-- adds carers fields to the social_history table, fixes up the view.
-- removes country_code field and uses the pk of common.lu_countries;
-- changes all in the datbaase to 'AU''s primary key
-- note the contacts database has a bad design flaw uses the text of the country code, not the primary key
-- view clin_history.vwresponsible persons depends on view clin_history.vwsocialhistory (not used any more?, anyway its trashed now!)
alter table  clin_history.social_history drop column  country_code cascade ;  --- drops all associate views
alter table clin_history.social_history add column country_code_responsible_person text default null;
update clin_history.social_history set country_code_responsible_person = 'AU' where fk_responsible_person is null and responsible_person is not null;
alter table clin_history.social_history rename column responsible_person  to responsible_person_wholename;

ALTER TABLE clin_history.social_history add column fk_carer integer default NULL references contacts.data_persons (pk);
ALTER TABLE clin_history.social_history add column carer_wholename text default NULL;
ALTER TABLE clin_history.social_history add column carer_street1 text  default NULL;
ALTER TABLE clin_history.social_history add column carer_street2 text  default NULL;
ALTER TABLE clin_history.social_history add column carer_town text  default NULL;
ALTER TABLE clin_history.social_history add column carer_postcode text default NULL;
ALTER TABLE clin_history.social_history add column carer_state text default NULL;
ALTER TABLE clin_history.social_history add column carer_contacts text  default NULL;
ALTER TABLE clin_history.social_history add column carer_notes text  default NULL;
ALTER TABLE clin_history.social_history add column country_code_carer text default null; -- references common.lu_countries (country_code);

COMMENT ON COLUMN clin_history.social_history.fk_carer IS 
  'if not null this is the key to  contacts.data_persons table and points to the person who is the official carer (may not be a family member)';
  
COMMENT ON COLUMN  clin_history.social_history.fk_responsible_person is 
'if not null this is the key to  contacts.data_persons table is either the next of kin or the person legally responsible for the patient';


CREATE OR REPLACE VIEW clin_history.vwsocialhistory AS 
 SELECT sh.pk AS pk_socialhistory,
    sh.fk_consult,
    consult.fk_patient,
    sh.history,
    sh.deleted,
    sh.fk_responsible_person,
	CASE WHEN sh.fk_responsible_person is null THEN  sh.responsible_person_wholename else  vwpersonsincludingpatients.wholename END AS person_responsible_wholename,
	CASE WHEN sh.fk_responsible_person is null THEN  sh.responsible_person_street1 else vwpersonsincludingpatients.street1 END AS person_responsible_street1,
	CASE WHEN sh.fk_responsible_person is null THEN  sh.responsible_person_street2 else vwpersonsincludingpatients.street2 END AS person_responsible_street2,	
	CASE WHEN sh.fk_responsible_person is null THEN  sh.responsible_person_town else vwpersonsincludingpatients.town END AS person_responsible_town,
	CASE WHEN sh.fk_responsible_person is null THEN  sh.responsible_person_state else vwpersonsincludingpatients.state END AS person_responsible_state,	
	CASE WHEN sh.fk_responsible_person is null THEN  sh.responsible_person_postcode else vwpersonsincludingpatients.postcode END AS person_responsible_postcode,	
	CASE WHEN sh.fk_responsible_person is null THEN  sh.responsible_person_contacts else Null END as person_responsible_contacts,
	CASE WHEN sh.fk_responsible_person is null THEN  sh.country_code_responsible_person else vwpersonsincludingpatients.country_code End as  person_responsible_country_code,
    sh.fk_carer,
	CASE WHEN sh.fk_carer is null THEN  sh.carer_wholename else  vwpersonsincludingpatients_carer.wholename END AS carer_wholename,
	CASE WHEN sh.fk_carer is null THEN  sh.carer_street1 else vwpersonsincludingpatients_carer.street1 END AS carer_street1,
	CASE WHEN sh.fk_carer is null THEN  sh.carer_street2 else vwpersonsincludingpatients_carer.street2 END AS carer_street2,	
	CASE WHEN sh.fk_carer is null THEN  sh.carer_town else vwpersonsincludingpatients_carer.town END AS carer_town,
	CASE WHEN sh.fk_carer is null THEN  sh.carer_state else vwpersonsincludingpatients_carer.state END AS carer_state,	
	CASE WHEN sh.fk_carer is null THEN  sh.carer_postcode else vwpersonsincludingpatients_carer.postcode END AS carer_postcode,	
	CASE WHEN sh.fk_carer is null THEN  sh.carer_contacts else Null END as carer_contacts,
	CASE WHEN sh.fk_carer is null THEN  sh.country_code_carer else vwpersonsincludingpatients_carer.country_code End as  carer_country_code,
    sh.do_not_print_confidential_notes,
    sh.fk_staff_may_view_confidential,
    sh.restrict_view_to_roles, 
    sh.history_confidential,
    sh.fk_progressnote,
    sh.fk_progressnote_confidential,
    lu_countries.country as person_responsible_country,
    lu_countries_carer.country as carer_country,
    sh.responsible_person_notes,
    sh.carer_notes,
    vwstaff.wholename AS staff_may_view_confidential_wholename
   FROM clin_history.social_history sh
     JOIN clin_consult.consult consult ON consult.pk = sh.fk_consult
     LEFT JOIN contacts.vwpersonsincludingpatients ON vwpersonsincludingpatients.fk_person = sh.fk_responsible_person
     LEFT JOIN contacts.vwpersonsincludingpatients vwpersonsincludingpatients_carer ON vwpersonsincludingpatients_carer.fk_person = sh.fk_carer
     LEFT JOIN common.lu_countries ON lu_countries.country_code::text = sh.country_code_responsible_person
     LEFT JOIN common.lu_countries lu_countries_carer ON lu_countries_carer.country_code::text = sh.country_code_carer
     LEFT JOIN admin.vwstaff ON vwstaff.fk_staff = sh.fk_staff_may_view_confidential;
  
ALTER TABLE clin_history.vwsocialhistory   OWNER TO easygp;
GRANT SELECT ON TABLE clin_history.vwsocialhistory TO staff;

COMMENT ON VIEW clin_history.vwsocialhistory
  IS 'Seems odd.. ok. if fk_responsible_person is in our database
    we want the latest name/address, so person_responsible... fields get this 
    from contacts
    If fk_responsible_person is null then we keep the responsible person
    address as given in a straight text field
    Anyway, two types of social history:
    i)  The ordinary history which if made public is not of great consequence
    ii) The confidential history which if made public could be disasterous
        hence this is restricted by default to a role or to a fk_staff 
        if only the doctor entering the information gets to see this';
        
update db.lu_version set lu_minor = 473;