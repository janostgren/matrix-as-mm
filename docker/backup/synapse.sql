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
-- Name: un_partial_stated_event_stream; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.un_partial_stated_event_stream (
    stream_id bigint NOT NULL,
    instance_name text NOT NULL,
    event_id text NOT NULL,
    rejection_status_changed boolean NOT NULL
);


ALTER TABLE public.un_partial_stated_event_stream OWNER TO synapse;

--
-- Name: un_partial_stated_event_stream_sequence; Type: SEQUENCE; Schema: public; Owner: synapse
--

CREATE SEQUENCE public.un_partial_stated_event_stream_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.un_partial_stated_event_stream_sequence OWNER TO synapse;

--
-- Name: un_partial_stated_room_stream; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.un_partial_stated_room_stream (
    stream_id bigint NOT NULL,
    instance_name text NOT NULL,
    room_id text NOT NULL
);


ALTER TABLE public.un_partial_stated_room_stream OWNER TO synapse;

--
-- Name: un_partial_stated_room_stream_sequence; Type: SEQUENCE; Schema: public; Owner: synapse
--

CREATE SEQUENCE public.un_partial_stated_room_stream_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.un_partial_stated_room_stream_sequence OWNER TO synapse;

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
5	@matterbot:localhost	PWRMYRIUQD	syt_bWF0dGVyYm90_vkekktqzNkwiqXWPhANf_1h5Lgs	\N	\N	1675957082697	\N	f
4	@user1.matrix:localhost	TVVUNPJUJZ	syt_dXNlcjEubWF0cml4_LDaxTViGjdehvJXyYkMx_0MwbKp	\N	\N	1675956811546	\N	t
6	@mm_user1.mm:localhost	RQAXSULDUM	syt_bW1fdXNlcjEubW0_ZqfhoUgkNwRquoGGFsGK_40NMNW	\N	\N	1676646214890	\N	f
7	@mm_user1.mm:localhost	CTHQGTXACR	syt_bW1fdXNlcjEubW0_TwulhcELLSVFPjIfNctJ_4eluOc	\N	\N	1676646295819	\N	f
8	@mm_user1.mm:localhost	PKQQWLAPGS	syt_bW1fdXNlcjEubW0_nFFwEHNyVMAHnsVZrErr_2Zye67	\N	\N	1676646295827	\N	f
2	@admin:localhost	OZJZGYFHKP	syt_YWRtaW4_ESjBoGLaWtscFgZHsBhJ_027WFj	\N	\N	1675956521567	\N	t
\.


--
-- Data for Name: account_data; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.account_data (user_id, account_data_type, stream_id, content, instance_name) FROM stdin;
@admin:localhost	org.matrix.msc3890.local_notification_settings.LWSWGUCQHK	2	{"is_silenced":false}	\N
@admin:localhost	im.vector.analytics	4	{"pseudonymousAnalyticsOptIn":false}	\N
@user1.matrix:localhost	org.matrix.msc3890.local_notification_settings.TVVUNPJUJZ	10	{"is_silenced":false}	\N
@user1.matrix:localhost	im.vector.analytics	12	{"pseudonymousAnalyticsOptIn":false}	\N
@user1.matrix:localhost	org.matrix.msc3890.local_notification_settings.VPHDFELNLR	19	{"is_silenced":false}	\N
@admin:localhost	org.matrix.msc3890.local_notification_settings.WYMFZMMAGV	26	{"is_silenced":false}	\N
@admin:localhost	im.vector.setting.breadcrumbs	30	{"recent_rooms":["!FzTtpSkXWMPYBKHUQN:localhost","!pYSbiOyjMFsKNxSMyi:localhost"]}	\N
@user1.matrix:localhost	org.matrix.msc3890.local_notification_settings.GQUGBBJECP	37	{"is_silenced":false}	\N
@user1.matrix:localhost	im.vector.web.settings	40	{"FTUE.useCaseSelection":"Skip","SpotlightSearch.recentSearches":["!AHOiTmgdxQzlhIOUsy:localhost","!FzTtpSkXWMPYBKHUQN:localhost","!pYSbiOyjMFsKNxSMyi:localhost","!KSMzKvonSTiyePvssr:localhost","!nazZsmPypmVtBOMIti:localhost"]}	\N
@user1.matrix:localhost	im.vector.setting.breadcrumbs	41	{"recent_rooms":["!AHOiTmgdxQzlhIOUsy:localhost","!FzTtpSkXWMPYBKHUQN:localhost","!pYSbiOyjMFsKNxSMyi:localhost"]}	\N
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
73	73/20_un_partial_stated_room_stream.sql
73	73/21_un_partial_stated_room_stream_seq.sql.postgres
73	73/22_rebuild_user_dir_stats.sql
73	73/22_un_partial_stated_event_stream.sql
73	73/23_fix_thread_index.sql
73	73/23_un_partial_stated_room_stream_seq.sql.postgres
73	73/24_events_jump_to_date_index.sql
73	73/25drop_presence.sql
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
X	46
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
2	master	user_last_seen_monthly_active	\N	1675955402823
3	master	get_monthly_active_count	{}	1675955402843
4	master	user_last_seen_monthly_active	\N	1675955610624
5	master	get_monthly_active_count	{}	1675955610692
6	master	get_user_by_id	{@admin:localhost}	1675956521514
7	master	count_e2e_one_time_keys	{@admin:localhost,LWSWGUCQHK}	1675956531714
8	master	get_e2e_unused_fallback_key_types	{@admin:localhost,LWSWGUCQHK}	1675956531749
9	master	count_e2e_one_time_keys	{@admin:localhost,LWSWGUCQHK}	1675956531838
10	master	count_e2e_one_time_keys	{@admin:localhost,LWSWGUCQHK}	1675956531900
11	master	count_e2e_one_time_keys	{@admin:localhost,LWSWGUCQHK}	1675956531971
12	master	count_e2e_one_time_keys	{@admin:localhost,LWSWGUCQHK}	1675956532033
13	master	count_e2e_one_time_keys	{@admin:localhost,LWSWGUCQHK}	1675956532222
14	master	count_e2e_one_time_keys	{@admin:localhost,LWSWGUCQHK}	1675956532334
15	master	_get_bare_e2e_cross_signing_keys	{@admin:localhost}	1675956532395
16	master	count_e2e_one_time_keys	{@admin:localhost,LWSWGUCQHK}	1675956532402
17	master	_get_bare_e2e_cross_signing_keys	{@admin:localhost}	1675956532405
18	master	_get_bare_e2e_cross_signing_keys	{@admin:localhost}	1675956532423
19	master	count_e2e_one_time_keys	{@admin:localhost,LWSWGUCQHK}	1675956532511
20	master	count_e2e_one_time_keys	{@admin:localhost,LWSWGUCQHK}	1675956532670
21	master	get_aliases_for_room	{!FzTtpSkXWMPYBKHUQN:localhost}	1675956617849
22	master	cs_cache_fake	{!FzTtpSkXWMPYBKHUQN:localhost}	1675956617990
23	master	cs_cache_fake	{!FzTtpSkXWMPYBKHUQN:localhost,@admin:localhost}	1675956618161
24	master	cs_cache_fake	{!FzTtpSkXWMPYBKHUQN:localhost}	1675956618585
25	master	cs_cache_fake	{!FzTtpSkXWMPYBKHUQN:localhost}	1675956618875
26	master	get_aliases_for_room	{!pYSbiOyjMFsKNxSMyi:localhost}	1675956696631
27	master	cs_cache_fake	{!pYSbiOyjMFsKNxSMyi:localhost}	1675956696694
28	master	cs_cache_fake	{!pYSbiOyjMFsKNxSMyi:localhost,@admin:localhost}	1675956696815
29	master	cs_cache_fake	{!pYSbiOyjMFsKNxSMyi:localhost}	1675956697184
30	master	cs_cache_fake	{!pYSbiOyjMFsKNxSMyi:localhost}	1675956697410
31	master	get_user_by_access_token	{syt_YWRtaW4_HzSAvDjKsSuGPIUmeheO_19s0jm}	1675956791498
32	master	count_e2e_one_time_keys	{@admin:localhost,LWSWGUCQHK}	1675956791509
33	master	get_e2e_unused_fallback_key_types	{@admin:localhost,LWSWGUCQHK}	1675956791512
34	master	get_user_by_id	{@user1.matrix:localhost}	1675956810245
35	master	count_e2e_one_time_keys	{@user1.matrix:localhost,TVVUNPJUJZ}	1675956811075
36	master	get_e2e_unused_fallback_key_types	{@user1.matrix:localhost,TVVUNPJUJZ}	1675956811095
37	master	count_e2e_one_time_keys	{@user1.matrix:localhost,TVVUNPJUJZ}	1675956811174
38	master	count_e2e_one_time_keys	{@user1.matrix:localhost,TVVUNPJUJZ}	1675956811246
39	master	count_e2e_one_time_keys	{@user1.matrix:localhost,TVVUNPJUJZ}	1675956811305
40	master	count_e2e_one_time_keys	{@user1.matrix:localhost,TVVUNPJUJZ}	1675956811360
41	master	count_e2e_one_time_keys	{@user1.matrix:localhost,TVVUNPJUJZ}	1675956811424
42	master	count_e2e_one_time_keys	{@user1.matrix:localhost,TVVUNPJUJZ}	1675956811485
43	master	count_e2e_one_time_keys	{@user1.matrix:localhost,TVVUNPJUJZ}	1675956811540
44	master	_get_bare_e2e_cross_signing_keys	{@user1.matrix:localhost}	1675956811564
45	master	_get_bare_e2e_cross_signing_keys	{@user1.matrix:localhost}	1675956811575
46	master	_get_bare_e2e_cross_signing_keys	{@user1.matrix:localhost}	1675956811587
47	master	count_e2e_one_time_keys	{@user1.matrix:localhost,TVVUNPJUJZ}	1675956811635
48	master	count_e2e_one_time_keys	{@user1.matrix:localhost,TVVUNPJUJZ}	1675956811797
49	master	cs_cache_fake	{!pYSbiOyjMFsKNxSMyi:localhost,@user1.matrix:localhost}	1675956825894
50	master	cs_cache_fake	{!FzTtpSkXWMPYBKHUQN:localhost,@user1.matrix:localhost}	1675956838459
51	master	user_last_seen_monthly_active	\N	1675957004017
52	master	get_monthly_active_count	{}	1675957004027
53	master	get_user_by_id	{@matterbot:localhost}	1675957082626
54	master	user_last_seen_monthly_active	\N	1675957171980
55	master	get_monthly_active_count	{}	1675957171987
56	master	user_last_seen_monthly_active	\N	1675957817014
57	master	get_monthly_active_count	{}	1675957817030
58	master	user_last_seen_monthly_active	\N	1675958144869
59	master	get_monthly_active_count	{}	1675958144877
60	master	user_last_seen_monthly_active	\N	1675958682567
61	master	get_monthly_active_count	{}	1675958682579
62	master	user_last_seen_monthly_active	\N	1675970012438
63	master	get_monthly_active_count	{}	1675970012442
64	master	user_last_seen_monthly_active	\N	1675970292049
65	master	get_monthly_active_count	{}	1675970292055
66	master	user_last_seen_monthly_active	\N	1675972234370
67	master	get_monthly_active_count	{}	1675972234384
68	master	user_last_seen_monthly_active	\N	1675972353773
69	master	get_monthly_active_count	{}	1675972353787
70	master	user_last_seen_monthly_active	\N	1675972740207
71	master	get_monthly_active_count	{}	1675972740214
72	master	user_last_seen_monthly_active	\N	1675973777322
73	master	get_monthly_active_count	{}	1675973777327
74	master	user_last_seen_monthly_active	\N	1675973886615
75	master	get_monthly_active_count	{}	1675973886621
76	master	user_last_seen_monthly_active	\N	1675974380508
77	master	get_monthly_active_count	{}	1675974380514
78	master	user_last_seen_monthly_active	\N	1675974415248
79	master	get_monthly_active_count	{}	1675974415257
80	master	user_last_seen_monthly_active	\N	1675974848005
81	master	get_monthly_active_count	{}	1675974848012
82	master	user_last_seen_monthly_active	\N	1675976492855
83	master	get_monthly_active_count	{}	1675976492884
84	master	user_last_seen_monthly_active	\N	1675977967663
85	master	get_monthly_active_count	{}	1675977967680
86	master	user_last_seen_monthly_active	\N	1676645894976
87	master	get_monthly_active_count	{}	1676645894986
88	master	user_last_seen_monthly_active	\N	1676645950114
89	master	get_monthly_active_count	{}	1676645950125
90	master	cs_cache_fake	{!pYSbiOyjMFsKNxSMyi:localhost,@matterbot:localhost}	1676646214155
91	master	cs_cache_fake	{!FzTtpSkXWMPYBKHUQN:localhost,@matterbot:localhost}	1676646214156
92	master	get_user_by_id	{@mm_user1.mm:localhost}	1676646214783
93	master	cs_cache_fake	{!pYSbiOyjMFsKNxSMyi:localhost,@matterbot:localhost}	1676646296020
94	master	cs_cache_fake	{!FzTtpSkXWMPYBKHUQN:localhost,@matterbot:localhost}	1676646296028
95	master	user_last_seen_monthly_active	\N	1678032765756
96	master	get_monthly_active_count	{}	1678032765783
97	master	count_e2e_one_time_keys	{@user1.matrix:localhost,VPHDFELNLR}	1678032892647
98	master	get_e2e_unused_fallback_key_types	{@user1.matrix:localhost,VPHDFELNLR}	1678032892680
99	master	count_e2e_one_time_keys	{@user1.matrix:localhost,VPHDFELNLR}	1678032892758
100	master	count_e2e_one_time_keys	{@user1.matrix:localhost,VPHDFELNLR}	1678032892813
101	master	count_e2e_one_time_keys	{@user1.matrix:localhost,VPHDFELNLR}	1678032892870
102	master	count_e2e_one_time_keys	{@user1.matrix:localhost,VPHDFELNLR}	1678032892938
103	master	count_e2e_one_time_keys	{@user1.matrix:localhost,VPHDFELNLR}	1678032892994
104	master	count_e2e_one_time_keys	{@user1.matrix:localhost,VPHDFELNLR}	1678032893050
105	master	count_e2e_one_time_keys	{@user1.matrix:localhost,VPHDFELNLR}	1678032893101
106	master	count_e2e_one_time_keys	{@user1.matrix:localhost,VPHDFELNLR}	1678032893157
107	master	count_e2e_one_time_keys	{@user1.matrix:localhost,VPHDFELNLR}	1678032893214
108	master	cs_cache_fake	{!FzTtpSkXWMPYBKHUQN:localhost,@mm_user1.mm:localhost}	1678032935284
109	master	cs_cache_fake	{!FzTtpSkXWMPYBKHUQN:localhost,@mm_user1.mm:localhost}	1678032935582
110	master	get_user_by_access_token	{syt_dXNlcjEubWF0cml4_ENEVYSTmTTMOFxEOKoKJ_0bGIae}	1678033083854
111	master	count_e2e_one_time_keys	{@user1.matrix:localhost,VPHDFELNLR}	1678033083867
112	master	get_e2e_unused_fallback_key_types	{@user1.matrix:localhost,VPHDFELNLR}	1678033083872
113	master	count_e2e_one_time_keys	{@admin:localhost,WYMFZMMAGV}	1678033098986
114	master	get_e2e_unused_fallback_key_types	{@admin:localhost,WYMFZMMAGV}	1678033098999
115	master	count_e2e_one_time_keys	{@admin:localhost,WYMFZMMAGV}	1678033099064
116	master	count_e2e_one_time_keys	{@admin:localhost,WYMFZMMAGV}	1678033099127
117	master	count_e2e_one_time_keys	{@admin:localhost,WYMFZMMAGV}	1678033099192
118	master	count_e2e_one_time_keys	{@admin:localhost,WYMFZMMAGV}	1678033099249
119	master	count_e2e_one_time_keys	{@admin:localhost,WYMFZMMAGV}	1678033099302
120	master	count_e2e_one_time_keys	{@admin:localhost,WYMFZMMAGV}	1678033099353
121	master	count_e2e_one_time_keys	{@admin:localhost,WYMFZMMAGV}	1678033099407
122	master	count_e2e_one_time_keys	{@admin:localhost,WYMFZMMAGV}	1678033099469
123	master	count_e2e_one_time_keys	{@admin:localhost,WYMFZMMAGV}	1678033099532
124	master	cs_cache_fake	{!FzTtpSkXWMPYBKHUQN:localhost}	1678033164724
125	master	get_user_by_access_token	{syt_bW1fdXNlcjEubW0_IunjotstMScFaScLrPOc_0mVBOr}	1678033179148
126	master	count_e2e_one_time_keys	{@mm_user1.mm:localhost,NEISSLGWTR}	1678033179188
127	master	get_e2e_unused_fallback_key_types	{@mm_user1.mm:localhost,NEISSLGWTR}	1678033179194
128	master	get_user_by_access_token	{syt_YWRtaW4_qBoxylZXGoaTkMpOxawg_4SQ49f}	1678033275824
129	master	count_e2e_one_time_keys	{@admin:localhost,WYMFZMMAGV}	1678033275836
130	master	get_e2e_unused_fallback_key_types	{@admin:localhost,WYMFZMMAGV}	1678033275839
131	master	count_e2e_one_time_keys	{@user1.matrix:localhost,GQUGBBJECP}	1678033302822
132	master	get_e2e_unused_fallback_key_types	{@user1.matrix:localhost,GQUGBBJECP}	1678033302835
133	master	count_e2e_one_time_keys	{@user1.matrix:localhost,GQUGBBJECP}	1678033302898
134	master	count_e2e_one_time_keys	{@user1.matrix:localhost,GQUGBBJECP}	1678033302951
135	master	count_e2e_one_time_keys	{@user1.matrix:localhost,GQUGBBJECP}	1678033303014
136	master	count_e2e_one_time_keys	{@user1.matrix:localhost,GQUGBBJECP}	1678033303074
142	master	get_user_by_access_token	{syt_bW1fdXNlcjEubW0_wPGKGCeFNoOzLYPunbBr_3uSoKr}	1678033565807
145	master	get_aliases_for_room	{!AHOiTmgdxQzlhIOUsy:localhost}	1678033569468
137	master	count_e2e_one_time_keys	{@user1.matrix:localhost,GQUGBBJECP}	1678033303139
148	master	cs_cache_fake	{!AHOiTmgdxQzlhIOUsy:localhost}	1678033570403
155	master	get_user_by_access_token	{syt_bW1fdXNlcjEubW0_oTMHTIecwTAOMSwTHtBV_3qDyhz}	1678033930385
138	master	count_e2e_one_time_keys	{@user1.matrix:localhost,GQUGBBJECP}	1678033303206
152	master	cs_cache_fake	{!AHOiTmgdxQzlhIOUsy:localhost,@mm_user1.mm:localhost}	1678033762880
139	master	count_e2e_one_time_keys	{@user1.matrix:localhost,GQUGBBJECP}	1678033303277
140	master	count_e2e_one_time_keys	{@user1.matrix:localhost,GQUGBBJECP}	1678033303384
147	master	cs_cache_fake	{!AHOiTmgdxQzlhIOUsy:localhost,@admin:localhost}	1678033569847
154	master	cs_cache_fake	{!AHOiTmgdxQzlhIOUsy:localhost,@user1.matrix:localhost}	1678033782365
141	master	count_e2e_one_time_keys	{@user1.matrix:localhost,GQUGBBJECP}	1678033303551
149	master	cs_cache_fake	{!AHOiTmgdxQzlhIOUsy:localhost}	1678033570750
151	master	cs_cache_fake	{!AHOiTmgdxQzlhIOUsy:localhost,@matterbot:localhost}	1678033706336
153	master	cs_cache_fake	{!AHOiTmgdxQzlhIOUsy:localhost,@mm_user1.mm:localhost}	1678033763149
156	master	count_e2e_one_time_keys	{@mm_user1.mm:localhost,NYIKZJDRFF}	1678033930408
157	master	get_e2e_unused_fallback_key_types	{@mm_user1.mm:localhost,NYIKZJDRFF}	1678033930412
143	master	count_e2e_one_time_keys	{@mm_user1.mm:localhost,NPASEFYMXA}	1678033565830
144	master	get_e2e_unused_fallback_key_types	{@mm_user1.mm:localhost,NPASEFYMXA}	1678033565833
146	master	cs_cache_fake	{!AHOiTmgdxQzlhIOUsy:localhost}	1678033569631
150	master	cs_cache_fake	{!AHOiTmgdxQzlhIOUsy:localhost,@matterbot:localhost}	1678033570897
158	master	cs_cache_fake	{!AHOiTmgdxQzlhIOUsy:localhost,@matterbot:localhost}	1678033936936
159	master	get_user_by_access_token	{syt_dXNlcjEubWF0cml4_DpWjksZWbpepOHDeLFOl_46Vnpc}	1678034032219
160	master	count_e2e_one_time_keys	{@user1.matrix:localhost,GQUGBBJECP}	1678034032231
161	master	get_e2e_unused_fallback_key_types	{@user1.matrix:localhost,GQUGBBJECP}	1678034032234
\.


--
-- Data for Name: current_state_delta_stream; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.current_state_delta_stream (stream_id, room_id, type, state_key, event_id, prev_event_id, instance_name) FROM stdin;
2	!FzTtpSkXWMPYBKHUQN:localhost	m.room.create		$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4	\N	master
3	!FzTtpSkXWMPYBKHUQN:localhost	m.room.member	@admin:localhost	$IU1ZxuT0Nte99MGUdW5IhEVc_pVMkrUEqjP5xs27dVs	\N	master
4	!FzTtpSkXWMPYBKHUQN:localhost	m.room.canonical_alias		$CgLbWRULI45y2D98z5CUQGfnpkIanhBTri6Qgk2FtZI	\N	master
4	!FzTtpSkXWMPYBKHUQN:localhost	m.room.history_visibility		$eaTE2oVse5UGe2gxU6bH4McqUJFwuNN8UMpxUnfeCzc	\N	master
4	!FzTtpSkXWMPYBKHUQN:localhost	m.room.join_rules		$MjPoUIyI-4SLUb_2CX0SN6Cq4siLSpO81XmSX0Tt1Ag	\N	master
4	!FzTtpSkXWMPYBKHUQN:localhost	m.room.power_levels		$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o	\N	master
8	!FzTtpSkXWMPYBKHUQN:localhost	m.room.name		$Z8l2x75Ktp4i5ZFSxqQHoicfewpQOJ2yKoIXvdXGGL4	\N	master
9	!pYSbiOyjMFsKNxSMyi:localhost	m.room.create		$gyvaweguHrwLjB1B_41QMnzSUMHQGbQmTALeOOMmWfU	\N	master
10	!pYSbiOyjMFsKNxSMyi:localhost	m.room.member	@admin:localhost	$hZ3X11MNOocXcrcCNowWncNXGOcKtKz2Yuy15DpSX9Y	\N	master
11	!pYSbiOyjMFsKNxSMyi:localhost	m.room.canonical_alias		$6A1pwZ_SweaaUsjoN5q44E3waqx9e_BX_Vch4BXsSMc	\N	master
11	!pYSbiOyjMFsKNxSMyi:localhost	m.room.history_visibility		$W2bBymarQF5AVOanxoytGxta4UVf4fhh6doJw6GmsQ0	\N	master
11	!pYSbiOyjMFsKNxSMyi:localhost	m.room.join_rules		$tkoiHC3Vf1zAnFhhvTe60NQ7m3nRNvT1ILxtf8O8Tdc	\N	master
11	!pYSbiOyjMFsKNxSMyi:localhost	m.room.power_levels		$EgLH6XFurmJirUH4D5Zkm8y1WyPdrFX2SSko4S0-7hQ	\N	master
15	!pYSbiOyjMFsKNxSMyi:localhost	m.room.name		$YSS-8MMEgCETq_EouYM-mm0KiVKGloqtULWeqmdQKZg	\N	master
16	!pYSbiOyjMFsKNxSMyi:localhost	m.room.member	@user1.matrix:localhost	$0RmvI0B1zTbePI4eCXXUO_9tJQY2XcOy4Kt4FqYQ-Yk	\N	master
17	!FzTtpSkXWMPYBKHUQN:localhost	m.room.member	@user1.matrix:localhost	$FSGyxWobRbm3XPzA_RJTfx_wFyj7eioybzttjovTej0	\N	master
18	!FzTtpSkXWMPYBKHUQN:localhost	m.room.member	@matterbot:localhost	$3iFc4KVKwTYBpN8T8PyFgNCDxXkCtJF5qS1nJbulpmU	\N	master
19	!pYSbiOyjMFsKNxSMyi:localhost	m.room.member	@matterbot:localhost	$f8S-mPLHMnruZFOTih-IYlCoYILk6A_BPx3dtO79ubI	\N	master
21	!pYSbiOyjMFsKNxSMyi:localhost	m.room.member	@matterbot:localhost	$Q7qpUYZra7SmdftawkKRrQilka-WlRBbgKYybv2QRls	$f8S-mPLHMnruZFOTih-IYlCoYILk6A_BPx3dtO79ubI	master
20	!FzTtpSkXWMPYBKHUQN:localhost	m.room.member	@matterbot:localhost	$o5ttVgA4qLDCRoIxN9qyVPOLj9QUajTOF3D_U8es57Y	$3iFc4KVKwTYBpN8T8PyFgNCDxXkCtJF5qS1nJbulpmU	master
23	!FzTtpSkXWMPYBKHUQN:localhost	m.room.member	@mm_user1.mm:localhost	$EeKexStxnjQMJwZnkxIZRNXLdggHQGqT_RJYm1xCocU	\N	master
24	!FzTtpSkXWMPYBKHUQN:localhost	m.room.member	@mm_user1.mm:localhost	$ZPGmNdM7zvGVfx5_posO0xAJ7C6aAnDZavYGV23i3eM	$EeKexStxnjQMJwZnkxIZRNXLdggHQGqT_RJYm1xCocU	master
27	!FzTtpSkXWMPYBKHUQN:localhost	m.room.name		$DRO5TAucLHxvrlJ47kjeEKQiKn1D0J-pwsDdrExDhfM	$Z8l2x75Ktp4i5ZFSxqQHoicfewpQOJ2yKoIXvdXGGL4	master
31	!AHOiTmgdxQzlhIOUsy:localhost	m.room.create		$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg	\N	master
32	!AHOiTmgdxQzlhIOUsy:localhost	m.room.member	@admin:localhost	$2AEp1hOUUsulI8Zc2ISpcmI9VmKuftWZdClPUSC_mD4	\N	master
33	!AHOiTmgdxQzlhIOUsy:localhost	m.room.canonical_alias		$z1GwtHO3iyw6MvOYBxrwIdl_jvUlP6_Bn6yFfE9P2aI	\N	master
33	!AHOiTmgdxQzlhIOUsy:localhost	m.room.history_visibility		$LmDzEqXVjmgNKIk52bhBmbosSuVDk32P02nhwggY0RM	\N	master
33	!AHOiTmgdxQzlhIOUsy:localhost	m.room.join_rules		$Ww-5pR04rXtgZleTLBj7vJSR1LGkC3tZ5Zuaxqazwek	\N	master
33	!AHOiTmgdxQzlhIOUsy:localhost	m.room.power_levels		$425aYo_LNE95R3HHpQZSk0MGS0CjqhCPkp0DJvtMk5M	\N	master
37	!AHOiTmgdxQzlhIOUsy:localhost	m.room.name		$sFv4HsuqMN9A0Wl_Bb1tZ-I7Kgdtxe83YsRaNWowWDM	\N	master
38	!AHOiTmgdxQzlhIOUsy:localhost	m.room.member	@matterbot:localhost	$xOF81meT9KSyhw3dY5FjCzADSBULEj6OoQaHM9DWtMY	\N	master
39	!AHOiTmgdxQzlhIOUsy:localhost	m.room.member	@matterbot:localhost	$cgYituIGJ7X54S5-Ax3C5u2yLwCnf99x2VbMmy0YD3w	$xOF81meT9KSyhw3dY5FjCzADSBULEj6OoQaHM9DWtMY	master
40	!AHOiTmgdxQzlhIOUsy:localhost	m.room.member	@mm_user1.mm:localhost	$hgeuyu5_SLbd99TLf-m4kSUM8l1Jy-W4XmhdQGO2rr0	\N	master
41	!AHOiTmgdxQzlhIOUsy:localhost	m.room.member	@mm_user1.mm:localhost	$jiXC1l1ou9Ti0I7CV7PJrsVblqsrb9dPQentqZqLBys	$hgeuyu5_SLbd99TLf-m4kSUM8l1Jy-W4XmhdQGO2rr0	master
43	!AHOiTmgdxQzlhIOUsy:localhost	m.room.member	@user1.matrix:localhost	$ye7ixCV2UmoA3GCF2K5lqNSxMrWwkdvkTSOdQDHy-P0	\N	master
45	!AHOiTmgdxQzlhIOUsy:localhost	m.room.member	@matterbot:localhost	$0XMDIAwJBH-iA7qIReHWRJAwmGiTGGioVtV8KFmJ4_M	$cgYituIGJ7X54S5-Ax3C5u2yLwCnf99x2VbMmy0YD3w	master
\.


--
-- Data for Name: current_state_events; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.current_state_events (event_id, room_id, type, state_key, membership) FROM stdin;
$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4	!FzTtpSkXWMPYBKHUQN:localhost	m.room.create		\N
$IU1ZxuT0Nte99MGUdW5IhEVc_pVMkrUEqjP5xs27dVs	!FzTtpSkXWMPYBKHUQN:localhost	m.room.member	@admin:localhost	join
$CgLbWRULI45y2D98z5CUQGfnpkIanhBTri6Qgk2FtZI	!FzTtpSkXWMPYBKHUQN:localhost	m.room.canonical_alias		\N
$eaTE2oVse5UGe2gxU6bH4McqUJFwuNN8UMpxUnfeCzc	!FzTtpSkXWMPYBKHUQN:localhost	m.room.history_visibility		\N
$MjPoUIyI-4SLUb_2CX0SN6Cq4siLSpO81XmSX0Tt1Ag	!FzTtpSkXWMPYBKHUQN:localhost	m.room.join_rules		\N
$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o	!FzTtpSkXWMPYBKHUQN:localhost	m.room.power_levels		\N
$gyvaweguHrwLjB1B_41QMnzSUMHQGbQmTALeOOMmWfU	!pYSbiOyjMFsKNxSMyi:localhost	m.room.create		\N
$hZ3X11MNOocXcrcCNowWncNXGOcKtKz2Yuy15DpSX9Y	!pYSbiOyjMFsKNxSMyi:localhost	m.room.member	@admin:localhost	join
$6A1pwZ_SweaaUsjoN5q44E3waqx9e_BX_Vch4BXsSMc	!pYSbiOyjMFsKNxSMyi:localhost	m.room.canonical_alias		\N
$W2bBymarQF5AVOanxoytGxta4UVf4fhh6doJw6GmsQ0	!pYSbiOyjMFsKNxSMyi:localhost	m.room.history_visibility		\N
$tkoiHC3Vf1zAnFhhvTe60NQ7m3nRNvT1ILxtf8O8Tdc	!pYSbiOyjMFsKNxSMyi:localhost	m.room.join_rules		\N
$EgLH6XFurmJirUH4D5Zkm8y1WyPdrFX2SSko4S0-7hQ	!pYSbiOyjMFsKNxSMyi:localhost	m.room.power_levels		\N
$YSS-8MMEgCETq_EouYM-mm0KiVKGloqtULWeqmdQKZg	!pYSbiOyjMFsKNxSMyi:localhost	m.room.name		\N
$0RmvI0B1zTbePI4eCXXUO_9tJQY2XcOy4Kt4FqYQ-Yk	!pYSbiOyjMFsKNxSMyi:localhost	m.room.member	@user1.matrix:localhost	join
$FSGyxWobRbm3XPzA_RJTfx_wFyj7eioybzttjovTej0	!FzTtpSkXWMPYBKHUQN:localhost	m.room.member	@user1.matrix:localhost	join
$Q7qpUYZra7SmdftawkKRrQilka-WlRBbgKYybv2QRls	!pYSbiOyjMFsKNxSMyi:localhost	m.room.member	@matterbot:localhost	join
$o5ttVgA4qLDCRoIxN9qyVPOLj9QUajTOF3D_U8es57Y	!FzTtpSkXWMPYBKHUQN:localhost	m.room.member	@matterbot:localhost	join
$ZPGmNdM7zvGVfx5_posO0xAJ7C6aAnDZavYGV23i3eM	!FzTtpSkXWMPYBKHUQN:localhost	m.room.member	@mm_user1.mm:localhost	join
$DRO5TAucLHxvrlJ47kjeEKQiKn1D0J-pwsDdrExDhfM	!FzTtpSkXWMPYBKHUQN:localhost	m.room.name		\N
$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg	!AHOiTmgdxQzlhIOUsy:localhost	m.room.create		\N
$2AEp1hOUUsulI8Zc2ISpcmI9VmKuftWZdClPUSC_mD4	!AHOiTmgdxQzlhIOUsy:localhost	m.room.member	@admin:localhost	join
$z1GwtHO3iyw6MvOYBxrwIdl_jvUlP6_Bn6yFfE9P2aI	!AHOiTmgdxQzlhIOUsy:localhost	m.room.canonical_alias		\N
$LmDzEqXVjmgNKIk52bhBmbosSuVDk32P02nhwggY0RM	!AHOiTmgdxQzlhIOUsy:localhost	m.room.history_visibility		\N
$Ww-5pR04rXtgZleTLBj7vJSR1LGkC3tZ5Zuaxqazwek	!AHOiTmgdxQzlhIOUsy:localhost	m.room.join_rules		\N
$425aYo_LNE95R3HHpQZSk0MGS0CjqhCPkp0DJvtMk5M	!AHOiTmgdxQzlhIOUsy:localhost	m.room.power_levels		\N
$sFv4HsuqMN9A0Wl_Bb1tZ-I7Kgdtxe83YsRaNWowWDM	!AHOiTmgdxQzlhIOUsy:localhost	m.room.name		\N
$jiXC1l1ou9Ti0I7CV7PJrsVblqsrb9dPQentqZqLBys	!AHOiTmgdxQzlhIOUsy:localhost	m.room.member	@mm_user1.mm:localhost	join
$ye7ixCV2UmoA3GCF2K5lqNSxMrWwkdvkTSOdQDHy-P0	!AHOiTmgdxQzlhIOUsy:localhost	m.room.member	@user1.matrix:localhost	join
$0XMDIAwJBH-iA7qIReHWRJAwmGiTGGioVtV8KFmJ4_M	!AHOiTmgdxQzlhIOUsy:localhost	m.room.member	@matterbot:localhost	join
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
X	34	!pYSbiOyjMFsKNxSMyi:localhost
\.


--
-- Data for Name: device_lists_changes_in_room; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.device_lists_changes_in_room (user_id, device_id, room_id, stream_id, converted_to_destinations, opentracing_context) FROM stdin;
@admin:localhost	LWSWGUCQHK	!FzTtpSkXWMPYBKHUQN:localhost	9	f	{}
@admin:localhost	LWSWGUCQHK	!pYSbiOyjMFsKNxSMyi:localhost	9	f	{}
@user1.matrix:localhost	VPHDFELNLR	!pYSbiOyjMFsKNxSMyi:localhost	20	f	{}
@user1.matrix:localhost	VPHDFELNLR	!FzTtpSkXWMPYBKHUQN:localhost	20	f	{}
@user1.matrix:localhost	VPHDFELNLR	!pYSbiOyjMFsKNxSMyi:localhost	21	f	{}
@user1.matrix:localhost	VPHDFELNLR	!FzTtpSkXWMPYBKHUQN:localhost	21	f	{}
@user1.matrix:localhost	VPHDFELNLR	!pYSbiOyjMFsKNxSMyi:localhost	23	f	{}
@user1.matrix:localhost	VPHDFELNLR	!FzTtpSkXWMPYBKHUQN:localhost	23	f	{}
@admin:localhost	WYMFZMMAGV	!pYSbiOyjMFsKNxSMyi:localhost	24	f	{}
@admin:localhost	WYMFZMMAGV	!FzTtpSkXWMPYBKHUQN:localhost	24	f	{}
@admin:localhost	WYMFZMMAGV	!pYSbiOyjMFsKNxSMyi:localhost	25	f	{}
@admin:localhost	WYMFZMMAGV	!FzTtpSkXWMPYBKHUQN:localhost	25	f	{}
@mm_user1.mm:localhost	NEISSLGWTR	!FzTtpSkXWMPYBKHUQN:localhost	26	f	{}
@mm_user1.mm:localhost	NPASEFYMXA	!FzTtpSkXWMPYBKHUQN:localhost	27	f	{}
@admin:localhost	WYMFZMMAGV	!pYSbiOyjMFsKNxSMyi:localhost	28	f	{}
@admin:localhost	WYMFZMMAGV	!FzTtpSkXWMPYBKHUQN:localhost	28	f	{}
@user1.matrix:localhost	GQUGBBJECP	!pYSbiOyjMFsKNxSMyi:localhost	29	f	{}
@user1.matrix:localhost	GQUGBBJECP	!FzTtpSkXWMPYBKHUQN:localhost	29	f	{}
@user1.matrix:localhost	GQUGBBJECP	!pYSbiOyjMFsKNxSMyi:localhost	30	f	{}
@user1.matrix:localhost	GQUGBBJECP	!FzTtpSkXWMPYBKHUQN:localhost	30	f	{}
@mm_user1.mm:localhost	NPASEFYMXA	!FzTtpSkXWMPYBKHUQN:localhost	31	f	{}
@mm_user1.mm:localhost	NYIKZJDRFF	!FzTtpSkXWMPYBKHUQN:localhost	32	f	{}
@mm_user1.mm:localhost	NYIKZJDRFF	!FzTtpSkXWMPYBKHUQN:localhost	33	f	{}
@mm_user1.mm:localhost	NYIKZJDRFF	!AHOiTmgdxQzlhIOUsy:localhost	33	f	{}
@user1.matrix:localhost	GQUGBBJECP	!pYSbiOyjMFsKNxSMyi:localhost	34	f	{}
@user1.matrix:localhost	GQUGBBJECP	!FzTtpSkXWMPYBKHUQN:localhost	34	f	{}
@user1.matrix:localhost	GQUGBBJECP	!AHOiTmgdxQzlhIOUsy:localhost	34	f	{}
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
2	@admin:localhost	OZJZGYFHKP
6	@admin:localhost	PExhpsiEzrVbb+nJW0okj2KxglVfRiJSlcyD0+MMljI
7	@admin:localhost	hJ2/IzKfbNkQKWlWXSO0LCSGtcCOfc2csC55NNXc2EQ
9	@admin:localhost	LWSWGUCQHK
13	@user1.matrix:localhost	beSzgvmiqhyOlsq4MZxq3tNAMlxVH0/q0zWZ5l+taX0
14	@user1.matrix:localhost	XDO/JuW2hr3pn+yiAgaWGlXOiZkLZTXihr135+Z5YnA
15	@user1.matrix:localhost	TVVUNPJUJZ
16	@matterbot:localhost	PWRMYRIUQD
17	@mm_user1.mm:localhost	RQAXSULDUM
18	@mm_user1.mm:localhost	CTHQGTXACR
19	@mm_user1.mm:localhost	PKQQWLAPGS
23	@user1.matrix:localhost	VPHDFELNLR
26	@mm_user1.mm:localhost	NEISSLGWTR
28	@admin:localhost	WYMFZMMAGV
31	@mm_user1.mm:localhost	NPASEFYMXA
33	@mm_user1.mm:localhost	NYIKZJDRFF
34	@user1.matrix:localhost	GQUGBBJECP
\.


--
-- Data for Name: devices; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.devices (user_id, device_id, display_name, last_seen, ip, user_agent, hidden) FROM stdin;
@admin:localhost	PExhpsiEzrVbb+nJW0okj2KxglVfRiJSlcyD0+MMljI	master signing key	\N	\N	\N	t
@admin:localhost	hJ2/IzKfbNkQKWlWXSO0LCSGtcCOfc2csC55NNXc2EQ	self_signing signing key	\N	\N	\N	t
@admin:localhost	kYr3N/1MnZ/awEPS8nnspAtjycIp31aCMUeYcARH16M	user_signing signing key	\N	\N	\N	t
@user1.matrix:localhost	beSzgvmiqhyOlsq4MZxq3tNAMlxVH0/q0zWZ5l+taX0	master signing key	\N	\N	\N	t
@user1.matrix:localhost	XDO/JuW2hr3pn+yiAgaWGlXOiZkLZTXihr135+Z5YnA	self_signing signing key	\N	\N	\N	t
@user1.matrix:localhost	FcIIrw9PjZO3SoQHeMatSRfhcThhfPsmWYvHPKaboJw	user_signing signing key	\N	\N	\N	t
@matterbot:localhost	PWRMYRIUQD	\N	\N	\N	\N	f
@user1.matrix:localhost	TVVUNPJUJZ	localhost:8080: Chrome on macOS	1675958805843	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36	f
@mm_user1.mm:localhost	RQAXSULDUM	\N	\N	\N	\N	f
@mm_user1.mm:localhost	CTHQGTXACR	\N	\N	\N	\N	f
@mm_user1.mm:localhost	PKQQWLAPGS	\N	\N	\N	\N	f
@admin:localhost	OZJZGYFHKP	\N	1678033936477	172.16.238.1	axios/1.3.2	f
\.


--
-- Data for Name: e2e_cross_signing_keys; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.e2e_cross_signing_keys (user_id, keytype, keydata, stream_id) FROM stdin;
@admin:localhost	master	{"user_id":"@admin:localhost","usage":["master"],"keys":{"ed25519:PExhpsiEzrVbb+nJW0okj2KxglVfRiJSlcyD0+MMljI":"PExhpsiEzrVbb+nJW0okj2KxglVfRiJSlcyD0+MMljI"},"signatures":{"@admin:localhost":{"ed25519:LWSWGUCQHK":"3YlJSJZ12oVyK6WXIMHUuEIC16ctVfRL0954pBCem033ZsXuyhl7k7u3Q/X2nBBj4Z16Qt7AEY2BxmdajuuGAQ"}}}	2
@admin:localhost	self_signing	{"user_id":"@admin:localhost","usage":["self_signing"],"keys":{"ed25519:hJ2/IzKfbNkQKWlWXSO0LCSGtcCOfc2csC55NNXc2EQ":"hJ2/IzKfbNkQKWlWXSO0LCSGtcCOfc2csC55NNXc2EQ"},"signatures":{"@admin:localhost":{"ed25519:PExhpsiEzrVbb+nJW0okj2KxglVfRiJSlcyD0+MMljI":"H7H8bGpifgp5vpwa2pyyOaWBoybnL0E7qknWpjXmV0Onjo7wxKkkCNXYLDE4yuNNUsFmt0gk5+yVLty8EyjhBg"}}}	3
@admin:localhost	user_signing	{"user_id":"@admin:localhost","usage":["user_signing"],"keys":{"ed25519:kYr3N/1MnZ/awEPS8nnspAtjycIp31aCMUeYcARH16M":"kYr3N/1MnZ/awEPS8nnspAtjycIp31aCMUeYcARH16M"},"signatures":{"@admin:localhost":{"ed25519:PExhpsiEzrVbb+nJW0okj2KxglVfRiJSlcyD0+MMljI":"QWjAIZsHhrIdeZ28agI81PQw3FADJg1R9naUWxlspRt2jnI34DYph4h/35EYx0XfUmQp/WZ7BHXyB10xkyz2BA"}}}	4
@user1.matrix:localhost	master	{"user_id":"@user1.matrix:localhost","usage":["master"],"keys":{"ed25519:beSzgvmiqhyOlsq4MZxq3tNAMlxVH0/q0zWZ5l+taX0":"beSzgvmiqhyOlsq4MZxq3tNAMlxVH0/q0zWZ5l+taX0"},"signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"ayiUJcfBfu1NuKTcUoEPjlEiLrwmMWg/rSScfJBgGXMc9HLIKRZTWfGYaXA1Xm8VDgBdoEaDXX+XfHo7mbWsCQ"}}}	5
@user1.matrix:localhost	self_signing	{"user_id":"@user1.matrix:localhost","usage":["self_signing"],"keys":{"ed25519:XDO/JuW2hr3pn+yiAgaWGlXOiZkLZTXihr135+Z5YnA":"XDO/JuW2hr3pn+yiAgaWGlXOiZkLZTXihr135+Z5YnA"},"signatures":{"@user1.matrix:localhost":{"ed25519:beSzgvmiqhyOlsq4MZxq3tNAMlxVH0/q0zWZ5l+taX0":"waOgjO4z0CGVmjygGBFWMMf12xOAG8nUdjV5p4dGkF+6ka75XDZ7ynfi6q87QuvZ+EoENWwji3F6PWXFXtHXBg"}}}	6
@user1.matrix:localhost	user_signing	{"user_id":"@user1.matrix:localhost","usage":["user_signing"],"keys":{"ed25519:FcIIrw9PjZO3SoQHeMatSRfhcThhfPsmWYvHPKaboJw":"FcIIrw9PjZO3SoQHeMatSRfhcThhfPsmWYvHPKaboJw"},"signatures":{"@user1.matrix:localhost":{"ed25519:beSzgvmiqhyOlsq4MZxq3tNAMlxVH0/q0zWZ5l+taX0":"JPl2KUUyu9z6cvqm50NNhRAT9NDltcG/vPGovjjoIN2QRG+FHuPvLctR2JfJxlhzD6RtES02SOYBuuHv1qVUAQ"}}}	7
\.


--
-- Data for Name: e2e_cross_signing_signatures; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.e2e_cross_signing_signatures (user_id, key_id, target_user_id, target_device_id, signature) FROM stdin;
@admin:localhost	ed25519:hJ2/IzKfbNkQKWlWXSO0LCSGtcCOfc2csC55NNXc2EQ	@admin:localhost	LWSWGUCQHK	OaW6io7zPXG3tMOuTiK08VaihJ2LvFN8K1okNYoEZ2ezL83U8oOVXhX+eBAeURXGAV/qB3lZ6a8TSfHddKzfBw
@user1.matrix:localhost	ed25519:XDO/JuW2hr3pn+yiAgaWGlXOiZkLZTXihr135+Z5YnA	@user1.matrix:localhost	TVVUNPJUJZ	/STyt607WZGFv9Pqw1skvanc1mCD4Scj8FmjFr3zz0ZMryw4l9J2RaW+iNivHpfPOKqU0AJ/9vsMsc3eeMhvDA
\.


--
-- Data for Name: e2e_device_keys_json; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.e2e_device_keys_json (user_id, device_id, ts_added_ms, key_json) FROM stdin;
@user1.matrix:localhost	TVVUNPJUJZ	1675956810704	{"algorithms":["m.olm.v1.curve25519-aes-sha2","m.megolm.v1.aes-sha2"],"device_id":"TVVUNPJUJZ","keys":{"curve25519:TVVUNPJUJZ":"NVFjCldekp+Q0Gybz7MGqQhPgU3Lpk8JqGBKUBNEyBs","ed25519:TVVUNPJUJZ":"f8/gI7YahE0lvtIPvFS+kZu7B465C0mawM5+EKvklAg"},"signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"vo/Ca+ZIll2MsEG6H4K2tqhv2ErNIUYbn2uvEMjJWzItjaTFaVOcthvbfqOjTxlsVPFQImuuFrGIeczJkd+WAw"}},"user_id":"@user1.matrix:localhost"}
\.


--
-- Data for Name: e2e_fallback_keys_json; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.e2e_fallback_keys_json (user_id, device_id, algorithm, key_id, key_json, used) FROM stdin;
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAABg	{"key":"1mkvKqnczKDOelhS8V4eyRhGWG8Le7+1+4B1wIFRvjE","fallback":true,"signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"AHdg7tQUyiDOQveX8bXr7/NXOZ/6NebyhqCIdcLIDSHD7i4N75aGdfQzGLC7QO3RsyfnXO08+g6/cMClwZZqDg"}}}	f
\.


--
-- Data for Name: e2e_one_time_keys_json; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.e2e_one_time_keys_json (user_id, device_id, algorithm, key_id, ts_added_ms, key_json) FROM stdin;
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAAFQ	1675956811300	{"key":"3zpXWzzcKP1TsIahfyiaLR6qXoX8tDQFcwgPBUB3szs","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"NyhQPSsldVLLgHWOdHK1xdpzI6T15zC5e6EqqM3KhtpbJsRXeYNY4MyxgEMdgdPIeB0XHuaSBN8MqnDe3WeUCg"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAAFA	1675956811300	{"key":"qZElz+PZ6DaMl1kukE9UGZOTpH9Jcrll1dYCrthfJVA","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"X006NiI456MvUifMIgyT7fLvWfwzXvm4FYsSF4HuRi4W5OFWOqnnufCvJ5JX3lUKR9F805NwiUv0MdnEivwMBw"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAAEw	1675956811300	{"key":"qT4WJI8iWr+3ILslqZYMMcR2DeDAOZ30XUHIIK+YlW0","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"1/NuY6GzQgefHQtfswnfUWrpMe682sNvP0OOVTIGEWC2NfAykvED7AXOKwugYI4HXAIdnwwd6LbGd9DYfucOBg"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAAEg	1675956811300	{"key":"7nV4XL/MGEyeb55yhGEpcyNaCqGDyZg1xkMWupUylE0","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"A1kNFObmefgBvrPzkRSzDJkvoWNSXeLzrDcs5zQ+ZIPKeF4fgdkK2xqXIZUzvkT991RYrYg0XO+99yqy/lQuDA"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAAEQ	1675956811300	{"key":"EuhtlUN/Pf9g/6WnqTcFxCvPUIgQ4H4ipT8D5ipMqlA","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"8xdP6tAJyF4oVHBBg5JzZpNBCl63late170YqwxYR7gOf5NdRblJj93FlrvKAOBTLLdscvcNGbdoSQuOVquMDg"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAABQ	1675956811061	{"key":"7mKre+5J3SOnie1hJeo6NrMB3zALqsdJw6+v4VlCVWg","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"X7kvPcUej4psPqSv4SUpkH9gnfKCOBC5gZLYr2QXPXoNaRCYIhOTyAGC2itRx4YcPk1kCXyZ0mWdlzfD8DNBBQ"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAABA	1675956811061	{"key":"FJJtiuh7w7Ok9G8WoR7ifmod9iH6RBYC+oz/J4YOPh8","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"O3osSsyRnhrGtFfxpbwRQi02T8e11d3C5nsoXSVPfjczbIUVnVW3tkw97oclqeSBA6ol2lBPYXqNwKlnkbnEBw"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAAAw	1675956811061	{"key":"6Ap6Jli6RkeGdLIsVgG8jaY0Miy6JnXo8u+Lg5/zIzU","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"khymQG7nZAtlldD0Zoc5/xvUZ5+F4u7RPrdG2d/BddCgc/2cSYxhSIQ/rKcfkpZ9org8c/EGQCfcsE0ubnzCAQ"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAAAg	1675956811061	{"key":"vlfWQ5t4r9M8hZuC3VVb4j2b1e1SnWAVBvK8yveJnU8","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"DarJhfWJ5C81OABuRAxDwhr4mawnAHzfy4Dd/sBE7b4nnAawAYoxk9K6D1XTkWGYmqkcF5iDyKFMRz+9Hq3eCQ"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAAAQ	1675956811061	{"key":"ybt8yqjMYcMUC8VSTUwlVOMq2O+Bw2xxLQiRtDLS01Q","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"o1tOgHevdgAau4SDQmcCNLnxgZ9/83KCyoHh75f2Aps2XQgsGQOFeJ8e5i8+ai1I/HNfXzgbfMyhryvXAffiAw"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAACw	1675956811167	{"key":"c7rhq19ejSplXccVFOJ/MIz3lX6ELtsJORObsaAgrRk","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"KfQWsw3fmZHkfPW6G5cLaHw1jiRm5gjFRdssA30sEpICp0bjL9Lb/qVK0fXNBWT0rN3TNkrfryCDnpIGcAogCw"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAACg	1675956811167	{"key":"BWNJHU1qNa/Uf+hZFg5guOavObRIK/II/mnJhodt5lU","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"O6beUTJ5skyV/yXDxJYw6S2zxdC3Lg9ghttSUdgIyydVe0FxqnvlbRaINu7/wcVkndjmewVIGadh+jiICXfOBQ"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAACQ	1675956811167	{"key":"jnvDdNkTf9cumOw3opVHp0M7qzL7sHBA6UOUpnWjQws","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"KpskXiCIjFo+aCv9XwGdbZId0YhXw7DVAOVE7VYWoV/D7+80SP5s2kJfnSvxk73Sc6xd5wrALD2DLCnefgqrCA"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAACA	1675956811167	{"key":"ZIJAZoc9N8DTZKtgB+3cfKzuzCnZJapSTGt6KDFhq1w","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"1BJFu3VV/NzwuSZjDsI7dtZ6CWAFD71KqTHIwmrB6kWdw/maVnynRVMnP6wQTvXgK32bzXxK5qTgPy9PSnpNDw"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAABw	1675956811167	{"key":"NBvG1s9AjAGPx+tF9Mm6q3UnRQjlIOPPWUJnEaPwbUw","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"QYTTSnCUDg/IbiVC4GjPKSn+9DFDH3jr8A2lPeqnAbGT5XRTnrL7Hvsd+gjjk1wOtXLKwr8EQRLGEmRvi0FqBA"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAAEA	1675956811240	{"key":"ArDrX656iQzXEkUP/5vbdJcbRkJqjaSZiHdAQLzOECg","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"kZxj/U/gkzJbwFfsputW/Kk1mtcYRKbyD+ZK+DW6QoA6+14PYQHc2n/HFmZ6Ilytz8m/G0ZxNVKeFvxQ/NrQBA"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAADw	1675956811240	{"key":"gbcWkTTAxzO758csgKUgBOqZd1J+b3aW80jU3zfmiWM","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"w18nSFl46Jv0g02fFIf7XlIDCocRM9sxkO8JgEqrF//54nizTcLWTaDQCrRiwNpHnNx4+7+4yqMMcaKIAvwxCQ"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAADg	1675956811240	{"key":"apm6MrVwpUZM9Oy0JyasMyz1lsbVynXw3kAckKbvYRc","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"/8FgsJbSliniNibvytcnFOKNbt3VnRNdRX2UaWRiUryVEdfBlLzFXN76LKzXJSuiAuRXboetkhYmkASixeb/Bw"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAADQ	1675956811240	{"key":"+hzefGvjyKQvQ0aDQKnl9slI0XDyoAPwgtiyXNJhEG8","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"vRo5wA2aYZaBRufYUvH/RymN/SUV/v62apYJU0nEfaOYQurKTeVvQPhYM+3t/jdpH+zoMuluBJphI3fsHpmXDA"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAADA	1675956811240	{"key":"JbAJEDGfZZfapHWIrwd1ft5Qse7+GrndhXtJ3Px+EGU","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"MNRwz2Cvc4V/8yGMd2pHAsHIXbH6Cf8scw0utalI8LMZDLmvmXGmOFRSCE/YQHZULf0skj78B/uDJrCPZxYjBQ"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAAGg	1675956811356	{"key":"UASdiJ2CNlBeBu8SaBOrXZXmIUcV/035yLejvyjB6nc","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"U2IRgrxEuOVR4MTTSHw+o3fr9beaFbTdVZfpRwog+bU1EtIVadflcbs8joEAgCHEnXhagki/0kIluyALAfNNAQ"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAAGQ	1675956811356	{"key":"Cpz+zfCenIz4jW8ve31/Azxqr73z/gC7ANrsX2EvwgI","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"OxrniZVDmXmgfqhdicGlij3Wkh/14b/QcYIjzjzNm/GOVBqI1mVe+zS76/Mmukv728MC39PLTEpx84iFpNBaDA"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAAGA	1675956811356	{"key":"yUqWJnNXoXQOAoy9VZ3/Ju5gTOujWNs8tEu9Y0FPlhY","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"x/Nk72UI+9dHbgJYlRN/E0fW9YKiwGKjwVtWJDoyhAQ8/bZfiYtV2gxg7u9DiSNAJL8opwT3r5hjJqnqCYDeBA"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAAFw	1675956811356	{"key":"Tfg4vkXEEmoZ4LV90cHKju4ABfEpOhfLABf4LwDKP2Y","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"5P93jlFIOjMN4mEEPzYZ6y8hvnnH2bNJco25dp414jUWhxuqZliHobn5NQgB2KfkFeW//KbUA62gCBMghuxcCw"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAAFg	1675956811356	{"key":"4jyE44w2bnaY3iJZx3CpvOoM2kwvd7lCaGxPgfAv0AU","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"+dLVyn59/RL1EMsRjjCHj65KvP15oggJWrafO9t6hQ54b4YBXljtPknbrfC+AQWfjSBoLC26IM27t9hvL1wAAg"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAAHw	1675956811419	{"key":"/4eC4ssL0JyhiVYRmhMHlhjQDkwYRE21gJNsoFoWPn0","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"eIkz76DURW52+yvw2dntkJvPic4fj4ugyVIkX+DjVFqGByDzYTObgV04v+HCKuklA7Qp+7LOMl+gkmaNMtHSCA"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAAHg	1675956811419	{"key":"CfKllqkEZ+hXV7Gx51gamRJYi1zGTE8jbUNZcSx1d3g","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"8sEcxrjqt01mcfDkeer+6a7vwOv1nGEAfbIrQlZSi5w0bG8mjkQV3jAo/nnWFOhs60X6M3SyRa9QJbp0VSG+Aw"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAAHQ	1675956811419	{"key":"/NOnn7kupCi3zMXIIHfohAaSsa6aR2HXugqwUn2HaHg","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"rP0V1ZmDN9mTN6TDlQwR6Mc2w12T4hvmFmtJyk+ckQqPL5YRuxrAPH273u4r/z/rg7kRgmOqGayew8yQRxivCg"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAAHA	1675956811419	{"key":"eeoNTsc9NU7i7Poevh2ezLTrS7Jkg61VLkOONey2BTA","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"6p5bVtJs0ZxCty0w//xvP/H6+9LvZ6qb75A0ktdcykoWLgJdOFhi2Hxg08nYwUcOZiK3jyGeDRauX/sIHLwqAg"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAAGw	1675956811419	{"key":"QkixO8QbOamzbjAsTe+YiHW5939GiKvt/TweGlWScCU","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"LnNjANgfgt34GvQ3NJHJHO4Ec/+OdBMKdL84FVQP6FRW9GHAMepGXTyoZmnjsmlmHCb+1hTzS27KbJaKWFdjDw"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAAJA	1675956811478	{"key":"Jz7ItxTgZKX3vMCHH5sL2QLx4LVtTGmGbXdQjVRapiQ","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"tfNsVFImXocwaS3aabXliF+VC5MaNC2OvUR15rgiJkO0f4OuDxQ9OfT1x0Ga4GnyTQQhjJuwudEvxngWXK89DQ"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAAIw	1675956811478	{"key":"WriSTCVwKSduARrx7kgatcChxzwObR7Fnm9RZ3qjpD8","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"smeiBn8Ul3r+/fffFC0sixlVzNQqGle8iKW2u2Oxhb9t4RNfT6bPZ98/GaGO4p60qXP6G2w0hXv3R+gmEqmjDg"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAAIg	1675956811478	{"key":"iEsSrd4PQec31IwrYDfDM8irEL9elGoUrOtZpUFcITc","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"LVRjDc9Uw/om21S8EppbsRND/+gKnHEsJj2/AGQk++2mEomqAJlxSFEUMsBvlLmEL1DSviBH+FqjK9C3qKpBBQ"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAAIQ	1675956811478	{"key":"hI6KXWyKEf8NOxkRRAAsQOHgovD4zjBWrjbxZ1gWzU8","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"Q0AJYb6MU3Nt0hLmiuAAaTJyi5yjPnwE87lQLiPs7DM5URbFiQB+8hbqpWdH56Fu4Ga0J0/R5V8FwwcWlaAKBg"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAAIA	1675956811478	{"key":"3AYoVKVJ91UI0yXnp6liLbtwOLnL1EzhlvhyDf1GRQE","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"MCtMXBekWsdsyIbFiIbF+OsophUooVDcPkPX/Fpvo4IY16yPqcmHOO+hkuy9rtj1VvxUJPn9RkyesXREo7QmCw"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAAKQ	1675956811535	{"key":"6TwSU2K4Cd1f06jk3/1YQjPZdr4kCE52F0zgpsXXWws","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"Ff/1UDm5XX34Vrtr6x6ZpsxcoEOoQ0CV6vjWV328/UnKgLM3JEJGWNXipAK0M6BCqc1caf49eiCufx41X7PiDg"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAAKA	1675956811535	{"key":"3IsMfAkOYC6NQZcLcg2kieNKuSW36KB1uxlqsJIpT1c","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"WYmGKeMBy0rajxDQmK4sxoMisloYWBm5qSO0St3HcVUtDn89YJUnS/xhYdgdb728oDv+LwmGBg5zzAZfSvSeCw"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAAJw	1675956811535	{"key":"oyo/t4Rt+682nnTvauOOJ/LE+yIV3mk2GEl4INkiIF8","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"TRPFXsq3XAd6b3mdldJnZVP9MNfB7dFa7wm2PygOWQBjmgKNlV9QbnKwBHooEwzRMzlZM/q9jLDFl8u0xJMtCg"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAAJg	1675956811535	{"key":"LuOhLssP8M9Fyu0xaoBr4Jo7nvgoCd3C8cGHl2jLAVo","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"L2zZhHGvsjxY/s+h1S1cmxlATJxuRBd3EpiELObpRkUEcr/4+J8esGeobsEZ77WleOYxx3DyXP3ta74PawZjCQ"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAAJQ	1675956811535	{"key":"NicrbkU0JKuxEr3q13cCpmB67+hJcvrmeAGqvay41QE","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"PUIUVoj0Kvq0EUnnaaeSmbQjGYI1vDNgxjP/TpF6W7Y/vGL+j2aDyolEKV9vQn5UroMqI5jWQmvIXH7359BUDw"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAALg	1675956811625	{"key":"cMn1rp9d/Mkxk8+WUULmrQiA5lMNFYYg/qdvjUgmsl8","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"/nakJ+kU4ZdR6a9gWkbYFnV8igp7ogD9GoJtTUu6HU4B4oG4qYAcr7LCChzXpfwb393VGkHUgwycXuQneoB2Dw"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAALQ	1675956811625	{"key":"U9ycbK9ZksniOtD3fnKhJVQuqhoxuVmf6Vv2Orw8MRM","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"4iRFlMvs2bI5i5YXB/+THAmmOYd8BxOUdPfwVJVc+JyF5dCipUO2Q//7E5Jy9fm1aG1nO/JC6W0xtXp3B5l6Cg"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAALA	1675956811625	{"key":"ggnlKMNh9JvVX4asKr6+ip2+jN+DcMZlTcXvxA4u9F8","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"rhs+B/N/cPBFzCJJGwIUo7Gttd5DG9+zDr2zE5Rno6yzI+4hrYVNvrjfPbN2eEhtm7z9D/dSJ6AaJBZUURW4CQ"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAAKw	1675956811625	{"key":"eNPTDd68+dSADsvjw5uNJV0aT+IJFmswVK0VKRjLugw","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"fwQGrRl6O/5Bww3G5Jqr9qv2k/vGsHDso6xI6L0B50O8O9iCCop0HN0LB+OTHGu8o3hgBygltMU8LEkCHqt/Cg"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAAKg	1675956811625	{"key":"Pa+Xq1YycH4jf/JzuQMt/8uIBrQmVq88iDdkcXT8ozw","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"IRlVRMsufP4T1VbGhX/PsvFPn1cEfo404lZe7DAD32n7TOg734zPAjBu6CpPHmqedj0I9Of/VqzmJIdhewGaCA"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAAMw	1675956811758	{"key":"xx8rWp7jdw5I1xUpWh+a+trwR1nFAnj0gGbXK5oJ7nY","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"U5G8jqrXUwFu0qZ8Y33HvuA5nIlEMs+uWINO14iFGrOa59CdnoEXVfX9k0ETEM9YsZpuCJkeRRxmM4ppQqFvDA"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAAMg	1675956811758	{"key":"/64EcNyM80uhejLaAa4PHI+rnzrHykC2Wf1sbZDrHEY","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"PdDdBLvcslh2VRa/G+bNzqQKMrUFc312hRF7wpl8MeyvqR/H4ycNn4f/4Cky1qWYqEN5/NmHWfhI8bayfFIdAw"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAAMQ	1675956811758	{"key":"UaCScvGhFGs5bOomvKhOcZj9sU0ckcglq3xnC1eyvg4","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"ne6zUncFW4KHudvtabo5Vo5ks7Jo9KX9hnTw9tEQRkDjUPp01DvLT9jzche8aWBZ8qLSPvaXbVUuAkoE2/N2CA"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAAMA	1675956811758	{"key":"n7L4bO8OVSxzn1i3rCzByk3zORM+hsGLYo2tGTycg1M","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"Y7j5Py7cE6Zdo1ayMwf1dJKYUdwvOKbjkTYVDLYGeDqDhxxy+KxyhUTkEToUtkUgew5ecOBomYlp+rwdfoXzBw"}}}
@user1.matrix:localhost	TVVUNPJUJZ	signed_curve25519	AAAALw	1675956811758	{"key":"2Qh/QdcNN/I76KnlxgHQ23cqP+88iDz3PCrwL0XRDSk","signatures":{"@user1.matrix:localhost":{"ed25519:TVVUNPJUJZ":"hlzN2WbD/nX7D7s0jlIaOU+DIEEshhu5P8eBxu1+mrzYA0mVT1ENljjHUx7n4wj5h3NktgpF7duXFkIR4Z9yDA"}}}
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
$IU1ZxuT0Nte99MGUdW5IhEVc_pVMkrUEqjP5xs27dVs	$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4	!FzTtpSkXWMPYBKHUQN:localhost
$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o	$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4	!FzTtpSkXWMPYBKHUQN:localhost
$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o	$IU1ZxuT0Nte99MGUdW5IhEVc_pVMkrUEqjP5xs27dVs	!FzTtpSkXWMPYBKHUQN:localhost
$CgLbWRULI45y2D98z5CUQGfnpkIanhBTri6Qgk2FtZI	$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4	!FzTtpSkXWMPYBKHUQN:localhost
$CgLbWRULI45y2D98z5CUQGfnpkIanhBTri6Qgk2FtZI	$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o	!FzTtpSkXWMPYBKHUQN:localhost
$CgLbWRULI45y2D98z5CUQGfnpkIanhBTri6Qgk2FtZI	$IU1ZxuT0Nte99MGUdW5IhEVc_pVMkrUEqjP5xs27dVs	!FzTtpSkXWMPYBKHUQN:localhost
$MjPoUIyI-4SLUb_2CX0SN6Cq4siLSpO81XmSX0Tt1Ag	$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4	!FzTtpSkXWMPYBKHUQN:localhost
$MjPoUIyI-4SLUb_2CX0SN6Cq4siLSpO81XmSX0Tt1Ag	$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o	!FzTtpSkXWMPYBKHUQN:localhost
$MjPoUIyI-4SLUb_2CX0SN6Cq4siLSpO81XmSX0Tt1Ag	$IU1ZxuT0Nte99MGUdW5IhEVc_pVMkrUEqjP5xs27dVs	!FzTtpSkXWMPYBKHUQN:localhost
$eaTE2oVse5UGe2gxU6bH4McqUJFwuNN8UMpxUnfeCzc	$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4	!FzTtpSkXWMPYBKHUQN:localhost
$eaTE2oVse5UGe2gxU6bH4McqUJFwuNN8UMpxUnfeCzc	$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o	!FzTtpSkXWMPYBKHUQN:localhost
$eaTE2oVse5UGe2gxU6bH4McqUJFwuNN8UMpxUnfeCzc	$IU1ZxuT0Nte99MGUdW5IhEVc_pVMkrUEqjP5xs27dVs	!FzTtpSkXWMPYBKHUQN:localhost
$Z8l2x75Ktp4i5ZFSxqQHoicfewpQOJ2yKoIXvdXGGL4	$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4	!FzTtpSkXWMPYBKHUQN:localhost
$Z8l2x75Ktp4i5ZFSxqQHoicfewpQOJ2yKoIXvdXGGL4	$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o	!FzTtpSkXWMPYBKHUQN:localhost
$Z8l2x75Ktp4i5ZFSxqQHoicfewpQOJ2yKoIXvdXGGL4	$IU1ZxuT0Nte99MGUdW5IhEVc_pVMkrUEqjP5xs27dVs	!FzTtpSkXWMPYBKHUQN:localhost
$hZ3X11MNOocXcrcCNowWncNXGOcKtKz2Yuy15DpSX9Y	$gyvaweguHrwLjB1B_41QMnzSUMHQGbQmTALeOOMmWfU	!pYSbiOyjMFsKNxSMyi:localhost
$EgLH6XFurmJirUH4D5Zkm8y1WyPdrFX2SSko4S0-7hQ	$gyvaweguHrwLjB1B_41QMnzSUMHQGbQmTALeOOMmWfU	!pYSbiOyjMFsKNxSMyi:localhost
$EgLH6XFurmJirUH4D5Zkm8y1WyPdrFX2SSko4S0-7hQ	$hZ3X11MNOocXcrcCNowWncNXGOcKtKz2Yuy15DpSX9Y	!pYSbiOyjMFsKNxSMyi:localhost
$6A1pwZ_SweaaUsjoN5q44E3waqx9e_BX_Vch4BXsSMc	$gyvaweguHrwLjB1B_41QMnzSUMHQGbQmTALeOOMmWfU	!pYSbiOyjMFsKNxSMyi:localhost
$6A1pwZ_SweaaUsjoN5q44E3waqx9e_BX_Vch4BXsSMc	$EgLH6XFurmJirUH4D5Zkm8y1WyPdrFX2SSko4S0-7hQ	!pYSbiOyjMFsKNxSMyi:localhost
$6A1pwZ_SweaaUsjoN5q44E3waqx9e_BX_Vch4BXsSMc	$hZ3X11MNOocXcrcCNowWncNXGOcKtKz2Yuy15DpSX9Y	!pYSbiOyjMFsKNxSMyi:localhost
$tkoiHC3Vf1zAnFhhvTe60NQ7m3nRNvT1ILxtf8O8Tdc	$gyvaweguHrwLjB1B_41QMnzSUMHQGbQmTALeOOMmWfU	!pYSbiOyjMFsKNxSMyi:localhost
$tkoiHC3Vf1zAnFhhvTe60NQ7m3nRNvT1ILxtf8O8Tdc	$EgLH6XFurmJirUH4D5Zkm8y1WyPdrFX2SSko4S0-7hQ	!pYSbiOyjMFsKNxSMyi:localhost
$tkoiHC3Vf1zAnFhhvTe60NQ7m3nRNvT1ILxtf8O8Tdc	$hZ3X11MNOocXcrcCNowWncNXGOcKtKz2Yuy15DpSX9Y	!pYSbiOyjMFsKNxSMyi:localhost
$W2bBymarQF5AVOanxoytGxta4UVf4fhh6doJw6GmsQ0	$gyvaweguHrwLjB1B_41QMnzSUMHQGbQmTALeOOMmWfU	!pYSbiOyjMFsKNxSMyi:localhost
$W2bBymarQF5AVOanxoytGxta4UVf4fhh6doJw6GmsQ0	$EgLH6XFurmJirUH4D5Zkm8y1WyPdrFX2SSko4S0-7hQ	!pYSbiOyjMFsKNxSMyi:localhost
$W2bBymarQF5AVOanxoytGxta4UVf4fhh6doJw6GmsQ0	$hZ3X11MNOocXcrcCNowWncNXGOcKtKz2Yuy15DpSX9Y	!pYSbiOyjMFsKNxSMyi:localhost
$YSS-8MMEgCETq_EouYM-mm0KiVKGloqtULWeqmdQKZg	$gyvaweguHrwLjB1B_41QMnzSUMHQGbQmTALeOOMmWfU	!pYSbiOyjMFsKNxSMyi:localhost
$YSS-8MMEgCETq_EouYM-mm0KiVKGloqtULWeqmdQKZg	$EgLH6XFurmJirUH4D5Zkm8y1WyPdrFX2SSko4S0-7hQ	!pYSbiOyjMFsKNxSMyi:localhost
$YSS-8MMEgCETq_EouYM-mm0KiVKGloqtULWeqmdQKZg	$hZ3X11MNOocXcrcCNowWncNXGOcKtKz2Yuy15DpSX9Y	!pYSbiOyjMFsKNxSMyi:localhost
$0RmvI0B1zTbePI4eCXXUO_9tJQY2XcOy4Kt4FqYQ-Yk	$gyvaweguHrwLjB1B_41QMnzSUMHQGbQmTALeOOMmWfU	!pYSbiOyjMFsKNxSMyi:localhost
$0RmvI0B1zTbePI4eCXXUO_9tJQY2XcOy4Kt4FqYQ-Yk	$EgLH6XFurmJirUH4D5Zkm8y1WyPdrFX2SSko4S0-7hQ	!pYSbiOyjMFsKNxSMyi:localhost
$0RmvI0B1zTbePI4eCXXUO_9tJQY2XcOy4Kt4FqYQ-Yk	$tkoiHC3Vf1zAnFhhvTe60NQ7m3nRNvT1ILxtf8O8Tdc	!pYSbiOyjMFsKNxSMyi:localhost
$FSGyxWobRbm3XPzA_RJTfx_wFyj7eioybzttjovTej0	$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4	!FzTtpSkXWMPYBKHUQN:localhost
$FSGyxWobRbm3XPzA_RJTfx_wFyj7eioybzttjovTej0	$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o	!FzTtpSkXWMPYBKHUQN:localhost
$FSGyxWobRbm3XPzA_RJTfx_wFyj7eioybzttjovTej0	$MjPoUIyI-4SLUb_2CX0SN6Cq4siLSpO81XmSX0Tt1Ag	!FzTtpSkXWMPYBKHUQN:localhost
$3iFc4KVKwTYBpN8T8PyFgNCDxXkCtJF5qS1nJbulpmU	$MjPoUIyI-4SLUb_2CX0SN6Cq4siLSpO81XmSX0Tt1Ag	!FzTtpSkXWMPYBKHUQN:localhost
$f8S-mPLHMnruZFOTih-IYlCoYILk6A_BPx3dtO79ubI	$tkoiHC3Vf1zAnFhhvTe60NQ7m3nRNvT1ILxtf8O8Tdc	!pYSbiOyjMFsKNxSMyi:localhost
$3iFc4KVKwTYBpN8T8PyFgNCDxXkCtJF5qS1nJbulpmU	$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4	!FzTtpSkXWMPYBKHUQN:localhost
$3iFc4KVKwTYBpN8T8PyFgNCDxXkCtJF5qS1nJbulpmU	$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o	!FzTtpSkXWMPYBKHUQN:localhost
$f8S-mPLHMnruZFOTih-IYlCoYILk6A_BPx3dtO79ubI	$gyvaweguHrwLjB1B_41QMnzSUMHQGbQmTALeOOMmWfU	!pYSbiOyjMFsKNxSMyi:localhost
$f8S-mPLHMnruZFOTih-IYlCoYILk6A_BPx3dtO79ubI	$EgLH6XFurmJirUH4D5Zkm8y1WyPdrFX2SSko4S0-7hQ	!pYSbiOyjMFsKNxSMyi:localhost
$Q7qpUYZra7SmdftawkKRrQilka-WlRBbgKYybv2QRls	$tkoiHC3Vf1zAnFhhvTe60NQ7m3nRNvT1ILxtf8O8Tdc	!pYSbiOyjMFsKNxSMyi:localhost
$Q7qpUYZra7SmdftawkKRrQilka-WlRBbgKYybv2QRls	$gyvaweguHrwLjB1B_41QMnzSUMHQGbQmTALeOOMmWfU	!pYSbiOyjMFsKNxSMyi:localhost
$Q7qpUYZra7SmdftawkKRrQilka-WlRBbgKYybv2QRls	$EgLH6XFurmJirUH4D5Zkm8y1WyPdrFX2SSko4S0-7hQ	!pYSbiOyjMFsKNxSMyi:localhost
$Q7qpUYZra7SmdftawkKRrQilka-WlRBbgKYybv2QRls	$f8S-mPLHMnruZFOTih-IYlCoYILk6A_BPx3dtO79ubI	!pYSbiOyjMFsKNxSMyi:localhost
$o5ttVgA4qLDCRoIxN9qyVPOLj9QUajTOF3D_U8es57Y	$MjPoUIyI-4SLUb_2CX0SN6Cq4siLSpO81XmSX0Tt1Ag	!FzTtpSkXWMPYBKHUQN:localhost
$o5ttVgA4qLDCRoIxN9qyVPOLj9QUajTOF3D_U8es57Y	$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4	!FzTtpSkXWMPYBKHUQN:localhost
$o5ttVgA4qLDCRoIxN9qyVPOLj9QUajTOF3D_U8es57Y	$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o	!FzTtpSkXWMPYBKHUQN:localhost
$o5ttVgA4qLDCRoIxN9qyVPOLj9QUajTOF3D_U8es57Y	$3iFc4KVKwTYBpN8T8PyFgNCDxXkCtJF5qS1nJbulpmU	!FzTtpSkXWMPYBKHUQN:localhost
$EeKexStxnjQMJwZnkxIZRNXLdggHQGqT_RJYm1xCocU	$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4	!FzTtpSkXWMPYBKHUQN:localhost
$EeKexStxnjQMJwZnkxIZRNXLdggHQGqT_RJYm1xCocU	$MjPoUIyI-4SLUb_2CX0SN6Cq4siLSpO81XmSX0Tt1Ag	!FzTtpSkXWMPYBKHUQN:localhost
$EeKexStxnjQMJwZnkxIZRNXLdggHQGqT_RJYm1xCocU	$IU1ZxuT0Nte99MGUdW5IhEVc_pVMkrUEqjP5xs27dVs	!FzTtpSkXWMPYBKHUQN:localhost
$EeKexStxnjQMJwZnkxIZRNXLdggHQGqT_RJYm1xCocU	$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o	!FzTtpSkXWMPYBKHUQN:localhost
$ZPGmNdM7zvGVfx5_posO0xAJ7C6aAnDZavYGV23i3eM	$EeKexStxnjQMJwZnkxIZRNXLdggHQGqT_RJYm1xCocU	!FzTtpSkXWMPYBKHUQN:localhost
$ZPGmNdM7zvGVfx5_posO0xAJ7C6aAnDZavYGV23i3eM	$MjPoUIyI-4SLUb_2CX0SN6Cq4siLSpO81XmSX0Tt1Ag	!FzTtpSkXWMPYBKHUQN:localhost
$ZPGmNdM7zvGVfx5_posO0xAJ7C6aAnDZavYGV23i3eM	$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o	!FzTtpSkXWMPYBKHUQN:localhost
$ZPGmNdM7zvGVfx5_posO0xAJ7C6aAnDZavYGV23i3eM	$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4	!FzTtpSkXWMPYBKHUQN:localhost
$DRO5TAucLHxvrlJ47kjeEKQiKn1D0J-pwsDdrExDhfM	$IU1ZxuT0Nte99MGUdW5IhEVc_pVMkrUEqjP5xs27dVs	!FzTtpSkXWMPYBKHUQN:localhost
$DRO5TAucLHxvrlJ47kjeEKQiKn1D0J-pwsDdrExDhfM	$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o	!FzTtpSkXWMPYBKHUQN:localhost
$DRO5TAucLHxvrlJ47kjeEKQiKn1D0J-pwsDdrExDhfM	$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4	!FzTtpSkXWMPYBKHUQN:localhost
$2AEp1hOUUsulI8Zc2ISpcmI9VmKuftWZdClPUSC_mD4	$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg	!AHOiTmgdxQzlhIOUsy:localhost
$425aYo_LNE95R3HHpQZSk0MGS0CjqhCPkp0DJvtMk5M	$2AEp1hOUUsulI8Zc2ISpcmI9VmKuftWZdClPUSC_mD4	!AHOiTmgdxQzlhIOUsy:localhost
$425aYo_LNE95R3HHpQZSk0MGS0CjqhCPkp0DJvtMk5M	$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg	!AHOiTmgdxQzlhIOUsy:localhost
$z1GwtHO3iyw6MvOYBxrwIdl_jvUlP6_Bn6yFfE9P2aI	$2AEp1hOUUsulI8Zc2ISpcmI9VmKuftWZdClPUSC_mD4	!AHOiTmgdxQzlhIOUsy:localhost
$z1GwtHO3iyw6MvOYBxrwIdl_jvUlP6_Bn6yFfE9P2aI	$425aYo_LNE95R3HHpQZSk0MGS0CjqhCPkp0DJvtMk5M	!AHOiTmgdxQzlhIOUsy:localhost
$z1GwtHO3iyw6MvOYBxrwIdl_jvUlP6_Bn6yFfE9P2aI	$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg	!AHOiTmgdxQzlhIOUsy:localhost
$Ww-5pR04rXtgZleTLBj7vJSR1LGkC3tZ5Zuaxqazwek	$2AEp1hOUUsulI8Zc2ISpcmI9VmKuftWZdClPUSC_mD4	!AHOiTmgdxQzlhIOUsy:localhost
$Ww-5pR04rXtgZleTLBj7vJSR1LGkC3tZ5Zuaxqazwek	$425aYo_LNE95R3HHpQZSk0MGS0CjqhCPkp0DJvtMk5M	!AHOiTmgdxQzlhIOUsy:localhost
$Ww-5pR04rXtgZleTLBj7vJSR1LGkC3tZ5Zuaxqazwek	$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg	!AHOiTmgdxQzlhIOUsy:localhost
$LmDzEqXVjmgNKIk52bhBmbosSuVDk32P02nhwggY0RM	$2AEp1hOUUsulI8Zc2ISpcmI9VmKuftWZdClPUSC_mD4	!AHOiTmgdxQzlhIOUsy:localhost
$LmDzEqXVjmgNKIk52bhBmbosSuVDk32P02nhwggY0RM	$425aYo_LNE95R3HHpQZSk0MGS0CjqhCPkp0DJvtMk5M	!AHOiTmgdxQzlhIOUsy:localhost
$LmDzEqXVjmgNKIk52bhBmbosSuVDk32P02nhwggY0RM	$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg	!AHOiTmgdxQzlhIOUsy:localhost
$sFv4HsuqMN9A0Wl_Bb1tZ-I7Kgdtxe83YsRaNWowWDM	$2AEp1hOUUsulI8Zc2ISpcmI9VmKuftWZdClPUSC_mD4	!AHOiTmgdxQzlhIOUsy:localhost
$sFv4HsuqMN9A0Wl_Bb1tZ-I7Kgdtxe83YsRaNWowWDM	$425aYo_LNE95R3HHpQZSk0MGS0CjqhCPkp0DJvtMk5M	!AHOiTmgdxQzlhIOUsy:localhost
$sFv4HsuqMN9A0Wl_Bb1tZ-I7Kgdtxe83YsRaNWowWDM	$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg	!AHOiTmgdxQzlhIOUsy:localhost
$xOF81meT9KSyhw3dY5FjCzADSBULEj6OoQaHM9DWtMY	$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg	!AHOiTmgdxQzlhIOUsy:localhost
$xOF81meT9KSyhw3dY5FjCzADSBULEj6OoQaHM9DWtMY	$Ww-5pR04rXtgZleTLBj7vJSR1LGkC3tZ5Zuaxqazwek	!AHOiTmgdxQzlhIOUsy:localhost
$xOF81meT9KSyhw3dY5FjCzADSBULEj6OoQaHM9DWtMY	$2AEp1hOUUsulI8Zc2ISpcmI9VmKuftWZdClPUSC_mD4	!AHOiTmgdxQzlhIOUsy:localhost
$xOF81meT9KSyhw3dY5FjCzADSBULEj6OoQaHM9DWtMY	$425aYo_LNE95R3HHpQZSk0MGS0CjqhCPkp0DJvtMk5M	!AHOiTmgdxQzlhIOUsy:localhost
$cgYituIGJ7X54S5-Ax3C5u2yLwCnf99x2VbMmy0YD3w	$Ww-5pR04rXtgZleTLBj7vJSR1LGkC3tZ5Zuaxqazwek	!AHOiTmgdxQzlhIOUsy:localhost
$cgYituIGJ7X54S5-Ax3C5u2yLwCnf99x2VbMmy0YD3w	$xOF81meT9KSyhw3dY5FjCzADSBULEj6OoQaHM9DWtMY	!AHOiTmgdxQzlhIOUsy:localhost
$cgYituIGJ7X54S5-Ax3C5u2yLwCnf99x2VbMmy0YD3w	$425aYo_LNE95R3HHpQZSk0MGS0CjqhCPkp0DJvtMk5M	!AHOiTmgdxQzlhIOUsy:localhost
$cgYituIGJ7X54S5-Ax3C5u2yLwCnf99x2VbMmy0YD3w	$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg	!AHOiTmgdxQzlhIOUsy:localhost
$hgeuyu5_SLbd99TLf-m4kSUM8l1Jy-W4XmhdQGO2rr0	$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg	!AHOiTmgdxQzlhIOUsy:localhost
$hgeuyu5_SLbd99TLf-m4kSUM8l1Jy-W4XmhdQGO2rr0	$Ww-5pR04rXtgZleTLBj7vJSR1LGkC3tZ5Zuaxqazwek	!AHOiTmgdxQzlhIOUsy:localhost
$hgeuyu5_SLbd99TLf-m4kSUM8l1Jy-W4XmhdQGO2rr0	$2AEp1hOUUsulI8Zc2ISpcmI9VmKuftWZdClPUSC_mD4	!AHOiTmgdxQzlhIOUsy:localhost
$hgeuyu5_SLbd99TLf-m4kSUM8l1Jy-W4XmhdQGO2rr0	$425aYo_LNE95R3HHpQZSk0MGS0CjqhCPkp0DJvtMk5M	!AHOiTmgdxQzlhIOUsy:localhost
$jiXC1l1ou9Ti0I7CV7PJrsVblqsrb9dPQentqZqLBys	$hgeuyu5_SLbd99TLf-m4kSUM8l1Jy-W4XmhdQGO2rr0	!AHOiTmgdxQzlhIOUsy:localhost
$jiXC1l1ou9Ti0I7CV7PJrsVblqsrb9dPQentqZqLBys	$Ww-5pR04rXtgZleTLBj7vJSR1LGkC3tZ5Zuaxqazwek	!AHOiTmgdxQzlhIOUsy:localhost
$jiXC1l1ou9Ti0I7CV7PJrsVblqsrb9dPQentqZqLBys	$425aYo_LNE95R3HHpQZSk0MGS0CjqhCPkp0DJvtMk5M	!AHOiTmgdxQzlhIOUsy:localhost
$jiXC1l1ou9Ti0I7CV7PJrsVblqsrb9dPQentqZqLBys	$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg	!AHOiTmgdxQzlhIOUsy:localhost
$ye7ixCV2UmoA3GCF2K5lqNSxMrWwkdvkTSOdQDHy-P0	$Ww-5pR04rXtgZleTLBj7vJSR1LGkC3tZ5Zuaxqazwek	!AHOiTmgdxQzlhIOUsy:localhost
$ye7ixCV2UmoA3GCF2K5lqNSxMrWwkdvkTSOdQDHy-P0	$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg	!AHOiTmgdxQzlhIOUsy:localhost
$ye7ixCV2UmoA3GCF2K5lqNSxMrWwkdvkTSOdQDHy-P0	$425aYo_LNE95R3HHpQZSk0MGS0CjqhCPkp0DJvtMk5M	!AHOiTmgdxQzlhIOUsy:localhost
$0XMDIAwJBH-iA7qIReHWRJAwmGiTGGioVtV8KFmJ4_M	$Ww-5pR04rXtgZleTLBj7vJSR1LGkC3tZ5Zuaxqazwek	!AHOiTmgdxQzlhIOUsy:localhost
$0XMDIAwJBH-iA7qIReHWRJAwmGiTGGioVtV8KFmJ4_M	$cgYituIGJ7X54S5-Ax3C5u2yLwCnf99x2VbMmy0YD3w	!AHOiTmgdxQzlhIOUsy:localhost
$0XMDIAwJBH-iA7qIReHWRJAwmGiTGGioVtV8KFmJ4_M	$425aYo_LNE95R3HHpQZSk0MGS0CjqhCPkp0DJvtMk5M	!AHOiTmgdxQzlhIOUsy:localhost
$0XMDIAwJBH-iA7qIReHWRJAwmGiTGGioVtV8KFmJ4_M	$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg	!AHOiTmgdxQzlhIOUsy:localhost
\.


--
-- Data for Name: event_auth_chain_links; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_auth_chain_links (origin_chain_id, origin_sequence_number, target_chain_id, target_sequence_number) FROM stdin;
2	1	1	1
5	1	3	1
5	1	1	1
4	1	2	1
3	1	1	1
4	1	3	1
5	1	2	1
4	1	1	1
3	1	2	1
6	1	1	1
6	1	2	1
6	1	3	1
7	1	3	1
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
10	1	13	1
11	1	9	1
13	1	8	1
13	1	9	1
14	1	13	1
14	1	8	1
14	1	9	1
15	1	8	1
15	1	9	1
15	1	12	1
15	1	13	1
16	1	1	1
16	1	2	1
16	1	3	1
16	1	4	1
18	1	1	1
17	1	13	1
17	1	8	1
17	1	9	1
17	1	12	1
18	1	3	1
18	1	4	1
18	1	2	1
19	1	3	1
19	1	1	1
19	1	4	1
19	1	2	1
20	1	2	1
20	1	3	1
20	1	1	1
22	1	21	1
26	1	21	1
24	1	25	1
24	1	21	1
25	1	21	1
26	1	22	1
25	1	22	1
23	1	25	1
23	1	21	1
24	1	22	1
23	1	22	1
26	1	25	1
27	1	25	1
27	1	22	1
27	1	21	1
28	1	21	1
28	1	22	1
28	1	25	1
28	1	26	1
29	1	25	1
29	1	22	1
29	1	26	1
29	1	21	1
30	1	21	1
30	1	25	1
30	1	22	1
30	1	26	1
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
$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4	1	1
$IU1ZxuT0Nte99MGUdW5IhEVc_pVMkrUEqjP5xs27dVs	2	1
$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o	3	1
$CgLbWRULI45y2D98z5CUQGfnpkIanhBTri6Qgk2FtZI	6	1
$MjPoUIyI-4SLUb_2CX0SN6Cq4siLSpO81XmSX0Tt1Ag	4	1
$eaTE2oVse5UGe2gxU6bH4McqUJFwuNN8UMpxUnfeCzc	5	1
$Z8l2x75Ktp4i5ZFSxqQHoicfewpQOJ2yKoIXvdXGGL4	7	1
$gyvaweguHrwLjB1B_41QMnzSUMHQGbQmTALeOOMmWfU	8	1
$hZ3X11MNOocXcrcCNowWncNXGOcKtKz2Yuy15DpSX9Y	9	1
$EgLH6XFurmJirUH4D5Zkm8y1WyPdrFX2SSko4S0-7hQ	13	1
$6A1pwZ_SweaaUsjoN5q44E3waqx9e_BX_Vch4BXsSMc	11	1
$W2bBymarQF5AVOanxoytGxta4UVf4fhh6doJw6GmsQ0	10	1
$tkoiHC3Vf1zAnFhhvTe60NQ7m3nRNvT1ILxtf8O8Tdc	12	1
$YSS-8MMEgCETq_EouYM-mm0KiVKGloqtULWeqmdQKZg	14	1
$0RmvI0B1zTbePI4eCXXUO_9tJQY2XcOy4Kt4FqYQ-Yk	15	1
$FSGyxWobRbm3XPzA_RJTfx_wFyj7eioybzttjovTej0	16	1
$f8S-mPLHMnruZFOTih-IYlCoYILk6A_BPx3dtO79ubI	17	1
$3iFc4KVKwTYBpN8T8PyFgNCDxXkCtJF5qS1nJbulpmU	18	1
$Q7qpUYZra7SmdftawkKRrQilka-WlRBbgKYybv2QRls	17	2
$o5ttVgA4qLDCRoIxN9qyVPOLj9QUajTOF3D_U8es57Y	18	2
$EeKexStxnjQMJwZnkxIZRNXLdggHQGqT_RJYm1xCocU	19	1
$ZPGmNdM7zvGVfx5_posO0xAJ7C6aAnDZavYGV23i3eM	19	2
$DRO5TAucLHxvrlJ47kjeEKQiKn1D0J-pwsDdrExDhfM	20	1
$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg	21	1
$2AEp1hOUUsulI8Zc2ISpcmI9VmKuftWZdClPUSC_mD4	22	1
$425aYo_LNE95R3HHpQZSk0MGS0CjqhCPkp0DJvtMk5M	25	1
$LmDzEqXVjmgNKIk52bhBmbosSuVDk32P02nhwggY0RM	24	1
$Ww-5pR04rXtgZleTLBj7vJSR1LGkC3tZ5Zuaxqazwek	26	1
$z1GwtHO3iyw6MvOYBxrwIdl_jvUlP6_Bn6yFfE9P2aI	23	1
$sFv4HsuqMN9A0Wl_Bb1tZ-I7Kgdtxe83YsRaNWowWDM	27	1
$xOF81meT9KSyhw3dY5FjCzADSBULEj6OoQaHM9DWtMY	28	1
$cgYituIGJ7X54S5-Ax3C5u2yLwCnf99x2VbMmy0YD3w	28	2
$hgeuyu5_SLbd99TLf-m4kSUM8l1Jy-W4XmhdQGO2rr0	29	1
$jiXC1l1ou9Ti0I7CV7PJrsVblqsrb9dPQentqZqLBys	29	2
$ye7ixCV2UmoA3GCF2K5lqNSxMrWwkdvkTSOdQDHy-P0	30	1
$0XMDIAwJBH-iA7qIReHWRJAwmGiTGGioVtV8KFmJ4_M	28	3
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
$IU1ZxuT0Nte99MGUdW5IhEVc_pVMkrUEqjP5xs27dVs	$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4	\N	f
$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o	$IU1ZxuT0Nte99MGUdW5IhEVc_pVMkrUEqjP5xs27dVs	\N	f
$CgLbWRULI45y2D98z5CUQGfnpkIanhBTri6Qgk2FtZI	$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o	\N	f
$MjPoUIyI-4SLUb_2CX0SN6Cq4siLSpO81XmSX0Tt1Ag	$CgLbWRULI45y2D98z5CUQGfnpkIanhBTri6Qgk2FtZI	\N	f
$eaTE2oVse5UGe2gxU6bH4McqUJFwuNN8UMpxUnfeCzc	$MjPoUIyI-4SLUb_2CX0SN6Cq4siLSpO81XmSX0Tt1Ag	\N	f
$Z8l2x75Ktp4i5ZFSxqQHoicfewpQOJ2yKoIXvdXGGL4	$eaTE2oVse5UGe2gxU6bH4McqUJFwuNN8UMpxUnfeCzc	\N	f
$hZ3X11MNOocXcrcCNowWncNXGOcKtKz2Yuy15DpSX9Y	$gyvaweguHrwLjB1B_41QMnzSUMHQGbQmTALeOOMmWfU	\N	f
$EgLH6XFurmJirUH4D5Zkm8y1WyPdrFX2SSko4S0-7hQ	$hZ3X11MNOocXcrcCNowWncNXGOcKtKz2Yuy15DpSX9Y	\N	f
$6A1pwZ_SweaaUsjoN5q44E3waqx9e_BX_Vch4BXsSMc	$EgLH6XFurmJirUH4D5Zkm8y1WyPdrFX2SSko4S0-7hQ	\N	f
$tkoiHC3Vf1zAnFhhvTe60NQ7m3nRNvT1ILxtf8O8Tdc	$6A1pwZ_SweaaUsjoN5q44E3waqx9e_BX_Vch4BXsSMc	\N	f
$W2bBymarQF5AVOanxoytGxta4UVf4fhh6doJw6GmsQ0	$tkoiHC3Vf1zAnFhhvTe60NQ7m3nRNvT1ILxtf8O8Tdc	\N	f
$YSS-8MMEgCETq_EouYM-mm0KiVKGloqtULWeqmdQKZg	$W2bBymarQF5AVOanxoytGxta4UVf4fhh6doJw6GmsQ0	\N	f
$0RmvI0B1zTbePI4eCXXUO_9tJQY2XcOy4Kt4FqYQ-Yk	$YSS-8MMEgCETq_EouYM-mm0KiVKGloqtULWeqmdQKZg	\N	f
$FSGyxWobRbm3XPzA_RJTfx_wFyj7eioybzttjovTej0	$Z8l2x75Ktp4i5ZFSxqQHoicfewpQOJ2yKoIXvdXGGL4	\N	f
$3iFc4KVKwTYBpN8T8PyFgNCDxXkCtJF5qS1nJbulpmU	$FSGyxWobRbm3XPzA_RJTfx_wFyj7eioybzttjovTej0	\N	f
$f8S-mPLHMnruZFOTih-IYlCoYILk6A_BPx3dtO79ubI	$0RmvI0B1zTbePI4eCXXUO_9tJQY2XcOy4Kt4FqYQ-Yk	\N	f
$Q7qpUYZra7SmdftawkKRrQilka-WlRBbgKYybv2QRls	$f8S-mPLHMnruZFOTih-IYlCoYILk6A_BPx3dtO79ubI	\N	f
$o5ttVgA4qLDCRoIxN9qyVPOLj9QUajTOF3D_U8es57Y	$3iFc4KVKwTYBpN8T8PyFgNCDxXkCtJF5qS1nJbulpmU	\N	f
$ws9UuWLPn8VzHbofyg3g8AQK-aYsdD2iv6woyWt3sEw	$Q7qpUYZra7SmdftawkKRrQilka-WlRBbgKYybv2QRls	\N	f
$EeKexStxnjQMJwZnkxIZRNXLdggHQGqT_RJYm1xCocU	$o5ttVgA4qLDCRoIxN9qyVPOLj9QUajTOF3D_U8es57Y	\N	f
$ZPGmNdM7zvGVfx5_posO0xAJ7C6aAnDZavYGV23i3eM	$EeKexStxnjQMJwZnkxIZRNXLdggHQGqT_RJYm1xCocU	\N	f
$ls5AzJlLTu3Alykxvj5L99HqOQsi7cUGH7wVb-IqErQ	$ZPGmNdM7zvGVfx5_posO0xAJ7C6aAnDZavYGV23i3eM	\N	f
$nFwL1txBnk2dj72aBWqthTGHrC-kv7CYWMt3cwz8qgw	$ws9UuWLPn8VzHbofyg3g8AQK-aYsdD2iv6woyWt3sEw	\N	f
$DRO5TAucLHxvrlJ47kjeEKQiKn1D0J-pwsDdrExDhfM	$ls5AzJlLTu3Alykxvj5L99HqOQsi7cUGH7wVb-IqErQ	\N	f
$hXzRSYfNTLUmjRz8EgsrekOmklfOoUQ9NKx0vS1AmTk	$DRO5TAucLHxvrlJ47kjeEKQiKn1D0J-pwsDdrExDhfM	\N	f
$fbEIs1FPebLFup8Sm4TvsnGt3OqnXO125KPufsX6e4E	$hXzRSYfNTLUmjRz8EgsrekOmklfOoUQ9NKx0vS1AmTk	\N	f
$ggCddRubeCPps5yMhlY-9Ib0RvBhwUJy716vZvf32Oo	$fbEIs1FPebLFup8Sm4TvsnGt3OqnXO125KPufsX6e4E	\N	f
$2AEp1hOUUsulI8Zc2ISpcmI9VmKuftWZdClPUSC_mD4	$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg	\N	f
$425aYo_LNE95R3HHpQZSk0MGS0CjqhCPkp0DJvtMk5M	$2AEp1hOUUsulI8Zc2ISpcmI9VmKuftWZdClPUSC_mD4	\N	f
$z1GwtHO3iyw6MvOYBxrwIdl_jvUlP6_Bn6yFfE9P2aI	$425aYo_LNE95R3HHpQZSk0MGS0CjqhCPkp0DJvtMk5M	\N	f
$Ww-5pR04rXtgZleTLBj7vJSR1LGkC3tZ5Zuaxqazwek	$z1GwtHO3iyw6MvOYBxrwIdl_jvUlP6_Bn6yFfE9P2aI	\N	f
$LmDzEqXVjmgNKIk52bhBmbosSuVDk32P02nhwggY0RM	$Ww-5pR04rXtgZleTLBj7vJSR1LGkC3tZ5Zuaxqazwek	\N	f
$sFv4HsuqMN9A0Wl_Bb1tZ-I7Kgdtxe83YsRaNWowWDM	$LmDzEqXVjmgNKIk52bhBmbosSuVDk32P02nhwggY0RM	\N	f
$xOF81meT9KSyhw3dY5FjCzADSBULEj6OoQaHM9DWtMY	$sFv4HsuqMN9A0Wl_Bb1tZ-I7Kgdtxe83YsRaNWowWDM	\N	f
$cgYituIGJ7X54S5-Ax3C5u2yLwCnf99x2VbMmy0YD3w	$xOF81meT9KSyhw3dY5FjCzADSBULEj6OoQaHM9DWtMY	\N	f
$hgeuyu5_SLbd99TLf-m4kSUM8l1Jy-W4XmhdQGO2rr0	$cgYituIGJ7X54S5-Ax3C5u2yLwCnf99x2VbMmy0YD3w	\N	f
$jiXC1l1ou9Ti0I7CV7PJrsVblqsrb9dPQentqZqLBys	$hgeuyu5_SLbd99TLf-m4kSUM8l1Jy-W4XmhdQGO2rr0	\N	f
$v3jGyApp70gdwh4Il9oB6nRxdyr-zF1Nt9w5VRI1Em4	$jiXC1l1ou9Ti0I7CV7PJrsVblqsrb9dPQentqZqLBys	\N	f
$ye7ixCV2UmoA3GCF2K5lqNSxMrWwkdvkTSOdQDHy-P0	$v3jGyApp70gdwh4Il9oB6nRxdyr-zF1Nt9w5VRI1Em4	\N	f
$95vJ25qtpsri2l4-Ft6bN-NMw1uq9NjdTcLLt_v-cdE	$ye7ixCV2UmoA3GCF2K5lqNSxMrWwkdvkTSOdQDHy-P0	\N	f
$0XMDIAwJBH-iA7qIReHWRJAwmGiTGGioVtV8KFmJ4_M	$95vJ25qtpsri2l4-Ft6bN-NMw1uq9NjdTcLLt_v-cdE	\N	f
$cy5KlfdXxrxwsh3JYgCvSt79RGqs9e0nqUdGznRRG7c	$0XMDIAwJBH-iA7qIReHWRJAwmGiTGGioVtV8KFmJ4_M	\N	f
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
$nFwL1txBnk2dj72aBWqthTGHrC-kv7CYWMt3cwz8qgw	!pYSbiOyjMFsKNxSMyi:localhost
$ggCddRubeCPps5yMhlY-9Ib0RvBhwUJy716vZvf32Oo	!FzTtpSkXWMPYBKHUQN:localhost
$cy5KlfdXxrxwsh3JYgCvSt79RGqs9e0nqUdGznRRG7c	!AHOiTmgdxQzlhIOUsy:localhost
\.


--
-- Data for Name: event_json; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_json (event_id, room_id, internal_metadata, json, format_version) FROM stdin;
$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4	!FzTtpSkXWMPYBKHUQN:localhost	{"token_id":3,"historical":false}	{"auth_events":[],"prev_events":[],"type":"m.room.create","room_id":"!FzTtpSkXWMPYBKHUQN:localhost","sender":"@admin:localhost","content":{"room_version":"9","creator":"@admin:localhost"},"depth":1,"state_key":"","origin":"localhost","origin_server_ts":1675956617863,"hashes":{"sha256":"yz2MP47GF8FUtoDAWwWXt1HWtoX8RjBPSaHDT+AdWoU"},"signatures":{"localhost":{"ed25519:a_vyji":"PDKxbRA1ODaOOHOgKQwHBd4CYqbXZP0SG8f4PDvX1VNDO9n7vySFNu+U8BuwpyI8VXvH84dZV52fY5EGcO2MAQ"}},"unsigned":{"age_ts":1675956617863}}	3
$IU1ZxuT0Nte99MGUdW5IhEVc_pVMkrUEqjP5xs27dVs	!FzTtpSkXWMPYBKHUQN:localhost	{"token_id":3,"historical":false}	{"auth_events":["$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4"],"prev_events":["$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4"],"type":"m.room.member","room_id":"!FzTtpSkXWMPYBKHUQN:localhost","sender":"@admin:localhost","content":{"membership":"join","displayname":"admin"},"depth":2,"state_key":"@admin:localhost","origin":"localhost","origin_server_ts":1675956618047,"hashes":{"sha256":"TWMVDQYSOKc9im9mdjJig1bKV6Ml+2Uc4anZHvKjlVo"},"signatures":{"localhost":{"ed25519:a_vyji":"lInbxw4ubPMRAWDt/SQaon3LnCva8JhKhxpU20WKseoYvZ43wnRQm2+46xl6o13NzTOd6LfNG6GPR/Ueu2URAQ"}},"unsigned":{"age_ts":1675956618047}}	3
$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o	!FzTtpSkXWMPYBKHUQN:localhost	{"token_id":3,"historical":false}	{"auth_events":["$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4","$IU1ZxuT0Nte99MGUdW5IhEVc_pVMkrUEqjP5xs27dVs"],"prev_events":["$IU1ZxuT0Nte99MGUdW5IhEVc_pVMkrUEqjP5xs27dVs"],"type":"m.room.power_levels","room_id":"!FzTtpSkXWMPYBKHUQN:localhost","sender":"@admin:localhost","content":{"users":{"@admin:localhost":100},"users_default":0,"events":{"m.room.name":50,"m.room.power_levels":100,"m.room.history_visibility":100,"m.room.canonical_alias":50,"m.room.avatar":50,"m.room.tombstone":100,"m.room.server_acl":100,"m.room.encryption":100},"events_default":0,"state_default":50,"ban":50,"kick":50,"redact":50,"invite":50,"historical":100},"depth":3,"state_key":"","origin":"localhost","origin_server_ts":1675956618184,"hashes":{"sha256":"lF7+QAeac78SfETACkrl9/FcVUbKjeL40wcYJJkDQ7U"},"signatures":{"localhost":{"ed25519:a_vyji":"j6a5VoengEn+FzW/Gwkf2hMM1iaYitnov9uV+8Ek9puu82IttpsRkm8Ae5jAlVDYrzmrwiax2ctTTsodCZGfCw"}},"unsigned":{"age_ts":1675956618184}}	3
$CgLbWRULI45y2D98z5CUQGfnpkIanhBTri6Qgk2FtZI	!FzTtpSkXWMPYBKHUQN:localhost	{"token_id":3,"historical":false}	{"auth_events":["$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4","$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o","$IU1ZxuT0Nte99MGUdW5IhEVc_pVMkrUEqjP5xs27dVs"],"prev_events":["$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o"],"type":"m.room.canonical_alias","room_id":"!FzTtpSkXWMPYBKHUQN:localhost","sender":"@admin:localhost","content":{"alias":"#town-square:localhost"},"depth":4,"state_key":"","origin":"localhost","origin_server_ts":1675956618243,"hashes":{"sha256":"DhNX7+KvHeoC6NST56kNEAB2xI2cqmSN37ojsCA/iY0"},"signatures":{"localhost":{"ed25519:a_vyji":"nk/PzKAJG76cDzZ46PJl678Jktxh9XJpoNxibLxr5ffvk3+60U1nWpvh9I8RljIc79QA+Fo3bqg/5YF5wDqODA"}},"unsigned":{"age_ts":1675956618243}}	3
$MjPoUIyI-4SLUb_2CX0SN6Cq4siLSpO81XmSX0Tt1Ag	!FzTtpSkXWMPYBKHUQN:localhost	{"token_id":3,"historical":false}	{"auth_events":["$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4","$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o","$IU1ZxuT0Nte99MGUdW5IhEVc_pVMkrUEqjP5xs27dVs"],"prev_events":["$CgLbWRULI45y2D98z5CUQGfnpkIanhBTri6Qgk2FtZI"],"type":"m.room.join_rules","room_id":"!FzTtpSkXWMPYBKHUQN:localhost","sender":"@admin:localhost","content":{"join_rule":"public"},"depth":5,"state_key":"","origin":"localhost","origin_server_ts":1675956618273,"hashes":{"sha256":"o6hHm1Xq5Rrok7ob60bhruFDKqeBSjHOjXX9YcGduSA"},"signatures":{"localhost":{"ed25519:a_vyji":"C0kW+WXsW9ZPMcrGTrpT4S025XZT/+JoNrY9N84yGZ0MN/XTrt5i7Ti7w4sqbQa7uTA3f+3pCdQIJ8LxjiWfAw"}},"unsigned":{"age_ts":1675956618273}}	3
$eaTE2oVse5UGe2gxU6bH4McqUJFwuNN8UMpxUnfeCzc	!FzTtpSkXWMPYBKHUQN:localhost	{"token_id":3,"historical":false}	{"auth_events":["$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4","$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o","$IU1ZxuT0Nte99MGUdW5IhEVc_pVMkrUEqjP5xs27dVs"],"prev_events":["$MjPoUIyI-4SLUb_2CX0SN6Cq4siLSpO81XmSX0Tt1Ag"],"type":"m.room.history_visibility","room_id":"!FzTtpSkXWMPYBKHUQN:localhost","sender":"@admin:localhost","content":{"history_visibility":"shared"},"depth":6,"state_key":"","origin":"localhost","origin_server_ts":1675956618289,"hashes":{"sha256":"8XDpCy3SatAoPi3ZcvsCCYHIMmay9ns/Tp+YGzbVJmo"},"signatures":{"localhost":{"ed25519:a_vyji":"kKl7xaUm1hEaDbyo6UKfrfw2Hmn3VWUx2TOgT9n6TnSAxmasLu1i0Q9Y9H4zpZNvCcTd+dT/G+4uULJFo+w8Dg"}},"unsigned":{"age_ts":1675956618289}}	3
$Z8l2x75Ktp4i5ZFSxqQHoicfewpQOJ2yKoIXvdXGGL4	!FzTtpSkXWMPYBKHUQN:localhost	{"token_id":3,"historical":false}	{"auth_events":["$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4","$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o","$IU1ZxuT0Nte99MGUdW5IhEVc_pVMkrUEqjP5xs27dVs"],"prev_events":["$eaTE2oVse5UGe2gxU6bH4McqUJFwuNN8UMpxUnfeCzc"],"type":"m.room.name","room_id":"!FzTtpSkXWMPYBKHUQN:localhost","sender":"@admin:localhost","content":{"name":"#Town Square"},"depth":7,"state_key":"","origin":"localhost","origin_server_ts":1675956618677,"hashes":{"sha256":"C5VXMRbgSxXozzoq8fTF9NeZ0mO28U+boMrceaxNpJM"},"signatures":{"localhost":{"ed25519:a_vyji":"xCAag8CyUfKcpb+NgQXWMByKw46tsqQwXFRLw7YCdpJMF+8T1FPj2s0YeXAz8laqBEkIKf9J6ELRK2MeIZVDDQ"}},"unsigned":{"age_ts":1675956618677}}	3
$gyvaweguHrwLjB1B_41QMnzSUMHQGbQmTALeOOMmWfU	!pYSbiOyjMFsKNxSMyi:localhost	{"token_id":3,"historical":false}	{"auth_events":[],"prev_events":[],"type":"m.room.create","room_id":"!pYSbiOyjMFsKNxSMyi:localhost","sender":"@admin:localhost","content":{"room_version":"9","creator":"@admin:localhost"},"depth":1,"state_key":"","origin":"localhost","origin_server_ts":1675956696635,"hashes":{"sha256":"70z+YhWQwpIZmuxlbj8thf1M9tqINZl9s/sfwRZj1j4"},"signatures":{"localhost":{"ed25519:a_vyji":"WyfotNKC900h7u9rFYMclr8DzhLtb/s0DSO2QO1nU369KSQ9DnbxuItue8ghAresfjakeU5h9ChXhRuijfyYCA"}},"unsigned":{"age_ts":1675956696635}}	3
$hZ3X11MNOocXcrcCNowWncNXGOcKtKz2Yuy15DpSX9Y	!pYSbiOyjMFsKNxSMyi:localhost	{"token_id":3,"historical":false}	{"auth_events":["$gyvaweguHrwLjB1B_41QMnzSUMHQGbQmTALeOOMmWfU"],"prev_events":["$gyvaweguHrwLjB1B_41QMnzSUMHQGbQmTALeOOMmWfU"],"type":"m.room.member","room_id":"!pYSbiOyjMFsKNxSMyi:localhost","sender":"@admin:localhost","content":{"membership":"join","displayname":"admin"},"depth":2,"state_key":"@admin:localhost","origin":"localhost","origin_server_ts":1675956696749,"hashes":{"sha256":"cssq6r3mRv4Oump60rBJngbYOVg+qb55n3o8X0wAseo"},"signatures":{"localhost":{"ed25519:a_vyji":"4qYdEmrPIokJ265vTJOS6Be+BuXSWm/W01aUA+kDC23dB+P7VlKId0awSVGRNsWsLooMo4EDgEyOedXemyR9Bg"}},"unsigned":{"age_ts":1675956696749}}	3
$FSGyxWobRbm3XPzA_RJTfx_wFyj7eioybzttjovTej0	!FzTtpSkXWMPYBKHUQN:localhost	{"token_id":4,"historical":false}	{"auth_events":["$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4","$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o","$MjPoUIyI-4SLUb_2CX0SN6Cq4siLSpO81XmSX0Tt1Ag"],"prev_events":["$Z8l2x75Ktp4i5ZFSxqQHoicfewpQOJ2yKoIXvdXGGL4"],"type":"m.room.member","room_id":"!FzTtpSkXWMPYBKHUQN:localhost","sender":"@user1.matrix:localhost","content":{"membership":"join","displayname":"user1.matrix"},"depth":8,"state_key":"@user1.matrix:localhost","origin":"localhost","origin_server_ts":1675956838410,"hashes":{"sha256":"oN0btzmZxN0Q2cF8gydfbNSTK44KW+chi5sQekBd5zg"},"signatures":{"localhost":{"ed25519:a_vyji":"YLyXqFPSxmsG9l3Z0SOESrD6aT0vLx4tpb10WWy/dP6IXg5o2+8U4H5i4yKvDvLHEmfdg3G9p2GCrhCrO2ZrCA"}},"unsigned":{"age_ts":1675956838410}}	3
$EgLH6XFurmJirUH4D5Zkm8y1WyPdrFX2SSko4S0-7hQ	!pYSbiOyjMFsKNxSMyi:localhost	{"token_id":3,"historical":false}	{"auth_events":["$gyvaweguHrwLjB1B_41QMnzSUMHQGbQmTALeOOMmWfU","$hZ3X11MNOocXcrcCNowWncNXGOcKtKz2Yuy15DpSX9Y"],"prev_events":["$hZ3X11MNOocXcrcCNowWncNXGOcKtKz2Yuy15DpSX9Y"],"type":"m.room.power_levels","room_id":"!pYSbiOyjMFsKNxSMyi:localhost","sender":"@admin:localhost","content":{"users":{"@admin:localhost":100},"users_default":0,"events":{"m.room.name":50,"m.room.power_levels":100,"m.room.history_visibility":100,"m.room.canonical_alias":50,"m.room.avatar":50,"m.room.tombstone":100,"m.room.server_acl":100,"m.room.encryption":100},"events_default":0,"state_default":50,"ban":50,"kick":50,"redact":50,"invite":50,"historical":100},"depth":3,"state_key":"","origin":"localhost","origin_server_ts":1675956696839,"hashes":{"sha256":"vzEiYP0Jn/6cSaJ4P1UXWHZD9S2d49p9OowtF8ZVMwE"},"signatures":{"localhost":{"ed25519:a_vyji":"e/OMtbdlBIUh6a+NUYHU6yx3qHZH1DNBM7uPuAPaDW1ianFWcgHgj/3/fBr+7s9gETC9OMTwOYPvSV0TQheoDg"}},"unsigned":{"age_ts":1675956696839}}	3
$6A1pwZ_SweaaUsjoN5q44E3waqx9e_BX_Vch4BXsSMc	!pYSbiOyjMFsKNxSMyi:localhost	{"token_id":3,"historical":false}	{"auth_events":["$gyvaweguHrwLjB1B_41QMnzSUMHQGbQmTALeOOMmWfU","$EgLH6XFurmJirUH4D5Zkm8y1WyPdrFX2SSko4S0-7hQ","$hZ3X11MNOocXcrcCNowWncNXGOcKtKz2Yuy15DpSX9Y"],"prev_events":["$EgLH6XFurmJirUH4D5Zkm8y1WyPdrFX2SSko4S0-7hQ"],"type":"m.room.canonical_alias","room_id":"!pYSbiOyjMFsKNxSMyi:localhost","sender":"@admin:localhost","content":{"alias":"#off-topic:localhost"},"depth":4,"state_key":"","origin":"localhost","origin_server_ts":1675956696896,"hashes":{"sha256":"Kc3R2Hzs4MMK4J49s2VCrqkoV6y2rnLsdENqhl4HeNg"},"signatures":{"localhost":{"ed25519:a_vyji":"BQZ8dx19lZTa0+5EkSvRLuC527OsOboB60Y4rdYzHcouYTZK2i1iMBc6fe46hBfjF0VmhrueZ+0LnWVuumjlCQ"}},"unsigned":{"age_ts":1675956696896}}	3
$tkoiHC3Vf1zAnFhhvTe60NQ7m3nRNvT1ILxtf8O8Tdc	!pYSbiOyjMFsKNxSMyi:localhost	{"token_id":3,"historical":false}	{"auth_events":["$gyvaweguHrwLjB1B_41QMnzSUMHQGbQmTALeOOMmWfU","$EgLH6XFurmJirUH4D5Zkm8y1WyPdrFX2SSko4S0-7hQ","$hZ3X11MNOocXcrcCNowWncNXGOcKtKz2Yuy15DpSX9Y"],"prev_events":["$6A1pwZ_SweaaUsjoN5q44E3waqx9e_BX_Vch4BXsSMc"],"type":"m.room.join_rules","room_id":"!pYSbiOyjMFsKNxSMyi:localhost","sender":"@admin:localhost","content":{"join_rule":"public"},"depth":5,"state_key":"","origin":"localhost","origin_server_ts":1675956696912,"hashes":{"sha256":"ULEmWO9RSRGvwDcQRcz5FFgzNRlaXRIOVH38ffJnpPg"},"signatures":{"localhost":{"ed25519:a_vyji":"fXq7zGek86vdPuHvYLwTwNnnGQitt460QeKyAHHojEGCu0X+ToYUaUuvS7rFyBtw8t9athgX9ti3BdEUR+kiDQ"}},"unsigned":{"age_ts":1675956696912}}	3
$W2bBymarQF5AVOanxoytGxta4UVf4fhh6doJw6GmsQ0	!pYSbiOyjMFsKNxSMyi:localhost	{"token_id":3,"historical":false}	{"auth_events":["$gyvaweguHrwLjB1B_41QMnzSUMHQGbQmTALeOOMmWfU","$EgLH6XFurmJirUH4D5Zkm8y1WyPdrFX2SSko4S0-7hQ","$hZ3X11MNOocXcrcCNowWncNXGOcKtKz2Yuy15DpSX9Y"],"prev_events":["$tkoiHC3Vf1zAnFhhvTe60NQ7m3nRNvT1ILxtf8O8Tdc"],"type":"m.room.history_visibility","room_id":"!pYSbiOyjMFsKNxSMyi:localhost","sender":"@admin:localhost","content":{"history_visibility":"shared"},"depth":6,"state_key":"","origin":"localhost","origin_server_ts":1675956696928,"hashes":{"sha256":"atkbvrYOjDyOHz2+f9ATDNTrKC7C27DnNF+141Els7U"},"signatures":{"localhost":{"ed25519:a_vyji":"WIbDw4eo46UUvLGy8GmxID1lHqoxDxnMl6Awb/yAw7c4aQDNQNrtCIQ1A+/hvON1VrukdloEOQYs8fv/V9IECw"}},"unsigned":{"age_ts":1675956696928}}	3
$YSS-8MMEgCETq_EouYM-mm0KiVKGloqtULWeqmdQKZg	!pYSbiOyjMFsKNxSMyi:localhost	{"token_id":3,"historical":false}	{"auth_events":["$gyvaweguHrwLjB1B_41QMnzSUMHQGbQmTALeOOMmWfU","$EgLH6XFurmJirUH4D5Zkm8y1WyPdrFX2SSko4S0-7hQ","$hZ3X11MNOocXcrcCNowWncNXGOcKtKz2Yuy15DpSX9Y"],"prev_events":["$W2bBymarQF5AVOanxoytGxta4UVf4fhh6doJw6GmsQ0"],"type":"m.room.name","room_id":"!pYSbiOyjMFsKNxSMyi:localhost","sender":"@admin:localhost","content":{"name":"#Off-Topic"},"depth":7,"state_key":"","origin":"localhost","origin_server_ts":1675956697215,"hashes":{"sha256":"fnhccx3kkOG2C7iSKS9R7Cf070Vrk4otQsqYzqU/Uww"},"signatures":{"localhost":{"ed25519:a_vyji":"XsOQA6yBFtoA2qiB5mHAN1z8WyG6I4uhtBv56+b52nXg4/OXqg0ZTEu5DG7BwpBHf2cxBkAJwfNtXbcKDRGEDg"}},"unsigned":{"age_ts":1675956697215}}	3
$0RmvI0B1zTbePI4eCXXUO_9tJQY2XcOy4Kt4FqYQ-Yk	!pYSbiOyjMFsKNxSMyi:localhost	{"token_id":4,"historical":false}	{"auth_events":["$gyvaweguHrwLjB1B_41QMnzSUMHQGbQmTALeOOMmWfU","$EgLH6XFurmJirUH4D5Zkm8y1WyPdrFX2SSko4S0-7hQ","$tkoiHC3Vf1zAnFhhvTe60NQ7m3nRNvT1ILxtf8O8Tdc"],"prev_events":["$YSS-8MMEgCETq_EouYM-mm0KiVKGloqtULWeqmdQKZg"],"type":"m.room.member","room_id":"!pYSbiOyjMFsKNxSMyi:localhost","sender":"@user1.matrix:localhost","content":{"membership":"join","displayname":"user1.matrix"},"depth":8,"state_key":"@user1.matrix:localhost","origin":"localhost","origin_server_ts":1675956825837,"hashes":{"sha256":"btOiUzpx1SHc8ml0r4MA87vt1K2lln4dtXkJHj+nrLM"},"signatures":{"localhost":{"ed25519:a_vyji":"imYPBtlyvyH7/UlyVB6LfDN37fmk4WAotcLm4kFMDfDtx+mPxckcKtwzSgGZWnTRiuIm1gvSxqduZus1qvuPAA"}},"unsigned":{"age_ts":1675956825837}}	3
$3iFc4KVKwTYBpN8T8PyFgNCDxXkCtJF5qS1nJbulpmU	!FzTtpSkXWMPYBKHUQN:localhost	{"historical":false}	{"auth_events":["$MjPoUIyI-4SLUb_2CX0SN6Cq4siLSpO81XmSX0Tt1Ag","$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4","$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o"],"prev_events":["$FSGyxWobRbm3XPzA_RJTfx_wFyj7eioybzttjovTej0"],"type":"m.room.member","room_id":"!FzTtpSkXWMPYBKHUQN:localhost","sender":"@matterbot:localhost","content":{"reason":"joining room","membership":"join","displayname":"Mattermost Bridge"},"depth":9,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1676646214039,"hashes":{"sha256":"AJb1hvTQTxK1IkH809Jb8bGazFWqS8KsbjxEOvWSbZc"},"signatures":{"localhost":{"ed25519:a_vyji":"5uX6N2M0/rQB142K1xb2xvYvtUiGZp3GLwAmHA35hR9DSHjc8jVrmSoV8TnJtt3odh5ravfPumh5BiW3hR2/CA"}},"unsigned":{"age_ts":1676646214039}}	3
$f8S-mPLHMnruZFOTih-IYlCoYILk6A_BPx3dtO79ubI	!pYSbiOyjMFsKNxSMyi:localhost	{"historical":false}	{"auth_events":["$tkoiHC3Vf1zAnFhhvTe60NQ7m3nRNvT1ILxtf8O8Tdc","$gyvaweguHrwLjB1B_41QMnzSUMHQGbQmTALeOOMmWfU","$EgLH6XFurmJirUH4D5Zkm8y1WyPdrFX2SSko4S0-7hQ"],"prev_events":["$0RmvI0B1zTbePI4eCXXUO_9tJQY2XcOy4Kt4FqYQ-Yk"],"type":"m.room.member","room_id":"!pYSbiOyjMFsKNxSMyi:localhost","sender":"@matterbot:localhost","content":{"reason":"joining room","membership":"join","displayname":"Mattermost Bridge"},"depth":9,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1676646214037,"hashes":{"sha256":"aIHp+/AqpAu3U+AFcvTYdA26hKG4Ftd7gjXOJhPPBqQ"},"signatures":{"localhost":{"ed25519:a_vyji":"OEJ2/N4FnGhKFbeSlH+quza4ujYP9igPBsCPIM49I/vSj6Ray5NgSr+aliWILi2sAKTf55azxCtynxg2Y4V5CA"}},"unsigned":{"age_ts":1676646214037}}	3
$Q7qpUYZra7SmdftawkKRrQilka-WlRBbgKYybv2QRls	!pYSbiOyjMFsKNxSMyi:localhost	{"historical":false}	{"auth_events":["$tkoiHC3Vf1zAnFhhvTe60NQ7m3nRNvT1ILxtf8O8Tdc","$gyvaweguHrwLjB1B_41QMnzSUMHQGbQmTALeOOMmWfU","$EgLH6XFurmJirUH4D5Zkm8y1WyPdrFX2SSko4S0-7hQ","$f8S-mPLHMnruZFOTih-IYlCoYILk6A_BPx3dtO79ubI"],"prev_events":["$f8S-mPLHMnruZFOTih-IYlCoYILk6A_BPx3dtO79ubI"],"type":"m.room.member","room_id":"!pYSbiOyjMFsKNxSMyi:localhost","sender":"@matterbot:localhost","content":{"reason":"Needed for app service","membership":"join","displayname":"Mattermost Bridge"},"depth":10,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1676646295913,"hashes":{"sha256":"oRHFxBB8OANo+TAK5olIElhj6i2fBQ2tbGnVn+k6jgw"},"signatures":{"localhost":{"ed25519:a_vyji":"9io4eNxIX+xBxAJbGqc5CB7B3QPnN36rR69kF+qEj+US7Vw60fmHzzUijtLGz1MBKrmvhQts5hBAbiIHAbbBDQ"}},"unsigned":{"age_ts":1676646295913,"replaces_state":"$f8S-mPLHMnruZFOTih-IYlCoYILk6A_BPx3dtO79ubI"}}	3
$o5ttVgA4qLDCRoIxN9qyVPOLj9QUajTOF3D_U8es57Y	!FzTtpSkXWMPYBKHUQN:localhost	{"historical":false}	{"auth_events":["$MjPoUIyI-4SLUb_2CX0SN6Cq4siLSpO81XmSX0Tt1Ag","$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4","$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o","$3iFc4KVKwTYBpN8T8PyFgNCDxXkCtJF5qS1nJbulpmU"],"prev_events":["$3iFc4KVKwTYBpN8T8PyFgNCDxXkCtJF5qS1nJbulpmU"],"type":"m.room.member","room_id":"!FzTtpSkXWMPYBKHUQN:localhost","sender":"@matterbot:localhost","content":{"reason":"Needed for app service","membership":"join","displayname":"Mattermost Bridge"},"depth":10,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1676646295905,"hashes":{"sha256":"d6V0UMnqbiSWyOrHDY8JnKPlFxd8iIg7ZOvKSzqswQ4"},"signatures":{"localhost":{"ed25519:a_vyji":"gnEPPhYO8Hn7YXX8XlbBj0t/5SVAKWEuO8lHQ1q2W95qai1Eu/Dgn70d+8Y3dwW/PhZ02RfeEh+d91aW4EoAAg"}},"unsigned":{"age_ts":1676646295905,"replaces_state":"$3iFc4KVKwTYBpN8T8PyFgNCDxXkCtJF5qS1nJbulpmU"}}	3
$ws9UuWLPn8VzHbofyg3g8AQK-aYsdD2iv6woyWt3sEw	!pYSbiOyjMFsKNxSMyi:localhost	{"txn_id":"m1676646372622","historical":false}	{"auth_events":["$gyvaweguHrwLjB1B_41QMnzSUMHQGbQmTALeOOMmWfU","$EgLH6XFurmJirUH4D5Zkm8y1WyPdrFX2SSko4S0-7hQ","$Q7qpUYZra7SmdftawkKRrQilka-WlRBbgKYybv2QRls"],"prev_events":["$Q7qpUYZra7SmdftawkKRrQilka-WlRBbgKYybv2QRls"],"type":"m.room.message","room_id":"!pYSbiOyjMFsKNxSMyi:localhost","sender":"@matterbot:localhost","content":{"body":"Hej","msgtype":"m.text"},"depth":11,"origin":"localhost","origin_server_ts":1676646372672,"hashes":{"sha256":"ayO7Ea4zC+ejOG987yQRa3d5eqJta3VFBga7qt5Ibn0"},"signatures":{"localhost":{"ed25519:a_vyji":"N6zqVRFKrXp3zA/qjA/A+3a21QbxEQfFbZ1PXbxTqyqdgG98TUZQR8AVfLxREE2k+LM1zGHaJhN3NQpOLUK8Bg"}},"unsigned":{"age_ts":1676646372672}}	3
$EeKexStxnjQMJwZnkxIZRNXLdggHQGqT_RJYm1xCocU	!FzTtpSkXWMPYBKHUQN:localhost	{"token_id":2,"historical":false}	{"auth_events":["$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4","$MjPoUIyI-4SLUb_2CX0SN6Cq4siLSpO81XmSX0Tt1Ag","$IU1ZxuT0Nte99MGUdW5IhEVc_pVMkrUEqjP5xs27dVs","$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o"],"prev_events":["$o5ttVgA4qLDCRoIxN9qyVPOLj9QUajTOF3D_U8es57Y"],"type":"m.room.member","room_id":"!FzTtpSkXWMPYBKHUQN:localhost","sender":"@admin:localhost","content":{"reason":"Invited to room","membership":"invite","displayname":"mm_user1.mm"},"depth":11,"state_key":"@mm_user1.mm:localhost","origin":"localhost","origin_server_ts":1678032935186,"hashes":{"sha256":"NqKdeWustO34Ip/KleAUWkyp08bO/tPh2R6zukxAfJg"},"signatures":{"localhost":{"ed25519:a_vyji":"cw8+hkDPmZEXr4j35hC7EWuK6PQqCtTETc5jBDG+w/uWKifudksW6j0RKp1tdpH7JXiYmPeHnf+sHMJxgf85Bg"}},"unsigned":{"age_ts":1678032935186,"invite_room_state":[{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#town-square:localhost"},"sender":"@admin:localhost"},{"type":"m.room.name","state_key":"","content":{"name":"#Town Square"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"9","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@admin:localhost","content":{"membership":"join","displayname":"admin"},"sender":"@admin:localhost"}]}}	3
$ZPGmNdM7zvGVfx5_posO0xAJ7C6aAnDZavYGV23i3eM	!FzTtpSkXWMPYBKHUQN:localhost	{"token_id":10,"historical":false}	{"auth_events":["$EeKexStxnjQMJwZnkxIZRNXLdggHQGqT_RJYm1xCocU","$MjPoUIyI-4SLUb_2CX0SN6Cq4siLSpO81XmSX0Tt1Ag","$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o","$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4"],"prev_events":["$EeKexStxnjQMJwZnkxIZRNXLdggHQGqT_RJYm1xCocU"],"type":"m.room.member","room_id":"!FzTtpSkXWMPYBKHUQN:localhost","sender":"@mm_user1.mm:localhost","content":{"reason":"joining room","membership":"join","displayname":"mm_user1.mm"},"depth":12,"state_key":"@mm_user1.mm:localhost","origin":"localhost","origin_server_ts":1678032935470,"hashes":{"sha256":"My+L9kmsIFUQc1l+50qPqZcOUN9ut2A82suyDJLjRwM"},"signatures":{"localhost":{"ed25519:a_vyji":"+3PPYV8j03u/LgT28hMWnLlaMFekX7asCDLVX2phnR9Vz0zV0OxoazR+/qk3XqmR88JQcftcKQWkmGKWb6OSAA"}},"unsigned":{"age_ts":1678032935470,"replaces_state":"$EeKexStxnjQMJwZnkxIZRNXLdggHQGqT_RJYm1xCocU"}}	3
$ls5AzJlLTu3Alykxvj5L99HqOQsi7cUGH7wVb-IqErQ	!FzTtpSkXWMPYBKHUQN:localhost	{"token_id":10,"txn_id":"m1678032937698","historical":false}	{"auth_events":["$ZPGmNdM7zvGVfx5_posO0xAJ7C6aAnDZavYGV23i3eM","$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o","$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4"],"prev_events":["$ZPGmNdM7zvGVfx5_posO0xAJ7C6aAnDZavYGV23i3eM"],"type":"m.room.message","room_id":"!FzTtpSkXWMPYBKHUQN:localhost","sender":"@mm_user1.mm:localhost","content":{"msgtype":"m.text","body":"oko"},"depth":13,"origin":"localhost","origin_server_ts":1678032937746,"hashes":{"sha256":"k5Xfym9dqPZC9eLAyM/x0ibeZI8Pz0sPlasQoK0o/O8"},"signatures":{"localhost":{"ed25519:a_vyji":"eOxzpMIaE/qW2BHjIQzdy9Edl7rlVPiNeXtVBFc9WB+seHUVVlzNFavQHOsjVZioPn7O8aA+Ez5De2Q140kSCQ"}},"unsigned":{"age_ts":1678032937746}}	3
$nFwL1txBnk2dj72aBWqthTGHrC-kv7CYWMt3cwz8qgw	!pYSbiOyjMFsKNxSMyi:localhost	{"token_id":9,"txn_id":"m1678032959509.0","historical":false}	{"auth_events":["$gyvaweguHrwLjB1B_41QMnzSUMHQGbQmTALeOOMmWfU","$EgLH6XFurmJirUH4D5Zkm8y1WyPdrFX2SSko4S0-7hQ","$0RmvI0B1zTbePI4eCXXUO_9tJQY2XcOy4Kt4FqYQ-Yk"],"prev_events":["$ws9UuWLPn8VzHbofyg3g8AQK-aYsdD2iv6woyWt3sEw"],"type":"m.room.message","room_id":"!pYSbiOyjMFsKNxSMyi:localhost","sender":"@user1.matrix:localhost","content":{"msgtype":"m.text","body":"kook"},"depth":12,"origin":"localhost","origin_server_ts":1678032959618,"hashes":{"sha256":"L0fZTQryAz8q4YhdrTd0uxXemuLDCUEHpzC1Hs7qwtc"},"signatures":{"localhost":{"ed25519:a_vyji":"XJgqES788qUL9Ck2zo6+9DPmZSc99V1eOOFRXTAmP41FG0XZwg9DjvXSXrDjrATEBRQ9XUb+RWankwG+/foKCQ"}},"unsigned":{"age_ts":1678032959618}}	3
$DRO5TAucLHxvrlJ47kjeEKQiKn1D0J-pwsDdrExDhfM	!FzTtpSkXWMPYBKHUQN:localhost	{"token_id":11,"historical":false}	{"auth_events":["$IU1ZxuT0Nte99MGUdW5IhEVc_pVMkrUEqjP5xs27dVs","$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o","$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4"],"prev_events":["$ls5AzJlLTu3Alykxvj5L99HqOQsi7cUGH7wVb-IqErQ"],"type":"m.room.name","room_id":"!FzTtpSkXWMPYBKHUQN:localhost","sender":"@admin:localhost","content":{"name":"Town Square"},"depth":14,"state_key":"","origin":"localhost","origin_server_ts":1678033164649,"hashes":{"sha256":"bwu8J4/l2cyPWpX05R8l7J7kPL6beJkmc3vnNKI8erY"},"signatures":{"localhost":{"ed25519:a_vyji":"Ex0VaNGs5Om8mXctGnY/+QlV5vwxF3eOg/hWcaIASCx7r+SBKN/hqgx+Z0NAlKnrBuubb8WPbVjc25mSRHcmBA"}},"unsigned":{"age_ts":1678033164649,"replaces_state":"$Z8l2x75Ktp4i5ZFSxqQHoicfewpQOJ2yKoIXvdXGGL4"}}	3
$hXzRSYfNTLUmjRz8EgsrekOmklfOoUQ9NKx0vS1AmTk	!FzTtpSkXWMPYBKHUQN:localhost	{"token_id":12,"txn_id":"m1678033228889","historical":false}	{"auth_events":["$ZPGmNdM7zvGVfx5_posO0xAJ7C6aAnDZavYGV23i3eM","$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o","$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4"],"prev_events":["$DRO5TAucLHxvrlJ47kjeEKQiKn1D0J-pwsDdrExDhfM"],"type":"m.room.message","room_id":"!FzTtpSkXWMPYBKHUQN:localhost","sender":"@mm_user1.mm:localhost","content":{"msgtype":"m.text","body":"okok"},"depth":15,"origin":"localhost","origin_server_ts":1678033228922,"hashes":{"sha256":"NFXgKIMKC2AUftAEnO2ShAtIfNnXc/M4k5mVc4VsWSc"},"signatures":{"localhost":{"ed25519:a_vyji":"r0Vfc4oIghSA0uS2IAmUP2Yyf66K8dyc4Pq8P6UPUFFvg1fT3nD2y2ENUk4ToydRE/Xyf3aj5EZSCOf9yA4FBg"}},"unsigned":{"age_ts":1678033228922}}	3
$fbEIs1FPebLFup8Sm4TvsnGt3OqnXO125KPufsX6e4E	!FzTtpSkXWMPYBKHUQN:localhost	{"token_id":11,"txn_id":"m1678033249669.0","historical":false}	{"auth_events":["$IU1ZxuT0Nte99MGUdW5IhEVc_pVMkrUEqjP5xs27dVs","$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o","$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4"],"prev_events":["$hXzRSYfNTLUmjRz8EgsrekOmklfOoUQ9NKx0vS1AmTk"],"type":"m.room.message","room_id":"!FzTtpSkXWMPYBKHUQN:localhost","sender":"@admin:localhost","content":{"msgtype":"m.text","body":"dokidoki"},"depth":16,"origin":"localhost","origin_server_ts":1678033249737,"hashes":{"sha256":"Y3aklTKKKcxjJUR2NxmTb14iedyIHnZr6Al9OonpHTE"},"signatures":{"localhost":{"ed25519:a_vyji":"SVYsOfKAMHsDR7pOvQh7sgE2f2UgWq5TEYNAnJsZ+rf/ipVBtWwPHZX4a9xLFOA/Rd7SyeI+NQQyhjEkQlKnAQ"}},"unsigned":{"age_ts":1678033249737}}	3
$ggCddRubeCPps5yMhlY-9Ib0RvBhwUJy716vZvf32Oo	!FzTtpSkXWMPYBKHUQN:localhost	{"token_id":13,"txn_id":"m1678033315167.0","historical":false}	{"auth_events":["$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4","$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o","$FSGyxWobRbm3XPzA_RJTfx_wFyj7eioybzttjovTej0"],"prev_events":["$fbEIs1FPebLFup8Sm4TvsnGt3OqnXO125KPufsX6e4E"],"type":"m.room.message","room_id":"!FzTtpSkXWMPYBKHUQN:localhost","sender":"@user1.matrix:localhost","content":{"msgtype":"m.text","body":"kalle"},"depth":17,"origin":"localhost","origin_server_ts":1678033315210,"hashes":{"sha256":"owgsPNbjef1spJldr9Vax1J4Ez/v7gFAhmEETTls87g"},"signatures":{"localhost":{"ed25519:a_vyji":"TsDKR3hqpCd6xxiXqKKZlQA7+lnr3Lo9OZtcHX0xIfYPxG/BVa2asay4voeR7GSNBqRWTwAl/6DVld0FntgaCQ"}},"unsigned":{"age_ts":1678033315210}}	3
$2AEp1hOUUsulI8Zc2ISpcmI9VmKuftWZdClPUSC_mD4	!AHOiTmgdxQzlhIOUsy:localhost	{"token_id":2,"historical":false}	{"auth_events":["$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg"],"prev_events":["$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg"],"type":"m.room.member","room_id":"!AHOiTmgdxQzlhIOUsy:localhost","sender":"@admin:localhost","content":{"membership":"join","displayname":"admin"},"depth":2,"state_key":"@admin:localhost","origin":"localhost","origin_server_ts":1678033569732,"hashes":{"sha256":"Hnfk0NGFylECEdN4jKbwdB9bbW6wGS26cN9/Pl2Vda8"},"signatures":{"localhost":{"ed25519:a_vyji":"708Np72eE2O+YDOQGcnqZETuD06FH9H1dOgi22KcM0vJ2iq9piPaD3w4gijb7oVzwzCAC/qJfmMtcPEkn6cBCw"}},"unsigned":{"age_ts":1678033569732}}	3
$425aYo_LNE95R3HHpQZSk0MGS0CjqhCPkp0DJvtMk5M	!AHOiTmgdxQzlhIOUsy:localhost	{"token_id":2,"historical":false}	{"auth_events":["$2AEp1hOUUsulI8Zc2ISpcmI9VmKuftWZdClPUSC_mD4","$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg"],"prev_events":["$2AEp1hOUUsulI8Zc2ISpcmI9VmKuftWZdClPUSC_mD4"],"type":"m.room.power_levels","room_id":"!AHOiTmgdxQzlhIOUsy:localhost","sender":"@admin:localhost","content":{"users":{"@admin:localhost":100},"users_default":0,"events":{"m.room.name":50,"m.room.power_levels":100,"m.room.history_visibility":100,"m.room.canonical_alias":50,"m.room.avatar":50,"m.room.tombstone":100,"m.room.server_acl":100,"m.room.encryption":100},"events_default":0,"state_default":50,"ban":50,"kick":50,"redact":50,"invite":50,"historical":100},"depth":3,"state_key":"","origin":"localhost","origin_server_ts":1678033569956,"hashes":{"sha256":"eBF6D3wGK7eiYb/4hdHdJ3AnYzxogIcDaCOineAKq4w"},"signatures":{"localhost":{"ed25519:a_vyji":"w8j+A+enuvUk7oePJRV/JHXhKnDtSZC8yZJis/mJw3nYc1NfYGCi6CXGwRFYzceXS6WOHwoUvq1qpp7QRvp+Aw"}},"unsigned":{"age_ts":1678033569956}}	3
$z1GwtHO3iyw6MvOYBxrwIdl_jvUlP6_Bn6yFfE9P2aI	!AHOiTmgdxQzlhIOUsy:localhost	{"token_id":2,"historical":false}	{"auth_events":["$2AEp1hOUUsulI8Zc2ISpcmI9VmKuftWZdClPUSC_mD4","$425aYo_LNE95R3HHpQZSk0MGS0CjqhCPkp0DJvtMk5M","$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg"],"prev_events":["$425aYo_LNE95R3HHpQZSk0MGS0CjqhCPkp0DJvtMk5M"],"type":"m.room.canonical_alias","room_id":"!AHOiTmgdxQzlhIOUsy:localhost","sender":"@admin:localhost","content":{"alias":"#after-work:localhost"},"depth":4,"state_key":"","origin":"localhost","origin_server_ts":1678033570034,"hashes":{"sha256":"LMgJGvnbK5vFlyWOmprE74gUp/0E6oEH0HWkhPps3bg"},"signatures":{"localhost":{"ed25519:a_vyji":"pc1OQ208FnEiSmppkJugmoIXnJDp7cdQMKNd24y2DTtMRLrSwVN/7obRn/APiIjZkOS3qEGJoAt1Lh4CzWqoBA"}},"unsigned":{"age_ts":1678033570034}}	3
$Ww-5pR04rXtgZleTLBj7vJSR1LGkC3tZ5Zuaxqazwek	!AHOiTmgdxQzlhIOUsy:localhost	{"token_id":2,"historical":false}	{"auth_events":["$2AEp1hOUUsulI8Zc2ISpcmI9VmKuftWZdClPUSC_mD4","$425aYo_LNE95R3HHpQZSk0MGS0CjqhCPkp0DJvtMk5M","$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg"],"prev_events":["$z1GwtHO3iyw6MvOYBxrwIdl_jvUlP6_Bn6yFfE9P2aI"],"type":"m.room.join_rules","room_id":"!AHOiTmgdxQzlhIOUsy:localhost","sender":"@admin:localhost","content":{"join_rule":"public"},"depth":5,"state_key":"","origin":"localhost","origin_server_ts":1678033570055,"hashes":{"sha256":"CuCZpOiuVgL5p1SIW0fHa6no7Bc8uXc5uc+sA4vRq9g"},"signatures":{"localhost":{"ed25519:a_vyji":"+0jGctyEOz1ecmQtJ74OsGv6oojvGP3EFNUbDCsRYmO+arLSD8VkB8O1JVG9HcgtO4JfZf7HS5ebXSR6YCFfAw"}},"unsigned":{"age_ts":1678033570055}}	3
$LmDzEqXVjmgNKIk52bhBmbosSuVDk32P02nhwggY0RM	!AHOiTmgdxQzlhIOUsy:localhost	{"token_id":2,"historical":false}	{"auth_events":["$2AEp1hOUUsulI8Zc2ISpcmI9VmKuftWZdClPUSC_mD4","$425aYo_LNE95R3HHpQZSk0MGS0CjqhCPkp0DJvtMk5M","$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg"],"prev_events":["$Ww-5pR04rXtgZleTLBj7vJSR1LGkC3tZ5Zuaxqazwek"],"type":"m.room.history_visibility","room_id":"!AHOiTmgdxQzlhIOUsy:localhost","sender":"@admin:localhost","content":{"history_visibility":"shared"},"depth":6,"state_key":"","origin":"localhost","origin_server_ts":1678033570065,"hashes":{"sha256":"yEe+lYToclJ5A5HkZECGMZ9Mj/PSztaYoYflF/B4Jv8"},"signatures":{"localhost":{"ed25519:a_vyji":"5hgX5yvQjTM6dR+/0JO/3m6FOLJumjnOPUI1cWeWdzMI/Sx/w2n45zAKAMpeKlPrFFB8v0gmd8+Y/sI60KsJBw"}},"unsigned":{"age_ts":1678033570065}}	3
$ye7ixCV2UmoA3GCF2K5lqNSxMrWwkdvkTSOdQDHy-P0	!AHOiTmgdxQzlhIOUsy:localhost	{"token_id":13,"historical":false}	{"auth_events":["$Ww-5pR04rXtgZleTLBj7vJSR1LGkC3tZ5Zuaxqazwek","$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg","$425aYo_LNE95R3HHpQZSk0MGS0CjqhCPkp0DJvtMk5M"],"prev_events":["$v3jGyApp70gdwh4Il9oB6nRxdyr-zF1Nt9w5VRI1Em4"],"type":"m.room.member","room_id":"!AHOiTmgdxQzlhIOUsy:localhost","sender":"@user1.matrix:localhost","content":{"membership":"join","displayname":"user1.matrix"},"depth":13,"state_key":"@user1.matrix:localhost","origin":"localhost","origin_server_ts":1678033782282,"hashes":{"sha256":"WEAbMj+AN+/Cao6R18qWRLiNbAiZK4Ngrw+q4Jgebco"},"signatures":{"localhost":{"ed25519:a_vyji":"WvLciVL8XUlTk6drLbG/+d/2OnkYpyerN6AZuNRpUryf+RFs5lcltQZ5PNeTddVcfyFsEiwckC3A59E4z1Q/DA"}},"unsigned":{"age_ts":1678033782282}}	3
$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg	!AHOiTmgdxQzlhIOUsy:localhost	{"token_id":2,"historical":false}	{"auth_events":[],"prev_events":[],"type":"m.room.create","room_id":"!AHOiTmgdxQzlhIOUsy:localhost","sender":"@admin:localhost","content":{"room_version":"10","creator":"@admin:localhost"},"depth":1,"state_key":"","origin":"localhost","origin_server_ts":1678033569475,"hashes":{"sha256":"Ttyb7i8yBrGPy5TqTfddQ9KoJY7Z83Oa7ZfJRJVRSkk"},"signatures":{"localhost":{"ed25519:a_vyji":"a7/ITTrp+wXy1dGfsWdIis3kn5jSgVMINN1mYeVK/jACxaBFPH7yff+lqwCfk4EaYzV6xfvzUKYW/UnWsjqXAQ"}},"unsigned":{"age_ts":1678033569475}}	3
$sFv4HsuqMN9A0Wl_Bb1tZ-I7Kgdtxe83YsRaNWowWDM	!AHOiTmgdxQzlhIOUsy:localhost	{"token_id":2,"historical":false}	{"auth_events":["$2AEp1hOUUsulI8Zc2ISpcmI9VmKuftWZdClPUSC_mD4","$425aYo_LNE95R3HHpQZSk0MGS0CjqhCPkp0DJvtMk5M","$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg"],"prev_events":["$LmDzEqXVjmgNKIk52bhBmbosSuVDk32P02nhwggY0RM"],"type":"m.room.name","room_id":"!AHOiTmgdxQzlhIOUsy:localhost","sender":"@admin:localhost","content":{"name":"After Work"},"depth":7,"state_key":"","origin":"localhost","origin_server_ts":1678033570448,"hashes":{"sha256":"eZabRyFt8c/xTlu2FHTCrDo+WGmkuv23iDFPeciPEdQ"},"signatures":{"localhost":{"ed25519:a_vyji":"0NBkfjBkPWj1KzKNLXOaENr85WiHkpWsWH0NZh3Tj4wjXJxGhwy4An4AuOiTlDLPd/S/Bxb5cE+emxx+CEM4CQ"}},"unsigned":{"age_ts":1678033570448}}	3
$xOF81meT9KSyhw3dY5FjCzADSBULEj6OoQaHM9DWtMY	!AHOiTmgdxQzlhIOUsy:localhost	{"token_id":2,"historical":false}	{"auth_events":["$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg","$Ww-5pR04rXtgZleTLBj7vJSR1LGkC3tZ5Zuaxqazwek","$2AEp1hOUUsulI8Zc2ISpcmI9VmKuftWZdClPUSC_mD4","$425aYo_LNE95R3HHpQZSk0MGS0CjqhCPkp0DJvtMk5M"],"prev_events":["$sFv4HsuqMN9A0Wl_Bb1tZ-I7Kgdtxe83YsRaNWowWDM"],"type":"m.room.member","room_id":"!AHOiTmgdxQzlhIOUsy:localhost","sender":"@admin:localhost","content":{"membership":"invite","displayname":"Mattermost Bridge"},"depth":8,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1678033570821,"hashes":{"sha256":"u4kpv1leFKfkykRLx7lFp+yQH+uaZgcjVbRezLfB6To"},"signatures":{"localhost":{"ed25519:a_vyji":"dpIqRKvz8FUUNyogS8LyOXbqqqYuoGqDDSq85ScV8/KXQ5DEUmOf7kvLRWOGx6AaG6czSlZj0yE2AXvStA51Ag"}},"unsigned":{"age_ts":1678033570821,"invite_room_state":[{"type":"m.room.member","state_key":"@admin:localhost","content":{"membership":"join","displayname":"admin"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#after-work:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"10","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.name","state_key":"","content":{"name":"After Work"},"sender":"@admin:localhost"}]}}	3
$cgYituIGJ7X54S5-Ax3C5u2yLwCnf99x2VbMmy0YD3w	!AHOiTmgdxQzlhIOUsy:localhost	{"historical":false}	{"auth_events":["$Ww-5pR04rXtgZleTLBj7vJSR1LGkC3tZ5Zuaxqazwek","$xOF81meT9KSyhw3dY5FjCzADSBULEj6OoQaHM9DWtMY","$425aYo_LNE95R3HHpQZSk0MGS0CjqhCPkp0DJvtMk5M","$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg"],"prev_events":["$xOF81meT9KSyhw3dY5FjCzADSBULEj6OoQaHM9DWtMY"],"type":"m.room.member","room_id":"!AHOiTmgdxQzlhIOUsy:localhost","sender":"@matterbot:localhost","content":{"reason":"joining room","membership":"join","displayname":"Mattermost Bridge"},"depth":9,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1678033706272,"hashes":{"sha256":"M3yMMu/9ZZ4VootLR292xRg3u+WOvhgypvrC/aMZuvc"},"signatures":{"localhost":{"ed25519:a_vyji":"qOWzn/7Rciy0yCoUDYQyP1IxvWaUvtSf4w9LRE95Vyljjb/xO9IiByHJFHBZucm7i5/cuhezLfILFkGiUvfNCw"}},"unsigned":{"age_ts":1678033706272,"replaces_state":"$xOF81meT9KSyhw3dY5FjCzADSBULEj6OoQaHM9DWtMY"}}	3
$jiXC1l1ou9Ti0I7CV7PJrsVblqsrb9dPQentqZqLBys	!AHOiTmgdxQzlhIOUsy:localhost	{"token_id":14,"historical":false}	{"auth_events":["$hgeuyu5_SLbd99TLf-m4kSUM8l1Jy-W4XmhdQGO2rr0","$Ww-5pR04rXtgZleTLBj7vJSR1LGkC3tZ5Zuaxqazwek","$425aYo_LNE95R3HHpQZSk0MGS0CjqhCPkp0DJvtMk5M","$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg"],"prev_events":["$hgeuyu5_SLbd99TLf-m4kSUM8l1Jy-W4XmhdQGO2rr0"],"type":"m.room.member","room_id":"!AHOiTmgdxQzlhIOUsy:localhost","sender":"@mm_user1.mm:localhost","content":{"reason":"joining room","membership":"join","displayname":"mm_user1.mm"},"depth":11,"state_key":"@mm_user1.mm:localhost","origin":"localhost","origin_server_ts":1678033763086,"hashes":{"sha256":"8mZGfLaHR1hdTifzUvHNm4vAjQKg+J/GG1BaPUvtQ1Q"},"signatures":{"localhost":{"ed25519:a_vyji":"wqOwEpEGJXGA8eWIJMuRzc+ttlBW6IRp4g6dClx3DErcozZ9sNjWcJVR8qwWsQCOy/S/36n96IB4rjvXt6nCDA"}},"unsigned":{"age_ts":1678033763086,"replaces_state":"$hgeuyu5_SLbd99TLf-m4kSUM8l1Jy-W4XmhdQGO2rr0"}}	3
$hgeuyu5_SLbd99TLf-m4kSUM8l1Jy-W4XmhdQGO2rr0	!AHOiTmgdxQzlhIOUsy:localhost	{"token_id":2,"historical":false}	{"auth_events":["$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg","$Ww-5pR04rXtgZleTLBj7vJSR1LGkC3tZ5Zuaxqazwek","$2AEp1hOUUsulI8Zc2ISpcmI9VmKuftWZdClPUSC_mD4","$425aYo_LNE95R3HHpQZSk0MGS0CjqhCPkp0DJvtMk5M"],"prev_events":["$cgYituIGJ7X54S5-Ax3C5u2yLwCnf99x2VbMmy0YD3w"],"type":"m.room.member","room_id":"!AHOiTmgdxQzlhIOUsy:localhost","sender":"@admin:localhost","content":{"reason":"Invited to room","membership":"invite","displayname":"mm_user1.mm"},"depth":10,"state_key":"@mm_user1.mm:localhost","origin":"localhost","origin_server_ts":1678033762706,"hashes":{"sha256":"T1WD9OG3mUqdi83vUKZh8wfyzZK5HXlDHCvZj0dlhW8"},"signatures":{"localhost":{"ed25519:a_vyji":"9nnFRMYlq4jq4eZrzUnQ8zn9xkXx5cCee5ssUqOGHoZmTmrWWIdJX2qonn0Rdpow+M1WWMqp6a85yERXFSq7AQ"}},"unsigned":{"age_ts":1678033762706,"invite_room_state":[{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"10","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#after-work:localhost"},"sender":"@admin:localhost"},{"type":"m.room.name","state_key":"","content":{"name":"After Work"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@admin:localhost","content":{"membership":"join","displayname":"admin"},"sender":"@admin:localhost"}]}}	3
$v3jGyApp70gdwh4Il9oB6nRxdyr-zF1Nt9w5VRI1Em4	!AHOiTmgdxQzlhIOUsy:localhost	{"token_id":14,"txn_id":"m1678033769233","historical":false}	{"auth_events":["$jiXC1l1ou9Ti0I7CV7PJrsVblqsrb9dPQentqZqLBys","$425aYo_LNE95R3HHpQZSk0MGS0CjqhCPkp0DJvtMk5M","$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg"],"prev_events":["$jiXC1l1ou9Ti0I7CV7PJrsVblqsrb9dPQentqZqLBys"],"type":"m.room.message","room_id":"!AHOiTmgdxQzlhIOUsy:localhost","sender":"@mm_user1.mm:localhost","content":{"msgtype":"m.text","body":"klklk"},"depth":12,"origin":"localhost","origin_server_ts":1678033769274,"hashes":{"sha256":"hVtqSOi1By3hLtOaFcia5ycEPwwy8BpBaqq5SGoSloo"},"signatures":{"localhost":{"ed25519:a_vyji":"RrpVKj25gHPICbtUTkclb+RxPTm4TCpZhv5Hq3F77gF4e4vxAd8emuyTSpy2Q9oabbtgvgZbpRyb0uOnqBSVCA"}},"unsigned":{"age_ts":1678033769274}}	3
$95vJ25qtpsri2l4-Ft6bN-NMw1uq9NjdTcLLt_v-cdE	!AHOiTmgdxQzlhIOUsy:localhost	{"token_id":14,"txn_id":"m1678033803383","historical":false}	{"auth_events":["$jiXC1l1ou9Ti0I7CV7PJrsVblqsrb9dPQentqZqLBys","$425aYo_LNE95R3HHpQZSk0MGS0CjqhCPkp0DJvtMk5M","$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg"],"prev_events":["$ye7ixCV2UmoA3GCF2K5lqNSxMrWwkdvkTSOdQDHy-P0"],"type":"m.room.message","room_id":"!AHOiTmgdxQzlhIOUsy:localhost","sender":"@mm_user1.mm:localhost","content":{"msgtype":"m.text","body":"KLKLK"},"depth":14,"origin":"localhost","origin_server_ts":1678033803466,"hashes":{"sha256":"oWs6lDS1hxB8XAq5Gy8wVPfbnaHa2K4cZImk3m+xjF0"},"signatures":{"localhost":{"ed25519:a_vyji":"+33i3CgoaGVGJs6i6GEXVZk+czQBys/78hKtUJxBo7M+InuganKgZ9jQLHIgqzhYMbjc5Gvu2HG6B7lxifU0DA"}},"unsigned":{"age_ts":1678033803466}}	3
$0XMDIAwJBH-iA7qIReHWRJAwmGiTGGioVtV8KFmJ4_M	!AHOiTmgdxQzlhIOUsy:localhost	{"historical":false}	{"auth_events":["$Ww-5pR04rXtgZleTLBj7vJSR1LGkC3tZ5Zuaxqazwek","$cgYituIGJ7X54S5-Ax3C5u2yLwCnf99x2VbMmy0YD3w","$425aYo_LNE95R3HHpQZSk0MGS0CjqhCPkp0DJvtMk5M","$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg"],"prev_events":["$95vJ25qtpsri2l4-Ft6bN-NMw1uq9NjdTcLLt_v-cdE"],"type":"m.room.member","room_id":"!AHOiTmgdxQzlhIOUsy:localhost","sender":"@matterbot:localhost","content":{"reason":"Needed for app service","membership":"join","displayname":"Mattermost Bridge"},"depth":15,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1678033936870,"hashes":{"sha256":"OeUvpjYUXxiDpUNRUOq7zYUxbuPvFZGcT+kGdW9rgTM"},"signatures":{"localhost":{"ed25519:a_vyji":"o+AumAhxyMdTEjFlHKRp9hLJEKogqav6do3D3JGiJ3O385soMqSJr9zvk/gWB1mbnCiqQAGyfoUGGxkmuXYpDw"}},"unsigned":{"age_ts":1678033936870,"replaces_state":"$cgYituIGJ7X54S5-Ax3C5u2yLwCnf99x2VbMmy0YD3w"}}	3
$cy5KlfdXxrxwsh3JYgCvSt79RGqs9e0nqUdGznRRG7c	!AHOiTmgdxQzlhIOUsy:localhost	{"token_id":13,"txn_id":"m1678034001328.1","historical":false}	{"auth_events":["$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg","$425aYo_LNE95R3HHpQZSk0MGS0CjqhCPkp0DJvtMk5M","$ye7ixCV2UmoA3GCF2K5lqNSxMrWwkdvkTSOdQDHy-P0"],"prev_events":["$0XMDIAwJBH-iA7qIReHWRJAwmGiTGGioVtV8KFmJ4_M"],"type":"m.room.message","room_id":"!AHOiTmgdxQzlhIOUsy:localhost","sender":"@user1.matrix:localhost","content":{"msgtype":"m.text","body":"ddd"},"depth":16,"origin":"localhost","origin_server_ts":1678034001410,"hashes":{"sha256":"lcAUxUEP3Iof8CQupDZpTbWW3XyG+QC6YAuVGZNBwYA"},"signatures":{"localhost":{"ed25519:a_vyji":"N56NpfT+x5a+P2cIF8RK2oyZ5kh7dpbOOwvcPixEJYZXJEBb+8OdxCPQKApoIKqDETqKgoX8vJRxBEknbN7OBg"}},"unsigned":{"age_ts":1678034001410}}	3
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
!FzTtpSkXWMPYBKHUQN:localhost	$ls5AzJlLTu3Alykxvj5L99HqOQsi7cUGH7wVb-IqErQ	@matterbot:localhost	\N		13	25	1	0	0	main
!pYSbiOyjMFsKNxSMyi:localhost	$nFwL1txBnk2dj72aBWqthTGHrC-kv7CYWMt3cwz8qgw	@matterbot:localhost	\N		12	26	1	0	0	main
!FzTtpSkXWMPYBKHUQN:localhost	$hXzRSYfNTLUmjRz8EgsrekOmklfOoUQ9NKx0vS1AmTk	@matterbot:localhost	\N		15	28	1	0	0	main
!FzTtpSkXWMPYBKHUQN:localhost	$fbEIs1FPebLFup8Sm4TvsnGt3OqnXO125KPufsX6e4E	@matterbot:localhost	\N		16	29	1	0	0	main
!FzTtpSkXWMPYBKHUQN:localhost	$ggCddRubeCPps5yMhlY-9Ib0RvBhwUJy716vZvf32Oo	@admin:localhost	\N		17	30	1	0	0	main
!FzTtpSkXWMPYBKHUQN:localhost	$ggCddRubeCPps5yMhlY-9Ib0RvBhwUJy716vZvf32Oo	@matterbot:localhost	\N		17	30	1	0	0	main
!AHOiTmgdxQzlhIOUsy:localhost	$xOF81meT9KSyhw3dY5FjCzADSBULEj6OoQaHM9DWtMY	@matterbot:localhost	\N	["notify",{"set_tweak":"highlight","value":false},{"set_tweak":"sound","value":"default"}]	8	38	1	0	0	main
!AHOiTmgdxQzlhIOUsy:localhost	$hgeuyu5_SLbd99TLf-m4kSUM8l1Jy-W4XmhdQGO2rr0	@mm_user1.mm:localhost	\N	["notify",{"set_tweak":"highlight","value":false},{"set_tweak":"sound","value":"default"}]	10	40	1	0	0	main
!AHOiTmgdxQzlhIOUsy:localhost	$v3jGyApp70gdwh4Il9oB6nRxdyr-zF1Nt9w5VRI1Em4	@admin:localhost	\N		12	42	1	0	0	main
!AHOiTmgdxQzlhIOUsy:localhost	$v3jGyApp70gdwh4Il9oB6nRxdyr-zF1Nt9w5VRI1Em4	@matterbot:localhost	\N		12	42	1	0	0	main
!AHOiTmgdxQzlhIOUsy:localhost	$95vJ25qtpsri2l4-Ft6bN-NMw1uq9NjdTcLLt_v-cdE	@admin:localhost	\N		14	44	1	0	0	main
!AHOiTmgdxQzlhIOUsy:localhost	$95vJ25qtpsri2l4-Ft6bN-NMw1uq9NjdTcLLt_v-cdE	@matterbot:localhost	\N		14	44	1	0	0	main
!AHOiTmgdxQzlhIOUsy:localhost	$cy5KlfdXxrxwsh3JYgCvSt79RGqs9e0nqUdGznRRG7c	@admin:localhost	\N		16	46	1	0	0	main
!AHOiTmgdxQzlhIOUsy:localhost	$cy5KlfdXxrxwsh3JYgCvSt79RGqs9e0nqUdGznRRG7c	@matterbot:localhost	\N		16	46	1	0	0	main
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
@user1.matrix:localhost	!pYSbiOyjMFsKNxSMyi:localhost	0	22	0	22	main
@mm_user1.mm:localhost	!FzTtpSkXWMPYBKHUQN:localhost	1	23	0	\N	main
@matterbot:localhost	!pYSbiOyjMFsKNxSMyi:localhost	1	26	0	\N	main
@admin:localhost	!pYSbiOyjMFsKNxSMyi:localhost	0	26	0	26	main
@user1.matrix:localhost	!FzTtpSkXWMPYBKHUQN:localhost	0	29	0	29	main
@admin:localhost	!FzTtpSkXWMPYBKHUQN:localhost	1	30	0	28	main
@matterbot:localhost	!FzTtpSkXWMPYBKHUQN:localhost	4	30	0	\N	main
@mm_user1.mm:localhost	!AHOiTmgdxQzlhIOUsy:localhost	1	40	0	\N	main
@admin:localhost	!AHOiTmgdxQzlhIOUsy:localhost	3	46	0	\N	main
@matterbot:localhost	!AHOiTmgdxQzlhIOUsy:localhost	4	46	0	\N	main
\.


--
-- Data for Name: event_push_summary_last_receipt_stream_id; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_push_summary_last_receipt_stream_id (lock, stream_id) FROM stdin;
X	19
\.


--
-- Data for Name: event_push_summary_stream_ordering; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_push_summary_stream_ordering (lock, stream_ordering) FROM stdin;
X	46
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
$Z8l2x75Ktp4i5ZFSxqQHoicfewpQOJ2yKoIXvdXGGL4	!FzTtpSkXWMPYBKHUQN:localhost	\N	content.name	'squar':2 'town':1	1675956618677	8
$YSS-8MMEgCETq_EouYM-mm0KiVKGloqtULWeqmdQKZg	!pYSbiOyjMFsKNxSMyi:localhost	\N	content.name	'off-top':1 'topic':3	1675956697215	15
$ws9UuWLPn8VzHbofyg3g8AQK-aYsdD2iv6woyWt3sEw	!pYSbiOyjMFsKNxSMyi:localhost	\N	content.body	'hej':1	1676646372672	22
$ls5AzJlLTu3Alykxvj5L99HqOQsi7cUGH7wVb-IqErQ	!FzTtpSkXWMPYBKHUQN:localhost	\N	content.body	'oko':1	1678032937746	25
$nFwL1txBnk2dj72aBWqthTGHrC-kv7CYWMt3cwz8qgw	!pYSbiOyjMFsKNxSMyi:localhost	\N	content.body	'kook':1	1678032959618	26
$DRO5TAucLHxvrlJ47kjeEKQiKn1D0J-pwsDdrExDhfM	!FzTtpSkXWMPYBKHUQN:localhost	\N	content.name	'squar':2 'town':1	1678033164649	27
$hXzRSYfNTLUmjRz8EgsrekOmklfOoUQ9NKx0vS1AmTk	!FzTtpSkXWMPYBKHUQN:localhost	\N	content.body	'okok':1	1678033228922	28
$fbEIs1FPebLFup8Sm4TvsnGt3OqnXO125KPufsX6e4E	!FzTtpSkXWMPYBKHUQN:localhost	\N	content.body	'dokidoki':1	1678033249737	29
$ggCddRubeCPps5yMhlY-9Ib0RvBhwUJy716vZvf32Oo	!FzTtpSkXWMPYBKHUQN:localhost	\N	content.body	'kall':1	1678033315210	30
$sFv4HsuqMN9A0Wl_Bb1tZ-I7Kgdtxe83YsRaNWowWDM	!AHOiTmgdxQzlhIOUsy:localhost	\N	content.name	'work':2	1678033570448	37
$v3jGyApp70gdwh4Il9oB6nRxdyr-zF1Nt9w5VRI1Em4	!AHOiTmgdxQzlhIOUsy:localhost	\N	content.body	'klklk':1	1678033769274	42
$95vJ25qtpsri2l4-Ft6bN-NMw1uq9NjdTcLLt_v-cdE	!AHOiTmgdxQzlhIOUsy:localhost	\N	content.body	'klklk':1	1678033803466	44
$cy5KlfdXxrxwsh3JYgCvSt79RGqs9e0nqUdGznRRG7c	!AHOiTmgdxQzlhIOUsy:localhost	\N	content.body	'ddd':1	1678034001410	46
\.


--
-- Data for Name: event_to_state_groups; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_to_state_groups (event_id, state_group) FROM stdin;
$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4	2
$IU1ZxuT0Nte99MGUdW5IhEVc_pVMkrUEqjP5xs27dVs	3
$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o	4
$CgLbWRULI45y2D98z5CUQGfnpkIanhBTri6Qgk2FtZI	5
$MjPoUIyI-4SLUb_2CX0SN6Cq4siLSpO81XmSX0Tt1Ag	6
$eaTE2oVse5UGe2gxU6bH4McqUJFwuNN8UMpxUnfeCzc	7
$Z8l2x75Ktp4i5ZFSxqQHoicfewpQOJ2yKoIXvdXGGL4	8
$gyvaweguHrwLjB1B_41QMnzSUMHQGbQmTALeOOMmWfU	10
$hZ3X11MNOocXcrcCNowWncNXGOcKtKz2Yuy15DpSX9Y	11
$EgLH6XFurmJirUH4D5Zkm8y1WyPdrFX2SSko4S0-7hQ	12
$6A1pwZ_SweaaUsjoN5q44E3waqx9e_BX_Vch4BXsSMc	13
$tkoiHC3Vf1zAnFhhvTe60NQ7m3nRNvT1ILxtf8O8Tdc	14
$W2bBymarQF5AVOanxoytGxta4UVf4fhh6doJw6GmsQ0	15
$YSS-8MMEgCETq_EouYM-mm0KiVKGloqtULWeqmdQKZg	16
$0RmvI0B1zTbePI4eCXXUO_9tJQY2XcOy4Kt4FqYQ-Yk	17
$FSGyxWobRbm3XPzA_RJTfx_wFyj7eioybzttjovTej0	18
$f8S-mPLHMnruZFOTih-IYlCoYILk6A_BPx3dtO79ubI	19
$3iFc4KVKwTYBpN8T8PyFgNCDxXkCtJF5qS1nJbulpmU	20
$Q7qpUYZra7SmdftawkKRrQilka-WlRBbgKYybv2QRls	24
$o5ttVgA4qLDCRoIxN9qyVPOLj9QUajTOF3D_U8es57Y	23
$ws9UuWLPn8VzHbofyg3g8AQK-aYsdD2iv6woyWt3sEw	24
$EeKexStxnjQMJwZnkxIZRNXLdggHQGqT_RJYm1xCocU	27
$ZPGmNdM7zvGVfx5_posO0xAJ7C6aAnDZavYGV23i3eM	28
$ls5AzJlLTu3Alykxvj5L99HqOQsi7cUGH7wVb-IqErQ	28
$nFwL1txBnk2dj72aBWqthTGHrC-kv7CYWMt3cwz8qgw	24
$DRO5TAucLHxvrlJ47kjeEKQiKn1D0J-pwsDdrExDhfM	29
$hXzRSYfNTLUmjRz8EgsrekOmklfOoUQ9NKx0vS1AmTk	29
$fbEIs1FPebLFup8Sm4TvsnGt3OqnXO125KPufsX6e4E	29
$ggCddRubeCPps5yMhlY-9Ib0RvBhwUJy716vZvf32Oo	29
$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg	35
$2AEp1hOUUsulI8Zc2ISpcmI9VmKuftWZdClPUSC_mD4	38
$425aYo_LNE95R3HHpQZSk0MGS0CjqhCPkp0DJvtMk5M	39
$z1GwtHO3iyw6MvOYBxrwIdl_jvUlP6_Bn6yFfE9P2aI	40
$Ww-5pR04rXtgZleTLBj7vJSR1LGkC3tZ5Zuaxqazwek	41
$LmDzEqXVjmgNKIk52bhBmbosSuVDk32P02nhwggY0RM	42
$sFv4HsuqMN9A0Wl_Bb1tZ-I7Kgdtxe83YsRaNWowWDM	43
$xOF81meT9KSyhw3dY5FjCzADSBULEj6OoQaHM9DWtMY	44
$cgYituIGJ7X54S5-Ax3C5u2yLwCnf99x2VbMmy0YD3w	47
$hgeuyu5_SLbd99TLf-m4kSUM8l1Jy-W4XmhdQGO2rr0	50
$jiXC1l1ou9Ti0I7CV7PJrsVblqsrb9dPQentqZqLBys	51
$v3jGyApp70gdwh4Il9oB6nRxdyr-zF1Nt9w5VRI1Em4	51
$ye7ixCV2UmoA3GCF2K5lqNSxMrWwkdvkTSOdQDHy-P0	52
$95vJ25qtpsri2l4-Ft6bN-NMw1uq9NjdTcLLt_v-cdE	52
$0XMDIAwJBH-iA7qIReHWRJAwmGiTGGioVtV8KFmJ4_M	55
$cy5KlfdXxrxwsh3JYgCvSt79RGqs9e0nqUdGznRRG7c	55
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
1	$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4	m.room.create	!FzTtpSkXWMPYBKHUQN:localhost	\N	\N	t	f	1	1675956617863	1675956617959	@admin:localhost	f	master	2		\N
2	$IU1ZxuT0Nte99MGUdW5IhEVc_pVMkrUEqjP5xs27dVs	m.room.member	!FzTtpSkXWMPYBKHUQN:localhost	\N	\N	t	f	2	1675956618047	1675956618127	@admin:localhost	f	master	3	@admin:localhost	\N
3	$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o	m.room.power_levels	!FzTtpSkXWMPYBKHUQN:localhost	\N	\N	t	f	3	1675956618184	1675956618547	@admin:localhost	f	master	4		\N
4	$CgLbWRULI45y2D98z5CUQGfnpkIanhBTri6Qgk2FtZI	m.room.canonical_alias	!FzTtpSkXWMPYBKHUQN:localhost	\N	\N	t	f	4	1675956618243	1675956618547	@admin:localhost	f	master	5		\N
5	$MjPoUIyI-4SLUb_2CX0SN6Cq4siLSpO81XmSX0Tt1Ag	m.room.join_rules	!FzTtpSkXWMPYBKHUQN:localhost	\N	\N	t	f	5	1675956618273	1675956618547	@admin:localhost	f	master	6		\N
6	$eaTE2oVse5UGe2gxU6bH4McqUJFwuNN8UMpxUnfeCzc	m.room.history_visibility	!FzTtpSkXWMPYBKHUQN:localhost	\N	\N	t	f	6	1675956618289	1675956618547	@admin:localhost	f	master	7		\N
7	$Z8l2x75Ktp4i5ZFSxqQHoicfewpQOJ2yKoIXvdXGGL4	m.room.name	!FzTtpSkXWMPYBKHUQN:localhost	\N	\N	t	f	7	1675956618677	1675956618821	@admin:localhost	f	master	8		\N
1	$gyvaweguHrwLjB1B_41QMnzSUMHQGbQmTALeOOMmWfU	m.room.create	!pYSbiOyjMFsKNxSMyi:localhost	\N	\N	t	f	1	1675956696635	1675956696672	@admin:localhost	f	master	9		\N
2	$hZ3X11MNOocXcrcCNowWncNXGOcKtKz2Yuy15DpSX9Y	m.room.member	!pYSbiOyjMFsKNxSMyi:localhost	\N	\N	t	f	2	1675956696749	1675956696783	@admin:localhost	f	master	10	@admin:localhost	\N
3	$EgLH6XFurmJirUH4D5Zkm8y1WyPdrFX2SSko4S0-7hQ	m.room.power_levels	!pYSbiOyjMFsKNxSMyi:localhost	\N	\N	t	f	3	1675956696839	1675956697144	@admin:localhost	f	master	11		\N
4	$6A1pwZ_SweaaUsjoN5q44E3waqx9e_BX_Vch4BXsSMc	m.room.canonical_alias	!pYSbiOyjMFsKNxSMyi:localhost	\N	\N	t	f	4	1675956696896	1675956697144	@admin:localhost	f	master	12		\N
5	$tkoiHC3Vf1zAnFhhvTe60NQ7m3nRNvT1ILxtf8O8Tdc	m.room.join_rules	!pYSbiOyjMFsKNxSMyi:localhost	\N	\N	t	f	5	1675956696912	1675956697144	@admin:localhost	f	master	13		\N
6	$W2bBymarQF5AVOanxoytGxta4UVf4fhh6doJw6GmsQ0	m.room.history_visibility	!pYSbiOyjMFsKNxSMyi:localhost	\N	\N	t	f	6	1675956696928	1675956697144	@admin:localhost	f	master	14		\N
7	$YSS-8MMEgCETq_EouYM-mm0KiVKGloqtULWeqmdQKZg	m.room.name	!pYSbiOyjMFsKNxSMyi:localhost	\N	\N	t	f	7	1675956697215	1675956697328	@admin:localhost	f	master	15		\N
8	$0RmvI0B1zTbePI4eCXXUO_9tJQY2XcOy4Kt4FqYQ-Yk	m.room.member	!pYSbiOyjMFsKNxSMyi:localhost	\N	\N	t	f	8	1675956825837	1675956825870	@user1.matrix:localhost	f	master	16	@user1.matrix:localhost	\N
8	$FSGyxWobRbm3XPzA_RJTfx_wFyj7eioybzttjovTej0	m.room.member	!FzTtpSkXWMPYBKHUQN:localhost	\N	\N	t	f	8	1675956838410	1675956838438	@user1.matrix:localhost	f	master	17	@user1.matrix:localhost	\N
9	$3iFc4KVKwTYBpN8T8PyFgNCDxXkCtJF5qS1nJbulpmU	m.room.member	!FzTtpSkXWMPYBKHUQN:localhost	\N	\N	t	f	9	1676646214039	1676646214116	@matterbot:localhost	f	master	18	@matterbot:localhost	\N
9	$f8S-mPLHMnruZFOTih-IYlCoYILk6A_BPx3dtO79ubI	m.room.member	!pYSbiOyjMFsKNxSMyi:localhost	\N	\N	t	f	9	1676646214037	1676646214116	@matterbot:localhost	f	master	19	@matterbot:localhost	\N
10	$Q7qpUYZra7SmdftawkKRrQilka-WlRBbgKYybv2QRls	m.room.member	!pYSbiOyjMFsKNxSMyi:localhost	\N	\N	t	f	10	1676646295913	1676646295981	@matterbot:localhost	f	master	21	@matterbot:localhost	\N
10	$o5ttVgA4qLDCRoIxN9qyVPOLj9QUajTOF3D_U8es57Y	m.room.member	!FzTtpSkXWMPYBKHUQN:localhost	\N	\N	t	f	10	1676646295905	1676646295985	@matterbot:localhost	f	master	20	@matterbot:localhost	\N
11	$ws9UuWLPn8VzHbofyg3g8AQK-aYsdD2iv6woyWt3sEw	m.room.message	!pYSbiOyjMFsKNxSMyi:localhost	\N	\N	t	f	11	1676646372672	1676646372767	@matterbot:localhost	f	master	22	\N	\N
11	$EeKexStxnjQMJwZnkxIZRNXLdggHQGqT_RJYm1xCocU	m.room.member	!FzTtpSkXWMPYBKHUQN:localhost	\N	\N	t	f	11	1678032935186	1678032935249	@admin:localhost	f	master	23	@mm_user1.mm:localhost	\N
12	$ZPGmNdM7zvGVfx5_posO0xAJ7C6aAnDZavYGV23i3eM	m.room.member	!FzTtpSkXWMPYBKHUQN:localhost	\N	\N	t	f	12	1678032935470	1678032935542	@mm_user1.mm:localhost	f	master	24	@mm_user1.mm:localhost	\N
13	$ls5AzJlLTu3Alykxvj5L99HqOQsi7cUGH7wVb-IqErQ	m.room.message	!FzTtpSkXWMPYBKHUQN:localhost	\N	\N	t	f	13	1678032937746	1678032937838	@mm_user1.mm:localhost	f	master	25	\N	\N
12	$nFwL1txBnk2dj72aBWqthTGHrC-kv7CYWMt3cwz8qgw	m.room.message	!pYSbiOyjMFsKNxSMyi:localhost	\N	\N	t	f	12	1678032959618	1678032959682	@user1.matrix:localhost	f	master	26	\N	\N
14	$DRO5TAucLHxvrlJ47kjeEKQiKn1D0J-pwsDdrExDhfM	m.room.name	!FzTtpSkXWMPYBKHUQN:localhost	\N	\N	t	f	14	1678033164649	1678033164684	@admin:localhost	f	master	27		\N
15	$hXzRSYfNTLUmjRz8EgsrekOmklfOoUQ9NKx0vS1AmTk	m.room.message	!FzTtpSkXWMPYBKHUQN:localhost	\N	\N	t	f	15	1678033228922	1678033228962	@mm_user1.mm:localhost	f	master	28	\N	\N
16	$fbEIs1FPebLFup8Sm4TvsnGt3OqnXO125KPufsX6e4E	m.room.message	!FzTtpSkXWMPYBKHUQN:localhost	\N	\N	t	f	16	1678033249737	1678033249794	@admin:localhost	f	master	29	\N	\N
17	$ggCddRubeCPps5yMhlY-9Ib0RvBhwUJy716vZvf32Oo	m.room.message	!FzTtpSkXWMPYBKHUQN:localhost	\N	\N	t	f	17	1678033315210	1678033315237	@user1.matrix:localhost	f	master	30	\N	\N
1	$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg	m.room.create	!AHOiTmgdxQzlhIOUsy:localhost	\N	\N	t	f	1	1678033569475	1678033569595	@admin:localhost	f	master	31		\N
2	$2AEp1hOUUsulI8Zc2ISpcmI9VmKuftWZdClPUSC_mD4	m.room.member	!AHOiTmgdxQzlhIOUsy:localhost	\N	\N	t	f	2	1678033569732	1678033569807	@admin:localhost	f	master	32	@admin:localhost	\N
3	$425aYo_LNE95R3HHpQZSk0MGS0CjqhCPkp0DJvtMk5M	m.room.power_levels	!AHOiTmgdxQzlhIOUsy:localhost	\N	\N	t	f	3	1678033569956	1678033570321	@admin:localhost	f	master	33		\N
4	$z1GwtHO3iyw6MvOYBxrwIdl_jvUlP6_Bn6yFfE9P2aI	m.room.canonical_alias	!AHOiTmgdxQzlhIOUsy:localhost	\N	\N	t	f	4	1678033570034	1678033570321	@admin:localhost	f	master	34		\N
5	$Ww-5pR04rXtgZleTLBj7vJSR1LGkC3tZ5Zuaxqazwek	m.room.join_rules	!AHOiTmgdxQzlhIOUsy:localhost	\N	\N	t	f	5	1678033570055	1678033570321	@admin:localhost	f	master	35		\N
6	$LmDzEqXVjmgNKIk52bhBmbosSuVDk32P02nhwggY0RM	m.room.history_visibility	!AHOiTmgdxQzlhIOUsy:localhost	\N	\N	t	f	6	1678033570065	1678033570321	@admin:localhost	f	master	36		\N
7	$sFv4HsuqMN9A0Wl_Bb1tZ-I7Kgdtxe83YsRaNWowWDM	m.room.name	!AHOiTmgdxQzlhIOUsy:localhost	\N	\N	t	f	7	1678033570448	1678033570599	@admin:localhost	f	master	37		\N
8	$xOF81meT9KSyhw3dY5FjCzADSBULEj6OoQaHM9DWtMY	m.room.member	!AHOiTmgdxQzlhIOUsy:localhost	\N	\N	t	f	8	1678033570821	1678033570877	@admin:localhost	f	master	38	@matterbot:localhost	\N
9	$cgYituIGJ7X54S5-Ax3C5u2yLwCnf99x2VbMmy0YD3w	m.room.member	!AHOiTmgdxQzlhIOUsy:localhost	\N	\N	t	f	9	1678033706272	1678033706315	@matterbot:localhost	f	master	39	@matterbot:localhost	\N
11	$jiXC1l1ou9Ti0I7CV7PJrsVblqsrb9dPQentqZqLBys	m.room.member	!AHOiTmgdxQzlhIOUsy:localhost	\N	\N	t	f	11	1678033763086	1678033763129	@mm_user1.mm:localhost	f	master	41	@mm_user1.mm:localhost	\N
10	$hgeuyu5_SLbd99TLf-m4kSUM8l1Jy-W4XmhdQGO2rr0	m.room.member	!AHOiTmgdxQzlhIOUsy:localhost	\N	\N	t	f	10	1678033762706	1678033762807	@admin:localhost	f	master	40	@mm_user1.mm:localhost	\N
12	$v3jGyApp70gdwh4Il9oB6nRxdyr-zF1Nt9w5VRI1Em4	m.room.message	!AHOiTmgdxQzlhIOUsy:localhost	\N	\N	t	f	12	1678033769274	1678033769341	@mm_user1.mm:localhost	f	master	42	\N	\N
14	$95vJ25qtpsri2l4-Ft6bN-NMw1uq9NjdTcLLt_v-cdE	m.room.message	!AHOiTmgdxQzlhIOUsy:localhost	\N	\N	t	f	14	1678033803466	1678033803598	@mm_user1.mm:localhost	f	master	44	\N	\N
13	$ye7ixCV2UmoA3GCF2K5lqNSxMrWwkdvkTSOdQDHy-P0	m.room.member	!AHOiTmgdxQzlhIOUsy:localhost	\N	\N	t	f	13	1678033782282	1678033782332	@user1.matrix:localhost	f	master	43	@user1.matrix:localhost	\N
15	$0XMDIAwJBH-iA7qIReHWRJAwmGiTGGioVtV8KFmJ4_M	m.room.member	!AHOiTmgdxQzlhIOUsy:localhost	\N	\N	t	f	15	1678033936870	1678033936909	@matterbot:localhost	f	master	45	@matterbot:localhost	\N
16	$cy5KlfdXxrxwsh3JYgCvSt79RGqs9e0nqUdGznRRG7c	m.room.message	!AHOiTmgdxQzlhIOUsy:localhost	\N	\N	t	f	16	1678034001410	1678034001456	@user1.matrix:localhost	f	master	46	\N	\N
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
events	46	master
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
!FzTtpSkXWMPYBKHUQN:localhost	@admin:localhost	$IU1ZxuT0Nte99MGUdW5IhEVc_pVMkrUEqjP5xs27dVs	join
!pYSbiOyjMFsKNxSMyi:localhost	@admin:localhost	$hZ3X11MNOocXcrcCNowWncNXGOcKtKz2Yuy15DpSX9Y	join
!pYSbiOyjMFsKNxSMyi:localhost	@user1.matrix:localhost	$0RmvI0B1zTbePI4eCXXUO_9tJQY2XcOy4Kt4FqYQ-Yk	join
!FzTtpSkXWMPYBKHUQN:localhost	@user1.matrix:localhost	$FSGyxWobRbm3XPzA_RJTfx_wFyj7eioybzttjovTej0	join
!pYSbiOyjMFsKNxSMyi:localhost	@matterbot:localhost	$Q7qpUYZra7SmdftawkKRrQilka-WlRBbgKYybv2QRls	join
!FzTtpSkXWMPYBKHUQN:localhost	@matterbot:localhost	$o5ttVgA4qLDCRoIxN9qyVPOLj9QUajTOF3D_U8es57Y	join
!FzTtpSkXWMPYBKHUQN:localhost	@mm_user1.mm:localhost	$ZPGmNdM7zvGVfx5_posO0xAJ7C6aAnDZavYGV23i3eM	join
!AHOiTmgdxQzlhIOUsy:localhost	@admin:localhost	$2AEp1hOUUsulI8Zc2ISpcmI9VmKuftWZdClPUSC_mD4	join
!AHOiTmgdxQzlhIOUsy:localhost	@mm_user1.mm:localhost	$jiXC1l1ou9Ti0I7CV7PJrsVblqsrb9dPQentqZqLBys	join
!AHOiTmgdxQzlhIOUsy:localhost	@user1.matrix:localhost	$ye7ixCV2UmoA3GCF2K5lqNSxMrWwkdvkTSOdQDHy-P0	join
!AHOiTmgdxQzlhIOUsy:localhost	@matterbot:localhost	$0XMDIAwJBH-iA7qIReHWRJAwmGiTGGioVtV8KFmJ4_M	join
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
-- Data for Name: presence_stream; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.presence_stream (stream_id, user_id, state, last_active_ts, last_federation_update_ts, last_user_sync_ts, status_msg, currently_active, instance_name) FROM stdin;
36	@matterbot:localhost	offline	1676646372829	1676646371304	0	\N	f	master
53	@admin:localhost	offline	1678033250018	1678033310512	1678033275894	\N	t	master
67	@mm_user1.mm:localhost	offline	1678033803773	1678033767632	0	\N	f	master
71	@user1.matrix:localhost	offline	1678034031972	1678034065513	1678034032270	\N	t	master
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.profiles (user_id, displayname, avatar_url) FROM stdin;
admin	admin	\N
user1.matrix	user1.matrix	\N
matterbot	Mattermost Bridge	\N
mm_user1.mm	mm_user1.mm	\N
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
!pYSbiOyjMFsKNxSMyi:localhost	m.read	@user1.matrix:localhost	["$ws9UuWLPn8VzHbofyg3g8AQK-aYsdD2iv6woyWt3sEw"]	{"ts":1678032902531}	\N
!pYSbiOyjMFsKNxSMyi:localhost	m.read.private	@user1.matrix:localhost	["$ws9UuWLPn8VzHbofyg3g8AQK-aYsdD2iv6woyWt3sEw"]	{"ts":1678032902603}	\N
!pYSbiOyjMFsKNxSMyi:localhost	m.read	@admin:localhost	["$nFwL1txBnk2dj72aBWqthTGHrC-kv7CYWMt3cwz8qgw"]	{"ts":1678033104641}	\N
!pYSbiOyjMFsKNxSMyi:localhost	m.read.private	@admin:localhost	["$nFwL1txBnk2dj72aBWqthTGHrC-kv7CYWMt3cwz8qgw"]	{"ts":1678033104792}	\N
!FzTtpSkXWMPYBKHUQN:localhost	m.read	@admin:localhost	["$hXzRSYfNTLUmjRz8EgsrekOmklfOoUQ9NKx0vS1AmTk"]	{"ts":1678033233032}	\N
!FzTtpSkXWMPYBKHUQN:localhost	m.read.private	@admin:localhost	["$hXzRSYfNTLUmjRz8EgsrekOmklfOoUQ9NKx0vS1AmTk"]	{"ts":1678033233050}	\N
!FzTtpSkXWMPYBKHUQN:localhost	m.read	@user1.matrix:localhost	["$fbEIs1FPebLFup8Sm4TvsnGt3OqnXO125KPufsX6e4E"]	{"ts":1678033309259}	\N
!FzTtpSkXWMPYBKHUQN:localhost	m.read.private	@user1.matrix:localhost	["$fbEIs1FPebLFup8Sm4TvsnGt3OqnXO125KPufsX6e4E"]	{"ts":1678033309282}	\N
!AHOiTmgdxQzlhIOUsy:localhost	m.read	@user1.matrix:localhost	["$0XMDIAwJBH-iA7qIReHWRJAwmGiTGGioVtV8KFmJ4_M"]	{"ts":1678033997717}	\N
!AHOiTmgdxQzlhIOUsy:localhost	m.read.private	@user1.matrix:localhost	["$0XMDIAwJBH-iA7qIReHWRJAwmGiTGGioVtV8KFmJ4_M"]	{"ts":1678033997742}	\N
\.


--
-- Data for Name: receipts_linearized; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.receipts_linearized (stream_id, room_id, receipt_type, user_id, event_id, data, instance_name, event_stream_ordering, thread_id) FROM stdin;
2	!pYSbiOyjMFsKNxSMyi:localhost	m.read	@user1.matrix:localhost	$ws9UuWLPn8VzHbofyg3g8AQK-aYsdD2iv6woyWt3sEw	{"ts":1678032902531}	\N	22	\N
3	!pYSbiOyjMFsKNxSMyi:localhost	m.read.private	@user1.matrix:localhost	$ws9UuWLPn8VzHbofyg3g8AQK-aYsdD2iv6woyWt3sEw	{"ts":1678032902603}	\N	22	\N
6	!pYSbiOyjMFsKNxSMyi:localhost	m.read	@admin:localhost	$nFwL1txBnk2dj72aBWqthTGHrC-kv7CYWMt3cwz8qgw	{"ts":1678033104641}	\N	26	\N
7	!pYSbiOyjMFsKNxSMyi:localhost	m.read.private	@admin:localhost	$nFwL1txBnk2dj72aBWqthTGHrC-kv7CYWMt3cwz8qgw	{"ts":1678033104792}	\N	26	\N
10	!FzTtpSkXWMPYBKHUQN:localhost	m.read	@admin:localhost	$hXzRSYfNTLUmjRz8EgsrekOmklfOoUQ9NKx0vS1AmTk	{"ts":1678033233032}	\N	28	\N
11	!FzTtpSkXWMPYBKHUQN:localhost	m.read.private	@admin:localhost	$hXzRSYfNTLUmjRz8EgsrekOmklfOoUQ9NKx0vS1AmTk	{"ts":1678033233050}	\N	28	\N
12	!FzTtpSkXWMPYBKHUQN:localhost	m.read	@user1.matrix:localhost	$fbEIs1FPebLFup8Sm4TvsnGt3OqnXO125KPufsX6e4E	{"ts":1678033309259}	\N	29	\N
13	!FzTtpSkXWMPYBKHUQN:localhost	m.read.private	@user1.matrix:localhost	$fbEIs1FPebLFup8Sm4TvsnGt3OqnXO125KPufsX6e4E	{"ts":1678033309282}	\N	29	\N
18	!AHOiTmgdxQzlhIOUsy:localhost	m.read	@user1.matrix:localhost	$0XMDIAwJBH-iA7qIReHWRJAwmGiTGGioVtV8KFmJ4_M	{"ts":1678033997717}	\N	45	\N
19	!AHOiTmgdxQzlhIOUsy:localhost	m.read.private	@user1.matrix:localhost	$0XMDIAwJBH-iA7qIReHWRJAwmGiTGGioVtV8KFmJ4_M	{"ts":1678033997742}	\N	45	\N
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
@user1.matrix:localhost	!pYSbiOyjMFsKNxSMyi:localhost	m.fully_read	25	{"event_id":"$nFwL1txBnk2dj72aBWqthTGHrC-kv7CYWMt3cwz8qgw"}	\N
@admin:localhost	!pYSbiOyjMFsKNxSMyi:localhost	m.fully_read	29	{"event_id":"$nFwL1txBnk2dj72aBWqthTGHrC-kv7CYWMt3cwz8qgw"}	\N
@admin:localhost	!FzTtpSkXWMPYBKHUQN:localhost	m.fully_read	35	{"event_id":"$fbEIs1FPebLFup8Sm4TvsnGt3OqnXO125KPufsX6e4E"}	\N
@user1.matrix:localhost	!FzTtpSkXWMPYBKHUQN:localhost	m.fully_read	39	{"event_id":"$ggCddRubeCPps5yMhlY-9Ib0RvBhwUJy716vZvf32Oo"}	\N
@user1.matrix:localhost	!AHOiTmgdxQzlhIOUsy:localhost	m.fully_read	45	{"event_id":"$cy5KlfdXxrxwsh3JYgCvSt79RGqs9e0nqUdGznRRG7c"}	\N
\.


--
-- Data for Name: room_alias_servers; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_alias_servers (room_alias, server) FROM stdin;
#town-square:localhost	localhost
#off-topic:localhost	localhost
#after-work:localhost	localhost
\.


--
-- Data for Name: room_aliases; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_aliases (room_alias, room_id, creator) FROM stdin;
#town-square:localhost	!FzTtpSkXWMPYBKHUQN:localhost	@admin:localhost
#off-topic:localhost	!pYSbiOyjMFsKNxSMyi:localhost	@admin:localhost
#after-work:localhost	!AHOiTmgdxQzlhIOUsy:localhost	@admin:localhost
\.


--
-- Data for Name: room_depth; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_depth (room_id, min_depth) FROM stdin;
!FzTtpSkXWMPYBKHUQN:localhost	1
!pYSbiOyjMFsKNxSMyi:localhost	1
!AHOiTmgdxQzlhIOUsy:localhost	1
\.


--
-- Data for Name: room_memberships; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_memberships (event_id, user_id, sender, room_id, membership, forgotten, display_name, avatar_url) FROM stdin;
$IU1ZxuT0Nte99MGUdW5IhEVc_pVMkrUEqjP5xs27dVs	@admin:localhost	@admin:localhost	!FzTtpSkXWMPYBKHUQN:localhost	join	0	admin	\N
$hZ3X11MNOocXcrcCNowWncNXGOcKtKz2Yuy15DpSX9Y	@admin:localhost	@admin:localhost	!pYSbiOyjMFsKNxSMyi:localhost	join	0	admin	\N
$0RmvI0B1zTbePI4eCXXUO_9tJQY2XcOy4Kt4FqYQ-Yk	@user1.matrix:localhost	@user1.matrix:localhost	!pYSbiOyjMFsKNxSMyi:localhost	join	0	user1.matrix	\N
$FSGyxWobRbm3XPzA_RJTfx_wFyj7eioybzttjovTej0	@user1.matrix:localhost	@user1.matrix:localhost	!FzTtpSkXWMPYBKHUQN:localhost	join	0	user1.matrix	\N
$3iFc4KVKwTYBpN8T8PyFgNCDxXkCtJF5qS1nJbulpmU	@matterbot:localhost	@matterbot:localhost	!FzTtpSkXWMPYBKHUQN:localhost	join	0	Mattermost Bridge	\N
$f8S-mPLHMnruZFOTih-IYlCoYILk6A_BPx3dtO79ubI	@matterbot:localhost	@matterbot:localhost	!pYSbiOyjMFsKNxSMyi:localhost	join	0	Mattermost Bridge	\N
$Q7qpUYZra7SmdftawkKRrQilka-WlRBbgKYybv2QRls	@matterbot:localhost	@matterbot:localhost	!pYSbiOyjMFsKNxSMyi:localhost	join	0	Mattermost Bridge	\N
$o5ttVgA4qLDCRoIxN9qyVPOLj9QUajTOF3D_U8es57Y	@matterbot:localhost	@matterbot:localhost	!FzTtpSkXWMPYBKHUQN:localhost	join	0	Mattermost Bridge	\N
$EeKexStxnjQMJwZnkxIZRNXLdggHQGqT_RJYm1xCocU	@mm_user1.mm:localhost	@admin:localhost	!FzTtpSkXWMPYBKHUQN:localhost	invite	0	mm_user1.mm	\N
$ZPGmNdM7zvGVfx5_posO0xAJ7C6aAnDZavYGV23i3eM	@mm_user1.mm:localhost	@mm_user1.mm:localhost	!FzTtpSkXWMPYBKHUQN:localhost	join	0	mm_user1.mm	\N
$2AEp1hOUUsulI8Zc2ISpcmI9VmKuftWZdClPUSC_mD4	@admin:localhost	@admin:localhost	!AHOiTmgdxQzlhIOUsy:localhost	join	0	admin	\N
$xOF81meT9KSyhw3dY5FjCzADSBULEj6OoQaHM9DWtMY	@matterbot:localhost	@admin:localhost	!AHOiTmgdxQzlhIOUsy:localhost	invite	0	Mattermost Bridge	\N
$cgYituIGJ7X54S5-Ax3C5u2yLwCnf99x2VbMmy0YD3w	@matterbot:localhost	@matterbot:localhost	!AHOiTmgdxQzlhIOUsy:localhost	join	0	Mattermost Bridge	\N
$hgeuyu5_SLbd99TLf-m4kSUM8l1Jy-W4XmhdQGO2rr0	@mm_user1.mm:localhost	@admin:localhost	!AHOiTmgdxQzlhIOUsy:localhost	invite	0	mm_user1.mm	\N
$jiXC1l1ou9Ti0I7CV7PJrsVblqsrb9dPQentqZqLBys	@mm_user1.mm:localhost	@mm_user1.mm:localhost	!AHOiTmgdxQzlhIOUsy:localhost	join	0	mm_user1.mm	\N
$ye7ixCV2UmoA3GCF2K5lqNSxMrWwkdvkTSOdQDHy-P0	@user1.matrix:localhost	@user1.matrix:localhost	!AHOiTmgdxQzlhIOUsy:localhost	join	0	user1.matrix	\N
$0XMDIAwJBH-iA7qIReHWRJAwmGiTGGioVtV8KFmJ4_M	@matterbot:localhost	@matterbot:localhost	!AHOiTmgdxQzlhIOUsy:localhost	join	0	Mattermost Bridge	\N
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
!pYSbiOyjMFsKNxSMyi:localhost	9	3	0	0	0	3	21	0
!FzTtpSkXWMPYBKHUQN:localhost	10	4	0	0	0	4	27	0
!AHOiTmgdxQzlhIOUsy:localhost	10	4	0	0	0	4	45	0
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
!pYSbiOyjMFsKNxSMyi:localhost	#Off-Topic	#off-topic:localhost	public	shared	\N	\N	\N	t	\N	\N
!FzTtpSkXWMPYBKHUQN:localhost	Town Square	#town-square:localhost	public	shared	\N	\N	\N	t	\N	\N
!AHOiTmgdxQzlhIOUsy:localhost	After Work	#after-work:localhost	public	shared	\N	\N	\N	t	\N	\N
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
!FzTtpSkXWMPYBKHUQN:localhost	t	@admin:localhost	9	t
!pYSbiOyjMFsKNxSMyi:localhost	t	@admin:localhost	9	t
!AHOiTmgdxQzlhIOUsy:localhost	t	@admin:localhost	10	t
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
$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4	!FzTtpSkXWMPYBKHUQN:localhost	m.room.create		\N
$IU1ZxuT0Nte99MGUdW5IhEVc_pVMkrUEqjP5xs27dVs	!FzTtpSkXWMPYBKHUQN:localhost	m.room.member	@admin:localhost	\N
$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o	!FzTtpSkXWMPYBKHUQN:localhost	m.room.power_levels		\N
$CgLbWRULI45y2D98z5CUQGfnpkIanhBTri6Qgk2FtZI	!FzTtpSkXWMPYBKHUQN:localhost	m.room.canonical_alias		\N
$MjPoUIyI-4SLUb_2CX0SN6Cq4siLSpO81XmSX0Tt1Ag	!FzTtpSkXWMPYBKHUQN:localhost	m.room.join_rules		\N
$eaTE2oVse5UGe2gxU6bH4McqUJFwuNN8UMpxUnfeCzc	!FzTtpSkXWMPYBKHUQN:localhost	m.room.history_visibility		\N
$Z8l2x75Ktp4i5ZFSxqQHoicfewpQOJ2yKoIXvdXGGL4	!FzTtpSkXWMPYBKHUQN:localhost	m.room.name		\N
$gyvaweguHrwLjB1B_41QMnzSUMHQGbQmTALeOOMmWfU	!pYSbiOyjMFsKNxSMyi:localhost	m.room.create		\N
$hZ3X11MNOocXcrcCNowWncNXGOcKtKz2Yuy15DpSX9Y	!pYSbiOyjMFsKNxSMyi:localhost	m.room.member	@admin:localhost	\N
$EgLH6XFurmJirUH4D5Zkm8y1WyPdrFX2SSko4S0-7hQ	!pYSbiOyjMFsKNxSMyi:localhost	m.room.power_levels		\N
$6A1pwZ_SweaaUsjoN5q44E3waqx9e_BX_Vch4BXsSMc	!pYSbiOyjMFsKNxSMyi:localhost	m.room.canonical_alias		\N
$tkoiHC3Vf1zAnFhhvTe60NQ7m3nRNvT1ILxtf8O8Tdc	!pYSbiOyjMFsKNxSMyi:localhost	m.room.join_rules		\N
$W2bBymarQF5AVOanxoytGxta4UVf4fhh6doJw6GmsQ0	!pYSbiOyjMFsKNxSMyi:localhost	m.room.history_visibility		\N
$YSS-8MMEgCETq_EouYM-mm0KiVKGloqtULWeqmdQKZg	!pYSbiOyjMFsKNxSMyi:localhost	m.room.name		\N
$0RmvI0B1zTbePI4eCXXUO_9tJQY2XcOy4Kt4FqYQ-Yk	!pYSbiOyjMFsKNxSMyi:localhost	m.room.member	@user1.matrix:localhost	\N
$FSGyxWobRbm3XPzA_RJTfx_wFyj7eioybzttjovTej0	!FzTtpSkXWMPYBKHUQN:localhost	m.room.member	@user1.matrix:localhost	\N
$3iFc4KVKwTYBpN8T8PyFgNCDxXkCtJF5qS1nJbulpmU	!FzTtpSkXWMPYBKHUQN:localhost	m.room.member	@matterbot:localhost	\N
$f8S-mPLHMnruZFOTih-IYlCoYILk6A_BPx3dtO79ubI	!pYSbiOyjMFsKNxSMyi:localhost	m.room.member	@matterbot:localhost	\N
$Q7qpUYZra7SmdftawkKRrQilka-WlRBbgKYybv2QRls	!pYSbiOyjMFsKNxSMyi:localhost	m.room.member	@matterbot:localhost	\N
$o5ttVgA4qLDCRoIxN9qyVPOLj9QUajTOF3D_U8es57Y	!FzTtpSkXWMPYBKHUQN:localhost	m.room.member	@matterbot:localhost	\N
$EeKexStxnjQMJwZnkxIZRNXLdggHQGqT_RJYm1xCocU	!FzTtpSkXWMPYBKHUQN:localhost	m.room.member	@mm_user1.mm:localhost	\N
$ZPGmNdM7zvGVfx5_posO0xAJ7C6aAnDZavYGV23i3eM	!FzTtpSkXWMPYBKHUQN:localhost	m.room.member	@mm_user1.mm:localhost	\N
$DRO5TAucLHxvrlJ47kjeEKQiKn1D0J-pwsDdrExDhfM	!FzTtpSkXWMPYBKHUQN:localhost	m.room.name		\N
$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg	!AHOiTmgdxQzlhIOUsy:localhost	m.room.create		\N
$2AEp1hOUUsulI8Zc2ISpcmI9VmKuftWZdClPUSC_mD4	!AHOiTmgdxQzlhIOUsy:localhost	m.room.member	@admin:localhost	\N
$425aYo_LNE95R3HHpQZSk0MGS0CjqhCPkp0DJvtMk5M	!AHOiTmgdxQzlhIOUsy:localhost	m.room.power_levels		\N
$z1GwtHO3iyw6MvOYBxrwIdl_jvUlP6_Bn6yFfE9P2aI	!AHOiTmgdxQzlhIOUsy:localhost	m.room.canonical_alias		\N
$Ww-5pR04rXtgZleTLBj7vJSR1LGkC3tZ5Zuaxqazwek	!AHOiTmgdxQzlhIOUsy:localhost	m.room.join_rules		\N
$LmDzEqXVjmgNKIk52bhBmbosSuVDk32P02nhwggY0RM	!AHOiTmgdxQzlhIOUsy:localhost	m.room.history_visibility		\N
$sFv4HsuqMN9A0Wl_Bb1tZ-I7Kgdtxe83YsRaNWowWDM	!AHOiTmgdxQzlhIOUsy:localhost	m.room.name		\N
$xOF81meT9KSyhw3dY5FjCzADSBULEj6OoQaHM9DWtMY	!AHOiTmgdxQzlhIOUsy:localhost	m.room.member	@matterbot:localhost	\N
$cgYituIGJ7X54S5-Ax3C5u2yLwCnf99x2VbMmy0YD3w	!AHOiTmgdxQzlhIOUsy:localhost	m.room.member	@matterbot:localhost	\N
$hgeuyu5_SLbd99TLf-m4kSUM8l1Jy-W4XmhdQGO2rr0	!AHOiTmgdxQzlhIOUsy:localhost	m.room.member	@mm_user1.mm:localhost	\N
$jiXC1l1ou9Ti0I7CV7PJrsVblqsrb9dPQentqZqLBys	!AHOiTmgdxQzlhIOUsy:localhost	m.room.member	@mm_user1.mm:localhost	\N
$ye7ixCV2UmoA3GCF2K5lqNSxMrWwkdvkTSOdQDHy-P0	!AHOiTmgdxQzlhIOUsy:localhost	m.room.member	@user1.matrix:localhost	\N
$0XMDIAwJBH-iA7qIReHWRJAwmGiTGGioVtV8KFmJ4_M	!AHOiTmgdxQzlhIOUsy:localhost	m.room.member	@matterbot:localhost	\N
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
17	16
18	8
19	17
20	18
21	20
22	19
23	20
24	19
25	23
26	24
27	23
28	27
29	28
30	24
31	29
32	29
33	24
35	34
36	29
37	24
38	35
39	38
40	39
41	40
42	41
43	42
44	43
45	24
46	29
47	44
48	29
49	24
50	47
51	50
52	51
53	24
54	29
55	52
56	29
57	24
58	55
\.


--
-- Data for Name: state_groups; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.state_groups (id, room_id, event_id) FROM stdin;
1	!FzTtpSkXWMPYBKHUQN:localhost	$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4
2	!FzTtpSkXWMPYBKHUQN:localhost	$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4
3	!FzTtpSkXWMPYBKHUQN:localhost	$IU1ZxuT0Nte99MGUdW5IhEVc_pVMkrUEqjP5xs27dVs
4	!FzTtpSkXWMPYBKHUQN:localhost	$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o
5	!FzTtpSkXWMPYBKHUQN:localhost	$CgLbWRULI45y2D98z5CUQGfnpkIanhBTri6Qgk2FtZI
6	!FzTtpSkXWMPYBKHUQN:localhost	$MjPoUIyI-4SLUb_2CX0SN6Cq4siLSpO81XmSX0Tt1Ag
7	!FzTtpSkXWMPYBKHUQN:localhost	$eaTE2oVse5UGe2gxU6bH4McqUJFwuNN8UMpxUnfeCzc
8	!FzTtpSkXWMPYBKHUQN:localhost	$Z8l2x75Ktp4i5ZFSxqQHoicfewpQOJ2yKoIXvdXGGL4
9	!pYSbiOyjMFsKNxSMyi:localhost	$gyvaweguHrwLjB1B_41QMnzSUMHQGbQmTALeOOMmWfU
10	!pYSbiOyjMFsKNxSMyi:localhost	$gyvaweguHrwLjB1B_41QMnzSUMHQGbQmTALeOOMmWfU
11	!pYSbiOyjMFsKNxSMyi:localhost	$hZ3X11MNOocXcrcCNowWncNXGOcKtKz2Yuy15DpSX9Y
12	!pYSbiOyjMFsKNxSMyi:localhost	$EgLH6XFurmJirUH4D5Zkm8y1WyPdrFX2SSko4S0-7hQ
13	!pYSbiOyjMFsKNxSMyi:localhost	$6A1pwZ_SweaaUsjoN5q44E3waqx9e_BX_Vch4BXsSMc
14	!pYSbiOyjMFsKNxSMyi:localhost	$tkoiHC3Vf1zAnFhhvTe60NQ7m3nRNvT1ILxtf8O8Tdc
15	!pYSbiOyjMFsKNxSMyi:localhost	$W2bBymarQF5AVOanxoytGxta4UVf4fhh6doJw6GmsQ0
16	!pYSbiOyjMFsKNxSMyi:localhost	$YSS-8MMEgCETq_EouYM-mm0KiVKGloqtULWeqmdQKZg
17	!pYSbiOyjMFsKNxSMyi:localhost	$0RmvI0B1zTbePI4eCXXUO_9tJQY2XcOy4Kt4FqYQ-Yk
18	!FzTtpSkXWMPYBKHUQN:localhost	$FSGyxWobRbm3XPzA_RJTfx_wFyj7eioybzttjovTej0
19	!pYSbiOyjMFsKNxSMyi:localhost	$f8S-mPLHMnruZFOTih-IYlCoYILk6A_BPx3dtO79ubI
20	!FzTtpSkXWMPYBKHUQN:localhost	$3iFc4KVKwTYBpN8T8PyFgNCDxXkCtJF5qS1nJbulpmU
21	!FzTtpSkXWMPYBKHUQN:localhost	$YcoSJr-DvcCc-tKQXIETgbHkCCKp5ywfYSEP7FwJNVg
22	!pYSbiOyjMFsKNxSMyi:localhost	$g0YgOMpZrU12XHGE_JImFXmPw0oXOwAyL9YUVgBeAus
23	!FzTtpSkXWMPYBKHUQN:localhost	$o5ttVgA4qLDCRoIxN9qyVPOLj9QUajTOF3D_U8es57Y
24	!pYSbiOyjMFsKNxSMyi:localhost	$Q7qpUYZra7SmdftawkKRrQilka-WlRBbgKYybv2QRls
25	!FzTtpSkXWMPYBKHUQN:localhost	$v-RPl1MnPAYT4dt4hxl4d1Gm7w2cnpOUk_iSe7YrXkw
26	!pYSbiOyjMFsKNxSMyi:localhost	$W0Kev85uoK4HtaTboFMMIb0R4-OI70npSfIwsuN1uz4
27	!FzTtpSkXWMPYBKHUQN:localhost	$EeKexStxnjQMJwZnkxIZRNXLdggHQGqT_RJYm1xCocU
28	!FzTtpSkXWMPYBKHUQN:localhost	$ZPGmNdM7zvGVfx5_posO0xAJ7C6aAnDZavYGV23i3eM
29	!FzTtpSkXWMPYBKHUQN:localhost	$DRO5TAucLHxvrlJ47kjeEKQiKn1D0J-pwsDdrExDhfM
30	!pYSbiOyjMFsKNxSMyi:localhost	$49hU3P-5kYsnTx3CJPUme72tObqaB8N9yNpl1vossg0
31	!FzTtpSkXWMPYBKHUQN:localhost	$PhD0xLVzNFzNQJAGtcjcz0nnixE6r3d839kM34jIf8g
32	!FzTtpSkXWMPYBKHUQN:localhost	$XUcJQGRevuaXkoEgE402JABWjwOVdrPfzgcNMKlcXvQ
33	!pYSbiOyjMFsKNxSMyi:localhost	$34vL9xxsLi4aArevf8pDFa63kZ0lf5XiCWrx0PvRvoc
34	!AHOiTmgdxQzlhIOUsy:localhost	$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg
35	!AHOiTmgdxQzlhIOUsy:localhost	$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg
36	!FzTtpSkXWMPYBKHUQN:localhost	$YDG80zntJNOKuufcgLue9g9MOBQUoeyuXo0fOqGayjY
37	!pYSbiOyjMFsKNxSMyi:localhost	$jZVuOMfxwi2fSy7owVVDaurqzNHPBSyyf6s_XQ4A_pQ
38	!AHOiTmgdxQzlhIOUsy:localhost	$2AEp1hOUUsulI8Zc2ISpcmI9VmKuftWZdClPUSC_mD4
39	!AHOiTmgdxQzlhIOUsy:localhost	$425aYo_LNE95R3HHpQZSk0MGS0CjqhCPkp0DJvtMk5M
40	!AHOiTmgdxQzlhIOUsy:localhost	$z1GwtHO3iyw6MvOYBxrwIdl_jvUlP6_Bn6yFfE9P2aI
41	!AHOiTmgdxQzlhIOUsy:localhost	$Ww-5pR04rXtgZleTLBj7vJSR1LGkC3tZ5Zuaxqazwek
42	!AHOiTmgdxQzlhIOUsy:localhost	$LmDzEqXVjmgNKIk52bhBmbosSuVDk32P02nhwggY0RM
43	!AHOiTmgdxQzlhIOUsy:localhost	$sFv4HsuqMN9A0Wl_Bb1tZ-I7Kgdtxe83YsRaNWowWDM
44	!AHOiTmgdxQzlhIOUsy:localhost	$xOF81meT9KSyhw3dY5FjCzADSBULEj6OoQaHM9DWtMY
45	!pYSbiOyjMFsKNxSMyi:localhost	$8XIKpy3VZccQOZxN3XavU1N1CY5N8YeAUuuDHFgRbjo
46	!FzTtpSkXWMPYBKHUQN:localhost	$wOQZ-biY7hPAPo71sHDFOUXe-bE1aX20NkEOpY1H2AQ
47	!AHOiTmgdxQzlhIOUsy:localhost	$cgYituIGJ7X54S5-Ax3C5u2yLwCnf99x2VbMmy0YD3w
48	!FzTtpSkXWMPYBKHUQN:localhost	$-3q3Ljru6wRXp4Z-hERkktC9SzodlK3MxzturLMga1g
49	!pYSbiOyjMFsKNxSMyi:localhost	$fKwT_0cyHyELp6qqGTPHzbJje2OEetonvLamah2ZhK8
50	!AHOiTmgdxQzlhIOUsy:localhost	$hgeuyu5_SLbd99TLf-m4kSUM8l1Jy-W4XmhdQGO2rr0
51	!AHOiTmgdxQzlhIOUsy:localhost	$jiXC1l1ou9Ti0I7CV7PJrsVblqsrb9dPQentqZqLBys
52	!AHOiTmgdxQzlhIOUsy:localhost	$ye7ixCV2UmoA3GCF2K5lqNSxMrWwkdvkTSOdQDHy-P0
53	!pYSbiOyjMFsKNxSMyi:localhost	$D1G29RvWGOaQbLK3TneFxdVDSGCmaRgybbto1vcSU-A
54	!FzTtpSkXWMPYBKHUQN:localhost	$skxsbyvlUyuygH8xQqp6K3laNchIune5iQeSzc3tBx0
55	!AHOiTmgdxQzlhIOUsy:localhost	$0XMDIAwJBH-iA7qIReHWRJAwmGiTGGioVtV8KFmJ4_M
56	!FzTtpSkXWMPYBKHUQN:localhost	$tRn_uPjSoJQAFtSjVnO6sgd-SBLrufGp5xzhZhRqUzk
57	!pYSbiOyjMFsKNxSMyi:localhost	$62-3JFpTMlRpv4_xAN2cDJVPyTAxye0feXIBfnOHi_E
58	!AHOiTmgdxQzlhIOUsy:localhost	$pTP0-CXb2Wza_9WGoLY5ZytUdeNQu6_3znRjg9NDoNY
\.


--
-- Data for Name: state_groups_state; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.state_groups_state (state_group, room_id, type, state_key, event_id) FROM stdin;
2	!FzTtpSkXWMPYBKHUQN:localhost	m.room.create		$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4
3	!FzTtpSkXWMPYBKHUQN:localhost	m.room.member	@admin:localhost	$IU1ZxuT0Nte99MGUdW5IhEVc_pVMkrUEqjP5xs27dVs
4	!FzTtpSkXWMPYBKHUQN:localhost	m.room.power_levels		$1kn0z5XFW6tgZeQlEjEweLSJX_vv-w54n3uMagFyz9o
5	!FzTtpSkXWMPYBKHUQN:localhost	m.room.canonical_alias		$CgLbWRULI45y2D98z5CUQGfnpkIanhBTri6Qgk2FtZI
6	!FzTtpSkXWMPYBKHUQN:localhost	m.room.join_rules		$MjPoUIyI-4SLUb_2CX0SN6Cq4siLSpO81XmSX0Tt1Ag
7	!FzTtpSkXWMPYBKHUQN:localhost	m.room.history_visibility		$eaTE2oVse5UGe2gxU6bH4McqUJFwuNN8UMpxUnfeCzc
8	!FzTtpSkXWMPYBKHUQN:localhost	m.room.name		$Z8l2x75Ktp4i5ZFSxqQHoicfewpQOJ2yKoIXvdXGGL4
10	!pYSbiOyjMFsKNxSMyi:localhost	m.room.create		$gyvaweguHrwLjB1B_41QMnzSUMHQGbQmTALeOOMmWfU
11	!pYSbiOyjMFsKNxSMyi:localhost	m.room.member	@admin:localhost	$hZ3X11MNOocXcrcCNowWncNXGOcKtKz2Yuy15DpSX9Y
12	!pYSbiOyjMFsKNxSMyi:localhost	m.room.power_levels		$EgLH6XFurmJirUH4D5Zkm8y1WyPdrFX2SSko4S0-7hQ
13	!pYSbiOyjMFsKNxSMyi:localhost	m.room.canonical_alias		$6A1pwZ_SweaaUsjoN5q44E3waqx9e_BX_Vch4BXsSMc
14	!pYSbiOyjMFsKNxSMyi:localhost	m.room.join_rules		$tkoiHC3Vf1zAnFhhvTe60NQ7m3nRNvT1ILxtf8O8Tdc
15	!pYSbiOyjMFsKNxSMyi:localhost	m.room.history_visibility		$W2bBymarQF5AVOanxoytGxta4UVf4fhh6doJw6GmsQ0
16	!pYSbiOyjMFsKNxSMyi:localhost	m.room.name		$YSS-8MMEgCETq_EouYM-mm0KiVKGloqtULWeqmdQKZg
17	!pYSbiOyjMFsKNxSMyi:localhost	m.room.member	@user1.matrix:localhost	$0RmvI0B1zTbePI4eCXXUO_9tJQY2XcOy4Kt4FqYQ-Yk
18	!FzTtpSkXWMPYBKHUQN:localhost	m.room.member	@user1.matrix:localhost	$FSGyxWobRbm3XPzA_RJTfx_wFyj7eioybzttjovTej0
19	!pYSbiOyjMFsKNxSMyi:localhost	m.room.member	@matterbot:localhost	$f8S-mPLHMnruZFOTih-IYlCoYILk6A_BPx3dtO79ubI
20	!FzTtpSkXWMPYBKHUQN:localhost	m.room.member	@matterbot:localhost	$3iFc4KVKwTYBpN8T8PyFgNCDxXkCtJF5qS1nJbulpmU
21	!FzTtpSkXWMPYBKHUQN:localhost	m.room.member	@matterbot:localhost	$YcoSJr-DvcCc-tKQXIETgbHkCCKp5ywfYSEP7FwJNVg
22	!pYSbiOyjMFsKNxSMyi:localhost	m.room.member	@matterbot:localhost	$g0YgOMpZrU12XHGE_JImFXmPw0oXOwAyL9YUVgBeAus
23	!FzTtpSkXWMPYBKHUQN:localhost	m.room.member	@matterbot:localhost	$o5ttVgA4qLDCRoIxN9qyVPOLj9QUajTOF3D_U8es57Y
24	!pYSbiOyjMFsKNxSMyi:localhost	m.room.member	@matterbot:localhost	$Q7qpUYZra7SmdftawkKRrQilka-WlRBbgKYybv2QRls
26	!pYSbiOyjMFsKNxSMyi:localhost	m.room.member	@matterbot:localhost	$W0Kev85uoK4HtaTboFMMIb0R4-OI70npSfIwsuN1uz4
25	!FzTtpSkXWMPYBKHUQN:localhost	m.room.member	@matterbot:localhost	$v-RPl1MnPAYT4dt4hxl4d1Gm7w2cnpOUk_iSe7YrXkw
27	!FzTtpSkXWMPYBKHUQN:localhost	m.room.member	@mm_user1.mm:localhost	$EeKexStxnjQMJwZnkxIZRNXLdggHQGqT_RJYm1xCocU
28	!FzTtpSkXWMPYBKHUQN:localhost	m.room.member	@mm_user1.mm:localhost	$ZPGmNdM7zvGVfx5_posO0xAJ7C6aAnDZavYGV23i3eM
29	!FzTtpSkXWMPYBKHUQN:localhost	m.room.name		$DRO5TAucLHxvrlJ47kjeEKQiKn1D0J-pwsDdrExDhfM
30	!pYSbiOyjMFsKNxSMyi:localhost	m.room.member	@matterbot:localhost	$49hU3P-5kYsnTx3CJPUme72tObqaB8N9yNpl1vossg0
31	!FzTtpSkXWMPYBKHUQN:localhost	m.room.member	@matterbot:localhost	$PhD0xLVzNFzNQJAGtcjcz0nnixE6r3d839kM34jIf8g
32	!FzTtpSkXWMPYBKHUQN:localhost	m.room.member	@matterbot:localhost	$XUcJQGRevuaXkoEgE402JABWjwOVdrPfzgcNMKlcXvQ
33	!pYSbiOyjMFsKNxSMyi:localhost	m.room.member	@matterbot:localhost	$34vL9xxsLi4aArevf8pDFa63kZ0lf5XiCWrx0PvRvoc
35	!AHOiTmgdxQzlhIOUsy:localhost	m.room.create		$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg
36	!FzTtpSkXWMPYBKHUQN:localhost	m.room.member	@matterbot:localhost	$YDG80zntJNOKuufcgLue9g9MOBQUoeyuXo0fOqGayjY
37	!pYSbiOyjMFsKNxSMyi:localhost	m.room.member	@matterbot:localhost	$jZVuOMfxwi2fSy7owVVDaurqzNHPBSyyf6s_XQ4A_pQ
38	!AHOiTmgdxQzlhIOUsy:localhost	m.room.member	@admin:localhost	$2AEp1hOUUsulI8Zc2ISpcmI9VmKuftWZdClPUSC_mD4
39	!AHOiTmgdxQzlhIOUsy:localhost	m.room.power_levels		$425aYo_LNE95R3HHpQZSk0MGS0CjqhCPkp0DJvtMk5M
40	!AHOiTmgdxQzlhIOUsy:localhost	m.room.canonical_alias		$z1GwtHO3iyw6MvOYBxrwIdl_jvUlP6_Bn6yFfE9P2aI
41	!AHOiTmgdxQzlhIOUsy:localhost	m.room.join_rules		$Ww-5pR04rXtgZleTLBj7vJSR1LGkC3tZ5Zuaxqazwek
42	!AHOiTmgdxQzlhIOUsy:localhost	m.room.history_visibility		$LmDzEqXVjmgNKIk52bhBmbosSuVDk32P02nhwggY0RM
43	!AHOiTmgdxQzlhIOUsy:localhost	m.room.name		$sFv4HsuqMN9A0Wl_Bb1tZ-I7Kgdtxe83YsRaNWowWDM
44	!AHOiTmgdxQzlhIOUsy:localhost	m.room.member	@matterbot:localhost	$xOF81meT9KSyhw3dY5FjCzADSBULEj6OoQaHM9DWtMY
45	!pYSbiOyjMFsKNxSMyi:localhost	m.room.member	@matterbot:localhost	$8XIKpy3VZccQOZxN3XavU1N1CY5N8YeAUuuDHFgRbjo
46	!FzTtpSkXWMPYBKHUQN:localhost	m.room.member	@matterbot:localhost	$wOQZ-biY7hPAPo71sHDFOUXe-bE1aX20NkEOpY1H2AQ
47	!AHOiTmgdxQzlhIOUsy:localhost	m.room.member	@matterbot:localhost	$cgYituIGJ7X54S5-Ax3C5u2yLwCnf99x2VbMmy0YD3w
48	!FzTtpSkXWMPYBKHUQN:localhost	m.room.member	@matterbot:localhost	$-3q3Ljru6wRXp4Z-hERkktC9SzodlK3MxzturLMga1g
49	!pYSbiOyjMFsKNxSMyi:localhost	m.room.member	@matterbot:localhost	$fKwT_0cyHyELp6qqGTPHzbJje2OEetonvLamah2ZhK8
50	!AHOiTmgdxQzlhIOUsy:localhost	m.room.member	@mm_user1.mm:localhost	$hgeuyu5_SLbd99TLf-m4kSUM8l1Jy-W4XmhdQGO2rr0
51	!AHOiTmgdxQzlhIOUsy:localhost	m.room.member	@mm_user1.mm:localhost	$jiXC1l1ou9Ti0I7CV7PJrsVblqsrb9dPQentqZqLBys
52	!AHOiTmgdxQzlhIOUsy:localhost	m.room.member	@user1.matrix:localhost	$ye7ixCV2UmoA3GCF2K5lqNSxMrWwkdvkTSOdQDHy-P0
53	!pYSbiOyjMFsKNxSMyi:localhost	m.room.member	@matterbot:localhost	$D1G29RvWGOaQbLK3TneFxdVDSGCmaRgybbto1vcSU-A
54	!FzTtpSkXWMPYBKHUQN:localhost	m.room.member	@matterbot:localhost	$skxsbyvlUyuygH8xQqp6K3laNchIune5iQeSzc3tBx0
55	!AHOiTmgdxQzlhIOUsy:localhost	m.room.member	@matterbot:localhost	$0XMDIAwJBH-iA7qIReHWRJAwmGiTGGioVtV8KFmJ4_M
56	!FzTtpSkXWMPYBKHUQN:localhost	m.room.member	@matterbot:localhost	$tRn_uPjSoJQAFtSjVnO6sgd-SBLrufGp5xzhZhRqUzk
57	!pYSbiOyjMFsKNxSMyi:localhost	m.room.member	@matterbot:localhost	$62-3JFpTMlRpv4_xAN2cDJVPyTAxye0feXIBfnOHi_E
58	!AHOiTmgdxQzlhIOUsy:localhost	m.room.member	@matterbot:localhost	$pTP0-CXb2Wza_9WGoLY5ZytUdeNQu6_3znRjg9NDoNY
\.


--
-- Data for Name: stats_incremental_position; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.stats_incremental_position (lock, stream_id) FROM stdin;
X	46
\.


--
-- Data for Name: stream_ordering_to_exterm; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.stream_ordering_to_exterm (stream_ordering, room_id, event_id) FROM stdin;
2	!FzTtpSkXWMPYBKHUQN:localhost	$c4I4FYRPIltfSw8Wf6w1NWiI0mLCN0eVcYuMsCyqiS4
3	!FzTtpSkXWMPYBKHUQN:localhost	$IU1ZxuT0Nte99MGUdW5IhEVc_pVMkrUEqjP5xs27dVs
7	!FzTtpSkXWMPYBKHUQN:localhost	$eaTE2oVse5UGe2gxU6bH4McqUJFwuNN8UMpxUnfeCzc
8	!FzTtpSkXWMPYBKHUQN:localhost	$Z8l2x75Ktp4i5ZFSxqQHoicfewpQOJ2yKoIXvdXGGL4
9	!pYSbiOyjMFsKNxSMyi:localhost	$gyvaweguHrwLjB1B_41QMnzSUMHQGbQmTALeOOMmWfU
10	!pYSbiOyjMFsKNxSMyi:localhost	$hZ3X11MNOocXcrcCNowWncNXGOcKtKz2Yuy15DpSX9Y
14	!pYSbiOyjMFsKNxSMyi:localhost	$W2bBymarQF5AVOanxoytGxta4UVf4fhh6doJw6GmsQ0
15	!pYSbiOyjMFsKNxSMyi:localhost	$YSS-8MMEgCETq_EouYM-mm0KiVKGloqtULWeqmdQKZg
16	!pYSbiOyjMFsKNxSMyi:localhost	$0RmvI0B1zTbePI4eCXXUO_9tJQY2XcOy4Kt4FqYQ-Yk
17	!FzTtpSkXWMPYBKHUQN:localhost	$FSGyxWobRbm3XPzA_RJTfx_wFyj7eioybzttjovTej0
18	!FzTtpSkXWMPYBKHUQN:localhost	$3iFc4KVKwTYBpN8T8PyFgNCDxXkCtJF5qS1nJbulpmU
19	!pYSbiOyjMFsKNxSMyi:localhost	$f8S-mPLHMnruZFOTih-IYlCoYILk6A_BPx3dtO79ubI
21	!pYSbiOyjMFsKNxSMyi:localhost	$Q7qpUYZra7SmdftawkKRrQilka-WlRBbgKYybv2QRls
20	!FzTtpSkXWMPYBKHUQN:localhost	$o5ttVgA4qLDCRoIxN9qyVPOLj9QUajTOF3D_U8es57Y
22	!pYSbiOyjMFsKNxSMyi:localhost	$ws9UuWLPn8VzHbofyg3g8AQK-aYsdD2iv6woyWt3sEw
23	!FzTtpSkXWMPYBKHUQN:localhost	$EeKexStxnjQMJwZnkxIZRNXLdggHQGqT_RJYm1xCocU
24	!FzTtpSkXWMPYBKHUQN:localhost	$ZPGmNdM7zvGVfx5_posO0xAJ7C6aAnDZavYGV23i3eM
25	!FzTtpSkXWMPYBKHUQN:localhost	$ls5AzJlLTu3Alykxvj5L99HqOQsi7cUGH7wVb-IqErQ
26	!pYSbiOyjMFsKNxSMyi:localhost	$nFwL1txBnk2dj72aBWqthTGHrC-kv7CYWMt3cwz8qgw
27	!FzTtpSkXWMPYBKHUQN:localhost	$DRO5TAucLHxvrlJ47kjeEKQiKn1D0J-pwsDdrExDhfM
28	!FzTtpSkXWMPYBKHUQN:localhost	$hXzRSYfNTLUmjRz8EgsrekOmklfOoUQ9NKx0vS1AmTk
29	!FzTtpSkXWMPYBKHUQN:localhost	$fbEIs1FPebLFup8Sm4TvsnGt3OqnXO125KPufsX6e4E
30	!FzTtpSkXWMPYBKHUQN:localhost	$ggCddRubeCPps5yMhlY-9Ib0RvBhwUJy716vZvf32Oo
31	!AHOiTmgdxQzlhIOUsy:localhost	$8JzwefAwHCl96ZlTja5b5rV-MxH_1T91x6Yl6vKYGSg
32	!AHOiTmgdxQzlhIOUsy:localhost	$2AEp1hOUUsulI8Zc2ISpcmI9VmKuftWZdClPUSC_mD4
36	!AHOiTmgdxQzlhIOUsy:localhost	$LmDzEqXVjmgNKIk52bhBmbosSuVDk32P02nhwggY0RM
37	!AHOiTmgdxQzlhIOUsy:localhost	$sFv4HsuqMN9A0Wl_Bb1tZ-I7Kgdtxe83YsRaNWowWDM
38	!AHOiTmgdxQzlhIOUsy:localhost	$xOF81meT9KSyhw3dY5FjCzADSBULEj6OoQaHM9DWtMY
39	!AHOiTmgdxQzlhIOUsy:localhost	$cgYituIGJ7X54S5-Ax3C5u2yLwCnf99x2VbMmy0YD3w
40	!AHOiTmgdxQzlhIOUsy:localhost	$hgeuyu5_SLbd99TLf-m4kSUM8l1Jy-W4XmhdQGO2rr0
41	!AHOiTmgdxQzlhIOUsy:localhost	$jiXC1l1ou9Ti0I7CV7PJrsVblqsrb9dPQentqZqLBys
42	!AHOiTmgdxQzlhIOUsy:localhost	$v3jGyApp70gdwh4Il9oB6nRxdyr-zF1Nt9w5VRI1Em4
43	!AHOiTmgdxQzlhIOUsy:localhost	$ye7ixCV2UmoA3GCF2K5lqNSxMrWwkdvkTSOdQDHy-P0
44	!AHOiTmgdxQzlhIOUsy:localhost	$95vJ25qtpsri2l4-Ft6bN-NMw1uq9NjdTcLLt_v-cdE
45	!AHOiTmgdxQzlhIOUsy:localhost	$0XMDIAwJBH-iA7qIReHWRJAwmGiTGGioVtV8KFmJ4_M
46	!AHOiTmgdxQzlhIOUsy:localhost	$cy5KlfdXxrxwsh3JYgCvSt79RGqs9e0nqUdGznRRG7c
\.


--
-- Data for Name: stream_positions; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.stream_positions (stream_name, instance_name, stream_id) FROM stdin;
receipts	master	19
events	master	46
account_data	master	45
presence_stream	master	71
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
-- Data for Name: un_partial_stated_event_stream; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.un_partial_stated_event_stream (stream_id, instance_name, event_id, rejection_status_changed) FROM stdin;
\.


--
-- Data for Name: un_partial_stated_room_stream; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.un_partial_stated_room_stream (stream_id, instance_name, room_id) FROM stdin;
\.


--
-- Data for Name: user_daily_visits; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_daily_visits (user_id, device_id, "timestamp", user_agent) FROM stdin;
@admin:localhost	LWSWGUCQHK	1675900800000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36
@user1.matrix:localhost	TVVUNPJUJZ	1675900800000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36
@user1.matrix:localhost	VPHDFELNLR	1677974400000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36
@admin:localhost	OZJZGYFHKP	1677974400000	axios/1.3.2
@user1.matrix:localhost	GQUGBBJECP	1677974400000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36
@admin:localhost	WYMFZMMAGV	1677974400000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36
\.


--
-- Data for Name: user_directory; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_directory (user_id, room_id, display_name, avatar_url) FROM stdin;
@admin:localhost	\N	admin	\N
@user1.matrix:localhost	\N	user1.matrix	\N
\.


--
-- Data for Name: user_directory_search; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_directory_search (user_id, vector) FROM stdin;
@admin:localhost	'admin':1A,3B 'localhost':2
@user1.matrix:localhost	'localhost':2 'user1.matrix':1A,3B
\.


--
-- Data for Name: user_directory_stream_pos; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_directory_stream_pos (lock, stream_id) FROM stdin;
X	46
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
user1.matrix	0	\\x7b22726f6f6d223a7b227374617465223a7b226c617a795f6c6f61645f6d656d62657273223a747275657d2c2274696d656c696e65223a7b22756e726561645f7468726561645f6e6f74696669636174696f6e73223a747275657d7d7d
\.


--
-- Data for Name: user_ips; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_ips (user_id, access_token, device_id, ip, user_agent, last_seen) FROM stdin;
@admin:localhost	syt_YWRtaW4_HzSAvDjKsSuGPIUmeheO_19s0jm	LWSWGUCQHK	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36	1675956679412
@user1.matrix:localhost	syt_dXNlcjEubWF0cml4_LDaxTViGjdehvJXyYkMx_0MwbKp	TVVUNPJUJZ	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36	1675958805843
@user1.matrix:localhost	syt_dXNlcjEubWF0cml4_ENEVYSTmTTMOFxEOKoKJ_0bGIae	VPHDFELNLR	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36	1678033020328
@mm_user1.mm:localhost	syt_bW1fdXNlcjEubW0_IunjotstMScFaScLrPOc_0mVBOr	NEISSLGWTR	172.16.238.1	axios/1.3.2	1678033179129
@admin:localhost	syt_YWRtaW4_qBoxylZXGoaTkMpOxawg_4SQ49f	WYMFZMMAGV	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36	1678033227722
@mm_user1.mm:localhost	syt_bW1fdXNlcjEubW0_wPGKGCeFNoOzLYPunbBr_3uSoKr	NPASEFYMXA	172.16.238.1	axios/1.3.2	1678033565759
@user1.matrix:localhost	syt_dXNlcjEubWF0cml4_DpWjksZWbpepOHDeLFOl_46Vnpc	GQUGBBJECP	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36	1678033928726
@mm_user1.mm:localhost	syt_bW1fdXNlcjEubW0_oTMHTIecwTAOMSwTHtBV_3qDyhz	NYIKZJDRFF	172.16.238.1	axios/1.3.2	1678033930340
@admin:localhost	syt_YWRtaW4_ESjBoGLaWtscFgZHsBhJ_027WFj	OZJZGYFHKP	172.16.238.1	axios/1.3.2	1678033936477
\.


--
-- Data for Name: user_signature_stream; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_signature_stream (stream_id, from_user_id, user_ids) FROM stdin;
5	@admin:localhost	["@admin:localhost"]
12	@user1.matrix:localhost	["@user1.matrix:localhost"]
\.


--
-- Data for Name: user_stats_current; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_stats_current (user_id, joined_rooms, completed_delta_stream_id) FROM stdin;
@admin:localhost	3	32
@matterbot:localhost	3	39
@mm_user1.mm:localhost	2	41
@user1.matrix:localhost	3	43
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
@admin:localhost	$2b$12$qDIHQv..pEFffVrWHTUGqem1aLBPWQwOGJtnPDy79poJOB5F9ppfS	1675956521	1	\N	0	\N	\N	\N	\N	0	f	\N	t
@user1.matrix:localhost	$2b$12$QUKVuA1bwKpslWNfisIeGeZ5/L4A6M5di4AUYKbdBt5Kx7nlcA9w2	1675956810	0	\N	0	\N	\N	\N	\N	0	f	\N	t
@matterbot:localhost		1675957082	0	\N	0	xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	\N	\N	\N	0	f	\N	t
@mm_user1.mm:localhost		1676646214	0	\N	0	xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	\N	\N	\N	0	f	\N	t
\.


--
-- Data for Name: users_in_public_rooms; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.users_in_public_rooms (user_id, room_id) FROM stdin;
@admin:localhost	!FzTtpSkXWMPYBKHUQN:localhost
@user1.matrix:localhost	!FzTtpSkXWMPYBKHUQN:localhost
@admin:localhost	!pYSbiOyjMFsKNxSMyi:localhost
@user1.matrix:localhost	!pYSbiOyjMFsKNxSMyi:localhost
@admin:localhost	!AHOiTmgdxQzlhIOUsy:localhost
@user1.matrix:localhost	!AHOiTmgdxQzlhIOUsy:localhost
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

SELECT pg_catalog.setval('public.account_data_sequence', 45, true);


--
-- Name: application_services_txn_id_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.application_services_txn_id_seq', 22, true);


--
-- Name: cache_invalidation_stream_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.cache_invalidation_stream_seq', 161, true);


--
-- Name: device_inbox_sequence; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.device_inbox_sequence', 1, true);


--
-- Name: event_auth_chain_id; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.event_auth_chain_id', 30, true);


--
-- Name: events_backfill_stream_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.events_backfill_stream_seq', 1, true);


--
-- Name: events_stream_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.events_stream_seq', 46, true);


--
-- Name: instance_map_instance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.instance_map_instance_id_seq', 1, false);


--
-- Name: presence_stream_sequence; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.presence_stream_sequence', 71, true);


--
-- Name: receipts_sequence; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.receipts_sequence', 19, true);


--
-- Name: state_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.state_group_id_seq', 58, true);


--
-- Name: un_partial_stated_event_stream_sequence; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.un_partial_stated_event_stream_sequence', 1, true);


--
-- Name: un_partial_stated_room_stream_sequence; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.un_partial_stated_room_stream_sequence', 1, true);


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
-- Name: un_partial_stated_event_stream un_partial_stated_event_stream_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.un_partial_stated_event_stream
    ADD CONSTRAINT un_partial_stated_event_stream_pkey PRIMARY KEY (stream_id);


--
-- Name: un_partial_stated_room_stream un_partial_stated_room_stream_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.un_partial_stated_room_stream
    ADD CONSTRAINT un_partial_stated_room_stream_pkey PRIMARY KEY (stream_id);


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
-- Name: events_jump_to_date_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX events_jump_to_date_idx ON public.events USING btree (room_id, origin_server_ts) WHERE (NOT outlier);


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
-- Name: un_partial_stated_event_stream_room_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX un_partial_stated_event_stream_room_id ON public.un_partial_stated_event_stream USING btree (event_id);


--
-- Name: un_partial_stated_room_stream_room_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX un_partial_stated_room_stream_room_id ON public.un_partial_stated_room_stream USING btree (room_id);


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
-- Name: un_partial_stated_event_stream un_partial_stated_event_stream_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.un_partial_stated_event_stream
    ADD CONSTRAINT un_partial_stated_event_stream_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.events(event_id) ON DELETE CASCADE;


--
-- Name: un_partial_stated_room_stream un_partial_stated_room_stream_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.un_partial_stated_room_stream
    ADD CONSTRAINT un_partial_stated_room_stream_room_id_fkey FOREIGN KEY (room_id) REFERENCES public.rooms(room_id) ON DELETE CASCADE;


--
-- Name: users_to_send_full_presence_to users_to_send_full_presence_to_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.users_to_send_full_presence_to
    ADD CONSTRAINT users_to_send_full_presence_to_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(name);


--
-- PostgreSQL database dump complete
--

