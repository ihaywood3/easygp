CREATE OR REPLACE VIEW clerical.vwtaskscomponentsnotes AS 
 SELECT task_component_notes.pk AS pk_note, task_component_notes.fk_task_component, task_component_notes.note, 
 task_component_notes.date, task_component_notes.fk_staff_made_note, vwstaffinclinics.wholename AS staff_made_note_wholename, 
 vwstaffinclinics.title AS staff_made_note_title, task_components.fk_task
   FROM clerical.task_component_notes
   JOIN admin.vwstaffinclinics ON task_component_notes.fk_staff_made_note = vwstaffinclinics.fk_staff
   JOIN clerical.task_components ON task_component_notes.fk_task_component = task_components.pk;

ALTER TABLE clerical.vwtaskscomponentsnotes OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponentsnotes TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponentsnotes TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 160);
