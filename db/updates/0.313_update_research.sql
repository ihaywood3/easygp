CREATE OR REPLACE VIEW coding.vwicpcgrouperlinkeasygpgenericcode AS 
 SELECT icpc2_grp_grouper.grouper, icpc2_terms.icpc_code || icpc2_terms.term_code AS fk_code
   FROM coding.icpc2_grp_grouper, coding.icpc2_grp_grp_icpc, coding.icpc2_terms
  WHERE icpc2_grp_grouper."Grouper_id" = icpc2_grp_grp_icpc.grouper_id AND icpc2_grp_grp_icpc.icpc_code::text = icpc2_terms.icpc_code;

ALTER TABLE coding.vwicpcgrouperlinkeasygpgenericcode   OWNER TO easygp;
GRANT SELECT on table coding.vwicpcgrouperlinkeasygpgenericcode to staff;


CREATE OR REPLACE VIEW research.vwlinkicpc2grouperhealthissues AS 
 SELECT vwpatients.pk_view, vwpatients.fk_patient, vwpatients.fk_address,
 vwpatients.fk_person, vwpatients.wholename, vwpatients.fk_doctor, vwpatients.fk_next_of_kin, 
 vwpatients.fk_payer_person, vwpatients.fk_payer_branch, vwpatients.fk_family, vwpatients.medicare_number, 
 vwpatients.medicare_ref_number, vwpatients.medicare_expiry_date, vwpatients.veteran_number, 
 vwpatients.veteran_specific_condition, vwpatients.concession_card_number, 
 vwpatients.concession_card_expiry_date, vwpatients.patient_memo, vwpatients.fk_legacy, 
 vwpatients.fk_lu_aboriginality, vwpatients.fk_lu_veteran_card_type, vwpatients.fk_lu_active_status, 
 vwpatients.fk_lu_centrelink_card_type, vwpatients.fk_lu_private_health_fund, vwpatients.private_insurance, 
 vwpatients.active_status, vwpatients.veteran_card_type, vwpatients.concession_card_type, vwpatients.fund, 
 vwpatients.firstname, vwpatients.surname, vwpatients.salutation, vwpatients.birthdate, vwpatients.age_display, 
 vwpatients.age_numeric, vwpatients.fk_ethnicity, vwpatients.fk_language, vwpatients.person_memo, 
 vwpatients.fk_marital, vwpatients.fk_title, vwpatients.fk_sex, vwpatients.country_birth_country_code, 
 vwpatients.fk_image, vwpatients.retired, vwpatients.fk_occupation, vwpatients.person_deleted, 
 vwpatients.deceased, vwpatients.date_deceased, vwpatients.language_problems, vwpatients.surname_normalised, 
 vwpatients.aboriginality, vwpatients.country_birth, vwpatients.ethnicity, vwpatients.language,
 vwpatients.occupation, vwpatients.marital, vwpatients.title, vwpatients.sex, vwpatients.sex_text, vwpatients.image, 
 vwpatients.md5sum, vwpatients.tag, vwpatients.fk_consult_image, vwpatients.fk_link_persons_address, 
 vwpatients.street1, vwpatients.fk_town, vwpatients.preferred_address, vwpatients.postal_address, 
 vwpatients.head_office, vwpatients.geolocation, vwpatients.country_code, vwpatients.fk_lu_address_type, vwpatients.address_deleted,
 vwpatients.street2, vwpatients.country, vwpatients.link_address_deleted, vwpatients.address_type, 
 vwpatients.postcode, vwpatients.town, vwpatients.state, vwpatients.fk_lu_default_billing_level,
 vwpatients.billing_level, vwpatients.nursing_home_resident, vwpatients.ihi, vwpatients.pcehr_consent, 
 vwpatients.ihi_updated, vwicpcgrouperlinkeasygpgenericcode.grouper, past_history.description AS health_issue_description,
 past_history.active AS health_issue_active
   FROM contacts.vwpatients, coding.vwicpcgrouperlinkeasygpgenericcode, clin_history.past_history, clin_consult.consult
  WHERE past_history.fk_code = vwicpcgrouperlinkeasygpgenericcode.fk_code AND past_history.fk_consult = consult.pk AND consult.fk_patient = vwpatients.fk_patient;

ALTER TABLE research.vwlinkicpc2grouperhealthissues   OWNER TO easygp;
GRANT SELECT on table research.vwlinkicpc2grouperhealthissues to staff;



CREATE OR REPLACE VIEW research.vwlinkicpc2grouperpatients AS 
 SELECT vwpatients.pk_view, vwpatients.fk_patient, vwpatients.fk_address, 
 vwpatients.fk_person, vwpatients.wholename, vwpatients.fk_doctor, vwpatients.fk_next_of_kin, 
 vwpatients.fk_payer_person, vwpatients.fk_payer_branch, vwpatients.fk_family, vwpatients.medicare_number, 
 vwpatients.medicare_ref_number, vwpatients.medicare_expiry_date, vwpatients.veteran_number, vwpatients.veteran_specific_condition, 
 vwpatients.concession_card_number, vwpatients.concession_card_expiry_date, vwpatients.patient_memo, vwpatients.fk_legacy, 
 vwpatients.fk_lu_aboriginality, vwpatients.fk_lu_veteran_card_type, vwpatients.fk_lu_active_status, vwpatients.fk_lu_centrelink_card_type, 
 vwpatients.fk_lu_private_health_fund, vwpatients.private_insurance, vwpatients.active_status, vwpatients.veteran_card_type, 
 vwpatients.concession_card_type, vwpatients.fund, vwpatients.firstname, vwpatients.surname, vwpatients.salutation, 
 vwpatients.birthdate, vwpatients.age_display, vwpatients.age_numeric, vwpatients.fk_ethnicity, vwpatients.fk_language, 
 vwpatients.person_memo, vwpatients.fk_marital, vwpatients.fk_title, vwpatients.fk_sex, vwpatients.country_birth_country_code, 
 vwpatients.fk_image, vwpatients.retired, vwpatients.fk_occupation, vwpatients.person_deleted, vwpatients.deceased, 
 vwpatients.date_deceased, vwpatients.language_problems, vwpatients.surname_normalised, vwpatients.aboriginality, 
 vwpatients.country_birth, vwpatients.ethnicity, vwpatients.language, vwpatients.occupation, vwpatients.marital, vwpatients.title,
 vwpatients.sex, vwpatients.sex_text, vwpatients.image, vwpatients.md5sum, vwpatients.tag, vwpatients.fk_consult_image, 
 vwpatients.fk_link_persons_address, vwpatients.street1, vwpatients.fk_town, vwpatients.preferred_address, vwpatients.postal_address, 
 vwpatients.head_office, vwpatients.geolocation, vwpatients.country_code, vwpatients.fk_lu_address_type, vwpatients.address_deleted, 
 vwpatients.street2, vwpatients.country, vwpatients.link_address_deleted, vwpatients.address_type, vwpatients.postcode,
 vwpatients.town, vwpatients.state, vwpatients.fk_lu_default_billing_level, vwpatients.billing_level, vwpatients.nursing_home_resident,
 vwpatients.ihi, vwpatients.pcehr_consent, vwpatients.ihi_updated, vwicpcgrouperlinkeasygpgenericcode.grouper
   FROM contacts.vwpatients, coding.vwicpcgrouperlinkeasygpgenericcode, clin_history.past_history, clin_consult.consult
  WHERE past_history.fk_code = vwicpcgrouperlinkeasygpgenericcode.fk_code AND past_history.fk_consult = consult.pk AND consult.fk_patient = vwpatients.fk_patient;

ALTER TABLE research.vwlinkicpc2grouperpatients   OWNER TO easygp;
GRANT SELECT on table research.vwlinkicpc2grouperpatients to staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 313);
