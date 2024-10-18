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

DROP DATABASE IF EXISTS skyserver_dr16_2020_11_30;
--
-- Name: skyserver_dr16_2020_11_30; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE skyserver_dr16_2020_11_30 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE skyserver_dr16_2020_11_30 OWNER TO postgres;

\connect skyserver_dr16_2020_11_30

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
-- Name: lite; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA lite;

ALTER SCHEMA lite OWNER TO postgres;

CREATE EXTENSION IF NOT EXISTS pg_trgm SCHEMA lite;

SET default_tablespace = '';

--
-- Name: galspecline; Type: TABLE; Schema: lite; Owner: postgres
--

CREATE TABLE lite.galspecline (
    specobjid numeric(20,0) NOT NULL
);


ALTER TABLE lite.galspecline OWNER TO postgres;

--
-- Name: neighbors; Type: TABLE; Schema: lite; Owner: postgres
--

CREATE TABLE lite.neighbors (
    objid bigint,
    neighborobjid bigint,
    distance double precision,
    type smallint,
    neighbortype smallint,
    mode smallint,
    neighbormode smallint
);


ALTER TABLE lite.neighbors OWNER TO postgres;

--
-- Name: photo_type; Type: TABLE; Schema: lite; Owner: postgres
--

CREATE TABLE lite.photo_type (
    value integer NOT NULL,
    name character varying,
    description text
);


ALTER TABLE lite.photo_type OWNER TO postgres;

--
-- Name: photoobj; Type: TABLE; Schema: lite; Owner: postgres
--

CREATE TABLE lite.photoobj (
    objid bigint NOT NULL,
    run smallint,
    rerun smallint,
    field smallint,
    mode smallint,
    type smallint,
    clean integer,
    flags bigint,
    rowc real,
    colc real,
    cmodelmag_u real,
    cmodelmag_g real,
    cmodelmag_r real,
    ra double precision,
    "dec" double precision,
    b double precision,
    l double precision,
    extinction_r real,
    mjd integer,
    loadversion integer,
    u real,
    g real,
    r real,
    i real,
    z real
);


ALTER TABLE lite.photoobj OWNER TO postgres;

--
-- Name: specobj; Type: TABLE; Schema: lite; Owner: postgres
--

CREATE TABLE lite.specobj (
    specobjid numeric(20,0) NOT NULL,
    bestobjid bigint,
    plateid numeric(20,0),
    scienceprimary smallint,
    segue2primary smallint,
    survey character varying(32),
    programname character varying(32),
    mjd integer,
    plate smallint,
    fiberid smallint,
    special_target1 bigint,
    segue2_target1 bigint,
    segue2_target2 bigint,
    ancillary_target1 bigint,
    ra double precision,
    "dec" double precision,
    z real,
    zerr real,
    zwarning integer,
    class character varying(32),
    subclass character varying(32),
    veldisp real,
    veldisperr real,
    loadversion integer
);


ALTER TABLE lite.specobj OWNER TO postgres;

--
-- Name: spplines; Type: TABLE; Schema: lite; Owner: postgres
--

CREATE TABLE lite.spplines (
    specobjid numeric(20,0) NOT NULL
);


ALTER TABLE lite.spplines OWNER TO postgres;

--
-- Data for Name: galspecline; Type: TABLE DATA; Schema: lite; Owner: postgres
--

\copy lite.galspecline (specobjid) FROM stdin;
\.
\copy lite.galspecline (specobjid) FROM '$$PATH$$/2267.dat';

--
-- Data for Name: neighbors; Type: TABLE DATA; Schema: lite; Owner: postgres
--

\copy lite.neighbors (objid, neighborobjid, distance, type, neighbortype, mode, neighbormode) FROM stdin;
\.
\copy lite.neighbors (objid, neighborobjid, distance, type, neighbortype, mode, neighbormode) FROM '$$PATH$$/2263.dat';

--
-- Data for Name: photo_type; Type: TABLE DATA; Schema: lite; Owner: postgres
--

\copy lite.photo_type (value, name, description) FROM stdin;
\.
\copy lite.photo_type (value, name, description) FROM '$$PATH$$/2262.dat';

--
-- Data for Name: photoobj; Type: TABLE DATA; Schema: lite; Owner: postgres
--

\copy lite.photoobj (objid, run, rerun, field, mode, type, clean, flags, rowc, colc, cmodelmag_u, cmodelmag_g, cmodelmag_r, ra, "dec", b, l, extinction_r, mjd, loadversion, u, g, r, i, z) FROM stdin;
\.
\copy lite.photoobj (objid, run, rerun, field, mode, type, clean, flags, rowc, colc, cmodelmag_u, cmodelmag_g, cmodelmag_r, ra, "dec", b, l, extinction_r, mjd, loadversion, u, g, r, i, z) FROM '$$PATH$$/2265.dat';

--
-- Data for Name: specobj; Type: TABLE DATA; Schema: lite; Owner: postgres
--

\copy lite.specobj (specobjid, bestobjid, plateid, scienceprimary, segue2primary, survey, programname, mjd, plate, fiberid, special_target1, segue2_target1, segue2_target2, ancillary_target1, ra, "dec", z, zerr, zwarning, class, subclass, veldisp, veldisperr, loadversion) FROM stdin;
\.
\copy lite.specobj (specobjid, bestobjid, plateid, scienceprimary, segue2primary, survey, programname, mjd, plate, fiberid, special_target1, segue2_target1, segue2_target2, ancillary_target1, ra, "dec", z, zerr, zwarning, class, subclass, veldisp, veldisperr, loadversion) FROM '$$PATH$$/2266.dat';

--
-- Data for Name: spplines; Type: TABLE DATA; Schema: lite; Owner: postgres
--

\copy lite.spplines (specobjid) FROM stdin;
\.
\copy lite.spplines (specobjid) FROM '$$PATH$$/2264.dat';

--
-- Name: galspecline galspecline_pk; Type: CONSTRAINT; Schema: lite; Owner: postgres
--

ALTER TABLE ONLY lite.galspecline
    ADD CONSTRAINT galspecline_pk PRIMARY KEY (specobjid);


--
-- Name: photo_type photo_type_pk; Type: CONSTRAINT; Schema: lite; Owner: postgres
--

ALTER TABLE ONLY lite.photo_type
    ADD CONSTRAINT photo_type_pk PRIMARY KEY (value);


--
-- Name: photoobj photoobj_pk; Type: CONSTRAINT; Schema: lite; Owner: postgres
--

ALTER TABLE ONLY lite.photoobj
    ADD CONSTRAINT photoobj_pk PRIMARY KEY (objid);


--
-- Name: specobj specobj_pk; Type: CONSTRAINT; Schema: lite; Owner: postgres
--

ALTER TABLE ONLY lite.specobj
    ADD CONSTRAINT specobj_pk PRIMARY KEY (specobjid);


--
-- Name: spplines spplines_pk; Type: CONSTRAINT; Schema: lite; Owner: postgres
--

ALTER TABLE ONLY lite.spplines
    ADD CONSTRAINT spplines_pk PRIMARY KEY (specobjid);


--
-- Name: galspecline fk_galspecline; Type: FK CONSTRAINT; Schema: lite; Owner: postgres
--

ALTER TABLE ONLY lite.galspecline
    ADD CONSTRAINT fk_galspecline FOREIGN KEY (specobjid) REFERENCES lite.specobj(specobjid);


--
-- Name: neighbors fk_neighbors; Type: FK CONSTRAINT; Schema: lite; Owner: postgres
--

ALTER TABLE ONLY lite.neighbors
    ADD CONSTRAINT fk_neighbors FOREIGN KEY (objid) REFERENCES lite.photoobj(objid);


--
-- Name: specobj fk_specobj; Type: FK CONSTRAINT; Schema: lite; Owner: postgres
--

ALTER TABLE ONLY lite.specobj
    ADD CONSTRAINT fk_specobj FOREIGN KEY (bestobjid) REFERENCES lite.photoobj(objid);


--
-- Name: spplines fk_spplines; Type: FK CONSTRAINT; Schema: lite; Owner: postgres
--

ALTER TABLE ONLY lite.spplines
    ADD CONSTRAINT fk_spplines FOREIGN KEY (specobjid) REFERENCES lite.specobj(specobjid);


--
-- Name: photoobj photoobj__photo_type_value_fk; Type: FK CONSTRAINT; Schema: lite; Owner: postgres
--

ALTER TABLE ONLY lite.photoobj
    ADD CONSTRAINT photoobj__photo_type_value_fk FOREIGN KEY (type) REFERENCES lite.photo_type(value);


--
-- Name: DATABASE skyserver_dr16_2020_11_30; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON DATABASE skyserver_dr16_2020_11_30 FROM PUBLIC;
REVOKE ALL ON DATABASE skyserver_dr16_2020_11_30 FROM postgres;
GRANT ALL ON DATABASE skyserver_dr16_2020_11_30 TO postgres;

--
-- Name: SCHEMA lite; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA lite FROM PUBLIC;
REVOKE ALL ON SCHEMA lite FROM postgres;
GRANT ALL ON SCHEMA lite TO postgres;

--
-- Name: TABLE galspecline; Type: ACL; Schema: lite; Owner: postgres
--

REVOKE ALL ON TABLE lite.galspecline FROM PUBLIC;
REVOKE ALL ON TABLE lite.galspecline FROM postgres;
GRANT ALL ON TABLE lite.galspecline TO postgres;

--
-- Name: TABLE neighbors; Type: ACL; Schema: lite; Owner: postgres
--

REVOKE ALL ON TABLE lite.neighbors FROM PUBLIC;
REVOKE ALL ON TABLE lite.neighbors FROM postgres;
GRANT ALL ON TABLE lite.neighbors TO postgres;

--
-- Name: TABLE photo_type; Type: ACL; Schema: lite; Owner: postgres
--

REVOKE ALL ON TABLE lite.photo_type FROM PUBLIC;
REVOKE ALL ON TABLE lite.photo_type FROM postgres;
GRANT ALL ON TABLE lite.photo_type TO postgres;

--
-- Name: TABLE photoobj; Type: ACL; Schema: lite; Owner: postgres
--

REVOKE ALL ON TABLE lite.photoobj FROM PUBLIC;
REVOKE ALL ON TABLE lite.photoobj FROM postgres;
GRANT ALL ON TABLE lite.photoobj TO postgres;

--
-- Name: TABLE specobj; Type: ACL; Schema: lite; Owner: postgres
--

REVOKE ALL ON TABLE lite.specobj FROM PUBLIC;
REVOKE ALL ON TABLE lite.specobj FROM postgres;
GRANT ALL ON TABLE lite.specobj TO postgres;

--
-- Name: TABLE spplines; Type: ACL; Schema: lite; Owner: postgres
--

REVOKE ALL ON TABLE lite.spplines FROM PUBLIC;
REVOKE ALL ON TABLE lite.spplines FROM postgres;
GRANT ALL ON TABLE lite.spplines TO postgres;

--
-- PostgreSQL database dump complete
--

