-- Modification to a column name so that things make more sense
Drop view clerical.vwtaskscomponents;

alter table clerical.tasks rename column task to related_to;

comment on column clerical.tasks.related_to is
'What the task is related to:
 i)  If the task origin was  a pathology result then the data could be eg ''FBC''
     if the task orgin was a letter from say specialist then the data could be ''Noted to be Anaemic''
 ii) if the task didn''t originate from a document could say, e.g a request for a patient it
     the data could be ''Please write a script for .....''';

Alter table clerical.task_components add column must_verify_completed boolean default false;
comment on column clerical.task_components.must_verify_completed is
'If True then the task absolutely must not be ''forgotten''
 Reason I have put this in is there is usually no way to 
 look back through tasks to pick out those the user considered
 to be really important, e.g a +ve faecal occult blood or 
 +ve HIV. For example the staff may have tried to contact a patient 
 but their phone number address etc has changed, or they left a 
 message, patient could have come said would come in, but in face
 they didn''t in the event. The staff member who arranged the appt
 probably has marked off their role in the task.

 This flag is used in EasyGP to hence bring up a view of all these critical tasks';
 


CREATE OR REPLACE VIEW clerical.vwtaskscomponents AS 
 SELECT task_components.pk AS pk_view, tasks.related_to, tasks.fk_row, tasks.fk_staff_finalised_task, 
 tasks.date_finalised, tasks.deleted AS task_deleted, tasks.fk_staff_filed_task, 
 tasks.fk_staff_must_finalise, tasks.fk_role_can_finalise, 
 vwstaffinclinics.wholename AS staff_filed_task_wholename, 
 vwstaffinclinics.title AS staff_filed_task_title, vwstaffinclinics2.title AS staff_finalised_task_title, 
 vwstaffinclinics2.wholename AS staff_finalised_task_wholename, 
 vwstaffinclinics3.title AS staff_must_finalise_task_title, 
 vwstaffinclinics3.wholename AS staff_must_finalise_task_wholename, 
 task_components.fk_role, task_components.pk AS fk_component, task_components.fk_task, 
 task_components.fk_consult, task_components.fk_staff_allocated, 
 task_components.fk_staff_completed, task_components.allocated_staff, 
 task_components.fk_urgency, task_components.details, task_components.must_verify_completed,
 task_components.date_completed AS date_component_completed, task_components.deleted AS component_deleted, 
 vwstaffinclinics1.wholename AS staff_allocated_wholename, 
 vwstaffinclinics1.title AS staff_allocated_title, consult.consult_date AS date_component_logged, 
 vwpatients.town AS patient_town, vwpatients.state AS patient_state, vwpatients.postcode AS patient_postcode, 
 vwpatients.street1 AS patient_street1, vwpatients.street2 AS patient_street2, 
 vwpatients.fk_person, vwpatients.fk_patient, vwpatients.wholename AS patient_wholename, 
 vwpatients.title AS patient_title, vwpatients.birthdate AS patient_birthdate, lu_urgency.urgency
   FROM clerical.task_components
   JOIN clerical.tasks ON task_components.fk_task = tasks.pk
   JOIN admin.vwstaffinclinics ON tasks.fk_staff_filed_task = vwstaffinclinics.fk_staff
   LEFT JOIN admin.vwstaffinclinics vwstaffinclinics1 ON task_components.fk_staff_allocated = vwstaffinclinics1.fk_staff
   LEFT JOIN admin.vwstaffinclinics vwstaffinclinics2 ON tasks.fk_staff_finalised_task = vwstaffinclinics2.fk_staff
   LEFT JOIN admin.vwstaffinclinics vwstaffinclinics3 ON tasks.fk_staff_must_finalise = vwstaffinclinics3.fk_staff
   JOIN clin_consult.consult ON task_components.fk_consult = consult.pk
   JOIN contacts.vwpatients ON consult.fk_patient = vwpatients.fk_patient
   JOIN common.lu_urgency ON task_components.fk_urgency = lu_urgency.pk
  WHERE task_components.fk_consult > 0
  ORDER BY vwpatients.fk_patient, task_components.pk;


ALTER TABLE clerical.vwtaskscomponents   OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponents TO easygp;
GRANT SELECT ON TABLE clerical.vwtaskscomponents TO staff;



DROP VIEW clerical.vwtaskscomponentsnotes;

CREATE OR REPLACE VIEW clerical.vwtaskscomponentsnotes AS 
 SELECT task_component_notes.pk AS pk_note, task_component_notes.fk_task_component, 
 task_component_notes.note, task_component_notes.date, task_component_notes.fk_staff_made_note, 
 task_components.date_completed,
 vwstaffinclinics.wholename AS staff_made_note_wholename, vwstaffinclinics.title AS staff_made_note_title, task_components.fk_task
   FROM clerical.task_component_notes
   JOIN admin.vwstaffinclinics ON task_component_notes.fk_staff_made_note = vwstaffinclinics.fk_staff
   JOIN clerical.task_components ON task_component_notes.fk_task_component = task_components.pk;

ALTER TABLE clerical.vwtaskscomponentsnotes   OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponentsnotes TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponentsnotes TO staff;



truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 280);


