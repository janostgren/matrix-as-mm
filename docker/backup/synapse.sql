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
7	@mm_user1.mm:localhost	IMKODBTCSL	syt_bW1fdXNlcjEubW0_TaVMjHzgIoHJYnEUqmaC_4C6dVv	\N	\N	1675814025571	\N	f
6	@user1.matrix:localhost	JAVZUYJBSA	syt_dXNlcjEubWF0cml4_qsgIFfitnStvFzGKJtmp_4BJJm7	\N	\N	1675794323617	\N	t
\.


--
-- Data for Name: account_data; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.account_data (user_id, account_data_type, stream_id, content, instance_name) FROM stdin;
@admin:localhost	org.matrix.msc3890.local_notification_settings.MCWQGRUWJV	3	{"is_silenced":false}	\N
@admin:localhost	im.vector.analytics	4	{"pseudonymousAnalyticsOptIn":false}	\N
@admin:localhost	im.vector.setting.breadcrumbs	17	{"recent_rooms":["!DaecDLDoTLOuqPWadN:localhost","!YmJPedFXUiFFGzTnFq:localhost"]}	\N
@user1.matrix:localhost	org.matrix.msc3890.local_notification_settings.JAVZUYJBSA	20	{"is_silenced":false}	\N
@user1.matrix:localhost	im.vector.analytics	22	{"pseudonymousAnalyticsOptIn":false}	\N
@user1.matrix:localhost	im.vector.web.settings	27	{"FTUE.useCaseSelection":"Skip","SpotlightSearch.recentSearches":["!DaecDLDoTLOuqPWadN:localhost","!YmJPedFXUiFFGzTnFq:localhost"]}	\N
@user1.matrix:localhost	im.vector.setting.breadcrumbs	50	{"recent_rooms":["!ZAIhwwJJQkZbVCWAWl:localhost","!YmJPedFXUiFFGzTnFq:localhost","!DaecDLDoTLOuqPWadN:localhost","!vzmIkPMtQHAHPQecus:localhost"]}	\N
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
X	113
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
43	master	user_last_seen_monthly_active	\N	1675793873199
44	master	get_monthly_active_count	{}	1675793873221
45	master	get_user_by_id	{@user1.matrix:localhost}	1675794322207
46	master	count_e2e_one_time_keys	{@user1.matrix:localhost,JAVZUYJBSA}	1675794323142
47	master	get_e2e_unused_fallback_key_types	{@user1.matrix:localhost,JAVZUYJBSA}	1675794323162
48	master	count_e2e_one_time_keys	{@user1.matrix:localhost,JAVZUYJBSA}	1675794323231
49	master	count_e2e_one_time_keys	{@user1.matrix:localhost,JAVZUYJBSA}	1675794323289
50	master	count_e2e_one_time_keys	{@user1.matrix:localhost,JAVZUYJBSA}	1675794323345
51	master	count_e2e_one_time_keys	{@user1.matrix:localhost,JAVZUYJBSA}	1675794323398
52	master	count_e2e_one_time_keys	{@user1.matrix:localhost,JAVZUYJBSA}	1675794323457
53	master	count_e2e_one_time_keys	{@user1.matrix:localhost,JAVZUYJBSA}	1675794323513
54	master	count_e2e_one_time_keys	{@user1.matrix:localhost,JAVZUYJBSA}	1675794323572
55	master	_get_bare_e2e_cross_signing_keys	{@user1.matrix:localhost}	1675794323634
56	master	_get_bare_e2e_cross_signing_keys	{@user1.matrix:localhost}	1675794323641
57	master	_get_bare_e2e_cross_signing_keys	{@user1.matrix:localhost}	1675794323647
58	master	count_e2e_one_time_keys	{@user1.matrix:localhost,JAVZUYJBSA}	1675794323671
59	master	count_e2e_one_time_keys	{@user1.matrix:localhost,JAVZUYJBSA}	1675794323824
60	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@user1.matrix:localhost}	1675794349530
61	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@user1.matrix:localhost}	1675794373846
62	master	user_last_seen_monthly_active	\N	1675794474386
63	master	get_monthly_active_count	{}	1675794474409
64	master	get_aliases_for_room	{!ZAIhwwJJQkZbVCWAWl:localhost}	1675797059970
65	master	cs_cache_fake	{!ZAIhwwJJQkZbVCWAWl:localhost}	1675797060049
66	master	cs_cache_fake	{!ZAIhwwJJQkZbVCWAWl:localhost,@user1.matrix:localhost}	1675797060208
67	master	cs_cache_fake	{!ZAIhwwJJQkZbVCWAWl:localhost}	1675797060718
68	master	cs_cache_fake	{!ZAIhwwJJQkZbVCWAWl:localhost}	1675797061081
69	master	cs_cache_fake	{!ZAIhwwJJQkZbVCWAWl:localhost,@matterbot:localhost}	1675797061314
70	master	cs_cache_fake	{!ZAIhwwJJQkZbVCWAWl:localhost}	1675797081201
71	master	cs_cache_fake	{!ZAIhwwJJQkZbVCWAWl:localhost,@mm_admin:localhost}	1675797190253
72	master	user_last_seen_monthly_active	\N	1675813493854
73	master	get_monthly_active_count	{}	1675813493878
74	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@matterbot:localhost}	1675814024649
75	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@matterbot:localhost}	1675814024658
76	master	get_user_by_id	{@mm_user1.mm:localhost}	1675814025544
77	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@matterbot:localhost}	1675814025967
78	master	user_last_seen_monthly_active	\N	1675877176958
79	master	get_monthly_active_count	{}	1675877176993
80	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@matterbot:localhost}	1675877263646
81	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@matterbot:localhost}	1675877264242
82	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@matterbot:localhost}	1675877264310
83	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@matterbot:localhost}	1675877264495
84	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@matterbot:localhost}	1675877264541
85	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@matterbot:localhost}	1675877556250
86	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@matterbot:localhost}	1675877556251
87	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@matterbot:localhost}	1675877556778
88	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@matterbot:localhost}	1675877556779
89	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@matterbot:localhost}	1675877556985
90	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@matterbot:localhost}	1675877557008
91	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@matterbot:localhost}	1675877728441
92	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@matterbot:localhost}	1675877728450
93	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@matterbot:localhost}	1675877728911
94	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@matterbot:localhost}	1675877728918
95	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@matterbot:localhost}	1675877729099
96	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@matterbot:localhost}	1675877729189
97	master	user_last_seen_monthly_active	\N	1675878347990
98	master	get_monthly_active_count	{}	1675878347999
99	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@matterbot:localhost}	1675878356526
100	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@matterbot:localhost}	1675878356526
101	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@matterbot:localhost}	1675878357285
102	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@matterbot:localhost}	1675878357430
103	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@matterbot:localhost}	1675878357883
104	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@matterbot:localhost}	1675878357900
105	master	user_last_seen_monthly_active	\N	1675879381483
106	master	get_monthly_active_count	{}	1675879381516
107	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@matterbot:localhost}	1675879386659
108	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@matterbot:localhost}	1675879386673
109	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@matterbot:localhost}	1675879387453
110	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@matterbot:localhost}	1675879387458
111	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@matterbot:localhost}	1675879387800
112	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@matterbot:localhost}	1675879387800
113	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@matterbot:localhost}	1675879697444
114	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@matterbot:localhost}	1675879697463
115	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@matterbot:localhost}	1675879698181
116	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@matterbot:localhost}	1675879698283
117	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@matterbot:localhost}	1675879698561
118	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@matterbot:localhost}	1675879698654
119	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@matterbot:localhost}	1675879780366
120	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@matterbot:localhost}	1675879780418
121	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@matterbot:localhost}	1675879781000
122	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@matterbot:localhost}	1675879781102
123	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@matterbot:localhost}	1675879781318
124	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@matterbot:localhost}	1675879781488
127	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@matterbot:localhost}	1675880228250
129	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@matterbot:localhost}	1675880228563
131	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@matterbot:localhost}	1675880501858
125	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@matterbot:localhost}	1675880227532
134	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@matterbot:localhost}	1675880503079
126	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@matterbot:localhost}	1675880227537
128	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@matterbot:localhost}	1675880228277
132	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@matterbot:localhost}	1675880501859
133	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@matterbot:localhost}	1675880502780
130	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@matterbot:localhost}	1675880228599
135	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@matterbot:localhost}	1675880656008
136	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@matterbot:localhost}	1675880656039
137	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@matterbot:localhost}	1675880656618
138	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@matterbot:localhost}	1675880656635
139	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@matterbot:localhost}	1675880912144
140	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@matterbot:localhost}	1675880913071
141	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@matterbot:localhost}	1675880965384
142	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@matterbot:localhost}	1675880965407
144	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@matterbot:localhost}	1675880966252
143	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@matterbot:localhost}	1675880966252
145	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@matterbot:localhost}	1675881027263
146	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@matterbot:localhost}	1675881027368
147	master	cs_cache_fake	{!DaecDLDoTLOuqPWadN:localhost,@matterbot:localhost}	1675881596723
148	master	cs_cache_fake	{!YmJPedFXUiFFGzTnFq:localhost,@matterbot:localhost}	1675881596725
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
25	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@user1.matrix:localhost	$4Wo5EetfrJ0oD7aWVI6CvS_-ZUM3lsyzkFZeQElMcmI	\N	master
26	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@user1.matrix:localhost	$eOdfuP6TezgWF5799z0-muVXLh1k8LvHE2Wfob0cC3A	\N	master
31	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.create		$SCwfg4xWBzxHVcFLtW1DbcDU4LMVkfgjYJG-qdUypcM	\N	master
32	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.member	@user1.matrix:localhost	$RB7fKTVNYlqIOEPsSHLuZd4VtyQWzJBKjadsEKrzboc	\N	master
33	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.canonical_alias		$qx1E7MsFRdI9CbDeDYHg3A8XeN6MXU2rkBGCoxPB5mw	\N	master
33	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.history_visibility		$MWD--uqyNXbmKDBMJob9sDY5AM4riTmkAwwz36FIaPk	\N	master
33	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.join_rules		$1kUMRxz6Q6tB2pRvD-yuOBQbj2dooMjTGymKWTyL_I0	\N	master
33	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.power_levels		$VypxR6iKVehL3VR2C035y9gijIu-KXtOmJ85mKX9XLI	\N	master
37	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.name		$a1xA663y2WchzA_Q5jmTKVlInC_HDgPTK8C2g37ysdk	\N	master
38	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.member	@matterbot:localhost	$wdUPyT-0i7vmiiPz1WNunqvPAIWSfFtnwV1OizPIkvg	\N	master
40	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.member	@mm_admin:localhost	$al7p9tH0ZoT5Yu3HsYz1r2ak-9HkXf2coQ7KKeBerUk	\N	master
43	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$E44xF_r_bYO9HOH-lw-VkWepvoS6z9dxDWthhfbpT9M	$ykL4uD4FNcb8S_8kQpwbthwvqPKRzD_pJ3jyfA-5ywc	master
42	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$PksohbU2dYCXTn5ETrl9bIqsEVAPP0Wohp--_6XwmYg	$06pNLPsFn-fF2WbziopICIA6qaey-LFJhiTAHGfqJS4	master
44	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$ycR02cfa_D8mViUfnzHTBMWRlLibcN2pYZDwiiQUt8I	$PksohbU2dYCXTn5ETrl9bIqsEVAPP0Wohp--_6XwmYg	master
47	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$4EiubgnrkRAh09BKQLVXOeE9xGDhNpI_objrHMKclmA	$ycR02cfa_D8mViUfnzHTBMWRlLibcN2pYZDwiiQUt8I	master
48	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$9-LSz3ddCTGWUa1IWqJRNNSh2mJrY7YVMY_uo340Sek	$E44xF_r_bYO9HOH-lw-VkWepvoS6z9dxDWthhfbpT9M	master
49	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$n7_pif4S0hNHmw6iRBbW8iOHiFYTB60HnOnp4zhPUiM	$4EiubgnrkRAh09BKQLVXOeE9xGDhNpI_objrHMKclmA	master
50	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$a185DaoMSzelXmfPlkcYOe3H3zITI_nFoVFWjnPmTu8	$9-LSz3ddCTGWUa1IWqJRNNSh2mJrY7YVMY_uo340Sek	master
51	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$Y6Vh2Kkasecp6HyMWxXbvX7gYSqrx6mIGOOROWKR1Hs	$n7_pif4S0hNHmw6iRBbW8iOHiFYTB60HnOnp4zhPUiM	master
52	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$tvfSz5Kqzjfh39pYs3yfctIZoJQ09aOzDx4YZvZDlyc	$a185DaoMSzelXmfPlkcYOe3H3zITI_nFoVFWjnPmTu8	master
53	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$84NzkDN2QGVP9qS7o_z1qOhaHe5-fSbz4Vs2SiNDPo0	$Y6Vh2Kkasecp6HyMWxXbvX7gYSqrx6mIGOOROWKR1Hs	master
54	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$oU5B1qtEraaFCsivi4-r4WT9WGSSBIzW-i7EDPYS-eE	$84NzkDN2QGVP9qS7o_z1qOhaHe5-fSbz4Vs2SiNDPo0	master
55	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$DhWWh8GrURTFDa120InvAq5u-MKwyslHHOkRAcsUhaQ	$tvfSz5Kqzjfh39pYs3yfctIZoJQ09aOzDx4YZvZDlyc	master
57	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$HvHWZQ09kf-ICUV-Ar9JELFLWq2tJUi2ull2GBzbx9U	$DhWWh8GrURTFDa120InvAq5u-MKwyslHHOkRAcsUhaQ	master
56	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$toF4I3EB1pERgvaXBIbhBugPExKQ2bOI0J6aOngeVI4	$oU5B1qtEraaFCsivi4-r4WT9WGSSBIzW-i7EDPYS-eE	master
59	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$4ODGclJajZc3SV1KXAMLeoAZrYyBdfzBaT-uorLgyJ8	$toF4I3EB1pERgvaXBIbhBugPExKQ2bOI0J6aOngeVI4	master
58	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$81XepwsM4YptvtHgl3P5SaUSvkP94S2d7apqzJ78aFk	$HvHWZQ09kf-ICUV-Ar9JELFLWq2tJUi2ull2GBzbx9U	master
62	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$DsB5975yzOpruMKKVBUYRHB3MSljJYHh3p7763sNf2I	$dL0sqD6DHzPvOsuGJe1kcseFEXgtsK3Q59XyD3PJVk4	master
60	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$dL0sqD6DHzPvOsuGJe1kcseFEXgtsK3Q59XyD3PJVk4	$81XepwsM4YptvtHgl3P5SaUSvkP94S2d7apqzJ78aFk	master
61	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$Pk6fFbdC0REz3T43EROb2OhYqN4o1ptnYGXXeyMDxkE	$4ODGclJajZc3SV1KXAMLeoAZrYyBdfzBaT-uorLgyJ8	master
63	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$7Op41p6mCUbcp5TuaBcCF4mMRwPYz6lWW7a943BDG8o	$Pk6fFbdC0REz3T43EROb2OhYqN4o1ptnYGXXeyMDxkE	master
67	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$V4DFlazGXeBPWV65AAUJ4t5Qg3tYPqs8hY5TxXXOAg8	$7Op41p6mCUbcp5TuaBcCF4mMRwPYz6lWW7a943BDG8o	master
66	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$4VQxBaDA6dKjPvqNVj95IwQXv3QL3a-bXdpp4EyG9yo	$DsB5975yzOpruMKKVBUYRHB3MSljJYHh3p7763sNf2I	master
68	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$XLYrVIK-R-MtOR1YnQaG3APBProvOP79zhKQSr95HqE	$4VQxBaDA6dKjPvqNVj95IwQXv3QL3a-bXdpp4EyG9yo	master
69	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$bm6jSsPXymAqmwjgIzaCnnJ6c2n_z2s5EzuLfrNVKvE	$V4DFlazGXeBPWV65AAUJ4t5Qg3tYPqs8hY5TxXXOAg8	master
70	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$qjaNmlKX4IG53qDAgTwuNoxohPKncklE70COvnTRmxc	$XLYrVIK-R-MtOR1YnQaG3APBProvOP79zhKQSr95HqE	master
71	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$LgX6qWXYlaiVRDlpKJmG6b1DcgpCsOwZlJZ0c9LjXmw	$bm6jSsPXymAqmwjgIzaCnnJ6c2n_z2s5EzuLfrNVKvE	master
73	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$eKKl-y9GISjb7jjkVd_Vn_qgDxbMFvFS-A5GytvRyVA	$qjaNmlKX4IG53qDAgTwuNoxohPKncklE70COvnTRmxc	master
72	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$eMJm6wCYpxKfgz2KOhEAL5wkidGtV_nWPvoVzahFQ_w	$LgX6qWXYlaiVRDlpKJmG6b1DcgpCsOwZlJZ0c9LjXmw	master
75	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$iT2ZJrZtDk-8_lxymECQMqYbECP_dXcTXNOuVCnSanc	$eKKl-y9GISjb7jjkVd_Vn_qgDxbMFvFS-A5GytvRyVA	master
74	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$V3iPyXBY5Rdjfq2cwuP29HNjpy0XdkW-xZbfClfMyX8	$eMJm6wCYpxKfgz2KOhEAL5wkidGtV_nWPvoVzahFQ_w	master
76	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$1TrVYjSyP6cjgknVY8uql_PO0hzYnXoh_Q5UcPnCrZo	$iT2ZJrZtDk-8_lxymECQMqYbECP_dXcTXNOuVCnSanc	master
77	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$7MV6cVe8OZRcCQoQ--G1tiE1hrAYBgcNJdkoRnK9cCQ	$V3iPyXBY5Rdjfq2cwuP29HNjpy0XdkW-xZbfClfMyX8	master
79	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$7kJDwW-2jhnIS4etX9TjGAX6-TcSeK1X5c2IXBKIYvg	$7MV6cVe8OZRcCQoQ--G1tiE1hrAYBgcNJdkoRnK9cCQ	master
78	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$aqyW9vUrxdObe9RJw6v5sRs4rGwiu8gB_G28XjM_ZIY	$1TrVYjSyP6cjgknVY8uql_PO0hzYnXoh_Q5UcPnCrZo	master
80	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$CZrqEW9z_cBAHrxuxxcYegi7fg1tf20O1jmxL17mC9Y	$7kJDwW-2jhnIS4etX9TjGAX6-TcSeK1X5c2IXBKIYvg	master
81	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$5AKU6xT-ue4wUP91q_e8RberEbyIcJxjftWsBfd5390	$aqyW9vUrxdObe9RJw6v5sRs4rGwiu8gB_G28XjM_ZIY	master
82	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$BzGhHpwzF69iD1LpgSzUCmR1BGptwZ_OUHk4PeOzJP0	$CZrqEW9z_cBAHrxuxxcYegi7fg1tf20O1jmxL17mC9Y	master
83	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$d8H-cks_WJ2pUVeQBHNQjxwMxQQ0dsVns9Egvk6ZZSY	$5AKU6xT-ue4wUP91q_e8RberEbyIcJxjftWsBfd5390	master
84	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$dML7rSy7hzRtf__Ngjhbwue3LB55pJlChEmQb7TTrUA	$d8H-cks_WJ2pUVeQBHNQjxwMxQQ0dsVns9Egvk6ZZSY	master
85	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$RwIZxuK_hLp0XkjhXtRp1uSYNLClkMGppfpR_voC8MU	$BzGhHpwzF69iD1LpgSzUCmR1BGptwZ_OUHk4PeOzJP0	master
86	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$PUa692WLwxL3-4B_FJ5fKAezQeDkQvk0Mt4aK6y6bKU	$RwIZxuK_hLp0XkjhXtRp1uSYNLClkMGppfpR_voC8MU	master
87	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$OP5HTw1PQzzmVnL4rM6W9vo_5awgP51OChBdnKJUw3k	$dML7rSy7hzRtf__Ngjhbwue3LB55pJlChEmQb7TTrUA	master
88	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$Gq6AiRbih1LLH4wkJuCyznmTxYjtNTs_3rlzFDU1SLk	$PUa692WLwxL3-4B_FJ5fKAezQeDkQvk0Mt4aK6y6bKU	master
89	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$21WoLTVJrJ52kKvP6FJpyDr7jDrBBFwJ8jtLVe5BxoE	$OP5HTw1PQzzmVnL4rM6W9vo_5awgP51OChBdnKJUw3k	master
90	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$De7JBlVgW8VX8ZxAOpb5VsKlSpBrrkExJPDpY6Jb2eQ	$Gq6AiRbih1LLH4wkJuCyznmTxYjtNTs_3rlzFDU1SLk	master
91	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$zpGESsEospA4z5J4JRYQhBomXyVjLg0lwLJpTY6TrFw	$21WoLTVJrJ52kKvP6FJpyDr7jDrBBFwJ8jtLVe5BxoE	master
92	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$z5XMi95yi1w0KN3jNQ-MskRCNLMJBwr2DZ949BQkcOA	$De7JBlVgW8VX8ZxAOpb5VsKlSpBrrkExJPDpY6Jb2eQ	master
93	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$ZCrE8n-g5lxd9QFIdUh_5iwteqPL5nimDqoJjpvZbFw	$zpGESsEospA4z5J4JRYQhBomXyVjLg0lwLJpTY6TrFw	master
94	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$P-cjsZvHLir5EVtcPh_t3mCvn8_Lc4bfG_lOprYS1U4	$z5XMi95yi1w0KN3jNQ-MskRCNLMJBwr2DZ949BQkcOA	master
95	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$utAs_ygC9AwIZbOfZwzq7nGH_lAonZbFfYMq25Sbnes	$ZCrE8n-g5lxd9QFIdUh_5iwteqPL5nimDqoJjpvZbFw	master
96	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$bEJ_JyOf1Ygj-Cm0huzAPtvmILPNN--9n3pzgagwWmI	$P-cjsZvHLir5EVtcPh_t3mCvn8_Lc4bfG_lOprYS1U4	master
97	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$Q73eZCSY4oV7fYHAJT-iw3ItAuHA58eqRH82uGwH44w	$utAs_ygC9AwIZbOfZwzq7nGH_lAonZbFfYMq25Sbnes	master
98	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$PmKTWj14_fU64-YCl_JArQdeIIgT1glyUAP8DQBs0uI	$bEJ_JyOf1Ygj-Cm0huzAPtvmILPNN--9n3pzgagwWmI	master
99	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$fyV6TMmTq9wDrYp9EN2Aw5D0DmsfhzoTxlQ1m0pSZAE	$Q73eZCSY4oV7fYHAJT-iw3ItAuHA58eqRH82uGwH44w	master
100	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$p-JIkw6J2K6wxu8JkmJXlKjanI9p7AuZUDneiYknsFc	$fyV6TMmTq9wDrYp9EN2Aw5D0DmsfhzoTxlQ1m0pSZAE	master
101	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$4W6pWQc6IgcxfGV0EHiFYFQtkY1qCo6APGtlCAr60LU	$PmKTWj14_fU64-YCl_JArQdeIIgT1glyUAP8DQBs0uI	master
102	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$whRcD0OyHSdXs5wCZ-Gol9e_KUH--BOTyu1FkYhhQ8E	$p-JIkw6J2K6wxu8JkmJXlKjanI9p7AuZUDneiYknsFc	master
103	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$yFVhlEG5pdVcYKH9LhbJ96IK79GygR0jCiB4NU7HPYM	$4W6pWQc6IgcxfGV0EHiFYFQtkY1qCo6APGtlCAr60LU	master
104	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$Dp5Q-o1kO6cZxdLOQVR1Ba5ymgYTF0qKir8rd5XVyd8	$whRcD0OyHSdXs5wCZ-Gol9e_KUH--BOTyu1FkYhhQ8E	master
105	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$sZ_xzte7aB_ofIWratL2US43tIv1Stl0DOtQuVuXIcE	$yFVhlEG5pdVcYKH9LhbJ96IK79GygR0jCiB4NU7HPYM	master
106	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$I9BAqY-jJivf3BugaTzIjWwCq4Vsthp2Srzia5sBtvs	$Dp5Q-o1kO6cZxdLOQVR1Ba5ymgYTF0qKir8rd5XVyd8	master
109	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$RFfsT0l03gEKL7fV86ElHnmtu7jGdj4KRpuuCyQKLh0	$I9BAqY-jJivf3BugaTzIjWwCq4Vsthp2Srzia5sBtvs	master
110	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$dcq0w5YsiXgEtTRJPYWW2GDKRM3k4SjC-ab3rJOSh7Q	$sCYM3URaqv6flwwrn8lHRJpDn83Sz8RuF7bYxgb0i8g	master
112	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$rT4YjNqnp8qiyQZIGMLIgPcDOrWgpTUHj-uEqSq5eFA	$DaEV2INCT0t6y3M79Y5P4M-s3jrmnFbl0thmqnRCeWM	master
107	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$pRbv28FK8ljHETiS081PP5TzzhsKXQ6FELLbCQtcHy4	$sZ_xzte7aB_ofIWratL2US43tIv1Stl0DOtQuVuXIcE	master
108	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$sCYM3URaqv6flwwrn8lHRJpDn83Sz8RuF7bYxgb0i8g	$pRbv28FK8ljHETiS081PP5TzzhsKXQ6FELLbCQtcHy4	master
111	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$DaEV2INCT0t6y3M79Y5P4M-s3jrmnFbl0thmqnRCeWM	$RFfsT0l03gEKL7fV86ElHnmtu7jGdj4KRpuuCyQKLh0	master
113	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$74eOdDCOl9SWRA3dJaPSiB4EC_sX__ThIgxmrPtmbZE	$dcq0w5YsiXgEtTRJPYWW2GDKRM3k4SjC-ab3rJOSh7Q	master
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
$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost	m.room.power_levels		\N
$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost	m.room.power_levels		\N
$e59i0svd92559O6Ylspucl1xefsa8dpbbZe0ZE0mUp4	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@mm_admin:localhost	join
$6Lgivd2MHjS9x-3BOttMrBNfnyKpvrsbwS8TFPVdz1c	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@mm_admin:localhost	join
$4Wo5EetfrJ0oD7aWVI6CvS_-ZUM3lsyzkFZeQElMcmI	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@user1.matrix:localhost	join
$eOdfuP6TezgWF5799z0-muVXLh1k8LvHE2Wfob0cC3A	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@user1.matrix:localhost	join
$SCwfg4xWBzxHVcFLtW1DbcDU4LMVkfgjYJG-qdUypcM	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.create		\N
$RB7fKTVNYlqIOEPsSHLuZd4VtyQWzJBKjadsEKrzboc	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.member	@user1.matrix:localhost	join
$qx1E7MsFRdI9CbDeDYHg3A8XeN6MXU2rkBGCoxPB5mw	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.canonical_alias		\N
$MWD--uqyNXbmKDBMJob9sDY5AM4riTmkAwwz36FIaPk	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.history_visibility		\N
$1kUMRxz6Q6tB2pRvD-yuOBQbj2dooMjTGymKWTyL_I0	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.join_rules		\N
$VypxR6iKVehL3VR2C035y9gijIu-KXtOmJ85mKX9XLI	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.power_levels		\N
$a1xA663y2WchzA_Q5jmTKVlInC_HDgPTK8C2g37ysdk	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.name		\N
$wdUPyT-0i7vmiiPz1WNunqvPAIWSfFtnwV1OizPIkvg	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.member	@matterbot:localhost	join
$al7p9tH0ZoT5Yu3HsYz1r2ak-9HkXf2coQ7KKeBerUk	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.member	@mm_admin:localhost	invite
$74eOdDCOl9SWRA3dJaPSiB4EC_sX__ThIgxmrPtmbZE	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	join
$rT4YjNqnp8qiyQZIGMLIgPcDOrWgpTUHj-uEqSq5eFA	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	join
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
X	17	
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
14	@user1.matrix:localhost	HzGuyT7hmhSWULANnzFTwJRYvwSFlIweFb53q28Mvt8
15	@user1.matrix:localhost	Oe5GNOlmI6SRP2t1CfUx+N4Pgcg1a7Jjb2vgIgyhbLw
16	@user1.matrix:localhost	JAVZUYJBSA
17	@mm_user1.mm:localhost	IMKODBTCSL
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
@user1.matrix:localhost	HzGuyT7hmhSWULANnzFTwJRYvwSFlIweFb53q28Mvt8	master signing key	\N	\N	\N	t
@user1.matrix:localhost	Oe5GNOlmI6SRP2t1CfUx+N4Pgcg1a7Jjb2vgIgyhbLw	self_signing signing key	\N	\N	\N	t
@user1.matrix:localhost	83s/13FiyFWV0titpBQH7EYPIFUAqJkz20Fkhlc27V4	user_signing signing key	\N	\N	\N	t
@mm_user1.mm:localhost	IMKODBTCSL	\N	\N	\N	\N	f
@user1.matrix:localhost	JAVZUYJBSA	localhost:8080: Chrome på macOS	1675882018710	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36	f
\.


--
-- Data for Name: e2e_cross_signing_keys; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.e2e_cross_signing_keys (user_id, keytype, keydata, stream_id) FROM stdin;
@admin:localhost	master	{"user_id":"@admin:localhost","usage":["master"],"keys":{"ed25519:9Favlbyv41Oymu7psEi73Z78IgREtdjB3x7X333+GCc":"9Favlbyv41Oymu7psEi73Z78IgREtdjB3x7X333+GCc"},"signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"+AIaMRp47RqQVG8cjzPonIXJE9Lap0DgATzEldFKzZ0bBg/RvUCQWUN1yi9JadL4AjLhsioItNJorDdLK5ZtCw"}}}	2
@admin:localhost	self_signing	{"user_id":"@admin:localhost","usage":["self_signing"],"keys":{"ed25519:SKb4WrefUUeHJMqsPB41qypT5nbR4gIz7rM2zpp77QQ":"SKb4WrefUUeHJMqsPB41qypT5nbR4gIz7rM2zpp77QQ"},"signatures":{"@admin:localhost":{"ed25519:9Favlbyv41Oymu7psEi73Z78IgREtdjB3x7X333+GCc":"CPfwqSgCqjlRddGeMfp+xXef/aNL89q7MUxFiW88yqY8NMEgcqmAl5kALmo7wbiAbgeehw5qw4XkOdVSryg1Bw"}}}	3
@admin:localhost	user_signing	{"user_id":"@admin:localhost","usage":["user_signing"],"keys":{"ed25519:vmvfo59xzOjKmX7eTKaUauAKaUMTqr5oZimh0Tsm5Ww":"vmvfo59xzOjKmX7eTKaUauAKaUMTqr5oZimh0Tsm5Ww"},"signatures":{"@admin:localhost":{"ed25519:9Favlbyv41Oymu7psEi73Z78IgREtdjB3x7X333+GCc":"eN8GO27s5/Q1LH17jHzTqSM6Cz8gHIJ+OxpeTswKoaOckpG0pxP2ZPQd9eknBiBTsCPMB3RKOPjwgGUjCsBLDQ"}}}	4
@user1.matrix:localhost	master	{"user_id":"@user1.matrix:localhost","usage":["master"],"keys":{"ed25519:HzGuyT7hmhSWULANnzFTwJRYvwSFlIweFb53q28Mvt8":"HzGuyT7hmhSWULANnzFTwJRYvwSFlIweFb53q28Mvt8"},"signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"VYhG9TW9ihh2aytP+2N8IYImv/pBIS2niLDNSizyhLH3LitasQVQgQCHFqGjNexB7XHi/sbiwVRW1tZCbXPaBw"}}}	5
@user1.matrix:localhost	self_signing	{"user_id":"@user1.matrix:localhost","usage":["self_signing"],"keys":{"ed25519:Oe5GNOlmI6SRP2t1CfUx+N4Pgcg1a7Jjb2vgIgyhbLw":"Oe5GNOlmI6SRP2t1CfUx+N4Pgcg1a7Jjb2vgIgyhbLw"},"signatures":{"@user1.matrix:localhost":{"ed25519:HzGuyT7hmhSWULANnzFTwJRYvwSFlIweFb53q28Mvt8":"Nsf5RC89AZ698PebeBmVGcT4h2U5G5sAT8AVfUslnPwDsLwgpjttWCLguwfnWmvTqtR7DLy9ZdP1HxI9PKByCQ"}}}	6
@user1.matrix:localhost	user_signing	{"user_id":"@user1.matrix:localhost","usage":["user_signing"],"keys":{"ed25519:83s/13FiyFWV0titpBQH7EYPIFUAqJkz20Fkhlc27V4":"83s/13FiyFWV0titpBQH7EYPIFUAqJkz20Fkhlc27V4"},"signatures":{"@user1.matrix:localhost":{"ed25519:HzGuyT7hmhSWULANnzFTwJRYvwSFlIweFb53q28Mvt8":"DWQLoOK0YiswP4Cm5hGW5tzNm4q1xkTQf6rjXESzw4eOl02nGN2Yuf3SNwm4SG/88/y/ES1IDpEzoii/fCGgCQ"}}}	7
\.


--
-- Data for Name: e2e_cross_signing_signatures; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.e2e_cross_signing_signatures (user_id, key_id, target_user_id, target_device_id, signature) FROM stdin;
@admin:localhost	ed25519:SKb4WrefUUeHJMqsPB41qypT5nbR4gIz7rM2zpp77QQ	@admin:localhost	MCWQGRUWJV	yEpCjldTE4CeZIknGoXGRecTTsTWxkpftTyHyq7xuT3EzxHz6VVd/9DDDp+jA+mHA5GqwF5ARMwxifKDpD3zCQ
@user1.matrix:localhost	ed25519:Oe5GNOlmI6SRP2t1CfUx+N4Pgcg1a7Jjb2vgIgyhbLw	@user1.matrix:localhost	JAVZUYJBSA	Sz9E1rRqHuPIFmfZVvI8PmBEi+je0JVRsv+QZuOPCSxx7BjSh7I8SAOGlmLrAqTLIyOLwTxNviUjHHIQhsHaDA
\.


--
-- Data for Name: e2e_device_keys_json; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.e2e_device_keys_json (user_id, device_id, ts_added_ms, key_json) FROM stdin;
@admin:localhost	MCWQGRUWJV	1675287440399	{"algorithms":["m.olm.v1.curve25519-aes-sha2","m.megolm.v1.aes-sha2"],"device_id":"MCWQGRUWJV","keys":{"curve25519:MCWQGRUWJV":"uOt+7lTrgFtzcreO5r+ciAg3gGNgkI+qgcn1eeN8Aic","ed25519:MCWQGRUWJV":"pvdYWTAlPhvpfQ1IYVUT6hjltGsEffXkMHXeaOk+xiM"},"signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"9iM/y75zK9C6zdOdMTksw+/EcZEUUEXMT7mW34ABGQelvhlDG1Iu6j6Qp01SGk2HKTJLkV3u6B4ABROrcyfHBQ"}},"user_id":"@admin:localhost"}
@user1.matrix:localhost	JAVZUYJBSA	1675794322671	{"algorithms":["m.olm.v1.curve25519-aes-sha2","m.megolm.v1.aes-sha2"],"device_id":"JAVZUYJBSA","keys":{"curve25519:JAVZUYJBSA":"TcDafh3ZwHQSVsikqyEJvGnRtNoQTJiupjhKac98kX0","ed25519:JAVZUYJBSA":"uR7CkudkKctXGycRGx6jSf7bZ0Nk6Jh0GgIpZv4P/qI"},"signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"wqMyrNbxxfZE0CWxQLENmIaBX7m8yenUgfct3VOK25e4PMlCUp2rVx78lM/LMt+frYxqivT3+GCyUpq4y6TFAw"}},"user_id":"@user1.matrix:localhost"}
\.


--
-- Data for Name: e2e_fallback_keys_json; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.e2e_fallback_keys_json (user_id, device_id, algorithm, key_id, key_json, used) FROM stdin;
@admin:localhost	MCWQGRUWJV	signed_curve25519	AAAADA	{"key":"e0f1/4qUPW+oF3oJmTF0NqmKxDTIJF2xrEy3P907eFE","fallback":true,"signatures":{"@admin:localhost":{"ed25519:MCWQGRUWJV":"cR4MVQO7EFSellYAf8Buz0r6s31n3KLs87V3bgoiKcE8SvBV5IXEqBVzFs+R5Cnrd5Ys8DBdzKvSyP8XQIYtAw"}}}	f
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAABg	{"key":"OxmIg46VWEx4if0hIol0arthu4H0w97jofeMavBHnmQ","fallback":true,"signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"hxz2APTfN9m0UKZZY+YikLa7gn/p51dDw6r9l9p7Fgb60Q4Ky9R/Ll1iy2QKGrAzzBbtk01lKlPmLC5KcgtWBw"}}}	f
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
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAABQ	1675794323128	{"key":"Ck7UfKQ7x/dZYtT6iuJoTn32fOxB6eSbTQq9QprdPAI","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"lLO5c6VHHplBLd3/TzjcXmyZQzaC9ebR0hKgco9vcJzEo7gGOs738Ax9jB9dgGe40d7YgpYQeMEQnhn4uejGDQ"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAABA	1675794323128	{"key":"hlRYVXYXOEYBv45ZoX4/rLbPX6/iJzhk9+rhE8Szslg","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"JHMcM6lrNVtC6p1xB56AmQBNMXWIQg5+ymEPnZQyafEG2t7CPMGPgpH/orvyS4/gdyLYVSs9XEBaKP7crtYtDg"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAAAw	1675794323128	{"key":"qccJNup/9ylRJdxSFFRc/uwfeYMwp2fHo9a8a+znjWk","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"4wF/tdKx1ECLHH8qm6de0XwMp2l/GoabwWOFC6H3ZsTn9AFv945Y/+1j9OU2s2hSaeTtQfZiUbN0Bf+CVZASBQ"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAAAg	1675794323128	{"key":"2pnuogXivkgBld7Aa13IxU+uyLR59kRDrPxPy3FSrCU","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"0djZtpXdyc8oP99UKAnp4e8ga/NQQCAtfg9EVUSlogJoJYLMQNgGS5i+eMB4YqzBJwkesUwCuhofgb5w9fkYAA"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAAAQ	1675794323128	{"key":"YTqrx3OsUE8IUC4JZ7a64jaxskuY9P1EBa2uapavJkQ","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"onWL/AVQjAKkN+qhTP85HxKJ96nm+UGyoC3R3Ahq7r7Ba0OM275udYNEokYTXm7WooCeT9S6gxn6CyYNceAwBg"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAACw	1675794323224	{"key":"9e0Ci8Ww0vKvEBxQMhAc4NK6F6UsDUzrg636H2gx2hY","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"kZShT3r/FnuXyaW1t9aFOB46lVXQyVuObvL5CxHpAJrzZdTRD93WqB4fDk72loawqejQzKwNNWG0de7x6LV4Cw"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAACg	1675794323224	{"key":"KDD0Yoz7dSmTS6lLOtnYweBDIDQNcctz98m3fmG/VFc","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"wC4NX7GyaFqUabcGn/pylXiT4AXhGrZlWPWjg0sxzfY0fO09RGfqvV+puNkqluHa25aQ2TK2r13J2yoovNATBg"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAACQ	1675794323224	{"key":"RSXRnhb8/UeF5WmmfR5bFNsQuHNrupEh/t3VQSG0tEw","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"fe0IjF30o92Ev6cfHT+/zOsZ/58AEOj76f5hO66URezipmaLrO/zeJ4U/60nPFIRf7dW3G0/zI77bZIr2M3jDw"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAACA	1675794323224	{"key":"xl5RtmGAZzdHC1EfrdBoqQNIX7AA5GAYwYlKdWGXj1A","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"Q9seb5Dn8KQbJWy8HHsKE8YSxP46nebw7/ApWw/6jYePOczzjasW+G3uXHx8tbq9YZmwTCAHaYvzRPn6z+TCBA"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAABw	1675794323224	{"key":"BfWsBjlSRPYgDj511kwKtHWl7XZ535VIZAhxzYdVvVw","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"gmBY3Cbd0OqtILkoRCHy5+2MBFypUBilW/LOKxccS+9DmrRiTwJRoAY8VdKOpVtr6Fq8KECap7yRjsslv7dYBQ"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAAEA	1675794323283	{"key":"sEUO7+ls/4kh1nY2S3KaOGLLP/60oakppasVhl5hfA8","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"EOsXdmo5UIXmQOKBpnaVCJHW0FVRvHsiBUHIIL1smXn1IMFPki+eeLWmhJlpUQovYv/6l5zNKtTIp3RhRyFBDw"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAADw	1675794323283	{"key":"96xJ2bAYlRu/Jb35kuERO6r97dDDZrdoaeTIoR7wbi4","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"FwexIASi1hFe6a3I1eAURfNJQqB4FUGCe7AZhKH7+3p+Har4q/GPaDmh4JvZY7RSx8fcNJy7WwNde48LLVzZAQ"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAADg	1675794323283	{"key":"Kegv7ghR+iQ7RmnvFn5l3gt5HMBh7LW5MHRIDKtF0HM","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"gVFuvSWT3ZwfnzbgO2tZ1zPkyM8tD5iPVI16zmVwxzI6UKUP+CsZLT+kbTjrX7jrR+frb3got54VJptDJXgUCw"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAADQ	1675794323283	{"key":"XM3J3zLYx6j/8kdbcm1ZvPhqEWBRNn3MnN6IvWRq3Ac","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"MiaMWzk+CYanMMv5gDheSX99NfvLMaEKDmS4y1Dt1GNw/YpXV0aEBoYFs9aI4NMB3tQEWFOwSmePdaxUp/fhDw"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAADA	1675794323283	{"key":"ea5Ydn0PnIpNStDX0QVJo22IpB0AK2AFlE1cJRQfpxU","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"QLhSGa419qdvrHGpkz5y3sdc/S9jSRjsMYf/H4fFf5+5qtbRpvuPR2bIETskS4vGdjemn3HrMWY0clmXrfDcCw"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAAFQ	1675794323339	{"key":"NDVD2M+82ruVrboYmpzj4y33YzDreU32UIu1IXjPcTQ","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"r7EdSfSwQLbapqs3MCnB2U+ub2CCET0fnf6Ve6QQri2cSmA1lNnTk35K0XVGFtm/U4T2xV3qI4Rt1jXntiKTDA"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAAFA	1675794323339	{"key":"7OEq3vBzC8y6FRMbOj0vnW+LJYwi4XumRxybThG3hXw","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"eEOAm+enEuSXALuNuQWCa6us6KuKt8UUUl4IjM0koKM1kama9opKEkNW6qkAaHFdxQtmUtW5y6xzvoAWm7h1AQ"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAAEw	1675794323339	{"key":"zNCTVikGUPg9mQ2Qq4zrVYonW9kyh/ejTF0EpIyxAA4","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"m6Y5aIl169NgNSZQxrOlsAtZPpd9wwOs2TXdwtH/6hxa/nhgYhG8H7ZXkS/Fqg7ZIw8NOhaIg4YFFGGTqROHAw"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAAEg	1675794323339	{"key":"hknHnIcwaa/d3DeR3Xv5PhccT2F55Byc09TOXFeE+H4","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"IXkxH0Su26RvCFjN/e/Uosv5mNuMpuoF4D7tMb+jcxEY51Z5omYhopxMWB2aPZJETGtUJqkLwnOclWfsY6YzAA"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAAEQ	1675794323339	{"key":"oCHOHBcLzZbLZueQVNTDvpR7QIP9qmjpvmvM6PgqKmw","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"8pbUYI9VOjbiQJGsA8gEohSSDAGYmcYOvh0LpmPyqchu2GCz7Z9QI4ArBwJngcv/4MdWFwik3WvT/faUWJpLCw"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAAGg	1675794323393	{"key":"buwDvuzNPVnniuDBuIQSsGr1rm+3rS0q8aNiYfdfAR8","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"hbJjctSO0nlS9B9+ev7VsFQv/C9GdKPm07iVsAcyxzWsxKhRVRpuX9SEjnf79Y5d+UIhdJ042krtYyLZ9tclCw"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAAGQ	1675794323393	{"key":"cgv4LIDAd1hWAFiEpwa9l/ZRR3ied70XKW4pv/rPg3M","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"UcFrsIVjA5aIFbu0I5dosCXDuwewDYC6c5qE6cqCETj/5yYn1zntcj+JmtnePk6VAAU4JwCF6wgQzOkg9dquAQ"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAAGA	1675794323393	{"key":"fv2A9gTe+dGi8lmT1g03hmZ/pPKi0hb96t0oTj8S+xc","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"/2DDi34u//JEdt6YR2UgJbms8cpIlh1YrLAuxxJ4Gck34/9mKo/+H5dvCs4rVXvwgWm0qJYB/S83NBJ83BgyCA"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAAFw	1675794323393	{"key":"T16Lsak28U0UohasYc4SI/KDr17W8OsPKXN5rh1QqyM","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"bkP6CXNFSgUX8xzjH+TuyAd/wK2cbkPp+Fn4kZQJiOvVeJIpKE1+q45dnLZW5WIa4gpwdEMuuo6hDkSDIBwVAw"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAAFg	1675794323393	{"key":"hU73O2YONbHO49K2jvtdKAmXl5cp+gzu4UJt24XLpBM","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"/1c7QUR+1MHn3tnX8D/yshDdtAVccfFCAbL+x7R7WZbsYEO5dkpprYmidRxlBkLhBDMswJbX/avAXjfReVVNCQ"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAAHw	1675794323449	{"key":"7z4Scl85YfA7jHvkuwI81KOQsrVfE/Hld6q54ookBDU","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"FZo2uLeTuGHxCCuizmU+FZRVlxBEKNvpNftlXklVAH1rHpeCYt6O0gVPIaTc0O+IL6SFK6N7ge2HJ+t+0lzBBg"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAAHg	1675794323449	{"key":"r2A6J4VuVsmDng/EJ/O2fp/q8MKeYsNtNih2dqXTjgI","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"zck8zKcas1n0zoSPvLaJ38E8KAPi06+i3nUiAc6wf+1D6F0C5yDj7dyrTLmqBs9DU4Kof6LWicbb+9y1XyZTBQ"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAAHQ	1675794323449	{"key":"+LeNiAO7hVHctIA49pZ+8bfVnFStSC/IiBPquimswXI","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"oYWzCwhGPGFid07BVaG9mjiZ4xQCNNtgFrto8ti2Bf3Lz/41irJncF6BxX/1AmZtlF+swU4l74VdzWeh7REKCA"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAAHA	1675794323449	{"key":"U6Y72gq/af3A7MGZImKrCP1+MQb6J1ese7DR9lfq0zo","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"+0CmCSvSBKeluq6YExJjdTkl2kvVXM2R6blRvTuTnw219vxp88lRVOWYdHk5bMS/XfdTVzpdjIxqkXiPx8xKBA"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAAGw	1675794323449	{"key":"tL+enF4pPsNVy/zaVi54KQeCeZy644gfDlx9FGfTC10","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"jR5tLKrnNn0ZbVjj2F536+YmmVvJXNAffX50QrX3WzVw0ofMOGo/hg+6kVKgKSHuv4zP5o2SbQ3DPeepfJZ5AQ"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAAJA	1675794323507	{"key":"UTzl2yCZTk9NdTmXbJu0TbO+fAJEPRYBpijneov6Dwc","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"4hYgGX2upI8ZNvEC6PeMFFxal6KUc1NwWsZ6JSOQqmHhlSnP8lICYD4ATvKo2O5X+0RcXx+BNn7qPUdjoOD2AQ"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAAIw	1675794323507	{"key":"PLmURfV0LL1qpYywgq9doHgKIe1B4lA4GF5R+VWMfWE","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"hEkUpm9ozeKOapbt28gO8taRzXyMozf3oAeoi3Wo5U5WiDa6uOQzh1mY3RKrw7YPmGIWy3U2xFmio/fQJQSzDw"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAAIg	1675794323507	{"key":"jDN81xgwatek3q213TGDWBO+5CeEG4xslHqTsqsX4Vw","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"2DP3kfhAOBapGvL1BG3Jmfx4M8F8uTaB3Cmsxs/8LuaJ+HzeM5b5amjINKG8wwhjDuNXmTzHd5DEngQJzIeBAw"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAAIQ	1675794323507	{"key":"hhWczftLyKcou/ucYg259mG2dUIsa0ny2DBNocztEx0","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"mt6VmE57pNFoRf/rgD//70lTxZcZAXDzOd/ROKO/GWJwmoJGhacAnYGIKgkWvmsmJV/vbSeozptRoGfOR5G2Bw"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAAIA	1675794323507	{"key":"UXHQ9a6TlEaspLL4FSbBtsDrBf3ie1t9FpZMk5wAhjg","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"VsY3c8PcslTPctWDCwHj/lki8NjrssM42pOjtKsckD30wAQ2227L/n+nm02m6sDxQ1OkgXi29jJde3ciiArfBA"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAAKQ	1675794323566	{"key":"pvUYPTmQKI5iWG5sx4BlqTIQ77Wi7D9UVxXfQjy7nG8","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"LpYiOHU2U/v5Lc72uF5iaqbPD25m35NfHvkClXoupw83sJv0gKkQC9/cqgS6n93oSkfDQVSXXhDz1Eah9lRABw"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAAKA	1675794323566	{"key":"R9aJlTIaGFYpPZirGjA8RvxhdbAEm8IPUy0AhRahKi0","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"YUJswROCWz4LKuU0wn2SbvRpjj3INIt0nL/0CXnB9oLVXGFxg4nphf0Cd/1BAKl1G7Owcnuf5at1/Lc1EOnSDQ"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAAJw	1675794323566	{"key":"xS441TK6mLamsy60nklMeAEX44aZ4v65GRUgUyIA7UM","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"T5ctMv2J80tvkh78wZSXC18IWELV/nDLIZPwfxC+Njk4hDVEi/No2dHguW+i2CnBJp4RbApcxdBIOYv/p+vvDg"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAAJg	1675794323566	{"key":"d3L91VCpU8IbFcglUcRAlSPU5CzUcZ2SZfnmZ6Io1Sc","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"focdFSJVrpZO4g1GUYFItT0MWVgL313IKW+yY0sH2+NDNQ220xt5PG0YBnr0bqeD12QCCMzXX5Llz4A4BTNoCw"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAAJQ	1675794323566	{"key":"Yt55yBDVtEn9e/3cmgL5sVyljFRmk5AzaQ5Qca/M8i8","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"o2f07VhVTAJeODBNZHqIWlmPdJpCiuF4s0HsAMF1oTBLlYCGI8pw4qv5uTf9wxDuGK/spEkA82L53Szew3Z/Ag"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAALg	1675794323649	{"key":"OiY8O/YOiDzrZrH+QstVqEr3bUE4FxH08pF1O4aUelg","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"fzslfjS2TpDvXMTQhFeYpHwpsGKReUeHrgr+yqklCe4dt2L1c9SvX+5ziJDeZqOdtTBaRNEaZBWq9E4/3eAvBA"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAALQ	1675794323649	{"key":"vvyyduxj8hH+1uALRE0t4OMS802q0gAoskNg/mpNgBk","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"AU20/v8xNtAgSHZEL4+PWqEHDo/NJdNDx3tbOo/CHtrVAGSlR7FZ8BL7MKbOF+F1LCc3PNod9tJ64NbHOIb9Dw"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAALA	1675794323649	{"key":"5N3NpJ3kUZgGDVwaZ6xfra/Ytf9vDFY8PzuiJGaI7wM","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"LcfqUO1Xpar+lw05V55h82PbijY8AE9zeZy/Bs3zmNMyC3vB0Vr5HgqQYIDUvkS8S3MTMRVVoc11oRxajhT7BA"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAAKw	1675794323649	{"key":"Xub85WKVzGU+vnibyu0RmVdW+DdHz0vKAUERNfMJ3Rc","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"grUvavRDhteCiL9Nl3/nuKIVXuK5RveenHwefY6Sy+IpJ8XQMgpM0XgBJvZK4pbrblILqJvKt9/fqP/DuiHqDA"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAAKg	1675794323649	{"key":"OBG84TFC/kIaCMYTYqHhNGw+42JdL+ZMjAq0IYBE13c","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"QxRlfRqGOW2BkaAO13/fFoEjR+ZAgwkyQZeOnKVcgkO1jLeejzrXvk39nrK5156yvgvPIZSIA4Wse7u88UDdAA"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAAMw	1675794323794	{"key":"aeqIIUm5LAnxxXu1aXJsJ4wUdmgw1CackdeF45oeRwI","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"nVEvItEs2Qu9DgUyF1goQiTV5A4NzZIoIluw13x2q42ak+kv4J5qFjO7PRWFwHUlZeKILZgEboCQlKII5poaAQ"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAAMg	1675794323794	{"key":"YKTvxDrm+qLkH8In86HhBCLg4xEejKUs7Z9xNdhSFF4","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"2OBzubuypxHdMSYv+BWcuapx/O2r8bwYDC/UyyCzdfoWAdunP4xwhJnjJhHK6ZEUDknDQ82u7e6pZRAaU8UhCw"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAAMQ	1675794323794	{"key":"aKqcOHHyS6m9U0L/1lU8377qOskYRnQogR5mdZvHbBk","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"2O0jB5k3gfqqSydJY70M1qQxC46blhjWDhja5G0CWpj7+/52EC312yJHfM4hL1VzJvfRhCnNTNv2Ko6AuFUVAw"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAAMA	1675794323794	{"key":"5y+SS12sN/fE6AB+Kw2diMe+lgUURgmYH29fM8+tlQ4","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"1JsEtTnMMK00b28rz8izVtFDfvmlxXTuwGSBK7CH4yhnsDF/lu6YPeeFyZ4Wt0aN69RSb1//NTvv95kg14MTAQ"}}}
@user1.matrix:localhost	JAVZUYJBSA	signed_curve25519	AAAALw	1675794323794	{"key":"7oZv1NlDfbPAZWVdT+hqgdetoCoXmvn2B6xpls5Wzgk","signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"VrX8ww5E6FTdfus31jHGkCO3V73U+Z8kxN34DGL8vfiExZdSVZWuuCtYaq3xU+j/oElpaq7lQTwDnyEHqFvvBQ"}}}
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
$4Wo5EetfrJ0oD7aWVI6CvS_-ZUM3lsyzkFZeQElMcmI	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost
$4Wo5EetfrJ0oD7aWVI6CvS_-ZUM3lsyzkFZeQElMcmI	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$4Wo5EetfrJ0oD7aWVI6CvS_-ZUM3lsyzkFZeQElMcmI	$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	!YmJPedFXUiFFGzTnFq:localhost
$eOdfuP6TezgWF5799z0-muVXLh1k8LvHE2Wfob0cC3A	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$eOdfuP6TezgWF5799z0-muVXLh1k8LvHE2Wfob0cC3A	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$eOdfuP6TezgWF5799z0-muVXLh1k8LvHE2Wfob0cC3A	$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	!DaecDLDoTLOuqPWadN:localhost
$RB7fKTVNYlqIOEPsSHLuZd4VtyQWzJBKjadsEKrzboc	$SCwfg4xWBzxHVcFLtW1DbcDU4LMVkfgjYJG-qdUypcM	!ZAIhwwJJQkZbVCWAWl:localhost
$VypxR6iKVehL3VR2C035y9gijIu-KXtOmJ85mKX9XLI	$RB7fKTVNYlqIOEPsSHLuZd4VtyQWzJBKjadsEKrzboc	!ZAIhwwJJQkZbVCWAWl:localhost
$VypxR6iKVehL3VR2C035y9gijIu-KXtOmJ85mKX9XLI	$SCwfg4xWBzxHVcFLtW1DbcDU4LMVkfgjYJG-qdUypcM	!ZAIhwwJJQkZbVCWAWl:localhost
$qx1E7MsFRdI9CbDeDYHg3A8XeN6MXU2rkBGCoxPB5mw	$RB7fKTVNYlqIOEPsSHLuZd4VtyQWzJBKjadsEKrzboc	!ZAIhwwJJQkZbVCWAWl:localhost
$qx1E7MsFRdI9CbDeDYHg3A8XeN6MXU2rkBGCoxPB5mw	$SCwfg4xWBzxHVcFLtW1DbcDU4LMVkfgjYJG-qdUypcM	!ZAIhwwJJQkZbVCWAWl:localhost
$qx1E7MsFRdI9CbDeDYHg3A8XeN6MXU2rkBGCoxPB5mw	$VypxR6iKVehL3VR2C035y9gijIu-KXtOmJ85mKX9XLI	!ZAIhwwJJQkZbVCWAWl:localhost
$1kUMRxz6Q6tB2pRvD-yuOBQbj2dooMjTGymKWTyL_I0	$RB7fKTVNYlqIOEPsSHLuZd4VtyQWzJBKjadsEKrzboc	!ZAIhwwJJQkZbVCWAWl:localhost
$1kUMRxz6Q6tB2pRvD-yuOBQbj2dooMjTGymKWTyL_I0	$SCwfg4xWBzxHVcFLtW1DbcDU4LMVkfgjYJG-qdUypcM	!ZAIhwwJJQkZbVCWAWl:localhost
$1kUMRxz6Q6tB2pRvD-yuOBQbj2dooMjTGymKWTyL_I0	$VypxR6iKVehL3VR2C035y9gijIu-KXtOmJ85mKX9XLI	!ZAIhwwJJQkZbVCWAWl:localhost
$MWD--uqyNXbmKDBMJob9sDY5AM4riTmkAwwz36FIaPk	$RB7fKTVNYlqIOEPsSHLuZd4VtyQWzJBKjadsEKrzboc	!ZAIhwwJJQkZbVCWAWl:localhost
$MWD--uqyNXbmKDBMJob9sDY5AM4riTmkAwwz36FIaPk	$SCwfg4xWBzxHVcFLtW1DbcDU4LMVkfgjYJG-qdUypcM	!ZAIhwwJJQkZbVCWAWl:localhost
$MWD--uqyNXbmKDBMJob9sDY5AM4riTmkAwwz36FIaPk	$VypxR6iKVehL3VR2C035y9gijIu-KXtOmJ85mKX9XLI	!ZAIhwwJJQkZbVCWAWl:localhost
$a1xA663y2WchzA_Q5jmTKVlInC_HDgPTK8C2g37ysdk	$RB7fKTVNYlqIOEPsSHLuZd4VtyQWzJBKjadsEKrzboc	!ZAIhwwJJQkZbVCWAWl:localhost
$a1xA663y2WchzA_Q5jmTKVlInC_HDgPTK8C2g37ysdk	$SCwfg4xWBzxHVcFLtW1DbcDU4LMVkfgjYJG-qdUypcM	!ZAIhwwJJQkZbVCWAWl:localhost
$a1xA663y2WchzA_Q5jmTKVlInC_HDgPTK8C2g37ysdk	$VypxR6iKVehL3VR2C035y9gijIu-KXtOmJ85mKX9XLI	!ZAIhwwJJQkZbVCWAWl:localhost
$wdUPyT-0i7vmiiPz1WNunqvPAIWSfFtnwV1OizPIkvg	$SCwfg4xWBzxHVcFLtW1DbcDU4LMVkfgjYJG-qdUypcM	!ZAIhwwJJQkZbVCWAWl:localhost
$wdUPyT-0i7vmiiPz1WNunqvPAIWSfFtnwV1OizPIkvg	$VypxR6iKVehL3VR2C035y9gijIu-KXtOmJ85mKX9XLI	!ZAIhwwJJQkZbVCWAWl:localhost
$wdUPyT-0i7vmiiPz1WNunqvPAIWSfFtnwV1OizPIkvg	$1kUMRxz6Q6tB2pRvD-yuOBQbj2dooMjTGymKWTyL_I0	!ZAIhwwJJQkZbVCWAWl:localhost
$al7p9tH0ZoT5Yu3HsYz1r2ak-9HkXf2coQ7KKeBerUk	$VypxR6iKVehL3VR2C035y9gijIu-KXtOmJ85mKX9XLI	!ZAIhwwJJQkZbVCWAWl:localhost
$al7p9tH0ZoT5Yu3HsYz1r2ak-9HkXf2coQ7KKeBerUk	$RB7fKTVNYlqIOEPsSHLuZd4VtyQWzJBKjadsEKrzboc	!ZAIhwwJJQkZbVCWAWl:localhost
$al7p9tH0ZoT5Yu3HsYz1r2ak-9HkXf2coQ7KKeBerUk	$SCwfg4xWBzxHVcFLtW1DbcDU4LMVkfgjYJG-qdUypcM	!ZAIhwwJJQkZbVCWAWl:localhost
$al7p9tH0ZoT5Yu3HsYz1r2ak-9HkXf2coQ7KKeBerUk	$1kUMRxz6Q6tB2pRvD-yuOBQbj2dooMjTGymKWTyL_I0	!ZAIhwwJJQkZbVCWAWl:localhost
$E44xF_r_bYO9HOH-lw-VkWepvoS6z9dxDWthhfbpT9M	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$E44xF_r_bYO9HOH-lw-VkWepvoS6z9dxDWthhfbpT9M	$ykL4uD4FNcb8S_8kQpwbthwvqPKRzD_pJ3jyfA-5ywc	!YmJPedFXUiFFGzTnFq:localhost
$E44xF_r_bYO9HOH-lw-VkWepvoS6z9dxDWthhfbpT9M	$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	!YmJPedFXUiFFGzTnFq:localhost
$E44xF_r_bYO9HOH-lw-VkWepvoS6z9dxDWthhfbpT9M	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost
$PksohbU2dYCXTn5ETrl9bIqsEVAPP0Wohp--_6XwmYg	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$PksohbU2dYCXTn5ETrl9bIqsEVAPP0Wohp--_6XwmYg	$06pNLPsFn-fF2WbziopICIA6qaey-LFJhiTAHGfqJS4	!DaecDLDoTLOuqPWadN:localhost
$PksohbU2dYCXTn5ETrl9bIqsEVAPP0Wohp--_6XwmYg	$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	!DaecDLDoTLOuqPWadN:localhost
$PksohbU2dYCXTn5ETrl9bIqsEVAPP0Wohp--_6XwmYg	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$ycR02cfa_D8mViUfnzHTBMWRlLibcN2pYZDwiiQUt8I	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$ycR02cfa_D8mViUfnzHTBMWRlLibcN2pYZDwiiQUt8I	$PksohbU2dYCXTn5ETrl9bIqsEVAPP0Wohp--_6XwmYg	!DaecDLDoTLOuqPWadN:localhost
$ycR02cfa_D8mViUfnzHTBMWRlLibcN2pYZDwiiQUt8I	$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	!DaecDLDoTLOuqPWadN:localhost
$ycR02cfa_D8mViUfnzHTBMWRlLibcN2pYZDwiiQUt8I	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$4EiubgnrkRAh09BKQLVXOeE9xGDhNpI_objrHMKclmA	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$4EiubgnrkRAh09BKQLVXOeE9xGDhNpI_objrHMKclmA	$ycR02cfa_D8mViUfnzHTBMWRlLibcN2pYZDwiiQUt8I	!DaecDLDoTLOuqPWadN:localhost
$4EiubgnrkRAh09BKQLVXOeE9xGDhNpI_objrHMKclmA	$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	!DaecDLDoTLOuqPWadN:localhost
$4EiubgnrkRAh09BKQLVXOeE9xGDhNpI_objrHMKclmA	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$9-LSz3ddCTGWUa1IWqJRNNSh2mJrY7YVMY_uo340Sek	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost
$9-LSz3ddCTGWUa1IWqJRNNSh2mJrY7YVMY_uo340Sek	$E44xF_r_bYO9HOH-lw-VkWepvoS6z9dxDWthhfbpT9M	!YmJPedFXUiFFGzTnFq:localhost
$9-LSz3ddCTGWUa1IWqJRNNSh2mJrY7YVMY_uo340Sek	$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	!YmJPedFXUiFFGzTnFq:localhost
$9-LSz3ddCTGWUa1IWqJRNNSh2mJrY7YVMY_uo340Sek	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$n7_pif4S0hNHmw6iRBbW8iOHiFYTB60HnOnp4zhPUiM	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$n7_pif4S0hNHmw6iRBbW8iOHiFYTB60HnOnp4zhPUiM	$4EiubgnrkRAh09BKQLVXOeE9xGDhNpI_objrHMKclmA	!DaecDLDoTLOuqPWadN:localhost
$n7_pif4S0hNHmw6iRBbW8iOHiFYTB60HnOnp4zhPUiM	$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	!DaecDLDoTLOuqPWadN:localhost
$n7_pif4S0hNHmw6iRBbW8iOHiFYTB60HnOnp4zhPUiM	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$a185DaoMSzelXmfPlkcYOe3H3zITI_nFoVFWjnPmTu8	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost
$a185DaoMSzelXmfPlkcYOe3H3zITI_nFoVFWjnPmTu8	$9-LSz3ddCTGWUa1IWqJRNNSh2mJrY7YVMY_uo340Sek	!YmJPedFXUiFFGzTnFq:localhost
$a185DaoMSzelXmfPlkcYOe3H3zITI_nFoVFWjnPmTu8	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$Y6Vh2Kkasecp6HyMWxXbvX7gYSqrx6mIGOOROWKR1Hs	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$Y6Vh2Kkasecp6HyMWxXbvX7gYSqrx6mIGOOROWKR1Hs	$n7_pif4S0hNHmw6iRBbW8iOHiFYTB60HnOnp4zhPUiM	!DaecDLDoTLOuqPWadN:localhost
$Y6Vh2Kkasecp6HyMWxXbvX7gYSqrx6mIGOOROWKR1Hs	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$tvfSz5Kqzjfh39pYs3yfctIZoJQ09aOzDx4YZvZDlyc	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost
$tvfSz5Kqzjfh39pYs3yfctIZoJQ09aOzDx4YZvZDlyc	$a185DaoMSzelXmfPlkcYOe3H3zITI_nFoVFWjnPmTu8	!YmJPedFXUiFFGzTnFq:localhost
$tvfSz5Kqzjfh39pYs3yfctIZoJQ09aOzDx4YZvZDlyc	$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	!YmJPedFXUiFFGzTnFq:localhost
$tvfSz5Kqzjfh39pYs3yfctIZoJQ09aOzDx4YZvZDlyc	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$84NzkDN2QGVP9qS7o_z1qOhaHe5-fSbz4Vs2SiNDPo0	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$84NzkDN2QGVP9qS7o_z1qOhaHe5-fSbz4Vs2SiNDPo0	$Y6Vh2Kkasecp6HyMWxXbvX7gYSqrx6mIGOOROWKR1Hs	!DaecDLDoTLOuqPWadN:localhost
$84NzkDN2QGVP9qS7o_z1qOhaHe5-fSbz4Vs2SiNDPo0	$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	!DaecDLDoTLOuqPWadN:localhost
$84NzkDN2QGVP9qS7o_z1qOhaHe5-fSbz4Vs2SiNDPo0	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$oU5B1qtEraaFCsivi4-r4WT9WGSSBIzW-i7EDPYS-eE	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$oU5B1qtEraaFCsivi4-r4WT9WGSSBIzW-i7EDPYS-eE	$84NzkDN2QGVP9qS7o_z1qOhaHe5-fSbz4Vs2SiNDPo0	!DaecDLDoTLOuqPWadN:localhost
$oU5B1qtEraaFCsivi4-r4WT9WGSSBIzW-i7EDPYS-eE	$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	!DaecDLDoTLOuqPWadN:localhost
$oU5B1qtEraaFCsivi4-r4WT9WGSSBIzW-i7EDPYS-eE	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$HvHWZQ09kf-ICUV-Ar9JELFLWq2tJUi2ull2GBzbx9U	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost
$HvHWZQ09kf-ICUV-Ar9JELFLWq2tJUi2ull2GBzbx9U	$DhWWh8GrURTFDa120InvAq5u-MKwyslHHOkRAcsUhaQ	!YmJPedFXUiFFGzTnFq:localhost
$HvHWZQ09kf-ICUV-Ar9JELFLWq2tJUi2ull2GBzbx9U	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$81XepwsM4YptvtHgl3P5SaUSvkP94S2d7apqzJ78aFk	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost
$81XepwsM4YptvtHgl3P5SaUSvkP94S2d7apqzJ78aFk	$HvHWZQ09kf-ICUV-Ar9JELFLWq2tJUi2ull2GBzbx9U	!YmJPedFXUiFFGzTnFq:localhost
$81XepwsM4YptvtHgl3P5SaUSvkP94S2d7apqzJ78aFk	$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	!YmJPedFXUiFFGzTnFq:localhost
$81XepwsM4YptvtHgl3P5SaUSvkP94S2d7apqzJ78aFk	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$dL0sqD6DHzPvOsuGJe1kcseFEXgtsK3Q59XyD3PJVk4	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost
$dL0sqD6DHzPvOsuGJe1kcseFEXgtsK3Q59XyD3PJVk4	$81XepwsM4YptvtHgl3P5SaUSvkP94S2d7apqzJ78aFk	!YmJPedFXUiFFGzTnFq:localhost
$dL0sqD6DHzPvOsuGJe1kcseFEXgtsK3Q59XyD3PJVk4	$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	!YmJPedFXUiFFGzTnFq:localhost
$dL0sqD6DHzPvOsuGJe1kcseFEXgtsK3Q59XyD3PJVk4	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$Pk6fFbdC0REz3T43EROb2OhYqN4o1ptnYGXXeyMDxkE	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$Pk6fFbdC0REz3T43EROb2OhYqN4o1ptnYGXXeyMDxkE	$4ODGclJajZc3SV1KXAMLeoAZrYyBdfzBaT-uorLgyJ8	!DaecDLDoTLOuqPWadN:localhost
$Pk6fFbdC0REz3T43EROb2OhYqN4o1ptnYGXXeyMDxkE	$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	!DaecDLDoTLOuqPWadN:localhost
$Pk6fFbdC0REz3T43EROb2OhYqN4o1ptnYGXXeyMDxkE	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$DsB5975yzOpruMKKVBUYRHB3MSljJYHh3p7763sNf2I	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost
$DsB5975yzOpruMKKVBUYRHB3MSljJYHh3p7763sNf2I	$dL0sqD6DHzPvOsuGJe1kcseFEXgtsK3Q59XyD3PJVk4	!YmJPedFXUiFFGzTnFq:localhost
$DsB5975yzOpruMKKVBUYRHB3MSljJYHh3p7763sNf2I	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$7Op41p6mCUbcp5TuaBcCF4mMRwPYz6lWW7a943BDG8o	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$7Op41p6mCUbcp5TuaBcCF4mMRwPYz6lWW7a943BDG8o	$Pk6fFbdC0REz3T43EROb2OhYqN4o1ptnYGXXeyMDxkE	!DaecDLDoTLOuqPWadN:localhost
$7Op41p6mCUbcp5TuaBcCF4mMRwPYz6lWW7a943BDG8o	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$DhWWh8GrURTFDa120InvAq5u-MKwyslHHOkRAcsUhaQ	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost
$DhWWh8GrURTFDa120InvAq5u-MKwyslHHOkRAcsUhaQ	$tvfSz5Kqzjfh39pYs3yfctIZoJQ09aOzDx4YZvZDlyc	!YmJPedFXUiFFGzTnFq:localhost
$DhWWh8GrURTFDa120InvAq5u-MKwyslHHOkRAcsUhaQ	$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	!YmJPedFXUiFFGzTnFq:localhost
$DhWWh8GrURTFDa120InvAq5u-MKwyslHHOkRAcsUhaQ	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$toF4I3EB1pERgvaXBIbhBugPExKQ2bOI0J6aOngeVI4	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$toF4I3EB1pERgvaXBIbhBugPExKQ2bOI0J6aOngeVI4	$oU5B1qtEraaFCsivi4-r4WT9WGSSBIzW-i7EDPYS-eE	!DaecDLDoTLOuqPWadN:localhost
$toF4I3EB1pERgvaXBIbhBugPExKQ2bOI0J6aOngeVI4	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$4ODGclJajZc3SV1KXAMLeoAZrYyBdfzBaT-uorLgyJ8	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$4ODGclJajZc3SV1KXAMLeoAZrYyBdfzBaT-uorLgyJ8	$toF4I3EB1pERgvaXBIbhBugPExKQ2bOI0J6aOngeVI4	!DaecDLDoTLOuqPWadN:localhost
$4ODGclJajZc3SV1KXAMLeoAZrYyBdfzBaT-uorLgyJ8	$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	!DaecDLDoTLOuqPWadN:localhost
$4ODGclJajZc3SV1KXAMLeoAZrYyBdfzBaT-uorLgyJ8	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$V4DFlazGXeBPWV65AAUJ4t5Qg3tYPqs8hY5TxXXOAg8	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$V4DFlazGXeBPWV65AAUJ4t5Qg3tYPqs8hY5TxXXOAg8	$7Op41p6mCUbcp5TuaBcCF4mMRwPYz6lWW7a943BDG8o	!DaecDLDoTLOuqPWadN:localhost
$V4DFlazGXeBPWV65AAUJ4t5Qg3tYPqs8hY5TxXXOAg8	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$V4DFlazGXeBPWV65AAUJ4t5Qg3tYPqs8hY5TxXXOAg8	$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	!DaecDLDoTLOuqPWadN:localhost
$4VQxBaDA6dKjPvqNVj95IwQXv3QL3a-bXdpp4EyG9yo	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost
$4VQxBaDA6dKjPvqNVj95IwQXv3QL3a-bXdpp4EyG9yo	$DsB5975yzOpruMKKVBUYRHB3MSljJYHh3p7763sNf2I	!YmJPedFXUiFFGzTnFq:localhost
$4VQxBaDA6dKjPvqNVj95IwQXv3QL3a-bXdpp4EyG9yo	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$4VQxBaDA6dKjPvqNVj95IwQXv3QL3a-bXdpp4EyG9yo	$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	!YmJPedFXUiFFGzTnFq:localhost
$XLYrVIK-R-MtOR1YnQaG3APBProvOP79zhKQSr95HqE	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost
$XLYrVIK-R-MtOR1YnQaG3APBProvOP79zhKQSr95HqE	$4VQxBaDA6dKjPvqNVj95IwQXv3QL3a-bXdpp4EyG9yo	!YmJPedFXUiFFGzTnFq:localhost
$XLYrVIK-R-MtOR1YnQaG3APBProvOP79zhKQSr95HqE	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$XLYrVIK-R-MtOR1YnQaG3APBProvOP79zhKQSr95HqE	$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	!YmJPedFXUiFFGzTnFq:localhost
$bm6jSsPXymAqmwjgIzaCnnJ6c2n_z2s5EzuLfrNVKvE	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$bm6jSsPXymAqmwjgIzaCnnJ6c2n_z2s5EzuLfrNVKvE	$V4DFlazGXeBPWV65AAUJ4t5Qg3tYPqs8hY5TxXXOAg8	!DaecDLDoTLOuqPWadN:localhost
$bm6jSsPXymAqmwjgIzaCnnJ6c2n_z2s5EzuLfrNVKvE	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$bm6jSsPXymAqmwjgIzaCnnJ6c2n_z2s5EzuLfrNVKvE	$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	!DaecDLDoTLOuqPWadN:localhost
$qjaNmlKX4IG53qDAgTwuNoxohPKncklE70COvnTRmxc	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost
$qjaNmlKX4IG53qDAgTwuNoxohPKncklE70COvnTRmxc	$XLYrVIK-R-MtOR1YnQaG3APBProvOP79zhKQSr95HqE	!YmJPedFXUiFFGzTnFq:localhost
$qjaNmlKX4IG53qDAgTwuNoxohPKncklE70COvnTRmxc	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$LgX6qWXYlaiVRDlpKJmG6b1DcgpCsOwZlJZ0c9LjXmw	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$LgX6qWXYlaiVRDlpKJmG6b1DcgpCsOwZlJZ0c9LjXmw	$bm6jSsPXymAqmwjgIzaCnnJ6c2n_z2s5EzuLfrNVKvE	!DaecDLDoTLOuqPWadN:localhost
$LgX6qWXYlaiVRDlpKJmG6b1DcgpCsOwZlJZ0c9LjXmw	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$eKKl-y9GISjb7jjkVd_Vn_qgDxbMFvFS-A5GytvRyVA	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost
$eKKl-y9GISjb7jjkVd_Vn_qgDxbMFvFS-A5GytvRyVA	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$eKKl-y9GISjb7jjkVd_Vn_qgDxbMFvFS-A5GytvRyVA	$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	!YmJPedFXUiFFGzTnFq:localhost
$eKKl-y9GISjb7jjkVd_Vn_qgDxbMFvFS-A5GytvRyVA	$qjaNmlKX4IG53qDAgTwuNoxohPKncklE70COvnTRmxc	!YmJPedFXUiFFGzTnFq:localhost
$eMJm6wCYpxKfgz2KOhEAL5wkidGtV_nWPvoVzahFQ_w	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$eMJm6wCYpxKfgz2KOhEAL5wkidGtV_nWPvoVzahFQ_w	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$eMJm6wCYpxKfgz2KOhEAL5wkidGtV_nWPvoVzahFQ_w	$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	!DaecDLDoTLOuqPWadN:localhost
$eMJm6wCYpxKfgz2KOhEAL5wkidGtV_nWPvoVzahFQ_w	$LgX6qWXYlaiVRDlpKJmG6b1DcgpCsOwZlJZ0c9LjXmw	!DaecDLDoTLOuqPWadN:localhost
$V3iPyXBY5Rdjfq2cwuP29HNjpy0XdkW-xZbfClfMyX8	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$V3iPyXBY5Rdjfq2cwuP29HNjpy0XdkW-xZbfClfMyX8	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$V3iPyXBY5Rdjfq2cwuP29HNjpy0XdkW-xZbfClfMyX8	$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	!DaecDLDoTLOuqPWadN:localhost
$V3iPyXBY5Rdjfq2cwuP29HNjpy0XdkW-xZbfClfMyX8	$eMJm6wCYpxKfgz2KOhEAL5wkidGtV_nWPvoVzahFQ_w	!DaecDLDoTLOuqPWadN:localhost
$iT2ZJrZtDk-8_lxymECQMqYbECP_dXcTXNOuVCnSanc	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost
$iT2ZJrZtDk-8_lxymECQMqYbECP_dXcTXNOuVCnSanc	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$iT2ZJrZtDk-8_lxymECQMqYbECP_dXcTXNOuVCnSanc	$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	!YmJPedFXUiFFGzTnFq:localhost
$iT2ZJrZtDk-8_lxymECQMqYbECP_dXcTXNOuVCnSanc	$eKKl-y9GISjb7jjkVd_Vn_qgDxbMFvFS-A5GytvRyVA	!YmJPedFXUiFFGzTnFq:localhost
$1TrVYjSyP6cjgknVY8uql_PO0hzYnXoh_Q5UcPnCrZo	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost
$1TrVYjSyP6cjgknVY8uql_PO0hzYnXoh_Q5UcPnCrZo	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$1TrVYjSyP6cjgknVY8uql_PO0hzYnXoh_Q5UcPnCrZo	$iT2ZJrZtDk-8_lxymECQMqYbECP_dXcTXNOuVCnSanc	!YmJPedFXUiFFGzTnFq:localhost
$7MV6cVe8OZRcCQoQ--G1tiE1hrAYBgcNJdkoRnK9cCQ	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$7MV6cVe8OZRcCQoQ--G1tiE1hrAYBgcNJdkoRnK9cCQ	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$7MV6cVe8OZRcCQoQ--G1tiE1hrAYBgcNJdkoRnK9cCQ	$V3iPyXBY5Rdjfq2cwuP29HNjpy0XdkW-xZbfClfMyX8	!DaecDLDoTLOuqPWadN:localhost
$7kJDwW-2jhnIS4etX9TjGAX6-TcSeK1X5c2IXBKIYvg	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$7kJDwW-2jhnIS4etX9TjGAX6-TcSeK1X5c2IXBKIYvg	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$7kJDwW-2jhnIS4etX9TjGAX6-TcSeK1X5c2IXBKIYvg	$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	!DaecDLDoTLOuqPWadN:localhost
$7kJDwW-2jhnIS4etX9TjGAX6-TcSeK1X5c2IXBKIYvg	$7MV6cVe8OZRcCQoQ--G1tiE1hrAYBgcNJdkoRnK9cCQ	!DaecDLDoTLOuqPWadN:localhost
$aqyW9vUrxdObe9RJw6v5sRs4rGwiu8gB_G28XjM_ZIY	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost
$aqyW9vUrxdObe9RJw6v5sRs4rGwiu8gB_G28XjM_ZIY	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$aqyW9vUrxdObe9RJw6v5sRs4rGwiu8gB_G28XjM_ZIY	$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	!YmJPedFXUiFFGzTnFq:localhost
$aqyW9vUrxdObe9RJw6v5sRs4rGwiu8gB_G28XjM_ZIY	$1TrVYjSyP6cjgknVY8uql_PO0hzYnXoh_Q5UcPnCrZo	!YmJPedFXUiFFGzTnFq:localhost
$CZrqEW9z_cBAHrxuxxcYegi7fg1tf20O1jmxL17mC9Y	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$CZrqEW9z_cBAHrxuxxcYegi7fg1tf20O1jmxL17mC9Y	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$CZrqEW9z_cBAHrxuxxcYegi7fg1tf20O1jmxL17mC9Y	$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	!DaecDLDoTLOuqPWadN:localhost
$CZrqEW9z_cBAHrxuxxcYegi7fg1tf20O1jmxL17mC9Y	$7kJDwW-2jhnIS4etX9TjGAX6-TcSeK1X5c2IXBKIYvg	!DaecDLDoTLOuqPWadN:localhost
$PUa692WLwxL3-4B_FJ5fKAezQeDkQvk0Mt4aK6y6bKU	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$PUa692WLwxL3-4B_FJ5fKAezQeDkQvk0Mt4aK6y6bKU	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$PUa692WLwxL3-4B_FJ5fKAezQeDkQvk0Mt4aK6y6bKU	$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	!DaecDLDoTLOuqPWadN:localhost
$PUa692WLwxL3-4B_FJ5fKAezQeDkQvk0Mt4aK6y6bKU	$RwIZxuK_hLp0XkjhXtRp1uSYNLClkMGppfpR_voC8MU	!DaecDLDoTLOuqPWadN:localhost
$5AKU6xT-ue4wUP91q_e8RberEbyIcJxjftWsBfd5390	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost
$5AKU6xT-ue4wUP91q_e8RberEbyIcJxjftWsBfd5390	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$5AKU6xT-ue4wUP91q_e8RberEbyIcJxjftWsBfd5390	$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	!YmJPedFXUiFFGzTnFq:localhost
$5AKU6xT-ue4wUP91q_e8RberEbyIcJxjftWsBfd5390	$aqyW9vUrxdObe9RJw6v5sRs4rGwiu8gB_G28XjM_ZIY	!YmJPedFXUiFFGzTnFq:localhost
$BzGhHpwzF69iD1LpgSzUCmR1BGptwZ_OUHk4PeOzJP0	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$BzGhHpwzF69iD1LpgSzUCmR1BGptwZ_OUHk4PeOzJP0	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$BzGhHpwzF69iD1LpgSzUCmR1BGptwZ_OUHk4PeOzJP0	$CZrqEW9z_cBAHrxuxxcYegi7fg1tf20O1jmxL17mC9Y	!DaecDLDoTLOuqPWadN:localhost
$d8H-cks_WJ2pUVeQBHNQjxwMxQQ0dsVns9Egvk6ZZSY	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost
$d8H-cks_WJ2pUVeQBHNQjxwMxQQ0dsVns9Egvk6ZZSY	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$d8H-cks_WJ2pUVeQBHNQjxwMxQQ0dsVns9Egvk6ZZSY	$5AKU6xT-ue4wUP91q_e8RberEbyIcJxjftWsBfd5390	!YmJPedFXUiFFGzTnFq:localhost
$Gq6AiRbih1LLH4wkJuCyznmTxYjtNTs_3rlzFDU1SLk	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$Gq6AiRbih1LLH4wkJuCyznmTxYjtNTs_3rlzFDU1SLk	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$Gq6AiRbih1LLH4wkJuCyznmTxYjtNTs_3rlzFDU1SLk	$PUa692WLwxL3-4B_FJ5fKAezQeDkQvk0Mt4aK6y6bKU	!DaecDLDoTLOuqPWadN:localhost
$dML7rSy7hzRtf__Ngjhbwue3LB55pJlChEmQb7TTrUA	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost
$dML7rSy7hzRtf__Ngjhbwue3LB55pJlChEmQb7TTrUA	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$dML7rSy7hzRtf__Ngjhbwue3LB55pJlChEmQb7TTrUA	$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	!YmJPedFXUiFFGzTnFq:localhost
$dML7rSy7hzRtf__Ngjhbwue3LB55pJlChEmQb7TTrUA	$d8H-cks_WJ2pUVeQBHNQjxwMxQQ0dsVns9Egvk6ZZSY	!YmJPedFXUiFFGzTnFq:localhost
$RwIZxuK_hLp0XkjhXtRp1uSYNLClkMGppfpR_voC8MU	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$RwIZxuK_hLp0XkjhXtRp1uSYNLClkMGppfpR_voC8MU	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$RwIZxuK_hLp0XkjhXtRp1uSYNLClkMGppfpR_voC8MU	$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	!DaecDLDoTLOuqPWadN:localhost
$RwIZxuK_hLp0XkjhXtRp1uSYNLClkMGppfpR_voC8MU	$BzGhHpwzF69iD1LpgSzUCmR1BGptwZ_OUHk4PeOzJP0	!DaecDLDoTLOuqPWadN:localhost
$OP5HTw1PQzzmVnL4rM6W9vo_5awgP51OChBdnKJUw3k	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost
$OP5HTw1PQzzmVnL4rM6W9vo_5awgP51OChBdnKJUw3k	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$OP5HTw1PQzzmVnL4rM6W9vo_5awgP51OChBdnKJUw3k	$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	!YmJPedFXUiFFGzTnFq:localhost
$OP5HTw1PQzzmVnL4rM6W9vo_5awgP51OChBdnKJUw3k	$dML7rSy7hzRtf__Ngjhbwue3LB55pJlChEmQb7TTrUA	!YmJPedFXUiFFGzTnFq:localhost
$21WoLTVJrJ52kKvP6FJpyDr7jDrBBFwJ8jtLVe5BxoE	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost
$21WoLTVJrJ52kKvP6FJpyDr7jDrBBFwJ8jtLVe5BxoE	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$21WoLTVJrJ52kKvP6FJpyDr7jDrBBFwJ8jtLVe5BxoE	$OP5HTw1PQzzmVnL4rM6W9vo_5awgP51OChBdnKJUw3k	!YmJPedFXUiFFGzTnFq:localhost
$De7JBlVgW8VX8ZxAOpb5VsKlSpBrrkExJPDpY6Jb2eQ	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$De7JBlVgW8VX8ZxAOpb5VsKlSpBrrkExJPDpY6Jb2eQ	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$De7JBlVgW8VX8ZxAOpb5VsKlSpBrrkExJPDpY6Jb2eQ	$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	!DaecDLDoTLOuqPWadN:localhost
$De7JBlVgW8VX8ZxAOpb5VsKlSpBrrkExJPDpY6Jb2eQ	$Gq6AiRbih1LLH4wkJuCyznmTxYjtNTs_3rlzFDU1SLk	!DaecDLDoTLOuqPWadN:localhost
$zpGESsEospA4z5J4JRYQhBomXyVjLg0lwLJpTY6TrFw	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost
$zpGESsEospA4z5J4JRYQhBomXyVjLg0lwLJpTY6TrFw	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$zpGESsEospA4z5J4JRYQhBomXyVjLg0lwLJpTY6TrFw	$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	!YmJPedFXUiFFGzTnFq:localhost
$zpGESsEospA4z5J4JRYQhBomXyVjLg0lwLJpTY6TrFw	$21WoLTVJrJ52kKvP6FJpyDr7jDrBBFwJ8jtLVe5BxoE	!YmJPedFXUiFFGzTnFq:localhost
$z5XMi95yi1w0KN3jNQ-MskRCNLMJBwr2DZ949BQkcOA	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$z5XMi95yi1w0KN3jNQ-MskRCNLMJBwr2DZ949BQkcOA	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$z5XMi95yi1w0KN3jNQ-MskRCNLMJBwr2DZ949BQkcOA	$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	!DaecDLDoTLOuqPWadN:localhost
$z5XMi95yi1w0KN3jNQ-MskRCNLMJBwr2DZ949BQkcOA	$De7JBlVgW8VX8ZxAOpb5VsKlSpBrrkExJPDpY6Jb2eQ	!DaecDLDoTLOuqPWadN:localhost
$ZCrE8n-g5lxd9QFIdUh_5iwteqPL5nimDqoJjpvZbFw	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost
$ZCrE8n-g5lxd9QFIdUh_5iwteqPL5nimDqoJjpvZbFw	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$ZCrE8n-g5lxd9QFIdUh_5iwteqPL5nimDqoJjpvZbFw	$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	!YmJPedFXUiFFGzTnFq:localhost
$ZCrE8n-g5lxd9QFIdUh_5iwteqPL5nimDqoJjpvZbFw	$zpGESsEospA4z5J4JRYQhBomXyVjLg0lwLJpTY6TrFw	!YmJPedFXUiFFGzTnFq:localhost
$P-cjsZvHLir5EVtcPh_t3mCvn8_Lc4bfG_lOprYS1U4	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$P-cjsZvHLir5EVtcPh_t3mCvn8_Lc4bfG_lOprYS1U4	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$P-cjsZvHLir5EVtcPh_t3mCvn8_Lc4bfG_lOprYS1U4	$z5XMi95yi1w0KN3jNQ-MskRCNLMJBwr2DZ949BQkcOA	!DaecDLDoTLOuqPWadN:localhost
$utAs_ygC9AwIZbOfZwzq7nGH_lAonZbFfYMq25Sbnes	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost
$utAs_ygC9AwIZbOfZwzq7nGH_lAonZbFfYMq25Sbnes	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$utAs_ygC9AwIZbOfZwzq7nGH_lAonZbFfYMq25Sbnes	$ZCrE8n-g5lxd9QFIdUh_5iwteqPL5nimDqoJjpvZbFw	!YmJPedFXUiFFGzTnFq:localhost
$bEJ_JyOf1Ygj-Cm0huzAPtvmILPNN--9n3pzgagwWmI	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$bEJ_JyOf1Ygj-Cm0huzAPtvmILPNN--9n3pzgagwWmI	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$bEJ_JyOf1Ygj-Cm0huzAPtvmILPNN--9n3pzgagwWmI	$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	!DaecDLDoTLOuqPWadN:localhost
$bEJ_JyOf1Ygj-Cm0huzAPtvmILPNN--9n3pzgagwWmI	$P-cjsZvHLir5EVtcPh_t3mCvn8_Lc4bfG_lOprYS1U4	!DaecDLDoTLOuqPWadN:localhost
$Q73eZCSY4oV7fYHAJT-iw3ItAuHA58eqRH82uGwH44w	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost
$Q73eZCSY4oV7fYHAJT-iw3ItAuHA58eqRH82uGwH44w	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$Q73eZCSY4oV7fYHAJT-iw3ItAuHA58eqRH82uGwH44w	$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	!YmJPedFXUiFFGzTnFq:localhost
$Q73eZCSY4oV7fYHAJT-iw3ItAuHA58eqRH82uGwH44w	$utAs_ygC9AwIZbOfZwzq7nGH_lAonZbFfYMq25Sbnes	!YmJPedFXUiFFGzTnFq:localhost
$PmKTWj14_fU64-YCl_JArQdeIIgT1glyUAP8DQBs0uI	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$PmKTWj14_fU64-YCl_JArQdeIIgT1glyUAP8DQBs0uI	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$PmKTWj14_fU64-YCl_JArQdeIIgT1glyUAP8DQBs0uI	$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	!DaecDLDoTLOuqPWadN:localhost
$PmKTWj14_fU64-YCl_JArQdeIIgT1glyUAP8DQBs0uI	$bEJ_JyOf1Ygj-Cm0huzAPtvmILPNN--9n3pzgagwWmI	!DaecDLDoTLOuqPWadN:localhost
$fyV6TMmTq9wDrYp9EN2Aw5D0DmsfhzoTxlQ1m0pSZAE	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost
$fyV6TMmTq9wDrYp9EN2Aw5D0DmsfhzoTxlQ1m0pSZAE	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$fyV6TMmTq9wDrYp9EN2Aw5D0DmsfhzoTxlQ1m0pSZAE	$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	!YmJPedFXUiFFGzTnFq:localhost
$fyV6TMmTq9wDrYp9EN2Aw5D0DmsfhzoTxlQ1m0pSZAE	$Q73eZCSY4oV7fYHAJT-iw3ItAuHA58eqRH82uGwH44w	!YmJPedFXUiFFGzTnFq:localhost
$p-JIkw6J2K6wxu8JkmJXlKjanI9p7AuZUDneiYknsFc	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost
$p-JIkw6J2K6wxu8JkmJXlKjanI9p7AuZUDneiYknsFc	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$p-JIkw6J2K6wxu8JkmJXlKjanI9p7AuZUDneiYknsFc	$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	!YmJPedFXUiFFGzTnFq:localhost
$p-JIkw6J2K6wxu8JkmJXlKjanI9p7AuZUDneiYknsFc	$fyV6TMmTq9wDrYp9EN2Aw5D0DmsfhzoTxlQ1m0pSZAE	!YmJPedFXUiFFGzTnFq:localhost
$4W6pWQc6IgcxfGV0EHiFYFQtkY1qCo6APGtlCAr60LU	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$4W6pWQc6IgcxfGV0EHiFYFQtkY1qCo6APGtlCAr60LU	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$4W6pWQc6IgcxfGV0EHiFYFQtkY1qCo6APGtlCAr60LU	$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	!DaecDLDoTLOuqPWadN:localhost
$4W6pWQc6IgcxfGV0EHiFYFQtkY1qCo6APGtlCAr60LU	$PmKTWj14_fU64-YCl_JArQdeIIgT1glyUAP8DQBs0uI	!DaecDLDoTLOuqPWadN:localhost
$whRcD0OyHSdXs5wCZ-Gol9e_KUH--BOTyu1FkYhhQ8E	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost
$whRcD0OyHSdXs5wCZ-Gol9e_KUH--BOTyu1FkYhhQ8E	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$whRcD0OyHSdXs5wCZ-Gol9e_KUH--BOTyu1FkYhhQ8E	$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	!YmJPedFXUiFFGzTnFq:localhost
$whRcD0OyHSdXs5wCZ-Gol9e_KUH--BOTyu1FkYhhQ8E	$p-JIkw6J2K6wxu8JkmJXlKjanI9p7AuZUDneiYknsFc	!YmJPedFXUiFFGzTnFq:localhost
$yFVhlEG5pdVcYKH9LhbJ96IK79GygR0jCiB4NU7HPYM	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$yFVhlEG5pdVcYKH9LhbJ96IK79GygR0jCiB4NU7HPYM	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$yFVhlEG5pdVcYKH9LhbJ96IK79GygR0jCiB4NU7HPYM	$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	!DaecDLDoTLOuqPWadN:localhost
$yFVhlEG5pdVcYKH9LhbJ96IK79GygR0jCiB4NU7HPYM	$4W6pWQc6IgcxfGV0EHiFYFQtkY1qCo6APGtlCAr60LU	!DaecDLDoTLOuqPWadN:localhost
$pRbv28FK8ljHETiS081PP5TzzhsKXQ6FELLbCQtcHy4	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$pRbv28FK8ljHETiS081PP5TzzhsKXQ6FELLbCQtcHy4	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$pRbv28FK8ljHETiS081PP5TzzhsKXQ6FELLbCQtcHy4	$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	!DaecDLDoTLOuqPWadN:localhost
$pRbv28FK8ljHETiS081PP5TzzhsKXQ6FELLbCQtcHy4	$sZ_xzte7aB_ofIWratL2US43tIv1Stl0DOtQuVuXIcE	!DaecDLDoTLOuqPWadN:localhost
$Dp5Q-o1kO6cZxdLOQVR1Ba5ymgYTF0qKir8rd5XVyd8	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost
$Dp5Q-o1kO6cZxdLOQVR1Ba5ymgYTF0qKir8rd5XVyd8	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$Dp5Q-o1kO6cZxdLOQVR1Ba5ymgYTF0qKir8rd5XVyd8	$whRcD0OyHSdXs5wCZ-Gol9e_KUH--BOTyu1FkYhhQ8E	!YmJPedFXUiFFGzTnFq:localhost
$sZ_xzte7aB_ofIWratL2US43tIv1Stl0DOtQuVuXIcE	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$sZ_xzte7aB_ofIWratL2US43tIv1Stl0DOtQuVuXIcE	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$sZ_xzte7aB_ofIWratL2US43tIv1Stl0DOtQuVuXIcE	$yFVhlEG5pdVcYKH9LhbJ96IK79GygR0jCiB4NU7HPYM	!DaecDLDoTLOuqPWadN:localhost
$I9BAqY-jJivf3BugaTzIjWwCq4Vsthp2Srzia5sBtvs	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost
$I9BAqY-jJivf3BugaTzIjWwCq4Vsthp2Srzia5sBtvs	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$I9BAqY-jJivf3BugaTzIjWwCq4Vsthp2Srzia5sBtvs	$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	!YmJPedFXUiFFGzTnFq:localhost
$I9BAqY-jJivf3BugaTzIjWwCq4Vsthp2Srzia5sBtvs	$Dp5Q-o1kO6cZxdLOQVR1Ba5ymgYTF0qKir8rd5XVyd8	!YmJPedFXUiFFGzTnFq:localhost
$RFfsT0l03gEKL7fV86ElHnmtu7jGdj4KRpuuCyQKLh0	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost
$RFfsT0l03gEKL7fV86ElHnmtu7jGdj4KRpuuCyQKLh0	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$RFfsT0l03gEKL7fV86ElHnmtu7jGdj4KRpuuCyQKLh0	$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	!YmJPedFXUiFFGzTnFq:localhost
$RFfsT0l03gEKL7fV86ElHnmtu7jGdj4KRpuuCyQKLh0	$I9BAqY-jJivf3BugaTzIjWwCq4Vsthp2Srzia5sBtvs	!YmJPedFXUiFFGzTnFq:localhost
$sCYM3URaqv6flwwrn8lHRJpDn83Sz8RuF7bYxgb0i8g	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$sCYM3URaqv6flwwrn8lHRJpDn83Sz8RuF7bYxgb0i8g	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$sCYM3URaqv6flwwrn8lHRJpDn83Sz8RuF7bYxgb0i8g	$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	!DaecDLDoTLOuqPWadN:localhost
$sCYM3URaqv6flwwrn8lHRJpDn83Sz8RuF7bYxgb0i8g	$pRbv28FK8ljHETiS081PP5TzzhsKXQ6FELLbCQtcHy4	!DaecDLDoTLOuqPWadN:localhost
$DaEV2INCT0t6y3M79Y5P4M-s3jrmnFbl0thmqnRCeWM	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost
$DaEV2INCT0t6y3M79Y5P4M-s3jrmnFbl0thmqnRCeWM	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$DaEV2INCT0t6y3M79Y5P4M-s3jrmnFbl0thmqnRCeWM	$RFfsT0l03gEKL7fV86ElHnmtu7jGdj4KRpuuCyQKLh0	!YmJPedFXUiFFGzTnFq:localhost
$dcq0w5YsiXgEtTRJPYWW2GDKRM3k4SjC-ab3rJOSh7Q	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$dcq0w5YsiXgEtTRJPYWW2GDKRM3k4SjC-ab3rJOSh7Q	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$dcq0w5YsiXgEtTRJPYWW2GDKRM3k4SjC-ab3rJOSh7Q	$sCYM3URaqv6flwwrn8lHRJpDn83Sz8RuF7bYxgb0i8g	!DaecDLDoTLOuqPWadN:localhost
$74eOdDCOl9SWRA3dJaPSiB4EC_sX__ThIgxmrPtmbZE	$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost
$74eOdDCOl9SWRA3dJaPSiB4EC_sX__ThIgxmrPtmbZE	$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg	!DaecDLDoTLOuqPWadN:localhost
$74eOdDCOl9SWRA3dJaPSiB4EC_sX__ThIgxmrPtmbZE	$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY	!DaecDLDoTLOuqPWadN:localhost
$74eOdDCOl9SWRA3dJaPSiB4EC_sX__ThIgxmrPtmbZE	$dcq0w5YsiXgEtTRJPYWW2GDKRM3k4SjC-ab3rJOSh7Q	!DaecDLDoTLOuqPWadN:localhost
$rT4YjNqnp8qiyQZIGMLIgPcDOrWgpTUHj-uEqSq5eFA	$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok	!YmJPedFXUiFFGzTnFq:localhost
$rT4YjNqnp8qiyQZIGMLIgPcDOrWgpTUHj-uEqSq5eFA	$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM	!YmJPedFXUiFFGzTnFq:localhost
$rT4YjNqnp8qiyQZIGMLIgPcDOrWgpTUHj-uEqSq5eFA	$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM	!YmJPedFXUiFFGzTnFq:localhost
$rT4YjNqnp8qiyQZIGMLIgPcDOrWgpTUHj-uEqSq5eFA	$DaEV2INCT0t6y3M79Y5P4M-s3jrmnFbl0thmqnRCeWM	!YmJPedFXUiFFGzTnFq:localhost
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
19	1	13	3
19	1	11	1
19	1	13	3
19	1	8	1
19	1	9	1
20	1	6	2
20	1	4	1
20	1	2	1
20	1	6	2
20	1	1	1
22	1	21	1
26	1	21	1
26	1	23	1
24	1	21	1
25	1	23	1
25	1	21	1
26	1	22	1
24	1	23	1
25	1	22	1
23	1	21	1
24	1	22	1
23	1	22	1
27	1	22	1
27	1	23	1
27	1	21	1
28	1	21	1
28	1	24	1
28	1	22	1
28	1	23	1
29	1	22	1
29	1	23	1
29	1	21	1
29	1	24	1
16	2	13	3
15	2	6	2
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
$4Wo5EetfrJ0oD7aWVI6CvS_-ZUM3lsyzkFZeQElMcmI	19	1
$eOdfuP6TezgWF5799z0-muVXLh1k8LvHE2Wfob0cC3A	20	1
$SCwfg4xWBzxHVcFLtW1DbcDU4LMVkfgjYJG-qdUypcM	21	1
$RB7fKTVNYlqIOEPsSHLuZd4VtyQWzJBKjadsEKrzboc	22	1
$VypxR6iKVehL3VR2C035y9gijIu-KXtOmJ85mKX9XLI	23	1
$1kUMRxz6Q6tB2pRvD-yuOBQbj2dooMjTGymKWTyL_I0	24	1
$MWD--uqyNXbmKDBMJob9sDY5AM4riTmkAwwz36FIaPk	26	1
$qx1E7MsFRdI9CbDeDYHg3A8XeN6MXU2rkBGCoxPB5mw	25	1
$a1xA663y2WchzA_Q5jmTKVlInC_HDgPTK8C2g37ysdk	27	1
$wdUPyT-0i7vmiiPz1WNunqvPAIWSfFtnwV1OizPIkvg	28	1
$al7p9tH0ZoT5Yu3HsYz1r2ak-9HkXf2coQ7KKeBerUk	29	1
$E44xF_r_bYO9HOH-lw-VkWepvoS6z9dxDWthhfbpT9M	16	2
$PksohbU2dYCXTn5ETrl9bIqsEVAPP0Wohp--_6XwmYg	15	2
$ycR02cfa_D8mViUfnzHTBMWRlLibcN2pYZDwiiQUt8I	15	3
$4EiubgnrkRAh09BKQLVXOeE9xGDhNpI_objrHMKclmA	15	4
$9-LSz3ddCTGWUa1IWqJRNNSh2mJrY7YVMY_uo340Sek	16	3
$n7_pif4S0hNHmw6iRBbW8iOHiFYTB60HnOnp4zhPUiM	15	5
$a185DaoMSzelXmfPlkcYOe3H3zITI_nFoVFWjnPmTu8	16	4
$Y6Vh2Kkasecp6HyMWxXbvX7gYSqrx6mIGOOROWKR1Hs	15	6
$tvfSz5Kqzjfh39pYs3yfctIZoJQ09aOzDx4YZvZDlyc	16	5
$84NzkDN2QGVP9qS7o_z1qOhaHe5-fSbz4Vs2SiNDPo0	15	7
$oU5B1qtEraaFCsivi4-r4WT9WGSSBIzW-i7EDPYS-eE	15	8
$DhWWh8GrURTFDa120InvAq5u-MKwyslHHOkRAcsUhaQ	16	6
$HvHWZQ09kf-ICUV-Ar9JELFLWq2tJUi2ull2GBzbx9U	16	7
$toF4I3EB1pERgvaXBIbhBugPExKQ2bOI0J6aOngeVI4	15	9
$4ODGclJajZc3SV1KXAMLeoAZrYyBdfzBaT-uorLgyJ8	15	10
$81XepwsM4YptvtHgl3P5SaUSvkP94S2d7apqzJ78aFk	16	8
$dL0sqD6DHzPvOsuGJe1kcseFEXgtsK3Q59XyD3PJVk4	16	9
$Pk6fFbdC0REz3T43EROb2OhYqN4o1ptnYGXXeyMDxkE	15	11
$DsB5975yzOpruMKKVBUYRHB3MSljJYHh3p7763sNf2I	16	10
$7Op41p6mCUbcp5TuaBcCF4mMRwPYz6lWW7a943BDG8o	15	12
$V4DFlazGXeBPWV65AAUJ4t5Qg3tYPqs8hY5TxXXOAg8	15	13
$4VQxBaDA6dKjPvqNVj95IwQXv3QL3a-bXdpp4EyG9yo	16	11
$XLYrVIK-R-MtOR1YnQaG3APBProvOP79zhKQSr95HqE	16	12
$bm6jSsPXymAqmwjgIzaCnnJ6c2n_z2s5EzuLfrNVKvE	15	14
$qjaNmlKX4IG53qDAgTwuNoxohPKncklE70COvnTRmxc	16	13
$LgX6qWXYlaiVRDlpKJmG6b1DcgpCsOwZlJZ0c9LjXmw	15	15
$eKKl-y9GISjb7jjkVd_Vn_qgDxbMFvFS-A5GytvRyVA	16	14
$eMJm6wCYpxKfgz2KOhEAL5wkidGtV_nWPvoVzahFQ_w	15	16
$V3iPyXBY5Rdjfq2cwuP29HNjpy0XdkW-xZbfClfMyX8	15	17
$iT2ZJrZtDk-8_lxymECQMqYbECP_dXcTXNOuVCnSanc	16	15
$1TrVYjSyP6cjgknVY8uql_PO0hzYnXoh_Q5UcPnCrZo	16	16
$7MV6cVe8OZRcCQoQ--G1tiE1hrAYBgcNJdkoRnK9cCQ	15	18
$7kJDwW-2jhnIS4etX9TjGAX6-TcSeK1X5c2IXBKIYvg	15	19
$aqyW9vUrxdObe9RJw6v5sRs4rGwiu8gB_G28XjM_ZIY	16	17
$CZrqEW9z_cBAHrxuxxcYegi7fg1tf20O1jmxL17mC9Y	15	20
$5AKU6xT-ue4wUP91q_e8RberEbyIcJxjftWsBfd5390	16	18
$BzGhHpwzF69iD1LpgSzUCmR1BGptwZ_OUHk4PeOzJP0	15	21
$d8H-cks_WJ2pUVeQBHNQjxwMxQQ0dsVns9Egvk6ZZSY	16	19
$dML7rSy7hzRtf__Ngjhbwue3LB55pJlChEmQb7TTrUA	16	20
$RwIZxuK_hLp0XkjhXtRp1uSYNLClkMGppfpR_voC8MU	15	22
$PUa692WLwxL3-4B_FJ5fKAezQeDkQvk0Mt4aK6y6bKU	15	23
$OP5HTw1PQzzmVnL4rM6W9vo_5awgP51OChBdnKJUw3k	16	21
$Gq6AiRbih1LLH4wkJuCyznmTxYjtNTs_3rlzFDU1SLk	15	24
$21WoLTVJrJ52kKvP6FJpyDr7jDrBBFwJ8jtLVe5BxoE	16	22
$De7JBlVgW8VX8ZxAOpb5VsKlSpBrrkExJPDpY6Jb2eQ	15	25
$zpGESsEospA4z5J4JRYQhBomXyVjLg0lwLJpTY6TrFw	16	23
$z5XMi95yi1w0KN3jNQ-MskRCNLMJBwr2DZ949BQkcOA	15	26
$ZCrE8n-g5lxd9QFIdUh_5iwteqPL5nimDqoJjpvZbFw	16	24
$P-cjsZvHLir5EVtcPh_t3mCvn8_Lc4bfG_lOprYS1U4	15	27
$utAs_ygC9AwIZbOfZwzq7nGH_lAonZbFfYMq25Sbnes	16	25
$bEJ_JyOf1Ygj-Cm0huzAPtvmILPNN--9n3pzgagwWmI	15	28
$Q73eZCSY4oV7fYHAJT-iw3ItAuHA58eqRH82uGwH44w	16	26
$PmKTWj14_fU64-YCl_JArQdeIIgT1glyUAP8DQBs0uI	15	29
$fyV6TMmTq9wDrYp9EN2Aw5D0DmsfhzoTxlQ1m0pSZAE	16	27
$p-JIkw6J2K6wxu8JkmJXlKjanI9p7AuZUDneiYknsFc	16	28
$4W6pWQc6IgcxfGV0EHiFYFQtkY1qCo6APGtlCAr60LU	15	30
$whRcD0OyHSdXs5wCZ-Gol9e_KUH--BOTyu1FkYhhQ8E	16	29
$pRbv28FK8ljHETiS081PP5TzzhsKXQ6FELLbCQtcHy4	15	33
$yFVhlEG5pdVcYKH9LhbJ96IK79GygR0jCiB4NU7HPYM	15	31
$Dp5Q-o1kO6cZxdLOQVR1Ba5ymgYTF0qKir8rd5XVyd8	16	30
$DaEV2INCT0t6y3M79Y5P4M-s3jrmnFbl0thmqnRCeWM	16	33
$sZ_xzte7aB_ofIWratL2US43tIv1Stl0DOtQuVuXIcE	15	32
$I9BAqY-jJivf3BugaTzIjWwCq4Vsthp2Srzia5sBtvs	16	31
$RFfsT0l03gEKL7fV86ElHnmtu7jGdj4KRpuuCyQKLh0	16	32
$dcq0w5YsiXgEtTRJPYWW2GDKRM3k4SjC-ab3rJOSh7Q	15	35
$rT4YjNqnp8qiyQZIGMLIgPcDOrWgpTUHj-uEqSq5eFA	16	34
$sCYM3URaqv6flwwrn8lHRJpDn83Sz8RuF7bYxgb0i8g	15	34
$74eOdDCOl9SWRA3dJaPSiB4EC_sX__ThIgxmrPtmbZE	15	36
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
$4Wo5EetfrJ0oD7aWVI6CvS_-ZUM3lsyzkFZeQElMcmI	$6Lgivd2MHjS9x-3BOttMrBNfnyKpvrsbwS8TFPVdz1c	\N	f
$eOdfuP6TezgWF5799z0-muVXLh1k8LvHE2Wfob0cC3A	$e59i0svd92559O6Ylspucl1xefsa8dpbbZe0ZE0mUp4	\N	f
$gQgbgv5fxFXlqv1ijNKbz-lh6k1tNCvxkocpyKVWVRs	$eOdfuP6TezgWF5799z0-muVXLh1k8LvHE2Wfob0cC3A	\N	f
$dmuQAnknZxpgqjpjtYIvJcdnBBRW5Te8hQ85WDS7uEw	$gQgbgv5fxFXlqv1ijNKbz-lh6k1tNCvxkocpyKVWVRs	\N	f
$mAU9A94YjP4DM004IBnCOQl3huTesAnKbo1CkVX7wMg	$dmuQAnknZxpgqjpjtYIvJcdnBBRW5Te8hQ85WDS7uEw	\N	f
$yGEzNJBRRycOk7KUDyR_XFaYOvJ4Hi44-bm0_UqUCeE	$mAU9A94YjP4DM004IBnCOQl3huTesAnKbo1CkVX7wMg	\N	f
$RB7fKTVNYlqIOEPsSHLuZd4VtyQWzJBKjadsEKrzboc	$SCwfg4xWBzxHVcFLtW1DbcDU4LMVkfgjYJG-qdUypcM	\N	f
$VypxR6iKVehL3VR2C035y9gijIu-KXtOmJ85mKX9XLI	$RB7fKTVNYlqIOEPsSHLuZd4VtyQWzJBKjadsEKrzboc	\N	f
$qx1E7MsFRdI9CbDeDYHg3A8XeN6MXU2rkBGCoxPB5mw	$VypxR6iKVehL3VR2C035y9gijIu-KXtOmJ85mKX9XLI	\N	f
$1kUMRxz6Q6tB2pRvD-yuOBQbj2dooMjTGymKWTyL_I0	$qx1E7MsFRdI9CbDeDYHg3A8XeN6MXU2rkBGCoxPB5mw	\N	f
$MWD--uqyNXbmKDBMJob9sDY5AM4riTmkAwwz36FIaPk	$1kUMRxz6Q6tB2pRvD-yuOBQbj2dooMjTGymKWTyL_I0	\N	f
$a1xA663y2WchzA_Q5jmTKVlInC_HDgPTK8C2g37ysdk	$MWD--uqyNXbmKDBMJob9sDY5AM4riTmkAwwz36FIaPk	\N	f
$wdUPyT-0i7vmiiPz1WNunqvPAIWSfFtnwV1OizPIkvg	$MWD--uqyNXbmKDBMJob9sDY5AM4riTmkAwwz36FIaPk	\N	f
$kULillGfRc9dmdALLVuNmIhsQ0DV5vjLVAQvpHNKHG8	$a1xA663y2WchzA_Q5jmTKVlInC_HDgPTK8C2g37ysdk	\N	f
$kULillGfRc9dmdALLVuNmIhsQ0DV5vjLVAQvpHNKHG8	$wdUPyT-0i7vmiiPz1WNunqvPAIWSfFtnwV1OizPIkvg	\N	f
$al7p9tH0ZoT5Yu3HsYz1r2ak-9HkXf2coQ7KKeBerUk	$kULillGfRc9dmdALLVuNmIhsQ0DV5vjLVAQvpHNKHG8	\N	f
$isvqtAkok4JAN-_OZRt7MG_xv-fWABZbUbvVPhtzjUI	$al7p9tH0ZoT5Yu3HsYz1r2ak-9HkXf2coQ7KKeBerUk	\N	f
$E44xF_r_bYO9HOH-lw-VkWepvoS6z9dxDWthhfbpT9M	$4Wo5EetfrJ0oD7aWVI6CvS_-ZUM3lsyzkFZeQElMcmI	\N	f
$PksohbU2dYCXTn5ETrl9bIqsEVAPP0Wohp--_6XwmYg	$yGEzNJBRRycOk7KUDyR_XFaYOvJ4Hi44-bm0_UqUCeE	\N	f
$ycR02cfa_D8mViUfnzHTBMWRlLibcN2pYZDwiiQUt8I	$PksohbU2dYCXTn5ETrl9bIqsEVAPP0Wohp--_6XwmYg	\N	f
$fuPA22emW4V0wHC5EllCh7JbzYMhTIW0DLr_D73YRtU	$ycR02cfa_D8mViUfnzHTBMWRlLibcN2pYZDwiiQUt8I	\N	f
$iZZW6EsuxUAxVBXtwcMnKFWoQkFHMXw7rvUqBVZ0wOM	$fuPA22emW4V0wHC5EllCh7JbzYMhTIW0DLr_D73YRtU	\N	f
$4EiubgnrkRAh09BKQLVXOeE9xGDhNpI_objrHMKclmA	$iZZW6EsuxUAxVBXtwcMnKFWoQkFHMXw7rvUqBVZ0wOM	\N	f
$9-LSz3ddCTGWUa1IWqJRNNSh2mJrY7YVMY_uo340Sek	$E44xF_r_bYO9HOH-lw-VkWepvoS6z9dxDWthhfbpT9M	\N	f
$n7_pif4S0hNHmw6iRBbW8iOHiFYTB60HnOnp4zhPUiM	$4EiubgnrkRAh09BKQLVXOeE9xGDhNpI_objrHMKclmA	\N	f
$a185DaoMSzelXmfPlkcYOe3H3zITI_nFoVFWjnPmTu8	$9-LSz3ddCTGWUa1IWqJRNNSh2mJrY7YVMY_uo340Sek	\N	f
$Y6Vh2Kkasecp6HyMWxXbvX7gYSqrx6mIGOOROWKR1Hs	$n7_pif4S0hNHmw6iRBbW8iOHiFYTB60HnOnp4zhPUiM	\N	f
$tvfSz5Kqzjfh39pYs3yfctIZoJQ09aOzDx4YZvZDlyc	$a185DaoMSzelXmfPlkcYOe3H3zITI_nFoVFWjnPmTu8	\N	f
$84NzkDN2QGVP9qS7o_z1qOhaHe5-fSbz4Vs2SiNDPo0	$Y6Vh2Kkasecp6HyMWxXbvX7gYSqrx6mIGOOROWKR1Hs	\N	f
$oU5B1qtEraaFCsivi4-r4WT9WGSSBIzW-i7EDPYS-eE	$84NzkDN2QGVP9qS7o_z1qOhaHe5-fSbz4Vs2SiNDPo0	\N	f
$DhWWh8GrURTFDa120InvAq5u-MKwyslHHOkRAcsUhaQ	$tvfSz5Kqzjfh39pYs3yfctIZoJQ09aOzDx4YZvZDlyc	\N	f
$HvHWZQ09kf-ICUV-Ar9JELFLWq2tJUi2ull2GBzbx9U	$DhWWh8GrURTFDa120InvAq5u-MKwyslHHOkRAcsUhaQ	\N	f
$toF4I3EB1pERgvaXBIbhBugPExKQ2bOI0J6aOngeVI4	$oU5B1qtEraaFCsivi4-r4WT9WGSSBIzW-i7EDPYS-eE	\N	f
$4ODGclJajZc3SV1KXAMLeoAZrYyBdfzBaT-uorLgyJ8	$toF4I3EB1pERgvaXBIbhBugPExKQ2bOI0J6aOngeVI4	\N	f
$81XepwsM4YptvtHgl3P5SaUSvkP94S2d7apqzJ78aFk	$HvHWZQ09kf-ICUV-Ar9JELFLWq2tJUi2ull2GBzbx9U	\N	f
$dL0sqD6DHzPvOsuGJe1kcseFEXgtsK3Q59XyD3PJVk4	$81XepwsM4YptvtHgl3P5SaUSvkP94S2d7apqzJ78aFk	\N	f
$Pk6fFbdC0REz3T43EROb2OhYqN4o1ptnYGXXeyMDxkE	$4ODGclJajZc3SV1KXAMLeoAZrYyBdfzBaT-uorLgyJ8	\N	f
$DsB5975yzOpruMKKVBUYRHB3MSljJYHh3p7763sNf2I	$dL0sqD6DHzPvOsuGJe1kcseFEXgtsK3Q59XyD3PJVk4	\N	f
$7Op41p6mCUbcp5TuaBcCF4mMRwPYz6lWW7a943BDG8o	$Pk6fFbdC0REz3T43EROb2OhYqN4o1ptnYGXXeyMDxkE	\N	f
$nD-WsmqnhEa4BIar13mUOspyj5CQ-NVfZYZo7aUnG8o	$7Op41p6mCUbcp5TuaBcCF4mMRwPYz6lWW7a943BDG8o	\N	f
$s1YwkJ0AvfbD0DFtp0NNPRSOEKYsrtf84Paq6r6Qn60	$isvqtAkok4JAN-_OZRt7MG_xv-fWABZbUbvVPhtzjUI	\N	f
$V4DFlazGXeBPWV65AAUJ4t5Qg3tYPqs8hY5TxXXOAg8	$nD-WsmqnhEa4BIar13mUOspyj5CQ-NVfZYZo7aUnG8o	\N	f
$4VQxBaDA6dKjPvqNVj95IwQXv3QL3a-bXdpp4EyG9yo	$DsB5975yzOpruMKKVBUYRHB3MSljJYHh3p7763sNf2I	\N	f
$XLYrVIK-R-MtOR1YnQaG3APBProvOP79zhKQSr95HqE	$4VQxBaDA6dKjPvqNVj95IwQXv3QL3a-bXdpp4EyG9yo	\N	f
$bm6jSsPXymAqmwjgIzaCnnJ6c2n_z2s5EzuLfrNVKvE	$V4DFlazGXeBPWV65AAUJ4t5Qg3tYPqs8hY5TxXXOAg8	\N	f
$qjaNmlKX4IG53qDAgTwuNoxohPKncklE70COvnTRmxc	$XLYrVIK-R-MtOR1YnQaG3APBProvOP79zhKQSr95HqE	\N	f
$LgX6qWXYlaiVRDlpKJmG6b1DcgpCsOwZlJZ0c9LjXmw	$bm6jSsPXymAqmwjgIzaCnnJ6c2n_z2s5EzuLfrNVKvE	\N	f
$eKKl-y9GISjb7jjkVd_Vn_qgDxbMFvFS-A5GytvRyVA	$qjaNmlKX4IG53qDAgTwuNoxohPKncklE70COvnTRmxc	\N	f
$eMJm6wCYpxKfgz2KOhEAL5wkidGtV_nWPvoVzahFQ_w	$LgX6qWXYlaiVRDlpKJmG6b1DcgpCsOwZlJZ0c9LjXmw	\N	f
$V3iPyXBY5Rdjfq2cwuP29HNjpy0XdkW-xZbfClfMyX8	$eMJm6wCYpxKfgz2KOhEAL5wkidGtV_nWPvoVzahFQ_w	\N	f
$iT2ZJrZtDk-8_lxymECQMqYbECP_dXcTXNOuVCnSanc	$eKKl-y9GISjb7jjkVd_Vn_qgDxbMFvFS-A5GytvRyVA	\N	f
$1TrVYjSyP6cjgknVY8uql_PO0hzYnXoh_Q5UcPnCrZo	$iT2ZJrZtDk-8_lxymECQMqYbECP_dXcTXNOuVCnSanc	\N	f
$7MV6cVe8OZRcCQoQ--G1tiE1hrAYBgcNJdkoRnK9cCQ	$V3iPyXBY5Rdjfq2cwuP29HNjpy0XdkW-xZbfClfMyX8	\N	f
$7kJDwW-2jhnIS4etX9TjGAX6-TcSeK1X5c2IXBKIYvg	$7MV6cVe8OZRcCQoQ--G1tiE1hrAYBgcNJdkoRnK9cCQ	\N	f
$aqyW9vUrxdObe9RJw6v5sRs4rGwiu8gB_G28XjM_ZIY	$1TrVYjSyP6cjgknVY8uql_PO0hzYnXoh_Q5UcPnCrZo	\N	f
$CZrqEW9z_cBAHrxuxxcYegi7fg1tf20O1jmxL17mC9Y	$7kJDwW-2jhnIS4etX9TjGAX6-TcSeK1X5c2IXBKIYvg	\N	f
$5AKU6xT-ue4wUP91q_e8RberEbyIcJxjftWsBfd5390	$aqyW9vUrxdObe9RJw6v5sRs4rGwiu8gB_G28XjM_ZIY	\N	f
$BzGhHpwzF69iD1LpgSzUCmR1BGptwZ_OUHk4PeOzJP0	$CZrqEW9z_cBAHrxuxxcYegi7fg1tf20O1jmxL17mC9Y	\N	f
$d8H-cks_WJ2pUVeQBHNQjxwMxQQ0dsVns9Egvk6ZZSY	$5AKU6xT-ue4wUP91q_e8RberEbyIcJxjftWsBfd5390	\N	f
$dML7rSy7hzRtf__Ngjhbwue3LB55pJlChEmQb7TTrUA	$d8H-cks_WJ2pUVeQBHNQjxwMxQQ0dsVns9Egvk6ZZSY	\N	f
$RwIZxuK_hLp0XkjhXtRp1uSYNLClkMGppfpR_voC8MU	$BzGhHpwzF69iD1LpgSzUCmR1BGptwZ_OUHk4PeOzJP0	\N	f
$PUa692WLwxL3-4B_FJ5fKAezQeDkQvk0Mt4aK6y6bKU	$RwIZxuK_hLp0XkjhXtRp1uSYNLClkMGppfpR_voC8MU	\N	f
$OP5HTw1PQzzmVnL4rM6W9vo_5awgP51OChBdnKJUw3k	$dML7rSy7hzRtf__Ngjhbwue3LB55pJlChEmQb7TTrUA	\N	f
$Gq6AiRbih1LLH4wkJuCyznmTxYjtNTs_3rlzFDU1SLk	$PUa692WLwxL3-4B_FJ5fKAezQeDkQvk0Mt4aK6y6bKU	\N	f
$21WoLTVJrJ52kKvP6FJpyDr7jDrBBFwJ8jtLVe5BxoE	$OP5HTw1PQzzmVnL4rM6W9vo_5awgP51OChBdnKJUw3k	\N	f
$De7JBlVgW8VX8ZxAOpb5VsKlSpBrrkExJPDpY6Jb2eQ	$Gq6AiRbih1LLH4wkJuCyznmTxYjtNTs_3rlzFDU1SLk	\N	f
$zpGESsEospA4z5J4JRYQhBomXyVjLg0lwLJpTY6TrFw	$21WoLTVJrJ52kKvP6FJpyDr7jDrBBFwJ8jtLVe5BxoE	\N	f
$z5XMi95yi1w0KN3jNQ-MskRCNLMJBwr2DZ949BQkcOA	$De7JBlVgW8VX8ZxAOpb5VsKlSpBrrkExJPDpY6Jb2eQ	\N	f
$ZCrE8n-g5lxd9QFIdUh_5iwteqPL5nimDqoJjpvZbFw	$zpGESsEospA4z5J4JRYQhBomXyVjLg0lwLJpTY6TrFw	\N	f
$P-cjsZvHLir5EVtcPh_t3mCvn8_Lc4bfG_lOprYS1U4	$z5XMi95yi1w0KN3jNQ-MskRCNLMJBwr2DZ949BQkcOA	\N	f
$utAs_ygC9AwIZbOfZwzq7nGH_lAonZbFfYMq25Sbnes	$ZCrE8n-g5lxd9QFIdUh_5iwteqPL5nimDqoJjpvZbFw	\N	f
$bEJ_JyOf1Ygj-Cm0huzAPtvmILPNN--9n3pzgagwWmI	$P-cjsZvHLir5EVtcPh_t3mCvn8_Lc4bfG_lOprYS1U4	\N	f
$Q73eZCSY4oV7fYHAJT-iw3ItAuHA58eqRH82uGwH44w	$utAs_ygC9AwIZbOfZwzq7nGH_lAonZbFfYMq25Sbnes	\N	f
$PmKTWj14_fU64-YCl_JArQdeIIgT1glyUAP8DQBs0uI	$bEJ_JyOf1Ygj-Cm0huzAPtvmILPNN--9n3pzgagwWmI	\N	f
$fyV6TMmTq9wDrYp9EN2Aw5D0DmsfhzoTxlQ1m0pSZAE	$Q73eZCSY4oV7fYHAJT-iw3ItAuHA58eqRH82uGwH44w	\N	f
$p-JIkw6J2K6wxu8JkmJXlKjanI9p7AuZUDneiYknsFc	$fyV6TMmTq9wDrYp9EN2Aw5D0DmsfhzoTxlQ1m0pSZAE	\N	f
$4W6pWQc6IgcxfGV0EHiFYFQtkY1qCo6APGtlCAr60LU	$PmKTWj14_fU64-YCl_JArQdeIIgT1glyUAP8DQBs0uI	\N	f
$whRcD0OyHSdXs5wCZ-Gol9e_KUH--BOTyu1FkYhhQ8E	$p-JIkw6J2K6wxu8JkmJXlKjanI9p7AuZUDneiYknsFc	\N	f
$yFVhlEG5pdVcYKH9LhbJ96IK79GygR0jCiB4NU7HPYM	$4W6pWQc6IgcxfGV0EHiFYFQtkY1qCo6APGtlCAr60LU	\N	f
$Dp5Q-o1kO6cZxdLOQVR1Ba5ymgYTF0qKir8rd5XVyd8	$whRcD0OyHSdXs5wCZ-Gol9e_KUH--BOTyu1FkYhhQ8E	\N	f
$sZ_xzte7aB_ofIWratL2US43tIv1Stl0DOtQuVuXIcE	$yFVhlEG5pdVcYKH9LhbJ96IK79GygR0jCiB4NU7HPYM	\N	f
$pRbv28FK8ljHETiS081PP5TzzhsKXQ6FELLbCQtcHy4	$sZ_xzte7aB_ofIWratL2US43tIv1Stl0DOtQuVuXIcE	\N	f
$I9BAqY-jJivf3BugaTzIjWwCq4Vsthp2Srzia5sBtvs	$Dp5Q-o1kO6cZxdLOQVR1Ba5ymgYTF0qKir8rd5XVyd8	\N	f
$sCYM3URaqv6flwwrn8lHRJpDn83Sz8RuF7bYxgb0i8g	$pRbv28FK8ljHETiS081PP5TzzhsKXQ6FELLbCQtcHy4	\N	f
$RFfsT0l03gEKL7fV86ElHnmtu7jGdj4KRpuuCyQKLh0	$I9BAqY-jJivf3BugaTzIjWwCq4Vsthp2Srzia5sBtvs	\N	f
$dcq0w5YsiXgEtTRJPYWW2GDKRM3k4SjC-ab3rJOSh7Q	$sCYM3URaqv6flwwrn8lHRJpDn83Sz8RuF7bYxgb0i8g	\N	f
$DaEV2INCT0t6y3M79Y5P4M-s3jrmnFbl0thmqnRCeWM	$RFfsT0l03gEKL7fV86ElHnmtu7jGdj4KRpuuCyQKLh0	\N	f
$74eOdDCOl9SWRA3dJaPSiB4EC_sX__ThIgxmrPtmbZE	$dcq0w5YsiXgEtTRJPYWW2GDKRM3k4SjC-ab3rJOSh7Q	\N	f
$rT4YjNqnp8qiyQZIGMLIgPcDOrWgpTUHj-uEqSq5eFA	$DaEV2INCT0t6y3M79Y5P4M-s3jrmnFbl0thmqnRCeWM	\N	f
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
$rT4YjNqnp8qiyQZIGMLIgPcDOrWgpTUHj-uEqSq5eFA	!YmJPedFXUiFFGzTnFq:localhost
$74eOdDCOl9SWRA3dJaPSiB4EC_sX__ThIgxmrPtmbZE	!DaecDLDoTLOuqPWadN:localhost
$s1YwkJ0AvfbD0DFtp0NNPRSOEKYsrtf84Paq6r6Qn60	!ZAIhwwJJQkZbVCWAWl:localhost
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
$4Wo5EetfrJ0oD7aWVI6CvS_-ZUM3lsyzkFZeQElMcmI	!YmJPedFXUiFFGzTnFq:localhost	{"token_id":6,"historical":false}	{"auth_events":["$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM","$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM"],"prev_events":["$6Lgivd2MHjS9x-3BOttMrBNfnyKpvrsbwS8TFPVdz1c"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@user1.matrix:localhost","content":{"membership":"join","displayname":"user1.matrix"},"depth":13,"state_key":"@user1.matrix:localhost","origin":"localhost","origin_server_ts":1675794349387,"hashes":{"sha256":"6eIu37cPf24IczaHT9i41CX4cGQbu24yy8WXSjec2ks"},"signatures":{"localhost":{"ed25519:a_vyji":"GyAW2waCI0PZ7djtVOG3FgBlYFMJU5jhuftLfZ6I8FinbJeYz7obck9uNrsrd0QWhm2Hu7yaJfy9MJqnOTfTBw"}},"unsigned":{"age_ts":1675794349387}}	3
$3iRjuPdSa2RM8LZ_hEUz2rpxW7wRYwAMtjldk4L3x2o	!YmJPedFXUiFFGzTnFq:localhost	{"token_id":4,"historical":false}	{"auth_events":["$HpReuVvJCIb4gFAA0V1ZLkXuAYpbGbYJ9xTxIowp0iA","$DoaPAQf-ky_qYpibXlB13gxRmHsYdEJTQRCskrRSxrI","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM"],"prev_events":["$ykL4uD4FNcb8S_8kQpwbthwvqPKRzD_pJ3jyfA-5ywc"],"type":"m.room.power_levels","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@admin:localhost","content":{"users":{"@admin:localhost":100,"@matterbot:localhost":0},"users_default":0,"events":{"m.room.name":50,"m.room.power_levels":100,"m.room.history_visibility":100,"m.room.canonical_alias":50,"m.room.avatar":50,"m.room.tombstone":100,"m.room.server_acl":100,"m.room.encryption":100,"m.space.child":50,"m.room.topic":50,"m.room.pinned_events":50,"m.reaction":0,"m.room.redaction":0,"org.matrix.msc3401.call":50,"org.matrix.msc3401.call.member":50,"im.vector.modular.widgets":50,"io.element.voice_broadcast_info":50},"events_default":0,"state_default":50,"ban":50,"kick":50,"redact":50,"invite":50,"historical":100},"depth":9,"state_key":"","origin":"localhost","origin_server_ts":1675288813725,"hashes":{"sha256":"JhvK4VzURw7/zfWj+Typllkddi2QjGR8FGcRHkMjkeE"},"signatures":{"localhost":{"ed25519:a_vyji":"2qxelJAcmSDnoHB0MMz45WGARuJDn42R1Dx4Nfqa13dVReIU8vfqW/5/cuhcPoYWAYL8GykitQJBMk2+2rygCA"}},"unsigned":{"age_ts":1675288813725,"replaces_state":"$DoaPAQf-ky_qYpibXlB13gxRmHsYdEJTQRCskrRSxrI"}}	3
$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E	!DaecDLDoTLOuqPWadN:localhost	{"token_id":4,"historical":false}	{"auth_events":["$UaZuzLfnyOIw3iLU39I6ihmpGMjzRB3mDd4pkHT22Jo","$cPQw7bnJzfkKROnFKbANhreS_L7eznZtJH4RClxd71s","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg"],"prev_events":["$06pNLPsFn-fF2WbziopICIA6qaey-LFJhiTAHGfqJS4"],"type":"m.room.power_levels","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@admin:localhost","content":{"users":{"@admin:localhost":100,"@matterbot:localhost":100},"users_default":0,"events":{"m.room.name":50,"m.room.power_levels":100,"m.room.history_visibility":100,"m.room.canonical_alias":50,"m.room.avatar":50,"m.room.tombstone":100,"m.room.server_acl":100,"m.room.encryption":100,"m.space.child":50,"m.room.topic":50,"m.room.pinned_events":50,"m.reaction":0,"m.room.redaction":0,"org.matrix.msc3401.call":50,"org.matrix.msc3401.call.member":50,"im.vector.modular.widgets":50,"io.element.voice_broadcast_info":50},"events_default":0,"state_default":50,"ban":50,"kick":50,"redact":50,"invite":50,"historical":100},"depth":9,"state_key":"","origin":"localhost","origin_server_ts":1675288889095,"hashes":{"sha256":"LoaPHUwCvCfim9YGY4N3VzvTYp20knBTqNNa2cIgezY"},"signatures":{"localhost":{"ed25519:a_vyji":"naBVO8l6eQOgCjyuDeGbtmw5odi0k+5p08jK6QDeaUsUH2ZBlS6+9eBu2/YdK+4FOGDJ9L2gXJN03+SRQn03CQ"}},"unsigned":{"age_ts":1675288889095,"replaces_state":"$cPQw7bnJzfkKROnFKbANhreS_L7eznZtJH4RClxd71s"}}	3
$CqTXYvkWmU1WEVsryzPffrK-UFPsAp9ZN7hNFMzRdcU	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$ykL4uD4FNcb8S_8kQpwbthwvqPKRzD_pJ3jyfA-5ywc","$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok","$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM"],"prev_events":["$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"admin [mm]"},"depth":11,"state_key":"@mm_admin:localhost","origin":"localhost","origin_server_ts":1675288909796,"hashes":{"sha256":"DpWxTm9cMA8m+EwYhpy/NLbhrfMR6LsF+/+i/B1HmI4"},"signatures":{"localhost":{"ed25519:a_vyji":"xEKMoH78Y3srW89d9B6XZ4wTp8xuv9XZx7g7tUqtiohsqOabIx6uSAK9OOiviffw0qQVGyhGNTGnKZSx5C0EBA"}},"unsigned":{"age_ts":1675288909796,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#town-square:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"9","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.name","state_key":"","content":{"name":"#town-square"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$e59i0svd92559O6Ylspucl1xefsa8dpbbZe0ZE0mUp4	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$M7i7kIr_313-fsK6zIJjyPUvcArWEnDYRpGwuz1z5zY","$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY","$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg"],"prev_events":["$M7i7kIr_313-fsK6zIJjyPUvcArWEnDYRpGwuz1z5zY"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@mm_admin:localhost","content":{"membership":"join","displayname":"admin [mm]"},"depth":11,"state_key":"@mm_admin:localhost","origin":"localhost","origin_server_ts":1675288910073,"hashes":{"sha256":"7sC6lZDmjkv9iDTtJMQBg2Sv3RLgwM3ZZapJfNYyqAA"},"signatures":{"localhost":{"ed25519:a_vyji":"vYSUWoqaGq0uPVftSVqpB3oKGqAdSU4bMX7XpRpdhXhVF7PMC8IL5+1QS5l6Bug/XTlwYEPICGq6cfoQlbp6Dw"}},"unsigned":{"age_ts":1675288910073,"replaces_state":"$M7i7kIr_313-fsK6zIJjyPUvcArWEnDYRpGwuz1z5zY"}}	3
$M7i7kIr_313-fsK6zIJjyPUvcArWEnDYRpGwuz1z5zY	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$06pNLPsFn-fF2WbziopICIA6qaey-LFJhiTAHGfqJS4","$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg"],"prev_events":["$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"membership":"invite","displayname":"admin [mm]"},"depth":10,"state_key":"@mm_admin:localhost","origin":"localhost","origin_server_ts":1675288909840,"hashes":{"sha256":"whNPEG7yS+tUS6+12r6Urq21x1t87WIMmzdoSae6QaE"},"signatures":{"localhost":{"ed25519:a_vyji":"hozjIZMGADWOHzkyPKxrEm+eTTdZqEmt5y5iVB/hP8HM/skkZrBx0VK47E3Y3nyjtLgPQDigza/o8+nlz4vSDg"}},"unsigned":{"age_ts":1675288909840,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#off-topic:localhost"},"sender":"@admin:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"9","creator":"@admin:localhost"},"sender":"@admin:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@admin:localhost"},{"type":"m.room.name","state_key":"","content":{"name":"#off-topic"},"sender":"@admin:localhost"},{"type":"m.room.member","state_key":"@matterbot:localhost","content":{"membership":"join","displayname":"Mattermost Bridge"},"sender":"@matterbot:localhost"}]}}	3
$6Lgivd2MHjS9x-3BOttMrBNfnyKpvrsbwS8TFPVdz1c	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$CqTXYvkWmU1WEVsryzPffrK-UFPsAp9ZN7hNFMzRdcU","$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM","$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM"],"prev_events":["$CqTXYvkWmU1WEVsryzPffrK-UFPsAp9ZN7hNFMzRdcU"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@mm_admin:localhost","content":{"membership":"join","displayname":"admin [mm]"},"depth":12,"state_key":"@mm_admin:localhost","origin":"localhost","origin_server_ts":1675288910076,"hashes":{"sha256":"3Ps0/weBCjQ7yfw1usg7PNHmd8g8/QyCXHh76T8JoJo"},"signatures":{"localhost":{"ed25519:a_vyji":"nv+XsQ7fiOlAl5i5FT9ijR1ANgk5+R4fkOw93K93gIkZynpnY0PsAxSk5PcEFPi7A+EEz9ABVjKSVGKd9NUkBA"}},"unsigned":{"age_ts":1675288910076,"replaces_state":"$CqTXYvkWmU1WEVsryzPffrK-UFPsAp9ZN7hNFMzRdcU"}}	3
$eOdfuP6TezgWF5799z0-muVXLh1k8LvHE2Wfob0cC3A	!DaecDLDoTLOuqPWadN:localhost	{"token_id":6,"historical":false}	{"auth_events":["$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg","$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY"],"prev_events":["$e59i0svd92559O6Ylspucl1xefsa8dpbbZe0ZE0mUp4"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@user1.matrix:localhost","content":{"membership":"join","displayname":"user1.matrix"},"depth":12,"state_key":"@user1.matrix:localhost","origin":"localhost","origin_server_ts":1675794373761,"hashes":{"sha256":"PAHCo4c2kmw3Mt5UbmV/9p25kNwx1qb8+343IwJ1/l4"},"signatures":{"localhost":{"ed25519:a_vyji":"iDmNn9XxSagGpVfLCvMRDod02MVt9XsJA0OV7vhpYNZy+yYaNQded6tmqlZCceLX4ePcGIP1b5arDtyeNwZJAA"}},"unsigned":{"age_ts":1675794373761}}	3
$gQgbgv5fxFXlqv1ijNKbz-lh6k1tNCvxkocpyKVWVRs	!DaecDLDoTLOuqPWadN:localhost	{"token_id":6,"txn_id":"m1675795622561.0","historical":false}	{"auth_events":["$eOdfuP6TezgWF5799z0-muVXLh1k8LvHE2Wfob0cC3A","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg","$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E"],"prev_events":["$eOdfuP6TezgWF5799z0-muVXLh1k8LvHE2Wfob0cC3A"],"type":"m.room.message","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@user1.matrix:localhost","content":{"msgtype":"m.text","body":"hej"},"depth":13,"origin":"localhost","origin_server_ts":1675795622658,"hashes":{"sha256":"geagnuPyGyO/8U0kvyiuPjJ0k7XyF3jXgCns306n0R4"},"signatures":{"localhost":{"ed25519:a_vyji":"InEJEFJGfMRsnFoyJVe5FAOx7+x/Yt0Gz/upk/+71F6cMRzhkS2hFGpHhfVM3TS4dv8lbW5jVETtaqfFzAYHCg"}},"unsigned":{"age_ts":1675795622658}}	3
$dmuQAnknZxpgqjpjtYIvJcdnBBRW5Te8hQ85WDS7uEw	!DaecDLDoTLOuqPWadN:localhost	{"token_id":6,"txn_id":"m1675796001803.1","historical":false}	{"auth_events":["$eOdfuP6TezgWF5799z0-muVXLh1k8LvHE2Wfob0cC3A","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg","$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E"],"prev_events":["$gQgbgv5fxFXlqv1ijNKbz-lh6k1tNCvxkocpyKVWVRs"],"type":"m.room.message","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@user1.matrix:localhost","content":{"msgtype":"m.text","body":"klkl"},"depth":14,"origin":"localhost","origin_server_ts":1675796001894,"hashes":{"sha256":"YDfyk92fuD0VXzZO56ckMDejXi2xTtcC8F6QfyBxfJU"},"signatures":{"localhost":{"ed25519:a_vyji":"Z4tpaW8f7NLd8iLuBErSna2EoleOu86i8wCEWSvOs26DNbZkOOyn3eVBT1fOB9X3Hn0FzyMTI7PSpDdltBHJCA"}},"unsigned":{"age_ts":1675796001894}}	3
$mAU9A94YjP4DM004IBnCOQl3huTesAnKbo1CkVX7wMg	!DaecDLDoTLOuqPWadN:localhost	{"token_id":6,"txn_id":"m1675796206032.2","historical":false}	{"auth_events":["$eOdfuP6TezgWF5799z0-muVXLh1k8LvHE2Wfob0cC3A","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg","$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E"],"prev_events":["$dmuQAnknZxpgqjpjtYIvJcdnBBRW5Te8hQ85WDS7uEw"],"type":"m.room.message","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@user1.matrix:localhost","content":{"msgtype":"m.text","body":"hej"},"depth":15,"origin":"localhost","origin_server_ts":1675796206110,"hashes":{"sha256":"/3LlsjKLp/kVESB9v42AghqjztmwY28dy5mrTpVdCg4"},"signatures":{"localhost":{"ed25519:a_vyji":"rneEXxAKJYoJbOY38nGPcGmH1sD5o+qp4kNeE3uinAXwkEf6yqxJNcYoAJ/wSt6ox5Z0q1JjwnKHkf0pq/5ACg"}},"unsigned":{"age_ts":1675796206110}}	3
$yGEzNJBRRycOk7KUDyR_XFaYOvJ4Hi44-bm0_UqUCeE	!DaecDLDoTLOuqPWadN:localhost	{"token_id":6,"txn_id":"m1675796781564.3","historical":false}	{"auth_events":["$eOdfuP6TezgWF5799z0-muVXLh1k8LvHE2Wfob0cC3A","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg","$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E"],"prev_events":["$mAU9A94YjP4DM004IBnCOQl3huTesAnKbo1CkVX7wMg"],"type":"m.room.message","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@user1.matrix:localhost","content":{"msgtype":"m.text","body":"ok"},"depth":16,"origin":"localhost","origin_server_ts":1675796781642,"hashes":{"sha256":"R0qLO7yhN87a4F4uA7QHGLUceMw9CV/S2rGc/urJT5c"},"signatures":{"localhost":{"ed25519:a_vyji":"co0Gni/17//J5/qV/7E2iKXcw/d+AHJJXghXA/jsLW6nHFNSE32fmir9oZ0SBgVdiI8jFUajm6WvE03P6oOpDQ"}},"unsigned":{"age_ts":1675796781642}}	3
$SCwfg4xWBzxHVcFLtW1DbcDU4LMVkfgjYJG-qdUypcM	!ZAIhwwJJQkZbVCWAWl:localhost	{"token_id":6,"historical":false}	{"auth_events":[],"prev_events":[],"type":"m.room.create","room_id":"!ZAIhwwJJQkZbVCWAWl:localhost","sender":"@user1.matrix:localhost","content":{"room_version":"9","creator":"@user1.matrix:localhost"},"depth":1,"state_key":"","origin":"localhost","origin_server_ts":1675797059975,"hashes":{"sha256":"Bjr4bEA2UT+NKk4yd48L2oThAvVoRapRQBdKJCHgoLk"},"signatures":{"localhost":{"ed25519:a_vyji":"33wwg54AHsjoGVVOf6JeA3gDyTUGGT3PWY3nsz/AAOVX/vvuN+HuTWOyVWgC4kzspFPb48A7GMSZvo5UZAfLBQ"}},"unsigned":{"age_ts":1675797059975}}	3
$RB7fKTVNYlqIOEPsSHLuZd4VtyQWzJBKjadsEKrzboc	!ZAIhwwJJQkZbVCWAWl:localhost	{"token_id":6,"historical":false}	{"auth_events":["$SCwfg4xWBzxHVcFLtW1DbcDU4LMVkfgjYJG-qdUypcM"],"prev_events":["$SCwfg4xWBzxHVcFLtW1DbcDU4LMVkfgjYJG-qdUypcM"],"type":"m.room.member","room_id":"!ZAIhwwJJQkZbVCWAWl:localhost","sender":"@user1.matrix:localhost","content":{"membership":"join","displayname":"user1.matrix"},"depth":2,"state_key":"@user1.matrix:localhost","origin":"localhost","origin_server_ts":1675797060104,"hashes":{"sha256":"qs+Ij3Aljzi+ReTrSkDZydCdyEiVyZ9fpZlECqddDGs"},"signatures":{"localhost":{"ed25519:a_vyji":"F4Qf1tU/HxkE6ICr715yCCovBBap6nZ9A1x6F7ME87aPcf9SxMzblf0kpYhl0sfocV8UuP/4ULK1I7YwBhn2BA"}},"unsigned":{"age_ts":1675797060104}}	3
$VypxR6iKVehL3VR2C035y9gijIu-KXtOmJ85mKX9XLI	!ZAIhwwJJQkZbVCWAWl:localhost	{"token_id":6,"historical":false}	{"auth_events":["$RB7fKTVNYlqIOEPsSHLuZd4VtyQWzJBKjadsEKrzboc","$SCwfg4xWBzxHVcFLtW1DbcDU4LMVkfgjYJG-qdUypcM"],"prev_events":["$RB7fKTVNYlqIOEPsSHLuZd4VtyQWzJBKjadsEKrzboc"],"type":"m.room.power_levels","room_id":"!ZAIhwwJJQkZbVCWAWl:localhost","sender":"@user1.matrix:localhost","content":{"users":{"@user1.matrix:localhost":100},"users_default":0,"events":{"m.room.name":50,"m.room.power_levels":100,"m.room.history_visibility":100,"m.room.canonical_alias":50,"m.room.avatar":50,"m.room.tombstone":100,"m.room.server_acl":100,"m.room.encryption":100},"events_default":0,"state_default":50,"ban":50,"kick":50,"redact":50,"invite":50,"historical":100},"depth":3,"state_key":"","origin":"localhost","origin_server_ts":1675797060239,"hashes":{"sha256":"qjTn6L1BgwR/VrwJuf/xx5d8UTpSBpc8uEmq71ommWo"},"signatures":{"localhost":{"ed25519:a_vyji":"qcyzciowXWc4DxFINiHTT3vNWPf5qxwTSgPjaxa684UmY6hOgta9wy3vYtJKWyfsx/422Obvocnd87ib0NSgAA"}},"unsigned":{"age_ts":1675797060239}}	3
$qx1E7MsFRdI9CbDeDYHg3A8XeN6MXU2rkBGCoxPB5mw	!ZAIhwwJJQkZbVCWAWl:localhost	{"token_id":6,"historical":false}	{"auth_events":["$RB7fKTVNYlqIOEPsSHLuZd4VtyQWzJBKjadsEKrzboc","$SCwfg4xWBzxHVcFLtW1DbcDU4LMVkfgjYJG-qdUypcM","$VypxR6iKVehL3VR2C035y9gijIu-KXtOmJ85mKX9XLI"],"prev_events":["$VypxR6iKVehL3VR2C035y9gijIu-KXtOmJ85mKX9XLI"],"type":"m.room.canonical_alias","room_id":"!ZAIhwwJJQkZbVCWAWl:localhost","sender":"@user1.matrix:localhost","content":{"alias":"#public-room1:localhost"},"depth":4,"state_key":"","origin":"localhost","origin_server_ts":1675797060301,"hashes":{"sha256":"R9N5mp8n7hxwWeEUnpZXCqRX/T+l7CXsBh1msCFwDM4"},"signatures":{"localhost":{"ed25519:a_vyji":"nP6asoadHgo2s1F87JcMnv+N/+Fuz00EPL9u6cfWuZ5vNth5/KNWHXq2fH6lqxzw/lkRvy7iZIN4E//w6C7DBQ"}},"unsigned":{"age_ts":1675797060301}}	3
$1kUMRxz6Q6tB2pRvD-yuOBQbj2dooMjTGymKWTyL_I0	!ZAIhwwJJQkZbVCWAWl:localhost	{"token_id":6,"historical":false}	{"auth_events":["$RB7fKTVNYlqIOEPsSHLuZd4VtyQWzJBKjadsEKrzboc","$SCwfg4xWBzxHVcFLtW1DbcDU4LMVkfgjYJG-qdUypcM","$VypxR6iKVehL3VR2C035y9gijIu-KXtOmJ85mKX9XLI"],"prev_events":["$qx1E7MsFRdI9CbDeDYHg3A8XeN6MXU2rkBGCoxPB5mw"],"type":"m.room.join_rules","room_id":"!ZAIhwwJJQkZbVCWAWl:localhost","sender":"@user1.matrix:localhost","content":{"join_rule":"public"},"depth":5,"state_key":"","origin":"localhost","origin_server_ts":1675797060344,"hashes":{"sha256":"GVpJ0msSIv0m7P5sw/HvMdAEQQ/yiQIa64cAfGR0ma4"},"signatures":{"localhost":{"ed25519:a_vyji":"EnjVkZvxeAKvyjCyOwCD+taJ17YGxLaGn5wD7fDb5O7p2qRM6d/rtBtJHKyAOAoIbj/zfy4BXOL1RUi5hVSIAg"}},"unsigned":{"age_ts":1675797060344}}	3
$MWD--uqyNXbmKDBMJob9sDY5AM4riTmkAwwz36FIaPk	!ZAIhwwJJQkZbVCWAWl:localhost	{"token_id":6,"historical":false}	{"auth_events":["$RB7fKTVNYlqIOEPsSHLuZd4VtyQWzJBKjadsEKrzboc","$SCwfg4xWBzxHVcFLtW1DbcDU4LMVkfgjYJG-qdUypcM","$VypxR6iKVehL3VR2C035y9gijIu-KXtOmJ85mKX9XLI"],"prev_events":["$1kUMRxz6Q6tB2pRvD-yuOBQbj2dooMjTGymKWTyL_I0"],"type":"m.room.history_visibility","room_id":"!ZAIhwwJJQkZbVCWAWl:localhost","sender":"@user1.matrix:localhost","content":{"history_visibility":"shared"},"depth":6,"state_key":"","origin":"localhost","origin_server_ts":1675797060371,"hashes":{"sha256":"TDcNmK0EkBJ2wdE3qjimPNVF29WmtMQijKvpad1OCrY"},"signatures":{"localhost":{"ed25519:a_vyji":"Y3aHofXi4GNW+NFiNB29qdKSN3uyjfGz+eKvTJqJrieLiXEPf7I63X7kRFhQF4NpmW4FZckvsMhXC4XTT/vMBg"}},"unsigned":{"age_ts":1675797060371}}	3
$a1xA663y2WchzA_Q5jmTKVlInC_HDgPTK8C2g37ysdk	!ZAIhwwJJQkZbVCWAWl:localhost	{"token_id":6,"historical":false}	{"auth_events":["$RB7fKTVNYlqIOEPsSHLuZd4VtyQWzJBKjadsEKrzboc","$SCwfg4xWBzxHVcFLtW1DbcDU4LMVkfgjYJG-qdUypcM","$VypxR6iKVehL3VR2C035y9gijIu-KXtOmJ85mKX9XLI"],"prev_events":["$MWD--uqyNXbmKDBMJob9sDY5AM4riTmkAwwz36FIaPk"],"type":"m.room.name","room_id":"!ZAIhwwJJQkZbVCWAWl:localhost","sender":"@user1.matrix:localhost","content":{"name":"#public-room1"},"depth":7,"state_key":"","origin":"localhost","origin_server_ts":1675797060838,"hashes":{"sha256":"zryCIQwlZAXwfwGUgvOkzvnm2JQNGnPw42Wzrzq0qmA"},"signatures":{"localhost":{"ed25519:a_vyji":"Q1G7Meph17qe4rqdMdEdRnKml15CBPV/iw8QF8GudZgkbpDC+6+WChKSgk5gcj0+u4KTO3BHdM3VFyA0pkHDDg"}},"unsigned":{"age_ts":1675797060838}}	3
$wdUPyT-0i7vmiiPz1WNunqvPAIWSfFtnwV1OizPIkvg	!ZAIhwwJJQkZbVCWAWl:localhost	{"historical":false}	{"auth_events":["$SCwfg4xWBzxHVcFLtW1DbcDU4LMVkfgjYJG-qdUypcM","$VypxR6iKVehL3VR2C035y9gijIu-KXtOmJ85mKX9XLI","$1kUMRxz6Q6tB2pRvD-yuOBQbj2dooMjTGymKWTyL_I0"],"prev_events":["$MWD--uqyNXbmKDBMJob9sDY5AM4riTmkAwwz36FIaPk"],"type":"m.room.member","room_id":"!ZAIhwwJJQkZbVCWAWl:localhost","sender":"@matterbot:localhost","content":{"reason":"Needed for Application Service","membership":"join","displayname":"Mattermost Bridge"},"depth":7,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675797061080,"hashes":{"sha256":"MRrWRbPDExmepFDdG8DN7y50/JnE/g4hPMLMRDNgSP4"},"signatures":{"localhost":{"ed25519:a_vyji":"NUqmR6h0srmTtJVpuD7M12PdWCaFfacZsr/BgfXo39KGPcxrUZq/HeEx8WdC6bxbI3AaWYtyt4pEoCwlclaqAA"}},"unsigned":{"age_ts":1675797061080}}	3
$kULillGfRc9dmdALLVuNmIhsQ0DV5vjLVAQvpHNKHG8	!ZAIhwwJJQkZbVCWAWl:localhost	{"token_id":6,"txn_id":"m1675797081086.4","historical":false}	{"auth_events":["$RB7fKTVNYlqIOEPsSHLuZd4VtyQWzJBKjadsEKrzboc","$SCwfg4xWBzxHVcFLtW1DbcDU4LMVkfgjYJG-qdUypcM","$VypxR6iKVehL3VR2C035y9gijIu-KXtOmJ85mKX9XLI"],"prev_events":["$a1xA663y2WchzA_Q5jmTKVlInC_HDgPTK8C2g37ysdk","$wdUPyT-0i7vmiiPz1WNunqvPAIWSfFtnwV1OizPIkvg"],"type":"m.room.message","room_id":"!ZAIhwwJJQkZbVCWAWl:localhost","sender":"@user1.matrix:localhost","content":{"msgtype":"m.text","body":"klklkl"},"depth":8,"origin":"localhost","origin_server_ts":1675797081159,"hashes":{"sha256":"l0ATCj/cRcnbn3JKdb91X/Extic9GdfBkDERkggXJUE"},"signatures":{"localhost":{"ed25519:a_vyji":"3nGWy4p4Ez59nkhNG9GOa9K2LSyFug79f4btEp2cyTRJEdmIbwwLYH7GBVGDValtYzjCXkf6fiUi9DjTDLO3DA"}},"unsigned":{"age_ts":1675797081159}}	3
$al7p9tH0ZoT5Yu3HsYz1r2ak-9HkXf2coQ7KKeBerUk	!ZAIhwwJJQkZbVCWAWl:localhost	{"token_id":6,"historical":false}	{"auth_events":["$VypxR6iKVehL3VR2C035y9gijIu-KXtOmJ85mKX9XLI","$RB7fKTVNYlqIOEPsSHLuZd4VtyQWzJBKjadsEKrzboc","$SCwfg4xWBzxHVcFLtW1DbcDU4LMVkfgjYJG-qdUypcM","$1kUMRxz6Q6tB2pRvD-yuOBQbj2dooMjTGymKWTyL_I0"],"prev_events":["$kULillGfRc9dmdALLVuNmIhsQ0DV5vjLVAQvpHNKHG8"],"type":"m.room.member","room_id":"!ZAIhwwJJQkZbVCWAWl:localhost","sender":"@user1.matrix:localhost","content":{"membership":"invite","displayname":"admin [mm]"},"depth":9,"state_key":"@mm_admin:localhost","origin":"localhost","origin_server_ts":1675797190163,"hashes":{"sha256":"BAyV1lQx3+NQ8qkgKL4781crFisIMkurrfG39EAntCY"},"signatures":{"localhost":{"ed25519:a_vyji":"QoUjrcjP+FnnhvRH4jZ9ElvWrD4W9Ca8lrrqJwS45MJcHotfBJeJFo0OhcKv/xaEe1qybesuJS81YdreFBT8Bw"}},"unsigned":{"age_ts":1675797190163,"invite_room_state":[{"type":"m.room.canonical_alias","state_key":"","content":{"alias":"#public-room1:localhost"},"sender":"@user1.matrix:localhost"},{"type":"m.room.create","state_key":"","content":{"room_version":"9","creator":"@user1.matrix:localhost"},"sender":"@user1.matrix:localhost"},{"type":"m.room.join_rules","state_key":"","content":{"join_rule":"public"},"sender":"@user1.matrix:localhost"},{"type":"m.room.name","state_key":"","content":{"name":"#public-room1"},"sender":"@user1.matrix:localhost"},{"type":"m.room.member","state_key":"@user1.matrix:localhost","content":{"membership":"join","displayname":"user1.matrix"},"sender":"@user1.matrix:localhost"}]}}	3
$isvqtAkok4JAN-_OZRt7MG_xv-fWABZbUbvVPhtzjUI	!ZAIhwwJJQkZbVCWAWl:localhost	{"token_id":6,"txn_id":"m1675797271047.5","historical":false}	{"auth_events":["$RB7fKTVNYlqIOEPsSHLuZd4VtyQWzJBKjadsEKrzboc","$SCwfg4xWBzxHVcFLtW1DbcDU4LMVkfgjYJG-qdUypcM","$VypxR6iKVehL3VR2C035y9gijIu-KXtOmJ85mKX9XLI"],"prev_events":["$al7p9tH0ZoT5Yu3HsYz1r2ak-9HkXf2coQ7KKeBerUk"],"type":"m.room.message","room_id":"!ZAIhwwJJQkZbVCWAWl:localhost","sender":"@user1.matrix:localhost","content":{"msgtype":"m.text","body":"ok"},"depth":10,"origin":"localhost","origin_server_ts":1675797271149,"hashes":{"sha256":"2E+LM8plZz6WA+UT/qvGeof/5Dt7r6iWq7CmDigM9LQ"},"signatures":{"localhost":{"ed25519:a_vyji":"HL517GeiLEDIZmXFKnNIauBalE7WTQA4UqGL9TRU7ViIVMfhrcGlmbAqNVjDsQOOSK+ZY4Wa7Jt6IB9ZERfGDw"}},"unsigned":{"age_ts":1675797271149}}	3
$E44xF_r_bYO9HOH-lw-VkWepvoS6z9dxDWthhfbpT9M	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM","$ykL4uD4FNcb8S_8kQpwbthwvqPKRzD_pJ3jyfA-5ywc","$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM","$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok"],"prev_events":["$4Wo5EetfrJ0oD7aWVI6CvS_-ZUM3lsyzkFZeQElMcmI"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@matterbot:localhost","content":{"reason":"joining room","membership":"join","displayname":"Mattermost Bridge"},"depth":14,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675814024531,"hashes":{"sha256":"GwvVvVGC+g2g3QqbwPDYcDy9iFHBvjN7evbF3AZU3oc"},"signatures":{"localhost":{"ed25519:a_vyji":"qvgeTtXDtpoO7+xpvfiuGOtZO2Dm9xFpLRXmXdgp87N0iBK6oWJDXZMEUnQCiDeuWr19Wm/xizgmz4cne4ZFBg"}},"unsigned":{"age_ts":1675814024531,"replaces_state":"$ykL4uD4FNcb8S_8kQpwbthwvqPKRzD_pJ3jyfA-5ywc"}}	3
$PksohbU2dYCXTn5ETrl9bIqsEVAPP0Wohp--_6XwmYg	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg","$06pNLPsFn-fF2WbziopICIA6qaey-LFJhiTAHGfqJS4","$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY","$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E"],"prev_events":["$yGEzNJBRRycOk7KUDyR_XFaYOvJ4Hi44-bm0_UqUCeE"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"reason":"joining room","membership":"join","displayname":"Mattermost Bridge"},"depth":17,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675814024538,"hashes":{"sha256":"uXdQ5egBjOUa3zpatCfAazw3Si10Zyh+j8qRqZwBJiw"},"signatures":{"localhost":{"ed25519:a_vyji":"8J9tyISS1dIZv6r4APHppXkXg5phLEyJYyN0ykMUhxOVWvScphvC1kvkDPYHfyYvYX4loVUV7leoXY342Xq1DA"}},"unsigned":{"age_ts":1675814024538,"replaces_state":"$06pNLPsFn-fF2WbziopICIA6qaey-LFJhiTAHGfqJS4"}}	3
$ycR02cfa_D8mViUfnzHTBMWRlLibcN2pYZDwiiQUt8I	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg","$PksohbU2dYCXTn5ETrl9bIqsEVAPP0Wohp--_6XwmYg","$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY","$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E"],"prev_events":["$PksohbU2dYCXTn5ETrl9bIqsEVAPP0Wohp--_6XwmYg"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"reason":"Needed for app service","membership":"join","displayname":"Mattermost Bridge"},"depth":18,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675814025884,"hashes":{"sha256":"AoyhTwVJ0ZMXbryRwodx4sAw6YgQ0B+j6K4VmJBFL2s"},"signatures":{"localhost":{"ed25519:a_vyji":"878PdYwMF7R4IA24cfMECgX8t5QZXWoeS+yDViwj+FwufNotvCeul2R1L+KLyNcVCSwlUNdg+pCVfFLIHRijDw"}},"unsigned":{"age_ts":1675814025884,"replaces_state":"$PksohbU2dYCXTn5ETrl9bIqsEVAPP0Wohp--_6XwmYg"}}	3
$fuPA22emW4V0wHC5EllCh7JbzYMhTIW0DLr_D73YRtU	!DaecDLDoTLOuqPWadN:localhost	{"token_id":6,"txn_id":"m1675814070660.52","historical":false}	{"auth_events":["$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg","$eOdfuP6TezgWF5799z0-muVXLh1k8LvHE2Wfob0cC3A","$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E"],"prev_events":["$ycR02cfa_D8mViUfnzHTBMWRlLibcN2pYZDwiiQUt8I"],"type":"m.room.message","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@user1.matrix:localhost","content":{"msgtype":"m.text","body":"ok kl"},"depth":19,"origin":"localhost","origin_server_ts":1675814070751,"hashes":{"sha256":"fb1lrLk2Xx20ha3BY16QkLQ2Zc3UM9fzS41483FMEeE"},"signatures":{"localhost":{"ed25519:a_vyji":"M0Th+D5EDglECNYncB8NrFQNmRb6FaW/KKXMVR4e9N4/RlqKDgQnn2pv6l9RiIH0kMY3HhyVH4Ku4FVN3F4vBw"}},"unsigned":{"age_ts":1675814070751}}	3
$iZZW6EsuxUAxVBXtwcMnKFWoQkFHMXw7rvUqBVZ0wOM	!DaecDLDoTLOuqPWadN:localhost	{"txn_id":"m1675814080493","historical":false}	{"auth_events":["$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg","$ycR02cfa_D8mViUfnzHTBMWRlLibcN2pYZDwiiQUt8I","$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E"],"prev_events":["$fuPA22emW4V0wHC5EllCh7JbzYMhTIW0DLr_D73YRtU"],"type":"m.room.message","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"body":"jkjk jkj","msgtype":"m.text"},"depth":20,"origin":"localhost","origin_server_ts":1675814080545,"hashes":{"sha256":"0dEGir6DBWew867XuLC3HTDGcx1MJw18HLSnp6cbhUo"},"signatures":{"localhost":{"ed25519:a_vyji":"89DrvfG/N9RwAzNgLKqjBSyVQtVBGg+4euuTlndQmnvLomOnhMr3Y9YXibemppltXTN0BO3FHQpbkrqdz0xhDQ"}},"unsigned":{"age_ts":1675814080545}}	3
$4EiubgnrkRAh09BKQLVXOeE9xGDhNpI_objrHMKclmA	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$ycR02cfa_D8mViUfnzHTBMWRlLibcN2pYZDwiiQUt8I","$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg"],"prev_events":["$iZZW6EsuxUAxVBXtwcMnKFWoQkFHMXw7rvUqBVZ0wOM"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"reason":"joining room","membership":"join","displayname":"Mattermost Bridge"},"depth":21,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675877263513,"hashes":{"sha256":"x1lNMGk8QQZCj4XhTOEIEPBQIKT4CkGtHPc4P/+gTnM"},"signatures":{"localhost":{"ed25519:a_vyji":"5dWS75z36N4Shz0svJfizH23X7VGrHiXBLS+eJYQJOOAOewpVlYW3qFz/1ZlobOn/KC2WWvyFjwR54cZdxBuAA"}},"unsigned":{"age_ts":1675877263513,"replaces_state":"$ycR02cfa_D8mViUfnzHTBMWRlLibcN2pYZDwiiQUt8I"}}	3
$9-LSz3ddCTGWUa1IWqJRNNSh2mJrY7YVMY_uo340Sek	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok","$E44xF_r_bYO9HOH-lw-VkWepvoS6z9dxDWthhfbpT9M","$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM"],"prev_events":["$E44xF_r_bYO9HOH-lw-VkWepvoS6z9dxDWthhfbpT9M"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@matterbot:localhost","content":{"reason":"Needed for app service","membership":"join","displayname":"Mattermost Bridge"},"depth":15,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675877264138,"hashes":{"sha256":"eFgsq3l2l3CLS36uRQLQvEhaqJ+RXm9f9E+cylCb5/0"},"signatures":{"localhost":{"ed25519:a_vyji":"VT++EcKmCQJyXWlC+zkIWJYY1uu8VBTfN+ntsJWzbbVhTM/zmzQ7qY+NXAVVJF2zRTyLLDI/7s8WkYSWcbxGAg"}},"unsigned":{"age_ts":1675877264138,"replaces_state":"$E44xF_r_bYO9HOH-lw-VkWepvoS6z9dxDWthhfbpT9M"}}	3
$n7_pif4S0hNHmw6iRBbW8iOHiFYTB60HnOnp4zhPUiM	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$4EiubgnrkRAh09BKQLVXOeE9xGDhNpI_objrHMKclmA","$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg"],"prev_events":["$4EiubgnrkRAh09BKQLVXOeE9xGDhNpI_objrHMKclmA"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"reason":"Needed for app service","membership":"join","displayname":"Mattermost Bridge"},"depth":22,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675877264162,"hashes":{"sha256":"v7Abd6EJfj4Qt2vv05xVEflsasZOLvbbXE3Kw8LEfVU"},"signatures":{"localhost":{"ed25519:a_vyji":"lsTneq3rHWyHYpb/fG+g+xcruQVyw2c8CXUED3LpjJ9axuPlAQBcd8z7mUs3iSWTP2/wvhAZGVJADsKYMIqlDA"}},"unsigned":{"age_ts":1675877264162,"replaces_state":"$4EiubgnrkRAh09BKQLVXOeE9xGDhNpI_objrHMKclmA"}}	3
$a185DaoMSzelXmfPlkcYOe3H3zITI_nFoVFWjnPmTu8	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok","$9-LSz3ddCTGWUa1IWqJRNNSh2mJrY7YVMY_uo340Sek","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM"],"prev_events":["$9-LSz3ddCTGWUa1IWqJRNNSh2mJrY7YVMY_uo340Sek"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@matterbot:localhost","content":{"reason":"leaving room","membership":"leave"},"depth":16,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675877264344,"hashes":{"sha256":"FXISZy88FCpYv0TXw8wKa1aqMoTUZ6tQZTtX5t9z4CA"},"signatures":{"localhost":{"ed25519:a_vyji":"JAeslMdXeFt+N6jvTxNSSI1BnmgDOJV6P0njFSfJ7MMzzBa72D7lCzFCQfkc8T2C+uM2Hbz3fLo5+aR1JrAYCg"}},"unsigned":{"age_ts":1675877264344,"replaces_state":"$9-LSz3ddCTGWUa1IWqJRNNSh2mJrY7YVMY_uo340Sek"}}	3
$Y6Vh2Kkasecp6HyMWxXbvX7gYSqrx6mIGOOROWKR1Hs	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$n7_pif4S0hNHmw6iRBbW8iOHiFYTB60HnOnp4zhPUiM","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg"],"prev_events":["$n7_pif4S0hNHmw6iRBbW8iOHiFYTB60HnOnp4zhPUiM"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"reason":"leaving room","membership":"leave"},"depth":23,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675877264424,"hashes":{"sha256":"d1owZvdcURkbZZecFaS0unCpI70xOcYQc3zn8dLZ4D0"},"signatures":{"localhost":{"ed25519:a_vyji":"VypcfAMtCa4BhPjbD04ZwdY7VHlUS1me/2ct08rri3T06wICqofP19qgzDZHraG7c8yRjnP2EoBTxsJ1v5MxDQ"}},"unsigned":{"age_ts":1675877264424,"replaces_state":"$n7_pif4S0hNHmw6iRBbW8iOHiFYTB60HnOnp4zhPUiM"}}	3
$tvfSz5Kqzjfh39pYs3yfctIZoJQ09aOzDx4YZvZDlyc	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok","$a185DaoMSzelXmfPlkcYOe3H3zITI_nFoVFWjnPmTu8","$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM"],"prev_events":["$a185DaoMSzelXmfPlkcYOe3H3zITI_nFoVFWjnPmTu8"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@matterbot:localhost","content":{"reason":"joining room","membership":"join","displayname":"Mattermost Bridge"},"depth":17,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675877556164,"hashes":{"sha256":"LWleXSH6msg526dEaSw9QLo3W8R6kroupklvn0JsVfQ"},"signatures":{"localhost":{"ed25519:a_vyji":"Gz6/qOJays4jQZkj+6DIIkEZOXf86D/twsndgwmhkjJV2mR92yORMj9FU0kFKOtaEjnsrkOcwmip3aY5cmsZBA"}},"unsigned":{"age_ts":1675877556164,"replaces_state":"$a185DaoMSzelXmfPlkcYOe3H3zITI_nFoVFWjnPmTu8"}}	3
$84NzkDN2QGVP9qS7o_z1qOhaHe5-fSbz4Vs2SiNDPo0	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$Y6Vh2Kkasecp6HyMWxXbvX7gYSqrx6mIGOOROWKR1Hs","$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg"],"prev_events":["$Y6Vh2Kkasecp6HyMWxXbvX7gYSqrx6mIGOOROWKR1Hs"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"reason":"joining room","membership":"join","displayname":"Mattermost Bridge"},"depth":24,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675877556153,"hashes":{"sha256":"I0aWzJXYwe9FiBPHq27GkyrIArR0M3KPRY/UR4lnbnI"},"signatures":{"localhost":{"ed25519:a_vyji":"ickcFLj0e5HQ3YNXe1BzbfkhVm5Ic1eWzztZLHvozGDNJYc/yHSLHggNhatpFddvYjidPQjI2/umETRwqOF5Dg"}},"unsigned":{"age_ts":1675877556153,"replaces_state":"$Y6Vh2Kkasecp6HyMWxXbvX7gYSqrx6mIGOOROWKR1Hs"}}	3
$HvHWZQ09kf-ICUV-Ar9JELFLWq2tJUi2ull2GBzbx9U	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok","$DhWWh8GrURTFDa120InvAq5u-MKwyslHHOkRAcsUhaQ","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM"],"prev_events":["$DhWWh8GrURTFDa120InvAq5u-MKwyslHHOkRAcsUhaQ"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@matterbot:localhost","content":{"reason":"leaving room","membership":"leave"},"depth":19,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675877556899,"hashes":{"sha256":"2AV5leaNbsX7hdT44B8/KNO4fCz4JrQp2lqoFEPJv4E"},"signatures":{"localhost":{"ed25519:a_vyji":"ruoBroxMQcCxb28ceb3qoc2li91Wi8/B4LNasYUq8+kSi25BUH4JJY9+x5XlT869MBcnWfXYACTPNEPvAoNZCQ"}},"unsigned":{"age_ts":1675877556899,"replaces_state":"$DhWWh8GrURTFDa120InvAq5u-MKwyslHHOkRAcsUhaQ"}}	3
$oU5B1qtEraaFCsivi4-r4WT9WGSSBIzW-i7EDPYS-eE	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$84NzkDN2QGVP9qS7o_z1qOhaHe5-fSbz4Vs2SiNDPo0","$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg"],"prev_events":["$84NzkDN2QGVP9qS7o_z1qOhaHe5-fSbz4Vs2SiNDPo0"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"reason":"Needed for app service","membership":"join","displayname":"Mattermost Bridge"},"depth":25,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675877556701,"hashes":{"sha256":"zo2dtU3msCNa3ZHJ3ueMu5PbD1KgC4P20taVZkzkVdQ"},"signatures":{"localhost":{"ed25519:a_vyji":"7R7jHtpAmE+9NOiHg4tdHVnQf89ul9rRT68QWpemuNw43psIhmxwHErNCtd0Y1ZhlnaFZZRVdvX6qQZWK0w/CQ"}},"unsigned":{"age_ts":1675877556701,"replaces_state":"$84NzkDN2QGVP9qS7o_z1qOhaHe5-fSbz4Vs2SiNDPo0"}}	3
$DhWWh8GrURTFDa120InvAq5u-MKwyslHHOkRAcsUhaQ	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok","$tvfSz5Kqzjfh39pYs3yfctIZoJQ09aOzDx4YZvZDlyc","$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM"],"prev_events":["$tvfSz5Kqzjfh39pYs3yfctIZoJQ09aOzDx4YZvZDlyc"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@matterbot:localhost","content":{"reason":"Needed for app service","membership":"join","displayname":"Mattermost Bridge"},"depth":18,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675877556710,"hashes":{"sha256":"YQPB8UgdsRACLArw+fDFtodUAV1V7tWvNWPbU9k3etE"},"signatures":{"localhost":{"ed25519:a_vyji":"DP05AmvInR3wTaJukRy5buK7VQwK3I+YUSdinA0HgmTHjqV1+3CYQcA/ZPDxKh4D52cIPHzZhjelJKKcsr5BDg"}},"unsigned":{"age_ts":1675877556710,"replaces_state":"$tvfSz5Kqzjfh39pYs3yfctIZoJQ09aOzDx4YZvZDlyc"}}	3
$toF4I3EB1pERgvaXBIbhBugPExKQ2bOI0J6aOngeVI4	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$oU5B1qtEraaFCsivi4-r4WT9WGSSBIzW-i7EDPYS-eE","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg"],"prev_events":["$oU5B1qtEraaFCsivi4-r4WT9WGSSBIzW-i7EDPYS-eE"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"reason":"leaving room","membership":"leave"},"depth":26,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675877556893,"hashes":{"sha256":"YH3Ps4452TWt+2tOhPL1EVFIu6vcAWvmWXJN/F6mtvU"},"signatures":{"localhost":{"ed25519:a_vyji":"f5/qSNHi684mQ9agFaRaerOUogvK9NuB7UhyyPJLBxZZqrXfSCrnfmzLvUqBR6z9w3BaDOz5XmvRIMO3Ng51CA"}},"unsigned":{"age_ts":1675877556893,"replaces_state":"$oU5B1qtEraaFCsivi4-r4WT9WGSSBIzW-i7EDPYS-eE"}}	3
$81XepwsM4YptvtHgl3P5SaUSvkP94S2d7apqzJ78aFk	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok","$HvHWZQ09kf-ICUV-Ar9JELFLWq2tJUi2ull2GBzbx9U","$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM"],"prev_events":["$HvHWZQ09kf-ICUV-Ar9JELFLWq2tJUi2ull2GBzbx9U"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@matterbot:localhost","content":{"reason":"joining room","membership":"join","displayname":"Mattermost Bridge"},"depth":20,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675877728354,"hashes":{"sha256":"cvkzkWZrW5EJlHGhgoVcPxU2i12EzP84KvQg9oNF03g"},"signatures":{"localhost":{"ed25519:a_vyji":"Zhl2KBlVnbCtW0JQZlVI8GW7o7GUWpYINWUuoMfVdvRpuUos9lZvZOtQYQirxYIFCqPfTFuRqUcoe7VW3qvKDA"}},"unsigned":{"age_ts":1675877728354,"replaces_state":"$HvHWZQ09kf-ICUV-Ar9JELFLWq2tJUi2ull2GBzbx9U"}}	3
$4ODGclJajZc3SV1KXAMLeoAZrYyBdfzBaT-uorLgyJ8	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$toF4I3EB1pERgvaXBIbhBugPExKQ2bOI0J6aOngeVI4","$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg"],"prev_events":["$toF4I3EB1pERgvaXBIbhBugPExKQ2bOI0J6aOngeVI4"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"reason":"joining room","membership":"join","displayname":"Mattermost Bridge"},"depth":27,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675877728363,"hashes":{"sha256":"hgh/St/tIvY/z9RURbNKzV4dHPxQs+uhRGkG68aZoT0"},"signatures":{"localhost":{"ed25519:a_vyji":"oy1XEmhWhdXpiWM5Sr1mt9M3SFy/QOWISYFrIbNscN4gNH5l7E8vzAy6H+ial19NGDESYVoMDuTOWUdXbChDBA"}},"unsigned":{"age_ts":1675877728363,"replaces_state":"$toF4I3EB1pERgvaXBIbhBugPExKQ2bOI0J6aOngeVI4"}}	3
$dL0sqD6DHzPvOsuGJe1kcseFEXgtsK3Q59XyD3PJVk4	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok","$81XepwsM4YptvtHgl3P5SaUSvkP94S2d7apqzJ78aFk","$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM"],"prev_events":["$81XepwsM4YptvtHgl3P5SaUSvkP94S2d7apqzJ78aFk"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@matterbot:localhost","content":{"reason":"Needed for app service","membership":"join","displayname":"Mattermost Bridge"},"depth":21,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675877728843,"hashes":{"sha256":"kNZadIod5KWC+r8hpOOtK04F+m6vwSnQH2plv3PS5WU"},"signatures":{"localhost":{"ed25519:a_vyji":"WDgVO1pFK0NYT/dzc0pbZ18fFPxEhyrxiaVclbKfnyIiMFmcYL9TTFk8bqg9/vWKiJ7m2NmkK526OysDu9BKDg"}},"unsigned":{"age_ts":1675877728843,"replaces_state":"$81XepwsM4YptvtHgl3P5SaUSvkP94S2d7apqzJ78aFk"}}	3
$Pk6fFbdC0REz3T43EROb2OhYqN4o1ptnYGXXeyMDxkE	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$4ODGclJajZc3SV1KXAMLeoAZrYyBdfzBaT-uorLgyJ8","$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg"],"prev_events":["$4ODGclJajZc3SV1KXAMLeoAZrYyBdfzBaT-uorLgyJ8"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"reason":"Needed for app service","membership":"join","displayname":"Mattermost Bridge"},"depth":28,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675877728845,"hashes":{"sha256":"mDiCtSdgDiEYi9PmyG/GyOBI8wp6wCPqBtGC54+thkw"},"signatures":{"localhost":{"ed25519:a_vyji":"w8KDMX0z0nd2boe189CKTWPEixokswFLUm0eKUPjrEo6JqMEC0BZS/GMQcgCndLgWDDzAIVmKTgXDUka7N+tBw"}},"unsigned":{"age_ts":1675877728845,"replaces_state":"$4ODGclJajZc3SV1KXAMLeoAZrYyBdfzBaT-uorLgyJ8"}}	3
$DsB5975yzOpruMKKVBUYRHB3MSljJYHh3p7763sNf2I	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok","$dL0sqD6DHzPvOsuGJe1kcseFEXgtsK3Q59XyD3PJVk4","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM"],"prev_events":["$dL0sqD6DHzPvOsuGJe1kcseFEXgtsK3Q59XyD3PJVk4"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@matterbot:localhost","content":{"reason":"leaving room","membership":"leave"},"depth":22,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675877729024,"hashes":{"sha256":"8Oc0zhxpM97+psNshrm5Y+3+nrZevhiIXr40pNspSkM"},"signatures":{"localhost":{"ed25519:a_vyji":"nbJ6Lw1sp2utH3Lu/t2Q4EMT9KHkXYcQ4WCOsUihUoQ3zrgB6sCBMzzlHR4IiyMikj2eGZDsZrWjtD75lVWACQ"}},"unsigned":{"age_ts":1675877729024,"replaces_state":"$dL0sqD6DHzPvOsuGJe1kcseFEXgtsK3Q59XyD3PJVk4"}}	3
$7Op41p6mCUbcp5TuaBcCF4mMRwPYz6lWW7a943BDG8o	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$Pk6fFbdC0REz3T43EROb2OhYqN4o1ptnYGXXeyMDxkE","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg"],"prev_events":["$Pk6fFbdC0REz3T43EROb2OhYqN4o1ptnYGXXeyMDxkE"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"reason":"leaving room","membership":"leave"},"depth":29,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675877729058,"hashes":{"sha256":"OCxLCPvVmsE+WqXGXnOgzQPaA4s6ANaupTycDD+Lnac"},"signatures":{"localhost":{"ed25519:a_vyji":"TW27/5gJrAHZJmU1eEC8Z0yWUbfHrnvgJqtuwa8t4iCJYSdIJ1GNJtnnD3XhXNGpP7LL6xH15KG+a/Ju3vCkCw"}},"unsigned":{"age_ts":1675877729058,"replaces_state":"$Pk6fFbdC0REz3T43EROb2OhYqN4o1ptnYGXXeyMDxkE"}}	3
$nD-WsmqnhEa4BIar13mUOspyj5CQ-NVfZYZo7aUnG8o	!DaecDLDoTLOuqPWadN:localhost	{"token_id":6,"txn_id":"m1675878048664.0","historical":false}	{"auth_events":["$eOdfuP6TezgWF5799z0-muVXLh1k8LvHE2Wfob0cC3A","$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg"],"prev_events":["$7Op41p6mCUbcp5TuaBcCF4mMRwPYz6lWW7a943BDG8o"],"type":"m.room.message","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@user1.matrix:localhost","content":{"msgtype":"m.text","body":"klklklkl"},"depth":30,"origin":"localhost","origin_server_ts":1675878048755,"hashes":{"sha256":"kuqk8UzU7Ibkkjemhi7JdR942PB/9AQCd/lL2if50dY"},"signatures":{"localhost":{"ed25519:a_vyji":"3fo/ehyKzYnO+mOCxxlW+Yc9biZpw/c9sRm3ZOKdlfy7SxOHqfCoeD8YtI95EB41K5ti94ivTvTydKN8MSIqBA"}},"unsigned":{"age_ts":1675878048755}}	3
$s1YwkJ0AvfbD0DFtp0NNPRSOEKYsrtf84Paq6r6Qn60	!ZAIhwwJJQkZbVCWAWl:localhost	{"token_id":6,"txn_id":"m1675878180964.1","historical":false}	{"auth_events":["$RB7fKTVNYlqIOEPsSHLuZd4VtyQWzJBKjadsEKrzboc","$VypxR6iKVehL3VR2C035y9gijIu-KXtOmJ85mKX9XLI","$SCwfg4xWBzxHVcFLtW1DbcDU4LMVkfgjYJG-qdUypcM"],"prev_events":["$isvqtAkok4JAN-_OZRt7MG_xv-fWABZbUbvVPhtzjUI"],"type":"m.room.message","room_id":"!ZAIhwwJJQkZbVCWAWl:localhost","sender":"@user1.matrix:localhost","content":{"msgtype":"m.text","body":"okoko"},"depth":11,"origin":"localhost","origin_server_ts":1675878181068,"hashes":{"sha256":"MBJOpCZsDfgk//As1Hs4ADABqvVmJ1HEE+bjAi7+2OY"},"signatures":{"localhost":{"ed25519:a_vyji":"a11+j9N3gMAKjZ7oZ9KJMRfxvgGVfLxsHuPfZ6ziFDmz+lurHDAH56B00udrQgsbxiegv6zRzm9VXaOhOqNMBQ"}},"unsigned":{"age_ts":1675878181068}}	3
$V4DFlazGXeBPWV65AAUJ4t5Qg3tYPqs8hY5TxXXOAg8	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$7Op41p6mCUbcp5TuaBcCF4mMRwPYz6lWW7a943BDG8o","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg","$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY"],"prev_events":["$nD-WsmqnhEa4BIar13mUOspyj5CQ-NVfZYZo7aUnG8o"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"reason":"joining room","membership":"join","displayname":"Mattermost Bridge"},"depth":31,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675878356410,"hashes":{"sha256":"fkamxSVEDg2AMknaDuUENOvWmbIbEyXnNYyW21IFPjo"},"signatures":{"localhost":{"ed25519:a_vyji":"xavBqx3MkKhwNPKm/wMLam7rCjMzuhjhN+Z2XD86HHJB1g1QbnbLKQ7yQcrQOGlcdIFRuzo6xqSrjVmgBz08AA"}},"unsigned":{"age_ts":1675878356410,"replaces_state":"$7Op41p6mCUbcp5TuaBcCF4mMRwPYz6lWW7a943BDG8o"}}	3
$4VQxBaDA6dKjPvqNVj95IwQXv3QL3a-bXdpp4EyG9yo	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok","$DsB5975yzOpruMKKVBUYRHB3MSljJYHh3p7763sNf2I","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM","$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM"],"prev_events":["$DsB5975yzOpruMKKVBUYRHB3MSljJYHh3p7763sNf2I"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@matterbot:localhost","content":{"reason":"joining room","membership":"join","displayname":"Mattermost Bridge"},"depth":23,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675878356414,"hashes":{"sha256":"LtcWV8SDBW79amXWHdEoexDIyCNZAcErWDzCNVDIrlI"},"signatures":{"localhost":{"ed25519:a_vyji":"r3ZLKJI9l6IRuXteyCVLUTsYNowKg2BuDEC20y8uyjeQa0vlDWSlh+GUIg8SrDKZfdV1sMTNcKbOxOkFtQEqCA"}},"unsigned":{"age_ts":1675878356414,"replaces_state":"$DsB5975yzOpruMKKVBUYRHB3MSljJYHh3p7763sNf2I"}}	3
$XLYrVIK-R-MtOR1YnQaG3APBProvOP79zhKQSr95HqE	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok","$4VQxBaDA6dKjPvqNVj95IwQXv3QL3a-bXdpp4EyG9yo","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM","$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM"],"prev_events":["$4VQxBaDA6dKjPvqNVj95IwQXv3QL3a-bXdpp4EyG9yo"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@matterbot:localhost","content":{"reason":"Needed for app service","membership":"join","displayname":"Mattermost Bridge"},"depth":24,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675878357193,"hashes":{"sha256":"NZOUt2lWAgmPbVxGSHj9nE+xSjjKaRnrvO30lIkuatc"},"signatures":{"localhost":{"ed25519:a_vyji":"Vkzk29RG8CcoYcWx3WsI4146J20PwmJg96DOSXFouphKUjIWb9bcHC90jgoEqPkKM+x3goGgmmno5t1hG9pJBg"}},"unsigned":{"age_ts":1675878357193,"replaces_state":"$4VQxBaDA6dKjPvqNVj95IwQXv3QL3a-bXdpp4EyG9yo"}}	3
$bm6jSsPXymAqmwjgIzaCnnJ6c2n_z2s5EzuLfrNVKvE	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$V4DFlazGXeBPWV65AAUJ4t5Qg3tYPqs8hY5TxXXOAg8","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg","$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY"],"prev_events":["$V4DFlazGXeBPWV65AAUJ4t5Qg3tYPqs8hY5TxXXOAg8"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"reason":"Needed for app service","membership":"join","displayname":"Mattermost Bridge"},"depth":32,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675878357183,"hashes":{"sha256":"+q0ff68zZ76Kdzk313QbmgRaxbcXth1Wa7COU6DxPdA"},"signatures":{"localhost":{"ed25519:a_vyji":"GDKcaLjAo4TxYOHrEN5EVaafKTCOHYmUSnHaCwELFFDCo9aL8sGw8WM8UNwA9Gc0IQPFRa1ZEV/sgqqMWY2tBw"}},"unsigned":{"age_ts":1675878357183,"replaces_state":"$V4DFlazGXeBPWV65AAUJ4t5Qg3tYPqs8hY5TxXXOAg8"}}	3
$qjaNmlKX4IG53qDAgTwuNoxohPKncklE70COvnTRmxc	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok","$XLYrVIK-R-MtOR1YnQaG3APBProvOP79zhKQSr95HqE","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM"],"prev_events":["$XLYrVIK-R-MtOR1YnQaG3APBProvOP79zhKQSr95HqE"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@matterbot:localhost","content":{"reason":"leaving room","membership":"leave"},"depth":25,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675878357445,"hashes":{"sha256":"f0MAVdNbD5yrlPGlusv4GNzjlVY5elkSDcuRNezXZHs"},"signatures":{"localhost":{"ed25519:a_vyji":"gHkBF+MEVGWGEE4Om98yG/dMmSOSVxWfUqPY3KOHquM5bvFJKDgtmGrZTqepx7CfEb9CFglSae8GySUUbChCBQ"}},"unsigned":{"age_ts":1675878357445,"replaces_state":"$XLYrVIK-R-MtOR1YnQaG3APBProvOP79zhKQSr95HqE"}}	3
$LgX6qWXYlaiVRDlpKJmG6b1DcgpCsOwZlJZ0c9LjXmw	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$bm6jSsPXymAqmwjgIzaCnnJ6c2n_z2s5EzuLfrNVKvE","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg"],"prev_events":["$bm6jSsPXymAqmwjgIzaCnnJ6c2n_z2s5EzuLfrNVKvE"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"reason":"leaving room","membership":"leave"},"depth":33,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675878357697,"hashes":{"sha256":"fQXmhebpf78UZjHGOUwK5nmNi+1leb9hb3T86YmS3s8"},"signatures":{"localhost":{"ed25519:a_vyji":"JpOYYDr++fmKGvWHs1d7H8MQLKNoqgjWmHUgZi23k5Igd/mXYCEWpoiB6T/aXhnX5keKdoOxhdKag6/cKDefDw"}},"unsigned":{"age_ts":1675878357697,"replaces_state":"$bm6jSsPXymAqmwjgIzaCnnJ6c2n_z2s5EzuLfrNVKvE"}}	3
$eKKl-y9GISjb7jjkVd_Vn_qgDxbMFvFS-A5GytvRyVA	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM","$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM","$qjaNmlKX4IG53qDAgTwuNoxohPKncklE70COvnTRmxc"],"prev_events":["$qjaNmlKX4IG53qDAgTwuNoxohPKncklE70COvnTRmxc"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@matterbot:localhost","content":{"reason":"joining room","membership":"join","displayname":"Mattermost Bridge"},"depth":26,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675879386540,"hashes":{"sha256":"jVNCYwTDLg9ZzPyQhQT6gJ+0dlwyW7MfXFrx5u4b3ws"},"signatures":{"localhost":{"ed25519:a_vyji":"Zb05r8oTcWL7ya/qk495IPwSkMaUaxWEjwSS/nYdzWQBA3pcidJ7vtW8YPDVaG6FQTBvTAKwSYcNcsV5EgOUBg"}},"unsigned":{"age_ts":1675879386540,"replaces_state":"$qjaNmlKX4IG53qDAgTwuNoxohPKncklE70COvnTRmxc"}}	3
$iT2ZJrZtDk-8_lxymECQMqYbECP_dXcTXNOuVCnSanc	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM","$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM","$eKKl-y9GISjb7jjkVd_Vn_qgDxbMFvFS-A5GytvRyVA"],"prev_events":["$eKKl-y9GISjb7jjkVd_Vn_qgDxbMFvFS-A5GytvRyVA"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@matterbot:localhost","content":{"reason":"Needed for app service","membership":"join","displayname":"Mattermost Bridge"},"depth":27,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675879387367,"hashes":{"sha256":"ur9gSM590/10nNPBhjOTjxPzn8zfLQAyhuAermrx1aw"},"signatures":{"localhost":{"ed25519:a_vyji":"CI5F2ExvqRFmYh/kr9Y31zNWHnsiuDTDa/TPzLYxCKHuLpFNoQ6MKsDF9iR6ZWxJx0gJII3aCYYOPUgsiKsFCw"}},"unsigned":{"age_ts":1675879387367,"replaces_state":"$eKKl-y9GISjb7jjkVd_Vn_qgDxbMFvFS-A5GytvRyVA"}}	3
$7kJDwW-2jhnIS4etX9TjGAX6-TcSeK1X5c2IXBKIYvg	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg","$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY","$7MV6cVe8OZRcCQoQ--G1tiE1hrAYBgcNJdkoRnK9cCQ"],"prev_events":["$7MV6cVe8OZRcCQoQ--G1tiE1hrAYBgcNJdkoRnK9cCQ"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"reason":"joining room","membership":"join","displayname":"Mattermost Bridge"},"depth":37,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675879697375,"hashes":{"sha256":"w6QrzvszdIKi+3y6ZjeTnsztYNg7HnNZ9aJKNuuoheU"},"signatures":{"localhost":{"ed25519:a_vyji":"2x49QY6/XsfqM6sSQNk02dOJpoiAiscX9xD5Hpk2uQcY5KaugJ6byIdsGkCi8BWO9vRS9x8R0QWnDF7q19qeBQ"}},"unsigned":{"age_ts":1675879697375,"replaces_state":"$7MV6cVe8OZRcCQoQ--G1tiE1hrAYBgcNJdkoRnK9cCQ"}}	3
$CZrqEW9z_cBAHrxuxxcYegi7fg1tf20O1jmxL17mC9Y	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg","$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY","$7kJDwW-2jhnIS4etX9TjGAX6-TcSeK1X5c2IXBKIYvg"],"prev_events":["$7kJDwW-2jhnIS4etX9TjGAX6-TcSeK1X5c2IXBKIYvg"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"reason":"Needed for app service","membership":"join","displayname":"Mattermost Bridge"},"depth":38,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675879698098,"hashes":{"sha256":"18m3uC6UF64z1zGx4UVSRlDwdIhkRPeZ2+uhx80b/kg"},"signatures":{"localhost":{"ed25519:a_vyji":"ziW9RAzBZ64miUkifnHOKjg8tdTi7HM+ws+HF4lYtUHPsBdS+i3KUzb7ka1FPmT4KK17gj4HvEMeewAsIG+CDQ"}},"unsigned":{"age_ts":1675879698098,"replaces_state":"$7kJDwW-2jhnIS4etX9TjGAX6-TcSeK1X5c2IXBKIYvg"}}	3
$PUa692WLwxL3-4B_FJ5fKAezQeDkQvk0Mt4aK6y6bKU	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg","$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY","$RwIZxuK_hLp0XkjhXtRp1uSYNLClkMGppfpR_voC8MU"],"prev_events":["$RwIZxuK_hLp0XkjhXtRp1uSYNLClkMGppfpR_voC8MU"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"reason":"Needed for app service","membership":"join","displayname":"Mattermost Bridge"},"depth":41,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675879780931,"hashes":{"sha256":"E/0ZdTAPcoSIvHXovklvxF0byAi1wX5Zai80Z2bzacQ"},"signatures":{"localhost":{"ed25519:a_vyji":"aGlJJgnbqNOfAkeMnsHt23Dr/qPF32EJkgzSnIz2F2HLSKusB132s/dYzAh3+XEiWtFnQaB338ofAg/xpoSyBQ"}},"unsigned":{"age_ts":1675879780931,"replaces_state":"$RwIZxuK_hLp0XkjhXtRp1uSYNLClkMGppfpR_voC8MU"}}	3
$sZ_xzte7aB_ofIWratL2US43tIv1Stl0DOtQuVuXIcE	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg","$yFVhlEG5pdVcYKH9LhbJ96IK79GygR0jCiB4NU7HPYM"],"prev_events":["$yFVhlEG5pdVcYKH9LhbJ96IK79GygR0jCiB4NU7HPYM"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"reason":"leaving room","membership":"leave"},"depth":50,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675880912648,"hashes":{"sha256":"4ODt5QGZ7QzIfYIu+LQbLMxQBZ4YHH/8D/a/iVEkISI"},"signatures":{"localhost":{"ed25519:a_vyji":"O+TBUlB4fr5j75qs03HgjtXzMzK3y0zqmu6ibZKLD9PMIuJuMG8pPMDknhpxlsNr+Y4YIGSoQu1im+ORGQr7DA"}},"unsigned":{"age_ts":1675880912648,"replaces_state":"$yFVhlEG5pdVcYKH9LhbJ96IK79GygR0jCiB4NU7HPYM"}}	3
$I9BAqY-jJivf3BugaTzIjWwCq4Vsthp2Srzia5sBtvs	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM","$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM","$Dp5Q-o1kO6cZxdLOQVR1Ba5ymgYTF0qKir8rd5XVyd8"],"prev_events":["$Dp5Q-o1kO6cZxdLOQVR1Ba5ymgYTF0qKir8rd5XVyd8"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@matterbot:localhost","content":{"reason":"joining room","membership":"join","displayname":"Mattermost Bridge"},"depth":43,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675880965283,"hashes":{"sha256":"8j7pojUdjSXT4vPnQqgrZ8eP/oYhvRmshWTsDKvN1NU"},"signatures":{"localhost":{"ed25519:a_vyji":"SdWMCH8nTd37/dWX7tCesqlejU98axXNixuR1nY68l15R40dR4kIVd5XsZOAP/GAeL4q3ahIDZNwafnsd3+GDg"}},"unsigned":{"age_ts":1675880965283,"replaces_state":"$Dp5Q-o1kO6cZxdLOQVR1Ba5ymgYTF0qKir8rd5XVyd8"}}	3
$RFfsT0l03gEKL7fV86ElHnmtu7jGdj4KRpuuCyQKLh0	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM","$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM","$I9BAqY-jJivf3BugaTzIjWwCq4Vsthp2Srzia5sBtvs"],"prev_events":["$I9BAqY-jJivf3BugaTzIjWwCq4Vsthp2Srzia5sBtvs"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@matterbot:localhost","content":{"reason":"Needed for app service","membership":"join","displayname":"Mattermost Bridge"},"depth":44,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675880966134,"hashes":{"sha256":"ALggZdjok1F0Qe2DC53DspZpZW0e5JHSRS6izWhxqu0"},"signatures":{"localhost":{"ed25519:a_vyji":"7xn/XRyppWM5qHjRuK2RQapyOu7HhuX5ygZfcI+OZ7p3gDIiPhKU3pbe1fshQkwtGyV+I00sdxmFS+Xxgxh8Cw"}},"unsigned":{"age_ts":1675880966134,"replaces_state":"$I9BAqY-jJivf3BugaTzIjWwCq4Vsthp2Srzia5sBtvs"}}	3
$V3iPyXBY5Rdjfq2cwuP29HNjpy0XdkW-xZbfClfMyX8	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg","$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY","$eMJm6wCYpxKfgz2KOhEAL5wkidGtV_nWPvoVzahFQ_w"],"prev_events":["$eMJm6wCYpxKfgz2KOhEAL5wkidGtV_nWPvoVzahFQ_w"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"reason":"Needed for app service","membership":"join","displayname":"Mattermost Bridge"},"depth":35,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675879387366,"hashes":{"sha256":"m1CFpzbIx0jUqqagaZMAqRKyn4HhWGGs7AlIhg9O3cs"},"signatures":{"localhost":{"ed25519:a_vyji":"ryvP2+IhktTIM49Sq4vJYwl5VzZ+2mX32CSuG3e8T/47hbAyfWI7rXAT4G1AZWUwIN1ES/JKfiKd3p3tmbGQDg"}},"unsigned":{"age_ts":1675879387366,"replaces_state":"$eMJm6wCYpxKfgz2KOhEAL5wkidGtV_nWPvoVzahFQ_w"}}	3
$5AKU6xT-ue4wUP91q_e8RberEbyIcJxjftWsBfd5390	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM","$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM","$aqyW9vUrxdObe9RJw6v5sRs4rGwiu8gB_G28XjM_ZIY"],"prev_events":["$aqyW9vUrxdObe9RJw6v5sRs4rGwiu8gB_G28XjM_ZIY"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@matterbot:localhost","content":{"reason":"Needed for app service","membership":"join","displayname":"Mattermost Bridge"},"depth":30,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675879698116,"hashes":{"sha256":"TpMJYQ8VgMEWR6YS9Ja+grMlHfNKNasTwxPj/1TqGJk"},"signatures":{"localhost":{"ed25519:a_vyji":"rhnNTvCDTs69Zj+3Ie58EG+uxTLAjZyL8XNUmTqEOEtKaWkl0hoXbiR81xDSKCAtTFAa+qZNe6P7lSdHZfACAA"}},"unsigned":{"age_ts":1675879698116,"replaces_state":"$aqyW9vUrxdObe9RJw6v5sRs4rGwiu8gB_G28XjM_ZIY"}}	3
$De7JBlVgW8VX8ZxAOpb5VsKlSpBrrkExJPDpY6Jb2eQ	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg","$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY","$Gq6AiRbih1LLH4wkJuCyznmTxYjtNTs_3rlzFDU1SLk"],"prev_events":["$Gq6AiRbih1LLH4wkJuCyznmTxYjtNTs_3rlzFDU1SLk"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"reason":"joining room","membership":"join","displayname":"Mattermost Bridge"},"depth":43,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675880227455,"hashes":{"sha256":"EzgSoe8Vok4e67cE6W654DJD2lXXIIwWre76HzcbwQw"},"signatures":{"localhost":{"ed25519:a_vyji":"b4PyixZ7Dr4bxRCHJ82DrFjk5JyTp6l7Wi88h1hVMrer4eWbwa4eeNsuAWsd7I7n9ld6YUQOVBUAVHUFe33BAQ"}},"unsigned":{"age_ts":1675880227455,"replaces_state":"$Gq6AiRbih1LLH4wkJuCyznmTxYjtNTs_3rlzFDU1SLk"}}	3
$fyV6TMmTq9wDrYp9EN2Aw5D0DmsfhzoTxlQ1m0pSZAE	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM","$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM","$Q73eZCSY4oV7fYHAJT-iw3ItAuHA58eqRH82uGwH44w"],"prev_events":["$Q73eZCSY4oV7fYHAJT-iw3ItAuHA58eqRH82uGwH44w"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@matterbot:localhost","content":{"reason":"Needed for app service","membership":"join","displayname":"Mattermost Bridge"},"depth":39,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675880502655,"hashes":{"sha256":"HaNkDk0nfotL7ZXJongOLXzEEzUisOhhRYN918SzQ98"},"signatures":{"localhost":{"ed25519:a_vyji":"lxE2lt3GceHbljvDc2Kd9EP6p5T04+jG1haPShPyuB/OSoKqq+ZTNxvfj9tjHRXif8LzYWNUk2VT9vrGfG2IDQ"}},"unsigned":{"age_ts":1675880502655,"replaces_state":"$Q73eZCSY4oV7fYHAJT-iw3ItAuHA58eqRH82uGwH44w"}}	3
$74eOdDCOl9SWRA3dJaPSiB4EC_sX__ThIgxmrPtmbZE	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg","$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY","$dcq0w5YsiXgEtTRJPYWW2GDKRM3k4SjC-ab3rJOSh7Q"],"prev_events":["$dcq0w5YsiXgEtTRJPYWW2GDKRM3k4SjC-ab3rJOSh7Q"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"reason":"joining room","membership":"join","displayname":"Mattermost Bridge"},"depth":54,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675881596607,"hashes":{"sha256":"cpWxm4ayHX1eYkzPpcRh/MfTFQNRUQcYcTrVemgAVss"},"signatures":{"localhost":{"ed25519:a_vyji":"SmFDpHaj5G56DYZJ6JwEYeWs+36KrNUdu/bQfrlEGyd3dIOckw99sWipykKEjvZKQmqoksCwhBPeD8gE8+ofDQ"}},"unsigned":{"age_ts":1675881596607,"replaces_state":"$dcq0w5YsiXgEtTRJPYWW2GDKRM3k4SjC-ab3rJOSh7Q"}}	3
$1TrVYjSyP6cjgknVY8uql_PO0hzYnXoh_Q5UcPnCrZo	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM","$iT2ZJrZtDk-8_lxymECQMqYbECP_dXcTXNOuVCnSanc"],"prev_events":["$iT2ZJrZtDk-8_lxymECQMqYbECP_dXcTXNOuVCnSanc"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@matterbot:localhost","content":{"reason":"leaving room","membership":"leave"},"depth":28,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675879387619,"hashes":{"sha256":"5OkINwni3IvAoSS/ISLMexXdmzj138XEqqZZWN+8ErY"},"signatures":{"localhost":{"ed25519:a_vyji":"Co3Q3/JxpozfwX6ryqxQ3NxaL2FZzzwi+UyDSK22YBNLPWO9TJYJaSPLz5COtG0uEpcZ/BWMWAcTGUqUx5qKCQ"}},"unsigned":{"age_ts":1675879387619,"replaces_state":"$iT2ZJrZtDk-8_lxymECQMqYbECP_dXcTXNOuVCnSanc"}}	3
$p-JIkw6J2K6wxu8JkmJXlKjanI9p7AuZUDneiYknsFc	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM","$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM","$fyV6TMmTq9wDrYp9EN2Aw5D0DmsfhzoTxlQ1m0pSZAE"],"prev_events":["$fyV6TMmTq9wDrYp9EN2Aw5D0DmsfhzoTxlQ1m0pSZAE"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@matterbot:localhost","content":{"reason":"joining room","membership":"join","displayname":"Mattermost Bridge"},"depth":40,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675880655921,"hashes":{"sha256":"jk1nB17Vbffi/bNUbr+NHKACPQTMJFbabprmnTiVg5Q"},"signatures":{"localhost":{"ed25519:a_vyji":"4y4cp4jaFpJODB3HZi0v8yGlSTvoxy65ZMw1+jzOsHdSXoX4bJQeT9WJz+EWSAjFDf4aZvRopboc4H7XCo0HDQ"}},"unsigned":{"age_ts":1675880655921,"replaces_state":"$fyV6TMmTq9wDrYp9EN2Aw5D0DmsfhzoTxlQ1m0pSZAE"}}	3
$7MV6cVe8OZRcCQoQ--G1tiE1hrAYBgcNJdkoRnK9cCQ	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg","$V3iPyXBY5Rdjfq2cwuP29HNjpy0XdkW-xZbfClfMyX8"],"prev_events":["$V3iPyXBY5Rdjfq2cwuP29HNjpy0XdkW-xZbfClfMyX8"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"reason":"leaving room","membership":"leave"},"depth":36,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675879387642,"hashes":{"sha256":"9lNjEusTvwNE/JZZ0xcP9J6mxnF+6kFSyrCJWMAbYs0"},"signatures":{"localhost":{"ed25519:a_vyji":"njhoeiBDW5xbf/RVxlJjAXIiarTJ/mZMe5ptIKKZvPrmxywCADdJ3FI2MMWkDZP2RzGBzCSOT+CUkB5pWUIFBA"}},"unsigned":{"age_ts":1675879387642,"replaces_state":"$V3iPyXBY5Rdjfq2cwuP29HNjpy0XdkW-xZbfClfMyX8"}}	3
$aqyW9vUrxdObe9RJw6v5sRs4rGwiu8gB_G28XjM_ZIY	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM","$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM","$1TrVYjSyP6cjgknVY8uql_PO0hzYnXoh_Q5UcPnCrZo"],"prev_events":["$1TrVYjSyP6cjgknVY8uql_PO0hzYnXoh_Q5UcPnCrZo"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@matterbot:localhost","content":{"reason":"joining room","membership":"join","displayname":"Mattermost Bridge"},"depth":29,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675879697380,"hashes":{"sha256":"xfB2LGUmYSaoFu/u0pUJwhvFjAZw7+i0IZcRoveQ2lU"},"signatures":{"localhost":{"ed25519:a_vyji":"cp8eRCX2Xc9FY42sz5kvQmxfBRy51owVxDo3H951yXuyoKEvxLGNL2vaMkXWSKhp47fj4omnvYWWDgOnpvDNDA"}},"unsigned":{"age_ts":1675879697380,"replaces_state":"$1TrVYjSyP6cjgknVY8uql_PO0hzYnXoh_Q5UcPnCrZo"}}	3
$ZCrE8n-g5lxd9QFIdUh_5iwteqPL5nimDqoJjpvZbFw	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM","$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM","$zpGESsEospA4z5J4JRYQhBomXyVjLg0lwLJpTY6TrFw"],"prev_events":["$zpGESsEospA4z5J4JRYQhBomXyVjLg0lwLJpTY6TrFw"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@matterbot:localhost","content":{"reason":"Needed for app service","membership":"join","displayname":"Mattermost Bridge"},"depth":36,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675880228120,"hashes":{"sha256":"FNG2D5WRJmGHeFbS5SFB77a6PXLIfKudfpUOReOfmzQ"},"signatures":{"localhost":{"ed25519:a_vyji":"EZJBaLJFIUFF1xvDX9HpxAbEc0Sf5ymu32cr4LL4S+b7j0/g6MUjgsYiNjdaDvndNyyYNe/UW9UJnY4aFBUFCw"}},"unsigned":{"age_ts":1675880228120,"replaces_state":"$zpGESsEospA4z5J4JRYQhBomXyVjLg0lwLJpTY6TrFw"}}	3
$Q73eZCSY4oV7fYHAJT-iw3ItAuHA58eqRH82uGwH44w	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM","$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM","$utAs_ygC9AwIZbOfZwzq7nGH_lAonZbFfYMq25Sbnes"],"prev_events":["$utAs_ygC9AwIZbOfZwzq7nGH_lAonZbFfYMq25Sbnes"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@matterbot:localhost","content":{"reason":"joining room","membership":"join","displayname":"Mattermost Bridge"},"depth":38,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675880501794,"hashes":{"sha256":"S1OSf37UAdjZiFucye0ri37/cD0BvirWImU39nm6viU"},"signatures":{"localhost":{"ed25519:a_vyji":"H7emGsY8KXHycf1uyUi6eMKJDrgM96LVCcc4Al4sp7qijpcY7CAYCOD3A6OIvwGNOGSjjWaVfzo+fXAl0PFnBw"}},"unsigned":{"age_ts":1675880501794,"replaces_state":"$utAs_ygC9AwIZbOfZwzq7nGH_lAonZbFfYMq25Sbnes"}}	3
$PmKTWj14_fU64-YCl_JArQdeIIgT1glyUAP8DQBs0uI	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg","$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY","$bEJ_JyOf1Ygj-Cm0huzAPtvmILPNN--9n3pzgagwWmI"],"prev_events":["$bEJ_JyOf1Ygj-Cm0huzAPtvmILPNN--9n3pzgagwWmI"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"reason":"Needed for app service","membership":"join","displayname":"Mattermost Bridge"},"depth":47,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675880502628,"hashes":{"sha256":"gNk+tJctk6ZOfnPFpjYHiF0mMmJiDu4CRmrtaupREZw"},"signatures":{"localhost":{"ed25519:a_vyji":"HlxVY7I2QpwIcIWKer47qEcwaE72wyimwclZfr1Kj4utlikBH335IbVWrcurieug2kW+8dQbEjRQgfEgelkYBA"}},"unsigned":{"age_ts":1675880502628,"replaces_state":"$bEJ_JyOf1Ygj-Cm0huzAPtvmILPNN--9n3pzgagwWmI"}}	3
$Dp5Q-o1kO6cZxdLOQVR1Ba5ymgYTF0qKir8rd5XVyd8	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM","$whRcD0OyHSdXs5wCZ-Gol9e_KUH--BOTyu1FkYhhQ8E"],"prev_events":["$whRcD0OyHSdXs5wCZ-Gol9e_KUH--BOTyu1FkYhhQ8E"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@matterbot:localhost","content":{"reason":"leaving room","membership":"leave"},"depth":42,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675880911968,"hashes":{"sha256":"RzMEK8LatxP7/SqP5Y+vn92XBXP8bPwtcz6DkbGJZww"},"signatures":{"localhost":{"ed25519:a_vyji":"QYhuw2pe3+4bXqzwmOVFhrE0xQm+zwxy4OzSZHhGYZ+r7m82ri9CghzHBDOvoKCTIk2SHfQARsIHxiHzPXvPBA"}},"unsigned":{"age_ts":1675880911968,"replaces_state":"$whRcD0OyHSdXs5wCZ-Gol9e_KUH--BOTyu1FkYhhQ8E"}}	3
$DaEV2INCT0t6y3M79Y5P4M-s3jrmnFbl0thmqnRCeWM	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM","$RFfsT0l03gEKL7fV86ElHnmtu7jGdj4KRpuuCyQKLh0"],"prev_events":["$RFfsT0l03gEKL7fV86ElHnmtu7jGdj4KRpuuCyQKLh0"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@matterbot:localhost","content":{"reason":"leaving room","membership":"leave"},"depth":45,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675881027046,"hashes":{"sha256":"Wkf03jVGnSHN9QrfxaGbrYUpXNpzWRMrALEiMb/quaE"},"signatures":{"localhost":{"ed25519:a_vyji":"oEBgmnOPsCKTqEGDzeuDiTuAfl3DVXQ7eCuyWJefkLcrr1QFMckMUuplRFyW7QY8OIIzMlnJv4qFqmticPDsCg"}},"unsigned":{"age_ts":1675881027046,"replaces_state":"$RFfsT0l03gEKL7fV86ElHnmtu7jGdj4KRpuuCyQKLh0"}}	3
$BzGhHpwzF69iD1LpgSzUCmR1BGptwZ_OUHk4PeOzJP0	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg","$CZrqEW9z_cBAHrxuxxcYegi7fg1tf20O1jmxL17mC9Y"],"prev_events":["$CZrqEW9z_cBAHrxuxxcYegi7fg1tf20O1jmxL17mC9Y"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"reason":"leaving room","membership":"leave"},"depth":39,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675879698339,"hashes":{"sha256":"udxK7Sxmm93McgYzOmnU5ZanllQyYYLOSS2X1uKNvHo"},"signatures":{"localhost":{"ed25519:a_vyji":"mTOE+Pbujq3KkJSFGQDAsuxxJ8pFlag1ViVMJXBlLX8hoQh+4AJcj/EhhH9td04Rjnlq2YI/RLGq9mJIrJZsDA"}},"unsigned":{"age_ts":1675879698339,"replaces_state":"$CZrqEW9z_cBAHrxuxxcYegi7fg1tf20O1jmxL17mC9Y"}}	3
$Gq6AiRbih1LLH4wkJuCyznmTxYjtNTs_3rlzFDU1SLk	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg","$PUa692WLwxL3-4B_FJ5fKAezQeDkQvk0Mt4aK6y6bKU"],"prev_events":["$PUa692WLwxL3-4B_FJ5fKAezQeDkQvk0Mt4aK6y6bKU"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"reason":"leaving room","membership":"leave"},"depth":42,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675879781138,"hashes":{"sha256":"ktuPBZBIweYyVGw1eePR9TeL2uwTkNi9UXPmXiEbhHs"},"signatures":{"localhost":{"ed25519:a_vyji":"CIZTM+v4J6xPNx+Cu47TeWMuxmkvnR6qhPfHIG7XiLorZ3GvR7zcqX5JXIjVBglsosOEIbgSFy7+AIPJBcJqBQ"}},"unsigned":{"age_ts":1675879781138,"replaces_state":"$PUa692WLwxL3-4B_FJ5fKAezQeDkQvk0Mt4aK6y6bKU"}}	3
$utAs_ygC9AwIZbOfZwzq7nGH_lAonZbFfYMq25Sbnes	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM","$ZCrE8n-g5lxd9QFIdUh_5iwteqPL5nimDqoJjpvZbFw"],"prev_events":["$ZCrE8n-g5lxd9QFIdUh_5iwteqPL5nimDqoJjpvZbFw"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@matterbot:localhost","content":{"reason":"leaving room","membership":"leave"},"depth":37,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675880228441,"hashes":{"sha256":"WUtfIXu318cfGfSoERKHUr8Ntoc/MRzbyWS9NIU5cHs"},"signatures":{"localhost":{"ed25519:a_vyji":"U9P/jBO6e+Xm/pYvkwumPY38UuQlGy7cqESl2SebadCQ0BEfxtPgbpTTnIqWmmw4YrDd1v0CBPneVPAhVxf6BA"}},"unsigned":{"age_ts":1675880228441,"replaces_state":"$ZCrE8n-g5lxd9QFIdUh_5iwteqPL5nimDqoJjpvZbFw"}}	3
$d8H-cks_WJ2pUVeQBHNQjxwMxQQ0dsVns9Egvk6ZZSY	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM","$5AKU6xT-ue4wUP91q_e8RberEbyIcJxjftWsBfd5390"],"prev_events":["$5AKU6xT-ue4wUP91q_e8RberEbyIcJxjftWsBfd5390"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@matterbot:localhost","content":{"reason":"leaving room","membership":"leave"},"depth":31,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675879698452,"hashes":{"sha256":"/40zC13Dca2FRfR/w9/ktNErIM7+EH5sRYzQ2WYZ4iE"},"signatures":{"localhost":{"ed25519:a_vyji":"jEPn2BHlvnj4C0piGuaGmpLbcFXEp55qHT1p1RG5D0u2HI+MvRs4nuFFQOnHq+ByX9NnQHgM+tFpQFf5iYtXCw"}},"unsigned":{"age_ts":1675879698452,"replaces_state":"$5AKU6xT-ue4wUP91q_e8RberEbyIcJxjftWsBfd5390"}}	3
$yFVhlEG5pdVcYKH9LhbJ96IK79GygR0jCiB4NU7HPYM	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg","$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY","$4W6pWQc6IgcxfGV0EHiFYFQtkY1qCo6APGtlCAr60LU"],"prev_events":["$4W6pWQc6IgcxfGV0EHiFYFQtkY1qCo6APGtlCAr60LU"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"reason":"Needed for app service","membership":"join","displayname":"Mattermost Bridge"},"depth":49,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675880656541,"hashes":{"sha256":"6mwQD4thbp7pwSVTKJEeohOSPi7vxpNrurOqO0uAHPY"},"signatures":{"localhost":{"ed25519:a_vyji":"EZyNWb3Xdp1wpJSkKY5UKRzU+4DcK8EZqL19/K0mtT7iZn1ZyP5e+QQYuTiMQu67xVcLiO0P9GSrrzdC5eYWAw"}},"unsigned":{"age_ts":1675880656541,"replaces_state":"$4W6pWQc6IgcxfGV0EHiFYFQtkY1qCo6APGtlCAr60LU"}}	3
$RwIZxuK_hLp0XkjhXtRp1uSYNLClkMGppfpR_voC8MU	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg","$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY","$BzGhHpwzF69iD1LpgSzUCmR1BGptwZ_OUHk4PeOzJP0"],"prev_events":["$BzGhHpwzF69iD1LpgSzUCmR1BGptwZ_OUHk4PeOzJP0"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"reason":"joining room","membership":"join","displayname":"Mattermost Bridge"},"depth":40,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675879780309,"hashes":{"sha256":"aPrsC8kTphlCwtlP+82PAKH5Lv69ONmRan39UEfYiLg"},"signatures":{"localhost":{"ed25519:a_vyji":"KIjIAL2rsdL8iWQ8Q4HZak2bQB/Tj12EFvNB9ah5cCS0IQxZUaDZxOZ+dF7GyVpGuAw7wyJAZ0OQ+Ll+HpJ1BQ"}},"unsigned":{"age_ts":1675879780309,"replaces_state":"$BzGhHpwzF69iD1LpgSzUCmR1BGptwZ_OUHk4PeOzJP0"}}	3
$OP5HTw1PQzzmVnL4rM6W9vo_5awgP51OChBdnKJUw3k	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM","$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM","$dML7rSy7hzRtf__Ngjhbwue3LB55pJlChEmQb7TTrUA"],"prev_events":["$dML7rSy7hzRtf__Ngjhbwue3LB55pJlChEmQb7TTrUA"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@matterbot:localhost","content":{"reason":"Needed for app service","membership":"join","displayname":"Mattermost Bridge"},"depth":33,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675879780956,"hashes":{"sha256":"iS68rxGQWTpvYJkFyv9mesphv8EtpM11/mZoaRmZt+g"},"signatures":{"localhost":{"ed25519:a_vyji":"9U8lqvWw7ToyLvGn/Iv6YBYJxHgqicX4xIqnLnmRP6mZJ3FLyVUX9y/2B4WeVknqqAbbBWfg6aduDgtoYF/rAw"}},"unsigned":{"age_ts":1675879780956,"replaces_state":"$dML7rSy7hzRtf__Ngjhbwue3LB55pJlChEmQb7TTrUA"}}	3
$4W6pWQc6IgcxfGV0EHiFYFQtkY1qCo6APGtlCAr60LU	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg","$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY","$PmKTWj14_fU64-YCl_JArQdeIIgT1glyUAP8DQBs0uI"],"prev_events":["$PmKTWj14_fU64-YCl_JArQdeIIgT1glyUAP8DQBs0uI"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"reason":"joining room","membership":"join","displayname":"Mattermost Bridge"},"depth":48,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675880655924,"hashes":{"sha256":"K1BnuL8eXKfbyS8Acps1KZeJ+uaUk68mZq6e+MCv8QA"},"signatures":{"localhost":{"ed25519:a_vyji":"U3O+i9j+N7uKRIIHR/xXff85X/slLP38U8tlAiSadG4xOl0csOXpzBwECFloRqgdZXPv5N1taSe2ebjkTRKTAQ"}},"unsigned":{"age_ts":1675880655924,"replaces_state":"$PmKTWj14_fU64-YCl_JArQdeIIgT1glyUAP8DQBs0uI"}}	3
$21WoLTVJrJ52kKvP6FJpyDr7jDrBBFwJ8jtLVe5BxoE	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM","$OP5HTw1PQzzmVnL4rM6W9vo_5awgP51OChBdnKJUw3k"],"prev_events":["$OP5HTw1PQzzmVnL4rM6W9vo_5awgP51OChBdnKJUw3k"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@matterbot:localhost","content":{"reason":"leaving room","membership":"leave"},"depth":34,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675879781280,"hashes":{"sha256":"+5ccvinLKlU3+mLv0STcbGPBg1aqT//eyU7XziRDeKk"},"signatures":{"localhost":{"ed25519:a_vyji":"hnOS9OB1YYhaVH4YfUO+S+BXxy+4PQqa8A90ToI/JQj3W0/mQZH1M39BPz8+LwkThMOgoKcnCr2Pb5k9SO45CA"}},"unsigned":{"age_ts":1675879781280,"replaces_state":"$OP5HTw1PQzzmVnL4rM6W9vo_5awgP51OChBdnKJUw3k"}}	3
$z5XMi95yi1w0KN3jNQ-MskRCNLMJBwr2DZ949BQkcOA	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg","$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY","$De7JBlVgW8VX8ZxAOpb5VsKlSpBrrkExJPDpY6Jb2eQ"],"prev_events":["$De7JBlVgW8VX8ZxAOpb5VsKlSpBrrkExJPDpY6Jb2eQ"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"reason":"Needed for app service","membership":"join","displayname":"Mattermost Bridge"},"depth":44,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675880228115,"hashes":{"sha256":"j0YsK27iCUdL9qde8cXFTObDbXAdDev+uhZXLFaYZFE"},"signatures":{"localhost":{"ed25519:a_vyji":"wcsC1JWyWeAgNRG1mSJ4CTeolzKkh9NfXtFGNgKnU/T1noeVxo6auuUnQ67A7NvFbbtc1rR5j4Ix66usTSv0Cg"}},"unsigned":{"age_ts":1675880228115,"replaces_state":"$De7JBlVgW8VX8ZxAOpb5VsKlSpBrrkExJPDpY6Jb2eQ"}}	3
$P-cjsZvHLir5EVtcPh_t3mCvn8_Lc4bfG_lOprYS1U4	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg","$z5XMi95yi1w0KN3jNQ-MskRCNLMJBwr2DZ949BQkcOA"],"prev_events":["$z5XMi95yi1w0KN3jNQ-MskRCNLMJBwr2DZ949BQkcOA"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"reason":"leaving room","membership":"leave"},"depth":45,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675880228408,"hashes":{"sha256":"9WdafdXTO3vOHY2p+h9A1zCsKaZfiVVbSiu3dSj1GVA"},"signatures":{"localhost":{"ed25519:a_vyji":"3xtt7fP18mulF+ogFI8vGS3o5U1WjfVsKQKFUTklvWDUkNP+/jhrJJERmn/WIcbF57IjOum/h5GUnTNYeTKfCg"}},"unsigned":{"age_ts":1675880228408,"replaces_state":"$z5XMi95yi1w0KN3jNQ-MskRCNLMJBwr2DZ949BQkcOA"}}	3
$bEJ_JyOf1Ygj-Cm0huzAPtvmILPNN--9n3pzgagwWmI	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg","$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY","$P-cjsZvHLir5EVtcPh_t3mCvn8_Lc4bfG_lOprYS1U4"],"prev_events":["$P-cjsZvHLir5EVtcPh_t3mCvn8_Lc4bfG_lOprYS1U4"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"reason":"joining room","membership":"join","displayname":"Mattermost Bridge"},"depth":46,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675880501797,"hashes":{"sha256":"IjZwnZpsPr3tOuOTDsAsc3+hs6G7YQS3egqefVNAyl8"},"signatures":{"localhost":{"ed25519:a_vyji":"zGU/FXuqkaxpxG4tocp8fgTRNOcy0VFTMJ6gZsfIRkOKWOdqEzcgJQs8MtS737mvpdxnQCbZdN0p8bbZ7EezCQ"}},"unsigned":{"age_ts":1675880501797,"replaces_state":"$P-cjsZvHLir5EVtcPh_t3mCvn8_Lc4bfG_lOprYS1U4"}}	3
$sCYM3URaqv6flwwrn8lHRJpDn83Sz8RuF7bYxgb0i8g	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg","$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY","$pRbv28FK8ljHETiS081PP5TzzhsKXQ6FELLbCQtcHy4"],"prev_events":["$pRbv28FK8ljHETiS081PP5TzzhsKXQ6FELLbCQtcHy4"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"reason":"Needed for app service","membership":"join","displayname":"Mattermost Bridge"},"depth":52,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675880966136,"hashes":{"sha256":"bq1+MT8Nnww0Jdmq2zbLt0QHb2/P0PPvqrsm7o8Q3sA"},"signatures":{"localhost":{"ed25519:a_vyji":"LpH/ZO7+4SWspT2TIbK/rJG8QCujkFI6eO3p+RDYs1LVCmKqjT6XxZc8N/aKZAeTcKxv1zKnA2KRk/ud/2VXCg"}},"unsigned":{"age_ts":1675880966136,"replaces_state":"$pRbv28FK8ljHETiS081PP5TzzhsKXQ6FELLbCQtcHy4"}}	3
$dcq0w5YsiXgEtTRJPYWW2GDKRM3k4SjC-ab3rJOSh7Q	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg","$sCYM3URaqv6flwwrn8lHRJpDn83Sz8RuF7bYxgb0i8g"],"prev_events":["$sCYM3URaqv6flwwrn8lHRJpDn83Sz8RuF7bYxgb0i8g"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"reason":"leaving room","membership":"leave"},"depth":53,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675881027051,"hashes":{"sha256":"2tPKWCGWE2qbzrlQN3qJdD/ueakjtJHEuIyjYvY5smY"},"signatures":{"localhost":{"ed25519:a_vyji":"kJD7na190rZ3CTCbylRA+UnTLdVtvbQXQdOdL2qbbI4tANWIrVKtsNd2GHGxJqdn12gKHw/fqdSIihb57CPcDQ"}},"unsigned":{"age_ts":1675881027051,"replaces_state":"$sCYM3URaqv6flwwrn8lHRJpDn83Sz8RuF7bYxgb0i8g"}}	3
$rT4YjNqnp8qiyQZIGMLIgPcDOrWgpTUHj-uEqSq5eFA	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM","$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM","$DaEV2INCT0t6y3M79Y5P4M-s3jrmnFbl0thmqnRCeWM"],"prev_events":["$DaEV2INCT0t6y3M79Y5P4M-s3jrmnFbl0thmqnRCeWM"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@matterbot:localhost","content":{"reason":"joining room","membership":"join","displayname":"Mattermost Bridge"},"depth":46,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675881596605,"hashes":{"sha256":"FDrZozzZCxbCwuC/5scLAEpDtzQFSHygNKtRPHFbCu4"},"signatures":{"localhost":{"ed25519:a_vyji":"K6zBmsudfK8/Xhd9DsrAHjaL/EZXvTCUxtVluHiPR7izABmCUrGmnA39LW8HXRyQmgo8GRluIa3rRrMAE9ZQCw"}},"unsigned":{"age_ts":1675881596605,"replaces_state":"$DaEV2INCT0t6y3M79Y5P4M-s3jrmnFbl0thmqnRCeWM"}}	3
$eMJm6wCYpxKfgz2KOhEAL5wkidGtV_nWPvoVzahFQ_w	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg","$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY","$LgX6qWXYlaiVRDlpKJmG6b1DcgpCsOwZlJZ0c9LjXmw"],"prev_events":["$LgX6qWXYlaiVRDlpKJmG6b1DcgpCsOwZlJZ0c9LjXmw"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"reason":"joining room","membership":"join","displayname":"Mattermost Bridge"},"depth":34,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675879386532,"hashes":{"sha256":"v4L1vJAR09VWa7lMN2Z1QSx3YF2zfnrQ9jNDqJbIMMg"},"signatures":{"localhost":{"ed25519:a_vyji":"UytHG5NRUbnRNBFTLVXfEllM4nawrJZbhTSaEwrzI9WkTid9VTNABJYAUNM6Xr3yc6n1t1qjqC8QSH/DtzbTBg"}},"unsigned":{"age_ts":1675879386532,"replaces_state":"$LgX6qWXYlaiVRDlpKJmG6b1DcgpCsOwZlJZ0c9LjXmw"}}	3
$dML7rSy7hzRtf__Ngjhbwue3LB55pJlChEmQb7TTrUA	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM","$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM","$d8H-cks_WJ2pUVeQBHNQjxwMxQQ0dsVns9Egvk6ZZSY"],"prev_events":["$d8H-cks_WJ2pUVeQBHNQjxwMxQQ0dsVns9Egvk6ZZSY"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@matterbot:localhost","content":{"reason":"joining room","membership":"join","displayname":"Mattermost Bridge"},"depth":32,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675879780307,"hashes":{"sha256":"5y+PVg820pqHTPLgeDvzjRTUBbAp5u/40bDtmTt7UIs"},"signatures":{"localhost":{"ed25519:a_vyji":"GGeYGdabGfJQrdj+wmzA5+h2dE4AI3dKbhgzwRX7hC3CA4615SA5IHIXwN05c/KaA1/BNwjd9hgyUksZz+fqAQ"}},"unsigned":{"age_ts":1675879780307,"replaces_state":"$d8H-cks_WJ2pUVeQBHNQjxwMxQQ0dsVns9Egvk6ZZSY"}}	3
$zpGESsEospA4z5J4JRYQhBomXyVjLg0lwLJpTY6TrFw	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM","$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM","$21WoLTVJrJ52kKvP6FJpyDr7jDrBBFwJ8jtLVe5BxoE"],"prev_events":["$21WoLTVJrJ52kKvP6FJpyDr7jDrBBFwJ8jtLVe5BxoE"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@matterbot:localhost","content":{"reason":"joining room","membership":"join","displayname":"Mattermost Bridge"},"depth":35,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675880227456,"hashes":{"sha256":"a/FtTCpdf5S1MtuX4QbPXnHB4obrCAUHWsBj/VvSO40"},"signatures":{"localhost":{"ed25519:a_vyji":"BFKCSrZIi+Bo/gUdhnGumsxl3p0GsfILMogY1tJtd9LewNW/vDY9RWqm7CGTNlIK0KKWALaSzkvubWoxopIvDg"}},"unsigned":{"age_ts":1675880227456,"replaces_state":"$21WoLTVJrJ52kKvP6FJpyDr7jDrBBFwJ8jtLVe5BxoE"}}	3
$whRcD0OyHSdXs5wCZ-Gol9e_KUH--BOTyu1FkYhhQ8E	!YmJPedFXUiFFGzTnFq:localhost	{"historical":false}	{"auth_events":["$BDMW2T5rOIuXZuvIY7kDv7dQxeZ_wtOYEw462Cwnxok","$NAlzeJ_P-ll7O7QZ6ApkPBgoTliLKcz9gg63V32DnYM","$Z46xOpbZO_Ph3k5GBQHl4aluGY4EItcrOOVtP_Yx9vM","$p-JIkw6J2K6wxu8JkmJXlKjanI9p7AuZUDneiYknsFc"],"prev_events":["$p-JIkw6J2K6wxu8JkmJXlKjanI9p7AuZUDneiYknsFc"],"type":"m.room.member","room_id":"!YmJPedFXUiFFGzTnFq:localhost","sender":"@matterbot:localhost","content":{"reason":"Needed for app service","membership":"join","displayname":"Mattermost Bridge"},"depth":41,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675880656521,"hashes":{"sha256":"WdtVyVgpLD8g4N5G8CGzfvvMyiOUer90F/OSgaUEbxg"},"signatures":{"localhost":{"ed25519:a_vyji":"1cAv65cBAb0qllp2QPn3CIcZLgNvJXXVQeBkPQ+RjKnE1pWtl0zPfRgHs1/nkdmf/mOZ220+2xS/qCmwFmQ1BQ"}},"unsigned":{"age_ts":1675880656521,"replaces_state":"$p-JIkw6J2K6wxu8JkmJXlKjanI9p7AuZUDneiYknsFc"}}	3
$pRbv28FK8ljHETiS081PP5TzzhsKXQ6FELLbCQtcHy4	!DaecDLDoTLOuqPWadN:localhost	{"historical":false}	{"auth_events":["$ZR7FntkHPxQjAslBfn5JujMKtaFbABixB-Pddv_6h7E","$46E3oP3kY7kMU5p5M9k97NbB8gfvRI8VjTe-hmlrgTg","$ukz1kEZMDpKwIBy5lKlVLepNwHm7PO3oEZoasz_QefY","$sZ_xzte7aB_ofIWratL2US43tIv1Stl0DOtQuVuXIcE"],"prev_events":["$sZ_xzte7aB_ofIWratL2US43tIv1Stl0DOtQuVuXIcE"],"type":"m.room.member","room_id":"!DaecDLDoTLOuqPWadN:localhost","sender":"@matterbot:localhost","content":{"reason":"joining room","membership":"join","displayname":"Mattermost Bridge"},"depth":51,"state_key":"@matterbot:localhost","origin":"localhost","origin_server_ts":1675880965281,"hashes":{"sha256":"7G3ItjKmTMsZirsGE5ASRxNwLSLqvMFHYfoHznDBspQ"},"signatures":{"localhost":{"ed25519:a_vyji":"t+RsXFNqjEp7KkJCXIt5BhILS6u5V9b789VL0491LDkCL5E6+xrBTb0z8kaa6PN2aU+SF1M+WL5DNEC+jLI3AQ"}},"unsigned":{"age_ts":1675880965281,"replaces_state":"$sZ_xzte7aB_ofIWratL2US43tIv1Stl0DOtQuVuXIcE"}}	3
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
!DaecDLDoTLOuqPWadN:localhost	$dmuQAnknZxpgqjpjtYIvJcdnBBRW5Te8hQ85WDS7uEw	@admin:localhost	\N		14	28	1	0	0	main
!DaecDLDoTLOuqPWadN:localhost	$dmuQAnknZxpgqjpjtYIvJcdnBBRW5Te8hQ85WDS7uEw	@matterbot:localhost	\N		14	28	1	0	0	main
!DaecDLDoTLOuqPWadN:localhost	$mAU9A94YjP4DM004IBnCOQl3huTesAnKbo1CkVX7wMg	@admin:localhost	\N		15	29	1	0	0	main
!DaecDLDoTLOuqPWadN:localhost	$mAU9A94YjP4DM004IBnCOQl3huTesAnKbo1CkVX7wMg	@matterbot:localhost	\N		15	29	1	0	0	main
!DaecDLDoTLOuqPWadN:localhost	$yGEzNJBRRycOk7KUDyR_XFaYOvJ4Hi44-bm0_UqUCeE	@admin:localhost	\N		16	30	1	0	0	main
!DaecDLDoTLOuqPWadN:localhost	$yGEzNJBRRycOk7KUDyR_XFaYOvJ4Hi44-bm0_UqUCeE	@matterbot:localhost	\N		16	30	1	0	0	main
!ZAIhwwJJQkZbVCWAWl:localhost	$kULillGfRc9dmdALLVuNmIhsQ0DV5vjLVAQvpHNKHG8	@matterbot:localhost	\N	["notify",{"set_tweak":"sound","value":"default"},{"set_tweak":"highlight","value":false}]	8	39	1	0	0	main
!ZAIhwwJJQkZbVCWAWl:localhost	$al7p9tH0ZoT5Yu3HsYz1r2ak-9HkXf2coQ7KKeBerUk	@mm_admin:localhost	\N	["notify",{"set_tweak":"highlight","value":false},{"set_tweak":"sound","value":"default"}]	9	40	1	0	0	main
!ZAIhwwJJQkZbVCWAWl:localhost	$isvqtAkok4JAN-_OZRt7MG_xv-fWABZbUbvVPhtzjUI	@matterbot:localhost	\N	["notify",{"set_tweak":"sound","value":"default"},{"set_tweak":"highlight","value":false}]	10	41	1	0	0	main
!DaecDLDoTLOuqPWadN:localhost	$fuPA22emW4V0wHC5EllCh7JbzYMhTIW0DLr_D73YRtU	@admin:localhost	\N		19	45	1	0	0	main
!DaecDLDoTLOuqPWadN:localhost	$fuPA22emW4V0wHC5EllCh7JbzYMhTIW0DLr_D73YRtU	@matterbot:localhost	\N		19	45	1	0	0	main
!DaecDLDoTLOuqPWadN:localhost	$iZZW6EsuxUAxVBXtwcMnKFWoQkFHMXw7rvUqBVZ0wOM	@admin:localhost	\N		20	46	1	0	0	main
!DaecDLDoTLOuqPWadN:localhost	$nD-WsmqnhEa4BIar13mUOspyj5CQ-NVfZYZo7aUnG8o	@admin:localhost	\N		30	64	1	0	0	main
!ZAIhwwJJQkZbVCWAWl:localhost	$s1YwkJ0AvfbD0DFtp0NNPRSOEKYsrtf84Paq6r6Qn60	@matterbot:localhost	\N	["notify",{"set_tweak":"sound","value":"default"},{"set_tweak":"highlight","value":false}]	11	65	1	0	0	main
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
@mm_admin:localhost	!ZAIhwwJJQkZbVCWAWl:localhost	1	40	0	\N	main
@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	5	45	0	\N	main
@user1.matrix:localhost	!DaecDLDoTLOuqPWadN:localhost	0	46	0	46	main
@admin:localhost	!DaecDLDoTLOuqPWadN:localhost	7	64	0	\N	main
@matterbot:localhost	!ZAIhwwJJQkZbVCWAWl:localhost	3	65	0	\N	main
\.


--
-- Data for Name: event_push_summary_last_receipt_stream_id; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_push_summary_last_receipt_stream_id (lock, stream_id) FROM stdin;
X	17
\.


--
-- Data for Name: event_push_summary_stream_ordering; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_push_summary_stream_ordering (lock, stream_ordering) FROM stdin;
X	113
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
$gQgbgv5fxFXlqv1ijNKbz-lh6k1tNCvxkocpyKVWVRs	!DaecDLDoTLOuqPWadN:localhost	\N	content.body	'hej':1	1675795622658	27
$dmuQAnknZxpgqjpjtYIvJcdnBBRW5Te8hQ85WDS7uEw	!DaecDLDoTLOuqPWadN:localhost	\N	content.body	'klkl':1	1675796001894	28
$mAU9A94YjP4DM004IBnCOQl3huTesAnKbo1CkVX7wMg	!DaecDLDoTLOuqPWadN:localhost	\N	content.body	'hej':1	1675796206110	29
$yGEzNJBRRycOk7KUDyR_XFaYOvJ4Hi44-bm0_UqUCeE	!DaecDLDoTLOuqPWadN:localhost	\N	content.body	'ok':1	1675796781642	30
$a1xA663y2WchzA_Q5jmTKVlInC_HDgPTK8C2g37ysdk	!ZAIhwwJJQkZbVCWAWl:localhost	\N	content.name	'public':2 'public-room1':1 'room1':3	1675797060838	37
$kULillGfRc9dmdALLVuNmIhsQ0DV5vjLVAQvpHNKHG8	!ZAIhwwJJQkZbVCWAWl:localhost	\N	content.body	'klklkl':1	1675797081159	39
$isvqtAkok4JAN-_OZRt7MG_xv-fWABZbUbvVPhtzjUI	!ZAIhwwJJQkZbVCWAWl:localhost	\N	content.body	'ok':1	1675797271149	41
$fuPA22emW4V0wHC5EllCh7JbzYMhTIW0DLr_D73YRtU	!DaecDLDoTLOuqPWadN:localhost	\N	content.body	'kl':2 'ok':1	1675814070751	45
$iZZW6EsuxUAxVBXtwcMnKFWoQkFHMXw7rvUqBVZ0wOM	!DaecDLDoTLOuqPWadN:localhost	\N	content.body	'jkj':2 'jkjk':1	1675814080545	46
$nD-WsmqnhEa4BIar13mUOspyj5CQ-NVfZYZo7aUnG8o	!DaecDLDoTLOuqPWadN:localhost	\N	content.body	'klklklkl':1	1675878048755	64
$s1YwkJ0AvfbD0DFtp0NNPRSOEKYsrtf84Paq6r6Qn60	!ZAIhwwJJQkZbVCWAWl:localhost	\N	content.body	'okoko':1	1675878181068	65
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
$4Wo5EetfrJ0oD7aWVI6CvS_-ZUM3lsyzkFZeQElMcmI	40
$eOdfuP6TezgWF5799z0-muVXLh1k8LvHE2Wfob0cC3A	42
$gQgbgv5fxFXlqv1ijNKbz-lh6k1tNCvxkocpyKVWVRs	42
$dmuQAnknZxpgqjpjtYIvJcdnBBRW5Te8hQ85WDS7uEw	42
$mAU9A94YjP4DM004IBnCOQl3huTesAnKbo1CkVX7wMg	42
$yGEzNJBRRycOk7KUDyR_XFaYOvJ4Hi44-bm0_UqUCeE	42
$SCwfg4xWBzxHVcFLtW1DbcDU4LMVkfgjYJG-qdUypcM	56
$RB7fKTVNYlqIOEPsSHLuZd4VtyQWzJBKjadsEKrzboc	57
$VypxR6iKVehL3VR2C035y9gijIu-KXtOmJ85mKX9XLI	58
$qx1E7MsFRdI9CbDeDYHg3A8XeN6MXU2rkBGCoxPB5mw	59
$1kUMRxz6Q6tB2pRvD-yuOBQbj2dooMjTGymKWTyL_I0	60
$MWD--uqyNXbmKDBMJob9sDY5AM4riTmkAwwz36FIaPk	61
$a1xA663y2WchzA_Q5jmTKVlInC_HDgPTK8C2g37ysdk	64
$wdUPyT-0i7vmiiPz1WNunqvPAIWSfFtnwV1OizPIkvg	65
$kULillGfRc9dmdALLVuNmIhsQ0DV5vjLVAQvpHNKHG8	66
$al7p9tH0ZoT5Yu3HsYz1r2ak-9HkXf2coQ7KKeBerUk	71
$isvqtAkok4JAN-_OZRt7MG_xv-fWABZbUbvVPhtzjUI	71
$E44xF_r_bYO9HOH-lw-VkWepvoS6z9dxDWthhfbpT9M	72
$PksohbU2dYCXTn5ETrl9bIqsEVAPP0Wohp--_6XwmYg	73
$ycR02cfa_D8mViUfnzHTBMWRlLibcN2pYZDwiiQUt8I	74
$fuPA22emW4V0wHC5EllCh7JbzYMhTIW0DLr_D73YRtU	74
$iZZW6EsuxUAxVBXtwcMnKFWoQkFHMXw7rvUqBVZ0wOM	74
$4EiubgnrkRAh09BKQLVXOeE9xGDhNpI_objrHMKclmA	76
$9-LSz3ddCTGWUa1IWqJRNNSh2mJrY7YVMY_uo340Sek	77
$n7_pif4S0hNHmw6iRBbW8iOHiFYTB60HnOnp4zhPUiM	78
$a185DaoMSzelXmfPlkcYOe3H3zITI_nFoVFWjnPmTu8	79
$Y6Vh2Kkasecp6HyMWxXbvX7gYSqrx6mIGOOROWKR1Hs	80
$tvfSz5Kqzjfh39pYs3yfctIZoJQ09aOzDx4YZvZDlyc	82
$84NzkDN2QGVP9qS7o_z1qOhaHe5-fSbz4Vs2SiNDPo0	81
$oU5B1qtEraaFCsivi4-r4WT9WGSSBIzW-i7EDPYS-eE	83
$DhWWh8GrURTFDa120InvAq5u-MKwyslHHOkRAcsUhaQ	84
$HvHWZQ09kf-ICUV-Ar9JELFLWq2tJUi2ull2GBzbx9U	86
$toF4I3EB1pERgvaXBIbhBugPExKQ2bOI0J6aOngeVI4	85
$4ODGclJajZc3SV1KXAMLeoAZrYyBdfzBaT-uorLgyJ8	88
$81XepwsM4YptvtHgl3P5SaUSvkP94S2d7apqzJ78aFk	87
$dL0sqD6DHzPvOsuGJe1kcseFEXgtsK3Q59XyD3PJVk4	90
$Pk6fFbdC0REz3T43EROb2OhYqN4o1ptnYGXXeyMDxkE	89
$DsB5975yzOpruMKKVBUYRHB3MSljJYHh3p7763sNf2I	91
$7Op41p6mCUbcp5TuaBcCF4mMRwPYz6lWW7a943BDG8o	92
$nD-WsmqnhEa4BIar13mUOspyj5CQ-NVfZYZo7aUnG8o	92
$s1YwkJ0AvfbD0DFtp0NNPRSOEKYsrtf84Paq6r6Qn60	71
$V4DFlazGXeBPWV65AAUJ4t5Qg3tYPqs8hY5TxXXOAg8	93
$4VQxBaDA6dKjPvqNVj95IwQXv3QL3a-bXdpp4EyG9yo	94
$XLYrVIK-R-MtOR1YnQaG3APBProvOP79zhKQSr95HqE	96
$bm6jSsPXymAqmwjgIzaCnnJ6c2n_z2s5EzuLfrNVKvE	95
$qjaNmlKX4IG53qDAgTwuNoxohPKncklE70COvnTRmxc	97
$LgX6qWXYlaiVRDlpKJmG6b1DcgpCsOwZlJZ0c9LjXmw	98
$eKKl-y9GISjb7jjkVd_Vn_qgDxbMFvFS-A5GytvRyVA	100
$eMJm6wCYpxKfgz2KOhEAL5wkidGtV_nWPvoVzahFQ_w	99
$V3iPyXBY5Rdjfq2cwuP29HNjpy0XdkW-xZbfClfMyX8	101
$iT2ZJrZtDk-8_lxymECQMqYbECP_dXcTXNOuVCnSanc	102
$1TrVYjSyP6cjgknVY8uql_PO0hzYnXoh_Q5UcPnCrZo	103
$7MV6cVe8OZRcCQoQ--G1tiE1hrAYBgcNJdkoRnK9cCQ	104
$7kJDwW-2jhnIS4etX9TjGAX6-TcSeK1X5c2IXBKIYvg	105
$aqyW9vUrxdObe9RJw6v5sRs4rGwiu8gB_G28XjM_ZIY	106
$CZrqEW9z_cBAHrxuxxcYegi7fg1tf20O1jmxL17mC9Y	107
$5AKU6xT-ue4wUP91q_e8RberEbyIcJxjftWsBfd5390	108
$BzGhHpwzF69iD1LpgSzUCmR1BGptwZ_OUHk4PeOzJP0	109
$d8H-cks_WJ2pUVeQBHNQjxwMxQQ0dsVns9Egvk6ZZSY	110
$dML7rSy7hzRtf__Ngjhbwue3LB55pJlChEmQb7TTrUA	111
$RwIZxuK_hLp0XkjhXtRp1uSYNLClkMGppfpR_voC8MU	112
$PUa692WLwxL3-4B_FJ5fKAezQeDkQvk0Mt4aK6y6bKU	113
$OP5HTw1PQzzmVnL4rM6W9vo_5awgP51OChBdnKJUw3k	114
$Gq6AiRbih1LLH4wkJuCyznmTxYjtNTs_3rlzFDU1SLk	115
$21WoLTVJrJ52kKvP6FJpyDr7jDrBBFwJ8jtLVe5BxoE	116
$De7JBlVgW8VX8ZxAOpb5VsKlSpBrrkExJPDpY6Jb2eQ	117
$zpGESsEospA4z5J4JRYQhBomXyVjLg0lwLJpTY6TrFw	118
$z5XMi95yi1w0KN3jNQ-MskRCNLMJBwr2DZ949BQkcOA	120
$ZCrE8n-g5lxd9QFIdUh_5iwteqPL5nimDqoJjpvZbFw	119
$P-cjsZvHLir5EVtcPh_t3mCvn8_Lc4bfG_lOprYS1U4	121
$utAs_ygC9AwIZbOfZwzq7nGH_lAonZbFfYMq25Sbnes	122
$bEJ_JyOf1Ygj-Cm0huzAPtvmILPNN--9n3pzgagwWmI	124
$Q73eZCSY4oV7fYHAJT-iw3ItAuHA58eqRH82uGwH44w	123
$PmKTWj14_fU64-YCl_JArQdeIIgT1glyUAP8DQBs0uI	125
$fyV6TMmTq9wDrYp9EN2Aw5D0DmsfhzoTxlQ1m0pSZAE	126
$74eOdDCOl9SWRA3dJaPSiB4EC_sX__ThIgxmrPtmbZE	140
$p-JIkw6J2K6wxu8JkmJXlKjanI9p7AuZUDneiYknsFc	127
$4W6pWQc6IgcxfGV0EHiFYFQtkY1qCo6APGtlCAr60LU	128
$whRcD0OyHSdXs5wCZ-Gol9e_KUH--BOTyu1FkYhhQ8E	129
$pRbv28FK8ljHETiS081PP5TzzhsKXQ6FELLbCQtcHy4	133
$yFVhlEG5pdVcYKH9LhbJ96IK79GygR0jCiB4NU7HPYM	130
$Dp5Q-o1kO6cZxdLOQVR1Ba5ymgYTF0qKir8rd5XVyd8	131
$DaEV2INCT0t6y3M79Y5P4M-s3jrmnFbl0thmqnRCeWM	138
$sZ_xzte7aB_ofIWratL2US43tIv1Stl0DOtQuVuXIcE	132
$I9BAqY-jJivf3BugaTzIjWwCq4Vsthp2Srzia5sBtvs	134
$RFfsT0l03gEKL7fV86ElHnmtu7jGdj4KRpuuCyQKLh0	136
$dcq0w5YsiXgEtTRJPYWW2GDKRM3k4SjC-ab3rJOSh7Q	137
$rT4YjNqnp8qiyQZIGMLIgPcDOrWgpTUHj-uEqSq5eFA	139
$sCYM3URaqv6flwwrn8lHRJpDn83Sz8RuF7bYxgb0i8g	135
\.


--
-- Data for Name: event_txn_id; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_txn_id (event_id, room_id, user_id, token_id, txn_id, inserted_ts) FROM stdin;
$dmuQAnknZxpgqjpjtYIvJcdnBBRW5Te8hQ85WDS7uEw	!DaecDLDoTLOuqPWadN:localhost	@user1.matrix:localhost	6	m1675796001803.1	1675796001934
$mAU9A94YjP4DM004IBnCOQl3huTesAnKbo1CkVX7wMg	!DaecDLDoTLOuqPWadN:localhost	@user1.matrix:localhost	6	m1675796206032.2	1675796206134
$yGEzNJBRRycOk7KUDyR_XFaYOvJ4Hi44-bm0_UqUCeE	!DaecDLDoTLOuqPWadN:localhost	@user1.matrix:localhost	6	m1675796781564.3	1675796781671
$kULillGfRc9dmdALLVuNmIhsQ0DV5vjLVAQvpHNKHG8	!ZAIhwwJJQkZbVCWAWl:localhost	@user1.matrix:localhost	6	m1675797081086.4	1675797081194
$isvqtAkok4JAN-_OZRt7MG_xv-fWABZbUbvVPhtzjUI	!ZAIhwwJJQkZbVCWAWl:localhost	@user1.matrix:localhost	6	m1675797271047.5	1675797271176
$fuPA22emW4V0wHC5EllCh7JbzYMhTIW0DLr_D73YRtU	!DaecDLDoTLOuqPWadN:localhost	@user1.matrix:localhost	6	m1675814070660.52	1675814070795
$nD-WsmqnhEa4BIar13mUOspyj5CQ-NVfZYZo7aUnG8o	!DaecDLDoTLOuqPWadN:localhost	@user1.matrix:localhost	6	m1675878048664.0	1675878048812
$s1YwkJ0AvfbD0DFtp0NNPRSOEKYsrtf84Paq6r6Qn60	!ZAIhwwJJQkZbVCWAWl:localhost	@user1.matrix:localhost	6	m1675878180964.1	1675878181117
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
13	$4Wo5EetfrJ0oD7aWVI6CvS_-ZUM3lsyzkFZeQElMcmI	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	13	1675794349387	1675794349495	@user1.matrix:localhost	f	master	25	@user1.matrix:localhost	\N
12	$eOdfuP6TezgWF5799z0-muVXLh1k8LvHE2Wfob0cC3A	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	12	1675794373761	1675794373821	@user1.matrix:localhost	f	master	26	@user1.matrix:localhost	\N
13	$gQgbgv5fxFXlqv1ijNKbz-lh6k1tNCvxkocpyKVWVRs	m.room.message	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	13	1675795622658	1675795622737	@user1.matrix:localhost	f	master	27	\N	\N
14	$dmuQAnknZxpgqjpjtYIvJcdnBBRW5Te8hQ85WDS7uEw	m.room.message	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	14	1675796001894	1675796001933	@user1.matrix:localhost	f	master	28	\N	\N
15	$mAU9A94YjP4DM004IBnCOQl3huTesAnKbo1CkVX7wMg	m.room.message	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	15	1675796206110	1675796206134	@user1.matrix:localhost	f	master	29	\N	\N
16	$yGEzNJBRRycOk7KUDyR_XFaYOvJ4Hi44-bm0_UqUCeE	m.room.message	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	16	1675796781642	1675796781670	@user1.matrix:localhost	f	master	30	\N	\N
1	$SCwfg4xWBzxHVcFLtW1DbcDU4LMVkfgjYJG-qdUypcM	m.room.create	!ZAIhwwJJQkZbVCWAWl:localhost	\N	\N	t	f	1	1675797059975	1675797060022	@user1.matrix:localhost	f	master	31		\N
2	$RB7fKTVNYlqIOEPsSHLuZd4VtyQWzJBKjadsEKrzboc	m.room.member	!ZAIhwwJJQkZbVCWAWl:localhost	\N	\N	t	f	2	1675797060104	1675797060157	@user1.matrix:localhost	f	master	32	@user1.matrix:localhost	\N
3	$VypxR6iKVehL3VR2C035y9gijIu-KXtOmJ85mKX9XLI	m.room.power_levels	!ZAIhwwJJQkZbVCWAWl:localhost	\N	\N	t	f	3	1675797060239	1675797060686	@user1.matrix:localhost	f	master	33		\N
4	$qx1E7MsFRdI9CbDeDYHg3A8XeN6MXU2rkBGCoxPB5mw	m.room.canonical_alias	!ZAIhwwJJQkZbVCWAWl:localhost	\N	\N	t	f	4	1675797060301	1675797060686	@user1.matrix:localhost	f	master	34		\N
5	$1kUMRxz6Q6tB2pRvD-yuOBQbj2dooMjTGymKWTyL_I0	m.room.join_rules	!ZAIhwwJJQkZbVCWAWl:localhost	\N	\N	t	f	5	1675797060344	1675797060686	@user1.matrix:localhost	f	master	35		\N
6	$MWD--uqyNXbmKDBMJob9sDY5AM4riTmkAwwz36FIaPk	m.room.history_visibility	!ZAIhwwJJQkZbVCWAWl:localhost	\N	\N	t	f	6	1675797060371	1675797060686	@user1.matrix:localhost	f	master	36		\N
7	$a1xA663y2WchzA_Q5jmTKVlInC_HDgPTK8C2g37ysdk	m.room.name	!ZAIhwwJJQkZbVCWAWl:localhost	\N	\N	t	f	7	1675797060838	1675797061011	@user1.matrix:localhost	f	master	37		\N
7	$wdUPyT-0i7vmiiPz1WNunqvPAIWSfFtnwV1OizPIkvg	m.room.member	!ZAIhwwJJQkZbVCWAWl:localhost	\N	\N	t	f	7	1675797061080	1675797061262	@matterbot:localhost	f	master	38	@matterbot:localhost	\N
8	$kULillGfRc9dmdALLVuNmIhsQ0DV5vjLVAQvpHNKHG8	m.room.message	!ZAIhwwJJQkZbVCWAWl:localhost	\N	\N	t	f	8	1675797081159	1675797081192	@user1.matrix:localhost	f	master	39	\N	\N
9	$al7p9tH0ZoT5Yu3HsYz1r2ak-9HkXf2coQ7KKeBerUk	m.room.member	!ZAIhwwJJQkZbVCWAWl:localhost	\N	\N	t	f	9	1675797190163	1675797190218	@user1.matrix:localhost	f	master	40	@mm_admin:localhost	\N
10	$isvqtAkok4JAN-_OZRt7MG_xv-fWABZbUbvVPhtzjUI	m.room.message	!ZAIhwwJJQkZbVCWAWl:localhost	\N	\N	t	f	10	1675797271149	1675797271175	@user1.matrix:localhost	f	master	41	\N	\N
14	$E44xF_r_bYO9HOH-lw-VkWepvoS6z9dxDWthhfbpT9M	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	14	1675814024531	1675814024618	@matterbot:localhost	f	master	43	@matterbot:localhost	\N
17	$PksohbU2dYCXTn5ETrl9bIqsEVAPP0Wohp--_6XwmYg	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	17	1675814024538	1675814024618	@matterbot:localhost	f	master	42	@matterbot:localhost	\N
18	$ycR02cfa_D8mViUfnzHTBMWRlLibcN2pYZDwiiQUt8I	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	18	1675814025884	1675814025936	@matterbot:localhost	f	master	44	@matterbot:localhost	\N
19	$fuPA22emW4V0wHC5EllCh7JbzYMhTIW0DLr_D73YRtU	m.room.message	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	19	1675814070751	1675814070793	@user1.matrix:localhost	f	master	45	\N	\N
20	$iZZW6EsuxUAxVBXtwcMnKFWoQkFHMXw7rvUqBVZ0wOM	m.room.message	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	20	1675814080545	1675814080603	@matterbot:localhost	f	master	46	\N	\N
21	$4EiubgnrkRAh09BKQLVXOeE9xGDhNpI_objrHMKclmA	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	21	1675877263513	1675877263608	@matterbot:localhost	f	master	47	@matterbot:localhost	\N
15	$9-LSz3ddCTGWUa1IWqJRNNSh2mJrY7YVMY_uo340Sek	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	15	1675877264138	1675877264215	@matterbot:localhost	f	master	48	@matterbot:localhost	\N
22	$n7_pif4S0hNHmw6iRBbW8iOHiFYTB60HnOnp4zhPUiM	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	22	1675877264162	1675877264225	@matterbot:localhost	f	master	49	@matterbot:localhost	\N
16	$a185DaoMSzelXmfPlkcYOe3H3zITI_nFoVFWjnPmTu8	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	16	1675877264344	1675877264456	@matterbot:localhost	f	master	50	@matterbot:localhost	\N
23	$Y6Vh2Kkasecp6HyMWxXbvX7gYSqrx6mIGOOROWKR1Hs	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	23	1675877264424	1675877264478	@matterbot:localhost	f	master	51	@matterbot:localhost	\N
17	$tvfSz5Kqzjfh39pYs3yfctIZoJQ09aOzDx4YZvZDlyc	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	17	1675877556164	1675877556210	@matterbot:localhost	f	master	52	@matterbot:localhost	\N
24	$84NzkDN2QGVP9qS7o_z1qOhaHe5-fSbz4Vs2SiNDPo0	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	24	1675877556153	1675877556212	@matterbot:localhost	f	master	53	@matterbot:localhost	\N
25	$oU5B1qtEraaFCsivi4-r4WT9WGSSBIzW-i7EDPYS-eE	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	25	1675877556701	1675877556759	@matterbot:localhost	f	master	54	@matterbot:localhost	\N
18	$DhWWh8GrURTFDa120InvAq5u-MKwyslHHOkRAcsUhaQ	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	18	1675877556710	1675877556760	@matterbot:localhost	f	master	55	@matterbot:localhost	\N
26	$toF4I3EB1pERgvaXBIbhBugPExKQ2bOI0J6aOngeVI4	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	26	1675877556893	1675877556958	@matterbot:localhost	f	master	56	@matterbot:localhost	\N
19	$HvHWZQ09kf-ICUV-Ar9JELFLWq2tJUi2ull2GBzbx9U	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	19	1675877556899	1675877556959	@matterbot:localhost	f	master	57	@matterbot:localhost	\N
27	$4ODGclJajZc3SV1KXAMLeoAZrYyBdfzBaT-uorLgyJ8	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	27	1675877728363	1675877728417	@matterbot:localhost	f	master	59	@matterbot:localhost	\N
20	$81XepwsM4YptvtHgl3P5SaUSvkP94S2d7apqzJ78aFk	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	20	1675877728354	1675877728418	@matterbot:localhost	f	master	58	@matterbot:localhost	\N
21	$dL0sqD6DHzPvOsuGJe1kcseFEXgtsK3Q59XyD3PJVk4	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	21	1675877728843	1675877728890	@matterbot:localhost	f	master	60	@matterbot:localhost	\N
28	$Pk6fFbdC0REz3T43EROb2OhYqN4o1ptnYGXXeyMDxkE	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	28	1675877728845	1675877728891	@matterbot:localhost	f	master	61	@matterbot:localhost	\N
22	$DsB5975yzOpruMKKVBUYRHB3MSljJYHh3p7763sNf2I	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	22	1675877729024	1675877729082	@matterbot:localhost	f	master	62	@matterbot:localhost	\N
29	$7Op41p6mCUbcp5TuaBcCF4mMRwPYz6lWW7a943BDG8o	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	29	1675877729058	1675877729150	@matterbot:localhost	f	master	63	@matterbot:localhost	\N
30	$nD-WsmqnhEa4BIar13mUOspyj5CQ-NVfZYZo7aUnG8o	m.room.message	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	30	1675878048755	1675878048811	@user1.matrix:localhost	f	master	64	\N	\N
11	$s1YwkJ0AvfbD0DFtp0NNPRSOEKYsrtf84Paq6r6Qn60	m.room.message	!ZAIhwwJJQkZbVCWAWl:localhost	\N	\N	t	f	11	1675878181068	1675878181116	@user1.matrix:localhost	f	master	65	\N	\N
31	$V4DFlazGXeBPWV65AAUJ4t5Qg3tYPqs8hY5TxXXOAg8	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	31	1675878356410	1675878356494	@matterbot:localhost	f	master	67	@matterbot:localhost	\N
23	$4VQxBaDA6dKjPvqNVj95IwQXv3QL3a-bXdpp4EyG9yo	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	23	1675878356414	1675878356495	@matterbot:localhost	f	master	66	@matterbot:localhost	\N
24	$XLYrVIK-R-MtOR1YnQaG3APBProvOP79zhKQSr95HqE	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	24	1675878357193	1675878357261	@matterbot:localhost	f	master	68	@matterbot:localhost	\N
32	$bm6jSsPXymAqmwjgIzaCnnJ6c2n_z2s5EzuLfrNVKvE	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	32	1675878357183	1675878357270	@matterbot:localhost	f	master	69	@matterbot:localhost	\N
25	$qjaNmlKX4IG53qDAgTwuNoxohPKncklE70COvnTRmxc	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	25	1675878357445	1675878357780	@matterbot:localhost	f	master	70	@matterbot:localhost	\N
33	$LgX6qWXYlaiVRDlpKJmG6b1DcgpCsOwZlJZ0c9LjXmw	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	33	1675878357697	1675878357855	@matterbot:localhost	f	master	71	@matterbot:localhost	\N
26	$eKKl-y9GISjb7jjkVd_Vn_qgDxbMFvFS-A5GytvRyVA	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	26	1675879386540	1675879386627	@matterbot:localhost	f	master	73	@matterbot:localhost	\N
34	$eMJm6wCYpxKfgz2KOhEAL5wkidGtV_nWPvoVzahFQ_w	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	34	1675879386532	1675879386628	@matterbot:localhost	f	master	72	@matterbot:localhost	\N
35	$V3iPyXBY5Rdjfq2cwuP29HNjpy0XdkW-xZbfClfMyX8	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	35	1675879387366	1675879387423	@matterbot:localhost	f	master	74	@matterbot:localhost	\N
27	$iT2ZJrZtDk-8_lxymECQMqYbECP_dXcTXNOuVCnSanc	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	27	1675879387367	1675879387431	@matterbot:localhost	f	master	75	@matterbot:localhost	\N
28	$1TrVYjSyP6cjgknVY8uql_PO0hzYnXoh_Q5UcPnCrZo	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	28	1675879387619	1675879387767	@matterbot:localhost	f	master	76	@matterbot:localhost	\N
36	$7MV6cVe8OZRcCQoQ--G1tiE1hrAYBgcNJdkoRnK9cCQ	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	36	1675879387642	1675879387768	@matterbot:localhost	f	master	77	@matterbot:localhost	\N
37	$7kJDwW-2jhnIS4etX9TjGAX6-TcSeK1X5c2IXBKIYvg	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	37	1675879697375	1675879697424	@matterbot:localhost	f	master	79	@matterbot:localhost	\N
29	$aqyW9vUrxdObe9RJw6v5sRs4rGwiu8gB_G28XjM_ZIY	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	29	1675879697380	1675879697425	@matterbot:localhost	f	master	78	@matterbot:localhost	\N
38	$CZrqEW9z_cBAHrxuxxcYegi7fg1tf20O1jmxL17mC9Y	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	38	1675879698098	1675879698158	@matterbot:localhost	f	master	80	@matterbot:localhost	\N
41	$PUa692WLwxL3-4B_FJ5fKAezQeDkQvk0Mt4aK6y6bKU	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	41	1675879780931	1675879780977	@matterbot:localhost	f	master	86	@matterbot:localhost	\N
36	$ZCrE8n-g5lxd9QFIdUh_5iwteqPL5nimDqoJjpvZbFw	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	36	1675880228120	1675880228237	@matterbot:localhost	f	master	93	@matterbot:localhost	\N
38	$Q73eZCSY4oV7fYHAJT-iw3ItAuHA58eqRH82uGwH44w	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	38	1675880501794	1675880501841	@matterbot:localhost	f	master	97	@matterbot:localhost	\N
47	$PmKTWj14_fU64-YCl_JArQdeIIgT1glyUAP8DQBs0uI	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	47	1675880502628	1675880502717	@matterbot:localhost	f	master	98	@matterbot:localhost	\N
40	$p-JIkw6J2K6wxu8JkmJXlKjanI9p7AuZUDneiYknsFc	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	40	1675880655921	1675880655979	@matterbot:localhost	f	master	100	@matterbot:localhost	\N
42	$Dp5Q-o1kO6cZxdLOQVR1Ba5ymgYTF0qKir8rd5XVyd8	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	42	1675880911968	1675880912033	@matterbot:localhost	f	master	104	@matterbot:localhost	\N
50	$sZ_xzte7aB_ofIWratL2US43tIv1Stl0DOtQuVuXIcE	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	50	1675880912648	1675880913004	@matterbot:localhost	f	master	105	@matterbot:localhost	\N
43	$I9BAqY-jJivf3BugaTzIjWwCq4Vsthp2Srzia5sBtvs	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	43	1675880965283	1675880965355	@matterbot:localhost	f	master	106	@matterbot:localhost	\N
44	$RFfsT0l03gEKL7fV86ElHnmtu7jGdj4KRpuuCyQKLh0	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	44	1675880966134	1675880966221	@matterbot:localhost	f	master	109	@matterbot:localhost	\N
53	$dcq0w5YsiXgEtTRJPYWW2GDKRM3k4SjC-ab3rJOSh7Q	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	53	1675881027051	1675881027232	@matterbot:localhost	f	master	110	@matterbot:localhost	\N
45	$DaEV2INCT0t6y3M79Y5P4M-s3jrmnFbl0thmqnRCeWM	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	45	1675881027046	1675881027232	@matterbot:localhost	f	master	111	@matterbot:localhost	\N
46	$rT4YjNqnp8qiyQZIGMLIgPcDOrWgpTUHj-uEqSq5eFA	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	46	1675881596605	1675881596681	@matterbot:localhost	f	master	112	@matterbot:localhost	\N
30	$5AKU6xT-ue4wUP91q_e8RberEbyIcJxjftWsBfd5390	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	30	1675879698116	1675879698178	@matterbot:localhost	f	master	81	@matterbot:localhost	\N
39	$BzGhHpwzF69iD1LpgSzUCmR1BGptwZ_OUHk4PeOzJP0	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	39	1675879698339	1675879698497	@matterbot:localhost	f	master	82	@matterbot:localhost	\N
31	$d8H-cks_WJ2pUVeQBHNQjxwMxQQ0dsVns9Egvk6ZZSY	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	31	1675879698452	1675879698550	@matterbot:localhost	f	master	83	@matterbot:localhost	\N
42	$Gq6AiRbih1LLH4wkJuCyznmTxYjtNTs_3rlzFDU1SLk	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	42	1675879781138	1675879781291	@matterbot:localhost	f	master	88	@matterbot:localhost	\N
43	$De7JBlVgW8VX8ZxAOpb5VsKlSpBrrkExJPDpY6Jb2eQ	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	43	1675880227455	1675880227505	@matterbot:localhost	f	master	90	@matterbot:localhost	\N
37	$utAs_ygC9AwIZbOfZwzq7nGH_lAonZbFfYMq25Sbnes	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	37	1675880228441	1675880228555	@matterbot:localhost	f	master	95	@matterbot:localhost	\N
39	$fyV6TMmTq9wDrYp9EN2Aw5D0DmsfhzoTxlQ1m0pSZAE	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	39	1675880502655	1675880502765	@matterbot:localhost	f	master	99	@matterbot:localhost	\N
49	$yFVhlEG5pdVcYKH9LhbJ96IK79GygR0jCiB4NU7HPYM	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	49	1675880656541	1675880656598	@matterbot:localhost	f	master	103	@matterbot:localhost	\N
54	$74eOdDCOl9SWRA3dJaPSiB4EC_sX__ThIgxmrPtmbZE	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	54	1675881596607	1675881596682	@matterbot:localhost	f	master	113	@matterbot:localhost	\N
32	$dML7rSy7hzRtf__Ngjhbwue3LB55pJlChEmQb7TTrUA	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	32	1675879780307	1675879780349	@matterbot:localhost	f	master	84	@matterbot:localhost	\N
40	$RwIZxuK_hLp0XkjhXtRp1uSYNLClkMGppfpR_voC8MU	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	40	1675879780309	1675879780359	@matterbot:localhost	f	master	85	@matterbot:localhost	\N
33	$OP5HTw1PQzzmVnL4rM6W9vo_5awgP51OChBdnKJUw3k	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	33	1675879780956	1675879781003	@matterbot:localhost	f	master	87	@matterbot:localhost	\N
34	$21WoLTVJrJ52kKvP6FJpyDr7jDrBBFwJ8jtLVe5BxoE	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	34	1675879781280	1675879781447	@matterbot:localhost	f	master	89	@matterbot:localhost	\N
35	$zpGESsEospA4z5J4JRYQhBomXyVjLg0lwLJpTY6TrFw	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	35	1675880227456	1675880227507	@matterbot:localhost	f	master	91	@matterbot:localhost	\N
44	$z5XMi95yi1w0KN3jNQ-MskRCNLMJBwr2DZ949BQkcOA	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	44	1675880228115	1675880228233	@matterbot:localhost	f	master	92	@matterbot:localhost	\N
45	$P-cjsZvHLir5EVtcPh_t3mCvn8_Lc4bfG_lOprYS1U4	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	45	1675880228408	1675880228530	@matterbot:localhost	f	master	94	@matterbot:localhost	\N
46	$bEJ_JyOf1Ygj-Cm0huzAPtvmILPNN--9n3pzgagwWmI	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	46	1675880501797	1675880501841	@matterbot:localhost	f	master	96	@matterbot:localhost	\N
48	$4W6pWQc6IgcxfGV0EHiFYFQtkY1qCo6APGtlCAr60LU	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	48	1675880655924	1675880655982	@matterbot:localhost	f	master	101	@matterbot:localhost	\N
41	$whRcD0OyHSdXs5wCZ-Gol9e_KUH--BOTyu1FkYhhQ8E	m.room.member	!YmJPedFXUiFFGzTnFq:localhost	\N	\N	t	f	41	1675880656521	1675880656588	@matterbot:localhost	f	master	102	@matterbot:localhost	\N
51	$pRbv28FK8ljHETiS081PP5TzzhsKXQ6FELLbCQtcHy4	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	51	1675880965281	1675880965349	@matterbot:localhost	f	master	107	@matterbot:localhost	\N
52	$sCYM3URaqv6flwwrn8lHRJpDn83Sz8RuF7bYxgb0i8g	m.room.member	!DaecDLDoTLOuqPWadN:localhost	\N	\N	t	f	52	1675880966136	1675880966216	@matterbot:localhost	f	master	108	@matterbot:localhost	\N
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
events	113	master
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
!DaecDLDoTLOuqPWadN:localhost	@mm_admin:localhost	$e59i0svd92559O6Ylspucl1xefsa8dpbbZe0ZE0mUp4	join
!YmJPedFXUiFFGzTnFq:localhost	@mm_admin:localhost	$6Lgivd2MHjS9x-3BOttMrBNfnyKpvrsbwS8TFPVdz1c	join
!YmJPedFXUiFFGzTnFq:localhost	@user1.matrix:localhost	$4Wo5EetfrJ0oD7aWVI6CvS_-ZUM3lsyzkFZeQElMcmI	join
!DaecDLDoTLOuqPWadN:localhost	@user1.matrix:localhost	$eOdfuP6TezgWF5799z0-muVXLh1k8LvHE2Wfob0cC3A	join
!ZAIhwwJJQkZbVCWAWl:localhost	@user1.matrix:localhost	$RB7fKTVNYlqIOEPsSHLuZd4VtyQWzJBKjadsEKrzboc	join
!ZAIhwwJJQkZbVCWAWl:localhost	@matterbot:localhost	$wdUPyT-0i7vmiiPz1WNunqvPAIWSfFtnwV1OizPIkvg	join
!ZAIhwwJJQkZbVCWAWl:localhost	@mm_admin:localhost	$al7p9tH0ZoT5Yu3HsYz1r2ak-9HkXf2coQ7KKeBerUk	invite
!DaecDLDoTLOuqPWadN:localhost	@matterbot:localhost	$74eOdDCOl9SWRA3dJaPSiB4EC_sX__ThIgxmrPtmbZE	join
!YmJPedFXUiFFGzTnFq:localhost	@matterbot:localhost	$rT4YjNqnp8qiyQZIGMLIgPcDOrWgpTUHj-uEqSq5eFA	join
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
42	@admin:localhost	offline	1675289375046	1675793907938	1675289375047	\N	t	master
185	@user1.matrix:localhost	online	1675882078935	1675881051227	1675882078935	\N	t	master
133	@matterbot:localhost	offline	1675877965339	1675877965340	0	\N	f	master
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.profiles (user_id, displayname, avatar_url) FROM stdin;
admin	admin	\N
mm_admin	admin [mm]	\N
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
!DaecDLDoTLOuqPWadN:localhost	m.read.private	@admin:localhost	["$06pNLPsFn-fF2WbziopICIA6qaey-LFJhiTAHGfqJS4"]	{"ts":1675288208461}	\N
!DaecDLDoTLOuqPWadN:localhost	m.read	@admin:localhost	["$06pNLPsFn-fF2WbziopICIA6qaey-LFJhiTAHGfqJS4"]	{"ts":1675288208478}	\N
!YmJPedFXUiFFGzTnFq:localhost	m.read.private	@admin:localhost	["$ykL4uD4FNcb8S_8kQpwbthwvqPKRzD_pJ3jyfA-5ywc"]	{"ts":1675288273900}	\N
!YmJPedFXUiFFGzTnFq:localhost	m.read	@admin:localhost	["$ykL4uD4FNcb8S_8kQpwbthwvqPKRzD_pJ3jyfA-5ywc"]	{"ts":1675288273989}	\N
!ZAIhwwJJQkZbVCWAWl:localhost	m.read.private	@user1.matrix:localhost	["$wdUPyT-0i7vmiiPz1WNunqvPAIWSfFtnwV1OizPIkvg"]	{"ts":1675797061852}	\N
!ZAIhwwJJQkZbVCWAWl:localhost	m.read	@user1.matrix:localhost	["$wdUPyT-0i7vmiiPz1WNunqvPAIWSfFtnwV1OizPIkvg"]	{"ts":1675797061968}	\N
!DaecDLDoTLOuqPWadN:localhost	m.read.private	@user1.matrix:localhost	["$iZZW6EsuxUAxVBXtwcMnKFWoQkFHMXw7rvUqBVZ0wOM"]	{"ts":1675814109219}	\N
!DaecDLDoTLOuqPWadN:localhost	m.read	@user1.matrix:localhost	["$iZZW6EsuxUAxVBXtwcMnKFWoQkFHMXw7rvUqBVZ0wOM"]	{"ts":1675814109242}	\N
!YmJPedFXUiFFGzTnFq:localhost	m.read.private	@user1.matrix:localhost	["$DsB5975yzOpruMKKVBUYRHB3MSljJYHh3p7763sNf2I"]	{"ts":1675878121414}	\N
!YmJPedFXUiFFGzTnFq:localhost	m.read	@user1.matrix:localhost	["$DsB5975yzOpruMKKVBUYRHB3MSljJYHh3p7763sNf2I"]	{"ts":1675878121439}	\N
\.


--
-- Data for Name: receipts_linearized; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.receipts_linearized (stream_id, room_id, receipt_type, user_id, event_id, data, instance_name, event_stream_ordering, thread_id) FROM stdin;
2	!DaecDLDoTLOuqPWadN:localhost	m.read.private	@admin:localhost	$06pNLPsFn-fF2WbziopICIA6qaey-LFJhiTAHGfqJS4	{"ts":1675288208461}	\N	16	\N
3	!DaecDLDoTLOuqPWadN:localhost	m.read	@admin:localhost	$06pNLPsFn-fF2WbziopICIA6qaey-LFJhiTAHGfqJS4	{"ts":1675288208478}	\N	16	\N
4	!YmJPedFXUiFFGzTnFq:localhost	m.read.private	@admin:localhost	$ykL4uD4FNcb8S_8kQpwbthwvqPKRzD_pJ3jyfA-5ywc	{"ts":1675288273900}	\N	17	\N
5	!YmJPedFXUiFFGzTnFq:localhost	m.read	@admin:localhost	$ykL4uD4FNcb8S_8kQpwbthwvqPKRzD_pJ3jyfA-5ywc	{"ts":1675288273989}	\N	17	\N
10	!ZAIhwwJJQkZbVCWAWl:localhost	m.read.private	@user1.matrix:localhost	$wdUPyT-0i7vmiiPz1WNunqvPAIWSfFtnwV1OizPIkvg	{"ts":1675797061852}	\N	38	\N
11	!ZAIhwwJJQkZbVCWAWl:localhost	m.read	@user1.matrix:localhost	$wdUPyT-0i7vmiiPz1WNunqvPAIWSfFtnwV1OizPIkvg	{"ts":1675797061968}	\N	38	\N
14	!DaecDLDoTLOuqPWadN:localhost	m.read.private	@user1.matrix:localhost	$iZZW6EsuxUAxVBXtwcMnKFWoQkFHMXw7rvUqBVZ0wOM	{"ts":1675814109219}	\N	46	\N
15	!DaecDLDoTLOuqPWadN:localhost	m.read	@user1.matrix:localhost	$iZZW6EsuxUAxVBXtwcMnKFWoQkFHMXw7rvUqBVZ0wOM	{"ts":1675814109242}	\N	46	\N
16	!YmJPedFXUiFFGzTnFq:localhost	m.read.private	@user1.matrix:localhost	$DsB5975yzOpruMKKVBUYRHB3MSljJYHh3p7763sNf2I	{"ts":1675878121414}	\N	62	\N
17	!YmJPedFXUiFFGzTnFq:localhost	m.read	@user1.matrix:localhost	$DsB5975yzOpruMKKVBUYRHB3MSljJYHh3p7763sNf2I	{"ts":1675878121439}	\N	62	\N
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
@user1.matrix:localhost	!YmJPedFXUiFFGzTnFq:localhost	m.fully_read	26	{"event_id":"$4Wo5EetfrJ0oD7aWVI6CvS_-ZUM3lsyzkFZeQElMcmI"}	\N
@user1.matrix:localhost	!DaecDLDoTLOuqPWadN:localhost	m.fully_read	46	{"event_id":"$nD-WsmqnhEa4BIar13mUOspyj5CQ-NVfZYZo7aUnG8o"}	\N
@user1.matrix:localhost	!ZAIhwwJJQkZbVCWAWl:localhost	m.fully_read	51	{"event_id":"$s1YwkJ0AvfbD0DFtp0NNPRSOEKYsrtf84Paq6r6Qn60"}	\N
\.


--
-- Data for Name: room_alias_servers; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_alias_servers (room_alias, server) FROM stdin;
#off-topic:localhost	localhost
#town-square:localhost	localhost
#public-room1:localhost	localhost
\.


--
-- Data for Name: room_aliases; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_aliases (room_alias, room_id, creator) FROM stdin;
#off-topic:localhost	!DaecDLDoTLOuqPWadN:localhost	@admin:localhost
#town-square:localhost	!YmJPedFXUiFFGzTnFq:localhost	@admin:localhost
#public-room1:localhost	!ZAIhwwJJQkZbVCWAWl:localhost	@user1.matrix:localhost
\.


--
-- Data for Name: room_depth; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_depth (room_id, min_depth) FROM stdin;
!DaecDLDoTLOuqPWadN:localhost	1
!YmJPedFXUiFFGzTnFq:localhost	1
!ZAIhwwJJQkZbVCWAWl:localhost	1
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
$4Wo5EetfrJ0oD7aWVI6CvS_-ZUM3lsyzkFZeQElMcmI	@user1.matrix:localhost	@user1.matrix:localhost	!YmJPedFXUiFFGzTnFq:localhost	join	0	user1.matrix	\N
$eOdfuP6TezgWF5799z0-muVXLh1k8LvHE2Wfob0cC3A	@user1.matrix:localhost	@user1.matrix:localhost	!DaecDLDoTLOuqPWadN:localhost	join	0	user1.matrix	\N
$RB7fKTVNYlqIOEPsSHLuZd4VtyQWzJBKjadsEKrzboc	@user1.matrix:localhost	@user1.matrix:localhost	!ZAIhwwJJQkZbVCWAWl:localhost	join	0	user1.matrix	\N
$wdUPyT-0i7vmiiPz1WNunqvPAIWSfFtnwV1OizPIkvg	@matterbot:localhost	@matterbot:localhost	!ZAIhwwJJQkZbVCWAWl:localhost	join	0	Mattermost Bridge	\N
$al7p9tH0ZoT5Yu3HsYz1r2ak-9HkXf2coQ7KKeBerUk	@mm_admin:localhost	@user1.matrix:localhost	!ZAIhwwJJQkZbVCWAWl:localhost	invite	0	admin [mm]	\N
$E44xF_r_bYO9HOH-lw-VkWepvoS6z9dxDWthhfbpT9M	@matterbot:localhost	@matterbot:localhost	!YmJPedFXUiFFGzTnFq:localhost	join	0	Mattermost Bridge	\N
$PksohbU2dYCXTn5ETrl9bIqsEVAPP0Wohp--_6XwmYg	@matterbot:localhost	@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	join	0	Mattermost Bridge	\N
$ycR02cfa_D8mViUfnzHTBMWRlLibcN2pYZDwiiQUt8I	@matterbot:localhost	@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	join	0	Mattermost Bridge	\N
$4EiubgnrkRAh09BKQLVXOeE9xGDhNpI_objrHMKclmA	@matterbot:localhost	@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	join	0	Mattermost Bridge	\N
$9-LSz3ddCTGWUa1IWqJRNNSh2mJrY7YVMY_uo340Sek	@matterbot:localhost	@matterbot:localhost	!YmJPedFXUiFFGzTnFq:localhost	join	0	Mattermost Bridge	\N
$n7_pif4S0hNHmw6iRBbW8iOHiFYTB60HnOnp4zhPUiM	@matterbot:localhost	@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	join	0	Mattermost Bridge	\N
$a185DaoMSzelXmfPlkcYOe3H3zITI_nFoVFWjnPmTu8	@matterbot:localhost	@matterbot:localhost	!YmJPedFXUiFFGzTnFq:localhost	leave	0	\N	\N
$Y6Vh2Kkasecp6HyMWxXbvX7gYSqrx6mIGOOROWKR1Hs	@matterbot:localhost	@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	leave	0	\N	\N
$tvfSz5Kqzjfh39pYs3yfctIZoJQ09aOzDx4YZvZDlyc	@matterbot:localhost	@matterbot:localhost	!YmJPedFXUiFFGzTnFq:localhost	join	0	Mattermost Bridge	\N
$84NzkDN2QGVP9qS7o_z1qOhaHe5-fSbz4Vs2SiNDPo0	@matterbot:localhost	@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	join	0	Mattermost Bridge	\N
$oU5B1qtEraaFCsivi4-r4WT9WGSSBIzW-i7EDPYS-eE	@matterbot:localhost	@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	join	0	Mattermost Bridge	\N
$DhWWh8GrURTFDa120InvAq5u-MKwyslHHOkRAcsUhaQ	@matterbot:localhost	@matterbot:localhost	!YmJPedFXUiFFGzTnFq:localhost	join	0	Mattermost Bridge	\N
$HvHWZQ09kf-ICUV-Ar9JELFLWq2tJUi2ull2GBzbx9U	@matterbot:localhost	@matterbot:localhost	!YmJPedFXUiFFGzTnFq:localhost	leave	0	\N	\N
$toF4I3EB1pERgvaXBIbhBugPExKQ2bOI0J6aOngeVI4	@matterbot:localhost	@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	leave	0	\N	\N
$4ODGclJajZc3SV1KXAMLeoAZrYyBdfzBaT-uorLgyJ8	@matterbot:localhost	@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	join	0	Mattermost Bridge	\N
$81XepwsM4YptvtHgl3P5SaUSvkP94S2d7apqzJ78aFk	@matterbot:localhost	@matterbot:localhost	!YmJPedFXUiFFGzTnFq:localhost	join	0	Mattermost Bridge	\N
$dL0sqD6DHzPvOsuGJe1kcseFEXgtsK3Q59XyD3PJVk4	@matterbot:localhost	@matterbot:localhost	!YmJPedFXUiFFGzTnFq:localhost	join	0	Mattermost Bridge	\N
$Pk6fFbdC0REz3T43EROb2OhYqN4o1ptnYGXXeyMDxkE	@matterbot:localhost	@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	join	0	Mattermost Bridge	\N
$DsB5975yzOpruMKKVBUYRHB3MSljJYHh3p7763sNf2I	@matterbot:localhost	@matterbot:localhost	!YmJPedFXUiFFGzTnFq:localhost	leave	0	\N	\N
$7Op41p6mCUbcp5TuaBcCF4mMRwPYz6lWW7a943BDG8o	@matterbot:localhost	@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	leave	0	\N	\N
$V4DFlazGXeBPWV65AAUJ4t5Qg3tYPqs8hY5TxXXOAg8	@matterbot:localhost	@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	join	0	Mattermost Bridge	\N
$4VQxBaDA6dKjPvqNVj95IwQXv3QL3a-bXdpp4EyG9yo	@matterbot:localhost	@matterbot:localhost	!YmJPedFXUiFFGzTnFq:localhost	join	0	Mattermost Bridge	\N
$XLYrVIK-R-MtOR1YnQaG3APBProvOP79zhKQSr95HqE	@matterbot:localhost	@matterbot:localhost	!YmJPedFXUiFFGzTnFq:localhost	join	0	Mattermost Bridge	\N
$bm6jSsPXymAqmwjgIzaCnnJ6c2n_z2s5EzuLfrNVKvE	@matterbot:localhost	@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	join	0	Mattermost Bridge	\N
$qjaNmlKX4IG53qDAgTwuNoxohPKncklE70COvnTRmxc	@matterbot:localhost	@matterbot:localhost	!YmJPedFXUiFFGzTnFq:localhost	leave	0	\N	\N
$LgX6qWXYlaiVRDlpKJmG6b1DcgpCsOwZlJZ0c9LjXmw	@matterbot:localhost	@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	leave	0	\N	\N
$eKKl-y9GISjb7jjkVd_Vn_qgDxbMFvFS-A5GytvRyVA	@matterbot:localhost	@matterbot:localhost	!YmJPedFXUiFFGzTnFq:localhost	join	0	Mattermost Bridge	\N
$eMJm6wCYpxKfgz2KOhEAL5wkidGtV_nWPvoVzahFQ_w	@matterbot:localhost	@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	join	0	Mattermost Bridge	\N
$iT2ZJrZtDk-8_lxymECQMqYbECP_dXcTXNOuVCnSanc	@matterbot:localhost	@matterbot:localhost	!YmJPedFXUiFFGzTnFq:localhost	join	0	Mattermost Bridge	\N
$V3iPyXBY5Rdjfq2cwuP29HNjpy0XdkW-xZbfClfMyX8	@matterbot:localhost	@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	join	0	Mattermost Bridge	\N
$1TrVYjSyP6cjgknVY8uql_PO0hzYnXoh_Q5UcPnCrZo	@matterbot:localhost	@matterbot:localhost	!YmJPedFXUiFFGzTnFq:localhost	leave	0	\N	\N
$7MV6cVe8OZRcCQoQ--G1tiE1hrAYBgcNJdkoRnK9cCQ	@matterbot:localhost	@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	leave	0	\N	\N
$7kJDwW-2jhnIS4etX9TjGAX6-TcSeK1X5c2IXBKIYvg	@matterbot:localhost	@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	join	0	Mattermost Bridge	\N
$aqyW9vUrxdObe9RJw6v5sRs4rGwiu8gB_G28XjM_ZIY	@matterbot:localhost	@matterbot:localhost	!YmJPedFXUiFFGzTnFq:localhost	join	0	Mattermost Bridge	\N
$CZrqEW9z_cBAHrxuxxcYegi7fg1tf20O1jmxL17mC9Y	@matterbot:localhost	@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	join	0	Mattermost Bridge	\N
$PUa692WLwxL3-4B_FJ5fKAezQeDkQvk0Mt4aK6y6bKU	@matterbot:localhost	@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	join	0	Mattermost Bridge	\N
$5AKU6xT-ue4wUP91q_e8RberEbyIcJxjftWsBfd5390	@matterbot:localhost	@matterbot:localhost	!YmJPedFXUiFFGzTnFq:localhost	join	0	Mattermost Bridge	\N
$BzGhHpwzF69iD1LpgSzUCmR1BGptwZ_OUHk4PeOzJP0	@matterbot:localhost	@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	leave	0	\N	\N
$d8H-cks_WJ2pUVeQBHNQjxwMxQQ0dsVns9Egvk6ZZSY	@matterbot:localhost	@matterbot:localhost	!YmJPedFXUiFFGzTnFq:localhost	leave	0	\N	\N
$Gq6AiRbih1LLH4wkJuCyznmTxYjtNTs_3rlzFDU1SLk	@matterbot:localhost	@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	leave	0	\N	\N
$dML7rSy7hzRtf__Ngjhbwue3LB55pJlChEmQb7TTrUA	@matterbot:localhost	@matterbot:localhost	!YmJPedFXUiFFGzTnFq:localhost	join	0	Mattermost Bridge	\N
$RwIZxuK_hLp0XkjhXtRp1uSYNLClkMGppfpR_voC8MU	@matterbot:localhost	@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	join	0	Mattermost Bridge	\N
$OP5HTw1PQzzmVnL4rM6W9vo_5awgP51OChBdnKJUw3k	@matterbot:localhost	@matterbot:localhost	!YmJPedFXUiFFGzTnFq:localhost	join	0	Mattermost Bridge	\N
$21WoLTVJrJ52kKvP6FJpyDr7jDrBBFwJ8jtLVe5BxoE	@matterbot:localhost	@matterbot:localhost	!YmJPedFXUiFFGzTnFq:localhost	leave	0	\N	\N
$De7JBlVgW8VX8ZxAOpb5VsKlSpBrrkExJPDpY6Jb2eQ	@matterbot:localhost	@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	join	0	Mattermost Bridge	\N
$zpGESsEospA4z5J4JRYQhBomXyVjLg0lwLJpTY6TrFw	@matterbot:localhost	@matterbot:localhost	!YmJPedFXUiFFGzTnFq:localhost	join	0	Mattermost Bridge	\N
$z5XMi95yi1w0KN3jNQ-MskRCNLMJBwr2DZ949BQkcOA	@matterbot:localhost	@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	join	0	Mattermost Bridge	\N
$ZCrE8n-g5lxd9QFIdUh_5iwteqPL5nimDqoJjpvZbFw	@matterbot:localhost	@matterbot:localhost	!YmJPedFXUiFFGzTnFq:localhost	join	0	Mattermost Bridge	\N
$P-cjsZvHLir5EVtcPh_t3mCvn8_Lc4bfG_lOprYS1U4	@matterbot:localhost	@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	leave	0	\N	\N
$utAs_ygC9AwIZbOfZwzq7nGH_lAonZbFfYMq25Sbnes	@matterbot:localhost	@matterbot:localhost	!YmJPedFXUiFFGzTnFq:localhost	leave	0	\N	\N
$bEJ_JyOf1Ygj-Cm0huzAPtvmILPNN--9n3pzgagwWmI	@matterbot:localhost	@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	join	0	Mattermost Bridge	\N
$Q73eZCSY4oV7fYHAJT-iw3ItAuHA58eqRH82uGwH44w	@matterbot:localhost	@matterbot:localhost	!YmJPedFXUiFFGzTnFq:localhost	join	0	Mattermost Bridge	\N
$PmKTWj14_fU64-YCl_JArQdeIIgT1glyUAP8DQBs0uI	@matterbot:localhost	@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	join	0	Mattermost Bridge	\N
$fyV6TMmTq9wDrYp9EN2Aw5D0DmsfhzoTxlQ1m0pSZAE	@matterbot:localhost	@matterbot:localhost	!YmJPedFXUiFFGzTnFq:localhost	join	0	Mattermost Bridge	\N
$p-JIkw6J2K6wxu8JkmJXlKjanI9p7AuZUDneiYknsFc	@matterbot:localhost	@matterbot:localhost	!YmJPedFXUiFFGzTnFq:localhost	join	0	Mattermost Bridge	\N
$4W6pWQc6IgcxfGV0EHiFYFQtkY1qCo6APGtlCAr60LU	@matterbot:localhost	@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	join	0	Mattermost Bridge	\N
$whRcD0OyHSdXs5wCZ-Gol9e_KUH--BOTyu1FkYhhQ8E	@matterbot:localhost	@matterbot:localhost	!YmJPedFXUiFFGzTnFq:localhost	join	0	Mattermost Bridge	\N
$yFVhlEG5pdVcYKH9LhbJ96IK79GygR0jCiB4NU7HPYM	@matterbot:localhost	@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	join	0	Mattermost Bridge	\N
$Dp5Q-o1kO6cZxdLOQVR1Ba5ymgYTF0qKir8rd5XVyd8	@matterbot:localhost	@matterbot:localhost	!YmJPedFXUiFFGzTnFq:localhost	leave	0	\N	\N
$sZ_xzte7aB_ofIWratL2US43tIv1Stl0DOtQuVuXIcE	@matterbot:localhost	@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	leave	0	\N	\N
$pRbv28FK8ljHETiS081PP5TzzhsKXQ6FELLbCQtcHy4	@matterbot:localhost	@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	join	0	Mattermost Bridge	\N
$I9BAqY-jJivf3BugaTzIjWwCq4Vsthp2Srzia5sBtvs	@matterbot:localhost	@matterbot:localhost	!YmJPedFXUiFFGzTnFq:localhost	join	0	Mattermost Bridge	\N
$sCYM3URaqv6flwwrn8lHRJpDn83Sz8RuF7bYxgb0i8g	@matterbot:localhost	@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	join	0	Mattermost Bridge	\N
$RFfsT0l03gEKL7fV86ElHnmtu7jGdj4KRpuuCyQKLh0	@matterbot:localhost	@matterbot:localhost	!YmJPedFXUiFFGzTnFq:localhost	join	0	Mattermost Bridge	\N
$dcq0w5YsiXgEtTRJPYWW2GDKRM3k4SjC-ab3rJOSh7Q	@matterbot:localhost	@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	leave	0	\N	\N
$DaEV2INCT0t6y3M79Y5P4M-s3jrmnFbl0thmqnRCeWM	@matterbot:localhost	@matterbot:localhost	!YmJPedFXUiFFGzTnFq:localhost	leave	0	\N	\N
$74eOdDCOl9SWRA3dJaPSiB4EC_sX__ThIgxmrPtmbZE	@matterbot:localhost	@matterbot:localhost	!DaecDLDoTLOuqPWadN:localhost	join	0	Mattermost Bridge	\N
$rT4YjNqnp8qiyQZIGMLIgPcDOrWgpTUHj-uEqSq5eFA	@matterbot:localhost	@matterbot:localhost	!YmJPedFXUiFFGzTnFq:localhost	join	0	Mattermost Bridge	\N
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
!ZAIhwwJJQkZbVCWAWl:localhost	9	2	1	0	0	2	40	0
!YmJPedFXUiFFGzTnFq:localhost	10	4	0	0	0	4	113	0
!DaecDLDoTLOuqPWadN:localhost	10	4	0	0	0	4	113	0
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
!ZAIhwwJJQkZbVCWAWl:localhost	#public-room1	#public-room1:localhost	public	shared	\N	\N	\N	t	\N	\N
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
!ZAIhwwJJQkZbVCWAWl:localhost	t	@user1.matrix:localhost	9	t
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
$4Wo5EetfrJ0oD7aWVI6CvS_-ZUM3lsyzkFZeQElMcmI	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@user1.matrix:localhost	\N
$eOdfuP6TezgWF5799z0-muVXLh1k8LvHE2Wfob0cC3A	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@user1.matrix:localhost	\N
$SCwfg4xWBzxHVcFLtW1DbcDU4LMVkfgjYJG-qdUypcM	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.create		\N
$RB7fKTVNYlqIOEPsSHLuZd4VtyQWzJBKjadsEKrzboc	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.member	@user1.matrix:localhost	\N
$VypxR6iKVehL3VR2C035y9gijIu-KXtOmJ85mKX9XLI	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.power_levels		\N
$qx1E7MsFRdI9CbDeDYHg3A8XeN6MXU2rkBGCoxPB5mw	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.canonical_alias		\N
$1kUMRxz6Q6tB2pRvD-yuOBQbj2dooMjTGymKWTyL_I0	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.join_rules		\N
$MWD--uqyNXbmKDBMJob9sDY5AM4riTmkAwwz36FIaPk	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.history_visibility		\N
$a1xA663y2WchzA_Q5jmTKVlInC_HDgPTK8C2g37ysdk	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.name		\N
$wdUPyT-0i7vmiiPz1WNunqvPAIWSfFtnwV1OizPIkvg	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.member	@matterbot:localhost	\N
$al7p9tH0ZoT5Yu3HsYz1r2ak-9HkXf2coQ7KKeBerUk	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.member	@mm_admin:localhost	\N
$E44xF_r_bYO9HOH-lw-VkWepvoS6z9dxDWthhfbpT9M	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	\N
$PksohbU2dYCXTn5ETrl9bIqsEVAPP0Wohp--_6XwmYg	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	\N
$ycR02cfa_D8mViUfnzHTBMWRlLibcN2pYZDwiiQUt8I	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	\N
$4EiubgnrkRAh09BKQLVXOeE9xGDhNpI_objrHMKclmA	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	\N
$9-LSz3ddCTGWUa1IWqJRNNSh2mJrY7YVMY_uo340Sek	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	\N
$n7_pif4S0hNHmw6iRBbW8iOHiFYTB60HnOnp4zhPUiM	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	\N
$a185DaoMSzelXmfPlkcYOe3H3zITI_nFoVFWjnPmTu8	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	\N
$Y6Vh2Kkasecp6HyMWxXbvX7gYSqrx6mIGOOROWKR1Hs	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	\N
$tvfSz5Kqzjfh39pYs3yfctIZoJQ09aOzDx4YZvZDlyc	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	\N
$84NzkDN2QGVP9qS7o_z1qOhaHe5-fSbz4Vs2SiNDPo0	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	\N
$oU5B1qtEraaFCsivi4-r4WT9WGSSBIzW-i7EDPYS-eE	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	\N
$DhWWh8GrURTFDa120InvAq5u-MKwyslHHOkRAcsUhaQ	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	\N
$toF4I3EB1pERgvaXBIbhBugPExKQ2bOI0J6aOngeVI4	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	\N
$HvHWZQ09kf-ICUV-Ar9JELFLWq2tJUi2ull2GBzbx9U	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	\N
$4ODGclJajZc3SV1KXAMLeoAZrYyBdfzBaT-uorLgyJ8	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	\N
$81XepwsM4YptvtHgl3P5SaUSvkP94S2d7apqzJ78aFk	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	\N
$dL0sqD6DHzPvOsuGJe1kcseFEXgtsK3Q59XyD3PJVk4	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	\N
$Pk6fFbdC0REz3T43EROb2OhYqN4o1ptnYGXXeyMDxkE	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	\N
$DsB5975yzOpruMKKVBUYRHB3MSljJYHh3p7763sNf2I	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	\N
$7Op41p6mCUbcp5TuaBcCF4mMRwPYz6lWW7a943BDG8o	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	\N
$V4DFlazGXeBPWV65AAUJ4t5Qg3tYPqs8hY5TxXXOAg8	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	\N
$4VQxBaDA6dKjPvqNVj95IwQXv3QL3a-bXdpp4EyG9yo	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	\N
$XLYrVIK-R-MtOR1YnQaG3APBProvOP79zhKQSr95HqE	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	\N
$bm6jSsPXymAqmwjgIzaCnnJ6c2n_z2s5EzuLfrNVKvE	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	\N
$qjaNmlKX4IG53qDAgTwuNoxohPKncklE70COvnTRmxc	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	\N
$LgX6qWXYlaiVRDlpKJmG6b1DcgpCsOwZlJZ0c9LjXmw	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	\N
$eKKl-y9GISjb7jjkVd_Vn_qgDxbMFvFS-A5GytvRyVA	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	\N
$eMJm6wCYpxKfgz2KOhEAL5wkidGtV_nWPvoVzahFQ_w	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	\N
$V3iPyXBY5Rdjfq2cwuP29HNjpy0XdkW-xZbfClfMyX8	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	\N
$iT2ZJrZtDk-8_lxymECQMqYbECP_dXcTXNOuVCnSanc	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	\N
$1TrVYjSyP6cjgknVY8uql_PO0hzYnXoh_Q5UcPnCrZo	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	\N
$7MV6cVe8OZRcCQoQ--G1tiE1hrAYBgcNJdkoRnK9cCQ	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	\N
$7kJDwW-2jhnIS4etX9TjGAX6-TcSeK1X5c2IXBKIYvg	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	\N
$aqyW9vUrxdObe9RJw6v5sRs4rGwiu8gB_G28XjM_ZIY	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	\N
$CZrqEW9z_cBAHrxuxxcYegi7fg1tf20O1jmxL17mC9Y	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	\N
$5AKU6xT-ue4wUP91q_e8RberEbyIcJxjftWsBfd5390	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	\N
$BzGhHpwzF69iD1LpgSzUCmR1BGptwZ_OUHk4PeOzJP0	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	\N
$d8H-cks_WJ2pUVeQBHNQjxwMxQQ0dsVns9Egvk6ZZSY	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	\N
$dML7rSy7hzRtf__Ngjhbwue3LB55pJlChEmQb7TTrUA	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	\N
$RwIZxuK_hLp0XkjhXtRp1uSYNLClkMGppfpR_voC8MU	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	\N
$PUa692WLwxL3-4B_FJ5fKAezQeDkQvk0Mt4aK6y6bKU	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	\N
$OP5HTw1PQzzmVnL4rM6W9vo_5awgP51OChBdnKJUw3k	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	\N
$Gq6AiRbih1LLH4wkJuCyznmTxYjtNTs_3rlzFDU1SLk	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	\N
$21WoLTVJrJ52kKvP6FJpyDr7jDrBBFwJ8jtLVe5BxoE	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	\N
$De7JBlVgW8VX8ZxAOpb5VsKlSpBrrkExJPDpY6Jb2eQ	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	\N
$zpGESsEospA4z5J4JRYQhBomXyVjLg0lwLJpTY6TrFw	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	\N
$z5XMi95yi1w0KN3jNQ-MskRCNLMJBwr2DZ949BQkcOA	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	\N
$ZCrE8n-g5lxd9QFIdUh_5iwteqPL5nimDqoJjpvZbFw	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	\N
$P-cjsZvHLir5EVtcPh_t3mCvn8_Lc4bfG_lOprYS1U4	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	\N
$utAs_ygC9AwIZbOfZwzq7nGH_lAonZbFfYMq25Sbnes	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	\N
$bEJ_JyOf1Ygj-Cm0huzAPtvmILPNN--9n3pzgagwWmI	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	\N
$Q73eZCSY4oV7fYHAJT-iw3ItAuHA58eqRH82uGwH44w	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	\N
$PmKTWj14_fU64-YCl_JArQdeIIgT1glyUAP8DQBs0uI	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	\N
$fyV6TMmTq9wDrYp9EN2Aw5D0DmsfhzoTxlQ1m0pSZAE	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	\N
$p-JIkw6J2K6wxu8JkmJXlKjanI9p7AuZUDneiYknsFc	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	\N
$4W6pWQc6IgcxfGV0EHiFYFQtkY1qCo6APGtlCAr60LU	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	\N
$whRcD0OyHSdXs5wCZ-Gol9e_KUH--BOTyu1FkYhhQ8E	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	\N
$yFVhlEG5pdVcYKH9LhbJ96IK79GygR0jCiB4NU7HPYM	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	\N
$Dp5Q-o1kO6cZxdLOQVR1Ba5ymgYTF0qKir8rd5XVyd8	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	\N
$sZ_xzte7aB_ofIWratL2US43tIv1Stl0DOtQuVuXIcE	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	\N
$pRbv28FK8ljHETiS081PP5TzzhsKXQ6FELLbCQtcHy4	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	\N
$I9BAqY-jJivf3BugaTzIjWwCq4Vsthp2Srzia5sBtvs	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	\N
$sCYM3URaqv6flwwrn8lHRJpDn83Sz8RuF7bYxgb0i8g	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	\N
$RFfsT0l03gEKL7fV86ElHnmtu7jGdj4KRpuuCyQKLh0	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	\N
$dcq0w5YsiXgEtTRJPYWW2GDKRM3k4SjC-ab3rJOSh7Q	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	\N
$DaEV2INCT0t6y3M79Y5P4M-s3jrmnFbl0thmqnRCeWM	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	\N
$74eOdDCOl9SWRA3dJaPSiB4EC_sX__ThIgxmrPtmbZE	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	\N
$rT4YjNqnp8qiyQZIGMLIgPcDOrWgpTUHj-uEqSq5eFA	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	\N
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
40	29
41	40
42	28
43	40
44	42
45	40
46	42
47	40
48	42
49	40
50	42
51	40
52	42
53	40
54	42
56	55
57	56
58	57
59	58
60	59
61	60
62	57
63	57
64	61
65	61
66	64
67	66
68	66
69	66
70	66
71	66
72	40
73	42
74	73
75	72
76	74
77	72
78	76
79	77
80	78
81	80
82	79
83	81
84	82
85	83
86	84
87	86
88	85
89	88
90	87
91	90
92	89
93	92
94	91
95	93
96	94
97	96
98	95
99	98
100	97
101	99
102	100
103	102
104	101
105	104
106	103
107	105
108	106
109	107
110	108
111	110
112	109
113	112
114	111
115	113
116	114
117	115
118	116
119	118
120	117
121	120
122	119
123	122
124	121
125	124
126	123
127	126
128	125
129	127
130	128
131	129
132	130
134	131
133	132
135	133
136	134
137	135
138	136
139	138
140	137
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
40	!YmJPedFXUiFFGzTnFq:localhost	$4Wo5EetfrJ0oD7aWVI6CvS_-ZUM3lsyzkFZeQElMcmI
41	!YmJPedFXUiFFGzTnFq:localhost	$6w70vRvj0kn4T8rZE54v8sSsEpx4KtpAxyV7FaI0cSw
42	!DaecDLDoTLOuqPWadN:localhost	$eOdfuP6TezgWF5799z0-muVXLh1k8LvHE2Wfob0cC3A
43	!YmJPedFXUiFFGzTnFq:localhost	$44k35CGR6tzobtvcWU_g8j4r598Qv0F1nxC-RuTVtp0
44	!DaecDLDoTLOuqPWadN:localhost	$RZNaqMuxzSKbGmII0VVyW_QzavBCvyk_lhydR7ro7rs
45	!YmJPedFXUiFFGzTnFq:localhost	$f9CjpaONdwC3KqTPS4KboUJoNMCQgH_n9K1530Vvt2k
46	!DaecDLDoTLOuqPWadN:localhost	$aQlksTET0vw59lBpnhJY-pEdzA2dj1PQ8bVcx-gDXjM
47	!YmJPedFXUiFFGzTnFq:localhost	$ItvhbiMfhraXCbvSjAWtfnM-JTnZVezLD5MjhBNTEQQ
48	!DaecDLDoTLOuqPWadN:localhost	$ux7nr4olRQgV2FSueXtOfU3Td-GMbfsf9c7dUfZF2aY
49	!YmJPedFXUiFFGzTnFq:localhost	$iFTzxNi6ScgAzt3-ZYqtyB17NgFe4qxhMLaO0XiPUWY
50	!DaecDLDoTLOuqPWadN:localhost	$rhSx9z-K6J1vLh3H1rbZf9ZVWaEXhXRpsyF1Czg4hIw
51	!YmJPedFXUiFFGzTnFq:localhost	$x3z-Fk2JlIoHUGbYZpMURxtsoY4_EUbyGfr8HAFXqLw
52	!DaecDLDoTLOuqPWadN:localhost	$2WCF1t4K-dctasECaw6DeT05oVTrQYr-SzgJ2vNNv78
53	!YmJPedFXUiFFGzTnFq:localhost	$J5tTycPHWTG5YNx19SX1a6CE3TZKRB1DXDwdfr-7jzI
54	!DaecDLDoTLOuqPWadN:localhost	$S-lWhJbr5OhcO_LXYKoZZwCd_JonU62JYDPrlYxZsVc
55	!ZAIhwwJJQkZbVCWAWl:localhost	$SCwfg4xWBzxHVcFLtW1DbcDU4LMVkfgjYJG-qdUypcM
56	!ZAIhwwJJQkZbVCWAWl:localhost	$SCwfg4xWBzxHVcFLtW1DbcDU4LMVkfgjYJG-qdUypcM
57	!ZAIhwwJJQkZbVCWAWl:localhost	$RB7fKTVNYlqIOEPsSHLuZd4VtyQWzJBKjadsEKrzboc
58	!ZAIhwwJJQkZbVCWAWl:localhost	$VypxR6iKVehL3VR2C035y9gijIu-KXtOmJ85mKX9XLI
59	!ZAIhwwJJQkZbVCWAWl:localhost	$qx1E7MsFRdI9CbDeDYHg3A8XeN6MXU2rkBGCoxPB5mw
60	!ZAIhwwJJQkZbVCWAWl:localhost	$1kUMRxz6Q6tB2pRvD-yuOBQbj2dooMjTGymKWTyL_I0
61	!ZAIhwwJJQkZbVCWAWl:localhost	$MWD--uqyNXbmKDBMJob9sDY5AM4riTmkAwwz36FIaPk
62	!ZAIhwwJJQkZbVCWAWl:localhost	$R-loB3KHB2GwS9dI8w_nPQ5TbYDq-M3nGktxU2V0kdw
63	!ZAIhwwJJQkZbVCWAWl:localhost	$Hqc06CO1EuF0eBaOFmoW_Yhx9Jpu0jr9JTJjTSIMA8c
64	!ZAIhwwJJQkZbVCWAWl:localhost	$a1xA663y2WchzA_Q5jmTKVlInC_HDgPTK8C2g37ysdk
65	!ZAIhwwJJQkZbVCWAWl:localhost	$wdUPyT-0i7vmiiPz1WNunqvPAIWSfFtnwV1OizPIkvg
66	!ZAIhwwJJQkZbVCWAWl:localhost	$7TTiE_XzV7O5cBv-HjI3odMbxWLmfFENqxpqwJYDpBk
67	!ZAIhwwJJQkZbVCWAWl:localhost	$7TTiE_XzV7O5cBv-HjI3odMbxWLmfFENqxpqwJYDpBk
68	!ZAIhwwJJQkZbVCWAWl:localhost	$TWs4FQvX4V7Q8gMkAxaoYBjOVra311IGYeXC0HBhtyw
69	!ZAIhwwJJQkZbVCWAWl:localhost	$v0mFd7c5-e8BXKkx-MLQMwvSpvYm9S_g8mVJwGnS0-A
70	!ZAIhwwJJQkZbVCWAWl:localhost	$ZERrnpMxp7EfjGmpdGY9px4gY9TPdnqKEF_w4TStP14
71	!ZAIhwwJJQkZbVCWAWl:localhost	$al7p9tH0ZoT5Yu3HsYz1r2ak-9HkXf2coQ7KKeBerUk
72	!YmJPedFXUiFFGzTnFq:localhost	$E44xF_r_bYO9HOH-lw-VkWepvoS6z9dxDWthhfbpT9M
73	!DaecDLDoTLOuqPWadN:localhost	$PksohbU2dYCXTn5ETrl9bIqsEVAPP0Wohp--_6XwmYg
74	!DaecDLDoTLOuqPWadN:localhost	$ycR02cfa_D8mViUfnzHTBMWRlLibcN2pYZDwiiQUt8I
75	!YmJPedFXUiFFGzTnFq:localhost	$lRVMDyKED4Y7p59SRXp-sYB7lrHCN6QxRnVyO2N14a8
76	!DaecDLDoTLOuqPWadN:localhost	$4EiubgnrkRAh09BKQLVXOeE9xGDhNpI_objrHMKclmA
77	!YmJPedFXUiFFGzTnFq:localhost	$9-LSz3ddCTGWUa1IWqJRNNSh2mJrY7YVMY_uo340Sek
78	!DaecDLDoTLOuqPWadN:localhost	$n7_pif4S0hNHmw6iRBbW8iOHiFYTB60HnOnp4zhPUiM
79	!YmJPedFXUiFFGzTnFq:localhost	$a185DaoMSzelXmfPlkcYOe3H3zITI_nFoVFWjnPmTu8
80	!DaecDLDoTLOuqPWadN:localhost	$Y6Vh2Kkasecp6HyMWxXbvX7gYSqrx6mIGOOROWKR1Hs
81	!DaecDLDoTLOuqPWadN:localhost	$84NzkDN2QGVP9qS7o_z1qOhaHe5-fSbz4Vs2SiNDPo0
82	!YmJPedFXUiFFGzTnFq:localhost	$tvfSz5Kqzjfh39pYs3yfctIZoJQ09aOzDx4YZvZDlyc
83	!DaecDLDoTLOuqPWadN:localhost	$oU5B1qtEraaFCsivi4-r4WT9WGSSBIzW-i7EDPYS-eE
84	!YmJPedFXUiFFGzTnFq:localhost	$DhWWh8GrURTFDa120InvAq5u-MKwyslHHOkRAcsUhaQ
85	!DaecDLDoTLOuqPWadN:localhost	$toF4I3EB1pERgvaXBIbhBugPExKQ2bOI0J6aOngeVI4
86	!YmJPedFXUiFFGzTnFq:localhost	$HvHWZQ09kf-ICUV-Ar9JELFLWq2tJUi2ull2GBzbx9U
87	!YmJPedFXUiFFGzTnFq:localhost	$81XepwsM4YptvtHgl3P5SaUSvkP94S2d7apqzJ78aFk
88	!DaecDLDoTLOuqPWadN:localhost	$4ODGclJajZc3SV1KXAMLeoAZrYyBdfzBaT-uorLgyJ8
89	!DaecDLDoTLOuqPWadN:localhost	$Pk6fFbdC0REz3T43EROb2OhYqN4o1ptnYGXXeyMDxkE
90	!YmJPedFXUiFFGzTnFq:localhost	$dL0sqD6DHzPvOsuGJe1kcseFEXgtsK3Q59XyD3PJVk4
91	!YmJPedFXUiFFGzTnFq:localhost	$DsB5975yzOpruMKKVBUYRHB3MSljJYHh3p7763sNf2I
92	!DaecDLDoTLOuqPWadN:localhost	$7Op41p6mCUbcp5TuaBcCF4mMRwPYz6lWW7a943BDG8o
93	!DaecDLDoTLOuqPWadN:localhost	$V4DFlazGXeBPWV65AAUJ4t5Qg3tYPqs8hY5TxXXOAg8
94	!YmJPedFXUiFFGzTnFq:localhost	$4VQxBaDA6dKjPvqNVj95IwQXv3QL3a-bXdpp4EyG9yo
95	!DaecDLDoTLOuqPWadN:localhost	$bm6jSsPXymAqmwjgIzaCnnJ6c2n_z2s5EzuLfrNVKvE
96	!YmJPedFXUiFFGzTnFq:localhost	$XLYrVIK-R-MtOR1YnQaG3APBProvOP79zhKQSr95HqE
97	!YmJPedFXUiFFGzTnFq:localhost	$qjaNmlKX4IG53qDAgTwuNoxohPKncklE70COvnTRmxc
98	!DaecDLDoTLOuqPWadN:localhost	$LgX6qWXYlaiVRDlpKJmG6b1DcgpCsOwZlJZ0c9LjXmw
99	!DaecDLDoTLOuqPWadN:localhost	$eMJm6wCYpxKfgz2KOhEAL5wkidGtV_nWPvoVzahFQ_w
100	!YmJPedFXUiFFGzTnFq:localhost	$eKKl-y9GISjb7jjkVd_Vn_qgDxbMFvFS-A5GytvRyVA
101	!DaecDLDoTLOuqPWadN:localhost	$V3iPyXBY5Rdjfq2cwuP29HNjpy0XdkW-xZbfClfMyX8
102	!YmJPedFXUiFFGzTnFq:localhost	$iT2ZJrZtDk-8_lxymECQMqYbECP_dXcTXNOuVCnSanc
103	!YmJPedFXUiFFGzTnFq:localhost	$1TrVYjSyP6cjgknVY8uql_PO0hzYnXoh_Q5UcPnCrZo
104	!DaecDLDoTLOuqPWadN:localhost	$7MV6cVe8OZRcCQoQ--G1tiE1hrAYBgcNJdkoRnK9cCQ
105	!DaecDLDoTLOuqPWadN:localhost	$7kJDwW-2jhnIS4etX9TjGAX6-TcSeK1X5c2IXBKIYvg
106	!YmJPedFXUiFFGzTnFq:localhost	$aqyW9vUrxdObe9RJw6v5sRs4rGwiu8gB_G28XjM_ZIY
107	!DaecDLDoTLOuqPWadN:localhost	$CZrqEW9z_cBAHrxuxxcYegi7fg1tf20O1jmxL17mC9Y
108	!YmJPedFXUiFFGzTnFq:localhost	$5AKU6xT-ue4wUP91q_e8RberEbyIcJxjftWsBfd5390
109	!DaecDLDoTLOuqPWadN:localhost	$BzGhHpwzF69iD1LpgSzUCmR1BGptwZ_OUHk4PeOzJP0
110	!YmJPedFXUiFFGzTnFq:localhost	$d8H-cks_WJ2pUVeQBHNQjxwMxQQ0dsVns9Egvk6ZZSY
111	!YmJPedFXUiFFGzTnFq:localhost	$dML7rSy7hzRtf__Ngjhbwue3LB55pJlChEmQb7TTrUA
112	!DaecDLDoTLOuqPWadN:localhost	$RwIZxuK_hLp0XkjhXtRp1uSYNLClkMGppfpR_voC8MU
113	!DaecDLDoTLOuqPWadN:localhost	$PUa692WLwxL3-4B_FJ5fKAezQeDkQvk0Mt4aK6y6bKU
114	!YmJPedFXUiFFGzTnFq:localhost	$OP5HTw1PQzzmVnL4rM6W9vo_5awgP51OChBdnKJUw3k
115	!DaecDLDoTLOuqPWadN:localhost	$Gq6AiRbih1LLH4wkJuCyznmTxYjtNTs_3rlzFDU1SLk
116	!YmJPedFXUiFFGzTnFq:localhost	$21WoLTVJrJ52kKvP6FJpyDr7jDrBBFwJ8jtLVe5BxoE
117	!DaecDLDoTLOuqPWadN:localhost	$De7JBlVgW8VX8ZxAOpb5VsKlSpBrrkExJPDpY6Jb2eQ
118	!YmJPedFXUiFFGzTnFq:localhost	$zpGESsEospA4z5J4JRYQhBomXyVjLg0lwLJpTY6TrFw
119	!YmJPedFXUiFFGzTnFq:localhost	$ZCrE8n-g5lxd9QFIdUh_5iwteqPL5nimDqoJjpvZbFw
120	!DaecDLDoTLOuqPWadN:localhost	$z5XMi95yi1w0KN3jNQ-MskRCNLMJBwr2DZ949BQkcOA
121	!DaecDLDoTLOuqPWadN:localhost	$P-cjsZvHLir5EVtcPh_t3mCvn8_Lc4bfG_lOprYS1U4
122	!YmJPedFXUiFFGzTnFq:localhost	$utAs_ygC9AwIZbOfZwzq7nGH_lAonZbFfYMq25Sbnes
123	!YmJPedFXUiFFGzTnFq:localhost	$Q73eZCSY4oV7fYHAJT-iw3ItAuHA58eqRH82uGwH44w
124	!DaecDLDoTLOuqPWadN:localhost	$bEJ_JyOf1Ygj-Cm0huzAPtvmILPNN--9n3pzgagwWmI
125	!DaecDLDoTLOuqPWadN:localhost	$PmKTWj14_fU64-YCl_JArQdeIIgT1glyUAP8DQBs0uI
126	!YmJPedFXUiFFGzTnFq:localhost	$fyV6TMmTq9wDrYp9EN2Aw5D0DmsfhzoTxlQ1m0pSZAE
127	!YmJPedFXUiFFGzTnFq:localhost	$p-JIkw6J2K6wxu8JkmJXlKjanI9p7AuZUDneiYknsFc
128	!DaecDLDoTLOuqPWadN:localhost	$4W6pWQc6IgcxfGV0EHiFYFQtkY1qCo6APGtlCAr60LU
129	!YmJPedFXUiFFGzTnFq:localhost	$whRcD0OyHSdXs5wCZ-Gol9e_KUH--BOTyu1FkYhhQ8E
130	!DaecDLDoTLOuqPWadN:localhost	$yFVhlEG5pdVcYKH9LhbJ96IK79GygR0jCiB4NU7HPYM
131	!YmJPedFXUiFFGzTnFq:localhost	$Dp5Q-o1kO6cZxdLOQVR1Ba5ymgYTF0qKir8rd5XVyd8
132	!DaecDLDoTLOuqPWadN:localhost	$sZ_xzte7aB_ofIWratL2US43tIv1Stl0DOtQuVuXIcE
134	!YmJPedFXUiFFGzTnFq:localhost	$I9BAqY-jJivf3BugaTzIjWwCq4Vsthp2Srzia5sBtvs
133	!DaecDLDoTLOuqPWadN:localhost	$pRbv28FK8ljHETiS081PP5TzzhsKXQ6FELLbCQtcHy4
135	!DaecDLDoTLOuqPWadN:localhost	$sCYM3URaqv6flwwrn8lHRJpDn83Sz8RuF7bYxgb0i8g
136	!YmJPedFXUiFFGzTnFq:localhost	$RFfsT0l03gEKL7fV86ElHnmtu7jGdj4KRpuuCyQKLh0
137	!DaecDLDoTLOuqPWadN:localhost	$dcq0w5YsiXgEtTRJPYWW2GDKRM3k4SjC-ab3rJOSh7Q
138	!YmJPedFXUiFFGzTnFq:localhost	$DaEV2INCT0t6y3M79Y5P4M-s3jrmnFbl0thmqnRCeWM
139	!YmJPedFXUiFFGzTnFq:localhost	$rT4YjNqnp8qiyQZIGMLIgPcDOrWgpTUHj-uEqSq5eFA
140	!DaecDLDoTLOuqPWadN:localhost	$74eOdDCOl9SWRA3dJaPSiB4EC_sX__ThIgxmrPtmbZE
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
40	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@user1.matrix:localhost	$4Wo5EetfrJ0oD7aWVI6CvS_-ZUM3lsyzkFZeQElMcmI
41	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@user1.matrix:localhost	$6w70vRvj0kn4T8rZE54v8sSsEpx4KtpAxyV7FaI0cSw
42	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@user1.matrix:localhost	$eOdfuP6TezgWF5799z0-muVXLh1k8LvHE2Wfob0cC3A
43	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$44k35CGR6tzobtvcWU_g8j4r598Qv0F1nxC-RuTVtp0
44	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$RZNaqMuxzSKbGmII0VVyW_QzavBCvyk_lhydR7ro7rs
45	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$f9CjpaONdwC3KqTPS4KboUJoNMCQgH_n9K1530Vvt2k
46	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$aQlksTET0vw59lBpnhJY-pEdzA2dj1PQ8bVcx-gDXjM
47	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$ItvhbiMfhraXCbvSjAWtfnM-JTnZVezLD5MjhBNTEQQ
48	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$ux7nr4olRQgV2FSueXtOfU3Td-GMbfsf9c7dUfZF2aY
49	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$iFTzxNi6ScgAzt3-ZYqtyB17NgFe4qxhMLaO0XiPUWY
50	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$rhSx9z-K6J1vLh3H1rbZf9ZVWaEXhXRpsyF1Czg4hIw
51	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$x3z-Fk2JlIoHUGbYZpMURxtsoY4_EUbyGfr8HAFXqLw
52	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$2WCF1t4K-dctasECaw6DeT05oVTrQYr-SzgJ2vNNv78
53	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$J5tTycPHWTG5YNx19SX1a6CE3TZKRB1DXDwdfr-7jzI
54	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$S-lWhJbr5OhcO_LXYKoZZwCd_JonU62JYDPrlYxZsVc
56	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.create		$SCwfg4xWBzxHVcFLtW1DbcDU4LMVkfgjYJG-qdUypcM
57	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.member	@user1.matrix:localhost	$RB7fKTVNYlqIOEPsSHLuZd4VtyQWzJBKjadsEKrzboc
58	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.power_levels		$VypxR6iKVehL3VR2C035y9gijIu-KXtOmJ85mKX9XLI
59	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.canonical_alias		$qx1E7MsFRdI9CbDeDYHg3A8XeN6MXU2rkBGCoxPB5mw
60	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.join_rules		$1kUMRxz6Q6tB2pRvD-yuOBQbj2dooMjTGymKWTyL_I0
61	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.history_visibility		$MWD--uqyNXbmKDBMJob9sDY5AM4riTmkAwwz36FIaPk
62	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.member	@matterbot:localhost	$R-loB3KHB2GwS9dI8w_nPQ5TbYDq-M3nGktxU2V0kdw
63	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.member	@matterbot:localhost	$Hqc06CO1EuF0eBaOFmoW_Yhx9Jpu0jr9JTJjTSIMA8c
67	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.member	@matterbot:localhost	$7TTiE_XzV7O5cBv-HjI3odMbxWLmfFENqxpqwJYDpBk
68	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.member	@matterbot:localhost	$TWs4FQvX4V7Q8gMkAxaoYBjOVra311IGYeXC0HBhtyw
64	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.name		$a1xA663y2WchzA_Q5jmTKVlInC_HDgPTK8C2g37ysdk
66	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.member	@matterbot:localhost	$wdUPyT-0i7vmiiPz1WNunqvPAIWSfFtnwV1OizPIkvg
70	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.member	@matterbot:localhost	$ZERrnpMxp7EfjGmpdGY9px4gY9TPdnqKEF_w4TStP14
65	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.member	@matterbot:localhost	$wdUPyT-0i7vmiiPz1WNunqvPAIWSfFtnwV1OizPIkvg
69	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.member	@matterbot:localhost	$v0mFd7c5-e8BXKkx-MLQMwvSpvYm9S_g8mVJwGnS0-A
71	!ZAIhwwJJQkZbVCWAWl:localhost	m.room.member	@mm_admin:localhost	$al7p9tH0ZoT5Yu3HsYz1r2ak-9HkXf2coQ7KKeBerUk
72	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$E44xF_r_bYO9HOH-lw-VkWepvoS6z9dxDWthhfbpT9M
73	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$PksohbU2dYCXTn5ETrl9bIqsEVAPP0Wohp--_6XwmYg
74	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$ycR02cfa_D8mViUfnzHTBMWRlLibcN2pYZDwiiQUt8I
75	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$lRVMDyKED4Y7p59SRXp-sYB7lrHCN6QxRnVyO2N14a8
76	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$4EiubgnrkRAh09BKQLVXOeE9xGDhNpI_objrHMKclmA
77	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$9-LSz3ddCTGWUa1IWqJRNNSh2mJrY7YVMY_uo340Sek
78	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$n7_pif4S0hNHmw6iRBbW8iOHiFYTB60HnOnp4zhPUiM
79	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$a185DaoMSzelXmfPlkcYOe3H3zITI_nFoVFWjnPmTu8
80	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$Y6Vh2Kkasecp6HyMWxXbvX7gYSqrx6mIGOOROWKR1Hs
81	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$84NzkDN2QGVP9qS7o_z1qOhaHe5-fSbz4Vs2SiNDPo0
82	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$tvfSz5Kqzjfh39pYs3yfctIZoJQ09aOzDx4YZvZDlyc
83	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$oU5B1qtEraaFCsivi4-r4WT9WGSSBIzW-i7EDPYS-eE
84	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$DhWWh8GrURTFDa120InvAq5u-MKwyslHHOkRAcsUhaQ
85	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$toF4I3EB1pERgvaXBIbhBugPExKQ2bOI0J6aOngeVI4
86	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$HvHWZQ09kf-ICUV-Ar9JELFLWq2tJUi2ull2GBzbx9U
87	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$81XepwsM4YptvtHgl3P5SaUSvkP94S2d7apqzJ78aFk
88	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$4ODGclJajZc3SV1KXAMLeoAZrYyBdfzBaT-uorLgyJ8
89	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$Pk6fFbdC0REz3T43EROb2OhYqN4o1ptnYGXXeyMDxkE
90	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$dL0sqD6DHzPvOsuGJe1kcseFEXgtsK3Q59XyD3PJVk4
91	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$DsB5975yzOpruMKKVBUYRHB3MSljJYHh3p7763sNf2I
92	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$7Op41p6mCUbcp5TuaBcCF4mMRwPYz6lWW7a943BDG8o
93	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$V4DFlazGXeBPWV65AAUJ4t5Qg3tYPqs8hY5TxXXOAg8
94	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$4VQxBaDA6dKjPvqNVj95IwQXv3QL3a-bXdpp4EyG9yo
95	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$bm6jSsPXymAqmwjgIzaCnnJ6c2n_z2s5EzuLfrNVKvE
96	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$XLYrVIK-R-MtOR1YnQaG3APBProvOP79zhKQSr95HqE
97	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$qjaNmlKX4IG53qDAgTwuNoxohPKncklE70COvnTRmxc
98	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$LgX6qWXYlaiVRDlpKJmG6b1DcgpCsOwZlJZ0c9LjXmw
99	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$eMJm6wCYpxKfgz2KOhEAL5wkidGtV_nWPvoVzahFQ_w
100	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$eKKl-y9GISjb7jjkVd_Vn_qgDxbMFvFS-A5GytvRyVA
101	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$V3iPyXBY5Rdjfq2cwuP29HNjpy0XdkW-xZbfClfMyX8
102	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$iT2ZJrZtDk-8_lxymECQMqYbECP_dXcTXNOuVCnSanc
103	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$1TrVYjSyP6cjgknVY8uql_PO0hzYnXoh_Q5UcPnCrZo
104	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$7MV6cVe8OZRcCQoQ--G1tiE1hrAYBgcNJdkoRnK9cCQ
105	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$7kJDwW-2jhnIS4etX9TjGAX6-TcSeK1X5c2IXBKIYvg
106	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$aqyW9vUrxdObe9RJw6v5sRs4rGwiu8gB_G28XjM_ZIY
107	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$CZrqEW9z_cBAHrxuxxcYegi7fg1tf20O1jmxL17mC9Y
108	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$5AKU6xT-ue4wUP91q_e8RberEbyIcJxjftWsBfd5390
109	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$BzGhHpwzF69iD1LpgSzUCmR1BGptwZ_OUHk4PeOzJP0
110	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$d8H-cks_WJ2pUVeQBHNQjxwMxQQ0dsVns9Egvk6ZZSY
111	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$dML7rSy7hzRtf__Ngjhbwue3LB55pJlChEmQb7TTrUA
112	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$RwIZxuK_hLp0XkjhXtRp1uSYNLClkMGppfpR_voC8MU
113	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$PUa692WLwxL3-4B_FJ5fKAezQeDkQvk0Mt4aK6y6bKU
114	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$OP5HTw1PQzzmVnL4rM6W9vo_5awgP51OChBdnKJUw3k
115	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$Gq6AiRbih1LLH4wkJuCyznmTxYjtNTs_3rlzFDU1SLk
119	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$ZCrE8n-g5lxd9QFIdUh_5iwteqPL5nimDqoJjpvZbFw
127	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$p-JIkw6J2K6wxu8JkmJXlKjanI9p7AuZUDneiYknsFc
116	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$21WoLTVJrJ52kKvP6FJpyDr7jDrBBFwJ8jtLVe5BxoE
130	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$yFVhlEG5pdVcYKH9LhbJ96IK79GygR0jCiB4NU7HPYM
118	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$zpGESsEospA4z5J4JRYQhBomXyVjLg0lwLJpTY6TrFw
121	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$P-cjsZvHLir5EVtcPh_t3mCvn8_Lc4bfG_lOprYS1U4
122	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$utAs_ygC9AwIZbOfZwzq7nGH_lAonZbFfYMq25Sbnes
126	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$fyV6TMmTq9wDrYp9EN2Aw5D0DmsfhzoTxlQ1m0pSZAE
117	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$De7JBlVgW8VX8ZxAOpb5VsKlSpBrrkExJPDpY6Jb2eQ
120	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$z5XMi95yi1w0KN3jNQ-MskRCNLMJBwr2DZ949BQkcOA
123	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$Q73eZCSY4oV7fYHAJT-iw3ItAuHA58eqRH82uGwH44w
124	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$bEJ_JyOf1Ygj-Cm0huzAPtvmILPNN--9n3pzgagwWmI
125	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$PmKTWj14_fU64-YCl_JArQdeIIgT1glyUAP8DQBs0uI
129	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$whRcD0OyHSdXs5wCZ-Gol9e_KUH--BOTyu1FkYhhQ8E
128	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$4W6pWQc6IgcxfGV0EHiFYFQtkY1qCo6APGtlCAr60LU
131	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$Dp5Q-o1kO6cZxdLOQVR1Ba5ymgYTF0qKir8rd5XVyd8
132	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$sZ_xzte7aB_ofIWratL2US43tIv1Stl0DOtQuVuXIcE
134	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$I9BAqY-jJivf3BugaTzIjWwCq4Vsthp2Srzia5sBtvs
133	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$pRbv28FK8ljHETiS081PP5TzzhsKXQ6FELLbCQtcHy4
135	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$sCYM3URaqv6flwwrn8lHRJpDn83Sz8RuF7bYxgb0i8g
136	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$RFfsT0l03gEKL7fV86ElHnmtu7jGdj4KRpuuCyQKLh0
137	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$dcq0w5YsiXgEtTRJPYWW2GDKRM3k4SjC-ab3rJOSh7Q
138	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$DaEV2INCT0t6y3M79Y5P4M-s3jrmnFbl0thmqnRCeWM
139	!YmJPedFXUiFFGzTnFq:localhost	m.room.member	@matterbot:localhost	$rT4YjNqnp8qiyQZIGMLIgPcDOrWgpTUHj-uEqSq5eFA
140	!DaecDLDoTLOuqPWadN:localhost	m.room.member	@matterbot:localhost	$74eOdDCOl9SWRA3dJaPSiB4EC_sX__ThIgxmrPtmbZE
\.


--
-- Data for Name: stats_incremental_position; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.stats_incremental_position (lock, stream_id) FROM stdin;
X	113
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
25	!YmJPedFXUiFFGzTnFq:localhost	$4Wo5EetfrJ0oD7aWVI6CvS_-ZUM3lsyzkFZeQElMcmI
26	!DaecDLDoTLOuqPWadN:localhost	$eOdfuP6TezgWF5799z0-muVXLh1k8LvHE2Wfob0cC3A
27	!DaecDLDoTLOuqPWadN:localhost	$gQgbgv5fxFXlqv1ijNKbz-lh6k1tNCvxkocpyKVWVRs
28	!DaecDLDoTLOuqPWadN:localhost	$dmuQAnknZxpgqjpjtYIvJcdnBBRW5Te8hQ85WDS7uEw
29	!DaecDLDoTLOuqPWadN:localhost	$mAU9A94YjP4DM004IBnCOQl3huTesAnKbo1CkVX7wMg
30	!DaecDLDoTLOuqPWadN:localhost	$yGEzNJBRRycOk7KUDyR_XFaYOvJ4Hi44-bm0_UqUCeE
31	!ZAIhwwJJQkZbVCWAWl:localhost	$SCwfg4xWBzxHVcFLtW1DbcDU4LMVkfgjYJG-qdUypcM
32	!ZAIhwwJJQkZbVCWAWl:localhost	$RB7fKTVNYlqIOEPsSHLuZd4VtyQWzJBKjadsEKrzboc
36	!ZAIhwwJJQkZbVCWAWl:localhost	$MWD--uqyNXbmKDBMJob9sDY5AM4riTmkAwwz36FIaPk
37	!ZAIhwwJJQkZbVCWAWl:localhost	$a1xA663y2WchzA_Q5jmTKVlInC_HDgPTK8C2g37ysdk
38	!ZAIhwwJJQkZbVCWAWl:localhost	$wdUPyT-0i7vmiiPz1WNunqvPAIWSfFtnwV1OizPIkvg
38	!ZAIhwwJJQkZbVCWAWl:localhost	$a1xA663y2WchzA_Q5jmTKVlInC_HDgPTK8C2g37ysdk
39	!ZAIhwwJJQkZbVCWAWl:localhost	$kULillGfRc9dmdALLVuNmIhsQ0DV5vjLVAQvpHNKHG8
40	!ZAIhwwJJQkZbVCWAWl:localhost	$al7p9tH0ZoT5Yu3HsYz1r2ak-9HkXf2coQ7KKeBerUk
41	!ZAIhwwJJQkZbVCWAWl:localhost	$isvqtAkok4JAN-_OZRt7MG_xv-fWABZbUbvVPhtzjUI
43	!YmJPedFXUiFFGzTnFq:localhost	$E44xF_r_bYO9HOH-lw-VkWepvoS6z9dxDWthhfbpT9M
42	!DaecDLDoTLOuqPWadN:localhost	$PksohbU2dYCXTn5ETrl9bIqsEVAPP0Wohp--_6XwmYg
44	!DaecDLDoTLOuqPWadN:localhost	$ycR02cfa_D8mViUfnzHTBMWRlLibcN2pYZDwiiQUt8I
45	!DaecDLDoTLOuqPWadN:localhost	$fuPA22emW4V0wHC5EllCh7JbzYMhTIW0DLr_D73YRtU
46	!DaecDLDoTLOuqPWadN:localhost	$iZZW6EsuxUAxVBXtwcMnKFWoQkFHMXw7rvUqBVZ0wOM
47	!DaecDLDoTLOuqPWadN:localhost	$4EiubgnrkRAh09BKQLVXOeE9xGDhNpI_objrHMKclmA
48	!YmJPedFXUiFFGzTnFq:localhost	$9-LSz3ddCTGWUa1IWqJRNNSh2mJrY7YVMY_uo340Sek
49	!DaecDLDoTLOuqPWadN:localhost	$n7_pif4S0hNHmw6iRBbW8iOHiFYTB60HnOnp4zhPUiM
50	!YmJPedFXUiFFGzTnFq:localhost	$a185DaoMSzelXmfPlkcYOe3H3zITI_nFoVFWjnPmTu8
51	!DaecDLDoTLOuqPWadN:localhost	$Y6Vh2Kkasecp6HyMWxXbvX7gYSqrx6mIGOOROWKR1Hs
52	!YmJPedFXUiFFGzTnFq:localhost	$tvfSz5Kqzjfh39pYs3yfctIZoJQ09aOzDx4YZvZDlyc
53	!DaecDLDoTLOuqPWadN:localhost	$84NzkDN2QGVP9qS7o_z1qOhaHe5-fSbz4Vs2SiNDPo0
54	!DaecDLDoTLOuqPWadN:localhost	$oU5B1qtEraaFCsivi4-r4WT9WGSSBIzW-i7EDPYS-eE
55	!YmJPedFXUiFFGzTnFq:localhost	$DhWWh8GrURTFDa120InvAq5u-MKwyslHHOkRAcsUhaQ
56	!DaecDLDoTLOuqPWadN:localhost	$toF4I3EB1pERgvaXBIbhBugPExKQ2bOI0J6aOngeVI4
57	!YmJPedFXUiFFGzTnFq:localhost	$HvHWZQ09kf-ICUV-Ar9JELFLWq2tJUi2ull2GBzbx9U
58	!YmJPedFXUiFFGzTnFq:localhost	$81XepwsM4YptvtHgl3P5SaUSvkP94S2d7apqzJ78aFk
59	!DaecDLDoTLOuqPWadN:localhost	$4ODGclJajZc3SV1KXAMLeoAZrYyBdfzBaT-uorLgyJ8
60	!YmJPedFXUiFFGzTnFq:localhost	$dL0sqD6DHzPvOsuGJe1kcseFEXgtsK3Q59XyD3PJVk4
61	!DaecDLDoTLOuqPWadN:localhost	$Pk6fFbdC0REz3T43EROb2OhYqN4o1ptnYGXXeyMDxkE
62	!YmJPedFXUiFFGzTnFq:localhost	$DsB5975yzOpruMKKVBUYRHB3MSljJYHh3p7763sNf2I
63	!DaecDLDoTLOuqPWadN:localhost	$7Op41p6mCUbcp5TuaBcCF4mMRwPYz6lWW7a943BDG8o
64	!DaecDLDoTLOuqPWadN:localhost	$nD-WsmqnhEa4BIar13mUOspyj5CQ-NVfZYZo7aUnG8o
65	!ZAIhwwJJQkZbVCWAWl:localhost	$s1YwkJ0AvfbD0DFtp0NNPRSOEKYsrtf84Paq6r6Qn60
66	!YmJPedFXUiFFGzTnFq:localhost	$4VQxBaDA6dKjPvqNVj95IwQXv3QL3a-bXdpp4EyG9yo
67	!DaecDLDoTLOuqPWadN:localhost	$V4DFlazGXeBPWV65AAUJ4t5Qg3tYPqs8hY5TxXXOAg8
68	!YmJPedFXUiFFGzTnFq:localhost	$XLYrVIK-R-MtOR1YnQaG3APBProvOP79zhKQSr95HqE
69	!DaecDLDoTLOuqPWadN:localhost	$bm6jSsPXymAqmwjgIzaCnnJ6c2n_z2s5EzuLfrNVKvE
70	!YmJPedFXUiFFGzTnFq:localhost	$qjaNmlKX4IG53qDAgTwuNoxohPKncklE70COvnTRmxc
71	!DaecDLDoTLOuqPWadN:localhost	$LgX6qWXYlaiVRDlpKJmG6b1DcgpCsOwZlJZ0c9LjXmw
72	!DaecDLDoTLOuqPWadN:localhost	$eMJm6wCYpxKfgz2KOhEAL5wkidGtV_nWPvoVzahFQ_w
73	!YmJPedFXUiFFGzTnFq:localhost	$eKKl-y9GISjb7jjkVd_Vn_qgDxbMFvFS-A5GytvRyVA
74	!DaecDLDoTLOuqPWadN:localhost	$V3iPyXBY5Rdjfq2cwuP29HNjpy0XdkW-xZbfClfMyX8
75	!YmJPedFXUiFFGzTnFq:localhost	$iT2ZJrZtDk-8_lxymECQMqYbECP_dXcTXNOuVCnSanc
76	!YmJPedFXUiFFGzTnFq:localhost	$1TrVYjSyP6cjgknVY8uql_PO0hzYnXoh_Q5UcPnCrZo
77	!DaecDLDoTLOuqPWadN:localhost	$7MV6cVe8OZRcCQoQ--G1tiE1hrAYBgcNJdkoRnK9cCQ
79	!DaecDLDoTLOuqPWadN:localhost	$7kJDwW-2jhnIS4etX9TjGAX6-TcSeK1X5c2IXBKIYvg
78	!YmJPedFXUiFFGzTnFq:localhost	$aqyW9vUrxdObe9RJw6v5sRs4rGwiu8gB_G28XjM_ZIY
80	!DaecDLDoTLOuqPWadN:localhost	$CZrqEW9z_cBAHrxuxxcYegi7fg1tf20O1jmxL17mC9Y
86	!DaecDLDoTLOuqPWadN:localhost	$PUa692WLwxL3-4B_FJ5fKAezQeDkQvk0Mt4aK6y6bKU
105	!DaecDLDoTLOuqPWadN:localhost	$sZ_xzte7aB_ofIWratL2US43tIv1Stl0DOtQuVuXIcE
106	!YmJPedFXUiFFGzTnFq:localhost	$I9BAqY-jJivf3BugaTzIjWwCq4Vsthp2Srzia5sBtvs
109	!YmJPedFXUiFFGzTnFq:localhost	$RFfsT0l03gEKL7fV86ElHnmtu7jGdj4KRpuuCyQKLh0
110	!DaecDLDoTLOuqPWadN:localhost	$dcq0w5YsiXgEtTRJPYWW2GDKRM3k4SjC-ab3rJOSh7Q
112	!YmJPedFXUiFFGzTnFq:localhost	$rT4YjNqnp8qiyQZIGMLIgPcDOrWgpTUHj-uEqSq5eFA
81	!YmJPedFXUiFFGzTnFq:localhost	$5AKU6xT-ue4wUP91q_e8RberEbyIcJxjftWsBfd5390
82	!DaecDLDoTLOuqPWadN:localhost	$BzGhHpwzF69iD1LpgSzUCmR1BGptwZ_OUHk4PeOzJP0
83	!YmJPedFXUiFFGzTnFq:localhost	$d8H-cks_WJ2pUVeQBHNQjxwMxQQ0dsVns9Egvk6ZZSY
88	!DaecDLDoTLOuqPWadN:localhost	$Gq6AiRbih1LLH4wkJuCyznmTxYjtNTs_3rlzFDU1SLk
90	!DaecDLDoTLOuqPWadN:localhost	$De7JBlVgW8VX8ZxAOpb5VsKlSpBrrkExJPDpY6Jb2eQ
95	!YmJPedFXUiFFGzTnFq:localhost	$utAs_ygC9AwIZbOfZwzq7nGH_lAonZbFfYMq25Sbnes
99	!YmJPedFXUiFFGzTnFq:localhost	$fyV6TMmTq9wDrYp9EN2Aw5D0DmsfhzoTxlQ1m0pSZAE
103	!DaecDLDoTLOuqPWadN:localhost	$yFVhlEG5pdVcYKH9LhbJ96IK79GygR0jCiB4NU7HPYM
113	!DaecDLDoTLOuqPWadN:localhost	$74eOdDCOl9SWRA3dJaPSiB4EC_sX__ThIgxmrPtmbZE
84	!YmJPedFXUiFFGzTnFq:localhost	$dML7rSy7hzRtf__Ngjhbwue3LB55pJlChEmQb7TTrUA
85	!DaecDLDoTLOuqPWadN:localhost	$RwIZxuK_hLp0XkjhXtRp1uSYNLClkMGppfpR_voC8MU
87	!YmJPedFXUiFFGzTnFq:localhost	$OP5HTw1PQzzmVnL4rM6W9vo_5awgP51OChBdnKJUw3k
89	!YmJPedFXUiFFGzTnFq:localhost	$21WoLTVJrJ52kKvP6FJpyDr7jDrBBFwJ8jtLVe5BxoE
91	!YmJPedFXUiFFGzTnFq:localhost	$zpGESsEospA4z5J4JRYQhBomXyVjLg0lwLJpTY6TrFw
92	!DaecDLDoTLOuqPWadN:localhost	$z5XMi95yi1w0KN3jNQ-MskRCNLMJBwr2DZ949BQkcOA
94	!DaecDLDoTLOuqPWadN:localhost	$P-cjsZvHLir5EVtcPh_t3mCvn8_Lc4bfG_lOprYS1U4
96	!DaecDLDoTLOuqPWadN:localhost	$bEJ_JyOf1Ygj-Cm0huzAPtvmILPNN--9n3pzgagwWmI
101	!DaecDLDoTLOuqPWadN:localhost	$4W6pWQc6IgcxfGV0EHiFYFQtkY1qCo6APGtlCAr60LU
102	!YmJPedFXUiFFGzTnFq:localhost	$whRcD0OyHSdXs5wCZ-Gol9e_KUH--BOTyu1FkYhhQ8E
107	!DaecDLDoTLOuqPWadN:localhost	$pRbv28FK8ljHETiS081PP5TzzhsKXQ6FELLbCQtcHy4
108	!DaecDLDoTLOuqPWadN:localhost	$sCYM3URaqv6flwwrn8lHRJpDn83Sz8RuF7bYxgb0i8g
93	!YmJPedFXUiFFGzTnFq:localhost	$ZCrE8n-g5lxd9QFIdUh_5iwteqPL5nimDqoJjpvZbFw
97	!YmJPedFXUiFFGzTnFq:localhost	$Q73eZCSY4oV7fYHAJT-iw3ItAuHA58eqRH82uGwH44w
98	!DaecDLDoTLOuqPWadN:localhost	$PmKTWj14_fU64-YCl_JArQdeIIgT1glyUAP8DQBs0uI
104	!YmJPedFXUiFFGzTnFq:localhost	$Dp5Q-o1kO6cZxdLOQVR1Ba5ymgYTF0qKir8rd5XVyd8
111	!YmJPedFXUiFFGzTnFq:localhost	$DaEV2INCT0t6y3M79Y5P4M-s3jrmnFbl0thmqnRCeWM
100	!YmJPedFXUiFFGzTnFq:localhost	$p-JIkw6J2K6wxu8JkmJXlKjanI9p7AuZUDneiYknsFc
\.


--
-- Data for Name: stream_positions; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.stream_positions (stream_name, instance_name, stream_id) FROM stdin;
presence_stream	master	185
receipts	master	17
account_data	master	51
events	master	113
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
EPgIXnuYnJJkGvJtPUmPconx	1675794299880	{}	{}	/_matrix/client/r0/register	POST	register a new account
QvFMZhFfEcgMqZGDGFKCuSjv	1675794321508	{"password_hash":"$2b$12$/1r7DN9xE5PtoFmLXFSFHuVTx.cSHcv8OKjkKg2LRrXE13tSDm9cu","registered_user_id":"@user1.matrix:localhost"}	{"username":"user1.matrix","initial_device_display_name":"localhost:8080: Chrome p\\u00e5 macOS"}	/_matrix/client/r0/register	POST	register a new account
OQzJItFuFTEtkRwQjIYQmWiA	1675794323145	{"request_user_id":"@user1.matrix:localhost"}	{"master_key":{"user_id":"@user1.matrix:localhost","usage":["master"],"keys":{"ed25519:HzGuyT7hmhSWULANnzFTwJRYvwSFlIweFb53q28Mvt8":"HzGuyT7hmhSWULANnzFTwJRYvwSFlIweFb53q28Mvt8"},"signatures":{"@user1.matrix:localhost":{"ed25519:JAVZUYJBSA":"VYhG9TW9ihh2aytP+2N8IYImv/pBIS2niLDNSizyhLH3LitasQVQgQCHFqGjNexB7XHi/sbiwVRW1tZCbXPaBw"}}},"self_signing_key":{"user_id":"@user1.matrix:localhost","usage":["self_signing"],"keys":{"ed25519:Oe5GNOlmI6SRP2t1CfUx+N4Pgcg1a7Jjb2vgIgyhbLw":"Oe5GNOlmI6SRP2t1CfUx+N4Pgcg1a7Jjb2vgIgyhbLw"},"signatures":{"@user1.matrix:localhost":{"ed25519:HzGuyT7hmhSWULANnzFTwJRYvwSFlIweFb53q28Mvt8":"Nsf5RC89AZ698PebeBmVGcT4h2U5G5sAT8AVfUslnPwDsLwgpjttWCLguwfnWmvTqtR7DLy9ZdP1HxI9PKByCQ"}}},"user_signing_key":{"user_id":"@user1.matrix:localhost","usage":["user_signing"],"keys":{"ed25519:83s/13FiyFWV0titpBQH7EYPIFUAqJkz20Fkhlc27V4":"83s/13FiyFWV0titpBQH7EYPIFUAqJkz20Fkhlc27V4"},"signatures":{"@user1.matrix:localhost":{"ed25519:HzGuyT7hmhSWULANnzFTwJRYvwSFlIweFb53q28Mvt8":"DWQLoOK0YiswP4Cm5hGW5tzNm4q1xkTQf6rjXESzw4eOl02nGN2Yuf3SNwm4SG/88/y/ES1IDpEzoii/fCGgCQ"}}}}	/_matrix/client/unstable/keys/device_signing/upload	POST	add a device signing key to your account
\.


--
-- Data for Name: ui_auth_sessions_credentials; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.ui_auth_sessions_credentials (session_id, stage_type, result) FROM stdin;
QvFMZhFfEcgMqZGDGFKCuSjv	m.login.dummy	true
OQzJItFuFTEtkRwQjIYQmWiA	m.login.password	"@user1.matrix:localhost"
\.


--
-- Data for Name: ui_auth_sessions_ips; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.ui_auth_sessions_ips (session_id, ip, user_agent) FROM stdin;
EPgIXnuYnJJkGvJtPUmPconx	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36
QvFMZhFfEcgMqZGDGFKCuSjv	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36
OQzJItFuFTEtkRwQjIYQmWiA	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36
\.


--
-- Data for Name: user_daily_visits; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_daily_visits (user_id, device_id, "timestamp", user_agent) FROM stdin;
@admin:localhost	MCWQGRUWJV	1675209600000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36
@user1.matrix:localhost	JAVZUYJBSA	1675728000000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36
@user1.matrix:localhost	JAVZUYJBSA	1675814400000	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36
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
X	113
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
@admin:localhost	syt_YWRtaW4_zzjcJlaeJfDtltVuDqsj_3MzL9R	MCWQGRUWJV	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36	1675289375046
@user1.matrix:localhost	syt_dXNlcjEubWF0cml4_qsgIFfitnStvFzGKJtmp_4BJJm7	JAVZUYJBSA	172.16.238.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36	1675882018710
\.


--
-- Data for Name: user_signature_stream; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_signature_stream (stream_id, from_user_id, user_ids) FROM stdin;
6	@admin:localhost	["@admin:localhost"]
13	@user1.matrix:localhost	["@user1.matrix:localhost"]
\.


--
-- Data for Name: user_stats_current; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_stats_current (user_id, joined_rooms, completed_delta_stream_id) FROM stdin;
@admin:localhost	2	10
@mm_admin:localhost	2	24
@user1.matrix:localhost	3	32
@mm_user1.mm:localhost	0	43
@matterbot:localhost	3	113
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
@user1.matrix:localhost	$2b$12$.hXmHX.4WOF5B5bOatE.9uCaJaIQDYUJNT0tSdm6o9/H51e2JqO3y	1675794322	0	\N	0	\N	\N	\N	\N	0	f	\N	t
@mm_user1.mm:localhost		1675814025	0	\N	0	xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt	\N	\N	\N	0	f	\N	t
\.


--
-- Data for Name: users_in_public_rooms; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.users_in_public_rooms (user_id, room_id) FROM stdin;
@admin:localhost	!DaecDLDoTLOuqPWadN:localhost
@admin:localhost	!YmJPedFXUiFFGzTnFq:localhost
@user1.matrix:localhost	!YmJPedFXUiFFGzTnFq:localhost
@user1.matrix:localhost	!DaecDLDoTLOuqPWadN:localhost
@user1.matrix:localhost	!ZAIhwwJJQkZbVCWAWl:localhost
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

SELECT pg_catalog.setval('public.account_data_sequence', 51, true);


--
-- Name: application_services_txn_id_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.application_services_txn_id_seq', 105, true);


--
-- Name: cache_invalidation_stream_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.cache_invalidation_stream_seq', 148, true);


--
-- Name: device_inbox_sequence; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.device_inbox_sequence', 1, true);


--
-- Name: event_auth_chain_id; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.event_auth_chain_id', 29, true);


--
-- Name: events_backfill_stream_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.events_backfill_stream_seq', 1, true);


--
-- Name: events_stream_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.events_stream_seq', 113, true);


--
-- Name: instance_map_instance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.instance_map_instance_id_seq', 1, false);


--
-- Name: presence_stream_sequence; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.presence_stream_sequence', 185, true);


--
-- Name: receipts_sequence; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.receipts_sequence', 17, true);


--
-- Name: state_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.state_group_id_seq', 140, true);


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

