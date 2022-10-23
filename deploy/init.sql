--
-- PostgreSQL database dump
--

-- Dumped from database version 15.0 (Debian 15.0-1.pgdg110+1)
-- Dumped by pg_dump version 15.0

-- Started on 2022-10-22 20:27:55

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

DROP DATABASE keycloak;
--
-- TOC entry 4217 (class 1262 OID 16384)
-- Name: keycloak; Type: DATABASE; Schema: -; Owner: keycloak
--

CREATE DATABASE keycloak WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE keycloak OWNER TO keycloak;

\connect keycloak

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
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 4218 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 255 (class 1259 OID 17017)
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO keycloak;

--
-- TOC entry 284 (class 1259 OID 17463)
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO keycloak;

--
-- TOC entry 258 (class 1259 OID 17032)
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO keycloak;

--
-- TOC entry 257 (class 1259 OID 17027)
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO keycloak;

--
-- TOC entry 256 (class 1259 OID 17022)
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO keycloak;

--
-- TOC entry 259 (class 1259 OID 17037)
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO keycloak;

--
-- TOC entry 285 (class 1259 OID 17478)
-- Name: broker_link; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO keycloak;

--
-- TOC entry 216 (class 1259 OID 16398)
-- Name: client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO keycloak;

--
-- TOC entry 239 (class 1259 OID 16756)
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_attributes OWNER TO keycloak;

--
-- TOC entry 296 (class 1259 OID 17727)
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO keycloak;

--
-- TOC entry 295 (class 1259 OID 17602)
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO keycloak;

--
-- TOC entry 241 (class 1259 OID 16766)
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO keycloak;

--
-- TOC entry 273 (class 1259 OID 17266)
-- Name: client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO keycloak;

--
-- TOC entry 274 (class 1259 OID 17280)
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO keycloak;

--
-- TOC entry 297 (class 1259 OID 17768)
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO keycloak;

--
-- TOC entry 275 (class 1259 OID 17285)
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO keycloak;

--
-- TOC entry 217 (class 1259 OID 16409)
-- Name: client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO keycloak;

--
-- TOC entry 262 (class 1259 OID 17055)
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO keycloak;

--
-- TOC entry 240 (class 1259 OID 16761)
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO keycloak;

--
-- TOC entry 254 (class 1259 OID 16939)
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO keycloak;

--
-- TOC entry 218 (class 1259 OID 16414)
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO keycloak;

--
-- TOC entry 263 (class 1259 OID 17136)
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO keycloak;

--
-- TOC entry 293 (class 1259 OID 17523)
-- Name: component; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO keycloak;

--
-- TOC entry 292 (class 1259 OID 17518)
-- Name: component_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO keycloak;

--
-- TOC entry 219 (class 1259 OID 16417)
-- Name: composite_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO keycloak;

--
-- TOC entry 220 (class 1259 OID 16420)
-- Name: credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO keycloak;

--
-- TOC entry 215 (class 1259 OID 16390)
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO keycloak;

--
-- TOC entry 214 (class 1259 OID 16385)
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO keycloak;

--
-- TOC entry 298 (class 1259 OID 17784)
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO keycloak;

--
-- TOC entry 221 (class 1259 OID 16425)
-- Name: event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO keycloak;

--
-- TOC entry 286 (class 1259 OID 17483)
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO keycloak;

--
-- TOC entry 287 (class 1259 OID 17488)
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO keycloak;

--
-- TOC entry 300 (class 1259 OID 17810)
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO keycloak;

--
-- TOC entry 288 (class 1259 OID 17497)
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO keycloak;

--
-- TOC entry 289 (class 1259 OID 17506)
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO keycloak;

--
-- TOC entry 290 (class 1259 OID 17509)
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO keycloak;

--
-- TOC entry 291 (class 1259 OID 17515)
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO keycloak;

--
-- TOC entry 244 (class 1259 OID 16802)
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO keycloak;

--
-- TOC entry 294 (class 1259 OID 17580)
-- Name: federated_user; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO keycloak;

--
-- TOC entry 270 (class 1259 OID 17204)
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO keycloak;

--
-- TOC entry 269 (class 1259 OID 17201)
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO keycloak;

--
-- TOC entry 245 (class 1259 OID 16807)
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO keycloak;

--
-- TOC entry 246 (class 1259 OID 16816)
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO keycloak;

--
-- TOC entry 251 (class 1259 OID 16920)
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO keycloak;

--
-- TOC entry 252 (class 1259 OID 16925)
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO keycloak;

--
-- TOC entry 268 (class 1259 OID 17198)
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO keycloak;

--
-- TOC entry 222 (class 1259 OID 16433)
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO keycloak;

--
-- TOC entry 250 (class 1259 OID 16917)
-- Name: migration_model; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO keycloak;

--
-- TOC entry 267 (class 1259 OID 17189)
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO keycloak;

--
-- TOC entry 266 (class 1259 OID 17184)
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO keycloak;

--
-- TOC entry 280 (class 1259 OID 17406)
-- Name: policy_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO keycloak;

--
-- TOC entry 242 (class 1259 OID 16791)
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO keycloak;

--
-- TOC entry 243 (class 1259 OID 16797)
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO keycloak;

--
-- TOC entry 223 (class 1259 OID 16439)
-- Name: realm; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO keycloak;

--
-- TOC entry 224 (class 1259 OID 16456)
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO keycloak;

--
-- TOC entry 272 (class 1259 OID 17213)
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO keycloak;

--
-- TOC entry 249 (class 1259 OID 16909)
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO keycloak;

--
-- TOC entry 225 (class 1259 OID 16464)
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO keycloak;

--
-- TOC entry 305 (class 1259 OID 17920)
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO keycloak;

--
-- TOC entry 226 (class 1259 OID 16467)
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO keycloak;

--
-- TOC entry 227 (class 1259 OID 16474)
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO keycloak;

--
-- TOC entry 247 (class 1259 OID 16825)
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO keycloak;

--
-- TOC entry 228 (class 1259 OID 16484)
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO keycloak;

--
-- TOC entry 265 (class 1259 OID 17148)
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO keycloak;

--
-- TOC entry 264 (class 1259 OID 17141)
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO keycloak;

--
-- TOC entry 302 (class 1259 OID 17849)
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO keycloak;

--
-- TOC entry 282 (class 1259 OID 17433)
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO keycloak;

--
-- TOC entry 281 (class 1259 OID 17418)
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO keycloak;

--
-- TOC entry 276 (class 1259 OID 17356)
-- Name: resource_server; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO keycloak;

--
-- TOC entry 301 (class 1259 OID 17825)
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO keycloak;

--
-- TOC entry 279 (class 1259 OID 17392)
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO keycloak;

--
-- TOC entry 277 (class 1259 OID 17364)
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO keycloak;

--
-- TOC entry 278 (class 1259 OID 17378)
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO keycloak;

--
-- TOC entry 303 (class 1259 OID 17867)
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO keycloak;

--
-- TOC entry 304 (class 1259 OID 17877)
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO keycloak;

--
-- TOC entry 229 (class 1259 OID 16487)
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO keycloak;

--
-- TOC entry 283 (class 1259 OID 17448)
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO keycloak;

--
-- TOC entry 231 (class 1259 OID 16493)
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO keycloak;

--
-- TOC entry 253 (class 1259 OID 16930)
-- Name: user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO keycloak;

--
-- TOC entry 299 (class 1259 OID 17800)
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO keycloak;

--
-- TOC entry 232 (class 1259 OID 16498)
-- Name: user_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO keycloak;

--
-- TOC entry 233 (class 1259 OID 16506)
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO keycloak;

--
-- TOC entry 260 (class 1259 OID 17042)
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO keycloak;

--
-- TOC entry 261 (class 1259 OID 17047)
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO keycloak;

--
-- TOC entry 234 (class 1259 OID 16511)
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO keycloak;

--
-- TOC entry 271 (class 1259 OID 17210)
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO keycloak;

--
-- TOC entry 235 (class 1259 OID 16516)
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO keycloak;

--
-- TOC entry 236 (class 1259 OID 16519)
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO keycloak;

--
-- TOC entry 237 (class 1259 OID 16522)
-- Name: user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO keycloak;

--
-- TOC entry 248 (class 1259 OID 16828)
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO keycloak;

--
-- TOC entry 230 (class 1259 OID 16490)
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO keycloak;

--
-- TOC entry 238 (class 1259 OID 16533)
-- Name: web_origins; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO keycloak;

--
-- TOC entry 4161 (class 0 OID 17017)
-- Dependencies: 255
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4190 (class 0 OID 17463)
-- Dependencies: 284
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4164 (class 0 OID 17032)
-- Dependencies: 258
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO public.authentication_execution VALUES ('52bb9aa6-a848-4d6f-8e46-b5098e63ba75', NULL, 'auth-cookie', 'master', 'ec1879bf-9ae9-44af-9e07-7e2a64089d2b', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('cfc105c4-7b9d-4162-bf6c-c431dfa3aace', NULL, 'auth-spnego', 'master', 'ec1879bf-9ae9-44af-9e07-7e2a64089d2b', 3, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('dadcbd4f-40ce-4032-bcae-eebcbd349539', NULL, 'identity-provider-redirector', 'master', 'ec1879bf-9ae9-44af-9e07-7e2a64089d2b', 2, 25, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('59d1d98b-6869-4933-b2ad-6442adb2d489', NULL, NULL, 'master', 'ec1879bf-9ae9-44af-9e07-7e2a64089d2b', 2, 30, true, '5ab5f864-5b15-4cc7-891f-755022be5090', NULL);
INSERT INTO public.authentication_execution VALUES ('e0dc6428-b30c-422c-b1b3-86868963afec', NULL, 'auth-username-password-form', 'master', '5ab5f864-5b15-4cc7-891f-755022be5090', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('92a91bf5-c96c-4408-a1a3-9f122f886202', NULL, NULL, 'master', '5ab5f864-5b15-4cc7-891f-755022be5090', 1, 20, true, 'aca9f326-fe56-45f5-a0db-bc31c7ade433', NULL);
INSERT INTO public.authentication_execution VALUES ('b66bdb21-2093-46ba-8d33-cd3baff18f17', NULL, 'conditional-user-configured', 'master', 'aca9f326-fe56-45f5-a0db-bc31c7ade433', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('2cefad0e-a074-4395-81dd-923c1e4338f4', NULL, 'auth-otp-form', 'master', 'aca9f326-fe56-45f5-a0db-bc31c7ade433', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('e647089f-fdc0-4794-a508-c3532b616228', NULL, 'direct-grant-validate-username', 'master', 'e7ed509b-30e0-428c-81b1-56e8f5ac9524', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('3be89825-aa63-4cc5-b1cf-7e238d6c483f', NULL, 'direct-grant-validate-password', 'master', 'e7ed509b-30e0-428c-81b1-56e8f5ac9524', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('9356ef6f-395c-4007-96b1-73084b6c50bc', NULL, NULL, 'master', 'e7ed509b-30e0-428c-81b1-56e8f5ac9524', 1, 30, true, 'f77f9f31-92fd-4484-a0f4-eec6b83efa85', NULL);
INSERT INTO public.authentication_execution VALUES ('4974db33-ab87-4f63-bcf2-2e6cbc3ec3b4', NULL, 'conditional-user-configured', 'master', 'f77f9f31-92fd-4484-a0f4-eec6b83efa85', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('d9fd506d-fcb8-4b93-9e3b-53ebf140e5e3', NULL, 'direct-grant-validate-otp', 'master', 'f77f9f31-92fd-4484-a0f4-eec6b83efa85', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('b1aa89df-b016-4026-8c11-a6aaeccdaddb', NULL, 'registration-page-form', 'master', '120bf679-6383-4aa0-961a-fb408c7913d0', 0, 10, true, '2fe46784-2903-426f-8ba3-ce19009de285', NULL);
INSERT INTO public.authentication_execution VALUES ('52732313-c3f5-472e-bc68-9d22638cdc5a', NULL, 'registration-user-creation', 'master', '2fe46784-2903-426f-8ba3-ce19009de285', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('5eff27db-a8f5-43a9-a92f-c198903bc58b', NULL, 'registration-profile-action', 'master', '2fe46784-2903-426f-8ba3-ce19009de285', 0, 40, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('287f07bf-9700-4ac7-80e4-1217d6a6df37', NULL, 'registration-password-action', 'master', '2fe46784-2903-426f-8ba3-ce19009de285', 0, 50, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('1ab58514-cb61-495d-b793-ff47d15e72c6', NULL, 'registration-recaptcha-action', 'master', '2fe46784-2903-426f-8ba3-ce19009de285', 3, 60, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('4866d554-e995-4616-89f0-4eb2ff965f79', NULL, 'reset-credentials-choose-user', 'master', '721d3fba-7a28-47bf-b9df-502cb641306e', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('bc4333fe-9b70-4efa-9a42-3bd36873a8a0', NULL, 'reset-credential-email', 'master', '721d3fba-7a28-47bf-b9df-502cb641306e', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('007d58fa-1dbf-415e-8245-43607166cc98', NULL, 'reset-password', 'master', '721d3fba-7a28-47bf-b9df-502cb641306e', 0, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('374fbd6e-7890-4b33-9bae-6325a18d0b9d', NULL, NULL, 'master', '721d3fba-7a28-47bf-b9df-502cb641306e', 1, 40, true, 'a8306d78-87dd-43f9-a44a-083ade681110', NULL);
INSERT INTO public.authentication_execution VALUES ('0763ca9a-6438-4796-92fc-84e76e44af7b', NULL, 'conditional-user-configured', 'master', 'a8306d78-87dd-43f9-a44a-083ade681110', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('5cb6bc35-1ad6-4278-b598-c78221c4672b', NULL, 'reset-otp', 'master', 'a8306d78-87dd-43f9-a44a-083ade681110', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('790cabb1-4201-4596-a4ba-624820321934', NULL, 'client-secret', 'master', '258df578-bb49-45f5-8483-da22f4a5f542', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('eca16bef-a336-4f46-bd68-906fc8df1d33', NULL, 'client-jwt', 'master', '258df578-bb49-45f5-8483-da22f4a5f542', 2, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('69aafb20-c95e-4cd4-b4e1-e8cf3731d693', NULL, 'client-secret-jwt', 'master', '258df578-bb49-45f5-8483-da22f4a5f542', 2, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('974c6d5a-67d2-426f-aea6-81eebe8c3830', NULL, 'client-x509', 'master', '258df578-bb49-45f5-8483-da22f4a5f542', 2, 40, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('dd97e910-78b3-4c3d-a834-fc051092735e', NULL, 'idp-review-profile', 'master', '1eaf7aad-ff60-4c5b-8797-3a20b7069064', 0, 10, false, NULL, 'f5133044-ae0e-4532-acd6-369ae63d137c');
INSERT INTO public.authentication_execution VALUES ('ad35aac5-dd58-44fc-ac95-a34e830035c3', NULL, NULL, 'master', '1eaf7aad-ff60-4c5b-8797-3a20b7069064', 0, 20, true, 'ba5b8273-f3f9-4eeb-9aab-3731510bb538', NULL);
INSERT INTO public.authentication_execution VALUES ('c26193df-4303-4bc8-8759-a7e98d493309', NULL, 'idp-create-user-if-unique', 'master', 'ba5b8273-f3f9-4eeb-9aab-3731510bb538', 2, 10, false, NULL, '1306c9f9-87b5-4402-a6e9-6e8c30db81ea');
INSERT INTO public.authentication_execution VALUES ('f5377589-8920-4b08-8f57-5e10a89d9b6d', NULL, NULL, 'master', 'ba5b8273-f3f9-4eeb-9aab-3731510bb538', 2, 20, true, 'f0adf15e-a815-42b4-bf15-8bab319f44f7', NULL);
INSERT INTO public.authentication_execution VALUES ('0db0ee00-da72-466a-9f2e-f5dce3ab828a', NULL, 'idp-confirm-link', 'master', 'f0adf15e-a815-42b4-bf15-8bab319f44f7', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('4774bb49-ecb3-4d63-b42d-a4ad83c15625', NULL, NULL, 'master', 'f0adf15e-a815-42b4-bf15-8bab319f44f7', 0, 20, true, 'ad0853cf-a67c-4d3e-bbef-9d12b434971c', NULL);
INSERT INTO public.authentication_execution VALUES ('abbd2035-fd11-4c11-8882-878d60ca6849', NULL, 'idp-email-verification', 'master', 'ad0853cf-a67c-4d3e-bbef-9d12b434971c', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('60989854-ddf7-4939-b43d-3810e5762a8a', NULL, NULL, 'master', 'ad0853cf-a67c-4d3e-bbef-9d12b434971c', 2, 20, true, '75c6da22-00a8-4b74-bb9b-4148ddd32d11', NULL);
INSERT INTO public.authentication_execution VALUES ('1b387d5c-44c7-4c37-b6bc-6220718c0144', NULL, 'idp-username-password-form', 'master', '75c6da22-00a8-4b74-bb9b-4148ddd32d11', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('757dd125-8da1-4712-bd1f-3fd6931dad8e', NULL, NULL, 'master', '75c6da22-00a8-4b74-bb9b-4148ddd32d11', 1, 20, true, '942b7b98-8a65-42be-bce0-b9289cf7d6bb', NULL);
INSERT INTO public.authentication_execution VALUES ('fc38cb76-6719-4345-8909-dcd393ecafc5', NULL, 'conditional-user-configured', 'master', '942b7b98-8a65-42be-bce0-b9289cf7d6bb', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('0e113729-f208-4ea5-b88a-d4b8b891ace8', NULL, 'auth-otp-form', 'master', '942b7b98-8a65-42be-bce0-b9289cf7d6bb', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('26e5b499-7d33-4781-be6d-b8539edb30e8', NULL, 'http-basic-authenticator', 'master', '01648f70-7115-4944-8269-43372d89c13f', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('b63c8f70-fedc-449b-8ce8-d45c4d79574b', NULL, 'docker-http-basic-authenticator', 'master', '1c4e2971-1344-4f47-b76a-a6b1e2b2e042', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('313eadf3-57fc-4403-b0a5-9442c35d7c6e', NULL, 'no-cookie-redirect', 'master', 'f67953b4-5f00-4501-8ac0-53c8ffeef64b', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('ba3ed303-760b-448d-b02d-22cfcefb1f30', NULL, NULL, 'master', 'f67953b4-5f00-4501-8ac0-53c8ffeef64b', 0, 20, true, '4de1c59c-7e2b-4d62-b85e-58017bc692fa', NULL);
INSERT INTO public.authentication_execution VALUES ('b3f1f5e9-3422-4b13-b2a5-1d9d2bb73522', NULL, 'basic-auth', 'master', '4de1c59c-7e2b-4d62-b85e-58017bc692fa', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('eb1acbb6-e600-4ff4-bd85-5c72dd9d0119', NULL, 'basic-auth-otp', 'master', '4de1c59c-7e2b-4d62-b85e-58017bc692fa', 3, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('c5f629b7-552b-4992-807d-3c277d0884f6', NULL, 'auth-spnego', 'master', '4de1c59c-7e2b-4d62-b85e-58017bc692fa', 3, 30, false, NULL, NULL);


--
-- TOC entry 4163 (class 0 OID 17027)
-- Dependencies: 257
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO public.authentication_flow VALUES ('ec1879bf-9ae9-44af-9e07-7e2a64089d2b', 'browser', 'browser based authentication', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('5ab5f864-5b15-4cc7-891f-755022be5090', 'forms', 'Username, password, otp and other auth forms.', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('aca9f326-fe56-45f5-a0db-bc31c7ade433', 'Browser - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('e7ed509b-30e0-428c-81b1-56e8f5ac9524', 'direct grant', 'OpenID Connect Resource Owner Grant', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('f77f9f31-92fd-4484-a0f4-eec6b83efa85', 'Direct Grant - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('120bf679-6383-4aa0-961a-fb408c7913d0', 'registration', 'registration flow', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('2fe46784-2903-426f-8ba3-ce19009de285', 'registration form', 'registration form', 'master', 'form-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('721d3fba-7a28-47bf-b9df-502cb641306e', 'reset credentials', 'Reset credentials for a user if they forgot their password or something', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('a8306d78-87dd-43f9-a44a-083ade681110', 'Reset - Conditional OTP', 'Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('258df578-bb49-45f5-8483-da22f4a5f542', 'clients', 'Base authentication for clients', 'master', 'client-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('1eaf7aad-ff60-4c5b-8797-3a20b7069064', 'first broker login', 'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('ba5b8273-f3f9-4eeb-9aab-3731510bb538', 'User creation or linking', 'Flow for the existing/non-existing user alternatives', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('f0adf15e-a815-42b4-bf15-8bab319f44f7', 'Handle Existing Account', 'Handle what to do if there is existing account with same email/username like authenticated identity provider', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('ad0853cf-a67c-4d3e-bbef-9d12b434971c', 'Account verification options', 'Method with which to verity the existing account', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('75c6da22-00a8-4b74-bb9b-4148ddd32d11', 'Verify Existing Account by Re-authentication', 'Reauthentication of existing account', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('942b7b98-8a65-42be-bce0-b9289cf7d6bb', 'First broker login - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('01648f70-7115-4944-8269-43372d89c13f', 'saml ecp', 'SAML ECP Profile Authentication Flow', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('1c4e2971-1344-4f47-b76a-a6b1e2b2e042', 'docker auth', 'Used by Docker clients to authenticate against the IDP', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('f67953b4-5f00-4501-8ac0-53c8ffeef64b', 'http challenge', 'An authentication flow based on challenge-response HTTP Authentication Schemes', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('4de1c59c-7e2b-4d62-b85e-58017bc692fa', 'Authentication Options', 'Authentication options.', 'master', 'basic-flow', false, true);


--
-- TOC entry 4162 (class 0 OID 17022)
-- Dependencies: 256
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO public.authenticator_config VALUES ('f5133044-ae0e-4532-acd6-369ae63d137c', 'review profile config', 'master');
INSERT INTO public.authenticator_config VALUES ('1306c9f9-87b5-4402-a6e9-6e8c30db81ea', 'create unique user config', 'master');


--
-- TOC entry 4165 (class 0 OID 17037)
-- Dependencies: 259
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO public.authenticator_config_entry VALUES ('f5133044-ae0e-4532-acd6-369ae63d137c', 'missing', 'update.profile.on.first.login');
INSERT INTO public.authenticator_config_entry VALUES ('1306c9f9-87b5-4402-a6e9-6e8c30db81ea', 'false', 'require.password.update.after.registration');


--
-- TOC entry 4191 (class 0 OID 17478)
-- Dependencies: 285
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4122 (class 0 OID 16398)
-- Dependencies: 216
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO public.client VALUES ('ba21cbd8-f648-48c5-9198-0d88c41702d8', true, false, 'master-realm', 0, false, NULL, NULL, true, NULL, false, 'master', NULL, 0, false, false, 'master Realm', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('25ebdb3e-1af4-4735-b66d-31e712802a57', true, false, 'account', 0, true, NULL, '/realms/master/account/', false, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_account}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('017a89e2-0f9c-4832-82c3-a9098e50b406', true, false, 'account-console', 0, true, NULL, '/realms/master/account/', false, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_account-console}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('77159e12-9c83-4fa6-8f9f-fe71afc4685b', true, false, 'broker', 0, false, NULL, NULL, true, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_broker}', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('303a8c8f-25c7-40f5-a497-4a717d177de7', true, false, 'security-admin-console', 0, true, NULL, '/admin/master/console/', false, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_security-admin-console}', false, 'client-secret', '${authAdminUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('f09eb9d3-b2e6-4449-a60a-dcb28a03194b', true, false, 'admin-cli', 0, true, NULL, NULL, false, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_admin-cli}', false, 'client-secret', NULL, NULL, NULL, false, false, true, false);
INSERT INTO public.client VALUES ('fc96fad3-3add-40bd-b993-d649579b03b0', true, true, 'admin', 0, false, 'fTfnXj5PncEFXZF1A7Y6x37t2LSgJwLs', NULL, false, NULL, false, 'master', 'openid-connect', -1, false, false, NULL, false, 'client-secret', NULL, NULL, NULL, true, false, true, false);


--
-- TOC entry 4145 (class 0 OID 16756)
-- Dependencies: 239
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO public.client_attributes VALUES ('017a89e2-0f9c-4832-82c3-a9098e50b406', 'S256', 'pkce.code.challenge.method');
INSERT INTO public.client_attributes VALUES ('303a8c8f-25c7-40f5-a497-4a717d177de7', 'S256', 'pkce.code.challenge.method');
INSERT INTO public.client_attributes VALUES ('fc96fad3-3add-40bd-b993-d649579b03b0', 'true', 'backchannel.logout.session.required');
INSERT INTO public.client_attributes VALUES ('fc96fad3-3add-40bd-b993-d649579b03b0', 'false', 'backchannel.logout.revoke.offline.tokens');
INSERT INTO public.client_attributes VALUES ('fc96fad3-3add-40bd-b993-d649579b03b0', 'false', 'saml.artifact.binding');
INSERT INTO public.client_attributes VALUES ('fc96fad3-3add-40bd-b993-d649579b03b0', 'false', 'saml.server.signature');
INSERT INTO public.client_attributes VALUES ('fc96fad3-3add-40bd-b993-d649579b03b0', 'false', 'saml.server.signature.keyinfo.ext');
INSERT INTO public.client_attributes VALUES ('fc96fad3-3add-40bd-b993-d649579b03b0', 'false', 'saml.assertion.signature');
INSERT INTO public.client_attributes VALUES ('fc96fad3-3add-40bd-b993-d649579b03b0', 'false', 'saml.client.signature');
INSERT INTO public.client_attributes VALUES ('fc96fad3-3add-40bd-b993-d649579b03b0', 'false', 'saml.encrypt');
INSERT INTO public.client_attributes VALUES ('fc96fad3-3add-40bd-b993-d649579b03b0', 'false', 'saml.authnstatement');
INSERT INTO public.client_attributes VALUES ('fc96fad3-3add-40bd-b993-d649579b03b0', 'false', 'saml.onetimeuse.condition');
INSERT INTO public.client_attributes VALUES ('fc96fad3-3add-40bd-b993-d649579b03b0', 'false', 'saml_force_name_id_format');
INSERT INTO public.client_attributes VALUES ('fc96fad3-3add-40bd-b993-d649579b03b0', 'false', 'saml.multivalued.roles');
INSERT INTO public.client_attributes VALUES ('fc96fad3-3add-40bd-b993-d649579b03b0', 'false', 'saml.force.post.binding');
INSERT INTO public.client_attributes VALUES ('fc96fad3-3add-40bd-b993-d649579b03b0', 'false', 'exclude.session.state.from.auth.response');
INSERT INTO public.client_attributes VALUES ('fc96fad3-3add-40bd-b993-d649579b03b0', 'false', 'oauth2.device.authorization.grant.enabled');
INSERT INTO public.client_attributes VALUES ('fc96fad3-3add-40bd-b993-d649579b03b0', 'false', 'oidc.ciba.grant.enabled');
INSERT INTO public.client_attributes VALUES ('fc96fad3-3add-40bd-b993-d649579b03b0', 'true', 'use.refresh.tokens');
INSERT INTO public.client_attributes VALUES ('fc96fad3-3add-40bd-b993-d649579b03b0', 'false', 'id.token.as.detached.signature');
INSERT INTO public.client_attributes VALUES ('fc96fad3-3add-40bd-b993-d649579b03b0', 'false', 'tls.client.certificate.bound.access.tokens');
INSERT INTO public.client_attributes VALUES ('fc96fad3-3add-40bd-b993-d649579b03b0', 'false', 'require.pushed.authorization.requests');
INSERT INTO public.client_attributes VALUES ('fc96fad3-3add-40bd-b993-d649579b03b0', 'false', 'client_credentials.use_refresh_token');
INSERT INTO public.client_attributes VALUES ('fc96fad3-3add-40bd-b993-d649579b03b0', 'false', 'display.on.consent.screen');


--
-- TOC entry 4202 (class 0 OID 17727)
-- Dependencies: 296
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4201 (class 0 OID 17602)
-- Dependencies: 295
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO public.client_initial_access VALUES ('fb55a8ae-efc1-40b7-b729-64a1ef8c3704', 'master', 1666430279, 2592000, 1, 1);


--
-- TOC entry 4147 (class 0 OID 16766)
-- Dependencies: 241
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4179 (class 0 OID 17266)
-- Dependencies: 273
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO public.client_scope VALUES ('5bbfcfac-57f3-46c3-b033-98d9f65f8b4c', 'offline_access', 'master', 'OpenID Connect built-in scope: offline_access', 'openid-connect');
INSERT INTO public.client_scope VALUES ('eccade99-409a-4939-9f70-8c74d704831c', 'role_list', 'master', 'SAML role list', 'saml');
INSERT INTO public.client_scope VALUES ('06f497ae-a985-4616-aa1f-05f22a1762fe', 'profile', 'master', 'OpenID Connect built-in scope: profile', 'openid-connect');
INSERT INTO public.client_scope VALUES ('32cd8045-27c4-4a8c-b52b-65a54e4e09b2', 'email', 'master', 'OpenID Connect built-in scope: email', 'openid-connect');
INSERT INTO public.client_scope VALUES ('0aa5b00c-5f1a-4f57-b945-aafd7289718f', 'address', 'master', 'OpenID Connect built-in scope: address', 'openid-connect');
INSERT INTO public.client_scope VALUES ('be579c97-0c20-4553-bad3-aacdd3fdb5a7', 'phone', 'master', 'OpenID Connect built-in scope: phone', 'openid-connect');
INSERT INTO public.client_scope VALUES ('f061ac1e-b240-4971-b4da-4051626671ae', 'roles', 'master', 'OpenID Connect scope for add user roles to the access token', 'openid-connect');
INSERT INTO public.client_scope VALUES ('29055654-85af-4ecb-967c-626d2bf55c8c', 'web-origins', 'master', 'OpenID Connect scope for add allowed web origins to the access token', 'openid-connect');
INSERT INTO public.client_scope VALUES ('0b315b1e-8ffc-45da-b6f4-23ad57e52a73', 'microprofile-jwt', 'master', 'Microprofile - JWT built-in scope', 'openid-connect');


--
-- TOC entry 4180 (class 0 OID 17280)
-- Dependencies: 274
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO public.client_scope_attributes VALUES ('5bbfcfac-57f3-46c3-b033-98d9f65f8b4c', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('5bbfcfac-57f3-46c3-b033-98d9f65f8b4c', '${offlineAccessScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('eccade99-409a-4939-9f70-8c74d704831c', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('eccade99-409a-4939-9f70-8c74d704831c', '${samlRoleListScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('06f497ae-a985-4616-aa1f-05f22a1762fe', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('06f497ae-a985-4616-aa1f-05f22a1762fe', '${profileScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('06f497ae-a985-4616-aa1f-05f22a1762fe', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('32cd8045-27c4-4a8c-b52b-65a54e4e09b2', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('32cd8045-27c4-4a8c-b52b-65a54e4e09b2', '${emailScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('32cd8045-27c4-4a8c-b52b-65a54e4e09b2', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('0aa5b00c-5f1a-4f57-b945-aafd7289718f', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('0aa5b00c-5f1a-4f57-b945-aafd7289718f', '${addressScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('0aa5b00c-5f1a-4f57-b945-aafd7289718f', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('be579c97-0c20-4553-bad3-aacdd3fdb5a7', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('be579c97-0c20-4553-bad3-aacdd3fdb5a7', '${phoneScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('be579c97-0c20-4553-bad3-aacdd3fdb5a7', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('f061ac1e-b240-4971-b4da-4051626671ae', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('f061ac1e-b240-4971-b4da-4051626671ae', '${rolesScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('f061ac1e-b240-4971-b4da-4051626671ae', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('29055654-85af-4ecb-967c-626d2bf55c8c', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('29055654-85af-4ecb-967c-626d2bf55c8c', '', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('29055654-85af-4ecb-967c-626d2bf55c8c', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('0b315b1e-8ffc-45da-b6f4-23ad57e52a73', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('0b315b1e-8ffc-45da-b6f4-23ad57e52a73', 'true', 'include.in.token.scope');


--
-- TOC entry 4203 (class 0 OID 17768)
-- Dependencies: 297
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO public.client_scope_client VALUES ('25ebdb3e-1af4-4735-b66d-31e712802a57', 'f061ac1e-b240-4971-b4da-4051626671ae', true);
INSERT INTO public.client_scope_client VALUES ('25ebdb3e-1af4-4735-b66d-31e712802a57', '29055654-85af-4ecb-967c-626d2bf55c8c', true);
INSERT INTO public.client_scope_client VALUES ('25ebdb3e-1af4-4735-b66d-31e712802a57', '32cd8045-27c4-4a8c-b52b-65a54e4e09b2', true);
INSERT INTO public.client_scope_client VALUES ('25ebdb3e-1af4-4735-b66d-31e712802a57', '06f497ae-a985-4616-aa1f-05f22a1762fe', true);
INSERT INTO public.client_scope_client VALUES ('25ebdb3e-1af4-4735-b66d-31e712802a57', '0b315b1e-8ffc-45da-b6f4-23ad57e52a73', false);
INSERT INTO public.client_scope_client VALUES ('25ebdb3e-1af4-4735-b66d-31e712802a57', 'be579c97-0c20-4553-bad3-aacdd3fdb5a7', false);
INSERT INTO public.client_scope_client VALUES ('25ebdb3e-1af4-4735-b66d-31e712802a57', '5bbfcfac-57f3-46c3-b033-98d9f65f8b4c', false);
INSERT INTO public.client_scope_client VALUES ('25ebdb3e-1af4-4735-b66d-31e712802a57', '0aa5b00c-5f1a-4f57-b945-aafd7289718f', false);
INSERT INTO public.client_scope_client VALUES ('017a89e2-0f9c-4832-82c3-a9098e50b406', 'f061ac1e-b240-4971-b4da-4051626671ae', true);
INSERT INTO public.client_scope_client VALUES ('017a89e2-0f9c-4832-82c3-a9098e50b406', '29055654-85af-4ecb-967c-626d2bf55c8c', true);
INSERT INTO public.client_scope_client VALUES ('017a89e2-0f9c-4832-82c3-a9098e50b406', '32cd8045-27c4-4a8c-b52b-65a54e4e09b2', true);
INSERT INTO public.client_scope_client VALUES ('017a89e2-0f9c-4832-82c3-a9098e50b406', '06f497ae-a985-4616-aa1f-05f22a1762fe', true);
INSERT INTO public.client_scope_client VALUES ('017a89e2-0f9c-4832-82c3-a9098e50b406', '0b315b1e-8ffc-45da-b6f4-23ad57e52a73', false);
INSERT INTO public.client_scope_client VALUES ('017a89e2-0f9c-4832-82c3-a9098e50b406', 'be579c97-0c20-4553-bad3-aacdd3fdb5a7', false);
INSERT INTO public.client_scope_client VALUES ('017a89e2-0f9c-4832-82c3-a9098e50b406', '5bbfcfac-57f3-46c3-b033-98d9f65f8b4c', false);
INSERT INTO public.client_scope_client VALUES ('017a89e2-0f9c-4832-82c3-a9098e50b406', '0aa5b00c-5f1a-4f57-b945-aafd7289718f', false);
INSERT INTO public.client_scope_client VALUES ('f09eb9d3-b2e6-4449-a60a-dcb28a03194b', 'f061ac1e-b240-4971-b4da-4051626671ae', true);
INSERT INTO public.client_scope_client VALUES ('f09eb9d3-b2e6-4449-a60a-dcb28a03194b', '29055654-85af-4ecb-967c-626d2bf55c8c', true);
INSERT INTO public.client_scope_client VALUES ('f09eb9d3-b2e6-4449-a60a-dcb28a03194b', '32cd8045-27c4-4a8c-b52b-65a54e4e09b2', true);
INSERT INTO public.client_scope_client VALUES ('f09eb9d3-b2e6-4449-a60a-dcb28a03194b', '06f497ae-a985-4616-aa1f-05f22a1762fe', true);
INSERT INTO public.client_scope_client VALUES ('f09eb9d3-b2e6-4449-a60a-dcb28a03194b', '0b315b1e-8ffc-45da-b6f4-23ad57e52a73', false);
INSERT INTO public.client_scope_client VALUES ('f09eb9d3-b2e6-4449-a60a-dcb28a03194b', 'be579c97-0c20-4553-bad3-aacdd3fdb5a7', false);
INSERT INTO public.client_scope_client VALUES ('f09eb9d3-b2e6-4449-a60a-dcb28a03194b', '5bbfcfac-57f3-46c3-b033-98d9f65f8b4c', false);
INSERT INTO public.client_scope_client VALUES ('f09eb9d3-b2e6-4449-a60a-dcb28a03194b', '0aa5b00c-5f1a-4f57-b945-aafd7289718f', false);
INSERT INTO public.client_scope_client VALUES ('77159e12-9c83-4fa6-8f9f-fe71afc4685b', 'f061ac1e-b240-4971-b4da-4051626671ae', true);
INSERT INTO public.client_scope_client VALUES ('77159e12-9c83-4fa6-8f9f-fe71afc4685b', '29055654-85af-4ecb-967c-626d2bf55c8c', true);
INSERT INTO public.client_scope_client VALUES ('77159e12-9c83-4fa6-8f9f-fe71afc4685b', '32cd8045-27c4-4a8c-b52b-65a54e4e09b2', true);
INSERT INTO public.client_scope_client VALUES ('77159e12-9c83-4fa6-8f9f-fe71afc4685b', '06f497ae-a985-4616-aa1f-05f22a1762fe', true);
INSERT INTO public.client_scope_client VALUES ('77159e12-9c83-4fa6-8f9f-fe71afc4685b', '0b315b1e-8ffc-45da-b6f4-23ad57e52a73', false);
INSERT INTO public.client_scope_client VALUES ('77159e12-9c83-4fa6-8f9f-fe71afc4685b', 'be579c97-0c20-4553-bad3-aacdd3fdb5a7', false);
INSERT INTO public.client_scope_client VALUES ('77159e12-9c83-4fa6-8f9f-fe71afc4685b', '5bbfcfac-57f3-46c3-b033-98d9f65f8b4c', false);
INSERT INTO public.client_scope_client VALUES ('77159e12-9c83-4fa6-8f9f-fe71afc4685b', '0aa5b00c-5f1a-4f57-b945-aafd7289718f', false);
INSERT INTO public.client_scope_client VALUES ('ba21cbd8-f648-48c5-9198-0d88c41702d8', 'f061ac1e-b240-4971-b4da-4051626671ae', true);
INSERT INTO public.client_scope_client VALUES ('ba21cbd8-f648-48c5-9198-0d88c41702d8', '29055654-85af-4ecb-967c-626d2bf55c8c', true);
INSERT INTO public.client_scope_client VALUES ('ba21cbd8-f648-48c5-9198-0d88c41702d8', '32cd8045-27c4-4a8c-b52b-65a54e4e09b2', true);
INSERT INTO public.client_scope_client VALUES ('ba21cbd8-f648-48c5-9198-0d88c41702d8', '06f497ae-a985-4616-aa1f-05f22a1762fe', true);
INSERT INTO public.client_scope_client VALUES ('ba21cbd8-f648-48c5-9198-0d88c41702d8', '0b315b1e-8ffc-45da-b6f4-23ad57e52a73', false);
INSERT INTO public.client_scope_client VALUES ('ba21cbd8-f648-48c5-9198-0d88c41702d8', 'be579c97-0c20-4553-bad3-aacdd3fdb5a7', false);
INSERT INTO public.client_scope_client VALUES ('ba21cbd8-f648-48c5-9198-0d88c41702d8', '5bbfcfac-57f3-46c3-b033-98d9f65f8b4c', false);
INSERT INTO public.client_scope_client VALUES ('ba21cbd8-f648-48c5-9198-0d88c41702d8', '0aa5b00c-5f1a-4f57-b945-aafd7289718f', false);
INSERT INTO public.client_scope_client VALUES ('303a8c8f-25c7-40f5-a497-4a717d177de7', 'f061ac1e-b240-4971-b4da-4051626671ae', true);
INSERT INTO public.client_scope_client VALUES ('303a8c8f-25c7-40f5-a497-4a717d177de7', '29055654-85af-4ecb-967c-626d2bf55c8c', true);
INSERT INTO public.client_scope_client VALUES ('303a8c8f-25c7-40f5-a497-4a717d177de7', '32cd8045-27c4-4a8c-b52b-65a54e4e09b2', true);
INSERT INTO public.client_scope_client VALUES ('303a8c8f-25c7-40f5-a497-4a717d177de7', '06f497ae-a985-4616-aa1f-05f22a1762fe', true);
INSERT INTO public.client_scope_client VALUES ('303a8c8f-25c7-40f5-a497-4a717d177de7', '0b315b1e-8ffc-45da-b6f4-23ad57e52a73', false);
INSERT INTO public.client_scope_client VALUES ('303a8c8f-25c7-40f5-a497-4a717d177de7', 'be579c97-0c20-4553-bad3-aacdd3fdb5a7', false);
INSERT INTO public.client_scope_client VALUES ('303a8c8f-25c7-40f5-a497-4a717d177de7', '5bbfcfac-57f3-46c3-b033-98d9f65f8b4c', false);
INSERT INTO public.client_scope_client VALUES ('303a8c8f-25c7-40f5-a497-4a717d177de7', '0aa5b00c-5f1a-4f57-b945-aafd7289718f', false);
INSERT INTO public.client_scope_client VALUES ('fc96fad3-3add-40bd-b993-d649579b03b0', 'f061ac1e-b240-4971-b4da-4051626671ae', true);
INSERT INTO public.client_scope_client VALUES ('fc96fad3-3add-40bd-b993-d649579b03b0', '29055654-85af-4ecb-967c-626d2bf55c8c', true);
INSERT INTO public.client_scope_client VALUES ('fc96fad3-3add-40bd-b993-d649579b03b0', '32cd8045-27c4-4a8c-b52b-65a54e4e09b2', true);
INSERT INTO public.client_scope_client VALUES ('fc96fad3-3add-40bd-b993-d649579b03b0', '06f497ae-a985-4616-aa1f-05f22a1762fe', true);
INSERT INTO public.client_scope_client VALUES ('fc96fad3-3add-40bd-b993-d649579b03b0', '0b315b1e-8ffc-45da-b6f4-23ad57e52a73', false);
INSERT INTO public.client_scope_client VALUES ('fc96fad3-3add-40bd-b993-d649579b03b0', 'be579c97-0c20-4553-bad3-aacdd3fdb5a7', false);
INSERT INTO public.client_scope_client VALUES ('fc96fad3-3add-40bd-b993-d649579b03b0', '5bbfcfac-57f3-46c3-b033-98d9f65f8b4c', false);
INSERT INTO public.client_scope_client VALUES ('fc96fad3-3add-40bd-b993-d649579b03b0', '0aa5b00c-5f1a-4f57-b945-aafd7289718f', false);


--
-- TOC entry 4181 (class 0 OID 17285)
-- Dependencies: 275
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO public.client_scope_role_mapping VALUES ('5bbfcfac-57f3-46c3-b033-98d9f65f8b4c', '7d9633f4-e669-409e-b409-cd47599f27ce');


--
-- TOC entry 4123 (class 0 OID 16409)
-- Dependencies: 217
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4168 (class 0 OID 17055)
-- Dependencies: 262
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4146 (class 0 OID 16761)
-- Dependencies: 240
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4160 (class 0 OID 16939)
-- Dependencies: 254
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4124 (class 0 OID 16414)
-- Dependencies: 218
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4169 (class 0 OID 17136)
-- Dependencies: 263
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4199 (class 0 OID 17523)
-- Dependencies: 293
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO public.component VALUES ('ed3f06f0-9626-4515-bfa7-53d35674b447', 'Trusted Hosts', 'master', 'trusted-hosts', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO public.component VALUES ('e28c4c05-4aa3-4d50-bcf8-b5126665d241', 'Consent Required', 'master', 'consent-required', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO public.component VALUES ('b9d76272-609d-442a-87e1-df372d91b835', 'Full Scope Disabled', 'master', 'scope', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO public.component VALUES ('71c3da16-b6d5-4904-b655-96c702103214', 'Max Clients Limit', 'master', 'max-clients', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO public.component VALUES ('5344b3e8-f9ed-45e7-b765-376b75648403', 'Allowed Protocol Mapper Types', 'master', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO public.component VALUES ('a4f128ea-07f0-49a1-879f-1be5f30c24c2', 'Allowed Client Scopes', 'master', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO public.component VALUES ('bed0e5f5-fbf1-401f-bba2-542c0a6bcc4a', 'Allowed Protocol Mapper Types', 'master', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'authenticated');
INSERT INTO public.component VALUES ('c73267f5-667f-46d6-906d-cb19a479bb01', 'Allowed Client Scopes', 'master', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'authenticated');
INSERT INTO public.component VALUES ('c1ca1e8c-8312-4265-9b0f-56bc884b6080', 'rsa-generated', 'master', 'rsa-generated', 'org.keycloak.keys.KeyProvider', 'master', NULL);
INSERT INTO public.component VALUES ('9a4ea80a-5d51-40ff-858f-0cbaa72ccddc', 'rsa-enc-generated', 'master', 'rsa-enc-generated', 'org.keycloak.keys.KeyProvider', 'master', NULL);
INSERT INTO public.component VALUES ('d84484c7-61f5-4090-9a05-fef8ecf0c5c4', 'hmac-generated', 'master', 'hmac-generated', 'org.keycloak.keys.KeyProvider', 'master', NULL);
INSERT INTO public.component VALUES ('5ab18253-17f2-4c7e-9210-5e4f17201b2e', 'aes-generated', 'master', 'aes-generated', 'org.keycloak.keys.KeyProvider', 'master', NULL);


--
-- TOC entry 4198 (class 0 OID 17518)
-- Dependencies: 292
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO public.component_config VALUES ('ef9e301f-7a57-4b44-a2a2-799583ab25f6', 'bed0e5f5-fbf1-401f-bba2-542c0a6bcc4a', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO public.component_config VALUES ('b298dbf2-b65b-4b76-b749-e86198a74efd', 'bed0e5f5-fbf1-401f-bba2-542c0a6bcc4a', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO public.component_config VALUES ('b41a7c37-72d0-46ca-947c-2424a2232ceb', 'bed0e5f5-fbf1-401f-bba2-542c0a6bcc4a', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config VALUES ('d1335376-340b-4a33-8472-b727df2ef673', 'bed0e5f5-fbf1-401f-bba2-542c0a6bcc4a', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config VALUES ('20d7ff56-be6d-43b3-becf-38ee6210c3dc', 'bed0e5f5-fbf1-401f-bba2-542c0a6bcc4a', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO public.component_config VALUES ('98e0b322-4566-46e1-a75a-77c03508a219', 'bed0e5f5-fbf1-401f-bba2-542c0a6bcc4a', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO public.component_config VALUES ('0a3fd6cd-1857-47cf-811c-212cd1b60508', 'bed0e5f5-fbf1-401f-bba2-542c0a6bcc4a', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO public.component_config VALUES ('1f12a9e8-2aae-4f44-a636-92b9ff195c8b', 'bed0e5f5-fbf1-401f-bba2-542c0a6bcc4a', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO public.component_config VALUES ('d09d3e9b-2cc8-49da-b7e8-3ab7eaa1ee65', 'ed3f06f0-9626-4515-bfa7-53d35674b447', 'client-uris-must-match', 'true');
INSERT INTO public.component_config VALUES ('0e4563a9-277a-413b-8ed7-615c509427d3', 'ed3f06f0-9626-4515-bfa7-53d35674b447', 'host-sending-registration-request-must-match', 'true');
INSERT INTO public.component_config VALUES ('f64d0250-8bd7-496e-bb38-b8962f5316b7', '5344b3e8-f9ed-45e7-b765-376b75648403', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO public.component_config VALUES ('fa63b1d1-d7d2-4df5-8086-1c9d51533d5a', '5344b3e8-f9ed-45e7-b765-376b75648403', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config VALUES ('3e485074-0cf4-498a-916c-487b56870661', '5344b3e8-f9ed-45e7-b765-376b75648403', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config VALUES ('cd40c973-ffdd-4c37-bd0b-45b2adcdd4e7', '5344b3e8-f9ed-45e7-b765-376b75648403', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO public.component_config VALUES ('cbc9734d-6d24-49e5-98dc-a3a0ecc46b01', '5344b3e8-f9ed-45e7-b765-376b75648403', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO public.component_config VALUES ('71992c86-e4f9-4115-9269-36e7c555b7ca', '5344b3e8-f9ed-45e7-b765-376b75648403', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO public.component_config VALUES ('f8cdf255-bd52-4d74-be17-6c8291a8d9df', '5344b3e8-f9ed-45e7-b765-376b75648403', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO public.component_config VALUES ('02c842bf-fafa-4bcc-9dd2-69d10b38fa42', '5344b3e8-f9ed-45e7-b765-376b75648403', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO public.component_config VALUES ('6ca674db-12ce-40ea-987c-841193bae5fc', '71c3da16-b6d5-4904-b655-96c702103214', 'max-clients', '200');
INSERT INTO public.component_config VALUES ('7fb0cb47-a2e9-4082-ba76-6c61c2a91c50', 'a4f128ea-07f0-49a1-879f-1be5f30c24c2', 'allow-default-scopes', 'true');
INSERT INTO public.component_config VALUES ('2f4c0245-5d95-4918-85f7-7398b4c596bd', 'c73267f5-667f-46d6-906d-cb19a479bb01', 'allow-default-scopes', 'true');
INSERT INTO public.component_config VALUES ('98c292a3-d6bd-4c92-8f84-d5257f9b912e', '9a4ea80a-5d51-40ff-858f-0cbaa72ccddc', 'priority', '100');
INSERT INTO public.component_config VALUES ('f35f39ce-7d59-4f59-8874-ea60709bffc3', '9a4ea80a-5d51-40ff-858f-0cbaa72ccddc', 'certificate', 'MIICmzCCAYMCBgGD/ucWHjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjIxMDIyMDg1MzIwWhcNMzIxMDIyMDg1NTAwWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCdd/82DLAGar5LgKxFwe5X4TMp/M/l2ODfUJ0RONo1H5/cArDdBT57Txe/uFhOenOOP0JpqrHnWxQ1N1AZN9/B7HNskyHpUTARBBkWgd22I4fWC5/2UFfKG+TA8jEz3k8PMIaIA39PTP+xT+LqS9hzGOkTUJ32ykuqnjml9+vo3zCfLjO814lXAeNWGKO5Au47aNuFEa3J7B9+hPWhlUqd1udCi8oWyLZAjxkgoaf4LZHT04jkpbhQnzj8xSk3N7IfjcZeOmlvlBDEgMfLKKz5DBJYqtthKWDV4hAnf4HVVhmaBx3wX+F9m6GQZOUqI14zPvuMRlUlGZh8FthuHb8xAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAFs1XfKxJbMhZIZ9MQGVveR7dLOzrW7hT1w5W9o2TqWJ/5s91Na8ew6bRM2i5h+xYqPw/DkgA1z7rGVb7B16dU8t+5TF1KeYsDnuLezQ8j+NKawU0OQtGPkx2bZHgZC8I9enAFppjTmq6dfcbb5xhWxOqU6Li1/VgE3qxcexdUdHXI1r5oeFM9mFIrwG3Goyz1zM1QGiD09u2GywY9eqhc+ekQPABHpf+vQEe1hu1bPHsFFCJVCEAeW0aNfTAqKCq7BWdll6qfbVYlCGfd+iiu6Lb9f0wkyNZ+B16FrFSaMwlEZG32/04sMBMqRSocNcW+j7k+FVFW4CY3aJLCAbxKg=');
INSERT INTO public.component_config VALUES ('c84b3333-3b4c-47d5-967a-33abc9794349', '9a4ea80a-5d51-40ff-858f-0cbaa72ccddc', 'keyUse', 'ENC');
INSERT INTO public.component_config VALUES ('f31c45ec-04bc-453a-9e3b-2e02c52dd8f9', '9a4ea80a-5d51-40ff-858f-0cbaa72ccddc', 'privateKey', 'MIIEowIBAAKCAQEAnXf/NgywBmq+S4CsRcHuV+EzKfzP5djg31CdETjaNR+f3AKw3QU+e08Xv7hYTnpzjj9Caaqx51sUNTdQGTffwexzbJMh6VEwEQQZFoHdtiOH1guf9lBXyhvkwPIxM95PDzCGiAN/T0z/sU/i6kvYcxjpE1Cd9spLqp45pffr6N8wny4zvNeJVwHjVhijuQLuO2jbhRGtyewffoT1oZVKndbnQovKFsi2QI8ZIKGn+C2R09OI5KW4UJ84/MUpNzeyH43GXjppb5QQxIDHyyis+QwSWKrbYSlg1eIQJ3+B1VYZmgcd8F/hfZuhkGTlKiNeMz77jEZVJRmYfBbYbh2/MQIDAQABAoIBAC97qbdwp/unYG6ABHKcgfR58eWtWDtk5JoyQsqYrCPsv1WmchKTrD2eofir6+TuQ74XET2vvSmYa0WIwlx4Xr6pQDzzOPyUALyA0dfZnTN5D1LZ+ohZvb8yHg6YeYG8fXaFGWwWMeOFwmyDPFeOO1ypnE64toleguaWA6gqVDbJ6hNrtop8qs+jJlLlWbebhQ82/7paguYqdElZ7cKZn1eQDN746CQJLuLWly4Hr3RvnHHiPUzYmhjl7SsTj1DHhG4Fk7PsULtw1Z3kIvEJnek9fowb56QfNunJzjJ1OcJpOfxgbVc3KCXV8C+bgMIUgGzKHdDhxhIlCPC9IZjvzuECgYEA/SCMyB1Qb+EMloGGXqGw5GD8JO29L7g9o2RFswVEKODPV1C4HWkT+tjvx0TO64+hhAqSXef/kJxw08Lofgo3zzhQzPyKab3Ab4WLCLX9HzH813sw601kMfJ5U+nueUFvoAN1iu5jnQ7bkf3MtaWUCE9+NAB7EGZWOlcaIH9uZAUCgYEAn0GD/TMIs7Bhx1mkAlbA/sFEVfzIrMyDyDKfwRaPcShtZvhpEsVeeKopYokc1yTpn42G7HTC4AxE6Kv6iS3/yv7xts3ANXvC+6gSuh52x3180yjJMc5nEh36fuLeeHr9WMsa+Dx0OyUDmn+2Gt/RjPQ5RWvunvwgKEIUzxFOYj0CgYBFtytPClPXHIKdCTt64MmZfOS1Pw02EWZYlAtmTPMC1zgD8mVjJEeudQVFOrxKwJpZhZfeaUFIEO46RJpH7ISGfBo0+vEcQni3vm4WjhkS+G+M4Y8Nn5kS8Jdd9zYJC261AX7kLtgcr7TltqMk/F+TEmHN7Lv4PldNZiP6A17iCQKBgCYqc1FI27sEeEpoJzAQTmw/MPtSe10+Hg7qYvLJT1MVFzLoMXY4Kq3MSeK9bVX6GKsOJdmhGdrL1e/U11Ps3DJv6smegYPPxyi8XNCR4HFql3GbgqwXBQiIerHR+PLytqiC9FGtW0WZV0W9eYzzOqsHFHqYpTUgwywiug3t3dUZAoGBALvVxHjjPyk+darj/P9Jhmsap+LwnDW8oKo/xhhig7SCzkIwhkVHpnC8ywWZotbEiZKwLHFQ1ip+RwRz6FMqEnAx6r6s/8IOeoCTcA2nhwZ8YcNU/kqkrFBpxANtgKTM3fNwtQVR8hOdUqrzDrS1vZxgqAMH5HGrXgmWrdDOQxKu');
INSERT INTO public.component_config VALUES ('26aa0551-ea42-409f-92e3-ff09116d9ca6', '9a4ea80a-5d51-40ff-858f-0cbaa72ccddc', 'algorithm', 'RSA-OAEP');
INSERT INTO public.component_config VALUES ('68b6ffc1-92b6-43ee-841c-ad32935acf8f', '5ab18253-17f2-4c7e-9210-5e4f17201b2e', 'secret', '4gphtfSTOi77cqB4MYyOYg');
INSERT INTO public.component_config VALUES ('60fbd1cb-7c62-475e-89aa-b55403ae58bd', '5ab18253-17f2-4c7e-9210-5e4f17201b2e', 'priority', '100');
INSERT INTO public.component_config VALUES ('a8ee661d-c848-411a-93e4-4fe1d4bd1958', '5ab18253-17f2-4c7e-9210-5e4f17201b2e', 'kid', '7a456009-21ef-4964-b548-1b3b6edb5e41');
INSERT INTO public.component_config VALUES ('362e84f9-9753-4c1f-8ba3-864c6500e38b', 'c1ca1e8c-8312-4265-9b0f-56bc884b6080', 'keyUse', 'SIG');
INSERT INTO public.component_config VALUES ('50597bfb-783e-4228-9cf4-c0531447837c', 'c1ca1e8c-8312-4265-9b0f-56bc884b6080', 'privateKey', 'MIIEpAIBAAKCAQEAh9+QkxZ7HM08Ij75jO8gIaLToWkVilKZ+XNYT+eEwiC7kgGg0wzeWBZKGs2St6fJl/LonSJMkV9rk4Wuw8iPstCt9qi/SrWZ4IvTkKOT6uUVc4dzLeeFUdrmlNfkFPBnd2LTi9i4M2e8XNrOZ4SU4Fae0Di+IMUw1QsghW6Hy9Y5ecQxowiQoDZDUGa7F7juncCNY4X4gARSIpQsRcURFq7HiJ7AVvgNoYpIvq6LKLWyyraHwcsMS3K+/QH+k1CWXhJgAbtZVxHZJjLpxN9d4550PL1EBQu7CzMRfiISXpPU+tMZ/Durbw2BHXXG6DY2YUP11zLxU/Btxkf9l6g9iwIDAQABAoIBAByc1swyusBI8/XePx0PqjuLF3fxMikL1gLy6FEDVzCuRfGsSBrJpfT01KwqSFBGlCxcaeHVPDyM1JGfYDs4fBJS4Z+Ez6vC7GGd8HKQD/EyRr8qcfXjwG6JY29Ku2wxaAh7FkNn4vpoSQFgzoB8KgHIG++LU3aBMBRdIH8Y1J328WY5xFyayMFNTQwiPKIUHA6+l8dsVLJeYIch2QRLQWWV53l4i3MKdgnFZdiub5Aym1pnbQ+yRgGOv0y07Vjb1+/jcskkssT3ncWl99YfY9vg68i+Kpm8+bv9t1VxZn9vZVBvs1upUfdR4940imy/ggs9ndLJGPD9HNCei8CuxdkCgYEA6R3/FoLl6Um4fXHoAZq/bCPLmZJwvA2xmHqAI1qLm3P0xlyamvhFPoCh8Oz9yfUGojrS+r4VIQ1m1qCQY7Jt630EgLEDrxDnCTCOsdDSgCwHr15NaJkiPimcVluMFdZpMKmU8uRGf0L3RMaEDkZz+1UGkSqCj71x3z8yY6rFzH8CgYEAlTXtFmg3LmAxC9ROXuMcwD+gIorVnAl/zVi3kDvkAhzxX5TR4O4t+btvNEIrLRLGKsDrQj1bG06UHlAV7tZAynSDvbrd12Rzgx+DItLqt45blY4/txEHKHauK+ASnu9Nl/KyQdEH5VH8ZJcLFcgQfo29RYEP8+KeuZqz80+AePUCgYEAoj1hKh6hujG3d37N9Efpz24+Jbx4Pzjcj/05ruE2ZlNWWLNcWlxNfMlza0TVADhKjJ+Z9C5UcDNujhMjSm+E9q6Ecrg/kxiVYpzrwq9NwSxjkNZ100U4QsEc8DE4ln4pqVdstXrP4YQOqUvr3i+ESrgLIP7P7Q/w72mBPUI99SsCgYBZDyflAO02zAlaQy1H640EnrVpCK75BJ54paRi/axZKodTgpNHC0L71UlJytjUfWk0qZOCJPcVNHCqKyj8NnvTm3nqq/evkXB06kEubu/UAa9ec9pJ3WsFVtkcrRDQNot8z0pgiHCLCsV4EMN4C8L0lotLSf6IllIg/Fq+Nky7ZQKBgQDcCjHKhchjJPQd2uHTo+KUdTo7RSSzU+dZdg/1VNvKU39WlDIPFi7boSYiAKKGkSc8qImVuuK70K8ApO7mtZcXBLhMWG6bJ/xvsZS/PKo9gPsCgF3kcbjZ+Q5o9qQgijgf3N2Rd+61/AhH7J2Xo4ehbB8Ju99A+Xg/2zbzq7QARg==');
INSERT INTO public.component_config VALUES ('3f258aab-f954-4162-82ca-49997b6545ee', 'c1ca1e8c-8312-4265-9b0f-56bc884b6080', 'certificate', 'MIICmzCCAYMCBgGD/ucU8DANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjIxMDIyMDg1MzIwWhcNMzIxMDIyMDg1NTAwWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCH35CTFnsczTwiPvmM7yAhotOhaRWKUpn5c1hP54TCILuSAaDTDN5YFkoazZK3p8mX8uidIkyRX2uTha7DyI+y0K32qL9KtZngi9OQo5Pq5RVzh3Mt54VR2uaU1+QU8Gd3YtOL2LgzZ7xc2s5nhJTgVp7QOL4gxTDVCyCFbofL1jl5xDGjCJCgNkNQZrsXuO6dwI1jhfiABFIilCxFxREWrseInsBW+A2hiki+rosotbLKtofBywxLcr79Af6TUJZeEmABu1lXEdkmMunE313jnnQ8vUQFC7sLMxF+IhJek9T60xn8O6tvDYEddcboNjZhQ/XXMvFT8G3GR/2XqD2LAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAGsuT8QwSbdPgX3qFEn4uQt2z+bNvPxEVgZVOJEX935QRHy0yIoJ6tAa2gbmAUF59PcJmGEdFglWEeNYW4oPsPbZ+ahVnppVuRiQrBhHAJGuSIKK+yUKD9O0mpMGlvOovznkzufbmZ779SLcbtiCj2qrimZu45TrNl7VqiThwytuybpOX+9b1eV0sz5NXa6AIZhzjiY2EoeUwqNh6Wgu5IOS8Je2b7rJUCkiE1G9sEFj7gMghlPWbST5XtVZT0v2rJsSx+HsvKklAe2mtmEVYQ0oQ7tMghjwOmlvxz56TVa/O5miE9LbdpC3SRCdna+n70dw+PZuc/8JP8p1IrWcc4M=');
INSERT INTO public.component_config VALUES ('c634e770-a8c5-494c-b0c3-4d9dff391ee1', 'c1ca1e8c-8312-4265-9b0f-56bc884b6080', 'priority', '100');
INSERT INTO public.component_config VALUES ('e9895dba-04e8-42dd-b495-f457218120d5', 'd84484c7-61f5-4090-9a05-fef8ecf0c5c4', 'priority', '100');
INSERT INTO public.component_config VALUES ('7e243843-0ed7-4a63-a44d-5e2dfc346ca1', 'd84484c7-61f5-4090-9a05-fef8ecf0c5c4', 'secret', 'Whir56FgzCHO9sI5esIK3dri_56n2ev3umzZIRU2p11doSsnMTh0JHcUBH9DZ1U8Xz4jw3kQGvoti0xFiJMo1Q');
INSERT INTO public.component_config VALUES ('b8222532-20dd-46f0-9950-2800a0ffd6f4', 'd84484c7-61f5-4090-9a05-fef8ecf0c5c4', 'kid', '17e0dbe6-8d77-4de5-9a7e-cf810285886b');
INSERT INTO public.component_config VALUES ('daf2843e-f2d1-4bf1-a861-8b3bacdbb17a', 'd84484c7-61f5-4090-9a05-fef8ecf0c5c4', 'algorithm', 'HS256');


--
-- TOC entry 4125 (class 0 OID 16417)
-- Dependencies: 219
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO public.composite_role VALUES ('4f44b5ce-a4a6-42c7-ba49-5609636f7774', '783258fe-3f0b-4a90-80ab-796a653d54e1');
INSERT INTO public.composite_role VALUES ('4f44b5ce-a4a6-42c7-ba49-5609636f7774', 'eab45139-a13b-4ee2-865d-37a33177fb05');
INSERT INTO public.composite_role VALUES ('4f44b5ce-a4a6-42c7-ba49-5609636f7774', '110c8cf6-6918-4981-8d4b-ec36c328cc12');
INSERT INTO public.composite_role VALUES ('4f44b5ce-a4a6-42c7-ba49-5609636f7774', 'b092afe5-7381-472a-b05c-2e0d3a1790f4');
INSERT INTO public.composite_role VALUES ('4f44b5ce-a4a6-42c7-ba49-5609636f7774', 'b38a088a-71fe-4aac-9cf2-8a74ba44918d');
INSERT INTO public.composite_role VALUES ('4f44b5ce-a4a6-42c7-ba49-5609636f7774', '00c2716a-0db0-47a6-bec2-858b427ba3c2');
INSERT INTO public.composite_role VALUES ('4f44b5ce-a4a6-42c7-ba49-5609636f7774', '8aae1799-b1a4-45d2-a7e2-90d5949b7ef5');
INSERT INTO public.composite_role VALUES ('4f44b5ce-a4a6-42c7-ba49-5609636f7774', '1f5427e7-4b13-4f33-b977-4334a044a88c');
INSERT INTO public.composite_role VALUES ('4f44b5ce-a4a6-42c7-ba49-5609636f7774', 'd68bca3b-6ad8-4e8d-928f-bee00b78a0d7');
INSERT INTO public.composite_role VALUES ('4f44b5ce-a4a6-42c7-ba49-5609636f7774', '5d0d94df-69ed-48f5-8bb7-9fb706cb86c9');
INSERT INTO public.composite_role VALUES ('4f44b5ce-a4a6-42c7-ba49-5609636f7774', 'f27a3695-7c5a-4175-b3e8-6bc3713de932');
INSERT INTO public.composite_role VALUES ('4f44b5ce-a4a6-42c7-ba49-5609636f7774', '679b75ff-bd9a-49e3-a65a-b11d91500f20');
INSERT INTO public.composite_role VALUES ('4f44b5ce-a4a6-42c7-ba49-5609636f7774', 'ec686a97-270d-4692-94ee-904b82ffcc01');
INSERT INTO public.composite_role VALUES ('4f44b5ce-a4a6-42c7-ba49-5609636f7774', 'f98d4933-912f-4ba3-b7d6-aabd496bca7e');
INSERT INTO public.composite_role VALUES ('4f44b5ce-a4a6-42c7-ba49-5609636f7774', 'b121efec-785f-48b1-bd9a-6405b14b2c03');
INSERT INTO public.composite_role VALUES ('4f44b5ce-a4a6-42c7-ba49-5609636f7774', '2597b09b-51aa-402b-9619-5949ec53308e');
INSERT INTO public.composite_role VALUES ('4f44b5ce-a4a6-42c7-ba49-5609636f7774', '34514542-e4c6-4baf-8219-403ce58f9b99');
INSERT INTO public.composite_role VALUES ('4f44b5ce-a4a6-42c7-ba49-5609636f7774', 'edd36c58-83f1-4e4e-ab87-d757bc132bbc');
INSERT INTO public.composite_role VALUES ('b38a088a-71fe-4aac-9cf2-8a74ba44918d', '2597b09b-51aa-402b-9619-5949ec53308e');
INSERT INTO public.composite_role VALUES ('b092afe5-7381-472a-b05c-2e0d3a1790f4', 'edd36c58-83f1-4e4e-ab87-d757bc132bbc');
INSERT INTO public.composite_role VALUES ('b092afe5-7381-472a-b05c-2e0d3a1790f4', 'b121efec-785f-48b1-bd9a-6405b14b2c03');
INSERT INTO public.composite_role VALUES ('f275dcfc-4a2f-4309-bf00-dcd1d5c12080', '42d5d593-88ca-434b-baf2-6bdfa2a027f1');
INSERT INTO public.composite_role VALUES ('f275dcfc-4a2f-4309-bf00-dcd1d5c12080', '31816775-a12b-47f0-9bab-3ee99f672181');
INSERT INTO public.composite_role VALUES ('31816775-a12b-47f0-9bab-3ee99f672181', 'c8a9cc2e-ff44-488d-85fc-2d047916404e');
INSERT INTO public.composite_role VALUES ('c6f1ed16-8268-4e3c-b994-dd5288efbabb', '7c3a8254-8f58-42ab-a779-dc45c37ac238');
INSERT INTO public.composite_role VALUES ('4f44b5ce-a4a6-42c7-ba49-5609636f7774', '7e03903b-a6e3-48a0-bc4a-7608f9dcb2d2');
INSERT INTO public.composite_role VALUES ('f275dcfc-4a2f-4309-bf00-dcd1d5c12080', '7d9633f4-e669-409e-b409-cd47599f27ce');
INSERT INTO public.composite_role VALUES ('f275dcfc-4a2f-4309-bf00-dcd1d5c12080', 'ab4d98ad-534a-465d-8720-6ed1173d6216');


--
-- TOC entry 4126 (class 0 OID 16420)
-- Dependencies: 220
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO public.credential VALUES ('d72c65c5-9c2f-4604-a84e-2f1dddb82df4', NULL, 'password', 'f59b57a0-0485-4722-919e-59957370b890', 1666428901751, NULL, '{"value":"jJb9fz7CHI22NGJNCo8kjUravWZ4/l5ZHLgkOPK55rrJCr3hbmzxi/p75PmpAG+PVs/P6cehUfWvZf/dgmW0Qw==","salt":"+mW0lmHxblFz0Gm6hlTw9w==","additionalParameters":{}}', '{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}', 10);
INSERT INTO public.credential VALUES ('0848c5bb-6d93-4cbf-9e92-af15136ba062', NULL, 'password', '9c8fe163-ded4-4f73-abf8-6db39a6f36c6', 1666429385202, NULL, '{"value":"oy9CYqPSpvI/1lkegb1fBPtDc3siffY/rk1SwPycU0zNDg9npuy42wGRxrneyfoiSVHt2vorlnX+j9kAtPhLaQ==","salt":"+ealh0kW8Elsig7BJeVY0g==","additionalParameters":{}}', '{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}', 10);
INSERT INTO public.credential VALUES ('efdfd1e6-12d3-473a-b1c4-0323cc0c1abc', NULL, 'password', '72da7f8a-9478-46c3-8b00-3357aaece36a', 1666429406524, NULL, '{"value":"0dDkAKS+/vZfim+hrdyisy67xYzwqR2lCqSG0hPvPGU5xo2PrVUyyS5fVbQ+sjkPBS8r08trysiLBzK8QYQVAQ==","salt":"t5fM+x66xlD1qetKIFFm6g==","additionalParameters":{}}', '{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}', 10);


--
-- TOC entry 4121 (class 0 OID 16390)
-- Dependencies: 215
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO public.databasechangelog VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.0.0.Final.xml', '2022-10-22 08:54:50.79522', 1, 'EXECUTED', '7:4e70412f24a3f382c82183742ec79317', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/db2-jpa-changelog-1.0.0.Final.xml', '2022-10-22 08:54:50.812645', 2, 'MARK_RAN', '7:cb16724583e9675711801c6875114f28', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('1.1.0.Beta1', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Beta1.xml', '2022-10-22 08:54:50.870658', 3, 'EXECUTED', '7:0310eb8ba07cec616460794d42ade0fa', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('1.1.0.Final', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Final.xml', '2022-10-22 08:54:50.880059', 4, 'EXECUTED', '7:5d25857e708c3233ef4439df1f93f012', 'renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/jpa-changelog-1.2.0.Beta1.xml', '2022-10-22 08:54:51.035587', 5, 'EXECUTED', '7:c7a54a1041d58eb3817a4a883b4d4e84', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.Beta1.xml', '2022-10-22 08:54:51.04115', 6, 'MARK_RAN', '7:2e01012df20974c1c2a605ef8afe25b7', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.2.0.CR1.xml', '2022-10-22 08:54:51.162156', 7, 'EXECUTED', '7:0f08df48468428e0f30ee59a8ec01a41', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.CR1.xml', '2022-10-22 08:54:51.167708', 8, 'MARK_RAN', '7:a77ea2ad226b345e7d689d366f185c8c', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('1.2.0.Final', 'keycloak', 'META-INF/jpa-changelog-1.2.0.Final.xml', '2022-10-22 08:54:51.174433', 9, 'EXECUTED', '7:a3377a2059aefbf3b90ebb4c4cc8e2ab', 'update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('1.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.3.0.xml', '2022-10-22 08:54:51.325223', 10, 'EXECUTED', '7:04c1dbedc2aa3e9756d1a1668e003451', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.4.0.xml', '2022-10-22 08:54:51.465537', 11, 'EXECUTED', '7:36ef39ed560ad07062d956db861042ba', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.4.0.xml', '2022-10-22 08:54:51.479293', 12, 'MARK_RAN', '7:d909180b2530479a716d3f9c9eaea3d7', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('1.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.5.0.xml', '2022-10-22 08:54:51.521036', 13, 'EXECUTED', '7:cf12b04b79bea5152f165eb41f3955f6', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('1.6.1_from15', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2022-10-22 08:54:51.593983', 14, 'EXECUTED', '7:7e32c8f05c755e8675764e7d5f514509', 'addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('1.6.1_from16-pre', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2022-10-22 08:54:51.604502', 15, 'MARK_RAN', '7:980ba23cc0ec39cab731ce903dd01291', 'delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('1.6.1_from16', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2022-10-22 08:54:51.608702', 16, 'MARK_RAN', '7:2fa220758991285312eb84f3b4ff5336', 'dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('1.6.1', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2022-10-22 08:54:51.617448', 17, 'EXECUTED', '7:d41d8cd98f00b204e9800998ecf8427e', 'empty', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('1.7.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.7.0.xml', '2022-10-22 08:54:51.72063', 18, 'EXECUTED', '7:91ace540896df890cc00a0490ee52bbc', 'createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.8.0.xml', '2022-10-22 08:54:51.783912', 19, 'EXECUTED', '7:c31d1646dfa2618a9335c00e07f89f24', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('1.8.0-2', 'keycloak', 'META-INF/jpa-changelog-1.8.0.xml', '2022-10-22 08:54:51.791436', 20, 'EXECUTED', '7:df8bc21027a4f7cbbb01f6344e89ce07', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part1', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-10-22 08:54:53.613454', 45, 'EXECUTED', '7:6a48ce645a3525488a90fbf76adf3bb3', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2022-10-22 08:54:51.795775', 21, 'MARK_RAN', '7:f987971fe6b37d963bc95fee2b27f8df', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('1.8.0-2', 'keycloak', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2022-10-22 08:54:51.80009', 22, 'MARK_RAN', '7:df8bc21027a4f7cbbb01f6344e89ce07', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('1.9.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.9.0.xml', '2022-10-22 08:54:51.866012', 23, 'EXECUTED', '7:ed2dc7f799d19ac452cbcda56c929e47', 'update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('1.9.1', 'keycloak', 'META-INF/jpa-changelog-1.9.1.xml', '2022-10-22 08:54:51.87519', 24, 'EXECUTED', '7:80b5db88a5dda36ece5f235be8757615', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('1.9.1', 'keycloak', 'META-INF/db2-jpa-changelog-1.9.1.xml', '2022-10-22 08:54:51.88552', 25, 'MARK_RAN', '7:1437310ed1305a9b93f8848f301726ce', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('1.9.2', 'keycloak', 'META-INF/jpa-changelog-1.9.2.xml', '2022-10-22 08:54:52.255974', 26, 'EXECUTED', '7:b82ffb34850fa0836be16deefc6a87c4', 'createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('authz-2.0.0', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.0.0.xml', '2022-10-22 08:54:52.402143', 27, 'EXECUTED', '7:9cc98082921330d8d9266decdd4bd658', 'createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('authz-2.5.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.5.1.xml', '2022-10-22 08:54:52.409514', 28, 'EXECUTED', '7:03d64aeed9cb52b969bd30a7ac0db57e', 'update tableName=RESOURCE_SERVER_POLICY', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('2.1.0-KEYCLOAK-5461', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.1.0.xml', '2022-10-22 08:54:52.518258', 29, 'EXECUTED', '7:f1f9fd8710399d725b780f463c6b21cd', 'createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('2.2.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.2.0.xml', '2022-10-22 08:54:52.547581', 30, 'EXECUTED', '7:53188c3eb1107546e6f765835705b6c1', 'addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('2.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.3.0.xml', '2022-10-22 08:54:52.574425', 31, 'EXECUTED', '7:d6e6f3bc57a0c5586737d1351725d4d4', 'createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('2.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.4.0.xml', '2022-10-22 08:54:52.582625', 32, 'EXECUTED', '7:454d604fbd755d9df3fd9c6329043aa5', 'customChange', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('2.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2022-10-22 08:54:52.589975', 33, 'EXECUTED', '7:57e98a3077e29caf562f7dbf80c72600', 'customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('2.5.0-unicode-oracle', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2022-10-22 08:54:52.593585', 34, 'MARK_RAN', '7:e4c7e8f2256210aee71ddc42f538b57a', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('2.5.0-unicode-other-dbs', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2022-10-22 08:54:52.634106', 35, 'EXECUTED', '7:09a43c97e49bc626460480aa1379b522', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('2.5.0-duplicate-email-support', 'slawomir@dabek.name', 'META-INF/jpa-changelog-2.5.0.xml', '2022-10-22 08:54:52.643072', 36, 'EXECUTED', '7:26bfc7c74fefa9126f2ce702fb775553', 'addColumn tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('2.5.0-unique-group-names', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2022-10-22 08:54:52.653601', 37, 'EXECUTED', '7:a161e2ae671a9020fff61e996a207377', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('2.5.1', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.1.xml', '2022-10-22 08:54:52.662677', 38, 'EXECUTED', '7:37fc1781855ac5388c494f1442b3f717', 'addColumn tableName=FED_USER_CONSENT', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('3.0.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-3.0.0.xml', '2022-10-22 08:54:52.668656', 39, 'EXECUTED', '7:13a27db0dae6049541136adad7261d27', 'addColumn tableName=IDENTITY_PROVIDER', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('3.2.0-fix', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2022-10-22 08:54:52.67213', 40, 'MARK_RAN', '7:550300617e3b59e8af3a6294df8248a3', 'addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('3.2.0-fix-with-keycloak-5416', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2022-10-22 08:54:52.675709', 41, 'MARK_RAN', '7:e3a9482b8931481dc2772a5c07c44f17', 'dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('3.2.0-fix-offline-sessions', 'hmlnarik', 'META-INF/jpa-changelog-3.2.0.xml', '2022-10-22 08:54:52.681795', 42, 'EXECUTED', '7:72b07d85a2677cb257edb02b408f332d', 'customChange', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('3.2.0-fixed', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2022-10-22 08:54:53.599366', 43, 'EXECUTED', '7:a72a7858967bd414835d19e04d880312', 'addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('3.3.0', 'keycloak', 'META-INF/jpa-changelog-3.3.0.xml', '2022-10-22 08:54:53.606924', 44, 'EXECUTED', '7:94edff7cf9ce179e7e85f0cd78a3cf2c', 'addColumn tableName=USER_ENTITY', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-10-22 08:54:53.620145', 46, 'EXECUTED', '7:e64b5dcea7db06077c6e57d3b9e5ca14', 'customChange', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-10-22 08:54:53.623271', 47, 'MARK_RAN', '7:fd8cf02498f8b1e72496a20afc75178c', 'dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-10-22 08:54:53.716275', 48, 'EXECUTED', '7:542794f25aa2b1fbabb7e577d6646319', 'addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('authn-3.4.0.CR1-refresh-token-max-reuse', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-10-22 08:54:53.722523', 49, 'EXECUTED', '7:edad604c882df12f74941dac3cc6d650', 'addColumn tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('3.4.0', 'keycloak', 'META-INF/jpa-changelog-3.4.0.xml', '2022-10-22 08:54:53.802109', 50, 'EXECUTED', '7:0f88b78b7b46480eb92690cbf5e44900', 'addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('3.4.0-KEYCLOAK-5230', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-3.4.0.xml', '2022-10-22 08:54:54.01581', 51, 'EXECUTED', '7:d560e43982611d936457c327f872dd59', 'createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('3.4.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-3.4.1.xml', '2022-10-22 08:54:54.021416', 52, 'EXECUTED', '7:c155566c42b4d14ef07059ec3b3bbd8e', 'modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('3.4.2', 'keycloak', 'META-INF/jpa-changelog-3.4.2.xml', '2022-10-22 08:54:54.026396', 53, 'EXECUTED', '7:b40376581f12d70f3c89ba8ddf5b7dea', 'update tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('3.4.2-KEYCLOAK-5172', 'mkanis@redhat.com', 'META-INF/jpa-changelog-3.4.2.xml', '2022-10-22 08:54:54.030347', 54, 'EXECUTED', '7:a1132cc395f7b95b3646146c2e38f168', 'update tableName=CLIENT', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('4.0.0-KEYCLOAK-6335', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2022-10-22 08:54:54.041243', 55, 'EXECUTED', '7:d8dc5d89c789105cfa7ca0e82cba60af', 'createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('4.0.0-CLEANUP-UNUSED-TABLE', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2022-10-22 08:54:54.048429', 56, 'EXECUTED', '7:7822e0165097182e8f653c35517656a3', 'dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('4.0.0-KEYCLOAK-6228', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2022-10-22 08:54:54.119824', 57, 'EXECUTED', '7:c6538c29b9c9a08f9e9ea2de5c2b6375', 'dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('4.0.0-KEYCLOAK-5579-fixed', 'mposolda@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2022-10-22 08:54:54.38698', 58, 'EXECUTED', '7:6d4893e36de22369cf73bcb051ded875', 'dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('authz-4.0.0.CR1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.CR1.xml', '2022-10-22 08:54:54.422535', 59, 'EXECUTED', '7:57960fc0b0f0dd0563ea6f8b2e4a1707', 'createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('authz-4.0.0.Beta3', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.Beta3.xml', '2022-10-22 08:54:54.430062', 60, 'EXECUTED', '7:2b4b8bff39944c7097977cc18dbceb3b', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('authz-4.2.0.Final', 'mhajas@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2022-10-22 08:54:54.438526', 61, 'EXECUTED', '7:2aa42a964c59cd5b8ca9822340ba33a8', 'createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('authz-4.2.0.Final-KEYCLOAK-9944', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2022-10-22 08:54:54.448406', 62, 'EXECUTED', '7:9ac9e58545479929ba23f4a3087a0346', 'addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('4.2.0-KEYCLOAK-6313', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.2.0.xml', '2022-10-22 08:54:54.454131', 63, 'EXECUTED', '7:14d407c35bc4fe1976867756bcea0c36', 'addColumn tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('4.3.0-KEYCLOAK-7984', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.3.0.xml', '2022-10-22 08:54:54.457745', 64, 'EXECUTED', '7:241a8030c748c8548e346adee548fa93', 'update tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('4.6.0-KEYCLOAK-7950', 'psilva@redhat.com', 'META-INF/jpa-changelog-4.6.0.xml', '2022-10-22 08:54:54.461265', 65, 'EXECUTED', '7:7d3182f65a34fcc61e8d23def037dc3f', 'update tableName=RESOURCE_SERVER_RESOURCE', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('4.6.0-KEYCLOAK-8377', 'keycloak', 'META-INF/jpa-changelog-4.6.0.xml', '2022-10-22 08:54:54.488572', 66, 'EXECUTED', '7:b30039e00a0b9715d430d1b0636728fa', 'createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('4.6.0-KEYCLOAK-8555', 'gideonray@gmail.com', 'META-INF/jpa-changelog-4.6.0.xml', '2022-10-22 08:54:54.509029', 67, 'EXECUTED', '7:3797315ca61d531780f8e6f82f258159', 'createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('4.7.0-KEYCLOAK-1267', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.7.0.xml', '2022-10-22 08:54:54.51608', 68, 'EXECUTED', '7:c7aa4c8d9573500c2d347c1941ff0301', 'addColumn tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('4.7.0-KEYCLOAK-7275', 'keycloak', 'META-INF/jpa-changelog-4.7.0.xml', '2022-10-22 08:54:54.54432', 69, 'EXECUTED', '7:b207faee394fc074a442ecd42185a5dd', 'renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('4.8.0-KEYCLOAK-8835', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.8.0.xml', '2022-10-22 08:54:54.551987', 70, 'EXECUTED', '7:ab9a9762faaba4ddfa35514b212c4922', 'addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('authz-7.0.0-KEYCLOAK-10443', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-7.0.0.xml', '2022-10-22 08:54:54.558907', 71, 'EXECUTED', '7:b9710f74515a6ccb51b72dc0d19df8c4', 'addColumn tableName=RESOURCE_SERVER', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('8.0.0-adding-credential-columns', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-10-22 08:54:54.569008', 72, 'EXECUTED', '7:ec9707ae4d4f0b7452fee20128083879', 'addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('8.0.0-updating-credential-data-not-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-10-22 08:54:54.578554', 73, 'EXECUTED', '7:3979a0ae07ac465e920ca696532fc736', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('8.0.0-updating-credential-data-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-10-22 08:54:54.582084', 74, 'MARK_RAN', '7:5abfde4c259119d143bd2fbf49ac2bca', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('8.0.0-credential-cleanup-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-10-22 08:54:54.602606', 75, 'EXECUTED', '7:b48da8c11a3d83ddd6b7d0c8c2219345', 'dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('8.0.0-resource-tag-support', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-10-22 08:54:54.629157', 76, 'EXECUTED', '7:a73379915c23bfad3e8f5c6d5c0aa4bd', 'addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('9.0.0-always-display-client', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2022-10-22 08:54:54.63507', 77, 'EXECUTED', '7:39e0073779aba192646291aa2332493d', 'addColumn tableName=CLIENT', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('9.0.0-drop-constraints-for-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2022-10-22 08:54:54.638552', 78, 'MARK_RAN', '7:81f87368f00450799b4bf42ea0b3ec34', 'dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('9.0.0-increase-column-size-federated-fk', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2022-10-22 08:54:54.662778', 79, 'EXECUTED', '7:20b37422abb9fb6571c618148f013a15', 'modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('9.0.0-recreate-constraints-after-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2022-10-22 08:54:54.666541', 80, 'MARK_RAN', '7:1970bb6cfb5ee800736b95ad3fb3c78a', 'addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('9.0.1-add-index-to-client.client_id', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-10-22 08:54:54.691051', 81, 'EXECUTED', '7:45d9b25fc3b455d522d8dcc10a0f4c80', 'createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('9.0.1-KEYCLOAK-12579-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-10-22 08:54:54.694901', 82, 'MARK_RAN', '7:890ae73712bc187a66c2813a724d037f', 'dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('9.0.1-KEYCLOAK-12579-add-not-null-constraint', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-10-22 08:54:54.701222', 83, 'EXECUTED', '7:0a211980d27fafe3ff50d19a3a29b538', 'addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('9.0.1-KEYCLOAK-12579-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-10-22 08:54:54.704695', 84, 'MARK_RAN', '7:a161e2ae671a9020fff61e996a207377', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('9.0.1-add-index-to-events', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-10-22 08:54:54.723702', 85, 'EXECUTED', '7:01c49302201bdf815b0a18d1f98a55dc', 'createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-11.0.0.xml', '2022-10-22 08:54:54.731647', 86, 'EXECUTED', '7:3dace6b144c11f53f1ad2c0361279b86', 'dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', '2022-10-22 08:54:54.741205', 87, 'EXECUTED', '7:578d0b92077eaf2ab95ad0ec087aa903', 'dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('12.1.0-add-realm-localization-table', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', '2022-10-22 08:54:54.75553', 88, 'EXECUTED', '7:c95abe90d962c57a09ecaee57972835d', 'createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('default-roles', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-10-22 08:54:54.764014', 89, 'EXECUTED', '7:f1313bcc2994a5c4dc1062ed6d8282d3', 'addColumn tableName=REALM; customChange', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('default-roles-cleanup', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-10-22 08:54:54.773217', 90, 'EXECUTED', '7:90d763b52eaffebefbcbde55f269508b', 'dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('13.0.0-KEYCLOAK-16844', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-10-22 08:54:54.793595', 91, 'EXECUTED', '7:d554f0cb92b764470dccfa5e0014a7dd', 'createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('map-remove-ri-13.0.0', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-10-22 08:54:54.802557', 92, 'EXECUTED', '7:73193e3ab3c35cf0f37ccea3bf783764', 'dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('13.0.0-KEYCLOAK-17992-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-10-22 08:54:54.806189', 93, 'MARK_RAN', '7:90a1e74f92e9cbaa0c5eab80b8a037f3', 'dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('13.0.0-increase-column-size-federated', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-10-22 08:54:54.821645', 94, 'EXECUTED', '7:5b9248f29cd047c200083cc6d8388b16', 'modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('13.0.0-KEYCLOAK-17992-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-10-22 08:54:54.824946', 95, 'MARK_RAN', '7:64db59e44c374f13955489e8990d17a1', 'addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('json-string-accomodation-fixed', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-10-22 08:54:54.835922', 96, 'EXECUTED', '7:329a578cdb43262fff975f0a7f6cda60', 'addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('14.0.0-KEYCLOAK-11019', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-10-22 08:54:54.898654', 97, 'EXECUTED', '7:fae0de241ac0fd0bbc2b380b85e4f567', 'createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-10-22 08:54:54.90566', 98, 'MARK_RAN', '7:075d54e9180f49bb0c64ca4218936e81', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286-revert', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-10-22 08:54:54.917125', 99, 'MARK_RAN', '7:06499836520f4f6b3d05e35a59324910', 'dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286-supported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-10-22 08:54:54.942275', 100, 'EXECUTED', '7:fad08e83c77d0171ec166bc9bc5d390a', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286-unsupported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-10-22 08:54:54.945545', 101, 'MARK_RAN', '7:3d2b23076e59c6f70bae703aa01be35b', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('KEYCLOAK-17267-add-index-to-user-attributes', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-10-22 08:54:54.969542', 102, 'EXECUTED', '7:1a7f28ff8d9e53aeb879d76ea3d9341a', 'createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('KEYCLOAK-18146-add-saml-art-binding-identifier', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-10-22 08:54:54.975142', 103, 'EXECUTED', '7:2fd554456fed4a82c698c555c5b751b6', 'customChange', '', NULL, '3.5.4', NULL, NULL, '6428890093');
INSERT INTO public.databasechangelog VALUES ('15.0.0-KEYCLOAK-18467', 'keycloak', 'META-INF/jpa-changelog-15.0.0.xml', '2022-10-22 08:54:54.983006', 104, 'EXECUTED', '7:b06356d66c2790ecc2ae54ba0458397a', 'addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...', '', NULL, '3.5.4', NULL, NULL, '6428890093');


--
-- TOC entry 4120 (class 0 OID 16385)
-- Dependencies: 214
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO public.databasechangeloglock VALUES (1, false, NULL, NULL);
INSERT INTO public.databasechangeloglock VALUES (1000, false, NULL, NULL);
INSERT INTO public.databasechangeloglock VALUES (1001, false, NULL, NULL);


--
-- TOC entry 4204 (class 0 OID 17784)
-- Dependencies: 298
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO public.default_client_scope VALUES ('master', '5bbfcfac-57f3-46c3-b033-98d9f65f8b4c', false);
INSERT INTO public.default_client_scope VALUES ('master', 'eccade99-409a-4939-9f70-8c74d704831c', true);
INSERT INTO public.default_client_scope VALUES ('master', '06f497ae-a985-4616-aa1f-05f22a1762fe', true);
INSERT INTO public.default_client_scope VALUES ('master', '32cd8045-27c4-4a8c-b52b-65a54e4e09b2', true);
INSERT INTO public.default_client_scope VALUES ('master', '0aa5b00c-5f1a-4f57-b945-aafd7289718f', false);
INSERT INTO public.default_client_scope VALUES ('master', 'be579c97-0c20-4553-bad3-aacdd3fdb5a7', false);
INSERT INTO public.default_client_scope VALUES ('master', 'f061ac1e-b240-4971-b4da-4051626671ae', true);
INSERT INTO public.default_client_scope VALUES ('master', '29055654-85af-4ecb-967c-626d2bf55c8c', true);
INSERT INTO public.default_client_scope VALUES ('master', '0b315b1e-8ffc-45da-b6f4-23ad57e52a73', false);


--
-- TOC entry 4127 (class 0 OID 16425)
-- Dependencies: 221
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4192 (class 0 OID 17483)
-- Dependencies: 286
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4193 (class 0 OID 17488)
-- Dependencies: 287
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4206 (class 0 OID 17810)
-- Dependencies: 300
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4194 (class 0 OID 17497)
-- Dependencies: 288
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4195 (class 0 OID 17506)
-- Dependencies: 289
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4196 (class 0 OID 17509)
-- Dependencies: 290
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4197 (class 0 OID 17515)
-- Dependencies: 291
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4150 (class 0 OID 16802)
-- Dependencies: 244
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4200 (class 0 OID 17580)
-- Dependencies: 294
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4176 (class 0 OID 17204)
-- Dependencies: 270
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4175 (class 0 OID 17201)
-- Dependencies: 269
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4151 (class 0 OID 16807)
-- Dependencies: 245
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4152 (class 0 OID 16816)
-- Dependencies: 246
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4157 (class 0 OID 16920)
-- Dependencies: 251
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4158 (class 0 OID 16925)
-- Dependencies: 252
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4174 (class 0 OID 17198)
-- Dependencies: 268
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4128 (class 0 OID 16433)
-- Dependencies: 222
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO public.keycloak_role VALUES ('f275dcfc-4a2f-4309-bf00-dcd1d5c12080', 'master', false, '${role_default-roles}', 'default-roles-master', 'master', NULL, NULL);
INSERT INTO public.keycloak_role VALUES ('4f44b5ce-a4a6-42c7-ba49-5609636f7774', 'master', false, '${role_admin}', 'admin', 'master', NULL, NULL);
INSERT INTO public.keycloak_role VALUES ('783258fe-3f0b-4a90-80ab-796a653d54e1', 'master', false, '${role_create-realm}', 'create-realm', 'master', NULL, NULL);
INSERT INTO public.keycloak_role VALUES ('eab45139-a13b-4ee2-865d-37a33177fb05', 'ba21cbd8-f648-48c5-9198-0d88c41702d8', true, '${role_create-client}', 'create-client', 'master', 'ba21cbd8-f648-48c5-9198-0d88c41702d8', NULL);
INSERT INTO public.keycloak_role VALUES ('110c8cf6-6918-4981-8d4b-ec36c328cc12', 'ba21cbd8-f648-48c5-9198-0d88c41702d8', true, '${role_view-realm}', 'view-realm', 'master', 'ba21cbd8-f648-48c5-9198-0d88c41702d8', NULL);
INSERT INTO public.keycloak_role VALUES ('b092afe5-7381-472a-b05c-2e0d3a1790f4', 'ba21cbd8-f648-48c5-9198-0d88c41702d8', true, '${role_view-users}', 'view-users', 'master', 'ba21cbd8-f648-48c5-9198-0d88c41702d8', NULL);
INSERT INTO public.keycloak_role VALUES ('b38a088a-71fe-4aac-9cf2-8a74ba44918d', 'ba21cbd8-f648-48c5-9198-0d88c41702d8', true, '${role_view-clients}', 'view-clients', 'master', 'ba21cbd8-f648-48c5-9198-0d88c41702d8', NULL);
INSERT INTO public.keycloak_role VALUES ('00c2716a-0db0-47a6-bec2-858b427ba3c2', 'ba21cbd8-f648-48c5-9198-0d88c41702d8', true, '${role_view-events}', 'view-events', 'master', 'ba21cbd8-f648-48c5-9198-0d88c41702d8', NULL);
INSERT INTO public.keycloak_role VALUES ('8aae1799-b1a4-45d2-a7e2-90d5949b7ef5', 'ba21cbd8-f648-48c5-9198-0d88c41702d8', true, '${role_view-identity-providers}', 'view-identity-providers', 'master', 'ba21cbd8-f648-48c5-9198-0d88c41702d8', NULL);
INSERT INTO public.keycloak_role VALUES ('1f5427e7-4b13-4f33-b977-4334a044a88c', 'ba21cbd8-f648-48c5-9198-0d88c41702d8', true, '${role_view-authorization}', 'view-authorization', 'master', 'ba21cbd8-f648-48c5-9198-0d88c41702d8', NULL);
INSERT INTO public.keycloak_role VALUES ('d68bca3b-6ad8-4e8d-928f-bee00b78a0d7', 'ba21cbd8-f648-48c5-9198-0d88c41702d8', true, '${role_manage-realm}', 'manage-realm', 'master', 'ba21cbd8-f648-48c5-9198-0d88c41702d8', NULL);
INSERT INTO public.keycloak_role VALUES ('5d0d94df-69ed-48f5-8bb7-9fb706cb86c9', 'ba21cbd8-f648-48c5-9198-0d88c41702d8', true, '${role_manage-users}', 'manage-users', 'master', 'ba21cbd8-f648-48c5-9198-0d88c41702d8', NULL);
INSERT INTO public.keycloak_role VALUES ('f27a3695-7c5a-4175-b3e8-6bc3713de932', 'ba21cbd8-f648-48c5-9198-0d88c41702d8', true, '${role_manage-clients}', 'manage-clients', 'master', 'ba21cbd8-f648-48c5-9198-0d88c41702d8', NULL);
INSERT INTO public.keycloak_role VALUES ('679b75ff-bd9a-49e3-a65a-b11d91500f20', 'ba21cbd8-f648-48c5-9198-0d88c41702d8', true, '${role_manage-events}', 'manage-events', 'master', 'ba21cbd8-f648-48c5-9198-0d88c41702d8', NULL);
INSERT INTO public.keycloak_role VALUES ('ec686a97-270d-4692-94ee-904b82ffcc01', 'ba21cbd8-f648-48c5-9198-0d88c41702d8', true, '${role_manage-identity-providers}', 'manage-identity-providers', 'master', 'ba21cbd8-f648-48c5-9198-0d88c41702d8', NULL);
INSERT INTO public.keycloak_role VALUES ('f98d4933-912f-4ba3-b7d6-aabd496bca7e', 'ba21cbd8-f648-48c5-9198-0d88c41702d8', true, '${role_manage-authorization}', 'manage-authorization', 'master', 'ba21cbd8-f648-48c5-9198-0d88c41702d8', NULL);
INSERT INTO public.keycloak_role VALUES ('b121efec-785f-48b1-bd9a-6405b14b2c03', 'ba21cbd8-f648-48c5-9198-0d88c41702d8', true, '${role_query-users}', 'query-users', 'master', 'ba21cbd8-f648-48c5-9198-0d88c41702d8', NULL);
INSERT INTO public.keycloak_role VALUES ('2597b09b-51aa-402b-9619-5949ec53308e', 'ba21cbd8-f648-48c5-9198-0d88c41702d8', true, '${role_query-clients}', 'query-clients', 'master', 'ba21cbd8-f648-48c5-9198-0d88c41702d8', NULL);
INSERT INTO public.keycloak_role VALUES ('34514542-e4c6-4baf-8219-403ce58f9b99', 'ba21cbd8-f648-48c5-9198-0d88c41702d8', true, '${role_query-realms}', 'query-realms', 'master', 'ba21cbd8-f648-48c5-9198-0d88c41702d8', NULL);
INSERT INTO public.keycloak_role VALUES ('edd36c58-83f1-4e4e-ab87-d757bc132bbc', 'ba21cbd8-f648-48c5-9198-0d88c41702d8', true, '${role_query-groups}', 'query-groups', 'master', 'ba21cbd8-f648-48c5-9198-0d88c41702d8', NULL);
INSERT INTO public.keycloak_role VALUES ('42d5d593-88ca-434b-baf2-6bdfa2a027f1', '25ebdb3e-1af4-4735-b66d-31e712802a57', true, '${role_view-profile}', 'view-profile', 'master', '25ebdb3e-1af4-4735-b66d-31e712802a57', NULL);
INSERT INTO public.keycloak_role VALUES ('31816775-a12b-47f0-9bab-3ee99f672181', '25ebdb3e-1af4-4735-b66d-31e712802a57', true, '${role_manage-account}', 'manage-account', 'master', '25ebdb3e-1af4-4735-b66d-31e712802a57', NULL);
INSERT INTO public.keycloak_role VALUES ('c8a9cc2e-ff44-488d-85fc-2d047916404e', '25ebdb3e-1af4-4735-b66d-31e712802a57', true, '${role_manage-account-links}', 'manage-account-links', 'master', '25ebdb3e-1af4-4735-b66d-31e712802a57', NULL);
INSERT INTO public.keycloak_role VALUES ('b8381a06-5135-4d4d-a60b-6cd4b88cdcd1', '25ebdb3e-1af4-4735-b66d-31e712802a57', true, '${role_view-applications}', 'view-applications', 'master', '25ebdb3e-1af4-4735-b66d-31e712802a57', NULL);
INSERT INTO public.keycloak_role VALUES ('7c3a8254-8f58-42ab-a779-dc45c37ac238', '25ebdb3e-1af4-4735-b66d-31e712802a57', true, '${role_view-consent}', 'view-consent', 'master', '25ebdb3e-1af4-4735-b66d-31e712802a57', NULL);
INSERT INTO public.keycloak_role VALUES ('c6f1ed16-8268-4e3c-b994-dd5288efbabb', '25ebdb3e-1af4-4735-b66d-31e712802a57', true, '${role_manage-consent}', 'manage-consent', 'master', '25ebdb3e-1af4-4735-b66d-31e712802a57', NULL);
INSERT INTO public.keycloak_role VALUES ('a2e70185-7b65-4af3-a268-6cd53d97fb36', '25ebdb3e-1af4-4735-b66d-31e712802a57', true, '${role_delete-account}', 'delete-account', 'master', '25ebdb3e-1af4-4735-b66d-31e712802a57', NULL);
INSERT INTO public.keycloak_role VALUES ('8263ef04-aed9-4297-afbd-0df54cca17c7', '77159e12-9c83-4fa6-8f9f-fe71afc4685b', true, '${role_read-token}', 'read-token', 'master', '77159e12-9c83-4fa6-8f9f-fe71afc4685b', NULL);
INSERT INTO public.keycloak_role VALUES ('7e03903b-a6e3-48a0-bc4a-7608f9dcb2d2', 'ba21cbd8-f648-48c5-9198-0d88c41702d8', true, '${role_impersonation}', 'impersonation', 'master', 'ba21cbd8-f648-48c5-9198-0d88c41702d8', NULL);
INSERT INTO public.keycloak_role VALUES ('7d9633f4-e669-409e-b409-cd47599f27ce', 'master', false, '${role_offline-access}', 'offline_access', 'master', NULL, NULL);
INSERT INTO public.keycloak_role VALUES ('ab4d98ad-534a-465d-8720-6ed1173d6216', 'master', false, '${role_uma_authorization}', 'uma_authorization', 'master', NULL, NULL);
INSERT INTO public.keycloak_role VALUES ('27d7e20e-5eed-4ce0-9f1e-13a9c8ee9081', 'master', false, 'Working with companies', 'companies', 'master', NULL, NULL);


--
-- TOC entry 4156 (class 0 OID 16917)
-- Dependencies: 250
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO public.migration_model VALUES ('iesh5', '16.1.1', 1666428898);


--
-- TOC entry 4173 (class 0 OID 17189)
-- Dependencies: 267
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4172 (class 0 OID 17184)
-- Dependencies: 266
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4186 (class 0 OID 17406)
-- Dependencies: 280
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4148 (class 0 OID 16791)
-- Dependencies: 242
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO public.protocol_mapper VALUES ('34f6415f-f893-4783-8e60-0415f4af9296', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', '017a89e2-0f9c-4832-82c3-a9098e50b406', NULL);
INSERT INTO public.protocol_mapper VALUES ('6f1934b0-fde4-461e-8240-312f7befa4b4', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', '303a8c8f-25c7-40f5-a497-4a717d177de7', NULL);
INSERT INTO public.protocol_mapper VALUES ('5d2d6163-7545-491a-955c-fd222851690f', 'role list', 'saml', 'saml-role-list-mapper', NULL, 'eccade99-409a-4939-9f70-8c74d704831c');
INSERT INTO public.protocol_mapper VALUES ('680bbb03-0dbd-444e-aff5-da90a56087d1', 'full name', 'openid-connect', 'oidc-full-name-mapper', NULL, '06f497ae-a985-4616-aa1f-05f22a1762fe');
INSERT INTO public.protocol_mapper VALUES ('e223ee5a-2cdd-45e2-af9e-12799dea9976', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '06f497ae-a985-4616-aa1f-05f22a1762fe');
INSERT INTO public.protocol_mapper VALUES ('4b8164f1-219a-432d-9d5b-61286d068658', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '06f497ae-a985-4616-aa1f-05f22a1762fe');
INSERT INTO public.protocol_mapper VALUES ('ee875927-1152-493c-95c9-5e84e5b5f747', 'middle name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '06f497ae-a985-4616-aa1f-05f22a1762fe');
INSERT INTO public.protocol_mapper VALUES ('4b868157-e3e4-4e26-ba88-a4768b7fed01', 'nickname', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '06f497ae-a985-4616-aa1f-05f22a1762fe');
INSERT INTO public.protocol_mapper VALUES ('e3eab996-564d-465c-b7b4-129eae74d902', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '06f497ae-a985-4616-aa1f-05f22a1762fe');
INSERT INTO public.protocol_mapper VALUES ('cb932dcd-45a5-439e-a1f4-27896b2923c7', 'profile', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '06f497ae-a985-4616-aa1f-05f22a1762fe');
INSERT INTO public.protocol_mapper VALUES ('e463e306-bd6b-4463-b681-c14217a7f26b', 'picture', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '06f497ae-a985-4616-aa1f-05f22a1762fe');
INSERT INTO public.protocol_mapper VALUES ('585a16a1-b693-4b4a-9e39-6299d7788372', 'website', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '06f497ae-a985-4616-aa1f-05f22a1762fe');
INSERT INTO public.protocol_mapper VALUES ('0562cb4e-5a5f-4bb6-9231-a1790db1ee46', 'gender', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '06f497ae-a985-4616-aa1f-05f22a1762fe');
INSERT INTO public.protocol_mapper VALUES ('ce2db1e6-4b9b-4b1d-9477-4b305654ab43', 'birthdate', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '06f497ae-a985-4616-aa1f-05f22a1762fe');
INSERT INTO public.protocol_mapper VALUES ('18cf3261-1350-4811-b6f2-752edb424bb5', 'zoneinfo', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '06f497ae-a985-4616-aa1f-05f22a1762fe');
INSERT INTO public.protocol_mapper VALUES ('d6f2ac52-c8b6-43c2-9708-1e381bb4cfd9', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '06f497ae-a985-4616-aa1f-05f22a1762fe');
INSERT INTO public.protocol_mapper VALUES ('163ad145-1aad-4a5d-9be7-51fac27b6110', 'updated at', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '06f497ae-a985-4616-aa1f-05f22a1762fe');
INSERT INTO public.protocol_mapper VALUES ('4ae52f9c-adac-44b3-9a79-f07fa931eeb0', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '32cd8045-27c4-4a8c-b52b-65a54e4e09b2');
INSERT INTO public.protocol_mapper VALUES ('20ee862e-c4e0-4eeb-849b-dc79eaf7726d', 'email verified', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '32cd8045-27c4-4a8c-b52b-65a54e4e09b2');
INSERT INTO public.protocol_mapper VALUES ('4c5b0005-9d4e-4039-842d-5bc8154a10d4', 'address', 'openid-connect', 'oidc-address-mapper', NULL, '0aa5b00c-5f1a-4f57-b945-aafd7289718f');
INSERT INTO public.protocol_mapper VALUES ('5e172d38-36e7-4373-ac21-fd83b079bf30', 'phone number', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'be579c97-0c20-4553-bad3-aacdd3fdb5a7');
INSERT INTO public.protocol_mapper VALUES ('6f8016e5-8c38-4879-b1c3-ee8879349d7c', 'phone number verified', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'be579c97-0c20-4553-bad3-aacdd3fdb5a7');
INSERT INTO public.protocol_mapper VALUES ('585e2dcf-b8b8-4407-8d1e-109dc121b5e6', 'realm roles', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, 'f061ac1e-b240-4971-b4da-4051626671ae');
INSERT INTO public.protocol_mapper VALUES ('be141e3b-52d9-49a0-badd-7ac97423682e', 'client roles', 'openid-connect', 'oidc-usermodel-client-role-mapper', NULL, 'f061ac1e-b240-4971-b4da-4051626671ae');
INSERT INTO public.protocol_mapper VALUES ('83b77aa3-960a-457e-9d87-95ad2ee7dbf7', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', NULL, 'f061ac1e-b240-4971-b4da-4051626671ae');
INSERT INTO public.protocol_mapper VALUES ('f92d37ee-415b-427d-a214-7eb8ab051c04', 'allowed web origins', 'openid-connect', 'oidc-allowed-origins-mapper', NULL, '29055654-85af-4ecb-967c-626d2bf55c8c');
INSERT INTO public.protocol_mapper VALUES ('2319c81f-5a9e-492f-89e7-101dbfd43205', 'upn', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '0b315b1e-8ffc-45da-b6f4-23ad57e52a73');
INSERT INTO public.protocol_mapper VALUES ('9bad8df1-30ea-4876-8424-84d8bd849f36', 'groups', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, '0b315b1e-8ffc-45da-b6f4-23ad57e52a73');


--
-- TOC entry 4149 (class 0 OID 16797)
-- Dependencies: 243
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO public.protocol_mapper_config VALUES ('6f1934b0-fde4-461e-8240-312f7befa4b4', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('6f1934b0-fde4-461e-8240-312f7befa4b4', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('6f1934b0-fde4-461e-8240-312f7befa4b4', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('6f1934b0-fde4-461e-8240-312f7befa4b4', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('6f1934b0-fde4-461e-8240-312f7befa4b4', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('6f1934b0-fde4-461e-8240-312f7befa4b4', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('5d2d6163-7545-491a-955c-fd222851690f', 'false', 'single');
INSERT INTO public.protocol_mapper_config VALUES ('5d2d6163-7545-491a-955c-fd222851690f', 'Basic', 'attribute.nameformat');
INSERT INTO public.protocol_mapper_config VALUES ('5d2d6163-7545-491a-955c-fd222851690f', 'Role', 'attribute.name');
INSERT INTO public.protocol_mapper_config VALUES ('680bbb03-0dbd-444e-aff5-da90a56087d1', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('680bbb03-0dbd-444e-aff5-da90a56087d1', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('680bbb03-0dbd-444e-aff5-da90a56087d1', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('e223ee5a-2cdd-45e2-af9e-12799dea9976', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('e223ee5a-2cdd-45e2-af9e-12799dea9976', 'lastName', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('e223ee5a-2cdd-45e2-af9e-12799dea9976', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('e223ee5a-2cdd-45e2-af9e-12799dea9976', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('e223ee5a-2cdd-45e2-af9e-12799dea9976', 'family_name', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('e223ee5a-2cdd-45e2-af9e-12799dea9976', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('4b8164f1-219a-432d-9d5b-61286d068658', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4b8164f1-219a-432d-9d5b-61286d068658', 'firstName', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('4b8164f1-219a-432d-9d5b-61286d068658', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4b8164f1-219a-432d-9d5b-61286d068658', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4b8164f1-219a-432d-9d5b-61286d068658', 'given_name', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('4b8164f1-219a-432d-9d5b-61286d068658', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('ee875927-1152-493c-95c9-5e84e5b5f747', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('ee875927-1152-493c-95c9-5e84e5b5f747', 'middleName', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('ee875927-1152-493c-95c9-5e84e5b5f747', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('ee875927-1152-493c-95c9-5e84e5b5f747', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('ee875927-1152-493c-95c9-5e84e5b5f747', 'middle_name', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('ee875927-1152-493c-95c9-5e84e5b5f747', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('4b868157-e3e4-4e26-ba88-a4768b7fed01', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4b868157-e3e4-4e26-ba88-a4768b7fed01', 'nickname', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('4b868157-e3e4-4e26-ba88-a4768b7fed01', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4b868157-e3e4-4e26-ba88-a4768b7fed01', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4b868157-e3e4-4e26-ba88-a4768b7fed01', 'nickname', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('4b868157-e3e4-4e26-ba88-a4768b7fed01', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('e3eab996-564d-465c-b7b4-129eae74d902', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('e3eab996-564d-465c-b7b4-129eae74d902', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('e3eab996-564d-465c-b7b4-129eae74d902', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('e3eab996-564d-465c-b7b4-129eae74d902', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('e3eab996-564d-465c-b7b4-129eae74d902', 'preferred_username', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('e3eab996-564d-465c-b7b4-129eae74d902', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('cb932dcd-45a5-439e-a1f4-27896b2923c7', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('cb932dcd-45a5-439e-a1f4-27896b2923c7', 'profile', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('cb932dcd-45a5-439e-a1f4-27896b2923c7', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('cb932dcd-45a5-439e-a1f4-27896b2923c7', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('cb932dcd-45a5-439e-a1f4-27896b2923c7', 'profile', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('cb932dcd-45a5-439e-a1f4-27896b2923c7', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('e463e306-bd6b-4463-b681-c14217a7f26b', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('e463e306-bd6b-4463-b681-c14217a7f26b', 'picture', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('e463e306-bd6b-4463-b681-c14217a7f26b', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('e463e306-bd6b-4463-b681-c14217a7f26b', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('e463e306-bd6b-4463-b681-c14217a7f26b', 'picture', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('e463e306-bd6b-4463-b681-c14217a7f26b', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('585a16a1-b693-4b4a-9e39-6299d7788372', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('585a16a1-b693-4b4a-9e39-6299d7788372', 'website', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('585a16a1-b693-4b4a-9e39-6299d7788372', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('585a16a1-b693-4b4a-9e39-6299d7788372', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('585a16a1-b693-4b4a-9e39-6299d7788372', 'website', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('585a16a1-b693-4b4a-9e39-6299d7788372', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('0562cb4e-5a5f-4bb6-9231-a1790db1ee46', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0562cb4e-5a5f-4bb6-9231-a1790db1ee46', 'gender', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('0562cb4e-5a5f-4bb6-9231-a1790db1ee46', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0562cb4e-5a5f-4bb6-9231-a1790db1ee46', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0562cb4e-5a5f-4bb6-9231-a1790db1ee46', 'gender', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('0562cb4e-5a5f-4bb6-9231-a1790db1ee46', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('ce2db1e6-4b9b-4b1d-9477-4b305654ab43', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('ce2db1e6-4b9b-4b1d-9477-4b305654ab43', 'birthdate', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('ce2db1e6-4b9b-4b1d-9477-4b305654ab43', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('ce2db1e6-4b9b-4b1d-9477-4b305654ab43', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('ce2db1e6-4b9b-4b1d-9477-4b305654ab43', 'birthdate', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('ce2db1e6-4b9b-4b1d-9477-4b305654ab43', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('18cf3261-1350-4811-b6f2-752edb424bb5', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('18cf3261-1350-4811-b6f2-752edb424bb5', 'zoneinfo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('18cf3261-1350-4811-b6f2-752edb424bb5', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('18cf3261-1350-4811-b6f2-752edb424bb5', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('18cf3261-1350-4811-b6f2-752edb424bb5', 'zoneinfo', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('18cf3261-1350-4811-b6f2-752edb424bb5', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('d6f2ac52-c8b6-43c2-9708-1e381bb4cfd9', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d6f2ac52-c8b6-43c2-9708-1e381bb4cfd9', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('d6f2ac52-c8b6-43c2-9708-1e381bb4cfd9', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d6f2ac52-c8b6-43c2-9708-1e381bb4cfd9', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d6f2ac52-c8b6-43c2-9708-1e381bb4cfd9', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('d6f2ac52-c8b6-43c2-9708-1e381bb4cfd9', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('163ad145-1aad-4a5d-9be7-51fac27b6110', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('163ad145-1aad-4a5d-9be7-51fac27b6110', 'updatedAt', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('163ad145-1aad-4a5d-9be7-51fac27b6110', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('163ad145-1aad-4a5d-9be7-51fac27b6110', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('163ad145-1aad-4a5d-9be7-51fac27b6110', 'updated_at', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('163ad145-1aad-4a5d-9be7-51fac27b6110', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('4ae52f9c-adac-44b3-9a79-f07fa931eeb0', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4ae52f9c-adac-44b3-9a79-f07fa931eeb0', 'email', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('4ae52f9c-adac-44b3-9a79-f07fa931eeb0', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4ae52f9c-adac-44b3-9a79-f07fa931eeb0', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4ae52f9c-adac-44b3-9a79-f07fa931eeb0', 'email', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('4ae52f9c-adac-44b3-9a79-f07fa931eeb0', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('20ee862e-c4e0-4eeb-849b-dc79eaf7726d', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('20ee862e-c4e0-4eeb-849b-dc79eaf7726d', 'emailVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('20ee862e-c4e0-4eeb-849b-dc79eaf7726d', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('20ee862e-c4e0-4eeb-849b-dc79eaf7726d', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('20ee862e-c4e0-4eeb-849b-dc79eaf7726d', 'email_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('20ee862e-c4e0-4eeb-849b-dc79eaf7726d', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('4c5b0005-9d4e-4039-842d-5bc8154a10d4', 'formatted', 'user.attribute.formatted');
INSERT INTO public.protocol_mapper_config VALUES ('4c5b0005-9d4e-4039-842d-5bc8154a10d4', 'country', 'user.attribute.country');
INSERT INTO public.protocol_mapper_config VALUES ('4c5b0005-9d4e-4039-842d-5bc8154a10d4', 'postal_code', 'user.attribute.postal_code');
INSERT INTO public.protocol_mapper_config VALUES ('4c5b0005-9d4e-4039-842d-5bc8154a10d4', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4c5b0005-9d4e-4039-842d-5bc8154a10d4', 'street', 'user.attribute.street');
INSERT INTO public.protocol_mapper_config VALUES ('4c5b0005-9d4e-4039-842d-5bc8154a10d4', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4c5b0005-9d4e-4039-842d-5bc8154a10d4', 'region', 'user.attribute.region');
INSERT INTO public.protocol_mapper_config VALUES ('4c5b0005-9d4e-4039-842d-5bc8154a10d4', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4c5b0005-9d4e-4039-842d-5bc8154a10d4', 'locality', 'user.attribute.locality');
INSERT INTO public.protocol_mapper_config VALUES ('5e172d38-36e7-4373-ac21-fd83b079bf30', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('5e172d38-36e7-4373-ac21-fd83b079bf30', 'phoneNumber', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('5e172d38-36e7-4373-ac21-fd83b079bf30', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('5e172d38-36e7-4373-ac21-fd83b079bf30', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('5e172d38-36e7-4373-ac21-fd83b079bf30', 'phone_number', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('5e172d38-36e7-4373-ac21-fd83b079bf30', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('6f8016e5-8c38-4879-b1c3-ee8879349d7c', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('6f8016e5-8c38-4879-b1c3-ee8879349d7c', 'phoneNumberVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('6f8016e5-8c38-4879-b1c3-ee8879349d7c', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('6f8016e5-8c38-4879-b1c3-ee8879349d7c', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('6f8016e5-8c38-4879-b1c3-ee8879349d7c', 'phone_number_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('6f8016e5-8c38-4879-b1c3-ee8879349d7c', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('585e2dcf-b8b8-4407-8d1e-109dc121b5e6', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config VALUES ('585e2dcf-b8b8-4407-8d1e-109dc121b5e6', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('585e2dcf-b8b8-4407-8d1e-109dc121b5e6', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('585e2dcf-b8b8-4407-8d1e-109dc121b5e6', 'realm_access.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('585e2dcf-b8b8-4407-8d1e-109dc121b5e6', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('be141e3b-52d9-49a0-badd-7ac97423682e', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config VALUES ('be141e3b-52d9-49a0-badd-7ac97423682e', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('be141e3b-52d9-49a0-badd-7ac97423682e', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('be141e3b-52d9-49a0-badd-7ac97423682e', 'resource_access.${client_id}.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('be141e3b-52d9-49a0-badd-7ac97423682e', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('2319c81f-5a9e-492f-89e7-101dbfd43205', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('2319c81f-5a9e-492f-89e7-101dbfd43205', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('2319c81f-5a9e-492f-89e7-101dbfd43205', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('2319c81f-5a9e-492f-89e7-101dbfd43205', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('2319c81f-5a9e-492f-89e7-101dbfd43205', 'upn', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('2319c81f-5a9e-492f-89e7-101dbfd43205', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('9bad8df1-30ea-4876-8424-84d8bd849f36', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config VALUES ('9bad8df1-30ea-4876-8424-84d8bd849f36', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('9bad8df1-30ea-4876-8424-84d8bd849f36', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('9bad8df1-30ea-4876-8424-84d8bd849f36', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('9bad8df1-30ea-4876-8424-84d8bd849f36', 'groups', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('9bad8df1-30ea-4876-8424-84d8bd849f36', 'String', 'jsonType.label');


--
-- TOC entry 4129 (class 0 OID 16439)
-- Dependencies: 223
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO public.realm VALUES ('master', 60, 300, 60, NULL, NULL, NULL, true, false, 0, NULL, 'master', 0, NULL, false, false, false, false, 'EXTERNAL', 1800, 36000, false, false, 'ba21cbd8-f648-48c5-9198-0d88c41702d8', 1800, false, NULL, false, false, false, false, 0, 1, 30, 6, 'HmacSHA1', 'totp', 'ec1879bf-9ae9-44af-9e07-7e2a64089d2b', '120bf679-6383-4aa0-961a-fb408c7913d0', 'e7ed509b-30e0-428c-81b1-56e8f5ac9524', '721d3fba-7a28-47bf-b9df-502cb641306e', '258df578-bb49-45f5-8483-da22f4a5f542', 2592000, false, 900, true, false, '1c4e2971-1344-4f47-b76a-a6b1e2b2e042', 0, false, 0, 0, 'f275dcfc-4a2f-4309-bf00-dcd1d5c12080');


--
-- TOC entry 4130 (class 0 OID 16456)
-- Dependencies: 224
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO public.realm_attribute VALUES ('_browser_header.contentSecurityPolicyReportOnly', 'master', '');
INSERT INTO public.realm_attribute VALUES ('_browser_header.xContentTypeOptions', 'master', 'nosniff');
INSERT INTO public.realm_attribute VALUES ('_browser_header.xRobotsTag', 'master', 'none');
INSERT INTO public.realm_attribute VALUES ('_browser_header.xFrameOptions', 'master', 'SAMEORIGIN');
INSERT INTO public.realm_attribute VALUES ('_browser_header.contentSecurityPolicy', 'master', 'frame-src ''self''; frame-ancestors ''self''; object-src ''none'';');
INSERT INTO public.realm_attribute VALUES ('_browser_header.xXSSProtection', 'master', '1; mode=block');
INSERT INTO public.realm_attribute VALUES ('_browser_header.strictTransportSecurity', 'master', 'max-age=31536000; includeSubDomains');
INSERT INTO public.realm_attribute VALUES ('bruteForceProtected', 'master', 'false');
INSERT INTO public.realm_attribute VALUES ('permanentLockout', 'master', 'false');
INSERT INTO public.realm_attribute VALUES ('maxFailureWaitSeconds', 'master', '900');
INSERT INTO public.realm_attribute VALUES ('minimumQuickLoginWaitSeconds', 'master', '60');
INSERT INTO public.realm_attribute VALUES ('waitIncrementSeconds', 'master', '60');
INSERT INTO public.realm_attribute VALUES ('quickLoginCheckMilliSeconds', 'master', '1000');
INSERT INTO public.realm_attribute VALUES ('maxDeltaTimeSeconds', 'master', '43200');
INSERT INTO public.realm_attribute VALUES ('failureFactor', 'master', '30');
INSERT INTO public.realm_attribute VALUES ('displayName', 'master', 'Keycloak');
INSERT INTO public.realm_attribute VALUES ('displayNameHtml', 'master', '<div class="kc-logo-text"><span>Keycloak</span></div>');
INSERT INTO public.realm_attribute VALUES ('defaultSignatureAlgorithm', 'master', 'RS256');
INSERT INTO public.realm_attribute VALUES ('offlineSessionMaxLifespanEnabled', 'master', 'false');
INSERT INTO public.realm_attribute VALUES ('offlineSessionMaxLifespan', 'master', '5184000');


--
-- TOC entry 4178 (class 0 OID 17213)
-- Dependencies: 272
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4155 (class 0 OID 16909)
-- Dependencies: 249
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4131 (class 0 OID 16464)
-- Dependencies: 225
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO public.realm_events_listeners VALUES ('master', 'jboss-logging');


--
-- TOC entry 4211 (class 0 OID 17920)
-- Dependencies: 305
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4132 (class 0 OID 16467)
-- Dependencies: 226
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO public.realm_required_credential VALUES ('password', 'password', true, true, 'master');


--
-- TOC entry 4133 (class 0 OID 16474)
-- Dependencies: 227
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4153 (class 0 OID 16825)
-- Dependencies: 247
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4134 (class 0 OID 16484)
-- Dependencies: 228
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO public.redirect_uris VALUES ('25ebdb3e-1af4-4735-b66d-31e712802a57', '/realms/master/account/*');
INSERT INTO public.redirect_uris VALUES ('017a89e2-0f9c-4832-82c3-a9098e50b406', '/realms/master/account/*');
INSERT INTO public.redirect_uris VALUES ('303a8c8f-25c7-40f5-a497-4a717d177de7', '/admin/master/console/*');
INSERT INTO public.redirect_uris VALUES ('fc96fad3-3add-40bd-b993-d649579b03b0', 'http://localhost:8400/');


--
-- TOC entry 4171 (class 0 OID 17148)
-- Dependencies: 265
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4170 (class 0 OID 17141)
-- Dependencies: 264
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO public.required_action_provider VALUES ('87192586-cb95-46e9-9f3c-6dcffb503b09', 'VERIFY_EMAIL', 'Verify Email', 'master', true, false, 'VERIFY_EMAIL', 50);
INSERT INTO public.required_action_provider VALUES ('a6944a13-d24e-4cea-8a6f-9d4ddc05418d', 'UPDATE_PROFILE', 'Update Profile', 'master', true, false, 'UPDATE_PROFILE', 40);
INSERT INTO public.required_action_provider VALUES ('a1c8a127-d0a5-4085-bf7a-729805fe1f21', 'CONFIGURE_TOTP', 'Configure OTP', 'master', true, false, 'CONFIGURE_TOTP', 10);
INSERT INTO public.required_action_provider VALUES ('d8ede2c3-791a-4a6b-b4df-c01b1747dd6e', 'UPDATE_PASSWORD', 'Update Password', 'master', true, false, 'UPDATE_PASSWORD', 30);
INSERT INTO public.required_action_provider VALUES ('c8fc3f07-88d0-407d-a3f1-2e1ed521bb7b', 'terms_and_conditions', 'Terms and Conditions', 'master', false, false, 'terms_and_conditions', 20);
INSERT INTO public.required_action_provider VALUES ('8aae3e3d-44c4-4dd2-b401-a821540476dc', 'update_user_locale', 'Update User Locale', 'master', true, false, 'update_user_locale', 1000);
INSERT INTO public.required_action_provider VALUES ('280bd69d-bcc1-4579-83cc-fd43442eef5c', 'delete_account', 'Delete Account', 'master', false, false, 'delete_account', 60);


--
-- TOC entry 4208 (class 0 OID 17849)
-- Dependencies: 302
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4188 (class 0 OID 17433)
-- Dependencies: 282
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4187 (class 0 OID 17418)
-- Dependencies: 281
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4182 (class 0 OID 17356)
-- Dependencies: 276
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4207 (class 0 OID 17825)
-- Dependencies: 301
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4185 (class 0 OID 17392)
-- Dependencies: 279
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4183 (class 0 OID 17364)
-- Dependencies: 277
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4184 (class 0 OID 17378)
-- Dependencies: 278
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4209 (class 0 OID 17867)
-- Dependencies: 303
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4210 (class 0 OID 17877)
-- Dependencies: 304
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4135 (class 0 OID 16487)
-- Dependencies: 229
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO public.scope_mapping VALUES ('017a89e2-0f9c-4832-82c3-a9098e50b406', '31816775-a12b-47f0-9bab-3ee99f672181');


--
-- TOC entry 4189 (class 0 OID 17448)
-- Dependencies: 283
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4137 (class 0 OID 16493)
-- Dependencies: 231
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4159 (class 0 OID 16930)
-- Dependencies: 253
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4205 (class 0 OID 17800)
-- Dependencies: 299
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4138 (class 0 OID 16498)
-- Dependencies: 232
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO public.user_entity VALUES ('f59b57a0-0485-4722-919e-59957370b890', NULL, 'b750a921-6333-4491-96eb-52c846aaa505', false, true, NULL, NULL, NULL, 'master', 'admin', 1666428901707, NULL, 0);
INSERT INTO public.user_entity VALUES ('9c8fe163-ded4-4f73-abf8-6db39a6f36c6', NULL, '128693d9-e92a-49dc-b9d5-cb084e28e8f4', false, true, NULL, NULL, NULL, 'master', 'user', 1666429329196, NULL, 0);
INSERT INTO public.user_entity VALUES ('72da7f8a-9478-46c3-8b00-3357aaece36a', NULL, 'bbc63f21-025b-45df-92ec-ebf3ed8da0b7', false, true, NULL, NULL, NULL, 'master', 'manager', 1666429354181, NULL, 0);


--
-- TOC entry 4139 (class 0 OID 16506)
-- Dependencies: 233
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4166 (class 0 OID 17042)
-- Dependencies: 260
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4167 (class 0 OID 17047)
-- Dependencies: 261
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4140 (class 0 OID 16511)
-- Dependencies: 234
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4177 (class 0 OID 17210)
-- Dependencies: 271
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4141 (class 0 OID 16516)
-- Dependencies: 235
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4142 (class 0 OID 16519)
-- Dependencies: 236
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO public.user_role_mapping VALUES ('f275dcfc-4a2f-4309-bf00-dcd1d5c12080', 'f59b57a0-0485-4722-919e-59957370b890');
INSERT INTO public.user_role_mapping VALUES ('4f44b5ce-a4a6-42c7-ba49-5609636f7774', 'f59b57a0-0485-4722-919e-59957370b890');
INSERT INTO public.user_role_mapping VALUES ('f275dcfc-4a2f-4309-bf00-dcd1d5c12080', '9c8fe163-ded4-4f73-abf8-6db39a6f36c6');
INSERT INTO public.user_role_mapping VALUES ('f275dcfc-4a2f-4309-bf00-dcd1d5c12080', '72da7f8a-9478-46c3-8b00-3357aaece36a');
INSERT INTO public.user_role_mapping VALUES ('27d7e20e-5eed-4ce0-9f1e-13a9c8ee9081', '72da7f8a-9478-46c3-8b00-3357aaece36a');


--
-- TOC entry 4143 (class 0 OID 16522)
-- Dependencies: 237
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4154 (class 0 OID 16828)
-- Dependencies: 248
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4136 (class 0 OID 16490)
-- Dependencies: 230
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- TOC entry 4144 (class 0 OID 16533)
-- Dependencies: 238
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO public.web_origins VALUES ('303a8c8f-25c7-40f5-a497-4a717d177de7', '+');


--
-- TOC entry 3663 (class 2606 OID 17592)
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- TOC entry 3636 (class 2606 OID 17903)
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- TOC entry 3877 (class 2606 OID 17731)
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- TOC entry 3879 (class 2606 OID 17932)
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- TOC entry 3874 (class 2606 OID 17606)
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- TOC entry 3791 (class 2606 OID 17252)
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- TOC entry 3839 (class 2606 OID 17529)
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- TOC entry 3761 (class 2606 OID 17160)
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- TOC entry 3865 (class 2606 OID 17549)
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- TOC entry 3868 (class 2606 OID 17547)
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- TOC entry 3857 (class 2606 OID 17545)
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- TOC entry 3841 (class 2606 OID 17531)
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- TOC entry 3844 (class 2606 OID 17533)
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- TOC entry 3849 (class 2606 OID 17539)
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- TOC entry 3853 (class 2606 OID 17541)
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- TOC entry 3861 (class 2606 OID 17543)
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- TOC entry 3872 (class 2606 OID 17586)
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- TOC entry 3793 (class 2606 OID 17690)
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- TOC entry 3721 (class 2606 OID 17707)
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- TOC entry 3650 (class 2606 OID 17709)
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- TOC entry 3716 (class 2606 OID 17711)
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- TOC entry 3709 (class 2606 OID 16837)
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- TOC entry 3692 (class 2606 OID 16771)
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- TOC entry 3633 (class 2606 OID 16545)
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- TOC entry 3705 (class 2606 OID 16839)
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- TOC entry 3642 (class 2606 OID 16547)
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- TOC entry 3624 (class 2606 OID 16549)
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- TOC entry 3687 (class 2606 OID 16551)
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- TOC entry 3678 (class 2606 OID 16553)
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- TOC entry 3695 (class 2606 OID 16773)
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- TOC entry 3616 (class 2606 OID 16557)
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- TOC entry 3621 (class 2606 OID 16559)
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- TOC entry 3660 (class 2606 OID 16561)
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- TOC entry 3697 (class 2606 OID 16775)
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- TOC entry 3647 (class 2606 OID 16563)
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- TOC entry 3653 (class 2606 OID 16565)
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- TOC entry 3638 (class 2606 OID 16567)
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- TOC entry 3739 (class 2606 OID 17694)
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- TOC entry 3751 (class 2606 OID 17068)
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- TOC entry 3747 (class 2606 OID 17066)
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- TOC entry 3744 (class 2606 OID 17064)
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- TOC entry 3741 (class 2606 OID 17062)
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- TOC entry 3759 (class 2606 OID 17072)
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- TOC entry 3684 (class 2606 OID 16569)
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- TOC entry 3626 (class 2606 OID 17688)
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- TOC entry 3737 (class 2606 OID 16955)
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- TOC entry 3714 (class 2606 OID 16841)
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- TOC entry 3825 (class 2606 OID 17412)
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- TOC entry 3655 (class 2606 OID 16571)
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- TOC entry 3630 (class 2606 OID 16573)
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- TOC entry 3676 (class 2606 OID 16575)
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- TOC entry 3892 (class 2606 OID 17829)
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- TOC entry 3810 (class 2606 OID 17370)
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- TOC entry 3820 (class 2606 OID 17398)
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- TOC entry 3836 (class 2606 OID 17467)
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- TOC entry 3830 (class 2606 OID 17437)
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- TOC entry 3815 (class 2606 OID 17384)
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- TOC entry 3827 (class 2606 OID 17422)
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- TOC entry 3833 (class 2606 OID 17452)
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- TOC entry 3669 (class 2606 OID 16577)
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- TOC entry 3757 (class 2606 OID 17076)
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- TOC entry 3753 (class 2606 OID 17074)
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- TOC entry 3890 (class 2606 OID 17814)
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- TOC entry 3887 (class 2606 OID 17804)
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- TOC entry 3732 (class 2606 OID 16949)
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- TOC entry 3778 (class 2606 OID 17219)
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- TOC entry 3785 (class 2606 OID 17226)
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3782 (class 2606 OID 17240)
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- TOC entry 3727 (class 2606 OID 16945)
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- TOC entry 3730 (class 2606 OID 17125)
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- TOC entry 3724 (class 2606 OID 16943)
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- TOC entry 3774 (class 2606 OID 17909)
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- TOC entry 3768 (class 2606 OID 17195)
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- TOC entry 3699 (class 2606 OID 16835)
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- TOC entry 3703 (class 2606 OID 17118)
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- TOC entry 3657 (class 2606 OID 17713)
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- TOC entry 3766 (class 2606 OID 17158)
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- TOC entry 3763 (class 2606 OID 17156)
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- TOC entry 3681 (class 2606 OID 17070)
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- TOC entry 3898 (class 2606 OID 17876)
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- TOC entry 3900 (class 2606 OID 17883)
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3665 (class 2606 OID 17154)
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3788 (class 2606 OID 17233)
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- TOC entry 3719 (class 2606 OID 16845)
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- TOC entry 3689 (class 2606 OID 17715)
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- TOC entry 3802 (class 2606 OID 17336)
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- TOC entry 3797 (class 2606 OID 17295)
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- TOC entry 3614 (class 2606 OID 16389)
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- TOC entry 3808 (class 2606 OID 17668)
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- TOC entry 3806 (class 2606 OID 17324)
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- TOC entry 3885 (class 2606 OID 17789)
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- TOC entry 3903 (class 2606 OID 17926)
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- TOC entry 3896 (class 2606 OID 17856)
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- TOC entry 3780 (class 2606 OID 17598)
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- TOC entry 3712 (class 2606 OID 16892)
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- TOC entry 3619 (class 2606 OID 16581)
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- TOC entry 3799 (class 2606 OID 17742)
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- TOC entry 3672 (class 2606 OID 16585)
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- TOC entry 3813 (class 2606 OID 17917)
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- TOC entry 3894 (class 2606 OID 17913)
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- TOC entry 3823 (class 2606 OID 17659)
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- TOC entry 3818 (class 2606 OID 17663)
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- TOC entry 3735 (class 2606 OID 17905)
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- TOC entry 3645 (class 2606 OID 16593)
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- TOC entry 3674 (class 2606 OID 17588)
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- TOC entry 3837 (class 1259 OID 17612)
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- TOC entry 3742 (class 1259 OID 17616)
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- TOC entry 3748 (class 1259 OID 17614)
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- TOC entry 3749 (class 1259 OID 17613)
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- TOC entry 3745 (class 1259 OID 17615)
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- TOC entry 3880 (class 1259 OID 17933)
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- TOC entry 3693 (class 1259 OID 17939)
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, ((value)::character varying(250)));


--
-- TOC entry 3617 (class 1259 OID 17918)
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- TOC entry 3875 (class 1259 OID 17656)
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- TOC entry 3622 (class 1259 OID 17620)
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- TOC entry 3800 (class 1259 OID 17819)
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- TOC entry 3881 (class 1259 OID 17930)
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- TOC entry 3700 (class 1259 OID 17816)
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- TOC entry 3803 (class 1259 OID 17817)
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- TOC entry 3866 (class 1259 OID 17622)
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- TOC entry 3869 (class 1259 OID 17890)
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- TOC entry 3870 (class 1259 OID 17621)
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- TOC entry 3627 (class 1259 OID 17623)
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- TOC entry 3628 (class 1259 OID 17624)
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- TOC entry 3882 (class 1259 OID 17822)
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- TOC entry 3883 (class 1259 OID 17823)
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- TOC entry 3634 (class 1259 OID 17919)
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- TOC entry 3706 (class 1259 OID 17355)
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- TOC entry 3707 (class 1259 OID 17354)
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- TOC entry 3842 (class 1259 OID 17716)
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- TOC entry 3845 (class 1259 OID 17736)
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- TOC entry 3846 (class 1259 OID 17901)
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- TOC entry 3847 (class 1259 OID 17718)
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- TOC entry 3850 (class 1259 OID 17719)
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- TOC entry 3851 (class 1259 OID 17720)
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- TOC entry 3854 (class 1259 OID 17721)
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- TOC entry 3855 (class 1259 OID 17722)
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- TOC entry 3858 (class 1259 OID 17723)
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- TOC entry 3859 (class 1259 OID 17724)
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- TOC entry 3862 (class 1259 OID 17725)
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- TOC entry 3863 (class 1259 OID 17726)
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- TOC entry 3786 (class 1259 OID 17627)
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- TOC entry 3783 (class 1259 OID 17628)
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- TOC entry 3728 (class 1259 OID 17630)
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- TOC entry 3710 (class 1259 OID 17629)
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- TOC entry 3639 (class 1259 OID 17631)
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- TOC entry 3640 (class 1259 OID 17632)
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- TOC entry 3775 (class 1259 OID 17936)
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- TOC entry 3769 (class 1259 OID 17937)
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- TOC entry 3770 (class 1259 OID 17938)
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- TOC entry 3771 (class 1259 OID 17894)
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- TOC entry 3772 (class 1259 OID 17927)
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- TOC entry 3701 (class 1259 OID 17633)
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- TOC entry 3648 (class 1259 OID 17636)
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- TOC entry 3795 (class 1259 OID 17815)
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- TOC entry 3794 (class 1259 OID 17637)
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- TOC entry 3651 (class 1259 OID 17640)
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- TOC entry 3722 (class 1259 OID 17639)
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- TOC entry 3643 (class 1259 OID 17635)
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- TOC entry 3717 (class 1259 OID 17641)
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- TOC entry 3658 (class 1259 OID 17642)
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- TOC entry 3764 (class 1259 OID 17643)
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- TOC entry 3831 (class 1259 OID 17644)
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- TOC entry 3828 (class 1259 OID 17645)
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- TOC entry 3821 (class 1259 OID 17664)
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- TOC entry 3811 (class 1259 OID 17665)
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- TOC entry 3816 (class 1259 OID 17666)
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- TOC entry 3901 (class 1259 OID 17889)
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- TOC entry 3804 (class 1259 OID 17818)
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- TOC entry 3661 (class 1259 OID 17649)
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- TOC entry 3834 (class 1259 OID 17650)
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- TOC entry 3725 (class 1259 OID 17899)
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- TOC entry 3776 (class 1259 OID 17343)
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- TOC entry 3888 (class 1259 OID 17824)
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- TOC entry 3666 (class 1259 OID 17351)
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- TOC entry 3667 (class 1259 OID 17940)
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- TOC entry 3733 (class 1259 OID 17348)
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- TOC entry 3631 (class 1259 OID 17352)
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- TOC entry 3670 (class 1259 OID 17345)
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- TOC entry 3789 (class 1259 OID 17347)
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- TOC entry 3682 (class 1259 OID 17353)
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- TOC entry 3685 (class 1259 OID 17346)
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- TOC entry 3754 (class 1259 OID 17652)
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- TOC entry 3755 (class 1259 OID 17653)
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- TOC entry 3679 (class 1259 OID 17654)
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- TOC entry 3690 (class 1259 OID 17655)
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- TOC entry 3945 (class 2606 OID 17077)
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3929 (class 2606 OID 16846)
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3922 (class 2606 OID 16776)
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3928 (class 2606 OID 16856)
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3924 (class 2606 OID 17003)
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3923 (class 2606 OID 16781)
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3932 (class 2606 OID 16886)
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- TOC entry 3905 (class 2606 OID 16596)
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3914 (class 2606 OID 16601)
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3918 (class 2606 OID 16606)
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3937 (class 2606 OID 16981)
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3912 (class 2606 OID 16616)
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3975 (class 2606 OID 17857)
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3916 (class 2606 OID 16621)
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3919 (class 2606 OID 16631)
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3909 (class 2606 OID 16636)
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- TOC entry 3913 (class 2606 OID 16641)
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3910 (class 2606 OID 16656)
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3906 (class 2606 OID 16661)
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3940 (class 2606 OID 17097)
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- TOC entry 3941 (class 2606 OID 17092)
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3939 (class 2606 OID 17087)
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3938 (class 2606 OID 17082)
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3904 (class 2606 OID 16666)
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- TOC entry 3920 (class 2606 OID 16671)
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3952 (class 2606 OID 17763)
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3953 (class 2606 OID 17753)
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3946 (class 2606 OID 17166)
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3925 (class 2606 OID 17748)
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3968 (class 2606 OID 17607)
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3966 (class 2606 OID 17555)
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- TOC entry 3967 (class 2606 OID 17550)
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3951 (class 2606 OID 17253)
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3944 (class 2606 OID 17112)
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- TOC entry 3942 (class 2606 OID 17107)
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- TOC entry 3943 (class 2606 OID 17102)
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3964 (class 2606 OID 17473)
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3962 (class 2606 OID 17458)
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3971 (class 2606 OID 17830)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3954 (class 2606 OID 17674)
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3972 (class 2606 OID 17835)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3973 (class 2606 OID 17840)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 3965 (class 2606 OID 17468)
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3963 (class 2606 OID 17453)
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 3974 (class 2606 OID 17862)
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3956 (class 2606 OID 17669)
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3958 (class 2606 OID 17423)
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3960 (class 2606 OID 17438)
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3961 (class 2606 OID 17443)
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3959 (class 2606 OID 17428)
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 3955 (class 2606 OID 17679)
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3907 (class 2606 OID 16686)
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3970 (class 2606 OID 17805)
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- TOC entry 3936 (class 2606 OID 16966)
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3949 (class 2606 OID 17227)
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- TOC entry 3948 (class 2606 OID 17241)
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- TOC entry 3933 (class 2606 OID 16912)
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3911 (class 2606 OID 16696)
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3934 (class 2606 OID 16956)
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3935 (class 2606 OID 17126)
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- TOC entry 3921 (class 2606 OID 16706)
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3915 (class 2606 OID 16716)
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3926 (class 2606 OID 16851)
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3908 (class 2606 OID 16731)
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3927 (class 2606 OID 17119)
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- TOC entry 3969 (class 2606 OID 17790)
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3947 (class 2606 OID 17161)
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3976 (class 2606 OID 17870)
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3977 (class 2606 OID 17884)
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3931 (class 2606 OID 16881)
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3917 (class 2606 OID 16751)
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- TOC entry 3950 (class 2606 OID 17234)
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3957 (class 2606 OID 17413)
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3930 (class 2606 OID 16861)
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


-- Completed on 2022-10-22 20:27:56

--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.0 (Debian 15.0-1.pgdg110+1)
-- Dumped by pg_dump version 15.0

-- Started on 2022-10-22 20:26:21

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

-- DROP DATABASE companies;
--
-- TOC entry 3343 (class 1262 OID 17948)
-- Name: companies; Type: DATABASE; Schema: -; Owner: keycloak
--

CREATE DATABASE companies WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE companies OWNER TO keycloak;

\connect companies

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
-- TOC entry 5 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 3344 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 848 (class 1247 OID 18108)
-- Name: company_type; Type: TYPE; Schema: public; Owner: keycloak
--

CREATE TYPE public.company_type AS ENUM (
    'Corporations',
    'NonProfit',
    'Cooperative',
    'Sole Proprietorship'
);


ALTER TYPE public.company_type OWNER TO keycloak;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 18117)
-- Name: companies; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.companies (
    id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    name character varying(15) NOT NULL,
    description character varying(3000),
    amount integer NOT NULL,
    registered boolean NOT NULL,
    type public.company_type NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp without time zone
);


ALTER TABLE public.companies OWNER TO keycloak;

--
-- TOC entry 3345 (class 0 OID 0)
-- Dependencies: 215
-- Name: TABLE companies; Type: COMMENT; Schema: public; Owner: keycloak
--

COMMENT ON TABLE public.companies IS 'Table of companies';


--
-- TOC entry 3346 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN companies.id; Type: COMMENT; Schema: public; Owner: keycloak
--

COMMENT ON COLUMN public.companies.id IS 'Unique identifier of company';


--
-- TOC entry 3347 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN companies.name; Type: COMMENT; Schema: public; Owner: keycloak
--

COMMENT ON COLUMN public.companies.name IS 'Company name';


--
-- TOC entry 3348 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN companies.description; Type: COMMENT; Schema: public; Owner: keycloak
--

COMMENT ON COLUMN public.companies.description IS 'Company description';


--
-- TOC entry 3349 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN companies.amount; Type: COMMENT; Schema: public; Owner: keycloak
--

COMMENT ON COLUMN public.companies.amount IS 'Amount of Employees';


--
-- TOC entry 3350 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN companies.registered; Type: COMMENT; Schema: public; Owner: keycloak
--

COMMENT ON COLUMN public.companies.registered IS 'Registered';


--
-- TOC entry 3351 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN companies.type; Type: COMMENT; Schema: public; Owner: keycloak
--

COMMENT ON COLUMN public.companies.type IS 'Type of Company';


--
-- TOC entry 3352 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN companies.created_at; Type: COMMENT; Schema: public; Owner: keycloak
--

COMMENT ON COLUMN public.companies.created_at IS 'Creation date and time';


--
-- TOC entry 3353 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN companies.updated_at; Type: COMMENT; Schema: public; Owner: keycloak
--

COMMENT ON COLUMN public.companies.updated_at IS 'Updating date and time';


--
-- TOC entry 3337 (class 0 OID 18117)
-- Dependencies: 215
-- Data for Name: companies; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO public.companies VALUES ('e1da4d2a-520d-11ed-977a-0242ac130002', 'Company 1', 'The First Company', 10, false, 'NonProfit', '2022-10-22 13:31:49.550064', NULL);
INSERT INTO public.companies VALUES ('4371e5b8-5216-11ed-8b90-0242ac130002', 'Company 2', 'The Second Company', 4000, true, 'Corporations', '2022-10-22 17:31:49.253835', '2022-10-22 16:42:23.857472');


--
-- TOC entry 3192 (class 2606 OID 18127)
-- Name: companies companies_name_uniq; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_name_uniq UNIQUE (name);


--
-- TOC entry 3194 (class 2606 OID 18125)
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


-- Completed on 2022-10-22 20:26:21

--
-- PostgreSQL database dump complete
--

