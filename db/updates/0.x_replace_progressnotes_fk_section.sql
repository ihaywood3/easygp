-- update script to merge progressnotes.gk_section into progressnotes.linked_table

alter table clin_consult.lu_progressnotes_sections add column linked_table regclass;

update clin_consult.lu_progressnotes_sections set linked_table='clin_consult.progressnotes'::regclass where pk=0;
update clin_consult.progressnotes set linked_table='clin_consult.progressnotes'::regclass where fk_secton=0;
update clin_consult.lu_progressnotes_sections set linked_table='clin_history.past_history'::regclass where pk=1;
update clin_consult.progressnotes set linked_table='clin_history.past_history'::regclass where fk_section=1;
update clin_consult.progressnotes set linked_table='clin_history.past_history'::regclass, fk_row=fk_problem where not fk_problem is null;
delete from clin_consult.lu_progressnotes_sections where pk=2; -- "general notes and "progress notes" aren't conceptually distinct
update clin_consult.progressnotes set linked_table='clin_consult.progressnotes'::regclass where fk_section=2;
update clin_consult.lu_progressnotes_sections set linked_table='clin_history.family_conditions'::regclass where pk=3;
update clin_consult.progressnotes set linked_table='clin_history.family_conditions'::regclass where fk_section=3;
update clin_consult.lu_progressnotes_sections set linked_table='clin_history.social_history'::regclass where pk=4;
update clin_consult.progressnotes set linked_table='clin_history.social_history'::regclass where fk_section=4;
update clin_consult.lu_progressnotes_sections set linked_table='clin_history.occupational_history'::regclass where pk=5;
update clin_consult.progressnotes set linked_table='clin_history.occupational_history'::regclass where fk_section=5;
update clin_consult.lu_progressnotes_sections set linked_table='clin_measurements.measurements'::regclass where pk=6;
update clin_consult.progressnotes set linked_table='clin_measurements.measurements'::regclass where fk_section=6;
update clin_consult.lu_progressnotes_sections set linked_table='clin_procedures.skin_procedures'::regclass where pk=7;
update clin_consult.progressnotes set linked_table='clin_procedures.skin_procedures'::regclass where fk_section=7;
update clin_consult.lu_progressnotes_sections set linked_table='documents.documents'::regclass where pk=8;
update clin_consult.progressnotes set linked_table='documents.documents'::regclass where fk_section=8;
update clin_consult.lu_progressnotes_sections set linked_table='travel'::regclass where pk=9; -- RICHARD: is there a table for travel?
update clin_consult.progressnotes set linked_table='travel'::regclass where fk_section=9;
update clin_consult.lu_progressnotes_sections set linked_table='clin_workcover.visits'::regclass where pk=10;
update clin_consult.progressnotes set linked_table='clin_workcover.visits'::regclass where fk_section=10;
update clin_consult.lu_progressnotes_sections set linked_table='clin_mentalhealth.mentalhealth_plan'::regclass where pk=11;
update clin_consult.progressnotes set linked_table='clin_mentalhealth.mentalhealth_plan'::regclass where fk_section=11;
update clin_consult.lu_progressnotes_sections set linked_table='clin_checkups.annual_checkup'::regclass where pk=12;
update clin_consult.progressnotes set linked_table='clin_checkups.annual_checkup'::regclass where fk_section=12;
update clin_consult.lu_progressnotes_sections set linked_table='clerical.tasks'::regclass, section='tasks' where pk=13;  -- "scratchpad" doesn't make sense now as progressnote category
update clin_consult.progressnotes set linked_table='clerical.tasks'::regclass where fk_section=13;
update clin_consult.lu_progressnotes_sections set linked_table='clin_referrals.referrals'::regclass where pk=14;
update clin_consult.progressnotes set linked_table='clin_referrals.referrals'::regclass where fk_section=14;
update clin_consult.lu_progressnotes_sections set linked_table='clin_vaccination.vaccinations'::regclass where pk=15;
update clin_consult.progressnotes set linked_table='clin_referrals.referrals'::regclass where fk_section=15;
update clin_consult.lu_progressnotes_sections set linked_table='clin_requests.forms'::regclass where pk=16;
update clin_consult.progressnotes set linked_table='clin_requests.forms'::regclass where fk_section=16;
update clin_consult.lu_progressnotes_sections set linked_table='clin_recalls.recalls'::regclass where pk=17;
update clin_consult.progressnotes set linked_table=''::regclass where fk_section=;
update clin_consult.lu_progressnotes_sections set linked_table='clin_prescribing.item_prescribed'::regclass where pk=18;
update clin_consult.progressnotes set linked_table='clin_prescribing.item_prescribed'::regclass where fk_section=;
update clin_consult.lu_progressnotes_sections set linked_table='clin_allergies.allergies'::regclass where pk=19;
update clin_consult.progressnotes set linked_table='clin_allergies.allergies'::regclass where fk_section=;
delete from clin_consult.lu_progressnotes_sections where pk=20; -- "documents" not conceptually distinct from "inbox" above
update clin_consult.progressnotes set linked_table='documents.documents'::regclass where fk_section=20;

drop view vwprogressnotes;

alter table clin_consult.progressnotes drop table fk_section;
alter table clin_consult.progressnotes drop table fk_problem;
alter table clin_consult.progressnotes drop table problem;

CREATE OR REPLACE VIEW clin_consult.vwprogressnotes AS 
 SELECT 
"CONSULT".fk_patient, 
progressnotes.pk AS pk_progressnote, 
"CONSULT".consult_date, 
"CONSULT_TYPE".type AS consult_type, 
sec.section, 
progressnotes.notes, 
"CONSULT".summary, 
progressnotes.fk_consult, 
progressnotes.fk_audit_action, 
"CONSULT".fk_staff, 
"CONSULT".fk_type,
data_persons.firstname, 
data_persons.surname, 
lu_title.title, 
lu_audit_actions.action AS audit_action, 
progressnotes.linked_table, 
progressnotes.fk_audit_reason, 
progressnotes.fk_row, 
lu_audit_actions.insist_reason, 
lu_staff_roles.role
   FROM clin_consult.consult "CONSULT"
   LEFT JOIN clin_consult.lu_consult_type "CONSULT_TYPE" ON "CONSULT".fk_type = "CONSULT_TYPE".pk
   JOIN admin.staff ON "CONSULT".fk_staff = staff.pk
   JOIN contacts.data_persons ON staff.fk_person = data_persons.pk
   LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
   JOIN clin_consult.progressnotes ON "CONSULT".pk = progressnotes.fk_consult
   LEFT JOIN clin_consult.lu_progressnotes_sections sec ON progressnotes.linked_table = sec.linked_table
   LEFT JOIN clin_consult.lu_audit_actions ON progressnotes.fk_audit_action = lu_audit_actions.pk
   JOIN admin.lu_staff_roles ON staff.fk_role = lu_staff_roles.pk
  WHERE "CONSULT_TYPE".pk <> 8;

truncate table db.lu_version;
insert into db.lu_version(lu_major,lu_minor) values (0, 59);