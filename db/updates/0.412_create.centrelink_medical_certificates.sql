-- some tables to describe Centrelink Australia Medical Certificates based on from SU415.1312 latest as of Oct 2015
--DROP TABLE clin_certificates.lu_centrelink_condition_temporality cascade;
--DROP TABLE clin_certificates.lu_centrelink_condition_prognosis cascade;
--DROP TABLE clin_certificates.centrelink_diagnoses cascade;
--DROP TABLE clin_certificates.centrelink_medical_certificates cascade;
--DROP FUNCTION clin_certificates.check_cert_diagnosis();
--DROP TABLE clin_certificates.lu_centrelink_diagnosis_type;


ALTER TABLE clerical.data_patients add column patient_at_practice_since text default null;
COMMENT ON COLUMN clerical.data_patients.patient_at_practice_since IS
'the number of years this patient has been attending this practice 
 note for new practices this will default to date of first constultation 
 but for others like myself I''ve been in practice 35 years and using easyGP only since 2011';

Create table clin_certificates.lu_centrelink_condition_temporality 
(pk serial primary key,
 temporality text not null);

ALTER TABLE clin_certificates.lu_centrelink_condition_temporality OWNER to EasyGP;
GRANT SELECT ON clin_certificates.lu_centrelink_condition_temporality TO STAFF;
COMMENT ON TABLE clin_certificates.lu_centrelink_condition_temporality IS
'whether the GP thinks the condition is temporary, permanent or an exacerbation';

INSERT INTO clin_certificates.lu_centrelink_condition_temporality (temporality) values ('temporary');
INSERT INTO clin_certificates.lu_centrelink_condition_temporality (temporality) values ('permanent');
INSERT INTO clin_certificates.lu_centrelink_condition_temporality (temporality) values ('exacerbation');

CREATE TABLE clin_certificates.lu_centrelink_condition_prognosis 
(pk serial primary key,
 expected_duration text not null);

CREATE TABLE clin_certificates.lu_centrelink_diagnosis_type
(pk serial primary key,
type text null
);

INSERT INTO	clin_certificates.lu_centrelink_diagnosis_type (type) values ('primary');
INSERT INTO	clin_certificates.lu_centrelink_diagnosis_type (type) values ('secondary');

ALTER TABLE clin_certificates.lu_centrelink_diagnosis_type OWNER to EasyGP;
GRANT SELECT ON clin_certificates.lu_centrelink_diagnosis_type TO STAFF;
COMMENT ON TABLE clin_certificates.lu_centrelink_diagnosis_type IS
'whether this is a primary (single) or secondary diagnosis (one or more)';

ALTER TABLE clin_certificates.lu_centrelink_condition_prognosis OWNER TO EasyGP;
GRANT SELECT ON clin_certificates.lu_centrelink_condition_prognosis to Staff;
COMMENT ON TABLE clin_certificates.lu_centrelink_condition_prognosis IS 
'how long the doctor thinks the patients inability to work will  last';

INSERT INTO clin_certificates.lu_centrelink_condition_prognosis  (expected_duration) values ('< 3 months');
INSERT INTO clin_certificates.lu_centrelink_condition_prognosis  (expected_duration) values ('3-12 months');
INSERT INTO clin_certificates.lu_centrelink_condition_prognosis  (expected_duration) values ('13-24 months');
INSERT INTO clin_certificates.lu_centrelink_condition_prognosis  (expected_duration) values ('> 24 months');
INSERT INTO clin_certificates.lu_centrelink_condition_prognosis  (expected_duration) values ('uncertain');

Create table clin_certificates.centrelink_medical_certificates
(
pk serial primary key,
fk_consult integer not null,
fk_progressnote integer not null,
primary_diagnosis_fk_lu_condition_temporality integer not null,
primary_diagnosis_fk_lu_condition_prognosis integer not null,
primary_diagnosis_symptoms text not null,
primary_diagnosis_treatment_past text default null,
primary_diagnosis_treatment_current text not null,
primary_diagnosis_treatment_planned text default null,
secondary_diagnoses_fk_lu_condition_temporality integer default null,
secondary_diagnoses_fk_lu_condition_prognosis integer default null,
secondary_diagnoses_symptoms text default null,
secondary_diagnoses_treatment_past text default null,
secondary_diagnoses_treatment_current text default null,
secondary_diagnoses_treatment_planned text default null,
other_impacting_conditions text default null,
unfit_from date not null,
unfit_to date not null,
can_do_usual_work boolean default false,
can_do_other_work boolean default false,
impacting_factors text default null,
print_on_centrelink_form boolean default false,
my_patient_since text not null,
latex text not null,
fk_document integer not null references documents.documents (pk),
deleted boolean default false,
CONSTRAINT clin_certificates_clc_fk_consult_fkey FOREIGN KEY (fk_consult)
      REFERENCES clin_consult.consult (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
CONSTRAINT clin_certificates_fk_progressnote_fkey FOREIGN KEY (fk_progressnote)
      REFERENCES clin_consult.progressnotes (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
 
 );
 
 ALTER TABLE clin_certificates.centrelink_medical_certificates OWNER TO easygp;
 GRANT ALL ON TABLE clin_certificates.centrelink_medical_certificates to staff;

 COMMENT ON TABLE clin_certificates.centrelink_medical_certificates IS  
  'contains information to generate a centrelink medical certificate
  as we usually don''t put in secondary conditions defaults for these fields are null
  based on form SU415.1312 latest as of Oct 2015';
  
COMMENT ON COLUMN clin_certificates.centrelink_medical_certificates.print_on_centrelink_form IS 
'If true then then form is printed on the sheets provided by centrelink, otherwise an existing pdf in templates/ will be used to print LaTex on';
COMMENT ON COLUMN clin_certificates.centrelink_medical_certificates.fk_document is 
 'key to document.documents which will contain the LaTex of the form';
COMMENT ON COLUMN clin_certificates.centrelink_medical_certificates.primary_diagnosis_fk_lu_condition_temporality  is'key to centrelink_lu_condition_temporality table ie whether the GP thinks the condition is temporary, permanent or an exacerbation';

COMMENT ON COLUMN clin_certificates.centrelink_medical_certificates.primary_diagnosis_fk_lu_condition_prognosis is
'key to centrelink_lu_condition_prognosis table ie the duration of time the condition is expected to persist';

create table clin_certificates.centrelink_diagnoses (
	pk serial primary key,
	fk_centrelink_certificate integer  not null references clin_certificates.centrelink_medical_certificates (pk),
	fk_lu_centrelink_diagnosis_type integer not null references clin_certificates.lu_centrelink_diagnosis_type (pk),
	description text not null,
	year_onset text not null,
	fk_pasthistory integer not null  references clin_history.past_history (pk),
	fk_code text not null, -- references coding.generic_terms (code),
	fk_coding_system integer not null references coding.lu_systems (pk),
        deleted boolean default false
);

ALTER TABLE clin_certificates.centrelink_diagnoses owner to easygp;
GRANT ALL ON TABLE clin_certificates.centrelink_diagnoses to staff;

COMMENT ON TABLE clin_certificates.centrelink_diagnoses IS
'contains all the diagnoses on the centrelink form differentiated by primary or secondary';

COMMENT ON COLUMN clin_certificates.centrelink_diagnoses.fk_lu_centrelink_diagnosis_type is
'key to clin_certificates.fk_lu_diagnosis type being either primary (main) or secondary (one or more)';

COMMENT ON COLUMN clin_certificates.centrelink_diagnoses.fk_centrelink_certificate is
'key to the main clin_certificates.centrelink_medical_certificates table which contains
 the unique fields the form';
 
COMMENT ON COLUMN clin_certificates.centrelink_diagnoses.description  is
'text of the primary diagnosis. Though initially obtatined from past_history!description field that field is
only a snapshot in time. We need to keep what was put on the certificate permanantly
I''ve kept the name description to match the fields in past history also it is often a 
description of a codable diagnosis';


COMMENT ON COLUMN clin_certificates.centrelink_diagnoses.year_onset is 
'the mm/yyyy or yyyy the approximate date of onset initially pulled from clin_history.past_history table';


COMMENT ON COLUMN clin_certificates.centrelink_diagnoses.fk_pasthistory is
'key to clin_history.past_history table. used in editing the certificate on the day of creation only
 as user could down the track change any details of this or even delete the record';
 
COMMENT ON COLUMN clin_certificates.centrelink_diagnoses.fk_code is 
' key to coding.lu_systems. However this is obtained intially from the past_history table. AS the entry in that table
   can change at any time, we keep the ''snapshot'' of what this code was to reflect what was truly put on the certificate';

COMMENT ON COLUMN clin_certificates.centrelink_diagnoses.fk_coding_system is 
'the coding system being used for the code. Again this ia a ''snapshot'' in time see the above comment';


 

CREATE FUNCTION clin_certificates.check_cert_diagnosis() RETURNS trigger AS $c$
    BEGIN
        perform 1 from coding.generic_terms where code = NEW.fk_code AND fk_coding_system = NEW.fk_coding_system;
	IF NOT FOUND THEN
            RAISE EXCEPTION '% not a valid diagnostic code', NEW.fk_code;
        END IF;
        RETURN NEW;
    END;
$c$ LANGUAGE plpgsql;

grant execute on function clin_certificates.check_cert_diagnosis() to staff;

CREATE TRIGGER check_cert_diagnosis BEFORE INSERT OR UPDATE ON clin_certificates.centrelink_diagnoses
    FOR EACH ROW EXECUTE PROCEDURE clin_certificates.check_cert_diagnosis();


-- View: clin_certificates.vwcentrelinkcertificates
-- DROP VIEW clin_certificates.vwcentrelinkcertificates;

CREATE OR REPLACE VIEW clin_certificates.vwcentrelinkcertificates AS 
 SELECT centrelink_medical_certificates.pk AS pk_certificate,
    consult.consult_date,
    consult.fk_patient,
    data_patients.patient_at_practice_since,
    consult.fk_staff,
    centrelink_medical_certificates.fk_consult,
    centrelink_medical_certificates.fk_progressnote,
    centrelink_medical_certificates.primary_diagnosis_fk_lu_condition_temporality,
    centrelink_medical_certificates.primary_diagnosis_fk_lu_condition_prognosis,
    centrelink_medical_certificates.primary_diagnosis_symptoms,
    centrelink_medical_certificates.primary_diagnosis_treatment_past,
    centrelink_medical_certificates.primary_diagnosis_treatment_current,
    centrelink_medical_certificates.primary_diagnosis_treatment_planned,
    centrelink_medical_certificates.secondary_diagnoses_fk_lu_condition_temporality,
    centrelink_medical_certificates.secondary_diagnoses_fk_lu_condition_prognosis,
    centrelink_medical_certificates.secondary_diagnoses_symptoms,
    centrelink_medical_certificates.secondary_diagnoses_treatment_past,
    centrelink_medical_certificates.secondary_diagnoses_treatment_current,
    centrelink_medical_certificates.secondary_diagnoses_treatment_planned,
    centrelink_medical_certificates.other_impacting_conditions,
    centrelink_medical_certificates.unfit_from,
    centrelink_medical_certificates.unfit_to,
    centrelink_medical_certificates.can_do_usual_work,
    centrelink_medical_certificates.can_do_other_work,
    centrelink_medical_certificates.impacting_factors,
    centrelink_medical_certificates.print_on_centrelink_form,
    centrelink_medical_certificates.my_patient_since,
    centrelink_medical_certificates.latex,
    centrelink_medical_certificates.deleted,
    centrelink_medical_certificates.fk_document,
    vwstaffinclinics.wholename AS staff_wholename,
    vwstaffinclinics.title AS staff_title,
    vwstaffinclinics.branch AS staff_branch,
    vwstaffinclinics.organisation AS staff_organisation,
    vwstaffinclinics.street1 AS staff_street1,
    vwstaffinclinics.street2 AS staff_street2,
    vwstaffinclinics.town AS staff_town,
    vwstaffinclinics.postcode AS staff_postcode,
    vwstaffinclinics.provider_number AS staff_provider_number,
    progressnotes.notes AS progress_notes
   FROM clin_certificates.centrelink_medical_certificates
     JOIN clin_consult.consult ON centrelink_medical_certificates.fk_consult = consult.pk
     JOIN clerical.data_patients ON consult.fk_patient = data_patients.pk
     JOIN admin.vwstaffinclinics ON consult.fk_staff = vwstaffinclinics.fk_staff
     JOIN clin_consult.progressnotes ON progressnotes.pk = centrelink_medical_certificates.fk_progressnote;
 
  
 COMMENT ON VIEW clin_certificates.VwCentreLinkCertificates is 
 'A view of certificate data. 
  * Note the link to the  staff details are needed for the audit trail  See modCertificateDBI.Centrelink_Certificates_Delete(..)
  * The progress notes are included in the view to allow strike-through when deleting in consult not today() as part of the audit trail';
 
 ALTER TABLE clin_certificates.VwCentreLinkCertificates OWNER TO easygp;
 GRANT SELECT ON clin_certificates.VwCentreLinkCertificates TO staff;

CREATE OR REPLACE VIEW clin_certificates.vwCentrelinkDiagnoses as
SELECT	
        centrelink_diagnoses.pk as pk_centrelink_diagnoses,
	fk_centrelink_certificate,
	fk_lu_centrelink_diagnosis_type,
	description,
	year_onset,
	fk_pasthistory,
	centrelink_diagnoses.fk_code,
	centrelink_diagnoses.fk_coding_system, 
	centrelink_diagnoses.deleted as diagnosis_deleted,
        generic_terms.term,
	((generic_terms.term || ' ('::text) || generic_terms.code) || ')'::text AS combined_term_code
	
FROM clin_certificates.centrelink_diagnoses
	
	JOIN clin_certificates.lu_centrelink_diagnosis_type ON centrelink_diagnoses.fk_lu_centrelink_diagnosis_type = lu_centrelink_diagnosis_type.pk
	JOIN clin_certificates.centrelink_medical_certificates ON centrelink_medical_certificates.pk= centrelink_diagnoses.fk_centrelink_certificate
	JOIN coding.generic_terms ON centrelink_diagnoses.fk_code = generic_terms.code ;

ALTER TABLE clin_certificates.vwCentrelinkDiagnoses OWNER TO easygp;
GRANT SELECT ON clin_certificates.vwCentrelinkDiagnoses TO staff;

update db.lu_version set lu_minor=412;
