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
    START WITH 36
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
3	@matrix_a:localhost	TKAVEOGKHH	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjZjaWQgdXNlcl9pZCA9IEBtYXRyaXhfYTpsb2NhbGhvc3QKMDAxNmNpZCB0eXBlID0gYWNjZXNzCjAwMjFjaWQgbm9uY2UgPSAwb3Y6eTZVdHojUk4jbFprCjAwMmZzaWduYXR1cmUgNNZKnOVRzj5svh9pEM0UUEqtXYnHjnj9XyNLJ1_uKoAK	\N	\N	\N	\N	\N
5	@ignored_user:localhost	IYEBBQEXHS	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMmFjaWQgdXNlcl9pZCA9IEBpZ25vcmVkX3VzZXI6bG9jYWxob3N0CjAwMTZjaWQgdHlwZSA9IGFjY2VzcwowMDIxY2lkIG5vbmNlID0gZU5ta1BBMj1FNnVPRGtwdgowMDJmc2lnbmF0dXJlIHSt8jrFU836Ne3it2HY88EhPD1Aoustsm211bbFjcLcCg	\N	\N	\N	\N	\N
6	@matterbot:localhost	WXUVNZGJEW	syt_bWF0dGVyYm90_BUJIdrtjNxhLblEFpObD_3qIP47	\N	\N	1673965922933	\N	f
7	@mm_mattermost_a:localhost	COGVPCWEKD	syt_bW1fbWF0dGVybW9zdF9h_gaIxUCblqvFelFijVAIT_1a3T85	\N	\N	1673966481703	\N	f
8	@mm_mattermost_b:localhost	HCOJCHMPGT	syt_bW1fbWF0dGVybW9zdF9i_CURPOkuhIgDkhoapqQwj_1OnttI	\N	\N	1673966482045	\N	f
2	@admin:localhost	WCSUBIGVWG	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjNjaWQgdXNlcl9pZCA9IEBhZG1pbjpsb2NhbGhvc3QKMDAxNmNpZCB0eXBlID0gYWNjZXNzCjAwMjFjaWQgbm9uY2UgPSBXVU9yUTVRMFRnUkNjME1ACjAwMmZzaWduYXR1cmUgdYKA-yuTQ5JV5O0HWRak-48xavOYgA1MMc6A1V_Uw5kK	\N	\N	\N	\N	t
10	@mm_user1.mm:localhost	YBRKEXDYRC	syt_bW1fdXNlcjEubW0_zXwkbKbEMttsBDYaghlM_4EX3a1	\N	\N	1673969011643	\N	f
4	@matrix_b:localhost	DJFHSWMXLW	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjZjaWQgdXNlcl9pZCA9IEBtYXRyaXhfYjpsb2NhbGhvc3QKMDAxNmNpZCB0eXBlID0gYWNjZXNzCjAwMjFjaWQgbm9uY2UgPSBBYl9hbWthI0daSzgtfjdICjAwMmZzaWduYXR1cmUgOReBLkPURCMNtzORS9fpogQqVa3IWN9ZEu5gXW91QTMK	\N	\N	\N	\N	t
12	@user1.matrix:localhost	WMNHMANJWT	syt_dXNlcjEubWF0cml4_FpgmWTtaBUkHEYnAakMh_1z2rBX	\N	\N	1674028741571	\N	t
14	@user1.matrix:localhost	MOYNZNSLTL	syt_dXNlcjEubWF0cml4_qqcPIFFfNKFPtSyPUCKf_2ujTev	\N	\N	1674111093367	\N	t
15	@user1.matrix:localhost	GHIOXGFALI	syt_dXNlcjEubWF0cml4_WuMhLkzYQyELybWBPaHy_1xnzph	\N	\N	1674210821686	\N	t
\.


--
-- Data for Name: account_data; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.account_data (user_id, account_data_type, stream_id, content, instance_name) FROM stdin;
@user1.matrix:localhost	org.matrix.msc3890.local_notification_settings.OXBKVBOLVC	2	{"is_silenced":false}	\N
@user1.matrix:localhost	im.vector.analytics	4	{"pseudonymousAnalyticsOptIn":false}	\N
@user1.matrix:localhost	org.matrix.msc3890.local_notification_settings.QDBOSXPKXK	14	{"is_silenced":false}	\N
@user1.matrix:localhost	org.matrix.msc3890.local_notification_settings.WMNHMANJWT	19	{"is_silenced":false}	\N
@user1.matrix:localhost	org.matrix.msc3890.local_notification_settings.QHRMHKJLQA	27	{"is_silenced":false}	\N
@user1.matrix:localhost	org.matrix.msc3890.local_notification_settings.VLVGWECQKM	29	{"is_silenced":false}	\N
@user1.matrix:localhost	org.matrix.msc3890.local_notification_settings.MOYNZNSLTL	33	{"is_silenced":false}	\N
@user1.matrix:localhost	org.matrix.msc3890.local_notification_settings.GHIOXGFALI	50	{"is_silenced":false}	\N
@user1.matrix:localhost	im.vector.web.settings	54	{"SpotlightSearch.recentSearches":["!dKcbdDATuwwphjRPQP:localhost","!kmbTYjjsDRDHGgVqUP:localhost"],"MessageComposerInput.insertTrailingColon":true}	\N
@user1.matrix:localhost	im.vector.setting.breadcrumbs	65	{"recent_rooms":["!kmbTYjjsDRDHGgVqUP:localhost","!dKcbdDATuwwphjRPQP:localhost","!hccoYOyrWRMEhMnaoh:localhost","!cUrTzQWGYNmZYMHoGB:localhost","!BfSgfecvJnYoZjTYRA:localhost","!pWsdJYvpdmDULVhQtX:localhost"]}	\N
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
65	65/05_remove_room_stats_historical_and_user_stats_historical.sql
65	65/07_arbitrary_relations.sql
65	65/08_device_inbox_background_updates.sql
65	65/10_expirable_refresh_tokens.sql
65	65/11_devices_auth_provider_session.sql
67	67/01drop_public_room_list_stream.sql
68	68/01event_columns.sql
68	68/02_msc2409_add_device_id_appservice_stream_type.sql
68	68/03_delete_account_data_for_deactivated_accounts.sql
68	68/04_refresh_tokens_index_next_token_id.sql
68	68/04partial_state_rooms.sql
68	68/05partial_state_rooms_triggers.py
68	68/06_msc3202_add_device_list_appservice_stream_type.sql
69	69/01as_txn_seq.py
69	69/01device_list_oubound_by_room.sql
69	69/02cache_invalidation_index.sql
70	70/01clean_table_purged_rooms.sql
70	70/08_state_group_edges_unique.sql
71	71/01rebuild_event_edges.sql.postgres
71	71/01remove_noop_background_updates.sql
71	71/02event_push_summary_unique.sql
72	72/01add_room_type_to_state_stats.sql
72	72/01event_push_summary_receipt.sql
72	72/02event_push_actions_index.sql
72	72/03bg_populate_events_columns.py
72	72/03drop_event_reference_hashes.sql
72	72/03remove_groups.sql
72	72/04drop_column_application_services_state_last_txn.sql.postgres
72	72/05receipts_event_stream_ordering.sql
72	72/05remove_unstable_private_read_receipts.sql
72	72/06add_consent_ts_to_users.sql
72	72/06thread_notifications.sql
72	72/07force_update_current_state_events_membership.py
72	72/07thread_receipts.sql.postgres
72	72/08begin_cache_invalidation_seq_at_2.sql.postgres
72	72/08thread_receipts.sql
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
X	119
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
27	master	user_last_seen_monthly_active	\N	1673965815848
28	master	get_monthly_active_count	{}	1673965815884
29	master	get_user_by_id	{@matterbot:localhost}	1673965922907
30	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@matterbot:localhost}	1673965923661
31	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@matterbot:localhost}	1673965923662
32	master	get_user_by_id	{@mm_mattermost_a:localhost}	1673966481654
33	master	get_user_by_id	{@mm_mattermost_b:localhost}	1673966482018
34	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_a:localhost}	1673966482219
35	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_a:localhost}	1673966482379
36	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_b:localhost}	1673966482407
37	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_a:localhost}	1673966482603
38	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_b:localhost}	1673966482633
39	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_a:localhost}	1673966482837
40	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_mattermost_b:localhost}	1673966482887
41	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_mattermost_b:localhost}	1673966483183
42	master	get_user_by_id	{@user1.matrix:localhost}	1673967243499
43	master	count_e2e_one_time_keys	{@user1.matrix:localhost,OXBKVBOLVC}	1673968366419
44	master	get_e2e_unused_fallback_key_types	{@user1.matrix:localhost,OXBKVBOLVC}	1673968366441
45	master	count_e2e_one_time_keys	{@user1.matrix:localhost,OXBKVBOLVC}	1673968366536
46	master	get_e2e_unused_fallback_key_types	{@user1.matrix:localhost,OXBKVBOLVC}	1673968366544
47	master	count_e2e_one_time_keys	{@user1.matrix:localhost,OXBKVBOLVC}	1673968366604
48	master	count_e2e_one_time_keys	{@user1.matrix:localhost,OXBKVBOLVC}	1673968366668
49	master	count_e2e_one_time_keys	{@user1.matrix:localhost,OXBKVBOLVC}	1673968366734
50	master	count_e2e_one_time_keys	{@user1.matrix:localhost,OXBKVBOLVC}	1673968366832
51	master	count_e2e_one_time_keys	{@user1.matrix:localhost,OXBKVBOLVC}	1673968367022
52	master	_get_bare_e2e_cross_signing_keys	{@user1.matrix:localhost}	1673968367051
53	master	_get_bare_e2e_cross_signing_keys	{@user1.matrix:localhost}	1673968367068
54	master	_get_bare_e2e_cross_signing_keys	{@user1.matrix:localhost}	1673968367079
55	master	count_e2e_one_time_keys	{@user1.matrix:localhost,OXBKVBOLVC}	1673968367115
56	master	count_e2e_one_time_keys	{@user1.matrix:localhost,OXBKVBOLVC}	1673968367237
57	master	count_e2e_one_time_keys	{@user1.matrix:localhost,OXBKVBOLVC}	1673968367331
58	master	_get_bare_e2e_cross_signing_keys	{@user1.matrix:localhost}	1673968370073
59	master	_get_bare_e2e_cross_signing_keys	{@user1.matrix:localhost}	1673968370078
60	master	_get_bare_e2e_cross_signing_keys	{@user1.matrix:localhost}	1673968370082
61	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@user1.matrix:localhost}	1673968543359
62	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@user1.matrix:localhost}	1673968600509
63	master	get_user_by_id	{@mm_user1.mm:localhost}	1673969011625
64	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_user1.mm:localhost}	1673969011838
65	master	cs_cache_fake	{!dKcbdDATuwwphjRPQP:localhost,@mm_user1.mm:localhost}	1673969012219
66	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_user1.mm:localhost}	1673969012377
67	master	cs_cache_fake	{!kmbTYjjsDRDHGgVqUP:localhost,@mm_user1.mm:localhost}	1673969012596
68	master	user_last_seen_monthly_active	\N	1673969415530
69	master	get_monthly_active_count	{}	1673969415532
70	master	count_e2e_one_time_keys	{@user1.matrix:localhost,QDBOSXPKXK}	1673972952745
71	master	get_e2e_unused_fallback_key_types	{@user1.matrix:localhost,QDBOSXPKXK}	1673972952760
72	master	count_e2e_one_time_keys	{@user1.matrix:localhost,QDBOSXPKXK}	1673972953427
73	master	count_e2e_one_time_keys	{@user1.matrix:localhost,QDBOSXPKXK}	1673972955763
74	master	count_e2e_one_time_keys	{@user1.matrix:localhost,QDBOSXPKXK}	1673972956137
75	master	count_e2e_one_time_keys	{@user1.matrix:localhost,QDBOSXPKXK}	1673972956377
76	master	count_e2e_one_time_keys	{@user1.matrix:localhost,QDBOSXPKXK}	1673972959251
77	master	count_e2e_one_time_keys	{@user1.matrix:localhost,QDBOSXPKXK}	1673972959728
78	master	count_e2e_one_time_keys	{@user1.matrix:localhost,QDBOSXPKXK}	1673972965786
79	master	count_e2e_one_time_keys	{@user1.matrix:localhost,QDBOSXPKXK}	1673972966302
80	master	get_user_by_access_token	{syt_dXNlcjEubWF0cml4_GrDyxoNglBiIvpSZUakQ_2VzLnb}	1673972966326
81	master	count_e2e_one_time_keys	{@user1.matrix:localhost,QDBOSXPKXK}	1673972966363
82	master	get_e2e_unused_fallback_key_types	{@user1.matrix:localhost,QDBOSXPKXK}	1673972966399
83	master	user_last_seen_monthly_active	\N	1673973015533
84	master	get_monthly_active_count	{}	1673973015536
85	master	user_last_seen_monthly_active	\N	1673977581681
86	master	get_monthly_active_count	{}	1673977581693
87	master	user_last_seen_monthly_active	\N	1673980826374
88	master	get_monthly_active_count	{}	1673980826384
89	master	user_last_seen_monthly_active	\N	1673983815533
90	master	get_monthly_active_count	{}	1673983815534
91	master	user_last_seen_monthly_active	\N	1673988387127
92	master	get_monthly_active_count	{}	1673988387160
93	master	user_last_seen_monthly_active	\N	1673991631768
94	master	get_monthly_active_count	{}	1673991631772
95	master	user_last_seen_monthly_active	\N	1673995003557
96	master	get_monthly_active_count	{}	1673995003559
97	master	user_last_seen_monthly_active	\N	1673998320507
98	master	get_monthly_active_count	{}	1673998320571
99	master	user_last_seen_monthly_active	\N	1674004803732
100	master	get_monthly_active_count	{}	1674004803738
101	master	user_last_seen_monthly_active	\N	1674008101721
102	master	get_monthly_active_count	{}	1674008101741
103	master	user_last_seen_monthly_active	\N	1674011342500
104	master	get_monthly_active_count	{}	1674011342512
105	master	user_last_seen_monthly_active	\N	1674014584035
106	master	get_monthly_active_count	{}	1674014584164
107	master	user_last_seen_monthly_active	\N	1674016455380
108	master	get_monthly_active_count	{}	1674016455422
109	master	user_last_seen_monthly_active	\N	1674022941120
110	master	get_monthly_active_count	{}	1674022941146
111	master	user_last_seen_monthly_active	\N	1674026183559
112	master	get_monthly_active_count	{}	1674026183585
113	master	user_last_seen_monthly_active	\N	1674028527983
114	master	get_monthly_active_count	{}	1674028528040
115	master	get_user_by_access_token	{syt_dXNlcjEubWF0cml4_VqtNUUcGLOCpwzTNKNfq_1iVBTx}	1674028693754
116	master	count_e2e_one_time_keys	{@user1.matrix:localhost,OXBKVBOLVC}	1674028693776
117	master	get_e2e_unused_fallback_key_types	{@user1.matrix:localhost,OXBKVBOLVC}	1674028693783
118	master	count_e2e_one_time_keys	{@user1.matrix:localhost,WMNHMANJWT}	1674028742744
119	master	get_e2e_unused_fallback_key_types	{@user1.matrix:localhost,WMNHMANJWT}	1674028742933
120	master	count_e2e_one_time_keys	{@user1.matrix:localhost,WMNHMANJWT}	1674028743047
121	master	get_e2e_unused_fallback_key_types	{@user1.matrix:localhost,WMNHMANJWT}	1674028743065
122	master	count_e2e_one_time_keys	{@user1.matrix:localhost,WMNHMANJWT}	1674028743160
123	master	count_e2e_one_time_keys	{@user1.matrix:localhost,WMNHMANJWT}	1674028743326
124	master	count_e2e_one_time_keys	{@user1.matrix:localhost,WMNHMANJWT}	1674028743440
125	master	count_e2e_one_time_keys	{@user1.matrix:localhost,WMNHMANJWT}	1674028743537
126	master	count_e2e_one_time_keys	{@user1.matrix:localhost,WMNHMANJWT}	1674028743630
127	master	count_e2e_one_time_keys	{@user1.matrix:localhost,WMNHMANJWT}	1674028743712
128	master	count_e2e_one_time_keys	{@user1.matrix:localhost,WMNHMANJWT}	1674028743803
129	master	count_e2e_one_time_keys	{@user1.matrix:localhost,WMNHMANJWT}	1674028743892
130	master	count_e2e_one_time_keys	{@user1.matrix:localhost,QHRMHKJLQA}	1674029089588
131	master	get_e2e_unused_fallback_key_types	{@user1.matrix:localhost,QHRMHKJLQA}	1674029089627
132	master	count_e2e_one_time_keys	{@user1.matrix:localhost,QHRMHKJLQA}	1674029089732
134	master	count_e2e_one_time_keys	{@user1.matrix:localhost,QHRMHKJLQA}	1674029089863
133	master	get_e2e_unused_fallback_key_types	{@user1.matrix:localhost,QHRMHKJLQA}	1674029089762
135	master	count_e2e_one_time_keys	{@user1.matrix:localhost,QHRMHKJLQA}	1674029089943
136	master	count_e2e_one_time_keys	{@user1.matrix:localhost,QHRMHKJLQA}	1674029090080
137	master	count_e2e_one_time_keys	{@user1.matrix:localhost,QHRMHKJLQA}	1674029090179
138	master	count_e2e_one_time_keys	{@user1.matrix:localhost,QHRMHKJLQA}	1674029090301
139	master	count_e2e_one_time_keys	{@user1.matrix:localhost,QHRMHKJLQA}	1674029090800
140	master	count_e2e_one_time_keys	{@user1.matrix:localhost,QHRMHKJLQA}	1674029090887
141	master	count_e2e_one_time_keys	{@user1.matrix:localhost,QHRMHKJLQA}	1674029091166
142	master	user_last_seen_monthly_active	\N	1674029287966
143	master	get_monthly_active_count	{}	1674029287972
144	master	get_user_by_access_token	{syt_dXNlcjEubWF0cml4_qDHrxVilscoXsedRWqoZ_2sHRVt}	1674029326934
145	master	count_e2e_one_time_keys	{@user1.matrix:localhost,QHRMHKJLQA}	1674029326972
146	master	get_e2e_unused_fallback_key_types	{@user1.matrix:localhost,QHRMHKJLQA}	1674029326995
147	master	user_last_seen_monthly_active	\N	1674029599272
148	master	get_monthly_active_count	{}	1674029599279
149	master	user_last_seen_monthly_active	\N	1674033199072
150	master	get_monthly_active_count	{}	1674033199075
151	master	user_last_seen_monthly_active	\N	1674036799069
152	master	get_monthly_active_count	{}	1674036799072
153	master	user_last_seen_monthly_active	\N	1674040399072
154	master	get_monthly_active_count	{}	1674040399073
155	master	user_last_seen_monthly_active	\N	1674044376762
156	master	get_monthly_active_count	{}	1674044376926
157	master	user_last_seen_monthly_active	\N	1674047599069
158	master	get_monthly_active_count	{}	1674047599071
159	master	user_last_seen_monthly_active	\N	1674051199079
160	master	get_monthly_active_count	{}	1674051199080
161	master	user_last_seen_monthly_active	\N	1674054799071
162	master	get_monthly_active_count	{}	1674054799073
163	master	user_last_seen_monthly_active	\N	1674058399070
164	master	get_monthly_active_count	{}	1674058399072
165	master	user_last_seen_monthly_active	\N	1674060007063
166	master	get_monthly_active_count	{}	1674060007075
167	master	count_e2e_one_time_keys	{@user1.matrix:localhost,VLVGWECQKM}	1674060060258
168	master	get_e2e_unused_fallback_key_types	{@user1.matrix:localhost,VLVGWECQKM}	1674060060287
169	master	count_e2e_one_time_keys	{@user1.matrix:localhost,VLVGWECQKM}	1674060060503
170	master	get_e2e_unused_fallback_key_types	{@user1.matrix:localhost,VLVGWECQKM}	1674060060589
171	master	count_e2e_one_time_keys	{@user1.matrix:localhost,VLVGWECQKM}	1674060062021
172	master	count_e2e_one_time_keys	{@user1.matrix:localhost,VLVGWECQKM}	1674060062355
173	master	count_e2e_one_time_keys	{@user1.matrix:localhost,VLVGWECQKM}	1674060064215
174	master	count_e2e_one_time_keys	{@user1.matrix:localhost,VLVGWECQKM}	1674060068704
175	master	count_e2e_one_time_keys	{@user1.matrix:localhost,VLVGWECQKM}	1674060070490
176	master	count_e2e_one_time_keys	{@user1.matrix:localhost,VLVGWECQKM}	1674060071014
177	master	get_user_by_access_token	{syt_dXNlcjEubWF0cml4_lxQEDeFsbPycHuLjqHFR_3s5Ihw}	1674060071116
178	master	count_e2e_one_time_keys	{@user1.matrix:localhost,VLVGWECQKM}	1674060071183
179	master	get_e2e_unused_fallback_key_types	{@user1.matrix:localhost,VLVGWECQKM}	1674060071191
180	master	user_last_seen_monthly_active	\N	1674066644484
181	master	get_monthly_active_count	{}	1674066644499
182	master	user_last_seen_monthly_active	\N	1674069885481
183	master	get_monthly_active_count	{}	1674069885783
184	master	user_last_seen_monthly_active	\N	1674072842718
185	master	get_monthly_active_count	{}	1674072842730
186	master	user_last_seen_monthly_active	\N	1674076086442
187	master	get_monthly_active_count	{}	1674076086455
188	master	user_last_seen_monthly_active	\N	1674079331123
189	master	get_monthly_active_count	{}	1674079331129
190	master	user_last_seen_monthly_active	\N	1674082571518
191	master	get_monthly_active_count	{}	1674082571522
192	master	user_last_seen_monthly_active	\N	1674085812420
193	master	get_monthly_active_count	{}	1674085812425
194	master	user_last_seen_monthly_active	\N	1674089054473
195	master	get_monthly_active_count	{}	1674089054477
196	master	user_last_seen_monthly_active	\N	1674095537269
197	master	get_monthly_active_count	{}	1674095537276
198	master	user_last_seen_monthly_active	\N	1674098777801
199	master	get_monthly_active_count	{}	1674098777809
200	master	user_last_seen_monthly_active	\N	1674102018766
201	master	get_monthly_active_count	{}	1674102018774
202	master	user_last_seen_monthly_active	\N	1674105259910
203	master	get_monthly_active_count	{}	1674105260051
204	master	user_last_seen_monthly_active	\N	1674108501408
205	master	get_monthly_active_count	{}	1674108501421
206	master	user_last_seen_monthly_active	\N	1674110952433
207	master	get_monthly_active_count	{}	1674110952526
208	master	count_e2e_one_time_keys	{@user1.matrix:localhost,MOYNZNSLTL}	1674111094288
209	master	get_e2e_unused_fallback_key_types	{@user1.matrix:localhost,MOYNZNSLTL}	1674111094303
210	master	count_e2e_one_time_keys	{@user1.matrix:localhost,MOYNZNSLTL}	1674111094378
211	master	count_e2e_one_time_keys	{@user1.matrix:localhost,MOYNZNSLTL}	1674111094432
212	master	count_e2e_one_time_keys	{@user1.matrix:localhost,MOYNZNSLTL}	1674111094481
213	master	count_e2e_one_time_keys	{@user1.matrix:localhost,MOYNZNSLTL}	1674111094536
214	master	count_e2e_one_time_keys	{@user1.matrix:localhost,MOYNZNSLTL}	1674111094610
215	master	count_e2e_one_time_keys	{@user1.matrix:localhost,MOYNZNSLTL}	1674111094666
216	master	count_e2e_one_time_keys	{@user1.matrix:localhost,MOYNZNSLTL}	1674111094717
220	master	cs_cache_fake	{!BfSgfecvJnYoZjTYRA:localhost}	1674111194931
223	master	cs_cache_fake	{!BfSgfecvJnYoZjTYRA:localhost}	1674111195567
231	master	cs_cache_fake	{!pWsdJYvpdmDULVhQtX:localhost}	1674111389819
236	master	cs_cache_fake	{!pWsdJYvpdmDULVhQtX:localhost}	1674111391056
217	master	count_e2e_one_time_keys	{@user1.matrix:localhost,MOYNZNSLTL}	1674111094775
227	master	cs_cache_fake	{!BfSgfecvJnYoZjTYRA:localhost,@mm_mattermost_a:localhost}	1674111228256
238	master	cs_cache_fake	{!pWsdJYvpdmDULVhQtX:localhost}	1674111530649
239	master	cs_cache_fake	{!pWsdJYvpdmDULVhQtX:localhost}	1674111570243
218	master	count_e2e_one_time_keys	{@user1.matrix:localhost,MOYNZNSLTL}	1674111094850
237	master	cs_cache_fake	{!pWsdJYvpdmDULVhQtX:localhost,@mm_mattermost_a:localhost}	1674111412769
219	master	get_aliases_for_room	{!BfSgfecvJnYoZjTYRA:localhost}	1674111194813
228	master	get_aliases_for_room	{!pWsdJYvpdmDULVhQtX:localhost}	1674111389354
243	master	user_last_seen_monthly_active	\N	1674117666212
244	master	get_monthly_active_count	{}	1674117666261
245	master	user_last_seen_monthly_active	\N	1674122819993
246	master	get_monthly_active_count	{}	1674122820587
249	master	user_last_seen_monthly_active	\N	1674136773911
250	master	get_monthly_active_count	{}	1674136773941
221	master	cs_cache_fake	{!BfSgfecvJnYoZjTYRA:localhost,@user1.matrix:localhost}	1674111195127
232	master	cs_cache_fake	{!pWsdJYvpdmDULVhQtX:localhost}	1674111390316
233	master	cs_cache_fake	{!pWsdJYvpdmDULVhQtX:localhost}	1674111390586
234	master	cs_cache_fake	{!pWsdJYvpdmDULVhQtX:localhost}	1674111390765
222	master	cs_cache_fake	{!BfSgfecvJnYoZjTYRA:localhost}	1674111195400
247	master	user_last_seen_monthly_active	\N	1674129541509
248	master	get_monthly_active_count	{}	1674129541510
224	master	cs_cache_fake	{!BfSgfecvJnYoZjTYRA:localhost}	1674111195743
225	master	cs_cache_fake	{!BfSgfecvJnYoZjTYRA:localhost}	1674111195896
229	master	cs_cache_fake	{!pWsdJYvpdmDULVhQtX:localhost}	1674111389419
240	master	cs_cache_fake	{!BfSgfecvJnYoZjTYRA:localhost,@matrix_b:localhost}	1674111677044
226	master	cs_cache_fake	{!BfSgfecvJnYoZjTYRA:localhost}	1674111196052
230	master	cs_cache_fake	{!pWsdJYvpdmDULVhQtX:localhost,@user1.matrix:localhost}	1674111389551
235	master	cs_cache_fake	{!pWsdJYvpdmDULVhQtX:localhost}	1674111390900
241	master	user_last_seen_monthly_active	\N	1674115848775
242	master	get_monthly_active_count	{}	1674115848862
251	master	user_last_seen_monthly_active	\N	1674144006321
252	master	get_monthly_active_count	{}	1674144006336
253	master	user_last_seen_monthly_active	\N	1674151234992
254	master	get_monthly_active_count	{}	1674151235046
255	master	user_last_seen_monthly_active	\N	1674158464468
256	master	get_monthly_active_count	{}	1674158464507
257	master	user_last_seen_monthly_active	\N	1674165669187
258	master	get_monthly_active_count	{}	1674165669227
259	master	user_last_seen_monthly_active	\N	1674172900926
260	master	get_monthly_active_count	{}	1674172900928
261	master	user_last_seen_monthly_active	\N	1674180103675
262	master	get_monthly_active_count	{}	1674180103684
263	master	user_last_seen_monthly_active	\N	1674187308256
264	master	get_monthly_active_count	{}	1674187308384
265	master	user_last_seen_monthly_active	\N	1674194514776
266	master	get_monthly_active_count	{}	1674194514787
267	master	user_last_seen_monthly_active	\N	1674201742709
268	master	get_monthly_active_count	{}	1674201742710
269	master	user_last_seen_monthly_active	\N	1674210447761
270	master	get_monthly_active_count	{}	1674210447768
271	master	user_last_seen_monthly_active	\N	1674210622666
272	master	get_monthly_active_count	{}	1674210622674
273	master	count_e2e_one_time_keys	{@user1.matrix:localhost,GHIOXGFALI}	1674210823230
274	master	get_e2e_unused_fallback_key_types	{@user1.matrix:localhost,GHIOXGFALI}	1674210823264
275	master	count_e2e_one_time_keys	{@user1.matrix:localhost,GHIOXGFALI}	1674210823342
276	master	get_e2e_unused_fallback_key_types	{@user1.matrix:localhost,GHIOXGFALI}	1674210823358
277	master	count_e2e_one_time_keys	{@user1.matrix:localhost,GHIOXGFALI}	1674210823422
278	master	count_e2e_one_time_keys	{@user1.matrix:localhost,GHIOXGFALI}	1674210823481
279	master	count_e2e_one_time_keys	{@user1.matrix:localhost,GHIOXGFALI}	1674210823537
280	master	count_e2e_one_time_keys	{@user1.matrix:localhost,GHIOXGFALI}	1674210823589
281	master	count_e2e_one_time_keys	{@user1.matrix:localhost,GHIOXGFALI}	1674210823647
282	master	count_e2e_one_time_keys	{@user1.matrix:localhost,GHIOXGFALI}	1674210823704
283	master	count_e2e_one_time_keys	{@user1.matrix:localhost,GHIOXGFALI}	1674210823788
285	master	get_aliases_for_room	{!cUrTzQWGYNmZYMHoGB:localhost}	1674211301071
286	master	cs_cache_fake	{!cUrTzQWGYNmZYMHoGB:localhost}	1674211301186
287	master	cs_cache_fake	{!cUrTzQWGYNmZYMHoGB:localhost,@user1.matrix:localhost}	1674211301472
292	master	cs_cache_fake	{!hccoYOyrWRMEhMnaoh:localhost}	1674211359489
294	master	cs_cache_fake	{!FSwSlJXpOZZONTVfGs:localhost,@user1.matrix:localhost}	1674211359707
295	master	cs_cache_fake	{!hccoYOyrWRMEhMnaoh:localhost,@user1.matrix:localhost}	1674211359773
297	master	cs_cache_fake	{!JGJhGNDoMdRLJzLgcJ:localhost}	1674211360421
304	master	cs_cache_fake	{!cUrTzQWGYNmZYMHoGB:localhost}	1674211361662
284	master	count_e2e_one_time_keys	{@user1.matrix:localhost,GHIOXGFALI}	1674210823873
288	master	cs_cache_fake	{!cUrTzQWGYNmZYMHoGB:localhost}	1674211302071
290	master	cs_cache_fake	{!cUrTzQWGYNmZYMHoGB:localhost}	1674211302456
301	master	cs_cache_fake	{!hccoYOyrWRMEhMnaoh:localhost}	1674211360912
289	master	cs_cache_fake	{!cUrTzQWGYNmZYMHoGB:localhost}	1674211302284
291	master	cs_cache_fake	{!FSwSlJXpOZZONTVfGs:localhost}	1674211359452
293	master	cs_cache_fake	{!JGJhGNDoMdRLJzLgcJ:localhost}	1674211359518
296	master	cs_cache_fake	{!JGJhGNDoMdRLJzLgcJ:localhost,@user1.matrix:localhost}	1674211359796
298	master	cs_cache_fake	{!FSwSlJXpOZZONTVfGs:localhost}	1674211360507
299	master	cs_cache_fake	{!hccoYOyrWRMEhMnaoh:localhost}	1674211360524
300	master	cs_cache_fake	{!JGJhGNDoMdRLJzLgcJ:localhost}	1674211360849
302	master	cs_cache_fake	{!FSwSlJXpOZZONTVfGs:localhost}	1674211360991
303	master	cs_cache_fake	{!cUrTzQWGYNmZYMHoGB:localhost}	1674211361463
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
21	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$jyfZsVYOTCt8az1WqRlL53b1lAQWjIj6-IvW1w3qYks	\N	master
20	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$PkPxRt8GuXFqdWre9vyhqKHlRSqflC0cOSTBOims4qY	\N	master
22	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$ARxMI5-TIkg2afPIDJsLgeSqCdrfbwBxm32e83QRfQ4	\N	master
23	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$nE3KmrZJdWnhQ2h6DgIB98qoLGnQlFFCvgSu4NS5FfA	\N	master
24	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$mlRlSJ1S_x5OctD_Nck7tq-Fo2IC7iOhysac1uYo_PY	\N	master
26	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$pXbc3VIu5b4O4VzPRePQd4FjtqYPJLH87Ss7pZM-gRM	$ARxMI5-TIkg2afPIDJsLgeSqCdrfbwBxm32e83QRfQ4	master
25	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Y86Vdmx2z1nvkEoTqBH7oAiLE_sHPFtNgI97gsUAwaY	\N	master
28	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$YHxtZv4JfPzIJvBMvoTgzeITfTFFng_L_4ijJ1Q97k4	$nE3KmrZJdWnhQ2h6DgIB98qoLGnQlFFCvgSu4NS5FfA	master
27	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$q7m8fkdDrp2QE9hRAHYIR_KN8htxYXW85pB3LgG-V2U	$mlRlSJ1S_x5OctD_Nck7tq-Fo2IC7iOhysac1uYo_PY	master
29	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$cH796vSd1hy4UBg8XHAqeUxz-u3gxer-uMeGrsirKbs	$Y86Vdmx2z1nvkEoTqBH7oAiLE_sHPFtNgI97gsUAwaY	master
30	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@user1.matrix:localhost	$5DYqRHQPE1SQt9QXHJodWH7x4Pztz3LTsgH1kdHawZs	\N	master
31	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@user1.matrix:localhost	$TKcINA6W5qTH8raDaFqEMBivZ0LjgXtIHGvxzJ9V4_8	\N	master
32	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1.mm:localhost	$REN0AaEE212pFbK8uJB-22lyjpnqTEP0SshUeVfsGU4	\N	master
33	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1.mm:localhost	$AwutniYNkYl6Dxs-8zYvdPdGLIcM4Kyzaldut5D0jHQ	$REN0AaEE212pFbK8uJB-22lyjpnqTEP0SshUeVfsGU4	master
34	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1.mm:localhost	$HmGCTcPZGDbaswAPjYZ0ddKt1eWRcRq89rE-yVwDV0s	\N	master
35	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1.mm:localhost	$VFMUBSkD_jWG8nImBQfkmffKyLBdxGMpdkFACHA33Ng	$HmGCTcPZGDbaswAPjYZ0ddKt1eWRcRq89rE-yVwDV0s	master
53	!BfSgfecvJnYoZjTYRA:localhost	m.room.create		$NfGFxRqIrSmaeLcN53BGirnWzJ1bpwzVyt2oZw2cj1k	\N	master
54	!BfSgfecvJnYoZjTYRA:localhost	m.room.member	@user1.matrix:localhost	$7N18oPwd46twVh-RWhED6VAPm79aIXVCh_BVUFAFHP8	\N	master
55	!BfSgfecvJnYoZjTYRA:localhost	m.room.power_levels		$eKvf8PFaZwsEOXW-IIYTGZwl6gxEYmEE2TalB5k2iGs	\N	master
56	!BfSgfecvJnYoZjTYRA:localhost	m.room.canonical_alias		$ZraIWv18CC1pTAGQZToI1ZXr7ki_53OY_jvQl0RDE_A	\N	master
57	!BfSgfecvJnYoZjTYRA:localhost	m.room.join_rules		$Uf6bLI9lxBnR9TJvz8fcfo-1_wbshzMvT4Ecr_qy-E4	\N	master
58	!BfSgfecvJnYoZjTYRA:localhost	m.room.history_visibility		$30q15kBxfYB9Dyc1sAhoNXYpZXfDlneq4Ckvuz_Sy1Y	\N	master
59	!BfSgfecvJnYoZjTYRA:localhost	m.room.name		$wlATKVSoZpEXfwFpmdptZK6V2TMFQ87Bjjhru1P3dGs	\N	master
60	!BfSgfecvJnYoZjTYRA:localhost	m.room.member	@mm_mattermost_a:localhost	$PZkmtd-Zj4an2Acc9O8V-mK2mVxXChviZhd_hsf6Ehg	\N	master
62	!pWsdJYvpdmDULVhQtX:localhost	m.room.create		$pIVIlPgvO-fbiW31dx4GB-wsRX4DrbADDn1AfJoXI50	\N	master
63	!pWsdJYvpdmDULVhQtX:localhost	m.room.member	@user1.matrix:localhost	$bWqW6N4T6ZlJ3MzEaI-MgqdvMEklGrNsy22WqL6ZgOc	\N	master
64	!pWsdJYvpdmDULVhQtX:localhost	m.room.power_levels		$ngKTLt0SDFtdjkF6GnjahEcDA-qLwTKRcVgMgMg5tN8	\N	master
65	!pWsdJYvpdmDULVhQtX:localhost	m.room.canonical_alias		$IxyNn3A4NegMug4xc7O0sm2s1r9jyybU5iNogwEGesQ	\N	master
66	!pWsdJYvpdmDULVhQtX:localhost	m.room.join_rules		$SQpUzgCCeFIrGC3eCPDX_U021w7MG0-lHOxFTcHbvKk	\N	master
67	!pWsdJYvpdmDULVhQtX:localhost	m.room.history_visibility		$pe2Yi2ila5QgzVKIEGGAIeqvcRaD37GUFMvAOWX2tp0	\N	master
68	!pWsdJYvpdmDULVhQtX:localhost	m.room.name		$_MdWHbg9mI3zN-WDGIpwDRJZmDWXBeW-m3WrJiRs4t8	\N	master
69	!pWsdJYvpdmDULVhQtX:localhost	m.room.topic		$7qFBn6lW7C0hRYBTRjR0tsE8qpZmodqh6LOyLL0HMnQ	\N	master
70	!pWsdJYvpdmDULVhQtX:localhost	m.room.member	@mm_mattermost_a:localhost	$d7sJ6Squy3gHlaCn4UxGeu_9AcN2XCBHtBIY8VL5d_g	\N	master
72	!pWsdJYvpdmDULVhQtX:localhost	m.room.topic		$8lVZQlOM-qXD0dT5ZSbvlEPAQPq5wJHU8KqM6sLfmWM	$7qFBn6lW7C0hRYBTRjR0tsE8qpZmodqh6LOyLL0HMnQ	master
73	!pWsdJYvpdmDULVhQtX:localhost	m.room.topic		$OsJU_fxidXD79b8VmXNcxdAdUkhXO3S73zUBYUa3yG8	$8lVZQlOM-qXD0dT5ZSbvlEPAQPq5wJHU8KqM6sLfmWM	master
75	!BfSgfecvJnYoZjTYRA:localhost	m.room.member	@matrix_b:localhost	$76OhaN_mof41kiqxA-qZV26DgKxkvkl8JwQjOYqZF1A	\N	master
81	!cUrTzQWGYNmZYMHoGB:localhost	m.room.create		$XhE1A2QtMIi_b9SfK9jbadCTQ4Xd5IZxBaUOcfglbIA	\N	master
82	!cUrTzQWGYNmZYMHoGB:localhost	m.room.member	@user1.matrix:localhost	$Ip3uw4uae3e7xwaJ6BU2ppE2nWhA0Zyb0KZDNvHAdmU	\N	master
83	!cUrTzQWGYNmZYMHoGB:localhost	m.room.canonical_alias		$wtg0qf-MdY5Ur4UMAlOlQ58df82OmKhsbTS81ItsAT8	\N	master
83	!cUrTzQWGYNmZYMHoGB:localhost	m.room.guest_access		$MJ2YTkP3f-eQwc5HLB6GVzjnPJaVov0pUCfq1bWqG3M	\N	master
83	!cUrTzQWGYNmZYMHoGB:localhost	m.room.history_visibility		$iAAlBelGypnsbVKn9Fd-ubLNje326TRpaegoLLyRZGY	\N	master
83	!cUrTzQWGYNmZYMHoGB:localhost	m.room.join_rules		$DFCNP6Tt2ypS8tXyd5kaCiqWeVDmE_FL-iOprkrfubk	\N	master
83	!cUrTzQWGYNmZYMHoGB:localhost	m.room.power_levels		$nofByIO1FFs8JcKVqFZb7ulSmWdVGm_V-3n-LceVmnw	\N	master
88	!cUrTzQWGYNmZYMHoGB:localhost	m.room.name		$34bSEXw9U2DTNkZA2he27rczptl3jni1oG64GRRYkfY	\N	master
89	!cUrTzQWGYNmZYMHoGB:localhost	m.room.topic		$SFXqj2UcfZU2XtnGBtupMwsoI3Z5JLp-7mmR2PU4MjQ	\N	master
90	!FSwSlJXpOZZONTVfGs:localhost	m.room.create		$VI4y-gfFPbzFuAM6S6F4gXfpeWta-thThcGlPN0xQN0	\N	master
91	!hccoYOyrWRMEhMnaoh:localhost	m.room.create		$LnGTvN89zWMaGdr_8T22TNwZ8hCnAeMlGOMaGpCPahE	\N	master
92	!JGJhGNDoMdRLJzLgcJ:localhost	m.room.create		$A45QtHYoTPEA17jEFQZ4U882WGuYFA2D4xiKqwnZyUs	\N	master
93	!FSwSlJXpOZZONTVfGs:localhost	m.room.member	@user1.matrix:localhost	$Z-W9-QEq_roRPUfFFGrVn3vc_d4uekRlcsL3uBSdDpM	\N	master
94	!hccoYOyrWRMEhMnaoh:localhost	m.room.member	@user1.matrix:localhost	$RRFtexNdS-wxfmZgcU9kk5Lyp462lIuVu6piimDKCGA	\N	master
95	!JGJhGNDoMdRLJzLgcJ:localhost	m.room.member	@user1.matrix:localhost	$uDBLcAyAHq3swiKjGlyKYFZwIrP5Ux8Ki1qU7x3aVsY	\N	master
96	!JGJhGNDoMdRLJzLgcJ:localhost	m.room.guest_access		$hNUZNFVPWjQzoWmc5wymfJzaTuaIdxyWFsi3fkTJ534	\N	master
96	!JGJhGNDoMdRLJzLgcJ:localhost	m.room.history_visibility		$JfR9TVM-sEe4hZ5-0bIni5e5m_tLlX2HdSU6u6IoVBM	\N	master
96	!JGJhGNDoMdRLJzLgcJ:localhost	m.room.join_rules		$e6pVgV1MsH-6_A1V_vGWGmdznPg_czNOfblinyTHshA	\N	master
96	!JGJhGNDoMdRLJzLgcJ:localhost	m.room.power_levels		$MLY05F5LyQaOuJw4avembMABTu_CtFuQyhyiF14QtYo	\N	master
96	!JGJhGNDoMdRLJzLgcJ:localhost	m.space.parent	!cUrTzQWGYNmZYMHoGB:localhost	$IYkBkm-ncU_4Z-Ft8v80LsrK5kKpzGKpHDUWZxxy6t8	\N	master
101	!FSwSlJXpOZZONTVfGs:localhost	m.room.guest_access		$Y_182-w64pn902ATtlukjIsNSzVBtF9fw_aMYWx9DdY	\N	master
101	!FSwSlJXpOZZONTVfGs:localhost	m.room.history_visibility		$33Pk__-gU3AslKMgHWQqdrgfvEhGtn4nPTRaDuhZUC0	\N	master
101	!FSwSlJXpOZZONTVfGs:localhost	m.room.join_rules		$CjB4vCnMjTm70a0EahGjB5FN8EKtrdWl7F12gA2FhDo	\N	master
101	!FSwSlJXpOZZONTVfGs:localhost	m.room.power_levels		$4ywygf1-17_Kq3j230bjqgAjdpc67zV0hIv7Uw6BKtA	\N	master
101	!FSwSlJXpOZZONTVfGs:localhost	m.space.parent	!cUrTzQWGYNmZYMHoGB:localhost	$27FTfsExd-igZozi1nKpy5Iyqayuxc3DZY9LFN9e6oo	\N	master
106	!hccoYOyrWRMEhMnaoh:localhost	m.room.guest_access		$5QgMOlhzvtIooZVNYnMnchsgiEUDObBacU41JO2zKs0	\N	master
106	!hccoYOyrWRMEhMnaoh:localhost	m.room.history_visibility		$-FXdMAkllHkSbPP-QDGsb_zIuCwPKR511zZahmMGKs4	\N	master
106	!hccoYOyrWRMEhMnaoh:localhost	m.room.join_rules		$4MpBsW-eFJ4SoVP-rLgkefjkNR0Sytuayop2Z-OBFzU	\N	master
106	!hccoYOyrWRMEhMnaoh:localhost	m.room.power_levels		$nMtE3MPK3rxeHXzgEF1GWQXqF1Of8IqoWwPKejXxdrg	\N	master
106	!hccoYOyrWRMEhMnaoh:localhost	m.space.parent	!cUrTzQWGYNmZYMHoGB:localhost	$NYaJba-K1Im8n6_Z7mL0VwgIAKxZqouzTTYu6EcK5eM	\N	master
111	!JGJhGNDoMdRLJzLgcJ:localhost	m.room.name		$UEYdHpguNtwCDIQ9fsK7537cGDuKB-9QPh7SJsYm6lQ	\N	master
112	!hccoYOyrWRMEhMnaoh:localhost	m.room.name		$sUchhgur-fFKVUmMUaBERmjM3ItMz4-8bhkuD7UXnuU	\N	master
113	!FSwSlJXpOZZONTVfGs:localhost	m.room.name		$bgbjmgXAlLz069pieqVTP8KTcxXHvT72ZwdRr71Fnqg	\N	master
114	!cUrTzQWGYNmZYMHoGB:localhost	m.space.child	!hccoYOyrWRMEhMnaoh:localhost	$___RsdFndwWsVVLqEZmb4-TWJG-e1GJLt_3bnf1dFu8	\N	master
115	!cUrTzQWGYNmZYMHoGB:localhost	m.space.child	!FSwSlJXpOZZONTVfGs:localhost	$OUsS0radBRPS3B8beUIJ1TUjFMPXJ0OTtSau2wSu6rY	\N	master
115	!cUrTzQWGYNmZYMHoGB:localhost	m.space.child	!JGJhGNDoMdRLJzLgcJ:localhost	$z3x2QWsqd2WeWbha161nzCLfGv7psz2SV_Gveo8B5Yk	\N	master
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
$jyfZsVYOTCt8az1WqRlL53b1lAQWjIj6-IvW1w3qYks	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	join
$PkPxRt8GuXFqdWre9vyhqKHlRSqflC0cOSTBOims4qY	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	join
$pXbc3VIu5b4O4VzPRePQd4FjtqYPJLH87Ss7pZM-gRM	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	join
$YHxtZv4JfPzIJvBMvoTgzeITfTFFng_L_4ijJ1Q97k4	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	join
$q7m8fkdDrp2QE9hRAHYIR_KN8htxYXW85pB3LgG-V2U	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	join
$cH796vSd1hy4UBg8XHAqeUxz-u3gxer-uMeGrsirKbs	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	join
$5DYqRHQPE1SQt9QXHJodWH7x4Pztz3LTsgH1kdHawZs	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@user1.matrix:localhost	join
$TKcINA6W5qTH8raDaFqEMBivZ0LjgXtIHGvxzJ9V4_8	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@user1.matrix:localhost	join
$AwutniYNkYl6Dxs-8zYvdPdGLIcM4Kyzaldut5D0jHQ	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1.mm:localhost	join
$VFMUBSkD_jWG8nImBQfkmffKyLBdxGMpdkFACHA33Ng	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1.mm:localhost	join
$NfGFxRqIrSmaeLcN53BGirnWzJ1bpwzVyt2oZw2cj1k	!BfSgfecvJnYoZjTYRA:localhost	m.room.create		\N
$7N18oPwd46twVh-RWhED6VAPm79aIXVCh_BVUFAFHP8	!BfSgfecvJnYoZjTYRA:localhost	m.room.member	@user1.matrix:localhost	join
$eKvf8PFaZwsEOXW-IIYTGZwl6gxEYmEE2TalB5k2iGs	!BfSgfecvJnYoZjTYRA:localhost	m.room.power_levels		\N
$ZraIWv18CC1pTAGQZToI1ZXr7ki_53OY_jvQl0RDE_A	!BfSgfecvJnYoZjTYRA:localhost	m.room.canonical_alias		\N
$Uf6bLI9lxBnR9TJvz8fcfo-1_wbshzMvT4Ecr_qy-E4	!BfSgfecvJnYoZjTYRA:localhost	m.room.join_rules		\N
$30q15kBxfYB9Dyc1sAhoNXYpZXfDlneq4Ckvuz_Sy1Y	!BfSgfecvJnYoZjTYRA:localhost	m.room.history_visibility		\N
$wlATKVSoZpEXfwFpmdptZK6V2TMFQ87Bjjhru1P3dGs	!BfSgfecvJnYoZjTYRA:localhost	m.room.name		\N
$PZkmtd-Zj4an2Acc9O8V-mK2mVxXChviZhd_hsf6Ehg	!BfSgfecvJnYoZjTYRA:localhost	m.room.member	@mm_mattermost_a:localhost	invite
$pIVIlPgvO-fbiW31dx4GB-wsRX4DrbADDn1AfJoXI50	!pWsdJYvpdmDULVhQtX:localhost	m.room.create		\N
$bWqW6N4T6ZlJ3MzEaI-MgqdvMEklGrNsy22WqL6ZgOc	!pWsdJYvpdmDULVhQtX:localhost	m.room.member	@user1.matrix:localhost	join
$ngKTLt0SDFtdjkF6GnjahEcDA-qLwTKRcVgMgMg5tN8	!pWsdJYvpdmDULVhQtX:localhost	m.room.power_levels		\N
$IxyNn3A4NegMug4xc7O0sm2s1r9jyybU5iNogwEGesQ	!pWsdJYvpdmDULVhQtX:localhost	m.room.canonical_alias		\N
$SQpUzgCCeFIrGC3eCPDX_U021w7MG0-lHOxFTcHbvKk	!pWsdJYvpdmDULVhQtX:localhost	m.room.join_rules		\N
$pe2Yi2ila5QgzVKIEGGAIeqvcRaD37GUFMvAOWX2tp0	!pWsdJYvpdmDULVhQtX:localhost	m.room.history_visibility		\N
$_MdWHbg9mI3zN-WDGIpwDRJZmDWXBeW-m3WrJiRs4t8	!pWsdJYvpdmDULVhQtX:localhost	m.room.name		\N
$d7sJ6Squy3gHlaCn4UxGeu_9AcN2XCBHtBIY8VL5d_g	!pWsdJYvpdmDULVhQtX:localhost	m.room.member	@mm_mattermost_a:localhost	invite
$OsJU_fxidXD79b8VmXNcxdAdUkhXO3S73zUBYUa3yG8	!pWsdJYvpdmDULVhQtX:localhost	m.room.topic		\N
$76OhaN_mof41kiqxA-qZV26DgKxkvkl8JwQjOYqZF1A	!BfSgfecvJnYoZjTYRA:localhost	m.room.member	@matrix_b:localhost	invite
$XhE1A2QtMIi_b9SfK9jbadCTQ4Xd5IZxBaUOcfglbIA	!cUrTzQWGYNmZYMHoGB:localhost	m.room.create		\N
$Ip3uw4uae3e7xwaJ6BU2ppE2nWhA0Zyb0KZDNvHAdmU	!cUrTzQWGYNmZYMHoGB:localhost	m.room.member	@user1.matrix:localhost	join
$wtg0qf-MdY5Ur4UMAlOlQ58df82OmKhsbTS81ItsAT8	!cUrTzQWGYNmZYMHoGB:localhost	m.room.canonical_alias		\N
$MJ2YTkP3f-eQwc5HLB6GVzjnPJaVov0pUCfq1bWqG3M	!cUrTzQWGYNmZYMHoGB:localhost	m.room.guest_access		\N
$iAAlBelGypnsbVKn9Fd-ubLNje326TRpaegoLLyRZGY	!cUrTzQWGYNmZYMHoGB:localhost	m.room.history_visibility		\N
$DFCNP6Tt2ypS8tXyd5kaCiqWeVDmE_FL-iOprkrfubk	!cUrTzQWGYNmZYMHoGB:localhost	m.room.join_rules		\N
$nofByIO1FFs8JcKVqFZb7ulSmWdVGm_V-3n-LceVmnw	!cUrTzQWGYNmZYMHoGB:localhost	m.room.power_levels		\N
$34bSEXw9U2DTNkZA2he27rczptl3jni1oG64GRRYkfY	!cUrTzQWGYNmZYMHoGB:localhost	m.room.name		\N
$SFXqj2UcfZU2XtnGBtupMwsoI3Z5JLp-7mmR2PU4MjQ	!cUrTzQWGYNmZYMHoGB:localhost	m.room.topic		\N
$VI4y-gfFPbzFuAM6S6F4gXfpeWta-thThcGlPN0xQN0	!FSwSlJXpOZZONTVfGs:localhost	m.room.create		\N
$LnGTvN89zWMaGdr_8T22TNwZ8hCnAeMlGOMaGpCPahE	!hccoYOyrWRMEhMnaoh:localhost	m.room.create		\N
$A45QtHYoTPEA17jEFQZ4U882WGuYFA2D4xiKqwnZyUs	!JGJhGNDoMdRLJzLgcJ:localhost	m.room.create		\N
$Z-W9-QEq_roRPUfFFGrVn3vc_d4uekRlcsL3uBSdDpM	!FSwSlJXpOZZONTVfGs:localhost	m.room.member	@user1.matrix:localhost	join
$RRFtexNdS-wxfmZgcU9kk5Lyp462lIuVu6piimDKCGA	!hccoYOyrWRMEhMnaoh:localhost	m.room.member	@user1.matrix:localhost	join
$uDBLcAyAHq3swiKjGlyKYFZwIrP5Ux8Ki1qU7x3aVsY	!JGJhGNDoMdRLJzLgcJ:localhost	m.room.member	@user1.matrix:localhost	join
$hNUZNFVPWjQzoWmc5wymfJzaTuaIdxyWFsi3fkTJ534	!JGJhGNDoMdRLJzLgcJ:localhost	m.room.guest_access		\N
$JfR9TVM-sEe4hZ5-0bIni5e5m_tLlX2HdSU6u6IoVBM	!JGJhGNDoMdRLJzLgcJ:localhost	m.room.history_visibility		\N
$e6pVgV1MsH-6_A1V_vGWGmdznPg_czNOfblinyTHshA	!JGJhGNDoMdRLJzLgcJ:localhost	m.room.join_rules		\N
$MLY05F5LyQaOuJw4avembMABTu_CtFuQyhyiF14QtYo	!JGJhGNDoMdRLJzLgcJ:localhost	m.room.power_levels		\N
$IYkBkm-ncU_4Z-Ft8v80LsrK5kKpzGKpHDUWZxxy6t8	!JGJhGNDoMdRLJzLgcJ:localhost	m.space.parent	!cUrTzQWGYNmZYMHoGB:localhost	\N
$Y_182-w64pn902ATtlukjIsNSzVBtF9fw_aMYWx9DdY	!FSwSlJXpOZZONTVfGs:localhost	m.room.guest_access		\N
$33Pk__-gU3AslKMgHWQqdrgfvEhGtn4nPTRaDuhZUC0	!FSwSlJXpOZZONTVfGs:localhost	m.room.history_visibility		\N
$CjB4vCnMjTm70a0EahGjB5FN8EKtrdWl7F12gA2FhDo	!FSwSlJXpOZZONTVfGs:localhost	m.room.join_rules		\N
$4ywygf1-17_Kq3j230bjqgAjdpc67zV0hIv7Uw6BKtA	!FSwSlJXpOZZONTVfGs:localhost	m.room.power_levels		\N
$27FTfsExd-igZozi1nKpy5Iyqayuxc3DZY9LFN9e6oo	!FSwSlJXpOZZONTVfGs:localhost	m.space.parent	!cUrTzQWGYNmZYMHoGB:localhost	\N
$5QgMOlhzvtIooZVNYnMnchsgiEUDObBacU41JO2zKs0	!hccoYOyrWRMEhMnaoh:localhost	m.room.guest_access		\N
$-FXdMAkllHkSbPP-QDGsb_zIuCwPKR511zZahmMGKs4	!hccoYOyrWRMEhMnaoh:localhost	m.room.history_visibility		\N
$4MpBsW-eFJ4SoVP-rLgkefjkNR0Sytuayop2Z-OBFzU	!hccoYOyrWRMEhMnaoh:localhost	m.room.join_rules		\N
$nMtE3MPK3rxeHXzgEF1GWQXqF1Of8IqoWwPKejXxdrg	!hccoYOyrWRMEhMnaoh:localhost	m.room.power_levels		\N
$NYaJba-K1Im8n6_Z7mL0VwgIAKxZqouzTTYu6EcK5eM	!hccoYOyrWRMEhMnaoh:localhost	m.space.parent	!cUrTzQWGYNmZYMHoGB:localhost	\N
$UEYdHpguNtwCDIQ9fsK7537cGDuKB-9QPh7SJsYm6lQ	!JGJhGNDoMdRLJzLgcJ:localhost	m.room.name		\N
$sUchhgur-fFKVUmMUaBERmjM3ItMz4-8bhkuD7UXnuU	!hccoYOyrWRMEhMnaoh:localhost	m.room.name		\N
$bgbjmgXAlLz069pieqVTP8KTcxXHvT72ZwdRr71Fnqg	!FSwSlJXpOZZONTVfGs:localhost	m.room.name		\N
$___RsdFndwWsVVLqEZmb4-TWJG-e1GJLt_3bnf1dFu8	!cUrTzQWGYNmZYMHoGB:localhost	m.space.child	!hccoYOyrWRMEhMnaoh:localhost	\N
$OUsS0radBRPS3B8beUIJ1TUjFMPXJ0OTtSau2wSu6rY	!cUrTzQWGYNmZYMHoGB:localhost	m.space.child	!FSwSlJXpOZZONTVfGs:localhost	\N
$z3x2QWsqd2WeWbha161nzCLfGv7psz2SV_Gveo8B5Yk	!cUrTzQWGYNmZYMHoGB:localhost	m.space.child	!JGJhGNDoMdRLJzLgcJ:localhost	\N
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
X	33	!pWsdJYvpdmDULVhQtX:localhost
\.


--
-- Data for Name: device_lists_changes_in_room; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.device_lists_changes_in_room (user_id, device_id, room_id, stream_id, converted_to_destinations, opentracing_context) FROM stdin;
@user1.matrix:localhost	GHIOXGFALI	!pWsdJYvpdmDULVhQtX:localhost	32	f	{}
@user1.matrix:localhost	GHIOXGFALI	!BfSgfecvJnYoZjTYRA:localhost	32	f	{}
@user1.matrix:localhost	GHIOXGFALI	!kmbTYjjsDRDHGgVqUP:localhost	32	f	{}
@user1.matrix:localhost	GHIOXGFALI	!dKcbdDATuwwphjRPQP:localhost	32	f	{}
@user1.matrix:localhost	GHIOXGFALI	!pWsdJYvpdmDULVhQtX:localhost	33	f	{}
@user1.matrix:localhost	GHIOXGFALI	!BfSgfecvJnYoZjTYRA:localhost	33	f	{}
@user1.matrix:localhost	GHIOXGFALI	!kmbTYjjsDRDHGgVqUP:localhost	33	f	{}
@user1.matrix:localhost	GHIOXGFALI	!dKcbdDATuwwphjRPQP:localhost	33	f	{}
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
2	@admin:localhost	WCSUBIGVWG
3	@matrix_a:localhost	TKAVEOGKHH
4	@matrix_b:localhost	DJFHSWMXLW
5	@ignored_user:localhost	IYEBBQEXHS
6	@matterbot:localhost	WXUVNZGJEW
7	@mm_mattermost_a:localhost	COGVPCWEKD
8	@mm_mattermost_b:localhost	HCOJCHMPGT
12	@user1.matrix:localhost	3/8ZOhX8wQEl9fs1++2yUXosfgS9k3wau3LuYMy66FY
13	@user1.matrix:localhost	afv73e+UXR1Rf2SnKx76pzr5uBBANm9nv0ASDrMuMiM
15	@user1.matrix:localhost	VSOPl7Mt1crWPc8nYK7cjE+pzWdYxGSeMXIjWTeMMUg
16	@user1.matrix:localhost	6/uPZfj+550+ypVZW/ohvr6QOhsqbxPq7V5/JskiSlY
17	@mm_user1.mm:localhost	YBRKEXDYRC
20	@user1.matrix:localhost	QDBOSXPKXK
21	@user1.matrix:localhost	OXBKVBOLVC
23	@user1.matrix:localhost	WMNHMANJWT
26	@user1.matrix:localhost	QHRMHKJLQA
29	@user1.matrix:localhost	VLVGWECQKM
31	@user1.matrix:localhost	MOYNZNSLTL
33	@user1.matrix:localhost	GHIOXGFALI
\.


--
-- Data for Name: devices; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.devices (user_id, device_id, display_name, last_seen, ip, user_agent, hidden) FROM stdin;
@matrix_a:localhost	TKAVEOGKHH	\N	1598686328398	172.21.0.1	curl/7.72.0	f
@ignored_user:localhost	IYEBBQEXHS	\N	1598686328565	172.21.0.1	curl/7.72.0	f
@matterbot:localhost	WXUVNZGJEW	\N	\N	\N	\N	f
@mm_mattermost_a:localhost	COGVPCWEKD	\N	\N	\N	\N	f
@mm_mattermost_b:localhost	HCOJCHMPGT	\N	\N	\N	\N	f
@admin:localhost	WCSUBIGVWG	\N	1673967222026	172.16.238.1	PostmanRuntime/7.30.0	f
@user1.matrix:localhost	3/8ZOhX8wQEl9fs1++2yUXosfgS9k3wau3LuYMy66FY	master signing key	\N	\N	\N	t
@user1.matrix:localhost	afv73e+UXR1Rf2SnKx76pzr5uBBANm9nv0ASDrMuMiM	self_signing signing key	\N	\N	\N	t
@user1.matrix:localhost	gF2DetovRmaXHKP51KbhOb3e7tmJuC16+hYC3swyFx4	user_signing signing key	\N	\N	\N	t
@user1.matrix:localhost	VSOPl7Mt1crWPc8nYK7cjE+pzWdYxGSeMXIjWTeMMUg	master signing key	\N	\N	\N	t
@user1.matrix:localhost	6/uPZfj+550+ypVZW/ohvr6QOhsqbxPq7V5/JskiSlY	self_signing signing key	\N	\N	\N	t
@user1.matrix:localhost	QZDT5p/hG5S1ryn8U+221RcabEL/G6PXPIynLoxQb8s	user_signing signing key	\N	\N	\N	t
@mm_user1.mm:localhost	YBRKEXDYRC	\N	\N	\N	\N	f
@matrix_b:localhost	DJFHSWMXLW	\N	1673974498823	172.16.238.1	Playwright/1.29.2 (x64; macOS 12.6) node/18.2	f
@user1.matrix:localhost	MOYNZNSLTL	localhost:8080: Chrome on macOS	1674203635880	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	f
@user1.matrix:localhost	WMNHMANJWT	localhost:8080: Chrome på macOS	1674058596943	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	f
@user1.matrix:localhost	GHIOXGFALI	localhost:8080: Chrome on macOS	1674211580407	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	f
\.


--
-- Data for Name: e2e_cross_signing_keys; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.e2e_cross_signing_keys (user_id, keytype, keydata, stream_id) FROM stdin;
@user1.matrix:localhost	master	{"user_id":"@user1.matrix:localhost","usage":["master"],"keys":{"ed25519:3/8ZOhX8wQEl9fs1++2yUXosfgS9k3wau3LuYMy66FY":"3/8ZOhX8wQEl9fs1++2yUXosfgS9k3wau3LuYMy66FY"},"signatures":{"@user1.matrix:localhost":{"ed25519:OXBKVBOLVC":"16E4uE18RnWHDCc6ixqRbtj9aLXKAQKOcofQTV8hLBCgQxTsnQqtVCXBcYeV0FIyZv52VV1xCc+1moXlG91RAA"}}}	2
@user1.matrix:localhost	self_signing	{"user_id":"@user1.matrix:localhost","usage":["self_signing"],"keys":{"ed25519:afv73e+UXR1Rf2SnKx76pzr5uBBANm9nv0ASDrMuMiM":"afv73e+UXR1Rf2SnKx76pzr5uBBANm9nv0ASDrMuMiM"},"signatures":{"@user1.matrix:localhost":{"ed25519:3/8ZOhX8wQEl9fs1++2yUXosfgS9k3wau3LuYMy66FY":"FT5svZgrUT4rtb9h+ZKGl7X2syNlvM4IAWSfkytbJdyG9oxQIUi5TTNxgHWMqZCpoRKh836/R6xoIKMGDDzXAw"}}}	3
@user1.matrix:localhost	user_signing	{"user_id":"@user1.matrix:localhost","usage":["user_signing"],"keys":{"ed25519:gF2DetovRmaXHKP51KbhOb3e7tmJuC16+hYC3swyFx4":"gF2DetovRmaXHKP51KbhOb3e7tmJuC16+hYC3swyFx4"},"signatures":{"@user1.matrix:localhost":{"ed25519:3/8ZOhX8wQEl9fs1++2yUXosfgS9k3wau3LuYMy66FY":"UIbvPzyEnoDjg1Me4zfF8Vq1HQsiJGcOeVRgf/q+85ZeQ7cjcH4G9RkePKDfLRxWAZk3GDeV9s9br66l4JXXDA"}}}	4
@user1.matrix:localhost	master	{"user_id":"@user1.matrix:localhost","usage":["master"],"keys":{"ed25519:VSOPl7Mt1crWPc8nYK7cjE+pzWdYxGSeMXIjWTeMMUg":"VSOPl7Mt1crWPc8nYK7cjE+pzWdYxGSeMXIjWTeMMUg"},"signatures":{"@user1.matrix:localhost":{"ed25519:OXBKVBOLVC":"OlO7zCZCFilMRke0U2YVeKCr2rjKF6OBG/a6gXQ/Dt7u4f0/nwSEXPdQVrAJmjYfZK1hdktXzc4LvT47EcbHBw"}}}	5
@user1.matrix:localhost	self_signing	{"user_id":"@user1.matrix:localhost","usage":["self_signing"],"keys":{"ed25519:6/uPZfj+550+ypVZW/ohvr6QOhsqbxPq7V5/JskiSlY":"6/uPZfj+550+ypVZW/ohvr6QOhsqbxPq7V5/JskiSlY"},"signatures":{"@user1.matrix:localhost":{"ed25519:VSOPl7Mt1crWPc8nYK7cjE+pzWdYxGSeMXIjWTeMMUg":"90s+y3n+v2Hq4KHsT2njXXQTFqoyLY7cY67n0NxqomeiVNcjln/HUevNdvapTzFhyX0eu2N54nrlrud9IhORCg"}}}	6
@user1.matrix:localhost	user_signing	{"user_id":"@user1.matrix:localhost","usage":["user_signing"],"keys":{"ed25519:QZDT5p/hG5S1ryn8U+221RcabEL/G6PXPIynLoxQb8s":"QZDT5p/hG5S1ryn8U+221RcabEL/G6PXPIynLoxQb8s"},"signatures":{"@user1.matrix:localhost":{"ed25519:VSOPl7Mt1crWPc8nYK7cjE+pzWdYxGSeMXIjWTeMMUg":"t/cu+fVfx9fRddORS8KxF0i4OFamVfNxBNpBUC1c0HeMBmxKvPSHj8tSVVX4149WL78Sf7WxrV43p5xELUIHDA"}}}	7
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
@user1.matrix:localhost	WMNHMANJWT	1674028742116	{"algorithms":["m.olm.v1.curve25519-aes-sha2","m.megolm.v1.aes-sha2"],"device_id":"WMNHMANJWT","keys":{"curve25519:WMNHMANJWT":"L+6ZN3Wurvf+6gZ7lNDHCUEwF9RrlFPDXmQriAczdUo","ed25519:WMNHMANJWT":"YucFZinnpS1N1hR61Rz46121h00D2RZfHIKhoj3zZEA"},"signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"ySChQrz0kdasyGVOsGZPf37GvIPJ/GEEUNdwp4lXtWhAt5lG9xN6SYK1EwfOBG9NeFFq9dq24m9oH4oGKuaJCQ"}},"user_id":"@user1.matrix:localhost"}
@user1.matrix:localhost	MOYNZNSLTL	1674111093774	{"algorithms":["m.olm.v1.curve25519-aes-sha2","m.megolm.v1.aes-sha2"],"device_id":"MOYNZNSLTL","keys":{"curve25519:MOYNZNSLTL":"kp4m+qdaLby/9OjKlMJKz5Z7zp1zAT96uxcQgJdWHzg","ed25519:MOYNZNSLTL":"LtHL6Qk0rXbB1v9mpDVfgFLjbVvV5IC0wGuYKmmaRUg"},"signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"Yqa9vKtTSH4dr0zKXjUrqmzkMa2+hIvj37abqiPEIS29JTlxv7GC1eXlVECbtFCeJoPQXvOftiiVxkmq+3VqAA"}},"user_id":"@user1.matrix:localhost"}
@user1.matrix:localhost	GHIOXGFALI	1674210822185	{"algorithms":["m.olm.v1.curve25519-aes-sha2","m.megolm.v1.aes-sha2"],"device_id":"GHIOXGFALI","keys":{"curve25519:GHIOXGFALI":"DPvGRF+QBZ+jJjtrANiFdAmNPI0W+wHCtL8YySV5aWU","ed25519:GHIOXGFALI":"/+ScHzehpElhILKZrff2IUZDwGiik3Be9K5GiWalkjU"},"signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"NF4aF5o1HFPBPbGzQ1l2kIPZ35EY0ipvHSgC7nrJVPwdaaAh+Resme5JCFNztg5qX8yd3PQLMr74vDUVqq09CQ"}},"user_id":"@user1.matrix:localhost"}
\.


--
-- Data for Name: e2e_fallback_keys_json; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.e2e_fallback_keys_json (user_id, device_id, algorithm, key_id, key_json, used) FROM stdin;
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAADA	{"key":"WWLVpUzeNUzcOgEE+kPv7aqkDGTT3IcttXTxpXX/N30","fallback":true,"signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"4spccIJeeCeaOxQdklbUuMJATFvhSlYUVLTv9YgdHy3WjhS5OmMWs8NUN8d262bhFwbzkFR2C3TLvy9Cb7xMCg"}}}	f
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAABg	{"key":"j1igwQrYcKgdzaQaOsnpvaJEcp69p/Wg3569mKtEh10","fallback":true,"signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"l1NbofEhcSVvyyFaOHTfm/8xr8/m5z5zFUw1/47Am8XMovG5Zhr6ZpGhNPYo/71v/+Bt16Ttm/4vXyXbzVwoBg"}}}	f
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAADA	{"key":"2/qfJE1O7D34D/j766p8T1+vX04mmeHsyzGKl9Ng0lo","fallback":true,"signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"d4VfiA/ROBvh8oBRHS5W2Ze3tER6v+4/lsY9YK5K74c4E7ZCwbjPM1XUA9sGfNOwRSoDG6SASnIQ5HBbu/WwDQ"}}}	f
\.


--
-- Data for Name: e2e_one_time_keys_json; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.e2e_one_time_keys_json (user_id, device_id, algorithm, key_id, ts_added_ms, key_json) FROM stdin;
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAABQ	1674028742698	{"key":"+vGmTvKDa6AmdQWjIiMY6SdOo1fRY78+TNsEvTr8bnk","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"whK8SjZ335e/uu8RWlaemzavKFvGTqUn2A9rupyOhnqpc2Lb7mU6md3e3KRlpW/RCzEimeXJ7j7x4soncoawCQ"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAABA	1674028742698	{"key":"rk5abV2S008uUJCHcTsWgctkbYBx4gdIbTzHwNPI/V8","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"bwUJwZ+IBb3e5g0Cdpx1T9kOIHWHCzJyCKN31N4qXWiWts0nqH7UuOjw0hF/NWKAkUISmAF5YX0WpUG5TsKgDw"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAAAw	1674028742698	{"key":"hgLFTrWDs+gR+uHhfDzGPXB/dBrZIpSyZQDONAv9+x4","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"A1Ua6LzoCrLwrWzwQ6/wcKCsvj8aJcsp+gQDa8edL21EBrtr2DCnAm5hEWkvB9E6v4iZgOcJ+eXav/XrHz0KDQ"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAAAg	1674028742698	{"key":"LAAoBKoTSk5cC/I4GmXqwGW6qEnpyjS6N62GlBzLWGA","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"XsIWv3lY/EYh6z8Y7uQcn5vBFMM6g1KvxhWHHxzC1qFIeknYTmX+qqJNtRvkoHG+wNRXiJJT/b/bsqYuvFOxAQ"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAAAQ	1674028742698	{"key":"qGtNuf7CDbXy737mXq3IKOUJ0U0MuzEBemg1cSkccGw","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"kSRr/Rg4nUB1pt3NAR2tbheTmHcdTlMmPDd04O6DKIlIraeSSrf6ObVrXkZm5MG6gMZDhBePnWjg5cxm00phAA"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAACw	1674028743031	{"key":"NrbgXvUp/aoGZk/m0gqX01mDwvrTKPXICu8OL1QtVT8","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"yf6Zl8qiUI94DIKmtXcm+hCJY+ISavR6t21Tm0j5R18s2GvztEAlpau+x4ahXCXHgwPP7aV6CdxmFaP++gekDA"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAACg	1674028743031	{"key":"ISWbAXhE0Slcuj/1bOwWzUqwkv8A5HEt0Iiv5oj0BCI","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"fgOxycvI8+6vm9DzQ8zG6SJalIVWI5G9TwKO2z/n92p2xgQCC53FI+Okq/knI9il71c+iv1Ms7wbVKlRgICKAw"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAACQ	1674028743031	{"key":"rpUbmiDkvlbsCnwyJ5VJdfrn8MyUUHJqQyfICxsNtGU","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"G15uQ9XQHcCifHmtbaaHYCu3AsFwFNz5A8Zys8ar3Z5wdZU6Bspb8I3MzlMcdiTjrsg3wwnkZ6zi7x+RntO4DA"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAACA	1674028743031	{"key":"0GkvXBAGHv5RAF2f3xG9geohTn0TIzOXy2rXViBXcik","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"qwbkdi8AqcP7yhPILhdloRCaSvHdUK+q79aKfJO4bu/GossSqIkM8nSLskDA0Se6hrK0D5fN7J+cIfiJMS8QDQ"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAABw	1674028743031	{"key":"YD/qHfnYiApHUGXizvgaGFE7uXOf74UIfxjRW1b2OQE","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"t7p3CDKENUK9pYzXPQmvWh8LyIaAHoAi2ZXh5xHORqn/aCT9EuaxnC/3I+4GeMV2DUG9MzxA4Jddra3dDwWkAg"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAAEQ	1674028743149	{"key":"hWp4wkUU5KJn0/UMILuyBhh3ZTXg0v7ivW77vyxQQkc","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"z2XYxR+fIZ1TnhXXuoPlg/gIOq2jOL24Zx2L6TeJc2/M5ZSuG0JeIYN9QcKVneY0pFKx6on2wYm2gEsr6XywCg"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAAEA	1674028743149	{"key":"vDpElRNqNhQRcoyAb4iBeoqbd+3lUM5nHm+3zdbmsD8","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"NVRxwJrmObrGfMyYLtWJ/lyDxoyQ6hMeV4QMnSSxOpCdhPCBqPwWHEKszrdvaOpD+IpUSDJD+STOpkfernB2Cw"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAADw	1674028743149	{"key":"/NiZPl+/kiD5FtGWdYt3F8A3EGBqKTdTsGwfoFgNMyc","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"aq7TdCcIA8HLFNCpkK6cY6AIXVZasm6P3DcdK7sWwltEXD58Y/GgMt1V2b6JbepZI6FHnnjXfzHV9FcKaiFcDw"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAADg	1674028743149	{"key":"V6DT1wqrV+3OPnFjQBKjtoqkLx+pW+imbYDvmaTAvzY","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"EsrRZlYr6i2mVTMmGDEiUdNADtacC1GGARSdtngbR6ukT+QsUmfujiC07xXdT7RyWLRS815Qk1RbtbevxHJbCw"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAADQ	1674028743149	{"key":"0nci5bT9Y2NBCeMuMi65moCukqHdQCRy2e7xwe0olTs","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"6DRA+UuslDfR+i5Ztt4y7OKM0f8GxCgqftEkBmvnOOc+o5zRaNERrwrGG/lf9xW1BNtXOthT0Nt6W6P0I48tDA"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAAFg	1674028743246	{"key":"FBjmWq3WVIU5lRaMZmlVd1o/aPjekA0u2Uci2EJ+lj4","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"yHieT/ljwFyJ1A83Dmmcgo3pW+RWFVmOQ0x3eemuEh4kZx/8nM5cDqMLULf8/KKuynU2iuq9+nUJGU+CKX5GBA"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAAFQ	1674028743246	{"key":"DHsqNA8P10fLgkmFZWivwe7tIVYTXTlIFhFfbI3yFXE","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"3T+g94X5KiAYHGQxtkKL5w3uTyYfC15IIl501nWLSBAbCeW2mTQdVMAQjm6DfsJYja8byuyLh6g6EuwtCXzoCQ"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAAFA	1674028743246	{"key":"uwXSCo+lH3SYil6nsKKShCzdV1hGwHWcvQQozIkQgRk","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"xSCWg0LKVdtbFvjO/CyOHtik+hzxlBloe3B3lVKZdiFD5o4sKphQSlx4snb1cVkbEJmbcMpu9BfLEiPwRYQQBg"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAAEw	1674028743246	{"key":"eMrCZVeBfKHdZwQbvG3gtlPNU3iynzp9CaSaxiRt1Tg","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"3OI5ZM6Ib8ZkREyhoAzzWwpB20/vK7zl8fgeDCifNp6fCO/UhaG/Ij2Y3EUIJHlKM0fjXLam54+J5+ypjO/gAg"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAAEg	1674028743246	{"key":"sdj1Tr/GEf1W5mO4V3yMwxftuGFtXFTSsGpBXjZKAFY","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"IwAkWu9K1lMBNWKtVuHkwfQWURz2KZQ1oGLRwoaT+Hayjbti8vfyYKRgoy0ErFUAp68xbwGkdIQIwWo6gZiADA"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAAGw	1674028743427	{"key":"CAivHbrSJI1YNDyPajuZoQEF0MngNg4WdOVR8bcAHjc","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"CKiMnHgARuiPg9Ph3x1nho22zByeK4j5zpg6xX7XFaizQppTDNZ0G99JQ6VD2zAEOqqcWTUro1+hjPaNEIICBg"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAAGg	1674028743427	{"key":"3/dITcjwwFb56B0s/wK4iKP9ELIrnVA6Oj/5cTXFvRA","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"/LIof5ueSEazYXSuZd4yUP9h7H6nwcYEnhBsk0pVoLkq71qfLIL5HCy4r95qzGqMTVpPYqXuPm24lVg5HMZ6AQ"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAAGQ	1674028743427	{"key":"3q0qLo4zsb4QXI42s8vF7Dfg3uTndM84nqod/q+1ryw","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"qXSS1OPhQm3auZMbDv18fZhaOsbke7g5cXrXSolUJtdcJijZl+yaWADXWBLWbjSUi5K+8f3qcbeogd2sg9/xCQ"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAAGA	1674028743427	{"key":"UACR6wR/ZVI7CkqhzbUvumjWauThoM78YTtJgmg0YRk","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"Zbp/M5vB3Ez55gjKoPF9y+vuWqek7RPKDsrQhWruZbdj1o7BQYWkgnlmztMrJy7SUmxrqVVjT28MF+dfxrtfBg"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAAFw	1674028743427	{"key":"UjeiFXNW+nRxsi+6z0++bYzGlPCuSpSkHZW6e2knoUY","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"OBskNlzTY9jY7y+6LT55PiZaKEXC0hsen8giviYJLs51lUIdtQ1zaUg77/vufUGh5d9xFQ3xKbWse0T8Ge1lCw"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAAIA	1674028743520	{"key":"gjqgbFeO/tkyI2Z9MnPMylhjXN0/ZMWZb3L+pcFfTXI","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"gLi484Rbx2MPcC+cQ86H5Vpnw9S4snoq3mBT0qWUzdCT+qV2sBBWFKlOPzMReYybTgD6BaJYQNformzh9eq7Cw"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAAHw	1674028743520	{"key":"9dErlZdgUXUxR+rOz2r+zt14sz0yRXpJMMQYbRT+R0Q","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"rg4XqQgWeLz0cS/L5Ez/mDujElyjNHWpMCfxgKN1Ma6P4PXXM+k6oxI5W081IiLb1QNaF6GvGmOr7xdCRIA6BA"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAAHg	1674028743520	{"key":"ugNl/766/ptGBiojI6wFhY6sMmXAZgStR922RZ/MYE0","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"Mbt9+shfaBG5G8mOfJdzK+YklC6voLlzb0+3IrogzxEfRxdUW/EJD8+7MJeINCeQXQ/R2vGUhqAOG30Fn0oaBQ"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAAHQ	1674028743520	{"key":"oP5q0Gm6LEBRSZKSLXpWEa1ZfAXb+81XOywYmSOAsi0","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"hp/pNdbij/o14sujFnYgtinpnw97OK3TYPCbwoXjrWQYekw9q216/G6ki9Wu4ZORRA1XDtXUBuwu+GOZvS3HAw"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAAHA	1674028743520	{"key":"k3Go1MO3aux5wad9n3eplLKtb42Gj1eVbw0/n7bAtyw","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"XpejShAnQGE3FlAP9je/ib0ca3WZ4gxF/UEJwgls6y7iw7rtTFSzjlXLQkqjd18vWxibsos/aa1c2cJgLyikDw"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAAJQ	1674028743617	{"key":"BGJINpezqsi1jh/ZEBc6UBupJMuJnhplLCiThsGru1I","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"D75z3Qa5kAYaS+VVftaRIIlOocNknR+OckSov1WEz4oivBk+9WQbmyiRAE80DZmawQcVS7OSfnH0OJeyWOQDBg"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAAJA	1674028743617	{"key":"GhQormP89aOERq7RZt+k/wZFFnzJCNnJu3rsOhIP5UQ","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"ZucD9KLHyyU3nL+hDrdk9ivkd1bRJdIsr3uhFq4jmg1ytPbNsxnEFOAhyjA1gZzFQAthtQngHpHkpxVZWpD4Bg"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAAIw	1674028743617	{"key":"MFf23YgwVQ0tqWAe4I/LER4PuF3ICAuq2MshwgxFk28","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"gc+BIz/ziVuDgICOzcenX8vMA7JN6SvHOA6dFXr7RnNPIajfdEnfi/oh5laH+M3eyccANfTqWd/Fo4HwXK9qDQ"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAAIg	1674028743617	{"key":"2YHNsXYPo8gJ7iZI78wtTYxD2MpU7B/kNhTTHkbfon4","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"X8Qc8xJ2UE1YfvGeOgX2DR4hrAedCsej13y78/B3qRtb2TW79jQNhsqD5oL65YS+lf7dQVjnw2gLfUdOGngCAQ"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAAIQ	1674028743617	{"key":"WBKhQK44uR+MK9iiTx01qvSgKbw5RiN8XaBYn7p+XCg","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"kGmDZA9i055eqVr20guBKsGEVLk5Wf5AfLKB63qia3AJZ9U3yNzJt683wC1Wj+UJonRG8VImwN8iAfAjqZAoAA"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAAKg	1674028743699	{"key":"Uzq2oTpv9QfMubDSF3DBBXw+4/VXbGogrSL2AZgSWzc","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"rOD/kUNwe7iA0nZWFysyN1rqi4bEPwgYytPeYwGneEIQZD7GP6jBoDlAWz4H65ggo5nVtQKqELArA98NwuBRAA"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAAKQ	1674028743699	{"key":"Vd7krRJLPJsb7t9ZLaMR58eytI0KU4Ktww0reNbRcXw","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"4lP0aBm/XNLO7ILDdl07biSCo8/5M/WaBh48YprMIaqriS7FOKJl33LYEb4EJn0ElQ/tWgbTIKeEHzUn78QiCQ"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAAKA	1674028743699	{"key":"ApD2NDHhlHMnD0WC0Y3hU2F3VWYZiiaaXR6TjtnRISQ","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"GYFd0eO1cMC6sVuAylP83c+WzZzvlgn+BSTBc+oJEpEUZstnBUaSz3OWDNlsuOFwiUOkmBO9bfbiD3JIRzwYDg"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAAJw	1674028743699	{"key":"t/Xu1Xz3Us5yEWbXSF/DsjM3XpWS0Kb1OVHGv2p/FEA","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"GrurCeEeUY2HtltF5le1Kliw7Iyeu0X+voMkQ1Hhqu5lJ9iK2FyMIUSxPWzIJt7EXjomYFHGr2r0kQBaOf9NCA"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAAJg	1674028743699	{"key":"kvqpZWt9gZ/vKmT1pqcqqSFRvtOuB97YPbJ5e8PEF38","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"TSwf2HH+XyzYowIOKZvd3DEArd+08q0kHld3Ygf9ZOU8roGuWt+V7j3cIc9f3lp0QAKL7cu+mQ21X39Vu4prCA"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAALw	1674028743788	{"key":"bjWk9qMHYREYbgyrtOmWZ0f0AdWk3o7GQABfQ9CrQkI","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"VwUnP8HIGQv1n37wojIVVm5DT56Eahi5CXh3/bxib8P5uqxjQ3M6CaQM81mgm1vpCA9VMJqocecTCz67nDJHCQ"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAALg	1674028743788	{"key":"6VcF/jcsLfOgmBPjohLWZ7F4c5AM8Knp3c2+qWun2nU","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"SsDM+wM4vUtIQqOz7npU0ynmW6RA82hUsJ1i5+eV+s0F9rgctzXMxhquJhyrigfxh4WnraTPH79IknU/FctxDA"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAALQ	1674028743788	{"key":"zRE+o9v/vLL6nnwDHagzNsd5fYXS/XpCSyfoK2Ne/hQ","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"u2fBFoUi+JRCUimY5AtnW2MgKCFCTEe1U/ktLkUV7R1mZzPz9J5QoNrEhoKyT28i+36z1jbZkPjwduGcPH1wBw"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAALA	1674028743788	{"key":"h2NmK7LKIST31H1/FdNcquiqv3eApcr5IquW/aIm1Aw","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"AVSh9EjBDCG1lWqDI66D4P00XCsGCUAqq2l3ReUgx+cZXkqVjPhfbhmBH90ZU0Dsu7UUFDsTwhgHva80okmlAw"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAAKw	1674028743788	{"key":"KUm9slbCBM+6k9jd7+tJCHt8/VaLHczH2bY6CKFaR2M","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"UDP5z3cDLoCF6Cb9hxOnany0G+zmg16KAe7uMYx9SdwJ/EFjvX0g+PgO6sDOAvtPT7PoXgeTWXekjr/XQnliDQ"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAANA	1674028743880	{"key":"vhZTdSlmgxggw4SGr5cMPv/d0ivB1T1uuUoWZICAgkA","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"nK3DWLjJNn8PWKPrN+7QdsnQAtiQlZs4NSNARXD0irIeyIb9hUxCpFKHmSVusgIeEuoi9wDffJUOEdlbW6U2Aw"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAAMw	1674028743880	{"key":"xejdYPeWEeQnmcA4EAmrpoI5j2Ow72XnotJipBvCYT0","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"M34nyi+Sgn5sGC7l7Q0/MHPp5ixKjViufa8W7RyjcnASMaYtL3Zg2JS8t24CjbYPajKhpW9934cNVXifEBBTCw"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAAMg	1674028743880	{"key":"TA/s3VSCuHhOsZgy+mJVPqzA44sRI39lMv/U7JlH/lU","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"DDDj3HNpNDNAF50UwmCl3OO5kB3Tooz0ZXkie9ookRgC+AwaHUAmSjBlqUBoM8CbHRu8ITv0Eq3ajGHFYfAaAQ"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAAMQ	1674028743880	{"key":"gQbzRwHwfw8FXnfRw1DxfWxr8M9xGsWbZE1SqXAK4D4","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"1zTg6XG4cMCIrHkKhRh2z/C2GIJIv0SsG/DTWO1LYqFB3BkWAzA5M+mtmY0QcaKMOF1nHsAG1hLF4LxMSWGGDw"}}}
@user1.matrix:localhost	WMNHMANJWT	signed_curve25519	AAAAMA	1674028743880	{"key":"Ie+S5jkgZQWM4PIqxIEyB0b1Ms9QkuyoB5/akzMz1yU","signatures":{"@user1.matrix:localhost":{"ed25519:WMNHMANJWT":"sp5+OzQEse8bKauKKz204nM0o2rBRX/Lw7XisOOUx+hGuz55A3FYenrsgGlhJxcqaaoF2fGC+4RaKouHKA7lDw"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAABQ	1674111094274	{"key":"243J+45bSrzEMT9TjXSniaCvRHCklJKp/AJRA3Vg1Ug","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"rm3S894H42U1W0+ucqrzTHxaLkk1OkHBD6kAKecHJbbiwJsdCq5NRXfjZehYmj1nD0mQIMaQLo6+ouiXvZnxDQ"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAABA	1674111094274	{"key":"9OwUqQYhrprrt6n25PPBzVps7wOowz6NJDwDbV8OwWk","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"A2QmiRIQpS0dQoM1hdl5/RwwvdBlr7vYyx8uhjbnM5sRveJuiio8F1Xd2ytmuXfcOFhHzdaq+Klz2OP22n2KCw"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAAAw	1674111094274	{"key":"39N83FHokFd03ObMbEeKYBmyeygGatMIqP+OYve44lA","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"s8WhWvL/Cfir1fWEpUL27y4CYlsrvu4VuAsMl7o9tBZESwUimjEu1KnmLHIlK4Sqt1NqnbrJdaF8XHP+qV4GBA"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAAAg	1674111094274	{"key":"GczpZ5nI1ogfkBZf/oi+I0nJip/EcCZMiJYajqVPe3o","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"eE2Bj+LuRjNQ0xPeKqDpkjnqZG89l8gJ8Lbs1chhsQaxtjqjP35Fw54dCITHB3yl/5DCwSEN/4Jv4dj5o2MmDQ"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAAAQ	1674111094274	{"key":"UB7oWds/ENSljNG85OFzEgoxDXzD3WFSvJNKBszWByk","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"gf11eThFwZn1g6LCzdmIneRNYl8VO5G5raxyRKwtBMoVtycjb3EEMnggi45Z22cgA34GGfH1TTHDosuedxJkAw"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAACw	1674111094370	{"key":"kTQ7KiAxa4B39+LhevUgGKVIg1F5HE6MYpbK2PeP81g","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"ULyUtEkKOo9hBB65/cm7qpnQtcwT9anHkd99Tzr87UQK3r719WlACnz8MmLQbwL9FB9eAkSQlMSTZo5UVMpQAQ"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAACg	1674111094370	{"key":"rhzH1JVv/wKGEHVn/8Qoz946uUPSQeaDWlBGtyfAtVs","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"YDQTaf5oubTQv+q59x1TBxe4zhToodvRiZWScXnoTOeShlk6ZsiJ1gFYSL5+Y3gB4TwP9fHG368RaEBfAFbUBQ"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAACQ	1674111094370	{"key":"8JT7R6JWwrxcVfFWZH9Ck5GN/2kfJkAKC+BX/iSB7Qg","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"dIVyTf+JnfpcqXkSwGpeDwWcZSVJH0niSYr6z9TQd5zTGsRNB9IFfkB98fPE93QaFP5pRNLf9xd3fg6PTe6oDQ"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAACA	1674111094370	{"key":"NoeAdsF/o8FEZO2aWlYbSuGaDZ1VCC89HkfA1/28DwQ","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"1aszRKPp9VTRhVOC9WocH1emf8Q25r78clzuyx5lNBNa8DJU7R6KAOi+P7/+l2cQAXidCeL8ymqUdDIL8HlhDA"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAABw	1674111094370	{"key":"+IIQvpFgZeJ+7YgjYHwIjxDqvhqGoh7t+bZmjva/pgw","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"32IHhuSlU79g9Xmd1IdgT38zYvdrZApoeR4E/zNKiSfapoCbimplGbinl8cBzCi+UgdgOESEsbTnpHXNGtHZCg"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAAEA	1674111094427	{"key":"weqa82vqfbUFsTNaixF/gW4NFfmnrH7qQdybenhk9i8","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"ovQZkqVAHcT6UJweIo5H0FPaoNXIgnKdeRaN3uH6BW4eIbfp+whiVF56fIW+uGsjSl+ifWrLnTkXrKeexE8EBw"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAADw	1674111094427	{"key":"V2Tt/QCRcIBin2WQddvhfUB8HDumJk9S0/xpgqf+bhw","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"TAf6vpJ10WUv4VuBT2C3dPKdVZ2TXBzlnpNCKZh8G7pwyZRr8lDLXzSnVO7hJDdxeQnjJoPHWID1uy9LBQ4BCw"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAADg	1674111094427	{"key":"f0u5IdFz9cRMwnaASOQUy5cwuuK+4EW20vSUzTnpxCc","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"Dfc/qGz/QBpsvfmQLMzsChhqZQnyAOtEMXOolSApkohVzmiy27v5BR89SmJnBKvQs1eqDJI6R+DCWOE4aTucCQ"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAADQ	1674111094427	{"key":"Lcsdz8/J5ZWm4x0soj3SzVsXMIDYZNgGnPVNn0lCAHo","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"vjdgQb4kuwarFfVtBI6+d2kP/ndifTOwcKoEPCzNwaPfhcpRHUsczA0/PqsSzAsHGS6r0F9kuvdj5E7Zk20bCA"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAADA	1674111094427	{"key":"Oyk5QTxe4Wja6yhN5LvnqMFM380A3r4vSJgD4gZR9AE","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"coCPLmJuDXmstS/6+pqt4TmBfASBg7zWx0PhkyVc7pB2GoYY1Hv8lfgH0PQK3FDc1Dv4K5+Z6QW3JZzjjQrKCg"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAAFQ	1674111094477	{"key":"6xj0Yg9G1V/6khVR0YzrQ876WMwR2yMdVHlNe5oBDgw","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"WpAw4UR4qWtPQM2buRHD1/+XV2DTol3ecmN10HNcivcQN6KE09ZEPF0mFnTO5uFz4KCNIMWrCGz5Q2yEEySjAw"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAAFA	1674111094477	{"key":"n49Wsr/WRmE9ZDsiSTdsxURBqZFBaiQUq5bV9jYIDio","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"A7jMyXZGg5Yz/KK6h7dskKJV0Rim8T5DDuip1hMo8dzM9R1wx/8xW0Hv7TwrXvvWtuFfYdss5B1DlkwdMwv7CQ"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAAEw	1674111094477	{"key":"QyWg1FxpfBcilCalnlzI2GZHzB831EhPp7HcpHZqNzw","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"h17kC0bLq5nVlR0oj/O/0jd+Yt3vvyUM4qLAyvweX2+SDiCWxacc+JU6eDdlmS7Yw6tQxWk6IPvmGwcFspjtDw"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAAEg	1674111094477	{"key":"F8B0pEIJNDLwOjlFWtL/ZNfhe5Ny6FCr3Y3IjgZDshw","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"VAeaIvoXldPJ5LO7N4f4GgKRLsPF6PngJLV3SZ5z9pmin3GU2I3IMnusA5QxbeG0ex7g67h+JCTvslyEOo67CQ"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAAEQ	1674111094477	{"key":"LUqh7D+dm1bn+ojoHolLKghZKt6chTiwYKe8QR8qa0o","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"dDk7wgL+z6wljrujS8UHbvo3SDMj94wPjFVWzKdBnl9oAMWqEYknq1oRCDCELLMvy3p/cAQMw4/mzv8dhZ59CQ"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAAGg	1674111094527	{"key":"CxcPoiqULhOKe3E9pO3FHlW3/2wiZMopLaWBnpPQ6lA","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"pB5W7mFIe+2OKJJciqBgudz2iVPjBzfdul7DGmA/S7WZGV23qr4x2HMQyZprwGUH3jMOnIiJ614PHyC/toJ8Aw"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAAGQ	1674111094527	{"key":"sJKoOJzQ6FwbKv41Zt0jQwykXoMV9Z9w+dmiJQqI6Dc","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"2bjV1S0jYQz4SwROzi7GCcN+8OXYooCxJIJrMiPVp5mdjkYvN8W1Yw1B4N7ykZpLAWwO9oSXa3/qpYfOAIRMAw"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAAGA	1674111094527	{"key":"+X9OHzMDRUlDjj47rldwnbSZWGRMVvmtG8h+7YqOiQk","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"SZhk5q3bBM9Iq+Vfyn3TNN7Msjekt8tyN6M68eHT3qZ+LnK6WRrLXHqyW3lNzqV/jqtoQOmdUuEqDnNQLTxdCQ"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAAFw	1674111094527	{"key":"Mt6mipk4dGth7d6ie/6qQtpPI4TFx/+zRQd3lug9q3Y","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"3ak7BnvjPeWll7r9xaKpK3IVclIRhynvIPbC1bO7XrwPbSifmRqKDjNDvWmuVJWl0nFgat67vos6VmJAEm1DDQ"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAAFg	1674111094527	{"key":"c97LFBT3s+bb79mtFqsenmo3RwaVIpKnJrYAfSgdXhM","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"llhvtiVktKQFIRO+evtpimDQfSIPlUU+zLL0TAZ6YPECH+/YGkG6MBQOLxMYKYJnSiYNg4m51eqw0OUw1hXKDg"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAAHw	1674111094602	{"key":"Cdxu5fijclQeQOQHs8E240LJCyUa6UxHJd3/zuG+9l8","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"NkLSndwSN4s+l4yEJgMBmo/A3ZueWZ4nylEakyG5+4aCFbHEynYs+aw26xzKju8RjWlcy89kibsG2GlAZXZ9Ag"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAAHg	1674111094602	{"key":"2RVMHP8AOPPDlt1GD9g3d2cVswxuJIpMcos02nLMlT0","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"20KtSu659CYIty2nfi0rjxk/kxKoEDsyMdJ+Yxsmc72VhuJL6LAc4BGGw/1iHRasttxUDs7hsdne+QfyervXDg"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAAHQ	1674111094602	{"key":"XDsdrMED1gZ/deu1QoWeLx8mtJ4hWTO2T3cHUHtpeXA","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"t0A7Cc9j4/JnQVNhfDGYIfs5iWW2fE2vAosRACrJst5162kfb3QteE1B/aZNWiuAmGEIfWJ+y3qcR5QPybnXAA"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAAHA	1674111094602	{"key":"eHtKfhF2FszB29eyEtspbUN1O0EBsXUwalsRP1DaewQ","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"kEjZMOU0JM8HwVcNhp0hI7GK6YA6eysfuTg1b/+Mv/MpQJBP/7azyHNFIgHk4i5Tvu5NpVGUohLw/lJBo3FsBQ"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAAGw	1674111094602	{"key":"4tdWFApf0/9YLmdYh6ONhRLOZQAz2YcGM1T2RMFRwiU","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"0Nob/t92Ilv2QHvRg9sVPBSv1cA74ZqvYMHIzRO7+VcPMpQQylHh89iEmLULBqpsGopVQzVY91ZHpDMcMJhyCA"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAAJA	1674111094661	{"key":"3PY4r43AN2hsKnTuua2OAJ+Wuo4R+byt6gLKiVS9wSk","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"kqj2aOLcT+xeITGihwzVm621ZMgnmXMJypDJnGMeFIT2lJPhwM6AEd5pz2J/QZMlrs6E+yy/GRD/SWKOnRY2Cg"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAAIw	1674111094661	{"key":"TI/qoVP3OgU42pO2n6eJ2SXU7pZb3y++vEwuFZLEsmI","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"vA35u5gH4HT3fFXxk2bJCmhPsadxHJiWPYIwuMklWDa0dhh5VAJ+cxrKolWLkF3FrhDSXIfnpf0V21mfbLFvBg"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAAIg	1674111094661	{"key":"o6nRJLI0Ifhue9WVRjdMVjSy+3G7CpP4Yem8C8cN03w","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"39s0OJQCu/x/piAVIMrjmMqkNMODRTs0549iTtpYDnUmjUR1Dvl2UmzQhrr54EXv8pkVZhYpggsTcjqEiH6NBg"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAAIQ	1674111094661	{"key":"Nvvh5rEWRbIxitr53hC3f/3dCT5a3V4KriwcdZtD2yM","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"1kXagTpOh6Sr0HWCqrnUtFgaCsdV6rBxUZndnZd3jRPdfCEUcXMLl5h6V/c3YkQttNjgCNQUg1y7b/WtiQYgBg"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAAIA	1674111094661	{"key":"ndwpUw1wiOZF0RDrxTkNZSAUQoz5tmcuJHmkc+JcqRI","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"NPIzLk0MNHQINPWwgn+BCEneaAjzfo1+5d8pECL9FPJTePehk2qxRy3iPfNh8sFhfUt0AII2em0dPfHKoXsiCw"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAAKQ	1674111094712	{"key":"A8YkDtzPlJ8JO9I0IAAm/fLh729472Hdv+bgslmudnY","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"eEXlftaQttpWE7WNKHpJRtNvI1vXvqcQRV02xFS0vVIyhLcBnlDuY4paoFKMVTs7rLGnKtY2RcX9NUdvoINiBw"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAAKA	1674111094712	{"key":"GAIhXAAS6cRtMldjmQXmW88BeRw0piMxvChgdjkGjyc","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"16m3hFcDgr7YUGTf/XBcz3hCTCFymRmpbhNXBVsaYMMgSB6i7rGGT85vq8MFZCMvmcUdAuC1xe1lXs4fTbOKAg"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAAJw	1674111094712	{"key":"97tsb6ZAakr5M4xrKY7ydmI02he581oEw88PQ25ntFU","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"W//gbHNS69XGFjVsja85kfvEnHUninwdjz8C0aQgZPUhJdNVFGO9lhZQWvddvIlqFy7LEz+u+dNWFD0DnY/dBA"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAAJg	1674111094712	{"key":"TvwMo9rRDP31hhyJtFdphbRx9qDmsPIn5eoKg0UYsW4","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"l86PYThGtt9Oxcq+5ilWsJczm4sauGOzDAUPRtXEYtE8g/RWOLMD6+m89fEkQXhemti5N5r/AVYFwj5z0F5VDg"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAAJQ	1674111094712	{"key":"2YzZ8zfv17F9ObV1ikbYLOtKYGJ3B4QTMQB0Ys1tohg","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"ODxw244kIvprv47yXrwEaHB+0pF6ltXzccPEdrGv0KX3/xara4d+rep57NXHfJAPQseKNh3PhlkC+i/OCwbTBA"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAALg	1674111094769	{"key":"+iIMNaPRefhBl6o46WQj84tQ/kb4icM8uoH2Hpkj+Ag","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"FI52RsSFZHWx2Zy+nhfHI1rZTySTIaaZ0Hj7+hNLYfhQF/YszApUih6xAGfAIHC+cbvOc0FGKOShbKFc6snWCg"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAALQ	1674111094769	{"key":"tzq1mPPQZ5vHteFHJ4XzoisXwRQycGPk4NAuBCGMzCc","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"2Z7zDJJ2obCJsrV9Q0SP2GbKKmlYkVRjdRmHLTvMwyhZHEHo/3KiiAFgmAu1Ux79asSeZ/35A7iTmiVakuBPAQ"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAALA	1674111094769	{"key":"ZbavjQMJieoh8HAZcIWNeuXaPOPsAaDsaIoKgVUPmyE","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"RebEfOj/1Vwv8B/ljzWe9zx0kgCyAReGfoEC4GwxzVsyOYWhPqi/z+UrGtateRsut3+oWOJWbpxzBt+/iV50DA"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAAKw	1674111094769	{"key":"VC+UDVlqL4vU5RRGuhz7alCoCHvI4fRwSLCzGgPh3h4","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"7dVXqMpRANl7AIF2FR6d9MIhrVFBaJQQFlGH17xrXO2FTcofK3NCmli9jxFTO4Ciq7X4l6dURhvygCd6XeaLBA"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAAKg	1674111094769	{"key":"/1RMGbcKWi/Xt2ptShO5PdoRuvPfWaSORizNBD/hJWs","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"cDNDRB5MyEV3yTvmOoRZX2vrhxnbaUc7fW7XqTnqU8GeeTS7LJfdNnbAH6cbKS7VKmj48KmzxJyuuPlHqkMXAQ"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAAMw	1674111094843	{"key":"bK3jq9bIWL1BBCHyJsO82vucABXP28umSy6XnRSZgkU","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"zO04FKKY58xmkNmLpU8/lUAI8Pg0Z6FhIn5xQQgPbk+jGaPzGHyS5cRlBOWSvZ9dmT25YIAmXcfpUD0TJyTuCw"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAAMg	1674111094843	{"key":"jo1Y5rsJu7A9RAk+aTydbfRovqiKjhaMnb9p7MC6jlw","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"qLucNRmh+GmlitXW/RmCEcOHkBxpV5HyKJQfM6NJEEryyrbl3ciM0BIon/4nyacrU+41bJgxTzZecvzI1shFAQ"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAAMQ	1674111094843	{"key":"jso8QTyzUV6Hl4rvWx2tX7ZBJexaPnjMB9sMXULe2UY","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"Apk+bOnmnARHEeYPf2Lw2CN2uAn/C4oM17XlSSa+uePjbpZvcwrmtyfONxxu6DiLcTKvK+6LgIhR5oF4L1SxBQ"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAAMA	1674111094843	{"key":"65gkAqxJ2iiEvClECD4nxGkgqHYRe7EC9jNCmUy0ETE","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"qhWEM+dwc4nA7TQgcGhaAD0ItsbqmBPMYdAdpQArB1/yvbAC6TxmMKm5QB/fsqui5TjTgNrwSqWek2XOVuDgAA"}}}
@user1.matrix:localhost	MOYNZNSLTL	signed_curve25519	AAAALw	1674111094843	{"key":"pdkkmgH61XLB+2EvEVFSKysLLEDCmGiRDHeZy3mgO0c","signatures":{"@user1.matrix:localhost":{"ed25519:MOYNZNSLTL":"6iQLo5VNRayEtV6EZGzKCyY+7yYjBMW6XCExydndLzru7hAZad8KlwBER/kScSFQD6dUoU4aWTrDIA/Y3HChCA"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAABQ	1674210823220	{"key":"U+PfGYk+fCZTAruRxFInVpT8/UtKRQpH09NiYbnan3w","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"ZtqwSROHhlVODRCX3EkmhVzeC/PSRUgVrcMo6TekCnmmNZa2B2ILjEmv8OeQ+wCKzGrMRIm2sLgSRsZaJGDOAg"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAABA	1674210823220	{"key":"E2w0tOq0tjKodGw7Qbmt/R2Z06jmwqx5fVNKqG2K7XU","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"AzRRLHDFBp5WmSxV1v+W6UhbjTYs4812xCgVKfIVSCSI+eww0Mikjo8KpBemlRExDunE+JPnSb3Afhhc3swADg"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAAAw	1674210823220	{"key":"aH54O/aN8tbZkI/xILuiMAPZZW6wfA0CgzKbHhqXD0M","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"nGhmmBEfRZcPEiV8Dmx8tuXha36sdM05W75txgl1I3P+nPfk2SpX7gR1CGBsfagIJPx47HYkFScrug1h04TECQ"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAAAg	1674210823220	{"key":"3EOo+ans9WjKiPS9lYoXPXzfp+q/GBTks4lXJpSCN3c","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"pbbbhd1cK6kQ2uIrbRJK9pVJOEHnZuEjm7FUpRCo7ydc48xYwfWWIJ37+AbaVML7trwwwCq2WI3buzfMQEauBw"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAAAQ	1674210823220	{"key":"+R/nUyIpBwlWjvyUzMZPNhCln0sWmgziQ8i8K7/C8FE","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"pfNS3mshyDc4tTghBxC/tngvs5xqcgzyYdbqfuRPzxS//h4LiYOUqAw1GCe4IKpSXrxIf7NLN9KdwZzdyMJvAg"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAACw	1674210823334	{"key":"9089sJQ0Rv5pHaxRTXMGsmHpoOs3s20TVqsO4R6LrSY","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"1tlck10DPIrG+eTXL5L6wV2KKmgKkFH3zf5I7d0bgdeDUYuCOgWaFf0X5YVExv7GLx/+rnKqpS2+l1vXJCclCw"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAACg	1674210823334	{"key":"n6iV/MpepJnN+JG/nmEgL507BblvCwRSrmt6VCvK2XA","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"N2koFOJmokIZpQ3dYhISRqZesteruyui2X/NmjtJILWnKGeMa9jVZAt43GA5AW9apTTxBy0Ns04lD2auKUOuDQ"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAACQ	1674210823334	{"key":"dPIlPpY5XBbrt6d1S3uMoQcC5OgB/yVq8KG7secrz3c","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"dfLcqPyb0ICHAdSaH0CNMh98TbidClS8mcUPhMUBv7Dhfk67pOlVTUIAAYtc81rval1xa4jHqcsmbrg/G4V4DA"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAACA	1674210823334	{"key":"jWgYKxRVj9ILVX6dLIdbwM91gGVgIK0i4jmApnieyXo","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"OJpXglUgBx660QHLFgcjzaoiIShOWO7+9Kyd1GH9Nj3fLBAKd8nDGj0oOnxw/ibcqX8zPhKll6KaqqLg0DOiAQ"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAABw	1674210823334	{"key":"76C2qecSIcsaEIvPw7tueKW2q8pqsbaoRbgb1grK+lM","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"+MyMNmGRc5Nifen4u7u9wcOzZPanqNwCgWALmy7eg7fTshhSE6tb/rWrApCP2VJuq69GJb33oKxrPGcXPtMeCA"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAAEQ	1674210823415	{"key":"hOrSDK0wH4vk2XF8k44R1VXKLlJXxyo+/u72dM1Fkhc","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"vwDRIUX7DpzX+hlyATE8zBvyVrAz1DaM0D8Oxkm1kbs+UrMUrdhS7mP9X/YrewsRw5fTJZUAZkQG/HBUFNMBCg"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAAEA	1674210823415	{"key":"lt3tV1fwYT9lm1hJlgSnd7yV30Eos5F5pgcZ52+OoBE","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"6hK4aKryoEYBfUhYQhDCkaYnPbD18eLwZCmcAQyKABEy5ZMNobdindTGYomR2ONpadryJ3cRbEFaSfKcqw4rBA"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAADw	1674210823415	{"key":"pPmJ7/T0CXeMfSIOHtsrn2ngFaik0n4hBlzXsPB8jSo","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"/mbrl2ypdJy25C1juEVkcDSHnvyctSRrG1ePtjW+gdzKfbxWlbV+Y4giptrW2ZFCoAK0aYtyxXQq2+syfW6CDA"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAADg	1674210823415	{"key":"8kFoIPrtXqR9W36xSPikBFmMAPmPG/gWAYNKFvYcE1M","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"ihfac3Ddl2u1+LvXoAUaltN/8HBJV9U3i2gJgdcfuqeU9S5ASEK3IPgc/iKQIkcY2rlhKivFDT2EbMpAUk/8Dg"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAADQ	1674210823415	{"key":"/SA8h5nV8p+AbdT84AsQ/rmsjcCiRwSBqAdkocNpz34","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"03cRzQGNjgakWa+VeC5GLXKQBCR3CeuIs0yJFMp53rBXnySlMKcDERRJa4t5CKxZpVXrpVOCy1vwK1HGUIWbCQ"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAAFg	1674210823475	{"key":"UpanHPDE7RKVtCBCGasoKo2kbHJsAPzOB36duQqEKXE","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"pwy9I08QlDd92+xdbF5Zt53CNw9I7VZafgZ2Ogp7cdbRAO3RUX1c8vBMB0ZJDLMiId9hi1IYDdiJQ3TR4TZnAA"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAAFQ	1674210823475	{"key":"8N8M9ljExnQtdBDJ7hlBKPO+QtVDzd4oNK6Eo/yN4Cw","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"rWB5AIDstX76ecXbjWhKWiEbKDXVrXuat+DIkG0j3aumIWIfkbc/GfYZ3JkKG1Z3YAwnvdx/pdD253DI3zB6Aw"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAAFA	1674210823475	{"key":"l2FiGViGZYQlfXWM2rE/9L/TXpOSwNXQvN3Dews+vh0","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"dqSXRPop+mxoicBB+T5yQt/mIgesZlhhJGlYN+tJNPNOgxvVHguPkODFe4VsTIVN/VZxjABSnAnyXi3g3wf2DA"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAAEw	1674210823475	{"key":"ej3M2E6OaWSEOdQ23U8y4xZtmfK5UCQkMTYyeFUoZRE","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"6c/Gc+M5ToN9DN00vnCyLJcGWtcck2ObI4fc8BJJKzIbSLVYyIHCTKYd+iIzlp50jn7aFz7+287eMlP2qwPWCA"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAAEg	1674210823475	{"key":"hBEcupr28JBzl6dGCgIBtT6azAODWhwFElUQrcZWHHA","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"cyF2hPgciYV3eKRadmhFf36xxJps6GomWqWqgKjft2dUuZlekGuQKfU/i6q50X3D9oE7cVkwUYKzSkr4u9vlDw"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAAGw	1674210823530	{"key":"1Tyo2wEv1vrWKkcZOEdavCfdX6SA/FT7NmB6gU4NRF0","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"mXiFvcAVneB96IfM3nTlUiwXsswtNr8lVqy6m+F4W74uQpLmJHmVTYVHI0FBRA4ni/K4jxTUHVJ3AYvvnNA/CA"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAAGg	1674210823530	{"key":"WlPqIAAl04QelYM/I2Q/OHGu83UDmCC6njTRoI6eTB0","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"Fh1rTypIfUvtw8rzghzk/vxDxOXGvLNQ7B+cuwVIsK1vk+TH8m8OpYo5uy9u94TEYtflXcXyiRJjUkqaf6qaDA"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAAGQ	1674210823530	{"key":"2wPx2vWaz/tSxJisHlVoNoRKnMd5Dxw7i/DAj5l0PTE","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"HtJCVMNIK0RM7HpVaKeQ0okkf+y+W2B3TSXrQ7bKK121hr+bd6EzRVK9bU8BnpvudafDvPHxgYEzryse1Z42CQ"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAAGA	1674210823530	{"key":"uGHUg3V8qIG9ZRFXYXnD3xlEcf7Hfrd4luBLugYUFwc","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"liSpNJYe8tvNWZoqVx07url9/YaWhEfQBnC93y+TKmZBewiyuieT75we4eWZXZR9vaimf2PvB0SN90I3H5oeCg"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAAFw	1674210823530	{"key":"yn7dFAYnGkCRpKDEV0faXWwpHad51KKX97J4BfN1UQk","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"I5X/9ovZzO4UiTjEzSB52WI8MFJKY1x0vNw2ptFOO1c8Lle+iACWXqG8TEnu0VfRQwJCgreZ98mJkq0bjGRSCQ"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAAIA	1674210823582	{"key":"u3Al8jfcig/A7nTdta0vO/kJxMLbxNwqA+aWLG+rQWs","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"bbaVlTmzRkF/cT+YHcM2eRvmRPJ0ltNXgLkAKvyPMemKxwPxU1fH7KnDKcl+wxluOFgBOsYKE5wnOVn0pSv2CA"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAAHw	1674210823582	{"key":"f3C17AN505caPYsTg2NyBjBQr7zQ8jgz6TgGg5L5nl8","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"Mc43Rm/G/WeSNiXGi1sA1KUCQdLRTCciUt85fCGQIdU2EicrrHAy9jBBIgkmlMcOjfBCbG9DS9APHPujsVF2Dw"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAAHg	1674210823582	{"key":"u+ypJY5NROxYyoBCzOJb5BnI09CwPu5c5i8iRb0wgAw","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"iV8/k4gmKsSs/ORtF4VIQK0SMK9WqTgr7yQm7lysbgTq6EcK5hm7/J5GurrG06M5G3vVo7vmiZs5DjFw8PNRDg"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAAHQ	1674210823582	{"key":"Fq/itVy5eBtRylC3F97xZ7nGOcIqrALtEsUNc6uDMAU","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"vuXqM4Bh+qipRFBMFqQWWoiQuKxKPTs5+nceXeWjw4AObgfIXJp2NzO3RBHIWU5Z+D5gf5gaZBy2iM/2tRMHAw"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAAHA	1674210823582	{"key":"T2753eqZr1FNegTSXXdeUg/wM4F8Dy1/wMBFEa29FUo","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"BIlOdhzJOqm2SnVJCSLVd/7Kn5vHyz5CJIxezJC4pMqq54RXINUjmkNu02SwXaEwRLgZH53OfJA4Th+xu8/6DA"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAAJQ	1674210823641	{"key":"qPpoYs8/l3aP8Vf77ZD8u6A/JwE0xdhsdKCo84iYaUs","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"qhZhCjksKWJVUN9557yO3Ym6stRFNkCUIaHTh7Dp4ToxQN43N+4tkOdnNhE3jOB7HcZD/lxoDUT4zdkinPpTCg"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAAJA	1674210823641	{"key":"cNrDHRcSe6z445YKVnGokQLcg3OwmdRF1DTdmVDlCk0","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"2JbElsgRFqcDgkTofi8J4/CGCihalheiJTUH4r4eMYnzpKtk+uh+HswVgm17P/tjsCurqIMXIK3xiuLxzH3tAA"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAAIw	1674210823641	{"key":"glrKYpTmDY/G3bAdTXM+9JLpaa7++bXQNuaDEtM5pS0","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"YKV8b9eWTw8/45B5Gz9vC+CGQFkRqZd2FZELmukqrfcggBpoMkp7XK3x4QTDQ2ig7t3EhnlQnltzWfbHPSYiCw"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAAIg	1674210823641	{"key":"ym16mdqmeX5fFcg9jKfV44S3YfNQ84NZOIas4TQN51Y","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"zjjAZ81D25tW9W71GgxggoO/uK8lE3t+FrR9NJdUp5ULenuWXG3LZRW8qDSbV6CuiU/BXjequzJY96R1GI+vAw"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAAIQ	1674210823641	{"key":"KAiqzvuALZVHoE2eGOX1mPr8qgLMSIXBJuBJbUAmeEw","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"fBwSq/j+uf7rHbE4w5ME0AUoktFS28JG8hMPC8hCWS10o5C5MywYay9HHAbjMdUNwJe21FXybo05LKg2KYcjBQ"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAAKg	1674210823696	{"key":"NGFg8egUCemjxjuLYaNx46l+TZ4OpdmovqZBgkaHsQI","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"QLhySfiP+4Xrc8yzMd1nt4Ui342I/HmnXENqSIGz+4CQURUuaTKTF7z7QNKQ43k/Gk04wlEsbsm5j7BcSPYUDQ"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAAKQ	1674210823696	{"key":"yR685fgaRAx0f3d0N4+FjeTsMuS0vuWLTQjyZP77bQ4","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"ZHZwrb0YByg0NdNJ/B7MhvjrSAXsoddpyiMA5Jjl0r+kuvMruduo6ilQpInYqPbypUtSBlA6eV9XfEgyIdTXCw"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAAKA	1674210823696	{"key":"22J2nMGlx3u5XUlPdDTtK6LOAvEhYmtrSMtMSj0lUEc","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"C1090411ETf8ygJu9zWYGgxF2a9Hf6oLTpOUZh7AUND3lHavKWNfAFBBohm7o2mnN6jdRKcZ5QGzuadADAi9BA"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAAJw	1674210823696	{"key":"FRtZHV5FvI4DMG5dX9PPx5EuJ+cZPma+doGlWzErTzM","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"OfKO2dVKJqbjUC3bBhpZdIUeGSEtXnCQjLQ6DftCysTYntvh8y8Ssc5fCEhhYnT+8NRd9aA6OJS7HFyQXz9AAg"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAAJg	1674210823696	{"key":"mSIH+8xjjLMVtwXIStY/yHwLL9zBXb9xl4nWfcy8Uk0","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"aZAsY9u1ZN5VFzwOQGpe6uMrVMGZwWAvvewMunFBF14mbE3XXLv92XG9Y5M9T0zA0XnLY48EymmexHFORhVTBQ"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAALw	1674210823780	{"key":"1lc1ynkzg5iKFjKoTdzJ6gv7aimPt3CxWVjrgEV93Co","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"2smDlkQOT+ANfX5ZcD4bseg4W3+wYWf9/iwadzv62SbnSGqpLuN8wJ8HhJBesGg7/vIi7dtxrNxwoo0pQQqXCg"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAALg	1674210823780	{"key":"BRZzSds0dMftsqu+34/KGKhtbp7wEwu7jmZ9+piLbnY","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"jXSpdM48TXoKxU3z9G2BS5N8IZhNj98bOcwUQAN3Ak3NLYdB2Ec8g6SRdbiF7CVxHESRY7v5VIjSU4RzqOB6Bg"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAALQ	1674210823780	{"key":"abWHnGu/UPUMNj2EU/T29Rqd33yqecPInLnzJSwynEE","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"/n1Lx4Z1Fu4ELM1k3TCxNhau8dl/Z4S7afVK4yLpe7qCzhHvEGuVCotspvOZHJFVK9gxdm0YelcUBHjv3h//DA"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAALA	1674210823780	{"key":"xk0TSwbAv8GzhxwDMBB1gc191rW8gXPqI0wsQWapvWw","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"TJF7gwAGGtXdJ8McYisqBG7imb/IxRDyGu54kKhn/R7vIVxyR4eeI42ZKa/tvTT5tGj7UtVFvu+d2N89vBovAg"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAAKw	1674210823780	{"key":"t31DGlC05C0oFaef2W3f/KPFE7X78QRMqMmZY6Xxegk","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"nudTzhL2xN2GogE+F2vgWrQ4/RPXBmRC1qxzrK5N+ausNGhtnGIh5HJPUk+lQfsIoJwT9x1KVn6a6X+fCg1IBA"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAANA	1674210823862	{"key":"Yg0Yt4XrNEseI8thexsioaTohBGPDIZjG093m8X7EmM","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"ep4kHF2ZtCnECJVrOdbXE3Tsl5o9YQnaNtcEJhPCdUlfZXTnimb5k3+RjZXbSzPp5XsUjFcuXixFfEhyXiMgDA"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAAMw	1674210823862	{"key":"I8uI4GyLfZ6yJYzfWDa3k1uymA6yS5yJ3trQheKH9ks","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"rpRFdczXUyXV5pz+l8UsU0MMyVE6RyKzcduA0I2Mdm+V+4mc8TjvhMPxn9rE2doBvZUHnAwAHEbpmL4icBdMCA"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAAMg	1674210823862	{"key":"Zei3g4yTVYyxquwDjRRh9INS1RfYrJDYxg9V9Wzaj3A","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"KD+h+Mo7y47SGRyXKW7htrGumHmGpX8VV9yEisubzAcVvihBmdq9ULjzUbCwV++J6kMmEOCNQZSHzS+RXGpRBA"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAAMQ	1674210823862	{"key":"G0wCetgBdNx6gp0fqILYZ1dGltZJNuMRzmcikDnMZ28","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"4DlqF+qIuNsdHMYImEw2mPMStssPb90VNMhE+Smce7tp6TvQLSoXMy3EZpNWnFmAe9wTikgyWAUSg4HlJplTBg"}}}
@user1.matrix:localhost	GHIOXGFALI	signed_curve25519	AAAAMA	1674210823862	{"key":"i+aca5UkAa4IhAFvpJbCIeYkSat3nJxp1ovESPgD8TE","signatures":{"@user1.matrix:localhost":{"ed25519:GHIOXGFALI":"8uuc7eLOAqCaCA6KiLHmj0V4x6HV5UWeJciGlXI+cA1mpacc4nsBI5EnNjFPdpJxT9iH3ZcNm1MnOmEhZdYYBw"}}}
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
$PkPxRt8GuXFqdWre9vyhqKHlRSqflC0cOSTBOims4qY	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$PkPxRt8GuXFqdWre9vyhqKHlRSqflC0cOSTBOims4qY	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$PkPxRt8GuXFqdWre9vyhqKHlRSqflC0cOSTBOims4qY	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$jyfZsVYOTCt8az1WqRlL53b1lAQWjIj6-IvW1w3qYks	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$jyfZsVYOTCt8az1WqRlL53b1lAQWjIj6-IvW1w3qYks	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$jyfZsVYOTCt8az1WqRlL53b1lAQWjIj6-IvW1w3qYks	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$ARxMI5-TIkg2afPIDJsLgeSqCdrfbwBxm32e83QRfQ4	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$ARxMI5-TIkg2afPIDJsLgeSqCdrfbwBxm32e83QRfQ4	$PkPxRt8GuXFqdWre9vyhqKHlRSqflC0cOSTBOims4qY	!kmbTYjjsDRDHGgVqUP:localhost
$ARxMI5-TIkg2afPIDJsLgeSqCdrfbwBxm32e83QRfQ4	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$ARxMI5-TIkg2afPIDJsLgeSqCdrfbwBxm32e83QRfQ4	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$nE3KmrZJdWnhQ2h6DgIB98qoLGnQlFFCvgSu4NS5FfA	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$nE3KmrZJdWnhQ2h6DgIB98qoLGnQlFFCvgSu4NS5FfA	$jyfZsVYOTCt8az1WqRlL53b1lAQWjIj6-IvW1w3qYks	!dKcbdDATuwwphjRPQP:localhost
$nE3KmrZJdWnhQ2h6DgIB98qoLGnQlFFCvgSu4NS5FfA	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$nE3KmrZJdWnhQ2h6DgIB98qoLGnQlFFCvgSu4NS5FfA	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$mlRlSJ1S_x5OctD_Nck7tq-Fo2IC7iOhysac1uYo_PY	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$mlRlSJ1S_x5OctD_Nck7tq-Fo2IC7iOhysac1uYo_PY	$PkPxRt8GuXFqdWre9vyhqKHlRSqflC0cOSTBOims4qY	!kmbTYjjsDRDHGgVqUP:localhost
$mlRlSJ1S_x5OctD_Nck7tq-Fo2IC7iOhysac1uYo_PY	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$mlRlSJ1S_x5OctD_Nck7tq-Fo2IC7iOhysac1uYo_PY	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$Y86Vdmx2z1nvkEoTqBH7oAiLE_sHPFtNgI97gsUAwaY	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$Y86Vdmx2z1nvkEoTqBH7oAiLE_sHPFtNgI97gsUAwaY	$jyfZsVYOTCt8az1WqRlL53b1lAQWjIj6-IvW1w3qYks	!dKcbdDATuwwphjRPQP:localhost
$Y86Vdmx2z1nvkEoTqBH7oAiLE_sHPFtNgI97gsUAwaY	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$Y86Vdmx2z1nvkEoTqBH7oAiLE_sHPFtNgI97gsUAwaY	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$YHxtZv4JfPzIJvBMvoTgzeITfTFFng_L_4ijJ1Q97k4	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$YHxtZv4JfPzIJvBMvoTgzeITfTFFng_L_4ijJ1Q97k4	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$YHxtZv4JfPzIJvBMvoTgzeITfTFFng_L_4ijJ1Q97k4	$nE3KmrZJdWnhQ2h6DgIB98qoLGnQlFFCvgSu4NS5FfA	!dKcbdDATuwwphjRPQP:localhost
$YHxtZv4JfPzIJvBMvoTgzeITfTFFng_L_4ijJ1Q97k4	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$pXbc3VIu5b4O4VzPRePQd4FjtqYPJLH87Ss7pZM-gRM	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$pXbc3VIu5b4O4VzPRePQd4FjtqYPJLH87Ss7pZM-gRM	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$pXbc3VIu5b4O4VzPRePQd4FjtqYPJLH87Ss7pZM-gRM	$ARxMI5-TIkg2afPIDJsLgeSqCdrfbwBxm32e83QRfQ4	!kmbTYjjsDRDHGgVqUP:localhost
$pXbc3VIu5b4O4VzPRePQd4FjtqYPJLH87Ss7pZM-gRM	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$q7m8fkdDrp2QE9hRAHYIR_KN8htxYXW85pB3LgG-V2U	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$q7m8fkdDrp2QE9hRAHYIR_KN8htxYXW85pB3LgG-V2U	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$q7m8fkdDrp2QE9hRAHYIR_KN8htxYXW85pB3LgG-V2U	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$q7m8fkdDrp2QE9hRAHYIR_KN8htxYXW85pB3LgG-V2U	$mlRlSJ1S_x5OctD_Nck7tq-Fo2IC7iOhysac1uYo_PY	!kmbTYjjsDRDHGgVqUP:localhost
$cH796vSd1hy4UBg8XHAqeUxz-u3gxer-uMeGrsirKbs	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$cH796vSd1hy4UBg8XHAqeUxz-u3gxer-uMeGrsirKbs	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$cH796vSd1hy4UBg8XHAqeUxz-u3gxer-uMeGrsirKbs	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$cH796vSd1hy4UBg8XHAqeUxz-u3gxer-uMeGrsirKbs	$Y86Vdmx2z1nvkEoTqBH7oAiLE_sHPFtNgI97gsUAwaY	!dKcbdDATuwwphjRPQP:localhost
$5DYqRHQPE1SQt9QXHJodWH7x4Pztz3LTsgH1kdHawZs	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$5DYqRHQPE1SQt9QXHJodWH7x4Pztz3LTsgH1kdHawZs	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$5DYqRHQPE1SQt9QXHJodWH7x4Pztz3LTsgH1kdHawZs	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$TKcINA6W5qTH8raDaFqEMBivZ0LjgXtIHGvxzJ9V4_8	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$TKcINA6W5qTH8raDaFqEMBivZ0LjgXtIHGvxzJ9V4_8	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$TKcINA6W5qTH8raDaFqEMBivZ0LjgXtIHGvxzJ9V4_8	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$REN0AaEE212pFbK8uJB-22lyjpnqTEP0SshUeVfsGU4	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$REN0AaEE212pFbK8uJB-22lyjpnqTEP0SshUeVfsGU4	$jyfZsVYOTCt8az1WqRlL53b1lAQWjIj6-IvW1w3qYks	!dKcbdDATuwwphjRPQP:localhost
$REN0AaEE212pFbK8uJB-22lyjpnqTEP0SshUeVfsGU4	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$REN0AaEE212pFbK8uJB-22lyjpnqTEP0SshUeVfsGU4	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$AwutniYNkYl6Dxs-8zYvdPdGLIcM4Kyzaldut5D0jHQ	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	!dKcbdDATuwwphjRPQP:localhost
$AwutniYNkYl6Dxs-8zYvdPdGLIcM4Kyzaldut5D0jHQ	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	!dKcbdDATuwwphjRPQP:localhost
$AwutniYNkYl6Dxs-8zYvdPdGLIcM4Kyzaldut5D0jHQ	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	!dKcbdDATuwwphjRPQP:localhost
$AwutniYNkYl6Dxs-8zYvdPdGLIcM4Kyzaldut5D0jHQ	$REN0AaEE212pFbK8uJB-22lyjpnqTEP0SshUeVfsGU4	!dKcbdDATuwwphjRPQP:localhost
$HmGCTcPZGDbaswAPjYZ0ddKt1eWRcRq89rE-yVwDV0s	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$HmGCTcPZGDbaswAPjYZ0ddKt1eWRcRq89rE-yVwDV0s	$PkPxRt8GuXFqdWre9vyhqKHlRSqflC0cOSTBOims4qY	!kmbTYjjsDRDHGgVqUP:localhost
$HmGCTcPZGDbaswAPjYZ0ddKt1eWRcRq89rE-yVwDV0s	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$HmGCTcPZGDbaswAPjYZ0ddKt1eWRcRq89rE-yVwDV0s	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$VFMUBSkD_jWG8nImBQfkmffKyLBdxGMpdkFACHA33Ng	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	!kmbTYjjsDRDHGgVqUP:localhost
$VFMUBSkD_jWG8nImBQfkmffKyLBdxGMpdkFACHA33Ng	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	!kmbTYjjsDRDHGgVqUP:localhost
$VFMUBSkD_jWG8nImBQfkmffKyLBdxGMpdkFACHA33Ng	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	!kmbTYjjsDRDHGgVqUP:localhost
$VFMUBSkD_jWG8nImBQfkmffKyLBdxGMpdkFACHA33Ng	$HmGCTcPZGDbaswAPjYZ0ddKt1eWRcRq89rE-yVwDV0s	!kmbTYjjsDRDHGgVqUP:localhost
$7N18oPwd46twVh-RWhED6VAPm79aIXVCh_BVUFAFHP8	$NfGFxRqIrSmaeLcN53BGirnWzJ1bpwzVyt2oZw2cj1k	!BfSgfecvJnYoZjTYRA:localhost
$eKvf8PFaZwsEOXW-IIYTGZwl6gxEYmEE2TalB5k2iGs	$7N18oPwd46twVh-RWhED6VAPm79aIXVCh_BVUFAFHP8	!BfSgfecvJnYoZjTYRA:localhost
$eKvf8PFaZwsEOXW-IIYTGZwl6gxEYmEE2TalB5k2iGs	$NfGFxRqIrSmaeLcN53BGirnWzJ1bpwzVyt2oZw2cj1k	!BfSgfecvJnYoZjTYRA:localhost
$ZraIWv18CC1pTAGQZToI1ZXr7ki_53OY_jvQl0RDE_A	$7N18oPwd46twVh-RWhED6VAPm79aIXVCh_BVUFAFHP8	!BfSgfecvJnYoZjTYRA:localhost
$ZraIWv18CC1pTAGQZToI1ZXr7ki_53OY_jvQl0RDE_A	$eKvf8PFaZwsEOXW-IIYTGZwl6gxEYmEE2TalB5k2iGs	!BfSgfecvJnYoZjTYRA:localhost
$ZraIWv18CC1pTAGQZToI1ZXr7ki_53OY_jvQl0RDE_A	$NfGFxRqIrSmaeLcN53BGirnWzJ1bpwzVyt2oZw2cj1k	!BfSgfecvJnYoZjTYRA:localhost
$Uf6bLI9lxBnR9TJvz8fcfo-1_wbshzMvT4Ecr_qy-E4	$7N18oPwd46twVh-RWhED6VAPm79aIXVCh_BVUFAFHP8	!BfSgfecvJnYoZjTYRA:localhost
$Uf6bLI9lxBnR9TJvz8fcfo-1_wbshzMvT4Ecr_qy-E4	$eKvf8PFaZwsEOXW-IIYTGZwl6gxEYmEE2TalB5k2iGs	!BfSgfecvJnYoZjTYRA:localhost
$Uf6bLI9lxBnR9TJvz8fcfo-1_wbshzMvT4Ecr_qy-E4	$NfGFxRqIrSmaeLcN53BGirnWzJ1bpwzVyt2oZw2cj1k	!BfSgfecvJnYoZjTYRA:localhost
$30q15kBxfYB9Dyc1sAhoNXYpZXfDlneq4Ckvuz_Sy1Y	$7N18oPwd46twVh-RWhED6VAPm79aIXVCh_BVUFAFHP8	!BfSgfecvJnYoZjTYRA:localhost
$30q15kBxfYB9Dyc1sAhoNXYpZXfDlneq4Ckvuz_Sy1Y	$eKvf8PFaZwsEOXW-IIYTGZwl6gxEYmEE2TalB5k2iGs	!BfSgfecvJnYoZjTYRA:localhost
$30q15kBxfYB9Dyc1sAhoNXYpZXfDlneq4Ckvuz_Sy1Y	$NfGFxRqIrSmaeLcN53BGirnWzJ1bpwzVyt2oZw2cj1k	!BfSgfecvJnYoZjTYRA:localhost
$wlATKVSoZpEXfwFpmdptZK6V2TMFQ87Bjjhru1P3dGs	$7N18oPwd46twVh-RWhED6VAPm79aIXVCh_BVUFAFHP8	!BfSgfecvJnYoZjTYRA:localhost
$wlATKVSoZpEXfwFpmdptZK6V2TMFQ87Bjjhru1P3dGs	$eKvf8PFaZwsEOXW-IIYTGZwl6gxEYmEE2TalB5k2iGs	!BfSgfecvJnYoZjTYRA:localhost
$wlATKVSoZpEXfwFpmdptZK6V2TMFQ87Bjjhru1P3dGs	$NfGFxRqIrSmaeLcN53BGirnWzJ1bpwzVyt2oZw2cj1k	!BfSgfecvJnYoZjTYRA:localhost
$PZkmtd-Zj4an2Acc9O8V-mK2mVxXChviZhd_hsf6Ehg	$7N18oPwd46twVh-RWhED6VAPm79aIXVCh_BVUFAFHP8	!BfSgfecvJnYoZjTYRA:localhost
$PZkmtd-Zj4an2Acc9O8V-mK2mVxXChviZhd_hsf6Ehg	$eKvf8PFaZwsEOXW-IIYTGZwl6gxEYmEE2TalB5k2iGs	!BfSgfecvJnYoZjTYRA:localhost
$PZkmtd-Zj4an2Acc9O8V-mK2mVxXChviZhd_hsf6Ehg	$NfGFxRqIrSmaeLcN53BGirnWzJ1bpwzVyt2oZw2cj1k	!BfSgfecvJnYoZjTYRA:localhost
$PZkmtd-Zj4an2Acc9O8V-mK2mVxXChviZhd_hsf6Ehg	$Uf6bLI9lxBnR9TJvz8fcfo-1_wbshzMvT4Ecr_qy-E4	!BfSgfecvJnYoZjTYRA:localhost
$bWqW6N4T6ZlJ3MzEaI-MgqdvMEklGrNsy22WqL6ZgOc	$pIVIlPgvO-fbiW31dx4GB-wsRX4DrbADDn1AfJoXI50	!pWsdJYvpdmDULVhQtX:localhost
$ngKTLt0SDFtdjkF6GnjahEcDA-qLwTKRcVgMgMg5tN8	$bWqW6N4T6ZlJ3MzEaI-MgqdvMEklGrNsy22WqL6ZgOc	!pWsdJYvpdmDULVhQtX:localhost
$ngKTLt0SDFtdjkF6GnjahEcDA-qLwTKRcVgMgMg5tN8	$pIVIlPgvO-fbiW31dx4GB-wsRX4DrbADDn1AfJoXI50	!pWsdJYvpdmDULVhQtX:localhost
$7qFBn6lW7C0hRYBTRjR0tsE8qpZmodqh6LOyLL0HMnQ	$bWqW6N4T6ZlJ3MzEaI-MgqdvMEklGrNsy22WqL6ZgOc	!pWsdJYvpdmDULVhQtX:localhost
$7qFBn6lW7C0hRYBTRjR0tsE8qpZmodqh6LOyLL0HMnQ	$ngKTLt0SDFtdjkF6GnjahEcDA-qLwTKRcVgMgMg5tN8	!pWsdJYvpdmDULVhQtX:localhost
$7qFBn6lW7C0hRYBTRjR0tsE8qpZmodqh6LOyLL0HMnQ	$pIVIlPgvO-fbiW31dx4GB-wsRX4DrbADDn1AfJoXI50	!pWsdJYvpdmDULVhQtX:localhost
$IxyNn3A4NegMug4xc7O0sm2s1r9jyybU5iNogwEGesQ	$bWqW6N4T6ZlJ3MzEaI-MgqdvMEklGrNsy22WqL6ZgOc	!pWsdJYvpdmDULVhQtX:localhost
$IxyNn3A4NegMug4xc7O0sm2s1r9jyybU5iNogwEGesQ	$ngKTLt0SDFtdjkF6GnjahEcDA-qLwTKRcVgMgMg5tN8	!pWsdJYvpdmDULVhQtX:localhost
$IxyNn3A4NegMug4xc7O0sm2s1r9jyybU5iNogwEGesQ	$pIVIlPgvO-fbiW31dx4GB-wsRX4DrbADDn1AfJoXI50	!pWsdJYvpdmDULVhQtX:localhost
$SQpUzgCCeFIrGC3eCPDX_U021w7MG0-lHOxFTcHbvKk	$bWqW6N4T6ZlJ3MzEaI-MgqdvMEklGrNsy22WqL6ZgOc	!pWsdJYvpdmDULVhQtX:localhost
$SQpUzgCCeFIrGC3eCPDX_U021w7MG0-lHOxFTcHbvKk	$ngKTLt0SDFtdjkF6GnjahEcDA-qLwTKRcVgMgMg5tN8	!pWsdJYvpdmDULVhQtX:localhost
$SQpUzgCCeFIrGC3eCPDX_U021w7MG0-lHOxFTcHbvKk	$pIVIlPgvO-fbiW31dx4GB-wsRX4DrbADDn1AfJoXI50	!pWsdJYvpdmDULVhQtX:localhost
$pe2Yi2ila5QgzVKIEGGAIeqvcRaD37GUFMvAOWX2tp0	$bWqW6N4T6ZlJ3MzEaI-MgqdvMEklGrNsy22WqL6ZgOc	!pWsdJYvpdmDULVhQtX:localhost
$pe2Yi2ila5QgzVKIEGGAIeqvcRaD37GUFMvAOWX2tp0	$ngKTLt0SDFtdjkF6GnjahEcDA-qLwTKRcVgMgMg5tN8	!pWsdJYvpdmDULVhQtX:localhost
$pe2Yi2ila5QgzVKIEGGAIeqvcRaD37GUFMvAOWX2tp0	$pIVIlPgvO-fbiW31dx4GB-wsRX4DrbADDn1AfJoXI50	!pWsdJYvpdmDULVhQtX:localhost
$_MdWHbg9mI3zN-WDGIpwDRJZmDWXBeW-m3WrJiRs4t8	$bWqW6N4T6ZlJ3MzEaI-MgqdvMEklGrNsy22WqL6ZgOc	!pWsdJYvpdmDULVhQtX:localhost
$_MdWHbg9mI3zN-WDGIpwDRJZmDWXBeW-m3WrJiRs4t8	$ngKTLt0SDFtdjkF6GnjahEcDA-qLwTKRcVgMgMg5tN8	!pWsdJYvpdmDULVhQtX:localhost
$_MdWHbg9mI3zN-WDGIpwDRJZmDWXBeW-m3WrJiRs4t8	$pIVIlPgvO-fbiW31dx4GB-wsRX4DrbADDn1AfJoXI50	!pWsdJYvpdmDULVhQtX:localhost
$d7sJ6Squy3gHlaCn4UxGeu_9AcN2XCBHtBIY8VL5d_g	$bWqW6N4T6ZlJ3MzEaI-MgqdvMEklGrNsy22WqL6ZgOc	!pWsdJYvpdmDULVhQtX:localhost
$d7sJ6Squy3gHlaCn4UxGeu_9AcN2XCBHtBIY8VL5d_g	$ngKTLt0SDFtdjkF6GnjahEcDA-qLwTKRcVgMgMg5tN8	!pWsdJYvpdmDULVhQtX:localhost
$d7sJ6Squy3gHlaCn4UxGeu_9AcN2XCBHtBIY8VL5d_g	$pIVIlPgvO-fbiW31dx4GB-wsRX4DrbADDn1AfJoXI50	!pWsdJYvpdmDULVhQtX:localhost
$d7sJ6Squy3gHlaCn4UxGeu_9AcN2XCBHtBIY8VL5d_g	$SQpUzgCCeFIrGC3eCPDX_U021w7MG0-lHOxFTcHbvKk	!pWsdJYvpdmDULVhQtX:localhost
$8lVZQlOM-qXD0dT5ZSbvlEPAQPq5wJHU8KqM6sLfmWM	$bWqW6N4T6ZlJ3MzEaI-MgqdvMEklGrNsy22WqL6ZgOc	!pWsdJYvpdmDULVhQtX:localhost
$8lVZQlOM-qXD0dT5ZSbvlEPAQPq5wJHU8KqM6sLfmWM	$ngKTLt0SDFtdjkF6GnjahEcDA-qLwTKRcVgMgMg5tN8	!pWsdJYvpdmDULVhQtX:localhost
$8lVZQlOM-qXD0dT5ZSbvlEPAQPq5wJHU8KqM6sLfmWM	$pIVIlPgvO-fbiW31dx4GB-wsRX4DrbADDn1AfJoXI50	!pWsdJYvpdmDULVhQtX:localhost
$OsJU_fxidXD79b8VmXNcxdAdUkhXO3S73zUBYUa3yG8	$bWqW6N4T6ZlJ3MzEaI-MgqdvMEklGrNsy22WqL6ZgOc	!pWsdJYvpdmDULVhQtX:localhost
$OsJU_fxidXD79b8VmXNcxdAdUkhXO3S73zUBYUa3yG8	$ngKTLt0SDFtdjkF6GnjahEcDA-qLwTKRcVgMgMg5tN8	!pWsdJYvpdmDULVhQtX:localhost
$OsJU_fxidXD79b8VmXNcxdAdUkhXO3S73zUBYUa3yG8	$pIVIlPgvO-fbiW31dx4GB-wsRX4DrbADDn1AfJoXI50	!pWsdJYvpdmDULVhQtX:localhost
$76OhaN_mof41kiqxA-qZV26DgKxkvkl8JwQjOYqZF1A	$7N18oPwd46twVh-RWhED6VAPm79aIXVCh_BVUFAFHP8	!BfSgfecvJnYoZjTYRA:localhost
$76OhaN_mof41kiqxA-qZV26DgKxkvkl8JwQjOYqZF1A	$eKvf8PFaZwsEOXW-IIYTGZwl6gxEYmEE2TalB5k2iGs	!BfSgfecvJnYoZjTYRA:localhost
$76OhaN_mof41kiqxA-qZV26DgKxkvkl8JwQjOYqZF1A	$NfGFxRqIrSmaeLcN53BGirnWzJ1bpwzVyt2oZw2cj1k	!BfSgfecvJnYoZjTYRA:localhost
$76OhaN_mof41kiqxA-qZV26DgKxkvkl8JwQjOYqZF1A	$Uf6bLI9lxBnR9TJvz8fcfo-1_wbshzMvT4Ecr_qy-E4	!BfSgfecvJnYoZjTYRA:localhost
$Ip3uw4uae3e7xwaJ6BU2ppE2nWhA0Zyb0KZDNvHAdmU	$XhE1A2QtMIi_b9SfK9jbadCTQ4Xd5IZxBaUOcfglbIA	!cUrTzQWGYNmZYMHoGB:localhost
$nofByIO1FFs8JcKVqFZb7ulSmWdVGm_V-3n-LceVmnw	$Ip3uw4uae3e7xwaJ6BU2ppE2nWhA0Zyb0KZDNvHAdmU	!cUrTzQWGYNmZYMHoGB:localhost
$nofByIO1FFs8JcKVqFZb7ulSmWdVGm_V-3n-LceVmnw	$XhE1A2QtMIi_b9SfK9jbadCTQ4Xd5IZxBaUOcfglbIA	!cUrTzQWGYNmZYMHoGB:localhost
$wtg0qf-MdY5Ur4UMAlOlQ58df82OmKhsbTS81ItsAT8	$Ip3uw4uae3e7xwaJ6BU2ppE2nWhA0Zyb0KZDNvHAdmU	!cUrTzQWGYNmZYMHoGB:localhost
$wtg0qf-MdY5Ur4UMAlOlQ58df82OmKhsbTS81ItsAT8	$nofByIO1FFs8JcKVqFZb7ulSmWdVGm_V-3n-LceVmnw	!cUrTzQWGYNmZYMHoGB:localhost
$wtg0qf-MdY5Ur4UMAlOlQ58df82OmKhsbTS81ItsAT8	$XhE1A2QtMIi_b9SfK9jbadCTQ4Xd5IZxBaUOcfglbIA	!cUrTzQWGYNmZYMHoGB:localhost
$DFCNP6Tt2ypS8tXyd5kaCiqWeVDmE_FL-iOprkrfubk	$Ip3uw4uae3e7xwaJ6BU2ppE2nWhA0Zyb0KZDNvHAdmU	!cUrTzQWGYNmZYMHoGB:localhost
$DFCNP6Tt2ypS8tXyd5kaCiqWeVDmE_FL-iOprkrfubk	$nofByIO1FFs8JcKVqFZb7ulSmWdVGm_V-3n-LceVmnw	!cUrTzQWGYNmZYMHoGB:localhost
$DFCNP6Tt2ypS8tXyd5kaCiqWeVDmE_FL-iOprkrfubk	$XhE1A2QtMIi_b9SfK9jbadCTQ4Xd5IZxBaUOcfglbIA	!cUrTzQWGYNmZYMHoGB:localhost
$MJ2YTkP3f-eQwc5HLB6GVzjnPJaVov0pUCfq1bWqG3M	$Ip3uw4uae3e7xwaJ6BU2ppE2nWhA0Zyb0KZDNvHAdmU	!cUrTzQWGYNmZYMHoGB:localhost
$MJ2YTkP3f-eQwc5HLB6GVzjnPJaVov0pUCfq1bWqG3M	$nofByIO1FFs8JcKVqFZb7ulSmWdVGm_V-3n-LceVmnw	!cUrTzQWGYNmZYMHoGB:localhost
$MJ2YTkP3f-eQwc5HLB6GVzjnPJaVov0pUCfq1bWqG3M	$XhE1A2QtMIi_b9SfK9jbadCTQ4Xd5IZxBaUOcfglbIA	!cUrTzQWGYNmZYMHoGB:localhost
$iAAlBelGypnsbVKn9Fd-ubLNje326TRpaegoLLyRZGY	$Ip3uw4uae3e7xwaJ6BU2ppE2nWhA0Zyb0KZDNvHAdmU	!cUrTzQWGYNmZYMHoGB:localhost
$iAAlBelGypnsbVKn9Fd-ubLNje326TRpaegoLLyRZGY	$nofByIO1FFs8JcKVqFZb7ulSmWdVGm_V-3n-LceVmnw	!cUrTzQWGYNmZYMHoGB:localhost
$iAAlBelGypnsbVKn9Fd-ubLNje326TRpaegoLLyRZGY	$XhE1A2QtMIi_b9SfK9jbadCTQ4Xd5IZxBaUOcfglbIA	!cUrTzQWGYNmZYMHoGB:localhost
$34bSEXw9U2DTNkZA2he27rczptl3jni1oG64GRRYkfY	$Ip3uw4uae3e7xwaJ6BU2ppE2nWhA0Zyb0KZDNvHAdmU	!cUrTzQWGYNmZYMHoGB:localhost
$34bSEXw9U2DTNkZA2he27rczptl3jni1oG64GRRYkfY	$nofByIO1FFs8JcKVqFZb7ulSmWdVGm_V-3n-LceVmnw	!cUrTzQWGYNmZYMHoGB:localhost
$34bSEXw9U2DTNkZA2he27rczptl3jni1oG64GRRYkfY	$XhE1A2QtMIi_b9SfK9jbadCTQ4Xd5IZxBaUOcfglbIA	!cUrTzQWGYNmZYMHoGB:localhost
$SFXqj2UcfZU2XtnGBtupMwsoI3Z5JLp-7mmR2PU4MjQ	$Ip3uw4uae3e7xwaJ6BU2ppE2nWhA0Zyb0KZDNvHAdmU	!cUrTzQWGYNmZYMHoGB:localhost
$SFXqj2UcfZU2XtnGBtupMwsoI3Z5JLp-7mmR2PU4MjQ	$nofByIO1FFs8JcKVqFZb7ulSmWdVGm_V-3n-LceVmnw	!cUrTzQWGYNmZYMHoGB:localhost
$SFXqj2UcfZU2XtnGBtupMwsoI3Z5JLp-7mmR2PU4MjQ	$XhE1A2QtMIi_b9SfK9jbadCTQ4Xd5IZxBaUOcfglbIA	!cUrTzQWGYNmZYMHoGB:localhost
$Z-W9-QEq_roRPUfFFGrVn3vc_d4uekRlcsL3uBSdDpM	$VI4y-gfFPbzFuAM6S6F4gXfpeWta-thThcGlPN0xQN0	!FSwSlJXpOZZONTVfGs:localhost
$uDBLcAyAHq3swiKjGlyKYFZwIrP5Ux8Ki1qU7x3aVsY	$A45QtHYoTPEA17jEFQZ4U882WGuYFA2D4xiKqwnZyUs	!JGJhGNDoMdRLJzLgcJ:localhost
$RRFtexNdS-wxfmZgcU9kk5Lyp462lIuVu6piimDKCGA	$LnGTvN89zWMaGdr_8T22TNwZ8hCnAeMlGOMaGpCPahE	!hccoYOyrWRMEhMnaoh:localhost
$nMtE3MPK3rxeHXzgEF1GWQXqF1Of8IqoWwPKejXxdrg	$RRFtexNdS-wxfmZgcU9kk5Lyp462lIuVu6piimDKCGA	!hccoYOyrWRMEhMnaoh:localhost
$nMtE3MPK3rxeHXzgEF1GWQXqF1Of8IqoWwPKejXxdrg	$LnGTvN89zWMaGdr_8T22TNwZ8hCnAeMlGOMaGpCPahE	!hccoYOyrWRMEhMnaoh:localhost
$4MpBsW-eFJ4SoVP-rLgkefjkNR0Sytuayop2Z-OBFzU	$RRFtexNdS-wxfmZgcU9kk5Lyp462lIuVu6piimDKCGA	!hccoYOyrWRMEhMnaoh:localhost
$4MpBsW-eFJ4SoVP-rLgkefjkNR0Sytuayop2Z-OBFzU	$nMtE3MPK3rxeHXzgEF1GWQXqF1Of8IqoWwPKejXxdrg	!hccoYOyrWRMEhMnaoh:localhost
$4MpBsW-eFJ4SoVP-rLgkefjkNR0Sytuayop2Z-OBFzU	$LnGTvN89zWMaGdr_8T22TNwZ8hCnAeMlGOMaGpCPahE	!hccoYOyrWRMEhMnaoh:localhost
$5QgMOlhzvtIooZVNYnMnchsgiEUDObBacU41JO2zKs0	$RRFtexNdS-wxfmZgcU9kk5Lyp462lIuVu6piimDKCGA	!hccoYOyrWRMEhMnaoh:localhost
$5QgMOlhzvtIooZVNYnMnchsgiEUDObBacU41JO2zKs0	$nMtE3MPK3rxeHXzgEF1GWQXqF1Of8IqoWwPKejXxdrg	!hccoYOyrWRMEhMnaoh:localhost
$5QgMOlhzvtIooZVNYnMnchsgiEUDObBacU41JO2zKs0	$LnGTvN89zWMaGdr_8T22TNwZ8hCnAeMlGOMaGpCPahE	!hccoYOyrWRMEhMnaoh:localhost
$NYaJba-K1Im8n6_Z7mL0VwgIAKxZqouzTTYu6EcK5eM	$RRFtexNdS-wxfmZgcU9kk5Lyp462lIuVu6piimDKCGA	!hccoYOyrWRMEhMnaoh:localhost
$NYaJba-K1Im8n6_Z7mL0VwgIAKxZqouzTTYu6EcK5eM	$nMtE3MPK3rxeHXzgEF1GWQXqF1Of8IqoWwPKejXxdrg	!hccoYOyrWRMEhMnaoh:localhost
$NYaJba-K1Im8n6_Z7mL0VwgIAKxZqouzTTYu6EcK5eM	$LnGTvN89zWMaGdr_8T22TNwZ8hCnAeMlGOMaGpCPahE	!hccoYOyrWRMEhMnaoh:localhost
$-FXdMAkllHkSbPP-QDGsb_zIuCwPKR511zZahmMGKs4	$RRFtexNdS-wxfmZgcU9kk5Lyp462lIuVu6piimDKCGA	!hccoYOyrWRMEhMnaoh:localhost
$-FXdMAkllHkSbPP-QDGsb_zIuCwPKR511zZahmMGKs4	$nMtE3MPK3rxeHXzgEF1GWQXqF1Of8IqoWwPKejXxdrg	!hccoYOyrWRMEhMnaoh:localhost
$-FXdMAkllHkSbPP-QDGsb_zIuCwPKR511zZahmMGKs4	$LnGTvN89zWMaGdr_8T22TNwZ8hCnAeMlGOMaGpCPahE	!hccoYOyrWRMEhMnaoh:localhost
$sUchhgur-fFKVUmMUaBERmjM3ItMz4-8bhkuD7UXnuU	$RRFtexNdS-wxfmZgcU9kk5Lyp462lIuVu6piimDKCGA	!hccoYOyrWRMEhMnaoh:localhost
$sUchhgur-fFKVUmMUaBERmjM3ItMz4-8bhkuD7UXnuU	$nMtE3MPK3rxeHXzgEF1GWQXqF1Of8IqoWwPKejXxdrg	!hccoYOyrWRMEhMnaoh:localhost
$sUchhgur-fFKVUmMUaBERmjM3ItMz4-8bhkuD7UXnuU	$LnGTvN89zWMaGdr_8T22TNwZ8hCnAeMlGOMaGpCPahE	!hccoYOyrWRMEhMnaoh:localhost
$OUsS0radBRPS3B8beUIJ1TUjFMPXJ0OTtSau2wSu6rY	$Ip3uw4uae3e7xwaJ6BU2ppE2nWhA0Zyb0KZDNvHAdmU	!cUrTzQWGYNmZYMHoGB:localhost
$OUsS0radBRPS3B8beUIJ1TUjFMPXJ0OTtSau2wSu6rY	$nofByIO1FFs8JcKVqFZb7ulSmWdVGm_V-3n-LceVmnw	!cUrTzQWGYNmZYMHoGB:localhost
$OUsS0radBRPS3B8beUIJ1TUjFMPXJ0OTtSau2wSu6rY	$XhE1A2QtMIi_b9SfK9jbadCTQ4Xd5IZxBaUOcfglbIA	!cUrTzQWGYNmZYMHoGB:localhost
$z3x2QWsqd2WeWbha161nzCLfGv7psz2SV_Gveo8B5Yk	$Ip3uw4uae3e7xwaJ6BU2ppE2nWhA0Zyb0KZDNvHAdmU	!cUrTzQWGYNmZYMHoGB:localhost
$z3x2QWsqd2WeWbha161nzCLfGv7psz2SV_Gveo8B5Yk	$nofByIO1FFs8JcKVqFZb7ulSmWdVGm_V-3n-LceVmnw	!cUrTzQWGYNmZYMHoGB:localhost
$z3x2QWsqd2WeWbha161nzCLfGv7psz2SV_Gveo8B5Yk	$XhE1A2QtMIi_b9SfK9jbadCTQ4Xd5IZxBaUOcfglbIA	!cUrTzQWGYNmZYMHoGB:localhost
$MLY05F5LyQaOuJw4avembMABTu_CtFuQyhyiF14QtYo	$uDBLcAyAHq3swiKjGlyKYFZwIrP5Ux8Ki1qU7x3aVsY	!JGJhGNDoMdRLJzLgcJ:localhost
$MLY05F5LyQaOuJw4avembMABTu_CtFuQyhyiF14QtYo	$A45QtHYoTPEA17jEFQZ4U882WGuYFA2D4xiKqwnZyUs	!JGJhGNDoMdRLJzLgcJ:localhost
$e6pVgV1MsH-6_A1V_vGWGmdznPg_czNOfblinyTHshA	$uDBLcAyAHq3swiKjGlyKYFZwIrP5Ux8Ki1qU7x3aVsY	!JGJhGNDoMdRLJzLgcJ:localhost
$e6pVgV1MsH-6_A1V_vGWGmdznPg_czNOfblinyTHshA	$MLY05F5LyQaOuJw4avembMABTu_CtFuQyhyiF14QtYo	!JGJhGNDoMdRLJzLgcJ:localhost
$e6pVgV1MsH-6_A1V_vGWGmdznPg_czNOfblinyTHshA	$A45QtHYoTPEA17jEFQZ4U882WGuYFA2D4xiKqwnZyUs	!JGJhGNDoMdRLJzLgcJ:localhost
$hNUZNFVPWjQzoWmc5wymfJzaTuaIdxyWFsi3fkTJ534	$uDBLcAyAHq3swiKjGlyKYFZwIrP5Ux8Ki1qU7x3aVsY	!JGJhGNDoMdRLJzLgcJ:localhost
$hNUZNFVPWjQzoWmc5wymfJzaTuaIdxyWFsi3fkTJ534	$MLY05F5LyQaOuJw4avembMABTu_CtFuQyhyiF14QtYo	!JGJhGNDoMdRLJzLgcJ:localhost
$hNUZNFVPWjQzoWmc5wymfJzaTuaIdxyWFsi3fkTJ534	$A45QtHYoTPEA17jEFQZ4U882WGuYFA2D4xiKqwnZyUs	!JGJhGNDoMdRLJzLgcJ:localhost
$IYkBkm-ncU_4Z-Ft8v80LsrK5kKpzGKpHDUWZxxy6t8	$uDBLcAyAHq3swiKjGlyKYFZwIrP5Ux8Ki1qU7x3aVsY	!JGJhGNDoMdRLJzLgcJ:localhost
$IYkBkm-ncU_4Z-Ft8v80LsrK5kKpzGKpHDUWZxxy6t8	$MLY05F5LyQaOuJw4avembMABTu_CtFuQyhyiF14QtYo	!JGJhGNDoMdRLJzLgcJ:localhost
$IYkBkm-ncU_4Z-Ft8v80LsrK5kKpzGKpHDUWZxxy6t8	$A45QtHYoTPEA17jEFQZ4U882WGuYFA2D4xiKqwnZyUs	!JGJhGNDoMdRLJzLgcJ:localhost
$JfR9TVM-sEe4hZ5-0bIni5e5m_tLlX2HdSU6u6IoVBM	$uDBLcAyAHq3swiKjGlyKYFZwIrP5Ux8Ki1qU7x3aVsY	!JGJhGNDoMdRLJzLgcJ:localhost
$JfR9TVM-sEe4hZ5-0bIni5e5m_tLlX2HdSU6u6IoVBM	$MLY05F5LyQaOuJw4avembMABTu_CtFuQyhyiF14QtYo	!JGJhGNDoMdRLJzLgcJ:localhost
$JfR9TVM-sEe4hZ5-0bIni5e5m_tLlX2HdSU6u6IoVBM	$A45QtHYoTPEA17jEFQZ4U882WGuYFA2D4xiKqwnZyUs	!JGJhGNDoMdRLJzLgcJ:localhost
$4ywygf1-17_Kq3j230bjqgAjdpc67zV0hIv7Uw6BKtA	$Z-W9-QEq_roRPUfFFGrVn3vc_d4uekRlcsL3uBSdDpM	!FSwSlJXpOZZONTVfGs:localhost
$4ywygf1-17_Kq3j230bjqgAjdpc67zV0hIv7Uw6BKtA	$VI4y-gfFPbzFuAM6S6F4gXfpeWta-thThcGlPN0xQN0	!FSwSlJXpOZZONTVfGs:localhost
$CjB4vCnMjTm70a0EahGjB5FN8EKtrdWl7F12gA2FhDo	$Z-W9-QEq_roRPUfFFGrVn3vc_d4uekRlcsL3uBSdDpM	!FSwSlJXpOZZONTVfGs:localhost
$CjB4vCnMjTm70a0EahGjB5FN8EKtrdWl7F12gA2FhDo	$4ywygf1-17_Kq3j230bjqgAjdpc67zV0hIv7Uw6BKtA	!FSwSlJXpOZZONTVfGs:localhost
$CjB4vCnMjTm70a0EahGjB5FN8EKtrdWl7F12gA2FhDo	$VI4y-gfFPbzFuAM6S6F4gXfpeWta-thThcGlPN0xQN0	!FSwSlJXpOZZONTVfGs:localhost
$Y_182-w64pn902ATtlukjIsNSzVBtF9fw_aMYWx9DdY	$Z-W9-QEq_roRPUfFFGrVn3vc_d4uekRlcsL3uBSdDpM	!FSwSlJXpOZZONTVfGs:localhost
$Y_182-w64pn902ATtlukjIsNSzVBtF9fw_aMYWx9DdY	$4ywygf1-17_Kq3j230bjqgAjdpc67zV0hIv7Uw6BKtA	!FSwSlJXpOZZONTVfGs:localhost
$Y_182-w64pn902ATtlukjIsNSzVBtF9fw_aMYWx9DdY	$VI4y-gfFPbzFuAM6S6F4gXfpeWta-thThcGlPN0xQN0	!FSwSlJXpOZZONTVfGs:localhost
$27FTfsExd-igZozi1nKpy5Iyqayuxc3DZY9LFN9e6oo	$Z-W9-QEq_roRPUfFFGrVn3vc_d4uekRlcsL3uBSdDpM	!FSwSlJXpOZZONTVfGs:localhost
$27FTfsExd-igZozi1nKpy5Iyqayuxc3DZY9LFN9e6oo	$4ywygf1-17_Kq3j230bjqgAjdpc67zV0hIv7Uw6BKtA	!FSwSlJXpOZZONTVfGs:localhost
$27FTfsExd-igZozi1nKpy5Iyqayuxc3DZY9LFN9e6oo	$VI4y-gfFPbzFuAM6S6F4gXfpeWta-thThcGlPN0xQN0	!FSwSlJXpOZZONTVfGs:localhost
$33Pk__-gU3AslKMgHWQqdrgfvEhGtn4nPTRaDuhZUC0	$Z-W9-QEq_roRPUfFFGrVn3vc_d4uekRlcsL3uBSdDpM	!FSwSlJXpOZZONTVfGs:localhost
$33Pk__-gU3AslKMgHWQqdrgfvEhGtn4nPTRaDuhZUC0	$4ywygf1-17_Kq3j230bjqgAjdpc67zV0hIv7Uw6BKtA	!FSwSlJXpOZZONTVfGs:localhost
$33Pk__-gU3AslKMgHWQqdrgfvEhGtn4nPTRaDuhZUC0	$VI4y-gfFPbzFuAM6S6F4gXfpeWta-thThcGlPN0xQN0	!FSwSlJXpOZZONTVfGs:localhost
$UEYdHpguNtwCDIQ9fsK7537cGDuKB-9QPh7SJsYm6lQ	$uDBLcAyAHq3swiKjGlyKYFZwIrP5Ux8Ki1qU7x3aVsY	!JGJhGNDoMdRLJzLgcJ:localhost
$UEYdHpguNtwCDIQ9fsK7537cGDuKB-9QPh7SJsYm6lQ	$MLY05F5LyQaOuJw4avembMABTu_CtFuQyhyiF14QtYo	!JGJhGNDoMdRLJzLgcJ:localhost
$UEYdHpguNtwCDIQ9fsK7537cGDuKB-9QPh7SJsYm6lQ	$A45QtHYoTPEA17jEFQZ4U882WGuYFA2D4xiKqwnZyUs	!JGJhGNDoMdRLJzLgcJ:localhost
$bgbjmgXAlLz069pieqVTP8KTcxXHvT72ZwdRr71Fnqg	$Z-W9-QEq_roRPUfFFGrVn3vc_d4uekRlcsL3uBSdDpM	!FSwSlJXpOZZONTVfGs:localhost
$bgbjmgXAlLz069pieqVTP8KTcxXHvT72ZwdRr71Fnqg	$4ywygf1-17_Kq3j230bjqgAjdpc67zV0hIv7Uw6BKtA	!FSwSlJXpOZZONTVfGs:localhost
$bgbjmgXAlLz069pieqVTP8KTcxXHvT72ZwdRr71Fnqg	$VI4y-gfFPbzFuAM6S6F4gXfpeWta-thThcGlPN0xQN0	!FSwSlJXpOZZONTVfGs:localhost
$___RsdFndwWsVVLqEZmb4-TWJG-e1GJLt_3bnf1dFu8	$Ip3uw4uae3e7xwaJ6BU2ppE2nWhA0Zyb0KZDNvHAdmU	!cUrTzQWGYNmZYMHoGB:localhost
$___RsdFndwWsVVLqEZmb4-TWJG-e1GJLt_3bnf1dFu8	$nofByIO1FFs8JcKVqFZb7ulSmWdVGm_V-3n-LceVmnw	!cUrTzQWGYNmZYMHoGB:localhost
$___RsdFndwWsVVLqEZmb4-TWJG-e1GJLt_3bnf1dFu8	$XhE1A2QtMIi_b9SfK9jbadCTQ4Xd5IZxBaUOcfglbIA	!cUrTzQWGYNmZYMHoGB:localhost
\.


--
-- Data for Name: event_auth_chain_links; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_auth_chain_links (origin_chain_id, origin_sequence_number, target_chain_id, target_sequence_number) FROM stdin;
13	1	11	1
18	1	11	1
4	1	11	1
1	1	15	1
2	1	17	1
6	1	16	1
12	1	11	1
16	1	17	1
18	1	13	1
18	1	9	1
1	1	17	1
12	1	9	1
12	1	13	1
8	1	18	1
15	1	17	1
2	1	14	1
5	1	15	1
10	1	18	1
17	1	14	1
6	1	15	1
9	1	11	1
5	1	17	1
10	1	9	1
1	1	14	1
3	1	17	1
8	1	9	1
8	1	11	1
2	1	16	1
16	1	14	1
6	1	17	1
3	1	14	1
1	1	16	1
7	1	11	1
10	1	11	1
10	1	13	1
8	1	13	1
4	1	18	1
7	1	9	1
4	1	9	1
15	1	14	1
3	1	16	1
15	1	16	1
4	1	13	1
7	1	13	1
5	1	14	1
6	1	14	1
13	1	9	1
5	1	16	1
19	1	16	1
19	1	14	1
19	1	17	1
19	1	15	1
20	1	9	1
20	1	18	1
20	1	13	1
20	1	11	1
21	1	18	1
21	1	13	1
21	1	9	1
21	1	20	1
21	1	11	1
22	1	15	1
22	1	16	1
22	1	17	1
22	1	19	1
22	1	14	1
23	1	13	1
23	1	9	1
23	1	20	1
23	1	11	1
23	1	18	1
24	1	16	1
24	1	17	1
24	1	19	1
24	1	14	1
24	1	15	1
25	1	9	1
25	1	18	1
25	1	13	1
25	1	11	1
26	1	15	1
26	1	16	1
26	1	14	1
26	1	17	1
27	1	16	1
27	1	19	1
27	1	14	1
27	1	17	1
27	1	15	1
28	1	13	1
28	1	9	1
28	1	20	1
28	1	11	1
28	1	18	1
30	1	29	1
31	1	29	1
31	1	30	1
32	1	30	1
32	1	31	1
32	1	29	1
33	1	30	1
33	1	31	1
33	1	29	1
34	1	30	1
34	1	31	1
34	1	29	1
35	1	31	1
35	1	29	1
35	1	30	1
36	1	33	1
36	1	31	1
36	1	29	1
36	1	30	1
38	1	37	1
39	1	38	1
39	1	37	1
40	1	38	1
40	1	39	1
40	1	37	1
41	1	39	1
41	1	37	1
41	1	38	1
42	1	38	1
42	1	39	1
42	1	37	1
43	1	37	1
43	1	38	1
43	1	39	1
44	1	38	1
44	1	39	1
44	1	37	1
45	1	41	1
45	1	39	1
45	1	38	1
45	1	37	1
46	1	39	1
46	1	37	1
46	1	38	1
47	1	37	1
47	1	38	1
47	1	39	1
48	1	29	1
48	1	30	1
48	1	33	1
48	1	31	1
50	1	49	1
52	1	50	1
53	1	55	1
53	1	50	1
55	1	49	1
52	1	49	1
51	1	49	1
53	1	49	1
51	1	55	1
51	1	50	1
54	1	49	1
54	1	55	1
54	1	50	1
55	1	50	1
52	1	55	1
56	1	49	1
56	1	55	1
56	1	50	1
57	1	49	1
57	1	55	1
57	1	50	1
61	1	58	1
62	1	59	1
63	1	60	1
68	1	60	1
67	1	60	1
65	1	66	1
67	1	66	1
66	1	60	1
65	1	63	1
68	1	63	1
65	1	60	1
64	1	60	1
66	1	63	1
64	1	66	1
64	1	63	1
68	1	66	1
67	1	63	1
70	1	58	1
70	1	69	1
69	1	58	1
70	1	61	1
73	1	61	1
72	1	58	1
72	1	61	1
72	1	69	1
69	1	61	1
71	1	61	1
71	1	58	1
73	1	69	1
73	1	58	1
71	1	69	1
75	1	76	1
78	1	59	1
74	1	62	1
74	1	76	1
78	1	62	1
77	1	76	1
78	1	76	1
77	1	59	1
76	1	59	1
74	1	59	1
75	1	62	1
77	1	62	1
76	1	62	1
75	1	59	1
79	1	66	1
79	1	63	1
79	1	60	1
80	1	76	1
80	1	62	1
80	1	59	1
81	1	61	1
81	1	58	1
81	1	69	1
82	1	50	1
82	1	49	1
82	1	55	1
84	1	49	1
84	1	55	1
84	1	50	1
83	1	55	1
83	1	50	1
83	1	49	1
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
$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	14	1
$PeAJ6BypXjJegHiUjcYe-I6Cf4NuCPICi_yUb-fyauA	17	1
$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	16	1
$TVnvv0nGbLydCBtMmTTz-htMsoI4hmxCr3s9AHyFGHQ	2	1
$b__a7rX3L5YpX7nAZte73DAbjtXZK48JH8VKSnGOKKw	3	1
$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	15	1
$4ZLf-3JRJMLLADbzome2n_5rZNEeHEFIo3w1xN4KKu0	1	1
$Svf91tyGyUuzelYH8bbzM6QXuI9Xcab-XMXjCrIgM5A	6	1
$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	11	1
$_oKaaOfL7rFtPsAsxDmHrCY9sAzFjslRwkJ_QHxHDTw	9	1
$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	13	1
$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	18	1
$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8	4	1
$O5iO4EII22igkDq5cMKHFB-SGIYD0KqJQXZohS2Dzc0	12	1
$X8tdoEsXAgBC6gobCepAn3rwO8CJoQU6i9NN9Rzhukg	7	1
$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA	8	1
$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk	10	1
$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0	5	1
$jyfZsVYOTCt8az1WqRlL53b1lAQWjIj6-IvW1w3qYks	19	1
$PkPxRt8GuXFqdWre9vyhqKHlRSqflC0cOSTBOims4qY	20	1
$ARxMI5-TIkg2afPIDJsLgeSqCdrfbwBxm32e83QRfQ4	21	1
$nE3KmrZJdWnhQ2h6DgIB98qoLGnQlFFCvgSu4NS5FfA	22	1
$mlRlSJ1S_x5OctD_Nck7tq-Fo2IC7iOhysac1uYo_PY	23	1
$Y86Vdmx2z1nvkEoTqBH7oAiLE_sHPFtNgI97gsUAwaY	24	1
$pXbc3VIu5b4O4VzPRePQd4FjtqYPJLH87Ss7pZM-gRM	21	2
$q7m8fkdDrp2QE9hRAHYIR_KN8htxYXW85pB3LgG-V2U	23	2
$YHxtZv4JfPzIJvBMvoTgzeITfTFFng_L_4ijJ1Q97k4	22	2
$cH796vSd1hy4UBg8XHAqeUxz-u3gxer-uMeGrsirKbs	24	2
$5DYqRHQPE1SQt9QXHJodWH7x4Pztz3LTsgH1kdHawZs	25	1
$TKcINA6W5qTH8raDaFqEMBivZ0LjgXtIHGvxzJ9V4_8	26	1
$REN0AaEE212pFbK8uJB-22lyjpnqTEP0SshUeVfsGU4	27	1
$AwutniYNkYl6Dxs-8zYvdPdGLIcM4Kyzaldut5D0jHQ	27	2
$HmGCTcPZGDbaswAPjYZ0ddKt1eWRcRq89rE-yVwDV0s	28	1
$VFMUBSkD_jWG8nImBQfkmffKyLBdxGMpdkFACHA33Ng	28	2
$NfGFxRqIrSmaeLcN53BGirnWzJ1bpwzVyt2oZw2cj1k	29	1
$7N18oPwd46twVh-RWhED6VAPm79aIXVCh_BVUFAFHP8	30	1
$eKvf8PFaZwsEOXW-IIYTGZwl6gxEYmEE2TalB5k2iGs	31	1
$ZraIWv18CC1pTAGQZToI1ZXr7ki_53OY_jvQl0RDE_A	32	1
$Uf6bLI9lxBnR9TJvz8fcfo-1_wbshzMvT4Ecr_qy-E4	33	1
$30q15kBxfYB9Dyc1sAhoNXYpZXfDlneq4Ckvuz_Sy1Y	34	1
$wlATKVSoZpEXfwFpmdptZK6V2TMFQ87Bjjhru1P3dGs	35	1
$PZkmtd-Zj4an2Acc9O8V-mK2mVxXChviZhd_hsf6Ehg	36	1
$pIVIlPgvO-fbiW31dx4GB-wsRX4DrbADDn1AfJoXI50	37	1
$bWqW6N4T6ZlJ3MzEaI-MgqdvMEklGrNsy22WqL6ZgOc	38	1
$ngKTLt0SDFtdjkF6GnjahEcDA-qLwTKRcVgMgMg5tN8	39	1
$IxyNn3A4NegMug4xc7O0sm2s1r9jyybU5iNogwEGesQ	40	1
$SQpUzgCCeFIrGC3eCPDX_U021w7MG0-lHOxFTcHbvKk	41	1
$pe2Yi2ila5QgzVKIEGGAIeqvcRaD37GUFMvAOWX2tp0	42	1
$_MdWHbg9mI3zN-WDGIpwDRJZmDWXBeW-m3WrJiRs4t8	43	1
$7qFBn6lW7C0hRYBTRjR0tsE8qpZmodqh6LOyLL0HMnQ	44	1
$d7sJ6Squy3gHlaCn4UxGeu_9AcN2XCBHtBIY8VL5d_g	45	1
$8lVZQlOM-qXD0dT5ZSbvlEPAQPq5wJHU8KqM6sLfmWM	46	1
$OsJU_fxidXD79b8VmXNcxdAdUkhXO3S73zUBYUa3yG8	47	1
$76OhaN_mof41kiqxA-qZV26DgKxkvkl8JwQjOYqZF1A	48	1
$XhE1A2QtMIi_b9SfK9jbadCTQ4Xd5IZxBaUOcfglbIA	49	1
$Ip3uw4uae3e7xwaJ6BU2ppE2nWhA0Zyb0KZDNvHAdmU	50	1
$nofByIO1FFs8JcKVqFZb7ulSmWdVGm_V-3n-LceVmnw	55	1
$DFCNP6Tt2ypS8tXyd5kaCiqWeVDmE_FL-iOprkrfubk	52	1
$MJ2YTkP3f-eQwc5HLB6GVzjnPJaVov0pUCfq1bWqG3M	53	1
$iAAlBelGypnsbVKn9Fd-ubLNje326TRpaegoLLyRZGY	54	1
$wtg0qf-MdY5Ur4UMAlOlQ58df82OmKhsbTS81ItsAT8	51	1
$34bSEXw9U2DTNkZA2he27rczptl3jni1oG64GRRYkfY	56	1
$SFXqj2UcfZU2XtnGBtupMwsoI3Z5JLp-7mmR2PU4MjQ	57	1
$VI4y-gfFPbzFuAM6S6F4gXfpeWta-thThcGlPN0xQN0	58	1
$LnGTvN89zWMaGdr_8T22TNwZ8hCnAeMlGOMaGpCPahE	59	1
$A45QtHYoTPEA17jEFQZ4U882WGuYFA2D4xiKqwnZyUs	60	1
$Z-W9-QEq_roRPUfFFGrVn3vc_d4uekRlcsL3uBSdDpM	61	1
$RRFtexNdS-wxfmZgcU9kk5Lyp462lIuVu6piimDKCGA	62	1
$uDBLcAyAHq3swiKjGlyKYFZwIrP5Ux8Ki1qU7x3aVsY	63	1
$MLY05F5LyQaOuJw4avembMABTu_CtFuQyhyiF14QtYo	66	1
$IYkBkm-ncU_4Z-Ft8v80LsrK5kKpzGKpHDUWZxxy6t8	65	1
$JfR9TVM-sEe4hZ5-0bIni5e5m_tLlX2HdSU6u6IoVBM	64	1
$e6pVgV1MsH-6_A1V_vGWGmdznPg_czNOfblinyTHshA	68	1
$hNUZNFVPWjQzoWmc5wymfJzaTuaIdxyWFsi3fkTJ534	67	1
$4ywygf1-17_Kq3j230bjqgAjdpc67zV0hIv7Uw6BKtA	69	1
$27FTfsExd-igZozi1nKpy5Iyqayuxc3DZY9LFN9e6oo	72	1
$33Pk__-gU3AslKMgHWQqdrgfvEhGtn4nPTRaDuhZUC0	71	1
$CjB4vCnMjTm70a0EahGjB5FN8EKtrdWl7F12gA2FhDo	73	1
$Y_182-w64pn902ATtlukjIsNSzVBtF9fw_aMYWx9DdY	70	1
$nMtE3MPK3rxeHXzgEF1GWQXqF1Of8IqoWwPKejXxdrg	76	1
$-FXdMAkllHkSbPP-QDGsb_zIuCwPKR511zZahmMGKs4	75	1
$4MpBsW-eFJ4SoVP-rLgkefjkNR0Sytuayop2Z-OBFzU	78	1
$5QgMOlhzvtIooZVNYnMnchsgiEUDObBacU41JO2zKs0	74	1
$NYaJba-K1Im8n6_Z7mL0VwgIAKxZqouzTTYu6EcK5eM	77	1
$UEYdHpguNtwCDIQ9fsK7537cGDuKB-9QPh7SJsYm6lQ	79	1
$sUchhgur-fFKVUmMUaBERmjM3ItMz4-8bhkuD7UXnuU	80	1
$bgbjmgXAlLz069pieqVTP8KTcxXHvT72ZwdRr71Fnqg	81	1
$___RsdFndwWsVVLqEZmb4-TWJG-e1GJLt_3bnf1dFu8	82	1
$OUsS0radBRPS3B8beUIJ1TUjFMPXJ0OTtSau2wSu6rY	84	1
$z3x2QWsqd2WeWbha161nzCLfGv7psz2SV_Gveo8B5Yk	83	1
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
$jyfZsVYOTCt8az1WqRlL53b1lAQWjIj6-IvW1w3qYks	$Svf91tyGyUuzelYH8bbzM6QXuI9Xcab-XMXjCrIgM5A	!dKcbdDATuwwphjRPQP:localhost	f
$PkPxRt8GuXFqdWre9vyhqKHlRSqflC0cOSTBOims4qY	$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA	!kmbTYjjsDRDHGgVqUP:localhost	f
$ARxMI5-TIkg2afPIDJsLgeSqCdrfbwBxm32e83QRfQ4	$PkPxRt8GuXFqdWre9vyhqKHlRSqflC0cOSTBOims4qY	!kmbTYjjsDRDHGgVqUP:localhost	f
$nE3KmrZJdWnhQ2h6DgIB98qoLGnQlFFCvgSu4NS5FfA	$jyfZsVYOTCt8az1WqRlL53b1lAQWjIj6-IvW1w3qYks	!dKcbdDATuwwphjRPQP:localhost	f
$mlRlSJ1S_x5OctD_Nck7tq-Fo2IC7iOhysac1uYo_PY	$ARxMI5-TIkg2afPIDJsLgeSqCdrfbwBxm32e83QRfQ4	!kmbTYjjsDRDHGgVqUP:localhost	f
$pXbc3VIu5b4O4VzPRePQd4FjtqYPJLH87Ss7pZM-gRM	$mlRlSJ1S_x5OctD_Nck7tq-Fo2IC7iOhysac1uYo_PY	!kmbTYjjsDRDHGgVqUP:localhost	f
$Y86Vdmx2z1nvkEoTqBH7oAiLE_sHPFtNgI97gsUAwaY	$nE3KmrZJdWnhQ2h6DgIB98qoLGnQlFFCvgSu4NS5FfA	!dKcbdDATuwwphjRPQP:localhost	f
$q7m8fkdDrp2QE9hRAHYIR_KN8htxYXW85pB3LgG-V2U	$pXbc3VIu5b4O4VzPRePQd4FjtqYPJLH87Ss7pZM-gRM	!kmbTYjjsDRDHGgVqUP:localhost	f
$YHxtZv4JfPzIJvBMvoTgzeITfTFFng_L_4ijJ1Q97k4	$Y86Vdmx2z1nvkEoTqBH7oAiLE_sHPFtNgI97gsUAwaY	!dKcbdDATuwwphjRPQP:localhost	f
$cH796vSd1hy4UBg8XHAqeUxz-u3gxer-uMeGrsirKbs	$YHxtZv4JfPzIJvBMvoTgzeITfTFFng_L_4ijJ1Q97k4	!dKcbdDATuwwphjRPQP:localhost	f
$5DYqRHQPE1SQt9QXHJodWH7x4Pztz3LTsgH1kdHawZs	$q7m8fkdDrp2QE9hRAHYIR_KN8htxYXW85pB3LgG-V2U	!kmbTYjjsDRDHGgVqUP:localhost	f
$TKcINA6W5qTH8raDaFqEMBivZ0LjgXtIHGvxzJ9V4_8	$cH796vSd1hy4UBg8XHAqeUxz-u3gxer-uMeGrsirKbs	!dKcbdDATuwwphjRPQP:localhost	f
$REN0AaEE212pFbK8uJB-22lyjpnqTEP0SshUeVfsGU4	$TKcINA6W5qTH8raDaFqEMBivZ0LjgXtIHGvxzJ9V4_8	!dKcbdDATuwwphjRPQP:localhost	f
$AwutniYNkYl6Dxs-8zYvdPdGLIcM4Kyzaldut5D0jHQ	$REN0AaEE212pFbK8uJB-22lyjpnqTEP0SshUeVfsGU4	!dKcbdDATuwwphjRPQP:localhost	f
$HmGCTcPZGDbaswAPjYZ0ddKt1eWRcRq89rE-yVwDV0s	$5DYqRHQPE1SQt9QXHJodWH7x4Pztz3LTsgH1kdHawZs	!kmbTYjjsDRDHGgVqUP:localhost	f
$VFMUBSkD_jWG8nImBQfkmffKyLBdxGMpdkFACHA33Ng	$HmGCTcPZGDbaswAPjYZ0ddKt1eWRcRq89rE-yVwDV0s	!kmbTYjjsDRDHGgVqUP:localhost	f
$DTQEMlxc_4_CqP-rYQ46vmCpJtEKlxw_Ugma4cnNO6w	$AwutniYNkYl6Dxs-8zYvdPdGLIcM4Kyzaldut5D0jHQ	!dKcbdDATuwwphjRPQP:localhost	f
$cIkI-00MET-_PQ4VaVFuuZsJ2WEz_UMnlXun9Itkqt8	$DTQEMlxc_4_CqP-rYQ46vmCpJtEKlxw_Ugma4cnNO6w	!dKcbdDATuwwphjRPQP:localhost	f
$CsT9BKDbT6nCfiXJCOAHV90fgB6fYV4boIF3v6eEls4	$cIkI-00MET-_PQ4VaVFuuZsJ2WEz_UMnlXun9Itkqt8	!dKcbdDATuwwphjRPQP:localhost	f
$3Q6XqtJGvGa1jhhtRN9kQqoLIWqjikrH3x7yltwaZ6w	$VFMUBSkD_jWG8nImBQfkmffKyLBdxGMpdkFACHA33Ng	!kmbTYjjsDRDHGgVqUP:localhost	f
$pulJgsd1znNtSba8MCpZoXTCHhxSC0OkMutE8dDzlO0	$3Q6XqtJGvGa1jhhtRN9kQqoLIWqjikrH3x7yltwaZ6w	!kmbTYjjsDRDHGgVqUP:localhost	f
$JghGsUh3v1rikXL8gETZ_UJKjZC_6NY_WEgHUWlDGUM	$pulJgsd1znNtSba8MCpZoXTCHhxSC0OkMutE8dDzlO0	!kmbTYjjsDRDHGgVqUP:localhost	f
$COcCgODcXP3YBig5Vk-_QDtWh0rzx9K1yVAasfvXRVk	$JghGsUh3v1rikXL8gETZ_UJKjZC_6NY_WEgHUWlDGUM	!kmbTYjjsDRDHGgVqUP:localhost	f
$lGC_2RlgCMjLDCMd4bkjzCmXnXFQHNvnd9eFy28BE8E	$COcCgODcXP3YBig5Vk-_QDtWh0rzx9K1yVAasfvXRVk	!kmbTYjjsDRDHGgVqUP:localhost	f
$iPEm9yDTEtMvd-r8SFs0eTz8dpjdWAFHcpWpOTKCqkk	$lGC_2RlgCMjLDCMd4bkjzCmXnXFQHNvnd9eFy28BE8E	!kmbTYjjsDRDHGgVqUP:localhost	f
$Ay9Au4hI33NjvpwrmfU6OSnS-_gSjFb5bRzB6756wKo	$iPEm9yDTEtMvd-r8SFs0eTz8dpjdWAFHcpWpOTKCqkk	!kmbTYjjsDRDHGgVqUP:localhost	f
$szFQBuhhfXcOIlgReai0669p3ycU-w57s91VHUKWXFA	$Ay9Au4hI33NjvpwrmfU6OSnS-_gSjFb5bRzB6756wKo	!kmbTYjjsDRDHGgVqUP:localhost	f
$pec3QOL9YU-4d4ww5taJYfFCSKUcMIUYBRSHQoML6Vw	$szFQBuhhfXcOIlgReai0669p3ycU-w57s91VHUKWXFA	!kmbTYjjsDRDHGgVqUP:localhost	f
$ckvkcjvKmxJljo0NX3W1BFf-JQMuUnFbh-r9CNPtmR4	$pec3QOL9YU-4d4ww5taJYfFCSKUcMIUYBRSHQoML6Vw	!kmbTYjjsDRDHGgVqUP:localhost	f
$Ss566NPFclWN6Mx7hHv8fd_JaawsG1AuM6gnlM7fA-k	$ckvkcjvKmxJljo0NX3W1BFf-JQMuUnFbh-r9CNPtmR4	!kmbTYjjsDRDHGgVqUP:localhost	f
$focovH6Yc-m2CXhjrx4lhMQHQhQODpLp4g1sKHOxfaU	$Ss566NPFclWN6Mx7hHv8fd_JaawsG1AuM6gnlM7fA-k	!kmbTYjjsDRDHGgVqUP:localhost	f
$Y8T81hxoxP5Ta-IxCarhZjMk4fWMtcg9FlgmTG9VgiE	$focovH6Yc-m2CXhjrx4lhMQHQhQODpLp4g1sKHOxfaU	!kmbTYjjsDRDHGgVqUP:localhost	f
$RVi3Hrw_NGpZOOlLIRSt-m_lPWPYt0K7JLecNmlU1Sw	$Y8T81hxoxP5Ta-IxCarhZjMk4fWMtcg9FlgmTG9VgiE	!kmbTYjjsDRDHGgVqUP:localhost	f
$7N18oPwd46twVh-RWhED6VAPm79aIXVCh_BVUFAFHP8	$NfGFxRqIrSmaeLcN53BGirnWzJ1bpwzVyt2oZw2cj1k	!BfSgfecvJnYoZjTYRA:localhost	f
$eKvf8PFaZwsEOXW-IIYTGZwl6gxEYmEE2TalB5k2iGs	$7N18oPwd46twVh-RWhED6VAPm79aIXVCh_BVUFAFHP8	!BfSgfecvJnYoZjTYRA:localhost	f
$ZraIWv18CC1pTAGQZToI1ZXr7ki_53OY_jvQl0RDE_A	$eKvf8PFaZwsEOXW-IIYTGZwl6gxEYmEE2TalB5k2iGs	!BfSgfecvJnYoZjTYRA:localhost	f
$Uf6bLI9lxBnR9TJvz8fcfo-1_wbshzMvT4Ecr_qy-E4	$ZraIWv18CC1pTAGQZToI1ZXr7ki_53OY_jvQl0RDE_A	!BfSgfecvJnYoZjTYRA:localhost	f
$30q15kBxfYB9Dyc1sAhoNXYpZXfDlneq4Ckvuz_Sy1Y	$Uf6bLI9lxBnR9TJvz8fcfo-1_wbshzMvT4Ecr_qy-E4	!BfSgfecvJnYoZjTYRA:localhost	f
$wlATKVSoZpEXfwFpmdptZK6V2TMFQ87Bjjhru1P3dGs	$30q15kBxfYB9Dyc1sAhoNXYpZXfDlneq4Ckvuz_Sy1Y	!BfSgfecvJnYoZjTYRA:localhost	f
$PZkmtd-Zj4an2Acc9O8V-mK2mVxXChviZhd_hsf6Ehg	$wlATKVSoZpEXfwFpmdptZK6V2TMFQ87Bjjhru1P3dGs	!BfSgfecvJnYoZjTYRA:localhost	f
$ZF1U_gGvucrvqj1m7ffy4HKGxUsoAbYKpWzUjaPqlMM	$PZkmtd-Zj4an2Acc9O8V-mK2mVxXChviZhd_hsf6Ehg	!BfSgfecvJnYoZjTYRA:localhost	f
$bWqW6N4T6ZlJ3MzEaI-MgqdvMEklGrNsy22WqL6ZgOc	$pIVIlPgvO-fbiW31dx4GB-wsRX4DrbADDn1AfJoXI50	!pWsdJYvpdmDULVhQtX:localhost	f
$ngKTLt0SDFtdjkF6GnjahEcDA-qLwTKRcVgMgMg5tN8	$bWqW6N4T6ZlJ3MzEaI-MgqdvMEklGrNsy22WqL6ZgOc	!pWsdJYvpdmDULVhQtX:localhost	f
$IxyNn3A4NegMug4xc7O0sm2s1r9jyybU5iNogwEGesQ	$ngKTLt0SDFtdjkF6GnjahEcDA-qLwTKRcVgMgMg5tN8	!pWsdJYvpdmDULVhQtX:localhost	f
$SQpUzgCCeFIrGC3eCPDX_U021w7MG0-lHOxFTcHbvKk	$IxyNn3A4NegMug4xc7O0sm2s1r9jyybU5iNogwEGesQ	!pWsdJYvpdmDULVhQtX:localhost	f
$pe2Yi2ila5QgzVKIEGGAIeqvcRaD37GUFMvAOWX2tp0	$SQpUzgCCeFIrGC3eCPDX_U021w7MG0-lHOxFTcHbvKk	!pWsdJYvpdmDULVhQtX:localhost	f
$_MdWHbg9mI3zN-WDGIpwDRJZmDWXBeW-m3WrJiRs4t8	$pe2Yi2ila5QgzVKIEGGAIeqvcRaD37GUFMvAOWX2tp0	!pWsdJYvpdmDULVhQtX:localhost	f
$7qFBn6lW7C0hRYBTRjR0tsE8qpZmodqh6LOyLL0HMnQ	$_MdWHbg9mI3zN-WDGIpwDRJZmDWXBeW-m3WrJiRs4t8	!pWsdJYvpdmDULVhQtX:localhost	f
$d7sJ6Squy3gHlaCn4UxGeu_9AcN2XCBHtBIY8VL5d_g	$7qFBn6lW7C0hRYBTRjR0tsE8qpZmodqh6LOyLL0HMnQ	!pWsdJYvpdmDULVhQtX:localhost	f
$xCubuHnQAGuDuGdlqiquXK0QRxhOWKTh5TJZZGcL09Q	$d7sJ6Squy3gHlaCn4UxGeu_9AcN2XCBHtBIY8VL5d_g	!pWsdJYvpdmDULVhQtX:localhost	f
$8lVZQlOM-qXD0dT5ZSbvlEPAQPq5wJHU8KqM6sLfmWM	$xCubuHnQAGuDuGdlqiquXK0QRxhOWKTh5TJZZGcL09Q	!pWsdJYvpdmDULVhQtX:localhost	f
$OsJU_fxidXD79b8VmXNcxdAdUkhXO3S73zUBYUa3yG8	$8lVZQlOM-qXD0dT5ZSbvlEPAQPq5wJHU8KqM6sLfmWM	!pWsdJYvpdmDULVhQtX:localhost	f
$JWIcDwBleupt991UzmNH_DSdEWQPePa6uEyU2J0-ldM	$OsJU_fxidXD79b8VmXNcxdAdUkhXO3S73zUBYUa3yG8	!pWsdJYvpdmDULVhQtX:localhost	f
$76OhaN_mof41kiqxA-qZV26DgKxkvkl8JwQjOYqZF1A	$ZF1U_gGvucrvqj1m7ffy4HKGxUsoAbYKpWzUjaPqlMM	!BfSgfecvJnYoZjTYRA:localhost	f
$8_ljUg0y31H3DwB8UeZyPs3Vlh_4zdSmAkWCsBDCc98	$CsT9BKDbT6nCfiXJCOAHV90fgB6fYV4boIF3v6eEls4	\N	f
$UlpkVhx0UMdfV3JIISqctfZ_aMoIkpmIqcfxcCxxRL8	$8_ljUg0y31H3DwB8UeZyPs3Vlh_4zdSmAkWCsBDCc98	\N	f
$_B6Ln541gYqlnaEaxAcSwy46yBXDxkldNhRG8HdrPBs	$UlpkVhx0UMdfV3JIISqctfZ_aMoIkpmIqcfxcCxxRL8	\N	f
$grj8CepyvbRzzkLI4auscQ640Z-NssUGE9TSsXkp690	$_B6Ln541gYqlnaEaxAcSwy46yBXDxkldNhRG8HdrPBs	\N	f
$oakhKpEqFw5Icor6iY_TRMQljV-HWQ3lueP0Vlm9hIY	$grj8CepyvbRzzkLI4auscQ640Z-NssUGE9TSsXkp690	\N	f
$Ip3uw4uae3e7xwaJ6BU2ppE2nWhA0Zyb0KZDNvHAdmU	$XhE1A2QtMIi_b9SfK9jbadCTQ4Xd5IZxBaUOcfglbIA	\N	f
$nofByIO1FFs8JcKVqFZb7ulSmWdVGm_V-3n-LceVmnw	$Ip3uw4uae3e7xwaJ6BU2ppE2nWhA0Zyb0KZDNvHAdmU	\N	f
$wtg0qf-MdY5Ur4UMAlOlQ58df82OmKhsbTS81ItsAT8	$nofByIO1FFs8JcKVqFZb7ulSmWdVGm_V-3n-LceVmnw	\N	f
$DFCNP6Tt2ypS8tXyd5kaCiqWeVDmE_FL-iOprkrfubk	$wtg0qf-MdY5Ur4UMAlOlQ58df82OmKhsbTS81ItsAT8	\N	f
$MJ2YTkP3f-eQwc5HLB6GVzjnPJaVov0pUCfq1bWqG3M	$DFCNP6Tt2ypS8tXyd5kaCiqWeVDmE_FL-iOprkrfubk	\N	f
$iAAlBelGypnsbVKn9Fd-ubLNje326TRpaegoLLyRZGY	$MJ2YTkP3f-eQwc5HLB6GVzjnPJaVov0pUCfq1bWqG3M	\N	f
$34bSEXw9U2DTNkZA2he27rczptl3jni1oG64GRRYkfY	$iAAlBelGypnsbVKn9Fd-ubLNje326TRpaegoLLyRZGY	\N	f
$SFXqj2UcfZU2XtnGBtupMwsoI3Z5JLp-7mmR2PU4MjQ	$34bSEXw9U2DTNkZA2he27rczptl3jni1oG64GRRYkfY	\N	f
$Z-W9-QEq_roRPUfFFGrVn3vc_d4uekRlcsL3uBSdDpM	$VI4y-gfFPbzFuAM6S6F4gXfpeWta-thThcGlPN0xQN0	\N	f
$RRFtexNdS-wxfmZgcU9kk5Lyp462lIuVu6piimDKCGA	$LnGTvN89zWMaGdr_8T22TNwZ8hCnAeMlGOMaGpCPahE	\N	f
$uDBLcAyAHq3swiKjGlyKYFZwIrP5Ux8Ki1qU7x3aVsY	$A45QtHYoTPEA17jEFQZ4U882WGuYFA2D4xiKqwnZyUs	\N	f
$MLY05F5LyQaOuJw4avembMABTu_CtFuQyhyiF14QtYo	$uDBLcAyAHq3swiKjGlyKYFZwIrP5Ux8Ki1qU7x3aVsY	\N	f
$e6pVgV1MsH-6_A1V_vGWGmdznPg_czNOfblinyTHshA	$MLY05F5LyQaOuJw4avembMABTu_CtFuQyhyiF14QtYo	\N	f
$hNUZNFVPWjQzoWmc5wymfJzaTuaIdxyWFsi3fkTJ534	$e6pVgV1MsH-6_A1V_vGWGmdznPg_czNOfblinyTHshA	\N	f
$IYkBkm-ncU_4Z-Ft8v80LsrK5kKpzGKpHDUWZxxy6t8	$hNUZNFVPWjQzoWmc5wymfJzaTuaIdxyWFsi3fkTJ534	\N	f
$JfR9TVM-sEe4hZ5-0bIni5e5m_tLlX2HdSU6u6IoVBM	$IYkBkm-ncU_4Z-Ft8v80LsrK5kKpzGKpHDUWZxxy6t8	\N	f
$4ywygf1-17_Kq3j230bjqgAjdpc67zV0hIv7Uw6BKtA	$Z-W9-QEq_roRPUfFFGrVn3vc_d4uekRlcsL3uBSdDpM	\N	f
$CjB4vCnMjTm70a0EahGjB5FN8EKtrdWl7F12gA2FhDo	$4ywygf1-17_Kq3j230bjqgAjdpc67zV0hIv7Uw6BKtA	\N	f
$Y_182-w64pn902ATtlukjIsNSzVBtF9fw_aMYWx9DdY	$CjB4vCnMjTm70a0EahGjB5FN8EKtrdWl7F12gA2FhDo	\N	f
$27FTfsExd-igZozi1nKpy5Iyqayuxc3DZY9LFN9e6oo	$Y_182-w64pn902ATtlukjIsNSzVBtF9fw_aMYWx9DdY	\N	f
$33Pk__-gU3AslKMgHWQqdrgfvEhGtn4nPTRaDuhZUC0	$27FTfsExd-igZozi1nKpy5Iyqayuxc3DZY9LFN9e6oo	\N	f
$nMtE3MPK3rxeHXzgEF1GWQXqF1Of8IqoWwPKejXxdrg	$RRFtexNdS-wxfmZgcU9kk5Lyp462lIuVu6piimDKCGA	\N	f
$4MpBsW-eFJ4SoVP-rLgkefjkNR0Sytuayop2Z-OBFzU	$nMtE3MPK3rxeHXzgEF1GWQXqF1Of8IqoWwPKejXxdrg	\N	f
$5QgMOlhzvtIooZVNYnMnchsgiEUDObBacU41JO2zKs0	$4MpBsW-eFJ4SoVP-rLgkefjkNR0Sytuayop2Z-OBFzU	\N	f
$NYaJba-K1Im8n6_Z7mL0VwgIAKxZqouzTTYu6EcK5eM	$5QgMOlhzvtIooZVNYnMnchsgiEUDObBacU41JO2zKs0	\N	f
$-FXdMAkllHkSbPP-QDGsb_zIuCwPKR511zZahmMGKs4	$NYaJba-K1Im8n6_Z7mL0VwgIAKxZqouzTTYu6EcK5eM	\N	f
$UEYdHpguNtwCDIQ9fsK7537cGDuKB-9QPh7SJsYm6lQ	$JfR9TVM-sEe4hZ5-0bIni5e5m_tLlX2HdSU6u6IoVBM	\N	f
$sUchhgur-fFKVUmMUaBERmjM3ItMz4-8bhkuD7UXnuU	$-FXdMAkllHkSbPP-QDGsb_zIuCwPKR511zZahmMGKs4	\N	f
$bgbjmgXAlLz069pieqVTP8KTcxXHvT72ZwdRr71Fnqg	$33Pk__-gU3AslKMgHWQqdrgfvEhGtn4nPTRaDuhZUC0	\N	f
$___RsdFndwWsVVLqEZmb4-TWJG-e1GJLt_3bnf1dFu8	$SFXqj2UcfZU2XtnGBtupMwsoI3Z5JLp-7mmR2PU4MjQ	\N	f
$OUsS0radBRPS3B8beUIJ1TUjFMPXJ0OTtSau2wSu6rY	$SFXqj2UcfZU2XtnGBtupMwsoI3Z5JLp-7mmR2PU4MjQ	\N	f
$z3x2QWsqd2WeWbha161nzCLfGv7psz2SV_Gveo8B5Yk	$SFXqj2UcfZU2XtnGBtupMwsoI3Z5JLp-7mmR2PU4MjQ	\N	f
$almCp-spfN30ITGsQkwvqZtOB3TVD17i4DcwiaswR4E	$sUchhgur-fFKVUmMUaBERmjM3ItMz4-8bhkuD7UXnuU	\N	f
$FJVN_jtSz6ZNRLKTCrfOqY0M69xPDbu_hr4GTuB_3u8	$almCp-spfN30ITGsQkwvqZtOB3TVD17i4DcwiaswR4E	\N	f
$PfXwdx6I54mC3f0Zd8nOukV5nTCxL7uRQKGn3Bxg17Y	$RVi3Hrw_NGpZOOlLIRSt-m_lPWPYt0K7JLecNmlU1Sw	\N	f
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
$JWIcDwBleupt991UzmNH_DSdEWQPePa6uEyU2J0-ldM	!pWsdJYvpdmDULVhQtX:localhost
$76OhaN_mof41kiqxA-qZV26DgKxkvkl8JwQjOYqZF1A	!BfSgfecvJnYoZjTYRA:localhost
$oakhKpEqFw5Icor6iY_TRMQljV-HWQ3lueP0Vlm9hIY	!dKcbdDATuwwphjRPQP:localhost
$UEYdHpguNtwCDIQ9fsK7537cGDuKB-9QPh7SJsYm6lQ	!JGJhGNDoMdRLJzLgcJ:localhost
$bgbjmgXAlLz069pieqVTP8KTcxXHvT72ZwdRr71Fnqg	!FSwSlJXpOZZONTVfGs:localhost
$OUsS0radBRPS3B8beUIJ1TUjFMPXJ0OTtSau2wSu6rY	!cUrTzQWGYNmZYMHoGB:localhost
$z3x2QWsqd2WeWbha161nzCLfGv7psz2SV_Gveo8B5Yk	!cUrTzQWGYNmZYMHoGB:localhost
$___RsdFndwWsVVLqEZmb4-TWJG-e1GJLt_3bnf1dFu8	!cUrTzQWGYNmZYMHoGB:localhost
$FJVN_jtSz6ZNRLKTCrfOqY0M69xPDbu_hr4GTuB_3u8	!hccoYOyrWRMEhMnaoh:localhost
$PfXwdx6I54mC3f0Zd8nOukV5nTCxL7uRQKGn3Bxg17Y	!kmbTYjjsDRDHGgVqUP:localhost
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
$ZraIWv18CC1pTAGQZToI1ZXr7ki_53OY_jvQl0RDE_A	!BfSgfecvJnYoZjTYRA:localhost	{"token_id":14,"historical":false}	{"auth_events":["$7N18oPwd46twVh-RWhED6VAPm79aIXVCh_BVUFAFHP8","$eKvf8PFaZwsEOXW-IIYTGZwl6gxEYmEE2TalB5k2iGs","$NfGFxRqIrSmaeLcN53BGirnWzJ1bpwzVyt2oZw2cj1k"],"prev_events":["$eKvf8PFaZwsEOXW-IIYTGZwl6gxEYmEE2TalB5k2iGs"],"type":"m.room.canonical_alias","room_id":"!BfSgfecvJnYoZjTYRA:localhost","sender":"@user1.matrix:localhost","content":{"alias":"#my.dining:localhost"},"depth":4,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1674111195509,"hashes":{"sha256":"Z54cx62h5mXzLhGLWnqgMedXTwjytKB2QKt1Oxwy4gg"},"signatures":{"localhost":{"ed25519:a_CHdg":"eUS6hjTp9Pr2Bs0tiu3up31UGY+Ok8gi0GqFoYk727T2XndBOzaZ3vyQzrjPwjnnw4NbMW6CCayGxwHLNI1yBQ"}},"unsigned":{"age_ts":1674111195509}}	3
$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id": 5, "stream_ordering": 18}	{"auth_events": ["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w", "$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o", "$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"], "prev_events": ["$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk"], "type": "m.room.member", "room_id": "!kmbTYjjsDRDHGgVqUP:localhost", "sender": "@ignored_user:localhost", "content": {"membership": "join", "displayname": "ignored_user"}, "depth": 9, "prev_state": [], "state_key": "@ignored_user:localhost", "origin": "localhost", "origin_server_ts": 1598686328575, "hashes": {"sha256": "D/rwxkYqWZ03Kws7Xsq84khdp4oGHRGnOy4+XwM8dLA"}, "signatures": {"localhost": {"ed25519:a_snHR": "kXK8xKjLjJ97KcFQivelEBI1TR/au+bgtD6i2VPDp9LjRi1bVH/zb6YqHZetT0JYaGt3NY4iFeN0Qh0mD4zyAg"}}, "unsigned": {"age_ts": 1598686328575}}	3
$PkPxRt8GuXFqdWre9vyhqKHlRSqflC0cOSTBOims4qY	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o"],"prev_events":["$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"depth":10,"prev_state":[],"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1673965923529,"hashes":{"sha256":"DWAxH6B2RNjRYSdxluBBpLiH2fDh2cQFbUvoHxqMpR4"},"signatures":{"localhost":{"ed25519:a_CHdg":"r6MNkwd4rT16masoPAgxemsEZVGA3666CiJWnQFa4IfQbTuhOMBeCAGjIvsdkTFcaaaJv54pIyqGX7mLk7h4BQ"}},"unsigned":{"age_ts":1673965923529}}	3
$jyfZsVYOTCt8az1WqRlL53b1lAQWjIj6-IvW1w3qYks	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs"],"prev_events":["$Svf91tyGyUuzelYH8bbzM6QXuI9Xcab-XMXjCrIgM5A"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"depth":10,"prev_state":[],"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1673965923535,"hashes":{"sha256":"Miwrw2ipXe144XA8Z2ou0kSyQilNPWiQfxP5BIKjykA"},"signatures":{"localhost":{"ed25519:a_CHdg":"0F471xJlVuI1dLmbDZ9y+3yeXe3FKCV27JHsgaDN3zWBYSkjxCXQ9SrA3hPZZEdjK7HmtymM19lx/2u0dW/bBg"}},"unsigned":{"age_ts":1673965923535}}	3
$ARxMI5-TIkg2afPIDJsLgeSqCdrfbwBxm32e83QRfQ4	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$PkPxRt8GuXFqdWre9vyhqKHlRSqflC0cOSTBOims4qY","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o"],"prev_events":["$PkPxRt8GuXFqdWre9vyhqKHlRSqflC0cOSTBOims4qY"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"MattermostUser A [mm]"},"depth":11,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1673966482039,"hashes":{"sha256":"gZxRzkaCB8MJvi/5TfKZMzNFJgkGN7rA+0b60UestK0"},"signatures":{"localhost":{"ed25519:a_CHdg":"5K1YO79XL8G13DlU2rdna9ROCVhw69FJMLr140OI56U9sreWV9wYfLto9arMiQqg72oStChM767+ORiu/vjWCA"}},"unsigned":{"age_ts":1673966482039,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#town-square:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$nE3KmrZJdWnhQ2h6DgIB98qoLGnQlFFCvgSu4NS5FfA	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$jyfZsVYOTCt8az1WqRlL53b1lAQWjIj6-IvW1w3qYks","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs"],"prev_events":["$jyfZsVYOTCt8az1WqRlL53b1lAQWjIj6-IvW1w3qYks"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"MattermostUser A [mm]"},"depth":11,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1673966482208,"hashes":{"sha256":"Oxd3TiRWsfBLB14WCjtQI62Xov4Afm5bDcG3HI3hHjk"},"signatures":{"localhost":{"ed25519:a_CHdg":"tGEkItLaQSWOGs0bpn9llpLDP/k+K9KfjU78bu+UEYEGSynQLJ3LKO1BWDjmBU3tRvhzbRJZKcJuURltGPgICA"}},"unsigned":{"age_ts":1673966482208,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#off-topic:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$mlRlSJ1S_x5OctD_Nck7tq-Fo2IC7iOhysac1uYo_PY	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$PkPxRt8GuXFqdWre9vyhqKHlRSqflC0cOSTBOims4qY","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o"],"prev_events":["$ARxMI5-TIkg2afPIDJsLgeSqCdrfbwBxm32e83QRfQ4"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"mattermost_b [mm]"},"depth":12,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1673966482334,"hashes":{"sha256":"oiHWHI/npZOLrvQeazntFnv9GcKaTXnRbuuGCN1i8VI"},"signatures":{"localhost":{"ed25519:a_CHdg":"SjytXnk7NYmg2Q9CYIXvNPomt44km2HWCDNelxnWAH9LM/FALE41m5HQVTSwphxq2snfaZrKzpO+wtwVC1FrBA"}},"unsigned":{"age_ts":1673966482334,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#town-square:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$pXbc3VIu5b4O4VzPRePQd4FjtqYPJLH87Ss7pZM-gRM	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$ARxMI5-TIkg2afPIDJsLgeSqCdrfbwBxm32e83QRfQ4","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o"],"prev_events":["$mlRlSJ1S_x5OctD_Nck7tq-Fo2IC7iOhysac1uYo_PY"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_a:localhost","content":{"membership":"join","displayname":"MattermostUser A [mm]"},"depth":13,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1673966482533,"hashes":{"sha256":"uxEnad8Il/MjSo4hmvuNO5eqNh9Q0qVRUWXxcrj9IHE"},"signatures":{"localhost":{"ed25519:a_CHdg":"cnnqKrM3/AiunD7DC9CIL978gk6qWvLwZ363mFAh1vXguUnIS7NddXJEvRwTXAW4ndOlugOT+Wd9RFMLQdHXBw"}},"unsigned":{"age_ts":1673966482533,"replaces_state":"$ARxMI5-TIkg2afPIDJsLgeSqCdrfbwBxm32e83QRfQ4"}}	3
$Y86Vdmx2z1nvkEoTqBH7oAiLE_sHPFtNgI97gsUAwaY	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$jyfZsVYOTCt8az1WqRlL53b1lAQWjIj6-IvW1w3qYks","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs"],"prev_events":["$nE3KmrZJdWnhQ2h6DgIB98qoLGnQlFFCvgSu4NS5FfA"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"mattermost_b [mm]"},"depth":12,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1673966482494,"hashes":{"sha256":"xGgQQsEn76Eo0E0LcFNdjcRN1sw0FAe5ZsSXQOwp9gA"},"signatures":{"localhost":{"ed25519:a_CHdg":"2iNr/9JB4CNNdgyZ8MQyuwerTqR0b/3AEYeWfL8/9bGwyXuVGtvqYdyZyJ8H5yIpl0ryWpLdt4IsGpFc+tNZCQ"}},"unsigned":{"age_ts":1673966482494,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#off-topic:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$YHxtZv4JfPzIJvBMvoTgzeITfTFFng_L_4ijJ1Q97k4	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$nE3KmrZJdWnhQ2h6DgIB98qoLGnQlFFCvgSu4NS5FfA","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs"],"prev_events":["$Y86Vdmx2z1nvkEoTqBH7oAiLE_sHPFtNgI97gsUAwaY"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_a:localhost","content":{"membership":"join","displayname":"MattermostUser A [mm]"},"depth":13,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1673966482750,"hashes":{"sha256":"nlAQ7BNPrZ4xcOh0tQLaNyzJyu4zWhQ55e/H1fB4w/w"},"signatures":{"localhost":{"ed25519:a_CHdg":"W7B6rMEoqvEEEFK3VyalD1kt1CbjFI2Aun7UsL55SSj+5H0dbkycMx0HMIdp0/CJZ3MRi5tR4xTV9JkfFerKBA"}},"unsigned":{"age_ts":1673966482750,"replaces_state":"$nE3KmrZJdWnhQ2h6DgIB98qoLGnQlFFCvgSu4NS5FfA"}}	3
$q7m8fkdDrp2QE9hRAHYIR_KN8htxYXW85pB3LgG-V2U	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$mlRlSJ1S_x5OctD_Nck7tq-Fo2IC7iOhysac1uYo_PY"],"prev_events":["$pXbc3VIu5b4O4VzPRePQd4FjtqYPJLH87Ss7pZM-gRM"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_mattermost_b:localhost","content":{"membership":"join","displayname":"mattermost_b [mm]"},"depth":14,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1673966482710,"hashes":{"sha256":"w6mbVmsI7f2N6zhy1cmTNQoqYnQZUlWandmMo0bFDBs"},"signatures":{"localhost":{"ed25519:a_CHdg":"GT+k48EfW0pswiKk18JOGcWt8A2+wtuRT8oz2x4+WPE/YxptuGeI8kf/XjYrlfMZPrWxZ7y3514pS8LW7CYzAQ"}},"unsigned":{"age_ts":1673966482710,"replaces_state":"$mlRlSJ1S_x5OctD_Nck7tq-Fo2IC7iOhysac1uYo_PY"}}	3
$cH796vSd1hy4UBg8XHAqeUxz-u3gxer-uMeGrsirKbs	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$Y86Vdmx2z1nvkEoTqBH7oAiLE_sHPFtNgI97gsUAwaY"],"prev_events":["$YHxtZv4JfPzIJvBMvoTgzeITfTFFng_L_4ijJ1Q97k4"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_mattermost_b:localhost","content":{"membership":"join","displayname":"mattermost_b [mm]"},"depth":14,"prev_state":[],"state_key":"@mm_mattermost_b:localhost","origin":"localhost","origin_server_ts":1673966483038,"hashes":{"sha256":"6BJwKt1xopV6d8OJyDDQP7fx874jEjLmPcb3c8CNCgY"},"signatures":{"localhost":{"ed25519:a_CHdg":"AZt3VQ9ZYNtagCh7t5uB8OE9zXrJ9kIpFwOngj11SD9W4tude1AJJdNIas88NLVy8qgPQ6n4JKH4t4vrEsTZCg"}},"unsigned":{"age_ts":1673966483038,"replaces_state":"$Y86Vdmx2z1nvkEoTqBH7oAiLE_sHPFtNgI97gsUAwaY"}}	3
$5DYqRHQPE1SQt9QXHJodWH7x4Pztz3LTsgH1kdHawZs	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":9,"historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o"],"prev_events":["$q7m8fkdDrp2QE9hRAHYIR_KN8htxYXW85pB3LgG-V2U"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@user1.matrix:localhost","content":{"membership":"join","displayname":"User 1 - Matrix"},"depth":15,"prev_state":[],"state_key":"@user1.matrix:localhost","origin":"localhost","origin_server_ts":1673968543297,"hashes":{"sha256":"eJIR5F4vht6QEYhq2nSt2PPEnnBTLZtD7sPvmPWQqmY"},"signatures":{"localhost":{"ed25519:a_CHdg":"mwxRYsx+wYeuk+3ukw8KZukj/68cVE/za5NnzgFtF/dk3BGMnkRfRAtTtXDvyrDI7nvqKZC2dXS4fa13ce+ACA"}},"unsigned":{"age_ts":1673968543297}}	3
$TKcINA6W5qTH8raDaFqEMBivZ0LjgXtIHGvxzJ9V4_8	!dKcbdDATuwwphjRPQP:localhost	{"token_id":9,"historical":false}	{"auth_events":["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs"],"prev_events":["$cH796vSd1hy4UBg8XHAqeUxz-u3gxer-uMeGrsirKbs"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@user1.matrix:localhost","content":{"membership":"join","displayname":"User 1 - Matrix"},"depth":15,"prev_state":[],"state_key":"@user1.matrix:localhost","origin":"localhost","origin_server_ts":1673968600436,"hashes":{"sha256":"5KhFhmLZqCU2rUTBuynR1J4CG61BzTO1z4XMTA6y76w"},"signatures":{"localhost":{"ed25519:a_CHdg":"1XjE8XlG+2s82Raa0m6KKEIVQkjp8PAOGra/SYS8ZTVF754RoYS6OedL6d2pntVsTk2eMSeWDadU5KiJbTlQCg"}},"unsigned":{"age_ts":1673968600436}}	3
$REN0AaEE212pFbK8uJB-22lyjpnqTEP0SshUeVfsGU4	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$jyfZsVYOTCt8az1WqRlL53b1lAQWjIj6-IvW1w3qYks","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs"],"prev_events":["$TKcINA6W5qTH8raDaFqEMBivZ0LjgXtIHGvxzJ9V4_8"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"user1.mm [mm]"},"depth":16,"prev_state":[],"state_key":"@mm_user1.mm:localhost","origin":"localhost","origin_server_ts":1673969011769,"hashes":{"sha256":"mzRAqZOMbqu4fPlIRPifxEFz66oXIiQb85+c7QfmMJI"},"signatures":{"localhost":{"ed25519:a_CHdg":"xjZE4/SXM7plBtMLfqVkCLHUgM4MByFdNnqmO7KZWUakIe5VEh6eyxyQd8hEc5QVk7+PuwDtuY//4Y9AnUOXCA"}},"unsigned":{"age_ts":1673969011769,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#off-topic:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$AwutniYNkYl6Dxs-8zYvdPdGLIcM4Kyzaldut5D0jHQ	!dKcbdDATuwwphjRPQP:localhost	{"historical":false}	{"auth_events":["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs","$REN0AaEE212pFbK8uJB-22lyjpnqTEP0SshUeVfsGU4"],"prev_events":["$REN0AaEE212pFbK8uJB-22lyjpnqTEP0SshUeVfsGU4"],"type":"m.room.member","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_user1.mm:localhost","content":{"membership":"join","displayname":"user1.mm [mm]"},"depth":17,"prev_state":[],"state_key":"@mm_user1.mm:localhost","origin":"localhost","origin_server_ts":1673969012107,"hashes":{"sha256":"Ck3K8TO3NnnDj81s5ktEwev0UHzOqTS1hS4dMsvCDxg"},"signatures":{"localhost":{"ed25519:a_CHdg":"tXXlyLzOi8u6TG+g4LY9PZtOSsigg9j4sH7N+H4FtzMahoDkUzKxUwglUATNRn6XDgdoWadEIc4tf1xnDwv/AA"}},"unsigned":{"age_ts":1673969012107,"replaces_state":"$REN0AaEE212pFbK8uJB-22lyjpnqTEP0SshUeVfsGU4"}}	3
$HmGCTcPZGDbaswAPjYZ0ddKt1eWRcRq89rE-yVwDV0s	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$PkPxRt8GuXFqdWre9vyhqKHlRSqflC0cOSTBOims4qY","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o"],"prev_events":["$5DYqRHQPE1SQt9QXHJodWH7x4Pztz3LTsgH1kdHawZs"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"user1.mm [mm]"},"depth":16,"prev_state":[],"state_key":"@mm_user1.mm:localhost","origin":"localhost","origin_server_ts":1673969012213,"hashes":{"sha256":"/fnDI1ppNcBZmH8I/unmVWTWEclifp4OEzU32u4uqWw"},"signatures":{"localhost":{"ed25519:a_CHdg":"pOgY3RjSiMpqkymHJbL+JS6F+8SGjXje/Stw9H9WLMwMcdBmNFeFXvNUQsio8Mfm7SKUyEL+ypPTFjiXSB/RAw"}},"unsigned":{"age_ts":1673969012213,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#town-square:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"5","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$VFMUBSkD_jWG8nImBQfkmffKyLBdxGMpdkFACHA33Ng	!kmbTYjjsDRDHGgVqUP:localhost	{"historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o","$HmGCTcPZGDbaswAPjYZ0ddKt1eWRcRq89rE-yVwDV0s"],"prev_events":["$HmGCTcPZGDbaswAPjYZ0ddKt1eWRcRq89rE-yVwDV0s"],"type":"m.room.member","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@mm_user1.mm:localhost","content":{"membership":"join","displayname":"user1.mm [mm]"},"depth":17,"prev_state":[],"state_key":"@mm_user1.mm:localhost","origin":"localhost","origin_server_ts":1673969012530,"hashes":{"sha256":"txshquwElgJ0E/7Sqq+hL5pgO+P3tp1SiiQwD39AWbU"},"signatures":{"localhost":{"ed25519:a_CHdg":"K+wE91MTdKD/URlKm4WBpLRru0Vsu8Vsl6Q8o3RJcqDUXJf+LSv6ZqaC3NHYlS8v3qTN47UIrtJImtiDymulCg"}},"unsigned":{"age_ts":1673969012530,"replaces_state":"$HmGCTcPZGDbaswAPjYZ0ddKt1eWRcRq89rE-yVwDV0s"}}	3
$DTQEMlxc_4_CqP-rYQ46vmCpJtEKlxw_Ugma4cnNO6w	!dKcbdDATuwwphjRPQP:localhost	{"txn_id":"m1673972703204.0","historical":false}	{"auth_events":["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$AwutniYNkYl6Dxs-8zYvdPdGLIcM4Kyzaldut5D0jHQ"],"prev_events":["$AwutniYNkYl6Dxs-8zYvdPdGLIcM4Kyzaldut5D0jHQ"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_user1.mm:localhost","content":{"msgtype":"m.text","body":"Atque optio veritatis culpa harum amet dolorum aspernatur quidem quidem. Laborum voluptatibus est esse veniam. Nisi eligendi harum eos magni. Impedit incidunt occaecati atque deleniti."},"depth":18,"prev_state":[],"origin":"localhost","origin_server_ts":1673972703246,"hashes":{"sha256":"yfqHL2U/KpftPCekfdv7g3GBfpBTo7REvx+kthJVp5U"},"signatures":{"localhost":{"ed25519:a_CHdg":"QfXVgH33boHEaf2MLUtmbL9E9Ea1HTHDATTts8Li+aKkTJljVSrFK0+mmXMJHXeKy7B3lAEXAXPpO24K689UCQ"}},"unsigned":{"age_ts":1673972703246}}	3
$cIkI-00MET-_PQ4VaVFuuZsJ2WEz_UMnlXun9Itkqt8	!dKcbdDATuwwphjRPQP:localhost	{"txn_id":"m1673972847322.1","historical":false}	{"auth_events":["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$AwutniYNkYl6Dxs-8zYvdPdGLIcM4Kyzaldut5D0jHQ"],"prev_events":["$DTQEMlxc_4_CqP-rYQ46vmCpJtEKlxw_Ugma4cnNO6w"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_user1.mm:localhost","content":{"msgtype":"m.text","body":"Ratione sequi provident placeat blanditiis saepe autem fugit sed voluptatibus. Qui doloremque perferendis libero. Hic occaecati voluptatem atque cum. Minus atque consequuntur debitis enim suscipit corrupti cumque libero autem. Ullam commodi est perferendis dolor eligendi. Sint sit odit quibusdam."},"depth":19,"prev_state":[],"origin":"localhost","origin_server_ts":1673972847384,"hashes":{"sha256":"2jBRnrjfua13j14IOPu34WxLq8/9Nznwv8KUDinAcpg"},"signatures":{"localhost":{"ed25519:a_CHdg":"9MptvnHPoNNROZV323NFXyBx+f5iNdf3A5lkf8Y0ixoR+uMSVV4qbEOenZo69JEXO4rWle+3yRPo4Dx+nyFJDg"}},"unsigned":{"age_ts":1673972847384}}	3
$CsT9BKDbT6nCfiXJCOAHV90fgB6fYV4boIF3v6eEls4	!dKcbdDATuwwphjRPQP:localhost	{"txn_id":"m1673972918728.2","historical":false}	{"auth_events":["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$AwutniYNkYl6Dxs-8zYvdPdGLIcM4Kyzaldut5D0jHQ"],"prev_events":["$cIkI-00MET-_PQ4VaVFuuZsJ2WEz_UMnlXun9Itkqt8"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_user1.mm:localhost","content":{"msgtype":"m.text","body":"Totam ullam nemo earum. Vero fugiat ratione enim maxime molestias. Quae voluptate ut alias nemo deserunt. Rem est quis expedita. Molestiae assumenda est architecto quod occaecati aperiam ut. Occaecati eligendi explicabo non tenetur sit."},"depth":20,"prev_state":[],"origin":"localhost","origin_server_ts":1673972918773,"hashes":{"sha256":"iwA/QtWMxvT75U9N7IG+ZKij7KtE3r8ZEJE8KLGvCIQ"},"signatures":{"localhost":{"ed25519:a_CHdg":"lXG5DM0yBhwFCNqDHjky+r+wFaPTkIbiEB3McOzZb7GlzMzIoWagB3m+DWNNKcNEzn05LsbsK2njSOZhUjajAQ"}},"unsigned":{"age_ts":1673972918773}}	3
$3Q6XqtJGvGa1jhhtRN9kQqoLIWqjikrH3x7yltwaZ6w	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":11,"txn_id":"m1673972961031.0","historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$5DYqRHQPE1SQt9QXHJodWH7x4Pztz3LTsgH1kdHawZs"],"prev_events":["$VFMUBSkD_jWG8nImBQfkmffKyLBdxGMpdkFACHA33Ng"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@user1.matrix:localhost","content":{"org.matrix.msc1767.text":"Playwright Test - Message from Element ","body":"Playwright Test - Message from Element ","msgtype":"m.text"},"depth":18,"prev_state":[],"origin":"localhost","origin_server_ts":1673972961213,"hashes":{"sha256":"Vw5yqXTcOb2kUwUOeL9Eb1aR+4BHWS8Ux1pY8jgm5p4"},"signatures":{"localhost":{"ed25519:a_CHdg":"n8fjLbAyUrWSorEHFfDaedEmCO2x5MxGjQhPXtXO6jQq2eSlZ8lymV6oiOxAqR4tRAJ3O7OFKu58x+DObfZZBw"}},"unsigned":{"age_ts":1673972961213}}	3
$pulJgsd1znNtSba8MCpZoXTCHhxSC0OkMutE8dDzlO0	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":11,"txn_id":"m1673972963124.1","historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$5DYqRHQPE1SQt9QXHJodWH7x4Pztz3LTsgH1kdHawZs"],"prev_events":["$3Q6XqtJGvGa1jhhtRN9kQqoLIWqjikrH3x7yltwaZ6w"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@user1.matrix:localhost","content":{"org.matrix.msc1767.text":"URL=http://localhost:8080 risky Browser=false ","body":"URL=http://localhost:8080 risky Browser=false ","msgtype":"m.text"},"depth":19,"prev_state":[],"origin":"localhost","origin_server_ts":1673972964497,"hashes":{"sha256":"okOhyWh5bBYRR1au0sWE7DoxpsFMckZwYbd9dXGFLXg"},"signatures":{"localhost":{"ed25519:a_CHdg":"r9s327Mza319QMneQY8zPXmxE0z56f1GHJbOycVumznSXHrNKjD17WPXvLDZFTHBh0cAgmIPvhT9OXt0uVGZCg"}},"unsigned":{"age_ts":1673972964497}}	3
$JghGsUh3v1rikXL8gETZ_UJKjZC_6NY_WEgHUWlDGUM	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":11,"txn_id":"m1673972964789.2","historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU","$5DYqRHQPE1SQt9QXHJodWH7x4Pztz3LTsgH1kdHawZs"],"prev_events":["$pulJgsd1znNtSba8MCpZoXTCHhxSC0OkMutE8dDzlO0"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@user1.matrix:localhost","content":{"org.matrix.msc1767.text":"Timestamp=1673972959618","body":"Timestamp=1673972959618","msgtype":"m.text"},"depth":20,"prev_state":[],"origin":"localhost","origin_server_ts":1673972965174,"hashes":{"sha256":"2CATm+JXc3GFisXjpx01xhxAAARPd95cRGfYBRInr6k"},"signatures":{"localhost":{"ed25519:a_CHdg":"nvnWpCT+slSHUlT35Qv3VVxpPivbYH7oWkFEL4j/Zip++8qNZvkg+qOa+v8GByR/Bwh1pot6wC0W3N2hJ+bOBg"}},"unsigned":{"age_ts":1673972965174}}	3
$pec3QOL9YU-4d4ww5taJYfFCSKUcMIUYBRSHQoML6Vw	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":4,"txn_id":"m.1673974498973","historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$szFQBuhhfXcOIlgReai0669p3ycU-w57s91VHUKWXFA"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_b:localhost","content":{"body":"Strange message seen:\\nIf we input the system, we can get to the SAS driver through the haptic SDD capacitor!\\n from Cary.Bahringer89@hotmail.com","msgtype":"m.text"},"depth":26,"prev_state":[],"origin":"localhost","origin_server_ts":1673974499038,"hashes":{"sha256":"S9PxOkrdXGzmXywmO6ZSiMOzauUUMwlPRp0eCk90m0g"},"signatures":{"localhost":{"ed25519:a_CHdg":"CtiVm42abLON1u6hSXudccY1mRpwLvBjZiVNJ9Pdd9WcJn5RZyPE2yWH7oQDZIqsKi/lp9VZqV17vaqEMLWYDw"}},"unsigned":{"age_ts":1673974499038}}	3
$COcCgODcXP3YBig5Vk-_QDtWh0rzx9K1yVAasfvXRVk	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":4,"txn_id":"m.1673973089227","historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$JghGsUh3v1rikXL8gETZ_UJKjZC_6NY_WEgHUWlDGUM"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_b:localhost","content":{"body":"Strange message seen:\\nsynthesizing the card won't do anything, we need to generate the virtual EXE transmitter!\\n from Ross_Klein19@hotmail.com","msgtype":"m.text"},"depth":21,"prev_state":[],"origin":"localhost","origin_server_ts":1673973089277,"hashes":{"sha256":"GrfxyB69xt3hruhEWRdf/50+rOcpmS50QDwH2GzN2ow"},"signatures":{"localhost":{"ed25519:a_CHdg":"VnqAJm9508NhWoddgHMKnY7BWgjvjuwX7sxmX2KGtFaYKqJcKKydABppuzXSoIVweO8WUMlnyp8M4/ixLFrXDQ"}},"unsigned":{"age_ts":1673973089277}}	3
$lGC_2RlgCMjLDCMd4bkjzCmXnXFQHNvnd9eFy28BE8E	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":4,"txn_id":"m.1673973777200","historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$COcCgODcXP3YBig5Vk-_QDtWh0rzx9K1yVAasfvXRVk"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_b:localhost","content":{"body":"Strange message seen:\\nYou can't copy the panel without navigating the neural RAM sensor!\\n from Elouise_Torphy@hotmail.com","msgtype":"m.text"},"depth":22,"prev_state":[],"origin":"localhost","origin_server_ts":1673973777265,"hashes":{"sha256":"CWgFGPjYHllIMJACorOPPjOmbXudNiDrz8FNDNSBhbw"},"signatures":{"localhost":{"ed25519:a_CHdg":"yDC8sf+9xfCzEe1BDWUPORKHtL63zFB9RhEate+iSAGvRuQ6ELfuK9KxDTmwQwxCqwObmoABq87Iz9H6hKARBA"}},"unsigned":{"age_ts":1673973777265}}	3
$iPEm9yDTEtMvd-r8SFs0eTz8dpjdWAFHcpWpOTKCqkk	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":4,"txn_id":"m.1673974303712","historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$lGC_2RlgCMjLDCMd4bkjzCmXnXFQHNvnd9eFy28BE8E"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_b:localhost","content":{"body":"Strange message seen:\\nThe SMS alarm is down, override the back-end driver so we can copy the HTTP array!\\n from Keenan72@yahoo.com","msgtype":"m.text"},"depth":23,"prev_state":[],"origin":"localhost","origin_server_ts":1673974303789,"hashes":{"sha256":"VdIyJLY5bC17a9bNqYcI73jq+X1vRMYMjk/Z8bgFH68"},"signatures":{"localhost":{"ed25519:a_CHdg":"J5bTRd4Wo1nncArtb4DteXMk2Pe/OvT6qOvaG328DWDowc1hQ4mYB14ExZ1CtGC6L07SwcWaiUrP816sd7/mDg"}},"unsigned":{"age_ts":1673974303789}}	3
$Ay9Au4hI33NjvpwrmfU6OSnS-_gSjFb5bRzB6756wKo	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":4,"txn_id":"m.1673974370452","historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$iPEm9yDTEtMvd-r8SFs0eTz8dpjdWAFHcpWpOTKCqkk"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_b:localhost","content":{"body":"Strange message seen:\\nYou can't bypass the firewall without connecting the primary USB microchip!\\n from Ben.Sawayn86@hotmail.com","msgtype":"m.text"},"depth":24,"prev_state":[],"origin":"localhost","origin_server_ts":1673974370506,"hashes":{"sha256":"rZCQRmrIQGdI+sF2pMnW2ky1/HKbB5TRxh7tyvnMzuk"},"signatures":{"localhost":{"ed25519:a_CHdg":"IgzZNogRhlnsJJS+4LzqBLEA5J0Yckt4ecqgnbp5ZVU+tEPrw/NhVHfWun++ULE2TMIDd1WvXW6EH+XcmhxOAw"}},"unsigned":{"age_ts":1673974370506}}	3
$ckvkcjvKmxJljo0NX3W1BFf-JQMuUnFbh-r9CNPtmR4	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":4,"txn_id":"m.1673974509065","historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$pec3QOL9YU-4d4ww5taJYfFCSKUcMIUYBRSHQoML6Vw"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_b:localhost","content":{"body":"Strange message seen:\\nIf we hack the monitor, we can get to the HEX hard drive through the wireless USB port!\\n from Carolyn.Kshlerin@hotmail.com","msgtype":"m.text"},"depth":27,"prev_state":[],"origin":"localhost","origin_server_ts":1673974509109,"hashes":{"sha256":"JJoA8YwJrBIGfOPUZpiy59FZALXMLxyjfM0h02IKAIM"},"signatures":{"localhost":{"ed25519:a_CHdg":"gYhHbUo1pN2470mpqHgtbUR0HJq/QksKzNHQu7ATBLjHCVSZaJZ2ctthrRv4g3L2KhscmyPIyyrRm18TZ9UWCw"}},"unsigned":{"age_ts":1673974509109}}	3
$szFQBuhhfXcOIlgReai0669p3ycU-w57s91VHUKWXFA	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":4,"txn_id":"m.1673974421488","historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$Ay9Au4hI33NjvpwrmfU6OSnS-_gSjFb5bRzB6756wKo"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_b:localhost","content":{"body":"Strange message seen:\\nThe IB bus is down, reboot the solid state sensor so we can input the UTF8 protocol!\\n from Kaelyn.Wilkinson61@hotmail.com","msgtype":"m.text"},"depth":25,"prev_state":[],"origin":"localhost","origin_server_ts":1673974421534,"hashes":{"sha256":"ACF1dt2Wz7l0ibgLXc+oMLevtsLDOkylmDj4x75O/pg"},"signatures":{"localhost":{"ed25519:a_CHdg":"4G9Uh+QqfDfIzYteuahmQmo6rOlLMhg/3ZZ5Ho+Hu7NV9xMjC9gGOzVPpU6UILPnKJcL70fUfwvNYQKegFfKCg"}},"unsigned":{"age_ts":1673974421534}}	3
$Ss566NPFclWN6Mx7hHv8fd_JaawsG1AuM6gnlM7fA-k	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":4,"txn_id":"m.1673974556784","historical":false}	{"auth_events":["$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$ckvkcjvKmxJljo0NX3W1BFf-JQMuUnFbh-r9CNPtmR4"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@matrix_b:localhost","content":{"body":"Strange message seen:\\nUse the online HDD driver, then you can index the auxiliary alarm!\\n from Wallace_Stoltenberg36@gmail.com","msgtype":"m.text"},"depth":28,"prev_state":[],"origin":"localhost","origin_server_ts":1673974556817,"hashes":{"sha256":"brf5Pf1rdl86HTTILMiB89C3wAwBATj0Fy4pBJNGMqE"},"signatures":{"localhost":{"ed25519:a_CHdg":"sj4M04zMeg9mcdDQrjBGUE4rTAcTnarl0TDUPpd1Bh204CXfCiFs4A6ErC+rK2csfFEjOqFpBVdDFzLcZzeICg"}},"unsigned":{"age_ts":1673974556817}}	3
$focovH6Yc-m2CXhjrx4lhMQHQhQODpLp4g1sKHOxfaU	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":13,"txn_id":"m1674060065249.0","historical":false}	{"auth_events":["$5DYqRHQPE1SQt9QXHJodWH7x4Pztz3LTsgH1kdHawZs","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$Ss566NPFclWN6Mx7hHv8fd_JaawsG1AuM6gnlM7fA-k"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@user1.matrix:localhost","content":{"org.matrix.msc1767.text":"Playwright Test - Message from Element ","body":"Playwright Test - Message from Element ","msgtype":"m.text"},"depth":29,"prev_state":[],"origin":"localhost","origin_server_ts":1674060065363,"hashes":{"sha256":"C4Ubf4di5MfSKZ4ECPwS08IpQjagvyz/5plILcCjAeo"},"signatures":{"localhost":{"ed25519:a_CHdg":"qFd+/h+WMVlc4e+UgA3YQsxJo7ax2ePNdLGo/IYMxLWmjWzX7lqw1vIPrSEWpbxbCAFbH6L4mFG0qtsh3IPuBQ"}},"unsigned":{"age_ts":1674060065363}}	3
$Y8T81hxoxP5Ta-IxCarhZjMk4fWMtcg9FlgmTG9VgiE	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":13,"txn_id":"m1674060067103.1","historical":false}	{"auth_events":["$5DYqRHQPE1SQt9QXHJodWH7x4Pztz3LTsgH1kdHawZs","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$focovH6Yc-m2CXhjrx4lhMQHQhQODpLp4g1sKHOxfaU"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@user1.matrix:localhost","content":{"org.matrix.msc1767.text":"URL=http://localhost:8080 risky Browser=false ","body":"URL=http://localhost:8080 risky Browser=false ","msgtype":"m.text"},"depth":30,"prev_state":[],"origin":"localhost","origin_server_ts":1674060068418,"hashes":{"sha256":"yv0mgTpV3gqbgzeTw1YDLkF1hHq/5SK+qFWg4XBEhC0"},"signatures":{"localhost":{"ed25519:a_CHdg":"ZQOfCzFGWyiq8XEy7QJouT2lpoR7rEHm/sXivs31O67IWx0xbep1RPG4ylI7ROyQdkPQv1sc+dnx7c/QeR7EBg"}},"unsigned":{"age_ts":1674060068418}}	3
$RVi3Hrw_NGpZOOlLIRSt-m_lPWPYt0K7JLecNmlU1Sw	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":13,"txn_id":"m1674060068614.2","historical":false}	{"auth_events":["$5DYqRHQPE1SQt9QXHJodWH7x4Pztz3LTsgH1kdHawZs","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$Y8T81hxoxP5Ta-IxCarhZjMk4fWMtcg9FlgmTG9VgiE"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@user1.matrix:localhost","content":{"org.matrix.msc1767.text":"Timestamp=1674060064296","body":"Timestamp=1674060064296","msgtype":"m.text"},"depth":31,"prev_state":[],"origin":"localhost","origin_server_ts":1674060069066,"hashes":{"sha256":"Iryb+u9B0Es6M+rdEKiiMZdHqrKIKH3peh9Pw3C4Utk"},"signatures":{"localhost":{"ed25519:a_CHdg":"wQuHkxDKH2cZHOm31v1HOi45d6H7MnVqXoNzt8PrIXYSGvbqInwGDYUVfPzuL3VoPADjsZ/bomoYj01ZkJ3lAA"}},"unsigned":{"age_ts":1674060069066}}	3
$NfGFxRqIrSmaeLcN53BGirnWzJ1bpwzVyt2oZw2cj1k	!BfSgfecvJnYoZjTYRA:localhost	{"token_id":14,"historical":false}	{"auth_events":[],"prev_events":[],"type":"m.room.create","room_id":"!BfSgfecvJnYoZjTYRA:localhost","sender":"@user1.matrix:localhost","content":{"room_version":"6","creator":"@user1.matrix:localhost"},"depth":1,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1674111194830,"hashes":{"sha256":"+WKZafWA94CPKln4iJq3XDEQVaGNiFEgmYEZorof4Ds"},"signatures":{"localhost":{"ed25519:a_CHdg":"kh/20rKt5AHsQZseIqp3lQXQIzkPT5UOXJASu7h5BoB4w37nvgn61jn1oT5iVh7izEuRfbpbu3KcdPCBp3OnCg"}},"unsigned":{"age_ts":1674111194830}}	3
$7N18oPwd46twVh-RWhED6VAPm79aIXVCh_BVUFAFHP8	!BfSgfecvJnYoZjTYRA:localhost	{"token_id":14,"historical":false}	{"auth_events":["$NfGFxRqIrSmaeLcN53BGirnWzJ1bpwzVyt2oZw2cj1k"],"prev_events":["$NfGFxRqIrSmaeLcN53BGirnWzJ1bpwzVyt2oZw2cj1k"],"type":"m.room.member","room_id":"!BfSgfecvJnYoZjTYRA:localhost","sender":"@user1.matrix:localhost","content":{"membership":"join","displayname":"User 1 - Matrix"},"depth":2,"prev_state":[],"state_key":"@user1.matrix:localhost","origin":"localhost","origin_server_ts":1674111195055,"hashes":{"sha256":"AgYgvuRPO8pPrR1QhKMWwvHyX8/ftdx//fVMXxi2AYM"},"signatures":{"localhost":{"ed25519:a_CHdg":"UAHBdX47BQ43GkmIjdfwJqAQTLIf6Tg2WaE9Bt5SrZ8ZsF0VCjGE2CWOH5DJGtqMaMMckX5Bbg1MtMjYKuuuCw"}},"unsigned":{"age_ts":1674111195055}}	3
$eKvf8PFaZwsEOXW-IIYTGZwl6gxEYmEE2TalB5k2iGs	!BfSgfecvJnYoZjTYRA:localhost	{"token_id":14,"historical":false}	{"auth_events":["$7N18oPwd46twVh-RWhED6VAPm79aIXVCh_BVUFAFHP8","$NfGFxRqIrSmaeLcN53BGirnWzJ1bpwzVyt2oZw2cj1k"],"prev_events":["$7N18oPwd46twVh-RWhED6VAPm79aIXVCh_BVUFAFHP8"],"type":"m.room.power_levels","room_id":"!BfSgfecvJnYoZjTYRA:localhost","sender":"@user1.matrix:localhost","content":{"users":{"@user1.matrix:localhost":100},"users_default":0,"events":{"m.room.name":50,"m.room.power_levels":100,"m.room.history_visibility":100,"m.room.canonical_alias":50,"m.room.avatar":50,"m.room.tombstone":100,"m.room.server_acl":100,"m.room.encryption":100},"events_default":0,"state_default":50,"ban":50,"kick":50,"redact":50,"invite":50,"historical":100},"depth":3,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1674111195193,"hashes":{"sha256":"Ypbkur5SbxMsgWtFgWRen5EqStuQHQI1JSCwG8zX/BQ"},"signatures":{"localhost":{"ed25519:a_CHdg":"CEmRia4TUM+rGAm6ekIaFfpZQGz18yW1KRYPvp5Q+VW/RjJQ7Gf17V28MThH0ACLMxFOTiJSO5/fFTHbrGQUCA"}},"unsigned":{"age_ts":1674111195193}}	3
$VI4y-gfFPbzFuAM6S6F4gXfpeWta-thThcGlPN0xQN0	!FSwSlJXpOZZONTVfGs:localhost	{"token_id":15,"historical":false}	{"auth_events":[],"prev_events":[],"type":"m.room.create","room_id":"!FSwSlJXpOZZONTVfGs:localhost","sender":"@user1.matrix:localhost","content":{"room_version":"9","creator":"@user1.matrix:localhost"},"depth":1,"state_key":"","origin":"localhost","origin_server_ts":1674211359282,"hashes":{"sha256":"rTn2gf9kywvIzdSxsnyV4eFEtZOr+Ycy4a1zCAWKeZ8"},"signatures":{"localhost":{"ed25519:a_vyji":"zZwB9Hf0OCyaYfSPnPfvEHDyJPjzAYYU3LPfAfbDb4mK0zbAonUR2/t+7Mp6lNjz0XXnadznVqSdreQBqZ0fDA"}},"unsigned":{"age_ts":1674211359282}}	3
$Uf6bLI9lxBnR9TJvz8fcfo-1_wbshzMvT4Ecr_qy-E4	!BfSgfecvJnYoZjTYRA:localhost	{"token_id":14,"historical":false}	{"auth_events":["$7N18oPwd46twVh-RWhED6VAPm79aIXVCh_BVUFAFHP8","$eKvf8PFaZwsEOXW-IIYTGZwl6gxEYmEE2TalB5k2iGs","$NfGFxRqIrSmaeLcN53BGirnWzJ1bpwzVyt2oZw2cj1k"],"prev_events":["$ZraIWv18CC1pTAGQZToI1ZXr7ki_53OY_jvQl0RDE_A"],"type":"m.room.join_rules","room_id":"!BfSgfecvJnYoZjTYRA:localhost","sender":"@user1.matrix:localhost","content":{"join_rule":"public"},"depth":5,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1674111195684,"hashes":{"sha256":"a7UKtHLmLk6cI/efTNXB7vHbZ7sO6U9gy9W1U9mbOOw"},"signatures":{"localhost":{"ed25519:a_CHdg":"ff2nhq7TQC8gZDZAsxqLTU7v+oBdBfHavdoBphx+fPVqjgBCjc9KZvG2PjbppKn6F/uqqzL4SQpk3RxlSZ3vCg"}},"unsigned":{"age_ts":1674111195684}}	3
$30q15kBxfYB9Dyc1sAhoNXYpZXfDlneq4Ckvuz_Sy1Y	!BfSgfecvJnYoZjTYRA:localhost	{"token_id":14,"historical":false}	{"auth_events":["$7N18oPwd46twVh-RWhED6VAPm79aIXVCh_BVUFAFHP8","$eKvf8PFaZwsEOXW-IIYTGZwl6gxEYmEE2TalB5k2iGs","$NfGFxRqIrSmaeLcN53BGirnWzJ1bpwzVyt2oZw2cj1k"],"prev_events":["$Uf6bLI9lxBnR9TJvz8fcfo-1_wbshzMvT4Ecr_qy-E4"],"type":"m.room.history_visibility","room_id":"!BfSgfecvJnYoZjTYRA:localhost","sender":"@user1.matrix:localhost","content":{"history_visibility":"shared"},"depth":6,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1674111195816,"hashes":{"sha256":"NaFSVF48Ya7Nge+JVBi+5Jh3gdk5QAbJziscifSViMk"},"signatures":{"localhost":{"ed25519:a_CHdg":"hdHWmtgStU4lXMmTYTtuPYbffipHRgPYZVDG9VBadZg35SSpSq3lr80Rg+dPyK3+NsFUI9bqhyUCRqZ4RqYsAg"}},"unsigned":{"age_ts":1674111195816}}	3
$wlATKVSoZpEXfwFpmdptZK6V2TMFQ87Bjjhru1P3dGs	!BfSgfecvJnYoZjTYRA:localhost	{"token_id":14,"historical":false}	{"auth_events":["$7N18oPwd46twVh-RWhED6VAPm79aIXVCh_BVUFAFHP8","$eKvf8PFaZwsEOXW-IIYTGZwl6gxEYmEE2TalB5k2iGs","$NfGFxRqIrSmaeLcN53BGirnWzJ1bpwzVyt2oZw2cj1k"],"prev_events":["$30q15kBxfYB9Dyc1sAhoNXYpZXfDlneq4Ckvuz_Sy1Y"],"type":"m.room.name","room_id":"!BfSgfecvJnYoZjTYRA:localhost","sender":"@user1.matrix:localhost","content":{"name":"My Dining"},"depth":7,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1674111195964,"hashes":{"sha256":"Fp/UvkF5H1zlZfwyNIPL9jNAO5EnKrzcz/MAEQlHC8I"},"signatures":{"localhost":{"ed25519:a_CHdg":"AG+TyDDsUR2Z70OIoaDdSznJ8xmBocAa8ki6rIBECFVhZ+bb6+rR+ImJHaydRx1d5oVzYihUnVhogd7O97vjDw"}},"unsigned":{"age_ts":1674111195964}}	3
$PZkmtd-Zj4an2Acc9O8V-mK2mVxXChviZhd_hsf6Ehg	!BfSgfecvJnYoZjTYRA:localhost	{"token_id":14,"historical":false}	{"auth_events":["$7N18oPwd46twVh-RWhED6VAPm79aIXVCh_BVUFAFHP8","$eKvf8PFaZwsEOXW-IIYTGZwl6gxEYmEE2TalB5k2iGs","$NfGFxRqIrSmaeLcN53BGirnWzJ1bpwzVyt2oZw2cj1k","$Uf6bLI9lxBnR9TJvz8fcfo-1_wbshzMvT4Ecr_qy-E4"],"prev_events":["$wlATKVSoZpEXfwFpmdptZK6V2TMFQ87Bjjhru1P3dGs"],"type":"m.room.member","room_id":"!BfSgfecvJnYoZjTYRA:localhost","sender":"@user1.matrix:localhost","content":{"membership":"invite","displayname":"MattermostUser A [mm]"},"depth":8,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1674111228158,"hashes":{"sha256":"FX0M/qbryrL6N606CKjl7UADkHaKjc715gHDYVc9FOg"},"signatures":{"localhost":{"ed25519:a_CHdg":"eOrLzfA0lWGfQe0O51Gg4rJn6wf9n7Tx902GbxFZ713r84U5TD7uQm8dUeXJFpFD2shn0g6tjC6hj8BanXUVDQ"}},"unsigned":{"age_ts":1674111228158,"invite_room_state":[{"type":"m.room.create","state_key":"","content":{"room_version":"6","creator":"@user1.matrix:localhost"},"sender":"@user1.matrix:localhost"},{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#my.dining:localhost"},"sender":"@user1.matrix:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@user1.matrix:localhost"},{"type":"m.room.name","state_key":"","content":{"name":"My Dining"},"sender":"@user1.matrix:localhost"},{"type":"m.room.member","state_key":"@user1.matrix:localhost","content":{"membership":"join","displayname":"User 1 - Matrix"},"sender":"@user1.matrix:localhost"}]}}	3
$ZF1U_gGvucrvqj1m7ffy4HKGxUsoAbYKpWzUjaPqlMM	!BfSgfecvJnYoZjTYRA:localhost	{"token_id":14,"txn_id":"m1674111244810.0","historical":false}	{"auth_events":["$7N18oPwd46twVh-RWhED6VAPm79aIXVCh_BVUFAFHP8","$eKvf8PFaZwsEOXW-IIYTGZwl6gxEYmEE2TalB5k2iGs","$NfGFxRqIrSmaeLcN53BGirnWzJ1bpwzVyt2oZw2cj1k"],"prev_events":["$PZkmtd-Zj4an2Acc9O8V-mK2mVxXChviZhd_hsf6Ehg"],"type":"m.room.message","room_id":"!BfSgfecvJnYoZjTYRA:localhost","sender":"@user1.matrix:localhost","content":{"org.matrix.msc1767.text":"Send a message","body":"Send a message","msgtype":"m.text"},"depth":9,"prev_state":[],"origin":"localhost","origin_server_ts":1674111244960,"hashes":{"sha256":"zz0zWIpjmnX1IJYl/nN4tNvm5beRJNrmC/J6m8aurDY"},"signatures":{"localhost":{"ed25519:a_CHdg":"JUF1OsX9AJQx45AclslVaFy35eepv5CBRD0kl+tk5n7+rW4eAvLQeo9Traali7SrQlFxNByE616bTCGrZoP4BQ"}},"unsigned":{"age_ts":1674111244960}}	3
$pIVIlPgvO-fbiW31dx4GB-wsRX4DrbADDn1AfJoXI50	!pWsdJYvpdmDULVhQtX:localhost	{"token_id":14,"historical":false}	{"auth_events":[],"prev_events":[],"type":"m.room.create","room_id":"!pWsdJYvpdmDULVhQtX:localhost","sender":"@user1.matrix:localhost","content":{"room_version":"6","creator":"@user1.matrix:localhost"},"depth":1,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1674111389371,"hashes":{"sha256":"ufBP21oQZUAnPwXydLnonuvbrL0mETadpqG+W1Y14IU"},"signatures":{"localhost":{"ed25519:a_CHdg":"ujepKquZEck1PLJI6MvAg6TyFlG51wXfA6mbkKRo6rtQR8B8kqdgAIsEhdDAG84RRgHapduSfhgJGyhHEE4gDw"}},"unsigned":{"age_ts":1674111389371}}	3
$bWqW6N4T6ZlJ3MzEaI-MgqdvMEklGrNsy22WqL6ZgOc	!pWsdJYvpdmDULVhQtX:localhost	{"token_id":14,"historical":false}	{"auth_events":["$pIVIlPgvO-fbiW31dx4GB-wsRX4DrbADDn1AfJoXI50"],"prev_events":["$pIVIlPgvO-fbiW31dx4GB-wsRX4DrbADDn1AfJoXI50"],"type":"m.room.member","room_id":"!pWsdJYvpdmDULVhQtX:localhost","sender":"@user1.matrix:localhost","content":{"membership":"join","displayname":"User 1 - Matrix"},"depth":2,"prev_state":[],"state_key":"@user1.matrix:localhost","origin":"localhost","origin_server_ts":1674111389486,"hashes":{"sha256":"pheyhkL+cvihVSfdghdZObtoNlbklHE1w5J5Q62m00w"},"signatures":{"localhost":{"ed25519:a_CHdg":"9EnhyDwevijfYnwPjcUoTXDuz41CChej4JIseW2uZsJgNQIV66l26Q9Yt5jjROYBf9O1NoTVYk/d+sqzXNcsCg"}},"unsigned":{"age_ts":1674111389486}}	3
$ngKTLt0SDFtdjkF6GnjahEcDA-qLwTKRcVgMgMg5tN8	!pWsdJYvpdmDULVhQtX:localhost	{"token_id":14,"historical":false}	{"auth_events":["$bWqW6N4T6ZlJ3MzEaI-MgqdvMEklGrNsy22WqL6ZgOc","$pIVIlPgvO-fbiW31dx4GB-wsRX4DrbADDn1AfJoXI50"],"prev_events":["$bWqW6N4T6ZlJ3MzEaI-MgqdvMEklGrNsy22WqL6ZgOc"],"type":"m.room.power_levels","room_id":"!pWsdJYvpdmDULVhQtX:localhost","sender":"@user1.matrix:localhost","content":{"users":{"@user1.matrix:localhost":100},"users_default":0,"events":{"m.room.name":50,"m.room.power_levels":100,"m.room.history_visibility":100,"m.room.canonical_alias":50,"m.room.avatar":50,"m.room.tombstone":100,"m.room.server_acl":100,"m.room.encryption":100},"events_default":0,"state_default":50,"ban":50,"kick":50,"redact":50,"invite":50,"historical":100},"depth":3,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1674111389629,"hashes":{"sha256":"rPJrh+g3fTHKM0DkRc1nc/Pyt4uyM8xlxwIKWW0eLjc"},"signatures":{"localhost":{"ed25519:a_CHdg":"skWVXgr/gk+XyO9bFpihkmjUTFOTbFmNmTV/ItcT2esSMyn8Kk0WwwkMLmwHrHzCvEBNf/n4mKoF1b8VE94nCQ"}},"unsigned":{"age_ts":1674111389629}}	3
$IxyNn3A4NegMug4xc7O0sm2s1r9jyybU5iNogwEGesQ	!pWsdJYvpdmDULVhQtX:localhost	{"token_id":14,"historical":false}	{"auth_events":["$bWqW6N4T6ZlJ3MzEaI-MgqdvMEklGrNsy22WqL6ZgOc","$ngKTLt0SDFtdjkF6GnjahEcDA-qLwTKRcVgMgMg5tN8","$pIVIlPgvO-fbiW31dx4GB-wsRX4DrbADDn1AfJoXI50"],"prev_events":["$ngKTLt0SDFtdjkF6GnjahEcDA-qLwTKRcVgMgMg5tN8"],"type":"m.room.canonical_alias","room_id":"!pWsdJYvpdmDULVhQtX:localhost","sender":"@user1.matrix:localhost","content":{"alias":"#sports:localhost"},"depth":4,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1674111390126,"hashes":{"sha256":"Isn1ra4r9gGEsL/f0CLq+jPtx0u3JVUD+/6XAAPswK8"},"signatures":{"localhost":{"ed25519:a_CHdg":"qtNPwPVsq2aXao+kj847h/01GBO/b/3AGgrTTwY/TJzOLbTmhfs6YwzDdXiAlyt4HFgqY1nX2gQGa671qgykCA"}},"unsigned":{"age_ts":1674111390126}}	3
$SQpUzgCCeFIrGC3eCPDX_U021w7MG0-lHOxFTcHbvKk	!pWsdJYvpdmDULVhQtX:localhost	{"token_id":14,"historical":false}	{"auth_events":["$bWqW6N4T6ZlJ3MzEaI-MgqdvMEklGrNsy22WqL6ZgOc","$ngKTLt0SDFtdjkF6GnjahEcDA-qLwTKRcVgMgMg5tN8","$pIVIlPgvO-fbiW31dx4GB-wsRX4DrbADDn1AfJoXI50"],"prev_events":["$IxyNn3A4NegMug4xc7O0sm2s1r9jyybU5iNogwEGesQ"],"type":"m.room.join_rules","room_id":"!pWsdJYvpdmDULVhQtX:localhost","sender":"@user1.matrix:localhost","content":{"join_rule":"public"},"depth":5,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1674111390459,"hashes":{"sha256":"bmAOpLVOlGF1hL/vjg1SuMwFTzYLvfFWhBKf/2QDD5I"},"signatures":{"localhost":{"ed25519:a_CHdg":"V9D02egI0GVpowPL+lD5hi4FYc4u1TXduRmg0WIEwDgqhJL0RNIMUxv5RClaGVC+71/+O5zrbpqxZMnJA6d/DA"}},"unsigned":{"age_ts":1674111390459}}	3
$pe2Yi2ila5QgzVKIEGGAIeqvcRaD37GUFMvAOWX2tp0	!pWsdJYvpdmDULVhQtX:localhost	{"token_id":14,"historical":false}	{"auth_events":["$bWqW6N4T6ZlJ3MzEaI-MgqdvMEklGrNsy22WqL6ZgOc","$ngKTLt0SDFtdjkF6GnjahEcDA-qLwTKRcVgMgMg5tN8","$pIVIlPgvO-fbiW31dx4GB-wsRX4DrbADDn1AfJoXI50"],"prev_events":["$SQpUzgCCeFIrGC3eCPDX_U021w7MG0-lHOxFTcHbvKk"],"type":"m.room.history_visibility","room_id":"!pWsdJYvpdmDULVhQtX:localhost","sender":"@user1.matrix:localhost","content":{"history_visibility":"shared"},"depth":6,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1674111390687,"hashes":{"sha256":"bRl5l0EIGz62TkLOF9ncqVAO1zDpnTNfR+fYhs6qGOk"},"signatures":{"localhost":{"ed25519:a_CHdg":"7dY365NcpxGVFCoLbwK8cT2/8XwgAGIyJfFPWSuf8YBB4wVf+3J/TU1swb+qJzKq268NyLOK//R7X6eMFvebDg"}},"unsigned":{"age_ts":1674111390687}}	3
$_MdWHbg9mI3zN-WDGIpwDRJZmDWXBeW-m3WrJiRs4t8	!pWsdJYvpdmDULVhQtX:localhost	{"token_id":14,"historical":false}	{"auth_events":["$bWqW6N4T6ZlJ3MzEaI-MgqdvMEklGrNsy22WqL6ZgOc","$ngKTLt0SDFtdjkF6GnjahEcDA-qLwTKRcVgMgMg5tN8","$pIVIlPgvO-fbiW31dx4GB-wsRX4DrbADDn1AfJoXI50"],"prev_events":["$pe2Yi2ila5QgzVKIEGGAIeqvcRaD37GUFMvAOWX2tp0"],"type":"m.room.name","room_id":"!pWsdJYvpdmDULVhQtX:localhost","sender":"@user1.matrix:localhost","content":{"name":"Sports"},"depth":7,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1674111390825,"hashes":{"sha256":"KDwHmmOOU2W1LOKOfpJd6mhtOw772WZwUD8iwY5W10U"},"signatures":{"localhost":{"ed25519:a_CHdg":"dy54njsSUJGRq9tbvIadSMExyRh/azAx3127063lWYzkfiA1KkjgXap82Akq9RddviS1jdOQUo9V4d1k/ZgdAw"}},"unsigned":{"age_ts":1674111390825}}	3
$7qFBn6lW7C0hRYBTRjR0tsE8qpZmodqh6LOyLL0HMnQ	!pWsdJYvpdmDULVhQtX:localhost	{"token_id":14,"historical":false}	{"auth_events":["$bWqW6N4T6ZlJ3MzEaI-MgqdvMEklGrNsy22WqL6ZgOc","$ngKTLt0SDFtdjkF6GnjahEcDA-qLwTKRcVgMgMg5tN8","$pIVIlPgvO-fbiW31dx4GB-wsRX4DrbADDn1AfJoXI50"],"prev_events":["$_MdWHbg9mI3zN-WDGIpwDRJZmDWXBeW-m3WrJiRs4t8"],"type":"m.room.topic","room_id":"!pWsdJYvpdmDULVhQtX:localhost","sender":"@user1.matrix:localhost","content":{"topic":"Handball"},"depth":8,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1674111390984,"hashes":{"sha256":"WjGjs8Q5DV1eQ1nzNXr5wcRQPcLESBhQhlu9vmOGOMU"},"signatures":{"localhost":{"ed25519:a_CHdg":"oH9Ade5uh9VzXBam+sl8WBeY0sZaGGmtRM5V3vzEX2m441zx+EcQHI1846l+F2i6SShw21N/llLRM3zNTH8BCg"}},"unsigned":{"age_ts":1674111390984}}	3
$d7sJ6Squy3gHlaCn4UxGeu_9AcN2XCBHtBIY8VL5d_g	!pWsdJYvpdmDULVhQtX:localhost	{"token_id":14,"historical":false}	{"auth_events":["$bWqW6N4T6ZlJ3MzEaI-MgqdvMEklGrNsy22WqL6ZgOc","$ngKTLt0SDFtdjkF6GnjahEcDA-qLwTKRcVgMgMg5tN8","$pIVIlPgvO-fbiW31dx4GB-wsRX4DrbADDn1AfJoXI50","$SQpUzgCCeFIrGC3eCPDX_U021w7MG0-lHOxFTcHbvKk"],"prev_events":["$7qFBn6lW7C0hRYBTRjR0tsE8qpZmodqh6LOyLL0HMnQ"],"type":"m.room.member","room_id":"!pWsdJYvpdmDULVhQtX:localhost","sender":"@user1.matrix:localhost","content":{"membership":"invite","displayname":"MattermostUser A [mm]"},"depth":9,"prev_state":[],"state_key":"@mm_mattermost_a:localhost","origin":"localhost","origin_server_ts":1674111412575,"hashes":{"sha256":"PTsNh962BUbkqZi1ItPjPF1JBXUXf7iU6D7KrdC2ssU"},"signatures":{"localhost":{"ed25519:a_CHdg":"5mFwCowHHqnDwhnM0DeEKTy+OC2+tvC3FrYnUmq9HHHTTAl8JzdOxzrwlcdp3ge00AiPi1OBzybSzOtIibLkDQ"}},"unsigned":{"age_ts":1674111412575,"invite_room_state":[{"type":"m.room.create","state_key":"","content":{"room_version":"6","creator":"@user1.matrix:localhost"},"sender":"@user1.matrix:localhost"},{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#sports:localhost"},"sender":"@user1.matrix:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@user1.matrix:localhost"},{"type":"m.room.name","state_key":"","content":{"name":"Sports"},"sender":"@user1.matrix:localhost"},{"type":"m.room.member","state_key":"@user1.matrix:localhost","content":{"membership":"join","displayname":"User 1 - Matrix"},"sender":"@user1.matrix:localhost"}]}}	3
$xCubuHnQAGuDuGdlqiquXK0QRxhOWKTh5TJZZGcL09Q	!pWsdJYvpdmDULVhQtX:localhost	{"token_id":14,"txn_id":"m1674111446447.1","historical":false}	{"auth_events":["$bWqW6N4T6ZlJ3MzEaI-MgqdvMEklGrNsy22WqL6ZgOc","$ngKTLt0SDFtdjkF6GnjahEcDA-qLwTKRcVgMgMg5tN8","$pIVIlPgvO-fbiW31dx4GB-wsRX4DrbADDn1AfJoXI50"],"prev_events":["$d7sJ6Squy3gHlaCn4UxGeu_9AcN2XCBHtBIY8VL5d_g"],"type":"m.room.message","room_id":"!pWsdJYvpdmDULVhQtX:localhost","sender":"@user1.matrix:localhost","content":{"org.matrix.msc1767.text":"A message","body":"A message","msgtype":"m.text"},"depth":10,"prev_state":[],"origin":"localhost","origin_server_ts":1674111446545,"hashes":{"sha256":"Hqzjrhgu/LvpX/FLwDzlZalaBtpdT3atVIdjqLpR8Dw"},"signatures":{"localhost":{"ed25519:a_CHdg":"mOQiYW7LQMYtO0ifpSs5XuOqEYuzk0OuGitaJVL8oJiv8xjdqZ1OXxo+ELDby9Js+kByw4JY8x0aRqpBf0ASBg"}},"unsigned":{"age_ts":1674111446545}}	3
$8lVZQlOM-qXD0dT5ZSbvlEPAQPq5wJHU8KqM6sLfmWM	!pWsdJYvpdmDULVhQtX:localhost	{"token_id":14,"historical":false}	{"auth_events":["$bWqW6N4T6ZlJ3MzEaI-MgqdvMEklGrNsy22WqL6ZgOc","$ngKTLt0SDFtdjkF6GnjahEcDA-qLwTKRcVgMgMg5tN8","$pIVIlPgvO-fbiW31dx4GB-wsRX4DrbADDn1AfJoXI50"],"prev_events":["$xCubuHnQAGuDuGdlqiquXK0QRxhOWKTh5TJZZGcL09Q"],"type":"m.room.topic","room_id":"!pWsdJYvpdmDULVhQtX:localhost","sender":"@user1.matrix:localhost","content":{"topic":"Handball\\nFootball","org.matrix.msc3765.topic":[{"body":"Handball\\nFootball","mimetype":"text/plain"}]},"depth":11,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1674111530536,"hashes":{"sha256":"zhFjkbGkohoOmsH2YPt7QjF9YEmlQB36Uuob+sjw7K4"},"signatures":{"localhost":{"ed25519:a_CHdg":"/zZTHbckJUKsqAO5tsyGpC9uxxbg5XTiTsoHK4HGYhXfThFyhn03ojSs2aGw7SkchWGio1C9Ga0cq8anJnMKBA"}},"unsigned":{"age_ts":1674111530536,"replaces_state":"$7qFBn6lW7C0hRYBTRjR0tsE8qpZmodqh6LOyLL0HMnQ"}}	3
$OsJU_fxidXD79b8VmXNcxdAdUkhXO3S73zUBYUa3yG8	!pWsdJYvpdmDULVhQtX:localhost	{"token_id":14,"historical":false}	{"auth_events":["$bWqW6N4T6ZlJ3MzEaI-MgqdvMEklGrNsy22WqL6ZgOc","$ngKTLt0SDFtdjkF6GnjahEcDA-qLwTKRcVgMgMg5tN8","$pIVIlPgvO-fbiW31dx4GB-wsRX4DrbADDn1AfJoXI50"],"prev_events":["$8lVZQlOM-qXD0dT5ZSbvlEPAQPq5wJHU8KqM6sLfmWM"],"type":"m.room.topic","room_id":"!pWsdJYvpdmDULVhQtX:localhost","sender":"@user1.matrix:localhost","content":{"topic":"Handball","org.matrix.msc3765.topic":[{"body":"Handball","mimetype":"text/plain"}]},"depth":12,"prev_state":[],"state_key":"","origin":"localhost","origin_server_ts":1674111570171,"hashes":{"sha256":"sNt+jh15D2EQw5iyfqyMMamcn6Ce9OOnKSYJ8aUA8Uk"},"signatures":{"localhost":{"ed25519:a_CHdg":"Ywus1OLUojJ9H/eWnfQtL2cwR3rfR/mbgWeoo6aFZDxLDWknE2s2FrQ7ml5rbXMozyOxW1oDnOXbFdTbGmqAAQ"}},"unsigned":{"age_ts":1674111570171,"replaces_state":"$8lVZQlOM-qXD0dT5ZSbvlEPAQPq5wJHU8KqM6sLfmWM"}}	3
$JWIcDwBleupt991UzmNH_DSdEWQPePa6uEyU2J0-ldM	!pWsdJYvpdmDULVhQtX:localhost	{"token_id":14,"txn_id":"m1674111611289.2","historical":false}	{"auth_events":["$bWqW6N4T6ZlJ3MzEaI-MgqdvMEklGrNsy22WqL6ZgOc","$ngKTLt0SDFtdjkF6GnjahEcDA-qLwTKRcVgMgMg5tN8","$pIVIlPgvO-fbiW31dx4GB-wsRX4DrbADDn1AfJoXI50"],"prev_events":["$OsJU_fxidXD79b8VmXNcxdAdUkhXO3S73zUBYUa3yG8"],"type":"m.room.message","room_id":"!pWsdJYvpdmDULVhQtX:localhost","sender":"@user1.matrix:localhost","content":{"org.matrix.msc1767.text":"Cool match","body":"Cool match","msgtype":"m.text"},"depth":13,"prev_state":[],"origin":"localhost","origin_server_ts":1674111611368,"hashes":{"sha256":"0GxaHChVuzv3JXiyolbE1w8ftYviQ5L86VZiKm565Zg"},"signatures":{"localhost":{"ed25519:a_CHdg":"ZF/LPcTD8YFr2UADkqWWRo75ZniyQRkTxUun9bS3YPO8oyQOukAiKAqSUSgMYydUl2AWzjnroZm+FU0PvHM2Aw"}},"unsigned":{"age_ts":1674111611368}}	3
$76OhaN_mof41kiqxA-qZV26DgKxkvkl8JwQjOYqZF1A	!BfSgfecvJnYoZjTYRA:localhost	{"token_id":14,"historical":false}	{"auth_events":["$7N18oPwd46twVh-RWhED6VAPm79aIXVCh_BVUFAFHP8","$eKvf8PFaZwsEOXW-IIYTGZwl6gxEYmEE2TalB5k2iGs","$NfGFxRqIrSmaeLcN53BGirnWzJ1bpwzVyt2oZw2cj1k","$Uf6bLI9lxBnR9TJvz8fcfo-1_wbshzMvT4Ecr_qy-E4"],"prev_events":["$ZF1U_gGvucrvqj1m7ffy4HKGxUsoAbYKpWzUjaPqlMM"],"type":"m.room.member","room_id":"!BfSgfecvJnYoZjTYRA:localhost","sender":"@user1.matrix:localhost","content":{"membership":"invite","displayname":"matrix_b"},"depth":10,"prev_state":[],"state_key":"@matrix_b:localhost","origin":"localhost","origin_server_ts":1674111676978,"hashes":{"sha256":"aeabxUM3lXM9Xuh9/PdO8H1M4rg8cce743iV/m4d0ds"},"signatures":{"localhost":{"ed25519:a_CHdg":"gTfjPHIkVecFenEOXeUwJXmbEZPbEnF4qRzlGdTdL9Lu0x0A5KFR4FKgruQayB0VBxUKlbUk1Un6L0pfgpHPCQ"}},"unsigned":{"age_ts":1674111676978,"invite_room_state":[{"type":"m.room.create","state_key":"","content":{"room_version":"6","creator":"@user1.matrix:localhost"},"sender":"@user1.matrix:localhost"},{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#my.dining:localhost"},"sender":"@user1.matrix:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@user1.matrix:localhost"},{"type":"m.room.name","state_key":"","content":{"name":"My Dining"},"sender":"@user1.matrix:localhost"},{"type":"m.room.member","state_key":"@user1.matrix:localhost","content":{"membership":"join","displayname":"User 1 - Matrix"},"sender":"@user1.matrix:localhost"}]}}	3
$8_ljUg0y31H3DwB8UeZyPs3Vlh_4zdSmAkWCsBDCc98	!dKcbdDATuwwphjRPQP:localhost	{"token_id":15,"txn_id":"m1674210868984.0","historical":false}	{"auth_events":["$TKcINA6W5qTH8raDaFqEMBivZ0LjgXtIHGvxzJ9V4_8","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$CsT9BKDbT6nCfiXJCOAHV90fgB6fYV4boIF3v6eEls4"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@user1.matrix:localhost","content":{"org.matrix.msc1767.text":"Hi there","body":"Hi there","msgtype":"m.text"},"depth":21,"origin":"localhost","origin_server_ts":1674210869080,"hashes":{"sha256":"BNOLlmpxC4dtcmK7itXGMQG64EusYG6YYVaQ8FeL8nE"},"signatures":{"localhost":{"ed25519:a_vyji":"PGQfvuaFbhWn9idk87FrNTk1E6nEnvkElcqZQGWobIeTD3JzZnFx1oPz8EXtGNprqGT3gd+G5VyKStWgoLixBg"}},"unsigned":{"age_ts":1674210869080}}	3
$UlpkVhx0UMdfV3JIISqctfZ_aMoIkpmIqcfxcCxxRL8	!dKcbdDATuwwphjRPQP:localhost	{"txn_id":"m1674210902148.0","historical":false}	{"auth_events":["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$AwutniYNkYl6Dxs-8zYvdPdGLIcM4Kyzaldut5D0jHQ"],"prev_events":["$8_ljUg0y31H3DwB8UeZyPs3Vlh_4zdSmAkWCsBDCc98"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_user1.mm:localhost","content":{"msgtype":"m.text","body":""},"depth":22,"origin":"localhost","origin_server_ts":1674210902175,"hashes":{"sha256":"qY4GOVJj/w0X/m1jyhOk3nKpvE05VgFPBrViRXNqOG0"},"signatures":{"localhost":{"ed25519:a_vyji":"NBgvZtbtS1/kNUYBO1HcTJBva9BrZuLJLLMPOz/48DlyU5NETrU5EmDYx7pDivlbPv8jVTGDaKSvuPDzZ5B5DA"}},"unsigned":{"age_ts":1674210902175}}	3
$_B6Ln541gYqlnaEaxAcSwy46yBXDxkldNhRG8HdrPBs	!dKcbdDATuwwphjRPQP:localhost	{"txn_id":"m1674210902598.1","historical":false}	{"auth_events":["$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88","$AwutniYNkYl6Dxs-8zYvdPdGLIcM4Kyzaldut5D0jHQ"],"prev_events":["$UlpkVhx0UMdfV3JIISqctfZ_aMoIkpmIqcfxcCxxRL8"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@mm_user1.mm:localhost","content":{"msgtype":"m.file","body":"code_style.md","url":"mxc://localhost/nSowXfTlLcjdOPizBpiKUGFU","info":{"mimetype":"","size":15996}},"depth":23,"origin":"localhost","origin_server_ts":1674210902667,"hashes":{"sha256":"m8EgXSYrZk29RKSBcLD1XalgVX1312HcBpDiXrRKP3o"},"signatures":{"localhost":{"ed25519:a_vyji":"aKXNK13caYiFS6ixIclRiic2BfrpFHGTicftV5OfFwhirYSIUSJoYzIMnNn5310CIQq+z66e5OpX+jd1vLVLBA"}},"unsigned":{"age_ts":1674210902667}}	3
$grj8CepyvbRzzkLI4auscQ640Z-NssUGE9TSsXkp690	!dKcbdDATuwwphjRPQP:localhost	{"token_id":15,"txn_id":"m1674211098519.1","historical":false}	{"auth_events":["$TKcINA6W5qTH8raDaFqEMBivZ0LjgXtIHGvxzJ9V4_8","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$_B6Ln541gYqlnaEaxAcSwy46yBXDxkldNhRG8HdrPBs"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@user1.matrix:localhost","content":{"body":"AB9719AB-315B-4EAB-AB5F-84EBA089EBB5.heic","info":{"size":2178164,"mimetype":"image/heic"},"msgtype":"m.file","url":"mxc://localhost/teOHbMgqlofgCWrnDDylQCGp"},"depth":24,"origin":"localhost","origin_server_ts":1674211098570,"hashes":{"sha256":"vm/jskIfRGaAt0+IOrcYuN03Er0+aCuqe+gGWN/PiDw"},"signatures":{"localhost":{"ed25519:a_vyji":"bDUrYN0KZCcTpimeXffOoboo427/VAdpSbcUo5YBqsJDb2pC1bB0yPuxwIxXzRpHfO0TRg8lta8NvEyMygGXAA"}},"unsigned":{"age_ts":1674211098570}}	3
$XhE1A2QtMIi_b9SfK9jbadCTQ4Xd5IZxBaUOcfglbIA	!cUrTzQWGYNmZYMHoGB:localhost	{"token_id":15,"historical":false}	{"auth_events":[],"prev_events":[],"type":"m.room.create","room_id":"!cUrTzQWGYNmZYMHoGB:localhost","sender":"@user1.matrix:localhost","content":{"type":"m.space","room_version":"9","creator":"@user1.matrix:localhost"},"depth":1,"state_key":"","origin":"localhost","origin_server_ts":1674211301080,"hashes":{"sha256":"4GWNeJUeggyo3R4HLDbtnozwNrT5co8EcHvTWxqseIU"},"signatures":{"localhost":{"ed25519:a_vyji":"kwWYnfyDbMRL9pCS6m5YNcmjlQb6QE/2jjcgp+RtE3cfDUBD6BlwIJoeG7g2vZUJ0f+A6SCjjU+ew2SSklfxCA"}},"unsigned":{"age_ts":1674211301080}}	3
$oakhKpEqFw5Icor6iY_TRMQljV-HWQ3lueP0Vlm9hIY	!dKcbdDATuwwphjRPQP:localhost	{"token_id":15,"txn_id":"m1674211225631.2","historical":false}	{"auth_events":["$TKcINA6W5qTH8raDaFqEMBivZ0LjgXtIHGvxzJ9V4_8","$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII","$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88"],"prev_events":["$grj8CepyvbRzzkLI4auscQ640Z-NssUGE9TSsXkp690"],"type":"m.room.message","room_id":"!dKcbdDATuwwphjRPQP:localhost","sender":"@user1.matrix:localhost","content":{"body":"A1D99574-D44E-4526-BEBD-470362011CD5.jpeg","info":{"size":3068971,"mimetype":"image/jpeg","thumbnail_info":{"w":800,"h":600,"mimetype":"image/jpeg","size":468034},"w":4032,"h":3024,"xyz.amorgan.blurhash":"LoED9yx]oeofyZtRj?j[byogjsfk","thumbnail_url":"mxc://localhost/ZblHPXvcnHoXXNZEbXxSxPxv"},"msgtype":"m.image","url":"mxc://localhost/PNierwtrdSqHEqtbUpgkyfbT"},"depth":25,"origin":"localhost","origin_server_ts":1674211225736,"hashes":{"sha256":"89K+DTSfTD1EurZYtYvBXaah48G1zKXCuBfOJkBwmKw"},"signatures":{"localhost":{"ed25519:a_vyji":"rKbrcjeoTulNGArTbfJTx+JfqfvFbpkmD6Yb1OWZrj6q7Uo5BHo5gjAKTGFduWkD0Q3QAc/X/Wg3BKOxHA7fDw"}},"unsigned":{"age_ts":1674211225736}}	3
$Ip3uw4uae3e7xwaJ6BU2ppE2nWhA0Zyb0KZDNvHAdmU	!cUrTzQWGYNmZYMHoGB:localhost	{"token_id":15,"historical":false}	{"auth_events":["$XhE1A2QtMIi_b9SfK9jbadCTQ4Xd5IZxBaUOcfglbIA"],"prev_events":["$XhE1A2QtMIi_b9SfK9jbadCTQ4Xd5IZxBaUOcfglbIA"],"type":"m.room.member","room_id":"!cUrTzQWGYNmZYMHoGB:localhost","sender":"@user1.matrix:localhost","content":{"membership":"join","displayname":"User 1 - Matrix"},"depth":2,"state_key":"@user1.matrix:localhost","origin":"localhost","origin_server_ts":1674211301349,"hashes":{"sha256":"7REPNpoC3yw7eHyKpXg3ygRo2kt+aGS3g6wqR+DiP00"},"signatures":{"localhost":{"ed25519:a_vyji":"LRUemnM+RmXllelT18GAM1JN2+nPdPCTmrG5q6dA0B6n3UtkYssOL2hQlMiCkuLXv5fEjOorIxLWKytqeA3hBw"}},"unsigned":{"age_ts":1674211301349}}	3
$nofByIO1FFs8JcKVqFZb7ulSmWdVGm_V-3n-LceVmnw	!cUrTzQWGYNmZYMHoGB:localhost	{"token_id":15,"historical":false}	{"auth_events":["$Ip3uw4uae3e7xwaJ6BU2ppE2nWhA0Zyb0KZDNvHAdmU","$XhE1A2QtMIi_b9SfK9jbadCTQ4Xd5IZxBaUOcfglbIA"],"prev_events":["$Ip3uw4uae3e7xwaJ6BU2ppE2nWhA0Zyb0KZDNvHAdmU"],"type":"m.room.power_levels","room_id":"!cUrTzQWGYNmZYMHoGB:localhost","sender":"@user1.matrix:localhost","content":{"users":{"@user1.matrix:localhost":100},"users_default":0,"events":{"m.room.name":50,"m.room.power_levels":100,"m.room.history_visibility":100,"m.room.canonical_alias":50,"m.room.avatar":50,"m.room.tombstone":100,"m.room.server_acl":100,"m.room.encryption":100},"events_default":100,"state_default":50,"ban":50,"kick":50,"redact":50,"invite":0,"historical":100},"depth":3,"state_key":"","origin":"localhost","origin_server_ts":1674211301513,"hashes":{"sha256":"/3o2bInD4PjPLknH281+BD7Elni+1WSLpcSwFkMl/ZI"},"signatures":{"localhost":{"ed25519:a_vyji":"Wof14fcRep2tIavY3KlA4mYmHdXAbaUZnlcYjAaqtfVmrhQP4wQEwf5Bfby9dqJbyp6b8OZo+7npf3z8AZcbCQ"}},"unsigned":{"age_ts":1674211301513}}	3
$wtg0qf-MdY5Ur4UMAlOlQ58df82OmKhsbTS81ItsAT8	!cUrTzQWGYNmZYMHoGB:localhost	{"token_id":15,"historical":false}	{"auth_events":["$Ip3uw4uae3e7xwaJ6BU2ppE2nWhA0Zyb0KZDNvHAdmU","$nofByIO1FFs8JcKVqFZb7ulSmWdVGm_V-3n-LceVmnw","$XhE1A2QtMIi_b9SfK9jbadCTQ4Xd5IZxBaUOcfglbIA"],"prev_events":["$nofByIO1FFs8JcKVqFZb7ulSmWdVGm_V-3n-LceVmnw"],"type":"m.room.canonical_alias","room_id":"!cUrTzQWGYNmZYMHoGB:localhost","sender":"@user1.matrix:localhost","content":{"alias":"#my-first-space:localhost"},"depth":4,"state_key":"","origin":"localhost","origin_server_ts":1674211301619,"hashes":{"sha256":"7pCjxv6uDCHtDOrC1uOIwiKeK7aOH/p5msG6MNvYIkA"},"signatures":{"localhost":{"ed25519:a_vyji":"SRjNtHGvQYmvwKbuj0I/QQLcKWfQLSvBfwYQ+5Rrlb3P3/kU1wU74tSe5pEC61XD0htolvDucbw9J/TzaQSOAQ"}},"unsigned":{"age_ts":1674211301619}}	3
$DFCNP6Tt2ypS8tXyd5kaCiqWeVDmE_FL-iOprkrfubk	!cUrTzQWGYNmZYMHoGB:localhost	{"token_id":15,"historical":false}	{"auth_events":["$Ip3uw4uae3e7xwaJ6BU2ppE2nWhA0Zyb0KZDNvHAdmU","$nofByIO1FFs8JcKVqFZb7ulSmWdVGm_V-3n-LceVmnw","$XhE1A2QtMIi_b9SfK9jbadCTQ4Xd5IZxBaUOcfglbIA"],"prev_events":["$wtg0qf-MdY5Ur4UMAlOlQ58df82OmKhsbTS81ItsAT8"],"type":"m.room.join_rules","room_id":"!cUrTzQWGYNmZYMHoGB:localhost","sender":"@user1.matrix:localhost","content":{"join_rule":"public"},"depth":5,"state_key":"","origin":"localhost","origin_server_ts":1674211301654,"hashes":{"sha256":"PgQElIP3Ao6X/qrzZOJXwTn0bJ1wRTa7bP1h3YQt+Kg"},"signatures":{"localhost":{"ed25519:a_vyji":"FCPpJBzyMawoN3yTfwn8gB6bWCstjzMYtoWVYd8cGgSG7yAs2XVFsXc90wn/mEHahGdlVLD+RaWMA77ior7BAQ"}},"unsigned":{"age_ts":1674211301654}}	3
$MJ2YTkP3f-eQwc5HLB6GVzjnPJaVov0pUCfq1bWqG3M	!cUrTzQWGYNmZYMHoGB:localhost	{"token_id":15,"historical":false}	{"auth_events":["$Ip3uw4uae3e7xwaJ6BU2ppE2nWhA0Zyb0KZDNvHAdmU","$nofByIO1FFs8JcKVqFZb7ulSmWdVGm_V-3n-LceVmnw","$XhE1A2QtMIi_b9SfK9jbadCTQ4Xd5IZxBaUOcfglbIA"],"prev_events":["$DFCNP6Tt2ypS8tXyd5kaCiqWeVDmE_FL-iOprkrfubk"],"type":"m.room.guest_access","room_id":"!cUrTzQWGYNmZYMHoGB:localhost","sender":"@user1.matrix:localhost","content":{"guest_access":"can_join"},"depth":6,"state_key":"","origin":"localhost","origin_server_ts":1674211301685,"hashes":{"sha256":"7Fay0CEEPccPN1/EwhvWJd9nS2qIZijI2h+Dwr0H3cY"},"signatures":{"localhost":{"ed25519:a_vyji":"CalAMmTgKIqKVacmUoVL25rlxuBr7WApmjH8wmosv3ArBqcXSMlz6HSLaLr1U8Blpft1vmpckpZ+NVRkSOyzAg"}},"unsigned":{"age_ts":1674211301685}}	3
$iAAlBelGypnsbVKn9Fd-ubLNje326TRpaegoLLyRZGY	!cUrTzQWGYNmZYMHoGB:localhost	{"token_id":15,"historical":false}	{"auth_events":["$Ip3uw4uae3e7xwaJ6BU2ppE2nWhA0Zyb0KZDNvHAdmU","$nofByIO1FFs8JcKVqFZb7ulSmWdVGm_V-3n-LceVmnw","$XhE1A2QtMIi_b9SfK9jbadCTQ4Xd5IZxBaUOcfglbIA"],"prev_events":["$MJ2YTkP3f-eQwc5HLB6GVzjnPJaVov0pUCfq1bWqG3M"],"type":"m.room.history_visibility","room_id":"!cUrTzQWGYNmZYMHoGB:localhost","sender":"@user1.matrix:localhost","content":{"history_visibility":"world_readable"},"depth":7,"state_key":"","origin":"localhost","origin_server_ts":1674211301709,"hashes":{"sha256":"0Uv8rJGS4cph3NOWMuUrSCLtIqVBo0brxqHBXETEDj8"},"signatures":{"localhost":{"ed25519:a_vyji":"ETM2LEfwJ7Cks9SLniC9H7XM9IV1cAVjfqLl1OfIdUPq1ibKr5Na3/RtYDKeWR2CQSXXDqy632bj6WEB2IKUBQ"}},"unsigned":{"age_ts":1674211301709}}	3
$34bSEXw9U2DTNkZA2he27rczptl3jni1oG64GRRYkfY	!cUrTzQWGYNmZYMHoGB:localhost	{"token_id":15,"historical":false}	{"auth_events":["$Ip3uw4uae3e7xwaJ6BU2ppE2nWhA0Zyb0KZDNvHAdmU","$nofByIO1FFs8JcKVqFZb7ulSmWdVGm_V-3n-LceVmnw","$XhE1A2QtMIi_b9SfK9jbadCTQ4Xd5IZxBaUOcfglbIA"],"prev_events":["$iAAlBelGypnsbVKn9Fd-ubLNje326TRpaegoLLyRZGY"],"type":"m.room.name","room_id":"!cUrTzQWGYNmZYMHoGB:localhost","sender":"@user1.matrix:localhost","content":{"name":"My-First-Space"},"depth":8,"state_key":"","origin":"localhost","origin_server_ts":1674211302128,"hashes":{"sha256":"PkvjgcrzoSw1hdiougkn8qBfdjjP/rwmuUg39/siAbo"},"signatures":{"localhost":{"ed25519:a_vyji":"gzDB8sXYz5B63UcdvrBxcKXeSrZbn/dBola5VbCNMRqE+wMjGXp+6oAUwW869g+KEl4qBiqJZyflUs+qLhd6AA"}},"unsigned":{"age_ts":1674211302128}}	3
$SFXqj2UcfZU2XtnGBtupMwsoI3Z5JLp-7mmR2PU4MjQ	!cUrTzQWGYNmZYMHoGB:localhost	{"token_id":15,"historical":false}	{"auth_events":["$Ip3uw4uae3e7xwaJ6BU2ppE2nWhA0Zyb0KZDNvHAdmU","$nofByIO1FFs8JcKVqFZb7ulSmWdVGm_V-3n-LceVmnw","$XhE1A2QtMIi_b9SfK9jbadCTQ4Xd5IZxBaUOcfglbIA"],"prev_events":["$34bSEXw9U2DTNkZA2he27rczptl3jni1oG64GRRYkfY"],"type":"m.room.topic","room_id":"!cUrTzQWGYNmZYMHoGB:localhost","sender":"@user1.matrix:localhost","content":{"topic":""},"depth":9,"state_key":"","origin":"localhost","origin_server_ts":1674211302326,"hashes":{"sha256":"uUP4HDhqFG37mwRCzv8KeLOHWkkLbkY2rhwYVh0EkKY"},"signatures":{"localhost":{"ed25519:a_vyji":"d9kwg7JRGF+8WgWIRvTgGOcvq6enaYeTVFEILcexUTZvpyBEOfHJuGvvVHCLSKagbYidEeneP1EEVElmRi/QDg"}},"unsigned":{"age_ts":1674211302326}}	3
$LnGTvN89zWMaGdr_8T22TNwZ8hCnAeMlGOMaGpCPahE	!hccoYOyrWRMEhMnaoh:localhost	{"token_id":15,"historical":false}	{"auth_events":[],"prev_events":[],"type":"m.room.create","room_id":"!hccoYOyrWRMEhMnaoh:localhost","sender":"@user1.matrix:localhost","content":{"room_version":"9","creator":"@user1.matrix:localhost"},"depth":1,"state_key":"","origin":"localhost","origin_server_ts":1674211359284,"hashes":{"sha256":"b5YPiB287ICzT/8PoDSWUVZGkyJsRBZKGHYbjG+vPOM"},"signatures":{"localhost":{"ed25519:a_vyji":"Trw1XVhe/bYz/+Ap26z0d8idLvut//lYOZUFnqZw7sqee0v62oWDhnYldAZC4lPEO0SlkFLv3z+kdSJ3hIy1Aw"}},"unsigned":{"age_ts":1674211359284}}	3
$A45QtHYoTPEA17jEFQZ4U882WGuYFA2D4xiKqwnZyUs	!JGJhGNDoMdRLJzLgcJ:localhost	{"token_id":15,"historical":false}	{"auth_events":[],"prev_events":[],"type":"m.room.create","room_id":"!JGJhGNDoMdRLJzLgcJ:localhost","sender":"@user1.matrix:localhost","content":{"room_version":"9","creator":"@user1.matrix:localhost"},"depth":1,"state_key":"","origin":"localhost","origin_server_ts":1674211359296,"hashes":{"sha256":"KDnTMXdXpkxRiVU8IDT66Epced9SQg7qmvfHi1CSkIs"},"signatures":{"localhost":{"ed25519:a_vyji":"f/7I8tOT8Qaf2Jkja+0l01vQ2v4OfwCXxJFhwR9oLg6oI9QU0P+HUUpn7rntEnjFvLuXwzImrfjESDP+6NLbDg"}},"unsigned":{"age_ts":1674211359296}}	3
$bgbjmgXAlLz069pieqVTP8KTcxXHvT72ZwdRr71Fnqg	!FSwSlJXpOZZONTVfGs:localhost	{"token_id":15,"historical":false}	{"auth_events":["$Z-W9-QEq_roRPUfFFGrVn3vc_d4uekRlcsL3uBSdDpM","$4ywygf1-17_Kq3j230bjqgAjdpc67zV0hIv7Uw6BKtA","$VI4y-gfFPbzFuAM6S6F4gXfpeWta-thThcGlPN0xQN0"],"prev_events":["$33Pk__-gU3AslKMgHWQqdrgfvEhGtn4nPTRaDuhZUC0"],"type":"m.room.name","room_id":"!FSwSlJXpOZZONTVfGs:localhost","sender":"@user1.matrix:localhost","content":{"name":"#Space-room-2"},"depth":8,"state_key":"","origin":"localhost","origin_server_ts":1674211360588,"hashes":{"sha256":"Jh69OXqkbzaFLlY2XKh5cbEVInP1PjQwuxT9AGqHauQ"},"signatures":{"localhost":{"ed25519:a_vyji":"GRylevSnBwHubiId/8Ayh/VkCOR27vzPtG+9X8tHpCWfMkZCwuxsf+gLFj3TEbfNRswf+xIGPBFM3/CcK1GYCg"}},"unsigned":{"age_ts":1674211360588}}	3
$Z-W9-QEq_roRPUfFFGrVn3vc_d4uekRlcsL3uBSdDpM	!FSwSlJXpOZZONTVfGs:localhost	{"token_id":15,"historical":false}	{"auth_events":["$VI4y-gfFPbzFuAM6S6F4gXfpeWta-thThcGlPN0xQN0"],"prev_events":["$VI4y-gfFPbzFuAM6S6F4gXfpeWta-thThcGlPN0xQN0"],"type":"m.room.member","room_id":"!FSwSlJXpOZZONTVfGs:localhost","sender":"@user1.matrix:localhost","content":{"membership":"join","displayname":"User 1 - Matrix"},"depth":2,"state_key":"@user1.matrix:localhost","origin":"localhost","origin_server_ts":1674211359556,"hashes":{"sha256":"MF88tqq1WojZZ+cHZNMHpthCaTawut3J2yUaPg7/wE4"},"signatures":{"localhost":{"ed25519:a_vyji":"zGIFQ9FY/lhSXz8NKJy42KaBkTmsRFKtZ3TACWPC5Nqo7j0x1iMFyWruM+hDSAdCqqAkdRkd5bGwelyJKwn1Dw"}},"unsigned":{"age_ts":1674211359556}}	3
$uDBLcAyAHq3swiKjGlyKYFZwIrP5Ux8Ki1qU7x3aVsY	!JGJhGNDoMdRLJzLgcJ:localhost	{"token_id":15,"historical":false}	{"auth_events":["$A45QtHYoTPEA17jEFQZ4U882WGuYFA2D4xiKqwnZyUs"],"prev_events":["$A45QtHYoTPEA17jEFQZ4U882WGuYFA2D4xiKqwnZyUs"],"type":"m.room.member","room_id":"!JGJhGNDoMdRLJzLgcJ:localhost","sender":"@user1.matrix:localhost","content":{"membership":"join","displayname":"User 1 - Matrix"},"depth":2,"state_key":"@user1.matrix:localhost","origin":"localhost","origin_server_ts":1674211359620,"hashes":{"sha256":"IwcLmc/nouixtujjxubxwLe8/aW6XdtoYG6Mwl0IVAs"},"signatures":{"localhost":{"ed25519:a_vyji":"G5akkjFFg8QdnWnypTHZ7D7Yw78GGO7MZH4izAhVqpQahY2+TTq5ZWZ/YhJZI4rPTsd0iFXQiDzYGXyttlx0DQ"}},"unsigned":{"age_ts":1674211359620}}	3
$nMtE3MPK3rxeHXzgEF1GWQXqF1Of8IqoWwPKejXxdrg	!hccoYOyrWRMEhMnaoh:localhost	{"token_id":15,"historical":false}	{"auth_events":["$RRFtexNdS-wxfmZgcU9kk5Lyp462lIuVu6piimDKCGA","$LnGTvN89zWMaGdr_8T22TNwZ8hCnAeMlGOMaGpCPahE"],"prev_events":["$RRFtexNdS-wxfmZgcU9kk5Lyp462lIuVu6piimDKCGA"],"type":"m.room.power_levels","room_id":"!hccoYOyrWRMEhMnaoh:localhost","sender":"@user1.matrix:localhost","content":{"users":{"@user1.matrix:localhost":100},"users_default":0,"events":{"m.room.name":50,"m.room.power_levels":100,"m.room.history_visibility":100,"m.room.canonical_alias":50,"m.room.avatar":50,"m.room.tombstone":100,"m.room.server_acl":100,"m.room.encryption":100},"events_default":0,"state_default":50,"ban":50,"kick":50,"redact":50,"invite":50,"historical":100},"depth":3,"state_key":"","origin":"localhost","origin_server_ts":1674211359836,"hashes":{"sha256":"uc1c8LstT+fN1j42n+8TLNoX0zi/UaLd+49jLf33QtE"},"signatures":{"localhost":{"ed25519:a_vyji":"7/m2Zi+MbhyhUIw1tiFumYzOTPJSKr3sv2t9cqsHbIXg8gi91rsktsK0WP2GdgGBTLN61TuOzZB4up3ScVDzDw"}},"unsigned":{"age_ts":1674211359836}}	3
$4MpBsW-eFJ4SoVP-rLgkefjkNR0Sytuayop2Z-OBFzU	!hccoYOyrWRMEhMnaoh:localhost	{"token_id":15,"historical":false}	{"auth_events":["$RRFtexNdS-wxfmZgcU9kk5Lyp462lIuVu6piimDKCGA","$nMtE3MPK3rxeHXzgEF1GWQXqF1Of8IqoWwPKejXxdrg","$LnGTvN89zWMaGdr_8T22TNwZ8hCnAeMlGOMaGpCPahE"],"prev_events":["$nMtE3MPK3rxeHXzgEF1GWQXqF1Of8IqoWwPKejXxdrg"],"type":"m.room.join_rules","room_id":"!hccoYOyrWRMEhMnaoh:localhost","sender":"@user1.matrix:localhost","content":{"join_rule":"public"},"depth":4,"state_key":"","origin":"localhost","origin_server_ts":1674211359954,"hashes":{"sha256":"9MvHjVslfBwmNUEbz1skjuLdgH8jNAVchYS+zjUBQWA"},"signatures":{"localhost":{"ed25519:a_vyji":"5BbgQ0rd+GsB+NsXRBj09rSNEx3YuUaw+a/6TxXUoITYNuvSF0voIBAwiBeDrB0jwNV5NyzuqLFPL01MbXj4Aw"}},"unsigned":{"age_ts":1674211359954}}	3
$5QgMOlhzvtIooZVNYnMnchsgiEUDObBacU41JO2zKs0	!hccoYOyrWRMEhMnaoh:localhost	{"token_id":15,"historical":false}	{"auth_events":["$RRFtexNdS-wxfmZgcU9kk5Lyp462lIuVu6piimDKCGA","$nMtE3MPK3rxeHXzgEF1GWQXqF1Of8IqoWwPKejXxdrg","$LnGTvN89zWMaGdr_8T22TNwZ8hCnAeMlGOMaGpCPahE"],"prev_events":["$4MpBsW-eFJ4SoVP-rLgkefjkNR0Sytuayop2Z-OBFzU"],"type":"m.room.guest_access","room_id":"!hccoYOyrWRMEhMnaoh:localhost","sender":"@user1.matrix:localhost","content":{"guest_access":"can_join"},"depth":5,"state_key":"","origin":"localhost","origin_server_ts":1674211359993,"hashes":{"sha256":"Qe2l+Ykdg1XNgL1TXNYI6hJIJmEqnzDGCLZZ/m8kcGI"},"signatures":{"localhost":{"ed25519:a_vyji":"Nwz2QPDjKNfd8dYNG67eZ5SH+GExYRy0gJs2tOtvcKHkYJmlb0aTiI4r8cA7QoV8o03bj5T+QSwYaHleq9vqBw"}},"unsigned":{"age_ts":1674211359993}}	3
$NYaJba-K1Im8n6_Z7mL0VwgIAKxZqouzTTYu6EcK5eM	!hccoYOyrWRMEhMnaoh:localhost	{"token_id":15,"historical":false}	{"auth_events":["$RRFtexNdS-wxfmZgcU9kk5Lyp462lIuVu6piimDKCGA","$nMtE3MPK3rxeHXzgEF1GWQXqF1Of8IqoWwPKejXxdrg","$LnGTvN89zWMaGdr_8T22TNwZ8hCnAeMlGOMaGpCPahE"],"prev_events":["$5QgMOlhzvtIooZVNYnMnchsgiEUDObBacU41JO2zKs0"],"type":"m.space.parent","room_id":"!hccoYOyrWRMEhMnaoh:localhost","sender":"@user1.matrix:localhost","content":{"via":["localhost"],"canonical":true},"depth":6,"state_key":"!cUrTzQWGYNmZYMHoGB:localhost","origin":"localhost","origin_server_ts":1674211360019,"hashes":{"sha256":"xbvPqa8LYtk8YffYVCiV5Wl0Q++1JXAgmWuAPeQTut8"},"signatures":{"localhost":{"ed25519:a_vyji":"4UyLTdoKzcwWiQuPHvPSVm/Oa1wTzSYmtVWs4uBpXYf8k+O6Bu2WswLU6arCioGpO/95SZ1TZR4rxor2NEdGDw"}},"unsigned":{"age_ts":1674211360019}}	3
$-FXdMAkllHkSbPP-QDGsb_zIuCwPKR511zZahmMGKs4	!hccoYOyrWRMEhMnaoh:localhost	{"token_id":15,"historical":false}	{"auth_events":["$RRFtexNdS-wxfmZgcU9kk5Lyp462lIuVu6piimDKCGA","$nMtE3MPK3rxeHXzgEF1GWQXqF1Of8IqoWwPKejXxdrg","$LnGTvN89zWMaGdr_8T22TNwZ8hCnAeMlGOMaGpCPahE"],"prev_events":["$NYaJba-K1Im8n6_Z7mL0VwgIAKxZqouzTTYu6EcK5eM"],"type":"m.room.history_visibility","room_id":"!hccoYOyrWRMEhMnaoh:localhost","sender":"@user1.matrix:localhost","content":{"history_visibility":"world_readable"},"depth":7,"state_key":"","origin":"localhost","origin_server_ts":1674211360039,"hashes":{"sha256":"6rahsNDOCouHFRyVzcTkowZu3L3PXiYGiXM7/dYBP88"},"signatures":{"localhost":{"ed25519:a_vyji":"achuvRyqBHM1U6s4fHn6vgGWps+lM2UJ51rUqaQPiGcq1mj88k4zqYQEcAgjVuHYiQ42J6e5b18w+GM+fjfECg"}},"unsigned":{"age_ts":1674211360039}}	3
$RRFtexNdS-wxfmZgcU9kk5Lyp462lIuVu6piimDKCGA	!hccoYOyrWRMEhMnaoh:localhost	{"token_id":15,"historical":false}	{"auth_events":["$LnGTvN89zWMaGdr_8T22TNwZ8hCnAeMlGOMaGpCPahE"],"prev_events":["$LnGTvN89zWMaGdr_8T22TNwZ8hCnAeMlGOMaGpCPahE"],"type":"m.room.member","room_id":"!hccoYOyrWRMEhMnaoh:localhost","sender":"@user1.matrix:localhost","content":{"membership":"join","displayname":"User 1 - Matrix"},"depth":2,"state_key":"@user1.matrix:localhost","origin":"localhost","origin_server_ts":1674211359590,"hashes":{"sha256":"vdtMBBBSXlHlvaT5tqH0+j4DxSOGR7UXGPwaY5OeAEM"},"signatures":{"localhost":{"ed25519:a_vyji":"y0vYTAHyNf2zdWNmLqN9CuMF+g31sIwXKWwbu32Jdk/xIz4feQ8Ox1ZEulhmY/OPSbdgeMrfdpx77WKH2JLNCA"}},"unsigned":{"age_ts":1674211359590}}	3
$OUsS0radBRPS3B8beUIJ1TUjFMPXJ0OTtSau2wSu6rY	!cUrTzQWGYNmZYMHoGB:localhost	{"token_id":15,"historical":false}	{"auth_events":["$Ip3uw4uae3e7xwaJ6BU2ppE2nWhA0Zyb0KZDNvHAdmU","$nofByIO1FFs8JcKVqFZb7ulSmWdVGm_V-3n-LceVmnw","$XhE1A2QtMIi_b9SfK9jbadCTQ4Xd5IZxBaUOcfglbIA"],"prev_events":["$SFXqj2UcfZU2XtnGBtupMwsoI3Z5JLp-7mmR2PU4MjQ"],"type":"m.space.child","room_id":"!cUrTzQWGYNmZYMHoGB:localhost","sender":"@user1.matrix:localhost","content":{"via":["localhost"],"suggested":true},"depth":10,"state_key":"!FSwSlJXpOZZONTVfGs:localhost","origin":"localhost","origin_server_ts":1674211361193,"hashes":{"sha256":"LST8uE0aAMdQSPusilENS2nzPwZWiLuiknkJIor60dk"},"signatures":{"localhost":{"ed25519:a_vyji":"VJUBBU/AeEWxBFmO7AEhVfCcsbMRn4XfKLNxftAPww6wh1D2SjNninEG0do6HQh+bnQSMjo+5yAB74CGgzlDBA"}},"unsigned":{"age_ts":1674211361193}}	3
$z3x2QWsqd2WeWbha161nzCLfGv7psz2SV_Gveo8B5Yk	!cUrTzQWGYNmZYMHoGB:localhost	{"token_id":15,"historical":false}	{"auth_events":["$Ip3uw4uae3e7xwaJ6BU2ppE2nWhA0Zyb0KZDNvHAdmU","$nofByIO1FFs8JcKVqFZb7ulSmWdVGm_V-3n-LceVmnw","$XhE1A2QtMIi_b9SfK9jbadCTQ4Xd5IZxBaUOcfglbIA"],"prev_events":["$SFXqj2UcfZU2XtnGBtupMwsoI3Z5JLp-7mmR2PU4MjQ"],"type":"m.space.child","room_id":"!cUrTzQWGYNmZYMHoGB:localhost","sender":"@user1.matrix:localhost","content":{"via":["localhost"],"suggested":true},"depth":10,"state_key":"!JGJhGNDoMdRLJzLgcJ:localhost","origin":"localhost","origin_server_ts":1674211361207,"hashes":{"sha256":"FHIFkElxWPyWE6BpUeSHEpodoMAbQNQe5Jdt3Gy/5bg"},"signatures":{"localhost":{"ed25519:a_vyji":"tEPGGla2u/PkX2UKxaDl84eAljvpoxYIg5C42LQ6EPoTpzfQdADE6dOPbLVwFgczBoZQepfkQuly+cnaeUBHDw"}},"unsigned":{"age_ts":1674211361207}}	3
$almCp-spfN30ITGsQkwvqZtOB3TVD17i4DcwiaswR4E	!hccoYOyrWRMEhMnaoh:localhost	{"token_id":15,"txn_id":"m1674211460155.3","historical":false}	{"auth_events":["$RRFtexNdS-wxfmZgcU9kk5Lyp462lIuVu6piimDKCGA","$nMtE3MPK3rxeHXzgEF1GWQXqF1Of8IqoWwPKejXxdrg","$LnGTvN89zWMaGdr_8T22TNwZ8hCnAeMlGOMaGpCPahE"],"prev_events":["$sUchhgur-fFKVUmMUaBERmjM3ItMz4-8bhkuD7UXnuU"],"type":"m.room.message","room_id":"!hccoYOyrWRMEhMnaoh:localhost","sender":"@user1.matrix:localhost","content":{"org.matrix.msc1767.text":"Hello","body":"Hello","msgtype":"m.text"},"depth":9,"origin":"localhost","origin_server_ts":1674211460232,"hashes":{"sha256":"6FX60TqynSOrFySfGL6WJ/UMZzgKUVz/Ih7/oB0QNys"},"signatures":{"localhost":{"ed25519:a_vyji":"CTkiGbkGvh7N9/L3qNFuw1fciXjcs1CaEOe7ctUkL8ZJGqk8Np+DRUaStqkBBALgPz5mTln5Nw38ILh6VgLfAQ"}},"unsigned":{"age_ts":1674211460232}}	3
$MLY05F5LyQaOuJw4avembMABTu_CtFuQyhyiF14QtYo	!JGJhGNDoMdRLJzLgcJ:localhost	{"token_id":15,"historical":false}	{"auth_events":["$uDBLcAyAHq3swiKjGlyKYFZwIrP5Ux8Ki1qU7x3aVsY","$A45QtHYoTPEA17jEFQZ4U882WGuYFA2D4xiKqwnZyUs"],"prev_events":["$uDBLcAyAHq3swiKjGlyKYFZwIrP5Ux8Ki1qU7x3aVsY"],"type":"m.room.power_levels","room_id":"!JGJhGNDoMdRLJzLgcJ:localhost","sender":"@user1.matrix:localhost","content":{"users":{"@user1.matrix:localhost":100},"users_default":0,"events":{"m.room.name":50,"m.room.power_levels":100,"m.room.history_visibility":100,"m.room.canonical_alias":50,"m.room.avatar":50,"m.room.tombstone":100,"m.room.server_acl":100,"m.room.encryption":100},"events_default":0,"state_default":50,"ban":50,"kick":50,"redact":50,"invite":50,"historical":100},"depth":3,"state_key":"","origin":"localhost","origin_server_ts":1674211359847,"hashes":{"sha256":"TeUzn3Al0EgEW2I/Xhd4EUrTs9ndvsrMySKfcsQR9MY"},"signatures":{"localhost":{"ed25519:a_vyji":"dKLWOmTc6htgxF+0wiVASybSEHgUINPJUHInTJf1tcsUL0fNWSysRnK8Oxk9cqCk50UhXyWHxXjUiUvuVUtjBQ"}},"unsigned":{"age_ts":1674211359847}}	3
$e6pVgV1MsH-6_A1V_vGWGmdznPg_czNOfblinyTHshA	!JGJhGNDoMdRLJzLgcJ:localhost	{"token_id":15,"historical":false}	{"auth_events":["$uDBLcAyAHq3swiKjGlyKYFZwIrP5Ux8Ki1qU7x3aVsY","$MLY05F5LyQaOuJw4avembMABTu_CtFuQyhyiF14QtYo","$A45QtHYoTPEA17jEFQZ4U882WGuYFA2D4xiKqwnZyUs"],"prev_events":["$MLY05F5LyQaOuJw4avembMABTu_CtFuQyhyiF14QtYo"],"type":"m.room.join_rules","room_id":"!JGJhGNDoMdRLJzLgcJ:localhost","sender":"@user1.matrix:localhost","content":{"join_rule":"public"},"depth":4,"state_key":"","origin":"localhost","origin_server_ts":1674211359893,"hashes":{"sha256":"zY6nmcMtK9O0jDqvyFveOyc+jNc7I2a9nOpFFERYxOA"},"signatures":{"localhost":{"ed25519:a_vyji":"/hrA59iSkS5MEZ75AnWDEgcWWwKt0gOM1S6AS+E3mzZK9N2gG5tYphkSZpP9ZNwm6f7A5O6lPt/ATf6dZQONDA"}},"unsigned":{"age_ts":1674211359893}}	3
$hNUZNFVPWjQzoWmc5wymfJzaTuaIdxyWFsi3fkTJ534	!JGJhGNDoMdRLJzLgcJ:localhost	{"token_id":15,"historical":false}	{"auth_events":["$uDBLcAyAHq3swiKjGlyKYFZwIrP5Ux8Ki1qU7x3aVsY","$MLY05F5LyQaOuJw4avembMABTu_CtFuQyhyiF14QtYo","$A45QtHYoTPEA17jEFQZ4U882WGuYFA2D4xiKqwnZyUs"],"prev_events":["$e6pVgV1MsH-6_A1V_vGWGmdznPg_czNOfblinyTHshA"],"type":"m.room.guest_access","room_id":"!JGJhGNDoMdRLJzLgcJ:localhost","sender":"@user1.matrix:localhost","content":{"guest_access":"can_join"},"depth":5,"state_key":"","origin":"localhost","origin_server_ts":1674211359965,"hashes":{"sha256":"mIk4SEe3VRI1dnExGWuD/9VG9z6/452h0UsVubI4pvs"},"signatures":{"localhost":{"ed25519:a_vyji":"1A3vA8TOiUz1loCuZIRyBvgki5OF5VGwgEogrbJkuD/dNryY1rYCXGzRdZW70Ric1bGxWqgPKyz3PVxsK8qKAQ"}},"unsigned":{"age_ts":1674211359965}}	3
$IYkBkm-ncU_4Z-Ft8v80LsrK5kKpzGKpHDUWZxxy6t8	!JGJhGNDoMdRLJzLgcJ:localhost	{"token_id":15,"historical":false}	{"auth_events":["$uDBLcAyAHq3swiKjGlyKYFZwIrP5Ux8Ki1qU7x3aVsY","$MLY05F5LyQaOuJw4avembMABTu_CtFuQyhyiF14QtYo","$A45QtHYoTPEA17jEFQZ4U882WGuYFA2D4xiKqwnZyUs"],"prev_events":["$hNUZNFVPWjQzoWmc5wymfJzaTuaIdxyWFsi3fkTJ534"],"type":"m.space.parent","room_id":"!JGJhGNDoMdRLJzLgcJ:localhost","sender":"@user1.matrix:localhost","content":{"via":["localhost"],"canonical":true},"depth":6,"state_key":"!cUrTzQWGYNmZYMHoGB:localhost","origin":"localhost","origin_server_ts":1674211359994,"hashes":{"sha256":"jCXMfhn4AzNP0jxx1Pz5/Zw1pSqODYBSVWrxBi4n6DU"},"signatures":{"localhost":{"ed25519:a_vyji":"NSnGIgkj90ocIPoJfffDFZujA9a8Gzd6M+2xxceEn/c7/A5oacuMrZ747oavl6qDp0QRwSK9QN/5BZF88j/pDw"}},"unsigned":{"age_ts":1674211359994}}	3
$JfR9TVM-sEe4hZ5-0bIni5e5m_tLlX2HdSU6u6IoVBM	!JGJhGNDoMdRLJzLgcJ:localhost	{"token_id":15,"historical":false}	{"auth_events":["$uDBLcAyAHq3swiKjGlyKYFZwIrP5Ux8Ki1qU7x3aVsY","$MLY05F5LyQaOuJw4avembMABTu_CtFuQyhyiF14QtYo","$A45QtHYoTPEA17jEFQZ4U882WGuYFA2D4xiKqwnZyUs"],"prev_events":["$IYkBkm-ncU_4Z-Ft8v80LsrK5kKpzGKpHDUWZxxy6t8"],"type":"m.room.history_visibility","room_id":"!JGJhGNDoMdRLJzLgcJ:localhost","sender":"@user1.matrix:localhost","content":{"history_visibility":"world_readable"},"depth":7,"state_key":"","origin":"localhost","origin_server_ts":1674211360020,"hashes":{"sha256":"LaK89q06XWwQRcpqVEzHxUCO8LjZ4GUtt1bNGoUN1vM"},"signatures":{"localhost":{"ed25519:a_vyji":"aSLzREHk5Wp5QTtUmirfqm3UNfEWTqdtVm6lt96J1js+ZodT88wn7ewP57jfNWLJR4zzPNaZz2IwBnRT1h56Bw"}},"unsigned":{"age_ts":1674211360020}}	3
$4ywygf1-17_Kq3j230bjqgAjdpc67zV0hIv7Uw6BKtA	!FSwSlJXpOZZONTVfGs:localhost	{"token_id":15,"historical":false}	{"auth_events":["$Z-W9-QEq_roRPUfFFGrVn3vc_d4uekRlcsL3uBSdDpM","$VI4y-gfFPbzFuAM6S6F4gXfpeWta-thThcGlPN0xQN0"],"prev_events":["$Z-W9-QEq_roRPUfFFGrVn3vc_d4uekRlcsL3uBSdDpM"],"type":"m.room.power_levels","room_id":"!FSwSlJXpOZZONTVfGs:localhost","sender":"@user1.matrix:localhost","content":{"users":{"@user1.matrix:localhost":100},"users_default":0,"events":{"m.room.name":50,"m.room.power_levels":100,"m.room.history_visibility":100,"m.room.canonical_alias":50,"m.room.avatar":50,"m.room.tombstone":100,"m.room.server_acl":100,"m.room.encryption":100},"events_default":0,"state_default":50,"ban":50,"kick":50,"redact":50,"invite":50,"historical":100},"depth":3,"state_key":"","origin":"localhost","origin_server_ts":1674211359740,"hashes":{"sha256":"r2CHS0Dc4xKbhuppFOcougNJOq9pM5X6DE2mKk4k25c"},"signatures":{"localhost":{"ed25519:a_vyji":"X3ysdo6RqmWEkQwLSoaCJGzItpRwbgsSknEdVlS2WWIXKHC6WjQHszOQXK+CMLmOakF30H012XshafDSET7pBg"}},"unsigned":{"age_ts":1674211359740}}	3
$CjB4vCnMjTm70a0EahGjB5FN8EKtrdWl7F12gA2FhDo	!FSwSlJXpOZZONTVfGs:localhost	{"token_id":15,"historical":false}	{"auth_events":["$Z-W9-QEq_roRPUfFFGrVn3vc_d4uekRlcsL3uBSdDpM","$4ywygf1-17_Kq3j230bjqgAjdpc67zV0hIv7Uw6BKtA","$VI4y-gfFPbzFuAM6S6F4gXfpeWta-thThcGlPN0xQN0"],"prev_events":["$4ywygf1-17_Kq3j230bjqgAjdpc67zV0hIv7Uw6BKtA"],"type":"m.room.join_rules","room_id":"!FSwSlJXpOZZONTVfGs:localhost","sender":"@user1.matrix:localhost","content":{"join_rule":"public"},"depth":4,"state_key":"","origin":"localhost","origin_server_ts":1674211359799,"hashes":{"sha256":"5ytbo6FhlyqKJvh0gGoqS/smhkB+t57rF32dy6nTfzI"},"signatures":{"localhost":{"ed25519:a_vyji":"s3f+0aVH9AT/ZIUecPwv39ICeqFhmtTbMcRDuyE1t2l6to46MDMbjHR71j2cgLZiY82DLAC5vk7hj6BDGBOJBg"}},"unsigned":{"age_ts":1674211359799}}	3
$Y_182-w64pn902ATtlukjIsNSzVBtF9fw_aMYWx9DdY	!FSwSlJXpOZZONTVfGs:localhost	{"token_id":15,"historical":false}	{"auth_events":["$Z-W9-QEq_roRPUfFFGrVn3vc_d4uekRlcsL3uBSdDpM","$4ywygf1-17_Kq3j230bjqgAjdpc67zV0hIv7Uw6BKtA","$VI4y-gfFPbzFuAM6S6F4gXfpeWta-thThcGlPN0xQN0"],"prev_events":["$CjB4vCnMjTm70a0EahGjB5FN8EKtrdWl7F12gA2FhDo"],"type":"m.room.guest_access","room_id":"!FSwSlJXpOZZONTVfGs:localhost","sender":"@user1.matrix:localhost","content":{"guest_access":"can_join"},"depth":5,"state_key":"","origin":"localhost","origin_server_ts":1674211359896,"hashes":{"sha256":"Z4ZUfEgmRGDuDgWQ0ssq/AFebzcWa9p1dduLbTc2TLQ"},"signatures":{"localhost":{"ed25519:a_vyji":"aY4ERsiDaOhuSTOkyrJeO3IC/crQQ1/SiEkYc/uD3dtnf9I6zFAqCdqUATJoTSHt8GrOT2MSBYsda1kCuLdTDw"}},"unsigned":{"age_ts":1674211359896}}	3
$27FTfsExd-igZozi1nKpy5Iyqayuxc3DZY9LFN9e6oo	!FSwSlJXpOZZONTVfGs:localhost	{"token_id":15,"historical":false}	{"auth_events":["$Z-W9-QEq_roRPUfFFGrVn3vc_d4uekRlcsL3uBSdDpM","$4ywygf1-17_Kq3j230bjqgAjdpc67zV0hIv7Uw6BKtA","$VI4y-gfFPbzFuAM6S6F4gXfpeWta-thThcGlPN0xQN0"],"prev_events":["$Y_182-w64pn902ATtlukjIsNSzVBtF9fw_aMYWx9DdY"],"type":"m.space.parent","room_id":"!FSwSlJXpOZZONTVfGs:localhost","sender":"@user1.matrix:localhost","content":{"via":["localhost"],"canonical":true},"depth":6,"state_key":"!cUrTzQWGYNmZYMHoGB:localhost","origin":"localhost","origin_server_ts":1674211359967,"hashes":{"sha256":"+6feMImuusxcDQrN3KBK+jeN6AfPa8lowZGr/uTm/Js"},"signatures":{"localhost":{"ed25519:a_vyji":"rXMRrh0sqy+u5OIZnlIa6OusSnkCM9BGUkYWUsQJN24bCYFQWDN+94pK4o3tHb6fp6Rv4fmcEBugFTlsKf8hAg"}},"unsigned":{"age_ts":1674211359967}}	3
$33Pk__-gU3AslKMgHWQqdrgfvEhGtn4nPTRaDuhZUC0	!FSwSlJXpOZZONTVfGs:localhost	{"token_id":15,"historical":false}	{"auth_events":["$Z-W9-QEq_roRPUfFFGrVn3vc_d4uekRlcsL3uBSdDpM","$4ywygf1-17_Kq3j230bjqgAjdpc67zV0hIv7Uw6BKtA","$VI4y-gfFPbzFuAM6S6F4gXfpeWta-thThcGlPN0xQN0"],"prev_events":["$27FTfsExd-igZozi1nKpy5Iyqayuxc3DZY9LFN9e6oo"],"type":"m.room.history_visibility","room_id":"!FSwSlJXpOZZONTVfGs:localhost","sender":"@user1.matrix:localhost","content":{"history_visibility":"world_readable"},"depth":7,"state_key":"","origin":"localhost","origin_server_ts":1674211360009,"hashes":{"sha256":"mi1DWuspYqkbmrHYJJgk3pZwJRIDCnkbqN9y8D3TjMk"},"signatures":{"localhost":{"ed25519:a_vyji":"g1BYXkVVpAlN0WS8LHZBCREE4sc9wswSad8xC9tKLnRCc/FIGwlwa2JxVpJw1D5Mdoe0RoXpyVFRGwC7jNIqCQ"}},"unsigned":{"age_ts":1674211360009}}	3
$UEYdHpguNtwCDIQ9fsK7537cGDuKB-9QPh7SJsYm6lQ	!JGJhGNDoMdRLJzLgcJ:localhost	{"token_id":15,"historical":false}	{"auth_events":["$uDBLcAyAHq3swiKjGlyKYFZwIrP5Ux8Ki1qU7x3aVsY","$MLY05F5LyQaOuJw4avembMABTu_CtFuQyhyiF14QtYo","$A45QtHYoTPEA17jEFQZ4U882WGuYFA2D4xiKqwnZyUs"],"prev_events":["$JfR9TVM-sEe4hZ5-0bIni5e5m_tLlX2HdSU6u6IoVBM"],"type":"m.room.name","room_id":"!JGJhGNDoMdRLJzLgcJ:localhost","sender":"@user1.matrix:localhost","content":{"name":"#Space-room-3"},"depth":8,"state_key":"","origin":"localhost","origin_server_ts":1674211360520,"hashes":{"sha256":"TblTrvyu7yte8HFnp5KK5lKKuA3VL7BIaGeNwMwlvJE"},"signatures":{"localhost":{"ed25519:a_vyji":"pwTuMKyeJc+wNxR/E1qnTHdjk13ye804xdK9abQaBYGjmLa1RCvCVh+XyO4gTnK4ckyEmnhU2miPH9RQMKq4Dg"}},"unsigned":{"age_ts":1674211360520}}	3
$___RsdFndwWsVVLqEZmb4-TWJG-e1GJLt_3bnf1dFu8	!cUrTzQWGYNmZYMHoGB:localhost	{"token_id":15,"historical":false}	{"auth_events":["$Ip3uw4uae3e7xwaJ6BU2ppE2nWhA0Zyb0KZDNvHAdmU","$nofByIO1FFs8JcKVqFZb7ulSmWdVGm_V-3n-LceVmnw","$XhE1A2QtMIi_b9SfK9jbadCTQ4Xd5IZxBaUOcfglbIA"],"prev_events":["$SFXqj2UcfZU2XtnGBtupMwsoI3Z5JLp-7mmR2PU4MjQ"],"type":"m.space.child","room_id":"!cUrTzQWGYNmZYMHoGB:localhost","sender":"@user1.matrix:localhost","content":{"via":["localhost"],"suggested":true},"depth":10,"state_key":"!hccoYOyrWRMEhMnaoh:localhost","origin":"localhost","origin_server_ts":1674211361192,"hashes":{"sha256":"wfD+TZM5ViYRRM7YgBtoxfgaPLj7NC1VcbGlLpKNGPw"},"signatures":{"localhost":{"ed25519:a_vyji":"xE32Ugh3TiBR56EdgYk8pAhZ8mWpmWxRsHVPz/5QG8LM5vW5/aRxqZo8tdKyqlhT1LiDJ5i4y/g+OYuM5KoXAw"}},"unsigned":{"age_ts":1674211361192}}	3
$sUchhgur-fFKVUmMUaBERmjM3ItMz4-8bhkuD7UXnuU	!hccoYOyrWRMEhMnaoh:localhost	{"token_id":15,"historical":false}	{"auth_events":["$RRFtexNdS-wxfmZgcU9kk5Lyp462lIuVu6piimDKCGA","$nMtE3MPK3rxeHXzgEF1GWQXqF1Of8IqoWwPKejXxdrg","$LnGTvN89zWMaGdr_8T22TNwZ8hCnAeMlGOMaGpCPahE"],"prev_events":["$-FXdMAkllHkSbPP-QDGsb_zIuCwPKR511zZahmMGKs4"],"type":"m.room.name","room_id":"!hccoYOyrWRMEhMnaoh:localhost","sender":"@user1.matrix:localhost","content":{"name":"#Space-room-1"},"depth":8,"state_key":"","origin":"localhost","origin_server_ts":1674211360600,"hashes":{"sha256":"PG0tgiOhFDwMzSNEfCaXSGvZf3SAUDYWEollIFO6RKw"},"signatures":{"localhost":{"ed25519:a_vyji":"mKPvaF5XqpWrQNZ79aZtFojLTfk/0YIzCObNcB+oLpzHSs4vU+kKyF2llTPWpuUOEmM170sqjuATHqVFIkUCAA"}},"unsigned":{"age_ts":1674211360600}}	3
$FJVN_jtSz6ZNRLKTCrfOqY0M69xPDbu_hr4GTuB_3u8	!hccoYOyrWRMEhMnaoh:localhost	{"token_id":15,"txn_id":"m1674211486605.4","historical":false}	{"auth_events":["$RRFtexNdS-wxfmZgcU9kk5Lyp462lIuVu6piimDKCGA","$nMtE3MPK3rxeHXzgEF1GWQXqF1Of8IqoWwPKejXxdrg","$LnGTvN89zWMaGdr_8T22TNwZ8hCnAeMlGOMaGpCPahE"],"prev_events":["$almCp-spfN30ITGsQkwvqZtOB3TVD17i4DcwiaswR4E"],"type":"m.room.message","room_id":"!hccoYOyrWRMEhMnaoh:localhost","sender":"@user1.matrix:localhost","content":{"org.matrix.msc1767.text":"klklkl","body":"klklkl","msgtype":"m.text"},"depth":10,"origin":"localhost","origin_server_ts":1674211486683,"hashes":{"sha256":"fzt0j0TvFfR9NqHNVdpWL1ldPtEsPiTu/b38/VMRyR4"},"signatures":{"localhost":{"ed25519:a_vyji":"luzgLLrmmhFYjrcnINp0pkpqcoSdDwqy0ypfxe3h+en/RNwXgA7Iv78a7vYMRG4bn98LYCJTssX/NfaHDA5UCA"}},"unsigned":{"age_ts":1674211486683}}	3
$PfXwdx6I54mC3f0Zd8nOukV5nTCxL7uRQKGn3Bxg17Y	!kmbTYjjsDRDHGgVqUP:localhost	{"token_id":15,"txn_id":"m1674211519535.5","historical":false}	{"auth_events":["$5DYqRHQPE1SQt9QXHJodWH7x4Pztz3LTsgH1kdHawZs","$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w","$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU"],"prev_events":["$RVi3Hrw_NGpZOOlLIRSt-m_lPWPYt0K7JLecNmlU1Sw"],"type":"m.room.message","room_id":"!kmbTYjjsDRDHGgVqUP:localhost","sender":"@user1.matrix:localhost","content":{"org.matrix.msc1767.text":"Nice","body":"Nice","msgtype":"m.text"},"depth":32,"origin":"localhost","origin_server_ts":1674211519597,"hashes":{"sha256":"Xb6Mc0zuI+ghN4p6OHyAbgFVlZRmfycTcsc75WOpINo"},"signatures":{"localhost":{"ed25519:a_vyji":"dtKw7k03D0anLuFk6AP4iAO/Lj4/BVKs1F8ogAZXNOtDpuhCw9/ClRQkSKVQd3Z6YynpA/cch3FKji6/XLZBDg"}},"unsigned":{"age_ts":1674211519597}}	3
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
!dKcbdDATuwwphjRPQP:localhost	$UlpkVhx0UMdfV3JIISqctfZ_aMoIkpmIqcfxcCxxRL8	@admin:localhost	\N		22	77	1	0	0	main
!dKcbdDATuwwphjRPQP:localhost	$UlpkVhx0UMdfV3JIISqctfZ_aMoIkpmIqcfxcCxxRL8	@matrix_a:localhost	\N		22	77	1	0	0	main
!dKcbdDATuwwphjRPQP:localhost	$UlpkVhx0UMdfV3JIISqctfZ_aMoIkpmIqcfxcCxxRL8	@matrix_b:localhost	\N		22	77	1	0	0	main
!dKcbdDATuwwphjRPQP:localhost	$UlpkVhx0UMdfV3JIISqctfZ_aMoIkpmIqcfxcCxxRL8	@ignored_user:localhost	\N		22	77	1	0	0	main
!dKcbdDATuwwphjRPQP:localhost	$UlpkVhx0UMdfV3JIISqctfZ_aMoIkpmIqcfxcCxxRL8	@matterbot:localhost	\N		22	77	1	0	0	main
!dKcbdDATuwwphjRPQP:localhost	$_B6Ln541gYqlnaEaxAcSwy46yBXDxkldNhRG8HdrPBs	@admin:localhost	\N		23	78	1	0	0	main
!dKcbdDATuwwphjRPQP:localhost	$_B6Ln541gYqlnaEaxAcSwy46yBXDxkldNhRG8HdrPBs	@matrix_a:localhost	\N		23	78	1	0	0	main
!dKcbdDATuwwphjRPQP:localhost	$_B6Ln541gYqlnaEaxAcSwy46yBXDxkldNhRG8HdrPBs	@matrix_b:localhost	\N		23	78	1	0	0	main
!dKcbdDATuwwphjRPQP:localhost	$_B6Ln541gYqlnaEaxAcSwy46yBXDxkldNhRG8HdrPBs	@ignored_user:localhost	\N		23	78	1	0	0	main
!dKcbdDATuwwphjRPQP:localhost	$_B6Ln541gYqlnaEaxAcSwy46yBXDxkldNhRG8HdrPBs	@matterbot:localhost	\N		23	78	1	0	0	main
!dKcbdDATuwwphjRPQP:localhost	$grj8CepyvbRzzkLI4auscQ640Z-NssUGE9TSsXkp690	@admin:localhost	\N		24	79	1	0	0	main
!dKcbdDATuwwphjRPQP:localhost	$grj8CepyvbRzzkLI4auscQ640Z-NssUGE9TSsXkp690	@matrix_a:localhost	\N		24	79	1	0	0	main
!dKcbdDATuwwphjRPQP:localhost	$grj8CepyvbRzzkLI4auscQ640Z-NssUGE9TSsXkp690	@matrix_b:localhost	\N		24	79	1	0	0	main
!dKcbdDATuwwphjRPQP:localhost	$grj8CepyvbRzzkLI4auscQ640Z-NssUGE9TSsXkp690	@ignored_user:localhost	\N		24	79	1	0	0	main
!dKcbdDATuwwphjRPQP:localhost	$grj8CepyvbRzzkLI4auscQ640Z-NssUGE9TSsXkp690	@matterbot:localhost	\N		24	79	1	0	0	main
!dKcbdDATuwwphjRPQP:localhost	$oakhKpEqFw5Icor6iY_TRMQljV-HWQ3lueP0Vlm9hIY	@admin:localhost	\N		25	80	1	0	0	main
!dKcbdDATuwwphjRPQP:localhost	$oakhKpEqFw5Icor6iY_TRMQljV-HWQ3lueP0Vlm9hIY	@matrix_a:localhost	\N		25	80	1	0	0	main
!dKcbdDATuwwphjRPQP:localhost	$oakhKpEqFw5Icor6iY_TRMQljV-HWQ3lueP0Vlm9hIY	@matrix_b:localhost	\N		25	80	1	0	0	main
!dKcbdDATuwwphjRPQP:localhost	$oakhKpEqFw5Icor6iY_TRMQljV-HWQ3lueP0Vlm9hIY	@ignored_user:localhost	\N		25	80	1	0	0	main
!dKcbdDATuwwphjRPQP:localhost	$oakhKpEqFw5Icor6iY_TRMQljV-HWQ3lueP0Vlm9hIY	@matterbot:localhost	\N		25	80	1	0	0	main
!kmbTYjjsDRDHGgVqUP:localhost	$PfXwdx6I54mC3f0Zd8nOukV5nTCxL7uRQKGn3Bxg17Y	@admin:localhost	\N		32	119	1	0	0	main
!kmbTYjjsDRDHGgVqUP:localhost	$PfXwdx6I54mC3f0Zd8nOukV5nTCxL7uRQKGn3Bxg17Y	@matrix_a:localhost	\N		32	119	1	0	0	main
!kmbTYjjsDRDHGgVqUP:localhost	$PfXwdx6I54mC3f0Zd8nOukV5nTCxL7uRQKGn3Bxg17Y	@matrix_b:localhost	\N		32	119	1	0	0	main
!kmbTYjjsDRDHGgVqUP:localhost	$PfXwdx6I54mC3f0Zd8nOukV5nTCxL7uRQKGn3Bxg17Y	@ignored_user:localhost	\N		32	119	1	0	0	main
!kmbTYjjsDRDHGgVqUP:localhost	$PfXwdx6I54mC3f0Zd8nOukV5nTCxL7uRQKGn3Bxg17Y	@matterbot:localhost	\N		32	119	1	0	0	main
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
@admin:localhost	!dKcbdDATuwwphjRPQP:localhost	8	80	0	\N	main
@matrix_a:localhost	!dKcbdDATuwwphjRPQP:localhost	8	80	0	\N	main
@ignored_user:localhost	!dKcbdDATuwwphjRPQP:localhost	8	80	0	\N	main
@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	8	80	0	\N	main
@matrix_b:localhost	!dKcbdDATuwwphjRPQP:localhost	8	80	0	\N	main
@matrix_b:localhost	!kmbTYjjsDRDHGgVqUP:localhost	7	119	0	\N	main
@admin:localhost	!kmbTYjjsDRDHGgVqUP:localhost	15	119	0	\N	main
@matrix_a:localhost	!kmbTYjjsDRDHGgVqUP:localhost	15	119	0	\N	main
@ignored_user:localhost	!kmbTYjjsDRDHGgVqUP:localhost	15	119	0	\N	main
@matterbot:localhost	!kmbTYjjsDRDHGgVqUP:localhost	15	119	0	\N	main
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
X	119
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
$DTQEMlxc_4_CqP-rYQ46vmCpJtEKlxw_Ugma4cnNO6w	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'amet':6 'aspernatur':8 'atqu':1,24 'culpa':4 'delen':25 'dolorum':7 'eligendi':17 'eo':19 'ess':14 'est':13 'harum':5,18 'impedit':21 'incidunt':22 'laborum':11 'magni':20 'nisi':16 'occaecati':23 'optio':2 'quidem':9,10 'veniam':15 'veritati':3 'voluptatibus':12	1673972703246	36
$cIkI-00MET-_PQ4VaVFuuZsJ2WEz_UMnlXun9Itkqt8	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'atqu':18,21 'autem':7,29 'blanditii':5 'commodi':31 'consequuntur':22 'corrupti':26 'cum':19 'cumqu':27 'debiti':23 'dolor':34 'doloremqu':12 'eligendi':35 'enim':24 'est':32 'fugit':8 'hic':15 'libero':14,28 'minus':20 'occaecati':16 'odit':38 'perferendi':13,33 'placeat':4 'provid':3 'qui':11 'quibusdam':39 'ration':1 'saep':6 'sed':9 'sequi':2 'sint':36 'sit':37 'suscipit':25 'ullam':30 'voluptatem':17 'voluptatibus':10	1673972847384	37
$CsT9BKDbT6nCfiXJCOAHV90fgB6fYV4boIF3v6eEls4	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'alia':14 'aperiam':27 'architecto':24 'assumenda':22 'deserunt':16 'earum':4 'eligendi':30 'enim':8 'est':18,23 'expedita':20 'explicabo':31 'fugiat':6 'maxim':9 'molestia':10,21 'nemo':3,15 'non':32 'occaecati':26,29 'quae':11 'qui':19 'quod':25 'ration':7 'rem':17 'sit':34 'tenetur':33 'totam':1 'ullam':2 'ut':13,28 'vero':5 'volupt':12	1673972918773	38
$3Q6XqtJGvGa1jhhtRN9kQqoLIWqjikrH3x7yltwaZ6w	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'element':5 'messag':3 'playwright':1 'test':2	1673972961213	39
$pulJgsd1znNtSba8MCpZoXTCHhxSC0OkMutE8dDzlO0	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'8080':3 'browser':5 'fals':6 'localhost':2 'riski':4 'url':1	1673972964497	40
$JghGsUh3v1rikXL8gETZ_UJKjZC_6NY_WEgHUWlDGUM	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'1673972959618':2 'timestamp':1	1673972965174	41
$COcCgODcXP3YBig5Vk-_QDtWh0rzx9K1yVAasfvXRVk	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'anyth':10 'card':6 'exe':17 'generat':14 'messag':2 'need':12 'ross_klein19@hotmail.com':20 'seen':3 'strang':1 'synthes':4 'transmitt':18 'virtual':16 'won':7	1673973089277	42
$lGC_2RlgCMjLDCMd4bkjzCmXnXFQHNvnd9eFy28BE8E	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'copi':7 'elouise_torphy@hotmail.com':17 'messag':2 'navig':11 'neural':13 'panel':9 'ram':14 'seen':3 'sensor':15 'strang':1 'without':10	1673973777265	43
$iPEm9yDTEtMvd-r8SFs0eTz8dpjdWAFHcpWpOTKCqkk	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'alarm':6 'array':21 'back':12 'back-end':11 'copi':18 'driver':14 'end':13 'http':20 'keenan72@yahoo.com':23 'messag':2 'overrid':9 'seen':3 'sms':5 'strang':1	1673974303789	44
$Ay9Au4hI33NjvpwrmfU6OSnS-_gSjFb5bRzB6756wKo	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'ben.sawayn86@hotmail.com':17 'bypass':7 'connect':11 'firewal':9 'messag':2 'microchip':15 'primari':13 'seen':3 'strang':1 'usb':14 'without':10	1673974370506	45
$szFQBuhhfXcOIlgReai0669p3ycU-w57s91VHUKWXFA	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'bus':6 'ib':5 'input':17 'kaelyn.wilkinson61@hotmail.com':22 'messag':2 'protocol':20 'reboot':9 'seen':3 'sensor':13 'solid':11 'state':12 'strang':1 'utf8':19	1673974421534	46
$pec3QOL9YU-4d4ww5taJYfFCSKUcMIUYBRSHQoML6Vw	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'capacitor':20 'cary.bahringer89@hotmail.com':22 'driver':15 'get':11 'haptic':18 'input':6 'messag':2 'sas':14 'sdd':19 'seen':3 'strang':1 'system':8	1673974499038	47
$ckvkcjvKmxJljo0NX3W1BFf-JQMuUnFbh-r9CNPtmR4	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'carolyn.kshlerin@hotmail.com':23 'drive':16 'get':11 'hack':6 'hard':15 'hex':14 'messag':2 'monitor':8 'port':21 'seen':3 'strang':1 'usb':20 'wireless':19	1673974509109	48
$Ss566NPFclWN6Mx7hHv8fd_JaawsG1AuM6gnlM7fA-k	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'alarm':15 'auxiliari':14 'driver':8 'hdd':7 'index':12 'messag':2 'onlin':6 'seen':3 'strang':1 'use':4 'wallace_stoltenberg36@gmail.com':17	1673974556817	49
$focovH6Yc-m2CXhjrx4lhMQHQhQODpLp4g1sKHOxfaU	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'element':5 'messag':3 'playwright':1 'test':2	1674060065363	50
$Y8T81hxoxP5Ta-IxCarhZjMk4fWMtcg9FlgmTG9VgiE	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'8080':3 'browser':5 'fals':6 'localhost':2 'riski':4 'url':1	1674060068418	51
$RVi3Hrw_NGpZOOlLIRSt-m_lPWPYt0K7JLecNmlU1Sw	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'1674060064296':2 'timestamp':1	1674060069066	52
$wlATKVSoZpEXfwFpmdptZK6V2TMFQ87Bjjhru1P3dGs	!BfSgfecvJnYoZjTYRA:localhost	\N	content.name	'dine':2	1674111195964	59
$ZF1U_gGvucrvqj1m7ffy4HKGxUsoAbYKpWzUjaPqlMM	!BfSgfecvJnYoZjTYRA:localhost	\N	content.body	'messag':3 'send':1	1674111244960	61
$_MdWHbg9mI3zN-WDGIpwDRJZmDWXBeW-m3WrJiRs4t8	!pWsdJYvpdmDULVhQtX:localhost	\N	content.name	'sport':1	1674111390825	68
$7qFBn6lW7C0hRYBTRjR0tsE8qpZmodqh6LOyLL0HMnQ	!pWsdJYvpdmDULVhQtX:localhost	\N	content.topic	'handbal':1	1674111390984	69
$xCubuHnQAGuDuGdlqiquXK0QRxhOWKTh5TJZZGcL09Q	!pWsdJYvpdmDULVhQtX:localhost	\N	content.body	'messag':2	1674111446545	71
$8lVZQlOM-qXD0dT5ZSbvlEPAQPq5wJHU8KqM6sLfmWM	!pWsdJYvpdmDULVhQtX:localhost	\N	content.topic	'footbal':2 'handbal':1	1674111530536	72
$OsJU_fxidXD79b8VmXNcxdAdUkhXO3S73zUBYUa3yG8	!pWsdJYvpdmDULVhQtX:localhost	\N	content.topic	'handbal':1	1674111570171	73
$JWIcDwBleupt991UzmNH_DSdEWQPePa6uEyU2J0-ldM	!pWsdJYvpdmDULVhQtX:localhost	\N	content.body	'cool':1 'match':2	1674111611368	74
$8_ljUg0y31H3DwB8UeZyPs3Vlh_4zdSmAkWCsBDCc98	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'hi':1	1674210869080	76
$UlpkVhx0UMdfV3JIISqctfZ_aMoIkpmIqcfxcCxxRL8	!dKcbdDATuwwphjRPQP:localhost	\N	content.body		1674210902175	77
$_B6Ln541gYqlnaEaxAcSwy46yBXDxkldNhRG8HdrPBs	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'code_style.md':1	1674210902667	78
$grj8CepyvbRzzkLI4auscQ640Z-NssUGE9TSsXkp690	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'ab9719ab-315b-4eab-ab5f-84eba089ebb5.heic':1	1674211098570	79
$oakhKpEqFw5Icor6iY_TRMQljV-HWQ3lueP0Vlm9hIY	!dKcbdDATuwwphjRPQP:localhost	\N	content.body	'a1d99574-d44e-4526-bebd-470362011cd5.jpeg':1	1674211225736	80
$34bSEXw9U2DTNkZA2he27rczptl3jni1oG64GRRYkfY	!cUrTzQWGYNmZYMHoGB:localhost	\N	content.name	'first':3 'my-first-spac':1 'space':4	1674211302128	88
$SFXqj2UcfZU2XtnGBtupMwsoI3Z5JLp-7mmR2PU4MjQ	!cUrTzQWGYNmZYMHoGB:localhost	\N	content.topic		1674211302326	89
$UEYdHpguNtwCDIQ9fsK7537cGDuKB-9QPh7SJsYm6lQ	!JGJhGNDoMdRLJzLgcJ:localhost	\N	content.name	'3':4 'room':3 'space':2 'space-room':1	1674211360520	111
$sUchhgur-fFKVUmMUaBERmjM3ItMz4-8bhkuD7UXnuU	!hccoYOyrWRMEhMnaoh:localhost	\N	content.name	'1':4 'room':3 'space':2 'space-room':1	1674211360600	112
$bgbjmgXAlLz069pieqVTP8KTcxXHvT72ZwdRr71Fnqg	!FSwSlJXpOZZONTVfGs:localhost	\N	content.name	'2':4 'room':3 'space':2 'space-room':1	1674211360588	113
$almCp-spfN30ITGsQkwvqZtOB3TVD17i4DcwiaswR4E	!hccoYOyrWRMEhMnaoh:localhost	\N	content.body	'hello':1	1674211460232	117
$FJVN_jtSz6ZNRLKTCrfOqY0M69xPDbu_hr4GTuB_3u8	!hccoYOyrWRMEhMnaoh:localhost	\N	content.body	'klklkl':1	1674211486683	118
$PfXwdx6I54mC3f0Zd8nOukV5nTCxL7uRQKGn3Bxg17Y	!kmbTYjjsDRDHGgVqUP:localhost	\N	content.body	'nice':1	1674211519597	119
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
$PkPxRt8GuXFqdWre9vyhqKHlRSqflC0cOSTBOims4qY	21
$jyfZsVYOTCt8az1WqRlL53b1lAQWjIj6-IvW1w3qYks	22
$ARxMI5-TIkg2afPIDJsLgeSqCdrfbwBxm32e83QRfQ4	27
$nE3KmrZJdWnhQ2h6DgIB98qoLGnQlFFCvgSu4NS5FfA	28
$mlRlSJ1S_x5OctD_Nck7tq-Fo2IC7iOhysac1uYo_PY	29
$Y86Vdmx2z1nvkEoTqBH7oAiLE_sHPFtNgI97gsUAwaY	30
$pXbc3VIu5b4O4VzPRePQd4FjtqYPJLH87Ss7pZM-gRM	31
$q7m8fkdDrp2QE9hRAHYIR_KN8htxYXW85pB3LgG-V2U	32
$YHxtZv4JfPzIJvBMvoTgzeITfTFFng_L_4ijJ1Q97k4	33
$cH796vSd1hy4UBg8XHAqeUxz-u3gxer-uMeGrsirKbs	34
$5DYqRHQPE1SQt9QXHJodWH7x4Pztz3LTsgH1kdHawZs	35
$TKcINA6W5qTH8raDaFqEMBivZ0LjgXtIHGvxzJ9V4_8	38
$REN0AaEE212pFbK8uJB-22lyjpnqTEP0SshUeVfsGU4	45
$AwutniYNkYl6Dxs-8zYvdPdGLIcM4Kyzaldut5D0jHQ	48
$HmGCTcPZGDbaswAPjYZ0ddKt1eWRcRq89rE-yVwDV0s	49
$VFMUBSkD_jWG8nImBQfkmffKyLBdxGMpdkFACHA33Ng	53
$DTQEMlxc_4_CqP-rYQ46vmCpJtEKlxw_Ugma4cnNO6w	48
$cIkI-00MET-_PQ4VaVFuuZsJ2WEz_UMnlXun9Itkqt8	48
$CsT9BKDbT6nCfiXJCOAHV90fgB6fYV4boIF3v6eEls4	48
$3Q6XqtJGvGa1jhhtRN9kQqoLIWqjikrH3x7yltwaZ6w	53
$pulJgsd1znNtSba8MCpZoXTCHhxSC0OkMutE8dDzlO0	53
$JghGsUh3v1rikXL8gETZ_UJKjZC_6NY_WEgHUWlDGUM	53
$COcCgODcXP3YBig5Vk-_QDtWh0rzx9K1yVAasfvXRVk	53
$lGC_2RlgCMjLDCMd4bkjzCmXnXFQHNvnd9eFy28BE8E	53
$iPEm9yDTEtMvd-r8SFs0eTz8dpjdWAFHcpWpOTKCqkk	53
$Ay9Au4hI33NjvpwrmfU6OSnS-_gSjFb5bRzB6756wKo	53
$szFQBuhhfXcOIlgReai0669p3ycU-w57s91VHUKWXFA	53
$pec3QOL9YU-4d4ww5taJYfFCSKUcMIUYBRSHQoML6Vw	53
$ckvkcjvKmxJljo0NX3W1BFf-JQMuUnFbh-r9CNPtmR4	53
$Ss566NPFclWN6Mx7hHv8fd_JaawsG1AuM6gnlM7fA-k	53
$focovH6Yc-m2CXhjrx4lhMQHQhQODpLp4g1sKHOxfaU	53
$Y8T81hxoxP5Ta-IxCarhZjMk4fWMtcg9FlgmTG9VgiE	53
$RVi3Hrw_NGpZOOlLIRSt-m_lPWPYt0K7JLecNmlU1Sw	53
$NfGFxRqIrSmaeLcN53BGirnWzJ1bpwzVyt2oZw2cj1k	166
$7N18oPwd46twVh-RWhED6VAPm79aIXVCh_BVUFAFHP8	167
$eKvf8PFaZwsEOXW-IIYTGZwl6gxEYmEE2TalB5k2iGs	168
$ZraIWv18CC1pTAGQZToI1ZXr7ki_53OY_jvQl0RDE_A	169
$Uf6bLI9lxBnR9TJvz8fcfo-1_wbshzMvT4Ecr_qy-E4	170
$30q15kBxfYB9Dyc1sAhoNXYpZXfDlneq4Ckvuz_Sy1Y	171
$wlATKVSoZpEXfwFpmdptZK6V2TMFQ87Bjjhru1P3dGs	172
$PZkmtd-Zj4an2Acc9O8V-mK2mVxXChviZhd_hsf6Ehg	173
$ZF1U_gGvucrvqj1m7ffy4HKGxUsoAbYKpWzUjaPqlMM	173
$pIVIlPgvO-fbiW31dx4GB-wsRX4DrbADDn1AfJoXI50	201
$bWqW6N4T6ZlJ3MzEaI-MgqdvMEklGrNsy22WqL6ZgOc	202
$ngKTLt0SDFtdjkF6GnjahEcDA-qLwTKRcVgMgMg5tN8	203
$IxyNn3A4NegMug4xc7O0sm2s1r9jyybU5iNogwEGesQ	204
$SQpUzgCCeFIrGC3eCPDX_U021w7MG0-lHOxFTcHbvKk	205
$pe2Yi2ila5QgzVKIEGGAIeqvcRaD37GUFMvAOWX2tp0	206
$_MdWHbg9mI3zN-WDGIpwDRJZmDWXBeW-m3WrJiRs4t8	207
$7qFBn6lW7C0hRYBTRjR0tsE8qpZmodqh6LOyLL0HMnQ	208
$d7sJ6Squy3gHlaCn4UxGeu_9AcN2XCBHtBIY8VL5d_g	209
$xCubuHnQAGuDuGdlqiquXK0QRxhOWKTh5TJZZGcL09Q	209
$8lVZQlOM-qXD0dT5ZSbvlEPAQPq5wJHU8KqM6sLfmWM	210
$OsJU_fxidXD79b8VmXNcxdAdUkhXO3S73zUBYUa3yG8	211
$JWIcDwBleupt991UzmNH_DSdEWQPePa6uEyU2J0-ldM	211
$76OhaN_mof41kiqxA-qZV26DgKxkvkl8JwQjOYqZF1A	212
$8_ljUg0y31H3DwB8UeZyPs3Vlh_4zdSmAkWCsBDCc98	48
$UlpkVhx0UMdfV3JIISqctfZ_aMoIkpmIqcfxcCxxRL8	48
$_B6Ln541gYqlnaEaxAcSwy46yBXDxkldNhRG8HdrPBs	48
$grj8CepyvbRzzkLI4auscQ640Z-NssUGE9TSsXkp690	48
$oakhKpEqFw5Icor6iY_TRMQljV-HWQ3lueP0Vlm9hIY	48
$XhE1A2QtMIi_b9SfK9jbadCTQ4Xd5IZxBaUOcfglbIA	266
$Ip3uw4uae3e7xwaJ6BU2ppE2nWhA0Zyb0KZDNvHAdmU	267
$nofByIO1FFs8JcKVqFZb7ulSmWdVGm_V-3n-LceVmnw	268
$wtg0qf-MdY5Ur4UMAlOlQ58df82OmKhsbTS81ItsAT8	269
$DFCNP6Tt2ypS8tXyd5kaCiqWeVDmE_FL-iOprkrfubk	270
$MJ2YTkP3f-eQwc5HLB6GVzjnPJaVov0pUCfq1bWqG3M	271
$iAAlBelGypnsbVKn9Fd-ubLNje326TRpaegoLLyRZGY	272
$34bSEXw9U2DTNkZA2he27rczptl3jni1oG64GRRYkfY	273
$SFXqj2UcfZU2XtnGBtupMwsoI3Z5JLp-7mmR2PU4MjQ	274
$VI4y-gfFPbzFuAM6S6F4gXfpeWta-thThcGlPN0xQN0	278
$LnGTvN89zWMaGdr_8T22TNwZ8hCnAeMlGOMaGpCPahE	279
$A45QtHYoTPEA17jEFQZ4U882WGuYFA2D4xiKqwnZyUs	280
$Z-W9-QEq_roRPUfFFGrVn3vc_d4uekRlcsL3uBSdDpM	281
$uDBLcAyAHq3swiKjGlyKYFZwIrP5Ux8Ki1qU7x3aVsY	283
$RRFtexNdS-wxfmZgcU9kk5Lyp462lIuVu6piimDKCGA	282
$MLY05F5LyQaOuJw4avembMABTu_CtFuQyhyiF14QtYo	286
$e6pVgV1MsH-6_A1V_vGWGmdznPg_czNOfblinyTHshA	288
$hNUZNFVPWjQzoWmc5wymfJzaTuaIdxyWFsi3fkTJ534	290
$IYkBkm-ncU_4Z-Ft8v80LsrK5kKpzGKpHDUWZxxy6t8	294
$JfR9TVM-sEe4hZ5-0bIni5e5m_tLlX2HdSU6u6IoVBM	297
$4ywygf1-17_Kq3j230bjqgAjdpc67zV0hIv7Uw6BKtA	284
$CjB4vCnMjTm70a0EahGjB5FN8EKtrdWl7F12gA2FhDo	285
$Y_182-w64pn902ATtlukjIsNSzVBtF9fw_aMYWx9DdY	289
$27FTfsExd-igZozi1nKpy5Iyqayuxc3DZY9LFN9e6oo	292
$33Pk__-gU3AslKMgHWQqdrgfvEhGtn4nPTRaDuhZUC0	295
$UEYdHpguNtwCDIQ9fsK7537cGDuKB-9QPh7SJsYm6lQ	299
$___RsdFndwWsVVLqEZmb4-TWJG-e1GJLt_3bnf1dFu8	304
$FJVN_jtSz6ZNRLKTCrfOqY0M69xPDbu_hr4GTuB_3u8	301
$PfXwdx6I54mC3f0Zd8nOukV5nTCxL7uRQKGn3Bxg17Y	53
$nMtE3MPK3rxeHXzgEF1GWQXqF1Of8IqoWwPKejXxdrg	287
$4MpBsW-eFJ4SoVP-rLgkefjkNR0Sytuayop2Z-OBFzU	291
$5QgMOlhzvtIooZVNYnMnchsgiEUDObBacU41JO2zKs0	293
$NYaJba-K1Im8n6_Z7mL0VwgIAKxZqouzTTYu6EcK5eM	296
$-FXdMAkllHkSbPP-QDGsb_zIuCwPKR511zZahmMGKs4	298
$sUchhgur-fFKVUmMUaBERmjM3ItMz4-8bhkuD7UXnuU	301
$bgbjmgXAlLz069pieqVTP8KTcxXHvT72ZwdRr71Fnqg	300
$OUsS0radBRPS3B8beUIJ1TUjFMPXJ0OTtSau2wSu6rY	302
$z3x2QWsqd2WeWbha161nzCLfGv7psz2SV_Gveo8B5Yk	303
$almCp-spfN30ITGsQkwvqZtOB3TVD17i4DcwiaswR4E	301
\.


--
-- Data for Name: event_txn_id; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_txn_id (event_id, room_id, user_id, token_id, txn_id, inserted_ts) FROM stdin;
$8_ljUg0y31H3DwB8UeZyPs3Vlh_4zdSmAkWCsBDCc98	!dKcbdDATuwwphjRPQP:localhost	@user1.matrix:localhost	15	m1674210868984.0	1674210869191
$grj8CepyvbRzzkLI4auscQ640Z-NssUGE9TSsXkp690	!dKcbdDATuwwphjRPQP:localhost	@user1.matrix:localhost	15	m1674211098519.1	1674211098630
$oakhKpEqFw5Icor6iY_TRMQljV-HWQ3lueP0Vlm9hIY	!dKcbdDATuwwphjRPQP:localhost	@user1.matrix:localhost	15	m1674211225631.2	1674211225834
$almCp-spfN30ITGsQkwvqZtOB3TVD17i4DcwiaswR4E	!hccoYOyrWRMEhMnaoh:localhost	@user1.matrix:localhost	15	m1674211460155.3	1674211460260
$FJVN_jtSz6ZNRLKTCrfOqY0M69xPDbu_hr4GTuB_3u8	!hccoYOyrWRMEhMnaoh:localhost	@user1.matrix:localhost	15	m1674211486605.4	1674211486704
$PfXwdx6I54mC3f0Zd8nOukV5nTCxL7uRQKGn3Bxg17Y	!kmbTYjjsDRDHGgVqUP:localhost	@user1.matrix:localhost	15	m1674211519535.5	1674211519643
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.events (topological_ordering, event_id, type, room_id, content, unrecognized_keys, processed, outlier, depth, origin_server_ts, received_ts, sender, contains_url, instance_name, stream_ordering, state_key, rejection_reason) FROM stdin;
21	$8_ljUg0y31H3DwB8UeZyPs3Vlh_4zdSmAkWCsBDCc98	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	21	1674210869080	1674210869188	@user1.matrix:localhost	f	master	76	\N	\N
24	$grj8CepyvbRzzkLI4auscQ640Z-NssUGE9TSsXkp690	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	24	1674211098570	1674211098627	@user1.matrix:localhost	t	master	79	\N	\N
6	$MJ2YTkP3f-eQwc5HLB6GVzjnPJaVov0pUCfq1bWqG3M	m.room.guest_access	!cUrTzQWGYNmZYMHoGB:localhost	\N	\N	t	f	6	1674211301685	1674211302035	@user1.matrix:localhost	f	master	86		\N
7	$iAAlBelGypnsbVKn9Fd-ubLNje326TRpaegoLLyRZGY	m.room.history_visibility	!cUrTzQWGYNmZYMHoGB:localhost	\N	\N	t	f	7	1674211301709	1674211302035	@user1.matrix:localhost	f	master	87		\N
9	$SFXqj2UcfZU2XtnGBtupMwsoI3Z5JLp-7mmR2PU4MjQ	m.room.topic	!cUrTzQWGYNmZYMHoGB:localhost	\N	\N	t	f	9	1674211302326	1674211302434	@user1.matrix:localhost	f	master	89		\N
1	$LnGTvN89zWMaGdr_8T22TNwZ8hCnAeMlGOMaGpCPahE	m.room.create	!hccoYOyrWRMEhMnaoh:localhost	\N	\N	t	f	1	1674211359284	1674211359415	@user1.matrix:localhost	f	master	91		\N
2	$Z-W9-QEq_roRPUfFFGrVn3vc_d4uekRlcsL3uBSdDpM	m.room.member	!FSwSlJXpOZZONTVfGs:localhost	\N	\N	t	f	2	1674211359556	1674211359647	@user1.matrix:localhost	f	master	93	@user1.matrix:localhost	\N
2	$uDBLcAyAHq3swiKjGlyKYFZwIrP5Ux8Ki1qU7x3aVsY	m.room.member	!JGJhGNDoMdRLJzLgcJ:localhost	\N	\N	t	f	2	1674211359620	1674211359689	@user1.matrix:localhost	f	master	95	@user1.matrix:localhost	\N
2	$RRFtexNdS-wxfmZgcU9kk5Lyp462lIuVu6piimDKCGA	m.room.member	!hccoYOyrWRMEhMnaoh:localhost	\N	\N	t	f	2	1674211359590	1674211359691	@user1.matrix:localhost	f	master	94	@user1.matrix:localhost	\N
3	$nMtE3MPK3rxeHXzgEF1GWQXqF1Of8IqoWwPKejXxdrg	m.room.power_levels	!hccoYOyrWRMEhMnaoh:localhost	\N	\N	t	f	3	1674211359836	1674211360427	@user1.matrix:localhost	f	master	106		\N
4	$4MpBsW-eFJ4SoVP-rLgkefjkNR0Sytuayop2Z-OBFzU	m.room.join_rules	!hccoYOyrWRMEhMnaoh:localhost	\N	\N	t	f	4	1674211359954	1674211360427	@user1.matrix:localhost	f	master	107		\N
5	$5QgMOlhzvtIooZVNYnMnchsgiEUDObBacU41JO2zKs0	m.room.guest_access	!hccoYOyrWRMEhMnaoh:localhost	\N	\N	t	f	5	1674211359993	1674211360427	@user1.matrix:localhost	f	master	108		\N
6	$NYaJba-K1Im8n6_Z7mL0VwgIAKxZqouzTTYu6EcK5eM	m.space.parent	!hccoYOyrWRMEhMnaoh:localhost	\N	\N	t	f	6	1674211360019	1674211360427	@user1.matrix:localhost	f	master	109	!cUrTzQWGYNmZYMHoGB:localhost	\N
7	$-FXdMAkllHkSbPP-QDGsb_zIuCwPKR511zZahmMGKs4	m.room.history_visibility	!hccoYOyrWRMEhMnaoh:localhost	\N	\N	t	f	7	1674211360039	1674211360427	@user1.matrix:localhost	f	master	110		\N
8	$sUchhgur-fFKVUmMUaBERmjM3ItMz4-8bhkuD7UXnuU	m.room.name	!hccoYOyrWRMEhMnaoh:localhost	\N	\N	t	f	8	1674211360600	1674211360836	@user1.matrix:localhost	f	master	112		\N
10	$OUsS0radBRPS3B8beUIJ1TUjFMPXJ0OTtSau2wSu6rY	m.space.child	!cUrTzQWGYNmZYMHoGB:localhost	\N	\N	t	f	10	1674211361193	1674211361603	@user1.matrix:localhost	f	master	115	!FSwSlJXpOZZONTVfGs:localhost	\N
10	$z3x2QWsqd2WeWbha161nzCLfGv7psz2SV_Gveo8B5Yk	m.space.child	!cUrTzQWGYNmZYMHoGB:localhost	\N	\N	t	f	10	1674211361207	1674211361603	@user1.matrix:localhost	f	master	116	!JGJhGNDoMdRLJzLgcJ:localhost	\N
9	$almCp-spfN30ITGsQkwvqZtOB3TVD17i4DcwiaswR4E	m.room.message	!hccoYOyrWRMEhMnaoh:localhost	\N	\N	t	f	9	1674211460232	1674211460259	@user1.matrix:localhost	f	master	117	\N	\N
22	$UlpkVhx0UMdfV3JIISqctfZ_aMoIkpmIqcfxcCxxRL8	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	22	1674210902175	1674210902267	@mm_user1.mm:localhost	f	master	77	\N	\N
1	$XhE1A2QtMIi_b9SfK9jbadCTQ4Xd5IZxBaUOcfglbIA	m.room.create	!cUrTzQWGYNmZYMHoGB:localhost	\N	\N	t	f	1	1674211301080	1674211301147	@user1.matrix:localhost	f	master	81		\N
2	$Ip3uw4uae3e7xwaJ6BU2ppE2nWhA0Zyb0KZDNvHAdmU	m.room.member	!cUrTzQWGYNmZYMHoGB:localhost	\N	\N	t	f	2	1674211301349	1674211301411	@user1.matrix:localhost	f	master	82	@user1.matrix:localhost	\N
8	$34bSEXw9U2DTNkZA2he27rczptl3jni1oG64GRRYkfY	m.room.name	!cUrTzQWGYNmZYMHoGB:localhost	\N	\N	t	f	8	1674211302128	1674211302224	@user1.matrix:localhost	f	master	88		\N
1	$VI4y-gfFPbzFuAM6S6F4gXfpeWta-thThcGlPN0xQN0	m.room.create	!FSwSlJXpOZZONTVfGs:localhost	\N	\N	t	f	1	1674211359282	1674211359414	@user1.matrix:localhost	f	master	90		\N
1	$A45QtHYoTPEA17jEFQZ4U882WGuYFA2D4xiKqwnZyUs	m.room.create	!JGJhGNDoMdRLJzLgcJ:localhost	\N	\N	t	f	1	1674211359296	1674211359425	@user1.matrix:localhost	f	master	92		\N
3	$MLY05F5LyQaOuJw4avembMABTu_CtFuQyhyiF14QtYo	m.room.power_levels	!JGJhGNDoMdRLJzLgcJ:localhost	\N	\N	t	f	3	1674211359847	1674211360363	@user1.matrix:localhost	f	master	96		\N
4	$e6pVgV1MsH-6_A1V_vGWGmdznPg_czNOfblinyTHshA	m.room.join_rules	!JGJhGNDoMdRLJzLgcJ:localhost	\N	\N	t	f	4	1674211359893	1674211360363	@user1.matrix:localhost	f	master	97		\N
5	$hNUZNFVPWjQzoWmc5wymfJzaTuaIdxyWFsi3fkTJ534	m.room.guest_access	!JGJhGNDoMdRLJzLgcJ:localhost	\N	\N	t	f	5	1674211359965	1674211360363	@user1.matrix:localhost	f	master	98		\N
6	$IYkBkm-ncU_4Z-Ft8v80LsrK5kKpzGKpHDUWZxxy6t8	m.space.parent	!JGJhGNDoMdRLJzLgcJ:localhost	\N	\N	t	f	6	1674211359994	1674211360363	@user1.matrix:localhost	f	master	99	!cUrTzQWGYNmZYMHoGB:localhost	\N
7	$JfR9TVM-sEe4hZ5-0bIni5e5m_tLlX2HdSU6u6IoVBM	m.room.history_visibility	!JGJhGNDoMdRLJzLgcJ:localhost	\N	\N	t	f	7	1674211360020	1674211360363	@user1.matrix:localhost	f	master	100		\N
3	$4ywygf1-17_Kq3j230bjqgAjdpc67zV0hIv7Uw6BKtA	m.room.power_levels	!FSwSlJXpOZZONTVfGs:localhost	\N	\N	t	f	3	1674211359740	1674211360383	@user1.matrix:localhost	f	master	101		\N
4	$CjB4vCnMjTm70a0EahGjB5FN8EKtrdWl7F12gA2FhDo	m.room.join_rules	!FSwSlJXpOZZONTVfGs:localhost	\N	\N	t	f	4	1674211359799	1674211360383	@user1.matrix:localhost	f	master	102		\N
5	$Y_182-w64pn902ATtlukjIsNSzVBtF9fw_aMYWx9DdY	m.room.guest_access	!FSwSlJXpOZZONTVfGs:localhost	\N	\N	t	f	5	1674211359896	1674211360383	@user1.matrix:localhost	f	master	103		\N
6	$27FTfsExd-igZozi1nKpy5Iyqayuxc3DZY9LFN9e6oo	m.space.parent	!FSwSlJXpOZZONTVfGs:localhost	\N	\N	t	f	6	1674211359967	1674211360383	@user1.matrix:localhost	f	master	104	!cUrTzQWGYNmZYMHoGB:localhost	\N
7	$33Pk__-gU3AslKMgHWQqdrgfvEhGtn4nPTRaDuhZUC0	m.room.history_visibility	!FSwSlJXpOZZONTVfGs:localhost	\N	\N	t	f	7	1674211360009	1674211360383	@user1.matrix:localhost	f	master	105		\N
8	$UEYdHpguNtwCDIQ9fsK7537cGDuKB-9QPh7SJsYm6lQ	m.room.name	!JGJhGNDoMdRLJzLgcJ:localhost	\N	\N	t	f	8	1674211360520	1674211360766	@user1.matrix:localhost	f	master	111		\N
8	$bgbjmgXAlLz069pieqVTP8KTcxXHvT72ZwdRr71Fnqg	m.room.name	!FSwSlJXpOZZONTVfGs:localhost	\N	\N	t	f	8	1674211360588	1674211360839	@user1.matrix:localhost	f	master	113		\N
10	$___RsdFndwWsVVLqEZmb4-TWJG-e1GJLt_3bnf1dFu8	m.space.child	!cUrTzQWGYNmZYMHoGB:localhost	\N	\N	t	f	10	1674211361192	1674211361405	@user1.matrix:localhost	f	master	114	!hccoYOyrWRMEhMnaoh:localhost	\N
10	$FJVN_jtSz6ZNRLKTCrfOqY0M69xPDbu_hr4GTuB_3u8	m.room.message	!hccoYOyrWRMEhMnaoh:localhost	\N	\N	t	f	10	1674211486683	1674211486703	@user1.matrix:localhost	f	master	118	\N	\N
32	$PfXwdx6I54mC3f0Zd8nOukV5nTCxL7uRQKGn3Bxg17Y	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	32	1674211519597	1674211519642	@user1.matrix:localhost	f	master	119	\N	\N
1	$mBmRyyvP_Jc-LDi7_hiGD9QTu5XGVXqNMxZM4yDMQPU	m.room.create	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	1	1598686327756	1598686327770	@admin:localhost	f	\N	2		\N
2	$_oKaaOfL7rFtPsAsxDmHrCY9sAzFjslRwkJ_QHxHDTw	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	2	1598686327803	1598686327820	@admin:localhost	f	\N	3	@admin:localhost	\N
3	$BYyVCPyJh9PVJBsxDwm9NakGY19DlCJJ1GlCcYpTv8w	m.room.power_levels	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	3	1598686327849	1598686327860	@admin:localhost	f	\N	4		\N
4	$X8tdoEsXAgBC6gobCepAn3rwO8CJoQU6i9NN9Rzhukg	m.room.canonical_alias	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	4	1598686327933	1598686327989	@admin:localhost	f	\N	5		\N
5	$G_m59AjH2Y1FX4D11JDsmEETfHGAWoknTIdv-_XYW2o	m.room.join_rules	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	5	1598686328055	1598686328083	@admin:localhost	f	\N	6		\N
6	$O5iO4EII22igkDq5cMKHFB-SGIYD0KqJQXZohS2Dzc0	m.room.history_visibility	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	6	1598686328127	1598686328156	@admin:localhost	f	\N	7		\N
1	$Rczn5GeJ1aYMBU_oXSIF8ppVk8WEruaYIBA3FE7Yq88	m.room.create	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	1	1598686328210	1598686328221	@admin:localhost	f	\N	8		\N
2	$PeAJ6BypXjJegHiUjcYe-I6Cf4NuCPICi_yUb-fyauA	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	2	1598686328245	1598686328258	@admin:localhost	f	\N	9	@admin:localhost	\N
3	$P98vptI_jrNYKKnTTDYouThgohgHqJkD5Rcj0gDgxII	m.room.power_levels	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	3	1598686328280	1598686328291	@admin:localhost	f	\N	10		\N
4	$b__a7rX3L5YpX7nAZte73DAbjtXZK48JH8VKSnGOKKw	m.room.canonical_alias	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	4	1598686328305	1598686328319	@admin:localhost	f	\N	11		\N
5	$hEtlt0NU16h0ix9xBX0MDJR0g54ATEZ4S96udYzYBqs	m.room.join_rules	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	5	1598686328338	1598686328349	@admin:localhost	f	\N	12		\N
6	$TVnvv0nGbLydCBtMmTTz-htMsoI4hmxCr3s9AHyFGHQ	m.room.history_visibility	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	6	1598686328366	1598686328379	@admin:localhost	f	\N	13		\N
7	$N33GyONpuSa3zRNJk1CtLYdhqJbhXBwSpAlUUm-zmB8	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	7	1598686328406	1598686328420	@matrix_a:localhost	f	\N	14	@matrix_a:localhost	\N
7	$wd-zBsOV9K_8HbhPARZ91kf5cfZwLKRi7yBBGGNUAb0	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	7	1598686328450	1598686328461	@matrix_a:localhost	f	\N	15	@matrix_a:localhost	\N
8	$llCtN-sfVC1IOdDQXgskgx4jl97hQHfKnEH-IP-lyvk	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	8	1598686328493	1598686328506	@matrix_b:localhost	f	\N	16	@matrix_b:localhost	\N
8	$4ZLf-3JRJMLLADbzome2n_5rZNEeHEFIo3w1xN4KKu0	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	8	1598686328533	1598686328544	@matrix_b:localhost	f	\N	17	@matrix_b:localhost	\N
9	$hD2Z-BHkSscOTiftcJe1n-peOIsihQlQbtyjR2IkTmA	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	9	1598686328575	1598686328587	@ignored_user:localhost	f	\N	18	@ignored_user:localhost	\N
9	$Svf91tyGyUuzelYH8bbzM6QXuI9Xcab-XMXjCrIgM5A	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	9	1598686328616	1598686328628	@ignored_user:localhost	f	\N	19	@ignored_user:localhost	\N
10	$PkPxRt8GuXFqdWre9vyhqKHlRSqflC0cOSTBOims4qY	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	10	1673965923529	1673965923627	@matterbot:localhost	f	master	20	@matterbot:localhost	\N
10	$jyfZsVYOTCt8az1WqRlL53b1lAQWjIj6-IvW1w3qYks	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	10	1673965923535	1673965923629	@matterbot:localhost	f	master	21	@matterbot:localhost	\N
11	$ARxMI5-TIkg2afPIDJsLgeSqCdrfbwBxm32e83QRfQ4	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	11	1673966482039	1673966482136	@matterbot:localhost	f	master	22	@mm_mattermost_a:localhost	\N
11	$nE3KmrZJdWnhQ2h6DgIB98qoLGnQlFFCvgSu4NS5FfA	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	11	1673966482208	1673966482325	@matterbot:localhost	f	master	23	@mm_mattermost_a:localhost	\N
12	$mlRlSJ1S_x5OctD_Nck7tq-Fo2IC7iOhysac1uYo_PY	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	12	1673966482334	1673966482378	@matterbot:localhost	f	master	24	@mm_mattermost_b:localhost	\N
12	$Y86Vdmx2z1nvkEoTqBH7oAiLE_sHPFtNgI97gsUAwaY	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	12	1673966482494	1673966482568	@matterbot:localhost	f	master	25	@mm_mattermost_b:localhost	\N
13	$pXbc3VIu5b4O4VzPRePQd4FjtqYPJLH87Ss7pZM-gRM	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	13	1673966482533	1673966482577	@mm_mattermost_a:localhost	f	master	26	@mm_mattermost_a:localhost	\N
14	$q7m8fkdDrp2QE9hRAHYIR_KN8htxYXW85pB3LgG-V2U	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	14	1673966482710	1673966482783	@mm_mattermost_b:localhost	f	master	27	@mm_mattermost_b:localhost	\N
13	$YHxtZv4JfPzIJvBMvoTgzeITfTFFng_L_4ijJ1Q97k4	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	13	1673966482750	1673966482785	@mm_mattermost_a:localhost	f	master	28	@mm_mattermost_a:localhost	\N
14	$cH796vSd1hy4UBg8XHAqeUxz-u3gxer-uMeGrsirKbs	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	14	1673966483038	1673966483150	@mm_mattermost_b:localhost	f	master	29	@mm_mattermost_b:localhost	\N
15	$5DYqRHQPE1SQt9QXHJodWH7x4Pztz3LTsgH1kdHawZs	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	15	1673968543297	1673968543336	@user1.matrix:localhost	f	master	30	@user1.matrix:localhost	\N
15	$TKcINA6W5qTH8raDaFqEMBivZ0LjgXtIHGvxzJ9V4_8	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	15	1673968600436	1673968600473	@user1.matrix:localhost	f	master	31	@user1.matrix:localhost	\N
16	$REN0AaEE212pFbK8uJB-22lyjpnqTEP0SshUeVfsGU4	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	16	1673969011769	1673969011817	@matterbot:localhost	f	master	32	@mm_user1.mm:localhost	\N
17	$AwutniYNkYl6Dxs-8zYvdPdGLIcM4Kyzaldut5D0jHQ	m.room.member	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	17	1673969012107	1673969012185	@mm_user1.mm:localhost	f	master	33	@mm_user1.mm:localhost	\N
16	$HmGCTcPZGDbaswAPjYZ0ddKt1eWRcRq89rE-yVwDV0s	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	16	1673969012213	1673969012317	@matterbot:localhost	f	master	34	@mm_user1.mm:localhost	\N
17	$VFMUBSkD_jWG8nImBQfkmffKyLBdxGMpdkFACHA33Ng	m.room.member	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	17	1673969012530	1673969012580	@mm_user1.mm:localhost	f	master	35	@mm_user1.mm:localhost	\N
18	$DTQEMlxc_4_CqP-rYQ46vmCpJtEKlxw_Ugma4cnNO6w	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	18	1673972703246	1673972703319	@mm_user1.mm:localhost	f	master	36	\N	\N
19	$cIkI-00MET-_PQ4VaVFuuZsJ2WEz_UMnlXun9Itkqt8	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	19	1673972847384	1673972847428	@mm_user1.mm:localhost	f	master	37	\N	\N
20	$CsT9BKDbT6nCfiXJCOAHV90fgB6fYV4boIF3v6eEls4	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	20	1673972918773	1673972918824	@mm_user1.mm:localhost	f	master	38	\N	\N
18	$3Q6XqtJGvGa1jhhtRN9kQqoLIWqjikrH3x7yltwaZ6w	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	18	1673972961213	1673972961350	@user1.matrix:localhost	f	master	39	\N	\N
19	$pulJgsd1znNtSba8MCpZoXTCHhxSC0OkMutE8dDzlO0	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	19	1673972964497	1673972964577	@user1.matrix:localhost	f	master	40	\N	\N
20	$JghGsUh3v1rikXL8gETZ_UJKjZC_6NY_WEgHUWlDGUM	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	20	1673972965174	1673972965248	@user1.matrix:localhost	f	master	41	\N	\N
21	$COcCgODcXP3YBig5Vk-_QDtWh0rzx9K1yVAasfvXRVk	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	21	1673973089277	1673973089350	@matrix_b:localhost	f	master	42	\N	\N
22	$lGC_2RlgCMjLDCMd4bkjzCmXnXFQHNvnd9eFy28BE8E	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	22	1673973777265	1673973777335	@matrix_b:localhost	f	master	43	\N	\N
23	$iPEm9yDTEtMvd-r8SFs0eTz8dpjdWAFHcpWpOTKCqkk	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	23	1673974303789	1673974303829	@matrix_b:localhost	f	master	44	\N	\N
24	$Ay9Au4hI33NjvpwrmfU6OSnS-_gSjFb5bRzB6756wKo	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	24	1673974370506	1673974370531	@matrix_b:localhost	f	master	45	\N	\N
25	$szFQBuhhfXcOIlgReai0669p3ycU-w57s91VHUKWXFA	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	25	1673974421534	1673974421554	@matrix_b:localhost	f	master	46	\N	\N
27	$ckvkcjvKmxJljo0NX3W1BFf-JQMuUnFbh-r9CNPtmR4	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	27	1673974509109	1673974509132	@matrix_b:localhost	f	master	48	\N	\N
28	$Ss566NPFclWN6Mx7hHv8fd_JaawsG1AuM6gnlM7fA-k	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	28	1673974556817	1673974556839	@matrix_b:localhost	f	master	49	\N	\N
26	$pec3QOL9YU-4d4ww5taJYfFCSKUcMIUYBRSHQoML6Vw	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	26	1673974499038	1673974499073	@matrix_b:localhost	f	master	47	\N	\N
29	$focovH6Yc-m2CXhjrx4lhMQHQhQODpLp4g1sKHOxfaU	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	29	1674060065363	1674060065543	@user1.matrix:localhost	f	master	50	\N	\N
30	$Y8T81hxoxP5Ta-IxCarhZjMk4fWMtcg9FlgmTG9VgiE	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	30	1674060068418	1674060068497	@user1.matrix:localhost	f	master	51	\N	\N
31	$RVi3Hrw_NGpZOOlLIRSt-m_lPWPYt0K7JLecNmlU1Sw	m.room.message	!kmbTYjjsDRDHGgVqUP:localhost	\N	\N	t	f	31	1674060069066	1674060069564	@user1.matrix:localhost	f	master	52	\N	\N
1	$NfGFxRqIrSmaeLcN53BGirnWzJ1bpwzVyt2oZw2cj1k	m.room.create	!BfSgfecvJnYoZjTYRA:localhost	\N	\N	t	f	1	1674111194830	1674111194893	@user1.matrix:localhost	f	master	53		\N
2	$7N18oPwd46twVh-RWhED6VAPm79aIXVCh_BVUFAFHP8	m.room.member	!BfSgfecvJnYoZjTYRA:localhost	\N	\N	t	f	2	1674111195055	1674111195093	@user1.matrix:localhost	f	master	54	@user1.matrix:localhost	\N
3	$eKvf8PFaZwsEOXW-IIYTGZwl6gxEYmEE2TalB5k2iGs	m.room.power_levels	!BfSgfecvJnYoZjTYRA:localhost	\N	\N	t	f	3	1674111195193	1674111195278	@user1.matrix:localhost	f	master	55		\N
4	$ZraIWv18CC1pTAGQZToI1ZXr7ki_53OY_jvQl0RDE_A	m.room.canonical_alias	!BfSgfecvJnYoZjTYRA:localhost	\N	\N	t	f	4	1674111195509	1674111195542	@user1.matrix:localhost	f	master	56		\N
5	$Uf6bLI9lxBnR9TJvz8fcfo-1_wbshzMvT4Ecr_qy-E4	m.room.join_rules	!BfSgfecvJnYoZjTYRA:localhost	\N	\N	t	f	5	1674111195684	1674111195717	@user1.matrix:localhost	f	master	57		\N
6	$30q15kBxfYB9Dyc1sAhoNXYpZXfDlneq4Ckvuz_Sy1Y	m.room.history_visibility	!BfSgfecvJnYoZjTYRA:localhost	\N	\N	t	f	6	1674111195816	1674111195871	@user1.matrix:localhost	f	master	58		\N
7	$wlATKVSoZpEXfwFpmdptZK6V2TMFQ87Bjjhru1P3dGs	m.room.name	!BfSgfecvJnYoZjTYRA:localhost	\N	\N	t	f	7	1674111195964	1674111196002	@user1.matrix:localhost	f	master	59		\N
8	$PZkmtd-Zj4an2Acc9O8V-mK2mVxXChviZhd_hsf6Ehg	m.room.member	!BfSgfecvJnYoZjTYRA:localhost	\N	\N	t	f	8	1674111228158	1674111228220	@user1.matrix:localhost	f	master	60	@mm_mattermost_a:localhost	\N
9	$ZF1U_gGvucrvqj1m7ffy4HKGxUsoAbYKpWzUjaPqlMM	m.room.message	!BfSgfecvJnYoZjTYRA:localhost	\N	\N	t	f	9	1674111244960	1674111244984	@user1.matrix:localhost	f	master	61	\N	\N
1	$pIVIlPgvO-fbiW31dx4GB-wsRX4DrbADDn1AfJoXI50	m.room.create	!pWsdJYvpdmDULVhQtX:localhost	\N	\N	t	f	1	1674111389371	1674111389403	@user1.matrix:localhost	f	master	62		\N
2	$bWqW6N4T6ZlJ3MzEaI-MgqdvMEklGrNsy22WqL6ZgOc	m.room.member	!pWsdJYvpdmDULVhQtX:localhost	\N	\N	t	f	2	1674111389486	1674111389520	@user1.matrix:localhost	f	master	63	@user1.matrix:localhost	\N
3	$ngKTLt0SDFtdjkF6GnjahEcDA-qLwTKRcVgMgMg5tN8	m.room.power_levels	!pWsdJYvpdmDULVhQtX:localhost	\N	\N	t	f	3	1674111389629	1674111389729	@user1.matrix:localhost	f	master	64		\N
4	$IxyNn3A4NegMug4xc7O0sm2s1r9jyybU5iNogwEGesQ	m.room.canonical_alias	!pWsdJYvpdmDULVhQtX:localhost	\N	\N	t	f	4	1674111390126	1674111390263	@user1.matrix:localhost	f	master	65		\N
5	$SQpUzgCCeFIrGC3eCPDX_U021w7MG0-lHOxFTcHbvKk	m.room.join_rules	!pWsdJYvpdmDULVhQtX:localhost	\N	\N	t	f	5	1674111390459	1674111390554	@user1.matrix:localhost	f	master	66		\N
6	$pe2Yi2ila5QgzVKIEGGAIeqvcRaD37GUFMvAOWX2tp0	m.room.history_visibility	!pWsdJYvpdmDULVhQtX:localhost	\N	\N	t	f	6	1674111390687	1674111390746	@user1.matrix:localhost	f	master	67		\N
7	$_MdWHbg9mI3zN-WDGIpwDRJZmDWXBeW-m3WrJiRs4t8	m.room.name	!pWsdJYvpdmDULVhQtX:localhost	\N	\N	t	f	7	1674111390825	1674111390873	@user1.matrix:localhost	f	master	68		\N
8	$7qFBn6lW7C0hRYBTRjR0tsE8qpZmodqh6LOyLL0HMnQ	m.room.topic	!pWsdJYvpdmDULVhQtX:localhost	\N	\N	t	f	8	1674111390984	1674111391032	@user1.matrix:localhost	f	master	69		\N
9	$d7sJ6Squy3gHlaCn4UxGeu_9AcN2XCBHtBIY8VL5d_g	m.room.member	!pWsdJYvpdmDULVhQtX:localhost	\N	\N	t	f	9	1674111412575	1674111412632	@user1.matrix:localhost	f	master	70	@mm_mattermost_a:localhost	\N
10	$xCubuHnQAGuDuGdlqiquXK0QRxhOWKTh5TJZZGcL09Q	m.room.message	!pWsdJYvpdmDULVhQtX:localhost	\N	\N	t	f	10	1674111446545	1674111446566	@user1.matrix:localhost	f	master	71	\N	\N
11	$8lVZQlOM-qXD0dT5ZSbvlEPAQPq5wJHU8KqM6sLfmWM	m.room.topic	!pWsdJYvpdmDULVhQtX:localhost	\N	\N	t	f	11	1674111530536	1674111530589	@user1.matrix:localhost	f	master	72		\N
12	$OsJU_fxidXD79b8VmXNcxdAdUkhXO3S73zUBYUa3yG8	m.room.topic	!pWsdJYvpdmDULVhQtX:localhost	\N	\N	t	f	12	1674111570171	1674111570212	@user1.matrix:localhost	f	master	73		\N
13	$JWIcDwBleupt991UzmNH_DSdEWQPePa6uEyU2J0-ldM	m.room.message	!pWsdJYvpdmDULVhQtX:localhost	\N	\N	t	f	13	1674111611368	1674111611388	@user1.matrix:localhost	f	master	74	\N	\N
10	$76OhaN_mof41kiqxA-qZV26DgKxkvkl8JwQjOYqZF1A	m.room.member	!BfSgfecvJnYoZjTYRA:localhost	\N	\N	t	f	10	1674111676978	1674111677017	@user1.matrix:localhost	f	master	75	@matrix_b:localhost	\N
23	$_B6Ln541gYqlnaEaxAcSwy46yBXDxkldNhRG8HdrPBs	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	23	1674210902667	1674210902743	@mm_user1.mm:localhost	t	master	78	\N	\N
25	$oakhKpEqFw5Icor6iY_TRMQljV-HWQ3lueP0Vlm9hIY	m.room.message	!dKcbdDATuwwphjRPQP:localhost	\N	\N	t	f	25	1674211225736	1674211225832	@user1.matrix:localhost	t	master	80	\N	\N
3	$nofByIO1FFs8JcKVqFZb7ulSmWdVGm_V-3n-LceVmnw	m.room.power_levels	!cUrTzQWGYNmZYMHoGB:localhost	\N	\N	t	f	3	1674211301513	1674211302035	@user1.matrix:localhost	f	master	83		\N
4	$wtg0qf-MdY5Ur4UMAlOlQ58df82OmKhsbTS81ItsAT8	m.room.canonical_alias	!cUrTzQWGYNmZYMHoGB:localhost	\N	\N	t	f	4	1674211301619	1674211302035	@user1.matrix:localhost	f	master	84		\N
5	$DFCNP6Tt2ypS8tXyd5kaCiqWeVDmE_FL-iOprkrfubk	m.room.join_rules	!cUrTzQWGYNmZYMHoGB:localhost	\N	\N	t	f	5	1674211301654	1674211302035	@user1.matrix:localhost	f	master	85		\N
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
events	119	master
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
!dKcbdDATuwwphjRPQP:localhost	@matterbot:localhost	$jyfZsVYOTCt8az1WqRlL53b1lAQWjIj6-IvW1w3qYks	join
!kmbTYjjsDRDHGgVqUP:localhost	@matterbot:localhost	$PkPxRt8GuXFqdWre9vyhqKHlRSqflC0cOSTBOims4qY	join
!kmbTYjjsDRDHGgVqUP:localhost	@mm_mattermost_a:localhost	$pXbc3VIu5b4O4VzPRePQd4FjtqYPJLH87Ss7pZM-gRM	join
!dKcbdDATuwwphjRPQP:localhost	@mm_mattermost_a:localhost	$YHxtZv4JfPzIJvBMvoTgzeITfTFFng_L_4ijJ1Q97k4	join
!kmbTYjjsDRDHGgVqUP:localhost	@mm_mattermost_b:localhost	$q7m8fkdDrp2QE9hRAHYIR_KN8htxYXW85pB3LgG-V2U	join
!dKcbdDATuwwphjRPQP:localhost	@mm_mattermost_b:localhost	$cH796vSd1hy4UBg8XHAqeUxz-u3gxer-uMeGrsirKbs	join
!kmbTYjjsDRDHGgVqUP:localhost	@user1.matrix:localhost	$5DYqRHQPE1SQt9QXHJodWH7x4Pztz3LTsgH1kdHawZs	join
!dKcbdDATuwwphjRPQP:localhost	@user1.matrix:localhost	$TKcINA6W5qTH8raDaFqEMBivZ0LjgXtIHGvxzJ9V4_8	join
!dKcbdDATuwwphjRPQP:localhost	@mm_user1.mm:localhost	$AwutniYNkYl6Dxs-8zYvdPdGLIcM4Kyzaldut5D0jHQ	join
!kmbTYjjsDRDHGgVqUP:localhost	@mm_user1.mm:localhost	$VFMUBSkD_jWG8nImBQfkmffKyLBdxGMpdkFACHA33Ng	join
!BfSgfecvJnYoZjTYRA:localhost	@user1.matrix:localhost	$7N18oPwd46twVh-RWhED6VAPm79aIXVCh_BVUFAFHP8	join
!BfSgfecvJnYoZjTYRA:localhost	@mm_mattermost_a:localhost	$PZkmtd-Zj4an2Acc9O8V-mK2mVxXChviZhd_hsf6Ehg	invite
!pWsdJYvpdmDULVhQtX:localhost	@user1.matrix:localhost	$bWqW6N4T6ZlJ3MzEaI-MgqdvMEklGrNsy22WqL6ZgOc	join
!pWsdJYvpdmDULVhQtX:localhost	@mm_mattermost_a:localhost	$d7sJ6Squy3gHlaCn4UxGeu_9AcN2XCBHtBIY8VL5d_g	invite
!BfSgfecvJnYoZjTYRA:localhost	@matrix_b:localhost	$76OhaN_mof41kiqxA-qZV26DgKxkvkl8JwQjOYqZF1A	invite
!cUrTzQWGYNmZYMHoGB:localhost	@user1.matrix:localhost	$Ip3uw4uae3e7xwaJ6BU2ppE2nWhA0Zyb0KZDNvHAdmU	join
!FSwSlJXpOZZONTVfGs:localhost	@user1.matrix:localhost	$Z-W9-QEq_roRPUfFFGrVn3vc_d4uekRlcsL3uBSdDpM	join
!hccoYOyrWRMEhMnaoh:localhost	@user1.matrix:localhost	$RRFtexNdS-wxfmZgcU9kk5Lyp462lIuVu6piimDKCGA	join
!JGJhGNDoMdRLJzLgcJ:localhost	@user1.matrix:localhost	$uDBLcAyAHq3swiKjGlyKYFZwIrP5Ux8Ki1qU7x3aVsY	join
\.


--
-- Data for Name: local_media_repository; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.local_media_repository (media_id, media_type, media_length, created_ts, upload_name, user_id, quarantined_by, url_cache, last_access_ts, safe_from_quarantine) FROM stdin;
nSowXfTlLcjdOPizBpiKUGFU	application/octet-stream	15996	1674210902576	code_style.md	@mm_user1.mm:localhost	\N	\N	1674210982510	f
teOHbMgqlofgCWrnDDylQCGp	image/heic	2178164	1674211098520	AB9719AB-315B-4EAB-AB5F-84EBA089EBB5.heic	@user1.matrix:localhost	\N	\N	1674211102512	f
ZblHPXvcnHoXXNZEbXxSxPxv	image/jpeg	468034	1674211223890	\N	@user1.matrix:localhost	\N	\N	\N	f
PNierwtrdSqHEqtbUpgkyfbT	image/jpeg	3068971	1674211224486	A1D99574-D44E-4526-BEBD-470362011CD5.jpeg	@user1.matrix:localhost	\N	\N	1674211282510	f
\.


--
-- Data for Name: local_media_repository_thumbnails; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.local_media_repository_thumbnails (media_id, thumbnail_width, thumbnail_height, thumbnail_type, thumbnail_method, thumbnail_length) FROM stdin;
ZblHPXvcnHoXXNZEbXxSxPxv	32	32	image/jpeg	crop	791
ZblHPXvcnHoXXNZEbXxSxPxv	96	96	image/jpeg	crop	1818
ZblHPXvcnHoXXNZEbXxSxPxv	320	240	image/jpeg	scale	10499
ZblHPXvcnHoXXNZEbXxSxPxv	640	480	image/jpeg	scale	44452
ZblHPXvcnHoXXNZEbXxSxPxv	800	600	image/jpeg	scale	75439
PNierwtrdSqHEqtbUpgkyfbT	32	32	image/jpeg	crop	791
PNierwtrdSqHEqtbUpgkyfbT	96	96	image/jpeg	crop	1824
PNierwtrdSqHEqtbUpgkyfbT	320	240	image/jpeg	scale	10298
PNierwtrdSqHEqtbUpgkyfbT	640	480	image/jpeg	scale	44366
PNierwtrdSqHEqtbUpgkyfbT	800	600	image/jpeg	scale	72699
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
121	@matrix_b:localhost	offline	1673974556861	1673974499098	0	\N	f	master
833	@mm_user1.mm:localhost	offline	1674210902911	1674210902330	0	\N	f	master
845	@user1.matrix:localhost	online	1674211580407	1674210822463	1674211580408	\N	t	master
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
user1.matrix	User 1 - Matrix	\N
mm_mattermost_b	mattermost_b [mm]	\N
mm_user1.mm	user1.mm [mm]	\N
mm_mattermost_a	MattermostUser A [mm]	\N
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
!kmbTYjjsDRDHGgVqUP:localhost	m.read	@user1.matrix:localhost	["$Ss566NPFclWN6Mx7hHv8fd_JaawsG1AuM6gnlM7fA-k"]	{"ts":1674028773659,"hidden":false}	\N
!dKcbdDATuwwphjRPQP:localhost	m.read.private	@user1.matrix:localhost	["$_B6Ln541gYqlnaEaxAcSwy46yBXDxkldNhRG8HdrPBs"]	{"ts":1674210917603}	\N
!dKcbdDATuwwphjRPQP:localhost	m.read	@user1.matrix:localhost	["$_B6Ln541gYqlnaEaxAcSwy46yBXDxkldNhRG8HdrPBs"]	{"ts":1674210917706}	\N
\.


--
-- Data for Name: receipts_linearized; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.receipts_linearized (stream_id, room_id, receipt_type, user_id, event_id, data, instance_name, event_stream_ordering, thread_id) FROM stdin;
3	!kmbTYjjsDRDHGgVqUP:localhost	m.read	@user1.matrix:localhost	$Ss566NPFclWN6Mx7hHv8fd_JaawsG1AuM6gnlM7fA-k	{"ts":1674028773659,"hidden":false}	\N	49	\N
4	!dKcbdDATuwwphjRPQP:localhost	m.read.private	@user1.matrix:localhost	$_B6Ln541gYqlnaEaxAcSwy46yBXDxkldNhRG8HdrPBs	{"ts":1674210917603}	\N	78	\N
5	!dKcbdDATuwwphjRPQP:localhost	m.read	@user1.matrix:localhost	$_B6Ln541gYqlnaEaxAcSwy46yBXDxkldNhRG8HdrPBs	{"ts":1674210917706}	\N	78	\N
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
@user1.matrix:localhost	!pWsdJYvpdmDULVhQtX:localhost	m.fully_read	46	{"event_id":"$JWIcDwBleupt991UzmNH_DSdEWQPePa6uEyU2J0-ldM"}	\N
@user1.matrix:localhost	!BfSgfecvJnYoZjTYRA:localhost	m.fully_read	48	{"event_id":"$76OhaN_mof41kiqxA-qZV26DgKxkvkl8JwQjOYqZF1A"}	\N
@user1.matrix:localhost	!dKcbdDATuwwphjRPQP:localhost	m.fully_read	56	{"event_id":"$oakhKpEqFw5Icor6iY_TRMQljV-HWQ3lueP0Vlm9hIY"}	\N
@user1.matrix:localhost	!hccoYOyrWRMEhMnaoh:localhost	m.fully_read	63	{"event_id":"$FJVN_jtSz6ZNRLKTCrfOqY0M69xPDbu_hr4GTuB_3u8"}	\N
@user1.matrix:localhost	!kmbTYjjsDRDHGgVqUP:localhost	m.fully_read	67	{"event_id":"$PfXwdx6I54mC3f0Zd8nOukV5nTCxL7uRQKGn3Bxg17Y"}	\N
\.


--
-- Data for Name: room_alias_servers; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_alias_servers (room_alias, server) FROM stdin;
#town-square:localhost	localhost
#off-topic:localhost	localhost
#my.dining:localhost	localhost
#sports:localhost	localhost
#my-first-space:localhost	localhost
\.


--
-- Data for Name: room_aliases; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_aliases (room_alias, room_id, creator) FROM stdin;
#town-square:localhost	!kmbTYjjsDRDHGgVqUP:localhost	@admin:localhost
#off-topic:localhost	!dKcbdDATuwwphjRPQP:localhost	@admin:localhost
#my.dining:localhost	!BfSgfecvJnYoZjTYRA:localhost	@user1.matrix:localhost
#sports:localhost	!pWsdJYvpdmDULVhQtX:localhost	@user1.matrix:localhost
#my-first-space:localhost	!cUrTzQWGYNmZYMHoGB:localhost	@user1.matrix:localhost
\.


--
-- Data for Name: room_depth; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_depth (room_id, min_depth) FROM stdin;
!kmbTYjjsDRDHGgVqUP:localhost	1
!dKcbdDATuwwphjRPQP:localhost	1
!BfSgfecvJnYoZjTYRA:localhost	1
!pWsdJYvpdmDULVhQtX:localhost	1
!cUrTzQWGYNmZYMHoGB:localhost	1
!FSwSlJXpOZZONTVfGs:localhost	1
!hccoYOyrWRMEhMnaoh:localhost	1
!JGJhGNDoMdRLJzLgcJ:localhost	1
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
$jyfZsVYOTCt8az1WqRlL53b1lAQWjIj6-IvW1w3qYks	@matterbot:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	Mattermost Bridge	\N
$PkPxRt8GuXFqdWre9vyhqKHlRSqflC0cOSTBOims4qY	@matterbot:localhost	@matterbot:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	Mattermost Bridge	\N
$ARxMI5-TIkg2afPIDJsLgeSqCdrfbwBxm32e83QRfQ4	@mm_mattermost_a:localhost	@matterbot:localhost	!kmbTYjjsDRDHGgVqUP:localhost	invite	0	MattermostUser A [mm]	\N
$nE3KmrZJdWnhQ2h6DgIB98qoLGnQlFFCvgSu4NS5FfA	@mm_mattermost_a:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	invite	0	MattermostUser A [mm]	\N
$mlRlSJ1S_x5OctD_Nck7tq-Fo2IC7iOhysac1uYo_PY	@mm_mattermost_b:localhost	@matterbot:localhost	!kmbTYjjsDRDHGgVqUP:localhost	invite	0	mattermost_b [mm]	\N
$pXbc3VIu5b4O4VzPRePQd4FjtqYPJLH87Ss7pZM-gRM	@mm_mattermost_a:localhost	@mm_mattermost_a:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	MattermostUser A [mm]	\N
$Y86Vdmx2z1nvkEoTqBH7oAiLE_sHPFtNgI97gsUAwaY	@mm_mattermost_b:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	invite	0	mattermost_b [mm]	\N
$YHxtZv4JfPzIJvBMvoTgzeITfTFFng_L_4ijJ1Q97k4	@mm_mattermost_a:localhost	@mm_mattermost_a:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	MattermostUser A [mm]	\N
$q7m8fkdDrp2QE9hRAHYIR_KN8htxYXW85pB3LgG-V2U	@mm_mattermost_b:localhost	@mm_mattermost_b:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	mattermost_b [mm]	\N
$cH796vSd1hy4UBg8XHAqeUxz-u3gxer-uMeGrsirKbs	@mm_mattermost_b:localhost	@mm_mattermost_b:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	mattermost_b [mm]	\N
$5DYqRHQPE1SQt9QXHJodWH7x4Pztz3LTsgH1kdHawZs	@user1.matrix:localhost	@user1.matrix:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	User 1 - Matrix	\N
$TKcINA6W5qTH8raDaFqEMBivZ0LjgXtIHGvxzJ9V4_8	@user1.matrix:localhost	@user1.matrix:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	User 1 - Matrix	\N
$REN0AaEE212pFbK8uJB-22lyjpnqTEP0SshUeVfsGU4	@mm_user1.mm:localhost	@matterbot:localhost	!dKcbdDATuwwphjRPQP:localhost	invite	0	user1.mm [mm]	\N
$AwutniYNkYl6Dxs-8zYvdPdGLIcM4Kyzaldut5D0jHQ	@mm_user1.mm:localhost	@mm_user1.mm:localhost	!dKcbdDATuwwphjRPQP:localhost	join	0	user1.mm [mm]	\N
$HmGCTcPZGDbaswAPjYZ0ddKt1eWRcRq89rE-yVwDV0s	@mm_user1.mm:localhost	@matterbot:localhost	!kmbTYjjsDRDHGgVqUP:localhost	invite	0	user1.mm [mm]	\N
$VFMUBSkD_jWG8nImBQfkmffKyLBdxGMpdkFACHA33Ng	@mm_user1.mm:localhost	@mm_user1.mm:localhost	!kmbTYjjsDRDHGgVqUP:localhost	join	0	user1.mm [mm]	\N
$7N18oPwd46twVh-RWhED6VAPm79aIXVCh_BVUFAFHP8	@user1.matrix:localhost	@user1.matrix:localhost	!BfSgfecvJnYoZjTYRA:localhost	join	0	User 1 - Matrix	\N
$PZkmtd-Zj4an2Acc9O8V-mK2mVxXChviZhd_hsf6Ehg	@mm_mattermost_a:localhost	@user1.matrix:localhost	!BfSgfecvJnYoZjTYRA:localhost	invite	0	MattermostUser A [mm]	\N
$bWqW6N4T6ZlJ3MzEaI-MgqdvMEklGrNsy22WqL6ZgOc	@user1.matrix:localhost	@user1.matrix:localhost	!pWsdJYvpdmDULVhQtX:localhost	join	0	User 1 - Matrix	\N
$d7sJ6Squy3gHlaCn4UxGeu_9AcN2XCBHtBIY8VL5d_g	@mm_mattermost_a:localhost	@user1.matrix:localhost	!pWsdJYvpdmDULVhQtX:localhost	invite	0	MattermostUser A [mm]	\N
$76OhaN_mof41kiqxA-qZV26DgKxkvkl8JwQjOYqZF1A	@matrix_b:localhost	@user1.matrix:localhost	!BfSgfecvJnYoZjTYRA:localhost	invite	0	matrix_b	\N
$Ip3uw4uae3e7xwaJ6BU2ppE2nWhA0Zyb0KZDNvHAdmU	@user1.matrix:localhost	@user1.matrix:localhost	!cUrTzQWGYNmZYMHoGB:localhost	join	0	User 1 - Matrix	\N
$Z-W9-QEq_roRPUfFFGrVn3vc_d4uekRlcsL3uBSdDpM	@user1.matrix:localhost	@user1.matrix:localhost	!FSwSlJXpOZZONTVfGs:localhost	join	0	User 1 - Matrix	\N
$RRFtexNdS-wxfmZgcU9kk5Lyp462lIuVu6piimDKCGA	@user1.matrix:localhost	@user1.matrix:localhost	!hccoYOyrWRMEhMnaoh:localhost	join	0	User 1 - Matrix	\N
$uDBLcAyAHq3swiKjGlyKYFZwIrP5Ux8Ki1qU7x3aVsY	@user1.matrix:localhost	@user1.matrix:localhost	!JGJhGNDoMdRLJzLgcJ:localhost	join	0	User 1 - Matrix	\N
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
!dKcbdDATuwwphjRPQP:localhost	14	9	0	0	0	9	33	0
!kmbTYjjsDRDHGgVqUP:localhost	14	9	0	0	0	9	35	0
!pWsdJYvpdmDULVhQtX:localhost	9	1	1	0	0	1	73	0
!BfSgfecvJnYoZjTYRA:localhost	9	1	2	0	0	1	75	0
!JGJhGNDoMdRLJzLgcJ:localhost	8	1	0	0	0	1	111	0
!hccoYOyrWRMEhMnaoh:localhost	8	1	0	0	0	1	113	0
!FSwSlJXpOZZONTVfGs:localhost	8	1	0	0	0	1	113	0
!cUrTzQWGYNmZYMHoGB:localhost	12	1	0	0	0	1	116	0
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
!dKcbdDATuwwphjRPQP:localhost	\N	#off-topic:localhost	public	shared	\N	\N	\N	t	\N	\N
!kmbTYjjsDRDHGgVqUP:localhost	\N	#town-square:localhost	public	shared	\N	\N	\N	t	\N	\N
!BfSgfecvJnYoZjTYRA:localhost	My Dining	#my.dining:localhost	public	shared	\N	\N	\N	t	\N	\N
!pWsdJYvpdmDULVhQtX:localhost	Sports	#sports:localhost	public	shared	\N	\N	\N	t	Handball	\N
!cUrTzQWGYNmZYMHoGB:localhost	My-First-Space	#my-first-space:localhost	public	world_readable	\N	\N	can_join	t		m.space
!JGJhGNDoMdRLJzLgcJ:localhost	#Space-room-3	\N	public	world_readable	\N	\N	can_join	t	\N	\N
!hccoYOyrWRMEhMnaoh:localhost	#Space-room-1	\N	public	world_readable	\N	\N	can_join	t	\N	\N
!FSwSlJXpOZZONTVfGs:localhost	#Space-room-2	\N	public	world_readable	\N	\N	can_join	t	\N	\N
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
!BfSgfecvJnYoZjTYRA:localhost	t	@user1.matrix:localhost	6	t
!pWsdJYvpdmDULVhQtX:localhost	t	@user1.matrix:localhost	6	t
!cUrTzQWGYNmZYMHoGB:localhost	t	@user1.matrix:localhost	9	t
!hccoYOyrWRMEhMnaoh:localhost	f	@user1.matrix:localhost	9	t
!FSwSlJXpOZZONTVfGs:localhost	f	@user1.matrix:localhost	9	t
!JGJhGNDoMdRLJzLgcJ:localhost	f	@user1.matrix:localhost	9	t
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
$PkPxRt8GuXFqdWre9vyhqKHlRSqflC0cOSTBOims4qY	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	\N
$jyfZsVYOTCt8az1WqRlL53b1lAQWjIj6-IvW1w3qYks	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	\N
$ARxMI5-TIkg2afPIDJsLgeSqCdrfbwBxm32e83QRfQ4	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$nE3KmrZJdWnhQ2h6DgIB98qoLGnQlFFCvgSu4NS5FfA	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$mlRlSJ1S_x5OctD_Nck7tq-Fo2IC7iOhysac1uYo_PY	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$Y86Vdmx2z1nvkEoTqBH7oAiLE_sHPFtNgI97gsUAwaY	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$pXbc3VIu5b4O4VzPRePQd4FjtqYPJLH87Ss7pZM-gRM	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$q7m8fkdDrp2QE9hRAHYIR_KN8htxYXW85pB3LgG-V2U	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$YHxtZv4JfPzIJvBMvoTgzeITfTFFng_L_4ijJ1Q97k4	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$cH796vSd1hy4UBg8XHAqeUxz-u3gxer-uMeGrsirKbs	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	\N
$5DYqRHQPE1SQt9QXHJodWH7x4Pztz3LTsgH1kdHawZs	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@user1.matrix:localhost	\N
$TKcINA6W5qTH8raDaFqEMBivZ0LjgXtIHGvxzJ9V4_8	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@user1.matrix:localhost	\N
$REN0AaEE212pFbK8uJB-22lyjpnqTEP0SshUeVfsGU4	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1.mm:localhost	\N
$AwutniYNkYl6Dxs-8zYvdPdGLIcM4Kyzaldut5D0jHQ	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1.mm:localhost	\N
$HmGCTcPZGDbaswAPjYZ0ddKt1eWRcRq89rE-yVwDV0s	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1.mm:localhost	\N
$VFMUBSkD_jWG8nImBQfkmffKyLBdxGMpdkFACHA33Ng	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1.mm:localhost	\N
$NfGFxRqIrSmaeLcN53BGirnWzJ1bpwzVyt2oZw2cj1k	!BfSgfecvJnYoZjTYRA:localhost	m.room.create		\N
$7N18oPwd46twVh-RWhED6VAPm79aIXVCh_BVUFAFHP8	!BfSgfecvJnYoZjTYRA:localhost	m.room.member	@user1.matrix:localhost	\N
$eKvf8PFaZwsEOXW-IIYTGZwl6gxEYmEE2TalB5k2iGs	!BfSgfecvJnYoZjTYRA:localhost	m.room.power_levels		\N
$ZraIWv18CC1pTAGQZToI1ZXr7ki_53OY_jvQl0RDE_A	!BfSgfecvJnYoZjTYRA:localhost	m.room.canonical_alias		\N
$Uf6bLI9lxBnR9TJvz8fcfo-1_wbshzMvT4Ecr_qy-E4	!BfSgfecvJnYoZjTYRA:localhost	m.room.join_rules		\N
$30q15kBxfYB9Dyc1sAhoNXYpZXfDlneq4Ckvuz_Sy1Y	!BfSgfecvJnYoZjTYRA:localhost	m.room.history_visibility		\N
$wlATKVSoZpEXfwFpmdptZK6V2TMFQ87Bjjhru1P3dGs	!BfSgfecvJnYoZjTYRA:localhost	m.room.name		\N
$PZkmtd-Zj4an2Acc9O8V-mK2mVxXChviZhd_hsf6Ehg	!BfSgfecvJnYoZjTYRA:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$pIVIlPgvO-fbiW31dx4GB-wsRX4DrbADDn1AfJoXI50	!pWsdJYvpdmDULVhQtX:localhost	m.room.create		\N
$bWqW6N4T6ZlJ3MzEaI-MgqdvMEklGrNsy22WqL6ZgOc	!pWsdJYvpdmDULVhQtX:localhost	m.room.member	@user1.matrix:localhost	\N
$ngKTLt0SDFtdjkF6GnjahEcDA-qLwTKRcVgMgMg5tN8	!pWsdJYvpdmDULVhQtX:localhost	m.room.power_levels		\N
$IxyNn3A4NegMug4xc7O0sm2s1r9jyybU5iNogwEGesQ	!pWsdJYvpdmDULVhQtX:localhost	m.room.canonical_alias		\N
$SQpUzgCCeFIrGC3eCPDX_U021w7MG0-lHOxFTcHbvKk	!pWsdJYvpdmDULVhQtX:localhost	m.room.join_rules		\N
$pe2Yi2ila5QgzVKIEGGAIeqvcRaD37GUFMvAOWX2tp0	!pWsdJYvpdmDULVhQtX:localhost	m.room.history_visibility		\N
$_MdWHbg9mI3zN-WDGIpwDRJZmDWXBeW-m3WrJiRs4t8	!pWsdJYvpdmDULVhQtX:localhost	m.room.name		\N
$7qFBn6lW7C0hRYBTRjR0tsE8qpZmodqh6LOyLL0HMnQ	!pWsdJYvpdmDULVhQtX:localhost	m.room.topic		\N
$d7sJ6Squy3gHlaCn4UxGeu_9AcN2XCBHtBIY8VL5d_g	!pWsdJYvpdmDULVhQtX:localhost	m.room.member	@mm_mattermost_a:localhost	\N
$8lVZQlOM-qXD0dT5ZSbvlEPAQPq5wJHU8KqM6sLfmWM	!pWsdJYvpdmDULVhQtX:localhost	m.room.topic		\N
$OsJU_fxidXD79b8VmXNcxdAdUkhXO3S73zUBYUa3yG8	!pWsdJYvpdmDULVhQtX:localhost	m.room.topic		\N
$76OhaN_mof41kiqxA-qZV26DgKxkvkl8JwQjOYqZF1A	!BfSgfecvJnYoZjTYRA:localhost	m.room.member	@matrix_b:localhost	\N
$XhE1A2QtMIi_b9SfK9jbadCTQ4Xd5IZxBaUOcfglbIA	!cUrTzQWGYNmZYMHoGB:localhost	m.room.create		\N
$Ip3uw4uae3e7xwaJ6BU2ppE2nWhA0Zyb0KZDNvHAdmU	!cUrTzQWGYNmZYMHoGB:localhost	m.room.member	@user1.matrix:localhost	\N
$nofByIO1FFs8JcKVqFZb7ulSmWdVGm_V-3n-LceVmnw	!cUrTzQWGYNmZYMHoGB:localhost	m.room.power_levels		\N
$wtg0qf-MdY5Ur4UMAlOlQ58df82OmKhsbTS81ItsAT8	!cUrTzQWGYNmZYMHoGB:localhost	m.room.canonical_alias		\N
$DFCNP6Tt2ypS8tXyd5kaCiqWeVDmE_FL-iOprkrfubk	!cUrTzQWGYNmZYMHoGB:localhost	m.room.join_rules		\N
$MJ2YTkP3f-eQwc5HLB6GVzjnPJaVov0pUCfq1bWqG3M	!cUrTzQWGYNmZYMHoGB:localhost	m.room.guest_access		\N
$iAAlBelGypnsbVKn9Fd-ubLNje326TRpaegoLLyRZGY	!cUrTzQWGYNmZYMHoGB:localhost	m.room.history_visibility		\N
$34bSEXw9U2DTNkZA2he27rczptl3jni1oG64GRRYkfY	!cUrTzQWGYNmZYMHoGB:localhost	m.room.name		\N
$SFXqj2UcfZU2XtnGBtupMwsoI3Z5JLp-7mmR2PU4MjQ	!cUrTzQWGYNmZYMHoGB:localhost	m.room.topic		\N
$VI4y-gfFPbzFuAM6S6F4gXfpeWta-thThcGlPN0xQN0	!FSwSlJXpOZZONTVfGs:localhost	m.room.create		\N
$LnGTvN89zWMaGdr_8T22TNwZ8hCnAeMlGOMaGpCPahE	!hccoYOyrWRMEhMnaoh:localhost	m.room.create		\N
$A45QtHYoTPEA17jEFQZ4U882WGuYFA2D4xiKqwnZyUs	!JGJhGNDoMdRLJzLgcJ:localhost	m.room.create		\N
$Z-W9-QEq_roRPUfFFGrVn3vc_d4uekRlcsL3uBSdDpM	!FSwSlJXpOZZONTVfGs:localhost	m.room.member	@user1.matrix:localhost	\N
$uDBLcAyAHq3swiKjGlyKYFZwIrP5Ux8Ki1qU7x3aVsY	!JGJhGNDoMdRLJzLgcJ:localhost	m.room.member	@user1.matrix:localhost	\N
$RRFtexNdS-wxfmZgcU9kk5Lyp462lIuVu6piimDKCGA	!hccoYOyrWRMEhMnaoh:localhost	m.room.member	@user1.matrix:localhost	\N
$MLY05F5LyQaOuJw4avembMABTu_CtFuQyhyiF14QtYo	!JGJhGNDoMdRLJzLgcJ:localhost	m.room.power_levels		\N
$e6pVgV1MsH-6_A1V_vGWGmdznPg_czNOfblinyTHshA	!JGJhGNDoMdRLJzLgcJ:localhost	m.room.join_rules		\N
$hNUZNFVPWjQzoWmc5wymfJzaTuaIdxyWFsi3fkTJ534	!JGJhGNDoMdRLJzLgcJ:localhost	m.room.guest_access		\N
$IYkBkm-ncU_4Z-Ft8v80LsrK5kKpzGKpHDUWZxxy6t8	!JGJhGNDoMdRLJzLgcJ:localhost	m.space.parent	!cUrTzQWGYNmZYMHoGB:localhost	\N
$JfR9TVM-sEe4hZ5-0bIni5e5m_tLlX2HdSU6u6IoVBM	!JGJhGNDoMdRLJzLgcJ:localhost	m.room.history_visibility		\N
$4ywygf1-17_Kq3j230bjqgAjdpc67zV0hIv7Uw6BKtA	!FSwSlJXpOZZONTVfGs:localhost	m.room.power_levels		\N
$CjB4vCnMjTm70a0EahGjB5FN8EKtrdWl7F12gA2FhDo	!FSwSlJXpOZZONTVfGs:localhost	m.room.join_rules		\N
$Y_182-w64pn902ATtlukjIsNSzVBtF9fw_aMYWx9DdY	!FSwSlJXpOZZONTVfGs:localhost	m.room.guest_access		\N
$27FTfsExd-igZozi1nKpy5Iyqayuxc3DZY9LFN9e6oo	!FSwSlJXpOZZONTVfGs:localhost	m.space.parent	!cUrTzQWGYNmZYMHoGB:localhost	\N
$33Pk__-gU3AslKMgHWQqdrgfvEhGtn4nPTRaDuhZUC0	!FSwSlJXpOZZONTVfGs:localhost	m.room.history_visibility		\N
$nMtE3MPK3rxeHXzgEF1GWQXqF1Of8IqoWwPKejXxdrg	!hccoYOyrWRMEhMnaoh:localhost	m.room.power_levels		\N
$4MpBsW-eFJ4SoVP-rLgkefjkNR0Sytuayop2Z-OBFzU	!hccoYOyrWRMEhMnaoh:localhost	m.room.join_rules		\N
$5QgMOlhzvtIooZVNYnMnchsgiEUDObBacU41JO2zKs0	!hccoYOyrWRMEhMnaoh:localhost	m.room.guest_access		\N
$NYaJba-K1Im8n6_Z7mL0VwgIAKxZqouzTTYu6EcK5eM	!hccoYOyrWRMEhMnaoh:localhost	m.space.parent	!cUrTzQWGYNmZYMHoGB:localhost	\N
$-FXdMAkllHkSbPP-QDGsb_zIuCwPKR511zZahmMGKs4	!hccoYOyrWRMEhMnaoh:localhost	m.room.history_visibility		\N
$UEYdHpguNtwCDIQ9fsK7537cGDuKB-9QPh7SJsYm6lQ	!JGJhGNDoMdRLJzLgcJ:localhost	m.room.name		\N
$sUchhgur-fFKVUmMUaBERmjM3ItMz4-8bhkuD7UXnuU	!hccoYOyrWRMEhMnaoh:localhost	m.room.name		\N
$bgbjmgXAlLz069pieqVTP8KTcxXHvT72ZwdRr71Fnqg	!FSwSlJXpOZZONTVfGs:localhost	m.room.name		\N
$___RsdFndwWsVVLqEZmb4-TWJG-e1GJLt_3bnf1dFu8	!cUrTzQWGYNmZYMHoGB:localhost	m.space.child	!hccoYOyrWRMEhMnaoh:localhost	\N
$OUsS0radBRPS3B8beUIJ1TUjFMPXJ0OTtSau2wSu6rY	!cUrTzQWGYNmZYMHoGB:localhost	m.space.child	!FSwSlJXpOZZONTVfGs:localhost	\N
$z3x2QWsqd2WeWbha161nzCLfGv7psz2SV_Gveo8B5Yk	!cUrTzQWGYNmZYMHoGB:localhost	m.space.child	!JGJhGNDoMdRLJzLgcJ:localhost	\N
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
23	21
24	22
25	22
26	21
27	21
28	22
29	27
30	28
31	29
32	31
33	30
34	33
35	32
36	35
37	35
38	34
39	38
40	35
41	38
42	35
43	38
44	38
45	38
46	45
47	35
48	45
49	35
50	48
51	48
52	48
53	49
54	48
55	53
56	53
57	53
58	53
59	53
60	53
61	48
62	53
63	48
64	53
65	48
66	48
67	53
68	48
69	48
70	53
71	48
72	53
74	48
73	53
75	48
76	53
77	48
78	48
79	48
80	53
81	48
82	53
83	53
84	53
85	53
86	53
88	53
87	48
89	53
90	48
91	53
92	53
93	53
94	48
95	53
96	53
98	53
97	48
99	48
100	53
101	53
102	48
103	53
104	48
105	48
106	48
107	48
108	48
109	53
110	48
111	53
112	48
113	48
114	53
115	53
116	48
117	48
118	53
119	48
120	48
121	48
122	53
123	48
124	53
125	48
126	48
127	53
128	48
129	53
130	48
131	53
132	48
133	53
134	53
135	48
136	53
137	53
138	53
139	53
140	48
141	48
142	53
143	53
144	53
145	48
146	48
147	53
148	53
149	53
150	48
151	48
152	53
153	48
154	53
155	48
156	53
157	48
158	53
159	53
160	48
161	53
162	48
163	48
164	48
166	165
167	166
168	167
169	168
170	169
171	170
172	171
173	172
174	53
175	48
176	48
177	53
178	48
179	48
180	53
181	48
182	53
183	48
184	53
185	48
186	53
187	48
188	48
189	53
193	53
190	48
191	48
196	53
192	48
194	53
199	53
195	48
197	53
198	53
201	200
202	201
203	202
204	203
205	204
206	205
207	206
208	207
209	208
210	209
211	210
212	173
213	48
214	53
215	48
216	53
217	53
218	48
219	53
220	53
221	53
222	48
223	53
224	53
225	53
226	53
227	48
228	48
229	53
230	48
231	53
232	48
233	53
234	48
235	48
236	48
237	48
238	48
239	48
240	53
241	53
242	48
243	53
244	53
245	53
246	48
247	53
248	53
249	53
250	48
251	48
252	53
253	48
254	53
255	48
256	53
257	48
258	48
259	53
260	48
261	53
262	48
263	48
264	48
266	265
267	266
268	267
269	268
270	269
271	270
272	271
273	272
274	273
278	275
279	276
280	277
281	278
282	279
283	280
284	281
285	284
286	283
287	282
288	286
289	285
290	288
291	287
292	289
293	291
294	290
295	292
296	293
297	294
298	296
299	297
301	298
300	295
302	274
304	274
303	274
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
21	!kmbTYjjsDRDHGgVqUP:localhost	$PkPxRt8GuXFqdWre9vyhqKHlRSqflC0cOSTBOims4qY
22	!dKcbdDATuwwphjRPQP:localhost	$jyfZsVYOTCt8az1WqRlL53b1lAQWjIj6-IvW1w3qYks
23	!kmbTYjjsDRDHGgVqUP:localhost	$EHQc-AjnBRaCFge0Ybiy5GhzOQPj26ezNlKeB-vvBek
24	!dKcbdDATuwwphjRPQP:localhost	$1LSD-P0UB_ZapjOWFg_2yQeicQg-RBDE3WrLK3o66bE
25	!dKcbdDATuwwphjRPQP:localhost	$9gvR9727ZRJUenaZH_I8ljPJrjgHIP6BZti7plfxu-Q
26	!kmbTYjjsDRDHGgVqUP:localhost	$SVIgv7CvxVPYnn0I8RzwxO_oYgOj99qU-ZxPmI-8DkE
27	!kmbTYjjsDRDHGgVqUP:localhost	$ARxMI5-TIkg2afPIDJsLgeSqCdrfbwBxm32e83QRfQ4
28	!dKcbdDATuwwphjRPQP:localhost	$nE3KmrZJdWnhQ2h6DgIB98qoLGnQlFFCvgSu4NS5FfA
29	!kmbTYjjsDRDHGgVqUP:localhost	$mlRlSJ1S_x5OctD_Nck7tq-Fo2IC7iOhysac1uYo_PY
30	!dKcbdDATuwwphjRPQP:localhost	$Y86Vdmx2z1nvkEoTqBH7oAiLE_sHPFtNgI97gsUAwaY
31	!kmbTYjjsDRDHGgVqUP:localhost	$pXbc3VIu5b4O4VzPRePQd4FjtqYPJLH87Ss7pZM-gRM
32	!kmbTYjjsDRDHGgVqUP:localhost	$q7m8fkdDrp2QE9hRAHYIR_KN8htxYXW85pB3LgG-V2U
33	!dKcbdDATuwwphjRPQP:localhost	$YHxtZv4JfPzIJvBMvoTgzeITfTFFng_L_4ijJ1Q97k4
34	!dKcbdDATuwwphjRPQP:localhost	$cH796vSd1hy4UBg8XHAqeUxz-u3gxer-uMeGrsirKbs
35	!kmbTYjjsDRDHGgVqUP:localhost	$5DYqRHQPE1SQt9QXHJodWH7x4Pztz3LTsgH1kdHawZs
36	!kmbTYjjsDRDHGgVqUP:localhost	$KtrybuPgyyw6muL8i2Hl4vpLifcWbnX5XvNtNyC15Bo
37	!kmbTYjjsDRDHGgVqUP:localhost	$cfT7uAtZtdZq5Q82AKsYh-bmJa8FLwzvB4zzHL5if_I
38	!dKcbdDATuwwphjRPQP:localhost	$TKcINA6W5qTH8raDaFqEMBivZ0LjgXtIHGvxzJ9V4_8
39	!dKcbdDATuwwphjRPQP:localhost	$wFrKzC-hGRFxMOMZrj5SGx2LKE0DLWIFMoXPPIOOlnE
40	!kmbTYjjsDRDHGgVqUP:localhost	$1T2YzEtdalFehZH4MzsybssSyCAFv4eSMuVjgpRSc2w
41	!dKcbdDATuwwphjRPQP:localhost	$Lrbom-_cuG7livg7a_k303DHFENjEMB-aOF7G-UkCfY
42	!kmbTYjjsDRDHGgVqUP:localhost	$mLnnua7L043wxKOPA3FAiNS9FtdjNYKDPOa9knxxErg
43	!dKcbdDATuwwphjRPQP:localhost	$IF4Cesm5Vy_Lz8zNght6Qqcj9ny2oMojSrMwZLhcp7g
44	!dKcbdDATuwwphjRPQP:localhost	$xJzQLQ2nofKRx0ghZNc2VS_zQRcBWrAOyVw9-SUQ2OA
45	!dKcbdDATuwwphjRPQP:localhost	$REN0AaEE212pFbK8uJB-22lyjpnqTEP0SshUeVfsGU4
46	!dKcbdDATuwwphjRPQP:localhost	$fZOewHIi92ULtD5oSzBZFXcXAOSEfIvWlZ4v3oJFW_c
47	!kmbTYjjsDRDHGgVqUP:localhost	$I8L7afrGiF7xzrB9dIa2JPiugLMIW9iV7ejZK_suyCs
48	!dKcbdDATuwwphjRPQP:localhost	$AwutniYNkYl6Dxs-8zYvdPdGLIcM4Kyzaldut5D0jHQ
49	!kmbTYjjsDRDHGgVqUP:localhost	$HmGCTcPZGDbaswAPjYZ0ddKt1eWRcRq89rE-yVwDV0s
50	!dKcbdDATuwwphjRPQP:localhost	$RfRzotv0yQEkNKnxdYYLjBQzuOWvVgMzkFHZI6Q97Bc
51	!dKcbdDATuwwphjRPQP:localhost	$yFMSvO4LPDDbsUVZSBHOz2TIj4IoqyHmD-LXNJFLxr8
52	!dKcbdDATuwwphjRPQP:localhost	$fdjyZsX0XtM5CSJWWIGdDbRHQvA31bzfESl1FG2RU-o
53	!kmbTYjjsDRDHGgVqUP:localhost	$VFMUBSkD_jWG8nImBQfkmffKyLBdxGMpdkFACHA33Ng
54	!dKcbdDATuwwphjRPQP:localhost	$YR6YDcG6TPYJ1sqmQvtpHn-qmjyGMW4XZC8uy7K_KoU
55	!kmbTYjjsDRDHGgVqUP:localhost	$CPAgh0hEGMzPF7nxQexWfime80yU6FkkHaNeT7SOAcM
56	!kmbTYjjsDRDHGgVqUP:localhost	$nbGh4DWni0ByialUtu_rJQ4Vc_4KT54dKYbOKRIplcM
57	!kmbTYjjsDRDHGgVqUP:localhost	$bbzTnDc4eq9oSD6mvkNNNPAeyhUjgzDRd3mSZ-owm24
58	!kmbTYjjsDRDHGgVqUP:localhost	$fMsRH9wJtZgjWrBibauCxx5tB3hM39Lvmz2lTHU818w
59	!kmbTYjjsDRDHGgVqUP:localhost	$QOkvrv86Q1H8n8zPlPF6uifkSRfaxCA3DVkhaMp0iB0
60	!kmbTYjjsDRDHGgVqUP:localhost	$6iJ2Dg84GzDRV_KN47XJhTwi5UcAtwbX1RHvxTW3N3c
61	!dKcbdDATuwwphjRPQP:localhost	$li1nwJzGsjSFXMXHzDwEYmlskv1TDW9FfNXG1Z1bHjU
62	!kmbTYjjsDRDHGgVqUP:localhost	$jMpD-jssCheykPotavL2HZmY8WinxMsUX6KImEoeZWg
63	!dKcbdDATuwwphjRPQP:localhost	$Vfin0LlYAVyy-JXN6OjclHc91JlpEC4O6811oUJ8cFs
64	!kmbTYjjsDRDHGgVqUP:localhost	$6qWNgg5Oi6bZGkD-6WNlInKOhzPe6JS7QoXJ_wusFuM
65	!dKcbdDATuwwphjRPQP:localhost	$CJaAk6uAQb5btIORfT4VwddnSaCJLAXKKd9boqYZ84k
66	!dKcbdDATuwwphjRPQP:localhost	$TWHi4vz3Yd05QOu7aTCoXAcSxVii7W7Ug0yZMYq0SDc
67	!kmbTYjjsDRDHGgVqUP:localhost	$_q4Khcfij2a-CKTkRyTZjfUvnAFHIBoK5K3TKP0Ew5g
68	!dKcbdDATuwwphjRPQP:localhost	$DPsZZPGGiAxGhvacv5jzWD3LvkksCslTg7b6bJdMB2g
69	!dKcbdDATuwwphjRPQP:localhost	$3uoSj6oyCXzNscB7fMWArnYLws_CKs7o29JN98bnIwE
70	!kmbTYjjsDRDHGgVqUP:localhost	$lGzytyESKSbv7gQSrCLbhHb89N8hJVb2tUVxNFJGNC8
71	!dKcbdDATuwwphjRPQP:localhost	$bl12RMayaeVdWxVHjZrybOUjb0cPQtao7ciB49AAESw
72	!kmbTYjjsDRDHGgVqUP:localhost	$-Hg4oCVAG5WnYeSsn1oVa_S9uA3QrCN1_Wg8zKmdF7Q
74	!dKcbdDATuwwphjRPQP:localhost	$GJ_REMVRwqJ3M4nvr336W1IYfzs4R022sD4Xq9GgR5o
73	!kmbTYjjsDRDHGgVqUP:localhost	$Y7ZS98oZJlIWyzPRblug6ZCNWmUwfO-CfhQqaNtKuMc
81	!dKcbdDATuwwphjRPQP:localhost	$yah3Di9dekITWMlkCYoUM2irSpAJaaflI76ia8gf3lI
75	!dKcbdDATuwwphjRPQP:localhost	$LvgknwGcq_qRJQu3lAFHQ5Pum4fH3XIluHZkZHwv1vk
83	!kmbTYjjsDRDHGgVqUP:localhost	$DkrPajt6Up_xlioIGBUdGR7as4vEId8Ci0nDgim3trQ
76	!kmbTYjjsDRDHGgVqUP:localhost	$ItOQwVtMAN-Esk79z2rWDkrNt4r1pq5MqJ58n5CRVes
84	!kmbTYjjsDRDHGgVqUP:localhost	$zFNSAIBCZtMm3fJjaHp3FbvUfi-bbh77SLBCpZoQ31g
77	!dKcbdDATuwwphjRPQP:localhost	$oOE_IiP_4ABZegcpxHzJO0Ig5z6ZgY5H--93pZW7auQ
79	!dKcbdDATuwwphjRPQP:localhost	$TtyM5Q_j_RB2JfB7uGoJ8dUTh0y8ffPXVB9QPmxDZsE
85	!kmbTYjjsDRDHGgVqUP:localhost	$meNPWRdcC15gOjoKy7aotqGFmCp96l_elBRSChx6Qxk
78	!dKcbdDATuwwphjRPQP:localhost	$IAw-2W_IgMtCdRosjkERwjRIoy9Qcz6s_MiunnGHpxQ
80	!kmbTYjjsDRDHGgVqUP:localhost	$WunNkuuYc7wRDc4RsnWuc93E-5j5uZdUYh_K5rKbpNk
82	!kmbTYjjsDRDHGgVqUP:localhost	$wCDAgzxDA46cj2JR1OP75EgjWeS7dUEBzy26M0bq1Z8
86	!kmbTYjjsDRDHGgVqUP:localhost	$Erahby-TrxS8vhbEawruWiQ_OKjm4F4m3aX-zrtACHM
88	!kmbTYjjsDRDHGgVqUP:localhost	$L4yIudAGrsCa8p2EI69eftP3RNYfff8Eu_OcBEMyLnk
87	!dKcbdDATuwwphjRPQP:localhost	$kMMsM6LzYBPZaVdEM3Jk2j80a5B4T_GsvKXklburbZ4
89	!kmbTYjjsDRDHGgVqUP:localhost	$RGT7BN__gcYyT1Ok7BkyIcsogzUOmXkduyrJRb-LnaE
90	!dKcbdDATuwwphjRPQP:localhost	$hNWLFkNsSJEFgKoZen5CQqhWIqN9HWhROp_PpgKLhTg
91	!kmbTYjjsDRDHGgVqUP:localhost	$iExZ8R59u9PwWltasqY6OCAgiX39v8Imri4LxJU2flU
92	!kmbTYjjsDRDHGgVqUP:localhost	$PfjA2f21SVmEAsRM5UUgOg8l8Kc1ngPxlqndX7MOQmM
93	!kmbTYjjsDRDHGgVqUP:localhost	$8BgF80ndyddX9B36NB2JS2AmgsnCSNdzWyxuDFqkRxU
94	!dKcbdDATuwwphjRPQP:localhost	$5GE3HChx7SIi4Lc64UzhJxIe18h_v-5MHSXRShXQwZo
95	!kmbTYjjsDRDHGgVqUP:localhost	$fDUgDgrp3dx6ovS_x0GVbhkYuzT4RvOhicmIe_fVdqo
96	!kmbTYjjsDRDHGgVqUP:localhost	$S8gvrieevHs4pgPJD1DuhqtWVH7gGcfKvnokkbb3siM
97	!dKcbdDATuwwphjRPQP:localhost	$6oCsRYoBDBMJzVy4mL74wgLrDIBR36U-yIkBpKkPNPM
98	!kmbTYjjsDRDHGgVqUP:localhost	$sh_mdZIcugcgRHCX4t3JmjkM_thYo1_dMOK9_T61z_E
99	!dKcbdDATuwwphjRPQP:localhost	$H2kBeNPPNH1P1xhXl8AemuvfXim8oPRC-Oxi1iQpyog
100	!kmbTYjjsDRDHGgVqUP:localhost	$hF47ktvvnMpDnY_VcQDrM37nC-nhd5pC9JliDqVqBak
101	!kmbTYjjsDRDHGgVqUP:localhost	$Df1xs2TWn-mijozZx9VusLBth4cMN37YSAXHbbG_tTU
102	!dKcbdDATuwwphjRPQP:localhost	$nRG07SGwkE_HYqczRqqB3IQRW2rL6Vdyc9H0gnjWi8g
103	!kmbTYjjsDRDHGgVqUP:localhost	$EwYANb4aGuYBf1tREVzuW_dXeABP5tf9YpSeUprgfcM
104	!dKcbdDATuwwphjRPQP:localhost	$1F_yI393dW2vC-PWb93rXVdCfvAHvH3dgXWB4mhCkLc
105	!dKcbdDATuwwphjRPQP:localhost	$IYMAflh4PWWAtOHIu0FYPDB3iMMzPfH2kIB7heT7kRs
106	!dKcbdDATuwwphjRPQP:localhost	$5o1j1k6INkx0JJ7_ZFyFgeKN74rtsV5R25PzwJiquBQ
107	!dKcbdDATuwwphjRPQP:localhost	$5BQNvs6sKhJMJUiI8t0tygviUzjL4C4EmtI9muw_H5w
108	!dKcbdDATuwwphjRPQP:localhost	$khtUPehm0sMcUWi50cnBsVQGa6_k6pTIeY2NRCHskss
109	!kmbTYjjsDRDHGgVqUP:localhost	$zHX4h5PSjr8cf48D9XrVHdD5OFVdm-iUaMDio3IVUxA
110	!dKcbdDATuwwphjRPQP:localhost	$uhcoHOsbehBt7vurqzjLqRwHTN-azETKhF4DNCZnRm4
111	!kmbTYjjsDRDHGgVqUP:localhost	$fqHs89ah1mbp1_5cYllNgyd01KXulOuquCbtMOVbEm0
112	!dKcbdDATuwwphjRPQP:localhost	$P9jJ4rqcMBsEhxT9b7uWmZzWXxuWj0TRYSe1dZ9Yna4
113	!dKcbdDATuwwphjRPQP:localhost	$Kxw8ZRnp63AA7TO1FANsx3SLFRTS34uKbCLgD6mWHP8
114	!kmbTYjjsDRDHGgVqUP:localhost	$C8v1PpeaFOsOt56T1aglRCG6EFVmdrimeWVxmRrYQyU
115	!kmbTYjjsDRDHGgVqUP:localhost	$gz7j2QlX0xf3jw9_8fILpm6CFnMhnWgiCLslIeseMHk
116	!dKcbdDATuwwphjRPQP:localhost	$vNQXYphfLsnBEVq1qPJ5qCsOd-H38KoOeQuFbiNm5HY
117	!dKcbdDATuwwphjRPQP:localhost	$vcIPzEMPOmp7Pr4mF9HthkRwKj9w4W7YIC-1vMMsa-c
118	!kmbTYjjsDRDHGgVqUP:localhost	$eIMWDruLpjaidNGgIsVwZR3YF9hTkYqTYFpbsZ4ArkE
119	!dKcbdDATuwwphjRPQP:localhost	$BlaUeOcmpt_kNa62yUBR8fN6D2Rlq2BoOsu1v-0UeOI
120	!dKcbdDATuwwphjRPQP:localhost	$wjh6Azx3rFPlybeeSy4UEiyZz_Gse8NKmPUScLyEAus
121	!dKcbdDATuwwphjRPQP:localhost	$hpo9EBffUHWA5FLm2_ROCsbX8Fy8CkzlSH0w9xIalng
122	!kmbTYjjsDRDHGgVqUP:localhost	$bCscjob8EhbvRgxECzAFrLOHM160SCrJG0QL6UiwCXo
123	!dKcbdDATuwwphjRPQP:localhost	$fqERnSXUH5UbAy58s3fBM9fmAtRwbiDpRHnBTHp8-Zo
124	!kmbTYjjsDRDHGgVqUP:localhost	$rH2tg39z1Ecw5xADWqhhbUm_V8l25VwjGP4eZuQNnAY
125	!dKcbdDATuwwphjRPQP:localhost	$9UEBx7DJDVWtf-Cey8GLHYrNY_VM4yUSL5mHSJrSvpE
126	!dKcbdDATuwwphjRPQP:localhost	$56xcsuIPpLQo6k1Pg4vZylYgNbBr6DEaiOM9Tqu_g9k
127	!kmbTYjjsDRDHGgVqUP:localhost	$coAxrmHk1DbqgR83ZLnAmYz4mzhgfFs7IN7KWv_gF2U
128	!dKcbdDATuwwphjRPQP:localhost	$aMf4q3fjOAqZw6v3We9pSa46GFcAO8Itu9dUcRxGW74
129	!kmbTYjjsDRDHGgVqUP:localhost	$-OGhvAMZTXBO_XI99N2Jtx3cl6nSnAmVPiEHC3Gq-58
130	!dKcbdDATuwwphjRPQP:localhost	$4ULqgY2iURBdxsdpUzIzqqSv7NSGrNkb2UyD_976jl0
131	!kmbTYjjsDRDHGgVqUP:localhost	$RjV2DkqHBe93TvbfZl-kTOR4XZjBpsILz57IBkJqYt0
132	!dKcbdDATuwwphjRPQP:localhost	$oO3qwUgfIwt6lOhJSL1SQ3Kt7w9w3qVTey2tXgAi34c
133	!kmbTYjjsDRDHGgVqUP:localhost	$-Sx9XWbg_2Vk4ogN1tuxwitCla3FruEZW18mrbaRR4Q
134	!kmbTYjjsDRDHGgVqUP:localhost	$9g2XbBMsi6IpL6i_KgaZyUMRVVrWdb_O-wVdZ1XdLQU
135	!dKcbdDATuwwphjRPQP:localhost	$uEIsiMtdJKv_uCh6Q7mw8LhnSKPxxxWYl5bBx6mtBy8
136	!kmbTYjjsDRDHGgVqUP:localhost	$FPu9dYl-BVUSUgjvY9a0_n5sG__J3ZSfaqrUTyAORwI
137	!kmbTYjjsDRDHGgVqUP:localhost	$1Lsi5c7b2uiOBeJDeZWBW1dEdxYHuNAJn9rbuyt-JoA
138	!kmbTYjjsDRDHGgVqUP:localhost	$GP7ZwEzth6ZYh_2zHWlgagzUwbVIeyXg0cw2nMER4yI
139	!kmbTYjjsDRDHGgVqUP:localhost	$Y28RYZDzvtgovNOviswtt4fTo-JzQ1L7pTnExyvPY3I
140	!dKcbdDATuwwphjRPQP:localhost	$jOylfXlQLFL0GsAsrZyClURWNLKohtiqqm8vpC5TRN8
141	!dKcbdDATuwwphjRPQP:localhost	$9roWOr41EpL10ogFjrFgrjKp8yZA2mhi3B_cl12um7o
142	!kmbTYjjsDRDHGgVqUP:localhost	$xi1QWw2iOFjBL0d1wKkKdi-91DjbFqCYJehZvMg_14U
143	!kmbTYjjsDRDHGgVqUP:localhost	$jFhx0D6eddkKhZNriaivn0qTbLKs85fH0fO1cUPbiLo
144	!kmbTYjjsDRDHGgVqUP:localhost	$MGsZsYd9EDPgpzUndFKh1mPqbb4k_vERlVSFMY9Y8mY
145	!dKcbdDATuwwphjRPQP:localhost	$O80myhmTQy_oiuVXaUkqHcTITPSzM6OAsEUrXX63xIk
146	!dKcbdDATuwwphjRPQP:localhost	$KMws5KNkiA3CjDaKy1xujSM7wzdRigEFshbBV8WdOtg
147	!kmbTYjjsDRDHGgVqUP:localhost	$-zyP7JFXoyDyh649bMnIDmd65jJN9fAbEmGnw-ggqHA
148	!kmbTYjjsDRDHGgVqUP:localhost	$VHNKatq3wcPmLxa9HE5TIKyBdkdYG3xGt-EMFIbtcFU
149	!kmbTYjjsDRDHGgVqUP:localhost	$YATKMC8UJJVr2ublhbn4Pvq1LhS7bXfmT4aysJ0dSRE
150	!dKcbdDATuwwphjRPQP:localhost	$6oqiD8mwg9yVb9R340vWp2DvT8DnyzYUB5-nHPHO3Bs
151	!dKcbdDATuwwphjRPQP:localhost	$ihuG2lbJbwC5x4ONDyKh1acz1rOcYBUg0LGvnNCsPj4
152	!kmbTYjjsDRDHGgVqUP:localhost	$ExNEtfJ6tdzCfLgVhzbiRe8vB7NQ4PO_AjzHhCcTIDg
153	!dKcbdDATuwwphjRPQP:localhost	$R1Ao5KKhwegjn7KhBqn-iagsDGh3K5gk00wGXb_b9Nk
154	!kmbTYjjsDRDHGgVqUP:localhost	$yatXqgv_JmznLc-lSGfIixNfUKkfy9F8OpG5h1sldL0
157	!dKcbdDATuwwphjRPQP:localhost	$wF45t88r7Qf4t4vIy1-gP8IqgJqQsW5VrHiPKJFcous
160	!dKcbdDATuwwphjRPQP:localhost	$-nyYXvLmH8xffgwsGav-PM-0pLPXXlstI-s5NqcM8v0
170	!BfSgfecvJnYoZjTYRA:localhost	$Uf6bLI9lxBnR9TJvz8fcfo-1_wbshzMvT4Ecr_qy-E4
178	!dKcbdDATuwwphjRPQP:localhost	$9RMpgZfWLqPzjcbLqUdLlvLbajkWRqO10fO3edSoFL4
179	!dKcbdDATuwwphjRPQP:localhost	$058zlQ1du3OFjMJR-ND8pt26qsSNNKMMbZjO1TKya1c
184	!kmbTYjjsDRDHGgVqUP:localhost	$69y0DOCe_fbJdvBaSmNaqgKpV148tCr6_lEUAvSIVmY
198	!kmbTYjjsDRDHGgVqUP:localhost	$4GvcefEwb0sPDVMlFPozUa_YkGM-SXvOftpaQaS3iI8
155	!dKcbdDATuwwphjRPQP:localhost	$Epe1QWhhtxYVMNZpiRkpXpv3LAycR27XrLe3HFc_xU8
169	!BfSgfecvJnYoZjTYRA:localhost	$ZraIWv18CC1pTAGQZToI1ZXr7ki_53OY_jvQl0RDE_A
191	!dKcbdDATuwwphjRPQP:localhost	$6KCSyhkYGihbzIY3Y2gYiajjeASRjgCqmboV9dNaLJ8
196	!kmbTYjjsDRDHGgVqUP:localhost	$ExIYysqsw_FR-5o-0If0dLU0Yw35w-hgGjSnb4zxs1s
156	!kmbTYjjsDRDHGgVqUP:localhost	$kjltc9l-wAwgXSKZ59_kIyAbmYXW_bPhPV1zEj2mP5E
162	!dKcbdDATuwwphjRPQP:localhost	$gQg1OK-TZZsY8TCzHFjodH2RBPL2aj8D6jpOi2PA7kM
168	!BfSgfecvJnYoZjTYRA:localhost	$eKvf8PFaZwsEOXW-IIYTGZwl6gxEYmEE2TalB5k2iGs
183	!dKcbdDATuwwphjRPQP:localhost	$nVm2IfI-eCS3aNqWDTNx8k1nEkXQTiH5bSTsUCDzB3Q
185	!dKcbdDATuwwphjRPQP:localhost	$xIe5fDIyqfoRUrXv9RzKtK3KvDpUaQJ5vVtklHgs-Js
195	!dKcbdDATuwwphjRPQP:localhost	$LsEM9iCKCgz1J1WqBn0N54lPpfG-HuvvU1fy7wQFh8k
158	!kmbTYjjsDRDHGgVqUP:localhost	$64XobAgmAT3xjja5oVXN7R6sxYQ2pfS2y-xI-_xWsv0
159	!kmbTYjjsDRDHGgVqUP:localhost	$pjGPUJ_9sLPsX5QS9ZPpV2-USu8i2FfLFpmmDKsR8KA
161	!kmbTYjjsDRDHGgVqUP:localhost	$lRG7O1DiDZW8fs2oBDxVrH6WMFlR0UVP753Y4p3AkK8
163	!dKcbdDATuwwphjRPQP:localhost	$FwHVikRlB9QHNZO9Hhu814HyaYQnqPDO6yZpdh_NBJw
164	!dKcbdDATuwwphjRPQP:localhost	$AjV8gA-8zUEkhjG6fr4g5hcD1ngbO87JCJJ1FHaOoGQ
165	!BfSgfecvJnYoZjTYRA:localhost	$NfGFxRqIrSmaeLcN53BGirnWzJ1bpwzVyt2oZw2cj1k
166	!BfSgfecvJnYoZjTYRA:localhost	$NfGFxRqIrSmaeLcN53BGirnWzJ1bpwzVyt2oZw2cj1k
167	!BfSgfecvJnYoZjTYRA:localhost	$7N18oPwd46twVh-RWhED6VAPm79aIXVCh_BVUFAFHP8
171	!BfSgfecvJnYoZjTYRA:localhost	$30q15kBxfYB9Dyc1sAhoNXYpZXfDlneq4Ckvuz_Sy1Y
172	!BfSgfecvJnYoZjTYRA:localhost	$wlATKVSoZpEXfwFpmdptZK6V2TMFQ87Bjjhru1P3dGs
173	!BfSgfecvJnYoZjTYRA:localhost	$PZkmtd-Zj4an2Acc9O8V-mK2mVxXChviZhd_hsf6Ehg
174	!kmbTYjjsDRDHGgVqUP:localhost	$x0ZOZgmGcuSts2ENoKXoXtQX31-Ob-Hp8MsF-q0-Ep0
175	!dKcbdDATuwwphjRPQP:localhost	$xkJvjddyebNuRobAnnSPGdmZ_zCd0zV6U6ke4g_X--o
176	!dKcbdDATuwwphjRPQP:localhost	$yde7PvaRuZgalkrstweNIIHhiqyq_h5pyYS3bsoOW6g
177	!kmbTYjjsDRDHGgVqUP:localhost	$jt2i_QCFn__79rijb05_YyTD5hmvYG9Gsq_CtLrR-Dk
180	!kmbTYjjsDRDHGgVqUP:localhost	$CoooTzBebjXCy7n4DMYU0bOg_VB9VlATY_w2cqzbEg0
181	!dKcbdDATuwwphjRPQP:localhost	$_13GCs0TQVwt3RiwyPJGVIkj6sDRYLTDpZAjYQrKI0c
182	!kmbTYjjsDRDHGgVqUP:localhost	$CB0S6NUcIHA0Bs80Rf3uIK8CbDIrZiD1PAzxBRl7LA8
186	!kmbTYjjsDRDHGgVqUP:localhost	$x5YSYA7JzrN8wFNXkiTl7z9fEIbelyx2leKYalIVs0I
187	!dKcbdDATuwwphjRPQP:localhost	$o7j5x13RPANokxELGWafyXmA9FLhwGmupdfFvIpVe7I
188	!dKcbdDATuwwphjRPQP:localhost	$aAUlcjOICelzjtFKrzme6vzGDgeGXOEfWOCQxRLsY3E
189	!kmbTYjjsDRDHGgVqUP:localhost	$L4RxQrWT9Q0_D_CPwKmjYmOfVLpWMAEbOwGUcj4-alU
190	!dKcbdDATuwwphjRPQP:localhost	$dxwh6lBEaecNbYhILDFw4Xqdd8X4VHJhOmPc_YBoyHc
192	!dKcbdDATuwwphjRPQP:localhost	$UBIUf1wzbAfWt14aqqoiK8SZzDz0QfThjuIeF-Ei3vg
193	!kmbTYjjsDRDHGgVqUP:localhost	$J8BHx8CEysLOXWn-zD-LuWnJZLYdCW4w_0xftpTkqYk
194	!kmbTYjjsDRDHGgVqUP:localhost	$rr3GVb0NbgRugPf95Vk2fQiO-LADrslfg2K5S5d4wjw
197	!kmbTYjjsDRDHGgVqUP:localhost	$wbRYt33vpFGB9wXj8CkTmLykhmyRxJ8xeZru9JwYC5U
199	!kmbTYjjsDRDHGgVqUP:localhost	$YtQl3zeA75MWNG1w6audvjwrYBWV6mXb8C6Ga6WDrhQ
200	!pWsdJYvpdmDULVhQtX:localhost	$pIVIlPgvO-fbiW31dx4GB-wsRX4DrbADDn1AfJoXI50
201	!pWsdJYvpdmDULVhQtX:localhost	$pIVIlPgvO-fbiW31dx4GB-wsRX4DrbADDn1AfJoXI50
202	!pWsdJYvpdmDULVhQtX:localhost	$bWqW6N4T6ZlJ3MzEaI-MgqdvMEklGrNsy22WqL6ZgOc
203	!pWsdJYvpdmDULVhQtX:localhost	$ngKTLt0SDFtdjkF6GnjahEcDA-qLwTKRcVgMgMg5tN8
204	!pWsdJYvpdmDULVhQtX:localhost	$IxyNn3A4NegMug4xc7O0sm2s1r9jyybU5iNogwEGesQ
205	!pWsdJYvpdmDULVhQtX:localhost	$SQpUzgCCeFIrGC3eCPDX_U021w7MG0-lHOxFTcHbvKk
206	!pWsdJYvpdmDULVhQtX:localhost	$pe2Yi2ila5QgzVKIEGGAIeqvcRaD37GUFMvAOWX2tp0
207	!pWsdJYvpdmDULVhQtX:localhost	$_MdWHbg9mI3zN-WDGIpwDRJZmDWXBeW-m3WrJiRs4t8
208	!pWsdJYvpdmDULVhQtX:localhost	$7qFBn6lW7C0hRYBTRjR0tsE8qpZmodqh6LOyLL0HMnQ
209	!pWsdJYvpdmDULVhQtX:localhost	$d7sJ6Squy3gHlaCn4UxGeu_9AcN2XCBHtBIY8VL5d_g
210	!pWsdJYvpdmDULVhQtX:localhost	$8lVZQlOM-qXD0dT5ZSbvlEPAQPq5wJHU8KqM6sLfmWM
211	!pWsdJYvpdmDULVhQtX:localhost	$OsJU_fxidXD79b8VmXNcxdAdUkhXO3S73zUBYUa3yG8
212	!BfSgfecvJnYoZjTYRA:localhost	$76OhaN_mof41kiqxA-qZV26DgKxkvkl8JwQjOYqZF1A
213	!dKcbdDATuwwphjRPQP:localhost	$ookqlSa7mnlrdjzkLacPnjSeTMaz_ziKTujCG08tNtY
214	!kmbTYjjsDRDHGgVqUP:localhost	$1WtE7dVviGcbaiXXiFzC_D6MPYLxmoG1bruTjhL7QPo
215	!dKcbdDATuwwphjRPQP:localhost	$JHt8yTopbTnKQirNm2sUE-VO7nB-MVB3RgH9verjZMg
216	!kmbTYjjsDRDHGgVqUP:localhost	$nzb8jklpQULzsHkg4ennbYTa1tFDzoRANqT7bEyCjbA
217	!kmbTYjjsDRDHGgVqUP:localhost	$p1LKjB3_qxYduEcevuH3VHzGF50_gElPoXuVVES5yHE
218	!dKcbdDATuwwphjRPQP:localhost	$ZYGFeG9k8oN8K78yvTrPSRQqFTlQlpjQ1u5R7MqMPVA
219	!kmbTYjjsDRDHGgVqUP:localhost	$P2KNNp8BWcW0lwfmH6dv372FWmuCgD99YCxCirX_24k
220	!kmbTYjjsDRDHGgVqUP:localhost	$CWcoz4q_uaaPYjIBIT5AnxMCONxUVoQmYk5Xi63PLhY
221	!kmbTYjjsDRDHGgVqUP:localhost	$q1S0plqlWdpoHUV2MVfoJxX6VYu6lrcUIn5NouxrpN0
222	!dKcbdDATuwwphjRPQP:localhost	$43QkdEfEt7HKU_yuu_ONjHdGvfspcdQxX0ILS-l32Lk
223	!kmbTYjjsDRDHGgVqUP:localhost	$Q0T53MXV2c1xyXUhHQk9c1RZhAPQb9Fxeg0Iim8HVGI
224	!kmbTYjjsDRDHGgVqUP:localhost	$PiJldnZIgnFLIsld4eQJRt4skJs87a9EhFd79MaBh34
225	!kmbTYjjsDRDHGgVqUP:localhost	$8EVF40qVJdh_jFfIm0kpugtOGrkf8t4yfwNxGL2qglY
226	!kmbTYjjsDRDHGgVqUP:localhost	$yNwq_TRKKZiOjbNxMXFXsQQizcrEK5hSGwM7Zgz_2NI
227	!dKcbdDATuwwphjRPQP:localhost	$n8XAvet9BwdXJkiaa9FRb1XFDtAfiN5htf7Mt-TLyyk
228	!dKcbdDATuwwphjRPQP:localhost	$ZzKnXCDFEY7C0J9-HRH16wVfaSqT5NQwHxlzlHeghJY
229	!kmbTYjjsDRDHGgVqUP:localhost	$NgiM496CKzyo9mL0iB4twnILOiI0iSVxNrfJ7ZevEvk
230	!dKcbdDATuwwphjRPQP:localhost	$l4NrZ0A1RlAEQON9EsKRRgnffUWoAoaqefApPQ1VY6Q
231	!kmbTYjjsDRDHGgVqUP:localhost	$6u6Tz1Elg1k0KgrBWCYX4EDuAIY3cYzC9QGb-TbZ7VY
232	!dKcbdDATuwwphjRPQP:localhost	$3by9dlJt9SeJ0Blyu5DdOV8mFnseUXul8FrpNJLCCw0
233	!kmbTYjjsDRDHGgVqUP:localhost	$JUtF9FhG78XWw5WA9iAP5HYKGKF4Lu8Vw2GCQnxLG4Q
234	!dKcbdDATuwwphjRPQP:localhost	$-uge4wQUpCVHb-wsXi_7jIe8TtKm7AkwVvQgvUriRCc
235	!dKcbdDATuwwphjRPQP:localhost	$uZjmYz-4nC5dNxkULv7dOuefYufe4J-RoiyOqO0_--U
236	!dKcbdDATuwwphjRPQP:localhost	$j1SzTn_a2DmIy9kS9tEvYrWWaQPK9qDw8bE1b5u5tUQ
237	!dKcbdDATuwwphjRPQP:localhost	$10QOTDSxlbUls_ztcz8_snwMb_C6O6J_0eVPeWmNzYA
238	!dKcbdDATuwwphjRPQP:localhost	$sirplViWe5LOuGNWLxn1taMZ3vMapdBt6rkX7v4w3nE
239	!dKcbdDATuwwphjRPQP:localhost	$Z4EEzzSh-PPixQJa0Qd4nqnNgsNmpgWV5sw19ibyHRU
240	!kmbTYjjsDRDHGgVqUP:localhost	$RCc2BKAAU0xwFEG7lPJnGfuRSd6yEi3q_Hc0zskLWug
241	!kmbTYjjsDRDHGgVqUP:localhost	$8ZM7qMbEwWVaBlf-c9rlwby2-b7Dga2c6Zq40K2y_-w
242	!dKcbdDATuwwphjRPQP:localhost	$Y9fHVplXv4p1AuIF3N9eYKbSXiAzmmQ7rMlmdImX_h0
243	!kmbTYjjsDRDHGgVqUP:localhost	$fU6KcQxNHMHMFBncKMc_sINH1LqRfLEjo6QY14pHz1c
244	!kmbTYjjsDRDHGgVqUP:localhost	$SShu50vkA4_WUgVAD_tyo9Yj35ASKebFSp7AIlE3jGg
245	!kmbTYjjsDRDHGgVqUP:localhost	$91QQ5eIIQ380-EfpFRVOStoHkmr7iUuurx-i65rNe1A
246	!dKcbdDATuwwphjRPQP:localhost	$WfhmMlJ8a7LCyZxNPwaJjoEsoa7DPivbliXuvxSpB-s
247	!kmbTYjjsDRDHGgVqUP:localhost	$kLb0d3AeHTWwU_JSvGXIthWm6OdK1fhUSMS48kLhBy8
248	!kmbTYjjsDRDHGgVqUP:localhost	$uZJ96yTaWnBxdnDWLoQZBSa5v3bgKYYTQyk1te6MbRU
249	!kmbTYjjsDRDHGgVqUP:localhost	$4pz6RI3cOq_sk23rZLxlCRxSlVG4odWIhb_Tmb7BBI8
250	!dKcbdDATuwwphjRPQP:localhost	$ui8Q0MTwyJJ8SkQUPXZqMuqIjSJAdgnZmv3lCs7fD7U
251	!dKcbdDATuwwphjRPQP:localhost	$denY4rFY5cmKVZ61qJvrbB3p-zpnNz9JI_c1v_jz8DY
252	!kmbTYjjsDRDHGgVqUP:localhost	$ZT3nsIEkD4jwuM954BWMPocL1KIhPb2YkxYq437nvZ4
253	!dKcbdDATuwwphjRPQP:localhost	$MgQYTFCTdU6NmtK0alkF0fLBwrWRdhnwWEYBSDO4oN8
254	!kmbTYjjsDRDHGgVqUP:localhost	$-cbPq-8i3jW3wAGXaaULCmiAxnvt62LeKUzLEwRsLZ8
255	!dKcbdDATuwwphjRPQP:localhost	$DJkoyDnNKzOMoyHXrwhjjIbc4sr4c5qa-vTsu-ygWCU
256	!kmbTYjjsDRDHGgVqUP:localhost	$lH8GYoDuYR02R2s1IZ1HjSkEZKVS9k4kBhr3Ziw7yAs
257	!dKcbdDATuwwphjRPQP:localhost	$i-KO6Y_sF828IyugytSgKTsKwvvPAuBsxMaTwO9OwRg
258	!dKcbdDATuwwphjRPQP:localhost	$dzRbCjhdfng5Zgo28lrRG79oXzyKPf6oSiRKAILTlCg
259	!kmbTYjjsDRDHGgVqUP:localhost	$pB0oSMJNS80mro5VRDn22HDuGjrnC_5SS4HpB5U1jhE
260	!dKcbdDATuwwphjRPQP:localhost	$RjgQaQlqYefKt2GpPWViIE6ElEwoyG9XEPqKHOLzmvU
261	!kmbTYjjsDRDHGgVqUP:localhost	$Tp5Xk31fuSoiVwlSwbCCKZ0iJQbAldbQaWAUepdvy8c
262	!dKcbdDATuwwphjRPQP:localhost	$tLgjtE9lAPSNjvmOJBE4UHVA__vQ0h3zR31FzvP-EB8
263	!dKcbdDATuwwphjRPQP:localhost	$GiTnYg2qbL0NhYXAeF9O7JtJolDGTTykooymchZRUoU
264	!dKcbdDATuwwphjRPQP:localhost	$1KDpgMHGbPRR_uwUkSHBNQCOaydIzh70Tr8oR3YNpVg
265	!cUrTzQWGYNmZYMHoGB:localhost	$XhE1A2QtMIi_b9SfK9jbadCTQ4Xd5IZxBaUOcfglbIA
266	!cUrTzQWGYNmZYMHoGB:localhost	$XhE1A2QtMIi_b9SfK9jbadCTQ4Xd5IZxBaUOcfglbIA
267	!cUrTzQWGYNmZYMHoGB:localhost	$Ip3uw4uae3e7xwaJ6BU2ppE2nWhA0Zyb0KZDNvHAdmU
268	!cUrTzQWGYNmZYMHoGB:localhost	$nofByIO1FFs8JcKVqFZb7ulSmWdVGm_V-3n-LceVmnw
269	!cUrTzQWGYNmZYMHoGB:localhost	$wtg0qf-MdY5Ur4UMAlOlQ58df82OmKhsbTS81ItsAT8
270	!cUrTzQWGYNmZYMHoGB:localhost	$DFCNP6Tt2ypS8tXyd5kaCiqWeVDmE_FL-iOprkrfubk
271	!cUrTzQWGYNmZYMHoGB:localhost	$MJ2YTkP3f-eQwc5HLB6GVzjnPJaVov0pUCfq1bWqG3M
272	!cUrTzQWGYNmZYMHoGB:localhost	$iAAlBelGypnsbVKn9Fd-ubLNje326TRpaegoLLyRZGY
273	!cUrTzQWGYNmZYMHoGB:localhost	$34bSEXw9U2DTNkZA2he27rczptl3jni1oG64GRRYkfY
274	!cUrTzQWGYNmZYMHoGB:localhost	$SFXqj2UcfZU2XtnGBtupMwsoI3Z5JLp-7mmR2PU4MjQ
276	!hccoYOyrWRMEhMnaoh:localhost	$LnGTvN89zWMaGdr_8T22TNwZ8hCnAeMlGOMaGpCPahE
275	!FSwSlJXpOZZONTVfGs:localhost	$VI4y-gfFPbzFuAM6S6F4gXfpeWta-thThcGlPN0xQN0
277	!JGJhGNDoMdRLJzLgcJ:localhost	$A45QtHYoTPEA17jEFQZ4U882WGuYFA2D4xiKqwnZyUs
278	!FSwSlJXpOZZONTVfGs:localhost	$VI4y-gfFPbzFuAM6S6F4gXfpeWta-thThcGlPN0xQN0
279	!hccoYOyrWRMEhMnaoh:localhost	$LnGTvN89zWMaGdr_8T22TNwZ8hCnAeMlGOMaGpCPahE
280	!JGJhGNDoMdRLJzLgcJ:localhost	$A45QtHYoTPEA17jEFQZ4U882WGuYFA2D4xiKqwnZyUs
281	!FSwSlJXpOZZONTVfGs:localhost	$Z-W9-QEq_roRPUfFFGrVn3vc_d4uekRlcsL3uBSdDpM
285	!FSwSlJXpOZZONTVfGs:localhost	$CjB4vCnMjTm70a0EahGjB5FN8EKtrdWl7F12gA2FhDo
292	!FSwSlJXpOZZONTVfGs:localhost	$27FTfsExd-igZozi1nKpy5Iyqayuxc3DZY9LFN9e6oo
296	!hccoYOyrWRMEhMnaoh:localhost	$NYaJba-K1Im8n6_Z7mL0VwgIAKxZqouzTTYu6EcK5eM
282	!hccoYOyrWRMEhMnaoh:localhost	$RRFtexNdS-wxfmZgcU9kk5Lyp462lIuVu6piimDKCGA
298	!hccoYOyrWRMEhMnaoh:localhost	$-FXdMAkllHkSbPP-QDGsb_zIuCwPKR511zZahmMGKs4
283	!JGJhGNDoMdRLJzLgcJ:localhost	$uDBLcAyAHq3swiKjGlyKYFZwIrP5Ux8Ki1qU7x3aVsY
288	!JGJhGNDoMdRLJzLgcJ:localhost	$e6pVgV1MsH-6_A1V_vGWGmdznPg_czNOfblinyTHshA
295	!FSwSlJXpOZZONTVfGs:localhost	$33Pk__-gU3AslKMgHWQqdrgfvEhGtn4nPTRaDuhZUC0
300	!FSwSlJXpOZZONTVfGs:localhost	$bgbjmgXAlLz069pieqVTP8KTcxXHvT72ZwdRr71Fnqg
304	!cUrTzQWGYNmZYMHoGB:localhost	$___RsdFndwWsVVLqEZmb4-TWJG-e1GJLt_3bnf1dFu8
284	!FSwSlJXpOZZONTVfGs:localhost	$4ywygf1-17_Kq3j230bjqgAjdpc67zV0hIv7Uw6BKtA
286	!JGJhGNDoMdRLJzLgcJ:localhost	$MLY05F5LyQaOuJw4avembMABTu_CtFuQyhyiF14QtYo
289	!FSwSlJXpOZZONTVfGs:localhost	$Y_182-w64pn902ATtlukjIsNSzVBtF9fw_aMYWx9DdY
291	!hccoYOyrWRMEhMnaoh:localhost	$4MpBsW-eFJ4SoVP-rLgkefjkNR0Sytuayop2Z-OBFzU
299	!JGJhGNDoMdRLJzLgcJ:localhost	$UEYdHpguNtwCDIQ9fsK7537cGDuKB-9QPh7SJsYm6lQ
301	!hccoYOyrWRMEhMnaoh:localhost	$sUchhgur-fFKVUmMUaBERmjM3ItMz4-8bhkuD7UXnuU
287	!hccoYOyrWRMEhMnaoh:localhost	$nMtE3MPK3rxeHXzgEF1GWQXqF1Of8IqoWwPKejXxdrg
290	!JGJhGNDoMdRLJzLgcJ:localhost	$hNUZNFVPWjQzoWmc5wymfJzaTuaIdxyWFsi3fkTJ534
294	!JGJhGNDoMdRLJzLgcJ:localhost	$IYkBkm-ncU_4Z-Ft8v80LsrK5kKpzGKpHDUWZxxy6t8
297	!JGJhGNDoMdRLJzLgcJ:localhost	$JfR9TVM-sEe4hZ5-0bIni5e5m_tLlX2HdSU6u6IoVBM
293	!hccoYOyrWRMEhMnaoh:localhost	$5QgMOlhzvtIooZVNYnMnchsgiEUDObBacU41JO2zKs0
302	!cUrTzQWGYNmZYMHoGB:localhost	$OUsS0radBRPS3B8beUIJ1TUjFMPXJ0OTtSau2wSu6rY
303	!cUrTzQWGYNmZYMHoGB:localhost	$z3x2QWsqd2WeWbha161nzCLfGv7psz2SV_Gveo8B5Yk
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
21	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$PkPxRt8GuXFqdWre9vyhqKHlRSqflC0cOSTBOims4qY
22	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$jyfZsVYOTCt8az1WqRlL53b1lAQWjIj6-IvW1w3qYks
23	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$EHQc-AjnBRaCFge0Ybiy5GhzOQPj26ezNlKeB-vvBek
24	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$1LSD-P0UB_ZapjOWFg_2yQeicQg-RBDE3WrLK3o66bE
25	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$9gvR9727ZRJUenaZH_I8ljPJrjgHIP6BZti7plfxu-Q
26	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$SVIgv7CvxVPYnn0I8RzwxO_oYgOj99qU-ZxPmI-8DkE
27	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$ARxMI5-TIkg2afPIDJsLgeSqCdrfbwBxm32e83QRfQ4
28	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$nE3KmrZJdWnhQ2h6DgIB98qoLGnQlFFCvgSu4NS5FfA
29	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$mlRlSJ1S_x5OctD_Nck7tq-Fo2IC7iOhysac1uYo_PY
30	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Y86Vdmx2z1nvkEoTqBH7oAiLE_sHPFtNgI97gsUAwaY
31	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$pXbc3VIu5b4O4VzPRePQd4FjtqYPJLH87Ss7pZM-gRM
32	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$q7m8fkdDrp2QE9hRAHYIR_KN8htxYXW85pB3LgG-V2U
33	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$YHxtZv4JfPzIJvBMvoTgzeITfTFFng_L_4ijJ1Q97k4
34	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$cH796vSd1hy4UBg8XHAqeUxz-u3gxer-uMeGrsirKbs
35	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@user1.matrix:localhost	$5DYqRHQPE1SQt9QXHJodWH7x4Pztz3LTsgH1kdHawZs
36	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@user1.matrix:localhost	$KtrybuPgyyw6muL8i2Hl4vpLifcWbnX5XvNtNyC15Bo
37	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@user1.matrix:localhost	$cfT7uAtZtdZq5Q82AKsYh-bmJa8FLwzvB4zzHL5if_I
38	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@user1.matrix:localhost	$TKcINA6W5qTH8raDaFqEMBivZ0LjgXtIHGvxzJ9V4_8
39	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$wFrKzC-hGRFxMOMZrj5SGx2LKE0DLWIFMoXPPIOOlnE
40	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$1T2YzEtdalFehZH4MzsybssSyCAFv4eSMuVjgpRSc2w
41	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Lrbom-_cuG7livg7a_k303DHFENjEMB-aOF7G-UkCfY
42	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$mLnnua7L043wxKOPA3FAiNS9FtdjNYKDPOa9knxxErg
43	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$IF4Cesm5Vy_Lz8zNght6Qqcj9ny2oMojSrMwZLhcp7g
44	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$xJzQLQ2nofKRx0ghZNc2VS_zQRcBWrAOyVw9-SUQ2OA
45	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1.mm:localhost	$REN0AaEE212pFbK8uJB-22lyjpnqTEP0SshUeVfsGU4
46	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$fZOewHIi92ULtD5oSzBZFXcXAOSEfIvWlZ4v3oJFW_c
47	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$I8L7afrGiF7xzrB9dIa2JPiugLMIW9iV7ejZK_suyCs
48	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1.mm:localhost	$AwutniYNkYl6Dxs-8zYvdPdGLIcM4Kyzaldut5D0jHQ
49	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1.mm:localhost	$HmGCTcPZGDbaswAPjYZ0ddKt1eWRcRq89rE-yVwDV0s
50	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$RfRzotv0yQEkNKnxdYYLjBQzuOWvVgMzkFHZI6Q97Bc
51	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$yFMSvO4LPDDbsUVZSBHOz2TIj4IoqyHmD-LXNJFLxr8
52	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$fdjyZsX0XtM5CSJWWIGdDbRHQvA31bzfESl1FG2RU-o
53	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1.mm:localhost	$VFMUBSkD_jWG8nImBQfkmffKyLBdxGMpdkFACHA33Ng
54	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$YR6YDcG6TPYJ1sqmQvtpHn-qmjyGMW4XZC8uy7K_KoU
55	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$CPAgh0hEGMzPF7nxQexWfime80yU6FkkHaNeT7SOAcM
56	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$nbGh4DWni0ByialUtu_rJQ4Vc_4KT54dKYbOKRIplcM
57	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$bbzTnDc4eq9oSD6mvkNNNPAeyhUjgzDRd3mSZ-owm24
58	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$fMsRH9wJtZgjWrBibauCxx5tB3hM39Lvmz2lTHU818w
59	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$QOkvrv86Q1H8n8zPlPF6uifkSRfaxCA3DVkhaMp0iB0
60	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$6iJ2Dg84GzDRV_KN47XJhTwi5UcAtwbX1RHvxTW3N3c
61	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$li1nwJzGsjSFXMXHzDwEYmlskv1TDW9FfNXG1Z1bHjU
62	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$jMpD-jssCheykPotavL2HZmY8WinxMsUX6KImEoeZWg
63	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Vfin0LlYAVyy-JXN6OjclHc91JlpEC4O6811oUJ8cFs
64	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$6qWNgg5Oi6bZGkD-6WNlInKOhzPe6JS7QoXJ_wusFuM
65	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$CJaAk6uAQb5btIORfT4VwddnSaCJLAXKKd9boqYZ84k
66	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1.mm:localhost	$TWHi4vz3Yd05QOu7aTCoXAcSxVii7W7Ug0yZMYq0SDc
67	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1.mm:localhost	$_q4Khcfij2a-CKTkRyTZjfUvnAFHIBoK5K3TKP0Ew5g
68	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$DPsZZPGGiAxGhvacv5jzWD3LvkksCslTg7b6bJdMB2g
69	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$3uoSj6oyCXzNscB7fMWArnYLws_CKs7o29JN98bnIwE
70	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$lGzytyESKSbv7gQSrCLbhHb89N8hJVb2tUVxNFJGNC8
71	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1.mm:localhost	$bl12RMayaeVdWxVHjZrybOUjb0cPQtao7ciB49AAESw
72	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$-Hg4oCVAG5WnYeSsn1oVa_S9uA3QrCN1_Wg8zKmdF7Q
74	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$GJ_REMVRwqJ3M4nvr336W1IYfzs4R022sD4Xq9GgR5o
73	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$Y7ZS98oZJlIWyzPRblug6ZCNWmUwfO-CfhQqaNtKuMc
75	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1.mm:localhost	$LvgknwGcq_qRJQu3lAFHQ5Pum4fH3XIluHZkZHwv1vk
76	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$ItOQwVtMAN-Esk79z2rWDkrNt4r1pq5MqJ58n5CRVes
77	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$oOE_IiP_4ABZegcpxHzJO0Ig5z6ZgY5H--93pZW7auQ
78	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$IAw-2W_IgMtCdRosjkERwjRIoy9Qcz6s_MiunnGHpxQ
79	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$TtyM5Q_j_RB2JfB7uGoJ8dUTh0y8ffPXVB9QPmxDZsE
80	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$WunNkuuYc7wRDc4RsnWuc93E-5j5uZdUYh_K5rKbpNk
81	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1.mm:localhost	$yah3Di9dekITWMlkCYoUM2irSpAJaaflI76ia8gf3lI
82	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$wCDAgzxDA46cj2JR1OP75EgjWeS7dUEBzy26M0bq1Z8
83	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1.mm:localhost	$DkrPajt6Up_xlioIGBUdGR7as4vEId8Ci0nDgim3trQ
84	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$zFNSAIBCZtMm3fJjaHp3FbvUfi-bbh77SLBCpZoQ31g
85	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1.mm:localhost	$meNPWRdcC15gOjoKy7aotqGFmCp96l_elBRSChx6Qxk
86	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1.mm:localhost	$Erahby-TrxS8vhbEawruWiQ_OKjm4F4m3aX-zrtACHM
88	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$L4yIudAGrsCa8p2EI69eftP3RNYfff8Eu_OcBEMyLnk
87	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$kMMsM6LzYBPZaVdEM3Jk2j80a5B4T_GsvKXklburbZ4
89	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$RGT7BN__gcYyT1Ok7BkyIcsogzUOmXkduyrJRb-LnaE
90	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$hNWLFkNsSJEFgKoZen5CQqhWIqN9HWhROp_PpgKLhTg
91	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$iExZ8R59u9PwWltasqY6OCAgiX39v8Imri4LxJU2flU
92	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$PfjA2f21SVmEAsRM5UUgOg8l8Kc1ngPxlqndX7MOQmM
93	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$8BgF80ndyddX9B36NB2JS2AmgsnCSNdzWyxuDFqkRxU
94	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$5GE3HChx7SIi4Lc64UzhJxIe18h_v-5MHSXRShXQwZo
95	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$fDUgDgrp3dx6ovS_x0GVbhkYuzT4RvOhicmIe_fVdqo
96	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1.mm:localhost	$S8gvrieevHs4pgPJD1DuhqtWVH7gGcfKvnokkbb3siM
98	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$sh_mdZIcugcgRHCX4t3JmjkM_thYo1_dMOK9_T61z_E
97	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1.mm:localhost	$6oCsRYoBDBMJzVy4mL74wgLrDIBR36U-yIkBpKkPNPM
99	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1.mm:localhost	$H2kBeNPPNH1P1xhXl8AemuvfXim8oPRC-Oxi1iQpyog
100	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$hF47ktvvnMpDnY_VcQDrM37nC-nhd5pC9JliDqVqBak
101	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$Df1xs2TWn-mijozZx9VusLBth4cMN37YSAXHbbG_tTU
102	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$nRG07SGwkE_HYqczRqqB3IQRW2rL6Vdyc9H0gnjWi8g
103	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1.mm:localhost	$EwYANb4aGuYBf1tREVzuW_dXeABP5tf9YpSeUprgfcM
104	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1.mm:localhost	$1F_yI393dW2vC-PWb93rXVdCfvAHvH3dgXWB4mhCkLc
105	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$IYMAflh4PWWAtOHIu0FYPDB3iMMzPfH2kIB7heT7kRs
106	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$5o1j1k6INkx0JJ7_ZFyFgeKN74rtsV5R25PzwJiquBQ
107	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1.mm:localhost	$5BQNvs6sKhJMJUiI8t0tygviUzjL4C4EmtI9muw_H5w
108	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$khtUPehm0sMcUWi50cnBsVQGa6_k6pTIeY2NRCHskss
109	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1.mm:localhost	$zHX4h5PSjr8cf48D9XrVHdD5OFVdm-iUaMDio3IVUxA
110	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$uhcoHOsbehBt7vurqzjLqRwHTN-azETKhF4DNCZnRm4
111	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1.mm:localhost	$fqHs89ah1mbp1_5cYllNgyd01KXulOuquCbtMOVbEm0
112	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$P9jJ4rqcMBsEhxT9b7uWmZzWXxuWj0TRYSe1dZ9Yna4
113	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$Kxw8ZRnp63AA7TO1FANsx3SLFRTS34uKbCLgD6mWHP8
114	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$C8v1PpeaFOsOt56T1aglRCG6EFVmdrimeWVxmRrYQyU
120	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$wjh6Azx3rFPlybeeSy4UEiyZz_Gse8NKmPUScLyEAus
122	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$bCscjob8EhbvRgxECzAFrLOHM160SCrJG0QL6UiwCXo
123	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$fqERnSXUH5UbAy58s3fBM9fmAtRwbiDpRHnBTHp8-Zo
126	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1.mm:localhost	$56xcsuIPpLQo6k1Pg4vZylYgNbBr6DEaiOM9Tqu_g9k
129	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$-OGhvAMZTXBO_XI99N2Jtx3cl6nSnAmVPiEHC3Gq-58
132	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1.mm:localhost	$oO3qwUgfIwt6lOhJSL1SQ3Kt7w9w3qVTey2tXgAi34c
136	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1.mm:localhost	$FPu9dYl-BVUSUgjvY9a0_n5sG__J3ZSfaqrUTyAORwI
115	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$gz7j2QlX0xf3jw9_8fILpm6CFnMhnWgiCLslIeseMHk
138	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1.mm:localhost	$GP7ZwEzth6ZYh_2zHWlgagzUwbVIeyXg0cw2nMER4yI
116	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$vNQXYphfLsnBEVq1qPJ5qCsOd-H38KoOeQuFbiNm5HY
118	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$eIMWDruLpjaidNGgIsVwZR3YF9hTkYqTYFpbsZ4ArkE
128	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1.mm:localhost	$aMf4q3fjOAqZw6v3We9pSa46GFcAO8Itu9dUcRxGW74
134	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$9g2XbBMsi6IpL6i_KgaZyUMRVVrWdb_O-wVdZ1XdLQU
117	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$vcIPzEMPOmp7Pr4mF9HthkRwKj9w4W7YIC-1vMMsa-c
124	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1.mm:localhost	$rH2tg39z1Ecw5xADWqhhbUm_V8l25VwjGP4eZuQNnAY
119	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$BlaUeOcmpt_kNa62yUBR8fN6D2Rlq2BoOsu1v-0UeOI
121	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$hpo9EBffUHWA5FLm2_ROCsbX8Fy8CkzlSH0w9xIalng
125	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$9UEBx7DJDVWtf-Cey8GLHYrNY_VM4yUSL5mHSJrSvpE
130	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$4ULqgY2iURBdxsdpUzIzqqSv7NSGrNkb2UyD_976jl0
131	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$RjV2DkqHBe93TvbfZl-kTOR4XZjBpsILz57IBkJqYt0
135	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1.mm:localhost	$uEIsiMtdJKv_uCh6Q7mw8LhnSKPxxxWYl5bBx6mtBy8
127	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$coAxrmHk1DbqgR83ZLnAmYz4mzhgfFs7IN7KWv_gF2U
133	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1.mm:localhost	$-Sx9XWbg_2Vk4ogN1tuxwitCla3FruEZW18mrbaRR4Q
137	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$1Lsi5c7b2uiOBeJDeZWBW1dEdxYHuNAJn9rbuyt-JoA
139	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$Y28RYZDzvtgovNOviswtt4fTo-JzQ1L7pTnExyvPY3I
140	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$jOylfXlQLFL0GsAsrZyClURWNLKohtiqqm8vpC5TRN8
141	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$9roWOr41EpL10ogFjrFgrjKp8yZA2mhi3B_cl12um7o
142	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$xi1QWw2iOFjBL0d1wKkKdi-91DjbFqCYJehZvMg_14U
143	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$jFhx0D6eddkKhZNriaivn0qTbLKs85fH0fO1cUPbiLo
144	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$MGsZsYd9EDPgpzUndFKh1mPqbb4k_vERlVSFMY9Y8mY
145	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$O80myhmTQy_oiuVXaUkqHcTITPSzM6OAsEUrXX63xIk
146	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$KMws5KNkiA3CjDaKy1xujSM7wzdRigEFshbBV8WdOtg
147	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$-zyP7JFXoyDyh649bMnIDmd65jJN9fAbEmGnw-ggqHA
148	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$VHNKatq3wcPmLxa9HE5TIKyBdkdYG3xGt-EMFIbtcFU
149	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$YATKMC8UJJVr2ublhbn4Pvq1LhS7bXfmT4aysJ0dSRE
150	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1.mm:localhost	$6oqiD8mwg9yVb9R340vWp2DvT8DnyzYUB5-nHPHO3Bs
151	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$ihuG2lbJbwC5x4ONDyKh1acz1rOcYBUg0LGvnNCsPj4
152	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1.mm:localhost	$ExNEtfJ6tdzCfLgVhzbiRe8vB7NQ4PO_AjzHhCcTIDg
153	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$R1Ao5KKhwegjn7KhBqn-iagsDGh3K5gk00wGXb_b9Nk
154	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$yatXqgv_JmznLc-lSGfIixNfUKkfy9F8OpG5h1sldL0
155	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$Epe1QWhhtxYVMNZpiRkpXpv3LAycR27XrLe3HFc_xU8
156	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1.mm:localhost	$kjltc9l-wAwgXSKZ59_kIyAbmYXW_bPhPV1zEj2mP5E
157	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1.mm:localhost	$wF45t88r7Qf4t4vIy1-gP8IqgJqQsW5VrHiPKJFcous
158	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$64XobAgmAT3xjja5oVXN7R6sxYQ2pfS2y-xI-_xWsv0
159	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1.mm:localhost	$pjGPUJ_9sLPsX5QS9ZPpV2-USu8i2FfLFpmmDKsR8KA
160	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$-nyYXvLmH8xffgwsGav-PM-0pLPXXlstI-s5NqcM8v0
161	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1.mm:localhost	$lRG7O1DiDZW8fs2oBDxVrH6WMFlR0UVP753Y4p3AkK8
162	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1.mm:localhost	$gQg1OK-TZZsY8TCzHFjodH2RBPL2aj8D6jpOi2PA7kM
163	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$FwHVikRlB9QHNZO9Hhu814HyaYQnqPDO6yZpdh_NBJw
164	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1.mm:localhost	$AjV8gA-8zUEkhjG6fr4g5hcD1ngbO87JCJJ1FHaOoGQ
166	!BfSgfecvJnYoZjTYRA:localhost	m.room.create		$NfGFxRqIrSmaeLcN53BGirnWzJ1bpwzVyt2oZw2cj1k
167	!BfSgfecvJnYoZjTYRA:localhost	m.room.member	@user1.matrix:localhost	$7N18oPwd46twVh-RWhED6VAPm79aIXVCh_BVUFAFHP8
168	!BfSgfecvJnYoZjTYRA:localhost	m.room.power_levels		$eKvf8PFaZwsEOXW-IIYTGZwl6gxEYmEE2TalB5k2iGs
169	!BfSgfecvJnYoZjTYRA:localhost	m.room.canonical_alias		$ZraIWv18CC1pTAGQZToI1ZXr7ki_53OY_jvQl0RDE_A
170	!BfSgfecvJnYoZjTYRA:localhost	m.room.join_rules		$Uf6bLI9lxBnR9TJvz8fcfo-1_wbshzMvT4Ecr_qy-E4
171	!BfSgfecvJnYoZjTYRA:localhost	m.room.history_visibility		$30q15kBxfYB9Dyc1sAhoNXYpZXfDlneq4Ckvuz_Sy1Y
172	!BfSgfecvJnYoZjTYRA:localhost	m.room.name		$wlATKVSoZpEXfwFpmdptZK6V2TMFQ87Bjjhru1P3dGs
173	!BfSgfecvJnYoZjTYRA:localhost	m.room.member	@mm_mattermost_a:localhost	$PZkmtd-Zj4an2Acc9O8V-mK2mVxXChviZhd_hsf6Ehg
174	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$x0ZOZgmGcuSts2ENoKXoXtQX31-Ob-Hp8MsF-q0-Ep0
175	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$xkJvjddyebNuRobAnnSPGdmZ_zCd0zV6U6ke4g_X--o
176	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$yde7PvaRuZgalkrstweNIIHhiqyq_h5pyYS3bsoOW6g
177	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$jt2i_QCFn__79rijb05_YyTD5hmvYG9Gsq_CtLrR-Dk
178	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$9RMpgZfWLqPzjcbLqUdLlvLbajkWRqO10fO3edSoFL4
179	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$058zlQ1du3OFjMJR-ND8pt26qsSNNKMMbZjO1TKya1c
180	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$CoooTzBebjXCy7n4DMYU0bOg_VB9VlATY_w2cqzbEg0
181	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1.mm:localhost	$_13GCs0TQVwt3RiwyPJGVIkj6sDRYLTDpZAjYQrKI0c
182	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$CB0S6NUcIHA0Bs80Rf3uIK8CbDIrZiD1PAzxBRl7LA8
183	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$nVm2IfI-eCS3aNqWDTNx8k1nEkXQTiH5bSTsUCDzB3Q
184	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1.mm:localhost	$69y0DOCe_fbJdvBaSmNaqgKpV148tCr6_lEUAvSIVmY
186	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$x5YSYA7JzrN8wFNXkiTl7z9fEIbelyx2leKYalIVs0I
185	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1.mm:localhost	$xIe5fDIyqfoRUrXv9RzKtK3KvDpUaQJ5vVtklHgs-Js
187	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$o7j5x13RPANokxELGWafyXmA9FLhwGmupdfFvIpVe7I
188	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1.mm:localhost	$aAUlcjOICelzjtFKrzme6vzGDgeGXOEfWOCQxRLsY3E
189	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$L4RxQrWT9Q0_D_CPwKmjYmOfVLpWMAEbOwGUcj4-alU
190	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$dxwh6lBEaecNbYhILDFw4Xqdd8X4VHJhOmPc_YBoyHc
191	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1.mm:localhost	$6KCSyhkYGihbzIY3Y2gYiajjeASRjgCqmboV9dNaLJ8
196	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1.mm:localhost	$ExIYysqsw_FR-5o-0If0dLU0Yw35w-hgGjSnb4zxs1s
193	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1.mm:localhost	$J8BHx8CEysLOXWn-zD-LuWnJZLYdCW4w_0xftpTkqYk
192	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$UBIUf1wzbAfWt14aqqoiK8SZzDz0QfThjuIeF-Ei3vg
194	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$rr3GVb0NbgRugPf95Vk2fQiO-LADrslfg2K5S5d4wjw
199	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$YtQl3zeA75MWNG1w6audvjwrYBWV6mXb8C6Ga6WDrhQ
195	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$LsEM9iCKCgz1J1WqBn0N54lPpfG-HuvvU1fy7wQFh8k
197	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$wbRYt33vpFGB9wXj8CkTmLykhmyRxJ8xeZru9JwYC5U
198	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1.mm:localhost	$4GvcefEwb0sPDVMlFPozUa_YkGM-SXvOftpaQaS3iI8
201	!pWsdJYvpdmDULVhQtX:localhost	m.room.create		$pIVIlPgvO-fbiW31dx4GB-wsRX4DrbADDn1AfJoXI50
202	!pWsdJYvpdmDULVhQtX:localhost	m.room.member	@user1.matrix:localhost	$bWqW6N4T6ZlJ3MzEaI-MgqdvMEklGrNsy22WqL6ZgOc
203	!pWsdJYvpdmDULVhQtX:localhost	m.room.power_levels		$ngKTLt0SDFtdjkF6GnjahEcDA-qLwTKRcVgMgMg5tN8
204	!pWsdJYvpdmDULVhQtX:localhost	m.room.canonical_alias		$IxyNn3A4NegMug4xc7O0sm2s1r9jyybU5iNogwEGesQ
205	!pWsdJYvpdmDULVhQtX:localhost	m.room.join_rules		$SQpUzgCCeFIrGC3eCPDX_U021w7MG0-lHOxFTcHbvKk
206	!pWsdJYvpdmDULVhQtX:localhost	m.room.history_visibility		$pe2Yi2ila5QgzVKIEGGAIeqvcRaD37GUFMvAOWX2tp0
207	!pWsdJYvpdmDULVhQtX:localhost	m.room.name		$_MdWHbg9mI3zN-WDGIpwDRJZmDWXBeW-m3WrJiRs4t8
208	!pWsdJYvpdmDULVhQtX:localhost	m.room.topic		$7qFBn6lW7C0hRYBTRjR0tsE8qpZmodqh6LOyLL0HMnQ
209	!pWsdJYvpdmDULVhQtX:localhost	m.room.member	@mm_mattermost_a:localhost	$d7sJ6Squy3gHlaCn4UxGeu_9AcN2XCBHtBIY8VL5d_g
210	!pWsdJYvpdmDULVhQtX:localhost	m.room.topic		$8lVZQlOM-qXD0dT5ZSbvlEPAQPq5wJHU8KqM6sLfmWM
211	!pWsdJYvpdmDULVhQtX:localhost	m.room.topic		$OsJU_fxidXD79b8VmXNcxdAdUkhXO3S73zUBYUa3yG8
212	!BfSgfecvJnYoZjTYRA:localhost	m.room.member	@matrix_b:localhost	$76OhaN_mof41kiqxA-qZV26DgKxkvkl8JwQjOYqZF1A
213	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$ookqlSa7mnlrdjzkLacPnjSeTMaz_ziKTujCG08tNtY
214	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$1WtE7dVviGcbaiXXiFzC_D6MPYLxmoG1bruTjhL7QPo
215	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$JHt8yTopbTnKQirNm2sUE-VO7nB-MVB3RgH9verjZMg
216	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$nzb8jklpQULzsHkg4ennbYTa1tFDzoRANqT7bEyCjbA
217	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$p1LKjB3_qxYduEcevuH3VHzGF50_gElPoXuVVES5yHE
218	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$ZYGFeG9k8oN8K78yvTrPSRQqFTlQlpjQ1u5R7MqMPVA
219	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$P2KNNp8BWcW0lwfmH6dv372FWmuCgD99YCxCirX_24k
220	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$CWcoz4q_uaaPYjIBIT5AnxMCONxUVoQmYk5Xi63PLhY
221	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$q1S0plqlWdpoHUV2MVfoJxX6VYu6lrcUIn5NouxrpN0
222	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1.mm:localhost	$43QkdEfEt7HKU_yuu_ONjHdGvfspcdQxX0ILS-l32Lk
223	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$Q0T53MXV2c1xyXUhHQk9c1RZhAPQb9Fxeg0Iim8HVGI
224	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1.mm:localhost	$PiJldnZIgnFLIsld4eQJRt4skJs87a9EhFd79MaBh34
225	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1.mm:localhost	$8EVF40qVJdh_jFfIm0kpugtOGrkf8t4yfwNxGL2qglY
226	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1.mm:localhost	$yNwq_TRKKZiOjbNxMXFXsQQizcrEK5hSGwM7Zgz_2NI
227	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1.mm:localhost	$n8XAvet9BwdXJkiaa9FRb1XFDtAfiN5htf7Mt-TLyyk
228	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$ZzKnXCDFEY7C0J9-HRH16wVfaSqT5NQwHxlzlHeghJY
229	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1.mm:localhost	$NgiM496CKzyo9mL0iB4twnILOiI0iSVxNrfJ7ZevEvk
230	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$l4NrZ0A1RlAEQON9EsKRRgnffUWoAoaqefApPQ1VY6Q
231	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$6u6Tz1Elg1k0KgrBWCYX4EDuAIY3cYzC9QGb-TbZ7VY
232	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1.mm:localhost	$3by9dlJt9SeJ0Blyu5DdOV8mFnseUXul8FrpNJLCCw0
233	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$JUtF9FhG78XWw5WA9iAP5HYKGKF4Lu8Vw2GCQnxLG4Q
234	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$-uge4wQUpCVHb-wsXi_7jIe8TtKm7AkwVvQgvUriRCc
235	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1.mm:localhost	$uZjmYz-4nC5dNxkULv7dOuefYufe4J-RoiyOqO0_--U
236	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$j1SzTn_a2DmIy9kS9tEvYrWWaQPK9qDw8bE1b5u5tUQ
237	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$10QOTDSxlbUls_ztcz8_snwMb_C6O6J_0eVPeWmNzYA
238	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$sirplViWe5LOuGNWLxn1taMZ3vMapdBt6rkX7v4w3nE
239	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@matterbot:localhost	$Z4EEzzSh-PPixQJa0Qd4nqnNgsNmpgWV5sw19ibyHRU
240	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@matterbot:localhost	$RCc2BKAAU0xwFEG7lPJnGfuRSd6yEi3q_Hc0zskLWug
241	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$8ZM7qMbEwWVaBlf-c9rlwby2-b7Dga2c6Zq40K2y_-w
242	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$Y9fHVplXv4p1AuIF3N9eYKbSXiAzmmQ7rMlmdImX_h0
243	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$fU6KcQxNHMHMFBncKMc_sINH1LqRfLEjo6QY14pHz1c
244	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$SShu50vkA4_WUgVAD_tyo9Yj35ASKebFSp7AIlE3jGg
245	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$91QQ5eIIQ380-EfpFRVOStoHkmr7iUuurx-i65rNe1A
246	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$WfhmMlJ8a7LCyZxNPwaJjoEsoa7DPivbliXuvxSpB-s
247	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$kLb0d3AeHTWwU_JSvGXIthWm6OdK1fhUSMS48kLhBy8
248	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1.mm:localhost	$uZJ96yTaWnBxdnDWLoQZBSa5v3bgKYYTQyk1te6MbRU
249	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$4pz6RI3cOq_sk23rZLxlCRxSlVG4odWIhb_Tmb7BBI8
250	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1.mm:localhost	$ui8Q0MTwyJJ8SkQUPXZqMuqIjSJAdgnZmv3lCs7fD7U
251	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1.mm:localhost	$denY4rFY5cmKVZ61qJvrbB3p-zpnNz9JI_c1v_jz8DY
252	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_b:localhost	$ZT3nsIEkD4jwuM954BWMPocL1KIhPb2YkxYq437nvZ4
253	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1.mm:localhost	$MgQYTFCTdU6NmtK0alkF0fLBwrWRdhnwWEYBSDO4oN8
254	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1.mm:localhost	$-cbPq-8i3jW3wAGXaaULCmiAxnvt62LeKUzLEwRsLZ8
255	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$DJkoyDnNKzOMoyHXrwhjjIbc4sr4c5qa-vTsu-ygWCU
256	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_mattermost_a:localhost	$lH8GYoDuYR02R2s1IZ1HjSkEZKVS9k4kBhr3Ziw7yAs
257	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_user1.mm:localhost	$i-KO6Y_sF828IyugytSgKTsKwvvPAuBsxMaTwO9OwRg
258	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$dzRbCjhdfng5Zgo28lrRG79oXzyKPf6oSiRKAILTlCg
259	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1.mm:localhost	$pB0oSMJNS80mro5VRDn22HDuGjrnC_5SS4HpB5U1jhE
260	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$RjgQaQlqYefKt2GpPWViIE6ElEwoyG9XEPqKHOLzmvU
261	!kmbTYjjsDRDHGgVqUP:localhost	m.room.member	@mm_user1.mm:localhost	$Tp5Xk31fuSoiVwlSwbCCKZ0iJQbAldbQaWAUepdvy8c
262	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_b:localhost	$tLgjtE9lAPSNjvmOJBE4UHVA__vQ0h3zR31FzvP-EB8
263	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$GiTnYg2qbL0NhYXAeF9O7JtJolDGTTykooymchZRUoU
264	!dKcbdDATuwwphjRPQP:localhost	m.room.member	@mm_mattermost_a:localhost	$1KDpgMHGbPRR_uwUkSHBNQCOaydIzh70Tr8oR3YNpVg
266	!cUrTzQWGYNmZYMHoGB:localhost	m.room.create		$XhE1A2QtMIi_b9SfK9jbadCTQ4Xd5IZxBaUOcfglbIA
267	!cUrTzQWGYNmZYMHoGB:localhost	m.room.member	@user1.matrix:localhost	$Ip3uw4uae3e7xwaJ6BU2ppE2nWhA0Zyb0KZDNvHAdmU
268	!cUrTzQWGYNmZYMHoGB:localhost	m.room.power_levels		$nofByIO1FFs8JcKVqFZb7ulSmWdVGm_V-3n-LceVmnw
269	!cUrTzQWGYNmZYMHoGB:localhost	m.room.canonical_alias		$wtg0qf-MdY5Ur4UMAlOlQ58df82OmKhsbTS81ItsAT8
270	!cUrTzQWGYNmZYMHoGB:localhost	m.room.join_rules		$DFCNP6Tt2ypS8tXyd5kaCiqWeVDmE_FL-iOprkrfubk
271	!cUrTzQWGYNmZYMHoGB:localhost	m.room.guest_access		$MJ2YTkP3f-eQwc5HLB6GVzjnPJaVov0pUCfq1bWqG3M
272	!cUrTzQWGYNmZYMHoGB:localhost	m.room.history_visibility		$iAAlBelGypnsbVKn9Fd-ubLNje326TRpaegoLLyRZGY
273	!cUrTzQWGYNmZYMHoGB:localhost	m.room.name		$34bSEXw9U2DTNkZA2he27rczptl3jni1oG64GRRYkfY
274	!cUrTzQWGYNmZYMHoGB:localhost	m.room.topic		$SFXqj2UcfZU2XtnGBtupMwsoI3Z5JLp-7mmR2PU4MjQ
278	!FSwSlJXpOZZONTVfGs:localhost	m.room.create		$VI4y-gfFPbzFuAM6S6F4gXfpeWta-thThcGlPN0xQN0
282	!hccoYOyrWRMEhMnaoh:localhost	m.room.member	@user1.matrix:localhost	$RRFtexNdS-wxfmZgcU9kk5Lyp462lIuVu6piimDKCGA
298	!hccoYOyrWRMEhMnaoh:localhost	m.room.history_visibility		$-FXdMAkllHkSbPP-QDGsb_zIuCwPKR511zZahmMGKs4
279	!hccoYOyrWRMEhMnaoh:localhost	m.room.create		$LnGTvN89zWMaGdr_8T22TNwZ8hCnAeMlGOMaGpCPahE
280	!JGJhGNDoMdRLJzLgcJ:localhost	m.room.create		$A45QtHYoTPEA17jEFQZ4U882WGuYFA2D4xiKqwnZyUs
284	!FSwSlJXpOZZONTVfGs:localhost	m.room.power_levels		$4ywygf1-17_Kq3j230bjqgAjdpc67zV0hIv7Uw6BKtA
286	!JGJhGNDoMdRLJzLgcJ:localhost	m.room.power_levels		$MLY05F5LyQaOuJw4avembMABTu_CtFuQyhyiF14QtYo
289	!FSwSlJXpOZZONTVfGs:localhost	m.room.guest_access		$Y_182-w64pn902ATtlukjIsNSzVBtF9fw_aMYWx9DdY
291	!hccoYOyrWRMEhMnaoh:localhost	m.room.join_rules		$4MpBsW-eFJ4SoVP-rLgkefjkNR0Sytuayop2Z-OBFzU
299	!JGJhGNDoMdRLJzLgcJ:localhost	m.room.name		$UEYdHpguNtwCDIQ9fsK7537cGDuKB-9QPh7SJsYm6lQ
301	!hccoYOyrWRMEhMnaoh:localhost	m.room.name		$sUchhgur-fFKVUmMUaBERmjM3ItMz4-8bhkuD7UXnuU
303	!cUrTzQWGYNmZYMHoGB:localhost	m.space.child	!JGJhGNDoMdRLJzLgcJ:localhost	$z3x2QWsqd2WeWbha161nzCLfGv7psz2SV_Gveo8B5Yk
281	!FSwSlJXpOZZONTVfGs:localhost	m.room.member	@user1.matrix:localhost	$Z-W9-QEq_roRPUfFFGrVn3vc_d4uekRlcsL3uBSdDpM
285	!FSwSlJXpOZZONTVfGs:localhost	m.room.join_rules		$CjB4vCnMjTm70a0EahGjB5FN8EKtrdWl7F12gA2FhDo
292	!FSwSlJXpOZZONTVfGs:localhost	m.space.parent	!cUrTzQWGYNmZYMHoGB:localhost	$27FTfsExd-igZozi1nKpy5Iyqayuxc3DZY9LFN9e6oo
296	!hccoYOyrWRMEhMnaoh:localhost	m.space.parent	!cUrTzQWGYNmZYMHoGB:localhost	$NYaJba-K1Im8n6_Z7mL0VwgIAKxZqouzTTYu6EcK5eM
283	!JGJhGNDoMdRLJzLgcJ:localhost	m.room.member	@user1.matrix:localhost	$uDBLcAyAHq3swiKjGlyKYFZwIrP5Ux8Ki1qU7x3aVsY
288	!JGJhGNDoMdRLJzLgcJ:localhost	m.room.join_rules		$e6pVgV1MsH-6_A1V_vGWGmdznPg_czNOfblinyTHshA
295	!FSwSlJXpOZZONTVfGs:localhost	m.room.history_visibility		$33Pk__-gU3AslKMgHWQqdrgfvEhGtn4nPTRaDuhZUC0
300	!FSwSlJXpOZZONTVfGs:localhost	m.room.name		$bgbjmgXAlLz069pieqVTP8KTcxXHvT72ZwdRr71Fnqg
304	!cUrTzQWGYNmZYMHoGB:localhost	m.space.child	!hccoYOyrWRMEhMnaoh:localhost	$___RsdFndwWsVVLqEZmb4-TWJG-e1GJLt_3bnf1dFu8
287	!hccoYOyrWRMEhMnaoh:localhost	m.room.power_levels		$nMtE3MPK3rxeHXzgEF1GWQXqF1Of8IqoWwPKejXxdrg
290	!JGJhGNDoMdRLJzLgcJ:localhost	m.room.guest_access		$hNUZNFVPWjQzoWmc5wymfJzaTuaIdxyWFsi3fkTJ534
294	!JGJhGNDoMdRLJzLgcJ:localhost	m.space.parent	!cUrTzQWGYNmZYMHoGB:localhost	$IYkBkm-ncU_4Z-Ft8v80LsrK5kKpzGKpHDUWZxxy6t8
297	!JGJhGNDoMdRLJzLgcJ:localhost	m.room.history_visibility		$JfR9TVM-sEe4hZ5-0bIni5e5m_tLlX2HdSU6u6IoVBM
293	!hccoYOyrWRMEhMnaoh:localhost	m.room.guest_access		$5QgMOlhzvtIooZVNYnMnchsgiEUDObBacU41JO2zKs0
302	!cUrTzQWGYNmZYMHoGB:localhost	m.space.child	!FSwSlJXpOZZONTVfGs:localhost	$OUsS0radBRPS3B8beUIJ1TUjFMPXJ0OTtSau2wSu6rY
\.


--
-- Data for Name: stats_incremental_position; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.stats_incremental_position (lock, stream_id) FROM stdin;
X	119
\.


--
-- Data for Name: stream_ordering_to_exterm; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.stream_ordering_to_exterm (stream_ordering, room_id, event_id) FROM stdin;
20	!kmbTYjjsDRDHGgVqUP:localhost	$PkPxRt8GuXFqdWre9vyhqKHlRSqflC0cOSTBOims4qY
21	!dKcbdDATuwwphjRPQP:localhost	$jyfZsVYOTCt8az1WqRlL53b1lAQWjIj6-IvW1w3qYks
22	!kmbTYjjsDRDHGgVqUP:localhost	$ARxMI5-TIkg2afPIDJsLgeSqCdrfbwBxm32e83QRfQ4
23	!dKcbdDATuwwphjRPQP:localhost	$nE3KmrZJdWnhQ2h6DgIB98qoLGnQlFFCvgSu4NS5FfA
24	!kmbTYjjsDRDHGgVqUP:localhost	$mlRlSJ1S_x5OctD_Nck7tq-Fo2IC7iOhysac1uYo_PY
25	!dKcbdDATuwwphjRPQP:localhost	$Y86Vdmx2z1nvkEoTqBH7oAiLE_sHPFtNgI97gsUAwaY
26	!kmbTYjjsDRDHGgVqUP:localhost	$pXbc3VIu5b4O4VzPRePQd4FjtqYPJLH87Ss7pZM-gRM
27	!kmbTYjjsDRDHGgVqUP:localhost	$q7m8fkdDrp2QE9hRAHYIR_KN8htxYXW85pB3LgG-V2U
28	!dKcbdDATuwwphjRPQP:localhost	$YHxtZv4JfPzIJvBMvoTgzeITfTFFng_L_4ijJ1Q97k4
29	!dKcbdDATuwwphjRPQP:localhost	$cH796vSd1hy4UBg8XHAqeUxz-u3gxer-uMeGrsirKbs
30	!kmbTYjjsDRDHGgVqUP:localhost	$5DYqRHQPE1SQt9QXHJodWH7x4Pztz3LTsgH1kdHawZs
31	!dKcbdDATuwwphjRPQP:localhost	$TKcINA6W5qTH8raDaFqEMBivZ0LjgXtIHGvxzJ9V4_8
32	!dKcbdDATuwwphjRPQP:localhost	$REN0AaEE212pFbK8uJB-22lyjpnqTEP0SshUeVfsGU4
33	!dKcbdDATuwwphjRPQP:localhost	$AwutniYNkYl6Dxs-8zYvdPdGLIcM4Kyzaldut5D0jHQ
34	!kmbTYjjsDRDHGgVqUP:localhost	$HmGCTcPZGDbaswAPjYZ0ddKt1eWRcRq89rE-yVwDV0s
35	!kmbTYjjsDRDHGgVqUP:localhost	$VFMUBSkD_jWG8nImBQfkmffKyLBdxGMpdkFACHA33Ng
36	!dKcbdDATuwwphjRPQP:localhost	$DTQEMlxc_4_CqP-rYQ46vmCpJtEKlxw_Ugma4cnNO6w
37	!dKcbdDATuwwphjRPQP:localhost	$cIkI-00MET-_PQ4VaVFuuZsJ2WEz_UMnlXun9Itkqt8
38	!dKcbdDATuwwphjRPQP:localhost	$CsT9BKDbT6nCfiXJCOAHV90fgB6fYV4boIF3v6eEls4
39	!kmbTYjjsDRDHGgVqUP:localhost	$3Q6XqtJGvGa1jhhtRN9kQqoLIWqjikrH3x7yltwaZ6w
40	!kmbTYjjsDRDHGgVqUP:localhost	$pulJgsd1znNtSba8MCpZoXTCHhxSC0OkMutE8dDzlO0
41	!kmbTYjjsDRDHGgVqUP:localhost	$JghGsUh3v1rikXL8gETZ_UJKjZC_6NY_WEgHUWlDGUM
42	!kmbTYjjsDRDHGgVqUP:localhost	$COcCgODcXP3YBig5Vk-_QDtWh0rzx9K1yVAasfvXRVk
43	!kmbTYjjsDRDHGgVqUP:localhost	$lGC_2RlgCMjLDCMd4bkjzCmXnXFQHNvnd9eFy28BE8E
44	!kmbTYjjsDRDHGgVqUP:localhost	$iPEm9yDTEtMvd-r8SFs0eTz8dpjdWAFHcpWpOTKCqkk
45	!kmbTYjjsDRDHGgVqUP:localhost	$Ay9Au4hI33NjvpwrmfU6OSnS-_gSjFb5bRzB6756wKo
46	!kmbTYjjsDRDHGgVqUP:localhost	$szFQBuhhfXcOIlgReai0669p3ycU-w57s91VHUKWXFA
47	!kmbTYjjsDRDHGgVqUP:localhost	$pec3QOL9YU-4d4ww5taJYfFCSKUcMIUYBRSHQoML6Vw
48	!kmbTYjjsDRDHGgVqUP:localhost	$ckvkcjvKmxJljo0NX3W1BFf-JQMuUnFbh-r9CNPtmR4
49	!kmbTYjjsDRDHGgVqUP:localhost	$Ss566NPFclWN6Mx7hHv8fd_JaawsG1AuM6gnlM7fA-k
50	!kmbTYjjsDRDHGgVqUP:localhost	$focovH6Yc-m2CXhjrx4lhMQHQhQODpLp4g1sKHOxfaU
51	!kmbTYjjsDRDHGgVqUP:localhost	$Y8T81hxoxP5Ta-IxCarhZjMk4fWMtcg9FlgmTG9VgiE
52	!kmbTYjjsDRDHGgVqUP:localhost	$RVi3Hrw_NGpZOOlLIRSt-m_lPWPYt0K7JLecNmlU1Sw
53	!BfSgfecvJnYoZjTYRA:localhost	$NfGFxRqIrSmaeLcN53BGirnWzJ1bpwzVyt2oZw2cj1k
54	!BfSgfecvJnYoZjTYRA:localhost	$7N18oPwd46twVh-RWhED6VAPm79aIXVCh_BVUFAFHP8
55	!BfSgfecvJnYoZjTYRA:localhost	$eKvf8PFaZwsEOXW-IIYTGZwl6gxEYmEE2TalB5k2iGs
56	!BfSgfecvJnYoZjTYRA:localhost	$ZraIWv18CC1pTAGQZToI1ZXr7ki_53OY_jvQl0RDE_A
57	!BfSgfecvJnYoZjTYRA:localhost	$Uf6bLI9lxBnR9TJvz8fcfo-1_wbshzMvT4Ecr_qy-E4
58	!BfSgfecvJnYoZjTYRA:localhost	$30q15kBxfYB9Dyc1sAhoNXYpZXfDlneq4Ckvuz_Sy1Y
59	!BfSgfecvJnYoZjTYRA:localhost	$wlATKVSoZpEXfwFpmdptZK6V2TMFQ87Bjjhru1P3dGs
60	!BfSgfecvJnYoZjTYRA:localhost	$PZkmtd-Zj4an2Acc9O8V-mK2mVxXChviZhd_hsf6Ehg
61	!BfSgfecvJnYoZjTYRA:localhost	$ZF1U_gGvucrvqj1m7ffy4HKGxUsoAbYKpWzUjaPqlMM
62	!pWsdJYvpdmDULVhQtX:localhost	$pIVIlPgvO-fbiW31dx4GB-wsRX4DrbADDn1AfJoXI50
63	!pWsdJYvpdmDULVhQtX:localhost	$bWqW6N4T6ZlJ3MzEaI-MgqdvMEklGrNsy22WqL6ZgOc
64	!pWsdJYvpdmDULVhQtX:localhost	$ngKTLt0SDFtdjkF6GnjahEcDA-qLwTKRcVgMgMg5tN8
65	!pWsdJYvpdmDULVhQtX:localhost	$IxyNn3A4NegMug4xc7O0sm2s1r9jyybU5iNogwEGesQ
66	!pWsdJYvpdmDULVhQtX:localhost	$SQpUzgCCeFIrGC3eCPDX_U021w7MG0-lHOxFTcHbvKk
67	!pWsdJYvpdmDULVhQtX:localhost	$pe2Yi2ila5QgzVKIEGGAIeqvcRaD37GUFMvAOWX2tp0
68	!pWsdJYvpdmDULVhQtX:localhost	$_MdWHbg9mI3zN-WDGIpwDRJZmDWXBeW-m3WrJiRs4t8
69	!pWsdJYvpdmDULVhQtX:localhost	$7qFBn6lW7C0hRYBTRjR0tsE8qpZmodqh6LOyLL0HMnQ
70	!pWsdJYvpdmDULVhQtX:localhost	$d7sJ6Squy3gHlaCn4UxGeu_9AcN2XCBHtBIY8VL5d_g
71	!pWsdJYvpdmDULVhQtX:localhost	$xCubuHnQAGuDuGdlqiquXK0QRxhOWKTh5TJZZGcL09Q
72	!pWsdJYvpdmDULVhQtX:localhost	$8lVZQlOM-qXD0dT5ZSbvlEPAQPq5wJHU8KqM6sLfmWM
73	!pWsdJYvpdmDULVhQtX:localhost	$OsJU_fxidXD79b8VmXNcxdAdUkhXO3S73zUBYUa3yG8
74	!pWsdJYvpdmDULVhQtX:localhost	$JWIcDwBleupt991UzmNH_DSdEWQPePa6uEyU2J0-ldM
75	!BfSgfecvJnYoZjTYRA:localhost	$76OhaN_mof41kiqxA-qZV26DgKxkvkl8JwQjOYqZF1A
76	!dKcbdDATuwwphjRPQP:localhost	$8_ljUg0y31H3DwB8UeZyPs3Vlh_4zdSmAkWCsBDCc98
77	!dKcbdDATuwwphjRPQP:localhost	$UlpkVhx0UMdfV3JIISqctfZ_aMoIkpmIqcfxcCxxRL8
78	!dKcbdDATuwwphjRPQP:localhost	$_B6Ln541gYqlnaEaxAcSwy46yBXDxkldNhRG8HdrPBs
79	!dKcbdDATuwwphjRPQP:localhost	$grj8CepyvbRzzkLI4auscQ640Z-NssUGE9TSsXkp690
80	!dKcbdDATuwwphjRPQP:localhost	$oakhKpEqFw5Icor6iY_TRMQljV-HWQ3lueP0Vlm9hIY
81	!cUrTzQWGYNmZYMHoGB:localhost	$XhE1A2QtMIi_b9SfK9jbadCTQ4Xd5IZxBaUOcfglbIA
82	!cUrTzQWGYNmZYMHoGB:localhost	$Ip3uw4uae3e7xwaJ6BU2ppE2nWhA0Zyb0KZDNvHAdmU
87	!cUrTzQWGYNmZYMHoGB:localhost	$iAAlBelGypnsbVKn9Fd-ubLNje326TRpaegoLLyRZGY
88	!cUrTzQWGYNmZYMHoGB:localhost	$34bSEXw9U2DTNkZA2he27rczptl3jni1oG64GRRYkfY
89	!cUrTzQWGYNmZYMHoGB:localhost	$SFXqj2UcfZU2XtnGBtupMwsoI3Z5JLp-7mmR2PU4MjQ
90	!FSwSlJXpOZZONTVfGs:localhost	$VI4y-gfFPbzFuAM6S6F4gXfpeWta-thThcGlPN0xQN0
91	!hccoYOyrWRMEhMnaoh:localhost	$LnGTvN89zWMaGdr_8T22TNwZ8hCnAeMlGOMaGpCPahE
92	!JGJhGNDoMdRLJzLgcJ:localhost	$A45QtHYoTPEA17jEFQZ4U882WGuYFA2D4xiKqwnZyUs
93	!FSwSlJXpOZZONTVfGs:localhost	$Z-W9-QEq_roRPUfFFGrVn3vc_d4uekRlcsL3uBSdDpM
95	!JGJhGNDoMdRLJzLgcJ:localhost	$uDBLcAyAHq3swiKjGlyKYFZwIrP5Ux8Ki1qU7x3aVsY
110	!hccoYOyrWRMEhMnaoh:localhost	$-FXdMAkllHkSbPP-QDGsb_zIuCwPKR511zZahmMGKs4
94	!hccoYOyrWRMEhMnaoh:localhost	$RRFtexNdS-wxfmZgcU9kk5Lyp462lIuVu6piimDKCGA
116	!cUrTzQWGYNmZYMHoGB:localhost	$OUsS0radBRPS3B8beUIJ1TUjFMPXJ0OTtSau2wSu6rY
116	!cUrTzQWGYNmZYMHoGB:localhost	$z3x2QWsqd2WeWbha161nzCLfGv7psz2SV_Gveo8B5Yk
116	!cUrTzQWGYNmZYMHoGB:localhost	$___RsdFndwWsVVLqEZmb4-TWJG-e1GJLt_3bnf1dFu8
117	!hccoYOyrWRMEhMnaoh:localhost	$almCp-spfN30ITGsQkwvqZtOB3TVD17i4DcwiaswR4E
100	!JGJhGNDoMdRLJzLgcJ:localhost	$JfR9TVM-sEe4hZ5-0bIni5e5m_tLlX2HdSU6u6IoVBM
105	!FSwSlJXpOZZONTVfGs:localhost	$33Pk__-gU3AslKMgHWQqdrgfvEhGtn4nPTRaDuhZUC0
111	!JGJhGNDoMdRLJzLgcJ:localhost	$UEYdHpguNtwCDIQ9fsK7537cGDuKB-9QPh7SJsYm6lQ
114	!cUrTzQWGYNmZYMHoGB:localhost	$___RsdFndwWsVVLqEZmb4-TWJG-e1GJLt_3bnf1dFu8
118	!hccoYOyrWRMEhMnaoh:localhost	$FJVN_jtSz6ZNRLKTCrfOqY0M69xPDbu_hr4GTuB_3u8
119	!kmbTYjjsDRDHGgVqUP:localhost	$PfXwdx6I54mC3f0Zd8nOukV5nTCxL7uRQKGn3Bxg17Y
112	!hccoYOyrWRMEhMnaoh:localhost	$sUchhgur-fFKVUmMUaBERmjM3ItMz4-8bhkuD7UXnuU
113	!FSwSlJXpOZZONTVfGs:localhost	$bgbjmgXAlLz069pieqVTP8KTcxXHvT72ZwdRr71Fnqg
\.


--
-- Data for Name: stream_positions; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.stream_positions (stream_name, instance_name, stream_id) FROM stdin;
events	master	119
account_data	master	67
presence_stream	master	845
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
@admin:localhost	WCSUBIGVWG	1673913600000	PostmanRuntime/7.30.0
@user1.matrix:localhost	OXBKVBOLVC	1673913600000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36
@user1.matrix:localhost	QDBOSXPKXK	1673913600000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36
@matrix_b:localhost	DJFHSWMXLW	1673913600000	Playwright/1.29.2 (x64; macOS 12.6) node/18.2
@user1.matrix:localhost	OXBKVBOLVC	1674000000000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36
@user1.matrix:localhost	WMNHMANJWT	1674000000000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36
@user1.matrix:localhost	QHRMHKJLQA	1674000000000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36
@user1.matrix:localhost	VLVGWECQKM	1674000000000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36
@user1.matrix:localhost	MOYNZNSLTL	1674086400000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36
@user1.matrix:localhost	MOYNZNSLTL	1674172800000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36
@user1.matrix:localhost	GHIOXGFALI	1674172800000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36
\.


--
-- Data for Name: user_directory; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_directory (user_id, room_id, display_name, avatar_url) FROM stdin;
@admin:localhost	\N	admin	\N
@matrix_a:localhost	\N	matrix_a	\N
@matrix_b:localhost	\N	matrix_b	\N
@ignored_user:localhost	\N	ignored_user	\N
@user1.matrix:localhost	\N	User 1 - Matrix	\N
\.


--
-- Data for Name: user_directory_search; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_directory_search (user_id, vector) FROM stdin;
@admin:localhost	'admin':1A,3B 'localhost':2
@matrix_a:localhost	'localhost':2 'matrix':1A,3B
@matrix_b:localhost	'b':2A,5B 'localhost':3 'matrix':1A,4B
@ignored_user:localhost	'ignor':1A,4B 'localhost':3 'user':2A,5B
@user1.matrix:localhost	'1':4B 'localhost':2 'matrix':5B 'user':3B 'user1.matrix':1A
\.


--
-- Data for Name: user_directory_stream_pos; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_directory_stream_pos (lock, stream_id) FROM stdin;
X	119
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
user1.matrix	0	\\x7b22726f6f6d223a7b227374617465223a7b226c617a795f6c6f61645f6d656d62657273223a747275657d7d7d
user1.matrix	1	\\x7b22726f6f6d223a7b227374617465223a7b226c617a795f6c6f61645f6d656d62657273223a747275657d2c2274696d656c696e65223a7b22756e726561645f7468726561645f6e6f74696669636174696f6e73223a747275657d7d7d
\.


--
-- Data for Name: user_ips; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_ips (user_id, access_token, device_id, ip, user_agent, last_seen) FROM stdin;
@admin:localhost	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjNjaWQgdXNlcl9pZCA9IEBhZG1pbjpsb2NhbGhvc3QKMDAxNmNpZCB0eXBlID0gYWNjZXNzCjAwMjFjaWQgbm9uY2UgPSBXVU9yUTVRMFRnUkNjME1ACjAwMmZzaWduYXR1cmUgdYKA-yuTQ5JV5O0HWRak-48xavOYgA1MMc6A1V_Uw5kK	WCSUBIGVWG	172.16.238.1	PostmanRuntime/7.30.0	1673967222026
@matrix_b:localhost	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjZjaWQgdXNlcl9pZCA9IEBtYXRyaXhfYjpsb2NhbGhvc3QKMDAxNmNpZCB0eXBlID0gYWNjZXNzCjAwMjFjaWQgbm9uY2UgPSBBYl9hbWthI0daSzgtfjdICjAwMmZzaWduYXR1cmUgOReBLkPURCMNtzORS9fpogQqVa3IWN9ZEu5gXW91QTMK	DJFHSWMXLW	172.16.238.1	Playwright/1.29.2 (x64; macOS 12.6) node/18.2	1673974498823
@user1.matrix:localhost	syt_dXNlcjEubWF0cml4_VqtNUUcGLOCpwzTNKNfq_1iVBTx	OXBKVBOLVC	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	1674028648804
@user1.matrix:localhost	syt_dXNlcjEubWF0cml4_qDHrxVilscoXsedRWqoZ_2sHRVt	QHRMHKJLQA	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	1674029310897
@user1.matrix:localhost	syt_dXNlcjEubWF0cml4_FpgmWTtaBUkHEYnAakMh_1z2rBX	WMNHMANJWT	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	1674058596943
@user1.matrix:localhost	syt_dXNlcjEubWF0cml4_lxQEDeFsbPycHuLjqHFR_3s5Ihw	VLVGWECQKM	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36	1674060056633
@user1.matrix:localhost	syt_dXNlcjEubWF0cml4_GrDyxoNglBiIvpSZUakQ_2VzLnb	QDBOSXPKXK	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36	1673972949141
@user1.matrix:localhost	syt_dXNlcjEubWF0cml4_qqcPIFFfNKFPtSyPUCKf_2ujTev	MOYNZNSLTL	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	1674203635880
@user1.matrix:localhost	syt_dXNlcjEubWF0cml4_WuMhLkzYQyELybWBPaHy_1xnzph	GHIOXGFALI	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	1674211580407
\.


--
-- Data for Name: user_signature_stream; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_signature_stream (stream_id, from_user_id, user_ids) FROM stdin;
11	@user1.matrix:localhost	["@user1.matrix:localhost"]
14	@user1.matrix:localhost	["@user1.matrix:localhost"]
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
@mm_mattermost_a:localhost	2	28
@mm_mattermost_b:localhost	2	29
@mm_user1.mm:localhost	2	35
@user1.matrix:localhost	8	95
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
@user1.matrix:localhost	email	user1.matrix@localhost	1673967243610	1673967243611
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.users (name, password_hash, creation_ts, admin, upgrade_ts, is_guest, appservice_id, consent_version, consent_server_notice_sent, user_type, deactivated, shadow_banned, consent_ts, approved) FROM stdin;
@matrix_a:localhost	$2b$12$V8cOJ670WikSre/C66CGI.a1ANkbEvkgYEUW.M23dlUnekRcPr08O	1598686327	0	\N	0	\N	\N	\N	\N	0	\N	\N	\N
@matrix_b:localhost	$2b$12$gnHJ1cdN/bfA2A2V61rPauepmeV2dLXr/pC70rCZy9qZoM9u2GKaq	1598686327	0	\N	0	\N	\N	\N	\N	0	\N	\N	\N
@ignored_user:localhost	$2b$12$cDOaADzxfGcFFspSrfJNcueOwevhD2Ex0hu6oAJcpz3S/owrOeSsW	1598686327	0	\N	0	\N	\N	\N	\N	0	\N	\N	\N
@matterbot:localhost		1673965922	0	\N	0	xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	\N	\N	\N	0	f	\N	\N
@mm_mattermost_a:localhost		1673966481	0	\N	0	xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	\N	\N	\N	0	f	\N	\N
@mm_mattermost_b:localhost		1673966482	0	\N	0	xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	\N	\N	\N	0	f	\N	\N
@admin:localhost	$2b$12$y3lT6nJGWMTXBWF2kFRaRuUqALWaFe.dhbEEBKROoFnkoKBuDnLhK	1598686326	1	\N	0	\N	\N	\N	\N	0	\N	\N	\N
@user1.matrix:localhost	$2b$12$dn0uD1PzPVDtwslAtg23hepHxhJwad91qmniMChIoL.HbUr2myPSe	1673967243	0	\N	0	\N	\N	\N	\N	0	f	\N	\N
@mm_user1.mm:localhost		1673969011	0	\N	0	xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	\N	\N	\N	0	f	\N	\N
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
@user1.matrix:localhost	!kmbTYjjsDRDHGgVqUP:localhost
@user1.matrix:localhost	!dKcbdDATuwwphjRPQP:localhost
@user1.matrix:localhost	!BfSgfecvJnYoZjTYRA:localhost
@user1.matrix:localhost	!pWsdJYvpdmDULVhQtX:localhost
@user1.matrix:localhost	!cUrTzQWGYNmZYMHoGB:localhost
@user1.matrix:localhost	!JGJhGNDoMdRLJzLgcJ:localhost
@user1.matrix:localhost	!FSwSlJXpOZZONTVfGs:localhost
@user1.matrix:localhost	!hccoYOyrWRMEhMnaoh:localhost
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

SELECT pg_catalog.setval('public.account_data_sequence', 67, true);


--
-- Name: application_services_txn_id_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.application_services_txn_id_seq', 41, true);


--
-- Name: cache_invalidation_stream_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.cache_invalidation_stream_seq', 304, true);


--
-- Name: device_inbox_sequence; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.device_inbox_sequence', 1, true);


--
-- Name: event_auth_chain_id; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.event_auth_chain_id', 84, true);


--
-- Name: events_backfill_stream_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.events_backfill_stream_seq', 1, true);


--
-- Name: events_stream_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.events_stream_seq', 119, true);


--
-- Name: instance_map_instance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.instance_map_instance_id_seq', 1, false);


--
-- Name: presence_stream_sequence; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.presence_stream_sequence', 845, true);


--
-- Name: receipts_sequence; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.receipts_sequence', 5, true);


--
-- Name: state_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.state_group_id_seq', 304, true);


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
-- Name: event_push_summary_unique_index; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX event_push_summary_unique_index ON public.event_push_summary USING btree (user_id, room_id);


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

