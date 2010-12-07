-- table renaming to make referencing using foreign keys more logical

alter table clin_consult.lu_actions rename to lu_audit_actions;

-- replace view dropped in IAN's cascading delete of schema AUDIT
-- Ah, finally, I can see progress notes again!!!!!1

CREATE OR REPLACE VIEW clin_consult.vwprogressnotes AS 
SELECT 
  "CONSULT".fk_patient,
   clin_consult.progressnotes.pk as pk_progressnote,
  "CONSULT".consult_date,
  "CONSULT_TYPE".type AS consult_type,
  "SECTION".section,
   clin_consult.progressnotes.problem,
   clin_consult.progressnotes.notes,
  "CONSULT".summary,
   clin_consult.progressnotes.fk_consult,
   clin_consult.progressnotes.fk_section,
   clin_consult.progressnotes.fk_code,
   clin_consult.progressnotes.fk_problem,
   clin_consult.progressnotes.fk_audit_action,
  "CONSULT".fk_staff,
  "CONSULT".fk_type,
  contacts.data_persons.firstname,
  contacts.data_persons.surname,
  contacts.lu_title.title,
  clin_consult.lu_audit_actions.action AS audit_action,

  clin_consult.progressnotes.linked_table,
  clin_consult.progressnotes.fk_audit_reason,
  clin_consult.progressnotes.fk_row,
  clin_consult.lu_audit_actions.insist_reason,
  admin.lu_staff_roles.role
FROM
  clin_consult.consult "CONSULT"
  LEFT OUTER JOIN clin_consult.lu_consult_type "CONSULT_TYPE" ON ("CONSULT".fk_type = "CONSULT_TYPE".pk)
  INNER JOIN admin.staff ON ("CONSULT".fk_staff = admin.staff.pk)
  INNER JOIN contacts.data_persons ON (admin.staff.fk_person = contacts.data_persons.pk)
  INNER JOIN contacts.lu_title ON (contacts.data_persons.fk_title = contacts.lu_title.pk)
  INNER JOIN clin_consult.progressnotes ON ("CONSULT".pk = clin_consult.progressnotes.fk_consult)
  INNER JOIN clin_consult.lu_progressnotes_sections "SECTION" ON (clin_consult.progressnotes.fk_section = "SECTION".pk)
  INNER JOIN clin_consult.lu_audit_actions ON (clin_consult.progressnotes.fk_audit_action = clin_consult.lu_audit_actions.pk)
  INNER JOIN admin.lu_staff_roles ON (admin.staff.fk_role = admin.lu_staff_roles.pk)
  WHERE "CONSULT_TYPE".pk <> 8 
  ORDER BY "CONSULT".fk_patient,
  "CONSULT".consult_date, "CONSULT".fk_staff, "SECTION".pk, clin_consult.progressnotes.fk_problem;
  
    truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 50)