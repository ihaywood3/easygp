alter table clin_requests.forms add column latex text;
comment on column  clin_requests.forms.latex is 
'the actually LaTex of the form as printed currently the field has no default as all 
  my old forms won''t have any LaTex';

DROP VIEW clin_requests.vwrequestforms;

CREATE OR REPLACE VIEW clin_requests.vwrequestforms AS 
 SELECT COALESCE((forms.pk || '-'::text) || forms_requests.pk) AS pk_view, forms_requests.pk AS fk_forms_requests, 
 forms.fk_consult, forms.date, lu_requests.item, forms.requests_summary, forms.notes_summary, 
 forms.fk_request_provider, forms.fk_lu_request_type, forms.medications_summary, forms.copyto, 
 forms.deleted, forms.copyto_patient, forms.urgent, forms.bulk_bill, forms.fasting, 
 forms.phone, forms.fax, forms.include_medications, forms.pk_image, forms.fk_progressnote, 
 forms.fk_pasthistory, forms.latex,
 vwstaff.firstname AS staff_firstname, vwstaff.surname AS staff_surname, 
 vwstaff.wholename AS staff_wholename, vwstaff.title AS staff_title, lu_request_type.type,
 vwrequestproviders.fk_headoffice_branch, vwrequestproviders.fk_default_branch, 
 vwrequestproviders.fk_employee, vwrequestproviders.fk_person, vwrequestproviders.request_provider_deleted, 
 vwrequestproviders.organisation, vwrequestproviders.category, vwrequestproviders.headoffice_branch, 
 vwrequestproviders.fk_organisation, vwrequestproviders.headoffice_branch_deleted, 
 vwrequestproviders.headoffice_street1, vwrequestproviders.headoffice_street2, vwrequestproviders.headoffice_address_deleted, 
 vwrequestproviders.headoffice_postcode, vwrequestproviders.headoffice_town, vwrequestproviders.headoffice_state, 
 vwrequestproviders.wholename, vwrequestproviders.firstname, vwrequestproviders.surname, vwrequestproviders.salutation, 
 vwrequestproviders.fk_title, vwrequestproviders.title, vwrequestproviders.fk_sex, vwrequestproviders.sex, 
 vwrequestproviders.fk_occupation, vwrequestproviders.occupation, vwrequestproviders.default_branch, 
 vwrequestproviders.default_branch_street1, vwrequestproviders.default_branch_street2, 
 vwrequestproviders.default_branch_postcode, vwrequestproviders.default_branch_town, 
 vwrequestproviders.default_branch_state, forms_requests.fk_form, forms_requests.fk_lu_request, 
 forms_requests.deleted AS forms_request_deleted, forms_requests.request_result_html, consult.consult_date, consult.fk_patient, 
 consult.fk_staff, past_history.description AS past_history_description
   FROM clin_requests.forms
   JOIN clin_consult.consult ON forms.fk_consult = consult.pk
   JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   JOIN clin_requests.lu_request_type ON forms.fk_lu_request_type = lu_request_type.pk
   JOIN clin_requests.forms_requests ON forms.pk = forms_requests.fk_form
   JOIN clin_requests.lu_requests ON forms_requests.fk_lu_request = lu_requests.pk
   JOIN clin_requests.vwrequestproviders ON forms.fk_request_provider = vwrequestproviders.pk_request_provider
   LEFT JOIN clin_history.past_history ON forms.fk_pasthistory = past_history.pk
  ORDER BY consult.fk_patient, forms.date DESC, forms_requests.fk_form, lu_requests.item;

ALTER TABLE clin_requests.vwrequestforms OWNER TO easygp;
GRANT ALL ON TABLE clin_requests.vwrequestforms TO easygp;
GRANT ALL ON TABLE clin_requests.vwrequestforms TO staff;



truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 132);

