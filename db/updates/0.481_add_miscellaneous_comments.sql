COMMENT ON COLUMN clerical.bookings.fk_lu_reason_not_billed IS 
'if not null then is the key to billing.lu_reasons_not_billed e.g ''aftercare''';
COMMENT ON COLUMN clerical.bookings.fk_lu_appointment_icon IS 
'if not null then the key to clerical.lu_appointment_icons, which are representative icons for a task e.g a pregnant women, a scalple';
COMMENT ON COLUMN clerical.bookings.fk_patient is 
'if not null key to clerical.data_patients, 
 if null, then if lu_appointment_icons is not null eg emergency then the gui displays this data
 if null, and no icon then then the notes column is displayed in the slot e.g could be a new patient not put in the DB eg Mrs Freda Jones';
 COMMENT ON COLUMN clerical.bookings.fk_lu_appointment_status is 'never null, this points to the lookup table for ''active'' or ''inactive''';
 COMMENT ON COLUMN contacts.data_persons.fk_occupation IS 'if not null the person''s prime occupation';
 COMMENT ON COLUMN contacts.data_persons.fk_sex is 'not null, but for historical (bad) design reasons fk_sex of 0 = male ie zero based table';
 COMMENT ON COLUMN clin_consult.progressnotes.fk_section is 
 'Not null, key to fk_lu_sections, for historical reasons this is zero based inconsistant with most of our keys 
  0= ''general notes'', 1= ''past history'' etc';
 COMMENT ON COLUMN clin_consult.progressnotes.fk_row is 
  'if not null points to the row in the linked_table field to which this record pertains';

COMMENT ON COLUMN clin_consult.progressnotes.fk_audit_reason is 'if not null key to clin_consult.lu_audit_reasons the reason for the row''s audit';
  
COMMENT ON COLUMN clin_mentalhealth.clozapine_record.fk_observation_white_cell_count  is 'if not null points to documents.observations table row';
COMMENT ON COLUMN clin_mentalhealth.clozapine_record.fk_observation_neutrophil_count is  'if not null points to documents.observations table row';
COMMENT ON COLUMN clerical.task_components.fk_consult is 'usually not null, but a staff>staff task is null';

 
update db.lu_version set lu_minor = 481;
