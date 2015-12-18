alter table clin_requests.forms drop column fk_pasthistory cascade;

CREATE OR REPLACE VIEW clin_requests.vwrequestforms AS 
 SELECT COALESCE((forms.pk || '-'::text) || forms_requests.pk) AS pk_view,
    forms_requests.pk AS fk_forms_requests,
    forms.fk_consult,
    forms.date,
    lu_requests.item,
    forms.requests_summary,
    forms.notes_summary,
    forms.fk_request_provider,
    forms.fk_lu_request_type,
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
    forms.pk_image,
    forms.fk_progressnote,
    forms.latex,
    vwstaff.firstname AS staff_firstname,
    vwstaff.surname AS staff_surname,
    vwstaff.wholename AS staff_wholename,
    vwstaff.title AS staff_title,
    lu_request_type.type,
    vwrequestproviders.fk_headoffice_branch,
    vwrequestproviders.fk_default_branch,
    vwrequestproviders.fk_employee,
    vwrequestproviders.fk_person,
    vwrequestproviders.request_provider_deleted,
    vwrequestproviders.organisation,
    vwrequestproviders.category,
    vwrequestproviders.headoffice_branch,
    vwrequestproviders.fk_organisation,
    vwrequestproviders.headoffice_branch_deleted,
    vwrequestproviders.headoffice_street1,
    vwrequestproviders.headoffice_street2,
    vwrequestproviders.headoffice_address_deleted,
    vwrequestproviders.headoffice_postcode,
    vwrequestproviders.headoffice_town,
    vwrequestproviders.headoffice_state,
    vwrequestproviders.wholename,
    vwrequestproviders.firstname,
    vwrequestproviders.surname,
    vwrequestproviders.salutation,
    vwrequestproviders.fk_title,
    vwrequestproviders.title,
    vwrequestproviders.fk_sex,
    vwrequestproviders.sex,
    vwrequestproviders.fk_occupation,
    vwrequestproviders.occupation,
    vwrequestproviders.default_branch,
    vwrequestproviders.default_branch_street1,
    vwrequestproviders.default_branch_street2,
    vwrequestproviders.default_branch_postcode,
    vwrequestproviders.default_branch_town,
    vwrequestproviders.default_branch_state,
    forms_requests.fk_form,
    forms_requests.fk_lu_request,
    forms_requests.deleted AS forms_request_deleted,
    forms_requests.request_result_html,
    consult.consult_date,
    consult.fk_patient,
    consult.fk_staff
   FROM clin_requests.forms
     JOIN clin_consult.consult ON forms.fk_consult = consult.pk
     JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
     JOIN clin_requests.lu_request_type ON forms.fk_lu_request_type = lu_request_type.pk
     JOIN clin_requests.forms_requests ON forms.pk = forms_requests.fk_form
     JOIN clin_requests.lu_requests ON forms_requests.fk_lu_request = lu_requests.pk
     JOIN clin_requests.vwrequestproviders ON forms.fk_request_provider = vwrequestproviders.pk_request_provider;
   
ALTER TABLE clin_requests.vwrequestforms   OWNER TO easygp;
GRANT ALL ON TABLE clin_requests.vwrequestforms TO staff;


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
     LEFT JOIN documents.vwdocuments ON forms_requests.pk = vwdocuments.fk_request
  WHERE forms.deleted = false AND forms_requests.deleted = false
  ORDER BY consult.fk_patient, forms.date DESC, forms_requests.fk_form, lu_requests.item;

ALTER TABLE clin_requests.vwrequestsordered   OWNER TO easygp;
GRANT SELECT ON TABLE clin_requests.vwrequestsordered TO staff;

update db.lu_version set lu_minor = 462;