COMMENT ON TABLE clin_history.team_care_arrangements
  IS 'the team care arrangments for a single episode of claiming Item 721 (initial) or 732 (review). 
     The LaTex of associated documents is kept in documents.documents (the GPMP, the TCA referrals, 
     the EPC form which uses overpic to generate is kept as a document in the file system with
     a key in documents.documents.  Note that as a TCA can be a document in progress - nurses could 
     help (heaven forbid) but if not calimedn no field is manditory until the gui enforces a final claim.';
     
CREATE OR REPLACE VIEW common.vwreligions AS 
 SELECT
        CASE
            WHEN lu_sub_religions.fk_religion is not null THEN (lu_religions.pk || '-'::text) || lu_sub_religions.pk
            ELSE lu_religions.pk || '-0'::text
        END AS pk_view,
    lu_religions.religion,
    lu_sub_religions.sub_religion,
    lu_religions.pk AS fk_religion,
    lu_sub_religions.pk AS fk_lu_sub_religion
   FROM common.lu_sub_religions
     RIGHT JOIN common.lu_religions ON lu_sub_religions.fk_religion = lu_religions.pk
  ORDER BY lu_sub_religions.fk_religion, lu_sub_religions.pk;

ALTER TABLE common.vwreligions   OWNER TO easygp;
GRANT SELECT ON TABLE common.vwreligions TO staff;

-- View: clerical.vwtaskscomponents

DROP VIEW clerical.vwtaskscomponents;

CREATE OR REPLACE VIEW clerical.vwtaskscomponents AS 
 SELECT task_components.pk AS pk_view,
    tasks.related_to,
    tasks.fk_row,
    tasks.fk_staff_finalised_task,
    tasks.date_finalised,
    tasks.deleted AS task_deleted,
    tasks.fk_staff_filed_task,
    tasks.fk_staff_must_finalise,
    tasks.fk_role_can_finalise,
    vwstaffinclinics.wholename AS staff_filed_task_wholename,
    vwstaffinclinics.title AS staff_filed_task_title,
    vwstaffinclinics2.title AS staff_finalised_task_title,
    vwstaffinclinics2.wholename AS staff_finalised_task_wholename,
    vwstaffinclinics3.title AS staff_must_finalise_task_title,
    vwstaffinclinics3.wholename AS staff_must_finalise_task_wholename,
    task_components.fk_role,
    task_components.pk AS fk_component,
    task_components.fk_task,
    task_components.fk_consult,
    task_components.fk_staff_allocated,
    task_components.fk_staff_completed,
    task_components.allocated_staff,
    task_components.fk_urgency,
    task_components.details,
    task_components.must_verify_completed,
    task_components.date_completed AS date_component_completed,
    task_components.deleted AS component_deleted,
    vwstaffinclinics1.wholename AS staff_allocated_wholename,
    vwstaffinclinics1.title AS staff_allocated_title,
    consult.consult_date AS date_component_logged,
    vwpatients.town AS patient_town,
    vwpatients.state AS patient_state,
    vwpatients.postcode AS patient_postcode,
    vwpatients.street1 AS patient_street1,
    vwpatients.street2 AS patient_street2,
    vwpatients.fk_person,
    vwpatients.fk_patient,
    vwpatients.wholename AS patient_wholename,
    vwpatients.title AS patient_title,
    vwpatients.birthdate AS patient_birthdate,
    lu_urgency.urgency
   FROM clerical.task_components
     JOIN clerical.tasks ON task_components.fk_task = tasks.pk
     JOIN admin.vwstaffinclinics ON tasks.fk_staff_filed_task = vwstaffinclinics.fk_staff
     LEFT JOIN admin.vwstaffinclinics vwstaffinclinics1 ON task_components.fk_staff_allocated = vwstaffinclinics1.fk_staff
     LEFT JOIN admin.vwstaffinclinics vwstaffinclinics2 ON tasks.fk_staff_finalised_task = vwstaffinclinics2.fk_staff
     LEFT JOIN admin.vwstaffinclinics vwstaffinclinics3 ON tasks.fk_staff_must_finalise = vwstaffinclinics3.fk_staff
     JOIN clin_consult.consult ON task_components.fk_consult = consult.pk
     JOIN contacts.vwpatients ON consult.fk_patient = vwpatients.fk_patient
     JOIN common.lu_urgency ON task_components.fk_urgency = lu_urgency.pk
  WHERE task_components.fk_consult is not null
  ORDER BY vwpatients.fk_patient, task_components.pk;

ALTER TABLE clerical.vwtaskscomponents   OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponents TO easygp;
GRANT SELECT ON TABLE clerical.vwtaskscomponents TO staff;

-- View: clerical.vwtaskscomponentsandnotes

-- DROP VIEW clerical.vwtaskscomponentsandnotes;

CREATE OR REPLACE VIEW clerical.vwtaskscomponentsandnotes AS 
 SELECT
        CASE
            WHEN task_component_notes.pk IS NULL THEN task_components.pk || '-0'::text
            ELSE (task_components.pk || '-'::text) || task_component_notes.pk
        END AS pk_view,
    tasks.related_to AS task,
    task_components.details,
    task_component_notes.note,
    tasks.fk_row,
    tasks.fk_staff_finalised_task,
    tasks.fk_staff_must_finalise,
    tasks.fk_role_can_finalise,
    tasks.date_finalised,
    tasks.deleted AS task_deleted,
    tasks.fk_staff_filed_task,
    vwstaffinclinics.wholename AS staff_filed_task_wholename,
    vwstaffinclinics.title AS staff_filed_task_title,
    vwstaffinclinics2.title AS staff_finalised_task_title,
    vwstaffinclinics2.wholename AS staff_finalised_task_wholename,
    vwstaffinclinics3.title AS staff_must_finalise_task_title,
    vwstaffinclinics3.wholename AS staff_must_finalise_task_wholename,
    task_components.fk_role,
    lu_staff_roles.role AS role_allocated,
    task_components.pk AS fk_component,
    task_components.fk_task,
    task_components.fk_consult,
    task_components.fk_staff_allocated,
    task_components.fk_staff_completed,
    task_components.allocated_staff,
    task_components.fk_urgency,
    task_components.date_completed AS date_component_completed,
    task_components.deleted AS component_deleted,
    vwstaffinclinics1.wholename AS staff_allocated_wholename,
    vwstaffinclinics1.title AS staff_allocated_title,
    consult.consult_date AS date_component_logged,
    vwpatients.town AS patient_town,
    vwpatients.state AS patient_state,
    vwpatients.postcode AS patient_postcode,
    vwpatients.street1 AS patient_street1,
    vwpatients.street2 AS patient_street2,
    vwpatients.fk_person,
    vwpatients.fk_patient,
    vwpatients.wholename AS patient_wholename,
    vwpatients.title AS patient_title,
    vwpatients.birthdate AS patient_birthdate,
    lu_urgency.urgency,
    task_component_notes.pk AS fk_task_component_note,
    task_component_notes.date AS date_note,
    task_component_notes.fk_staff_made_note,
    vwstaffinclinics4.wholename AS staff_made_note_wholename,
    vwstaffinclinics4.title AS staff_made_note_title
   FROM clerical.task_components
     JOIN clerical.tasks ON task_components.fk_task = tasks.pk
     JOIN admin.vwstaffinclinics ON tasks.fk_staff_filed_task = vwstaffinclinics.fk_staff
     LEFT JOIN admin.vwstaffinclinics vwstaffinclinics1 ON task_components.fk_staff_allocated = vwstaffinclinics1.fk_staff
     LEFT JOIN admin.vwstaffinclinics vwstaffinclinics2 ON tasks.fk_staff_finalised_task = vwstaffinclinics2.fk_staff
     LEFT JOIN admin.vwstaffinclinics vwstaffinclinics3 ON tasks.fk_staff_must_finalise = vwstaffinclinics3.fk_staff
     JOIN clin_consult.consult ON task_components.fk_consult = consult.pk
     JOIN contacts.vwpatients ON consult.fk_patient = vwpatients.fk_patient
     JOIN common.lu_urgency ON task_components.fk_urgency = lu_urgency.pk
     LEFT JOIN clerical.task_component_notes ON task_components.pk = task_component_notes.fk_task_component
     LEFT JOIN admin.vwstaffinclinics vwstaffinclinics4 ON task_component_notes.fk_staff_made_note = vwstaffinclinics4.fk_staff
     LEFT JOIN admin.lu_staff_roles ON task_components.fk_role = lu_staff_roles.pk
  WHERE task_components.fk_consult is not null
  ORDER BY vwpatients.fk_patient, task_components.pk;

ALTER TABLE clerical.vwtaskscomponentsandnotes
  OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwtaskscomponentsandnotes TO easygp;
GRANT SELECT ON TABLE clerical.vwtaskscomponentsandnotes TO staff;
COMMENT ON VIEW clerical.vwtaskscomponentsandnotes
  IS 'the tasks and each component in it''s actioning and any associated notes.
  Note: if task_components.fk_role is not null then anyone of that role can action it
       hence lu_staff_roles.role as role_can_action gives the text for that role e.g secretary
       this is also why staff_made_note_wholename to indicate which staff actually did the component';


drop view chronic_disease_management.vwdiabetesgroupalliedhealth;
CREATE OR REPLACE VIEW chronic_disease_management.vwdiabetesgroupalliedhealth AS 
 SELECT diabetes_group_allied_health_services.pk AS pk_diabetes_group_allied_health_services,
    diabetes_group_allied_health_services.fk_consult,
    consult.consult_date,
    consult.fk_patient,
    consult.fk_staff,
    diabetes_group_allied_health_services.confirm_diabetic,
    diabetes_group_allied_health_services.gpmp_new,
    diabetes_group_allied_health_services.gpmp_review,
    diabetes_group_allied_health_services.age_care_plan_review,
    diabetes_group_allied_health_services.latex_form,
    diabetes_group_allied_health_services.latex_history_items,
    diabetes_group_allied_health_services.fk_document_history_items,
    diabetes_group_allied_health_services.fk_document_form,
    diabetes_group_allied_health_services.health_issue_keys,
    diabetes_group_allied_health_services.fk_branch,
    diabetes_group_allied_health_services.fk_employee,
    diabetes_group_allied_health_services.fk_person,
    diabetes_group_allied_health_services.sessions_dietitian,
    diabetes_group_allied_health_services.sessions_exercise,
    diabetes_group_allied_health_services.sessions_education,
    diabetes_group_allied_health_services.include_allergies,
    diabetes_group_allied_health_services.include_medications,
    diabetes_group_allied_health_services.special_notes,
    diabetes_group_allied_health_services.fk_progressnote,
    vworganisationsemployees.fk_organisation,
    vworganisationsemployees.firstname,
    vworganisationsemployees.surname,
    vworganisationsemployees.title,
    vworganisationsemployees.occupation,
    vworganisationsemployees.organisation,
    vworganisationsemployees.branch,
    vworganisationsemployees.street1,
    vworganisationsemployees.street2,
    vworganisationsemployees.town,
    vworganisationsemployees.postcode,
    ((vworganisationsemployees.title || ' '::text) || (vworganisationsemployees.firstname || ' '::text)) || vworganisationsemployees.surname AS wholename,
    ((vworganisationsemployees.organisation || ' '::text) || (vworganisationsemployees.branch || ' '::text)) ||
        CASE
            WHEN vworganisationsemployees.fk_address IS NULL THEN ''::text
            ELSE (((vworganisationsemployees.street1 || ' '::text) || vworganisationsemployees.town) || ' '::text) || vworganisationsemployees.postcode::text
        END AS organisation_summary,
    diabetes_group_allied_health_services.deleted
   FROM chronic_disease_management.diabetes_group_allied_health_services
     JOIN clin_consult.consult ON diabetes_group_allied_health_services.fk_consult = consult.pk
     LEFT JOIN contacts.vworganisationsemployees ON diabetes_group_allied_health_services.fk_branch = vworganisationsemployees.fk_branch AND diabetes_group_allied_health_services.fk_employee = vworganisationsemployees.fk_employee
  WHERE diabetes_group_allied_health_services.deleted = false AND diabetes_group_allied_health_services.fk_branch is not null AND diabetes_group_allied_health_services.fk_employee is not null
UNION
 SELECT diabetes_group_allied_health_services.pk AS pk_diabetes_group_allied_health_services,
    diabetes_group_allied_health_services.fk_consult,
    consult.consult_date,
    consult.fk_patient,
    consult.fk_staff,
    diabetes_group_allied_health_services.confirm_diabetic,
    diabetes_group_allied_health_services.gpmp_new,
    diabetes_group_allied_health_services.gpmp_review,
    diabetes_group_allied_health_services.age_care_plan_review,
    diabetes_group_allied_health_services.latex_form,
    diabetes_group_allied_health_services.latex_history_items,
    diabetes_group_allied_health_services.fk_document_history_items,
    diabetes_group_allied_health_services.fk_document_form,
    diabetes_group_allied_health_services.health_issue_keys,
    diabetes_group_allied_health_services.fk_branch,
    diabetes_group_allied_health_services.fk_employee,
    diabetes_group_allied_health_services.fk_person,
    diabetes_group_allied_health_services.sessions_dietitian,
    diabetes_group_allied_health_services.sessions_exercise,
    diabetes_group_allied_health_services.sessions_education,
    diabetes_group_allied_health_services.include_allergies,
    diabetes_group_allied_health_services.include_medications,
    diabetes_group_allied_health_services.special_notes,
    diabetes_group_allied_health_services.fk_progressnote,
    vworganisations.fk_organisation,
    NULL::text AS firstname,
    NULL::text AS surname,
    NULL::text AS title,
    NULL::text AS occupation,
    vworganisations.organisation,
    vworganisations.branch,
    vworganisations.street1,
    vworganisations.street2,
    vworganisations.town,
    vworganisations.postcode,
    NULL::text AS wholename,
    (((vworganisations.organisation || ' '::text) || (vworganisations.branch || ' '::text)) || (((vworganisations.street1 || ' '::text) || vworganisations.town) || ' '::text)) || vworganisations.postcode::text AS organisation_summary,
    diabetes_group_allied_health_services.deleted
   FROM chronic_disease_management.diabetes_group_allied_health_services
     JOIN clin_consult.consult ON diabetes_group_allied_health_services.fk_consult = consult.pk
     LEFT JOIN contacts.vworganisations ON diabetes_group_allied_health_services.fk_branch = vworganisations.fk_branch
  WHERE diabetes_group_allied_health_services.deleted = false AND diabetes_group_allied_health_services.fk_branch is not null AND diabetes_group_allied_health_services.fk_employee IS NULL;

ALTER TABLE chronic_disease_management.vwdiabetesgroupalliedhealth   OWNER TO easygp;
GRANT ALL ON TABLE chronic_disease_management.vwdiabetesgroupalliedhealth TO easygp;
GRANT ALL ON TABLE chronic_disease_management.vwdiabetesgroupalliedhealth TO staff;


CREATE OR REPLACE VIEW clin_mentalhealth.vwteamcaremembers AS 
 SELECT team_care_members.pk,
    team_care_members.fk_plan,
    team_care_members.fk_employee,
    vworganisationsemployees.fk_organisation,
    vworganisationsemployees.fk_branch,
    vworganisationsemployees.fk_person,
        CASE
            WHEN vworganisationsemployees.fk_employee is null THEN vworganisationsemployees.branch
            ELSE ((vworganisationsemployees.title || ' '::text) || (vworganisationsemployees.firstname || ' '::text)) || vworganisationsemployees.surname
        END AS wholename,
    ((vworganisationsemployees.organisation || ' '::text) || (vworganisationsemployees.branch || ' '::text)) ||
        CASE
            WHEN vworganisationsemployees.fk_address IS NULL THEN ''::text
            ELSE (((vworganisationsemployees.street1 || ' '::text) || vworganisationsemployees.town) || ' '::text) || vworganisationsemployees.postcode::text
        END AS summary,
    team_care_members.responsibility
   FROM clin_mentalhealth.team_care_members
     LEFT JOIN contacts.vworganisationsemployees ON team_care_members.fk_branch = vworganisationsemployees.fk_branch AND team_care_members.fk_employee = vworganisationsemployees.fk_employee
  WHERE team_care_members.deleted = false AND team_care_members.fk_branch is not null
UNION
 SELECT team_care_members.pk,
    team_care_members.fk_plan,
    team_care_members.fk_employee,
    NULL::integer AS fk_organisation,
    NULL::integer AS fk_branch,
    vwpersonsincludingpatients.fk_person,
    vwpersonsincludingpatients.wholename,
    (((vwpersonsincludingpatients.street1 || ' '::text) || vwpersonsincludingpatients.town) || ' '::text) || vwpersonsincludingpatients.postcode::text AS summary,
    team_care_members.responsibility
   FROM clin_mentalhealth.team_care_members
     JOIN contacts.vwpersonsincludingpatients ON team_care_members.fk_person = vwpersonsincludingpatients.fk_person
     LEFT JOIN contacts.vworganisationsemployees ON team_care_members.fk_person = vworganisationsemployees.fk_person
  WHERE team_care_members.deleted = false AND team_care_members.fk_employee IS NULL;

ALTER TABLE clin_mentalhealth.vwteamcaremembers   OWNER TO easygp;
GRANT SELECT ON TABLE clin_mentalhealth.vwteamcaremembers TO staff;


CREATE OR REPLACE VIEW clin_requests.vwrequestnames AS 
 SELECT lu_request_items.pk || '-1'::text AS pk_view,
    lu_request_items.pk AS fk_lu_request,
    lu_request_type.type,
    lu_request_items.fk_lu_request_type,
    lu_request_items.deleted,
        CASE
            WHEN lu_request_items.fk_laterality = 3 THEN lu_request_items.item || ' (LEFT)'::text
            ELSE NULL::text
        END AS item,
    1 AS fk_laterality
   FROM clin_requests.lu_requests lu_request_items
     JOIN clin_requests.lu_request_type ON lu_request_items.fk_lu_request_type = lu_request_type.pk
  WHERE lower(lu_request_items.item) ~~ '%'::text AND lu_request_items.fk_laterality = 3
UNION
 SELECT lu_request_items.pk || '-2'::text AS pk_view,
    lu_request_items.pk AS fk_lu_request,
    lu_request_type.type,
    lu_request_items.fk_lu_request_type,
    lu_request_items.deleted,
        CASE
            WHEN lu_request_items.fk_laterality = 3 THEN lu_request_items.item || ' (RIGHT)'::text
            ELSE NULL::text
        END AS item,
    2 AS fk_laterality
   FROM clin_requests.lu_requests lu_request_items
     JOIN clin_requests.lu_request_type ON lu_request_items.fk_lu_request_type = lu_request_type.pk
  WHERE lower(lu_request_items.item) ~~ '%'::text AND lu_request_items.fk_laterality = 3
UNION
 SELECT lu_request_items.pk || '-3'::text AS pk_view,
    lu_request_items.pk AS fk_lu_request,
    lu_request_type.type,
    lu_request_items.fk_lu_request_type,
    lu_request_items.deleted,
        CASE
            WHEN lu_request_items.fk_laterality = 3 THEN lu_request_items.item || ' (BOTH)'::text
            ELSE NULL::text
        END AS item,
    3 AS fk_laterality
   FROM clin_requests.lu_requests lu_request_items
     JOIN clin_requests.lu_request_type ON lu_request_items.fk_lu_request_type = lu_request_type.pk
  WHERE lower(lu_request_items.item) ~~ '%'::text AND lu_request_items.fk_laterality = 3
UNION
 SELECT lu_request_items.pk || '-0'::text AS pk_view,
    lu_request_items.pk AS fk_lu_request,
    lu_request_type.type,
    lu_request_items.fk_lu_request_type,
    lu_request_items.deleted,
    lu_request_items.item,
    lu_request_items.fk_laterality
   FROM clin_requests.lu_requests lu_request_items
     JOIN clin_requests.lu_request_type ON lu_request_items.fk_lu_request_type = lu_request_type.pk
  WHERE lower(lu_request_items.item) ~~ '%'::text AND lu_request_items.fk_laterality IS NULL
  ORDER BY 2, 7;

ALTER TABLE clin_requests.vwrequestnames   OWNER TO easygp;
GRANT ALL ON TABLE clin_requests.vwrequestnames TO staff;

COMMENT ON VIEW clin_requests.vwrequestnames
  IS 'a view of everything which is orderable, including lateralisation eg Xray wrist (LEFT), Xray wrist (RIGHT) or Xray Wrist (BOTH)';
  
update db.lu_version set lu_minor = 466;