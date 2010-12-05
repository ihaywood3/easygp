update admin.lu_staff_roles
set role = 'dentist' where pk = 2;
update admin.lu_staff_roles
set role = 'information technology' where pk = 8;

Delete from admin.lu_staff_roles where pk = 9;

 ALTER SEQUENCE admin.lu_staff_roles_pk_seq 
 RESTART 8 ;


ALTER TABLE clerical.task_components
add column fk_role integer;

Comment on column clerical.task_components.fk_role is
'foreign key to admin.lu_staff_roles 
 points to the role within the organisation for which the task 
 is designated key of 7=secretarial';
 
 DROP VIEW clerical.vwtaskscomponents;

CREATE OR REPLACE VIEW clerical.vwtaskscomponents AS 
 SELECT task_components.pk AS pk_view, tasks.task, tasks.fk_schema, tasks.fk_table, tasks.fk_row, 
 tasks.fk_staff_finalised_task, tasks.date_finalised, tasks.deleted AS task_deleted, tasks.fk_staff_filed_task,
  vwstaffinclinics.wholename AS staff_filed_task_wholename, vwstaffinclinics.title AS staff_filed_task_title, 
  vwstaffinclinics2.title AS staff_finalised_task_title, vwstaffinclinics2.wholename AS staff_finalised_task_wholename, task_components.fk_role,
  task_components.pk AS fk_component, task_components.fk_task, task_components.fk_consult, task_components.fk_staff_allocated, 
  task_components.fk_staff_completed, task_components.allocated_staff, task_components.fk_lu_task_type, task_components.fk_urgency, 
  task_components.details, task_components.date_completed AS date_component_completed, task_components.deleted AS component_deleted, 
  vwstaffinclinics1.wholename AS staff_allocated_wholename, vwstaffinclinics1.title AS staff_allocated_title, consult.consult_date AS date_component_logged, 
  vwpatients.town AS patient_town, vwpatients.state AS patient_state, vwpatients.postcode AS patient_postcode, vwpatients.street AS patient_street, 
  vwpatients.fk_person, vwpatients.fk_patient, vwpatients.wholename AS patient_wholename, vwpatients.title AS patient_title, 
  vwpatients.birthdate AS patient_birthdate, lu_task_types.type AS task_type, lu_urgency.urgency
   FROM clerical.task_components
   JOIN clerical.tasks ON task_components.fk_task = tasks.pk
   JOIN admin.vwstaffinclinics ON tasks.fk_staff_filed_task = vwstaffinclinics.fk_staff
   LEFT JOIN admin.vwstaffinclinics vwstaffinclinics1 ON task_components.fk_staff_allocated = vwstaffinclinics1.fk_staff
   LEFT JOIN admin.vwstaffinclinics vwstaffinclinics2 ON tasks.fk_staff_finalised_task = vwstaffinclinics2.fk_staff
   JOIN clin_consult.consult ON task_components.fk_consult = consult.pk
   JOIN contacts.vwpatients ON consult.fk_patient = vwpatients.fk_patient
   JOIN clerical.lu_task_types ON task_components.fk_lu_task_type = lu_task_types.pk
   JOIN common.lu_urgency ON task_components.fk_urgency = lu_urgency.pk
  WHERE task_components.fk_consult > 0
  ORDER BY vwpatients.fk_patient, task_components.pk;

ALTER TABLE clerical.vwtaskscomponents OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponents TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponents TO staff;

Create or replace view Clerical.vwTasksComponentsAndNotes as

SELECT 
  case 
      WHEN clerical.task_component_notes.pk is null then clerical.task_components.pk ||'-0'::text
      ELSE clerical.task_components.pk ||'-'||  clerical.task_component_notes.pk
  end as pk_view ,
  clerical.tasks.task,
  clerical.lu_task_types.type AS task_type,
  clerical.task_components.details,

  clerical.task_component_notes.note,
  clerical.tasks.fk_schema,
  clerical.tasks.fk_table,
  clerical.tasks.fk_row,
  clerical.tasks.fk_staff_finalised_task,
  clerical.tasks.date_finalised,
  clerical.tasks.deleted AS task_deleted,
  clerical.tasks.fk_staff_filed_task,
  admin.vwstaffinclinics.wholename AS staff_filed_task_wholename,
  admin.vwstaffinclinics.title AS staff_filed_task_title,
  vwstaffinclinics2.title AS staff_finalised_task_title,
  vwstaffinclinics2.wholename AS staff_finalised_task_wholename,
  clerical.task_components.fk_role,
  clerical.task_components.pk AS fk_component,
  clerical.task_components.fk_task,
  clerical.task_components.fk_consult,
  clerical.task_components.fk_staff_allocated,
  clerical.task_components.fk_staff_completed,
  clerical.task_components.allocated_staff,
  clerical.task_components.fk_lu_task_type,
  clerical.task_components.fk_urgency,
 
  clerical.task_components.date_completed AS date_component_completed,
  clerical.task_components.deleted AS component_deleted,
  vwstaffinclinics1.wholename AS staff_allocated_wholename,
  vwstaffinclinics1.title AS staff_allocated_title,
  clin_consult.consult.consult_date AS date_component_logged,
  contacts.vwpatients.town AS patient_town,
  contacts.vwpatients.state AS patient_state,
  contacts.vwpatients.postcode AS patient_postcode,
  contacts.vwpatients.street AS patient_street,
  contacts.vwpatients.fk_person,
  contacts.vwpatients.fk_patient,
  contacts.vwpatients.wholename AS patient_wholename,
  contacts.vwpatients.title AS patient_title,
  contacts.vwpatients.birthdate AS patient_birthdate,
  
  common.lu_urgency.urgency,
  clerical.task_component_notes.pk AS fk_task_component_note,
  
  clerical.task_component_notes.date AS date_note,
  clerical.task_component_notes.fk_staff_made_note

FROM
  clerical.task_components
  INNER JOIN clerical.tasks ON (clerical.task_components.fk_task = clerical.tasks.pk)
  INNER JOIN admin.vwstaffinclinics ON (clerical.tasks.fk_staff_filed_task = admin.vwstaffinclinics.fk_staff)
  LEFT OUTER JOIN admin.vwstaffinclinics vwstaffinclinics1 ON (clerical.task_components.fk_staff_allocated = vwstaffinclinics1.fk_staff)
  LEFT OUTER JOIN admin.vwstaffinclinics vwstaffinclinics2 ON (clerical.tasks.fk_staff_finalised_task = vwstaffinclinics2.fk_staff)
  INNER JOIN clin_consult.consult ON (clerical.task_components.fk_consult = clin_consult.consult.pk)
  INNER JOIN contacts.vwpatients ON (clin_consult.consult.fk_patient = contacts.vwpatients.fk_patient)
  INNER JOIN clerical.lu_task_types ON (clerical.task_components.fk_lu_task_type = clerical.lu_task_types.pk)
  INNER JOIN common.lu_urgency ON (clerical.task_components.fk_urgency = common.lu_urgency.pk)
  LEFT OUTER JOIN clerical.task_component_notes ON (clerical.task_components.pk = clerical.task_component_notes.fk_task_component)
  WHERE task_components.fk_consult > 0
  ORDER BY vwpatients.fk_patient, task_components.pk;

  ALTER TABLE clerical.vwTasksComponentsAndNotes OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwTasksComponentsAndNotes TO easygp;
GRANT ALL ON TABLE clerical.vwTasksComponentsAndNotes TO staff;

  truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 48)