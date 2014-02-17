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
-- Data for Name: lu_clinical_modules; Type: TABLE DATA; Schema: admin; Owner: easygp
--

COPY lu_clinical_modules (pk, name, icon_path, in_use) FROM stdin;
\.


--
-- Name: lu_clinical_modules_pk_seq; Type: SEQUENCE SET; Schema: admin; Owner: easygp
--

SELECT pg_catalog.setval('lu_clinical_modules_pk_seq', 1, false);


--
-- Data for Name: lu_preferences_defaults; Type: TABLE DATA; Schema: admin; Owner: easygp
--

COPY lu_preferences_defaults (pk, name, value, check_dir) FROM stdin;
\.


--
-- Name: lu_preferences_defaults_pk_seq; Type: SEQUENCE SET; Schema: admin; Owner: easygp
--

SELECT pg_catalog.setval('lu_preferences_defaults_pk_seq', 1, false);


--
-- Data for Name: lu_staff_roles; Type: TABLE DATA; Schema: admin; Owner: easygp
--

COPY lu_staff_roles (pk, role) FROM stdin;
\.


--
-- Name: lu_staff_roles_pk_seq; Type: SEQUENCE SET; Schema: admin; Owner: easygp
--

SELECT pg_catalog.setval('lu_staff_roles_pk_seq', 1, false);


--
-- Data for Name: lu_staff_status; Type: TABLE DATA; Schema: admin; Owner: easygp
--

COPY lu_staff_status (pk, status) FROM stdin;
\.


--
-- Name: lu_staff_status_pk_seq; Type: SEQUENCE SET; Schema: admin; Owner: easygp
--

SELECT pg_catalog.setval('lu_staff_status_pk_seq', 1, false);


--
-- Data for Name: lu_staff_type; Type: TABLE DATA; Schema: admin; Owner: easygp
--

COPY lu_staff_type (pk, type) FROM stdin;
\.


--
-- Name: lu_staff_type_pk_seq; Type: SEQUENCE SET; Schema: admin; Owner: easygp
--

SELECT pg_catalog.setval('lu_staff_type_pk_seq', 1, false);


SET search_path = billing, pg_catalog;

--
-- Data for Name: lu_billing_type; Type: TABLE DATA; Schema: billing; Owner: easygp
--

COPY lu_billing_type (pk, type) FROM stdin;
\.


--
-- Name: lu_billing_type_pk_seq; Type: SEQUENCE SET; Schema: billing; Owner: easygp
--

SELECT pg_catalog.setval('lu_billing_type_pk_seq', 1, false);


--
-- Data for Name: lu_bulk_billing_type; Type: TABLE DATA; Schema: billing; Owner: easygp
--

COPY lu_bulk_billing_type (pk, type) FROM stdin;
\.


--
-- Name: lu_bulk_billing_type_pk_seq; Type: SEQUENCE SET; Schema: billing; Owner: easygp
--

SELECT pg_catalog.setval('lu_bulk_billing_type_pk_seq', 1, false);


--
-- Data for Name: lu_default_billing_level; Type: TABLE DATA; Schema: billing; Owner: easygp
--

COPY lu_default_billing_level (pk, level) FROM stdin;
\.


--
-- Name: lu_default_billing_level_pk_seq; Type: SEQUENCE SET; Schema: billing; Owner: easygp
--

SELECT pg_catalog.setval('lu_default_billing_level_pk_seq', 1, false);


--
-- Data for Name: lu_invoice_comments; Type: TABLE DATA; Schema: billing; Owner: easygp
--

COPY lu_invoice_comments (pk, comment) FROM stdin;
\.


--
-- Name: lu_invoice_comments_pk_seq; Type: SEQUENCE SET; Schema: billing; Owner: easygp
--

SELECT pg_catalog.setval('lu_invoice_comments_pk_seq', 1, false);


--
-- Data for Name: lu_payment_method; Type: TABLE DATA; Schema: billing; Owner: easygp
--

COPY lu_payment_method (pk, method) FROM stdin;
\.


--
-- Name: lu_payment_method_pk_seq; Type: SEQUENCE SET; Schema: billing; Owner: easygp
--

SELECT pg_catalog.setval('lu_payment_method_pk_seq', 1, false);


--
-- Data for Name: lu_reasons_not_billed; Type: TABLE DATA; Schema: billing; Owner: easygp
--

COPY lu_reasons_not_billed (pk, reason) FROM stdin;
\.


--
-- Name: lu_reasons_not_billed_pk_seq; Type: SEQUENCE SET; Schema: billing; Owner: easygp
--

SELECT pg_catalog.setval('lu_reasons_not_billed_pk_seq', 1, false);


--
-- Data for Name: lu_reports; Type: TABLE DATA; Schema: billing; Owner: easygp
--

COPY lu_reports (pk, report_title) FROM stdin;
\.


--
-- Name: lu_reports_pk_seq; Type: SEQUENCE SET; Schema: billing; Owner: easygp
--

SELECT pg_catalog.setval('lu_reports_pk_seq', 1, false);


SET search_path = chronic_disease_management, pg_catalog;

--
-- Data for Name: lu_allied_health_type; Type: TABLE DATA; Schema: chronic_disease_management; Owner: easygp
--

COPY lu_allied_health_type (pk, type, item_number, deleted) FROM stdin;
\.


--
-- Name: lu_allied_health_type_pk_seq; Type: SEQUENCE SET; Schema: chronic_disease_management; Owner: easygp
--

SELECT pg_catalog.setval('lu_allied_health_type_pk_seq', 1, false);


--
-- Data for Name: lu_dacc_components; Type: TABLE DATA; Schema: chronic_disease_management; Owner: easygp
--

COPY lu_dacc_components (pk, fk_component) FROM stdin;
\.


--
-- Name: lu_dacc_components_pk_seq; Type: SEQUENCE SET; Schema: chronic_disease_management; Owner: easygp
--

SELECT pg_catalog.setval('lu_dacc_components_pk_seq', 1, false);


SET search_path = clerical, pg_catalog;

--
-- Data for Name: lu_active_status; Type: TABLE DATA; Schema: clerical; Owner: easygp
--

COPY lu_active_status (pk, status) FROM stdin;
\.


--
-- Name: lu_active_status_pk_seq; Type: SEQUENCE SET; Schema: clerical; Owner: easygp
--

SELECT pg_catalog.setval('lu_active_status_pk_seq', 1, false);


--
-- Data for Name: lu_appointment_icons; Type: TABLE DATA; Schema: clerical; Owner: easygp
--

COPY lu_appointment_icons (pk, appointment_type, icon_path) FROM stdin;
\.


--
-- Name: lu_appointment_icons_pk_seq; Type: SEQUENCE SET; Schema: clerical; Owner: easygp
--

SELECT pg_catalog.setval('lu_appointment_icons_pk_seq', 1, false);


--
-- Data for Name: lu_appointment_status; Type: TABLE DATA; Schema: clerical; Owner: easygp
--

COPY lu_appointment_status (pk, status) FROM stdin;
\.


--
-- Name: lu_appointment_status_pk_seq; Type: SEQUENCE SET; Schema: clerical; Owner: easygp
--

SELECT pg_catalog.setval('lu_appointment_status_pk_seq', 1, false);


--
-- Data for Name: lu_centrelink_card_type; Type: TABLE DATA; Schema: clerical; Owner: easygp
--

COPY lu_centrelink_card_type (pk, type) FROM stdin;
\.


--
-- Name: lu_centrelink_card_type_pk_seq; Type: SEQUENCE SET; Schema: clerical; Owner: easygp
--

SELECT pg_catalog.setval('lu_centrelink_card_type_pk_seq', 1, false);


--
-- Data for Name: lu_inventory_categories; Type: TABLE DATA; Schema: clerical; Owner: easygp
--

COPY lu_inventory_categories (pk, category) FROM stdin;
\.


--
-- Name: lu_inventory_categories_pk_seq; Type: SEQUENCE SET; Schema: clerical; Owner: easygp
--

SELECT pg_catalog.setval('lu_inventory_categories_pk_seq', 1, false);


--
-- Data for Name: lu_inventory_items; Type: TABLE DATA; Schema: clerical; Owner: easygp
--

COPY lu_inventory_items (pk, fk_lu_inventory_category, item) FROM stdin;
\.


--
-- Name: lu_inventory_items_pk_seq; Type: SEQUENCE SET; Schema: clerical; Owner: easygp
--

SELECT pg_catalog.setval('lu_inventory_items_pk_seq', 1, false);


--
-- Data for Name: lu_private_health_funds; Type: TABLE DATA; Schema: clerical; Owner: easygp
--

COPY lu_private_health_funds (pk, fund, name_abbrev, availability, states_available) FROM stdin;
\.


--
-- Name: lu_private_health_funds_pk_seq; Type: SEQUENCE SET; Schema: clerical; Owner: easygp
--

SELECT pg_catalog.setval('lu_private_health_funds_pk_seq', 1, false);


--
-- Data for Name: lu_task_types; Type: TABLE DATA; Schema: clerical; Owner: easygp
--

COPY lu_task_types (pk, type) FROM stdin;
\.


--
-- Name: lu_task_types_pk_seq; Type: SEQUENCE SET; Schema: clerical; Owner: easygp
--

SELECT pg_catalog.setval('lu_task_types_pk_seq', 1, false);


--
-- Data for Name: lu_veteran_card_type; Type: TABLE DATA; Schema: clerical; Owner: easygp
--

COPY lu_veteran_card_type (pk, type) FROM stdin;
\.


--
-- Name: lu_veteran_card_type_pk_seq; Type: SEQUENCE SET; Schema: clerical; Owner: easygp
--

SELECT pg_catalog.setval('lu_veteran_card_type_pk_seq', 1, false);


SET search_path = clin_allergies, pg_catalog;

--
-- Data for Name: lu_reaction_type; Type: TABLE DATA; Schema: clin_allergies; Owner: easygp
--

COPY lu_reaction_type (pk, type) FROM stdin;
\.


--
-- Name: lu_reaction_type_pk_seq; Type: SEQUENCE SET; Schema: clin_allergies; Owner: easygp
--

SELECT pg_catalog.setval('lu_reaction_type_pk_seq', 1, false);


SET search_path = clin_careplans, pg_catalog;

--
-- Data for Name: lu_advice; Type: TABLE DATA; Schema: clin_careplans; Owner: easygp
--

COPY lu_advice (pk, advice) FROM stdin;
\.


--
-- Name: lu_advice_pk_seq; Type: SEQUENCE SET; Schema: clin_careplans; Owner: easygp
--

SELECT pg_catalog.setval('lu_advice_pk_seq', 1, false);


--
-- Data for Name: lu_aims; Type: TABLE DATA; Schema: clin_careplans; Owner: easygp
--

COPY lu_aims (pk, aim) FROM stdin;
\.


--
-- Name: lu_aims_pk_seq; Type: SEQUENCE SET; Schema: clin_careplans; Owner: easygp
--

SELECT pg_catalog.setval('lu_aims_pk_seq', 1, false);


--
-- Data for Name: lu_components; Type: TABLE DATA; Schema: clin_careplans; Owner: easygp
--

COPY lu_components (pk, component) FROM stdin;
\.


--
-- Name: lu_components_pk_seq; Type: SEQUENCE SET; Schema: clin_careplans; Owner: easygp
--

SELECT pg_catalog.setval('lu_components_pk_seq', 1, false);


--
-- Data for Name: lu_conditions; Type: TABLE DATA; Schema: clin_careplans; Owner: easygp
--

COPY lu_conditions (pk, condition, fk_condition_code) FROM stdin;
\.


--
-- Name: lu_conditions_pk_seq; Type: SEQUENCE SET; Schema: clin_careplans; Owner: easygp
--

SELECT pg_catalog.setval('lu_conditions_pk_seq', 1, false);


--
-- Data for Name: lu_education; Type: TABLE DATA; Schema: clin_careplans; Owner: easygp
--

COPY lu_education (pk, education) FROM stdin;
\.


--
-- Name: lu_education_pk_seq; Type: SEQUENCE SET; Schema: clin_careplans; Owner: easygp
--

SELECT pg_catalog.setval('lu_education_pk_seq', 1, false);


--
-- Data for Name: lu_responsible; Type: TABLE DATA; Schema: clin_careplans; Owner: easygp
--

COPY lu_responsible (pk, responsible) FROM stdin;
\.


--
-- Name: lu_responsible_pk_seq; Type: SEQUENCE SET; Schema: clin_careplans; Owner: easygp
--

SELECT pg_catalog.setval('lu_responsible_pk_seq', 1, false);


--
-- Data for Name: lu_tasks; Type: TABLE DATA; Schema: clin_careplans; Owner: easygp
--

COPY lu_tasks (pk, task) FROM stdin;
\.


--
-- Name: lu_tasks_pk_seq; Type: SEQUENCE SET; Schema: clin_careplans; Owner: easygp
--

SELECT pg_catalog.setval('lu_tasks_pk_seq', 1, false);


SET search_path = clin_certificates, pg_catalog;

--
-- Data for Name: lu_fitness; Type: TABLE DATA; Schema: clin_certificates; Owner: easygp
--

COPY lu_fitness (pk, fitness) FROM stdin;
\.


--
-- Name: lu_fitness_pk_seq; Type: SEQUENCE SET; Schema: clin_certificates; Owner: easygp
--

SELECT pg_catalog.setval('lu_fitness_pk_seq', 1, false);


--
-- Data for Name: lu_illness_temporality; Type: TABLE DATA; Schema: clin_certificates; Owner: easygp
--

COPY lu_illness_temporality (pk, temporality) FROM stdin;
\.


--
-- Name: lu_illness_temporality_pk_seq; Type: SEQUENCE SET; Schema: clin_certificates; Owner: easygp
--

SELECT pg_catalog.setval('lu_illness_temporality_pk_seq', 1, false);


SET search_path = clin_checkups, pg_catalog;

--
-- Data for Name: lu_nutrition_questions; Type: TABLE DATA; Schema: clin_checkups; Owner: easygp
--

COPY lu_nutrition_questions (pk, question, red_flag_text) FROM stdin;
\.


--
-- Name: lu_nutrition_questions_pk_seq; Type: SEQUENCE SET; Schema: clin_checkups; Owner: easygp
--

SELECT pg_catalog.setval('lu_nutrition_questions_pk_seq', 1, false);


--
-- Data for Name: lu_state_of_health; Type: TABLE DATA; Schema: clin_checkups; Owner: easygp
--

COPY lu_state_of_health (pk, state_of_health) FROM stdin;
\.


--
-- Name: lu_state_of_health_pk_seq; Type: SEQUENCE SET; Schema: clin_checkups; Owner: easygp
--

SELECT pg_catalog.setval('lu_state_of_health_pk_seq', 1, false);


SET search_path = clin_consult, pg_catalog;

--
-- Name: lu_actions_pk_seq; Type: SEQUENCE SET; Schema: clin_consult; Owner: easygp
--

SELECT pg_catalog.setval('lu_actions_pk_seq', 1, false);


--
-- Data for Name: lu_audit_actions; Type: TABLE DATA; Schema: clin_consult; Owner: easygp
--

COPY lu_audit_actions (pk, action, insist_reason) FROM stdin;
\.


--
-- Data for Name: lu_audit_reasons; Type: TABLE DATA; Schema: clin_consult; Owner: easygp
--

COPY lu_audit_reasons (pk, fk_staff, reason) FROM stdin;
\.


--
-- Name: lu_audit_reasons_pk_seq; Type: SEQUENCE SET; Schema: clin_consult; Owner: easygp
--

SELECT pg_catalog.setval('lu_audit_reasons_pk_seq', 1, false);


--
-- Data for Name: lu_consult_type; Type: TABLE DATA; Schema: clin_consult; Owner: easygp
--

COPY lu_consult_type (pk, type, user_selectable) FROM stdin;
\.


--
-- Name: lu_consult_type_pk_seq; Type: SEQUENCE SET; Schema: clin_consult; Owner: easygp
--

SELECT pg_catalog.setval('lu_consult_type_pk_seq', 1, false);


--
-- Data for Name: lu_progressnote_templates; Type: TABLE DATA; Schema: clin_consult; Owner: easygp
--

COPY lu_progressnote_templates (pk, fk_staff, shared, name, deleted, template) FROM stdin;
\.


--
-- Name: lu_progressnote_templates_pk_seq; Type: SEQUENCE SET; Schema: clin_consult; Owner: easygp
--

SELECT pg_catalog.setval('lu_progressnote_templates_pk_seq', 1, false);


--
-- Data for Name: lu_progressnotes_sections; Type: TABLE DATA; Schema: clin_consult; Owner: easygp
--

COPY lu_progressnotes_sections (pk, section) FROM stdin;
\.


--
-- Name: lu_progressnotes_sections_pk_seq; Type: SEQUENCE SET; Schema: clin_consult; Owner: easygp
--

SELECT pg_catalog.setval('lu_progressnotes_sections_pk_seq', 20, false);


--
-- Data for Name: lu_shortcut_category; Type: TABLE DATA; Schema: clin_consult; Owner: easygp
--

COPY lu_shortcut_category (pk, category) FROM stdin;
\.


--
-- Data for Name: lu_shortcut; Type: TABLE DATA; Schema: clin_consult; Owner: easygp
--

COPY lu_shortcut (pk, fk_staff, shared, shortcut, expanded, fk_lu_shortcut_category) FROM stdin;
\.


--
-- Name: lu_shortcut_category_pk_seq; Type: SEQUENCE SET; Schema: clin_consult; Owner: easygp
--

SELECT pg_catalog.setval('lu_shortcut_category_pk_seq', 1, false);


--
-- Name: lu_shortcut_pk_seq; Type: SEQUENCE SET; Schema: clin_consult; Owner: easygp
--

SELECT pg_catalog.setval('lu_shortcut_pk_seq', 1, false);


SET search_path = clin_history, pg_catalog;

--
-- Data for Name: lu_careplan_components; Type: TABLE DATA; Schema: clin_history; Owner: easygp
--

COPY lu_careplan_components (pk, component) FROM stdin;
\.


--
-- Name: lu_careplan_components_pk_seq; Type: SEQUENCE SET; Schema: clin_history; Owner: easygp
--

SELECT pg_catalog.setval('lu_careplan_components_pk_seq', 1, false);


--
-- Data for Name: lu_dacc_components; Type: TABLE DATA; Schema: clin_history; Owner: easygp
--

COPY lu_dacc_components (pk, fk_component) FROM stdin;
\.


--
-- Name: lu_dacc_components_pk_seq; Type: SEQUENCE SET; Schema: clin_history; Owner: easygp
--

SELECT pg_catalog.setval('lu_dacc_components_pk_seq', 1, false);


--
-- Data for Name: lu_exposures; Type: TABLE DATA; Schema: clin_history; Owner: easygp
--

COPY lu_exposures (pk, exposure, fk_decision_support, deleted) FROM stdin;
\.


--
-- Name: lu_exposures_pk_seq; Type: SEQUENCE SET; Schema: clin_history; Owner: easygp
--

SELECT pg_catalog.setval('lu_exposures_pk_seq', 1, false);


SET search_path = clin_measurements, pg_catalog;

--
-- Data for Name: lu_reason_anticoagulant_use; Type: TABLE DATA; Schema: clin_measurements; Owner: easygp
--

COPY lu_reason_anticoagulant_use (pk, reason, fk_code) FROM stdin;
\.


--
-- Name: lu_reason_anticoagulant_use_pk_seq; Type: SEQUENCE SET; Schema: clin_measurements; Owner: easygp
--

SELECT pg_catalog.setval('lu_reason_anticoagulant_use_pk_seq', 1, false);


--
-- Data for Name: lu_type; Type: TABLE DATA; Schema: clin_measurements; Owner: easygp
--

COPY lu_type (pk, name_abbreviated, code, name_full, input_key_restriction, input_mask, fk_unit, unit_qualifier, upper_limit, lower_limit, fk_decision_support, fk_plotting_method) FROM stdin;
\.


--
-- Name: lu_type_pk_seq; Type: SEQUENCE SET; Schema: clin_measurements; Owner: easygp
--

SELECT pg_catalog.setval('lu_type_pk_seq', 1, false);


SET search_path = clin_mentalhealth, pg_catalog;

--
-- Data for Name: lu_assessment_tools; Type: TABLE DATA; Schema: clin_mentalhealth; Owner: easygp
--

COPY lu_assessment_tools (pk_tool, tool, tool_about, name_abbrev) FROM stdin;
\.


--
-- Name: lu_assessment_tools_pk_tool_seq; Type: SEQUENCE SET; Schema: clin_mentalhealth; Owner: easygp
--

SELECT pg_catalog.setval('lu_assessment_tools_pk_tool_seq', 1, false);


--
-- Data for Name: lu_component_help; Type: TABLE DATA; Schema: clin_mentalhealth; Owner: easygp
--

COPY lu_component_help (pk, care_plan_component, component_help) FROM stdin;
\.


--
-- Name: lu_component_help_pk_seq; Type: SEQUENCE SET; Schema: clin_mentalhealth; Owner: easygp
--

SELECT pg_catalog.setval('lu_component_help_pk_seq', 1, false);


--
-- Data for Name: lu_depression_degree; Type: TABLE DATA; Schema: clin_mentalhealth; Owner: easygp
--

COPY lu_depression_degree (pk, degree) FROM stdin;
\.


--
-- Name: lu_depression_degree_pk_seq; Type: SEQUENCE SET; Schema: clin_mentalhealth; Owner: easygp
--

SELECT pg_catalog.setval('lu_depression_degree_pk_seq', 1, false);


--
-- Data for Name: lu_k10_components; Type: TABLE DATA; Schema: clin_mentalhealth; Owner: easygp
--

COPY lu_k10_components (pk, component) FROM stdin;
\.


--
-- Name: lu_k10_components_pk_seq; Type: SEQUENCE SET; Schema: clin_mentalhealth; Owner: easygp
--

SELECT pg_catalog.setval('lu_k10_components_pk_seq', 1, false);


--
-- Data for Name: lu_plan_type; Type: TABLE DATA; Schema: clin_mentalhealth; Owner: easygp
--

COPY lu_plan_type (pk, type) FROM stdin;
\.


--
-- Name: lu_plan_type_pk_seq; Type: SEQUENCE SET; Schema: clin_mentalhealth; Owner: easygp
--

SELECT pg_catalog.setval('lu_plan_type_pk_seq', 1, false);


--
-- Data for Name: lu_risk_to_others; Type: TABLE DATA; Schema: clin_mentalhealth; Owner: easygp
--

COPY lu_risk_to_others (pk, risk) FROM stdin;
\.


--
-- Name: lu_risk_to_others_pk_seq; Type: SEQUENCE SET; Schema: clin_mentalhealth; Owner: easygp
--

SELECT pg_catalog.setval('lu_risk_to_others_pk_seq', 1, false);


SET search_path = clin_pregnancy, pg_catalog;

--
-- Data for Name: lu_ante_natal_diagnosis; Type: TABLE DATA; Schema: clin_pregnancy; Owner: easygp
--

COPY lu_ante_natal_diagnosis (pk, diagnostic_procedure) FROM stdin;
\.


--
-- Name: lu_ante_natal_diagnosis_pk_seq; Type: SEQUENCE SET; Schema: clin_pregnancy; Owner: easygp
--

SELECT pg_catalog.setval('lu_ante_natal_diagnosis_pk_seq', 1, false);


--
-- Data for Name: lu_delivery_types; Type: TABLE DATA; Schema: clin_pregnancy; Owner: easygp
--

COPY lu_delivery_types (pk, type) FROM stdin;
\.


--
-- Name: lu_delivery_types_pk_seq; Type: SEQUENCE SET; Schema: clin_pregnancy; Owner: easygp
--

SELECT pg_catalog.setval('lu_delivery_types_pk_seq', 1, false);


--
-- Data for Name: lu_onset_labour; Type: TABLE DATA; Schema: clin_pregnancy; Owner: easygp
--

COPY lu_onset_labour (pk, type) FROM stdin;
\.


--
-- Name: lu_onset_labour_pk_seq; Type: SEQUENCE SET; Schema: clin_pregnancy; Owner: easygp
--

SELECT pg_catalog.setval('lu_onset_labour_pk_seq', 1, false);


--
-- Data for Name: lu_placenta_position; Type: TABLE DATA; Schema: clin_pregnancy; Owner: easygp
--

COPY lu_placenta_position (pk, "position") FROM stdin;
\.


--
-- Name: lu_placenta_position_pk_seq; Type: SEQUENCE SET; Schema: clin_pregnancy; Owner: easygp
--

SELECT pg_catalog.setval('lu_placenta_position_pk_seq', 1, false);


--
-- Data for Name: lu_presentations; Type: TABLE DATA; Schema: clin_pregnancy; Owner: easygp
--

COPY lu_presentations (pk, presentation) FROM stdin;
\.


--
-- Name: lu_presentations_pk_seq; Type: SEQUENCE SET; Schema: clin_pregnancy; Owner: easygp
--

SELECT pg_catalog.setval('lu_presentations_pk_seq', 1, false);


SET search_path = clin_prescribing, pg_catalog;

--
-- Data for Name: lu_pbs_script_type; Type: TABLE DATA; Schema: clin_prescribing; Owner: easygp
--

COPY lu_pbs_script_type (pk, type) FROM stdin;
\.


--
-- Name: print_status_pk_seq; Type: SEQUENCE SET; Schema: clin_prescribing; Owner: easygp
--

SELECT pg_catalog.setval('print_status_pk_seq', 1, false);


SET search_path = clin_procedures, pg_catalog;

--
-- Data for Name: lu_anaesthetic_agent; Type: TABLE DATA; Schema: clin_procedures; Owner: easygp
--

COPY lu_anaesthetic_agent (pk, agent, fk_lu_route_administration) FROM stdin;
\.


--
-- Name: lu_anaesthetic_agent_pk_seq; Type: SEQUENCE SET; Schema: clin_procedures; Owner: easygp
--

SELECT pg_catalog.setval('lu_anaesthetic_agent_pk_seq', 1, false);


--
-- Data for Name: lu_complications; Type: TABLE DATA; Schema: clin_procedures; Owner: easygp
--

COPY lu_complications (pk, complication) FROM stdin;
\.


--
-- Name: lu_complications_pk_seq; Type: SEQUENCE SET; Schema: clin_procedures; Owner: easygp
--

SELECT pg_catalog.setval('lu_complications_pk_seq', 1, false);


--
-- Name: lu_excision_type_pk_seq; Type: SEQUENCE SET; Schema: clin_procedures; Owner: easygp
--

SELECT pg_catalog.setval('lu_excision_type_pk_seq', 1, false);


--
-- Data for Name: lu_last_surgical_pack; Type: TABLE DATA; Schema: clin_procedures; Owner: easygp
--

COPY lu_last_surgical_pack (pk, identifier, fk_clinic) FROM stdin;
\.


--
-- Name: lu_pack_pk_seq; Type: SEQUENCE SET; Schema: clin_procedures; Owner: easygp
--

SELECT pg_catalog.setval('lu_pack_pk_seq', 1, false);


--
-- Data for Name: lu_procedure_type; Type: TABLE DATA; Schema: clin_procedures; Owner: easygp
--

COPY lu_procedure_type (pk, type) FROM stdin;
\.


--
-- Data for Name: lu_repair_type; Type: TABLE DATA; Schema: clin_procedures; Owner: easygp
--

COPY lu_repair_type (pk, type) FROM stdin;
\.


--
-- Name: lu_repair_type_pk_seq; Type: SEQUENCE SET; Schema: clin_procedures; Owner: easygp
--

SELECT pg_catalog.setval('lu_repair_type_pk_seq', 1, false);


--
-- Data for Name: lu_skin_preparation; Type: TABLE DATA; Schema: clin_procedures; Owner: easygp
--

COPY lu_skin_preparation (pk, preparation) FROM stdin;
\.


--
-- Name: lu_skin_preparation_pk_seq; Type: SEQUENCE SET; Schema: clin_procedures; Owner: easygp
--

SELECT pg_catalog.setval('lu_skin_preparation_pk_seq', 1, false);


--
-- Data for Name: lu_suture_site; Type: TABLE DATA; Schema: clin_procedures; Owner: easygp
--

COPY lu_suture_site (pk, site) FROM stdin;
\.


--
-- Name: lu_suture_site_pk_seq; Type: SEQUENCE SET; Schema: clin_procedures; Owner: easygp
--

SELECT pg_catalog.setval('lu_suture_site_pk_seq', 1, false);


--
-- Data for Name: lu_suture_type; Type: TABLE DATA; Schema: clin_procedures; Owner: easygp
--

COPY lu_suture_type (pk, brand, fk_lu_site) FROM stdin;
\.


--
-- Name: lu_suture_type_pk_seq; Type: SEQUENCE SET; Schema: clin_procedures; Owner: easygp
--

SELECT pg_catalog.setval('lu_suture_type_pk_seq', 1, false);


SET search_path = clin_recalls, pg_catalog;

--
-- Data for Name: lu_reasons; Type: TABLE DATA; Schema: clin_recalls; Owner: easygp
--

COPY lu_reasons (pk, reason) FROM stdin;
\.


--
-- Name: lu_reasons_pk_seq; Type: SEQUENCE SET; Schema: clin_recalls; Owner: easygp
--

SELECT pg_catalog.setval('lu_reasons_pk_seq', 1, false);


--
-- Data for Name: lu_recall_intervals; Type: TABLE DATA; Schema: clin_recalls; Owner: easygp
--

COPY lu_recall_intervals (pk, fk_reason, fk_staff, "interval", fk_interval_unit) FROM stdin;
\.


--
-- Name: lu_recall_intervals_pk_seq; Type: SEQUENCE SET; Schema: clin_recalls; Owner: easygp
--

SELECT pg_catalog.setval('lu_recall_intervals_pk_seq', 1, false);


--
-- Data for Name: lu_templates; Type: TABLE DATA; Schema: clin_recalls; Owner: easygp
--

COPY lu_templates (pk, name, deleted, template, fk_lu_appointment_length) FROM stdin;
\.


--
-- Name: lu_templates_pk_seq; Type: SEQUENCE SET; Schema: clin_recalls; Owner: easygp
--

SELECT pg_catalog.setval('lu_templates_pk_seq', 1, false);


SET search_path = clin_referrals, pg_catalog;

--
-- Data for Name: lu_referral_letter_templates; Type: TABLE DATA; Schema: clin_referrals; Owner: easygp
--

COPY lu_referral_letter_templates (pk, fk_staff, shared, name, deleted, template) FROM stdin;
\.


--
-- Name: lu_referral_letter_templates_pk_seq; Type: SEQUENCE SET; Schema: clin_referrals; Owner: easygp
--

SELECT pg_catalog.setval('lu_referral_letter_templates_pk_seq', 1, false);


--
-- Data for Name: lu_type; Type: TABLE DATA; Schema: clin_referrals; Owner: easygp
--

COPY lu_type (pk, type, display) FROM stdin;
\.


--
-- Name: lu_type_pk_seq; Type: SEQUENCE SET; Schema: clin_referrals; Owner: easygp
--

SELECT pg_catalog.setval('lu_type_pk_seq', 1, false);


--
-- Data for Name: lu_urgency; Type: TABLE DATA; Schema: clin_referrals; Owner: easygp
--

COPY lu_urgency (pk, urgency) FROM stdin;
\.


--
-- Name: lu_urgency_pk_seq; Type: SEQUENCE SET; Schema: clin_referrals; Owner: easygp
--

SELECT pg_catalog.setval('lu_urgency_pk_seq', 1, false);


SET search_path = clin_requests, pg_catalog;

--
-- Data for Name: lu_copyto_type; Type: TABLE DATA; Schema: clin_requests; Owner: easygp
--

COPY lu_copyto_type (pk, type) FROM stdin;
\.


--
-- Name: lu_copyto_type_pk_seq; Type: SEQUENCE SET; Schema: clin_requests; Owner: easygp
--

SELECT pg_catalog.setval('lu_copyto_type_pk_seq', 1, false);


--
-- Data for Name: lu_form_header; Type: TABLE DATA; Schema: clin_requests; Owner: easygp
--

COPY lu_form_header (pk, fk_branch, header, general_text) FROM stdin;
\.


--
-- Name: lu_form_header_pk_seq; Type: SEQUENCE SET; Schema: clin_requests; Owner: easygp
--

SELECT pg_catalog.setval('lu_form_header_pk_seq', 1, false);


--
-- Data for Name: lu_instructions; Type: TABLE DATA; Schema: clin_requests; Owner: easygp
--

COPY lu_instructions (pk, instruction) FROM stdin;
\.


--
-- Name: lu_instructions_pk_seq; Type: SEQUENCE SET; Schema: clin_requests; Owner: easygp
--

SELECT pg_catalog.setval('lu_instructions_pk_seq', 1, false);


--
-- Data for Name: lu_link_provider_user_requests; Type: TABLE DATA; Schema: clin_requests; Owner: easygp
--

COPY lu_link_provider_user_requests (pk, fk_lu_request, provider_request_name, lateralisation, deleted) FROM stdin;
\.


--
-- Name: lu_link_provider_user_requests_pk_seq; Type: SEQUENCE SET; Schema: clin_requests; Owner: easygp
--

SELECT pg_catalog.setval('lu_link_provider_user_requests_pk_seq', 1, false);


--
-- Data for Name: lu_request_type; Type: TABLE DATA; Schema: clin_requests; Owner: easygp
--

COPY lu_request_type (pk, type) FROM stdin;
\.


--
-- Name: lu_request_type_pk_seq; Type: SEQUENCE SET; Schema: clin_requests; Owner: easygp
--

SELECT pg_catalog.setval('lu_request_type_pk_seq', 1, false);


--
-- Data for Name: lu_requests; Type: TABLE DATA; Schema: clin_requests; Owner: easygp
--

COPY lu_requests (pk, fk_lu_request_type, item, fk_laterality, fk_decision_support, fk_instruction, deleted) FROM stdin;
\.


--
-- Name: lu_requests_pk_seq; Type: SEQUENCE SET; Schema: clin_requests; Owner: easygp
--

SELECT pg_catalog.setval('lu_requests_pk_seq', 1, false);


SET search_path = clin_vaccination, pg_catalog;

--
-- Data for Name: lu_descriptions; Type: TABLE DATA; Schema: clin_vaccination; Owner: easygp
--

COPY lu_descriptions (pk, description, deleted) FROM stdin;
\.


--
-- Data for Name: lu_formulation; Type: TABLE DATA; Schema: clin_vaccination; Owner: easygp
--

COPY lu_formulation (pk, form) FROM stdin;
\.


--
-- Name: lu_formulation_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: easygp
--

SELECT pg_catalog.setval('lu_formulation_pk_seq', 1, false);


--
-- Data for Name: lu_schedules; Type: TABLE DATA; Schema: clin_vaccination; Owner: easygp
--

COPY lu_schedules (pk, age_due_from_months, age_due_to_months, schedule, female_only, atsi_only, fk_season, inactive, date_inactive, deleted, multiple_vaccines, notes) FROM stdin;
\.


--
-- Name: lu_schedules_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: easygp
--

SELECT pg_catalog.setval('lu_schedules_pk_seq', 1, false);


--
-- Data for Name: lu_vaccines; Type: TABLE DATA; Schema: clin_vaccination; Owner: easygp
--

COPY lu_vaccines (pk, brand, form, fk_description, fk_route, inactive, deleted, fk_form, notes, female_only) FROM stdin;
\.


--
-- Name: lu_vaccines_descriptions_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: easygp
--

SELECT pg_catalog.setval('lu_vaccines_descriptions_pk_seq', 1, false);


--
-- Data for Name: lu_vaccines_in_schedule; Type: TABLE DATA; Schema: clin_vaccination; Owner: easygp
--

COPY lu_vaccines_in_schedule (pk, fk_vaccine, fk_schedule, atsi_only, date_inactive) FROM stdin;
\.


--
-- Name: lu_vaccines_in_schedule_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: easygp
--

SELECT pg_catalog.setval('lu_vaccines_in_schedule_pk_seq', 1, false);


--
-- Name: lu_vaccines_pk_seq; Type: SEQUENCE SET; Schema: clin_vaccination; Owner: easygp
--

SELECT pg_catalog.setval('lu_vaccines_pk_seq', 1, false);


SET search_path = clin_workcover, pg_catalog;

--
-- Data for Name: lu_caused_by_employment; Type: TABLE DATA; Schema: clin_workcover; Owner: easygp
--

COPY lu_caused_by_employment (pk, caused_by_employment) FROM stdin;
\.


--
-- Name: lu_caused_by_employment_pk_seq; Type: SEQUENCE SET; Schema: clin_workcover; Owner: easygp
--

SELECT pg_catalog.setval('lu_caused_by_employment_pk_seq', 1, false);


--
-- Data for Name: lu_visit_type; Type: TABLE DATA; Schema: clin_workcover; Owner: easygp
--

COPY lu_visit_type (pk, type) FROM stdin;
\.


--
-- Name: lu_visit_type_pk_seq; Type: SEQUENCE SET; Schema: clin_workcover; Owner: easygp
--

SELECT pg_catalog.setval('lu_visit_type_pk_seq', 1, false);


SET search_path = coding, pg_catalog;

--
-- Data for Name: lu_icpc2_plain_language_mapper; Type: TABLE DATA; Schema: coding; Owner: easygp
--

COPY lu_icpc2_plain_language_mapper (pk, fk_icpc2_term, free_text) FROM stdin;
\.


--
-- Name: lu_icpc2_plain_language_mapper_pk_seq; Type: SEQUENCE SET; Schema: coding; Owner: easygp
--

SELECT pg_catalog.setval('lu_icpc2_plain_language_mapper_pk_seq', 1, false);


--
-- Data for Name: lu_loinc; Type: TABLE DATA; Schema: coding; Owner: easygp
--

COPY lu_loinc (loinc_num, component, property, time_aspct, system, scale_typ, method_typ, relat_nms, class, source, dt_last_ch, chng_type, comments, answerlist, status, map_to, scope, consumer_name, ipcc_units, reference, exact_cmp_sy, molar_mass, classtype, formula, species, exmpl_answers, acssym, base_name, final, naaccr_id, code_table, setroot, panelelements, survey_quest_text, survey_quest_src, unitsrequired, submitted_units, relatednames2, shortname, order_obs, cdisc_common_tests, hl7_field_subfield_id, external_copyright_notice, example_units, inpc_percentage, long_common_name, hl7_v2_datatype, hl7_v3_datatype, curated_range_and_units, document_section, definition_description_help, example_ucum_units) FROM stdin;
\.


--
-- Data for Name: lu_loinc_abbrev; Type: TABLE DATA; Schema: coding; Owner: easygp
--

COPY lu_loinc_abbrev (pk, loinc_num, component, system) FROM stdin;
\.


--
-- Name: lu_loinc_abbrev_pk_seq; Type: SEQUENCE SET; Schema: coding; Owner: easygp
--

SELECT pg_catalog.setval('lu_loinc_abbrev_pk_seq', 1, false);


--
-- Data for Name: lu_systems; Type: TABLE DATA; Schema: coding; Owner: easygp
--

COPY lu_systems (pk, system, author, preferred) FROM stdin;
\.


--
-- Name: lu_systems_pk_seq; Type: SEQUENCE SET; Schema: coding; Owner: easygp
--

SELECT pg_catalog.setval('lu_systems_pk_seq', 1, false);


SET search_path = common, pg_catalog;

--
-- Data for Name: lu_aboriginality; Type: TABLE DATA; Schema: common; Owner: easygp
--

COPY lu_aboriginality (pk, aboriginality) FROM stdin;
\.


--
-- Name: lu_aboriginality_pk_seq; Type: SEQUENCE SET; Schema: common; Owner: easygp
--

SELECT pg_catalog.setval('lu_aboriginality_pk_seq', 1, false);


--
-- Data for Name: lu_anatomical_localisation; Type: TABLE DATA; Schema: common; Owner: easygp
--

COPY lu_anatomical_localisation (pk, term) FROM stdin;
\.


--
-- Name: lu_anatomical_location_pk_seq; Type: SEQUENCE SET; Schema: common; Owner: easygp
--

SELECT pg_catalog.setval('lu_anatomical_location_pk_seq', 1, false);


--
-- Data for Name: lu_anatomical_site; Type: TABLE DATA; Schema: common; Owner: easygp
--

COPY lu_anatomical_site (pk, site) FROM stdin;
\.


--
-- Name: lu_anatomical_site_pk_seq; Type: SEQUENCE SET; Schema: common; Owner: easygp
--

SELECT pg_catalog.setval('lu_anatomical_site_pk_seq', 1, false);


--
-- Data for Name: lu_anterior_posterior; Type: TABLE DATA; Schema: common; Owner: easygp
--

COPY lu_anterior_posterior (pk, anterior_posterior) FROM stdin;
\.


--
-- Name: lu_anterior_posterior_pk_seq; Type: SEQUENCE SET; Schema: common; Owner: easygp
--

SELECT pg_catalog.setval('lu_anterior_posterior_pk_seq', 1, false);


--
-- Data for Name: lu_appointment_length; Type: TABLE DATA; Schema: common; Owner: easygp
--

COPY lu_appointment_length (pk, length) FROM stdin;
\.


--
-- Name: lu_appointment_length_pk_seq; Type: SEQUENCE SET; Schema: common; Owner: easygp
--

SELECT pg_catalog.setval('lu_appointment_length_pk_seq', 0, false);


--
-- Data for Name: lu_blood_group; Type: TABLE DATA; Schema: common; Owner: easygp
--

COPY lu_blood_group (pk, abo_group) FROM stdin;
\.


--
-- Name: lu_blood_group_pk_seq; Type: SEQUENCE SET; Schema: common; Owner: easygp
--

SELECT pg_catalog.setval('lu_blood_group_pk_seq', 1, false);


--
-- Data for Name: lu_companion_status; Type: TABLE DATA; Schema: common; Owner: easygp
--

COPY lu_companion_status (pk, status) FROM stdin;
\.


--
-- Name: lu_companion_status_pk_seq; Type: SEQUENCE SET; Schema: common; Owner: easygp
--

SELECT pg_catalog.setval('lu_companion_status_pk_seq', 1, false);


--
-- Data for Name: lu_countries; Type: TABLE DATA; Schema: common; Owner: easygp
--

COPY lu_countries (pk, country_code, country) FROM stdin;
\.


--
-- Name: lu_countries_pk_seq; Type: SEQUENCE SET; Schema: common; Owner: easygp
--

SELECT pg_catalog.setval('lu_countries_pk_seq', 1, false);


--
-- Data for Name: lu_ethnicity; Type: TABLE DATA; Schema: common; Owner: easygp
--

COPY lu_ethnicity (pk, ethnicity) FROM stdin;
\.


--
-- Name: lu_ethnicity_pk_seq; Type: SEQUENCE SET; Schema: common; Owner: easygp
--

SELECT pg_catalog.setval('lu_ethnicity_pk_seq', 1, false);


--
-- Data for Name: lu_family_relationships; Type: TABLE DATA; Schema: common; Owner: easygp
--

COPY lu_family_relationships (pk, relationship) FROM stdin;
\.


--
-- Name: lu_family_relationships_pk_seq; Type: SEQUENCE SET; Schema: common; Owner: easygp
--

SELECT pg_catalog.setval('lu_family_relationships_pk_seq', 1, false);


--
-- Data for Name: lu_formulation; Type: TABLE DATA; Schema: common; Owner: easygp
--

COPY lu_formulation (pk, form) FROM stdin;
\.


--
-- Name: lu_formulation_pk_seq; Type: SEQUENCE SET; Schema: common; Owner: easygp
--

SELECT pg_catalog.setval('lu_formulation_pk_seq', 1, false);


--
-- Data for Name: lu_hearing_aid_status; Type: TABLE DATA; Schema: common; Owner: easygp
--

COPY lu_hearing_aid_status (pk, status) FROM stdin;
\.


--
-- Name: lu_hearing_aid_status_pk_seq; Type: SEQUENCE SET; Schema: common; Owner: easygp
--

SELECT pg_catalog.setval('lu_hearing_aid_status_pk_seq', 1, false);


--
-- Data for Name: lu_languages; Type: TABLE DATA; Schema: common; Owner: easygp
--

COPY lu_languages (pk, language) FROM stdin;
\.


--
-- Name: lu_languages_pk_seq; Type: SEQUENCE SET; Schema: common; Owner: easygp
--

SELECT pg_catalog.setval('lu_languages_pk_seq', 1, false);


--
-- Data for Name: lu_laterality; Type: TABLE DATA; Schema: common; Owner: easygp
--

COPY lu_laterality (pk, laterality) FROM stdin;
\.


--
-- Name: lu_laterality_pk_seq; Type: SEQUENCE SET; Schema: common; Owner: easygp
--

SELECT pg_catalog.setval('lu_laterality_pk_seq', 1, false);


--
-- Data for Name: lu_medicolegal; Type: TABLE DATA; Schema: common; Owner: easygp
--

COPY lu_medicolegal (pk, medicolegal_action) FROM stdin;
\.


--
-- Name: lu_medicolegal_pk_seq; Type: SEQUENCE SET; Schema: common; Owner: easygp
--

SELECT pg_catalog.setval('lu_medicolegal_pk_seq', 1, false);


--
-- Data for Name: lu_motion; Type: TABLE DATA; Schema: common; Owner: easygp
--

COPY lu_motion (pk, motion) FROM stdin;
\.


--
-- Name: lu_motion_pk_seq; Type: SEQUENCE SET; Schema: common; Owner: easygp
--

SELECT pg_catalog.setval('lu_motion_pk_seq', 1, false);


--
-- Data for Name: lu_normality; Type: TABLE DATA; Schema: common; Owner: easygp
--

COPY lu_normality (pk, normality) FROM stdin;
\.


--
-- Name: lu_normality_pk_seq; Type: SEQUENCE SET; Schema: common; Owner: easygp
--

SELECT pg_catalog.setval('lu_normality_pk_seq', 1, false);


--
-- Data for Name: lu_occupations; Type: TABLE DATA; Schema: common; Owner: easygp
--

COPY lu_occupations (pk, occupation, referrer_type) FROM stdin;
\.


--
-- Data for Name: lu_occupations_abs_coded; Type: TABLE DATA; Schema: common; Owner: easygp
--

COPY lu_occupations_abs_coded (pk, abs_code, occupation) FROM stdin;
\.


--
-- Name: lu_occupations_abs_coded_pk_seq; Type: SEQUENCE SET; Schema: common; Owner: easygp
--

SELECT pg_catalog.setval('lu_occupations_abs_coded_pk_seq', 1, false);


--
-- Name: lu_occupations_pk_seq; Type: SEQUENCE SET; Schema: common; Owner: easygp
--

SELECT pg_catalog.setval('lu_occupations_pk_seq', 1, false);


--
-- Data for Name: lu_occupations_temp; Type: TABLE DATA; Schema: common; Owner: easygp
--

COPY lu_occupations_temp (pk, occupation, referrer_type) FROM stdin;
\.


--
-- Name: lu_occupations_temp_pk_seq; Type: SEQUENCE SET; Schema: common; Owner: easygp
--

SELECT pg_catalog.setval('lu_occupations_temp_pk_seq', 1, false);


--
-- Data for Name: lu_proximal_distal; Type: TABLE DATA; Schema: common; Owner: easygp
--

COPY lu_proximal_distal (pk, proximal_distal) FROM stdin;
\.


--
-- Name: lu_proximal_distal_pk_seq; Type: SEQUENCE SET; Schema: common; Owner: easygp
--

SELECT pg_catalog.setval('lu_proximal_distal_pk_seq', 1, false);


--
-- Data for Name: lu_route_administration; Type: TABLE DATA; Schema: common; Owner: easygp
--

COPY lu_route_administration (pk, abbreviation, route) FROM stdin;
\.


--
-- Data for Name: lu_recreational_drugs; Type: TABLE DATA; Schema: common; Owner: easygp
--

COPY lu_recreational_drugs (pk, drug, alternative_names, default_fk_lu_route_administration, quantification, illicit) FROM stdin;
\.


--
-- Name: lu_recreational_drugs_pk_seq; Type: SEQUENCE SET; Schema: common; Owner: easygp
--

SELECT pg_catalog.setval('lu_recreational_drugs_pk_seq', 1, false);


--
-- Data for Name: lu_religions; Type: TABLE DATA; Schema: common; Owner: easygp
--

COPY lu_religions (pk, religion) FROM stdin;
\.


--
-- Name: lu_religions_pk_seq; Type: SEQUENCE SET; Schema: common; Owner: easygp
--

SELECT pg_catalog.setval('lu_religions_pk_seq', 1, false);


--
-- Data for Name: lu_rhesus_group; Type: TABLE DATA; Schema: common; Owner: easygp
--

COPY lu_rhesus_group (pk, rhesus_group) FROM stdin;
\.


--
-- Name: lu_rhesus_group_pk_seq; Type: SEQUENCE SET; Schema: common; Owner: easygp
--

SELECT pg_catalog.setval('lu_rhesus_group_pk_seq', 1, false);


--
-- Name: lu_route_administration_pk_seq; Type: SEQUENCE SET; Schema: common; Owner: easygp
--

SELECT pg_catalog.setval('lu_route_administration_pk_seq', 1, false);


--
-- Data for Name: lu_seasons; Type: TABLE DATA; Schema: common; Owner: easygp
--

COPY lu_seasons (pk, season) FROM stdin;
\.


--
-- Name: lu_seasons_pk_seq; Type: SEQUENCE SET; Schema: common; Owner: easygp
--

SELECT pg_catalog.setval('lu_seasons_pk_seq', 1, false);


--
-- Data for Name: lu_site_administration; Type: TABLE DATA; Schema: common; Owner: easygp
--

COPY lu_site_administration (pk, site, has_laterality) FROM stdin;
\.


--
-- Name: lu_site_administration_pk_seq; Type: SEQUENCE SET; Schema: common; Owner: easygp
--

SELECT pg_catalog.setval('lu_site_administration_pk_seq', 1, false);


--
-- Data for Name: lu_smoking_status; Type: TABLE DATA; Schema: common; Owner: easygp
--

COPY lu_smoking_status (pk, status) FROM stdin;
\.


--
-- Name: lu_smoking_status_pk_seq; Type: SEQUENCE SET; Schema: common; Owner: easygp
--

SELECT pg_catalog.setval('lu_smoking_status_pk_seq', 1, false);


--
-- Data for Name: lu_social_support; Type: TABLE DATA; Schema: common; Owner: easygp
--

COPY lu_social_support (pk, support) FROM stdin;
\.


--
-- Name: lu_social_support_pk_seq; Type: SEQUENCE SET; Schema: common; Owner: easygp
--

SELECT pg_catalog.setval('lu_social_support_pk_seq', 1, false);


--
-- Data for Name: lu_sub_religions; Type: TABLE DATA; Schema: common; Owner: easygp
--

COPY lu_sub_religions (pk, fk_religion, sub_religion) FROM stdin;
\.


--
-- Name: lu_sub_religions_pk_seq; Type: SEQUENCE SET; Schema: common; Owner: easygp
--

SELECT pg_catalog.setval('lu_sub_religions_pk_seq', 1, false);


--
-- Data for Name: lu_units; Type: TABLE DATA; Schema: common; Owner: easygp
--

COPY lu_units (pk, abbrev_text, full_text) FROM stdin;
\.


--
-- Name: lu_units_pk_seq; Type: SEQUENCE SET; Schema: common; Owner: easygp
--

SELECT pg_catalog.setval('lu_units_pk_seq', 1, false);


--
-- Data for Name: lu_urgency; Type: TABLE DATA; Schema: common; Owner: easygp
--

COPY lu_urgency (pk, urgency) FROM stdin;
\.


--
-- Name: lu_urgency_pk_seq; Type: SEQUENCE SET; Schema: common; Owner: easygp
--

SELECT pg_catalog.setval('lu_urgency_pk_seq', 1, false);


--
-- Data for Name: lu_whisper_test; Type: TABLE DATA; Schema: common; Owner: easygp
--

COPY lu_whisper_test (pk, hearing_result) FROM stdin;
\.


--
-- Name: lu_whisper_test_pk_seq; Type: SEQUENCE SET; Schema: common; Owner: easygp
--

SELECT pg_catalog.setval('lu_whisper_test_pk_seq', 1, false);


SET search_path = contacts, pg_catalog;

--
-- Data for Name: lu_address_types; Type: TABLE DATA; Schema: contacts; Owner: easygp
--

COPY lu_address_types (pk, type) FROM stdin;
\.


--
-- Name: lu_address_types_pk_seq; Type: SEQUENCE SET; Schema: contacts; Owner: easygp
--

SELECT pg_catalog.setval('lu_address_types_pk_seq', 1, false);


--
-- Data for Name: lu_categories; Type: TABLE DATA; Schema: contacts; Owner: easygp
--

COPY lu_categories (pk, category) FROM stdin;
\.


--
-- Name: lu_categories_pk_seq; Type: SEQUENCE SET; Schema: contacts; Owner: easygp
--

SELECT pg_catalog.setval('lu_categories_pk_seq', 1, false);


--
-- Data for Name: lu_contact_type; Type: TABLE DATA; Schema: contacts; Owner: easygp
--

COPY lu_contact_type (pk, type) FROM stdin;
\.


--
-- Name: lu_contact_type_pk_seq; Type: SEQUENCE SET; Schema: contacts; Owner: easygp
--

SELECT pg_catalog.setval('lu_contact_type_pk_seq', 1, false);


--
-- Data for Name: lu_employee_status; Type: TABLE DATA; Schema: contacts; Owner: easygp
--

COPY lu_employee_status (pk, status) FROM stdin;
\.


--
-- Name: lu_employee_status_pk_seq; Type: SEQUENCE SET; Schema: contacts; Owner: easygp
--

SELECT pg_catalog.setval('lu_employee_status_pk_seq', 1, false);


--
-- Data for Name: lu_sex; Type: TABLE DATA; Schema: contacts; Owner: easygp
--

COPY lu_sex (pk, sex, sex_text) FROM stdin;
\.


--
-- Data for Name: lu_firstnames; Type: TABLE DATA; Schema: contacts; Owner: easygp
--

COPY lu_firstnames (pk, firstname, ord, sex) FROM stdin;
\.


--
-- Name: lu_firstnames_pk_seq; Type: SEQUENCE SET; Schema: contacts; Owner: easygp
--

SELECT pg_catalog.setval('lu_firstnames_pk_seq', 1, false);


--
-- Data for Name: lu_marital; Type: TABLE DATA; Schema: contacts; Owner: easygp
--

COPY lu_marital (pk, marital) FROM stdin;
\.


--
-- Name: lu_marital_pk_seq; Type: SEQUENCE SET; Schema: contacts; Owner: easygp
--

SELECT pg_catalog.setval('lu_marital_pk_seq', 1, false);


--
-- Name: lu_mismatched_towns_pk_seq; Type: SEQUENCE SET; Schema: contacts; Owner: easygp
--

SELECT pg_catalog.setval('lu_mismatched_towns_pk_seq', 1, false);


--
-- Data for Name: lu_misspelt_towns; Type: TABLE DATA; Schema: contacts; Owner: easygp
--

COPY lu_misspelt_towns (pk, fk_town, town, town_misspelt) FROM stdin;
\.


--
-- Name: lu_sex_pk_seq; Type: SEQUENCE SET; Schema: contacts; Owner: easygp
--

SELECT pg_catalog.setval('lu_sex_pk_seq', 1, false);


--
-- Data for Name: lu_surnames; Type: TABLE DATA; Schema: contacts; Owner: easygp
--

COPY lu_surnames (pk, surname) FROM stdin;
\.


--
-- Name: lu_surnames_pk_seq; Type: SEQUENCE SET; Schema: contacts; Owner: easygp
--

SELECT pg_catalog.setval('lu_surnames_pk_seq', 1, false);


--
-- Data for Name: lu_title; Type: TABLE DATA; Schema: contacts; Owner: easygp
--

COPY lu_title (pk, title) FROM stdin;
\.


--
-- Name: lu_title_pk_seq; Type: SEQUENCE SET; Schema: contacts; Owner: easygp
--

SELECT pg_catalog.setval('lu_title_pk_seq', 1, false);


--
-- Data for Name: lu_towns; Type: TABLE DATA; Schema: contacts; Owner: easygp
--

COPY lu_towns (pk, postcode, town, state, comment) FROM stdin;
\.


--
-- Name: lu_towns_pk_seq; Type: SEQUENCE SET; Schema: contacts; Owner: easygp
--

SELECT pg_catalog.setval('lu_towns_pk_seq', 1, false);


SET search_path = db, pg_catalog;

--
-- Name: db_version_pk_seq; Type: SEQUENCE SET; Schema: db; Owner: easygp
--

SELECT pg_catalog.setval('db_version_pk_seq', 1, false);


--
-- Data for Name: lu_version; Type: TABLE DATA; Schema: db; Owner: easygp
--

COPY lu_version (pk, lu_major, lu_minor) FROM stdin;
\.


SET search_path = defaults, pg_catalog;

--
-- Data for Name: lu_link_printer_task; Type: TABLE DATA; Schema: defaults; Owner: easygp
--

COPY lu_link_printer_task (pk, fk_lu_printer_host, fk_task) FROM stdin;
\.


--
-- Name: lu_link_printer_task_pk_seq; Type: SEQUENCE SET; Schema: defaults; Owner: easygp
--

SELECT pg_catalog.setval('lu_link_printer_task_pk_seq', 1, false);


--
-- Data for Name: lu_message_display_style; Type: TABLE DATA; Schema: defaults; Owner: easygp
--

COPY lu_message_display_style (pk, style) FROM stdin;
\.


--
-- Name: lu_message_display_style_pk_seq; Type: SEQUENCE SET; Schema: defaults; Owner: easygp
--

SELECT pg_catalog.setval('lu_message_display_style_pk_seq', 1, false);


--
-- Data for Name: lu_message_standard; Type: TABLE DATA; Schema: defaults; Owner: easygp
--

COPY lu_message_standard (pk, type, version) FROM stdin;
\.


--
-- Name: lu_message_standard_pk_seq; Type: SEQUENCE SET; Schema: defaults; Owner: easygp
--

SELECT pg_catalog.setval('lu_message_standard_pk_seq', 1, false);


--
-- Data for Name: lu_printer_host; Type: TABLE DATA; Schema: defaults; Owner: easygp
--

COPY lu_printer_host (pk, fk_clinic, hostname, printer) FROM stdin;
\.


--
-- Name: lu_printer_host_pk_seq; Type: SEQUENCE SET; Schema: defaults; Owner: easygp
--

SELECT pg_catalog.setval('lu_printer_host_pk_seq', 1, false);


--
-- Data for Name: lu_printer_task; Type: TABLE DATA; Schema: defaults; Owner: easygp
--

COPY lu_printer_task (pk, task) FROM stdin;
\.


--
-- Name: lu_printer_task_pk_seq; Type: SEQUENCE SET; Schema: defaults; Owner: easygp
--

SELECT pg_catalog.setval('lu_printer_task_pk_seq', 1, false);


SET search_path = documents, pg_catalog;

--
-- Data for Name: lu_archive_site; Type: TABLE DATA; Schema: documents; Owner: easygp
--

COPY lu_archive_site (pk, archive_site) FROM stdin;
\.


--
-- Name: lu_archive_site_pk_seq; Type: SEQUENCE SET; Schema: documents; Owner: easygp
--

SELECT pg_catalog.setval('lu_archive_site_pk_seq', 1, false);


--
-- Data for Name: lu_display_as; Type: TABLE DATA; Schema: documents; Owner: easygp
--

COPY lu_display_as (pk, display_as) FROM stdin;
\.


--
-- Name: lu_display_as_pk_seq; Type: SEQUENCE SET; Schema: documents; Owner: easygp
--

SELECT pg_catalog.setval('lu_display_as_pk_seq', 1, false);


--
-- Data for Name: lu_message_display_style; Type: TABLE DATA; Schema: documents; Owner: easygp
--

COPY lu_message_display_style (pk, style) FROM stdin;
\.


--
-- Name: lu_message_display_style_pk_seq; Type: SEQUENCE SET; Schema: documents; Owner: easygp
--

SELECT pg_catalog.setval('lu_message_display_style_pk_seq', 1, false);


--
-- Data for Name: lu_message_standard; Type: TABLE DATA; Schema: documents; Owner: easygp
--

COPY lu_message_standard (pk, type, version) FROM stdin;
\.


--
-- Name: lu_message_standard_pk_seq; Type: SEQUENCE SET; Schema: documents; Owner: easygp
--

SELECT pg_catalog.setval('lu_message_standard_pk_seq', 1, false);


SET search_path = drugbank, pg_catalog;

--
-- Data for Name: lu_external_resources; Type: TABLE DATA; Schema: drugbank; Owner: easygp
--

COPY lu_external_resources (pk, resource) FROM stdin;
\.


--
-- Name: lu_external_resources_pk_seq; Type: SEQUENCE SET; Schema: drugbank; Owner: easygp
--

SELECT pg_catalog.setval('lu_external_resources_pk_seq', 1, false);


SET search_path = drugs, pg_catalog;

--
-- Data for Name: atc; Type: TABLE DATA; Schema: drugs; Owner: easygp
--

COPY atc (atccode, atcname) FROM stdin;
\.


--
-- Data for Name: form; Type: TABLE DATA; Schema: drugs; Owner: easygp
--

COPY form (pk, form, volume_amount_required) FROM stdin;
\.


--
-- Data for Name: schedules; Type: TABLE DATA; Schema: drugs; Owner: easygp
--

COPY schedules (pk, schedule) FROM stdin;
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: drugs; Owner: easygp
--

COPY product (pk, atccode, generic, salt, fk_form, strength, salt_strength, original_pbs_name, original_pbs_fs, free_comment, updated_at, fk_schedule, shared, pack_size, amount, amount_unit, units_per_pack, old_original_pbs_name, sct, extempore) FROM stdin;
\.


--
-- Data for Name: brand; Type: TABLE DATA; Schema: drugs; Owner: easygp
--

COPY brand (fk_product, fk_company, brand, price, from_pbs, original_tga_text, original_tga_code, pk, product_information_filename, product_information_filename_user, current, sct) FROM stdin;
\.


--
-- Data for Name: chapters; Type: TABLE DATA; Schema: drugs; Owner: easygp
--

COPY chapters (chapter, chapter_name) FROM stdin;
\.


--
-- Data for Name: severity_level; Type: TABLE DATA; Schema: drugs; Owner: easygp
--

COPY severity_level (pk, severity) FROM stdin;
\.


--
-- Data for Name: clinical_effects; Type: TABLE DATA; Schema: drugs; Owner: easygp
--

COPY clinical_effects (pk, effect, fk_severity) FROM stdin;
\.


--
-- Name: clinical_effects_pk_seq; Type: SEQUENCE SET; Schema: drugs; Owner: easygp
--

SELECT pg_catalog.setval('clinical_effects_pk_seq', 1, false);


--
-- Data for Name: company; Type: TABLE DATA; Schema: drugs; Owner: easygp
--

COPY company (company, address, telephone, facsimile, code) FROM stdin;
\.


--
-- Data for Name: evidence_levels; Type: TABLE DATA; Schema: drugs; Owner: easygp
--

COPY evidence_levels (pk, evidence_level) FROM stdin;
\.


--
-- Data for Name: flags; Type: TABLE DATA; Schema: drugs; Owner: easygp
--

COPY flags (pk, description) FROM stdin;
\.


--
-- Name: flags_pk_seq; Type: SEQUENCE SET; Schema: drugs; Owner: easygp
--

SELECT pg_catalog.setval('flags_pk_seq', 1, false);


--
-- Data for Name: patient_categories; Type: TABLE DATA; Schema: drugs; Owner: easygp
--

COPY patient_categories (pk, category) FROM stdin;
\.


--
-- Data for Name: pharmacologic_mechanisms; Type: TABLE DATA; Schema: drugs; Owner: easygp
--

COPY pharmacologic_mechanisms (pk, mechanism) FROM stdin;
\.


--
-- Data for Name: topic; Type: TABLE DATA; Schema: drugs; Owner: easygp
--

COPY topic (pk, title, target) FROM stdin;
\.


--
-- Data for Name: info; Type: TABLE DATA; Schema: drugs; Owner: easygp
--

COPY info (pk, comment, fk_topic, created_at, fk_clinical_effect, fk_pharmacologic_mechanism, fk_evidence_level, fk_patient_category, standard_frequency, paed_dose, paed_max, fk_severity) FROM stdin;
\.


--
-- Name: info_pk_seq; Type: SEQUENCE SET; Schema: drugs; Owner: easygp
--

SELECT pg_catalog.setval('info_pk_seq', 1, false);


--
-- Data for Name: link_atc_info; Type: TABLE DATA; Schema: drugs; Owner: easygp
--

COPY link_atc_info (atccode, fk_info) FROM stdin;
\.


--
-- Data for Name: link_category_info; Type: TABLE DATA; Schema: drugs; Owner: easygp
--

COPY link_category_info (fk_category, fk_info) FROM stdin;
\.


--
-- Data for Name: link_flag_product; Type: TABLE DATA; Schema: drugs; Owner: easygp
--

COPY link_flag_product (fk_product, fk_flag) FROM stdin;
\.


--
-- Data for Name: sources; Type: TABLE DATA; Schema: drugs; Owner: easygp
--

COPY sources (pk, source_category, source) FROM stdin;
\.


--
-- Data for Name: link_info_source; Type: TABLE DATA; Schema: drugs; Owner: easygp
--

COPY link_info_source (fk_info, fk_source) FROM stdin;
\.


--
-- Data for Name: pbs; Type: TABLE DATA; Schema: drugs; Owner: easygp
--

COPY pbs (fk_product, quantity, max_rpt, pbscode, chapter, restrictionflag) FROM stdin;
\.


--
-- Data for Name: pbsconvert; Type: TABLE DATA; Schema: drugs; Owner: easygp
--

COPY pbsconvert (fs, done, dose, packsize, amount, id, comment, form) FROM stdin;
\.


--
-- Data for Name: product_information_files; Type: TABLE DATA; Schema: drugs; Owner: easygp
--

COPY product_information_files (filename) FROM stdin;
\.


--
-- Data for Name: product_information_unmatched; Type: TABLE DATA; Schema: drugs; Owner: easygp
--

COPY product_information_unmatched (brand, product_information_filename) FROM stdin;
\.


--
-- Data for Name: restriction; Type: TABLE DATA; Schema: drugs; Owner: easygp
--

COPY restriction (pbscode, restriction, restriction_type, code, streamlined) FROM stdin;
\.


--
-- Data for Name: version; Type: TABLE DATA; Schema: drugs; Owner: easygp
--

COPY version (release_date, author, comment) FROM stdin;
\.


SET search_path = import_export, pg_catalog;

--
-- Data for Name: lu_demographics_field_templates; Type: TABLE DATA; Schema: import_export; Owner: easygp
--

COPY lu_demographics_field_templates (pk, fk_source_program, version, surname_field_order, firstname_field_order, title_field_order, sex_field_order, marital_field_order, salutation_field_order, medicare_field_order, birthdate_field_order, occupation_field_order, street1_field_order, street2_field_order, suburb_field_order, homephone_field_order, workphone_field_order, mobile_field_order, retired_field_order, field_names, veterens_field_order, medicare_card_pos_field_order, card_concession_number_field_order) FROM stdin;
\.


--
-- Name: lu_demographics_field_templates_pk_seq; Type: SEQUENCE SET; Schema: import_export; Owner: easygp
--

SELECT pg_catalog.setval('lu_demographics_field_templates_pk_seq', 1, false);


--
-- Data for Name: lu_misspelt_occupations; Type: TABLE DATA; Schema: import_export; Owner: easygp
--

COPY lu_misspelt_occupations (pk, occupation, misspelt_occupation) FROM stdin;
\.


--
-- Name: lu_misspelt_occupations_pk_seq; Type: SEQUENCE SET; Schema: import_export; Owner: easygp
--

SELECT pg_catalog.setval('lu_misspelt_occupations_pk_seq', 1, false);


--
-- Data for Name: lu_misspelt_user_request_tags; Type: TABLE DATA; Schema: import_export; Owner: easygp
--

COPY lu_misspelt_user_request_tags (pk, tag) FROM stdin;
\.


--
-- Name: lu_misspelt_user_request_tags_pk_seq; Type: SEQUENCE SET; Schema: import_export; Owner: easygp
--

SELECT pg_catalog.setval('lu_misspelt_user_request_tags_pk_seq', 1, false);


--
-- Data for Name: lu_source_program; Type: TABLE DATA; Schema: import_export; Owner: easygp
--

COPY lu_source_program (pk, program) FROM stdin;
\.


--
-- Name: lu_source_program_pk_seq; Type: SEQUENCE SET; Schema: import_export; Owner: easygp
--

SELECT pg_catalog.setval('lu_source_program_pk_seq', 1, false);


SET search_path = public, pg_catalog;

--
-- Data for Name: lu_modes; Type: TABLE DATA; Schema: public; Owner: easygp
--

COPY lu_modes (mode, description) FROM stdin;
\.


--
-- PostgreSQL database dump complete
--

