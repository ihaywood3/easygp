-- probably an easier way to do this however:
-- bug in FMedicalCertificates has led to saving duplicate reasons for certificate
-- this saves the unique reasons (we don't use the keys in clin_certificates.medical_certificates, only used for display

Create table clin_certificates.temp
(pk serial primary key,
reason text not null,
fk_staff integer not null);

insert into clin_certificates.temp(reason, fk_staff) 
(select distinct reason, fk_staff from clin_certificates.certificate_reasons);

delete from clin_certificates.certificate_reasons;
ALTER SEQUENCE "clin_certificates"."certificate_reasons_pk_seq"
    INCREMENT 1  MINVALUE 1
    MAXVALUE 9223372036854775807  RESTART 1
    CACHE 1  NO CYCLE;
    
insert into clin_certificates.certificate_reasons(reason, fk_staff) 
( select reason,fk_staff from clin_certificates.temp);

-- add boolean column to allow qualifying notes to be printed on the medical certificate

alter table clin_certificates.medical_certificates add column print_notes boolean default false;
comment on column  clin_certificates.medical_certificates.print_notes is
'if true then the notes will be printed on the medical certificate';

DROP VIEW clin_certificates.vwmedicalcertificates;

CREATE OR REPLACE VIEW clin_certificates.vwmedicalcertificates AS 
 SELECT medical_certificates.pk AS pk_medicalcertificate, consult.fk_patient, consult.consult_date, 
 medical_certificates.fk_consult, medical_certificates.certificate_date, medical_certificates.reason, 
 medical_certificates.fk_coding_system, medical_certificates.fk_code, medical_certificates.fk_lu_illness_temporality, 
 medical_certificates.fk_lu_fitness, lu_fitness.fitness, medical_certificates.from_date, medical_certificates.deleted, 
 medical_certificates.to_date, medical_certificates.notes, medical_certificates.print_notes, medical_certificates.fk_progressnote, 
 medical_certificates.latex, consult.fk_staff, vwstaffinclinics.wholename AS staff_wholename, vwstaffinclinics.title AS staff_title, 
 vwstaffinclinics.branch AS staff_branch, vwstaffinclinics.organisation AS staff_organisation, vwstaffinclinics.street1 AS staff_street1, 
 vwstaffinclinics.street2 AS staff_street2, vwstaffinclinics.town AS staff_town, vwstaffinclinics.postcode AS staff_postcode, 
 vwstaffinclinics.provider_number AS staff_provider_number, lu_illness_temporality.temporality, lu_systems.system, generic_terms.term, generic_terms.code
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
insert into db.lu_version (lu_major,lu_minor) values (0, 141);

