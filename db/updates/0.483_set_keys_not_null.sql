-- final work on constraining the database - setting some more not-null constratins
-- Ian's dump of keys with not null constraints from python mind_meld.py
-- I've commented out all those foreign keys which are allowed to be null or currently uncertain
-- ** HORST SEE NOTES BELOW ABOUT YOUR MENTAL HEALTH PLANS **** SO I'VE PUT THIS ONE RIGHT AT THE TOP
-- if you don't contrain it you will continue to have problems as I've not found the bug
ALTER TABLE contacts.data_employees ALTER COLUMN fk_occupation SET NOT NULL;
ALTER TABLE clin_recalls.recalls ALTER COLUMN fk_interval_unit SET NOT NULL;
ALTER TABLE clin_mentalhealth.mentalhealth_plan ALTER COLUMN fk_progressnote SET NOT NULL;
ALTER TABLE clin_pregnancy.ante_natal_care_summary ALTER COLUMN fk_staff_caring SET NOT NULL;
ALTER TABLE coding.generic_terms ALTER COLUMN fk_coding_system SET NOT NULL;
ALTER TABLE clin_vaccination.vaccinations ALTER COLUMN fk_schedule SET NOT NULL;
ALTER TABLE clin_vaccination.vaccinations ALTER COLUMN fk_progressnote SET NOT NULL;
ALTER TABLE clin_vaccination.vaccinations ALTER COLUMN fk_vaccine SET NOT NULL;
ALTER TABLE clin_requests.link_forms_requests_requests_results ALTER COLUMN fk_forms_requests SET NOT NULL;
ALTER TABLE drugbank.brands ALTER COLUMN fk_drug SET NOT NULL;
ALTER TABLE clin_mentalhealth.k10_results ALTER COLUMN fk_plan SET NOT NULL;
ALTER TABLE clin_mentalhealth.k10_results ALTER COLUMN fk_lu_k10_component SET NOT NULL;
ALTER TABLE clin_recalls.lu_templates ALTER COLUMN fk_lu_appointment_length SET NOT NULL;
ALTER TABLE clin_vaccination.lu_vaccines_in_schedule ALTER COLUMN fk_schedule SET NOT NULL;
ALTER TABLE clin_vaccination.lu_vaccines_in_schedule ALTER COLUMN fk_vaccine SET NOT NULL;
ALTER TABLE drugbank.patents ALTER COLUMN fk_drug SET NOT NULL;
ALTER TABLE clerical.data_patients ALTER COLUMN fk_lu_active_status SET NOT NULL;
ALTER TABLE clin_consult.dictations ALTER COLUMN fk_referral SET NOT NULL;
ALTER TABLE clin_consult.dictations ALTER COLUMN fk_progress_note SET NOT NULL;
ALTER TABLE clerical.data_patients ALTER COLUMN fk_lu_default_billing_level SET NOT NULL;
ALTER TABLE documents.documents ALTER COLUMN fk_lu_display_as SET NOT NULL;
ALTER TABLE documents.documents ALTER COLUMN fk_lu_urgency SET NOT NULL;
ALTER TABLE clerical.task_components ALTER COLUMN fk_staff_filed SET NOT NULL;
ALTER TABLE clerical.task_components ALTER COLUMN fk_urgency SET NOT NULL;
ALTER TABLE clerical.bookings ALTER COLUMN fk_lu_appointment_status SET NOT NULL;
ALTER TABLE drugbank.pregnancy_code ALTER COLUMN fk_drug SET NOT NULL;
ALTER TABLE contacts.links_employees_comms ALTER COLUMN fk_comm SET NOT NULL;
ALTER TABLE contacts.links_employees_comms ALTER COLUMN fk_employee SET NOT NULL;
ALTER TABLE billing.payments_received ALTER COLUMN fk_lu_payment_method SET NOT NULL;
ALTER TABLE billing.payments_received ALTER COLUMN fk_staff_receipted SET NOT NULL;
ALTER TABLE clin_history.recreational_drugs ALTER COLUMN fk_lu_route_administration SET NOT NULL;
ALTER TABLE contacts.links_persons_comms ALTER COLUMN fk_comm SET NOT NULL;
ALTER TABLE contacts.links_persons_comms ALTER COLUMN fk_person SET NOT NULL;
ALTER TABLE drugbank.food_interactions ALTER COLUMN fk_drug SET NOT NULL;
ALTER TABLE drugbank.synonyms ALTER COLUMN fk_drug SET NOT NULL;
ALTER TABLE clin_prescribing.prescribed ALTER COLUMN fk_lu_pbs_script_type SET NOT NULL;
ALTER TABLE clin_prescribing.prescribed ALTER COLUMN fk_brand SET NOT NULL;
ALTER TABLE clin_prescribing.prescribed ALTER COLUMN fk_prescribed_for SET NOT NULL;
ALTER TABLE clin_requests.user_provider_defaults ALTER COLUMN fk_request_provider SET NOT NULL;
ALTER TABLE clin_procedures.staff_skin_procedure_defaults ALTER COLUMN fk_user_provider_defaults SET NOT NULL;
ALTER TABLE clin_procedures.staff_skin_procedure_defaults ALTER COLUMN fk_lu_skin_preparation SET NOT NULL;
ALTER TABLE clin_procedures.staff_skin_procedure_defaults ALTER COLUMN fk_staff SET NOT NULL;
ALTER TABLE clin_procedures.staff_skin_procedure_defaults ALTER COLUMN fk_lu_repair_type SET NOT NULL;
ALTER TABLE clin_procedures.staff_skin_procedure_defaults ALTER COLUMN fk_subcutaneous_suture SET NOT NULL;
ALTER TABLE clin_procedures.staff_skin_procedure_defaults ALTER COLUMN fk_skin_suture SET NOT NULL;
ALTER TABLE clin_procedures.staff_skin_procedure_defaults ALTER COLUMN fk_lu_anaesthetic_agent SET NOT NULL;
ALTER TABLE clin_procedures.staff_skin_procedure_defaults ALTER COLUMN fk_lu_procedure_type SET NOT NULL;
ALTER TABLE clin_recalls.recalls ALTER COLUMN fk_progressnote SET NOT NULL;
ALTER TABLE clin_history.gp_management_plans ALTER COLUMN fk_progressnote SET NOT NULL;
ALTER TABLE drugbank.drug_interactions ALTER COLUMN fk_drug SET NOT NULL;
ALTER TABLE drugbank.drug_interactions ALTER COLUMN fk_interacts_with SET NOT NULL;
ALTER TABLE drugbank.external_links ALTER COLUMN fk_drug SET NOT NULL;
ALTER TABLE drugbank.external_links ALTER COLUMN fk_external_resource SET NOT NULL;
ALTER TABLE contacts.data_persons ALTER COLUMN fk_sex SET NOT NULL;
ALTER TABLE contacts.data_persons ALTER COLUMN fk_marital SET NOT NULL;
ALTER TABLE contacts.data_persons ALTER COLUMN fk_title SET NOT NULL;
ALTER TABLE clerical.tasks ALTER COLUMN fk_staff_filed_task SET NOT NULL;
ALTER TABLE clin_referrals.referrals ALTER COLUMN fk_lu_urgency SET NOT NULL;
ALTER TABLE clin_referrals.referrals ALTER COLUMN fk_type SET NOT NULL;
ALTER TABLE clin_consult.consult ALTER COLUMN fk_type SET NOT NULL;
ALTER TABLE contacts.links_persons_addresses ALTER COLUMN fk_person SET NOT NULL;
ALTER TABLE contacts.links_persons_addresses ALTER COLUMN fk_address SET NOT NULL;
ALTER TABLE clin_requests.forms_requests ALTER COLUMN fk_form SET NOT NULL;
ALTER TABLE clin_history.family_conditions ALTER COLUMN fk_progressnote SET NOT NULL;
ALTER TABLE clin_history.family_conditions ALTER COLUMN fk_code SET NOT NULL;
ALTER TABLE clin_history.family_conditions ALTER COLUMN fk_consult SET NOT NULL;
ALTER TABLE clin_consult.progressnotes ALTER COLUMN fk_consult SET NOT NULL;
ALTER TABLE clin_consult.progressnotes ALTER COLUMN fk_section SET NOT NULL;
ALTER TABLE clin_consult.progressnotes ALTER COLUMN fk_audit_action SET NOT NULL;
ALTER TABLE drugbank.general_references ALTER COLUMN fk_drug SET NOT NULL;
ALTER TABLE contacts.data_branches ALTER COLUMN fk_category SET NOT NULL;
ALTER TABLE contacts.data_branches ALTER COLUMN fk_organisation SET NOT NULL;
ALTER TABLE clin_history.past_history ALTER COLUMN fk_code SET NOT NULL;
ALTER TABLE clin_mentalhealth.clozapine_record ALTER COLUMN fk_clozapine_details SET NOT NULL;
ALTER TABLE clin_mentalhealth.clozapine_record ALTER COLUMN fk_observation_white_cell_count SET NOT NULL;
ALTER TABLE contacts.data_employees ALTER COLUMN fk_status SET NOT NULL;
ALTER TABLE contacts.data_employees ALTER COLUMN fk_person SET NOT NULL;
ALTER TABLE contacts.data_employees ALTER COLUMN fk_branch SET NOT NULL;
ALTER TABLE clin_procedures.skin_procedures ALTER COLUMN fk_branch SET NOT NULL;
ALTER TABLE clin_procedures.skin_procedures ALTER COLUMN fk_lu_repair_type SET NOT NULL;
ALTER TABLE clin_procedures.skin_procedures ALTER COLUMN fk_progressnote_auto SET NOT NULL;
ALTER TABLE clin_procedures.skin_procedures ALTER COLUMN fk_provisional_diagnosis SET NOT NULL;
ALTER TABLE clin_procedures.skin_procedures ALTER COLUMN fk_lu_anaesthetic_agent SET NOT NULL;
ALTER TABLE clin_procedures.skin_procedures ALTER COLUMN fk_form SET NOT NULL;
ALTER TABLE clin_procedures.skin_procedures ALTER COLUMN fk_document SET NOT NULL;
ALTER TABLE clin_procedures.skin_procedures ALTER COLUMN fk_pasthistory SET NOT NULL;
ALTER TABLE clin_procedures.skin_procedures ALTER COLUMN fk_lu_procedure_type SET NOT NULL;
ALTER TABLE clin_procedures.skin_procedures ALTER COLUMN fk_subcutaneous_suture SET NOT NULL;
ALTER TABLE clin_procedures.skin_procedures ALTER COLUMN fk_actual_diagnosis SET NOT NULL;
ALTER TABLE clin_procedures.skin_procedures ALTER COLUMN fk_lu_skin_preparation SET NOT NULL;
ALTER TABLE clin_procedures.skin_procedures ALTER COLUMN fk_lu_anterior_posterior SET NOT NULL;
ALTER TABLE clin_procedures.skin_procedures ALTER COLUMN fk_progressnote_user SET NOT NULL;
ALTER TABLE clin_procedures.skin_procedures ALTER COLUMN fk_skin_suture SET NOT NULL;
ALTER TABLE clin_procedures.skin_procedures ALTER COLUMN fk_lu_lateralisation SET NOT NULL;
ALTER TABLE clin_mentalhealth.mentalhealth_plan ALTER COLUMN fk_lu_risk_to_others SET NOT NULL;
ALTER TABLE clin_mentalhealth.mentalhealth_plan ALTER COLUMN fk_code SET NOT NULL;
ALTER TABLE clin_mentalhealth.mentalhealth_plan ALTER COLUMN fk_coding_system SET NOT NULL;
ALTER TABLE clin_mentalhealth.mentalhealth_plan ALTER COLUMN fk_lu_plan_type SET NOT NULL;
ALTER TABLE drugs.link_category_info ALTER COLUMN fk_category SET NOT NULL;
ALTER TABLE drugs.link_category_info ALTER COLUMN fk_info SET NOT NULL;
ALTER TABLE clin_pregnancy.pregnancies ALTER COLUMN fk_lu_sex SET NOT NULL;
ALTER TABLE clin_workcover.visits ALTER COLUMN fk_code SET NOT NULL;
ALTER TABLE clin_workcover.visits ALTER COLUMN fk_coding_system SET NOT NULL;
ALTER TABLE clin_workcover.visits ALTER COLUMN fk_progressnote SET NOT NULL;
ALTER TABLE clin_workcover.visits ALTER COLUMN fk_consult SET NOT NULL;
ALTER TABLE clin_measurements.inr_plan ALTER COLUMN fk_lu_reason_anticoagulant_use SET NOT NULL;
ALTER TABLE drugbank.salts ALTER COLUMN fk_drug SET NOT NULL;
ALTER TABLE clin_recalls.sent ALTER COLUMN fk_staff SET NOT NULL;
ALTER TABLE drugbank.link_drug_to_dosage ALTER COLUMN fk_drug SET NOT NULL;
ALTER TABLE drugbank.link_drug_to_dosage ALTER COLUMN fk_dosage SET NOT NULL;
ALTER TABLE clin_measurements.lu_type ALTER COLUMN fk_unit SET NOT NULL;
ALTER TABLE clin_certificates.medical_certificates ALTER COLUMN fk_lu_fitness SET NOT NULL;
ALTER TABLE drugs.info ALTER COLUMN fk_clinical_effect SET NOT NULL;
ALTER TABLE drugs.info ALTER COLUMN fk_patient_category SET NOT NULL;
ALTER TABLE drugs.info ALTER COLUMN fk_pharmacologic_mechanism SET NOT NULL;
ALTER TABLE drugs.info ALTER COLUMN fk_severity SET NOT NULL;
ALTER TABLE documents.observations ALTER COLUMN fk_document SET NOT NULL;
ALTER TABLE clin_vaccination.lu_vaccines ALTER COLUMN fk_route SET NOT NULL;
ALTER TABLE clin_vaccination.lu_vaccines ALTER COLUMN fk_form SET NOT NULL;
ALTER TABLE clin_vaccination.lu_vaccines ALTER COLUMN fk_description SET NOT NULL;
ALTER TABLE clin_procedures.lu_suture_type ALTER COLUMN fk_lu_site SET NOT NULL;
ALTER TABLE drugbank.link_drug_to_atc_code ALTER COLUMN fk_drug SET NOT NULL;
ALTER TABLE drugbank.link_drug_to_atc_code ALTER COLUMN fk_atc_code SET NOT NULL;
ALTER TABLE contacts.links_branches_comms ALTER COLUMN fk_comm SET NOT NULL;
ALTER TABLE contacts.links_branches_comms ALTER COLUMN fk_branch SET NOT NULL;
ALTER TABLE drugbank.link_drug_to_category ALTER COLUMN fk_drug SET NOT NULL;
ALTER TABLE drugbank.link_drug_to_category ALTER COLUMN fk_category SET NOT NULL;
ALTER TABLE clin_vaccination.vaccine_serial_numbers ALTER COLUMN fk_vaccine SET NOT NULL;
ALTER TABLE billing.invoices ALTER COLUMN fk_lu_bulk_billing_type SET NOT NULL;
ALTER TABLE clin_history.occupational_history ALTER COLUMN fk_progressnote SET NOT NULL;
ALTER TABLE clin_certificates.medical_certificates ALTER COLUMN fk_progressnote SET NOT NULL;
ALTER TABLE chronic_disease_management.diabetes_annual_cycle_of_care ALTER COLUMN fk_progressnote SET NOT NULL;

ALTER TABLE clin_measurements.inr_plan ALTER COLUMN fk_progressnote SET NOT NULL;

ALTER TABLE clin_history.past_history ALTER COLUMN fk_progressnote SET NOT NULL;

------------------------------------------------------------------------------------------------------------------------
-- THESE BELOW HERE PROBABLY SHOULD NOT BE CONSTRAINED AS CAN BE NULL I'VE CHECKED THEM ALL, SOMETIMES ADDED COMMENTS --
------------------------------------------------------------------------------------------------------------------------
-- have put on the back-burner ALTER TABLE clin_history.team_care_members ALTER COLUMN fk_lu_allied_health_care_type SET NOT NULL;
-- CHECK WITH IAN ALTER TABLE documents.documents ALTER COLUMN fk_staff_destination SET NOT NULL;  
-- CHECKED AGAINST BACK END AND OMMITTED  ALTER TABLE clin_history.team_care_members ALTER COLUMN fk_document_gp_management_plan SET NOT NULL; (not all team care members get a copy of the plan)
-- lEFT OUT UNTIL I decide ALTER TABLE contacts.data_addresses ALTER COLUMN fk_town SET NOT NULL;
--  CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_history.team_care_members ALTER COLUMN fk_document_tca SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE contacts.data_branches ALTER COLUMN fk_address SET NOT NULL
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_history.team_care_members ALTER COLUMN fk_document_allied_health_form SET NOT NULL; (only not null if a TCA was done)
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_consult.progressnotes ALTER COLUMN fk_audit_reason SET NOT NULL;
-- lEFT OUT UNTIL IAN DECDIES IF NEEDED ALTER TABLE drugs.product ALTER COLUMN fk_schedule SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE documents.sending_entities ALTER COLUMN fk_branch SET NOT NULL; (may be null)
-- sCHECKED AGAINST BACK END AND OMMITTED ALTER TABLE documents.sending_entities ALTER COLUMN fk_lu_request_type SET NOT NULL; (can be null eg letters)
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_requests.lu_requests ALTER COLUMN fk_laterality SET NOT NULL; (many requests not lateralised)
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE contacts.data_addresses ALTER COLUMN fk_lu_address_type SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE admin.global_preferences ALTER COLUMN fk_staff SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED - will be null if letter was not finalised or is deleted ALTER TABLE clin_referrals.referrals ALTER COLUMN fk_progressnote SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_allergies.allergies ALTER COLUMN fk_coding_system SET NOT NULL (not needed if nil_allergies_sensitivies is not null;
-- CHECKED AGAINST BACK END AND OMMITTED clin_allergies.allergies ALTER COLUMN fk_lu_reaction_type SET NOT NULL; (these can be null)
-- CHECKED AGAINST BACK END AND OMMITTED  ALTER TABLE clin_allergies.allergies ALTER COLUMN fk_code SET NOT NULL; (this can be null)
-- user has the option not to code ALTER TABLE clin_certificates.medical_certificates ALTER COLUMN fk_coding_system SET NOT NULL;
-- user has the option not to code ALTER TABLE clin_certificates.medical_certificates ALTER COLUMN fk_code SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE blobs.images ALTER COLUMN fk_consult SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE drugs.brand ALTER COLUMN fk_company SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_pregnancy.ante_natal_care_summary ALTER COLUMN fk_subreligion SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_pregnancy.ante_natal_care_summary ALTER COLUMN fk_religion SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_vaccination.vaccinations ALTER COLUMN fk_laterality SET NOT NULL; may have no laterality
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_vaccination.vaccinations ALTER COLUMN fk_site SET NOT NULL;       may be null (unknown)
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE chronic_disease_management.diabetes_group_allied_health_services ALTER COLUMN fk_person SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE chronic_disease_management.diabetes_group_allied_health_services ALTER COLUMN fk_employee SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE chronic_disease_management.diabetes_group_allied_health_services ALTER COLUMN fk_branch SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED LTER TABLE public.external_links ALTER COLUMN fk_external_resource SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_history.family_members ALTER COLUMN fk_occupation SET NOT NULL; usually  have no occupation
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_history.family_members ALTER COLUMN fk_country_birth SET NOT NULL; usually have no country of birth
-- CHECKED AGAINST BACK END AND OMMITTEDALTER TABLE contacts.data_numbers ALTER COLUMN fk_branch SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTEDALTER TABLE contacts.data_numbers ALTER COLUMN fk_person SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clerical.task_component_notes ALTER COLUMN fk_staff_made_note SET NOT NULL; may be null if note not made yet
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clerical.data_patients ALTER COLUMN fk_lu_centrelink_card_type SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clerical.data_patients ALTER COLUMN fk_payer_person SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clerical.data_patients ALTER COLUMN fk_lu_aboriginality SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clerical.data_patients ALTER COLUMN fk_branch_pharmacy SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clerical.data_patients ALTER COLUMN fk_lu_veteran_card_type SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clerical.data_patients ALTER COLUMN fk_family SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clerical.data_patients ALTER COLUMN fk_lu_private_health_fund SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clerical.data_patients ALTER COLUMN fk_source_program SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clerical.data_patients ALTER COLUMN fk_next_of_kin SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clerical.data_patients ALTER COLUMN fk_payer_branch SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE documents.documents ALTER COLUMN fk_staff_filed_document SET NOT NULL; -- CHECKED AGAINST BACK END AND OMMITTED is null if not filed
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE documents.documents ALTER COLUMN fk_unmatched_patient SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED  ALTER TABLE documents.documents ALTER COLUMN fk_lu_data_content_type SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE documents.documents ALTER COLUMN fk_lu_request_type SET NOT NULL;  can be null, not all docs are requests
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE documents.documents ALTER COLUMN fk_patient SET NOT NULL;  -- CHECKED AGAINST BACK END AND OMMITTED can be a non patient document
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE documents.documents ALTER COLUMN fk_referral SET NOT NULL; can be null
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE documents.documents ALTER COLUMN fk_unmatched_staff SET NOT NULL; can be null
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE documents.documents ALTER COLUMN fk_request SET NOT NULL; can be null, currently not used
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clerical.task_components ALTER COLUMN fk_staff_allocated SET NOT NULL; may be null with a generic role
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clerical.task_components ALTER COLUMN fk_role SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clerical.task_components ALTER COLUMN fk_staff_completed SET NOT NULL; (inter staff task has no fk_consult)
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clerical.task_components ALTER COLUMN fk_consult SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_mentalhealth.team_care_members ALTER COLUMN fk_branch SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_mentalhealth.team_care_members ALTER COLUMN fk_person SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_mentalhealth.team_care_members ALTER COLUMN fk_organisation SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_mentalhealth.team_care_members ALTER COLUMN fk_employee SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE documents.unmatched_patients ALTER COLUMN fk_real_patient SET NOT NULL; can be null if not yet matched
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clerical.bookings ALTER COLUMN fk_lu_reason_not_billed SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clerical.bookings ALTER COLUMN fk_lu_appointment_icon SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clerical.bookings ALTER COLUMN fk_patient SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_history.recreational_drugs ALTER COLUMN fk_lu_substance_frequency SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_history.recreational_drugs ALTER COLUMN fk_lu_substance_amount_units SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_measurements.patients_defaults ALTER COLUMN fk_lu_type SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE ALTER TABLE clin_consult.lu_audit_reasons ALTER COLUMN fk_staff SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED  ALTER TABLE clin_measurements.inr_dose_management ALTER COLUMN fk_progressnote SET NOT NULL; RICHARD TO REVIEW THIS
-- RICHARD I DON'T THIK WE USE THIS FIED: ALTER TABLE clin_prescribing.prescribed ALTER COLUMN fk_progress_note SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_recalls.recalls ALTER COLUMN fk_sent SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_recalls.recalls ALTER COLUMN fk_template SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTEDALTER TABLE clerical.tasks ALTER COLUMN fk_role_can_finalise SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTEDALTER TABLE clerical.tasks ALTER COLUMN fk_staff_must_finalise SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTEDALTER TABLE clerical.tasks ALTER COLUMN fk_staff_finalised_task SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clerical.tasks ALTER COLUMN fk_row SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_history.team_care_members ALTER COLUMN fk_person SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_history.team_care_members ALTER COLUMN fk_employee SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE contacts.data_persons ALTER COLUMN fk_language SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE contacts.data_persons ALTER COLUMN fk_ethnicity SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE contacts.data_persons ALTER COLUMN fk_occupation SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_referrals.referrals ALTER COLUMN fk_person SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_referrals.referrals ALTER COLUMN fk_branch SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_referrals.referrals ALTER COLUMN fk_address SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_referrals.referrals ALTER COLUMN fk_employee SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE contacts.data_persons ALTER COLUMN fk_image SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_history.team_care_members ALTER COLUMN fk_branch SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_requests.request_providers ALTER COLUMN fk_default_branch SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_requests.request_providers ALTER COLUMN fk_person SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_requests.request_providers ALTER COLUMN fk_headoffice_branch SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTEDALTER TABLE clin_requests.request_providers ALTER COLUMN fk_employee SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTEDALTER TABLE clin_consult.progressnotes ALTER COLUMN fk_row SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_allergies.allergies ALTER COLUMN fk_product SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_allergies.allergies ALTER COLUMN fk_brand SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_mentalhealth.clozapine_record ALTER COLUMN fk_observation_neutrophil_count SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_history.occupations_exposures ALTER COLUMN fk_lu_units SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_history.past_history ALTER COLUMN fk_laterality SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_history.social_history ALTER COLUMN fk_carer SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_history.social_history ALTER COLUMN fk_progressnote_confidential SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_history.social_history ALTER COLUMN fk_responsible_person SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_history.social_history ALTER COLUMN fk_staff_may_view_confidential SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE documents.unmatched_staff ALTER COLUMN fk_real_staff SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_history.link_pasthistory_providers ALTER COLUMN fk_person SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_history.link_pasthistory_providers ALTER COLUMN fk_employee SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_history.link_pasthistory_providers ALTER COLUMN fk_branch SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_pregnancy.pregnancies ALTER COLUMN fk_lu_blood_group SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE documents.sending_entities ALTER COLUMN fk_person SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE documents.sending_entities ALTER COLUMN fk_employee SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_pregnancy.pregnancies ALTER COLUMN fk_lu_placenta_position SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_pregnancy.pregnancies ALTER COLUMN fk_lu_onset_labour SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_pregnancy.pregnancies ALTER COLUMN fk_lu_delivery_type SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_pregnancy.pregnancies ALTER COLUMN fk_lu_rhesus_group SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_pregnancy.pregnancies ALTER COLUMN fk_lu_contraception_method SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_workcover.claims ALTER COLUMN fk_person SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_workcover.claims ALTER COLUMN fk_branch SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_workcover.claims ALTER COLUMN fk_occupation SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_pregnancy.scans ALTER COLUMN fk_blob SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_pregnancy.scans ALTER COLUMN fk_document SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clerical.inventory ALTER COLUMN fk_person_purchased_from SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clerical.inventory ALTER COLUMN fk_employee_purchased_from SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clerical.inventory ALTER COLUMN fk_image SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clerical.inventory ALTER COLUMN fk_branch_purchased_from SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE billing.invoices ALTER COLUMN fk_payer_person SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED LTER TABLE billing.invoices ALTER COLUMN fk_patient SET NOT NULL; ??check with IAN
-- CHECKED AGAINST BACK END AND OMMITTEDALTER TABLE billing.invoices ALTER COLUMN fk_payer_branch SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE billing.invoices ALTER COLUMN fk_claim SET NOT NULL; ??check with IAN
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE billing.invoices ALTER COLUMN fk_appointment SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE billing.lu_reports ALTER COLUMN fk_subreport SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_vaccination.lu_schedules ALTER COLUMN fk_season SET NOT NULL;
-- CHECKED AGAINST BACK END AND OMMITTED ALTER TABLE clin_requests.notes ALTER COLUMN fk_lu_type SET NOT NULL;

update db.lu_version set lu_minor = 483;
