-- in case grants info gets clobbered on database update
-- this is a grants table
-- we have it here
grant all on coding.usr_codes_weighting_pk_seq to staff;
grant all on coding.usr_codes_weighting to staff;
GRANT ALL ON TABLE admin.clinics TO staff;
GRANT ALL ON TABLE admin.link_staff_clinics TO staff;
GRANT ALL ON TABLE admin.staff TO staff;
GRANT ALL ON TABLE admin.vwclinics TO staff;
GRANT ALL ON TABLE admin.vwstaffinclinics TO staff;
ALTER TABLE "admin".staff_clinical_toolbar OWNER TO easygp;
GRANT ALL ON TABLE "admin".staff_clinical_toolbar TO easygp;
GRANT ALL ON TABLE "admin".staff_clinical_toolbar TO staff;

ALTER TABLE admin.vwstafftoolbarbuttons owner to easygp;
GRANT ALL ON TABLE admin.vwstafftoolbarbuttons to easygp;
GRANT ALL ON TABLE admin.vwstafftoolbarbuttons to staff;

GRANT ALL ON TABLE admin.vwstaff TO staff;
GRANT ALL ON TABLE clerical.data_families TO staff;
GRANT ALL ON TABLE clerical.data_family_members TO staff;
GRANT ALL ON TABLE clerical.data_patients TO staff;
GRANT ALL ON TABLE clin_allergies.allergies TO staff;
GRANT ALL ON TABLE clin_careplans.careplan_pages TO staff;
GRANT ALL ON TABLE clin_careplans.careplans TO staff;
GRANT ALL ON TABLE clin_careplans.component_task_due TO staff;
GRANT ALL ON TABLE clin_careplans.link_careplanpage_advice TO staff;
GRANT ALL ON TABLE clin_careplans.link_careplanpage_components TO staff;
GRANT ALL ON TABLE clin_careplans.link_careplanpages_careplan TO staff;
GRANT ALL ON TABLE clin_careplans.sample_plan TO staff;
GRANT ALL ON TABLE clin_careplans.test TO staff;
GRANT ALL ON TABLE clin_checkups.annual_checkup TO staff;
GRANT ALL ON TABLE clin_consult.consult TO staff;
GRANT ALL ON TABLE clin_consult.images TO staff;
GRANT ALL ON TABLE clin_consult.progressnotes TO staff;
GRANT ALL ON TABLE clin_consult.scratchpad TO staff;
GRANT ALL ON TABLE clin_consult.vwprogressnotes TO staff;
GRANT ALL ON TABLE clin_consult.vwscratchpad TO staff;
GRANT ALL ON TABLE clin_history.data_recreational_drugs TO staff;
GRANT ALL ON TABLE clin_history.family_conditions TO staff;
GRANT ALL ON TABLE clin_history.family_links TO staff;
GRANT ALL ON TABLE clin_history.family_members TO staff;
GRANT ALL ON TABLE clin_history.hospitalisations TO staff;
GRANT all ON TABLE clin_history.occupational_history TO staff;
GRANT ALL ON TABLE clin_history.past_history TO staff;
GRANT ALL ON TABLE clin_history.social_history TO staff;
GRANT ALL ON TABLE clin_history.vwfamilyhistory TO staff;
GRANT ALL ON TABLE clin_history.vwhealthissues TO staff;
GRANT ALL ON TABLE clin_history.vwoccupationalhistory TO staff;
GRANT ALL ON TABLE clin_history.vwsocialhistory TO staff;
GRANT ALL ON TABLE clin_measurements.measurements TO staff;
GRANT ALL ON TABLE clin_measurements.patients_defaults TO staff;
GRANT ALL ON TABLE clin_measurements.vwmeasurements TO staff;
GRANT ALL ON TABLE clin_measurements.vwmeasurementtypes TO staff;
GRANT ALL ON TABLE clin_measurements.vwpatientsdefaults TO staff;

GRANT ALL ON TABLE clin_procedures.link_images_procedures TO staff;
GRANT ALL ON TABLE clin_procedures.lu_last_surgical_pack TO staff;
GRANT ALL ON TABLE clin_procedures.lu_procedure_type TO staff;
GRANT ALL ON TABLE clin_procedures.lu_repair_type TO staff;
GRANT ALL ON TABLE clin_procedures.lu_skin_preparation TO staff;
GRANT ALL ON TABLE clin_procedures.lu_suture_site TO staff;
GRANT ALL ON TABLE clin_procedures.lu_suture_type TO staff;
GRANT ALL ON TABLE clin_procedures.skin_procedures TO staff;
GRANT ALL ON TABLE clin_procedures.staff_skin_procedure_defaults TO staff;
GRANT ALL ON TABLE clin_procedures.surgical_packs TO staff;
GRANT ALL ON TABLE clin_procedures.vwimages TO staff;
GRANT ALL ON TABLE clin_procedures.vwskinprocedures TO staff;
GRANT ALL ON TABLE clin_procedures.vwsutures TO staff;
GRANT all ON TABLE clin_recalls.lu_templates TO staff;
GRANT ALL ON TABLE clin_recalls.recalls TO staff;
GRANT ALL ON TABLE clin_recalls.sent TO staff;
GRANT ALL ON TABLE clin_recalls.vwreasons TO staff;
GRANT ALL ON TABLE clin_recalls.vwrecalls TO staff;
GRANT ALL ON TABLE clin_referrals.referrals TO staff;
GRANT ALL ON TABLE clin_referrals.vwreferrals TO staff;
GRANT ALL ON TABLE clin_requests.forms_requests TO staff;
GRANT ALL ON TABLE clin_requests.link_forms_requests_requests_results TO staff;
GRANT ALL ON TABLE clin_requests.lu_copyto_type TO staff;
GRANT ALL ON TABLE clin_requests.lu_form_header TO staff;
GRANT ALL ON TABLE clin_requests.lu_requests TO staff;
GRANT ALL ON TABLE clin_requests.notes TO staff;
GRANT ALL ON TABLE clin_requests.user_default_type TO staff;
GRANT ALL ON TABLE clin_requests.user_provider_defaults TO staff;



GRANT ALL ON TABLE clin_requests.vwrequestforms TO staff;







GRANT ALL ON TABLE clin_vaccination.vaccinations TO staff;
GRANT ALL ON TABLE clin_vaccination.vwvaccines TO staff;
GRANT ALL ON TABLE clin_workcover.claims TO staff;
GRANT ALL ON TABLE clin_workcover.lu_caused_by_employment TO staff;
GRANT ALL ON TABLE clin_workcover.visits TO staff;
GRANT ALL ON TABLE clin_workcover.vwworkcover TO staff;
GRANT ALL ON TABLE contacts.data_addresses TO staff;
GRANT ALL ON TABLE contacts.data_branches TO staff;
GRANT ALL ON TABLE contacts.data_communications TO staff;
GRANT ALL ON TABLE contacts.data_employees TO staff;
GRANT ALL ON TABLE contacts.data_organisations TO staff;
GRANT ALL ON TABLE contacts.data_persons TO staff;
GRANT ALL ON TABLE contacts.links_branches_comms TO staff;
GRANT ALL ON TABLE contacts.links_employees_comms TO staff;
GRANT ALL ON TABLE contacts.links_persons_addresses TO staff;
GRANT ALL ON TABLE contacts.links_persons_comms TO staff;
GRANT ALL ON TABLE contacts.lu_categories_pk_seq TO staff;
GRANT ALL ON TABLE contacts.lu_categories TO staff;
GRANT all ON TABLE contacts.lu_misspelt_towns TO staff;
GRANT ALL ON TABLE contacts.lu_title TO staff;
GRANT ALL ON TABLE contacts.todo TO staff;
GRANT ALL ON TABLE contacts.vwbranchescomms TO staff;
GRANT ALL ON TABLE contacts.vworganisationsbycategory TO staff;
GRANT ALL ON TABLE contacts.vworganisationsemployees TO staff;
GRANT ALL ON TABLE contacts.vwpatients TO staff;
GRANT ALL ON TABLE contacts.vwpersonsaddresses TO staff;
GRANT ALL ON TABLE contacts.vwpersonscomms TO staff;
GRANT ALL ON TABLE contacts.vwtowns TO staff;
GRANT ALL ON TABLE defaults.hl7_inboxes TO staff;
GRANT all ON TABLE defaults.incoming_message_handling TO staff;
GRANT all ON TABLE defaults.lu_link_printer_task TO staff;
GRANT ALL ON TABLE defaults.lu_printer_host TO staff;
GRANT ALL ON TABLE defaults.lu_printer_task TO staff;
GRANT ALL ON TABLE defaults.script_coordinates TO staff;
GRANT ALL ON TABLE defaults.temp TO staff;
GRANT ALL ON TABLE defaults.vwprinterstasks TO staff;
GRANT select, insert ON TABLE blobs.blobs TO staff;
GRANT select, insert ON TABLE clin_allergies.lu_reaction TO staff;
GRANT select, insert ON TABLE clin_careplans.lu_advice TO staff;
GRANT select, insert ON TABLE clin_careplans.lu_aims TO staff;
GRANT select, insert ON TABLE clin_careplans.lu_components TO staff;
GRANT select, insert ON TABLE clin_careplans.lu_conditions TO staff;
GRANT select, insert ON TABLE clin_careplans.lu_education TO staff;
GRANT select, insert ON TABLE clin_careplans.lu_responsible TO staff;
GRANT select, insert ON TABLE clin_careplans.lu_tasks TO staff;
GRANT select, insert ON TABLE clin_history.lu_exposures TO staff;
GRANT select, insert ON TABLE clin_mentalhealth.team_care_members TO staff;
GRANT select, insert ON TABLE clin_pregnancy.lu_antenatal_venue TO staff;
GRANT select, insert ON TABLE clin_procedures.lu_anaesthetic_agent TO staff;
GRANT select, insert ON TABLE clin_procedures.lu_complications TO staff;
GRANT select, insert ON TABLE clin_recalls.links_forms TO staff;
GRANT select, insert ON TABLE clin_recalls.lu_reasons TO staff;
GRANT select, insert ON TABLE clin_recalls.lu_recall_intervals TO staff;
GRANT select, insert ON TABLE clin_requests.forms TO staff;
GRANT select, insert ON TABLE clin_requests.lu_instructions TO staff;
GRANT select, insert ON TABLE clin_requests.lu_link_provider_user_requests TO staff;
GRANT select, insert ON TABLE common.lu_anatomical_site TO staff;
GRANT select, insert ON TABLE common.lu_anterior_posterior TO staff;
GRANT select, insert ON TABLE common.lu_ethnicity TO staff;
GRANT select, insert ON TABLE contacts.images TO staff;
GRANT select, insert ON TABLE contacts.lu_firstnames TO staff;
GRANT select, insert ON TABLE contacts.lu_surnames TO staff;
GRANT select, insert ON TABLE documents.observations TO staff;
GRANT select, insert, update ON TABLE clin_checkups.over75 TO staff;
GRANT select, insert, update ON TABLE clin_history.care_plan_components_due TO staff;
GRANT select, insert, update ON TABLE clin_history.occupations_exposures TO staff;
GRANT select, insert, update ON TABLE clin_history.team_care_members TO staff;
GRANT select, insert, update ON TABLE clin_mentalhealth.k10_results TO staff;
GRANT select, insert, update ON TABLE clin_mentalhealth.mentalhealth_plan TO staff;
GRANT select, insert, update ON TABLE documents.documents TO staff;
GRANT select, insert, update  ON TABLE documents.sending_entities TO staff;
GRANT select, insert, update ON TABLE documents.signed_off TO staff;
GRANT select, insert, update ON TABLE documents.unmatched_patients TO staff;
GRANT select, insert, update ON TABLE documents.unmatched_staff TO staff;
grant select on clerical.lu_task_types to staff;
grant select on clerical.vwtaskscomponents to staff;
grant select on clin_recalls.vwrecallsdue to staff;
grant select on clin_requests.lu_request_type to staff;
grant select on clin_requests.vwrequestproviders to staff;
grant select on clin_requests.vwrequestsordered to staff;
grant select on coding.lu_loinc_abbrev to staff;
grant select on coding.lu_loinc to staff;
grant select on coding.vwcodesweighted to staff;
grant select on coding.vwgenericterms to staff;
GRANT select ON TABLE admin.clinic_rooms TO staff;
GRANT select ON TABLE admin.global_preferences TO staff;
GRANT select ON TABLE admin.lu_staff_roles TO staff;
GRANT select ON TABLE admin.lu_staff_status TO staff;
GRANT select ON TABLE admin.lu_staff_type TO staff;
GRANT select ON TABLE admin.vwclinicrooms TO staff;


GRANT select ON TABLE clin_allergies.lu_type TO staff;
GRANT select ON TABLE clin_certificates.lu_illness_temporality TO staff;
GRANT select ON TABLE clin_certificates.vwmedicalcertificates TO staff;
GRANT select ON TABLE clin_checkups.lu_nutrition_questions TO staff;
GRANT select ON TABLE clin_checkups.lu_state_of_health TO staff;
GRANT select ON TABLE clin_consult.lu_consult_type TO staff;
GRANT select ON TABLE clin_consult.lu_progressnotes_sections TO staff;
GRANT select ON TABLE clin_consult.lu_scratchpad_status TO staff;
GRANT select ON TABLE clin_history.lu_careplan_components TO staff;
GRANT select ON TABLE clin_history.lu_dacc_components TO staff;
GRANT select ON TABLE clin_history.vwcareplancomponentsdue TO staff;

GRANT select ON TABLE clin_history.vwteamcaremembers TO staff;
GRANT select ON TABLE clin_measurements.lu_type TO staff;
GRANT select ON TABLE clin_mentalhealth.lu_assessment_tools TO staff;
GRANT select ON TABLE clin_mentalhealth.lu_component_help TO staff;
GRANT select ON TABLE clin_mentalhealth.lu_depression_degree TO staff;
GRANT select ON TABLE clin_mentalhealth.lu_k10_components TO staff;
GRANT select ON TABLE clin_mentalhealth.lu_plan_type TO staff;
GRANT select ON TABLE clin_mentalhealth.lu_risk_to_others TO staff;
GRANT select ON TABLE clin_mentalhealth.vwk10results TO staff;
GRANT select ON TABLE clin_mentalhealth.vwmentalhealthplans TO staff;
GRANT select ON TABLE clin_mentalhealth.vwteamcaremembers TO staff;
GRANT select ON TABLE clin_procedures.vwstaffskinproceduredefaults TO staff;

GRANT select ON TABLE clin_referrals.lu_type TO staff;

GRANT select ON TABLE clin_requests.vwrequestsynonyms TO staff;

GRANT select ON TABLE clin_vaccination.lu_schedules TO staff;


GRANT select ON TABLE clin_vaccination.lu_vaccines_in_schedule TO staff;
GRANT select ON TABLE clin_vaccination.lu_vaccines TO staff;
GRANT select ON TABLE clin_workcover.lu_visit_type TO staff;
GRANT select ON TABLE coding.generic_terms TO staff;
GRANT select ON TABLE coding.lu_systems TO staff;
GRANT select ON TABLE common.lu_aboriginality TO staff;
GRANT select ON TABLE common.lu_anatomical_localisation TO staff;
GRANT select ON TABLE common.lu_appointment_length TO staff;
GRANT select ON TABLE common.lu_companion_status TO staff;
GRANT select ON TABLE common.lu_countries TO staff;
GRANT select ON TABLE common.lu_family_relationships TO staff;
GRANT SELECT ON TABLE common.lu_formulation TO staff;
GRANT select ON TABLE common.lu_hearing_aid_status TO staff;
GRANT SELECT ON TABLE common.lu_languages TO staff;
GRANT select ON TABLE common.lu_laterality TO staff;
GRANT SELECT ON TABLE common.lu_medicolegal TO staff;
GRANT SELECT ON TABLE common.lu_motion TO staff;
GRANT select ON TABLE common.lu_normality TO staff;
GRANT select,insert ON TABLE common.lu_occupations TO staff;
GRANT SELECT ON TABLE common.lu_proximal_distal TO staff;
GRANT SELECT ON TABLE common.lu_recreationaldrugs TO staff;
GRANT select ON TABLE common.lu_religions TO staff;
GRANT select ON TABLE common.lu_route_administration TO staff;
GRANT SELECT ON TABLE common.lu_seasons TO staff;
GRANT select ON TABLE common.lu_site_administration TO staff;
GRANT select ON TABLE common.lu_smoking_status TO staff;
GRANT select ON TABLE common.lu_social_support TO staff;
GRANT select ON TABLE common.lu_sub_religions TO staff;
GRANT select ON TABLE common.lu_units TO staff;
GRANT select ON TABLE common.lu_urgency TO staff;
GRANT select ON TABLE common.lu_whisper_test TO staff;
GRANT select ON TABLE common.vwreligions TO staff;
GRANT select ON TABLE contacts.lu_address_types TO staff;
GRANT SELECT ON TABLE contacts.lu_categories TO staff;
GRANT select ON TABLE contacts.lu_contact_type TO staff;
GRANT select ON TABLE contacts.lu_marital TO staff;
GRANT SELECT ON TABLE contacts.lu_sex TO staff;
GRANT select ON TABLE contacts.lu_towns TO staff;
GRANT select ON TABLE contacts.vwemployees TO staff;
GRANT select ON TABLE contacts.vwpersonsexcludingpatients TO staff;
GRANT select ON TABLE contacts.vwpersonsincludingpatients TO staff;
GRANT select ON TABLE contacts.vwpersons TO staff;
GRANT select ON TABLE db.lu_version TO staff;
GRANT select ON TABLE documents.lu_archive_site TO staff;
GRANT select ON TABLE documents.lu_message_display_style TO staff;
GRANT select ON TABLE documents.lu_message_standard TO staff;
GRANT select ON TABLE documents.vwdocuments TO staff;
GRANT select ON TABLE documents.vwgraphableobservations TO staff;
GRANT select ON TABLE documents.vwinboxstaff TO staff;
GRANT select ON TABLE documents.vwobservations TO staff;
GRANT select ON TABLE documents.vwsendingentities TO staff;
GRANT select ON TABLE import_export.lu_demographics_field_templates TO staff;
GRANT select ON TABLE import_export.lu_source_program TO staff;
GRANT select ON TABLE import_export.vwdemographictemplates TO staff;
grant usage on schema admin to staff;
grant usage on schema blobs to staff;
grant usage on schema clerical to staff;
grant usage on schema clin_allergies to staff;
grant usage on schema clin_careplans to staff;
grant usage on schema clin_certificates to staff;
grant usage on schema clin_checkups to staff;
grant usage on schema clin_consult to staff;
grant usage on schema clin_history to staff;
grant usage on schema clin_measurements to staff;
grant usage on schema clin_prescribing to staff;
grant usage on schema clin_procedures to staff;
grant usage on schema clin_recalls to staff;
grant usage on schema clin_referrals to staff;
grant usage on schema clin_requests to staff;
grant usage on schema clin_vaccination to staff;
grant usage on schema clin_workcover to staff;
grant usage on schema coding to staff;
grant usage on schema common to staff;
grant usage on schema contacts to staff;
grant usage on schema db to staff;
grant usage on schema defaults to staff;
grant usage on schema documents to staff;
grant usage on schema import_export to staff;
grant usage on schema maintenance to staff;
grant usage on schema research to staff;
 GRANT USAGE ON SEQUENCE admin.clinic_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE admin.link_staff_clinics_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE admin.staff_pk_seq TO staff;



GRANT USAGE ON SEQUENCE blobs.blobs_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clerical.data_families_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clerical.data_family_members_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clerical.data_patients_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_allergies.allergies_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_allergies.lu_reaction_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_allergies.lu_type_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_careplans.careplan_pages_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_careplans.careplans_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_careplans.component_task_due_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_careplans.link_careplanpage_advice_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_careplans.link_careplanpage_components_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_careplans.link_careplanpages_careplan_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_careplans.lu_advice_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_careplans.lu_aims_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_careplans.lu_components_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_careplans.lu_conditions_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_careplans.lu_education_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_careplans.lu_responsible_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_careplans.lu_tasks_pk_seq TO staff;
GRANT usage on SEQUENCE clin_certificates.lu_illness_temporality_pk_seq TO staff;
GRANT usage on SEQUENCE clin_certificates.medical_certificate_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_checkups.annual_checkup_pk_seq TO staff;
GRANT usage on SEQUENCE clin_checkups.lu_nutrition_questions_pk_seq TO staff;
GRANT usage on SEQUENCE clin_checkups.lu_state_of_health_pk_seq TO staff;
GRANT usage on SEQUENCE clin_checkups.over75_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_consult.consult_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_consult.images_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_consult.lu_progressnotes_sections_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_consult.lu_scratchpad_status_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_consult.progressnotes_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_consult.scratchpad_pk_seq TO staff;
GRANT usage on SEQUENCE clin_history.care_plan_components_due_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_history.data_recreational_drugs_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_history.family_conditions_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_history.family_links_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_history.family_members_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_history.hospitalisations_pk_seq TO staff;
GRANT usage on SEQUENCE clin_history.lu_dacc_components_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_history.lu_exposures_pk_seq TO staff;
GRANT usage on SEQUENCE clin_history.occupational_history_pk_seq TO staff;
GRANT usage on SEQUENCE clin_history.occupations_exposures_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_history.past_history_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_history.social_history_pk_seq TO staff;
GRANT usage on SEQUENCE clin_history.team_care_members_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_measurements.lu_type_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_measurements.measurements_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_measurements.patients_defaults_pk_seq TO staff;
GRANT usage on SEQUENCE clin_mentalhealth.k10_results_pk_seq TO staff;
GRANT usage on SEQUENCE clin_mentalhealth.lu_component_help_pk_seq TO staff;
GRANT usage on SEQUENCE clin_mentalhealth.lu_depression_degree_pk_seq TO staff;
GRANT usage on SEQUENCE clin_mentalhealth.lu_k10_components_pk_seq TO staff;
GRANT usage on SEQUENCE clin_mentalhealth.lu_plan_type_pk_seq TO staff;
GRANT usage on SEQUENCE clin_mentalhealth.lu_risk_to_others_pk_seq TO staff;
GRANT usage on SEQUENCE clin_mentalhealth.mentalhealth_plan_pk_seq TO staff;
GRANT usage on SEQUENCE clin_mentalhealth.team_care_members_pk_seq TO staff;
GRANT usage on SEQUENCE clin_pregnancy.lu_antenatal_venue_pk_seq TO staff;
 
 GRANT USAGE ON SEQUENCE clin_procedures.link_images_procedures_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_procedures.lu_anaesthetic_agent_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_procedures.lu_complications_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_procedures.lu_excision_type_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_procedures.lu_pack_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_procedures.lu_repair_type_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_procedures.lu_skin_preparation_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_procedures.lu_suture_site_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_procedures.lu_suture_type_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_procedures.skin_procedures_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_procedures.staff_skin_procedure_defaults_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_procedures.surgical_packs_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_recalls.links_forms_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_recalls.lu_reasons_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_recalls.lu_recall_intervals_pk_seq TO staff;
GRANT usage on SEQUENCE clin_recalls.lu_templates_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_recalls.recalls_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_recalls.sent_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_referrals.lu_type_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_referrals.referrals_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_requests.forms_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_requests.forms_requests_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_requests.link_forms_requests_requests_results_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_requests.lu_copyto_type_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_requests.lu_form_header_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_requests.lu_instructions_pk_seq TO staff;
GRANT usage on SEQUENCE clin_requests.lu_link_provider_user_requests_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_requests.lu_requests_pk_seq TO staff;

 GRANT USAGE ON SEQUENCE clin_requests.notes_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_requests.results_requests_episode_key TO staff;
 GRANT USAGE ON SEQUENCE clin_requests.user_default_type_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_requests.user_provider_defaults_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_requests.vwforms_pk_seq TO staff;




 GRANT USAGE ON SEQUENCE clin_vaccination.lu_schedules_pk_seq TO staff;

 GRANT USAGE ON SEQUENCE clin_vaccination.lu_vaccines_descriptions_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_vaccination.lu_vaccines_in_schedule_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_vaccination.lu_vaccines_pk_seq TO staff;



 GRANT USAGE ON SEQUENCE clin_workcover.claims_pk_seq TO staff;
  GRANT USAGE ON SEQUENCE clin_workcover.lu_caused_by_employment_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_workcover.lu_visit_type_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE clin_workcover.visits_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE common.lu_appointment_length_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE contacts.data_addresses_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE contacts.data_branches_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE contacts.data_communications_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE contacts.data_employees_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE contacts.data_organisations_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE contacts.data_persons_pk_seq TO staff;
GRANT usage on SEQUENCE contacts.images_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE contacts.links_branches_comms_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE contacts.links_employees_comms_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE contacts.links_persons_addresses_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE contacts.links_persons_comms_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE contacts.lu_firstnames_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE contacts.lu_surnames_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE contacts.lu_title_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE contacts.vworganisations_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE contacts.vwpatients_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE defaults.hl7_message_destination_pk_seq TO staff;
GRANT usage on SEQUENCE defaults.incoming_message_handling_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE defaults.lu_link_printer_task_pk_seq TO staff;
GRANT usage on SEQUENCE defaults.lu_message_display_style_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE defaults.lu_printer_host_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE defaults.lu_printer_task_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE defaults.script_coordinates_pk_seq TO staff;
 GRANT USAGE ON SEQUENCE defaults.temp_pk_seq TO staff;
GRANT usage on SEQUENCE documents.documents_pk_seq TO staff;
GRANT usage on SEQUENCE documents.lu_archive_site_pk_seq TO staff;
GRANT usage on SEQUENCE documents.lu_message_standard_pk_seq TO staff;
GRANT usage on SEQUENCE documents.observations_pk_seq TO staff;
GRANT usage on SEQUENCE documents.sending_entities_pk_seq TO staff;
GRANT usage on SEQUENCE documents.signed_off_pk_seq TO staff;
GRANT usage on SEQUENCE documents.unmatched_patients_pk_seq TO staff;
GRANT usage on SEQUENCE documents.unmatched_staff_pk_seq TO staff;
GRANT usage on SEQUENCE import_export.lu_demographics_field_templates_pk_seq TO staff;
GRANT usage on SEQUENCE import_export.lu_source_program_pk_seq TO staff;
grant all on admin.staff_clinical_toolbar to staff;
grant usage on admin.staff_clinical_toolbar_pk_seq to staff;
grant select on contacts.vwOrganisations to staff;
grant usage on clin_referrals.referrals_pk_seq to staff;
grant usage on sequence common.lu_occupations_pk_seq to staff;
grant select on clerical.vwappointments to staff;
grant all on clerical.bookings to staff;
grant all on clerical.sessions to staff;
grant all on clerical.bookings to staff;
grant all on clerical.sessions_pk_seq to staff;
grant all on clerical.bookings_pk_seq to staff;
grant all on clerical.schedule to staff;
grant all on clerical.prices to staff;
grant select on clerical.lu_billing_type to staff;
grant select on clerical.vwFees to staff;

alter table drugs.vwDrugs owner to easygp;
grant all on table drugs.vwDrugs to easygp;
grant select on drugs.vwDrugs to staff;

alter table drugs.vwdistinctbrandsforgenericproduct owner to easygp;
grant all on table drugs.vwdistinctbrandsforgenericproduct to easygp;
grant select on drugs.vwdistinctbrandsforgenericproduct to staff;

ALTER TABLE drugs.vwpbs OWNER TO easygp;
GRANT ALL ON TABLE drugs.vwpbs TO easygp;
GRANT ALL ON TABLE drugs.vwpbs TO staff;

ALTER TABLE drugs.vwGeneric OWNER TO easygp;
GRANT ALL ON TABLE drugs.vwGeneric TO easygp;
GRANT ALL ON TABLE drugs.vwGeneric TO staff;

alter schema drugs owner to easygp;
grant all on schema drugs to staff;

grant select on drugs.form to staff;

alter table drugs.form owner to easygp;
grant all on table drugs.form to easygp;
grant all on TABLE drugs.form to staff;


alter table drugs.product owner to easygp;
grant all on table drugs.product to easygp;
grant all on TABLE drugs.product to staff;

alter table drugs.brand owner to easygp;
grant all on table drugs.brand to easygp;
grant all on TABLE drugs.brand to staff;

alter table drugs.company owner to easygp;
grant all on table drugs.company to easygp;
grant all on TABLE drugs.company to staff;

ALTER TABLE drugs.evidence_levels OWNER TO easygp;
grant all on table drugs.evidence_levels to easygp;
grant all on TABLE drugs.evidence_levels to staff;

alter table drugs.atc owner to easygp;
grant all on table drugs.atc to easygp;
GRANT ALL ON TABLE drugs.atc to staff;

alter table drugs.flags owner to easygp;
grant all on table drugs.flags to easygp;
GRANT ALL ON TABLE drugs.flags to staff;

alter table drugs.info owner to easygp;
grant all on table drugs.info to easygp;
GRANT ALL ON TABLE drugs.info to staff;

ALTER TABLE drugs.link_atc_info OWNER TO easygp;
grant all on table drugs.link_atc_info to easygp;
GRANT ALL ON TABLE drugs.link_atc_info to staff;


ALTER TABLE drugs.link_category_info OWNER TO easygp;
grant all on table drugs.link_category_info to easygp;
GRANT ALL ON TABLE drugs.link_category_info to staff;


ALTER TABLE drugs.link_flag_product OWNER TO easygp;
grant all on table drugs.link_flag_product to easygp;
GRANT ALL ON TABLE drugs.link_flag_product to staff;

ALTER TABLE drugs.patient_categories OWNER TO easygp;
grant all on table drugs.patient_categories to easygp;
GRANT ALL ON TABLE drugs.patient_categories to staff;


ALTER TABLE drugs.pharmacologic_mechanisms OWNER TO easygp;
grant all on table drugs.pharmacologic_mechanisms to easygp;
GRANT ALL ON TABLE drugs.pharmacologic_mechanisms to staff;

ALTER TABLE drugs.severity_level OWNER TO easygp;
grant all on table drugs.severity_level to easygp;
GRANT ALL ON TABLE drugs.severity_level to staff;

ALTER TABLE drugs.sources OWNER TO easygp;
grant all on table drugs.sources to easygp;
GRANT ALL ON TABLE drugs.sources to staff;

ALTER TABLE drugs.topic OWNER TO easygp;
grant all on table drugs.topic to easygp;
GRANT ALL ON TABLE drugs.topic to staff;

ALTER TABLE drugs.product_information_unmatched OWNER TO easygp;
grant all on table drugs.product_information_unmatched to easygp;
GRANT ALL ON TABLE drugs.product_information_unmatched to staff;

ALTER TABLE drugs.pbs OWNER TO easygp;
grant all on table drugs.pbs to easygp;
GRANT ALL ON TABLE drugs.pbs to staff;

alter table drugs.chapters owner to easygp;
grant all on table drugs.chapters to easygp;
GRANT ALL ON TABLE drugs.chapters to staff;

ALTER TABLE drugs.clinical_effects OWNER TO easygp;
grant all on table drugs.clinical_effects to easygp;
GRANT ALL ON TABLE drugs.clinical_effects to staff;

alter table drugs.restriction owner to easygp;
grant all on table drugs.restriction to easygp;
GRANT ALL ON TABLE drugs.restriction to staff;

alter table drugs.schedules owner to easygp;
grant all on table drugs.schedules to easygp;
GRANT ALL ON TABLE drugs.schedules to staff;


GRANT all ON TABLE clin_prescribing.authority_number TO staff;
GRANT all ON TABLE clin_prescribing.instruction_habits_pk_seq TO staff;
GRANT all ON TABLE clin_prescribing.prescribed_for_pk_seq TO staff;
GRANT all ON TABLE clin_prescribing.instructions_pk_seq TO staff;
GRANT all ON TABLE clin_prescribing.medications_pk_seq TO staff;
GRANT all ON TABLE clin_prescribing.prescribed_for_habits TO staff;
GRANT all ON TABLE clin_prescribing.prescribed_for_habits_pk_seq TO staff;
GRANT all ON TABLE clin_prescribing.prescribed_pk_seq  TO staff;
GRANT all ON TABLE clin_prescribing.print_status_pk_seq TO staff;
GRANT all ON TABLE clin_prescribing.script_number TO staff;
GRANT ALL ON TABLE clin_prescribing.medications TO staff;
GRANT ALL ON TABLE clin_prescribing.instruction_habits to staff;
GRANT ALL on table clin_prescribing.vwInstructionHabits to staff;
GRANT ALL ON TABLE clin_prescribing.vwPrescribedForHabits to staff;
GRANT USAGE ON SEQUENCE clin_prescribing.medications_pk_seq TO staff;