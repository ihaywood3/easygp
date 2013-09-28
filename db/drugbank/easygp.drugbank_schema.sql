--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.9
-- Dumped by pg_dump version 9.1.9
-- Started on 2013-09-28 13:01:55 EST

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 20 (class 2615 OID 20971)
-- Name: drugbank; Type: SCHEMA; Schema: -; Owner: easygp
--

CREATE SCHEMA drugbank;


ALTER SCHEMA drugbank OWNER TO easygp;

--
-- TOC entry 4496 (class 0 OID 0)
-- Dependencies: 20
-- Name: SCHEMA drugbank; Type: COMMENT; Schema: -; Owner: easygp
--

COMMENT ON SCHEMA drugbank IS 'http://drugbank.ca derived drug reference data';


SET search_path = drugbank, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 862 (class 1259 OID 23973)
-- Dependencies: 20
-- Name: atc_codes; Type: TABLE; Schema: drugbank; Owner: easygp; Tablespace: 
--

CREATE TABLE atc_codes (
    pk integer NOT NULL,
    atc_code text
);


ALTER TABLE drugbank.atc_codes OWNER TO easygp;

--
-- TOC entry 863 (class 1259 OID 23979)
-- Dependencies: 862 20
-- Name: atc_codes_pk_seq; Type: SEQUENCE; Schema: drugbank; Owner: easygp
--

CREATE SEQUENCE atc_codes_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE drugbank.atc_codes_pk_seq OWNER TO easygp;

--
-- TOC entry 4499 (class 0 OID 0)
-- Dependencies: 863
-- Name: atc_codes_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: easygp
--

ALTER SEQUENCE atc_codes_pk_seq OWNED BY atc_codes.pk;


--
-- TOC entry 864 (class 1259 OID 23981)
-- Dependencies: 20
-- Name: brands; Type: TABLE; Schema: drugbank; Owner: easygp; Tablespace: 
--

CREATE TABLE brands (
    pk integer NOT NULL,
    name text,
    fk_drug integer
);


ALTER TABLE drugbank.brands OWNER TO easygp;

--
-- TOC entry 865 (class 1259 OID 23987)
-- Dependencies: 864 20
-- Name: brands_pk_seq; Type: SEQUENCE; Schema: drugbank; Owner: easygp
--

CREATE SEQUENCE brands_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE drugbank.brands_pk_seq OWNER TO easygp;

--
-- TOC entry 4501 (class 0 OID 0)
-- Dependencies: 865
-- Name: brands_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: easygp
--

ALTER SEQUENCE brands_pk_seq OWNED BY brands.pk;


--
-- TOC entry 866 (class 1259 OID 23989)
-- Dependencies: 20
-- Name: categories; Type: TABLE; Schema: drugbank; Owner: easygp; Tablespace: 
--

CREATE TABLE categories (
    pk integer NOT NULL,
    category text
);


ALTER TABLE drugbank.categories OWNER TO easygp;

--
-- TOC entry 867 (class 1259 OID 23995)
-- Dependencies: 866 20
-- Name: categories_pk_seq; Type: SEQUENCE; Schema: drugbank; Owner: easygp
--

CREATE SEQUENCE categories_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE drugbank.categories_pk_seq OWNER TO easygp;

--
-- TOC entry 4503 (class 0 OID 0)
-- Dependencies: 867
-- Name: categories_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: easygp
--

ALTER SEQUENCE categories_pk_seq OWNED BY categories.pk;


--
-- TOC entry 868 (class 1259 OID 23997)
-- Dependencies: 20
-- Name: dosage; Type: TABLE; Schema: drugbank; Owner: easygp; Tablespace: 
--

CREATE TABLE dosage (
    pk integer NOT NULL,
    form text,
    route text,
    strength text
);


ALTER TABLE drugbank.dosage OWNER TO easygp;

--
-- TOC entry 869 (class 1259 OID 24003)
-- Dependencies: 868 20
-- Name: dosage_pl_seq; Type: SEQUENCE; Schema: drugbank; Owner: easygp
--

CREATE SEQUENCE dosage_pl_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE drugbank.dosage_pl_seq OWNER TO easygp;

--
-- TOC entry 4505 (class 0 OID 0)
-- Dependencies: 869
-- Name: dosage_pl_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: easygp
--

ALTER SEQUENCE dosage_pl_seq OWNED BY dosage.pk;


--
-- TOC entry 870 (class 1259 OID 24005)
-- Dependencies: 20
-- Name: drug; Type: TABLE; Schema: drugbank; Owner: easygp; Tablespace: 
--

CREATE TABLE drug (
    pk integer NOT NULL,
    drugbank_id character(7) NOT NULL,
    description text,
    cas_number text,
    indication text,
    pharmacology text,
    mechanism_of_action text,
    toxicity text,
    biotransformation text,
    absorption text,
    half_life text,
    route_of_elimination text,
    volume_of_distribution text,
    clearance text,
    name text
);


ALTER TABLE drugbank.drug OWNER TO easygp;

--
-- TOC entry 4506 (class 0 OID 0)
-- Dependencies: 870
-- Name: TABLE drug; Type: COMMENT; Schema: drugbank; Owner: easygp
--

COMMENT ON TABLE drug IS 'Individual substance';


--
-- TOC entry 4507 (class 0 OID 0)
-- Dependencies: 870
-- Name: COLUMN drug.name; Type: COMMENT; Schema: drugbank; Owner: easygp
--

COMMENT ON COLUMN drug.name IS 'should be INN, but isn''t always';


--
-- TOC entry 871 (class 1259 OID 24011)
-- Dependencies: 20
-- Name: drug_interactions; Type: TABLE; Schema: drugbank; Owner: easygp; Tablespace: 
--

CREATE TABLE drug_interactions (
    pk integer NOT NULL,
    fk_drug integer,
    fk_interacts_with integer,
    description text
);


ALTER TABLE drugbank.drug_interactions OWNER TO easygp;

--
-- TOC entry 4509 (class 0 OID 0)
-- Dependencies: 871
-- Name: COLUMN drug_interactions.description; Type: COMMENT; Schema: drugbank; Owner: easygp
--

COMMENT ON COLUMN drug_interactions.description IS 'description of the interaction';


--
-- TOC entry 872 (class 1259 OID 24017)
-- Dependencies: 871 20
-- Name: drug_interactions_pk_seq; Type: SEQUENCE; Schema: drugbank; Owner: easygp
--

CREATE SEQUENCE drug_interactions_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE drugbank.drug_interactions_pk_seq OWNER TO easygp;

--
-- TOC entry 4511 (class 0 OID 0)
-- Dependencies: 872
-- Name: drug_interactions_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: easygp
--

ALTER SEQUENCE drug_interactions_pk_seq OWNED BY drug_interactions.pk;


--
-- TOC entry 873 (class 1259 OID 24019)
-- Dependencies: 870 20
-- Name: drug_pk_seq; Type: SEQUENCE; Schema: drugbank; Owner: easygp
--

CREATE SEQUENCE drug_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE drugbank.drug_pk_seq OWNER TO easygp;

--
-- TOC entry 4512 (class 0 OID 0)
-- Dependencies: 873
-- Name: drug_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: easygp
--

ALTER SEQUENCE drug_pk_seq OWNED BY drug.pk;


--
-- TOC entry 874 (class 1259 OID 24021)
-- Dependencies: 20
-- Name: external_links; Type: TABLE; Schema: drugbank; Owner: easygp; Tablespace: 
--

CREATE TABLE external_links (
    pk integer NOT NULL,
    fk_external_resource integer,
    external_link text,
    fk_drug integer
);


ALTER TABLE drugbank.external_links OWNER TO easygp;

--
-- TOC entry 875 (class 1259 OID 24027)
-- Dependencies: 874 20
-- Name: external_links_pk_seq; Type: SEQUENCE; Schema: drugbank; Owner: easygp
--

CREATE SEQUENCE external_links_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE drugbank.external_links_pk_seq OWNER TO easygp;

--
-- TOC entry 4514 (class 0 OID 0)
-- Dependencies: 875
-- Name: external_links_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: easygp
--

ALTER SEQUENCE external_links_pk_seq OWNED BY external_links.pk;


--
-- TOC entry 876 (class 1259 OID 24029)
-- Dependencies: 20
-- Name: food_interactions; Type: TABLE; Schema: drugbank; Owner: easygp; Tablespace: 
--

CREATE TABLE food_interactions (
    pk integer NOT NULL,
    fk_drug integer,
    food_interaction text
);


ALTER TABLE drugbank.food_interactions OWNER TO easygp;

--
-- TOC entry 877 (class 1259 OID 24035)
-- Dependencies: 876 20
-- Name: food_interactions_pk_seq; Type: SEQUENCE; Schema: drugbank; Owner: easygp
--

CREATE SEQUENCE food_interactions_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE drugbank.food_interactions_pk_seq OWNER TO easygp;

--
-- TOC entry 4516 (class 0 OID 0)
-- Dependencies: 877
-- Name: food_interactions_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: easygp
--

ALTER SEQUENCE food_interactions_pk_seq OWNED BY food_interactions.pk;


--
-- TOC entry 878 (class 1259 OID 24037)
-- Dependencies: 20
-- Name: general_references; Type: TABLE; Schema: drugbank; Owner: easygp; Tablespace: 
--

CREATE TABLE general_references (
    pk integer NOT NULL,
    reference text,
    fk_drug integer
);


ALTER TABLE drugbank.general_references OWNER TO easygp;

--
-- TOC entry 4517 (class 0 OID 0)
-- Dependencies: 878
-- Name: TABLE general_references; Type: COMMENT; Schema: drugbank; Owner: easygp
--

COMMENT ON TABLE general_references IS 'literature and other references to a drug';


--
-- TOC entry 879 (class 1259 OID 24043)
-- Dependencies: 878 20
-- Name: general_references_pk_seq; Type: SEQUENCE; Schema: drugbank; Owner: easygp
--

CREATE SEQUENCE general_references_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE drugbank.general_references_pk_seq OWNER TO easygp;

--
-- TOC entry 4519 (class 0 OID 0)
-- Dependencies: 879
-- Name: general_references_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: easygp
--

ALTER SEQUENCE general_references_pk_seq OWNED BY general_references.pk;


--
-- TOC entry 880 (class 1259 OID 24045)
-- Dependencies: 20
-- Name: link_drug_to_atc_code; Type: TABLE; Schema: drugbank; Owner: easygp; Tablespace: 
--

CREATE TABLE link_drug_to_atc_code (
    pk integer NOT NULL,
    fk_drug integer,
    fk_atc_code integer
);


ALTER TABLE drugbank.link_drug_to_atc_code OWNER TO easygp;

--
-- TOC entry 881 (class 1259 OID 24048)
-- Dependencies: 880 20
-- Name: link_drug_to_atc_code_pk_seq; Type: SEQUENCE; Schema: drugbank; Owner: easygp
--

CREATE SEQUENCE link_drug_to_atc_code_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE drugbank.link_drug_to_atc_code_pk_seq OWNER TO easygp;

--
-- TOC entry 4521 (class 0 OID 0)
-- Dependencies: 881
-- Name: link_drug_to_atc_code_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: easygp
--

ALTER SEQUENCE link_drug_to_atc_code_pk_seq OWNED BY link_drug_to_atc_code.pk;


--
-- TOC entry 882 (class 1259 OID 24050)
-- Dependencies: 20
-- Name: link_drug_to_category; Type: TABLE; Schema: drugbank; Owner: easygp; Tablespace: 
--

CREATE TABLE link_drug_to_category (
    pk integer NOT NULL,
    fk_drug integer,
    fk_category integer
);


ALTER TABLE drugbank.link_drug_to_category OWNER TO easygp;

--
-- TOC entry 883 (class 1259 OID 24053)
-- Dependencies: 882 20
-- Name: link_drug_to_category_pk_seq; Type: SEQUENCE; Schema: drugbank; Owner: easygp
--

CREATE SEQUENCE link_drug_to_category_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE drugbank.link_drug_to_category_pk_seq OWNER TO easygp;

--
-- TOC entry 4523 (class 0 OID 0)
-- Dependencies: 883
-- Name: link_drug_to_category_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: easygp
--

ALTER SEQUENCE link_drug_to_category_pk_seq OWNED BY link_drug_to_category.pk;


--
-- TOC entry 884 (class 1259 OID 24055)
-- Dependencies: 20
-- Name: link_drug_to_dosage; Type: TABLE; Schema: drugbank; Owner: easygp; Tablespace: 
--

CREATE TABLE link_drug_to_dosage (
    pk integer NOT NULL,
    fk_drug integer,
    fk_dosage integer
);


ALTER TABLE drugbank.link_drug_to_dosage OWNER TO easygp;

--
-- TOC entry 885 (class 1259 OID 24058)
-- Dependencies: 884 20
-- Name: link_drug_to_dosage_pk_seq; Type: SEQUENCE; Schema: drugbank; Owner: easygp
--

CREATE SEQUENCE link_drug_to_dosage_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE drugbank.link_drug_to_dosage_pk_seq OWNER TO easygp;

--
-- TOC entry 4525 (class 0 OID 0)
-- Dependencies: 885
-- Name: link_drug_to_dosage_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: easygp
--

ALTER SEQUENCE link_drug_to_dosage_pk_seq OWNED BY link_drug_to_dosage.pk;


--
-- TOC entry 886 (class 1259 OID 24060)
-- Dependencies: 20
-- Name: lu_external_resources; Type: TABLE; Schema: drugbank; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_external_resources (
    pk integer NOT NULL,
    resource text
);


ALTER TABLE drugbank.lu_external_resources OWNER TO easygp;

--
-- TOC entry 887 (class 1259 OID 24066)
-- Dependencies: 886 20
-- Name: lu_external_resources_pk_seq; Type: SEQUENCE; Schema: drugbank; Owner: easygp
--

CREATE SEQUENCE lu_external_resources_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE drugbank.lu_external_resources_pk_seq OWNER TO easygp;

--
-- TOC entry 4527 (class 0 OID 0)
-- Dependencies: 887
-- Name: lu_external_resources_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: easygp
--

ALTER SEQUENCE lu_external_resources_pk_seq OWNED BY lu_external_resources.pk;


--
-- TOC entry 888 (class 1259 OID 24068)
-- Dependencies: 20
-- Name: patents; Type: TABLE; Schema: drugbank; Owner: easygp; Tablespace: 
--

CREATE TABLE patents (
    pk integer NOT NULL,
    fk_drug integer,
    patent_number text,
    country text,
    approved date,
    expires date
);


ALTER TABLE drugbank.patents OWNER TO easygp;

--
-- TOC entry 889 (class 1259 OID 24074)
-- Dependencies: 888 20
-- Name: patents_pk_seq; Type: SEQUENCE; Schema: drugbank; Owner: easygp
--

CREATE SEQUENCE patents_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE drugbank.patents_pk_seq OWNER TO easygp;

--
-- TOC entry 4529 (class 0 OID 0)
-- Dependencies: 889
-- Name: patents_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: easygp
--

ALTER SEQUENCE patents_pk_seq OWNED BY patents.pk;


--
-- TOC entry 890 (class 1259 OID 24076)
-- Dependencies: 20
-- Name: pregnancy_code; Type: TABLE; Schema: drugbank; Owner: easygp; Tablespace: 
--

CREATE TABLE pregnancy_code (
    pk integer NOT NULL,
    fk_drug integer,
    code character(2),
    safety text
);


ALTER TABLE drugbank.pregnancy_code OWNER TO easygp;

--
-- TOC entry 891 (class 1259 OID 24082)
-- Dependencies: 890 20
-- Name: pregnancy_code_pk_seq; Type: SEQUENCE; Schema: drugbank; Owner: easygp
--

CREATE SEQUENCE pregnancy_code_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE drugbank.pregnancy_code_pk_seq OWNER TO easygp;

--
-- TOC entry 4531 (class 0 OID 0)
-- Dependencies: 891
-- Name: pregnancy_code_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: easygp
--

ALTER SEQUENCE pregnancy_code_pk_seq OWNED BY pregnancy_code.pk;


--
-- TOC entry 892 (class 1259 OID 24084)
-- Dependencies: 20
-- Name: salts; Type: TABLE; Schema: drugbank; Owner: easygp; Tablespace: 
--

CREATE TABLE salts (
    pk integer NOT NULL,
    fk_drug integer,
    salt text
);


ALTER TABLE drugbank.salts OWNER TO easygp;

--
-- TOC entry 893 (class 1259 OID 24090)
-- Dependencies: 892 20
-- Name: salts_pk_seq; Type: SEQUENCE; Schema: drugbank; Owner: easygp
--

CREATE SEQUENCE salts_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE drugbank.salts_pk_seq OWNER TO easygp;

--
-- TOC entry 4533 (class 0 OID 0)
-- Dependencies: 893
-- Name: salts_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: easygp
--

ALTER SEQUENCE salts_pk_seq OWNED BY salts.pk;


--
-- TOC entry 894 (class 1259 OID 24092)
-- Dependencies: 20
-- Name: synonyms; Type: TABLE; Schema: drugbank; Owner: easygp; Tablespace: 
--

CREATE TABLE synonyms (
    pk integer NOT NULL,
    fk_drug integer,
    name text
);


ALTER TABLE drugbank.synonyms OWNER TO easygp;

--
-- TOC entry 895 (class 1259 OID 24098)
-- Dependencies: 894 20
-- Name: synonyms_pk_seq; Type: SEQUENCE; Schema: drugbank; Owner: easygp
--

CREATE SEQUENCE synonyms_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE drugbank.synonyms_pk_seq OWNER TO easygp;

--
-- TOC entry 4535 (class 0 OID 0)
-- Dependencies: 895
-- Name: synonyms_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: easygp
--

ALTER SEQUENCE synonyms_pk_seq OWNED BY synonyms.pk;


--
-- TOC entry 896 (class 1259 OID 24100)
-- Dependencies: 4390 20
-- Name: vwatcdrugfoodinteractions; Type: VIEW; Schema: drugbank; Owner: easygp
--

CREATE VIEW vwatcdrugfoodinteractions AS
    SELECT atc_codes.atc_code, drug.name, food_interactions.pk, food_interactions.food_interaction FROM food_interactions, link_drug_to_atc_code, drug, atc_codes WHERE (((food_interactions.fk_drug = link_drug_to_atc_code.fk_drug) AND (link_drug_to_atc_code.fk_drug = drug.pk)) AND (link_drug_to_atc_code.fk_atc_code = atc_codes.pk));


ALTER TABLE drugbank.vwatcdrugfoodinteractions OWNER TO easygp;

--
-- TOC entry 4536 (class 0 OID 0)
-- Dependencies: 896
-- Name: VIEW vwatcdrugfoodinteractions; Type: COMMENT; Schema: drugbank; Owner: easygp
--

COMMENT ON VIEW vwatcdrugfoodinteractions IS 'a view of drugs atccode linked to food interactions';


--
-- TOC entry 897 (class 1259 OID 24104)
-- Dependencies: 4391 20
-- Name: vwdrugatccodeinteractions; Type: VIEW; Schema: drugbank; Owner: easygp
--

CREATE VIEW vwdrugatccodeinteractions AS
    SELECT drug_interactions.pk AS pk_view, drug.name, atc1.atc_code, drug1.name AS drug_interacts_with, drug_interactions.description, atc2.atc_code AS atc_code_interacts_with FROM ((((((drug JOIN drug_interactions ON ((drug.pk = drug_interactions.fk_drug))) JOIN link_drug_to_atc_code ON ((drug.pk = link_drug_to_atc_code.fk_drug))) JOIN atc_codes atc1 ON ((link_drug_to_atc_code.fk_atc_code = atc1.pk))) JOIN drug drug1 ON ((drug_interactions.fk_interacts_with = drug1.pk))) JOIN link_drug_to_atc_code link_drug_atc2 ON ((drug1.pk = link_drug_atc2.fk_drug))) JOIN atc_codes atc2 ON ((link_drug_atc2.fk_atc_code = atc2.pk)));


ALTER TABLE drugbank.vwdrugatccodeinteractions OWNER TO easygp;

--
-- TOC entry 4416 (class 2604 OID 24662)
-- Dependencies: 863 862
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY atc_codes ALTER COLUMN pk SET DEFAULT nextval('atc_codes_pk_seq'::regclass);


--
-- TOC entry 4417 (class 2604 OID 24663)
-- Dependencies: 865 864
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY brands ALTER COLUMN pk SET DEFAULT nextval('brands_pk_seq'::regclass);


--
-- TOC entry 4418 (class 2604 OID 24664)
-- Dependencies: 867 866
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY categories ALTER COLUMN pk SET DEFAULT nextval('categories_pk_seq'::regclass);


--
-- TOC entry 4419 (class 2604 OID 24665)
-- Dependencies: 869 868
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY dosage ALTER COLUMN pk SET DEFAULT nextval('dosage_pl_seq'::regclass);


--
-- TOC entry 4420 (class 2604 OID 24666)
-- Dependencies: 873 870
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY drug ALTER COLUMN pk SET DEFAULT nextval('drug_pk_seq'::regclass);


--
-- TOC entry 4421 (class 2604 OID 24667)
-- Dependencies: 872 871
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY drug_interactions ALTER COLUMN pk SET DEFAULT nextval('drug_interactions_pk_seq'::regclass);


--
-- TOC entry 4422 (class 2604 OID 24668)
-- Dependencies: 875 874
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY external_links ALTER COLUMN pk SET DEFAULT nextval('external_links_pk_seq'::regclass);


--
-- TOC entry 4423 (class 2604 OID 24669)
-- Dependencies: 877 876
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY food_interactions ALTER COLUMN pk SET DEFAULT nextval('food_interactions_pk_seq'::regclass);


--
-- TOC entry 4424 (class 2604 OID 24670)
-- Dependencies: 879 878
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY general_references ALTER COLUMN pk SET DEFAULT nextval('general_references_pk_seq'::regclass);


--
-- TOC entry 4425 (class 2604 OID 24671)
-- Dependencies: 881 880
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY link_drug_to_atc_code ALTER COLUMN pk SET DEFAULT nextval('link_drug_to_atc_code_pk_seq'::regclass);


--
-- TOC entry 4426 (class 2604 OID 24672)
-- Dependencies: 883 882
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY link_drug_to_category ALTER COLUMN pk SET DEFAULT nextval('link_drug_to_category_pk_seq'::regclass);


--
-- TOC entry 4427 (class 2604 OID 24673)
-- Dependencies: 885 884
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY link_drug_to_dosage ALTER COLUMN pk SET DEFAULT nextval('link_drug_to_dosage_pk_seq'::regclass);


--
-- TOC entry 4428 (class 2604 OID 24674)
-- Dependencies: 887 886
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY lu_external_resources ALTER COLUMN pk SET DEFAULT nextval('lu_external_resources_pk_seq'::regclass);


--
-- TOC entry 4429 (class 2604 OID 24675)
-- Dependencies: 889 888
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY patents ALTER COLUMN pk SET DEFAULT nextval('patents_pk_seq'::regclass);


--
-- TOC entry 4430 (class 2604 OID 24676)
-- Dependencies: 891 890
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY pregnancy_code ALTER COLUMN pk SET DEFAULT nextval('pregnancy_code_pk_seq'::regclass);


--
-- TOC entry 4431 (class 2604 OID 24677)
-- Dependencies: 893 892
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY salts ALTER COLUMN pk SET DEFAULT nextval('salts_pk_seq'::regclass);


--
-- TOC entry 4432 (class 2604 OID 24678)
-- Dependencies: 895 894
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY synonyms ALTER COLUMN pk SET DEFAULT nextval('synonyms_pk_seq'::regclass);


--
-- TOC entry 4434 (class 2606 OID 41013)
-- Dependencies: 862 862 4493
-- Name: atc_codes_atc-code_key; Type: CONSTRAINT; Schema: drugbank; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY atc_codes
    ADD CONSTRAINT "atc_codes_atc-code_key" UNIQUE (atc_code);


--
-- TOC entry 4436 (class 2606 OID 41015)
-- Dependencies: 862 862 4493
-- Name: atc_codes_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY atc_codes
    ADD CONSTRAINT atc_codes_pkey PRIMARY KEY (pk);


--
-- TOC entry 4438 (class 2606 OID 41017)
-- Dependencies: 864 864 4493
-- Name: brands_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY brands
    ADD CONSTRAINT brands_pkey PRIMARY KEY (pk);


--
-- TOC entry 4440 (class 2606 OID 41019)
-- Dependencies: 866 866 4493
-- Name: categories_category_key; Type: CONSTRAINT; Schema: drugbank; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_category_key UNIQUE (category);


--
-- TOC entry 4442 (class 2606 OID 41021)
-- Dependencies: 866 866 4493
-- Name: categories_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (pk);


--
-- TOC entry 4444 (class 2606 OID 41023)
-- Dependencies: 868 868 4493
-- Name: dosage_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY dosage
    ADD CONSTRAINT dosage_pkey PRIMARY KEY (pk);


--
-- TOC entry 4446 (class 2606 OID 41025)
-- Dependencies: 870 870 4493
-- Name: drug_drugbank_id_key; Type: CONSTRAINT; Schema: drugbank; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY drug
    ADD CONSTRAINT drug_drugbank_id_key UNIQUE (drugbank_id);


--
-- TOC entry 4450 (class 2606 OID 41027)
-- Dependencies: 871 871 4493
-- Name: drug_interactions_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY drug_interactions
    ADD CONSTRAINT drug_interactions_pkey PRIMARY KEY (pk);


--
-- TOC entry 4448 (class 2606 OID 41029)
-- Dependencies: 870 870 4493
-- Name: drug_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY drug
    ADD CONSTRAINT drug_pkey PRIMARY KEY (pk);


--
-- TOC entry 4452 (class 2606 OID 41031)
-- Dependencies: 874 874 4493
-- Name: external_links_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY external_links
    ADD CONSTRAINT external_links_pkey PRIMARY KEY (pk);


--
-- TOC entry 4454 (class 2606 OID 41033)
-- Dependencies: 876 876 4493
-- Name: food_interactions_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY food_interactions
    ADD CONSTRAINT food_interactions_pkey PRIMARY KEY (pk);


--
-- TOC entry 4456 (class 2606 OID 41035)
-- Dependencies: 878 878 4493
-- Name: general_references_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY general_references
    ADD CONSTRAINT general_references_pkey PRIMARY KEY (pk);


--
-- TOC entry 4458 (class 2606 OID 41037)
-- Dependencies: 880 880 4493
-- Name: link_drug_to_atc_code_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY link_drug_to_atc_code
    ADD CONSTRAINT link_drug_to_atc_code_pkey PRIMARY KEY (pk);


--
-- TOC entry 4460 (class 2606 OID 41039)
-- Dependencies: 882 882 4493
-- Name: link_drug_to_category_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY link_drug_to_category
    ADD CONSTRAINT link_drug_to_category_pkey PRIMARY KEY (pk);


--
-- TOC entry 4462 (class 2606 OID 41041)
-- Dependencies: 884 884 4493
-- Name: link_drug_to_dosage_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY link_drug_to_dosage
    ADD CONSTRAINT link_drug_to_dosage_pkey PRIMARY KEY (pk);


--
-- TOC entry 4464 (class 2606 OID 41043)
-- Dependencies: 886 886 4493
-- Name: lu_external_resources_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_external_resources
    ADD CONSTRAINT lu_external_resources_pkey PRIMARY KEY (pk);


--
-- TOC entry 4466 (class 2606 OID 41045)
-- Dependencies: 886 886 4493
-- Name: lu_external_resources_resource_key; Type: CONSTRAINT; Schema: drugbank; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_external_resources
    ADD CONSTRAINT lu_external_resources_resource_key UNIQUE (resource);


--
-- TOC entry 4468 (class 2606 OID 41047)
-- Dependencies: 888 888 4493
-- Name: patents_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY patents
    ADD CONSTRAINT patents_pkey PRIMARY KEY (pk);


--
-- TOC entry 4470 (class 2606 OID 41049)
-- Dependencies: 890 890 4493
-- Name: pregnancy_code_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY pregnancy_code
    ADD CONSTRAINT pregnancy_code_pkey PRIMARY KEY (pk);


--
-- TOC entry 4472 (class 2606 OID 41051)
-- Dependencies: 892 892 4493
-- Name: salts_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY salts
    ADD CONSTRAINT salts_pkey PRIMARY KEY (pk);


--
-- TOC entry 4474 (class 2606 OID 41053)
-- Dependencies: 894 894 4493
-- Name: synonyms_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY synonyms
    ADD CONSTRAINT synonyms_pkey PRIMARY KEY (pk);


--
-- TOC entry 4475 (class 2606 OID 41414)
-- Dependencies: 4447 870 864 4493
-- Name: brands_fk_drug_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY brands
    ADD CONSTRAINT brands_fk_drug_fkey FOREIGN KEY (fk_drug) REFERENCES drug(pk);


--
-- TOC entry 4476 (class 2606 OID 41419)
-- Dependencies: 4447 870 871 4493
-- Name: drug_interactions_fk_drug_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY drug_interactions
    ADD CONSTRAINT drug_interactions_fk_drug_fkey FOREIGN KEY (fk_drug) REFERENCES drug(pk);


--
-- TOC entry 4477 (class 2606 OID 41424)
-- Dependencies: 4447 870 871 4493
-- Name: drug_interactions_fk_interacts_with_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY drug_interactions
    ADD CONSTRAINT drug_interactions_fk_interacts_with_fkey FOREIGN KEY (fk_interacts_with) REFERENCES drug(pk);


--
-- TOC entry 4478 (class 2606 OID 41429)
-- Dependencies: 4447 870 874 4493
-- Name: external_links_fk_drug_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY external_links
    ADD CONSTRAINT external_links_fk_drug_fkey FOREIGN KEY (fk_drug) REFERENCES drug(pk);


--
-- TOC entry 4479 (class 2606 OID 41434)
-- Dependencies: 4463 886 874 4493
-- Name: external_links_fk_external_resource_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY external_links
    ADD CONSTRAINT external_links_fk_external_resource_fkey FOREIGN KEY (fk_external_resource) REFERENCES lu_external_resources(pk);


--
-- TOC entry 4480 (class 2606 OID 41439)
-- Dependencies: 4447 870 876 4493
-- Name: food_interactions_fk_drug_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY food_interactions
    ADD CONSTRAINT food_interactions_fk_drug_fkey FOREIGN KEY (fk_drug) REFERENCES drug(pk);


--
-- TOC entry 4481 (class 2606 OID 41444)
-- Dependencies: 4447 870 878 4493
-- Name: general_references_fk_drug_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY general_references
    ADD CONSTRAINT general_references_fk_drug_fkey FOREIGN KEY (fk_drug) REFERENCES drug(pk);


--
-- TOC entry 4482 (class 2606 OID 41449)
-- Dependencies: 4435 862 880 4493
-- Name: link_drug_to_atc_code_fk_atc_code_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY link_drug_to_atc_code
    ADD CONSTRAINT link_drug_to_atc_code_fk_atc_code_fkey FOREIGN KEY (fk_atc_code) REFERENCES atc_codes(pk);


--
-- TOC entry 4483 (class 2606 OID 41454)
-- Dependencies: 4447 870 880 4493
-- Name: link_drug_to_atc_code_fk_drug_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY link_drug_to_atc_code
    ADD CONSTRAINT link_drug_to_atc_code_fk_drug_fkey FOREIGN KEY (fk_drug) REFERENCES drug(pk);


--
-- TOC entry 4484 (class 2606 OID 41459)
-- Dependencies: 4441 866 882 4493
-- Name: link_drug_to_category_fk_category_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY link_drug_to_category
    ADD CONSTRAINT link_drug_to_category_fk_category_fkey FOREIGN KEY (fk_category) REFERENCES categories(pk);


--
-- TOC entry 4485 (class 2606 OID 41464)
-- Dependencies: 4447 870 882 4493
-- Name: link_drug_to_category_fk_drug_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY link_drug_to_category
    ADD CONSTRAINT link_drug_to_category_fk_drug_fkey FOREIGN KEY (fk_drug) REFERENCES drug(pk);


--
-- TOC entry 4486 (class 2606 OID 41469)
-- Dependencies: 4443 868 884 4493
-- Name: link_drug_to_dosage_fk_dosage_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY link_drug_to_dosage
    ADD CONSTRAINT link_drug_to_dosage_fk_dosage_fkey FOREIGN KEY (fk_dosage) REFERENCES dosage(pk);


--
-- TOC entry 4487 (class 2606 OID 41474)
-- Dependencies: 4447 870 884 4493
-- Name: link_drug_to_dosage_fk_drug_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY link_drug_to_dosage
    ADD CONSTRAINT link_drug_to_dosage_fk_drug_fkey FOREIGN KEY (fk_drug) REFERENCES drug(pk);


--
-- TOC entry 4488 (class 2606 OID 41479)
-- Dependencies: 4447 870 888 4493
-- Name: patents_fk_drug_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY patents
    ADD CONSTRAINT patents_fk_drug_fkey FOREIGN KEY (fk_drug) REFERENCES drug(pk);


--
-- TOC entry 4489 (class 2606 OID 41484)
-- Dependencies: 4447 870 890 4493
-- Name: pregnancy_code_fk_drug_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY pregnancy_code
    ADD CONSTRAINT pregnancy_code_fk_drug_fkey FOREIGN KEY (fk_drug) REFERENCES drug(pk);


--
-- TOC entry 4490 (class 2606 OID 41489)
-- Dependencies: 4447 870 892 4493
-- Name: salts_fk_drug_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY salts
    ADD CONSTRAINT salts_fk_drug_fkey FOREIGN KEY (fk_drug) REFERENCES drug(pk);


--
-- TOC entry 4491 (class 2606 OID 41494)
-- Dependencies: 4447 870 894 4493
-- Name: synonyms_fk_drug_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY synonyms
    ADD CONSTRAINT synonyms_fk_drug_fkey FOREIGN KEY (fk_drug) REFERENCES drug(pk);


--
-- TOC entry 4497 (class 0 OID 0)
-- Dependencies: 20
-- Name: drugbank; Type: ACL; Schema: -; Owner: easygp
--

REVOKE ALL ON SCHEMA drugbank FROM PUBLIC;
REVOKE ALL ON SCHEMA drugbank FROM easygp;
GRANT ALL ON SCHEMA drugbank TO easygp;
GRANT USAGE ON SCHEMA drugbank TO staff;


--
-- TOC entry 4498 (class 0 OID 0)
-- Dependencies: 862
-- Name: atc_codes; Type: ACL; Schema: drugbank; Owner: easygp
--

REVOKE ALL ON TABLE atc_codes FROM PUBLIC;
REVOKE ALL ON TABLE atc_codes FROM easygp;
GRANT ALL ON TABLE atc_codes TO easygp;
GRANT SELECT ON TABLE atc_codes TO staff;


--
-- TOC entry 4500 (class 0 OID 0)
-- Dependencies: 864
-- Name: brands; Type: ACL; Schema: drugbank; Owner: easygp
--

REVOKE ALL ON TABLE brands FROM PUBLIC;
REVOKE ALL ON TABLE brands FROM easygp;
GRANT ALL ON TABLE brands TO easygp;
GRANT SELECT ON TABLE brands TO staff;


--
-- TOC entry 4502 (class 0 OID 0)
-- Dependencies: 866
-- Name: categories; Type: ACL; Schema: drugbank; Owner: easygp
--

REVOKE ALL ON TABLE categories FROM PUBLIC;
REVOKE ALL ON TABLE categories FROM easygp;
GRANT ALL ON TABLE categories TO easygp;
GRANT SELECT ON TABLE categories TO staff;


--
-- TOC entry 4504 (class 0 OID 0)
-- Dependencies: 868
-- Name: dosage; Type: ACL; Schema: drugbank; Owner: easygp
--

REVOKE ALL ON TABLE dosage FROM PUBLIC;
REVOKE ALL ON TABLE dosage FROM easygp;
GRANT ALL ON TABLE dosage TO easygp;
GRANT SELECT ON TABLE dosage TO staff;


--
-- TOC entry 4508 (class 0 OID 0)
-- Dependencies: 870
-- Name: drug; Type: ACL; Schema: drugbank; Owner: easygp
--

REVOKE ALL ON TABLE drug FROM PUBLIC;
REVOKE ALL ON TABLE drug FROM easygp;
GRANT ALL ON TABLE drug TO easygp;
GRANT SELECT ON TABLE drug TO staff;


--
-- TOC entry 4510 (class 0 OID 0)
-- Dependencies: 871
-- Name: drug_interactions; Type: ACL; Schema: drugbank; Owner: easygp
--

REVOKE ALL ON TABLE drug_interactions FROM PUBLIC;
REVOKE ALL ON TABLE drug_interactions FROM easygp;
GRANT ALL ON TABLE drug_interactions TO easygp;
GRANT SELECT ON TABLE drug_interactions TO staff;


--
-- TOC entry 4513 (class 0 OID 0)
-- Dependencies: 874
-- Name: external_links; Type: ACL; Schema: drugbank; Owner: easygp
--

REVOKE ALL ON TABLE external_links FROM PUBLIC;
REVOKE ALL ON TABLE external_links FROM easygp;
GRANT ALL ON TABLE external_links TO easygp;
GRANT SELECT ON TABLE external_links TO staff;


--
-- TOC entry 4515 (class 0 OID 0)
-- Dependencies: 876
-- Name: food_interactions; Type: ACL; Schema: drugbank; Owner: easygp
--

REVOKE ALL ON TABLE food_interactions FROM PUBLIC;
REVOKE ALL ON TABLE food_interactions FROM easygp;
GRANT ALL ON TABLE food_interactions TO easygp;
GRANT SELECT ON TABLE food_interactions TO staff;


--
-- TOC entry 4518 (class 0 OID 0)
-- Dependencies: 878
-- Name: general_references; Type: ACL; Schema: drugbank; Owner: easygp
--

REVOKE ALL ON TABLE general_references FROM PUBLIC;
REVOKE ALL ON TABLE general_references FROM easygp;
GRANT ALL ON TABLE general_references TO easygp;
GRANT SELECT ON TABLE general_references TO staff;


--
-- TOC entry 4520 (class 0 OID 0)
-- Dependencies: 880
-- Name: link_drug_to_atc_code; Type: ACL; Schema: drugbank; Owner: easygp
--

REVOKE ALL ON TABLE link_drug_to_atc_code FROM PUBLIC;
REVOKE ALL ON TABLE link_drug_to_atc_code FROM easygp;
GRANT ALL ON TABLE link_drug_to_atc_code TO easygp;
GRANT SELECT ON TABLE link_drug_to_atc_code TO staff;


--
-- TOC entry 4522 (class 0 OID 0)
-- Dependencies: 882
-- Name: link_drug_to_category; Type: ACL; Schema: drugbank; Owner: easygp
--

REVOKE ALL ON TABLE link_drug_to_category FROM PUBLIC;
REVOKE ALL ON TABLE link_drug_to_category FROM easygp;
GRANT ALL ON TABLE link_drug_to_category TO easygp;
GRANT SELECT ON TABLE link_drug_to_category TO staff;


--
-- TOC entry 4524 (class 0 OID 0)
-- Dependencies: 884
-- Name: link_drug_to_dosage; Type: ACL; Schema: drugbank; Owner: easygp
--

REVOKE ALL ON TABLE link_drug_to_dosage FROM PUBLIC;
REVOKE ALL ON TABLE link_drug_to_dosage FROM easygp;
GRANT ALL ON TABLE link_drug_to_dosage TO easygp;
GRANT SELECT ON TABLE link_drug_to_dosage TO staff;


--
-- TOC entry 4526 (class 0 OID 0)
-- Dependencies: 886
-- Name: lu_external_resources; Type: ACL; Schema: drugbank; Owner: easygp
--

REVOKE ALL ON TABLE lu_external_resources FROM PUBLIC;
REVOKE ALL ON TABLE lu_external_resources FROM easygp;
GRANT ALL ON TABLE lu_external_resources TO easygp;
GRANT SELECT ON TABLE lu_external_resources TO staff;


--
-- TOC entry 4528 (class 0 OID 0)
-- Dependencies: 888
-- Name: patents; Type: ACL; Schema: drugbank; Owner: easygp
--

REVOKE ALL ON TABLE patents FROM PUBLIC;
REVOKE ALL ON TABLE patents FROM easygp;
GRANT ALL ON TABLE patents TO easygp;
GRANT SELECT ON TABLE patents TO staff;


--
-- TOC entry 4530 (class 0 OID 0)
-- Dependencies: 890
-- Name: pregnancy_code; Type: ACL; Schema: drugbank; Owner: easygp
--

REVOKE ALL ON TABLE pregnancy_code FROM PUBLIC;
REVOKE ALL ON TABLE pregnancy_code FROM easygp;
GRANT ALL ON TABLE pregnancy_code TO easygp;
GRANT SELECT ON TABLE pregnancy_code TO staff;


--
-- TOC entry 4532 (class 0 OID 0)
-- Dependencies: 892
-- Name: salts; Type: ACL; Schema: drugbank; Owner: easygp
--

REVOKE ALL ON TABLE salts FROM PUBLIC;
REVOKE ALL ON TABLE salts FROM easygp;
GRANT ALL ON TABLE salts TO easygp;
GRANT SELECT ON TABLE salts TO staff;


--
-- TOC entry 4534 (class 0 OID 0)
-- Dependencies: 894
-- Name: synonyms; Type: ACL; Schema: drugbank; Owner: easygp
--

REVOKE ALL ON TABLE synonyms FROM PUBLIC;
REVOKE ALL ON TABLE synonyms FROM easygp;
GRANT ALL ON TABLE synonyms TO easygp;
GRANT SELECT ON TABLE synonyms TO staff;


--
-- TOC entry 4537 (class 0 OID 0)
-- Dependencies: 896
-- Name: vwatcdrugfoodinteractions; Type: ACL; Schema: drugbank; Owner: easygp
--

REVOKE ALL ON TABLE vwatcdrugfoodinteractions FROM PUBLIC;
REVOKE ALL ON TABLE vwatcdrugfoodinteractions FROM easygp;
GRANT ALL ON TABLE vwatcdrugfoodinteractions TO easygp;
GRANT SELECT ON TABLE vwatcdrugfoodinteractions TO staff;


--
-- TOC entry 4538 (class 0 OID 0)
-- Dependencies: 897
-- Name: vwdrugatccodeinteractions; Type: ACL; Schema: drugbank; Owner: easygp
--

REVOKE ALL ON TABLE vwdrugatccodeinteractions FROM PUBLIC;
REVOKE ALL ON TABLE vwdrugatccodeinteractions FROM easygp;
GRANT ALL ON TABLE vwdrugatccodeinteractions TO easygp;
GRANT SELECT ON TABLE vwdrugatccodeinteractions TO staff;


-- Completed on 2013-09-28 13:01:55 EST

--
-- PostgreSQL database dump complete
--

