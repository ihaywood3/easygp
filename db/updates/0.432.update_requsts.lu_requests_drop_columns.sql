alter table clin_requests.lu_requests drop column fk_decision_support cascade;
alter table clin_requests.lu_requests add column fk_instruction integer references clin_requests.lu_instructons (pk);
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
    1 AS fk_laterality,
    lu_request_items.fk_instruction,
    lu_instructions.instruction
   FROM clin_requests.lu_requests lu_request_items
     JOIN clin_requests.lu_request_type ON lu_request_items.fk_lu_request_type = lu_request_type.pk
     LEFT JOIN clin_requests.lu_instructions ON lu_request_items.fk_instruction = lu_instructions.pk
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
    2 AS fk_laterality,
    lu_request_items.fk_instruction,
    lu_instructions.instruction
   FROM clin_requests.lu_requests lu_request_items
     JOIN clin_requests.lu_request_type ON lu_request_items.fk_lu_request_type = lu_request_type.pk
     LEFT JOIN clin_requests.lu_instructions ON lu_request_items.fk_instruction = lu_instructions.pk
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
    3 AS fk_laterality,
    lu_request_items.fk_instruction,
    lu_instructions.instruction
   FROM clin_requests.lu_requests lu_request_items
     JOIN clin_requests.lu_request_type ON lu_request_items.fk_lu_request_type = lu_request_type.pk
     LEFT JOIN clin_requests.lu_instructions ON lu_request_items.fk_instruction = lu_instructions.pk
  WHERE lower(lu_request_items.item) ~~ '%'::text AND lu_request_items.fk_laterality = 3
UNION
 SELECT lu_request_items.pk || '-0'::text AS pk_view,
    lu_request_items.pk AS fk_lu_request,
    lu_request_type.type,
    lu_request_items.fk_lu_request_type,
    lu_request_items.deleted,
    lu_request_items.item,
    lu_request_items.fk_laterality,
    lu_request_items.fk_instruction,
    lu_instructions.instruction
   FROM clin_requests.lu_requests lu_request_items
     JOIN clin_requests.lu_request_type ON lu_request_items.fk_lu_request_type = lu_request_type.pk
     LEFT JOIN clin_requests.lu_instructions ON lu_request_items.fk_instruction = lu_instructions.pk
  WHERE lower(lu_request_items.item) ~~ '%'::text AND lu_request_items.fk_laterality is null
  ORDER BY 2, 7;

ALTER TABLE clin_requests.vwrequestnames   OWNER TO easygp;
GRANT ALL ON TABLE clin_requests.vwrequestnames TO staff;
COMMENT ON VIEW clin_requests.vwrequestnames
  IS 'a view of everything which is orderable, including lateralisation eg Xray wrist (LEFT), Xray wrist (RIGHT) or Xray Wrist (BOTH)';

--drop view clin_requests.vwrequestsordered;
CREATE OR REPLACE VIEW clin_requests.vwrequestsordered AS 
 SELECT (forms.pk || '-'::text) || forms_requests.pk AS pk_view,
    forms.fk_lu_request_type,
    lu_request_type.type,
    forms.fk_consult,
    consult.consult_date,
    consult.fk_patient,
    data_persons.firstname,
    data_persons.surname,
    data_persons.birthdate,
    data_persons.fk_sex,
    forms_requests.fk_form,
    forms.requests_summary,
    forms_requests.pk AS fk_forms_requests,
    lu_requests.item,
    forms.date,
    forms_requests.request_result_html,
    forms.fk_progressnote,
    forms_requests.fk_lu_request,
    forms_requests.deleted AS request_deleted,
    lu_requests.fk_laterality,
    lu_requests.fk_instruction,
    forms.fk_request_provider AS fk_branch,
    forms.notes_summary,
    forms.medications_summary,
    forms.copyto,
    forms.deleted,
    forms.copyto_patient,
    forms.urgent,
    forms.bulk_bill,
    forms.fasting,
    forms.phone,
    forms.fax,
    forms.include_medications,
    forms.pk_image AS fk_image,
    forms.fk_pasthistory,
    past_history.description,
    lu_title.title AS staff_title,
    staff.pk AS fk_staff,
    data_persons1.firstname AS staff_firstname,
    data_persons1.surname AS staff_surname,
    data_branches.branch,
    data_branches.fk_organisation,
    data_organisations.organisation,
    vwdocuments.data,
    vwdocuments.data_content_type,
    vwdocuments.fk_lu_data_content_type
   FROM clin_requests.forms
     JOIN clin_requests.forms_requests ON forms.pk = forms_requests.fk_form
     JOIN clin_requests.lu_requests ON forms_requests.fk_lu_request = lu_requests.pk
     JOIN clin_requests.lu_request_type ON lu_requests.fk_lu_request_type = lu_request_type.pk
     JOIN clin_consult.consult ON forms.fk_consult = consult.pk
     JOIN clerical.data_patients ON consult.fk_patient = data_patients.pk
     JOIN contacts.data_persons ON data_patients.fk_person = data_persons.pk
     LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
     JOIN admin.staff ON consult.fk_staff = staff.pk
     JOIN contacts.data_persons data_persons1 ON staff.fk_person = data_persons1.pk
     LEFT JOIN contacts.data_branches ON forms.fk_request_provider = data_branches.pk
     LEFT JOIN contacts.data_organisations ON data_branches.fk_organisation = data_organisations.pk
     LEFT JOIN clin_history.past_history ON forms.fk_pasthistory = past_history.pk
     LEFT JOIN documents.vwdocuments ON forms_requests.pk = vwdocuments.fk_request
  WHERE forms.deleted = false AND forms_requests.deleted = false
  ORDER BY consult.fk_patient, forms.date DESC, forms_requests.fk_form, lu_requests.item;

ALTER TABLE clin_requests.vwrequestsordered   OWNER TO easygp;
GRANT SELECT ON TABLE clin_requests.vwrequestsordered TO staff;

update db.lu_version set lu_minor=432;
