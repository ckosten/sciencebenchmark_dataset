--
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.20
-- Dumped by pg_dump version 14.4

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

DROP DATABASE IF EXISTS cordis_temporary;
--
-- Name: cordis_temporary; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE cordis_temporary WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE cordis_temporary OWNER TO postgres;

\connect cordis_temporary

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
-- Name: cordis_temporary; Type: DATABASE PROPERTIES; Schema: -; Owner: postgres
--

ALTER DATABASE cordis_temporary SET search_path TO 'unics_cordis';


\connect cordis_temporary

CREATE EXTENSION IF NOT EXISTS pg_trgm SCHEMA cordis_temporary;
CREATE EXTENSION IF NOT EXISTS pg_trgm SCHEMA public;

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
-- Name: unics_cordis; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA unics_cordis;


ALTER SCHEMA unics_cordis OWNER TO postgres;

SET default_tablespace = '';

--
-- Name: activity_types; Type: TABLE; Schema: unics_cordis; Owner: postgres
--

CREATE TABLE unics_cordis.activity_types (
    code text NOT NULL,
    description text
);


ALTER TABLE unics_cordis.activity_types OWNER TO postgres;

--
-- Name: countries; Type: TABLE; Schema: unics_cordis; Owner: postgres
--

CREATE TABLE unics_cordis.countries (
    unics_id integer NOT NULL,
    country_name text NOT NULL,
    country_code2 character varying(2) NOT NULL,
    country_code3 character varying(3) NOT NULL,
    geocode_country_code character varying(2)
);


ALTER TABLE unics_cordis.countries OWNER TO postgres;

--
-- Name: ec_framework_programs; Type: TABLE; Schema: unics_cordis; Owner: postgres
--

CREATE TABLE unics_cordis.ec_framework_programs (
    ec_framework_program_name text NOT NULL
);


ALTER TABLE unics_cordis.ec_framework_programs OWNER TO postgres;

--
-- Name: projects; Type: TABLE; Schema: unics_cordis; Owner: postgres
--

CREATE TABLE unics_cordis.projects (
    unics_id integer NOT NULL,
    acronym text,
    title text,
    ec_call text,
    ec_fund_scheme text,
    cordis_ref text,
    ec_ref text,
    start_date date,
    end_date date,
    start_year integer,
    end_year integer,
    homepage text,
    total_cost double precision,
    ec_max_contribution double precision,
    framework_program text,
    objective text,
    principal_investigator integer
);


ALTER TABLE unics_cordis.projects OWNER TO postgres;

--
-- Name: erc_calls; Type: MATERIALIZED VIEW; Schema: unics_cordis; Owner: postgres
--

CREATE MATERIALIZED VIEW unics_cordis.erc_calls AS
 SELECT q.ec_call,
    q.erc_type,
    q.erc_type_name
   FROM ( SELECT DISTINCT p.ec_call,
                CASE
                    WHEN (p.ec_call ~~* 'ERC-%-AdG%'::text) THEN 'ADG'::text
                    WHEN (p.ec_call ~~* 'ERC-%-CoG%'::text) THEN 'COG'::text
                    WHEN (p.ec_call ~~* 'ERC-%-PoC%'::text) THEN 'POC'::text
                    WHEN (p.ec_call ~~* 'ERC-%-STG%'::text) THEN 'STG'::text
                    WHEN (p.ec_call ~~* 'ERC-%-Sup%'::text) THEN 'SUP'::text
                    WHEN (p.ec_call ~~* 'ERC-%-SyG%'::text) THEN 'SYG'::text
                    ELSE NULL::text
                END AS erc_type,
                CASE
                    WHEN (p.ec_call ~~* 'ERC-%-AdG%'::text) THEN 'ERC Advanced Grant'::text
                    WHEN (p.ec_call ~~* 'ERC-%-CoG%'::text) THEN 'ERC Consolidator Grant'::text
                    WHEN (p.ec_call ~~* 'ERC-%-PoC%'::text) THEN 'ERC Proof of Concept Grant'::text
                    WHEN (p.ec_call ~~* 'ERC-%-STG%'::text) THEN 'ERC Starting Grant'::text
                    WHEN (p.ec_call ~~* 'ERC-%-Sup%'::text) THEN 'ERC Support'::text
                    WHEN (p.ec_call ~~* 'ERC-%-SyG%'::text) THEN 'ERC Synergy Grant'::text
                    ELSE NULL::text
                END AS erc_type_name
           FROM unics_cordis.projects p
          WHERE (p.ec_call ~~* 'ERC-%'::text)) q
  WHERE ((q.erc_type IS NOT NULL) AND (q.erc_type_name IS NOT NULL))
  WITH NO DATA;


ALTER TABLE unics_cordis.erc_calls OWNER TO postgres;

--
-- Name: erc_grants; Type: MATERIALIZED VIEW; Schema: unics_cordis; Owner: postgres
--

CREATE MATERIALIZED VIEW unics_cordis.erc_grants AS
 SELECT DISTINCT erc_calls.erc_type AS code,
    erc_calls.erc_type_name AS name
   FROM unics_cordis.erc_calls
  WITH NO DATA;


ALTER TABLE unics_cordis.erc_grants OWNER TO postgres;

--
-- Name: erc_panels; Type: TABLE; Schema: unics_cordis; Owner: postgres
--

CREATE TABLE unics_cordis.erc_panels (
    code text NOT NULL,
    description text,
    part_of text
);


ALTER TABLE unics_cordis.erc_panels OWNER TO postgres;

--
-- Name: erc_research_domains; Type: TABLE; Schema: unics_cordis; Owner: postgres
--

CREATE TABLE unics_cordis.erc_research_domains (
    code text NOT NULL,
    description text
);


ALTER TABLE unics_cordis.erc_research_domains OWNER TO postgres;

--
-- Name: eu_territorial_units; Type: TABLE; Schema: unics_cordis; Owner: postgres
--

CREATE TABLE unics_cordis.eu_territorial_units (
    geocode_regions text NOT NULL,
    description text,
    geocode_level integer,
    nuts_version text
);


ALTER TABLE unics_cordis.eu_territorial_units OWNER TO postgres;

--
-- Name: funding_schemes; Type: TABLE; Schema: unics_cordis; Owner: postgres
--

CREATE TABLE unics_cordis.funding_schemes (
    code text NOT NULL,
    title text
);


ALTER TABLE unics_cordis.funding_schemes OWNER TO postgres;

--
-- Name: institutions; Type: TABLE; Schema: unics_cordis; Owner: postgres
--

CREATE TABLE unics_cordis.institutions (
    unics_id integer NOT NULL,
    country_id integer,
    institutions_name text NOT NULL,
    geocode_regions_3 text,
    db_pedia_url text,
    wikidata_url text,
    grid_id text,
    acronym text,
    short_name text,
    website text,
    document_vectors tsvector
);


ALTER TABLE unics_cordis.institutions OWNER TO postgres;

--
-- Name: nuts_hierarchy; Type: MATERIALIZED VIEW; Schema: unics_cordis; Owner: postgres
--

CREATE MATERIALIZED VIEW unics_cordis.nuts_hierarchy AS
 SELECT etu.geocode_regions AS nuts_3,
    "substring"(etu.geocode_regions, 1, 4) AS nuts_2,
    "substring"(etu.geocode_regions, 1, 3) AS nuts_1
   FROM unics_cordis.eu_territorial_units etu
  WHERE (length(etu.geocode_regions) >= 5)
  WITH NO DATA;


ALTER TABLE unics_cordis.nuts_hierarchy OWNER TO postgres;

--
-- Name: people; Type: TABLE; Schema: unics_cordis; Owner: postgres
--

CREATE TABLE unics_cordis.people (
    unics_id integer NOT NULL,
    full_name text
);


ALTER TABLE unics_cordis.people OWNER TO postgres;

--
-- Name: people_unics_id_seq; Type: SEQUENCE; Schema: unics_cordis; Owner: postgres
--

CREATE SEQUENCE unics_cordis.people_unics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE unics_cordis.people_unics_id_seq OWNER TO postgres;

--
-- Name: people_unics_id_seq; Type: SEQUENCE OWNED BY; Schema: unics_cordis; Owner: postgres
--

ALTER SEQUENCE unics_cordis.people_unics_id_seq OWNED BY unics_cordis.people.unics_id;


--
-- Name: programmes; Type: TABLE; Schema: unics_cordis; Owner: postgres
--

CREATE TABLE unics_cordis.programmes (
    code text NOT NULL,
    rcn text,
    title text,
    short_name text,
    parent text
);


ALTER TABLE unics_cordis.programmes OWNER TO postgres;

--
-- Name: programme_partof_programme; Type: MATERIALIZED VIEW; Schema: unics_cordis; Owner: postgres
--

CREATE MATERIALIZED VIEW unics_cordis.programme_partof_programme AS
( WITH RECURSIVE transitive_closure(prog, parent) AS (
         SELECT epp.code,
            epp.parent
           FROM unics_cordis.programmes epp
        UNION ALL
         SELECT tc.prog,
            epp.parent
           FROM (transitive_closure tc
             JOIN unics_cordis.programmes epp ON ((epp.code = tc.parent)))
        )
 SELECT transitive_closure.prog AS programme1,
    transitive_closure.parent AS programme2
   FROM transitive_closure
  WHERE (transitive_closure.parent IS NOT NULL))
UNION ALL
 SELECT epp.code AS programme1,
    epp.code AS programme2
   FROM unics_cordis.programmes epp
  WITH NO DATA;


ALTER TABLE unics_cordis.programme_partof_programme OWNER TO postgres;

--
-- Name: project_erc_panels; Type: TABLE; Schema: unics_cordis; Owner: postgres
--

CREATE TABLE unics_cordis.project_erc_panels (
    project integer NOT NULL,
    panel text NOT NULL
);


ALTER TABLE unics_cordis.project_erc_panels OWNER TO postgres;

--
-- Name: project_member_roles; Type: TABLE; Schema: unics_cordis; Owner: postgres
--

CREATE TABLE unics_cordis.project_member_roles (
    code text NOT NULL,
    description text
);


ALTER TABLE unics_cordis.project_member_roles OWNER TO postgres;

--
-- Name: project_members; Type: TABLE; Schema: unics_cordis; Owner: postgres
--

CREATE TABLE unics_cordis.project_members (
    unics_id integer NOT NULL,
    project integer NOT NULL,
    pic_number text,
    rcn text,
    member_name text,
    activity_type text,
    country text,
    street text,
    city text,
    postal_code text,
    ec_contribution double precision,
    institution_id integer,
    member_role text NOT NULL,
    geocode_regions_3 text,
    member_short_name text,
    department_name text,
    vat_number character varying,
    latitude numeric,
    longitude numeric,
    region_code text,
    region_name text
);


ALTER TABLE unics_cordis.project_members OWNER TO postgres;

--
-- Name: project_members_unics_id_seq; Type: SEQUENCE; Schema: unics_cordis; Owner: postgres
--

CREATE SEQUENCE unics_cordis.project_members_unics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE unics_cordis.project_members_unics_id_seq OWNER TO postgres;

--
-- Name: project_members_unics_id_seq; Type: SEQUENCE OWNED BY; Schema: unics_cordis; Owner: postgres
--

ALTER SEQUENCE unics_cordis.project_members_unics_id_seq OWNED BY unics_cordis.project_members.unics_id;


--
-- Name: project_programmes; Type: TABLE; Schema: unics_cordis; Owner: postgres
--

CREATE TABLE unics_cordis.project_programmes (
    project integer NOT NULL,
    programme text NOT NULL
);


ALTER TABLE unics_cordis.project_programmes OWNER TO postgres;

--
-- Name: project_subject_areas; Type: TABLE; Schema: unics_cordis; Owner: postgres
--

CREATE TABLE unics_cordis.project_subject_areas (
    project integer NOT NULL,
    subject_area text NOT NULL
);


ALTER TABLE unics_cordis.project_subject_areas OWNER TO postgres;

--
-- Name: project_topics; Type: TABLE; Schema: unics_cordis; Owner: postgres
--

CREATE TABLE unics_cordis.project_topics (
    project integer NOT NULL,
    topic text NOT NULL
);


ALTER TABLE unics_cordis.project_topics OWNER TO postgres;

--
-- Name: projects_unics_id_seq; Type: SEQUENCE; Schema: unics_cordis; Owner: postgres
--

CREATE SEQUENCE unics_cordis.projects_unics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE unics_cordis.projects_unics_id_seq OWNER TO postgres;

--
-- Name: projects_unics_id_seq; Type: SEQUENCE OWNED BY; Schema: unics_cordis; Owner: postgres
--

ALTER SEQUENCE unics_cordis.projects_unics_id_seq OWNED BY unics_cordis.projects.unics_id;


--
-- Name: subject_areas; Type: TABLE; Schema: unics_cordis; Owner: postgres
--

CREATE TABLE unics_cordis.subject_areas (
    code text NOT NULL,
    title text,
    description text
);


ALTER TABLE unics_cordis.subject_areas OWNER TO postgres;

--
-- Name: topics; Type: TABLE; Schema: unics_cordis; Owner: postgres
--

CREATE TABLE unics_cordis.topics (
    code text NOT NULL,
    rcn text,
    title text
);


ALTER TABLE unics_cordis.topics OWNER TO postgres;

--
-- Name: people unics_id; Type: DEFAULT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.people ALTER COLUMN unics_id SET DEFAULT nextval('unics_cordis.people_unics_id_seq'::regclass);


--
-- Name: project_members unics_id; Type: DEFAULT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.project_members ALTER COLUMN unics_id SET DEFAULT nextval('unics_cordis.project_members_unics_id_seq'::regclass);


--
-- Name: projects unics_id; Type: DEFAULT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.projects ALTER COLUMN unics_id SET DEFAULT nextval('unics_cordis.projects_unics_id_seq'::regclass);


--
-- Data for Name: activity_types; Type: TABLE DATA; Schema: unics_cordis; Owner: postgres
--

\i $$PATH$$/2484.dat

--
-- Data for Name: countries; Type: TABLE DATA; Schema: unics_cordis; Owner: postgres
--

\i $$PATH$$/2485.dat

--
-- Data for Name: ec_framework_programs; Type: TABLE DATA; Schema: unics_cordis; Owner: postgres
--

\i $$PATH$$/2486.dat

--
-- Data for Name: erc_panels; Type: TABLE DATA; Schema: unics_cordis; Owner: postgres
--

\i $$PATH$$/2490.dat

--
-- Data for Name: erc_research_domains; Type: TABLE DATA; Schema: unics_cordis; Owner: postgres
--

\i $$PATH$$/2491.dat

--
-- Data for Name: eu_territorial_units; Type: TABLE DATA; Schema: unics_cordis; Owner: postgres
--

\i $$PATH$$/2492.dat

--
-- Data for Name: funding_schemes; Type: TABLE DATA; Schema: unics_cordis; Owner: postgres
--

\i $$PATH$$/2493.dat

--
-- Data for Name: institutions; Type: TABLE DATA; Schema: unics_cordis; Owner: postgres
--

\i $$PATH$$/2494.dat

--
-- Data for Name: people; Type: TABLE DATA; Schema: unics_cordis; Owner: postgres
--

\i $$PATH$$/2496.dat

--
-- Data for Name: programmes; Type: TABLE DATA; Schema: unics_cordis; Owner: postgres
--

\i $$PATH$$/2498.dat

--
-- Data for Name: project_erc_panels; Type: TABLE DATA; Schema: unics_cordis; Owner: postgres
--

\i $$PATH$$/2500.dat

--
-- Data for Name: project_member_roles; Type: TABLE DATA; Schema: unics_cordis; Owner: postgres
--

\i $$PATH$$/2501.dat

--
-- Data for Name: project_members; Type: TABLE DATA; Schema: unics_cordis; Owner: postgres
--

\i $$PATH$$/2502.dat

--
-- Data for Name: project_programmes; Type: TABLE DATA; Schema: unics_cordis; Owner: postgres
--

\i $$PATH$$/2504.dat

--
-- Data for Name: project_subject_areas; Type: TABLE DATA; Schema: unics_cordis; Owner: postgres
--

\i $$PATH$$/2505.dat

--
-- Data for Name: project_topics; Type: TABLE DATA; Schema: unics_cordis; Owner: postgres
--

\i $$PATH$$/2506.dat

--
-- Data for Name: projects; Type: TABLE DATA; Schema: unics_cordis; Owner: postgres
--

\i $$PATH$$/2487.dat

--
-- Data for Name: subject_areas; Type: TABLE DATA; Schema: unics_cordis; Owner: postgres
--

\i $$PATH$$/2508.dat

--
-- Data for Name: topics; Type: TABLE DATA; Schema: unics_cordis; Owner: postgres
--

\i $$PATH$$/2509.dat

--
-- Name: people_unics_id_seq; Type: SEQUENCE SET; Schema: unics_cordis; Owner: postgres
--

SELECT pg_catalog.setval('unics_cordis.people_unics_id_seq', 1, false);


--
-- Name: project_members_unics_id_seq; Type: SEQUENCE SET; Schema: unics_cordis; Owner: postgres
--

SELECT pg_catalog.setval('unics_cordis.project_members_unics_id_seq', 1, false);


--
-- Name: projects_unics_id_seq; Type: SEQUENCE SET; Schema: unics_cordis; Owner: postgres
--

SELECT pg_catalog.setval('unics_cordis.projects_unics_id_seq', 1, false);


--
-- Name: activity_types activity_types_pkey; Type: CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.activity_types
    ADD CONSTRAINT activity_types_pkey PRIMARY KEY (code);


--
-- Name: countries countries_country_code2_key; Type: CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.countries
    ADD CONSTRAINT countries_country_code2_key UNIQUE (country_code2);


--
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (unics_id);


--
-- Name: ec_framework_programs ec_framework_programs_pkey; Type: CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.ec_framework_programs
    ADD CONSTRAINT ec_framework_programs_pkey PRIMARY KEY (ec_framework_program_name);


--
-- Name: erc_panels erc_panels_pkey; Type: CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.erc_panels
    ADD CONSTRAINT erc_panels_pkey PRIMARY KEY (code);


--
-- Name: erc_research_domains erc_research_domains_pkey; Type: CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.erc_research_domains
    ADD CONSTRAINT erc_research_domains_pkey PRIMARY KEY (code);


--
-- Name: eu_territorial_units eu_territorial_units_pkey; Type: CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.eu_territorial_units
    ADD CONSTRAINT eu_territorial_units_pkey PRIMARY KEY (geocode_regions);


--
-- Name: funding_schemes funding_schemes_pkey; Type: CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.funding_schemes
    ADD CONSTRAINT funding_schemes_pkey PRIMARY KEY (code);


--
-- Name: institutions institutions_pkey; Type: CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.institutions
    ADD CONSTRAINT institutions_pkey PRIMARY KEY (unics_id);


--
-- Name: people people_pkey; Type: CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.people
    ADD CONSTRAINT people_pkey PRIMARY KEY (unics_id);


--
-- Name: programmes programmes_pkey; Type: CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.programmes
    ADD CONSTRAINT programmes_pkey PRIMARY KEY (code);


--
-- Name: project_erc_panels project_erc_panels_pkey; Type: CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.project_erc_panels
    ADD CONSTRAINT project_erc_panels_pkey PRIMARY KEY (project);


--
-- Name: project_member_roles project_member_roles_pkey; Type: CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.project_member_roles
    ADD CONSTRAINT project_member_roles_pkey PRIMARY KEY (code);


--
-- Name: project_members project_members_pkey; Type: CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.project_members
    ADD CONSTRAINT project_members_pkey PRIMARY KEY (unics_id);


--
-- Name: project_programmes project_programmes_pkey; Type: CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.project_programmes
    ADD CONSTRAINT project_programmes_pkey PRIMARY KEY (project, programme);


--
-- Name: project_subject_areas project_subject_areas_pkey; Type: CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.project_subject_areas
    ADD CONSTRAINT project_subject_areas_pkey PRIMARY KEY (project, subject_area);


--
-- Name: project_topics project_topics_pkey; Type: CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.project_topics
    ADD CONSTRAINT project_topics_pkey PRIMARY KEY (project, topic);


--
-- Name: projects projects_cordis_ref_key; Type: CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.projects
    ADD CONSTRAINT projects_cordis_ref_key UNIQUE (cordis_ref);


--
-- Name: projects projects_ec_ref_key; Type: CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.projects
    ADD CONSTRAINT projects_ec_ref_key UNIQUE (ec_ref);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (unics_id);


--
-- Name: subject_areas subject_areas_pkey; Type: CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.subject_areas
    ADD CONSTRAINT subject_areas_pkey PRIMARY KEY (code);


--
-- Name: topics topics_pkey; Type: CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.topics
    ADD CONSTRAINT topics_pkey PRIMARY KEY (code);


--
-- Name: activity_types_code_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX activity_types_code_gist_idx ON unics_cordis.activity_types USING gist (code public.gist_trgm_ops);


--
-- Name: activity_types_description_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX activity_types_description_gist_idx ON unics_cordis.activity_types USING gist (description public.gist_trgm_ops);


--
-- Name: countries_country_code2_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX countries_country_code2_gist_idx ON unics_cordis.countries USING gist (country_code2 public.gist_trgm_ops);


--
-- Name: countries_country_code3_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX countries_country_code3_gist_idx ON unics_cordis.countries USING gist (country_code3 public.gist_trgm_ops);


--
-- Name: countries_country_name_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX countries_country_name_gist_idx ON unics_cordis.countries USING gist (country_name public.gist_trgm_ops);


--
-- Name: countries_geocode_country_code_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX countries_geocode_country_code_gist_idx ON unics_cordis.countries USING gist (geocode_country_code public.gist_trgm_ops);


--
-- Name: ec_framework_programs_ec_framework_program_name_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX ec_framework_programs_ec_framework_program_name_gist_idx ON unics_cordis.ec_framework_programs USING gist (ec_framework_program_name public.gist_trgm_ops);


--
-- Name: erc_calls_ec_call_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE UNIQUE INDEX erc_calls_ec_call_idx ON unics_cordis.erc_calls USING btree (ec_call);


--
-- Name: erc_grants_code_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE UNIQUE INDEX erc_grants_code_idx ON unics_cordis.erc_grants USING btree (code);


--
-- Name: erc_grants_name_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE UNIQUE INDEX erc_grants_name_idx ON unics_cordis.erc_grants USING btree (name);


--
-- Name: erc_panels_code_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX erc_panels_code_gist_idx ON unics_cordis.erc_panels USING gist (code public.gist_trgm_ops);


--
-- Name: erc_panels_description_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX erc_panels_description_gist_idx ON unics_cordis.erc_panels USING gist (description public.gist_trgm_ops);


--
-- Name: erc_panels_part_of_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX erc_panels_part_of_gist_idx ON unics_cordis.erc_panels USING gist (part_of public.gist_trgm_ops);


--
-- Name: erc_research_domains_code_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX erc_research_domains_code_gist_idx ON unics_cordis.erc_research_domains USING gist (code public.gist_trgm_ops);


--
-- Name: erc_research_domains_description_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX erc_research_domains_description_gist_idx ON unics_cordis.erc_research_domains USING gist (description public.gist_trgm_ops);


--
-- Name: eu_territorial_units_description_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX eu_territorial_units_description_gist_idx ON unics_cordis.eu_territorial_units USING gist (description public.gist_trgm_ops);


--
-- Name: eu_territorial_units_geocode_regions_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX eu_territorial_units_geocode_regions_gist_idx ON unics_cordis.eu_territorial_units USING gist (geocode_regions public.gist_trgm_ops);


--
-- Name: eu_territorial_units_nuts_version_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX eu_territorial_units_nuts_version_gist_idx ON unics_cordis.eu_territorial_units USING gist (nuts_version public.gist_trgm_ops);


--
-- Name: funding_schemes_code_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX funding_schemes_code_gist_idx ON unics_cordis.funding_schemes USING gist (code public.gist_trgm_ops);


--
-- Name: funding_schemes_title_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX funding_schemes_title_gist_idx ON unics_cordis.funding_schemes USING gist (title public.gist_trgm_ops);


--
-- Name: institutions_acronym_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX institutions_acronym_gist_idx ON unics_cordis.institutions USING gist (acronym public.gist_trgm_ops);


--
-- Name: institutions_db_pedia_url_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX institutions_db_pedia_url_gist_idx ON unics_cordis.institutions USING gist (db_pedia_url public.gist_trgm_ops);


--
-- Name: institutions_geocode_regions_3_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX institutions_geocode_regions_3_gist_idx ON unics_cordis.institutions USING gist (geocode_regions_3 public.gist_trgm_ops);


--
-- Name: institutions_grid_id_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX institutions_grid_id_gist_idx ON unics_cordis.institutions USING gist (grid_id public.gist_trgm_ops);


--
-- Name: institutions_institutions_name_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX institutions_institutions_name_gist_idx ON unics_cordis.institutions USING gist (institutions_name public.gist_trgm_ops);


--
-- Name: institutions_short_name_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX institutions_short_name_gist_idx ON unics_cordis.institutions USING gist (short_name public.gist_trgm_ops);


--
-- Name: institutions_website_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX institutions_website_gist_idx ON unics_cordis.institutions USING gist (website public.gist_trgm_ops);


--
-- Name: institutions_wikidata_url_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX institutions_wikidata_url_gist_idx ON unics_cordis.institutions USING gist (wikidata_url public.gist_trgm_ops);


--
-- Name: nuts_hierarchy_nuts_3_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE UNIQUE INDEX nuts_hierarchy_nuts_3_idx ON unics_cordis.nuts_hierarchy USING btree (nuts_3);


--
-- Name: people_full_name_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX people_full_name_gist_idx ON unics_cordis.people USING gist (full_name public.gist_trgm_ops);


--
-- Name: programmes_code_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX programmes_code_gist_idx ON unics_cordis.programmes USING gist (code public.gist_trgm_ops);


--
-- Name: programmes_parent_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX programmes_parent_gist_idx ON unics_cordis.programmes USING gist (parent public.gist_trgm_ops);


--
-- Name: programmes_rcn_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX programmes_rcn_gist_idx ON unics_cordis.programmes USING gist (rcn public.gist_trgm_ops);


--
-- Name: programmes_short_name_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX programmes_short_name_gist_idx ON unics_cordis.programmes USING gist (short_name public.gist_trgm_ops);


--
-- Name: programmes_title_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX programmes_title_gist_idx ON unics_cordis.programmes USING gist (title public.gist_trgm_ops);


--
-- Name: project_erc_panels_panel_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX project_erc_panels_panel_gist_idx ON unics_cordis.project_erc_panels USING gist (panel public.gist_trgm_ops);


--
-- Name: project_member_roles_code_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX project_member_roles_code_gist_idx ON unics_cordis.project_member_roles USING gist (code public.gist_trgm_ops);


--
-- Name: project_member_roles_description_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX project_member_roles_description_gist_idx ON unics_cordis.project_member_roles USING gist (description public.gist_trgm_ops);


--
-- Name: project_members_activity_type_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX project_members_activity_type_gist_idx ON unics_cordis.project_members USING gist (activity_type public.gist_trgm_ops);


--
-- Name: project_members_city_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX project_members_city_gist_idx ON unics_cordis.project_members USING gist (city public.gist_trgm_ops);


--
-- Name: project_members_country_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX project_members_country_gist_idx ON unics_cordis.project_members USING gist (country public.gist_trgm_ops);


--
-- Name: project_members_department_name_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX project_members_department_name_gist_idx ON unics_cordis.project_members USING gist (department_name public.gist_trgm_ops);


--
-- Name: project_members_geocode_regions_3_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX project_members_geocode_regions_3_gist_idx ON unics_cordis.project_members USING gist (geocode_regions_3 public.gist_trgm_ops);


--
-- Name: project_members_institution_id_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX project_members_institution_id_idx ON unics_cordis.project_members USING btree (institution_id);


--
-- Name: project_members_member_name_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX project_members_member_name_gist_idx ON unics_cordis.project_members USING gist (member_name public.gist_trgm_ops);


--
-- Name: project_members_member_role_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX project_members_member_role_gist_idx ON unics_cordis.project_members USING gist (member_role public.gist_trgm_ops);


--
-- Name: project_members_member_short_name_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX project_members_member_short_name_gist_idx ON unics_cordis.project_members USING gist (member_short_name public.gist_trgm_ops);


--
-- Name: project_members_pic_number_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX project_members_pic_number_gist_idx ON unics_cordis.project_members USING gist (pic_number public.gist_trgm_ops);


--
-- Name: project_members_postal_code_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX project_members_postal_code_gist_idx ON unics_cordis.project_members USING gist (postal_code public.gist_trgm_ops);


--
-- Name: project_members_rcn_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX project_members_rcn_gist_idx ON unics_cordis.project_members USING gist (rcn public.gist_trgm_ops);


--
-- Name: project_members_street_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX project_members_street_gist_idx ON unics_cordis.project_members USING gist (street public.gist_trgm_ops);


--
-- Name: project_members_vat_number_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX project_members_vat_number_gist_idx ON unics_cordis.project_members USING gist (vat_number public.gist_trgm_ops);


--
-- Name: project_programmes_programme_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX project_programmes_programme_gist_idx ON unics_cordis.project_programmes USING gist (programme public.gist_trgm_ops);


--
-- Name: project_subject_areas_subject_area_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX project_subject_areas_subject_area_gist_idx ON unics_cordis.project_subject_areas USING gist (subject_area public.gist_trgm_ops);


--
-- Name: project_topics_topic_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX project_topics_topic_gist_idx ON unics_cordis.project_topics USING gist (topic public.gist_trgm_ops);


--
-- Name: projects_acronym_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX projects_acronym_gist_idx ON unics_cordis.projects USING gist (acronym public.gist_trgm_ops);


--
-- Name: projects_cordis_ref_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX projects_cordis_ref_gist_idx ON unics_cordis.projects USING gist (cordis_ref public.gist_trgm_ops);


--
-- Name: projects_ec_call_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX projects_ec_call_gist_idx ON unics_cordis.projects USING gist (ec_call public.gist_trgm_ops);


--
-- Name: projects_ec_fund_scheme_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX projects_ec_fund_scheme_gist_idx ON unics_cordis.projects USING gist (ec_fund_scheme public.gist_trgm_ops);


--
-- Name: projects_ec_ref_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX projects_ec_ref_gist_idx ON unics_cordis.projects USING gist (ec_ref public.gist_trgm_ops);


--
-- Name: projects_framework_program_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX projects_framework_program_gist_idx ON unics_cordis.projects USING gist (framework_program public.gist_trgm_ops);


--
-- Name: projects_homepage_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX projects_homepage_gist_idx ON unics_cordis.projects USING gist (homepage public.gist_trgm_ops);


--
-- Name: projects_objective_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX projects_objective_gist_idx ON unics_cordis.projects USING gist (objective public.gist_trgm_ops);


--
-- Name: projects_title_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX projects_title_gist_idx ON unics_cordis.projects USING gist (title public.gist_trgm_ops);


--
-- Name: subject_areas_code_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX subject_areas_code_gist_idx ON unics_cordis.subject_areas USING gist (code public.gist_trgm_ops);


--
-- Name: subject_areas_description_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX subject_areas_description_gist_idx ON unics_cordis.subject_areas USING gist (description public.gist_trgm_ops);


--
-- Name: subject_areas_title_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX subject_areas_title_gist_idx ON unics_cordis.subject_areas USING gist (title public.gist_trgm_ops);


--
-- Name: topics_code_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX topics_code_gist_idx ON unics_cordis.topics USING gist (code public.gist_trgm_ops);


--
-- Name: topics_rcn_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX topics_rcn_gist_idx ON unics_cordis.topics USING gist (rcn public.gist_trgm_ops);


--
-- Name: topics_title_gist_idx; Type: INDEX; Schema: unics_cordis; Owner: postgres
--

CREATE INDEX topics_title_gist_idx ON unics_cordis.topics USING gist (title public.gist_trgm_ops);


--
-- Name: erc_panels erc_panels_part_of_fkey; Type: FK CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.erc_panels
    ADD CONSTRAINT erc_panels_part_of_fkey FOREIGN KEY (part_of) REFERENCES unics_cordis.erc_research_domains(code) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: institutions institutions_countries_unics_id_fk; Type: FK CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.institutions
    ADD CONSTRAINT institutions_countries_unics_id_fk FOREIGN KEY (country_id) REFERENCES unics_cordis.countries(unics_id);


--
-- Name: institutions institutions_geocode_regions_3_fkey; Type: FK CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.institutions
    ADD CONSTRAINT institutions_geocode_regions_3_fkey FOREIGN KEY (geocode_regions_3) REFERENCES unics_cordis.eu_territorial_units(geocode_regions) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: programmes programmes_parent_fkey; Type: FK CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.programmes
    ADD CONSTRAINT programmes_parent_fkey FOREIGN KEY (parent) REFERENCES unics_cordis.programmes(code) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: project_erc_panels project_erc_panels_panel_fkey; Type: FK CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.project_erc_panels
    ADD CONSTRAINT project_erc_panels_panel_fkey FOREIGN KEY (panel) REFERENCES unics_cordis.erc_panels(code) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: project_erc_panels project_erc_panels_project_fkey; Type: FK CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.project_erc_panels
    ADD CONSTRAINT project_erc_panels_project_fkey FOREIGN KEY (project) REFERENCES unics_cordis.projects(unics_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: project_members project_members_activity_type_fkey; Type: FK CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.project_members
    ADD CONSTRAINT project_members_activity_type_fkey FOREIGN KEY (activity_type) REFERENCES unics_cordis.activity_types(code) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: project_members project_members_institutions_unics_id_fk; Type: FK CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.project_members
    ADD CONSTRAINT project_members_institutions_unics_id_fk FOREIGN KEY (institution_id) REFERENCES unics_cordis.institutions(unics_id);


--
-- Name: project_members project_members_member_role_fkey; Type: FK CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.project_members
    ADD CONSTRAINT project_members_member_role_fkey FOREIGN KEY (member_role) REFERENCES unics_cordis.project_member_roles(code);


--
-- Name: project_members project_members_nuts3_code_fkey; Type: FK CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.project_members
    ADD CONSTRAINT project_members_nuts3_code_fkey FOREIGN KEY (geocode_regions_3) REFERENCES unics_cordis.eu_territorial_units(geocode_regions) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: project_members project_members_project_fkey; Type: FK CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.project_members
    ADD CONSTRAINT project_members_project_fkey FOREIGN KEY (project) REFERENCES unics_cordis.projects(unics_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: project_programmes project_programmes_programme_fkey; Type: FK CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.project_programmes
    ADD CONSTRAINT project_programmes_programme_fkey FOREIGN KEY (programme) REFERENCES unics_cordis.programmes(code) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: project_programmes project_programmes_project_fkey; Type: FK CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.project_programmes
    ADD CONSTRAINT project_programmes_project_fkey FOREIGN KEY (project) REFERENCES unics_cordis.projects(unics_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: project_subject_areas project_subject_areas_project_fkey; Type: FK CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.project_subject_areas
    ADD CONSTRAINT project_subject_areas_project_fkey FOREIGN KEY (project) REFERENCES unics_cordis.projects(unics_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: project_subject_areas project_subject_areas_subject_area_fkey; Type: FK CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.project_subject_areas
    ADD CONSTRAINT project_subject_areas_subject_area_fkey FOREIGN KEY (subject_area) REFERENCES unics_cordis.subject_areas(code) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: project_topics project_topics_project_fkey; Type: FK CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.project_topics
    ADD CONSTRAINT project_topics_project_fkey FOREIGN KEY (project) REFERENCES unics_cordis.projects(unics_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: project_topics project_topics_topic_fkey; Type: FK CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.project_topics
    ADD CONSTRAINT project_topics_topic_fkey FOREIGN KEY (topic) REFERENCES unics_cordis.topics(code) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: projects projects_ec_fund_scheme_fkey; Type: FK CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.projects
    ADD CONSTRAINT projects_ec_fund_scheme_fkey FOREIGN KEY (ec_fund_scheme) REFERENCES unics_cordis.funding_schemes(code) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: projects projects_framework_program_fkey; Type: FK CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.projects
    ADD CONSTRAINT projects_framework_program_fkey FOREIGN KEY (framework_program) REFERENCES unics_cordis.ec_framework_programs(ec_framework_program_name) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: projects projects_principal_investigator_fkey; Type: FK CONSTRAINT; Schema: unics_cordis; Owner: postgres
--

ALTER TABLE ONLY unics_cordis.projects
    ADD CONSTRAINT projects_principal_investigator_fkey FOREIGN KEY (principal_investigator) REFERENCES unics_cordis.people(unics_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: DATABASE cordis_temporary; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON DATABASE cordis_temporary FROM PUBLIC;
REVOKE ALL ON DATABASE cordis_temporary FROM postgres;
GRANT ALL ON DATABASE cordis_temporary TO postgres;
GRANT CONNECT,TEMPORARY ON DATABASE cordis_temporary TO PUBLIC;

--
-- Name: SCHEMA unics_cordis; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA unics_cordis FROM PUBLIC;
REVOKE ALL ON SCHEMA unics_cordis FROM postgres;
GRANT ALL ON SCHEMA unics_cordis TO postgres;

--
-- Name: TABLE activity_types; Type: ACL; Schema: unics_cordis; Owner: postgres
--

REVOKE ALL ON TABLE unics_cordis.activity_types FROM PUBLIC;
REVOKE ALL ON TABLE unics_cordis.activity_types FROM postgres;
GRANT ALL ON TABLE unics_cordis.activity_types TO postgres;

--
-- Name: TABLE countries; Type: ACL; Schema: unics_cordis; Owner: postgres
--

REVOKE ALL ON TABLE unics_cordis.countries FROM PUBLIC;
REVOKE ALL ON TABLE unics_cordis.countries FROM postgres;
GRANT ALL ON TABLE unics_cordis.countries TO postgres;

--
-- Name: TABLE ec_framework_programs; Type: ACL; Schema: unics_cordis; Owner: postgres
--

REVOKE ALL ON TABLE unics_cordis.ec_framework_programs FROM PUBLIC;
REVOKE ALL ON TABLE unics_cordis.ec_framework_programs FROM postgres;
GRANT ALL ON TABLE unics_cordis.ec_framework_programs TO postgres;

--
-- Name: TABLE projects; Type: ACL; Schema: unics_cordis; Owner: postgres
--

REVOKE ALL ON TABLE unics_cordis.projects FROM PUBLIC;
REVOKE ALL ON TABLE unics_cordis.projects FROM postgres;
GRANT ALL ON TABLE unics_cordis.projects TO postgres;

--
-- Name: TABLE erc_calls; Type: ACL; Schema: unics_cordis; Owner: postgres
--

REVOKE ALL ON TABLE unics_cordis.erc_calls FROM PUBLIC;
REVOKE ALL ON TABLE unics_cordis.erc_calls FROM postgres;
GRANT ALL ON TABLE unics_cordis.erc_calls TO postgres;

--
-- Name: TABLE erc_grants; Type: ACL; Schema: unics_cordis; Owner: postgres
--

REVOKE ALL ON TABLE unics_cordis.erc_grants FROM PUBLIC;
REVOKE ALL ON TABLE unics_cordis.erc_grants FROM postgres;
GRANT ALL ON TABLE unics_cordis.erc_grants TO postgres;

--
-- Name: TABLE erc_panels; Type: ACL; Schema: unics_cordis; Owner: postgres
--

REVOKE ALL ON TABLE unics_cordis.erc_panels FROM PUBLIC;
REVOKE ALL ON TABLE unics_cordis.erc_panels FROM postgres;
GRANT ALL ON TABLE unics_cordis.erc_panels TO postgres;

--
-- Name: TABLE erc_research_domains; Type: ACL; Schema: unics_cordis; Owner: postgres
--

REVOKE ALL ON TABLE unics_cordis.erc_research_domains FROM PUBLIC;
REVOKE ALL ON TABLE unics_cordis.erc_research_domains FROM postgres;
GRANT ALL ON TABLE unics_cordis.erc_research_domains TO postgres;

--
-- Name: TABLE eu_territorial_units; Type: ACL; Schema: unics_cordis; Owner: postgres
--

REVOKE ALL ON TABLE unics_cordis.eu_territorial_units FROM PUBLIC;
REVOKE ALL ON TABLE unics_cordis.eu_territorial_units FROM postgres;
GRANT ALL ON TABLE unics_cordis.eu_territorial_units TO postgres;

--
-- Name: TABLE funding_schemes; Type: ACL; Schema: unics_cordis; Owner: postgres
--

REVOKE ALL ON TABLE unics_cordis.funding_schemes FROM PUBLIC;
REVOKE ALL ON TABLE unics_cordis.funding_schemes FROM postgres;
GRANT ALL ON TABLE unics_cordis.funding_schemes TO postgres;

--
-- Name: TABLE institutions; Type: ACL; Schema: unics_cordis; Owner: postgres
--

REVOKE ALL ON TABLE unics_cordis.institutions FROM PUBLIC;
REVOKE ALL ON TABLE unics_cordis.institutions FROM postgres;
GRANT ALL ON TABLE unics_cordis.institutions TO postgres;

--
-- Name: TABLE nuts_hierarchy; Type: ACL; Schema: unics_cordis; Owner: postgres
--

REVOKE ALL ON TABLE unics_cordis.nuts_hierarchy FROM PUBLIC;
REVOKE ALL ON TABLE unics_cordis.nuts_hierarchy FROM postgres;
GRANT ALL ON TABLE unics_cordis.nuts_hierarchy TO postgres;

--
-- Name: TABLE people; Type: ACL; Schema: unics_cordis; Owner: postgres
--

REVOKE ALL ON TABLE unics_cordis.people FROM PUBLIC;
REVOKE ALL ON TABLE unics_cordis.people FROM postgres;
GRANT ALL ON TABLE unics_cordis.people TO postgres;

--
-- Name: TABLE programmes; Type: ACL; Schema: unics_cordis; Owner: postgres
--

REVOKE ALL ON TABLE unics_cordis.programmes FROM PUBLIC;
REVOKE ALL ON TABLE unics_cordis.programmes FROM postgres;
GRANT ALL ON TABLE unics_cordis.programmes TO postgres;

--
-- Name: TABLE programme_partof_programme; Type: ACL; Schema: unics_cordis; Owner: postgres
--

REVOKE ALL ON TABLE unics_cordis.programme_partof_programme FROM PUBLIC;
REVOKE ALL ON TABLE unics_cordis.programme_partof_programme FROM postgres;
GRANT ALL ON TABLE unics_cordis.programme_partof_programme TO postgres;

--
-- Name: TABLE project_erc_panels; Type: ACL; Schema: unics_cordis; Owner: postgres
--

REVOKE ALL ON TABLE unics_cordis.project_erc_panels FROM PUBLIC;
REVOKE ALL ON TABLE unics_cordis.project_erc_panels FROM postgres;
GRANT ALL ON TABLE unics_cordis.project_erc_panels TO postgres;

--
-- Name: TABLE project_member_roles; Type: ACL; Schema: unics_cordis; Owner: postgres
--

REVOKE ALL ON TABLE unics_cordis.project_member_roles FROM PUBLIC;
REVOKE ALL ON TABLE unics_cordis.project_member_roles FROM postgres;
GRANT ALL ON TABLE unics_cordis.project_member_roles TO postgres;

--
-- Name: TABLE project_members; Type: ACL; Schema: unics_cordis; Owner: postgres
--

REVOKE ALL ON TABLE unics_cordis.project_members FROM PUBLIC;
REVOKE ALL ON TABLE unics_cordis.project_members FROM postgres;
GRANT ALL ON TABLE unics_cordis.project_members TO postgres;

--
-- Name: TABLE project_programmes; Type: ACL; Schema: unics_cordis; Owner: postgres
--

REVOKE ALL ON TABLE unics_cordis.project_programmes FROM PUBLIC;
REVOKE ALL ON TABLE unics_cordis.project_programmes FROM postgres;
GRANT ALL ON TABLE unics_cordis.project_programmes TO postgres;

--
-- Name: TABLE project_subject_areas; Type: ACL; Schema: unics_cordis; Owner: postgres
--

REVOKE ALL ON TABLE unics_cordis.project_subject_areas FROM PUBLIC;
REVOKE ALL ON TABLE unics_cordis.project_subject_areas FROM postgres;
GRANT ALL ON TABLE unics_cordis.project_subject_areas TO postgres;

--
-- Name: TABLE project_topics; Type: ACL; Schema: unics_cordis; Owner: postgres
--

REVOKE ALL ON TABLE unics_cordis.project_topics FROM PUBLIC;
REVOKE ALL ON TABLE unics_cordis.project_topics FROM postgres;
GRANT ALL ON TABLE unics_cordis.project_topics TO postgres;

--
-- Name: TABLE subject_areas; Type: ACL; Schema: unics_cordis; Owner: postgres
--

REVOKE ALL ON TABLE unics_cordis.subject_areas FROM PUBLIC;
REVOKE ALL ON TABLE unics_cordis.subject_areas FROM postgres;
GRANT ALL ON TABLE unics_cordis.subject_areas TO postgres;

--
-- Name: TABLE topics; Type: ACL; Schema: unics_cordis; Owner: postgres
--

REVOKE ALL ON TABLE unics_cordis.topics FROM PUBLIC;
REVOKE ALL ON TABLE unics_cordis.topics FROM postgres;
GRANT ALL ON TABLE unics_cordis.topics TO postgres;

--
-- Name: erc_calls; Type: MATERIALIZED VIEW DATA; Schema: unics_cordis; Owner: postgres
--

REFRESH MATERIALIZED VIEW unics_cordis.erc_calls;


--
-- Name: erc_grants; Type: MATERIALIZED VIEW DATA; Schema: unics_cordis; Owner: postgres
--

REFRESH MATERIALIZED VIEW unics_cordis.erc_grants;


--
-- Name: nuts_hierarchy; Type: MATERIALIZED VIEW DATA; Schema: unics_cordis; Owner: postgres
--

REFRESH MATERIALIZED VIEW unics_cordis.nuts_hierarchy;


--
-- Name: programme_partof_programme; Type: MATERIALIZED VIEW DATA; Schema: unics_cordis; Owner: postgres
--

REFRESH MATERIALIZED VIEW unics_cordis.programme_partof_programme;


--
-- PostgreSQL database dump complete
--

