--
-- PostgreSQL database dump
--

-- Started on 2011-02-05 16:49:27 EST

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 12 (class 2615 OID 421372)
-- Name: chronic_disease_management; Type: SCHEMA; Schema: -; Owner: richard
--

CREATE SCHEMA chronic_disease_management;


ALTER SCHEMA chronic_disease_management OWNER TO easygp;

SET search_path = chronic_disease_management, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 2671 (class 1259 OID 421597)
-- Dependencies: 3561 12
-- Name: diabetes_annual_cycle_of_care; Type: TABLE; Schema: chronic_disease_management; Owner: easygp; Tablespace: 
--

CREATE TABLE diabetes_annual_cycle_of_care (
    pk integer NOT NULL,
    fk_consult integer NOT NULL,
    date_completed date,
    hba1c_date date,
    hba1c_date_due date,
    hba1c_details text,
    eyes_date date,
    eyes_date_due date,
    eyes_details text,
    bp_date date,
    bp_date_due date,
    bp_details text,
    bmi_date date,
    bmi_date_due date,
    bmi_details text,
    feet_date date,
    feet_date_due date,
    feet_details text,
    lipids_date date,
    lipids_date_due date,
    lipids_details text,
    microalbumin_date date,
    microalbumin_date_due date,
    microalbumin_details text,
    education_date date,
    education_date_due date,
    education_details text,
    diet_date date,
    diet_date_due date,
    diet_details text,
    exercise_date date,
    exercise_date_due date,
    exercise_details text,
    smoking_date date,
    smoking_date_due date,
    smoking_details text,
    medication_review_date date,
    medication_review_date_due date,
    medication_review_details text,
    deleted boolean DEFAULT false,
    fk_progressnote integer NOT NULL
);


ALTER TABLE chronic_disease_management.diabetes_annual_cycle_of_care OWNER TO easygp;

--
-- TOC entry 3570 (class 0 OID 0)
-- Dependencies: 2671
-- Name: TABLE diabetes_annual_cycle_of_care; Type: COMMENT; Schema: chronic_disease_management; Owner: easygp
--

COMMENT ON TABLE diabetes_annual_cycle_of_care IS 'Table containing the components to the diabetes annual cycle of care first version not for clinical use';


--
-- TOC entry 3571 (class 0 OID 0)
-- Dependencies: 2671
-- Name: COLUMN diabetes_annual_cycle_of_care.hba1c_date; Type: COMMENT; Schema: chronic_disease_management; Owner: easygp
--

COMMENT ON COLUMN diabetes_annual_cycle_of_care.hba1c_date IS 'date of last hba1c could be null if not yet completed but DACC saved
	 also could be taken from  document not from our system, or a phone result etc';


--
-- TOC entry 3572 (class 0 OID 0)
-- Dependencies: 2671
-- Name: COLUMN diabetes_annual_cycle_of_care.eyes_date; Type: COMMENT; Schema: chronic_disease_management; Owner: easygp
--

COMMENT ON COLUMN diabetes_annual_cycle_of_care.eyes_date IS 'Date the eye check was done, may be entered without paperwork to verify ';


--
-- TOC entry 3573 (class 0 OID 0)
-- Dependencies: 2671
-- Name: COLUMN diabetes_annual_cycle_of_care.eyes_details; Type: COMMENT; Schema: chronic_disease_management; Owner: easygp
--

COMMENT ON COLUMN diabetes_annual_cycle_of_care.eyes_details IS 'Whoever checked the eyes, could be person or entity, but hopefully in most cases
 will be auto-trawled from the database ';


--
-- TOC entry 2672 (class 1259 OID 421604)
-- Dependencies: 2671 12
-- Name: diabetes_annual_cycle_of_care_pk_seq; Type: SEQUENCE; Schema: chronic_disease_management; Owner: easygp
--

CREATE SEQUENCE diabetes_annual_cycle_of_care_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE chronic_disease_management.diabetes_annual_cycle_of_care_pk_seq OWNER TO easygp;

--
-- TOC entry 3575 (class 0 OID 0)
-- Dependencies: 2672
-- Name: diabetes_annual_cycle_of_care_pk_seq; Type: SEQUENCE OWNED BY; Schema: chronic_disease_management; Owner: easygp
--

ALTER SEQUENCE diabetes_annual_cycle_of_care_pk_seq OWNED BY diabetes_annual_cycle_of_care.pk;


--
-- TOC entry 2673 (class 1259 OID 421606)
-- Dependencies: 12
-- Name: lu_dacc_components; Type: TABLE; Schema: chronic_disease_management; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_dacc_components (
    pk integer NOT NULL,
    fk_component integer NOT NULL
);


ALTER TABLE chronic_disease_management.lu_dacc_components OWNER TO easygp;

--
-- TOC entry 3576 (class 0 OID 0)
-- Dependencies: 2673
-- Name: TABLE lu_dacc_components; Type: COMMENT; Schema: chronic_disease_management; Owner: easygp
--

COMMENT ON TABLE lu_dacc_components IS 'Specific to Australian Government requirements for billing care of diabetics is the so 
  called Diabetic Annual Cycle of Care (DACC)';


--
-- TOC entry 3577 (class 0 OID 0)
-- Dependencies: 2673
-- Name: COLUMN lu_dacc_components.fk_component; Type: COMMENT; Schema: chronic_disease_management; Owner: easygp
--

COMMENT ON COLUMN lu_dacc_components.fk_component IS 'key to chronic_disease_management.lu_careplan_components table';


--
-- TOC entry 2674 (class 1259 OID 421609)
-- Dependencies: 2673 12
-- Name: lu_dacc_components_pk_seq; Type: SEQUENCE; Schema: chronic_disease_management; Owner: easygp
--

CREATE SEQUENCE lu_dacc_components_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE chronic_disease_management.lu_dacc_components_pk_seq OWNER TO easygp;

--
-- TOC entry 3579 (class 0 OID 0)
-- Dependencies: 2674
-- Name: lu_dacc_components_pk_seq; Type: SEQUENCE OWNED BY; Schema: chronic_disease_management; Owner: easygp
--

ALTER SEQUENCE lu_dacc_components_pk_seq OWNED BY lu_dacc_components.pk;


--
-- TOC entry 3201 (class 1259 OID 425856)
-- Dependencies: 3368 12
-- Name: vwdiabetescycleofcare; Type: VIEW; Schema: chronic_disease_management; Owner: easygp
--

CREATE VIEW vwdiabetescycleofcare AS
    SELECT consult.fk_patient, consult.fk_staff, diabetes_annual_cycle_of_care.pk, diabetes_annual_cycle_of_care.fk_consult, diabetes_annual_cycle_of_care.fk_progressnote, diabetes_annual_cycle_of_care.date_completed, diabetes_annual_cycle_of_care.hba1c_date, diabetes_annual_cycle_of_care.hba1c_date_due, diabetes_annual_cycle_of_care.hba1c_details, diabetes_annual_cycle_of_care.eyes_date, diabetes_annual_cycle_of_care.eyes_date_due, diabetes_annual_cycle_of_care.eyes_details, diabetes_annual_cycle_of_care.bp_date, diabetes_annual_cycle_of_care.bp_date_due, diabetes_annual_cycle_of_care.bp_details, diabetes_annual_cycle_of_care.bmi_date, diabetes_annual_cycle_of_care.bmi_date_due, diabetes_annual_cycle_of_care.bmi_details, diabetes_annual_cycle_of_care.feet_date, diabetes_annual_cycle_of_care.feet_date_due, diabetes_annual_cycle_of_care.feet_details, diabetes_annual_cycle_of_care.lipids_date, diabetes_annual_cycle_of_care.lipids_date_due, diabetes_annual_cycle_of_care.lipids_details, diabetes_annual_cycle_of_care.microalbumin_date, diabetes_annual_cycle_of_care.microalbumin_date_due, diabetes_annual_cycle_of_care.microalbumin_details, diabetes_annual_cycle_of_care.education_date, diabetes_annual_cycle_of_care.education_date_due, diabetes_annual_cycle_of_care.education_details, diabetes_annual_cycle_of_care.diet_date, diabetes_annual_cycle_of_care.diet_date_due, diabetes_annual_cycle_of_care.diet_details, diabetes_annual_cycle_of_care.exercise_date, diabetes_annual_cycle_of_care.exercise_date_due, diabetes_annual_cycle_of_care.exercise_details, diabetes_annual_cycle_of_care.smoking_date, diabetes_annual_cycle_of_care.smoking_date_due, diabetes_annual_cycle_of_care.smoking_details, diabetes_annual_cycle_of_care.medication_review_date, diabetes_annual_cycle_of_care.medication_review_date_due, diabetes_annual_cycle_of_care.medication_review_details, diabetes_annual_cycle_of_care.deleted FROM clin_consult.consult, diabetes_annual_cycle_of_care WHERE (diabetes_annual_cycle_of_care.fk_consult = consult.pk) ORDER BY consult.fk_patient, diabetes_annual_cycle_of_care.fk_consult;


ALTER TABLE chronic_disease_management.vwdiabetescycleofcare OWNER TO easygp;

--
-- TOC entry 3560 (class 2604 OID 423778)
-- Dependencies: 2672 2671
-- Name: pk; Type: DEFAULT; Schema: chronic_disease_management; Owner: easygp
--

ALTER TABLE diabetes_annual_cycle_of_care ALTER COLUMN pk SET DEFAULT nextval('diabetes_annual_cycle_of_care_pk_seq'::regclass);


--
-- TOC entry 3562 (class 2604 OID 423779)
-- Dependencies: 2674 2673
-- Name: pk; Type: DEFAULT; Schema: chronic_disease_management; Owner: easygp
--

ALTER TABLE lu_dacc_components ALTER COLUMN pk SET DEFAULT nextval('lu_dacc_components_pk_seq'::regclass);


--
-- TOC entry 3564 (class 2606 OID 425016)
-- Dependencies: 2671 2671
-- Name: diabetes_annual_cycle_of_care_pkey; Type: CONSTRAINT; Schema: chronic_disease_management; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY diabetes_annual_cycle_of_care
    ADD CONSTRAINT diabetes_annual_cycle_of_care_pkey PRIMARY KEY (pk);


--
-- TOC entry 3566 (class 2606 OID 425018)
-- Dependencies: 2673 2673
-- Name: lu_dacc_components_pkey; Type: CONSTRAINT; Schema: chronic_disease_management; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_dacc_components
    ADD CONSTRAINT lu_dacc_components_pkey PRIMARY KEY (pk);


--
-- TOC entry 3569 (class 0 OID 0)
-- Dependencies: 12
-- Name: chronic_disease_management; Type: ACL; Schema: -; Owner: richard
--

REVOKE ALL ON SCHEMA chronic_disease_management FROM PUBLIC;
REVOKE ALL ON SCHEMA chronic_disease_management FROM richard;
GRANT ALL ON SCHEMA chronic_disease_management TO richard;
GRANT ALL ON SCHEMA chronic_disease_management TO easygp;
GRANT ALL ON SCHEMA chronic_disease_management TO staff;


--
-- TOC entry 3574 (class 0 OID 0)
-- Dependencies: 2671
-- Name: diabetes_annual_cycle_of_care; Type: ACL; Schema: chronic_disease_management; Owner: easygp
--

REVOKE ALL ON TABLE diabetes_annual_cycle_of_care FROM PUBLIC;
REVOKE ALL ON TABLE diabetes_annual_cycle_of_care FROM easygp;
GRANT ALL ON TABLE diabetes_annual_cycle_of_care TO easygp;
GRANT ALL ON TABLE diabetes_annual_cycle_of_care TO staff;


--
-- TOC entry 3578 (class 0 OID 0)
-- Dependencies: 2673
-- Name: lu_dacc_components; Type: ACL; Schema: chronic_disease_management; Owner: easygp
--

REVOKE ALL ON TABLE lu_dacc_components FROM PUBLIC;
REVOKE ALL ON TABLE lu_dacc_components FROM easygp;
GRANT ALL ON TABLE lu_dacc_components TO easygp;
GRANT ALL ON TABLE lu_dacc_components TO staff;


--
-- TOC entry 3580 (class 0 OID 0)
-- Dependencies: 3201
-- Name: vwdiabetescycleofcare; Type: ACL; Schema: chronic_disease_management; Owner: easygp
--

REVOKE ALL ON TABLE vwdiabetescycleofcare FROM PUBLIC;
REVOKE ALL ON TABLE vwdiabetescycleofcare FROM easygp;
GRANT ALL ON TABLE vwdiabetescycleofcare TO easygp;
GRANT ALL ON TABLE vwdiabetescycleofcare TO staff;


-- Completed on 2011-02-05 16:49:27 EST

--
-- PostgreSQL database dump complete
--

truncate table db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 68);
