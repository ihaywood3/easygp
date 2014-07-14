-- a table to allow users to jot down what to do on the next patient visit
-- drop table clin_consult.next_visit;

create table clin_consult.next_visit
(pk serial primary key,
 fk_consult integer not null,
 todo text default null,
 Constraint next_visit_fk_consult_fkey FOREIGN KEY (fk_consult)
 REFERENCES clin_consult.consult (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION);

 alter table clin_consult.next_visit owner to easygp;
 grant all on sequence clin_consult.next_visit_pk_seq to staff;
 Grant all on table clin_consult.next_visit to staff;

 Comment on table clin_consult.next_visit is
 ' a jotter pad to remind to remind staff what is meant to be done next visit';
 
 Create or replace view clin_consult.vwNextVisit as
SELECT 
  consult.fk_patient, 
  staff.fk_role, 
  next_visit.pk,
  next_visit.todo
FROM 
  clin_consult.next_visit, 
  clin_consult.consult, 
  admin.staff
WHERE 
  next_visit.fk_consult = consult.pk AND
  consult.fk_staff = staff.pk;

  comment on view clin_consult.vwNextVisit is 
  'what members of a particular role e.g doctor think they (collective)
   need to do at the patient''s next visit - a sort of jotter pad';

  alter table clin_consult.vwNextVisit owner to easygp;
  grant select on table clin_consult.vwNextVisit to staff;
  
  update db.lu_version set lu_minor=378;
