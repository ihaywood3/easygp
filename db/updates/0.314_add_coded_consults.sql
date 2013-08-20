-- add coding to clin_consult and drop an unwanted view;

Drop view clin_consult.vwProgressNotes1;

CREATE TABLE clin_consult.progressnotes_codes
(
  pk serial primary key,
  fk_progressnote integer NOT NULL,
  fk_code text NOT NULL,
  deleted boolean NOT NULL DEFAULT false,
  CONSTRAINT progressnotes_codes_fk_progressnote_fkey FOREIGN KEY (fk_progressnote)
      REFERENCES clin_consult.progressnotes (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);


ALTER TABLE clin_consult.progressnotes_codes   OWNER TO easygp;
GRANT ALL ON TABLE clin_consult.progressnotes_codes TO easygp;
GRANT ALL ON TABLE clin_consult.progressnotes_codes TO staff;

CREATE OR REPLACE VIEW clin_consult.vwprogressnotescodes AS 
 SELECT consult.fk_patient, progressnotes_codes.pk, progressnotes_codes.fk_progressnote, 
 progressnotes_codes.fk_code, progressnotes_codes.deleted, generic_terms.fk_coding_system, generic_terms.term
   FROM clin_consult.consult, clin_consult.progressnotes_codes, clin_consult.progressnotes, coding.generic_terms
  WHERE 
      progressnotes_codes.fk_code = generic_terms.code 
  AND progressnotes.fk_consult = consult.pk AND progressnotes.pk = progressnotes_codes.fk_progressnote;

ALTER TABLE clin_consult.vwprogressnotescodes   OWNER TO easygp;
GRANT ALL ON TABLE clin_consult.vwprogressnotescodes TO easygp;
GRANT ALL ON TABLE clin_consult.vwprogressnotescodes TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 314);
