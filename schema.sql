--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5 (Debian 11.5-1.pgdg90+1)
-- Dumped by pg_dump version 11.5 (Debian 11.5-1.pgdg90+1)

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
-- Name: hstore; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


--
-- Name: core_crudlog_delete_master(); Type: FUNCTION; Schema: public; Owner: pgisn
--

CREATE FUNCTION public.core_crudlog_delete_master() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
                BEGIN
                    DELETE FROM ONLY "core_crudlog" WHERE id = NEW.id;
                    RETURN NEW;
                END;
            $$;


ALTER FUNCTION public.core_crudlog_delete_master() OWNER TO pgisn;

--
-- Name: core_crudlog_insert_child(); Type: FUNCTION; Schema: public; Owner: pgisn
--

CREATE FUNCTION public.core_crudlog_insert_child() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
                DECLARE
                    match core_crudlog."action_time"%TYPE;
                    tablename VARCHAR;
                    checks TEXT;

                BEGIN
                    IF NEW."action_time" IS NULL THEN
                        tablename := 'core_crudlog_null';
                        checks := '"action_time" IS NULL';
                    ELSE
                        match := DATE_TRUNC('month', NEW."action_time");
                        tablename := 'core_crudlog_' || TO_CHAR(NEW."action_time", '"y"YYYY"m"MM');
                        checks := '"action_time" >= ''' || match || ''' AND "action_time" < ''' || (match + INTERVAL '1 month') || '''';
                    END IF;

                    IF NOT EXISTS(
                        SELECT 1 FROM information_schema.tables WHERE table_name=tablename)
                    THEN
                        BEGIN
                            EXECUTE 'CREATE TABLE ' || tablename || ' (
                                CHECK (' || checks || '),
                                LIKE "core_crudlog" INCLUDING DEFAULTS INCLUDING CONSTRAINTS INCLUDING INDEXES
                            ) INHERITS ("core_crudlog");';
                        EXCEPTION WHEN duplicate_table THEN
                            -- pass
                        END;
                    END IF;

                    EXECUTE 'INSERT INTO ' || tablename || ' VALUES (($1).*);' USING NEW;
                    RETURN NEW;
                END;
            $_$;


ALTER FUNCTION public.core_crudlog_insert_child() OWNER TO pgisn;

--
-- Name: report_engine_accesscodelog_delete_master(); Type: FUNCTION; Schema: public; Owner: pgisn
--

CREATE FUNCTION public.report_engine_accesscodelog_delete_master() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
                BEGIN
                    DELETE FROM ONLY "report_engine_accesscodelog" WHERE id = NEW.id;
                    RETURN NEW;
                END;
            $$;


ALTER FUNCTION public.report_engine_accesscodelog_delete_master() OWNER TO pgisn;

--
-- Name: report_engine_accesscodelog_insert_child(); Type: FUNCTION; Schema: public; Owner: pgisn
--

CREATE FUNCTION public.report_engine_accesscodelog_insert_child() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
                DECLARE
                    match report_engine_accesscodelog."log_date"%TYPE;
                    tablename VARCHAR;
                    checks TEXT;

                BEGIN
                    IF NEW."log_date" IS NULL THEN
                        tablename := 'report_engine_accesscodelog_null';
                        checks := '"log_date" IS NULL';
                    ELSE
                        match := DATE_TRUNC('month', NEW."log_date");
                        tablename := 'report_engine_accesscodelog_' || TO_CHAR(NEW."log_date", '"y"YYYY"m"MM');
                        checks := '"log_date" >= ''' || match || ''' AND "log_date" < ''' || (match + INTERVAL '1 month') || '''';
                    END IF;

                    IF NOT EXISTS(
                        SELECT 1 FROM information_schema.tables WHERE table_name=tablename)
                    THEN
                        BEGIN
                            EXECUTE 'CREATE TABLE ' || tablename || ' (
                                CHECK (' || checks || '),
                                LIKE "report_engine_accesscodelog" INCLUDING DEFAULTS INCLUDING CONSTRAINTS INCLUDING INDEXES
                            ) INHERITS ("report_engine_accesscodelog");';
                        EXCEPTION WHEN duplicate_table THEN
                            -- pass
                        END;
                    END IF;

                    EXECUTE 'INSERT INTO ' || tablename || ' VALUES (($1).*);' USING NEW;
                    RETURN NEW;
                END;
            $_$;


ALTER FUNCTION public.report_engine_accesscodelog_insert_child() OWNER TO pgisn;

--
-- Name: report_engine_visitorlog_delete_master(); Type: FUNCTION; Schema: public; Owner: pgisn
--

CREATE FUNCTION public.report_engine_visitorlog_delete_master() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
                BEGIN
                    DELETE FROM ONLY "report_engine_visitorlog" WHERE id = NEW.id;
                    RETURN NEW;
                END;
            $$;


ALTER FUNCTION public.report_engine_visitorlog_delete_master() OWNER TO pgisn;

--
-- Name: report_engine_visitorlog_insert_child(); Type: FUNCTION; Schema: public; Owner: pgisn
--

CREATE FUNCTION public.report_engine_visitorlog_insert_child() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
                DECLARE
                    match report_engine_visitorlog."log_date"%TYPE;
                    tablename VARCHAR;
                    checks TEXT;

                BEGIN
                    IF NEW."log_date" IS NULL THEN
                        tablename := 'report_engine_visitorlog_null';
                        checks := '"log_date" IS NULL';
                    ELSE
                        match := DATE_TRUNC('month', NEW."log_date");
                        tablename := 'report_engine_visitorlog_' || TO_CHAR(NEW."log_date", '"y"YYYY"m"MM');
                        checks := '"log_date" >= ''' || match || ''' AND "log_date" < ''' || (match + INTERVAL '1 month') || '''';
                    END IF;

                    IF NOT EXISTS(
                        SELECT 1 FROM information_schema.tables WHERE table_name=tablename)
                    THEN
                        BEGIN
                            EXECUTE 'CREATE TABLE ' || tablename || ' (
                                CHECK (' || checks || '),
                                LIKE "report_engine_visitorlog" INCLUDING DEFAULTS INCLUDING CONSTRAINTS INCLUDING INDEXES
                            ) INHERITS ("report_engine_visitorlog");';
                        EXCEPTION WHEN duplicate_table THEN
                            -- pass
                        END;
                    END IF;

                    EXECUTE 'INSERT INTO ' || tablename || ' VALUES (($1).*);' USING NEW;
                    RETURN NEW;
                END;
            $_$;


ALTER FUNCTION public.report_engine_visitorlog_insert_child() OWNER TO pgisn;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: access_control_accesscode; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.access_control_accesscode (
    id integer NOT NULL,
    access_code character varying(50) NOT NULL,
    type character varying(10) NOT NULL,
    is_active boolean NOT NULL,
    start_date date NOT NULL,
    end_date date,
    object_id integer,
    content_type_id integer,
    facility_code_id integer NOT NULL,
    CONSTRAINT access_control_accesscode_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE public.access_control_accesscode OWNER TO pgisn;

--
-- Name: access_control_accesscode_groups; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.access_control_accesscode_groups (
    id integer NOT NULL,
    accesscode_id integer NOT NULL,
    acgroup_id integer NOT NULL
);


ALTER TABLE public.access_control_accesscode_groups OWNER TO pgisn;

--
-- Name: access_control_accesscode_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.access_control_accesscode_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.access_control_accesscode_groups_id_seq OWNER TO pgisn;

--
-- Name: access_control_accesscode_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.access_control_accesscode_groups_id_seq OWNED BY public.access_control_accesscode_groups.id;


--
-- Name: access_control_accesscode_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.access_control_accesscode_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.access_control_accesscode_id_seq OWNER TO pgisn;

--
-- Name: access_control_accesscode_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.access_control_accesscode_id_seq OWNED BY public.access_control_accesscode.id;


--
-- Name: access_control_acgroup; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.access_control_acgroup (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.access_control_acgroup OWNER TO pgisn;

--
-- Name: access_control_acgroup_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.access_control_acgroup_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.access_control_acgroup_id_seq OWNER TO pgisn;

--
-- Name: access_control_acgroup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.access_control_acgroup_id_seq OWNED BY public.access_control_acgroup.id;


--
-- Name: access_control_acpasstemplate; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.access_control_acpasstemplate (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    "default" boolean NOT NULL,
    type character varying(10) NOT NULL,
    content text NOT NULL
);


ALTER TABLE public.access_control_acpasstemplate OWNER TO pgisn;

--
-- Name: access_control_acpasstemplate_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.access_control_acpasstemplate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.access_control_acpasstemplate_id_seq OWNER TO pgisn;

--
-- Name: access_control_acpasstemplate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.access_control_acpasstemplate_id_seq OWNED BY public.access_control_acpasstemplate.id;


--
-- Name: access_control_acpermission; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.access_control_acpermission (
    entity_ptr_id integer NOT NULL,
    schedule_id integer NOT NULL
);


ALTER TABLE public.access_control_acpermission OWNER TO pgisn;

--
-- Name: access_control_acpermission_devices; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.access_control_acpermission_devices (
    id integer NOT NULL,
    acpermission_id integer NOT NULL,
    device_id integer NOT NULL
);


ALTER TABLE public.access_control_acpermission_devices OWNER TO pgisn;

--
-- Name: access_control_acpermission_devices_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.access_control_acpermission_devices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.access_control_acpermission_devices_id_seq OWNER TO pgisn;

--
-- Name: access_control_acpermission_devices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.access_control_acpermission_devices_id_seq OWNED BY public.access_control_acpermission_devices.id;


--
-- Name: access_control_acpermission_groups; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.access_control_acpermission_groups (
    id integer NOT NULL,
    acpermission_id integer NOT NULL,
    acgroup_id integer NOT NULL
);


ALTER TABLE public.access_control_acpermission_groups OWNER TO pgisn;

--
-- Name: access_control_acpermission_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.access_control_acpermission_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.access_control_acpermission_groups_id_seq OWNER TO pgisn;

--
-- Name: access_control_acpermission_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.access_control_acpermission_groups_id_seq OWNED BY public.access_control_acpermission_groups.id;


--
-- Name: access_control_acschedule; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.access_control_acschedule (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    start timestamp with time zone NOT NULL,
    "end" timestamp with time zone NOT NULL,
    purpose text,
    frequency character varying(4) NOT NULL,
    weekdays character varying(13) NOT NULL,
    repeat_until date,
    finish timestamp with time zone,
    next_start timestamp with time zone
);


ALTER TABLE public.access_control_acschedule OWNER TO pgisn;

--
-- Name: access_control_acschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.access_control_acschedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.access_control_acschedule_id_seq OWNER TO pgisn;

--
-- Name: access_control_acschedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.access_control_acschedule_id_seq OWNED BY public.access_control_acschedule.id;


--
-- Name: access_control_device; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.access_control_device (
    entity_ptr_id integer NOT NULL,
    type character varying(10) NOT NULL,
    gate_id integer NOT NULL
);


ALTER TABLE public.access_control_device OWNER TO pgisn;

--
-- Name: access_control_facilitycode; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.access_control_facilitycode (
    id integer NOT NULL,
    code character varying(10) NOT NULL
);


ALTER TABLE public.access_control_facilitycode OWNER TO pgisn;

--
-- Name: access_control_facilitycode_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.access_control_facilitycode_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.access_control_facilitycode_id_seq OWNER TO pgisn;

--
-- Name: access_control_facilitycode_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.access_control_facilitycode_id_seq OWNED BY public.access_control_facilitycode.id;


--
-- Name: access_control_sticker; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.access_control_sticker (
    id integer NOT NULL,
    range_start integer NOT NULL,
    range_end integer NOT NULL,
    picture character varying(250) NOT NULL,
    facility_code_id integer NOT NULL
);


ALTER TABLE public.access_control_sticker OWNER TO pgisn;

--
-- Name: access_control_sticker_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.access_control_sticker_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.access_control_sticker_id_seq OWNER TO pgisn;

--
-- Name: access_control_sticker_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.access_control_sticker_id_seq OWNED BY public.access_control_sticker.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO pgisn;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO pgisn;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO pgisn;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO pgisn;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO pgisn;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO pgisn;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO pgisn;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO pgisn;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO pgisn;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO pgisn;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO pgisn;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO pgisn;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: authtoken_token; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.authtoken_token (
    key character varying(40) NOT NULL,
    created timestamp with time zone NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.authtoken_token OWNER TO pgisn;

--
-- Name: core_apirequestlog; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.core_apirequestlog (
    id integer NOT NULL,
    requested_at timestamp with time zone NOT NULL,
    response_ms integer NOT NULL,
    path character varying(200) NOT NULL,
    remote_addr inet NOT NULL,
    host character varying(200) NOT NULL,
    method character varying(10) NOT NULL,
    query_params text,
    data text,
    response text,
    status_code integer,
    object_id text,
    object_repr character varying(200),
    content_type_id integer,
    user_id integer,
    CONSTRAINT core_apirequestlog_response_ms_check CHECK ((response_ms >= 0)),
    CONSTRAINT core_apirequestlog_status_code_check CHECK ((status_code >= 0))
);


ALTER TABLE public.core_apirequestlog OWNER TO pgisn;

--
-- Name: core_apirequestlog_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.core_apirequestlog_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_apirequestlog_id_seq OWNER TO pgisn;

--
-- Name: core_apirequestlog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.core_apirequestlog_id_seq OWNED BY public.core_apirequestlog.id;


--
-- Name: core_crudlog; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.core_crudlog (
    id integer NOT NULL,
    user_id integer NOT NULL,
    object_id integer NOT NULL,
    object_str character varying(250) NOT NULL,
    model_name character varying(250) NOT NULL,
    action_time timestamp with time zone NOT NULL,
    action character varying(6) NOT NULL,
    CONSTRAINT core_crudlog_object_id_check CHECK ((object_id >= 0)),
    CONSTRAINT core_crudlog_user_id_check CHECK ((user_id >= 0))
);


ALTER TABLE public.core_crudlog OWNER TO pgisn;

--
-- Name: core_crudlog_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.core_crudlog_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_crudlog_id_seq OWNER TO pgisn;

--
-- Name: core_crudlog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.core_crudlog_id_seq OWNED BY public.core_crudlog.id;


--
-- Name: core_crudlog_y2018m09; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.core_crudlog_y2018m09 (
    id integer DEFAULT nextval('public.core_crudlog_id_seq'::regclass),
    user_id integer,
    object_id integer,
    object_str character varying(250),
    model_name character varying(250),
    action_time timestamp with time zone,
    action character varying(6),
    CONSTRAINT core_crudlog_object_id_check CHECK ((object_id >= 0)),
    CONSTRAINT core_crudlog_user_id_check CHECK ((user_id >= 0)),
    CONSTRAINT core_crudlog_y2018m09_action_time_check CHECK (((action_time >= '2018-09-01 00:00:00+00'::timestamp with time zone) AND (action_time < '2018-10-01 00:00:00+00'::timestamp with time zone)))
)
INHERITS (public.core_crudlog);


ALTER TABLE public.core_crudlog_y2018m09 OWNER TO pgisn;

--
-- Name: core_crudlog_y2018m10; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.core_crudlog_y2018m10 (
    id integer DEFAULT nextval('public.core_crudlog_id_seq'::regclass),
    user_id integer,
    object_id integer,
    object_str character varying(250),
    model_name character varying(250),
    action_time timestamp with time zone,
    action character varying(6),
    CONSTRAINT core_crudlog_object_id_check CHECK ((object_id >= 0)),
    CONSTRAINT core_crudlog_user_id_check CHECK ((user_id >= 0)),
    CONSTRAINT core_crudlog_y2018m10_action_time_check CHECK (((action_time >= '2018-10-01 00:00:00+00'::timestamp with time zone) AND (action_time < '2018-11-01 00:00:00+00'::timestamp with time zone)))
)
INHERITS (public.core_crudlog);


ALTER TABLE public.core_crudlog_y2018m10 OWNER TO pgisn;

--
-- Name: core_crudlog_y2018m11; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.core_crudlog_y2018m11 (
    id integer DEFAULT nextval('public.core_crudlog_id_seq'::regclass),
    user_id integer,
    object_id integer,
    object_str character varying(250),
    model_name character varying(250),
    action_time timestamp with time zone,
    action character varying(6),
    CONSTRAINT core_crudlog_object_id_check CHECK ((object_id >= 0)),
    CONSTRAINT core_crudlog_user_id_check CHECK ((user_id >= 0)),
    CONSTRAINT core_crudlog_y2018m11_action_time_check CHECK (((action_time >= '2018-11-01 00:00:00+00'::timestamp with time zone) AND (action_time < '2018-12-01 00:00:00+00'::timestamp with time zone)))
)
INHERITS (public.core_crudlog);


ALTER TABLE public.core_crudlog_y2018m11 OWNER TO pgisn;

--
-- Name: core_crudlog_y2018m12; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.core_crudlog_y2018m12 (
    id integer DEFAULT nextval('public.core_crudlog_id_seq'::regclass),
    user_id integer,
    object_id integer,
    object_str character varying(250),
    model_name character varying(250),
    action_time timestamp with time zone,
    action character varying(6),
    CONSTRAINT core_crudlog_object_id_check CHECK ((object_id >= 0)),
    CONSTRAINT core_crudlog_user_id_check CHECK ((user_id >= 0)),
    CONSTRAINT core_crudlog_y2018m12_action_time_check CHECK (((action_time >= '2018-12-01 00:00:00+00'::timestamp with time zone) AND (action_time < '2019-01-01 00:00:00+00'::timestamp with time zone)))
)
INHERITS (public.core_crudlog);


ALTER TABLE public.core_crudlog_y2018m12 OWNER TO pgisn;

--
-- Name: core_crudlog_y2019m01; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.core_crudlog_y2019m01 (
    id integer DEFAULT nextval('public.core_crudlog_id_seq'::regclass),
    user_id integer,
    object_id integer,
    object_str character varying(250),
    model_name character varying(250),
    action_time timestamp with time zone,
    action character varying(6),
    CONSTRAINT core_crudlog_object_id_check CHECK ((object_id >= 0)),
    CONSTRAINT core_crudlog_user_id_check CHECK ((user_id >= 0)),
    CONSTRAINT core_crudlog_y2019m01_action_time_check CHECK (((action_time >= '2019-01-01 00:00:00+00'::timestamp with time zone) AND (action_time < '2019-02-01 00:00:00+00'::timestamp with time zone)))
)
INHERITS (public.core_crudlog);


ALTER TABLE public.core_crudlog_y2019m01 OWNER TO pgisn;

--
-- Name: core_crudlog_y2019m02; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.core_crudlog_y2019m02 (
    id integer DEFAULT nextval('public.core_crudlog_id_seq'::regclass),
    user_id integer,
    object_id integer,
    object_str character varying(250),
    model_name character varying(250),
    action_time timestamp with time zone,
    action character varying(6),
    CONSTRAINT core_crudlog_object_id_check CHECK ((object_id >= 0)),
    CONSTRAINT core_crudlog_user_id_check CHECK ((user_id >= 0)),
    CONSTRAINT core_crudlog_y2019m02_action_time_check CHECK (((action_time >= '2019-02-01 00:00:00+00'::timestamp with time zone) AND (action_time < '2019-03-01 00:00:00+00'::timestamp with time zone)))
)
INHERITS (public.core_crudlog);


ALTER TABLE public.core_crudlog_y2019m02 OWNER TO pgisn;

--
-- Name: core_crudlog_y2019m03; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.core_crudlog_y2019m03 (
    id integer DEFAULT nextval('public.core_crudlog_id_seq'::regclass),
    user_id integer,
    object_id integer,
    object_str character varying(250),
    model_name character varying(250),
    action_time timestamp with time zone,
    action character varying(6),
    CONSTRAINT core_crudlog_object_id_check CHECK ((object_id >= 0)),
    CONSTRAINT core_crudlog_user_id_check CHECK ((user_id >= 0)),
    CONSTRAINT core_crudlog_y2019m03_action_time_check CHECK (((action_time >= '2019-03-01 00:00:00+00'::timestamp with time zone) AND (action_time < '2019-04-01 00:00:00+00'::timestamp with time zone)))
)
INHERITS (public.core_crudlog);


ALTER TABLE public.core_crudlog_y2019m03 OWNER TO pgisn;

--
-- Name: core_crudlog_y2019m04; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.core_crudlog_y2019m04 (
    id integer DEFAULT nextval('public.core_crudlog_id_seq'::regclass),
    user_id integer,
    object_id integer,
    object_str character varying(250),
    model_name character varying(250),
    action_time timestamp with time zone,
    action character varying(6),
    CONSTRAINT core_crudlog_object_id_check CHECK ((object_id >= 0)),
    CONSTRAINT core_crudlog_user_id_check CHECK ((user_id >= 0)),
    CONSTRAINT core_crudlog_y2019m04_action_time_check CHECK (((action_time >= '2019-04-01 00:00:00+00'::timestamp with time zone) AND (action_time < '2019-05-01 00:00:00+00'::timestamp with time zone)))
)
INHERITS (public.core_crudlog);


ALTER TABLE public.core_crudlog_y2019m04 OWNER TO pgisn;

--
-- Name: core_crudlog_y2019m05; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.core_crudlog_y2019m05 (
    id integer DEFAULT nextval('public.core_crudlog_id_seq'::regclass),
    user_id integer,
    object_id integer,
    object_str character varying(250),
    model_name character varying(250),
    action_time timestamp with time zone,
    action character varying(6),
    CONSTRAINT core_crudlog_object_id_check CHECK ((object_id >= 0)),
    CONSTRAINT core_crudlog_user_id_check CHECK ((user_id >= 0)),
    CONSTRAINT core_crudlog_y2019m05_action_time_check CHECK (((action_time >= '2019-05-01 00:00:00+00'::timestamp with time zone) AND (action_time < '2019-06-01 00:00:00+00'::timestamp with time zone)))
)
INHERITS (public.core_crudlog);


ALTER TABLE public.core_crudlog_y2019m05 OWNER TO pgisn;

--
-- Name: core_crudlog_y2019m06; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.core_crudlog_y2019m06 (
    id integer DEFAULT nextval('public.core_crudlog_id_seq'::regclass),
    user_id integer,
    object_id integer,
    object_str character varying(250),
    model_name character varying(250),
    action_time timestamp with time zone,
    action character varying(6),
    CONSTRAINT core_crudlog_object_id_check CHECK ((object_id >= 0)),
    CONSTRAINT core_crudlog_user_id_check CHECK ((user_id >= 0)),
    CONSTRAINT core_crudlog_y2019m06_action_time_check CHECK (((action_time >= '2019-06-01 00:00:00+00'::timestamp with time zone) AND (action_time < '2019-07-01 00:00:00+00'::timestamp with time zone)))
)
INHERITS (public.core_crudlog);


ALTER TABLE public.core_crudlog_y2019m06 OWNER TO pgisn;

--
-- Name: core_crudlog_y2019m07; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.core_crudlog_y2019m07 (
    id integer DEFAULT nextval('public.core_crudlog_id_seq'::regclass),
    user_id integer,
    object_id integer,
    object_str character varying(250),
    model_name character varying(250),
    action_time timestamp with time zone,
    action character varying(6),
    CONSTRAINT core_crudlog_object_id_check CHECK ((object_id >= 0)),
    CONSTRAINT core_crudlog_user_id_check CHECK ((user_id >= 0)),
    CONSTRAINT core_crudlog_y2019m07_action_time_check CHECK (((action_time >= '2019-07-01 00:00:00+00'::timestamp with time zone) AND (action_time < '2019-08-01 00:00:00+00'::timestamp with time zone)))
)
INHERITS (public.core_crudlog);


ALTER TABLE public.core_crudlog_y2019m07 OWNER TO pgisn;

--
-- Name: core_crudlog_y2019m08; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.core_crudlog_y2019m08 (
    id integer DEFAULT nextval('public.core_crudlog_id_seq'::regclass),
    user_id integer,
    object_id integer,
    object_str character varying(250),
    model_name character varying(250),
    action_time timestamp with time zone,
    action character varying(6),
    CONSTRAINT core_crudlog_object_id_check CHECK ((object_id >= 0)),
    CONSTRAINT core_crudlog_user_id_check CHECK ((user_id >= 0)),
    CONSTRAINT core_crudlog_y2019m08_action_time_check CHECK (((action_time >= '2019-08-01 00:00:00+00'::timestamp with time zone) AND (action_time < '2019-09-01 00:00:00+00'::timestamp with time zone)))
)
INHERITS (public.core_crudlog);


ALTER TABLE public.core_crudlog_y2019m08 OWNER TO pgisn;

--
-- Name: core_crudlog_y2019m09; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.core_crudlog_y2019m09 (
    id integer DEFAULT nextval('public.core_crudlog_id_seq'::regclass),
    user_id integer,
    object_id integer,
    object_str character varying(250),
    model_name character varying(250),
    action_time timestamp with time zone,
    action character varying(6),
    CONSTRAINT core_crudlog_object_id_check CHECK ((object_id >= 0)),
    CONSTRAINT core_crudlog_user_id_check CHECK ((user_id >= 0)),
    CONSTRAINT core_crudlog_y2019m09_action_time_check CHECK (((action_time >= '2019-09-01 00:00:00+00'::timestamp with time zone) AND (action_time < '2019-10-01 00:00:00+00'::timestamp with time zone)))
)
INHERITS (public.core_crudlog);


ALTER TABLE public.core_crudlog_y2019m09 OWNER TO pgisn;

--
-- Name: core_crudlog_y2019m10; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.core_crudlog_y2019m10 (
    id integer DEFAULT nextval('public.core_crudlog_id_seq'::regclass),
    user_id integer,
    object_id integer,
    object_str character varying(250),
    model_name character varying(250),
    action_time timestamp with time zone,
    action character varying(6),
    CONSTRAINT core_crudlog_object_id_check CHECK ((object_id >= 0)),
    CONSTRAINT core_crudlog_user_id_check CHECK ((user_id >= 0)),
    CONSTRAINT core_crudlog_y2019m10_action_time_check CHECK (((action_time >= '2019-10-01 00:00:00+00'::timestamp with time zone) AND (action_time < '2019-11-01 00:00:00+00'::timestamp with time zone)))
)
INHERITS (public.core_crudlog);


ALTER TABLE public.core_crudlog_y2019m10 OWNER TO pgisn;

--
-- Name: core_crudlog_y2019m11; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.core_crudlog_y2019m11 (
    id integer DEFAULT nextval('public.core_crudlog_id_seq'::regclass),
    user_id integer,
    object_id integer,
    object_str character varying(250),
    model_name character varying(250),
    action_time timestamp with time zone,
    action character varying(6),
    CONSTRAINT core_crudlog_object_id_check CHECK ((object_id >= 0)),
    CONSTRAINT core_crudlog_user_id_check CHECK ((user_id >= 0)),
    CONSTRAINT core_crudlog_y2019m11_action_time_check CHECK (((action_time >= '2019-11-01 00:00:00+00'::timestamp with time zone) AND (action_time < '2019-12-01 00:00:00+00'::timestamp with time zone)))
)
INHERITS (public.core_crudlog);


ALTER TABLE public.core_crudlog_y2019m11 OWNER TO pgisn;

--
-- Name: core_crudlog_y2019m12; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.core_crudlog_y2019m12 (
    id integer DEFAULT nextval('public.core_crudlog_id_seq'::regclass),
    user_id integer,
    object_id integer,
    object_str character varying(250),
    model_name character varying(250),
    action_time timestamp with time zone,
    action character varying(6),
    CONSTRAINT core_crudlog_object_id_check CHECK ((object_id >= 0)),
    CONSTRAINT core_crudlog_user_id_check CHECK ((user_id >= 0)),
    CONSTRAINT core_crudlog_y2019m12_action_time_check CHECK (((action_time >= '2019-12-01 00:00:00+00'::timestamp with time zone) AND (action_time < '2020-01-01 00:00:00+00'::timestamp with time zone)))
)
INHERITS (public.core_crudlog);


ALTER TABLE public.core_crudlog_y2019m12 OWNER TO pgisn;

--
-- Name: core_crudlog_y2020m01; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.core_crudlog_y2020m01 (
    id integer DEFAULT nextval('public.core_crudlog_id_seq'::regclass),
    user_id integer,
    object_id integer,
    object_str character varying(250),
    model_name character varying(250),
    action_time timestamp with time zone,
    action character varying(6),
    CONSTRAINT core_crudlog_object_id_check CHECK ((object_id >= 0)),
    CONSTRAINT core_crudlog_user_id_check CHECK ((user_id >= 0)),
    CONSTRAINT core_crudlog_y2020m01_action_time_check CHECK (((action_time >= '2020-01-01 00:00:00+00'::timestamp with time zone) AND (action_time < '2020-02-01 00:00:00+00'::timestamp with time zone)))
)
INHERITS (public.core_crudlog);


ALTER TABLE public.core_crudlog_y2020m01 OWNER TO pgisn;

--
-- Name: core_crudlog_y2020m02; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.core_crudlog_y2020m02 (
    id integer DEFAULT nextval('public.core_crudlog_id_seq'::regclass),
    user_id integer,
    object_id integer,
    object_str character varying(250),
    model_name character varying(250),
    action_time timestamp with time zone,
    action character varying(6),
    CONSTRAINT core_crudlog_object_id_check CHECK ((object_id >= 0)),
    CONSTRAINT core_crudlog_user_id_check CHECK ((user_id >= 0)),
    CONSTRAINT core_crudlog_y2020m02_action_time_check CHECK (((action_time >= '2020-02-01 00:00:00+00'::timestamp with time zone) AND (action_time < '2020-03-01 00:00:00+00'::timestamp with time zone)))
)
INHERITS (public.core_crudlog);


ALTER TABLE public.core_crudlog_y2020m02 OWNER TO pgisn;

--
-- Name: core_emailsuitesetting; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.core_emailsuitesetting (
    id integer NOT NULL,
    host character varying(150) NOT NULL,
    port character varying(5) NOT NULL,
    username character varying(100) NOT NULL,
    password character varying(150) NOT NULL,
    use_tls boolean NOT NULL,
    active boolean NOT NULL
);


ALTER TABLE public.core_emailsuitesetting OWNER TO pgisn;

--
-- Name: core_emailsuitesetting_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.core_emailsuitesetting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_emailsuitesetting_id_seq OWNER TO pgisn;

--
-- Name: core_emailsuitesetting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.core_emailsuitesetting_id_seq OWNED BY public.core_emailsuitesetting.id;


--
-- Name: core_loggedusers; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.core_loggedusers (
    id integer NOT NULL,
    last_login timestamp with time zone,
    last_logout timestamp with time zone,
    is_online boolean NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.core_loggedusers OWNER TO pgisn;

--
-- Name: core_loggedusers_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.core_loggedusers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_loggedusers_id_seq OWNER TO pgisn;

--
-- Name: core_loggedusers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.core_loggedusers_id_seq OWNED BY public.core_loggedusers.id;


--
-- Name: core_module; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.core_module (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    app_label character varying(50) NOT NULL,
    verbose_name character varying(100),
    version character varying(20) NOT NULL,
    category character varying(100),
    sequence integer NOT NULL,
    website character varying(255),
    description text,
    author character varying(100),
    author_email character varying(254),
    license character varying(100),
    depends character varying(100),
    is_install boolean NOT NULL,
    is_enabled boolean NOT NULL,
    installable boolean NOT NULL,
    init_data_loaded boolean NOT NULL,
    has_init_data boolean NOT NULL,
    import_data_loaded boolean NOT NULL,
    has_import_data boolean NOT NULL,
    icon character varying(20),
    has_test_data boolean NOT NULL,
    test_data_loaded boolean NOT NULL
);


ALTER TABLE public.core_module OWNER TO pgisn;

--
-- Name: core_module_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.core_module_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_module_id_seq OWNER TO pgisn;

--
-- Name: core_module_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.core_module_id_seq OWNED BY public.core_module.id;


--
-- Name: core_singlesignon; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.core_singlesignon (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    public_key text NOT NULL,
    private_key text NOT NULL,
    method character varying(1) NOT NULL,
    description text NOT NULL,
    active boolean NOT NULL,
    sso_timeout integer NOT NULL,
    is_default boolean NOT NULL,
    iv text NOT NULL,
    template character varying(255) NOT NULL
);


ALTER TABLE public.core_singlesignon OWNER TO pgisn;

--
-- Name: core_singlesignon_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.core_singlesignon_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_singlesignon_id_seq OWNER TO pgisn;

--
-- Name: core_singlesignon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.core_singlesignon_id_seq OWNED BY public.core_singlesignon.id;


--
-- Name: core_ssotoken; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.core_ssotoken (
    id integer NOT NULL,
    request_token character varying(255) NOT NULL,
    access_status boolean NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    redirect_to character varying(255) NOT NULL,
    consumer_id integer NOT NULL,
    user_id integer,
    access_token character varying(255) NOT NULL
);


ALTER TABLE public.core_ssotoken OWNER TO pgisn;

--
-- Name: core_ssotoken_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.core_ssotoken_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_ssotoken_id_seq OWNER TO pgisn;

--
-- Name: core_ssotoken_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.core_ssotoken_id_seq OWNED BY public.core_ssotoken.id;


--
-- Name: core_suitepreference; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.core_suitepreference (
    id integer NOT NULL,
    level_log character varying(1),
    module_id integer NOT NULL,
    show_events_tab boolean NOT NULL,
    show_activity_tab boolean NOT NULL,
    client_session_timeout integer NOT NULL,
    rw_show_pin_tab boolean NOT NULL,
    show_employee_tab boolean NOT NULL,
    CONSTRAINT core_suitepreference_client_session_timeout_check CHECK ((client_session_timeout >= 0))
);


ALTER TABLE public.core_suitepreference OWNER TO pgisn;

--
-- Name: core_suitepreference_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.core_suitepreference_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_suitepreference_id_seq OWNER TO pgisn;

--
-- Name: core_suitepreference_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.core_suitepreference_id_seq OWNED BY public.core_suitepreference.id;


--
-- Name: core_userprofile; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.core_userprofile (
    id integer NOT NULL,
    ci character varying(25) NOT NULL,
    avatar character varying(100),
    title character varying(150),
    user_id integer NOT NULL
);


ALTER TABLE public.core_userprofile OWNER TO pgisn;

--
-- Name: core_userprofile_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.core_userprofile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_userprofile_id_seq OWNER TO pgisn;

--
-- Name: core_userprofile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.core_userprofile_id_seq OWNED BY public.core_userprofile.id;


--
-- Name: data_migration_datafiles; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.data_migration_datafiles (
    id integer NOT NULL,
    file character varying(250) NOT NULL,
    description text NOT NULL,
    user_id integer,
    "timestamp" timestamp with time zone NOT NULL
);


ALTER TABLE public.data_migration_datafiles OWNER TO pgisn;

--
-- Name: data_migration_datafiles_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.data_migration_datafiles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.data_migration_datafiles_id_seq OWNER TO pgisn;

--
-- Name: data_migration_datafiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.data_migration_datafiles_id_seq OWNED BY public.data_migration_datafiles.id;


--
-- Name: data_migration_profile; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.data_migration_profile (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    field_ref character varying(255),
    model character varying(255) NOT NULL,
    description text NOT NULL,
    field_map public.hstore NOT NULL,
    file_to_import character varying(255) NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    type character varying(1) NOT NULL,
    executed boolean NOT NULL,
    delete_data boolean NOT NULL,
    dependency_id integer,
    processor_code text NOT NULL,
    stop_on_error boolean NOT NULL
);


ALTER TABLE public.data_migration_profile OWNER TO pgisn;

--
-- Name: data_migration_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.data_migration_profile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.data_migration_profile_id_seq OWNER TO pgisn;

--
-- Name: data_migration_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.data_migration_profile_id_seq OWNED BY public.data_migration_profile.id;


--
-- Name: data_migration_reference; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.data_migration_reference (
    id integer NOT NULL,
    internal integer NOT NULL,
    external character varying(100) NOT NULL,
    profile_id integer NOT NULL,
    CONSTRAINT data_migration_reference_internal_check CHECK ((internal >= 0))
);


ALTER TABLE public.data_migration_reference OWNER TO pgisn;

--
-- Name: data_migration_reference_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.data_migration_reference_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.data_migration_reference_id_seq OWNER TO pgisn;

--
-- Name: data_migration_reference_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.data_migration_reference_id_seq OWNED BY public.data_migration_reference.id;


--
-- Name: dbm_address; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_address (
    id integer NOT NULL,
    address1 character varying(200) NOT NULL,
    address2 character varying(200) NOT NULL,
    city_id integer
);


ALTER TABLE public.dbm_address OWNER TO pgisn;

--
-- Name: dbm_address_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.dbm_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dbm_address_id_seq OWNER TO pgisn;

--
-- Name: dbm_address_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.dbm_address_id_seq OWNED BY public.dbm_address.id;


--
-- Name: dbm_bolo; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_bolo (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(150) NOT NULL,
    unit character varying(255) NOT NULL,
    tag character varying(100) NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.dbm_bolo OWNER TO pgisn;

--
-- Name: dbm_bolo_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.dbm_bolo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dbm_bolo_id_seq OWNER TO pgisn;

--
-- Name: dbm_bolo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.dbm_bolo_id_seq OWNED BY public.dbm_bolo.id;


--
-- Name: dbm_car; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_car (
    id integer NOT NULL,
    plate character varying(50) NOT NULL,
    "registrationDate" date NOT NULL,
    "expirationDate" date,
    year integer,
    "mainColor_id" integer NOT NULL,
    model_id integer NOT NULL,
    owner_id integer,
    "secColor_id" integer,
    state_id integer,
    company text NOT NULL,
    miscellany1 text NOT NULL,
    miscellany2 text NOT NULL,
    CONSTRAINT dbm_car_year_check CHECK ((year >= 0))
);


ALTER TABLE public.dbm_car OWNER TO pgisn;

--
-- Name: dbm_car_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.dbm_car_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dbm_car_id_seq OWNER TO pgisn;

--
-- Name: dbm_car_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.dbm_car_id_seq OWNED BY public.dbm_car.id;


--
-- Name: dbm_carmodel; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_carmodel (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    "releaseYear" integer,
    make_id integer,
    CONSTRAINT "dbm_carmodel_releaseYear_check" CHECK (("releaseYear" >= 0))
);


ALTER TABLE public.dbm_carmodel OWNER TO pgisn;

--
-- Name: dbm_carmodel_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.dbm_carmodel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dbm_carmodel_id_seq OWNER TO pgisn;

--
-- Name: dbm_carmodel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.dbm_carmodel_id_seq OWNED BY public.dbm_carmodel.id;


--
-- Name: dbm_category; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_category (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    family character varying(2),
    lft integer NOT NULL,
    rght integer NOT NULL,
    tree_id integer NOT NULL,
    level integer NOT NULL,
    parent_id integer,
    locked boolean NOT NULL,
    CONSTRAINT dbm_category_level_check CHECK ((level >= 0)),
    CONSTRAINT dbm_category_lft_check CHECK ((lft >= 0)),
    CONSTRAINT dbm_category_rght_check CHECK ((rght >= 0)),
    CONSTRAINT dbm_category_tree_id_check CHECK ((tree_id >= 0))
);


ALTER TABLE public.dbm_category OWNER TO pgisn;

--
-- Name: dbm_category_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.dbm_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dbm_category_id_seq OWNER TO pgisn;

--
-- Name: dbm_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.dbm_category_id_seq OWNED BY public.dbm_category.id;


--
-- Name: dbm_city; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_city (
    id integer NOT NULL,
    code character varying(20),
    name character varying(165) NOT NULL,
    zip_code character varying(10) NOT NULL,
    county_id integer,
    state_id integer NOT NULL
);


ALTER TABLE public.dbm_city OWNER TO pgisn;

--
-- Name: dbm_city_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.dbm_city_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dbm_city_id_seq OWNER TO pgisn;

--
-- Name: dbm_city_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.dbm_city_id_seq OWNED BY public.dbm_city.id;


--
-- Name: dbm_color; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_color (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    hexa character varying(18) NOT NULL
);


ALTER TABLE public.dbm_color OWNER TO pgisn;

--
-- Name: dbm_color_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.dbm_color_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dbm_color_id_seq OWNER TO pgisn;

--
-- Name: dbm_color_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.dbm_color_id_seq OWNED BY public.dbm_color.id;


--
-- Name: dbm_community; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_community (
    area double precision NOT NULL,
    phone character varying(50) NOT NULL,
    email character varying(254) NOT NULL,
    has_member_number boolean NOT NULL,
    has_real_states boolean NOT NULL,
    client_url character varying(200) NOT NULL,
    confirm_btn boolean NOT NULL,
    show_qrcode boolean NOT NULL,
    rw_edit_mode boolean NOT NULL,
    logo character varying(250),
    logo_monochrome character varying(250),
    max_speed integer NOT NULL,
    max_speed_picture character varying(250),
    logo_zpt text NOT NULL,
    show_building boolean NOT NULL,
    badge character varying(250),
    firebase_short_domain character varying(255) NOT NULL,
    firebase_short_key character varying(255) NOT NULL,
    show_events_tab boolean NOT NULL,
    show_activity_tab boolean NOT NULL,
    client_session_timeout integer NOT NULL,
    rw_show_pin_tab boolean NOT NULL,
    show_employee_tab boolean NOT NULL,
    entity_id integer NOT NULL,
    CONSTRAINT dbm_community_client_session_timeout_check CHECK ((client_session_timeout >= 0))
);


ALTER TABLE public.dbm_community OWNER TO pgisn;

--
-- Name: dbm_company; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_company (
    id integer NOT NULL,
    name character varying(200),
    "registrationDate" date NOT NULL,
    type character varying(1) NOT NULL,
    acronym character varying(50),
    category character varying(250) NOT NULL
);


ALTER TABLE public.dbm_company OWNER TO pgisn;

--
-- Name: dbm_company_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.dbm_company_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dbm_company_id_seq OWNER TO pgisn;

--
-- Name: dbm_company_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.dbm_company_id_seq OWNED BY public.dbm_company.id;


--
-- Name: dbm_contact; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_contact (
    id integer NOT NULL,
    "nickName" character varying(100) NOT NULL,
    website character varying(200) NOT NULL,
    address_id integer,
    company_id integer,
    unit_id integer
);


ALTER TABLE public.dbm_contact OWNER TO pgisn;

--
-- Name: dbm_contact_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.dbm_contact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dbm_contact_id_seq OWNER TO pgisn;

--
-- Name: dbm_contact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.dbm_contact_id_seq OWNED BY public.dbm_contact.id;


--
-- Name: dbm_contact_persons; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_contact_persons (
    id integer NOT NULL,
    contact_id integer NOT NULL,
    person_id integer NOT NULL
);


ALTER TABLE public.dbm_contact_persons OWNER TO pgisn;

--
-- Name: dbm_contact_persons_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.dbm_contact_persons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dbm_contact_persons_id_seq OWNER TO pgisn;

--
-- Name: dbm_contact_persons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.dbm_contact_persons_id_seq OWNED BY public.dbm_contact_persons.id;


--
-- Name: dbm_contract; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_contract (
    id integer NOT NULL,
    number character varying(50) NOT NULL,
    "expirationDate" date NOT NULL,
    responsible_id integer,
    community_id integer
);


ALTER TABLE public.dbm_contract OWNER TO pgisn;

--
-- Name: dbm_contract_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.dbm_contract_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dbm_contract_id_seq OWNER TO pgisn;

--
-- Name: dbm_contract_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.dbm_contract_id_seq OWNED BY public.dbm_contract.id;


--
-- Name: dbm_county; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_county (
    id integer NOT NULL,
    name character varying(165) NOT NULL,
    code character varying(10),
    state_id integer NOT NULL
);


ALTER TABLE public.dbm_county OWNER TO pgisn;

--
-- Name: dbm_county_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.dbm_county_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dbm_county_id_seq OWNER TO pgisn;

--
-- Name: dbm_county_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.dbm_county_id_seq OWNED BY public.dbm_county.id;


--
-- Name: dbm_decal; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_decal (
    id integer NOT NULL,
    code character varying(20) NOT NULL,
    issued date NOT NULL,
    expires date NOT NULL,
    description text NOT NULL,
    active boolean NOT NULL,
    vehicle_id integer NOT NULL
);


ALTER TABLE public.dbm_decal OWNER TO pgisn;

--
-- Name: dbm_decal_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.dbm_decal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dbm_decal_id_seq OWNER TO pgisn;

--
-- Name: dbm_decal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.dbm_decal_id_seq OWNED BY public.dbm_decal.id;


--
-- Name: dbm_direction; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_direction (
    id integer NOT NULL,
    description text NOT NULL,
    gate_id integer NOT NULL,
    unit_id integer NOT NULL
);


ALTER TABLE public.dbm_direction OWNER TO pgisn;

--
-- Name: dbm_direction_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.dbm_direction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dbm_direction_id_seq OWNER TO pgisn;

--
-- Name: dbm_direction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.dbm_direction_id_seq OWNED BY public.dbm_direction.id;


--
-- Name: dbm_drive; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_drive (
    id integer NOT NULL,
    person_id integer
);


ALTER TABLE public.dbm_drive OWNER TO pgisn;

--
-- Name: dbm_drive_cars; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_drive_cars (
    id integer NOT NULL,
    drive_id integer NOT NULL,
    car_id integer NOT NULL
);


ALTER TABLE public.dbm_drive_cars OWNER TO pgisn;

--
-- Name: dbm_drive_cars_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.dbm_drive_cars_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dbm_drive_cars_id_seq OWNER TO pgisn;

--
-- Name: dbm_drive_cars_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.dbm_drive_cars_id_seq OWNED BY public.dbm_drive_cars.id;


--
-- Name: dbm_drive_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.dbm_drive_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dbm_drive_id_seq OWNER TO pgisn;

--
-- Name: dbm_drive_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.dbm_drive_id_seq OWNED BY public.dbm_drive.id;


--
-- Name: dbm_email; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_email (
    id integer NOT NULL,
    email character varying(150) NOT NULL,
    is_default boolean NOT NULL,
    category_id integer,
    contact_id integer,
    description text NOT NULL
);


ALTER TABLE public.dbm_email OWNER TO pgisn;

--
-- Name: dbm_email_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.dbm_email_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dbm_email_id_seq OWNER TO pgisn;

--
-- Name: dbm_email_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.dbm_email_id_seq OWNED BY public.dbm_email.id;


--
-- Name: dbm_employee; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_employee (
    person_ptr_id integer NOT NULL,
    work_time character varying(100),
    company_id integer,
    unit_id integer
);


ALTER TABLE public.dbm_employee OWNER TO pgisn;

--
-- Name: dbm_entity; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_entity (
    id integer NOT NULL,
    name character varying(100),
    code character varying(20) NOT NULL,
    latitude double precision,
    longitude double precision
);


ALTER TABLE public.dbm_entity OWNER TO pgisn;

--
-- Name: dbm_entity_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.dbm_entity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dbm_entity_id_seq OWNER TO pgisn;

--
-- Name: dbm_entity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.dbm_entity_id_seq OWNED BY public.dbm_entity.id;


--
-- Name: dbm_event; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_event (
    id integer NOT NULL,
    invitation_flag boolean NOT NULL,
    start timestamp with time zone NOT NULL,
    "end" timestamp with time zone NOT NULL,
    name character varying(100) NOT NULL,
    purpose text,
    type character varying(1) NOT NULL,
    frequency character varying(4) NOT NULL,
    repeat_until date,
    object_id integer,
    content_type_id integer,
    weekdays character varying(13) NOT NULL,
    finish timestamp with time zone,
    next_start timestamp with time zone,
    CONSTRAINT dbm_event_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE public.dbm_event OWNER TO pgisn;

--
-- Name: dbm_event_guest_list; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_event_guest_list (
    id integer NOT NULL,
    event_id integer NOT NULL,
    guest_id integer NOT NULL
);


ALTER TABLE public.dbm_event_guest_list OWNER TO pgisn;

--
-- Name: dbm_event_guest_list_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.dbm_event_guest_list_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dbm_event_guest_list_id_seq OWNER TO pgisn;

--
-- Name: dbm_event_guest_list_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.dbm_event_guest_list_id_seq OWNED BY public.dbm_event_guest_list.id;


--
-- Name: dbm_event_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.dbm_event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dbm_event_id_seq OWNER TO pgisn;

--
-- Name: dbm_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.dbm_event_id_seq OWNED BY public.dbm_event.id;


--
-- Name: dbm_gate; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_gate (
    cardinal character varying(2) NOT NULL,
    subcommunity_id integer,
    entity_id integer NOT NULL
);


ALTER TABLE public.dbm_gate OWNER TO pgisn;

--
-- Name: dbm_guest; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_guest (
    person_ptr_id integer NOT NULL,
    "isActive" boolean,
    permanent boolean NOT NULL,
    type character varying(1) NOT NULL,
    "specialInstructions" text,
    avatar character varying(250),
    company_id integer,
    host_id integer,
    unit_id integer,
    temporary boolean NOT NULL
);


ALTER TABLE public.dbm_guest OWNER TO pgisn;

--
-- Name: dbm_lease; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_lease (
    id integer NOT NULL,
    expiration_date timestamp with time zone NOT NULL,
    start_date timestamp with time zone NOT NULL,
    is_renewable boolean NOT NULL,
    unit_id integer NOT NULL,
    payed boolean NOT NULL,
    price numeric(8,2) NOT NULL
);


ALTER TABLE public.dbm_lease OWNER TO pgisn;

--
-- Name: dbm_lease_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.dbm_lease_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dbm_lease_id_seq OWNER TO pgisn;

--
-- Name: dbm_lease_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.dbm_lease_id_seq OWNED BY public.dbm_lease.id;


--
-- Name: dbm_make; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_make (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.dbm_make OWNER TO pgisn;

--
-- Name: dbm_make_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.dbm_make_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dbm_make_id_seq OWNER TO pgisn;

--
-- Name: dbm_make_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.dbm_make_id_seq OWNED BY public.dbm_make.id;


--
-- Name: dbm_owner; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_owner (
    id integer NOT NULL,
    person_id integer
);


ALTER TABLE public.dbm_owner OWNER TO pgisn;

--
-- Name: dbm_owner_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.dbm_owner_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dbm_owner_id_seq OWNER TO pgisn;

--
-- Name: dbm_owner_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.dbm_owner_id_seq OWNED BY public.dbm_owner.id;


--
-- Name: dbm_owner_units; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_owner_units (
    id integer NOT NULL,
    owner_id integer NOT NULL,
    unit_id integer NOT NULL
);


ALTER TABLE public.dbm_owner_units OWNER TO pgisn;

--
-- Name: dbm_owner_units_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.dbm_owner_units_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dbm_owner_units_id_seq OWNER TO pgisn;

--
-- Name: dbm_owner_units_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.dbm_owner_units_id_seq OWNED BY public.dbm_owner_units.id;


--
-- Name: dbm_person; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_person (
    id integer NOT NULL,
    "firstName" character varying(100) NOT NULL,
    "lastName" character varying(100) NOT NULL,
    pin character varying(128) NOT NULL,
    member_number character varying(128) NOT NULL,
    sex character varying(1) NOT NULL,
    description text NOT NULL,
    category_id integer,
    license_number character varying(15) NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL
);


ALTER TABLE public.dbm_person OWNER TO pgisn;

--
-- Name: dbm_person_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.dbm_person_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dbm_person_id_seq OWNER TO pgisn;

--
-- Name: dbm_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.dbm_person_id_seq OWNED BY public.dbm_person.id;


--
-- Name: dbm_pet; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_pet (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    ci character varying(10) NOT NULL,
    description text,
    pet_category_id integer,
    owner_id integer NOT NULL
);


ALTER TABLE public.dbm_pet OWNER TO pgisn;

--
-- Name: dbm_pet_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.dbm_pet_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dbm_pet_id_seq OWNER TO pgisn;

--
-- Name: dbm_pet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.dbm_pet_id_seq OWNED BY public.dbm_pet.id;


--
-- Name: dbm_phone; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_phone (
    id integer NOT NULL,
    phone character varying(50) NOT NULL,
    is_default boolean NOT NULL,
    carrier_id integer,
    category_id integer,
    contact_id integer,
    description text NOT NULL
);


ALTER TABLE public.dbm_phone OWNER TO pgisn;

--
-- Name: dbm_phone_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.dbm_phone_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dbm_phone_id_seq OWNER TO pgisn;

--
-- Name: dbm_phone_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.dbm_phone_id_seq OWNED BY public.dbm_phone.id;


--
-- Name: dbm_phonecarrier; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_phonecarrier (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    sms character varying(250) NOT NULL,
    mms character varying(250) NOT NULL
);


ALTER TABLE public.dbm_phonecarrier OWNER TO pgisn;

--
-- Name: dbm_phonecarrier_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.dbm_phonecarrier_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dbm_phonecarrier_id_seq OWNER TO pgisn;

--
-- Name: dbm_phonecarrier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.dbm_phonecarrier_id_seq OWNED BY public.dbm_phonecarrier.id;


--
-- Name: dbm_photo; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_photo (
    id integer NOT NULL,
    photo character varying(250) NOT NULL,
    "default" boolean NOT NULL,
    object_id integer,
    category_id integer NOT NULL,
    content_type_id integer,
    CONSTRAINT dbm_photo_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE public.dbm_photo OWNER TO pgisn;

--
-- Name: dbm_photo_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.dbm_photo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dbm_photo_id_seq OWNER TO pgisn;

--
-- Name: dbm_photo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.dbm_photo_id_seq OWNED BY public.dbm_photo.id;


--
-- Name: dbm_realstate; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_realstate (
    id integer NOT NULL,
    count integer NOT NULL,
    category_id integer NOT NULL,
    unit_id integer NOT NULL,
    CONSTRAINT dbm_realstate_count_check CHECK ((count >= 0))
);


ALTER TABLE public.dbm_realstate OWNER TO pgisn;

--
-- Name: dbm_realstate_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.dbm_realstate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dbm_realstate_id_seq OWNER TO pgisn;

--
-- Name: dbm_realstate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.dbm_realstate_id_seq OWNED BY public.dbm_realstate.id;


--
-- Name: dbm_resident; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_resident (
    person_ptr_id integer NOT NULL,
    residence_id integer,
    master boolean NOT NULL,
    lease_id integer
);


ALTER TABLE public.dbm_resident OWNER TO pgisn;

--
-- Name: dbm_state; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_state (
    id integer NOT NULL,
    name character varying(165) NOT NULL,
    code character varying(5),
    country character varying(2)
);


ALTER TABLE public.dbm_state OWNER TO pgisn;

--
-- Name: dbm_state_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.dbm_state_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dbm_state_id_seq OWNER TO pgisn;

--
-- Name: dbm_state_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.dbm_state_id_seq OWNED BY public.dbm_state.id;


--
-- Name: dbm_subcommunity; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_subcommunity (
    community_id integer,
    entity_id integer NOT NULL
);


ALTER TABLE public.dbm_subcommunity OWNER TO pgisn;

--
-- Name: dbm_unit; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.dbm_unit (
    entity_ptr_id integer NOT NULL,
    flag_message text,
    admin_notes text,
    description text,
    "isActive" boolean NOT NULL,
    category_id integer,
    "subCommunity_id" integer,
    lot_number character varying(255) NOT NULL,
    emergency text,
    building character varying(150) NOT NULL
);


ALTER TABLE public.dbm_unit OWNER TO pgisn;

--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO pgisn;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO pgisn;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_celery_beat_clockedschedule; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.django_celery_beat_clockedschedule (
    id integer NOT NULL,
    clocked_time timestamp with time zone NOT NULL,
    enabled boolean NOT NULL
);


ALTER TABLE public.django_celery_beat_clockedschedule OWNER TO pgisn;

--
-- Name: django_celery_beat_clockedschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.django_celery_beat_clockedschedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_celery_beat_clockedschedule_id_seq OWNER TO pgisn;

--
-- Name: django_celery_beat_clockedschedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.django_celery_beat_clockedschedule_id_seq OWNED BY public.django_celery_beat_clockedschedule.id;


--
-- Name: django_celery_beat_crontabschedule; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.django_celery_beat_crontabschedule (
    id integer NOT NULL,
    minute character varying(240) NOT NULL,
    hour character varying(96) NOT NULL,
    day_of_week character varying(64) NOT NULL,
    day_of_month character varying(124) NOT NULL,
    month_of_year character varying(64) NOT NULL,
    timezone character varying(63) NOT NULL
);


ALTER TABLE public.django_celery_beat_crontabschedule OWNER TO pgisn;

--
-- Name: django_celery_beat_crontabschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.django_celery_beat_crontabschedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_celery_beat_crontabschedule_id_seq OWNER TO pgisn;

--
-- Name: django_celery_beat_crontabschedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.django_celery_beat_crontabschedule_id_seq OWNED BY public.django_celery_beat_crontabschedule.id;


--
-- Name: django_celery_beat_intervalschedule; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.django_celery_beat_intervalschedule (
    id integer NOT NULL,
    every integer NOT NULL,
    period character varying(24) NOT NULL
);


ALTER TABLE public.django_celery_beat_intervalschedule OWNER TO pgisn;

--
-- Name: django_celery_beat_intervalschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.django_celery_beat_intervalschedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_celery_beat_intervalschedule_id_seq OWNER TO pgisn;

--
-- Name: django_celery_beat_intervalschedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.django_celery_beat_intervalschedule_id_seq OWNED BY public.django_celery_beat_intervalschedule.id;


--
-- Name: django_celery_beat_periodictask; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.django_celery_beat_periodictask (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    task character varying(200) NOT NULL,
    args text NOT NULL,
    kwargs text NOT NULL,
    queue character varying(200),
    exchange character varying(200),
    routing_key character varying(200),
    expires timestamp with time zone,
    enabled boolean NOT NULL,
    last_run_at timestamp with time zone,
    total_run_count integer NOT NULL,
    date_changed timestamp with time zone NOT NULL,
    description text NOT NULL,
    crontab_id integer,
    interval_id integer,
    solar_id integer,
    one_off boolean NOT NULL,
    start_time timestamp with time zone,
    priority integer,
    headers text NOT NULL,
    clocked_id integer,
    CONSTRAINT django_celery_beat_periodictask_priority_check CHECK ((priority >= 0)),
    CONSTRAINT django_celery_beat_periodictask_total_run_count_check CHECK ((total_run_count >= 0))
);


ALTER TABLE public.django_celery_beat_periodictask OWNER TO pgisn;

--
-- Name: django_celery_beat_periodictask_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.django_celery_beat_periodictask_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_celery_beat_periodictask_id_seq OWNER TO pgisn;

--
-- Name: django_celery_beat_periodictask_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.django_celery_beat_periodictask_id_seq OWNED BY public.django_celery_beat_periodictask.id;


--
-- Name: django_celery_beat_periodictasks; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.django_celery_beat_periodictasks (
    ident smallint NOT NULL,
    last_update timestamp with time zone NOT NULL
);


ALTER TABLE public.django_celery_beat_periodictasks OWNER TO pgisn;

--
-- Name: django_celery_beat_solarschedule; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.django_celery_beat_solarschedule (
    id integer NOT NULL,
    event character varying(24) NOT NULL,
    latitude numeric(9,6) NOT NULL,
    longitude numeric(9,6) NOT NULL
);


ALTER TABLE public.django_celery_beat_solarschedule OWNER TO pgisn;

--
-- Name: django_celery_beat_solarschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.django_celery_beat_solarschedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_celery_beat_solarschedule_id_seq OWNER TO pgisn;

--
-- Name: django_celery_beat_solarschedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.django_celery_beat_solarschedule_id_seq OWNED BY public.django_celery_beat_solarschedule.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO pgisn;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO pgisn;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO pgisn;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO pgisn;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO pgisn;

--
-- Name: django_twilio_caller; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.django_twilio_caller (
    id integer NOT NULL,
    blacklisted boolean NOT NULL,
    phone_number character varying(128) NOT NULL
);


ALTER TABLE public.django_twilio_caller OWNER TO pgisn;

--
-- Name: django_twilio_caller_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.django_twilio_caller_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_twilio_caller_id_seq OWNER TO pgisn;

--
-- Name: django_twilio_caller_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.django_twilio_caller_id_seq OWNED BY public.django_twilio_caller.id;


--
-- Name: django_twilio_credential; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.django_twilio_credential (
    id integer NOT NULL,
    name character varying(30) NOT NULL,
    account_sid character varying(34) NOT NULL,
    auth_token character varying(32) NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.django_twilio_credential OWNER TO pgisn;

--
-- Name: django_twilio_credential_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.django_twilio_credential_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_twilio_credential_id_seq OWNER TO pgisn;

--
-- Name: django_twilio_credential_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.django_twilio_credential_id_seq OWNED BY public.django_twilio_credential.id;


--
-- Name: incident_report_icar; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.incident_report_icar (
    id integer NOT NULL,
    plate character varying(50) NOT NULL,
    state character varying(3) NOT NULL,
    model character varying(50) NOT NULL,
    make character varying(50) NOT NULL,
    description text NOT NULL,
    incident_id integer
);


ALTER TABLE public.incident_report_icar OWNER TO pgisn;

--
-- Name: incident_report_icar_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.incident_report_icar_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.incident_report_icar_id_seq OWNER TO pgisn;

--
-- Name: incident_report_icar_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.incident_report_icar_id_seq OWNED BY public.incident_report_icar.id;


--
-- Name: incident_report_icategory; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.incident_report_icategory (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    lft integer NOT NULL,
    rght integer NOT NULL,
    tree_id integer NOT NULL,
    level integer NOT NULL,
    parent_id integer,
    CONSTRAINT incident_report_icategory_level_check CHECK ((level >= 0)),
    CONSTRAINT incident_report_icategory_lft_check CHECK ((lft >= 0)),
    CONSTRAINT incident_report_icategory_rght_check CHECK ((rght >= 0)),
    CONSTRAINT incident_report_icategory_tree_id_check CHECK ((tree_id >= 0))
);


ALTER TABLE public.incident_report_icategory OWNER TO pgisn;

--
-- Name: incident_report_icategory_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.incident_report_icategory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.incident_report_icategory_id_seq OWNER TO pgisn;

--
-- Name: incident_report_icategory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.incident_report_icategory_id_seq OWNED BY public.incident_report_icategory.id;


--
-- Name: incident_report_incident; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.incident_report_incident (
    id integer NOT NULL,
    number character varying(20),
    name character varying(100) NOT NULL,
    registered_date timestamp with time zone NOT NULL,
    occurred_date timestamp with time zone NOT NULL,
    area character varying(200) NOT NULL,
    cause character varying(200) NOT NULL,
    latitude double precision,
    longitude double precision,
    description text NOT NULL,
    category_id integer,
    subcommunity_id integer,
    address character varying(200) NOT NULL,
    disposition_id integer,
    updated_date timestamp with time zone NOT NULL,
    owner_id integer NOT NULL,
    responsible_id integer,
    status_id integer
);


ALTER TABLE public.incident_report_incident OWNER TO pgisn;

--
-- Name: incident_report_incident_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.incident_report_incident_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.incident_report_incident_id_seq OWNER TO pgisn;

--
-- Name: incident_report_incident_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.incident_report_incident_id_seq OWNED BY public.incident_report_incident.id;


--
-- Name: incident_report_incidentstatus; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.incident_report_incidentstatus (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    color character varying(50) NOT NULL,
    description text
);


ALTER TABLE public.incident_report_incidentstatus OWNER TO pgisn;

--
-- Name: incident_report_incidentstatus_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.incident_report_incidentstatus_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.incident_report_incidentstatus_id_seq OWNER TO pgisn;

--
-- Name: incident_report_incidentstatus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.incident_report_incidentstatus_id_seq OWNED BY public.incident_report_incidentstatus.id;


--
-- Name: incident_report_iperson; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.incident_report_iperson (
    id integer NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    person_ref integer NOT NULL,
    phone character varying(200) NOT NULL,
    license_number character varying(50) NOT NULL,
    special text NOT NULL,
    description text NOT NULL,
    type character varying(20) NOT NULL,
    incident_id integer,
    relationship character varying(255) NOT NULL,
    CONSTRAINT incident_report_iperson_person_ref_check CHECK ((person_ref >= 0))
);


ALTER TABLE public.incident_report_iperson OWNER TO pgisn;

--
-- Name: incident_report_iperson_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.incident_report_iperson_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.incident_report_iperson_id_seq OWNER TO pgisn;

--
-- Name: incident_report_iperson_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.incident_report_iperson_id_seq OWNED BY public.incident_report_iperson.id;


--
-- Name: incident_report_iunit; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.incident_report_iunit (
    id integer NOT NULL,
    code character varying(25) NOT NULL,
    address character varying(255) NOT NULL,
    description text NOT NULL,
    incident_id integer
);


ALTER TABLE public.incident_report_iunit OWNER TO pgisn;

--
-- Name: incident_report_iunit_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.incident_report_iunit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.incident_report_iunit_id_seq OWNER TO pgisn;

--
-- Name: incident_report_iunit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.incident_report_iunit_id_seq OWNED BY public.incident_report_iunit.id;


--
-- Name: incident_report_iupdate; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.incident_report_iupdate (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    update text NOT NULL,
    visible boolean NOT NULL,
    narrative boolean NOT NULL,
    creator_id integer NOT NULL,
    incident_id integer NOT NULL
);


ALTER TABLE public.incident_report_iupdate OWNER TO pgisn;

--
-- Name: incident_report_iupdate_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.incident_report_iupdate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.incident_report_iupdate_id_seq OWNER TO pgisn;

--
-- Name: incident_report_iupdate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.incident_report_iupdate_id_seq OWNED BY public.incident_report_iupdate.id;


--
-- Name: incident_report_media; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.incident_report_media (
    id integer NOT NULL,
    description text NOT NULL,
    file character varying(250),
    incident_id integer,
    type_id integer,
    original_name character varying(255) NOT NULL
);


ALTER TABLE public.incident_report_media OWNER TO pgisn;

--
-- Name: incident_report_media_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.incident_report_media_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.incident_report_media_id_seq OWNER TO pgisn;

--
-- Name: incident_report_media_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.incident_report_media_id_seq OWNED BY public.incident_report_media.id;


--
-- Name: notification_message; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.notification_message (
    id integer NOT NULL,
    datetime timestamp with time zone NOT NULL,
    text text NOT NULL,
    room character varying(1) NOT NULL,
    msg_read boolean NOT NULL,
    user_from_id integer NOT NULL,
    user_to_id integer
);


ALTER TABLE public.notification_message OWNER TO pgisn;

--
-- Name: notification_message_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.notification_message_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notification_message_id_seq OWNER TO pgisn;

--
-- Name: notification_message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.notification_message_id_seq OWNED BY public.notification_message.id;


--
-- Name: report_engine_accesscodelog; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.report_engine_accesscodelog (
    id integer NOT NULL,
    app character varying(200) NOT NULL,
    log_date date NOT NULL,
    log_time time without time zone NOT NULL,
    gate character varying(100) NOT NULL,
    entry_log boolean NOT NULL,
    access_status character varying(1) NOT NULL,
    denied_reason text NOT NULL,
    notes text NOT NULL,
    access_code character varying(150) NOT NULL,
    device character varying(150) NOT NULL,
    user_id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(150) NOT NULL,
    tag character varying(100) NOT NULL,
    unit character varying(150) NOT NULL,
    created timestamp with time zone NOT NULL
);


ALTER TABLE public.report_engine_accesscodelog OWNER TO pgisn;

--
-- Name: report_engine_accesscodelog_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.report_engine_accesscodelog_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.report_engine_accesscodelog_id_seq OWNER TO pgisn;

--
-- Name: report_engine_accesscodelog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.report_engine_accesscodelog_id_seq OWNED BY public.report_engine_accesscodelog.id;


--
-- Name: report_engine_accesscodelog_y2018m10; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.report_engine_accesscodelog_y2018m10 (
    id integer DEFAULT nextval('public.report_engine_accesscodelog_id_seq'::regclass),
    app character varying(200),
    log_date date,
    log_time time without time zone,
    gate character varying(100),
    entry_log boolean,
    access_status character varying(1),
    denied_reason text,
    notes text,
    access_code character varying(150),
    device character varying(150),
    user_id integer,
    CONSTRAINT report_engine_accesscodelog_y2018m10_log_date_check CHECK (((log_date >= '2018-10-01'::date) AND (log_date < '2018-11-01'::date)))
)
INHERITS (public.report_engine_accesscodelog);


ALTER TABLE public.report_engine_accesscodelog_y2018m10 OWNER TO pgisn;

--
-- Name: report_engine_accesscodelog_y2018m12; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.report_engine_accesscodelog_y2018m12 (
    id integer DEFAULT nextval('public.report_engine_accesscodelog_id_seq'::regclass),
    app character varying(200),
    log_date date,
    log_time time without time zone,
    gate character varying(100),
    entry_log boolean,
    access_status character varying(1),
    denied_reason text,
    notes text,
    access_code character varying(150),
    device character varying(150),
    user_id integer,
    first_name character varying(100),
    last_name character varying(150),
    tag character varying(100),
    CONSTRAINT report_engine_accesscodelog_y2018m12_log_date_check CHECK (((log_date >= '2018-12-01'::date) AND (log_date < '2019-01-01'::date)))
)
INHERITS (public.report_engine_accesscodelog);


ALTER TABLE public.report_engine_accesscodelog_y2018m12 OWNER TO pgisn;

--
-- Name: report_engine_accesscodelog_y2019m01; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.report_engine_accesscodelog_y2019m01 (
    id integer DEFAULT nextval('public.report_engine_accesscodelog_id_seq'::regclass),
    app character varying(200),
    log_date date,
    log_time time without time zone,
    gate character varying(100),
    entry_log boolean,
    access_status character varying(1),
    denied_reason text,
    notes text,
    access_code character varying(150),
    device character varying(150),
    user_id integer,
    first_name character varying(100),
    last_name character varying(150),
    tag character varying(100),
    CONSTRAINT report_engine_accesscodelog_y2019m01_log_date_check CHECK (((log_date >= '2019-01-01'::date) AND (log_date < '2019-02-01'::date)))
)
INHERITS (public.report_engine_accesscodelog);


ALTER TABLE public.report_engine_accesscodelog_y2019m01 OWNER TO pgisn;

--
-- Name: report_engine_accesscodelog_y2019m02; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.report_engine_accesscodelog_y2019m02 (
    id integer DEFAULT nextval('public.report_engine_accesscodelog_id_seq'::regclass),
    app character varying(200),
    log_date date,
    log_time time without time zone,
    gate character varying(100),
    entry_log boolean,
    access_status character varying(1),
    denied_reason text,
    notes text,
    access_code character varying(150),
    device character varying(150),
    user_id integer,
    first_name character varying(100),
    last_name character varying(150),
    tag character varying(100),
    CONSTRAINT report_engine_accesscodelog_y2019m02_log_date_check CHECK (((log_date >= '2019-02-01'::date) AND (log_date < '2019-03-01'::date)))
)
INHERITS (public.report_engine_accesscodelog);


ALTER TABLE public.report_engine_accesscodelog_y2019m02 OWNER TO pgisn;

--
-- Name: report_engine_accesscodelog_y2019m03; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.report_engine_accesscodelog_y2019m03 (
    id integer DEFAULT nextval('public.report_engine_accesscodelog_id_seq'::regclass),
    app character varying(200),
    log_date date,
    log_time time without time zone,
    gate character varying(100),
    entry_log boolean,
    access_status character varying(1),
    denied_reason text,
    notes text,
    access_code character varying(150),
    device character varying(150),
    user_id integer,
    first_name character varying(100),
    last_name character varying(150),
    tag character varying(100),
    CONSTRAINT report_engine_accesscodelog_y2019m03_log_date_check CHECK (((log_date >= '2019-03-01'::date) AND (log_date < '2019-04-01'::date)))
)
INHERITS (public.report_engine_accesscodelog);


ALTER TABLE public.report_engine_accesscodelog_y2019m03 OWNER TO pgisn;

--
-- Name: report_engine_accesscodelog_y2019m04; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.report_engine_accesscodelog_y2019m04 (
    id integer DEFAULT nextval('public.report_engine_accesscodelog_id_seq'::regclass),
    app character varying(200),
    log_date date,
    log_time time without time zone,
    gate character varying(100),
    entry_log boolean,
    access_status character varying(1),
    denied_reason text,
    notes text,
    access_code character varying(150),
    device character varying(150),
    user_id integer,
    first_name character varying(100),
    last_name character varying(150),
    tag character varying(100),
    CONSTRAINT report_engine_accesscodelog_y2019m04_log_date_check CHECK (((log_date >= '2019-04-01'::date) AND (log_date < '2019-05-01'::date)))
)
INHERITS (public.report_engine_accesscodelog);


ALTER TABLE public.report_engine_accesscodelog_y2019m04 OWNER TO pgisn;

--
-- Name: report_engine_accesscodelog_y2019m05; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.report_engine_accesscodelog_y2019m05 (
    id integer DEFAULT nextval('public.report_engine_accesscodelog_id_seq'::regclass),
    app character varying(200),
    log_date date,
    log_time time without time zone,
    gate character varying(100),
    entry_log boolean,
    access_status character varying(1),
    denied_reason text,
    notes text,
    access_code character varying(150),
    device character varying(150),
    user_id integer,
    first_name character varying(100),
    last_name character varying(150),
    tag character varying(100),
    CONSTRAINT report_engine_accesscodelog_y2019m05_log_date_check CHECK (((log_date >= '2019-05-01'::date) AND (log_date < '2019-06-01'::date)))
)
INHERITS (public.report_engine_accesscodelog);


ALTER TABLE public.report_engine_accesscodelog_y2019m05 OWNER TO pgisn;

--
-- Name: report_engine_accesscodelog_y2019m06; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.report_engine_accesscodelog_y2019m06 (
    id integer DEFAULT nextval('public.report_engine_accesscodelog_id_seq'::regclass),
    app character varying(200),
    log_date date,
    log_time time without time zone,
    gate character varying(100),
    entry_log boolean,
    access_status character varying(1),
    denied_reason text,
    notes text,
    access_code character varying(150),
    device character varying(150),
    user_id integer,
    first_name character varying(100),
    last_name character varying(150),
    tag character varying(100),
    CONSTRAINT report_engine_accesscodelog_y2019m06_log_date_check CHECK (((log_date >= '2019-06-01'::date) AND (log_date < '2019-07-01'::date)))
)
INHERITS (public.report_engine_accesscodelog);


ALTER TABLE public.report_engine_accesscodelog_y2019m06 OWNER TO pgisn;

--
-- Name: report_engine_accesscodelog_y2019m07; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.report_engine_accesscodelog_y2019m07 (
    id integer DEFAULT nextval('public.report_engine_accesscodelog_id_seq'::regclass),
    app character varying(200),
    log_date date,
    log_time time without time zone,
    gate character varying(100),
    entry_log boolean,
    access_status character varying(1),
    denied_reason text,
    notes text,
    access_code character varying(150),
    device character varying(150),
    user_id integer,
    first_name character varying(100),
    last_name character varying(150),
    tag character varying(100),
    CONSTRAINT report_engine_accesscodelog_y2019m07_log_date_check CHECK (((log_date >= '2019-07-01'::date) AND (log_date < '2019-08-01'::date)))
)
INHERITS (public.report_engine_accesscodelog);


ALTER TABLE public.report_engine_accesscodelog_y2019m07 OWNER TO pgisn;

--
-- Name: report_engine_accesscodelog_y2019m08; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.report_engine_accesscodelog_y2019m08 (
    id integer DEFAULT nextval('public.report_engine_accesscodelog_id_seq'::regclass),
    app character varying(200),
    log_date date,
    log_time time without time zone,
    gate character varying(100),
    entry_log boolean,
    access_status character varying(1),
    denied_reason text,
    notes text,
    access_code character varying(150),
    device character varying(150),
    user_id integer,
    first_name character varying(100),
    last_name character varying(150),
    tag character varying(100),
    unit character varying(150),
    CONSTRAINT report_engine_accesscodelog_y2019m08_log_date_check CHECK (((log_date >= '2019-08-01'::date) AND (log_date < '2019-09-01'::date)))
)
INHERITS (public.report_engine_accesscodelog);


ALTER TABLE public.report_engine_accesscodelog_y2019m08 OWNER TO pgisn;

--
-- Name: report_engine_accesscodelog_y2019m09; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.report_engine_accesscodelog_y2019m09 (
    id integer DEFAULT nextval('public.report_engine_accesscodelog_id_seq'::regclass),
    app character varying(200),
    log_date date,
    log_time time without time zone,
    gate character varying(100),
    entry_log boolean,
    access_status character varying(1),
    denied_reason text,
    notes text,
    access_code character varying(150),
    device character varying(150),
    user_id integer,
    first_name character varying(100),
    last_name character varying(150),
    tag character varying(100),
    unit character varying(150),
    CONSTRAINT report_engine_accesscodelog_y2019m09_log_date_check CHECK (((log_date >= '2019-09-01'::date) AND (log_date < '2019-10-01'::date)))
)
INHERITS (public.report_engine_accesscodelog);


ALTER TABLE public.report_engine_accesscodelog_y2019m09 OWNER TO pgisn;

--
-- Name: report_engine_accesscodelog_y2019m10; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.report_engine_accesscodelog_y2019m10 (
    id integer DEFAULT nextval('public.report_engine_accesscodelog_id_seq'::regclass),
    app character varying(200),
    log_date date,
    log_time time without time zone,
    gate character varying(100),
    entry_log boolean,
    access_status character varying(1),
    denied_reason text,
    notes text,
    access_code character varying(150),
    device character varying(150),
    user_id integer,
    first_name character varying(100),
    last_name character varying(150),
    tag character varying(100),
    unit character varying(150),
    CONSTRAINT report_engine_accesscodelog_y2019m10_log_date_check CHECK (((log_date >= '2019-10-01'::date) AND (log_date < '2019-11-01'::date)))
)
INHERITS (public.report_engine_accesscodelog);


ALTER TABLE public.report_engine_accesscodelog_y2019m10 OWNER TO pgisn;

--
-- Name: report_engine_accesscodelog_y2019m11; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.report_engine_accesscodelog_y2019m11 (
    id integer DEFAULT nextval('public.report_engine_accesscodelog_id_seq'::regclass),
    app character varying(200),
    log_date date,
    log_time time without time zone,
    gate character varying(100),
    entry_log boolean,
    access_status character varying(1),
    denied_reason text,
    notes text,
    access_code character varying(150),
    device character varying(150),
    user_id integer,
    first_name character varying(100),
    last_name character varying(150),
    tag character varying(100),
    unit character varying(150),
    CONSTRAINT report_engine_accesscodelog_y2019m11_log_date_check CHECK (((log_date >= '2019-11-01'::date) AND (log_date < '2019-12-01'::date)))
)
INHERITS (public.report_engine_accesscodelog);


ALTER TABLE public.report_engine_accesscodelog_y2019m11 OWNER TO pgisn;

--
-- Name: report_engine_accesscodelog_y2019m12; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.report_engine_accesscodelog_y2019m12 (
    id integer DEFAULT nextval('public.report_engine_accesscodelog_id_seq'::regclass),
    app character varying(200),
    log_date date,
    log_time time without time zone,
    gate character varying(100),
    entry_log boolean,
    access_status character varying(1),
    denied_reason text,
    notes text,
    access_code character varying(150),
    device character varying(150),
    user_id integer,
    first_name character varying(100),
    last_name character varying(150),
    tag character varying(100),
    unit character varying(150),
    CONSTRAINT report_engine_accesscodelog_y2019m12_log_date_check CHECK (((log_date >= '2019-12-01'::date) AND (log_date < '2020-01-01'::date)))
)
INHERITS (public.report_engine_accesscodelog);


ALTER TABLE public.report_engine_accesscodelog_y2019m12 OWNER TO pgisn;

--
-- Name: report_engine_accesscodelog_y2020m01; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.report_engine_accesscodelog_y2020m01 (
    id integer DEFAULT nextval('public.report_engine_accesscodelog_id_seq'::regclass),
    app character varying(200),
    log_date date,
    log_time time without time zone,
    gate character varying(100),
    entry_log boolean,
    access_status character varying(1),
    denied_reason text,
    notes text,
    access_code character varying(150),
    device character varying(150),
    user_id integer,
    first_name character varying(100),
    last_name character varying(150),
    tag character varying(100),
    unit character varying(150),
    CONSTRAINT report_engine_accesscodelog_y2020m01_log_date_check CHECK (((log_date >= '2020-01-01'::date) AND (log_date < '2020-02-01'::date)))
)
INHERITS (public.report_engine_accesscodelog);


ALTER TABLE public.report_engine_accesscodelog_y2020m01 OWNER TO pgisn;

--
-- Name: report_engine_accesscodelog_y2020m02; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.report_engine_accesscodelog_y2020m02 (
    id integer DEFAULT nextval('public.report_engine_accesscodelog_id_seq'::regclass),
    app character varying(200),
    log_date date,
    log_time time without time zone,
    gate character varying(100),
    entry_log boolean,
    access_status character varying(1),
    denied_reason text,
    notes text,
    access_code character varying(150),
    device character varying(150),
    user_id integer,
    first_name character varying(100),
    last_name character varying(150),
    tag character varying(100),
    unit character varying(150),
    created timestamp with time zone,
    CONSTRAINT report_engine_accesscodelog_y2020m02_log_date_check CHECK (((log_date >= '2020-02-01'::date) AND (log_date < '2020-03-01'::date)))
)
INHERITS (public.report_engine_accesscodelog);


ALTER TABLE public.report_engine_accesscodelog_y2020m02 OWNER TO pgisn;

--
-- Name: report_engine_visitor; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.report_engine_visitor (
    id integer NOT NULL,
    index character varying(50),
    first_name character varying(100) NOT NULL,
    last_name character varying(150) NOT NULL,
    phone character varying(200) NOT NULL,
    license_number character varying(50) NOT NULL,
    type character varying(200) NOT NULL,
    company character varying(200) NOT NULL,
    special text NOT NULL,
    temporary boolean NOT NULL,
    created timestamp with time zone NOT NULL
);


ALTER TABLE public.report_engine_visitor OWNER TO pgisn;

--
-- Name: report_engine_visitor_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.report_engine_visitor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.report_engine_visitor_id_seq OWNER TO pgisn;

--
-- Name: report_engine_visitor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.report_engine_visitor_id_seq OWNED BY public.report_engine_visitor.id;


--
-- Name: report_engine_visitorlog; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.report_engine_visitorlog (
    id integer NOT NULL,
    app character varying(200) NOT NULL,
    log_date date NOT NULL,
    log_time time without time zone NOT NULL,
    gate character varying(100) NOT NULL,
    entry_log boolean NOT NULL,
    access_status character varying(1) NOT NULL,
    denied_reason text NOT NULL,
    notes text NOT NULL,
    unit character varying(100) NOT NULL,
    tag character varying(100) NOT NULL,
    user_id integer NOT NULL,
    visitor_id integer NOT NULL,
    device character varying(150) NOT NULL,
    created timestamp with time zone NOT NULL
);


ALTER TABLE public.report_engine_visitorlog OWNER TO pgisn;

--
-- Name: report_engine_visitorlog_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.report_engine_visitorlog_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.report_engine_visitorlog_id_seq OWNER TO pgisn;

--
-- Name: report_engine_visitorlog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.report_engine_visitorlog_id_seq OWNED BY public.report_engine_visitorlog.id;


--
-- Name: report_engine_visitorlog_y2018m12; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.report_engine_visitorlog_y2018m12 (
    id integer DEFAULT nextval('public.report_engine_visitorlog_id_seq'::regclass),
    app character varying(200),
    log_date date,
    log_time time without time zone,
    gate character varying(100),
    entry_log boolean,
    access_status character varying(1),
    denied_reason text,
    notes text,
    unit character varying(100),
    tag character varying(100),
    user_id integer,
    visitor_id integer,
    device character varying(150),
    CONSTRAINT report_engine_visitorlog_y2018m12_log_date_check CHECK (((log_date >= '2018-12-01'::date) AND (log_date < '2019-01-01'::date)))
)
INHERITS (public.report_engine_visitorlog);


ALTER TABLE public.report_engine_visitorlog_y2018m12 OWNER TO pgisn;

--
-- Name: report_engine_visitorlog_y2019m01; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.report_engine_visitorlog_y2019m01 (
    id integer DEFAULT nextval('public.report_engine_visitorlog_id_seq'::regclass),
    app character varying(200),
    log_date date,
    log_time time without time zone,
    gate character varying(100),
    entry_log boolean,
    access_status character varying(1),
    denied_reason text,
    notes text,
    unit character varying(100),
    tag character varying(100),
    user_id integer,
    visitor_id integer,
    device character varying(150),
    CONSTRAINT report_engine_visitorlog_y2019m01_log_date_check CHECK (((log_date >= '2019-01-01'::date) AND (log_date < '2019-02-01'::date)))
)
INHERITS (public.report_engine_visitorlog);


ALTER TABLE public.report_engine_visitorlog_y2019m01 OWNER TO pgisn;

--
-- Name: report_engine_visitorlog_y2019m02; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.report_engine_visitorlog_y2019m02 (
    id integer DEFAULT nextval('public.report_engine_visitorlog_id_seq'::regclass),
    app character varying(200),
    log_date date,
    log_time time without time zone,
    gate character varying(100),
    entry_log boolean,
    access_status character varying(1),
    denied_reason text,
    notes text,
    unit character varying(100),
    tag character varying(100),
    user_id integer,
    visitor_id integer,
    device character varying(150),
    CONSTRAINT report_engine_visitorlog_y2019m02_log_date_check CHECK (((log_date >= '2019-02-01'::date) AND (log_date < '2019-03-01'::date)))
)
INHERITS (public.report_engine_visitorlog);


ALTER TABLE public.report_engine_visitorlog_y2019m02 OWNER TO pgisn;

--
-- Name: report_engine_visitorlog_y2019m03; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.report_engine_visitorlog_y2019m03 (
    id integer DEFAULT nextval('public.report_engine_visitorlog_id_seq'::regclass),
    app character varying(200),
    log_date date,
    log_time time without time zone,
    gate character varying(100),
    entry_log boolean,
    access_status character varying(1),
    denied_reason text,
    notes text,
    unit character varying(100),
    tag character varying(100),
    user_id integer,
    visitor_id integer,
    device character varying(150),
    CONSTRAINT report_engine_visitorlog_y2019m03_log_date_check CHECK (((log_date >= '2019-03-01'::date) AND (log_date < '2019-04-01'::date)))
)
INHERITS (public.report_engine_visitorlog);


ALTER TABLE public.report_engine_visitorlog_y2019m03 OWNER TO pgisn;

--
-- Name: report_engine_visitorlog_y2019m04; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.report_engine_visitorlog_y2019m04 (
    id integer DEFAULT nextval('public.report_engine_visitorlog_id_seq'::regclass),
    app character varying(200),
    log_date date,
    log_time time without time zone,
    gate character varying(100),
    entry_log boolean,
    access_status character varying(1),
    denied_reason text,
    notes text,
    unit character varying(100),
    tag character varying(100),
    user_id integer,
    visitor_id integer,
    device character varying(150),
    CONSTRAINT report_engine_visitorlog_y2019m04_log_date_check CHECK (((log_date >= '2019-04-01'::date) AND (log_date < '2019-05-01'::date)))
)
INHERITS (public.report_engine_visitorlog);


ALTER TABLE public.report_engine_visitorlog_y2019m04 OWNER TO pgisn;

--
-- Name: report_engine_visitorlog_y2019m05; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.report_engine_visitorlog_y2019m05 (
    id integer DEFAULT nextval('public.report_engine_visitorlog_id_seq'::regclass),
    app character varying(200),
    log_date date,
    log_time time without time zone,
    gate character varying(100),
    entry_log boolean,
    access_status character varying(1),
    denied_reason text,
    notes text,
    unit character varying(100),
    tag character varying(100),
    user_id integer,
    visitor_id integer,
    device character varying(150),
    CONSTRAINT report_engine_visitorlog_y2019m05_log_date_check CHECK (((log_date >= '2019-05-01'::date) AND (log_date < '2019-06-01'::date)))
)
INHERITS (public.report_engine_visitorlog);


ALTER TABLE public.report_engine_visitorlog_y2019m05 OWNER TO pgisn;

--
-- Name: report_engine_visitorlog_y2019m06; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.report_engine_visitorlog_y2019m06 (
    id integer DEFAULT nextval('public.report_engine_visitorlog_id_seq'::regclass),
    app character varying(200),
    log_date date,
    log_time time without time zone,
    gate character varying(100),
    entry_log boolean,
    access_status character varying(1),
    denied_reason text,
    notes text,
    unit character varying(100),
    tag character varying(100),
    user_id integer,
    visitor_id integer,
    device character varying(150),
    CONSTRAINT report_engine_visitorlog_y2019m06_log_date_check CHECK (((log_date >= '2019-06-01'::date) AND (log_date < '2019-07-01'::date)))
)
INHERITS (public.report_engine_visitorlog);


ALTER TABLE public.report_engine_visitorlog_y2019m06 OWNER TO pgisn;

--
-- Name: report_engine_visitorlog_y2019m07; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.report_engine_visitorlog_y2019m07 (
    id integer DEFAULT nextval('public.report_engine_visitorlog_id_seq'::regclass),
    app character varying(200),
    log_date date,
    log_time time without time zone,
    gate character varying(100),
    entry_log boolean,
    access_status character varying(1),
    denied_reason text,
    notes text,
    unit character varying(100),
    tag character varying(100),
    user_id integer,
    visitor_id integer,
    device character varying(150),
    CONSTRAINT report_engine_visitorlog_y2019m07_log_date_check CHECK (((log_date >= '2019-07-01'::date) AND (log_date < '2019-08-01'::date)))
)
INHERITS (public.report_engine_visitorlog);


ALTER TABLE public.report_engine_visitorlog_y2019m07 OWNER TO pgisn;

--
-- Name: report_engine_visitorlog_y2019m08; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.report_engine_visitorlog_y2019m08 (
    id integer DEFAULT nextval('public.report_engine_visitorlog_id_seq'::regclass),
    app character varying(200),
    log_date date,
    log_time time without time zone,
    gate character varying(100),
    entry_log boolean,
    access_status character varying(1),
    denied_reason text,
    notes text,
    unit character varying(100),
    tag character varying(100),
    user_id integer,
    visitor_id integer,
    device character varying(150),
    CONSTRAINT report_engine_visitorlog_y2019m08_log_date_check CHECK (((log_date >= '2019-08-01'::date) AND (log_date < '2019-09-01'::date)))
)
INHERITS (public.report_engine_visitorlog);


ALTER TABLE public.report_engine_visitorlog_y2019m08 OWNER TO pgisn;

--
-- Name: report_engine_visitorlog_y2019m09; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.report_engine_visitorlog_y2019m09 (
    id integer DEFAULT nextval('public.report_engine_visitorlog_id_seq'::regclass),
    app character varying(200),
    log_date date,
    log_time time without time zone,
    gate character varying(100),
    entry_log boolean,
    access_status character varying(1),
    denied_reason text,
    notes text,
    unit character varying(100),
    tag character varying(100),
    user_id integer,
    visitor_id integer,
    device character varying(150),
    CONSTRAINT report_engine_visitorlog_y2019m09_log_date_check CHECK (((log_date >= '2019-09-01'::date) AND (log_date < '2019-10-01'::date)))
)
INHERITS (public.report_engine_visitorlog);


ALTER TABLE public.report_engine_visitorlog_y2019m09 OWNER TO pgisn;

--
-- Name: report_engine_visitorlog_y2019m10; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.report_engine_visitorlog_y2019m10 (
    id integer DEFAULT nextval('public.report_engine_visitorlog_id_seq'::regclass),
    app character varying(200),
    log_date date,
    log_time time without time zone,
    gate character varying(100),
    entry_log boolean,
    access_status character varying(1),
    denied_reason text,
    notes text,
    unit character varying(100),
    tag character varying(100),
    user_id integer,
    visitor_id integer,
    device character varying(150),
    CONSTRAINT report_engine_visitorlog_y2019m10_log_date_check CHECK (((log_date >= '2019-10-01'::date) AND (log_date < '2019-11-01'::date)))
)
INHERITS (public.report_engine_visitorlog);


ALTER TABLE public.report_engine_visitorlog_y2019m10 OWNER TO pgisn;

--
-- Name: report_engine_visitorlog_y2019m11; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.report_engine_visitorlog_y2019m11 (
    id integer DEFAULT nextval('public.report_engine_visitorlog_id_seq'::regclass),
    app character varying(200),
    log_date date,
    log_time time without time zone,
    gate character varying(100),
    entry_log boolean,
    access_status character varying(1),
    denied_reason text,
    notes text,
    unit character varying(100),
    tag character varying(100),
    user_id integer,
    visitor_id integer,
    device character varying(150),
    CONSTRAINT report_engine_visitorlog_y2019m11_log_date_check CHECK (((log_date >= '2019-11-01'::date) AND (log_date < '2019-12-01'::date)))
)
INHERITS (public.report_engine_visitorlog);


ALTER TABLE public.report_engine_visitorlog_y2019m11 OWNER TO pgisn;

--
-- Name: report_engine_visitorlog_y2019m12; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.report_engine_visitorlog_y2019m12 (
    id integer DEFAULT nextval('public.report_engine_visitorlog_id_seq'::regclass),
    app character varying(200),
    log_date date,
    log_time time without time zone,
    gate character varying(100),
    entry_log boolean,
    access_status character varying(1),
    denied_reason text,
    notes text,
    unit character varying(100),
    tag character varying(100),
    user_id integer,
    visitor_id integer,
    device character varying(150),
    CONSTRAINT report_engine_visitorlog_y2019m12_log_date_check CHECK (((log_date >= '2019-12-01'::date) AND (log_date < '2020-01-01'::date)))
)
INHERITS (public.report_engine_visitorlog);


ALTER TABLE public.report_engine_visitorlog_y2019m12 OWNER TO pgisn;

--
-- Name: report_engine_visitorlog_y2020m01; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.report_engine_visitorlog_y2020m01 (
    id integer DEFAULT nextval('public.report_engine_visitorlog_id_seq'::regclass),
    app character varying(200),
    log_date date,
    log_time time without time zone,
    gate character varying(100),
    entry_log boolean,
    access_status character varying(1),
    denied_reason text,
    notes text,
    unit character varying(100),
    tag character varying(100),
    user_id integer,
    visitor_id integer,
    device character varying(150),
    CONSTRAINT report_engine_visitorlog_y2020m01_log_date_check CHECK (((log_date >= '2020-01-01'::date) AND (log_date < '2020-02-01'::date)))
)
INHERITS (public.report_engine_visitorlog);


ALTER TABLE public.report_engine_visitorlog_y2020m01 OWNER TO pgisn;

--
-- Name: report_engine_visitorlog_y2020m02; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.report_engine_visitorlog_y2020m02 (
    id integer DEFAULT nextval('public.report_engine_visitorlog_id_seq'::regclass),
    app character varying(200),
    log_date date,
    log_time time without time zone,
    gate character varying(100),
    entry_log boolean,
    access_status character varying(1),
    denied_reason text,
    notes text,
    unit character varying(100),
    tag character varying(100),
    user_id integer,
    visitor_id integer,
    device character varying(150),
    created timestamp with time zone,
    CONSTRAINT report_engine_visitorlog_y2020m02_log_date_check CHECK (((log_date >= '2020-02-01'::date) AND (log_date < '2020-03-01'::date)))
)
INHERITS (public.report_engine_visitorlog);


ALTER TABLE public.report_engine_visitorlog_y2020m02 OWNER TO pgisn;

--
-- Name: residents_website_invitation; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.residents_website_invitation (
    id integer NOT NULL,
    sms_send timestamp with time zone,
    phone character varying(50) NOT NULL,
    email_send timestamp with time zone,
    email character varying(254) NOT NULL,
    event_id integer,
    receiver_id integer NOT NULL,
    sender_id integer NOT NULL,
    checked boolean NOT NULL,
    code character varying(32) NOT NULL,
    email_count integer NOT NULL,
    sms_count integer NOT NULL,
    qr_code_path character varying(250) NOT NULL,
    CONSTRAINT residents_website_invitation_email_count_check CHECK ((email_count >= 0)),
    CONSTRAINT residents_website_invitation_sms_count_check CHECK ((sms_count >= 0))
);


ALTER TABLE public.residents_website_invitation OWNER TO pgisn;

--
-- Name: residents_website_invitation_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.residents_website_invitation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.residents_website_invitation_id_seq OWNER TO pgisn;

--
-- Name: residents_website_invitation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.residents_website_invitation_id_seq OWNED BY public.residents_website_invitation.id;


--
-- Name: residents_website_invitationtexttemplate; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.residents_website_invitationtexttemplate (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    is_default boolean NOT NULL,
    text text NOT NULL,
    html_formatted boolean NOT NULL,
    subject character varying(150) NOT NULL,
    sms_text text NOT NULL
);


ALTER TABLE public.residents_website_invitationtexttemplate OWNER TO pgisn;

--
-- Name: residents_website_invitationtexttemplate_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.residents_website_invitationtexttemplate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.residents_website_invitationtexttemplate_id_seq OWNER TO pgisn;

--
-- Name: residents_website_invitationtexttemplate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.residents_website_invitationtexttemplate_id_seq OWNED BY public.residents_website_invitationtexttemplate.id;


--
-- Name: residents_website_notification; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.residents_website_notification (
    id integer NOT NULL,
    guest_arrival_email boolean NOT NULL,
    guest_arrival_sms boolean NOT NULL,
    ac_exp_email boolean NOT NULL,
    ac_exp_sms boolean NOT NULL,
    vehicle_exp_email boolean NOT NULL,
    vehicle_exp_sms boolean NOT NULL,
    resident_id integer,
    email_id integer,
    phone_id integer
);


ALTER TABLE public.residents_website_notification OWNER TO pgisn;

--
-- Name: residents_website_notification_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.residents_website_notification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.residents_website_notification_id_seq OWNER TO pgisn;

--
-- Name: residents_website_notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.residents_website_notification_id_seq OWNED BY public.residents_website_notification.id;


--
-- Name: residents_website_profile; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.residents_website_profile (
    user_ptr_id integer NOT NULL,
    "phoneNumber" character varying(50) NOT NULL,
    pin character varying(128),
    invitation_template_id integer,
    resident_id integer NOT NULL
);


ALTER TABLE public.residents_website_profile OWNER TO pgisn;

--
-- Name: rules_rule; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.rules_rule (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    active boolean NOT NULL,
    message text NOT NULL,
    "limit" integer NOT NULL,
    match_field character varying(255) NOT NULL,
    filterset public.hstore NOT NULL,
    ctype_id integer NOT NULL,
    code character varying(200) NOT NULL,
    CONSTRAINT rules_rule_limit_check CHECK (("limit" >= 0))
);


ALTER TABLE public.rules_rule OWNER TO pgisn;

--
-- Name: rules_rule_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.rules_rule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rules_rule_id_seq OWNER TO pgisn;

--
-- Name: rules_rule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.rules_rule_id_seq OWNED BY public.rules_rule.id;


--
-- Name: task_attachment; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.task_attachment (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    name character varying(200) NOT NULL,
    description text,
    file character varying(250) NOT NULL,
    task_id integer NOT NULL
);


ALTER TABLE public.task_attachment OWNER TO pgisn;

--
-- Name: task_attachment_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.task_attachment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.task_attachment_id_seq OWNER TO pgisn;

--
-- Name: task_attachment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.task_attachment_id_seq OWNED BY public.task_attachment.id;


--
-- Name: task_checklist; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.task_checklist (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    name character varying(200) NOT NULL,
    description text,
    finished boolean NOT NULL,
    task_id integer NOT NULL
);


ALTER TABLE public.task_checklist OWNER TO pgisn;

--
-- Name: task_checklist_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.task_checklist_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.task_checklist_id_seq OWNER TO pgisn;

--
-- Name: task_checklist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.task_checklist_id_seq OWNED BY public.task_checklist.id;


--
-- Name: task_comment; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.task_comment (
    id integer NOT NULL,
    comment text NOT NULL,
    visible boolean NOT NULL,
    lft integer NOT NULL,
    rght integer NOT NULL,
    tree_id integer NOT NULL,
    level integer NOT NULL,
    creator_id integer NOT NULL,
    parent_id integer,
    task_id integer NOT NULL,
    CONSTRAINT task_comment_level_check CHECK ((level >= 0)),
    CONSTRAINT task_comment_lft_check CHECK ((lft >= 0)),
    CONSTRAINT task_comment_rght_check CHECK ((rght >= 0)),
    CONSTRAINT task_comment_tree_id_check CHECK ((tree_id >= 0))
);


ALTER TABLE public.task_comment OWNER TO pgisn;

--
-- Name: task_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.task_comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.task_comment_id_seq OWNER TO pgisn;

--
-- Name: task_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.task_comment_id_seq OWNED BY public.task_comment.id;


--
-- Name: task_label; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.task_label (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    name character varying(200) NOT NULL,
    description text
);


ALTER TABLE public.task_label OWNER TO pgisn;

--
-- Name: task_label_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.task_label_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.task_label_id_seq OWNER TO pgisn;

--
-- Name: task_label_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.task_label_id_seq OWNED BY public.task_label.id;


--
-- Name: task_status; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.task_status (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    name character varying(200) NOT NULL,
    description text,
    color character varying(18) NOT NULL
);


ALTER TABLE public.task_status OWNER TO pgisn;

--
-- Name: task_status_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.task_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.task_status_id_seq OWNER TO pgisn;

--
-- Name: task_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.task_status_id_seq OWNED BY public.task_status.id;


--
-- Name: task_task; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.task_task (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    name character varying(200) NOT NULL,
    description text,
    "order" smallint NOT NULL,
    priority smallint NOT NULL,
    finished boolean NOT NULL,
    category_id integer,
    creator_id integer NOT NULL,
    group_id integer,
    status_id integer,
    CONSTRAINT task_task_order_check CHECK (("order" >= 0)),
    CONSTRAINT task_task_priority_check CHECK ((priority >= 0))
);


ALTER TABLE public.task_task OWNER TO pgisn;

--
-- Name: task_task_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.task_task_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.task_task_id_seq OWNER TO pgisn;

--
-- Name: task_task_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.task_task_id_seq OWNED BY public.task_task.id;


--
-- Name: task_task_labels; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.task_task_labels (
    id integer NOT NULL,
    task_id integer NOT NULL,
    label_id integer NOT NULL
);


ALTER TABLE public.task_task_labels OWNER TO pgisn;

--
-- Name: task_task_labels_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.task_task_labels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.task_task_labels_id_seq OWNER TO pgisn;

--
-- Name: task_task_labels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.task_task_labels_id_seq OWNED BY public.task_task_labels.id;


--
-- Name: task_task_members; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.task_task_members (
    id integer NOT NULL,
    task_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.task_task_members OWNER TO pgisn;

--
-- Name: task_task_members_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.task_task_members_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.task_task_members_id_seq OWNER TO pgisn;

--
-- Name: task_task_members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.task_task_members_id_seq OWNED BY public.task_task_members.id;


--
-- Name: task_taskcategory; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.task_taskcategory (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    name character varying(200) NOT NULL,
    description text,
    lft integer NOT NULL,
    rght integer NOT NULL,
    tree_id integer NOT NULL,
    level integer NOT NULL,
    parent_id integer,
    CONSTRAINT task_taskcategory_level_check CHECK ((level >= 0)),
    CONSTRAINT task_taskcategory_lft_check CHECK ((lft >= 0)),
    CONSTRAINT task_taskcategory_rght_check CHECK ((rght >= 0)),
    CONSTRAINT task_taskcategory_tree_id_check CHECK ((tree_id >= 0))
);


ALTER TABLE public.task_taskcategory OWNER TO pgisn;

--
-- Name: task_taskcategory_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.task_taskcategory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.task_taskcategory_id_seq OWNER TO pgisn;

--
-- Name: task_taskcategory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.task_taskcategory_id_seq OWNED BY public.task_taskcategory.id;


--
-- Name: task_taskgroup; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.task_taskgroup (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    name character varying(200) NOT NULL,
    description text
);


ALTER TABLE public.task_taskgroup OWNER TO pgisn;

--
-- Name: task_taskgroup_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.task_taskgroup_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.task_taskgroup_id_seq OWNER TO pgisn;

--
-- Name: task_taskgroup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.task_taskgroup_id_seq OWNED BY public.task_taskgroup.id;


--
-- Name: task_taskschedule; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.task_taskschedule (
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    start_time time without time zone NOT NULL,
    start_date date NOT NULL,
    end_time time without time zone NOT NULL,
    end_date date NOT NULL,
    finish date,
    frequency character varying(1),
    weekdays character varying(1)[] NOT NULL,
    repeat_until date,
    task_id integer NOT NULL
);


ALTER TABLE public.task_taskschedule OWNER TO pgisn;

--
-- Name: task_vote; Type: TABLE; Schema: public; Owner: pgisn
--

CREATE TABLE public.task_vote (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    vote smallint NOT NULL,
    comment_id integer NOT NULL,
    owner_id integer NOT NULL,
    CONSTRAINT task_vote_vote_check CHECK ((vote >= 0))
);


ALTER TABLE public.task_vote OWNER TO pgisn;

--
-- Name: task_vote_id_seq; Type: SEQUENCE; Schema: public; Owner: pgisn
--

CREATE SEQUENCE public.task_vote_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.task_vote_id_seq OWNER TO pgisn;

--
-- Name: task_vote_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgisn
--

ALTER SEQUENCE public.task_vote_id_seq OWNED BY public.task_vote.id;


--
-- Name: access_control_accesscode id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.access_control_accesscode ALTER COLUMN id SET DEFAULT nextval('public.access_control_accesscode_id_seq'::regclass);


--
-- Name: access_control_accesscode_groups id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.access_control_accesscode_groups ALTER COLUMN id SET DEFAULT nextval('public.access_control_accesscode_groups_id_seq'::regclass);


--
-- Name: access_control_acgroup id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.access_control_acgroup ALTER COLUMN id SET DEFAULT nextval('public.access_control_acgroup_id_seq'::regclass);


--
-- Name: access_control_acpasstemplate id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.access_control_acpasstemplate ALTER COLUMN id SET DEFAULT nextval('public.access_control_acpasstemplate_id_seq'::regclass);


--
-- Name: access_control_acpermission_devices id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.access_control_acpermission_devices ALTER COLUMN id SET DEFAULT nextval('public.access_control_acpermission_devices_id_seq'::regclass);


--
-- Name: access_control_acpermission_groups id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.access_control_acpermission_groups ALTER COLUMN id SET DEFAULT nextval('public.access_control_acpermission_groups_id_seq'::regclass);


--
-- Name: access_control_acschedule id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.access_control_acschedule ALTER COLUMN id SET DEFAULT nextval('public.access_control_acschedule_id_seq'::regclass);


--
-- Name: access_control_facilitycode id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.access_control_facilitycode ALTER COLUMN id SET DEFAULT nextval('public.access_control_facilitycode_id_seq'::regclass);


--
-- Name: access_control_sticker id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.access_control_sticker ALTER COLUMN id SET DEFAULT nextval('public.access_control_sticker_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: core_apirequestlog id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_apirequestlog ALTER COLUMN id SET DEFAULT nextval('public.core_apirequestlog_id_seq'::regclass);


--
-- Name: core_crudlog id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_crudlog ALTER COLUMN id SET DEFAULT nextval('public.core_crudlog_id_seq'::regclass);


--
-- Name: core_emailsuitesetting id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_emailsuitesetting ALTER COLUMN id SET DEFAULT nextval('public.core_emailsuitesetting_id_seq'::regclass);


--
-- Name: core_loggedusers id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_loggedusers ALTER COLUMN id SET DEFAULT nextval('public.core_loggedusers_id_seq'::regclass);


--
-- Name: core_module id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_module ALTER COLUMN id SET DEFAULT nextval('public.core_module_id_seq'::regclass);


--
-- Name: core_singlesignon id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_singlesignon ALTER COLUMN id SET DEFAULT nextval('public.core_singlesignon_id_seq'::regclass);


--
-- Name: core_ssotoken id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_ssotoken ALTER COLUMN id SET DEFAULT nextval('public.core_ssotoken_id_seq'::regclass);


--
-- Name: core_suitepreference id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_suitepreference ALTER COLUMN id SET DEFAULT nextval('public.core_suitepreference_id_seq'::regclass);


--
-- Name: core_userprofile id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_userprofile ALTER COLUMN id SET DEFAULT nextval('public.core_userprofile_id_seq'::regclass);


--
-- Name: data_migration_datafiles id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.data_migration_datafiles ALTER COLUMN id SET DEFAULT nextval('public.data_migration_datafiles_id_seq'::regclass);


--
-- Name: data_migration_profile id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.data_migration_profile ALTER COLUMN id SET DEFAULT nextval('public.data_migration_profile_id_seq'::regclass);


--
-- Name: data_migration_reference id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.data_migration_reference ALTER COLUMN id SET DEFAULT nextval('public.data_migration_reference_id_seq'::regclass);


--
-- Name: dbm_address id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_address ALTER COLUMN id SET DEFAULT nextval('public.dbm_address_id_seq'::regclass);


--
-- Name: dbm_bolo id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_bolo ALTER COLUMN id SET DEFAULT nextval('public.dbm_bolo_id_seq'::regclass);


--
-- Name: dbm_car id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_car ALTER COLUMN id SET DEFAULT nextval('public.dbm_car_id_seq'::regclass);


--
-- Name: dbm_carmodel id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_carmodel ALTER COLUMN id SET DEFAULT nextval('public.dbm_carmodel_id_seq'::regclass);


--
-- Name: dbm_category id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_category ALTER COLUMN id SET DEFAULT nextval('public.dbm_category_id_seq'::regclass);


--
-- Name: dbm_city id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_city ALTER COLUMN id SET DEFAULT nextval('public.dbm_city_id_seq'::regclass);


--
-- Name: dbm_color id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_color ALTER COLUMN id SET DEFAULT nextval('public.dbm_color_id_seq'::regclass);


--
-- Name: dbm_company id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_company ALTER COLUMN id SET DEFAULT nextval('public.dbm_company_id_seq'::regclass);


--
-- Name: dbm_contact id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_contact ALTER COLUMN id SET DEFAULT nextval('public.dbm_contact_id_seq'::regclass);


--
-- Name: dbm_contact_persons id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_contact_persons ALTER COLUMN id SET DEFAULT nextval('public.dbm_contact_persons_id_seq'::regclass);


--
-- Name: dbm_contract id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_contract ALTER COLUMN id SET DEFAULT nextval('public.dbm_contract_id_seq'::regclass);


--
-- Name: dbm_county id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_county ALTER COLUMN id SET DEFAULT nextval('public.dbm_county_id_seq'::regclass);


--
-- Name: dbm_decal id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_decal ALTER COLUMN id SET DEFAULT nextval('public.dbm_decal_id_seq'::regclass);


--
-- Name: dbm_direction id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_direction ALTER COLUMN id SET DEFAULT nextval('public.dbm_direction_id_seq'::regclass);


--
-- Name: dbm_drive id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_drive ALTER COLUMN id SET DEFAULT nextval('public.dbm_drive_id_seq'::regclass);


--
-- Name: dbm_drive_cars id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_drive_cars ALTER COLUMN id SET DEFAULT nextval('public.dbm_drive_cars_id_seq'::regclass);


--
-- Name: dbm_email id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_email ALTER COLUMN id SET DEFAULT nextval('public.dbm_email_id_seq'::regclass);


--
-- Name: dbm_entity id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_entity ALTER COLUMN id SET DEFAULT nextval('public.dbm_entity_id_seq'::regclass);


--
-- Name: dbm_event id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_event ALTER COLUMN id SET DEFAULT nextval('public.dbm_event_id_seq'::regclass);


--
-- Name: dbm_event_guest_list id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_event_guest_list ALTER COLUMN id SET DEFAULT nextval('public.dbm_event_guest_list_id_seq'::regclass);


--
-- Name: dbm_lease id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_lease ALTER COLUMN id SET DEFAULT nextval('public.dbm_lease_id_seq'::regclass);


--
-- Name: dbm_make id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_make ALTER COLUMN id SET DEFAULT nextval('public.dbm_make_id_seq'::regclass);


--
-- Name: dbm_owner id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_owner ALTER COLUMN id SET DEFAULT nextval('public.dbm_owner_id_seq'::regclass);


--
-- Name: dbm_owner_units id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_owner_units ALTER COLUMN id SET DEFAULT nextval('public.dbm_owner_units_id_seq'::regclass);


--
-- Name: dbm_person id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_person ALTER COLUMN id SET DEFAULT nextval('public.dbm_person_id_seq'::regclass);


--
-- Name: dbm_pet id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_pet ALTER COLUMN id SET DEFAULT nextval('public.dbm_pet_id_seq'::regclass);


--
-- Name: dbm_phone id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_phone ALTER COLUMN id SET DEFAULT nextval('public.dbm_phone_id_seq'::regclass);


--
-- Name: dbm_phonecarrier id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_phonecarrier ALTER COLUMN id SET DEFAULT nextval('public.dbm_phonecarrier_id_seq'::regclass);


--
-- Name: dbm_photo id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_photo ALTER COLUMN id SET DEFAULT nextval('public.dbm_photo_id_seq'::regclass);


--
-- Name: dbm_realstate id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_realstate ALTER COLUMN id SET DEFAULT nextval('public.dbm_realstate_id_seq'::regclass);


--
-- Name: dbm_state id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_state ALTER COLUMN id SET DEFAULT nextval('public.dbm_state_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_celery_beat_clockedschedule id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.django_celery_beat_clockedschedule ALTER COLUMN id SET DEFAULT nextval('public.django_celery_beat_clockedschedule_id_seq'::regclass);


--
-- Name: django_celery_beat_crontabschedule id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.django_celery_beat_crontabschedule ALTER COLUMN id SET DEFAULT nextval('public.django_celery_beat_crontabschedule_id_seq'::regclass);


--
-- Name: django_celery_beat_intervalschedule id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.django_celery_beat_intervalschedule ALTER COLUMN id SET DEFAULT nextval('public.django_celery_beat_intervalschedule_id_seq'::regclass);


--
-- Name: django_celery_beat_periodictask id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.django_celery_beat_periodictask ALTER COLUMN id SET DEFAULT nextval('public.django_celery_beat_periodictask_id_seq'::regclass);


--
-- Name: django_celery_beat_solarschedule id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.django_celery_beat_solarschedule ALTER COLUMN id SET DEFAULT nextval('public.django_celery_beat_solarschedule_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: django_twilio_caller id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.django_twilio_caller ALTER COLUMN id SET DEFAULT nextval('public.django_twilio_caller_id_seq'::regclass);


--
-- Name: django_twilio_credential id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.django_twilio_credential ALTER COLUMN id SET DEFAULT nextval('public.django_twilio_credential_id_seq'::regclass);


--
-- Name: incident_report_icar id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.incident_report_icar ALTER COLUMN id SET DEFAULT nextval('public.incident_report_icar_id_seq'::regclass);


--
-- Name: incident_report_icategory id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.incident_report_icategory ALTER COLUMN id SET DEFAULT nextval('public.incident_report_icategory_id_seq'::regclass);


--
-- Name: incident_report_incident id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.incident_report_incident ALTER COLUMN id SET DEFAULT nextval('public.incident_report_incident_id_seq'::regclass);


--
-- Name: incident_report_incidentstatus id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.incident_report_incidentstatus ALTER COLUMN id SET DEFAULT nextval('public.incident_report_incidentstatus_id_seq'::regclass);


--
-- Name: incident_report_iperson id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.incident_report_iperson ALTER COLUMN id SET DEFAULT nextval('public.incident_report_iperson_id_seq'::regclass);


--
-- Name: incident_report_iunit id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.incident_report_iunit ALTER COLUMN id SET DEFAULT nextval('public.incident_report_iunit_id_seq'::regclass);


--
-- Name: incident_report_iupdate id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.incident_report_iupdate ALTER COLUMN id SET DEFAULT nextval('public.incident_report_iupdate_id_seq'::regclass);


--
-- Name: incident_report_media id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.incident_report_media ALTER COLUMN id SET DEFAULT nextval('public.incident_report_media_id_seq'::regclass);


--
-- Name: notification_message id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.notification_message ALTER COLUMN id SET DEFAULT nextval('public.notification_message_id_seq'::regclass);


--
-- Name: report_engine_accesscodelog id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_accesscodelog ALTER COLUMN id SET DEFAULT nextval('public.report_engine_accesscodelog_id_seq'::regclass);


--
-- Name: report_engine_visitor id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_visitor ALTER COLUMN id SET DEFAULT nextval('public.report_engine_visitor_id_seq'::regclass);


--
-- Name: report_engine_visitorlog id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_visitorlog ALTER COLUMN id SET DEFAULT nextval('public.report_engine_visitorlog_id_seq'::regclass);


--
-- Name: residents_website_invitation id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.residents_website_invitation ALTER COLUMN id SET DEFAULT nextval('public.residents_website_invitation_id_seq'::regclass);


--
-- Name: residents_website_invitationtexttemplate id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.residents_website_invitationtexttemplate ALTER COLUMN id SET DEFAULT nextval('public.residents_website_invitationtexttemplate_id_seq'::regclass);


--
-- Name: residents_website_notification id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.residents_website_notification ALTER COLUMN id SET DEFAULT nextval('public.residents_website_notification_id_seq'::regclass);


--
-- Name: rules_rule id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.rules_rule ALTER COLUMN id SET DEFAULT nextval('public.rules_rule_id_seq'::regclass);


--
-- Name: task_attachment id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_attachment ALTER COLUMN id SET DEFAULT nextval('public.task_attachment_id_seq'::regclass);


--
-- Name: task_checklist id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_checklist ALTER COLUMN id SET DEFAULT nextval('public.task_checklist_id_seq'::regclass);


--
-- Name: task_comment id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_comment ALTER COLUMN id SET DEFAULT nextval('public.task_comment_id_seq'::regclass);


--
-- Name: task_label id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_label ALTER COLUMN id SET DEFAULT nextval('public.task_label_id_seq'::regclass);


--
-- Name: task_status id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_status ALTER COLUMN id SET DEFAULT nextval('public.task_status_id_seq'::regclass);


--
-- Name: task_task id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_task ALTER COLUMN id SET DEFAULT nextval('public.task_task_id_seq'::regclass);


--
-- Name: task_task_labels id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_task_labels ALTER COLUMN id SET DEFAULT nextval('public.task_task_labels_id_seq'::regclass);


--
-- Name: task_task_members id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_task_members ALTER COLUMN id SET DEFAULT nextval('public.task_task_members_id_seq'::regclass);


--
-- Name: task_taskcategory id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_taskcategory ALTER COLUMN id SET DEFAULT nextval('public.task_taskcategory_id_seq'::regclass);


--
-- Name: task_taskgroup id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_taskgroup ALTER COLUMN id SET DEFAULT nextval('public.task_taskgroup_id_seq'::regclass);


--
-- Name: task_vote id; Type: DEFAULT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_vote ALTER COLUMN id SET DEFAULT nextval('public.task_vote_id_seq'::regclass);


--
-- Name: access_control_accesscode_groups access_control_accesscode_groups_accesscode_id_acgroup_id_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.access_control_accesscode_groups
    ADD CONSTRAINT access_control_accesscode_groups_accesscode_id_acgroup_id_key UNIQUE (accesscode_id, acgroup_id);


--
-- Name: access_control_accesscode_groups access_control_accesscode_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.access_control_accesscode_groups
    ADD CONSTRAINT access_control_accesscode_groups_pkey PRIMARY KEY (id);


--
-- Name: access_control_accesscode access_control_accesscode_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.access_control_accesscode
    ADD CONSTRAINT access_control_accesscode_pkey PRIMARY KEY (id);


--
-- Name: access_control_acgroup access_control_acgroup_name_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.access_control_acgroup
    ADD CONSTRAINT access_control_acgroup_name_key UNIQUE (name);


--
-- Name: access_control_acgroup access_control_acgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.access_control_acgroup
    ADD CONSTRAINT access_control_acgroup_pkey PRIMARY KEY (id);


--
-- Name: access_control_acpasstemplate access_control_acpasstemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.access_control_acpasstemplate
    ADD CONSTRAINT access_control_acpasstemplate_pkey PRIMARY KEY (id);


--
-- Name: access_control_acpermission_devices access_control_acpermission_devic_acpermission_id_device_id_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.access_control_acpermission_devices
    ADD CONSTRAINT access_control_acpermission_devic_acpermission_id_device_id_key UNIQUE (acpermission_id, device_id);


--
-- Name: access_control_acpermission_devices access_control_acpermission_devices_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.access_control_acpermission_devices
    ADD CONSTRAINT access_control_acpermission_devices_pkey PRIMARY KEY (id);


--
-- Name: access_control_acpermission_groups access_control_acpermission_grou_acpermission_id_acgroup_id_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.access_control_acpermission_groups
    ADD CONSTRAINT access_control_acpermission_grou_acpermission_id_acgroup_id_key UNIQUE (acpermission_id, acgroup_id);


--
-- Name: access_control_acpermission_groups access_control_acpermission_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.access_control_acpermission_groups
    ADD CONSTRAINT access_control_acpermission_groups_pkey PRIMARY KEY (id);


--
-- Name: access_control_acpermission access_control_acpermission_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.access_control_acpermission
    ADD CONSTRAINT access_control_acpermission_pkey PRIMARY KEY (entity_ptr_id);


--
-- Name: access_control_acschedule access_control_acschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.access_control_acschedule
    ADD CONSTRAINT access_control_acschedule_pkey PRIMARY KEY (id);


--
-- Name: access_control_device access_control_device_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.access_control_device
    ADD CONSTRAINT access_control_device_pkey PRIMARY KEY (entity_ptr_id);


--
-- Name: access_control_facilitycode access_control_facilitycode_code_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.access_control_facilitycode
    ADD CONSTRAINT access_control_facilitycode_code_key UNIQUE (code);


--
-- Name: access_control_facilitycode access_control_facilitycode_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.access_control_facilitycode
    ADD CONSTRAINT access_control_facilitycode_pkey PRIMARY KEY (id);


--
-- Name: access_control_sticker access_control_sticker_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.access_control_sticker
    ADD CONSTRAINT access_control_sticker_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_key UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_key UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_key UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_key UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: authtoken_token authtoken_token_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_pkey PRIMARY KEY (key);


--
-- Name: authtoken_token authtoken_token_user_id_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_key UNIQUE (user_id);


--
-- Name: core_apirequestlog core_apirequestlog_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_apirequestlog
    ADD CONSTRAINT core_apirequestlog_pkey PRIMARY KEY (id);


--
-- Name: core_crudlog core_crudlog_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_crudlog
    ADD CONSTRAINT core_crudlog_pkey PRIMARY KEY (id);


--
-- Name: core_crudlog_y2018m09 core_crudlog_y2018m09_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_crudlog_y2018m09
    ADD CONSTRAINT core_crudlog_y2018m09_pkey PRIMARY KEY (id);


--
-- Name: core_crudlog_y2018m10 core_crudlog_y2018m10_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_crudlog_y2018m10
    ADD CONSTRAINT core_crudlog_y2018m10_pkey PRIMARY KEY (id);


--
-- Name: core_crudlog_y2018m11 core_crudlog_y2018m11_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_crudlog_y2018m11
    ADD CONSTRAINT core_crudlog_y2018m11_pkey PRIMARY KEY (id);


--
-- Name: core_crudlog_y2018m12 core_crudlog_y2018m12_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_crudlog_y2018m12
    ADD CONSTRAINT core_crudlog_y2018m12_pkey PRIMARY KEY (id);


--
-- Name: core_crudlog_y2019m01 core_crudlog_y2019m01_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_crudlog_y2019m01
    ADD CONSTRAINT core_crudlog_y2019m01_pkey PRIMARY KEY (id);


--
-- Name: core_crudlog_y2019m02 core_crudlog_y2019m02_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_crudlog_y2019m02
    ADD CONSTRAINT core_crudlog_y2019m02_pkey PRIMARY KEY (id);


--
-- Name: core_crudlog_y2019m03 core_crudlog_y2019m03_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_crudlog_y2019m03
    ADD CONSTRAINT core_crudlog_y2019m03_pkey PRIMARY KEY (id);


--
-- Name: core_crudlog_y2019m04 core_crudlog_y2019m04_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_crudlog_y2019m04
    ADD CONSTRAINT core_crudlog_y2019m04_pkey PRIMARY KEY (id);


--
-- Name: core_crudlog_y2019m05 core_crudlog_y2019m05_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_crudlog_y2019m05
    ADD CONSTRAINT core_crudlog_y2019m05_pkey PRIMARY KEY (id);


--
-- Name: core_crudlog_y2019m06 core_crudlog_y2019m06_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_crudlog_y2019m06
    ADD CONSTRAINT core_crudlog_y2019m06_pkey PRIMARY KEY (id);


--
-- Name: core_crudlog_y2019m07 core_crudlog_y2019m07_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_crudlog_y2019m07
    ADD CONSTRAINT core_crudlog_y2019m07_pkey PRIMARY KEY (id);


--
-- Name: core_crudlog_y2019m08 core_crudlog_y2019m08_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_crudlog_y2019m08
    ADD CONSTRAINT core_crudlog_y2019m08_pkey PRIMARY KEY (id);


--
-- Name: core_crudlog_y2019m09 core_crudlog_y2019m09_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_crudlog_y2019m09
    ADD CONSTRAINT core_crudlog_y2019m09_pkey PRIMARY KEY (id);


--
-- Name: core_crudlog_y2019m10 core_crudlog_y2019m10_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_crudlog_y2019m10
    ADD CONSTRAINT core_crudlog_y2019m10_pkey PRIMARY KEY (id);


--
-- Name: core_crudlog_y2019m11 core_crudlog_y2019m11_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_crudlog_y2019m11
    ADD CONSTRAINT core_crudlog_y2019m11_pkey PRIMARY KEY (id);


--
-- Name: core_crudlog_y2019m12 core_crudlog_y2019m12_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_crudlog_y2019m12
    ADD CONSTRAINT core_crudlog_y2019m12_pkey PRIMARY KEY (id);


--
-- Name: core_crudlog_y2020m01 core_crudlog_y2020m01_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_crudlog_y2020m01
    ADD CONSTRAINT core_crudlog_y2020m01_pkey PRIMARY KEY (id);


--
-- Name: core_crudlog_y2020m02 core_crudlog_y2020m02_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_crudlog_y2020m02
    ADD CONSTRAINT core_crudlog_y2020m02_pkey PRIMARY KEY (id);


--
-- Name: core_emailsuitesetting core_emailsuitesetting_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_emailsuitesetting
    ADD CONSTRAINT core_emailsuitesetting_pkey PRIMARY KEY (id);


--
-- Name: core_loggedusers core_loggedusers_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_loggedusers
    ADD CONSTRAINT core_loggedusers_pkey PRIMARY KEY (id);


--
-- Name: core_loggedusers core_loggedusers_user_id_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_loggedusers
    ADD CONSTRAINT core_loggedusers_user_id_key UNIQUE (user_id);


--
-- Name: core_module core_module_app_label_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_module
    ADD CONSTRAINT core_module_app_label_key UNIQUE (app_label);


--
-- Name: core_module core_module_name_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_module
    ADD CONSTRAINT core_module_name_key UNIQUE (name);


--
-- Name: core_module core_module_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_module
    ADD CONSTRAINT core_module_pkey PRIMARY KEY (id);


--
-- Name: core_singlesignon core_singlesignon_iv_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_singlesignon
    ADD CONSTRAINT core_singlesignon_iv_key UNIQUE (iv);


--
-- Name: core_singlesignon core_singlesignon_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_singlesignon
    ADD CONSTRAINT core_singlesignon_pkey PRIMARY KEY (id);


--
-- Name: core_ssotoken core_ssotoken_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_ssotoken
    ADD CONSTRAINT core_ssotoken_pkey PRIMARY KEY (id);


--
-- Name: core_suitepreference core_suitepreference_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_suitepreference
    ADD CONSTRAINT core_suitepreference_pkey PRIMARY KEY (id);


--
-- Name: core_userprofile core_userprofile_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_userprofile
    ADD CONSTRAINT core_userprofile_pkey PRIMARY KEY (id);


--
-- Name: core_userprofile core_userprofile_user_id_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_userprofile
    ADD CONSTRAINT core_userprofile_user_id_key UNIQUE (user_id);


--
-- Name: data_migration_datafiles data_migration_datafiles_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.data_migration_datafiles
    ADD CONSTRAINT data_migration_datafiles_pkey PRIMARY KEY (id);


--
-- Name: data_migration_profile data_migration_profile_name_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.data_migration_profile
    ADD CONSTRAINT data_migration_profile_name_key UNIQUE (name);


--
-- Name: data_migration_profile data_migration_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.data_migration_profile
    ADD CONSTRAINT data_migration_profile_pkey PRIMARY KEY (id);


--
-- Name: data_migration_reference data_migration_reference_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.data_migration_reference
    ADD CONSTRAINT data_migration_reference_pkey PRIMARY KEY (id);


--
-- Name: dbm_address dbm_address_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_address
    ADD CONSTRAINT dbm_address_pkey PRIMARY KEY (id);


--
-- Name: dbm_bolo dbm_bolo_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_bolo
    ADD CONSTRAINT dbm_bolo_pkey PRIMARY KEY (id);


--
-- Name: dbm_car dbm_car_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_car
    ADD CONSTRAINT dbm_car_pkey PRIMARY KEY (id);


--
-- Name: dbm_car dbm_car_plate_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_car
    ADD CONSTRAINT dbm_car_plate_key UNIQUE (plate);


--
-- Name: dbm_carmodel dbm_carmodel_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_carmodel
    ADD CONSTRAINT dbm_carmodel_pkey PRIMARY KEY (id);


--
-- Name: dbm_category dbm_category_name_41068eede8936a05_uniq; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_category
    ADD CONSTRAINT dbm_category_name_41068eede8936a05_uniq UNIQUE (name, family);


--
-- Name: dbm_category dbm_category_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_category
    ADD CONSTRAINT dbm_category_pkey PRIMARY KEY (id);


--
-- Name: dbm_city dbm_city_code_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_city
    ADD CONSTRAINT dbm_city_code_key UNIQUE (code);


--
-- Name: dbm_city dbm_city_name_3ecf25f16f38636f_uniq; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_city
    ADD CONSTRAINT dbm_city_name_3ecf25f16f38636f_uniq UNIQUE (name, state_id);


--
-- Name: dbm_city dbm_city_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_city
    ADD CONSTRAINT dbm_city_pkey PRIMARY KEY (id);


--
-- Name: dbm_color dbm_color_hexa_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_color
    ADD CONSTRAINT dbm_color_hexa_key UNIQUE (hexa);


--
-- Name: dbm_color dbm_color_name_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_color
    ADD CONSTRAINT dbm_color_name_key UNIQUE (name);


--
-- Name: dbm_color dbm_color_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_color
    ADD CONSTRAINT dbm_color_pkey PRIMARY KEY (id);


--
-- Name: dbm_community dbm_community_entity_id_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_community
    ADD CONSTRAINT dbm_community_entity_id_key UNIQUE (entity_id);


--
-- Name: dbm_company dbm_company_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_company
    ADD CONSTRAINT dbm_company_pkey PRIMARY KEY (id);


--
-- Name: dbm_contact_persons dbm_contact_persons_contact_id_person_id_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_contact_persons
    ADD CONSTRAINT dbm_contact_persons_contact_id_person_id_key UNIQUE (contact_id, person_id);


--
-- Name: dbm_contact_persons dbm_contact_persons_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_contact_persons
    ADD CONSTRAINT dbm_contact_persons_pkey PRIMARY KEY (id);


--
-- Name: dbm_contact dbm_contact_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_contact
    ADD CONSTRAINT dbm_contact_pkey PRIMARY KEY (id);


--
-- Name: dbm_contact dbm_contact_unit_id_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_contact
    ADD CONSTRAINT dbm_contact_unit_id_key UNIQUE (unit_id);


--
-- Name: dbm_contract dbm_contract_number_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_contract
    ADD CONSTRAINT dbm_contract_number_key UNIQUE (number);


--
-- Name: dbm_contract dbm_contract_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_contract
    ADD CONSTRAINT dbm_contract_pkey PRIMARY KEY (id);


--
-- Name: dbm_county dbm_county_name_73d9480a83f5fa6c_uniq; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_county
    ADD CONSTRAINT dbm_county_name_73d9480a83f5fa6c_uniq UNIQUE (name, state_id);


--
-- Name: dbm_county dbm_county_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_county
    ADD CONSTRAINT dbm_county_pkey PRIMARY KEY (id);


--
-- Name: dbm_decal dbm_decal_code_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_decal
    ADD CONSTRAINT dbm_decal_code_key UNIQUE (code);


--
-- Name: dbm_decal dbm_decal_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_decal
    ADD CONSTRAINT dbm_decal_pkey PRIMARY KEY (id);


--
-- Name: dbm_direction dbm_direction_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_direction
    ADD CONSTRAINT dbm_direction_pkey PRIMARY KEY (id);


--
-- Name: dbm_direction dbm_direction_unit_id_6e5c819d58077267_uniq; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_direction
    ADD CONSTRAINT dbm_direction_unit_id_6e5c819d58077267_uniq UNIQUE (unit_id, gate_id);


--
-- Name: dbm_drive_cars dbm_drive_cars_drive_id_car_id_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_drive_cars
    ADD CONSTRAINT dbm_drive_cars_drive_id_car_id_key UNIQUE (drive_id, car_id);


--
-- Name: dbm_drive_cars dbm_drive_cars_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_drive_cars
    ADD CONSTRAINT dbm_drive_cars_pkey PRIMARY KEY (id);


--
-- Name: dbm_drive dbm_drive_person_id_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_drive
    ADD CONSTRAINT dbm_drive_person_id_key UNIQUE (person_id);


--
-- Name: dbm_drive dbm_drive_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_drive
    ADD CONSTRAINT dbm_drive_pkey PRIMARY KEY (id);


--
-- Name: dbm_email dbm_email_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_email
    ADD CONSTRAINT dbm_email_pkey PRIMARY KEY (id);


--
-- Name: dbm_employee dbm_employee_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_employee
    ADD CONSTRAINT dbm_employee_pkey PRIMARY KEY (person_ptr_id);


--
-- Name: dbm_entity dbm_entity_code_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_entity
    ADD CONSTRAINT dbm_entity_code_key UNIQUE (code);


--
-- Name: dbm_entity dbm_entity_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_entity
    ADD CONSTRAINT dbm_entity_pkey PRIMARY KEY (id);


--
-- Name: dbm_event_guest_list dbm_event_guest_list_event_id_guest_id_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_event_guest_list
    ADD CONSTRAINT dbm_event_guest_list_event_id_guest_id_key UNIQUE (event_id, guest_id);


--
-- Name: dbm_event_guest_list dbm_event_guest_list_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_event_guest_list
    ADD CONSTRAINT dbm_event_guest_list_pkey PRIMARY KEY (id);


--
-- Name: dbm_event dbm_event_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_event
    ADD CONSTRAINT dbm_event_pkey PRIMARY KEY (id);


--
-- Name: dbm_gate dbm_gate_entity_id_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_gate
    ADD CONSTRAINT dbm_gate_entity_id_key UNIQUE (entity_id);


--
-- Name: dbm_guest dbm_guest_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_guest
    ADD CONSTRAINT dbm_guest_pkey PRIMARY KEY (person_ptr_id);


--
-- Name: dbm_lease dbm_lease_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_lease
    ADD CONSTRAINT dbm_lease_pkey PRIMARY KEY (id);


--
-- Name: dbm_make dbm_make_name_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_make
    ADD CONSTRAINT dbm_make_name_key UNIQUE (name);


--
-- Name: dbm_make dbm_make_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_make
    ADD CONSTRAINT dbm_make_pkey PRIMARY KEY (id);


--
-- Name: dbm_owner dbm_owner_person_id_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_owner
    ADD CONSTRAINT dbm_owner_person_id_key UNIQUE (person_id);


--
-- Name: dbm_owner dbm_owner_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_owner
    ADD CONSTRAINT dbm_owner_pkey PRIMARY KEY (id);


--
-- Name: dbm_owner_units dbm_owner_units_owner_id_unit_id_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_owner_units
    ADD CONSTRAINT dbm_owner_units_owner_id_unit_id_key UNIQUE (owner_id, unit_id);


--
-- Name: dbm_owner_units dbm_owner_units_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_owner_units
    ADD CONSTRAINT dbm_owner_units_pkey PRIMARY KEY (id);


--
-- Name: dbm_person dbm_person_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_person
    ADD CONSTRAINT dbm_person_pkey PRIMARY KEY (id);


--
-- Name: dbm_pet dbm_pet_ci_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_pet
    ADD CONSTRAINT dbm_pet_ci_key UNIQUE (ci);


--
-- Name: dbm_pet dbm_pet_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_pet
    ADD CONSTRAINT dbm_pet_pkey PRIMARY KEY (id);


--
-- Name: dbm_phone dbm_phone_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_phone
    ADD CONSTRAINT dbm_phone_pkey PRIMARY KEY (id);


--
-- Name: dbm_phonecarrier dbm_phonecarrier_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_phonecarrier
    ADD CONSTRAINT dbm_phonecarrier_pkey PRIMARY KEY (id);


--
-- Name: dbm_photo dbm_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_photo
    ADD CONSTRAINT dbm_photo_pkey PRIMARY KEY (id);


--
-- Name: dbm_realstate dbm_realstate_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_realstate
    ADD CONSTRAINT dbm_realstate_pkey PRIMARY KEY (id);


--
-- Name: dbm_resident dbm_resident_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_resident
    ADD CONSTRAINT dbm_resident_pkey PRIMARY KEY (person_ptr_id);


--
-- Name: dbm_state dbm_state_name_f20ae5aa0efadac_uniq; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_state
    ADD CONSTRAINT dbm_state_name_f20ae5aa0efadac_uniq UNIQUE (name);


--
-- Name: dbm_state dbm_state_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_state
    ADD CONSTRAINT dbm_state_pkey PRIMARY KEY (id);


--
-- Name: dbm_subcommunity dbm_subcommunity_entity_id_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_subcommunity
    ADD CONSTRAINT dbm_subcommunity_entity_id_key UNIQUE (entity_id);


--
-- Name: dbm_unit dbm_unit_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_unit
    ADD CONSTRAINT dbm_unit_pkey PRIMARY KEY (entity_ptr_id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_celery_beat_clockedschedule django_celery_beat_clockedschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.django_celery_beat_clockedschedule
    ADD CONSTRAINT django_celery_beat_clockedschedule_pkey PRIMARY KEY (id);


--
-- Name: django_celery_beat_crontabschedule django_celery_beat_crontabschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.django_celery_beat_crontabschedule
    ADD CONSTRAINT django_celery_beat_crontabschedule_pkey PRIMARY KEY (id);


--
-- Name: django_celery_beat_intervalschedule django_celery_beat_intervalschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.django_celery_beat_intervalschedule
    ADD CONSTRAINT django_celery_beat_intervalschedule_pkey PRIMARY KEY (id);


--
-- Name: django_celery_beat_periodictask django_celery_beat_periodictask_name_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.django_celery_beat_periodictask
    ADD CONSTRAINT django_celery_beat_periodictask_name_key UNIQUE (name);


--
-- Name: django_celery_beat_periodictask django_celery_beat_periodictask_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.django_celery_beat_periodictask
    ADD CONSTRAINT django_celery_beat_periodictask_pkey PRIMARY KEY (id);


--
-- Name: django_celery_beat_periodictasks django_celery_beat_periodictasks_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.django_celery_beat_periodictasks
    ADD CONSTRAINT django_celery_beat_periodictasks_pkey PRIMARY KEY (ident);


--
-- Name: django_celery_beat_solarschedule django_celery_beat_solarschedule_event_3c3aae7366feb12e_uniq; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.django_celery_beat_solarschedule
    ADD CONSTRAINT django_celery_beat_solarschedule_event_3c3aae7366feb12e_uniq UNIQUE (event, latitude, longitude);


--
-- Name: django_celery_beat_solarschedule django_celery_beat_solarschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.django_celery_beat_solarschedule
    ADD CONSTRAINT django_celery_beat_solarschedule_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_45f3b1d93ec8c61c_uniq; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_45f3b1d93ec8c61c_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_twilio_caller django_twilio_caller_phone_number_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.django_twilio_caller
    ADD CONSTRAINT django_twilio_caller_phone_number_key UNIQUE (phone_number);


--
-- Name: django_twilio_caller django_twilio_caller_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.django_twilio_caller
    ADD CONSTRAINT django_twilio_caller_pkey PRIMARY KEY (id);


--
-- Name: django_twilio_credential django_twilio_credential_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.django_twilio_credential
    ADD CONSTRAINT django_twilio_credential_pkey PRIMARY KEY (id);


--
-- Name: django_twilio_credential django_twilio_credential_user_id_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.django_twilio_credential
    ADD CONSTRAINT django_twilio_credential_user_id_key UNIQUE (user_id);


--
-- Name: incident_report_icar incident_report_icar_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.incident_report_icar
    ADD CONSTRAINT incident_report_icar_pkey PRIMARY KEY (id);


--
-- Name: incident_report_icategory incident_report_icategory_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.incident_report_icategory
    ADD CONSTRAINT incident_report_icategory_pkey PRIMARY KEY (id);


--
-- Name: incident_report_incident incident_report_incident_number_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.incident_report_incident
    ADD CONSTRAINT incident_report_incident_number_key UNIQUE (number);


--
-- Name: incident_report_incident incident_report_incident_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.incident_report_incident
    ADD CONSTRAINT incident_report_incident_pkey PRIMARY KEY (id);


--
-- Name: incident_report_incidentstatus incident_report_incidentstatus_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.incident_report_incidentstatus
    ADD CONSTRAINT incident_report_incidentstatus_pkey PRIMARY KEY (id);


--
-- Name: incident_report_iperson incident_report_iperson_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.incident_report_iperson
    ADD CONSTRAINT incident_report_iperson_pkey PRIMARY KEY (id);


--
-- Name: incident_report_iunit incident_report_iunit_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.incident_report_iunit
    ADD CONSTRAINT incident_report_iunit_pkey PRIMARY KEY (id);


--
-- Name: incident_report_iupdate incident_report_iupdate_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.incident_report_iupdate
    ADD CONSTRAINT incident_report_iupdate_pkey PRIMARY KEY (id);


--
-- Name: incident_report_media incident_report_media_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.incident_report_media
    ADD CONSTRAINT incident_report_media_pkey PRIMARY KEY (id);


--
-- Name: notification_message notification_message_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.notification_message
    ADD CONSTRAINT notification_message_pkey PRIMARY KEY (id);


--
-- Name: report_engine_accesscodelog report_engine_accesscodelog_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_accesscodelog
    ADD CONSTRAINT report_engine_accesscodelog_pkey PRIMARY KEY (id);


--
-- Name: report_engine_accesscodelog_y2018m10 report_engine_accesscodelog_y2018m10_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_accesscodelog_y2018m10
    ADD CONSTRAINT report_engine_accesscodelog_y2018m10_pkey PRIMARY KEY (id);


--
-- Name: report_engine_accesscodelog_y2018m12 report_engine_accesscodelog_y2018m12_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_accesscodelog_y2018m12
    ADD CONSTRAINT report_engine_accesscodelog_y2018m12_pkey PRIMARY KEY (id);


--
-- Name: report_engine_accesscodelog_y2019m01 report_engine_accesscodelog_y2019m01_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_accesscodelog_y2019m01
    ADD CONSTRAINT report_engine_accesscodelog_y2019m01_pkey PRIMARY KEY (id);


--
-- Name: report_engine_accesscodelog_y2019m02 report_engine_accesscodelog_y2019m02_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_accesscodelog_y2019m02
    ADD CONSTRAINT report_engine_accesscodelog_y2019m02_pkey PRIMARY KEY (id);


--
-- Name: report_engine_accesscodelog_y2019m03 report_engine_accesscodelog_y2019m03_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_accesscodelog_y2019m03
    ADD CONSTRAINT report_engine_accesscodelog_y2019m03_pkey PRIMARY KEY (id);


--
-- Name: report_engine_accesscodelog_y2019m04 report_engine_accesscodelog_y2019m04_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_accesscodelog_y2019m04
    ADD CONSTRAINT report_engine_accesscodelog_y2019m04_pkey PRIMARY KEY (id);


--
-- Name: report_engine_accesscodelog_y2019m05 report_engine_accesscodelog_y2019m05_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_accesscodelog_y2019m05
    ADD CONSTRAINT report_engine_accesscodelog_y2019m05_pkey PRIMARY KEY (id);


--
-- Name: report_engine_accesscodelog_y2019m06 report_engine_accesscodelog_y2019m06_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_accesscodelog_y2019m06
    ADD CONSTRAINT report_engine_accesscodelog_y2019m06_pkey PRIMARY KEY (id);


--
-- Name: report_engine_accesscodelog_y2019m07 report_engine_accesscodelog_y2019m07_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_accesscodelog_y2019m07
    ADD CONSTRAINT report_engine_accesscodelog_y2019m07_pkey PRIMARY KEY (id);


--
-- Name: report_engine_accesscodelog_y2019m08 report_engine_accesscodelog_y2019m08_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_accesscodelog_y2019m08
    ADD CONSTRAINT report_engine_accesscodelog_y2019m08_pkey PRIMARY KEY (id);


--
-- Name: report_engine_accesscodelog_y2019m09 report_engine_accesscodelog_y2019m09_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_accesscodelog_y2019m09
    ADD CONSTRAINT report_engine_accesscodelog_y2019m09_pkey PRIMARY KEY (id);


--
-- Name: report_engine_accesscodelog_y2019m10 report_engine_accesscodelog_y2019m10_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_accesscodelog_y2019m10
    ADD CONSTRAINT report_engine_accesscodelog_y2019m10_pkey PRIMARY KEY (id);


--
-- Name: report_engine_accesscodelog_y2019m11 report_engine_accesscodelog_y2019m11_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_accesscodelog_y2019m11
    ADD CONSTRAINT report_engine_accesscodelog_y2019m11_pkey PRIMARY KEY (id);


--
-- Name: report_engine_accesscodelog_y2019m12 report_engine_accesscodelog_y2019m12_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_accesscodelog_y2019m12
    ADD CONSTRAINT report_engine_accesscodelog_y2019m12_pkey PRIMARY KEY (id);


--
-- Name: report_engine_accesscodelog_y2020m01 report_engine_accesscodelog_y2020m01_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_accesscodelog_y2020m01
    ADD CONSTRAINT report_engine_accesscodelog_y2020m01_pkey PRIMARY KEY (id);


--
-- Name: report_engine_accesscodelog_y2020m02 report_engine_accesscodelog_y2020m02_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_accesscodelog_y2020m02
    ADD CONSTRAINT report_engine_accesscodelog_y2020m02_pkey PRIMARY KEY (id);


--
-- Name: report_engine_visitor report_engine_visitor_index_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_visitor
    ADD CONSTRAINT report_engine_visitor_index_key UNIQUE (index);


--
-- Name: report_engine_visitor report_engine_visitor_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_visitor
    ADD CONSTRAINT report_engine_visitor_pkey PRIMARY KEY (id);


--
-- Name: report_engine_visitorlog report_engine_visitorlog_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_visitorlog
    ADD CONSTRAINT report_engine_visitorlog_pkey PRIMARY KEY (id);


--
-- Name: report_engine_visitorlog_y2018m12 report_engine_visitorlog_y2018m12_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_visitorlog_y2018m12
    ADD CONSTRAINT report_engine_visitorlog_y2018m12_pkey PRIMARY KEY (id);


--
-- Name: report_engine_visitorlog_y2019m01 report_engine_visitorlog_y2019m01_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_visitorlog_y2019m01
    ADD CONSTRAINT report_engine_visitorlog_y2019m01_pkey PRIMARY KEY (id);


--
-- Name: report_engine_visitorlog_y2019m02 report_engine_visitorlog_y2019m02_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_visitorlog_y2019m02
    ADD CONSTRAINT report_engine_visitorlog_y2019m02_pkey PRIMARY KEY (id);


--
-- Name: report_engine_visitorlog_y2019m03 report_engine_visitorlog_y2019m03_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_visitorlog_y2019m03
    ADD CONSTRAINT report_engine_visitorlog_y2019m03_pkey PRIMARY KEY (id);


--
-- Name: report_engine_visitorlog_y2019m04 report_engine_visitorlog_y2019m04_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_visitorlog_y2019m04
    ADD CONSTRAINT report_engine_visitorlog_y2019m04_pkey PRIMARY KEY (id);


--
-- Name: report_engine_visitorlog_y2019m05 report_engine_visitorlog_y2019m05_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_visitorlog_y2019m05
    ADD CONSTRAINT report_engine_visitorlog_y2019m05_pkey PRIMARY KEY (id);


--
-- Name: report_engine_visitorlog_y2019m06 report_engine_visitorlog_y2019m06_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_visitorlog_y2019m06
    ADD CONSTRAINT report_engine_visitorlog_y2019m06_pkey PRIMARY KEY (id);


--
-- Name: report_engine_visitorlog_y2019m07 report_engine_visitorlog_y2019m07_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_visitorlog_y2019m07
    ADD CONSTRAINT report_engine_visitorlog_y2019m07_pkey PRIMARY KEY (id);


--
-- Name: report_engine_visitorlog_y2019m08 report_engine_visitorlog_y2019m08_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_visitorlog_y2019m08
    ADD CONSTRAINT report_engine_visitorlog_y2019m08_pkey PRIMARY KEY (id);


--
-- Name: report_engine_visitorlog_y2019m09 report_engine_visitorlog_y2019m09_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_visitorlog_y2019m09
    ADD CONSTRAINT report_engine_visitorlog_y2019m09_pkey PRIMARY KEY (id);


--
-- Name: report_engine_visitorlog_y2019m10 report_engine_visitorlog_y2019m10_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_visitorlog_y2019m10
    ADD CONSTRAINT report_engine_visitorlog_y2019m10_pkey PRIMARY KEY (id);


--
-- Name: report_engine_visitorlog_y2019m11 report_engine_visitorlog_y2019m11_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_visitorlog_y2019m11
    ADD CONSTRAINT report_engine_visitorlog_y2019m11_pkey PRIMARY KEY (id);


--
-- Name: report_engine_visitorlog_y2019m12 report_engine_visitorlog_y2019m12_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_visitorlog_y2019m12
    ADD CONSTRAINT report_engine_visitorlog_y2019m12_pkey PRIMARY KEY (id);


--
-- Name: report_engine_visitorlog_y2020m01 report_engine_visitorlog_y2020m01_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_visitorlog_y2020m01
    ADD CONSTRAINT report_engine_visitorlog_y2020m01_pkey PRIMARY KEY (id);


--
-- Name: report_engine_visitorlog_y2020m02 report_engine_visitorlog_y2020m02_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_visitorlog_y2020m02
    ADD CONSTRAINT report_engine_visitorlog_y2020m02_pkey PRIMARY KEY (id);


--
-- Name: residents_website_invitation residents_website_invitation_code_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.residents_website_invitation
    ADD CONSTRAINT residents_website_invitation_code_key UNIQUE (code);


--
-- Name: residents_website_invitationtexttemplate residents_website_invitationtexttemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.residents_website_invitationtexttemplate
    ADD CONSTRAINT residents_website_invitationtexttemplate_pkey PRIMARY KEY (id);


--
-- Name: residents_website_notification residents_website_notificatio_resident_id_6f960651dc294b9b_uniq; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.residents_website_notification
    ADD CONSTRAINT residents_website_notificatio_resident_id_6f960651dc294b9b_uniq UNIQUE (resident_id);


--
-- Name: residents_website_notification residents_website_notification_email_id_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.residents_website_notification
    ADD CONSTRAINT residents_website_notification_email_id_key UNIQUE (email_id);


--
-- Name: residents_website_notification residents_website_notification_phone_id_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.residents_website_notification
    ADD CONSTRAINT residents_website_notification_phone_id_key UNIQUE (phone_id);


--
-- Name: residents_website_notification residents_website_notification_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.residents_website_notification
    ADD CONSTRAINT residents_website_notification_pkey PRIMARY KEY (id);


--
-- Name: residents_website_profile residents_website_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.residents_website_profile
    ADD CONSTRAINT residents_website_profile_pkey PRIMARY KEY (user_ptr_id);


--
-- Name: residents_website_profile residents_website_profile_resident_id_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.residents_website_profile
    ADD CONSTRAINT residents_website_profile_resident_id_key UNIQUE (resident_id);


--
-- Name: rules_rule rules_rule_code_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.rules_rule
    ADD CONSTRAINT rules_rule_code_key UNIQUE (code);


--
-- Name: rules_rule rules_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.rules_rule
    ADD CONSTRAINT rules_rule_pkey PRIMARY KEY (id);


--
-- Name: task_attachment task_attachment_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_attachment
    ADD CONSTRAINT task_attachment_pkey PRIMARY KEY (id);


--
-- Name: task_attachment task_attachment_task_id_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_attachment
    ADD CONSTRAINT task_attachment_task_id_key UNIQUE (task_id);


--
-- Name: task_checklist task_checklist_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_checklist
    ADD CONSTRAINT task_checklist_pkey PRIMARY KEY (id);


--
-- Name: task_comment task_comment_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_comment
    ADD CONSTRAINT task_comment_pkey PRIMARY KEY (id);


--
-- Name: task_label task_label_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_label
    ADD CONSTRAINT task_label_pkey PRIMARY KEY (id);


--
-- Name: task_status task_status_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_status
    ADD CONSTRAINT task_status_pkey PRIMARY KEY (id);


--
-- Name: task_task_labels task_task_labels_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_task_labels
    ADD CONSTRAINT task_task_labels_pkey PRIMARY KEY (id);


--
-- Name: task_task_labels task_task_labels_task_id_label_id_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_task_labels
    ADD CONSTRAINT task_task_labels_task_id_label_id_key UNIQUE (task_id, label_id);


--
-- Name: task_task_members task_task_members_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_task_members
    ADD CONSTRAINT task_task_members_pkey PRIMARY KEY (id);


--
-- Name: task_task_members task_task_members_task_id_user_id_key; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_task_members
    ADD CONSTRAINT task_task_members_task_id_user_id_key UNIQUE (task_id, user_id);


--
-- Name: task_task task_task_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_task
    ADD CONSTRAINT task_task_pkey PRIMARY KEY (id);


--
-- Name: task_taskcategory task_taskcategory_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_taskcategory
    ADD CONSTRAINT task_taskcategory_pkey PRIMARY KEY (id);


--
-- Name: task_taskgroup task_taskgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_taskgroup
    ADD CONSTRAINT task_taskgroup_pkey PRIMARY KEY (id);


--
-- Name: task_taskschedule task_taskschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_taskschedule
    ADD CONSTRAINT task_taskschedule_pkey PRIMARY KEY (task_id);


--
-- Name: task_vote task_vote_pkey; Type: CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_vote
    ADD CONSTRAINT task_vote_pkey PRIMARY KEY (id);


--
-- Name: access_control_accesscode_417f1b1c; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX access_control_accesscode_417f1b1c ON public.access_control_accesscode USING btree (content_type_id);


--
-- Name: access_control_accesscode_a699e6c1; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX access_control_accesscode_a699e6c1 ON public.access_control_accesscode USING btree (facility_code_id);


--
-- Name: access_control_accesscode_groups_7f944755; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX access_control_accesscode_groups_7f944755 ON public.access_control_accesscode_groups USING btree (acgroup_id);


--
-- Name: access_control_accesscode_groups_d0ded932; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX access_control_accesscode_groups_d0ded932 ON public.access_control_accesscode_groups USING btree (accesscode_id);


--
-- Name: access_control_acgroup_name_4c0273a3c784e702_like; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX access_control_acgroup_name_4c0273a3c784e702_like ON public.access_control_acgroup USING btree (name varchar_pattern_ops);


--
-- Name: access_control_acpermission_9bc70bb9; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX access_control_acpermission_9bc70bb9 ON public.access_control_acpermission USING btree (schedule_id);


--
-- Name: access_control_acpermission_devices_9379346c; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX access_control_acpermission_devices_9379346c ON public.access_control_acpermission_devices USING btree (device_id);


--
-- Name: access_control_acpermission_devices_bcf1d376; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX access_control_acpermission_devices_bcf1d376 ON public.access_control_acpermission_devices USING btree (acpermission_id);


--
-- Name: access_control_acpermission_groups_7f944755; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX access_control_acpermission_groups_7f944755 ON public.access_control_acpermission_groups USING btree (acgroup_id);


--
-- Name: access_control_acpermission_groups_bcf1d376; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX access_control_acpermission_groups_bcf1d376 ON public.access_control_acpermission_groups USING btree (acpermission_id);


--
-- Name: access_control_device_36c028e3; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX access_control_device_36c028e3 ON public.access_control_device USING btree (gate_id);


--
-- Name: access_control_facilitycode_code_6a628d3befce4286_like; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX access_control_facilitycode_code_6a628d3befce4286_like ON public.access_control_facilitycode USING btree (code varchar_pattern_ops);


--
-- Name: access_control_sticker_a699e6c1; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX access_control_sticker_a699e6c1 ON public.access_control_sticker USING btree (facility_code_id);


--
-- Name: auth_group_name_253ae2a6331666e8_like; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX auth_group_name_253ae2a6331666e8_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_0e939a4f; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX auth_group_permissions_0e939a4f ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_8373b171; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX auth_group_permissions_8373b171 ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_417f1b1c; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX auth_permission_417f1b1c ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_0e939a4f; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX auth_user_groups_0e939a4f ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_e8701ad4; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX auth_user_groups_e8701ad4 ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_8373b171; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX auth_user_user_permissions_8373b171 ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_e8701ad4; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX auth_user_user_permissions_e8701ad4 ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_51b3b110094b8aae_like; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX auth_user_username_51b3b110094b8aae_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: authtoken_token_key_7222ec672cd32dcd_like; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX authtoken_token_key_7222ec672cd32dcd_like ON public.authtoken_token USING btree (key varchar_pattern_ops);


--
-- Name: core_apirequestlog_3ef8c07f; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX core_apirequestlog_3ef8c07f ON public.core_apirequestlog USING btree (requested_at);


--
-- Name: core_apirequestlog_417f1b1c; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX core_apirequestlog_417f1b1c ON public.core_apirequestlog USING btree (content_type_id);


--
-- Name: core_apirequestlog_be63d8c5; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX core_apirequestlog_be63d8c5 ON public.core_apirequestlog USING btree (query_params);


--
-- Name: core_apirequestlog_d6fe1d0b; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX core_apirequestlog_d6fe1d0b ON public.core_apirequestlog USING btree (path);


--
-- Name: core_apirequestlog_e8701ad4; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX core_apirequestlog_e8701ad4 ON public.core_apirequestlog USING btree (user_id);


--
-- Name: core_apirequestlog_path_6b422ad83874da49_like; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX core_apirequestlog_path_6b422ad83874da49_like ON public.core_apirequestlog USING btree (path varchar_pattern_ops);


--
-- Name: core_apirequestlog_query_params_31ec797075972041_like; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX core_apirequestlog_query_params_31ec797075972041_like ON public.core_apirequestlog USING btree (query_params text_pattern_ops);


--
-- Name: core_module_app_label_e336b12139018b9_like; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX core_module_app_label_e336b12139018b9_like ON public.core_module USING btree (app_label varchar_pattern_ops);


--
-- Name: core_module_name_5cf52158c84f83d1_like; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX core_module_name_5cf52158c84f83d1_like ON public.core_module USING btree (name varchar_pattern_ops);


--
-- Name: core_singlesignon_iv_28d7062892577155_like; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX core_singlesignon_iv_28d7062892577155_like ON public.core_singlesignon USING btree (iv text_pattern_ops);


--
-- Name: core_singlesignon_private_key_f585924f5dfc3bc_like; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX core_singlesignon_private_key_f585924f5dfc3bc_like ON public.core_singlesignon USING btree (private_key text_pattern_ops);


--
-- Name: core_singlesignon_public_key_7a4b4bd37643f503_like; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX core_singlesignon_public_key_7a4b4bd37643f503_like ON public.core_singlesignon USING btree (public_key text_pattern_ops);


--
-- Name: core_ssotoken_1db5a817; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX core_ssotoken_1db5a817 ON public.core_ssotoken USING btree (consumer_id);


--
-- Name: core_ssotoken_e8701ad4; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX core_ssotoken_e8701ad4 ON public.core_ssotoken USING btree (user_id);


--
-- Name: core_ssotoken_request_token_4f7092de712444c_like; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX core_ssotoken_request_token_4f7092de712444c_like ON public.core_ssotoken USING btree (request_token varchar_pattern_ops);


--
-- Name: core_suitepreference_c9799665; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX core_suitepreference_c9799665 ON public.core_suitepreference USING btree (module_id);


--
-- Name: data_migration_datafiles_e8701ad4; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX data_migration_datafiles_e8701ad4 ON public.data_migration_datafiles USING btree (user_id);


--
-- Name: data_migration_profile_d11782a6; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX data_migration_profile_d11782a6 ON public.data_migration_profile USING btree (dependency_id);


--
-- Name: data_migration_profile_name_1a4f1400bbe2f7af_like; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX data_migration_profile_name_1a4f1400bbe2f7af_like ON public.data_migration_profile USING btree (name varchar_pattern_ops);


--
-- Name: data_migration_reference_83a0eb3f; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX data_migration_reference_83a0eb3f ON public.data_migration_reference USING btree (profile_id);


--
-- Name: dbm_address_c7141997; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_address_c7141997 ON public.dbm_address USING btree (city_id);


--
-- Name: dbm_car_2a8feb1a; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_car_2a8feb1a ON public.dbm_car USING btree ("mainColor_id");


--
-- Name: dbm_car_477cbf8a; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_car_477cbf8a ON public.dbm_car USING btree (model_id);


--
-- Name: dbm_car_5e7b1936; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_car_5e7b1936 ON public.dbm_car USING btree (owner_id);


--
-- Name: dbm_car_b75c53da; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_car_b75c53da ON public.dbm_car USING btree ("secColor_id");


--
-- Name: dbm_car_d5582625; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_car_d5582625 ON public.dbm_car USING btree (state_id);


--
-- Name: dbm_car_plate_75af3a65a144cd89_like; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_car_plate_75af3a65a144cd89_like ON public.dbm_car USING btree (plate varchar_pattern_ops);


--
-- Name: dbm_carmodel_14dd5396; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_carmodel_14dd5396 ON public.dbm_carmodel USING btree (make_id);


--
-- Name: dbm_category_656442a0; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_category_656442a0 ON public.dbm_category USING btree (tree_id);


--
-- Name: dbm_category_6be37982; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_category_6be37982 ON public.dbm_category USING btree (parent_id);


--
-- Name: dbm_city_code_7f395e507d02a71d_like; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_city_code_7f395e507d02a71d_like ON public.dbm_city USING btree (code varchar_pattern_ops);


--
-- Name: dbm_city_d19428be; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_city_d19428be ON public.dbm_city USING btree (county_id);


--
-- Name: dbm_city_d5582625; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_city_d5582625 ON public.dbm_city USING btree (state_id);


--
-- Name: dbm_color_hexa_33629017ad00c899_like; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_color_hexa_33629017ad00c899_like ON public.dbm_color USING btree (hexa varchar_pattern_ops);


--
-- Name: dbm_color_name_301a370b4df4d816_like; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_color_name_301a370b4df4d816_like ON public.dbm_color USING btree (name varchar_pattern_ops);


--
-- Name: dbm_contact_447d3092; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_contact_447d3092 ON public.dbm_contact USING btree (company_id);


--
-- Name: dbm_contact_ea8e5d12; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_contact_ea8e5d12 ON public.dbm_contact USING btree (address_id);


--
-- Name: dbm_contact_persons_6d82f13d; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_contact_persons_6d82f13d ON public.dbm_contact_persons USING btree (contact_id);


--
-- Name: dbm_contact_persons_a8452ca7; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_contact_persons_a8452ca7 ON public.dbm_contact_persons USING btree (person_id);


--
-- Name: dbm_contract_4c66c5b6; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_contract_4c66c5b6 ON public.dbm_contract USING btree (responsible_id);


--
-- Name: dbm_contract_e167e732; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_contract_e167e732 ON public.dbm_contract USING btree (community_id);


--
-- Name: dbm_contract_number_1eb96c4a70537994_like; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_contract_number_1eb96c4a70537994_like ON public.dbm_contract USING btree (number varchar_pattern_ops);


--
-- Name: dbm_county_d5582625; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_county_d5582625 ON public.dbm_county USING btree (state_id);


--
-- Name: dbm_decal_35ec04dc; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_decal_35ec04dc ON public.dbm_decal USING btree (vehicle_id);


--
-- Name: dbm_decal_code_149420189dde9aca_like; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_decal_code_149420189dde9aca_like ON public.dbm_decal USING btree (code varchar_pattern_ops);


--
-- Name: dbm_direction_36c028e3; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_direction_36c028e3 ON public.dbm_direction USING btree (gate_id);


--
-- Name: dbm_direction_e8175980; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_direction_e8175980 ON public.dbm_direction USING btree (unit_id);


--
-- Name: dbm_drive_cars_2f9a31f3; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_drive_cars_2f9a31f3 ON public.dbm_drive_cars USING btree (drive_id);


--
-- Name: dbm_drive_cars_cf8b1f8d; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_drive_cars_cf8b1f8d ON public.dbm_drive_cars USING btree (car_id);


--
-- Name: dbm_email_6d82f13d; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_email_6d82f13d ON public.dbm_email USING btree (contact_id);


--
-- Name: dbm_email_b583a629; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_email_b583a629 ON public.dbm_email USING btree (category_id);


--
-- Name: dbm_employee_447d3092; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_employee_447d3092 ON public.dbm_employee USING btree (company_id);


--
-- Name: dbm_employee_e8175980; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_employee_e8175980 ON public.dbm_employee USING btree (unit_id);


--
-- Name: dbm_entity_code_51b610a5f9cf1731_like; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_entity_code_51b610a5f9cf1731_like ON public.dbm_entity USING btree (code varchar_pattern_ops);


--
-- Name: dbm_event_417f1b1c; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_event_417f1b1c ON public.dbm_event USING btree (content_type_id);


--
-- Name: dbm_event_guest_list_4437cfac; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_event_guest_list_4437cfac ON public.dbm_event_guest_list USING btree (event_id);


--
-- Name: dbm_event_guest_list_64701d7f; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_event_guest_list_64701d7f ON public.dbm_event_guest_list USING btree (guest_id);


--
-- Name: dbm_gate_3739f508; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_gate_3739f508 ON public.dbm_gate USING btree (subcommunity_id);


--
-- Name: dbm_guest_447d3092; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_guest_447d3092 ON public.dbm_guest USING btree (company_id);


--
-- Name: dbm_guest_8396f175; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_guest_8396f175 ON public.dbm_guest USING btree (host_id);


--
-- Name: dbm_guest_e8175980; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_guest_e8175980 ON public.dbm_guest USING btree (unit_id);


--
-- Name: dbm_lease_e8175980; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_lease_e8175980 ON public.dbm_lease USING btree (unit_id);


--
-- Name: dbm_make_name_1fe2374b4e382fc8_like; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_make_name_1fe2374b4e382fc8_like ON public.dbm_make USING btree (name varchar_pattern_ops);


--
-- Name: dbm_owner_units_5e7b1936; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_owner_units_5e7b1936 ON public.dbm_owner_units USING btree (owner_id);


--
-- Name: dbm_owner_units_e8175980; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_owner_units_e8175980 ON public.dbm_owner_units USING btree (unit_id);


--
-- Name: dbm_person_b583a629; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_person_b583a629 ON public.dbm_person USING btree (category_id);


--
-- Name: dbm_pet_18a08c7e; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_pet_18a08c7e ON public.dbm_pet USING btree (pet_category_id);


--
-- Name: dbm_pet_5e7b1936; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_pet_5e7b1936 ON public.dbm_pet USING btree (owner_id);


--
-- Name: dbm_pet_ci_3290eedff7573c8b_like; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_pet_ci_3290eedff7573c8b_like ON public.dbm_pet USING btree (ci varchar_pattern_ops);


--
-- Name: dbm_phone_6d82f13d; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_phone_6d82f13d ON public.dbm_phone USING btree (contact_id);


--
-- Name: dbm_phone_b583a629; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_phone_b583a629 ON public.dbm_phone USING btree (category_id);


--
-- Name: dbm_phone_ed09056b; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_phone_ed09056b ON public.dbm_phone USING btree (carrier_id);


--
-- Name: dbm_photo_417f1b1c; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_photo_417f1b1c ON public.dbm_photo USING btree (content_type_id);


--
-- Name: dbm_photo_b583a629; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_photo_b583a629 ON public.dbm_photo USING btree (category_id);


--
-- Name: dbm_realstate_b583a629; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_realstate_b583a629 ON public.dbm_realstate USING btree (category_id);


--
-- Name: dbm_realstate_e8175980; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_realstate_e8175980 ON public.dbm_realstate USING btree (unit_id);


--
-- Name: dbm_resident_56d9b55d; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_resident_56d9b55d ON public.dbm_resident USING btree (lease_id);


--
-- Name: dbm_resident_e3b697d4; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_resident_e3b697d4 ON public.dbm_resident USING btree (residence_id);


--
-- Name: dbm_subcommunity_e167e732; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_subcommunity_e167e732 ON public.dbm_subcommunity USING btree (community_id);


--
-- Name: dbm_unit_ac33b8db; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_unit_ac33b8db ON public.dbm_unit USING btree ("subCommunity_id");


--
-- Name: dbm_unit_b583a629; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX dbm_unit_b583a629 ON public.dbm_unit USING btree (category_id);


--
-- Name: django_admin_log_417f1b1c; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX django_admin_log_417f1b1c ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_e8701ad4; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX django_admin_log_e8701ad4 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_celery_beat_periodictask_1dcd7040; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX django_celery_beat_periodictask_1dcd7040 ON public.django_celery_beat_periodictask USING btree (interval_id);


--
-- Name: django_celery_beat_periodictask_9a874ea8; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX django_celery_beat_periodictask_9a874ea8 ON public.django_celery_beat_periodictask USING btree (solar_id);


--
-- Name: django_celery_beat_periodictask_clocked_id_47a69f82; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX django_celery_beat_periodictask_clocked_id_47a69f82 ON public.django_celery_beat_periodictask USING btree (clocked_id);


--
-- Name: django_celery_beat_periodictask_f3f0d72a; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX django_celery_beat_periodictask_f3f0d72a ON public.django_celery_beat_periodictask USING btree (crontab_id);


--
-- Name: django_celery_beat_periodictask_name_5b147be2a6046d2_like; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX django_celery_beat_periodictask_name_5b147be2a6046d2_like ON public.django_celery_beat_periodictask USING btree (name varchar_pattern_ops);


--
-- Name: django_session_de54fa62; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX django_session_de54fa62 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_461cfeaa630ca218_like; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX django_session_session_key_461cfeaa630ca218_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: django_twilio_caller_phone_number_42b76f90df5647b1_like; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX django_twilio_caller_phone_number_42b76f90df5647b1_like ON public.django_twilio_caller USING btree (phone_number varchar_pattern_ops);


--
-- Name: incident_report_icar_f5ce6141; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX incident_report_icar_f5ce6141 ON public.incident_report_icar USING btree (incident_id);


--
-- Name: incident_report_icategory_656442a0; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX incident_report_icategory_656442a0 ON public.incident_report_icategory USING btree (tree_id);


--
-- Name: incident_report_icategory_6be37982; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX incident_report_icategory_6be37982 ON public.incident_report_icategory USING btree (parent_id);


--
-- Name: incident_report_incident_22e22e30; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX incident_report_incident_22e22e30 ON public.incident_report_incident USING btree (disposition_id);


--
-- Name: incident_report_incident_3739f508; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX incident_report_incident_3739f508 ON public.incident_report_incident USING btree (subcommunity_id);


--
-- Name: incident_report_incident_4c66c5b6; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX incident_report_incident_4c66c5b6 ON public.incident_report_incident USING btree (responsible_id);


--
-- Name: incident_report_incident_5e7b1936; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX incident_report_incident_5e7b1936 ON public.incident_report_incident USING btree (owner_id);


--
-- Name: incident_report_incident_b583a629; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX incident_report_incident_b583a629 ON public.incident_report_incident USING btree (category_id);


--
-- Name: incident_report_incident_dc91ed4b; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX incident_report_incident_dc91ed4b ON public.incident_report_incident USING btree (status_id);


--
-- Name: incident_report_incident_number_34a53c6a2f9d41a1_like; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX incident_report_incident_number_34a53c6a2f9d41a1_like ON public.incident_report_incident USING btree (number varchar_pattern_ops);


--
-- Name: incident_report_iperson_f5ce6141; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX incident_report_iperson_f5ce6141 ON public.incident_report_iperson USING btree (incident_id);


--
-- Name: incident_report_iunit_f5ce6141; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX incident_report_iunit_f5ce6141 ON public.incident_report_iunit USING btree (incident_id);


--
-- Name: incident_report_iupdate_3700153c; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX incident_report_iupdate_3700153c ON public.incident_report_iupdate USING btree (creator_id);


--
-- Name: incident_report_iupdate_f5ce6141; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX incident_report_iupdate_f5ce6141 ON public.incident_report_iupdate USING btree (incident_id);


--
-- Name: incident_report_media_94757cae; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX incident_report_media_94757cae ON public.incident_report_media USING btree (type_id);


--
-- Name: incident_report_media_f5ce6141; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX incident_report_media_f5ce6141 ON public.incident_report_media USING btree (incident_id);


--
-- Name: notification_message_c139bdcd; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX notification_message_c139bdcd ON public.notification_message USING btree (user_to_id);


--
-- Name: notification_message_e1e8addb; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX notification_message_e1e8addb ON public.notification_message USING btree (user_from_id);


--
-- Name: report_engine_accesscodelog_e8701ad4; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_accesscodelog_e8701ad4 ON public.report_engine_accesscodelog USING btree (user_id);


--
-- Name: report_engine_accesscodelog_y2018m10_user_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_accesscodelog_y2018m10_user_id_idx ON public.report_engine_accesscodelog_y2018m10 USING btree (user_id);


--
-- Name: report_engine_accesscodelog_y2018m12_user_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_accesscodelog_y2018m12_user_id_idx ON public.report_engine_accesscodelog_y2018m12 USING btree (user_id);


--
-- Name: report_engine_accesscodelog_y2019m01_user_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_accesscodelog_y2019m01_user_id_idx ON public.report_engine_accesscodelog_y2019m01 USING btree (user_id);


--
-- Name: report_engine_accesscodelog_y2019m02_user_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_accesscodelog_y2019m02_user_id_idx ON public.report_engine_accesscodelog_y2019m02 USING btree (user_id);


--
-- Name: report_engine_accesscodelog_y2019m03_user_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_accesscodelog_y2019m03_user_id_idx ON public.report_engine_accesscodelog_y2019m03 USING btree (user_id);


--
-- Name: report_engine_accesscodelog_y2019m04_user_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_accesscodelog_y2019m04_user_id_idx ON public.report_engine_accesscodelog_y2019m04 USING btree (user_id);


--
-- Name: report_engine_accesscodelog_y2019m05_user_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_accesscodelog_y2019m05_user_id_idx ON public.report_engine_accesscodelog_y2019m05 USING btree (user_id);


--
-- Name: report_engine_accesscodelog_y2019m06_user_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_accesscodelog_y2019m06_user_id_idx ON public.report_engine_accesscodelog_y2019m06 USING btree (user_id);


--
-- Name: report_engine_accesscodelog_y2019m07_user_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_accesscodelog_y2019m07_user_id_idx ON public.report_engine_accesscodelog_y2019m07 USING btree (user_id);


--
-- Name: report_engine_accesscodelog_y2019m08_user_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_accesscodelog_y2019m08_user_id_idx ON public.report_engine_accesscodelog_y2019m08 USING btree (user_id);


--
-- Name: report_engine_accesscodelog_y2019m09_user_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_accesscodelog_y2019m09_user_id_idx ON public.report_engine_accesscodelog_y2019m09 USING btree (user_id);


--
-- Name: report_engine_accesscodelog_y2019m10_user_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_accesscodelog_y2019m10_user_id_idx ON public.report_engine_accesscodelog_y2019m10 USING btree (user_id);


--
-- Name: report_engine_accesscodelog_y2019m11_user_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_accesscodelog_y2019m11_user_id_idx ON public.report_engine_accesscodelog_y2019m11 USING btree (user_id);


--
-- Name: report_engine_accesscodelog_y2019m12_user_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_accesscodelog_y2019m12_user_id_idx ON public.report_engine_accesscodelog_y2019m12 USING btree (user_id);


--
-- Name: report_engine_accesscodelog_y2020m01_user_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_accesscodelog_y2020m01_user_id_idx ON public.report_engine_accesscodelog_y2020m01 USING btree (user_id);


--
-- Name: report_engine_accesscodelog_y2020m02_user_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_accesscodelog_y2020m02_user_id_idx ON public.report_engine_accesscodelog_y2020m02 USING btree (user_id);


--
-- Name: report_engine_visitor_index_2f3482aa5c99b9d7_like; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_visitor_index_2f3482aa5c99b9d7_like ON public.report_engine_visitor USING btree (index varchar_pattern_ops);


--
-- Name: report_engine_visitorlog_bfc2f125; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_visitorlog_bfc2f125 ON public.report_engine_visitorlog USING btree (visitor_id);


--
-- Name: report_engine_visitorlog_e8701ad4; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_visitorlog_e8701ad4 ON public.report_engine_visitorlog USING btree (user_id);


--
-- Name: report_engine_visitorlog_y2018m12_user_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_visitorlog_y2018m12_user_id_idx ON public.report_engine_visitorlog_y2018m12 USING btree (user_id);


--
-- Name: report_engine_visitorlog_y2018m12_visitor_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_visitorlog_y2018m12_visitor_id_idx ON public.report_engine_visitorlog_y2018m12 USING btree (visitor_id);


--
-- Name: report_engine_visitorlog_y2019m01_user_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_visitorlog_y2019m01_user_id_idx ON public.report_engine_visitorlog_y2019m01 USING btree (user_id);


--
-- Name: report_engine_visitorlog_y2019m01_visitor_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_visitorlog_y2019m01_visitor_id_idx ON public.report_engine_visitorlog_y2019m01 USING btree (visitor_id);


--
-- Name: report_engine_visitorlog_y2019m02_user_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_visitorlog_y2019m02_user_id_idx ON public.report_engine_visitorlog_y2019m02 USING btree (user_id);


--
-- Name: report_engine_visitorlog_y2019m02_visitor_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_visitorlog_y2019m02_visitor_id_idx ON public.report_engine_visitorlog_y2019m02 USING btree (visitor_id);


--
-- Name: report_engine_visitorlog_y2019m03_user_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_visitorlog_y2019m03_user_id_idx ON public.report_engine_visitorlog_y2019m03 USING btree (user_id);


--
-- Name: report_engine_visitorlog_y2019m03_visitor_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_visitorlog_y2019m03_visitor_id_idx ON public.report_engine_visitorlog_y2019m03 USING btree (visitor_id);


--
-- Name: report_engine_visitorlog_y2019m04_user_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_visitorlog_y2019m04_user_id_idx ON public.report_engine_visitorlog_y2019m04 USING btree (user_id);


--
-- Name: report_engine_visitorlog_y2019m04_visitor_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_visitorlog_y2019m04_visitor_id_idx ON public.report_engine_visitorlog_y2019m04 USING btree (visitor_id);


--
-- Name: report_engine_visitorlog_y2019m05_user_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_visitorlog_y2019m05_user_id_idx ON public.report_engine_visitorlog_y2019m05 USING btree (user_id);


--
-- Name: report_engine_visitorlog_y2019m05_visitor_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_visitorlog_y2019m05_visitor_id_idx ON public.report_engine_visitorlog_y2019m05 USING btree (visitor_id);


--
-- Name: report_engine_visitorlog_y2019m06_user_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_visitorlog_y2019m06_user_id_idx ON public.report_engine_visitorlog_y2019m06 USING btree (user_id);


--
-- Name: report_engine_visitorlog_y2019m06_visitor_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_visitorlog_y2019m06_visitor_id_idx ON public.report_engine_visitorlog_y2019m06 USING btree (visitor_id);


--
-- Name: report_engine_visitorlog_y2019m07_user_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_visitorlog_y2019m07_user_id_idx ON public.report_engine_visitorlog_y2019m07 USING btree (user_id);


--
-- Name: report_engine_visitorlog_y2019m07_visitor_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_visitorlog_y2019m07_visitor_id_idx ON public.report_engine_visitorlog_y2019m07 USING btree (visitor_id);


--
-- Name: report_engine_visitorlog_y2019m08_user_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_visitorlog_y2019m08_user_id_idx ON public.report_engine_visitorlog_y2019m08 USING btree (user_id);


--
-- Name: report_engine_visitorlog_y2019m08_visitor_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_visitorlog_y2019m08_visitor_id_idx ON public.report_engine_visitorlog_y2019m08 USING btree (visitor_id);


--
-- Name: report_engine_visitorlog_y2019m09_user_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_visitorlog_y2019m09_user_id_idx ON public.report_engine_visitorlog_y2019m09 USING btree (user_id);


--
-- Name: report_engine_visitorlog_y2019m09_visitor_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_visitorlog_y2019m09_visitor_id_idx ON public.report_engine_visitorlog_y2019m09 USING btree (visitor_id);


--
-- Name: report_engine_visitorlog_y2019m10_user_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_visitorlog_y2019m10_user_id_idx ON public.report_engine_visitorlog_y2019m10 USING btree (user_id);


--
-- Name: report_engine_visitorlog_y2019m10_visitor_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_visitorlog_y2019m10_visitor_id_idx ON public.report_engine_visitorlog_y2019m10 USING btree (visitor_id);


--
-- Name: report_engine_visitorlog_y2019m11_user_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_visitorlog_y2019m11_user_id_idx ON public.report_engine_visitorlog_y2019m11 USING btree (user_id);


--
-- Name: report_engine_visitorlog_y2019m11_visitor_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_visitorlog_y2019m11_visitor_id_idx ON public.report_engine_visitorlog_y2019m11 USING btree (visitor_id);


--
-- Name: report_engine_visitorlog_y2019m12_user_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_visitorlog_y2019m12_user_id_idx ON public.report_engine_visitorlog_y2019m12 USING btree (user_id);


--
-- Name: report_engine_visitorlog_y2019m12_visitor_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_visitorlog_y2019m12_visitor_id_idx ON public.report_engine_visitorlog_y2019m12 USING btree (visitor_id);


--
-- Name: report_engine_visitorlog_y2020m01_user_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_visitorlog_y2020m01_user_id_idx ON public.report_engine_visitorlog_y2020m01 USING btree (user_id);


--
-- Name: report_engine_visitorlog_y2020m01_visitor_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_visitorlog_y2020m01_visitor_id_idx ON public.report_engine_visitorlog_y2020m01 USING btree (visitor_id);


--
-- Name: report_engine_visitorlog_y2020m02_user_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_visitorlog_y2020m02_user_id_idx ON public.report_engine_visitorlog_y2020m02 USING btree (user_id);


--
-- Name: report_engine_visitorlog_y2020m02_visitor_id_idx; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX report_engine_visitorlog_y2020m02_visitor_id_idx ON public.report_engine_visitorlog_y2020m02 USING btree (visitor_id);


--
-- Name: residents_website_invitation_code_32ecf8ef7c703111_like; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX residents_website_invitation_code_32ecf8ef7c703111_like ON public.residents_website_invitation USING btree (code varchar_pattern_ops);


--
-- Name: residents_website_notification_95a915ae; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX residents_website_notification_95a915ae ON public.residents_website_notification USING btree (resident_id);


--
-- Name: residents_website_profile_bb930b80; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX residents_website_profile_bb930b80 ON public.residents_website_profile USING btree (invitation_template_id);


--
-- Name: rules_rule_961f60d2; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX rules_rule_961f60d2 ON public.rules_rule USING btree (ctype_id);


--
-- Name: rules_rule_code_e7fb074c3b6b927_like; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX rules_rule_code_e7fb074c3b6b927_like ON public.rules_rule USING btree (code varchar_pattern_ops);


--
-- Name: task_checklist_57746cc8; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX task_checklist_57746cc8 ON public.task_checklist USING btree (task_id);


--
-- Name: task_comment_3700153c; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX task_comment_3700153c ON public.task_comment USING btree (creator_id);


--
-- Name: task_comment_57746cc8; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX task_comment_57746cc8 ON public.task_comment USING btree (task_id);


--
-- Name: task_comment_656442a0; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX task_comment_656442a0 ON public.task_comment USING btree (tree_id);


--
-- Name: task_comment_6be37982; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX task_comment_6be37982 ON public.task_comment USING btree (parent_id);


--
-- Name: task_task_0e939a4f; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX task_task_0e939a4f ON public.task_task USING btree (group_id);


--
-- Name: task_task_3700153c; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX task_task_3700153c ON public.task_task USING btree (creator_id);


--
-- Name: task_task_b583a629; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX task_task_b583a629 ON public.task_task USING btree (category_id);


--
-- Name: task_task_dc91ed4b; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX task_task_dc91ed4b ON public.task_task USING btree (status_id);


--
-- Name: task_task_labels_57746cc8; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX task_task_labels_57746cc8 ON public.task_task_labels USING btree (task_id);


--
-- Name: task_task_labels_abec2aca; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX task_task_labels_abec2aca ON public.task_task_labels USING btree (label_id);


--
-- Name: task_task_members_57746cc8; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX task_task_members_57746cc8 ON public.task_task_members USING btree (task_id);


--
-- Name: task_task_members_e8701ad4; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX task_task_members_e8701ad4 ON public.task_task_members USING btree (user_id);


--
-- Name: task_taskcategory_656442a0; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX task_taskcategory_656442a0 ON public.task_taskcategory USING btree (tree_id);


--
-- Name: task_taskcategory_6be37982; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX task_taskcategory_6be37982 ON public.task_taskcategory USING btree (parent_id);


--
-- Name: task_vote_5e7b1936; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX task_vote_5e7b1936 ON public.task_vote USING btree (owner_id);


--
-- Name: task_vote_69b97d17; Type: INDEX; Schema: public; Owner: pgisn
--

CREATE INDEX task_vote_69b97d17 ON public.task_vote USING btree (comment_id);


--
-- Name: core_crudlog after_insert_core_crudlog_trigger; Type: TRIGGER; Schema: public; Owner: pgisn
--

CREATE TRIGGER after_insert_core_crudlog_trigger AFTER INSERT ON public.core_crudlog FOR EACH ROW EXECUTE PROCEDURE public.core_crudlog_delete_master();


--
-- Name: report_engine_accesscodelog after_insert_report_engine_accesscodelog_trigger; Type: TRIGGER; Schema: public; Owner: pgisn
--

CREATE TRIGGER after_insert_report_engine_accesscodelog_trigger AFTER INSERT ON public.report_engine_accesscodelog FOR EACH ROW EXECUTE PROCEDURE public.report_engine_accesscodelog_delete_master();


--
-- Name: report_engine_visitorlog after_insert_report_engine_visitorlog_trigger; Type: TRIGGER; Schema: public; Owner: pgisn
--

CREATE TRIGGER after_insert_report_engine_visitorlog_trigger AFTER INSERT ON public.report_engine_visitorlog FOR EACH ROW EXECUTE PROCEDURE public.report_engine_visitorlog_delete_master();


--
-- Name: core_crudlog before_insert_core_crudlog_trigger; Type: TRIGGER; Schema: public; Owner: pgisn
--

CREATE TRIGGER before_insert_core_crudlog_trigger BEFORE INSERT ON public.core_crudlog FOR EACH ROW EXECUTE PROCEDURE public.core_crudlog_insert_child();


--
-- Name: report_engine_accesscodelog before_insert_report_engine_accesscodelog_trigger; Type: TRIGGER; Schema: public; Owner: pgisn
--

CREATE TRIGGER before_insert_report_engine_accesscodelog_trigger BEFORE INSERT ON public.report_engine_accesscodelog FOR EACH ROW EXECUTE PROCEDURE public.report_engine_accesscodelog_insert_child();


--
-- Name: report_engine_visitorlog before_insert_report_engine_visitorlog_trigger; Type: TRIGGER; Schema: public; Owner: pgisn
--

CREATE TRIGGER before_insert_report_engine_visitorlog_trigger BEFORE INSERT ON public.report_engine_visitorlog FOR EACH ROW EXECUTE PROCEDURE public.report_engine_visitorlog_insert_child();


--
-- Name: access_control_acpermission_devices D1ea1703a28b4d80147512b6a9e1815f; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.access_control_acpermission_devices
    ADD CONSTRAINT "D1ea1703a28b4d80147512b6a9e1815f" FOREIGN KEY (acpermission_id) REFERENCES public.access_control_acpermission(entity_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: incident_report_incident D59972efca74699181b0fe87dc3b2673; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.incident_report_incident
    ADD CONSTRAINT "D59972efca74699181b0fe87dc3b2673" FOREIGN KEY (status_id) REFERENCES public.incident_report_incidentstatus(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: access_control_sticker a2dda721d435ee29f207a359509cae7f; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.access_control_sticker
    ADD CONSTRAINT a2dda721d435ee29f207a359509cae7f FOREIGN KEY (facility_code_id) REFERENCES public.access_control_facilitycode(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: access_control_acpermission_devices a960842d17c175b1ad99be57c0ca2dba; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.access_control_acpermission_devices
    ADD CONSTRAINT a960842d17c175b1ad99be57c0ca2dba FOREIGN KEY (device_id) REFERENCES public.access_control_device(entity_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: access_control_acpermission ac_schedule_id_33779dc8ee87f9e4_fk_access_control_acschedule_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.access_control_acpermission
    ADD CONSTRAINT ac_schedule_id_33779dc8ee87f9e4_fk_access_control_acschedule_id FOREIGN KEY (schedule_id) REFERENCES public.access_control_acschedule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: access_control_accesscode acce_content_type_id_44ad550228a8b6f5_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.access_control_accesscode
    ADD CONSTRAINT acce_content_type_id_44ad550228a8b6f5_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: access_control_acpermission_groups access_acgroup_id_1c4e690320cbd491_fk_access_control_acgroup_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.access_control_acpermission_groups
    ADD CONSTRAINT access_acgroup_id_1c4e690320cbd491_fk_access_control_acgroup_id FOREIGN KEY (acgroup_id) REFERENCES public.access_control_acgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: access_control_accesscode_groups access_acgroup_id_7c727f66820b2b17_fk_access_control_acgroup_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.access_control_accesscode_groups
    ADD CONSTRAINT access_acgroup_id_7c727f66820b2b17_fk_access_control_acgroup_id FOREIGN KEY (acgroup_id) REFERENCES public.access_control_acgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: access_control_device access_control__entity_ptr_id_73b2d374ffdc1b9a_fk_dbm_entity_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.access_control_device
    ADD CONSTRAINT access_control__entity_ptr_id_73b2d374ffdc1b9a_fk_dbm_entity_id FOREIGN KEY (entity_ptr_id) REFERENCES public.dbm_entity(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: access_control_acpermission access_control_a_entity_ptr_id_31a6e867e74cead_fk_dbm_entity_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.access_control_acpermission
    ADD CONSTRAINT access_control_a_entity_ptr_id_31a6e867e74cead_fk_dbm_entity_id FOREIGN KEY (entity_ptr_id) REFERENCES public.dbm_entity(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: access_control_accesscode_groups accesscode_id_15c2f00d04ef0444_fk_access_control_accesscode_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.access_control_accesscode_groups
    ADD CONSTRAINT accesscode_id_15c2f00d04ef0444_fk_access_control_accesscode_id FOREIGN KEY (accesscode_id) REFERENCES public.access_control_accesscode(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_content_type_id_508cf46651277a81_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_content_type_id_508cf46651277a81_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_group_id_689710a9a73b7457_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_group_id_689710a9a73b7457_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permission_id_1f49ccbbdc69d2fc_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permission_id_1f49ccbbdc69d2fc_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user__permission_id_384b62483d7071f0_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user__permission_id_384b62483d7071f0_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_33ac548dcf5f8e37_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_33ac548dcf5f8e37_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_4b5ed4ffdb8fd9b0_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_4b5ed4ffdb8fd9b0_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permiss_user_id_7f0938558328534a_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permiss_user_id_7f0938558328534a_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: authtoken_token authtoken_token_user_id_1d10c57f535fb363_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_1d10c57f535fb363_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: residents_website_profile cf6c1f3103d8f1561d56986bcb317355; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.residents_website_profile
    ADD CONSTRAINT cf6c1f3103d8f1561d56986bcb317355 FOREIGN KEY (invitation_template_id) REFERENCES public.residents_website_invitationtexttemplate(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_apirequestlog core_apirequestlog_user_id_41047288328964a_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_apirequestlog
    ADD CONSTRAINT core_apirequestlog_user_id_41047288328964a_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_apirequestlog core_content_type_id_38fa3569ad191e6d_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_apirequestlog
    ADD CONSTRAINT core_content_type_id_38fa3569ad191e6d_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_loggedusers core_loggedusers_user_id_15f0be73604cbced_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_loggedusers
    ADD CONSTRAINT core_loggedusers_user_id_15f0be73604cbced_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_ssotoken core_ssotok_consumer_id_50f0444d11b6aaf_fk_core_singlesignon_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_ssotoken
    ADD CONSTRAINT core_ssotok_consumer_id_50f0444d11b6aaf_fk_core_singlesignon_id FOREIGN KEY (consumer_id) REFERENCES public.core_singlesignon(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_ssotoken core_ssotoken_user_id_4dff215352f02b6b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_ssotoken
    ADD CONSTRAINT core_ssotoken_user_id_4dff215352f02b6b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_suitepreference core_suitepreferen_module_id_5d493f352058a137_fk_core_module_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_suitepreference
    ADD CONSTRAINT core_suitepreferen_module_id_5d493f352058a137_fk_core_module_id FOREIGN KEY (module_id) REFERENCES public.core_module(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_userprofile core_userprofile_user_id_5b1cb1c9cb51df05_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.core_userprofile
    ADD CONSTRAINT core_userprofile_user_id_5b1cb1c9cb51df05_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: access_control_acpermission_groups d0c4e4c9fac03c07913ec15fd1d39ff3; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.access_control_acpermission_groups
    ADD CONSTRAINT d0c4e4c9fac03c07913ec15fd1d39ff3 FOREIGN KEY (acpermission_id) REFERENCES public.access_control_acpermission(entity_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: incident_report_incident d2332f881a2365e8973b9811da810faa; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.incident_report_incident
    ADD CONSTRAINT d2332f881a2365e8973b9811da810faa FOREIGN KEY (disposition_id) REFERENCES public.incident_report_icategory(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: data_migration_profile dat_dependency_id_480428a36fd56b63_fk_data_migration_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.data_migration_profile
    ADD CONSTRAINT dat_dependency_id_480428a36fd56b63_fk_data_migration_profile_id FOREIGN KEY (dependency_id) REFERENCES public.data_migration_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: data_migration_reference data_m_profile_id_1a3367dbde7d8034_fk_data_migration_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.data_migration_reference
    ADD CONSTRAINT data_m_profile_id_1a3367dbde7d8034_fk_data_migration_profile_id FOREIGN KEY (profile_id) REFERENCES public.data_migration_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: data_migration_datafiles data_migration_datafil_user_id_6d09a6b3e3cd8160_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.data_migration_datafiles
    ADD CONSTRAINT data_migration_datafil_user_id_6d09a6b3e3cd8160_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: access_control_accesscode db984f29b775190b66cbf22bbf1be2c2; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.access_control_accesscode
    ADD CONSTRAINT db984f29b775190b66cbf22bbf1be2c2 FOREIGN KEY (facility_code_id) REFERENCES public.access_control_facilitycode(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_photo dbm__content_type_id_21c5feafdd834ce7_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_photo
    ADD CONSTRAINT dbm__content_type_id_21c5feafdd834ce7_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_event dbm__content_type_id_33c973a8ff418433_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_event
    ADD CONSTRAINT dbm__content_type_id_33c973a8ff418433_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_address dbm_address_city_id_6ef86ee03fcc68f6_fk_dbm_city_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_address
    ADD CONSTRAINT dbm_address_city_id_6ef86ee03fcc68f6_fk_dbm_city_id FOREIGN KEY (city_id) REFERENCES public.dbm_city(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_car dbm_car_mainColor_id_75cbbd24d912b380_fk_dbm_color_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_car
    ADD CONSTRAINT "dbm_car_mainColor_id_75cbbd24d912b380_fk_dbm_color_id" FOREIGN KEY ("mainColor_id") REFERENCES public.dbm_color(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_car dbm_car_model_id_4077788c031595f7_fk_dbm_carmodel_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_car
    ADD CONSTRAINT dbm_car_model_id_4077788c031595f7_fk_dbm_carmodel_id FOREIGN KEY (model_id) REFERENCES public.dbm_carmodel(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_car dbm_car_owner_id_6d0160e5c2c92c7f_fk_dbm_person_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_car
    ADD CONSTRAINT dbm_car_owner_id_6d0160e5c2c92c7f_fk_dbm_person_id FOREIGN KEY (owner_id) REFERENCES public.dbm_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_car dbm_car_secColor_id_3accace720134cd9_fk_dbm_color_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_car
    ADD CONSTRAINT "dbm_car_secColor_id_3accace720134cd9_fk_dbm_color_id" FOREIGN KEY ("secColor_id") REFERENCES public.dbm_color(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_car dbm_car_state_id_70a4bb8e83991abf_fk_dbm_state_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_car
    ADD CONSTRAINT dbm_car_state_id_70a4bb8e83991abf_fk_dbm_state_id FOREIGN KEY (state_id) REFERENCES public.dbm_state(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_carmodel dbm_carmodel_make_id_682431c1b5d4a0f5_fk_dbm_make_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_carmodel
    ADD CONSTRAINT dbm_carmodel_make_id_682431c1b5d4a0f5_fk_dbm_make_id FOREIGN KEY (make_id) REFERENCES public.dbm_make(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_category dbm_category_parent_id_359a4cb8c99d04ce_fk_dbm_category_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_category
    ADD CONSTRAINT dbm_category_parent_id_359a4cb8c99d04ce_fk_dbm_category_id FOREIGN KEY (parent_id) REFERENCES public.dbm_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_city dbm_city_county_id_29c12a4f28fa6ee1_fk_dbm_county_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_city
    ADD CONSTRAINT dbm_city_county_id_29c12a4f28fa6ee1_fk_dbm_county_id FOREIGN KEY (county_id) REFERENCES public.dbm_county(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_city dbm_city_state_id_618ce93bd34c3755_fk_dbm_state_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_city
    ADD CONSTRAINT dbm_city_state_id_618ce93bd34c3755_fk_dbm_state_id FOREIGN KEY (state_id) REFERENCES public.dbm_state(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_community dbm_community_entity_id_8b1a0b8a_fk_dbm_entity_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_community
    ADD CONSTRAINT dbm_community_entity_id_8b1a0b8a_fk_dbm_entity_id FOREIGN KEY (entity_id) REFERENCES public.dbm_entity(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_contact dbm_contact_address_id_178b3fdd62eb3e70_fk_dbm_address_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_contact
    ADD CONSTRAINT dbm_contact_address_id_178b3fdd62eb3e70_fk_dbm_address_id FOREIGN KEY (address_id) REFERENCES public.dbm_address(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_contact dbm_contact_company_id_9119b6052d395f9_fk_dbm_company_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_contact
    ADD CONSTRAINT dbm_contact_company_id_9119b6052d395f9_fk_dbm_company_id FOREIGN KEY (company_id) REFERENCES public.dbm_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_contact_persons dbm_contact_perso_contact_id_60bb5500ad28b5c9_fk_dbm_contact_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_contact_persons
    ADD CONSTRAINT dbm_contact_perso_contact_id_60bb5500ad28b5c9_fk_dbm_contact_id FOREIGN KEY (contact_id) REFERENCES public.dbm_contact(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_contact_persons dbm_contact_persons_person_id_40aa1fa90ad734ad_fk_dbm_person_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_contact_persons
    ADD CONSTRAINT dbm_contact_persons_person_id_40aa1fa90ad734ad_fk_dbm_person_id FOREIGN KEY (person_id) REFERENCES public.dbm_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_contact dbm_contact_unit_id_db6a72b32705bf9_fk_dbm_unit_entity_ptr_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_contact
    ADD CONSTRAINT dbm_contact_unit_id_db6a72b32705bf9_fk_dbm_unit_entity_ptr_id FOREIGN KEY (unit_id) REFERENCES public.dbm_unit(entity_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_contract dbm_contract_responsible_id_4085b0260556d127_fk_dbm_person_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_contract
    ADD CONSTRAINT dbm_contract_responsible_id_4085b0260556d127_fk_dbm_person_id FOREIGN KEY (responsible_id) REFERENCES public.dbm_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_county dbm_county_state_id_7561e975c26fdd0a_fk_dbm_state_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_county
    ADD CONSTRAINT dbm_county_state_id_7561e975c26fdd0a_fk_dbm_state_id FOREIGN KEY (state_id) REFERENCES public.dbm_state(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_decal dbm_decal_vehicle_id_1c3d0b5319cd32b9_fk_dbm_car_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_decal
    ADD CONSTRAINT dbm_decal_vehicle_id_1c3d0b5319cd32b9_fk_dbm_car_id FOREIGN KEY (vehicle_id) REFERENCES public.dbm_car(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_direction dbm_directio_unit_id_2fe69b91db6fcce9_fk_dbm_unit_entity_ptr_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_direction
    ADD CONSTRAINT dbm_directio_unit_id_2fe69b91db6fcce9_fk_dbm_unit_entity_ptr_id FOREIGN KEY (unit_id) REFERENCES public.dbm_unit(entity_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_drive_cars dbm_drive_cars_car_id_4c40d53fc234aa7b_fk_dbm_car_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_drive_cars
    ADD CONSTRAINT dbm_drive_cars_car_id_4c40d53fc234aa7b_fk_dbm_car_id FOREIGN KEY (car_id) REFERENCES public.dbm_car(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_drive_cars dbm_drive_cars_drive_id_2b8913ae52022cc7_fk_dbm_drive_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_drive_cars
    ADD CONSTRAINT dbm_drive_cars_drive_id_2b8913ae52022cc7_fk_dbm_drive_id FOREIGN KEY (drive_id) REFERENCES public.dbm_drive(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_drive dbm_drive_person_id_531041e4bb38ac5c_fk_dbm_person_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_drive
    ADD CONSTRAINT dbm_drive_person_id_531041e4bb38ac5c_fk_dbm_person_id FOREIGN KEY (person_id) REFERENCES public.dbm_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_email dbm_email_category_id_221f50e51e742169_fk_dbm_category_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_email
    ADD CONSTRAINT dbm_email_category_id_221f50e51e742169_fk_dbm_category_id FOREIGN KEY (category_id) REFERENCES public.dbm_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_email dbm_email_contact_id_55a4caa4c5cac3be_fk_dbm_contact_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_email
    ADD CONSTRAINT dbm_email_contact_id_55a4caa4c5cac3be_fk_dbm_contact_id FOREIGN KEY (contact_id) REFERENCES public.dbm_contact(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_employee dbm_employee_company_id_29e14a0c73aa44ae_fk_dbm_company_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_employee
    ADD CONSTRAINT dbm_employee_company_id_29e14a0c73aa44ae_fk_dbm_company_id FOREIGN KEY (company_id) REFERENCES public.dbm_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_employee dbm_employee_person_ptr_id_165285183589474e_fk_dbm_person_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_employee
    ADD CONSTRAINT dbm_employee_person_ptr_id_165285183589474e_fk_dbm_person_id FOREIGN KEY (person_ptr_id) REFERENCES public.dbm_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_employee dbm_employee_unit_id_2317ce177840d52_fk_dbm_unit_entity_ptr_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_employee
    ADD CONSTRAINT dbm_employee_unit_id_2317ce177840d52_fk_dbm_unit_entity_ptr_id FOREIGN KEY (unit_id) REFERENCES public.dbm_unit(entity_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_event_guest_list dbm_event_g_guest_id_2e39fd9c972b223_fk_dbm_guest_person_ptr_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_event_guest_list
    ADD CONSTRAINT dbm_event_g_guest_id_2e39fd9c972b223_fk_dbm_guest_person_ptr_id FOREIGN KEY (guest_id) REFERENCES public.dbm_guest(person_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_event_guest_list dbm_event_guest_list_event_id_5c0bda4a88ad245b_fk_dbm_event_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_event_guest_list
    ADD CONSTRAINT dbm_event_guest_list_event_id_5c0bda4a88ad245b_fk_dbm_event_id FOREIGN KEY (event_id) REFERENCES public.dbm_event(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_gate dbm_gate_entity_id_ad6eff34_fk_dbm_entity_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_gate
    ADD CONSTRAINT dbm_gate_entity_id_ad6eff34_fk_dbm_entity_id FOREIGN KEY (entity_id) REFERENCES public.dbm_entity(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_guest dbm_gues_host_id_5c5e90155073be7f_fk_dbm_resident_person_ptr_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_guest
    ADD CONSTRAINT dbm_gues_host_id_5c5e90155073be7f_fk_dbm_resident_person_ptr_id FOREIGN KEY (host_id) REFERENCES public.dbm_resident(person_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_guest dbm_guest_company_id_6af2122e9b71a965_fk_dbm_company_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_guest
    ADD CONSTRAINT dbm_guest_company_id_6af2122e9b71a965_fk_dbm_company_id FOREIGN KEY (company_id) REFERENCES public.dbm_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_guest dbm_guest_person_ptr_id_1041a0457fd5e1bb_fk_dbm_person_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_guest
    ADD CONSTRAINT dbm_guest_person_ptr_id_1041a0457fd5e1bb_fk_dbm_person_id FOREIGN KEY (person_ptr_id) REFERENCES public.dbm_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_guest dbm_guest_unit_id_13732fe094803f65_fk_dbm_unit_entity_ptr_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_guest
    ADD CONSTRAINT dbm_guest_unit_id_13732fe094803f65_fk_dbm_unit_entity_ptr_id FOREIGN KEY (unit_id) REFERENCES public.dbm_unit(entity_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_lease dbm_lease_unit_id_6c91356c11758b8f_fk_dbm_unit_entity_ptr_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_lease
    ADD CONSTRAINT dbm_lease_unit_id_6c91356c11758b8f_fk_dbm_unit_entity_ptr_id FOREIGN KEY (unit_id) REFERENCES public.dbm_unit(entity_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_owner dbm_owner_person_id_429f20ea0f22a597_fk_dbm_person_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_owner
    ADD CONSTRAINT dbm_owner_person_id_429f20ea0f22a597_fk_dbm_person_id FOREIGN KEY (person_id) REFERENCES public.dbm_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_owner_units dbm_owner_un_unit_id_7cfd3606674f619c_fk_dbm_unit_entity_ptr_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_owner_units
    ADD CONSTRAINT dbm_owner_un_unit_id_7cfd3606674f619c_fk_dbm_unit_entity_ptr_id FOREIGN KEY (unit_id) REFERENCES public.dbm_unit(entity_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_owner_units dbm_owner_units_owner_id_7f4eaf765dd5ff7a_fk_dbm_owner_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_owner_units
    ADD CONSTRAINT dbm_owner_units_owner_id_7f4eaf765dd5ff7a_fk_dbm_owner_id FOREIGN KEY (owner_id) REFERENCES public.dbm_owner(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_person dbm_person_category_id_59b27fa83ade02cb_fk_dbm_category_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_person
    ADD CONSTRAINT dbm_person_category_id_59b27fa83ade02cb_fk_dbm_category_id FOREIGN KEY (category_id) REFERENCES public.dbm_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_pet dbm_pet_owner_id_6007f370a02b6f2c_fk_dbm_resident_person_ptr_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_pet
    ADD CONSTRAINT dbm_pet_owner_id_6007f370a02b6f2c_fk_dbm_resident_person_ptr_id FOREIGN KEY (owner_id) REFERENCES public.dbm_resident(person_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_pet dbm_pet_pet_category_id_753dbbb748ba64a2_fk_dbm_category_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_pet
    ADD CONSTRAINT dbm_pet_pet_category_id_753dbbb748ba64a2_fk_dbm_category_id FOREIGN KEY (pet_category_id) REFERENCES public.dbm_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_phone dbm_phone_carrier_id_375791b06c58ac32_fk_dbm_phonecarrier_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_phone
    ADD CONSTRAINT dbm_phone_carrier_id_375791b06c58ac32_fk_dbm_phonecarrier_id FOREIGN KEY (carrier_id) REFERENCES public.dbm_phonecarrier(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_phone dbm_phone_category_id_529d300c0c8deb53_fk_dbm_category_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_phone
    ADD CONSTRAINT dbm_phone_category_id_529d300c0c8deb53_fk_dbm_category_id FOREIGN KEY (category_id) REFERENCES public.dbm_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_phone dbm_phone_contact_id_4bca50a1ba663532_fk_dbm_contact_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_phone
    ADD CONSTRAINT dbm_phone_contact_id_4bca50a1ba663532_fk_dbm_contact_id FOREIGN KEY (contact_id) REFERENCES public.dbm_contact(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_photo dbm_photo_category_id_3ef77c8dec4f258b_fk_dbm_category_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_photo
    ADD CONSTRAINT dbm_photo_category_id_3ef77c8dec4f258b_fk_dbm_category_id FOREIGN KEY (category_id) REFERENCES public.dbm_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_realstate dbm_realstat_unit_id_320f328fd9d73628_fk_dbm_unit_entity_ptr_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_realstate
    ADD CONSTRAINT dbm_realstat_unit_id_320f328fd9d73628_fk_dbm_unit_entity_ptr_id FOREIGN KEY (unit_id) REFERENCES public.dbm_unit(entity_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_realstate dbm_realstate_category_id_4f3476baa8db746a_fk_dbm_category_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_realstate
    ADD CONSTRAINT dbm_realstate_category_id_4f3476baa8db746a_fk_dbm_category_id FOREIGN KEY (category_id) REFERENCES public.dbm_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_resident dbm_res_residence_id_343ab50490e5c885_fk_dbm_unit_entity_ptr_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_resident
    ADD CONSTRAINT dbm_res_residence_id_343ab50490e5c885_fk_dbm_unit_entity_ptr_id FOREIGN KEY (residence_id) REFERENCES public.dbm_unit(entity_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_resident dbm_resident_lease_id_4488ac862b2e0372_fk_dbm_lease_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_resident
    ADD CONSTRAINT dbm_resident_lease_id_4488ac862b2e0372_fk_dbm_lease_id FOREIGN KEY (lease_id) REFERENCES public.dbm_lease(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_resident dbm_resident_person_ptr_id_389222a6077c50fa_fk_dbm_person_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_resident
    ADD CONSTRAINT dbm_resident_person_ptr_id_389222a6077c50fa_fk_dbm_person_id FOREIGN KEY (person_ptr_id) REFERENCES public.dbm_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_subcommunity dbm_subcommunity_entity_id_d67ef388_fk_dbm_entity_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_subcommunity
    ADD CONSTRAINT dbm_subcommunity_entity_id_d67ef388_fk_dbm_entity_id FOREIGN KEY (entity_id) REFERENCES public.dbm_entity(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_unit dbm_unit_category_id_1b3fad855d5a1652_fk_dbm_category_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_unit
    ADD CONSTRAINT dbm_unit_category_id_1b3fad855d5a1652_fk_dbm_category_id FOREIGN KEY (category_id) REFERENCES public.dbm_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dbm_unit dbm_unit_entity_ptr_id_69c869a9826952c6_fk_dbm_entity_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.dbm_unit
    ADD CONSTRAINT dbm_unit_entity_ptr_id_69c869a9826952c6_fk_dbm_entity_id FOREIGN KEY (entity_ptr_id) REFERENCES public.dbm_entity(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log djan_content_type_id_697914295151027a_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT djan_content_type_id_697914295151027a_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_52fdd58701c5f563_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_52fdd58701c5f563_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_celery_beat_periodictask django_celery_beat_p_clocked_id_47a69f82_fk_django_ce; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.django_celery_beat_periodictask
    ADD CONSTRAINT django_celery_beat_p_clocked_id_47a69f82_fk_django_ce FOREIGN KEY (clocked_id) REFERENCES public.django_celery_beat_clockedschedule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_celery_beat_periodictask django_celery_beat_p_crontab_id_d3cba168_fk_django_ce; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.django_celery_beat_periodictask
    ADD CONSTRAINT django_celery_beat_p_crontab_id_d3cba168_fk_django_ce FOREIGN KEY (crontab_id) REFERENCES public.django_celery_beat_crontabschedule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_celery_beat_periodictask django_celery_beat_p_interval_id_a8ca27da_fk_django_ce; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.django_celery_beat_periodictask
    ADD CONSTRAINT django_celery_beat_p_interval_id_a8ca27da_fk_django_ce FOREIGN KEY (interval_id) REFERENCES public.django_celery_beat_intervalschedule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_celery_beat_periodictask django_celery_beat_p_solar_id_a87ce72c_fk_django_ce; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.django_celery_beat_periodictask
    ADD CONSTRAINT django_celery_beat_p_solar_id_a87ce72c_fk_django_ce FOREIGN KEY (solar_id) REFERENCES public.django_celery_beat_solarschedule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_twilio_credential django_twilio_credenti_user_id_65c51300c22dafbf_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.django_twilio_credential
    ADD CONSTRAINT django_twilio_credenti_user_id_65c51300c22dafbf_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: incident_report_incident in_category_id_1ade557baf857ae2_fk_incident_report_icategory_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.incident_report_incident
    ADD CONSTRAINT in_category_id_1ade557baf857ae2_fk_incident_report_icategory_id FOREIGN KEY (category_id) REFERENCES public.incident_report_icategory(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: incident_report_iupdate inc_incident_id_1e972c00e25eb316_fk_incident_report_incident_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.incident_report_iupdate
    ADD CONSTRAINT inc_incident_id_1e972c00e25eb316_fk_incident_report_incident_id FOREIGN KEY (incident_id) REFERENCES public.incident_report_incident(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: incident_report_icar inc_incident_id_27e0afecdd421011_fk_incident_report_incident_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.incident_report_icar
    ADD CONSTRAINT inc_incident_id_27e0afecdd421011_fk_incident_report_incident_id FOREIGN KEY (incident_id) REFERENCES public.incident_report_incident(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: incident_report_iunit inc_incident_id_4f6d1297ac274533_fk_incident_report_incident_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.incident_report_iunit
    ADD CONSTRAINT inc_incident_id_4f6d1297ac274533_fk_incident_report_incident_id FOREIGN KEY (incident_id) REFERENCES public.incident_report_incident(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: incident_report_iperson inc_incident_id_613ebc40abea2985_fk_incident_report_incident_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.incident_report_iperson
    ADD CONSTRAINT inc_incident_id_613ebc40abea2985_fk_incident_report_incident_id FOREIGN KEY (incident_id) REFERENCES public.incident_report_incident(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: incident_report_media inc_incident_id_71a7d8e21da78e96_fk_incident_report_incident_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.incident_report_media
    ADD CONSTRAINT inc_incident_id_71a7d8e21da78e96_fk_incident_report_incident_id FOREIGN KEY (incident_id) REFERENCES public.incident_report_incident(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: incident_report_icategory inci_parent_id_2a6fdb37cb9214d0_fk_incident_report_icategory_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.incident_report_icategory
    ADD CONSTRAINT inci_parent_id_2a6fdb37cb9214d0_fk_incident_report_icategory_id FOREIGN KEY (parent_id) REFERENCES public.incident_report_icategory(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: incident_report_media incide_type_id_60407b380af9a7e0_fk_incident_report_icategory_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.incident_report_media
    ADD CONSTRAINT incide_type_id_60407b380af9a7e0_fk_incident_report_icategory_id FOREIGN KEY (type_id) REFERENCES public.incident_report_icategory(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: incident_report_incident incident_report_incid_owner_id_40a50f1750a15f45_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.incident_report_incident
    ADD CONSTRAINT incident_report_incid_owner_id_40a50f1750a15f45_fk_auth_user_id FOREIGN KEY (owner_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: incident_report_iupdate incident_report_iup_creator_id_6c370291523e45e9_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.incident_report_iupdate
    ADD CONSTRAINT incident_report_iup_creator_id_6c370291523e45e9_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: incident_report_incident incident_report_responsible_id_55976e5000d50577_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.incident_report_incident
    ADD CONSTRAINT incident_report_responsible_id_55976e5000d50577_fk_auth_user_id FOREIGN KEY (responsible_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: notification_message notification_mess_user_from_id_1cf4db962c3be526_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.notification_message
    ADD CONSTRAINT notification_mess_user_from_id_1cf4db962c3be526_fk_auth_user_id FOREIGN KEY (user_from_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: notification_message notification_messag_user_to_id_1864e1192e19053b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.notification_message
    ADD CONSTRAINT notification_messag_user_to_id_1864e1192e19053b_fk_auth_user_id FOREIGN KEY (user_to_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: report_engine_visitorlog report__visitor_id_384679ac6458e38a_fk_report_engine_visitor_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_visitorlog
    ADD CONSTRAINT report__visitor_id_384679ac6458e38a_fk_report_engine_visitor_id FOREIGN KEY (visitor_id) REFERENCES public.report_engine_visitor(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: report_engine_accesscodelog report_engine_accesscod_user_id_542b7ba2b08c4c8_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_accesscodelog
    ADD CONSTRAINT report_engine_accesscod_user_id_542b7ba2b08c4c8_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: report_engine_visitorlog report_engine_visitorl_user_id_1bf7bcfd4c3a49cf_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.report_engine_visitorlog
    ADD CONSTRAINT report_engine_visitorl_user_id_1bf7bcfd4c3a49cf_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: residents_website_notification resi_resident_id_6f960651dc294b9b_fk_dbm_resident_person_ptr_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.residents_website_notification
    ADD CONSTRAINT resi_resident_id_6f960651dc294b9b_fk_dbm_resident_person_ptr_id FOREIGN KEY (resident_id) REFERENCES public.dbm_resident(person_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: residents_website_profile residents_website__user_ptr_id_5fea52fa19f814fe_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.residents_website_profile
    ADD CONSTRAINT residents_website__user_ptr_id_5fea52fa19f814fe_fk_auth_user_id FOREIGN KEY (user_ptr_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: residents_website_notification residents_website_not_email_id_467f3a89b9e5c4bb_fk_dbm_email_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.residents_website_notification
    ADD CONSTRAINT residents_website_not_email_id_467f3a89b9e5c4bb_fk_dbm_email_id FOREIGN KEY (email_id) REFERENCES public.dbm_email(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: residents_website_notification residents_website_not_phone_id_500daa9a25c97312_fk_dbm_phone_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.residents_website_notification
    ADD CONSTRAINT residents_website_not_phone_id_500daa9a25c97312_fk_dbm_phone_id FOREIGN KEY (phone_id) REFERENCES public.dbm_phone(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: rules_rule rules_rule_ctype_id_28f540121a622dee_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.rules_rule
    ADD CONSTRAINT rules_rule_ctype_id_28f540121a622dee_fk_django_content_type_id FOREIGN KEY (ctype_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: task_attachment task_attachment_task_id_30933c3ec9d95e65_fk_task_task_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_attachment
    ADD CONSTRAINT task_attachment_task_id_30933c3ec9d95e65_fk_task_task_id FOREIGN KEY (task_id) REFERENCES public.task_task(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: task_checklist task_checklist_task_id_66f4fed6e6427889_fk_task_task_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_checklist
    ADD CONSTRAINT task_checklist_task_id_66f4fed6e6427889_fk_task_task_id FOREIGN KEY (task_id) REFERENCES public.task_task(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: task_comment task_comment_creator_id_548f33f9563a4f61_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_comment
    ADD CONSTRAINT task_comment_creator_id_548f33f9563a4f61_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: task_comment task_comment_parent_id_581ca3d4805d479c_fk_task_comment_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_comment
    ADD CONSTRAINT task_comment_parent_id_581ca3d4805d479c_fk_task_comment_id FOREIGN KEY (parent_id) REFERENCES public.task_comment(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: task_comment task_comment_task_id_6af2e0e211308b15_fk_task_task_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_comment
    ADD CONSTRAINT task_comment_task_id_6af2e0e211308b15_fk_task_task_id FOREIGN KEY (task_id) REFERENCES public.task_task(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: task_task task_task_category_id_436951b117b51a5_fk_task_taskcategory_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_task
    ADD CONSTRAINT task_task_category_id_436951b117b51a5_fk_task_taskcategory_id FOREIGN KEY (category_id) REFERENCES public.task_taskcategory(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: task_task task_task_creator_id_5a3110316d980cba_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_task
    ADD CONSTRAINT task_task_creator_id_5a3110316d980cba_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: task_task task_task_group_id_284361eb6bf17a71_fk_task_taskgroup_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_task
    ADD CONSTRAINT task_task_group_id_284361eb6bf17a71_fk_task_taskgroup_id FOREIGN KEY (group_id) REFERENCES public.task_taskgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: task_task_labels task_task_labels_label_id_55be2cae4992e67c_fk_task_label_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_task_labels
    ADD CONSTRAINT task_task_labels_label_id_55be2cae4992e67c_fk_task_label_id FOREIGN KEY (label_id) REFERENCES public.task_label(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: task_task_labels task_task_labels_task_id_36b0f49b0f257d3f_fk_task_task_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_task_labels
    ADD CONSTRAINT task_task_labels_task_id_36b0f49b0f257d3f_fk_task_task_id FOREIGN KEY (task_id) REFERENCES public.task_task(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: task_task_members task_task_members_task_id_4b8550269ccb18b9_fk_task_task_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_task_members
    ADD CONSTRAINT task_task_members_task_id_4b8550269ccb18b9_fk_task_task_id FOREIGN KEY (task_id) REFERENCES public.task_task(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: task_task_members task_task_members_user_id_1e86f8d6211077e5_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_task_members
    ADD CONSTRAINT task_task_members_user_id_1e86f8d6211077e5_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: task_task task_task_status_id_7972f2d93d010218_fk_task_status_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_task
    ADD CONSTRAINT task_task_status_id_7972f2d93d010218_fk_task_status_id FOREIGN KEY (status_id) REFERENCES public.task_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: task_taskcategory task_taskcat_parent_id_1ab62a61a695b15a_fk_task_taskcategory_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_taskcategory
    ADD CONSTRAINT task_taskcat_parent_id_1ab62a61a695b15a_fk_task_taskcategory_id FOREIGN KEY (parent_id) REFERENCES public.task_taskcategory(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: task_taskschedule task_taskschedule_task_id_2db0112bec914885_fk_task_task_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_taskschedule
    ADD CONSTRAINT task_taskschedule_task_id_2db0112bec914885_fk_task_task_id FOREIGN KEY (task_id) REFERENCES public.task_task(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: task_vote task_vote_comment_id_1fa5ce5569ddd989_fk_task_comment_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_vote
    ADD CONSTRAINT task_vote_comment_id_1fa5ce5569ddd989_fk_task_comment_id FOREIGN KEY (comment_id) REFERENCES public.task_comment(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: task_vote task_vote_owner_id_75c2ef10f86e8b23_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pgisn
--

ALTER TABLE ONLY public.task_vote
    ADD CONSTRAINT task_vote_owner_id_75c2ef10f86e8b23_fk_auth_user_id FOREIGN KEY (owner_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--
