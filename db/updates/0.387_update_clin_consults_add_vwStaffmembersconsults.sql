--drop view clin_consult.vwStaffMembersPatientsConsults;

Create or replace view clin_consult.vwStaffMembersPatientsConsults as
 SELECT distinct to_char(consult_date,'DD/MM/YYYY') as pk_view, consult_date, fk_consult, fk_staff, fk_patient, fk_type, consult_type FROM clin_consult.vwProgressNotes 
 where (fk_audit_action = 1 Or fk_audit_action = 2)  AND deleted = False 
 ;

comment on view clin_consult.vwStaffMembersPatientsConsults is
'a view of all the consults of a patient for a individual staff members keyed by consult date';

alter table clin_consult.vwStaffMembersPatientsConsults owner to easygp;
grant select on clin_consult.vwStaffMembersPatientsConsults to staff;

update db.lu_version set lu_minor=387;