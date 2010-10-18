drop schema audit;
CREATE SCHEMA audit;

SET search_path = audit, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: audit; Type: TABLE; Schema: audit; Owner: -; Tablespace: 
--

CREATE TABLE audit (
    pk serial primary key,
    fk_table regclass,
    fk_row integer,
    fk_consult integer,
    fk_lu_reason integer,
    fk_action integer,
    data_summary text
);

CREATE TABLE lu_actions (
    pk serial primary key,
    "action" text NOT NULL,
    insist_reason boolean default 'f' not null
);


COMMENT ON TABLE lu_actions IS 'the action undertaken by the audit eg insert, update, delete, complete etc';
comment on column lu_actions.insist_reason is 
'true if the client should insist the user enter a reason for this action';

--
-- Name: lu_reasons; Type: TABLE; Schema: audit; Owner: -; Tablespace: 
--

CREATE TABLE lu_reasons (
    pk serial primary key,
    fk_staff integer,
    reason text
);


--
-- Name: TABLE lu_reasons; Type: COMMENT; Schema: audit; Owner: -
--

COMMENT ON TABLE lu_reasons IS 'keeps reasons for the audit action on per-user basis';


--
-- Name: vwaudit; Type: VIEW; Schema: audit; Owner: -
--

CREATE VIEW vwaudit AS
    SELECT audit.pk AS pk_view, 
          consult.fk_patient, 
          consult.consult_date AS date_audit, 
          audit.data_summary, 
          lu_reasons.reason AS audit_trail_reason, 
          vwstaff.title AS altered_by_title, 
          vwstaff.wholename AS altered_by_name,  
          audit.fk_consult, 
          audit.fk_lu_reason, 
          lu_actions.action, 
          audit.fk_action FROM
      audit,lu_actions,admin.vwstaff,clin_consult.consult,lu_reasons
where  
audit.fk_lu_reason = lu_reasons.pk and 
audit.fk_consult = consult.pk and 
consult.fk_staff = vwstaff.fk_staff and 
audit.fk_action = lu_actions.pk;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 31);


