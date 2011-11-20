alter  TABLE clin_history.social_history drop column country_code;
alter  TABLE clin_history.social_history add column country_code text default null;


-- was dropped by previous update DROP VIEW clin_history.vwsocialhistory;

CREATE OR REPLACE VIEW clin_history.vwsocialhistory AS 
 SELECT sh.pk AS pk_socialhistory, sh.fk_consult, consult.fk_patient, sh.history, sh.deleted, 
 sh.fk_responsible_person, sh.responsible_person, sh.responsible_person_street1, sh.responsible_person_street2, 
 sh.responsible_person_town, sh.responsible_person_state, sh.responsible_person_postcode, sh.responsible_person_contacts, 
 sh.country_code, lu_countries.country, sh.responsible_person_notes, 
 vwpersonsincludingpatients.title AS person_responsible_title, 
 vwpersonsincludingpatients.firstname AS person_responsible_firstname, 
 vwpersonsincludingpatients.surname AS person_responsible_surname, vwpersonsincludingpatients.wholename AS person_responsible_wholename, 
 vwpersonsincludingpatients.street1 AS person_responsible_street1, vwpersonsincludingpatients.street2 AS person_responsible_street2,
 vwpersonsincludingpatients.town AS person_responsible_town, vwpersonsincludingpatients.postcode AS person_responsible_postcode,
 vwpersonsincludingpatients.state AS person_responsible_state, vwpersonsincludingpatients.fk_town AS patient_fk_town
   FROM clin_history.social_history sh
   JOIN clin_consult.consult consult ON consult.pk = sh.fk_consult
   LEFT JOIN contacts.vwpersonsincludingpatients ON vwpersonsincludingpatients.fk_person = sh.fk_responsible_person
   LEFT JOIN common.lu_countries ON lu_countries.country_code = sh.country_code
  WHERE sh.deleted = false;

ALTER TABLE clin_history.vwsocialhistory OWNER TO easygp;
GRANT ALL ON TABLE clin_history.vwsocialhistory TO easygp;
GRANT ALL ON TABLE clin_history.vwsocialhistory TO staff;

comment on view clin_history.vwsocialhistory
is 'Seems odd.. ok. if fk_responsible_person is in our database
    we want the latest name/address, so person_responsible... fields get this 
    from contacts
    If fk_responsible_person is null/0 then we keep the responsible person
    address as given in a straight text field';
    
truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 139);

