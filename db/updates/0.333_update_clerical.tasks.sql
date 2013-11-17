-- fix typo and in the view comment and added a field staff_made_note_title for display in the audit trail

CREATE OR REPLACE VIEW clerical.vwtaskscomponentsandnotes AS 
 SELECT 
        CASE
            WHEN task_component_notes.pk IS NULL THEN task_components.pk || '-0'::text
            ELSE (task_components.pk || '-'::text) || task_component_notes.pk
        END AS pk_view, tasks.related_to AS task, task_components.details, task_component_notes.note, tasks.fk_row, 
        tasks.fk_staff_finalised_task, tasks.fk_staff_must_finalise, tasks.fk_role_can_finalise, tasks.date_finalised, 
        tasks.deleted AS task_deleted, tasks.fk_staff_filed_task, vwstaffinclinics.wholename AS staff_filed_task_wholename, 
        vwstaffinclinics.title AS staff_filed_task_title, vwstaffinclinics2.title AS staff_finalised_task_title, 
        vwstaffinclinics2.wholename AS staff_finalised_task_wholename, 
        vwstaffinclinics3.title AS staff_must_finalise_task_title, vwstaffinclinics3.wholename AS staff_must_finalise_task_wholename, 
        task_components.fk_role, lu_staff_roles.role AS role_allocated, task_components.pk AS fk_component, 
        task_components.fk_task, task_components.fk_consult, task_components.fk_staff_allocated, 
        task_components.fk_staff_completed, task_components.allocated_staff, task_components.fk_urgency, 
        task_components.date_completed AS date_component_completed, task_components.deleted AS component_deleted,
        vwstaffinclinics1.wholename AS staff_allocated_wholename, vwstaffinclinics1.title AS staff_allocated_title, 
        consult.consult_date AS date_component_logged, vwpatients.town AS patient_town, 
        vwpatients.state AS patient_state, vwpatients.postcode AS patient_postcode, 
        vwpatients.street1 AS patient_street1, vwpatients.street2 AS patient_street2, 
        vwpatients.fk_person, vwpatients.fk_patient, vwpatients.wholename AS patient_wholename, 
        vwpatients.title AS patient_title, vwpatients.birthdate AS patient_birthdate, 
        lu_urgency.urgency, task_component_notes.pk AS fk_task_component_note, task_component_notes.date AS date_note, 
        task_component_notes.fk_staff_made_note, vwstaffinclinics4.wholename AS staff_made_note_wholename,
        vwstaffinclinics4.title AS staff_made_note_title
   FROM clerical.task_components
   JOIN clerical.tasks ON task_components.fk_task = tasks.pk
   JOIN admin.vwstaffinclinics ON tasks.fk_staff_filed_task = vwstaffinclinics.fk_staff
   LEFT JOIN admin.vwstaffinclinics vwstaffinclinics1 ON task_components.fk_staff_allocated = vwstaffinclinics1.fk_staff
   LEFT JOIN admin.vwstaffinclinics vwstaffinclinics2 ON tasks.fk_staff_finalised_task = vwstaffinclinics2.fk_staff
   LEFT JOIN admin.vwstaffinclinics vwstaffinclinics3 ON tasks.fk_staff_must_finalise = vwstaffinclinics3.fk_staff
   JOIN clin_consult.consult ON task_components.fk_consult = consult.pk
   JOIN contacts.vwpatients ON consult.fk_patient = vwpatients.fk_patient
   JOIN common.lu_urgency ON task_components.fk_urgency = lu_urgency.pk
   LEFT JOIN clerical.task_component_notes ON task_components.pk = task_component_notes.fk_task_component
   LEFT JOIN admin.vwstaffinclinics vwstaffinclinics4 ON task_component_notes.fk_staff_made_note = vwstaffinclinics4.fk_staff
   LEFT JOIN admin.lu_staff_roles ON task_components.fk_role = lu_staff_roles.pk
  WHERE task_components.fk_consult > 0
  ORDER BY vwpatients.fk_patient, task_components.pk;

ALTER TABLE clerical.vwtaskscomponentsandnotes   OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponentsandnotes TO easygp;
GRANT SELECT ON TABLE clerical.vwtaskscomponentsandnotes TO staff;
COMMENT ON VIEW clerical.vwtaskscomponentsandnotes
  IS 'the tasks and each component in it''s actioning and any associated notes.
  Note: if task_components.fk_role is not null then anyone of that role can action it
       hence lu_staff_roles.role as role_can_action gives the text for that role e.g secretary
       this is also why staff_made_note_wholename to indicate which staff actually did the component';

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 333);
