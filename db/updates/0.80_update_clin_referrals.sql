-- drop schema and all its tables and views.
drop schema clin_referrals cascade;



Create schema clin_referrals;
GRANT ALL ON SCHEMA clin_referrals TO easygp;
GRANT USAGE ON SCHEMA clin_referrals TO staff;

COMMENT ON SCHEMA clin_referrals IS 'Contains all referral letters written';

SET search_path = clin_referrals, pg_catalog;


CREATE TABLE lu_type (
    pk serial primary key,
    type text NOT NULL
);

ALTER TABLE clin_referrals.lu_type OWNER TO easygp;
GRANT ALL ON TABLE clin_referrals.lu_type TO easygp;
GRANT SELECT ON TABLE clin_referrals.lu_type TO staff;

COMMENT ON TABLE lu_type IS
 'List of types of referral eg required by medicare so could be
  opinion
  ongoing management
  indefinate referral etc';

INSERT INTO lu_type (pk, type) VALUES (1, 'Opinion');
INSERT INTO lu_type (pk, type) VALUES (2, 'Opinion and Management');
INSERT INTO lu_type (pk, type) VALUES (4, 'Feedback');
INSERT INTO lu_type (pk, type) VALUES (5, 'Indefinate Referral');
INSERT INTO lu_type (pk, type) VALUES (6, 'Immediate Treatment');
INSERT INTO lu_type (pk, type) VALUES (7, 'Education');
INSERT INTO lu_type (pk, type) VALUES (8, 'Admission');
INSERT INTO lu_type (pk, type) VALUES (3, 'Request for investigation');
INSERT INTO lu_type (pk, type) VALUES (9, 'Management');
INSERT INTO lu_type (pk, type) VALUES (10, 'Recall or Reminder');
INSERT INTO lu_type (pk, type) VALUES (11, 'Imported Letter');
INSERT INTO lu_type (pk, type) VALUES (12, 'Recall or Reminder Imported');


CREATE TABLE clin_referrals.referrals
(
  pk serial primary key,
  fk_consult integer NOT NULL,
  date_referral date NOT NULL, 
  fk_branch integer,
  fk_employee integer,
  fk_person integer, 
  fk_address integer,
  fk_type integer, 
  letter_html text NOT NULL, 
  tag text, 
  deleted boolean DEFAULT false,
  body_html text, 
  fk_pasthistory integer DEFAULT 0, 
  fk_progressnote integer, 
  include_careplan boolean DEFAULT false,
  include_healthsummary boolean DEFAULT false,
  copyto text );


ALTER TABLE clin_referrals.referrals OWNER TO easygp;
GRANT ALL ON TABLE clin_referrals.referrals TO easygp;
GRANT ALL ON TABLE clin_referrals.referrals TO staff;

COMMENT ON TABLE clin_referrals.referrals IS 'data of all referrals. Note that I kept all my referral as shredded down rich text files outside of the database so this table will probably change.';
COMMENT ON COLUMN clin_referrals.referrals.fk_branch is 'if not null key to contacts.data_branches - points to organisation and address of the organisation';
COMMENT ON COLUMN clin_referrals.referrals.fk_employee is 'if not null key to contacts.data_employees table - points to employee of an organisation';
COMMENT ON COLUMN clin_referrals.referrals.fk_consult IS 'key to the main clin_consult.consult table which is the master table of the database';
COMMENT ON COLUMN clin_referrals.referrals.fk_address is 'key to contacts.data_addresses, if not null is the address of the person. not the address of the organisation/branch/employee obtained through the other keys';
COMMENT ON COLUMN clin_referrals.referrals.fk_person IS 'if not null key to contacts.data_persons table ie person referred to';
COMMENT ON COLUMN clin_referrals.referrals.fk_type IS 'key to lu_referral_type table ie type of referral e.g opinion or management';
COMMENT ON COLUMN clin_referrals.referrals.letter_html IS 'html which is the letter itself';
COMMENT ON COLUMN clin_referrals.referrals.tag IS 'A description of the letter eg ''heart failure''';
COMMENT ON COLUMN clin_referrals.referrals.body_html IS 'Contains the html of the body of the letter';
COMMENT ON COLUMN clin_referrals.referrals.fk_pasthistory IS 'if not 0 = general notes, then is the key to clin_history.past_history table';
COMMENT ON COLUMN clin_referrals.referrals.fk_progressnote IS 
'key to clin_consult.progress notes table - points to the progress note of a letter during the
 consultation it was written in - used for editing/auditing';
COMMENT ON COLUMN clin_referrals.referrals.date_referral IS 'Date written on the referral, may not be the consult_date';
COMMENT ON COLUMN clin_referrals.referrals.copyto IS 'a Pipe delimated list of entities receiving copies
 e.g Mr Joe Blogs
     John Hunter hospital, Lookout Rd New Lambton Heights
     any free text or constructed text is acceptable';


CREATE OR REPLACE VIEW clin_referrals.vwreferrals AS 
         SELECT DISTINCT referrals.pk AS pk_referral, referrals.date_referral, referrals.fk_consult, referrals.fk_person, referrals.fk_type, lu_type.type,
	  referrals.letter_html, referrals.tag, referrals.deleted, referrals.body_html, referrals.fk_pasthistory, referrals.fk_progressnote, referrals.include_careplan, referrals.include_healthsummary, referrals.fk_branch, referrals.fk_employee, referrals.fk_address, referrals.copyto, vworganisationsemployees.street, vworganisationsemployees.postcode, vworganisationsemployees.town, vworganisationsemployees.state, vworganisationsemployees.organisation, vworganisationsemployees.branch, vworganisationsemployees.wholename, vworganisationsemployees.occupation, vworganisationsemployees.firstname, vworganisationsemployees.surname, vworganisationsemployees.salutation, vworganisationsemployees.sex, vworganisationsemployees.title, consult.consult_date, consult.fk_patient, consult.fk_staff, vwstaff.provider_number, vwstaff.firstname AS staff_firstname, vwstaff.wholename AS staff_wholename, vwstaff.salutation AS staff_salutation, vwstaff.title AS staff_title, past_history.description
           FROM clin_referrals.referrals
      JOIN contacts.vworganisationsemployees ON referrals.fk_employee = vworganisationsemployees.fk_employee AND referrals.fk_branch = vworganisationsemployees.fk_branch
   JOIN clin_consult.consult ON referrals.fk_consult = consult.pk
   JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   JOIN clin_referrals.lu_type on referrals.fk_type = lu_type.pk
   LEFT JOIN clin_history.past_history ON referrals.fk_pasthistory = past_history.pk
UNION 
         SELECT DISTINCT referrals.pk AS pk_referral, referrals.date_referral, referrals.fk_consult, referrals.fk_person, referrals.fk_type, lu_type.type,
	  referrals.letter_html, referrals.tag, referrals.deleted, referrals.body_html, referrals.fk_pasthistory, referrals.fk_progressnote, referrals.include_careplan, referrals.include_healthsummary, referrals.fk_branch, referrals.fk_employee, referrals.fk_address, referrals.copyto, vwpersonsincludingpatients.street, vwpersonsincludingpatients.town AS postcode, vwpersonsincludingpatients.state AS town, vwpersonsincludingpatients.postcode AS state, NULL::text AS organisation, NULL::text AS branch, vwpersonsincludingpatients.wholename, NULL::text AS occupation, vwpersonsincludingpatients.firstname, vwpersonsincludingpatients.surname, vwpersonsincludingpatients.salutation, vwpersonsincludingpatients.sex, vwpersonsincludingpatients.title, consult.consult_date, consult.fk_patient, consult.fk_staff, vwstaff.provider_number, vwstaff.firstname AS staff_firstname, vwstaff.wholename AS staff_wholename, vwstaff.salutation AS staff_salutation, vwstaff.title AS staff_title, past_history.description
           FROM clin_referrals.referrals
      LEFT JOIN contacts.vwpersonsincludingpatients ON referrals.fk_person = vwpersonsincludingpatients.fk_person AND referrals.fk_address = vwpersonsincludingpatients.fk_address
   JOIN clin_consult.consult ON referrals.fk_consult = consult.pk
   JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   JOIN clin_referrals.lu_type on referrals.fk_type = lu_type.pk
   LEFT JOIN clin_history.past_history ON referrals.fk_pasthistory = past_history.pk
  WHERE referrals.fk_branch IS NULL AND referrals.fk_employee IS NULL
  ORDER BY 32, 2;

ALTER TABLE clin_referrals.vwreferrals OWNER TO easygp;
GRANT ALL ON TABLE clin_referrals.vwreferrals TO easygp;
GRANT ALL ON TABLE clin_referrals.vwreferrals TO staff;
COMMENT ON VIEW clin_referrals.vwreferrals IS 
'A view of referral letters written, includes also for example recall letters sent to patient, letters to non-medical providers e.g insurance companies
 FIXME: need to fix contacts.vwPersonsIncludingPatients to include occupation 
 Not that the the view uses contacts.vwpersonsincludingpatient.
 The view also **DOES NOT** exclude retired or left organisation employees, as once written the letter is written.
';

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 80);


