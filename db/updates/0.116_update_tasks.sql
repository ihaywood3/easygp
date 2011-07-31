alter table clerical.tasks add column fk_staff_must_finalise integer default null;
comment on column  clerical.tasks.fk_staff_must_finalise is
'if not null, then this staff member has ultimate responsbility to finalise the task';

alter table clerical.tasks add column fk_role_can_finalise integer default null;

comment on column  clerical.tasks.fk_role_can_finalise is
'if not null, then a staff member of this role can finalise the task';

COMMENT ON TABLE clerical.tasks IS 
'A task can be generated for either a patient or a staff member
 It may have 1 or more components, for either same or different staff members
 If linked to a document then all actions for this task will be veiwed in the documents audit trail.
 The task can be allocated to
 - a particuliar staff member, or anyone of a particular role
 The task can be set to be finalised by:
 - a designated staff member only (currently only the task allocator) and no-one else
 - any staff member of a particular role
 Once all components to a task are completed fk_staff_finalised and date finalised is set
 ';


 DROP VIEW clerical.vwtaskscomponents;

CREATE OR REPLACE VIEW clerical.vwtaskscomponents AS 
 SELECT task_components.pk AS pk_view, tasks.task, tasks.fk_row, tasks.fk_staff_finalised_task, tasks.date_finalised, 
 tasks.deleted AS task_deleted, tasks.fk_staff_filed_task, tasks.fk_staff_must_finalise, tasks.fk_role_can_finalise,
  vwstaffinclinics.wholename AS staff_filed_task_wholename, vwstaffinclinics.title AS staff_filed_task_title, 
  vwstaffinclinics2.title AS staff_finalised_task_title, vwstaffinclinics2.wholename AS staff_finalised_task_wholename,
  vwstaffinclinics3.title AS staff_must_finalise_task_title, vwstaffinclinics3.wholename AS staff_must_finalise_task_wholename,
  task_components.fk_role, task_components.pk AS fk_component, task_components.fk_task, task_components.fk_consult, 
   task_components.fk_staff_allocated, task_components.fk_staff_completed, task_components.allocated_staff, task_components.fk_urgency, 
   task_components.details, task_components.date_completed AS date_component_completed, task_components.deleted AS component_deleted, 
   vwstaffinclinics1.wholename AS staff_allocated_wholename, vwstaffinclinics1.title AS staff_allocated_title, 
   consult.consult_date AS date_component_logged, vwpatients.town AS patient_town, vwpatients.state AS patient_state, 
   vwpatients.postcode AS patient_postcode, vwpatients.street1 AS patient_street1, vwpatients.street2 AS patient_street2, 
   vwpatients.fk_person, vwpatients.fk_patient, vwpatients.wholename AS patient_wholename, vwpatients.title AS patient_title, 
   vwpatients.birthdate AS patient_birthdate, lu_urgency.urgency
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

ALTER TABLE clerical.vwtaskscomponents OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponents TO easygp;
GRANT SELECT ON TABLE clerical.vwtaskscomponents TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 116);
