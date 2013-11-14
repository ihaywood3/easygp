--
-- PostgreSQL database dump
--
DROP SCHEMA clin_pregnancy CASCADE;
-- Dumped from database version 9.1.9
-- Dumped by pg_dump version 9.1.9
-- Started on 2013-11-14 15:15:26 EST

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 52 (class 2615 OID 61606)
-- Name: clin_pregnancy; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA clin_pregnancy;


SET search_path = clin_pregnancy, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 996 (class 1259 OID 61607)
-- Dependencies: 4520 4521 4522 4523 4524 4525 4526 4527 4528 4529 4530 4531 4532 4533 4534 4535 4536 4537 4538 4539 4540 4541 4542 4543 4544 4545 4546 4547 4548 4549 4550 4551 4552 4553 4554 4555 4556 4557 4558 4559 4560 52
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
-- TOC entry 4647 (class 0 OID 0)
-- Dependencies: 996
-- Name: TABLE ante_natal_care_summary; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON TABLE ante_natal_care_summary IS 'mmm.... like it or not and you won''t this is the Hunter Area Health Service Ante-natal Care sheet, first draft';


--
-- TOC entry 4648 (class 0 OID 0)
-- Dependencies: 996
-- Name: COLUMN ante_natal_care_summary.accommodation; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN ante_natal_care_summary.accommodation IS 'the nature of the pregnant women''s accomodation';


--
-- TOC entry 4649 (class 0 OID 0)
-- Dependencies: 996
-- Name: COLUMN ante_natal_care_summary.fk_staff_caring; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN ante_natal_care_summary.fk_staff_caring IS 'if not null the staff member looking after the pregnancy';


--
-- TOC entry 4650 (class 0 OID 0)
-- Dependencies: 996
-- Name: COLUMN ante_natal_care_summary.latex; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN ante_natal_care_summary.latex IS 'the latex of the ante-natal record sheet';


--
-- TOC entry 997 (class 1259 OID 61654)
-- Dependencies: 996 52
-- Name: ante_natal_care_summary_pk_seq; Type: SEQUENCE; Schema: clin_pregnancy; Owner: -
--

CREATE SEQUENCE ante_natal_care_summary_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4652 (class 0 OID 0)
-- Dependencies: 997
-- Name: ante_natal_care_summary_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_pregnancy; Owner: -
--

ALTER SEQUENCE ante_natal_care_summary_pk_seq OWNED BY ante_natal_care_summary.pk;


--
-- TOC entry 998 (class 1259 OID 61656)
-- Dependencies: 4562 4563 52
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
    notes text,
    foetal_heart_rate integer,
    fk_progressnote integer NOT NULL
);


--
-- TOC entry 4654 (class 0 OID 0)
-- Dependencies: 998
-- Name: COLUMN ante_natal_visits.duration_weeks; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN ante_natal_visits.duration_weeks IS 'Can be an integer value eg 32 or text eg 32W 3D';


--
-- TOC entry 4655 (class 0 OID 0)
-- Dependencies: 998
-- Name: COLUMN ante_natal_visits.fundal_height; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN ante_natal_visits.fundal_height IS 'may not be palpable hence defaults to null';


--
-- TOC entry 999 (class 1259 OID 61664)
-- Dependencies: 998 52
-- Name: ante_natal_visits_pk_seq; Type: SEQUENCE; Schema: clin_pregnancy; Owner: -
--

CREATE SEQUENCE ante_natal_visits_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4657 (class 0 OID 0)
-- Dependencies: 999
-- Name: ante_natal_visits_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_pregnancy; Owner: -
--

ALTER SEQUENCE ante_natal_visits_pk_seq OWNED BY ante_natal_visits.pk;


--
-- TOC entry 1000 (class 1259 OID 61666)
-- Dependencies: 52
-- Name: edc; Type: TABLE; Schema: clin_pregnancy; Owner: -; Tablespace: 
--

CREATE TABLE edc (
    pk integer NOT NULL,
    edc date NOT NULL,
    edc_comment text
);


--
-- TOC entry 4659 (class 0 OID 0)
-- Dependencies: 1000
-- Name: TABLE edc; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON TABLE edc IS 'The current date of confinement. We do not keep the edc in the primary pregnancy table
      because it can be constantly revised.This table keeps track Of the reasons ';


--
-- TOC entry 4660 (class 0 OID 0)
-- Dependencies: 1000
-- Name: COLUMN edc.edc_comment; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN edc.edc_comment IS 'any comment on the edc eg why the edc was revised';


--
-- TOC entry 1001 (class 1259 OID 61672)
-- Dependencies: 52 1000
-- Name: edc_pk_seq; Type: SEQUENCE; Schema: clin_pregnancy; Owner: -
--

CREATE SEQUENCE edc_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4662 (class 0 OID 0)
-- Dependencies: 1001
-- Name: edc_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_pregnancy; Owner: -
--

ALTER SEQUENCE edc_pk_seq OWNED BY edc.pk;


--
-- TOC entry 1002 (class 1259 OID 61674)
-- Dependencies: 52
-- Name: lu_ante_natal_diagnosis; Type: TABLE; Schema: clin_pregnancy; Owner: -; Tablespace: 
--

CREATE TABLE lu_ante_natal_diagnosis (
    pk integer NOT NULL,
    diagnostic_procedure text NOT NULL
);


--
-- TOC entry 1003 (class 1259 OID 61680)
-- Dependencies: 52 1002
-- Name: lu_ante_natal_diagnosis_pk_seq; Type: SEQUENCE; Schema: clin_pregnancy; Owner: -
--

CREATE SEQUENCE lu_ante_natal_diagnosis_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4665 (class 0 OID 0)
-- Dependencies: 1003
-- Name: lu_ante_natal_diagnosis_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_pregnancy; Owner: -
--

ALTER SEQUENCE lu_ante_natal_diagnosis_pk_seq OWNED BY lu_ante_natal_diagnosis.pk;


--
-- TOC entry 1004 (class 1259 OID 61682)
-- Dependencies: 52
-- Name: lu_delivery_types; Type: TABLE; Schema: clin_pregnancy; Owner: -; Tablespace: 
--

CREATE TABLE lu_delivery_types (
    pk integer NOT NULL,
    type text NOT NULL
);


--
-- TOC entry 1005 (class 1259 OID 61688)
-- Dependencies: 1004 52
-- Name: lu_delivery_types_pk_seq; Type: SEQUENCE; Schema: clin_pregnancy; Owner: -
--

CREATE SEQUENCE lu_delivery_types_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4667 (class 0 OID 0)
-- Dependencies: 1005
-- Name: lu_delivery_types_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_pregnancy; Owner: -
--

ALTER SEQUENCE lu_delivery_types_pk_seq OWNED BY lu_delivery_types.pk;


--
-- TOC entry 1006 (class 1259 OID 61690)
-- Dependencies: 52
-- Name: lu_onset_labour; Type: TABLE; Schema: clin_pregnancy; Owner: -; Tablespace: 
--

CREATE TABLE lu_onset_labour (
    pk integer NOT NULL,
    type text NOT NULL
);


--
-- TOC entry 1007 (class 1259 OID 61696)
-- Dependencies: 52 1006
-- Name: lu_onset_labour_pk_seq; Type: SEQUENCE; Schema: clin_pregnancy; Owner: -
--

CREATE SEQUENCE lu_onset_labour_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4670 (class 0 OID 0)
-- Dependencies: 1007
-- Name: lu_onset_labour_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_pregnancy; Owner: -
--

ALTER SEQUENCE lu_onset_labour_pk_seq OWNED BY lu_onset_labour.pk;


--
-- TOC entry 1008 (class 1259 OID 61698)
-- Dependencies: 52
-- Name: lu_placenta_position; Type: TABLE; Schema: clin_pregnancy; Owner: -; Tablespace: 
--

CREATE TABLE lu_placenta_position (
    pk integer NOT NULL,
    "position" text NOT NULL
);


--
-- TOC entry 1009 (class 1259 OID 61704)
-- Dependencies: 1008 52
-- Name: lu_placenta_position_pk_seq; Type: SEQUENCE; Schema: clin_pregnancy; Owner: -
--

CREATE SEQUENCE lu_placenta_position_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4673 (class 0 OID 0)
-- Dependencies: 1009
-- Name: lu_placenta_position_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_pregnancy; Owner: -
--

ALTER SEQUENCE lu_placenta_position_pk_seq OWNED BY lu_placenta_position.pk;


--
-- TOC entry 1010 (class 1259 OID 61706)
-- Dependencies: 52
-- Name: lu_presentations; Type: TABLE; Schema: clin_pregnancy; Owner: -; Tablespace: 
--

CREATE TABLE lu_presentations (
    pk integer NOT NULL,
    presentation text NOT NULL
);


--
-- TOC entry 1011 (class 1259 OID 61712)
-- Dependencies: 1010 52
-- Name: lu_presentations_pk_seq; Type: SEQUENCE; Schema: clin_pregnancy; Owner: -
--

CREATE SEQUENCE lu_presentations_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4675 (class 0 OID 0)
-- Dependencies: 1011
-- Name: lu_presentations_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_pregnancy; Owner: -
--

ALTER SEQUENCE lu_presentations_pk_seq OWNED BY lu_presentations.pk;


--
-- TOC entry 1012 (class 1259 OID 61714)
-- Dependencies: 4571 4572 4573 4574 4575 4576 4577 4578 4579 4581 4582 52
-- Name: pregnancies; Type: TABLE; Schema: clin_pregnancy; Owner: -; Tablespace: 
--

CREATE TABLE pregnancies (
    pk integer NOT NULL,
    fk_consult integer NOT NULL,
    lmp text,
    edc date,
    date_gtt date,
    notes text,
    gestation text,
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
    puerperium text,
    edc_revised_reason text,
    morphology_scan_abnormal boolean,
    nuchal_fold_abnormal boolean,
    gtt_result text,
    edc_revised date,
    fk_progressnote integer NOT NULL,
    breast_fed boolean,
    breast_fed_duration text,
    contraception text,
    anti_d_28w_date date,
    anti_d_28w_given boolean DEFAULT false,
    anti_d_34w_date boolean DEFAULT false,
    anti_d_34w_given boolean DEFAULT false,
    morphology_scan_foetal_size numeric,
    morphology_scan_weeks numeric,
    fk_lu_blood_group integer,
    fk_lu_rhesus_group integer,
    booking_haemoglobin numeric,
    syphilus boolean,
    rubella boolean,
    rubella_titre text,
    hepatitis_b boolean,
    hepatitis_c boolean,
    booking_msu text,
    group_b_strep_swabs boolean,
    repeat_antibody_screen_34_37wk boolean DEFAULT false,
    hiv boolean,
    varicella boolean,
    rh_antibody_screen_28w boolean,
    prenatal_diagnosis_amniocentesis boolean DEFAULT false,
    prenatal_diagnosis_cvs boolean DEFAULT false
);


--
-- TOC entry 4677 (class 0 OID 0)
-- Dependencies: 1012
-- Name: TABLE pregnancies; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON TABLE pregnancies IS 'The ''core'' data about a pregnancy
  This table probably seems Odd, it may contain nothing but a primary key
  And say a month/year or date as date_delivery, a baby_sex etc ';


--
-- TOC entry 4678 (class 0 OID 0)
-- Dependencies: 1012
-- Name: COLUMN pregnancies.lmp; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN pregnancies.lmp IS 'the last period date if known, can be free text or null';


--
-- TOC entry 4679 (class 0 OID 0)
-- Dependencies: 1012
-- Name: COLUMN pregnancies.edc; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN pregnancies.edc IS 'the estimated date of confinement can initially be null';


--
-- TOC entry 4680 (class 0 OID 0)
-- Dependencies: 1012
-- Name: COLUMN pregnancies.notes; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN pregnancies.notes IS 'general notes on the pregnancy, could include summary of complications';


--
-- TOC entry 4681 (class 0 OID 0)
-- Dependencies: 1012
-- Name: COLUMN pregnancies.gestation; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN pregnancies.gestation IS 'the gestation in weeks';


--
-- TOC entry 4682 (class 0 OID 0)
-- Dependencies: 1012
-- Name: COLUMN pregnancies.age_at_delivery; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN pregnancies.age_at_delivery IS 'a deliberately vague column for recording past history of pregnancies
  e.g could have say TOP at age 18yrs';


--
-- TOC entry 4683 (class 0 OID 0)
-- Dependencies: 1012
-- Name: COLUMN pregnancies.date_delivery; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN pregnancies.date_delivery IS 'As we may be recording bare details about past pregnancies where dates are not known accept year or mm/yyyy or proper date';


--
-- TOC entry 4684 (class 0 OID 0)
-- Dependencies: 1012
-- Name: COLUMN pregnancies.puerperium; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN pregnancies.puerperium IS 'any complications after birth e.g problems with infant feeding, mothers mood, depression etc';


--
-- TOC entry 4685 (class 0 OID 0)
-- Dependencies: 1012
-- Name: COLUMN pregnancies.morphology_scan_abnormal; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN pregnancies.morphology_scan_abnormal IS 'True if abnormal , False if normal and null if unknown or not done';


--
-- TOC entry 4686 (class 0 OID 0)
-- Dependencies: 1012
-- Name: COLUMN pregnancies.nuchal_fold_abnormal; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN pregnancies.nuchal_fold_abnormal IS 'True if abnormal , False if normal and null if unknown or not done';


--
-- TOC entry 4687 (class 0 OID 0)
-- Dependencies: 1012
-- Name: COLUMN pregnancies.contraception; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN pregnancies.contraception IS 'the post natal contraceptive method or advice';


--
-- TOC entry 4688 (class 0 OID 0)
-- Dependencies: 1012
-- Name: COLUMN pregnancies.anti_d_28w_date; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN pregnancies.anti_d_28w_date IS 'Date the injection of anti-d is due or was given';


--
-- TOC entry 4689 (class 0 OID 0)
-- Dependencies: 1012
-- Name: COLUMN pregnancies.anti_d_28w_given; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN pregnancies.anti_d_28w_given IS 'True if given, False if not given, null if unknown';


--
-- TOC entry 4690 (class 0 OID 0)
-- Dependencies: 1012
-- Name: COLUMN pregnancies.anti_d_34w_date; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN pregnancies.anti_d_34w_date IS 'Date the injection of anti-d is due or was given';


--
-- TOC entry 4691 (class 0 OID 0)
-- Dependencies: 1012
-- Name: COLUMN pregnancies.anti_d_34w_given; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN pregnancies.anti_d_34w_given IS 'True if given, False if not given, null if unknown';


--
-- TOC entry 4692 (class 0 OID 0)
-- Dependencies: 1012
-- Name: COLUMN pregnancies.booking_haemoglobin; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN pregnancies.booking_haemoglobin IS 'the patients haemoglobin at booking ... considered this field to be generic enough
  as to not to need a date - all the ante-natal forms do not use dates';


--
-- TOC entry 4693 (class 0 OID 0)
-- Dependencies: 1012
-- Name: COLUMN pregnancies.syphilus; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN pregnancies.syphilus IS 'True if TPHA or VDRL positive, False if -ve and null if unknown';


--
-- TOC entry 4694 (class 0 OID 0)
-- Dependencies: 1012
-- Name: COLUMN pregnancies.rubella; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN pregnancies.rubella IS 'True if Immune , False if not immune and null if unknown';


--
-- TOC entry 4695 (class 0 OID 0)
-- Dependencies: 1012
-- Name: COLUMN pregnancies.rubella_titre; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN pregnancies.rubella_titre IS 'this is a text field as the result could be eg 20 (range may be included)';


--
-- TOC entry 4696 (class 0 OID 0)
-- Dependencies: 1012
-- Name: COLUMN pregnancies.hepatitis_b; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN pregnancies.hepatitis_b IS 'True if Immune , False if non immune and null if unknown';


--
-- TOC entry 4697 (class 0 OID 0)
-- Dependencies: 1012
-- Name: COLUMN pregnancies.hepatitis_c; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN pregnancies.hepatitis_c IS 'True if Immune , False if non immune and null if unknown';


--
-- TOC entry 4698 (class 0 OID 0)
-- Dependencies: 1012
-- Name: COLUMN pregnancies.booking_msu; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN pregnancies.booking_msu IS 'The mid stream urine results at time of booking';


--
-- TOC entry 4699 (class 0 OID 0)
-- Dependencies: 1012
-- Name: COLUMN pregnancies.group_b_strep_swabs; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN pregnancies.group_b_strep_swabs IS 'True if postive , False if negative and null if unknown';


--
-- TOC entry 4700 (class 0 OID 0)
-- Dependencies: 1012
-- Name: COLUMN pregnancies.repeat_antibody_screen_34_37wk; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN pregnancies.repeat_antibody_screen_34_37wk IS 'True if postive , False if negative and null if unknown';


--
-- TOC entry 4701 (class 0 OID 0)
-- Dependencies: 1012
-- Name: COLUMN pregnancies.hiv; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN pregnancies.hiv IS 'True if Postive , False if negative and null if unknown';


--
-- TOC entry 4702 (class 0 OID 0)
-- Dependencies: 1012
-- Name: COLUMN pregnancies.varicella; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN pregnancies.varicella IS 'True if Immune , False if Non Immune and null if unknown';


--
-- TOC entry 4703 (class 0 OID 0)
-- Dependencies: 1012
-- Name: COLUMN pregnancies.rh_antibody_screen_28w; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN pregnancies.rh_antibody_screen_28w IS 'True if Positive , False if Negative and null if unknown';


--
-- TOC entry 1013 (class 1259 OID 61730)
-- Dependencies: 1012 52
-- Name: pregnancies_pk_seq; Type: SEQUENCE; Schema: clin_pregnancy; Owner: -
--

CREATE SEQUENCE pregnancies_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4705 (class 0 OID 0)
-- Dependencies: 1013
-- Name: pregnancies_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_pregnancy; Owner: -
--

ALTER SEQUENCE pregnancies_pk_seq OWNED BY pregnancies.pk;


--
-- TOC entry 1014 (class 1259 OID 61732)
-- Dependencies: 52
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
-- TOC entry 4707 (class 0 OID 0)
-- Dependencies: 1014
-- Name: TABLE scans; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON TABLE scans IS 'contains information about pregnancy scans';


--
-- TOC entry 4708 (class 0 OID 0)
-- Dependencies: 1014
-- Name: COLUMN scans.fk_document; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN scans.fk_document IS 'if not null the scan is a document in our system key to documents.documents table';


--
-- TOC entry 4709 (class 0 OID 0)
-- Dependencies: 1014
-- Name: COLUMN scans.scan_date; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN scans.scan_date IS 'this is a text field because patient may have had scan elsewhere, not know the date';


--
-- TOC entry 4710 (class 0 OID 0)
-- Dependencies: 1014
-- Name: COLUMN scans.fk_blob; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON COLUMN scans.fk_blob IS 'if not null, the key to blobs.images table containing picture of the scan';


--
-- TOC entry 1015 (class 1259 OID 61738)
-- Dependencies: 52 1014
-- Name: scans_pk_seq; Type: SEQUENCE; Schema: clin_pregnancy; Owner: -
--

CREATE SEQUENCE scans_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4712 (class 0 OID 0)
-- Dependencies: 1015
-- Name: scans_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_pregnancy; Owner: -
--

ALTER SEQUENCE scans_pk_seq OWNED BY scans.pk;


--
-- TOC entry 1016 (class 1259 OID 61740)
-- Dependencies: 4518 52
-- Name: vwantenatal_visits; Type: VIEW; Schema: clin_pregnancy; Owner: -
--

CREATE VIEW vwantenatal_visits AS
    SELECT ante_natal_visits.pk AS pk_antenatal_visit, lu_presentations.presentation, 
    ante_natal_visits.fk_consult, consult.fk_patient, ante_natal_visits.fk_pregnancy, 
    ante_natal_visits.visit_date, ante_natal_visits.duration_weeks, 
    ante_natal_visits.fundal_height, ante_natal_visits.fk_lu_presentation, ante_natal_visits.foetal_heart_heard,
     ante_natal_visits.urinalysis, ante_natal_visits.bloodpressure, ante_natal_visits.weight, 
     ante_natal_visits.foetal_movements_felt, ante_natal_visits.notes, ante_natal_visits.foetal_heart_rate, 
     ante_natal_visits.fk_progressnote, progressnotes.notes AS progress_notes, pregnancies.edc, 
     pregnancies.edc_revised FROM ante_natal_visits, lu_presentations, clin_consult.consult, 
     pregnancies, clin_consult.progressnotes 
     WHERE ((((ante_natal_visits.fk_lu_presentation = lu_presentations.pk) 
     AND (ante_natal_visits.fk_consult = consult.pk)) 
     AND (ante_natal_visits.fk_pregnancy = pregnancies.pk)) 
     AND (ante_natal_visits.fk_progressnote = progressnotes.pk));


--
-- TOC entry 1017 (class 1259 OID 61996)
-- Dependencies: 4519 52
-- Name: vwpregnancies; Type: VIEW; Schema: clin_pregnancy; Owner: -
--

CREATE VIEW vwpregnancies AS
    SELECT consult.fk_patient, pregnancies.pk AS fk_pregnancy, pregnancies.pk, 
    pregnancies.fk_consult, pregnancies.lmp, pregnancies.edc, pregnancies.edc_revised, 
    pregnancies.edc_revised_reason, pregnancies.date_gtt, pregnancies.gtt_result, pregnancies.notes, 
    pregnancies.gestation, pregnancies.nuchal_fold_scan_date, pregnancies.morphology_scan_date, pregnancies.last_presentation, 
    pregnancies.risk_factor_smoking, pregnancies.risk_factor_smoking_details, pregnancies.risk_factor_alcohol, 
    pregnancies.risk_factor_alcohol_details, pregnancies.risk_factor_drugs, pregnancies.risk_factor_drugs_details, 
    pregnancies.risk_factor_social, pregnancies.risk_factor_social_details, pregnancies.risk_factor_mental_health,
    pregnancies.risk_factor_mental_health_details, pregnancies.age_at_delivery, pregnancies.date_delivery, 
    pregnancies.gestation_at_delivery, pregnancies.fk_lu_onset_labour, pregnancies.labour_hours, pregnancies.fk_lu_delivery_type, 
    pregnancies.complications, pregnancies.fk_lu_sex, pregnancies.birthweight, 
pregnancies.baby_name, pregnancies.puerperium, pregnancies.morphology_scan_abnormal, pregnancies.nuchal_fold_abnormal, 
pregnancies.fk_progressnote, pregnancies.breast_fed, pregnancies.breast_fed_duration, pregnancies.contraception,
 pregnancies.anti_d_28w_date, pregnancies.anti_d_28w_given, pregnancies.anti_d_34w_date, pregnancies.anti_d_34w_given,
  pregnancies.morphology_scan_foetal_size, pregnancies.morphology_scan_weeks, pregnancies.fk_lu_blood_group,
  pregnancies.fk_lu_rhesus_group, pregnancies.booking_haemoglobin, pregnancies.syphilus, pregnancies.rubella, 
  pregnancies.rubella_titre, pregnancies.hepatitis_b, pregnancies.hepatitis_c, 
  pregnancies.booking_msu, pregnancies.group_b_strep_swabs, pregnancies.repeat_antibody_screen_34_37wk, 
  pregnancies.hiv, pregnancies.varicella, pregnancies.rh_antibody_screen_28w, pregnancies.prenatal_diagnosis_amniocentesis, 
  pregnancies.prenatal_diagnosis_cvs, lu_delivery_types.type AS delivery_type, lu_onset_labour.type AS onset_labour_type,
   lu_sex.sex_text AS baby_sex, lu_blood_group.abo_group, lu_rhesus_group.rhesus_group, 
vwprogressnotes.notes AS progress_notes, vwprogressnotes.consult_date AS progress_notes_date 
FROM (((((((pregnancies 
JOIN clin_consult.consult ON ((pregnancies.fk_consult = consult.pk))) 
JOIN clin_consult.vwprogressnotes ON ((pregnancies.fk_progressnote = vwprogressnotes.pk_progressnote))) 
LEFT JOIN lu_onset_labour ON ((pregnancies.fk_lu_onset_labour = lu_onset_labour.pk))) 
LEFT JOIN lu_delivery_types ON ((pregnancies.fk_lu_delivery_type = lu_delivery_types.pk))) 
LEFT JOIN common.lu_blood_group ON ((pregnancies.fk_lu_blood_group = lu_blood_group.pk))) 
LEFT JOIN common.lu_rhesus_group ON ((pregnancies.fk_lu_rhesus_group = lu_rhesus_group.pk))) 
LEFT JOIN contacts.lu_sex ON ((pregnancies.fk_lu_sex = lu_sex.pk)));


--
-- TOC entry 4561 (class 2604 OID 61745)
-- Dependencies: 997 996
-- Name: pk; Type: DEFAULT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY ante_natal_care_summary ALTER COLUMN pk SET DEFAULT nextval('ante_natal_care_summary_pk_seq'::regclass);


--
-- TOC entry 4564 (class 2604 OID 61746)
-- Dependencies: 999 998
-- Name: pk; Type: DEFAULT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY ante_natal_visits ALTER COLUMN pk SET DEFAULT nextval('ante_natal_visits_pk_seq'::regclass);


--
-- TOC entry 4565 (class 2604 OID 61747)
-- Dependencies: 1001 1000
-- Name: pk; Type: DEFAULT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY edc ALTER COLUMN pk SET DEFAULT nextval('edc_pk_seq'::regclass);


--
-- TOC entry 4566 (class 2604 OID 61748)
-- Dependencies: 1003 1002
-- Name: pk; Type: DEFAULT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY lu_ante_natal_diagnosis ALTER COLUMN pk SET DEFAULT nextval('lu_ante_natal_diagnosis_pk_seq'::regclass);


--
-- TOC entry 4567 (class 2604 OID 61749)
-- Dependencies: 1005 1004
-- Name: pk; Type: DEFAULT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY lu_delivery_types ALTER COLUMN pk SET DEFAULT nextval('lu_delivery_types_pk_seq'::regclass);


--
-- TOC entry 4568 (class 2604 OID 61750)
-- Dependencies: 1007 1006
-- Name: pk; Type: DEFAULT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY lu_onset_labour ALTER COLUMN pk SET DEFAULT nextval('lu_onset_labour_pk_seq'::regclass);


--
-- TOC entry 4569 (class 2604 OID 61751)
-- Dependencies: 1009 1008
-- Name: pk; Type: DEFAULT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY lu_placenta_position ALTER COLUMN pk SET DEFAULT nextval('lu_placenta_position_pk_seq'::regclass);


--
-- TOC entry 4570 (class 2604 OID 61752)
-- Dependencies: 1011 1010
-- Name: pk; Type: DEFAULT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY lu_presentations ALTER COLUMN pk SET DEFAULT nextval('lu_presentations_pk_seq'::regclass);


--
-- TOC entry 4580 (class 2604 OID 61753)
-- Dependencies: 1013 1012
-- Name: pk; Type: DEFAULT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY pregnancies ALTER COLUMN pk SET DEFAULT nextval('pregnancies_pk_seq'::regclass);


--
-- TOC entry 4583 (class 2604 OID 61754)
-- Dependencies: 1015 1014
-- Name: pk; Type: DEFAULT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY scans ALTER COLUMN pk SET DEFAULT nextval('scans_pk_seq'::regclass);


--
-- TOC entry 4622 (class 0 OID 61607)
-- Dependencies: 996 4642
-- Data for Name: ante_natal_care_summary; Type: TABLE DATA; Schema: clin_pregnancy; Owner: -
--



--
-- TOC entry 4715 (class 0 OID 0)
-- Dependencies: 997
-- Name: ante_natal_care_summary_pk_seq; Type: SEQUENCE SET; Schema: clin_pregnancy; Owner: -
--

SELECT pg_catalog.setval('ante_natal_care_summary_pk_seq', 1, false);


--
-- TOC entry 4624 (class 0 OID 61656)
-- Dependencies: 998 4642
-- Data for Name: ante_natal_visits; Type: TABLE DATA; Schema: clin_pregnancy; Owner: -
--



--
-- TOC entry 4716 (class 0 OID 0)
-- Dependencies: 999
-- Name: ante_natal_visits_pk_seq; Type: SEQUENCE SET; Schema: clin_pregnancy; Owner: -
--

SELECT pg_catalog.setval('ante_natal_visits_pk_seq', 1, true);


--
-- TOC entry 4626 (class 0 OID 61666)
-- Dependencies: 1000 4642
-- Data for Name: edc; Type: TABLE DATA; Schema: clin_pregnancy; Owner: -
--



--
-- TOC entry 4717 (class 0 OID 0)
-- Dependencies: 1001
-- Name: edc_pk_seq; Type: SEQUENCE SET; Schema: clin_pregnancy; Owner: -
--

SELECT pg_catalog.setval('edc_pk_seq', 1, false);


--
-- TOC entry 4628 (class 0 OID 61674)
-- Dependencies: 1002 4642
-- Data for Name: lu_ante_natal_diagnosis; Type: TABLE DATA; Schema: clin_pregnancy; Owner: -
--

INSERT INTO lu_ante_natal_diagnosis VALUES (1, 'chorionic villus sampling');
INSERT INTO lu_ante_natal_diagnosis VALUES (2, 'amniocentesis');
INSERT INTO lu_ante_natal_diagnosis VALUES (3, 'nuchal fold scan');


--
-- TOC entry 4718 (class 0 OID 0)
-- Dependencies: 1003
-- Name: lu_ante_natal_diagnosis_pk_seq; Type: SEQUENCE SET; Schema: clin_pregnancy; Owner: -
--

SELECT pg_catalog.setval('lu_ante_natal_diagnosis_pk_seq', 3, true);


--
-- TOC entry 4630 (class 0 OID 61682)
-- Dependencies: 1004 4642
-- Data for Name: lu_delivery_types; Type: TABLE DATA; Schema: clin_pregnancy; Owner: -
--

INSERT INTO lu_delivery_types VALUES (1, 'n/a');
INSERT INTO lu_delivery_types VALUES (2, 'vaginal - spontaneous');
INSERT INTO lu_delivery_types VALUES (3, 'vaginal - forceps');
INSERT INTO lu_delivery_types VALUES (4, 'vaginal - breech');
INSERT INTO lu_delivery_types VALUES (5, 'caesarian section');


--
-- TOC entry 4719 (class 0 OID 0)
-- Dependencies: 1005
-- Name: lu_delivery_types_pk_seq; Type: SEQUENCE SET; Schema: clin_pregnancy; Owner: -
--

SELECT pg_catalog.setval('lu_delivery_types_pk_seq', 5, true);


--
-- TOC entry 4632 (class 0 OID 61690)
-- Dependencies: 1006 4642
-- Data for Name: lu_onset_labour; Type: TABLE DATA; Schema: clin_pregnancy; Owner: -
--

INSERT INTO lu_onset_labour VALUES (1, 'n/a');
INSERT INTO lu_onset_labour VALUES (2, 'spontaneous');
INSERT INTO lu_onset_labour VALUES (3, 'induced');


--
-- TOC entry 4720 (class 0 OID 0)
-- Dependencies: 1007
-- Name: lu_onset_labour_pk_seq; Type: SEQUENCE SET; Schema: clin_pregnancy; Owner: -
--

SELECT pg_catalog.setval('lu_onset_labour_pk_seq', 3, true);


--
-- TOC entry 4634 (class 0 OID 61698)
-- Dependencies: 1008 4642
-- Data for Name: lu_placenta_position; Type: TABLE DATA; Schema: clin_pregnancy; Owner: -
--

INSERT INTO lu_placenta_position VALUES (1, 'fundal');
INSERT INTO lu_placenta_position VALUES (2, 'low');
INSERT INTO lu_placenta_position VALUES (3, 'anterior');
INSERT INTO lu_placenta_position VALUES (4, 'posterior');


--
-- TOC entry 4721 (class 0 OID 0)
-- Dependencies: 1009
-- Name: lu_placenta_position_pk_seq; Type: SEQUENCE SET; Schema: clin_pregnancy; Owner: -
--

SELECT pg_catalog.setval('lu_placenta_position_pk_seq', 4, true);


--
-- TOC entry 4636 (class 0 OID 61706)
-- Dependencies: 1010 4642
-- Data for Name: lu_presentations; Type: TABLE DATA; Schema: clin_pregnancy; Owner: -
--

INSERT INTO lu_presentations VALUES (1, 'n/a');
INSERT INTO lu_presentations VALUES (2, 'cephalic');
INSERT INTO lu_presentations VALUES (3, 'breech');
INSERT INTO lu_presentations VALUES (4, 'transverse');
INSERT INTO lu_presentations VALUES (5, 'unstable');


--
-- TOC entry 4722 (class 0 OID 0)
-- Dependencies: 1011
-- Name: lu_presentations_pk_seq; Type: SEQUENCE SET; Schema: clin_pregnancy; Owner: -
--

SELECT pg_catalog.setval('lu_presentations_pk_seq', 5, true);


--
-- TOC entry 4638 (class 0 OID 61714)
-- Dependencies: 1012 4642
-- Data for Name: pregnancies; Type: TABLE DATA; Schema: clin_pregnancy; Owner: -
--



--
-- TOC entry 4723 (class 0 OID 0)
-- Dependencies: 1013
-- Name: pregnancies_pk_seq; Type: SEQUENCE SET; Schema: clin_pregnancy; Owner: -
--

SELECT pg_catalog.setval('pregnancies_pk_seq', 1, true);


--
-- TOC entry 4640 (class 0 OID 61732)
-- Dependencies: 1014 4642
-- Data for Name: scans; Type: TABLE DATA; Schema: clin_pregnancy; Owner: -
--



--
-- TOC entry 4724 (class 0 OID 0)
-- Dependencies: 1015
-- Name: scans_pk_seq; Type: SEQUENCE SET; Schema: clin_pregnancy; Owner: -
--

SELECT pg_catalog.setval('scans_pk_seq', 1, false);


--
-- TOC entry 4585 (class 2606 OID 61756)
-- Dependencies: 996 996 4643
-- Name: ante_natal_care_summary_pkey; Type: CONSTRAINT; Schema: clin_pregnancy; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ante_natal_care_summary
    ADD CONSTRAINT ante_natal_care_summary_pkey PRIMARY KEY (pk);


--
-- TOC entry 4587 (class 2606 OID 61758)
-- Dependencies: 998 998 4643
-- Name: ante_natal_visits_pkey; Type: CONSTRAINT; Schema: clin_pregnancy; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ante_natal_visits
    ADD CONSTRAINT ante_natal_visits_pkey PRIMARY KEY (pk);


--
-- TOC entry 4589 (class 2606 OID 61760)
-- Dependencies: 1000 1000 4643
-- Name: edc_pkey; Type: CONSTRAINT; Schema: clin_pregnancy; Owner: -; Tablespace: 
--

ALTER TABLE ONLY edc
    ADD CONSTRAINT edc_pkey PRIMARY KEY (pk);


--
-- TOC entry 4591 (class 2606 OID 61762)
-- Dependencies: 1002 1002 4643
-- Name: lu_ante_natal_diagnosis_pkey; Type: CONSTRAINT; Schema: clin_pregnancy; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_ante_natal_diagnosis
    ADD CONSTRAINT lu_ante_natal_diagnosis_pkey PRIMARY KEY (pk);


--
-- TOC entry 4593 (class 2606 OID 61764)
-- Dependencies: 1004 1004 4643
-- Name: lu_delivery_types_pkey; Type: CONSTRAINT; Schema: clin_pregnancy; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_delivery_types
    ADD CONSTRAINT lu_delivery_types_pkey PRIMARY KEY (pk);


--
-- TOC entry 4595 (class 2606 OID 61766)
-- Dependencies: 1006 1006 4643
-- Name: lu_onset_labour_pkey; Type: CONSTRAINT; Schema: clin_pregnancy; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_onset_labour
    ADD CONSTRAINT lu_onset_labour_pkey PRIMARY KEY (pk);


--
-- TOC entry 4597 (class 2606 OID 61768)
-- Dependencies: 1008 1008 4643
-- Name: lu_placenta_position_pkey; Type: CONSTRAINT; Schema: clin_pregnancy; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_placenta_position
    ADD CONSTRAINT lu_placenta_position_pkey PRIMARY KEY (pk);


--
-- TOC entry 4599 (class 2606 OID 61770)
-- Dependencies: 1010 1010 4643
-- Name: lu_presentations_pkey; Type: CONSTRAINT; Schema: clin_pregnancy; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_presentations
    ADD CONSTRAINT lu_presentations_pkey PRIMARY KEY (pk);


--
-- TOC entry 4601 (class 2606 OID 61772)
-- Dependencies: 1012 1012 4643
-- Name: pregnancies_pkey; Type: CONSTRAINT; Schema: clin_pregnancy; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pregnancies
    ADD CONSTRAINT pregnancies_pkey PRIMARY KEY (pk);


--
-- TOC entry 4603 (class 2606 OID 61774)
-- Dependencies: 1014 1014 4643
-- Name: scans_pkey; Type: CONSTRAINT; Schema: clin_pregnancy; Owner: -; Tablespace: 
--

ALTER TABLE ONLY scans
    ADD CONSTRAINT scans_pkey PRIMARY KEY (pk);


--
-- TOC entry 4611 (class 2606 OID 61775)
-- Dependencies: 301 998 4643
-- Name: ante_natal_visits_fk_consult_fkey; Type: FK CONSTRAINT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY ante_natal_visits
    ADD CONSTRAINT ante_natal_visits_fk_consult_fkey FOREIGN KEY (fk_consult) REFERENCES clin_consult.consult(pk);


--
-- TOC entry 4610 (class 2606 OID 61780)
-- Dependencies: 4598 998 1010 4643
-- Name: ante_natal_visits_fk_lu_presentation_fkey; Type: FK CONSTRAINT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY ante_natal_visits
    ADD CONSTRAINT ante_natal_visits_fk_lu_presentation_fkey FOREIGN KEY (fk_lu_presentation) REFERENCES lu_presentations(pk);


--
-- TOC entry 4609 (class 2606 OID 61785)
-- Dependencies: 1012 998 4600 4643
-- Name: ante_natal_visits_fk_pregnancies_fkey; Type: FK CONSTRAINT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY ante_natal_visits
    ADD CONSTRAINT ante_natal_visits_fk_pregnancies_fkey FOREIGN KEY (fk_pregnancy) REFERENCES pregnancies(pk);


--
-- TOC entry 4608 (class 2606 OID 61790)
-- Dependencies: 998 322 4643
-- Name: ante_natal_visits_fk_progressnote_fkey; Type: FK CONSTRAINT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY ante_natal_visits
    ADD CONSTRAINT ante_natal_visits_fk_progressnote_fkey FOREIGN KEY (fk_progressnote) REFERENCES clin_consult.progressnotes(pk);


--
-- TOC entry 4618 (class 2606 OID 61795)
-- Dependencies: 301 1012 4643
-- Name: pregnancies_fk_consult_fkey; Type: FK CONSTRAINT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY pregnancies
    ADD CONSTRAINT pregnancies_fk_consult_fkey FOREIGN KEY (fk_consult) REFERENCES clin_consult.consult(pk);


--
-- TOC entry 4617 (class 2606 OID 61800)
-- Dependencies: 1012 993 4643
-- Name: pregnancies_fk_lu_blood_group_fkey; Type: FK CONSTRAINT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY pregnancies
    ADD CONSTRAINT pregnancies_fk_lu_blood_group_fkey FOREIGN KEY (fk_lu_blood_group) REFERENCES common.lu_blood_group(pk);


--
-- TOC entry 4616 (class 2606 OID 61805)
-- Dependencies: 1012 4592 1004 4643
-- Name: pregnancies_fk_lu_delivery_type_fkey; Type: FK CONSTRAINT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY pregnancies
    ADD CONSTRAINT pregnancies_fk_lu_delivery_type_fkey FOREIGN KEY (fk_lu_delivery_type) REFERENCES lu_delivery_types(pk);


--
-- TOC entry 4615 (class 2606 OID 61810)
-- Dependencies: 1012 1006 4594 4643
-- Name: pregnancies_fk_lu_onset_labour_fkey; Type: FK CONSTRAINT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY pregnancies
    ADD CONSTRAINT pregnancies_fk_lu_onset_labour_fkey FOREIGN KEY (fk_lu_onset_labour) REFERENCES lu_onset_labour(pk);


--
-- TOC entry 4614 (class 2606 OID 61815)
-- Dependencies: 995 1012 4643
-- Name: pregnancies_fk_lu_rhesus_group_fkey; Type: FK CONSTRAINT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY pregnancies
    ADD CONSTRAINT pregnancies_fk_lu_rhesus_group_fkey FOREIGN KEY (fk_lu_rhesus_group) REFERENCES common.lu_rhesus_group(pk);


--
-- TOC entry 4613 (class 2606 OID 61820)
-- Dependencies: 248 1012 4643
-- Name: pregnancies_fk_lu_sex_fkey; Type: FK CONSTRAINT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY pregnancies
    ADD CONSTRAINT pregnancies_fk_lu_sex_fkey FOREIGN KEY (fk_lu_sex) REFERENCES contacts.lu_sex(pk);


--
-- TOC entry 4612 (class 2606 OID 61825)
-- Dependencies: 1012 322 4643
-- Name: pregnancies_fk_progressnote_fkey; Type: FK CONSTRAINT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY pregnancies
    ADD CONSTRAINT pregnancies_fk_progressnote_fkey FOREIGN KEY (fk_progressnote) REFERENCES clin_consult.progressnotes(pk);


--
-- TOC entry 4607 (class 2606 OID 61830)
-- Dependencies: 224 996 4643
-- Name: pregnancy_first_exam_fk_staff_caring_fkey; Type: FK CONSTRAINT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY ante_natal_care_summary
    ADD CONSTRAINT pregnancy_first_exam_fk_staff_caring_fkey FOREIGN KEY (fk_staff_caring) REFERENCES admin.staff(pk);


--
-- TOC entry 4606 (class 2606 OID 61835)
-- Dependencies: 224 996 4643
-- Name: pregnancy_first_exam_fk_staff_fkey; Type: FK CONSTRAINT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY ante_natal_care_summary
    ADD CONSTRAINT pregnancy_first_exam_fk_staff_fkey FOREIGN KEY (fk_staff_first_exam) REFERENCES admin.staff(pk);


--
-- TOC entry 4605 (class 2606 OID 61840)
-- Dependencies: 996 301 4643
-- Name: pregnancy_fk_consult_fkey; Type: FK CONSTRAINT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY ante_natal_care_summary
    ADD CONSTRAINT pregnancy_fk_consult_fkey FOREIGN KEY (fk_consult) REFERENCES clin_consult.consult(pk);


--
-- TOC entry 4604 (class 2606 OID 61845)
-- Dependencies: 322 996 4643
-- Name: pregnancy_fk_progressnote; Type: FK CONSTRAINT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY ante_natal_care_summary
    ADD CONSTRAINT pregnancy_fk_progressnote FOREIGN KEY (fk_progressnote) REFERENCES clin_consult.progressnotes(pk);


--
-- TOC entry 4621 (class 2606 OID 61850)
-- Dependencies: 298 1014 4643
-- Name: scans_fk_blob_fkey; Type: FK CONSTRAINT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY scans
    ADD CONSTRAINT scans_fk_blob_fkey FOREIGN KEY (fk_blob) REFERENCES blobs.blobs(pk);


--
-- TOC entry 4620 (class 2606 OID 61855)
-- Dependencies: 572 1014 4643
-- Name: scans_fk_document_fkey; Type: FK CONSTRAINT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY scans
    ADD CONSTRAINT scans_fk_document_fkey FOREIGN KEY (fk_document) REFERENCES documents.documents(pk);


--
-- TOC entry 4619 (class 2606 OID 61860)
-- Dependencies: 4584 996 1014 4643
-- Name: scans_fk_pregnancy_fkey; Type: FK CONSTRAINT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE ONLY scans
    ADD CONSTRAINT scans_fk_pregnancy_fkey FOREIGN KEY (fk_pregnancy) REFERENCES ante_natal_care_summary(pk);


--
-- TOC entry 4646 (class 0 OID 0)
-- Dependencies: 52
-- Name: clin_pregnancy; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA clin_pregnancy FROM PUBLIC;
GRANT ALL ON SCHEMA clin_pregnancy TO easygp;
GRANT ALL ON SCHEMA clin_pregnancy TO staff;


--
-- TOC entry 4651 (class 0 OID 0)
-- Dependencies: 996
-- Name: ante_natal_care_summary; Type: ACL; Schema: clin_pregnancy; Owner: -
--

REVOKE ALL ON TABLE ante_natal_care_summary FROM PUBLIC;
GRANT ALL ON TABLE ante_natal_care_summary TO easygp;
GRANT ALL ON TABLE ante_natal_care_summary TO staff;


--
-- TOC entry 4653 (class 0 OID 0)
-- Dependencies: 997
-- Name: ante_natal_care_summary_pk_seq; Type: ACL; Schema: clin_pregnancy; Owner: -
--

REVOKE ALL ON SEQUENCE ante_natal_care_summary_pk_seq FROM PUBLIC;
GRANT ALL ON SEQUENCE ante_natal_care_summary_pk_seq TO easygp;
GRANT ALL ON SEQUENCE ante_natal_care_summary_pk_seq TO staff;


--
-- TOC entry 4656 (class 0 OID 0)
-- Dependencies: 998
-- Name: ante_natal_visits; Type: ACL; Schema: clin_pregnancy; Owner: -
--

REVOKE ALL ON TABLE ante_natal_visits FROM PUBLIC;
GRANT ALL ON TABLE ante_natal_visits TO easygp;
GRANT ALL ON TABLE ante_natal_visits TO staff;


--
-- TOC entry 4658 (class 0 OID 0)
-- Dependencies: 999
-- Name: ante_natal_visits_pk_seq; Type: ACL; Schema: clin_pregnancy; Owner: -
--

REVOKE ALL ON SEQUENCE ante_natal_visits_pk_seq FROM PUBLIC;
GRANT ALL ON SEQUENCE ante_natal_visits_pk_seq TO easygp;
GRANT ALL ON SEQUENCE ante_natal_visits_pk_seq TO staff;


--
-- TOC entry 4661 (class 0 OID 0)
-- Dependencies: 1000
-- Name: edc; Type: ACL; Schema: clin_pregnancy; Owner: -
--

REVOKE ALL ON TABLE edc FROM PUBLIC;
GRANT ALL ON TABLE edc TO easygp;
GRANT ALL ON TABLE edc TO staff;


--
-- TOC entry 4663 (class 0 OID 0)
-- Dependencies: 1001
-- Name: edc_pk_seq; Type: ACL; Schema: clin_pregnancy; Owner: -
--

REVOKE ALL ON SEQUENCE edc_pk_seq FROM PUBLIC;
GRANT ALL ON SEQUENCE edc_pk_seq TO easygp;
GRANT ALL ON SEQUENCE edc_pk_seq TO staff;


--
-- TOC entry 4664 (class 0 OID 0)
-- Dependencies: 1002
-- Name: lu_ante_natal_diagnosis; Type: ACL; Schema: clin_pregnancy; Owner: -
--

REVOKE ALL ON TABLE lu_ante_natal_diagnosis FROM PUBLIC;
GRANT ALL ON TABLE lu_ante_natal_diagnosis TO easygp;
GRANT SELECT ON TABLE lu_ante_natal_diagnosis TO staff;


--
-- TOC entry 4666 (class 0 OID 0)
-- Dependencies: 1004
-- Name: lu_delivery_types; Type: ACL; Schema: clin_pregnancy; Owner: -
--

REVOKE ALL ON TABLE lu_delivery_types FROM PUBLIC;
GRANT ALL ON TABLE lu_delivery_types TO easygp;
GRANT ALL ON TABLE lu_delivery_types TO staff;


--
-- TOC entry 4668 (class 0 OID 0)
-- Dependencies: 1005
-- Name: lu_delivery_types_pk_seq; Type: ACL; Schema: clin_pregnancy; Owner: -
--

REVOKE ALL ON SEQUENCE lu_delivery_types_pk_seq FROM PUBLIC;
GRANT ALL ON SEQUENCE lu_delivery_types_pk_seq TO easygp;
GRANT ALL ON SEQUENCE lu_delivery_types_pk_seq TO staff;


--
-- TOC entry 4669 (class 0 OID 0)
-- Dependencies: 1006
-- Name: lu_onset_labour; Type: ACL; Schema: clin_pregnancy; Owner: -
--

REVOKE ALL ON TABLE lu_onset_labour FROM PUBLIC;
GRANT ALL ON TABLE lu_onset_labour TO easygp;
GRANT ALL ON TABLE lu_onset_labour TO staff;


--
-- TOC entry 4671 (class 0 OID 0)
-- Dependencies: 1007
-- Name: lu_onset_labour_pk_seq; Type: ACL; Schema: clin_pregnancy; Owner: -
--

REVOKE ALL ON SEQUENCE lu_onset_labour_pk_seq FROM PUBLIC;
GRANT ALL ON SEQUENCE lu_onset_labour_pk_seq TO easygp;
GRANT ALL ON SEQUENCE lu_onset_labour_pk_seq TO staff;


--
-- TOC entry 4672 (class 0 OID 0)
-- Dependencies: 1008
-- Name: lu_placenta_position; Type: ACL; Schema: clin_pregnancy; Owner: -
--

REVOKE ALL ON TABLE lu_placenta_position FROM PUBLIC;
GRANT ALL ON TABLE lu_placenta_position TO easygp;
GRANT SELECT ON TABLE lu_placenta_position TO staff;


--
-- TOC entry 4674 (class 0 OID 0)
-- Dependencies: 1010
-- Name: lu_presentations; Type: ACL; Schema: clin_pregnancy; Owner: -
--

REVOKE ALL ON TABLE lu_presentations FROM PUBLIC;
GRANT ALL ON TABLE lu_presentations TO easygp;
GRANT ALL ON TABLE lu_presentations TO staff;


--
-- TOC entry 4676 (class 0 OID 0)
-- Dependencies: 1011
-- Name: lu_presentations_pk_seq; Type: ACL; Schema: clin_pregnancy; Owner: -
--

REVOKE ALL ON SEQUENCE lu_presentations_pk_seq FROM PUBLIC;
GRANT ALL ON SEQUENCE lu_presentations_pk_seq TO easygp;
GRANT ALL ON SEQUENCE lu_presentations_pk_seq TO staff;


--
-- TOC entry 4704 (class 0 OID 0)
-- Dependencies: 1012
-- Name: pregnancies; Type: ACL; Schema: clin_pregnancy; Owner: -
--

REVOKE ALL ON TABLE pregnancies FROM PUBLIC;
GRANT ALL ON TABLE pregnancies TO easygp;
GRANT ALL ON TABLE pregnancies TO staff;


--
-- TOC entry 4706 (class 0 OID 0)
-- Dependencies: 1013
-- Name: pregnancies_pk_seq; Type: ACL; Schema: clin_pregnancy; Owner: -
--

REVOKE ALL ON SEQUENCE pregnancies_pk_seq FROM PUBLIC;
GRANT ALL ON SEQUENCE pregnancies_pk_seq TO easygp;
GRANT ALL ON SEQUENCE pregnancies_pk_seq TO staff;


--
-- TOC entry 4711 (class 0 OID 0)
-- Dependencies: 1014
-- Name: scans; Type: ACL; Schema: clin_pregnancy; Owner: -
--

REVOKE ALL ON TABLE scans FROM PUBLIC;
GRANT ALL ON TABLE scans TO easygp;
GRANT ALL ON TABLE scans TO staff;


--
-- TOC entry 4713 (class 0 OID 0)
-- Dependencies: 1016
-- Name: vwantenatal_visits; Type: ACL; Schema: clin_pregnancy; Owner: -
--

REVOKE ALL ON TABLE vwantenatal_visits FROM PUBLIC;
REVOKE ALL ON TABLE vwantenatal_visits FROM easygp;
GRANT ALL ON TABLE vwantenatal_visits TO easygp;
GRANT SELECT ON TABLE vwantenatal_visits TO staff;


--
-- TOC entry 4714 (class 0 OID 0)
-- Dependencies: 1017
-- Name: vwpregnancies; Type: ACL; Schema: clin_pregnancy; Owner: -
--

REVOKE ALL ON TABLE vwpregnancies FROM PUBLIC;
REVOKE ALL ON TABLE vwpregnancies FROM easygp;
GRANT ALL ON TABLE vwpregnancies TO easygp;
GRANT ALL ON TABLE vwpregnancies TO staff;


-- Completed on 2013-11-14 15:15:27 EST

--
-- PostgreSQL database dump complete
--

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 337);
