-- Table: clin_history.social_history
-- drop cascades to clin_history.responsible_persons
-- drop cascades to clin_history.vwSocialHistory

DROP TABLE clin_history.social_history cascade;
DROP TABLE clin_history.responsible_persons;

CREATE TABLE clin_history.social_history
(
  pk serial primary key,
  fk_consult integer not null,
  history text,
  deleted boolean DEFAULT false,
  fk_responsible_patient integer default null, -- if not null this is the key to  clerical.data_patients table
  responsible_person text default null,
  responsible_person_street1 text default null, -- if not null is the street of responsible person who is not in patients database
  responsible_person_street2 text default null, -- if not null is the street2 of responsible person who is not in patients database
  responsible_person_town text default null, 
  responsible_person_contacts text,
  country_code character(2) not null,    
  responsible_person_notes text default null
 );
ALTER TABLE clin_history.social_history OWNER TO easygp;
GRANT ALL ON TABLE clin_history.social_history TO easygp;
GRANT ALL ON TABLE clin_history.social_history TO staff;
comment on table  clin_history.social_history is
'keeps patient social history and contact for responsible person, the address is hard_coded to allow for oversea''s addresses
 if fk_patient is not null the address fields will not be filled, but retrieved in the view from contacts';

COMMENT ON COLUMN clin_history.social_history.fk_responsible_patient IS 'if not null this is the key to  clerical.data_patients table';
COMMENT ON COLUMN clin_history.social_history.responsible_person_street1 IS 'if not null is the street of responsible person who is not in patients database';
COMMENT ON COLUMN clin_history.social_history.responsible_person_street2 IS 'if not null is the street2 of responsible person who is not in patients database';
COMMENT ON COLUMN clin_history.social_history.responsible_person_town IS 'if not null is the fk_town of responsible person who is not in patients database';
COMMENT ON COLUMN clin_history.social_history.responsible_person_contacts is 'one or more types of contact';
comment on column clin_history.social_history.responsible_person is 'if not null and fk_patient is null then this is used as name as responsible person';

-- probably messy  way to do this but I'm tired++

CREATE OR REPLACE VIEW clin_history.vwsocialhistory AS 
 SELECT sh.pk AS pk_socialhistory, sh.fk_consult, consult.fk_patient as fk_patient, 
 sh.history, sh.deleted,
 sh.fk_responsible_patient,
 sh.responsible_person, sh.responsible_person_street1, sh.responsible_person_street2,
 sh.responsible_person_town, sh.responsible_person_contacts, sh.country_code,
 common.lu_countries.country,
 sh.responsible_person_notes,
 contacts.vwPatients.title as patient_responsible_title,
 contacts.vwPatients.firstname as patient_responsible_firstname,
 contacts.vwPatients.surname as patient_responsible_surname, 
 contacts.vwPatients.wholename as patient_responsible_wholename,
 contacts.vwPatients.street1 as patient_responsible_street1,
 contacts.vwPatients.street2 as patient_responsible_street2, 
 contacts.vwPatients.town as patient_responsible_town, contacts.vwPatients.postcode as patient_responsible_postcode,
 contacts.vwPatients.state as patient_responsible_state,
 contacts.vwPatients.fk_town as patient_fk_town
 
   FROM clin_history.social_history sh 
   JOIN clin_consult.consult consult ON consult.pk = sh.fk_consult
   LEFT JOIN contacts.vwPatients on vwPatients.fk_patient = sh.fk_responsible_patient
    LEFT JOIN common.lu_countries on lu_countries.country_code = sh.country_code
  WHERE sh.deleted = false;

ALTER TABLE clin_history.vwsocialhistory OWNER TO easygp;
GRANT ALL ON TABLE clin_history.vwsocialhistory TO easygp;
GRANT ALL ON TABLE clin_history.vwsocialhistory TO staff;






truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 137);

