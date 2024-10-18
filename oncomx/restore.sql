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

DROP DATABASE IF EXISTS oncomx_v1_0_25_small;
--
-- Name: oncomx_v1_0_25_small; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE oncomx_v1_0_25_small WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE oncomx_v1_0_25_small OWNER TO postgres;

\connect oncomx_v1_0_25_small

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
-- Name: DATABASE oncomx_v1_0_25_small; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE oncomx_v1_0_25_small IS 'A down sampled version of oncomx_v1_0_25 without raw data tables.';


--
-- Name: oncomx_v1_0_25; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA oncomx_v1_0_25;

ALTER SCHEMA oncomx_v1_0_25 OWNER TO postgres;

CREATE EXTENSION IF NOT EXISTS pg_trgm SCHEMA oncomx_v1_0_25;

SET default_tablespace = '';

--
-- Name: anatomical_entity; Type: TABLE; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE TABLE oncomx_v1_0_25.anatomical_entity (
    id character varying(20) NOT NULL,
    name character varying(255),
    description text
);


ALTER TABLE oncomx_v1_0_25.anatomical_entity OWNER TO postgres;

--
-- Name: COLUMN anatomical_entity.name; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.anatomical_entity.name IS 'Anatomical entity name';


--
-- Name: COLUMN anatomical_entity.description; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.anatomical_entity.description IS 'Anatomical entity description';


--
-- Name: biomarker; Type: TABLE; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE TABLE oncomx_v1_0_25.biomarker (
    id character varying(10) DEFAULT '0'::character varying NOT NULL,
    gene_symbol character varying(255),
    biomarker_description text,
    biomarker_id character varying(50),
    test_is_a_panel boolean NOT NULL
);


ALTER TABLE oncomx_v1_0_25.biomarker OWNER TO postgres;

--
-- Name: biomarker_alias; Type: TABLE; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE TABLE oncomx_v1_0_25.biomarker_alias (
    biomarker_internal_id character varying(10) NOT NULL,
    alias character varying(255) NOT NULL
);


ALTER TABLE oncomx_v1_0_25.biomarker_alias OWNER TO postgres;

--
-- Name: COLUMN biomarker_alias.biomarker_internal_id; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.biomarker_alias.biomarker_internal_id IS 'It is an internal identifier for biomarkers (not included originally in the OncoMX dataset), and it might change for each new release. ';


--
-- Name: biomarker_article; Type: TABLE; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE TABLE oncomx_v1_0_25.biomarker_article (
    biomarker_internal_id character varying(10) DEFAULT '0'::character varying NOT NULL,
    pmid character varying(15) NOT NULL
);


ALTER TABLE oncomx_v1_0_25.biomarker_article OWNER TO postgres;

--
-- Name: biomarker_edrn; Type: TABLE; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE TABLE oncomx_v1_0_25.biomarker_edrn (
    id character varying(10) DEFAULT '0'::character varying NOT NULL,
    qa_state character varying(12) NOT NULL,
    biomarker_title character varying(300) NOT NULL,
    biomarker_type character varying(30) NOT NULL,
    uberon_anatomical_id character varying(20) NOT NULL,
    phase character varying(20)
);


ALTER TABLE oncomx_v1_0_25.biomarker_edrn OWNER TO postgres;

--
-- Name: COLUMN biomarker_edrn.id; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.biomarker_edrn.id IS 'It is an internal identifier for biomarkers (not included originally in the OncoMX dataset), and it might change for each new release. ';


--
-- Name: COLUMN biomarker_edrn.qa_state; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.biomarker_edrn.qa_state IS 'It denotes whether biomarker has been accepted, curated or is under review.';


--
-- Name: COLUMN biomarker_edrn.biomarker_title; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.biomarker_edrn.biomarker_title IS 'Early Detection Research Network (EDRN) title.';


--
-- Name: COLUMN biomarker_edrn.biomarker_type; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.biomarker_edrn.biomarker_type IS 'Specifies the type of marker, i.e. Genomic, Proteomic, Gene, or Protein.';


--
-- Name: COLUMN biomarker_edrn.uberon_anatomical_id; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.biomarker_edrn.uberon_anatomical_id IS 'Applicable organ for biomarker.';


--
-- Name: COLUMN biomarker_edrn.phase; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.biomarker_edrn.phase IS 'The phase of biomarker development.';


--
-- Name: biomarker_fda; Type: TABLE; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE TABLE oncomx_v1_0_25.biomarker_fda (
    id character varying(10) DEFAULT '0'::character varying NOT NULL,
    test_trade_name character varying(255) NOT NULL,
    test_submission character varying(100) NOT NULL
);


ALTER TABLE oncomx_v1_0_25.biomarker_fda OWNER TO postgres;

--
-- Name: COLUMN biomarker_fda.id; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.biomarker_fda.id IS 'It is an internal identifier for biomarkers (not included originally in the OncoMX dataset), and it might change for each new release. The stable candidate key for this table is (gene_symbol, test_trade_name, test_submission)';


--
-- Name: COLUMN biomarker_fda.test_trade_name; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.biomarker_fda.test_trade_name IS 'Test trade name.';


--
-- Name: COLUMN biomarker_fda.test_submission; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.biomarker_fda.test_submission IS 'Test submission.';


--
-- Name: biomarker_fda_drug; Type: TABLE; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE TABLE oncomx_v1_0_25.biomarker_fda_drug (
    biomarker_fda_id character varying(10) DEFAULT '0'::character varying NOT NULL,
    biomarker_drug character varying(255) NOT NULL
);


ALTER TABLE oncomx_v1_0_25.biomarker_fda_drug OWNER TO postgres;

--
-- Name: COLUMN biomarker_fda_drug.biomarker_fda_id; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.biomarker_fda_drug.biomarker_fda_id IS 'It is an internal identifier for biomarkers (not included originally in the OncoMX dataset), and it might change for each new release. The stable candidate key for this table is (gene_symbol, test_trade_name, test_submission)';


--
-- Name: biomarker_fda_ncit_term; Type: TABLE; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE TABLE oncomx_v1_0_25.biomarker_fda_ncit_term (
    biomarker_fda_id character varying(10) DEFAULT '0'::character varying NOT NULL,
    ncit_biomarker character varying(255) NOT NULL
);


ALTER TABLE oncomx_v1_0_25.biomarker_fda_ncit_term OWNER TO postgres;

--
-- Name: COLUMN biomarker_fda_ncit_term.biomarker_fda_id; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.biomarker_fda_ncit_term.biomarker_fda_id IS 'It is an internal identifier for biomarkers (not included originally in the OncoMX dataset), and it might change for each new release. The stable candidate key for this table is (gene_symbol, test_trade_name, test_submission)';


--
-- Name: biomarker_fda_test; Type: TABLE; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE TABLE oncomx_v1_0_25.biomarker_fda_test (
    test_trade_name character varying(500) NOT NULL,
    test_manufacturer character varying(300) NOT NULL,
    test_submission character varying(100) NOT NULL,
    biomarker_origin character varying(30) NOT NULL,
    doid bigint NOT NULL,
    histological_type character varying(255) NOT NULL,
    specimen_type character varying(255) NOT NULL,
    platform_method character varying(255) NOT NULL,
    test_number_genes bigint NOT NULL,
    test_adoption_evidence character varying(255) NOT NULL,
    test_approval_status character varying(255) NOT NULL,
    test_study_design character varying(255),
    clinical_significance text NOT NULL
);


ALTER TABLE oncomx_v1_0_25.biomarker_fda_test OWNER TO postgres;

--
-- Name: COLUMN biomarker_fda_test.test_trade_name; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.biomarker_fda_test.test_trade_name IS 'Test trade name.';


--
-- Name: COLUMN biomarker_fda_test.test_manufacturer; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.biomarker_fda_test.test_manufacturer IS 'Test manufacturer.';


--
-- Name: COLUMN biomarker_fda_test.test_submission; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.biomarker_fda_test.test_submission IS 'Test submission.';


--
-- Name: COLUMN biomarker_fda_test.biomarker_origin; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.biomarker_fda_test.biomarker_origin IS 'The biomarker origin.';


--
-- Name: COLUMN biomarker_fda_test.doid; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.biomarker_fda_test.doid IS 'Disease Ontology Identifier (DOID) (e.g. 363 that corresponds to “uterine cancer”). To express the IRI of a DO term, we can concatenate to the DOID number the following prefix: http://purl.obolibrary.org/obo/DOID_.';


--
-- Name: COLUMN biomarker_fda_test.histological_type; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.biomarker_fda_test.histological_type IS 'The histological type.';


--
-- Name: COLUMN biomarker_fda_test.specimen_type; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.biomarker_fda_test.specimen_type IS 'The speciment type to detect a biomarker.';


--
-- Name: COLUMN biomarker_fda_test.platform_method; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.biomarker_fda_test.platform_method IS 'The platform method.';


--
-- Name: COLUMN biomarker_fda_test.test_number_genes; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.biomarker_fda_test.test_number_genes IS 'The number of genes.';


--
-- Name: COLUMN biomarker_fda_test.test_adoption_evidence; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.biomarker_fda_test.test_adoption_evidence IS 'The test adoption evidence of a biomarker such as experimetal or clinical use.';


--
-- Name: COLUMN biomarker_fda_test.test_approval_status; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.biomarker_fda_test.test_approval_status IS 'Regulatory approval status.';


--
-- Name: COLUMN biomarker_fda_test.test_study_design; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.biomarker_fda_test.test_study_design IS 'Study design.';


--
-- Name: COLUMN biomarker_fda_test.clinical_significance; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.biomarker_fda_test.clinical_significance IS 'Regulatory approval status.';


--
-- Name: biomarker_fda_test_trial; Type: TABLE; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE TABLE oncomx_v1_0_25.biomarker_fda_test_trial (
    test_trade_name character varying(255) NOT NULL,
    test_submission character varying(100) NOT NULL,
    test_trial_id character varying(255) NOT NULL
);


ALTER TABLE oncomx_v1_0_25.biomarker_fda_test_trial OWNER TO postgres;

--
-- Name: COLUMN biomarker_fda_test_trial.test_trade_name; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.biomarker_fda_test_trial.test_trade_name IS 'Test trade name.';


--
-- Name: COLUMN biomarker_fda_test_trial.test_submission; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.biomarker_fda_test_trial.test_submission IS 'Test submission.';


--
-- Name: biomarker_fda_test_use; Type: TABLE; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE TABLE oncomx_v1_0_25.biomarker_fda_test_use (
    id bigint NOT NULL,
    test_trade_name character varying(255) NOT NULL,
    test_submission character varying(100) NOT NULL,
    approved_indication character varying(255) NOT NULL,
    actual_use character varying(255) NOT NULL
);


ALTER TABLE oncomx_v1_0_25.biomarker_fda_test_use OWNER TO postgres;

--
-- Name: COLUMN biomarker_fda_test_use.id; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.biomarker_fda_test_use.id IS 'Internal identifier for a FDA biomaker indication and actual use.';


--
-- Name: COLUMN biomarker_fda_test_use.test_trade_name; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.biomarker_fda_test_use.test_trade_name IS 'Test trade name.';


--
-- Name: COLUMN biomarker_fda_test_use.test_submission; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.biomarker_fda_test_use.test_submission IS 'Test submission.';


--
-- Name: biomarker_fda_test_use_id_seq; Type: SEQUENCE; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE SEQUENCE oncomx_v1_0_25.biomarker_fda_test_use_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE oncomx_v1_0_25.biomarker_fda_test_use_id_seq OWNER TO postgres;

--
-- Name: biomarker_fda_test_use_id_seq; Type: SEQUENCE OWNED BY; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER SEQUENCE oncomx_v1_0_25.biomarker_fda_test_use_id_seq OWNED BY oncomx_v1_0_25.biomarker_fda_test_use.id;


--
-- Name: cancer_tissue; Type: TABLE; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE TABLE oncomx_v1_0_25.cancer_tissue (
    doid bigint NOT NULL,
    uberon_anatomical_id character varying(20) NOT NULL
);


ALTER TABLE oncomx_v1_0_25.cancer_tissue OWNER TO postgres;

--
-- Name: COLUMN cancer_tissue.doid; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.cancer_tissue.doid IS 'Disease Ontology Identifier (DOID) (e.g. 363 that corresponds to “uterine cancer”). To express the IRI of a DO term, we can concatenate to the DOID number the following prefix: http://purl.obolibrary.org/obo/DOID_ .';


--
-- Name: differential_expression; Type: TABLE; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE TABLE oncomx_v1_0_25.differential_expression (
    gene_symbol character varying(255) NOT NULL,
    doid bigint NOT NULL,
    log2fc double precision NOT NULL,
    pvalue double precision NOT NULL,
    adjpvalue double precision NOT NULL,
    statistical_significance character varying(3) NOT NULL,
    expression_change_direction character varying(10) NOT NULL,
    subjects_up bigint NOT NULL,
    subjects_down bigint NOT NULL,
    subjects_nochange bigint NOT NULL,
    subjects_nocoverage bigint NOT NULL,
    subjects_total bigint NOT NULL
);


ALTER TABLE oncomx_v1_0_25.differential_expression OWNER TO postgres;

--
-- Name: COLUMN differential_expression.gene_symbol; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.differential_expression.gene_symbol IS 'Official gene symbol/name approved by HUGO Gene Nomenclature Committee (HGNC) or miRNA name.';


--
-- Name: COLUMN differential_expression.doid; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.differential_expression.doid IS 'Disease Ontology Identifier (DOID) (e.g. 363 that corresponds to “uterine cancer”). To express the IRI of a DO term, we can concatenate to the DOID number the following prefix: http://purl.obolibrary.org/obo/DOID_ .';


--
-- Name: COLUMN differential_expression.log2fc; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.differential_expression.log2fc IS 'The logarithm (to base 2) of the fold change from normal expression to tumor expression. Fold change is equivalent to  the expression level of a gene in cancer divided by the expression level of a gene in the same kind of tissue but a healthy one.';


--
-- Name: COLUMN differential_expression.pvalue; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.differential_expression.pvalue IS 'P-value for statistical significance of the reported change, computed directly by DESeq2. DESeq2 is a tool to verify the change of expression of genes between two samples.';


--
-- Name: COLUMN differential_expression.adjpvalue; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.differential_expression.adjpvalue IS 'P-value adjusted for multiple testing with the Benjamini-Hochberg procedure, which controls false discovery rate (FDR).';


--
-- Name: COLUMN differential_expression.statistical_significance; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.differential_expression.statistical_significance IS 'Trends are considered significant when adj. P-value < 0.05';


--
-- Name: COLUMN differential_expression.expression_change_direction; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.differential_expression.expression_change_direction IS 'Gene expression trend. Possible values are no change, down or up.';


--
-- Name: COLUMN differential_expression.subjects_up; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.differential_expression.subjects_up IS 'The amount of patients with increased gene expression.';


--
-- Name: COLUMN differential_expression.subjects_down; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.differential_expression.subjects_down IS 'The amount of patients with decreased gene expression.';


--
-- Name: COLUMN differential_expression.subjects_nochange; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.differential_expression.subjects_nochange IS 'The amount of patients with no change in terms of gene expression.';


--
-- Name: COLUMN differential_expression.subjects_nocoverage; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.differential_expression.subjects_nocoverage IS 'The amount of patients with no coverage.';


--
-- Name: COLUMN differential_expression.subjects_total; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.differential_expression.subjects_total IS 'The total number of patients with data for the study.';


--
-- Name: disease; Type: TABLE; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE TABLE oncomx_v1_0_25.disease (
    id bigint NOT NULL,
    name character varying(60) NOT NULL
);


ALTER TABLE oncomx_v1_0_25.disease OWNER TO postgres;

--
-- Name: disease_mutation; Type: TABLE; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE TABLE oncomx_v1_0_25.disease_mutation (
    id bigint NOT NULL,
    chromosome_id character varying(2) NOT NULL,
    chromosome_pos bigint NOT NULL,
    ref_nt character(1) NOT NULL,
    alt_nt character(1) NOT NULL,
    ensembl_transcript_id character varying(15) NOT NULL,
    cds_pos bigint NOT NULL,
    peptide_pos bigint NOT NULL,
    aa_pos_uniprotkb bigint NOT NULL,
    ref_aa character(1) NOT NULL,
    alt_aa character(1) NOT NULL,
    mutation_freq bigint NOT NULL,
    data_source character varying(12) NOT NULL,
    doid bigint NOT NULL
);


ALTER TABLE oncomx_v1_0_25.disease_mutation OWNER TO postgres;

--
-- Name: COLUMN disease_mutation.id; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.disease_mutation.id IS 'It is an internal identifier for disease mutations. A stable candidate key is the tuple (alt_nt, cds_pos, data_source, doid, ensembl_transcript_id).';


--
-- Name: COLUMN disease_mutation.chromosome_id; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.disease_mutation.chromosome_id IS 'Chromosome identifier.';


--
-- Name: COLUMN disease_mutation.chromosome_pos; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.disease_mutation.chromosome_pos IS 'Chromosome position. Indeed, the genomic position of variant. An identifier from the University of California Santa Cruz (UCSC) Genome database can be assigned as value to represent a genome position.  (e.g. chr1:150830829)';


--
-- Name: COLUMN disease_mutation.ref_nt; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.disease_mutation.ref_nt IS 'Reference or wild-type (~normal) nucleotide base. Nucleotide is an organic molecule that is the basis of a nucleic acid such as DNA. A nucleotide is coded as depicted at https://www.bioinformatics.org/sms/iupac.html .';


--
-- Name: COLUMN disease_mutation.alt_nt; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.disease_mutation.alt_nt IS 'Nucleotide base resulting from variation (~mutation).';


--
-- Name: COLUMN disease_mutation.ensembl_transcript_id; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.disease_mutation.ensembl_transcript_id IS 'Ensembl database transcript identifier.';


--
-- Name: COLUMN disease_mutation.cds_pos; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.disease_mutation.cds_pos IS 'Nucleotide position of variation at the CoDing Sequence (CDS).';


--
-- Name: COLUMN disease_mutation.peptide_pos; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.disease_mutation.peptide_pos IS 'Amino acid position of variation at the protein sequence.';


--
-- Name: COLUMN disease_mutation.aa_pos_uniprotkb; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.disease_mutation.aa_pos_uniprotkb IS 'Amino acid position of variation at UniProt protein sequence (composed of amino acids).';


--
-- Name: COLUMN disease_mutation.ref_aa; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.disease_mutation.ref_aa IS 'Reference or wild-type (~normal) amino acid residue.';


--
-- Name: COLUMN disease_mutation.alt_aa; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.disease_mutation.alt_aa IS 'Residue resulting from variation.';


--
-- Name: COLUMN disease_mutation.mutation_freq; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.disease_mutation.mutation_freq IS 'Mutation frequency.';


--
-- Name: COLUMN disease_mutation.data_source; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.disease_mutation.data_source IS 'Data source of reported variation. The data sources are represented with their acronym, for example, The Cancer Genome Atlas (TCGA).';


--
-- Name: COLUMN disease_mutation.doid; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.disease_mutation.doid IS 'Disease Ontology Identifier (DOID) (e.g. 363 that corresponds to “uterine cancer”). To express the IRI of a DO term, we can concatenate to the DOID number the following prefix: http://purl.obolibrary.org/obo/DOID_.';


--
-- Name: disease_mutation_article; Type: TABLE; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE TABLE oncomx_v1_0_25.disease_mutation_article (
    pmid bigint NOT NULL,
    disease_mutation_id bigint NOT NULL
);


ALTER TABLE oncomx_v1_0_25.disease_mutation_article OWNER TO postgres;

--
-- Name: COLUMN disease_mutation_article.disease_mutation_id; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.disease_mutation_article.disease_mutation_id IS 'It is an internal identifier for disease mutations. A stable candidate key is the tuple (alt_nt, cds_pos, data_source, doid, ensembl_transcript_id).';


--
-- Name: disease_mutation_id_seq; Type: SEQUENCE; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE SEQUENCE oncomx_v1_0_25.disease_mutation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE oncomx_v1_0_25.disease_mutation_id_seq OWNER TO postgres;

--
-- Name: disease_mutation_id_seq; Type: SEQUENCE OWNED BY; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER SEQUENCE oncomx_v1_0_25.disease_mutation_id_seq OWNED BY oncomx_v1_0_25.disease_mutation.id;


--
-- Name: disease_mutation_impact_prediction; Type: TABLE; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE TABLE oncomx_v1_0_25.disease_mutation_impact_prediction (
    id bigint NOT NULL,
    disease_mutation_id bigint NOT NULL,
    site_prediction character varying(255) NOT NULL,
    probability double precision,
    tool character varying(255) NOT NULL
);


ALTER TABLE oncomx_v1_0_25.disease_mutation_impact_prediction OWNER TO postgres;

--
-- Name: COLUMN disease_mutation_impact_prediction.disease_mutation_id; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.disease_mutation_impact_prediction.disease_mutation_id IS 'It is an internal identifier for disease mutations. A stable candidate key is the tuple (alt_nt, cds_pos, data_source, doid, ensembl_transcript_id).';


--
-- Name: disease_mutation_impact_prediction_id_seq; Type: SEQUENCE; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE SEQUENCE oncomx_v1_0_25.disease_mutation_impact_prediction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE oncomx_v1_0_25.disease_mutation_impact_prediction_id_seq OWNER TO postgres;

--
-- Name: disease_mutation_impact_prediction_id_seq; Type: SEQUENCE OWNED BY; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER SEQUENCE oncomx_v1_0_25.disease_mutation_impact_prediction_id_seq OWNED BY oncomx_v1_0_25.disease_mutation_impact_prediction.id;


--
-- Name: disease_mutation_site_annotation; Type: TABLE; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE TABLE oncomx_v1_0_25.disease_mutation_site_annotation (
    id bigint NOT NULL,
    disease_mutation_id bigint NOT NULL,
    description character varying(255),
    feature_key character varying(255) NOT NULL
);


ALTER TABLE oncomx_v1_0_25.disease_mutation_site_annotation OWNER TO postgres;

--
-- Name: COLUMN disease_mutation_site_annotation.id; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.disease_mutation_site_annotation.id IS 'Internal identifier.';


--
-- Name: COLUMN disease_mutation_site_annotation.disease_mutation_id; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.disease_mutation_site_annotation.disease_mutation_id IS 'It is an internal identifier for disease mutations. A stable candidate key is the tuple (alt_nt, cds_pos, data_source, doid, ensembl_transcript_id).';


--
-- Name: disease_mutation_site_annotation_id_seq; Type: SEQUENCE; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE SEQUENCE oncomx_v1_0_25.disease_mutation_site_annotation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE oncomx_v1_0_25.disease_mutation_site_annotation_id_seq OWNER TO postgres;

--
-- Name: disease_mutation_site_annotation_id_seq; Type: SEQUENCE OWNED BY; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER SEQUENCE oncomx_v1_0_25.disease_mutation_site_annotation_id_seq OWNED BY oncomx_v1_0_25.disease_mutation_site_annotation.id;


--
-- Name: disease_mutation_tissue; Type: TABLE; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE TABLE oncomx_v1_0_25.disease_mutation_tissue (
    uberon_anatomical_id character varying(20) NOT NULL,
    disease_mutation_id bigint NOT NULL
);


ALTER TABLE oncomx_v1_0_25.disease_mutation_tissue OWNER TO postgres;

--
-- Name: COLUMN disease_mutation_tissue.disease_mutation_id; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.disease_mutation_tissue.disease_mutation_id IS 'It is an internal identifier for disease mutations. A stable candidate key is the tuple (alt_nt, cds_pos, data_source, doid, ensembl_transcript_id).';


--
-- Name: healthy_expression; Type: TABLE; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE TABLE oncomx_v1_0_25.healthy_expression (
    ensembl_gene_id character varying(20) NOT NULL,
    uberon_anatomical_id character varying(20) NOT NULL,
    uberon_developmental_id character varying(14) NOT NULL,
    expression_level_gene_relative character varying(6) NOT NULL,
    expression_level_anatomical_relative character varying(6) NOT NULL,
    call_quality character varying(6) NOT NULL,
    expression_rank_score numeric(9,2) NOT NULL,
    expression_score numeric(9,5) NOT NULL
);


ALTER TABLE oncomx_v1_0_25.healthy_expression OWNER TO postgres;

--
-- Name: map_protein_disease_mutation; Type: TABLE; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE TABLE oncomx_v1_0_25.map_protein_disease_mutation (
    peptide_id character varying(15) NOT NULL,
    ensembl_transcript_id character varying(15) NOT NULL,
    uniprotkb_ac character varying(15) NOT NULL
);


ALTER TABLE oncomx_v1_0_25.map_protein_disease_mutation OWNER TO postgres;

--
-- Name: COLUMN map_protein_disease_mutation.peptide_id; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.map_protein_disease_mutation.peptide_id IS 'Ensembl database protein identifier.';


--
-- Name: COLUMN map_protein_disease_mutation.ensembl_transcript_id; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.map_protein_disease_mutation.ensembl_transcript_id IS 'Ensembl database transcript identifier.';


--
-- Name: COLUMN map_protein_disease_mutation.uniprotkb_ac; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.map_protein_disease_mutation.uniprotkb_ac IS 'UniProtKB/SwissProt AC. The accession number (i.e. identifier) assigned to a protein in UniProtKB database.';


--
-- Name: map_uniprot_canonical_id; Type: TABLE; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE TABLE oncomx_v1_0_25.map_uniprot_canonical_id (
    uniprotkb_ac character varying(15) NOT NULL,
    uniprotkb_canonical_ac character varying(15) NOT NULL
);


ALTER TABLE oncomx_v1_0_25.map_uniprot_canonical_id OWNER TO postgres;

--
-- Name: COLUMN map_uniprot_canonical_id.uniprotkb_ac; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.map_uniprot_canonical_id.uniprotkb_ac IS 'UniProtKB/SwissProt AC. The accession number (i.e. identifier) assigned to a protein in UniProtKB database.';


--
-- Name: COLUMN map_uniprot_canonical_id.uniprotkb_canonical_ac; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.map_uniprot_canonical_id.uniprotkb_canonical_ac IS 'UniProtKB/SwissProt Canonical AC. Accession number assigned to the canonical isoform in UniProtKB database.';


--
-- Name: species; Type: TABLE; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE TABLE oncomx_v1_0_25.species (
    speciesid integer NOT NULL,
    genus character varying(70) NOT NULL,
    species character varying(70) NOT NULL,
    speciescommonname character varying(70) NOT NULL
);


ALTER TABLE oncomx_v1_0_25.species OWNER TO postgres;

--
-- Name: COLUMN species.speciesid; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.species.speciesid IS 'NCBI species taxon id.';


--
-- Name: COLUMN species.genus; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.species.genus IS 'Genus name.';


--
-- Name: COLUMN species.species; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.species.species IS 'Species name.';


--
-- Name: COLUMN species.speciescommonname; Type: COMMENT; Schema: oncomx_v1_0_25; Owner: postgres
--

COMMENT ON COLUMN oncomx_v1_0_25.species.speciescommonname IS 'NCBI species common name.';


--
-- Name: stage; Type: TABLE; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE TABLE oncomx_v1_0_25.stage (
    id character varying(14) NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE oncomx_v1_0_25.stage OWNER TO postgres;

--
-- Name: xref_gene_ensembl; Type: TABLE; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE TABLE oncomx_v1_0_25.xref_gene_ensembl (
    gene_symbol character varying(255) NOT NULL,
    ensembl_gene_id character varying(20) NOT NULL,
    speciesid integer NOT NULL
);


ALTER TABLE oncomx_v1_0_25.xref_gene_ensembl OWNER TO postgres;

--
-- Name: biomarker_fda_test_use id; Type: DEFAULT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.biomarker_fda_test_use ALTER COLUMN id SET DEFAULT nextval('oncomx_v1_0_25.biomarker_fda_test_use_id_seq'::regclass);


--
-- Name: disease_mutation id; Type: DEFAULT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.disease_mutation ALTER COLUMN id SET DEFAULT nextval('oncomx_v1_0_25.disease_mutation_id_seq'::regclass);


--
-- Name: disease_mutation_impact_prediction id; Type: DEFAULT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.disease_mutation_impact_prediction ALTER COLUMN id SET DEFAULT nextval('oncomx_v1_0_25.disease_mutation_impact_prediction_id_seq'::regclass);


--
-- Name: disease_mutation_site_annotation id; Type: DEFAULT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.disease_mutation_site_annotation ALTER COLUMN id SET DEFAULT nextval('oncomx_v1_0_25.disease_mutation_site_annotation_id_seq'::regclass);


--
-- Data for Name: anatomical_entity; Type: TABLE DATA; Schema: oncomx_v1_0_25; Owner: postgres
--

\i $$PATH$$/2480.dat

--
-- Data for Name: biomarker; Type: TABLE DATA; Schema: oncomx_v1_0_25; Owner: postgres
--

\i $$PATH$$/2481.dat

--
-- Data for Name: biomarker_alias; Type: TABLE DATA; Schema: oncomx_v1_0_25; Owner: postgres
--

\i $$PATH$$/2482.dat

--
-- Data for Name: biomarker_article; Type: TABLE DATA; Schema: oncomx_v1_0_25; Owner: postgres
--

\i $$PATH$$/2483.dat

--
-- Data for Name: biomarker_edrn; Type: TABLE DATA; Schema: oncomx_v1_0_25; Owner: postgres
--

\i $$PATH$$/2484.dat

--
-- Data for Name: biomarker_fda; Type: TABLE DATA; Schema: oncomx_v1_0_25; Owner: postgres
--

\i $$PATH$$/2485.dat

--
-- Data for Name: biomarker_fda_drug; Type: TABLE DATA; Schema: oncomx_v1_0_25; Owner: postgres
--

\i $$PATH$$/2486.dat

--
-- Data for Name: biomarker_fda_ncit_term; Type: TABLE DATA; Schema: oncomx_v1_0_25; Owner: postgres
--

\i $$PATH$$/2487.dat

--
-- Data for Name: biomarker_fda_test; Type: TABLE DATA; Schema: oncomx_v1_0_25; Owner: postgres
--

\i $$PATH$$/2488.dat

--
-- Data for Name: biomarker_fda_test_trial; Type: TABLE DATA; Schema: oncomx_v1_0_25; Owner: postgres
--

\i $$PATH$$/2489.dat

--
-- Data for Name: biomarker_fda_test_use; Type: TABLE DATA; Schema: oncomx_v1_0_25; Owner: postgres
--

\i $$PATH$$/2490.dat

--
-- Data for Name: cancer_tissue; Type: TABLE DATA; Schema: oncomx_v1_0_25; Owner: postgres
--

\i $$PATH$$/2507.dat

--
-- Data for Name: differential_expression; Type: TABLE DATA; Schema: oncomx_v1_0_25; Owner: postgres
--

\i $$PATH$$/2508.dat

--
-- Data for Name: disease; Type: TABLE DATA; Schema: oncomx_v1_0_25; Owner: postgres
--

\i $$PATH$$/2492.dat

--
-- Data for Name: disease_mutation; Type: TABLE DATA; Schema: oncomx_v1_0_25; Owner: postgres
--

\i $$PATH$$/2493.dat

--
-- Data for Name: disease_mutation_article; Type: TABLE DATA; Schema: oncomx_v1_0_25; Owner: postgres
--

\i $$PATH$$/2494.dat

--
-- Data for Name: disease_mutation_impact_prediction; Type: TABLE DATA; Schema: oncomx_v1_0_25; Owner: postgres
--

\i $$PATH$$/2496.dat

--
-- Data for Name: disease_mutation_site_annotation; Type: TABLE DATA; Schema: oncomx_v1_0_25; Owner: postgres
--

\i $$PATH$$/2498.dat

--
-- Data for Name: disease_mutation_tissue; Type: TABLE DATA; Schema: oncomx_v1_0_25; Owner: postgres
--

\i $$PATH$$/2500.dat

--
-- Data for Name: healthy_expression; Type: TABLE DATA; Schema: oncomx_v1_0_25; Owner: postgres
--

\i $$PATH$$/2501.dat

--
-- Data for Name: map_protein_disease_mutation; Type: TABLE DATA; Schema: oncomx_v1_0_25; Owner: postgres
--

\i $$PATH$$/2502.dat

--
-- Data for Name: map_uniprot_canonical_id; Type: TABLE DATA; Schema: oncomx_v1_0_25; Owner: postgres
--

\i $$PATH$$/2503.dat

--
-- Data for Name: species; Type: TABLE DATA; Schema: oncomx_v1_0_25; Owner: postgres
--

\i $$PATH$$/2504.dat

--
-- Data for Name: stage; Type: TABLE DATA; Schema: oncomx_v1_0_25; Owner: postgres
--

\i $$PATH$$/2505.dat

--
-- Data for Name: xref_gene_ensembl; Type: TABLE DATA; Schema: oncomx_v1_0_25; Owner: postgres
--

\i $$PATH$$/2506.dat

--
-- Name: biomarker_fda_test_use_id_seq; Type: SEQUENCE SET; Schema: oncomx_v1_0_25; Owner: postgres
--

SELECT pg_catalog.setval('oncomx_v1_0_25.biomarker_fda_test_use_id_seq', 124, true);


--
-- Name: disease_mutation_id_seq; Type: SEQUENCE SET; Schema: oncomx_v1_0_25; Owner: postgres
--

SELECT pg_catalog.setval('oncomx_v1_0_25.disease_mutation_id_seq', 7757463, true);


--
-- Name: disease_mutation_impact_prediction_id_seq; Type: SEQUENCE SET; Schema: oncomx_v1_0_25; Owner: postgres
--

SELECT pg_catalog.setval('oncomx_v1_0_25.disease_mutation_impact_prediction_id_seq', 4685290, true);


--
-- Name: disease_mutation_site_annotation_id_seq; Type: SEQUENCE SET; Schema: oncomx_v1_0_25; Owner: postgres
--

SELECT pg_catalog.setval('oncomx_v1_0_25.disease_mutation_site_annotation_id_seq', 85391, true);


--
-- Name: anatomical_entity idx_18385_primary; Type: CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.anatomical_entity
    ADD CONSTRAINT idx_18385_primary PRIMARY KEY (id);


--
-- Name: biomarker idx_18391_primary; Type: CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.biomarker
    ADD CONSTRAINT idx_18391_primary PRIMARY KEY (id);


--
-- Name: biomarker_alias idx_18398_primary; Type: CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.biomarker_alias
    ADD CONSTRAINT idx_18398_primary PRIMARY KEY (biomarker_internal_id, alias);


--
-- Name: biomarker_article idx_18401_primary; Type: CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.biomarker_article
    ADD CONSTRAINT idx_18401_primary PRIMARY KEY (biomarker_internal_id, pmid);


--
-- Name: biomarker_edrn idx_18405_primary; Type: CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.biomarker_edrn
    ADD CONSTRAINT idx_18405_primary PRIMARY KEY (id);


--
-- Name: biomarker_fda idx_18415_primary; Type: CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.biomarker_fda
    ADD CONSTRAINT idx_18415_primary PRIMARY KEY (id);


--
-- Name: biomarker_fda_drug idx_18419_primary; Type: CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.biomarker_fda_drug
    ADD CONSTRAINT idx_18419_primary PRIMARY KEY (biomarker_fda_id, biomarker_drug);


--
-- Name: biomarker_fda_ncit_term idx_18423_primary; Type: CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.biomarker_fda_ncit_term
    ADD CONSTRAINT idx_18423_primary PRIMARY KEY (biomarker_fda_id, ncit_biomarker);


--
-- Name: biomarker_fda_test idx_18433_primary; Type: CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.biomarker_fda_test
    ADD CONSTRAINT idx_18433_primary PRIMARY KEY (test_submission, test_trade_name);


--
-- Name: biomarker_fda_test_trial idx_18439_primary; Type: CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.biomarker_fda_test_trial
    ADD CONSTRAINT idx_18439_primary PRIMARY KEY (test_trade_name, test_submission, test_trial_id);


--
-- Name: biomarker_fda_test_use idx_18447_primary; Type: CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.biomarker_fda_test_use
    ADD CONSTRAINT idx_18447_primary PRIMARY KEY (id);


--
-- Name: disease idx_18463_primary; Type: CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.disease
    ADD CONSTRAINT idx_18463_primary PRIMARY KEY (id);


--
-- Name: disease_mutation idx_18468_primary; Type: CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.disease_mutation
    ADD CONSTRAINT idx_18468_primary PRIMARY KEY (id);


--
-- Name: disease_mutation_article idx_18472_primary; Type: CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.disease_mutation_article
    ADD CONSTRAINT idx_18472_primary PRIMARY KEY (disease_mutation_id, pmid);


--
-- Name: disease_mutation_impact_prediction idx_18477_primary; Type: CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.disease_mutation_impact_prediction
    ADD CONSTRAINT idx_18477_primary PRIMARY KEY (id);


--
-- Name: disease_mutation_site_annotation idx_18492_primary; Type: CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.disease_mutation_site_annotation
    ADD CONSTRAINT idx_18492_primary PRIMARY KEY (id);


--
-- Name: disease_mutation_tissue idx_18499_primary; Type: CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.disease_mutation_tissue
    ADD CONSTRAINT idx_18499_primary PRIMARY KEY (uberon_anatomical_id, disease_mutation_id);


--
-- Name: healthy_expression idx_18502_primary; Type: CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.healthy_expression
    ADD CONSTRAINT idx_18502_primary PRIMARY KEY (ensembl_gene_id, uberon_anatomical_id, uberon_developmental_id);


--
-- Name: map_protein_disease_mutation idx_18517_primary; Type: CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.map_protein_disease_mutation
    ADD CONSTRAINT idx_18517_primary PRIMARY KEY (ensembl_transcript_id);


--
-- Name: map_uniprot_canonical_id idx_18520_primary; Type: CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.map_uniprot_canonical_id
    ADD CONSTRAINT idx_18520_primary PRIMARY KEY (uniprotkb_ac);


--
-- Name: species idx_18526_primary; Type: CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.species
    ADD CONSTRAINT idx_18526_primary PRIMARY KEY (speciesid);


--
-- Name: stage idx_18529_primary; Type: CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.stage
    ADD CONSTRAINT idx_18529_primary PRIMARY KEY (id);


--
-- Name: xref_gene_ensembl idx_18532_primary; Type: CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.xref_gene_ensembl
    ADD CONSTRAINT idx_18532_primary PRIMARY KEY (ensembl_gene_id);


--
-- Name: cancer_tissue idx_26577_primary; Type: CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.cancer_tissue
    ADD CONSTRAINT idx_26577_primary PRIMARY KEY (doid, uberon_anatomical_id);


--
-- Name: differential_expression idx_26580_primary; Type: CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.differential_expression
    ADD CONSTRAINT idx_26580_primary PRIMARY KEY (gene_symbol, doid);


--
-- Name: anatomical_entity_description_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX anatomical_entity_description_gist_idx ON oncomx_v1_0_25.anatomical_entity USING gist (description oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: anatomical_entity_id_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX anatomical_entity_id_gist_idx ON oncomx_v1_0_25.anatomical_entity USING gist (id oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: anatomical_entity_name_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX anatomical_entity_name_gist_idx ON oncomx_v1_0_25.anatomical_entity USING gist (name oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_alias_alias_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_alias_alias_gist_idx ON oncomx_v1_0_25.biomarker_alias USING gist (alias oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_alias_biomarker_internal_id_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_alias_biomarker_internal_id_gist_idx ON oncomx_v1_0_25.biomarker_alias USING gist (biomarker_internal_id oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_article_biomarker_internal_id_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_article_biomarker_internal_id_gist_idx ON oncomx_v1_0_25.biomarker_article USING gist (biomarker_internal_id oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_article_pmid_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_article_pmid_gist_idx ON oncomx_v1_0_25.biomarker_article USING gist (pmid oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_biomarker_description_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_biomarker_description_gist_idx ON oncomx_v1_0_25.biomarker USING gist (biomarker_description oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_biomarker_id_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_biomarker_id_gist_idx ON oncomx_v1_0_25.biomarker USING gist (biomarker_id oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_edrn_biomarker_title_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_edrn_biomarker_title_gist_idx ON oncomx_v1_0_25.biomarker_edrn USING gist (biomarker_title oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_edrn_biomarker_type_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_edrn_biomarker_type_gist_idx ON oncomx_v1_0_25.biomarker_edrn USING gist (biomarker_type oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_edrn_id_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_edrn_id_gist_idx ON oncomx_v1_0_25.biomarker_edrn USING gist (id oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_edrn_phase_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_edrn_phase_gist_idx ON oncomx_v1_0_25.biomarker_edrn USING gist (phase oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_edrn_qa_state_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_edrn_qa_state_gist_idx ON oncomx_v1_0_25.biomarker_edrn USING gist (qa_state oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_edrn_uberon_anatomical_id_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_edrn_uberon_anatomical_id_gist_idx ON oncomx_v1_0_25.biomarker_edrn USING gist (uberon_anatomical_id oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_fda_drug_biomarker_drug_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_fda_drug_biomarker_drug_gist_idx ON oncomx_v1_0_25.biomarker_fda_drug USING gist (biomarker_drug oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_fda_drug_biomarker_fda_id_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_fda_drug_biomarker_fda_id_gist_idx ON oncomx_v1_0_25.biomarker_fda_drug USING gist (biomarker_fda_id oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_fda_id_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_fda_id_gist_idx ON oncomx_v1_0_25.biomarker_fda USING gist (id oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_fda_ncit_term_biomarker_fda_id_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_fda_ncit_term_biomarker_fda_id_gist_idx ON oncomx_v1_0_25.biomarker_fda_ncit_term USING gist (biomarker_fda_id oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_fda_ncit_term_ncit_biomarker_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_fda_ncit_term_ncit_biomarker_gist_idx ON oncomx_v1_0_25.biomarker_fda_ncit_term USING gist (ncit_biomarker oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_fda_test_biomarker_origin_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_fda_test_biomarker_origin_gist_idx ON oncomx_v1_0_25.biomarker_fda_test USING gist (biomarker_origin oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_fda_test_clinical_significance_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_fda_test_clinical_significance_gist_idx ON oncomx_v1_0_25.biomarker_fda_test USING gist (clinical_significance oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_fda_test_doid_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_fda_test_doid_idx ON oncomx_v1_0_25.biomarker_fda_test USING btree (doid);


--
-- Name: biomarker_fda_test_histological_type_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_fda_test_histological_type_gist_idx ON oncomx_v1_0_25.biomarker_fda_test USING gist (histological_type oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_fda_test_platform_method_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_fda_test_platform_method_gist_idx ON oncomx_v1_0_25.biomarker_fda_test USING gist (platform_method oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_fda_test_specimen_type_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_fda_test_specimen_type_gist_idx ON oncomx_v1_0_25.biomarker_fda_test USING gist (specimen_type oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_fda_test_submission_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_fda_test_submission_gist_idx ON oncomx_v1_0_25.biomarker_fda USING gist (test_submission oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_fda_test_test_adoption_evidence_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_fda_test_test_adoption_evidence_gist_idx ON oncomx_v1_0_25.biomarker_fda_test USING gist (test_adoption_evidence oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_fda_test_test_approval_status_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_fda_test_test_approval_status_gist_idx ON oncomx_v1_0_25.biomarker_fda_test USING gist (test_approval_status oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_fda_test_test_manufacturer_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_fda_test_test_manufacturer_gist_idx ON oncomx_v1_0_25.biomarker_fda_test USING gist (test_manufacturer oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_fda_test_test_number_genes_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_fda_test_test_number_genes_idx ON oncomx_v1_0_25.biomarker_fda_test USING btree (test_number_genes);


--
-- Name: biomarker_fda_test_test_study_design_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_fda_test_test_study_design_gist_idx ON oncomx_v1_0_25.biomarker_fda_test USING gist (test_study_design oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_fda_test_test_submission_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_fda_test_test_submission_gist_idx ON oncomx_v1_0_25.biomarker_fda_test USING gist (test_submission oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_fda_test_test_trade_name_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_fda_test_test_trade_name_gist_idx ON oncomx_v1_0_25.biomarker_fda_test USING gist (test_trade_name oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_fda_test_trade_name_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_fda_test_trade_name_gist_idx ON oncomx_v1_0_25.biomarker_fda USING gist (test_trade_name oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_fda_test_trial_test_submission_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_fda_test_trial_test_submission_gist_idx ON oncomx_v1_0_25.biomarker_fda_test_trial USING gist (test_submission oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_fda_test_trial_test_trade_name_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_fda_test_trial_test_trade_name_gist_idx ON oncomx_v1_0_25.biomarker_fda_test_trial USING gist (test_trade_name oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_fda_test_trial_test_trial_id_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_fda_test_trial_test_trial_id_gist_idx ON oncomx_v1_0_25.biomarker_fda_test_trial USING gist (test_trial_id oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_fda_test_use_actual_use_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_fda_test_use_actual_use_gist_idx ON oncomx_v1_0_25.biomarker_fda_test_use USING gist (actual_use oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_fda_test_use_approved_indication_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_fda_test_use_approved_indication_gist_idx ON oncomx_v1_0_25.biomarker_fda_test_use USING gist (approved_indication oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_fda_test_use_id_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_fda_test_use_id_idx ON oncomx_v1_0_25.biomarker_fda_test_use USING btree (id);


--
-- Name: biomarker_fda_test_use_test_submission_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_fda_test_use_test_submission_gist_idx ON oncomx_v1_0_25.biomarker_fda_test_use USING gist (test_submission oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_fda_test_use_test_trade_name_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_fda_test_use_test_trade_name_gist_idx ON oncomx_v1_0_25.biomarker_fda_test_use USING gist (test_trade_name oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_gene_symbol_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_gene_symbol_gist_idx ON oncomx_v1_0_25.biomarker USING gist (gene_symbol oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_id_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_id_gist_idx ON oncomx_v1_0_25.biomarker USING gist (id oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: biomarker_test_is_a_panel_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX biomarker_test_is_a_panel_idx ON oncomx_v1_0_25.biomarker USING btree (test_is_a_panel);


--
-- Name: cancer_tissue_doid_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX cancer_tissue_doid_idx ON oncomx_v1_0_25.cancer_tissue USING btree (doid);


--
-- Name: cancer_tissue_uberon_anatomical_id_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX cancer_tissue_uberon_anatomical_id_gist_idx ON oncomx_v1_0_25.cancer_tissue USING gist (uberon_anatomical_id oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: differential_expression_adjpvalue_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX differential_expression_adjpvalue_idx ON oncomx_v1_0_25.differential_expression USING btree (adjpvalue);


--
-- Name: differential_expression_doid_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX differential_expression_doid_idx ON oncomx_v1_0_25.differential_expression USING btree (doid);


--
-- Name: differential_expression_expression_change_direction_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX differential_expression_expression_change_direction_gist_idx ON oncomx_v1_0_25.differential_expression USING gist (expression_change_direction oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: differential_expression_gene_symbol_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX differential_expression_gene_symbol_gist_idx ON oncomx_v1_0_25.differential_expression USING gist (gene_symbol oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: differential_expression_log2fc_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX differential_expression_log2fc_idx ON oncomx_v1_0_25.differential_expression USING btree (log2fc);


--
-- Name: differential_expression_pvalue_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX differential_expression_pvalue_idx ON oncomx_v1_0_25.differential_expression USING btree (pvalue);


--
-- Name: differential_expression_statistical_significance_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX differential_expression_statistical_significance_gist_idx ON oncomx_v1_0_25.differential_expression USING gist (statistical_significance oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: differential_expression_subjects_down_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX differential_expression_subjects_down_idx ON oncomx_v1_0_25.differential_expression USING btree (subjects_down);


--
-- Name: differential_expression_subjects_nochange_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX differential_expression_subjects_nochange_idx ON oncomx_v1_0_25.differential_expression USING btree (subjects_nochange);


--
-- Name: differential_expression_subjects_nocoverage_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX differential_expression_subjects_nocoverage_idx ON oncomx_v1_0_25.differential_expression USING btree (subjects_nocoverage);


--
-- Name: differential_expression_subjects_total_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX differential_expression_subjects_total_idx ON oncomx_v1_0_25.differential_expression USING btree (subjects_total);


--
-- Name: differential_expression_subjects_up_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX differential_expression_subjects_up_idx ON oncomx_v1_0_25.differential_expression USING btree (subjects_up);


--
-- Name: disease_id_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX disease_id_idx ON oncomx_v1_0_25.disease USING btree (id);


--
-- Name: disease_mutation_aa_pos_uniprotkb_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX disease_mutation_aa_pos_uniprotkb_idx ON oncomx_v1_0_25.disease_mutation USING btree (aa_pos_uniprotkb);


--
-- Name: disease_mutation_alt_aa_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX disease_mutation_alt_aa_idx ON oncomx_v1_0_25.disease_mutation USING btree (alt_aa);


--
-- Name: disease_mutation_alt_nt_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX disease_mutation_alt_nt_idx ON oncomx_v1_0_25.disease_mutation USING btree (alt_nt);


--
-- Name: disease_mutation_article_disease_mutation_id_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX disease_mutation_article_disease_mutation_id_idx ON oncomx_v1_0_25.disease_mutation_article USING btree (disease_mutation_id);


--
-- Name: disease_mutation_article_pmid_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX disease_mutation_article_pmid_idx ON oncomx_v1_0_25.disease_mutation_article USING btree (pmid);


--
-- Name: disease_mutation_cds_pos_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX disease_mutation_cds_pos_idx ON oncomx_v1_0_25.disease_mutation USING btree (cds_pos);


--
-- Name: disease_mutation_chromosome_id_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX disease_mutation_chromosome_id_gist_idx ON oncomx_v1_0_25.disease_mutation USING gist (chromosome_id oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: disease_mutation_chromosome_id_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX disease_mutation_chromosome_id_idx ON oncomx_v1_0_25.disease_mutation USING btree (chromosome_id);


--
-- Name: disease_mutation_chromosome_pos_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX disease_mutation_chromosome_pos_idx ON oncomx_v1_0_25.disease_mutation USING btree (chromosome_pos);


--
-- Name: disease_mutation_data_source_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX disease_mutation_data_source_gist_idx ON oncomx_v1_0_25.disease_mutation USING gist (data_source oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: disease_mutation_doid_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX disease_mutation_doid_idx ON oncomx_v1_0_25.disease_mutation USING btree (doid);


--
-- Name: disease_mutation_ensembl_transcript_id_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX disease_mutation_ensembl_transcript_id_gist_idx ON oncomx_v1_0_25.disease_mutation USING gist (ensembl_transcript_id oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: disease_mutation_id_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX disease_mutation_id_idx ON oncomx_v1_0_25.disease_mutation USING btree (id);


--
-- Name: disease_mutation_impact_prediction_disease_mutation_id_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX disease_mutation_impact_prediction_disease_mutation_id_idx ON oncomx_v1_0_25.disease_mutation_impact_prediction USING btree (disease_mutation_id);


--
-- Name: disease_mutation_impact_prediction_id_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX disease_mutation_impact_prediction_id_idx ON oncomx_v1_0_25.disease_mutation_impact_prediction USING btree (id);


--
-- Name: disease_mutation_impact_prediction_probability_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX disease_mutation_impact_prediction_probability_idx ON oncomx_v1_0_25.disease_mutation_impact_prediction USING btree (probability);


--
-- Name: disease_mutation_impact_prediction_site_prediction_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX disease_mutation_impact_prediction_site_prediction_gist_idx ON oncomx_v1_0_25.disease_mutation_impact_prediction USING gist (site_prediction oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: disease_mutation_impact_prediction_tool_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX disease_mutation_impact_prediction_tool_gist_idx ON oncomx_v1_0_25.disease_mutation_impact_prediction USING gist (tool oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: disease_mutation_mutation_freq_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX disease_mutation_mutation_freq_idx ON oncomx_v1_0_25.disease_mutation USING btree (mutation_freq);


--
-- Name: disease_mutation_peptide_pos_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX disease_mutation_peptide_pos_idx ON oncomx_v1_0_25.disease_mutation USING btree (peptide_pos);


--
-- Name: disease_mutation_ref_aa_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX disease_mutation_ref_aa_idx ON oncomx_v1_0_25.disease_mutation USING btree (ref_aa);


--
-- Name: disease_mutation_ref_nt_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX disease_mutation_ref_nt_idx ON oncomx_v1_0_25.disease_mutation USING btree (ref_nt);


--
-- Name: disease_mutation_site_annotation_description_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX disease_mutation_site_annotation_description_gist_idx ON oncomx_v1_0_25.disease_mutation_site_annotation USING gist (description oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: disease_mutation_site_annotation_disease_mutation_id_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX disease_mutation_site_annotation_disease_mutation_id_idx ON oncomx_v1_0_25.disease_mutation_site_annotation USING btree (disease_mutation_id);


--
-- Name: disease_mutation_site_annotation_feature_key_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX disease_mutation_site_annotation_feature_key_gist_idx ON oncomx_v1_0_25.disease_mutation_site_annotation USING gist (feature_key oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: disease_mutation_site_annotation_id_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX disease_mutation_site_annotation_id_idx ON oncomx_v1_0_25.disease_mutation_site_annotation USING btree (id);


--
-- Name: disease_mutation_tissue_disease_mutation_id_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX disease_mutation_tissue_disease_mutation_id_idx ON oncomx_v1_0_25.disease_mutation_tissue USING btree (disease_mutation_id);


--
-- Name: disease_mutation_tissue_uberon_anatomical_id_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX disease_mutation_tissue_uberon_anatomical_id_gist_idx ON oncomx_v1_0_25.disease_mutation_tissue USING gist (uberon_anatomical_id oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: disease_name_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX disease_name_gist_idx ON oncomx_v1_0_25.disease USING gist (name oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: fk_ensembl_transcript_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX fk_ensembl_transcript_idx ON oncomx_v1_0_25.disease_mutation USING btree (ensembl_transcript_id);


--
-- Name: healthy_expression_call_quality_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX healthy_expression_call_quality_gist_idx ON oncomx_v1_0_25.healthy_expression USING gist (call_quality oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: healthy_expression_ensembl_gene_id_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX healthy_expression_ensembl_gene_id_gist_idx ON oncomx_v1_0_25.healthy_expression USING gist (ensembl_gene_id oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: healthy_expression_expression_level_anatomical_relative_gist_id; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX healthy_expression_expression_level_anatomical_relative_gist_id ON oncomx_v1_0_25.healthy_expression USING gist (expression_level_anatomical_relative oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: healthy_expression_expression_level_gene_relative_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX healthy_expression_expression_level_gene_relative_gist_idx ON oncomx_v1_0_25.healthy_expression USING gist (expression_level_gene_relative oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: healthy_expression_expression_rank_score_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX healthy_expression_expression_rank_score_idx ON oncomx_v1_0_25.healthy_expression USING btree (expression_rank_score);


--
-- Name: healthy_expression_expression_score_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX healthy_expression_expression_score_idx ON oncomx_v1_0_25.healthy_expression USING btree (expression_score);


--
-- Name: healthy_expression_uberon_anatomical_id_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX healthy_expression_uberon_anatomical_id_gist_idx ON oncomx_v1_0_25.healthy_expression USING gist (uberon_anatomical_id oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: healthy_expression_uberon_developmental_id_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX healthy_expression_uberon_developmental_id_gist_idx ON oncomx_v1_0_25.healthy_expression USING gist (uberon_developmental_id oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: idx_18385_name; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE UNIQUE INDEX idx_18385_name ON oncomx_v1_0_25.anatomical_entity USING btree (name);


--
-- Name: idx_18398_idx_biomarker_alias; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_18398_idx_biomarker_alias ON oncomx_v1_0_25.biomarker_alias USING btree (alias);


--
-- Name: idx_18401_idx_biomarker_pmid; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_18401_idx_biomarker_pmid ON oncomx_v1_0_25.biomarker_article USING btree (pmid);


--
-- Name: idx_18405_idx_biomarker_edrn_anat; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_18405_idx_biomarker_edrn_anat ON oncomx_v1_0_25.biomarker_edrn USING btree (uberon_anatomical_id);


--
-- Name: idx_18415_fk_biomarker_fda_test; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_18415_fk_biomarker_fda_test ON oncomx_v1_0_25.biomarker_fda USING btree (test_submission, test_trade_name);


--
-- Name: idx_18415_idx_biomarker_fda_test_submission; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_18415_idx_biomarker_fda_test_submission ON oncomx_v1_0_25.biomarker_fda USING btree (test_submission);


--
-- Name: idx_18415_idx_biomarker_fda_trade_name; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_18415_idx_biomarker_fda_trade_name ON oncomx_v1_0_25.biomarker_fda USING btree (test_trade_name);


--
-- Name: idx_18419_idx_biomarker_fda_drug; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_18419_idx_biomarker_fda_drug ON oncomx_v1_0_25.biomarker_fda_drug USING btree (biomarker_drug);


--
-- Name: idx_18419_idx_biomarker_fda_drug_id; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_18419_idx_biomarker_fda_drug_id ON oncomx_v1_0_25.biomarker_fda_drug USING btree (biomarker_fda_id);


--
-- Name: idx_18423_idx_biomarker_fda_id_ncit; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_18423_idx_biomarker_fda_id_ncit ON oncomx_v1_0_25.biomarker_fda_ncit_term USING btree (biomarker_fda_id);


--
-- Name: idx_18423_idx_biomarker_fda_ncit; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_18423_idx_biomarker_fda_ncit ON oncomx_v1_0_25.biomarker_fda_ncit_term USING btree (ncit_biomarker);


--
-- Name: idx_18433_idx_biomarker_fda_test_doid; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_18433_idx_biomarker_fda_test_doid ON oncomx_v1_0_25.biomarker_fda_test USING btree (doid);


--
-- Name: idx_18433_idx_biomarker_fda_test_manufacture; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_18433_idx_biomarker_fda_test_manufacture ON oncomx_v1_0_25.biomarker_fda_test USING btree (test_manufacturer);


--
-- Name: idx_18433_idx_biomarker_fda_test_submission; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_18433_idx_biomarker_fda_test_submission ON oncomx_v1_0_25.biomarker_fda_test USING btree (test_submission);


--
-- Name: idx_18433_idx_biomarker_fda_test_trade_name; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_18433_idx_biomarker_fda_test_trade_name ON oncomx_v1_0_25.biomarker_fda_test USING btree (test_trade_name);


--
-- Name: idx_18439_fk_biomarker_fda_test_trial; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_18439_fk_biomarker_fda_test_trial ON oncomx_v1_0_25.biomarker_fda_test_trial USING btree (test_submission, test_trade_name);


--
-- Name: idx_18439_idx_biomarker_fda_test_submission_trial; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_18439_idx_biomarker_fda_test_submission_trial ON oncomx_v1_0_25.biomarker_fda_test_trial USING btree (test_submission);


--
-- Name: idx_18439_idx_biomarker_fda_test_trial_id; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_18439_idx_biomarker_fda_test_trial_id ON oncomx_v1_0_25.biomarker_fda_test_trial USING btree (test_trial_id);


--
-- Name: idx_18439_idx_biomarker_fda_trade_name_trial; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_18439_idx_biomarker_fda_trade_name_trial ON oncomx_v1_0_25.biomarker_fda_test_trial USING btree (test_trade_name);


--
-- Name: idx_18447_fk_biomarker_fda_test_use; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_18447_fk_biomarker_fda_test_use ON oncomx_v1_0_25.biomarker_fda_test_use USING btree (test_submission, test_trade_name);


--
-- Name: idx_18463_name; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE UNIQUE INDEX idx_18463_name ON oncomx_v1_0_25.disease USING btree (name);


--
-- Name: idx_18472_idx_dm_article_id; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_18472_idx_dm_article_id ON oncomx_v1_0_25.disease_mutation_article USING btree (disease_mutation_id);


--
-- Name: idx_18472_idx_dm_article_pmid; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_18472_idx_dm_article_pmid ON oncomx_v1_0_25.disease_mutation_article USING btree (pmid);


--
-- Name: idx_18477_idx_dm_impact_prediction_tool; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_18477_idx_dm_impact_prediction_tool ON oncomx_v1_0_25.disease_mutation_impact_prediction USING btree (tool);


--
-- Name: idx_18477_idx_fk_dm_impact_prediction_id; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_18477_idx_fk_dm_impact_prediction_id ON oncomx_v1_0_25.disease_mutation_impact_prediction USING btree (disease_mutation_id);


--
-- Name: idx_18492_idx_dm_site_annotation_feature; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_18492_idx_dm_site_annotation_feature ON oncomx_v1_0_25.disease_mutation_site_annotation USING btree (feature_key);


--
-- Name: idx_18492_idx_fk_dm_site_annotation_id; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_18492_idx_fk_dm_site_annotation_id ON oncomx_v1_0_25.disease_mutation_site_annotation USING btree (disease_mutation_id);


--
-- Name: idx_18499_idx_fk_disease_mutation_id; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_18499_idx_fk_disease_mutation_id ON oncomx_v1_0_25.disease_mutation_tissue USING btree (disease_mutation_id);


--
-- Name: idx_18499_idx_fk_uberon_id; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_18499_idx_fk_uberon_id ON oncomx_v1_0_25.disease_mutation_tissue USING btree (uberon_anatomical_id);


--
-- Name: idx_18502_fk_ensg_he_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_18502_fk_ensg_he_idx ON oncomx_v1_0_25.healthy_expression USING btree (ensembl_gene_id);


--
-- Name: idx_18502_fk_stage_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_18502_fk_stage_idx ON oncomx_v1_0_25.healthy_expression USING btree (uberon_developmental_id);


--
-- Name: idx_18502_fk_uberon_he_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_18502_fk_uberon_he_idx ON oncomx_v1_0_25.healthy_expression USING btree (uberon_anatomical_id);


--
-- Name: idx_18517_idx_fk_uniprotkb_ac; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_18517_idx_fk_uniprotkb_ac ON oncomx_v1_0_25.map_protein_disease_mutation USING btree (uniprotkb_ac);


--
-- Name: idx_18517_peptide_id; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE UNIQUE INDEX idx_18517_peptide_id ON oncomx_v1_0_25.map_protein_disease_mutation USING btree (peptide_id);


--
-- Name: idx_18520_idx_uniprotkb_canonical_ac; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_18520_idx_uniprotkb_canonical_ac ON oncomx_v1_0_25.map_uniprot_canonical_id USING btree (uniprotkb_canonical_ac);


--
-- Name: idx_18532_fk_gene_speciesid; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_18532_fk_gene_speciesid ON oncomx_v1_0_25.xref_gene_ensembl USING btree (speciesid);


--
-- Name: idx_18532_xref_ensg_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_18532_xref_ensg_idx ON oncomx_v1_0_25.xref_gene_ensembl USING btree (gene_symbol);


--
-- Name: idx_26577_fk_doid_cancer_tissue_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_26577_fk_doid_cancer_tissue_idx ON oncomx_v1_0_25.cancer_tissue USING btree (doid);


--
-- Name: idx_26577_fk_uberon_cancer_tissue_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_26577_fk_uberon_cancer_tissue_idx ON oncomx_v1_0_25.cancer_tissue USING btree (uberon_anatomical_id);


--
-- Name: idx_26580_idx_df_doid; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_26580_idx_df_doid ON oncomx_v1_0_25.differential_expression USING btree (doid);


--
-- Name: idx_26580_idx_gene_symbol; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_26580_idx_gene_symbol ON oncomx_v1_0_25.differential_expression USING btree (gene_symbol);


--
-- Name: idx_disease_mutation_candidate_key; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_disease_mutation_candidate_key ON oncomx_v1_0_25.disease_mutation USING btree (alt_nt, cds_pos, data_source, doid, ensembl_transcript_id);


--
-- Name: idx_dm_doid; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX idx_dm_doid ON oncomx_v1_0_25.disease_mutation USING btree (doid);


--
-- Name: map_protein_disease_mutation_ensembl_transcript_id_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX map_protein_disease_mutation_ensembl_transcript_id_gist_idx ON oncomx_v1_0_25.map_protein_disease_mutation USING gist (ensembl_transcript_id oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: map_protein_disease_mutation_peptide_id_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX map_protein_disease_mutation_peptide_id_gist_idx ON oncomx_v1_0_25.map_protein_disease_mutation USING gist (peptide_id oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: map_protein_disease_mutation_uniprotkb_ac_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX map_protein_disease_mutation_uniprotkb_ac_gist_idx ON oncomx_v1_0_25.map_protein_disease_mutation USING gist (uniprotkb_ac oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: map_uniprot_canonical_id_uniprotkb_ac_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX map_uniprot_canonical_id_uniprotkb_ac_gist_idx ON oncomx_v1_0_25.map_uniprot_canonical_id USING gist (uniprotkb_ac oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: map_uniprot_canonical_id_uniprotkb_canonical_ac_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX map_uniprot_canonical_id_uniprotkb_canonical_ac_gist_idx ON oncomx_v1_0_25.map_uniprot_canonical_id USING gist (uniprotkb_canonical_ac oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: species_genus_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX species_genus_gist_idx ON oncomx_v1_0_25.species USING gist (genus oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: species_species_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX species_species_gist_idx ON oncomx_v1_0_25.species USING gist (species oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: species_speciescommonname_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX species_speciescommonname_gist_idx ON oncomx_v1_0_25.species USING gist (speciescommonname oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: species_speciesid_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX species_speciesid_idx ON oncomx_v1_0_25.species USING btree (speciesid);


--
-- Name: stage_id_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX stage_id_gist_idx ON oncomx_v1_0_25.stage USING gist (id oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: stage_name_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX stage_name_gist_idx ON oncomx_v1_0_25.stage USING gist (name oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: xref_gene_ensembl_ensembl_gene_id_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX xref_gene_ensembl_ensembl_gene_id_gist_idx ON oncomx_v1_0_25.xref_gene_ensembl USING gist (ensembl_gene_id oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: xref_gene_ensembl_gene_symbol_gist_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX xref_gene_ensembl_gene_symbol_gist_idx ON oncomx_v1_0_25.xref_gene_ensembl USING gist (gene_symbol oncomx_v1_0_25.gist_trgm_ops);


--
-- Name: xref_gene_ensembl_speciesid_idx; Type: INDEX; Schema: oncomx_v1_0_25; Owner: postgres
--

CREATE INDEX xref_gene_ensembl_speciesid_idx ON oncomx_v1_0_25.xref_gene_ensembl USING btree (speciesid);


--
-- Name: biomarker_alias fk_biomarker_alias; Type: FK CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.biomarker_alias
    ADD CONSTRAINT fk_biomarker_alias FOREIGN KEY (biomarker_internal_id) REFERENCES oncomx_v1_0_25.biomarker(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: biomarker_article fk_biomarker_article; Type: FK CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.biomarker_article
    ADD CONSTRAINT fk_biomarker_article FOREIGN KEY (biomarker_internal_id) REFERENCES oncomx_v1_0_25.biomarker(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: biomarker_edrn fk_biomarker_edrn_anat; Type: FK CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.biomarker_edrn
    ADD CONSTRAINT fk_biomarker_edrn_anat FOREIGN KEY (uberon_anatomical_id) REFERENCES oncomx_v1_0_25.anatomical_entity(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: biomarker_edrn fk_biomarker_edrn_id; Type: FK CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.biomarker_edrn
    ADD CONSTRAINT fk_biomarker_edrn_id FOREIGN KEY (id) REFERENCES oncomx_v1_0_25.biomarker(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: biomarker_fda_drug fk_biomarker_fda_drug; Type: FK CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.biomarker_fda_drug
    ADD CONSTRAINT fk_biomarker_fda_drug FOREIGN KEY (biomarker_fda_id) REFERENCES oncomx_v1_0_25.biomarker_fda(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: biomarker_fda fk_biomarker_fda_id; Type: FK CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.biomarker_fda
    ADD CONSTRAINT fk_biomarker_fda_id FOREIGN KEY (id) REFERENCES oncomx_v1_0_25.biomarker(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: biomarker_fda_ncit_term fk_biomarker_fda_ncit; Type: FK CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.biomarker_fda_ncit_term
    ADD CONSTRAINT fk_biomarker_fda_ncit FOREIGN KEY (biomarker_fda_id) REFERENCES oncomx_v1_0_25.biomarker_fda(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: biomarker_fda fk_biomarker_fda_test; Type: FK CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.biomarker_fda
    ADD CONSTRAINT fk_biomarker_fda_test FOREIGN KEY (test_submission, test_trade_name) REFERENCES oncomx_v1_0_25.biomarker_fda_test(test_submission, test_trade_name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: biomarker_fda_test fk_biomarker_fda_test_doid; Type: FK CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.biomarker_fda_test
    ADD CONSTRAINT fk_biomarker_fda_test_doid FOREIGN KEY (doid) REFERENCES oncomx_v1_0_25.disease(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: biomarker_fda_test_trial fk_biomarker_fda_test_trial; Type: FK CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.biomarker_fda_test_trial
    ADD CONSTRAINT fk_biomarker_fda_test_trial FOREIGN KEY (test_submission, test_trade_name) REFERENCES oncomx_v1_0_25.biomarker_fda_test(test_submission, test_trade_name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: biomarker_fda_test_use fk_biomarker_fda_test_use; Type: FK CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.biomarker_fda_test_use
    ADD CONSTRAINT fk_biomarker_fda_test_use FOREIGN KEY (test_submission, test_trade_name) REFERENCES oncomx_v1_0_25.biomarker_fda_test(test_submission, test_trade_name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: differential_expression fk_df_doid; Type: FK CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.differential_expression
    ADD CONSTRAINT fk_df_doid FOREIGN KEY (doid) REFERENCES oncomx_v1_0_25.disease(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: disease_mutation fk_disease_mutation_doid; Type: FK CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.disease_mutation
    ADD CONSTRAINT fk_disease_mutation_doid FOREIGN KEY (doid) REFERENCES oncomx_v1_0_25.disease(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: disease_mutation_article fk_dm_article_id; Type: FK CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.disease_mutation_article
    ADD CONSTRAINT fk_dm_article_id FOREIGN KEY (disease_mutation_id) REFERENCES oncomx_v1_0_25.disease_mutation(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: disease_mutation_impact_prediction fk_dm_impact_prediction_id; Type: FK CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.disease_mutation_impact_prediction
    ADD CONSTRAINT fk_dm_impact_prediction_id FOREIGN KEY (disease_mutation_id) REFERENCES oncomx_v1_0_25.disease_mutation(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: disease_mutation_site_annotation fk_dm_site_annotation_id; Type: FK CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.disease_mutation_site_annotation
    ADD CONSTRAINT fk_dm_site_annotation_id FOREIGN KEY (disease_mutation_id) REFERENCES oncomx_v1_0_25.disease_mutation(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cancer_tissue fk_doid_cancer_tissue; Type: FK CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.cancer_tissue
    ADD CONSTRAINT fk_doid_cancer_tissue FOREIGN KEY (doid) REFERENCES oncomx_v1_0_25.disease(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: disease_mutation fk_ensembl_transcript; Type: FK CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.disease_mutation
    ADD CONSTRAINT fk_ensembl_transcript FOREIGN KEY (ensembl_transcript_id) REFERENCES oncomx_v1_0_25.map_protein_disease_mutation(ensembl_transcript_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: healthy_expression fk_ensg_he; Type: FK CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.healthy_expression
    ADD CONSTRAINT fk_ensg_he FOREIGN KEY (ensembl_gene_id) REFERENCES oncomx_v1_0_25.xref_gene_ensembl(ensembl_gene_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: xref_gene_ensembl fk_gene_speciesid; Type: FK CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.xref_gene_ensembl
    ADD CONSTRAINT fk_gene_speciesid FOREIGN KEY (speciesid) REFERENCES oncomx_v1_0_25.species(speciesid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: healthy_expression fk_stage; Type: FK CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.healthy_expression
    ADD CONSTRAINT fk_stage FOREIGN KEY (uberon_developmental_id) REFERENCES oncomx_v1_0_25.stage(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cancer_tissue fk_uberon_cancer_tissue; Type: FK CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.cancer_tissue
    ADD CONSTRAINT fk_uberon_cancer_tissue FOREIGN KEY (uberon_anatomical_id) REFERENCES oncomx_v1_0_25.anatomical_entity(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: healthy_expression fk_uberon_he; Type: FK CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.healthy_expression
    ADD CONSTRAINT fk_uberon_he FOREIGN KEY (uberon_anatomical_id) REFERENCES oncomx_v1_0_25.anatomical_entity(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: map_protein_disease_mutation fk_uniprotkb_ac; Type: FK CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.map_protein_disease_mutation
    ADD CONSTRAINT fk_uniprotkb_ac FOREIGN KEY (uniprotkb_ac) REFERENCES oncomx_v1_0_25.map_uniprot_canonical_id(uniprotkb_ac) ON UPDATE CASCADE;


--
-- Name: disease_mutation_tissue idx_fk_disease_mutation_id; Type: FK CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.disease_mutation_tissue
    ADD CONSTRAINT idx_fk_disease_mutation_id FOREIGN KEY (disease_mutation_id) REFERENCES oncomx_v1_0_25.disease_mutation(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: disease_mutation_tissue idx_fk_disease_mutation_uberon; Type: FK CONSTRAINT; Schema: oncomx_v1_0_25; Owner: postgres
--

ALTER TABLE ONLY oncomx_v1_0_25.disease_mutation_tissue
    ADD CONSTRAINT idx_fk_disease_mutation_uberon FOREIGN KEY (uberon_anatomical_id) REFERENCES oncomx_v1_0_25.anatomical_entity(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: DATABASE oncomx_v1_0_25_small; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON DATABASE oncomx_v1_0_25_small FROM PUBLIC;
REVOKE ALL ON DATABASE oncomx_v1_0_25_small FROM postgres;
GRANT ALL ON DATABASE oncomx_v1_0_25_small TO postgres;


--
-- Name: SCHEMA oncomx_v1_0_25; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA oncomx_v1_0_25 FROM PUBLIC;
REVOKE ALL ON SCHEMA oncomx_v1_0_25 FROM postgres;
GRANT ALL ON SCHEMA oncomx_v1_0_25 TO postgres;


--
-- PostgreSQL database dump complete
--

