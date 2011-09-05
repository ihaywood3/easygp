-- Database changes to reflect medical certificates now behaving like all other sections
-- progress note for each certificate linked now to clin_consult.progressnotes
-- minor name change to medical_certificates.date > becomes certificate_date to allow the latex template to generate from either the table or the view
-- fk_progress note set to 0 to allow view to still work, all certificates prior to this time have no editable progress notes entry however.

ALTER TABLE clin_certificates.medical_certificates rename COLUMN date to certificate_date;

Alter table clin_certificates.medical_certificates add column fk_progressnote integer;
Update clin_certificates.medical_certificates set fk_progressnote=0;
Alter table clin_certificates.medical_certificates alter column fk_progressnote set default null;
comment on column clin_certificates.medical_certificates.fk_progressnote is 'references clin_consult.progressnotes primary key';

DROP VIEW clin_certificates.vwmedicalcertificates;

CREATE OR REPLACE VIEW clin_certificates.vwmedicalcertificates AS 
 SELECT medical_certificates.pk AS pk_medicalcertificate, consult.fk_patient, consult.consult_date, medical_certificates.fk_consult,
  medical_certificates.certificate_date , medical_certificates.reason, 
  medical_certificates.fk_coding_system, medical_certificates.fk_code, medical_certificates.fk_lu_illness_temporality, 
  medical_certificates.fk_lu_fitness, lu_fitness.fitness, medical_certificates.from_date,
   medical_certificates.deleted, medical_certificates.to_date, medical_certificates.notes, medical_certificates.fk_progressnote,
   consult.fk_staff, 
   vwstaffinclinics.wholename AS staff_wholename, vwstaffinclinics.title AS staff_title,
    vwstaffinclinics.branch AS staff_branch, vwstaffinclinics.organisation AS staff_organisation, 
    vwstaffinclinics.street1 AS staff_street1, vwstaffinclinics.street2 AS staff_street2, 
    vwstaffinclinics.town AS staff_town, vwstaffinclinics.postcode AS staff_postcode, 
    vwstaffinclinics.provider_number AS staff_provider_number, lu_illness_temporality.temporality, 
    lu_systems.system, generic_terms.term, generic_terms.code
   FROM clin_certificates.medical_certificates medical_certificates
   JOIN clin_consult.consult ON medical_certificates.fk_consult = consult.pk
   JOIN admin.vwstaffinclinics ON consult.fk_staff = vwstaffinclinics.fk_staff
   JOIN clin_certificates.lu_illness_temporality ON medical_certificates.fk_lu_illness_temporality = lu_illness_temporality.pk
   JOIN clin_certificates.lu_fitness ON medical_certificates.fk_lu_fitness = lu_fitness.pk
   LEFT JOIN coding.lu_systems ON medical_certificates.fk_coding_system = lu_systems.pk
   LEFT JOIN coding.generic_terms ON medical_certificates.fk_code = generic_terms.code
  WHERE medical_certificates.deleted = false
  ORDER BY consult.fk_patient, consult.consult_date;

ALTER TABLE clin_certificates.vwmedicalcertificates OWNER TO easygp;
GRANT ALL ON TABLE clin_certificates.vwmedicalcertificates TO easygp;
GRANT ALL ON TABLE clin_certificates.vwmedicalcertificates TO staff;
COMMENT ON VIEW clin_certificates.vwmedicalcertificates IS 'A view of patients medical certificate history, includes written by which staff member and where';

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 120);

