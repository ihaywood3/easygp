-- Changes to Clin_referrals to accomodate hl7 sending and saving

create table clin_referrals.lu_urgency
(pk serial primary key,
 urgency text not null);
 
 insert into clin_referrals.lu_urgency (urgency) values ('Routine');
 insert into clin_referrals.lu_urgency (urgency) values ('Semi-Urgent');
 insert into clin_referrals.lu_urgency (urgency) values ('Urgent');

-- fix all existing referrals
 Alter table clin_referrals.referrals add column fk_lu_urgency integer default 1;
 
 
ALTER TABLE clin_referrals.lu_urgency   OWNER TO easygp;
GRANT ALL ON TABLE clin_referrals.lu_urgency TO easygp;
GRANT ALL ON TABLE clin_referrals.lu_urgency TO staff;


alter table clin_referrals.lu_type add column display boolean default True;

comment on column clin_referrals.lu_type.display is
'when true, the column will be available on the combo list in the referral''s gui';

-- make some name changes to the options for the combo in referrals as to type of referrals
-- update existing ones where necessary, 
update clin_referrals.lu_type set type='Reply to Referral' where pk = 4;
update clin_referrals.lu_type set type='Admission' where pk = 7;
update clin_referrals.lu_type set type='Recall or Reminder' where pk = 8;
update clin_referrals.lu_type set type='Non Medicare Related' where pk = 9;
delete from clin_referrals.lu_type where pk > 9;
update clin_referrals.referrals set fk_type = 9 where fk_type =13;
update clin_referrals.lu_type set display = false where pk = 8;

ALTER SEQUENCE "clin_referrals"."lu_type_pk_seq"
    INCREMENT 1  MINVALUE 1
    MAXVALUE 9223372036854775807  RESTART 10
    CACHE 1  NO CYCLE;

-- IAN you may care to comment on the comment
alter table clin_referrals.referrals add column letter_hl7 text default null;
Comment on column clin_referrals.referrals.letter_hl7 is
 ' the hl7 of the letter ** minus ** the inclusions OBX segments
   the hl7 file sent can be ''re-constituted'' by accessing the referrals.inclusions table';

-- add the new fields back into the view
DROP VIEW clin_referrals.vwreferrals;

CREATE OR REPLACE VIEW clin_referrals.vwreferrals AS 
        (         SELECT DISTINCT referrals.pk AS pk_referral, referrals.date_referral, referrals.fk_consult, 
        referrals.fk_person, referrals.fk_type, lu_type.type, referrals.tag, referrals.deleted, 
        referrals.body_html, referrals.letter_html, referrals.letter_hl7,
        referrals.fk_pasthistory, referrals.fk_progressnote, referrals.include_careplan, 
        referrals.include_healthsummary, referrals.fk_branch, referrals.fk_employee, referrals.fk_address, 
        referrals.copyto, referrals.fk_lu_urgency, lu_urgency.urgency,
        vworganisationsemployees.street1, vworganisationsemployees.street2, 
        vworganisationsemployees.town, vworganisationsemployees.state, vworganisationsemployees.postcode, 
        vworganisationsemployees.organisation, vworganisationsemployees.branch, vworganisationsemployees.wholename, 
        vworganisationsemployees.occupation, vworganisationsemployees.firstname, vworganisationsemployees.surname, 
        vworganisationsemployees.salutation, vworganisationsemployees.sex, vworganisationsemployees.title, 
        consult.consult_date, consult.fk_patient, consult.fk_staff, vwstaff.firstname AS staff_firstname, 
        vwstaff.wholename AS staff_wholename, vwstaff.salutation AS staff_salutation, vwstaff.title AS staff_title, 
        past_history.description, vworganisationsemployees.provider_number AS contact_provider_number
                   FROM clin_referrals.referrals
              JOIN contacts.vworganisationsemployees ON referrals.fk_employee = vworganisationsemployees.fk_employee AND referrals.fk_branch = vworganisationsemployees.fk_branch
         JOIN clin_consult.consult ON referrals.fk_consult = consult.pk
    JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   JOIN clin_referrals.lu_type ON referrals.fk_type = lu_type.pk
   LEFT JOIN clin_history.past_history ON referrals.fk_pasthistory = past_history.pk
   JOIN clin_referrals.lu_urgency ON referrals.fk_lu_urgency = lu_urgency.pk
       UNION 
                 SELECT DISTINCT referrals.pk AS pk_referral, referrals.date_referral, referrals.fk_consult, referrals.fk_person, 
                 referrals.fk_type, lu_type.type, referrals.tag, referrals.deleted, referrals.body_html, referrals.letter_html, referrals.letter_hl7,
                 referrals.fk_pasthistory, referrals.fk_progressnote, referrals.include_careplan, referrals.include_healthsummary, 
                 referrals.fk_branch, referrals.fk_employee, referrals.fk_address, referrals.copyto, referrals.fk_lu_urgency, lu_urgency.urgency,
                 vwpersonsincludingpatients.street1, 
                 vwpersonsincludingpatients.street2, vwpersonsincludingpatients.town, vwpersonsincludingpatients.state, 
                 vwpersonsincludingpatients.postcode, NULL::text AS organisation, NULL::text AS branch, vwpersonsincludingpatients.wholename, 
                 NULL::text AS occupation, vwpersonsincludingpatients.firstname, vwpersonsincludingpatients.surname, 
                 vwpersonsincludingpatients.salutation, vwpersonsincludingpatients.sex, vwpersonsincludingpatients.title, 
                 consult.consult_date, consult.fk_patient, consult.fk_staff, vwstaff.firstname AS staff_firstname, 
                 vwstaff.wholename AS staff_wholename, vwstaff.salutation AS staff_salutation, vwstaff.title AS staff_title, 
                 past_history.description, NULL::text AS contact_provider_number
                   FROM clin_referrals.referrals
              LEFT JOIN contacts.vwpersonsincludingpatients ON referrals.fk_person = vwpersonsincludingpatients.fk_person AND referrals.fk_address = vwpersonsincludingpatients.fk_address
         JOIN clin_consult.consult ON referrals.fk_consult = consult.pk
    JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   JOIN clin_referrals.lu_type ON referrals.fk_type = lu_type.pk
   LEFT JOIN clin_history.past_history ON referrals.fk_pasthistory = past_history.pk
   JOIN clin_referrals.lu_urgency ON referrals.fk_lu_urgency = lu_urgency.pk
  WHERE referrals.fk_branch IS NULL AND referrals.fk_employee IS NULL)
UNION 
         SELECT DISTINCT referrals.pk AS pk_referral, referrals.date_referral, referrals.fk_consult, referrals.fk_person, referrals.fk_type, 
         lu_type.type, referrals.tag, referrals.deleted, referrals.body_html, referrals.letter_html, referrals.letter_hl7, referrals.fk_pasthistory, 
         referrals.fk_progressnote, referrals.include_careplan, referrals.include_healthsummary, referrals.fk_branch, referrals.fk_employee, 
         referrals.fk_address, referrals.copyto, referrals.fk_lu_urgency, lu_urgency.urgency,
         vworganisationsemployees.street1, vworganisationsemployees.street2, 
         vworganisationsemployees.town, vworganisationsemployees.state, vworganisationsemployees.postcode, 
         vworganisationsemployees.organisation, vworganisationsemployees.branch, NULL::text AS wholename, 
         NULL::text AS occupation, NULL::text AS firstname, NULL::text AS surname, NULL::text AS salutation, NULL::text AS sex, 
         NULL::text AS title, consult.consult_date, consult.fk_patient, consult.fk_staff, vwstaff.firstname AS staff_firstname, 
         vwstaff.wholename AS staff_wholename, vwstaff.salutation AS staff_salutation, vwstaff.title AS staff_title, past_history.description, 
         NULL::text AS contact_provider_number
           FROM clin_referrals.referrals
      JOIN contacts.vworganisationsemployees ON referrals.fk_branch = vworganisationsemployees.fk_branch
   JOIN clin_consult.consult ON referrals.fk_consult = consult.pk
   JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   JOIN clin_referrals.lu_type ON referrals.fk_type = lu_type.pk
   JOIN clin_referrals.lu_urgency ON referrals.fk_lu_urgency = lu_urgency.pk
   LEFT JOIN clin_history.past_history ON referrals.fk_pasthistory = past_history.pk
  WHERE referrals.fk_person IS NULL;

ALTER TABLE clin_referrals.vwreferrals   OWNER TO easygp;
GRANT ALL ON TABLE clin_referrals.vwreferrals TO easygp;
GRANT ALL ON TABLE clin_referrals.vwreferrals TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 232);

