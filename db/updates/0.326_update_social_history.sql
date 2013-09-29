-- added some fields to allow confidentiality in social history and who can access them
Alter table clin_history.social_history add column do_not_print_confidential_notes boolean default True;
comment on column  clin_history.social_history.do_not_print_confidential_notes is
'if True (the default) then any confidential social history  is never printed on the patient health summary';
 -- update existing data
update clin_history.social_history set do_not_print_confidential_notes = True; 

Alter table clin_history.social_history add column fk_progressnote integer ;
comment on column clin_history.social_history.fk_progressnote is
'the default value should not be null, however for historical reasons I never 
 got around to putting in a social history progress note, now I need to so
 all the early ones will be 0';
  
update clin_history.social_history set fk_progressnote =0;
ALTER TABLE clin_history.social_history ALTER COLUMN fk_progressnote SET NOT NULL;

Alter table clin_history.social_history add column fk_progressnote_confidential integer default null;
comment on column clin_history.social_history.fk_progressnote_confidential is
'any progress notes for this social history item which are confidential';
update clin_history.social_history set fk_progressnote_confidential =null;

Alter table clin_history.social_history add column fk_staff_may_view_confidential integer default null;
comment on column  clin_history.social_history.fk_staff_may_view_confidential  is
'if not null then only the staff memember pointed to by this key may read the confidential history';

Alter table clin_history.social_history
ADD CONSTRAINT social_history_fk_staff_may_view_confidential_fkey FOREIGN KEY (fk_staff_may_view_confidential)
      REFERENCES admin.staff (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

alter table clin_history.social_history add column restrict_view_to_roles integer[] default null;
comment on column clin_history.social_history.restrict_view_to_roles is
'if not null then the confidential social history has role restrictions 
 the integer[] contains the admin.lu_staff_roles keys';

alter table clin_history.social_history add column history_confidential text default null;
comment on column clin_history.social_history.history_confidential is
'important social information history you would not want to let out in the wild
 for example sexual abuse, amphetamine use'; 
DROP VIEW clin_history.vwsocialhistory cascade;

CREATE OR REPLACE VIEW clin_history.vwsocialhistory AS 
 SELECT sh.pk AS pk_socialhistory, sh.fk_consult, consult.fk_patient, sh.history, 
 sh.deleted, sh.fk_responsible_person, sh.responsible_person, sh.responsible_person_street1, 
 sh.responsible_person_street2, sh.responsible_person_town, sh.responsible_person_state, 
 sh.responsible_person_postcode, sh.responsible_person_contacts, sh.country_code, 
 sh.do_not_print_confidential_notes, sh.fk_staff_may_view_confidential, sh.restrict_view_to_roles, sh.history_confidential,
 sh.fk_progressnote, fk_progressnote_confidential,
 lu_countries.country, sh.responsible_person_notes, vwpersonsincludingpatients.title AS person_responsible_title, 
 vwpersonsincludingpatients.firstname AS person_responsible_firstname, 
 vwpersonsincludingpatients.surname AS person_responsible_surname, 
 vwpersonsincludingpatients.wholename AS person_responsible_wholename, 
 vwpersonsincludingpatients.street1 AS person_responsible_street1, 
 vwpersonsincludingpatients.street2 AS person_responsible_street2, 
 vwpersonsincludingpatients.town AS person_responsible_town, 
 vwpersonsincludingpatients.postcode AS person_responsible_postcode, 
 vwpersonsincludingpatients.state AS person_responsible_state, 
 vwpersonsincludingpatients.fk_town AS patient_fk_town,
 vwStaff.wholename as staff_may_view_confidential_wholename
   FROM clin_history.social_history sh
   JOIN clin_consult.consult consult ON consult.pk = sh.fk_consult
   LEFT JOIN contacts.vwpersonsincludingpatients ON vwpersonsincludingpatients.fk_person = sh.fk_responsible_person
   LEFT JOIN common.lu_countries ON lu_countries.country_code::text = sh.country_code
   LEFT JOIN admin.vwStaff on vwStaff.fk_staff = sh.fk_staff_may_view_confidential
  WHERE sh.deleted = false;

ALTER TABLE clin_history.vwsocialhistory   OWNER TO easygp;
GRANT SELECT ON TABLE clin_history.vwsocialhistory TO staff;
COMMENT ON VIEW clin_history.vwsocialhistory
  IS 'Seems odd.. ok. if fk_responsible_person is in our database
    we want the latest name/address, so person_responsible... fields get this 
    from contacts
    If fk_responsible_person is null/0 then we keep the responsible person
    address as given in a straight text field
    Anyway, two types of social history:
    i)  The ordinary history which if made public is not of great consequence
    ii) The confidential history which if made public could be disasterous
        hence this is restricted by default to a role or to a fk_staff 
        if only the doctor entering the information gets to see this';


CREATE OR REPLACE VIEW clin_history.vwresponsiblepersons AS 
 SELECT vwpatients.surname, vwpatients.firstname, vwsocialhistory.responsible_person, 
 vwsocialhistory.fk_responsible_person, vwsocialhistory.person_responsible_wholename, 
 vwsocialhistory.history, vwpatients.active_status, vwpatients.age_numeric, vwpatients.deceased
   FROM clin_history.vwsocialhistory, contacts.vwpatients
  WHERE vwsocialhistory.fk_patient = vwpatients.fk_patient 
  AND vwpatients.age_numeric < 90::double precision 
  AND vwpatients.active_status = 'active'::text 
  AND vwpatients.deceased = false 
  AND vwpatients.person_deleted = false;

ALTER TABLE clin_history.vwresponsiblepersons   OWNER TO easygp;
GRANT SELECT ON TABLE clin_history.vwresponsiblepersons TO staff;
truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 326)
      
