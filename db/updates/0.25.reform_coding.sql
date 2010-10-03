drop view clin_prescribing.vwpatientsmedications;
drop view coding.vwavailablecodingsystems;
drop view coding.vwreasonsweighted;
drop view coding.vwgenericterms;
drop table coding.available_systems;
drop table coding.lu_icd10;
drop table coding.lu_icd10_chapters;
drop table coding.lu_icd10_subchapters;
drop table coding.lu_icd10_old;
drop table coding.usr_reasons_weighting;
drop table coding.lu_reasons;

CREATE TABLE coding.usr_codes_weighting
(
  pk serial NOT NULL,
  code text not null,
  fk_coding_system integer not null,
  fk_staff integer NOT NULL,
  weighting integer NOT NULL,
  CONSTRAINT usr_codes_weighting_pkey PRIMARY KEY (pk)
)
WITH (
  OIDS=FALSE
);

grant all on coding.usr_codes_weighting to staff;

CREATE OR REPLACE VIEW coding.vwcodesweighted AS 
 SELECT t.code, t.fk_coding_system, t.term, w.fk_staff, w.weighting
   FROM coding.generic_terms t
   LEFT JOIN coding.usr_codes_weighting w ON (t.code = w.code and w.fk_coding_system = t.fk_coding_system);

grant select on coding.vwcodesweighted to staff;

alter table coding.lu_systems add column  author text;
alter table coding.lu_systems add column  preferred boolean default 'f' not null;
comment on column coding.lu_systems.preferred is 'true if this is the preferred system';
comment on column coding.lu_systems.author is 'the authors of the system';
update coding.lu_systems set preferred='t' where pk=1;
update coding.lu_systems set author='Family Medicine Research Unit, University of Sydney' where pk=1;
update coding.lu_systems set author='World Health Organisation' where pk=2;
update coding.lu_systems set author='EasyGP developers' where pk=3;
update coding.lu_systems set system='FreeCodes' where pk=3;

drop view coding.v1;

alter table coding.generic_terms add column icd10 varchar(15);
comment on column coding.generic_terms.icd10 is 'mapping to ICD-10 where this exists for the system';

CREATE OR REPLACE VIEW coding.vwgenericterms AS 
 SELECT DISTINCT generic_terms.code AS pk_view, generic_terms.code, generic_terms.body_system, generic_terms.code_role, generic_terms.term, generic_terms.fk_coding_system, 
   generic_terms.icd10,generic_terms.active, s.system as system, s.preferred as preferred
   FROM coding.generic_terms, coding.lu_systems s where s.pk = generic_terms.fk_coding_system;

grant select on coding.vwgenericterms to staff;

create table coding.icpc2_user_terms as select * from coding.lu_user_icpc2_terms;
grant all on coding.icpc2_user_terms to staff;

DROP TABLE coding.lu_user_icpc2_terms; 

create table coding.icpc2_drsdesk_term_mapper as select * from coding.lu_drsdesk_icpc_term_mapper;
grant all on coding.icpc2_drsdesk_term_mapper to staff;

DROP TABLE coding.lu_drsdesk_icpc_term_mapper;

alter table clin_prescribing.items_prescribed add column fk_coding_system integer;
alter table clin_prescribing.items_prescribed drop column fk_prescribed_for;
alter table clin_prescribing.items_prescribed add column fk_prescribed_for text;


CREATE OR REPLACE VIEW clin_prescribing.vwpatientsmedications AS 
 SELECT consult.fk_patient, items_prescribed.script_date, lu_brand.brand, lu_generics.generics, items_prescribed.strength, items_prescribed.repeats, lu_instructions.instruction, 
generic_terms.term, items_prescribed.quantity, lu_generics.class_codes, items_prescribed.pk AS pk_item_prescribed, items_prescribed.fk_consult, items_prescribed.fk_medication, 
items_prescribed.fk_pack, items_prescribed.fk_instruction, items_prescribed.fk_prescribed_for, items_prescribed.fk_authority, items_prescribed.fk_pbs, items_prescribed.print_status, 
items_prescribed.suppress_reason, items_prescribed.s8, items_prescribed.reg24, items_prescribed.active, consult.consult_date, consult.fk_staff, medications.fk_lu_generics, 
medications.fk_lu_brand, medications.deleted, lu_pbs_status.status AS pbs_status
   FROM clin_prescribing.items_prescribed
   JOIN clin_prescribing.medications ON items_prescribed.fk_medication = medications.pk
   JOIN clin_prescribing.lu_brand ON medications.fk_lu_brand = lu_brand.pk
   JOIN clin_prescribing.lu_generics ON medications.fk_lu_generics = lu_generics.pk
   JOIN clin_consult.consult ON items_prescribed.fk_consult = consult.pk
   JOIN clin_prescribing.lu_instructions ON items_prescribed.fk_instruction = lu_instructions.pk
   JOIN coding.generic_terms ON (items_prescribed.fk_prescribed_for = generic_terms.code and items_prescribed.fk_coding_system = generic_terms.fk_coding_system)
   JOIN clin_prescribing.lu_pbs_status ON items_prescribed.fk_pbs = lu_pbs_status.pk
  WHERE not medications.deleted;
grant select on clin_prescribing.vwpatientsmedications to staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 25);

