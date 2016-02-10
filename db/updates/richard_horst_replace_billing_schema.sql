-- this file is richard_horst_replace_billing_schema.sql
-- This is a drop in replacement for the Billing Schema
--  but it drops a stack of other views which must be replaced
-- I have just added a vwPatient's which is lost in the cascade
Drop schema billing cascade;
-- view contacts.vwpatients depends on table billing.lu_default_billing_level
-- view clerical.vwtaskscomponents depends on view contacts.vwpatients
-- view clerical.vwtaskscomponentsandnotes depends on view contacts.vwpatients
-- view clin_consult.vwdictations depends on view contacts.vwpatients
-- view clin_consult.vwpatientconsults depends on view contacts.vwpatients
-- view clin_history.vwresponsiblepersons depends on view contacts.vwpatients
-- view clin_recalls.vwrecallsdue depends on view contacts.vwpatients
-- view documents.vwdocuments depends on view contacts.vwpatients
-- view clin_requests.vwrequestsordered depends on view documents.vwdocuments
-- view documents.vwhl7filesimported depends on view documents.vwdocuments
-- view research.vwmostrecenteyerelateddocuments depends on view documents.vwdocuments
-- view documents.vwdocuments1 depends on view contacts.vwpatients
-- view vwfentanylpatients depends on view contacts.vwpatients
-- view research.diabetes_patients_latest_hba1c depends on view contacts.vwpatients
-- view research.diabetes_patients_with_hba1c depends on view contacts.vwpatients
-- view research.patientsnameshba1cover75 depends on view contacts.vwpatients
-- view research.vwdiabetes_patients_with_hba1c depends on view contacts.vwpatients
-- view research.vwdiabetics_with_ldlcholesterol depends on view research.vwdiabetes_patients_with_hba1c
-- view research.vwdiabetics_with_microalbumins depends on view research.vwdiabetes_patients_with_hba1c
-- view research.vwdiabeticsegfr depends on view research.vwdiabetes_patients_with_hba1c
-- view research.vwfentanylpatients depends on view contacts.vwpatients
-- view research.vwldh depends on view contacts.vwpatients
-- view clin_workcover.vwpatientswithworkcover depends on view contacts.vwpatients
-- view clerical.vwappointments depends on table billing.lu_reasons_not_billed
-- view clerical.vwappointments1 depends on table billing.lu_reasons_not_billed
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: billing; Type: SCHEMA; Schema: -; Owner: easygp
--

CREATE SCHEMA billing;


ALTER SCHEMA billing OWNER TO easygp;

--
-- Name: SCHEMA billing; Type: COMMENT; Schema: -; Owner: easygp
--

COMMENT ON SCHEMA billing IS 'Contains anything to do with billing or receiving payments for the patient services';


SET search_path = public, billing, pg_catalog;

--
-- Name: assert_code(integer, text); Type: FUNCTION; Schema: billing; Owner: easygp
--

CREATE FUNCTION billing.assert_code(integer, text) RETURNS void
    LANGUAGE plpgsql
    AS $_$
begin
  perform 1 from billing.codes where code=$1;
  if found then
      update billing.codes set description=$2 where code=$1;
  else
      insert into billing.codes (code,description) values ($1, $2);
  end if;
end
$_$;


ALTER FUNCTION billing.assert_code(integer, text) OWNER TO easygp;

--
-- Name: invoice_gst(integer); Type: FUNCTION; Schema: billing; Owner: easygp
--

CREATE FUNCTION billing.invoice_gst(integer) RETURNS money
    LANGUAGE sql
    AS $_$
   select coalesce(sum(i.amount_gst),'$0.00'::money) 
           from billing.items_billed i where i.fk_invoice=$1; 
$_$;


ALTER FUNCTION billing.invoice_gst(integer) OWNER TO easygp;

--
-- Name: invoice_notify(); Type: FUNCTION; Schema: billing; Owner: easygp
--

CREATE FUNCTION billing.invoice_notify() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	EXECUTE 'NOTIFY invoice, '''|| NEW.pk || '''';
	RETURN NEW;
END;
$$;


ALTER FUNCTION billing.invoice_notify() OWNER TO easygp;

--
-- Name: invoice_received(integer); Type: FUNCTION; Schema: billing; Owner: easygp
--

CREATE FUNCTION billing.invoice_received(integer) RETURNS money
    LANGUAGE sql
    AS $_$
    select coalesce(sum(amount),'$0.00'::money) from billing.payments_received where fk_invoice=$1;$_$;


ALTER FUNCTION billing.invoice_received(integer) OWNER TO easygp;

--
-- Name: invoice_total(integer); Type: FUNCTION; Schema: billing; Owner: easygp
--

CREATE FUNCTION billing.invoice_total(integer) RETURNS money
    LANGUAGE sql
    AS $_$
   select coalesce(sum(amount),'$0.00'::money) from billing.items_billed where fk_invoice=$1; $_$;


ALTER FUNCTION billing.invoice_total(integer) OWNER TO easygp;

--
-- Name: update_invoice_bill(); Type: FUNCTION; Schema: billing; Owner: easygp
--

CREATE FUNCTION billing.update_invoice_bill() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
       pk_invoice iNTEGER;
       gst MONEY;
    BEGIN
        if (TG_OP = 'DELETE') THEN
pk_invoice = OLD.fk_invoice;
else
pk_invoice = NEW.fk_invoice;
end if;
        gst := billing.invoice_gst(pk_invoice);
        update billing.invoices set total_bill=billing.invoice_total(pk)+gst, total_gst=gst where pk = pk_invoice;
        RETURN NULL; -- result is ignored since this is an AFTER trigger
    END;
$$;


ALTER FUNCTION billing.update_invoice_bill() OWNER TO easygp;

--
-- Name: update_invoice_payment(); Type: FUNCTION; Schema: billing; Owner: easygp
--

CREATE FUNCTION billing.update_invoice_payment() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
       pk_invoice iNTEGER;
    BEGIN
        If (TG_OP = 'DELETE') THEN
      pk_invoice = OLD.fk_invoice;
   Else
      pk_invoice = New .fk_invoice;
   End If ;
        update billing.invoices set total_paid = billing.invoice_received(pk)where pk = pk_invoice;
   update billing.invoices set paid = (total_paid >= total_gst + total_bill)where pk = pk_invoice;
        Return Null; -- result Is Ignored since this Is An AFTER trigger
    End ;
$$;


ALTER FUNCTION billing.update_invoice_payment() OWNER TO easygp;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: bank_details; Type: TABLE; Schema: billing; Owner: easygp; Tablespace: 
--

CREATE TABLE billing.bank_details (
    pk integer NOT NULL,
    fk_invoice integer NOT NULL,
    bsb character(6) NOT NULL,
    account_number character varying(10) NOT NULL,
    account_name text NOT NULL,
    CONSTRAINT bank_details_account_number_check CHECK (((account_number)::text ~ '^[0-9]{4,10}$'::text)),
    CONSTRAINT bank_details_bsb_check CHECK ((bsb ~ '^[0-9]{6}$'::text))
);


ALTER TABLE billing.bank_details OWNER TO easygp;

--
-- Name: bank_details_pk_seq; Type: SEQUENCE; Schema: billing; Owner: easygp
--

CREATE SEQUENCE billing.bank_details_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE billing.bank_details_pk_seq OWNER TO easygp;

--
-- Name: bank_details_pk_seq; Type: SEQUENCE OWNED BY; Schema: billing; Owner: easygp
--

ALTER SEQUENCE billing.bank_details_pk_seq OWNED BY bank_details.pk;


--
-- Name: claims; Type: TABLE; Schema: billing; Owner: easygp; Tablespace: 
--

CREATE TABLE billing.claims (
    pk integer NOT NULL,
    claim_id text,
    claim_date timestamp without time zone,
    fk_branch integer NOT NULL,
    result_code integer DEFAULT (-2),
    result_text text,
    provider_number character varying(8),
    payment_report_run_date timestamp without time zone,
    processing_report_run_date timestamp without time zone,
    payment_report text
);


ALTER TABLE billing.claims OWNER TO easygp;

--
-- Name: TABLE claims; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON TABLE claims IS 'Contains informaton about claims made online: bulk-billing or otherwise';


--
-- Name: COLUMN claims.claim_id; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN claims.claim_id IS 'The medicare issued coverslip number which accompanies the claim';


--
-- Name: COLUMN claims.claim_date; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN claims.claim_date IS 'The date on which the claim was processed (paper) or lodged (medclaims)';


--
-- Name: COLUMN claims.result_code; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN claims.result_code IS 'returned code for the whole claim. 0 means success';


--
-- Name: COLUMN claims.result_text; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN claims.result_text IS 'only significant if report > 0, returned by the driver';


--
-- Name: claims_pk_seq; Type: SEQUENCE; Schema: billing; Owner: easygp
--

CREATE SEQUENCE billing.claims_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE billing.claims_pk_seq OWNER TO easygp;

--
-- Name: claims_pk_seq; Type: SEQUENCE OWNED BY; Schema: billing; Owner: easygp
--

ALTER SEQUENCE billing.claims_pk_seq OWNED BY claims.pk;


--
-- Name: fee_schedule; Type: TABLE; Schema: billing; Owner: easygp; Tablespace: 
--

CREATE TABLE billing.fee_schedule (
    pk integer NOT NULL,
    mbs_item text,
    user_item text,
    ama_item text,
    descriptor text NOT NULL,
    ceased_date date,
    "group" text,
    derived_fee text,
    descriptor_brief text,
    gst_rate integer DEFAULT 0,
    percentage_fee_rule boolean DEFAULT false,
    number_of_patients integer DEFAULT 0,
    CONSTRAINT schedule_check CHECK ((((NOT (mbs_item IS NULL)) OR (NOT (ama_item IS NULL))) OR (NOT (user_item IS NULL))))
);


ALTER TABLE billing.fee_schedule OWNER TO easygp;

--
-- Name: TABLE fee_schedule; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON TABLE fee_schedule IS 'the Schedule of Fees this may be medicare benefit schedule or added by the user';


--
-- Name: COLUMN fee_schedule.mbs_item; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN fee_schedule.mbs_item IS 'the item number in the Medicare Benefits Schedule or user schedule, NULL only if only appears on AMA Schedule';


--
-- Name: COLUMN fee_schedule.user_item; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN fee_schedule.user_item IS 'if the item is defined by the user';


--
-- Name: COLUMN fee_schedule.ama_item; Type: COMMENT; Schema: billing; Owner: easygp
--


COMMENT ON COLUMN fee_schedule.ama_item IS 'the item number in the AMA version of the schedule, if used, otherwise NULL';



--
-- Name: COLUMN fee_schedule.descriptor_brief; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN fee_schedule.descriptor_brief IS 'a brief description of a long descriptor';


--
-- Name: COLUMN fee_schedule.gst_rate; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN fee_schedule.gst_rate IS 'the goods and services tax rate';


--
-- Name: COLUMN fee_schedule.number_of_patients; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN fee_schedule.number_of_patients IS 'the number of patients to which this item applies, usually 1, but e.g nursing homes or group therapy sessions can be up to 7';


--
-- Name: fee_schedule_pk_seq; Type: SEQUENCE; Schema: billing; Owner: easygp
--

CREATE SEQUENCE billing.fee_schedule_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE billing.fee_schedule_pk_seq OWNER TO easygp;

--
-- Name: fee_schedule_pk_seq; Type: SEQUENCE OWNED BY; Schema: billing; Owner: easygp
--

ALTER SEQUENCE billing.fee_schedule_pk_seq OWNED BY fee_schedule.pk;


--
-- Name: invoices; Type: TABLE; Schema: billing; Owner: easygp; Tablespace: 
--

CREATE TABLE billing.invoices (
    pk integer NOT NULL,
    fk_staff_invoicing integer NOT NULL,
    date_printed timestamp without time zone,
    notes text,
    fk_staff_provided_service integer NOT NULL,
    fk_patient integer,
    date_invoiced timestamp without time zone DEFAULT now() NOT NULL,
    paid boolean DEFAULT false NOT NULL,
    fk_payer_person integer,
    fk_payer_branch integer,
    latex text,
    fk_branch integer NOT NULL,
    visit_date date,
    reference text,
    fk_lu_bulk_billing_type integer,
    fk_appointment integer,
    total_bill money DEFAULT '$0.00'::money NOT NULL,
    total_gst money DEFAULT '$0.00'::money NOT NULL,
    total_paid money DEFAULT '$0.00'::money NOT NULL,
    online boolean DEFAULT false NOT NULL,
    result_code integer DEFAULT (-1),
    result_text text,
    fk_claim integer,
    voucher_id character varying(2),
    referrer_provider_number character varying(8),
    referral_date date,
    referral_duration integer,
    pms_claim_id text,
    error_level character(1),
    claimant_address_upload boolean DEFAULT false NOT NULL,
    bank_details_upload boolean DEFAULT false NOT NULL,
    CONSTRAINT flags_online CHECK ((NOT ((NOT online) AND (bank_details_upload OR claimant_address_upload)))),
    CONSTRAINT has_claimant CHECK ((NOT (claimant_address_upload AND (fk_payer_person IS NULL))))
);


ALTER TABLE billing.invoices OWNER TO easygp;

--
-- Name: TABLE invoices; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON TABLE invoices IS 'any invoices generated';


--
-- Name: COLUMN invoices.fk_staff_invoicing; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN invoices.fk_staff_invoicing IS 'the staff member raising the invoice';


--
-- Name: COLUMN invoices.notes; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN invoices.notes IS 'Any additional comments pertaining to the invoice or any of it''s
  items eg if the item was WCO002 (workcover case conference per 5mins)
  then the comment may be ''Conference with Mr P Smith about Return to Work Plan''';


--
-- Name: COLUMN invoices.fk_staff_provided_service; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN invoices.fk_staff_provided_service IS 'the staff member who provider the service on which the invoice is based';


--
-- Name: COLUMN invoices.fk_payer_person; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN invoices.fk_payer_person IS 'if not null then the key to the person who pays the bill';


--
-- Name: COLUMN invoices.fk_payer_branch; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN invoices.fk_payer_branch IS 'if not null then payer is an organisation/branch';


--
-- Name: COLUMN invoices.latex; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN invoices.latex IS 'the LaTeX definition of the invoice generated';


--
-- Name: COLUMN invoices.fk_branch; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN invoices.fk_branch IS 'The branch at which the patient was provided with the service';


--
-- Name: COLUMN invoices.visit_date; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN invoices.visit_date IS 'The date time of the patient visit - may be null because the invoice could be raised not in relation to a visit';


--
-- Name: COLUMN invoices.reference; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN invoices.reference IS 'text of any insurance or bill reference eg ''CLAIM NO:1234''';


--
-- Name: COLUMN invoices.fk_lu_bulk_billing_type; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN invoices.fk_lu_bulk_billing_type IS 'if not null then the type of bulk-bill 1=medicare 2=veteran';


--
-- Name: COLUMN invoices.online; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN invoices.online IS 'true if the invoice is to be uploaded via Medicare Online';


--
-- Name: COLUMN invoices.result_code; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN invoices.result_code IS 'text returned by medicare Online driver, only significant if result_code > 0';


--
-- Name: COLUMN invoices.pms_claim_id; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN invoices.pms_claim_id IS 'Medicare Online returns a claim transaction ID, which their documentaiton misleadingly calls the PMS Claim ID';


--
-- Name: COLUMN invoices.error_level; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN invoices.error_level IS 'Medicare Online''s one-char error level code, A=acceptable, U=aunacceptable, not very useful compared to the error numeric code';


--
-- Name: COLUMN invoices.claimant_address_upload; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN invoices.claimant_address_upload IS 'true if claimant''s address is to be uploaded using Medicare Online';


--
-- Name: COLUMN invoices.bank_details_upload; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN invoices.bank_details_upload IS 'true if claimant''s bank details are to be uploaded using Medicare Online';


--
-- Name: invoices_pk_seq; Type: SEQUENCE; Schema: billing; Owner: easygp
--

CREATE SEQUENCE billing.invoices_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE billing.invoices_pk_seq OWNER TO easygp;

--
-- Name: invoices_pk_seq; Type: SEQUENCE OWNED BY; Schema: billing; Owner: easygp
--

ALTER SEQUENCE billing.invoices_pk_seq OWNED BY invoices.pk;


--
-- Name: items_billed; Type: TABLE; Schema: billing; Owner: easygp; Tablespace: 
--

CREATE TABLE billing.items_billed (
    pk integer NOT NULL,
    fk_fee_schedule integer NOT NULL,
    amount money NOT NULL,
    fk_invoice integer NOT NULL,
    fk_lu_billing_type integer NOT NULL,
    amount_gst money,
    service_id character(4),
    reason_code integer,
    comment text,
    error_level character(1),
    multiple_procedure boolean DEFAULT false NOT NULL,
    aftercare boolean DEFAULT false NOT NULL,
    duplicate boolean DEFAULT false NOT NULL,
    separate_sites boolean DEFAULT false NOT NULL,
    not_related boolean DEFAULT false NOT NULL,
    procedure_duration integer DEFAULT 0 NOT NULL,
    field_quantity integer DEFAULT 0 NOT NULL
);


ALTER TABLE billing.items_billed OWNER TO easygp;

--
-- Name: TABLE items_billed; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON TABLE items_billed IS 'contains all the items as per shedule billed on the invoice';


--
-- Name: COLUMN items_billed.error_level; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN items_billed.error_level IS 'Medicare Online''s one-char error level code, A=acceptable, U=unacceptable, not very useful compared to the error numeric code';


--
-- Name: COLUMN items_billed.multiple_procedure; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN items_billed.multiple_procedure IS 'flag for multiple procedure override on Medicare Online';


--
-- Name: COLUMN items_billed.aftercare; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN items_billed.aftercare IS 'flag for ''not normal aftercare'' on Medicare Online';


--
-- Name: COLUMN items_billed.duplicate; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN items_billed.duplicate IS 'flag for ''duplicate service'' on Medicare Online';


--
-- Name: COLUMN items_billed.separate_sites; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN items_billed.separate_sites IS 'flag for ''separate (procedure) sites'' on Medicare Online';


--
-- Name: COLUMN items_billed.not_related; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN items_billed.not_related IS 'flag for ''not realted 9to care plan)'' on Medicare Online';


--
-- Name: COLUMN items_billed.procedure_duration; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN items_billed.procedure_duration IS 'field for duration in certai special (usually anaesthetic) items on Medicare Online. Expressed in minutes, must be a mutiple of 15';


--
-- Name: COLUMN items_billed.field_quantity; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN items_billed.field_quantity IS 'special field for a small number of items on Medicare Online: radiotherapy, and certain anaesthetic items';


--
-- Name: items_billed_pk_seq; Type: SEQUENCE; Schema: billing; Owner: easygp
--

CREATE SEQUENCE billing.items_billed_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE billing.items_billed_pk_seq OWNER TO easygp;

--
-- Name: items_billed_pk_seq; Type: SEQUENCE OWNED BY; Schema: billing; Owner: easygp
--

ALTER SEQUENCE billing.items_billed_pk_seq OWNED BY items_billed.pk;


--
-- Name: lu_billing_type; Type: TABLE; Schema: billing; Owner: easygp; Tablespace: 
--

CREATE TABLE billing.lu_billing_type (
    pk integer NOT NULL,
    type text NOT NULL
);


ALTER TABLE billing.lu_billing_type OWNER TO easygp;

--
-- Name: TABLE lu_billing_type; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON TABLE lu_billing_type IS 'the various types of billing eg AMA, Schedule Fee, Private etc.';


--
-- Name: lu_billing_type_pk_seq; Type: SEQUENCE; Schema: billing; Owner: easygp
--

CREATE SEQUENCE billing.lu_billing_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE billing.lu_billing_type_pk_seq OWNER TO easygp;

--
-- Name: lu_billing_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: billing; Owner: easygp
--

ALTER SEQUENCE billing.lu_billing_type_pk_seq OWNED BY lu_billing_type.pk;


--
-- Name: lu_bulk_billing_type; Type: TABLE; Schema: billing; Owner: easygp; Tablespace: 
--

CREATE TABLE billing.lu_bulk_billing_type (
    pk integer NOT NULL,
    type text NOT NULL
);


ALTER TABLE billing.lu_bulk_billing_type OWNER TO easygp;

--
-- Name: TABLE lu_bulk_billing_type; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON TABLE lu_bulk_billing_type IS 'the type of bulk-bill 1=medicare 2=veterans';


--
-- Name: lu_bulk_billing_type_pk_seq; Type: SEQUENCE; Schema: billing; Owner: easygp
--

CREATE SEQUENCE billing.lu_bulk_billing_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE billing.lu_bulk_billing_type_pk_seq OWNER TO easygp;

--
-- Name: lu_bulk_billing_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: billing; Owner: easygp
--

ALTER SEQUENCE billing.lu_bulk_billing_type_pk_seq OWNED BY lu_bulk_billing_type.pk;


--
-- Name: lu_codes; Type: TABLE; Schema: billing; Owner: easygp; Tablespace: 
--

CREATE TABLE billing.lu_codes (
    code integer,
    description text
);


ALTER TABLE billing.lu_codes OWNER TO easygp;

--
-- Name: lu_default_billing_level; Type: TABLE; Schema: billing; Owner: easygp; Tablespace: 
--

CREATE TABLE billing.lu_default_billing_level (
    pk integer NOT NULL,
    level text NOT NULL
);


ALTER TABLE billing.lu_default_billing_level OWNER TO easygp;

--
-- Name: TABLE lu_default_billing_level; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON TABLE lu_default_billing_level IS ' the default level of billing that a practice decides to give to a patient/client
 eg bulk bill (either medicare or veterans) private or concession of some type';


--
-- Name: lu_default_billing_level_pk_seq; Type: SEQUENCE; Schema: billing; Owner: easygp
--

CREATE SEQUENCE billing.lu_default_billing_level_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE billing.lu_default_billing_level_pk_seq OWNER TO easygp;

--
-- Name: lu_default_billing_level_pk_seq; Type: SEQUENCE OWNED BY; Schema: billing; Owner: easygp
--

ALTER SEQUENCE billing.lu_default_billing_level_pk_seq OWNED BY lu_default_billing_level.pk;


--
-- Name: lu_invoice_comments; Type: TABLE; Schema: billing; Owner: easygp; Tablespace: 
--

CREATE TABLE billing.lu_invoice_comments (
    pk integer NOT NULL,
    comment text NOT NULL
);


ALTER TABLE billing.lu_invoice_comments OWNER TO easygp;

--
-- Name: TABLE lu_invoice_comments; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON TABLE lu_invoice_comments IS 'Comments added to the invoice e.g ''not usual aftercare''';


--
-- Name: lu_invoice_comments_pk_seq; Type: SEQUENCE; Schema: billing; Owner: easygp
--

CREATE SEQUENCE billing.lu_invoice_comments_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE billing.lu_invoice_comments_pk_seq OWNER TO easygp;

--
-- Name: lu_invoice_comments_pk_seq; Type: SEQUENCE OWNED BY; Schema: billing; Owner: easygp
--

ALTER SEQUENCE billing.lu_invoice_comments_pk_seq OWNED BY lu_invoice_comments.pk;


--
-- Name: lu_payment_method; Type: TABLE; Schema: billing; Owner: easygp; Tablespace: 
--

CREATE TABLE billing.lu_payment_method (
    pk integer NOT NULL,
    method text NOT NULL
);


ALTER TABLE billing.lu_payment_method OWNER TO easygp;

--
-- Name: TABLE lu_payment_method; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON TABLE lu_payment_method IS 'the method of paying the invoice';


--
-- Name: lu_payment_method_pk_seq; Type: SEQUENCE; Schema: billing; Owner: easygp
--

CREATE SEQUENCE billing.lu_payment_method_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE billing.lu_payment_method_pk_seq OWNER TO easygp;

--
-- Name: lu_payment_method_pk_seq; Type: SEQUENCE OWNED BY; Schema: billing; Owner: easygp
--

ALTER SEQUENCE billing.lu_payment_method_pk_seq OWNED BY lu_payment_method.pk;


--
-- Name: lu_reasons_not_billed; Type: TABLE; Schema: billing; Owner: easygp; Tablespace: 
--

CREATE TABLE billing.lu_reasons_not_billed (
    pk integer NOT NULL,
    reason text NOT NULL
);


ALTER TABLE billing.lu_reasons_not_billed OWNER TO easygp;

--
-- Name: lu_reasons_not_billed_pk_seq; Type: SEQUENCE; Schema: billing; Owner: easygp
--

CREATE SEQUENCE billing.lu_reasons_not_billed_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE billing.lu_reasons_not_billed_pk_seq OWNER TO easygp;

--
-- Name: lu_reasons_not_billed_pk_seq; Type: SEQUENCE OWNED BY; Schema: billing; Owner: easygp
--

ALTER SEQUENCE billing.lu_reasons_not_billed_pk_seq OWNED BY lu_reasons_not_billed.pk;


--
-- Name: lu_reports; Type: TABLE; Schema: billing; Owner: easygp; Tablespace: 
--

CREATE TABLE billing.lu_reports (
    pk integer NOT NULL,
    report_title text NOT NULL,
    sql text NOT NULL,
    plot text,
    fk_subreport integer,
    subkey name
);



ALTER TABLE billing.lu_reports OWNER TO easygp;

--
-- Name: COLUMN lu_reports.sql; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN lu_reports.sql IS 'SQL code to run the report, with variable subsitutions prefixed by dollar. $staff $start_date and $end_date are default';


--
-- Name: COLUMN lu_reports.plot; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN lu_reports.plot IS 'if non-null GNUPlot program to feed results of query into';


--
-- Name: COLUMN lu_reports.fk_subreport; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN lu_reports.fk_subreport IS 'PK of sub-report if exists';


--
-- Name: COLUMN lu_reports.subkey; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN lu_reports.subkey IS 'field on this report to be available to subreport''s quiery as a substitution variable';


--
-- Name: lu_reports_pk_seq; Type: SEQUENCE; Schema: billing; Owner: easygp
--

CREATE SEQUENCE billing.lu_reports_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE billing.lu_reports_pk_seq OWNER TO easygp;

--
-- Name: lu_reports_pk_seq; Type: SEQUENCE OWNED BY; Schema: billing; Owner: easygp
--

ALTER SEQUENCE billing.lu_reports_pk_seq OWNED BY lu_reports.pk;


--
-- Name: payments_received; Type: TABLE; Schema: billing; Owner: easygp; Tablespace: 
--

CREATE TABLE billing.payments_received (
    pk integer NOT NULL,
    fk_invoice integer NOT NULL,
    referent text,
    amount money NOT NULL,
    fk_lu_payment_method integer,
    date_paid timestamp without time zone DEFAULT now() NOT NULL,
    fk_staff_receipted integer
);


ALTER TABLE billing.payments_received OWNER TO easygp;

--
-- Name: payments_received_pk_seq; Type: SEQUENCE; Schema: billing; Owner: easygp
--

CREATE SEQUENCE billing.payments_received_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE billing.payments_received_pk_seq OWNER TO easygp;

--
-- Name: payments_received_pk_seq; Type: SEQUENCE OWNED BY; Schema: billing; Owner: easygp
--


ALTER SEQUENCE billing.payments_received_pk_seq OWNED BY payments_received.pk;


--
-- Name: prices; Type: TABLE; Schema: billing; Owner: easygp; Tablespace: 
--

CREATE TABLE billing.prices (
    pk integer NOT NULL,
    fk_fee_schedule integer NOT NULL,
    price money DEFAULT '$0.00'::money NOT NULL,
    fk_lu_billing_type integer NOT NULL,
    notes text
);


ALTER TABLE billing.prices OWNER TO easygp;

--
-- Name: COLUMN prices.price; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN prices.price IS 'the price to the patient';


--
-- Name: prices_pk_seq; Type: SEQUENCE; Schema: billing; Owner: easygp
--

CREATE SEQUENCE billing.prices_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE billing.prices_pk_seq OWNER TO easygp;

--
-- Name: prices_pk_seq; Type: SEQUENCE OWNED BY; Schema: billing; Owner: easygp
--

ALTER SEQUENCE billing.prices_pk_seq OWNED BY prices.pk;


--
-- Name: reports; Type: TABLE; Schema: billing; Owner: easygp; Tablespace: 
--

CREATE TABLE billing.reports (
    pk integer,
    report_title text
);


ALTER TABLE billing.reports OWNER TO easygp;

--
-- Name: vwclaims; Type: VIEW; Schema: billing; Owner: easygp
--

CREATE VIEW billing.vwclaims AS
 SELECT claims.pk,
    claims.claim_id,
    claims.claim_date,
    claims.fk_branch,
    claims.result_code,
    (COALESCE(claims.result_text, ''::text) || COALESCE(lu_codes.description, ''::text)) AS result_text,
    claims.provider_number,
    claims.payment_report_run_date,
    claims.processing_report_run_date,
    claims.payment_report,
    vwstaff.wholename AS doctor,
    vwclinics.branch
   FROM (((claims
     LEFT JOIN lu_codes ON ((lu_codes.code = claims.result_code)))
     LEFT JOIN admin.vwstaff ON ((vwstaff.provider_number = (claims.provider_number)::text)))
     JOIN admin.vwclinics ON ((vwclinics.fk_branch = claims.fk_branch)));


ALTER TABLE billing.vwclaims OWNER TO easygp;

--
-- Name: vwdaylist; Type: VIEW; Schema: billing; Owner: easygp
--

CREATE VIEW billing.vwdaylist AS
 SELECT ((bookings.pk || '-'::text) || items_billed.pk) AS pk_view,
    bookings.pk AS fk_appointment,
    bookings.fk_patient,
    bookings.fk_lu_reason_not_billed,
    data_patients.fk_lu_centrelink_card_type,
    invoices.pk AS fk_invoice,
    invoices.paid,
    invoices.fk_payer_person,
    invoices.fk_payer_branch,
    invoices.latex,
    invoices.total_bill,
    invoices.total_gst,
    invoices.total_paid,
    invoices.fk_staff_provided_service,
    invoices.fk_lu_bulk_billing_type,
    lu_bulk_billing_type.type AS bulk_billing_type,
    bookings.begin AS appointment_date,
    COALESCE(COALESCE(fee_schedule.ama_item, fee_schedule.mbs_item), fee_schedule.user_item) AS item,
    fee_schedule.descriptor_brief,
    items_billed.amount,
    items_billed.amount_gst,
    items_billed.pk AS fk_items_billed,
    payments_received.fk_lu_payment_method,
    payments_received.amount AS payment_amount,
    lu_billing_type.type AS billing_type,
    lu_payment_method.method AS payment_method,
    NULL::text AS reason_not_billed,
    (((lu_title.title || ' '::text) || (data_persons.firstname || ' '::text)) || (data_persons.surname || ' '::text)) AS wholename,
    data_persons.firstname,
    data_persons.surname,
    lu_title.title,
    data_persons.fk_sex,
    COALESCE(vworganisations.organisation, vwpersonsincludingpatients.wholename) AS account_to_name,
    clinics.fk_branch
   FROM (((((((((((((clerical.bookings
     JOIN invoices ON ((invoices.fk_appointment = bookings.pk)))
     JOIN admin.clinics ON ((bookings.fk_clinic = clinics.pk)))
     JOIN clerical.data_patients ON ((bookings.fk_patient = data_patients.pk)))
     LEFT JOIN lu_bulk_billing_type ON ((invoices.fk_lu_bulk_billing_type = lu_bulk_billing_type.pk)))
     JOIN items_billed ON ((invoices.pk = items_billed.fk_invoice)))
     JOIN fee_schedule ON ((items_billed.fk_fee_schedule = fee_schedule.pk)))
     JOIN lu_billing_type ON ((items_billed.fk_lu_billing_type = lu_billing_type.pk)))
     LEFT JOIN contacts.vworganisations ON ((invoices.fk_payer_branch = vworganisations.fk_branch)))
     LEFT JOIN contacts.vwpersonsincludingpatients ON ((invoices.fk_payer_person = vwpersonsincludingpatients.fk_person)))
     JOIN contacts.data_persons ON ((data_patients.fk_person = data_persons.pk)))
     JOIN contacts.lu_title ON ((data_persons.fk_title = lu_title.pk)))
     LEFT JOIN payments_received ON ((invoices.pk = payments_received.fk_invoice)))
     LEFT JOIN lu_payment_method ON ((payments_received.fk_lu_payment_method = lu_payment_method.pk)))
  WHERE (bookings.fk_lu_reason_not_billed IS NULL)
UNION
 SELECT ((bookings.pk || '-'::text) || '0'::text) AS pk_view,
    bookings.pk AS fk_appointment,
    bookings.fk_patient,
    bookings.fk_lu_reason_not_billed,
    NULL::integer AS fk_lu_centrelink_card_type,
    NULL::integer AS fk_invoice,
    NULL::boolean AS paid,
    NULL::integer AS fk_payer_person,
    NULL::integer AS fk_payer_branch,
    NULL::text AS latex,
    NULL::money AS total_bill,
    NULL::money AS total_gst,
    NULL::money AS total_paid,
    bookings.fk_staff AS fk_staff_provided_service,
    NULL::integer AS fk_lu_bulk_billing_type,
    NULL::text AS bulk_billing_type,
    bookings.begin AS appointment_date,
    NULL::text AS item,
    NULL::text AS descriptor_brief,
    NULL::money AS amount,
    NULL::money AS amount_gst,
    NULL::integer AS fk_items_billed,
    NULL::integer AS fk_lu_payment_method,
    NULL::money AS payment_amount,
    NULL::text AS billing_type,
    NULL::text AS payment_method,
    lu_reasons_not_billed.reason AS reason_not_billed,
    (((lu_title.title || ' '::text) || (data_persons.firstname || ' '::text)) || (data_persons.surname || ' '::text)) AS wholename,
    data_persons.firstname,
    data_persons.surname,
    lu_title.title,
    data_persons.fk_sex,
    NULL::text AS account_to_name,
    clinics.fk_branch
   FROM (((((clerical.bookings
     JOIN clerical.data_patients ON ((bookings.fk_patient = data_patients.pk)))
     JOIN admin.clinics ON ((bookings.fk_clinic = clinics.pk)))
     LEFT JOIN lu_reasons_not_billed ON ((bookings.fk_lu_reason_not_billed = lu_reasons_not_billed.pk)))
     JOIN contacts.data_persons ON ((data_patients.fk_person = data_persons.pk)))
     JOIN contacts.lu_title ON ((data_persons.fk_title = lu_title.pk)))
  WHERE (bookings.fk_lu_reason_not_billed IS NOT NULL);


ALTER TABLE billing.vwdaylist OWNER TO easygp;

--
-- Name: vwfees; Type: VIEW; Schema: billing; Owner: easygp
--

CREATE VIEW billing.vwfees AS
 SELECT prices.pk AS pk_view,
    fee_schedule.mbs_item,
    fee_schedule.user_item,
    fee_schedule.ama_item,
    fee_schedule.descriptor,
    fee_schedule.descriptor_brief,
    fee_schedule.gst_rate,
    fee_schedule.percentage_fee_rule,
    fee_schedule.ceased_date,
    fee_schedule."group",
    fee_schedule.derived_fee,
    fee_schedule.number_of_patients,
    prices.fk_fee_schedule,
    prices.pk AS fk_price,
    prices.price,
    prices.fk_lu_billing_type,
    prices.notes,
    lu_billing_type.type AS fee_type
   FROM ((fee_schedule
     JOIN prices ON ((fee_schedule.pk = prices.fk_fee_schedule)))
     JOIN lu_billing_type ON ((prices.fk_lu_billing_type = lu_billing_type.pk)));


ALTER TABLE billing.vwfees OWNER TO easygp;

--
-- Name: vwinvoices; Type: VIEW; Schema: billing; Owner: easygp
--
-- contacts.vwPatients gets dropped with the drop billing cascade:

CREATE OR REPLACE VIEW contacts.vwpatients AS 
 SELECT
        CASE
            WHEN addresses.pk IS NULL THEN patients.pk || '-0'::text
            ELSE (patients.pk || '-'::text) || addresses.pk
        END AS pk_view,
    patients.pk AS fk_patient,
    link_person_address.fk_address,
    patients.fk_person,
    ((title.title || ' '::text) || (persons.firstname || ' '::text)) || persons.surname AS wholename,
    patients.fk_doctor,
    patients.fk_next_of_kin,
    patients.fk_payer_person,
    patients.fk_payer_branch,
    patients.fk_family,
    patients.medicare_number,
    patients.medicare_ref_number,
    patients.medicare_expiry_date,
    patients.veteran_number,
    patients.veteran_specific_condition,
    patients.concession_card_number,
    patients.concession_card_expiry_date,
    patients.memo AS patient_memo,
    patients.fk_legacy,
    patients.fk_lu_aboriginality,
    patients.fk_lu_veteran_card_type,
    patients.fk_lu_active_status,
    patients.fk_lu_centrelink_card_type,
    patients.fk_lu_private_health_fund,
    patients.private_insurance,
    lu_active_status.status AS active_status,
    lu_veteran_card_type.type AS veteran_card_type,
    lu_centrelink_card_type.type AS concession_card_type,
    lu_private_health_funds.fund,
    persons.firstname,
    persons.surname,
    persons.salutation,
    persons.birthdate,
    age_display(age(persons.birthdate::timestamp with time zone)) AS age_display,
    date_part('year'::text, age(persons.birthdate::timestamp with time zone)) AS age_numeric,
    persons.fk_ethnicity,
    persons.fk_language,
    persons.memo AS person_memo,
    persons.fk_marital,
    persons.fk_title,
    persons.fk_sex,
    persons.country_code AS country_birth_country_code,
    persons.fk_image,
    persons.retired,
    persons.fk_occupation,
    persons.deleted AS person_deleted,
    persons.deceased,
    persons.date_deceased,
    persons.language_problems,
    persons.surname_normalised,
    lu_aboriginality.aboriginality,
    country_birth.country AS country_birth,
    lu_ethnicity.ethnicity,
    lu_languages.language,
    lu_occupations.occupation,
    lu_marital.marital,
    title.title,
    lu_sex.sex,
    lu_sex.sex_text,
    images.image,
    images.md5sum,
    images.tag,
    images.fk_consult AS fk_consult_image,
    link_person_address.pk AS fk_link_persons_address,
    addresses.street1,
    addresses.fk_town,
    addresses.preferred_address,
    addresses.postal_address,
    addresses.head_office,
    addresses.geolocation,
    addresses.country_code,
    addresses.fk_lu_address_type,
    addresses.deleted AS address_deleted,
    addresses.street2,
    address_country.country,
    link_person_address.deleted AS link_address_deleted,
    lu_address_types.type AS address_type,
    lu_towns.postcode,
    lu_towns.town,
    lu_towns.state,
    patients.fk_lu_default_billing_level,
    lu_default_billing_level.level AS billing_level,
    patients.nursing_home_resident,
    patients.ihi,
    patients.pcehr_consent,
    patients.ihi_updated,
    patients.fk_branch_pharmacy,
    patients.uses_webster_pack,
    patients.memo_for_pharmacy,
    patients.patient_at_practice_since
   FROM clerical.data_patients patients
     JOIN clerical.lu_active_status lu_active_status ON patients.fk_lu_active_status = lu_active_status.pk
     LEFT JOIN clerical.lu_centrelink_card_type ON patients.fk_lu_centrelink_card_type = lu_centrelink_card_type.pk
     LEFT JOIN common.lu_aboriginality ON patients.fk_lu_aboriginality = lu_aboriginality.pk
     LEFT JOIN clerical.lu_veteran_card_type ON patients.fk_lu_veteran_card_type = lu_veteran_card_type.pk
     LEFT JOIN clerical.lu_private_health_funds ON patients.fk_lu_private_health_fund = lu_private_health_funds.pk
     LEFT JOIN billing.lu_default_billing_level ON patients.fk_lu_default_billing_level = lu_default_billing_level.pk
     JOIN contacts.data_persons persons ON patients.fk_person = persons.pk
     LEFT JOIN common.lu_ethnicity ON persons.fk_ethnicity = lu_ethnicity.pk
     LEFT JOIN common.lu_languages ON persons.fk_language = lu_languages.pk
     LEFT JOIN common.lu_occupations ON persons.fk_occupation = lu_occupations.pk
     LEFT JOIN contacts.lu_marital ON persons.fk_marital = lu_marital.pk
     LEFT JOIN contacts.lu_title title ON persons.fk_title = title.pk
     LEFT JOIN contacts.lu_sex ON persons.fk_sex = lu_sex.pk
     LEFT JOIN blobs.images images ON persons.fk_image = images.pk
     LEFT JOIN contacts.links_persons_addresses link_person_address ON persons.pk = link_person_address.fk_person
     LEFT JOIN contacts.data_addresses addresses ON link_person_address.fk_address = addresses.pk
     LEFT JOIN contacts.lu_address_types ON addresses.fk_lu_address_type = lu_address_types.pk
     LEFT JOIN contacts.lu_towns ON addresses.fk_town = lu_towns.pk
     LEFT JOIN common.lu_countries country_birth ON persons.country_code = country_birth.country_code::text
     LEFT JOIN common.lu_countries address_country ON addresses.country_code = address_country.country_code;

ALTER TABLE contacts.vwpatients   OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpatients TO staff;

CREATE OR REPLACE VIEW clerical.vwtaskscomponents AS 
 SELECT task_components.pk AS pk_view,
    tasks.related_to,
    tasks.fk_row,
    tasks.fk_staff_finalised_task,
    tasks.date_finalised,
    tasks.deleted AS task_deleted,
    tasks.fk_staff_filed_task,
    tasks.fk_staff_must_finalise,
    tasks.fk_role_can_finalise,
    vwstaffinclinics.wholename AS staff_filed_task_wholename,
    vwstaffinclinics.title AS staff_filed_task_title,
    vwstaffinclinics2.title AS staff_finalised_task_title,
    vwstaffinclinics2.wholename AS staff_finalised_task_wholename,
    vwstaffinclinics3.title AS staff_must_finalise_task_title,
    vwstaffinclinics3.wholename AS staff_must_finalise_task_wholename,
    task_components.fk_role,
    task_components.pk AS fk_component,
    task_components.fk_task,
    task_components.fk_consult,
    task_components.fk_staff_allocated,
    task_components.fk_staff_completed,
    task_components.allocated_staff,
    task_components.fk_urgency,
    task_components.details,
    task_components.must_verify_completed,
    task_components.date_completed AS date_component_completed,
    task_components.deleted AS component_deleted,
    vwstaffinclinics1.wholename AS staff_allocated_wholename,
    vwstaffinclinics1.title AS staff_allocated_title,
    consult.consult_date AS date_component_logged,
    vwpatients.town AS patient_town,
    vwpatients.state AS patient_state,
    vwpatients.postcode AS patient_postcode,
    vwpatients.street1 AS patient_street1,
    vwpatients.street2 AS patient_street2,
    vwpatients.fk_person,
    vwpatients.fk_patient,
    vwpatients.wholename AS patient_wholename,
    vwpatients.title AS patient_title,
    vwpatients.birthdate AS patient_birthdate,
    lu_urgency.urgency
   FROM clerical.task_components
     JOIN clerical.tasks ON task_components.fk_task = tasks.pk
     JOIN admin.vwstaffinclinics ON tasks.fk_staff_filed_task = vwstaffinclinics.fk_staff
     LEFT JOIN admin.vwstaffinclinics vwstaffinclinics1 ON task_components.fk_staff_allocated = vwstaffinclinics1.fk_staff
     LEFT JOIN admin.vwstaffinclinics vwstaffinclinics2 ON tasks.fk_staff_finalised_task = vwstaffinclinics2.fk_staff
     LEFT JOIN admin.vwstaffinclinics vwstaffinclinics3 ON tasks.fk_staff_must_finalise = vwstaffinclinics3.fk_staff
     JOIN clin_consult.consult ON task_components.fk_consult = consult.pk
     JOIN contacts.vwpatients ON consult.fk_patient = vwpatients.fk_patient
     JOIN common.lu_urgency ON task_components.fk_urgency = lu_urgency.pk
  WHERE task_components.fk_consult > 0
  ORDER BY vwpatients.fk_patient, task_components.pk;

ALTER TABLE clerical.vwtaskscomponents   OWNER TO easygp;
GRANT SELECT ON TABLE clerical.vwtaskscomponents TO staff;

CREATE OR REPLACE VIEW clerical.vwtaskscomponentsandnotes AS 
 SELECT
        CASE
            WHEN task_component_notes.pk IS NULL THEN task_components.pk || '-0'::text
            ELSE (task_components.pk || '-'::text) || task_component_notes.pk
        END AS pk_view,
    tasks.related_to AS task,
    task_components.details,
    task_component_notes.note,
    tasks.fk_row,
    tasks.fk_staff_finalised_task,
    tasks.fk_staff_must_finalise,
    tasks.fk_role_can_finalise,
    tasks.date_finalised,
    tasks.deleted AS task_deleted,
    tasks.fk_staff_filed_task,
    vwstaffinclinics.wholename AS staff_filed_task_wholename,
    vwstaffinclinics.title AS staff_filed_task_title,
    vwstaffinclinics2.title AS staff_finalised_task_title,
    vwstaffinclinics2.wholename AS staff_finalised_task_wholename,
    vwstaffinclinics3.title AS staff_must_finalise_task_title,
    vwstaffinclinics3.wholename AS staff_must_finalise_task_wholename,
    task_components.fk_role,
    lu_staff_roles.role AS role_allocated,
    task_components.pk AS fk_component,
    task_components.fk_task,
    task_components.fk_consult,
    task_components.fk_staff_allocated,
    task_components.fk_staff_completed,
    task_components.allocated_staff,
    task_components.fk_urgency,
    task_components.date_completed AS date_component_completed,
    task_components.deleted AS component_deleted,
    vwstaffinclinics1.wholename AS staff_allocated_wholename,
    vwstaffinclinics1.title AS staff_allocated_title,
    consult.consult_date AS date_component_logged,
    vwpatients.town AS patient_town,
    vwpatients.state AS patient_state,
    vwpatients.postcode AS patient_postcode,
    vwpatients.street1 AS patient_street1,
    vwpatients.street2 AS patient_street2,
    vwpatients.fk_person,
    vwpatients.fk_patient,
    vwpatients.wholename AS patient_wholename,
    vwpatients.title AS patient_title,
    vwpatients.birthdate AS patient_birthdate,
    lu_urgency.urgency,
    task_component_notes.pk AS fk_task_component_note,
    task_component_notes.date AS date_note,
    task_component_notes.fk_staff_made_note,
    vwstaffinclinics4.wholename AS staff_made_note_wholename,
    vwstaffinclinics4.title AS staff_made_note_title
   FROM clerical.task_components
     JOIN clerical.tasks ON task_components.fk_task = tasks.pk
     JOIN admin.vwstaffinclinics ON tasks.fk_staff_filed_task = vwstaffinclinics.fk_staff
     LEFT JOIN admin.vwstaffinclinics vwstaffinclinics1 ON task_components.fk_staff_allocated = vwstaffinclinics1.fk_staff
     LEFT JOIN admin.vwstaffinclinics vwstaffinclinics2 ON tasks.fk_staff_finalised_task = vwstaffinclinics2.fk_staff
     LEFT JOIN admin.vwstaffinclinics vwstaffinclinics3 ON tasks.fk_staff_must_finalise = vwstaffinclinics3.fk_staff
     JOIN clin_consult.consult ON task_components.fk_consult = consult.pk
     JOIN contacts.vwpatients ON consult.fk_patient = vwpatients.fk_patient
     JOIN common.lu_urgency ON task_components.fk_urgency = lu_urgency.pk
     LEFT JOIN clerical.task_component_notes ON task_components.pk = task_component_notes.fk_task_component
     LEFT JOIN admin.vwstaffinclinics vwstaffinclinics4 ON task_component_notes.fk_staff_made_note = vwstaffinclinics4.fk_staff
     LEFT JOIN admin.lu_staff_roles ON task_components.fk_role = lu_staff_roles.pk
  WHERE task_components.fk_consult > 0
  ORDER BY vwpatients.fk_patient, task_components.pk;

ALTER TABLE clerical.vwtaskscomponentsandnotes   OWNER TO easygp;
GRANT SELECT ON TABLE clerical.vwtaskscomponentsandnotes TO staff;

COMMENT ON VIEW clerical.vwtaskscomponentsandnotes
  IS 'the tasks and each component in it''s actioning and any associated notes.
  Note: if task_components.fk_role is not null then anyone of that role can action it
       hence lu_staff_roles.role as role_can_action gives the text for that role e.g secretary
       this is also why staff_made_note_wholename to indicate which staff actually did the component';

CREATE OR REPLACE VIEW clin_consult.vwdictations AS 
 SELECT d.pk AS pk_dictation,
    d.fk_referral,
    d.transcript,
    d.fk_progress_note,
    d.fk_user,
    d.processed,
    d.filename,
    vwp.wholename,
    c.fk_patient
   FROM clin_consult.dictations d,
    clin_referrals.referrals r,
    contacts.vwpatients vwp,
    clin_consult.consult c
  WHERE d.fk_referral = r.pk AND r.fk_consult = c.pk AND c.fk_patient = vwp.fk_patient;

ALTER TABLE clin_consult.vwdictations  OWNER TO easygp;
GRANT ALL ON TABLE clin_consult.vwdictations TO staff;

CREATE OR REPLACE VIEW clin_history.vwresponsiblepersons AS 
 SELECT vwpatients.surname,
    vwpatients.firstname,
    vwsocialhistory.responsible_person,
    vwsocialhistory.fk_responsible_person,
    vwsocialhistory.person_responsible_wholename,
    vwsocialhistory.history,
    vwpatients.active_status,
    vwpatients.age_numeric,
    vwpatients.deceased
   FROM clin_history.vwsocialhistory,
    contacts.vwpatients
  WHERE vwsocialhistory.fk_patient = vwpatients.fk_patient AND vwpatients.age_numeric < 90::double precision AND vwpatients.active_status = 'active'::text AND vwpatients.deceased = false AND vwpatients.person_deleted = false;

ALTER TABLE clin_history.vwresponsiblepersons   OWNER TO easygp;
GRANT SELECT ON TABLE clin_history.vwresponsiblepersons TO staff;

CREATE OR REPLACE VIEW research.vwfentanylpatients AS 
 SELECT DISTINCT vwpatients.firstname,
    vwpatients.surname
   FROM clin_prescribing.vwprescribeditems,
    contacts.vwpatients
  WHERE vwprescribeditems.fk_patient = vwpatients.fk_patient AND vwprescribeditems.generic ~~* '%fentanyl%'::text;

ALTER TABLE research.vwfentanylpatients   OWNER TO easygp;
GRANT SELECT ON research.vwfentanylpatients TO staff;

CREATE OR REPLACE VIEW clin_recalls.vwrecallsdue AS 
 SELECT recalls.pk AS pk_recall,
    recalls.fk_consult,
    recalls.due,
    recalls.due - date(now()) AS days_due,
    recalls.fk_reason,
    recalls.fk_contact_method,
    recalls.fk_urgency,
    recalls.fk_appointment_length,
    recalls.fk_staff,
    recalls.active,
    recalls.additional_text,
    recalls.deleted,
    recalls."interval",
    recalls.fk_interval_unit,
    recalls.fk_progressnote,
    recalls.fk_pasthistory,
    recalls.fk_sent,
    recalls.num_reminders,
    sent.latex,
    sent.date AS date_reminder_sent,
    lu_units.abbrev_text,
    vwpatients.fk_person,
    vwpatients.wholename,
    vwpatients.firstname,
    vwpatients.surname,
    vwpatients.salutation,
    vwpatients.birthdate,
    vwpatients.age_numeric,
    vwpatients.sex,
    vwpatients.deceased,
    vwpatients.title,
    vwpatients.street1,
    vwpatients.street2,
    vwpatients.town,
    vwpatients.state,
    vwpatients.postcode,
    vwpatients.language_problems,
    vwpatients.language,
    consult.fk_patient,
    vwstaff.firstname AS staff_to_see_firstname,
    vwstaff.surname AS staff_to_see_surname,
    vwstaff.wholename AS staff_to_see_wholename,
    vwstaff.title AS staff_to_see_title,
    lu_reasons.reason,
    lu_urgency.urgency,
    lu_contact_type.type AS contact_method,
    lu_appointment_length.length AS appointment_length,
    consult.consult_date,
    recalls.fk_template,
    lu_appointment_length1.length,
    lu_templates.name,
    lu_templates.template
   FROM clin_recalls.recalls
     JOIN clin_consult.consult ON recalls.fk_consult = consult.pk
     JOIN contacts.vwpatients ON consult.fk_patient = vwpatients.fk_patient
     JOIN admin.vwstaff ON recalls.fk_staff = vwstaff.fk_staff
     JOIN clin_recalls.lu_reasons ON recalls.fk_reason = lu_reasons.pk
     JOIN common.lu_urgency ON recalls.fk_urgency = lu_urgency.pk
     JOIN contacts.lu_contact_type ON recalls.fk_contact_method = lu_contact_type.pk
     JOIN common.lu_appointment_length ON recalls.fk_appointment_length = lu_appointment_length.pk
     LEFT JOIN common.lu_units ON recalls.fk_interval_unit = lu_units.pk
     LEFT JOIN clin_recalls.lu_templates ON recalls.fk_template = lu_templates.pk
     LEFT JOIN common.lu_appointment_length lu_appointment_length1 ON lu_templates.fk_lu_appointment_length = lu_appointment_length1.pk
     LEFT JOIN clin_recalls.sent ON recalls.fk_sent = sent.pk
  WHERE recalls.deleted = false
  ORDER BY recalls.due - date(now()), consult.fk_patient;

ALTER TABLE clin_recalls.vwrecallsdue   OWNER TO easygp;
GRANT ALL ON TABLE clin_recalls.vwrecallsdue TO staff;

CREATE OR REPLACE VIEW documents.vwdocuments AS 
 SELECT documents.pk AS pk_document,
    documents.source_file,
    documents.fk_sending_entity,
    documents.imported_time,
    documents.date_requested,
    documents.date_created,
    documents.fk_patient,
    documents.fk_staff_filed_document,
    documents.originator,
    documents.originator_reference,
    documents.copy_to,
    documents.provider_of_service_reference,
    documents.internal_reference,
    documents.copies_to,
    documents.fk_staff_destination,
    documents.comment_on_document,
    documents.patient_access,
    documents.concluded,
    documents.deleted,
    documents.fk_lu_urgency,
    documents.tag,
    documents.tag_user,
    documents.md5sum,
    documents.data,
    documents.fk_lu_data_content_type,
    documents.fk_unmatched_staff,
    documents.fk_referral,
    documents.fk_request,
    documents.incoming_referral,
    documents.fk_unmatched_patient,
    documents.fk_lu_display_as,
    documents.fk_lu_request_type,
    documents.protected,
    lu_data_content_type.data_content_type,
    lu_request_type.type AS request_type,
    vwsendingentities.fk_lu_request_type AS sending_entity_fk_lu_request_type,
    vwsendingentities.request_type AS sending_entity_request_type,
    vwsendingentities.style,
    vwsendingentities.message_type,
    vwsendingentities.message_version,
    vwsendingentities.msh_sending_entity,
    vwsendingentities.msh_transmitting_entity,
    vwsendingentities.fk_lu_message_display_style,
    vwsendingentities.fk_branch AS fk_sender_branch,
    vwsendingentities.fk_employee AS fk_employee_branch,
    vwsendingentities.fk_person AS fk_sender_person,
    vwsendingentities.fk_lu_message_standard,
    vwsendingentities.exclude_ft_report,
    vwsendingentities.abnormals_foreground_color,
    vwsendingentities.abnormals_background_color,
    vwsendingentities.exclude_pit,
    vwsendingentities.person_occupation,
    vwsendingentities.organisation,
    vwsendingentities.organisation_category,
    vwpatients.fk_person AS patient_fk_person,
    vwpatients.firstname AS patient_firstname,
    vwpatients.surname AS patient_surname,
    vwpatients.birthdate AS patient_birthdate,
    vwpatients.sex AS patient_sex,
    vwpatients.age_numeric AS patient_age,
    vwpatients.title AS patient_title,
    vwpatients.street1 AS patient_street1,
    vwpatients.street2 AS patient_street2,
    vwpatients.town AS patient_town,
    vwpatients.state AS patient_state,
    vwpatients.postcode AS patient_postcode,
    vwpatients.fk_person,
    vwstaff.wholename AS staff_destination_wholename,
    vwstaff.title AS staff_destination_title,
    unmatched_patients.surname AS unmatched_patient_surname,
    unmatched_patients.firstname AS unmatched_patient_firstname,
    unmatched_patients.birthdate AS unmatched_patient_birthdate,
    unmatched_patients.sex AS unmatched_patient_sex,
    unmatched_patients.title AS unmatched_patient_title,
    unmatched_patients.street AS unmatched_patient_street,
    unmatched_patients.town AS unmatched_patient_town,
    unmatched_patients.postcode AS unmatched_patient_postcode,
    unmatched_patients.state AS unmatched_patient_state,
    unmatched_staff.surname AS unmatched_staff_surname,
    unmatched_staff.firstname AS unmatched_staff_firstname,
    unmatched_staff.title AS unmatched_staff_title,
    unmatched_staff.provider_number AS unmatched_staff_provider_number,
    vwsendingentities.provider_number
   FROM documents.documents
     JOIN documents.vwsendingentities ON documents.fk_sending_entity = vwsendingentities.pk_sending_entities
     LEFT JOIN clin_requests.lu_request_type ON documents.fk_lu_request_type = lu_request_type.pk
     LEFT JOIN contacts.vwpatients ON documents.fk_patient = vwpatients.fk_patient
     LEFT JOIN admin.vwstaff ON documents.fk_staff_destination = vwstaff.fk_staff
     LEFT JOIN documents.unmatched_patients ON documents.fk_unmatched_patient = unmatched_patients.pk
     LEFT JOIN documents.unmatched_staff ON documents.fk_unmatched_staff = unmatched_staff.pk
     LEFT JOIN documents.lu_data_content_type ON documents.fk_lu_data_content_type = lu_data_content_type.pk
  ORDER BY documents.fk_patient, documents.date_created;

ALTER TABLE documents.vwdocuments   OWNER TO easygp;
GRANT SELECT ON TABLE documents.vwdocuments TO staff;

CREATE OR REPLACE VIEW clin_requests.vwrequestsordered AS 
 SELECT (forms.pk || '-'::text) || forms_requests.pk AS pk_view,
    forms.fk_lu_request_type,
    lu_request_type.type,
    forms.fk_consult,
    consult.consult_date,
    consult.fk_patient,
    data_persons.firstname,
    data_persons.surname,
    data_persons.birthdate,
    data_persons.fk_sex,
    forms_requests.fk_form,
    forms.requests_summary,
    forms_requests.pk AS fk_forms_requests,
    lu_requests.item,
    forms.date,
    forms_requests.request_result_html,
    forms.fk_progressnote,
    forms_requests.fk_lu_request,
    forms_requests.deleted AS request_deleted,
    lu_requests.fk_laterality,
    forms.fk_request_provider AS fk_branch,
    forms.notes_summary,
    forms.medications_summary,
    forms.copyto,
    forms.deleted,
    forms.copyto_patient,
    forms.urgent,
    forms.bulk_bill,
    forms.fasting,
    forms.phone,
    forms.fax,
    forms.include_medications,
    forms.pk_image AS fk_image,
    forms.fk_pasthistory,
    past_history.description,
    lu_title.title AS staff_title,
    staff.pk AS fk_staff,
    data_persons1.firstname AS staff_firstname,
    data_persons1.surname AS staff_surname,
    data_branches.branch,
    data_branches.fk_organisation,
    data_organisations.organisation,
    vwdocuments.data,
    vwdocuments.data_content_type,
    vwdocuments.fk_lu_data_content_type
   FROM clin_requests.forms
     JOIN clin_requests.forms_requests ON forms.pk = forms_requests.fk_form
     JOIN clin_requests.lu_requests ON forms_requests.fk_lu_request = lu_requests.pk
     JOIN clin_requests.lu_request_type ON lu_requests.fk_lu_request_type = lu_request_type.pk
     JOIN clin_consult.consult ON forms.fk_consult = consult.pk
     JOIN clerical.data_patients ON consult.fk_patient = data_patients.pk
     JOIN contacts.data_persons ON data_patients.fk_person = data_persons.pk
     LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
     JOIN admin.staff ON consult.fk_staff = staff.pk
     JOIN contacts.data_persons data_persons1 ON staff.fk_person = data_persons1.pk
     LEFT JOIN contacts.data_branches ON forms.fk_request_provider = data_branches.pk
     LEFT JOIN contacts.data_organisations ON data_branches.fk_organisation = data_organisations.pk
     LEFT JOIN clin_history.past_history ON forms.fk_pasthistory = past_history.pk
     LEFT JOIN documents.vwdocuments ON forms_requests.pk = vwdocuments.fk_request
  WHERE forms.deleted = false AND forms_requests.deleted = false
  ORDER BY consult.fk_patient, forms.date DESC, forms_requests.fk_form, lu_requests.item;

ALTER TABLE clin_requests.vwrequestsordered   OWNER TO easygp;
GRANT SELECT ON TABLE clin_requests.vwrequestsordered TO staff;

CREATE OR REPLACE VIEW documents.vwhl7filesimported AS 
 SELECT DISTINCT vwdocuments.source_file
   FROM documents.vwdocuments
  WHERE vwdocuments.md5sum IS NULL
  ORDER BY vwdocuments.source_file;

ALTER TABLE documents.vwhl7filesimported   OWNER TO easygp;
GRANT SELECT ON TABLE documents.vwhl7filesimported TO staff;


CREATE OR REPLACE VIEW research.vwmostrecenteyerelateddocuments AS 
 SELECT DISTINCT ON (vwdocuments.fk_patient) vwdocuments.fk_patient AS pk_view,
    vwdocuments.fk_patient,
    vwdocuments.pk_document AS fk_document,
    vwdocuments.date_created,
    vwdocuments.deleted
   FROM documents.vwdocuments
  WHERE (vwdocuments.organisation_category::text ~~* '%ophthal%'::text OR vwdocuments.organisation_category::text ~~* '%optom%'::text OR vwdocuments.person_occupation ~~* '%ophthal%'::text OR vwdocuments.person_occupation ~~* '%optom%'::text) AND vwdocuments.deleted = false
  ORDER BY vwdocuments.fk_patient, vwdocuments.date_created DESC;

ALTER TABLE research.vwmostrecenteyerelateddocuments   OWNER TO richard;
GRANT ALL ON TABLE research.vwmostrecenteyerelateddocuments TO easygp;
GRANT SELECT ON TABLE research.vwmostrecenteyerelateddocuments TO staff;

COMMENT ON VIEW research.vwmostrecenteyerelateddocuments
  IS 'This is a view of the most recent eye related document found in the database.
Quite dependant on the user allocating an eye-related category.
Though not specific to diabetics, it is currently only used in FDiabetesResearch 
The view key pk_view=fk_patient so once we have all diabetic patients, the view 
yields their eye documents. I put in fk_patient only to remind anyone viewing the
data that pk_view = fk_patient';


CREATE OR REPLACE VIEW research.diabetes_patients_latest_hba1c AS 
 SELECT DISTINCT vwobservations.fk_patient,
    vwpatients.wholename,
    vwpatients.surname,
    vwpatients.firstname,
    vwpatients.birthdate,
    vwpatients.age_numeric,
    ( SELECT vwobservations_1.observation_date
           FROM documents.vwobservations vwobservations_1
          WHERE vwobservations_1.fk_patient = vwpatients.fk_patient AND vwobservations_1.loinc = '4548-4'::text
          ORDER BY vwobservations_1.observation_date DESC
         LIMIT 1) AS observation_date,
    ( SELECT vwobservations_1.value_numeric
           FROM documents.vwobservations vwobservations_1
          WHERE vwobservations_1.fk_patient = vwpatients.fk_patient AND vwobservations_1.loinc = '4548-4'::text
          ORDER BY vwobservations_1.observation_date DESC
         LIMIT 1) AS hba1c
   FROM contacts.vwpatients,
    documents.vwobservations
  WHERE vwobservations.fk_patient = vwpatients.fk_patient AND vwobservations.loinc = '4548-4'::text
  ORDER BY ( SELECT vwobservations_1.value_numeric
           FROM documents.vwobservations vwobservations_1
          WHERE vwobservations_1.fk_patient = vwpatients.fk_patient AND vwobservations_1.loinc = '4548-4'::text
          ORDER BY vwobservations_1.observation_date DESC
         LIMIT 1);

ALTER TABLE research.diabetes_patients_latest_hba1c   OWNER TO easygp;
GRANT SELECT ON TABLE research.diabetes_patients_latest_hba1c TO staff;


CREATE OR REPLACE VIEW research.diabetes_patients_with_hba1c AS 
 SELECT DISTINCT vwgraphableobservations.observation_date,
    vwgraphableobservations.loinc,
    vwgraphableobservations.value_numeric,
    vwpatients.firstname,
    vwpatients.wholename,
    vwpatients.age_display,
    vwpatients.sex,
    vwpatients.title,
    vwpatients.street1,
    vwpatients.street2,
    vwpatients.town,
    vwpatients.state,
    vwpatients.occupation,
    vwpatients.postcode,
    vwpatients.surname,
    vwpatients.birthdate,
    vwpatients.age_numeric,
    vwpatients.marital
   FROM contacts.vwpatients,
    documents.vwgraphableobservations
  WHERE vwgraphableobservations.fk_patient = vwpatients.fk_patient AND vwgraphableobservations.loinc = '4548-4'::text;

ALTER TABLE research.diabetes_patients_with_hba1c   OWNER TO easygp;
GRANT SELECT ON TABLE research.diabetes_patients_with_hba1c TO staff;

CREATE OR REPLACE VIEW research.patientsnameshba1cover75 AS 
 SELECT DISTINCT vwpatients.wholename,
    vwpatients.age_display,
    vwpatients.sex
   FROM contacts.vwpatients,
    documents.patientshba1cover75
  WHERE patientshba1cover75.fk_patient = vwpatients.fk_patient;

ALTER TABLE research.patientsnameshba1cover75   OWNER TO easygp;
GRANT SELECT ON TABLE research.patientsnameshba1cover75 TO staff;

CREATE OR REPLACE VIEW research.vwdiabetes_patients_with_hba1c AS 
 SELECT DISTINCT vwgraphableobservations.pk_observations,
    vwgraphableobservations.observation_date,
    vwgraphableobservations.loinc,
    vwgraphableobservations.value_numeric,
    vwpatients.fk_patient,
    vwpatients.firstname,
    vwpatients.surname,
    vwpatients.wholename,
    vwpatients.age_display,
    vwpatients.sex,
    vwpatients.title,
    vwpatients.occupation,
    vwpatients.fk_image,
    vwpatients.birthdate,
    vwpatients.age_numeric,
    vwpatients.marital,
    vwpatients.fk_person,
    vwpatients.deceased,
    vwpatients.active_status,
    vwpatients.street1,
    vwpatients.street2,
    vwpatients.town,
    vwpatients.state,
    vwpatients.postcode
   FROM contacts.vwpatients,
    documents.vwgraphableobservations
  WHERE vwgraphableobservations.fk_patient = vwpatients.fk_patient AND vwgraphableobservations.loinc = '4548-4'::text;

ALTER TABLE research.vwdiabetes_patients_with_hba1c   OWNER TO richard;
GRANT ALL ON TABLE research.vwdiabetes_patients_with_hba1c TO easygp;
GRANT ALL ON TABLE research.vwdiabetes_patients_with_hba1c TO staff;
COMMENT ON VIEW research.vwdiabetes_patients_with_hba1c
  IS 'all patients and all their hba1''s, including deceased and those left the practice
 this view could also contain patients who are not diabetic if someone has done
 their hab1c without good cause or logic - mind you there is a push to make
 hba1c a diagnostic tool heaven forbid
 The GUI layer must use  chronic_disease_management.diabetes_hba1c_not_diabetic
 to filter these non-diabetics out of stats - or at least that is how I''ve done it';


CREATE OR REPLACE VIEW research.vwdiabetics_with_ldlcholesterol AS 
 SELECT vwdiabetes_patients_with_hba1c.fk_patient AS pk_view,
    vwgraphableobservations.loinc,
    vwgraphableobservations.value_numeric,
    vwgraphableobservations.value_numeric_qualifier,
    vwdiabetes_patients_with_hba1c.fk_patient,
    vwdiabetes_patients_with_hba1c.deceased,
    vwdiabetes_patients_with_hba1c.active_status,
    vwgraphableobservations.identifier,
    vwgraphableobservations.observation_date,
    vwgraphableobservations.reference_range,
    vwgraphableobservations.abnormal
   FROM research.vwdiabetes_patients_with_hba1c,
    documents.vwgraphableobservations
  WHERE vwdiabetes_patients_with_hba1c.fk_patient = vwgraphableobservations.fk_patient AND vwgraphableobservations.loinc = '22748-8'::text;

ALTER TABLE research.vwdiabetics_with_ldlcholesterol   OWNER TO richard;
GRANT ALL ON TABLE research.vwdiabetics_with_ldlcholesterol TO easygp;
GRANT SELECT ON TABLE research.vwdiabetics_with_ldlcholesterol TO staff;

COMMENT ON VIEW research.vwdiabetics_with_ldlcholesterol
  IS 'a view of all diabetes and their LDL Cholesterol Levels
 note as the fk_patient of the diabetes view is linked to the fk_patient of the observations view
 there is always a 1-1 relationship between these views
 this view could also contain patients who are not diabetic if someone has done
 their hab1c without good cause or logic 
 The GUI layer must use  chronic_disease_management.diabetes_hba1c_not_diabetic
 to filter these non-diabetics out of stats - or at least that is how I''ve done it';

 CREATE OR REPLACE VIEW research.vwdiabetics_with_microalbumins AS 
 SELECT vwmicroalbuminuria.identifier,
    vwmicroalbuminuria.observation_date,
    vwmicroalbuminuria.value_numeric,
    vwmicroalbuminuria.value_numeric_qualifier,
    vwmicroalbuminuria.units,
    vwmicroalbuminuria.reference_range,
    vwmicroalbuminuria.abnormal,
    vwmicroalbuminuria.loinc,
    vwdiabetes_patients_with_hba1c.fk_patient,
    vwdiabetes_patients_with_hba1c.fk_patient AS pk_view,
    vwdiabetes_patients_with_hba1c.deceased,
    vwdiabetes_patients_with_hba1c.active_status
   FROM research.vwmicroalbuminuria,
    research.vwdiabetes_patients_with_hba1c
  WHERE vwmicroalbuminuria.fk_patient = vwdiabetes_patients_with_hba1c.fk_patient
  ORDER BY vwdiabetes_patients_with_hba1c.fk_patient, vwmicroalbuminuria.observation_date;

ALTER TABLE research.vwdiabetics_with_microalbumins   OWNER TO richard;
GRANT ALL ON TABLE research.vwdiabetics_with_microalbumins TO easygp;
GRANT ALL ON TABLE research.vwdiabetics_with_microalbumins TO staff;
COMMENT ON VIEW research.vwdiabetics_with_microalbumins

  IS 'A view of all patient''s with hab1c''s who also have had some sort of microalbumnin test (4 different LOINC''s
 Note the pk_view does not have to be unique we only pull out a single record for each patient when used (our collections must have unique keys)';

 CREATE OR REPLACE VIEW research.vwdiabeticsegfr AS 
 SELECT vwdiabetes_patients_with_hba1c.fk_patient AS pk_view,
    vwgraphableobservations.loinc,
    vwgraphableobservations.value_numeric,
    vwgraphableobservations.value_numeric_qualifier,
    vwdiabetes_patients_with_hba1c.fk_patient,
    vwdiabetes_patients_with_hba1c.deceased,
    vwdiabetes_patients_with_hba1c.active_status,
    vwgraphableobservations.identifier,
    vwgraphableobservations.observation_date,
    vwgraphableobservations.reference_range,
    vwgraphableobservations.abnormal
   FROM research.vwdiabetes_patients_with_hba1c,
    documents.vwgraphableobservations
  WHERE vwdiabetes_patients_with_hba1c.fk_patient = vwgraphableobservations.fk_patient AND vwgraphableobservations.loinc = '33914-3'::text;

ALTER TABLE research.vwdiabeticsegfr   OWNER TO easygp;
GRANT SELECT ON TABLE research.vwdiabeticsegfr TO staff;

COMMENT ON VIEW research.vwdiabeticsegfr
  IS 'a view of all diabetes and their egfr''s
 note as the fk_patient of the diabetes view is linked to the fk_patient of the observations view
 there is always a 1-1 relationship between these views
 this view could also contain patients who are not diabetic if someone has done
 their hab1c without good cause or logic 
 The GUI layer must use  chronic_disease_management.diabetes_hba1c_not_diabetic
 to filter these non-diabetics out of stats - or at least that is how I''ve done it';
 
 
CREATE OR REPLACE VIEW research.vwldh AS 
 SELECT vwpatients.wholename,
    vwpatients.fk_patient,
    vwobservations.value_numeric,
    vwobservations.abnormal
   FROM contacts.vwpatients,
    documents.vwobservations
  WHERE vwobservations.identifier ~~* '%LDH%'::text AND vwobservations.fk_patient = vwpatients.fk_patient AND vwobservations.abnormal IS NOT NULL
  ORDER BY vwobservations.value_numeric;

ALTER TABLE research.vwldh   OWNER TO easygp;
GRANT ALL ON TABLE research.vwldh TO staff;


CREATE OR REPLACE VIEW clin_consult.vwpatientconsults AS 
 SELECT DISTINCT vwprogressnotes.consult_date AS pk_view,
    vwprogressnotes.fk_patient,
    vwprogressnotes.consult_date,
    vwprogressnotes.consult_type,
    vwprogressnotes.fk_staff,
    vwprogressnotes.title AS staff_title,
    vwprogressnotes.surname AS staff_surname,
    vwprogressnotes.firstname AS staff_firstname,
    vwprogressnotes.linked_table,
    vwprogressnotes.fk_type,
    vwpatients.wholename,
    vwpatients.firstname,
    vwpatients.surname,
    vwpatients.street1,
    vwpatients.street2,
    vwpatients.town,
    vwpatients.state,
    vwpatients.postcode,
    vwpatients.deceased,
    vwpatients.sex,
    vwpatients.title,
    vwpatients.birthdate,
    vwpatients.age_numeric,
    vwpatients.age_display
   FROM clin_consult.vwprogressnotes,
    contacts.vwpatients
  WHERE vwprogressnotes.fk_patient = vwpatients.fk_patient
  ORDER BY vwprogressnotes.consult_date;

ALTER TABLE clin_consult.vwpatientconsults  OWNER TO easygp;
GRANT ALL ON TABLE clin_consult.vwpatientconsults TO staff;

CREATE OR REPLACE VIEW clin_workcover.vwpatientswithworkcover AS 
 SELECT vwpatients.fk_patient,
    vwpatients.pk_view,
    vwpatients.fk_person,
    vwpatients.firstname,
    vwpatients.surname,
    vwpatients.birthdate,
    vwpatients.age_display,
    vwpatients.age_numeric,
    vwpatients.street2,
    vwpatients.street1,
    vwpatients.title,
    vwpatients.town,
    vwpatients.state,
    vwpatients.address_deleted,
    vwpatients.deceased,
    vwpatients.fk_lu_active_status
   FROM contacts.vwpatients,
    clin_workcover.vwworkcover
  WHERE vwpatients.fk_patient = vwworkcover.fk_patient;

ALTER TABLE clin_workcover.vwpatientswithworkcover   OWNER TO easygp;
GRANT SELECT ON TABLE clin_workcover.vwpatientswithworkcover TO staff;

CREATE OR REPLACE VIEW clerical.vwappointments AS 
 SELECT bookings.pk,
    bookings.fk_patient,
    bookings.fk_staff,
    bookings.begin,
    bookings.duration,
    bookings.notes,
    bookings.fk_staff_booked,
    bookings.fk_clinic,
    bookings.fk_lu_appointment_icon,
    bookings.fk_lu_appointment_status,
    bookings.deleted,
    bookings.invoiced,
    bookings.did_not_attend,
    bookings.fk_lu_reason_not_billed,
    data_patients.fk_payer_person,
    data_patients.fk_payer_branch,
    data_patients.fk_doctor,
    data_patients.fk_lu_default_billing_level,
    data_patients.medicare_number,
    data_patients.medicare_ref_number,
    data_patients.medicare_expiry_date,
    lu_veteran_card_type.type AS veteran_card_type,
    data_patients.veteran_number,
    data_patients.veteran_specific_condition,
    data_patients.concession_card_number,
    data_patients.concession_card_expiry_date,
    data_patients.nursing_home_resident,
    lu_centrelink_card_type.type AS concession_card_type,
    lu_private_health_funds.fund,
    lu_default_billing_level.level AS billing_level,
    data_persons.firstname,
    data_persons.surname,
    data_persons.birthdate,
    data_persons.pk AS fk_person,
    lu_sex.sex,
    lu_title.title,
    ((lu_title.title || ' '::text) || (data_persons.firstname || ' '::text)) || (data_persons.surname || ' '::text) AS wholename,
    age_display(age(data_persons.birthdate::timestamp with time zone)) AS age_display,
    date_part('year'::text, age(data_persons.birthdate::timestamp with time zone)) AS age_numeric,
    lu_reasons_not_billed.reason
   FROM clerical.bookings
     LEFT JOIN clerical.data_patients ON bookings.fk_patient = data_patients.pk
     LEFT JOIN clerical.lu_centrelink_card_type ON data_patients.fk_lu_centrelink_card_type = lu_centrelink_card_type.pk
     LEFT JOIN clerical.lu_private_health_funds ON data_patients.fk_lu_private_health_fund = lu_private_health_funds.pk
     LEFT JOIN clerical.lu_veteran_card_type ON data_patients.fk_lu_veteran_card_type = lu_veteran_card_type.pk
     LEFT JOIN contacts.data_persons ON data_patients.fk_person = data_persons.pk
     LEFT JOIN contacts.lu_sex ON data_persons.fk_sex = lu_sex.pk
     LEFT JOIN billing.lu_default_billing_level ON data_patients.fk_lu_default_billing_level = lu_default_billing_level.pk
     LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
     LEFT JOIN billing.lu_reasons_not_billed ON bookings.fk_lu_reason_not_billed = lu_reasons_not_billed.pk
  ORDER BY bookings.begin;

ALTER TABLE clerical.vwappointments   OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwappointments TO staff;





CREATE VIEW billing.vwinvoices AS
 SELECT invoices.pk AS pk_invoice,
    invoices.pk AS fk_invoice,
    invoices.notes,
    invoices.fk_staff_invoicing,
    invoices.fk_patient,
    invoices.date_printed,
    invoices.fk_staff_provided_service,
    invoices.date_invoiced,
    invoices.paid,
    invoices.fk_payer_person,
    invoices.fk_payer_branch,
    COALESCE(vworganisations.organisation, vwpersonsincludingpatients.wholename) AS account_to_name,
    vworganisations.branch AS account_to_branch,
    COALESCE(((vworganisations.street1 || ' '::text) || vworganisations.street2), vworganisations.street1, ((vwpersonsincludingpatients.street1 || ' '::text) || vwpersonsincludingpatients.street2), vwpersonsincludingpatients.street1) AS account_to_street,
    COALESCE(((vworganisations.town || ' '::text) || (vworganisations.postcode)::text), ((vwpersonsincludingpatients.town || ' '::text) || (vwpersonsincludingpatients.postcode)::text)) AS account_to_town_postcode,
    invoices.latex,
    invoices.fk_branch,
    invoices.visit_date,
    invoices.fk_appointment,
    bookings.begin AS appointment_time,
    bookings.duration,
    invoices.reference,
    invoices.fk_lu_bulk_billing_type,
    invoices.total_bill,
    invoices.total_paid,
    invoices.total_gst,
    (invoices.total_bill - invoices.total_paid) AS due,
    staff_invoicing.wholename AS staff_invoicing_wholename,
    staff_provider.wholename AS staff_provided_service_wholename,
    staff_provider.provider_number AS staff_provided_service_provider_number,
    staff_provider.australian_business_number,
    vwpatients.firstname AS patient_firstname,
    vwpatients.surname AS patient_surname,
    vwpatients.title AS patient_title,
    vwpatients.fk_sex AS patient_fk_sex,
    vwpatients.sex AS patient_sex,
    vwpatients.wholename AS patient_wholename,
    vwpatients.fk_lu_centrelink_card_type,
    vwpatients.fk_lu_default_billing_level,
    vworganisations1.branch,
    claims.claim_id,
    claims.result_code AS claim_result_code,
    claims.result_text AS claim_result_text,
    claims.claim_date,
    invoices.online,
    invoices.fk_claim,
    invoices.voucher_id,
    invoices.referrer_provider_number,
    invoices.referral_date,
    invoices.referral_duration,
    invoices.result_code,
    invoices.result_text,
    invoices.error_level,
    invoices.pms_claim_id,
    c1.description,
    c2.description AS claim_description,
    invoices.bank_details_upload,
    invoices.claimant_address_upload,
    vp2.medicare_number AS account_to_medicare_number,
    vp2.medicare_ref_number AS account_to_medicare_ref_number,
    vp2.birthdate AS account_to_birthdate,
    staff_provider.payee_provider_number
   FROM (((((((((((invoices
     JOIN admin.vwstaffinclinics staff_invoicing ON (((invoices.fk_staff_invoicing = staff_invoicing.fk_staff) AND (invoices.fk_branch = staff_invoicing.fk_branch))))
     JOIN admin.vwstaffinclinics staff_provider ON (((invoices.fk_staff_provided_service = staff_provider.fk_staff) AND (invoices.fk_branch = staff_provider.fk_branch))))
     JOIN contacts.vworganisations vworganisations1 ON ((invoices.fk_branch = vworganisations1.fk_branch)))
     LEFT JOIN clerical.bookings ON ((invoices.fk_appointment = bookings.pk)))
     LEFT JOIN contacts.vworganisations ON ((invoices.fk_payer_branch = vworganisations.fk_branch)))
     LEFT JOIN contacts.vwpersonsincludingpatients ON ((invoices.fk_payer_person = vwpersonsincludingpatients.fk_person)))
     LEFT JOIN contacts.vwpatients ON ((invoices.fk_patient = vwpatients.fk_patient)))
     LEFT JOIN claims ON ((invoices.fk_claim = claims.pk)))
     LEFT JOIN lu_codes c1 ON ((invoices.result_code = c1.code)))
     LEFT JOIN lu_codes c2 ON ((claims.result_code = c2.code)))
     LEFT JOIN contacts.vwpatients vp2 ON ((invoices.fk_payer_person = vp2.fk_person)));


ALTER TABLE billing.vwinvoices OWNER TO easygp;

--
-- Name: vwitemsbilled; Type: VIEW; Schema: billing; Owner: easygp
--

CREATE VIEW billing.vwitemsbilled AS
 SELECT items_billed.pk AS pk_items_billed,
    items_billed.fk_fee_schedule,
    items_billed.amount,
    items_billed.amount_gst,
    items_billed.fk_invoice,
    items_billed.fk_lu_billing_type,
    lu_billing_type.type AS billing_type,
    fee_schedule.mbs_item,
    fee_schedule.user_item,
    fee_schedule.ama_item,
    COALESCE(fee_schedule.mbs_item, fee_schedule.ama_item, fee_schedule.user_item) AS common_item,
    fee_schedule.descriptor,
    fee_schedule.descriptor_brief,
    fee_schedule.gst_rate,
    fee_schedule.percentage_fee_rule,
    items_billed.service_id,
    items_billed.reason_code,
    items_billed.comment,
    items_billed.error_level,
    lu_codes.description,
    fee_schedule.number_of_patients,
    items_billed.multiple_procedure,
    items_billed.aftercare,
    items_billed.duplicate,
    items_billed.separate_sites,
    items_billed.not_related,
    items_billed.procedure_duration,
    items_billed.field_quantity
   FROM (((items_billed
     JOIN lu_billing_type ON ((lu_billing_type.pk = items_billed.fk_lu_billing_type)))
     JOIN fee_schedule ON ((items_billed.fk_fee_schedule = fee_schedule.pk)))
     LEFT JOIN lu_codes ON ((items_billed.reason_code = lu_codes.code)));


ALTER TABLE billing.vwitemsbilled OWNER TO easygp;

--
-- Name: vwitemsandinvoices; Type: VIEW; Schema: billing; Owner: easygp
--

CREATE VIEW billing.vwitemsandinvoices AS
 SELECT vwitemsbilled.pk_items_billed,
    vwitemsbilled.fk_fee_schedule,
    vwitemsbilled.amount,
    vwitemsbilled.amount_gst,
    vwitemsbilled.fk_lu_billing_type,
    vwitemsbilled.billing_type,
    vwitemsbilled.mbs_item,
    vwitemsbilled.user_item,
    vwitemsbilled.ama_item,
    vwitemsbilled.descriptor,
    vwitemsbilled.descriptor_brief,
    vwitemsbilled.gst_rate,
    vwitemsbilled.percentage_fee_rule,
    vwinvoices.fk_invoice,
    vwinvoices.notes,
    vwinvoices.fk_staff_invoicing,
    vwinvoices.fk_patient,
    vwinvoices.date_printed,
    vwinvoices.fk_staff_provided_service,
    vwinvoices.date_invoiced,
    vwinvoices.paid,
    vwinvoices.fk_payer_person,
    vwinvoices.fk_payer_branch,
    vwinvoices.account_to_name,
    vwinvoices.account_to_branch,
    vwinvoices.account_to_street,
    vwinvoices.account_to_town_postcode,
    vwinvoices.latex,
    vwinvoices.fk_branch,
    vwinvoices.visit_date,
    vwinvoices.fk_appointment,
    vwinvoices.appointment_time,
    vwinvoices.duration,
    vwinvoices.reference,
    vwinvoices.fk_lu_bulk_billing_type,
    vwinvoices.total_bill,
    vwinvoices.total_paid,
    vwinvoices.total_gst,
    vwinvoices.due,
    vwinvoices.staff_invoicing_wholename,
    vwinvoices.staff_provided_service_wholename,
    vwinvoices.staff_provided_service_provider_number,
    vwinvoices.australian_business_number,
    vwinvoices.patient_firstname,
    vwinvoices.patient_surname,
    vwinvoices.patient_title,
    vwinvoices.patient_fk_sex,
    vwinvoices.patient_sex,
    vwinvoices.patient_wholename,
    vwinvoices.fk_lu_centrelink_card_type,
    vwinvoices.fk_lu_default_billing_level,
    vwinvoices.branch,
    vwinvoices.result_code,
    vwinvoices.result_text,
    vwitemsbilled.reason_code,
    vwitemsbilled.comment AS item_comment,
    vwitemsbilled.service_id,
    vwinvoices.voucher_id,
    vwinvoices.fk_claim,
    vwinvoices.pms_claim_id,
    vwinvoices.error_level,
    vwinvoices.description,
    vwitemsbilled.error_level AS item_error_level,
    vwitemsbilled.description AS item_description,
    vwinvoices.claim_description,
    vwinvoices.claim_result_code,
    vwinvoices.claim_result_text,
    vwinvoices.online,
    vwitemsbilled.common_item,
    vwinvoices.claim_id,
    vwinvoices.claim_date,
    vwinvoices.bank_details_upload,
    vwinvoices.claimant_address_upload,
    vwitemsbilled.number_of_patients,
    vwitemsbilled.multiple_procedure,
    vwitemsbilled.aftercare,
    vwitemsbilled.duplicate,
    vwitemsbilled.separate_sites,
    vwitemsbilled.not_related,
    vwitemsbilled.procedure_duration,
    vwitemsbilled.field_quantity,
    vwinvoices.payee_provider_number
   FROM vwitemsbilled,
    vwinvoices
  WHERE (vwinvoices.fk_invoice = vwitemsbilled.fk_invoice);


ALTER TABLE billing.vwitemsandinvoices OWNER TO easygp;

--
-- Name: vwpaymentsreceived; Type: VIEW; Schema: billing; Owner: easygp
--

CREATE VIEW billing.vwpaymentsreceived AS
 SELECT payments_received.pk AS pk_view,
    payments_received.pk AS fk_payment_received,
    payments_received.date_paid,
    COALESCE(vworganisations.organisation, vwpersonsincludingpatients.wholename) AS account_to_name,
    (((lu_title.title || ' '::text) || (data_persons.firstname || ' '::text)) || (data_persons.surname || ' '::text)) AS patient_wholename,
    payments_received.fk_invoice,
    payments_received.referent,
    payments_received.amount,
    payments_received.fk_lu_payment_method,
    payments_received.fk_staff_receipted,
    lu_payment_method.method AS payment_method,
    invoices.fk_patient,
    invoices.fk_payer_person,
    invoices.fk_payer_branch,
    invoices.fk_staff_provided_service,
    invoices.fk_branch AS fk_clinic_branch,
    invoices.visit_date,
    invoices.latex,
    data_persons.firstname,
    data_persons.surname,
    lu_title.title
   FROM (((((((payments_received
     JOIN lu_payment_method ON ((payments_received.fk_lu_payment_method = lu_payment_method.pk)))
     JOIN invoices ON ((payments_received.fk_invoice = invoices.pk)))
     LEFT JOIN clerical.data_patients ON ((invoices.fk_patient = data_patients.pk)))
     LEFT JOIN contacts.data_persons ON ((data_patients.fk_person = data_persons.pk)))
     LEFT JOIN contacts.lu_title ON ((data_persons.fk_title = lu_title.pk)))
     LEFT JOIN contacts.vworganisations ON ((invoices.fk_payer_branch = vworganisations.fk_branch)))
     LEFT JOIN contacts.vwpersonsincludingpatients ON ((invoices.fk_payer_person = vwpersonsincludingpatients.fk_person)));


ALTER TABLE billing.vwpaymentsreceived OWNER TO easygp;

--
-- Name: pk; Type: DEFAULT; Schema: billing; Owner: easygp
--
-- 

--
-- Name: pk; Type: DEFAULT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY claims ALTER COLUMN pk SET DEFAULT nextval('claims_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY billing.fee_schedule ALTER COLUMN pk SET DEFAULT nextval('fee_schedule_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY billing.invoices ALTER COLUMN pk SET DEFAULT nextval('invoices_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY billing.items_billed ALTER COLUMN pk SET DEFAULT nextval('items_billed_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY billing.lu_billing_type ALTER COLUMN pk SET DEFAULT nextval('lu_billing_type_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY billing.lu_bulk_billing_type ALTER COLUMN pk SET DEFAULT nextval('lu_bulk_billing_type_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY billing.lu_default_billing_level ALTER COLUMN pk SET DEFAULT nextval('lu_default_billing_level_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY billing.lu_invoice_comments ALTER COLUMN pk SET DEFAULT nextval('lu_invoice_comments_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY billing.lu_payment_method ALTER COLUMN pk SET DEFAULT nextval('lu_payment_method_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY billing.lu_reasons_not_billed ALTER COLUMN pk SET DEFAULT nextval('lu_reasons_not_billed_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY billing.lu_reports ALTER COLUMN pk SET DEFAULT nextval('lu_reports_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY billing.payments_received ALTER COLUMN pk SET DEFAULT nextval('payments_received_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY billing.prices ALTER COLUMN pk SET DEFAULT nextval('prices_pk_seq'::regclass);


--
-- Name: bank_details_pkey; Type: CONSTRAINT; Schema: billing; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY billing.bank_details
    ADD CONSTRAINT bank_details_pkey PRIMARY KEY (pk);


--
-- Name: bulk_billing_claims_pkey; Type: CONSTRAINT; Schema: billing; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY billing.claims
    ADD CONSTRAINT bulk_billing_claims_pkey PRIMARY KEY (pk);


--
-- Name: codes_code_key; Type: CONSTRAINT; Schema: billing; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY billing.lu_codes
    ADD CONSTRAINT codes_code_key UNIQUE (code);


--
-- Name: fee_schedule_pkey; Type: CONSTRAINT; Schema: billing; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY billing.fee_schedule
    ADD CONSTRAINT fee_schedule_pkey PRIMARY KEY (pk);


--
-- Name: invoices_pkey; Type: CONSTRAINT; Schema: billing; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY billing.invoices
    ADD CONSTRAINT invoices_pkey PRIMARY KEY (pk);


--
-- Name: items_billed_pkey; Type: CONSTRAINT; Schema: billing; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY billing.items_billed
    ADD CONSTRAINT items_billed_pkey PRIMARY KEY (pk);


--
-- Name: lu_billing_type_pkey; Type: CONSTRAINT; Schema: billing; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY billing.lu_billing_type
    ADD CONSTRAINT lu_billing_type_pkey PRIMARY KEY (pk);


--
-- Name: lu_billing_type_type_key; Type: CONSTRAINT; Schema: billing; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY billing.lu_billing_type
    ADD CONSTRAINT lu_billing_type_type_key UNIQUE (type);


--
-- Name: lu_bulk_billing_type_pkey; Type: CONSTRAINT; Schema: billing; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY billing.lu_bulk_billing_type
    ADD CONSTRAINT lu_bulk_billing_type_pkey PRIMARY KEY (pk);


--
-- Name: lu_default_billing_level_pkey; Type: CONSTRAINT; Schema: billing; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY billing.lu_default_billing_level
    ADD CONSTRAINT lu_default_billing_level_pkey PRIMARY KEY (pk);


--
-- Name: lu_invoice_comments_pkey; Type: CONSTRAINT; Schema: billing; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY billing.lu_invoice_comments
    ADD CONSTRAINT lu_invoice_comments_pkey PRIMARY KEY (pk);


--
-- Name: lu_payment_method_pkey; Type: CONSTRAINT; Schema: billing; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY billing.lu_payment_method
    ADD CONSTRAINT lu_payment_method_pkey PRIMARY KEY (pk);


--
-- Name: lu_reasons_not_billed_pkey; Type: CONSTRAINT; Schema: billing; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY billing.lu_reasons_not_billed
    ADD CONSTRAINT lu_reasons_not_billed_pkey PRIMARY KEY (pk);


--
-- Name: lu_reports_pkey; Type: CONSTRAINT; Schema: billing; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY billing.lu_reports
    ADD CONSTRAINT lu_reports_pkey PRIMARY KEY (pk);


--
-- Name: payments_received_pkey; Type: CONSTRAINT; Schema: billing; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY billing.payments_received
    ADD CONSTRAINT payments_received_pkey PRIMARY KEY (pk);


--
-- Name: prices_pkey; Type: CONSTRAINT; Schema: billing; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY billing.prices
    ADD CONSTRAINT prices_pkey PRIMARY KEY (pk);


--
-- Name: schedule_ama_item_key; Type: CONSTRAINT; Schema: billing; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY billing.fee_schedule
    ADD CONSTRAINT schedule_ama_item_key UNIQUE (ama_item);


--
-- Name: update_invoice; Type: TRIGGER; Schema: billing; Owner: easygp
--

CREATE TRIGGER update_invoice BEFORE INSERT OR UPDATE ON billing.invoices FOR EACH ROW EXECUTE PROCEDURE billing.invoice_notify();


--
-- Name: update_invoice_bill_trig; Type: TRIGGER; Schema: billing; Owner: easygp
--

CREATE TRIGGER update_invoice_bill_trig AFTER INSERT OR DELETE OR UPDATE ON billing.items_billed FOR EACH ROW EXECUTE PROCEDURE billing.update_invoice_bill();


--
-- Name: update_invoice_payment_trig; Type: TRIGGER; Schema: billing; Owner: easygp
--

CREATE TRIGGER update_invoice_payment_trig AFTER INSERT OR DELETE OR UPDATE ON billing.payments_received FOR EACH ROW EXECUTE PROCEDURE billing.update_invoice_payment();


--
-- Name: bank_details_fk_invoice_fkey; Type: FK CONSTRAINT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY billing.bank_details
    ADD CONSTRAINT bank_details_fk_invoice_fkey FOREIGN KEY (fk_invoice) REFERENCES invoices(pk);


--
-- Name: bulk_billing_claims_fk_branch_fkey; Type: FK CONSTRAINT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY claims
    ADD CONSTRAINT bulk_billing_claims_fk_branch_fkey FOREIGN KEY (fk_branch) REFERENCES contacts.data_branches(pk);


--
-- Name: invoices_fk_appointment_fkey; Type: FK CONSTRAINT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY invoices
    ADD CONSTRAINT invoices_fk_appointment_fkey FOREIGN KEY (fk_appointment) REFERENCES clerical.bookings(pk);


--
-- Name: invoices_fk_branch_fkey; Type: FK CONSTRAINT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY invoices
    ADD CONSTRAINT invoices_fk_branch_fkey FOREIGN KEY (fk_branch) REFERENCES contacts.data_branches(pk);


--
-- Name: invoices_fk_claim_fkey; Type: FK CONSTRAINT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY invoices
    ADD CONSTRAINT invoices_fk_claim_fkey FOREIGN KEY (fk_claim) REFERENCES claims(pk);


--
-- Name: invoices_fk_doctor_raising_fkey; Type: FK CONSTRAINT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY invoices
    ADD CONSTRAINT invoices_fk_doctor_raising_fkey FOREIGN KEY (fk_staff_provided_service) REFERENCES admin.staff(pk);


--
-- Name: invoices_fk_lu_bulk_billing_type_fkey; Type: FK CONSTRAINT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY invoices
    ADD CONSTRAINT invoices_fk_lu_bulk_billing_type_fkey FOREIGN KEY (fk_lu_bulk_billing_type) REFERENCES lu_bulk_billing_type(pk);


--
-- Name: invoices_fk_patient_fkey; Type: FK CONSTRAINT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY invoices
    ADD CONSTRAINT invoices_fk_patient_fkey FOREIGN KEY (fk_patient) REFERENCES clerical.data_patients(pk);


--
-- Name: invoices_fk_payer_branch_fkey; Type: FK CONSTRAINT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY invoices
    ADD CONSTRAINT invoices_fk_payer_branch_fkey FOREIGN KEY (fk_payer_branch) REFERENCES contacts.data_branches(pk);


--
-- Name: invoices_fk_payer_person_fkey; Type: FK CONSTRAINT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY invoices
    ADD CONSTRAINT invoices_fk_payer_person_fkey FOREIGN KEY (fk_payer_person) REFERENCES contacts.data_persons(pk);


--
-- Name: invoices_fk_staff_invoicing_fkey; Type: FK CONSTRAINT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY invoices
    ADD CONSTRAINT invoices_fk_staff_invoicing_fkey FOREIGN KEY (fk_staff_invoicing) REFERENCES admin.staff(pk);


--
-- Name: items_billed_fk_fee_schedule_fkey; Type: FK CONSTRAINT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY items_billed
    ADD CONSTRAINT items_billed_fk_fee_schedule_fkey FOREIGN KEY (fk_fee_schedule) REFERENCES fee_schedule(pk);


--
-- Name: items_billed_fk_invoice_fkey; Type: FK CONSTRAINT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY items_billed
    ADD CONSTRAINT items_billed_fk_invoice_fkey FOREIGN KEY (fk_invoice) REFERENCES invoices(pk);


--
-- Name: lu_reports_fk_subreport_fkey; Type: FK CONSTRAINT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY lu_reports
    ADD CONSTRAINT lu_reports_fk_subreport_fkey FOREIGN KEY (fk_subreport) REFERENCES lu_reports(pk);


--
-- Name: payments_received_fk_invoice_fkey; Type: FK CONSTRAINT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY payments_received
    ADD CONSTRAINT payments_received_fk_invoice_fkey FOREIGN KEY (fk_invoice) REFERENCES invoices(pk);


--
-- Name: payments_received_fk_lu_payment_method_fkey; Type: FK CONSTRAINT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY payments_received
    ADD CONSTRAINT payments_received_fk_lu_payment_method_fkey FOREIGN KEY (fk_lu_payment_method) REFERENCES lu_payment_method(pk);


--
-- Name: payments_received_fk_staff_receipted_fkey; Type: FK CONSTRAINT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY payments_received
    ADD CONSTRAINT payments_received_fk_staff_receipted_fkey FOREIGN KEY (fk_staff_receipted) REFERENCES admin.staff(pk);


--
-- Name: prices_fk_fee_schedule_fkey; Type: FK CONSTRAINT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY prices
    ADD CONSTRAINT prices_fk_fee_schedule_fkey FOREIGN KEY (fk_fee_schedule) REFERENCES fee_schedule(pk);


--
-- Name: prices_fk_lu_billing_type_fkey; Type: FK CONSTRAINT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY items_billed
    ADD CONSTRAINT prices_fk_lu_billing_type_fkey FOREIGN KEY (fk_lu_billing_type) REFERENCES lu_billing_type(pk);


--
-- Name: prices_fk_lu_billing_type_fkey; Type: FK CONSTRAINT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY prices
    ADD CONSTRAINT prices_fk_lu_billing_type_fkey FOREIGN KEY (fk_lu_billing_type) REFERENCES lu_billing_type(pk);


--
-- Name: billing; Type: ACL; Schema: -; Owner: easygp
--

REVOKE ALL ON SCHEMA billing FROM PUBLIC;
REVOKE ALL ON SCHEMA billing FROM easygp;
GRANT ALL ON SCHEMA billing TO easygp;
GRANT USAGE ON SCHEMA billing TO staff;


--
-- Name: bank_details; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE bank_details FROM PUBLIC;
REVOKE ALL ON TABLE bank_details FROM easygp;
GRANT ALL ON TABLE bank_details TO easygp;
GRANT ALL ON TABLE bank_details TO staff;


--
-- Name: bank_details_pk_seq; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON SEQUENCE bank_details_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE bank_details_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE bank_details_pk_seq TO easygp;
GRANT ALL ON SEQUENCE bank_details_pk_seq TO staff;


--
-- Name: claims; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE claims FROM PUBLIC;
REVOKE ALL ON TABLE claims FROM easygp;
GRANT ALL ON TABLE claims TO easygp;
GRANT ALL ON TABLE claims TO staff;


--
-- Name: claims_pk_seq; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON SEQUENCE claims_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE claims_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE claims_pk_seq TO easygp;
GRANT ALL ON SEQUENCE claims_pk_seq TO staff;


--
-- Name: fee_schedule; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE fee_schedule FROM PUBLIC;
REVOKE ALL ON TABLE fee_schedule FROM easygp;
GRANT ALL ON TABLE fee_schedule TO easygp;
GRANT ALL ON TABLE fee_schedule TO staff;


--
-- Name: fee_schedule_pk_seq; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON SEQUENCE fee_schedule_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE fee_schedule_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE fee_schedule_pk_seq TO easygp;
GRANT ALL ON SEQUENCE fee_schedule_pk_seq TO staff;


--
-- Name: invoices; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE invoices FROM PUBLIC;
REVOKE ALL ON TABLE invoices FROM easygp;
GRANT ALL ON TABLE invoices TO easygp;
GRANT ALL ON TABLE invoices TO staff;


--
-- Name: invoices_pk_seq; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON SEQUENCE invoices_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE invoices_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE invoices_pk_seq TO easygp;
GRANT ALL ON SEQUENCE invoices_pk_seq TO staff;


--
-- Name: items_billed; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE items_billed FROM PUBLIC;
REVOKE ALL ON TABLE items_billed FROM easygp;
GRANT ALL ON TABLE items_billed TO easygp;
GRANT ALL ON TABLE items_billed TO staff;


--
-- Name: items_billed_pk_seq; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON SEQUENCE items_billed_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE items_billed_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE items_billed_pk_seq TO easygp;
GRANT ALL ON SEQUENCE items_billed_pk_seq TO staff;


--
-- Name: lu_billing_type; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE lu_billing_type FROM PUBLIC;
REVOKE ALL ON TABLE lu_billing_type FROM easygp;
GRANT ALL ON TABLE lu_billing_type TO easygp;
GRANT ALL ON TABLE lu_billing_type TO staff;


--
-- Name: lu_bulk_billing_type; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE lu_bulk_billing_type FROM PUBLIC;
REVOKE ALL ON TABLE lu_bulk_billing_type FROM easygp;
GRANT ALL ON TABLE lu_bulk_billing_type TO easygp;
GRANT ALL ON TABLE lu_bulk_billing_type TO staff;


--
-- Name: lu_codes; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE lu_codes FROM PUBLIC;
REVOKE ALL ON TABLE lu_codes FROM easygp;
GRANT ALL ON TABLE lu_codes TO easygp;
GRANT SELECT ON TABLE lu_codes TO staff;


--
-- Name: lu_default_billing_level; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE lu_default_billing_level FROM PUBLIC;
REVOKE ALL ON TABLE lu_default_billing_level FROM easygp;
GRANT ALL ON TABLE lu_default_billing_level TO easygp;
GRANT ALL ON TABLE lu_default_billing_level TO staff;


--
-- Name: lu_invoice_comments; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE lu_invoice_comments FROM PUBLIC;
REVOKE ALL ON TABLE lu_invoice_comments FROM easygp;
GRANT ALL ON TABLE lu_invoice_comments TO easygp;
GRANT ALL ON TABLE lu_invoice_comments TO staff;


--
-- Name: lu_payment_method; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE lu_payment_method FROM PUBLIC;
REVOKE ALL ON TABLE lu_payment_method FROM easygp;
GRANT ALL ON TABLE lu_payment_method TO easygp;
GRANT ALL ON TABLE lu_payment_method TO staff;


--
-- Name: lu_reasons_not_billed; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE lu_reasons_not_billed FROM PUBLIC;
REVOKE ALL ON TABLE lu_reasons_not_billed FROM easygp;
GRANT ALL ON TABLE lu_reasons_not_billed TO easygp;
GRANT ALL ON TABLE lu_reasons_not_billed TO staff;


--
-- Name: lu_reports; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE lu_reports FROM PUBLIC;
REVOKE ALL ON TABLE lu_reports FROM easygp;
GRANT ALL ON TABLE lu_reports TO easygp;
GRANT ALL ON TABLE lu_reports TO staff;


--
-- Name: payments_received; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE payments_received FROM PUBLIC;
REVOKE ALL ON TABLE payments_received FROM easygp;
GRANT ALL ON TABLE payments_received TO easygp;
GRANT ALL ON TABLE payments_received TO staff;


--
-- Name: payments_received_pk_seq; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON SEQUENCE payments_received_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE payments_received_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE payments_received_pk_seq TO easygp;
GRANT ALL ON SEQUENCE payments_received_pk_seq TO staff;


--
-- Name: prices; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE prices FROM PUBLIC;
REVOKE ALL ON TABLE prices FROM easygp;
GRANT ALL ON TABLE prices TO easygp;
GRANT ALL ON TABLE prices TO staff;


--
-- Name: prices_pk_seq; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON SEQUENCE prices_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE prices_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE prices_pk_seq TO easygp;
GRANT ALL ON SEQUENCE prices_pk_seq TO staff;


--
-- Name: reports; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE reports FROM PUBLIC;
REVOKE ALL ON TABLE reports FROM easygp;
GRANT ALL ON TABLE reports TO easygp;
GRANT ALL ON TABLE reports TO staff;


--
-- Name: vwclaims; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE vwclaims FROM PUBLIC;
REVOKE ALL ON TABLE vwclaims FROM easygp;
GRANT ALL ON TABLE vwclaims TO easygp;
GRANT SELECT ON TABLE vwclaims TO staff;


--
-- Name: vwdaylist; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE vwdaylist FROM PUBLIC;
REVOKE ALL ON TABLE vwdaylist FROM easygp;
GRANT ALL ON TABLE vwdaylist TO easygp;
GRANT ALL ON TABLE vwdaylist TO staff;


--
-- Name: vwfees; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE vwfees FROM PUBLIC;
REVOKE ALL ON TABLE vwfees FROM easygp;
GRANT ALL ON TABLE vwfees TO easygp;
GRANT SELECT ON TABLE vwfees TO staff;


--
-- Name: vwinvoices; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE vwinvoices FROM PUBLIC;
REVOKE ALL ON TABLE vwinvoices FROM easygp;
GRANT ALL ON TABLE vwinvoices TO easygp;
GRANT SELECT ON TABLE vwinvoices TO staff;


--
-- Name: vwitemsbilled; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE vwitemsbilled FROM PUBLIC;
REVOKE ALL ON TABLE vwitemsbilled FROM easygp;
GRANT ALL ON TABLE vwitemsbilled TO easygp;
GRANT SELECT ON TABLE vwitemsbilled TO staff;


--
-- Name: vwitemsandinvoices; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE vwitemsandinvoices FROM PUBLIC;
REVOKE ALL ON TABLE vwitemsandinvoices FROM easygp;
GRANT ALL ON TABLE vwitemsandinvoices TO easygp;
GRANT SELECT ON TABLE vwitemsandinvoices TO staff;


--
-- Name: vwpaymentsreceived; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE vwpaymentsreceived FROM PUBLIC;
REVOKE ALL ON TABLE vwpaymentsreceived FROM easygp;
GRANT ALL ON TABLE vwpaymentsreceived TO easygp;
GRANT ALL ON TABLE vwpaymentsreceived TO staff;


--
-- PostgreSQL database dump complete
--

