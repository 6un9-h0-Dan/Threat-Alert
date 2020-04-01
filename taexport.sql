--
-- PostgreSQL database dump
--

-- Dumped from database version 10.6 (Ubuntu 10.6-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.6 (Ubuntu 10.6-0ubuntu0.18.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: user_password_change_insert(); Type: FUNCTION; Schema: public; Owner: threatalertuser
--

CREATE FUNCTION public.user_password_change_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
IF
	TG_OP = 'UPDATE' 
	AND OLD."password" <> NEW."password" THEN
	INSERT INTO user_passwordhistory ( user_id, "password" )
VALUES
	( OLD.ID, OLD."password" );
ELSIF ( TG_OP = 'INSERT' ) THEN
INSERT INTO user_passwordhistory ( user_id, "password" )
VALUES
	( NEW.ID, NEW."password" );
END IF;
RETURN NEW;

END;

$$;


ALTER FUNCTION public.user_password_change_insert() OWNER TO threatalertuser;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: account; Type: TABLE; Schema: public; Owner: threatalertuser
--

CREATE TABLE public.account (
    id integer NOT NULL,
    active boolean,
    third_party boolean,
    name character varying(32),
    notes character varying(256),
    account_type_id integer DEFAULT 1 NOT NULL,
    identifier character varying(256),
    email_address character varying(512)
);


ALTER TABLE public.account OWNER TO threatalertuser;

--
-- Name: account_id_seq; Type: SEQUENCE; Schema: public; Owner: threatalertuser
--

CREATE SEQUENCE public.account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_id_seq OWNER TO threatalertuser;

--
-- Name: account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: threatalertuser
--

ALTER SEQUENCE public.account_id_seq OWNED BY public.account.id;


--
-- Name: account_type; Type: TABLE; Schema: public; Owner: threatalertuser
--

CREATE TABLE public.account_type (
    id integer NOT NULL,
    name character varying(80)
);


ALTER TABLE public.account_type OWNER TO threatalertuser;

--
-- Name: account_type_id_seq; Type: SEQUENCE; Schema: public; Owner: threatalertuser
--

CREATE SEQUENCE public.account_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_type_id_seq OWNER TO threatalertuser;

--
-- Name: account_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: threatalertuser
--

ALTER SEQUENCE public.account_type_id_seq OWNED BY public.account_type.id;


--
-- Name: account_type_values; Type: TABLE; Schema: public; Owner: threatalertuser
--

CREATE TABLE public.account_type_values (
    id integer NOT NULL,
    name character varying(64),
    value character varying(256),
    account_id integer NOT NULL
);


ALTER TABLE public.account_type_values OWNER TO threatalertuser;

--
-- Name: account_type_values_id_seq; Type: SEQUENCE; Schema: public; Owner: threatalertuser
--

CREATE SEQUENCE public.account_type_values_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_type_values_id_seq OWNER TO threatalertuser;

--
-- Name: account_type_values_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: threatalertuser
--

ALTER SEQUENCE public.account_type_values_id_seq OWNED BY public.account_type_values.id;


--
-- Name: accountpatternauditscore; Type: TABLE; Schema: public; Owner: threatalertuser
--

CREATE TABLE public.accountpatternauditscore (
    id integer NOT NULL,
    account_type character varying(80) NOT NULL,
    account_field character varying(128) NOT NULL,
    account_pattern character varying(128) NOT NULL,
    score integer NOT NULL,
    itemauditscores_id integer NOT NULL
);


ALTER TABLE public.accountpatternauditscore OWNER TO threatalertuser;

--
-- Name: accountpatternauditscore_id_seq; Type: SEQUENCE; Schema: public; Owner: threatalertuser
--

CREATE SEQUENCE public.accountpatternauditscore_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accountpatternauditscore_id_seq OWNER TO threatalertuser;

--
-- Name: accountpatternauditscore_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: threatalertuser
--

ALTER SEQUENCE public.accountpatternauditscore_id_seq OWNED BY public.accountpatternauditscore.id;


--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: threatalertuser
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO threatalertuser;

--
-- Name: anchore_config; Type: TABLE; Schema: public; Owner: threatalertuser
--

CREATE TABLE public.anchore_config (
    id integer NOT NULL,
    name character varying(64) NOT NULL,
    username character varying(64),
    password character varying(64),
    url character varying(1024),
    ssl_verify boolean
);


ALTER TABLE public.anchore_config OWNER TO threatalertuser;

--
-- Name: anchore_config_id_seq; Type: SEQUENCE; Schema: public; Owner: threatalertuser
--

CREATE SEQUENCE public.anchore_config_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.anchore_config_id_seq OWNER TO threatalertuser;

--
-- Name: anchore_config_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: threatalertuser
--

ALTER SEQUENCE public.anchore_config_id_seq OWNED BY public.anchore_config.id;


--
-- Name: association; Type: TABLE; Schema: public; Owner: threatalertuser
--

CREATE TABLE public.association (
    user_id integer,
    account_id integer
);


ALTER TABLE public.association OWNER TO threatalertuser;

--
-- Name: auditorsettings; Type: TABLE; Schema: public; Owner: threatalertuser
--

CREATE TABLE public.auditorsettings (
    id integer NOT NULL,
    tech_id integer,
    account_id integer,
    disabled boolean NOT NULL,
    issue_text character varying(512),
    auditor_class character varying(128)
);


ALTER TABLE public.auditorsettings OWNER TO threatalertuser;

--
-- Name: auditorsettings_id_seq; Type: SEQUENCE; Schema: public; Owner: threatalertuser
--

CREATE SEQUENCE public.auditorsettings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auditorsettings_id_seq OWNER TO threatalertuser;

--
-- Name: auditorsettings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: threatalertuser
--

ALTER SEQUENCE public.auditorsettings_id_seq OWNED BY public.auditorsettings.id;


--
-- Name: cloudtrail; Type: TABLE; Schema: public; Owner: threatalertuser
--

CREATE TABLE public.cloudtrail (
    id integer NOT NULL,
    event_id character varying(36),
    request_id character varying(36),
    event_source character varying(64) NOT NULL,
    event_name character varying(64) NOT NULL,
    event_time timestamp without time zone NOT NULL,
    request_parameters json,
    "responseElements" json,
    source_ip character varying(45),
    user_agent character varying(300),
    full_entry json,
    user_identity json,
    user_identity_arn character varying(300),
    revision_id integer NOT NULL,
    item_id integer NOT NULL
);


ALTER TABLE public.cloudtrail OWNER TO threatalertuser;

--
-- Name: cloudtrail_id_seq; Type: SEQUENCE; Schema: public; Owner: threatalertuser
--

CREATE SEQUENCE public.cloudtrail_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cloudtrail_id_seq OWNER TO threatalertuser;

--
-- Name: cloudtrail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: threatalertuser
--

ALTER SEQUENCE public.cloudtrail_id_seq OWNED BY public.cloudtrail.id;


--
-- Name: exceptions; Type: TABLE; Schema: public; Owner: threatalertuser
--

CREATE TABLE public.exceptions (
    id bigint NOT NULL,
    source character varying(256) NOT NULL,
    occurred timestamp without time zone NOT NULL,
    ttl timestamp without time zone NOT NULL,
    type character varying(256) NOT NULL,
    message character varying(512),
    stacktrace text,
    region character varying(32),
    tech_id integer,
    item_id integer,
    account_id integer
);


ALTER TABLE public.exceptions OWNER TO threatalertuser;

--
-- Name: exceptions_id_seq; Type: SEQUENCE; Schema: public; Owner: threatalertuser
--

CREATE SEQUENCE public.exceptions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.exceptions_id_seq OWNER TO threatalertuser;

--
-- Name: exceptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: threatalertuser
--

ALTER SEQUENCE public.exceptions_id_seq OWNED BY public.exceptions.id;


--
-- Name: ignorelist; Type: TABLE; Schema: public; Owner: threatalertuser
--

CREATE TABLE public.ignorelist (
    id integer NOT NULL,
    prefix character varying(512),
    notes character varying(512),
    tech_id integer NOT NULL
);


ALTER TABLE public.ignorelist OWNER TO threatalertuser;

--
-- Name: ignorelist_id_seq; Type: SEQUENCE; Schema: public; Owner: threatalertuser
--

CREATE SEQUENCE public.ignorelist_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ignorelist_id_seq OWNER TO threatalertuser;

--
-- Name: ignorelist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: threatalertuser
--

ALTER SEQUENCE public.ignorelist_id_seq OWNED BY public.ignorelist.id;


--
-- Name: issue_item_association; Type: TABLE; Schema: public; Owner: threatalertuser
--

CREATE TABLE public.issue_item_association (
    super_issue_id integer,
    sub_item_id integer
);


ALTER TABLE public.issue_item_association OWNER TO threatalertuser;

--
-- Name: item; Type: TABLE; Schema: public; Owner: threatalertuser
--

CREATE TABLE public.item (
    id integer NOT NULL,
    region character varying(32),
    name character varying(303),
    tech_id integer NOT NULL,
    account_id integer NOT NULL,
    latest_revision_id integer,
    arn text,
    latest_revision_complete_hash character varying(32),
    latest_revision_durable_hash character varying(32)
);


ALTER TABLE public.item OWNER TO threatalertuser;

--
-- Name: item_id_seq; Type: SEQUENCE; Schema: public; Owner: threatalertuser
--

CREATE SEQUENCE public.item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.item_id_seq OWNER TO threatalertuser;

--
-- Name: item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: threatalertuser
--

ALTER SEQUENCE public.item_id_seq OWNED BY public.item.id;


--
-- Name: itemaudit; Type: TABLE; Schema: public; Owner: threatalertuser
--

CREATE TABLE public.itemaudit (
    id integer NOT NULL,
    score integer,
    issue character varying(512),
    notes character varying(1024),
    justified boolean,
    justified_user_id integer,
    justification character varying(512),
    justified_date timestamp without time zone,
    item_id integer NOT NULL,
    auditor_setting_id integer,
    action_instructions text,
    background_info text,
    origin text,
    origin_summary text,
    class_uuid character varying(32),
    fixed boolean NOT NULL,
    itsm_ticket character varying(64),
    itsm_ticket_date timestamp without time zone,
    itsm_ticket_details character varying(512),
    itsm_ticket_user_id integer
);


ALTER TABLE public.itemaudit OWNER TO threatalertuser;

--
-- Name: itemaudit_id_seq; Type: SEQUENCE; Schema: public; Owner: threatalertuser
--

CREATE SEQUENCE public.itemaudit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.itemaudit_id_seq OWNER TO threatalertuser;

--
-- Name: itemaudit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: threatalertuser
--

ALTER SEQUENCE public.itemaudit_id_seq OWNED BY public.itemaudit.id;


--
-- Name: itemauditscores; Type: TABLE; Schema: public; Owner: threatalertuser
--

CREATE TABLE public.itemauditscores (
    id integer NOT NULL,
    technology character varying(128) NOT NULL,
    method character varying(256) NOT NULL,
    score integer NOT NULL,
    disabled boolean
);


ALTER TABLE public.itemauditscores OWNER TO threatalertuser;

--
-- Name: itemauditscores_id_seq; Type: SEQUENCE; Schema: public; Owner: threatalertuser
--

CREATE SEQUENCE public.itemauditscores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.itemauditscores_id_seq OWNER TO threatalertuser;

--
-- Name: itemauditscores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: threatalertuser
--

ALTER SEQUENCE public.itemauditscores_id_seq OWNED BY public.itemauditscores.id;


--
-- Name: itemcomment; Type: TABLE; Schema: public; Owner: threatalertuser
--

CREATE TABLE public.itemcomment (
    id integer NOT NULL,
    user_id integer NOT NULL,
    item_id integer NOT NULL,
    date_created timestamp without time zone NOT NULL,
    text character varying(1024)
);


ALTER TABLE public.itemcomment OWNER TO threatalertuser;

--
-- Name: itemcomment_id_seq; Type: SEQUENCE; Schema: public; Owner: threatalertuser
--

CREATE SEQUENCE public.itemcomment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.itemcomment_id_seq OWNER TO threatalertuser;

--
-- Name: itemcomment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: threatalertuser
--

ALTER SEQUENCE public.itemcomment_id_seq OWNED BY public.itemcomment.id;


--
-- Name: itemrevision; Type: TABLE; Schema: public; Owner: threatalertuser
--

CREATE TABLE public.itemrevision (
    id integer NOT NULL,
    active boolean,
    config json,
    date_created timestamp without time zone NOT NULL,
    item_id integer NOT NULL,
    date_last_ephemeral_change timestamp without time zone
);


ALTER TABLE public.itemrevision OWNER TO threatalertuser;

--
-- Name: itemrevision_id_seq; Type: SEQUENCE; Schema: public; Owner: threatalertuser
--

CREATE SEQUENCE public.itemrevision_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.itemrevision_id_seq OWNER TO threatalertuser;

--
-- Name: itemrevision_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: threatalertuser
--

ALTER SEQUENCE public.itemrevision_id_seq OWNED BY public.itemrevision.id;


--
-- Name: itemrevisioncomment; Type: TABLE; Schema: public; Owner: threatalertuser
--

CREATE TABLE public.itemrevisioncomment (
    id integer NOT NULL,
    user_id integer NOT NULL,
    revision_id integer NOT NULL,
    date_created timestamp without time zone NOT NULL,
    text character varying(1024)
);


ALTER TABLE public.itemrevisioncomment OWNER TO threatalertuser;

--
-- Name: itemrevisioncomment_id_seq; Type: SEQUENCE; Schema: public; Owner: threatalertuser
--

CREATE SEQUENCE public.itemrevisioncomment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.itemrevisioncomment_id_seq OWNER TO threatalertuser;

--
-- Name: itemrevisioncomment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: threatalertuser
--

ALTER SEQUENCE public.itemrevisioncomment_id_seq OWNED BY public.itemrevisioncomment.id;


--
-- Name: itsm_product; Type: TABLE; Schema: public; Owner: threatalertuser
--

CREATE TABLE public.itsm_product (
    id integer NOT NULL,
    name character varying(80)
);


ALTER TABLE public.itsm_product OWNER TO threatalertuser;

--
-- Name: itsm_product_config; Type: TABLE; Schema: public; Owner: threatalertuser
--

CREATE TABLE public.itsm_product_config (
    id integer NOT NULL,
    active boolean,
    itsm_product_id integer NOT NULL
);


ALTER TABLE public.itsm_product_config OWNER TO threatalertuser;

--
-- Name: itsm_product_config_customvalues; Type: TABLE; Schema: public; Owner: threatalertuser
--

CREATE TABLE public.itsm_product_config_customvalues (
    id integer NOT NULL,
    name character varying(64),
    value character varying(256),
    itsm_product_config_id integer NOT NULL
);


ALTER TABLE public.itsm_product_config_customvalues OWNER TO threatalertuser;

--
-- Name: itsm_product_config_customvalues_id_seq; Type: SEQUENCE; Schema: public; Owner: threatalertuser
--

CREATE SEQUENCE public.itsm_product_config_customvalues_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.itsm_product_config_customvalues_id_seq OWNER TO threatalertuser;

--
-- Name: itsm_product_config_customvalues_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: threatalertuser
--

ALTER SEQUENCE public.itsm_product_config_customvalues_id_seq OWNED BY public.itsm_product_config_customvalues.id;


--
-- Name: itsm_product_config_id_seq; Type: SEQUENCE; Schema: public; Owner: threatalertuser
--

CREATE SEQUENCE public.itsm_product_config_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.itsm_product_config_id_seq OWNER TO threatalertuser;

--
-- Name: itsm_product_config_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: threatalertuser
--

ALTER SEQUENCE public.itsm_product_config_id_seq OWNED BY public.itsm_product_config.id;


--
-- Name: itsm_product_id_seq; Type: SEQUENCE; Schema: public; Owner: threatalertuser
--

CREATE SEQUENCE public.itsm_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.itsm_product_id_seq OWNER TO threatalertuser;

--
-- Name: itsm_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: threatalertuser
--

ALTER SEQUENCE public.itsm_product_id_seq OWNED BY public.itsm_product.id;


--
-- Name: networkwhitelist; Type: TABLE; Schema: public; Owner: threatalertuser
--

CREATE TABLE public.networkwhitelist (
    id integer NOT NULL,
    name character varying(512),
    notes character varying(512),
    cidr cidr
);


ALTER TABLE public.networkwhitelist OWNER TO threatalertuser;

--
-- Name: networkwhitelist_id_seq; Type: SEQUENCE; Schema: public; Owner: threatalertuser
--

CREATE SEQUENCE public.networkwhitelist_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.networkwhitelist_id_seq OWNER TO threatalertuser;

--
-- Name: networkwhitelist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: threatalertuser
--

ALTER SEQUENCE public.networkwhitelist_id_seq OWNED BY public.networkwhitelist.id;


--
-- Name: role; Type: TABLE; Schema: public; Owner: threatalertuser
--

CREATE TABLE public.role (
    id integer NOT NULL,
    name character varying(80),
    description character varying(255)
);


ALTER TABLE public.role OWNER TO threatalertuser;

--
-- Name: role_id_seq; Type: SEQUENCE; Schema: public; Owner: threatalertuser
--

CREATE SEQUENCE public.role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.role_id_seq OWNER TO threatalertuser;

--
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: threatalertuser
--

ALTER SEQUENCE public.role_id_seq OWNED BY public.role.id;


--
-- Name: roles_users; Type: TABLE; Schema: public; Owner: threatalertuser
--

CREATE TABLE public.roles_users (
    user_id integer,
    role_id integer
);


ALTER TABLE public.roles_users OWNER TO threatalertuser;

--
-- Name: technology; Type: TABLE; Schema: public; Owner: threatalertuser
--

CREATE TABLE public.technology (
    id integer NOT NULL,
    name character varying(32)
);


ALTER TABLE public.technology OWNER TO threatalertuser;

--
-- Name: technology_id_seq; Type: SEQUENCE; Schema: public; Owner: threatalertuser
--

CREATE SEQUENCE public.technology_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.technology_id_seq OWNER TO threatalertuser;

--
-- Name: technology_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: threatalertuser
--

ALTER SEQUENCE public.technology_id_seq OWNED BY public.technology.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: threatalertuser
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    email character varying(255),
    password character varying(255),
    active boolean,
    confirmed_at timestamp without time zone,
    daily_audit_email boolean,
    change_reports character varying(32),
    role character varying(30),
    current_login_at timestamp without time zone,
    current_login_ip character varying(45),
    last_login_at timestamp without time zone,
    last_login_ip character varying(45),
    login_count integer
);


ALTER TABLE public."user" OWNER TO threatalertuser;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: threatalertuser
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO threatalertuser;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: threatalertuser
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: user_passwordhistory; Type: TABLE; Schema: public; Owner: threatalertuser
--

CREATE TABLE public.user_passwordhistory (
    id integer NOT NULL,
    user_id integer NOT NULL,
    password character varying(255),
    changed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.user_passwordhistory OWNER TO threatalertuser;

--
-- Name: user_passwordhistory_id_seq; Type: SEQUENCE; Schema: public; Owner: threatalertuser
--

CREATE SEQUENCE public.user_passwordhistory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_passwordhistory_id_seq OWNER TO threatalertuser;

--
-- Name: user_passwordhistory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: threatalertuser
--

ALTER SEQUENCE public.user_passwordhistory_id_seq OWNED BY public.user_passwordhistory.id;


--
-- Name: watcher_config; Type: TABLE; Schema: public; Owner: threatalertuser
--

CREATE TABLE public.watcher_config (
    id integer NOT NULL,
    index character varying(80),
    "interval" integer NOT NULL,
    active boolean NOT NULL
);


ALTER TABLE public.watcher_config OWNER TO threatalertuser;

--
-- Name: watcher_config_id_seq; Type: SEQUENCE; Schema: public; Owner: threatalertuser
--

CREATE SEQUENCE public.watcher_config_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.watcher_config_id_seq OWNER TO threatalertuser;

--
-- Name: watcher_config_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: threatalertuser
--

ALTER SEQUENCE public.watcher_config_id_seq OWNED BY public.watcher_config.id;


--
-- Name: account id; Type: DEFAULT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.account ALTER COLUMN id SET DEFAULT nextval('public.account_id_seq'::regclass);


--
-- Name: account_type id; Type: DEFAULT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.account_type ALTER COLUMN id SET DEFAULT nextval('public.account_type_id_seq'::regclass);


--
-- Name: account_type_values id; Type: DEFAULT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.account_type_values ALTER COLUMN id SET DEFAULT nextval('public.account_type_values_id_seq'::regclass);


--
-- Name: accountpatternauditscore id; Type: DEFAULT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.accountpatternauditscore ALTER COLUMN id SET DEFAULT nextval('public.accountpatternauditscore_id_seq'::regclass);


--
-- Name: anchore_config id; Type: DEFAULT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.anchore_config ALTER COLUMN id SET DEFAULT nextval('public.anchore_config_id_seq'::regclass);


--
-- Name: auditorsettings id; Type: DEFAULT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.auditorsettings ALTER COLUMN id SET DEFAULT nextval('public.auditorsettings_id_seq'::regclass);


--
-- Name: cloudtrail id; Type: DEFAULT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.cloudtrail ALTER COLUMN id SET DEFAULT nextval('public.cloudtrail_id_seq'::regclass);


--
-- Name: exceptions id; Type: DEFAULT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.exceptions ALTER COLUMN id SET DEFAULT nextval('public.exceptions_id_seq'::regclass);


--
-- Name: ignorelist id; Type: DEFAULT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.ignorelist ALTER COLUMN id SET DEFAULT nextval('public.ignorelist_id_seq'::regclass);


--
-- Name: item id; Type: DEFAULT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.item ALTER COLUMN id SET DEFAULT nextval('public.item_id_seq'::regclass);


--
-- Name: itemaudit id; Type: DEFAULT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.itemaudit ALTER COLUMN id SET DEFAULT nextval('public.itemaudit_id_seq'::regclass);


--
-- Name: itemauditscores id; Type: DEFAULT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.itemauditscores ALTER COLUMN id SET DEFAULT nextval('public.itemauditscores_id_seq'::regclass);


--
-- Name: itemcomment id; Type: DEFAULT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.itemcomment ALTER COLUMN id SET DEFAULT nextval('public.itemcomment_id_seq'::regclass);


--
-- Name: itemrevision id; Type: DEFAULT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.itemrevision ALTER COLUMN id SET DEFAULT nextval('public.itemrevision_id_seq'::regclass);


--
-- Name: itemrevisioncomment id; Type: DEFAULT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.itemrevisioncomment ALTER COLUMN id SET DEFAULT nextval('public.itemrevisioncomment_id_seq'::regclass);


--
-- Name: itsm_product id; Type: DEFAULT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.itsm_product ALTER COLUMN id SET DEFAULT nextval('public.itsm_product_id_seq'::regclass);


--
-- Name: itsm_product_config id; Type: DEFAULT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.itsm_product_config ALTER COLUMN id SET DEFAULT nextval('public.itsm_product_config_id_seq'::regclass);


--
-- Name: itsm_product_config_customvalues id; Type: DEFAULT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.itsm_product_config_customvalues ALTER COLUMN id SET DEFAULT nextval('public.itsm_product_config_customvalues_id_seq'::regclass);


--
-- Name: networkwhitelist id; Type: DEFAULT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.networkwhitelist ALTER COLUMN id SET DEFAULT nextval('public.networkwhitelist_id_seq'::regclass);


--
-- Name: role id; Type: DEFAULT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.role ALTER COLUMN id SET DEFAULT nextval('public.role_id_seq'::regclass);


--
-- Name: technology id; Type: DEFAULT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.technology ALTER COLUMN id SET DEFAULT nextval('public.technology_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Name: user_passwordhistory id; Type: DEFAULT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.user_passwordhistory ALTER COLUMN id SET DEFAULT nextval('public.user_passwordhistory_id_seq'::regclass);


--
-- Name: watcher_config id; Type: DEFAULT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.watcher_config ALTER COLUMN id SET DEFAULT nextval('public.watcher_config_id_seq'::regclass);


--
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: threatalertuser
--

COPY public.account (id, active, third_party, name, notes, account_type_id, identifier, email_address) FROM stdin;
\.


--
-- Data for Name: account_type; Type: TABLE DATA; Schema: public; Owner: threatalertuser
--

COPY public.account_type (id, name) FROM stdin;
1	AWS
\.


--
-- Data for Name: account_type_values; Type: TABLE DATA; Schema: public; Owner: threatalertuser
--

COPY public.account_type_values (id, name, value, account_id) FROM stdin;
\.


--
-- Data for Name: accountpatternauditscore; Type: TABLE DATA; Schema: public; Owner: threatalertuser
--

COPY public.accountpatternauditscore (id, account_type, account_field, account_pattern, score, itemauditscores_id) FROM stdin;
\.


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: threatalertuser
--

COPY public.alembic_version (version_num) FROM stdin;
150c9e5bb88d
\.


--
-- Data for Name: anchore_config; Type: TABLE DATA; Schema: public; Owner: threatalertuser
--

COPY public.anchore_config (id, name, username, password, url, ssl_verify) FROM stdin;
\.


--
-- Data for Name: association; Type: TABLE DATA; Schema: public; Owner: threatalertuser
--

COPY public.association (user_id, account_id) FROM stdin;
\.


--
-- Data for Name: auditorsettings; Type: TABLE DATA; Schema: public; Owner: threatalertuser
--

COPY public.auditorsettings (id, tech_id, account_id, disabled, issue_text, auditor_class) FROM stdin;
\.


--
-- Data for Name: cloudtrail; Type: TABLE DATA; Schema: public; Owner: threatalertuser
--

COPY public.cloudtrail (id, event_id, request_id, event_source, event_name, event_time, request_parameters, "responseElements", source_ip, user_agent, full_entry, user_identity, user_identity_arn, revision_id, item_id) FROM stdin;
\.


--
-- Data for Name: exceptions; Type: TABLE DATA; Schema: public; Owner: threatalertuser
--

COPY public.exceptions (id, source, occurred, ttl, type, message, stacktrace, region, tech_id, item_id, account_id) FROM stdin;
\.


--
-- Data for Name: ignorelist; Type: TABLE DATA; Schema: public; Owner: threatalertuser
--

COPY public.ignorelist (id, prefix, notes, tech_id) FROM stdin;
\.


--
-- Data for Name: issue_item_association; Type: TABLE DATA; Schema: public; Owner: threatalertuser
--

COPY public.issue_item_association (super_issue_id, sub_item_id) FROM stdin;
\.


--
-- Data for Name: item; Type: TABLE DATA; Schema: public; Owner: threatalertuser
--

COPY public.item (id, region, name, tech_id, account_id, latest_revision_id, arn, latest_revision_complete_hash, latest_revision_durable_hash) FROM stdin;
\.


--
-- Data for Name: itemaudit; Type: TABLE DATA; Schema: public; Owner: threatalertuser
--

COPY public.itemaudit (id, score, issue, notes, justified, justified_user_id, justification, justified_date, item_id, auditor_setting_id, action_instructions, background_info, origin, origin_summary, class_uuid, fixed, itsm_ticket, itsm_ticket_date, itsm_ticket_details, itsm_ticket_user_id) FROM stdin;
\.


--
-- Data for Name: itemauditscores; Type: TABLE DATA; Schema: public; Owner: threatalertuser
--

COPY public.itemauditscores (id, technology, method, score, disabled) FROM stdin;
\.


--
-- Data for Name: itemcomment; Type: TABLE DATA; Schema: public; Owner: threatalertuser
--

COPY public.itemcomment (id, user_id, item_id, date_created, text) FROM stdin;
\.


--
-- Data for Name: itemrevision; Type: TABLE DATA; Schema: public; Owner: threatalertuser
--

COPY public.itemrevision (id, active, config, date_created, item_id, date_last_ephemeral_change) FROM stdin;
\.


--
-- Data for Name: itemrevisioncomment; Type: TABLE DATA; Schema: public; Owner: threatalertuser
--

COPY public.itemrevisioncomment (id, user_id, revision_id, date_created, text) FROM stdin;
\.


--
-- Data for Name: itsm_product; Type: TABLE DATA; Schema: public; Owner: threatalertuser
--

COPY public.itsm_product (id, name) FROM stdin;
1	Jira
2	ServiceNow
\.


--
-- Data for Name: itsm_product_config; Type: TABLE DATA; Schema: public; Owner: threatalertuser
--

COPY public.itsm_product_config (id, active, itsm_product_id) FROM stdin;
\.


--
-- Data for Name: itsm_product_config_customvalues; Type: TABLE DATA; Schema: public; Owner: threatalertuser
--

COPY public.itsm_product_config_customvalues (id, name, value, itsm_product_config_id) FROM stdin;
\.


--
-- Data for Name: networkwhitelist; Type: TABLE DATA; Schema: public; Owner: threatalertuser
--

COPY public.networkwhitelist (id, name, notes, cidr) FROM stdin;
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: threatalertuser
--

COPY public.role (id, name, description) FROM stdin;
\.


--
-- Data for Name: roles_users; Type: TABLE DATA; Schema: public; Owner: threatalertuser
--

COPY public.roles_users (user_id, role_id) FROM stdin;
\.


--
-- Data for Name: technology; Type: TABLE DATA; Schema: public; Owner: threatalertuser
--

COPY public.technology (id, name) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: threatalertuser
--

COPY public."user" (id, email, password, active, confirmed_at, daily_audit_email, change_reports, role, current_login_at, current_login_ip, last_login_at, last_login_ip, login_count) FROM stdin;
1	admin@threatalert	$2a$12$m9lmAcwPUkv4q.O.rz.24.BMhNDszt5M/wabRTEzR57Kyq02nhBqK	t	2019-03-21 12:15:46.933806	\N	\N	Admin	2020-03-31 21:15:23.448695	76.100.43.89	2019-03-21 17:06:46.727773	76.100.43.89	3
\.


--
-- Data for Name: user_passwordhistory; Type: TABLE DATA; Schema: public; Owner: threatalertuser
--

COPY public.user_passwordhistory (id, user_id, password, changed_at) FROM stdin;
1	1	$2a$12$qmHgHRScTGV5G1YgSw5WluxewUcYmXbPCXwnXOaiJ7kzRZjX5RCOO	2019-03-21 12:15:25.450835
2	1	$2a$12$qmHgHRScTGV5G1YgSw5WluxewUcYmXbPCXwnXOaiJ7kzRZjX5RCOO	2020-03-31 17:15:35.964603
\.


--
-- Data for Name: watcher_config; Type: TABLE DATA; Schema: public; Owner: threatalertuser
--

COPY public.watcher_config (id, index, "interval", active) FROM stdin;
\.


--
-- Name: account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: threatalertuser
--

SELECT pg_catalog.setval('public.account_id_seq', 1, false);


--
-- Name: account_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: threatalertuser
--

SELECT pg_catalog.setval('public.account_type_id_seq', 1, true);


--
-- Name: account_type_values_id_seq; Type: SEQUENCE SET; Schema: public; Owner: threatalertuser
--

SELECT pg_catalog.setval('public.account_type_values_id_seq', 1, false);


--
-- Name: accountpatternauditscore_id_seq; Type: SEQUENCE SET; Schema: public; Owner: threatalertuser
--

SELECT pg_catalog.setval('public.accountpatternauditscore_id_seq', 1, false);


--
-- Name: anchore_config_id_seq; Type: SEQUENCE SET; Schema: public; Owner: threatalertuser
--

SELECT pg_catalog.setval('public.anchore_config_id_seq', 1, false);


--
-- Name: auditorsettings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: threatalertuser
--

SELECT pg_catalog.setval('public.auditorsettings_id_seq', 1, false);


--
-- Name: cloudtrail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: threatalertuser
--

SELECT pg_catalog.setval('public.cloudtrail_id_seq', 1, false);


--
-- Name: exceptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: threatalertuser
--

SELECT pg_catalog.setval('public.exceptions_id_seq', 1, false);


--
-- Name: ignorelist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: threatalertuser
--

SELECT pg_catalog.setval('public.ignorelist_id_seq', 1, false);


--
-- Name: item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: threatalertuser
--

SELECT pg_catalog.setval('public.item_id_seq', 1, false);


--
-- Name: itemaudit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: threatalertuser
--

SELECT pg_catalog.setval('public.itemaudit_id_seq', 1, false);


--
-- Name: itemauditscores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: threatalertuser
--

SELECT pg_catalog.setval('public.itemauditscores_id_seq', 1, false);


--
-- Name: itemcomment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: threatalertuser
--

SELECT pg_catalog.setval('public.itemcomment_id_seq', 1, false);


--
-- Name: itemrevision_id_seq; Type: SEQUENCE SET; Schema: public; Owner: threatalertuser
--

SELECT pg_catalog.setval('public.itemrevision_id_seq', 1, false);


--
-- Name: itemrevisioncomment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: threatalertuser
--

SELECT pg_catalog.setval('public.itemrevisioncomment_id_seq', 1, false);


--
-- Name: itsm_product_config_customvalues_id_seq; Type: SEQUENCE SET; Schema: public; Owner: threatalertuser
--

SELECT pg_catalog.setval('public.itsm_product_config_customvalues_id_seq', 1, false);


--
-- Name: itsm_product_config_id_seq; Type: SEQUENCE SET; Schema: public; Owner: threatalertuser
--

SELECT pg_catalog.setval('public.itsm_product_config_id_seq', 1, false);


--
-- Name: itsm_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: threatalertuser
--

SELECT pg_catalog.setval('public.itsm_product_id_seq', 2, true);


--
-- Name: networkwhitelist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: threatalertuser
--

SELECT pg_catalog.setval('public.networkwhitelist_id_seq', 1, false);


--
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: threatalertuser
--

SELECT pg_catalog.setval('public.role_id_seq', 1, false);


--
-- Name: technology_id_seq; Type: SEQUENCE SET; Schema: public; Owner: threatalertuser
--

SELECT pg_catalog.setval('public.technology_id_seq', 1, false);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: threatalertuser
--

SELECT pg_catalog.setval('public.user_id_seq', 1, true);


--
-- Name: user_passwordhistory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: threatalertuser
--

SELECT pg_catalog.setval('public.user_passwordhistory_id_seq', 2, true);


--
-- Name: watcher_config_id_seq; Type: SEQUENCE SET; Schema: public; Owner: threatalertuser
--

SELECT pg_catalog.setval('public.watcher_config_id_seq', 1, false);


--
-- Name: account account_identifier_key; Type: CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_identifier_key UNIQUE (identifier);


--
-- Name: account account_pkey; Type: CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);


--
-- Name: account_type account_type_name_key; Type: CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.account_type
    ADD CONSTRAINT account_type_name_key UNIQUE (name);


--
-- Name: account_type account_type_pkey; Type: CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.account_type
    ADD CONSTRAINT account_type_pkey PRIMARY KEY (id);


--
-- Name: account_type_values account_type_values_pkey; Type: CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.account_type_values
    ADD CONSTRAINT account_type_values_pkey PRIMARY KEY (id);


--
-- Name: accountpatternauditscore accountpatternauditscore_pkey; Type: CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.accountpatternauditscore
    ADD CONSTRAINT accountpatternauditscore_pkey PRIMARY KEY (id);


--
-- Name: anchore_config anchore_config_pkey; Type: CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.anchore_config
    ADD CONSTRAINT anchore_config_pkey PRIMARY KEY (id, name);


--
-- Name: auditorsettings auditorsettings_pkey; Type: CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.auditorsettings
    ADD CONSTRAINT auditorsettings_pkey PRIMARY KEY (id);


--
-- Name: cloudtrail cloudtrail_pkey; Type: CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.cloudtrail
    ADD CONSTRAINT cloudtrail_pkey PRIMARY KEY (id);


--
-- Name: exceptions exceptions_pkey; Type: CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.exceptions
    ADD CONSTRAINT exceptions_pkey PRIMARY KEY (id);


--
-- Name: ignorelist ignorelist_pkey; Type: CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.ignorelist
    ADD CONSTRAINT ignorelist_pkey PRIMARY KEY (id);


--
-- Name: item item_pkey; Type: CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.item
    ADD CONSTRAINT item_pkey PRIMARY KEY (id);


--
-- Name: itemaudit itemaudit_pkey; Type: CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.itemaudit
    ADD CONSTRAINT itemaudit_pkey PRIMARY KEY (id);


--
-- Name: itemauditscores itemauditscores_pkey; Type: CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.itemauditscores
    ADD CONSTRAINT itemauditscores_pkey PRIMARY KEY (id);


--
-- Name: itemcomment itemcomment_pkey; Type: CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.itemcomment
    ADD CONSTRAINT itemcomment_pkey PRIMARY KEY (id);


--
-- Name: itemrevision itemrevision_pkey; Type: CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.itemrevision
    ADD CONSTRAINT itemrevision_pkey PRIMARY KEY (id);


--
-- Name: itemrevisioncomment itemrevisioncomment_pkey; Type: CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.itemrevisioncomment
    ADD CONSTRAINT itemrevisioncomment_pkey PRIMARY KEY (id);


--
-- Name: itsm_product_config_customvalues itsm_product_config_customvalues_pkey; Type: CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.itsm_product_config_customvalues
    ADD CONSTRAINT itsm_product_config_customvalues_pkey PRIMARY KEY (id);


--
-- Name: itsm_product_config itsm_product_config_pkey; Type: CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.itsm_product_config
    ADD CONSTRAINT itsm_product_config_pkey PRIMARY KEY (id);


--
-- Name: itsm_product itsm_product_name_key; Type: CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.itsm_product
    ADD CONSTRAINT itsm_product_name_key UNIQUE (name);


--
-- Name: itsm_product itsm_product_pkey; Type: CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.itsm_product
    ADD CONSTRAINT itsm_product_pkey PRIMARY KEY (id);


--
-- Name: networkwhitelist networkwhitelist_pkey; Type: CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.networkwhitelist
    ADD CONSTRAINT networkwhitelist_pkey PRIMARY KEY (id);


--
-- Name: role role_name_key; Type: CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_name_key UNIQUE (name);


--
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- Name: itemauditscores tech_method_uc; Type: CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.itemauditscores
    ADD CONSTRAINT tech_method_uc UNIQUE (technology, method);


--
-- Name: technology technology_pkey; Type: CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.technology
    ADD CONSTRAINT technology_pkey PRIMARY KEY (id);


--
-- Name: user user_email_key; Type: CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- Name: user_passwordhistory user_passwordhistory_pkey; Type: CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.user_passwordhistory
    ADD CONSTRAINT user_passwordhistory_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: watcher_config watcher_config_index_key; Type: CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.watcher_config
    ADD CONSTRAINT watcher_config_index_key UNIQUE (index);


--
-- Name: watcher_config watcher_config_pkey; Type: CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.watcher_config
    ADD CONSTRAINT watcher_config_pkey PRIMARY KEY (id);


--
-- Name: ix_account_name; Type: INDEX; Schema: public; Owner: threatalertuser
--

CREATE UNIQUE INDEX ix_account_name ON public.account USING btree (name);


--
-- Name: ix_auditorsettings_account_id; Type: INDEX; Schema: public; Owner: threatalertuser
--

CREATE INDEX ix_auditorsettings_account_id ON public.auditorsettings USING btree (account_id);


--
-- Name: ix_auditorsettings_tech_id; Type: INDEX; Schema: public; Owner: threatalertuser
--

CREATE INDEX ix_auditorsettings_tech_id ON public.auditorsettings USING btree (tech_id);


--
-- Name: ix_cloudtrail_event_id; Type: INDEX; Schema: public; Owner: threatalertuser
--

CREATE UNIQUE INDEX ix_cloudtrail_event_id ON public.cloudtrail USING btree (event_id);


--
-- Name: ix_cloudtrail_event_time; Type: INDEX; Schema: public; Owner: threatalertuser
--

CREATE INDEX ix_cloudtrail_event_time ON public.cloudtrail USING btree (event_time);


--
-- Name: ix_cloudtrail_item_id; Type: INDEX; Schema: public; Owner: threatalertuser
--

CREATE INDEX ix_cloudtrail_item_id ON public.cloudtrail USING btree (item_id);


--
-- Name: ix_cloudtrail_request_id; Type: INDEX; Schema: public; Owner: threatalertuser
--

CREATE INDEX ix_cloudtrail_request_id ON public.cloudtrail USING btree (request_id);


--
-- Name: ix_cloudtrail_revision_id; Type: INDEX; Schema: public; Owner: threatalertuser
--

CREATE INDEX ix_cloudtrail_revision_id ON public.cloudtrail USING btree (revision_id);


--
-- Name: ix_cloudtrail_user_identity_arn; Type: INDEX; Schema: public; Owner: threatalertuser
--

CREATE INDEX ix_cloudtrail_user_identity_arn ON public.cloudtrail USING btree (user_identity_arn);


--
-- Name: ix_exceptions_account_id; Type: INDEX; Schema: public; Owner: threatalertuser
--

CREATE INDEX ix_exceptions_account_id ON public.exceptions USING btree (account_id);


--
-- Name: ix_exceptions_item_id; Type: INDEX; Schema: public; Owner: threatalertuser
--

CREATE INDEX ix_exceptions_item_id ON public.exceptions USING btree (item_id);


--
-- Name: ix_exceptions_region; Type: INDEX; Schema: public; Owner: threatalertuser
--

CREATE INDEX ix_exceptions_region ON public.exceptions USING btree (region);


--
-- Name: ix_exceptions_source; Type: INDEX; Schema: public; Owner: threatalertuser
--

CREATE INDEX ix_exceptions_source ON public.exceptions USING btree (source);


--
-- Name: ix_exceptions_tech_id; Type: INDEX; Schema: public; Owner: threatalertuser
--

CREATE INDEX ix_exceptions_tech_id ON public.exceptions USING btree (tech_id);


--
-- Name: ix_exceptions_type; Type: INDEX; Schema: public; Owner: threatalertuser
--

CREATE INDEX ix_exceptions_type ON public.exceptions USING btree (type);


--
-- Name: ix_ignorelist_tech_id; Type: INDEX; Schema: public; Owner: threatalertuser
--

CREATE INDEX ix_ignorelist_tech_id ON public.ignorelist USING btree (tech_id);


--
-- Name: ix_item_account_id; Type: INDEX; Schema: public; Owner: threatalertuser
--

CREATE INDEX ix_item_account_id ON public.item USING btree (account_id);


--
-- Name: ix_item_arn; Type: INDEX; Schema: public; Owner: threatalertuser
--

CREATE UNIQUE INDEX ix_item_arn ON public.item USING btree (arn);


--
-- Name: ix_item_latest_revision_complete_hash; Type: INDEX; Schema: public; Owner: threatalertuser
--

CREATE INDEX ix_item_latest_revision_complete_hash ON public.item USING btree (latest_revision_complete_hash);


--
-- Name: ix_item_latest_revision_durable_hash; Type: INDEX; Schema: public; Owner: threatalertuser
--

CREATE INDEX ix_item_latest_revision_durable_hash ON public.item USING btree (latest_revision_durable_hash);


--
-- Name: ix_item_name; Type: INDEX; Schema: public; Owner: threatalertuser
--

CREATE INDEX ix_item_name ON public.item USING btree (name);


--
-- Name: ix_item_region; Type: INDEX; Schema: public; Owner: threatalertuser
--

CREATE INDEX ix_item_region ON public.item USING btree (region);


--
-- Name: ix_item_tech_id; Type: INDEX; Schema: public; Owner: threatalertuser
--

CREATE INDEX ix_item_tech_id ON public.item USING btree (tech_id);


--
-- Name: ix_itemaudit_auditor_setting_id; Type: INDEX; Schema: public; Owner: threatalertuser
--

CREATE INDEX ix_itemaudit_auditor_setting_id ON public.itemaudit USING btree (auditor_setting_id);


--
-- Name: ix_itemaudit_item_id; Type: INDEX; Schema: public; Owner: threatalertuser
--

CREATE INDEX ix_itemaudit_item_id ON public.itemaudit USING btree (item_id);


--
-- Name: ix_itemaudit_itsm_ticket_user_id; Type: INDEX; Schema: public; Owner: threatalertuser
--

CREATE INDEX ix_itemaudit_itsm_ticket_user_id ON public.itemaudit USING btree (itsm_ticket_user_id);


--
-- Name: ix_itemaudit_justified_user_id; Type: INDEX; Schema: public; Owner: threatalertuser
--

CREATE INDEX ix_itemaudit_justified_user_id ON public.itemaudit USING btree (justified_user_id);


--
-- Name: ix_itemcomment_item_id; Type: INDEX; Schema: public; Owner: threatalertuser
--

CREATE INDEX ix_itemcomment_item_id ON public.itemcomment USING btree (item_id);


--
-- Name: ix_itemcomment_user_id; Type: INDEX; Schema: public; Owner: threatalertuser
--

CREATE INDEX ix_itemcomment_user_id ON public.itemcomment USING btree (user_id);


--
-- Name: ix_itemrevision_date_created; Type: INDEX; Schema: public; Owner: threatalertuser
--

CREATE INDEX ix_itemrevision_date_created ON public.itemrevision USING btree (date_created);


--
-- Name: ix_itemrevision_date_last_ephemeral_change; Type: INDEX; Schema: public; Owner: threatalertuser
--

CREATE INDEX ix_itemrevision_date_last_ephemeral_change ON public.itemrevision USING btree (date_last_ephemeral_change);


--
-- Name: ix_itemrevision_item_id; Type: INDEX; Schema: public; Owner: threatalertuser
--

CREATE INDEX ix_itemrevision_item_id ON public.itemrevision USING btree (item_id);


--
-- Name: ix_itemrevisioncomment_revision_id; Type: INDEX; Schema: public; Owner: threatalertuser
--

CREATE INDEX ix_itemrevisioncomment_revision_id ON public.itemrevisioncomment USING btree (revision_id);


--
-- Name: ix_itemrevisioncomment_user_id; Type: INDEX; Schema: public; Owner: threatalertuser
--

CREATE INDEX ix_itemrevisioncomment_user_id ON public.itemrevisioncomment USING btree (user_id);


--
-- Name: ix_technology_name; Type: INDEX; Schema: public; Owner: threatalertuser
--

CREATE UNIQUE INDEX ix_technology_name ON public.technology USING btree (name);


--
-- Name: ix_user_passwordhistory_user_id; Type: INDEX; Schema: public; Owner: threatalertuser
--

CREATE INDEX ix_user_passwordhistory_user_id ON public.user_passwordhistory USING btree (user_id);


--
-- Name: user user_password_change_insert_trigger; Type: TRIGGER; Schema: public; Owner: threatalertuser
--

CREATE TRIGGER user_password_change_insert_trigger BEFORE UPDATE ON public."user" FOR EACH ROW EXECUTE PROCEDURE public.user_password_change_insert();


--
-- Name: user user_password_insert_trigger; Type: TRIGGER; Schema: public; Owner: threatalertuser
--

CREATE TRIGGER user_password_insert_trigger AFTER INSERT ON public."user" FOR EACH ROW EXECUTE PROCEDURE public.user_password_change_insert();


--
-- Name: account account_account_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_account_type_id_fkey FOREIGN KEY (account_type_id) REFERENCES public.account_type(id);


--
-- Name: account_type_values account_type_values_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.account_type_values
    ADD CONSTRAINT account_type_values_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.account(id);


--
-- Name: accountpatternauditscore accountpatternauditscore_itemauditscores_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.accountpatternauditscore
    ADD CONSTRAINT accountpatternauditscore_itemauditscores_id_fkey FOREIGN KEY (itemauditscores_id) REFERENCES public.itemauditscores(id);


--
-- Name: association association_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.association
    ADD CONSTRAINT association_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.account(id);


--
-- Name: association association_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.association
    ADD CONSTRAINT association_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: auditorsettings auditorsettings_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.auditorsettings
    ADD CONSTRAINT auditorsettings_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.account(id);


--
-- Name: auditorsettings auditorsettings_tech_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.auditorsettings
    ADD CONSTRAINT auditorsettings_tech_id_fkey FOREIGN KEY (tech_id) REFERENCES public.technology(id);


--
-- Name: cloudtrail cloudtrail_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.cloudtrail
    ADD CONSTRAINT cloudtrail_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.item(id);


--
-- Name: cloudtrail cloudtrail_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.cloudtrail
    ADD CONSTRAINT cloudtrail_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES public.itemrevision(id);


--
-- Name: exceptions exceptions_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.exceptions
    ADD CONSTRAINT exceptions_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.account(id) ON DELETE CASCADE;


--
-- Name: exceptions exceptions_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.exceptions
    ADD CONSTRAINT exceptions_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.item(id) ON DELETE CASCADE;


--
-- Name: exceptions exceptions_tech_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.exceptions
    ADD CONSTRAINT exceptions_tech_id_fkey FOREIGN KEY (tech_id) REFERENCES public.technology(id) ON DELETE CASCADE;


--
-- Name: ignorelist ignorelist_tech_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.ignorelist
    ADD CONSTRAINT ignorelist_tech_id_fkey FOREIGN KEY (tech_id) REFERENCES public.technology(id);


--
-- Name: issue_item_association issue_item_association_sub_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.issue_item_association
    ADD CONSTRAINT issue_item_association_sub_item_id_fkey FOREIGN KEY (sub_item_id) REFERENCES public.item(id);


--
-- Name: issue_item_association issue_item_association_super_issue_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.issue_item_association
    ADD CONSTRAINT issue_item_association_super_issue_id_fkey FOREIGN KEY (super_issue_id) REFERENCES public.itemaudit(id);


--
-- Name: item item_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.item
    ADD CONSTRAINT item_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.account(id);


--
-- Name: item item_tech_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.item
    ADD CONSTRAINT item_tech_id_fkey FOREIGN KEY (tech_id) REFERENCES public.technology(id);


--
-- Name: itemaudit itemaudit_auditor_setting_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.itemaudit
    ADD CONSTRAINT itemaudit_auditor_setting_id_fkey FOREIGN KEY (auditor_setting_id) REFERENCES public.auditorsettings(id);


--
-- Name: itemaudit itemaudit_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.itemaudit
    ADD CONSTRAINT itemaudit_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.item(id);


--
-- Name: itemaudit itemaudit_itsm_ticket_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.itemaudit
    ADD CONSTRAINT itemaudit_itsm_ticket_user_id_fkey FOREIGN KEY (itsm_ticket_user_id) REFERENCES public."user"(id);


--
-- Name: itemaudit itemaudit_justified_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.itemaudit
    ADD CONSTRAINT itemaudit_justified_user_id_fkey FOREIGN KEY (justified_user_id) REFERENCES public."user"(id);


--
-- Name: itemcomment itemcomment_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.itemcomment
    ADD CONSTRAINT itemcomment_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.item(id);


--
-- Name: itemcomment itemcomment_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.itemcomment
    ADD CONSTRAINT itemcomment_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: itemrevision itemrevision_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.itemrevision
    ADD CONSTRAINT itemrevision_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.item(id);


--
-- Name: itemrevisioncomment itemrevisioncomment_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.itemrevisioncomment
    ADD CONSTRAINT itemrevisioncomment_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES public.itemrevision(id);


--
-- Name: itemrevisioncomment itemrevisioncomment_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.itemrevisioncomment
    ADD CONSTRAINT itemrevisioncomment_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: itsm_product_config_customvalues itsm_product_config_customvalues_itsm_product_config_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.itsm_product_config_customvalues
    ADD CONSTRAINT itsm_product_config_customvalues_itsm_product_config_id_fkey FOREIGN KEY (itsm_product_config_id) REFERENCES public.itsm_product_config(id);


--
-- Name: itsm_product_config itsm_product_config_itsm_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.itsm_product_config
    ADD CONSTRAINT itsm_product_config_itsm_product_id_fkey FOREIGN KEY (itsm_product_id) REFERENCES public.itsm_product(id);


--
-- Name: roles_users roles_users_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.roles_users
    ADD CONSTRAINT roles_users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.role(id);


--
-- Name: roles_users roles_users_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.roles_users
    ADD CONSTRAINT roles_users_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: user_passwordhistory user_passwordhistory_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: threatalertuser
--

ALTER TABLE ONLY public.user_passwordhistory
    ADD CONSTRAINT user_passwordhistory_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- PostgreSQL database dump complete
--

