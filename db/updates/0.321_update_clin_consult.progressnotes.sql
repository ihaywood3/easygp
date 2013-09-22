-- a bugfix for mis-labelled progress notes.
-- by way of explanation for historical reasons a visible label was set with the section type of progress notes
-- I continued to use this instead of an internal string to save the type of progress note 
-- In the progress notes embedded in the inbox I forgot to do this and the progress notes type was set to 'Section Label'
-- at some time in the future when my brain is clearer I'll go through the notes and fix this.

update clin_consult.progressnotes set problem='New General Notes' where problem='Section Label';

-- included consult_date in the progress notes codes view to allow filtering on today

DROP VIEW clin_consult.vwprogressnotescodes;

CREATE OR REPLACE VIEW clin_consult.vwprogressnotescodes AS 
 SELECT 
 consult.fk_patient, consult.consult_date, consult.fk_staff,
 progressnotes_codes.pk, progressnotes_codes.fk_progressnote, 
 progressnotes_codes.fk_code, progressnotes_codes.deleted, 
 generic_terms.fk_coding_system, generic_terms.term
   FROM clin_consult.consult, clin_consult.progressnotes_codes, clin_consult.progressnotes, coding.generic_terms
  WHERE progressnotes_codes.fk_code = generic_terms.code 
  AND progressnotes.fk_consult = consult.pk AND progressnotes.pk = progressnotes_codes.fk_progressnote;

ALTER TABLE clin_consult.vwprogressnotescodes   OWNER TO easygp;
GRANT ALL ON TABLE clin_consult.vwprogressnotescodes TO easygp;
GRANT ALL ON TABLE clin_consult.vwprogressnotescodes TO staff;


truncate db.lu_version;                                                                                                                                                                      
insert into db.lu_version (lu_major,lu_minor) values (0, 321);
