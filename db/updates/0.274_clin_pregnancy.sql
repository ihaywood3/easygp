DROP SCHEMA CLIN_PREGNANCY CASCADE;
--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.9
-- Dumped by pg_dump version 9.1.9
-- Started on 2013-04-28 12:13:21 EST

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 32 (class 2615 OID 20650)
-- Name: clin_pregnancy; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA clin_pregnancy;


SET search_path = clin_pregnancy, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 516 (class 1259 OID 22153)
-- Dependencies: 4168 4169 4170 4171 4172 4173 4174 4175 4176 4177 4178 4179 4180 4181 4182 4183 4184 4185 4186 4187 4188 4189 4190 4191 4192 4193 4194 4195 4196 4197 4198 4199 4200 4201 4202 4203 4204 4205 4206 4207 4208 32
-- Name: ante_natal_care_summary; Type: TABLE; Schema: clin_pregnancy; Owner: -; Tablespace: 
--

CREATE TABLE ante_natal_care_summary (
    pk integer NOT NULL,
    fk_consult integer NOT NULL,
    fk_progressnote integer NOT NULL,
    lmp date,
    lmp_normal boolean DEFAULT true,
    lmp_sure boolean DEFAULT true,
    age_menarche integer,
    cycle_length integer,
    cycle_regular boolean DEFAULT true,
    pregnancy_planned boolean DEFAULT true,
    date_contraception_stopped date,
    infertility_problems boolean DEFAULT false,
    prenatal_diagnosis_counselling boolean DEFAULT false,
    fk_religion integer,
    fk_subreligion integer,
    accommodation text,
    family_doctor text,
    fk_staff_caring integer,
    family_doctor_address text,
    family_doctor_town text,
    family_doctor_phone text,
    spouse_name text,
    spouse_birthdate date,
    spouse_age integer,
    spouse_fk_country_birth text,
    spouse_fk_occupation integer,
    spouse_fk_ethnicity integer,
    past_health_heart boolean DEFAULT false,
    past_health_back_problems boolean DEFAULT false,
    past_health_renal_uti boolean DEFAULT false,
    past_health_transfusioni boolean DEFAULT false,
    past_health_hypertension boolean DEFAULT false,
    past_health_asthma boolean DEFAULT false,
    past_health_mental_health boolean DEFAULT false,
    past_health_migraine boolean DEFAULT false,
    past_health_epilepsy boolean DEFAULT false,
    past_health_std boolean DEFAULT false,
    past_health_viral_illness boolean DEFAULT false,
    past_health_hepatitis_git boolean DEFAULT false,
    past_health_more_than_three_miscarriages boolean DEFAULT false,
    past_health_caesarians boolean DEFAULT false,
    allergy_latex boolean DEFAULT false,
    allergy_foods text,
    allergy_drugs text,
    family_history_summary text,
    family_history_hypertension boolean DEFAULT false,
    family_history_diabetes boolean DEFAULT false,
    family_history_tb boolean DEFAULT false,
    family_history_convulsions boolean DEFAULT false,
    family_history_birth_defects boolean DEFAULT false,
    family_history_genetic_disorders boolean DEFAULT false,
    family_history_depression boolean DEFAULT false,
    family_history_stillbirth boolean DEFAULT false,
    family_history_drugandalcohol boolean DEFAULT false,
    habits_smoking_number_per_day integer,
    habits_smoking_weeks_pregnancy_ceased integer,
    habits_alcohol_grams_per_day integer,
    household_smoker boolean DEFAULT false,
    habits_methadone boolean DEFAULT false,
    habits_thc boolean DEFAULT false,
    habits_vitamins boolean DEFAULT false,
    habits_heroin boolean DEFAULT false,
    habits_amphetamines boolean DEFAULT false,
    habits_herbal_meds boolean DEFAULT false,
    habits_nos text,
    edc date NOT NULL,
    edc_revised boolean DEFAULT false,
    fk_staff_first_exam integer NOT NULL,
    first_exam_date date NOT NULL,
    first_exam_gestation_weeks integer NOT NULL,
    first_exam_height numeric,
    first_exam_weight numeric,
    first_exam_bmi numeric,
    first_exam_pulse integer,
    first_exam_pulse_regular boolean DEFAULT true,
    first_exam_bp text,
    first_exam_heart_sounds text,
    first_exam_varicosities boolean DEFAULT false,
    first_exam_chest text,
    first_exam_breast text,
    first_exam_other_system text,
    first_exam_vaginal_exam boolean DEFAULT false,
    first_exam_vaginal_findings text,
    first_exam_cervix text,
    first_exam_pap_smear text,
    first_exam_urinalysis text,
    first_exam_abdomen text,
    first_exam_general_comments text,
    latex text
);


--
-- TOC entry 4273 (class 0 OID 0)
-- Dependencies: 516
-- Name: TABLE ante_natal_care_summary; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON TABLE ante_natal_care_summary IS 'mmm.... like it or not and you won''t this is the Hunter Area Health Service Ante-natal Care sheet, first draft';


--
-- TOC entry 4274 (class 0 OID 0)
-- Dependencies: 516
-- Name: COLUMN ante_natal_care_summary.accommodation; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN ante_natal_care_summary.accommodation IS 'the nature of the pregnant women''s accomodation';


--
-- TOC entry 4275 (class 0 OID 0)
-- Dependencies: 516
-- Name: COLUMN ante_natal_care_summary.fk_staff_caring; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN ante_natal_care_summary.fk_staff_caring IS 'if not null the staff member looking after the pregnancy';


--
-- TOC entry 4276 (class 0 OID 0)
-- Dependencies: 516
-- Name: COLUMN ante_natal_care_summary.latex; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN ante_natal_care_summary.latex IS 'the latex of the ante-natal record sheet';


--
-- TOC entry 517 (class 1259 OID 22200)
-- Dependencies: 516 32
-- Name: ante_natal_care_summary_pk_seq; Type: SEQUENCE; Schema: clin_pregnancy; Owner: -
--

CREATE SEQUENCE ante_natal_care_summary_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4278 (class 0 OID 0)
-- Dependencies: 517
-- Name: ante_natal_care_summary_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_pregnancy; Owner: -
--

ALTER SEQUENCE ante_natal_care_summary_pk_seq OWNED BY ante_natal_care_summary.pk;


--
-- TOC entry 518 (class 1259 OID 22202)
-- Dependencies: 4210 4211 32
-- Name: ante_natal_visits; Type: TABLE; Schema: clin_pregnancy; Owner: -; Tablespace: 
--

CREATE TABLE ante_natal_visits (
    pk integer NOT NULL,
    fk_consult integer NOT NULL,
    fk_pregnancy integer NOT NULL,
    visit_date date NOT NULL,
    duration_weeks text NOT NULL,
    fundal_height integer,
    fk_lu_presentation integer NOT NULL,
    foetal_heart_heard boolean DEFAULT false,
    urinalysis text,
    bloodpressure text,
    weight numeric,
    foetal_movements_felt boolean DEFAULT false,
    notes text
);


--
-- TOC entry 4279 (class 0 OID 0)
-- Dependencies: 518
-- Name: COLUMN ante_natal_visits.duration_weeks; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN ante_natal_visits.duration_weeks IS 'Can be an integer value eg 32 or text eg 32W 3D';


--
-- TOC entry 4280 (class 0 OID 0)
-- Dependencies: 518
-- Name: COLUMN ante_natal_visits.fundal_height; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN ante_natal_visits.fundal_height IS 'may not be palpable hence defaults to null';


--
-- TOC entry 519 (class 1259 OID 22210)
-- Dependencies: 518 32
-- Name: ante_natal_visits_pk_seq; Type: SEQUENCE; Schema: clin_pregnancy; Owner: -
--

CREATE SEQUENCE ante_natal_visits_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4282 (class 0 OID 0)
-- Dependencies: 519
-- Name: ante_natal_visits_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_pregnancy; Owner: -
--

ALTER SEQUENCE ante_natal_visits_pk_seq OWNED BY ante_natal_visits.pk;


--
-- TOC entry 520 (class 1259 OID 22212)
-- Dependencies: 32
-- Name: edc; Type: TABLE; Schema: clin_pregnancy; Owner: -; Tablespace: 
--

CREATE TABLE edc (
    pk integer NOT NULL,
    edc date NOT NULL,
    edc_comment text
);


--
-- TOC entry 4283 (class 0 OID 0)
-- Dependencies: 520
-- Name: TABLE edc; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON TABLE edc IS 'The current date of confinement. We do not keep the edc in the primary pregnancy table
      because it can be constantly revised.This table keeps track Of the reasons ';


--
-- TOC entry 4284 (class 0 OID 0)
-- Dependencies: 520
-- Name: COLUMN edc.edc_comment; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN edc.edc_comment IS 'any comment on the edc eg why the edc was revised';


--
-- TOC entry 521 (class 1259 OID 22218)
-- Dependencies: 520 32
-- Name: edc_pk_seq; Type: SEQUENCE; Schema: clin_pregnancy; Owner: -
--

CREATE SEQUENCE edc_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4286 (class 0 OID 0)
-- Dependencies: 521
-- Name: edc_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_pregnancy; Owner: -
--

ALTER SEQUENCE edc_pk_seq OWNED BY edc.pk;


--
-- TOC entry 522 (class 1259 OID 22220)
-- Dependencies: 32
-- Name: lu_delivery_types; Type: TABLE; Schema: clin_pregnancy; Owner: -; Tablespace: 
--

CREATE TABLE lu_delivery_types (
    pk integer NOT NULL,
    type text NOT NULL
);


--
-- TOC entry 523 (class 1259 OID 22226)
-- Dependencies: 522 32
-- Name: lu_delivery_types_pk_seq; Type: SEQUENCE; Schema: clin_pregnancy; Owner: -
--

CREATE SEQUENCE lu_delivery_types_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4288 (class 0 OID 0)
-- Dependencies: 523
-- Name: lu_delivery_types_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_pregnancy; Owner: -
--

ALTER SEQUENCE lu_delivery_types_pk_seq OWNED BY lu_delivery_types.pk;


--
-- TOC entry 524 (class 1259 OID 22228)
-- Dependencies: 32
-- Name: lu_onset_labour; Type: TABLE; Schema: clin_pregnancy; Owner: -; Tablespace: 
--

CREATE TABLE lu_onset_labour (
    pk integer NOT NULL,
    type text NOT NULL
);


--
-- TOC entry 525 (class 1259 OID 22234)
-- Dependencies: 524 32
-- Name: lu_onset_labour_pk_seq; Type: SEQUENCE; Schema: clin_pregnancy; Owner: -
--

CREATE SEQUENCE lu_onset_labour_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4290 (class 0 OID 0)
-- Dependencies: 525
-- Name: lu_onset_labour_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_pregnancy; Owner: -
--

ALTER SEQUENCE lu_onset_labour_pk_seq OWNED BY lu_onset_labour.pk;


--
-- TOC entry 526 (class 1259 OID 22236)
-- Dependencies: 32
-- Name: lu_presentations; Type: TABLE; Schema: clin_pregnancy; Owner: -; Tablespace: 
--

CREATE TABLE lu_presentations (
    pk integer NOT NULL,
    presentation text NOT NULL
);


--
-- TOC entry 527 (class 1259 OID 22242)
-- Dependencies: 526 32
-- Name: lu_presentations_pk_seq; Type: SEQUENCE; Schema: clin_pregnancy; Owner: -
--

CREATE SEQUENCE lu_presentations_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4292 (class 0 OID 0)
-- Dependencies: 527
-- Name: lu_presentations_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_pregnancy; Owner: -
--

ALTER SEQUENCE lu_presentations_pk_seq OWNED BY lu_presentations.pk;


--
-- TOC entry 528 (class 1259 OID 22244)
-- Dependencies: 4217 4218 4219 4220 4221 4222 4223 32
-- Name: pregnancies; Type: TABLE; Schema: clin_pregnancy; Owner: -; Tablespace: 
--

CREATE TABLE pregnancies (
    pk integer NOT NULL,
    fk_consult integer NOT NULL,
    lmp text,
    edc date,
    edc_revised boolean DEFAULT false,
    date_anti_d date,
    anti_d_given boolean DEFAULT false,
    date_gtt date,
    notes text,
    gestation integer,
    nuchal_fold_scan_date date,
    morphology_scan_date date,
    last_presentation text,
    risk_factor_smoking boolean DEFAULT false,
    risk_factor_smoking_details text,
    risk_factor_alcohol boolean DEFAULT false,
    risk_factor_alcohol_details text,
    risk_factor_drugs boolean DEFAULT false,
    risk_factor_drugs_details text,
    risk_factor_social boolean DEFAULT false,
    risk_factor_social_details text,
    risk_factor_mental_health boolean DEFAULT false,
    risk_factor_mental_health_details text,
    age_at_delivery integer,
    date_delivery text,
    gestation_at_delivery integer,
    fk_lu_onset_labour integer,
    labour_hours numeric,
    fk_lu_delivery_type integer,
    complications text,
    fk_lu_sex integer,
    birthweight numeric,
    baby_name text,
    peurperium text
);


--
-- TOC entry 4293 (class 0 OID 0)
-- Dependencies: 528
-- Name: TABLE pregnancies; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON TABLE pregnancies IS 'The ''core'' data about a pregnancy
  This table probably seems Odd, it may contain nothing but a primary key
  And say a month/year or date as date_delivery, a baby_sex etc ';


--
-- TOC entry 4294 (class 0 OID 0)
-- Dependencies: 528
-- Name: COLUMN pregnancies.lmp; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN pregnancies.lmp IS 'the last period date if known, can be free text or null';


--
-- TOC entry 4295 (class 0 OID 0)
-- Dependencies: 528
-- Name: COLUMN pregnancies.edc; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN pregnancies.edc IS 'the estimated date of confinement can initially be null';


--
-- TOC entry 4296 (class 0 OID 0)
-- Dependencies: 528
-- Name: COLUMN pregnancies.edc_revised; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN pregnancies.edc_revised IS 'if true the edc has been revised';


--
-- TOC entry 4297 (class 0 OID 0)
-- Dependencies: 528
-- Name: COLUMN pregnancies.notes; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN pregnancies.notes IS 'general notes on the pregnancy, could include summary of complications';


--
-- TOC entry 4298 (class 0 OID 0)
-- Dependencies: 528
-- Name: COLUMN pregnancies.gestation; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN pregnancies.gestation IS 'the gestation in weeks';


--
-- TOC entry 4299 (class 0 OID 0)
-- Dependencies: 528
-- Name: COLUMN pregnancies.age_at_delivery; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN pregnancies.age_at_delivery IS 'a deliberately vague column for recording past history of pregnancies
  e.g could have say TOP at age 18yrs';


--
-- TOC entry 4300 (class 0 OID 0)
-- Dependencies: 528
-- Name: COLUMN pregnancies.date_delivery; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN pregnancies.date_delivery IS 'As we may be recording bare details about past pregnancies where dates are not known accept year or mm/yyyy or proper date';


--
-- TOC entry 4301 (class 0 OID 0)
-- Dependencies: 528
-- Name: COLUMN pregnancies.peurperium; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN pregnancies.peurperium IS 'any complications after birth e.g problems with infant feeding, mothers mood, depression etc';


--
-- TOC entry 529 (class 1259 OID 22257)
-- Dependencies: 528 32
-- Name: pregnancies_pk_seq; Type: SEQUENCE; Schema: clin_pregnancy; Owner: -
--

CREATE SEQUENCE pregnancies_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4303 (class 0 OID 0)
-- Dependencies: 529
-- Name: pregnancies_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_pregnancy; Owner: -
--

ALTER SEQUENCE pregnancies_pk_seq OWNED BY pregnancies.pk;


--
-- TOC entry 530 (class 1259 OID 22259)
-- Dependencies: 32
-- Name: scans; Type: TABLE; Schema: clin_pregnancy; Owner: -; Tablespace: 
--

CREATE TABLE scans (
    pk integer NOT NULL,
    fk_pregnancy integer NOT NULL,
    fk_document integer,
    scan_date text NOT NULL,
    fk_blob integer,
    summary_findings text NOT NULL
);


--
-- TOC entry 4304 (class 0 OID 0)
-- Dependencies: 530
-- Name: TABLE scans; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON TABLE scans IS 'contains information about pregnancy scans';


--
-- TOC entry 4305 (class 0 OID 0)
-- Dependencies: 530
-- Name: COLUMN scans.fk_document; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN scans.fk_document IS 'if not null the scan is a document in our system key to documents.documents table';


--
-- TOC entry 4306 (class 0 OID 0)
-- Dependencies: 530
-- Name: COLUMN scans.scan_date; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN scans.scan_date IS 'this is a text field because patient may have had scan elsewhere, not know the date';


--
-- TOC entry 4307 (class 0 OID 0)
-- Dependencies: 530
-- Name: COLUMN scans.fk_blob; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN scans.fk_blob IS 'if not null, the key to blobs.images table containing picture of the scan';


--
-- TOC entry 531 (class 1259 OID 22265)
-- Dependencies: 530 32
-- Name: scans_pk_seq; Type: SEQUENCE; Schema: clin_pregnancy; Owner: -
--

CREATE SEQUENCE scans_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4309 (class 0 OID 0)
-- Dependencies: 531
-- Name: scans_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_pregnancy; Owner: -
--

ALTER SEQUENCE scans_pk_seq OWNED BY scans.pk;


--
-- TOC entry 532 (class 1259 OID 22267)
-- Dependencies: 4098 32
-- Name: vwantenatal_visits; Type: VIEW; Schema: clin_pregnancy; Owner: -
--

CREATE VIEW vwantenatal_visits AS
    SELECT ante_natal_visits.pk AS pk_antenatal_visit, lu_presentations.presentation, ante_natal_visits.fk_consult, consult.fk_patient, ante_natal_visits.fk_pregnancy, ante_natal_visits.visit_date, ante_natal_visits.duration_weeks, ante_natal_visits.fundal_height, ante_natal_visits.fk_lu_presentation, ante_natal_visits.foetal_heart_heard, ante_natal_visits.urinalysis, ante_natal_visits.bloodpressure, ante_natal_visits.weight, ante_natal_visits.foetal_movements_felt, ante_natal_visits.notes, pregnancies.edc, pregnancies.edc_revised FROM ante_natal_visits, lu_presentations, clin_consult.consult, pregnancies WHERE (((ante_natal_visits.fk_lu_presentation = lu_presentations.pk) AND (ante_natal_visits.fk_consult = consult.pk)) AND (ante_natal_visits.fk_pregnancy = pregnancies.pk));


--
-- TOC entry 533 (class 1259 OID 22272)
-- Dependencies: 4099 32
-- Name: vwpregnancies; Type: VIEW; Schema: clin_pregnancy; Owner: -
--

CREATE VIEW vwpregnancies AS
    SELECT consult.fk_patient, pregnancies.pk AS fk_pregnancy, pregnancies.pk, pregnancies.fk_consult, pregnancies.lmp, pregnancies.edc, pregnancies.edc_revised, pregnancies.date_anti_d, pregnancies.anti_d_given, pregnancies.date_gtt, pregnancies.notes, pregnancies.gestation, pregnancies.nuchal_fold_scan_date, pregnancies.morphology_scan_date, pregnancies.last_presentation, pregnancies.risk_factor_smoking, pregnancies.risk_factor_smoking_details, pregnancies.risk_factor_alcohol, pregnancies.risk_factor_alcohol_details, pregnancies.risk_factor_drugs, pregnancies.risk_factor_drugs_details, pregnancies.risk_factor_social, pregnancies.risk_factor_social_details, pregnancies.risk_factor_mental_health, pregnancies.risk_factor_mental_health_details, pregnancies.age_at_delivery, pregnancies.date_delivery, pregnancies.gestation_at_delivery, pregnancies.fk_lu_onset_labour, pregnancies.labour_hours, pregnancies.fk_lu_delivery_type, pregnancies.complications, pregnancies.fk_lu_sex, pregnancies.birthweight, pregnancies.
baby_name, pregnancies.peurperium, lu_delivery_types.type AS delivery_type, lu_onset_labour.type AS onset_labour_type, lu_sex.sex_text AS baby_sex FROM ((((pregnancies JOIN clin_consult.consult ON ((pregnancies.fk_consult = consult.pk))) LEFT JOIN lu_onset_labour ON ((pregnancies.fk_lu_onset_labour = lu_onset_labour.pk))) LEFT JOIN lu_delivery_types ON ((pregnancies.fk_lu_delivery_type = lu_delivery_types.pk))) LEFT JOIN contacts.lu_sex ON ((pregnancies.fk_lu_sex = lu_sex.pk)));


--
-- TOC entry 4209 (class 2604 OID 23889)
-- Dependencies: 517 516
-- Name: pk; Type: DEFAULT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY ante_natal_care_summary ALTER COLUMN pk SET DEFAULT nextval('ante_natal_care_summary_pk_seq'::regclass);


--
-- TOC entry 4212 (class 2604 OID 23890)
-- Dependencies: 519 518
-- Name: pk; Type: DEFAULT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY ante_natal_visits ALTER COLUMN pk SET DEFAULT nextval('ante_natal_visits_pk_seq'::regclass);


--
-- TOC entry 4213 (class 2604 OID 23891)
-- Dependencies: 521 520
-- Name: pk; Type: DEFAULT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY edc ALTER COLUMN pk SET DEFAULT nextval('edc_pk_seq'::regclass);


--
-- TOC entry 4214 (class 2604 OID 23892)
-- Dependencies: 523 522
-- Name: pk; Type: DEFAULT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY lu_delivery_types ALTER COLUMN pk SET DEFAULT nextval('lu_delivery_types_pk_seq'::regclass);


--
-- TOC entry 4215 (class 2604 OID 23893)
-- Dependencies: 525 524
-- Name: pk; Type: DEFAULT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY lu_onset_labour ALTER COLUMN pk SET DEFAULT nextval('lu_onset_labour_pk_seq'::regclass);


--
-- TOC entry 4216 (class 2604 OID 23894)
-- Dependencies: 527 526
-- Name: pk; Type: DEFAULT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY lu_presentations ALTER COLUMN pk SET DEFAULT nextval('lu_presentations_pk_seq'::regclass);


--
-- TOC entry 4224 (class 2604 OID 23895)
-- Dependencies: 529 528
-- Name: pk; Type: DEFAULT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY pregnancies ALTER COLUMN pk SET DEFAULT nextval('pregnancies_pk_seq'::regclass);


--
-- TOC entry 4225 (class 2604 OID 23896)
-- Dependencies: 531 530
-- Name: pk; Type: DEFAULT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY scans ALTER COLUMN pk SET DEFAULT nextval('scans_pk_seq'::regclass);


--
-- TOC entry 4252 (class 0 OID 22153)
-- Dependencies: 516 4268
-- Data for Name: ante_natal_care_summary; Type: TABLE DATA; Schema: clin_pregnancy; Owner: -
--



--
-- TOC entry 4312 (class 0 OID 0)
-- Dependencies: 517
-- Name: ante_natal_care_summary_pk_seq; Type: SEQUENCE SET; Schema: clin_pregnancy; Owner: -
--

SELECT pg_catalog.setval('ante_natal_care_summary_pk_seq', 1, false);


--
-- TOC entry 4254 (class 0 OID 22202)
-- Dependencies: 518 4268
-- Data for Name: ante_natal_visits; Type: TABLE DATA; Schema: clin_pregnancy; Owner: -
--



--
-- TOC entry 4313 (class 0 OID 0)
-- Dependencies: 519
-- Name: ante_natal_visits_pk_seq; Type: SEQUENCE SET; Schema: clin_pregnancy; Owner: -
--

SELECT pg_catalog.setval('ante_natal_visits_pk_seq', 1, false);


--
-- TOC entry 4256 (class 0 OID 22212)
-- Dependencies: 520 4268
-- Data for Name: edc; Type: TABLE DATA; Schema: clin_pregnancy; Owner: -
--



--
-- TOC entry 4314 (class 0 OID 0)
-- Dependencies: 521
-- Name: edc_pk_seq; Type: SEQUENCE SET; Schema: clin_pregnancy; Owner: -
--

SELECT pg_catalog.setval('edc_pk_seq', 1, false);


--
-- TOC entry 4258 (class 0 OID 22220)
-- Dependencies: 522 4268
-- Data for Name: lu_delivery_types; Type: TABLE DATA; Schema: clin_pregnancy; Owner: -
--

INSERT INTO lu_delivery_types VALUES (1, 'n/a');
INSERT INTO lu_delivery_types VALUES (2, 'vaginal - spontaneous');
INSERT INTO lu_delivery_types VALUES (3, 'vaginal - forceps');
INSERT INTO lu_delivery_types VALUES (4, 'vaginal - breech');
INSERT INTO lu_delivery_types VALUES (5, 'caesarian section');


--
-- TOC entry 4315 (class 0 OID 0)
-- Dependencies: 523
-- Name: lu_delivery_types_pk_seq; Type: SEQUENCE SET; Schema: clin_pregnancy; Owner: -
--

SELECT pg_catalog.setval('lu_delivery_types_pk_seq', 5, true);


--
-- TOC entry 4260 (class 0 OID 22228)
-- Dependencies: 524 4268
-- Data for Name: lu_onset_labour; Type: TABLE DATA; Schema: clin_pregnancy; Owner: -
--

INSERT INTO lu_onset_labour VALUES (1, 'n/a');
INSERT INTO lu_onset_labour VALUES (2, 'spontaneous');
INSERT INTO lu_onset_labour VALUES (3, 'induced');


--
-- TOC entry 4316 (class 0 OID 0)
-- Dependencies: 525
-- Name: lu_onset_labour_pk_seq; Type: SEQUENCE SET; Schema: clin_pregnancy; Owner: -
--

SELECT pg_catalog.setval('lu_onset_labour_pk_seq', 3, true);


--
-- TOC entry 4262 (class 0 OID 22236)
-- Dependencies: 526 4268
-- Data for Name: lu_presentations; Type: TABLE DATA; Schema: clin_pregnancy; Owner: -
--

INSERT INTO lu_presentations VALUES (1, 'n/a');
INSERT INTO lu_presentations VALUES (2, 'cephalic');
INSERT INTO lu_presentations VALUES (3, 'breech');
INSERT INTO lu_presentations VALUES (4, 'transverse');
INSERT INTO lu_presentations VALUES (5, 'unstable');


--
-- TOC entry 4317 (class 0 OID 0)
-- Dependencies: 527
-- Name: lu_presentations_pk_seq; Type: SEQUENCE SET; Schema: clin_pregnancy; Owner: -
--

SELECT pg_catalog.setval('lu_presentations_pk_seq', 5, true);


--
-- TOC entry 4264 (class 0 OID 22244)
-- Dependencies: 528 4268
-- Data for Name: pregnancies; Type: TABLE DATA; Schema: clin_pregnancy; Owner: -
--



--
-- TOC entry 4318 (class 0 OID 0)
-- Dependencies: 529
-- Name: pregnancies_pk_seq; Type: SEQUENCE SET; Schema: clin_pregnancy; Owner: -
--

SELECT pg_catalog.setval('pregnancies_pk_seq', 1, false);


--
-- TOC entry 4266 (class 0 OID 22259)
-- Dependencies: 530 4268
-- Data for Name: scans; Type: TABLE DATA; Schema: clin_pregnancy; Owner: -
--



--
-- TOC entry 4319 (class 0 OID 0)
-- Dependencies: 531
-- Name: scans_pk_seq; Type: SEQUENCE SET; Schema: clin_pregnancy; Owner: -
--

SELECT pg_catalog.setval('scans_pk_seq', 1, false);


--
-- TOC entry 4227 (class 2606 OID 38090)
-- Dependencies: 516 516 4269
-- Name: ante_natal_care_summary_pkey; Type: CONSTRAINT; Schema: clin_pregnancy; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ante_natal_care_summary
    ADD CONSTRAINT ante_natal_care_summary_pkey PRIMARY KEY (pk);


--
-- TOC entry 4229 (class 2606 OID 38092)
-- Dependencies: 518 518 4269
-- Name: ante_natal_visits_pkey; Type: CONSTRAINT; Schema: clin_pregnancy; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ante_natal_visits
    ADD CONSTRAINT ante_natal_visits_pkey PRIMARY KEY (pk);


--
-- TOC entry 4231 (class 2606 OID 38094)
-- Dependencies: 520 520 4269
-- Name: edc_pkey; Type: CONSTRAINT; Schema: clin_pregnancy; Owner: -; Tablespace: 
--

ALTER TABLE ONLY edc
    ADD CONSTRAINT edc_pkey PRIMARY KEY (pk);


--
-- TOC entry 4233 (class 2606 OID 38096)
-- Dependencies: 522 522 4269
-- Name: lu_delivery_types_pkey; Type: CONSTRAINT; Schema: clin_pregnancy; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_delivery_types
    ADD CONSTRAINT lu_delivery_types_pkey PRIMARY KEY (pk);


--
-- TOC entry 4235 (class 2606 OID 38098)
-- Dependencies: 524 524 4269
-- Name: lu_onset_labour_pkey; Type: CONSTRAINT; Schema: clin_pregnancy; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_onset_labour
    ADD CONSTRAINT lu_onset_labour_pkey PRIMARY KEY (pk);


--
-- TOC entry 4237 (class 2606 OID 38100)
-- Dependencies: 526 526 4269
-- Name: lu_presentations_pkey; Type: CONSTRAINT; Schema: clin_pregnancy; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_presentations
    ADD CONSTRAINT lu_presentations_pkey PRIMARY KEY (pk);


--
-- TOC entry 4239 (class 2606 OID 38102)
-- Dependencies: 528 528 4269
-- Name: pregnancies_pkey; Type: CONSTRAINT; Schema: clin_pregnancy; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pregnancies
    ADD CONSTRAINT pregnancies_pkey PRIMARY KEY (pk);


--
-- TOC entry 4241 (class 2606 OID 38104)
-- Dependencies: 530 530 4269
-- Name: scans_pkey; Type: CONSTRAINT; Schema: clin_pregnancy; Owner: -; Tablespace: 
--

ALTER TABLE ONLY scans
    ADD CONSTRAINT scans_pkey PRIMARY KEY (pk);


--
-- TOC entry 4246 (class 2606 OID 38663)
-- Dependencies: 289 518 4269
-- Name: ante_natal_visits_fk_consult_fkey; Type: FK CONSTRAINT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY ante_natal_visits
    ADD CONSTRAINT ante_natal_visits_fk_consult_fkey FOREIGN KEY (fk_consult) REFERENCES clin_consult.consult(pk);


--
-- TOC entry 4247 (class 2606 OID 38668)
-- Dependencies: 4236 526 518 4269
-- Name: ante_natal_visits_fk_lu_presentation_fkey; Type: FK CONSTRAINT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY ante_natal_visits
    ADD CONSTRAINT ante_natal_visits_fk_lu_presentation_fkey FOREIGN KEY (fk_lu_presentation) REFERENCES lu_presentations(pk);


--
-- TOC entry 4248 (class 2606 OID 38673)
-- Dependencies: 4238 528 518 4269
-- Name: ante_natal_visits_fk_pregnancies_fkey; Type: FK CONSTRAINT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY ante_natal_visits
    ADD CONSTRAINT ante_natal_visits_fk_pregnancies_fkey FOREIGN KEY (fk_pregnancy) REFERENCES pregnancies(pk);


--
-- TOC entry 4242 (class 2606 OID 38678)
-- Dependencies: 209 516 4269
-- Name: pregnancy_first_exam_fk_staff_caring_fkey; Type: FK CONSTRAINT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY ante_natal_care_summary
    ADD CONSTRAINT pregnancy_first_exam_fk_staff_caring_fkey FOREIGN KEY (fk_staff_caring) REFERENCES admin.staff(pk);


--
-- TOC entry 4243 (class 2606 OID 38683)
-- Dependencies: 209 516 4269
-- Name: pregnancy_first_exam_fk_staff_fkey; Type: FK CONSTRAINT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY ante_natal_care_summary
    ADD CONSTRAINT pregnancy_first_exam_fk_staff_fkey FOREIGN KEY (fk_staff_first_exam) REFERENCES admin.staff(pk);


--
-- TOC entry 4244 (class 2606 OID 38688)
-- Dependencies: 289 516 4269
-- Name: pregnancy_fk_consult_fkey; Type: FK CONSTRAINT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY ante_natal_care_summary
    ADD CONSTRAINT pregnancy_fk_consult_fkey FOREIGN KEY (fk_consult) REFERENCES clin_consult.consult(pk);


--
-- TOC entry 4245 (class 2606 OID 38693)
-- Dependencies: 310 516 4269
-- Name: pregnancy_fk_progressnote; Type: FK CONSTRAINT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY ante_natal_care_summary
    ADD CONSTRAINT pregnancy_fk_progressnote FOREIGN KEY (fk_progressnote) REFERENCES clin_consult.progressnotes(pk);


--
-- TOC entry 4249 (class 2606 OID 38698)
-- Dependencies: 286 530 4269
-- Name: scans_fk_blob_fkey; Type: FK CONSTRAINT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY scans
    ADD CONSTRAINT scans_fk_blob_fkey FOREIGN KEY (fk_blob) REFERENCES blobs.blobs(pk);


--
-- TOC entry 4250 (class 2606 OID 38703)
-- Dependencies: 608 530 4269
-- Name: scans_fk_document_fkey; Type: FK CONSTRAINT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY scans
    ADD CONSTRAINT scans_fk_document_fkey FOREIGN KEY (fk_document) REFERENCES documents.documents(pk);


--
-- TOC entry 4251 (class 2606 OID 38708)
-- Dependencies: 4226 516 530 4269
-- Name: scans_fk_pregnancy_fkey; Type: FK CONSTRAINT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY scans
    ADD CONSTRAINT scans_fk_pregnancy_fkey FOREIGN KEY (fk_pregnancy) REFERENCES ante_natal_care_summary(pk);


--
-- TOC entry 4272 (class 0 OID 0)
-- Dependencies: 32
-- Name: clin_pregnancy; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA clin_pregnancy FROM PUBLIC;
GRANT ALL ON SCHEMA clin_pregnancy TO easygp;
GRANT ALL ON SCHEMA clin_pregnancy TO staff;


--
-- TOC entry 4277 (class 0 OID 0)
-- Dependencies: 516
-- Name: ante_natal_care_summary; Type: ACL; Schema: clin_pregnancy; Owner: -
--

REVOKE ALL ON TABLE ante_natal_care_summary FROM PUBLIC;
GRANT ALL ON TABLE ante_natal_care_summary TO easygp;
GRANT ALL ON TABLE ante_natal_care_summary TO staff;


--
-- TOC entry 4281 (class 0 OID 0)
-- Dependencies: 518
-- Name: ante_natal_visits; Type: ACL; Schema: clin_pregnancy; Owner: -
--

REVOKE ALL ON TABLE ante_natal_visits FROM PUBLIC;
GRANT ALL ON TABLE ante_natal_visits TO easygp;
GRANT ALL ON TABLE ante_natal_visits TO staff;


--
-- TOC entry 4285 (class 0 OID 0)
-- Dependencies: 520
-- Name: edc; Type: ACL; Schema: clin_pregnancy; Owner: -
--

REVOKE ALL ON TABLE edc FROM PUBLIC;
GRANT ALL ON TABLE edc TO easygp;
GRANT ALL ON TABLE edc TO staff;


--
-- TOC entry 4287 (class 0 OID 0)
-- Dependencies: 522
-- Name: lu_delivery_types; Type: ACL; Schema: clin_pregnancy; Owner: -
--

REVOKE ALL ON TABLE lu_delivery_types FROM PUBLIC;
GRANT ALL ON TABLE lu_delivery_types TO easygp;
GRANT ALL ON TABLE lu_delivery_types TO staff;


--
-- TOC entry 4289 (class 0 OID 0)
-- Dependencies: 524
-- Name: lu_onset_labour; Type: ACL; Schema: clin_pregnancy; Owner: -
--

REVOKE ALL ON TABLE lu_onset_labour FROM PUBLIC;
GRANT ALL ON TABLE lu_onset_labour TO easygp;
GRANT ALL ON TABLE lu_onset_labour TO staff;


--
-- TOC entry 4291 (class 0 OID 0)
-- Dependencies: 526
-- Name: lu_presentations; Type: ACL; Schema: clin_pregnancy; Owner: -
--

REVOKE ALL ON TABLE lu_presentations FROM PUBLIC;
GRANT ALL ON TABLE lu_presentations TO easygp;
GRANT ALL ON TABLE lu_presentations TO staff;


--
-- TOC entry 4302 (class 0 OID 0)
-- Dependencies: 528
-- Name: pregnancies; Type: ACL; Schema: clin_pregnancy; Owner: -
--

REVOKE ALL ON TABLE pregnancies FROM PUBLIC;
GRANT ALL ON TABLE pregnancies TO easygp;
GRANT ALL ON TABLE pregnancies TO staff;


--
-- TOC entry 4308 (class 0 OID 0)
-- Dependencies: 530
-- Name: scans; Type: ACL; Schema: clin_pregnancy; Owner: -
--

REVOKE ALL ON TABLE scans FROM PUBLIC;
GRANT ALL ON TABLE scans TO easygp;
GRANT ALL ON TABLE scans TO staff;


--
-- TOC entry 4310 (class 0 OID 0)
-- Dependencies: 532
-- Name: vwantenatal_visits; Type: ACL; Schema: clin_pregnancy; Owner: -
--

REVOKE ALL ON TABLE vwantenatal_visits FROM PUBLIC;
GRANT ALL ON TABLE vwantenatal_visits TO easygp;
GRANT ALL ON TABLE vwantenatal_visits TO staff;


--
-- TOC entry 4311 (class 0 OID 0)
-- Dependencies: 533
-- Name: vwpregnancies; Type: ACL; Schema: clin_pregnancy; Owner: -
--

REVOKE ALL ON TABLE vwpregnancies FROM PUBLIC;
GRANT ALL ON TABLE vwpregnancies TO easygp;
GRANT ALL ON TABLE vwpregnancies TO staff;


-- Completed on 2013-04-28 12:13:21 EST

--
-- PostgreSQL database dump complete
--
truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 274);


