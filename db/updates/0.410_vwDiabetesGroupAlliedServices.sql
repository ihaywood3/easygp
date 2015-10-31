-- View: chronic_disease_management.vwDiabetesGroupAlliedHealth

 --DROP VIEW chronic_disease_management.vwDiabetesGroupAlliedHealth;
CREATE OR REPLACE VIEW chronic_disease_management.vwDiabetesGroupAlliedHealth AS 
 SELECT 
	diabetes_group_allied_health_services.pk as pk_diabetes_group_allied_health_services,
	diabetes_group_allied_health_services.fk_consult,
	consult.consult_date as consult_date,
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
	diabetes_group_allied_health_services.sessions_dietitian,
	diabetes_group_allied_health_services.sessions_exercise,
	diabetes_group_allied_health_services.sessions_education,
	diabetes_group_allied_health_services.include_allergies,
	diabetes_group_allied_health_services.include_medications,
	diabetes_group_allied_health_services.special_notes,
	diabetes_group_allied_health_services.fk_progressnote, 
	vworganisationsemployees.fk_branch,
	vworganisationsemployees.fk_employee,
	vworganisationsemployees.fk_organisation,
	vworganisationsemployees.fk_person,
	vworganisationsemployees.firstname, vworganisationsemployees.surname, vworganisationsemployees.title, vworganisationsemployees.occupation,
	vworganisationsemployees.organisation, vworganisationsemployees.branch,
	vworganisationsemployees.street1, vworganisationsemployees.street2, vworganisationsemployees.town, vworganisationsemployees.postcode,
		CASE
		    WHEN vworganisationsemployees.fk_employee = 0 THEN vworganisationsemployees.branch
		    ELSE ((vworganisationsemployees.title || ' '::text) || (vworganisationsemployees.firstname || ' '::text)) || vworganisationsemployees.surname
		END AS wholename,
        ((vworganisationsemployees.organisation || ' '::text) || (vworganisationsemployees.branch || ' '::text)) ||
		CASE
		    WHEN vworganisationsemployees.fk_address IS NULL THEN ''::text
		    ELSE (((vworganisationsemployees.street1 || ' '::text) || vworganisationsemployees.town) || ' '::text) || vworganisationsemployees.postcode::text
		END AS organisation_summary,
		diabetes_group_allied_health_services.deleted
    FROM chronic_disease_management.diabetes_group_allied_health_services
        JOIN clin_consult.consult ON  diabetes_group_allied_health_services.fk_consult = consult.pk
        LEFT JOIN  contacts.vworganisationsemployees 
		ON diabetes_group_allied_health_services.fk_branch = vworganisationsemployees.fk_branch AND diabetes_group_allied_health_services.fk_employee = vworganisationsemployees.fk_employee
	WHERE diabetes_group_allied_health_services.deleted = false AND diabetes_group_allied_health_services.fk_branch > 0

UNION
	SELECT
	diabetes_group_allied_health_services.pk as pk_diabetes_group_allied_health_services,
	diabetes_group_allied_health_services.fk_consult,
	consult.consult_date as consult_date,
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
	diabetes_group_allied_health_services.sessions_dietitian,
	diabetes_group_allied_health_services.sessions_exercise,
	diabetes_group_allied_health_services.sessions_education,
	diabetes_group_allied_health_services.include_allergies,
	diabetes_group_allied_health_services.include_medications,
	diabetes_group_allied_health_services.special_notes,
	diabetes_group_allied_health_services.fk_progressnote, 
	vworganisationsemployees.fk_branch,
	vworganisationsemployees.fk_employee,
	vworganisationsemployees.fk_organisation,
	vworganisationsemployees.fk_person,
	vworganisationsemployees.firstname, vworganisationsemployees.surname, vworganisationsemployees.title,vworganisationsemployees.occupation,
	vworganisationsemployees.organisation, vworganisationsemployees.branch,
	vworganisationsemployees.street1, vworganisationsemployees.street2, vworganisationsemployees.town, vworganisationsemployees.postcode,
		CASE
		    WHEN vworganisationsemployees.fk_employee = 0 THEN vworganisationsemployees.branch
		    ELSE ((vworganisationsemployees.title || ' '::text) || (vworganisationsemployees.firstname || ' '::text)) || vworganisationsemployees.surname
		END AS wholename,
        ((vworganisationsemployees.organisation || ' '::text) || (vworganisationsemployees.branch || ' '::text)) ||
		CASE
		    WHEN vworganisationsemployees.fk_address IS NULL THEN ''::text
		    ELSE (((vworganisationsemployees.street1 || ' '::text) || vworganisationsemployees.town) || ' '::text) || vworganisationsemployees.postcode::text
		END AS organisation_summary,
		diabetes_group_allied_health_services.deleted
     FROM chronic_disease_management.diabetes_group_allied_health_services
        JOIN clin_consult.consult ON  diabetes_group_allied_health_services.fk_consult = consult.pk
        LEFT JOIN  contacts.vworganisationsemployees 
		ON diabetes_group_allied_health_services.fk_branch = vworganisationsemployees.fk_branch AND diabetes_group_allied_health_services.fk_employee = vworganisationsemployees.fk_employee
	WHERE diabetes_group_allied_health_services.deleted = false AND diabetes_group_allied_health_services.fk_branch > 0
	;
	
ALTER TABLE chronic_disease_management.vwDiabetesGroupAlliedHealth   OWNER TO easygp;
GRANT ALL ON TABLE chronic_disease_management.vwDiabetesGroupAlliedHealth TO easygp;
GRANT ALL ON TABLE chronic_disease_management.vwDiabetesGroupAlliedHealth TO staff;

update db.lu_version set lu_minor=410;