--
-- PostgreSQL database dump
--

-- Dumped from database version 9.2.3
-- Dumped by pg_dump version 9.2.3
-- Started on 2013-06-10 00:35:02 EST

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 2347 (class 1262 OID 24576)
-- Dependencies: 2346
-- Name: drugbank; Type: COMMENT; Schema: -; Owner: easygp
--

COMMENT ON DATABASE drugbank IS 'http://drugbank.ca derived drug reference data';


--
-- TOC entry 7 (class 2615 OID 24577)
-- Name: drugbank; Type: SCHEMA; Schema: -; Owner: easygp
--

CREATE SCHEMA drugbank;


ALTER SCHEMA drugbank OWNER TO easygp;

--
-- TOC entry 199 (class 3079 OID 11995)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2350 (class 0 OID 0)
-- Dependencies: 199
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = drugbank, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 182 (class 1259 OID 24666)
-- Name: atc_codes; Type: TABLE; Schema: drugbank; Owner: easygp; Tablespace: 
--

CREATE TABLE atc_codes (
    pk integer NOT NULL,
    "atc-code" text
);


ALTER TABLE drugbank.atc_codes OWNER TO easygp;

--
-- TOC entry 181 (class 1259 OID 24664)
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
-- TOC entry 2351 (class 0 OID 0)
-- Dependencies: 181
-- Name: atc_codes_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: easygp
--

ALTER SEQUENCE atc_codes_pk_seq OWNED BY atc_codes.pk;


--
-- TOC entry 176 (class 1259 OID 24624)
-- Name: brands; Type: TABLE; Schema: drugbank; Owner: postgres; Tablespace: 
--

CREATE TABLE brands (
    pk integer NOT NULL,
    name text
);


ALTER TABLE drugbank.brands OWNER TO postgres;

--
-- TOC entry 175 (class 1259 OID 24622)
-- Name: brands_pk_seq; Type: SEQUENCE; Schema: drugbank; Owner: postgres
--

CREATE SEQUENCE brands_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE drugbank.brands_pk_seq OWNER TO postgres;

--
-- TOC entry 2352 (class 0 OID 0)
-- Dependencies: 175
-- Name: brands_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: postgres
--

ALTER SEQUENCE brands_pk_seq OWNED BY brands.pk;


--
-- TOC entry 178 (class 1259 OID 24635)
-- Name: categories; Type: TABLE; Schema: drugbank; Owner: postgres; Tablespace: 
--

CREATE TABLE categories (
    pk integer NOT NULL,
    category text
);


ALTER TABLE drugbank.categories OWNER TO postgres;

--
-- TOC entry 177 (class 1259 OID 24633)
-- Name: categories_pk_seq; Type: SEQUENCE; Schema: drugbank; Owner: postgres
--

CREATE SEQUENCE categories_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE drugbank.categories_pk_seq OWNER TO postgres;

--
-- TOC entry 2353 (class 0 OID 0)
-- Dependencies: 177
-- Name: categories_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: postgres
--

ALTER SEQUENCE categories_pk_seq OWNED BY categories.pk;


--
-- TOC entry 186 (class 1259 OID 24698)
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
-- TOC entry 185 (class 1259 OID 24696)
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
-- TOC entry 2354 (class 0 OID 0)
-- Dependencies: 185
-- Name: dosage_pl_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: easygp
--

ALTER SEQUENCE dosage_pl_seq OWNED BY dosage.pk;


--
-- TOC entry 169 (class 1259 OID 24578)
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
-- TOC entry 2355 (class 0 OID 0)
-- Dependencies: 169
-- Name: TABLE drug; Type: COMMENT; Schema: drugbank; Owner: easygp
--

COMMENT ON TABLE drug IS 'Individual substance';


--
-- TOC entry 2356 (class 0 OID 0)
-- Dependencies: 169
-- Name: COLUMN drug.name; Type: COMMENT; Schema: drugbank; Owner: easygp
--

COMMENT ON COLUMN drug.name IS 'should be INN, but isn''t always';


--
-- TOC entry 190 (class 1259 OID 24725)
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
-- TOC entry 2357 (class 0 OID 0)
-- Dependencies: 190
-- Name: COLUMN drug_interactions.description; Type: COMMENT; Schema: drugbank; Owner: easygp
--

COMMENT ON COLUMN drug_interactions.description IS 'description of the interaction';


--
-- TOC entry 189 (class 1259 OID 24723)
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
-- TOC entry 2358 (class 0 OID 0)
-- Dependencies: 189
-- Name: drug_interactions_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: easygp
--

ALTER SEQUENCE drug_interactions_pk_seq OWNED BY drug_interactions.pk;


--
-- TOC entry 170 (class 1259 OID 24581)
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
-- TOC entry 2359 (class 0 OID 0)
-- Dependencies: 170
-- Name: drug_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: easygp
--

ALTER SEQUENCE drug_pk_seq OWNED BY drug.pk;


--
-- TOC entry 196 (class 1259 OID 24773)
-- Name: external_links; Type: TABLE; Schema: drugbank; Owner: easygp; Tablespace: 
--

CREATE TABLE external_links (
    pk integer NOT NULL,
    pk_external_resource integer,
    external_link text
);


ALTER TABLE drugbank.external_links OWNER TO easygp;

--
-- TOC entry 195 (class 1259 OID 24771)
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
-- TOC entry 2360 (class 0 OID 0)
-- Dependencies: 195
-- Name: external_links_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: easygp
--

ALTER SEQUENCE external_links_pk_seq OWNED BY external_links.pk;


--
-- TOC entry 192 (class 1259 OID 24746)
-- Name: food_interactions; Type: TABLE; Schema: drugbank; Owner: easygp; Tablespace: 
--

CREATE TABLE food_interactions (
    pk integer NOT NULL,
    pk_drug integer,
    food_interaction text
);


ALTER TABLE drugbank.food_interactions OWNER TO easygp;

--
-- TOC entry 191 (class 1259 OID 24744)
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
-- TOC entry 2361 (class 0 OID 0)
-- Dependencies: 191
-- Name: food_interactions_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: easygp
--

ALTER SEQUENCE food_interactions_pk_seq OWNED BY food_interactions.pk;


--
-- TOC entry 172 (class 1259 OID 24597)
-- Name: general_references; Type: TABLE; Schema: drugbank; Owner: easygp; Tablespace: 
--

CREATE TABLE general_references (
    pk integer NOT NULL,
    reference text
);


ALTER TABLE drugbank.general_references OWNER TO easygp;

--
-- TOC entry 2362 (class 0 OID 0)
-- Dependencies: 172
-- Name: TABLE general_references; Type: COMMENT; Schema: drugbank; Owner: easygp
--

COMMENT ON TABLE general_references IS 'literature and other references to a drug';


--
-- TOC entry 171 (class 1259 OID 24595)
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
-- TOC entry 2363 (class 0 OID 0)
-- Dependencies: 171
-- Name: general_references_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: easygp
--

ALTER SEQUENCE general_references_pk_seq OWNED BY general_references.pk;


--
-- TOC entry 184 (class 1259 OID 24680)
-- Name: link_drug_to_atc_code; Type: TABLE; Schema: drugbank; Owner: postgres; Tablespace: 
--

CREATE TABLE link_drug_to_atc_code (
    pk integer NOT NULL,
    pk_drug integer,
    pk_atc_code integer
);


ALTER TABLE drugbank.link_drug_to_atc_code OWNER TO postgres;

--
-- TOC entry 183 (class 1259 OID 24678)
-- Name: link_drug_to_atc_code_pk_seq; Type: SEQUENCE; Schema: drugbank; Owner: postgres
--

CREATE SEQUENCE link_drug_to_atc_code_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE drugbank.link_drug_to_atc_code_pk_seq OWNER TO postgres;

--
-- TOC entry 2364 (class 0 OID 0)
-- Dependencies: 183
-- Name: link_drug_to_atc_code_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: postgres
--

ALTER SEQUENCE link_drug_to_atc_code_pk_seq OWNED BY link_drug_to_atc_code.pk;


--
-- TOC entry 180 (class 1259 OID 24648)
-- Name: link_drug_to_category; Type: TABLE; Schema: drugbank; Owner: postgres; Tablespace: 
--

CREATE TABLE link_drug_to_category (
    pk integer NOT NULL,
    fk_drug integer,
    fk_category integer
);


ALTER TABLE drugbank.link_drug_to_category OWNER TO postgres;

--
-- TOC entry 179 (class 1259 OID 24646)
-- Name: link_drug_to_category_pk_seq; Type: SEQUENCE; Schema: drugbank; Owner: postgres
--

CREATE SEQUENCE link_drug_to_category_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE drugbank.link_drug_to_category_pk_seq OWNER TO postgres;

--
-- TOC entry 2365 (class 0 OID 0)
-- Dependencies: 179
-- Name: link_drug_to_category_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: postgres
--

ALTER SEQUENCE link_drug_to_category_pk_seq OWNED BY link_drug_to_category.pk;


--
-- TOC entry 194 (class 1259 OID 24762)
-- Name: lu_external_resources; Type: TABLE; Schema: drugbank; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_external_resources (
    pk integer NOT NULL,
    resource text
);


ALTER TABLE drugbank.lu_external_resources OWNER TO easygp;

--
-- TOC entry 193 (class 1259 OID 24760)
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
-- TOC entry 2366 (class 0 OID 0)
-- Dependencies: 193
-- Name: lu_external_resources_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: easygp
--

ALTER SEQUENCE lu_external_resources_pk_seq OWNED BY lu_external_resources.pk;


--
-- TOC entry 188 (class 1259 OID 24709)
-- Name: patents; Type: TABLE; Schema: drugbank; Owner: easygp; Tablespace: 
--

CREATE TABLE patents (
    pk integer NOT NULL,
    pk_drug integer,
    number text,
    country text,
    approved date,
    expires date
);


ALTER TABLE drugbank.patents OWNER TO easygp;

--
-- TOC entry 187 (class 1259 OID 24707)
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
-- TOC entry 2367 (class 0 OID 0)
-- Dependencies: 187
-- Name: patents_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: easygp
--

ALTER SEQUENCE patents_pk_seq OWNED BY patents.pk;


--
-- TOC entry 198 (class 1259 OID 24789)
-- Name: salts; Type: TABLE; Schema: drugbank; Owner: easygp; Tablespace: 
--

CREATE TABLE salts (
    pk integer NOT NULL,
    pk_drug integer,
    salt text
);


ALTER TABLE drugbank.salts OWNER TO easygp;

--
-- TOC entry 197 (class 1259 OID 24787)
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
-- TOC entry 2368 (class 0 OID 0)
-- Dependencies: 197
-- Name: salts_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: easygp
--

ALTER SEQUENCE salts_pk_seq OWNED BY salts.pk;


--
-- TOC entry 174 (class 1259 OID 24608)
-- Name: synonyms; Type: TABLE; Schema: drugbank; Owner: easygp; Tablespace: 
--

CREATE TABLE synonyms (
    pk integer NOT NULL,
    fk_drug integer,
    name text
);


ALTER TABLE drugbank.synonyms OWNER TO easygp;

--
-- TOC entry 173 (class 1259 OID 24606)
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
-- TOC entry 2369 (class 0 OID 0)
-- Dependencies: 173
-- Name: synonyms_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: easygp
--

ALTER SEQUENCE synonyms_pk_seq OWNED BY synonyms.pk;


--
-- TOC entry 2286 (class 2604 OID 24669)
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY atc_codes ALTER COLUMN pk SET DEFAULT nextval('atc_codes_pk_seq'::regclass);


--
-- TOC entry 2283 (class 2604 OID 24627)
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: postgres
--

ALTER TABLE ONLY brands ALTER COLUMN pk SET DEFAULT nextval('brands_pk_seq'::regclass);


--
-- TOC entry 2284 (class 2604 OID 24638)
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: postgres
--

ALTER TABLE ONLY categories ALTER COLUMN pk SET DEFAULT nextval('categories_pk_seq'::regclass);


--
-- TOC entry 2288 (class 2604 OID 24701)
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY dosage ALTER COLUMN pk SET DEFAULT nextval('dosage_pl_seq'::regclass);


--
-- TOC entry 2280 (class 2604 OID 24583)
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY drug ALTER COLUMN pk SET DEFAULT nextval('drug_pk_seq'::regclass);


--
-- TOC entry 2290 (class 2604 OID 24728)
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY drug_interactions ALTER COLUMN pk SET DEFAULT nextval('drug_interactions_pk_seq'::regclass);


--
-- TOC entry 2293 (class 2604 OID 24776)
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY external_links ALTER COLUMN pk SET DEFAULT nextval('external_links_pk_seq'::regclass);


--
-- TOC entry 2291 (class 2604 OID 24749)
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY food_interactions ALTER COLUMN pk SET DEFAULT nextval('food_interactions_pk_seq'::regclass);


--
-- TOC entry 2281 (class 2604 OID 24600)
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY general_references ALTER COLUMN pk SET DEFAULT nextval('general_references_pk_seq'::regclass);


--
-- TOC entry 2287 (class 2604 OID 24683)
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: postgres
--

ALTER TABLE ONLY link_drug_to_atc_code ALTER COLUMN pk SET DEFAULT nextval('link_drug_to_atc_code_pk_seq'::regclass);


--
-- TOC entry 2285 (class 2604 OID 24651)
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: postgres
--

ALTER TABLE ONLY link_drug_to_category ALTER COLUMN pk SET DEFAULT nextval('link_drug_to_category_pk_seq'::regclass);


--
-- TOC entry 2292 (class 2604 OID 24765)
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY lu_external_resources ALTER COLUMN pk SET DEFAULT nextval('lu_external_resources_pk_seq'::regclass);


--
-- TOC entry 2289 (class 2604 OID 24712)
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY patents ALTER COLUMN pk SET DEFAULT nextval('patents_pk_seq'::regclass);


--
-- TOC entry 2294 (class 2604 OID 24792)
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY salts ALTER COLUMN pk SET DEFAULT nextval('salts_pk_seq'::regclass);


--
-- TOC entry 2282 (class 2604 OID 24611)
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY synonyms ALTER COLUMN pk SET DEFAULT nextval('synonyms_pk_seq'::regclass);


--
-- TOC entry 2312 (class 2606 OID 24676)
-- Name: atc_codes_atc-code_key; Type: CONSTRAINT; Schema: drugbank; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY atc_codes
    ADD CONSTRAINT "atc_codes_atc-code_key" UNIQUE ("atc-code");


--
-- TOC entry 2314 (class 2606 OID 24671)
-- Name: atc_codes_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY atc_codes
    ADD CONSTRAINT atc_codes_pkey PRIMARY KEY (pk);


--
-- TOC entry 2304 (class 2606 OID 24632)
-- Name: brands_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY brands
    ADD CONSTRAINT brands_pkey PRIMARY KEY (pk);


--
-- TOC entry 2306 (class 2606 OID 24645)
-- Name: categories_category_key; Type: CONSTRAINT; Schema: drugbank; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_category_key UNIQUE (category);


--
-- TOC entry 2308 (class 2606 OID 24643)
-- Name: categories_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (pk);


--
-- TOC entry 2318 (class 2606 OID 24706)
-- Name: dosage_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY dosage
    ADD CONSTRAINT dosage_pkey PRIMARY KEY (pk);


--
-- TOC entry 2296 (class 2606 OID 24594)
-- Name: drug_drugbank_id_key; Type: CONSTRAINT; Schema: drugbank; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY drug
    ADD CONSTRAINT drug_drugbank_id_key UNIQUE (drugbank_id);


--
-- TOC entry 2322 (class 2606 OID 24733)
-- Name: drug_interactions_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY drug_interactions
    ADD CONSTRAINT drug_interactions_pkey PRIMARY KEY (pk);


--
-- TOC entry 2298 (class 2606 OID 24591)
-- Name: drug_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY drug
    ADD CONSTRAINT drug_pkey PRIMARY KEY (pk);


--
-- TOC entry 2328 (class 2606 OID 24781)
-- Name: external_links_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY external_links
    ADD CONSTRAINT external_links_pkey PRIMARY KEY (pk);


--
-- TOC entry 2324 (class 2606 OID 24754)
-- Name: food_interactions_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY food_interactions
    ADD CONSTRAINT food_interactions_pkey PRIMARY KEY (pk);


--
-- TOC entry 2300 (class 2606 OID 24605)
-- Name: general_references_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY general_references
    ADD CONSTRAINT general_references_pkey PRIMARY KEY (pk);


--
-- TOC entry 2316 (class 2606 OID 24685)
-- Name: link_drug_to_atc_code_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY link_drug_to_atc_code
    ADD CONSTRAINT link_drug_to_atc_code_pkey PRIMARY KEY (pk);


--
-- TOC entry 2310 (class 2606 OID 24653)
-- Name: link_drug_to_category_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY link_drug_to_category
    ADD CONSTRAINT link_drug_to_category_pkey PRIMARY KEY (pk);


--
-- TOC entry 2326 (class 2606 OID 24770)
-- Name: lu_external_resources_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_external_resources
    ADD CONSTRAINT lu_external_resources_pkey PRIMARY KEY (pk);


--
-- TOC entry 2320 (class 2606 OID 24717)
-- Name: patents_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY patents
    ADD CONSTRAINT patents_pkey PRIMARY KEY (pk);


--
-- TOC entry 2330 (class 2606 OID 24797)
-- Name: salts_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY salts
    ADD CONSTRAINT salts_pkey PRIMARY KEY (pk);


--
-- TOC entry 2302 (class 2606 OID 24616)
-- Name: synonyms_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY synonyms
    ADD CONSTRAINT synonyms_pkey PRIMARY KEY (pk);


--
-- TOC entry 2337 (class 2606 OID 25632)
-- Name: drug_interactions_fk_drug_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY drug_interactions
    ADD CONSTRAINT drug_interactions_fk_drug_fkey FOREIGN KEY (fk_drug) REFERENCES drug(pk);


--
-- TOC entry 2338 (class 2606 OID 25637)
-- Name: drug_interactions_fk_interacts_with_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY drug_interactions
    ADD CONSTRAINT drug_interactions_fk_interacts_with_fkey FOREIGN KEY (fk_interacts_with) REFERENCES drug(pk);


--
-- TOC entry 2340 (class 2606 OID 24782)
-- Name: external_links_pk_external_resource_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY external_links
    ADD CONSTRAINT external_links_pk_external_resource_fkey FOREIGN KEY (pk_external_resource) REFERENCES lu_external_resources(pk);


--
-- TOC entry 2339 (class 2606 OID 24755)
-- Name: food_interactions_pk_drug_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY food_interactions
    ADD CONSTRAINT food_interactions_pk_drug_fkey FOREIGN KEY (pk_drug) REFERENCES drug(pk);


--
-- TOC entry 2334 (class 2606 OID 24686)
-- Name: link_drug_to_atc_code_pk_atc_code_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: postgres
--

ALTER TABLE ONLY link_drug_to_atc_code
    ADD CONSTRAINT link_drug_to_atc_code_pk_atc_code_fkey FOREIGN KEY (pk_atc_code) REFERENCES atc_codes(pk);


--
-- TOC entry 2335 (class 2606 OID 24691)
-- Name: link_drug_to_atc_code_pk_drug_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: postgres
--

ALTER TABLE ONLY link_drug_to_atc_code
    ADD CONSTRAINT link_drug_to_atc_code_pk_drug_fkey FOREIGN KEY (pk_drug) REFERENCES drug(pk);


--
-- TOC entry 2333 (class 2606 OID 24659)
-- Name: link_drug_to_category_fk_category_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: postgres
--

ALTER TABLE ONLY link_drug_to_category
    ADD CONSTRAINT link_drug_to_category_fk_category_fkey FOREIGN KEY (fk_category) REFERENCES categories(pk);


--
-- TOC entry 2332 (class 2606 OID 24654)
-- Name: link_drug_to_category_fk_drug_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: postgres
--

ALTER TABLE ONLY link_drug_to_category
    ADD CONSTRAINT link_drug_to_category_fk_drug_fkey FOREIGN KEY (fk_drug) REFERENCES drug(pk);


--
-- TOC entry 2336 (class 2606 OID 24718)
-- Name: patents_pk_drug_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY patents
    ADD CONSTRAINT patents_pk_drug_fkey FOREIGN KEY (pk_drug) REFERENCES drug(pk);


--
-- TOC entry 2341 (class 2606 OID 24798)
-- Name: salts_pk_drug_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY salts
    ADD CONSTRAINT salts_pk_drug_fkey FOREIGN KEY (pk_drug) REFERENCES drug(pk);


--
-- TOC entry 2331 (class 2606 OID 24617)
-- Name: synonyms_fk_drug_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: easygp
--

ALTER TABLE ONLY synonyms
    ADD CONSTRAINT synonyms_fk_drug_fkey FOREIGN KEY (fk_drug) REFERENCES drug(pk);


--
-- TOC entry 2349 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2013-06-10 00:35:02 EST

--
-- PostgreSQL database dump complete
--

