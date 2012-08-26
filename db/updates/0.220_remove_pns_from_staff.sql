
create or replace view admin.vwstaffinclinics as
SELECT (staff.pk || '-'::text) || data_addresses.pk AS pk_view, (data_persons.firstname || ' '::text) || data_persons.surname AS wholename, staff.fk_person, staff.fk_role, staff.fk_status, staff.logon_name, data_numbers.provider_number, data_numbers.prescriber_number, staff.fk_lu_staff_type, staff.logon_date_from, staff.logon_date_to, link_staff_clinics1.fk_staff, link_staff_clinics1.fk_clinic, clinics.fk_branch, data_branches.branch, data_branches.fk_organisation, data_branches.fk_address, data_branches.memo AS branch_memo, data_branches.fk_category AS branch_category, data_branches.deleted AS branch_deleted, data_employees.pk AS fk_employee, data_employees.fk_occupation, data_employees.memo AS employee_memo, data_employees.deleted AS employee_deleted, data_persons.firstname, data_persons.surname, data_persons.salutation, data_persons.birthdate, data_persons.fk_ethnicity, data_persons.fk_language, data_persons.memo AS person_memo, data_persons.fk_marital, data_persons.fk_title, data_persons.fk_sex, data_persons.country_code AS person_country_code, data_persons.fk_image, data_persons.retired, data_persons.deleted AS person_deleted, data_persons.deceased, data_persons.date_deceased, lu_title.title, lu_marital.marital, lu_sex.sex, lu_occupations.occupation, lu_ethnicity.ethnicity, lu_languages.language, images.image, images.md5sum, images.tag, images.fk_consult AS fk_consult_image, images.deleted AS image_deleted, lu_staff_roles.role, lu_staff_type.type AS staff_type, lu_employee_status.status, data_organisations.organisation, data_organisations.deleted AS organisation_deleted, data_addresses.street1, data_addresses.street2, data_addresses.fk_town, lu_address_types.type AS address_type, data_addresses.preferred_address, data_addresses.postal_address, data_addresses.head_office, data_addresses.geolocation, data_addresses.country_code, data_addresses.fk_lu_address_type, data_addresses.deleted AS address_deleted, lu_towns.postcode, lu_towns.town, lu_towns.state, link_staff_clinics1.pk AS fk_link_staff_clinic, staff.qualifications, data_persons.surname_normalised
   FROM admin.staff
   JOIN admin.link_staff_clinics link_staff_clinics1 ON staff.pk = link_staff_clinics1.fk_staff
   JOIN admin.clinics ON link_staff_clinics1.fk_clinic = clinics.pk
   JOIN contacts.data_employees ON (staff.fk_person = data_employees.fk_person AND clinics.fk_branch = data_employees.fk_branch)
   JOIN contacts.data_branches ON clinics.fk_branch = data_branches.pk
   JOIN contacts.data_persons ON data_employees.fk_person = data_persons.pk
   JOIN admin.lu_staff_type ON staff.fk_lu_staff_type = lu_staff_type.pk
   LEFT JOIN contacts.lu_sex ON data_persons.fk_sex = lu_sex.pk
   LEFT JOIN contacts.data_numbers on (data_numbers.fk_person = staff.fk_person and clinics.fk_branch = data_numbers.fk_branch)
   LEFT JOIN contacts.lu_marital ON data_persons.fk_marital = lu_marital.pk
   LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
   LEFT JOIN common.lu_occupations ON data_employees.fk_occupation = lu_occupations.pk
   LEFT JOIN common.lu_ethnicity ON data_persons.fk_ethnicity = lu_ethnicity.pk
   LEFT JOIN common.lu_languages ON data_persons.fk_language = lu_languages.pk
   LEFT JOIN blobs.images ON data_persons.fk_image = images.pk
   JOIN admin.lu_staff_roles ON staff.fk_role = lu_staff_roles.pk
   JOIN contacts.lu_employee_status ON staff.fk_status = lu_employee_status.pk
   JOIN contacts.data_organisations ON data_branches.fk_organisation = data_organisations.pk
   LEFT JOIN contacts.data_addresses ON data_branches.fk_address = data_addresses.pk
   LEFT JOIN contacts.lu_towns ON data_addresses.fk_town = lu_towns.pk
   LEFT JOIN contacts.lu_address_types ON data_addresses.fk_lu_address_type = lu_address_types.pk;




drop view admin.vwstaff cascade;
--alter table admin.staff drop column provider_number;
--alter table admin.staff drop column prescriber_number;


create view admin.vwstaff as 
 SELECT roles.role, staff.fk_person, staff.logon_name, staff.fk_role, staff.pk, staff.pk AS fk_staff,  persons.firstname, persons.surname, (persons.firstname || ' '::text) || persons.surname AS wholename, persons.salutation, persons.fk_title, lu_title.title, staff.qualifications, persons.surname_normalised
   FROM admin.staff staff
   JOIN admin.lu_staff_roles roles ON staff.fk_role = roles.pk
   JOIN contacts.data_persons persons ON staff.fk_person = persons.pk
   JOIN contacts.lu_title ON persons.fk_title = lu_title.pk;



create view clin_mentalhealth.vwmentalhealthplans as 
 SELECT mentalhealth_plan.pk AS pk_mentalhealth_plan, consult.fk_patient, consult.fk_staff, consult.consult_date AS plan_date, mentalhealth_plan.fk_consult, 
mentalhealth_plan.fk_pasthistory, mentalhealth_plan.diagnosis, mentalhealth_plan.fk_coding_system, mentalhealth_plan.fk_progressnote, lu_systems.system, 
( SELECT DISTINCT generic_terms.term
           FROM coding.generic_terms
          WHERE mentalhealth_plan.fk_code = generic_terms.code) AS coded_term, mentalhealth_plan.fk_code, mentalhealth_plan.presenting_problems, mentalhealth_plan.bio_psycho_social, 
mentalhealth_plan.mental_state_examination, mentalhealth_plan.fk_lu_risk_to_others, lu_risk_to_others.risk, mentalhealth_plan.fk_stress_assessment, mentalhealth_plan.relapse_plan, 
mentalhealth_plan.risk_harm_comments, mentalhealth_plan.goals, mentalhealth_plan.treatment_referrrals, mentalhealth_plan.review_date, mentalhealth_plan.html, mentalhealth_plan.fk_lu_plan_type, 
lu_plan_type.type, mentalhealth_plan.deleted, vwstaff.wholename, vwstaff.title
   FROM clin_mentalhealth.mentalhealth_plan
   JOIN clin_consult.consult ON mentalhealth_plan.fk_consult = consult.pk
   JOIN clin_mentalhealth.lu_plan_type ON mentalhealth_plan.fk_lu_plan_type = lu_plan_type.pk
   LEFT JOIN clin_history.past_history ON mentalhealth_plan.fk_pasthistory = past_history.pk
   JOIN coding.lu_systems ON mentalhealth_plan.fk_coding_system = lu_systems.pk
   LEFT JOIN clin_mentalhealth.lu_risk_to_others ON mentalhealth_plan.fk_lu_risk_to_others = lu_risk_to_others.pk
   JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
  WHERE not mentalhealth_plan.deleted;

CREATE VIEW clin_prescribing.vwprescribeditems AS 
 SELECT prescribed.pk AS pk_view, medications.pk AS fk_medication, medications.start_date, medications.last_date, 
 medications.active, medications.deleted AS medication_deleted, medications.fk_generic_product, 
 consult.pk AS fk_consult, consult.consult_date AS date_script_written, consult.fk_patient, 
 product.generic, brand.brand, product.strength, brand.product_information_filename, 
 form.form, brand.pk AS fk_brand, prescribed.pk AS fk_prescribed, prescribed.repeats, 
 prescribed.date_on_script, prescribed.quantity, prescribed_for.prescribed_for, prescribed.deleted AS prescribed_deleted, 
 prescribed.authority_reason, prescribed.print_reason, instructions.instruction, vwstaff.wholename AS staff_prescribed_wholename, 
 vwstaff.title AS staff_prescribed_title, product.atccode, product.salt, product.fk_form, 
 product.fk_schedule, product.salt_strength, prescribed.fk_instruction, prescribed.fk_prescribed_for, 
 prescribed.pbscode, prescribed.fk_lu_pbs_script_type, prescribed.restriction_code, prescribed.fk_code, prescribed.reg24,
 lu_pbs_script_type.type AS pbs_script_type, restriction.streamlined, restriction.restriction, 
 restriction.restriction_type, schedules.schedule, drugs.format_strength(product.strength) AS display_strength, 
 drugs.format_amount(product.amount, product.amount_unit, product.units_per_pack) AS display_packsize, product.units_per_pack
   FROM clin_consult.consult
   JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   JOIN clin_prescribing.prescribed ON consult.pk = prescribed.fk_consult
   JOIN clin_prescribing.medications medications ON prescribed.fk_medication = medications.pk
   JOIN clin_prescribing.prescribed_for ON prescribed.fk_prescribed_for = prescribed_for.pk
   JOIN clin_prescribing.instructions ON prescribed.fk_instruction = instructions.pk
   JOIN clin_prescribing.lu_pbs_script_type ON prescribed.fk_lu_pbs_script_type = lu_pbs_script_type.pk
   LEFT JOIN drugs.restriction ON prescribed.pbscode = restriction.pbscode::text AND prescribed.restriction_code = restriction.code::text
   LEFT JOIN drugs.brand ON prescribed.fk_brand = brand.pk
   JOIN drugs.product ON medications.fk_generic_product = product.pk
   LEFT JOIN drugs.schedules ON product.fk_schedule = schedules.pk
   JOIN drugs.form ON product.fk_form = form.pk;


create View clin_procedures.vwskinprocedures as
 SELECT skin_procedures.pk AS pk_view, skin_procedures.pk AS fk_skin_procedure, skin_procedures.fk_consult, skin_procedures.date, skin_procedures.explained_procedure, skin_procedures.obtained_consent, skin_procedures.detailed_complications, skin_procedures.fk_lu_site, skin_procedures.lesion_notes, skin_procedures.dermoscopy_notes, skin_procedures.fk_lu_lateralisation, skin_procedures.fk_lu_anterior_posterior, skin_procedures.localisation, skin_procedures.surgical_pack_identifier, skin_procedures.fk_lu_skin_preparation, skin_procedures.fk_lu_anaesthetic_agent, skin_procedures.fk_lu_procedure_type, skin_procedures.fk_lu_repair_type, skin_procedures.fk_subcutaneous_suture, skin_procedures.fk_skin_suture, skin_procedures.average_diameter_cm, skin_procedures.fk_provisional_diagnosis, generic_terms.term AS provisional_diagnosis, skin_procedures.fk_document, skin_procedures.fk_actual_diagnosis, generic_terms1.term AS actual_diagnosis, skin_procedures.fk_pasthistory, skin_procedures.referred, skin_procedures.review_months, skin_procedures.fk_branch, skin_procedures.fk_form, skin_procedures.complications, skin_procedures.fk_progressnote_auto, progressnotes.notes AS progressnote_auto, skin_procedures.fk_progressnote_user, progressnotes1.notes AS progressnote_user, consult.consult_date, consult.fk_staff, consult.fk_patient, lu_anatomical_site.site, lu_anterior_posterior.anterior_posterior, lu_laterality.laterality, lu_skin_preparation.preparation, lu_anaesthetic_agent.agent, lu_anaesthetic_agent.fk_lu_route_administration, lu_procedure_type.type AS procedure_type, lu_repair_type.type AS repair_type, lu_suture_type.brand AS skin_suture, lu_suture_type1.brand AS subcutaneous_suture, data_organisations.organisation, vwstaff.wholename, vwstaff.title
   FROM clin_procedures.skin_procedures
   JOIN clin_consult.consult ON skin_procedures.fk_consult = consult.pk
   JOIN common.lu_anatomical_site ON skin_procedures.fk_lu_site = lu_anatomical_site.pk
   LEFT JOIN common.lu_anterior_posterior ON skin_procedures.fk_lu_anterior_posterior = lu_anterior_posterior.pk
   LEFT JOIN common.lu_laterality ON skin_procedures.fk_lu_lateralisation = lu_laterality.pk
   LEFT JOIN clin_procedures.lu_skin_preparation ON skin_procedures.fk_lu_skin_preparation = lu_skin_preparation.pk
   LEFT JOIN coding.generic_terms ON skin_procedures.fk_provisional_diagnosis = generic_terms.code
   JOIN clin_procedures.lu_anaesthetic_agent ON skin_procedures.fk_lu_anaesthetic_agent = lu_anaesthetic_agent.pk
   JOIN clin_procedures.lu_procedure_type ON skin_procedures.fk_lu_procedure_type = lu_procedure_type.pk
   JOIN clin_procedures.lu_repair_type ON skin_procedures.fk_lu_repair_type = lu_repair_type.pk
   JOIN clin_procedures.lu_suture_type ON skin_procedures.fk_skin_suture = lu_suture_type.pk
   JOIN clin_procedures.lu_suture_type lu_suture_type1 ON skin_procedures.fk_subcutaneous_suture = lu_suture_type1.pk
   LEFT JOIN coding.generic_terms generic_terms1 ON skin_procedures.fk_actual_diagnosis = generic_terms1.code
   LEFT JOIN contacts.data_branches ON skin_procedures.fk_branch = data_branches.pk
   LEFT JOIN clin_requests.forms ON skin_procedures.fk_form = forms.pk
   LEFT JOIN clin_consult.progressnotes progressnotes1 ON skin_procedures.fk_progressnote_user = progressnotes1.pk
   JOIN clin_consult.progressnotes ON skin_procedures.fk_progressnote_auto = progressnotes.pk
   JOIN contacts.data_organisations ON data_branches.fk_organisation = data_organisations.pk
   JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff;

create View clin_requests.vwrequestforms as
 SELECT COALESCE((forms.pk || '-'::text) || forms_requests.pk) AS pk_view, forms_requests.pk AS fk_forms_requests, forms.fk_consult, forms.date, lu_requests.item, forms.requests_summary, forms.notes_summary, forms.fk_request_provider, forms.fk_lu_request_type, forms.medications_summary, forms.copyto, forms.deleted, forms.copyto_patient, forms.urgent, forms.bulk_bill, forms.fasting, forms.phone, forms.fax, forms.include_medications, forms.pk_image, forms.fk_progressnote, forms.fk_pasthistory, forms.latex, vwstaff.firstname AS staff_firstname, vwstaff.surname AS staff_surname, vwstaff.wholename AS staff_wholename, vwstaff.title AS staff_title, lu_request_type.type, vwrequestproviders.fk_headoffice_branch, vwrequestproviders.fk_default_branch, vwrequestproviders.fk_employee, vwrequestproviders.fk_person, vwrequestproviders.request_provider_deleted, vwrequestproviders.organisation, vwrequestproviders.category, vwrequestproviders.headoffice_branch, vwrequestproviders.fk_organisation, vwrequestproviders.headoffice_branch_deleted, vwrequestproviders.headoffice_street1, vwrequestproviders.headoffice_street2, vwrequestproviders.headoffice_address_deleted, vwrequestproviders.headoffice_postcode, vwrequestproviders.headoffice_town, vwrequestproviders.headoffice_state, vwrequestproviders.wholename, vwrequestproviders.firstname, vwrequestproviders.surname, vwrequestproviders.salutation, vwrequestproviders.fk_title, vwrequestproviders.title, vwrequestproviders.fk_sex, vwrequestproviders.sex, vwrequestproviders.fk_occupation, vwrequestproviders.occupation, vwrequestproviders.default_branch, vwrequestproviders.default_branch_street1, vwrequestproviders.default_branch_street2, vwrequestproviders.default_branch_postcode, vwrequestproviders.default_branch_town, vwrequestproviders.default_branch_state, forms_requests.fk_form, forms_requests.fk_lu_request, forms_requests.deleted AS forms_request_deleted, forms_requests.request_result_html, consult.consult_date, consult.fk_patient, consult.fk_staff, past_history.description AS past_history_description
   FROM clin_requests.forms
   JOIN clin_consult.consult ON forms.fk_consult = consult.pk
   JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   JOIN clin_requests.lu_request_type ON forms.fk_lu_request_type = lu_request_type.pk
   JOIN clin_requests.forms_requests ON forms.pk = forms_requests.fk_form
   JOIN clin_requests.lu_requests ON forms_requests.fk_lu_request = lu_requests.pk
   JOIN clin_requests.vwrequestproviders ON forms.fk_request_provider = vwrequestproviders.pk_request_provider
   LEFT JOIN clin_history.past_history ON forms.fk_pasthistory = past_history.pk;

 create View clin_vaccination.vwvaccinesgiven  as        
 SELECT vaccinations.pk AS pk_view, vaccinations.pk AS fk_vaccination, consult.fk_patient, vwstaff.title AS staff_title, vwstaff.wholename AS staff_wholename, consult.consult_date, consult.fk_staff, consult.pk AS fk_consult, lu_schedules.age_due_from_months, lu_schedules.age_due_to_months, lu_schedules.schedule, lu_schedules.female_only, lu_schedules.atsi_only, lu_schedules.fk_season, lu_schedules.inactive AS schedule_inactive, lu_schedules.date_inactive AS date_schedule_inactive, lu_schedules.deleted AS schedule_deleted, lu_schedules.multiple_vaccines, lu_schedules.notes AS schedule_notes, lu_seasons.season, lu_laterality.laterality, lu_site_administration.site, progressnotes.notes AS progress_notes, lu_vaccines.brand, lu_vaccines.form, lu_vaccines.fk_description, lu_vaccines.fk_route, lu_vaccines.inactive, vaccinations.fk_vaccine, vaccinations.fk_schedule, vaccinations.fk_site, vaccinations.fk_laterality, vaccinations.date_given, vaccinations.serial_no, vaccinations.fk_progressnote, vaccinations.not_given, vaccinations.notes, vaccinations.deleted
   FROM clin_consult.consult
   JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   JOIN clin_consult.progressnotes ON progressnotes.fk_consult = consult.pk
   JOIN clin_vaccination.vaccinations ON vaccinations.fk_progressnote = progressnotes.pk
   LEFT JOIN common.lu_site_administration ON vaccinations.fk_site = lu_site_administration.pk
   LEFT JOIN common.lu_laterality ON vaccinations.fk_laterality = lu_laterality.pk
   JOIN clin_vaccination.lu_schedules ON vaccinations.fk_schedule = lu_schedules.pk
   JOIN clin_vaccination.lu_vaccines ON vaccinations.fk_vaccine = lu_vaccines.pk
   LEFT JOIN common.lu_seasons ON lu_schedules.fk_season = lu_seasons.pk;

create View clin_workcover.vwworkcover as
 SELECT visits.pk AS pk_view, visits.pk AS fk_visit, visits.fk_claim, consult1.consult_date AS start_date, consult.consult_date AS visit_date, consult.fk_patient, claims.claim_number, claims.fk_occupation, claims.fk_branch, claims.hours_week_worked, claims.mechanism_of_injury, claims.date_injury, claims.contact_person, claims.memo, claims.identifier, claims.fk_person, claims.accepted, claims.deleted AS claim_deleted, consult.fk_staff, consult.fk_type, consult.summary, vwstaff.wholename AS staff_wholename, vwstaff.surname AS staff_surname, vwstaff.firstname AS staff_firstname, vwstaff.title AS staff_title, lu_occupations.occupation, vworganisations.branch, vworganisations.fk_organisation, vworganisations.organisation, vworganisations.street1 AS branch_street1, vworganisations.street2 AS branch_street2, vworganisations.town AS branch_town, vworganisations.branch_deleted, vwpersons.wholename AS soletrader_wholename, vwpersons.firstname AS soletrader_firstname, vwpersons.surname AS soletrader_surname, vwpersons.title AS soletrader_title, vwpersons.town AS soletrader_town, vwpersons.street1 AS soletrader_street1, vwpersons.street2 AS soletrader_street2, vwpersons.postcode AS soletrader_postcode, vwpersons.address_deleted AS soletrader_address_deleted, lu_visit_type.type AS visit_type, visits.fk_lu_visit_type, visits.diagnosis, lu_systems.system AS coding_system, visits.fk_code, 
        CASE
            WHEN visits.fk_code IS NOT NULL THEN ( SELECT DISTINCT generic_terms.term
               FROM coding.generic_terms
              WHERE visits.fk_code = generic_terms.code)
            ELSE NULL::text
        END AS coded_term, visits.certificate_date, visits.management_plan, visits.review_date, visits.assessworkplace, visits.hours_capable, visits.days_capable, visits.restrictions, visits.fk_caused_by_employment, visits.doctor_consented, visits.worker_consented, visits.fitness_preinjury_from, visits.fitness_suitable_from, visits.fitness_suitable_to, visits.fitness_unfit_from, visits.fitness_unfit_to, visits.fitness_perm_mod_duties_from, visits.fk_consult, visits.fk_progressnote, visits.fk_coding_system, visits.capabilities, visits.latex, visits.deleted AS visit_deleted, lu_caused_by_employment.caused_by_employment, consult1.pk AS fk_consult_claim
   FROM clin_consult.consult
   JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   JOIN clin_workcover.visits ON visits.fk_consult = consult.pk
   JOIN clin_workcover.claims ON claims.pk = visits.fk_claim
   JOIN common.lu_occupations ON claims.fk_occupation = lu_occupations.pk
   LEFT JOIN coding.lu_systems ON visits.fk_coding_system = lu_systems.pk
   LEFT JOIN contacts.vworganisations ON claims.fk_branch = vworganisations.fk_branch
   LEFT JOIN contacts.vwpersons ON claims.fk_person = vwpersons.fk_person
   JOIN clin_workcover.lu_visit_type ON visits.fk_lu_visit_type = lu_visit_type.pk
   JOIN clin_workcover.lu_caused_by_employment ON visits.fk_caused_by_employment = lu_caused_by_employment.pk
   JOIN clin_consult.consult consult1 ON claims.fk_consult = consult1.pk;

 create View clin_recalls.vwrecallsdue as
 SELECT recalls.pk AS pk_recall, recalls.fk_consult, recalls.due, recalls.due - date(now()) AS days_due, recalls.fk_reason, recalls.fk_contact_method, recalls.fk_urgency, recalls.fk_appointment_length, recalls.fk_staff, recalls.active, recalls.additional_text, recalls.deleted, recalls."interval", recalls.fk_interval_unit, recalls.fk_progressnote, recalls.fk_pasthistory, recalls.fk_sent, recalls.num_reminders, sent.latex, sent.date AS date_reminder_sent, lu_units.abbrev_text, vwpatients.fk_person, vwpatients.wholename, vwpatients.firstname, vwpatients.surname, vwpatients.salutation, vwpatients.birthdate, vwpatients.age_numeric, vwpatients.sex, vwpatients.title, vwpatients.street1, vwpatients.street2, vwpatients.town, vwpatients.state, vwpatients.postcode, vwpatients.language_problems, vwpatients.language, consult.fk_patient, vwstaff.firstname AS staff_to_see_firstname, vwstaff.surname AS staff_to_see_surname, vwstaff.wholename AS staff_to_see_wholename, vwstaff.title AS staff_to_see_title, lu_reasons.reason, lu_urgency.urgency, lu_contact_type.type AS contact_method, lu_appointment_length.length AS appointment_length, consult.consult_date, recalls.fk_template, lu_appointment_length1.length, lu_templates.name, lu_templates.template
   FROM clin_recalls.recalls
   JOIN clin_consult.consult ON recalls.fk_consult = consult.pk
   JOIN contacts.vwpatients ON consult.fk_patient = vwpatients.fk_patient
   JOIN admin.vwstaff ON recalls.fk_staff = vwstaff.fk_staff
   JOIN clin_recalls.lu_reasons ON recalls.fk_reason = lu_reasons.pk
   JOIN common.lu_urgency ON recalls.fk_urgency = lu_urgency.pk
   JOIN contacts.lu_contact_type ON recalls.fk_contact_method = lu_contact_type.pk
   JOIN common.lu_appointment_length ON recalls.fk_appointment_length = lu_appointment_length.pk
   LEFT JOIN common.lu_units ON recalls.fk_interval_unit = lu_units.pk
   LEFT JOIN clin_recalls.lu_templates ON recalls.fk_template = lu_templates.pk
   LEFT JOIN common.lu_appointment_length lu_appointment_length1 ON lu_templates.fk_lu_appointment_length = lu_appointment_length1.pk
   LEFT JOIN clin_recalls.sent ON recalls.fk_sent = sent.pk
  WHERE NOT recalls.deleted;

 create View clin_referrals.vwreferrals as
         (         SELECT DISTINCT referrals.pk AS pk_referral, referrals.date_referral, referrals.fk_consult, referrals.fk_person, referrals.fk_type, lu_type.type, referrals.tag, referrals.deleted, referrals.body_html, referrals.letter_html, referrals.fk_pasthistory, referrals.fk_progressnote, referrals.include_careplan, referrals.include_healthsummary, referrals.fk_branch, referrals.fk_employee, referrals.fk_address, referrals.copyto, vworganisationsemployees.street1, vworganisationsemployees.street2, vworganisationsemployees.town, vworganisationsemployees.state, vworganisationsemployees.postcode, vworganisationsemployees.organisation, vworganisationsemployees.branch, vworganisationsemployees.wholename, vworganisationsemployees.occupation, vworganisationsemployees.firstname, vworganisationsemployees.surname, vworganisationsemployees.salutation, vworganisationsemployees.sex, vworganisationsemployees.title, consult.consult_date, consult.fk_patient, consult.fk_staff, vwstaff.firstname AS staff_firstname, vwstaff.wholename AS staff_wholename, vwstaff.salutation AS staff_salutation, vwstaff.title AS staff_title, past_history.description, vworganisationsemployees.provider_number AS contact_provider_number
                   FROM clin_referrals.referrals
              JOIN contacts.vworganisationsemployees ON referrals.fk_employee = vworganisationsemployees.fk_employee AND referrals.fk_branch = vworganisationsemployees.fk_branch
         JOIN clin_consult.consult ON referrals.fk_consult = consult.pk
    JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   JOIN clin_referrals.lu_type ON referrals.fk_type = lu_type.pk
   LEFT JOIN clin_history.past_history ON referrals.fk_pasthistory = past_history.pk
        UNION 
                 SELECT DISTINCT referrals.pk AS pk_referral, referrals.date_referral, referrals.fk_consult, referrals.fk_person, referrals.fk_type, lu_type.type, referrals.tag, referrals.deleted, referrals.body_html, referrals.letter_html, referrals.fk_pasthistory, referrals.fk_progressnote, referrals.include_careplan, referrals.include_healthsummary, referrals.fk_branch, referrals.fk_employee, referrals.fk_address, referrals.copyto, vwpersonsincludingpatients.street1, vwpersonsincludingpatients.street2, vwpersonsincludingpatients.town, vwpersonsincludingpatients.state, vwpersonsincludingpatients.postcode, NULL::text AS organisation, NULL::text AS branch, vwpersonsincludingpatients.wholename, NULL::text AS occupation, vwpersonsincludingpatients.firstname, vwpersonsincludingpatients.surname, vwpersonsincludingpatients.salutation, vwpersonsincludingpatients.sex, vwpersonsincludingpatients.title, consult.consult_date, consult.fk_patient, consult.fk_staff, vwstaff.firstname AS staff_firstname, vwstaff.wholename AS staff_wholename, vwstaff.salutation AS staff_salutation, vwstaff.title AS staff_title, past_history.description, NULL::text AS contact_provider_number
                   FROM clin_referrals.referrals
              LEFT JOIN contacts.vwpersonsincludingpatients ON referrals.fk_person = vwpersonsincludingpatients.fk_person AND referrals.fk_address = vwpersonsincludingpatients.fk_address
         JOIN clin_consult.consult ON referrals.fk_consult = consult.pk
    JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   JOIN clin_referrals.lu_type ON referrals.fk_type = lu_type.pk
   LEFT JOIN clin_history.past_history ON referrals.fk_pasthistory = past_history.pk
  WHERE referrals.fk_branch IS NULL AND referrals.fk_employee IS NULL)
UNION 
         SELECT DISTINCT referrals.pk AS pk_referral, referrals.date_referral, referrals.fk_consult, referrals.fk_person, referrals.fk_type, lu_type.type, referrals.tag, referrals.deleted, referrals.body_html, referrals.letter_html, referrals.fk_pasthistory, referrals.fk_progressnote, referrals.include_careplan, referrals.include_healthsummary, referrals.fk_branch, referrals.fk_employee, referrals.fk_address, referrals.copyto, vworganisationsemployees.street1, vworganisationsemployees.street2, vworganisationsemployees.town, vworganisationsemployees.state, vworganisationsemployees.postcode, vworganisationsemployees.organisation, vworganisationsemployees.branch, NULL::text AS wholename, NULL::text AS occupation, NULL::text AS firstname, NULL::text AS surname, NULL::text AS salutation, NULL::text AS sex, NULL::text AS title, consult.consult_date, consult.fk_patient, consult.fk_staff, vwstaff.firstname AS staff_firstname, vwstaff.wholename AS staff_wholename, vwstaff.salutation AS staff_salutation, vwstaff.title AS staff_title, past_history.description, NULL::text AS contact_provider_number
           FROM clin_referrals.referrals
      JOIN contacts.vworganisationsemployees ON referrals.fk_branch = vworganisationsemployees.fk_branch
   JOIN clin_consult.consult ON referrals.fk_consult = consult.pk
   JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   JOIN clin_referrals.lu_type ON referrals.fk_type = lu_type.pk
   LEFT JOIN clin_history.past_history ON referrals.fk_pasthistory = past_history.pk
  WHERE referrals.fk_person IS NULL;

 create View chronic_disease_management.vwdiabetescycleofcare as
 SELECT (diabetes_annual_cycle_of_care.pk || '-'::text) || COALESCE(diabetes_annual_cycle_of_care_notes.pk, 0)::text AS pk_view, diabetes_annual_cycle_of_care.pk AS fk_diabetes_annual_cycle_of_care, consult.consult_date, consult.fk_patient, consult.fk_staff AS fk_staff_started, diabetes_annual_cycle_of_care.date_completed, diabetes_annual_cycle_of_care.fk_consult, diabetes_annual_cycle_of_care.hba1c_date, diabetes_annual_cycle_of_care.hba1c_date_due, diabetes_annual_cycle_of_care.hba1c_details, diabetes_annual_cycle_of_care.eyes_date, diabetes_annual_cycle_of_care.eyes_date_due, diabetes_annual_cycle_of_care.eyes_details, diabetes_annual_cycle_of_care.bp_date, diabetes_annual_cycle_of_care.bp_date_due, diabetes_annual_cycle_of_care.bp_details, diabetes_annual_cycle_of_care.bmi_date, diabetes_annual_cycle_of_care.bmi_date_due, diabetes_annual_cycle_of_care.bmi_details, diabetes_annual_cycle_of_care.feet_date, diabetes_annual_cycle_of_care.feet_date_due, diabetes_annual_cycle_of_care.feet_details, diabetes_annual_cycle_of_care.lipids_date, diabetes_annual_cycle_of_care.lipids_date_due, diabetes_annual_cycle_of_care.lipids_details, diabetes_annual_cycle_of_care.microalbumin_date, diabetes_annual_cycle_of_care.microalbumin_date_due, diabetes_annual_cycle_of_care.microalbumin_details, diabetes_annual_cycle_of_care.renalfunction_date, diabetes_annual_cycle_of_care.renalfunction_date_due, diabetes_annual_cycle_of_care.renalfunction_details, diabetes_annual_cycle_of_care.education_date, diabetes_annual_cycle_of_care.education_date_due, diabetes_annual_cycle_of_care.education_details, diabetes_annual_cycle_of_care.diet_date, diabetes_annual_cycle_of_care.diet_date_due, diabetes_annual_cycle_of_care.diet_details, diabetes_annual_cycle_of_care.exercise_date, diabetes_annual_cycle_of_care.exercise_date_due, diabetes_annual_cycle_of_care.exercise_details, diabetes_annual_cycle_of_care.smoking_date, diabetes_annual_cycle_of_care.smoking_date_due, diabetes_annual_cycle_of_care.smoking_details, diabetes_annual_cycle_of_care.medication_review_date, diabetes_annual_cycle_of_care.medication_review_date_due, diabetes_annual_cycle_of_care.medication_review_details, diabetes_annual_cycle_of_care.deleted, diabetes_annual_cycle_of_care.fk_progressnote_components, diabetes_annual_cycle_of_care.latex, diabetes_annual_cycle_of_care_notes.fk_progressnote AS fk_progressnote_comments, vwprogressnotes.consult_date AS date_progress_note_comment, vwstaff.title AS staff_made_comment_title, vwstaff.wholename AS staff_made_comment_wholename, vwstaff1.title AS staff_started_title, vwstaff1.wholename AS staff_started_wholename, progressnotes.notes AS component_notes, vwprogressnotes.notes AS comments_notes
   FROM chronic_disease_management.diabetes_annual_cycle_of_care
   JOIN clin_consult.consult ON diabetes_annual_cycle_of_care.fk_consult = consult.pk
   LEFT JOIN chronic_disease_management.diabetes_annual_cycle_of_care_notes ON diabetes_annual_cycle_of_care.pk = diabetes_annual_cycle_of_care_notes.fk_diabetes_annual_cycle_of_care
   LEFT JOIN clin_consult.vwprogressnotes ON diabetes_annual_cycle_of_care_notes.fk_progressnote = vwprogressnotes.pk_progressnote
   LEFT JOIN admin.vwstaff ON vwprogressnotes.fk_staff = vwstaff.fk_staff
   JOIN clin_consult.progressnotes ON diabetes_annual_cycle_of_care.fk_progressnote_components = progressnotes.pk
   JOIN admin.vwstaff vwstaff1 ON consult.fk_staff = vwstaff1.pk;

create View documents.vwdocuments as
 SELECT documents.pk AS pk_document, documents.source_file, documents.fk_sending_entity, documents.imported_time, documents.date_requested, documents.date_created, documents.fk_patient, documents.fk_staff_filed_document, documents.originator, documents.originator_reference, documents.copy_to, documents.provider_of_service_reference, documents.internal_reference, documents.copies_to, documents.fk_staff_destination, documents.comment_on_document, documents.patient_access, documents.concluded, documents.deleted, documents.fk_lu_urgency, documents.tag, documents.tag_user, documents.md5sum, documents.html, documents.fk_unmatched_staff, documents.fk_referral, documents.fk_request, documents.fk_unmatched_patient, documents.fk_lu_display_as, documents.fk_lu_request_type, lu_request_type.type AS request_type, vwsendingentities.fk_lu_request_type AS sending_entity_fk_lu_request_type, vwsendingentities.request_type AS sending_entity_request_type, vwsendingentities.style, vwsendingentities.message_type, vwsendingentities.message_version, vwsendingentities.msh_sending_entity, vwsendingentities.msh_transmitting_entity, vwsendingentities.fk_lu_message_display_style, vwsendingentities.fk_branch AS fk_sender_branch, vwsendingentities.fk_employee AS fk_employee_branch, vwsendingentities.fk_person AS fk_sender_person, vwsendingentities.fk_lu_message_standard, vwsendingentities.exclude_ft_report, vwsendingentities.abnormals_foreground_color, vwsendingentities.abnormals_background_color, vwsendingentities.exclude_pit, vwsendingentities.person_occupation, vwsendingentities.organisation, vwsendingentities.organisation_category, vwpatients.fk_person AS patient_fk_person, vwpatients.firstname AS patient_firstname, vwpatients.surname AS patient_surname, vwpatients.birthdate AS patient_birthdate, vwpatients.sex AS patient_sex, vwpatients.age_numeric AS patient_age, vwpatients.title AS patient_title, vwpatients.street1 AS patient_street1, vwpatients.street2 AS patient_street2, vwpatients.town AS patient_town, vwpatients.state AS patient_state, vwpatients.postcode AS patient_postcode, vwstaff.wholename AS staff_destination_wholename, vwstaff.title AS staff_destination_title, unmatched_patients.surname AS unmatched_patient_surname, unmatched_patients.firstname AS unmatched_patient_firstname, unmatched_patients.birthdate AS unmatched_patient_birthdate, unmatched_patients.sex AS unmatched_patient_sex, unmatched_patients.title AS unmatched_patient_title, unmatched_patients.street AS unmatched_patient_street, unmatched_patients.town AS unmatched_patient_town, unmatched_patients.postcode AS unmatched_patient_postcode, unmatched_patients.state AS unmatched_patient_state, unmatched_staff.surname AS unmatched_staff_surname, unmatched_staff.firstname AS unmatched_staff_firstname, unmatched_staff.title AS unmatched_staff_title, unmatched_staff.provider_number AS unmatched_staff_provider_number, documents.incoming_referral
   FROM documents.documents
   JOIN documents.vwsendingentities ON documents.fk_sending_entity = vwsendingentities.pk_sending_entities
   LEFT JOIN clin_requests.lu_request_type ON documents.fk_lu_request_type = lu_request_type.pk
   LEFT JOIN contacts.vwpatients ON documents.fk_patient = vwpatients.fk_patient
   LEFT JOIN admin.vwstaff ON documents.fk_staff_destination = vwstaff.fk_staff
   LEFT JOIN documents.unmatched_patients ON documents.fk_unmatched_patient = unmatched_patients.pk
   LEFT JOIN documents.unmatched_staff ON documents.fk_unmatched_staff = unmatched_staff.pk;

--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = admin, pg_catalog;

--
-- Name: vwstafftoolbarbuttons; Type: VIEW; Schema: admin; Owner: ian
--

CREATE VIEW vwstafftoolbarbuttons AS
    SELECT lu_clinical_modules.pk AS pk_module, staff_clinical_toolbar.pk AS fk_staff_clinical_toolbar, staff_clinical_toolbar.display_order, lu_clinical_modules.name, lu_clinical_modules.icon_path, staff_clinical_toolbar.fk_staff, staff_clinical_toolbar.deleted FROM staff_clinical_toolbar, vwstaff, lu_clinical_modules WHERE ((staff_clinical_toolbar.fk_staff = vwstaff.fk_staff) AND (staff_clinical_toolbar.fk_module = lu_clinical_modules.pk)) ORDER BY staff_clinical_toolbar.fk_staff, staff_clinical_toolbar.display_order;


ALTER TABLE admin.vwstafftoolbarbuttons OWNER TO easygp;

SET search_path = clin_requests, pg_catalog;

--
-- Name: vwrequestsordered; Type: VIEW; Schema: clin_requests; Owner: ian
--

CREATE VIEW vwrequestsordered AS
    SELECT ((forms.pk || '-'::text) || forms_requests.pk) AS pk_view, forms.fk_lu_request_type, lu_request_type.type, forms.fk_consult, consult.consult_date, consult.fk_patient, data_persons.firstname, data_persons.surname, data_persons.birthdate, data_persons.fk_sex, forms_requests.fk_form, forms.requests_summary, forms_requests.pk AS fk_forms_requests, lu_requests.item, forms.date, forms_requests.request_result_html, forms.fk_progressnote, forms_requests.fk_lu_request, forms_requests.deleted AS request_deleted, lu_requests.fk_laterality, lu_requests.fk_decision_support, lu_requests.fk_instruction, forms.fk_request_provider AS fk_branch, forms.notes_summary, forms.medications_summary, forms.copyto, forms.deleted, forms.copyto_patient, forms.urgent, forms.bulk_bill, forms.fasting, forms.phone, forms.fax, forms.include_medications, forms.pk_image AS fk_image, forms.fk_pasthistory, past_history.description, lu_title.title AS staff_title, staff.pk AS fk_staff, data_persons1.firstname AS staff_firstname, data_persons1.surname AS staff_surname, data_branches.branch, data_branches.fk_organisation, data_organisations.organisation, vwdocuments.html FROM (((((((((((((forms JOIN forms_requests ON ((forms.pk = forms_requests.fk_form))) JOIN lu_requests ON ((forms_requests.fk_lu_request = lu_requests.pk))) JOIN lu_request_type ON ((lu_requests.fk_lu_request_type = lu_request_type.pk))) JOIN clin_consult.consult ON ((forms.fk_consult = consult.pk))) JOIN clerical.data_patients ON ((consult.fk_patient = data_patients.pk))) JOIN contacts.data_persons ON ((data_patients.fk_person = data_persons.pk))) LEFT JOIN contacts.lu_title ON ((data_persons.fk_title = lu_title.pk))) JOIN admin.staff ON ((consult.fk_staff = staff.pk))) JOIN contacts.data_persons data_persons1 ON ((staff.fk_person = data_persons1.pk))) LEFT JOIN contacts.data_branches ON ((forms.fk_request_provider = data_branches.pk))) LEFT JOIN contacts.data_organisations ON ((data_branches.fk_organisation = data_organisations.pk))) LEFT JOIN clin_history.past_history ON ((forms.fk_pasthistory = past_history.pk))) LEFT JOIN documents.vwdocuments ON ((forms_requests.pk = vwdocuments.fk_request))) WHERE ((forms.deleted = false) AND (forms_requests.deleted = false)) ORDER BY consult.fk_patient, forms.date DESC, forms_requests.fk_form, lu_requests.item;


ALTER TABLE clin_requests.vwrequestsordered OWNER TO easygp;

SET search_path = documents, pg_catalog;

--
-- Name: vwhl7filesimported; Type: VIEW; Schema: documents; Owner: ian
--

CREATE VIEW vwhl7filesimported AS
    SELECT DISTINCT vwdocuments.source_file FROM vwdocuments WHERE (vwdocuments.md5sum IS NULL) ORDER BY vwdocuments.source_file;


ALTER TABLE documents.vwhl7filesimported OWNER TO easygp;

SET search_path = research, pg_catalog;

--
-- Name: vwmostrecenteyerelateddocuments; Type: VIEW; Schema: research; Owner: ian
--

CREATE VIEW vwmostrecenteyerelateddocuments AS
    SELECT DISTINCT ON (vwdocuments.fk_patient) vwdocuments.fk_patient AS pk_view, vwdocuments.fk_patient, vwdocuments.pk_document AS fk_document, vwdocuments.date_created, vwdocuments.deleted FROM documents.vwdocuments WHERE ((((((vwdocuments.organisation_category)::text ~~* '%ophthal%'::text) OR ((vwdocuments.organisation_category)::text ~~* '%optom%'::text)) OR (vwdocuments.person_occupation ~~* '%ophthal%'::text)) OR (vwdocuments.person_occupation ~~* '%optom%'::text)) AND (vwdocuments.deleted = false)) ORDER BY vwdocuments.fk_patient, vwdocuments.date_created DESC;


ALTER TABLE research.vwmostrecenteyerelateddocuments OWNER TO easygp;

--
-- Name: VIEW vwmostrecenteyerelateddocuments; Type: COMMENT; Schema: research; Owner: ian
--

COMMENT ON VIEW vwmostrecenteyerelateddocuments IS '
This is a view of the most recent eye related document found in the database.
Quite dependant on the user allocating an eye-related category.
Though not specific to diabetics, it is currently only used in FDiabetesResearch 
The view key pk_view=fk_patient so once we have all diabetic patients, the view 
yields their eye documents. I put in fk_patient only to remind anyone viewing the
data that pk_view = fk_patient
';


SET search_path = clin_requests, pg_catalog;

--
-- Name: vwrequestsordered; Type: ACL; Schema: clin_requests; Owner: ian
--

REVOKE ALL ON TABLE vwrequestsordered FROM PUBLIC;
GRANT SELECT ON TABLE vwrequestsordered TO staff;


SET search_path = documents, pg_catalog;

--
-- Name: vwhl7filesimported; Type: ACL; Schema: documents; Owner: ian
--

REVOKE ALL ON TABLE vwhl7filesimported FROM PUBLIC;
REVOKE ALL ON TABLE vwhl7filesimported FROM easygp;
GRANT ALL ON TABLE vwhl7filesimported TO easygp;
GRANT SELECT ON TABLE vwhl7filesimported TO staff;


SET search_path = research, pg_catalog;

--
-- Name: vwmostrecenteyerelateddocuments; Type: ACL; Schema: research; Owner: ian
--

REVOKE ALL ON TABLE vwmostrecenteyerelateddocuments FROM PUBLIC;
REVOKE ALL ON TABLE vwmostrecenteyerelateddocuments FROM easygp;
GRANT ALL ON TABLE vwmostrecenteyerelateddocuments TO easygp;
GRANT ALL ON TABLE vwmostrecenteyerelateddocuments TO staff;


--
-- PostgreSQL database dump complete
--


grant select on admin.vwstafftoolbarbuttons to staff;
grant select on clin_mentalhealth.vwmentalhealthplans to staff;
grant select on clin_prescribing.vwprescribeditems to staff;
grant select on clin_procedures.vwskinprocedures to staff;
grant select on clin_requests.vwrequestforms to staff;
grant select on clin_vaccination.vwvaccinesgiven to staff;
grant select on clin_workcover.vwworkcover to staff;
grant select on clin_recalls.vwrecallsdue to staff;
grant select on documents.vwdocuments to staff;
grant select on clin_referrals.vwreferrals to staff;
grant select on chronic_disease_management.vwdiabetescycleofcare to staff;
grant select on admin.vwstaff to staff;

truncate table db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 220);


