-- View: clin_requests.vwrequestformsnotdone

--DROP VIEW clin_requests.vwrequestformsnotdone;

CREATE OR REPLACE VIEW clin_requests.vwrequestformsnotdone AS 
 SELECT COALESCE((forms.pk || '-'::text) || forms_requests.pk) AS pk_view,
    vwpatients.wholename AS patient_wholename,
    vwpatients.surname AS patient_surname,
    vwpatients.firstname AS patient_firstname,
    vwpatients.birthdate,
    vwpatients.street1 AS patient_street1,
    vwpatients.street2 AS patient_street2,
    vwpatients.town AS patient_town,
    vwpatients.postcode AS patient_postcode,
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
    lu_request_type.type,
    forms_requests.fk_form,
    forms_requests.fk_lu_request,
    forms_requests.deleted AS forms_request_deleted,
    forms_requests.request_result_html,
    forms_requests.finalised,
    forms_requests.reason_not_done,
    consult.consult_date,
    consult.fk_patient,
    consult.fk_staff
   FROM clin_requests.forms
     JOIN clin_consult.consult ON forms.fk_consult = consult.pk
     JOIN clin_requests.lu_request_type ON forms.fk_lu_request_type = lu_request_type.pk
     JOIN clin_requests.forms_requests ON forms.pk = forms_requests.fk_form
     JOIN clin_requests.lu_requests ON forms_requests.fk_lu_request = lu_requests.pk
     JOIN contacts.vwpatients ON vwpatients.fk_patient = consult.fk_patient
  WHERE forms_requests.finalised = false;

ALTER TABLE clin_requests.vwrequestformsnotdone   OWNER TO easygp;
GRANT ALL ON TABLE clin_requests.vwrequestformsnotdone TO easygp;
GRANT ALL ON TABLE clin_requests.vwrequestformsnotdone TO staff;

update db.lu_version set lu_minor=521;