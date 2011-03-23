-- oops, at least on my machine, I've screwed the lu_type sequence so here's a fix:

ALTER SEQUENCE "clin_referrals"."lu_type_pk_seq"
    INCREMENT 1  MINVALUE 1
    MAXVALUE 9223372036854775807  RESTART 13
    CACHE 1  NO CYCLE;

-- new referral type to take care of all letters not to specialists etc.

insert into clin_referrals.lu_type (type) values ('Non Medicare');


-- added another query to the view to include letters to organisatios with no employees
-- view now will pull out
	--letter to an organisation
	--letter to an employee in an organisation
	--letter to a person not in an organisation

DROP VIEW clin_referrals.vwreferrals;

CREATE OR REPLACE VIEW clin_referrals.vwreferrals AS 
        (         SELECT DISTINCT referrals.pk AS pk_referral, referrals.date_referral, referrals.fk_consult, 
        referrals.fk_person, referrals.fk_type, lu_type.type, referrals.letter_html, referrals.tag, referrals.deleted, 
        referrals.body_html, referrals.fk_pasthistory, referrals.fk_progressnote, referrals.include_careplan, 
        referrals.include_healthsummary, referrals.fk_branch, referrals.fk_employee, referrals.fk_address, referrals.copyto, 
        vworganisationsemployees.street,  vworganisationsemployees.town, 
        vworganisationsemployees.state, vworganisationsemployees.postcode,vworganisationsemployees.organisation, vworganisationsemployees.branch, 
        vworganisationsemployees.wholename, vworganisationsemployees.occupation, vworganisationsemployees.firstname, 
        vworganisationsemployees.surname, vworganisationsemployees.salutation, vworganisationsemployees.sex, 
        vworganisationsemployees.title, consult.consult_date, consult.fk_patient, consult.fk_staff, 
        vwstaff.provider_number, vwstaff.firstname AS staff_firstname, vwstaff.wholename AS staff_wholename,
        vwstaff.salutation AS staff_salutation, vwstaff.title AS staff_title, past_history.description
                   FROM clin_referrals.referrals
              JOIN contacts.vworganisationsemployees ON referrals.fk_employee = vworganisationsemployees.fk_employee AND referrals.fk_branch = vworganisationsemployees.fk_branch
         JOIN clin_consult.consult ON referrals.fk_consult = consult.pk
    JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   JOIN clin_referrals.lu_type ON referrals.fk_type = lu_type.pk
   LEFT JOIN clin_history.past_history ON referrals.fk_pasthistory = past_history.pk
        UNION 

            SELECT DISTINCT referrals.pk AS pk_referral, referrals.date_referral, 
                referrals.fk_consult, referrals.fk_person, referrals.fk_type, lu_type.type, referrals.letter_html, 
                referrals.tag, referrals.deleted, referrals.body_html,
                 referrals.fk_pasthistory, referrals.fk_progressnote, referrals.include_careplan, 
                 referrals.include_healthsummary, referrals.fk_branch, referrals.fk_employee, 
                 referrals.fk_address, referrals.copyto, vwpersonsincludingpatients.street,
                 vwpersonsincludingpatients.town AS town, vwpersonsincludingpatients.state AS state, vwpersonsincludingpatients.postcode AS postcode, NULL::text AS organisation, NULL::text AS branch, vwpersonsincludingpatients.wholename, NULL::text AS occupation, vwpersonsincludingpatients.firstname, vwpersonsincludingpatients.surname, vwpersonsincludingpatients.salutation, vwpersonsincludingpatients.sex, vwpersonsincludingpatients.title, consult.consult_date, consult.fk_patient, consult.fk_staff, vwstaff.provider_number, vwstaff.firstname AS staff_firstname, vwstaff.wholename AS staff_wholename, vwstaff.salutation AS staff_salutation, vwstaff.title AS staff_title, past_history.description
                   FROM clin_referrals.referrals
              LEFT JOIN contacts.vwpersonsincludingpatients ON referrals.fk_person = vwpersonsincludingpatients.fk_person AND referrals.fk_address = vwpersonsincludingpatients.fk_address
         JOIN clin_consult.consult ON referrals.fk_consult = consult.pk
    JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   JOIN clin_referrals.lu_type ON referrals.fk_type = lu_type.pk
   LEFT JOIN clin_history.past_history ON referrals.fk_pasthistory = past_history.pk
  WHERE referrals.fk_branch IS NULL AND referrals.fk_employee IS NULL


 UNION 
         SELECT DISTINCT referrals.pk AS pk_referral, referrals.date_referral, referrals.fk_consult, referrals.fk_person, 
         referrals.fk_type, lu_type.type, referrals.letter_html, referrals.tag, referrals.deleted, referrals.body_html, 
         referrals.fk_pasthistory, referrals.fk_progressnote, referrals.include_careplan, 
         referrals.include_healthsummary, referrals.fk_branch, referrals.fk_employee, referrals.fk_address, 
         referrals.copyto, 
         vworganisationsemployees.street,vworganisationsemployees.town, vworganisationsemployees.state, vworganisationsemployees.postcode,  vworganisationsemployees.organisation, vworganisationsemployees.branch, NULL::text AS wholename, NULL::text AS occupation, NULL::text AS firstname, NULL::text AS surname, NULL::text AS salutation, NULL::text AS sex, NULL::text AS title, consult.consult_date, consult.fk_patient, consult.fk_staff, vwstaff.provider_number, vwstaff.firstname AS staff_firstname, vwstaff.wholename AS staff_wholename, vwstaff.salutation AS staff_salutation, vwstaff.title AS staff_title, past_history.description
           FROM clin_referrals.referrals
      JOIN contacts.vworganisationsemployees ON referrals.fk_branch = vworganisationsemployees.fk_branch
   JOIN clin_consult.consult ON referrals.fk_consult = consult.pk
   JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   JOIN clin_referrals.lu_type ON referrals.fk_type = lu_type.pk
   LEFT JOIN clin_history.past_history ON referrals.fk_pasthistory = past_history.pk
  WHERE referrals.fk_person IS NULL)
  ORDER BY 32, 2;

ALTER TABLE clin_referrals.vwreferrals OWNER TO easygp;
GRANT ALL ON TABLE clin_referrals.vwreferrals TO easygp;
GRANT ALL ON TABLE clin_referrals.vwreferrals TO staff;
COMMENT ON VIEW clin_referrals.vwreferrals IS 'A view of referral letters written, includes also for example recall letters sent to patient, letters to non-medical providers e.g insurance companies
 FIXME: need to fix contacts.vwPersonsIncludingPatients to include occupation 
 Not that the the view uses contacts.vwpersonsincludingpatient.
 The view also **DOES NOT** exclude retired or left organisation employees, as once written the letter is written.
';



truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 86)

