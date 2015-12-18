-- removed previous linkage to past history and rebuild view

alter table clin_referrals.referrals drop column fk_pasthistory cascade;

CREATE OR REPLACE VIEW clin_referrals.vwreferrals AS 
 SELECT DISTINCT referrals.pk AS pk_referral,
    referrals.date_referral,
    referrals.fk_consult,
    referrals.fk_person,
    referrals.fk_type,
    lu_type.type,
    referrals.tag,
    referrals.deleted,
    referrals.body_html,
    referrals.letter_html,
    referrals.letter_hl7,
    referrals.fk_progressnote,
    referrals.include_careplan,
    referrals.include_healthsummary,
    referrals.fk_branch,
    referrals.fk_employee,
    referrals.fk_address,
    referrals.copyto,
    referrals.fk_lu_urgency,
    referrals.finalised,
    lu_urgency.urgency,
    vworganisationsemployees.street1,
    vworganisationsemployees.street2,
    vworganisationsemployees.town,
    vworganisationsemployees.state,
    vworganisationsemployees.postcode,
    vworganisationsemployees.organisation,
    vworganisationsemployees.branch,
    vworganisationsemployees.wholename,
    vworganisationsemployees.occupation,
    vworganisationsemployees.firstname,
    vworganisationsemployees.surname,
    vworganisationsemployees.salutation,
    vworganisationsemployees.sex,
    vworganisationsemployees.title,
    consult.consult_date,
    consult.fk_patient,
    consult.fk_staff,
    vwstaff.firstname AS staff_firstname,
    vwstaff.wholename AS staff_wholename,
    vwstaff.salutation AS staff_salutation,
    vwstaff.title AS staff_title,
    vworganisationsemployees.provider_number AS contact_provider_number
   FROM clin_referrals.referrals
     JOIN contacts.vworganisationsemployees ON referrals.fk_employee = vworganisationsemployees.fk_employee AND referrals.fk_branch = vworganisationsemployees.fk_branch
     JOIN clin_consult.consult ON referrals.fk_consult = consult.pk
     JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
     JOIN clin_referrals.lu_type ON referrals.fk_type = lu_type.pk
      JOIN clin_referrals.lu_urgency ON referrals.fk_lu_urgency = lu_urgency.pk
UNION
 SELECT DISTINCT referrals.pk AS pk_referral,
    referrals.date_referral,
    referrals.fk_consult,
    referrals.fk_person,
    referrals.fk_type,
    lu_type.type,
    referrals.tag,
    referrals.deleted,
    referrals.body_html,
    referrals.letter_html,
    referrals.letter_hl7,
    referrals.fk_progressnote,
    referrals.include_careplan,
    referrals.include_healthsummary,
    referrals.fk_branch,
    referrals.fk_employee,
    referrals.fk_address,
    referrals.copyto,
    referrals.fk_lu_urgency,
    referrals.finalised,
    lu_urgency.urgency,
    vwpersonsincludingpatients.street1,
    vwpersonsincludingpatients.street2,
    vwpersonsincludingpatients.town,
    vwpersonsincludingpatients.state,
    vwpersonsincludingpatients.postcode,
    NULL::text AS organisation,
    NULL::text AS branch,
    vwpersonsincludingpatients.wholename,
    NULL::text AS occupation,
    vwpersonsincludingpatients.firstname,
    vwpersonsincludingpatients.surname,
    vwpersonsincludingpatients.salutation,
    vwpersonsincludingpatients.sex,
    vwpersonsincludingpatients.title,
    consult.consult_date,
    consult.fk_patient,
    consult.fk_staff,
    vwstaff.firstname AS staff_firstname,
    vwstaff.wholename AS staff_wholename,
    vwstaff.salutation AS staff_salutation,
    vwstaff.title AS staff_title,
    NULL::text AS contact_provider_number
   FROM clin_referrals.referrals
     LEFT JOIN contacts.vwpersonsincludingpatients ON referrals.fk_person = vwpersonsincludingpatients.fk_person AND referrals.fk_address = vwpersonsincludingpatients.fk_address
     JOIN clin_consult.consult ON referrals.fk_consult = consult.pk
     JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
     JOIN clin_referrals.lu_type ON referrals.fk_type = lu_type.pk
     JOIN clin_referrals.lu_urgency ON referrals.fk_lu_urgency = lu_urgency.pk
  WHERE referrals.fk_branch IS NULL AND referrals.fk_employee IS NULL
UNION
 SELECT DISTINCT referrals.pk AS pk_referral,
    referrals.date_referral,
    referrals.fk_consult,
    referrals.fk_person,
    referrals.fk_type,
    lu_type.type,
    referrals.tag,
    referrals.deleted,
    referrals.body_html,
    referrals.letter_html,
    referrals.letter_hl7,
    referrals.fk_progressnote,
    referrals.include_careplan,
    referrals.include_healthsummary,
    referrals.fk_branch,
    referrals.fk_employee,
    referrals.fk_address,
    referrals.copyto,
    referrals.fk_lu_urgency,
    referrals.finalised,
    lu_urgency.urgency,
    vworganisationsemployees.street1,
    vworganisationsemployees.street2,
    vworganisationsemployees.town,
    vworganisationsemployees.state,
    vworganisationsemployees.postcode,
    vworganisationsemployees.organisation,
    vworganisationsemployees.branch,
    NULL::text AS wholename,
    NULL::text AS occupation,
    NULL::text AS firstname,
    NULL::text AS surname,
    NULL::text AS salutation,
    NULL::text AS sex,
    NULL::text AS title,
    consult.consult_date,
    consult.fk_patient,
    consult.fk_staff,
    vwstaff.firstname AS staff_firstname,
    vwstaff.wholename AS staff_wholename,
    vwstaff.salutation AS staff_salutation,
    vwstaff.title AS staff_title,
    NULL::text AS contact_provider_number
   FROM clin_referrals.referrals
     JOIN contacts.vworganisationsemployees ON referrals.fk_branch = vworganisationsemployees.fk_branch
     JOIN clin_consult.consult ON referrals.fk_consult = consult.pk
     JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
     JOIN clin_referrals.lu_type ON referrals.fk_type = lu_type.pk
     JOIN clin_referrals.lu_urgency ON referrals.fk_lu_urgency = lu_urgency.pk
   WHERE referrals.fk_person IS NULL;

ALTER TABLE clin_referrals.vwreferrals   OWNER TO easygp;
GRANT ALL ON TABLE clin_referrals.vwreferrals TO staff;
CREATE OR REPLACE VIEW clin_history.vwresponsiblepersons AS 
 SELECT vwpatients.surname,
    vwpatients.firstname,
    vwsocialhistory.responsible_person,
    vwsocialhistory.fk_responsible_person,
    vwsocialhistory.person_responsible_wholename,
    vwsocialhistory.history,
    vwpatients.active_status,
    vwpatients.age_numeric,
    vwpatients.deceased
   FROM clin_history.vwsocialhistory,
    contacts.vwpatients
  WHERE vwsocialhistory.fk_patient = vwpatients.fk_patient AND vwpatients.age_numeric < 90::double precision AND vwpatients.active_status = 'active'::text AND vwpatients.deceased = false AND vwpatients.person_deleted = false;

ALTER TABLE clin_history.vwresponsiblepersons   OWNER TO easygp;
GRANT ALL ON TABLE clin_history.vwresponsiblepersons TO easygp;
GRANT SELECT ON TABLE clin_history.vwresponsiblepersons TO staff;

update db.lu_version set lu_minor = 447;
