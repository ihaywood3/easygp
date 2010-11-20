--
-- PostgreSQL database dump
--

-- Started on 2010-11-20 11:03:11 EST

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 33 (class 2615 OID 284723)
-- Name: clin_vaccination; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA clin_vaccination;


--
-- TOC entry 3670 (class 0 OID 0)
-- Dependencies: 33
-- Name: SCHEMA clin_vaccination; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA clin_vaccination IS ' Easy GP:2April2008 creates all the tables to do with vaccination ie vaccines (holds the brand names, fk_vaccine_description, form (eg injection) vaccines_descriptions eg typoid or tetanus toxoid, diptheria toxoid vaccines_last_bath_number - dr/nurse specific last batch used';


SET search_path = clin_vaccination, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 3028 (class 1259 OID 286270)
-- Dependencies: 3624 3625 33
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
-- TOC entry 3672 (class 0 OID 0)
-- Dependencies: 3028
-- Name: COLUMN vaccinations.date_given; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON COLUMN vaccinations.date_given IS 'not a date field because sometimes may need to record just say 01/2002 or 1998';


--
-- TOC entry 3029 (class 1259 OID 286278)
-- Dependencies: 3028 33
-- Name: data_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE data_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 3674 (class 0 OID 0)
-- Dependencies: 3029
-- Name: data_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE data_pk_seq OWNED BY vaccinations.pk;


--
-- TOC entry 3675 (class 0 OID 0)
-- Dependencies: 3029
-- Name: data_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: -
--

SELECT pg_catalog.setval('data_pk_seq', 1, true);


--
-- TOC entry 3030 (class 1259 OID 286280)
-- Dependencies: 33
-- Name: lu_indication; Type: TABLE; Schema: clin_vaccination; Owner: -; Tablespace: 
--

CREATE TABLE lu_indication (
    pk integer NOT NULL,
    medical_name text NOT NULL,
    common_name text
);


--
-- TOC entry 3677 (class 0 OID 0)
-- Dependencies: 3030
-- Name: TABLE lu_indication; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON TABLE lu_indication IS ' vaccine target disease lookup table  eg hepatitis B  todo this should really be a coded field not a text field';


--
-- TOC entry 3031 (class 1259 OID 286286)
-- Dependencies: 3030 33
-- Name: indication_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE indication_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 3679 (class 0 OID 0)
-- Dependencies: 3031
-- Name: indication_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE indication_pk_seq OWNED BY lu_indication.pk;


--
-- TOC entry 3680 (class 0 OID 0)
-- Dependencies: 3031
-- Name: indication_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: -
--

SELECT pg_catalog.setval('indication_pk_seq', 1, false);


--
-- TOC entry 3032 (class 1259 OID 286288)
-- Dependencies: 33
-- Name: last_batch_number; Type: TABLE; Schema: clin_vaccination; Owner: -; Tablespace: 
--

CREATE TABLE last_batch_number (
    pk integer NOT NULL,
    fk_vaccine integer,
    batch_number text NOT NULL
);


--
-- TOC entry 3682 (class 0 OID 0)
-- Dependencies: 3032
-- Name: TABLE last_batch_number; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON TABLE last_batch_number IS 'last used batch number to make it easier on the doctors typeing when e.g vaccines may be stored in fridges in rooms in a surgery and most doctors and nurses work out of their own rooms. todo link to doctor code table';


--
-- TOC entry 3033 (class 1259 OID 286294)
-- Dependencies: 3032 33
-- Name: last_batch_number_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE last_batch_number_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 3684 (class 0 OID 0)
-- Dependencies: 3033
-- Name: last_batch_number_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE last_batch_number_pk_seq OWNED BY last_batch_number.pk;


--
-- TOC entry 3685 (class 0 OID 0)
-- Dependencies: 3033
-- Name: last_batch_number_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: -
--

SELECT pg_catalog.setval('last_batch_number_pk_seq', 1, false);


--
-- TOC entry 3034 (class 1259 OID 286296)
-- Dependencies: 3629 33
-- Name: lu_descriptions; Type: TABLE; Schema: clin_vaccination; Owner: -; Tablespace: 
--

CREATE TABLE lu_descriptions (
    pk integer NOT NULL,
    description text,
    deleted boolean DEFAULT false
);


--
-- TOC entry 3687 (class 0 OID 0)
-- Dependencies: 3034
-- Name: TABLE lu_descriptions; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON TABLE lu_descriptions IS 'create the vaccines_descriptions table contains names describing what the brand names are eg tetanus, diptheria, or combinations thereof ';


--
-- TOC entry 3035 (class 1259 OID 286303)
-- Dependencies: 3030 33
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
-- Dependencies: 3035
-- Name: lu_indication_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE lu_indication_pk_seq OWNED BY lu_indication.pk;


--
-- TOC entry 3690 (class 0 OID 0)
-- Dependencies: 3035
-- Name: lu_indication_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: -
--

SELECT pg_catalog.setval('lu_indication_pk_seq', 27, true);


--
-- TOC entry 3036 (class 1259 OID 286305)
-- Dependencies: 3631 3632 3633 3634 3635 33
-- Name: lu_schedules; Type: TABLE; Schema: clin_vaccination; Owner: -; Tablespace: 
--

CREATE TABLE lu_schedules (
    pk integer NOT NULL,
    age_due_from_months integer,
    age_due_to_months integer,
    schedule text NOT NULL,
    female_only boolean DEFAULT false,
    atsi_only boolean DEFAULT false,
    fk_season integer,
    inactive boolean DEFAULT false,
    date_inactive date,
    deleted boolean DEFAULT false,
    multiple_vaccines boolean DEFAULT false,
    notes text
);


--
-- TOC entry 3692 (class 0 OID 0)
-- Dependencies: 3036
-- Name: TABLE lu_schedules; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON TABLE lu_schedules IS 'create schedulescontains the schedules eg 2 month, 4 months, 4yrs etcA vaccination schedule can be a single vaccination or a schedule of
vaccination and contain one or more vaccines. The reason for this is complex
and practical referral to the doc for further information';


--
-- TOC entry 3693 (class 0 OID 0)
-- Dependencies: 3036
-- Name: COLUMN lu_schedules.schedule; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON COLUMN lu_schedules.schedule IS 'either a target disease name eg ''yellow fever'' or a schedule name to describe course of combined vaccines eg Hepatits A + Hepatitis B.Hence this allows unlimited and user defined schedules.';


--
-- TOC entry 3694 (class 0 OID 0)
-- Dependencies: 3036
-- Name: COLUMN lu_schedules.atsi_only; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON COLUMN lu_schedules.atsi_only IS 'australian requirement, some schedules apply only to aboriginal or torres strait islanders at particular ages';


--
-- TOC entry 3695 (class 0 OID 0)
-- Dependencies: 3036
-- Name: COLUMN lu_schedules.fk_season; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON COLUMN lu_schedules.fk_season IS 'eg. influenza prompts only wanted at particular time of year';


--
-- TOC entry 3696 (class 0 OID 0)
-- Dependencies: 3036
-- Name: COLUMN lu_schedules.multiple_vaccines; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON COLUMN lu_schedules.multiple_vaccines IS 'if TRUE this vaccine schedule aka target contains muliple separate vaccines
 for example in AU the 2 month childhood has 2 separate injections and 1 oral vaccine';


--
-- TOC entry 3697 (class 0 OID 0)
-- Dependencies: 3036
-- Name: COLUMN lu_schedules.notes; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON COLUMN lu_schedules.notes IS 'any additional notes, eg the NSW 12-13yrs schedule is a school program only';


--
-- TOC entry 3037 (class 1259 OID 286316)
-- Dependencies: 3036 33
-- Name: lu_schedules_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE lu_schedules_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 3699 (class 0 OID 0)
-- Dependencies: 3037
-- Name: lu_schedules_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE lu_schedules_pk_seq OWNED BY lu_schedules.pk;


--
-- TOC entry 3700 (class 0 OID 0)
-- Dependencies: 3037
-- Name: lu_schedules_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: -
--

SELECT pg_catalog.setval('lu_schedules_pk_seq', 60, true);


--
-- TOC entry 3038 (class 1259 OID 286318)
-- Dependencies: 33
-- Name: lu_target; Type: TABLE; Schema: clin_vaccination; Owner: -; Tablespace: 
--

CREATE TABLE lu_target (
    pk integer NOT NULL,
    target text NOT NULL
);


--
-- TOC entry 3039 (class 1259 OID 286324)
-- Dependencies: 3038 33
-- Name: lu_target_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE lu_target_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 3703 (class 0 OID 0)
-- Dependencies: 3039
-- Name: lu_target_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE lu_target_pk_seq OWNED BY lu_target.pk;


--
-- TOC entry 3704 (class 0 OID 0)
-- Dependencies: 3039
-- Name: lu_target_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: -
--

SELECT pg_catalog.setval('lu_target_pk_seq', 27, true);


--
-- TOC entry 3040 (class 1259 OID 286326)
-- Dependencies: 3638 33
-- Name: lu_vaccines; Type: TABLE; Schema: clin_vaccination; Owner: -; Tablespace: 
--

CREATE TABLE lu_vaccines (
    pk integer NOT NULL,
    brand text,
    form text,
    fk_description integer,
    fk_route integer,
    inactive boolean DEFAULT false
);


--
-- TOC entry 3706 (class 0 OID 0)
-- Dependencies: 3040
-- Name: TABLE lu_vaccines; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON TABLE lu_vaccines IS 'A Table to hold all vaccines.
 Note as the database will contain legacy data, some of these brand names are no
 longer commercially available, so inactive will be true.I''ve not put a date 
 inactive inactive in here as I didn''t think it was important, or usually knowable';


--
-- TOC entry 3041 (class 1259 OID 286333)
-- Dependencies: 3034 33
-- Name: lu_vaccines_descriptions_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE lu_vaccines_descriptions_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 3708 (class 0 OID 0)
-- Dependencies: 3041
-- Name: lu_vaccines_descriptions_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE lu_vaccines_descriptions_pk_seq OWNED BY lu_descriptions.pk;


--
-- TOC entry 3709 (class 0 OID 0)
-- Dependencies: 3041
-- Name: lu_vaccines_descriptions_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: -
--

SELECT pg_catalog.setval('lu_vaccines_descriptions_pk_seq', 41, true);


--
-- TOC entry 3042 (class 1259 OID 286335)
-- Dependencies: 3640 33
-- Name: lu_vaccines_in_schedule; Type: TABLE; Schema: clin_vaccination; Owner: -; Tablespace: 
--

CREATE TABLE lu_vaccines_in_schedule (
    pk integer NOT NULL,
    fk_vaccine integer,
    fk_schedule integer,
    atsi_only boolean DEFAULT false,
    date_inactive date
);


--
-- TOC entry 3043 (class 1259 OID 286339)
-- Dependencies: 3042 33
-- Name: lu_vaccines_in_schedule_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE lu_vaccines_in_schedule_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 3711 (class 0 OID 0)
-- Dependencies: 3043
-- Name: lu_vaccines_in_schedule_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE lu_vaccines_in_schedule_pk_seq OWNED BY lu_vaccines_in_schedule.pk;


--
-- TOC entry 3712 (class 0 OID 0)
-- Dependencies: 3043
-- Name: lu_vaccines_in_schedule_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: -
--

SELECT pg_catalog.setval('lu_vaccines_in_schedule_pk_seq', 170, true);


--
-- TOC entry 3044 (class 1259 OID 286341)
-- Dependencies: 3040 33
-- Name: lu_vaccines_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE lu_vaccines_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 3713 (class 0 OID 0)
-- Dependencies: 3044
-- Name: lu_vaccines_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE lu_vaccines_pk_seq OWNED BY lu_vaccines.pk;


--
-- TOC entry 3714 (class 0 OID 0)
-- Dependencies: 3044
-- Name: lu_vaccines_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: -
--

SELECT pg_catalog.setval('lu_vaccines_pk_seq', 193, true);


--
-- TOC entry 3266 (class 1259 OID 288926)
-- Dependencies: 3429 33
-- Name: vwvaccines; Type: VIEW; Schema: clin_vaccination; Owner: -
--

CREATE VIEW vwvaccines AS
    SELECT lu_vaccines.pk, lu_vaccines.brand, lu_vaccines.form, lu_vaccines.fk_description, lu_vaccines.inactive AS vaccine_inactive, lu_descriptions.description, lu_descriptions.deleted AS decription_deleted FROM (lu_vaccines JOIN lu_descriptions ON ((lu_vaccines.fk_description = lu_descriptions.pk))) ORDER BY lu_descriptions.description;


--
-- TOC entry 3269 (class 1259 OID 288989)
-- Dependencies: 3432 33
-- Name: vwvaccinesgiven; Type: VIEW; Schema: clin_vaccination; Owner: -
--

CREATE VIEW vwvaccinesgiven AS
    SELECT consult.fk_patient, vwstaff.title AS staff_title, vwstaff.wholename AS staff_wholename, consult.consult_date, vaccinations.pk AS pk_vaccination, vaccinations.fk_vaccine, vaccinations.fk_schedule, vaccinations.fk_site, vaccinations.fk_laterality, vaccinations.fk_route, vaccinations.date_given, vaccinations.serial_no, consult.fk_staff, vaccinations.fk_consult, lu_route_administration.route, lu_schedules.age_due_from_months, lu_schedules.age_due_to_months, lu_schedules.schedule, lu_schedules.female_only, lu_schedules.atsi_only, lu_schedules.fk_season, lu_schedules.inactive AS schedule_inactive, lu_schedules.date_inactive AS date_schedule_inactive, lu_schedules.deleted AS schedule_deleted, lu_schedules.multiple_vaccines, lu_schedules.notes AS schedule_notes, lu_seasons.season, lu_laterality.laterality, lu_site_administration.site FROM (((((((vaccinations JOIN clin_consult.consult ON ((vaccinations.fk_consult = consult.pk))) JOIN admin.vwstaff ON ((consult.fk_staff = vwstaff.fk_staff))) JOIN common.lu_route_administration ON ((vaccinations.fk_route = lu_route_administration.pk))) JOIN lu_schedules ON ((vaccinations.fk_schedule = lu_schedules.pk))) LEFT JOIN common.lu_seasons ON ((lu_schedules.fk_season = lu_seasons.pk))) JOIN common.lu_laterality ON ((vaccinations.fk_laterality = lu_laterality.pk))) LEFT JOIN common.lu_site_administration ON ((vaccinations.fk_site = lu_site_administration.pk))) ORDER BY consult.fk_patient, vaccinations.fk_schedule, vaccinations.fk_consult;


--
-- TOC entry 3267 (class 1259 OID 288934)
-- Dependencies: 3430 33
-- Name: vwvaccinesinschedule; Type: VIEW; Schema: clin_vaccination; Owner: -
--

CREATE VIEW vwvaccinesinschedule AS
    SELECT ((lu_vaccines_in_schedule.fk_schedule || '-'::text) || lu_vaccines_in_schedule.fk_vaccine) AS pk_view, lu_vaccines_in_schedule.pk AS fk_lu_vaccines_in_schedule, lu_vaccines_in_schedule.fk_schedule, lu_vaccines_in_schedule.atsi_only, lu_vaccines_in_schedule.date_inactive AS date_vaccine_inactive, lu_vaccines.brand, lu_vaccines.fk_route, lu_vaccines.form, lu_vaccines.fk_description, lu_vaccines_in_schedule.fk_vaccine, lu_descriptions.description, lu_descriptions.deleted AS description_deleted FROM ((lu_vaccines_in_schedule JOIN lu_vaccines ON ((lu_vaccines_in_schedule.fk_vaccine = lu_vaccines.pk))) JOIN lu_descriptions ON ((lu_vaccines.fk_description = lu_descriptions.pk))) ORDER BY lu_vaccines_in_schedule.fk_schedule, lu_vaccines.brand;


--
-- TOC entry 3268 (class 1259 OID 288969)
-- Dependencies: 3431 33
-- Name: vwvaccinesinschedule1; Type: VIEW; Schema: clin_vaccination; Owner: -
--

CREATE VIEW vwvaccinesinschedule1 AS
    SELECT lu_vaccines_in_schedule.pk AS pk_view, lu_vaccines_in_schedule.fk_schedule, lu_vaccines_in_schedule.fk_vaccine, lu_vaccines_in_schedule.atsi_only AS vaccine_atsi_only, lu_vaccines_in_schedule.date_inactive AS date_vaccine_in_schedule_inactive, lu_schedules.age_due_from_months, lu_schedules.age_due_to_months, lu_schedules.schedule, lu_schedules.female_only AS schedule_female_only, lu_schedules.atsi_only AS schedule_atsi_only, lu_schedules.fk_season, lu_schedules.inactive AS schedule_inactive, lu_schedules.date_inactive AS date_schedule_inactive, lu_schedules.deleted AS schedule_deleted, lu_schedules.multiple_vaccines, lu_schedules.notes, lu_vaccines.brand, lu_vaccines.form, lu_vaccines.fk_description, lu_vaccines.fk_route, lu_vaccines.inactive AS vaccine_inactive, lu_seasons.season, lu_descriptions.description AS vaccine_description FROM ((((lu_vaccines_in_schedule JOIN lu_schedules ON ((lu_vaccines_in_schedule.fk_schedule = lu_schedules.pk))) JOIN lu_vaccines ON ((lu_vaccines_in_schedule.fk_vaccine = lu_vaccines.pk))) LEFT JOIN common.lu_seasons ON ((lu_schedules.fk_season = lu_seasons.pk))) JOIN lu_descriptions ON ((lu_vaccines.fk_description = lu_descriptions.pk))) ORDER BY lu_vaccines_in_schedule.fk_schedule, lu_vaccines.brand;


--
-- TOC entry 3628 (class 2604 OID 287308)
-- Dependencies: 3033 3032
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE last_batch_number ALTER COLUMN pk SET DEFAULT nextval('last_batch_number_pk_seq'::regclass);


--
-- TOC entry 3630 (class 2604 OID 287309)
-- Dependencies: 3041 3034
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE lu_descriptions ALTER COLUMN pk SET DEFAULT nextval('lu_vaccines_descriptions_pk_seq'::regclass);


--
-- TOC entry 3627 (class 2604 OID 287310)
-- Dependencies: 3031 3030
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE lu_indication ALTER COLUMN pk SET DEFAULT nextval('indication_pk_seq'::regclass);


--
-- TOC entry 3636 (class 2604 OID 287311)
-- Dependencies: 3037 3036
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE lu_schedules ALTER COLUMN pk SET DEFAULT nextval('lu_schedules_pk_seq'::regclass);


--
-- TOC entry 3637 (class 2604 OID 287312)
-- Dependencies: 3039 3038
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE lu_target ALTER COLUMN pk SET DEFAULT nextval('lu_target_pk_seq'::regclass);


--
-- TOC entry 3639 (class 2604 OID 287313)
-- Dependencies: 3044 3040
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE lu_vaccines ALTER COLUMN pk SET DEFAULT nextval('lu_vaccines_pk_seq'::regclass);


--
-- TOC entry 3641 (class 2604 OID 287314)
-- Dependencies: 3043 3042
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE lu_vaccines_in_schedule ALTER COLUMN pk SET DEFAULT nextval('lu_vaccines_in_schedule_pk_seq'::regclass);


--
-- TOC entry 3626 (class 2604 OID 287315)
-- Dependencies: 3029 3028
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE vaccinations ALTER COLUMN pk SET DEFAULT nextval('data_pk_seq'::regclass);


--
-- TOC entry 3662 (class 0 OID 286288)
-- Dependencies: 3032
-- Data for Name: last_batch_number; Type: TABLE DATA; Schema: clin_vaccination; Owner: -
--

COPY last_batch_number (pk, fk_vaccine, batch_number) FROM stdin;
1  36  TyphimV!-last
\.


--
-- TOC entry 3663 (class 0 OID 286296)
-- Dependencies: 3034
-- Data for Name: lu_descriptions; Type: TABLE DATA; Schema: clin_vaccination; Owner: -
--

COPY lu_descriptions (pk, description, deleted) FROM stdin;
1  Hepatitis B vaccine,Haemophilus B conjugate vaccine  f
2  Influenza virus vaccine  f
3  Measles vaccine, live,Mumps vaccine, live,Rubella vaccine, live  f
4  Varicella zoster vaccine, live attenuated  f
5  Tetanus toxoid,Pertussis vaccine,Diphtheria toxoid  f
6  Tetanus toxoid,Diphtheria toxoid  f
7  Hepatitis B vaccine,Hepatitis A vaccine  f
8  Ditheria,Tetanus,Pertussis,Hib, Hepatitis B, Polio  f
9  Yellow fever vaccine  f
10  Salmonella typhi vaccine  f
11  Diphtheria toxoid  f
12  Influenza Vaccine  f
13  Human Papilloma Virus Vaccine  f
14  Hepatitis A vaccine  f
15  Yersinia pestis vaccine  f
16  BCG vaccine  f
17  Pertussis vaccine,Hepatitis B vaccine,Tetanus toxoid,Diphtheria toxoid  f
18  Neisseria meningitidis vaccine  f
19  Coxiella burnetii vaccine  f
20  Japanese encephalitis virus vaccine  f
21  Hepatitis B vaccine  f
22  Rubella vaccine  f
23  Vibrio cholerae vaccine, oral  f
24  Poliomyelitis vaccine, oral  f
25  Vibrio cholerae vaccine  f
26  salmonella typhi vaccine,Hepatitis A vaccine  f
27  Yellow fever Vaccine  f
28  Rota Virus Vaccine  f
29  Poliomyelitis vaccine  f
30  Tetanus toxoid  f
31  Cholera vaccine  f
32  Hepatitis A vaccine,Hepatitis B vaccine  f
33  Tetanus toxoid,Diphtheria toxoid,Pertussis vaccine  f
34  Rabies vaccine  f
35  Measles vaccine, live,Rubella vaccine, live,Mumps vaccine, live  f
36  Salmonella typhi vaccine, oral  f
37  Pertussis vaccine,Tetanus toxoid,Diphtheria toxoid  f
38  Diptheria,Tetanus,Pertussis,Polio  f
39  Diphtheria toxoid,Tetanus toxoid  f
40  Haemophilus B conjugate vaccine  f
41  Pneumococcal vaccine  f
\.


--
-- TOC entry 3661 (class 0 OID 286280)
-- Dependencies: 3030
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
-- TOC entry 3664 (class 0 OID 286305)
-- Dependencies: 3036
-- Data for Name: lu_schedules; Type: TABLE DATA; Schema: clin_vaccination; Owner: -
--

COPY lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) FROM stdin;
2  2  \N  2 month childhood (Prior 1/5/2000)  f  f  \N  t  \N  f  f  \N
3  4  \N  4 month  childhood (Prior 1/5/2000)  f  f  \N  t  \N  f  f  \N
4  6  \N  6 month  childhood (Prior 1/5/2000)  f  f  \N  t  \N  f  f  \N
5  12  \N  12 month  childhood (Prior 1/5/2000)  f  f  \N  t  \N  f  f  \N
6  18  \N  18 month  childhood (Prior 1/5/2000)  f  f  \N  t  \N  f  f  \N
7  4  5  Prior to school  (4-5yrs) (Prior 1/5/2000)  f  f  \N  t  \N  f  f  \N
8  10  16  Hepatitis B - school 10-16 years (Prior 1/5/2000)  f  f  \N  t  \N  f  f  \N
9  15  19  ADT + Polio -  15-19 years  f  f  \N  t  \N  f  f  \N
33  2  \N  2 month childhood (After 1/5/2000)  f  f  \N  t  \N  f  f  \N
34  4  \N  4 month childhood (After 1/5/2000)  f  f  \N  t  \N  f  f  \N
35  6  \N  6 month childhood (After 1/5/2000)  f  f  \N  t  \N  f  f  \N
36  12  \N  12 month childhood (After 1/5/2000)  f  f  \N  t  \N  f  f  \N
37  18  \N  18 month childhood (After 1/5/2000)  f  f  \N  t  \N  f  f  \N
38  45  5  Prior to school (4-5yrs) (After 1/5/2000)  f  f  \N  t  \N  f  f  \N
39  \N  144  Chicken Pox age < 12 years  f  f  \N  t  \N  f  f  \N
41  \N  \N  Pertussis  f  f  \N  t  \N  f  f  \N
42  2  2  2 month childhood (From 1/11/2005)  f  f  \N  t  \N  f  f  \N
43  4  4  4 month childhood (From 1/11/2005)  f  f  \N  t  \N  f  f  \N
49  216  312  Human Papilloma Virus (18-26yrs)  f  f  \N  t  \N  f  f  \N
16  \N  \N  Tuberculosis  f  f  \N  t  \N  f  f  \N
17  \N  \N  Q-Fever  f  f  \N  t  \N  f  f  \N
20  \N  \N  Meningococcal  f  f  \N  t  \N  f  f  \N
21  \N  \N  Poliomyelitis  f  f  \N  t  \N  f  f  \N
27  \N  \N  Mumps  f  f  \N  t  \N  f  f  \N
30  \N  \N  Hepatitis B  f  f  \N  t  \N  f  f  \N
31  \N  \N  Japanese Encephalitis  f  f  \N  t  \N  f  f  \N
24  \N  \N  Cholera  f  f  \N  f  \N  f  f  \N
19  \N  \N  Diptheria  f  f  \N  f  \N  f  f  \N
14  \N  \N  Influenza  f  f  3  f  \N  f  f  \N
18  \N  \N  Hepatitis A  f  f  \N  f  \N  f  f  \N
32  \N  \N  Hepatitis A + Hepatitis B  f  f  \N  f  \N  f  f  \N
28  \N  \N  Measles  f  f  \N  f  \N  f  f  \N
13  \N  \N  Pneumoccal  f  f  \N  f  \N  f  f  \N
22  \N  \N  Rabies  f  f  \N  f  \N  f  f  \N
26  \N  \N  Plague  f  f  \N  f  \N  f  f  \N
29  \N  \N  Rubella  f  f  \N  f  \N  f  f  \N
25  \N  \N  Yellow Fever  f  f  \N  f  \N  f  f  \N
48  \N  \N  Typhoid + Hepatitis A  f  f  \N  f  \N  f  f  \N
23  \N  \N  Typhoid  f  f  \N  f  \N  f  f  \N
15  \N  \N  Tetanus - every 10 years  f  f  \N  f  \N  f  f  \N
40  \N  \N  Chicken Pox age > 12 years  f  f  \N  f  \N  f  f  \N
46  18  \N  18 month childhood  f  f  \N  f  \N  f  f  \N
50  2  \N  2 month childhood  f  f  \N  f  \N  f  t  \N
51  4  \N  4 month childhood  f  f  \N  f  \N  f  t  \N
44  6  6  6 month childhood  f  f  \N  f  \N  f  t  \N
45  12  \N  12 month childhood  f  f  \N  f  \N  f  t  \N
47  46  60  4 year childhood  f  f  \N  f  \N  f  t  \N
54  11  12  Aboriginal Winter Schedule  f  t  3  f  \N  f  t  \N
57  50  \N  50yrs & Over ATSI (Influenza)  f  t  \N  f  \N  f  f  \N
58  50  \N  50yrs & Over (ATSI) Pneumococcal  f  t  \N  f  \N  f  f  \N
59  12  \N  12 yrs (School Based)  f  f  \N  f  \N  f  f  School based program only
60  15  \N  15 Yrs (School program)  f  f  \N  f  \N  f  f  School based program
\.


--
-- TOC entry 3665 (class 0 OID 286318)
-- Dependencies: 3038
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
-- TOC entry 3666 (class 0 OID 286326)
-- Dependencies: 3040
-- Data for Name: lu_vaccines; Type: TABLE DATA; Schema: clin_vaccination; Owner: -
--

COPY lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) FROM stdin;
177  Varivax II  Injection  4  \N  f
178  Meningitec  injection  18  \N  f
179  Neis-vac C  injection  18  \N  f
180  Menjugate  injection  18  \N  f
181  Infranrix hexa  injection  8  \N  f
182  Infranrix-IPV  injection  38  \N  f
183  Vivaxim  injection  26  \N  f
185  Gardasil  injection  13  \N  f
186  Rotarix  oral  28  \N  f
187  Influvac  injection  12  \N  f
189  Boostrix IPV  injection  38  \N  f
1  BCG Vaccine  Injection  16  \N  f
17  Havrix prefilled syringe  Injection  14  \N  f
18  Twinrix Junior Formulation  Injection  32  \N  f
19  Twinrix Adult Formulation  Injection  7  \N  f
20  H-B-Vax II Paediatric Formulation  Injection  21  \N  f
21  H-B-Vax II Dialysis Formulation  Injection  21  \N  f
22  H-B-Vax II Adult Formulation  Injection  21  \N  f
23  Engerix-B Adult Formulation  Injection  21  \N  f
24  Engerix-B Paediatric Formulation  Injection  21  \N  f
25  Fluvax  Injection  2  \N  f
26  Vaxigrip  Injection  2  \N  f
27  M-M-R II  Injection  3  \N  f
28  Mencevax ACWY  Injection  18  \N  f
29  Menomune  Injection  18  \N  f
30  Pneumovax 23  Injection  41  \N  f
31  Ipol  Injection  29  \N  f
32  Polio Sabin (Oral)  Drop  24  \N  f
33  Merieux Inactivated Rabies Vaccine  Injection  34  \N  f
34  Meruvax II  Injection  22  \N  f
35  Ervevax  Injection  22  \N  f
36  Typh-Vax (Oral)  Capsules  36  \N  f
37  Typhim Vi  Injection  10  \N  f
38  Typhoid Vaccine  injection  10  \N  f
39  Tet-Tox  Injection  30  \N  f
40  Cholera Vaccine  Injection  31  \N  f
41  Yellow Fever Vaccine  injection  9  \N  f
42  Plague Vaccine  Injection  15  \N  f
52  Fluarix  Injection  2  \N  f
64  Je-Vax  Injection  20  \N  f
163  Prevenar  Injection  41  \N  f
75  Stamaril  Injection  9  \N  f
76  Brand Unknown  Injection  27  \N  f
88  Fluvirin  Injection  2  \N  f
98  Infanrix Hep B  Injection  17  \N  f
101  Liquid PedvaxHIB  Injection  40  \N  f
111  Priorix  Injection  35  \N  f
120  Typherix  Injection  10  \N  f
124  Varilrix  Injection  4  \N  f
126  Avaxim Inactivated Hepatitis A Vaccine  Injection  14  \N  f
128  Boostrix  Injection  37  \N  f
131  Comvax  Injection  1  \N  f
134  Engerix-B Adult Formulation Injection  Injection  21  \N  f
135  Engerix-B Paediatric Formulation Injection  Injection  21  \N  f
140  H-B-Vax II Adult Formulation Injection  Injection  21  \N  f
141  H-B-Vax II Dialysis Formulation Injection  Injection  21  \N  f
142  H-B-Vax II Paediatric Formulation Injection  Injection  21  \N  f
143  H-B-Vax II Paediatric Formulation Injection Preservative free  Injection  21  \N  f
144  Havrix Junior prefilled syringe Injection  Injection  14  \N  f
145  Havrix monodose vial Injection  Injection  14  \N  f
146  Havrix prefilled syringe Injection  Injection  14  \N  f
159  Orochol  Powder  23  \N  f
190  PanVax  Adult (Swine Flu)  injection  12  \N  f
169  Twinrix Adult Formulation Injection  Injection  32  \N  f
170  Twinrix Junior Formulation Injection  Injection  7  \N  f
174  VAQTA Adult Formulation Injection  Injection  14  \N  f
175  VAQTA Paediatric/adolescent Formulation Injection  Injection  14  \N  f
184  Dukoral  oral  25  \N  f
2  Q-Vax  Injection  19  \N  f
3  Diphtheria Vaccine, Adsorbed (Diluted for Adult Use)  Injection  11  \N  f
4  Diphtheria Vaccine, Adsorbed  Injection  11  \N  f
5  Triple Antigen (Diphtheria, Tetanus, Pertussis - Adsorbed)  Injection  33  \N  f
6  Infanrix  Injection  5  \N  f
7  Tripacel  Injection  33  \N  f
8  CDT Vaccine  Injection  39  \N  f
9  ADT Vaccine  Injection  6  \N  f
10  HibTITER  Injection  40  \N  f
11  Hiberix  Injection  40  \N  f
12  PedvaxHIB  Injection  40  \N  f
13  VAQTA Adult Formulation  Injection  14  \N  f
14  Havrix monodose vial  Injection  14  \N  f
15  VAQTA Paediatric/adolescent Formulation  Injection  14  \N  f
16  Havrix Junior prefilled syringe  Injection  14  \N  f
191  Adacel  injection  37  \N  f
192  PanVax Junior (Swine Flu) <3yrs  injection  12  \N  f
193  Intanza  injection  12  \N  f
\.


--
-- TOC entry 3667 (class 0 OID 286335)
-- Dependencies: 3042
-- Data for Name: lu_vaccines_in_schedule; Type: TABLE DATA; Schema: clin_vaccination; Owner: -
--

COPY lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) FROM stdin;
1  12  35  f  \N
2  32  35  f  \N
3  111  36  f  \N
4  27  36  f  \N
5  101  36  f  \N
6  6  37  f  \N
7  6  38  f  \N
8  111  38  f  \N
9  32  38  f  \N
10  111  5  f  \N
11  111  7  f  \N
12  20  30  f  \N
13  18  8  f  \N
14  19  8  f  \N
15  163  13  f  \N
16  126  18  f  \N
17  88  14  f  \N
18  159  24  f  \N
19  76  25  f  \N
20  111  27  f  \N
21  111  28  f  \N
22  111  29  f  \N
23  101  33  f  \N
24  101  34  f  \N
25  179  20  f  \N
26  180  20  f  \N
27  128  41  f  \N
28  163  42  f  \N
29  163  43  f  \N
30  163  44  f  \N
31  181  42  f  \N
32  181  43  f  \N
33  181  44  f  \N
34  111  45  f  \N
35  11  45  f  \N
37  163  45  f  \N
38  124  46  f  \N
39  182  47  f  \N
40  111  47  f  \N
41  30  47  f  \N
42  183  48  f  \N
43  184  24  f  \N
44  185  49  f  \N
45  181  50  f  \N
46  163  50  f  \N
47  163  51  f  \N
48  181  51  f  \N
49  186  50  f  \N
50  186  51  f  \N
51  187  14  f  \N
52  189  15  f  \N
53  128  15  f  \N
54  124  39  f  \N
55  124  40  f  \N
56  120  23  f  \N
57  177  39  f  \N
58  177  40  f  \N
59  178  20  f  \N
60  20  1  f  \N
61  24  1  f  \N
62  6  2  f  \N
63  7  2  f  \N
64  5  2  f  \N
65  10  2  f  \N
66  11  2  f  \N
67  12  2  f  \N
68  32  2  f  \N
69  5  3  f  \N
70  6  3  f  \N
71  7  3  f  \N
72  10  3  f  \N
73  11  3  f  \N
74  12  3  f  \N
75  5  4  f  \N
76  6  4  f  \N
77  7  4  f  \N
78  10  4  f  \N
79  11  4  f  \N
80  27  5  f  \N
81  12  5  f  \N
82  5  6  f  \N
83  6  6  f  \N
84  7  6  f  \N
85  10  6  f  \N
86  11  6  f  \N
87  32  3  f  \N
88  32  4  f  \N
89  9  15  f  \N
90  39  15  f  \N
91  1  16  f  \N
92  2  17  f  \N
93  13  18  f  \N
94  14  18  f  \N
95  15  18  f  \N
96  16  18  f  \N
97  17  18  f  \N
98  19  32  f  \N
99  3  19  f  \N
100  4  19  f  \N
101  28  20  f  \N
102  29  20  f  \N
103  31  21  f  \N
104  32  21  f  \N
105  33  22  f  \N
106  36  23  f  \N
107  37  23  f  \N
108  38  23  f  \N
109  40  24  f  \N
110  41  25  f  \N
111  42  26  f  \N
112  27  27  f  \N
113  27  28  f  \N
114  27  29  f  \N
115  34  29  f  \N
116  25  14  f  \N
117  26  14  f  \N
118  30  13  f  \N
119  30  11  f  \N
120  25  12  f  \N
121  26  12  f  \N
122  34  10  f  \N
123  35  10  f  \N
124  31  9  f  \N
125  32  9  f  \N
126  5  7  f  \N
127  6  7  f  \N
128  7  7  f  \N
129  31  7  f  \N
130  32  7  f  \N
131  9  9  f  \N
132  27  7  f  \N
133  21  30  f  \N
134  22  30  f  \N
135  23  30  f  \N
136  24  30  f  \N
137  35  29  f  \N
138  52  12  f  \N
139  52  14  f  \N
140  75  25  f  \N
141  64  31  f  \N
142  18  32  f  \N
143  20  8  f  \N
144  21  8  f  \N
145  22  8  f  \N
146  23  8  f  \N
147  24  8  f  \N
148  98  33  f  \N
149  12  33  f  \N
150  32  33  f  \N
151  98  34  f  \N
152  12  34  f  \N
153  32  34  f  \N
154  98  35  f  \N
155  190  14  f  \N
156  191  41  f  \N
157  191  19  f  \N
158  192  14  f  \N
159  191  15  f  \N
160  193  14  f  \N
161  187  54  t  \N
162  192  54  t  \N
163  30  54  t  2010-11-14
164  30  57  t  2010-11-14
36  178  45  f  \N
165  187  57  t  \N
166  30  58  t  \N
167  20  59  f  \N
168  124  59  f  \N
169  185  59  f  \N
170  128  60  f  \N
\.


--
-- TOC entry 3660 (class 0 OID 286270)
-- Dependencies: 3028
-- Data for Name: vaccinations; Type: TABLE DATA; Schema: clin_vaccination; Owner: -
--

COPY vaccinations (pk, fk_consult, fk_vaccine, fk_schedule, fk_site, fk_laterality, fk_route, date_given, serial_no) FROM stdin;
1  4361  36  23  2  1  1  20/11/2010  TyphimV!-last
\.


--
-- TOC entry 3643 (class 2606 OID 288516)
-- Dependencies: 3028 3028
-- Name: data_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY vaccinations
    ADD CONSTRAINT data_pkey PRIMARY KEY (pk);


--
-- TOC entry 3645 (class 2606 OID 288518)
-- Dependencies: 3030 3030
-- Name: indication_key; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_indication
    ADD CONSTRAINT indication_key UNIQUE (medical_name);


--
-- TOC entry 3649 (class 2606 OID 288520)
-- Dependencies: 3032 3032
-- Name: last_batch_number_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY last_batch_number
    ADD CONSTRAINT last_batch_number_pkey PRIMARY KEY (pk);


--
-- TOC entry 3647 (class 2606 OID 288522)
-- Dependencies: 3030 3030
-- Name: lu_indication_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_indication
    ADD CONSTRAINT lu_indication_pkey PRIMARY KEY (pk);


--
-- TOC entry 3653 (class 2606 OID 288524)
-- Dependencies: 3036 3036
-- Name: lu_schedules_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_schedules
    ADD CONSTRAINT lu_schedules_pkey PRIMARY KEY (pk);


--
-- TOC entry 3655 (class 2606 OID 288526)
-- Dependencies: 3038 3038
-- Name: lu_target_pkey1; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_target
    ADD CONSTRAINT lu_target_pkey1 PRIMARY KEY (pk);


--
-- TOC entry 3651 (class 2606 OID 288528)
-- Dependencies: 3034 3034
-- Name: lu_vaccines_descriptions_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_descriptions
    ADD CONSTRAINT lu_vaccines_descriptions_pkey PRIMARY KEY (pk);


--
-- TOC entry 3659 (class 2606 OID 288530)
-- Dependencies: 3042 3042
-- Name: lu_vaccines_in_schedule_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_vaccines_in_schedule
    ADD CONSTRAINT lu_vaccines_in_schedule_pkey PRIMARY KEY (pk);


--
-- TOC entry 3657 (class 2606 OID 288532)
-- Dependencies: 3040 3040
-- Name: lu_vaccines_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_vaccines
    ADD CONSTRAINT lu_vaccines_pkey PRIMARY KEY (pk);


--
-- TOC entry 3671 (class 0 OID 0)
-- Dependencies: 33
-- Name: clin_vaccination; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA clin_vaccination FROM PUBLIC;
REVOKE ALL ON SCHEMA clin_vaccination FROM richard;
GRANT ALL ON SCHEMA clin_vaccination TO richard;
GRANT ALL ON SCHEMA clin_vaccination TO easygp;
GRANT USAGE ON SCHEMA clin_vaccination TO staff;


--
-- TOC entry 3673 (class 0 OID 0)
-- Dependencies: 3028
-- Name: vaccinations; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE vaccinations FROM PUBLIC;
REVOKE ALL ON TABLE vaccinations FROM richard;
GRANT ALL ON TABLE vaccinations TO richard;
GRANT ALL ON TABLE vaccinations TO easygp;
GRANT ALL ON TABLE vaccinations TO staff;


--
-- TOC entry 3676 (class 0 OID 0)
-- Dependencies: 3029
-- Name: data_pk_seq; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON SEQUENCE data_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE data_pk_seq FROM richard;
GRANT ALL ON SEQUENCE data_pk_seq TO richard;
GRANT ALL ON SEQUENCE data_pk_seq TO easygp;
GRANT USAGE ON SEQUENCE data_pk_seq TO staff;


--
-- TOC entry 3678 (class 0 OID 0)
-- Dependencies: 3030
-- Name: lu_indication; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE lu_indication FROM PUBLIC;
REVOKE ALL ON TABLE lu_indication FROM richard;
GRANT ALL ON TABLE lu_indication TO richard;
GRANT ALL ON TABLE lu_indication TO easygp;
GRANT SELECT ON TABLE lu_indication TO staff;


--
-- TOC entry 3681 (class 0 OID 0)
-- Dependencies: 3031
-- Name: indication_pk_seq; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON SEQUENCE indication_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE indication_pk_seq FROM richard;
GRANT ALL ON SEQUENCE indication_pk_seq TO richard;
GRANT ALL ON SEQUENCE indication_pk_seq TO easygp;
GRANT USAGE ON SEQUENCE indication_pk_seq TO staff;


--
-- TOC entry 3683 (class 0 OID 0)
-- Dependencies: 3032
-- Name: last_batch_number; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE last_batch_number FROM PUBLIC;
REVOKE ALL ON TABLE last_batch_number FROM richard;
GRANT ALL ON TABLE last_batch_number TO richard;
GRANT ALL ON TABLE last_batch_number TO easygp;
GRANT ALL ON TABLE last_batch_number TO staff;


--
-- TOC entry 3686 (class 0 OID 0)
-- Dependencies: 3033
-- Name: last_batch_number_pk_seq; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON SEQUENCE last_batch_number_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE last_batch_number_pk_seq FROM richard;
GRANT ALL ON SEQUENCE last_batch_number_pk_seq TO richard;
GRANT ALL ON SEQUENCE last_batch_number_pk_seq TO easygp;
GRANT USAGE ON SEQUENCE last_batch_number_pk_seq TO staff;


--
-- TOC entry 3688 (class 0 OID 0)
-- Dependencies: 3034
-- Name: lu_descriptions; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE lu_descriptions FROM PUBLIC;
REVOKE ALL ON TABLE lu_descriptions FROM richard;
GRANT ALL ON TABLE lu_descriptions TO richard;
GRANT ALL ON TABLE lu_descriptions TO easygp;
GRANT ALL ON TABLE lu_descriptions TO staff;


--
-- TOC entry 3691 (class 0 OID 0)
-- Dependencies: 3035
-- Name: lu_indication_pk_seq; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON SEQUENCE lu_indication_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_indication_pk_seq FROM richard;
GRANT ALL ON SEQUENCE lu_indication_pk_seq TO richard;
GRANT ALL ON SEQUENCE lu_indication_pk_seq TO easygp;
GRANT USAGE ON SEQUENCE lu_indication_pk_seq TO staff;


--
-- TOC entry 3698 (class 0 OID 0)
-- Dependencies: 3036
-- Name: lu_schedules; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE lu_schedules FROM PUBLIC;
REVOKE ALL ON TABLE lu_schedules FROM richard;
GRANT ALL ON TABLE lu_schedules TO richard;
GRANT ALL ON TABLE lu_schedules TO easygp;
GRANT SELECT ON TABLE lu_schedules TO staff;


--
-- TOC entry 3701 (class 0 OID 0)
-- Dependencies: 3037
-- Name: lu_schedules_pk_seq; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON SEQUENCE lu_schedules_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_schedules_pk_seq FROM richard;
GRANT ALL ON SEQUENCE lu_schedules_pk_seq TO richard;
GRANT ALL ON SEQUENCE lu_schedules_pk_seq TO easygp;
GRANT USAGE ON SEQUENCE lu_schedules_pk_seq TO staff;


--
-- TOC entry 3702 (class 0 OID 0)
-- Dependencies: 3038
-- Name: lu_target; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE lu_target FROM PUBLIC;
REVOKE ALL ON TABLE lu_target FROM richard;
GRANT ALL ON TABLE lu_target TO richard;
GRANT ALL ON TABLE lu_target TO easygp;
GRANT SELECT ON TABLE lu_target TO staff;


--
-- TOC entry 3705 (class 0 OID 0)
-- Dependencies: 3039
-- Name: lu_target_pk_seq; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON SEQUENCE lu_target_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_target_pk_seq FROM richard;
GRANT ALL ON SEQUENCE lu_target_pk_seq TO richard;
GRANT ALL ON SEQUENCE lu_target_pk_seq TO easygp;
GRANT USAGE ON SEQUENCE lu_target_pk_seq TO staff;


--
-- TOC entry 3707 (class 0 OID 0)
-- Dependencies: 3040
-- Name: lu_vaccines; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE lu_vaccines FROM PUBLIC;
REVOKE ALL ON TABLE lu_vaccines FROM richard;
GRANT ALL ON TABLE lu_vaccines TO richard;
GRANT ALL ON TABLE lu_vaccines TO easygp;
GRANT ALL ON TABLE lu_vaccines TO staff;


--
-- TOC entry 3710 (class 0 OID 0)
-- Dependencies: 3042
-- Name: lu_vaccines_in_schedule; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE lu_vaccines_in_schedule FROM PUBLIC;
REVOKE ALL ON TABLE lu_vaccines_in_schedule FROM richard;
GRANT ALL ON TABLE lu_vaccines_in_schedule TO richard;
GRANT ALL ON TABLE lu_vaccines_in_schedule TO easygp;
GRANT ALL ON TABLE lu_vaccines_in_schedule TO staff;


--
-- TOC entry 3715 (class 0 OID 0)
-- Dependencies: 3266
-- Name: vwvaccines; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE vwvaccines FROM PUBLIC;
REVOKE ALL ON TABLE vwvaccines FROM easygp;
GRANT ALL ON TABLE vwvaccines TO easygp;
GRANT ALL ON TABLE vwvaccines TO staff;


--
-- TOC entry 3716 (class 0 OID 0)
-- Dependencies: 3269
-- Name: vwvaccinesgiven; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE vwvaccinesgiven FROM PUBLIC;
REVOKE ALL ON TABLE vwvaccinesgiven FROM easygp;
GRANT ALL ON TABLE vwvaccinesgiven TO easygp;
GRANT ALL ON TABLE vwvaccinesgiven TO staff;


--
-- TOC entry 3717 (class 0 OID 0)
-- Dependencies: 3267
-- Name: vwvaccinesinschedule; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE vwvaccinesinschedule FROM PUBLIC;
REVOKE ALL ON TABLE vwvaccinesinschedule FROM easygp;
GRANT ALL ON TABLE vwvaccinesinschedule TO easygp;
GRANT ALL ON TABLE vwvaccinesinschedule TO staff;


--
-- TOC entry 3718 (class 0 OID 0)
-- Dependencies: 3268
-- Name: vwvaccinesinschedule1; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE vwvaccinesinschedule1 FROM PUBLIC;
REVOKE ALL ON TABLE vwvaccinesinschedule1 FROM easygp;
GRANT ALL ON TABLE vwvaccinesinschedule1 TO easygp;
GRANT ALL ON TABLE vwvaccinesinschedule1 TO staff;


-- Completed on 2010-11-20 11:03:12 EST

--
-- PostgreSQL database dump complete
--

