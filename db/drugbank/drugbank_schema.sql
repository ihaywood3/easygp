--
-- PostgreSQL database dump
--

-- Dumped from database version 9.2.3
-- Dumped by pg_dump version 9.2.3
-- Started on 2013-06-12 23:14:12 EST

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 2360 (class 1262 OID 28560)
-- Dependencies: 2359
-- Name: drugbank; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON DATABASE drugbank IS 'http://drugbank.ca derived drug reference data';


--
-- TOC entry 6 (class 2615 OID 28561)
-- Name: drugbank; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA drugbank;


--
-- TOC entry 201 (class 3079 OID 11995)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2362 (class 0 OID 0)
-- Dependencies: 201
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = drugbank, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 169 (class 1259 OID 28562)
-- Name: atc_codes; Type: TABLE; Schema: drugbank; Owner: -; Tablespace: 
--

CREATE TABLE atc_codes (
    pk integer NOT NULL,
    atc_code text
);


--
-- TOC entry 170 (class 1259 OID 28568)
-- Name: atc_codes_pk_seq; Type: SEQUENCE; Schema: drugbank; Owner: -
--

CREATE SEQUENCE atc_codes_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2363 (class 0 OID 0)
-- Dependencies: 170
-- Name: atc_codes_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: -
--

ALTER SEQUENCE atc_codes_pk_seq OWNED BY atc_codes.pk;


--
-- TOC entry 171 (class 1259 OID 28570)
-- Name: brands; Type: TABLE; Schema: drugbank; Owner: -; Tablespace: 
--

CREATE TABLE brands (
    pk integer NOT NULL,
    name text,
    fk_drug integer
);


--
-- TOC entry 172 (class 1259 OID 28576)
-- Name: brands_pk_seq; Type: SEQUENCE; Schema: drugbank; Owner: -
--

CREATE SEQUENCE brands_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2364 (class 0 OID 0)
-- Dependencies: 172
-- Name: brands_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: -
--

ALTER SEQUENCE brands_pk_seq OWNED BY brands.pk;


--
-- TOC entry 173 (class 1259 OID 28578)
-- Name: categories; Type: TABLE; Schema: drugbank; Owner: -; Tablespace: 
--

CREATE TABLE categories (
    pk integer NOT NULL,
    category text
);


--
-- TOC entry 174 (class 1259 OID 28584)
-- Name: categories_pk_seq; Type: SEQUENCE; Schema: drugbank; Owner: -
--

CREATE SEQUENCE categories_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2365 (class 0 OID 0)
-- Dependencies: 174
-- Name: categories_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: -
--

ALTER SEQUENCE categories_pk_seq OWNED BY categories.pk;


--
-- TOC entry 175 (class 1259 OID 28586)
-- Name: dosage; Type: TABLE; Schema: drugbank; Owner: -; Tablespace: 
--

CREATE TABLE dosage (
    pk integer NOT NULL,
    form text,
    route text,
    strength text
);


--
-- TOC entry 176 (class 1259 OID 28592)
-- Name: dosage_pl_seq; Type: SEQUENCE; Schema: drugbank; Owner: -
--

CREATE SEQUENCE dosage_pl_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2366 (class 0 OID 0)
-- Dependencies: 176
-- Name: dosage_pl_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: -
--

ALTER SEQUENCE dosage_pl_seq OWNED BY dosage.pk;


--
-- TOC entry 177 (class 1259 OID 28594)
-- Name: drug; Type: TABLE; Schema: drugbank; Owner: -; Tablespace: 
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


--
-- TOC entry 2367 (class 0 OID 0)
-- Dependencies: 177
-- Name: TABLE drug; Type: COMMENT; Schema: drugbank; Owner: -
--

COMMENT ON TABLE drug IS 'Individual substance';


--
-- TOC entry 2368 (class 0 OID 0)
-- Dependencies: 177
-- Name: COLUMN drug.name; Type: COMMENT; Schema: drugbank; Owner: -
--

COMMENT ON COLUMN drug.name IS 'should be INN, but isn''t always';


--
-- TOC entry 178 (class 1259 OID 28600)
-- Name: drug_interactions; Type: TABLE; Schema: drugbank; Owner: -; Tablespace: 
--

CREATE TABLE drug_interactions (
    pk integer NOT NULL,
    fk_drug integer,
    fk_interacts_with integer,
    description text
);


--
-- TOC entry 2369 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN drug_interactions.description; Type: COMMENT; Schema: drugbank; Owner: -
--

COMMENT ON COLUMN drug_interactions.description IS 'description of the interaction';


--
-- TOC entry 179 (class 1259 OID 28606)
-- Name: drug_interactions_pk_seq; Type: SEQUENCE; Schema: drugbank; Owner: -
--

CREATE SEQUENCE drug_interactions_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2370 (class 0 OID 0)
-- Dependencies: 179
-- Name: drug_interactions_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: -
--

ALTER SEQUENCE drug_interactions_pk_seq OWNED BY drug_interactions.pk;


--
-- TOC entry 180 (class 1259 OID 28608)
-- Name: drug_pk_seq; Type: SEQUENCE; Schema: drugbank; Owner: -
--

CREATE SEQUENCE drug_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2371 (class 0 OID 0)
-- Dependencies: 180
-- Name: drug_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: -
--

ALTER SEQUENCE drug_pk_seq OWNED BY drug.pk;


--
-- TOC entry 181 (class 1259 OID 28610)
-- Name: external_links; Type: TABLE; Schema: drugbank; Owner: -; Tablespace: 
--

CREATE TABLE external_links (
    pk integer NOT NULL,
    fk_external_resource integer,
    external_link text
);


--
-- TOC entry 182 (class 1259 OID 28616)
-- Name: external_links_pk_seq; Type: SEQUENCE; Schema: drugbank; Owner: -
--

CREATE SEQUENCE external_links_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2372 (class 0 OID 0)
-- Dependencies: 182
-- Name: external_links_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: -
--

ALTER SEQUENCE external_links_pk_seq OWNED BY external_links.pk;


--
-- TOC entry 183 (class 1259 OID 28618)
-- Name: food_interactions; Type: TABLE; Schema: drugbank; Owner: -; Tablespace: 
--

CREATE TABLE food_interactions (
    pk integer NOT NULL,
    fk_drug integer,
    food_interaction text
);


--
-- TOC entry 184 (class 1259 OID 28624)
-- Name: food_interactions_pk_seq; Type: SEQUENCE; Schema: drugbank; Owner: -
--

CREATE SEQUENCE food_interactions_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2373 (class 0 OID 0)
-- Dependencies: 184
-- Name: food_interactions_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: -
--

ALTER SEQUENCE food_interactions_pk_seq OWNED BY food_interactions.pk;


--
-- TOC entry 185 (class 1259 OID 28626)
-- Name: general_references; Type: TABLE; Schema: drugbank; Owner: -; Tablespace: 
--

CREATE TABLE general_references (
    pk integer NOT NULL,
    reference text,
    fk_drug integer
);


--
-- TOC entry 2374 (class 0 OID 0)
-- Dependencies: 185
-- Name: TABLE general_references; Type: COMMENT; Schema: drugbank; Owner: -
--

COMMENT ON TABLE general_references IS 'literature and other references to a drug';


--
-- TOC entry 186 (class 1259 OID 28632)
-- Name: general_references_pk_seq; Type: SEQUENCE; Schema: drugbank; Owner: -
--

CREATE SEQUENCE general_references_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2375 (class 0 OID 0)
-- Dependencies: 186
-- Name: general_references_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: -
--

ALTER SEQUENCE general_references_pk_seq OWNED BY general_references.pk;


--
-- TOC entry 187 (class 1259 OID 28634)
-- Name: link_drug_to_atc_code; Type: TABLE; Schema: drugbank; Owner: -; Tablespace: 
--

CREATE TABLE link_drug_to_atc_code (
    pk integer NOT NULL,
    fk_drug integer,
    fk_atc_code integer
);


--
-- TOC entry 188 (class 1259 OID 28637)
-- Name: link_drug_to_atc_code_pk_seq; Type: SEQUENCE; Schema: drugbank; Owner: -
--

CREATE SEQUENCE link_drug_to_atc_code_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2376 (class 0 OID 0)
-- Dependencies: 188
-- Name: link_drug_to_atc_code_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: -
--

ALTER SEQUENCE link_drug_to_atc_code_pk_seq OWNED BY link_drug_to_atc_code.pk;


--
-- TOC entry 189 (class 1259 OID 28639)
-- Name: link_drug_to_category; Type: TABLE; Schema: drugbank; Owner: -; Tablespace: 
--

CREATE TABLE link_drug_to_category (
    pk integer NOT NULL,
    fk_drug integer,
    fk_category integer
);


--
-- TOC entry 190 (class 1259 OID 28642)
-- Name: link_drug_to_category_pk_seq; Type: SEQUENCE; Schema: drugbank; Owner: -
--

CREATE SEQUENCE link_drug_to_category_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2377 (class 0 OID 0)
-- Dependencies: 190
-- Name: link_drug_to_category_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: -
--

ALTER SEQUENCE link_drug_to_category_pk_seq OWNED BY link_drug_to_category.pk;


--
-- TOC entry 200 (class 1259 OID 29660)
-- Name: link_drug_to_dosage; Type: TABLE; Schema: drugbank; Owner: -; Tablespace: 
--

CREATE TABLE link_drug_to_dosage (
    pk integer NOT NULL,
    fk_drug integer,
    fk_dosage integer
);


--
-- TOC entry 199 (class 1259 OID 29658)
-- Name: link_drug_to_dosage_pk_seq; Type: SEQUENCE; Schema: drugbank; Owner: -
--

CREATE SEQUENCE link_drug_to_dosage_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2378 (class 0 OID 0)
-- Dependencies: 199
-- Name: link_drug_to_dosage_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: -
--

ALTER SEQUENCE link_drug_to_dosage_pk_seq OWNED BY link_drug_to_dosage.pk;


--
-- TOC entry 191 (class 1259 OID 28644)
-- Name: lu_external_resources; Type: TABLE; Schema: drugbank; Owner: -; Tablespace: 
--

CREATE TABLE lu_external_resources (
    pk integer NOT NULL,
    resource text
);


--
-- TOC entry 192 (class 1259 OID 28650)
-- Name: lu_external_resources_pk_seq; Type: SEQUENCE; Schema: drugbank; Owner: -
--

CREATE SEQUENCE lu_external_resources_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2379 (class 0 OID 0)
-- Dependencies: 192
-- Name: lu_external_resources_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: -
--

ALTER SEQUENCE lu_external_resources_pk_seq OWNED BY lu_external_resources.pk;


--
-- TOC entry 193 (class 1259 OID 28652)
-- Name: patents; Type: TABLE; Schema: drugbank; Owner: -; Tablespace: 
--

CREATE TABLE patents (
    pk integer NOT NULL,
    fk_drug integer,
    patent_number text,
    country text,
    approved date,
    expires date
);


--
-- TOC entry 194 (class 1259 OID 28658)
-- Name: patents_pk_seq; Type: SEQUENCE; Schema: drugbank; Owner: -
--

CREATE SEQUENCE patents_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2380 (class 0 OID 0)
-- Dependencies: 194
-- Name: patents_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: -
--

ALTER SEQUENCE patents_pk_seq OWNED BY patents.pk;


--
-- TOC entry 195 (class 1259 OID 28660)
-- Name: salts; Type: TABLE; Schema: drugbank; Owner: -; Tablespace: 
--

CREATE TABLE salts (
    pk integer NOT NULL,
    fk_drug integer,
    salt text
);


--
-- TOC entry 196 (class 1259 OID 28666)
-- Name: salts_pk_seq; Type: SEQUENCE; Schema: drugbank; Owner: -
--

CREATE SEQUENCE salts_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2381 (class 0 OID 0)
-- Dependencies: 196
-- Name: salts_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: -
--

ALTER SEQUENCE salts_pk_seq OWNED BY salts.pk;


--
-- TOC entry 197 (class 1259 OID 28668)
-- Name: synonyms; Type: TABLE; Schema: drugbank; Owner: -; Tablespace: 
--

CREATE TABLE synonyms (
    pk integer NOT NULL,
    fk_drug integer,
    name text
);


--
-- TOC entry 198 (class 1259 OID 28674)
-- Name: synonyms_pk_seq; Type: SEQUENCE; Schema: drugbank; Owner: -
--

CREATE SEQUENCE synonyms_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2382 (class 0 OID 0)
-- Dependencies: 198
-- Name: synonyms_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugbank; Owner: -
--

ALTER SEQUENCE synonyms_pk_seq OWNED BY synonyms.pk;


--
-- TOC entry 2286 (class 2604 OID 28676)
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: -
--

ALTER TABLE ONLY atc_codes ALTER COLUMN pk SET DEFAULT nextval('atc_codes_pk_seq'::regclass);


--
-- TOC entry 2287 (class 2604 OID 28677)
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: -
--

ALTER TABLE ONLY brands ALTER COLUMN pk SET DEFAULT nextval('brands_pk_seq'::regclass);


--
-- TOC entry 2288 (class 2604 OID 28678)
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: -
--

ALTER TABLE ONLY categories ALTER COLUMN pk SET DEFAULT nextval('categories_pk_seq'::regclass);


--
-- TOC entry 2289 (class 2604 OID 28679)
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: -
--

ALTER TABLE ONLY dosage ALTER COLUMN pk SET DEFAULT nextval('dosage_pl_seq'::regclass);


--
-- TOC entry 2290 (class 2604 OID 28680)
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: -
--

ALTER TABLE ONLY drug ALTER COLUMN pk SET DEFAULT nextval('drug_pk_seq'::regclass);


--
-- TOC entry 2291 (class 2604 OID 28681)
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: -
--

ALTER TABLE ONLY drug_interactions ALTER COLUMN pk SET DEFAULT nextval('drug_interactions_pk_seq'::regclass);


--
-- TOC entry 2292 (class 2604 OID 28682)
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: -
--

ALTER TABLE ONLY external_links ALTER COLUMN pk SET DEFAULT nextval('external_links_pk_seq'::regclass);


--
-- TOC entry 2293 (class 2604 OID 28683)
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: -
--

ALTER TABLE ONLY food_interactions ALTER COLUMN pk SET DEFAULT nextval('food_interactions_pk_seq'::regclass);


--
-- TOC entry 2294 (class 2604 OID 28684)
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: -
--

ALTER TABLE ONLY general_references ALTER COLUMN pk SET DEFAULT nextval('general_references_pk_seq'::regclass);


--
-- TOC entry 2295 (class 2604 OID 28685)
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: -
--

ALTER TABLE ONLY link_drug_to_atc_code ALTER COLUMN pk SET DEFAULT nextval('link_drug_to_atc_code_pk_seq'::regclass);


--
-- TOC entry 2296 (class 2604 OID 28686)
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: -
--

ALTER TABLE ONLY link_drug_to_category ALTER COLUMN pk SET DEFAULT nextval('link_drug_to_category_pk_seq'::regclass);


--
-- TOC entry 2301 (class 2604 OID 29663)
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: -
--

ALTER TABLE ONLY link_drug_to_dosage ALTER COLUMN pk SET DEFAULT nextval('link_drug_to_dosage_pk_seq'::regclass);


--
-- TOC entry 2297 (class 2604 OID 28687)
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: -
--

ALTER TABLE ONLY lu_external_resources ALTER COLUMN pk SET DEFAULT nextval('lu_external_resources_pk_seq'::regclass);


--
-- TOC entry 2298 (class 2604 OID 28688)
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: -
--

ALTER TABLE ONLY patents ALTER COLUMN pk SET DEFAULT nextval('patents_pk_seq'::regclass);


--
-- TOC entry 2299 (class 2604 OID 28689)
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: -
--

ALTER TABLE ONLY salts ALTER COLUMN pk SET DEFAULT nextval('salts_pk_seq'::regclass);


--
-- TOC entry 2300 (class 2604 OID 28690)
-- Name: pk; Type: DEFAULT; Schema: drugbank; Owner: -
--

ALTER TABLE ONLY synonyms ALTER COLUMN pk SET DEFAULT nextval('synonyms_pk_seq'::regclass);


--
-- TOC entry 2303 (class 2606 OID 28692)
-- Name: atc_codes_atc-code_key; Type: CONSTRAINT; Schema: drugbank; Owner: -; Tablespace: 
--

ALTER TABLE ONLY atc_codes
    ADD CONSTRAINT "atc_codes_atc-code_key" UNIQUE (atc_code);


--
-- TOC entry 2305 (class 2606 OID 28694)
-- Name: atc_codes_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: -; Tablespace: 
--

ALTER TABLE ONLY atc_codes
    ADD CONSTRAINT atc_codes_pkey PRIMARY KEY (pk);


--
-- TOC entry 2307 (class 2606 OID 28696)
-- Name: brands_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: -; Tablespace: 
--

ALTER TABLE ONLY brands
    ADD CONSTRAINT brands_pkey PRIMARY KEY (pk);


--
-- TOC entry 2309 (class 2606 OID 28698)
-- Name: categories_category_key; Type: CONSTRAINT; Schema: drugbank; Owner: -; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_category_key UNIQUE (category);


--
-- TOC entry 2311 (class 2606 OID 28700)
-- Name: categories_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: -; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (pk);


--
-- TOC entry 2313 (class 2606 OID 28702)
-- Name: dosage_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dosage
    ADD CONSTRAINT dosage_pkey PRIMARY KEY (pk);


--
-- TOC entry 2315 (class 2606 OID 28704)
-- Name: drug_drugbank_id_key; Type: CONSTRAINT; Schema: drugbank; Owner: -; Tablespace: 
--

ALTER TABLE ONLY drug
    ADD CONSTRAINT drug_drugbank_id_key UNIQUE (drugbank_id);


--
-- TOC entry 2319 (class 2606 OID 28706)
-- Name: drug_interactions_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: -; Tablespace: 
--

ALTER TABLE ONLY drug_interactions
    ADD CONSTRAINT drug_interactions_pkey PRIMARY KEY (pk);


--
-- TOC entry 2317 (class 2606 OID 28708)
-- Name: drug_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: -; Tablespace: 
--

ALTER TABLE ONLY drug
    ADD CONSTRAINT drug_pkey PRIMARY KEY (pk);


--
-- TOC entry 2321 (class 2606 OID 28710)
-- Name: external_links_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: -; Tablespace: 
--

ALTER TABLE ONLY external_links
    ADD CONSTRAINT external_links_pkey PRIMARY KEY (pk);


--
-- TOC entry 2323 (class 2606 OID 28712)
-- Name: food_interactions_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: -; Tablespace: 
--

ALTER TABLE ONLY food_interactions
    ADD CONSTRAINT food_interactions_pkey PRIMARY KEY (pk);


--
-- TOC entry 2325 (class 2606 OID 28714)
-- Name: general_references_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: -; Tablespace: 
--

ALTER TABLE ONLY general_references
    ADD CONSTRAINT general_references_pkey PRIMARY KEY (pk);


--
-- TOC entry 2327 (class 2606 OID 28716)
-- Name: link_drug_to_atc_code_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: -; Tablespace: 
--

ALTER TABLE ONLY link_drug_to_atc_code
    ADD CONSTRAINT link_drug_to_atc_code_pkey PRIMARY KEY (pk);


--
-- TOC entry 2329 (class 2606 OID 28718)
-- Name: link_drug_to_category_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: -; Tablespace: 
--

ALTER TABLE ONLY link_drug_to_category
    ADD CONSTRAINT link_drug_to_category_pkey PRIMARY KEY (pk);


--
-- TOC entry 2339 (class 2606 OID 29665)
-- Name: link_drug_to_dosage_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: -; Tablespace: 
--

ALTER TABLE ONLY link_drug_to_dosage
    ADD CONSTRAINT link_drug_to_dosage_pkey PRIMARY KEY (pk);


--
-- TOC entry 2331 (class 2606 OID 28720)
-- Name: lu_external_resources_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_external_resources
    ADD CONSTRAINT lu_external_resources_pkey PRIMARY KEY (pk);


--
-- TOC entry 2333 (class 2606 OID 28722)
-- Name: patents_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: -; Tablespace: 
--

ALTER TABLE ONLY patents
    ADD CONSTRAINT patents_pkey PRIMARY KEY (pk);


--
-- TOC entry 2335 (class 2606 OID 28724)
-- Name: salts_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: -; Tablespace: 
--

ALTER TABLE ONLY salts
    ADD CONSTRAINT salts_pkey PRIMARY KEY (pk);


--
-- TOC entry 2337 (class 2606 OID 28726)
-- Name: synonyms_pkey; Type: CONSTRAINT; Schema: drugbank; Owner: -; Tablespace: 
--

ALTER TABLE ONLY synonyms
    ADD CONSTRAINT synonyms_pkey PRIMARY KEY (pk);


--
-- TOC entry 2340 (class 2606 OID 29741)
-- Name: brands_fk_drug_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: -
--

ALTER TABLE ONLY brands
    ADD CONSTRAINT brands_fk_drug_fkey FOREIGN KEY (fk_drug) REFERENCES drug(pk);


--
-- TOC entry 2341 (class 2606 OID 28727)
-- Name: drug_interactions_fk_drug_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: -
--

ALTER TABLE ONLY drug_interactions
    ADD CONSTRAINT drug_interactions_fk_drug_fkey FOREIGN KEY (fk_drug) REFERENCES drug(pk);


--
-- TOC entry 2342 (class 2606 OID 28732)
-- Name: drug_interactions_fk_interacts_with_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: -
--

ALTER TABLE ONLY drug_interactions
    ADD CONSTRAINT drug_interactions_fk_interacts_with_fkey FOREIGN KEY (fk_interacts_with) REFERENCES drug(pk);


--
-- TOC entry 2343 (class 2606 OID 29676)
-- Name: external_links_fk_external_resource_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: -
--

ALTER TABLE ONLY external_links
    ADD CONSTRAINT external_links_fk_external_resource_fkey FOREIGN KEY (fk_external_resource) REFERENCES lu_external_resources(pk);


--
-- TOC entry 2344 (class 2606 OID 29681)
-- Name: food_interactions_fk_drug_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: -
--

ALTER TABLE ONLY food_interactions
    ADD CONSTRAINT food_interactions_fk_drug_fkey FOREIGN KEY (fk_drug) REFERENCES drug(pk);


--
-- TOC entry 2345 (class 2606 OID 29752)
-- Name: general_references_fk_drug_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: -
--

ALTER TABLE ONLY general_references
    ADD CONSTRAINT general_references_fk_drug_fkey FOREIGN KEY (fk_drug) REFERENCES drug(pk);


--
-- TOC entry 2346 (class 2606 OID 29731)
-- Name: link_drug_to_atc_code_fk_atc_code_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: -
--

ALTER TABLE ONLY link_drug_to_atc_code
    ADD CONSTRAINT link_drug_to_atc_code_fk_atc_code_fkey FOREIGN KEY (fk_atc_code) REFERENCES atc_codes(pk);


--
-- TOC entry 2347 (class 2606 OID 29736)
-- Name: link_drug_to_atc_code_fk_drug_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: -
--

ALTER TABLE ONLY link_drug_to_atc_code
    ADD CONSTRAINT link_drug_to_atc_code_fk_drug_fkey FOREIGN KEY (fk_drug) REFERENCES drug(pk);


--
-- TOC entry 2348 (class 2606 OID 29721)
-- Name: link_drug_to_category_fk_category_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: -
--

ALTER TABLE ONLY link_drug_to_category
    ADD CONSTRAINT link_drug_to_category_fk_category_fkey FOREIGN KEY (fk_category) REFERENCES categories(pk);


--
-- TOC entry 2349 (class 2606 OID 29726)
-- Name: link_drug_to_category_fk_drug_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: -
--

ALTER TABLE ONLY link_drug_to_category
    ADD CONSTRAINT link_drug_to_category_fk_drug_fkey FOREIGN KEY (fk_drug) REFERENCES drug(pk);


--
-- TOC entry 2353 (class 2606 OID 29711)
-- Name: link_drug_to_dosage_fk_dosage_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: -
--

ALTER TABLE ONLY link_drug_to_dosage
    ADD CONSTRAINT link_drug_to_dosage_fk_dosage_fkey FOREIGN KEY (fk_dosage) REFERENCES dosage(pk);


--
-- TOC entry 2354 (class 2606 OID 29716)
-- Name: link_drug_to_dosage_fk_drug_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: -
--

ALTER TABLE ONLY link_drug_to_dosage
    ADD CONSTRAINT link_drug_to_dosage_fk_drug_fkey FOREIGN KEY (fk_drug) REFERENCES drug(pk);


--
-- TOC entry 2350 (class 2606 OID 29747)
-- Name: patents_fk_drug_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: -
--

ALTER TABLE ONLY patents
    ADD CONSTRAINT patents_fk_drug_fkey FOREIGN KEY (fk_drug) REFERENCES drug(pk);


--
-- TOC entry 2351 (class 2606 OID 29706)
-- Name: salts_fk_drug_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: -
--

ALTER TABLE ONLY salts
    ADD CONSTRAINT salts_fk_drug_fkey FOREIGN KEY (fk_drug) REFERENCES drug(pk);


--
-- TOC entry 2352 (class 2606 OID 28777)
-- Name: synonyms_fk_drug_fkey; Type: FK CONSTRAINT; Schema: drugbank; Owner: -
--

ALTER TABLE ONLY synonyms
    ADD CONSTRAINT synonyms_fk_drug_fkey FOREIGN KEY (fk_drug) REFERENCES drug(pk);


-- Completed on 2013-06-12 23:14:12 EST

--
-- PostgreSQL database dump complete
--

