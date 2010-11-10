ALTER TABLE clin_vaccination.lu_schedules DROP COLUMN date_inactive;
ALTER TABLE clin_vaccination.lu_schedules DROP COLUMN inactive;
ALTER TABLE clin_vaccination.lu_schedules rename COLUMN schedule_text to schedule;
.. then import the data, then put this back in.

ALTER TABLE clin_vaccination.lu_schedules add column inactive boolean default true;
ALTER TABLE clin_vaccination.lu_schedules add column date_inactive date default null;



CREATE TABLE clin_vaccination.lu_vaccines
(
  pk serial primary key,
  brand text,
  fk_description text,
  fk_route integer,
  form text,
  inserted date,
  deleted date);


ALTER TABLE clin_vaccination.lu_vaccines OWNER TO easygp;
GRANT ALL ON TABLE clin_vaccination.lu_vaccines TO easygp;
GRANT ALL ON TABLE clin_vaccination.lu_vaccines TO staff;
COMMENT ON TABLE clin_vaccination.lu_vaccines IS 'the master vaccine table containing links to trade name links table, target disease';

CREATE TABLE clin_vaccination.lu_vaccines_descriptions
(
  pk serial primary key,
  description text,
  deleted  boolean default false
);


update clin_vaccination.lu_vaccines 

set fk_description = (Select pk from clin_vaccination.lu_vaccines_descriptions where
clin_vaccination.lu_vaccines_descriptions.description = clin_vaccination.lu_vaccines.description);

ALTER TABLE clin_vaccination.lu_vaccines_descriptions OWNER TO easygp;
GRANT ALL ON TABLE clin_vaccination.lu_vaccines_descriptions TO easygp;
GRANT all ON TABLE clin_vaccination.lu_vaccines_descriptions TO staff;
COMMENT ON TABLE clin_vaccination.lu_vaccines_descriptions IS 'create the vaccines_descriptions table contains names describing what the brand names are eg tetanus, diptheria, or combinations thereof ';

CREATE TABLE clin_vaccination.lu_vaccines_in_schedule
(
  pk serial primary key,
  fk_vaccine integer,
  fk_schedule integer);

  
ALTER TABLE clin_vaccination.lu_vaccines_in_schedule OWNER TO easygp;
GRANT ALL ON TABLE clin_vaccination.lu_vaccines_in_schedule TO staff;
GRANT ALL ON TABLE clin_vaccination.lu_vaccines_in_schedule TO easygp;


create table clin_vaccination.lu_vaccine_formulation
(pk serial primary key,
 formulation text not null)

 ;
 Drop table clin_vaccination.lu_vaccine_formulation;

CREATE TABLE clin_vaccination.lu_vaccine_formulation
(
  pk serial NOT NULL,
  form text NOT NULL,
  CONSTRAINT lu_vaccine_formulation_pkey PRIMARY KEY (pk)
)
WITH (
  OIDS=FALSE
);
INSERT INTO clin_vaccination.lu_vaccine_formulation (form)
SELECT distinct clin_vaccination.lu_vaccines.form  FROM "clin_vaccination"."lu_vaccines";

insert into clin_vaccination.lu_vaccines_descriptions(description)
Select distinct description from clin_vaccination.lu_vaccines;

 insert into clin_vaccination.lu_vaccine_formulation (formulation) values ('injection');
 insert into clin_vaccination.lu_vaccine_formulation (formulation) values ('capsules');
 insert into clin_vaccination.lu_vaccine_formulation (formulation) values ('oral liquid');
 insert into clin_vaccination.lu_vaccine_formulation (formulation) values ('powder');
 
 
CREATE OR REPLACE VIEW clin_vaccination.vwvaccines AS 
 SELECT lu_vaccines.pk, lu_vaccines.brand, lu_vaccines.form, lu_vaccines.fk_description, lu_descriptions.description, lu_descriptions.deleted
   FROM clin_vaccination.lu_vaccines
   JOIN clin_vaccination.lu_descriptions ON lu_vaccines.fk_description = lu_descriptions.pk
   order by description;

ALTER TABLE clin_vaccination.vwvaccines OWNER TO easygp;
GRANT ALL ON TABLE clin_vaccination.vwvaccines TO staff;
GRANT ALL ON TABLE clin_vaccination.vwvaccines TO easygp;






alter table clin_vaccination.lu_vaccines add column fk_route integer;



Create or replace view clin_vaccination.vwVaccinesInSchedule as 
SELECT 
   clin_vaccination.lu_schedules.pk || '-'::text || clin_vaccination.lu_vaccines.pk as pk_view,
  clin_vaccination.lu_schedules.age_due_from_months,
  clin_vaccination.lu_schedules.age_due_to_months,
  clin_vaccination.lu_schedules.schedule,
  clin_vaccination.lu_schedules.female_only,
  clin_vaccination.lu_schedules.aboriginal_tsi_only,
  clin_vaccination.lu_schedules.fk_season,
  clin_vaccination.lu_schedules.inactive,
  clin_vaccination.lu_schedules.date_inactive,
  clin_vaccination.lu_vaccines_in_schedule.fk_schedule,
  clin_vaccination.lu_vaccines.brand,
  clin_vaccination.lu_vaccines.fk_route,
  clin_vaccination.lu_vaccines.form,
  clin_vaccination.lu_vaccines.fk_description,
  clin_vaccination.lu_vaccines_in_schedule.fk_vaccine,
  clin_vaccination.lu_descriptions.description,
  clin_vaccination.lu_descriptions.deleted AS description_deleted
FROM
  clin_vaccination.lu_schedules
  INNER JOIN clin_vaccination.lu_vaccines_in_schedule ON (clin_vaccination.lu_schedules.pk = clin_vaccination.lu_vaccines_in_schedule.fk_schedule)
  INNER JOIN clin_vaccination.lu_vaccines ON (clin_vaccination.lu_vaccines_in_schedule.fk_vaccine = clin_vaccination.lu_vaccines.pk)
  INNER JOIN clin_vaccination.lu_descriptions ON (clin_vaccination.lu_vaccines.fk_description = clin_vaccination.lu_descriptions.pk)
  order by schedule, brand;
  
  
 ALTER TABLE clin_vaccination.vwVaccinesInSchedule OWNER TO easygp;
GRANT ALL ON TABLE clin_vaccination.vwVaccinesInSchedule TO easygp;
GRANT ALL ON TABLE clin_vaccination.vwVaccinesInSchedule TO staff;



----------------------------------
--
-- PostgreSQL database dump
--

-- Started on 2010-11-04 18:57:10 EST

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 25 (class 2615 OID 271600)
-- Name: clin_vaccination; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA clin_vaccination;


--
-- TOC entry 3651 (class 0 OID 0)
-- Dependencies: 25
-- Name: SCHEMA clin_vaccination; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA clin_vaccination IS ' Easy GP:2April2008 creates all the tables to do with vaccination ie vaccines (holds the brand names, fk_vaccine_description, form (eg injection) vaccines_descriptions eg typoid or tetanus toxoid, diptheria toxoid vaccines_last_bath_number - dr/nurse specific last batch used';


SET search_path = clin_vaccination, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 3023 (class 1259 OID 273146)
-- Dependencies: 3614 3615 25
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
-- TOC entry 3653 (class 0 OID 0)
-- Dependencies: 3023
-- Name: COLUMN vaccinations.date_given; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON COLUMN vaccinations.date_given IS 'not a date field because sometimes may need to record just say 01/2002 or 1998';


--
-- TOC entry 3024 (class 1259 OID 273154)
-- Dependencies: 3023 25
-- Name: data_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE data_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 3655 (class 0 OID 0)
-- Dependencies: 3024
-- Name: data_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE data_pk_seq OWNED BY vaccinations.pk;


--
-- TOC entry 3656 (class 0 OID 0)
-- Dependencies: 3024
-- Name: data_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: -
--

SELECT pg_catalog.setval('data_pk_seq', 1, false);


--
-- TOC entry 3025 (class 1259 OID 273156)
-- Dependencies: 25
-- Name: lu_indication; Type: TABLE; Schema: clin_vaccination; Owner: -; Tablespace: 
--

CREATE TABLE lu_indication (
    pk integer NOT NULL,
    medical_name text NOT NULL,
    common_name text
);


--
-- TOC entry 3658 (class 0 OID 0)
-- Dependencies: 3025
-- Name: TABLE lu_indication; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON TABLE lu_indication IS ' vaccine target disease lookup table  eg hepatitis B  todo this should really be a coded field not a text field';


--
-- TOC entry 3026 (class 1259 OID 273162)
-- Dependencies: 3025 25
-- Name: indication_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE indication_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 3660 (class 0 OID 0)
-- Dependencies: 3026
-- Name: indication_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE indication_pk_seq OWNED BY lu_indication.pk;


--
-- TOC entry 3661 (class 0 OID 0)
-- Dependencies: 3026
-- Name: indication_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: -
--

SELECT pg_catalog.setval('indication_pk_seq', 1, false);


--
-- TOC entry 3027 (class 1259 OID 273164)
-- Dependencies: 25
-- Name: last_batch_number; Type: TABLE; Schema: clin_vaccination; Owner: -; Tablespace: 
--

CREATE TABLE last_batch_number (
    pk integer NOT NULL,
    fk_vaccine integer,
    batch_number text NOT NULL,
    fk_provider integer
);


--
-- TOC entry 3663 (class 0 OID 0)
-- Dependencies: 3027
-- Name: TABLE last_batch_number; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON TABLE last_batch_number IS 'last used batch number to make it easier on the doctors typeing when e.g vaccines may be stored in fridges in rooms in a surgery and most doctors and nurses work out of their own rooms. todo link to doctor code table';


--
-- TOC entry 3028 (class 1259 OID 273170)
-- Dependencies: 3027 25
-- Name: last_batch_number_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE last_batch_number_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 3665 (class 0 OID 0)
-- Dependencies: 3028
-- Name: last_batch_number_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE last_batch_number_pk_seq OWNED BY last_batch_number.pk;


--
-- TOC entry 3666 (class 0 OID 0)
-- Dependencies: 3028
-- Name: last_batch_number_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: -
--

SELECT pg_catalog.setval('last_batch_number_pk_seq', 1, false);


--
-- TOC entry 3256 (class 1259 OID 275806)
-- Dependencies: 3623 25
-- Name: lu_descriptions; Type: TABLE; Schema: clin_vaccination; Owner: -; Tablespace: 
--

CREATE TABLE lu_descriptions (
    pk integer NOT NULL,
    description text,
    deleted boolean DEFAULT false
);


--
-- TOC entry 3668 (class 0 OID 0)
-- Dependencies: 3256
-- Name: TABLE lu_descriptions; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON TABLE lu_descriptions IS 'create the vaccines_descriptions table contains names describing what the brand names are eg tetanus, diptheria, or combinations thereof ';


--
-- TOC entry 3029 (class 1259 OID 273177)
-- Dependencies: 3025 25
-- Name: lu_indication_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE lu_indication_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 3670 (class 0 OID 0)
-- Dependencies: 3029
-- Name: lu_indication_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE lu_indication_pk_seq OWNED BY lu_indication.pk;


--
-- TOC entry 3671 (class 0 OID 0)
-- Dependencies: 3029
-- Name: lu_indication_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: -
--

SELECT pg_catalog.setval('lu_indication_pk_seq', 27, true);


--
-- TOC entry 3030 (class 1259 OID 273179)
-- Dependencies: 3620 25
-- Name: lu_schedules; Type: TABLE; Schema: clin_vaccination; Owner: -; Tablespace: 
--

CREATE TABLE lu_schedules (
    pk integer NOT NULL,
    age_due_from_months integer,
    age_due_to_months integer,
    schedule text NOT NULL,
    female_only boolean,
    aboriginal_tsi_only boolean,
    fk_season integer,
    inactive boolean DEFAULT true,
    date_inactive date
);


--
-- TOC entry 3673 (class 0 OID 0)
-- Dependencies: 3030
-- Name: TABLE lu_schedules; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON TABLE lu_schedules IS 'create schedulescontains the schedules eg 2 month, 4 months, 4yrs etcA vaccination schedule can be a single vaccination or a schedule of
vaccination and contain one or more vaccines. The reason for this is complex
and practical referral to the doc for further information';


--
-- TOC entry 3674 (class 0 OID 0)
-- Dependencies: 3030
-- Name: COLUMN lu_schedules.schedule; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON COLUMN lu_schedules.schedule IS 'either a target disease name eg ''yellow fever'' or a schedule name to describe course of combined vaccines eg Hepatits A + Hepatitis B.Hence this allows unlimited and user defined schedules.';


--
-- TOC entry 3675 (class 0 OID 0)
-- Dependencies: 3030
-- Name: COLUMN lu_schedules.aboriginal_tsi_only; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON COLUMN lu_schedules.aboriginal_tsi_only IS 'australian requirement, some schedules apply only to aboriginal or torres strait islanders at particular ages';


--
-- TOC entry 3676 (class 0 OID 0)
-- Dependencies: 3030
-- Name: COLUMN lu_schedules.fk_season; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON COLUMN lu_schedules.fk_season IS 'eg. influenza prompts only wanted at particular time of year';


--
-- TOC entry 3031 (class 1259 OID 273185)
-- Dependencies: 3030 25
-- Name: lu_schedules_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE lu_schedules_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 3678 (class 0 OID 0)
-- Dependencies: 3031
-- Name: lu_schedules_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE lu_schedules_pk_seq OWNED BY lu_schedules.pk;


--
-- TOC entry 3679 (class 0 OID 0)
-- Dependencies: 3031
-- Name: lu_schedules_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: -
--

SELECT pg_catalog.setval('lu_schedules_pk_seq', 1, false);


--
-- TOC entry 3032 (class 1259 OID 273187)
-- Dependencies: 25
-- Name: lu_target; Type: TABLE; Schema: clin_vaccination; Owner: -; Tablespace: 
--

CREATE TABLE lu_target (
    pk integer NOT NULL,
    target text NOT NULL
);


--
-- TOC entry 3033 (class 1259 OID 273193)
-- Dependencies: 3032 25
-- Name: lu_target_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE lu_target_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 3682 (class 0 OID 0)
-- Dependencies: 3033
-- Name: lu_target_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE lu_target_pk_seq OWNED BY lu_target.pk;


--
-- TOC entry 3683 (class 0 OID 0)
-- Dependencies: 3033
-- Name: lu_target_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: -
--

SELECT pg_catalog.setval('lu_target_pk_seq', 27, true);


--
-- TOC entry 3259 (class 1259 OID 275834)
-- Dependencies: 25
-- Name: lu_vaccines; Type: TABLE; Schema: clin_vaccination; Owner: -; Tablespace: 
--

CREATE TABLE lu_vaccines (
    pk integer NOT NULL,
    brand text,
    form text,
    fk_description integer,
    fk_route integer
);


--
-- TOC entry 3685 (class 0 OID 0)
-- Dependencies: 3259
-- Name: TABLE lu_vaccines; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON TABLE lu_vaccines IS 'the master vaccine table containing links to trade name links table, target disease';


--
-- TOC entry 3255 (class 1259 OID 275804)
-- Dependencies: 3256 25
-- Name: lu_vaccines_descriptions_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE lu_vaccines_descriptions_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 3687 (class 0 OID 0)
-- Dependencies: 3255
-- Name: lu_vaccines_descriptions_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE lu_vaccines_descriptions_pk_seq OWNED BY lu_descriptions.pk;


--
-- TOC entry 3688 (class 0 OID 0)
-- Dependencies: 3255
-- Name: lu_vaccines_descriptions_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: -
--

SELECT pg_catalog.setval('lu_vaccines_descriptions_pk_seq', 41, true);


--
-- TOC entry 3257 (class 1259 OID 275818)
-- Dependencies: 25
-- Name: lu_vaccines_in_schedule; Type: TABLE; Schema: clin_vaccination; Owner: -; Tablespace: 
--

CREATE TABLE lu_vaccines_in_schedule (
    fk_vaccine integer,
    fk_schedule integer
);


--
-- TOC entry 3258 (class 1259 OID 275832)
-- Dependencies: 3259 25
-- Name: lu_vaccines_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE lu_vaccines_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 3690 (class 0 OID 0)
-- Dependencies: 3258
-- Name: lu_vaccines_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE lu_vaccines_pk_seq OWNED BY lu_vaccines.pk;


--
-- TOC entry 3691 (class 0 OID 0)
-- Dependencies: 3258
-- Name: lu_vaccines_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: -
--

SELECT pg_catalog.setval('lu_vaccines_pk_seq', 1, false);


--
-- TOC entry 3260 (class 1259 OID 275843)
-- Dependencies: 3421 25
-- Name: vwvaccines; Type: VIEW; Schema: clin_vaccination; Owner: -
--

CREATE VIEW vwvaccines AS
    SELECT lu_vaccines.pk, lu_vaccines.brand, lu_vaccines.form, lu_vaccines.fk_description, lu_descriptions.description, lu_descriptions.deleted FROM (lu_vaccines JOIN lu_descriptions ON ((lu_vaccines.fk_description = lu_descriptions.pk))) ORDER BY lu_descriptions.description;


--
-- TOC entry 3261 (class 1259 OID 275862)
-- Dependencies: 3422 25
-- Name: vwvaccinesinschedule; Type: VIEW; Schema: clin_vaccination; Owner: -
--

CREATE VIEW vwvaccinesinschedule AS
    SELECT ((lu_schedules.pk || '-'::text) || lu_vaccines.pk) AS pk_view, lu_schedules.age_due_from_months, lu_schedules.age_due_to_months, lu_schedules.schedule, lu_schedules.female_only, lu_schedules.aboriginal_tsi_only, lu_schedules.fk_season, lu_schedules.inactive, lu_schedules.date_inactive, lu_vaccines_in_schedule.fk_schedule, lu_vaccines.brand, lu_vaccines.fk_route, lu_vaccines.form, lu_vaccines.fk_description, lu_vaccines_in_schedule.fk_vaccine, lu_descriptions.description, lu_descriptions.deleted AS description_deleted FROM (((lu_schedules JOIN lu_vaccines_in_schedule ON ((lu_schedules.pk = lu_vaccines_in_schedule.fk_schedule))) JOIN lu_vaccines ON ((lu_vaccines_in_schedule.fk_vaccine = lu_vaccines.pk))) JOIN lu_descriptions ON ((lu_vaccines.fk_description = lu_descriptions.pk))) ORDER BY lu_schedules.schedule, lu_vaccines.brand;


--
-- TOC entry 3618 (class 2604 OID 274184)
-- Dependencies: 3028 3027
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE last_batch_number ALTER COLUMN pk SET DEFAULT nextval('last_batch_number_pk_seq'::regclass);


--
-- TOC entry 3622 (class 2604 OID 275809)
-- Dependencies: 3255 3256 3256
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE lu_descriptions ALTER COLUMN pk SET DEFAULT nextval('lu_vaccines_descriptions_pk_seq'::regclass);


--
-- TOC entry 3617 (class 2604 OID 274186)
-- Dependencies: 3026 3025
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE lu_indication ALTER COLUMN pk SET DEFAULT nextval('indication_pk_seq'::regclass);


--
-- TOC entry 3619 (class 2604 OID 274187)
-- Dependencies: 3031 3030
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE lu_schedules ALTER COLUMN pk SET DEFAULT nextval('lu_schedules_pk_seq'::regclass);


--
-- TOC entry 3621 (class 2604 OID 274188)
-- Dependencies: 3033 3032
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE lu_target ALTER COLUMN pk SET DEFAULT nextval('lu_target_pk_seq'::regclass);


--
-- TOC entry 3624 (class 2604 OID 275837)
-- Dependencies: 3258 3259 3259
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE lu_vaccines ALTER COLUMN pk SET DEFAULT nextval('lu_vaccines_pk_seq'::regclass);


--
-- TOC entry 3616 (class 2604 OID 274192)
-- Dependencies: 3024 3023
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE vaccinations ALTER COLUMN pk SET DEFAULT nextval('data_pk_seq'::regclass);


--
-- TOC entry 3643 (class 0 OID 273164)
-- Dependencies: 3027
-- Data for Name: last_batch_number; Type: TABLE DATA; Schema: clin_vaccination; Owner: -
--

COPY last_batch_number (pk, fk_vaccine, batch_number, fk_provider) FROM stdin;
\.


--
-- TOC entry 3646 (class 0 OID 275806)
-- Dependencies: 3256
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
-- TOC entry 3642 (class 0 OID 273156)
-- Dependencies: 3025
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
-- TOC entry 3644 (class 0 OID 273179)
-- Dependencies: 3030
-- Data for Name: lu_schedules; Type: TABLE DATA; Schema: clin_vaccination; Owner: -
--

COPY lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, aboriginal_tsi_only, fk_season, inactive, date_inactive) FROM stdin;
2  2  \N  2 month childhood (Prior 1/5/2000)  f  f  0  t  \N
3  4  \N  4 month  childhood (Prior 1/5/2000)  f  f  0  t  \N
4  6  \N  6 month  childhood (Prior 1/5/2000)  f  f  0  t  \N
5  12  \N  12 month  childhood (Prior 1/5/2000)  f  f  0  t  \N
6  18  \N  18 month  childhood (Prior 1/5/2000)  f  f  0  t  \N
7  4  5  Prior to school  (4-5yrs) (Prior 1/5/2000)  f  f  0  t  \N
8  10  16  Hepatitis B - school 10-16 years (Prior 1/5/2000)  f  f  0  t  \N
9  15  19  ADT + Polio -  15-19 years  f  f  0  t  \N
13  \N  1188  Pneumoccal  f  f  0  t  \N
14  \N  1188  Influenza  f  f  1  t  \N
15  \N  1188  Tetanus - every 10 years  f  f  0  t  \N
16  \N  1188  Tuberculosis  f  f  0  t  \N
17  \N  1188  Q-Fever  f  f  0  t  \N
18  \N  1188  Hepatitis A  f  f  0  t  \N
19  \N  1188  Diptheria  f  f  0  t  \N
20  \N  1188  Meningococcal  f  f  0  t  \N
21  \N  1188  Poliomyelitis  f  f  0  t  \N
22  \N  1188  Rabies  f  f  0  t  \N
23  \N  1188  Typhoid  f  f  0  t  \N
24  \N  1188  Cholera  f  f  0  t  \N
25  \N  1188  Yellow Fever  f  f  0  t  \N
26  \N  1188  Plague  f  f  0  t  \N
27  \N  1188  Mumps  f  f  0  t  \N
28  \N  1188  Measles  f  f  0  t  \N
29  \N  1188  Rubella  f  f  0  t  \N
30  \N  1188  Hepatitis B  f  f  0  t  \N
31  \N  1188  Japanese Encephalitis  f  f  0  t  \N
32  \N  1188  Hepatitis A + Hepatitis B  f  f  0  t  \N
33  2  \N  2 month childhood (After 1/5/2000)  f  f  0  t  \N
34  4  \N  4 month childhood (After 1/5/2000)  f  f  0  t  \N
35  6  \N  6 month childhood (After 1/5/2000)  f  f  0  t  \N
36  12  \N  12 month childhood (After 1/5/2000)  f  f  0  t  \N
37  18  \N  18 month childhood (After 1/5/2000)  f  f  0  t  \N
38  45  5  Prior to school (4-5yrs) (After 1/5/2000)  f  f  0  t  \N
39  \N  144  Chicken Pox age < 12 years  f  f  0  t  \N
40  \N  1188  Chicken Pox age > 12 years  f  f  0  t  \N
41  \N  \N  Pertussis  f  f  0  t  \N
42  2  2  2 month childhood (From 1/11/2005)  f  f  0  t  \N
43  4  4  4 month childhood (From 1/11/2005)  f  f  0  t  \N
44  6  6  6 month childhood (From 1/11/2005)  f  f  0  t  \N
45  12  \N  12 month childhood (From 1/11/2005)  f  f  0  t  \N
46  18  \N  18 month childhood (From 1/11/2005)  f  f  0  t  \N
47  46  60  4 year childhoot (From 1/11/2005)  f  f  0  t  \N
48  \N  1188  Typhoid + Hepatitis A  f  f  0  t  \N
49  216  312  Human Papilloma Virus (18-26yrs)  f  f  0  t  \N
50  2  \N  2 month childhood (Born after 01 May 2007)  f  f  0  t  \N
51  4  \N  4 month childhood (Born after 01 May 2007)  f  f  0  t  \N
\.


--
-- TOC entry 3645 (class 0 OID 273187)
-- Dependencies: 3032
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
-- TOC entry 3648 (class 0 OID 275834)
-- Dependencies: 3259
-- Data for Name: lu_vaccines; Type: TABLE DATA; Schema: clin_vaccination; Owner: -
--

COPY lu_vaccines (pk, brand, form, fk_description, fk_route) FROM stdin;
177  Varivax II  Injection  4  \N
178  Meningitec  injection  18  \N
179  Neis-vac C  injection  18  \N
180  Menjugate  injection  18  \N
181  Infranrix hexa  injection  8  \N
182  Infranrix-IPV  injection  38  \N
183  Vivaxim  injection  26  \N
185  Gardasil  injection  13  \N
186  Rotarix  oral  28  \N
187  Influvac  injection  12  \N
189  Boostrix IPV  injection  38  \N
1  BCG Vaccine  Injection  16  \N
17  Havrix prefilled syringe  Injection  14  \N
18  Twinrix Junior Formulation  Injection  32  \N
19  Twinrix Adult Formulation  Injection  7  \N
20  H-B-Vax II Paediatric Formulation  Injection  21  \N
21  H-B-Vax II Dialysis Formulation  Injection  21  \N
22  H-B-Vax II Adult Formulation  Injection  21  \N
23  Engerix-B Adult Formulation  Injection  21  \N
24  Engerix-B Paediatric Formulation  Injection  21  \N
25  Fluvax  Injection  2  \N
26  Vaxigrip  Injection  2  \N
27  M-M-R II  Injection  3  \N
28  Mencevax ACWY  Injection  18  \N
29  Menomune  Injection  18  \N
30  Pneumovax 23  Injection  41  \N
31  Ipol  Injection  29  \N
32  Polio Sabin (Oral)  Drop  24  \N
33  Merieux Inactivated Rabies Vaccine  Injection  34  \N
34  Meruvax II  Injection  22  \N
35  Ervevax  Injection  22  \N
36  Typh-Vax (Oral)  Capsules  36  \N
37  Typhim Vi  Injection  10  \N
38  Typhoid Vaccine  injection  10  \N
39  Tet-Tox  Injection  30  \N
40  Cholera Vaccine  Injection  31  \N
41  Yellow Fever Vaccine  injection  9  \N
42  Plague Vaccine  Injection  15  \N
52  Fluarix  Injection  2  \N
64  Je-Vax  Injection  20  \N
163  Prevenar  Injection  41  \N
75  Stamaril  Injection  9  \N
76  Brand Unknown  Injection  27  \N
88  Fluvirin  Injection  2  \N
98  Infanrix Hep B  Injection  17  \N
101  Liquid PedvaxHIB  Injection  40  \N
111  Priorix  Injection  35  \N
120  Typherix  Injection  10  \N
124  Varilrix  Injection  4  \N
126  Avaxim Inactivated Hepatitis A Vaccine  Injection  14  \N
128  Boostrix  Injection  37  \N
131  Comvax  Injection  1  \N
134  Engerix-B Adult Formulation Injection  Injection  21  \N
135  Engerix-B Paediatric Formulation Injection  Injection  21  \N
140  H-B-Vax II Adult Formulation Injection  Injection  21  \N
141  H-B-Vax II Dialysis Formulation Injection  Injection  21  \N
142  H-B-Vax II Paediatric Formulation Injection  Injection  21  \N
143  H-B-Vax II Paediatric Formulation Injection Preservative free  Injection  21  \N
144  Havrix Junior prefilled syringe Injection  Injection  14  \N
145  Havrix monodose vial Injection  Injection  14  \N
146  Havrix prefilled syringe Injection  Injection  14  \N
159  Orochol  Powder  23  \N
190  PanVax  Adult (Swine Flu)  injection  12  \N
169  Twinrix Adult Formulation Injection  Injection  32  \N
170  Twinrix Junior Formulation Injection  Injection  7  \N
174  VAQTA Adult Formulation Injection  Injection  14  \N
175  VAQTA Paediatric/adolescent Formulation Injection  Injection  14  \N
184  Dukoral  oral  25  \N
2  Q-Vax  Injection  19  \N
3  Diphtheria Vaccine, Adsorbed (Diluted for Adult Use)  Injection  11  \N
4  Diphtheria Vaccine, Adsorbed  Injection  11  \N
5  Triple Antigen (Diphtheria, Tetanus, Pertussis - Adsorbed)  Injection  33  \N
6  Infanrix  Injection  5  \N
7  Tripacel  Injection  33  \N
8  CDT Vaccine  Injection  39  \N
9  ADT Vaccine  Injection  6  \N
10  HibTITER  Injection  40  \N
11  Hiberix  Injection  40  \N
12  PedvaxHIB  Injection  40  \N
13  VAQTA Adult Formulation  Injection  14  \N
14  Havrix monodose vial  Injection  14  \N
15  VAQTA Paediatric/adolescent Formulation  Injection  14  \N
16  Havrix Junior prefilled syringe  Injection  14  \N
191  Adacel  injection  37  \N
192  PanVax Junior (Swine Flu) <3yrs  injection  12  \N
193  Intanza  injection  12  \N
\.


--
-- TOC entry 3647 (class 0 OID 275818)
-- Dependencies: 3257
-- Data for Name: lu_vaccines_in_schedule; Type: TABLE DATA; Schema: clin_vaccination; Owner: -
--

COPY lu_vaccines_in_schedule (fk_vaccine, fk_schedule) FROM stdin;
12  35
32  35
111  36
27  36
101  36
6  37
6  38
111  38
32  38
111  5
111  7
20  30
18  8
19  8
163  13
126  18
88  14
159  24
76  25
111  27
111  28
111  29
101  33
101  34
179  20
180  20
128  41
163  42
163  43
163  44
181  42
181  43
181  44
111  45
11  45
178  45
163  45
124  46
182  47
111  47
30  47
183  48
184  24
185  49
181  50
163  50
163  51
181  51
186  50
186  51
187  14
189  15
128  15
124  39
124  40
120  23
177  39
177  40
178  20
20  1
24  1
6  2
7  2
5  2
10  2
11  2
12  2
32  2
5  3
6  3
7  3
10  3
11  3
12  3
5  4
6  4
7  4
10  4
11  4
27  5
12  5
5  6
6  6
7  6
10  6
11  6
32  3
32  4
9  15
39  15
1  16
2  17
13  18
14  18
15  18
16  18
17  18
19  32
3  19
4  19
28  20
29  20
31  21
32  21
33  22
36  23
37  23
38  23
40  24
41  25
42  26
27  27
27  28
27  29
34  29
25  14
26  14
30  13
30  11
25  12
26  12
34  10
35  10
31  9
32  9
5  7
6  7
7  7
31  7
32  7
9  9
27  7
21  30
22  30
23  30
24  30
35  29
52  12
52  14
75  25
64  31
18  32
20  8
21  8
22  8
23  8
24  8
98  33
12  33
32  33
98  34
12  34
32  34
98  35
190  14
191  41
191  19
192  14
191  15
193  14
\.


--
-- TOC entry 3641 (class 0 OID 273146)
-- Dependencies: 3023
-- Data for Name: vaccinations; Type: TABLE DATA; Schema: clin_vaccination; Owner: -
--

COPY vaccinations (pk, fk_consult, fk_vaccine, fk_schedule, fk_site, fk_laterality, fk_route, date_given, serial_no) FROM stdin;
\.


--
-- TOC entry 3626 (class 2606 OID 275392)
-- Dependencies: 3023 3023
-- Name: data_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY vaccinations
    ADD CONSTRAINT data_pkey PRIMARY KEY (pk);


--
-- TOC entry 3628 (class 2606 OID 275394)
-- Dependencies: 3025 3025
-- Name: indication_key; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_indication
    ADD CONSTRAINT indication_key UNIQUE (medical_name);


--
-- TOC entry 3632 (class 2606 OID 275396)
-- Dependencies: 3027 3027
-- Name: last_batch_number_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY last_batch_number
    ADD CONSTRAINT last_batch_number_pkey PRIMARY KEY (pk);


--
-- TOC entry 3630 (class 2606 OID 275398)
-- Dependencies: 3025 3025
-- Name: lu_indication_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_indication
    ADD CONSTRAINT lu_indication_pkey PRIMARY KEY (pk);


--
-- TOC entry 3634 (class 2606 OID 275400)
-- Dependencies: 3030 3030
-- Name: lu_schedules_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_schedules
    ADD CONSTRAINT lu_schedules_pkey PRIMARY KEY (pk);


--
-- TOC entry 3636 (class 2606 OID 275402)
-- Dependencies: 3032 3032
-- Name: lu_target_pkey1; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_target
    ADD CONSTRAINT lu_target_pkey1 PRIMARY KEY (pk);


--
-- TOC entry 3638 (class 2606 OID 275815)
-- Dependencies: 3256 3256
-- Name: lu_vaccines_descriptions_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_descriptions
    ADD CONSTRAINT lu_vaccines_descriptions_pkey PRIMARY KEY (pk);


--
-- TOC entry 3640 (class 2606 OID 275842)
-- Dependencies: 3259 3259
-- Name: lu_vaccines_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_vaccines
    ADD CONSTRAINT lu_vaccines_pkey PRIMARY KEY (pk);


--
-- TOC entry 3652 (class 0 OID 0)
-- Dependencies: 25
-- Name: clin_vaccination; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA clin_vaccination FROM PUBLIC;
REVOKE ALL ON SCHEMA clin_vaccination FROM richard;
GRANT ALL ON SCHEMA clin_vaccination TO richard;
GRANT ALL ON SCHEMA clin_vaccination TO easygp;
GRANT USAGE ON SCHEMA clin_vaccination TO staff;


--
-- TOC entry 3654 (class 0 OID 0)
-- Dependencies: 3023
-- Name: vaccinations; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE vaccinations FROM PUBLIC;
REVOKE ALL ON TABLE vaccinations FROM richard;
GRANT ALL ON TABLE vaccinations TO richard;
GRANT ALL ON TABLE vaccinations TO easygp;
GRANT ALL ON TABLE vaccinations TO staff;


--
-- TOC entry 3657 (class 0 OID 0)
-- Dependencies: 3024
-- Name: data_pk_seq; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON SEQUENCE data_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE data_pk_seq FROM richard;
GRANT ALL ON SEQUENCE data_pk_seq TO richard;
GRANT ALL ON SEQUENCE data_pk_seq TO easygp;
GRANT USAGE ON SEQUENCE data_pk_seq TO staff;


--
-- TOC entry 3659 (class 0 OID 0)
-- Dependencies: 3025
-- Name: lu_indication; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE lu_indication FROM PUBLIC;
REVOKE ALL ON TABLE lu_indication FROM richard;
GRANT ALL ON TABLE lu_indication TO richard;
GRANT ALL ON TABLE lu_indication TO easygp;
GRANT SELECT ON TABLE lu_indication TO staff;


--
-- TOC entry 3662 (class 0 OID 0)
-- Dependencies: 3026
-- Name: indication_pk_seq; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON SEQUENCE indication_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE indication_pk_seq FROM richard;
GRANT ALL ON SEQUENCE indication_pk_seq TO richard;
GRANT ALL ON SEQUENCE indication_pk_seq TO easygp;
GRANT USAGE ON SEQUENCE indication_pk_seq TO staff;


--
-- TOC entry 3664 (class 0 OID 0)
-- Dependencies: 3027
-- Name: last_batch_number; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE last_batch_number FROM PUBLIC;
REVOKE ALL ON TABLE last_batch_number FROM richard;
GRANT ALL ON TABLE last_batch_number TO richard;
GRANT ALL ON TABLE last_batch_number TO easygp;
GRANT ALL ON TABLE last_batch_number TO staff;


--
-- TOC entry 3667 (class 0 OID 0)
-- Dependencies: 3028
-- Name: last_batch_number_pk_seq; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON SEQUENCE last_batch_number_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE last_batch_number_pk_seq FROM richard;
GRANT ALL ON SEQUENCE last_batch_number_pk_seq TO richard;
GRANT ALL ON SEQUENCE last_batch_number_pk_seq TO easygp;
GRANT USAGE ON SEQUENCE last_batch_number_pk_seq TO staff;


--
-- TOC entry 3669 (class 0 OID 0)
-- Dependencies: 3256
-- Name: lu_descriptions; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE lu_descriptions FROM PUBLIC;
REVOKE ALL ON TABLE lu_descriptions FROM easygp;
GRANT ALL ON TABLE lu_descriptions TO easygp;
GRANT ALL ON TABLE lu_descriptions TO staff;


--
-- TOC entry 3672 (class 0 OID 0)
-- Dependencies: 3029
-- Name: lu_indication_pk_seq; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON SEQUENCE lu_indication_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_indication_pk_seq FROM richard;
GRANT ALL ON SEQUENCE lu_indication_pk_seq TO richard;
GRANT ALL ON SEQUENCE lu_indication_pk_seq TO easygp;
GRANT USAGE ON SEQUENCE lu_indication_pk_seq TO staff;


--
-- TOC entry 3677 (class 0 OID 0)
-- Dependencies: 3030
-- Name: lu_schedules; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE lu_schedules FROM PUBLIC;
REVOKE ALL ON TABLE lu_schedules FROM richard;
GRANT ALL ON TABLE lu_schedules TO richard;
GRANT ALL ON TABLE lu_schedules TO easygp;
GRANT SELECT ON TABLE lu_schedules TO staff;


--
-- TOC entry 3680 (class 0 OID 0)
-- Dependencies: 3031
-- Name: lu_schedules_pk_seq; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON SEQUENCE lu_schedules_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_schedules_pk_seq FROM richard;
GRANT ALL ON SEQUENCE lu_schedules_pk_seq TO richard;
GRANT ALL ON SEQUENCE lu_schedules_pk_seq TO easygp;
GRANT USAGE ON SEQUENCE lu_schedules_pk_seq TO staff;


--
-- TOC entry 3681 (class 0 OID 0)
-- Dependencies: 3032
-- Name: lu_target; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE lu_target FROM PUBLIC;
REVOKE ALL ON TABLE lu_target FROM richard;
GRANT ALL ON TABLE lu_target TO richard;
GRANT ALL ON TABLE lu_target TO easygp;
GRANT SELECT ON TABLE lu_target TO staff;


--
-- TOC entry 3684 (class 0 OID 0)
-- Dependencies: 3033
-- Name: lu_target_pk_seq; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON SEQUENCE lu_target_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_target_pk_seq FROM richard;
GRANT ALL ON SEQUENCE lu_target_pk_seq TO richard;
GRANT ALL ON SEQUENCE lu_target_pk_seq TO easygp;
GRANT USAGE ON SEQUENCE lu_target_pk_seq TO staff;


--
-- TOC entry 3686 (class 0 OID 0)
-- Dependencies: 3259
-- Name: lu_vaccines; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE lu_vaccines FROM PUBLIC;
REVOKE ALL ON TABLE lu_vaccines FROM easygp;
GRANT ALL ON TABLE lu_vaccines TO easygp;
GRANT ALL ON TABLE lu_vaccines TO staff;


--
-- TOC entry 3689 (class 0 OID 0)
-- Dependencies: 3257
-- Name: lu_vaccines_in_schedule; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE lu_vaccines_in_schedule FROM PUBLIC;
REVOKE ALL ON TABLE lu_vaccines_in_schedule FROM easygp;
GRANT ALL ON TABLE lu_vaccines_in_schedule TO easygp;
GRANT ALL ON TABLE lu_vaccines_in_schedule TO staff;


--
-- TOC entry 3692 (class 0 OID 0)
-- Dependencies: 3260
-- Name: vwvaccines; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE vwvaccines FROM PUBLIC;
REVOKE ALL ON TABLE vwvaccines FROM easygp;
GRANT ALL ON TABLE vwvaccines TO easygp;
GRANT ALL ON TABLE vwvaccines TO staff;


--
-- TOC entry 3693 (class 0 OID 0)
-- Dependencies: 3261
-- Name: vwvaccinesinschedule; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE vwvaccinesinschedule FROM PUBLIC;
REVOKE ALL ON TABLE vwvaccinesinschedule FROM easygp;
GRANT ALL ON TABLE vwvaccinesinschedule TO easygp;
GRANT ALL ON TABLE vwvaccinesinschedule TO staff;


-- Completed on 2010-11-04 18:57:11 EST

--
-- PostgreSQL database dump complete
--






-------------------------------------
truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 38);