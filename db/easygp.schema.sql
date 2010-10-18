--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- Name: admin; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA admin;


--
-- Name: audit; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA audit;


--
-- Name: blobs; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA blobs;


--
-- Name: clerical; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA clerical;


--
-- Name: SCHEMA clerical; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA clerical IS 'Clerical schema contains anything to do with the office
Fore example patient specific stuff to do with medicare,
veterns etc. If The project ever got off the ground all
the financial stuff would be here.';


--
-- Name: clin_allergies; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA clin_allergies;


--
-- Name: clin_careplans; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA clin_careplans;


--
-- Name: clin_certificates; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA clin_certificates;


--
-- Name: clin_checkups; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA clin_checkups;


--
-- Name: clin_consult; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA clin_consult;


--
-- Name: clin_history; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA clin_history;


--
-- Name: clin_measurements; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA clin_measurements;


--
-- Name: clin_mentalhealth; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA clin_mentalhealth;


--
-- Name: clin_pregnancy; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA clin_pregnancy;


--
-- Name: clin_prescribing; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA clin_prescribing;


--
-- Name: clin_procedures; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA clin_procedures;


--
-- Name: clin_recalls; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA clin_recalls;


--
-- Name: clin_referrals; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA clin_referrals;


--
-- Name: SCHEMA clin_referrals; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA clin_referrals IS 'Contains all referral letters written';


--
-- Name: clin_requests; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA clin_requests;


--
-- Name: SCHEMA clin_requests; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA clin_requests IS 'Schema containing all the lookup information and data around request ordering';


--
-- Name: clin_vaccination; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA clin_vaccination;


--
-- Name: SCHEMA clin_vaccination; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA clin_vaccination IS ' Easy GP:2April2008 creates all the tables to do with vaccination ie vaccines (holds the brand names, fk_vaccine_description, form (eg injection) vaccines_descriptions eg typoid or tetanus toxoid, diptheria toxoid vaccines_last_bath_number - dr/nurse specific last batch used';


--
-- Name: clin_workcover; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA clin_workcover;


--
-- Name: SCHEMA clin_workcover; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA clin_workcover IS 'First version probably needs modifications +++';


--
-- Name: coding; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA coding;


--
-- Name: common; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA common;


--
-- Name: contacts; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA contacts;


--
-- Name: db; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA db;


--
-- Name: defaults; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA defaults;


--
-- Name: SCHEMA defaults; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA defaults IS 'Schema containing program defaults 
 ranging from how the user wants the program to look
 to default providers for pathology etc
 very embryonic
	';


--
-- Name: documents; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA documents;


--
-- Name: drugs; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA drugs;


--
-- Name: SCHEMA drugs; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA drugs IS '
This schema is based on original DDL structure of drug database for the gnumed project
Copyright (C) 2000, 2001, 2002 Dr. Horst Herb
Further adaptations by Ian Haywood 2010
';


--
-- Name: import_export; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA import_export;


--
-- Name: maintenance; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA maintenance;


--
-- Name: research; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA research;


--
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: -
--

CREATE PROCEDURAL LANGUAGE plpgsql;


SET search_path = clin_careplans, pg_catalog;

--
-- Name: erase_data(); Type: FUNCTION; Schema: clin_careplans; Owner: -
--

CREATE FUNCTION erase_data() RETURNS boolean
    LANGUAGE plpgsql
    AS $$
begin
delete from clin_careplans.careplan_pages;
delete from clin_careplans.careplans;
delete from clin_careplans.component_task_due;

delete from clin_careplans.link_careplanpage_advice;

delete from clin_careplans.link_careplanpage_components;
delete from clin_careplans.link_careplanpages_careplan;

delete from clin_careplans.lu_advice;

delete from clin_careplans.lu_aims;

delete from clin_careplans.lu_components;

delete from clin_careplans.lu_conditions;

delete from clin_careplans.lu_education;


delete from clin_careplans.lu_tasks;
return 1;
end
$$;


--
-- Name: FUNCTION erase_data(); Type: COMMENT; Schema: clin_careplans; Owner: -
--

COMMENT ON FUNCTION erase_data() IS '**********************
 Developmental use only
 **********************
 This function will erase your entire care plan database!!!!!!!!!!!!;
';


SET search_path = admin, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: clinics; Type: TABLE; Schema: admin; Owner: -; Tablespace: 
--

CREATE TABLE clinics (
    pk integer NOT NULL,
    fk_branch integer NOT NULL
);


--
-- Name: TABLE clinics; Type: COMMENT; Schema: admin; Owner: -
--

COMMENT ON TABLE clinics IS 'Probably temporary table till I figure out how to save clinic specific stuff';


--
-- Name: COLUMN clinics.fk_branch; Type: COMMENT; Schema: admin; Owner: -
--

COMMENT ON COLUMN clinics.fk_branch IS 'foreign key to contacts.branches table';


--
-- Name: clinic_pk_seq; Type: SEQUENCE; Schema: admin; Owner: -
--

CREATE SEQUENCE clinic_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: clinic_pk_seq; Type: SEQUENCE OWNED BY; Schema: admin; Owner: -
--

ALTER SEQUENCE clinic_pk_seq OWNED BY clinics.pk;


--
-- Name: clinic_rooms; Type: TABLE; Schema: admin; Owner: -; Tablespace: 
--

CREATE TABLE clinic_rooms (
    pk integer NOT NULL,
    room_name text NOT NULL,
    fk_clinic integer NOT NULL,
    script_printer text,
    default_printer text
);


--
-- Name: TABLE clinic_rooms; Type: COMMENT; Schema: admin; Owner: -
--

COMMENT ON TABLE clinic_rooms IS 'links a name of a room to a clinic ie specifies locations within the practice(s)';


--
-- Name: COLUMN clinic_rooms.room_name; Type: COMMENT; Schema: admin; Owner: -
--

COMMENT ON COLUMN clinic_rooms.room_name IS 'the name of a location within the clinic for example Surgery1';


--
-- Name: COLUMN clinic_rooms.fk_clinic; Type: COMMENT; Schema: admin; Owner: -
--

COMMENT ON COLUMN clinic_rooms.fk_clinic IS 'foreign key to admin.clinics table';


--
-- Name: clinic_rooms_pk_seq; Type: SEQUENCE; Schema: admin; Owner: -
--

CREATE SEQUENCE clinic_rooms_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: clinic_rooms_pk_seq; Type: SEQUENCE OWNED BY; Schema: admin; Owner: -
--

ALTER SEQUENCE clinic_rooms_pk_seq OWNED BY clinic_rooms.pk;


--
-- Name: global_preferences; Type: TABLE; Schema: admin; Owner: -; Tablespace: 
--

CREATE TABLE global_preferences (
    pk integer NOT NULL,
    name text NOT NULL,
    value text,
    fk_clinic integer NOT NULL
);


--
-- Name: global_preferences_pk_seq; Type: SEQUENCE; Schema: admin; Owner: -
--

CREATE SEQUENCE global_preferences_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: global_preferences_pk_seq; Type: SEQUENCE OWNED BY; Schema: admin; Owner: -
--

ALTER SEQUENCE global_preferences_pk_seq OWNED BY global_preferences.pk;


--
-- Name: link_staff_clinics; Type: TABLE; Schema: admin; Owner: -; Tablespace: 
--

CREATE TABLE link_staff_clinics (
    pk integer NOT NULL,
    fk_staff integer NOT NULL,
    fk_clinic integer NOT NULL
);


--
-- Name: link_staff_clinics_pk_seq; Type: SEQUENCE; Schema: admin; Owner: -
--

CREATE SEQUENCE link_staff_clinics_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: link_staff_clinics_pk_seq; Type: SEQUENCE OWNED BY; Schema: admin; Owner: -
--

ALTER SEQUENCE link_staff_clinics_pk_seq OWNED BY link_staff_clinics.pk;


--
-- Name: lu_staff_roles; Type: TABLE; Schema: admin; Owner: -; Tablespace: 
--

CREATE TABLE lu_staff_roles (
    pk integer NOT NULL,
    role text NOT NULL
);


--
-- Name: TABLE lu_staff_roles; Type: COMMENT; Schema: admin; Owner: -
--

COMMENT ON TABLE lu_staff_roles IS 'Type of role in the organisation
	sysadmin, clinical, administrative';


--
-- Name: lu_staff_roles_pk_seq; Type: SEQUENCE; Schema: admin; Owner: -
--

CREATE SEQUENCE lu_staff_roles_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_staff_roles_pk_seq; Type: SEQUENCE OWNED BY; Schema: admin; Owner: -
--

ALTER SEQUENCE lu_staff_roles_pk_seq OWNED BY lu_staff_roles.pk;


--
-- Name: lu_staff_status; Type: TABLE; Schema: admin; Owner: -; Tablespace: 
--

CREATE TABLE lu_staff_status (
    pk integer NOT NULL,
    status text NOT NULL
);


--
-- Name: TABLE lu_staff_status; Type: COMMENT; Schema: admin; Owner: -
--

COMMENT ON TABLE lu_staff_status IS 'Working status of staff member
	e.g active = active in organisation
	    locum  = is a locum etc';


--
-- Name: lu_staff_status_pk_seq; Type: SEQUENCE; Schema: admin; Owner: -
--

CREATE SEQUENCE lu_staff_status_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_staff_status_pk_seq; Type: SEQUENCE OWNED BY; Schema: admin; Owner: -
--

ALTER SEQUENCE lu_staff_status_pk_seq OWNED BY lu_staff_status.pk;


--
-- Name: lu_staff_type; Type: TABLE; Schema: admin; Owner: -; Tablespace: 
--

CREATE TABLE lu_staff_type (
    pk integer NOT NULL,
    type text NOT NULL
);


--
-- Name: TABLE lu_staff_type; Type: COMMENT; Schema: admin; Owner: -
--

COMMENT ON TABLE lu_staff_type IS 'Type of staff:
	Administrative
	Maintenance
	Medical
	Mental Health
	Nursing
	Paramedical
	Secretarial
	Speclialist
	or whatever these end up being
';


--
-- Name: lu_staff_type_pk_seq; Type: SEQUENCE; Schema: admin; Owner: -
--

CREATE SEQUENCE lu_staff_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_staff_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: admin; Owner: -
--

ALTER SEQUENCE lu_staff_type_pk_seq OWNED BY lu_staff_type.pk;


--
-- Name: staff; Type: TABLE; Schema: admin; Owner: -; Tablespace: 
--

CREATE TABLE staff (
    pk integer NOT NULL,
    fk_person integer NOT NULL,
    fk_role integer NOT NULL,
    fk_status integer NOT NULL,
    logon_name text NOT NULL,
    provider_number text,
    prescriber_number text,
    logon_date_from date,
    logon_date_to date
);


--
-- Name: staff_pk_seq; Type: SEQUENCE; Schema: admin; Owner: -
--

CREATE SEQUENCE staff_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: staff_pk_seq; Type: SEQUENCE OWNED BY; Schema: admin; Owner: -
--

ALTER SEQUENCE staff_pk_seq OWNED BY staff.pk;


SET search_path = contacts, pg_catalog;

--
-- Name: data_addresses; Type: TABLE; Schema: contacts; Owner: -; Tablespace: 
--

CREATE TABLE data_addresses (
    pk integer NOT NULL,
    street text,
    fk_town integer,
    preferred_address boolean DEFAULT false,
    postal_address boolean DEFAULT false,
    head_office boolean DEFAULT false,
    geolocation point,
    country_code character(2),
    fk_lu_address_type integer,
    deleted boolean DEFAULT false
);


--
-- Name: COLUMN data_addresses.geolocation; Type: COMMENT; Schema: contacts; Owner: -
--

COMMENT ON COLUMN data_addresses.geolocation IS 'geographical location latitude and longitude';


--
-- Name: COLUMN data_addresses.country_code; Type: COMMENT; Schema: contacts; Owner: -
--

COMMENT ON COLUMN data_addresses.country_code IS 'pointer to lu_country';


--
-- Name: COLUMN data_addresses.deleted; Type: COMMENT; Schema: contacts; Owner: -
--

COMMENT ON COLUMN data_addresses.deleted IS 'IF False then this address has had its link removed';


--
-- Name: data_branches; Type: TABLE; Schema: contacts; Owner: -; Tablespace: 
--

CREATE TABLE data_branches (
    pk integer NOT NULL,
    branch text,
    fk_organisation integer,
    fk_address integer,
    memo text,
    fk_category integer,
    deleted boolean DEFAULT false
);


--
-- Name: COLUMN data_branches.memo; Type: COMMENT; Schema: contacts; Owner: -
--

COMMENT ON COLUMN data_branches.memo IS 'branch specific memo';


--
-- Name: COLUMN data_branches.deleted; Type: COMMENT; Schema: contacts; Owner: -
--

COMMENT ON COLUMN data_branches.deleted IS 'If true then the branch is marked as  deleted';


--
-- Name: data_organisations; Type: TABLE; Schema: contacts; Owner: -; Tablespace: 
--

CREATE TABLE data_organisations (
    pk integer NOT NULL,
    organisation character varying(50) NOT NULL,
    deleted boolean DEFAULT false
);


--
-- Name: lu_address_types; Type: TABLE; Schema: contacts; Owner: -; Tablespace: 
--

CREATE TABLE lu_address_types (
    pk integer NOT NULL,
    type text
);


--
-- Name: lu_categories; Type: TABLE; Schema: contacts; Owner: -; Tablespace: 
--

CREATE TABLE lu_categories (
    pk integer NOT NULL,
    category character varying(50) NOT NULL
);


--
-- Name: lu_towns; Type: TABLE; Schema: contacts; Owner: -; Tablespace: 
--

CREATE TABLE lu_towns (
    pk integer NOT NULL,
    postcode character varying(4),
    town text,
    state character varying(3),
    comment text
);


--
-- Name: COLUMN lu_towns.comment; Type: COMMENT; Schema: contacts; Owner: -
--

COMMENT ON COLUMN lu_towns.comment IS 'really a qualifier, in the Australian context this field is usually null
 or the text:PO Boxes';


SET search_path = admin, pg_catalog;

--
-- Name: vwclinics; Type: VIEW; Schema: admin; Owner: -
--

CREATE VIEW vwclinics AS
    SELECT data_branches.pk AS pk_view, clinics.pk AS fk_clinic, clinics.fk_branch, data_branches.branch, data_branches.fk_address, data_branches.fk_organisation, data_organisations.organisation, data_addresses.street, data_addresses.fk_town, data_addresses.preferred_address, data_addresses.postal_address, data_addresses.head_office, data_addresses.geolocation, data_addresses.country_code, data_addresses.fk_lu_address_type, lu_address_types.type AS address_type, data_addresses.deleted, lu_towns.postcode, lu_towns.town, lu_towns.state, data_branches.memo AS memo_branches, data_organisations.deleted AS organisation_deleted, lu_categories.category FROM ((((((clinics JOIN contacts.data_branches ON ((clinics.fk_branch = data_branches.pk))) JOIN contacts.data_organisations ON ((data_branches.fk_organisation = data_organisations.pk))) LEFT JOIN contacts.data_addresses ON ((data_branches.fk_address = data_addresses.pk))) LEFT JOIN contacts.lu_address_types ON ((data_addresses.fk_lu_address_type = lu_address_types.pk))) JOIN contacts.lu_towns ON ((data_addresses.fk_town = lu_towns.pk))) JOIN contacts.lu_categories ON ((data_branches.fk_category = lu_categories.pk))) ORDER BY data_organisations.organisation, data_branches.fk_address;


--
-- Name: vwclinicrooms; Type: VIEW; Schema: admin; Owner: -
--

CREATE VIEW vwclinicrooms AS
    SELECT clinic_rooms.pk, clinic_rooms.room_name, clinic_rooms.script_printer, clinic_rooms.default_printer, clinic_rooms.fk_clinic, vwclinics.organisation, vwclinics.branch, vwclinics.street, vwclinics.town FROM clinic_rooms, vwclinics WHERE (clinic_rooms.fk_clinic = vwclinics.fk_clinic) ORDER BY clinic_rooms.fk_clinic, clinic_rooms.room_name;


SET search_path = contacts, pg_catalog;

--
-- Name: data_persons; Type: TABLE; Schema: contacts; Owner: -; Tablespace: 
--

CREATE TABLE data_persons (
    pk integer NOT NULL,
    firstname text,
    surname text,
    salutation text,
    birthdate date,
    fk_ethnicity integer,
    fk_language integer,
    memo text,
    fk_marital integer DEFAULT 0,
    fk_title integer DEFAULT 7,
    fk_sex integer,
    country_code text,
    fk_image integer,
    retired boolean DEFAULT false,
    fk_occupation integer,
    fk_category integer,
    deleted boolean DEFAULT false,
    deceased boolean DEFAULT false,
    date_deceased date
);


--
-- Name: COLUMN data_persons.fk_occupation; Type: COMMENT; Schema: contacts; Owner: -
--

COMMENT ON COLUMN data_persons.fk_occupation IS 'maybe a temporary column - at the moment only used to record a single occupation 
of a person who is not in an organisation';


--
-- Name: COLUMN data_persons.fk_category; Type: COMMENT; Schema: contacts; Owner: -
--

COMMENT ON COLUMN data_persons.fk_category IS 'In the grand apparently convoluted schema of thing:
	if person <> a patient and <> employee then fk_category may not be null';


--
-- Name: lu_title; Type: TABLE; Schema: contacts; Owner: -; Tablespace: 
--

CREATE TABLE lu_title (
    pk integer NOT NULL,
    title text
);


SET search_path = admin, pg_catalog;

--
-- Name: vwstaff; Type: VIEW; Schema: admin; Owner: -
--

CREATE VIEW vwstaff AS
    SELECT roles.role, staff.fk_person, staff.logon_name, staff.fk_role, staff.pk, staff.pk AS fk_staff, staff.provider_number, staff.prescriber_number, persons.firstname, persons.surname, ((persons.firstname || ' '::text) || persons.surname) AS wholename, persons.salutation, persons.fk_title, lu_title.title FROM (((staff staff JOIN lu_staff_roles roles ON ((staff.fk_role = roles.pk))) JOIN contacts.data_persons persons ON ((staff.fk_person = persons.pk))) JOIN contacts.lu_title ON ((persons.fk_title = lu_title.pk)));


SET search_path = common, pg_catalog;

--
-- Name: lu_ethnicity; Type: TABLE; Schema: common; Owner: -; Tablespace: 
--

CREATE TABLE lu_ethnicity (
    pk integer NOT NULL,
    ethnicity text NOT NULL
);


--
-- Name: lu_languages; Type: TABLE; Schema: common; Owner: -; Tablespace: 
--

CREATE TABLE lu_languages (
    pk integer NOT NULL,
    language text NOT NULL
);


--
-- Name: lu_occupations; Type: TABLE; Schema: common; Owner: -; Tablespace: 
--

CREATE TABLE lu_occupations (
    pk integer NOT NULL,
    occupation text NOT NULL
);


SET search_path = contacts, pg_catalog;

--
-- Name: data_employees; Type: TABLE; Schema: contacts; Owner: -; Tablespace: 
--

CREATE TABLE data_employees (
    pk integer NOT NULL,
    fk_branch integer,
    fk_person integer,
    fk_occupation integer,
    fk_category integer,
    memo text,
    deleted boolean DEFAULT false,
    fk_status integer DEFAULT 0
);


--
-- Name: COLUMN data_employees.deleted; Type: COMMENT; Schema: contacts; Owner: -
--

COMMENT ON COLUMN data_employees.deleted IS 'If True then the person is marked as no longer attatched to current branch
 though of course is not removed from the database';


--
-- Name: COLUMN data_employees.fk_status; Type: COMMENT; Schema: contacts; Owner: -
--

COMMENT ON COLUMN data_employees.fk_status IS 'employement status, foreign key to admin.lu_status FIXME SHIFT THIS TO CONTACTS AND
 FIX ASSOCIATED STAFF QUERIES - eg 0 = active';


--
-- Name: lu_employee_status; Type: TABLE; Schema: contacts; Owner: -; Tablespace: 
--

CREATE TABLE lu_employee_status (
    pk integer NOT NULL,
    status text NOT NULL
);


--
-- Name: TABLE lu_employee_status; Type: COMMENT; Schema: contacts; Owner: -
--

COMMENT ON TABLE lu_employee_status IS 'Working status of staff member
	e.g active = active in organisation';


--
-- Name: lu_marital; Type: TABLE; Schema: contacts; Owner: -; Tablespace: 
--

CREATE TABLE lu_marital (
    pk integer NOT NULL,
    marital text
);


--
-- Name: lu_sex; Type: TABLE; Schema: contacts; Owner: -; Tablespace: 
--

CREATE TABLE lu_sex (
    pk integer NOT NULL,
    sex text,
    sex_text text
);


SET search_path = public, pg_catalog;

--
-- Name: all_images; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE all_images (
    pk integer NOT NULL,
    image bytea,
    deleted boolean
);


SET search_path = admin, pg_catalog;

--
-- Name: vwstaffinclinics; Type: VIEW; Schema: admin; Owner: -
--

CREATE VIEW vwstaffinclinics AS
    SELECT ((staff.pk || '-'::text) || data_addresses.pk) AS pk_view, ((data_persons.firstname || ' '::text) || data_persons.surname) AS wholename, staff.fk_person, staff.fk_role, staff.fk_status, staff.logon_name, staff.provider_number, staff.prescriber_number, staff.logon_date_from, staff.logon_date_to, link_staff_clinics1.fk_staff, link_staff_clinics1.fk_clinic, clinics.fk_branch, data_branches.branch, data_branches.fk_organisation, data_branches.fk_address, data_branches.memo AS branch_memo, data_branches.fk_category AS branch_category, data_branches.deleted AS branch_deleted, data_employees.pk AS fk_employee, data_employees.fk_occupation, data_employees.fk_category AS fk_employee_category, data_employees.memo AS employee_memo, data_employees.deleted AS employee_deleted, data_persons.firstname, data_persons.surname, data_persons.salutation, data_persons.birthdate, data_persons.fk_ethnicity, data_persons.fk_language, data_persons.memo AS person_memo, data_persons.fk_marital, data_persons.fk_title, data_persons.fk_sex, data_persons.country_code AS person_country_code, data_persons.fk_image, data_persons.retired, data_persons.deleted AS person_deleted, data_persons.deceased, data_persons.date_deceased, lu_title.title, lu_marital.marital, lu_sex.sex, lu_categories.category AS employee_category, lu_occupations.occupation, lu_ethnicity.ethnicity, lu_languages.language, all_images.image, all_images.deleted AS image_deleted, lu_staff_roles.role, lu_employee_status.status, data_organisations.organisation, data_organisations.deleted AS organisation_deleted, data_addresses.street, data_addresses.fk_town, lu_address_types.type AS address_type, data_addresses.preferred_address, data_addresses.postal_address, data_addresses.head_office, data_addresses.geolocation, data_addresses.country_code, data_addresses.fk_lu_address_type, data_addresses.deleted AS address_deleted, lu_towns.postcode, lu_towns.town, lu_towns.state, link_staff_clinics1.pk AS fk_link_staff_clinic FROM (((((((((((((((((((staff JOIN link_staff_clinics link_staff_clinics1 ON ((staff.pk = link_staff_clinics1.fk_staff))) JOIN clinics ON ((link_staff_clinics1.fk_clinic = clinics.pk))) JOIN contacts.data_employees ON (((staff.fk_person = data_employees.fk_person) AND (clinics.fk_branch = data_employees.fk_branch)))) JOIN contacts.data_branches ON ((clinics.fk_branch = data_branches.pk))) JOIN contacts.data_persons ON ((data_employees.fk_person = data_persons.pk))) LEFT JOIN contacts.lu_sex ON ((data_persons.fk_sex = lu_sex.pk))) LEFT JOIN contacts.lu_marital ON ((data_persons.fk_marital = lu_marital.pk))) LEFT JOIN contacts.lu_title ON ((data_persons.fk_title = lu_title.pk))) LEFT JOIN contacts.lu_categories ON ((data_employees.fk_category = lu_categories.pk))) LEFT JOIN common.lu_occupations ON ((data_employees.fk_occupation = lu_occupations.pk))) LEFT JOIN common.lu_ethnicity ON ((data_persons.fk_ethnicity = lu_ethnicity.pk))) LEFT JOIN common.lu_languages ON ((data_persons.fk_language = lu_languages.pk))) LEFT JOIN public.all_images ON ((data_persons.fk_image = all_images.pk))) JOIN lu_staff_roles ON ((staff.fk_role = lu_staff_roles.pk))) JOIN contacts.lu_employee_status ON ((staff.fk_status = lu_employee_status.pk))) JOIN contacts.data_organisations ON ((data_branches.fk_organisation = data_organisations.pk))) JOIN contacts.data_addresses ON ((data_branches.fk_address = data_addresses.pk))) LEFT JOIN contacts.lu_towns ON ((data_addresses.fk_town = lu_towns.pk))) LEFT JOIN contacts.lu_address_types ON ((data_addresses.fk_lu_address_type = lu_address_types.pk))) ORDER BY data_branches.branch, data_persons.surname;


SET search_path = audit, pg_catalog;

--
-- Name: audit; Type: TABLE; Schema: audit; Owner: -; Tablespace: 
--

CREATE TABLE audit (
    pk integer NOT NULL,
    fk_schema integer,
    fk_table integer,
    fk_row integer,
    fk_consult integer,
    fk_lu_reason integer,
    fk_action integer,
    fk_section integer,
    data_summary text
);


--
-- Name: audit_pk_seq; Type: SEQUENCE; Schema: audit; Owner: -
--

CREATE SEQUENCE audit_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: audit_pk_seq; Type: SEQUENCE OWNED BY; Schema: audit; Owner: -
--

ALTER SEQUENCE audit_pk_seq OWNED BY audit.pk;


--
-- Name: lu_actions; Type: TABLE; Schema: audit; Owner: -; Tablespace: 
--

CREATE TABLE lu_actions (
    pk integer NOT NULL,
    action text NOT NULL
);


--
-- Name: TABLE lu_actions; Type: COMMENT; Schema: audit; Owner: -
--

COMMENT ON TABLE lu_actions IS 'the action undertaken by the audit eg insert, update, delete, complete etc';


--
-- Name: lu_status; Type: TABLE; Schema: audit; Owner: -; Tablespace: 
--

CREATE TABLE lu_status (
    pk integer NOT NULL,
    status text NOT NULL
);


--
-- Name: lu_actions_pk_seq; Type: SEQUENCE; Schema: audit; Owner: -
--

CREATE SEQUENCE lu_actions_pk_seq
    START WITH 0
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


--
-- Name: lu_actions_pk_seq; Type: SEQUENCE OWNED BY; Schema: audit; Owner: -
--

ALTER SEQUENCE lu_actions_pk_seq OWNED BY lu_status.pk;


--
-- Name: lu_actions_pk_seq1; Type: SEQUENCE; Schema: audit; Owner: -
--

CREATE SEQUENCE lu_actions_pk_seq1
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_actions_pk_seq1; Type: SEQUENCE OWNED BY; Schema: audit; Owner: -
--

ALTER SEQUENCE lu_actions_pk_seq1 OWNED BY lu_actions.pk;


--
-- Name: lu_reasons; Type: TABLE; Schema: audit; Owner: -; Tablespace: 
--

CREATE TABLE lu_reasons (
    pk integer NOT NULL,
    fk_staff integer,
    reason text
);


--
-- Name: TABLE lu_reasons; Type: COMMENT; Schema: audit; Owner: -
--

COMMENT ON TABLE lu_reasons IS 'keeps reasons for the audit action on per-user basis';


--
-- Name: lu_reasons_pk_seq; Type: SEQUENCE; Schema: audit; Owner: -
--

CREATE SEQUENCE lu_reasons_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_reasons_pk_seq; Type: SEQUENCE OWNED BY; Schema: audit; Owner: -
--

ALTER SEQUENCE lu_reasons_pk_seq OWNED BY lu_reasons.pk;


--
-- Name: lu_schemas; Type: TABLE; Schema: audit; Owner: -; Tablespace: 
--

CREATE TABLE lu_schemas (
    pk integer NOT NULL,
    schema text NOT NULL
);


--
-- Name: lu_schemas_pk_seq; Type: SEQUENCE; Schema: audit; Owner: -
--

CREATE SEQUENCE lu_schemas_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_schemas_pk_seq; Type: SEQUENCE OWNED BY; Schema: audit; Owner: -
--

ALTER SEQUENCE lu_schemas_pk_seq OWNED BY lu_schemas.pk;


--
-- Name: lu_tables; Type: TABLE; Schema: audit; Owner: -; Tablespace: 
--

CREATE TABLE lu_tables (
    pk integer NOT NULL,
    fk_schema integer NOT NULL,
    tablename text
);


--
-- Name: lu_tables_pk_seq; Type: SEQUENCE; Schema: audit; Owner: -
--

CREATE SEQUENCE lu_tables_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_tables_pk_seq; Type: SEQUENCE OWNED BY; Schema: audit; Owner: -
--

ALTER SEQUENCE lu_tables_pk_seq OWNED BY lu_tables.pk;


SET search_path = clin_consult, pg_catalog;

--
-- Name: consult; Type: TABLE; Schema: clin_consult; Owner: -; Tablespace: 
--

CREATE TABLE consult (
    pk integer NOT NULL,
    consult_date timestamp without time zone NOT NULL,
    fk_patient integer NOT NULL,
    fk_staff integer NOT NULL,
    fk_type integer,
    summary text
);


--
-- Name: lu_progressnotes_sections; Type: TABLE; Schema: clin_consult; Owner: -; Tablespace: 
--

CREATE TABLE lu_progressnotes_sections (
    pk integer NOT NULL,
    section text NOT NULL
);


SET search_path = audit, pg_catalog;

--
-- Name: vwaudit; Type: VIEW; Schema: audit; Owner: -
--

CREATE VIEW vwaudit AS
    SELECT ((consult.fk_patient || '-'::text) || audit.pk) AS pk_view, consult.fk_patient, consult.consult_date AS date_audit, audit.data_summary, lu_reasons.reason AS audit_trail_reason, vwstaff.title AS altered_by_title, vwstaff.wholename AS altered_by_name, lu_schemas.schema, lu_tables.fk_schema, lu_tables.tablename, audit.fk_table, audit.fk_row, audit.fk_consult, audit.fk_lu_reason, lu_actions.action, audit.fk_action, audit.fk_section, lu_progressnotes_sections.section FROM (((((((audit JOIN lu_tables ON ((audit.fk_table = lu_tables.pk))) JOIN lu_schemas ON ((lu_tables.fk_schema = lu_schemas.pk))) JOIN lu_reasons ON ((audit.fk_lu_reason = lu_reasons.pk))) JOIN clin_consult.consult ON ((audit.fk_consult = consult.pk))) JOIN admin.vwstaff ON ((consult.fk_staff = vwstaff.fk_staff))) JOIN lu_actions ON ((audit.fk_action = lu_actions.pk))) JOIN clin_consult.lu_progressnotes_sections ON ((audit.fk_section = lu_progressnotes_sections.pk))) ORDER BY consult.fk_patient, audit.fk_table, audit.fk_row;


--
-- Name: vwschemas; Type: VIEW; Schema: audit; Owner: -
--

CREATE VIEW vwschemas AS
    SELECT lu_schemas.schema, lu_tables.tablename, lu_tables.fk_schema, lu_tables.pk AS fk_table FROM lu_schemas, lu_tables WHERE (lu_tables.fk_schema = lu_schemas.pk) ORDER BY lu_schemas.schema, lu_tables.tablename;


SET search_path = blobs, pg_catalog;

--
-- Name: blobs; Type: TABLE; Schema: blobs; Owner: -; Tablespace: 
--

CREATE TABLE blobs (
    pk integer NOT NULL,
    blob bytea NOT NULL
);


--
-- Name: blobs_pk_seq; Type: SEQUENCE; Schema: blobs; Owner: -
--

CREATE SEQUENCE blobs_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: blobs_pk_seq; Type: SEQUENCE OWNED BY; Schema: blobs; Owner: -
--

ALTER SEQUENCE blobs_pk_seq OWNED BY blobs.pk;


SET search_path = clerical, pg_catalog;

--
-- Name: data_families; Type: TABLE; Schema: clerical; Owner: -; Tablespace: 
--

CREATE TABLE data_families (
    pk integer NOT NULL,
    disbanded boolean
);


--
-- Name: data_families_pk_seq; Type: SEQUENCE; Schema: clerical; Owner: -
--

CREATE SEQUENCE data_families_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: data_families_pk_seq; Type: SEQUENCE OWNED BY; Schema: clerical; Owner: -
--

ALTER SEQUENCE data_families_pk_seq OWNED BY data_families.pk;


--
-- Name: data_family_members; Type: TABLE; Schema: clerical; Owner: -; Tablespace: 
--

CREATE TABLE data_family_members (
    pk integer NOT NULL,
    fk_family integer NOT NULL,
    fk_patient integer NOT NULL
);


--
-- Name: data_family_members_pk_seq; Type: SEQUENCE; Schema: clerical; Owner: -
--

CREATE SEQUENCE data_family_members_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: data_family_members_pk_seq; Type: SEQUENCE OWNED BY; Schema: clerical; Owner: -
--

ALTER SEQUENCE data_family_members_pk_seq OWNED BY data_family_members.pk;


--
-- Name: data_patients; Type: TABLE; Schema: clerical; Owner: -; Tablespace: 
--

CREATE TABLE data_patients (
    pk integer NOT NULL,
    fk_person integer NOT NULL,
    fk_doctor integer,
    fk_next_of_kin integer,
    fk_payer integer,
    fk_family integer,
    active_status character(1),
    medicare_number character varying(10),
    medicare_ref_number text,
    medicare_expiry_date date,
    veteran_number character varying(10),
    veteran_card_type character(1),
    veteran_specific_condition text,
    concession_card_name text,
    concession_type character(1),
    concession_number text,
    concession_expiry_date date,
    file_paper_number text,
    file_racgp_format boolean,
    file_chart_status character(1),
    private_billing_concession integer,
    private_insurance text,
    memo text,
    pk_legacy integer,
    atsi integer,
    CONSTRAINT data_patients_active_status_check CHECK (((((active_status)::text = 'a'::text) OR ((active_status)::text = 'i'::text)) OR ((active_status)::text = 'v'::text))),
    CONSTRAINT data_patients_concession_type_check CHECK (((((((concession_type)::text = 'a'::text) OR ((concession_type)::text = 'd'::text)) OR ((concession_type)::text = 'h'::text)) OR ((concession_type)::text = 's'::text)) OR ((concession_type)::text IS NULL))),
    CONSTRAINT data_patients_file_chart_status_check CHECK ((((file_chart_status = 'c'::bpchar) OR (file_chart_status = 'a'::bpchar)) OR (file_chart_status IS NULL))),
    CONSTRAINT data_patients_veteran_card_type_check CHECK ((((((veteran_card_type)::text = 'g'::text) OR ((veteran_card_type)::text = 'l'::text)) OR ((veteran_card_type)::text = 's'::text)) OR (veteran_card_type IS NULL)))
);


--
-- Name: TABLE data_patients; Type: COMMENT; Schema: clerical; Owner: -
--

COMMENT ON TABLE data_patients IS 'Patient specific data, ie applies within the health care
sector only';


--
-- Name: COLUMN data_patients.veteran_card_type; Type: COMMENT; Schema: clerical; Owner: -
--

COMMENT ON COLUMN data_patients.veteran_card_type IS 'Veteran cards can be:
               Gold  fully entitled veteran
               Lilac fully entitle  window/windower
               White specific entitlement eg skin cancer';


--
-- Name: COLUMN data_patients.concession_card_name; Type: COMMENT; Schema: clerical; Owner: -
--

COMMENT ON COLUMN data_patients.concession_card_name IS 'Non Veterans concession cards can be:
              Pension - type age or disability ie a or d
              Health Care Card  h
              Seniors health Card s ';


--
-- Name: COLUMN data_patients.file_chart_status; Type: COMMENT; Schema: clerical; Owner: -
--

COMMENT ON COLUMN data_patients.file_chart_status IS 'a = Archived c = current';


--
-- Name: COLUMN data_patients.pk_legacy; Type: COMMENT; Schema: clerical; Owner: -
--

COMMENT ON COLUMN data_patients.pk_legacy IS 'the key from the legacy database for the patient';


--
-- Name: data_patients_pk_seq; Type: SEQUENCE; Schema: clerical; Owner: -
--

CREATE SEQUENCE data_patients_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: data_patients_pk_seq; Type: SEQUENCE OWNED BY; Schema: clerical; Owner: -
--

ALTER SEQUENCE data_patients_pk_seq OWNED BY data_patients.pk;


--
-- Name: lu_task_types; Type: TABLE; Schema: clerical; Owner: -; Tablespace: 
--

CREATE TABLE lu_task_types (
    pk integer NOT NULL,
    type text NOT NULL
);


--
-- Name: TABLE lu_task_types; Type: COMMENT; Schema: clerical; Owner: -
--

COMMENT ON TABLE lu_task_types IS 'the type of task e.g ring the patient';


--
-- Name: lu_task_types_pk_seq; Type: SEQUENCE; Schema: clerical; Owner: -
--

CREATE SEQUENCE lu_task_types_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_task_types_pk_seq; Type: SEQUENCE OWNED BY; Schema: clerical; Owner: -
--

ALTER SEQUENCE lu_task_types_pk_seq OWNED BY lu_task_types.pk;


--
-- Name: task_component_notes; Type: TABLE; Schema: clerical; Owner: -; Tablespace: 
--

CREATE TABLE task_component_notes (
    pk integer NOT NULL,
    fk_task_component integer NOT NULL,
    note text NOT NULL,
    date timestamp(0) without time zone NOT NULL,
    fk_staff_made_note integer
);


--
-- Name: COLUMN task_component_notes.note; Type: COMMENT; Schema: clerical; Owner: -
--

COMMENT ON COLUMN task_component_notes.note IS 'notes about the component as the task progresses
 e.g Patient was rung, said they will come in next week
  or Patient rung a second time - refuses to come in';


--
-- Name: task_component_notes_pk_seq; Type: SEQUENCE; Schema: clerical; Owner: -
--

CREATE SEQUENCE task_component_notes_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: task_component_notes_pk_seq; Type: SEQUENCE OWNED BY; Schema: clerical; Owner: -
--

ALTER SEQUENCE task_component_notes_pk_seq OWNED BY task_component_notes.pk;


--
-- Name: task_components; Type: TABLE; Schema: clerical; Owner: -; Tablespace: 
--

CREATE TABLE task_components (
    pk integer NOT NULL,
    fk_task integer NOT NULL,
    fk_consult integer,
    date_logged date,
    fk_staff_allocated integer NOT NULL,
    fk_staff_completed integer,
    allocated_staff text,
    fk_lu_task_type integer NOT NULL,
    fk_urgency integer DEFAULT 1,
    details text,
    date_completed date,
    deleted boolean DEFAULT false,
    fk_staff_filed integer
);


--
-- Name: TABLE task_components; Type: COMMENT; Schema: clerical; Owner: -
--

COMMENT ON TABLE task_components IS 'Components which make up a task
 e.g arrange a GTT, get back for results.
 note: table clerical.task_component_notes contains none or one or
 more notes about the task component in hand
 see table task_component_notes_link for linkage';


--
-- Name: COLUMN task_components.fk_consult; Type: COMMENT; Schema: clerical; Owner: -
--

COMMENT ON COLUMN task_components.fk_consult IS 'key to clin_consult.consult ie gives patient and
the date the task was logged and by which staff member if the task is for a patient, otherwise can be null';


--
-- Name: COLUMN task_components.date_logged; Type: COMMENT; Schema: clerical; Owner: -
--

COMMENT ON COLUMN task_components.date_logged IS 'Null where the task was logged for a patient, as it has fk_consult,
 if not null, this is a staff task not linked to a fk_patient';


--
-- Name: COLUMN task_components.fk_staff_allocated; Type: COMMENT; Schema: clerical; Owner: -
--

COMMENT ON COLUMN task_components.fk_staff_allocated IS 'foreign key to clerical.staff table, ie points to the staff member
 who is allocated to do the task. May be null if staff member is a generic
 e.g Practice Nurse';


--
-- Name: COLUMN task_components.fk_staff_completed; Type: COMMENT; Schema: clerical; Owner: -
--

COMMENT ON COLUMN task_components.fk_staff_completed IS 'foreign key to clerical.staff table, points to who
 marked this component off as finalised';


--
-- Name: COLUMN task_components.allocated_staff; Type: COMMENT; Schema: clerical; Owner: -
--

COMMENT ON COLUMN task_components.allocated_staff IS 'usually null unless the staff is generic
 in which case contains text e.g Practice Nurse fixme not implemented ie the not generic';


--
-- Name: COLUMN task_components.fk_lu_task_type; Type: COMMENT; Schema: clerical; Owner: -
--

COMMENT ON COLUMN task_components.fk_lu_task_type IS 'key to clerical.lu_staff_tasks, points to text e.g phone patient';


--
-- Name: COLUMN task_components.fk_urgency; Type: COMMENT; Schema: clerical; Owner: -
--

COMMENT ON COLUMN task_components.fk_urgency IS 'key to common.lu_urgency 1:routine 2:moderate 3:urgent';


--
-- Name: COLUMN task_components.date_completed; Type: COMMENT; Schema: clerical; Owner: -
--

COMMENT ON COLUMN task_components.date_completed IS 'The date the component was finalised
 note this does not mean the task was completed';


--
-- Name: task_components_pk_seq; Type: SEQUENCE; Schema: clerical; Owner: -
--

CREATE SEQUENCE task_components_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: task_components_pk_seq; Type: SEQUENCE OWNED BY; Schema: clerical; Owner: -
--

ALTER SEQUENCE task_components_pk_seq OWNED BY task_components.pk;


--
-- Name: tasks; Type: TABLE; Schema: clerical; Owner: -; Tablespace: 
--

CREATE TABLE tasks (
    pk integer NOT NULL,
    task text NOT NULL,
    fk_staff_filed_task integer NOT NULL,
    fk_staff_finalised_task integer,
    fk_schema integer,
    fk_table integer,
    fk_row integer,
    date_finalised date,
    deleted boolean DEFAULT false
);


--
-- Name: TABLE tasks; Type: COMMENT; Schema: clerical; Owner: -
--

COMMENT ON TABLE tasks IS 'A task generated for either a patient or a staff member
 May have 1 or more components, for either same or different staff members
 If linked to a document, recall, request, it will have a fk_schema, fk_table and fk_row
 as per the corresponding audit schema tables (audit.vwSchemas). When all components to
 a task are completed finalised is true
 ';


--
-- Name: tasks_pk_seq; Type: SEQUENCE; Schema: clerical; Owner: -
--

CREATE SEQUENCE tasks_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: tasks_pk_seq; Type: SEQUENCE OWNED BY; Schema: clerical; Owner: -
--

ALTER SEQUENCE tasks_pk_seq OWNED BY tasks.pk;


SET search_path = common, pg_catalog;

--
-- Name: lu_countries; Type: TABLE; Schema: common; Owner: -; Tablespace: 
--

CREATE TABLE lu_countries (
    pk integer NOT NULL,
    country_code character(2) NOT NULL,
    country text NOT NULL
);


--
-- Name: lu_urgency; Type: TABLE; Schema: common; Owner: -; Tablespace: 
--

CREATE TABLE lu_urgency (
    pk integer NOT NULL,
    urgency text
);


--
-- Name: TABLE lu_urgency; Type: COMMENT; Schema: common; Owner: -
--

COMMENT ON TABLE lu_urgency IS 'The degree of urgency of a recall';


SET search_path = contacts, pg_catalog;

--
-- Name: links_persons_addresses; Type: TABLE; Schema: contacts; Owner: -; Tablespace: 
--

CREATE TABLE links_persons_addresses (
    pk integer NOT NULL,
    fk_address integer,
    fk_person integer,
    deleted boolean DEFAULT false
);


--
-- Name: vwpatients; Type: VIEW; Schema: contacts; Owner: -
--

CREATE VIEW vwpatients AS
    SELECT CASE WHEN (addresses.pk IS NULL) THEN (patients.pk || '-0'::text) ELSE ((patients.pk || '-'::text) || addresses.pk) END AS pk_view, patients.pk AS fk_patient, addresses.pk AS fk_address, patients.fk_person, (((title.title || ' '::text) || (persons.firstname || ' '::text)) || (persons.surname || ' '::text)) AS wholename, persons.firstname, persons.surname, persons.salutation, persons.birthdate, date_part('year'::text, age((persons.birthdate)::timestamp with time zone)) AS age, marital.marital, sex.sex, title.title, countries.country, languages.language, ethnicity.ethnicity, occupation.occupation, addresses.street, towns.town, towns.state, towns.postcode, addresses.fk_town, lu_address_types.type AS address_type, addresses.fk_lu_address_type, addresses.preferred_address, addresses.postal_address, addresses.head_office, addresses.geolocation, addresses.country_code, addresses.deleted AS address_deleted, persons.fk_ethnicity, persons.fk_language, persons.memo, persons.fk_marital, persons.fk_title, persons.fk_sex, persons.fk_occupation, persons.retired, persons.deceased, persons.date_deceased, patients.fk_doctor, patients.fk_next_of_kin, patients.fk_payer, patients.fk_family, patients.active_status, patients.medicare_number, patients.medicare_ref_number, patients.medicare_expiry_date, patients.veteran_number, patients.veteran_card_type, patients.veteran_specific_condition, patients.concession_card_name, patients.concession_type, patients.concession_number, patients.concession_expiry_date, patients.file_paper_number, patients.atsi, patients.file_racgp_format, patients.file_chart_status, patients.private_billing_concession, patients.private_insurance, patients.memo AS patient_memo, all_images.pk AS fk_image, all_images.image FROM (((((((((((((data_persons persons LEFT JOIN links_persons_addresses link_person_address ON ((persons.pk = link_person_address.fk_person))) LEFT JOIN data_addresses addresses ON ((link_person_address.fk_address = addresses.pk))) LEFT JOIN lu_towns towns ON ((addresses.fk_town = towns.pk))) LEFT JOIN lu_address_types ON ((addresses.fk_lu_address_type = lu_address_types.pk))) LEFT JOIN lu_marital marital ON ((persons.fk_marital = marital.pk))) LEFT JOIN lu_sex sex ON ((persons.fk_sex = sex.pk))) LEFT JOIN lu_title title ON ((persons.fk_title = title.pk))) LEFT JOIN public.all_images ON ((persons.fk_image = all_images.pk))) LEFT JOIN common.lu_ethnicity ethnicity ON ((persons.fk_ethnicity = ethnicity.pk))) LEFT JOIN common.lu_languages languages ON ((persons.fk_language = languages.pk))) LEFT JOIN common.lu_countries countries ON ((persons.country_code = (countries.country_code)::text))) JOIN clerical.data_patients patients ON ((persons.pk = patients.fk_person))) LEFT JOIN common.lu_occupations occupation ON ((persons.fk_occupation = occupation.pk))) ORDER BY patients.fk_person;


--
-- Name: VIEW vwpatients; Type: COMMENT; Schema: contacts; Owner: -
--

COMMENT ON VIEW vwpatients IS 'unique key for this view is pk_view. If the patient has an address then this is in the format 
patient.pk-addresspk (e.g 1-1) otherwise patient.pk-0 (e.g 1-0)';


SET search_path = clerical, pg_catalog;

--
-- Name: vwtaskscomponents; Type: VIEW; Schema: clerical; Owner: -
--

CREATE VIEW vwtaskscomponents AS
    SELECT task_components.pk AS pk_view, tasks.task, tasks.fk_schema, tasks.fk_table, tasks.fk_row, tasks.fk_staff_finalised_task, tasks.date_finalised, tasks.deleted AS task_deleted, tasks.fk_staff_filed_task, vwstaffinclinics.wholename AS staff_filed_task_wholename, vwstaffinclinics.title AS staff_filed_task_title, vwstaffinclinics2.title AS staff_finalised_task_title, vwstaffinclinics2.wholename AS staff_finalised_task_wholename, task_components.pk AS fk_component, task_components.fk_task, task_components.fk_consult, task_components.fk_staff_allocated, task_components.fk_staff_completed, task_components.allocated_staff, task_components.fk_lu_task_type, task_components.fk_urgency, task_components.details, task_components.date_completed AS date_component_completed, task_components.deleted AS component_deleted, vwstaffinclinics1.wholename AS staff_allocated_wholename, vwstaffinclinics1.title AS staff_allocated_title, consult.consult_date AS date_component_logged, vwpatients.town AS patient_town, vwpatients.state AS patient_state, vwpatients.postcode AS patient_postcode, vwpatients.street AS patient_street, vwpatients.fk_person, vwpatients.fk_patient, vwpatients.wholename AS patient_wholename, vwpatients.title AS patient_title, vwpatients.birthdate AS patient_birthdate, lu_task_types.type AS task_type, lu_urgency.urgency FROM ((((((((task_components JOIN tasks ON ((task_components.fk_task = tasks.pk))) JOIN admin.vwstaffinclinics ON ((tasks.fk_staff_filed_task = vwstaffinclinics.fk_staff))) LEFT JOIN admin.vwstaffinclinics vwstaffinclinics1 ON ((task_components.fk_staff_allocated = vwstaffinclinics1.fk_staff))) LEFT JOIN admin.vwstaffinclinics vwstaffinclinics2 ON ((tasks.fk_staff_finalised_task = vwstaffinclinics2.fk_staff))) JOIN clin_consult.consult ON ((task_components.fk_consult = consult.pk))) JOIN contacts.vwpatients ON ((consult.fk_patient = vwpatients.fk_patient))) JOIN lu_task_types ON ((task_components.fk_lu_task_type = lu_task_types.pk))) JOIN common.lu_urgency ON ((task_components.fk_urgency = lu_urgency.pk))) WHERE (task_components.fk_consult > 0) ORDER BY vwpatients.fk_patient, task_components.pk;


--
-- Name: vwtaskscomponentsnotes; Type: VIEW; Schema: clerical; Owner: -
--

CREATE VIEW vwtaskscomponentsnotes AS
    SELECT task_component_notes.pk AS pk_note, task_component_notes.fk_task_component, task_component_notes.note, task_component_notes.date, task_component_notes.fk_staff_made_note, vwstaffinclinics.wholename AS staff_made_note_wholename, vwstaffinclinics.title AS staff_made_note_title, task_components.fk_task FROM ((task_component_notes JOIN admin.vwstaffinclinics ON ((task_component_notes.fk_staff_made_note = vwstaffinclinics.fk_staff))) JOIN task_components ON ((task_component_notes.fk_task_component = task_components.pk)));


SET search_path = clin_allergies, pg_catalog;

--
-- Name: allergies; Type: TABLE; Schema: clin_allergies; Owner: -; Tablespace: 
--

CREATE TABLE allergies (
    pk integer NOT NULL,
    fk_consult integer,
    brand text,
    generic text,
    generic_specific boolean,
    fk_type integer NOT NULL,
    fk_reaction text NOT NULL,
    deleted boolean
);


--
-- Name: allergies_pk_seq; Type: SEQUENCE; Schema: clin_allergies; Owner: -
--

CREATE SEQUENCE allergies_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: allergies_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_allergies; Owner: -
--

ALTER SEQUENCE allergies_pk_seq OWNED BY allergies.pk;


--
-- Name: lu_reaction; Type: TABLE; Schema: clin_allergies; Owner: -; Tablespace: 
--

CREATE TABLE lu_reaction (
    pk integer NOT NULL,
    reaction text NOT NULL
);


--
-- Name: lu_reaction_pk_seq; Type: SEQUENCE; Schema: clin_allergies; Owner: -
--

CREATE SEQUENCE lu_reaction_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_reaction_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_allergies; Owner: -
--

ALTER SEQUENCE lu_reaction_pk_seq OWNED BY lu_reaction.pk;


--
-- Name: lu_type; Type: TABLE; Schema: clin_allergies; Owner: -; Tablespace: 
--

CREATE TABLE lu_type (
    pk integer NOT NULL,
    type text
);


--
-- Name: lu_type_pk_seq; Type: SEQUENCE; Schema: clin_allergies; Owner: -
--

CREATE SEQUENCE lu_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_allergies; Owner: -
--

ALTER SEQUENCE lu_type_pk_seq OWNED BY lu_type.pk;


SET search_path = clin_careplans, pg_catalog;

--
-- Name: careplan_pages; Type: TABLE; Schema: clin_careplans; Owner: -; Tablespace: 
--

CREATE TABLE careplan_pages (
    pk integer NOT NULL,
    fk_condition integer NOT NULL,
    fk_education integer,
    fk_aim integer NOT NULL,
    summary text NOT NULL
);


--
-- Name: TABLE careplan_pages; Type: COMMENT; Schema: clin_careplans; Owner: -
--

COMMENT ON TABLE careplan_pages IS 'Note by default the careplan page does not have a parent, in this case it is a template
 the table careplans links person to multiple careplan pages, which then make up the careplan
 Each care plan page contains the complete html summary of the care plan page, and some (not all) of the
 pointers to care plan components, advice, education, so that it can be re-constructed/deconstructed.
 It will always have a  condition and aim, but may or may
 not have link to education which is not enforced. Any components of the care plan are kept in components_tasks_due';


--
-- Name: COLUMN careplan_pages.fk_condition; Type: COMMENT; Schema: clin_careplans; Owner: -
--

COMMENT ON COLUMN careplan_pages.fk_condition IS 'key to lu_conditions table e.g NIDDM';


--
-- Name: COLUMN careplan_pages.fk_education; Type: COMMENT; Schema: clin_careplans; Owner: -
--

COMMENT ON COLUMN careplan_pages.fk_education IS 'key to lu_education table';


--
-- Name: COLUMN careplan_pages.fk_aim; Type: COMMENT; Schema: clin_careplans; Owner: -
--

COMMENT ON COLUMN careplan_pages.fk_aim IS 'key to lu_aims table e.g -get a life!';


--
-- Name: COLUMN careplan_pages.summary; Type: COMMENT; Schema: clin_careplans; Owner: -
--

COMMENT ON COLUMN careplan_pages.summary IS 'a complete html page which is the careplan for this condition
 and which will stand alone for display or printing';


--
-- Name: careplan_pages_pk_seq; Type: SEQUENCE; Schema: clin_careplans; Owner: -
--

CREATE SEQUENCE careplan_pages_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: careplan_pages_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_careplans; Owner: -
--

ALTER SEQUENCE careplan_pages_pk_seq OWNED BY careplan_pages.pk;


--
-- Name: careplans; Type: TABLE; Schema: clin_careplans; Owner: -; Tablespace: 
--

CREATE TABLE careplans (
    pk integer NOT NULL,
    fk_consult integer NOT NULL
);


--
-- Name: TABLE careplans; Type: COMMENT; Schema: clin_careplans; Owner: -
--

COMMENT ON TABLE careplans IS '
Creates a unique id for a patient care plan and link to consult it is created or changed
note:
The total care plan consists of one or more html pages describing how to manage a condition in the plan
Condition = the disease condition or risk factor
Aim       = the overall aim of the plan e.g Prevent end organ damage due to elevated BSL and vascular complications of diabetes
Components= methods or ways of achieving the aim, ie of managing the diabetes.
	    Each component will have tasks, ir how this component will be made to work
		component(1) could be $$Monitor vision$$
			 Task(1) could be $$Make appointment with opthalmologist$$
		component(2) could be $$Improve physical fitness$$
	                 Task(1) could be $$exercise for 1 hour per day$$
	                 task(2) could be $$Join a gym$$ 
	    These components are then displayed in table format in the final html and can be dissassembled
NotifyUs  = Reasons(1-n) the patient should contact the surgery.
Education = Information to improve patients understanding of their condition.
SamplePlan is available in Clin_careplans.sample table.
';


--
-- Name: COLUMN careplans.fk_consult; Type: COMMENT; Schema: clin_careplans; Owner: -
--

COMMENT ON COLUMN careplans.fk_consult IS 'foreigh key to the clin_consult.consult table (to get the patients id)';


--
-- Name: careplans_pk_seq; Type: SEQUENCE; Schema: clin_careplans; Owner: -
--

CREATE SEQUENCE careplans_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: careplans_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_careplans; Owner: -
--

ALTER SEQUENCE careplans_pk_seq OWNED BY careplans.pk;


--
-- Name: component_task_due; Type: TABLE; Schema: clin_careplans; Owner: -; Tablespace: 
--

CREATE TABLE component_task_due (
    pk integer NOT NULL,
    fk_careplanpage integer NOT NULL,
    fk_component integer NOT NULL,
    fk_task integer NOT NULL,
    fk_responsible integer,
    due date,
    "interval" text
);


--
-- Name: TABLE component_task_due; Type: COMMENT; Schema: clin_careplans; Owner: -
--

COMMENT ON TABLE component_task_due IS 'links a component to a task, and to whoever is responsible
 and when the task falls due';


--
-- Name: COLUMN component_task_due."interval"; Type: COMMENT; Schema: clin_careplans; Owner: -
--

COMMENT ON COLUMN component_task_due."interval" IS 'temporary field containg e.g 12M. Should be two
 fields linked to common.lu_units';


--
-- Name: component_task_due_pk_seq; Type: SEQUENCE; Schema: clin_careplans; Owner: -
--

CREATE SEQUENCE component_task_due_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: component_task_due_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_careplans; Owner: -
--

ALTER SEQUENCE component_task_due_pk_seq OWNED BY component_task_due.pk;


--
-- Name: link_careplanpage_advice; Type: TABLE; Schema: clin_careplans; Owner: -; Tablespace: 
--

CREATE TABLE link_careplanpage_advice (
    pk integer NOT NULL,
    fk_careplanpage integer,
    fk_advice integer
);


--
-- Name: TABLE link_careplanpage_advice; Type: COMMENT; Schema: clin_careplans; Owner: -
--

COMMENT ON TABLE link_careplanpage_advice IS 'Links a careplan page to advice. Note that the same condition could have different advice
depending on eg severity of condition, psychology of the patient etc, hence not linked to the
condition, but the care plan page itself.';


--
-- Name: COLUMN link_careplanpage_advice.fk_careplanpage; Type: COMMENT; Schema: clin_careplans; Owner: -
--

COMMENT ON COLUMN link_careplanpage_advice.fk_careplanpage IS 'foreign key to data_careplanpage';


--
-- Name: COLUMN link_careplanpage_advice.fk_advice; Type: COMMENT; Schema: clin_careplans; Owner: -
--

COMMENT ON COLUMN link_careplanpage_advice.fk_advice IS 'foreign key to lu_advice table';


--
-- Name: link_careplanpage_advice_pk_seq; Type: SEQUENCE; Schema: clin_careplans; Owner: -
--

CREATE SEQUENCE link_careplanpage_advice_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: link_careplanpage_advice_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_careplans; Owner: -
--

ALTER SEQUENCE link_careplanpage_advice_pk_seq OWNED BY link_careplanpage_advice.pk;


--
-- Name: link_careplanpage_components; Type: TABLE; Schema: clin_careplans; Owner: -; Tablespace: 
--

CREATE TABLE link_careplanpage_components (
    pk integer NOT NULL,
    fk_careplanpage integer NOT NULL,
    fk_component integer NOT NULL
);


--
-- Name: TABLE link_careplanpage_components; Type: COMMENT; Schema: clin_careplans; Owner: -
--

COMMENT ON TABLE link_careplanpage_components IS ' links a  careplan page to its component parts';


--
-- Name: link_careplanpage_components_pk_seq; Type: SEQUENCE; Schema: clin_careplans; Owner: -
--

CREATE SEQUENCE link_careplanpage_components_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: link_careplanpage_components_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_careplans; Owner: -
--

ALTER SEQUENCE link_careplanpage_components_pk_seq OWNED BY link_careplanpage_components.pk;


--
-- Name: link_careplanpages_careplan; Type: TABLE; Schema: clin_careplans; Owner: -; Tablespace: 
--

CREATE TABLE link_careplanpages_careplan (
    pk integer NOT NULL,
    fk_careplan integer NOT NULL,
    fk_careplanpage integer NOT NULL
);


--
-- Name: TABLE link_careplanpages_careplan; Type: COMMENT; Schema: clin_careplans; Owner: -
--

COMMENT ON TABLE link_careplanpages_careplan IS 'links a care plan  to its consituant pages';


--
-- Name: COLUMN link_careplanpages_careplan.fk_careplan; Type: COMMENT; Schema: clin_careplans; Owner: -
--

COMMENT ON COLUMN link_careplanpages_careplan.fk_careplan IS 'key to clin_careplans.careplan table';


--
-- Name: COLUMN link_careplanpages_careplan.fk_careplanpage; Type: COMMENT; Schema: clin_careplans; Owner: -
--

COMMENT ON COLUMN link_careplanpages_careplan.fk_careplanpage IS 'key to clin_careplans.careplan_pages table';


--
-- Name: link_careplanpages_careplan_pk_seq; Type: SEQUENCE; Schema: clin_careplans; Owner: -
--

CREATE SEQUENCE link_careplanpages_careplan_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: link_careplanpages_careplan_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_careplans; Owner: -
--

ALTER SEQUENCE link_careplanpages_careplan_pk_seq OWNED BY link_careplanpages_careplan.pk;


--
-- Name: lu_advice; Type: TABLE; Schema: clin_careplans; Owner: -; Tablespace: 
--

CREATE TABLE lu_advice (
    pk integer NOT NULL,
    advice text NOT NULL
);


--
-- Name: TABLE lu_advice; Type: COMMENT; Schema: clin_careplans; Owner: -
--

COMMENT ON TABLE lu_advice IS 'Advice to be printed on the care plan re the condition';


--
-- Name: COLUMN lu_advice.advice; Type: COMMENT; Schema: clin_careplans; Owner: -
--

COMMENT ON COLUMN lu_advice.advice IS 'advice printed on care plan e.g ring if chest pains';


--
-- Name: lu_advice_pk_seq; Type: SEQUENCE; Schema: clin_careplans; Owner: -
--

CREATE SEQUENCE lu_advice_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_advice_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_careplans; Owner: -
--

ALTER SEQUENCE lu_advice_pk_seq OWNED BY lu_advice.pk;


--
-- Name: lu_aims; Type: TABLE; Schema: clin_careplans; Owner: -; Tablespace: 
--

CREATE TABLE lu_aims (
    pk integer NOT NULL,
    aim text NOT NULL
);


--
-- Name: lu_aims_pk_seq; Type: SEQUENCE; Schema: clin_careplans; Owner: -
--

CREATE SEQUENCE lu_aims_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_aims_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_careplans; Owner: -
--

ALTER SEQUENCE lu_aims_pk_seq OWNED BY lu_aims.pk;


--
-- Name: lu_components; Type: TABLE; Schema: clin_careplans; Owner: -; Tablespace: 
--

CREATE TABLE lu_components (
    pk integer NOT NULL,
    component text NOT NULL
);


--
-- Name: TABLE lu_components; Type: COMMENT; Schema: clin_careplans; Owner: -
--

COMMENT ON TABLE lu_components IS 'A component is a part of a care plan describing
  something that needs to be acheived eg.
  component could be - lose weight - or - increase physical fitness';


--
-- Name: lu_components_pk_seq; Type: SEQUENCE; Schema: clin_careplans; Owner: -
--

CREATE SEQUENCE lu_components_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_components_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_careplans; Owner: -
--

ALTER SEQUENCE lu_components_pk_seq OWNED BY lu_components.pk;


--
-- Name: lu_conditions; Type: TABLE; Schema: clin_careplans; Owner: -; Tablespace: 
--

CREATE TABLE lu_conditions (
    pk integer NOT NULL,
    condition text NOT NULL,
    fk_condition_code integer NOT NULL
);


--
-- Name: TABLE lu_conditions; Type: COMMENT; Schema: clin_careplans; Owner: -
--

COMMENT ON TABLE lu_conditions IS 'Look up table of conditions (should be snomed)';


--
-- Name: COLUMN lu_conditions.condition; Type: COMMENT; Schema: clin_careplans; Owner: -
--

COMMENT ON COLUMN lu_conditions.condition IS 'condition eg diabetes, hypertension
Later need to make this just a snomed code';


--
-- Name: COLUMN lu_conditions.fk_condition_code; Type: COMMENT; Schema: clin_careplans; Owner: -
--

COMMENT ON COLUMN lu_conditions.fk_condition_code IS 'key to codings.lu_reason table FIXME
this is confusing and ambiguous because of reasons in the care plan schema';


--
-- Name: lu_conditions_pk_seq; Type: SEQUENCE; Schema: clin_careplans; Owner: -
--

CREATE SEQUENCE lu_conditions_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_conditions_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_careplans; Owner: -
--

ALTER SEQUENCE lu_conditions_pk_seq OWNED BY lu_conditions.pk;


--
-- Name: lu_education; Type: TABLE; Schema: clin_careplans; Owner: -; Tablespace: 
--

CREATE TABLE lu_education (
    pk integer NOT NULL,
    education text
);


--
-- Name: COLUMN lu_education.education; Type: COMMENT; Schema: clin_careplans; Owner: -
--

COMMENT ON COLUMN lu_education.education IS 'text of education e.g all about hypertension';


--
-- Name: lu_education_pk_seq; Type: SEQUENCE; Schema: clin_careplans; Owner: -
--

CREATE SEQUENCE lu_education_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_education_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_careplans; Owner: -
--

ALTER SEQUENCE lu_education_pk_seq OWNED BY lu_education.pk;


--
-- Name: lu_responsible; Type: TABLE; Schema: clin_careplans; Owner: -; Tablespace: 
--

CREATE TABLE lu_responsible (
    pk integer NOT NULL,
    responsible text NOT NULL
);


--
-- Name: TABLE lu_responsible; Type: COMMENT; Schema: clin_careplans; Owner: -
--

COMMENT ON TABLE lu_responsible IS 'the person responsible for implementing a component of a care plan
  this preferably should be generic eg Dr, GP, Practice Nurse, Secretary
  Patient, but can be specific eg Dr Imthe BestDoctor';


--
-- Name: lu_responsible_pk_seq; Type: SEQUENCE; Schema: clin_careplans; Owner: -
--

CREATE SEQUENCE lu_responsible_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_responsible_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_careplans; Owner: -
--

ALTER SEQUENCE lu_responsible_pk_seq OWNED BY lu_responsible.pk;


--
-- Name: lu_tasks; Type: TABLE; Schema: clin_careplans; Owner: -; Tablespace: 
--

CREATE TABLE lu_tasks (
    pk integer NOT NULL,
    task text NOT NULL
);


--
-- Name: TABLE lu_tasks; Type: COMMENT; Schema: clin_careplans; Owner: -
--

COMMENT ON TABLE lu_tasks IS 'A task is something that needs to be done to acheive one of the 
 goals in a care plan e.g:
 What to acheive is - improve physical fitness
 Task could be - exercise 1 hour per day or -joint a gym';


--
-- Name: lu_tasks_pk_seq; Type: SEQUENCE; Schema: clin_careplans; Owner: -
--

CREATE SEQUENCE lu_tasks_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_tasks_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_careplans; Owner: -
--

ALTER SEQUENCE lu_tasks_pk_seq OWNED BY lu_tasks.pk;


--
-- Name: sample_plan; Type: TABLE; Schema: clin_careplans; Owner: -; Tablespace: 
--

CREATE TABLE sample_plan (
    html text
);


--
-- Name: test; Type: TABLE; Schema: clin_careplans; Owner: -; Tablespace: 
--

CREATE TABLE test (
    somedata text[]
);


SET search_path = clin_certificates, pg_catalog;

--
-- Name: lu_illness_temporality; Type: TABLE; Schema: clin_certificates; Owner: -; Tablespace: 
--

CREATE TABLE lu_illness_temporality (
    pk integer NOT NULL,
    temporality text NOT NULL
);


--
-- Name: TABLE lu_illness_temporality; Type: COMMENT; Schema: clin_certificates; Owner: -
--

COMMENT ON TABLE lu_illness_temporality IS 'dictionary defination: of or relating to the sequence of time or to a particular time
 in our case a lookup table to indicate in past, now, in the future';


--
-- Name: COLUMN lu_illness_temporality.temporality; Type: COMMENT; Schema: clin_certificates; Owner: -
--

COMMENT ON COLUMN lu_illness_temporality.temporality IS 'text contents: is - was - will be';


--
-- Name: lu_illness_temporality_pk_seq; Type: SEQUENCE; Schema: clin_certificates; Owner: -
--

CREATE SEQUENCE lu_illness_temporality_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_illness_temporality_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_certificates; Owner: -
--

ALTER SEQUENCE lu_illness_temporality_pk_seq OWNED BY lu_illness_temporality.pk;


--
-- Name: medical_certificate; Type: TABLE; Schema: clin_certificates; Owner: -; Tablespace: 
--

CREATE TABLE medical_certificate (
    pk integer NOT NULL,
    fk_patient integer NOT NULL,
    fk_consult integer NOT NULL,
    reason text,
    fk_coding_system integer,
    fk_code text,
    fk_lu_illness_temporality integer NOT NULL,
    from_date date NOT NULL,
    to_date date,
    deleted boolean DEFAULT false
);


--
-- Name: TABLE medical_certificate; Type: COMMENT; Schema: clin_certificates; Owner: -
--

COMMENT ON TABLE medical_certificate IS 'a table to save medical certificates';


--
-- Name: COLUMN medical_certificate.fk_patient; Type: COMMENT; Schema: clin_certificates; Owner: -
--

COMMENT ON COLUMN medical_certificate.fk_patient IS 'foreign key to clerical.data_patients';


--
-- Name: COLUMN medical_certificate.fk_consult; Type: COMMENT; Schema: clin_certificates; Owner: -
--

COMMENT ON COLUMN medical_certificate.fk_consult IS 'foreign key to clin_consult.consult table identifies consult date and staff member';


--
-- Name: COLUMN medical_certificate.reason; Type: COMMENT; Schema: clin_certificates; Owner: -
--

COMMENT ON COLUMN medical_certificate.reason IS 'temporary concession to non-coders, the text reason for the certificate';


--
-- Name: COLUMN medical_certificate.fk_coding_system; Type: COMMENT; Schema: clin_certificates; Owner: -
--

COMMENT ON COLUMN medical_certificate.fk_coding_system IS 'key to coding.lu_coding_system containing name of coding system eg icpc, icd10';


--
-- Name: COLUMN medical_certificate.fk_code; Type: COMMENT; Schema: clin_certificates; Owner: -
--

COMMENT ON COLUMN medical_certificate.fk_code IS 'the coded reason for the illness eg N18';


--
-- Name: COLUMN medical_certificate.fk_lu_illness_temporality; Type: COMMENT; Schema: clin_certificates; Owner: -
--

COMMENT ON COLUMN medical_certificate.fk_lu_illness_temporality IS 'foreign key to fk_lu_illness_temporality table to tell temporal nature of the certificate
 i.e was sick, is sick, will be sick';


--
-- Name: COLUMN medical_certificate.from_date; Type: COMMENT; Schema: clin_certificates; Owner: -
--

COMMENT ON COLUMN medical_certificate.from_date IS 'Date from which the person was unwell';


--
-- Name: COLUMN medical_certificate.to_date; Type: COMMENT; Schema: clin_certificates; Owner: -
--

COMMENT ON COLUMN medical_certificate.to_date IS 'Date to which the person will be unwell';


--
-- Name: COLUMN medical_certificate.deleted; Type: COMMENT; Schema: clin_certificates; Owner: -
--

COMMENT ON COLUMN medical_certificate.deleted IS 'if true the record is marked as deleted';


--
-- Name: medical_certificate_pk_seq; Type: SEQUENCE; Schema: clin_certificates; Owner: -
--

CREATE SEQUENCE medical_certificate_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: medical_certificate_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_certificates; Owner: -
--

ALTER SEQUENCE medical_certificate_pk_seq OWNED BY medical_certificate.pk;


--
-- Name: vwmedicalcertificates; Type: VIEW; Schema: clin_certificates; Owner: -
--

CREATE VIEW vwmedicalcertificates AS
    SELECT medical_certificate.pk AS pk_medicalcertificate, medical_certificate.fk_patient, medical_certificate.fk_consult, medical_certificate.reason, medical_certificate.fk_coding_system, medical_certificate.fk_code, medical_certificate.fk_lu_illness_temporality, medical_certificate.from_date, medical_certificate.deleted, medical_certificate.to_date, consult.consult_date AS date_issued, consult.fk_staff, vwstaffinclinics.wholename AS staff_wholename, vwstaffinclinics.title AS staff_title, vwstaffinclinics.branch AS staff_branch, vwstaffinclinics.organisation AS staff_organisation, vwstaffinclinics.street AS staff_street, vwstaffinclinics.town AS staff_town, vwstaffinclinics.postcode AS staff_postcode, vwstaffinclinics.provider_number AS staff_provider_number, lu_illness_temporality.temporality FROM (((medical_certificate JOIN clin_consult.consult ON ((medical_certificate.fk_consult = consult.pk))) JOIN admin.vwstaffinclinics ON ((consult.fk_staff = vwstaffinclinics.fk_staff))) JOIN lu_illness_temporality ON ((medical_certificate.fk_lu_illness_temporality = lu_illness_temporality.pk))) WHERE (medical_certificate.deleted = false) ORDER BY medical_certificate.fk_patient, consult.consult_date;


--
-- Name: VIEW vwmedicalcertificates; Type: COMMENT; Schema: clin_certificates; Owner: -
--

COMMENT ON VIEW vwmedicalcertificates IS 'A view of patients medical certificate history, includes written by which staff member and where';


SET search_path = clin_checkups, pg_catalog;

--
-- Name: annual_checkup; Type: TABLE; Schema: clin_checkups; Owner: -; Tablespace: 
--

CREATE TABLE annual_checkup (
    pk integer NOT NULL,
    pk_consult integer,
    patient_concerns text,
    "system _review" text,
    centralnervoussystem_sysreview boolean DEFAULT false,
    earnosethroat_sysreview boolean DEFAULT false,
    cardiovascular_sysreview boolean DEFAULT false,
    respiratory_sysreview boolean DEFAULT false,
    muskuloskeletal_sysreview boolean DEFAULT false,
    gastrointestinal_sysreview boolean DEFAULT false,
    genitourinary_sysreview boolean DEFAULT false,
    endocrine_sysreview boolean DEFAULT false,
    haemopoetic_sysreview boolean DEFAULT false,
    fk_height integer,
    fk_weight numeric,
    bmi numeric,
    overweight_kg numeric,
    fk_bp numeric,
    fk_bsl numeric,
    fk_urinalysis text,
    clinical_notes text,
    summary text,
    consultation_html text
);


--
-- Name: TABLE annual_checkup; Type: COMMENT; Schema: clin_checkups; Owner: -
--

COMMENT ON TABLE annual_checkup IS 'Describes a persons annual checkup';


--
-- Name: annual_checkup_pk_seq; Type: SEQUENCE; Schema: clin_checkups; Owner: -
--

CREATE SEQUENCE annual_checkup_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: annual_checkup_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_checkups; Owner: -
--

ALTER SEQUENCE annual_checkup_pk_seq OWNED BY annual_checkup.pk;


--
-- Name: lu_nutrition_questions; Type: TABLE; Schema: clin_checkups; Owner: -; Tablespace: 
--

CREATE TABLE lu_nutrition_questions (
    pk integer NOT NULL,
    question text NOT NULL,
    red_flag_text text
);


--
-- Name: TABLE lu_nutrition_questions; Type: COMMENT; Schema: clin_checkups; Owner: -
--

COMMENT ON TABLE lu_nutrition_questions IS 'The questions to determinate patients state of nuitrition';


--
-- Name: COLUMN lu_nutrition_questions.question; Type: COMMENT; Schema: clin_checkups; Owner: -
--

COMMENT ON COLUMN lu_nutrition_questions.question IS 'the question e.g do you have enough money for food?';


--
-- Name: COLUMN lu_nutrition_questions.red_flag_text; Type: COMMENT; Schema: clin_checkups; Owner: -
--

COMMENT ON COLUMN lu_nutrition_questions.red_flag_text IS 'the question translated e.g may not have enough money to buy food and may be null';


--
-- Name: lu_nutrition_questions_pk_seq; Type: SEQUENCE; Schema: clin_checkups; Owner: -
--

CREATE SEQUENCE lu_nutrition_questions_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_nutrition_questions_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_checkups; Owner: -
--

ALTER SEQUENCE lu_nutrition_questions_pk_seq OWNED BY lu_nutrition_questions.pk;


--
-- Name: lu_state_of_health; Type: TABLE; Schema: clin_checkups; Owner: -; Tablespace: 
--

CREATE TABLE lu_state_of_health (
    pk integer NOT NULL,
    state_of_health text NOT NULL
);


--
-- Name: TABLE lu_state_of_health; Type: COMMENT; Schema: clin_checkups; Owner: -
--

COMMENT ON TABLE lu_state_of_health IS 'The general state of the patients health';


--
-- Name: COLUMN lu_state_of_health.state_of_health; Type: COMMENT; Schema: clin_checkups; Owner: -
--

COMMENT ON COLUMN lu_state_of_health.state_of_health IS 'excellent, very good, good, fair, poor, indeterminate';


--
-- Name: lu_state_of_health_pk_seq; Type: SEQUENCE; Schema: clin_checkups; Owner: -
--

CREATE SEQUENCE lu_state_of_health_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_state_of_health_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_checkups; Owner: -
--

ALTER SEQUENCE lu_state_of_health_pk_seq OWNED BY lu_state_of_health.pk;


--
-- Name: over75; Type: TABLE; Schema: clin_checkups; Owner: -; Tablespace: 
--

CREATE TABLE over75 (
    pk integer NOT NULL,
    fk_lu_consult_type integer NOT NULL,
    fk_lu_state_of_health integer NOT NULL,
    systems_reviewed boolean,
    fk_lu_smoking_status integer,
    alcohol_gm_per_day integer,
    consider_alcohol_audit_tool boolean,
    exercise boolean,
    foot_problems boolean,
    visual_acuity text,
    lu_hearing_aid_status integer,
    fk_lu_earcanal_status integer,
    fk_lu_whisper_test integer,
    fit_to_drive boolean,
    urinary_incontinence boolean,
    fk_bowel_trouble boolean,
    system_review_comments text,
    other_health_professionals text,
    mentalstatus_problems boolean,
    mentalstatus_consider_assessment_tool boolean,
    fk_lu_companion_status integer,
    fk_lu_social_support integer,
    independance_have_carer boolean,
    independance_is_carer boolean,
    fk_lu_depression_degree boolean,
    mood_difficulty_sleeping boolean,
    mood_consider_assessement_tool boolean,
    nuitrition_dentures_yes_no boolean,
    nuitrition_denture_problems boolean,
    nuitrition_eating_less boolean,
    nuitrition_3meals_per_day boolean,
    nuitrition_fruit_n_veg boolean,
    nuitrition_dairy boolean,
    nuitrition_excess_alcohol boolean,
    nuitrition_adequate_fluids boolean,
    nuitrition_swallowing_problems boolean,
    nuitrition_enough_money boolean,
    nuitrition_eat_alone boolean,
    nuitrition_lots_of_medications boolean,
    nuitrition_weight_change boolean,
    nuitrition_shop_cook_feed boolean,
    mobility_aid_indoors boolean,
    mobility_aid_outdoors boolean,
    mobility_bath_shower boolean,
    mobility_bend_kneel boolean,
    mobility_walk100meters boolean,
    mobility_use_steps boolean,
    mobility_reach_overhead boolean,
    mobility_no_clutter boolean,
    mobility_adequate_lighting boolean,
    mobility_free_of_falls boolean,
    mobility_actions_suggested text,
    home_safety_use_chairs boolean,
    home_safety_use_bed boolean,
    home_safety_use_light boolean,
    home_safety_use_toilet boolean,
    home_safety_flooring_secured boolean,
    home_safety_use_bath_mats boolean,
    home_safety_carry_meals boolean,
    home_safety_use_utensils boolean,
    home_safety_see_stairs boolean,
    home_safety_actions_suggested text
);


--
-- Name: COLUMN over75.fk_lu_consult_type; Type: COMMENT; Schema: clin_checkups; Owner: -
--

COMMENT ON COLUMN over75.fk_lu_consult_type IS 'foreign key to consult.lu_consult_type table eg home visit';


--
-- Name: COLUMN over75.fk_lu_state_of_health; Type: COMMENT; Schema: clin_checkups; Owner: -
--

COMMENT ON COLUMN over75.fk_lu_state_of_health IS 'foreign key to clin_checkups.fk_lu_state_of_health table';


--
-- Name: COLUMN over75.fk_lu_smoking_status; Type: COMMENT; Schema: clin_checkups; Owner: -
--

COMMENT ON COLUMN over75.fk_lu_smoking_status IS 'foreign key to clin_checkups.lu_lu_smoking_status';


--
-- Name: COLUMN over75.fk_lu_earcanal_status; Type: COMMENT; Schema: clin_checkups; Owner: -
--

COMMENT ON COLUMN over75.fk_lu_earcanal_status IS 'references common.lu_normality';


--
-- Name: over75_pk_seq; Type: SEQUENCE; Schema: clin_checkups; Owner: -
--

CREATE SEQUENCE over75_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: over75_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_checkups; Owner: -
--

ALTER SEQUENCE over75_pk_seq OWNED BY over75.pk;


SET search_path = clin_consult, pg_catalog;

--
-- Name: consult_pk_seq; Type: SEQUENCE; Schema: clin_consult; Owner: -
--

CREATE SEQUENCE consult_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: consult_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_consult; Owner: -
--

ALTER SEQUENCE consult_pk_seq OWNED BY consult.pk;


--
-- Name: images; Type: TABLE; Schema: clin_consult; Owner: -; Tablespace: 
--

CREATE TABLE images (
    pk integer NOT NULL,
    image bytea,
    deleted boolean
);


--
-- Name: images_pk_seq; Type: SEQUENCE; Schema: clin_consult; Owner: -
--

CREATE SEQUENCE images_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: images_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_consult; Owner: -
--

ALTER SEQUENCE images_pk_seq OWNED BY images.pk;


--
-- Name: lu_consult_type; Type: TABLE; Schema: clin_consult; Owner: -; Tablespace: 
--

CREATE TABLE lu_consult_type (
    pk integer NOT NULL,
    type text NOT NULL
);


--
-- Name: lu_consult_type_pk_seq; Type: SEQUENCE; Schema: clin_consult; Owner: -
--

CREATE SEQUENCE lu_consult_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_consult_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_consult; Owner: -
--

ALTER SEQUENCE lu_consult_type_pk_seq OWNED BY lu_consult_type.pk;


--
-- Name: lu_progressnotes_sections_pk_seq; Type: SEQUENCE; Schema: clin_consult; Owner: -
--

CREATE SEQUENCE lu_progressnotes_sections_pk_seq
    START WITH 20
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_progressnotes_sections_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_consult; Owner: -
--

ALTER SEQUENCE lu_progressnotes_sections_pk_seq OWNED BY lu_progressnotes_sections.pk;


--
-- Name: lu_scratchpad_status; Type: TABLE; Schema: clin_consult; Owner: -; Tablespace: 
--

CREATE TABLE lu_scratchpad_status (
    pk integer NOT NULL,
    status text
);


--
-- Name: TABLE lu_scratchpad_status; Type: COMMENT; Schema: clin_consult; Owner: -
--

COMMENT ON TABLE lu_scratchpad_status IS 'Current status of the scrathpad item 
e.g outstanding
    compeleted
    completed with explanation
    marked as deleted
    ';


--
-- Name: lu_scratchpad_status_pk_seq; Type: SEQUENCE; Schema: clin_consult; Owner: -
--

CREATE SEQUENCE lu_scratchpad_status_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_scratchpad_status_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_consult; Owner: -
--

ALTER SEQUENCE lu_scratchpad_status_pk_seq OWNED BY lu_scratchpad_status.pk;


--
-- Name: progressnotes; Type: TABLE; Schema: clin_consult; Owner: -; Tablespace: 
--

CREATE TABLE progressnotes (
    pk integer NOT NULL,
    fk_consult integer,
    notes text,
    fk_section integer,
    fk_code bigint,
    problem text,
    fk_problem integer,
    fk_audit_action integer,
    display boolean DEFAULT true
);


--
-- Name: progressnotes_pk_seq; Type: SEQUENCE; Schema: clin_consult; Owner: -
--

CREATE SEQUENCE progressnotes_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: progressnotes_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_consult; Owner: -
--

ALTER SEQUENCE progressnotes_pk_seq OWNED BY progressnotes.pk;


--
-- Name: scratchpad; Type: TABLE; Schema: clin_consult; Owner: -; Tablespace: 
--

CREATE TABLE scratchpad (
    pk integer NOT NULL,
    fk_consult integer,
    note text,
    deleted boolean DEFAULT false,
    fk_lu_status integer NOT NULL,
    fk_progressnote integer
);


--
-- Name: COLUMN scratchpad.fk_progressnote; Type: COMMENT; Schema: clin_consult; Owner: -
--

COMMENT ON COLUMN scratchpad.fk_progressnote IS 'foreign key to clin_consult.progressnotes, points to the last progress note entry for this item';


--
-- Name: scratchpad_pk_seq; Type: SEQUENCE; Schema: clin_consult; Owner: -
--

CREATE SEQUENCE scratchpad_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: scratchpad_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_consult; Owner: -
--

ALTER SEQUENCE scratchpad_pk_seq OWNED BY scratchpad.pk;


--
-- Name: vwprogressnotes; Type: VIEW; Schema: clin_consult; Owner: -
--

CREATE VIEW vwprogressnotes AS
    SELECT "CONSULT".fk_patient, "PROGRESSNOTES".pk AS pk_progressnote, "CONSULT".consult_date, "CONSULT_TYPE".type AS consult_type, "CONSULT_TYPE".pk AS fk_lu_consult_type, "SECTION".section, "PROGRESSNOTES".problem, "PROGRESSNOTES".notes, "CONSULT".summary, "PROGRESSNOTES".fk_consult, "PROGRESSNOTES".fk_section, "PROGRESSNOTES".fk_code, "PROGRESSNOTES".fk_problem, "PROGRESSNOTES".fk_audit_action, "PROGRESSNOTES".display, "CONSULT".fk_staff, "CONSULT".fk_type, "AUDITACTIONS".pk AS fk_action, "AUDITACTIONS".status AS audit_action, data_persons.firstname, data_persons.surname, lu_title.title FROM (((((((progressnotes "PROGRESSNOTES" JOIN consult "CONSULT" ON (("PROGRESSNOTES".fk_consult = "CONSULT".pk))) LEFT JOIN lu_consult_type "CONSULT_TYPE" ON (("CONSULT".fk_type = "CONSULT_TYPE".pk))) LEFT JOIN lu_progressnotes_sections "SECTION" ON (("PROGRESSNOTES".fk_section = "SECTION".pk))) LEFT JOIN audit.lu_status "AUDITACTIONS" ON (("PROGRESSNOTES".fk_audit_action = "AUDITACTIONS".pk))) JOIN admin.staff ON (("CONSULT".fk_staff = staff.pk))) JOIN contacts.data_persons ON ((staff.fk_person = data_persons.pk))) JOIN contacts.lu_title ON ((data_persons.fk_title = lu_title.pk))) WHERE (("CONSULT_TYPE".pk <> 8) AND ("PROGRESSNOTES".display = true)) ORDER BY "CONSULT".fk_patient, "CONSULT".consult_date, "CONSULT".fk_staff, "SECTION".pk, "PROGRESSNOTES".fk_problem;


--
-- Name: vwscratchpad; Type: VIEW; Schema: clin_consult; Owner: -
--

CREATE VIEW vwscratchpad AS
    SELECT consult.fk_patient, scratchpad.pk AS pk_scratchpad, scratchpad.fk_consult, scratchpad.note, consult.consult_date, consult.fk_staff, lu_title.title, data_persons.firstname, data_persons.surname, ((data_persons.firstname || ' '::text) || data_persons.surname) AS wholename, scratchpad.deleted, scratchpad.fk_lu_status AS fk_status, scratchpad.fk_progressnote FROM ((((scratchpad JOIN consult ON ((scratchpad.fk_consult = consult.pk))) JOIN admin.staff ON ((consult.fk_staff = staff.pk))) JOIN contacts.data_persons ON ((staff.fk_person = data_persons.pk))) LEFT JOIN contacts.lu_title ON ((data_persons.fk_title = lu_title.pk))) ORDER BY consult.fk_patient, consult.consult_date;


--
-- Name: vwscratchpadaudit; Type: VIEW; Schema: clin_consult; Owner: -
--

CREATE VIEW vwscratchpadaudit AS
    SELECT vwaudit.pk_view, vwaudit.fk_patient, vwaudit.date_audit, vwaudit.data_summary, vwaudit.audit_trail_reason, vwaudit.altered_by_title, vwaudit.altered_by_name, vwaudit.schema, vwaudit.fk_schema, vwaudit.tablename, vwaudit.fk_table, vwaudit.fk_row, vwaudit.fk_consult, vwaudit.fk_lu_reason, vwaudit.action, vwaudit.fk_action, vwaudit.fk_section, vwaudit.section, scratchpad.note FROM (audit.vwaudit JOIN scratchpad ON ((vwaudit.fk_row = scratchpad.pk))) WHERE ((vwaudit.schema = 'clin_consult'::text) AND (vwaudit.tablename = 'scratchpad'::text)) ORDER BY vwaudit.fk_patient, vwaudit.fk_row, vwaudit.date_audit;


SET search_path = clin_history, pg_catalog;

--
-- Name: care_plan_components_due; Type: TABLE; Schema: clin_history; Owner: -; Tablespace: 
--

CREATE TABLE care_plan_components_due (
    pk integer NOT NULL,
    fk_pasthistory integer NOT NULL,
    fk_component integer NOT NULL,
    due date
);


--
-- Name: TABLE care_plan_components_due; Type: COMMENT; Schema: clin_history; Owner: -
--

COMMENT ON TABLE care_plan_components_due IS 'links a health issue - fk_pasthistory - to a component of care and when it is due. As each fk_pasthistory is unique to a patient and not re-used, this key identifies the patient or visa-versa - i.e the patient''s past history item or health issue identifies its care plan components.';


--
-- Name: COLUMN care_plan_components_due.fk_pasthistory; Type: COMMENT; Schema: clin_history; Owner: -
--

COMMENT ON COLUMN care_plan_components_due.fk_pasthistory IS 'foreign key references clin_history.past_history.pk';


--
-- Name: COLUMN care_plan_components_due.fk_component; Type: COMMENT; Schema: clin_history; Owner: -
--

COMMENT ON COLUMN care_plan_components_due.fk_component IS 'foreign key references clin_history.care_plan_components.pk';


--
-- Name: COLUMN care_plan_components_due.due; Type: COMMENT; Schema: clin_history; Owner: -
--

COMMENT ON COLUMN care_plan_components_due.due IS 'date the comment is due to be done';


--
-- Name: care_plan_components_due_pk_seq; Type: SEQUENCE; Schema: clin_history; Owner: -
--

CREATE SEQUENCE care_plan_components_due_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: care_plan_components_due_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_history; Owner: -
--

ALTER SEQUENCE care_plan_components_due_pk_seq OWNED BY care_plan_components_due.pk;


--
-- Name: data_recreational_drugs; Type: TABLE; Schema: clin_history; Owner: -; Tablespace: 
--

CREATE TABLE data_recreational_drugs (
    pk integer NOT NULL,
    fk_consult integer,
    fk_drug integer,
    notes text,
    deleted boolean
);


--
-- Name: data_recreational_drugs_pk_seq; Type: SEQUENCE; Schema: clin_history; Owner: -
--

CREATE SEQUENCE data_recreational_drugs_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: data_recreational_drugs_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_history; Owner: -
--

ALTER SEQUENCE data_recreational_drugs_pk_seq OWNED BY data_recreational_drugs.pk;


--
-- Name: family_conditions; Type: TABLE; Schema: clin_history; Owner: -; Tablespace: 
--

CREATE TABLE family_conditions (
    pk integer NOT NULL,
    fk_member integer NOT NULL,
    condition text NOT NULL,
    fk_reason integer,
    age_of_onset integer,
    cause_of_death boolean DEFAULT false,
    notes text,
    deleted boolean DEFAULT false,
    fk_consult integer,
    contributed_to_death boolean
);


--
-- Name: COLUMN family_conditions.condition; Type: COMMENT; Schema: clin_history; Owner: -
--

COMMENT ON COLUMN family_conditions.condition IS 'note: the condition may NEVER exist in the coded database, so it must be stored here. fk_reason will only exist if it is a coded reaosn';


--
-- Name: family_conditions_pk_seq; Type: SEQUENCE; Schema: clin_history; Owner: -
--

CREATE SEQUENCE family_conditions_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: family_conditions_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_history; Owner: -
--

ALTER SEQUENCE family_conditions_pk_seq OWNED BY family_conditions.pk;


--
-- Name: family_links; Type: TABLE; Schema: clin_history; Owner: -; Tablespace: 
--

CREATE TABLE family_links (
    pk integer NOT NULL,
    fk_member integer NOT NULL,
    fk_patient integer NOT NULL,
    deleted boolean DEFAULT false
);


--
-- Name: family_links_pk_seq; Type: SEQUENCE; Schema: clin_history; Owner: -
--

CREATE SEQUENCE family_links_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: family_links_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_history; Owner: -
--

ALTER SEQUENCE family_links_pk_seq OWNED BY family_links.pk;


--
-- Name: family_members; Type: TABLE; Schema: clin_history; Owner: -; Tablespace: 
--

CREATE TABLE family_members (
    pk integer NOT NULL,
    fk_relationship integer NOT NULL,
    fk_person integer,
    name text,
    birthdate date,
    age_of_death integer,
    fk_occupation integer,
    fk_country_birth character(2),
    deleted boolean DEFAULT false,
    fk_consult integer
);


--
-- Name: COLUMN family_members.fk_person; Type: COMMENT; Schema: clin_history; Owner: -
--

COMMENT ON COLUMN family_members.fk_person IS 'I put this in in-case it was needed if we had imported family history from an person who exists in the easygp database.';


--
-- Name: family_members_pk_seq; Type: SEQUENCE; Schema: clin_history; Owner: -
--

CREATE SEQUENCE family_members_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: family_members_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_history; Owner: -
--

ALTER SEQUENCE family_members_pk_seq OWNED BY family_members.pk;


--
-- Name: hospitalisations; Type: TABLE; Schema: clin_history; Owner: -; Tablespace: 
--

CREATE TABLE hospitalisations (
    pk integer NOT NULL,
    admission_date date,
    discharge_date date,
    pk_person integer,
    specialist_name text,
    diagnosis text
);


--
-- Name: TABLE hospitalisations; Type: COMMENT; Schema: clin_history; Owner: -
--

COMMENT ON TABLE hospitalisations IS 'if specialist exists in contacts use pk_person';


--
-- Name: hospitalisations_pk_seq; Type: SEQUENCE; Schema: clin_history; Owner: -
--

CREATE SEQUENCE hospitalisations_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: hospitalisations_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_history; Owner: -
--

ALTER SEQUENCE hospitalisations_pk_seq OWNED BY hospitalisations.pk;


--
-- Name: lu_careplan_components; Type: TABLE; Schema: clin_history; Owner: -; Tablespace: 
--

CREATE TABLE lu_careplan_components (
    pk integer NOT NULL,
    component text NOT NULL
);


--
-- Name: TABLE lu_careplan_components; Type: COMMENT; Schema: clin_history; Owner: -
--

COMMENT ON TABLE lu_careplan_components IS 'table containing all the components available for care planning';


--
-- Name: COLUMN lu_careplan_components.component; Type: COMMENT; Schema: clin_history; Owner: -
--

COMMENT ON COLUMN lu_careplan_components.component IS 'a component of a care plan e.g HBA1c or visit opthalmologist';


--
-- Name: lu_careplan_components_pk_seq; Type: SEQUENCE; Schema: clin_history; Owner: -
--

CREATE SEQUENCE lu_careplan_components_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_careplan_components_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_history; Owner: -
--

ALTER SEQUENCE lu_careplan_components_pk_seq OWNED BY lu_careplan_components.pk;


--
-- Name: lu_dacc_components; Type: TABLE; Schema: clin_history; Owner: -; Tablespace: 
--

CREATE TABLE lu_dacc_components (
    pk integer NOT NULL,
    fk_component integer NOT NULL
);


--
-- Name: TABLE lu_dacc_components; Type: COMMENT; Schema: clin_history; Owner: -
--

COMMENT ON TABLE lu_dacc_components IS 'Specific to Australian Government requirements for billing care of diabetics is the so 
  called Diabetic Annual Cycle of Care (DACC). This table keeps linkages to the 
  lu_careplan_components table for those components needed
  This table is purely to enable quick pulling in of DACC for the health issues section';


--
-- Name: COLUMN lu_dacc_components.fk_component; Type: COMMENT; Schema: clin_history; Owner: -
--

COMMENT ON COLUMN lu_dacc_components.fk_component IS 'key to clin_history.lu_careplan_components table';


--
-- Name: lu_dacc_components_pk_seq; Type: SEQUENCE; Schema: clin_history; Owner: -
--

CREATE SEQUENCE lu_dacc_components_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_dacc_components_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_history; Owner: -
--

ALTER SEQUENCE lu_dacc_components_pk_seq OWNED BY lu_dacc_components.pk;


--
-- Name: lu_exposures; Type: TABLE; Schema: clin_history; Owner: -; Tablespace: 
--

CREATE TABLE lu_exposures (
    pk integer NOT NULL,
    exposure text NOT NULL,
    fk_decision_support integer,
    deleted boolean
);


--
-- Name: TABLE lu_exposures; Type: COMMENT; Schema: clin_history; Owner: -
--

COMMENT ON TABLE lu_exposures IS 'lookup table for things the person may be exposed to in the workplace e.g "stress", or "asbestos"';


--
-- Name: COLUMN lu_exposures.fk_decision_support; Type: COMMENT; Schema: clin_history; Owner: -
--

COMMENT ON COLUMN lu_exposures.fk_decision_support IS '
 foriegn key to decision support table, wherever and whenever that exists';


--
-- Name: lu_exposures_pk_seq; Type: SEQUENCE; Schema: clin_history; Owner: -
--

CREATE SEQUENCE lu_exposures_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_exposures_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_history; Owner: -
--

ALTER SEQUENCE lu_exposures_pk_seq OWNED BY lu_exposures.pk;


--
-- Name: occupational_history; Type: TABLE; Schema: clin_history; Owner: -; Tablespace: 
--

CREATE TABLE occupational_history (
    pk integer NOT NULL,
    fk_consult integer NOT NULL,
    fk_occupation integer NOT NULL,
    from_age integer,
    to_age integer,
    current boolean DEFAULT false,
    retired boolean DEFAULT false,
    notes_occupation text,
    deleted boolean DEFAULT false,
    fk_progressnote integer
);


--
-- Name: TABLE occupational_history; Type: COMMENT; Schema: clin_history; Owner: -
--

COMMENT ON TABLE occupational_history IS 'data table for a patients occupational history
  note that any work place exposures for this occupation must be
  retrieved via the occupation_exposure_links table';


--
-- Name: COLUMN occupational_history.fk_occupation; Type: COMMENT; Schema: clin_history; Owner: -
--

COMMENT ON COLUMN occupational_history.fk_occupation IS 'foreign key to common.lu_occupations';


--
-- Name: COLUMN occupational_history.from_age; Type: COMMENT; Schema: clin_history; Owner: -
--

COMMENT ON COLUMN occupational_history.from_age IS 'age person started working in this occupation, can be null, measured in years
  note:potential problem here as now cannot calculate duration of exposure
  so this is kept in the link_occupation_exposure table';


--
-- Name: COLUMN occupational_history.current; Type: COMMENT; Schema: clin_history; Owner: -
--

COMMENT ON COLUMN occupational_history.current IS 'if true this is the patients current occupation';


--
-- Name: COLUMN occupational_history.retired; Type: COMMENT; Schema: clin_history; Owner: -
--

COMMENT ON COLUMN occupational_history.retired IS 'if true then the patient is retired with this as last occupation';


--
-- Name: COLUMN occupational_history.notes_occupation; Type: COMMENT; Schema: clin_history; Owner: -
--

COMMENT ON COLUMN occupational_history.notes_occupation IS 'notes about either the occupation or further comment on exposure risks';


--
-- Name: COLUMN occupational_history.fk_progressnote; Type: COMMENT; Schema: clin_history; Owner: -
--

COMMENT ON COLUMN occupational_history.fk_progressnote IS 'key to clin_consult.progressnotes points to the last progress note for this occupation';


--
-- Name: occupational_history_pk_seq; Type: SEQUENCE; Schema: clin_history; Owner: -
--

CREATE SEQUENCE occupational_history_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: occupational_history_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_history; Owner: -
--

ALTER SEQUENCE occupational_history_pk_seq OWNED BY occupational_history.pk;


--
-- Name: occupations_exposures; Type: TABLE; Schema: clin_history; Owner: -; Tablespace: 
--

CREATE TABLE occupations_exposures (
    pk integer NOT NULL,
    fk_occupational_history integer NOT NULL,
    fk_exposure integer NOT NULL,
    exposure_duration integer,
    exposure_duration_units integer,
    deleted boolean DEFAULT false,
    notes_exposure text
);


--
-- Name: TABLE occupations_exposures; Type: COMMENT; Schema: clin_history; Owner: -
--

COMMENT ON TABLE occupations_exposures IS 'links table for one to many links of substances person exposed to in their occupation';


--
-- Name: COLUMN occupations_exposures.fk_occupational_history; Type: COMMENT; Schema: clin_history; Owner: -
--

COMMENT ON COLUMN occupations_exposures.fk_occupational_history IS 'foreign key to clin_history.occupational_history';


--
-- Name: COLUMN occupations_exposures.fk_exposure; Type: COMMENT; Schema: clin_history; Owner: -
--

COMMENT ON COLUMN occupations_exposures.fk_exposure IS 'foreign key to clin_history.lu_exposures';


--
-- Name: COLUMN occupations_exposures.exposure_duration; Type: COMMENT; Schema: clin_history; Owner: -
--

COMMENT ON COLUMN occupations_exposures.exposure_duration IS 'length of time exposed';


--
-- Name: COLUMN occupations_exposures.exposure_duration_units; Type: COMMENT; Schema: clin_history; Owner: -
--

COMMENT ON COLUMN occupations_exposures.exposure_duration_units IS 'foreign key to common.lu_units table
  e.g 6 = month, 7 = year';


--
-- Name: occupations_exposures_pk_seq; Type: SEQUENCE; Schema: clin_history; Owner: -
--

CREATE SEQUENCE occupations_exposures_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: occupations_exposures_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_history; Owner: -
--

ALTER SEQUENCE occupations_exposures_pk_seq OWNED BY occupations_exposures.pk;


--
-- Name: past_history; Type: TABLE; Schema: clin_history; Owner: -; Tablespace: 
--

CREATE TABLE past_history (
    pk integer NOT NULL,
    fk_consult integer NOT NULL,
    age_onset integer NOT NULL,
    age_onset_units integer NOT NULL,
    description text NOT NULL,
    fk_laterality integer DEFAULT 0,
    year_onset text NOT NULL,
    active boolean DEFAULT false,
    operation boolean DEFAULT false,
    cause_of_death boolean DEFAULT false,
    confidential boolean DEFAULT false,
    major boolean DEFAULT false,
    deleted boolean DEFAULT false,
    year_onset_uncertain boolean DEFAULT false,
    management_summary text DEFAULT ''::text,
    condition_summary text DEFAULT ''::text,
    risk_factor boolean DEFAULT false,
    fk_coding_system integer NOT NULL,
    fk_code text,
    aim_of_plan text,
    fk_progressnote integer
);


--
-- Name: COLUMN past_history.fk_coding_system; Type: COMMENT; Schema: clin_history; Owner: -
--

COMMENT ON COLUMN past_history.fk_coding_system IS 'key to coding.lu_coding_system containing name of coding system 
  that this health issue is linked to';


--
-- Name: COLUMN past_history.fk_progressnote; Type: COMMENT; Schema: clin_history; Owner: -
--

COMMENT ON COLUMN past_history.fk_progressnote IS 'foreign key to clin_consult.progressnotes table, used only during each consultation
 if changes made to this past history item, an entry is put in the progress notes, so
 if changed, but then edited again in same consultation it overwrites the original note';


--
-- Name: past_history_pk_seq; Type: SEQUENCE; Schema: clin_history; Owner: -
--

CREATE SEQUENCE past_history_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: past_history_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_history; Owner: -
--

ALTER SEQUENCE past_history_pk_seq OWNED BY past_history.pk;


--
-- Name: pk_view_familyhistory; Type: SEQUENCE; Schema: clin_history; Owner: -
--

CREATE SEQUENCE pk_view_familyhistory
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: social_history; Type: TABLE; Schema: clin_history; Owner: -; Tablespace: 
--

CREATE TABLE social_history (
    pk integer NOT NULL,
    fk_consult integer,
    history text,
    deleted boolean DEFAULT false,
    responsible_person text
);


--
-- Name: social_history_pk_seq; Type: SEQUENCE; Schema: clin_history; Owner: -
--

CREATE SEQUENCE social_history_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: social_history_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_history; Owner: -
--

ALTER SEQUENCE social_history_pk_seq OWNED BY social_history.pk;


--
-- Name: team_care_members; Type: TABLE; Schema: clin_history; Owner: -; Tablespace: 
--

CREATE TABLE team_care_members (
    pk integer NOT NULL,
    fk_pasthistory integer NOT NULL,
    fk_organisation integer,
    fk_branch integer,
    fk_employee integer,
    fk_person integer,
    deleted boolean DEFAULT false,
    responsibility text
);


--
-- Name: TABLE team_care_members; Type: COMMENT; Schema: clin_history; Owner: -
--

COMMENT ON TABLE team_care_members IS 'links a past history item to team care members
  keys are kept rather than names and addresses to allow automatic updating of the
  names and addresses on the care plan.';


--
-- Name: team_care_members_pk_seq; Type: SEQUENCE; Schema: clin_history; Owner: -
--

CREATE SEQUENCE team_care_members_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: team_care_members_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_history; Owner: -
--

ALTER SEQUENCE team_care_members_pk_seq OWNED BY team_care_members.pk;


--
-- Name: vwcareplancomponentsdue; Type: VIEW; Schema: clin_history; Owner: -
--

CREATE VIEW vwcareplancomponentsdue AS
    SELECT care_plan_components_due.fk_pasthistory, lu_careplan_components.component, care_plan_components_due.fk_component, care_plan_components_due.pk AS pk_careplan_components_due, care_plan_components_due.due FROM (care_plan_components_due JOIN lu_careplan_components ON ((care_plan_components_due.fk_component = lu_careplan_components.pk))) ORDER BY care_plan_components_due.fk_pasthistory, care_plan_components_due.due;


SET search_path = common, pg_catalog;

--
-- Name: lu_family_relationships; Type: TABLE; Schema: common; Owner: -; Tablespace: 
--

CREATE TABLE lu_family_relationships (
    pk integer NOT NULL,
    relationship text NOT NULL
);


SET search_path = clin_history, pg_catalog;

--
-- Name: vwfamilyhistory; Type: VIEW; Schema: clin_history; Owner: -
--

CREATE VIEW vwfamilyhistory AS
    SELECT family_conditions.pk AS pk_view, family_links.fk_member, family_members.fk_consult AS fk_consult_familymember, family_members.fk_relationship, family_members.fk_person, family_members.name, family_members.birthdate, family_members.age_of_death, family_members.fk_occupation, family_members.fk_country_birth, family_members.deleted AS member_deleted, family_links.fk_patient, family_links.pk AS fk_link, family_conditions.pk AS fk_condition, family_conditions.condition, family_conditions.fk_consult AS fk_consult_condition, family_conditions.fk_reason, family_conditions.age_of_onset, family_conditions.cause_of_death, family_conditions.notes, family_conditions.deleted AS condition_deleted, family_conditions.contributed_to_death, lu_countries.country, lu_occupations.occupation, lu_family_relationships.relationship, family_links.deleted AS link_deleted FROM ((((((family_links LEFT JOIN clerical.data_patients ON ((family_links.fk_patient = data_patients.pk))) JOIN family_members ON ((family_links.fk_member = family_members.pk))) JOIN family_conditions ON ((family_links.fk_member = family_conditions.fk_member))) LEFT JOIN common.lu_countries ON ((family_members.fk_country_birth = lu_countries.country_code))) LEFT JOIN common.lu_occupations ON ((family_members.fk_occupation = lu_occupations.pk))) JOIN common.lu_family_relationships ON ((family_members.fk_relationship = lu_family_relationships.pk))) WHERE ((family_members.deleted = false) AND (family_conditions.deleted = false)) ORDER BY family_links.fk_patient, family_links.fk_member;


SET search_path = coding, pg_catalog;

--
-- Name: generic_terms; Type: TABLE; Schema: coding; Owner: -; Tablespace: 
--

CREATE TABLE generic_terms (
    code text,
    body_system text,
    code_role integer,
    term text,
    fk_coding_system integer,
    active boolean,
    icd10 character varying(15)
);


--
-- Name: COLUMN generic_terms.icd10; Type: COMMENT; Schema: coding; Owner: -
--

COMMENT ON COLUMN generic_terms.icd10 IS 'mapping to ICD-10 where this exists for the system';


--
-- Name: lu_systems; Type: TABLE; Schema: coding; Owner: -; Tablespace: 
--

CREATE TABLE lu_systems (
    pk integer NOT NULL,
    system text NOT NULL,
    author text,
    preferred boolean DEFAULT false NOT NULL
);


--
-- Name: TABLE lu_systems; Type: COMMENT; Schema: coding; Owner: -
--

COMMENT ON TABLE lu_systems IS 'Contains names of coding systems';


--
-- Name: COLUMN lu_systems.system; Type: COMMENT; Schema: coding; Owner: -
--

COMMENT ON COLUMN lu_systems.system IS 'The name of the coding system
  e.g ICPC2 Plus, or ICD10';


--
-- Name: COLUMN lu_systems.author; Type: COMMENT; Schema: coding; Owner: -
--

COMMENT ON COLUMN lu_systems.author IS 'the authors of the system';


--
-- Name: COLUMN lu_systems.preferred; Type: COMMENT; Schema: coding; Owner: -
--

COMMENT ON COLUMN lu_systems.preferred IS 'true if this is the preferred system';


SET search_path = common, pg_catalog;

--
-- Name: lu_laterality; Type: TABLE; Schema: common; Owner: -; Tablespace: 
--

CREATE TABLE lu_laterality (
    pk integer NOT NULL,
    laterality text NOT NULL
);


SET search_path = clin_history, pg_catalog;

--
-- Name: vwhealthissues; Type: VIEW; Schema: clin_history; Owner: -
--

CREATE VIEW vwhealthissues AS
    SELECT consult.fk_patient, past_history.pk AS pk_pasthistory, past_history.age_onset, past_history.age_onset_units, past_history.description, past_history.fk_laterality, past_history.year_onset, past_history.active, past_history.operation, past_history.cause_of_death, past_history.confidential, past_history.major, past_history.deleted, past_history.year_onset_uncertain, past_history.management_summary, past_history.condition_summary, past_history.aim_of_plan, past_history.risk_factor, past_history.fk_coding_system, past_history.fk_code, past_history.fk_progressnote, lu_systems.system, generic_terms.term, (((generic_terms.term || ' ('::text) || generic_terms.code) || ')'::text) AS combined_term_code, generic_terms.active AS code_active, consult.pk AS fk_consult, consult.fk_staff, consult.consult_date AS date_noted, data_persons.firstname AS staff_firstname, data_persons.surname AS staff_surname, lu_title.title AS staff_title FROM (((((((past_history JOIN clin_consult.consult ON ((past_history.fk_consult = consult.pk))) LEFT JOIN common.lu_laterality ON ((past_history.fk_laterality = lu_laterality.pk))) LEFT JOIN coding.lu_systems ON ((past_history.fk_coding_system = lu_systems.pk))) LEFT JOIN coding.generic_terms ON ((past_history.fk_code = generic_terms.code))) JOIN admin.staff ON ((consult.fk_staff = staff.pk))) JOIN contacts.data_persons ON ((staff.fk_person = data_persons.pk))) LEFT JOIN contacts.lu_title ON ((data_persons.fk_title = lu_title.pk))) WHERE (past_history.deleted = false) ORDER BY consult.fk_patient;


SET search_path = common, pg_catalog;

--
-- Name: lu_units; Type: TABLE; Schema: common; Owner: -; Tablespace: 
--

CREATE TABLE lu_units (
    pk integer NOT NULL,
    abbrev_text text NOT NULL,
    full_text text
);


SET search_path = clin_history, pg_catalog;

--
-- Name: vwoccupationalhistory; Type: VIEW; Schema: clin_history; Owner: -
--

CREATE VIEW vwoccupationalhistory AS
    SELECT CASE WHEN (occupations_exposures.pk IS NULL) THEN (occupational_history.pk || '-0'::text) ELSE ((occupational_history.pk || '-'::text) || occupations_exposures.pk) END AS pk_view, occupational_history.pk AS fk_occupational_history, occupational_history.fk_consult, occupational_history.fk_occupation, occupational_history.from_age, occupational_history.to_age, occupational_history.current, occupational_history.retired, occupational_history.notes_occupation, occupational_history.deleted AS occupational_history_deleted, occupational_history.fk_progressnote, consult.consult_date, consult.fk_patient, lu_occupations.occupation, occupations_exposures.pk AS fk_occupations_exposures, occupations_exposures.fk_exposure, occupations_exposures.exposure_duration, occupations_exposures.exposure_duration_units, occupations_exposures.notes_exposure, lu_exposures.exposure, lu_exposures.fk_decision_support, occupations_exposures.deleted AS exposure_deleted, lu_units.abbrev_text FROM (((((occupational_history JOIN clin_consult.consult ON ((occupational_history.fk_consult = consult.pk))) JOIN common.lu_occupations ON ((occupational_history.fk_occupation = lu_occupations.pk))) LEFT JOIN occupations_exposures ON ((occupational_history.pk = occupations_exposures.fk_occupational_history))) LEFT JOIN lu_exposures ON ((occupations_exposures.fk_exposure = lu_exposures.pk))) LEFT JOIN common.lu_units ON ((occupations_exposures.exposure_duration_units = lu_units.pk)));


--
-- Name: vwpasthistoryaudit; Type: VIEW; Schema: clin_history; Owner: -
--

CREATE VIEW vwpasthistoryaudit AS
    SELECT vwaudit.pk_view, vwaudit.fk_patient, vwaudit.date_audit, vwaudit.data_summary, vwaudit.audit_trail_reason, vwaudit.altered_by_title, vwaudit.altered_by_name, vwaudit.schema, vwaudit.fk_schema, vwaudit.tablename, vwaudit.fk_table, vwaudit.fk_row, vwaudit.fk_consult, vwaudit.fk_lu_reason, vwaudit.action, vwaudit.fk_action, vwaudit.fk_section, vwaudit.section FROM (audit.vwaudit JOIN past_history ON ((vwaudit.fk_row = past_history.pk))) WHERE ((vwaudit.schema = 'clin_history'::text) AND (vwaudit.tablename = 'past_history'::text)) ORDER BY vwaudit.fk_patient, vwaudit.fk_row, vwaudit.date_audit;


--
-- Name: vwsocialhistory; Type: VIEW; Schema: clin_history; Owner: -
--

CREATE VIEW vwsocialhistory AS
    SELECT sh.pk AS pk_socialhistory, consult.pk AS fk_consult, consult.fk_patient, sh.history, sh.responsible_person, sh.deleted FROM (social_history sh JOIN clin_consult.consult consult ON ((consult.pk = sh.fk_consult))) WHERE (sh.deleted = false);


SET search_path = contacts, pg_catalog;

--
-- Name: vworganisations_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: -
--

CREATE SEQUENCE vworganisations_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: vworganisationsemployees; Type: VIEW; Schema: contacts; Owner: -
--

CREATE VIEW vworganisationsemployees AS
    SELECT nextval('vworganisations_pk_seq'::regclass) AS pk_view, clinics.pk AS fk_clinic, organisations.organisation, organisations.deleted AS organisation_deleted, branches.pk AS fk_branch, branches.branch, branches.fk_organisation, branches.deleted AS branch_deleted, branches.fk_address, employees.memo, branches.fk_category, categories.category, addresses.street, addresses.fk_town, addresses.preferred_address, addresses.postal_address, addresses.head_office, addresses.country_code, addresses.fk_lu_address_type, addresses.deleted AS address_deleted, towns.postcode, towns.town, towns.state, employees.pk AS fk_employee, CASE WHEN (employees.pk > 0) THEN (((title.title || ' '::text) || (persons.firstname || ' '::text)) || persons.surname) ELSE 'Nothing'::text END AS wholename, employees.fk_occupation, employees.fk_category AS fk_employee_category, employees.fk_status, employee_status.status AS employee_status, employees.deleted AS employee_deleted, occupations.occupation, persons.pk AS fk_person, persons.firstname, persons.surname, persons.salutation, persons.birthdate, persons.deceased, persons.date_deceased, persons.fk_ethnicity, persons.fk_language, persons.fk_marital, persons.fk_title, persons.fk_sex, sex.sex, title.title FROM ((((((((((((data_employees employees JOIN data_branches branches ON ((employees.fk_branch = branches.pk))) LEFT JOIN lu_categories categories ON ((employees.fk_category = categories.pk))) LEFT JOIN lu_employee_status employee_status ON ((employees.fk_status = employee_status.pk))) JOIN data_organisations organisations ON ((branches.fk_organisation = organisations.pk))) LEFT JOIN data_addresses addresses ON ((branches.fk_address = addresses.pk))) LEFT JOIN lu_address_types ON ((addresses.fk_lu_address_type = lu_address_types.pk))) LEFT JOIN lu_towns towns ON ((addresses.fk_town = towns.pk))) LEFT JOIN common.lu_occupations occupations ON ((employees.fk_occupation = occupations.pk))) LEFT JOIN data_persons persons ON ((employees.fk_person = persons.pk))) LEFT JOIN lu_title title ON ((persons.fk_title = title.pk))) LEFT JOIN lu_sex sex ON ((persons.fk_sex = sex.pk))) LEFT JOIN admin.clinics ON ((branches.pk = clinics.fk_branch))) WHERE (employees.fk_person IS NOT NULL) UNION SELECT nextval('vworganisations_pk_seq'::regclass) AS pk_view, clinics.pk AS fk_clinic, organisations.organisation, organisations.deleted AS organisation_deleted, branches.pk AS fk_branch, branches.branch, branches.fk_organisation, branches.deleted AS branch_deleted, branches.fk_address, branches.memo, branches.fk_category, categories.category, addresses.street, addresses.fk_town, addresses.preferred_address, addresses.postal_address, addresses.head_office, addresses.country_code, addresses.fk_lu_address_type, addresses.deleted AS address_deleted, towns.postcode, towns.town, towns.state, 0 AS fk_employee, (((organisations.organisation)::text || ' '::text) || branches.branch) AS wholename, 0 AS fk_occupation, 0 AS fk_employee_category, 0 AS fk_status, NULL::unknown AS employee_status, false AS employee_deleted, NULL::unknown AS occupation, 0 AS fk_person, NULL::unknown AS firstname, NULL::unknown AS surname, NULL::unknown AS salutation, NULL::unknown AS birthdate, false AS deceased, NULL::unknown AS date_deceased, 0 AS fk_ethnicity, 0 AS fk_language, 0 AS fk_marital, 0 AS fk_title, 0 AS fk_sex, NULL::unknown AS sex, NULL::unknown AS title FROM ((((((data_branches branches JOIN data_organisations organisations ON ((branches.fk_organisation = organisations.pk))) JOIN lu_categories categories ON ((branches.fk_category = categories.pk))) LEFT JOIN data_addresses addresses ON ((branches.fk_address = addresses.pk))) LEFT JOIN lu_address_types ON ((addresses.fk_lu_address_type = lu_address_types.pk))) LEFT JOIN lu_towns towns ON ((addresses.fk_town = towns.pk))) LEFT JOIN admin.clinics ON ((branches.pk = clinics.fk_branch))) ORDER BY 1, 3, 4, 29, 28;


--
-- Name: vwpersonsincludingpatients; Type: VIEW; Schema: contacts; Owner: -
--

CREATE VIEW vwpersonsincludingpatients AS
    SELECT persons.pk AS fk_person, CASE WHEN (addresses.pk > 0) THEN COALESCE(((persons.pk || '-'::text) || addresses.pk)) ELSE (persons.pk || '-0'::text) END AS pk_view, addresses.pk AS fk_address, (((title.title || ' '::text) || (persons.firstname || ' '::text)) || (persons.surname || ' '::text)) AS wholename, persons.firstname, persons.surname, persons.salutation, persons.birthdate, date_part('year'::text, age((persons.birthdate)::timestamp with time zone)) AS age, marital.marital, sex.sex, title.title, countries.country, languages.language, ethnicity.ethnicity, addresses.street, towns.town, towns.state, towns.postcode, addresses.fk_town, lu_address_types.type AS address_type, addresses.preferred_address, addresses.postal_address, addresses.head_office, addresses.geolocation, addresses.country_code, addresses.fk_lu_address_type AS fk_address_type, addresses.deleted AS address_deleted, persons.fk_ethnicity, persons.fk_language, persons.memo, persons.fk_marital, persons.fk_title, persons.deceased, persons.date_deceased, persons.fk_sex, all_images.pk AS fk_image, all_images.image FROM ((((((((((((data_persons persons LEFT JOIN clerical.data_patients ON ((persons.pk = data_patients.pk))) LEFT JOIN links_persons_addresses ON ((persons.pk = links_persons_addresses.fk_person))) LEFT JOIN lu_marital marital ON ((persons.fk_marital = marital.pk))) LEFT JOIN lu_sex sex ON ((persons.fk_sex = sex.pk))) LEFT JOIN common.lu_languages languages ON ((persons.fk_language = languages.pk))) LEFT JOIN lu_title title ON ((persons.fk_title = title.pk))) LEFT JOIN common.lu_ethnicity ethnicity ON ((persons.fk_ethnicity = ethnicity.pk))) LEFT JOIN public.all_images ON ((persons.fk_image = all_images.pk))) LEFT JOIN common.lu_countries countries ON ((persons.country_code = (countries.country_code)::text))) JOIN data_addresses addresses ON ((links_persons_addresses.fk_address = addresses.pk))) LEFT JOIN lu_address_types ON ((addresses.fk_lu_address_type = addresses.fk_lu_address_type))) JOIN lu_towns towns ON ((addresses.fk_town = towns.pk)));


--
-- Name: VIEW vwpersonsincludingpatients; Type: COMMENT; Schema: contacts; Owner: -
--

COMMENT ON VIEW vwpersonsincludingpatients IS 'temporary view until I fix it, a view of all persons including those who are patients';


SET search_path = clin_history, pg_catalog;

--
-- Name: vwteamcaremembers; Type: VIEW; Schema: clin_history; Owner: -
--

CREATE VIEW vwteamcaremembers AS
    SELECT team_care_members.pk, team_care_members.fk_pasthistory, vworganisationsemployees.fk_organisation, vworganisationsemployees.fk_branch, vworganisationsemployees.fk_person, vworganisationsemployees.fk_employee, CASE WHEN (vworganisationsemployees.fk_employee = 0) THEN vworganisationsemployees.branch ELSE (((vworganisationsemployees.title || ' '::text) || (vworganisationsemployees.firstname || ' '::text)) || vworganisationsemployees.surname) END AS wholename, ((((vworganisationsemployees.organisation)::text || ' '::text) || (vworganisationsemployees.branch || ' '::text)) || CASE WHEN (vworganisationsemployees.fk_address IS NULL) THEN ''::text ELSE ((((vworganisationsemployees.street || ' '::text) || vworganisationsemployees.town) || ' '::text) || (vworganisationsemployees.postcode)::text) END) AS summary, team_care_members.responsibility FROM (team_care_members LEFT JOIN contacts.vworganisationsemployees ON (((team_care_members.fk_branch = vworganisationsemployees.fk_branch) AND (team_care_members.fk_employee = vworganisationsemployees.fk_employee)))) WHERE ((team_care_members.deleted = false) AND (team_care_members.fk_branch > 0)) UNION SELECT team_care_members.pk, team_care_members.fk_pasthistory, NULL::unknown AS fk_organisation, NULL::unknown AS fk_branch, vwpersonsincludingpatients.fk_person, NULL::unknown AS fk_employee, vwpersonsincludingpatients.wholename, ((((vwpersonsincludingpatients.street || ' '::text) || vwpersonsincludingpatients.town) || ' '::text) || (vwpersonsincludingpatients.postcode)::text) AS summary, team_care_members.responsibility FROM ((team_care_members JOIN contacts.vwpersonsincludingpatients ON ((team_care_members.fk_person = vwpersonsincludingpatients.fk_person))) LEFT JOIN contacts.vworganisationsemployees ON ((team_care_members.fk_person = vworganisationsemployees.fk_person))) WHERE ((team_care_members.deleted = false) AND (team_care_members.fk_employee IS NULL)) ORDER BY 2;


SET search_path = clin_measurements, pg_catalog;

--
-- Name: lu_type; Type: TABLE; Schema: clin_measurements; Owner: -; Tablespace: 
--

CREATE TABLE lu_type (
    pk integer NOT NULL,
    name_abbreviated text NOT NULL,
    code integer,
    name_full text,
    input_key_restriction integer,
    input_mask text,
    fk_unit integer,
    unit_qualifier text,
    upper_limit integer,
    lower_limit integer,
    fk_decision_support integer,
    fk_plotting_method integer
);


--
-- Name: TABLE lu_type; Type: COMMENT; Schema: clin_measurements; Owner: -
--

COMMENT ON TABLE lu_type IS 'A lookup table containing types of measurements';


--
-- Name: COLUMN lu_type.name_abbreviated; Type: COMMENT; Schema: clin_measurements; Owner: -
--

COMMENT ON COLUMN lu_type.name_abbreviated IS 'The type of measurement e.g BP';


--
-- Name: COLUMN lu_type.code; Type: COMMENT; Schema: clin_measurements; Owner: -
--

COMMENT ON COLUMN lu_type.code IS 'if not null points to disease code not implemented';


--
-- Name: COLUMN lu_type.name_full; Type: COMMENT; Schema: clin_measurements; Owner: -
--

COMMENT ON COLUMN lu_type.name_full IS 'Full description eg Blood Pressure';


--
-- Name: COLUMN lu_type.input_key_restriction; Type: COMMENT; Schema: clin_measurements; Owner: -
--

COMMENT ON COLUMN lu_type.input_key_restriction IS 'Contant contained in module gvar (global variable module) eg  AllowKeys_BP will allow numbers & /';


--
-- Name: COLUMN lu_type.input_mask; Type: COMMENT; Schema: clin_measurements; Owner: -
--

COMMENT ON COLUMN lu_type.input_mask IS 'input mask e.g ###/###';


--
-- Name: COLUMN lu_type.fk_unit; Type: COMMENT; Schema: clin_measurements; Owner: -
--

COMMENT ON COLUMN lu_type.fk_unit IS 'key to common.lu_units table eg mm (millimeters)';


--
-- Name: COLUMN lu_type.unit_qualifier; Type: COMMENT; Schema: clin_measurements; Owner: -
--

COMMENT ON COLUMN lu_type.unit_qualifier IS 'qualifier for the unit eg Hg (mercury)';


--
-- Name: COLUMN lu_type.upper_limit; Type: COMMENT; Schema: clin_measurements; Owner: -
--

COMMENT ON COLUMN lu_type.upper_limit IS 'A recommended upper limit if not null';


--
-- Name: COLUMN lu_type.lower_limit; Type: COMMENT; Schema: clin_measurements; Owner: -
--

COMMENT ON COLUMN lu_type.lower_limit IS 'A recommended lower limit if not null';


--
-- Name: COLUMN lu_type.fk_decision_support; Type: COMMENT; Schema: clin_measurements; Owner: -
--

COMMENT ON COLUMN lu_type.fk_decision_support IS 'key to Decision support table which does not exist yet';


--
-- Name: COLUMN lu_type.fk_plotting_method; Type: COMMENT; Schema: clin_measurements; Owner: -
--

COMMENT ON COLUMN lu_type.fk_plotting_method IS 'foreign key for lu_plotting method table';


--
-- Name: lu_type_pk_seq; Type: SEQUENCE; Schema: clin_measurements; Owner: -
--

CREATE SEQUENCE lu_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_measurements; Owner: -
--

ALTER SEQUENCE lu_type_pk_seq OWNED BY lu_type.pk;


--
-- Name: measurements; Type: TABLE; Schema: clin_measurements; Owner: -; Tablespace: 
--

CREATE TABLE measurements (
    pk integer NOT NULL,
    fk_consult integer NOT NULL,
    time_noted time without time zone,
    fk_type integer NOT NULL,
    measurement numeric,
    comment text,
    deleted boolean DEFAULT false
);


--
-- Name: TABLE measurements; Type: COMMENT; Schema: clin_measurements; Owner: -
--

COMMENT ON TABLE measurements IS 'A data table containing data for all measurements all measurements are assumed to be covertable to numbers 
 even blood pressure which is stored as six digit number eg 120070 = 120/70';


--
-- Name: COLUMN measurements.fk_consult; Type: COMMENT; Schema: clin_measurements; Owner: -
--

COMMENT ON COLUMN measurements.fk_consult IS 'key to clin_consult.consult table which gives date consult, dr/patient';


--
-- Name: COLUMN measurements.time_noted; Type: COMMENT; Schema: clin_measurements; Owner: -
--

COMMENT ON COLUMN measurements.time_noted IS 'time measurement noted within the date of the consult';


--
-- Name: COLUMN measurements.fk_type; Type: COMMENT; Schema: clin_measurements; Owner: -
--

COMMENT ON COLUMN measurements.fk_type IS 'key to clin_measurements.lu_type table eg BP measurement';


--
-- Name: COLUMN measurements.measurement; Type: COMMENT; Schema: clin_measurements; Owner: -
--

COMMENT ON COLUMN measurements.measurement IS 'the actual measurement, see comment in table comment';


--
-- Name: COLUMN measurements.comment; Type: COMMENT; Schema: clin_measurements; Owner: -
--

COMMENT ON COLUMN measurements.comment IS 'comment on this measurement e.g resting BP';


--
-- Name: measurements_pk_seq; Type: SEQUENCE; Schema: clin_measurements; Owner: -
--

CREATE SEQUENCE measurements_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: measurements_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_measurements; Owner: -
--

ALTER SEQUENCE measurements_pk_seq OWNED BY measurements.pk;


--
-- Name: patients_defaults; Type: TABLE; Schema: clin_measurements; Owner: -; Tablespace: 
--

CREATE TABLE patients_defaults (
    pk integer NOT NULL,
    fk_patient integer NOT NULL,
    fk_lu_type integer,
    loinc text,
    display_as_default boolean DEFAULT false,
    name text,
    alias text,
    deleted boolean DEFAULT false
);


--
-- Name: TABLE patients_defaults; Type: COMMENT; Schema: clin_measurements; Owner: -
--

COMMENT ON TABLE patients_defaults IS 'contains patient specific measurement types for graphing';


--
-- Name: COLUMN patients_defaults.fk_lu_type; Type: COMMENT; Schema: clin_measurements; Owner: -
--

COMMENT ON COLUMN patients_defaults.fk_lu_type IS 'key to clin_measurements.lu_type table. May be null for example if the default type is a loinc code';


--
-- Name: COLUMN patients_defaults.loinc; Type: COMMENT; Schema: clin_measurements; Owner: -
--

COMMENT ON COLUMN patients_defaults.loinc IS 'if not null, the default measurement to graph is that of the loinc';


--
-- Name: COLUMN patients_defaults.alias; Type: COMMENT; Schema: clin_measurements; Owner: -
--

COMMENT ON COLUMN patients_defaults.alias IS 'Used where the full name is too long for a button, eg Haemoglobin could be HB';


--
-- Name: COLUMN patients_defaults.deleted; Type: COMMENT; Schema: clin_measurements; Owner: -
--

COMMENT ON COLUMN patients_defaults.deleted IS 'If True, then this record is marked deleted';


--
-- Name: patients_defaults_pk_seq; Type: SEQUENCE; Schema: clin_measurements; Owner: -
--

CREATE SEQUENCE patients_defaults_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: patients_defaults_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_measurements; Owner: -
--

ALTER SEQUENCE patients_defaults_pk_seq OWNED BY patients_defaults.pk;


--
-- Name: vwmeasurements; Type: VIEW; Schema: clin_measurements; Owner: -
--

CREATE VIEW vwmeasurements AS
    SELECT consult.fk_patient, consult.consult_date, measurements.fk_consult, measurements.time_noted, lu_type.name_abbreviated AS type, lu_type.name_full, measurements.pk AS pk_measurement, measurements.measurement, consult.fk_staff, measurements.comment, measurements.fk_type, lu_staff_roles.role, data_persons.firstname, data_persons.surname, lu_title.title, measurements.deleted FROM ((((((measurements JOIN lu_type ON ((measurements.fk_type = lu_type.pk))) JOIN clin_consult.consult ON ((measurements.fk_consult = consult.pk))) JOIN admin.staff ON ((consult.fk_staff = staff.pk))) LEFT JOIN admin.lu_staff_roles ON ((staff.fk_role = lu_staff_roles.pk))) LEFT JOIN contacts.data_persons ON ((staff.fk_person = data_persons.pk))) LEFT JOIN contacts.lu_title ON ((data_persons.fk_title = lu_title.pk))) WHERE (measurements.deleted = false) ORDER BY consult.fk_patient, lu_type.name_abbreviated, consult.consult_date, measurements.time_noted;


--
-- Name: vwmeasurementtypes; Type: VIEW; Schema: clin_measurements; Owner: -
--

CREATE VIEW vwmeasurementtypes AS
    SELECT lu_units.full_text, lu_units.abbrev_text, lu_type.pk, lu_type.name_abbreviated, lu_type.code, lu_type.name_full, lu_type.input_key_restriction, lu_type.input_mask, lu_type.fk_unit, lu_type.unit_qualifier, lu_type.upper_limit, lu_type.lower_limit, lu_type.fk_decision_support, lu_type.fk_plotting_method FROM (lu_type JOIN common.lu_units ON ((lu_type.fk_unit = lu_units.pk))) ORDER BY lu_type.name_full;


--
-- Name: vwpatientsdefaults; Type: VIEW; Schema: clin_measurements; Owner: -
--

CREATE VIEW vwpatientsdefaults AS
    SELECT patients_defaults.fk_patient, patients_defaults.pk AS pk_patients_defaults, patients_defaults.fk_lu_type, lu_type.name_abbreviated, lu_type.code, lu_type.input_key_restriction, lu_type.name_full, lu_type.input_mask, lu_type.fk_unit, lu_type.unit_qualifier, lu_type.upper_limit, lu_type.lower_limit, lu_type.fk_decision_support, lu_type.fk_plotting_method, lu_units.full_text, lu_units.abbrev_text FROM ((patients_defaults JOIN lu_type ON ((patients_defaults.fk_lu_type = lu_type.pk))) LEFT JOIN common.lu_units ON ((lu_type.fk_unit = lu_units.pk))) ORDER BY patients_defaults.fk_patient;


SET search_path = clin_mentalhealth, pg_catalog;

--
-- Name: k10_results; Type: TABLE; Schema: clin_mentalhealth; Owner: -; Tablespace: 
--

CREATE TABLE k10_results (
    pk integer NOT NULL,
    fk_plan integer,
    fk_lu_k10_component integer,
    score integer
);


--
-- Name: k10_results_pk_seq; Type: SEQUENCE; Schema: clin_mentalhealth; Owner: -
--

CREATE SEQUENCE k10_results_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: k10_results_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_mentalhealth; Owner: -
--

ALTER SEQUENCE k10_results_pk_seq OWNED BY k10_results.pk;


--
-- Name: lu_assessment_tools; Type: TABLE; Schema: clin_mentalhealth; Owner: -; Tablespace: 
--

CREATE TABLE lu_assessment_tools (
    pk_tool integer NOT NULL,
    tool text NOT NULL,
    tool_about text,
    name_abbrev text
);


--
-- Name: TABLE lu_assessment_tools; Type: COMMENT; Schema: clin_mentalhealth; Owner: -
--

COMMENT ON TABLE lu_assessment_tools IS 'table containing names of assessment tools and some descriptive html to display to user';


--
-- Name: lu_assessment_tools_pk_tool_seq; Type: SEQUENCE; Schema: clin_mentalhealth; Owner: -
--

CREATE SEQUENCE lu_assessment_tools_pk_tool_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_assessment_tools_pk_tool_seq; Type: SEQUENCE OWNED BY; Schema: clin_mentalhealth; Owner: -
--

ALTER SEQUENCE lu_assessment_tools_pk_tool_seq OWNED BY lu_assessment_tools.pk_tool;


--
-- Name: lu_component_help; Type: TABLE; Schema: clin_mentalhealth; Owner: -; Tablespace: 
--

CREATE TABLE lu_component_help (
    pk integer NOT NULL,
    care_plan_component text NOT NULL,
    component_help text NOT NULL
);


--
-- Name: TABLE lu_component_help; Type: COMMENT; Schema: clin_mentalhealth; Owner: -
--

COMMENT ON TABLE lu_component_help IS 'contains help for each component of a care plan';


--
-- Name: COLUMN lu_component_help.care_plan_component; Type: COMMENT; Schema: clin_mentalhealth; Owner: -
--

COMMENT ON COLUMN lu_component_help.care_plan_component IS 'the components of a plan e.g mental state examination';


--
-- Name: lu_component_help_pk_seq; Type: SEQUENCE; Schema: clin_mentalhealth; Owner: -
--

CREATE SEQUENCE lu_component_help_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_component_help_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_mentalhealth; Owner: -
--

ALTER SEQUENCE lu_component_help_pk_seq OWNED BY lu_component_help.pk;


--
-- Name: lu_depression_degree; Type: TABLE; Schema: clin_mentalhealth; Owner: -; Tablespace: 
--

CREATE TABLE lu_depression_degree (
    pk integer NOT NULL,
    degree text NOT NULL
);


--
-- Name: lu_depression_degree_pk_seq; Type: SEQUENCE; Schema: clin_mentalhealth; Owner: -
--

CREATE SEQUENCE lu_depression_degree_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_depression_degree_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_mentalhealth; Owner: -
--

ALTER SEQUENCE lu_depression_degree_pk_seq OWNED BY lu_depression_degree.pk;


--
-- Name: lu_k10_components; Type: TABLE; Schema: clin_mentalhealth; Owner: -; Tablespace: 
--

CREATE TABLE lu_k10_components (
    pk integer NOT NULL,
    component text NOT NULL
);


--
-- Name: lu_k10_components_pk_seq; Type: SEQUENCE; Schema: clin_mentalhealth; Owner: -
--

CREATE SEQUENCE lu_k10_components_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_k10_components_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_mentalhealth; Owner: -
--

ALTER SEQUENCE lu_k10_components_pk_seq OWNED BY lu_k10_components.pk;


--
-- Name: lu_plan_type; Type: TABLE; Schema: clin_mentalhealth; Owner: -; Tablespace: 
--

CREATE TABLE lu_plan_type (
    pk integer NOT NULL,
    type text NOT NULL
);


--
-- Name: lu_plan_type_pk_seq; Type: SEQUENCE; Schema: clin_mentalhealth; Owner: -
--

CREATE SEQUENCE lu_plan_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_plan_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_mentalhealth; Owner: -
--

ALTER SEQUENCE lu_plan_type_pk_seq OWNED BY lu_plan_type.pk;


--
-- Name: lu_risk_to_others; Type: TABLE; Schema: clin_mentalhealth; Owner: -; Tablespace: 
--

CREATE TABLE lu_risk_to_others (
    pk integer NOT NULL,
    risk text NOT NULL
);


--
-- Name: lu_risk_to_others_pk_seq; Type: SEQUENCE; Schema: clin_mentalhealth; Owner: -
--

CREATE SEQUENCE lu_risk_to_others_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_risk_to_others_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_mentalhealth; Owner: -
--

ALTER SEQUENCE lu_risk_to_others_pk_seq OWNED BY lu_risk_to_others.pk;


--
-- Name: mentalhealth_plan; Type: TABLE; Schema: clin_mentalhealth; Owner: -; Tablespace: 
--

CREATE TABLE mentalhealth_plan (
    pk integer NOT NULL,
    fk_consult integer NOT NULL,
    fk_pasthistory integer,
    diagnosis text NOT NULL,
    fk_coding_system integer,
    fk_code text,
    presenting_problems text,
    bio_psycho_social text,
    mental_state_examination text,
    fk_lu_risk_to_others integer,
    fk_stress_assessment integer,
    risk_harm_comments text,
    goals text,
    treatment_referrrals text,
    patient_action text,
    review_date date,
    html text,
    deleted boolean DEFAULT false,
    fk_lu_plan_type integer,
    fk_progressnote integer,
    relapse_plan text
);


--
-- Name: TABLE mentalhealth_plan; Type: COMMENT; Schema: clin_mentalhealth; Owner: -
--

COMMENT ON TABLE mentalhealth_plan IS 'The mental health plan components including html';


--
-- Name: COLUMN mentalhealth_plan.fk_consult; Type: COMMENT; Schema: clin_mentalhealth; Owner: -
--

COMMENT ON COLUMN mentalhealth_plan.fk_consult IS 'key to clin_consult.consult > gives Dr and date plan formulated';


--
-- Name: COLUMN mentalhealth_plan.fk_pasthistory; Type: COMMENT; Schema: clin_mentalhealth; Owner: -
--

COMMENT ON COLUMN mentalhealth_plan.fk_pasthistory IS 'key to clin_history.past_history if not null is linked to health issue';


--
-- Name: COLUMN mentalhealth_plan.diagnosis; Type: COMMENT; Schema: clin_mentalhealth; Owner: -
--

COMMENT ON COLUMN mentalhealth_plan.diagnosis IS 'the diagnosis may be free text but could be coded';


--
-- Name: COLUMN mentalhealth_plan.fk_coding_system; Type: COMMENT; Schema: clin_mentalhealth; Owner: -
--

COMMENT ON COLUMN mentalhealth_plan.fk_coding_system IS 'if not null this is the coding system used for the coded diagnosis';


--
-- Name: COLUMN mentalhealth_plan.fk_lu_risk_to_others; Type: COMMENT; Schema: clin_mentalhealth; Owner: -
--

COMMENT ON COLUMN mentalhealth_plan.fk_lu_risk_to_others IS 'key to lu_risk_to_others table';


--
-- Name: COLUMN mentalhealth_plan.fk_stress_assessment; Type: COMMENT; Schema: clin_mentalhealth; Owner: -
--

COMMENT ON COLUMN mentalhealth_plan.fk_stress_assessment IS 'key to stress_assessment table eg results of K10';


--
-- Name: COLUMN mentalhealth_plan.html; Type: COMMENT; Schema: clin_mentalhealth; Owner: -
--

COMMENT ON COLUMN mentalhealth_plan.html IS 'the plan in html';


--
-- Name: COLUMN mentalhealth_plan.fk_progressnote; Type: COMMENT; Schema: clin_mentalhealth; Owner: -
--

COMMENT ON COLUMN mentalhealth_plan.fk_progressnote IS 'foreign key to clin_consult.progressnotes, and points to the progress note for the consultation
 that this mental health plan was written in. Used in editing during a consultation only';


--
-- Name: mentalhealth_plan_pk_seq; Type: SEQUENCE; Schema: clin_mentalhealth; Owner: -
--

CREATE SEQUENCE mentalhealth_plan_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: mentalhealth_plan_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_mentalhealth; Owner: -
--

ALTER SEQUENCE mentalhealth_plan_pk_seq OWNED BY mentalhealth_plan.pk;


--
-- Name: team_care_members; Type: TABLE; Schema: clin_mentalhealth; Owner: -; Tablespace: 
--

CREATE TABLE team_care_members (
    pk integer NOT NULL,
    fk_plan integer NOT NULL,
    fk_organisation integer,
    fk_branch integer,
    fk_employee integer,
    fk_person integer,
    deleted boolean DEFAULT false,
    responsibility text
);


--
-- Name: TABLE team_care_members; Type: COMMENT; Schema: clin_mentalhealth; Owner: -
--

COMMENT ON TABLE team_care_members IS 'links a mental health plan to team care members
  keys are kept rather than names and addresses to allow automatic updating of the
  names and addresses on the care plan.';


--
-- Name: team_care_members_pk_seq; Type: SEQUENCE; Schema: clin_mentalhealth; Owner: -
--

CREATE SEQUENCE team_care_members_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: team_care_members_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_mentalhealth; Owner: -
--

ALTER SEQUENCE team_care_members_pk_seq OWNED BY team_care_members.pk;


--
-- Name: vwk10results; Type: VIEW; Schema: clin_mentalhealth; Owner: -
--

CREATE VIEW vwk10results AS
    SELECT k10_results.pk, k10_results.fk_plan, k10_results.fk_lu_k10_component, k10_results.score, lu_k10_components.component FROM k10_results, lu_k10_components WHERE (k10_results.fk_lu_k10_component = lu_k10_components.pk) ORDER BY k10_results.fk_plan;


--
-- Name: vwmentalhealthplans; Type: VIEW; Schema: clin_mentalhealth; Owner: -
--

CREATE VIEW vwmentalhealthplans AS
    SELECT mentalhealth_plan.pk AS pk_mentalhealth_plan, consult.fk_patient, consult.fk_staff, consult.consult_date AS plan_date, mentalhealth_plan.fk_consult, mentalhealth_plan.fk_pasthistory, mentalhealth_plan.diagnosis, mentalhealth_plan.fk_coding_system, mentalhealth_plan.fk_progressnote, lu_systems.system, (SELECT DISTINCT generic_terms.term FROM coding.generic_terms WHERE (mentalhealth_plan.fk_code = generic_terms.code)) AS coded_term, mentalhealth_plan.fk_code, mentalhealth_plan.presenting_problems, mentalhealth_plan.bio_psycho_social, mentalhealth_plan.mental_state_examination, mentalhealth_plan.fk_lu_risk_to_others, lu_risk_to_others.risk, mentalhealth_plan.fk_stress_assessment, mentalhealth_plan.relapse_plan, mentalhealth_plan.risk_harm_comments, mentalhealth_plan.goals, mentalhealth_plan.treatment_referrrals, mentalhealth_plan.review_date, mentalhealth_plan.html, mentalhealth_plan.fk_lu_plan_type, lu_plan_type.type, mentalhealth_plan.deleted, vwstaff.wholename, vwstaff.title FROM ((((((mentalhealth_plan JOIN clin_consult.consult ON ((mentalhealth_plan.fk_consult = consult.pk))) JOIN lu_plan_type ON ((mentalhealth_plan.fk_lu_plan_type = lu_plan_type.pk))) LEFT JOIN clin_history.past_history ON ((mentalhealth_plan.fk_pasthistory = past_history.pk))) JOIN coding.lu_systems ON ((mentalhealth_plan.fk_coding_system = lu_systems.pk))) LEFT JOIN lu_risk_to_others ON ((mentalhealth_plan.fk_lu_risk_to_others = lu_risk_to_others.pk))) JOIN admin.vwstaff ON ((consult.fk_staff = vwstaff.fk_staff))) WHERE (mentalhealth_plan.deleted = false) ORDER BY consult.fk_patient, mentalhealth_plan.fk_code, mentalhealth_plan.fk_lu_plan_type, consult.consult_date;


--
-- Name: vwteamcaremembers; Type: VIEW; Schema: clin_mentalhealth; Owner: -
--

CREATE VIEW vwteamcaremembers AS
    SELECT team_care_members.pk, team_care_members.fk_plan, vworganisationsemployees.fk_organisation, vworganisationsemployees.fk_branch, vworganisationsemployees.fk_person, CASE WHEN (vworganisationsemployees.fk_employee = 0) THEN vworganisationsemployees.branch ELSE (((vworganisationsemployees.title || ' '::text) || (vworganisationsemployees.firstname || ' '::text)) || vworganisationsemployees.surname) END AS wholename, ((((vworganisationsemployees.organisation)::text || ' '::text) || (vworganisationsemployees.branch || ' '::text)) || CASE WHEN (vworganisationsemployees.fk_address IS NULL) THEN ''::text ELSE ((((vworganisationsemployees.street || ' '::text) || vworganisationsemployees.town) || ' '::text) || (vworganisationsemployees.postcode)::text) END) AS summary, team_care_members.responsibility FROM (team_care_members LEFT JOIN contacts.vworganisationsemployees ON (((team_care_members.fk_branch = vworganisationsemployees.fk_branch) AND (team_care_members.fk_employee = vworganisationsemployees.fk_employee)))) WHERE ((team_care_members.deleted = false) AND (team_care_members.fk_branch > 0)) UNION SELECT team_care_members.pk, team_care_members.fk_plan, NULL::unknown AS fk_organisation, NULL::unknown AS fk_branch, vwpersonsincludingpatients.fk_person, vwpersonsincludingpatients.wholename, ((((vwpersonsincludingpatients.street || ' '::text) || vwpersonsincludingpatients.town) || ' '::text) || (vwpersonsincludingpatients.postcode)::text) AS summary, team_care_members.responsibility FROM ((team_care_members JOIN contacts.vwpersonsincludingpatients ON ((team_care_members.fk_person = vwpersonsincludingpatients.fk_person))) LEFT JOIN contacts.vworganisationsemployees ON ((team_care_members.fk_person = vworganisationsemployees.fk_person))) WHERE ((team_care_members.deleted = false) AND (team_care_members.fk_employee IS NULL)) ORDER BY 2;


SET search_path = clin_pregnancy, pg_catalog;

--
-- Name: lu_antenatal_venue; Type: TABLE; Schema: clin_pregnancy; Owner: -; Tablespace: 
--

CREATE TABLE lu_antenatal_venue (
    pk integer NOT NULL,
    fk_branch integer NOT NULL
);


--
-- Name: TABLE lu_antenatal_venue; Type: COMMENT; Schema: clin_pregnancy; Owner: -
--

COMMENT ON TABLE lu_antenatal_venue IS 'available venues for attendance for pregnant women';


--
-- Name: lu_antenatal_venue_pk_seq; Type: SEQUENCE; Schema: clin_pregnancy; Owner: -
--

CREATE SEQUENCE lu_antenatal_venue_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_antenatal_venue_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_pregnancy; Owner: -
--

ALTER SEQUENCE lu_antenatal_venue_pk_seq OWNED BY lu_antenatal_venue.pk;


SET search_path = clin_prescribing, pg_catalog;

--
-- Name: items_prescribed; Type: TABLE; Schema: clin_prescribing; Owner: -; Tablespace: 
--

CREATE TABLE items_prescribed (
    pk integer NOT NULL,
    fk_consult integer NOT NULL,
    fk_medication integer NOT NULL,
    fk_pack integer NOT NULL,
    fk_instruction integer NOT NULL,
    fk_authority integer,
    fk_pbs integer NOT NULL,
    print_status text NOT NULL,
    script_date date NOT NULL,
    suppress_reason boolean DEFAULT false,
    repeats integer,
    quantity integer,
    s8 boolean DEFAULT false,
    reg24 boolean DEFAULT false,
    active boolean DEFAULT false,
    strength text,
    fk_coding_system integer,
    fk_prescribed_for text
);


--
-- Name: TABLE items_prescribed; Type: COMMENT; Schema: clin_prescribing; Owner: -
--

COMMENT ON TABLE items_prescribed IS 'Every single item prescribed has an entry here
	this table gives us
	- the doctor who prescribed
	- the date prescription was issued consult.date
	- the actual date on the script (script_date)
	  which could be foreward or back dated
	- the medication details (fk_medication > who
	  first prescribed it, date first started, active
	- stuff which could be unique for this prescription
	  such as pbs details, quantity, repeats, reg 25, s8
	- print_status is pbs or rpbs or priv
	- the pack details for this drug on this occasion.';


--
-- Name: items_prescribed_pk_seq; Type: SEQUENCE; Schema: clin_prescribing; Owner: -
--

CREATE SEQUENCE items_prescribed_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: items_prescribed_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_prescribing; Owner: -
--

ALTER SEQUENCE items_prescribed_pk_seq OWNED BY items_prescribed.pk;


--
-- Name: link_generics_brands; Type: TABLE; Schema: clin_prescribing; Owner: -; Tablespace: 
--

CREATE TABLE link_generics_brands (
    pk integer NOT NULL,
    fk_generics integer NOT NULL,
    fk_brand integer NOT NULL
);


--
-- Name: link_generics_brands_pk_seq; Type: SEQUENCE; Schema: clin_prescribing; Owner: -
--

CREATE SEQUENCE link_generics_brands_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: link_generics_brands_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_prescribing; Owner: -
--

ALTER SEQUENCE link_generics_brands_pk_seq OWNED BY link_generics_brands.pk;


--
-- Name: lu_authority_indications; Type: TABLE; Schema: clin_prescribing; Owner: -; Tablespace: 
--

CREATE TABLE lu_authority_indications (
    pk integer NOT NULL,
    indication text
);


--
-- Name: lu_authority_indications_pk_seq; Type: SEQUENCE; Schema: clin_prescribing; Owner: -
--

CREATE SEQUENCE lu_authority_indications_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_authority_indications_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_prescribing; Owner: -
--

ALTER SEQUENCE lu_authority_indications_pk_seq OWNED BY lu_authority_indications.pk;


--
-- Name: lu_brand; Type: TABLE; Schema: clin_prescribing; Owner: -; Tablespace: 
--

CREATE TABLE lu_brand (
    pk integer NOT NULL,
    brand text
);


--
-- Name: TABLE lu_brand; Type: COMMENT; Schema: clin_prescribing; Owner: -
--

COMMENT ON TABLE lu_brand IS 'brands used kept independant form MIMS because drugs come and go';


--
-- Name: lu_brand_pk_seq; Type: SEQUENCE; Schema: clin_prescribing; Owner: -
--

CREATE SEQUENCE lu_brand_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_brand_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_prescribing; Owner: -
--

ALTER SEQUENCE lu_brand_pk_seq OWNED BY lu_brand.pk;


--
-- Name: lu_generics; Type: TABLE; Schema: clin_prescribing; Owner: -; Tablespace: 
--

CREATE TABLE lu_generics (
    pk integer NOT NULL,
    generics text NOT NULL,
    class_codes text
);


--
-- Name: lu_generics_pk_seq; Type: SEQUENCE; Schema: clin_prescribing; Owner: -
--

CREATE SEQUENCE lu_generics_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_generics_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_prescribing; Owner: -
--

ALTER SEQUENCE lu_generics_pk_seq OWNED BY lu_generics.pk;


--
-- Name: lu_instruction_habits; Type: TABLE; Schema: clin_prescribing; Owner: -; Tablespace: 
--

CREATE TABLE lu_instruction_habits (
    pk integer NOT NULL,
    fk_instruction integer NOT NULL,
    fk_brand integer NOT NULL,
    fk_staff integer NOT NULL,
    formulation text NOT NULL,
    weighting integer NOT NULL
);


--
-- Name: lu_instruction_habits_pk_seq; Type: SEQUENCE; Schema: clin_prescribing; Owner: -
--

CREATE SEQUENCE lu_instruction_habits_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_instruction_habits_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_prescribing; Owner: -
--

ALTER SEQUENCE lu_instruction_habits_pk_seq OWNED BY lu_instruction_habits.pk;


--
-- Name: lu_instructions; Type: TABLE; Schema: clin_prescribing; Owner: -; Tablespace: 
--

CREATE TABLE lu_instructions (
    pk integer NOT NULL,
    instruction text,
    fk_unit integer,
    am integer,
    lunch integer,
    pm integer,
    bed integer,
    prn integer
);


--
-- Name: lu_instructions_pk_seq; Type: SEQUENCE; Schema: clin_prescribing; Owner: -
--

CREATE SEQUENCE lu_instructions_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_instructions_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_prescribing; Owner: -
--

ALTER SEQUENCE lu_instructions_pk_seq OWNED BY lu_instructions.pk;


--
-- Name: lu_next_authority_number; Type: TABLE; Schema: clin_prescribing; Owner: -; Tablespace: 
--

CREATE TABLE lu_next_authority_number (
    pk integer NOT NULL,
    authority_number integer
);


--
-- Name: lu_next_authority_number_pk_seq; Type: SEQUENCE; Schema: clin_prescribing; Owner: -
--

CREATE SEQUENCE lu_next_authority_number_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_next_authority_number_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_prescribing; Owner: -
--

ALTER SEQUENCE lu_next_authority_number_pk_seq OWNED BY lu_next_authority_number.pk;


--
-- Name: lu_pbs_status; Type: TABLE; Schema: clin_prescribing; Owner: -; Tablespace: 
--

CREATE TABLE lu_pbs_status (
    pk integer NOT NULL,
    status text
);


--
-- Name: TABLE lu_pbs_status; Type: COMMENT; Schema: clin_prescribing; Owner: -
--

COMMENT ON TABLE lu_pbs_status IS 'The way the drug is handled on the pbs
   e.g pbs, rpbs, private, section 100';


--
-- Name: lu_pbs_status_pk_seq; Type: SEQUENCE; Schema: clin_prescribing; Owner: -
--

CREATE SEQUENCE lu_pbs_status_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_pbs_status_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_prescribing; Owner: -
--

ALTER SEQUENCE lu_pbs_status_pk_seq OWNED BY lu_pbs_status.pk;


--
-- Name: medication_audit_reasons; Type: TABLE; Schema: clin_prescribing; Owner: -; Tablespace: 
--

CREATE TABLE medication_audit_reasons (
    pk integer NOT NULL,
    reason text NOT NULL
);


--
-- Name: TABLE medication_audit_reasons; Type: COMMENT; Schema: clin_prescribing; Owner: -
--

COMMENT ON TABLE medication_audit_reasons IS 'a table to keep the reason a medication was changed, to help
  keep track of difficult things like sensitivities, patients
  refusing to take one medication, side effects, ineffective etc
  when used in combination with medication_audit_trail allows popup
  reasons on a per-user basis (via fk_consult)
  ';


--
-- Name: medication_audit_reasons_pk_seq; Type: SEQUENCE; Schema: clin_prescribing; Owner: -
--

CREATE SEQUENCE medication_audit_reasons_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: medication_audit_reasons_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_prescribing; Owner: -
--

ALTER SEQUENCE medication_audit_reasons_pk_seq OWNED BY medication_audit_reasons.pk;


--
-- Name: medication_audit_trail; Type: TABLE; Schema: clin_prescribing; Owner: -; Tablespace: 
--

CREATE TABLE medication_audit_trail (
    pk integer NOT NULL,
    fk_consult integer NOT NULL,
    fk_medication integer NOT NULL,
    fk_audit_reason integer NOT NULL
);


--
-- Name: TABLE medication_audit_trail; Type: COMMENT; Schema: clin_prescribing; Owner: -
--

COMMENT ON TABLE medication_audit_trail IS 'a table to keep the reason a medication was changed, to help
  keep track of difficult things like sensitivities, patients
  refusing to take one medication, side effects, ineffective etc';


--
-- Name: medication_audit_trail_pk_seq; Type: SEQUENCE; Schema: clin_prescribing; Owner: -
--

CREATE SEQUENCE medication_audit_trail_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: medication_audit_trail_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_prescribing; Owner: -
--

ALTER SEQUENCE medication_audit_trail_pk_seq OWNED BY medication_audit_trail.pk;


--
-- Name: medications; Type: TABLE; Schema: clin_prescribing; Owner: -; Tablespace: 
--

CREATE TABLE medications (
    pk integer NOT NULL,
    fk_lu_generics integer,
    fk_lu_brand integer,
    deleted boolean DEFAULT false
);


--
-- Name: medications_pk_seq; Type: SEQUENCE; Schema: clin_prescribing; Owner: -
--

CREATE SEQUENCE medications_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: medications_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_prescribing; Owner: -
--

ALTER SEQUENCE medications_pk_seq OWNED BY medications.pk;


--
-- Name: pack_details; Type: TABLE; Schema: clin_prescribing; Owner: -; Tablespace: 
--

CREATE TABLE pack_details (
    pk integer NOT NULL,
    details character(50),
    formulation text
);


--
-- Name: pack_details_pk_seq; Type: SEQUENCE; Schema: clin_prescribing; Owner: -
--

CREATE SEQUENCE pack_details_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: pack_details_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_prescribing; Owner: -
--

ALTER SEQUENCE pack_details_pk_seq OWNED BY pack_details.pk;


--
-- Name: script_dates; Type: TABLE; Schema: clin_prescribing; Owner: -; Tablespace: 
--

CREATE TABLE script_dates (
    pk integer NOT NULL,
    start_date date,
    last_date date
);


--
-- Name: script_dates_pk_seq; Type: SEQUENCE; Schema: clin_prescribing; Owner: -
--

CREATE SEQUENCE script_dates_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: script_dates_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_prescribing; Owner: -
--

ALTER SEQUENCE script_dates_pk_seq OWNED BY script_dates.pk;


--
-- Name: vwpatientsmedications; Type: VIEW; Schema: clin_prescribing; Owner: -
--

CREATE VIEW vwpatientsmedications AS
    SELECT consult.fk_patient, items_prescribed.script_date, lu_brand.brand, lu_generics.generics, items_prescribed.strength, items_prescribed.repeats, lu_instructions.instruction, generic_terms.term, items_prescribed.quantity, lu_generics.class_codes, items_prescribed.pk AS pk_item_prescribed, items_prescribed.fk_consult, items_prescribed.fk_medication, items_prescribed.fk_pack, items_prescribed.fk_instruction, items_prescribed.fk_prescribed_for, items_prescribed.fk_authority, items_prescribed.fk_pbs, items_prescribed.print_status, items_prescribed.suppress_reason, items_prescribed.s8, items_prescribed.reg24, items_prescribed.active, consult.consult_date, consult.fk_staff, medications.fk_lu_generics, medications.fk_lu_brand, medications.deleted, lu_pbs_status.status AS pbs_status FROM (((((((items_prescribed JOIN medications ON ((items_prescribed.fk_medication = medications.pk))) JOIN lu_brand ON ((medications.fk_lu_brand = lu_brand.pk))) JOIN lu_generics ON ((medications.fk_lu_generics = lu_generics.pk))) JOIN clin_consult.consult ON ((items_prescribed.fk_consult = consult.pk))) JOIN lu_instructions ON ((items_prescribed.fk_instruction = lu_instructions.pk))) JOIN coding.generic_terms ON (((items_prescribed.fk_prescribed_for = generic_terms.code) AND (items_prescribed.fk_coding_system = generic_terms.fk_coding_system)))) JOIN lu_pbs_status ON ((items_prescribed.fk_pbs = lu_pbs_status.pk))) WHERE (NOT medications.deleted);


SET search_path = clin_procedures, pg_catalog;

--
-- Name: link_images_procedures; Type: TABLE; Schema: clin_procedures; Owner: -; Tablespace: 
--

CREATE TABLE link_images_procedures (
    pk integer NOT NULL,
    fk_image integer NOT NULL,
    fk_procedure integer NOT NULL,
    deleted boolean DEFAULT false
);


--
-- Name: TABLE link_images_procedures; Type: COMMENT; Schema: clin_procedures; Owner: -
--

COMMENT ON TABLE link_images_procedures IS ' links images to a procedure - one to many';


--
-- Name: COLUMN link_images_procedures.fk_image; Type: COMMENT; Schema: clin_procedures; Owner: -
--

COMMENT ON COLUMN link_images_procedures.fk_image IS ' key to clin_consult.images table';


--
-- Name: COLUMN link_images_procedures.fk_procedure; Type: COMMENT; Schema: clin_procedures; Owner: -
--

COMMENT ON COLUMN link_images_procedures.fk_procedure IS 'ky to a procedure table eg skin_procedures';


--
-- Name: COLUMN link_images_procedures.deleted; Type: COMMENT; Schema: clin_procedures; Owner: -
--

COMMENT ON COLUMN link_images_procedures.deleted IS 'if true then the image is marked as deleted';


--
-- Name: link_images_procedures_pk_seq; Type: SEQUENCE; Schema: clin_procedures; Owner: -
--

CREATE SEQUENCE link_images_procedures_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: link_images_procedures_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_procedures; Owner: -
--

ALTER SEQUENCE link_images_procedures_pk_seq OWNED BY link_images_procedures.pk;


--
-- Name: lu_anaesthetic_agent; Type: TABLE; Schema: clin_procedures; Owner: -; Tablespace: 
--

CREATE TABLE lu_anaesthetic_agent (
    pk integer NOT NULL,
    agent text NOT NULL,
    fk_lu_route_administration integer NOT NULL
);


--
-- Name: COLUMN lu_anaesthetic_agent.fk_lu_route_administration; Type: COMMENT; Schema: clin_procedures; Owner: -
--

COMMENT ON COLUMN lu_anaesthetic_agent.fk_lu_route_administration IS 'foreign key to common.lu_route_adminstration e.g sub-cutaneous)';


--
-- Name: lu_anaesthetic_agent_pk_seq; Type: SEQUENCE; Schema: clin_procedures; Owner: -
--

CREATE SEQUENCE lu_anaesthetic_agent_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_anaesthetic_agent_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_procedures; Owner: -
--

ALTER SEQUENCE lu_anaesthetic_agent_pk_seq OWNED BY lu_anaesthetic_agent.pk;


--
-- Name: lu_complications; Type: TABLE; Schema: clin_procedures; Owner: -; Tablespace: 
--

CREATE TABLE lu_complications (
    pk integer NOT NULL,
    complication text NOT NULL
);


--
-- Name: lu_complications_pk_seq; Type: SEQUENCE; Schema: clin_procedures; Owner: -
--

CREATE SEQUENCE lu_complications_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_complications_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_procedures; Owner: -
--

ALTER SEQUENCE lu_complications_pk_seq OWNED BY lu_complications.pk;


--
-- Name: lu_procedure_type; Type: TABLE; Schema: clin_procedures; Owner: -; Tablespace: 
--

CREATE TABLE lu_procedure_type (
    pk integer NOT NULL,
    type text NOT NULL
);


--
-- Name: TABLE lu_procedure_type; Type: COMMENT; Schema: clin_procedures; Owner: -
--

COMMENT ON TABLE lu_procedure_type IS 'the type of excision eg ellipse, graft, flap etc';


--
-- Name: lu_excision_type_pk_seq; Type: SEQUENCE; Schema: clin_procedures; Owner: -
--

CREATE SEQUENCE lu_excision_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_excision_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_procedures; Owner: -
--

ALTER SEQUENCE lu_excision_type_pk_seq OWNED BY lu_procedure_type.pk;


--
-- Name: lu_last_surgical_pack; Type: TABLE; Schema: clin_procedures; Owner: -; Tablespace: 
--

CREATE TABLE lu_last_surgical_pack (
    pk integer NOT NULL,
    identifier text NOT NULL,
    fk_clinic integer NOT NULL
);


--
-- Name: TABLE lu_last_surgical_pack; Type: COMMENT; Schema: clin_procedures; Owner: -
--

COMMENT ON TABLE lu_last_surgical_pack IS 'the last pack used - probably close to or = to date of one now using';


--
-- Name: lu_pack_pk_seq; Type: SEQUENCE; Schema: clin_procedures; Owner: -
--

CREATE SEQUENCE lu_pack_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_pack_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_procedures; Owner: -
--

ALTER SEQUENCE lu_pack_pk_seq OWNED BY lu_last_surgical_pack.pk;


--
-- Name: lu_repair_type; Type: TABLE; Schema: clin_procedures; Owner: -; Tablespace: 
--

CREATE TABLE lu_repair_type (
    pk integer NOT NULL,
    type text
);


--
-- Name: lu_repair_type_pk_seq; Type: SEQUENCE; Schema: clin_procedures; Owner: -
--

CREATE SEQUENCE lu_repair_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_repair_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_procedures; Owner: -
--

ALTER SEQUENCE lu_repair_type_pk_seq OWNED BY lu_repair_type.pk;


--
-- Name: lu_skin_preparation; Type: TABLE; Schema: clin_procedures; Owner: -; Tablespace: 
--

CREATE TABLE lu_skin_preparation (
    pk integer NOT NULL,
    preparation text NOT NULL
);


--
-- Name: lu_skin_preparation_pk_seq; Type: SEQUENCE; Schema: clin_procedures; Owner: -
--

CREATE SEQUENCE lu_skin_preparation_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_skin_preparation_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_procedures; Owner: -
--

ALTER SEQUENCE lu_skin_preparation_pk_seq OWNED BY lu_skin_preparation.pk;


--
-- Name: lu_suture_site; Type: TABLE; Schema: clin_procedures; Owner: -; Tablespace: 
--

CREATE TABLE lu_suture_site (
    pk integer NOT NULL,
    site text
);


--
-- Name: TABLE lu_suture_site; Type: COMMENT; Schema: clin_procedures; Owner: -
--

COMMENT ON TABLE lu_suture_site IS 'the site the suture is used eg subcutaneous, skin, sclera, cornea, blood vessel';


--
-- Name: lu_suture_site_pk_seq; Type: SEQUENCE; Schema: clin_procedures; Owner: -
--

CREATE SEQUENCE lu_suture_site_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_suture_site_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_procedures; Owner: -
--

ALTER SEQUENCE lu_suture_site_pk_seq OWNED BY lu_suture_site.pk;


--
-- Name: lu_suture_type; Type: TABLE; Schema: clin_procedures; Owner: -; Tablespace: 
--

CREATE TABLE lu_suture_type (
    pk integer NOT NULL,
    brand text NOT NULL,
    fk_lu_site integer
);


--
-- Name: TABLE lu_suture_type; Type: COMMENT; Schema: clin_procedures; Owner: -
--

COMMENT ON TABLE lu_suture_type IS 'type of sutures, could extend this table to include ordering of sutures by incrementing the count etc somewhere';


--
-- Name: lu_suture_type_pk_seq; Type: SEQUENCE; Schema: clin_procedures; Owner: -
--

CREATE SEQUENCE lu_suture_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_suture_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_procedures; Owner: -
--

ALTER SEQUENCE lu_suture_type_pk_seq OWNED BY lu_suture_type.pk;


--
-- Name: skin_procedures; Type: TABLE; Schema: clin_procedures; Owner: -; Tablespace: 
--

CREATE TABLE skin_procedures (
    pk integer NOT NULL,
    fk_consult integer NOT NULL,
    date date NOT NULL,
    explained_procedure boolean DEFAULT false,
    obtained_consent boolean DEFAULT false,
    detailed_complications boolean DEFAULT false,
    fk_lu_site integer NOT NULL,
    lesion_notes text,
    dermoscopy_notes text,
    fk_lu_lateralisation integer,
    fk_lu_anterior_posterior integer,
    localisation text,
    surgical_pack_identifier text NOT NULL,
    fk_lu_skin_preparation integer,
    fk_lu_anaesthetic_agent integer,
    fk_lu_procedure_type integer,
    fk_lu_repair_type integer,
    fk_subcutaneous_suture integer,
    fk_skin_suture integer,
    average_diameter_cm numeric,
    fk_provisional_diagnosis text,
    fk_document integer,
    fk_actual_diagnosis text,
    referred boolean DEFAULT false,
    review_months integer,
    fk_branch integer,
    fk_form integer,
    complications text,
    fk_progressnote_auto integer,
    fk_pasthistory integer,
    fk_progressnote_user integer
);


--
-- Name: TABLE skin_procedures; Type: COMMENT; Schema: clin_procedures; Owner: -
--

COMMENT ON TABLE skin_procedures IS 'keeps data for skin procedures';


--
-- Name: COLUMN skin_procedures.fk_consult; Type: COMMENT; Schema: clin_procedures; Owner: -
--

COMMENT ON COLUMN skin_procedures.fk_consult IS 'pk of clin_consult.consult table ie links to staff and patient';


--
-- Name: COLUMN skin_procedures.date; Type: COMMENT; Schema: clin_procedures; Owner: -
--

COMMENT ON COLUMN skin_procedures.date IS 'date performed may no <> date consult notes written up';


--
-- Name: COLUMN skin_procedures.explained_procedure; Type: COMMENT; Schema: clin_procedures; Owner: -
--

COMMENT ON COLUMN skin_procedures.explained_procedure IS 'if true the clinician explained the procedure to the patient';


--
-- Name: COLUMN skin_procedures.obtained_consent; Type: COMMENT; Schema: clin_procedures; Owner: -
--

COMMENT ON COLUMN skin_procedures.obtained_consent IS 'if true the clinician obtained consent fo the procedure from the patient';


--
-- Name: COLUMN skin_procedures.detailed_complications; Type: COMMENT; Schema: clin_procedures; Owner: -
--

COMMENT ON COLUMN skin_procedures.detailed_complications IS 'if true the clinician detailed the complications of the procedure to the patient';


--
-- Name: COLUMN skin_procedures.fk_lu_site; Type: COMMENT; Schema: clin_procedures; Owner: -
--

COMMENT ON COLUMN skin_procedures.fk_lu_site IS 'pk of clin_procedures.lu_site e.g could be the foot';


--
-- Name: COLUMN skin_procedures.lesion_notes; Type: COMMENT; Schema: clin_procedures; Owner: -
--

COMMENT ON COLUMN skin_procedures.lesion_notes IS 'clinical notes re this excision';


--
-- Name: COLUMN skin_procedures.dermoscopy_notes; Type: COMMENT; Schema: clin_procedures; Owner: -
--

COMMENT ON COLUMN skin_procedures.dermoscopy_notes IS 'clinical notes re this excision';


--
-- Name: COLUMN skin_procedures.fk_lu_lateralisation; Type: COMMENT; Schema: clin_procedures; Owner: -
--

COMMENT ON COLUMN skin_procedures.fk_lu_lateralisation IS 'pk of common.lu_lateralisation';


--
-- Name: COLUMN skin_procedures.localisation; Type: COMMENT; Schema: clin_procedures; Owner: -
--

COMMENT ON COLUMN skin_procedures.localisation IS 'add notes to localise lesion e.g near scapula or above umbilicus';


--
-- Name: COLUMN skin_procedures.surgical_pack_identifier; Type: COMMENT; Schema: clin_procedures; Owner: -
--

COMMENT ON COLUMN skin_procedures.surgical_pack_identifier IS 'pack identifier for surgicalinstrument(s) may be multiple';


--
-- Name: COLUMN skin_procedures.fk_lu_skin_preparation; Type: COMMENT; Schema: clin_procedures; Owner: -
--

COMMENT ON COLUMN skin_procedures.fk_lu_skin_preparation IS 'text explaining how skin was prepped';


--
-- Name: COLUMN skin_procedures.fk_lu_procedure_type; Type: COMMENT; Schema: clin_procedures; Owner: -
--

COMMENT ON COLUMN skin_procedures.fk_lu_procedure_type IS 'key to clin_procedures.lu_procedure_type table';


--
-- Name: COLUMN skin_procedures.fk_subcutaneous_suture; Type: COMMENT; Schema: clin_procedures; Owner: -
--

COMMENT ON COLUMN skin_procedures.fk_subcutaneous_suture IS 'key to clin_procedures.lu_suture_type table';


--
-- Name: COLUMN skin_procedures.fk_skin_suture; Type: COMMENT; Schema: clin_procedures; Owner: -
--

COMMENT ON COLUMN skin_procedures.fk_skin_suture IS 'key to clin_procedures.lu_suture_type table';


--
-- Name: COLUMN skin_procedures.fk_provisional_diagnosis; Type: COMMENT; Schema: clin_procedures; Owner: -
--

COMMENT ON COLUMN skin_procedures.fk_provisional_diagnosis IS 'key to coding.generic_terms table generic_terms.code
 this field is a string ';


--
-- Name: COLUMN skin_procedures.fk_document; Type: COMMENT; Schema: clin_procedures; Owner: -
--

COMMENT ON COLUMN skin_procedures.fk_document IS 'Points to the document which is the result';


--
-- Name: COLUMN skin_procedures.fk_actual_diagnosis; Type: COMMENT; Schema: clin_procedures; Owner: -
--

COMMENT ON COLUMN skin_procedures.fk_actual_diagnosis IS 'key to coding.generic_terms table generic_terms.code
 this field is a string ';


--
-- Name: COLUMN skin_procedures.fk_progressnote_auto; Type: COMMENT; Schema: clin_procedures; Owner: -
--

COMMENT ON COLUMN skin_procedures.fk_progressnote_auto IS 'Key to clin_consult.progressnotes.

At each excision all the fields the user filled in are used to auto-generate a description of the exision, and this is saved to the progress notes. ';


--
-- Name: COLUMN skin_procedures.fk_pasthistory; Type: COMMENT; Schema: clin_procedures; Owner: -
--

COMMENT ON COLUMN skin_procedures.fk_pasthistory IS 'if not null it is the health issue linked to this procedure foreign key to clin_history.past_history';


--
-- Name: COLUMN skin_procedures.fk_progressnote_user; Type: COMMENT; Schema: clin_procedures; Owner: -
--

COMMENT ON COLUMN skin_procedures.fk_progressnote_user IS 'Key to clin_consult.progress_notes.

At each exicision, the user can put in free-hand  clinical notes';


--
-- Name: skin_procedures_pk_seq; Type: SEQUENCE; Schema: clin_procedures; Owner: -
--

CREATE SEQUENCE skin_procedures_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: skin_procedures_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_procedures; Owner: -
--

ALTER SEQUENCE skin_procedures_pk_seq OWNED BY skin_procedures.pk;


--
-- Name: staff_skin_procedure_defaults; Type: TABLE; Schema: clin_procedures; Owner: -; Tablespace: 
--

CREATE TABLE staff_skin_procedure_defaults (
    pk integer NOT NULL,
    fk_staff integer,
    fk_lu_skin_preparation integer,
    fk_lu_anaesthetic_agent integer,
    fk_lu_procedure_type integer,
    fk_lu_repair_type integer,
    fk_subcutaneous_suture integer,
    fk_skin_suture integer,
    fk_user_provider_defaults integer
);


--
-- Name: TABLE staff_skin_procedure_defaults; Type: COMMENT; Schema: clin_procedures; Owner: -
--

COMMENT ON TABLE staff_skin_procedure_defaults IS 'The defaults for a staff member for a skin procedure, e.g
	  what type of skin prep, suture materials, who they send pathology
	  to, electronic or paper etc';


--
-- Name: COLUMN staff_skin_procedure_defaults.fk_user_provider_defaults; Type: COMMENT; Schema: clin_procedures; Owner: -
--

COMMENT ON COLUMN staff_skin_procedure_defaults.fk_user_provider_defaults IS 'key to clin_requests.user_provider_defaults table which details
	  the default branch, organisation and method of sending pathology';


--
-- Name: staff_skin_procedure_defaults_pk_seq; Type: SEQUENCE; Schema: clin_procedures; Owner: -
--

CREATE SEQUENCE staff_skin_procedure_defaults_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: staff_skin_procedure_defaults_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_procedures; Owner: -
--

ALTER SEQUENCE staff_skin_procedure_defaults_pk_seq OWNED BY staff_skin_procedure_defaults.pk;


--
-- Name: surgical_packs; Type: TABLE; Schema: clin_procedures; Owner: -; Tablespace: 
--

CREATE TABLE surgical_packs (
    pk integer NOT NULL,
    identifier text NOT NULL,
    fk_staff integer NOT NULL,
    fk_clinic integer NOT NULL,
    date_sterilised date NOT NULL,
    date_expires date NOT NULL
);


--
-- Name: TABLE surgical_packs; Type: COMMENT; Schema: clin_procedures; Owner: -
--

COMMENT ON TABLE surgical_packs IS 'info about each surgical pack sterilized';


--
-- Name: surgical_packs_pk_seq; Type: SEQUENCE; Schema: clin_procedures; Owner: -
--

CREATE SEQUENCE surgical_packs_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: surgical_packs_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_procedures; Owner: -
--

ALTER SEQUENCE surgical_packs_pk_seq OWNED BY surgical_packs.pk;


--
-- Name: vwimages; Type: VIEW; Schema: clin_procedures; Owner: -
--

CREATE VIEW vwimages AS
    SELECT all_images.image, link_images_procedures.fk_image, link_images_procedures.fk_procedure, link_images_procedures.deleted, link_images_procedures.pk AS pk_link_images_procedures FROM (link_images_procedures JOIN public.all_images ON ((link_images_procedures.fk_image = all_images.pk))) WHERE (link_images_procedures.deleted = false) ORDER BY link_images_procedures.fk_procedure;


--
-- Name: vwimages1; Type: VIEW; Schema: clin_procedures; Owner: -
--

CREATE VIEW vwimages1 AS
    SELECT images.image, link_images_procedures.fk_image, link_images_procedures.fk_procedure, link_images_procedures.deleted, link_images_procedures.pk AS pk_link_images_procedures FROM (link_images_procedures JOIN clin_consult.images ON ((link_images_procedures.fk_image = images.pk))) WHERE (link_images_procedures.deleted = false) ORDER BY link_images_procedures.fk_procedure;


SET search_path = clin_requests, pg_catalog;

--
-- Name: forms; Type: TABLE; Schema: clin_requests; Owner: -; Tablespace: 
--

CREATE TABLE forms (
    pk integer NOT NULL,
    fk_consult integer NOT NULL,
    date date,
    fk_branch integer NOT NULL,
    fk_lu_request_type integer NOT NULL,
    requests_summary text NOT NULL,
    notes_summary text,
    medications_summary text,
    copyto text,
    form_html text,
    deleted boolean DEFAULT false,
    copyto_patient boolean DEFAULT false,
    urgent boolean DEFAULT false,
    bulk_bill boolean DEFAULT false,
    fasting boolean DEFAULT false,
    phone boolean DEFAULT false,
    fax boolean DEFAULT false,
    include_medications boolean DEFAULT false,
    pk_image integer,
    forms_results_html text,
    fk_progressnote integer
);


--
-- Name: TABLE forms; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON TABLE forms IS 'Links a form to a consult(hence the patient/date), organisation, type of request, notes, etc';


--
-- Name: COLUMN forms.fk_consult; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON COLUMN forms.fk_consult IS 'foreign key to clin_consult.consult table';


--
-- Name: COLUMN forms.date; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON COLUMN forms.date IS 'the date printed on request form. May not be
same as consult_date, for instance, if dated in the future';


--
-- Name: COLUMN forms.fk_branch; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON COLUMN forms.fk_branch IS 'foreign key to contacts.data_branches table points to organisation service is requested of, the branch address, all comms for the organisation, branch etc
FIXME - BAD NAME, MIXED UP NOMENCLATURE';


--
-- Name: COLUMN forms.fk_lu_request_type; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON COLUMN forms.fk_lu_request_type IS 'foreign key to clin_requests.lu_type table e.g 1= pathology';


--
-- Name: COLUMN forms.requests_summary; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON COLUMN forms.requests_summary IS ' delimited ; summary of requests eg fbc;esr;msu;lfts;';


--
-- Name: COLUMN forms.notes_summary; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON COLUMN forms.notes_summary IS ' delimited ; summary of clinicalnotes eg tiredness;weight loss;';


--
-- Name: COLUMN forms.medications_summary; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON COLUMN forms.medications_summary IS ' delimited ; summary of medications eg ranitidine;simvastatin';


--
-- Name: COLUMN forms.deleted; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON COLUMN forms.deleted IS 'if true the the request form as been deleted';


--
-- Name: COLUMN forms.forms_results_html; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON COLUMN forms.forms_results_html IS 'aggreggated result html for this request form';


SET search_path = common, pg_catalog;

--
-- Name: lu_anatomical_site; Type: TABLE; Schema: common; Owner: -; Tablespace: 
--

CREATE TABLE lu_anatomical_site (
    pk integer NOT NULL,
    site text NOT NULL
);


--
-- Name: lu_anterior_posterior; Type: TABLE; Schema: common; Owner: -; Tablespace: 
--

CREATE TABLE lu_anterior_posterior (
    pk integer NOT NULL,
    anterior_posterior text
);


SET search_path = clin_procedures, pg_catalog;

--
-- Name: vwskinprocedures; Type: VIEW; Schema: clin_procedures; Owner: -
--

CREATE VIEW vwskinprocedures AS
    SELECT skin_procedures.pk AS pk_view, skin_procedures.pk AS fk_skin_procedure, skin_procedures.fk_consult, skin_procedures.date, skin_procedures.explained_procedure, skin_procedures.obtained_consent, skin_procedures.detailed_complications, skin_procedures.fk_lu_site, skin_procedures.lesion_notes, skin_procedures.dermoscopy_notes, skin_procedures.fk_lu_lateralisation, skin_procedures.fk_lu_anterior_posterior, skin_procedures.localisation, skin_procedures.surgical_pack_identifier, skin_procedures.fk_lu_skin_preparation, skin_procedures.fk_lu_anaesthetic_agent, skin_procedures.fk_lu_procedure_type, skin_procedures.fk_lu_repair_type, skin_procedures.fk_subcutaneous_suture, skin_procedures.fk_skin_suture, skin_procedures.average_diameter_cm, skin_procedures.fk_provisional_diagnosis, generic_terms.term AS provisional_diagnosis, skin_procedures.fk_document, skin_procedures.fk_actual_diagnosis, generic_terms1.term AS actual_diagnosis, skin_procedures.fk_pasthistory, skin_procedures.referred, skin_procedures.review_months, skin_procedures.fk_branch, skin_procedures.fk_form, skin_procedures.complications, skin_procedures.fk_progressnote_auto, progressnotes.notes AS progressnote_auto, skin_procedures.fk_progressnote_user, progressnotes1.notes AS progressnote_user, consult.consult_date, consult.fk_staff, consult.fk_patient, lu_anatomical_site.site, lu_anterior_posterior.anterior_posterior, lu_laterality.laterality, lu_skin_preparation.preparation, lu_anaesthetic_agent.agent, lu_anaesthetic_agent.fk_lu_route_administration, lu_procedure_type.type AS procedure_type, lu_repair_type.type AS repair_type, lu_suture_type.brand AS skin_suture, lu_suture_type1.brand AS subcutaneous_suture, data_organisations.organisation, vwstaff.wholename, vwstaff.title, forms.form_html FROM ((((((((((((((((((skin_procedures JOIN clin_consult.consult ON ((skin_procedures.fk_consult = consult.pk))) JOIN common.lu_anatomical_site ON ((skin_procedures.fk_lu_site = lu_anatomical_site.pk))) LEFT JOIN common.lu_anterior_posterior ON ((skin_procedures.fk_lu_anterior_posterior = lu_anterior_posterior.pk))) LEFT JOIN common.lu_laterality ON ((skin_procedures.fk_lu_lateralisation = lu_laterality.pk))) LEFT JOIN lu_skin_preparation ON ((skin_procedures.fk_lu_skin_preparation = lu_skin_preparation.pk))) LEFT JOIN coding.generic_terms ON ((skin_procedures.fk_provisional_diagnosis = generic_terms.code))) JOIN lu_anaesthetic_agent ON ((skin_procedures.fk_lu_anaesthetic_agent = lu_anaesthetic_agent.pk))) JOIN lu_procedure_type ON ((skin_procedures.fk_lu_procedure_type = lu_procedure_type.pk))) JOIN lu_repair_type ON ((skin_procedures.fk_lu_repair_type = lu_repair_type.pk))) JOIN lu_suture_type ON ((skin_procedures.fk_skin_suture = lu_suture_type.pk))) JOIN lu_suture_type lu_suture_type1 ON ((skin_procedures.fk_subcutaneous_suture = lu_suture_type1.pk))) LEFT JOIN coding.generic_terms generic_terms1 ON ((skin_procedures.fk_actual_diagnosis = generic_terms1.code))) LEFT JOIN contacts.data_branches ON ((skin_procedures.fk_branch = data_branches.pk))) LEFT JOIN clin_requests.forms ON ((skin_procedures.fk_form = forms.pk))) LEFT JOIN clin_consult.progressnotes progressnotes1 ON ((skin_procedures.fk_progressnote_user = progressnotes1.pk))) JOIN clin_consult.progressnotes ON ((skin_procedures.fk_progressnote_auto = progressnotes.pk))) JOIN contacts.data_organisations ON ((data_branches.fk_organisation = data_organisations.pk))) JOIN admin.vwstaff ON ((consult.fk_staff = vwstaff.fk_staff))) ORDER BY consult.fk_patient;


--
-- Name: vwstaffskinproceduredefaults; Type: VIEW; Schema: clin_procedures; Owner: -
--

CREATE VIEW vwstaffskinproceduredefaults AS
    SELECT lu_anaesthetic_agent.agent, lu_skin_preparation.preparation, staff_skin_procedure_defaults.pk AS pk_default, staff_skin_procedure_defaults.fk_staff, staff_skin_procedure_defaults.fk_lu_skin_preparation, staff_skin_procedure_defaults.fk_lu_anaesthetic_agent, staff_skin_procedure_defaults.fk_lu_procedure_type, staff_skin_procedure_defaults.fk_lu_repair_type, staff_skin_procedure_defaults.fk_subcutaneous_suture, staff_skin_procedure_defaults.fk_skin_suture, staff_skin_procedure_defaults.fk_user_provider_defaults, lu_suture_type.brand AS skin_suture, lu_suture_type1.brand AS subcutaneous_suture, lu_procedure_type.type AS procedure_type, lu_repair_type.type AS repair_type FROM ((((((staff_skin_procedure_defaults JOIN lu_anaesthetic_agent ON ((staff_skin_procedure_defaults.fk_lu_anaesthetic_agent = lu_anaesthetic_agent.pk))) JOIN lu_skin_preparation ON ((staff_skin_procedure_defaults.fk_lu_skin_preparation = lu_skin_preparation.pk))) JOIN lu_suture_type ON ((staff_skin_procedure_defaults.fk_skin_suture = lu_suture_type.pk))) JOIN lu_suture_type lu_suture_type1 ON ((staff_skin_procedure_defaults.fk_subcutaneous_suture = lu_suture_type1.pk))) JOIN lu_procedure_type ON ((staff_skin_procedure_defaults.fk_lu_procedure_type = lu_procedure_type.pk))) JOIN lu_repair_type ON ((staff_skin_procedure_defaults.fk_lu_repair_type = lu_repair_type.pk))) ORDER BY staff_skin_procedure_defaults.fk_staff;


--
-- Name: vwsutures; Type: VIEW; Schema: clin_procedures; Owner: -
--

CREATE VIEW vwsutures AS
    SELECT lu_suture_type.pk, lu_suture_type.brand, lu_suture_type.fk_lu_site, lu_suture_site.site FROM (lu_suture_type JOIN lu_suture_site ON ((lu_suture_type.fk_lu_site = lu_suture_site.pk))) ORDER BY lu_suture_site.site, lu_suture_type.brand;


SET search_path = clin_recalls, pg_catalog;

--
-- Name: forms; Type: TABLE; Schema: clin_recalls; Owner: -; Tablespace: 
--

CREATE TABLE forms (
    pk integer NOT NULL,
    form text
);


--
-- Name: TABLE forms; Type: COMMENT; Schema: clin_recalls; Owner: -
--

COMMENT ON TABLE forms IS 'embryonic table, will contain all data to create form, for now just a dummy text column';


--
-- Name: forms_pk_seq; Type: SEQUENCE; Schema: clin_recalls; Owner: -
--

CREATE SEQUENCE forms_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: forms_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_recalls; Owner: -
--

ALTER SEQUENCE forms_pk_seq OWNED BY forms.pk;


--
-- Name: links_forms; Type: TABLE; Schema: clin_recalls; Owner: -; Tablespace: 
--

CREATE TABLE links_forms (
    pk integer NOT NULL,
    fk_recalls integer NOT NULL,
    fk_form integer NOT NULL
);


--
-- Name: TABLE links_forms; Type: COMMENT; Schema: clin_recalls; Owner: -
--

COMMENT ON TABLE links_forms IS 'links a particular recall to one or more forms to include when patient recalled';


--
-- Name: COLUMN links_forms.fk_recalls; Type: COMMENT; Schema: clin_recalls; Owner: -
--

COMMENT ON COLUMN links_forms.fk_recalls IS 'foreign key to data_recalls table';


--
-- Name: COLUMN links_forms.fk_form; Type: COMMENT; Schema: clin_recalls; Owner: -
--

COMMENT ON COLUMN links_forms.fk_form IS 'foreign key to forms table';


--
-- Name: links_forms_pk_seq; Type: SEQUENCE; Schema: clin_recalls; Owner: -
--

CREATE SEQUENCE links_forms_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: links_forms_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_recalls; Owner: -
--

ALTER SEQUENCE links_forms_pk_seq OWNED BY links_forms.pk;


--
-- Name: lu_reasons; Type: TABLE; Schema: clin_recalls; Owner: -; Tablespace: 
--

CREATE TABLE lu_reasons (
    pk integer NOT NULL,
    reason text NOT NULL
);


--
-- Name: TABLE lu_reasons; Type: COMMENT; Schema: clin_recalls; Owner: -
--

COMMENT ON TABLE lu_reasons IS 'Keeps the reasons for the recall.
	Whilst these may equate to a code reason e.g colonoscopy
	they often will not e.g
	3rd Hepatitis B Injection
	May later want to link to coding system when we have one
  ';


--
-- Name: COLUMN lu_reasons.reason; Type: COMMENT; Schema: clin_recalls; Owner: -
--

COMMENT ON COLUMN lu_reasons.reason IS 'the reason for the recall';


--
-- Name: lu_reasons_pk_seq; Type: SEQUENCE; Schema: clin_recalls; Owner: -
--

CREATE SEQUENCE lu_reasons_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_reasons_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_recalls; Owner: -
--

ALTER SEQUENCE lu_reasons_pk_seq OWNED BY lu_reasons.pk;


--
-- Name: lu_recall_intervals; Type: TABLE; Schema: clin_recalls; Owner: -; Tablespace: 
--

CREATE TABLE lu_recall_intervals (
    pk integer NOT NULL,
    fk_reason integer NOT NULL,
    fk_staff integer NOT NULL,
    "interval" integer NOT NULL,
    fk_interval_unit integer NOT NULL
);


--
-- Name: TABLE lu_recall_intervals; Type: COMMENT; Schema: clin_recalls; Owner: -
--

COMMENT ON TABLE lu_recall_intervals IS 'Keeps list of intervals used on per-user basis to recall
  for things eg PAP 2yrs. Use this table to auto-insert dates
  for next recall due
  ';


--
-- Name: COLUMN lu_recall_intervals.fk_staff; Type: COMMENT; Schema: clin_recalls; Owner: -
--

COMMENT ON COLUMN lu_recall_intervals.fk_staff IS 'key to admin.staff table';


--
-- Name: COLUMN lu_recall_intervals."interval"; Type: COMMENT; Schema: clin_recalls; Owner: -
--

COMMENT ON COLUMN lu_recall_intervals."interval" IS 'the time interval for the recall 
    e.g 24 (if months) or 2 (if years)
    i.e the most ususal or common interval for this particular reason';


--
-- Name: COLUMN lu_recall_intervals.fk_interval_unit; Type: COMMENT; Schema: clin_recalls; Owner: -
--

COMMENT ON COLUMN lu_recall_intervals.fk_interval_unit IS 'key to common.lu_units table
   e.g a value of 6 = month';


--
-- Name: lu_recall_intervals_pk_seq; Type: SEQUENCE; Schema: clin_recalls; Owner: -
--

CREATE SEQUENCE lu_recall_intervals_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_recall_intervals_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_recalls; Owner: -
--

ALTER SEQUENCE lu_recall_intervals_pk_seq OWNED BY lu_recall_intervals.pk;


--
-- Name: lu_status; Type: TABLE; Schema: clin_recalls; Owner: -; Tablespace: 
--

CREATE TABLE lu_status (
    pk integer NOT NULL,
    status text
);


--
-- Name: TABLE lu_status; Type: COMMENT; Schema: clin_recalls; Owner: -
--

COMMENT ON TABLE lu_status IS 'Current status of the recall e.g outstanding, or arranged not completed etc';


--
-- Name: lu_status_pk_seq; Type: SEQUENCE; Schema: clin_recalls; Owner: -
--

CREATE SEQUENCE lu_status_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_status_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_recalls; Owner: -
--

ALTER SEQUENCE lu_status_pk_seq OWNED BY lu_status.pk;


--
-- Name: lu_templates; Type: TABLE; Schema: clin_recalls; Owner: -; Tablespace: 
--

CREATE TABLE lu_templates (
    pk integer NOT NULL,
    name text NOT NULL,
    deleted boolean,
    template text NOT NULL
);


--
-- Name: TABLE lu_templates; Type: COMMENT; Schema: clin_recalls; Owner: -
--

COMMENT ON TABLE lu_templates IS 'Table to hold templates for recall letters';


--
-- Name: COLUMN lu_templates.template; Type: COMMENT; Schema: clin_recalls; Owner: -
--

COMMENT ON COLUMN lu_templates.template IS 'html for a letter template';


--
-- Name: lu_templates_pk_seq; Type: SEQUENCE; Schema: clin_recalls; Owner: -
--

CREATE SEQUENCE lu_templates_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_templates_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_recalls; Owner: -
--

ALTER SEQUENCE lu_templates_pk_seq OWNED BY lu_templates.pk;


--
-- Name: recalls; Type: TABLE; Schema: clin_recalls; Owner: -; Tablespace: 
--

CREATE TABLE recalls (
    pk integer NOT NULL,
    fk_consult integer NOT NULL,
    due date NOT NULL,
    fk_reason integer NOT NULL,
    fk_contact_method integer NOT NULL,
    fk_urgency integer NOT NULL,
    fk_appointment_length integer NOT NULL,
    fk_staff integer NOT NULL,
    fk_status integer DEFAULT 1 NOT NULL,
    additional_text text,
    deleted boolean DEFAULT false,
    "interval" integer,
    fk_interval_unit integer,
    fk_audit integer,
    fk_progressnote integer,
    fk_pasthistory integer
);


--
-- Name: TABLE recalls; Type: COMMENT; Schema: clin_recalls; Owner: -
--

COMMENT ON TABLE recalls IS 'The main recall table
 notes: the fk_reason is key to recalls.lu_reasons table within this schema
         currently no coded reason is kept
         Example of a reason would be 2nd Hepatitis B Injection, but we need to keep these
         for re-use for ease of typing.
      : Also God knows where the patient will be in 5 years time, so though we keep a default
        method of contacting them (fk_contact_method), this could change
      : Ditto with staff members, Dr Blogs may have moved on, so if he is recorded as the
        person to see and not present later on, will send appointment for anyone
        Also,may not be important who patient sees eg, bloods taken by the practice nurse
        so fk_staff could point to a generic staff member eg generic_nurse (FIXME NOT IMPLEMENTED)
      : note most foreign keys will have equivalents in module gvar
';


--
-- Name: COLUMN recalls.fk_consult; Type: COMMENT; Schema: clin_recalls; Owner: -
--

COMMENT ON COLUMN recalls.fk_consult IS 'key to clin_consult.consult table hence gives staff member, patient and date consult';


--
-- Name: COLUMN recalls.due; Type: COMMENT; Schema: clin_recalls; Owner: -
--

COMMENT ON COLUMN recalls.due IS 'date recall falls due';


--
-- Name: COLUMN recalls.fk_reason; Type: COMMENT; Schema: clin_recalls; Owner: -
--

COMMENT ON COLUMN recalls.fk_reason IS ' key to clin_recalls.lu.reasons tablet';


--
-- Name: COLUMN recalls.fk_contact_method; Type: COMMENT; Schema: clin_recalls; Owner: -
--

COMMENT ON COLUMN recalls.fk_contact_method IS 'key to contacts.lu_contact_method table';


--
-- Name: COLUMN recalls.fk_urgency; Type: COMMENT; Schema: clin_recalls; Owner: -
--

COMMENT ON COLUMN recalls.fk_urgency IS 'key to common.lu_urgency table eg 1 = routine
	 gvar.RecallUrgencyLevelRoutine';


--
-- Name: COLUMN recalls.fk_appointment_length; Type: COMMENT; Schema: clin_recalls; Owner: -
--

COMMENT ON COLUMN recalls.fk_appointment_length IS 'key to common.lu_appointment_length';


--
-- Name: COLUMN recalls.fk_staff; Type: COMMENT; Schema: clin_recalls; Owner: -
--

COMMENT ON COLUMN recalls.fk_staff IS 'key to clerical.staff table';


--
-- Name: COLUMN recalls.fk_status; Type: COMMENT; Schema: clin_recalls; Owner: -
--

COMMENT ON COLUMN recalls.fk_status IS 'key to lu_status table, ie things like not due, finalised, refused
     corresponds to e.g gvar.RecallNotDue constants
     this defaults to 1 = not due';


--
-- Name: COLUMN recalls.additional_text; Type: COMMENT; Schema: clin_recalls; Owner: -
--

COMMENT ON COLUMN recalls.additional_text IS 'Any additional text to accompany the letter
	 e.g  come fasting or bring your partner etc';


--
-- Name: COLUMN recalls.fk_progressnote; Type: COMMENT; Schema: clin_recalls; Owner: -
--

COMMENT ON COLUMN recalls.fk_progressnote IS 'the foreign key to clin_consult.progressnotes, kept so that if the recall is
 edited, then the progress note is modified with the edited value for the current consultation';


--
-- Name: COLUMN recalls.fk_pasthistory; Type: COMMENT; Schema: clin_recalls; Owner: -
--

COMMENT ON COLUMN recalls.fk_pasthistory IS 'if not null it is the health issue linked to this recall foreign key to clin_history.past_history';


--
-- Name: recalls_pk_seq; Type: SEQUENCE; Schema: clin_recalls; Owner: -
--

CREATE SEQUENCE recalls_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: recalls_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_recalls; Owner: -
--

ALTER SEQUENCE recalls_pk_seq OWNED BY recalls.pk;


--
-- Name: sent; Type: TABLE; Schema: clin_recalls; Owner: -; Tablespace: 
--

CREATE TABLE sent (
    pk integer NOT NULL,
    fk_recall integer NOT NULL,
    date date NOT NULL,
    reminder_text text NOT NULL,
    fk_contact_method integer NOT NULL,
    fk_address text,
    contact_value text,
    fk_staff integer,
    memo text
);


--
-- Name: TABLE sent; Type: COMMENT; Schema: clin_recalls; Owner: -
--

COMMENT ON TABLE sent IS 'Details of recalls sent out to remind the patient';


--
-- Name: COLUMN sent.fk_recall; Type: COMMENT; Schema: clin_recalls; Owner: -
--

COMMENT ON COLUMN sent.fk_recall IS 'key to clin_recalls.recall table';


--
-- Name: COLUMN sent.date; Type: COMMENT; Schema: clin_recalls; Owner: -
--

COMMENT ON COLUMN sent.date IS 'the date the reminder for the recall was processed';


--
-- Name: COLUMN sent.reminder_text; Type: COMMENT; Schema: clin_recalls; Owner: -
--

COMMENT ON COLUMN sent.reminder_text IS 'the actual html text constructed and sent by whatever method';


--
-- Name: COLUMN sent.fk_contact_method; Type: COMMENT; Schema: clin_recalls; Owner: -
--

COMMENT ON COLUMN sent.fk_contact_method IS 'key to contacts.lu_contact_type table e.g could point to letter/phone';


--
-- Name: COLUMN sent.fk_address; Type: COMMENT; Schema: clin_recalls; Owner: -
--

COMMENT ON COLUMN sent.fk_address IS 'if not null letter posted or delivered to this address';


--
-- Name: COLUMN sent.contact_value; Type: COMMENT; Schema: clin_recalls; Owner: -
--

COMMENT ON COLUMN sent.contact_value IS 'if not null contact via this text eg mobile phone, voip, email';


--
-- Name: COLUMN sent.fk_staff; Type: COMMENT; Schema: clin_recalls; Owner: -
--

COMMENT ON COLUMN sent.fk_staff IS 'key to admin.staff table staff member who prepared the letter';


--
-- Name: COLUMN sent.memo; Type: COMMENT; Schema: clin_recalls; Owner: -
--

COMMENT ON COLUMN sent.memo IS 'memo added by staff at the time e.g could have called patient who said they would make appointment';


--
-- Name: sent_pk_seq; Type: SEQUENCE; Schema: clin_recalls; Owner: -
--

CREATE SEQUENCE sent_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: sent_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_recalls; Owner: -
--

ALTER SEQUENCE sent_pk_seq OWNED BY sent.pk;


--
-- Name: vwreasons; Type: VIEW; Schema: clin_recalls; Owner: -
--

CREATE VIEW vwreasons AS
    SELECT lu_reasons.pk AS pk_reason, lu_reasons.reason, lu_recall_intervals.fk_staff, lu_recall_intervals.pk AS fk_lu_recall_intervals, lu_recall_intervals."interval", lu_units.abbrev_text, lu_units.full_text, lu_recall_intervals.fk_interval_unit FROM ((lu_recall_intervals JOIN common.lu_units ON ((lu_recall_intervals.fk_interval_unit = lu_units.pk))) JOIN lu_reasons ON ((lu_recall_intervals.fk_reason = lu_reasons.pk))) ORDER BY lu_reasons.reason;


SET search_path = common, pg_catalog;

--
-- Name: lu_appointment_length_pk_seq; Type: SEQUENCE; Schema: common; Owner: -
--

CREATE SEQUENCE lu_appointment_length_pk_seq
    START WITH 0
    INCREMENT BY 1
    MAXVALUE 100
    MINVALUE 0
    CACHE 1;


--
-- Name: lu_appointment_length; Type: TABLE; Schema: common; Owner: -; Tablespace: 
--

CREATE TABLE lu_appointment_length (
    pk integer DEFAULT nextval('lu_appointment_length_pk_seq'::regclass) NOT NULL,
    length text NOT NULL
);


SET search_path = contacts, pg_catalog;

--
-- Name: lu_contact_type; Type: TABLE; Schema: contacts; Owner: -; Tablespace: 
--

CREATE TABLE lu_contact_type (
    pk integer NOT NULL,
    type text
);


SET search_path = clin_recalls, pg_catalog;

--
-- Name: vwrecalls; Type: VIEW; Schema: clin_recalls; Owner: -
--

CREATE VIEW vwrecalls AS
    SELECT consult.fk_patient, consult.consult_date, lu_reasons.reason, recalls.due, lu_urgency.urgency, lu_contact_type.type AS contact_by, lu_appointment_length.length, lu_title.title, ((data_persons.firstname || ' '::text) || data_persons.surname) AS wholename, recalls.fk_consult, recalls.pk AS pk_recall, recalls.fk_reason, recalls.fk_contact_method, recalls.fk_urgency, recalls.fk_appointment_length, recalls.fk_staff, recalls.fk_status, recalls."interval", lu_units.abbrev_text, recalls.fk_interval_unit, recalls.additional_text, recalls.deleted, recalls.fk_pasthistory, recalls.fk_progressnote, data_persons.firstname, data_persons.surname, data_persons.fk_title, lu_contact_type.pk AS fk_contact_by, lu_status.status, lu_recall_intervals."interval" AS default_interval, lu_recall_intervals.fk_interval_unit AS fk_default_interval_unit FROM (((((((((((recalls JOIN lu_recall_intervals ON ((recalls.fk_reason = lu_recall_intervals.fk_reason))) JOIN clin_consult.consult ON ((recalls.fk_consult = consult.pk))) JOIN lu_reasons ON ((recalls.fk_reason = lu_reasons.pk))) JOIN contacts.lu_contact_type ON ((recalls.fk_contact_method = lu_contact_type.pk))) JOIN admin.staff ON ((consult.fk_staff = staff.pk))) LEFT JOIN contacts.data_persons ON ((staff.fk_person = data_persons.pk))) LEFT JOIN contacts.lu_title ON ((data_persons.fk_title = lu_title.pk))) JOIN common.lu_urgency ON ((recalls.fk_urgency = lu_urgency.pk))) JOIN common.lu_appointment_length ON ((recalls.fk_appointment_length = lu_appointment_length.pk))) LEFT JOIN common.lu_units ON ((recalls.fk_interval_unit = lu_units.pk))) JOIN lu_status ON ((recalls.fk_status = lu_status.pk))) WHERE (recalls.deleted = false) ORDER BY consult.fk_patient, recalls.due;


--
-- Name: vwrecallsaudit; Type: VIEW; Schema: clin_recalls; Owner: -
--

CREATE VIEW vwrecallsaudit AS
    SELECT vwaudit.pk_view, vwaudit.fk_patient, vwaudit.date_audit, vwaudit.data_summary, vwaudit.audit_trail_reason, vwaudit.altered_by_title, vwaudit.altered_by_name, vwaudit.schema, vwaudit.fk_schema, vwaudit.tablename, vwaudit.fk_table, vwaudit.fk_row, vwaudit.fk_consult, vwaudit.fk_lu_reason, vwaudit.action, vwaudit.fk_action, vwaudit.fk_section, vwaudit.section, recalls.fk_reason AS fk_reason_recall FROM (audit.vwaudit JOIN recalls ON ((vwaudit.fk_row = recalls.pk))) WHERE ((vwaudit.schema = 'clin_recalls'::text) AND (vwaudit.tablename = 'recalls'::text)) ORDER BY vwaudit.fk_patient, vwaudit.fk_row, vwaudit.date_audit;


SET search_path = clin_referrals, pg_catalog;

--
-- Name: inbox; Type: TABLE; Schema: clin_referrals; Owner: -; Tablespace: 
--

CREATE TABLE inbox (
    pk integer NOT NULL,
    fk_patient integer NOT NULL,
    fk_organisation integer,
    fk_employee integer,
    fk_person integer,
    date date,
    fk_health_issue integer,
    tag text NOT NULL,
    html text NOT NULL
);


--
-- Name: TABLE inbox; Type: COMMENT; Schema: clin_referrals; Owner: -
--

COMMENT ON TABLE inbox IS 'This table contains all hl7 correspondace which
  is not the result of a request from the user
  e.g letters from after hours, letters from specialists
  where possible the user should link a specialists letter
  to an existing health issue, or code the incoming letter
  to a diagnosis
  fk_patient  = key to clerical.data_patients table
  fk_branch   = key to contacts.data_branches table
	- if not null = branch and hence provider
  fk_employee  = key to contacts.data_employee table
	- if not null the sender is employed by the 
	  branch 
  fk_person  = key to data_persons table
	- if not null the send is a person with no company
  date       = date of the correspondance
  fk_health_issue  key to clin_history.data_past history table
  tag = a description of the correspondance, could be
	either free text or clin_history.description
  html text NOT NULL is the html of the actual letter
  
  ';


--
-- Name: inbox_pk_seq; Type: SEQUENCE; Schema: clin_referrals; Owner: -
--

CREATE SEQUENCE inbox_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: inbox_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_referrals; Owner: -
--

ALTER SEQUENCE inbox_pk_seq OWNED BY inbox.pk;


--
-- Name: link_referral_condition; Type: TABLE; Schema: clin_referrals; Owner: -; Tablespace: 
--

CREATE TABLE link_referral_condition (
    pk integer NOT NULL,
    fk_past_history integer NOT NULL,
    fk_referral integer NOT NULL
);


--
-- Name: TABLE link_referral_condition; Type: COMMENT; Schema: clin_referrals; Owner: -
--

COMMENT ON TABLE link_referral_condition IS 'links a referral to a patients condition e.g if the referral was about diabetes, pk_condition would be diabetes';


--
-- Name: COLUMN link_referral_condition.fk_past_history; Type: COMMENT; Schema: clin_referrals; Owner: -
--

COMMENT ON COLUMN link_referral_condition.fk_past_history IS 'key to the main clin_history.data_past_history table which  condition information about the linked condition';


--
-- Name: COLUMN link_referral_condition.fk_referral; Type: COMMENT; Schema: clin_referrals; Owner: -
--

COMMENT ON COLUMN link_referral_condition.fk_referral IS 'key to clin_referrals_referral table';


--
-- Name: link_referral_condition_pk_seq; Type: SEQUENCE; Schema: clin_referrals; Owner: -
--

CREATE SEQUENCE link_referral_condition_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: link_referral_condition_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_referrals; Owner: -
--

ALTER SEQUENCE link_referral_condition_pk_seq OWNED BY link_referral_condition.pk;


--
-- Name: lu_type; Type: TABLE; Schema: clin_referrals; Owner: -; Tablespace: 
--

CREATE TABLE lu_type (
    pk integer NOT NULL,
    type text NOT NULL
);


--
-- Name: TABLE lu_type; Type: COMMENT; Schema: clin_referrals; Owner: -
--

COMMENT ON TABLE lu_type IS 'List of types of referral eg required by medicare so could be
opinion
ongoing management
indefinate referral etc';


--
-- Name: lu_type_pk_seq; Type: SEQUENCE; Schema: clin_referrals; Owner: -
--

CREATE SEQUENCE lu_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_referrals; Owner: -
--

ALTER SEQUENCE lu_type_pk_seq OWNED BY lu_type.pk;


--
-- Name: referrals; Type: TABLE; Schema: clin_referrals; Owner: -; Tablespace: 
--

CREATE TABLE referrals (
    pk integer NOT NULL,
    fk_consult integer NOT NULL,
    fk_person integer,
    fk_branch integer,
    fk_type integer,
    letter_html text NOT NULL,
    tag text,
    deleted boolean DEFAULT false,
    body_html text,
    fk_pasthistory integer DEFAULT 0,
    fk_progressnote integer,
    include_careplan boolean DEFAULT false,
    include_healthsummary boolean DEFAULT false
);


--
-- Name: TABLE referrals; Type: COMMENT; Schema: clin_referrals; Owner: -
--

COMMENT ON TABLE referrals IS 'data of all referrals. Note that I kept all my referral as shredded down rich text files outside of the database so this table will probably change.';


--
-- Name: COLUMN referrals.fk_consult; Type: COMMENT; Schema: clin_referrals; Owner: -
--

COMMENT ON COLUMN referrals.fk_consult IS 'key to the main clin_consult.consult table which is the master table of the database';


--
-- Name: COLUMN referrals.fk_person; Type: COMMENT; Schema: clin_referrals; Owner: -
--

COMMENT ON COLUMN referrals.fk_person IS 'if not null key to contacts.data_persons table ie person referred to';


--
-- Name: COLUMN referrals.fk_branch; Type: COMMENT; Schema: clin_referrals; Owner: -
--

COMMENT ON COLUMN referrals.fk_branch IS 'key to contacts.data_branches table ie branch of organisation ';


--
-- Name: COLUMN referrals.fk_type; Type: COMMENT; Schema: clin_referrals; Owner: -
--

COMMENT ON COLUMN referrals.fk_type IS 'key to lu_referral_type table ie type of referral e.g opinion or management';


--
-- Name: COLUMN referrals.letter_html; Type: COMMENT; Schema: clin_referrals; Owner: -
--

COMMENT ON COLUMN referrals.letter_html IS 'html which is the letter itself';


--
-- Name: COLUMN referrals.tag; Type: COMMENT; Schema: clin_referrals; Owner: -
--

COMMENT ON COLUMN referrals.tag IS 'A description of the letter eg ''heart failure''';


--
-- Name: COLUMN referrals.body_html; Type: COMMENT; Schema: clin_referrals; Owner: -
--

COMMENT ON COLUMN referrals.body_html IS 'Contains the html of the body of the letter';


--
-- Name: COLUMN referrals.fk_pasthistory; Type: COMMENT; Schema: clin_referrals; Owner: -
--

COMMENT ON COLUMN referrals.fk_pasthistory IS 'if not 0 = general notes, then is the key to clin_history.past_history table';


--
-- Name: COLUMN referrals.fk_progressnote; Type: COMMENT; Schema: clin_referrals; Owner: -
--

COMMENT ON COLUMN referrals.fk_progressnote IS 'key to clin_consult.progress notes table - points to the progress note of a letter during the
 consultation it was written in - used for editing/auditing';


--
-- Name: referrals_pk_seq; Type: SEQUENCE; Schema: clin_referrals; Owner: -
--

CREATE SEQUENCE referrals_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: referrals_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_referrals; Owner: -
--

ALTER SEQUENCE referrals_pk_seq OWNED BY referrals.pk;


--
-- Name: vwreferrals; Type: VIEW; Schema: clin_referrals; Owner: -
--

CREATE VIEW vwreferrals AS
    SELECT referrals.pk AS pk_referral, referrals.fk_consult, referrals.fk_person, referrals.fk_branch, referrals.fk_type, referrals.letter_html, referrals.tag, referrals.deleted, referrals.body_html, referrals.include_healthsummary, referrals.include_careplan, consult.consult_date AS date, consult.fk_patient, consult.fk_staff, data_persons.firstname AS provider_firstname, data_persons.surname AS provider_surname, lu_title.title AS provider_title, data_branches.branch, data_organisations.organisation, lu_type.type, lu_categories.category, data_addresses.street, lu_towns.postcode, lu_towns.town, data_branches.fk_organisation, referrals.fk_pasthistory, referrals.fk_progressnote FROM (((((((((referrals JOIN clin_consult.consult ON ((referrals.fk_consult = consult.pk))) LEFT JOIN contacts.data_persons ON ((referrals.fk_person = data_persons.pk))) LEFT JOIN contacts.lu_title ON ((data_persons.fk_title = lu_title.pk))) LEFT JOIN contacts.data_branches ON ((referrals.fk_branch = data_branches.pk))) LEFT JOIN contacts.data_organisations ON ((data_branches.fk_organisation = data_organisations.pk))) JOIN lu_type ON ((referrals.fk_type = lu_type.pk))) JOIN contacts.lu_categories ON ((data_branches.fk_category = lu_categories.pk))) LEFT JOIN contacts.data_addresses ON ((data_branches.fk_address = data_addresses.pk))) LEFT JOIN contacts.lu_towns ON ((data_addresses.fk_town = lu_towns.pk))) WHERE (referrals.deleted = false) ORDER BY consult.fk_patient DESC;


--
-- Name: vwreferralsinbox; Type: VIEW; Schema: clin_referrals; Owner: -
--

CREATE VIEW vwreferralsinbox AS
    SELECT inbox.pk, inbox.fk_patient, inbox.fk_organisation, inbox.fk_employee, inbox.fk_person, inbox.date, inbox.fk_health_issue, inbox.tag, inbox.html, data_organisations.organisation, data_persons.firstname AS employee_firstname, data_persons.surname AS employee_surname, lu_title.title AS employee_title, lu_title1.title, data_persons1.firstname, data_persons1.surname FROM (((((((inbox LEFT JOIN clin_history.past_history ON ((inbox.fk_health_issue = past_history.pk))) LEFT JOIN contacts.data_organisations ON ((inbox.fk_organisation = data_organisations.pk))) LEFT JOIN contacts.data_employees ON ((inbox.fk_employee = data_employees.pk))) LEFT JOIN contacts.data_persons ON ((data_employees.fk_person = data_persons.pk))) LEFT JOIN contacts.lu_title ON ((data_persons.fk_title = lu_title.pk))) LEFT JOIN contacts.data_persons data_persons1 ON ((inbox.fk_person = data_persons1.pk))) LEFT JOIN contacts.lu_title lu_title1 ON ((data_persons1.fk_title = lu_title1.pk))) ORDER BY inbox.fk_patient;


SET search_path = clin_requests, pg_catalog;

--
-- Name: forms_pk_seq; Type: SEQUENCE; Schema: clin_requests; Owner: -
--

CREATE SEQUENCE forms_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: forms_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_requests; Owner: -
--

ALTER SEQUENCE forms_pk_seq OWNED BY forms.pk;


--
-- Name: forms_requests; Type: TABLE; Schema: clin_requests; Owner: -; Tablespace: 
--

CREATE TABLE forms_requests (
    pk integer NOT NULL,
    fk_form integer,
    fk_lu_request integer NOT NULL,
    deleted boolean DEFAULT false,
    request_result_html text
);


--
-- Name: TABLE forms_requests; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON TABLE forms_requests IS 'This table links a form to the name of requests on that form
  i.e there is a one to many relationship to a form
  when a form ie created/saved, then an entry in this table
  is created, but there is no OBR (returned result segment in hl7)
  and no html text to summarise the result of the request';


--
-- Name: COLUMN forms_requests.pk; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON COLUMN forms_requests.pk IS 'key to forms_requests table, ie points to pk of the orginal request   ';


--
-- Name: COLUMN forms_requests.fk_form; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON COLUMN forms_requests.fk_form IS ' points to form the request was on  ';


--
-- Name: COLUMN forms_requests.fk_lu_request; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON COLUMN forms_requests.fk_lu_request IS ' foreign key points to the actual request name eg ''FBC  ';


--
-- Name: COLUMN forms_requests.deleted; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON COLUMN forms_requests.deleted IS ' If false the form has been delted  ';


--
-- Name: COLUMN forms_requests.request_result_html; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON COLUMN forms_requests.request_result_html IS ' the entire html of a single result   ';


--
-- Name: forms_requests_pk_seq; Type: SEQUENCE; Schema: clin_requests; Owner: -
--

CREATE SEQUENCE forms_requests_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: forms_requests_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_requests; Owner: -
--

ALTER SEQUENCE forms_requests_pk_seq OWNED BY forms_requests.pk;


--
-- Name: inbox_oru_unresolved_temp_patient_id_seq; Type: SEQUENCE; Schema: clin_requests; Owner: -
--

CREATE SEQUENCE inbox_oru_unresolved_temp_patient_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: link_forms_requests_requests_results; Type: TABLE; Schema: clin_requests; Owner: -; Tablespace: 
--

CREATE TABLE link_forms_requests_requests_results (
    pk integer NOT NULL,
    fk_forms_requests integer,
    requests_results_episode_key integer
);


--
-- Name: link_forms_requests_requests_results_pk_seq; Type: SEQUENCE; Schema: clin_requests; Owner: -
--

CREATE SEQUENCE link_forms_requests_requests_results_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: link_forms_requests_requests_results_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_requests; Owner: -
--

ALTER SEQUENCE link_forms_requests_requests_results_pk_seq OWNED BY link_forms_requests_requests_results.pk;


--
-- Name: lu_copyto_type; Type: TABLE; Schema: clin_requests; Owner: -; Tablespace: 
--

CREATE TABLE lu_copyto_type (
    pk integer NOT NULL,
    type text NOT NULL
);


--
-- Name: TABLE lu_copyto_type; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON TABLE lu_copyto_type IS 'The type of contact that is being sent a copy of
  the request eg person or organisation/branch';


--
-- Name: lu_copyto_type_pk_seq; Type: SEQUENCE; Schema: clin_requests; Owner: -
--

CREATE SEQUENCE lu_copyto_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_copyto_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_requests; Owner: -
--

ALTER SEQUENCE lu_copyto_type_pk_seq OWNED BY lu_copyto_type.pk;


--
-- Name: lu_form_header; Type: TABLE; Schema: clin_requests; Owner: -; Tablespace: 
--

CREATE TABLE lu_form_header (
    pk integer NOT NULL,
    fk_branch integer NOT NULL,
    header text,
    general_text text
);


--
-- Name: TABLE lu_form_header; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON TABLE lu_form_header IS 'Provider specific text to be shown on a request form
 e.g For a pathology report could be specific details
 they have on their forms, A.C.N - Australian company number - etc';


--
-- Name: COLUMN lu_form_header.fk_branch; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON COLUMN lu_form_header.fk_branch IS 'primary key to contacts.branches table. This will usually be the head office';


--
-- Name: COLUMN lu_form_header.header; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON COLUMN lu_form_header.header IS 'HTML text as described above';


--
-- Name: COLUMN lu_form_header.general_text; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON COLUMN lu_form_header.general_text IS 'Some general text such as this, from one pathology company:
<B>Privacy Note:</B>The information provided by you on this form will be used to assess 
the benefit payable for the service(s) rendered. Its collection is authorised by 
law and may be disclosed to the Department of Health and Family Services, 
to the person who has claimed benefit for the service or to that person''s nominee. 
Information concerning your eligibility under the scheme may be advised to a person
who may or who has made a claim under the scheme.';


--
-- Name: lu_form_header_pk_seq; Type: SEQUENCE; Schema: clin_requests; Owner: -
--

CREATE SEQUENCE lu_form_header_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_form_header_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_requests; Owner: -
--

ALTER SEQUENCE lu_form_header_pk_seq OWNED BY lu_form_header.pk;


--
-- Name: lu_instructions; Type: TABLE; Schema: clin_requests; Owner: -; Tablespace: 
--

CREATE TABLE lu_instructions (
    pk integer NOT NULL,
    instruction text NOT NULL
);


--
-- Name: TABLE lu_instructions; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON TABLE lu_instructions IS 'Table containing instructions which can be linked to a particular tests to be printed out on the request form';


--
-- Name: COLUMN lu_instructions.instruction; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON COLUMN lu_instructions.instruction IS 'Instructions for a given test, for e.g for an cardiac.holter monitor:
<P>You will be wearing a small box around your waist for 24 hours. 
You will not be able to shower or get wet in any way whilst the test is in progress. 
The clothing you wear is important.<P>
<B>LADIES</B> please bring or wear a 2 piece outfit such as a loose blouse that buttons
 through the front and skirt or slacks. One piece undergarments (bodysuits/long-line bras)
  are not suitable.
  <B>MEN</B> Please bring or wear a button through the front shirt and shorts or trousers. 
  Please do not wear a singlet.';


--
-- Name: lu_instructions_pk_seq; Type: SEQUENCE; Schema: clin_requests; Owner: -
--

CREATE SEQUENCE lu_instructions_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_instructions_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_requests; Owner: -
--

ALTER SEQUENCE lu_instructions_pk_seq OWNED BY lu_instructions.pk;


--
-- Name: lu_link_provider_user_requests; Type: TABLE; Schema: clin_requests; Owner: -; Tablespace: 
--

CREATE TABLE lu_link_provider_user_requests (
    pk integer NOT NULL,
    fk_lu_request integer NOT NULL,
    provider_request_name text NOT NULL,
    lateralisation integer DEFAULT 0
);


--
-- Name: lu_link_provider_user_requests_pk_seq; Type: SEQUENCE; Schema: clin_requests; Owner: -
--

CREATE SEQUENCE lu_link_provider_user_requests_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_link_provider_user_requests_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_requests; Owner: -
--

ALTER SEQUENCE lu_link_provider_user_requests_pk_seq OWNED BY lu_link_provider_user_requests.pk;


--
-- Name: lu_request_type; Type: TABLE; Schema: clin_requests; Owner: -; Tablespace: 
--

CREATE TABLE lu_request_type (
    pk integer NOT NULL,
    type text NOT NULL
);


--
-- Name: TABLE lu_request_type; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON TABLE lu_request_type IS 'Table containing list of types of requests eg radiology';


--
-- Name: COLUMN lu_request_type.type; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON COLUMN lu_request_type.type IS 'the type of request e.g radiology, pathology, cardiovascular etc.';


--
-- Name: lu_request_type_pk_seq; Type: SEQUENCE; Schema: clin_requests; Owner: -
--

CREATE SEQUENCE lu_request_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_request_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_requests; Owner: -
--

ALTER SEQUENCE lu_request_type_pk_seq OWNED BY lu_request_type.pk;


--
-- Name: lu_requests; Type: TABLE; Schema: clin_requests; Owner: -; Tablespace: 
--

CREATE TABLE lu_requests (
    pk integer NOT NULL,
    fk_type integer NOT NULL,
    item text NOT NULL,
    fk_laterality integer DEFAULT 0,
    fk_decision_support integer DEFAULT 0,
    fk_instruction integer DEFAULT 0,
    deleted boolean DEFAULT false
);


--
-- Name: TABLE lu_requests; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON TABLE lu_requests IS 'Table containing all possible request items for eg pathology, radiology etc e.g CXR, Ultasound of gall bladder, Bone mineral Density, or physio e.g physio at discretion or back physio';


--
-- Name: COLUMN lu_requests.fk_type; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON COLUMN lu_requests.fk_type IS ' foreign key to clin_requests.lu_request_type table';


--
-- Name: COLUMN lu_requests.item; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON COLUMN lu_requests.item IS 'the actual request eg Xray of wrist';


--
-- Name: COLUMN lu_requests.fk_laterality; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON COLUMN lu_requests.fk_laterality IS 'foreign key to common.lu_laterality, ie left/right/both';


--
-- Name: COLUMN lu_requests.fk_decision_support; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON COLUMN lu_requests.fk_decision_support IS 'foreign key to decision_support.decision_support table neither of which exist yet';


--
-- Name: COLUMN lu_requests.fk_instruction; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON COLUMN lu_requests.fk_instruction IS 'foreign key to lu_instructions ie patient instructions for a particular test';


--
-- Name: lu_requests_pk_seq; Type: SEQUENCE; Schema: clin_requests; Owner: -
--

CREATE SEQUENCE lu_requests_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_requests_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_requests; Owner: -
--

ALTER SEQUENCE lu_requests_pk_seq OWNED BY lu_requests.pk;


--
-- Name: lu_type; Type: TABLE; Schema: clin_requests; Owner: -; Tablespace: 
--

CREATE TABLE lu_type (
    pk integer NOT NULL,
    type text NOT NULL,
    memo text
);


--
-- Name: TABLE lu_type; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON TABLE lu_type IS 'Table containing list of types of requests eg radiology';


--
-- Name: COLUMN lu_type.type; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON COLUMN lu_type.type IS 'the type of request e.g radiology, pathology, physiotherapy, cardiovascular etc.';


--
-- Name: lu_type_pk_seq; Type: SEQUENCE; Schema: clin_requests; Owner: -
--

CREATE SEQUENCE lu_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_requests; Owner: -
--

ALTER SEQUENCE lu_type_pk_seq OWNED BY lu_type.pk;


--
-- Name: notes; Type: TABLE; Schema: clin_requests; Owner: -; Tablespace: 
--

CREATE TABLE notes (
    pk integer NOT NULL,
    note text,
    fk_lu_type integer,
    fk_staff integer NOT NULL
);


--
-- Name: TABLE notes; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON TABLE notes IS 'This table may be moved. The principal is that it saves the user
typing, by saving short notes which the user colon delimited during
data entry whilst creating request forms
e.g tiredness;weight loss;increased breathlessness;';


--
-- Name: COLUMN notes.fk_lu_type; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON COLUMN notes.fk_lu_type IS 'key to lu_type table, ie pathology/radiology/physiotherapy etc';


--
-- Name: notes_pk_seq; Type: SEQUENCE; Schema: clin_requests; Owner: -
--

CREATE SEQUENCE notes_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: notes_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_requests; Owner: -
--

ALTER SEQUENCE notes_pk_seq OWNED BY notes.pk;


--
-- Name: request_providers; Type: TABLE; Schema: clin_requests; Owner: -; Tablespace: 
--

CREATE TABLE request_providers (
    pk integer NOT NULL,
    fk_branch integer,
    fk_employee integer,
    fk_person integer,
    fk_lu_request_type integer NOT NULL
);


--
-- Name: TABLE request_providers; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON TABLE request_providers IS 'table which points to those persons, organisations or employees in 
  an organisation to whom we can send requests for services. this could
  be a test eg fbc, cxr, or a service like physiotherapy - in which case
  the user is using a request form instead of a letter';


--
-- Name: request_providers_pk_seq; Type: SEQUENCE; Schema: clin_requests; Owner: -
--

CREATE SEQUENCE request_providers_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: request_providers_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_requests; Owner: -
--

ALTER SEQUENCE request_providers_pk_seq OWNED BY request_providers.pk;


--
-- Name: results_requests_episode_key; Type: SEQUENCE; Schema: clin_requests; Owner: -
--

CREATE SEQUENCE results_requests_episode_key
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: SEQUENCE results_requests_episode_key; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON SEQUENCE results_requests_episode_key IS 'First attempt to link multiple lines of this table eg all the
 rows of a FBC to one or more differently named requests';


--
-- Name: user_default_type; Type: TABLE; Schema: clin_requests; Owner: -; Tablespace: 
--

CREATE TABLE user_default_type (
    pk integer NOT NULL,
    fk_staff integer NOT NULL,
    fk_lu_type integer NOT NULL
);


--
-- Name: TABLE user_default_type; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON TABLE user_default_type IS 'the default type of form first presented to the
  user when loads the request form module';


--
-- Name: COLUMN user_default_type.fk_staff; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON COLUMN user_default_type.fk_staff IS 'key to admin.staff table';


--
-- Name: COLUMN user_default_type.fk_lu_type; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON COLUMN user_default_type.fk_lu_type IS 'key to lu_type table ie type of request e.g pathology';


--
-- Name: user_default_type_pk_seq; Type: SEQUENCE; Schema: clin_requests; Owner: -
--

CREATE SEQUENCE user_default_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: user_default_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_requests; Owner: -
--

ALTER SEQUENCE user_default_type_pk_seq OWNED BY user_default_type.pk;


--
-- Name: user_provider_defaults; Type: TABLE; Schema: clin_requests; Owner: -; Tablespace: 
--

CREATE TABLE user_provider_defaults (
    pk integer NOT NULL,
    fk_staff integer NOT NULL,
    fk_default_branch integer NOT NULL,
    fk_head_office_branch integer,
    send_electronically boolean DEFAULT false,
    print_paper boolean DEFAULT true,
    deleted boolean DEFAULT false,
    fk_lu_request_type integer NOT NULL
);


--
-- Name: TABLE user_provider_defaults; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON TABLE user_provider_defaults IS 'Contains defaults for users according to the category of the provider - as that provider has its own category';


--
-- Name: COLUMN user_provider_defaults.fk_staff; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON COLUMN user_provider_defaults.fk_staff IS 'key to admin.staff table ie describes the user';


--
-- Name: COLUMN user_provider_defaults.fk_default_branch; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON COLUMN user_provider_defaults.fk_default_branch IS 'key to contacts.branches table
  this is the branch that the user preferentially sends the
  request to';


--
-- Name: user_provider_defaults_pk_seq; Type: SEQUENCE; Schema: clin_requests; Owner: -
--

CREATE SEQUENCE user_provider_defaults_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: user_provider_defaults_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_requests; Owner: -
--

ALTER SEQUENCE user_provider_defaults_pk_seq OWNED BY user_provider_defaults.pk;


SET search_path = contacts, pg_catalog;

--
-- Name: images; Type: TABLE; Schema: contacts; Owner: -; Tablespace: 
--

CREATE TABLE images (
    pk integer NOT NULL,
    image bytea,
    deleted boolean
);


--
-- Name: vwpersons; Type: VIEW; Schema: contacts; Owner: -
--

CREATE VIEW vwpersons AS
    SELECT data_persons.pk AS fk_person, CASE WHEN ("Addresses".pk > 0) THEN COALESCE(((data_persons.pk || '-'::text) || "Addresses".pk)) ELSE (data_persons.pk || '-0'::text) END AS pk_view, (((lu_title.title || ' '::text) || (data_persons.firstname || ' '::text)) || (data_persons.surname || ' '::text)) AS wholename, data_persons.firstname, data_persons.surname, data_persons.salutation, data_persons.birthdate, data_persons.fk_ethnicity, data_persons.fk_language, data_persons.memo, data_persons.fk_marital, data_persons.fk_title, data_persons.fk_sex, data_persons.fk_image, data_persons.fk_occupation, data_persons.fk_category, data_persons.retired, data_persons.deceased, data_persons.date_deceased, lu_sex.sex, lu_sex.sex_text, lu_title.title, lu_marital.marital, lu_occupations.occupation, lu_languages.language, lu_countries.country, links_persons_addresses.pk AS fk_link_address, links_persons_addresses.fk_address, lu_towns.postcode, lu_towns.town, lu_towns.state, data_persons.country_code, lu_categories.category, "Addresses".street, "Addresses".fk_town, "Addresses".fk_lu_address_type, lu_address_types.type AS address_type, "Addresses".preferred_address, "Addresses".postal_address, "Addresses".head_office, "Addresses".geolocation, "Addresses".deleted AS address_deleted, images.image FROM ((((((((((((data_persons LEFT JOIN lu_sex ON ((data_persons.fk_sex = lu_sex.pk))) LEFT JOIN lu_title ON ((data_persons.fk_title = lu_title.pk))) LEFT JOIN lu_marital ON ((data_persons.fk_marital = lu_marital.pk))) LEFT JOIN common.lu_occupations ON ((data_persons.fk_occupation = lu_occupations.pk))) LEFT JOIN lu_categories ON ((data_persons.fk_category = lu_categories.pk))) LEFT JOIN common.lu_languages ON ((data_persons.fk_language = lu_languages.pk))) LEFT JOIN images ON ((data_persons.fk_image = images.pk))) LEFT JOIN links_persons_addresses ON ((data_persons.pk = links_persons_addresses.fk_person))) LEFT JOIN common.lu_countries ON ((data_persons.country_code = (lu_countries.country_code)::text))) LEFT JOIN data_addresses "Addresses" ON ((links_persons_addresses.fk_address = "Addresses".pk))) LEFT JOIN lu_address_types ON (("Addresses".fk_lu_address_type = lu_address_types.pk))) LEFT JOIN lu_towns ON (("Addresses".fk_town = lu_towns.pk))) ORDER BY data_persons.pk, links_persons_addresses.fk_address;


SET search_path = documents, pg_catalog;

--
-- Name: documents; Type: TABLE; Schema: documents; Owner: -; Tablespace: 
--

CREATE TABLE documents (
    pk integer NOT NULL,
    source_file text,
    fk_sending_entity integer NOT NULL,
    imported_time timestamp without time zone DEFAULT now() NOT NULL,
    date_requested date,
    date_created date,
    fk_patient integer,
    fk_staff_filed_document integer,
    originator text,
    originator_reference text,
    provider_of_service_reference text,
    internal_reference text,
    copies_to text,
    fk_staff_destination integer,
    comment_on_document text,
    patient_access boolean DEFAULT false,
    concluded boolean DEFAULT false,
    deleted boolean DEFAULT false,
    fk_lu_urgency integer,
    tag text,
    md5sum text,
    fk_unmatched_staff integer,
    fk_unmatched_patient integer,
    fk_referral integer,
    fk_request integer,
    html text,
    tag_user text,
    copy_to text,
    staff_intended_for_unknown boolean DEFAULT false,
    fk_lu_display_as integer,
    fk_lu_request_type integer
);


--
-- Name: COLUMN documents.source_file; Type: COMMENT; Schema: documents; Owner: -
--

COMMENT ON COLUMN documents.source_file IS 'the source filename of the document pdf, jpeg etc on the file server, may be 1:1 or the document contents may have been part of a file eg hl7';


--
-- Name: COLUMN documents.date_created; Type: COMMENT; Schema: documents; Owner: -
--

COMMENT ON COLUMN documents.date_created IS 'date the document was created - ie the document was created or  the observation collected e.g blood';


--
-- Name: COLUMN documents.fk_staff_filed_document; Type: COMMENT; Schema: documents; Owner: -
--

COMMENT ON COLUMN documents.fk_staff_filed_document IS 'key to admin.staff table - who filed the document, may be null if auto-filed eg by the hl7 parser';


--
-- Name: COLUMN documents.copies_to; Type: COMMENT; Schema: documents; Owner: -
--

COMMENT ON COLUMN documents.copies_to IS 'Whoever gets a copy of the document - flaw should be keyed for multiple';


--
-- Name: COLUMN documents.fk_staff_destination; Type: COMMENT; Schema: documents; Owner: -
--

COMMENT ON COLUMN documents.fk_staff_destination IS 'if null, then documented sent to everyones inbox';


--
-- Name: COLUMN documents.comment_on_document; Type: COMMENT; Schema: documents; Owner: -
--

COMMENT ON COLUMN documents.comment_on_document IS 'additional comment e.g NAD etc';


--
-- Name: COLUMN documents.fk_referral; Type: COMMENT; Schema: documents; Owner: -
--

COMMENT ON COLUMN documents.fk_referral IS 'If not null, linkt the document e.g incoming letter from specialist to a referral letter written
  to the specialist in the first place. That way, all correspondance for a particular referral
  and health issues (as referrals are linked to health issues) can be shown';


--
-- Name: COLUMN documents.fk_request; Type: COMMENT; Schema: documents; Owner: -
--

COMMENT ON COLUMN documents.fk_request IS 'If not null, links the document e.g incoming result form a path lab
  to a particular request on a particular form. This is the fk to clin_requests.forms_requests table';


--
-- Name: COLUMN documents.html; Type: COMMENT; Schema: documents; Owner: -
--

COMMENT ON COLUMN documents.html IS 'maybe temporary, but as most of the documents are html results, I have included this field';


--
-- Name: COLUMN documents.staff_intended_for_unknown; Type: COMMENT; Schema: documents; Owner: -
--

COMMENT ON COLUMN documents.staff_intended_for_unknown IS 'Sometimes despite all efforts it is not possible to determine from the hl7 who the message was
 intended for. In this situation EasyGP has a default staff member who is allocated the
 orphaned messages. If so, then this field will be true
 If this is sorted out, then this field will be re-set to false the fk_staff_destination set
 to the correct fk_staff, however these changes will be logged';


--
-- Name: COLUMN documents.fk_lu_display_as; Type: COMMENT; Schema: documents; Owner: -
--

COMMENT ON COLUMN documents.fk_lu_display_as IS 'How to display the document 1 as a result 2 as a letter';


--
-- Name: COLUMN documents.fk_lu_request_type; Type: COMMENT; Schema: documents; Owner: -
--

COMMENT ON COLUMN documents.fk_lu_request_type IS ' - key to clin_requests.lu_request_type table which contains the types
    of requests e.g Pathology Radiology Vascular. 
  - note this field over-rides the 
   fk_lu_request_type of a given documents.sending_entities.fk_lu_request_type
   which is there to aid FDocumentMetadata guess the likely type of request for
   a given sender of messages, but may not be correct all the time';


--
-- Name: lu_message_display_style; Type: TABLE; Schema: documents; Owner: -; Tablespace: 
--

CREATE TABLE lu_message_display_style (
    pk integer NOT NULL,
    style text NOT NULL
);


--
-- Name: lu_message_standard; Type: TABLE; Schema: documents; Owner: -; Tablespace: 
--

CREATE TABLE lu_message_standard (
    pk integer NOT NULL,
    type text NOT NULL,
    version text
);


--
-- Name: TABLE lu_message_standard; Type: COMMENT; Schema: documents; Owner: -
--

COMMENT ON TABLE lu_message_standard IS 'hl7 or pit version not yet implemented';


--
-- Name: sending_entities; Type: TABLE; Schema: documents; Owner: -; Tablespace: 
--

CREATE TABLE sending_entities (
    pk integer NOT NULL,
    fk_lu_request_type integer,
    msh_sending_entity text NOT NULL,
    msh_transmitting_entity text,
    fk_lu_message_display_style integer NOT NULL,
    fk_branch integer,
    fk_employee integer,
    fk_person integer,
    fk_lu_message_standard integer NOT NULL,
    exclude_ft_report boolean DEFAULT false,
    exclude_pit boolean DEFAULT false,
    abnormals_foreground_color integer DEFAULT 16711680,
    abnormals_background_color integer DEFAULT 16777215
);


--
-- Name: TABLE sending_entities; Type: COMMENT; Schema: documents; Owner: -
--

COMMENT ON TABLE sending_entities IS 'Sending entities and the parameters to define how to handle incoming hl7 messages 
on a per-provider basis.Note these messages can be in form of various hl7 standards or old style PIT (sequential numbered text lines eg 100, 110 120 etc This table
defines the file type hl7 or pit, who is sending it, where to put it, which segments of the message to exclude when displaying in html';


--
-- Name: COLUMN sending_entities.fk_lu_request_type; Type: COMMENT; Schema: documents; Owner: -
--

COMMENT ON COLUMN sending_entities.fk_lu_request_type IS 'The type of provider eg pathology provider, radiology provider';


--
-- Name: COLUMN sending_entities.msh_sending_entity; Type: COMMENT; Schema: documents; Owner: -
--

COMMENT ON COLUMN sending_entities.msh_sending_entity IS 'the entity sending, could be unintelligable eg a NATA/number or a recognizable name eg Hunter Radiology, however often bears no relationship to a real person or company';


--
-- Name: COLUMN sending_entities.msh_transmitting_entity; Type: COMMENT; Schema: documents; Owner: -
--

COMMENT ON COLUMN sending_entities.msh_transmitting_entity IS 'could be the sending entity or third party transmitter eg Medical Objects, or the name of a computer program generating the hl7';


--
-- Name: COLUMN sending_entities.fk_lu_message_display_style; Type: COMMENT; Schema: documents; Owner: -
--

COMMENT ON COLUMN sending_entities.fk_lu_message_display_style IS 'display as letter or result style';


--
-- Name: COLUMN sending_entities.fk_lu_message_standard; Type: COMMENT; Schema: documents; Owner: -
--

COMMENT ON COLUMN sending_entities.fk_lu_message_standard IS 'hl7 or pit';


--
-- Name: COLUMN sending_entities.exclude_ft_report; Type: COMMENT; Schema: documents; Owner: -
--

COMMENT ON COLUMN sending_entities.exclude_ft_report IS 'if true then no free text segments will be shown';


--
-- Name: COLUMN sending_entities.exclude_pit; Type: COMMENT; Schema: documents; Owner: -
--

COMMENT ON COLUMN sending_entities.exclude_pit IS 'if contains PIT segments if true these will not be shown (often duplicated the hl7 data itself)';


--
-- Name: unmatched_patients; Type: TABLE; Schema: documents; Owner: -; Tablespace: 
--

CREATE TABLE unmatched_patients (
    pk integer NOT NULL,
    surname text NOT NULL,
    firstname text,
    birthdate date,
    sex text,
    title text,
    comment text,
    fk_real_patient integer,
    street text,
    town text,
    postcode text,
    state text
);


--
-- Name: COLUMN unmatched_patients.comment; Type: COMMENT; Schema: documents; Owner: -
--

COMMENT ON COLUMN unmatched_patients.comment IS 'other data about the patient to help matching';


--
-- Name: unmatched_staff; Type: TABLE; Schema: documents; Owner: -; Tablespace: 
--

CREATE TABLE unmatched_staff (
    pk integer NOT NULL,
    surname text NOT NULL,
    firstname text,
    title text,
    provider_number text,
    fk_real_staff integer
);


--
-- Name: vwsendingentities; Type: VIEW; Schema: documents; Owner: -
--

CREATE VIEW vwsendingentities AS
    SELECT sending_entities.pk AS pk_sending_entities, sending_entities.fk_lu_request_type, lu_request_type.type AS request_type, sending_entities.msh_sending_entity, sending_entities.msh_transmitting_entity, sending_entities.fk_lu_message_display_style, sending_entities.fk_branch, sending_entities.fk_employee, sending_entities.fk_person, sending_entities.fk_lu_message_standard, sending_entities.exclude_ft_report, sending_entities.exclude_pit, lu_message_display_style.style, sending_entities.abnormals_foreground_color, sending_entities.abnormals_background_color, lu_message_standard.type AS message_type, lu_message_standard.version AS message_version, vworganisationsemployees.organisation, vworganisationsemployees.branch, vworganisationsemployees.fk_address AS fk_address_organisation, vworganisationsemployees.fk_category AS fk_category_organisation, vworganisationsemployees.category AS organisation_category, vworganisationsemployees.street AS organisation_street, vworganisationsemployees.fk_town AS fk_town_organisation, vworganisationsemployees.postal_address AS organisation_postal_address, vworganisationsemployees.head_office AS organisation_head_office, vworganisationsemployees.postcode AS organisation_postcode, vworganisationsemployees.town AS organisation_town, vworganisationsemployees.state AS organisation_state, vworganisationsemployees.fk_organisation, vwpersons.firstname, vwpersons.surname, vwpersons.fk_title, vwpersons.fk_sex, vwpersons.fk_occupation, vwpersons.fk_category AS fk_category_person, vwpersons.category AS person_category, vwpersons.occupation AS person_occupation, vwpersons.fk_address AS fk_address_person, vwpersons.postcode AS person_postcode, vwpersons.town AS person_town, vwpersons.state AS person_state, vwpersons.street AS person_street, vwpersons.fk_town AS fk_town_person FROM (((((sending_entities LEFT JOIN clin_requests.lu_request_type ON ((sending_entities.fk_lu_request_type = lu_request_type.pk))) JOIN lu_message_display_style ON ((sending_entities.fk_lu_message_display_style = lu_message_display_style.pk))) JOIN lu_message_standard ON ((sending_entities.fk_lu_message_standard = lu_message_standard.pk))) LEFT JOIN contacts.vworganisationsemployees ON ((sending_entities.fk_branch = vworganisationsemployees.fk_branch))) LEFT JOIN contacts.vwpersons ON ((sending_entities.fk_person = vwpersons.fk_person))) ORDER BY sending_entities.msh_sending_entity;


--
-- Name: VIEW vwsendingentities; Type: COMMENT; Schema: documents; Owner: -
--

COMMENT ON VIEW vwsendingentities IS 'View of the sending entities note:
  -  LEFT JOIN contacts.lu_categories as when a file is parsed fk_lu_provider type cannot exist
  -  ditto for the sending organisation, employee or person
  -  not employee not implemented';


--
-- Name: vwdocuments; Type: VIEW; Schema: documents; Owner: -
--

CREATE VIEW vwdocuments AS
    SELECT documents.pk AS pk_document, documents.source_file, documents.fk_sending_entity, documents.imported_time, documents.date_requested, documents.date_created, documents.fk_patient, documents.fk_staff_filed_document, documents.originator, documents.originator_reference, documents.copy_to, documents.provider_of_service_reference, documents.internal_reference, documents.copies_to, documents.fk_staff_destination, documents.comment_on_document, documents.patient_access, documents.concluded, documents.deleted, documents.fk_lu_urgency, documents.tag, documents.tag_user, documents.md5sum, documents.html, documents.fk_unmatched_staff, documents.fk_referral, documents.fk_request, documents.fk_unmatched_patient, documents.fk_lu_display_as, documents.fk_lu_request_type, lu_request_type.type AS request_type, vwsendingentities.fk_lu_request_type AS sending_entity_fk_lu_request_type, vwsendingentities.request_type AS sending_entity_request_type, vwsendingentities.style, vwsendingentities.message_type, vwsendingentities.message_version, vwsendingentities.msh_sending_entity, vwsendingentities.msh_transmitting_entity, vwsendingentities.fk_lu_message_display_style, vwsendingentities.fk_branch AS fk_sender_branch, vwsendingentities.fk_employee AS fk_employee_branch, vwsendingentities.fk_person AS fk_sender_person, vwsendingentities.fk_lu_message_standard, vwsendingentities.exclude_ft_report, vwsendingentities.abnormals_foreground_color, vwsendingentities.abnormals_background_color, vwsendingentities.exclude_pit, vwsendingentities.organisation_category, vwsendingentities.person_category, vwpatients.fk_person AS patient_fk_person, vwpatients.firstname AS patient_firstname, vwpatients.surname AS patient_surname, vwpatients.birthdate AS patient_birthdate, vwpatients.sex AS patient_sex, vwpatients.age AS patient_age, vwpatients.title AS patient_title, vwpatients.street AS patient_street, vwpatients.town AS patient_town, vwpatients.state AS patient_state, vwpatients.postcode AS patient_postcode, vwstaff.wholename AS staff_destination_wholename, vwstaff.title AS staff_destination_title, unmatched_patients.surname AS unmatched_patient_surname, unmatched_patients.firstname AS unmatched_patient_firstname, unmatched_patients.birthdate AS unmatched_patient_birthdate, unmatched_patients.sex AS unmatched_patient_sex, unmatched_patients.title AS unmatched_patient_title, unmatched_patients.street AS unmatched_patient_street, unmatched_patients.town AS unmatched_patient_town, unmatched_patients.postcode AS unmatched_patient_postcode, unmatched_patients.state AS unmatched_patient_state, unmatched_staff.surname AS unmatched_staff_surname, unmatched_staff.firstname AS unmatched_staff_firstname, unmatched_staff.title AS unmatched_staff_title, unmatched_staff.provider_number AS unmatched_staff_provider_number FROM ((((((documents JOIN vwsendingentities ON ((documents.fk_sending_entity = vwsendingentities.pk_sending_entities))) LEFT JOIN clin_requests.lu_request_type ON ((documents.fk_lu_request_type = lu_request_type.pk))) LEFT JOIN contacts.vwpatients ON ((documents.fk_patient = vwpatients.fk_patient))) LEFT JOIN admin.vwstaff ON ((documents.fk_staff_destination = vwstaff.fk_staff))) LEFT JOIN unmatched_patients ON ((documents.fk_unmatched_patient = unmatched_patients.pk))) LEFT JOIN unmatched_staff ON ((documents.fk_unmatched_staff = unmatched_staff.pk))) ORDER BY documents.fk_patient, documents.date_created;


SET search_path = clin_requests, pg_catalog;

--
-- Name: vwforms; Type: VIEW; Schema: clin_requests; Owner: -
--

CREATE VIEW vwforms AS
    SELECT ((forms.pk || '-'::text) || forms_requests.pk) AS pk_view, forms.fk_lu_request_type AS fk_lu_type, lu_type.type, forms.fk_consult, consult.consult_date, consult.fk_patient, data_persons.firstname, data_persons.surname, data_persons.birthdate, data_persons.fk_sex, forms_requests.fk_form, forms.requests_summary, forms_requests.pk AS fk_forms_requests, lu_requests.item, forms.date AS request_date, forms_requests.request_result_html, forms.forms_results_html, forms.fk_progressnote, forms_requests.fk_lu_request, forms_requests.deleted AS request_deleted, lu_requests.fk_laterality, lu_requests.fk_decision_support, lu_requests.fk_instruction, forms.fk_branch, forms.notes_summary, forms.medications_summary, forms.copyto, forms.form_html, forms.deleted, forms.copyto_patient, forms.urgent, forms.bulk_bill, forms.fasting, forms.phone, forms.fax, forms.include_medications, forms.pk_image AS fk_image, lu_title.title AS staff_title, staff.pk AS fk_staff, data_persons1.firstname AS staff_firstname, data_persons1.surname AS staff_surname, data_branches.branch, data_branches.fk_organisation, data_organisations.organisation, vwdocuments.html FROM ((((((((((((forms JOIN forms_requests ON ((forms.pk = forms_requests.fk_form))) JOIN lu_requests ON ((forms_requests.fk_lu_request = lu_requests.pk))) JOIN lu_type ON ((lu_requests.fk_type = lu_type.pk))) JOIN clin_consult.consult ON ((forms.fk_consult = consult.pk))) JOIN clerical.data_patients ON ((consult.fk_patient = data_patients.pk))) JOIN contacts.data_persons ON ((data_patients.fk_person = data_persons.pk))) LEFT JOIN contacts.lu_title ON ((data_persons.fk_title = lu_title.pk))) JOIN admin.staff ON ((consult.fk_staff = staff.pk))) JOIN contacts.data_persons data_persons1 ON ((staff.fk_person = data_persons1.pk))) LEFT JOIN contacts.data_branches ON ((forms.fk_branch = data_branches.pk))) LEFT JOIN contacts.data_organisations ON ((data_branches.fk_organisation = data_organisations.pk))) LEFT JOIN documents.vwdocuments ON ((forms_requests.pk = vwdocuments.fk_request))) WHERE ((forms.deleted = false) AND (forms_requests.deleted = false)) ORDER BY consult.fk_patient, forms.date DESC, forms_requests.fk_form, lu_requests.item;


--
-- Name: vwforms_pk_seq; Type: SEQUENCE; Schema: clin_requests; Owner: -
--

CREATE SEQUENCE vwforms_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: vwrequestforms; Type: VIEW; Schema: clin_requests; Owner: -
--

CREATE VIEW vwrequestforms AS
    SELECT consult.consult_date, consult.fk_patient, data_persons1.firstname, data_persons1.surname, data_persons1.birthdate, lu_sex.sex, forms.date AS request_date, forms.pk AS pk_form, forms.fk_consult, forms.fk_branch, forms.fk_lu_request_type AS fk_type, forms.requests_summary, forms.notes_summary, forms.medications_summary, forms.form_html, forms.deleted, forms.copyto_patient, forms.urgent, forms.bulk_bill, forms.fasting, forms.phone, forms.fax, forms.include_medications, forms.copyto, lu_title.title AS staff_title, data_persons.surname AS staff_surname, data_persons.firstname AS staff_firstname, data_branches.branch, data_organisations.organisation, data_branches.fk_organisation, data_addresses.pk AS fk_address, data_addresses.street, data_addresses.fk_town, lu_address_types.type AS address_type, data_addresses.preferred_address, data_addresses.postal_address, data_addresses.head_office, data_addresses.geolocation, data_addresses.country_code, lu_towns.postcode, lu_towns.town, lu_towns.state, data_patients.fk_person, data_persons1.fk_sex FROM ((((((((((((admin.staff LEFT JOIN contacts.data_persons ON ((staff.fk_person = data_persons.pk))) JOIN clin_consult.consult ON ((consult.fk_staff = staff.pk))) LEFT JOIN contacts.lu_title ON ((data_persons.fk_title = lu_title.pk))) JOIN forms ON ((forms.fk_consult = consult.pk))) JOIN contacts.data_branches ON ((forms.fk_branch = data_branches.pk))) JOIN contacts.data_organisations ON ((data_branches.fk_organisation = data_organisations.pk))) LEFT JOIN contacts.data_addresses ON ((data_branches.fk_address = data_addresses.pk))) LEFT JOIN contacts.lu_towns ON ((data_addresses.fk_town = lu_towns.pk))) LEFT JOIN contacts.lu_address_types ON ((data_addresses.fk_lu_address_type = lu_address_types.pk))) JOIN clerical.data_patients ON ((consult.fk_patient = data_patients.pk))) JOIN contacts.data_persons data_persons1 ON ((data_patients.fk_person = data_persons1.pk))) LEFT JOIN contacts.lu_sex ON ((data_persons1.fk_sex = lu_sex.pk))) WHERE (forms.deleted = false) ORDER BY consult.fk_patient, forms.date;


--
-- Name: vwrequestitems; Type: VIEW; Schema: clin_requests; Owner: -
--

CREATE VIEW vwrequestitems AS
    ((SELECT (lu_request_items.pk || '-1'::text) AS pk_view, lu_request_items.pk AS fk_lu_request, lu_type.type, lu_request_items.fk_type, CASE WHEN (lu_request_items.fk_laterality = 3) THEN (lu_request_items.item || ' (LEFT)'::text) ELSE NULL::text END AS item, lu_request_items.fk_laterality, lu_request_items.fk_decision_support, lu_request_items.fk_instruction, lu_instructions.instruction FROM ((lu_requests lu_request_items JOIN lu_type ON ((lu_request_items.fk_type = lu_type.pk))) LEFT JOIN lu_instructions ON ((lu_request_items.fk_instruction = lu_instructions.pk))) WHERE ((lower(lu_request_items.item) ~~ '%'::text) AND (lu_request_items.fk_laterality = 3)) UNION SELECT (lu_request_items.pk || '-2'::text) AS pk_view, lu_request_items.pk AS fk_lu_request, lu_type.type, lu_request_items.fk_type, CASE WHEN (lu_request_items.fk_laterality = 3) THEN (lu_request_items.item || ' (RIGHT)'::text) ELSE NULL::text END AS item, lu_request_items.fk_laterality, lu_request_items.fk_decision_support, lu_request_items.fk_instruction, lu_instructions.instruction FROM ((lu_requests lu_request_items JOIN lu_type ON ((lu_request_items.fk_type = lu_type.pk))) LEFT JOIN lu_instructions ON ((lu_request_items.fk_instruction = lu_instructions.pk))) WHERE ((lower(lu_request_items.item) ~~ '%'::text) AND (lu_request_items.fk_laterality = 3))) UNION SELECT (lu_request_items.pk || '-3'::text) AS pk_view, lu_request_items.pk AS fk_lu_request, lu_type.type, lu_request_items.fk_type, CASE WHEN (lu_request_items.fk_laterality = 3) THEN (lu_request_items.item || ' (BOTH)'::text) ELSE NULL::text END AS item, lu_request_items.fk_laterality, lu_request_items.fk_decision_support, lu_request_items.fk_instruction, lu_instructions.instruction FROM ((lu_requests lu_request_items JOIN lu_type ON ((lu_request_items.fk_type = lu_type.pk))) LEFT JOIN lu_instructions ON ((lu_request_items.fk_instruction = lu_instructions.pk))) WHERE ((lower(lu_request_items.item) ~~ '%'::text) AND (lu_request_items.fk_laterality = 3))) UNION SELECT (lu_request_items.pk || '-0'::text) AS pk_view, lu_request_items.pk AS fk_lu_request, lu_type.type, lu_request_items.fk_type, lu_request_items.item, lu_request_items.fk_laterality, lu_request_items.fk_decision_support, lu_request_items.fk_instruction, lu_instructions.instruction FROM ((lu_requests lu_request_items JOIN lu_type ON ((lu_request_items.fk_type = lu_type.pk))) LEFT JOIN lu_instructions ON ((lu_request_items.fk_instruction = lu_instructions.pk))) WHERE ((lower(lu_request_items.item) ~~ '%'::text) AND (lu_request_items.fk_laterality = 0)) ORDER BY 4, 5;


--
-- Name: vwrequestproviders; Type: VIEW; Schema: clin_requests; Owner: -
--

CREATE VIEW vwrequestproviders AS
    SELECT lu_request_type.type, request_providers.fk_lu_request_type, request_providers.fk_person, request_providers.fk_employee, request_providers.fk_branch, request_providers.pk AS pk_request_provider, vworganisationsemployees.organisation, vworganisationsemployees.branch, vworganisationsemployees.postcode, vworganisationsemployees.town, vworganisationsemployees.state, vworganisationsemployees.fk_organisation, vworganisationsemployees.category, vworganisationsemployees.street, vworganisationsemployees.head_office FROM ((request_providers JOIN lu_request_type ON ((request_providers.fk_lu_request_type = lu_request_type.pk))) JOIN contacts.vworganisationsemployees ON ((request_providers.fk_branch = vworganisationsemployees.fk_branch))) ORDER BY request_providers.fk_lu_request_type, vworganisationsemployees.organisation;


--
-- Name: vwrequests; Type: VIEW; Schema: clin_requests; Owner: -
--

CREATE VIEW vwrequests AS
    ((SELECT lu_requests.pk, lu_requests.fk_type, CASE WHEN (lu_requests.fk_laterality = 3) THEN (lu_requests.item || '(BOTH)'::text) ELSE NULL::text END AS request, lu_requests.fk_decision_support, lu_requests.fk_instruction FROM lu_requests lu_requests WHERE ((lower(lu_requests.item) ~~ '%'::text) AND (lu_requests.fk_laterality = 3)) UNION SELECT lu_requests.pk, lu_requests.fk_type, CASE WHEN (lu_requests.fk_laterality = 3) THEN (lu_requests.item || '(Left)'::text) ELSE NULL::text END AS request, lu_requests.fk_decision_support, lu_requests.fk_instruction FROM lu_requests lu_requests WHERE ((lower(lu_requests.item) ~~ '%'::text) AND (lu_requests.fk_laterality = 3))) UNION SELECT lu_requests.pk, lu_requests.fk_type, CASE WHEN (lu_requests.fk_laterality = 3) THEN (lu_requests.item || '(Right)'::text) ELSE NULL::text END AS request, lu_requests.fk_decision_support, lu_requests.fk_instruction FROM lu_requests lu_requests WHERE ((lower(lu_requests.item) ~~ '%'::text) AND (lu_requests.fk_laterality = 3))) UNION SELECT lu_requests.pk, lu_requests.fk_type, lu_requests.item AS request, lu_requests.fk_decision_support, lu_requests.fk_instruction FROM lu_requests lu_requests WHERE ((lower(lu_requests.item) ~~ '%'::text) AND (lu_requests.fk_laterality = 0));


--
-- Name: vwrequestsonforms; Type: VIEW; Schema: clin_requests; Owner: -
--

CREATE VIEW vwrequestsonforms AS
    SELECT consult.fk_patient, forms.date, forms_requests.pk AS fk_forms_requests, lu_requests.item, forms_requests.fk_lu_request, forms_requests.fk_form, forms_requests.request_result_html AS html, lu_requests.fk_type, lu_type.type, forms_requests.deleted FROM ((((forms JOIN forms_requests ON ((forms.pk = forms_requests.fk_form))) JOIN lu_requests ON ((forms_requests.fk_lu_request = lu_requests.pk))) JOIN lu_type ON ((lu_requests.fk_type = lu_type.pk))) JOIN clin_consult.consult ON ((forms.fk_consult = consult.pk))) WHERE (forms_requests.deleted = false) ORDER BY consult.fk_patient;


--
-- Name: VIEW vwrequestsonforms; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON VIEW vwrequestsonforms IS 'a  view of all requests on all forms ordered by patient id';


--
-- Name: vwrequestsynonyms; Type: VIEW; Schema: clin_requests; Owner: -
--

CREATE VIEW vwrequestsynonyms AS
    SELECT lu_link_provider_user_requests.pk AS pk_lu_link_provider_user_requests, lu_link_provider_user_requests.provider_request_name, lu_link_provider_user_requests.lateralisation, lu_requests.pk AS fk_lu_request, lu_requests.item AS user_request_name FROM lu_requests, lu_link_provider_user_requests WHERE (lu_link_provider_user_requests.fk_lu_request = lu_requests.pk);


--
-- Name: vwstaffpreferences; Type: VIEW; Schema: clin_requests; Owner: -
--

CREATE VIEW vwstaffpreferences AS
    SELECT user_default_type.fk_staff, user_default_type.fk_lu_type AS pk_lu_type, lu_type.type FROM (user_default_type JOIN lu_type ON ((user_default_type.fk_lu_type = lu_type.pk))) ORDER BY user_default_type.fk_staff;


--
-- Name: VIEW vwstaffpreferences; Type: COMMENT; Schema: clin_requests; Owner: -
--

COMMENT ON VIEW vwstaffpreferences IS 'The default request ordering the user wants e.g pathology. Note the the
 view must have a primary key';


--
-- Name: vwuserproviderdefaults; Type: VIEW; Schema: clin_requests; Owner: -
--

CREATE VIEW vwuserproviderdefaults AS
    SELECT user_provider_defaults.pk AS pk_default, user_provider_defaults.fk_staff, user_provider_defaults.fk_default_branch, user_provider_defaults.fk_head_office_branch, user_provider_defaults.send_electronically, user_provider_defaults.print_paper, user_provider_defaults.deleted, user_provider_defaults.fk_lu_request_type, data_branches.branch AS default_branch, data_branches.fk_organisation, data_branches.fk_address, data_branches.memo AS default_branch_memo, data_branches.fk_category, data_branches.deleted AS default_branch_deleted, data_organisations.organisation, lu_request_type.type AS request_type, lu_categories.category AS category_organisation, data_addresses.street AS default_branch_street, lu_towns.town AS default_branch_town, lu_towns.postcode AS default_branch_postcode, data_branches1.branch AS headoffice_branch, data_addresses1.street AS headoffice_street, lu_towns1.postcode AS headoffice_postcode, lu_towns1.town AS headoffice_town FROM (((((((((user_provider_defaults JOIN contacts.data_branches ON ((user_provider_defaults.fk_default_branch = data_branches.pk))) JOIN contacts.data_organisations ON ((data_branches.fk_organisation = data_organisations.pk))) JOIN lu_request_type ON ((user_provider_defaults.fk_lu_request_type = lu_request_type.pk))) JOIN contacts.lu_categories ON ((data_branches.fk_category = lu_categories.pk))) JOIN contacts.data_addresses ON ((data_branches.fk_address = data_addresses.pk))) JOIN contacts.lu_towns ON ((data_addresses.fk_town = lu_towns.pk))) JOIN contacts.data_branches data_branches1 ON ((user_provider_defaults.fk_head_office_branch = data_branches1.pk))) JOIN contacts.data_addresses data_addresses1 ON ((data_branches1.fk_address = data_addresses1.pk))) JOIN contacts.lu_towns lu_towns1 ON ((data_addresses1.fk_town = lu_towns1.pk))) ORDER BY user_provider_defaults.fk_staff;


SET search_path = clin_vaccination, pg_catalog;

--
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
-- Name: COLUMN vaccinations.date_given; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON COLUMN vaccinations.date_given IS 'not a date field because sometimes may need to record just say 01/2002 or 1998';


--
-- Name: data_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE data_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: data_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE data_pk_seq OWNED BY vaccinations.pk;


--
-- Name: lu_indication; Type: TABLE; Schema: clin_vaccination; Owner: -; Tablespace: 
--

CREATE TABLE lu_indication (
    pk integer NOT NULL,
    medical_name text NOT NULL,
    common_name text
);


--
-- Name: TABLE lu_indication; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON TABLE lu_indication IS ' vaccine target disease lookup table  eg hepatitis B  todo this should really be a coded field not a text field';


--
-- Name: indication_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE indication_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: indication_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE indication_pk_seq OWNED BY lu_indication.pk;


--
-- Name: last_batch_number; Type: TABLE; Schema: clin_vaccination; Owner: -; Tablespace: 
--

CREATE TABLE last_batch_number (
    pk integer NOT NULL,
    fk_vaccine integer,
    batch_number text NOT NULL,
    fk_provider integer
);


--
-- Name: TABLE last_batch_number; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON TABLE last_batch_number IS 'last used batch number to make it easier on the doctors typeing when e.g vaccines may be stored in fridges in rooms in a surgery and most doctors and nurses work out of their own rooms. todo link to doctor code table';


--
-- Name: last_batch_number_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE last_batch_number_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: last_batch_number_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE last_batch_number_pk_seq OWNED BY last_batch_number.pk;


--
-- Name: link_provider_site_admininstered; Type: TABLE; Schema: clin_vaccination; Owner: -; Tablespace: 
--

CREATE TABLE link_provider_site_admininstered (
    id integer NOT NULL,
    fk_site integer,
    fk_vaccine integer,
    fk_provider integer
);


--
-- Name: TABLE link_provider_site_admininstered; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON TABLE link_provider_site_admininstered IS 'allows per-provider presentation of usual site of injection';


--
-- Name: link_provider_site_admininstered_id_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE link_provider_site_admininstered_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: link_provider_site_admininstered_id_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE link_provider_site_admininstered_id_seq OWNED BY link_provider_site_admininstered.id;


--
-- Name: lu_indication_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE lu_indication_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_indication_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE lu_indication_pk_seq OWNED BY lu_indication.pk;


--
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
-- Name: TABLE lu_schedules; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON TABLE lu_schedules IS 'create schedulescontains the schedules eg 2 month, 4 months, 4yrs etcA vaccination schedule can be a single vaccination or a schedule of
vaccination and contain one or more vaccines. The reason for this is complex
and practical referral to the doc for further information';


--
-- Name: COLUMN lu_schedules.schedule_text; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON COLUMN lu_schedules.schedule_text IS 'either a target disease name eg ''yellow fever'' or a schedule name to describe course of combined vaccines eg Hepatits A + Hepatitis B.Hence this allows unlimited and user defined schedules.';


--
-- Name: COLUMN lu_schedules.aboriginal_tsi_only; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON COLUMN lu_schedules.aboriginal_tsi_only IS 'australian requirement, some schedules apply only to aboriginal or torres strait islanders at particular ages';


--
-- Name: COLUMN lu_schedules.fk_season; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON COLUMN lu_schedules.fk_season IS 'eg. influenza prompts only wanted at particular time of year';


--
-- Name: COLUMN lu_schedules.inactive; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON COLUMN lu_schedules.inactive IS 'The vaccination schedule/vaccines is no longer in use';


--
-- Name: lu_schedules_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE lu_schedules_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_schedules_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE lu_schedules_pk_seq OWNED BY lu_schedules.pk;


--
-- Name: lu_target; Type: TABLE; Schema: clin_vaccination; Owner: -; Tablespace: 
--

CREATE TABLE lu_target (
    pk integer NOT NULL,
    target text NOT NULL
);


--
-- Name: lu_target_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE lu_target_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_target_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE lu_target_pk_seq OWNED BY lu_target.pk;


--
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
-- Name: TABLE lu_vaccines; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON TABLE lu_vaccines IS 'the master vaccine table containing links totrade name links table, target disease';


--
-- Name: lu_vaccines_descriptions; Type: TABLE; Schema: clin_vaccination; Owner: -; Tablespace: 
--

CREATE TABLE lu_vaccines_descriptions (
    pk integer NOT NULL,
    description text,
    inserted date DEFAULT ('now'::text)::date,
    deleted date
);


--
-- Name: TABLE lu_vaccines_descriptions; Type: COMMENT; Schema: clin_vaccination; Owner: -
--

COMMENT ON TABLE lu_vaccines_descriptions IS 'create the vaccines_descriptions table contains names describing what the brand names are eg tetanus, diptheria, or combinations thereof ';


--
-- Name: lu_vaccines_descriptions_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE lu_vaccines_descriptions_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_vaccines_descriptions_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE lu_vaccines_descriptions_pk_seq OWNED BY lu_vaccines_descriptions.pk;


--
-- Name: lu_vaccines_in_schedule; Type: TABLE; Schema: clin_vaccination; Owner: -; Tablespace: 
--

CREATE TABLE lu_vaccines_in_schedule (
    pk integer NOT NULL,
    fk_vaccine integer,
    fk_schedule integer
);


--
-- Name: lu_vaccines_in_schedule_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE lu_vaccines_in_schedule_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_vaccines_in_schedule_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE lu_vaccines_in_schedule_pk_seq OWNED BY lu_vaccines_in_schedule.pk;


--
-- Name: lu_vaccines_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE lu_vaccines_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_vaccines_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE lu_vaccines_pk_seq OWNED BY lu_vaccines.pk;


--
-- Name: vaccines_descriptions_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE vaccines_descriptions_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: vaccines_descriptions_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE vaccines_descriptions_pk_seq OWNED BY lu_vaccines_descriptions.pk;


--
-- Name: vaccines_in_schedule_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE vaccines_in_schedule_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: vaccines_in_schedule_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE vaccines_in_schedule_pk_seq OWNED BY lu_vaccines_in_schedule.pk;


--
-- Name: vaccines_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: -
--

CREATE SEQUENCE vaccines_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: vaccines_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: -
--

ALTER SEQUENCE vaccines_pk_seq OWNED BY lu_vaccines.pk;


SET search_path = common, pg_catalog;

--
-- Name: lu_route_administration; Type: TABLE; Schema: common; Owner: -; Tablespace: 
--

CREATE TABLE lu_route_administration (
    pk integer NOT NULL,
    abbreviation text NOT NULL,
    route text NOT NULL
);


SET search_path = clin_vaccination, pg_catalog;

--
-- Name: vwvaccines; Type: VIEW; Schema: clin_vaccination; Owner: -
--

CREATE VIEW vwvaccines AS
    SELECT lu_vaccines.pk, lu_vaccines.brand, lu_vaccines.fk_description, lu_vaccines.fk_route, lu_vaccines.form, lu_vaccines.inserted, lu_vaccines.deleted, lu_vaccines_descriptions.description, lu_route_administration.route, lu_route_administration.abbreviation AS route_abbrev FROM ((lu_vaccines JOIN lu_vaccines_descriptions ON ((lu_vaccines.fk_description = (lu_vaccines_descriptions.pk)::text))) LEFT JOIN common.lu_route_administration ON ((lu_vaccines.fk_route = lu_route_administration.pk))) ORDER BY lu_vaccines_descriptions.description;


SET search_path = clin_workcover, pg_catalog;

--
-- Name: claims; Type: TABLE; Schema: clin_workcover; Owner: -; Tablespace: 
--

CREATE TABLE claims (
    pk integer NOT NULL,
    fk_consult integer NOT NULL,
    claim_number text,
    fk_occupation integer,
    fk_branch integer,
    hours_week_worked integer,
    mechanism_of_injury text,
    date_injury text NOT NULL,
    contact_person text,
    memo text,
    identifier text NOT NULL,
    fk_person integer,
    accepted boolean
);


--
-- Name: COLUMN claims.fk_consult; Type: COMMENT; Schema: clin_workcover; Owner: -
--

COMMENT ON COLUMN claims.fk_consult IS 'fk to clin_consult.consult, gives date the claim was first logged. Note the first visit.fk_consult will be same as this, but no subsequent ones will. Last visit.fk_consult = day claim was finalised';


--
-- Name: COLUMN claims.claim_number; Type: COMMENT; Schema: clin_workcover; Owner: -
--

COMMENT ON COLUMN claims.claim_number IS 'claim number for this workcover claim';


--
-- Name: COLUMN claims.fk_occupation; Type: COMMENT; Schema: clin_workcover; Owner: -
--

COMMENT ON COLUMN claims.fk_occupation IS 'foreign key to common.lu_occupations table
note that a person may have more than one occupation so this may not be the same key
as recorded in the patients entry in data_persons.fk_occupation';


--
-- Name: COLUMN claims.fk_branch; Type: COMMENT; Schema: clin_workcover; Owner: -
--

COMMENT ON COLUMN claims.fk_branch IS 'foreign key to contacts.data.organisations table or contacts.data_persons table where the employer is a person and not a company';


--
-- Name: COLUMN claims.date_injury; Type: COMMENT; Schema: clin_workcover; Owner: -
--

COMMENT ON COLUMN claims.date_injury IS 'if known, the date of injury ?how to handle vague dates here, so have made this text for now';


--
-- Name: COLUMN claims.contact_person; Type: COMMENT; Schema: clin_workcover; Owner: -
--

COMMENT ON COLUMN claims.contact_person IS 'A contact person for this claim
Note that this IS NOT related to 
fk_person field which is used where
the employer is a person and not a company';


--
-- Name: COLUMN claims.fk_person; Type: COMMENT; Schema: clin_workcover; Owner: -
--

COMMENT ON COLUMN claims.fk_person IS ' key to contacts.data_persons table where employer is a person and not an organisation';


--
-- Name: COLUMN claims.accepted; Type: COMMENT; Schema: clin_workcover; Owner: -
--

COMMENT ON COLUMN claims.accepted IS 'If True then the work cover claim as been accepted by the insurer';


--
-- Name: claims_pk_seq; Type: SEQUENCE; Schema: clin_workcover; Owner: -
--

CREATE SEQUENCE claims_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: claims_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_workcover; Owner: -
--

ALTER SEQUENCE claims_pk_seq OWNED BY claims.pk;


--
-- Name: link_claim_documents; Type: TABLE; Schema: clin_workcover; Owner: -; Tablespace: 
--

CREATE TABLE link_claim_documents (
    pk integer NOT NULL,
    fk_document integer,
    fk_encounter integer NOT NULL
);


--
-- Name: TABLE link_claim_documents; Type: COMMENT; Schema: clin_workcover; Owner: -
--

COMMENT ON TABLE link_claim_documents IS 'link table to link documents received to a particular work-cover encounter';


--
-- Name: COLUMN link_claim_documents.fk_document; Type: COMMENT; Schema: clin_workcover; Owner: -
--

COMMENT ON COLUMN link_claim_documents.fk_document IS 'foreign key to documents table (when it exists) to link a document to this encounter';


--
-- Name: COLUMN link_claim_documents.fk_encounter; Type: COMMENT; Schema: clin_workcover; Owner: -
--

COMMENT ON COLUMN link_claim_documents.fk_encounter IS 'foreign key to encounter table';


--
-- Name: link_claim_documents_pk_seq; Type: SEQUENCE; Schema: clin_workcover; Owner: -
--

CREATE SEQUENCE link_claim_documents_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: link_claim_documents_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_workcover; Owner: -
--

ALTER SEQUENCE link_claim_documents_pk_seq OWNED BY link_claim_documents.pk;


--
-- Name: lu_caused_by_employment; Type: TABLE; Schema: clin_workcover; Owner: -; Tablespace: 
--

CREATE TABLE lu_caused_by_employment (
    pk integer NOT NULL,
    caused_by_employment text
);


--
-- Name: TABLE lu_caused_by_employment; Type: COMMENT; Schema: clin_workcover; Owner: -
--

COMMENT ON TABLE lu_caused_by_employment IS 'degree of certainty that the workcover injury was caused by employment';


--
-- Name: lu_caused_by_employment_pk_seq; Type: SEQUENCE; Schema: clin_workcover; Owner: -
--

CREATE SEQUENCE lu_caused_by_employment_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_caused_by_employment_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_workcover; Owner: -
--

ALTER SEQUENCE lu_caused_by_employment_pk_seq OWNED BY lu_caused_by_employment.pk;


--
-- Name: lu_visit_type; Type: TABLE; Schema: clin_workcover; Owner: -; Tablespace: 
--

CREATE TABLE lu_visit_type (
    pk integer NOT NULL,
    type text NOT NULL
);


--
-- Name: TABLE lu_visit_type; Type: COMMENT; Schema: clin_workcover; Owner: -
--

COMMENT ON TABLE lu_visit_type IS 'type of workcover consultation lookup table - can be Initial, Progress or the Final consulation';


--
-- Name: COLUMN lu_visit_type.type; Type: COMMENT; Schema: clin_workcover; Owner: -
--

COMMENT ON COLUMN lu_visit_type.type IS 'Initial Progress or Final or Initial and Final';


--
-- Name: lu_visit_type_pk_seq; Type: SEQUENCE; Schema: clin_workcover; Owner: -
--

CREATE SEQUENCE lu_visit_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_visit_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_workcover; Owner: -
--

ALTER SEQUENCE lu_visit_type_pk_seq OWNED BY lu_visit_type.pk;


--
-- Name: visits; Type: TABLE; Schema: clin_workcover; Owner: -; Tablespace: 
--

CREATE TABLE visits (
    pk integer NOT NULL,
    fk_claim integer NOT NULL,
    fk_lu_visit_type integer NOT NULL,
    diagnosis text NOT NULL,
    fk_code text,
    management_plan text,
    review_date date,
    assessworkplace boolean DEFAULT false NOT NULL,
    hours_capable integer,
    days_capable integer,
    restrictions text,
    fk_caused_by_employment integer NOT NULL,
    doctor_consented boolean DEFAULT true,
    worker_consented boolean DEFAULT true,
    fitness_preinjury_from date,
    fitness_suitable_from date,
    fitness_suitable_to date,
    fitness_unfit_from date,
    fitness_unfit_to date,
    fitness_perm_mod_duties_from date,
    fk_consult integer,
    fk_progressnote integer,
    fk_coding_system integer,
    capabilities text
);


--
-- Name: COLUMN visits.fk_claim; Type: COMMENT; Schema: clin_workcover; Owner: -
--

COMMENT ON COLUMN visits.fk_claim IS 'foreign key linking to claims table';


--
-- Name: COLUMN visits.fk_lu_visit_type; Type: COMMENT; Schema: clin_workcover; Owner: -
--

COMMENT ON COLUMN visits.fk_lu_visit_type IS 'key to lu_visit_type table';


--
-- Name: COLUMN visits.diagnosis; Type: COMMENT; Schema: clin_workcover; Owner: -
--

COMMENT ON COLUMN visits.diagnosis IS 'the diagnosis may be free text but could be coded';


--
-- Name: COLUMN visits.fk_code; Type: COMMENT; Schema: clin_workcover; Owner: -
--

COMMENT ON COLUMN visits.fk_code IS ' key to coding.generic_terms table';


--
-- Name: COLUMN visits.management_plan; Type: COMMENT; Schema: clin_workcover; Owner: -
--

COMMENT ON COLUMN visits.management_plan IS 'description of the managment plan';


--
-- Name: COLUMN visits.review_date; Type: COMMENT; Schema: clin_workcover; Owner: -
--

COMMENT ON COLUMN visits.review_date IS 'Date the treatment plan will be reviewed';


--
-- Name: COLUMN visits.hours_capable; Type: COMMENT; Schema: clin_workcover; Owner: -
--

COMMENT ON COLUMN visits.hours_capable IS 'number of hours in the day capable';


--
-- Name: COLUMN visits.days_capable; Type: COMMENT; Schema: clin_workcover; Owner: -
--

COMMENT ON COLUMN visits.days_capable IS 'number of days in a week capable of working';


--
-- Name: COLUMN visits.doctor_consented; Type: COMMENT; Schema: clin_workcover; Owner: -
--

COMMENT ON COLUMN visits.doctor_consented IS 'if true doctor consented. Note this is not in the 
encounter table because doctor could at any time change his mind and terminate the agreement, hence though it
will usually be the same for all vists it may not be';


--
-- Name: COLUMN visits.worker_consented; Type: COMMENT; Schema: clin_workcover; Owner: -
--

COMMENT ON COLUMN visits.worker_consented IS 'if true worker consented. Note this is not in the 
encounter table because worker could at any time change his mind and terminate the agreement, hence though it
will usually be the same for all vists it may not be';


--
-- Name: COLUMN visits.fk_progressnote; Type: COMMENT; Schema: clin_workcover; Owner: -
--

COMMENT ON COLUMN visits.fk_progressnote IS 'key to clin_consult.progressnotes points to last progress note associated with this visit';


--
-- Name: COLUMN visits.fk_coding_system; Type: COMMENT; Schema: clin_workcover; Owner: -
--

COMMENT ON COLUMN visits.fk_coding_system IS 'if not null this is the coding system used for the coded diagnosis';


--
-- Name: visits_pk_seq; Type: SEQUENCE; Schema: clin_workcover; Owner: -
--

CREATE SEQUENCE visits_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: visits_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_workcover; Owner: -
--

ALTER SEQUENCE visits_pk_seq OWNED BY visits.pk;


--
-- Name: vwworkcover; Type: VIEW; Schema: clin_workcover; Owner: -
--

CREATE VIEW vwworkcover AS
    SELECT visits.pk AS pk_view, visits.pk AS fk_visit, consult1.consult_date AS visit_date, consult.consult_date AS start_date, claims.identifier, claims.accepted, consult.fk_patient, visits.fk_claim, visits.fk_lu_visit_type, visits.diagnosis, visits.fk_coding_system, lu_systems.system AS coding_system, visits.fk_code, CASE WHEN (visits.fk_code IS NOT NULL) THEN (SELECT DISTINCT generic_terms.term FROM coding.generic_terms WHERE (visits.fk_code = generic_terms.code)) ELSE NULL::text END AS coded_term, visits.fk_progressnote, visits.management_plan, visits.review_date, visits.assessworkplace, visits.hours_capable, visits.days_capable, visits.restrictions, visits.capabilities, visits.fk_caused_by_employment, lu_caused_by_employment.caused_by_employment, visits.doctor_consented, visits.worker_consented, visits.fitness_preinjury_from, visits.fitness_suitable_from, visits.fitness_suitable_to, visits.fitness_unfit_from, visits.fitness_unfit_to, visits.fitness_perm_mod_duties_from, visits.fk_consult AS fk_consult_visit, claims.fk_consult AS fk_consult_claim, claims.claim_number, claims.fk_occupation, claims.fk_branch, claims.hours_week_worked, claims.mechanism_of_injury, claims.date_injury, claims.contact_person, claims.memo, consult.fk_staff AS fk_doctor, lu_occupations.occupation, data_persons.firstname AS doctor_firstname, data_persons.surname AS doctor_surname, lu_title.title AS doctor_title, lu_sex.sex AS doctor_sex, lu_visit_type.type AS visit_type, data_branches.branch, lu_categories.category AS branch_category, data_organisations.organisation, data_organisations.pk AS fk_organisation, data_addresses.pk AS fk_address, data_addresses.street, data_addresses.fk_town, lu_address_types.type AS address_type, data_addresses.preferred_address, data_addresses.postal_address, data_addresses.head_office, data_addresses.geolocation, data_addresses.country_code, data_addresses.fk_lu_address_type, data_addresses.deleted, lu_towns.postcode, lu_towns.town, lu_staff_roles.role AS staff_role FROM ((((((((((((((((((claims JOIN visits ON ((claims.pk = visits.fk_claim))) JOIN clin_consult.consult ON ((claims.fk_consult = consult.pk))) JOIN common.lu_occupations ON ((claims.fk_occupation = lu_occupations.pk))) JOIN admin.staff ON ((consult.fk_staff = staff.pk))) JOIN contacts.data_persons ON ((staff.fk_person = data_persons.pk))) LEFT JOIN contacts.lu_title ON ((data_persons.fk_title = lu_title.pk))) LEFT JOIN contacts.lu_sex ON ((data_persons.fk_sex = lu_sex.pk))) JOIN lu_visit_type ON ((visits.fk_lu_visit_type = lu_visit_type.pk))) JOIN lu_caused_by_employment ON ((visits.fk_caused_by_employment = lu_caused_by_employment.pk))) JOIN contacts.data_branches ON ((claims.fk_branch = data_branches.pk))) JOIN contacts.lu_categories ON ((data_branches.fk_category = lu_categories.pk))) JOIN contacts.data_organisations ON ((data_branches.fk_organisation = data_organisations.pk))) LEFT JOIN contacts.data_addresses ON ((data_branches.fk_address = data_addresses.pk))) JOIN admin.lu_staff_roles ON ((staff.fk_role = lu_staff_roles.pk))) JOIN clin_consult.consult consult1 ON ((visits.fk_consult = consult1.pk))) LEFT JOIN coding.lu_systems ON ((visits.fk_coding_system = lu_systems.pk))) LEFT JOIN contacts.lu_towns ON ((data_addresses.fk_town = lu_towns.pk))) LEFT JOIN contacts.lu_address_types ON ((data_addresses.fk_lu_address_type = lu_address_types.pk))) ORDER BY consult.fk_patient, consult.consult_date, consult1.consult_date;


--
-- Name: VIEW vwworkcover; Type: COMMENT; Schema: clin_workcover; Owner: -
--

COMMENT ON VIEW vwworkcover IS 'View of all visits for all claims date ordered. If the work cover form was coded also contains the coding system
 the coded term and the code';


SET search_path = coding, pg_catalog;

--
-- Name: icd10; Type: TABLE; Schema: coding; Owner: -; Tablespace: 
--

CREATE TABLE icd10 (
    code text,
    term text,
    stem text,
    chapter text,
    len_code text,
    len_term text
);


--
-- Name: TABLE icd10; Type: COMMENT; Schema: coding; Owner: -
--

COMMENT ON TABLE icd10 IS 'icd10 codes version 2007 WHO';


--
-- Name: COLUMN icd10.code; Type: COMMENT; Schema: coding; Owner: -
--

COMMENT ON COLUMN icd10.code IS 'the complete icd10 code without dots';


--
-- Name: COLUMN icd10.term; Type: COMMENT; Schema: coding; Owner: -
--

COMMENT ON COLUMN icd10.term IS ' the icd10 term eg angina max lengh 99 characters';


--
-- Name: COLUMN icd10.stem; Type: COMMENT; Schema: coding; Owner: -
--

COMMENT ON COLUMN icd10.stem IS 'the initial three characters of code to link to chapter';


--
-- Name: COLUMN icd10.chapter; Type: COMMENT; Schema: coding; Owner: -
--

COMMENT ON COLUMN icd10.chapter IS 'the chapter number 1-21';


--
-- Name: lu_loinc; Type: TABLE; Schema: coding; Owner: -; Tablespace: 
--

CREATE TABLE lu_loinc (
    loinc_num text,
    component text,
    property text,
    time_aspct text,
    system text,
    scale_typ text,
    method_typ text,
    relat_nms text,
    class text,
    source text,
    dt_last_ch text,
    chng_type text,
    comments text,
    answerlist text,
    status text,
    map_to text,
    scope text,
    consumer_name text,
    ipcc_units text,
    reference text,
    exact_cmp_sy text,
    molar_mass text,
    classtype integer,
    formula text,
    species text,
    exmpl_answers text,
    acssym text,
    base_name text,
    final text,
    naaccr_id text,
    code_table text,
    setroot integer,
    panelelements text,
    survey_quest_text text,
    survey_quest_src text,
    unitsrequired text,
    submitted_units text,
    relatednames2 text,
    shortname text,
    order_obs text,
    cdisc_common_tests text,
    hl7_field_subfield_id text,
    external_copyright_notice text,
    example_units text,
    inpc_percentage numeric,
    long_common_name text,
    hl7_v2_datatype text,
    hl7_v3_datatype text,
    curated_range_and_units text,
    document_section text,
    definition_description_help text,
    example_ucum_units text
);


--
-- Name: lu_loinc_abbrev; Type: TABLE; Schema: coding; Owner: -; Tablespace: 
--

CREATE TABLE lu_loinc_abbrev (
    pk integer NOT NULL,
    loinc_num text,
    component text,
    system text
);


--
-- Name: lu_loinc_abbrev_pk_seq; Type: SEQUENCE; Schema: coding; Owner: -
--

CREATE SEQUENCE lu_loinc_abbrev_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_loinc_abbrev_pk_seq; Type: SEQUENCE OWNED BY; Schema: coding; Owner: -
--

ALTER SEQUENCE lu_loinc_abbrev_pk_seq OWNED BY lu_loinc_abbrev.pk;


--
-- Name: lu_systems_pk_seq; Type: SEQUENCE; Schema: coding; Owner: -
--

CREATE SEQUENCE lu_systems_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_systems_pk_seq; Type: SEQUENCE OWNED BY; Schema: coding; Owner: -
--

ALTER SEQUENCE lu_systems_pk_seq OWNED BY lu_systems.pk;


--
-- Name: user_terms_pk_seq; Type: SEQUENCE; Schema: coding; Owner: -
--

CREATE SEQUENCE user_terms_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: usr_codes_weighting; Type: TABLE; Schema: coding; Owner: -; Tablespace: 
--

CREATE TABLE usr_codes_weighting (
    pk integer NOT NULL,
    code text NOT NULL,
    fk_coding_system integer NOT NULL,
    fk_staff integer NOT NULL,
    weighting integer NOT NULL
);


--
-- Name: usr_codes_weighting_pk_seq; Type: SEQUENCE; Schema: coding; Owner: -
--

CREATE SEQUENCE usr_codes_weighting_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: usr_codes_weighting_pk_seq; Type: SEQUENCE OWNED BY; Schema: coding; Owner: -
--

ALTER SEQUENCE usr_codes_weighting_pk_seq OWNED BY usr_codes_weighting.pk;


--
-- Name: vwcodesweighted; Type: VIEW; Schema: coding; Owner: -
--

CREATE VIEW vwcodesweighted AS
    SELECT t.code, t.fk_coding_system, t.term, w.fk_staff, w.weighting FROM (generic_terms t LEFT JOIN usr_codes_weighting w ON (((t.code = w.code) AND (w.fk_coding_system = t.fk_coding_system))));


--
-- Name: vwgenericterms; Type: VIEW; Schema: coding; Owner: -
--

CREATE VIEW vwgenericterms AS
    SELECT DISTINCT generic_terms.code AS pk_view, generic_terms.code, generic_terms.body_system, generic_terms.code_role, generic_terms.term, generic_terms.fk_coding_system, generic_terms.icd10, generic_terms.active, s.system, s.preferred FROM generic_terms, lu_systems s WHERE (s.pk = generic_terms.fk_coding_system);


SET search_path = common, pg_catalog;

--
-- Name: lu_aboriginality; Type: TABLE; Schema: common; Owner: -; Tablespace: 
--

CREATE TABLE lu_aboriginality (
    pk integer NOT NULL,
    aboriginality text NOT NULL
);


--
-- Name: lu_aboriginality_pk_seq; Type: SEQUENCE; Schema: common; Owner: -
--

CREATE SEQUENCE lu_aboriginality_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_aboriginality_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: -
--

ALTER SEQUENCE lu_aboriginality_pk_seq OWNED BY lu_aboriginality.pk;


--
-- Name: lu_anatomical_localisation; Type: TABLE; Schema: common; Owner: -; Tablespace: 
--

CREATE TABLE lu_anatomical_localisation (
    pk integer NOT NULL,
    term text NOT NULL
);


--
-- Name: lu_anatomical_location_pk_seq; Type: SEQUENCE; Schema: common; Owner: -
--

CREATE SEQUENCE lu_anatomical_location_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_anatomical_location_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: -
--

ALTER SEQUENCE lu_anatomical_location_pk_seq OWNED BY lu_anatomical_localisation.pk;


--
-- Name: lu_anatomical_site_pk_seq; Type: SEQUENCE; Schema: common; Owner: -
--

CREATE SEQUENCE lu_anatomical_site_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_anatomical_site_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: -
--

ALTER SEQUENCE lu_anatomical_site_pk_seq OWNED BY lu_anatomical_site.pk;


--
-- Name: lu_anterior_posterior_pk_seq; Type: SEQUENCE; Schema: common; Owner: -
--

CREATE SEQUENCE lu_anterior_posterior_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_anterior_posterior_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: -
--

ALTER SEQUENCE lu_anterior_posterior_pk_seq OWNED BY lu_anterior_posterior.pk;


--
-- Name: lu_companion_status; Type: TABLE; Schema: common; Owner: -; Tablespace: 
--

CREATE TABLE lu_companion_status (
    pk integer NOT NULL,
    status text NOT NULL
);


--
-- Name: lu_companion_status_pk_seq; Type: SEQUENCE; Schema: common; Owner: -
--

CREATE SEQUENCE lu_companion_status_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_companion_status_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: -
--

ALTER SEQUENCE lu_companion_status_pk_seq OWNED BY lu_companion_status.pk;


--
-- Name: lu_countries_pk_seq; Type: SEQUENCE; Schema: common; Owner: -
--

CREATE SEQUENCE lu_countries_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_countries_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: -
--

ALTER SEQUENCE lu_countries_pk_seq OWNED BY lu_countries.pk;


--
-- Name: lu_ethnicity_pk_seq; Type: SEQUENCE; Schema: common; Owner: -
--

CREATE SEQUENCE lu_ethnicity_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_ethnicity_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: -
--

ALTER SEQUENCE lu_ethnicity_pk_seq OWNED BY lu_ethnicity.pk;


--
-- Name: lu_family_relationships_pk_seq; Type: SEQUENCE; Schema: common; Owner: -
--

CREATE SEQUENCE lu_family_relationships_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_family_relationships_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: -
--

ALTER SEQUENCE lu_family_relationships_pk_seq OWNED BY lu_family_relationships.pk;


--
-- Name: lu_formulation; Type: TABLE; Schema: common; Owner: -; Tablespace: 
--

CREATE TABLE lu_formulation (
    pk integer NOT NULL,
    form text NOT NULL
);


--
-- Name: lu_formulation_pk_seq; Type: SEQUENCE; Schema: common; Owner: -
--

CREATE SEQUENCE lu_formulation_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_formulation_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: -
--

ALTER SEQUENCE lu_formulation_pk_seq OWNED BY lu_formulation.pk;


--
-- Name: lu_hearing_aid_status; Type: TABLE; Schema: common; Owner: -; Tablespace: 
--

CREATE TABLE lu_hearing_aid_status (
    pk integer NOT NULL,
    status text NOT NULL
);


--
-- Name: lu_hearing_aid_status_pk_seq; Type: SEQUENCE; Schema: common; Owner: -
--

CREATE SEQUENCE lu_hearing_aid_status_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_hearing_aid_status_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: -
--

ALTER SEQUENCE lu_hearing_aid_status_pk_seq OWNED BY lu_hearing_aid_status.pk;


--
-- Name: lu_languages_pk_seq; Type: SEQUENCE; Schema: common; Owner: -
--

CREATE SEQUENCE lu_languages_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_languages_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: -
--

ALTER SEQUENCE lu_languages_pk_seq OWNED BY lu_languages.pk;


--
-- Name: lu_laterality_pk_seq; Type: SEQUENCE; Schema: common; Owner: -
--

CREATE SEQUENCE lu_laterality_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_laterality_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: -
--

ALTER SEQUENCE lu_laterality_pk_seq OWNED BY lu_laterality.pk;


--
-- Name: lu_medicolegal; Type: TABLE; Schema: common; Owner: -; Tablespace: 
--

CREATE TABLE lu_medicolegal (
    pk integer NOT NULL,
    medicolegal_action text NOT NULL
);


--
-- Name: TABLE lu_medicolegal; Type: COMMENT; Schema: common; Owner: -
--

COMMENT ON TABLE lu_medicolegal IS ' list of medicolegal things eg - patient informed of risks - user extensible';


--
-- Name: lu_medicolegal_pk_seq; Type: SEQUENCE; Schema: common; Owner: -
--

CREATE SEQUENCE lu_medicolegal_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_medicolegal_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: -
--

ALTER SEQUENCE lu_medicolegal_pk_seq OWNED BY lu_medicolegal.pk;


--
-- Name: lu_motion; Type: TABLE; Schema: common; Owner: -; Tablespace: 
--

CREATE TABLE lu_motion (
    pk integer NOT NULL,
    motion text NOT NULL
);


--
-- Name: lu_motion_pk_seq; Type: SEQUENCE; Schema: common; Owner: -
--

CREATE SEQUENCE lu_motion_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_motion_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: -
--

ALTER SEQUENCE lu_motion_pk_seq OWNED BY lu_motion.pk;


--
-- Name: lu_normality; Type: TABLE; Schema: common; Owner: -; Tablespace: 
--

CREATE TABLE lu_normality (
    pk integer NOT NULL,
    normality text NOT NULL
);


--
-- Name: lu_normality_pk_seq; Type: SEQUENCE; Schema: common; Owner: -
--

CREATE SEQUENCE lu_normality_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_normality_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: -
--

ALTER SEQUENCE lu_normality_pk_seq OWNED BY lu_normality.pk;


--
-- Name: lu_occupations_bak; Type: TABLE; Schema: common; Owner: -; Tablespace: 
--

CREATE TABLE lu_occupations_bak (
    pk integer NOT NULL,
    occupation text
);


--
-- Name: lu_occupations_bak_pk_seq; Type: SEQUENCE; Schema: common; Owner: -
--

CREATE SEQUENCE lu_occupations_bak_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_occupations_bak_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: -
--

ALTER SEQUENCE lu_occupations_bak_pk_seq OWNED BY lu_occupations_bak.pk;


--
-- Name: lu_occupations_pk_seq; Type: SEQUENCE; Schema: common; Owner: -
--

CREATE SEQUENCE lu_occupations_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_occupations_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: -
--

ALTER SEQUENCE lu_occupations_pk_seq OWNED BY lu_occupations.pk;


--
-- Name: lu_proximal_distal; Type: TABLE; Schema: common; Owner: -; Tablespace: 
--

CREATE TABLE lu_proximal_distal (
    pk integer NOT NULL,
    proximal_distal text
);


--
-- Name: lu_proximal_distal_pk_seq; Type: SEQUENCE; Schema: common; Owner: -
--

CREATE SEQUENCE lu_proximal_distal_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_proximal_distal_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: -
--

ALTER SEQUENCE lu_proximal_distal_pk_seq OWNED BY lu_proximal_distal.pk;


--
-- Name: lu_recreationaldrugs; Type: TABLE; Schema: common; Owner: -; Tablespace: 
--

CREATE TABLE lu_recreationaldrugs (
    pk integer NOT NULL,
    drug character varying(50)
);


--
-- Name: lu_recreationaldrugs_pk_seq; Type: SEQUENCE; Schema: common; Owner: -
--

CREATE SEQUENCE lu_recreationaldrugs_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_recreationaldrugs_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: -
--

ALTER SEQUENCE lu_recreationaldrugs_pk_seq OWNED BY lu_recreationaldrugs.pk;


--
-- Name: lu_religions; Type: TABLE; Schema: common; Owner: -; Tablespace: 
--

CREATE TABLE lu_religions (
    pk integer NOT NULL,
    religion text NOT NULL
);


--
-- Name: TABLE lu_religions; Type: COMMENT; Schema: common; Owner: -
--

COMMENT ON TABLE lu_religions IS 'The -core- religions eg christiantity, the sub religions are
 in the table lu_sub_religion';


--
-- Name: lu_religions_pk_seq; Type: SEQUENCE; Schema: common; Owner: -
--

CREATE SEQUENCE lu_religions_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_religions_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: -
--

ALTER SEQUENCE lu_religions_pk_seq OWNED BY lu_religions.pk;


--
-- Name: lu_route_administration_pk_seq; Type: SEQUENCE; Schema: common; Owner: -
--

CREATE SEQUENCE lu_route_administration_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_route_administration_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: -
--

ALTER SEQUENCE lu_route_administration_pk_seq OWNED BY lu_route_administration.pk;


--
-- Name: lu_seasons; Type: TABLE; Schema: common; Owner: -; Tablespace: 
--

CREATE TABLE lu_seasons (
    pk integer NOT NULL,
    season text NOT NULL
);


--
-- Name: lu_seasons_pk_seq; Type: SEQUENCE; Schema: common; Owner: -
--

CREATE SEQUENCE lu_seasons_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_seasons_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: -
--

ALTER SEQUENCE lu_seasons_pk_seq OWNED BY lu_seasons.pk;


--
-- Name: lu_site_administration; Type: TABLE; Schema: common; Owner: -; Tablespace: 
--

CREATE TABLE lu_site_administration (
    pk integer NOT NULL,
    site text NOT NULL
);


--
-- Name: lu_site_administration_pk_seq; Type: SEQUENCE; Schema: common; Owner: -
--

CREATE SEQUENCE lu_site_administration_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_site_administration_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: -
--

ALTER SEQUENCE lu_site_administration_pk_seq OWNED BY lu_site_administration.pk;


--
-- Name: lu_smoking_status; Type: TABLE; Schema: common; Owner: -; Tablespace: 
--

CREATE TABLE lu_smoking_status (
    pk integer NOT NULL,
    status text NOT NULL
);


--
-- Name: lu_smoking_status_pk_seq; Type: SEQUENCE; Schema: common; Owner: -
--

CREATE SEQUENCE lu_smoking_status_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_smoking_status_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: -
--

ALTER SEQUENCE lu_smoking_status_pk_seq OWNED BY lu_smoking_status.pk;


--
-- Name: lu_social_support; Type: TABLE; Schema: common; Owner: -; Tablespace: 
--

CREATE TABLE lu_social_support (
    pk integer NOT NULL,
    support text NOT NULL
);


--
-- Name: lu_social_support_pk_seq; Type: SEQUENCE; Schema: common; Owner: -
--

CREATE SEQUENCE lu_social_support_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_social_support_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: -
--

ALTER SEQUENCE lu_social_support_pk_seq OWNED BY lu_social_support.pk;


--
-- Name: lu_sub_religions; Type: TABLE; Schema: common; Owner: -; Tablespace: 
--

CREATE TABLE lu_sub_religions (
    pk integer NOT NULL,
    fk_religion integer NOT NULL,
    sub_religion text NOT NULL
);


--
-- Name: TABLE lu_sub_religions; Type: COMMENT; Schema: common; Owner: -
--

COMMENT ON TABLE lu_sub_religions IS 'The eg christiantity may be Baptist, Methodist';


--
-- Name: lu_sub_religions_pk_seq; Type: SEQUENCE; Schema: common; Owner: -
--

CREATE SEQUENCE lu_sub_religions_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_sub_religions_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: -
--

ALTER SEQUENCE lu_sub_religions_pk_seq OWNED BY lu_sub_religions.pk;


--
-- Name: lu_units_pk_seq; Type: SEQUENCE; Schema: common; Owner: -
--

CREATE SEQUENCE lu_units_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_units_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: -
--

ALTER SEQUENCE lu_units_pk_seq OWNED BY lu_units.pk;


--
-- Name: lu_urgency_pk_seq; Type: SEQUENCE; Schema: common; Owner: -
--

CREATE SEQUENCE lu_urgency_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_urgency_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: -
--

ALTER SEQUENCE lu_urgency_pk_seq OWNED BY lu_urgency.pk;


--
-- Name: lu_whisper_test; Type: TABLE; Schema: common; Owner: -; Tablespace: 
--

CREATE TABLE lu_whisper_test (
    pk integer NOT NULL,
    hearing_result text NOT NULL
);


--
-- Name: lu_whisper_test_pk_seq; Type: SEQUENCE; Schema: common; Owner: -
--

CREATE SEQUENCE lu_whisper_test_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_whisper_test_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: -
--

ALTER SEQUENCE lu_whisper_test_pk_seq OWNED BY lu_whisper_test.pk;


--
-- Name: vwreligions; Type: VIEW; Schema: common; Owner: -
--

CREATE VIEW vwreligions AS
    SELECT CASE WHEN (lu_sub_religions.fk_religion > 0) THEN ((lu_religions.pk || '-'::text) || lu_sub_religions.pk) ELSE (lu_religions.pk || '-0'::text) END AS pk_view, lu_religions.religion, lu_sub_religions.sub_religion, lu_religions.pk AS fk_religion, lu_sub_religions.pk AS fk_lu_sub_religion FROM (lu_sub_religions RIGHT JOIN lu_religions ON ((lu_sub_religions.fk_religion = lu_religions.pk))) ORDER BY lu_sub_religions.fk_religion, lu_sub_religions.pk;


SET search_path = contacts, pg_catalog;

--
-- Name: data_addresses_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: -
--

CREATE SEQUENCE data_addresses_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: data_addresses_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: -
--

ALTER SEQUENCE data_addresses_pk_seq OWNED BY data_addresses.pk;


--
-- Name: data_branches_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: -
--

CREATE SEQUENCE data_branches_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: data_branches_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: -
--

ALTER SEQUENCE data_branches_pk_seq OWNED BY data_branches.pk;


--
-- Name: data_communications; Type: TABLE; Schema: contacts; Owner: -; Tablespace: 
--

CREATE TABLE data_communications (
    pk integer NOT NULL,
    value text NOT NULL,
    note text,
    preferred_method boolean DEFAULT false,
    confidential boolean DEFAULT false,
    deleted boolean DEFAULT false,
    fk_type integer NOT NULL
);


--
-- Name: data_communications_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: -
--

CREATE SEQUENCE data_communications_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: data_communications_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: -
--

ALTER SEQUENCE data_communications_pk_seq OWNED BY data_communications.pk;


--
-- Name: data_employees_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: -
--

CREATE SEQUENCE data_employees_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: data_employees_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: -
--

ALTER SEQUENCE data_employees_pk_seq OWNED BY data_employees.pk;


--
-- Name: data_organisations_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: -
--

CREATE SEQUENCE data_organisations_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: data_organisations_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: -
--

ALTER SEQUENCE data_organisations_pk_seq OWNED BY data_organisations.pk;


--
-- Name: data_persons_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: -
--

CREATE SEQUENCE data_persons_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: data_persons_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: -
--

ALTER SEQUENCE data_persons_pk_seq OWNED BY data_persons.pk;


--
-- Name: images_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: -
--

CREATE SEQUENCE images_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: images_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: -
--

ALTER SEQUENCE images_pk_seq OWNED BY images.pk;


--
-- Name: links_branches_comms; Type: TABLE; Schema: contacts; Owner: -; Tablespace: 
--

CREATE TABLE links_branches_comms (
    pk integer NOT NULL,
    fk_branch integer,
    fk_comm integer,
    deleted boolean DEFAULT false
);


--
-- Name: links_branches_comms_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: -
--

CREATE SEQUENCE links_branches_comms_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: links_branches_comms_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: -
--

ALTER SEQUENCE links_branches_comms_pk_seq OWNED BY links_branches_comms.pk;


--
-- Name: links_employees_comms; Type: TABLE; Schema: contacts; Owner: -; Tablespace: 
--

CREATE TABLE links_employees_comms (
    pk integer NOT NULL,
    fk_employee integer,
    fk_comm integer,
    deleted boolean DEFAULT false
);


--
-- Name: links_employees_comms_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: -
--

CREATE SEQUENCE links_employees_comms_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: links_employees_comms_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: -
--

ALTER SEQUENCE links_employees_comms_pk_seq OWNED BY links_employees_comms.pk;


--
-- Name: links_persons_addresses_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: -
--

CREATE SEQUENCE links_persons_addresses_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: links_persons_addresses_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: -
--

ALTER SEQUENCE links_persons_addresses_pk_seq OWNED BY links_persons_addresses.pk;


--
-- Name: links_persons_comms; Type: TABLE; Schema: contacts; Owner: -; Tablespace: 
--

CREATE TABLE links_persons_comms (
    pk integer NOT NULL,
    fk_person integer,
    fk_comm integer,
    deleted boolean DEFAULT false
);


--
-- Name: links_persons_comms_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: -
--

CREATE SEQUENCE links_persons_comms_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: links_persons_comms_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: -
--

ALTER SEQUENCE links_persons_comms_pk_seq OWNED BY links_persons_comms.pk;


--
-- Name: lu_address_types_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: -
--

CREATE SEQUENCE lu_address_types_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_address_types_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: -
--

ALTER SEQUENCE lu_address_types_pk_seq OWNED BY lu_address_types.pk;


--
-- Name: lu_categories_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: -
--

CREATE SEQUENCE lu_categories_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_categories_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: -
--

ALTER SEQUENCE lu_categories_pk_seq OWNED BY lu_categories.pk;


--
-- Name: lu_contact_type_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: -
--

CREATE SEQUENCE lu_contact_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_contact_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: -
--

ALTER SEQUENCE lu_contact_type_pk_seq OWNED BY lu_contact_type.pk;


--
-- Name: lu_employee_status_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: -
--

CREATE SEQUENCE lu_employee_status_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_employee_status_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: -
--

ALTER SEQUENCE lu_employee_status_pk_seq OWNED BY lu_employee_status.pk;


--
-- Name: lu_firstnames; Type: TABLE; Schema: contacts; Owner: -; Tablespace: 
--

CREATE TABLE lu_firstnames (
    pk integer NOT NULL,
    firstname text,
    ord integer,
    sex character(1)
);


--
-- Name: lu_firstnames_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: -
--

CREATE SEQUENCE lu_firstnames_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_firstnames_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: -
--

ALTER SEQUENCE lu_firstnames_pk_seq OWNED BY lu_firstnames.pk;


--
-- Name: lu_marital_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: -
--

CREATE SEQUENCE lu_marital_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_marital_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: -
--

ALTER SEQUENCE lu_marital_pk_seq OWNED BY lu_marital.pk;


--
-- Name: lu_misspelt_towns; Type: TABLE; Schema: contacts; Owner: -; Tablespace: 
--

CREATE TABLE lu_misspelt_towns (
    pk integer NOT NULL,
    fk_town integer NOT NULL,
    town text NOT NULL,
    town_misspelt text NOT NULL
);


--
-- Name: TABLE lu_misspelt_towns; Type: COMMENT; Schema: contacts; Owner: -
--

COMMENT ON TABLE lu_misspelt_towns IS 'When patient demographics is imported, the quality is usually appalling
 this table keeps matches to real towns/suburbs from the AU postcode database';


--
-- Name: lu_mismatched_towns_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: -
--

CREATE SEQUENCE lu_mismatched_towns_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_mismatched_towns_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: -
--

ALTER SEQUENCE lu_mismatched_towns_pk_seq OWNED BY lu_misspelt_towns.pk;


--
-- Name: lu_sex_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: -
--

CREATE SEQUENCE lu_sex_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_sex_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: -
--

ALTER SEQUENCE lu_sex_pk_seq OWNED BY lu_sex.pk;


--
-- Name: lu_surnames; Type: TABLE; Schema: contacts; Owner: -; Tablespace: 
--

CREATE TABLE lu_surnames (
    pk integer NOT NULL,
    surname text
);


--
-- Name: lu_surnames_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: -
--

CREATE SEQUENCE lu_surnames_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_surnames_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: -
--

ALTER SEQUENCE lu_surnames_pk_seq OWNED BY lu_surnames.pk;


--
-- Name: lu_title_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: -
--

CREATE SEQUENCE lu_title_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_title_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: -
--

ALTER SEQUENCE lu_title_pk_seq OWNED BY lu_title.pk;


--
-- Name: lu_towns_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: -
--

CREATE SEQUENCE lu_towns_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_towns_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: -
--

ALTER SEQUENCE lu_towns_pk_seq OWNED BY lu_towns.pk;


--
-- Name: todo; Type: TABLE; Schema: contacts; Owner: -; Tablespace: 
--

CREATE TABLE todo (
    text text
);


--
-- Name: vwbranchescomms; Type: VIEW; Schema: contacts; Owner: -
--

CREATE VIEW vwbranchescomms AS
    SELECT comms.pk, comms.value, comms.note, comms.preferred_method, comms.confidential, comms.deleted, comms.fk_type, type.type, branches.pk AS fk_branch, links.deleted AS comm_link_deleted FROM (((data_branches branches JOIN links_branches_comms links ON ((branches.pk = links.fk_branch))) JOIN data_communications comms ON ((links.fk_comm = comms.pk))) JOIN lu_contact_type type ON ((comms.fk_type = type.pk))) WHERE (links.deleted = false) ORDER BY branches.pk;


--
-- Name: vwemployees; Type: VIEW; Schema: contacts; Owner: -
--

CREATE VIEW vwemployees AS
    SELECT ((data_branches.fk_address || '-'::text) || data_employees.pk) AS pk_view, data_organisations.organisation, data_branches.branch, data_branches.fk_category AS fk_category_branch, lu_categories.category AS category_organisation, data_branches.fk_organisation, data_branches.fk_address, data_employees.pk AS fk_employee, data_employees.fk_category AS fk_category_employee, data_employees.fk_person, data_employees.fk_branch, lu_occupations.occupation, data_employees.fk_occupation, data_employees.fk_status, lu_employee_status.status AS employee_status, data_organisations.deleted AS organisation_deleted, data_branches.memo AS branch_memo, lu_categories1.category AS category_employee, data_addresses.street, lu_towns.postcode, lu_towns.town, lu_towns.state, data_addresses.fk_town, data_addresses.preferred_address, data_addresses.postal_address, data_addresses.head_office, data_employees.memo AS employee_memo, data_persons.firstname, data_persons.surname, data_persons.salutation, data_persons.birthdate, data_persons.fk_title, lu_title.title, lu_sex.sex, data_persons.fk_sex, data_persons.retired, data_persons.deceased, data_persons.date_deceased, data_employees.deleted AS employee_deleted, data_branches.deleted AS branch_deleted FROM (((((((((((data_branches JOIN data_organisations ON ((data_branches.fk_organisation = data_organisations.pk))) JOIN lu_categories ON ((data_branches.fk_category = lu_categories.pk))) LEFT JOIN data_addresses ON ((data_branches.fk_address = data_addresses.pk))) RIGHT JOIN data_employees ON ((data_branches.pk = data_employees.fk_branch))) JOIN lu_categories lu_categories1 ON ((data_employees.fk_category = lu_categories1.pk))) LEFT JOIN common.lu_occupations ON ((data_employees.fk_occupation = lu_occupations.pk))) JOIN lu_towns ON ((data_addresses.fk_town = lu_towns.pk))) JOIN lu_employee_status ON ((data_employees.fk_status = lu_employee_status.pk))) JOIN data_persons ON ((data_employees.fk_person = data_persons.pk))) JOIN lu_title ON ((data_persons.fk_title = lu_title.pk))) JOIN lu_sex ON ((data_persons.fk_sex = lu_sex.pk))) ORDER BY data_organisations.organisation, data_branches.branch, data_persons.surname, data_persons.firstname;


--
-- Name: vworganisationsbycategory; Type: VIEW; Schema: contacts; Owner: -
--

CREATE VIEW vworganisationsbycategory AS
    SELECT DISTINCT data_organisations.organisation, data_organisations.pk AS pk_organisation, data_branches.fk_category, lu_categories.category FROM ((data_branches JOIN data_organisations ON ((data_branches.fk_organisation = data_organisations.pk))) JOIN lu_categories ON ((data_branches.fk_category = lu_categories.pk))) ORDER BY data_branches.fk_category, data_organisations.organisation, data_organisations.pk, lu_categories.category;


--
-- Name: vwpatients_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: -
--

CREATE SEQUENCE vwpatients_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: vwpersonsaddresses; Type: VIEW; Schema: contacts; Owner: -
--

CREATE VIEW vwpersonsaddresses AS
    SELECT links_persons_addresses.fk_address AS pk_view, links_persons_addresses.fk_person, links_persons_addresses.fk_address, data_addresses.street, data_addresses.fk_town, lu_address_types.type AS address_type, data_addresses.preferred_address, data_addresses.postal_address, data_addresses.head_office, data_addresses.geolocation, data_addresses.country_code, data_addresses.fk_lu_address_type, data_addresses.deleted, lu_towns.postcode, lu_towns.town, lu_towns.state FROM (((links_persons_addresses JOIN data_addresses ON ((links_persons_addresses.fk_address = data_addresses.pk))) JOIN lu_towns ON ((data_addresses.fk_town = lu_towns.pk))) LEFT JOIN lu_address_types ON ((data_addresses.fk_lu_address_type = lu_address_types.pk))) WHERE ((data_addresses.head_office = false) AND (data_addresses.deleted = false)) ORDER BY links_persons_addresses.fk_person;


--
-- Name: vwpersonscomms; Type: VIEW; Schema: contacts; Owner: -
--

CREATE VIEW vwpersonscomms AS
    SELECT links_person_comms.fk_person, comms.pk, comms.value, comms.note, comms.preferred_method, comms.confidential, comms.deleted, comms.fk_type, comm_types.type FROM ((data_communications comms JOIN lu_contact_type comm_types ON ((comms.fk_type = comm_types.pk))) JOIN links_persons_comms links_person_comms ON ((comms.pk = links_person_comms.fk_comm))) ORDER BY links_person_comms.fk_person;


--
-- Name: vwpersonsexcludingpatients; Type: VIEW; Schema: contacts; Owner: -
--

CREATE VIEW vwpersonsexcludingpatients AS
    SELECT vwpersons.fk_person, vwpersons.pk_view, vwpersons.wholename, vwpersons.firstname, vwpersons.surname, vwpersons.salutation, vwpersons.birthdate, vwpersons.fk_ethnicity, vwpersons.fk_language, vwpersons.memo, vwpersons.fk_marital, vwpersons.fk_title, vwpersons.fk_sex, vwpersons.fk_image, vwpersons.fk_occupation, vwpersons.fk_category, vwpersons.retired, vwpersons.deceased, vwpersons.date_deceased, vwpersons.sex, vwpersons.sex_text, vwpersons.title, vwpersons.marital, vwpersons.occupation, vwpersons.category, vwpersons.language, vwpersons.country, vwpersons.fk_link_address, vwpersons.fk_address, vwpersons.postcode, vwpersons.town, vwpersons.state, vwpersons.country_code, vwpersons.street, vwpersons.fk_town, vwpersons.fk_lu_address_type, vwpersons.address_type, vwpersons.preferred_address, vwpersons.postal_address, vwpersons.head_office, vwpersons.address_deleted, vwpersons.image FROM ((vwpersons LEFT JOIN clerical.data_patients ON ((vwpersons.fk_person = data_patients.fk_person))) LEFT JOIN public.all_images ON ((vwpersons.fk_image = all_images.pk))) WHERE (data_patients.pk IS NULL) ORDER BY vwpersons.fk_person, vwpersons.fk_address;


--
-- Name: vwtowns; Type: VIEW; Schema: contacts; Owner: -
--

CREATE VIEW vwtowns AS
    SELECT lu_towns.pk, lu_towns.postcode, lu_towns.town, lu_towns.state, lu_towns.comment FROM lu_towns ORDER BY lu_towns.town;


SET search_path = db, pg_catalog;

--
-- Name: lu_version; Type: TABLE; Schema: db; Owner: -; Tablespace: 
--

CREATE TABLE lu_version (
    pk integer NOT NULL,
    lu_major integer DEFAULT 0 NOT NULL,
    lu_minor integer DEFAULT 0 NOT NULL
);


--
-- Name: db_version_pk_seq; Type: SEQUENCE; Schema: db; Owner: -
--

CREATE SEQUENCE db_version_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: db_version_pk_seq; Type: SEQUENCE OWNED BY; Schema: db; Owner: -
--

ALTER SEQUENCE db_version_pk_seq OWNED BY lu_version.pk;


SET search_path = defaults, pg_catalog;

--
-- Name: hl7_inboxes; Type: TABLE; Schema: defaults; Owner: -; Tablespace: 
--

CREATE TABLE hl7_inboxes (
    pk integer NOT NULL,
    destination text
);


--
-- Name: TABLE hl7_inboxes; Type: COMMENT; Schema: defaults; Owner: -
--

COMMENT ON TABLE hl7_inboxes IS 'The destination for the hl7 message';


--
-- Name: COLUMN hl7_inboxes.destination; Type: COMMENT; Schema: defaults; Owner: -
--

COMMENT ON COLUMN hl7_inboxes.destination IS 'where the hl7 message is routed to:
	general inbox = doctor specific general inbox eg
		all radiology/pathology/specialist letters
	patient inbox = the inbox in the patients notes
	doctors personal inbox = doctors personal messages
	e.g could by from external entity, or internal staff
	messages e.g reminding him do something';


--
-- Name: hl7_message_destination_pk_seq; Type: SEQUENCE; Schema: defaults; Owner: -
--

CREATE SEQUENCE hl7_message_destination_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: hl7_message_destination_pk_seq; Type: SEQUENCE OWNED BY; Schema: defaults; Owner: -
--

ALTER SEQUENCE hl7_message_destination_pk_seq OWNED BY hl7_inboxes.pk;


--
-- Name: incoming_message_handling; Type: TABLE; Schema: defaults; Owner: -; Tablespace: 
--

CREATE TABLE incoming_message_handling (
    pk integer NOT NULL,
    fk_lu_provider_type integer,
    sending_entity text NOT NULL,
    transmitting_entity text,
    fk_lu_message_display_style integer NOT NULL,
    fk_branch integer,
    fk_employee integer,
    fk_person integer,
    incoming_dir text NOT NULL,
    processed_dir text NOT NULL,
    error_dir text NOT NULL,
    fk_lu_message_standard integer NOT NULL,
    file_sample_filename text NOT NULL,
    exclude_ft_report boolean DEFAULT false,
    exclude_pit boolean DEFAULT false,
    fk_blob integer
);


--
-- Name: TABLE incoming_message_handling; Type: COMMENT; Schema: defaults; Owner: -
--

COMMENT ON TABLE incoming_message_handling IS 'parameters to define how to handle incoming hl7 messages on a per-provider basis.
Note these messages can be in form of various hl7 standards or old style PIT (sequential numbered text lines eg 100, 110 120 etc This table
defines the file type hl7 or pit, who is sending it, where to put it, which segments of the message to exclude when displaying in html';


--
-- Name: COLUMN incoming_message_handling.fk_lu_provider_type; Type: COMMENT; Schema: defaults; Owner: -
--

COMMENT ON COLUMN incoming_message_handling.fk_lu_provider_type IS 'The type of provider eg pathology provider, radiology provider';


--
-- Name: COLUMN incoming_message_handling.sending_entity; Type: COMMENT; Schema: defaults; Owner: -
--

COMMENT ON COLUMN incoming_message_handling.sending_entity IS 'the entity sending eg Best Radiology';


--
-- Name: COLUMN incoming_message_handling.transmitting_entity; Type: COMMENT; Schema: defaults; Owner: -
--

COMMENT ON COLUMN incoming_message_handling.transmitting_entity IS 'could be the sending entity or third party transmitter eg Medical Objects';


--
-- Name: COLUMN incoming_message_handling.fk_lu_message_display_style; Type: COMMENT; Schema: defaults; Owner: -
--

COMMENT ON COLUMN incoming_message_handling.fk_lu_message_display_style IS 'display as letter or result style';


--
-- Name: COLUMN incoming_message_handling.fk_lu_message_standard; Type: COMMENT; Schema: defaults; Owner: -
--

COMMENT ON COLUMN incoming_message_handling.fk_lu_message_standard IS 'hl7 or pit';


--
-- Name: COLUMN incoming_message_handling.exclude_ft_report; Type: COMMENT; Schema: defaults; Owner: -
--

COMMENT ON COLUMN incoming_message_handling.exclude_ft_report IS 'if true then no free text segments will be shown';


--
-- Name: COLUMN incoming_message_handling.exclude_pit; Type: COMMENT; Schema: defaults; Owner: -
--

COMMENT ON COLUMN incoming_message_handling.exclude_pit IS 'if contains PIT segments if true these will not be shown (often duplicated the hl7 data itself)';


--
-- Name: COLUMN incoming_message_handling.fk_blob; Type: COMMENT; Schema: defaults; Owner: -
--

COMMENT ON COLUMN incoming_message_handling.fk_blob IS 'sample file data';


--
-- Name: incoming_message_handling_pk_seq; Type: SEQUENCE; Schema: defaults; Owner: -
--

CREATE SEQUENCE incoming_message_handling_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: incoming_message_handling_pk_seq; Type: SEQUENCE OWNED BY; Schema: defaults; Owner: -
--

ALTER SEQUENCE incoming_message_handling_pk_seq OWNED BY incoming_message_handling.pk;


--
-- Name: lu_link_printer_task; Type: TABLE; Schema: defaults; Owner: -; Tablespace: 
--

CREATE TABLE lu_link_printer_task (
    pk integer NOT NULL,
    fk_lu_printer_host integer NOT NULL,
    fk_task integer NOT NULL
);


--
-- Name: TABLE lu_link_printer_task; Type: COMMENT; Schema: defaults; Owner: -
--

COMMENT ON TABLE lu_link_printer_task IS 'Links a printer on a host = linux hostname = a computer to a task';


--
-- Name: lu_link_printer_task_pk_seq; Type: SEQUENCE; Schema: defaults; Owner: -
--

CREATE SEQUENCE lu_link_printer_task_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_link_printer_task_pk_seq; Type: SEQUENCE OWNED BY; Schema: defaults; Owner: -
--

ALTER SEQUENCE lu_link_printer_task_pk_seq OWNED BY lu_link_printer_task.pk;


--
-- Name: lu_message_display_style; Type: TABLE; Schema: defaults; Owner: -; Tablespace: 
--

CREATE TABLE lu_message_display_style (
    pk integer NOT NULL,
    style text NOT NULL
);


--
-- Name: lu_message_display_style_pk_seq; Type: SEQUENCE; Schema: defaults; Owner: -
--

CREATE SEQUENCE lu_message_display_style_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_message_display_style_pk_seq; Type: SEQUENCE OWNED BY; Schema: defaults; Owner: -
--

ALTER SEQUENCE lu_message_display_style_pk_seq OWNED BY lu_message_display_style.pk;


--
-- Name: lu_message_standard; Type: TABLE; Schema: defaults; Owner: -; Tablespace: 
--

CREATE TABLE lu_message_standard (
    pk integer NOT NULL,
    type text NOT NULL,
    version text
);


--
-- Name: TABLE lu_message_standard; Type: COMMENT; Schema: defaults; Owner: -
--

COMMENT ON TABLE lu_message_standard IS 'hl7 or pit version not yet implemented';


--
-- Name: lu_message_standard_pk_seq; Type: SEQUENCE; Schema: defaults; Owner: -
--

CREATE SEQUENCE lu_message_standard_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_message_standard_pk_seq; Type: SEQUENCE OWNED BY; Schema: defaults; Owner: -
--

ALTER SEQUENCE lu_message_standard_pk_seq OWNED BY lu_message_standard.pk;


--
-- Name: lu_printer_host; Type: TABLE; Schema: defaults; Owner: -; Tablespace: 
--

CREATE TABLE lu_printer_host (
    pk integer NOT NULL,
    fk_clinic integer NOT NULL,
    hostname text NOT NULL,
    printer text NOT NULL
);


--
-- Name: TABLE lu_printer_host; Type: COMMENT; Schema: defaults; Owner: -
--

COMMENT ON TABLE lu_printer_host IS 'keeps a list of which printers live in which rooms (host=linux hostname)';


--
-- Name: lu_printer_host_pk_seq; Type: SEQUENCE; Schema: defaults; Owner: -
--

CREATE SEQUENCE lu_printer_host_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_printer_host_pk_seq; Type: SEQUENCE OWNED BY; Schema: defaults; Owner: -
--

ALTER SEQUENCE lu_printer_host_pk_seq OWNED BY lu_printer_host.pk;


--
-- Name: lu_printer_task; Type: TABLE; Schema: defaults; Owner: -; Tablespace: 
--

CREATE TABLE lu_printer_task (
    pk integer NOT NULL,
    task text NOT NULL
);


--
-- Name: lu_printer_task_pk_seq; Type: SEQUENCE; Schema: defaults; Owner: -
--

CREATE SEQUENCE lu_printer_task_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_printer_task_pk_seq; Type: SEQUENCE OWNED BY; Schema: defaults; Owner: -
--

ALTER SEQUENCE lu_printer_task_pk_seq OWNED BY lu_printer_task.pk;


--
-- Name: script_coordinates; Type: TABLE; Schema: defaults; Owner: -; Tablespace: 
--

CREATE TABLE script_coordinates (
    pk integer NOT NULL,
    fk_lu_printer_host integer NOT NULL,
    left_margin integer NOT NULL,
    top_margin integer NOT NULL,
    practice_details_x integer NOT NULL,
    practice_details_y integer NOT NULL,
    prescriber_number_x integer NOT NULL,
    prescriber_number_y integer NOT NULL,
    medicare_number_x integer NOT NULL,
    medicare_number_y integer NOT NULL,
    benefits_number_x integer NOT NULL,
    benefits_number_y integer NOT NULL,
    safety_net_card_holder_x integer NOT NULL,
    safety_net_card_holder_y integer NOT NULL,
    other_concession_card_x integer NOT NULL,
    other_concession_card_y integer NOT NULL,
    patients_details_x integer NOT NULL,
    patients_details_y integer NOT NULL,
    script_date_x integer NOT NULL,
    script_date_y integer NOT NULL,
    no_brand_substitution_x integer NOT NULL,
    no_brand_substitution_y integer NOT NULL,
    script_type_x integer NOT NULL,
    script_type_y integer NOT NULL,
    font text DEFAULT 'Arial,9'::text,
    drugs_x integer,
    drugs_y integer
);


--
-- Name: TABLE script_coordinates; Type: COMMENT; Schema: defaults; Owner: -
--

COMMENT ON TABLE script_coordinates IS 'keeps the paper positions x-y for printing out
 a prescription for a particular printer in a
 particular clinic on a particular desk';


--
-- Name: script_coordinates_pk_seq; Type: SEQUENCE; Schema: defaults; Owner: -
--

CREATE SEQUENCE script_coordinates_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: script_coordinates_pk_seq; Type: SEQUENCE OWNED BY; Schema: defaults; Owner: -
--

ALTER SEQUENCE script_coordinates_pk_seq OWNED BY script_coordinates.pk;


--
-- Name: temp; Type: TABLE; Schema: defaults; Owner: -; Tablespace: 
--

CREATE TABLE temp (
    pk integer NOT NULL,
    xy point
);


--
-- Name: temp_pk_seq; Type: SEQUENCE; Schema: defaults; Owner: -
--

CREATE SEQUENCE temp_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: temp_pk_seq; Type: SEQUENCE OWNED BY; Schema: defaults; Owner: -
--

ALTER SEQUENCE temp_pk_seq OWNED BY temp.pk;


--
-- Name: vwprinterstasks; Type: VIEW; Schema: defaults; Owner: -
--

CREATE VIEW vwprinterstasks AS
    SELECT data_branches.branch, lu_printer_host.hostname, lu_printer_host.printer, lu_printer_task.task, lu_link_printer_task.fk_task, lu_link_printer_task.fk_lu_printer_host, lu_printer_host.fk_clinic, clinics.fk_branch, lu_link_printer_task.pk AS pk_lu_link_printer_task FROM ((((lu_link_printer_task JOIN lu_printer_host ON ((lu_link_printer_task.fk_lu_printer_host = lu_printer_host.pk))) JOIN lu_printer_task ON ((lu_link_printer_task.fk_task = lu_printer_task.pk))) JOIN admin.clinics ON ((lu_printer_host.fk_clinic = clinics.pk))) JOIN contacts.data_branches ON ((clinics.fk_branch = data_branches.pk)));


SET search_path = documents, pg_catalog;

--
-- Name: copies_to; Type: TABLE; Schema: documents; Owner: -; Tablespace: 
--

CREATE TABLE copies_to (
    pk integer NOT NULL,
    fk_document integer NOT NULL,
    fk_stakeholder integer NOT NULL
);


--
-- Name: copies_to_pk_seq; Type: SEQUENCE; Schema: documents; Owner: -
--

CREATE SEQUENCE copies_to_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: copies_to_pk_seq; Type: SEQUENCE OWNED BY; Schema: documents; Owner: -
--

ALTER SEQUENCE copies_to_pk_seq OWNED BY copies_to.pk;


--
-- Name: documents_pk_seq; Type: SEQUENCE; Schema: documents; Owner: -
--

CREATE SEQUENCE documents_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: documents_pk_seq; Type: SEQUENCE OWNED BY; Schema: documents; Owner: -
--

ALTER SEQUENCE documents_pk_seq OWNED BY documents.pk;


--
-- Name: link_document_action; Type: TABLE; Schema: documents; Owner: -; Tablespace: 
--

CREATE TABLE link_document_action (
    pk integer NOT NULL,
    fk_document integer NOT NULL,
    fk_table integer NOT NULL,
    fk_schema integer NOT NULL,
    fk_table_row integer NOT NULL
);


--
-- Name: TABLE link_document_action; Type: COMMENT; Schema: documents; Owner: -
--

COMMENT ON TABLE link_document_action IS 'experimental table, linking a document to
 other tables, hence to that tables audit trail eg
 if have entered a scratchpad item  in relationship to a document
 and that scratch pad item is actioned, then can trace it';


--
-- Name: link_document_action_pk_seq; Type: SEQUENCE; Schema: documents; Owner: -
--

CREATE SEQUENCE link_document_action_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: link_document_action_pk_seq; Type: SEQUENCE OWNED BY; Schema: documents; Owner: -
--

ALTER SEQUENCE link_document_action_pk_seq OWNED BY link_document_action.pk;


--
-- Name: link_document_task; Type: TABLE; Schema: documents; Owner: -; Tablespace: 
--

CREATE TABLE link_document_task (
    pk integer NOT NULL,
    fk_task integer NOT NULL,
    fk_document integer NOT NULL
);


--
-- Name: TABLE link_document_task; Type: COMMENT; Schema: documents; Owner: -
--

COMMENT ON TABLE link_document_task IS 'Tasks allocated to staff members when the document was filed';


--
-- Name: COLUMN link_document_task.fk_task; Type: COMMENT; Schema: documents; Owner: -
--

COMMENT ON COLUMN link_document_task.fk_task IS 'key to admin.tasks table - ie points to the task, and who is responsible';


--
-- Name: lu_archive_site; Type: TABLE; Schema: documents; Owner: -; Tablespace: 
--

CREATE TABLE lu_archive_site (
    pk integer NOT NULL,
    archive_site text NOT NULL
);


--
-- Name: TABLE lu_archive_site; Type: COMMENT; Schema: documents; Owner: -
--

COMMENT ON TABLE lu_archive_site IS 'sites documents are archived eg filesystem,  url';


--
-- Name: lu_archive_site_pk_seq; Type: SEQUENCE; Schema: documents; Owner: -
--

CREATE SEQUENCE lu_archive_site_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_archive_site_pk_seq; Type: SEQUENCE OWNED BY; Schema: documents; Owner: -
--

ALTER SEQUENCE lu_archive_site_pk_seq OWNED BY lu_archive_site.pk;


--
-- Name: lu_display_as; Type: TABLE; Schema: documents; Owner: -; Tablespace: 
--

CREATE TABLE lu_display_as (
    pk integer NOT NULL,
    display_as text NOT NULL
);


--
-- Name: lu_display_as_pk_seq; Type: SEQUENCE; Schema: documents; Owner: -
--

CREATE SEQUENCE lu_display_as_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_display_as_pk_seq; Type: SEQUENCE OWNED BY; Schema: documents; Owner: -
--

ALTER SEQUENCE lu_display_as_pk_seq OWNED BY lu_display_as.pk;


--
-- Name: lu_message_display_style_pk_seq; Type: SEQUENCE; Schema: documents; Owner: -
--

CREATE SEQUENCE lu_message_display_style_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_message_display_style_pk_seq; Type: SEQUENCE OWNED BY; Schema: documents; Owner: -
--

ALTER SEQUENCE lu_message_display_style_pk_seq OWNED BY lu_message_display_style.pk;


--
-- Name: lu_message_standard_pk_seq; Type: SEQUENCE; Schema: documents; Owner: -
--

CREATE SEQUENCE lu_message_standard_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_message_standard_pk_seq; Type: SEQUENCE OWNED BY; Schema: documents; Owner: -
--

ALTER SEQUENCE lu_message_standard_pk_seq OWNED BY lu_message_standard.pk;


--
-- Name: lu_stakeholder_type; Type: TABLE; Schema: documents; Owner: -; Tablespace: 
--

CREATE TABLE lu_stakeholder_type (
    pk integer NOT NULL,
    type text
);


--
-- Name: TABLE lu_stakeholder_type; Type: COMMENT; Schema: documents; Owner: -
--

COMMENT ON TABLE lu_stakeholder_type IS 'the type of stake holder:
-originator = person whose action led to creation of the document for
 example the person who requested a pathology test
 - transmitter = the person/organisation who acted as the intermediary
   to transmit the document, eg. Medical Objects - independant company
   could be the same as the sender, or could be the service provider
 - service provider = the person/company/employee who was involved in
   creating the document content - eg a letter or a pathology result
   could be the originator in case of specialist letters, or e.g 
   a pathology company if they performed a request for a doctor
';


--
-- Name: lu_stakeholder_type_pk_seq; Type: SEQUENCE; Schema: documents; Owner: -
--

CREATE SEQUENCE lu_stakeholder_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_stakeholder_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: documents; Owner: -
--

ALTER SEQUENCE lu_stakeholder_type_pk_seq OWNED BY lu_stakeholder_type.pk;


--
-- Name: lu_stakeholders; Type: TABLE; Schema: documents; Owner: -; Tablespace: 
--

CREATE TABLE lu_stakeholders (
    pk integer NOT NULL,
    stakeholder text
);


--
-- Name: TABLE lu_stakeholders; Type: COMMENT; Schema: documents; Owner: -
--

COMMENT ON TABLE lu_stakeholders IS 'the type of stake holder:
-originator = person whose action led to creation of the document for
 example the person who requested a pathology test
 - transmitter = the person/organisation who acted as the intermediary
   to transmit the document, eg. Medical Objects - independant company
   could be the same as the sender, or could be the service provider
 - service provider = the person/company/employee who was involved in
   creating the document content - eg a letter or a pathology result
   could be the originator in case of specialist letters, or e.g 
   a pathology company if they performed a request for a doctor
';


--
-- Name: lu_stakeholders_pk_seq; Type: SEQUENCE; Schema: documents; Owner: -
--

CREATE SEQUENCE lu_stakeholders_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_stakeholders_pk_seq; Type: SEQUENCE OWNED BY; Schema: documents; Owner: -
--

ALTER SEQUENCE lu_stakeholders_pk_seq OWNED BY lu_stakeholders.pk;


--
-- Name: lu_type; Type: TABLE; Schema: documents; Owner: -; Tablespace: 
--

CREATE TABLE lu_type (
    pk integer NOT NULL,
    type text NOT NULL
);


--
-- Name: lu_type_pk_seq; Type: SEQUENCE; Schema: documents; Owner: -
--

CREATE SEQUENCE lu_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: documents; Owner: -
--

ALTER SEQUENCE lu_type_pk_seq OWNED BY lu_type.pk;


--
-- Name: observations; Type: TABLE; Schema: documents; Owner: -; Tablespace: 
--

CREATE TABLE observations (
    pk integer NOT NULL,
    fk_document integer,
    set_id integer,
    value_type text,
    identifier text,
    sub_identifier text,
    value text,
    units text,
    reference_range text,
    abnormal text,
    probability text,
    nature_abnormality text,
    result_status text,
    date_last_normal date,
    user_defined_access_checks text,
    observation_date date,
    value_numeric numeric,
    loinc text,
    pit boolean DEFAULT false,
    value_numeric_qualifier text
);


--
-- Name: TABLE observations; Type: COMMENT; Schema: documents; Owner: -
--

COMMENT ON TABLE observations IS 'Essentially this is an OBX segment such as shown below:
OBX|4|NM|2532-0^LDH^LN||269|U/L^U/L|120-250|*|||F|||200811242054
where:set_id     = 1 to n
      value_type = NM
      identifier = LDH (actually observation_identifer = 2532-0^LDH^LN
      value      = 269
      units      = U/L
      range      = 120-250
      abnormal   = * (but can be various other codes)

but we have included a numeric value of the observation value and LOINC code';


--
-- Name: COLUMN observations.pit; Type: COMMENT; Schema: documents; Owner: -
--

COMMENT ON COLUMN observations.pit IS 'if true, the FT segment contains PIT lines ie a PIT report';


--
-- Name: COLUMN observations.value_numeric_qualifier; Type: COMMENT; Schema: documents; Owner: -
--

COMMENT ON COLUMN observations.value_numeric_qualifier IS 'numerical qualifier eg < or > for example egfr <60)';


--
-- Name: observations_pk_seq; Type: SEQUENCE; Schema: documents; Owner: -
--

CREATE SEQUENCE observations_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: observations_pk_seq; Type: SEQUENCE OWNED BY; Schema: documents; Owner: -
--

ALTER SEQUENCE observations_pk_seq OWNED BY observations.pk;


--
-- Name: sending_entities_pk_seq; Type: SEQUENCE; Schema: documents; Owner: -
--

CREATE SEQUENCE sending_entities_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: sending_entities_pk_seq; Type: SEQUENCE OWNED BY; Schema: documents; Owner: -
--

ALTER SEQUENCE sending_entities_pk_seq OWNED BY sending_entities.pk;


--
-- Name: signed_off; Type: TABLE; Schema: documents; Owner: -; Tablespace: 
--

CREATE TABLE signed_off (
    pk integer NOT NULL,
    fk_document integer NOT NULL,
    fk_staff integer NOT NULL,
    date timestamp without time zone DEFAULT now(),
    comment text
);


--
-- Name: signed_off_pk_seq; Type: SEQUENCE; Schema: documents; Owner: -
--

CREATE SEQUENCE signed_off_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: signed_off_pk_seq; Type: SEQUENCE OWNED BY; Schema: documents; Owner: -
--

ALTER SEQUENCE signed_off_pk_seq OWNED BY signed_off.pk;


--
-- Name: staff_tasks_pk_seq; Type: SEQUENCE; Schema: documents; Owner: -
--

CREATE SEQUENCE staff_tasks_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: staff_tasks_pk_seq; Type: SEQUENCE OWNED BY; Schema: documents; Owner: -
--

ALTER SEQUENCE staff_tasks_pk_seq OWNED BY link_document_task.pk;


--
-- Name: stakeholders; Type: TABLE; Schema: documents; Owner: -; Tablespace: 
--

CREATE TABLE stakeholders (
    pk integer NOT NULL,
    fk_branch integer,
    fk_employee integer,
    fk_person integer,
    fk_lu_stakeholder_type integer NOT NULL
);


--
-- Name: TABLE stakeholders; Type: COMMENT; Schema: documents; Owner: -
--

COMMENT ON TABLE stakeholders IS 'contains information about all parties who are stakeholders in the
 document - i.e keys to contacts schema table, along with key to 
 lookup the type of stakeholder e.g originator, transmitter etc
 describes everyone involved in the pathway from requesting to final delivery';


--
-- Name: stakeholders_pk_seq; Type: SEQUENCE; Schema: documents; Owner: -
--

CREATE SEQUENCE stakeholders_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: stakeholders_pk_seq; Type: SEQUENCE OWNED BY; Schema: documents; Owner: -
--

ALTER SEQUENCE stakeholders_pk_seq OWNED BY stakeholders.pk;


--
-- Name: unmatched_patients_pk_seq; Type: SEQUENCE; Schema: documents; Owner: -
--

CREATE SEQUENCE unmatched_patients_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: unmatched_patients_pk_seq; Type: SEQUENCE OWNED BY; Schema: documents; Owner: -
--

ALTER SEQUENCE unmatched_patients_pk_seq OWNED BY unmatched_patients.pk;


--
-- Name: unmatched_staff_pk_seq; Type: SEQUENCE; Schema: documents; Owner: -
--

CREATE SEQUENCE unmatched_staff_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: unmatched_staff_pk_seq; Type: SEQUENCE OWNED BY; Schema: documents; Owner: -
--

ALTER SEQUENCE unmatched_staff_pk_seq OWNED BY unmatched_staff.pk;


--
-- Name: unmatched_types; Type: TABLE; Schema: documents; Owner: -; Tablespace: 
--

CREATE TABLE unmatched_types (
    pk integer NOT NULL,
    type_name text NOT NULL,
    fk_real_type integer
);


--
-- Name: unmatched_types_pk_seq; Type: SEQUENCE; Schema: documents; Owner: -
--

CREATE SEQUENCE unmatched_types_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: unmatched_types_pk_seq; Type: SEQUENCE OWNED BY; Schema: documents; Owner: -
--

ALTER SEQUENCE unmatched_types_pk_seq OWNED BY unmatched_types.pk;


--
-- Name: vwgraphableobservations; Type: VIEW; Schema: documents; Owner: -
--

CREATE VIEW vwgraphableobservations AS
    SELECT observations.pk AS pk_observations, lu_loinc_abbrev.component, observations.loinc, observations.fk_document, observations.identifier, observations.reference_range, observations.units, observations.abnormal, observations.observation_date, observations.value, observations.value_numeric, observations.value_numeric_qualifier, documents.fk_patient FROM coding.lu_loinc_abbrev, observations, documents WHERE ((((observations.loinc = lu_loinc_abbrev.loinc_num) AND (observations.fk_document = documents.pk)) AND (observations.identifier <> ''::text)) AND (observations.loinc <> '15418-7'::text)) ORDER BY documents.fk_patient, observations.identifier, observations.observation_date;


--
-- Name: vwhl7filesimported; Type: VIEW; Schema: documents; Owner: -
--

CREATE VIEW vwhl7filesimported AS
    SELECT DISTINCT vwdocuments.source_file FROM vwdocuments WHERE (vwdocuments.md5sum IS NULL) ORDER BY vwdocuments.source_file;


--
-- Name: vwinboxstaff; Type: VIEW; Schema: documents; Owner: -
--

CREATE VIEW vwinboxstaff AS
    SELECT vwstaffinclinics.pk_view, vwstaffinclinics.title, vwstaffinclinics.fk_staff, vwstaffinclinics.wholename, vwstaffinclinics.surname, NULL::unknown AS fk_unmatched_staff FROM admin.vwstaffinclinics UNION SELECT ((unmatched_staff.pk || '-'::text) || 'unmatched'::text) AS pk_view, unmatched_staff.title, unmatched_staff.fk_real_staff AS fk_staff, ((unmatched_staff.firstname || ' '::text) || (unmatched_staff.surname || ' [Unkown]'::text)) AS wholename, unmatched_staff.surname, unmatched_staff.pk AS fk_unmatched_staff FROM unmatched_staff WHERE (unmatched_staff.fk_real_staff IS NULL) ORDER BY 5;


--
-- Name: VIEW vwinboxstaff; Type: COMMENT; Schema: documents; Owner: -
--

COMMENT ON VIEW vwinboxstaff IS 'All staff with an inbox. If the staff member is unknown, they will still
 appear, once matched to a real staff member they are not pulled from
 the unmatched table ie fk_real_staff <> null then';


--
-- Name: vwobservations; Type: VIEW; Schema: documents; Owner: -
--

CREATE VIEW vwobservations AS
    SELECT documents.fk_patient, observations.pk, observations.identifier, observations.observation_date, observations.value_numeric, observations.units, observations.reference_range, observations.abnormal, observations.loinc FROM observations, documents WHERE (documents.pk = observations.fk_document) ORDER BY documents.fk_patient, observations.observation_date;


SET search_path = drugs, pg_catalog;

--
-- Name: atc; Type: TABLE; Schema: drugs; Owner: -; Tablespace: 
--

CREATE TABLE atc (
    atccode character varying(8) NOT NULL,
    name text NOT NULL
);


--
-- Name: TABLE atc; Type: COMMENT; Schema: drugs; Owner: -
--

COMMENT ON TABLE atc IS 'table associating drug names and ATC codes';


--
-- Name: brand; Type: TABLE; Schema: drugs; Owner: -; Tablespace: 
--

CREATE TABLE brand (
    fk_product integer NOT NULL,
    fk_manufacturer integer NOT NULL,
    brand character varying(80) NOT NULL,
    price money,
    from_pbs boolean DEFAULT false NOT NULL,
    pi_link text
);


--
-- Name: TABLE brand; Type: COMMENT; Schema: drugs; Owner: -
--

COMMENT ON TABLE brand IS 'many to many pivot table linking drug products and manufacturers';


--
-- Name: COLUMN brand.from_pbs; Type: COMMENT; Schema: drugs; Owner: -
--

COMMENT ON COLUMN brand.from_pbs IS 'true if the brand comes from the PBS database, allows the list to be easily reloaded
with new PBS data. False means data we added ourselves.';


--
-- Name: COLUMN brand.pi_link; Type: COMMENT; Schema: drugs; Owner: -
--

COMMENT ON COLUMN brand.pi_link IS 'name of PDF file on www.pbs.org.au of the manufacturer''s product information';


--
-- Name: clinical_effects; Type: TABLE; Schema: drugs; Owner: -; Tablespace: 
--

CREATE TABLE clinical_effects (
    pk integer NOT NULL,
    description text,
    fk_severity integer NOT NULL
);


--
-- Name: TABLE clinical_effects; Type: COMMENT; Schema: drugs; Owner: -
--

COMMENT ON TABLE clinical_effects IS 'A list of sie-effects and consequences of interactions.
I appreciate this list will get long, some values may only apply to one or two drugs, but
I think it is important to normalise. The interface may need to use a text box (it will be
too long for a pick list) and confirm with users if they want to create a new entry.';


--
-- Name: clinical_effects_pk_seq; Type: SEQUENCE; Schema: drugs; Owner: -
--

CREATE SEQUENCE clinical_effects_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: clinical_effects_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugs; Owner: -
--

ALTER SEQUENCE clinical_effects_pk_seq OWNED BY clinical_effects.pk;


--
-- Name: disease_code; Type: TABLE; Schema: drugs; Owner: -; Tablespace: 
--

CREATE TABLE disease_code (
    pk integer NOT NULL,
    code character varying(20),
    description text NOT NULL
);


--
-- Name: TABLE disease_code; Type: COMMENT; Schema: drugs; Owner: -
--

COMMENT ON TABLE disease_code IS 'holds actual coding systems';


--
-- Name: disease_code_pk_seq; Type: SEQUENCE; Schema: drugs; Owner: -
--

CREATE SEQUENCE disease_code_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: disease_code_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugs; Owner: -
--

ALTER SEQUENCE disease_code_pk_seq OWNED BY disease_code.pk;


--
-- Name: evidence_levels; Type: TABLE; Schema: drugs; Owner: -; Tablespace: 
--

CREATE TABLE evidence_levels (
    pk integer NOT NULL,
    description text NOT NULL
);


--
-- Name: evidence_levels_pk_seq; Type: SEQUENCE; Schema: drugs; Owner: -
--

CREATE SEQUENCE evidence_levels_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: evidence_levels_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugs; Owner: -
--

ALTER SEQUENCE evidence_levels_pk_seq OWNED BY evidence_levels.pk;


--
-- Name: flags; Type: TABLE; Schema: drugs; Owner: -; Tablespace: 
--

CREATE TABLE flags (
    pk integer NOT NULL,
    description character varying(100) NOT NULL
);


--
-- Name: TABLE flags; Type: COMMENT; Schema: drugs; Owner: -
--

COMMENT ON TABLE flags IS 'flags for adjuvants such as ''gluten-free'', ''paediatric formulation'', etc.';


--
-- Name: flags_pk_seq; Type: SEQUENCE; Schema: drugs; Owner: -
--

CREATE SEQUENCE flags_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: flags_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugs; Owner: -
--

ALTER SEQUENCE flags_pk_seq OWNED BY flags.pk;


--
-- Name: info; Type: TABLE; Schema: drugs; Owner: -; Tablespace: 
--

CREATE TABLE info (
    pk integer NOT NULL,
    comment text NOT NULL,
    fk_topic integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    fk_clinical_effect integer,
    fk_pharmacologic_mechanism integer,
    fk_evidence_level integer NOT NULL,
    fk_source integer NOT NULL,
    fk_patient_category integer
);


--
-- Name: TABLE info; Type: COMMENT; Schema: drugs; Owner: -
--

COMMENT ON TABLE info IS 'any product information about a specific drug or class in HTML format';


--
-- Name: COLUMN info.comment; Type: COMMENT; Schema: drugs; Owner: -
--

COMMENT ON COLUMN info.comment IS 'the drug product information in HTML format';


--
-- Name: info_pk_seq; Type: SEQUENCE; Schema: drugs; Owner: -
--

CREATE SEQUENCE info_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: info_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugs; Owner: -
--

ALTER SEQUENCE info_pk_seq OWNED BY info.pk;


--
-- Name: link_atc_info; Type: TABLE; Schema: drugs; Owner: -; Tablespace: 
--

CREATE TABLE link_atc_info (
    atccode character varying(8) NOT NULL,
    fk_info integer NOT NULL
);


--
-- Name: TABLE link_atc_info; Type: COMMENT; Schema: drugs; Owner: -
--

COMMENT ON TABLE link_atc_info IS 'links one or more ATC codes (i.e. drugs or classes) to a piece of information. Generally one 
link, but for interactions or contraindications there may be more';


--
-- Name: link_disease_info; Type: TABLE; Schema: drugs; Owner: -; Tablespace: 
--

CREATE TABLE link_disease_info (
    icd10code character varying(8) NOT NULL,
    fk_info integer NOT NULL
);


--
-- Name: TABLE link_disease_info; Type: COMMENT; Schema: drugs; Owner: -
--

COMMENT ON TABLE link_disease_info IS 'links one or more ICD-10 disease codes to a piece of information, for indications the indicated disease, for contraindications obvious, for side-effects also (ICD-10 has R-codes for various non-specifc symptoms)';


--
-- Name: link_flag_product; Type: TABLE; Schema: drugs; Owner: -; Tablespace: 
--

CREATE TABLE link_flag_product (
    fk_product integer NOT NULL,
    fk_flag integer NOT NULL
);


--
-- Name: TABLE link_flag_product; Type: COMMENT; Schema: drugs; Owner: -
--

COMMENT ON TABLE link_flag_product IS 'many-to-many pivot table linking products to flags';


--
-- Name: manufacturer; Type: TABLE; Schema: drugs; Owner: -; Tablespace: 
--

CREATE TABLE manufacturer (
    pk integer NOT NULL,
    name character varying(100),
    address text NOT NULL,
    telephone text,
    facsimile text,
    code character(2)
);


--
-- Name: TABLE manufacturer; Type: COMMENT; Schema: drugs; Owner: -
--

COMMENT ON TABLE manufacturer IS 'list of pharmaceutical manufacturers';


--
-- Name: COLUMN manufacturer.name; Type: COMMENT; Schema: drugs; Owner: -
--

COMMENT ON COLUMN manufacturer.name IS 'company name';


--
-- Name: COLUMN manufacturer.address; Type: COMMENT; Schema: drugs; Owner: -
--

COMMENT ON COLUMN manufacturer.address IS 'complete printable address with embeded newline characters as "\\n"';


--
-- Name: COLUMN manufacturer.telephone; Type: COMMENT; Schema: drugs; Owner: -
--

COMMENT ON COLUMN manufacturer.telephone IS 'phone number of company';


--
-- Name: COLUMN manufacturer.facsimile; Type: COMMENT; Schema: drugs; Owner: -
--

COMMENT ON COLUMN manufacturer.facsimile IS 'fax number of company';


--
-- Name: COLUMN manufacturer.code; Type: COMMENT; Schema: drugs; Owner: -
--

COMMENT ON COLUMN manufacturer.code IS 'two-letter symbol of manufacturer';


--
-- Name: manufacturer_pk_seq; Type: SEQUENCE; Schema: drugs; Owner: -
--

CREATE SEQUENCE manufacturer_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: manufacturer_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugs; Owner: -
--

ALTER SEQUENCE manufacturer_pk_seq OWNED BY manufacturer.pk;


--
-- Name: patient_categories; Type: TABLE; Schema: drugs; Owner: -; Tablespace: 
--

CREATE TABLE patient_categories (
    pk integer NOT NULL,
    description text NOT NULL,
    comment text
);


--
-- Name: TABLE patient_categories; Type: COMMENT; Schema: drugs; Owner: -
--

COMMENT ON TABLE patient_categories IS 'enumeration of categories of patient populations for targeted drug warnings';


--
-- Name: patient_categories_pk_seq; Type: SEQUENCE; Schema: drugs; Owner: -
--

CREATE SEQUENCE patient_categories_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: patient_categories_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugs; Owner: -
--

ALTER SEQUENCE patient_categories_pk_seq OWNED BY patient_categories.pk;


--
-- Name: pbs; Type: TABLE; Schema: drugs; Owner: -; Tablespace: 
--

CREATE TABLE pbs (
    fk_product integer NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    max_rpt integer DEFAULT 0 NOT NULL,
    pbscode character varying(10) NOT NULL,
    chapter character varying(2) NOT NULL,
    restrictionflag character(1) DEFAULT 'U'::bpchar NOT NULL
);


--
-- Name: TABLE pbs; Type: COMMENT; Schema: drugs; Owner: -
--

COMMENT ON TABLE pbs IS 'PBS-specific information about subsidy, authority riles, etc. Private-script only drugs wont have a entry in this table.';


--
-- Name: COLUMN pbs.quantity; Type: COMMENT; Schema: drugs; Owner: -
--

COMMENT ON COLUMN pbs.quantity IS 'quantity of packaged units dispensed under subsidy for any one prescription. 
AU: this the maximum quantity in the PBS Yellow Book.';


--
-- Name: COLUMN pbs.max_rpt; Type: COMMENT; Schema: drugs; Owner: -
--

COMMENT ON COLUMN pbs.max_rpt IS 'maximum number of repeat (refill) authorizations allowed on any one subsidised prescription (series)';


--
-- Name: COLUMN pbs.restrictionflag; Type: COMMENT; Schema: drugs; Owner: -
--

COMMENT ON COLUMN pbs.restrictionflag IS 'U=unrestricted, R=restricted, A=authority, S=streamlined';


--
-- Name: pharmacologic_mechanisms; Type: TABLE; Schema: drugs; Owner: -; Tablespace: 
--

CREATE TABLE pharmacologic_mechanisms (
    pk integer NOT NULL,
    description text NOT NULL
);


--
-- Name: pharmacologic_mechanisms_pk_seq; Type: SEQUENCE; Schema: drugs; Owner: -
--

CREATE SEQUENCE pharmacologic_mechanisms_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: pharmacologic_mechanisms_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugs; Owner: -
--

ALTER SEQUENCE pharmacologic_mechanisms_pk_seq OWNED BY pharmacologic_mechanisms.pk;


--
-- Name: product; Type: TABLE; Schema: drugs; Owner: -; Tablespace: 
--

CREATE TABLE product (
    pk integer NOT NULL,
    atccode character varying(8),
    name text NOT NULL,
    description text NOT NULL,
    numeric_dose double precision DEFAULT 1.0,
    fk_unit integer,
    packsize integer NOT NULL
);


--
-- Name: TABLE product; Type: COMMENT; Schema: drugs; Owner: -
--

COMMENT ON TABLE product IS 'dispensable form of a generic drug including strength, package size etc';


--
-- Name: product_pk_seq; Type: SEQUENCE; Schema: drugs; Owner: -
--

CREATE SEQUENCE product_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: product_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugs; Owner: -
--

ALTER SEQUENCE product_pk_seq OWNED BY product.pk;


--
-- Name: restriction; Type: TABLE; Schema: drugs; Owner: -; Tablespace: 
--

CREATE TABLE restriction (
    pbscode character varying(10) NOT NULL,
    comment text NOT NULL,
    code character varying(10) NOT NULL
);


--
-- Name: TABLE restriction; Type: COMMENT; Schema: drugs; Owner: -
--

COMMENT ON TABLE restriction IS 'list of PBS restrictions and authority warnings';


--
-- Name: COLUMN restriction.comment; Type: COMMENT; Schema: drugs; Owner: -
--

COMMENT ON COLUMN restriction.comment IS 'the actual text of the authority requirement';


--
-- Name: COLUMN restriction.code; Type: COMMENT; Schema: drugs; Owner: -
--

COMMENT ON COLUMN restriction.code IS 'the authority code number, for doing streamlined authorities';


--
-- Name: severity_level; Type: TABLE; Schema: drugs; Owner: -; Tablespace: 
--

CREATE TABLE severity_level (
    pk integer NOT NULL,
    description character varying(100) NOT NULL,
    comment text
);


--
-- Name: severity_level_pk_seq; Type: SEQUENCE; Schema: drugs; Owner: -
--

CREATE SEQUENCE severity_level_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: severity_level_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugs; Owner: -
--

ALTER SEQUENCE severity_level_pk_seq OWNED BY severity_level.pk;


--
-- Name: sources; Type: TABLE; Schema: drugs; Owner: -; Tablespace: 
--

CREATE TABLE sources (
    pk integer NOT NULL,
    source_category character(1) NOT NULL,
    description text NOT NULL,
    CONSTRAINT sources_source_category_check CHECK ((source_category = ANY (ARRAY['p'::bpchar, 'a'::bpchar, 'i'::bpchar, 'm'::bpchar, 'o'::bpchar, 's'::bpchar])))
);


--
-- Name: TABLE sources; Type: COMMENT; Schema: drugs; Owner: -
--

COMMENT ON TABLE sources IS 'Source of any reference information in this database';


--
-- Name: COLUMN sources.source_category; Type: COMMENT; Schema: drugs; Owner: -
--

COMMENT ON COLUMN sources.source_category IS 'p=peer reviewed, a=official authority, i=independent source, m=manufacturer, o=other, s=self defined';


--
-- Name: COLUMN sources.description; Type: COMMENT; Schema: drugs; Owner: -
--

COMMENT ON COLUMN sources.description IS 'URL or address or similar informtion allowing to reproduce the source of information';


--
-- Name: sources_pk_seq; Type: SEQUENCE; Schema: drugs; Owner: -
--

CREATE SEQUENCE sources_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: sources_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugs; Owner: -
--

ALTER SEQUENCE sources_pk_seq OWNED BY sources.pk;


--
-- Name: topic; Type: TABLE; Schema: drugs; Owner: -; Tablespace: 
--

CREATE TABLE topic (
    pk integer NOT NULL,
    title character varying(60) NOT NULL,
    target character(1) NOT NULL,
    CONSTRAINT topic_target_check CHECK ((target = ANY (ARRAY['h'::bpchar, 'p'::bpchar])))
);


--
-- Name: TABLE topic; Type: COMMENT; Schema: drugs; Owner: -
--

COMMENT ON TABLE topic IS 'topics for drug information, such as pharmaco-kinetics, indications, etc.';


--
-- Name: COLUMN topic.target; Type: COMMENT; Schema: drugs; Owner: -
--

COMMENT ON COLUMN topic.target IS 'the target of this information: h=health professional, p=patient';


--
-- Name: topic_pk_seq; Type: SEQUENCE; Schema: drugs; Owner: -
--

CREATE SEQUENCE topic_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: topic_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugs; Owner: -
--

ALTER SEQUENCE topic_pk_seq OWNED BY topic.pk;


--
-- Name: units; Type: TABLE; Schema: drugs; Owner: -; Tablespace: 
--

CREATE TABLE units (
    pk integer NOT NULL,
    unit character varying(30) NOT NULL
);


--
-- Name: TABLE units; Type: COMMENT; Schema: drugs; Owner: -
--

COMMENT ON TABLE units IS '(SI) units used to quantify/measure drugs';


--
-- Name: COLUMN units.unit; Type: COMMENT; Schema: drugs; Owner: -
--

COMMENT ON COLUMN units.unit IS '(SI) units used to quantify/measure drugs like "mg", "ml"';


--
-- Name: units_pk_seq; Type: SEQUENCE; Schema: drugs; Owner: -
--

CREATE SEQUENCE units_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: units_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugs; Owner: -
--

ALTER SEQUENCE units_pk_seq OWNED BY units.pk;


SET search_path = import_export, pg_catalog;

--
-- Name: lu_demographics_field_templates; Type: TABLE; Schema: import_export; Owner: -; Tablespace: 
--

CREATE TABLE lu_demographics_field_templates (
    pk integer NOT NULL,
    fk_source_program integer NOT NULL,
    version text NOT NULL,
    surname_field_order integer,
    firstname_field_order integer,
    title_field_order integer,
    sex_field_order integer,
    marital_field_order integer,
    salutation_field_order integer,
    medicare_field_order integer,
    birthdate_field_order integer,
    occupation_field_order integer,
    street1_field_order integer,
    street2_field_order integer,
    suburb_field_order integer,
    homephone_field_order integer,
    workphone_field_order integer,
    mobile_field_order integer,
    retired_field_order integer,
    field_names text,
    veterens_field_order integer,
    medicare_card_pos_field_order integer,
    card_concession_number_field_order integer
);


--
-- Name: TABLE lu_demographics_field_templates; Type: COMMENT; Schema: import_export; Owner: -
--

COMMENT ON TABLE lu_demographics_field_templates IS 'demographic details imported from delimited file , this table keeps details of field definitions, sparators etc';


--
-- Name: lu_demographics_field_templates_pk_seq; Type: SEQUENCE; Schema: import_export; Owner: -
--

CREATE SEQUENCE lu_demographics_field_templates_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_demographics_field_templates_pk_seq; Type: SEQUENCE OWNED BY; Schema: import_export; Owner: -
--

ALTER SEQUENCE lu_demographics_field_templates_pk_seq OWNED BY lu_demographics_field_templates.pk;


--
-- Name: lu_source_program; Type: TABLE; Schema: import_export; Owner: -; Tablespace: 
--

CREATE TABLE lu_source_program (
    pk integer NOT NULL,
    program text NOT NULL
);


--
-- Name: TABLE lu_source_program; Type: COMMENT; Schema: import_export; Owner: -
--

COMMENT ON TABLE lu_source_program IS 'source program for imported data either clinical or clerical';


--
-- Name: lu_source_program_pk_seq; Type: SEQUENCE; Schema: import_export; Owner: -
--

CREATE SEQUENCE lu_source_program_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lu_source_program_pk_seq; Type: SEQUENCE OWNED BY; Schema: import_export; Owner: -
--

ALTER SEQUENCE lu_source_program_pk_seq OWNED BY lu_source_program.pk;


--
-- Name: vwdemographictemplates; Type: VIEW; Schema: import_export; Owner: -
--

CREATE VIEW vwdemographictemplates AS
    SELECT lu_source_program.pk AS pk_source_program, lu_source_program.program, lu_demographics_field_templates.pk AS fk_template, lu_demographics_field_templates.version, lu_demographics_field_templates.surname_field_order, lu_demographics_field_templates.firstname_field_order, lu_demographics_field_templates.title_field_order, lu_demographics_field_templates.sex_field_order, lu_demographics_field_templates.marital_field_order, lu_demographics_field_templates.salutation_field_order, lu_demographics_field_templates.medicare_field_order, lu_demographics_field_templates.medicare_card_pos_field_order, lu_demographics_field_templates.card_concession_number_field_order, lu_demographics_field_templates.veterens_field_order, lu_demographics_field_templates.birthdate_field_order, lu_demographics_field_templates.occupation_field_order, lu_demographics_field_templates.street1_field_order, lu_demographics_field_templates.street2_field_order, lu_demographics_field_templates.suburb_field_order, lu_demographics_field_templates.homephone_field_order, lu_demographics_field_templates.workphone_field_order, lu_demographics_field_templates.mobile_field_order, lu_demographics_field_templates.retired_field_order, lu_demographics_field_templates.field_names, lu_demographics_field_templates.fk_source_program FROM (lu_demographics_field_templates RIGHT JOIN lu_source_program ON ((lu_demographics_field_templates.fk_source_program = lu_source_program.pk))) ORDER BY lu_source_program.program;


SET search_path = public, pg_catalog;

--
-- Name: all_images_pk_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE all_images_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: all_images_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE all_images_pk_seq OWNED BY all_images.pk;


SET search_path = admin, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: admin; Owner: -
--

ALTER TABLE clinic_rooms ALTER COLUMN pk SET DEFAULT nextval('clinic_rooms_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: admin; Owner: -
--

ALTER TABLE clinics ALTER COLUMN pk SET DEFAULT nextval('clinic_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: admin; Owner: -
--

ALTER TABLE global_preferences ALTER COLUMN pk SET DEFAULT nextval('global_preferences_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: admin; Owner: -
--

ALTER TABLE link_staff_clinics ALTER COLUMN pk SET DEFAULT nextval('link_staff_clinics_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: admin; Owner: -
--

ALTER TABLE lu_staff_roles ALTER COLUMN pk SET DEFAULT nextval('lu_staff_roles_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: admin; Owner: -
--

ALTER TABLE lu_staff_status ALTER COLUMN pk SET DEFAULT nextval('lu_staff_status_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: admin; Owner: -
--

ALTER TABLE lu_staff_type ALTER COLUMN pk SET DEFAULT nextval('lu_staff_type_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: admin; Owner: -
--

ALTER TABLE staff ALTER COLUMN pk SET DEFAULT nextval('staff_pk_seq'::regclass);


SET search_path = audit, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: audit; Owner: -
--

ALTER TABLE audit ALTER COLUMN pk SET DEFAULT nextval('audit_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: audit; Owner: -
--

ALTER TABLE lu_actions ALTER COLUMN pk SET DEFAULT nextval('lu_actions_pk_seq1'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: audit; Owner: -
--

ALTER TABLE lu_reasons ALTER COLUMN pk SET DEFAULT nextval('lu_reasons_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: audit; Owner: -
--

ALTER TABLE lu_schemas ALTER COLUMN pk SET DEFAULT nextval('lu_schemas_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: audit; Owner: -
--

ALTER TABLE lu_status ALTER COLUMN pk SET DEFAULT nextval('lu_actions_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: audit; Owner: -
--

ALTER TABLE lu_tables ALTER COLUMN pk SET DEFAULT nextval('lu_tables_pk_seq'::regclass);


SET search_path = blobs, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: blobs; Owner: -
--

ALTER TABLE blobs ALTER COLUMN pk SET DEFAULT nextval('blobs_pk_seq'::regclass);


SET search_path = clerical, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: clerical; Owner: -
--

ALTER TABLE data_families ALTER COLUMN pk SET DEFAULT nextval('data_families_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clerical; Owner: -
--

ALTER TABLE data_family_members ALTER COLUMN pk SET DEFAULT nextval('data_family_members_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clerical; Owner: -
--

ALTER TABLE data_patients ALTER COLUMN pk SET DEFAULT nextval('data_patients_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clerical; Owner: -
--

ALTER TABLE lu_task_types ALTER COLUMN pk SET DEFAULT nextval('lu_task_types_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clerical; Owner: -
--

ALTER TABLE task_component_notes ALTER COLUMN pk SET DEFAULT nextval('task_component_notes_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clerical; Owner: -
--

ALTER TABLE task_components ALTER COLUMN pk SET DEFAULT nextval('task_components_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clerical; Owner: -
--

ALTER TABLE tasks ALTER COLUMN pk SET DEFAULT nextval('tasks_pk_seq'::regclass);


SET search_path = clin_allergies, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: clin_allergies; Owner: -
--

ALTER TABLE allergies ALTER COLUMN pk SET DEFAULT nextval('allergies_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_allergies; Owner: -
--

ALTER TABLE lu_reaction ALTER COLUMN pk SET DEFAULT nextval('lu_reaction_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_allergies; Owner: -
--

ALTER TABLE lu_type ALTER COLUMN pk SET DEFAULT nextval('lu_type_pk_seq'::regclass);


SET search_path = clin_careplans, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: clin_careplans; Owner: -
--

ALTER TABLE careplan_pages ALTER COLUMN pk SET DEFAULT nextval('careplan_pages_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_careplans; Owner: -
--

ALTER TABLE careplans ALTER COLUMN pk SET DEFAULT nextval('careplans_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_careplans; Owner: -
--

ALTER TABLE component_task_due ALTER COLUMN pk SET DEFAULT nextval('component_task_due_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_careplans; Owner: -
--

ALTER TABLE link_careplanpage_advice ALTER COLUMN pk SET DEFAULT nextval('link_careplanpage_advice_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_careplans; Owner: -
--

ALTER TABLE link_careplanpage_components ALTER COLUMN pk SET DEFAULT nextval('link_careplanpage_components_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_careplans; Owner: -
--

ALTER TABLE link_careplanpages_careplan ALTER COLUMN pk SET DEFAULT nextval('link_careplanpages_careplan_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_careplans; Owner: -
--

ALTER TABLE lu_advice ALTER COLUMN pk SET DEFAULT nextval('lu_advice_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_careplans; Owner: -
--

ALTER TABLE lu_aims ALTER COLUMN pk SET DEFAULT nextval('lu_aims_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_careplans; Owner: -
--

ALTER TABLE lu_components ALTER COLUMN pk SET DEFAULT nextval('lu_components_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_careplans; Owner: -
--

ALTER TABLE lu_conditions ALTER COLUMN pk SET DEFAULT nextval('lu_conditions_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_careplans; Owner: -
--

ALTER TABLE lu_education ALTER COLUMN pk SET DEFAULT nextval('lu_education_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_careplans; Owner: -
--

ALTER TABLE lu_responsible ALTER COLUMN pk SET DEFAULT nextval('lu_responsible_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_careplans; Owner: -
--

ALTER TABLE lu_tasks ALTER COLUMN pk SET DEFAULT nextval('lu_tasks_pk_seq'::regclass);


SET search_path = clin_certificates, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: clin_certificates; Owner: -
--

ALTER TABLE lu_illness_temporality ALTER COLUMN pk SET DEFAULT nextval('lu_illness_temporality_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_certificates; Owner: -
--

ALTER TABLE medical_certificate ALTER COLUMN pk SET DEFAULT nextval('medical_certificate_pk_seq'::regclass);


SET search_path = clin_checkups, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: clin_checkups; Owner: -
--

ALTER TABLE annual_checkup ALTER COLUMN pk SET DEFAULT nextval('annual_checkup_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_checkups; Owner: -
--

ALTER TABLE lu_nutrition_questions ALTER COLUMN pk SET DEFAULT nextval('lu_nutrition_questions_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_checkups; Owner: -
--

ALTER TABLE lu_state_of_health ALTER COLUMN pk SET DEFAULT nextval('lu_state_of_health_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_checkups; Owner: -
--

ALTER TABLE over75 ALTER COLUMN pk SET DEFAULT nextval('over75_pk_seq'::regclass);


SET search_path = clin_consult, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: clin_consult; Owner: -
--

ALTER TABLE consult ALTER COLUMN pk SET DEFAULT nextval('consult_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_consult; Owner: -
--

ALTER TABLE images ALTER COLUMN pk SET DEFAULT nextval('images_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_consult; Owner: -
--

ALTER TABLE lu_consult_type ALTER COLUMN pk SET DEFAULT nextval('lu_consult_type_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_consult; Owner: -
--

ALTER TABLE lu_progressnotes_sections ALTER COLUMN pk SET DEFAULT nextval('lu_progressnotes_sections_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_consult; Owner: -
--

ALTER TABLE lu_scratchpad_status ALTER COLUMN pk SET DEFAULT nextval('lu_scratchpad_status_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_consult; Owner: -
--

ALTER TABLE progressnotes ALTER COLUMN pk SET DEFAULT nextval('progressnotes_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_consult; Owner: -
--

ALTER TABLE scratchpad ALTER COLUMN pk SET DEFAULT nextval('scratchpad_pk_seq'::regclass);


SET search_path = clin_history, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: clin_history; Owner: -
--

ALTER TABLE care_plan_components_due ALTER COLUMN pk SET DEFAULT nextval('care_plan_components_due_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_history; Owner: -
--

ALTER TABLE data_recreational_drugs ALTER COLUMN pk SET DEFAULT nextval('data_recreational_drugs_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_history; Owner: -
--

ALTER TABLE family_conditions ALTER COLUMN pk SET DEFAULT nextval('family_conditions_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_history; Owner: -
--

ALTER TABLE family_links ALTER COLUMN pk SET DEFAULT nextval('family_links_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_history; Owner: -
--

ALTER TABLE family_members ALTER COLUMN pk SET DEFAULT nextval('family_members_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_history; Owner: -
--

ALTER TABLE hospitalisations ALTER COLUMN pk SET DEFAULT nextval('hospitalisations_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_history; Owner: -
--

ALTER TABLE lu_careplan_components ALTER COLUMN pk SET DEFAULT nextval('lu_careplan_components_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_history; Owner: -
--

ALTER TABLE lu_dacc_components ALTER COLUMN pk SET DEFAULT nextval('lu_dacc_components_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_history; Owner: -
--

ALTER TABLE lu_exposures ALTER COLUMN pk SET DEFAULT nextval('lu_exposures_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_history; Owner: -
--

ALTER TABLE occupational_history ALTER COLUMN pk SET DEFAULT nextval('occupational_history_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_history; Owner: -
--

ALTER TABLE occupations_exposures ALTER COLUMN pk SET DEFAULT nextval('occupations_exposures_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_history; Owner: -
--

ALTER TABLE past_history ALTER COLUMN pk SET DEFAULT nextval('past_history_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_history; Owner: -
--

ALTER TABLE social_history ALTER COLUMN pk SET DEFAULT nextval('social_history_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_history; Owner: -
--

ALTER TABLE team_care_members ALTER COLUMN pk SET DEFAULT nextval('team_care_members_pk_seq'::regclass);


SET search_path = clin_measurements, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: clin_measurements; Owner: -
--

ALTER TABLE lu_type ALTER COLUMN pk SET DEFAULT nextval('lu_type_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_measurements; Owner: -
--

ALTER TABLE measurements ALTER COLUMN pk SET DEFAULT nextval('measurements_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_measurements; Owner: -
--

ALTER TABLE patients_defaults ALTER COLUMN pk SET DEFAULT nextval('patients_defaults_pk_seq'::regclass);


SET search_path = clin_mentalhealth, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: clin_mentalhealth; Owner: -
--

ALTER TABLE k10_results ALTER COLUMN pk SET DEFAULT nextval('k10_results_pk_seq'::regclass);


--
-- Name: pk_tool; Type: DEFAULT; Schema: clin_mentalhealth; Owner: -
--

ALTER TABLE lu_assessment_tools ALTER COLUMN pk_tool SET DEFAULT nextval('lu_assessment_tools_pk_tool_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_mentalhealth; Owner: -
--

ALTER TABLE lu_component_help ALTER COLUMN pk SET DEFAULT nextval('lu_component_help_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_mentalhealth; Owner: -
--

ALTER TABLE lu_depression_degree ALTER COLUMN pk SET DEFAULT nextval('lu_depression_degree_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_mentalhealth; Owner: -
--

ALTER TABLE lu_k10_components ALTER COLUMN pk SET DEFAULT nextval('lu_k10_components_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_mentalhealth; Owner: -
--

ALTER TABLE lu_plan_type ALTER COLUMN pk SET DEFAULT nextval('lu_plan_type_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_mentalhealth; Owner: -
--

ALTER TABLE lu_risk_to_others ALTER COLUMN pk SET DEFAULT nextval('lu_risk_to_others_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_mentalhealth; Owner: -
--

ALTER TABLE mentalhealth_plan ALTER COLUMN pk SET DEFAULT nextval('mentalhealth_plan_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_mentalhealth; Owner: -
--

ALTER TABLE team_care_members ALTER COLUMN pk SET DEFAULT nextval('team_care_members_pk_seq'::regclass);


SET search_path = clin_pregnancy, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: clin_pregnancy; Owner: -
--

ALTER TABLE lu_antenatal_venue ALTER COLUMN pk SET DEFAULT nextval('lu_antenatal_venue_pk_seq'::regclass);


SET search_path = clin_prescribing, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: clin_prescribing; Owner: -
--

ALTER TABLE items_prescribed ALTER COLUMN pk SET DEFAULT nextval('items_prescribed_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_prescribing; Owner: -
--

ALTER TABLE link_generics_brands ALTER COLUMN pk SET DEFAULT nextval('link_generics_brands_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_prescribing; Owner: -
--

ALTER TABLE lu_authority_indications ALTER COLUMN pk SET DEFAULT nextval('lu_authority_indications_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_prescribing; Owner: -
--

ALTER TABLE lu_brand ALTER COLUMN pk SET DEFAULT nextval('lu_brand_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_prescribing; Owner: -
--

ALTER TABLE lu_generics ALTER COLUMN pk SET DEFAULT nextval('lu_generics_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_prescribing; Owner: -
--

ALTER TABLE lu_instruction_habits ALTER COLUMN pk SET DEFAULT nextval('lu_instruction_habits_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_prescribing; Owner: -
--

ALTER TABLE lu_instructions ALTER COLUMN pk SET DEFAULT nextval('lu_instructions_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_prescribing; Owner: -
--

ALTER TABLE lu_next_authority_number ALTER COLUMN pk SET DEFAULT nextval('lu_next_authority_number_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_prescribing; Owner: -
--

ALTER TABLE lu_pbs_status ALTER COLUMN pk SET DEFAULT nextval('lu_pbs_status_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_prescribing; Owner: -
--

ALTER TABLE medication_audit_reasons ALTER COLUMN pk SET DEFAULT nextval('medication_audit_reasons_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_prescribing; Owner: -
--

ALTER TABLE medication_audit_trail ALTER COLUMN pk SET DEFAULT nextval('medication_audit_trail_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_prescribing; Owner: -
--

ALTER TABLE medications ALTER COLUMN pk SET DEFAULT nextval('medications_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_prescribing; Owner: -
--

ALTER TABLE pack_details ALTER COLUMN pk SET DEFAULT nextval('pack_details_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_prescribing; Owner: -
--

ALTER TABLE script_dates ALTER COLUMN pk SET DEFAULT nextval('script_dates_pk_seq'::regclass);


SET search_path = clin_procedures, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: clin_procedures; Owner: -
--

ALTER TABLE link_images_procedures ALTER COLUMN pk SET DEFAULT nextval('link_images_procedures_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_procedures; Owner: -
--

ALTER TABLE lu_anaesthetic_agent ALTER COLUMN pk SET DEFAULT nextval('lu_anaesthetic_agent_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_procedures; Owner: -
--

ALTER TABLE lu_complications ALTER COLUMN pk SET DEFAULT nextval('lu_complications_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_procedures; Owner: -
--

ALTER TABLE lu_last_surgical_pack ALTER COLUMN pk SET DEFAULT nextval('lu_pack_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_procedures; Owner: -
--

ALTER TABLE lu_procedure_type ALTER COLUMN pk SET DEFAULT nextval('lu_excision_type_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_procedures; Owner: -
--

ALTER TABLE lu_repair_type ALTER COLUMN pk SET DEFAULT nextval('lu_repair_type_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_procedures; Owner: -
--

ALTER TABLE lu_skin_preparation ALTER COLUMN pk SET DEFAULT nextval('lu_skin_preparation_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_procedures; Owner: -
--

ALTER TABLE lu_suture_site ALTER COLUMN pk SET DEFAULT nextval('lu_suture_site_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_procedures; Owner: -
--

ALTER TABLE lu_suture_type ALTER COLUMN pk SET DEFAULT nextval('lu_suture_type_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_procedures; Owner: -
--

ALTER TABLE skin_procedures ALTER COLUMN pk SET DEFAULT nextval('skin_procedures_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_procedures; Owner: -
--

ALTER TABLE staff_skin_procedure_defaults ALTER COLUMN pk SET DEFAULT nextval('staff_skin_procedure_defaults_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_procedures; Owner: -
--

ALTER TABLE surgical_packs ALTER COLUMN pk SET DEFAULT nextval('surgical_packs_pk_seq'::regclass);


SET search_path = clin_recalls, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: clin_recalls; Owner: -
--

ALTER TABLE forms ALTER COLUMN pk SET DEFAULT nextval('forms_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_recalls; Owner: -
--

ALTER TABLE links_forms ALTER COLUMN pk SET DEFAULT nextval('links_forms_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_recalls; Owner: -
--

ALTER TABLE lu_reasons ALTER COLUMN pk SET DEFAULT nextval('lu_reasons_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_recalls; Owner: -
--

ALTER TABLE lu_recall_intervals ALTER COLUMN pk SET DEFAULT nextval('lu_recall_intervals_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_recalls; Owner: -
--

ALTER TABLE lu_status ALTER COLUMN pk SET DEFAULT nextval('lu_status_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_recalls; Owner: -
--

ALTER TABLE lu_templates ALTER COLUMN pk SET DEFAULT nextval('lu_templates_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_recalls; Owner: -
--

ALTER TABLE recalls ALTER COLUMN pk SET DEFAULT nextval('recalls_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_recalls; Owner: -
--

ALTER TABLE sent ALTER COLUMN pk SET DEFAULT nextval('sent_pk_seq'::regclass);


SET search_path = clin_referrals, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: clin_referrals; Owner: -
--

ALTER TABLE inbox ALTER COLUMN pk SET DEFAULT nextval('inbox_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_referrals; Owner: -
--

ALTER TABLE link_referral_condition ALTER COLUMN pk SET DEFAULT nextval('link_referral_condition_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_referrals; Owner: -
--

ALTER TABLE lu_type ALTER COLUMN pk SET DEFAULT nextval('lu_type_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_referrals; Owner: -
--

ALTER TABLE referrals ALTER COLUMN pk SET DEFAULT nextval('referrals_pk_seq'::regclass);


SET search_path = clin_requests, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: clin_requests; Owner: -
--

ALTER TABLE forms ALTER COLUMN pk SET DEFAULT nextval('forms_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_requests; Owner: -
--

ALTER TABLE forms_requests ALTER COLUMN pk SET DEFAULT nextval('forms_requests_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_requests; Owner: -
--

ALTER TABLE link_forms_requests_requests_results ALTER COLUMN pk SET DEFAULT nextval('link_forms_requests_requests_results_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_requests; Owner: -
--

ALTER TABLE lu_copyto_type ALTER COLUMN pk SET DEFAULT nextval('lu_copyto_type_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_requests; Owner: -
--

ALTER TABLE lu_form_header ALTER COLUMN pk SET DEFAULT nextval('lu_form_header_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_requests; Owner: -
--

ALTER TABLE lu_instructions ALTER COLUMN pk SET DEFAULT nextval('lu_instructions_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_requests; Owner: -
--

ALTER TABLE lu_link_provider_user_requests ALTER COLUMN pk SET DEFAULT nextval('lu_link_provider_user_requests_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_requests; Owner: -
--

ALTER TABLE lu_request_type ALTER COLUMN pk SET DEFAULT nextval('lu_request_type_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_requests; Owner: -
--

ALTER TABLE lu_requests ALTER COLUMN pk SET DEFAULT nextval('lu_requests_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_requests; Owner: -
--

ALTER TABLE lu_type ALTER COLUMN pk SET DEFAULT nextval('lu_type_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_requests; Owner: -
--

ALTER TABLE notes ALTER COLUMN pk SET DEFAULT nextval('notes_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_requests; Owner: -
--

ALTER TABLE request_providers ALTER COLUMN pk SET DEFAULT nextval('request_providers_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_requests; Owner: -
--

ALTER TABLE user_default_type ALTER COLUMN pk SET DEFAULT nextval('user_default_type_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_requests; Owner: -
--

ALTER TABLE user_provider_defaults ALTER COLUMN pk SET DEFAULT nextval('user_provider_defaults_pk_seq'::regclass);


SET search_path = clin_vaccination, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE last_batch_number ALTER COLUMN pk SET DEFAULT nextval('last_batch_number_pk_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE link_provider_site_admininstered ALTER COLUMN id SET DEFAULT nextval('link_provider_site_admininstered_id_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE lu_indication ALTER COLUMN pk SET DEFAULT nextval('indication_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE lu_schedules ALTER COLUMN pk SET DEFAULT nextval('lu_schedules_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE lu_target ALTER COLUMN pk SET DEFAULT nextval('lu_target_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE lu_vaccines ALTER COLUMN pk SET DEFAULT nextval('vaccines_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE lu_vaccines_descriptions ALTER COLUMN pk SET DEFAULT nextval('vaccines_descriptions_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE lu_vaccines_in_schedule ALTER COLUMN pk SET DEFAULT nextval('vaccines_in_schedule_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: -
--

ALTER TABLE vaccinations ALTER COLUMN pk SET DEFAULT nextval('data_pk_seq'::regclass);


SET search_path = clin_workcover, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: clin_workcover; Owner: -
--

ALTER TABLE claims ALTER COLUMN pk SET DEFAULT nextval('claims_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_workcover; Owner: -
--

ALTER TABLE link_claim_documents ALTER COLUMN pk SET DEFAULT nextval('link_claim_documents_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_workcover; Owner: -
--

ALTER TABLE lu_caused_by_employment ALTER COLUMN pk SET DEFAULT nextval('lu_caused_by_employment_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_workcover; Owner: -
--

ALTER TABLE lu_visit_type ALTER COLUMN pk SET DEFAULT nextval('lu_visit_type_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_workcover; Owner: -
--

ALTER TABLE visits ALTER COLUMN pk SET DEFAULT nextval('visits_pk_seq'::regclass);


SET search_path = coding, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: coding; Owner: -
--

ALTER TABLE lu_loinc_abbrev ALTER COLUMN pk SET DEFAULT nextval('lu_loinc_abbrev_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: coding; Owner: -
--

ALTER TABLE lu_systems ALTER COLUMN pk SET DEFAULT nextval('lu_systems_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: coding; Owner: -
--

ALTER TABLE usr_codes_weighting ALTER COLUMN pk SET DEFAULT nextval('usr_codes_weighting_pk_seq'::regclass);


SET search_path = common, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: -
--

ALTER TABLE lu_aboriginality ALTER COLUMN pk SET DEFAULT nextval('lu_aboriginality_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: -
--

ALTER TABLE lu_anatomical_localisation ALTER COLUMN pk SET DEFAULT nextval('lu_anatomical_location_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: -
--

ALTER TABLE lu_anatomical_site ALTER COLUMN pk SET DEFAULT nextval('lu_anatomical_site_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: -
--

ALTER TABLE lu_anterior_posterior ALTER COLUMN pk SET DEFAULT nextval('lu_anterior_posterior_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: -
--

ALTER TABLE lu_companion_status ALTER COLUMN pk SET DEFAULT nextval('lu_companion_status_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: -
--

ALTER TABLE lu_countries ALTER COLUMN pk SET DEFAULT nextval('lu_countries_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: -
--

ALTER TABLE lu_ethnicity ALTER COLUMN pk SET DEFAULT nextval('lu_ethnicity_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: -
--

ALTER TABLE lu_family_relationships ALTER COLUMN pk SET DEFAULT nextval('lu_family_relationships_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: -
--

ALTER TABLE lu_formulation ALTER COLUMN pk SET DEFAULT nextval('lu_formulation_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: -
--

ALTER TABLE lu_hearing_aid_status ALTER COLUMN pk SET DEFAULT nextval('lu_hearing_aid_status_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: -
--

ALTER TABLE lu_languages ALTER COLUMN pk SET DEFAULT nextval('lu_languages_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: -
--

ALTER TABLE lu_laterality ALTER COLUMN pk SET DEFAULT nextval('lu_laterality_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: -
--

ALTER TABLE lu_medicolegal ALTER COLUMN pk SET DEFAULT nextval('lu_medicolegal_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: -
--

ALTER TABLE lu_motion ALTER COLUMN pk SET DEFAULT nextval('lu_motion_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: -
--

ALTER TABLE lu_normality ALTER COLUMN pk SET DEFAULT nextval('lu_normality_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: -
--

ALTER TABLE lu_occupations ALTER COLUMN pk SET DEFAULT nextval('lu_occupations_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: -
--

ALTER TABLE lu_occupations_bak ALTER COLUMN pk SET DEFAULT nextval('lu_occupations_bak_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: -
--

ALTER TABLE lu_proximal_distal ALTER COLUMN pk SET DEFAULT nextval('lu_proximal_distal_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: -
--

ALTER TABLE lu_recreationaldrugs ALTER COLUMN pk SET DEFAULT nextval('lu_recreationaldrugs_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: -
--

ALTER TABLE lu_religions ALTER COLUMN pk SET DEFAULT nextval('lu_religions_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: -
--

ALTER TABLE lu_route_administration ALTER COLUMN pk SET DEFAULT nextval('lu_route_administration_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: -
--

ALTER TABLE lu_seasons ALTER COLUMN pk SET DEFAULT nextval('lu_seasons_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: -
--

ALTER TABLE lu_site_administration ALTER COLUMN pk SET DEFAULT nextval('lu_site_administration_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: -
--

ALTER TABLE lu_smoking_status ALTER COLUMN pk SET DEFAULT nextval('lu_smoking_status_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: -
--

ALTER TABLE lu_social_support ALTER COLUMN pk SET DEFAULT nextval('lu_social_support_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: -
--

ALTER TABLE lu_sub_religions ALTER COLUMN pk SET DEFAULT nextval('lu_sub_religions_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: -
--

ALTER TABLE lu_units ALTER COLUMN pk SET DEFAULT nextval('lu_units_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: -
--

ALTER TABLE lu_urgency ALTER COLUMN pk SET DEFAULT nextval('lu_urgency_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: -
--

ALTER TABLE lu_whisper_test ALTER COLUMN pk SET DEFAULT nextval('lu_whisper_test_pk_seq'::regclass);


SET search_path = contacts, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: -
--

ALTER TABLE data_addresses ALTER COLUMN pk SET DEFAULT nextval('data_addresses_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: -
--

ALTER TABLE data_branches ALTER COLUMN pk SET DEFAULT nextval('data_branches_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: -
--

ALTER TABLE data_communications ALTER COLUMN pk SET DEFAULT nextval('data_communications_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: -
--

ALTER TABLE data_employees ALTER COLUMN pk SET DEFAULT nextval('data_employees_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: -
--

ALTER TABLE data_organisations ALTER COLUMN pk SET DEFAULT nextval('data_organisations_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: -
--

ALTER TABLE data_persons ALTER COLUMN pk SET DEFAULT nextval('data_persons_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: -
--

ALTER TABLE images ALTER COLUMN pk SET DEFAULT nextval('images_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: -
--

ALTER TABLE links_branches_comms ALTER COLUMN pk SET DEFAULT nextval('links_branches_comms_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: -
--

ALTER TABLE links_employees_comms ALTER COLUMN pk SET DEFAULT nextval('links_employees_comms_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: -
--

ALTER TABLE links_persons_addresses ALTER COLUMN pk SET DEFAULT nextval('links_persons_addresses_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: -
--

ALTER TABLE links_persons_comms ALTER COLUMN pk SET DEFAULT nextval('links_persons_comms_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: -
--

ALTER TABLE lu_address_types ALTER COLUMN pk SET DEFAULT nextval('lu_address_types_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: -
--

ALTER TABLE lu_categories ALTER COLUMN pk SET DEFAULT nextval('lu_categories_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: -
--

ALTER TABLE lu_contact_type ALTER COLUMN pk SET DEFAULT nextval('lu_contact_type_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: -
--

ALTER TABLE lu_employee_status ALTER COLUMN pk SET DEFAULT nextval('lu_employee_status_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: -
--

ALTER TABLE lu_firstnames ALTER COLUMN pk SET DEFAULT nextval('lu_firstnames_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: -
--

ALTER TABLE lu_marital ALTER COLUMN pk SET DEFAULT nextval('lu_marital_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: -
--

ALTER TABLE lu_misspelt_towns ALTER COLUMN pk SET DEFAULT nextval('lu_mismatched_towns_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: -
--

ALTER TABLE lu_sex ALTER COLUMN pk SET DEFAULT nextval('lu_sex_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: -
--

ALTER TABLE lu_surnames ALTER COLUMN pk SET DEFAULT nextval('lu_surnames_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: -
--

ALTER TABLE lu_title ALTER COLUMN pk SET DEFAULT nextval('lu_title_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: -
--

ALTER TABLE lu_towns ALTER COLUMN pk SET DEFAULT nextval('lu_towns_pk_seq'::regclass);


SET search_path = db, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: db; Owner: -
--

ALTER TABLE lu_version ALTER COLUMN pk SET DEFAULT nextval('db_version_pk_seq'::regclass);


SET search_path = defaults, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: defaults; Owner: -
--

ALTER TABLE hl7_inboxes ALTER COLUMN pk SET DEFAULT nextval('hl7_message_destination_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: defaults; Owner: -
--

ALTER TABLE incoming_message_handling ALTER COLUMN pk SET DEFAULT nextval('incoming_message_handling_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: defaults; Owner: -
--

ALTER TABLE lu_link_printer_task ALTER COLUMN pk SET DEFAULT nextval('lu_link_printer_task_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: defaults; Owner: -
--

ALTER TABLE lu_message_display_style ALTER COLUMN pk SET DEFAULT nextval('lu_message_display_style_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: defaults; Owner: -
--

ALTER TABLE lu_message_standard ALTER COLUMN pk SET DEFAULT nextval('lu_message_standard_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: defaults; Owner: -
--

ALTER TABLE lu_printer_host ALTER COLUMN pk SET DEFAULT nextval('lu_printer_host_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: defaults; Owner: -
--

ALTER TABLE lu_printer_task ALTER COLUMN pk SET DEFAULT nextval('lu_printer_task_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: defaults; Owner: -
--

ALTER TABLE script_coordinates ALTER COLUMN pk SET DEFAULT nextval('script_coordinates_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: defaults; Owner: -
--

ALTER TABLE temp ALTER COLUMN pk SET DEFAULT nextval('temp_pk_seq'::regclass);


SET search_path = documents, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: documents; Owner: -
--

ALTER TABLE copies_to ALTER COLUMN pk SET DEFAULT nextval('copies_to_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: documents; Owner: -
--

ALTER TABLE documents ALTER COLUMN pk SET DEFAULT nextval('documents_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: documents; Owner: -
--

ALTER TABLE link_document_action ALTER COLUMN pk SET DEFAULT nextval('link_document_action_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: documents; Owner: -
--

ALTER TABLE link_document_task ALTER COLUMN pk SET DEFAULT nextval('staff_tasks_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: documents; Owner: -
--

ALTER TABLE lu_archive_site ALTER COLUMN pk SET DEFAULT nextval('lu_archive_site_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: documents; Owner: -
--

ALTER TABLE lu_display_as ALTER COLUMN pk SET DEFAULT nextval('lu_display_as_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: documents; Owner: -
--

ALTER TABLE lu_message_display_style ALTER COLUMN pk SET DEFAULT nextval('lu_message_display_style_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: documents; Owner: -
--

ALTER TABLE lu_message_standard ALTER COLUMN pk SET DEFAULT nextval('lu_message_standard_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: documents; Owner: -
--

ALTER TABLE lu_stakeholder_type ALTER COLUMN pk SET DEFAULT nextval('lu_stakeholder_type_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: documents; Owner: -
--

ALTER TABLE lu_stakeholders ALTER COLUMN pk SET DEFAULT nextval('lu_stakeholders_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: documents; Owner: -
--

ALTER TABLE lu_type ALTER COLUMN pk SET DEFAULT nextval('lu_type_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: documents; Owner: -
--

ALTER TABLE observations ALTER COLUMN pk SET DEFAULT nextval('observations_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: documents; Owner: -
--

ALTER TABLE sending_entities ALTER COLUMN pk SET DEFAULT nextval('sending_entities_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: documents; Owner: -
--

ALTER TABLE signed_off ALTER COLUMN pk SET DEFAULT nextval('signed_off_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: documents; Owner: -
--

ALTER TABLE stakeholders ALTER COLUMN pk SET DEFAULT nextval('stakeholders_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: documents; Owner: -
--

ALTER TABLE unmatched_patients ALTER COLUMN pk SET DEFAULT nextval('unmatched_patients_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: documents; Owner: -
--

ALTER TABLE unmatched_staff ALTER COLUMN pk SET DEFAULT nextval('unmatched_staff_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: documents; Owner: -
--

ALTER TABLE unmatched_types ALTER COLUMN pk SET DEFAULT nextval('unmatched_types_pk_seq'::regclass);


SET search_path = drugs, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: drugs; Owner: -
--

ALTER TABLE clinical_effects ALTER COLUMN pk SET DEFAULT nextval('clinical_effects_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: drugs; Owner: -
--

ALTER TABLE disease_code ALTER COLUMN pk SET DEFAULT nextval('disease_code_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: drugs; Owner: -
--

ALTER TABLE evidence_levels ALTER COLUMN pk SET DEFAULT nextval('evidence_levels_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: drugs; Owner: -
--

ALTER TABLE flags ALTER COLUMN pk SET DEFAULT nextval('flags_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: drugs; Owner: -
--

ALTER TABLE info ALTER COLUMN pk SET DEFAULT nextval('info_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: drugs; Owner: -
--

ALTER TABLE manufacturer ALTER COLUMN pk SET DEFAULT nextval('manufacturer_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: drugs; Owner: -
--

ALTER TABLE patient_categories ALTER COLUMN pk SET DEFAULT nextval('patient_categories_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: drugs; Owner: -
--

ALTER TABLE pharmacologic_mechanisms ALTER COLUMN pk SET DEFAULT nextval('pharmacologic_mechanisms_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: drugs; Owner: -
--

ALTER TABLE product ALTER COLUMN pk SET DEFAULT nextval('product_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: drugs; Owner: -
--

ALTER TABLE severity_level ALTER COLUMN pk SET DEFAULT nextval('severity_level_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: drugs; Owner: -
--

ALTER TABLE sources ALTER COLUMN pk SET DEFAULT nextval('sources_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: drugs; Owner: -
--

ALTER TABLE topic ALTER COLUMN pk SET DEFAULT nextval('topic_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: drugs; Owner: -
--

ALTER TABLE units ALTER COLUMN pk SET DEFAULT nextval('units_pk_seq'::regclass);


SET search_path = import_export, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: import_export; Owner: -
--

ALTER TABLE lu_demographics_field_templates ALTER COLUMN pk SET DEFAULT nextval('lu_demographics_field_templates_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: import_export; Owner: -
--

ALTER TABLE lu_source_program ALTER COLUMN pk SET DEFAULT nextval('lu_source_program_pk_seq'::regclass);


SET search_path = public, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE all_images ALTER COLUMN pk SET DEFAULT nextval('all_images_pk_seq'::regclass);


SET search_path = admin, pg_catalog;

--
-- Name: clinic_pkey; Type: CONSTRAINT; Schema: admin; Owner: -; Tablespace: 
--

ALTER TABLE ONLY clinics
    ADD CONSTRAINT clinic_pkey PRIMARY KEY (pk);


--
-- Name: clinic_rooms_pkey; Type: CONSTRAINT; Schema: admin; Owner: -; Tablespace: 
--

ALTER TABLE ONLY clinic_rooms
    ADD CONSTRAINT clinic_rooms_pkey PRIMARY KEY (pk);


--
-- Name: global_preferences_fk_clinic_key; Type: CONSTRAINT; Schema: admin; Owner: -; Tablespace: 
--

ALTER TABLE ONLY global_preferences
    ADD CONSTRAINT global_preferences_fk_clinic_key UNIQUE (fk_clinic, name);


--
-- Name: global_preferences_pkey; Type: CONSTRAINT; Schema: admin; Owner: -; Tablespace: 
--

ALTER TABLE ONLY global_preferences
    ADD CONSTRAINT global_preferences_pkey PRIMARY KEY (pk);


--
-- Name: link_staff_clinics_pkey; Type: CONSTRAINT; Schema: admin; Owner: -; Tablespace: 
--

ALTER TABLE ONLY link_staff_clinics
    ADD CONSTRAINT link_staff_clinics_pkey PRIMARY KEY (pk);


--
-- Name: lu_staff_roles_pkey; Type: CONSTRAINT; Schema: admin; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_staff_roles
    ADD CONSTRAINT lu_staff_roles_pkey PRIMARY KEY (pk);


--
-- Name: lu_staff_status_pkey; Type: CONSTRAINT; Schema: admin; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_staff_status
    ADD CONSTRAINT lu_staff_status_pkey PRIMARY KEY (pk);


--
-- Name: lu_staff_type_pkey; Type: CONSTRAINT; Schema: admin; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_staff_type
    ADD CONSTRAINT lu_staff_type_pkey PRIMARY KEY (pk);


--
-- Name: staff_pkey; Type: CONSTRAINT; Schema: admin; Owner: -; Tablespace: 
--

ALTER TABLE ONLY staff
    ADD CONSTRAINT staff_pkey PRIMARY KEY (pk);


SET search_path = audit, pg_catalog;

--
-- Name: audit_pkey; Type: CONSTRAINT; Schema: audit; Owner: -; Tablespace: 
--

ALTER TABLE ONLY audit
    ADD CONSTRAINT audit_pkey PRIMARY KEY (pk);


--
-- Name: lu_actions_pkey; Type: CONSTRAINT; Schema: audit; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_status
    ADD CONSTRAINT lu_actions_pkey PRIMARY KEY (pk);


--
-- Name: lu_actions_pkey1; Type: CONSTRAINT; Schema: audit; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_actions
    ADD CONSTRAINT lu_actions_pkey1 PRIMARY KEY (pk);


--
-- Name: lu_reasons_pkey; Type: CONSTRAINT; Schema: audit; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_reasons
    ADD CONSTRAINT lu_reasons_pkey PRIMARY KEY (pk);


--
-- Name: lu_schemas_pkey; Type: CONSTRAINT; Schema: audit; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_schemas
    ADD CONSTRAINT lu_schemas_pkey PRIMARY KEY (pk);


--
-- Name: lu_tables_pkey; Type: CONSTRAINT; Schema: audit; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_tables
    ADD CONSTRAINT lu_tables_pkey PRIMARY KEY (pk);


SET search_path = blobs, pg_catalog;

--
-- Name: blobs_pkey; Type: CONSTRAINT; Schema: blobs; Owner: -; Tablespace: 
--

ALTER TABLE ONLY blobs
    ADD CONSTRAINT blobs_pkey PRIMARY KEY (pk);


SET search_path = clerical, pg_catalog;

--
-- Name: data_families_pkey; Type: CONSTRAINT; Schema: clerical; Owner: -; Tablespace: 
--

ALTER TABLE ONLY data_families
    ADD CONSTRAINT data_families_pkey PRIMARY KEY (pk);


--
-- Name: data_family_members_pkey; Type: CONSTRAINT; Schema: clerical; Owner: -; Tablespace: 
--

ALTER TABLE ONLY data_family_members
    ADD CONSTRAINT data_family_members_pkey PRIMARY KEY (pk);


--
-- Name: data_patients_fk_person_key; Type: CONSTRAINT; Schema: clerical; Owner: -; Tablespace: 
--

ALTER TABLE ONLY data_patients
    ADD CONSTRAINT data_patients_fk_person_key UNIQUE (fk_person);


--
-- Name: data_patients_pkey; Type: CONSTRAINT; Schema: clerical; Owner: -; Tablespace: 
--

ALTER TABLE ONLY data_patients
    ADD CONSTRAINT data_patients_pkey PRIMARY KEY (pk);


--
-- Name: lu_task_types_pkey; Type: CONSTRAINT; Schema: clerical; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_task_types
    ADD CONSTRAINT lu_task_types_pkey PRIMARY KEY (pk);


--
-- Name: task_component_notes_pkey; Type: CONSTRAINT; Schema: clerical; Owner: -; Tablespace: 
--

ALTER TABLE ONLY task_component_notes
    ADD CONSTRAINT task_component_notes_pkey PRIMARY KEY (pk);


--
-- Name: task_components_pkey; Type: CONSTRAINT; Schema: clerical; Owner: -; Tablespace: 
--

ALTER TABLE ONLY task_components
    ADD CONSTRAINT task_components_pkey PRIMARY KEY (pk);


--
-- Name: tasks_pkey; Type: CONSTRAINT; Schema: clerical; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (pk);


SET search_path = clin_allergies, pg_catalog;

--
-- Name: allergies_pkey; Type: CONSTRAINT; Schema: clin_allergies; Owner: -; Tablespace: 
--

ALTER TABLE ONLY allergies
    ADD CONSTRAINT allergies_pkey PRIMARY KEY (pk);


--
-- Name: lu_reaction_pkey; Type: CONSTRAINT; Schema: clin_allergies; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_reaction
    ADD CONSTRAINT lu_reaction_pkey PRIMARY KEY (pk);


--
-- Name: lu_type_pkey; Type: CONSTRAINT; Schema: clin_allergies; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_type
    ADD CONSTRAINT lu_type_pkey PRIMARY KEY (pk);


SET search_path = clin_careplans, pg_catalog;

--
-- Name: careplan_pages_pkey1; Type: CONSTRAINT; Schema: clin_careplans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY careplan_pages
    ADD CONSTRAINT careplan_pages_pkey1 PRIMARY KEY (pk);


--
-- Name: careplans_pkey; Type: CONSTRAINT; Schema: clin_careplans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY careplans
    ADD CONSTRAINT careplans_pkey PRIMARY KEY (pk);


--
-- Name: component_task_due_pkey; Type: CONSTRAINT; Schema: clin_careplans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY component_task_due
    ADD CONSTRAINT component_task_due_pkey PRIMARY KEY (pk);


--
-- Name: link_careplanpage_advice_pkey; Type: CONSTRAINT; Schema: clin_careplans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY link_careplanpage_advice
    ADD CONSTRAINT link_careplanpage_advice_pkey PRIMARY KEY (pk);


--
-- Name: link_careplanpage_components_pkey; Type: CONSTRAINT; Schema: clin_careplans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY link_careplanpage_components
    ADD CONSTRAINT link_careplanpage_components_pkey PRIMARY KEY (pk);


--
-- Name: link_careplanpages_careplan_pkey; Type: CONSTRAINT; Schema: clin_careplans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY link_careplanpages_careplan
    ADD CONSTRAINT link_careplanpages_careplan_pkey PRIMARY KEY (pk);


--
-- Name: lu_advice_pkey; Type: CONSTRAINT; Schema: clin_careplans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_advice
    ADD CONSTRAINT lu_advice_pkey PRIMARY KEY (pk);


--
-- Name: lu_aims_pkey; Type: CONSTRAINT; Schema: clin_careplans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_aims
    ADD CONSTRAINT lu_aims_pkey PRIMARY KEY (pk);


--
-- Name: lu_components_pkey; Type: CONSTRAINT; Schema: clin_careplans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_components
    ADD CONSTRAINT lu_components_pkey PRIMARY KEY (pk);


--
-- Name: lu_conditions_pkey; Type: CONSTRAINT; Schema: clin_careplans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_conditions
    ADD CONSTRAINT lu_conditions_pkey PRIMARY KEY (pk);


--
-- Name: lu_education_pkey; Type: CONSTRAINT; Schema: clin_careplans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_education
    ADD CONSTRAINT lu_education_pkey PRIMARY KEY (pk);


--
-- Name: lu_responsible_pkey; Type: CONSTRAINT; Schema: clin_careplans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_responsible
    ADD CONSTRAINT lu_responsible_pkey PRIMARY KEY (pk);


--
-- Name: lu_tasks_pkey; Type: CONSTRAINT; Schema: clin_careplans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_tasks
    ADD CONSTRAINT lu_tasks_pkey PRIMARY KEY (pk);


SET search_path = clin_certificates, pg_catalog;

--
-- Name: lu_illness_temporality_pkey; Type: CONSTRAINT; Schema: clin_certificates; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_illness_temporality
    ADD CONSTRAINT lu_illness_temporality_pkey PRIMARY KEY (pk);


--
-- Name: medical_certificate_pkey; Type: CONSTRAINT; Schema: clin_certificates; Owner: -; Tablespace: 
--

ALTER TABLE ONLY medical_certificate
    ADD CONSTRAINT medical_certificate_pkey PRIMARY KEY (pk);


SET search_path = clin_checkups, pg_catalog;

--
-- Name: annual_checkup_pkey; Type: CONSTRAINT; Schema: clin_checkups; Owner: -; Tablespace: 
--

ALTER TABLE ONLY annual_checkup
    ADD CONSTRAINT annual_checkup_pkey PRIMARY KEY (pk);


--
-- Name: lu_nutrition_questions_pkey; Type: CONSTRAINT; Schema: clin_checkups; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_nutrition_questions
    ADD CONSTRAINT lu_nutrition_questions_pkey PRIMARY KEY (pk);


--
-- Name: lu_state_of_health_pkey; Type: CONSTRAINT; Schema: clin_checkups; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_state_of_health
    ADD CONSTRAINT lu_state_of_health_pkey PRIMARY KEY (pk);


--
-- Name: over75_pkey; Type: CONSTRAINT; Schema: clin_checkups; Owner: -; Tablespace: 
--

ALTER TABLE ONLY over75
    ADD CONSTRAINT over75_pkey PRIMARY KEY (pk);


SET search_path = clin_consult, pg_catalog;

--
-- Name: consult_pkey; Type: CONSTRAINT; Schema: clin_consult; Owner: -; Tablespace: 
--

ALTER TABLE ONLY consult
    ADD CONSTRAINT consult_pkey PRIMARY KEY (pk);


--
-- Name: images_pkey; Type: CONSTRAINT; Schema: clin_consult; Owner: -; Tablespace: 
--

ALTER TABLE ONLY images
    ADD CONSTRAINT images_pkey PRIMARY KEY (pk);


--
-- Name: lu_consult_type_pkey; Type: CONSTRAINT; Schema: clin_consult; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_consult_type
    ADD CONSTRAINT lu_consult_type_pkey PRIMARY KEY (pk);


--
-- Name: lu_progressnotes_sections_pkey; Type: CONSTRAINT; Schema: clin_consult; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_progressnotes_sections
    ADD CONSTRAINT lu_progressnotes_sections_pkey PRIMARY KEY (pk);


--
-- Name: lu_status_pkey; Type: CONSTRAINT; Schema: clin_consult; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_scratchpad_status
    ADD CONSTRAINT lu_status_pkey PRIMARY KEY (pk);


--
-- Name: progressnotes_pkey; Type: CONSTRAINT; Schema: clin_consult; Owner: -; Tablespace: 
--

ALTER TABLE ONLY progressnotes
    ADD CONSTRAINT progressnotes_pkey PRIMARY KEY (pk);


--
-- Name: scratchpad_pkey; Type: CONSTRAINT; Schema: clin_consult; Owner: -; Tablespace: 
--

ALTER TABLE ONLY scratchpad
    ADD CONSTRAINT scratchpad_pkey PRIMARY KEY (pk);


SET search_path = clin_history, pg_catalog;

--
-- Name: care_plan_components_due_pkey; Type: CONSTRAINT; Schema: clin_history; Owner: -; Tablespace: 
--

ALTER TABLE ONLY care_plan_components_due
    ADD CONSTRAINT care_plan_components_due_pkey PRIMARY KEY (pk);


--
-- Name: data_recreational_drugs_pkey; Type: CONSTRAINT; Schema: clin_history; Owner: -; Tablespace: 
--

ALTER TABLE ONLY data_recreational_drugs
    ADD CONSTRAINT data_recreational_drugs_pkey PRIMARY KEY (pk);


--
-- Name: family_conditions_pkey; Type: CONSTRAINT; Schema: clin_history; Owner: -; Tablespace: 
--

ALTER TABLE ONLY family_conditions
    ADD CONSTRAINT family_conditions_pkey PRIMARY KEY (pk);


--
-- Name: family_links_pkey; Type: CONSTRAINT; Schema: clin_history; Owner: -; Tablespace: 
--

ALTER TABLE ONLY family_links
    ADD CONSTRAINT family_links_pkey PRIMARY KEY (pk);


--
-- Name: family_members_pkey; Type: CONSTRAINT; Schema: clin_history; Owner: -; Tablespace: 
--

ALTER TABLE ONLY family_members
    ADD CONSTRAINT family_members_pkey PRIMARY KEY (pk);


--
-- Name: hospitalisations_pkey; Type: CONSTRAINT; Schema: clin_history; Owner: -; Tablespace: 
--

ALTER TABLE ONLY hospitalisations
    ADD CONSTRAINT hospitalisations_pkey PRIMARY KEY (pk);


--
-- Name: lu_careplan_components_pkey; Type: CONSTRAINT; Schema: clin_history; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_careplan_components
    ADD CONSTRAINT lu_careplan_components_pkey PRIMARY KEY (pk);


--
-- Name: lu_dacc_components_pkey; Type: CONSTRAINT; Schema: clin_history; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_dacc_components
    ADD CONSTRAINT lu_dacc_components_pkey PRIMARY KEY (pk);


--
-- Name: lu_exposures_pkey; Type: CONSTRAINT; Schema: clin_history; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_exposures
    ADD CONSTRAINT lu_exposures_pkey PRIMARY KEY (pk);


--
-- Name: occupational_history_pkey; Type: CONSTRAINT; Schema: clin_history; Owner: -; Tablespace: 
--

ALTER TABLE ONLY occupational_history
    ADD CONSTRAINT occupational_history_pkey PRIMARY KEY (pk);


--
-- Name: occupations_exposures_pkey; Type: CONSTRAINT; Schema: clin_history; Owner: -; Tablespace: 
--

ALTER TABLE ONLY occupations_exposures
    ADD CONSTRAINT occupations_exposures_pkey PRIMARY KEY (pk);


--
-- Name: past_history_pkey; Type: CONSTRAINT; Schema: clin_history; Owner: -; Tablespace: 
--

ALTER TABLE ONLY past_history
    ADD CONSTRAINT past_history_pkey PRIMARY KEY (pk);


--
-- Name: social_history_pkey; Type: CONSTRAINT; Schema: clin_history; Owner: -; Tablespace: 
--

ALTER TABLE ONLY social_history
    ADD CONSTRAINT social_history_pkey PRIMARY KEY (pk);


--
-- Name: team_care_members_pkey; Type: CONSTRAINT; Schema: clin_history; Owner: -; Tablespace: 
--

ALTER TABLE ONLY team_care_members
    ADD CONSTRAINT team_care_members_pkey PRIMARY KEY (pk);


SET search_path = clin_measurements, pg_catalog;

--
-- Name: lu_type_pkey; Type: CONSTRAINT; Schema: clin_measurements; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_type
    ADD CONSTRAINT lu_type_pkey PRIMARY KEY (pk);


--
-- Name: measurements_pkey; Type: CONSTRAINT; Schema: clin_measurements; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measurements
    ADD CONSTRAINT measurements_pkey PRIMARY KEY (pk);


--
-- Name: patients_defaults_pkey; Type: CONSTRAINT; Schema: clin_measurements; Owner: -; Tablespace: 
--

ALTER TABLE ONLY patients_defaults
    ADD CONSTRAINT patients_defaults_pkey PRIMARY KEY (pk);


SET search_path = clin_mentalhealth, pg_catalog;

--
-- Name: k10_results_pkey; Type: CONSTRAINT; Schema: clin_mentalhealth; Owner: -; Tablespace: 
--

ALTER TABLE ONLY k10_results
    ADD CONSTRAINT k10_results_pkey PRIMARY KEY (pk);


--
-- Name: lu_assessment_tools_pkey; Type: CONSTRAINT; Schema: clin_mentalhealth; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_assessment_tools
    ADD CONSTRAINT lu_assessment_tools_pkey PRIMARY KEY (pk_tool);


--
-- Name: lu_component_help_pkey; Type: CONSTRAINT; Schema: clin_mentalhealth; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_component_help
    ADD CONSTRAINT lu_component_help_pkey PRIMARY KEY (pk);


--
-- Name: lu_depression_degree_pkey; Type: CONSTRAINT; Schema: clin_mentalhealth; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_depression_degree
    ADD CONSTRAINT lu_depression_degree_pkey PRIMARY KEY (pk);


--
-- Name: lu_k10_components_pkey; Type: CONSTRAINT; Schema: clin_mentalhealth; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_k10_components
    ADD CONSTRAINT lu_k10_components_pkey PRIMARY KEY (pk);


--
-- Name: lu_plan_type_pkey; Type: CONSTRAINT; Schema: clin_mentalhealth; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_plan_type
    ADD CONSTRAINT lu_plan_type_pkey PRIMARY KEY (pk);


--
-- Name: lu_risk_to_others_pkey; Type: CONSTRAINT; Schema: clin_mentalhealth; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_risk_to_others
    ADD CONSTRAINT lu_risk_to_others_pkey PRIMARY KEY (pk);


--
-- Name: mentalhealth_plan_pkey; Type: CONSTRAINT; Schema: clin_mentalhealth; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mentalhealth_plan
    ADD CONSTRAINT mentalhealth_plan_pkey PRIMARY KEY (pk);


--
-- Name: team_care_members_pkey; Type: CONSTRAINT; Schema: clin_mentalhealth; Owner: -; Tablespace: 
--

ALTER TABLE ONLY team_care_members
    ADD CONSTRAINT team_care_members_pkey PRIMARY KEY (pk);


SET search_path = clin_pregnancy, pg_catalog;

--
-- Name: lu_antenatal_venue_pkey; Type: CONSTRAINT; Schema: clin_pregnancy; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_antenatal_venue
    ADD CONSTRAINT lu_antenatal_venue_pkey PRIMARY KEY (pk);


SET search_path = clin_prescribing, pg_catalog;

--
-- Name: items_prescribed_pkey; Type: CONSTRAINT; Schema: clin_prescribing; Owner: -; Tablespace: 
--

ALTER TABLE ONLY items_prescribed
    ADD CONSTRAINT items_prescribed_pkey PRIMARY KEY (pk);


--
-- Name: link_generics_brands_pkey; Type: CONSTRAINT; Schema: clin_prescribing; Owner: -; Tablespace: 
--

ALTER TABLE ONLY link_generics_brands
    ADD CONSTRAINT link_generics_brands_pkey PRIMARY KEY (pk);


--
-- Name: lu_authority_indications_pkey; Type: CONSTRAINT; Schema: clin_prescribing; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_authority_indications
    ADD CONSTRAINT lu_authority_indications_pkey PRIMARY KEY (pk);


--
-- Name: lu_brand_pkey; Type: CONSTRAINT; Schema: clin_prescribing; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_brand
    ADD CONSTRAINT lu_brand_pkey PRIMARY KEY (pk);


--
-- Name: lu_generics_pkey; Type: CONSTRAINT; Schema: clin_prescribing; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_generics
    ADD CONSTRAINT lu_generics_pkey PRIMARY KEY (pk);


--
-- Name: lu_instruction_habits_pkey; Type: CONSTRAINT; Schema: clin_prescribing; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_instruction_habits
    ADD CONSTRAINT lu_instruction_habits_pkey PRIMARY KEY (pk);


--
-- Name: lu_instructions_pkey; Type: CONSTRAINT; Schema: clin_prescribing; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_instructions
    ADD CONSTRAINT lu_instructions_pkey PRIMARY KEY (pk);


--
-- Name: lu_next_authority_number_pkey; Type: CONSTRAINT; Schema: clin_prescribing; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_next_authority_number
    ADD CONSTRAINT lu_next_authority_number_pkey PRIMARY KEY (pk);


--
-- Name: lu_pbs_status_pkey; Type: CONSTRAINT; Schema: clin_prescribing; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_pbs_status
    ADD CONSTRAINT lu_pbs_status_pkey PRIMARY KEY (pk);


--
-- Name: medication_audit_reasons_pkey; Type: CONSTRAINT; Schema: clin_prescribing; Owner: -; Tablespace: 
--

ALTER TABLE ONLY medication_audit_reasons
    ADD CONSTRAINT medication_audit_reasons_pkey PRIMARY KEY (pk);


--
-- Name: medication_audit_trail_pkey; Type: CONSTRAINT; Schema: clin_prescribing; Owner: -; Tablespace: 
--

ALTER TABLE ONLY medication_audit_trail
    ADD CONSTRAINT medication_audit_trail_pkey PRIMARY KEY (pk);


--
-- Name: medications_pkey; Type: CONSTRAINT; Schema: clin_prescribing; Owner: -; Tablespace: 
--

ALTER TABLE ONLY medications
    ADD CONSTRAINT medications_pkey PRIMARY KEY (pk);


--
-- Name: script_dates_pkey; Type: CONSTRAINT; Schema: clin_prescribing; Owner: -; Tablespace: 
--

ALTER TABLE ONLY script_dates
    ADD CONSTRAINT script_dates_pkey PRIMARY KEY (pk);


SET search_path = clin_procedures, pg_catalog;

--
-- Name: link_images_procedures_pkey; Type: CONSTRAINT; Schema: clin_procedures; Owner: -; Tablespace: 
--

ALTER TABLE ONLY link_images_procedures
    ADD CONSTRAINT link_images_procedures_pkey PRIMARY KEY (pk);


--
-- Name: lu_anaesthetic_agent_pkey; Type: CONSTRAINT; Schema: clin_procedures; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_anaesthetic_agent
    ADD CONSTRAINT lu_anaesthetic_agent_pkey PRIMARY KEY (pk);


--
-- Name: lu_complications_pkey; Type: CONSTRAINT; Schema: clin_procedures; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_complications
    ADD CONSTRAINT lu_complications_pkey PRIMARY KEY (pk);


--
-- Name: lu_excision_type_pkey; Type: CONSTRAINT; Schema: clin_procedures; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_procedure_type
    ADD CONSTRAINT lu_excision_type_pkey PRIMARY KEY (pk);


--
-- Name: lu_pack_pkey; Type: CONSTRAINT; Schema: clin_procedures; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_last_surgical_pack
    ADD CONSTRAINT lu_pack_pkey PRIMARY KEY (pk);


--
-- Name: lu_repair_type_pkey; Type: CONSTRAINT; Schema: clin_procedures; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_repair_type
    ADD CONSTRAINT lu_repair_type_pkey PRIMARY KEY (pk);


--
-- Name: lu_skin_preparation_pkey; Type: CONSTRAINT; Schema: clin_procedures; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_skin_preparation
    ADD CONSTRAINT lu_skin_preparation_pkey PRIMARY KEY (pk);


--
-- Name: lu_suture_site_pkey; Type: CONSTRAINT; Schema: clin_procedures; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_suture_site
    ADD CONSTRAINT lu_suture_site_pkey PRIMARY KEY (pk);


--
-- Name: lu_suture_type_pkey; Type: CONSTRAINT; Schema: clin_procedures; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_suture_type
    ADD CONSTRAINT lu_suture_type_pkey PRIMARY KEY (pk);


--
-- Name: skin_procedures_pkey; Type: CONSTRAINT; Schema: clin_procedures; Owner: -; Tablespace: 
--

ALTER TABLE ONLY skin_procedures
    ADD CONSTRAINT skin_procedures_pkey PRIMARY KEY (pk);


--
-- Name: staff_skin_procedure_defaults_pkey; Type: CONSTRAINT; Schema: clin_procedures; Owner: -; Tablespace: 
--

ALTER TABLE ONLY staff_skin_procedure_defaults
    ADD CONSTRAINT staff_skin_procedure_defaults_pkey PRIMARY KEY (pk);


--
-- Name: surgical_packs_pkey; Type: CONSTRAINT; Schema: clin_procedures; Owner: -; Tablespace: 
--

ALTER TABLE ONLY surgical_packs
    ADD CONSTRAINT surgical_packs_pkey PRIMARY KEY (pk);


SET search_path = clin_recalls, pg_catalog;

--
-- Name: forms_pkey; Type: CONSTRAINT; Schema: clin_recalls; Owner: -; Tablespace: 
--

ALTER TABLE ONLY forms
    ADD CONSTRAINT forms_pkey PRIMARY KEY (pk);


--
-- Name: lu_reasons_pkey; Type: CONSTRAINT; Schema: clin_recalls; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_reasons
    ADD CONSTRAINT lu_reasons_pkey PRIMARY KEY (pk);


--
-- Name: lu_recall_intervals_pkey; Type: CONSTRAINT; Schema: clin_recalls; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_recall_intervals
    ADD CONSTRAINT lu_recall_intervals_pkey PRIMARY KEY (pk);


--
-- Name: lu_status_pkey; Type: CONSTRAINT; Schema: clin_recalls; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_status
    ADD CONSTRAINT lu_status_pkey PRIMARY KEY (pk);


--
-- Name: lu_templates_pkey; Type: CONSTRAINT; Schema: clin_recalls; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_templates
    ADD CONSTRAINT lu_templates_pkey PRIMARY KEY (pk);


--
-- Name: recalls_pkey; Type: CONSTRAINT; Schema: clin_recalls; Owner: -; Tablespace: 
--

ALTER TABLE ONLY recalls
    ADD CONSTRAINT recalls_pkey PRIMARY KEY (pk);


--
-- Name: sent_pkey; Type: CONSTRAINT; Schema: clin_recalls; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sent
    ADD CONSTRAINT sent_pkey PRIMARY KEY (pk);


SET search_path = clin_referrals, pg_catalog;

--
-- Name: inbox_pkey; Type: CONSTRAINT; Schema: clin_referrals; Owner: -; Tablespace: 
--

ALTER TABLE ONLY inbox
    ADD CONSTRAINT inbox_pkey PRIMARY KEY (pk);


--
-- Name: link_referral_condition_pkey; Type: CONSTRAINT; Schema: clin_referrals; Owner: -; Tablespace: 
--

ALTER TABLE ONLY link_referral_condition
    ADD CONSTRAINT link_referral_condition_pkey PRIMARY KEY (pk);


--
-- Name: lu_type_pkey; Type: CONSTRAINT; Schema: clin_referrals; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_type
    ADD CONSTRAINT lu_type_pkey PRIMARY KEY (pk);


--
-- Name: referrals_pkey; Type: CONSTRAINT; Schema: clin_referrals; Owner: -; Tablespace: 
--

ALTER TABLE ONLY referrals
    ADD CONSTRAINT referrals_pkey PRIMARY KEY (pk);


SET search_path = clin_requests, pg_catalog;

--
-- Name: forms_pkey; Type: CONSTRAINT; Schema: clin_requests; Owner: -; Tablespace: 
--

ALTER TABLE ONLY forms
    ADD CONSTRAINT forms_pkey PRIMARY KEY (pk);


--
-- Name: forms_requests_pkey; Type: CONSTRAINT; Schema: clin_requests; Owner: -; Tablespace: 
--

ALTER TABLE ONLY forms_requests
    ADD CONSTRAINT forms_requests_pkey PRIMARY KEY (pk);


--
-- Name: link_forms_requests_requests_results_pkey; Type: CONSTRAINT; Schema: clin_requests; Owner: -; Tablespace: 
--

ALTER TABLE ONLY link_forms_requests_requests_results
    ADD CONSTRAINT link_forms_requests_requests_results_pkey PRIMARY KEY (pk);


--
-- Name: lu_copyto_type_pkey; Type: CONSTRAINT; Schema: clin_requests; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_copyto_type
    ADD CONSTRAINT lu_copyto_type_pkey PRIMARY KEY (pk);


--
-- Name: lu_form_header_pkey; Type: CONSTRAINT; Schema: clin_requests; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_form_header
    ADD CONSTRAINT lu_form_header_pkey PRIMARY KEY (pk);


--
-- Name: lu_instructions_pkey; Type: CONSTRAINT; Schema: clin_requests; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_instructions
    ADD CONSTRAINT lu_instructions_pkey PRIMARY KEY (pk);


--
-- Name: lu_link_provider_user_requests_pkey; Type: CONSTRAINT; Schema: clin_requests; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_link_provider_user_requests
    ADD CONSTRAINT lu_link_provider_user_requests_pkey PRIMARY KEY (pk);


--
-- Name: lu_request_type_pkey; Type: CONSTRAINT; Schema: clin_requests; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_request_type
    ADD CONSTRAINT lu_request_type_pkey PRIMARY KEY (pk);


--
-- Name: lu_requests_pkey; Type: CONSTRAINT; Schema: clin_requests; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_requests
    ADD CONSTRAINT lu_requests_pkey PRIMARY KEY (pk);


--
-- Name: lu_type_pkey; Type: CONSTRAINT; Schema: clin_requests; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_type
    ADD CONSTRAINT lu_type_pkey PRIMARY KEY (pk);


--
-- Name: notes_pkey; Type: CONSTRAINT; Schema: clin_requests; Owner: -; Tablespace: 
--

ALTER TABLE ONLY notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (pk);


--
-- Name: request_providers_pkey; Type: CONSTRAINT; Schema: clin_requests; Owner: -; Tablespace: 
--

ALTER TABLE ONLY request_providers
    ADD CONSTRAINT request_providers_pkey PRIMARY KEY (pk);


--
-- Name: user_default_type_pkey; Type: CONSTRAINT; Schema: clin_requests; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_default_type
    ADD CONSTRAINT user_default_type_pkey PRIMARY KEY (pk);


--
-- Name: user_provider_defaults_pkey; Type: CONSTRAINT; Schema: clin_requests; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_provider_defaults
    ADD CONSTRAINT user_provider_defaults_pkey PRIMARY KEY (pk);


SET search_path = clin_vaccination, pg_catalog;

--
-- Name: data_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY vaccinations
    ADD CONSTRAINT data_pkey PRIMARY KEY (pk);


--
-- Name: indication_key; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_indication
    ADD CONSTRAINT indication_key UNIQUE (medical_name);


--
-- Name: last_batch_number_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY last_batch_number
    ADD CONSTRAINT last_batch_number_pkey PRIMARY KEY (pk);


--
-- Name: lu_indication_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_indication
    ADD CONSTRAINT lu_indication_pkey PRIMARY KEY (pk);


--
-- Name: lu_schedules_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_schedules
    ADD CONSTRAINT lu_schedules_pkey PRIMARY KEY (pk);


--
-- Name: lu_target_pkey1; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_target
    ADD CONSTRAINT lu_target_pkey1 PRIMARY KEY (pk);


--
-- Name: lu_vaccines_descriptions_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_vaccines_descriptions
    ADD CONSTRAINT lu_vaccines_descriptions_pkey PRIMARY KEY (pk);


--
-- Name: lu_vaccines_in_schedule_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_vaccines_in_schedule
    ADD CONSTRAINT lu_vaccines_in_schedule_pkey PRIMARY KEY (pk);


--
-- Name: lu_vaccines_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_vaccines
    ADD CONSTRAINT lu_vaccines_pkey PRIMARY KEY (pk);


SET search_path = clin_workcover, pg_catalog;

--
-- Name: claims_pkey; Type: CONSTRAINT; Schema: clin_workcover; Owner: -; Tablespace: 
--

ALTER TABLE ONLY claims
    ADD CONSTRAINT claims_pkey PRIMARY KEY (pk);


--
-- Name: link_claim_documents_pkey; Type: CONSTRAINT; Schema: clin_workcover; Owner: -; Tablespace: 
--

ALTER TABLE ONLY link_claim_documents
    ADD CONSTRAINT link_claim_documents_pkey PRIMARY KEY (pk);


--
-- Name: lu_caused_by_employment_pkey; Type: CONSTRAINT; Schema: clin_workcover; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_caused_by_employment
    ADD CONSTRAINT lu_caused_by_employment_pkey PRIMARY KEY (pk);


--
-- Name: lu_visit_type_pkey; Type: CONSTRAINT; Schema: clin_workcover; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_visit_type
    ADD CONSTRAINT lu_visit_type_pkey PRIMARY KEY (pk);


--
-- Name: visits_pkey; Type: CONSTRAINT; Schema: clin_workcover; Owner: -; Tablespace: 
--

ALTER TABLE ONLY visits
    ADD CONSTRAINT visits_pkey PRIMARY KEY (pk);


SET search_path = coding, pg_catalog;

--
-- Name: lu_loinc_abbrev_pkey; Type: CONSTRAINT; Schema: coding; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_loinc_abbrev
    ADD CONSTRAINT lu_loinc_abbrev_pkey PRIMARY KEY (pk);


--
-- Name: lu_systems_pkey; Type: CONSTRAINT; Schema: coding; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_systems
    ADD CONSTRAINT lu_systems_pkey PRIMARY KEY (pk);


--
-- Name: usr_codes_weighting_pkey; Type: CONSTRAINT; Schema: coding; Owner: -; Tablespace: 
--

ALTER TABLE ONLY usr_codes_weighting
    ADD CONSTRAINT usr_codes_weighting_pkey PRIMARY KEY (pk);


SET search_path = common, pg_catalog;

--
-- Name: lu_aboriginality_pkey; Type: CONSTRAINT; Schema: common; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_aboriginality
    ADD CONSTRAINT lu_aboriginality_pkey PRIMARY KEY (pk);


--
-- Name: lu_anatomical_location_pkey; Type: CONSTRAINT; Schema: common; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_anatomical_localisation
    ADD CONSTRAINT lu_anatomical_location_pkey PRIMARY KEY (pk);


--
-- Name: lu_anatomical_site_pkey; Type: CONSTRAINT; Schema: common; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_anatomical_site
    ADD CONSTRAINT lu_anatomical_site_pkey PRIMARY KEY (pk);


--
-- Name: lu_anterior_posterior_pkey; Type: CONSTRAINT; Schema: common; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_anterior_posterior
    ADD CONSTRAINT lu_anterior_posterior_pkey PRIMARY KEY (pk);


--
-- Name: lu_appointment_length_pkey; Type: CONSTRAINT; Schema: common; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_appointment_length
    ADD CONSTRAINT lu_appointment_length_pkey PRIMARY KEY (pk);


--
-- Name: lu_companion_status_pkey; Type: CONSTRAINT; Schema: common; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_companion_status
    ADD CONSTRAINT lu_companion_status_pkey PRIMARY KEY (pk);


--
-- Name: lu_countries_pkey; Type: CONSTRAINT; Schema: common; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_countries
    ADD CONSTRAINT lu_countries_pkey PRIMARY KEY (pk);


--
-- Name: lu_ethnicity_pkey; Type: CONSTRAINT; Schema: common; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_ethnicity
    ADD CONSTRAINT lu_ethnicity_pkey PRIMARY KEY (pk);


--
-- Name: lu_family_relationships_pkey; Type: CONSTRAINT; Schema: common; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_family_relationships
    ADD CONSTRAINT lu_family_relationships_pkey PRIMARY KEY (pk);


--
-- Name: lu_formulation_pkey; Type: CONSTRAINT; Schema: common; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_formulation
    ADD CONSTRAINT lu_formulation_pkey PRIMARY KEY (pk);


--
-- Name: lu_hearing_aid_status_pkey; Type: CONSTRAINT; Schema: common; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_hearing_aid_status
    ADD CONSTRAINT lu_hearing_aid_status_pkey PRIMARY KEY (pk);


--
-- Name: lu_languages_pkey; Type: CONSTRAINT; Schema: common; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_languages
    ADD CONSTRAINT lu_languages_pkey PRIMARY KEY (pk);


--
-- Name: lu_laterality_pkey; Type: CONSTRAINT; Schema: common; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_laterality
    ADD CONSTRAINT lu_laterality_pkey PRIMARY KEY (pk);


--
-- Name: lu_medicolegal_pkey; Type: CONSTRAINT; Schema: common; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_medicolegal
    ADD CONSTRAINT lu_medicolegal_pkey PRIMARY KEY (pk);


--
-- Name: lu_motion_pkey; Type: CONSTRAINT; Schema: common; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_motion
    ADD CONSTRAINT lu_motion_pkey PRIMARY KEY (pk);


--
-- Name: lu_normality_pkey; Type: CONSTRAINT; Schema: common; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_normality
    ADD CONSTRAINT lu_normality_pkey PRIMARY KEY (pk);


--
-- Name: lu_occupations_bak_pkey; Type: CONSTRAINT; Schema: common; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_occupations_bak
    ADD CONSTRAINT lu_occupations_bak_pkey PRIMARY KEY (pk);


--
-- Name: lu_occupations_pkey; Type: CONSTRAINT; Schema: common; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_occupations
    ADD CONSTRAINT lu_occupations_pkey PRIMARY KEY (pk);


--
-- Name: lu_proximal_distal_pkey; Type: CONSTRAINT; Schema: common; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_proximal_distal
    ADD CONSTRAINT lu_proximal_distal_pkey PRIMARY KEY (pk);


--
-- Name: lu_recreationaldrugs_pkey; Type: CONSTRAINT; Schema: common; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_recreationaldrugs
    ADD CONSTRAINT lu_recreationaldrugs_pkey PRIMARY KEY (pk);


--
-- Name: lu_religions_pkey; Type: CONSTRAINT; Schema: common; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_religions
    ADD CONSTRAINT lu_religions_pkey PRIMARY KEY (pk);


--
-- Name: lu_route_administration_pkey; Type: CONSTRAINT; Schema: common; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_route_administration
    ADD CONSTRAINT lu_route_administration_pkey PRIMARY KEY (pk);


--
-- Name: lu_seasons_pkey; Type: CONSTRAINT; Schema: common; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_seasons
    ADD CONSTRAINT lu_seasons_pkey PRIMARY KEY (pk);


--
-- Name: lu_site_administration_pkey; Type: CONSTRAINT; Schema: common; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_site_administration
    ADD CONSTRAINT lu_site_administration_pkey PRIMARY KEY (pk);


--
-- Name: lu_smoking_status_pkey; Type: CONSTRAINT; Schema: common; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_smoking_status
    ADD CONSTRAINT lu_smoking_status_pkey PRIMARY KEY (pk);


--
-- Name: lu_social_support_pkey; Type: CONSTRAINT; Schema: common; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_social_support
    ADD CONSTRAINT lu_social_support_pkey PRIMARY KEY (pk);


--
-- Name: lu_sub_religions_pkey; Type: CONSTRAINT; Schema: common; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_sub_religions
    ADD CONSTRAINT lu_sub_religions_pkey PRIMARY KEY (pk);


--
-- Name: lu_units_pkey; Type: CONSTRAINT; Schema: common; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_units
    ADD CONSTRAINT lu_units_pkey PRIMARY KEY (pk);


--
-- Name: lu_urgency_pkey; Type: CONSTRAINT; Schema: common; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_urgency
    ADD CONSTRAINT lu_urgency_pkey PRIMARY KEY (pk);


--
-- Name: lu_whisper_test_pkey; Type: CONSTRAINT; Schema: common; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_whisper_test
    ADD CONSTRAINT lu_whisper_test_pkey PRIMARY KEY (pk);


SET search_path = contacts, pg_catalog;

--
-- Name: data_addresses_pkey; Type: CONSTRAINT; Schema: contacts; Owner: -; Tablespace: 
--

ALTER TABLE ONLY data_addresses
    ADD CONSTRAINT data_addresses_pkey PRIMARY KEY (pk);


--
-- Name: data_branches_pkey; Type: CONSTRAINT; Schema: contacts; Owner: -; Tablespace: 
--

ALTER TABLE ONLY data_branches
    ADD CONSTRAINT data_branches_pkey PRIMARY KEY (pk);


--
-- Name: data_communications_pkey; Type: CONSTRAINT; Schema: contacts; Owner: -; Tablespace: 
--

ALTER TABLE ONLY data_communications
    ADD CONSTRAINT data_communications_pkey PRIMARY KEY (pk);


--
-- Name: data_employees_pkey; Type: CONSTRAINT; Schema: contacts; Owner: -; Tablespace: 
--

ALTER TABLE ONLY data_employees
    ADD CONSTRAINT data_employees_pkey PRIMARY KEY (pk);


--
-- Name: data_organisations_pkey; Type: CONSTRAINT; Schema: contacts; Owner: -; Tablespace: 
--

ALTER TABLE ONLY data_organisations
    ADD CONSTRAINT data_organisations_pkey PRIMARY KEY (pk);


--
-- Name: data_persons_pkey; Type: CONSTRAINT; Schema: contacts; Owner: -; Tablespace: 
--

ALTER TABLE ONLY data_persons
    ADD CONSTRAINT data_persons_pkey PRIMARY KEY (pk);


--
-- Name: images_pkey; Type: CONSTRAINT; Schema: contacts; Owner: -; Tablespace: 
--

ALTER TABLE ONLY images
    ADD CONSTRAINT images_pkey PRIMARY KEY (pk);


--
-- Name: links_branches_comms_pkey; Type: CONSTRAINT; Schema: contacts; Owner: -; Tablespace: 
--

ALTER TABLE ONLY links_branches_comms
    ADD CONSTRAINT links_branches_comms_pkey PRIMARY KEY (pk);


--
-- Name: links_employees_comms_pkey; Type: CONSTRAINT; Schema: contacts; Owner: -; Tablespace: 
--

ALTER TABLE ONLY links_employees_comms
    ADD CONSTRAINT links_employees_comms_pkey PRIMARY KEY (pk);


--
-- Name: links_persons_addresses_pkey; Type: CONSTRAINT; Schema: contacts; Owner: -; Tablespace: 
--

ALTER TABLE ONLY links_persons_addresses
    ADD CONSTRAINT links_persons_addresses_pkey PRIMARY KEY (pk);


--
-- Name: links_persons_comms_pkey; Type: CONSTRAINT; Schema: contacts; Owner: -; Tablespace: 
--

ALTER TABLE ONLY links_persons_comms
    ADD CONSTRAINT links_persons_comms_pkey PRIMARY KEY (pk);


--
-- Name: lu_address_types_pkey; Type: CONSTRAINT; Schema: contacts; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_address_types
    ADD CONSTRAINT lu_address_types_pkey PRIMARY KEY (pk);


--
-- Name: lu_categories_pkey; Type: CONSTRAINT; Schema: contacts; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_categories
    ADD CONSTRAINT lu_categories_pkey PRIMARY KEY (pk);


--
-- Name: lu_contact_type_pkey; Type: CONSTRAINT; Schema: contacts; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_contact_type
    ADD CONSTRAINT lu_contact_type_pkey PRIMARY KEY (pk);


--
-- Name: lu_employee_status_pkey; Type: CONSTRAINT; Schema: contacts; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_employee_status
    ADD CONSTRAINT lu_employee_status_pkey PRIMARY KEY (pk);


--
-- Name: lu_firstnames_pkey; Type: CONSTRAINT; Schema: contacts; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_firstnames
    ADD CONSTRAINT lu_firstnames_pkey PRIMARY KEY (pk);


--
-- Name: lu_marital_pkey; Type: CONSTRAINT; Schema: contacts; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_marital
    ADD CONSTRAINT lu_marital_pkey PRIMARY KEY (pk);


--
-- Name: lu_mismatched_towns_pkey; Type: CONSTRAINT; Schema: contacts; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_misspelt_towns
    ADD CONSTRAINT lu_mismatched_towns_pkey PRIMARY KEY (pk);


--
-- Name: lu_sex_pkey; Type: CONSTRAINT; Schema: contacts; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_sex
    ADD CONSTRAINT lu_sex_pkey PRIMARY KEY (pk);


--
-- Name: lu_surnames_pkey; Type: CONSTRAINT; Schema: contacts; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_surnames
    ADD CONSTRAINT lu_surnames_pkey PRIMARY KEY (pk);


--
-- Name: lu_title_pkey; Type: CONSTRAINT; Schema: contacts; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_title
    ADD CONSTRAINT lu_title_pkey PRIMARY KEY (pk);


--
-- Name: lu_towns_pkey; Type: CONSTRAINT; Schema: contacts; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_towns
    ADD CONSTRAINT lu_towns_pkey PRIMARY KEY (pk);


SET search_path = db, pg_catalog;

--
-- Name: db_version_pkey; Type: CONSTRAINT; Schema: db; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_version
    ADD CONSTRAINT db_version_pkey PRIMARY KEY (pk);


SET search_path = defaults, pg_catalog;

--
-- Name: hl7_message_destination_pkey; Type: CONSTRAINT; Schema: defaults; Owner: -; Tablespace: 
--

ALTER TABLE ONLY hl7_inboxes
    ADD CONSTRAINT hl7_message_destination_pkey PRIMARY KEY (pk);


--
-- Name: incoming_message_handling_pkey; Type: CONSTRAINT; Schema: defaults; Owner: -; Tablespace: 
--

ALTER TABLE ONLY incoming_message_handling
    ADD CONSTRAINT incoming_message_handling_pkey PRIMARY KEY (pk);


--
-- Name: lu_link_printer_task_pkey; Type: CONSTRAINT; Schema: defaults; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_link_printer_task
    ADD CONSTRAINT lu_link_printer_task_pkey PRIMARY KEY (pk);


--
-- Name: lu_message_display_style_pkey; Type: CONSTRAINT; Schema: defaults; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_message_display_style
    ADD CONSTRAINT lu_message_display_style_pkey PRIMARY KEY (pk);


--
-- Name: lu_message_standard_pkey; Type: CONSTRAINT; Schema: defaults; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_message_standard
    ADD CONSTRAINT lu_message_standard_pkey PRIMARY KEY (pk);


--
-- Name: lu_printer_host_pkey; Type: CONSTRAINT; Schema: defaults; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_printer_host
    ADD CONSTRAINT lu_printer_host_pkey PRIMARY KEY (pk);


--
-- Name: lu_printer_task_pkey; Type: CONSTRAINT; Schema: defaults; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_printer_task
    ADD CONSTRAINT lu_printer_task_pkey PRIMARY KEY (pk);


--
-- Name: script_coordinates_pkey; Type: CONSTRAINT; Schema: defaults; Owner: -; Tablespace: 
--

ALTER TABLE ONLY script_coordinates
    ADD CONSTRAINT script_coordinates_pkey PRIMARY KEY (pk);


--
-- Name: temp_pkey; Type: CONSTRAINT; Schema: defaults; Owner: -; Tablespace: 
--

ALTER TABLE ONLY temp
    ADD CONSTRAINT temp_pkey PRIMARY KEY (pk);


SET search_path = documents, pg_catalog;

--
-- Name: copies_to_pkey; Type: CONSTRAINT; Schema: documents; Owner: -; Tablespace: 
--

ALTER TABLE ONLY copies_to
    ADD CONSTRAINT copies_to_pkey PRIMARY KEY (pk);


--
-- Name: documents_pkey; Type: CONSTRAINT; Schema: documents; Owner: -; Tablespace: 
--

ALTER TABLE ONLY documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (pk);


--
-- Name: link_document_action_pkey; Type: CONSTRAINT; Schema: documents; Owner: -; Tablespace: 
--

ALTER TABLE ONLY link_document_action
    ADD CONSTRAINT link_document_action_pkey PRIMARY KEY (pk);


--
-- Name: lu_archive_site_pkey; Type: CONSTRAINT; Schema: documents; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_archive_site
    ADD CONSTRAINT lu_archive_site_pkey PRIMARY KEY (pk);


--
-- Name: lu_display_as_pkey; Type: CONSTRAINT; Schema: documents; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_display_as
    ADD CONSTRAINT lu_display_as_pkey PRIMARY KEY (pk);


--
-- Name: lu_message_display_style_pkey; Type: CONSTRAINT; Schema: documents; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_message_display_style
    ADD CONSTRAINT lu_message_display_style_pkey PRIMARY KEY (pk);


--
-- Name: lu_message_standard_pkey; Type: CONSTRAINT; Schema: documents; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_message_standard
    ADD CONSTRAINT lu_message_standard_pkey PRIMARY KEY (pk);


--
-- Name: lu_stakeholder_type_pkey; Type: CONSTRAINT; Schema: documents; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_stakeholder_type
    ADD CONSTRAINT lu_stakeholder_type_pkey PRIMARY KEY (pk);


--
-- Name: lu_stakeholders_pkey; Type: CONSTRAINT; Schema: documents; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_stakeholders
    ADD CONSTRAINT lu_stakeholders_pkey PRIMARY KEY (pk);


--
-- Name: lu_type_pkey; Type: CONSTRAINT; Schema: documents; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_type
    ADD CONSTRAINT lu_type_pkey PRIMARY KEY (pk);


--
-- Name: observations_pkey; Type: CONSTRAINT; Schema: documents; Owner: -; Tablespace: 
--

ALTER TABLE ONLY observations
    ADD CONSTRAINT observations_pkey PRIMARY KEY (pk);


--
-- Name: sending_entities_pkey; Type: CONSTRAINT; Schema: documents; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sending_entities
    ADD CONSTRAINT sending_entities_pkey PRIMARY KEY (pk);


--
-- Name: signed_off_pkey; Type: CONSTRAINT; Schema: documents; Owner: -; Tablespace: 
--

ALTER TABLE ONLY signed_off
    ADD CONSTRAINT signed_off_pkey PRIMARY KEY (pk);


--
-- Name: staff_tasks_pkey; Type: CONSTRAINT; Schema: documents; Owner: -; Tablespace: 
--

ALTER TABLE ONLY link_document_task
    ADD CONSTRAINT staff_tasks_pkey PRIMARY KEY (pk);


--
-- Name: stakeholders_pkey; Type: CONSTRAINT; Schema: documents; Owner: -; Tablespace: 
--

ALTER TABLE ONLY stakeholders
    ADD CONSTRAINT stakeholders_pkey PRIMARY KEY (pk);


--
-- Name: unmatched_patients_pkey; Type: CONSTRAINT; Schema: documents; Owner: -; Tablespace: 
--

ALTER TABLE ONLY unmatched_patients
    ADD CONSTRAINT unmatched_patients_pkey PRIMARY KEY (pk);


--
-- Name: unmatched_staff_pkey; Type: CONSTRAINT; Schema: documents; Owner: -; Tablespace: 
--

ALTER TABLE ONLY unmatched_staff
    ADD CONSTRAINT unmatched_staff_pkey PRIMARY KEY (pk);


--
-- Name: unmatched_types_pkey; Type: CONSTRAINT; Schema: documents; Owner: -; Tablespace: 
--

ALTER TABLE ONLY unmatched_types
    ADD CONSTRAINT unmatched_types_pkey PRIMARY KEY (pk);


SET search_path = drugs, pg_catalog;

--
-- Name: atc_pkey; Type: CONSTRAINT; Schema: drugs; Owner: -; Tablespace: 
--

ALTER TABLE ONLY atc
    ADD CONSTRAINT atc_pkey PRIMARY KEY (atccode);


--
-- Name: clinical_effects_description_key; Type: CONSTRAINT; Schema: drugs; Owner: -; Tablespace: 
--

ALTER TABLE ONLY clinical_effects
    ADD CONSTRAINT clinical_effects_description_key UNIQUE (description);


--
-- Name: clinical_effects_pkey; Type: CONSTRAINT; Schema: drugs; Owner: -; Tablespace: 
--

ALTER TABLE ONLY clinical_effects
    ADD CONSTRAINT clinical_effects_pkey PRIMARY KEY (pk);


--
-- Name: disease_code_code_key; Type: CONSTRAINT; Schema: drugs; Owner: -; Tablespace: 
--

ALTER TABLE ONLY disease_code
    ADD CONSTRAINT disease_code_code_key UNIQUE (code);


--
-- Name: disease_code_pkey; Type: CONSTRAINT; Schema: drugs; Owner: -; Tablespace: 
--

ALTER TABLE ONLY disease_code
    ADD CONSTRAINT disease_code_pkey PRIMARY KEY (pk);


--
-- Name: evidence_levels_pkey; Type: CONSTRAINT; Schema: drugs; Owner: -; Tablespace: 
--

ALTER TABLE ONLY evidence_levels
    ADD CONSTRAINT evidence_levels_pkey PRIMARY KEY (pk);


--
-- Name: flags_pkey; Type: CONSTRAINT; Schema: drugs; Owner: -; Tablespace: 
--

ALTER TABLE ONLY flags
    ADD CONSTRAINT flags_pkey PRIMARY KEY (pk);


--
-- Name: info_pkey; Type: CONSTRAINT; Schema: drugs; Owner: -; Tablespace: 
--

ALTER TABLE ONLY info
    ADD CONSTRAINT info_pkey PRIMARY KEY (pk);


--
-- Name: manufacturer_code_key; Type: CONSTRAINT; Schema: drugs; Owner: -; Tablespace: 
--

ALTER TABLE ONLY manufacturer
    ADD CONSTRAINT manufacturer_code_key UNIQUE (code);


--
-- Name: manufacturer_name_key; Type: CONSTRAINT; Schema: drugs; Owner: -; Tablespace: 
--

ALTER TABLE ONLY manufacturer
    ADD CONSTRAINT manufacturer_name_key UNIQUE (name);


--
-- Name: manufacturer_pkey; Type: CONSTRAINT; Schema: drugs; Owner: -; Tablespace: 
--

ALTER TABLE ONLY manufacturer
    ADD CONSTRAINT manufacturer_pkey PRIMARY KEY (pk);


--
-- Name: patient_categories_pkey; Type: CONSTRAINT; Schema: drugs; Owner: -; Tablespace: 
--

ALTER TABLE ONLY patient_categories
    ADD CONSTRAINT patient_categories_pkey PRIMARY KEY (pk);


--
-- Name: pharmacologic_mechanisms_pkey; Type: CONSTRAINT; Schema: drugs; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pharmacologic_mechanisms
    ADD CONSTRAINT pharmacologic_mechanisms_pkey PRIMARY KEY (pk);


--
-- Name: product_atccode_key; Type: CONSTRAINT; Schema: drugs; Owner: -; Tablespace: 
--

ALTER TABLE ONLY product
    ADD CONSTRAINT product_atccode_key UNIQUE (atccode, name, description, packsize);


--
-- Name: product_pkey; Type: CONSTRAINT; Schema: drugs; Owner: -; Tablespace: 
--

ALTER TABLE ONLY product
    ADD CONSTRAINT product_pkey PRIMARY KEY (pk);


--
-- Name: severity_level_pkey; Type: CONSTRAINT; Schema: drugs; Owner: -; Tablespace: 
--

ALTER TABLE ONLY severity_level
    ADD CONSTRAINT severity_level_pkey PRIMARY KEY (pk);


--
-- Name: sources_pkey; Type: CONSTRAINT; Schema: drugs; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sources
    ADD CONSTRAINT sources_pkey PRIMARY KEY (pk);


--
-- Name: topic_pkey; Type: CONSTRAINT; Schema: drugs; Owner: -; Tablespace: 
--

ALTER TABLE ONLY topic
    ADD CONSTRAINT topic_pkey PRIMARY KEY (pk);


--
-- Name: units_pkey; Type: CONSTRAINT; Schema: drugs; Owner: -; Tablespace: 
--

ALTER TABLE ONLY units
    ADD CONSTRAINT units_pkey PRIMARY KEY (pk);


SET search_path = import_export, pg_catalog;

--
-- Name: lu_demographics_field_templates_pkey; Type: CONSTRAINT; Schema: import_export; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_demographics_field_templates
    ADD CONSTRAINT lu_demographics_field_templates_pkey PRIMARY KEY (pk);


--
-- Name: lu_source_program_pkey; Type: CONSTRAINT; Schema: import_export; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_source_program
    ADD CONSTRAINT lu_source_program_pkey PRIMARY KEY (pk);


SET search_path = public, pg_catalog;

--
-- Name: all_images_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY all_images
    ADD CONSTRAINT all_images_pkey PRIMARY KEY (pk);


SET search_path = contacts, pg_catalog;

--
-- Name: data_persons_firstname_surname_idx; Type: INDEX; Schema: contacts; Owner: -; Tablespace: 
--

CREATE INDEX data_persons_firstname_surname_idx ON data_persons USING btree (firstname, surname);


SET search_path = documents, pg_catalog;

--
-- Name: documents__concluded_deleted_idx; Type: INDEX; Schema: documents; Owner: -; Tablespace: 
--

CREATE INDEX documents__concluded_deleted_idx ON documents USING btree (concluded, deleted) WHERE false;


--
-- Name: documents_concluded_idx; Type: INDEX; Schema: documents; Owner: -; Tablespace: 
--

CREATE INDEX documents_concluded_idx ON documents USING btree (concluded);


--
-- Name: sending_entities_provider_type_index; Type: INDEX; Schema: documents; Owner: -; Tablespace: 
--

CREATE INDEX sending_entities_provider_type_index ON sending_entities USING btree (fk_lu_request_type);


SET search_path = clerical, pg_catalog;

--
-- Name: data_patients_fk_family_fkey; Type: FK CONSTRAINT; Schema: clerical; Owner: -
--

ALTER TABLE ONLY data_patients
    ADD CONSTRAINT data_patients_fk_family_fkey FOREIGN KEY (fk_family) REFERENCES data_families(pk);


SET search_path = contacts, pg_catalog;

--
-- Name: links_branches_comms_fk_branch_fkey; Type: FK CONSTRAINT; Schema: contacts; Owner: -
--

ALTER TABLE ONLY links_branches_comms
    ADD CONSTRAINT links_branches_comms_fk_branch_fkey FOREIGN KEY (fk_branch) REFERENCES data_branches(pk);


--
-- Name: links_branches_comms_fk_comm_fkey; Type: FK CONSTRAINT; Schema: contacts; Owner: -
--

ALTER TABLE ONLY links_branches_comms
    ADD CONSTRAINT links_branches_comms_fk_comm_fkey FOREIGN KEY (fk_comm) REFERENCES data_communications(pk);


SET search_path = defaults, pg_catalog;

--
-- Name: incoming_message_handling_fk_lu_provider_type_fkey; Type: FK CONSTRAINT; Schema: defaults; Owner: -
--

ALTER TABLE ONLY incoming_message_handling
    ADD CONSTRAINT incoming_message_handling_fk_lu_provider_type_fkey FOREIGN KEY (fk_lu_provider_type) REFERENCES contacts.lu_categories(pk);


SET search_path = documents, pg_catalog;

--
-- Name: unmatched_patients_fk_real_patient_fkey; Type: FK CONSTRAINT; Schema: documents; Owner: -
--

ALTER TABLE ONLY unmatched_patients
    ADD CONSTRAINT unmatched_patients_fk_real_patient_fkey FOREIGN KEY (fk_real_patient) REFERENCES clerical.data_patients(pk);


--
-- Name: unmatched_staff_fk_real_staff_fkey; Type: FK CONSTRAINT; Schema: documents; Owner: -
--

ALTER TABLE ONLY unmatched_staff
    ADD CONSTRAINT unmatched_staff_fk_real_staff_fkey FOREIGN KEY (fk_real_staff) REFERENCES admin.staff(pk);


--
-- Name: unmatched_types_fk_real_type_fkey; Type: FK CONSTRAINT; Schema: documents; Owner: -
--

ALTER TABLE ONLY unmatched_types
    ADD CONSTRAINT unmatched_types_fk_real_type_fkey FOREIGN KEY (fk_real_type) REFERENCES lu_type(pk);


SET search_path = drugs, pg_catalog;

--
-- Name: brand_fk_product_fkey; Type: FK CONSTRAINT; Schema: drugs; Owner: -
--

ALTER TABLE ONLY brand
    ADD CONSTRAINT brand_fk_product_fkey FOREIGN KEY (fk_product) REFERENCES product(pk);


--
-- Name: clinical_effects_fk_severity_fkey; Type: FK CONSTRAINT; Schema: drugs; Owner: -
--

ALTER TABLE ONLY clinical_effects
    ADD CONSTRAINT clinical_effects_fk_severity_fkey FOREIGN KEY (fk_severity) REFERENCES severity_level(pk);


--
-- Name: info_fk_clinical_effect_fkey; Type: FK CONSTRAINT; Schema: drugs; Owner: -
--

ALTER TABLE ONLY info
    ADD CONSTRAINT info_fk_clinical_effect_fkey FOREIGN KEY (fk_clinical_effect) REFERENCES clinical_effects(pk);


--
-- Name: info_fk_evidence_level_fkey; Type: FK CONSTRAINT; Schema: drugs; Owner: -
--

ALTER TABLE ONLY info
    ADD CONSTRAINT info_fk_evidence_level_fkey FOREIGN KEY (fk_evidence_level) REFERENCES evidence_levels(pk);


--
-- Name: info_fk_patient_category_fkey; Type: FK CONSTRAINT; Schema: drugs; Owner: -
--

ALTER TABLE ONLY info
    ADD CONSTRAINT info_fk_patient_category_fkey FOREIGN KEY (fk_patient_category) REFERENCES patient_categories(pk);


--
-- Name: info_fk_pharmacologic_mechanism_fkey; Type: FK CONSTRAINT; Schema: drugs; Owner: -
--

ALTER TABLE ONLY info
    ADD CONSTRAINT info_fk_pharmacologic_mechanism_fkey FOREIGN KEY (fk_pharmacologic_mechanism) REFERENCES pharmacologic_mechanisms(pk);


--
-- Name: info_fk_source_fkey; Type: FK CONSTRAINT; Schema: drugs; Owner: -
--

ALTER TABLE ONLY info
    ADD CONSTRAINT info_fk_source_fkey FOREIGN KEY (fk_source) REFERENCES sources(pk);


--
-- Name: info_fk_topic_fkey; Type: FK CONSTRAINT; Schema: drugs; Owner: -
--

ALTER TABLE ONLY info
    ADD CONSTRAINT info_fk_topic_fkey FOREIGN KEY (fk_topic) REFERENCES topic(pk);


--
-- Name: link_atc_info_fk_info_fkey; Type: FK CONSTRAINT; Schema: drugs; Owner: -
--

ALTER TABLE ONLY link_atc_info
    ADD CONSTRAINT link_atc_info_fk_info_fkey FOREIGN KEY (fk_info) REFERENCES info(pk);


--
-- Name: link_disease_info_fk_info_fkey; Type: FK CONSTRAINT; Schema: drugs; Owner: -
--

ALTER TABLE ONLY link_disease_info
    ADD CONSTRAINT link_disease_info_fk_info_fkey FOREIGN KEY (fk_info) REFERENCES info(pk);


--
-- Name: link_flag_product_fk_flag_fkey; Type: FK CONSTRAINT; Schema: drugs; Owner: -
--

ALTER TABLE ONLY link_flag_product
    ADD CONSTRAINT link_flag_product_fk_flag_fkey FOREIGN KEY (fk_flag) REFERENCES flags(pk);


--
-- Name: link_flag_product_fk_product_fkey; Type: FK CONSTRAINT; Schema: drugs; Owner: -
--

ALTER TABLE ONLY link_flag_product
    ADD CONSTRAINT link_flag_product_fk_product_fkey FOREIGN KEY (fk_product) REFERENCES product(pk);


--
-- Name: pbs_fk_product_fkey; Type: FK CONSTRAINT; Schema: drugs; Owner: -
--

ALTER TABLE ONLY pbs
    ADD CONSTRAINT pbs_fk_product_fkey FOREIGN KEY (fk_product) REFERENCES product(pk);


--
-- Name: product_fk_unit_fkey; Type: FK CONSTRAINT; Schema: drugs; Owner: -
--

ALTER TABLE ONLY product
    ADD CONSTRAINT product_fk_unit_fkey FOREIGN KEY (fk_unit) REFERENCES units(pk);


--
-- PostgreSQL database dump complete
--

