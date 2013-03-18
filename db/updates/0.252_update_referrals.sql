-- To allow editing of referral letters on future days
-- Feature for Ian who may write a letter back to referrer but need to complete it not on the day

Alter table clin_referrals.referrals add column finalised boolean default false;

Comment on column clin_referrals.referrals.finalised is 'if true the letter has been partly written but not sent either by hl7 or printed';

update clin_referrals.referrals set finalised = true;

DROP VIEW clin_referrals.vwreferrals;

CREATE OR REPLACE VIEW clin_referrals.vwreferrals AS 
        (         SELECT DISTINCT referrals.pk AS pk_referral, referrals.date_referral, referrals.fk_consult, 
        referrals.fk_person, referrals.fk_type, lu_type.type, referrals.tag, referrals.deleted, referrals.body_html, 
        referrals.letter_html, referrals.letter_hl7, referrals.fk_pasthistory, referrals.fk_progressnote, 
        referrals.include_careplan, referrals.include_healthsummary, referrals.fk_branch, 
        referrals.fk_employee, referrals.fk_address, referrals.copyto, referrals.fk_lu_urgency, referrals.finalised, lu_urgency.urgency, 
        vworganisationsemployees.street1, vworganisationsemployees.street2, vworganisationsemployees.town, vworganisationsemployees.state, vworganisationsemployees.postcode, vworganisationsemployees.organisation, vworganisationsemployees.branch, vworganisationsemployees.wholename, vworganisationsemployees.occupation, vworganisationsemployees.firstname, vworganisationsemployees.surname, vworganisationsemployees.salutation, vworganisationsemployees.sex, vworganisationsemployees.title, consult.consult_date, consult.fk_patient, consult.fk_staff, vwstaff.firstname AS staff_firstname, vwstaff.wholename AS staff_wholename, vwstaff.salutation AS staff_salutation, vwstaff.title AS staff_title, past_history.description, vworganisationsemployees.provider_number AS contact_provider_number
                   FROM clin_referrals.referrals
              JOIN contacts.vworganisationsemployees ON referrals.fk_employee = vworganisationsemployees.fk_employee AND referrals.fk_branch = vworganisationsemployees.fk_branch
         JOIN clin_consult.consult ON referrals.fk_consult = consult.pk
    JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   JOIN clin_referrals.lu_type ON referrals.fk_type = lu_type.pk
   LEFT JOIN clin_history.past_history ON referrals.fk_pasthistory = past_history.pk
   JOIN clin_referrals.lu_urgency ON referrals.fk_lu_urgency = lu_urgency.pk
        UNION 
                 SELECT DISTINCT referrals.pk AS pk_referral, referrals.date_referral, referrals.fk_consult, 
                 referrals.fk_person, referrals.fk_type, lu_type.type, referrals.tag, referrals.deleted, referrals.body_html, 
                 referrals.letter_html, referrals.letter_hl7, referrals.fk_pasthistory, referrals.fk_progressnote, 
                 referrals.include_careplan, referrals.include_healthsummary, referrals.fk_branch, 
                 referrals.fk_employee, referrals.fk_address, referrals.copyto, referrals.fk_lu_urgency, referrals.finalised,
                 lu_urgency.urgency, vwpersonsincludingpatients.street1, vwpersonsincludingpatients.street2, vwpersonsincludingpatients.town, vwpersonsincludingpatients.state, vwpersonsincludingpatients.postcode, NULL::text AS organisation, NULL::text AS branch, vwpersonsincludingpatients.wholename, NULL::text AS occupation, vwpersonsincludingpatients.firstname, vwpersonsincludingpatients.surname, vwpersonsincludingpatients.salutation, vwpersonsincludingpatients.sex, vwpersonsincludingpatients.title, consult.consult_date, consult.fk_patient, consult.fk_staff, vwstaff.firstname AS staff_firstname, vwstaff.wholename AS staff_wholename, vwstaff.salutation AS staff_salutation, vwstaff.title AS staff_title, past_history.description, NULL::text AS contact_provider_number
                   FROM clin_referrals.referrals
              LEFT JOIN contacts.vwpersonsincludingpatients ON referrals.fk_person = vwpersonsincludingpatients.fk_person AND referrals.fk_address = vwpersonsincludingpatients.fk_address
         JOIN clin_consult.consult ON referrals.fk_consult = consult.pk
    JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   JOIN clin_referrals.lu_type ON referrals.fk_type = lu_type.pk
   LEFT JOIN clin_history.past_history ON referrals.fk_pasthistory = past_history.pk
   JOIN clin_referrals.lu_urgency ON referrals.fk_lu_urgency = lu_urgency.pk
  WHERE referrals.fk_branch IS NULL AND referrals.fk_employee IS NULL)
UNION 
         SELECT DISTINCT referrals.pk AS pk_referral, referrals.date_referral, referrals.fk_consult, referrals.fk_person, 
         referrals.fk_type, lu_type.type, referrals.tag, referrals.deleted, referrals.body_html, referrals.letter_html, 
         referrals.letter_hl7, referrals.fk_pasthistory, referrals.fk_progressnote, referrals.include_careplan, 
         referrals.include_healthsummary, referrals.fk_branch, referrals.fk_employee, referrals.fk_address, 
         referrals.copyto, referrals.fk_lu_urgency, referrals.finalised, lu_urgency.urgency, 
         vworganisationsemployees.street1, vworganisationsemployees.street2, vworganisationsemployees.town, vworganisationsemployees.state, vworganisationsemployees.postcode, vworganisationsemployees.organisation, vworganisationsemployees.branch, NULL::text AS wholename, NULL::text AS occupation, NULL::text AS firstname, NULL::text AS surname, NULL::text AS salutation, NULL::text AS sex, NULL::text AS title, consult.consult_date, consult.fk_patient, consult.fk_staff, vwstaff.firstname AS staff_firstname, vwstaff.wholename AS staff_wholename, vwstaff.salutation AS staff_salutation, vwstaff.title AS staff_title, past_history.description, NULL::text AS contact_provider_number
           FROM clin_referrals.referrals
      JOIN contacts.vworganisationsemployees ON referrals.fk_branch = vworganisationsemployees.fk_branch
   JOIN clin_consult.consult ON referrals.fk_consult = consult.pk
   JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   JOIN clin_referrals.lu_type ON referrals.fk_type = lu_type.pk
   JOIN clin_referrals.lu_urgency ON referrals.fk_lu_urgency = lu_urgency.pk
   LEFT JOIN clin_history.past_history ON referrals.fk_pasthistory = past_history.pk
  WHERE referrals.fk_person IS NULL;

ALTER TABLE clin_referrals.vwreferrals OWNER TO easygp;
GRANT ALL ON TABLE clin_referrals.vwreferrals TO easygp;
GRANT ALL ON TABLE clin_referrals.vwreferrals TO staff;



truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 252);

