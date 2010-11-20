--
-- PostgreSQL database dump
--

-- Started on 2010-11-21 00:06:00 EST

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 14 (class 2615 OID 52550)
-- Name: clin_vaccination; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA clin_vaccination;


--
-- TOC entry 3667 (class 0 OID 0)
-- Dependencies: 14
-- Name: SCHEMA clin_vaccination; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA clin_vaccination IS ' Easy GP:2April2008 creates all the tables to do with vaccination ie vaccines (holds the brand names, fk_vaccine_description, form (eg injection) vaccines_descriptions eg typoid or tetanus toxoid, diptheria toxoid vaccines_last_bath_number - dr/nurse specific last batch used';


SET search_path = clin_vaccination, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 2986 (class 1259 OID 54054)
-- Dependencies: 3625 3626 14
-- Name: vaccinations; Type: TABLE; Schema: clin_vaccination; Owner: -; Tablespace: 
--

CREATE TABLE vaccinations (
    pk integer NOT NULL,
    fk_consult integer,
    fk_vaccine integer,
    fk_schedule integer,
    fk_site integer DEFAULT 1 NOT NULL,
    fk_laterality integer,
    fk_route integer,
    date_given character varying(10),
    serial_no text DEFAULT 'not recorded'::text NOT NULL
);


--
-- TOC entry 3669 (class 0 OID 0)
-- Dependencies: 2986
-- Name: COLUMN vaccinations.date_given; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON COLUMN vaccinations.date_given IS 'not a date field because sometimes may need to record just say 01/2002 or 1998';


--
-- TOC entry 2987 (class 1259 OID 54062)
-- Dependencies: 2986 14
-- Name: data_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE data_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 3671 (class 0 OID 0)
-- Dependencies: 2987
-- Name: data_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE data_pk_seq OWNED BY vaccinations.pk;


--
-- TOC entry 3672 (class 0 OID 0)
-- Dependencies: 2987
-- Name: data_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: -
--

SELECT pg_catalog.setval('data_pk_seq', 1, false);


--
-- TOC entry 2988 (class 1259 OID 54064)
-- Dependencies: 14
-- Name: lu_indication; Type: TABLE; Schema: clin_vaccination; Owner: -; Tablespace: 
--

CREATE TABLE lu_indication (
    pk integer NOT NULL,
    medical_name text NOT NULL,
    common_name text
);


--
-- TOC entry 3674 (class 0 OID 0)
-- Dependencies: 2988
-- Name: TABLE lu_indication; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON TABLE lu_indication IS ' vaccine target disease lookup table  eg hepatitis B  todo this should really be a coded field not a text field';


--
-- TOC entry 2989 (class 1259 OID 54070)
-- Dependencies: 2988 14
-- Name: indication_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE indication_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 3676 (class 0 OID 0)
-- Dependencies: 2989
-- Name: indication_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE indication_pk_seq OWNED BY lu_indication.pk;


--
-- TOC entry 3677 (class 0 OID 0)
-- Dependencies: 2989
-- Name: indication_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: -
--

SELECT pg_catalog.setval('indication_pk_seq', 1, false);


--
-- TOC entry 2990 (class 1259 OID 54072)
-- Dependencies: 14
-- Name: last_batch_number; Type: TABLE; Schema: clin_vaccination; Owner: -; Tablespace: 
--

CREATE TABLE last_batch_number (
    pk integer NOT NULL,
    fk_vaccine integer,
    batch_number text NOT NULL,
    fk_provider integer
);


--
-- TOC entry 3679 (class 0 OID 0)
-- Dependencies: 2990
-- Name: TABLE last_batch_number; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON TABLE last_batch_number IS 'last used batch number to make it easier on the doctors typeing when e.g vaccines may be stored in fridges in rooms in a surgery and most doctors and nurses work out of their own rooms. todo link to doctor code table';


--
-- TOC entry 2991 (class 1259 OID 54078)
-- Dependencies: 14 2990
-- Name: last_batch_number_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE last_batch_number_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 3681 (class 0 OID 0)
-- Dependencies: 2991
-- Name: last_batch_number_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE last_batch_number_pk_seq OWNED BY last_batch_number.pk;


--
-- TOC entry 3682 (class 0 OID 0)
-- Dependencies: 2991
-- Name: last_batch_number_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: -
--

SELECT pg_catalog.setval('last_batch_number_pk_seq', 1, false);


--
-- TOC entry 2992 (class 1259 OID 54080)
-- Dependencies: 14
-- Name: link_provider_site_admininstered; Type: TABLE; Schema: clin_vaccination; Owner: -; Tablespace: 
--

CREATE TABLE link_provider_site_admininstered (
    id integer NOT NULL,
    fk_site integer,
    fk_vaccine integer,
    fk_provider integer
);


--
-- TOC entry 3684 (class 0 OID 0)
-- Dependencies: 2992
-- Name: TABLE link_provider_site_admininstered; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON TABLE link_provider_site_admininstered IS 'allows per-provider presentation of usual site of injection';


--
-- TOC entry 2993 (class 1259 OID 54083)
-- Dependencies: 14 2992
-- Name: link_provider_site_admininstered_id_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE link_provider_site_admininstered_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 3686 (class 0 OID 0)
-- Dependencies: 2993
-- Name: link_provider_site_admininstered_id_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE link_provider_site_admininstered_id_seq OWNED BY link_provider_site_admininstered.id;


--
-- TOC entry 3687 (class 0 OID 0)
-- Dependencies: 2993
-- Name: link_provider_site_admininstered_id_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: -
--

SELECT pg_catalog.setval('link_provider_site_admininstered_id_seq', 1, false);


--
-- TOC entry 2994 (class 1259 OID 54085)
-- Dependencies: 14 2988
-- Name: lu_indication_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE lu_indication_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 3689 (class 0 OID 0)
-- Dependencies: 2994
-- Name: lu_indication_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE lu_indication_pk_seq OWNED BY lu_indication.pk;


--
-- TOC entry 3690 (class 0 OID 0)
-- Dependencies: 2994
-- Name: lu_indication_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: -
--

SELECT pg_catalog.setval('lu_indication_pk_seq', 27, true);


--
-- TOC entry 2995 (class 1259 OID 54087)
-- Dependencies: 14
-- Name: lu_schedules; Type: TABLE; Schema: clin_vaccination; Owner: -; Tablespace: 
--

CREATE TABLE lu_schedules (
    pk integer NOT NULL,
    age_due_from_months integer,
    age_due_to_months integer,
    schedule_text text NOT NULL,
    female_only boolean,
    aboriginal_tsi_only boolean,
    fk_season integer,
    date_inactive date,
    inactive boolean
);


--
-- TOC entry 3692 (class 0 OID 0)
-- Dependencies: 2995
-- Name: TABLE lu_schedules; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON TABLE lu_schedules IS 'create schedulescontains the schedules eg 2 month, 4 months, 4yrs etcA vaccination schedule can be a single vaccination or a schedule of
vaccination and contain one or more vaccines. The reason for this is complex
and practical referral to the doc for further information';


--
-- TOC entry 3693 (class 0 OID 0)
-- Dependencies: 2995
-- Name: COLUMN lu_schedules.schedule_text; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON COLUMN lu_schedules.schedule_text IS 'either a target disease name eg ''yellow fever'' or a schedule name to describe course of combined vaccines eg Hepatits A + Hepatitis B.Hence this allows unlimited and user defined schedules.';


--
-- TOC entry 3694 (class 0 OID 0)
-- Dependencies: 2995
-- Name: COLUMN lu_schedules.aboriginal_tsi_only; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON COLUMN lu_schedules.aboriginal_tsi_only IS 'australian requirement, some schedules apply only to aboriginal or torres strait islanders at particular ages';


--
-- TOC entry 3695 (class 0 OID 0)
-- Dependencies: 2995
-- Name: COLUMN lu_schedules.fk_season; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON COLUMN lu_schedules.fk_season IS 'eg. influenza prompts only wanted at particular time of year';


--
-- TOC entry 3696 (class 0 OID 0)
-- Dependencies: 2995
-- Name: COLUMN lu_schedules.inactive; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON COLUMN lu_schedules.inactive IS 'The vaccination schedule/vaccines is no longer in use';


--
-- TOC entry 2996 (class 1259 OID 54093)
-- Dependencies: 2995 14
-- Name: lu_schedules_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE lu_schedules_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 3698 (class 0 OID 0)
-- Dependencies: 2996
-- Name: lu_schedules_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE lu_schedules_pk_seq OWNED BY lu_schedules.pk;


--
-- TOC entry 3699 (class 0 OID 0)
-- Dependencies: 2996
-- Name: lu_schedules_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: -
--

SELECT pg_catalog.setval('lu_schedules_pk_seq', 1, false);


--
-- TOC entry 2997 (class 1259 OID 54095)
-- Dependencies: 14
-- Name: lu_target; Type: TABLE; Schema: clin_vaccination; Owner: -; Tablespace: 
--

CREATE TABLE lu_target (
    pk integer NOT NULL,
    target text NOT NULL
);


--
-- TOC entry 2998 (class 1259 OID 54101)
-- Dependencies: 14 2997
-- Name: lu_target_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE lu_target_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 3702 (class 0 OID 0)
-- Dependencies: 2998
-- Name: lu_target_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE lu_target_pk_seq OWNED BY lu_target.pk;


--
-- TOC entry 3703 (class 0 OID 0)
-- Dependencies: 2998
-- Name: lu_target_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: -
--

SELECT pg_catalog.setval('lu_target_pk_seq', 27, true);


--
-- TOC entry 2999 (class 1259 OID 54103)
-- Dependencies: 3633 14
-- Name: lu_vaccines; Type: TABLE; Schema: clin_vaccination; Owner: -; Tablespace: 
--

CREATE TABLE lu_vaccines (
    pk integer NOT NULL,
    brand text,
    fk_description text,
    fk_route integer,
    form text,
    inserted date DEFAULT ('now'::text)::date,
    deleted date
);


--
-- TOC entry 3705 (class 0 OID 0)
-- Dependencies: 2999
-- Name: TABLE lu_vaccines; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON TABLE lu_vaccines IS 'the master vaccine table containing links totrade name links table, target disease';


--
-- TOC entry 3000 (class 1259 OID 54110)
-- Dependencies: 3635 14
-- Name: lu_vaccines_descriptions; Type: TABLE; Schema: clin_vaccination; Owner: -; Tablespace: 
--

CREATE TABLE lu_vaccines_descriptions (
    pk integer NOT NULL,
    description text,
    inserted date DEFAULT ('now'::text)::date,
    deleted date
);


--
-- TOC entry 3707 (class 0 OID 0)
-- Dependencies: 3000
-- Name: TABLE lu_vaccines_descriptions; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON TABLE lu_vaccines_descriptions IS 'create the vaccines_descriptions table contains names describing what the brand names are eg tetanus, diptheria, or combinations thereof ';


--
-- TOC entry 3001 (class 1259 OID 54117)
-- Dependencies: 14 3000
-- Name: lu_vaccines_descriptions_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE lu_vaccines_descriptions_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 3709 (class 0 OID 0)
-- Dependencies: 3001
-- Name: lu_vaccines_descriptions_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE lu_vaccines_descriptions_pk_seq OWNED BY lu_vaccines_descriptions.pk;


--
-- TOC entry 3710 (class 0 OID 0)
-- Dependencies: 3001
-- Name: lu_vaccines_descriptions_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: -
--

SELECT pg_catalog.setval('lu_vaccines_descriptions_pk_seq', 62, true);


--
-- TOC entry 3002 (class 1259 OID 54119)
-- Dependencies: 14
-- Name: lu_vaccines_in_schedule; Type: TABLE; Schema: clin_vaccination; Owner: -; Tablespace: 
--

CREATE TABLE lu_vaccines_in_schedule (
    pk integer NOT NULL,
    fk_vaccine integer,
    fk_schedule integer
);


--
-- TOC entry 3003 (class 1259 OID 54122)
-- Dependencies: 14 3002
-- Name: lu_vaccines_in_schedule_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE lu_vaccines_in_schedule_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 3713 (class 0 OID 0)
-- Dependencies: 3003
-- Name: lu_vaccines_in_schedule_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE lu_vaccines_in_schedule_pk_seq OWNED BY lu_vaccines_in_schedule.pk;


--
-- TOC entry 3714 (class 0 OID 0)
-- Dependencies: 3003
-- Name: lu_vaccines_in_schedule_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: -
--

SELECT pg_catalog.setval('lu_vaccines_in_schedule_pk_seq', 1, false);


--
-- TOC entry 3004 (class 1259 OID 54124)
-- Dependencies: 14 2999
-- Name: lu_vaccines_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE lu_vaccines_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 3716 (class 0 OID 0)
-- Dependencies: 3004
-- Name: lu_vaccines_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE lu_vaccines_pk_seq OWNED BY lu_vaccines.pk;


--
-- TOC entry 3717 (class 0 OID 0)
-- Dependencies: 3004
-- Name: lu_vaccines_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: -
--

SELECT pg_catalog.setval('lu_vaccines_pk_seq', 62, true);


--
-- TOC entry 3005 (class 1259 OID 54126)
-- Dependencies: 14 3000
-- Name: vaccines_descriptions_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE vaccines_descriptions_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 3719 (class 0 OID 0)
-- Dependencies: 3005
-- Name: vaccines_descriptions_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE vaccines_descriptions_pk_seq OWNED BY lu_vaccines_descriptions.pk;


--
-- TOC entry 3720 (class 0 OID 0)
-- Dependencies: 3005
-- Name: vaccines_descriptions_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: -
--

SELECT pg_catalog.setval('vaccines_descriptions_pk_seq', 1, false);


--
-- TOC entry 3006 (class 1259 OID 54128)
-- Dependencies: 3002 14
-- Name: vaccines_in_schedule_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE vaccines_in_schedule_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 3722 (class 0 OID 0)
-- Dependencies: 3006
-- Name: vaccines_in_schedule_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE vaccines_in_schedule_pk_seq OWNED BY lu_vaccines_in_schedule.pk;


--
-- TOC entry 3723 (class 0 OID 0)
-- Dependencies: 3006
-- Name: vaccines_in_schedule_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: -
--

SELECT pg_catalog.setval('vaccines_in_schedule_pk_seq', 1, false);


--
-- TOC entry 3007 (class 1259 OID 54130)
-- Dependencies: 2999 14
-- Name: vaccines_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE vaccines_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 3725 (class 0 OID 0)
-- Dependencies: 3007
-- Name: vaccines_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE vaccines_pk_seq OWNED BY lu_vaccines.pk;


--
-- TOC entry 3726 (class 0 OID 0)
-- Dependencies: 3007
-- Name: vaccines_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: -
--

SELECT pg_catalog.setval('vaccines_pk_seq', 1, false);


--
-- TOC entry 3009 (class 1259 OID 54138)
-- Dependencies: 3385 14
-- Name: vwvaccines; Type: VIEW; Schema: clin_vaccination; Owner: -
--

CREATE VIEW vwvaccines AS
    SELECT lu_vaccines.pk, lu_vaccines.brand, lu_vaccines.fk_description, lu_vaccines.fk_route, lu_vaccines.form, lu_vaccines.inserted, lu_vaccines.deleted, lu_vaccines_descriptions.description, lu_route_administration.route, lu_route_administration.abbreviation AS route_abbrev FROM ((lu_vaccines JOIN lu_vaccines_descriptions ON ((lu_vaccines.fk_description = (lu_vaccines_descriptions.pk)::text))) LEFT JOIN common.lu_route_administration ON ((lu_vaccines.fk_route = lu_route_administration.pk))) ORDER BY lu_vaccines_descriptions.description;


--
-- TOC entry 3629 (class 2604 OID 55063)
-- Dependencies: 2991 2990
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE last_batch_number ALTER COLUMN pk SET DEFAULT nextval('last_batch_number_pk_seq'::regclass);


--
-- TOC entry 3630 (class 2604 OID 55064)
-- Dependencies: 2993 2992
-- Name: id; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE link_provider_site_admininstered ALTER COLUMN id SET DEFAULT nextval('link_provider_site_admininstered_id_seq'::regclass);


--
-- TOC entry 3628 (class 2604 OID 55065)
-- Dependencies: 2989 2988
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE lu_indication ALTER COLUMN pk SET DEFAULT nextval('indication_pk_seq'::regclass);


--
-- TOC entry 3631 (class 2604 OID 55066)
-- Dependencies: 2996 2995
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE lu_schedules ALTER COLUMN pk SET DEFAULT nextval('lu_schedules_pk_seq'::regclass);


--
-- TOC entry 3632 (class 2604 OID 55067)
-- Dependencies: 2998 2997
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE lu_target ALTER COLUMN pk SET DEFAULT nextval('lu_target_pk_seq'::regclass);


--
-- TOC entry 3634 (class 2604 OID 55068)
-- Dependencies: 3007 2999
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE lu_vaccines ALTER COLUMN pk SET DEFAULT nextval('vaccines_pk_seq'::regclass);


--
-- TOC entry 3636 (class 2604 OID 55069)
-- Dependencies: 3005 3000
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE lu_vaccines_descriptions ALTER COLUMN pk SET DEFAULT nextval('vaccines_descriptions_pk_seq'::regclass);


--
-- TOC entry 3637 (class 2604 OID 55070)
-- Dependencies: 3006 3002
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE lu_vaccines_in_schedule ALTER COLUMN pk SET DEFAULT nextval('vaccines_in_schedule_pk_seq'::regclass);


--
-- TOC entry 3627 (class 2604 OID 55071)
-- Dependencies: 2987 2986
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE vaccinations ALTER COLUMN pk SET DEFAULT nextval('data_pk_seq'::regclass);


--
-- TOC entry 3658 (class 0 OID 54072)
-- Dependencies: 2990
-- Data for Name: last_batch_number; Type: TABLE DATA; Schema: clin_vaccination; Owner: -
--

COPY last_batch_number (pk, fk_vaccine, batch_number, fk_provider) FROM stdin;
\.


--
-- TOC entry 3659 (class 0 OID 54080)
-- Dependencies: 2992
-- Data for Name: link_provider_site_admininstered; Type: TABLE DATA; Schema: clin_vaccination; Owner: -
--

COPY link_provider_site_admininstered (id, fk_site, fk_vaccine, fk_provider) FROM stdin;
\.


--
-- TOC entry 3657 (class 0 OID 54064)
-- Dependencies: 2988
-- Data for Name: lu_indication; Type: TABLE DATA; Schema: clin_vaccination; Owner: -
--

COPY lu_indication (pk, medical_name, common_name) FROM stdin;
1  Vibrio cholerae  cholera
2  diptheria  diptheria
3  haemophylis influenzae  haemophylis
4  hepatitis A  hepatitis A
5  hepatitis B  hepatitis B
6  influenza  influenza
7  japanese b encephalitis  japanese b encephalitis
8  malaria  malaria
9  hiv  aids
10  salmonella typhi  salmonella
11  measles  measles
12  Neisseria meningitidis A  meningococcus A
13  Neisseria meningitidis C  meningococcus C
14  Neisseria meningitidis W  meningococcus W
15  Neisseria meningitidis Y  meningococcus Y
16  mumps  mumps
17  pertussis  whooping cough
18  pneumococcus  pneumococcus
19  poliomyelitis  polio
20  Coxiella burnetii  q fever
21  rabies  rabies
22  rubella  german measles
23  tetanus  lock jaw
24  tuberculosis  tb
25  varicella zoster  chickenpox/shingles
26  yellow fever  yellow fever
27  yersinia pestis  plague
\.


--
-- TOC entry 3660 (class 0 OID 54087)
-- Dependencies: 2995
-- Data for Name: lu_schedules; Type: TABLE DATA; Schema: clin_vaccination; Owner: -
--

COPY lu_schedules (pk, age_due_from_months, age_due_to_months, schedule_text, female_only, aboriginal_tsi_only, fk_season, date_inactive, inactive) FROM stdin;
\.


--
-- TOC entry 3661 (class 0 OID 54095)
-- Dependencies: 2997
-- Data for Name: lu_target; Type: TABLE DATA; Schema: clin_vaccination; Owner: -
--

COPY lu_target (pk, target) FROM stdin;
1  Cholera
2  Coxiella burnetii
3  Diptheria and Tetanus
4  Diptheria, Tetanus, Hepatitis B, Polio, Pertussus
5  Diptheria, Tetanus, Hepatitis B, Polio, Pertussus, Haemophilus
6  Diptheria, Tetanus, Pertussus
7  Diptheria, Tetanus, Polio, Pertussus
8  Haemophilus B
9  Haemophilus B,Hepatitis B vaccine, 
10  Hepatitis A
11  Hepatitis A, Hepatitis B
12  Hepatitis A, Salmonella Typhi
13  Hepatitis B
14  Human papillomavirus Virus
15  Influenza virus
16  Japanese encephalitis
17  Measles Mumps Rubella
18  Neisseria meningitidis
19  Pneumococcus
20  Poliomyelitis
21  Rabies
22  Rotavirus
23  Rubella 
24  Salmonella Typhi
25  Tuberculosis
26  Varicella zoster
27  Yellow fever
\.


--
-- TOC entry 3662 (class 0 OID 54103)
-- Dependencies: 2999
-- Data for Name: lu_vaccines; Type: TABLE DATA; Schema: clin_vaccination; Owner: -
--

COPY lu_vaccines (pk, brand, fk_description, fk_route, form, inserted, deleted) FROM stdin;
125  RotaTeq  1  3  Liquid  2008-04-02  \N
126  Varivax Refrigerated  2  1  Powder for injection  2008-04-02  \N
127  Vaxigrip  3  1  Injection  2008-04-02  \N
128  Vaxigrip Junior  4  1  Injection  2008-04-02  \N
129  Vivaxim  5  1  Injection  2008-04-02  \N
130  Vivotif Oral  6  3  Capsules  2008-04-02  \N
133  Rotarix  9  3  Powder for oral suspension  2008-04-02  \N
135  Tripacel  11  1  Injection  2008-04-02  \N
136  Twinrix (720/20) Injection  12  1  Injection  2008-04-02  \N
137  Twinrix Junior (360/10) Injection  13  1  Injection  2008-04-02  \N
138  Typherix  14  1  Injection  2008-04-02  \N
139  Typhim Vi  15  1  Injection  2008-04-02  \N
140  VAQTA Paediatric/adolescent Formulation Injection  16  1  Injection  2008-04-02  \N
141  VAQTA Adult Formulation Injection  17  1  Injection  2008-04-02  \N
131  Zostavax  7  \N  Powder for injection  2008-04-02  \N
132  Rabipur  8  \N  Powder for injection  2008-04-02  \N
134  Stamaril  10  \N  Injection  2008-04-02  \N
142  Varilrix  18  \N  Powder for injection  2008-04-02  \N
143  Meruvax II  19  \N  Injection  2008-04-02  \N
144  NeisVac-C Vaccine  20  \N  Injection  2008-04-02  \N
149  Quadracel  25  \N  Injection  2008-04-02  \N
150  Q-Vax Vaccine  26  \N  Solution for injection  2008-04-02  \N
151  Q-Vax Skin Test  27  \N  Concentrate for injection  2008-04-02  \N
155  Je-Vax  31  \N  Injection  2008-04-02  \N
157  Mencevax ACWY  33  \N  Powder for injection  2008-04-02  \N
161  Merieux Inactivated Rabies Vaccine  37  \N  Injection  2008-04-02  \N
181  BCG Vaccine  57  \N  Injection  2008-04-02  \N
145  Pneumovax 23  21  1  Injection  2008-04-02  \N
146  Polio Sabin (oral) Multidose  22  0  Drop  2008-04-02  \N
147  Prevenar  23  1  Suspension for injection  2008-04-02  \N
148  Priorix  24  1  Powder for injection  2008-04-02  \N
152  Infanrix Penta  28  1  Injection  2008-04-02  \N
153  Influvac  29  2  Suspension for injection  2008-04-02  \N
154  Ipol  30  1  Injection  2008-04-02  \N
156  Liquid PedvaxHIB  32  1  Suspension for injection  2008-04-02  \N
158  Meningitec  34  1  Injection  2008-04-02  \N
159  Menjugate Syringe  35  1  Powder for reconstitution  2008-04-02  \N
160  Menomune  36  1  Injection  2008-04-02  \N
162  Engerix-B Adult Formulation Injection  38  1  Injection  2008-04-02  \N
163  Engerix-B Paediatric Formulation Injection  39  1  Injection  2008-04-02  \N
164  Fluad  40  2  Injection  2008-04-02  \N
165  Fluarix  41  2  Suspension for injection  2008-04-02  \N
166  Fluvax  42  2  Injection  2008-04-02  \N
167  Gardasil  43  1  Suspension for injection  2008-04-02  \N
168  Havrix monodose vial Injection  44  1  Injection  2008-04-02  \N
169  Havrix prefilled syringe Injection  45  1  Injection  2008-04-02  \N
170  Havrix Junior prefilled syringe Injection  46  1  Injection  2008-04-02  \N
171  H-B-Vax II Paediatric Formulation Injection Preservative Free  47  1  Suspension for injection  2008-04-02  \N
172  H-B-Vax II Adult Formulation Injection Preservative Free  48  1  Suspension for injection  2008-04-02  \N
173  H-B-Vax II Dialysis Formulation Injection Preservative Free  49  1  Suspension for injection  2008-04-02  \N
174  Hiberix  50  1  Injection  2008-04-02  \N
175  Infanrix Hexa  51  1  Injection  2008-04-02  \N
176  Infanrix IPV  52  1  Suspension for injection  2008-04-02  \N
177  Adacel  53  1  Suspension for injection  2008-04-02  \N
178  Adacel Polio  54  1  Suspension for injection  2008-04-02  \N
179  ADT Booster  55  1  Injection  2008-04-02  \N
180  Avaxim Inactivated Hepatitis A Vaccine  56  1  Injection  2008-04-02  \N
182  Boostrix  58  1  Suspension for injection  2008-04-02  \N
183  Boostrix-IPV  59  1  Suspension for injection  2008-04-02  \N
184  Cervarix  60  1  Injection  2008-04-02  \N
185  Comvax  61  1  Injection  2008-04-02  \N
186  Dukoral  62  3  Suspension  2008-04-02  \N
\.


--
-- TOC entry 3663 (class 0 OID 54110)
-- Dependencies: 3000
-- Data for Name: lu_vaccines_descriptions; Type: TABLE DATA; Schema: clin_vaccination; Owner: -
--

COPY lu_vaccines_descriptions (pk, description, inserted, deleted) FROM stdin;
1  Rotavirus vaccine, live, oral,   2008-04-02  \N
2  Varicella zoster vaccine, live attenuated,   2008-04-02  \N
3  Influenza virus vaccine,   2008-04-02  \N
4  Influenza virus vaccine,   2008-04-02  \N
5  Hepatitis A vaccine, Salmonella typhi vaccine,   2008-04-02  \N
6  Salmonella typhi vaccine, oral,   2008-04-02  \N
7  Varicella zoster vaccine, live attenuated,   2008-04-02  \N
8  Rabies vaccine,   2008-04-02  \N
9  Rotavirus vaccine, live, oral,   2008-04-02  \N
10  Yellow fever vaccine,   2008-04-02  \N
11  Diphtheria toxoid, Tetanus toxoid, Pertussis vaccine,   2008-04-02  \N
12  Hepatitis B vaccine, Hepatitis A vaccine,   2008-04-02  \N
13  Hepatitis B vaccine, Hepatitis A vaccine,   2008-04-02  \N
14  Salmonella typhi vaccine,   2008-04-02  \N
15  Salmonella typhi vaccine,   2008-04-02  \N
16  Hepatitis A vaccine,   2008-04-02  \N
17  Hepatitis A vaccine,   2008-04-02  \N
18  Varicella zoster vaccine, live attenuated,   2008-04-02  \N
19  Rubella vaccine,   2008-04-02  \N
20  Neisseria meningitidis vaccine,   2008-04-02  \N
21  Pneumococcal vaccine,   2008-04-02  \N
22  Poliomyelitis vaccine, oral,   2008-04-02  \N
23  Pneumococcal vaccine,   2008-04-02  \N
24  Measles vaccine, live, Mumps vaccine, live, Rubella vaccine, live,   2008-04-02  \N
25  Diphtheria toxoid, Tetanus toxoid, Poliomyelitis vaccine, Pertussis vaccine,   2008-04-02  \N
26  Coxiella burnetii vaccine,   2008-04-02  \N
27  Coxiella burnetii vaccine,   2008-04-02  \N
28  Diphtheria toxoid, Tetanus toxoid, Hepatitis B vaccine, Poliomyelitis vaccine, Pertussis vaccine,   2008-04-02  \N
29  Influenza virus vaccine,   2008-04-02  \N
30  Poliomyelitis vaccine,   2008-04-02  \N
31  Japanese encephalitis virus vaccine,   2008-04-02  \N
32  Haemophilus B conjugate vaccine,   2008-04-02  \N
33  Neisseria meningitidis vaccine,   2008-04-02  \N
34  Neisseria meningitidis vaccine,   2008-04-02  \N
35  Neisseria meningitidis vaccine,   2008-04-02  \N
36  Neisseria meningitidis vaccine,   2008-04-02  \N
37  Rabies vaccine,   2008-04-02  \N
38  Hepatitis B vaccine,   2008-04-02  \N
39  Hepatitis B vaccine,   2008-04-02  \N
40  Influenza virus vaccine,   2008-04-02  \N
41  Influenza virus vaccine,   2008-04-02  \N
42  Influenza virus vaccine,   2008-04-02  \N
43  Human papillomavirus vaccine, recombinant,   2008-04-02  \N
44  Hepatitis A vaccine,   2008-04-02  \N
45  Hepatitis A vaccine,   2008-04-02  \N
46  Hepatitis A vaccine,   2008-04-02  \N
47  Hepatitis B vaccine,   2008-04-02  \N
48  Hepatitis B vaccine,   2008-04-02  \N
49  Hepatitis B vaccine,   2008-04-02  \N
50  Haemophilus B conjugate vaccine,   2008-04-02  \N
51  Diphtheria toxoid, Tetanus toxoid, Hepatitis B vaccine, Poliomyelitis vaccine, Pertussis vaccine, Haemophilus influenzae vaccine,   2008-04-02  \N
52  Diphtheria toxoid, Tetanus toxoid, Poliomyelitis vaccine, Pertussis vaccine,   2008-04-02  \N
53  Diphtheria toxoid, Tetanus toxoid, Pertussis vaccine,   2008-04-02  \N
54  Diphtheria toxoid, Tetanus toxoid, Poliomyelitis vaccine, Pertussis vaccine,   2008-04-02  \N
55  Diphtheria toxoid, Tetanus toxoid,   2008-04-02  \N
56  Hepatitis A vaccine,   2008-04-02  \N
57  BCG vaccine,   2008-04-02  \N
58  Diphtheria toxoid, Tetanus toxoid, Pertussis vaccine,   2008-04-02  \N
59  Diphtheria toxoid, Tetanus toxoid, Poliomyelitis vaccine, Pertussis vaccine,   2008-04-02  \N
60  Human papillomavirus vaccine, recombinant,   2008-04-02  \N
61  Haemophilus B conjugate vaccine, Hepatitis B vaccine,   2008-04-02  \N
62  Vibrio cholerae vaccine, Cholera toxin B subunit (recombinant),   2008-04-02  \N
\.


--
-- TOC entry 3664 (class 0 OID 54119)
-- Dependencies: 3002
-- Data for Name: lu_vaccines_in_schedule; Type: TABLE DATA; Schema: clin_vaccination; Owner: -
--

COPY lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule) FROM stdin;
\.


--
-- TOC entry 3656 (class 0 OID 54054)
-- Dependencies: 2986
-- Data for Name: vaccinations; Type: TABLE DATA; Schema: clin_vaccination; Owner: -
--

COPY vaccinations (pk, fk_consult, fk_vaccine, fk_schedule, fk_site, fk_laterality, fk_route, date_given, serial_no) FROM stdin;
\.


--
-- TOC entry 3639 (class 2606 OID 55425)
-- Dependencies: 2986 2986
-- Name: data_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY vaccinations
    ADD CONSTRAINT data_pkey PRIMARY KEY (pk);


--
-- TOC entry 3641 (class 2606 OID 55427)
-- Dependencies: 2988 2988
-- Name: indication_key; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_indication
    ADD CONSTRAINT indication_key UNIQUE (medical_name);


--
-- TOC entry 3645 (class 2606 OID 55429)
-- Dependencies: 2990 2990
-- Name: last_batch_number_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY last_batch_number
    ADD CONSTRAINT last_batch_number_pkey PRIMARY KEY (pk);


--
-- TOC entry 3643 (class 2606 OID 55431)
-- Dependencies: 2988 2988
-- Name: lu_indication_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_indication
    ADD CONSTRAINT lu_indication_pkey PRIMARY KEY (pk);


--
-- TOC entry 3647 (class 2606 OID 55433)
-- Dependencies: 2995 2995
-- Name: lu_schedules_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_schedules
    ADD CONSTRAINT lu_schedules_pkey PRIMARY KEY (pk);


--
-- TOC entry 3649 (class 2606 OID 55435)
-- Dependencies: 2997 2997
-- Name: lu_target_pkey1; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_target
    ADD CONSTRAINT lu_target_pkey1 PRIMARY KEY (pk);


--
-- TOC entry 3653 (class 2606 OID 55437)
-- Dependencies: 3000 3000
-- Name: lu_vaccines_descriptions_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_vaccines_descriptions
    ADD CONSTRAINT lu_vaccines_descriptions_pkey PRIMARY KEY (pk);


--
-- TOC entry 3655 (class 2606 OID 55439)
-- Dependencies: 3002 3002
-- Name: lu_vaccines_in_schedule_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_vaccines_in_schedule
    ADD CONSTRAINT lu_vaccines_in_schedule_pkey PRIMARY KEY (pk);


--
-- TOC entry 3651 (class 2606 OID 55441)
-- Dependencies: 2999 2999
-- Name: lu_vaccines_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_vaccines
    ADD CONSTRAINT lu_vaccines_pkey PRIMARY KEY (pk);


--
-- TOC entry 3668 (class 0 OID 0)
-- Dependencies: 14
-- Name: clin_vaccination; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA clin_vaccination FROM PUBLIC;
REVOKE ALL ON SCHEMA clin_vaccination FROM easygp;
GRANT ALL ON SCHEMA clin_vaccination TO easygp;
GRANT USAGE ON SCHEMA clin_vaccination TO staff;


--
-- TOC entry 3670 (class 0 OID 0)
-- Dependencies: 2986
-- Name: vaccinations; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE vaccinations FROM PUBLIC;
REVOKE ALL ON TABLE vaccinations FROM easygp;
GRANT ALL ON TABLE vaccinations TO easygp;
GRANT ALL ON TABLE vaccinations TO staff;


--
-- TOC entry 3673 (class 0 OID 0)
-- Dependencies: 2987
-- Name: data_pk_seq; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON SEQUENCE data_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE data_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE data_pk_seq TO easygp;
GRANT USAGE ON SEQUENCE data_pk_seq TO staff;


--
-- TOC entry 3675 (class 0 OID 0)
-- Dependencies: 2988
-- Name: lu_indication; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE lu_indication FROM PUBLIC;
REVOKE ALL ON TABLE lu_indication FROM easygp;
GRANT ALL ON TABLE lu_indication TO easygp;
GRANT SELECT ON TABLE lu_indication TO staff;


--
-- TOC entry 3678 (class 0 OID 0)
-- Dependencies: 2989
-- Name: indication_pk_seq; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON SEQUENCE indication_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE indication_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE indication_pk_seq TO easygp;
GRANT USAGE ON SEQUENCE indication_pk_seq TO staff;


--
-- TOC entry 3680 (class 0 OID 0)
-- Dependencies: 2990
-- Name: last_batch_number; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE last_batch_number FROM PUBLIC;
REVOKE ALL ON TABLE last_batch_number FROM easygp;
GRANT ALL ON TABLE last_batch_number TO easygp;
GRANT ALL ON TABLE last_batch_number TO staff;


--
-- TOC entry 3683 (class 0 OID 0)
-- Dependencies: 2991
-- Name: last_batch_number_pk_seq; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON SEQUENCE last_batch_number_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE last_batch_number_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE last_batch_number_pk_seq TO easygp;
GRANT USAGE ON SEQUENCE last_batch_number_pk_seq TO staff;


--
-- TOC entry 3685 (class 0 OID 0)
-- Dependencies: 2992
-- Name: link_provider_site_admininstered; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE link_provider_site_admininstered FROM PUBLIC;
REVOKE ALL ON TABLE link_provider_site_admininstered FROM easygp;
GRANT ALL ON TABLE link_provider_site_admininstered TO easygp;
GRANT ALL ON TABLE link_provider_site_admininstered TO staff;


--
-- TOC entry 3688 (class 0 OID 0)
-- Dependencies: 2993
-- Name: link_provider_site_admininstered_id_seq; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON SEQUENCE link_provider_site_admininstered_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE link_provider_site_admininstered_id_seq FROM easygp;
GRANT ALL ON SEQUENCE link_provider_site_admininstered_id_seq TO easygp;
GRANT USAGE ON SEQUENCE link_provider_site_admininstered_id_seq TO staff;


--
-- TOC entry 3691 (class 0 OID 0)
-- Dependencies: 2994
-- Name: lu_indication_pk_seq; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON SEQUENCE lu_indication_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_indication_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_indication_pk_seq TO easygp;
GRANT USAGE ON SEQUENCE lu_indication_pk_seq TO staff;


--
-- TOC entry 3697 (class 0 OID 0)
-- Dependencies: 2995
-- Name: lu_schedules; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE lu_schedules FROM PUBLIC;
REVOKE ALL ON TABLE lu_schedules FROM easygp;
GRANT ALL ON TABLE lu_schedules TO easygp;
GRANT SELECT ON TABLE lu_schedules TO staff;


--
-- TOC entry 3700 (class 0 OID 0)
-- Dependencies: 2996
-- Name: lu_schedules_pk_seq; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON SEQUENCE lu_schedules_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_schedules_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_schedules_pk_seq TO easygp;
GRANT USAGE ON SEQUENCE lu_schedules_pk_seq TO staff;


--
-- TOC entry 3701 (class 0 OID 0)
-- Dependencies: 2997
-- Name: lu_target; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE lu_target FROM PUBLIC;
REVOKE ALL ON TABLE lu_target FROM easygp;
GRANT ALL ON TABLE lu_target TO easygp;
GRANT SELECT ON TABLE lu_target TO staff;


--
-- TOC entry 3704 (class 0 OID 0)
-- Dependencies: 2998
-- Name: lu_target_pk_seq; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON SEQUENCE lu_target_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_target_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_target_pk_seq TO easygp;
GRANT USAGE ON SEQUENCE lu_target_pk_seq TO staff;


--
-- TOC entry 3706 (class 0 OID 0)
-- Dependencies: 2999
-- Name: lu_vaccines; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE lu_vaccines FROM PUBLIC;
REVOKE ALL ON TABLE lu_vaccines FROM easygp;
GRANT ALL ON TABLE lu_vaccines TO easygp;
GRANT SELECT ON TABLE lu_vaccines TO staff;


--
-- TOC entry 3708 (class 0 OID 0)
-- Dependencies: 3000
-- Name: lu_vaccines_descriptions; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE lu_vaccines_descriptions FROM PUBLIC;
REVOKE ALL ON TABLE lu_vaccines_descriptions FROM easygp;
GRANT ALL ON TABLE lu_vaccines_descriptions TO easygp;
GRANT SELECT ON TABLE lu_vaccines_descriptions TO staff;


--
-- TOC entry 3711 (class 0 OID 0)
-- Dependencies: 3001
-- Name: lu_vaccines_descriptions_pk_seq; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON SEQUENCE lu_vaccines_descriptions_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_vaccines_descriptions_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_vaccines_descriptions_pk_seq TO easygp;
GRANT USAGE ON SEQUENCE lu_vaccines_descriptions_pk_seq TO staff;


--
-- TOC entry 3712 (class 0 OID 0)
-- Dependencies: 3002
-- Name: lu_vaccines_in_schedule; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE lu_vaccines_in_schedule FROM PUBLIC;
REVOKE ALL ON TABLE lu_vaccines_in_schedule FROM easygp;
GRANT ALL ON TABLE lu_vaccines_in_schedule TO easygp;
GRANT SELECT ON TABLE lu_vaccines_in_schedule TO staff;


--
-- TOC entry 3715 (class 0 OID 0)
-- Dependencies: 3003
-- Name: lu_vaccines_in_schedule_pk_seq; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON SEQUENCE lu_vaccines_in_schedule_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_vaccines_in_schedule_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_vaccines_in_schedule_pk_seq TO easygp;
GRANT USAGE ON SEQUENCE lu_vaccines_in_schedule_pk_seq TO staff;


--
-- TOC entry 3718 (class 0 OID 0)
-- Dependencies: 3004
-- Name: lu_vaccines_pk_seq; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON SEQUENCE lu_vaccines_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_vaccines_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_vaccines_pk_seq TO easygp;
GRANT USAGE ON SEQUENCE lu_vaccines_pk_seq TO staff;


--
-- TOC entry 3721 (class 0 OID 0)
-- Dependencies: 3005
-- Name: vaccines_descriptions_pk_seq; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON SEQUENCE vaccines_descriptions_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE vaccines_descriptions_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE vaccines_descriptions_pk_seq TO easygp;
GRANT USAGE ON SEQUENCE vaccines_descriptions_pk_seq TO staff;


--
-- TOC entry 3724 (class 0 OID 0)
-- Dependencies: 3006
-- Name: vaccines_in_schedule_pk_seq; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON SEQUENCE vaccines_in_schedule_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE vaccines_in_schedule_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE vaccines_in_schedule_pk_seq TO easygp;
GRANT USAGE ON SEQUENCE vaccines_in_schedule_pk_seq TO staff;


--
-- TOC entry 3727 (class 0 OID 0)
-- Dependencies: 3007
-- Name: vaccines_pk_seq; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON SEQUENCE vaccines_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE vaccines_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE vaccines_pk_seq TO easygp;
GRANT USAGE ON SEQUENCE vaccines_pk_seq TO staff;


--
-- TOC entry 3728 (class 0 OID 0)
-- Dependencies: 3009
-- Name: vwvaccines; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE vwvaccines FROM PUBLIC;
REVOKE ALL ON TABLE vwvaccines FROM easygp;
GRANT ALL ON TABLE vwvaccines TO easygp;
GRANT ALL ON TABLE vwvaccines TO staff;


-- Completed on 2010-11-21 00:06:01 EST

--
-- PostgreSQL database dump complete
--

