drop schema clin_vaccination cascade;
--
-- PostgreSQL database dump
--

-- Started on 2010-12-03 08:24:52 EST

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 10 (class 2615 OID 332185)
-- Name: clin_vaccination; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA clin_vaccination;


--
-- TOC entry 3635 (class 0 OID 0)
-- Dependencies: 10
-- Name: SCHEMA clin_vaccination; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA clin_vaccination IS ' Easy GP:2April2008 creates all the tables to do with vaccination ie vaccines (holds the brand names, fk_vaccine_description, form (eg injection) vaccines_descriptions eg typoid or tetanus toxoid, diptheria toxoid vaccines_last_bath_number - dr/nurse specific last batch used';


SET search_path = clin_vaccination, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 3203 (class 1259 OID 332186)
-- Dependencies: 3600 3601 10
-- Name: vaccinations; Type: TABLE; Schema: clin_vaccination; Owner: -; Tablespace: 
--

CREATE TABLE vaccinations (
    pk integer NOT NULL,
    fk_vaccine integer,
    fk_schedule integer,
    fk_site integer DEFAULT 1 NOT NULL,
    fk_laterality integer,
    date_given character varying(10),
    serial_no text DEFAULT 'not recorded'::text NOT NULL,
    fk_progressnote integer
);


--
-- TOC entry 3637 (class 0 OID 0)
-- Dependencies: 3203
-- Name: COLUMN vaccinations.date_given; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON COLUMN vaccinations.date_given IS 'not a date field because sometimes may need to record just say 01/2002 or 1998';


--
-- TOC entry 3204 (class 1259 OID 332194)
-- Dependencies: 10 3203
-- Name: data_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE data_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 3639 (class 0 OID 0)
-- Dependencies: 3204
-- Name: data_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE data_pk_seq OWNED BY vaccinations.pk;


--
-- TOC entry 3640 (class 0 OID 0)
-- Dependencies: 3204
-- Name: data_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: -
--

SELECT pg_catalog.setval('data_pk_seq', 34, true);


--
-- TOC entry 3205 (class 1259 OID 332196)
-- Dependencies: 3603 10
-- Name: lu_descriptions; Type: TABLE; Schema: clin_vaccination; Owner: -; Tablespace: 
--

CREATE TABLE lu_descriptions (
    pk integer NOT NULL,
    description text,
    deleted boolean DEFAULT false
);


--
-- TOC entry 3642 (class 0 OID 0)
-- Dependencies: 3205
-- Name: TABLE lu_descriptions; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON TABLE lu_descriptions IS 'create the vaccines_descriptions table contains names describing what the brand names are eg tetanus, diptheria, or combinations thereof ';


--
-- TOC entry 3206 (class 1259 OID 332203)
-- Dependencies: 3605 3606 3607 3608 3609 10
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
-- TOC entry 3644 (class 0 OID 0)
-- Dependencies: 3206
-- Name: TABLE lu_schedules; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON TABLE lu_schedules IS 'create schedulescontains the schedules eg 2 month, 4 months, 4yrs etcA vaccination schedule can be a single vaccination or a schedule of
vaccination and contain one or more vaccines. The reason for this is complex
and practical referral to the doc for further information';


--
-- TOC entry 3645 (class 0 OID 0)
-- Dependencies: 3206
-- Name: COLUMN lu_schedules.schedule; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON COLUMN lu_schedules.schedule IS 'either a target disease name eg ''yellow fever'' or a schedule name to describe course of combined vaccines eg Hepatits A + Hepatitis B.Hence this allows unlimited and user defined schedules.';


--
-- TOC entry 3646 (class 0 OID 0)
-- Dependencies: 3206
-- Name: COLUMN lu_schedules.atsi_only; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON COLUMN lu_schedules.atsi_only IS 'australian requirement, some schedules apply only to aboriginal or torres strait islanders at particular ages';


--
-- TOC entry 3647 (class 0 OID 0)
-- Dependencies: 3206
-- Name: COLUMN lu_schedules.fk_season; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON COLUMN lu_schedules.fk_season IS 'eg. influenza prompts only wanted at particular time of year';


--
-- TOC entry 3648 (class 0 OID 0)
-- Dependencies: 3206
-- Name: COLUMN lu_schedules.multiple_vaccines; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON COLUMN lu_schedules.multiple_vaccines IS 'if TRUE this vaccine schedule aka target contains muliple separate vaccines
 for example in AU the 2 month childhood has 2 separate injections and 1 oral vaccine';


--
-- TOC entry 3649 (class 0 OID 0)
-- Dependencies: 3206
-- Name: COLUMN lu_schedules.notes; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON COLUMN lu_schedules.notes IS 'any additional notes, eg the NSW 12-13yrs schedule is a school program only';


--
-- TOC entry 3207 (class 1259 OID 332214)
-- Dependencies: 3206 10
-- Name: lu_schedules_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE lu_schedules_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 3651 (class 0 OID 0)
-- Dependencies: 3207
-- Name: lu_schedules_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE lu_schedules_pk_seq OWNED BY lu_schedules.pk;


--
-- TOC entry 3652 (class 0 OID 0)
-- Dependencies: 3207
-- Name: lu_schedules_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: -
--

SELECT pg_catalog.setval('lu_schedules_pk_seq', 60, true);


--
-- TOC entry 3208 (class 1259 OID 332216)
-- Dependencies: 3611 10
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
-- TOC entry 3654 (class 0 OID 0)
-- Dependencies: 3208
-- Name: TABLE lu_vaccines; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON TABLE lu_vaccines IS 'A Table to hold all vaccines.
 Note as the database will contain legacy data, some of these brand names are no
 longer commercially available, so inactive will be true.I''ve not put a date 
 inactive inactive in here as I didn''t think it was important, or usually knowable';


--
-- TOC entry 3209 (class 1259 OID 332223)
-- Dependencies: 3205 10
-- Name: lu_vaccines_descriptions_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE lu_vaccines_descriptions_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 3656 (class 0 OID 0)
-- Dependencies: 3209
-- Name: lu_vaccines_descriptions_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE lu_vaccines_descriptions_pk_seq OWNED BY lu_descriptions.pk;


--
-- TOC entry 3657 (class 0 OID 0)
-- Dependencies: 3209
-- Name: lu_vaccines_descriptions_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: -
--

SELECT pg_catalog.setval('lu_vaccines_descriptions_pk_seq', 41, true);


--
-- TOC entry 3210 (class 1259 OID 332225)
-- Dependencies: 3613 10
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
-- TOC entry 3211 (class 1259 OID 332229)
-- Dependencies: 3210 10
-- Name: lu_vaccines_in_schedule_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE lu_vaccines_in_schedule_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 3659 (class 0 OID 0)
-- Dependencies: 3211
-- Name: lu_vaccines_in_schedule_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE lu_vaccines_in_schedule_pk_seq OWNED BY lu_vaccines_in_schedule.pk;


--
-- TOC entry 3660 (class 0 OID 0)
-- Dependencies: 3211
-- Name: lu_vaccines_in_schedule_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: -
--

SELECT pg_catalog.setval('lu_vaccines_in_schedule_pk_seq', 170, true);


--
-- TOC entry 3212 (class 1259 OID 332231)
-- Dependencies: 3208 10
-- Name: lu_vaccines_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE lu_vaccines_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 3661 (class 0 OID 0)
-- Dependencies: 3212
-- Name: lu_vaccines_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE lu_vaccines_pk_seq OWNED BY lu_vaccines.pk;


--
-- TOC entry 3662 (class 0 OID 0)
-- Dependencies: 3212
-- Name: lu_vaccines_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: -
--

SELECT pg_catalog.setval('lu_vaccines_pk_seq', 193, true);


--
-- TOC entry 3213 (class 1259 OID 332233)
-- Dependencies: 10
-- Name: vaccine_serial_numbers; Type: TABLE; Schema: clin_vaccination; Owner: -; Tablespace: 
--

CREATE TABLE vaccine_serial_numbers (
    pk integer NOT NULL,
    fk_vaccine integer,
    serial_number text NOT NULL,
    date_used date NOT NULL
);


--
-- TOC entry 3663 (class 0 OID 0)
-- Dependencies: 3213
-- Name: TABLE vaccine_serial_numbers; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON TABLE vaccine_serial_numbers IS 'last used batch number to make it easier on the doctors typing when e.g vaccines may be stored in fridges in rooms in a surgery and most doctors and nurses work out of their own rooms. todo link to doctor code table';


--
-- TOC entry 3214 (class 1259 OID 332239)
-- Dependencies: 10 3213
-- Name: vaccine_serial_numbers_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE vaccine_serial_numbers_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 3665 (class 0 OID 0)
-- Dependencies: 3214
-- Name: vaccine_serial_numbers_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE vaccine_serial_numbers_pk_seq OWNED BY vaccine_serial_numbers.pk;


--
-- TOC entry 3666 (class 0 OID 0)
-- Dependencies: 3214
-- Name: vaccine_serial_numbers_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: -
--

SELECT pg_catalog.setval('vaccine_serial_numbers_pk_seq', 19, true);


--
-- TOC entry 3215 (class 1259 OID 332241)
-- Dependencies: 3378 10
-- Name: vwvaccines; Type: VIEW; Schema: clin_vaccination; Owner: -
--

CREATE VIEW vwvaccines AS
    SELECT lu_vaccines.pk, lu_vaccines.brand, lu_vaccines.form, lu_vaccines.fk_description, lu_vaccines.inactive AS vaccine_inactive, lu_descriptions.description, lu_descriptions.deleted AS decription_deleted FROM (lu_vaccines JOIN lu_descriptions ON ((lu_vaccines.fk_description = lu_descriptions.pk))) ORDER BY lu_descriptions.description;


--
-- TOC entry 3216 (class 1259 OID 332245)
-- Dependencies: 3379 10
-- Name: vwvaccinesgiven; Type: VIEW; Schema: clin_vaccination; Owner: -
--

CREATE VIEW vwvaccinesgiven AS
    SELECT vaccinations.pk AS pk_view, vaccinations.pk AS fk_vaccination, consult.fk_patient, vwstaff.title AS staff_title, vwstaff.wholename AS staff_wholename, consult.consult_date, consult.fk_staff, consult.pk AS fk_consult, lu_schedules.age_due_from_months, lu_schedules.age_due_to_months, lu_schedules.schedule, lu_schedules.female_only, lu_schedules.atsi_only, lu_schedules.fk_season, lu_schedules.inactive AS schedule_inactive, lu_schedules.date_inactive AS date_schedule_inactive, lu_schedules.deleted AS schedule_deleted, lu_schedules.multiple_vaccines, lu_schedules.notes AS schedule_notes, lu_seasons.season, lu_laterality.laterality, lu_site_administration.site, progressnotes.notes AS progress_notes, lu_vaccines.brand, lu_vaccines.form, lu_vaccines.fk_description, lu_vaccines.fk_route, lu_vaccines.inactive, vaccinations.fk_vaccine, vaccinations.fk_schedule, vaccinations.fk_site, vaccinations.fk_laterality, vaccinations.date_given, vaccinations.serial_no, vaccinations.fk_progressnote FROM ((((((((clin_consult.consult JOIN admin.vwstaff ON ((consult.fk_staff = vwstaff.fk_staff))) JOIN clin_consult.progressnotes ON ((progressnotes.fk_consult = consult.pk))) JOIN vaccinations ON ((vaccinations.fk_progressnote = progressnotes.pk))) LEFT JOIN common.lu_site_administration ON ((vaccinations.fk_site = lu_site_administration.pk))) LEFT JOIN common.lu_laterality ON ((vaccinations.fk_laterality = lu_laterality.pk))) JOIN lu_schedules ON ((vaccinations.fk_schedule = lu_schedules.pk))) JOIN lu_vaccines ON ((vaccinations.fk_vaccine = lu_vaccines.pk))) LEFT JOIN common.lu_seasons ON ((lu_schedules.fk_season = lu_seasons.pk))) ORDER BY consult.fk_patient, vaccinations.fk_schedule, vaccinations.date_given;


--
-- TOC entry 3217 (class 1259 OID 332250)
-- Dependencies: 3380 10
-- Name: vwvaccinesinschedule; Type: VIEW; Schema: clin_vaccination; Owner: -
--

CREATE VIEW vwvaccinesinschedule AS
    SELECT lu_vaccines_in_schedule.pk AS pk_view, lu_vaccines_in_schedule.pk AS fk_lu_vaccines_in_schedule, lu_vaccines_in_schedule.fk_schedule, lu_vaccines_in_schedule.fk_vaccine, lu_vaccines_in_schedule.atsi_only AS vaccine_atsi_only, lu_vaccines_in_schedule.date_inactive AS date_vaccine_in_schedule_inactive, lu_schedules.age_due_from_months, lu_schedules.age_due_to_months, lu_schedules.schedule, lu_schedules.female_only AS schedule_female_only, lu_schedules.atsi_only AS schedule_atsi_only, lu_schedules.fk_season, lu_schedules.inactive AS schedule_inactive, lu_schedules.date_inactive AS date_schedule_inactive, lu_schedules.deleted AS schedule_deleted, lu_schedules.multiple_vaccines, lu_schedules.notes, lu_vaccines.brand, lu_vaccines.form, lu_vaccines.fk_description, lu_vaccines.fk_route, lu_vaccines.inactive AS vaccine_inactive, lu_seasons.season, lu_descriptions.description AS vaccine_description FROM ((((lu_vaccines_in_schedule JOIN lu_schedules ON ((lu_vaccines_in_schedule.fk_schedule = lu_schedules.pk))) JOIN lu_vaccines ON ((lu_vaccines_in_schedule.fk_vaccine = lu_vaccines.pk))) LEFT JOIN common.lu_seasons ON ((lu_schedules.fk_season = lu_seasons.pk))) JOIN lu_descriptions ON ((lu_vaccines.fk_description = lu_descriptions.pk))) ORDER BY lu_vaccines_in_schedule.fk_schedule, lu_vaccines.brand;


--
-- TOC entry 3602 (class 2604 OID 332255)
-- Dependencies: 3209 3205
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE lu_descriptions ALTER COLUMN pk SET DEFAULT nextval('lu_vaccines_descriptions_pk_seq'::regclass);


--
-- TOC entry 3604 (class 2604 OID 332256)
-- Dependencies: 3207 3206
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE lu_schedules ALTER COLUMN pk SET DEFAULT nextval('lu_schedules_pk_seq'::regclass);


--
-- TOC entry 3610 (class 2604 OID 332257)
-- Dependencies: 3212 3208
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE lu_vaccines ALTER COLUMN pk SET DEFAULT nextval('lu_vaccines_pk_seq'::regclass);


--
-- TOC entry 3612 (class 2604 OID 332258)
-- Dependencies: 3211 3210
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE lu_vaccines_in_schedule ALTER COLUMN pk SET DEFAULT nextval('lu_vaccines_in_schedule_pk_seq'::regclass);


--
-- TOC entry 3599 (class 2604 OID 332259)
-- Dependencies: 3204 3203
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE vaccinations ALTER COLUMN pk SET DEFAULT nextval('data_pk_seq'::regclass);


--
-- TOC entry 3614 (class 2604 OID 332260)
-- Dependencies: 3214 3213
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE vaccine_serial_numbers ALTER COLUMN pk SET DEFAULT nextval('vaccine_serial_numbers_pk_seq'::regclass);


--
-- TOC entry 3628 (class 0 OID 332196)
-- Dependencies: 3205
-- Data for Name: lu_descriptions; Type: TABLE DATA; Schema: clin_vaccination; Owner: -
--

INSERT INTO lu_descriptions (pk, description, deleted) VALUES (1, 'Hepatitis B vaccine,Haemophilus B conjugate vaccine', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (2, 'Influenza virus vaccine', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (3, 'Measles vaccine, live,Mumps vaccine, live,Rubella vaccine, live', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (4, 'Varicella zoster vaccine, live attenuated', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (5, 'Tetanus toxoid,Pertussis vaccine,Diphtheria toxoid', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (6, 'Tetanus toxoid,Diphtheria toxoid', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (7, 'Hepatitis B vaccine,Hepatitis A vaccine', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (8, 'Ditheria,Tetanus,Pertussis,Hib, Hepatitis B, Polio', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (9, 'Yellow fever vaccine', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (10, 'Salmonella typhi vaccine', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (11, 'Diphtheria toxoid', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (12, 'Influenza Vaccine', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (13, 'Human Papilloma Virus Vaccine', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (14, 'Hepatitis A vaccine', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (15, 'Yersinia pestis vaccine', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (16, 'BCG vaccine', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (17, 'Pertussis vaccine,Hepatitis B vaccine,Tetanus toxoid,Diphtheria toxoid', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (18, 'Neisseria meningitidis vaccine', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (19, 'Coxiella burnetii vaccine', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (20, 'Japanese encephalitis virus vaccine', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (21, 'Hepatitis B vaccine', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (22, 'Rubella vaccine', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (23, 'Vibrio cholerae vaccine, oral', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (24, 'Poliomyelitis vaccine, oral', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (25, 'Vibrio cholerae vaccine', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (26, 'salmonella typhi vaccine,Hepatitis A vaccine', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (27, 'Yellow fever Vaccine', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (28, 'Rota Virus Vaccine', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (29, 'Poliomyelitis vaccine', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (30, 'Tetanus toxoid', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (31, 'Cholera vaccine', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (32, 'Hepatitis A vaccine,Hepatitis B vaccine', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (33, 'Tetanus toxoid,Diphtheria toxoid,Pertussis vaccine', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (34, 'Rabies vaccine', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (35, 'Measles vaccine, live,Rubella vaccine, live,Mumps vaccine, live', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (36, 'Salmonella typhi vaccine, oral', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (37, 'Pertussis vaccine,Tetanus toxoid,Diphtheria toxoid', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (38, 'Diptheria,Tetanus,Pertussis,Polio', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (39, 'Diphtheria toxoid,Tetanus toxoid', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (40, 'Haemophilus B conjugate vaccine', false);
INSERT INTO lu_descriptions (pk, description, deleted) VALUES (41, 'Pneumococcal vaccine', false);


--
-- TOC entry 3629 (class 0 OID 332203)
-- Dependencies: 3206
-- Data for Name: lu_schedules; Type: TABLE DATA; Schema: clin_vaccination; Owner: -
--

INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (2, 2, NULL, '2 month childhood (Prior 1/5/2000)', false, false, NULL, true, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (3, 4, NULL, '4 month  childhood (Prior 1/5/2000)', false, false, NULL, true, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (4, 6, NULL, '6 month  childhood (Prior 1/5/2000)', false, false, NULL, true, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (5, 12, NULL, '12 month  childhood (Prior 1/5/2000)', false, false, NULL, true, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (6, 18, NULL, '18 month  childhood (Prior 1/5/2000)', false, false, NULL, true, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (7, 4, 5, 'Prior to school  (4-5yrs) (Prior 1/5/2000)', false, false, NULL, true, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (8, 10, 16, 'Hepatitis B - school 10-16 years (Prior 1/5/2000)', false, false, NULL, true, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (9, 15, 19, 'ADT + Polio -  15-19 years', false, false, NULL, true, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (33, 2, NULL, '2 month childhood (After 1/5/2000)', false, false, NULL, true, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (34, 4, NULL, '4 month childhood (After 1/5/2000)', false, false, NULL, true, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (35, 6, NULL, '6 month childhood (After 1/5/2000)', false, false, NULL, true, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (36, 12, NULL, '12 month childhood (After 1/5/2000)', false, false, NULL, true, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (37, 18, NULL, '18 month childhood (After 1/5/2000)', false, false, NULL, true, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (38, 45, 5, 'Prior to school (4-5yrs) (After 1/5/2000)', false, false, NULL, true, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (39, NULL, 144, 'Chicken Pox age < 12 years', false, false, NULL, true, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (41, NULL, NULL, 'Pertussis', false, false, NULL, true, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (42, 2, 2, '2 month childhood (From 1/11/2005)', false, false, NULL, true, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (43, 4, 4, '4 month childhood (From 1/11/2005)', false, false, NULL, true, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (49, 216, 312, 'Human Papilloma Virus (18-26yrs)', false, false, NULL, true, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (16, NULL, NULL, 'Tuberculosis', false, false, NULL, true, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (17, NULL, NULL, 'Q-Fever', false, false, NULL, true, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (20, NULL, NULL, 'Meningococcal', false, false, NULL, true, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (21, NULL, NULL, 'Poliomyelitis', false, false, NULL, true, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (27, NULL, NULL, 'Mumps', false, false, NULL, true, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (30, NULL, NULL, 'Hepatitis B', false, false, NULL, true, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (31, NULL, NULL, 'Japanese Encephalitis', false, false, NULL, true, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (24, NULL, NULL, 'Cholera', false, false, NULL, false, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (19, NULL, NULL, 'Diptheria', false, false, NULL, false, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (14, NULL, NULL, 'Influenza', false, false, 3, false, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (18, NULL, NULL, 'Hepatitis A', false, false, NULL, false, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (32, NULL, NULL, 'Hepatitis A + Hepatitis B', false, false, NULL, false, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (28, NULL, NULL, 'Measles', false, false, NULL, false, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (13, NULL, NULL, 'Pneumoccal', false, false, NULL, false, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (22, NULL, NULL, 'Rabies', false, false, NULL, false, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (26, NULL, NULL, 'Plague', false, false, NULL, false, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (29, NULL, NULL, 'Rubella', false, false, NULL, false, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (25, NULL, NULL, 'Yellow Fever', false, false, NULL, false, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (48, NULL, NULL, 'Typhoid + Hepatitis A', false, false, NULL, false, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (23, NULL, NULL, 'Typhoid', false, false, NULL, false, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (15, NULL, NULL, 'Tetanus - every 10 years', false, false, NULL, false, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (40, NULL, NULL, 'Chicken Pox age > 12 years', false, false, NULL, false, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (46, 18, NULL, '18 month childhood', false, false, NULL, false, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (50, 2, NULL, '2 month childhood', false, false, NULL, false, NULL, false, true, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (51, 4, NULL, '4 month childhood', false, false, NULL, false, NULL, false, true, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (44, 6, 6, '6 month childhood', false, false, NULL, false, NULL, false, true, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (45, 12, NULL, '12 month childhood', false, false, NULL, false, NULL, false, true, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (47, 46, 60, '4 year childhood', false, false, NULL, false, NULL, false, true, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (54, 11, 12, 'Aboriginal Winter Schedule', false, true, 3, false, NULL, false, true, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (57, 50, NULL, '50yrs & Over ATSI (Influenza)', false, true, NULL, false, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (58, 50, NULL, '50yrs & Over (ATSI) Pneumococcal', false, true, NULL, false, NULL, false, false, NULL);
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (60, 15, NULL, '15 Yrs (School program)', false, false, NULL, false, NULL, false, false, 'School based program');
INSERT INTO lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) VALUES (59, 12, NULL, '12 yrs (School Based)', false, false, NULL, false, NULL, false, true, 'School based program only');


--
-- TOC entry 3630 (class 0 OID 332216)
-- Dependencies: 3208
-- Data for Name: lu_vaccines; Type: TABLE DATA; Schema: clin_vaccination; Owner: -
--

INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (177, 'Varivax II', 'Injection', 4, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (178, 'Meningitec', 'injection', 18, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (179, 'Neis-vac C', 'injection', 18, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (180, 'Menjugate', 'injection', 18, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (181, 'Infranrix hexa', 'injection', 8, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (182, 'Infranrix-IPV', 'injection', 38, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (183, 'Vivaxim', 'injection', 26, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (185, 'Gardasil', 'injection', 13, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (186, 'Rotarix', 'oral', 28, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (187, 'Influvac', 'injection', 12, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (189, 'Boostrix IPV', 'injection', 38, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (1, 'BCG Vaccine', 'Injection', 16, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (17, 'Havrix prefilled syringe', 'Injection', 14, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (18, 'Twinrix Junior Formulation', 'Injection', 32, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (19, 'Twinrix Adult Formulation', 'Injection', 7, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (20, 'H-B-Vax II Paediatric Formulation', 'Injection', 21, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (21, 'H-B-Vax II Dialysis Formulation', 'Injection', 21, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (22, 'H-B-Vax II Adult Formulation', 'Injection', 21, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (23, 'Engerix-B Adult Formulation', 'Injection', 21, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (24, 'Engerix-B Paediatric Formulation', 'Injection', 21, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (25, 'Fluvax', 'Injection', 2, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (26, 'Vaxigrip', 'Injection', 2, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (27, 'M-M-R II', 'Injection', 3, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (28, 'Mencevax ACWY', 'Injection', 18, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (29, 'Menomune', 'Injection', 18, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (30, 'Pneumovax 23', 'Injection', 41, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (31, 'Ipol', 'Injection', 29, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (32, 'Polio Sabin (Oral)', 'Drop', 24, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (33, 'Merieux Inactivated Rabies Vaccine', 'Injection', 34, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (34, 'Meruvax II', 'Injection', 22, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (35, 'Ervevax', 'Injection', 22, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (36, 'Typh-Vax (Oral)', 'Capsules', 36, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (37, 'Typhim Vi', 'Injection', 10, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (38, 'Typhoid Vaccine', 'injection', 10, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (39, 'Tet-Tox', 'Injection', 30, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (40, 'Cholera Vaccine', 'Injection', 31, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (41, 'Yellow Fever Vaccine', 'injection', 9, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (42, 'Plague Vaccine', 'Injection', 15, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (52, 'Fluarix', 'Injection', 2, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (64, 'Je-Vax', 'Injection', 20, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (163, 'Prevenar', 'Injection', 41, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (75, 'Stamaril', 'Injection', 9, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (76, 'Brand Unknown', 'Injection', 27, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (88, 'Fluvirin', 'Injection', 2, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (98, 'Infanrix Hep B', 'Injection', 17, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (101, 'Liquid PedvaxHIB', 'Injection', 40, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (111, 'Priorix', 'Injection', 35, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (120, 'Typherix', 'Injection', 10, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (124, 'Varilrix', 'Injection', 4, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (126, 'Avaxim Inactivated Hepatitis A Vaccine', 'Injection', 14, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (128, 'Boostrix', 'Injection', 37, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (131, 'Comvax', 'Injection', 1, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (134, 'Engerix-B Adult Formulation Injection', 'Injection', 21, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (135, 'Engerix-B Paediatric Formulation Injection', 'Injection', 21, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (140, 'H-B-Vax II Adult Formulation Injection', 'Injection', 21, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (141, 'H-B-Vax II Dialysis Formulation Injection', 'Injection', 21, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (142, 'H-B-Vax II Paediatric Formulation Injection', 'Injection', 21, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (143, 'H-B-Vax II Paediatric Formulation Injection Preservative free', 'Injection', 21, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (144, 'Havrix Junior prefilled syringe Injection', 'Injection', 14, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (145, 'Havrix monodose vial Injection', 'Injection', 14, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (146, 'Havrix prefilled syringe Injection', 'Injection', 14, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (159, 'Orochol', 'Powder', 23, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (190, 'PanVax  Adult (Swine Flu)', 'injection', 12, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (169, 'Twinrix Adult Formulation Injection', 'Injection', 32, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (170, 'Twinrix Junior Formulation Injection', 'Injection', 7, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (174, 'VAQTA Adult Formulation Injection', 'Injection', 14, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (175, 'VAQTA Paediatric/adolescent Formulation Injection', 'Injection', 14, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (184, 'Dukoral', 'oral', 25, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (2, 'Q-Vax', 'Injection', 19, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (3, 'Diphtheria Vaccine, Adsorbed (Diluted for Adult Use)', 'Injection', 11, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (4, 'Diphtheria Vaccine, Adsorbed', 'Injection', 11, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (5, 'Triple Antigen (Diphtheria, Tetanus, Pertussis - Adsorbed)', 'Injection', 33, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (6, 'Infanrix', 'Injection', 5, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (7, 'Tripacel', 'Injection', 33, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (8, 'CDT Vaccine', 'Injection', 39, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (9, 'ADT Vaccine', 'Injection', 6, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (10, 'HibTITER', 'Injection', 40, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (11, 'Hiberix', 'Injection', 40, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (12, 'PedvaxHIB', 'Injection', 40, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (13, 'VAQTA Adult Formulation', 'Injection', 14, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (14, 'Havrix monodose vial', 'Injection', 14, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (15, 'VAQTA Paediatric/adolescent Formulation', 'Injection', 14, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (16, 'Havrix Junior prefilled syringe', 'Injection', 14, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (191, 'Adacel', 'injection', 37, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (192, 'PanVax Junior (Swine Flu) <3yrs', 'injection', 12, NULL, false);
INSERT INTO lu_vaccines (pk, brand, form, fk_description, fk_route, inactive) VALUES (193, 'Intanza', 'injection', 12, NULL, false);


--
-- TOC entry 3631 (class 0 OID 332225)
-- Dependencies: 3210
-- Data for Name: lu_vaccines_in_schedule; Type: TABLE DATA; Schema: clin_vaccination; Owner: -
--

INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (1, 12, 35, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (2, 32, 35, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (3, 111, 36, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (4, 27, 36, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (5, 101, 36, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (6, 6, 37, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (7, 6, 38, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (8, 111, 38, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (9, 32, 38, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (10, 111, 5, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (11, 111, 7, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (12, 20, 30, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (13, 18, 8, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (14, 19, 8, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (15, 163, 13, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (16, 126, 18, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (17, 88, 14, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (18, 159, 24, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (19, 76, 25, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (20, 111, 27, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (21, 111, 28, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (22, 111, 29, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (23, 101, 33, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (24, 101, 34, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (25, 179, 20, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (26, 180, 20, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (27, 128, 41, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (28, 163, 42, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (29, 163, 43, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (30, 163, 44, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (31, 181, 42, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (32, 181, 43, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (33, 181, 44, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (34, 111, 45, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (35, 11, 45, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (37, 163, 45, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (38, 124, 46, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (39, 182, 47, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (40, 111, 47, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (41, 30, 47, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (42, 183, 48, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (43, 184, 24, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (44, 185, 49, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (45, 181, 50, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (46, 163, 50, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (47, 163, 51, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (48, 181, 51, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (49, 186, 50, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (50, 186, 51, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (51, 187, 14, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (52, 189, 15, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (53, 128, 15, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (54, 124, 39, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (55, 124, 40, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (56, 120, 23, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (57, 177, 39, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (58, 177, 40, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (59, 178, 20, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (60, 20, 1, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (61, 24, 1, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (62, 6, 2, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (63, 7, 2, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (64, 5, 2, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (65, 10, 2, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (66, 11, 2, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (67, 12, 2, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (68, 32, 2, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (69, 5, 3, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (70, 6, 3, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (71, 7, 3, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (72, 10, 3, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (73, 11, 3, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (74, 12, 3, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (75, 5, 4, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (76, 6, 4, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (77, 7, 4, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (78, 10, 4, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (79, 11, 4, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (80, 27, 5, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (81, 12, 5, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (82, 5, 6, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (83, 6, 6, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (84, 7, 6, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (85, 10, 6, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (86, 11, 6, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (87, 32, 3, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (88, 32, 4, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (89, 9, 15, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (90, 39, 15, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (91, 1, 16, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (92, 2, 17, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (93, 13, 18, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (94, 14, 18, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (95, 15, 18, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (96, 16, 18, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (97, 17, 18, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (98, 19, 32, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (99, 3, 19, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (100, 4, 19, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (101, 28, 20, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (102, 29, 20, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (103, 31, 21, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (104, 32, 21, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (105, 33, 22, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (106, 36, 23, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (107, 37, 23, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (108, 38, 23, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (109, 40, 24, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (110, 41, 25, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (111, 42, 26, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (112, 27, 27, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (113, 27, 28, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (114, 27, 29, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (115, 34, 29, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (116, 25, 14, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (117, 26, 14, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (118, 30, 13, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (119, 30, 11, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (120, 25, 12, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (121, 26, 12, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (122, 34, 10, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (123, 35, 10, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (124, 31, 9, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (125, 32, 9, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (126, 5, 7, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (127, 6, 7, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (128, 7, 7, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (129, 31, 7, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (130, 32, 7, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (131, 9, 9, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (132, 27, 7, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (133, 21, 30, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (134, 22, 30, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (135, 23, 30, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (136, 24, 30, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (137, 35, 29, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (138, 52, 12, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (139, 52, 14, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (140, 75, 25, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (141, 64, 31, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (142, 18, 32, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (143, 20, 8, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (144, 21, 8, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (145, 22, 8, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (146, 23, 8, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (147, 24, 8, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (148, 98, 33, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (149, 12, 33, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (150, 32, 33, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (151, 98, 34, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (152, 12, 34, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (153, 32, 34, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (154, 98, 35, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (155, 190, 14, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (156, 191, 41, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (157, 191, 19, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (158, 192, 14, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (159, 191, 15, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (160, 193, 14, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (161, 187, 54, true, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (162, 192, 54, true, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (163, 30, 54, true, '2010-11-14');
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (164, 30, 57, true, '2010-11-14');
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (36, 178, 45, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (165, 187, 57, true, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (166, 30, 58, true, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (167, 20, 59, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (168, 124, 59, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (169, 185, 59, false, NULL);
INSERT INTO lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) VALUES (170, 128, 60, false, NULL);


--
-- TOC entry 3627 (class 0 OID 332186)
-- Dependencies: 3203
-- Data for Name: vaccinations; Type: TABLE DATA; Schema: clin_vaccination; Owner: -
--

INSERT INTO vaccinations (pk, fk_vaccine, fk_schedule, fk_site, fk_laterality, date_given, serial_no, fk_progressnote) VALUES (25, 128, 15, 2, 1, '21/11/2010', 'Boostrix - SN1', 504);
INSERT INTO vaccinations (pk, fk_vaccine, fk_schedule, fk_site, fk_laterality, date_given, serial_no, fk_progressnote) VALUES (26, 128, 15, 2, 1, '21/11/2010', 'Boostrix - SN2', 505);
INSERT INTO vaccinations (pk, fk_vaccine, fk_schedule, fk_site, fk_laterality, date_given, serial_no, fk_progressnote) VALUES (27, 128, 15, 2, 1, '21/11/2010', 'Boostrix - SN2', 506);
INSERT INTO vaccinations (pk, fk_vaccine, fk_schedule, fk_site, fk_laterality, date_given, serial_no, fk_progressnote) VALUES (28, 185, 59, 3, 1, '21/11/2010', 'Gardasil-SN1', 507);
INSERT INTO vaccinations (pk, fk_vaccine, fk_schedule, fk_site, fk_laterality, date_given, serial_no, fk_progressnote) VALUES (29, 20, 59, 2, 2, '21/11/2010', 'HB-Vax-SN1', 507);
INSERT INTO vaccinations (pk, fk_vaccine, fk_schedule, fk_site, fk_laterality, date_given, serial_no, fk_progressnote) VALUES (30, 124, 59, 4, 2, '21/11/2010', 'Varilrix-SN1', 507);
INSERT INTO vaccinations (pk, fk_vaccine, fk_schedule, fk_site, fk_laterality, date_given, serial_no, fk_progressnote) VALUES (31, 128, 15, 1, 2, '21/11/2010', 'Boostrix - SN4', 508);
INSERT INTO vaccinations (pk, fk_vaccine, fk_schedule, fk_site, fk_laterality, date_given, serial_no, fk_progressnote) VALUES (22, 42, 26, 2, 1, '24/11/2010', 'Plaque SN1', 509);


--
-- TOC entry 3632 (class 0 OID 332233)
-- Dependencies: 3213
-- Data for Name: vaccine_serial_numbers; Type: TABLE DATA; Schema: clin_vaccination; Owner: -
--

INSERT INTO vaccine_serial_numbers (pk, fk_vaccine, serial_number, date_used) VALUES (10, 128, 'Boostrix - SN2', '2010-11-21');
INSERT INTO vaccine_serial_numbers (pk, fk_vaccine, serial_number, date_used) VALUES (11, 185, 'Gardasil-SN1', '2010-11-21');
INSERT INTO vaccine_serial_numbers (pk, fk_vaccine, serial_number, date_used) VALUES (12, 20, 'HB-Vax-SN1', '2010-11-21');
INSERT INTO vaccine_serial_numbers (pk, fk_vaccine, serial_number, date_used) VALUES (13, 124, 'Varilrix-SN1', '2010-11-21');
INSERT INTO vaccine_serial_numbers (pk, fk_vaccine, serial_number, date_used) VALUES (9, 128, 'Boostrix - SN1', '2010-11-21');
INSERT INTO vaccine_serial_numbers (pk, fk_vaccine, serial_number, date_used) VALUES (14, 128, 'Boostrix - SN3', '2010-11-21');
INSERT INTO vaccine_serial_numbers (pk, fk_vaccine, serial_number, date_used) VALUES (15, 128, 'Boostrix - SN4', '2010-11-21');
INSERT INTO vaccine_serial_numbers (pk, fk_vaccine, serial_number, date_used) VALUES (19, 42, 'Plaque SN1', '2010-11-24');


--
-- TOC entry 3616 (class 2606 OID 332262)
-- Dependencies: 3203 3203
-- Name: data_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY vaccinations
    ADD CONSTRAINT data_pkey PRIMARY KEY (pk);


--
-- TOC entry 3620 (class 2606 OID 332264)
-- Dependencies: 3206 3206
-- Name: lu_schedules_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_schedules
    ADD CONSTRAINT lu_schedules_pkey PRIMARY KEY (pk);


--
-- TOC entry 3618 (class 2606 OID 332266)
-- Dependencies: 3205 3205
-- Name: lu_vaccines_descriptions_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_descriptions
    ADD CONSTRAINT lu_vaccines_descriptions_pkey PRIMARY KEY (pk);


--
-- TOC entry 3624 (class 2606 OID 332268)
-- Dependencies: 3210 3210
-- Name: lu_vaccines_in_schedule_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_vaccines_in_schedule
    ADD CONSTRAINT lu_vaccines_in_schedule_pkey PRIMARY KEY (pk);


--
-- TOC entry 3622 (class 2606 OID 332270)
-- Dependencies: 3208 3208
-- Name: lu_vaccines_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_vaccines
    ADD CONSTRAINT lu_vaccines_pkey PRIMARY KEY (pk);


--
-- TOC entry 3626 (class 2606 OID 332272)
-- Dependencies: 3213 3213
-- Name: vaccine_serial_numbers_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY vaccine_serial_numbers
    ADD CONSTRAINT vaccine_serial_numbers_pkey PRIMARY KEY (pk);


--
-- TOC entry 3636 (class 0 OID 0)
-- Dependencies: 10
-- Name: clin_vaccination; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA clin_vaccination FROM PUBLIC;
REVOKE ALL ON SCHEMA clin_vaccination FROM richard;
GRANT ALL ON SCHEMA clin_vaccination TO richard;
GRANT ALL ON SCHEMA clin_vaccination TO easygp;
GRANT USAGE ON SCHEMA clin_vaccination TO staff;


--
-- TOC entry 3638 (class 0 OID 0)
-- Dependencies: 3203
-- Name: vaccinations; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE vaccinations FROM PUBLIC;
REVOKE ALL ON TABLE vaccinations FROM richard;
GRANT ALL ON TABLE vaccinations TO richard;
GRANT ALL ON TABLE vaccinations TO easygp;
GRANT ALL ON TABLE vaccinations TO staff;


--
-- TOC entry 3641 (class 0 OID 0)
-- Dependencies: 3204
-- Name: data_pk_seq; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON SEQUENCE data_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE data_pk_seq FROM richard;
GRANT ALL ON SEQUENCE data_pk_seq TO richard;
GRANT ALL ON SEQUENCE data_pk_seq TO easygp;
GRANT USAGE ON SEQUENCE data_pk_seq TO staff;


--
-- TOC entry 3643 (class 0 OID 0)
-- Dependencies: 3205
-- Name: lu_descriptions; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE lu_descriptions FROM PUBLIC;
REVOKE ALL ON TABLE lu_descriptions FROM richard;
GRANT ALL ON TABLE lu_descriptions TO richard;
GRANT ALL ON TABLE lu_descriptions TO easygp;
GRANT ALL ON TABLE lu_descriptions TO staff;


--
-- TOC entry 3650 (class 0 OID 0)
-- Dependencies: 3206
-- Name: lu_schedules; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE lu_schedules FROM PUBLIC;
REVOKE ALL ON TABLE lu_schedules FROM richard;
GRANT ALL ON TABLE lu_schedules TO richard;
GRANT ALL ON TABLE lu_schedules TO easygp;
GRANT SELECT ON TABLE lu_schedules TO staff;


--
-- TOC entry 3653 (class 0 OID 0)
-- Dependencies: 3207
-- Name: lu_schedules_pk_seq; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON SEQUENCE lu_schedules_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_schedules_pk_seq FROM richard;
GRANT ALL ON SEQUENCE lu_schedules_pk_seq TO richard;
GRANT ALL ON SEQUENCE lu_schedules_pk_seq TO easygp;
GRANT USAGE ON SEQUENCE lu_schedules_pk_seq TO staff;


--
-- TOC entry 3655 (class 0 OID 0)
-- Dependencies: 3208
-- Name: lu_vaccines; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE lu_vaccines FROM PUBLIC;
REVOKE ALL ON TABLE lu_vaccines FROM richard;
GRANT ALL ON TABLE lu_vaccines TO richard;
GRANT ALL ON TABLE lu_vaccines TO easygp;
GRANT ALL ON TABLE lu_vaccines TO staff;


--
-- TOC entry 3658 (class 0 OID 0)
-- Dependencies: 3210
-- Name: lu_vaccines_in_schedule; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE lu_vaccines_in_schedule FROM PUBLIC;
REVOKE ALL ON TABLE lu_vaccines_in_schedule FROM richard;
GRANT ALL ON TABLE lu_vaccines_in_schedule TO richard;
GRANT ALL ON TABLE lu_vaccines_in_schedule TO easygp;
GRANT ALL ON TABLE lu_vaccines_in_schedule TO staff;


--
-- TOC entry 3664 (class 0 OID 0)
-- Dependencies: 3213
-- Name: vaccine_serial_numbers; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE vaccine_serial_numbers FROM PUBLIC;
REVOKE ALL ON TABLE vaccine_serial_numbers FROM richard;
GRANT ALL ON TABLE vaccine_serial_numbers TO richard;
GRANT ALL ON TABLE vaccine_serial_numbers TO postgres;
GRANT ALL ON TABLE vaccine_serial_numbers TO easygp;
GRANT ALL ON TABLE vaccine_serial_numbers TO staff;


--
-- TOC entry 3667 (class 0 OID 0)
-- Dependencies: 3215
-- Name: vwvaccines; Type: ACL; Schema: clin_vaccination; Owner: -
--

REVOKE ALL ON TABLE vwvaccines FROM PUBLIC;
REVOKE ALL ON TABLE vwvaccines FROM richard;
GRANT ALL ON TABLE vwvaccines TO richard;
GRANT ALL ON TABLE vwvaccines TO easygp;
GRANT ALL ON TABLE vwvaccines TO staff;


-- Completed on 2010-12-03 08:24:52 EST

--
-- PostgreSQL database dump complete
--

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 43);