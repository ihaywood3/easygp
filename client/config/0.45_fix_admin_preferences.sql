ALTER TABLE "admin".global_preferences OWNER TO easygp;
GRANT SELECT ON TABLE  "admin".global_preferences TO staff;
GRANT ALL ON TABLE "admin".global_preferences TO easygp;

--temporary for me
create or replace view clerical.vwtaskscomponents_new as
SELECT 
  clerical.tasks.task,
  clerical.tasks.fk_staff_filed_task,
  clerical.tasks.fk_staff_finalised_task,
  clerical.tasks.fk_schema,
  clerical.tasks.fk_table,
  clerical.tasks.fk_row,
  clerical.tasks.date_finalised,
  clerical.tasks.deleted as task_deleted,
  clerical.task_components.pk AS pk_view,
  clerical.task_components.pk AS fk_component,
  clerical.task_components.fk_task,
  clerical.task_components.fk_consult,
  clerical.task_components.date_logged,
  clerical.task_components.fk_staff_allocated,
  clerical.task_components.fk_staff_completed,
  clerical.task_components.allocated_staff,
  clerical.task_components.fk_lu_task_type,
  clerical.task_components.fk_urgency,
  clerical.task_components.details,
  clerical.task_components.date_completed as date_component_completed,
  clerical.task_components.deleted as component_deleted,
  admin.vwstaffinclinics.wholename AS staff_filed_task_wholename,
  admin.vwstaffinclinics.title AS staff_filed_task_title,
  vwstaffinclinics1.wholename AS staff_finalised_task_wholname,
  vwstaffinclinics1.title AS staff_finalised_task_title,
  vwstaffinclinics2.wholename AS staff_allocated_wholename,
  vwstaffinclinics2.title AS staff_allocated_title,
  vwstaffinclinics3.wholename AS staff_completed_component_wholename,
  vwstaffinclinics3.title AS staff_completed_component_title,
  clin_consult.consult.consult_date AS date_component_logged,
  common.lu_urgency.urgency,
  admin.vwstaff.fk_staff AS fk_staff_filed_component,
  admin.vwstaff.wholename AS staff_filed_component_wholename,
  admin.vwstaff.title AS staff_filed_component_title,
  contacts.vwpatients.wholename AS patient_wholename,
  contacts.vwpatients.firstname AS patient_firstname,
  contacts.vwpatients.surname AS patient_surname,
  contacts.vwpatients.birthdate AS patient_birthdate,
  contacts.vwpatients.fk_sex,
  contacts.vwpatients.fk_title AS patient_fk_title,
  contacts.vwpatients.title AS patient_title,
  contacts.vwpatients.street AS patient_street,
  contacts.vwpatients.town AS patient_town,
  contacts.vwpatients.state AS patient_state,
  contacts.vwpatients.postcode AS patient_postcode,
  contacts.vwpatients.fk_person,
  contacts.vwpatients.fk_patient,
  contacts.vwpatients."age" AS patient_age,
  clerical.lu_task_types.type AS task_type
FROM
  clerical.tasks
  INNER JOIN clerical.task_components ON (clerical.tasks.pk = clerical.task_components.fk_task)
  INNER JOIN admin.vwstaffinclinics ON (clerical.tasks.fk_staff_filed_task = admin.vwstaffinclinics.fk_staff)
  LEFT OUTER JOIN admin.vwstaffinclinics vwstaffinclinics1 ON (clerical.tasks.fk_staff_finalised_task = vwstaffinclinics1.fk_staff)
  INNER JOIN admin.vwstaffinclinics vwstaffinclinics2 ON (clerical.task_components.fk_staff_allocated = vwstaffinclinics2.fk_staff)
  LEFT OUTER JOIN admin.vwstaffinclinics vwstaffinclinics3 ON (clerical.task_components.fk_staff_completed = vwstaffinclinics3.fk_staff)
  INNER JOIN clin_consult.consult ON (clerical.task_components.fk_consult = clin_consult.consult.pk)
  INNER JOIN common.lu_urgency ON (clerical.task_components.fk_urgency = common.lu_urgency.pk)
  INNER JOIN admin.vwstaff ON (clin_consult.consult.fk_staff = admin.vwstaff.fk_staff)
  INNER JOIN contacts.vwpatients ON (clin_consult.consult.fk_patient = contacts.vwpatients.fk_patient)
  INNER JOIN clerical.lu_task_types ON (clerical.task_components.fk_lu_task_type = clerical.lu_task_types.pk)

   WHERE task_components.fk_consult > 0
  ORDER BY vwpatients.fk_patient, task_components.pk;

ALTER TABLE clerical.vwtaskscomponents_new OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponents_new TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponents_new TO staff;
