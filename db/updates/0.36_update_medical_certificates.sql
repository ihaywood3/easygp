-- modifications to clin_certificates schema, tables and view

create table clin_certificates.lu_fitness

(pk serial primary key,
 fitness text not null);

GRANT ALL ON TABLE clin_certificates.lu_fitness TO staff;

Insert into clin_certificates.lu_fitness(fitness) values ('fit');
Insert into clin_certificates.lu_fitness(fitness) values ('unfit');
 
-- Alter table structure of medical_certficate this cascades to vwMedicalCertificates

ALTER TABLE clin_certificates.medical_certificate DROP COLUMN fk_patient cascade;
ALTER TABLE clin_certificates.medical_certificate add column fk_lu_fitness integer;
ALTER TABLE clin_certificates.medical_certificate alter COLUMN fk_coding_system set default null;
ALTER TABLE clin_certificates.medical_certificate alter COLUMN fk_code set default null;
ALTER TABLE clin_certificates.medical_certificate add column notes text default null;
Alter TABLE clin_certificates.medical_certificate add column "date" date not null;

comment on column clin_certificates.medical_certificate.date is '
The date which appears on top of the certificate
this may not be the date on which it was written, e.g sometimes have to
back-date a certificate';

ALTER TABLE clin_certificates.medical_certificate rename to "medical_certificates";
 
Create table clin_certificates.certificate_reasons
(pk serial primary key,
 fk_staff integer not null,
 reason text not null);
 
 comment on table clin_certificates.certificate_reasons is
 'A table to keep reasons a particular doctor writes for certificates
  to make data entry quicker - for popup lists - caveat spelling - no checker yet installed';

GRANT SELECT ON TABLE clin_certificates.certificate_reasons TO staff;
 
 
CREATE OR REPLACE VIEW clin_certificates.vwmedicalcertificates AS 
 SELECT medical_certificates.pk AS pk_medicalcertificate, consult.fk_patient, consult.consult_date, medical_certificates.fk_consult,
  medical_certificates.date AS certificate_date, medical_certificates.reason, medical_certificates.fk_coding_system, medical_certificates.fk_code,
   medical_certificates.fk_lu_illness_temporality, medical_certificates.fk_lu_fitness, lu_fitness.fitness,
    medical_certificates.from_date, medical_certificates.deleted, medical_certificates.to_date, medical_certificates.notes, 
    consult.fk_staff, vwstaffinclinics.wholename AS staff_wholename, vwstaffinclinics.title AS staff_title, vwstaffinclinics.branch AS staff_branch,
     vwstaffinclinics.organisation AS staff_organisation, vwstaffinclinics.street AS staff_street,
      vwstaffinclinics.town AS staff_town, vwstaffinclinics.postcode AS staff_postcode,
       vwstaffinclinics.provider_number AS staff_provider_number,
        lu_illness_temporality.temporality, lu_systems.system, generic_terms.term, generic_terms.code
   FROM clin_certificates.medical_certificates medical_certificates
   JOIN clin_consult.consult ON medical_certificates.fk_consult = consult.pk
   JOIN admin.vwstaffinclinics ON consult.fk_staff = vwstaffinclinics.fk_staff
   JOIN clin_certificates.lu_illness_temporality ON medical_certificates.fk_lu_illness_temporality = lu_illness_temporality.pk
   JOIN clin_certificates.lu_fitness ON medical_certificates.fk_lu_fitness = lu_fitness.pk
   LEFT JOIN coding.lu_systems ON medical_certificates.fk_coding_system = lu_systems.pk
   LEFT JOIN coding.generic_terms ON medical_certificates.fk_code = generic_terms.code
  WHERE medical_certificates.deleted = false
  ORDER BY consult.fk_patient, consult.consult_date;

GRANT ALL ON TABLE clin_certificates.vwmedicalcertificates TO staff;
COMMENT ON VIEW clin_certificates.vwmedicalcertificates IS 'A view of patients medical certificate history, includes written by which staff member and where';


 
truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 36);
