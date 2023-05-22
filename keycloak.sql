--
-- PostgreSQL database dump
--

-- Dumped from database version 12.13 (Debian 12.13-1.pgdg110+1)
-- Dumped by pg_dump version 12.13 (Debian 12.13-1.pgdg110+1)

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
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.admin_event_entity OWNER TO postgres;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO postgres;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.authentication_execution OWNER TO postgres;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.authentication_flow OWNER TO postgres;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO postgres;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO postgres;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.broker_link OWNER TO postgres;

--
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.client OWNER TO postgres;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO postgres;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO postgres;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO postgres;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO postgres;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO postgres;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO postgres;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO postgres;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO postgres;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.client_session OWNER TO postgres;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO postgres;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO postgres;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO postgres;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO postgres;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO postgres;

--
-- Name: component; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.component OWNER TO postgres;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO postgres;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO postgres;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.credential OWNER TO postgres;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.databasechangelog OWNER TO postgres;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO postgres;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO postgres;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.event_entity OWNER TO postgres;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO postgres;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.fed_user_consent OWNER TO postgres;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO postgres;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.fed_user_credential OWNER TO postgres;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO postgres;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO postgres;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO postgres;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO postgres;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO postgres;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO postgres;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO postgres;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.identity_provider OWNER TO postgres;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO postgres;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO postgres;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO postgres;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO postgres;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.keycloak_role OWNER TO postgres;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO postgres;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.offline_client_session OWNER TO postgres;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.offline_user_session OWNER TO postgres;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO postgres;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO postgres;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO postgres;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.realm OWNER TO postgres;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO postgres;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO postgres;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO postgres;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO postgres;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO postgres;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO postgres;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO postgres;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO postgres;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO postgres;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO postgres;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.required_action_provider OWNER TO postgres;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO postgres;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO postgres;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO postgres;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO postgres;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.resource_server_perm_ticket OWNER TO postgres;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.resource_server_policy OWNER TO postgres;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.resource_server_resource OWNER TO postgres;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO postgres;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO postgres;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO postgres;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO postgres;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO postgres;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO postgres;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.user_consent OWNER TO postgres;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO postgres;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.user_entity OWNER TO postgres;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO postgres;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO postgres;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO postgres;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.user_federation_provider OWNER TO postgres;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO postgres;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO postgres;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO postgres;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.user_session OWNER TO postgres;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO postgres;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO postgres;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO postgres;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
da5d627e-74f7-4af0-98d5-e39d9664f60c	\N	auth-cookie	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	2d35ec91-c44b-4bc1-90d5-7dcee8989320	2	10	f	\N	\N
93cabdf9-0f50-4140-a811-b343897e1455	\N	auth-spnego	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	2d35ec91-c44b-4bc1-90d5-7dcee8989320	3	20	f	\N	\N
c1b3e5c7-707e-42a5-9c27-c3a14dcb46c0	\N	identity-provider-redirector	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	2d35ec91-c44b-4bc1-90d5-7dcee8989320	2	25	f	\N	\N
74817ccc-f26b-42d2-a826-2d144dbef198	\N	\N	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	2d35ec91-c44b-4bc1-90d5-7dcee8989320	2	30	t	57169485-a71e-4861-8d54-03a50b1a1e52	\N
c335c67b-c12f-4020-9034-db07dbeeba50	\N	auth-username-password-form	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	57169485-a71e-4861-8d54-03a50b1a1e52	0	10	f	\N	\N
49e46c62-1a33-4120-aabe-09e1788f8ca3	\N	\N	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	57169485-a71e-4861-8d54-03a50b1a1e52	1	20	t	6a22c121-00ef-4c1f-ad0b-c112d04ee2df	\N
2c5bf117-2eb0-417b-8b90-a60026b969f5	\N	conditional-user-configured	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	6a22c121-00ef-4c1f-ad0b-c112d04ee2df	0	10	f	\N	\N
5abf4fb3-7340-4477-82a4-c40c4bc4d6a9	\N	auth-otp-form	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	6a22c121-00ef-4c1f-ad0b-c112d04ee2df	0	20	f	\N	\N
dd8c2ede-02a8-4fe9-ab7a-f86c886078f0	\N	direct-grant-validate-username	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	08a90d37-3e49-4883-aa02-1376996e8246	0	10	f	\N	\N
0f4694a6-f846-4392-867f-38ec45e221aa	\N	direct-grant-validate-password	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	08a90d37-3e49-4883-aa02-1376996e8246	0	20	f	\N	\N
bf9abea9-3cda-42ff-b0c6-0b3f166c50f8	\N	\N	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	08a90d37-3e49-4883-aa02-1376996e8246	1	30	t	b3672c7d-be46-4862-909e-69d3959c2083	\N
9dea567b-cfef-48be-a9f2-2cfeecdc5ae4	\N	conditional-user-configured	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	b3672c7d-be46-4862-909e-69d3959c2083	0	10	f	\N	\N
959da684-31da-4b31-940b-8e7e4767ce34	\N	direct-grant-validate-otp	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	b3672c7d-be46-4862-909e-69d3959c2083	0	20	f	\N	\N
9bd140a4-6637-46df-91b0-eea980244099	\N	registration-page-form	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	9761a3a3-977b-4f85-9df9-4c114471a315	0	10	t	ad64b7d5-b595-453c-8dd5-2d02382814df	\N
a61f6791-8949-4291-90f4-c19af4ef1d4c	\N	registration-user-creation	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	ad64b7d5-b595-453c-8dd5-2d02382814df	0	20	f	\N	\N
2e0ac151-d566-45ab-902c-865dffcef905	\N	registration-profile-action	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	ad64b7d5-b595-453c-8dd5-2d02382814df	0	40	f	\N	\N
f76b4606-14e8-43d2-9ae9-ed4e47c0c868	\N	registration-password-action	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	ad64b7d5-b595-453c-8dd5-2d02382814df	0	50	f	\N	\N
5a6d4d74-d636-4c13-8601-406875506d26	\N	registration-recaptcha-action	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	ad64b7d5-b595-453c-8dd5-2d02382814df	3	60	f	\N	\N
b6ed2cff-b091-46d4-b503-5e9bce7fdcc1	\N	reset-credentials-choose-user	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	8650b7ed-32c6-4baf-9088-57485fd3d9e2	0	10	f	\N	\N
b37b5290-1327-48c0-b52c-37095db1fdc3	\N	reset-credential-email	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	8650b7ed-32c6-4baf-9088-57485fd3d9e2	0	20	f	\N	\N
2bc0a803-d301-4724-b395-8db5bad31c8e	\N	reset-password	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	8650b7ed-32c6-4baf-9088-57485fd3d9e2	0	30	f	\N	\N
2a04ea64-1551-4482-a235-ea545ea2e149	\N	\N	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	8650b7ed-32c6-4baf-9088-57485fd3d9e2	1	40	t	ddab3f99-63db-4bb3-b19c-a4665e45256e	\N
0630363b-fcfb-431b-a4f8-5d2e16d0cf79	\N	conditional-user-configured	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	ddab3f99-63db-4bb3-b19c-a4665e45256e	0	10	f	\N	\N
41381191-d669-4952-b234-dafbb90f9ffa	\N	reset-otp	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	ddab3f99-63db-4bb3-b19c-a4665e45256e	0	20	f	\N	\N
1742d243-c553-4d97-a8a6-2c25d490be30	\N	client-secret	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	f7d1d0d0-3c8e-48ec-96de-e7a7b55fb36e	2	10	f	\N	\N
7395a57b-bc82-41d5-81d6-acb5abf016a1	\N	client-jwt	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	f7d1d0d0-3c8e-48ec-96de-e7a7b55fb36e	2	20	f	\N	\N
74029c8a-3678-411f-b4fc-338173fbcb9b	\N	client-secret-jwt	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	f7d1d0d0-3c8e-48ec-96de-e7a7b55fb36e	2	30	f	\N	\N
bf1a6472-f3dc-4998-a015-cafd4786cd7f	\N	client-x509	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	f7d1d0d0-3c8e-48ec-96de-e7a7b55fb36e	2	40	f	\N	\N
4a509aeb-8adc-443e-ada2-391988eeb76d	\N	idp-review-profile	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	b9424bf4-687c-4fd1-b4f2-89f03530ed36	0	10	f	\N	22d63cfe-3a4a-4cf4-8c24-d87053f83527
1565f940-8321-4857-8834-d72c6a98ca5f	\N	\N	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	b9424bf4-687c-4fd1-b4f2-89f03530ed36	0	20	t	0d9cdbd9-689e-4dbb-b663-c2017e1848c6	\N
008a80c7-b344-45a4-ac0b-2e76e06f4375	\N	idp-create-user-if-unique	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	0d9cdbd9-689e-4dbb-b663-c2017e1848c6	2	10	f	\N	d457ba90-501e-4cf0-bdec-3473136efc45
f59819af-25a6-421e-b81a-7c5e9e52e1cd	\N	\N	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	0d9cdbd9-689e-4dbb-b663-c2017e1848c6	2	20	t	c1d07a7a-2772-4db9-94ff-39eaaf464554	\N
9ce72293-12fb-43b9-9200-412af672dc00	\N	idp-confirm-link	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	c1d07a7a-2772-4db9-94ff-39eaaf464554	0	10	f	\N	\N
572834de-1349-490f-b5fc-6ddee7d86456	\N	\N	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	c1d07a7a-2772-4db9-94ff-39eaaf464554	0	20	t	3919b1ce-3f25-422d-86f6-667a46ef86d1	\N
15520c92-20b2-494c-bbfa-2ae65f03797b	\N	idp-email-verification	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	3919b1ce-3f25-422d-86f6-667a46ef86d1	2	10	f	\N	\N
c7cedfe8-643f-441d-be50-68f33dd24b57	\N	\N	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	3919b1ce-3f25-422d-86f6-667a46ef86d1	2	20	t	84b0ee8d-e31e-4c8d-b802-514e4c8adaf3	\N
43cab693-09f4-45ee-90da-3a5330b5d2e8	\N	idp-username-password-form	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	84b0ee8d-e31e-4c8d-b802-514e4c8adaf3	0	10	f	\N	\N
874fef3a-26c1-4088-8fc0-9db2330f5668	\N	\N	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	84b0ee8d-e31e-4c8d-b802-514e4c8adaf3	1	20	t	03d3bdcc-f305-48de-8ed6-8fc491165833	\N
5a5dd09f-9d5d-43f1-bda7-536ab7f07819	\N	conditional-user-configured	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	03d3bdcc-f305-48de-8ed6-8fc491165833	0	10	f	\N	\N
a07cf096-e820-4086-9282-73148dd9d36e	\N	auth-otp-form	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	03d3bdcc-f305-48de-8ed6-8fc491165833	0	20	f	\N	\N
1b50c68a-0efe-4afb-99bb-214c58c59e9a	\N	http-basic-authenticator	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	6ed5b3d4-68bb-4ce3-be95-683c6a0d58ca	0	10	f	\N	\N
66a527be-f192-4608-b25c-8e4de28ad906	\N	docker-http-basic-authenticator	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	57577692-8244-4d2d-92ab-1d6a2514a33d	0	10	f	\N	\N
d23bd90e-5989-44b9-9f7c-e49461e9b9c3	\N	no-cookie-redirect	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	aac8d4e0-4831-4cae-a973-681edde228dc	0	10	f	\N	\N
2eaf85ee-b0ab-4f65-87e7-0eb5f5ea6976	\N	\N	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	aac8d4e0-4831-4cae-a973-681edde228dc	0	20	t	41703ac6-0abc-463c-8ed6-b915da46fa99	\N
c71a9e0b-096e-4c1b-8b8c-15510264be63	\N	basic-auth	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	41703ac6-0abc-463c-8ed6-b915da46fa99	0	10	f	\N	\N
f7ed63ab-4175-4351-a600-44f8e4218042	\N	basic-auth-otp	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	41703ac6-0abc-463c-8ed6-b915da46fa99	3	20	f	\N	\N
439fc190-3b57-42c1-82b3-fd5b58078424	\N	auth-spnego	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	41703ac6-0abc-463c-8ed6-b915da46fa99	3	30	f	\N	\N
846b2dd5-4cb0-434c-ac8c-d29c09391c96	\N	idp-email-verification	cbe1e5c7-2df6-4315-81ae-99391565cb0c	a4c7ae6e-b412-4136-bd52-282136406675	2	10	f	\N	\N
7390cb52-cc28-4f1c-b9fe-68ee696d7d23	\N	\N	cbe1e5c7-2df6-4315-81ae-99391565cb0c	a4c7ae6e-b412-4136-bd52-282136406675	2	20	t	33020870-909c-49c7-947d-b55c1bb0d58a	\N
bd391bcb-c75f-4abe-81ec-19eb6bb9529a	\N	basic-auth	cbe1e5c7-2df6-4315-81ae-99391565cb0c	51086a85-325d-4f64-bc27-bdced1275e9e	0	10	f	\N	\N
471fcdf7-3e3a-4b27-ad52-8ff3fcdc5b2d	\N	basic-auth-otp	cbe1e5c7-2df6-4315-81ae-99391565cb0c	51086a85-325d-4f64-bc27-bdced1275e9e	3	20	f	\N	\N
3472ba22-6445-4cc9-b77c-990e59efe7f2	\N	auth-spnego	cbe1e5c7-2df6-4315-81ae-99391565cb0c	51086a85-325d-4f64-bc27-bdced1275e9e	3	30	f	\N	\N
4a5cd03f-38d2-4cf9-acc8-84ecd4c6b719	\N	conditional-user-configured	cbe1e5c7-2df6-4315-81ae-99391565cb0c	1d10b53a-376e-43fa-a8b4-b281c17764a9	0	10	f	\N	\N
c8debd7d-ef10-49b0-91d5-4c3a42edcec3	\N	auth-otp-form	cbe1e5c7-2df6-4315-81ae-99391565cb0c	1d10b53a-376e-43fa-a8b4-b281c17764a9	0	20	f	\N	\N
742c81cd-def0-434d-b2a8-c91b3a417734	\N	conditional-user-configured	cbe1e5c7-2df6-4315-81ae-99391565cb0c	08736a59-820b-4904-9705-0a58b924eec8	0	10	f	\N	\N
8e91859b-5f06-4565-a899-f32b28a0fd83	\N	direct-grant-validate-otp	cbe1e5c7-2df6-4315-81ae-99391565cb0c	08736a59-820b-4904-9705-0a58b924eec8	0	20	f	\N	\N
000d43bd-d9df-4121-bd42-f02e60e4892f	\N	conditional-user-configured	cbe1e5c7-2df6-4315-81ae-99391565cb0c	bd8d8f56-0707-48cf-866e-d7738d4425fb	0	10	f	\N	\N
f3acbc36-5abe-4dda-b5a7-ed2248c33db5	\N	auth-otp-form	cbe1e5c7-2df6-4315-81ae-99391565cb0c	bd8d8f56-0707-48cf-866e-d7738d4425fb	0	20	f	\N	\N
aeec43da-7769-4078-a9cf-a0b860ce9fad	\N	idp-confirm-link	cbe1e5c7-2df6-4315-81ae-99391565cb0c	fc49b1dd-83f9-40c8-8e4e-c4b2d0bb74b7	0	10	f	\N	\N
52f65bbb-502d-4a80-ac63-0e8529f39ca0	\N	\N	cbe1e5c7-2df6-4315-81ae-99391565cb0c	fc49b1dd-83f9-40c8-8e4e-c4b2d0bb74b7	0	20	t	a4c7ae6e-b412-4136-bd52-282136406675	\N
1bf94489-68b9-4830-a7b6-add3bf392f9b	\N	conditional-user-configured	cbe1e5c7-2df6-4315-81ae-99391565cb0c	9165ca4f-5ce1-4b9c-bf8a-c7daacfcb18a	0	10	f	\N	\N
08d85461-f34a-4377-8ab4-a12e839e3e04	\N	reset-otp	cbe1e5c7-2df6-4315-81ae-99391565cb0c	9165ca4f-5ce1-4b9c-bf8a-c7daacfcb18a	0	20	f	\N	\N
ecc0cc2b-a409-4ffa-a4a7-bb5dd47a97f4	\N	idp-create-user-if-unique	cbe1e5c7-2df6-4315-81ae-99391565cb0c	856d5254-45db-422f-9b16-1a9fd58e73a6	2	10	f	\N	3d05da62-e40c-4347-936b-c5b10cff05b4
96e4e2fe-067a-42ed-aadd-0f4eb8f6fcb6	\N	\N	cbe1e5c7-2df6-4315-81ae-99391565cb0c	856d5254-45db-422f-9b16-1a9fd58e73a6	2	20	t	fc49b1dd-83f9-40c8-8e4e-c4b2d0bb74b7	\N
cd606ee6-ecfe-4b68-bbc6-bcf9b5c0a442	\N	idp-username-password-form	cbe1e5c7-2df6-4315-81ae-99391565cb0c	33020870-909c-49c7-947d-b55c1bb0d58a	0	10	f	\N	\N
96e9b811-df3b-4dfb-be26-f4a5a5522767	\N	\N	cbe1e5c7-2df6-4315-81ae-99391565cb0c	33020870-909c-49c7-947d-b55c1bb0d58a	1	20	t	bd8d8f56-0707-48cf-866e-d7738d4425fb	\N
97497a11-c4f9-4eb4-a228-d3b3ab086af4	\N	auth-cookie	cbe1e5c7-2df6-4315-81ae-99391565cb0c	5cbe336f-685e-4b6c-a18b-662d9303e1ab	2	10	f	\N	\N
cfc05412-cc14-4912-8240-d14ae1d9524b	\N	auth-spnego	cbe1e5c7-2df6-4315-81ae-99391565cb0c	5cbe336f-685e-4b6c-a18b-662d9303e1ab	3	20	f	\N	\N
a4907413-2e7c-4434-8642-0703591734bb	\N	identity-provider-redirector	cbe1e5c7-2df6-4315-81ae-99391565cb0c	5cbe336f-685e-4b6c-a18b-662d9303e1ab	2	25	f	\N	\N
f120d021-cab6-4b8a-93e9-bcbfa9d03cf5	\N	\N	cbe1e5c7-2df6-4315-81ae-99391565cb0c	5cbe336f-685e-4b6c-a18b-662d9303e1ab	2	30	t	3fe7dd27-b5e5-4dfb-ba2e-da64be70aef7	\N
c1cf2234-d2dd-4707-98f1-2cda503532d2	\N	client-secret	cbe1e5c7-2df6-4315-81ae-99391565cb0c	9bd36232-7aeb-43a0-99b4-c5d27ad3f27f	2	10	f	\N	\N
7dfe0dea-c556-45c5-9fda-f54f7ca14d16	\N	client-jwt	cbe1e5c7-2df6-4315-81ae-99391565cb0c	9bd36232-7aeb-43a0-99b4-c5d27ad3f27f	2	20	f	\N	\N
527915d3-4cc5-41cc-ab2d-ec415fe5b204	\N	client-secret-jwt	cbe1e5c7-2df6-4315-81ae-99391565cb0c	9bd36232-7aeb-43a0-99b4-c5d27ad3f27f	2	30	f	\N	\N
9baa572a-c1c9-402d-946f-6d68f14bf429	\N	client-x509	cbe1e5c7-2df6-4315-81ae-99391565cb0c	9bd36232-7aeb-43a0-99b4-c5d27ad3f27f	2	40	f	\N	\N
c9d3a9a5-586c-41f8-b9f1-76943f755cd4	\N	direct-grant-validate-username	cbe1e5c7-2df6-4315-81ae-99391565cb0c	e57e429f-327f-417b-8cc3-e006ff7c9928	0	10	f	\N	\N
d78d0627-94ef-4f5f-b1f0-e198dd46b299	\N	direct-grant-validate-password	cbe1e5c7-2df6-4315-81ae-99391565cb0c	e57e429f-327f-417b-8cc3-e006ff7c9928	0	20	f	\N	\N
b2e3c2e5-d9a3-4657-a5bd-2cd0284611d5	\N	\N	cbe1e5c7-2df6-4315-81ae-99391565cb0c	e57e429f-327f-417b-8cc3-e006ff7c9928	1	30	t	08736a59-820b-4904-9705-0a58b924eec8	\N
ea9db790-1dfe-42c2-9025-e8651b189426	\N	docker-http-basic-authenticator	cbe1e5c7-2df6-4315-81ae-99391565cb0c	d425a327-2de1-4cd4-a0b8-c3ba6151d5be	0	10	f	\N	\N
f519b3ca-e380-4735-b40b-bb67c935933d	\N	idp-review-profile	cbe1e5c7-2df6-4315-81ae-99391565cb0c	166efc67-7a45-4c9d-8da5-c5c155ded59e	0	10	f	\N	3515b6e3-8d86-4988-92af-3beb3af241e7
0c379abf-a829-4ad6-b8f3-73dbd79b796a	\N	\N	cbe1e5c7-2df6-4315-81ae-99391565cb0c	166efc67-7a45-4c9d-8da5-c5c155ded59e	0	20	t	856d5254-45db-422f-9b16-1a9fd58e73a6	\N
68d5ad92-46e8-4e09-aa3c-8e78127af3a9	\N	auth-username-password-form	cbe1e5c7-2df6-4315-81ae-99391565cb0c	3fe7dd27-b5e5-4dfb-ba2e-da64be70aef7	0	10	f	\N	\N
2a515c56-0ac0-4fa4-b0c0-1334fdb71bc0	\N	\N	cbe1e5c7-2df6-4315-81ae-99391565cb0c	3fe7dd27-b5e5-4dfb-ba2e-da64be70aef7	1	20	t	1d10b53a-376e-43fa-a8b4-b281c17764a9	\N
41ba11e0-2784-4d52-9d2f-f36d685377dc	\N	no-cookie-redirect	cbe1e5c7-2df6-4315-81ae-99391565cb0c	512fb041-6fab-40f7-8cbf-0b08926ffa49	0	10	f	\N	\N
e1e45623-a8a4-4c3f-a6fd-4a420d71d2b6	\N	\N	cbe1e5c7-2df6-4315-81ae-99391565cb0c	512fb041-6fab-40f7-8cbf-0b08926ffa49	0	20	t	51086a85-325d-4f64-bc27-bdced1275e9e	\N
c4a22a37-37fb-4efd-8b9c-b3179e886709	\N	registration-page-form	cbe1e5c7-2df6-4315-81ae-99391565cb0c	59e51925-bdbf-47ee-8362-dd98cf4aa5c4	0	10	t	2d8b0efe-3cf4-4c9a-9cba-be1842a5bbab	\N
38abd90e-0c00-4cce-a8e6-0af1d8e903e9	\N	registration-user-creation	cbe1e5c7-2df6-4315-81ae-99391565cb0c	2d8b0efe-3cf4-4c9a-9cba-be1842a5bbab	0	20	f	\N	\N
8fa92150-2e4d-4f72-8498-26ef9f8cac8a	\N	registration-profile-action	cbe1e5c7-2df6-4315-81ae-99391565cb0c	2d8b0efe-3cf4-4c9a-9cba-be1842a5bbab	0	40	f	\N	\N
cdd9e414-5a72-425f-9280-14136fb5d6a3	\N	registration-password-action	cbe1e5c7-2df6-4315-81ae-99391565cb0c	2d8b0efe-3cf4-4c9a-9cba-be1842a5bbab	0	50	f	\N	\N
eeedb897-763b-449e-a439-a5692c219ca0	\N	registration-recaptcha-action	cbe1e5c7-2df6-4315-81ae-99391565cb0c	2d8b0efe-3cf4-4c9a-9cba-be1842a5bbab	3	60	f	\N	\N
4672cec9-33eb-4b33-9763-b02bbcffc99b	\N	reset-credentials-choose-user	cbe1e5c7-2df6-4315-81ae-99391565cb0c	9c43f4c8-4e32-4160-adaf-c7bb1eee167a	0	10	f	\N	\N
17b19ca2-949c-4201-a424-1c99d72368ef	\N	reset-credential-email	cbe1e5c7-2df6-4315-81ae-99391565cb0c	9c43f4c8-4e32-4160-adaf-c7bb1eee167a	0	20	f	\N	\N
a1600ff4-2872-49f9-b52b-c5ce29b3138b	\N	reset-password	cbe1e5c7-2df6-4315-81ae-99391565cb0c	9c43f4c8-4e32-4160-adaf-c7bb1eee167a	0	30	f	\N	\N
8785e078-50ca-4794-b41b-8d3627652640	\N	\N	cbe1e5c7-2df6-4315-81ae-99391565cb0c	9c43f4c8-4e32-4160-adaf-c7bb1eee167a	1	40	t	9165ca4f-5ce1-4b9c-bf8a-c7daacfcb18a	\N
0dd9c317-f5ac-40c7-862e-a24d31b2aecb	\N	http-basic-authenticator	cbe1e5c7-2df6-4315-81ae-99391565cb0c	01930e52-3bca-4d44-8741-aa79ec6b48c1	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
2d35ec91-c44b-4bc1-90d5-7dcee8989320	browser	browser based authentication	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	basic-flow	t	t
57169485-a71e-4861-8d54-03a50b1a1e52	forms	Username, password, otp and other auth forms.	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	basic-flow	f	t
6a22c121-00ef-4c1f-ad0b-c112d04ee2df	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	basic-flow	f	t
08a90d37-3e49-4883-aa02-1376996e8246	direct grant	OpenID Connect Resource Owner Grant	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	basic-flow	t	t
b3672c7d-be46-4862-909e-69d3959c2083	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	basic-flow	f	t
9761a3a3-977b-4f85-9df9-4c114471a315	registration	registration flow	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	basic-flow	t	t
ad64b7d5-b595-453c-8dd5-2d02382814df	registration form	registration form	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	form-flow	f	t
8650b7ed-32c6-4baf-9088-57485fd3d9e2	reset credentials	Reset credentials for a user if they forgot their password or something	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	basic-flow	t	t
ddab3f99-63db-4bb3-b19c-a4665e45256e	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	basic-flow	f	t
f7d1d0d0-3c8e-48ec-96de-e7a7b55fb36e	clients	Base authentication for clients	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	client-flow	t	t
b9424bf4-687c-4fd1-b4f2-89f03530ed36	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	basic-flow	t	t
0d9cdbd9-689e-4dbb-b663-c2017e1848c6	User creation or linking	Flow for the existing/non-existing user alternatives	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	basic-flow	f	t
c1d07a7a-2772-4db9-94ff-39eaaf464554	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	basic-flow	f	t
3919b1ce-3f25-422d-86f6-667a46ef86d1	Account verification options	Method with which to verity the existing account	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	basic-flow	f	t
84b0ee8d-e31e-4c8d-b802-514e4c8adaf3	Verify Existing Account by Re-authentication	Reauthentication of existing account	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	basic-flow	f	t
03d3bdcc-f305-48de-8ed6-8fc491165833	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	basic-flow	f	t
6ed5b3d4-68bb-4ce3-be95-683c6a0d58ca	saml ecp	SAML ECP Profile Authentication Flow	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	basic-flow	t	t
57577692-8244-4d2d-92ab-1d6a2514a33d	docker auth	Used by Docker clients to authenticate against the IDP	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	basic-flow	t	t
aac8d4e0-4831-4cae-a973-681edde228dc	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	basic-flow	t	t
41703ac6-0abc-463c-8ed6-b915da46fa99	Authentication Options	Authentication options.	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	basic-flow	f	t
a4c7ae6e-b412-4136-bd52-282136406675	Account verification options	Method with which to verity the existing account	cbe1e5c7-2df6-4315-81ae-99391565cb0c	basic-flow	f	t
51086a85-325d-4f64-bc27-bdced1275e9e	Authentication Options	Authentication options.	cbe1e5c7-2df6-4315-81ae-99391565cb0c	basic-flow	f	t
1d10b53a-376e-43fa-a8b4-b281c17764a9	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	cbe1e5c7-2df6-4315-81ae-99391565cb0c	basic-flow	f	t
08736a59-820b-4904-9705-0a58b924eec8	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	cbe1e5c7-2df6-4315-81ae-99391565cb0c	basic-flow	f	t
bd8d8f56-0707-48cf-866e-d7738d4425fb	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	cbe1e5c7-2df6-4315-81ae-99391565cb0c	basic-flow	f	t
fc49b1dd-83f9-40c8-8e4e-c4b2d0bb74b7	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	cbe1e5c7-2df6-4315-81ae-99391565cb0c	basic-flow	f	t
9165ca4f-5ce1-4b9c-bf8a-c7daacfcb18a	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	cbe1e5c7-2df6-4315-81ae-99391565cb0c	basic-flow	f	t
856d5254-45db-422f-9b16-1a9fd58e73a6	User creation or linking	Flow for the existing/non-existing user alternatives	cbe1e5c7-2df6-4315-81ae-99391565cb0c	basic-flow	f	t
33020870-909c-49c7-947d-b55c1bb0d58a	Verify Existing Account by Re-authentication	Reauthentication of existing account	cbe1e5c7-2df6-4315-81ae-99391565cb0c	basic-flow	f	t
5cbe336f-685e-4b6c-a18b-662d9303e1ab	browser	browser based authentication	cbe1e5c7-2df6-4315-81ae-99391565cb0c	basic-flow	t	t
9bd36232-7aeb-43a0-99b4-c5d27ad3f27f	clients	Base authentication for clients	cbe1e5c7-2df6-4315-81ae-99391565cb0c	client-flow	t	t
e57e429f-327f-417b-8cc3-e006ff7c9928	direct grant	OpenID Connect Resource Owner Grant	cbe1e5c7-2df6-4315-81ae-99391565cb0c	basic-flow	t	t
d425a327-2de1-4cd4-a0b8-c3ba6151d5be	docker auth	Used by Docker clients to authenticate against the IDP	cbe1e5c7-2df6-4315-81ae-99391565cb0c	basic-flow	t	t
166efc67-7a45-4c9d-8da5-c5c155ded59e	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	cbe1e5c7-2df6-4315-81ae-99391565cb0c	basic-flow	t	t
3fe7dd27-b5e5-4dfb-ba2e-da64be70aef7	forms	Username, password, otp and other auth forms.	cbe1e5c7-2df6-4315-81ae-99391565cb0c	basic-flow	f	t
512fb041-6fab-40f7-8cbf-0b08926ffa49	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	cbe1e5c7-2df6-4315-81ae-99391565cb0c	basic-flow	t	t
59e51925-bdbf-47ee-8362-dd98cf4aa5c4	registration	registration flow	cbe1e5c7-2df6-4315-81ae-99391565cb0c	basic-flow	t	t
2d8b0efe-3cf4-4c9a-9cba-be1842a5bbab	registration form	registration form	cbe1e5c7-2df6-4315-81ae-99391565cb0c	form-flow	f	t
9c43f4c8-4e32-4160-adaf-c7bb1eee167a	reset credentials	Reset credentials for a user if they forgot their password or something	cbe1e5c7-2df6-4315-81ae-99391565cb0c	basic-flow	t	t
01930e52-3bca-4d44-8741-aa79ec6b48c1	saml ecp	SAML ECP Profile Authentication Flow	cbe1e5c7-2df6-4315-81ae-99391565cb0c	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
22d63cfe-3a4a-4cf4-8c24-d87053f83527	review profile config	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0
d457ba90-501e-4cf0-bdec-3473136efc45	create unique user config	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0
3d05da62-e40c-4347-936b-c5b10cff05b4	create unique user config	cbe1e5c7-2df6-4315-81ae-99391565cb0c
3515b6e3-8d86-4988-92af-3beb3af241e7	review profile config	cbe1e5c7-2df6-4315-81ae-99391565cb0c
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
22d63cfe-3a4a-4cf4-8c24-d87053f83527	missing	update.profile.on.first.login
d457ba90-501e-4cf0-bdec-3473136efc45	false	require.password.update.after.registration
3515b6e3-8d86-4988-92af-3beb3af241e7	missing	update.profile.on.first.login
3d05da62-e40c-4347-936b-c5b10cff05b4	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
be9cdd2f-9a9d-4f02-85f2-340a2921fe56	t	f	master-realm	0	f	\N	\N	t	\N	f	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
5f5beba5-7c21-407e-8e8b-2f3a6cdfb19f	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
bc637500-577a-4a27-8195-332e353992b2	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
d28a131d-754b-4ecb-8670-1cd69234a3b7	t	f	broker	0	f	\N	\N	t	\N	f	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
d69e5f30-203e-41ae-a726-1f8948a43de6	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
9d58e0e4-2d55-4ecb-b54d-8a8db9413917	t	f	admin-cli	0	t	\N	\N	f	\N	f	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
83a550b2-cfe9-4b89-8249-c5c5b0768b88	t	f	testing-realm-realm	0	f	\N	\N	t	\N	f	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	\N	0	f	f	testing-realm Realm	f	client-secret	\N	\N	\N	t	f	f	f
ab8b4126-c57b-4569-92ff-b29d9111aca3	t	f	account	0	t	\N	/realms/testing-realm/account/	f	\N	f	cbe1e5c7-2df6-4315-81ae-99391565cb0c	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
e7abce3a-f802-40e3-bfe2-9b3c5d306c72	t	t	springboot-testing	0	f	skEsUGd0QF0IuPttKWjuoR5HlXIzIklW		f		f	cbe1e5c7-2df6-4315-81ae-99391565cb0c	openid-connect	-1	t	f		f	client-secret			\N	t	f	f	f
5847a1f9-bc56-44b8-b548-dc9e6c50a883	t	f	account-console	0	t	\N	/realms/testing-realm/account/	f	\N	f	cbe1e5c7-2df6-4315-81ae-99391565cb0c	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
041de8e0-ed37-4624-ad5f-0ebc7efb7d8d	t	f	admin-cli	0	t	\N	\N	f	\N	f	cbe1e5c7-2df6-4315-81ae-99391565cb0c	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
26a66b8b-94b9-460d-a970-be87fbf2e93d	t	f	broker	0	f	\N	\N	t	\N	f	cbe1e5c7-2df6-4315-81ae-99391565cb0c	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
7ab6de4e-eb0a-4065-b68c-697bc5a347a4	t	f	realm-management	0	f	\N	\N	t	\N	f	cbe1e5c7-2df6-4315-81ae-99391565cb0c	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
7f05ba07-4dfd-4d20-8593-77ba24fb858a	t	f	security-admin-console	0	t	\N	/admin/testing-realm/console/	f	\N	f	cbe1e5c7-2df6-4315-81ae-99391565cb0c	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
5f5beba5-7c21-407e-8e8b-2f3a6cdfb19f	post.logout.redirect.uris	+
bc637500-577a-4a27-8195-332e353992b2	post.logout.redirect.uris	+
bc637500-577a-4a27-8195-332e353992b2	pkce.code.challenge.method	S256
d69e5f30-203e-41ae-a726-1f8948a43de6	post.logout.redirect.uris	+
d69e5f30-203e-41ae-a726-1f8948a43de6	pkce.code.challenge.method	S256
ab8b4126-c57b-4569-92ff-b29d9111aca3	post.logout.redirect.uris	+
5847a1f9-bc56-44b8-b548-dc9e6c50a883	post.logout.redirect.uris	+
5847a1f9-bc56-44b8-b548-dc9e6c50a883	pkce.code.challenge.method	S256
041de8e0-ed37-4624-ad5f-0ebc7efb7d8d	post.logout.redirect.uris	+
26a66b8b-94b9-460d-a970-be87fbf2e93d	post.logout.redirect.uris	+
7ab6de4e-eb0a-4065-b68c-697bc5a347a4	post.logout.redirect.uris	+
7f05ba07-4dfd-4d20-8593-77ba24fb858a	post.logout.redirect.uris	+
7f05ba07-4dfd-4d20-8593-77ba24fb858a	pkce.code.challenge.method	S256
e7abce3a-f802-40e3-bfe2-9b3c5d306c72	backchannel.logout.revoke.offline.tokens	false
e7abce3a-f802-40e3-bfe2-9b3c5d306c72	backchannel.logout.session.required	true
e7abce3a-f802-40e3-bfe2-9b3c5d306c72	client.secret.creation.time	1684726326
e7abce3a-f802-40e3-bfe2-9b3c5d306c72	display.on.consent.screen	false
e7abce3a-f802-40e3-bfe2-9b3c5d306c72	oauth2.device.authorization.grant.enabled	false
e7abce3a-f802-40e3-bfe2-9b3c5d306c72	oidc.ciba.grant.enabled	false
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
c3d7e71f-2fa2-4e5d-b580-178e263f792c	offline_access	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	OpenID Connect built-in scope: offline_access	openid-connect
73d65881-75b5-478c-ad69-6fed31e383f3	role_list	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	SAML role list	saml
89e232b5-b3df-48cb-94f0-f1b03e6c68f6	profile	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	OpenID Connect built-in scope: profile	openid-connect
a2cc3c5f-9472-4812-975d-c545071f8522	email	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	OpenID Connect built-in scope: email	openid-connect
25a3144c-b376-4fa0-afd4-c5f3d4dd7582	address	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	OpenID Connect built-in scope: address	openid-connect
7f30c325-3de9-4f1d-a975-cc6bd870a90e	phone	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	OpenID Connect built-in scope: phone	openid-connect
f9065946-fcdf-4194-aa9e-75b13145f65b	roles	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	OpenID Connect scope for add user roles to the access token	openid-connect
4f226a1c-ea33-44c1-ae1a-494806fa49f5	web-origins	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	OpenID Connect scope for add allowed web origins to the access token	openid-connect
a59dc23f-deaa-4b97-8637-9ef15abaee46	microprofile-jwt	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	Microprofile - JWT built-in scope	openid-connect
aefc9c13-31ce-413d-a0bf-8f4e3829c40b	acr	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
9a670f04-41ac-4da8-b039-28dce24fac15	offline_access	cbe1e5c7-2df6-4315-81ae-99391565cb0c	OpenID Connect built-in scope: offline_access	openid-connect
3194e349-b71a-43f5-99dd-9e25349e66cd	phone	cbe1e5c7-2df6-4315-81ae-99391565cb0c	OpenID Connect built-in scope: phone	openid-connect
84e038fe-f6fc-46f2-a57f-9feb435ef80a	acr	cbe1e5c7-2df6-4315-81ae-99391565cb0c	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
cacb555e-dc4c-4e8f-9de8-9a5d2be48c20	role_list	cbe1e5c7-2df6-4315-81ae-99391565cb0c	SAML role list	saml
620c7619-6927-4434-b8bf-e4252a4ded7c	email	cbe1e5c7-2df6-4315-81ae-99391565cb0c	OpenID Connect built-in scope: email	openid-connect
c48d3c37-4891-43f6-a435-11c608e5e49a	profile	cbe1e5c7-2df6-4315-81ae-99391565cb0c	OpenID Connect built-in scope: profile	openid-connect
b5b7e586-4d77-48db-b8de-86a930ad1807	microprofile-jwt	cbe1e5c7-2df6-4315-81ae-99391565cb0c	Microprofile - JWT built-in scope	openid-connect
f95f85af-c4cf-49d7-8dc7-985fc602a2eb	address	cbe1e5c7-2df6-4315-81ae-99391565cb0c	OpenID Connect built-in scope: address	openid-connect
54ec3616-09a5-4a7e-8272-f4da91858b3d	roles	cbe1e5c7-2df6-4315-81ae-99391565cb0c	OpenID Connect scope for add user roles to the access token	openid-connect
b2ac5abd-12bb-4c38-adf4-be272a591e65	web-origins	cbe1e5c7-2df6-4315-81ae-99391565cb0c	OpenID Connect scope for add allowed web origins to the access token	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
c3d7e71f-2fa2-4e5d-b580-178e263f792c	true	display.on.consent.screen
c3d7e71f-2fa2-4e5d-b580-178e263f792c	${offlineAccessScopeConsentText}	consent.screen.text
73d65881-75b5-478c-ad69-6fed31e383f3	true	display.on.consent.screen
73d65881-75b5-478c-ad69-6fed31e383f3	${samlRoleListScopeConsentText}	consent.screen.text
89e232b5-b3df-48cb-94f0-f1b03e6c68f6	true	display.on.consent.screen
89e232b5-b3df-48cb-94f0-f1b03e6c68f6	${profileScopeConsentText}	consent.screen.text
89e232b5-b3df-48cb-94f0-f1b03e6c68f6	true	include.in.token.scope
a2cc3c5f-9472-4812-975d-c545071f8522	true	display.on.consent.screen
a2cc3c5f-9472-4812-975d-c545071f8522	${emailScopeConsentText}	consent.screen.text
a2cc3c5f-9472-4812-975d-c545071f8522	true	include.in.token.scope
25a3144c-b376-4fa0-afd4-c5f3d4dd7582	true	display.on.consent.screen
25a3144c-b376-4fa0-afd4-c5f3d4dd7582	${addressScopeConsentText}	consent.screen.text
25a3144c-b376-4fa0-afd4-c5f3d4dd7582	true	include.in.token.scope
7f30c325-3de9-4f1d-a975-cc6bd870a90e	true	display.on.consent.screen
7f30c325-3de9-4f1d-a975-cc6bd870a90e	${phoneScopeConsentText}	consent.screen.text
7f30c325-3de9-4f1d-a975-cc6bd870a90e	true	include.in.token.scope
f9065946-fcdf-4194-aa9e-75b13145f65b	true	display.on.consent.screen
f9065946-fcdf-4194-aa9e-75b13145f65b	${rolesScopeConsentText}	consent.screen.text
f9065946-fcdf-4194-aa9e-75b13145f65b	false	include.in.token.scope
4f226a1c-ea33-44c1-ae1a-494806fa49f5	false	display.on.consent.screen
4f226a1c-ea33-44c1-ae1a-494806fa49f5		consent.screen.text
4f226a1c-ea33-44c1-ae1a-494806fa49f5	false	include.in.token.scope
a59dc23f-deaa-4b97-8637-9ef15abaee46	false	display.on.consent.screen
a59dc23f-deaa-4b97-8637-9ef15abaee46	true	include.in.token.scope
aefc9c13-31ce-413d-a0bf-8f4e3829c40b	false	display.on.consent.screen
aefc9c13-31ce-413d-a0bf-8f4e3829c40b	false	include.in.token.scope
9a670f04-41ac-4da8-b039-28dce24fac15	${offlineAccessScopeConsentText}	consent.screen.text
9a670f04-41ac-4da8-b039-28dce24fac15	true	display.on.consent.screen
3194e349-b71a-43f5-99dd-9e25349e66cd	true	include.in.token.scope
3194e349-b71a-43f5-99dd-9e25349e66cd	true	display.on.consent.screen
3194e349-b71a-43f5-99dd-9e25349e66cd	${phoneScopeConsentText}	consent.screen.text
84e038fe-f6fc-46f2-a57f-9feb435ef80a	false	include.in.token.scope
84e038fe-f6fc-46f2-a57f-9feb435ef80a	false	display.on.consent.screen
cacb555e-dc4c-4e8f-9de8-9a5d2be48c20	${samlRoleListScopeConsentText}	consent.screen.text
cacb555e-dc4c-4e8f-9de8-9a5d2be48c20	true	display.on.consent.screen
620c7619-6927-4434-b8bf-e4252a4ded7c	true	include.in.token.scope
620c7619-6927-4434-b8bf-e4252a4ded7c	true	display.on.consent.screen
620c7619-6927-4434-b8bf-e4252a4ded7c	${emailScopeConsentText}	consent.screen.text
c48d3c37-4891-43f6-a435-11c608e5e49a	true	include.in.token.scope
c48d3c37-4891-43f6-a435-11c608e5e49a	true	display.on.consent.screen
c48d3c37-4891-43f6-a435-11c608e5e49a	${profileScopeConsentText}	consent.screen.text
b5b7e586-4d77-48db-b8de-86a930ad1807	true	include.in.token.scope
b5b7e586-4d77-48db-b8de-86a930ad1807	false	display.on.consent.screen
f95f85af-c4cf-49d7-8dc7-985fc602a2eb	true	include.in.token.scope
f95f85af-c4cf-49d7-8dc7-985fc602a2eb	true	display.on.consent.screen
f95f85af-c4cf-49d7-8dc7-985fc602a2eb	${addressScopeConsentText}	consent.screen.text
54ec3616-09a5-4a7e-8272-f4da91858b3d	false	include.in.token.scope
54ec3616-09a5-4a7e-8272-f4da91858b3d	true	display.on.consent.screen
54ec3616-09a5-4a7e-8272-f4da91858b3d	${rolesScopeConsentText}	consent.screen.text
b2ac5abd-12bb-4c38-adf4-be272a591e65	false	include.in.token.scope
b2ac5abd-12bb-4c38-adf4-be272a591e65	false	display.on.consent.screen
b2ac5abd-12bb-4c38-adf4-be272a591e65		consent.screen.text
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
5f5beba5-7c21-407e-8e8b-2f3a6cdfb19f	89e232b5-b3df-48cb-94f0-f1b03e6c68f6	t
5f5beba5-7c21-407e-8e8b-2f3a6cdfb19f	f9065946-fcdf-4194-aa9e-75b13145f65b	t
5f5beba5-7c21-407e-8e8b-2f3a6cdfb19f	a2cc3c5f-9472-4812-975d-c545071f8522	t
5f5beba5-7c21-407e-8e8b-2f3a6cdfb19f	4f226a1c-ea33-44c1-ae1a-494806fa49f5	t
5f5beba5-7c21-407e-8e8b-2f3a6cdfb19f	aefc9c13-31ce-413d-a0bf-8f4e3829c40b	t
5f5beba5-7c21-407e-8e8b-2f3a6cdfb19f	a59dc23f-deaa-4b97-8637-9ef15abaee46	f
5f5beba5-7c21-407e-8e8b-2f3a6cdfb19f	25a3144c-b376-4fa0-afd4-c5f3d4dd7582	f
5f5beba5-7c21-407e-8e8b-2f3a6cdfb19f	7f30c325-3de9-4f1d-a975-cc6bd870a90e	f
5f5beba5-7c21-407e-8e8b-2f3a6cdfb19f	c3d7e71f-2fa2-4e5d-b580-178e263f792c	f
bc637500-577a-4a27-8195-332e353992b2	89e232b5-b3df-48cb-94f0-f1b03e6c68f6	t
bc637500-577a-4a27-8195-332e353992b2	f9065946-fcdf-4194-aa9e-75b13145f65b	t
bc637500-577a-4a27-8195-332e353992b2	a2cc3c5f-9472-4812-975d-c545071f8522	t
bc637500-577a-4a27-8195-332e353992b2	4f226a1c-ea33-44c1-ae1a-494806fa49f5	t
bc637500-577a-4a27-8195-332e353992b2	aefc9c13-31ce-413d-a0bf-8f4e3829c40b	t
bc637500-577a-4a27-8195-332e353992b2	a59dc23f-deaa-4b97-8637-9ef15abaee46	f
bc637500-577a-4a27-8195-332e353992b2	25a3144c-b376-4fa0-afd4-c5f3d4dd7582	f
bc637500-577a-4a27-8195-332e353992b2	7f30c325-3de9-4f1d-a975-cc6bd870a90e	f
bc637500-577a-4a27-8195-332e353992b2	c3d7e71f-2fa2-4e5d-b580-178e263f792c	f
9d58e0e4-2d55-4ecb-b54d-8a8db9413917	89e232b5-b3df-48cb-94f0-f1b03e6c68f6	t
9d58e0e4-2d55-4ecb-b54d-8a8db9413917	f9065946-fcdf-4194-aa9e-75b13145f65b	t
9d58e0e4-2d55-4ecb-b54d-8a8db9413917	a2cc3c5f-9472-4812-975d-c545071f8522	t
9d58e0e4-2d55-4ecb-b54d-8a8db9413917	4f226a1c-ea33-44c1-ae1a-494806fa49f5	t
9d58e0e4-2d55-4ecb-b54d-8a8db9413917	aefc9c13-31ce-413d-a0bf-8f4e3829c40b	t
9d58e0e4-2d55-4ecb-b54d-8a8db9413917	a59dc23f-deaa-4b97-8637-9ef15abaee46	f
9d58e0e4-2d55-4ecb-b54d-8a8db9413917	25a3144c-b376-4fa0-afd4-c5f3d4dd7582	f
9d58e0e4-2d55-4ecb-b54d-8a8db9413917	7f30c325-3de9-4f1d-a975-cc6bd870a90e	f
9d58e0e4-2d55-4ecb-b54d-8a8db9413917	c3d7e71f-2fa2-4e5d-b580-178e263f792c	f
d28a131d-754b-4ecb-8670-1cd69234a3b7	89e232b5-b3df-48cb-94f0-f1b03e6c68f6	t
d28a131d-754b-4ecb-8670-1cd69234a3b7	f9065946-fcdf-4194-aa9e-75b13145f65b	t
d28a131d-754b-4ecb-8670-1cd69234a3b7	a2cc3c5f-9472-4812-975d-c545071f8522	t
d28a131d-754b-4ecb-8670-1cd69234a3b7	4f226a1c-ea33-44c1-ae1a-494806fa49f5	t
d28a131d-754b-4ecb-8670-1cd69234a3b7	aefc9c13-31ce-413d-a0bf-8f4e3829c40b	t
d28a131d-754b-4ecb-8670-1cd69234a3b7	a59dc23f-deaa-4b97-8637-9ef15abaee46	f
d28a131d-754b-4ecb-8670-1cd69234a3b7	25a3144c-b376-4fa0-afd4-c5f3d4dd7582	f
d28a131d-754b-4ecb-8670-1cd69234a3b7	7f30c325-3de9-4f1d-a975-cc6bd870a90e	f
d28a131d-754b-4ecb-8670-1cd69234a3b7	c3d7e71f-2fa2-4e5d-b580-178e263f792c	f
be9cdd2f-9a9d-4f02-85f2-340a2921fe56	89e232b5-b3df-48cb-94f0-f1b03e6c68f6	t
be9cdd2f-9a9d-4f02-85f2-340a2921fe56	f9065946-fcdf-4194-aa9e-75b13145f65b	t
be9cdd2f-9a9d-4f02-85f2-340a2921fe56	a2cc3c5f-9472-4812-975d-c545071f8522	t
be9cdd2f-9a9d-4f02-85f2-340a2921fe56	4f226a1c-ea33-44c1-ae1a-494806fa49f5	t
be9cdd2f-9a9d-4f02-85f2-340a2921fe56	aefc9c13-31ce-413d-a0bf-8f4e3829c40b	t
be9cdd2f-9a9d-4f02-85f2-340a2921fe56	a59dc23f-deaa-4b97-8637-9ef15abaee46	f
be9cdd2f-9a9d-4f02-85f2-340a2921fe56	25a3144c-b376-4fa0-afd4-c5f3d4dd7582	f
be9cdd2f-9a9d-4f02-85f2-340a2921fe56	7f30c325-3de9-4f1d-a975-cc6bd870a90e	f
be9cdd2f-9a9d-4f02-85f2-340a2921fe56	c3d7e71f-2fa2-4e5d-b580-178e263f792c	f
d69e5f30-203e-41ae-a726-1f8948a43de6	89e232b5-b3df-48cb-94f0-f1b03e6c68f6	t
d69e5f30-203e-41ae-a726-1f8948a43de6	f9065946-fcdf-4194-aa9e-75b13145f65b	t
d69e5f30-203e-41ae-a726-1f8948a43de6	a2cc3c5f-9472-4812-975d-c545071f8522	t
d69e5f30-203e-41ae-a726-1f8948a43de6	4f226a1c-ea33-44c1-ae1a-494806fa49f5	t
d69e5f30-203e-41ae-a726-1f8948a43de6	aefc9c13-31ce-413d-a0bf-8f4e3829c40b	t
d69e5f30-203e-41ae-a726-1f8948a43de6	a59dc23f-deaa-4b97-8637-9ef15abaee46	f
d69e5f30-203e-41ae-a726-1f8948a43de6	25a3144c-b376-4fa0-afd4-c5f3d4dd7582	f
d69e5f30-203e-41ae-a726-1f8948a43de6	7f30c325-3de9-4f1d-a975-cc6bd870a90e	f
d69e5f30-203e-41ae-a726-1f8948a43de6	c3d7e71f-2fa2-4e5d-b580-178e263f792c	f
ab8b4126-c57b-4569-92ff-b29d9111aca3	b2ac5abd-12bb-4c38-adf4-be272a591e65	t
ab8b4126-c57b-4569-92ff-b29d9111aca3	84e038fe-f6fc-46f2-a57f-9feb435ef80a	t
ab8b4126-c57b-4569-92ff-b29d9111aca3	c48d3c37-4891-43f6-a435-11c608e5e49a	t
ab8b4126-c57b-4569-92ff-b29d9111aca3	54ec3616-09a5-4a7e-8272-f4da91858b3d	t
ab8b4126-c57b-4569-92ff-b29d9111aca3	620c7619-6927-4434-b8bf-e4252a4ded7c	t
ab8b4126-c57b-4569-92ff-b29d9111aca3	f95f85af-c4cf-49d7-8dc7-985fc602a2eb	f
ab8b4126-c57b-4569-92ff-b29d9111aca3	3194e349-b71a-43f5-99dd-9e25349e66cd	f
ab8b4126-c57b-4569-92ff-b29d9111aca3	9a670f04-41ac-4da8-b039-28dce24fac15	f
ab8b4126-c57b-4569-92ff-b29d9111aca3	b5b7e586-4d77-48db-b8de-86a930ad1807	f
5847a1f9-bc56-44b8-b548-dc9e6c50a883	b2ac5abd-12bb-4c38-adf4-be272a591e65	t
5847a1f9-bc56-44b8-b548-dc9e6c50a883	84e038fe-f6fc-46f2-a57f-9feb435ef80a	t
5847a1f9-bc56-44b8-b548-dc9e6c50a883	c48d3c37-4891-43f6-a435-11c608e5e49a	t
5847a1f9-bc56-44b8-b548-dc9e6c50a883	54ec3616-09a5-4a7e-8272-f4da91858b3d	t
5847a1f9-bc56-44b8-b548-dc9e6c50a883	620c7619-6927-4434-b8bf-e4252a4ded7c	t
5847a1f9-bc56-44b8-b548-dc9e6c50a883	f95f85af-c4cf-49d7-8dc7-985fc602a2eb	f
5847a1f9-bc56-44b8-b548-dc9e6c50a883	3194e349-b71a-43f5-99dd-9e25349e66cd	f
5847a1f9-bc56-44b8-b548-dc9e6c50a883	9a670f04-41ac-4da8-b039-28dce24fac15	f
5847a1f9-bc56-44b8-b548-dc9e6c50a883	b5b7e586-4d77-48db-b8de-86a930ad1807	f
041de8e0-ed37-4624-ad5f-0ebc7efb7d8d	b2ac5abd-12bb-4c38-adf4-be272a591e65	t
041de8e0-ed37-4624-ad5f-0ebc7efb7d8d	84e038fe-f6fc-46f2-a57f-9feb435ef80a	t
041de8e0-ed37-4624-ad5f-0ebc7efb7d8d	c48d3c37-4891-43f6-a435-11c608e5e49a	t
041de8e0-ed37-4624-ad5f-0ebc7efb7d8d	54ec3616-09a5-4a7e-8272-f4da91858b3d	t
041de8e0-ed37-4624-ad5f-0ebc7efb7d8d	620c7619-6927-4434-b8bf-e4252a4ded7c	t
041de8e0-ed37-4624-ad5f-0ebc7efb7d8d	f95f85af-c4cf-49d7-8dc7-985fc602a2eb	f
041de8e0-ed37-4624-ad5f-0ebc7efb7d8d	3194e349-b71a-43f5-99dd-9e25349e66cd	f
041de8e0-ed37-4624-ad5f-0ebc7efb7d8d	9a670f04-41ac-4da8-b039-28dce24fac15	f
041de8e0-ed37-4624-ad5f-0ebc7efb7d8d	b5b7e586-4d77-48db-b8de-86a930ad1807	f
26a66b8b-94b9-460d-a970-be87fbf2e93d	b2ac5abd-12bb-4c38-adf4-be272a591e65	t
26a66b8b-94b9-460d-a970-be87fbf2e93d	84e038fe-f6fc-46f2-a57f-9feb435ef80a	t
26a66b8b-94b9-460d-a970-be87fbf2e93d	c48d3c37-4891-43f6-a435-11c608e5e49a	t
26a66b8b-94b9-460d-a970-be87fbf2e93d	54ec3616-09a5-4a7e-8272-f4da91858b3d	t
26a66b8b-94b9-460d-a970-be87fbf2e93d	620c7619-6927-4434-b8bf-e4252a4ded7c	t
26a66b8b-94b9-460d-a970-be87fbf2e93d	f95f85af-c4cf-49d7-8dc7-985fc602a2eb	f
26a66b8b-94b9-460d-a970-be87fbf2e93d	3194e349-b71a-43f5-99dd-9e25349e66cd	f
26a66b8b-94b9-460d-a970-be87fbf2e93d	9a670f04-41ac-4da8-b039-28dce24fac15	f
26a66b8b-94b9-460d-a970-be87fbf2e93d	b5b7e586-4d77-48db-b8de-86a930ad1807	f
7ab6de4e-eb0a-4065-b68c-697bc5a347a4	b2ac5abd-12bb-4c38-adf4-be272a591e65	t
7ab6de4e-eb0a-4065-b68c-697bc5a347a4	84e038fe-f6fc-46f2-a57f-9feb435ef80a	t
7ab6de4e-eb0a-4065-b68c-697bc5a347a4	c48d3c37-4891-43f6-a435-11c608e5e49a	t
7ab6de4e-eb0a-4065-b68c-697bc5a347a4	54ec3616-09a5-4a7e-8272-f4da91858b3d	t
7ab6de4e-eb0a-4065-b68c-697bc5a347a4	620c7619-6927-4434-b8bf-e4252a4ded7c	t
7ab6de4e-eb0a-4065-b68c-697bc5a347a4	f95f85af-c4cf-49d7-8dc7-985fc602a2eb	f
7ab6de4e-eb0a-4065-b68c-697bc5a347a4	3194e349-b71a-43f5-99dd-9e25349e66cd	f
7ab6de4e-eb0a-4065-b68c-697bc5a347a4	9a670f04-41ac-4da8-b039-28dce24fac15	f
7ab6de4e-eb0a-4065-b68c-697bc5a347a4	b5b7e586-4d77-48db-b8de-86a930ad1807	f
7f05ba07-4dfd-4d20-8593-77ba24fb858a	b2ac5abd-12bb-4c38-adf4-be272a591e65	t
7f05ba07-4dfd-4d20-8593-77ba24fb858a	84e038fe-f6fc-46f2-a57f-9feb435ef80a	t
7f05ba07-4dfd-4d20-8593-77ba24fb858a	c48d3c37-4891-43f6-a435-11c608e5e49a	t
7f05ba07-4dfd-4d20-8593-77ba24fb858a	54ec3616-09a5-4a7e-8272-f4da91858b3d	t
7f05ba07-4dfd-4d20-8593-77ba24fb858a	620c7619-6927-4434-b8bf-e4252a4ded7c	t
7f05ba07-4dfd-4d20-8593-77ba24fb858a	f95f85af-c4cf-49d7-8dc7-985fc602a2eb	f
7f05ba07-4dfd-4d20-8593-77ba24fb858a	3194e349-b71a-43f5-99dd-9e25349e66cd	f
7f05ba07-4dfd-4d20-8593-77ba24fb858a	9a670f04-41ac-4da8-b039-28dce24fac15	f
7f05ba07-4dfd-4d20-8593-77ba24fb858a	b5b7e586-4d77-48db-b8de-86a930ad1807	f
e7abce3a-f802-40e3-bfe2-9b3c5d306c72	b2ac5abd-12bb-4c38-adf4-be272a591e65	t
e7abce3a-f802-40e3-bfe2-9b3c5d306c72	84e038fe-f6fc-46f2-a57f-9feb435ef80a	t
e7abce3a-f802-40e3-bfe2-9b3c5d306c72	c48d3c37-4891-43f6-a435-11c608e5e49a	t
e7abce3a-f802-40e3-bfe2-9b3c5d306c72	54ec3616-09a5-4a7e-8272-f4da91858b3d	t
e7abce3a-f802-40e3-bfe2-9b3c5d306c72	620c7619-6927-4434-b8bf-e4252a4ded7c	t
e7abce3a-f802-40e3-bfe2-9b3c5d306c72	f95f85af-c4cf-49d7-8dc7-985fc602a2eb	f
e7abce3a-f802-40e3-bfe2-9b3c5d306c72	3194e349-b71a-43f5-99dd-9e25349e66cd	f
e7abce3a-f802-40e3-bfe2-9b3c5d306c72	9a670f04-41ac-4da8-b039-28dce24fac15	f
e7abce3a-f802-40e3-bfe2-9b3c5d306c72	b5b7e586-4d77-48db-b8de-86a930ad1807	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
c3d7e71f-2fa2-4e5d-b580-178e263f792c	5ff25442-cfc8-4412-b592-77c910366d6f
9a670f04-41ac-4da8-b039-28dce24fac15	017cca8a-c3a1-4b69-99eb-bbb221e86e8b
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
d5b13757-f7b9-44d4-9821-0091f0b32428	Trusted Hosts	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	anonymous
991ddc6d-4461-4784-9c89-1f334b4a6df0	Consent Required	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	anonymous
5c17f688-57cf-4ef8-872f-3e359d5f5f14	Full Scope Disabled	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	anonymous
14c9813a-aa47-4e92-b4d6-d712ddf2e9bd	Max Clients Limit	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	anonymous
581dd7e4-8a05-4333-9b2b-3a6dc38c312a	Allowed Protocol Mapper Types	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	anonymous
36001324-bc06-4776-92a5-56829ccc22f9	Allowed Client Scopes	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	anonymous
b48ca052-3670-47d9-9838-d516e336d25b	Allowed Protocol Mapper Types	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	authenticated
b2f686b7-e56f-4df9-8580-56101783af8b	Allowed Client Scopes	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	authenticated
55362f2d-942f-4325-921a-c58cc1be6e9e	rsa-generated	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	rsa-generated	org.keycloak.keys.KeyProvider	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	\N
b68d2020-ddff-4e7f-b522-53e4c5a779f4	rsa-enc-generated	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	rsa-enc-generated	org.keycloak.keys.KeyProvider	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	\N
a492d8e3-29cb-43ee-a269-8359f962192c	hmac-generated	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	hmac-generated	org.keycloak.keys.KeyProvider	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	\N
69cbba4d-bdac-4650-9ac7-3e9344f2bd6a	aes-generated	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	aes-generated	org.keycloak.keys.KeyProvider	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	\N
54ff52f9-b107-4b6c-adcb-e134f3489376	Allowed Protocol Mapper Types	cbe1e5c7-2df6-4315-81ae-99391565cb0c	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	cbe1e5c7-2df6-4315-81ae-99391565cb0c	authenticated
be85dab7-5ca5-44e1-8d81-5e2027648b0a	Allowed Client Scopes	cbe1e5c7-2df6-4315-81ae-99391565cb0c	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	cbe1e5c7-2df6-4315-81ae-99391565cb0c	anonymous
e091e511-7ec4-4354-9923-e42f97593356	Max Clients Limit	cbe1e5c7-2df6-4315-81ae-99391565cb0c	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	cbe1e5c7-2df6-4315-81ae-99391565cb0c	anonymous
9272c29e-7a69-48fa-81d1-eb9239110e09	Allowed Client Scopes	cbe1e5c7-2df6-4315-81ae-99391565cb0c	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	cbe1e5c7-2df6-4315-81ae-99391565cb0c	authenticated
5413cf6b-2028-4d71-b371-0e2b289c450b	Consent Required	cbe1e5c7-2df6-4315-81ae-99391565cb0c	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	cbe1e5c7-2df6-4315-81ae-99391565cb0c	anonymous
e7cbab52-0b2e-41dd-aee2-0aa2f439228b	Trusted Hosts	cbe1e5c7-2df6-4315-81ae-99391565cb0c	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	cbe1e5c7-2df6-4315-81ae-99391565cb0c	anonymous
785d3b4c-1fcd-42c4-88d0-2ccd4b0cafbb	Allowed Protocol Mapper Types	cbe1e5c7-2df6-4315-81ae-99391565cb0c	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	cbe1e5c7-2df6-4315-81ae-99391565cb0c	anonymous
1f10ae5b-7d2e-4d81-ae8f-1e7ba40f768c	Full Scope Disabled	cbe1e5c7-2df6-4315-81ae-99391565cb0c	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	cbe1e5c7-2df6-4315-81ae-99391565cb0c	anonymous
dfd58bd1-c5ac-4225-ba9a-63b978e118b9	rsa-enc-generated	cbe1e5c7-2df6-4315-81ae-99391565cb0c	rsa-enc-generated	org.keycloak.keys.KeyProvider	cbe1e5c7-2df6-4315-81ae-99391565cb0c	\N
ecf1e7e9-895d-49dd-8013-ef6e1490979b	rsa-generated	cbe1e5c7-2df6-4315-81ae-99391565cb0c	rsa-generated	org.keycloak.keys.KeyProvider	cbe1e5c7-2df6-4315-81ae-99391565cb0c	\N
e2d198ed-6135-4ced-a0fd-4d25d769d445	aes-generated	cbe1e5c7-2df6-4315-81ae-99391565cb0c	aes-generated	org.keycloak.keys.KeyProvider	cbe1e5c7-2df6-4315-81ae-99391565cb0c	\N
fe6fb23f-070c-4c0d-91b5-4a35fa26b46f	hmac-generated	cbe1e5c7-2df6-4315-81ae-99391565cb0c	hmac-generated	org.keycloak.keys.KeyProvider	cbe1e5c7-2df6-4315-81ae-99391565cb0c	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
81770a5c-f868-464e-94ed-5932919b4902	b48ca052-3670-47d9-9838-d516e336d25b	allowed-protocol-mapper-types	saml-user-property-mapper
8f6b4da9-dd3a-49fa-9a29-5fa6fa16105a	b48ca052-3670-47d9-9838-d516e336d25b	allowed-protocol-mapper-types	saml-role-list-mapper
90e45db5-a1a9-4c96-853d-0afcecc25045	b48ca052-3670-47d9-9838-d516e336d25b	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
04975a92-16ae-4af2-8061-6d85af1e7df6	b48ca052-3670-47d9-9838-d516e336d25b	allowed-protocol-mapper-types	oidc-full-name-mapper
069ab7b1-b4cb-47e0-887d-9be37394d3ef	b48ca052-3670-47d9-9838-d516e336d25b	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
9f0720c9-78ad-4d63-937e-90f078778f0e	b48ca052-3670-47d9-9838-d516e336d25b	allowed-protocol-mapper-types	saml-user-attribute-mapper
1b04b7f7-7c41-4838-b36f-c115af2af7bf	b48ca052-3670-47d9-9838-d516e336d25b	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
73a1fe18-9ad3-4f61-a67f-04114a98c9a3	b48ca052-3670-47d9-9838-d516e336d25b	allowed-protocol-mapper-types	oidc-address-mapper
a465c6cc-3c2e-4df6-95aa-7bebd1ca4995	581dd7e4-8a05-4333-9b2b-3a6dc38c312a	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
d4c74794-4462-40c9-b84e-a1100e042f11	581dd7e4-8a05-4333-9b2b-3a6dc38c312a	allowed-protocol-mapper-types	saml-user-attribute-mapper
a93a0f84-98cd-4be8-9481-eaa5b3862adb	581dd7e4-8a05-4333-9b2b-3a6dc38c312a	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
3b59a880-0553-448f-bd35-0699605f36a9	581dd7e4-8a05-4333-9b2b-3a6dc38c312a	allowed-protocol-mapper-types	oidc-full-name-mapper
c146cc5e-7937-4e39-bf7b-cb3f4921851f	581dd7e4-8a05-4333-9b2b-3a6dc38c312a	allowed-protocol-mapper-types	saml-role-list-mapper
5d1d081c-890f-49ce-9022-76ab92c61144	581dd7e4-8a05-4333-9b2b-3a6dc38c312a	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
a5ccb0c6-e4f4-406e-b3fa-4e6754e9ed91	581dd7e4-8a05-4333-9b2b-3a6dc38c312a	allowed-protocol-mapper-types	saml-user-property-mapper
639c0fe2-a2ca-4077-a1d0-b6747d061e53	581dd7e4-8a05-4333-9b2b-3a6dc38c312a	allowed-protocol-mapper-types	oidc-address-mapper
d50b91b2-75ec-4cfd-a773-d2428a9ad8c1	b2f686b7-e56f-4df9-8580-56101783af8b	allow-default-scopes	true
2e8e5773-42c5-4830-bac2-9c8b12ae4240	14c9813a-aa47-4e92-b4d6-d712ddf2e9bd	max-clients	200
0af892e9-1d02-4c35-aa6c-d0d6ab219a78	36001324-bc06-4776-92a5-56829ccc22f9	allow-default-scopes	true
c9e80fa4-834c-4cc9-b65e-a0d17d0b2e87	d5b13757-f7b9-44d4-9821-0091f0b32428	client-uris-must-match	true
43ad5575-7147-43d5-ad44-dfdea943f5a9	d5b13757-f7b9-44d4-9821-0091f0b32428	host-sending-registration-request-must-match	true
7e51ddfc-2dc9-4856-a1d4-8fdd88acd560	69cbba4d-bdac-4650-9ac7-3e9344f2bd6a	secret	-GsjDINp7Q-NfjCecnhWtA
8355482a-2fcb-41d3-ac18-43527746d02c	69cbba4d-bdac-4650-9ac7-3e9344f2bd6a	priority	100
4d2d0f13-7822-4465-807d-408d7d606932	69cbba4d-bdac-4650-9ac7-3e9344f2bd6a	kid	b71099e0-f4ae-4927-97c1-c79e66bd62da
b0285190-2350-4d9d-a757-ffea6e558274	55362f2d-942f-4325-921a-c58cc1be6e9e	priority	100
8adc8956-5cb0-4a41-9a3f-44e3dd61c586	55362f2d-942f-4325-921a-c58cc1be6e9e	certificate	MIICmzCCAYMCBgGIMvI7QzANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMwNTE5MDczNjU1WhcNMzMwNTE5MDczODM1WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCpKmpQBjrr6n/WPr+PPst9VVwtvGLnApLXd5zOIdxprj7wFiaQ0DXz/40rPVDLTegDa/H9yEdCTgV9ymtHjiB5Mk//0vsrYTBtRECZLpS22YM81bWUzstF6QaCnqqHyL8eCoQlrQx4wGePdtmaoKg7z45fsSSl5Y2wJ/3lRuSQoRQ1Li5iOFTG7PkI40dJCvF7EULkZVdP7txGLQGz4EbyW+H5fppqzELDLlrFM25tBONg7KA+xkZuyRLDDmO9UPugW6zSWN2R66V3AEozIwkD7pgZToSq2t/a4BTIAdB4EjAY0WC1xT6V2fAo06re88tT5ZWySkfeTE+FcUSwcq1vAgMBAAEwDQYJKoZIhvcNAQELBQADggEBACyFtpZtdEhJ02mFezQ2knNEfXr1ndqCM8L6XaEfNPMckPq4HE9yA65k7WkGOCje0zpFee2VENmsGGsL6oruWNcfHyB9ff/SZNUUmVzSYVyakfCoVuLMHHGy2FiCA4dshQZSKiemIT1x98ToQDRivzFTNC03Fc0omF1k7JD/AT720DWNxf+3c0N0qC+K3XzWYvDxKk4GkCIznEQf3N7KBLOoQdT2C7G4ZywJ+2JlhRRCUeC8AS3jWdeLX7I9/PV4VpRohwqZjg2HRF25XXv8oi1Cl5Dur0ssuA5et4SSZ7axEDqtIZOUidy4QQyPx4d5mo0TyaRPXyYXnfuoqreXiWU=
e834dd27-0a05-4343-bd3d-61e2b13eaae3	55362f2d-942f-4325-921a-c58cc1be6e9e	keyUse	SIG
167f2883-a4bf-4b29-a54f-322bd0c28802	55362f2d-942f-4325-921a-c58cc1be6e9e	privateKey	MIIEogIBAAKCAQEAqSpqUAY66+p/1j6/jz7LfVVcLbxi5wKS13ecziHcaa4+8BYmkNA18/+NKz1Qy03oA2vx/chHQk4FfcprR44geTJP/9L7K2EwbURAmS6UttmDPNW1lM7LRekGgp6qh8i/HgqEJa0MeMBnj3bZmqCoO8+OX7EkpeWNsCf95UbkkKEUNS4uYjhUxuz5CONHSQrxexFC5GVXT+7cRi0Bs+BG8lvh+X6aasxCwy5axTNubQTjYOygPsZGbskSww5jvVD7oFus0ljdkeuldwBKMyMJA+6YGU6Eqtrf2uAUyAHQeBIwGNFgtcU+ldnwKNOq3vPLU+WVskpH3kxPhXFEsHKtbwIDAQABAoIBAAQO4JevMT5T6kwqm4V6r/6qNmNh0mI7UBLQ1kH6/aLKtiIj+I80ciQ6fFmjXMBRIUs6Ytw/2oxvJbeTobOI584wfvXNSw7f2ShjNkTWdrp/iPlDy9mC2nfWCWdxxKKBlirI0sxlPy2DDsOaH3STp7rY6vqbBnI1CbXw8lN2j2jJbQpDk5shvPAV+sVIJPpy36U9wmrOHZYN8INMwzu2lHgd3Ur0c0ZkD3vUrzuMtdZ9g98FYInR1YMYR7fR074owTsCXbopNgCeBpBaVEJ92rkankhssLhmaOZiauA3x3b/6DvKe/xHu6hpS1WSNBIc9thLOR7fN2gPPxSLAUOjgckCgYEA7S02K0Pj18wCLsCS1mtYFBRKMNEkA5jP3rLfpyaRkzaFVsEGtrnY4Gq964M6/nYMOjRfn1owGxygiA/n4fgcKB9eaMXSnm2HWSrwGJ8isGoMHh4ULxEqAT7JjYMC0L1OdBIxWPkf1MaXjFRZqRjD9u/i6A5dkugYJgVE25beFckCgYEAtpdnw3+X+JJWeRhRz0szWgEF0RgwaP3XK544qyh2igsxF+/33ZVugYutS+l68FpLyEToeoYjJ8b/WTWnRSv0QP4xHdw6O0MbugMF6riJ55ogq3m53O064Cm6UqAaUzefrvCbc/o+IhzUaSvNkjyPeTd29GcbJnckbQ5k1hfMpXcCgYAyejjZJG3Nc8HTKXEW6WmpfFf948UCbvdusisfa/n3ltbyC8reANfDi3Q4N4nKtl0L1jGzvIIYgxM3Ygs78I4ti9+P9OpKhY0U0SqgUt4TJb7GeihZjBGgijhjQcrLmj6kPWr7QKohotKGLz2V24t5dryYHtaTeYoKLXzmL0m84QKBgAvRjQPYdGvAfRxleJYkVfSTcF7yY9/H3m+SVDSv78xLoSfdfnu3OmnkMplhSXXZQmJ6I1oa6Jegh9KsaGFP0QWL7n3yTUqcs2S84VsqCrMVBNxUirVEHbV4vfivKEUOqqVWKZm+LttiZlVQYoP+q4K7FlYHfnhk6dStQ9WfwL1NAoGAOmsPc8KOvPvlyysyZT4tQYkmCsfA9nnUTXAIpvSJKzxgAcpfnXyxyjJEj9o9Wfafh6KWZ2UxAkC87RFV8t6PM2QaNu2lMi9ipm8Jl2OaGr7CDxyvId6GZQbdZz1JIYKrXinN/49tE5cfFfzE4vLV8n04IteMw4/R1N8MzeH+Pew=
6a7eb14f-fa9d-4a24-89a8-8030e899bd10	dfd58bd1-c5ac-4225-ba9a-63b978e118b9	certificate	MIICqTCCAZECBgGIMvQ5WTANBgkqhkiG9w0BAQsFADAYMRYwFAYDVQQDDA10ZXN0aW5nLXJlYWxtMB4XDTIzMDUxOTA3MzkwNloXDTMzMDUxOTA3NDA0NlowGDEWMBQGA1UEAwwNdGVzdGluZy1yZWFsbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAK9d3wW32t9tr95gL9n1OMYKhw8MbdxlXxnjMmV858n45tVZrKRL4EpZU1RyNgb+hYHVfLcBXF/628YaOf3AxEOJZJkinhRiB3RJMzjQ3R6cE9NnJFRJnKmfoj6js7k4hIEFQRDbD8B1oRcG/pIsrBK0+cqNlsgUrHtTOVQfxyCEyeSnVr2OtoAhbgPgtJfQ0+Wo759fgZxUZEnl7ubbCE2mIYW9diHM9lphXCcrWuDlWNK8Wz4lAp5B2rsXen8Zy5eS3OBBomW2wEcZ3dCR2a6YVSiptPp9x+p2wXfgBZMoB16Xa52eqa3o7TsxR9Oc/lbSpfBc8oAJB3PDSa85gI8CAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAdyG0ZT8GqpPrE94f0taj4kAPK9PJmopePLHpWPRDMLnQlA0lNXU4/bBCymnH3JsmAnyDa3DYIiv0miSlqfrlOujfCz1MQqAeU+2GUzRTDDRPUUQG5AoEPYsCZ5jZWe+arklODUHjfrFqNi/xH3dvuiCXyYKZWBp7G0Ys+SF6myUcMZoR9aeUDqCXlFIAOnNl0jASXdCJvV8F4cDLSlShfOiiD5mc3YMyiWPYYlEe8hGCw4XkLQ0PlLeTSdAVNqkJ3PdZ9IXn6JwoNx8CmWmqKdl7y6jY0MRC475N8vtxZC0b4E8IbyalbG+57/innybHXx2C8ftMj5ncE/SXkXb8TA==
09b38088-eaa5-41a3-87cb-0517e3667907	b68d2020-ddff-4e7f-b522-53e4c5a779f4	privateKey	MIIEpAIBAAKCAQEA5lq/sWse5ovh4UIIm4dm69w4FYgXEqpkcPdFvupzkuCmqi5zsMx0WAjf1oLbga3KqaEWer2nsVlLLOS6IgUYu5jaLvNROCgSFEjtZWqP6bUj3N7vwiB5Sl88uGogxe3rG5vBdIUEpX4eeE6ziNLCAtTJXvJ//JcBrStviocZzAOV4SUb/vWO6KzPwBMrHezuepkzG87v4NI95T07566y3ZMNi9OEt7eLbmBnKwh22GsFaHRFq9OPSTgBN2dq+tWULqr026SBly7A5FsTYw9VDiSikvv0s7XkwriXtYDKgwPQicMqIOZ9HWu6PmHvefykwlxPRKocqedYW9qyyiXNAQIDAQABAoIBAF/on9CIV7zIt/rYSgordYw1S/qXB3hDjn9ETPtA1W7tbycDITMW5Uf0JfJD2I3lJLC8u8XN6iCam4StFNxuP853xTvwHbxiXqiodoMXu6SkQTLIdY3fhHCVN4xWz59pQE7l6kWPzo/y80/HANQyYAnau573G5e47b9CivXj6zc36otUqUYdGa9FsoLrVMah1voMk74diBv0f4X0/NDFSIBJdbSIahker9fy2iJYhXAyuAqZ4tUHlW1ELSf+VYd6Jvx/F4K1IC5uTIoFY3jQGCmg+7EGLmGWds4Hf2aF4kIjAW+tcYB351fKr47KMT4OselaVF+3lft9pnAo4VJ15eMCgYEA/Yw+0qsDBn50fYy8NQA7G4GkzkUdGgJtBOzunDve+5zYyzcdFavy5YJg1cll91nw2QwZ5BlgqrwOna+kFSNje0+iXNmkVa7G4DONONM3xMQ291pfw611gD2GZ/cVfh6L70MSJnJaQMMam+qmpBENEJ6GzgZMDkh3OMRNAmXMvOsCgYEA6JUUU8gQY1fqvnPtJnFRwb+QnUYaPXgDm8RLKfaJm1h7pOleQHWtlnMl2Z7RStv/4KoS2WiB9xsHkB78WV3D2zdrhEsnrNfYy0+YDGf7d++Wo5kmv9kCNdJiDcMlHAwUIqScQocKl+Unstt4wfPyz6AqbsGPWzj7W0lLusPkMsMCgYANxdiDyRZY+/WH/GUc2+5aCCjTq51xFECny9cKVZY/RL3iDBRgYP7IyNRJyK7pSNF0eNvPMDG4FI8WsbvQCiQVRrYjJQ9wOBZFh4dcVtzoq1/w/8/D6WBAnxb1/s4EE9S2IoaR4BRXAEIpxg1XTDXReUsJVf47qGQRiVhFkRIWEQKBgQCoK5s+FSvcWSaQPUxdfpSKDlSnk5fHmG6rg5yBpBTNsYX9sQwIec5hObNFjnNwuHBk5zSn5MwMe4vVZsI6b/T9Hi5swtbWQGAuacfcOJd4mlGGy2dcUrIpboydvNupUwaAIhwmcnRzbittRQok25pXDE2CNgzM/f+peu76BUiMdwKBgQD57Vd3UFMqng7P81rzxMNsGUWZaT9vk+/cvkcR/gGJDvlq6aa2PYeQfRqeqZ6CfjbqEByBamZqC337WFHcDLWZnHJJx5rftEVoLd8tNYp0xlK99NZyMiP9yeIryk738misTxCqOwRsFlfltNwYet5dvMuprukiFWA3YJpXYMugZw==
0964236a-9849-4466-a932-bd495967c8a3	b68d2020-ddff-4e7f-b522-53e4c5a779f4	keyUse	ENC
041e0241-17b5-43d9-9d28-ae9567ae66f0	b68d2020-ddff-4e7f-b522-53e4c5a779f4	algorithm	RSA-OAEP
56d1f62c-5a08-4fb7-b49f-e7c63189c2a6	b68d2020-ddff-4e7f-b522-53e4c5a779f4	certificate	MIICmzCCAYMCBgGIMvJAqjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMwNTE5MDczNjU3WhcNMzMwNTE5MDczODM3WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDmWr+xax7mi+HhQgibh2br3DgViBcSqmRw90W+6nOS4KaqLnOwzHRYCN/WgtuBrcqpoRZ6vaexWUss5LoiBRi7mNou81E4KBIUSO1lao/ptSPc3u/CIHlKXzy4aiDF7esbm8F0hQSlfh54TrOI0sIC1Mle8n/8lwGtK2+KhxnMA5XhJRv+9Y7orM/AEysd7O56mTMbzu/g0j3lPTvnrrLdkw2L04S3t4tuYGcrCHbYawVodEWr049JOAE3Z2r61ZQuqvTbpIGXLsDkWxNjD1UOJKKS+/SzteTCuJe1gMqDA9CJwyog5n0da7o+Ye95/KTCXE9Eqhyp51hb2rLKJc0BAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAIG8EsDGwytIfDdGs819QAhtS4FsfyhXPL6p8l5asLT7A/94PNP4p2/bWOlGs9BhGT9JmYLMcPQGrcead81tMIWMU9NvKPDrvLsY+TkET326nURpfPde3MUQtDQY8TsKJkGKwBqm/iQZcvfOgvadM8lF2k8TZt7kGFkCGe+Ug1gD7u/MglbPyCDHNTNFHRu7JMoERvWKsiZ1YXt6syBywNgD1iYVqrXy9Kf1Cnj7fNU0pfLx4O1E/GK+bt9gk8D/ubPXlltnDdiqPvKvOhccDuOVBHEnqSc6b9JL5qvpnLeI3YgwcvDW8rOXbQ9EViXzeUhpgF1sUKyaODm0DprHH+s=
3da2d15f-5bfc-47bb-87a6-64e222c4c3ea	b68d2020-ddff-4e7f-b522-53e4c5a779f4	priority	100
0ed201f9-52c5-4349-80f1-c9b3558372d9	a492d8e3-29cb-43ee-a269-8359f962192c	secret	lrc5jMZKpxo7cRwBnXkQvr6Y0DAqlRAELT5Ex02UOAxsWn0q_MjRbJEGncF0nx0J6idUUNtq_FBd-YERhto0xA
898422c7-7c0d-4c50-a309-ccac23f627f0	a492d8e3-29cb-43ee-a269-8359f962192c	kid	0959a990-5f43-4208-9a7a-212c1788a071
245c9679-1b61-43ad-8cba-6db49d06cc27	a492d8e3-29cb-43ee-a269-8359f962192c	priority	100
46808614-863d-4747-8444-ba2ca1fe2789	a492d8e3-29cb-43ee-a269-8359f962192c	algorithm	HS256
cb42846e-ab6f-4e33-a221-a7e701cc39f6	54ff52f9-b107-4b6c-adcb-e134f3489376	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
b64562fa-1b4b-403f-bcfb-ac4d4f32cee8	54ff52f9-b107-4b6c-adcb-e134f3489376	allowed-protocol-mapper-types	saml-role-list-mapper
573c4c2e-1e78-459f-8f10-9c95a2a8880d	54ff52f9-b107-4b6c-adcb-e134f3489376	allowed-protocol-mapper-types	saml-user-property-mapper
ec681430-7be4-41be-8640-d092dd8c665c	54ff52f9-b107-4b6c-adcb-e134f3489376	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
0acf7914-375e-464a-bcf0-f6224a1d7e29	54ff52f9-b107-4b6c-adcb-e134f3489376	allowed-protocol-mapper-types	oidc-full-name-mapper
63e8862d-ba6d-48a1-928b-55abfc2660da	54ff52f9-b107-4b6c-adcb-e134f3489376	allowed-protocol-mapper-types	oidc-address-mapper
70f019ae-5b8b-4f5f-a475-94588e6d9e9c	54ff52f9-b107-4b6c-adcb-e134f3489376	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
7f378e07-5019-41cb-834f-8c97a5e7dde4	54ff52f9-b107-4b6c-adcb-e134f3489376	allowed-protocol-mapper-types	saml-user-attribute-mapper
44c0cb05-8eea-42a6-9050-cf36f44fcdc5	be85dab7-5ca5-44e1-8d81-5e2027648b0a	allow-default-scopes	true
791f1929-ebc9-4c91-b259-ceab83a3b941	e091e511-7ec4-4354-9923-e42f97593356	max-clients	200
c5ea3777-996e-48f1-8235-294810b24fb5	dfd58bd1-c5ac-4225-ba9a-63b978e118b9	algorithm	RSA-OAEP
f27858fd-468d-4854-8b10-1aebe77acee2	dfd58bd1-c5ac-4225-ba9a-63b978e118b9	priority	100
7d92e893-38c1-4c9f-ae8b-843bbc3b27e0	dfd58bd1-c5ac-4225-ba9a-63b978e118b9	privateKey	MIIEogIBAAKCAQEAr13fBbfa322v3mAv2fU4xgqHDwxt3GVfGeMyZXznyfjm1VmspEvgSllTVHI2Bv6FgdV8twFcX/rbxho5/cDEQ4lkmSKeFGIHdEkzONDdHpwT02ckVEmcqZ+iPqOzuTiEgQVBENsPwHWhFwb+kiysErT5yo2WyBSse1M5VB/HIITJ5KdWvY62gCFuA+C0l9DT5ajvn1+BnFRkSeXu5tsITaYhhb12Icz2WmFcJyta4OVY0rxbPiUCnkHauxd6fxnLl5Lc4EGiZbbARxnd0JHZrphVKKm0+n3H6nbBd+AFkygHXpdrnZ6prejtOzFH05z+VtKl8FzygAkHc8NJrzmAjwIDAQABAoIBAEr4xMn7ChWPHSri0FJMJhN0mLz0QVuB8yBsIzWEKswMHxODHO24ipD+k0N8+GARHB6fmIvchxN5ec+9kqFLchy1dk6JoC9yoWEzkjRuBrp5W3h7lep69gEGgCRrdABxiyRljKWaIafUIiRoFxmDA6WTvV69HYM4Y2zt7Yprc4QQynwASdQh85PFt18i6GN5jR+4lSyxaQK8hAeavy/zfKxlJp1RJAftt8lxn5fr+id0yq5LsONoo6RQPyxEVfWU3Q3EVfi1XInqX3a0E4p7KY/s7yFfeIovhaKjUPQ/mcFxbkrqo0W1HfjFPZh1WrCTjMyqe6BznzO0idXCuF25bwECgYEA76q1kDyOJg3e6TAw57NIu5Qh1hhY+J0Yo16DnheLZgZcc5cBvBw+EQMHSBWsames8MsuNnnLkHOr+mYprZR37YcqAPPYVHqbnQNApbodJAUIIKX1uBN7t29dmMjfaxbLP8z9ppl86d7CsxfsIoy47/Czd7RoHLExAeybjZaWTM8CgYEAu1FdVmhVmH1JFkemmDlAEmLV+vGFV0WvEtcvKNtGPEGIelKVoaJsmSV803SsL1wCiJDFZK3lH2BnPu5vSafHUsGCGQpU+OocYtSQcy49/zkxMGoVIhMjnfTZWZa2EFySugr3xOdBYml2PtZBQtOZI4Dc+Konv+dVVJQR4L/wAEECgYBLRmrQarSa7zBcPW6e14i4ocYe4HbRX0YlycG9HdgCq2zOQVeiJZy46yKWWXhV00pWNvrE0WxGao5Rj1T31/HzAMkIk44Wuou1vRfI9bPBZHMxDe8nabcp3iifnDfQAtDDsTbZ5Mt/CSBN7+2SzHAprIgxyNAKcvzZhd81kV6TsQKBgHi4Cyswulk4BO4y5w6bdstinvzGwmRoKFhADciK6EzU/xu2NXChuNNJ8ZRlUMKEza0tf8lOuKbr/h30lAwn8LFIvIteuTxhxEF9NErGtnXRaf4Fn/EB3KZjsd+m3VbWEkmL3/op/11pEieU9SIYNE1JMx+eqVdnwvprIspxaD8BAoGANxxRvV5AAAu1W+376ESxYIddPo6Nc9wfHljwgwHvg7xE7zaGvtN0igbniIX01BylvLj8bmh07haV4YMQBJW/0qIEoXigAF0z3L20WMllfY32qq4xC13jZiWFZWYm8eB4zXeTE/bHJ0zUUO8nRRwqTsvqULETLpHhTfw7M45/lCQ=
3fdca4a1-5d68-4114-9ffc-c5bd63539d30	ecf1e7e9-895d-49dd-8013-ef6e1490979b	privateKey	MIIEpAIBAAKCAQEAti0VJNKYG9YIfWnq7dfx8O2wPLQhK0vDPtOontRNLJlkRYQPQrkZ0DK/oVVMq3oDPvEB45V3qGgHBL2zmYSfpxmZ2YUxXPQKLiu3m7sT6sz3SjkHl2y7XhCLfII9H9Do+YDnrz1MrksKNM/egiGCpvbQK3EcuHjJKaJDnpXehq247q8C1NVf1uc1n4yCaj/nlka6SeG0XVbnmjWXKoNMgXdBO9BeZUFDXMJ9AUNcG0r5dAX8kuZWzNIbijKDMnQutFJeaDT9XVBqzZzTKDATYCitoksmCaIeMgBLwm0tTF8/mx8Vj4KOTI7LNt4WknY8M/GITWlAqQYN96qyBsjETwIDAQABAoIBABAzpTg/pHiBSgMBWvvpIyLGuNBFQtfrZoNdZpctkWmAgNrv2j2YYbPS95j9EZMEiGpeG8lmPxySl+Ezj9f85AgD7ltajZ/TMl6V07/9XNGahfmrZcHxUR6WARnDKXV9amLaNICwxnOPx+oXfJX9LfX0aGIcrq23TEiwHixp7r7yaNDHXSPEkN4bcCFIzK+RZ/WkGqbKSkNnhifvmQX5Iqg/5F1Byqa/JWwqRrrdAG8AMbAN+4qsL5u/9u90Uqlc7RI3weVmTKxcWri7qYE5Qs3RoL/fj0lAuN7WJX3BbjqvcPU7gGo4g6ed9FZ6DeDrr3/6HOUKr1kFuWC7hWbHK7ECgYEA5LPexizy8N0JD8s2HnfAeDA+4HfHrB6lQziCyybx/btkMZfmw71MIQEe9z7yZ0pF7tB8J7vyRLjdtPAeR9HfWgdPn0OPh8SingcVH16f6pqAGPaFlfjIzn9h4xSZo5FVbyoid3yZhj2yOwpMjSBuDAzUNDsjZvXgH4wdlA9UvR8CgYEAy+uR79/JzyhpahMa8XK5bt6SdMhU4q7WHeTWtH2ThSHkNpIYYpwbg8N2PlBIxhVQHj024VnD8Q0kwDp+QTuSubOKasMK9cxJQjKKJsfLaLJ9UID6X0EvTi4KBo+y/g2gWdgS4Se148Arml32siPvh4G4jgUSHXDHWXXPvbK74tECgYEArRoHj/ANoYlrhmzE9aKmJ1I9BSEkHH7Fj2+Cb8l2eBoR6AeVPqpUqNZ0XadjShLJg8yBbIGxCZrzFDR6dtm/OCE4fs9gH98RRpMNxcSVPbjbJAnTaoP3WXTI3luFPmyOQamelNnWSekAsfdFobveD3jWVQI99Xw8uyQObzZ7aPkCgYBgNvQSpBqKPd0PCZiq16CaqTWdGHDEzA2G6VRMsPuL02PkQ6Zx0IpC71S5LhRIMgItYmCkj0AeWj8+29p6WOtv50CmAwUG2K6wJzx788ULzzvFYjW///ecAakFU4P2zuMbwRGXXq85mJB6M1+UydPYseIsUEQt0+qbUTUFonF4IQKBgQCV7jP3C2IGbF4ZPEJKTN0ANcoy6Wxr3Z0FICO1S9Slb71X/WSlR29AZV5Yn6DAH4/ZZoVZbVSujpbexe8MnQFlORRuZgbHjQgng14xi1pyWrBOipZymId+6UxAhBbQarbnGkTys/K9hsFahRlY7Nr/h1VVINQAikQ8sw1sLmQuYA==
c44a8fec-eea6-4e31-9f20-d98d251c1460	ecf1e7e9-895d-49dd-8013-ef6e1490979b	priority	100
b95d9eaa-94a9-4494-ac47-91b116c4b961	ecf1e7e9-895d-49dd-8013-ef6e1490979b	certificate	MIICqTCCAZECBgGIMvQ9OTANBgkqhkiG9w0BAQsFADAYMRYwFAYDVQQDDA10ZXN0aW5nLXJlYWxtMB4XDTIzMDUxOTA3MzkwN1oXDTMzMDUxOTA3NDA0N1owGDEWMBQGA1UEAwwNdGVzdGluZy1yZWFsbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALYtFSTSmBvWCH1p6u3X8fDtsDy0IStLwz7TqJ7UTSyZZEWED0K5GdAyv6FVTKt6Az7xAeOVd6hoBwS9s5mEn6cZmdmFMVz0Ci4rt5u7E+rM90o5B5dsu14Qi3yCPR/Q6PmA5689TK5LCjTP3oIhgqb20CtxHLh4ySmiQ56V3oatuO6vAtTVX9bnNZ+Mgmo/55ZGuknhtF1W55o1lyqDTIF3QTvQXmVBQ1zCfQFDXBtK+XQF/JLmVszSG4oygzJ0LrRSXmg0/V1Qas2c0ygwE2AoraJLJgmiHjIAS8JtLUxfP5sfFY+CjkyOyzbeFpJ2PDPxiE1pQKkGDfeqsgbIxE8CAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAS7VT3BJvX/ixivmYWVv6NZSPLzcC1XlL6HcxWTq3p7n5cB0Q3OQ0jF15fUp27NkmI+BJoCcwNLspavsy41B7TDl+tZI8vKygYHvMikOo/D+CFSBK5mwWOyc4pM5cCkNjc7XwR2m/J5KPEkgeX9RxdWDnQ19JQKbWpxWOo9TjEer9B4x7iT7qFzbwMjDBr6pX+bdgp8X9UTsS8y1+CaHx2orQX2lP1m7AaTybV5SoZD/oIXsKZre52hXWB87Op0oACd/ZJHeCSiyVfxDs8cOtIdVUO3xqRM+szw9FWuE4CuyxWVpKZCUxgCl/WJ4zfiROeYgBAjUdk7qYQpoDtoyNUQ==
76bea32c-593d-487e-b69e-0d667ac1482f	e2d198ed-6135-4ced-a0fd-4d25d769d445	kid	465a1359-aa30-4961-96c1-684afa785c4d
139640f7-dea6-410f-955f-c13b2eb91e00	e2d198ed-6135-4ced-a0fd-4d25d769d445	priority	100
daddb87b-bb43-437a-a4bd-06f311e24fa6	e2d198ed-6135-4ced-a0fd-4d25d769d445	secret	9Ret__ujnw9JdVx6o14hpg
c0847dd3-81b5-43fa-bb13-d8ce21838d39	9272c29e-7a69-48fa-81d1-eb9239110e09	allow-default-scopes	true
c027aafd-b707-4edd-aef1-62d57ccb5338	e7cbab52-0b2e-41dd-aee2-0aa2f439228b	client-uris-must-match	true
1fde85aa-c512-470a-9713-ee5e0863fd2b	e7cbab52-0b2e-41dd-aee2-0aa2f439228b	host-sending-registration-request-must-match	true
5cb41c82-abdb-48ab-9d97-10ab3cb2bcf6	785d3b4c-1fcd-42c4-88d0-2ccd4b0cafbb	allowed-protocol-mapper-types	saml-user-property-mapper
969c4364-072d-452a-aeaf-856f36ee8f77	785d3b4c-1fcd-42c4-88d0-2ccd4b0cafbb	allowed-protocol-mapper-types	oidc-address-mapper
f149dbef-ffd1-4b29-8b6d-b952d67a262f	785d3b4c-1fcd-42c4-88d0-2ccd4b0cafbb	allowed-protocol-mapper-types	saml-role-list-mapper
86462980-80e8-4192-bbdb-7c34e05188b2	785d3b4c-1fcd-42c4-88d0-2ccd4b0cafbb	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
5e1eaf20-4376-4e15-99b9-6d80f656aa79	785d3b4c-1fcd-42c4-88d0-2ccd4b0cafbb	allowed-protocol-mapper-types	saml-user-attribute-mapper
caaaab4d-136b-4a2d-917d-3fb3d6961537	785d3b4c-1fcd-42c4-88d0-2ccd4b0cafbb	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
d72130ef-4b6b-4c3c-81c3-afb385319bba	785d3b4c-1fcd-42c4-88d0-2ccd4b0cafbb	allowed-protocol-mapper-types	oidc-full-name-mapper
aa20ea72-e377-4e08-a2b1-0f38345a2586	785d3b4c-1fcd-42c4-88d0-2ccd4b0cafbb	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
70bacd25-6e5e-455c-8506-54cbd601cf85	fe6fb23f-070c-4c0d-91b5-4a35fa26b46f	algorithm	HS256
8226b3d4-434b-4756-9a43-f8e854ff5725	fe6fb23f-070c-4c0d-91b5-4a35fa26b46f	kid	2ffebf35-663d-4cbc-a1d3-48a619ce5bf8
150d254f-ae62-4907-af6e-070a7c35529b	fe6fb23f-070c-4c0d-91b5-4a35fa26b46f	priority	100
913f604d-494a-4bb8-83cb-83feb61922d1	fe6fb23f-070c-4c0d-91b5-4a35fa26b46f	secret	UayLMKivm5oMeiEHMXfnp7AmHLjKoR6oDWMbkj7MvuOOUh6lxQotlEeHnwc9sY5RMRn42G8VqW8cT11sC18V3g
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.composite_role (composite, child_role) FROM stdin;
c5426dd7-025c-47e0-86c6-e19ece396662	520ddaaf-bbec-4274-8b9b-1e4ac6466275
c5426dd7-025c-47e0-86c6-e19ece396662	e826c0e6-171b-4495-8a9e-2683b8dc43c9
c5426dd7-025c-47e0-86c6-e19ece396662	30c93ed4-00cd-4fd1-a022-7bd48e4e8408
c5426dd7-025c-47e0-86c6-e19ece396662	473d94e4-f8d6-4460-a705-011adc4b3f6e
c5426dd7-025c-47e0-86c6-e19ece396662	920d6424-3de5-45c4-9868-e8e6b7f4ed8a
c5426dd7-025c-47e0-86c6-e19ece396662	fefac6e6-22ac-4d53-9883-a3322f4369fd
c5426dd7-025c-47e0-86c6-e19ece396662	9e550ab7-1783-45a6-bb2d-cd16c20b1c30
c5426dd7-025c-47e0-86c6-e19ece396662	aeb820ab-384f-432f-9706-79f6ee56693e
c5426dd7-025c-47e0-86c6-e19ece396662	cc36fcdb-2f24-4d68-b83f-1a9722e78af0
c5426dd7-025c-47e0-86c6-e19ece396662	98147973-59fa-492c-8df1-634a05d358b0
c5426dd7-025c-47e0-86c6-e19ece396662	3c95cc4d-3707-46f6-a03f-d1e1a8e924a7
c5426dd7-025c-47e0-86c6-e19ece396662	02569414-725c-427a-9ec2-fbbeab88df54
c5426dd7-025c-47e0-86c6-e19ece396662	0baaa372-9938-443b-9531-14d15c9c2166
c5426dd7-025c-47e0-86c6-e19ece396662	9d1ccae7-3209-4f3d-b3e9-9d7fc331d7cc
c5426dd7-025c-47e0-86c6-e19ece396662	9f6aa589-512e-43a6-b16f-5d4b6fd21531
c5426dd7-025c-47e0-86c6-e19ece396662	4fc29970-93e9-418f-b648-683a44736da6
c5426dd7-025c-47e0-86c6-e19ece396662	c33dfbd1-389a-4e65-a76a-ec2f27f62761
c5426dd7-025c-47e0-86c6-e19ece396662	804016da-028f-40d8-aa51-40103a95920f
473d94e4-f8d6-4460-a705-011adc4b3f6e	804016da-028f-40d8-aa51-40103a95920f
473d94e4-f8d6-4460-a705-011adc4b3f6e	9f6aa589-512e-43a6-b16f-5d4b6fd21531
5f0608d6-e4a2-4d2b-b50f-4a61e1c848b5	2875937d-733d-4376-aaaf-8dbd8cf3c3b0
920d6424-3de5-45c4-9868-e8e6b7f4ed8a	4fc29970-93e9-418f-b648-683a44736da6
5f0608d6-e4a2-4d2b-b50f-4a61e1c848b5	30f74f9b-961f-4082-bb0c-7cd8078f3d8a
30f74f9b-961f-4082-bb0c-7cd8078f3d8a	6679b760-3012-4ea8-8ef2-cc3b2ebe3a6f
f38cb56a-95c4-45c2-af4e-09e33c08a98e	a49cc2f9-a9f1-4139-a202-124d78a48c39
c5426dd7-025c-47e0-86c6-e19ece396662	bb459247-bc93-488c-a515-4a5bf9448434
5f0608d6-e4a2-4d2b-b50f-4a61e1c848b5	5ff25442-cfc8-4412-b592-77c910366d6f
5f0608d6-e4a2-4d2b-b50f-4a61e1c848b5	bef5671e-f4d3-4a95-bbfe-3790cfeea08b
c5426dd7-025c-47e0-86c6-e19ece396662	804dae16-88bd-46cb-9a2f-3e738f9b4662
c5426dd7-025c-47e0-86c6-e19ece396662	e03856ec-c546-4ee9-b182-75d1555555d4
c5426dd7-025c-47e0-86c6-e19ece396662	592ee4f7-9370-437b-b734-31628a1ad019
c5426dd7-025c-47e0-86c6-e19ece396662	0c1ebd2c-c8fd-4667-8850-85dc6735bdc8
c5426dd7-025c-47e0-86c6-e19ece396662	182e78d4-ece2-46a3-b680-f5172ff088c3
c5426dd7-025c-47e0-86c6-e19ece396662	3266db3a-9e35-4408-bcde-6e32f293306d
c5426dd7-025c-47e0-86c6-e19ece396662	d714b12e-d993-4639-ba22-365d1a1fa7f2
c5426dd7-025c-47e0-86c6-e19ece396662	f754c89f-c540-4c7e-bf82-1cf52ade5a93
c5426dd7-025c-47e0-86c6-e19ece396662	8dbf8d35-fe3a-4114-8bd6-6ebddace0433
c5426dd7-025c-47e0-86c6-e19ece396662	e9983085-f1a7-4eab-ad50-49771dc9ef4e
c5426dd7-025c-47e0-86c6-e19ece396662	09856cb1-37d3-4157-89c0-a7dc6c7f4c50
c5426dd7-025c-47e0-86c6-e19ece396662	b2fb1cc9-382c-410a-bc4a-b950ef3264dc
c5426dd7-025c-47e0-86c6-e19ece396662	bdcbac71-805e-429a-8d7f-202574793fc3
c5426dd7-025c-47e0-86c6-e19ece396662	6cc26cde-a145-4814-9b2e-f722e31148ab
c5426dd7-025c-47e0-86c6-e19ece396662	deb7d0ad-3110-417b-8425-f05a8b87814d
c5426dd7-025c-47e0-86c6-e19ece396662	e2aad06f-d535-46ac-980e-115f8add4116
c5426dd7-025c-47e0-86c6-e19ece396662	4274384d-7e7f-4209-9dbe-1c5461527d8e
0c1ebd2c-c8fd-4667-8850-85dc6735bdc8	deb7d0ad-3110-417b-8425-f05a8b87814d
592ee4f7-9370-437b-b734-31628a1ad019	6cc26cde-a145-4814-9b2e-f722e31148ab
592ee4f7-9370-437b-b734-31628a1ad019	4274384d-7e7f-4209-9dbe-1c5461527d8e
1f1d2001-6a1e-482a-b4cf-056dc15526c0	017cca8a-c3a1-4b69-99eb-bbb221e86e8b
4c812bc2-5137-49ac-a6b7-b8703f4ec5c6	b9255dee-3b05-4b86-ba81-25dc1148954d
4c812bc2-5137-49ac-a6b7-b8703f4ec5c6	5f7c490b-cc0f-42b3-9acd-bd495f2203c5
4c812bc2-5137-49ac-a6b7-b8703f4ec5c6	9e39907e-ff42-4103-88c0-84ab0e295ada
4c812bc2-5137-49ac-a6b7-b8703f4ec5c6	7b6c0c79-796d-423c-8e45-7f3d6290fd41
4c812bc2-5137-49ac-a6b7-b8703f4ec5c6	fd23e9e2-7fba-4e0c-9324-9fe760501d15
4c812bc2-5137-49ac-a6b7-b8703f4ec5c6	3cb054cf-9dc9-46da-8696-56b855f61c42
4c812bc2-5137-49ac-a6b7-b8703f4ec5c6	cbce6aa1-c494-4901-87ee-2c5b3ccc3982
4c812bc2-5137-49ac-a6b7-b8703f4ec5c6	cf7de47a-877e-4f84-a9f2-ed7dea505fb7
4c812bc2-5137-49ac-a6b7-b8703f4ec5c6	9824f341-be36-4f62-b676-83c14ad0a85f
4c812bc2-5137-49ac-a6b7-b8703f4ec5c6	bb728a3f-6a39-4f0a-a413-496491ef1e62
4c812bc2-5137-49ac-a6b7-b8703f4ec5c6	71c98329-5a99-4830-9d2d-59bf943a4afa
4c812bc2-5137-49ac-a6b7-b8703f4ec5c6	07fc109d-89e9-433f-8e73-34c8844b5bb0
4c812bc2-5137-49ac-a6b7-b8703f4ec5c6	6f6e45ff-532d-4d09-8e94-e54e92050964
4c812bc2-5137-49ac-a6b7-b8703f4ec5c6	a59b6375-8753-4802-88e9-c4530134eb99
4c812bc2-5137-49ac-a6b7-b8703f4ec5c6	ffd3fa5f-f8cf-44f3-8aaf-459d2f8994eb
4c812bc2-5137-49ac-a6b7-b8703f4ec5c6	055c1549-fd3a-46e9-b076-fb3837dee4a5
4c812bc2-5137-49ac-a6b7-b8703f4ec5c6	8b9da6f2-1797-400e-94a3-d589fe3a7348
c5426dd7-025c-47e0-86c6-e19ece396662	922c484f-ce38-415d-9e89-8fa1459d87d1
7b6c0c79-796d-423c-8e45-7f3d6290fd41	ffd3fa5f-f8cf-44f3-8aaf-459d2f8994eb
9e39907e-ff42-4103-88c0-84ab0e295ada	a59b6375-8753-4802-88e9-c4530134eb99
9e39907e-ff42-4103-88c0-84ab0e295ada	8b9da6f2-1797-400e-94a3-d589fe3a7348
4c812bc2-5137-49ac-a6b7-b8703f4ec5c6	3b7ebdde-469a-4e59-a513-42d544f04a06
1f1d2001-6a1e-482a-b4cf-056dc15526c0	a20d55a1-31c4-40ed-92f4-c355cf23b3e2
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
454c5e4e-9b45-4cbe-8fd1-30a1329ddfe7	\N	password	18309232-af22-4cab-b783-66ff1f7b242f	1684481924380	\N	{"value":"vw8XKVCPfeVa9vTJQCxekZn4Tm9xDHiIDpsACnqsMHM=","salt":"odvj4eyr6rrW1MFYtEokPw==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
36c44e4f-0f3b-45a5-ac61-a847531f7154	\N	password	53ee06e9-e803-47ed-b1e4-7b8ea194d0dc	1684491068863	My password	{"value":"YjuXB9AUp2HVEwNNCklHKAK2BQKCx8VYYcgitagbX7c=","salt":"fSVU+0Z/18Lhfea902ykfQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2023-05-19 07:38:05.195624	1	EXECUTED	8:bda77d94bf90182a1e30c24f1c155ec7	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.16.1	\N	\N	4481874627
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2023-05-19 07:38:05.22972	2	MARK_RAN	8:1ecb330f30986693d1cba9ab579fa219	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.16.1	\N	\N	4481874627
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2023-05-19 07:38:05.598739	3	EXECUTED	8:cb7ace19bc6d959f305605d255d4c843	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.16.1	\N	\N	4481874627
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2023-05-19 07:38:05.643032	4	EXECUTED	8:80230013e961310e6872e871be424a63	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.16.1	\N	\N	4481874627
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2023-05-19 07:38:06.72432	5	EXECUTED	8:67f4c20929126adc0c8e9bf48279d244	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.16.1	\N	\N	4481874627
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2023-05-19 07:38:06.768043	6	MARK_RAN	8:7311018b0b8179ce14628ab412bb6783	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.16.1	\N	\N	4481874627
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2023-05-19 07:38:07.817376	7	EXECUTED	8:037ba1216c3640f8785ee6b8e7c8e3c1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.16.1	\N	\N	4481874627
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2023-05-19 07:38:07.84937	8	MARK_RAN	8:7fe6ffe4af4df289b3157de32c624263	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.16.1	\N	\N	4481874627
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2023-05-19 07:38:07.886132	9	EXECUTED	8:9c136bc3187083a98745c7d03bc8a303	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.16.1	\N	\N	4481874627
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2023-05-19 07:38:08.979799	10	EXECUTED	8:b5f09474dca81fb56a97cf5b6553d331	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.16.1	\N	\N	4481874627
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2023-05-19 07:38:09.501826	11	EXECUTED	8:ca924f31bd2a3b219fdcfe78c82dacf4	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.16.1	\N	\N	4481874627
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2023-05-19 07:38:09.533884	12	MARK_RAN	8:8acad7483e106416bcfa6f3b824a16cd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.16.1	\N	\N	4481874627
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2023-05-19 07:38:09.654557	13	EXECUTED	8:9b1266d17f4f87c78226f5055408fd5e	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.16.1	\N	\N	4481874627
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-05-19 07:38:09.981542	14	EXECUTED	8:d80ec4ab6dbfe573550ff72396c7e910	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.16.1	\N	\N	4481874627
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-05-19 07:38:09.992127	15	MARK_RAN	8:d86eb172171e7c20b9c849b584d147b2	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.16.1	\N	\N	4481874627
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-05-19 07:38:10.009606	16	MARK_RAN	8:5735f46f0fa60689deb0ecdc2a0dea22	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.16.1	\N	\N	4481874627
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-05-19 07:38:10.019006	17	EXECUTED	8:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.16.1	\N	\N	4481874627
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2023-05-19 07:38:10.685122	18	EXECUTED	8:5c1a8fd2014ac7fc43b90a700f117b23	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.16.1	\N	\N	4481874627
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2023-05-19 07:38:11.203652	19	EXECUTED	8:1f6c2c2dfc362aff4ed75b3f0ef6b331	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.16.1	\N	\N	4481874627
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2023-05-19 07:38:11.248723	20	EXECUTED	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.16.1	\N	\N	4481874627
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2023-05-19 07:38:11.256707	21	MARK_RAN	8:9eb2ee1fa8ad1c5e426421a6f8fdfa6a	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.16.1	\N	\N	4481874627
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2023-05-19 07:38:11.280203	22	MARK_RAN	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.16.1	\N	\N	4481874627
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2023-05-19 07:38:11.548835	23	EXECUTED	8:d9fa18ffa355320395b86270680dd4fe	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.16.1	\N	\N	4481874627
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2023-05-19 07:38:11.642754	24	EXECUTED	8:90cff506fedb06141ffc1c71c4a1214c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.16.1	\N	\N	4481874627
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2023-05-19 07:38:11.689252	25	MARK_RAN	8:11a788aed4961d6d29c427c063af828c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.16.1	\N	\N	4481874627
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2023-05-19 07:38:12.014505	26	EXECUTED	8:a4218e51e1faf380518cce2af5d39b43	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.16.1	\N	\N	4481874627
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2023-05-19 07:38:12.925974	27	EXECUTED	8:d9e9a1bfaa644da9952456050f07bbdc	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.16.1	\N	\N	4481874627
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2023-05-19 07:38:12.958807	28	EXECUTED	8:d1bf991a6163c0acbfe664b615314505	update tableName=RESOURCE_SERVER_POLICY		\N	4.16.1	\N	\N	4481874627
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2023-05-19 07:38:13.584531	29	EXECUTED	8:88a743a1e87ec5e30bf603da68058a8c	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.16.1	\N	\N	4481874627
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2023-05-19 07:38:13.696117	30	EXECUTED	8:c5517863c875d325dea463d00ec26d7a	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.16.1	\N	\N	4481874627
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2023-05-19 07:38:13.810657	31	EXECUTED	8:ada8b4833b74a498f376d7136bc7d327	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.16.1	\N	\N	4481874627
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2023-05-19 07:38:13.831239	32	EXECUTED	8:b9b73c8ea7299457f99fcbb825c263ba	customChange		\N	4.16.1	\N	\N	4481874627
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-05-19 07:38:13.851684	33	EXECUTED	8:07724333e625ccfcfc5adc63d57314f3	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.16.1	\N	\N	4481874627
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-05-19 07:38:13.859387	34	MARK_RAN	8:8b6fd445958882efe55deb26fc541a7b	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.16.1	\N	\N	4481874627
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-05-19 07:38:14.052027	35	EXECUTED	8:29b29cfebfd12600897680147277a9d7	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.16.1	\N	\N	4481874627
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2023-05-19 07:38:14.083885	36	EXECUTED	8:73ad77ca8fd0410c7f9f15a471fa52bc	addColumn tableName=REALM		\N	4.16.1	\N	\N	4481874627
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-05-19 07:38:14.132126	37	EXECUTED	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.16.1	\N	\N	4481874627
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2023-05-19 07:38:14.16698	38	EXECUTED	8:27180251182e6c31846c2ddab4bc5781	addColumn tableName=FED_USER_CONSENT		\N	4.16.1	\N	\N	4481874627
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2023-05-19 07:38:14.187417	39	EXECUTED	8:d56f201bfcfa7a1413eb3e9bc02978f9	addColumn tableName=IDENTITY_PROVIDER		\N	4.16.1	\N	\N	4481874627
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-05-19 07:38:14.20169	40	MARK_RAN	8:91f5522bf6afdc2077dfab57fbd3455c	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.16.1	\N	\N	4481874627
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-05-19 07:38:14.220389	41	MARK_RAN	8:0f01b554f256c22caeb7d8aee3a1cdc8	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.16.1	\N	\N	4481874627
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2023-05-19 07:38:14.252947	42	EXECUTED	8:ab91cf9cee415867ade0e2df9651a947	customChange		\N	4.16.1	\N	\N	4481874627
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-05-19 07:38:15.906552	43	EXECUTED	8:ceac9b1889e97d602caf373eadb0d4b7	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.16.1	\N	\N	4481874627
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2023-05-19 07:38:15.925118	44	EXECUTED	8:84b986e628fe8f7fd8fd3c275c5259f2	addColumn tableName=USER_ENTITY		\N	4.16.1	\N	\N	4481874627
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-05-19 07:38:15.949194	45	EXECUTED	8:a164ae073c56ffdbc98a615493609a52	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.16.1	\N	\N	4481874627
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-05-19 07:38:15.972077	46	EXECUTED	8:70a2b4f1f4bd4dbf487114bdb1810e64	customChange		\N	4.16.1	\N	\N	4481874627
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-05-19 07:38:15.985097	47	MARK_RAN	8:7be68b71d2f5b94b8df2e824f2860fa2	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.16.1	\N	\N	4481874627
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-05-19 07:38:16.472541	48	EXECUTED	8:bab7c631093c3861d6cf6144cd944982	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.16.1	\N	\N	4481874627
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-05-19 07:38:16.499712	49	EXECUTED	8:fa809ac11877d74d76fe40869916daad	addColumn tableName=REALM		\N	4.16.1	\N	\N	4481874627
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2023-05-19 07:38:17.021933	50	EXECUTED	8:fac23540a40208f5f5e326f6ceb4d291	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.16.1	\N	\N	4481874627
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2023-05-19 07:38:17.31874	51	EXECUTED	8:2612d1b8a97e2b5588c346e817307593	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.16.1	\N	\N	4481874627
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2023-05-19 07:38:17.348741	52	EXECUTED	8:9842f155c5db2206c88bcb5d1046e941	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.16.1	\N	\N	4481874627
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2023-05-19 07:38:17.365564	53	EXECUTED	8:2e12e06e45498406db72d5b3da5bbc76	update tableName=REALM		\N	4.16.1	\N	\N	4481874627
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2023-05-19 07:38:17.381852	54	EXECUTED	8:33560e7c7989250c40da3abdabdc75a4	update tableName=CLIENT		\N	4.16.1	\N	\N	4481874627
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-05-19 07:38:17.416095	55	EXECUTED	8:87a8d8542046817a9107c7eb9cbad1cd	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.16.1	\N	\N	4481874627
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-05-19 07:38:17.452764	56	EXECUTED	8:3ea08490a70215ed0088c273d776311e	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.16.1	\N	\N	4481874627
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-05-19 07:38:17.654888	57	EXECUTED	8:2d56697c8723d4592ab608ce14b6ed68	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.16.1	\N	\N	4481874627
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-05-19 07:38:18.72295	58	EXECUTED	8:3e423e249f6068ea2bbe48bf907f9d86	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.16.1	\N	\N	4481874627
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2023-05-19 07:38:18.958335	59	EXECUTED	8:15cabee5e5df0ff099510a0fc03e4103	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.16.1	\N	\N	4481874627
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2023-05-19 07:38:18.996814	60	EXECUTED	8:4b80200af916ac54d2ffbfc47918ab0e	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.16.1	\N	\N	4481874627
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-05-19 07:38:19.041721	61	EXECUTED	8:66564cd5e168045d52252c5027485bbb	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.16.1	\N	\N	4481874627
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-05-19 07:38:19.101844	62	EXECUTED	8:1c7064fafb030222be2bd16ccf690f6f	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.16.1	\N	\N	4481874627
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2023-05-19 07:38:19.121917	63	EXECUTED	8:2de18a0dce10cdda5c7e65c9b719b6e5	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.16.1	\N	\N	4481874627
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2023-05-19 07:38:19.152847	64	EXECUTED	8:03e413dd182dcbd5c57e41c34d0ef682	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.16.1	\N	\N	4481874627
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2023-05-19 07:38:19.17218	65	EXECUTED	8:d27b42bb2571c18fbe3fe4e4fb7582a7	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.16.1	\N	\N	4481874627
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2023-05-19 07:38:19.383244	66	EXECUTED	8:698baf84d9fd0027e9192717c2154fb8	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.16.1	\N	\N	4481874627
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2023-05-19 07:38:19.415753	67	EXECUTED	8:ced8822edf0f75ef26eb51582f9a821a	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.16.1	\N	\N	4481874627
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2023-05-19 07:38:19.438457	68	EXECUTED	8:f0abba004cf429e8afc43056df06487d	addColumn tableName=REALM		\N	4.16.1	\N	\N	4481874627
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2023-05-19 07:38:19.50683	69	EXECUTED	8:6662f8b0b611caa359fcf13bf63b4e24	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.16.1	\N	\N	4481874627
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2023-05-19 07:38:19.536731	70	EXECUTED	8:9e6b8009560f684250bdbdf97670d39e	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.16.1	\N	\N	4481874627
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2023-05-19 07:38:19.557135	71	EXECUTED	8:4223f561f3b8dc655846562b57bb502e	addColumn tableName=RESOURCE_SERVER		\N	4.16.1	\N	\N	4481874627
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-05-19 07:38:19.582718	72	EXECUTED	8:215a31c398b363ce383a2b301202f29e	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.16.1	\N	\N	4481874627
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-05-19 07:38:19.620675	73	EXECUTED	8:83f7a671792ca98b3cbd3a1a34862d3d	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.16.1	\N	\N	4481874627
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-05-19 07:38:19.635298	74	MARK_RAN	8:f58ad148698cf30707a6efbdf8061aa7	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.16.1	\N	\N	4481874627
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-05-19 07:38:19.759211	75	EXECUTED	8:79e4fd6c6442980e58d52ffc3ee7b19c	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.16.1	\N	\N	4481874627
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-05-19 07:38:19.79008	76	EXECUTED	8:87af6a1e6d241ca4b15801d1f86a297d	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.16.1	\N	\N	4481874627
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-05-19 07:38:19.80976	77	EXECUTED	8:b44f8d9b7b6ea455305a6d72a200ed15	addColumn tableName=CLIENT		\N	4.16.1	\N	\N	4481874627
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-05-19 07:38:19.823776	78	MARK_RAN	8:2d8ed5aaaeffd0cb004c046b4a903ac5	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.16.1	\N	\N	4481874627
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-05-19 07:38:19.926237	79	EXECUTED	8:e290c01fcbc275326c511633f6e2acde	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.16.1	\N	\N	4481874627
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-05-19 07:38:19.933906	80	MARK_RAN	8:c9db8784c33cea210872ac2d805439f8	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.16.1	\N	\N	4481874627
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-05-19 07:38:20.055411	81	EXECUTED	8:95b676ce8fc546a1fcfb4c92fae4add5	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.16.1	\N	\N	4481874627
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-05-19 07:38:20.070898	82	MARK_RAN	8:38a6b2a41f5651018b1aca93a41401e5	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.16.1	\N	\N	4481874627
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-05-19 07:38:20.253179	83	EXECUTED	8:3fb99bcad86a0229783123ac52f7609c	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.16.1	\N	\N	4481874627
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-05-19 07:38:20.265901	84	MARK_RAN	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.16.1	\N	\N	4481874627
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-05-19 07:38:20.32511	85	EXECUTED	8:ab4f863f39adafd4c862f7ec01890abc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.16.1	\N	\N	4481874627
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2023-05-19 07:38:20.367123	86	EXECUTED	8:13c419a0eb336e91ee3a3bf8fda6e2a7	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.16.1	\N	\N	4481874627
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-05-19 07:38:20.390193	87	EXECUTED	8:e3fb1e698e0471487f51af1ed80fe3ac	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.16.1	\N	\N	4481874627
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-05-19 07:38:20.483294	88	EXECUTED	8:babadb686aab7b56562817e60bf0abd0	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.16.1	\N	\N	4481874627
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-05-19 07:38:20.520995	89	EXECUTED	8:72d03345fda8e2f17093d08801947773	addColumn tableName=REALM; customChange		\N	4.16.1	\N	\N	4481874627
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-05-19 07:38:20.609581	90	EXECUTED	8:61c9233951bd96ffecd9ba75f7d978a4	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.16.1	\N	\N	4481874627
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-05-19 07:38:20.643437	91	EXECUTED	8:ea82e6ad945cec250af6372767b25525	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.16.1	\N	\N	4481874627
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-05-19 07:38:20.699356	92	EXECUTED	8:d3f4a33f41d960ddacd7e2ef30d126b3	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.16.1	\N	\N	4481874627
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-05-19 07:38:20.718335	93	MARK_RAN	8:1284a27fbd049d65831cb6fc07c8a783	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.16.1	\N	\N	4481874627
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-05-19 07:38:20.802943	94	EXECUTED	8:9d11b619db2ae27c25853b8a37cd0dea	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.16.1	\N	\N	4481874627
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-05-19 07:38:20.820963	95	MARK_RAN	8:3002bb3997451bb9e8bac5c5cd8d6327	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.16.1	\N	\N	4481874627
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-05-19 07:38:20.873007	96	EXECUTED	8:dfbee0d6237a23ef4ccbb7a4e063c163	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.16.1	\N	\N	4481874627
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-05-19 07:38:20.991844	97	EXECUTED	8:75f3e372df18d38c62734eebb986b960	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.16.1	\N	\N	4481874627
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-05-19 07:38:21.004757	98	MARK_RAN	8:7fee73eddf84a6035691512c85637eef	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.16.1	\N	\N	4481874627
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-05-19 07:38:21.055003	99	MARK_RAN	8:7a11134ab12820f999fbf3bb13c3adc8	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.16.1	\N	\N	4481874627
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-05-19 07:38:21.107014	100	EXECUTED	8:c0f6eaac1f3be773ffe54cb5b8482b70	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.16.1	\N	\N	4481874627
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-05-19 07:38:21.1196	101	MARK_RAN	8:18186f0008b86e0f0f49b0c4d0e842ac	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.16.1	\N	\N	4481874627
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-05-19 07:38:21.157699	102	EXECUTED	8:09c2780bcb23b310a7019d217dc7b433	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.16.1	\N	\N	4481874627
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-05-19 07:38:21.180321	103	EXECUTED	8:276a44955eab693c970a42880197fff2	customChange		\N	4.16.1	\N	\N	4481874627
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2023-05-19 07:38:21.221984	104	EXECUTED	8:ba8ee3b694d043f2bfc1a1079d0760d7	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.16.1	\N	\N	4481874627
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2023-05-19 07:38:21.253613	105	EXECUTED	8:5e06b1d75f5d17685485e610c2851b17	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.16.1	\N	\N	4481874627
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2023-05-19 07:38:21.323812	106	EXECUTED	8:4b80546c1dc550ac552ee7b24a4ab7c0	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.16.1	\N	\N	4481874627
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2023-05-19 07:38:21.34094	107	EXECUTED	8:af510cd1bb2ab6339c45372f3e491696	customChange		\N	4.16.1	\N	\N	4481874627
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2023-05-19 07:38:21.384051	108	EXECUTED	8:05c99fc610845ef66ee812b7921af0ef	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.16.1	\N	\N	4481874627
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2023-05-19 07:38:21.388542	109	MARK_RAN	8:314e803baf2f1ec315b3464e398b8247	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.16.1	\N	\N	4481874627
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2023-05-19 07:38:21.424286	110	EXECUTED	8:56e4677e7e12556f70b604c573840100	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.16.1	\N	\N	4481874627
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	c3d7e71f-2fa2-4e5d-b580-178e263f792c	f
7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	73d65881-75b5-478c-ad69-6fed31e383f3	t
7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	89e232b5-b3df-48cb-94f0-f1b03e6c68f6	t
7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	a2cc3c5f-9472-4812-975d-c545071f8522	t
7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	25a3144c-b376-4fa0-afd4-c5f3d4dd7582	f
7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	7f30c325-3de9-4f1d-a975-cc6bd870a90e	f
7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	f9065946-fcdf-4194-aa9e-75b13145f65b	t
7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	4f226a1c-ea33-44c1-ae1a-494806fa49f5	t
7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	a59dc23f-deaa-4b97-8637-9ef15abaee46	f
7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	aefc9c13-31ce-413d-a0bf-8f4e3829c40b	t
cbe1e5c7-2df6-4315-81ae-99391565cb0c	cacb555e-dc4c-4e8f-9de8-9a5d2be48c20	t
cbe1e5c7-2df6-4315-81ae-99391565cb0c	c48d3c37-4891-43f6-a435-11c608e5e49a	t
cbe1e5c7-2df6-4315-81ae-99391565cb0c	620c7619-6927-4434-b8bf-e4252a4ded7c	t
cbe1e5c7-2df6-4315-81ae-99391565cb0c	54ec3616-09a5-4a7e-8272-f4da91858b3d	t
cbe1e5c7-2df6-4315-81ae-99391565cb0c	b2ac5abd-12bb-4c38-adf4-be272a591e65	t
cbe1e5c7-2df6-4315-81ae-99391565cb0c	84e038fe-f6fc-46f2-a57f-9feb435ef80a	t
cbe1e5c7-2df6-4315-81ae-99391565cb0c	9a670f04-41ac-4da8-b039-28dce24fac15	f
cbe1e5c7-2df6-4315-81ae-99391565cb0c	f95f85af-c4cf-49d7-8dc7-985fc602a2eb	f
cbe1e5c7-2df6-4315-81ae-99391565cb0c	3194e349-b71a-43f5-99dd-9e25349e66cd	f
cbe1e5c7-2df6-4315-81ae-99391565cb0c	b5b7e586-4d77-48db-b8de-86a930ad1807	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
5f0608d6-e4a2-4d2b-b50f-4a61e1c848b5	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	f	${role_default-roles}	default-roles-master	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	\N	\N
520ddaaf-bbec-4274-8b9b-1e4ac6466275	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	f	${role_create-realm}	create-realm	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	\N	\N
e826c0e6-171b-4495-8a9e-2683b8dc43c9	be9cdd2f-9a9d-4f02-85f2-340a2921fe56	t	${role_create-client}	create-client	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	be9cdd2f-9a9d-4f02-85f2-340a2921fe56	\N
30c93ed4-00cd-4fd1-a022-7bd48e4e8408	be9cdd2f-9a9d-4f02-85f2-340a2921fe56	t	${role_view-realm}	view-realm	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	be9cdd2f-9a9d-4f02-85f2-340a2921fe56	\N
473d94e4-f8d6-4460-a705-011adc4b3f6e	be9cdd2f-9a9d-4f02-85f2-340a2921fe56	t	${role_view-users}	view-users	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	be9cdd2f-9a9d-4f02-85f2-340a2921fe56	\N
920d6424-3de5-45c4-9868-e8e6b7f4ed8a	be9cdd2f-9a9d-4f02-85f2-340a2921fe56	t	${role_view-clients}	view-clients	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	be9cdd2f-9a9d-4f02-85f2-340a2921fe56	\N
fefac6e6-22ac-4d53-9883-a3322f4369fd	be9cdd2f-9a9d-4f02-85f2-340a2921fe56	t	${role_view-events}	view-events	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	be9cdd2f-9a9d-4f02-85f2-340a2921fe56	\N
9e550ab7-1783-45a6-bb2d-cd16c20b1c30	be9cdd2f-9a9d-4f02-85f2-340a2921fe56	t	${role_view-identity-providers}	view-identity-providers	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	be9cdd2f-9a9d-4f02-85f2-340a2921fe56	\N
aeb820ab-384f-432f-9706-79f6ee56693e	be9cdd2f-9a9d-4f02-85f2-340a2921fe56	t	${role_view-authorization}	view-authorization	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	be9cdd2f-9a9d-4f02-85f2-340a2921fe56	\N
cc36fcdb-2f24-4d68-b83f-1a9722e78af0	be9cdd2f-9a9d-4f02-85f2-340a2921fe56	t	${role_manage-realm}	manage-realm	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	be9cdd2f-9a9d-4f02-85f2-340a2921fe56	\N
98147973-59fa-492c-8df1-634a05d358b0	be9cdd2f-9a9d-4f02-85f2-340a2921fe56	t	${role_manage-users}	manage-users	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	be9cdd2f-9a9d-4f02-85f2-340a2921fe56	\N
3c95cc4d-3707-46f6-a03f-d1e1a8e924a7	be9cdd2f-9a9d-4f02-85f2-340a2921fe56	t	${role_manage-clients}	manage-clients	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	be9cdd2f-9a9d-4f02-85f2-340a2921fe56	\N
02569414-725c-427a-9ec2-fbbeab88df54	be9cdd2f-9a9d-4f02-85f2-340a2921fe56	t	${role_manage-events}	manage-events	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	be9cdd2f-9a9d-4f02-85f2-340a2921fe56	\N
0baaa372-9938-443b-9531-14d15c9c2166	be9cdd2f-9a9d-4f02-85f2-340a2921fe56	t	${role_manage-identity-providers}	manage-identity-providers	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	be9cdd2f-9a9d-4f02-85f2-340a2921fe56	\N
9d1ccae7-3209-4f3d-b3e9-9d7fc331d7cc	be9cdd2f-9a9d-4f02-85f2-340a2921fe56	t	${role_manage-authorization}	manage-authorization	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	be9cdd2f-9a9d-4f02-85f2-340a2921fe56	\N
9f6aa589-512e-43a6-b16f-5d4b6fd21531	be9cdd2f-9a9d-4f02-85f2-340a2921fe56	t	${role_query-users}	query-users	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	be9cdd2f-9a9d-4f02-85f2-340a2921fe56	\N
4fc29970-93e9-418f-b648-683a44736da6	be9cdd2f-9a9d-4f02-85f2-340a2921fe56	t	${role_query-clients}	query-clients	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	be9cdd2f-9a9d-4f02-85f2-340a2921fe56	\N
c33dfbd1-389a-4e65-a76a-ec2f27f62761	be9cdd2f-9a9d-4f02-85f2-340a2921fe56	t	${role_query-realms}	query-realms	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	be9cdd2f-9a9d-4f02-85f2-340a2921fe56	\N
c5426dd7-025c-47e0-86c6-e19ece396662	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	f	${role_admin}	admin	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	\N	\N
804016da-028f-40d8-aa51-40103a95920f	be9cdd2f-9a9d-4f02-85f2-340a2921fe56	t	${role_query-groups}	query-groups	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	be9cdd2f-9a9d-4f02-85f2-340a2921fe56	\N
2875937d-733d-4376-aaaf-8dbd8cf3c3b0	5f5beba5-7c21-407e-8e8b-2f3a6cdfb19f	t	${role_view-profile}	view-profile	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	5f5beba5-7c21-407e-8e8b-2f3a6cdfb19f	\N
30f74f9b-961f-4082-bb0c-7cd8078f3d8a	5f5beba5-7c21-407e-8e8b-2f3a6cdfb19f	t	${role_manage-account}	manage-account	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	5f5beba5-7c21-407e-8e8b-2f3a6cdfb19f	\N
6679b760-3012-4ea8-8ef2-cc3b2ebe3a6f	5f5beba5-7c21-407e-8e8b-2f3a6cdfb19f	t	${role_manage-account-links}	manage-account-links	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	5f5beba5-7c21-407e-8e8b-2f3a6cdfb19f	\N
ad686ea7-98d9-462a-8b36-b52651d13ac0	5f5beba5-7c21-407e-8e8b-2f3a6cdfb19f	t	${role_view-applications}	view-applications	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	5f5beba5-7c21-407e-8e8b-2f3a6cdfb19f	\N
a49cc2f9-a9f1-4139-a202-124d78a48c39	5f5beba5-7c21-407e-8e8b-2f3a6cdfb19f	t	${role_view-consent}	view-consent	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	5f5beba5-7c21-407e-8e8b-2f3a6cdfb19f	\N
f38cb56a-95c4-45c2-af4e-09e33c08a98e	5f5beba5-7c21-407e-8e8b-2f3a6cdfb19f	t	${role_manage-consent}	manage-consent	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	5f5beba5-7c21-407e-8e8b-2f3a6cdfb19f	\N
9b75dfb3-2da1-4b0f-9fdd-82c79aec8c3c	5f5beba5-7c21-407e-8e8b-2f3a6cdfb19f	t	${role_view-groups}	view-groups	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	5f5beba5-7c21-407e-8e8b-2f3a6cdfb19f	\N
31cb7e9e-d923-4d49-9ca6-f5f968cd7d96	5f5beba5-7c21-407e-8e8b-2f3a6cdfb19f	t	${role_delete-account}	delete-account	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	5f5beba5-7c21-407e-8e8b-2f3a6cdfb19f	\N
4e0697ff-aa14-4512-8bc8-41e5fe00ed1f	d28a131d-754b-4ecb-8670-1cd69234a3b7	t	${role_read-token}	read-token	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	d28a131d-754b-4ecb-8670-1cd69234a3b7	\N
bb459247-bc93-488c-a515-4a5bf9448434	be9cdd2f-9a9d-4f02-85f2-340a2921fe56	t	${role_impersonation}	impersonation	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	be9cdd2f-9a9d-4f02-85f2-340a2921fe56	\N
5ff25442-cfc8-4412-b592-77c910366d6f	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	f	${role_offline-access}	offline_access	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	\N	\N
bef5671e-f4d3-4a95-bbfe-3790cfeea08b	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	f	${role_uma_authorization}	uma_authorization	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	\N	\N
1f1d2001-6a1e-482a-b4cf-056dc15526c0	cbe1e5c7-2df6-4315-81ae-99391565cb0c	f	${role_default-roles}	default-roles-testing-realm	cbe1e5c7-2df6-4315-81ae-99391565cb0c	\N	\N
804dae16-88bd-46cb-9a2f-3e738f9b4662	83a550b2-cfe9-4b89-8249-c5c5b0768b88	t	${role_create-client}	create-client	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	83a550b2-cfe9-4b89-8249-c5c5b0768b88	\N
e03856ec-c546-4ee9-b182-75d1555555d4	83a550b2-cfe9-4b89-8249-c5c5b0768b88	t	${role_view-realm}	view-realm	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	83a550b2-cfe9-4b89-8249-c5c5b0768b88	\N
592ee4f7-9370-437b-b734-31628a1ad019	83a550b2-cfe9-4b89-8249-c5c5b0768b88	t	${role_view-users}	view-users	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	83a550b2-cfe9-4b89-8249-c5c5b0768b88	\N
0c1ebd2c-c8fd-4667-8850-85dc6735bdc8	83a550b2-cfe9-4b89-8249-c5c5b0768b88	t	${role_view-clients}	view-clients	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	83a550b2-cfe9-4b89-8249-c5c5b0768b88	\N
182e78d4-ece2-46a3-b680-f5172ff088c3	83a550b2-cfe9-4b89-8249-c5c5b0768b88	t	${role_view-events}	view-events	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	83a550b2-cfe9-4b89-8249-c5c5b0768b88	\N
3266db3a-9e35-4408-bcde-6e32f293306d	83a550b2-cfe9-4b89-8249-c5c5b0768b88	t	${role_view-identity-providers}	view-identity-providers	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	83a550b2-cfe9-4b89-8249-c5c5b0768b88	\N
d714b12e-d993-4639-ba22-365d1a1fa7f2	83a550b2-cfe9-4b89-8249-c5c5b0768b88	t	${role_view-authorization}	view-authorization	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	83a550b2-cfe9-4b89-8249-c5c5b0768b88	\N
f754c89f-c540-4c7e-bf82-1cf52ade5a93	83a550b2-cfe9-4b89-8249-c5c5b0768b88	t	${role_manage-realm}	manage-realm	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	83a550b2-cfe9-4b89-8249-c5c5b0768b88	\N
8dbf8d35-fe3a-4114-8bd6-6ebddace0433	83a550b2-cfe9-4b89-8249-c5c5b0768b88	t	${role_manage-users}	manage-users	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	83a550b2-cfe9-4b89-8249-c5c5b0768b88	\N
e9983085-f1a7-4eab-ad50-49771dc9ef4e	83a550b2-cfe9-4b89-8249-c5c5b0768b88	t	${role_manage-clients}	manage-clients	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	83a550b2-cfe9-4b89-8249-c5c5b0768b88	\N
09856cb1-37d3-4157-89c0-a7dc6c7f4c50	83a550b2-cfe9-4b89-8249-c5c5b0768b88	t	${role_manage-events}	manage-events	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	83a550b2-cfe9-4b89-8249-c5c5b0768b88	\N
b2fb1cc9-382c-410a-bc4a-b950ef3264dc	83a550b2-cfe9-4b89-8249-c5c5b0768b88	t	${role_manage-identity-providers}	manage-identity-providers	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	83a550b2-cfe9-4b89-8249-c5c5b0768b88	\N
bdcbac71-805e-429a-8d7f-202574793fc3	83a550b2-cfe9-4b89-8249-c5c5b0768b88	t	${role_manage-authorization}	manage-authorization	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	83a550b2-cfe9-4b89-8249-c5c5b0768b88	\N
6cc26cde-a145-4814-9b2e-f722e31148ab	83a550b2-cfe9-4b89-8249-c5c5b0768b88	t	${role_query-users}	query-users	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	83a550b2-cfe9-4b89-8249-c5c5b0768b88	\N
deb7d0ad-3110-417b-8425-f05a8b87814d	83a550b2-cfe9-4b89-8249-c5c5b0768b88	t	${role_query-clients}	query-clients	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	83a550b2-cfe9-4b89-8249-c5c5b0768b88	\N
e2aad06f-d535-46ac-980e-115f8add4116	83a550b2-cfe9-4b89-8249-c5c5b0768b88	t	${role_query-realms}	query-realms	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	83a550b2-cfe9-4b89-8249-c5c5b0768b88	\N
4274384d-7e7f-4209-9dbe-1c5461527d8e	83a550b2-cfe9-4b89-8249-c5c5b0768b88	t	${role_query-groups}	query-groups	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	83a550b2-cfe9-4b89-8249-c5c5b0768b88	\N
017cca8a-c3a1-4b69-99eb-bbb221e86e8b	cbe1e5c7-2df6-4315-81ae-99391565cb0c	f	${role_offline-access}	offline_access	cbe1e5c7-2df6-4315-81ae-99391565cb0c	\N	\N
1d13458b-e378-48f8-b124-12c54c745c48	ab8b4126-c57b-4569-92ff-b29d9111aca3	t	\N	manage-account	cbe1e5c7-2df6-4315-81ae-99391565cb0c	ab8b4126-c57b-4569-92ff-b29d9111aca3	\N
0bd9e065-2fe0-4fd5-b08d-da1df27f4e29	ab8b4126-c57b-4569-92ff-b29d9111aca3	t	\N	view-groups	cbe1e5c7-2df6-4315-81ae-99391565cb0c	ab8b4126-c57b-4569-92ff-b29d9111aca3	\N
4c812bc2-5137-49ac-a6b7-b8703f4ec5c6	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	t	${role_realm-admin}	realm-admin	cbe1e5c7-2df6-4315-81ae-99391565cb0c	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	\N
b9255dee-3b05-4b86-ba81-25dc1148954d	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	t	${role_create-client}	create-client	cbe1e5c7-2df6-4315-81ae-99391565cb0c	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	\N
5f7c490b-cc0f-42b3-9acd-bd495f2203c5	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	t	${role_view-realm}	view-realm	cbe1e5c7-2df6-4315-81ae-99391565cb0c	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	\N
9e39907e-ff42-4103-88c0-84ab0e295ada	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	t	${role_view-users}	view-users	cbe1e5c7-2df6-4315-81ae-99391565cb0c	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	\N
7b6c0c79-796d-423c-8e45-7f3d6290fd41	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	t	${role_view-clients}	view-clients	cbe1e5c7-2df6-4315-81ae-99391565cb0c	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	\N
fd23e9e2-7fba-4e0c-9324-9fe760501d15	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	t	${role_view-events}	view-events	cbe1e5c7-2df6-4315-81ae-99391565cb0c	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	\N
3cb054cf-9dc9-46da-8696-56b855f61c42	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	t	${role_view-identity-providers}	view-identity-providers	cbe1e5c7-2df6-4315-81ae-99391565cb0c	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	\N
cbce6aa1-c494-4901-87ee-2c5b3ccc3982	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	t	${role_view-authorization}	view-authorization	cbe1e5c7-2df6-4315-81ae-99391565cb0c	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	\N
cf7de47a-877e-4f84-a9f2-ed7dea505fb7	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	t	${role_manage-realm}	manage-realm	cbe1e5c7-2df6-4315-81ae-99391565cb0c	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	\N
9824f341-be36-4f62-b676-83c14ad0a85f	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	t	${role_manage-users}	manage-users	cbe1e5c7-2df6-4315-81ae-99391565cb0c	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	\N
bb728a3f-6a39-4f0a-a413-496491ef1e62	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	t	${role_manage-clients}	manage-clients	cbe1e5c7-2df6-4315-81ae-99391565cb0c	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	\N
71c98329-5a99-4830-9d2d-59bf943a4afa	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	t	${role_manage-events}	manage-events	cbe1e5c7-2df6-4315-81ae-99391565cb0c	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	\N
07fc109d-89e9-433f-8e73-34c8844b5bb0	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	t	${role_manage-identity-providers}	manage-identity-providers	cbe1e5c7-2df6-4315-81ae-99391565cb0c	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	\N
6f6e45ff-532d-4d09-8e94-e54e92050964	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	t	${role_manage-authorization}	manage-authorization	cbe1e5c7-2df6-4315-81ae-99391565cb0c	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	\N
a59b6375-8753-4802-88e9-c4530134eb99	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	t	${role_query-users}	query-users	cbe1e5c7-2df6-4315-81ae-99391565cb0c	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	\N
ffd3fa5f-f8cf-44f3-8aaf-459d2f8994eb	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	t	${role_query-clients}	query-clients	cbe1e5c7-2df6-4315-81ae-99391565cb0c	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	\N
055c1549-fd3a-46e9-b076-fb3837dee4a5	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	t	${role_query-realms}	query-realms	cbe1e5c7-2df6-4315-81ae-99391565cb0c	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	\N
8b9da6f2-1797-400e-94a3-d589fe3a7348	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	t	${role_query-groups}	query-groups	cbe1e5c7-2df6-4315-81ae-99391565cb0c	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	\N
922c484f-ce38-415d-9e89-8fa1459d87d1	83a550b2-cfe9-4b89-8249-c5c5b0768b88	t	${role_impersonation}	impersonation	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	83a550b2-cfe9-4b89-8249-c5c5b0768b88	\N
3b7ebdde-469a-4e59-a513-42d544f04a06	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	t	${role_impersonation}	impersonation	cbe1e5c7-2df6-4315-81ae-99391565cb0c	7ab6de4e-eb0a-4065-b68c-697bc5a347a4	\N
36d72bfd-e9fc-40b7-abb7-0f0ae8f73405	ab8b4126-c57b-4569-92ff-b29d9111aca3	t	${role_delete-account}	delete-account	cbe1e5c7-2df6-4315-81ae-99391565cb0c	ab8b4126-c57b-4569-92ff-b29d9111aca3	\N
a20d55a1-31c4-40ed-92f4-c355cf23b3e2	cbe1e5c7-2df6-4315-81ae-99391565cb0c	f	${role_uma_authorization}	uma_authorization	cbe1e5c7-2df6-4315-81ae-99391565cb0c	\N	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migration_model (id, version, update_time) FROM stdin;
sqzzw	21.0.1	1684481902
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
e8b6ec3a-05bb-4403-9930-146dae145a28	audience resolve	openid-connect	oidc-audience-resolve-mapper	bc637500-577a-4a27-8195-332e353992b2	\N
26ceac35-2b5a-4bd4-a620-0d09cc7bf431	locale	openid-connect	oidc-usermodel-attribute-mapper	d69e5f30-203e-41ae-a726-1f8948a43de6	\N
4c741807-d2de-491f-abdb-2e51f20ce32a	role list	saml	saml-role-list-mapper	\N	73d65881-75b5-478c-ad69-6fed31e383f3
86cb7de5-9a64-4cd2-af7b-d8776685b6c1	full name	openid-connect	oidc-full-name-mapper	\N	89e232b5-b3df-48cb-94f0-f1b03e6c68f6
c35f2647-6730-4a4a-a336-35bb6add15cc	family name	openid-connect	oidc-usermodel-property-mapper	\N	89e232b5-b3df-48cb-94f0-f1b03e6c68f6
b7ad9d19-32ff-4dcb-83d8-5119164e1864	given name	openid-connect	oidc-usermodel-property-mapper	\N	89e232b5-b3df-48cb-94f0-f1b03e6c68f6
fb844bff-cb33-416e-a0e7-618f7116628f	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	89e232b5-b3df-48cb-94f0-f1b03e6c68f6
2fe79508-c7aa-4fa1-a335-0de63f5cc89f	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	89e232b5-b3df-48cb-94f0-f1b03e6c68f6
bea34fd7-68cf-47eb-8be4-0ff9d4cf3486	username	openid-connect	oidc-usermodel-property-mapper	\N	89e232b5-b3df-48cb-94f0-f1b03e6c68f6
c31d3032-db26-47be-b4f0-7d2cb75a5033	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	89e232b5-b3df-48cb-94f0-f1b03e6c68f6
c0ad4295-3f9b-4b10-9297-f6600286b878	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	89e232b5-b3df-48cb-94f0-f1b03e6c68f6
3bb61027-9808-4cad-aa5e-1c4a0b99eec3	website	openid-connect	oidc-usermodel-attribute-mapper	\N	89e232b5-b3df-48cb-94f0-f1b03e6c68f6
44dff726-f0ae-415c-a07d-ce37b02f3118	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	89e232b5-b3df-48cb-94f0-f1b03e6c68f6
4af35102-a850-4bb9-81d6-573bdddbed55	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	89e232b5-b3df-48cb-94f0-f1b03e6c68f6
65ced580-597e-45c3-b14e-601bd3812050	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	89e232b5-b3df-48cb-94f0-f1b03e6c68f6
8173eeea-8535-4af3-b1c8-2d582431dfcc	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	89e232b5-b3df-48cb-94f0-f1b03e6c68f6
42de2e0a-5fc2-41ad-9a4a-d9ed51e8c784	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	89e232b5-b3df-48cb-94f0-f1b03e6c68f6
144c06d9-5524-48b4-af7a-0b239679dca1	email	openid-connect	oidc-usermodel-property-mapper	\N	a2cc3c5f-9472-4812-975d-c545071f8522
61ebf7de-c314-45d3-814f-0c246d615164	email verified	openid-connect	oidc-usermodel-property-mapper	\N	a2cc3c5f-9472-4812-975d-c545071f8522
6b6cc559-1f2f-457f-868b-567c29913971	address	openid-connect	oidc-address-mapper	\N	25a3144c-b376-4fa0-afd4-c5f3d4dd7582
7e3b2f3d-3a8c-4d31-9773-b64f0d4d93f3	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	7f30c325-3de9-4f1d-a975-cc6bd870a90e
9fcd36e6-6b91-4f6f-9c0e-23eba7802257	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	7f30c325-3de9-4f1d-a975-cc6bd870a90e
3efc2f6d-50ff-4bb3-b780-e3dac94d8abd	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	f9065946-fcdf-4194-aa9e-75b13145f65b
932850a7-865e-49f9-ae9d-3c59a3237a4a	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	f9065946-fcdf-4194-aa9e-75b13145f65b
a24695fa-538e-4a43-892a-d1a17afc2592	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	f9065946-fcdf-4194-aa9e-75b13145f65b
2b0104c2-278b-4445-921a-41c0defde16c	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	4f226a1c-ea33-44c1-ae1a-494806fa49f5
7c748c7a-4228-44c9-92aa-2dc25222bccb	upn	openid-connect	oidc-usermodel-property-mapper	\N	a59dc23f-deaa-4b97-8637-9ef15abaee46
c2cfe0cd-f198-4abd-9dd5-6d40f8a16417	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	a59dc23f-deaa-4b97-8637-9ef15abaee46
c4a05d6a-a648-4bce-b0d1-0f3ab6905cf5	acr loa level	openid-connect	oidc-acr-mapper	\N	aefc9c13-31ce-413d-a0bf-8f4e3829c40b
fb5d1aa2-f95d-4cd7-8cda-04230f24430e	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	3194e349-b71a-43f5-99dd-9e25349e66cd
61157357-a26b-4250-a109-bd535ff52c8d	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	3194e349-b71a-43f5-99dd-9e25349e66cd
f6d3988c-5cd4-46a3-9901-83581220f0ac	acr loa level	openid-connect	oidc-acr-mapper	\N	84e038fe-f6fc-46f2-a57f-9feb435ef80a
dcab7443-c193-41a8-ad06-84fe12bb24c7	role list	saml	saml-role-list-mapper	\N	cacb555e-dc4c-4e8f-9de8-9a5d2be48c20
983b2242-7dc0-42b2-a18b-e6bda4c273d4	email verified	openid-connect	oidc-usermodel-property-mapper	\N	620c7619-6927-4434-b8bf-e4252a4ded7c
63b21a58-1558-42c9-a5c7-f41b90bb1261	email	openid-connect	oidc-usermodel-property-mapper	\N	620c7619-6927-4434-b8bf-e4252a4ded7c
0e3de0a2-4965-484b-a34b-9c9ac04ba2e8	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	c48d3c37-4891-43f6-a435-11c608e5e49a
ed581c7d-8843-44ff-9ee2-3e5d02338582	website	openid-connect	oidc-usermodel-attribute-mapper	\N	c48d3c37-4891-43f6-a435-11c608e5e49a
1c2b634d-2e8d-4ded-a6aa-76bbe9d30142	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	c48d3c37-4891-43f6-a435-11c608e5e49a
b4f198fa-26d6-4f21-a3ee-4455739fe597	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	c48d3c37-4891-43f6-a435-11c608e5e49a
8b20e01c-e40a-4bc3-abaa-6734a4a370ce	full name	openid-connect	oidc-full-name-mapper	\N	c48d3c37-4891-43f6-a435-11c608e5e49a
dd07e2ab-c3a9-44fb-8861-9b6b869f9e67	username	openid-connect	oidc-usermodel-property-mapper	\N	c48d3c37-4891-43f6-a435-11c608e5e49a
466f2112-81d3-40ac-883b-55777991f68a	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	c48d3c37-4891-43f6-a435-11c608e5e49a
3ba2330d-3edb-4b5a-b213-a5a84dec62cc	given name	openid-connect	oidc-usermodel-property-mapper	\N	c48d3c37-4891-43f6-a435-11c608e5e49a
6128fc64-e45e-42a9-afbf-9effe649cf9a	family name	openid-connect	oidc-usermodel-property-mapper	\N	c48d3c37-4891-43f6-a435-11c608e5e49a
8c04726e-25c0-45c3-b0a3-574923eef192	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	c48d3c37-4891-43f6-a435-11c608e5e49a
f6c07292-5664-4555-92c7-b1f9d309d38b	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	c48d3c37-4891-43f6-a435-11c608e5e49a
5ab42e7a-c3db-4476-a010-fa27fc46672b	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	c48d3c37-4891-43f6-a435-11c608e5e49a
8c48ea49-8927-4ff8-9fb2-0aed9c0cbaee	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	c48d3c37-4891-43f6-a435-11c608e5e49a
e51a4931-10ae-4fbd-a599-64fc582a5555	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	c48d3c37-4891-43f6-a435-11c608e5e49a
ec27a269-a743-4902-be6a-597144b0a36a	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	b5b7e586-4d77-48db-b8de-86a930ad1807
87a0b789-e2fc-44ea-9a14-45532aef41ed	upn	openid-connect	oidc-usermodel-property-mapper	\N	b5b7e586-4d77-48db-b8de-86a930ad1807
3002fb74-e5c5-4cf5-94d8-9283c243de4a	address	openid-connect	oidc-address-mapper	\N	f95f85af-c4cf-49d7-8dc7-985fc602a2eb
57e46265-8068-4aa5-9d18-21f69f990fc3	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	54ec3616-09a5-4a7e-8272-f4da91858b3d
d72f2de9-7ff6-4926-9850-0c7f0b560dbc	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	54ec3616-09a5-4a7e-8272-f4da91858b3d
06f4c5ff-9f7c-46ba-b385-41921f6b0539	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	54ec3616-09a5-4a7e-8272-f4da91858b3d
decda156-9acb-4a7f-a639-ffd1078a96b2	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	b2ac5abd-12bb-4c38-adf4-be272a591e65
685569ae-100b-4e1a-82a6-dd5abc723e37	audience resolve	openid-connect	oidc-audience-resolve-mapper	5847a1f9-bc56-44b8-b548-dc9e6c50a883	\N
d5c32a67-ceb3-4656-b469-effb810187db	locale	openid-connect	oidc-usermodel-attribute-mapper	7f05ba07-4dfd-4d20-8593-77ba24fb858a	\N
00cb1e8e-09c0-40c8-a726-412ed6ea43e7	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	e7abce3a-f802-40e3-bfe2-9b3c5d306c72	\N
2c3d6932-0e04-47c2-b383-74c650d9e3ae	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	e7abce3a-f802-40e3-bfe2-9b3c5d306c72	\N
00605667-4f75-4171-a65b-eb29ab52b54d	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	e7abce3a-f802-40e3-bfe2-9b3c5d306c72	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
26ceac35-2b5a-4bd4-a620-0d09cc7bf431	true	userinfo.token.claim
26ceac35-2b5a-4bd4-a620-0d09cc7bf431	locale	user.attribute
26ceac35-2b5a-4bd4-a620-0d09cc7bf431	true	id.token.claim
26ceac35-2b5a-4bd4-a620-0d09cc7bf431	true	access.token.claim
26ceac35-2b5a-4bd4-a620-0d09cc7bf431	locale	claim.name
26ceac35-2b5a-4bd4-a620-0d09cc7bf431	String	jsonType.label
4c741807-d2de-491f-abdb-2e51f20ce32a	false	single
4c741807-d2de-491f-abdb-2e51f20ce32a	Basic	attribute.nameformat
4c741807-d2de-491f-abdb-2e51f20ce32a	Role	attribute.name
2fe79508-c7aa-4fa1-a335-0de63f5cc89f	true	userinfo.token.claim
2fe79508-c7aa-4fa1-a335-0de63f5cc89f	nickname	user.attribute
2fe79508-c7aa-4fa1-a335-0de63f5cc89f	true	id.token.claim
2fe79508-c7aa-4fa1-a335-0de63f5cc89f	true	access.token.claim
2fe79508-c7aa-4fa1-a335-0de63f5cc89f	nickname	claim.name
2fe79508-c7aa-4fa1-a335-0de63f5cc89f	String	jsonType.label
3bb61027-9808-4cad-aa5e-1c4a0b99eec3	true	userinfo.token.claim
3bb61027-9808-4cad-aa5e-1c4a0b99eec3	website	user.attribute
3bb61027-9808-4cad-aa5e-1c4a0b99eec3	true	id.token.claim
3bb61027-9808-4cad-aa5e-1c4a0b99eec3	true	access.token.claim
3bb61027-9808-4cad-aa5e-1c4a0b99eec3	website	claim.name
3bb61027-9808-4cad-aa5e-1c4a0b99eec3	String	jsonType.label
42de2e0a-5fc2-41ad-9a4a-d9ed51e8c784	true	userinfo.token.claim
42de2e0a-5fc2-41ad-9a4a-d9ed51e8c784	updatedAt	user.attribute
42de2e0a-5fc2-41ad-9a4a-d9ed51e8c784	true	id.token.claim
42de2e0a-5fc2-41ad-9a4a-d9ed51e8c784	true	access.token.claim
42de2e0a-5fc2-41ad-9a4a-d9ed51e8c784	updated_at	claim.name
42de2e0a-5fc2-41ad-9a4a-d9ed51e8c784	long	jsonType.label
44dff726-f0ae-415c-a07d-ce37b02f3118	true	userinfo.token.claim
44dff726-f0ae-415c-a07d-ce37b02f3118	gender	user.attribute
44dff726-f0ae-415c-a07d-ce37b02f3118	true	id.token.claim
44dff726-f0ae-415c-a07d-ce37b02f3118	true	access.token.claim
44dff726-f0ae-415c-a07d-ce37b02f3118	gender	claim.name
44dff726-f0ae-415c-a07d-ce37b02f3118	String	jsonType.label
4af35102-a850-4bb9-81d6-573bdddbed55	true	userinfo.token.claim
4af35102-a850-4bb9-81d6-573bdddbed55	birthdate	user.attribute
4af35102-a850-4bb9-81d6-573bdddbed55	true	id.token.claim
4af35102-a850-4bb9-81d6-573bdddbed55	true	access.token.claim
4af35102-a850-4bb9-81d6-573bdddbed55	birthdate	claim.name
4af35102-a850-4bb9-81d6-573bdddbed55	String	jsonType.label
65ced580-597e-45c3-b14e-601bd3812050	true	userinfo.token.claim
65ced580-597e-45c3-b14e-601bd3812050	zoneinfo	user.attribute
65ced580-597e-45c3-b14e-601bd3812050	true	id.token.claim
65ced580-597e-45c3-b14e-601bd3812050	true	access.token.claim
65ced580-597e-45c3-b14e-601bd3812050	zoneinfo	claim.name
65ced580-597e-45c3-b14e-601bd3812050	String	jsonType.label
8173eeea-8535-4af3-b1c8-2d582431dfcc	true	userinfo.token.claim
8173eeea-8535-4af3-b1c8-2d582431dfcc	locale	user.attribute
8173eeea-8535-4af3-b1c8-2d582431dfcc	true	id.token.claim
8173eeea-8535-4af3-b1c8-2d582431dfcc	true	access.token.claim
8173eeea-8535-4af3-b1c8-2d582431dfcc	locale	claim.name
8173eeea-8535-4af3-b1c8-2d582431dfcc	String	jsonType.label
86cb7de5-9a64-4cd2-af7b-d8776685b6c1	true	userinfo.token.claim
86cb7de5-9a64-4cd2-af7b-d8776685b6c1	true	id.token.claim
86cb7de5-9a64-4cd2-af7b-d8776685b6c1	true	access.token.claim
b7ad9d19-32ff-4dcb-83d8-5119164e1864	true	userinfo.token.claim
b7ad9d19-32ff-4dcb-83d8-5119164e1864	firstName	user.attribute
b7ad9d19-32ff-4dcb-83d8-5119164e1864	true	id.token.claim
b7ad9d19-32ff-4dcb-83d8-5119164e1864	true	access.token.claim
b7ad9d19-32ff-4dcb-83d8-5119164e1864	given_name	claim.name
b7ad9d19-32ff-4dcb-83d8-5119164e1864	String	jsonType.label
bea34fd7-68cf-47eb-8be4-0ff9d4cf3486	true	userinfo.token.claim
bea34fd7-68cf-47eb-8be4-0ff9d4cf3486	username	user.attribute
bea34fd7-68cf-47eb-8be4-0ff9d4cf3486	true	id.token.claim
bea34fd7-68cf-47eb-8be4-0ff9d4cf3486	true	access.token.claim
bea34fd7-68cf-47eb-8be4-0ff9d4cf3486	preferred_username	claim.name
bea34fd7-68cf-47eb-8be4-0ff9d4cf3486	String	jsonType.label
c0ad4295-3f9b-4b10-9297-f6600286b878	true	userinfo.token.claim
c0ad4295-3f9b-4b10-9297-f6600286b878	picture	user.attribute
c0ad4295-3f9b-4b10-9297-f6600286b878	true	id.token.claim
c0ad4295-3f9b-4b10-9297-f6600286b878	true	access.token.claim
c0ad4295-3f9b-4b10-9297-f6600286b878	picture	claim.name
c0ad4295-3f9b-4b10-9297-f6600286b878	String	jsonType.label
c31d3032-db26-47be-b4f0-7d2cb75a5033	true	userinfo.token.claim
c31d3032-db26-47be-b4f0-7d2cb75a5033	profile	user.attribute
c31d3032-db26-47be-b4f0-7d2cb75a5033	true	id.token.claim
c31d3032-db26-47be-b4f0-7d2cb75a5033	true	access.token.claim
c31d3032-db26-47be-b4f0-7d2cb75a5033	profile	claim.name
c31d3032-db26-47be-b4f0-7d2cb75a5033	String	jsonType.label
c35f2647-6730-4a4a-a336-35bb6add15cc	true	userinfo.token.claim
c35f2647-6730-4a4a-a336-35bb6add15cc	lastName	user.attribute
c35f2647-6730-4a4a-a336-35bb6add15cc	true	id.token.claim
c35f2647-6730-4a4a-a336-35bb6add15cc	true	access.token.claim
c35f2647-6730-4a4a-a336-35bb6add15cc	family_name	claim.name
c35f2647-6730-4a4a-a336-35bb6add15cc	String	jsonType.label
fb844bff-cb33-416e-a0e7-618f7116628f	true	userinfo.token.claim
fb844bff-cb33-416e-a0e7-618f7116628f	middleName	user.attribute
fb844bff-cb33-416e-a0e7-618f7116628f	true	id.token.claim
fb844bff-cb33-416e-a0e7-618f7116628f	true	access.token.claim
fb844bff-cb33-416e-a0e7-618f7116628f	middle_name	claim.name
fb844bff-cb33-416e-a0e7-618f7116628f	String	jsonType.label
144c06d9-5524-48b4-af7a-0b239679dca1	true	userinfo.token.claim
144c06d9-5524-48b4-af7a-0b239679dca1	email	user.attribute
144c06d9-5524-48b4-af7a-0b239679dca1	true	id.token.claim
144c06d9-5524-48b4-af7a-0b239679dca1	true	access.token.claim
144c06d9-5524-48b4-af7a-0b239679dca1	email	claim.name
144c06d9-5524-48b4-af7a-0b239679dca1	String	jsonType.label
61ebf7de-c314-45d3-814f-0c246d615164	true	userinfo.token.claim
61ebf7de-c314-45d3-814f-0c246d615164	emailVerified	user.attribute
61ebf7de-c314-45d3-814f-0c246d615164	true	id.token.claim
61ebf7de-c314-45d3-814f-0c246d615164	true	access.token.claim
61ebf7de-c314-45d3-814f-0c246d615164	email_verified	claim.name
61ebf7de-c314-45d3-814f-0c246d615164	boolean	jsonType.label
6b6cc559-1f2f-457f-868b-567c29913971	formatted	user.attribute.formatted
6b6cc559-1f2f-457f-868b-567c29913971	country	user.attribute.country
6b6cc559-1f2f-457f-868b-567c29913971	postal_code	user.attribute.postal_code
6b6cc559-1f2f-457f-868b-567c29913971	true	userinfo.token.claim
6b6cc559-1f2f-457f-868b-567c29913971	street	user.attribute.street
6b6cc559-1f2f-457f-868b-567c29913971	true	id.token.claim
6b6cc559-1f2f-457f-868b-567c29913971	region	user.attribute.region
6b6cc559-1f2f-457f-868b-567c29913971	true	access.token.claim
6b6cc559-1f2f-457f-868b-567c29913971	locality	user.attribute.locality
7e3b2f3d-3a8c-4d31-9773-b64f0d4d93f3	true	userinfo.token.claim
7e3b2f3d-3a8c-4d31-9773-b64f0d4d93f3	phoneNumber	user.attribute
7e3b2f3d-3a8c-4d31-9773-b64f0d4d93f3	true	id.token.claim
7e3b2f3d-3a8c-4d31-9773-b64f0d4d93f3	true	access.token.claim
7e3b2f3d-3a8c-4d31-9773-b64f0d4d93f3	phone_number	claim.name
7e3b2f3d-3a8c-4d31-9773-b64f0d4d93f3	String	jsonType.label
9fcd36e6-6b91-4f6f-9c0e-23eba7802257	true	userinfo.token.claim
9fcd36e6-6b91-4f6f-9c0e-23eba7802257	phoneNumberVerified	user.attribute
9fcd36e6-6b91-4f6f-9c0e-23eba7802257	true	id.token.claim
9fcd36e6-6b91-4f6f-9c0e-23eba7802257	true	access.token.claim
9fcd36e6-6b91-4f6f-9c0e-23eba7802257	phone_number_verified	claim.name
9fcd36e6-6b91-4f6f-9c0e-23eba7802257	boolean	jsonType.label
3efc2f6d-50ff-4bb3-b780-e3dac94d8abd	true	multivalued
3efc2f6d-50ff-4bb3-b780-e3dac94d8abd	foo	user.attribute
3efc2f6d-50ff-4bb3-b780-e3dac94d8abd	true	access.token.claim
3efc2f6d-50ff-4bb3-b780-e3dac94d8abd	realm_access.roles	claim.name
3efc2f6d-50ff-4bb3-b780-e3dac94d8abd	String	jsonType.label
932850a7-865e-49f9-ae9d-3c59a3237a4a	true	multivalued
932850a7-865e-49f9-ae9d-3c59a3237a4a	foo	user.attribute
932850a7-865e-49f9-ae9d-3c59a3237a4a	true	access.token.claim
932850a7-865e-49f9-ae9d-3c59a3237a4a	resource_access.${client_id}.roles	claim.name
932850a7-865e-49f9-ae9d-3c59a3237a4a	String	jsonType.label
7c748c7a-4228-44c9-92aa-2dc25222bccb	true	userinfo.token.claim
7c748c7a-4228-44c9-92aa-2dc25222bccb	username	user.attribute
7c748c7a-4228-44c9-92aa-2dc25222bccb	true	id.token.claim
7c748c7a-4228-44c9-92aa-2dc25222bccb	true	access.token.claim
7c748c7a-4228-44c9-92aa-2dc25222bccb	upn	claim.name
7c748c7a-4228-44c9-92aa-2dc25222bccb	String	jsonType.label
c2cfe0cd-f198-4abd-9dd5-6d40f8a16417	true	multivalued
c2cfe0cd-f198-4abd-9dd5-6d40f8a16417	foo	user.attribute
c2cfe0cd-f198-4abd-9dd5-6d40f8a16417	true	id.token.claim
c2cfe0cd-f198-4abd-9dd5-6d40f8a16417	true	access.token.claim
c2cfe0cd-f198-4abd-9dd5-6d40f8a16417	groups	claim.name
c2cfe0cd-f198-4abd-9dd5-6d40f8a16417	String	jsonType.label
c4a05d6a-a648-4bce-b0d1-0f3ab6905cf5	true	id.token.claim
c4a05d6a-a648-4bce-b0d1-0f3ab6905cf5	true	access.token.claim
61157357-a26b-4250-a109-bd535ff52c8d	true	userinfo.token.claim
61157357-a26b-4250-a109-bd535ff52c8d	phoneNumber	user.attribute
61157357-a26b-4250-a109-bd535ff52c8d	true	id.token.claim
61157357-a26b-4250-a109-bd535ff52c8d	true	access.token.claim
61157357-a26b-4250-a109-bd535ff52c8d	phone_number	claim.name
61157357-a26b-4250-a109-bd535ff52c8d	String	jsonType.label
fb5d1aa2-f95d-4cd7-8cda-04230f24430e	true	userinfo.token.claim
fb5d1aa2-f95d-4cd7-8cda-04230f24430e	phoneNumberVerified	user.attribute
fb5d1aa2-f95d-4cd7-8cda-04230f24430e	true	id.token.claim
fb5d1aa2-f95d-4cd7-8cda-04230f24430e	true	access.token.claim
fb5d1aa2-f95d-4cd7-8cda-04230f24430e	phone_number_verified	claim.name
fb5d1aa2-f95d-4cd7-8cda-04230f24430e	boolean	jsonType.label
f6d3988c-5cd4-46a3-9901-83581220f0ac	true	id.token.claim
f6d3988c-5cd4-46a3-9901-83581220f0ac	true	access.token.claim
f6d3988c-5cd4-46a3-9901-83581220f0ac	true	userinfo.token.claim
dcab7443-c193-41a8-ad06-84fe12bb24c7	false	single
dcab7443-c193-41a8-ad06-84fe12bb24c7	Basic	attribute.nameformat
dcab7443-c193-41a8-ad06-84fe12bb24c7	Role	attribute.name
63b21a58-1558-42c9-a5c7-f41b90bb1261	true	userinfo.token.claim
63b21a58-1558-42c9-a5c7-f41b90bb1261	email	user.attribute
63b21a58-1558-42c9-a5c7-f41b90bb1261	true	id.token.claim
63b21a58-1558-42c9-a5c7-f41b90bb1261	true	access.token.claim
63b21a58-1558-42c9-a5c7-f41b90bb1261	email	claim.name
63b21a58-1558-42c9-a5c7-f41b90bb1261	String	jsonType.label
983b2242-7dc0-42b2-a18b-e6bda4c273d4	true	userinfo.token.claim
983b2242-7dc0-42b2-a18b-e6bda4c273d4	emailVerified	user.attribute
983b2242-7dc0-42b2-a18b-e6bda4c273d4	true	id.token.claim
983b2242-7dc0-42b2-a18b-e6bda4c273d4	true	access.token.claim
983b2242-7dc0-42b2-a18b-e6bda4c273d4	email_verified	claim.name
983b2242-7dc0-42b2-a18b-e6bda4c273d4	boolean	jsonType.label
0e3de0a2-4965-484b-a34b-9c9ac04ba2e8	true	userinfo.token.claim
0e3de0a2-4965-484b-a34b-9c9ac04ba2e8	middleName	user.attribute
0e3de0a2-4965-484b-a34b-9c9ac04ba2e8	true	id.token.claim
0e3de0a2-4965-484b-a34b-9c9ac04ba2e8	true	access.token.claim
0e3de0a2-4965-484b-a34b-9c9ac04ba2e8	middle_name	claim.name
0e3de0a2-4965-484b-a34b-9c9ac04ba2e8	String	jsonType.label
1c2b634d-2e8d-4ded-a6aa-76bbe9d30142	true	userinfo.token.claim
1c2b634d-2e8d-4ded-a6aa-76bbe9d30142	zoneinfo	user.attribute
1c2b634d-2e8d-4ded-a6aa-76bbe9d30142	true	id.token.claim
1c2b634d-2e8d-4ded-a6aa-76bbe9d30142	true	access.token.claim
1c2b634d-2e8d-4ded-a6aa-76bbe9d30142	zoneinfo	claim.name
1c2b634d-2e8d-4ded-a6aa-76bbe9d30142	String	jsonType.label
3ba2330d-3edb-4b5a-b213-a5a84dec62cc	true	userinfo.token.claim
3ba2330d-3edb-4b5a-b213-a5a84dec62cc	firstName	user.attribute
3ba2330d-3edb-4b5a-b213-a5a84dec62cc	true	id.token.claim
3ba2330d-3edb-4b5a-b213-a5a84dec62cc	true	access.token.claim
3ba2330d-3edb-4b5a-b213-a5a84dec62cc	given_name	claim.name
3ba2330d-3edb-4b5a-b213-a5a84dec62cc	String	jsonType.label
466f2112-81d3-40ac-883b-55777991f68a	true	userinfo.token.claim
466f2112-81d3-40ac-883b-55777991f68a	nickname	user.attribute
466f2112-81d3-40ac-883b-55777991f68a	true	id.token.claim
466f2112-81d3-40ac-883b-55777991f68a	true	access.token.claim
466f2112-81d3-40ac-883b-55777991f68a	nickname	claim.name
466f2112-81d3-40ac-883b-55777991f68a	String	jsonType.label
5ab42e7a-c3db-4476-a010-fa27fc46672b	true	userinfo.token.claim
5ab42e7a-c3db-4476-a010-fa27fc46672b	updatedAt	user.attribute
5ab42e7a-c3db-4476-a010-fa27fc46672b	true	id.token.claim
5ab42e7a-c3db-4476-a010-fa27fc46672b	true	access.token.claim
5ab42e7a-c3db-4476-a010-fa27fc46672b	updated_at	claim.name
5ab42e7a-c3db-4476-a010-fa27fc46672b	long	jsonType.label
6128fc64-e45e-42a9-afbf-9effe649cf9a	true	userinfo.token.claim
6128fc64-e45e-42a9-afbf-9effe649cf9a	lastName	user.attribute
6128fc64-e45e-42a9-afbf-9effe649cf9a	true	id.token.claim
6128fc64-e45e-42a9-afbf-9effe649cf9a	true	access.token.claim
6128fc64-e45e-42a9-afbf-9effe649cf9a	family_name	claim.name
6128fc64-e45e-42a9-afbf-9effe649cf9a	String	jsonType.label
8b20e01c-e40a-4bc3-abaa-6734a4a370ce	true	id.token.claim
8b20e01c-e40a-4bc3-abaa-6734a4a370ce	true	access.token.claim
8b20e01c-e40a-4bc3-abaa-6734a4a370ce	true	userinfo.token.claim
8c04726e-25c0-45c3-b0a3-574923eef192	true	userinfo.token.claim
8c04726e-25c0-45c3-b0a3-574923eef192	profile	user.attribute
8c04726e-25c0-45c3-b0a3-574923eef192	true	id.token.claim
8c04726e-25c0-45c3-b0a3-574923eef192	true	access.token.claim
8c04726e-25c0-45c3-b0a3-574923eef192	profile	claim.name
8c04726e-25c0-45c3-b0a3-574923eef192	String	jsonType.label
8c48ea49-8927-4ff8-9fb2-0aed9c0cbaee	true	userinfo.token.claim
8c48ea49-8927-4ff8-9fb2-0aed9c0cbaee	picture	user.attribute
8c48ea49-8927-4ff8-9fb2-0aed9c0cbaee	true	id.token.claim
8c48ea49-8927-4ff8-9fb2-0aed9c0cbaee	true	access.token.claim
8c48ea49-8927-4ff8-9fb2-0aed9c0cbaee	picture	claim.name
8c48ea49-8927-4ff8-9fb2-0aed9c0cbaee	String	jsonType.label
b4f198fa-26d6-4f21-a3ee-4455739fe597	true	userinfo.token.claim
b4f198fa-26d6-4f21-a3ee-4455739fe597	birthdate	user.attribute
b4f198fa-26d6-4f21-a3ee-4455739fe597	true	id.token.claim
b4f198fa-26d6-4f21-a3ee-4455739fe597	true	access.token.claim
b4f198fa-26d6-4f21-a3ee-4455739fe597	birthdate	claim.name
b4f198fa-26d6-4f21-a3ee-4455739fe597	String	jsonType.label
dd07e2ab-c3a9-44fb-8861-9b6b869f9e67	true	userinfo.token.claim
dd07e2ab-c3a9-44fb-8861-9b6b869f9e67	username	user.attribute
dd07e2ab-c3a9-44fb-8861-9b6b869f9e67	true	id.token.claim
dd07e2ab-c3a9-44fb-8861-9b6b869f9e67	true	access.token.claim
dd07e2ab-c3a9-44fb-8861-9b6b869f9e67	preferred_username	claim.name
dd07e2ab-c3a9-44fb-8861-9b6b869f9e67	String	jsonType.label
e51a4931-10ae-4fbd-a599-64fc582a5555	true	userinfo.token.claim
e51a4931-10ae-4fbd-a599-64fc582a5555	locale	user.attribute
e51a4931-10ae-4fbd-a599-64fc582a5555	true	id.token.claim
e51a4931-10ae-4fbd-a599-64fc582a5555	true	access.token.claim
e51a4931-10ae-4fbd-a599-64fc582a5555	locale	claim.name
e51a4931-10ae-4fbd-a599-64fc582a5555	String	jsonType.label
ed581c7d-8843-44ff-9ee2-3e5d02338582	true	userinfo.token.claim
ed581c7d-8843-44ff-9ee2-3e5d02338582	website	user.attribute
ed581c7d-8843-44ff-9ee2-3e5d02338582	true	id.token.claim
ed581c7d-8843-44ff-9ee2-3e5d02338582	true	access.token.claim
ed581c7d-8843-44ff-9ee2-3e5d02338582	website	claim.name
ed581c7d-8843-44ff-9ee2-3e5d02338582	String	jsonType.label
f6c07292-5664-4555-92c7-b1f9d309d38b	true	userinfo.token.claim
f6c07292-5664-4555-92c7-b1f9d309d38b	gender	user.attribute
f6c07292-5664-4555-92c7-b1f9d309d38b	true	id.token.claim
f6c07292-5664-4555-92c7-b1f9d309d38b	true	access.token.claim
f6c07292-5664-4555-92c7-b1f9d309d38b	gender	claim.name
f6c07292-5664-4555-92c7-b1f9d309d38b	String	jsonType.label
87a0b789-e2fc-44ea-9a14-45532aef41ed	true	userinfo.token.claim
87a0b789-e2fc-44ea-9a14-45532aef41ed	username	user.attribute
87a0b789-e2fc-44ea-9a14-45532aef41ed	true	id.token.claim
87a0b789-e2fc-44ea-9a14-45532aef41ed	true	access.token.claim
87a0b789-e2fc-44ea-9a14-45532aef41ed	upn	claim.name
87a0b789-e2fc-44ea-9a14-45532aef41ed	String	jsonType.label
ec27a269-a743-4902-be6a-597144b0a36a	true	multivalued
ec27a269-a743-4902-be6a-597144b0a36a	true	userinfo.token.claim
ec27a269-a743-4902-be6a-597144b0a36a	foo	user.attribute
ec27a269-a743-4902-be6a-597144b0a36a	true	id.token.claim
ec27a269-a743-4902-be6a-597144b0a36a	true	access.token.claim
ec27a269-a743-4902-be6a-597144b0a36a	groups	claim.name
ec27a269-a743-4902-be6a-597144b0a36a	String	jsonType.label
3002fb74-e5c5-4cf5-94d8-9283c243de4a	formatted	user.attribute.formatted
3002fb74-e5c5-4cf5-94d8-9283c243de4a	country	user.attribute.country
3002fb74-e5c5-4cf5-94d8-9283c243de4a	postal_code	user.attribute.postal_code
3002fb74-e5c5-4cf5-94d8-9283c243de4a	true	userinfo.token.claim
3002fb74-e5c5-4cf5-94d8-9283c243de4a	street	user.attribute.street
3002fb74-e5c5-4cf5-94d8-9283c243de4a	true	id.token.claim
3002fb74-e5c5-4cf5-94d8-9283c243de4a	region	user.attribute.region
3002fb74-e5c5-4cf5-94d8-9283c243de4a	true	access.token.claim
3002fb74-e5c5-4cf5-94d8-9283c243de4a	locality	user.attribute.locality
06f4c5ff-9f7c-46ba-b385-41921f6b0539	foo	user.attribute
06f4c5ff-9f7c-46ba-b385-41921f6b0539	true	access.token.claim
06f4c5ff-9f7c-46ba-b385-41921f6b0539	realm_access.roles	claim.name
06f4c5ff-9f7c-46ba-b385-41921f6b0539	String	jsonType.label
06f4c5ff-9f7c-46ba-b385-41921f6b0539	true	multivalued
57e46265-8068-4aa5-9d18-21f69f990fc3	foo	user.attribute
57e46265-8068-4aa5-9d18-21f69f990fc3	true	access.token.claim
57e46265-8068-4aa5-9d18-21f69f990fc3	resource_access.${client_id}.roles	claim.name
57e46265-8068-4aa5-9d18-21f69f990fc3	String	jsonType.label
57e46265-8068-4aa5-9d18-21f69f990fc3	true	multivalued
d5c32a67-ceb3-4656-b469-effb810187db	true	userinfo.token.claim
d5c32a67-ceb3-4656-b469-effb810187db	locale	user.attribute
d5c32a67-ceb3-4656-b469-effb810187db	true	id.token.claim
d5c32a67-ceb3-4656-b469-effb810187db	true	access.token.claim
d5c32a67-ceb3-4656-b469-effb810187db	locale	claim.name
d5c32a67-ceb3-4656-b469-effb810187db	String	jsonType.label
00605667-4f75-4171-a65b-eb29ab52b54d	clientHost	user.session.note
00605667-4f75-4171-a65b-eb29ab52b54d	true	id.token.claim
00605667-4f75-4171-a65b-eb29ab52b54d	true	access.token.claim
00605667-4f75-4171-a65b-eb29ab52b54d	clientHost	claim.name
00605667-4f75-4171-a65b-eb29ab52b54d	String	jsonType.label
00cb1e8e-09c0-40c8-a726-412ed6ea43e7	clientId	user.session.note
00cb1e8e-09c0-40c8-a726-412ed6ea43e7	true	id.token.claim
00cb1e8e-09c0-40c8-a726-412ed6ea43e7	true	access.token.claim
00cb1e8e-09c0-40c8-a726-412ed6ea43e7	clientId	claim.name
00cb1e8e-09c0-40c8-a726-412ed6ea43e7	String	jsonType.label
00cb1e8e-09c0-40c8-a726-412ed6ea43e7	true	userinfo.token.claim
2c3d6932-0e04-47c2-b383-74c650d9e3ae	clientAddress	user.session.note
2c3d6932-0e04-47c2-b383-74c650d9e3ae	true	id.token.claim
2c3d6932-0e04-47c2-b383-74c650d9e3ae	true	access.token.claim
2c3d6932-0e04-47c2-b383-74c650d9e3ae	clientAddress	claim.name
2c3d6932-0e04-47c2-b383-74c650d9e3ae	String	jsonType.label
2c3d6932-0e04-47c2-b383-74c650d9e3ae	true	userinfo.token.claim
00605667-4f75-4171-a65b-eb29ab52b54d	true	userinfo.token.claim
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	be9cdd2f-9a9d-4f02-85f2-340a2921fe56	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	2d35ec91-c44b-4bc1-90d5-7dcee8989320	9761a3a3-977b-4f85-9df9-4c114471a315	08a90d37-3e49-4883-aa02-1376996e8246	8650b7ed-32c6-4baf-9088-57485fd3d9e2	f7d1d0d0-3c8e-48ec-96de-e7a7b55fb36e	2592000	f	900	t	f	57577692-8244-4d2d-92ab-1d6a2514a33d	0	f	0	0	5f0608d6-e4a2-4d2b-b50f-4a61e1c848b5
cbe1e5c7-2df6-4315-81ae-99391565cb0c	60	300	300	\N	\N	\N	t	f	0	\N	testing-realm	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	83a550b2-cfe9-4b89-8249-c5c5b0768b88	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	5cbe336f-685e-4b6c-a18b-662d9303e1ab	59e51925-bdbf-47ee-8362-dd98cf4aa5c4	e57e429f-327f-417b-8cc3-e006ff7c9928	9c43f4c8-4e32-4160-adaf-c7bb1eee167a	9bd36232-7aeb-43a0-99b4-c5d27ad3f27f	2592000	f	900	t	f	d425a327-2de1-4cd4-a0b8-c3ba6151d5be	0	f	0	0	1f1d2001-6a1e-482a-b4cf-056dc15526c0
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	
_browser_header.xContentTypeOptions	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	nosniff
_browser_header.xRobotsTag	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	none
_browser_header.xFrameOptions	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	SAMEORIGIN
_browser_header.contentSecurityPolicy	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	1; mode=block
_browser_header.strictTransportSecurity	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	max-age=31536000; includeSubDomains
bruteForceProtected	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	false
permanentLockout	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	false
maxFailureWaitSeconds	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	900
minimumQuickLoginWaitSeconds	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	60
waitIncrementSeconds	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	60
quickLoginCheckMilliSeconds	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	1000
maxDeltaTimeSeconds	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	43200
failureFactor	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	30
realmReusableOtpCode	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	false
displayName	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	Keycloak
displayNameHtml	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	RS256
offlineSessionMaxLifespanEnabled	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	false
offlineSessionMaxLifespan	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	5184000
_browser_header.contentSecurityPolicyReportOnly	cbe1e5c7-2df6-4315-81ae-99391565cb0c	
_browser_header.xContentTypeOptions	cbe1e5c7-2df6-4315-81ae-99391565cb0c	nosniff
_browser_header.xRobotsTag	cbe1e5c7-2df6-4315-81ae-99391565cb0c	none
_browser_header.xFrameOptions	cbe1e5c7-2df6-4315-81ae-99391565cb0c	SAMEORIGIN
_browser_header.contentSecurityPolicy	cbe1e5c7-2df6-4315-81ae-99391565cb0c	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	cbe1e5c7-2df6-4315-81ae-99391565cb0c	1; mode=block
_browser_header.strictTransportSecurity	cbe1e5c7-2df6-4315-81ae-99391565cb0c	max-age=31536000; includeSubDomains
bruteForceProtected	cbe1e5c7-2df6-4315-81ae-99391565cb0c	false
permanentLockout	cbe1e5c7-2df6-4315-81ae-99391565cb0c	false
maxFailureWaitSeconds	cbe1e5c7-2df6-4315-81ae-99391565cb0c	900
minimumQuickLoginWaitSeconds	cbe1e5c7-2df6-4315-81ae-99391565cb0c	60
waitIncrementSeconds	cbe1e5c7-2df6-4315-81ae-99391565cb0c	60
quickLoginCheckMilliSeconds	cbe1e5c7-2df6-4315-81ae-99391565cb0c	1000
maxDeltaTimeSeconds	cbe1e5c7-2df6-4315-81ae-99391565cb0c	43200
failureFactor	cbe1e5c7-2df6-4315-81ae-99391565cb0c	30
realmReusableOtpCode	cbe1e5c7-2df6-4315-81ae-99391565cb0c	false
defaultSignatureAlgorithm	cbe1e5c7-2df6-4315-81ae-99391565cb0c	RS256
offlineSessionMaxLifespanEnabled	cbe1e5c7-2df6-4315-81ae-99391565cb0c	false
offlineSessionMaxLifespan	cbe1e5c7-2df6-4315-81ae-99391565cb0c	5184000
clientSessionIdleTimeout	cbe1e5c7-2df6-4315-81ae-99391565cb0c	0
clientSessionMaxLifespan	cbe1e5c7-2df6-4315-81ae-99391565cb0c	0
clientOfflineSessionIdleTimeout	cbe1e5c7-2df6-4315-81ae-99391565cb0c	0
clientOfflineSessionMaxLifespan	cbe1e5c7-2df6-4315-81ae-99391565cb0c	0
actionTokenGeneratedByAdminLifespan	cbe1e5c7-2df6-4315-81ae-99391565cb0c	43200
actionTokenGeneratedByUserLifespan	cbe1e5c7-2df6-4315-81ae-99391565cb0c	300
oauth2DeviceCodeLifespan	cbe1e5c7-2df6-4315-81ae-99391565cb0c	600
oauth2DevicePollingInterval	cbe1e5c7-2df6-4315-81ae-99391565cb0c	5
webAuthnPolicyRpEntityName	cbe1e5c7-2df6-4315-81ae-99391565cb0c	keycloak
webAuthnPolicySignatureAlgorithms	cbe1e5c7-2df6-4315-81ae-99391565cb0c	ES256
webAuthnPolicyRpId	cbe1e5c7-2df6-4315-81ae-99391565cb0c	
webAuthnPolicyAttestationConveyancePreference	cbe1e5c7-2df6-4315-81ae-99391565cb0c	not specified
webAuthnPolicyAuthenticatorAttachment	cbe1e5c7-2df6-4315-81ae-99391565cb0c	not specified
webAuthnPolicyRequireResidentKey	cbe1e5c7-2df6-4315-81ae-99391565cb0c	not specified
webAuthnPolicyUserVerificationRequirement	cbe1e5c7-2df6-4315-81ae-99391565cb0c	not specified
webAuthnPolicyCreateTimeout	cbe1e5c7-2df6-4315-81ae-99391565cb0c	0
webAuthnPolicyAvoidSameAuthenticatorRegister	cbe1e5c7-2df6-4315-81ae-99391565cb0c	false
webAuthnPolicyRpEntityNamePasswordless	cbe1e5c7-2df6-4315-81ae-99391565cb0c	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	cbe1e5c7-2df6-4315-81ae-99391565cb0c	ES256
webAuthnPolicyRpIdPasswordless	cbe1e5c7-2df6-4315-81ae-99391565cb0c	
webAuthnPolicyAttestationConveyancePreferencePasswordless	cbe1e5c7-2df6-4315-81ae-99391565cb0c	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	cbe1e5c7-2df6-4315-81ae-99391565cb0c	not specified
webAuthnPolicyRequireResidentKeyPasswordless	cbe1e5c7-2df6-4315-81ae-99391565cb0c	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	cbe1e5c7-2df6-4315-81ae-99391565cb0c	not specified
webAuthnPolicyCreateTimeoutPasswordless	cbe1e5c7-2df6-4315-81ae-99391565cb0c	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	cbe1e5c7-2df6-4315-81ae-99391565cb0c	false
cibaBackchannelTokenDeliveryMode	cbe1e5c7-2df6-4315-81ae-99391565cb0c	poll
cibaExpiresIn	cbe1e5c7-2df6-4315-81ae-99391565cb0c	120
cibaInterval	cbe1e5c7-2df6-4315-81ae-99391565cb0c	5
cibaAuthRequestedUserHint	cbe1e5c7-2df6-4315-81ae-99391565cb0c	login_hint
parRequestUriLifespan	cbe1e5c7-2df6-4315-81ae-99391565cb0c	60
client-policies.profiles	cbe1e5c7-2df6-4315-81ae-99391565cb0c	{"profiles":[]}
client-policies.policies	cbe1e5c7-2df6-4315-81ae-99391565cb0c	{"policies":[]}
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	jboss-logging
cbe1e5c7-2df6-4315-81ae-99391565cb0c	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0
password	password	t	t	cbe1e5c7-2df6-4315-81ae-99391565cb0c
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.redirect_uris (client_id, value) FROM stdin;
5f5beba5-7c21-407e-8e8b-2f3a6cdfb19f	/realms/master/account/*
bc637500-577a-4a27-8195-332e353992b2	/realms/master/account/*
d69e5f30-203e-41ae-a726-1f8948a43de6	/admin/master/console/*
ab8b4126-c57b-4569-92ff-b29d9111aca3	/realms/testing-realm/account/*
5847a1f9-bc56-44b8-b548-dc9e6c50a883	/realms/testing-realm/account/*
7f05ba07-4dfd-4d20-8593-77ba24fb858a	/admin/testing-realm/console/*
e7abce3a-f802-40e3-bfe2-9b3c5d306c72	http://localhost:8081/login/oauth2/code/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
cf426e13-5a40-47a9-9c82-9ae2f2499745	VERIFY_EMAIL	Verify Email	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	t	f	VERIFY_EMAIL	50
11bc2c59-0d82-4d4d-8d58-44af80835f80	UPDATE_PROFILE	Update Profile	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	t	f	UPDATE_PROFILE	40
3def70a2-5bf2-4d8b-a337-0d9bd123dcaf	CONFIGURE_TOTP	Configure OTP	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	t	f	CONFIGURE_TOTP	10
38b42752-ceb6-4e66-8436-2155f7c8e8a1	UPDATE_PASSWORD	Update Password	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	t	f	UPDATE_PASSWORD	30
700d8a4d-aed2-4a28-a30b-6e6d8ad2d2ac	TERMS_AND_CONDITIONS	Terms and Conditions	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	f	f	TERMS_AND_CONDITIONS	20
5f194e81-1d5f-4a21-b407-85ba8dba8baa	delete_account	Delete Account	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	f	f	delete_account	60
46982d29-c5f7-4748-89f9-3bdb360e0257	update_user_locale	Update User Locale	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	t	f	update_user_locale	1000
5387ca8c-6128-4817-bea3-a973e313f012	webauthn-register	Webauthn Register	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	t	f	webauthn-register	70
d00c8498-d35f-4243-841e-ca85ba577cb1	webauthn-register-passwordless	Webauthn Register Passwordless	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	t	f	webauthn-register-passwordless	80
d634f3d3-4ad0-4c4e-a82d-98df7adaf4d8	CONFIGURE_TOTP	Configure OTP	cbe1e5c7-2df6-4315-81ae-99391565cb0c	t	f	CONFIGURE_TOTP	10
d64f547c-e5f3-4b96-8efc-003cf64f1210	TERMS_AND_CONDITIONS	Terms and Conditions	cbe1e5c7-2df6-4315-81ae-99391565cb0c	f	f	TERMS_AND_CONDITIONS	20
1d8e7ffb-0724-4e16-a43f-e4b6309d16d1	UPDATE_PASSWORD	Update Password	cbe1e5c7-2df6-4315-81ae-99391565cb0c	t	f	UPDATE_PASSWORD	30
ccc12578-7364-49f6-a222-e955ec8e58a2	UPDATE_PROFILE	Update Profile	cbe1e5c7-2df6-4315-81ae-99391565cb0c	t	f	UPDATE_PROFILE	40
a760ee27-0e9d-4b30-b0a3-4790674fef5c	VERIFY_EMAIL	Verify Email	cbe1e5c7-2df6-4315-81ae-99391565cb0c	t	f	VERIFY_EMAIL	50
62e8d2d8-1991-4554-b830-8f85b0a43b66	delete_account	Delete Account	cbe1e5c7-2df6-4315-81ae-99391565cb0c	f	f	delete_account	60
886f350f-bc99-40eb-b798-f3d450c159db	webauthn-register	Webauthn Register	cbe1e5c7-2df6-4315-81ae-99391565cb0c	t	f	webauthn-register	70
3271870b-89eb-49ec-b27d-c642597d28b6	webauthn-register-passwordless	Webauthn Register Passwordless	cbe1e5c7-2df6-4315-81ae-99391565cb0c	t	f	webauthn-register-passwordless	80
12dc050d-6ab6-4c44-a494-939787dfdca1	update_user_locale	Update User Locale	cbe1e5c7-2df6-4315-81ae-99391565cb0c	t	f	update_user_locale	1000
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
bc637500-577a-4a27-8195-332e353992b2	30f74f9b-961f-4082-bb0c-7cd8078f3d8a
bc637500-577a-4a27-8195-332e353992b2	9b75dfb3-2da1-4b0f-9fdd-82c79aec8c3c
5847a1f9-bc56-44b8-b548-dc9e6c50a883	1d13458b-e378-48f8-b124-12c54c745c48
5847a1f9-bc56-44b8-b548-dc9e6c50a883	0bd9e065-2fe0-4fd5-b08d-da1df27f4e29
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
18309232-af22-4cab-b783-66ff1f7b242f	\N	6ffe6551-fb9e-427b-9ad3-c9c87872d9b8	f	t	\N	\N	\N	7f0ac646-5f96-421c-9f2c-0be20ba7a8a0	admin	1684481923040	\N	0
53ee06e9-e803-47ed-b1e4-7b8ea194d0dc	\N	ce074003-55e2-4f1c-b7de-e506ceca9a14	f	t	\N			cbe1e5c7-2df6-4315-81ae-99391565cb0c	tes	1684491059222	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
5f0608d6-e4a2-4d2b-b50f-4a61e1c848b5	18309232-af22-4cab-b783-66ff1f7b242f
c5426dd7-025c-47e0-86c6-e19ece396662	18309232-af22-4cab-b783-66ff1f7b242f
804dae16-88bd-46cb-9a2f-3e738f9b4662	18309232-af22-4cab-b783-66ff1f7b242f
e03856ec-c546-4ee9-b182-75d1555555d4	18309232-af22-4cab-b783-66ff1f7b242f
592ee4f7-9370-437b-b734-31628a1ad019	18309232-af22-4cab-b783-66ff1f7b242f
0c1ebd2c-c8fd-4667-8850-85dc6735bdc8	18309232-af22-4cab-b783-66ff1f7b242f
182e78d4-ece2-46a3-b680-f5172ff088c3	18309232-af22-4cab-b783-66ff1f7b242f
3266db3a-9e35-4408-bcde-6e32f293306d	18309232-af22-4cab-b783-66ff1f7b242f
d714b12e-d993-4639-ba22-365d1a1fa7f2	18309232-af22-4cab-b783-66ff1f7b242f
f754c89f-c540-4c7e-bf82-1cf52ade5a93	18309232-af22-4cab-b783-66ff1f7b242f
8dbf8d35-fe3a-4114-8bd6-6ebddace0433	18309232-af22-4cab-b783-66ff1f7b242f
e9983085-f1a7-4eab-ad50-49771dc9ef4e	18309232-af22-4cab-b783-66ff1f7b242f
09856cb1-37d3-4157-89c0-a7dc6c7f4c50	18309232-af22-4cab-b783-66ff1f7b242f
b2fb1cc9-382c-410a-bc4a-b950ef3264dc	18309232-af22-4cab-b783-66ff1f7b242f
bdcbac71-805e-429a-8d7f-202574793fc3	18309232-af22-4cab-b783-66ff1f7b242f
6cc26cde-a145-4814-9b2e-f722e31148ab	18309232-af22-4cab-b783-66ff1f7b242f
deb7d0ad-3110-417b-8425-f05a8b87814d	18309232-af22-4cab-b783-66ff1f7b242f
e2aad06f-d535-46ac-980e-115f8add4116	18309232-af22-4cab-b783-66ff1f7b242f
4274384d-7e7f-4209-9dbe-1c5461527d8e	18309232-af22-4cab-b783-66ff1f7b242f
1f1d2001-6a1e-482a-b4cf-056dc15526c0	53ee06e9-e803-47ed-b1e4-7b8ea194d0dc
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_origins (client_id, value) FROM stdin;
d69e5f30-203e-41ae-a726-1f8948a43de6	+
7f05ba07-4dfd-4d20-8593-77ba24fb858a	+
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

