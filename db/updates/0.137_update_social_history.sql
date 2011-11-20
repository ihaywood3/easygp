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
  fk_responsible_person integer default null, -- if not null this is the key to  clerical.data_patients table
  responsible_person text default null,
  responsible_person_street1 text default null, -- if not null is the street of responsible person who is not in patients database
  responsible_person_street2 text default null, -- if not null is the street2 of responsible person who is not in patients database
  responsible_person_town text default null, 
  responsible_person_postcode text default null, 
  responsible_person_state text default null, 
  responsible_person_contacts text,
  country_code text,    
  responsible_person_notes text default null
 );
ALTER TABLE clin_history.social_history OWNER TO easygp;
GRANT ALL ON TABLE clin_history.social_history TO easygp;
GRANT ALL ON TABLE clin_history.social_history TO staff;
comment on table  clin_history.social_history is
'keeps patient social history and contact for responsible person, the address is hard_coded to allow for oversea''s addresses
 if fk_person is not null the address fields will not be filled, but retrieved in the view from contacts';

COMMENT ON COLUMN clin_history.social_history.fk_responsible_person IS 'if not null this is the key to  clerical.data_persons table';
COMMENT ON COLUMN clin_history.social_history.responsible_person_street1 IS 'if not null is the street of responsible person who is not in patients database';
COMMENT ON COLUMN clin_history.social_history.responsible_person_street2 IS 'if not null is the street2 of responsible person who is not in patients database';
COMMENT ON COLUMN clin_history.social_history.responsible_person_town IS 'if not null is the fk_town of responsible person who is not in patients database';
COMMENT ON COLUMN clin_history.social_history.responsible_person_contacts is 'one or more types of contact';
comment on column clin_history.social_history.responsible_person is 'if not null and fk_patient is null then this is used as name as responsible person';

CREATE OR REPLACE VIEW clin_history.vwsocialhistory AS 
 SELECT sh.pk AS pk_socialhistory, sh.fk_consult, consult.fk_patient, sh.history, sh.deleted, sh.fk_responsible_person, 
sh.responsible_person, sh.responsible_person_street1, sh.responsible_person_street2, sh.responsible_person_town, 
sh.responsible_person_state, sh.responsible_person_postcode, sh.responsible_person_contacts, sh.country_code, lu_countries.country, 
sh.responsible_person_notes, vwpersonsincludingpatients.title AS person_responsible_title, vwpersonsincludingpatients.firstname AS person_responsible_firstname, 
vwpersonsincludingpatients.surname AS person_responsible_surname, vwpersonsincludingpatients.wholename AS person_responsible_wholename, 
vwpersonsincludingpatients.street1 AS person_responsible_street1, vwpersonsincludingpatients.street2 AS person_responsible_street2, 
vwpersonsincludingpatients.town AS person_responsible_town, vwpersonsincludingpatients.postcode AS person_responsible_postcode, 
vwpersonsincludingpatients.state AS person_responsible_state, vwpersonsincludingpatients.fk_town AS patient_fk_town
   FROM clin_history.social_history sh
   JOIN clin_consult.consult consult ON consult.pk = sh.fk_consult
   LEFT JOIN contacts.vwpersonsincludingpatients ON vwpersonsincludingpatients.fk_person = sh.fk_responsible_person
   LEFT JOIN common.lu_countries ON lu_countries.country_code::text = sh.country_code
  WHERE sh.deleted = false;

ALTER TABLE clin_history.vwsocialhistory OWNER TO easygp;
GRANT ALL ON TABLE clin_history.vwsocialhistory TO easygp;
GRANT ALL ON TABLE clin_history.vwsocialhistory TO staff;
COMMENT ON VIEW clin_history.vwsocialhistory IS 'Seems odd.. ok. if fk_responsible_person is in our database
    we want the latest name/address, so person_responsible... fields get this 
    from contacts
    If fk_responsible_person is null/0 then we keep the responsible person
    address as given in a straight text field';


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 137);

