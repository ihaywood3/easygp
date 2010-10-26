-- Debugging and fixing the clin_requests schema to remove html of forms


alter table clin_requests.forms drop column form_html cascade;
alter table clin_requests.forms drop column forms_results_html;

-- This causes this to happen:

--drop cascades to view clin_procedures.vwskinprocedures
--drop cascades to view clin_requests.vwforms
--drop cascades to view clin_requests.


DROP TABLE clin_requests.lu_type cascade;

-- This causes this to happen: 

--drop table clin_request.lu_type table no longer used, instead using clin_requests.lu_request_type table
--drop cascades to view clin_requests.vwrequestitems dosn't matter, we are dropping this and recreating different one in its place
--drop cascades to view clin_requests.vwrequestsonforms
--drop cascades to view clin_requests.vwstaffpreferences - this view no longer is used


drop view clin_requests.vwRequests;  -- this view no longer needed - new one called vwRequestNames instead


alter table clin_requests.lu_requests rename column fk_type to fk_lu_request_type;

Alter table clin_requests.forms add column fk_pasthistory integer default null;

comment on column clin_requests.forms.fk_pasthistory is
'if not null it is the health issue linked to this request form -  foreign key to clin_history.past_history';

-- Now reconstruct the views

CREATE OR REPLACE VIEW clin_requests.vwrequestsOrdered AS 
 SELECT (forms.pk || '-'::text) || forms_requests.pk AS pk_view, forms.fk_lu_request_type, lu_request_type.type, 
 forms.fk_consult, consult.consult_date, consult.fk_patient, data_persons.firstname, data_persons.surname, 
 data_persons.birthdate, data_persons.fk_sex, forms_requests.fk_form, forms.requests_summary, forms_requests.pk AS fk_forms_requests, 
 lu_requests.item, forms.date, forms_requests.request_result_html, forms.fk_progressnote, forms_requests.fk_lu_request, 
 forms_requests.deleted AS request_deleted, lu_requests.fk_laterality, lu_requests.fk_decision_support, 
 lu_requests.fk_instruction, forms.fk_branch, forms.notes_summary, forms.medications_summary, forms.copyto, forms.deleted, 
 forms.copyto_patient, forms.urgent, forms.bulk_bill, forms.fasting, forms.phone, forms.fax, forms.include_medications, 
 forms.pk_image AS fk_image, forms.fk_pasthistory, past_history.description, lu_title.title AS staff_title,
  staff.pk AS fk_staff, data_persons1.firstname AS staff_firstname, data_persons1.surname AS staff_surname, 
  data_branches.branch, data_branches.fk_organisation, data_organisations.organisation, vwdocuments.html
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
   LEFT JOIN contacts.data_branches ON forms.fk_branch = data_branches.pk
   LEFT JOIN contacts.data_organisations ON data_branches.fk_organisation = data_organisations.pk
   LEFT JOIN clin_history.past_history ON forms.fk_pasthistory = past_history.pk
   LEFT JOIN documents.vwdocuments ON forms_requests.pk = vwdocuments.fk_request
  WHERE forms.deleted = false AND forms_requests.deleted = false
  ORDER BY consult.fk_patient, forms.date DESC, forms_requests.fk_form, lu_requests.item;

ALTER TABLE clin_requests.vwrequestsOrdered OWNER TO easygp;
GRANT ALL ON TABLE clin_requests.vwrequestsOrdered TO easygp;
GRANT ALL ON TABLE clin_requests.vwrequestsOrdered TO staff;

COMMENT ON VIEW clin_requests.vwrequestsOrdered is
'a view of all requests ordered along with form detail, i.e
 for a form with say fbc, uec, lfts on it
 row1 = form data + fbc
 row2 = form data + uec etc ';
 
CREATE OR REPLACE VIEW clin_requests.vwRequestforms AS 
 SELECT forms.pk  AS pk_view, forms.fk_lu_request_type, lu_request_type.type, forms.fk_consult, consult.consult_date, 
 consult.fk_patient, data_persons.firstname, data_persons.surname, data_persons.birthdate, 
 data_persons.fk_sex, forms_requests.fk_form, forms.requests_summary, forms_requests.pk AS fk_forms_requests, 
 lu_requests.item, forms.date, forms_requests.request_result_html, forms.fk_progressnote, forms_requests.fk_lu_request, forms_requests.deleted AS request_deleted, lu_requests.fk_laterality, lu_requests.fk_decision_support, lu_requests.fk_instruction, forms.fk_branch, forms.notes_summary, forms.medications_summary, forms.copyto, forms.deleted, forms.copyto_patient, forms.urgent, forms.bulk_bill, forms.fasting, forms.phone, forms.fax, forms.include_medications, forms.pk_image AS fk_image, forms.fk_pasthistory, past_history.description, lu_title.title AS staff_title, staff.pk AS fk_staff, data_persons1.firstname AS staff_firstname, data_persons1.surname AS staff_surname, data_branches.branch, data_branches.fk_organisation, data_organisations.organisation, vwdocuments.html
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
   LEFT JOIN contacts.data_branches ON forms.fk_branch = data_branches.pk
   LEFT JOIN contacts.data_organisations ON data_branches.fk_organisation = data_organisations.pk
   LEFT JOIN clin_history.past_history ON forms.fk_pasthistory = past_history.pk
   LEFT JOIN documents.vwdocuments ON forms_requests.pk = vwdocuments.fk_request
  WHERE forms.deleted = false AND forms_requests.deleted = false
  ORDER BY consult.fk_patient, forms.date DESC, forms_requests.fk_form, lu_requests.item;

ALTER TABLE clin_requests.vwRequestforms OWNER TO easygp;
GRANT ALL ON TABLE clin_requests.vwRequestforms TO easygp;
GRANT ALL ON TABLE clin_requests.vwRequestforms TO staff;

COMMENT ON VIEW clin_requests.vwRequestforms IS 'A view of just the unique forms, where the forms requests are represented only by for example fbc;uec;lfts
 Note that clin_requests.vwRequestFormsAndRequests has multiple rows for each form, one per request on that form';


CREATE OR REPLACE VIEW clin_requests.vwRequestNames AS 
        (        (         SELECT lu_request_items.pk || '-1'::text AS pk_view, lu_request_items.pk AS fk_lu_request, lu_request_type.type, lu_request_items.fk_lu_request_type, 
                                CASE
                                    WHEN lu_request_items.fk_laterality = 3 THEN lu_request_items.item || ' (LEFT)'::text
                                    ELSE NULL::text
                                END AS item, lu_request_items.fk_laterality, lu_request_items.fk_decision_support, lu_request_items.fk_instruction, lu_instructions.instruction
                           FROM clin_requests.lu_requests lu_request_items
                      JOIN clin_requests.lu_request_type ON lu_request_items.fk_lu_request_type = lu_request_type.pk
                 LEFT JOIN clin_requests.lu_instructions ON lu_request_items.fk_instruction = lu_instructions.pk
                WHERE lower(lu_request_items.item) ~~ '%'::text AND lu_request_items.fk_laterality = 3
                UNION 
                         SELECT lu_request_items.pk || '-2'::text AS pk_view, lu_request_items.pk AS fk_lu_request, lu_request_type.type, lu_request_items.fk_lu_request_type, 
                                CASE
                                    WHEN lu_request_items.fk_laterality = 3 THEN lu_request_items.item || ' (RIGHT)'::text
                                    ELSE NULL::text
                                END AS item, lu_request_items.fk_laterality, lu_request_items.fk_decision_support, lu_request_items.fk_instruction, lu_instructions.instruction
                           FROM clin_requests.lu_requests lu_request_items
                      JOIN clin_requests.lu_request_type ON lu_request_items.fk_lu_request_type = lu_request_type.pk
                 LEFT JOIN clin_requests.lu_instructions ON lu_request_items.fk_instruction = lu_instructions.pk
                WHERE lower(lu_request_items.item) ~~ '%'::text AND lu_request_items.fk_laterality = 3)
        UNION 
                 SELECT lu_request_items.pk || '-3'::text AS pk_view, lu_request_items.pk AS fk_lu_request, lu_request_type.type, lu_request_items.fk_lu_request_type, 
                        CASE
                            WHEN lu_request_items.fk_laterality = 3 THEN lu_request_items.item || ' (BOTH)'::text
                            ELSE NULL::text
                        END AS item, lu_request_items.fk_laterality, lu_request_items.fk_decision_support, lu_request_items.fk_instruction, lu_instructions.instruction
                   FROM clin_requests.lu_requests lu_request_items
              JOIN clin_requests.lu_request_type ON lu_request_items.fk_lu_request_type = lu_request_type.pk
         LEFT JOIN clin_requests.lu_instructions ON lu_request_items.fk_instruction = lu_instructions.pk
        WHERE lower(lu_request_items.item) ~~ '%'::text AND lu_request_items.fk_laterality = 3)
UNION 
         SELECT lu_request_items.pk || '-0'::text AS pk_view, lu_request_items.pk AS fk_lu_request, lu_request_type.type, lu_request_items.fk_lu_request_type, lu_request_items.item, lu_request_items.fk_laterality, lu_request_items.fk_decision_support, lu_request_items.fk_instruction, lu_instructions.instruction
           FROM clin_requests.lu_requests lu_request_items
      JOIN clin_requests.lu_request_type ON lu_request_items.fk_lu_request_type = lu_request_type.pk
   LEFT JOIN clin_requests.lu_instructions ON lu_request_items.fk_instruction = lu_instructions.pk
  WHERE lower(lu_request_items.item) ~~ '%'::text AND lu_request_items.fk_laterality = 0
  ORDER BY 4, 5;

ALTER TABLE clin_requests.vwRequestNames OWNER TO easygp;
GRANT ALL ON TABLE clin_requests.vwRequestNames TO easygp;
GRANT ALL ON TABLE clin_requests.vwRequestNames TO staff;


COMMENT ON VIEW clin_requests.vwRequestNames IS 'a view of everything which is orderable, including lateralisation eg Xray wrist (LEFT), Xray wrist (RIGHT) or Xray Wrist (BOTH)';



truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 35);
