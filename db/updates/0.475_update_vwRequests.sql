-- fix yet another left over 0 in fk_occupation

alter table clin_requests.user_provider_defaults rename column fk_default_branch to fk_default_branch_user;

COMMENT ON COLUMN clin_requests.user_provider_defaults.fk_default_branch_user IS
'If  you look at the table clin_requests.request_providers you will see there is a fk_default_branch field.
 This is set by Admin when they designate that a particular company can be used to send particular types of
 requests, and they ''guess'' the most likely branch  users will use.

 This field fk_default_branch_user will over-ride Admins default if it is different';


DROP VIEW clin_requests.vwrequestproviders cascade;

CREATE OR REPLACE VIEW clin_requests.vwrequestproviders AS 
 SELECT request_providers.pk AS pk_request_provider,
    lu_request_type.type,
    request_providers.fk_headoffice_branch,
    request_providers.fk_default_branch,
    request_providers.fk_employee,
    request_providers.fk_person,
    request_providers.fk_lu_request_type,
    request_providers.deleted AS request_provider_deleted,
    request_providers.staff_default,
    data_organisations.organisation,
    lu_categories.category,
    data_branches.branch AS headoffice_branch,
    data_branches.fk_organisation,
    data_branches.deleted AS headoffice_branch_deleted,
    data_addresses.street1 AS headoffice_street1,
    data_addresses.street2 AS headoffice_street2,
    data_addresses.deleted AS headoffice_address_deleted,
    lu_towns.postcode AS headoffice_postcode,
    lu_towns.town AS headoffice_town,
    lu_towns.state AS headoffice_state,
    NULL::text AS wholename,
    NULL::text AS firstname,
    NULL::text AS surname,
    NULL::text AS salutation,
    0 AS fk_title,
    NULL::text AS title,
    0 AS fk_sex,
    NULL::text AS sex,
    Null AS fk_occupation,
    NULL::text AS occupation,
    data_branches1.branch AS default_branch,
    data_addresses1.street1 AS default_branch_street1,
    data_addresses1.street2 AS default_branch_street2,
    lu_towns1.postcode AS default_branch_postcode,
    lu_towns1.town AS default_branch_town,
    lu_towns1.state AS default_branch_state
   FROM clin_requests.request_providers
     JOIN contacts.data_branches ON request_providers.fk_headoffice_branch = data_branches.pk
     JOIN contacts.data_organisations ON data_branches.fk_organisation = data_organisations.pk
     JOIN contacts.lu_categories ON data_branches.fk_category = lu_categories.pk
     JOIN clin_requests.lu_request_type ON request_providers.fk_lu_request_type = lu_request_type.pk
     LEFT JOIN contacts.data_addresses ON data_branches.fk_address = data_addresses.pk
     LEFT JOIN contacts.lu_towns ON data_addresses.fk_town = lu_towns.pk
     JOIN contacts.data_branches data_branches1 ON request_providers.fk_default_branch = data_branches1.pk
     LEFT JOIN contacts.data_addresses data_addresses1 ON data_branches1.fk_address = data_addresses1.pk
     LEFT JOIN contacts.lu_towns lu_towns1 ON data_addresses1.fk_town = lu_towns1.pk
  WHERE request_providers.fk_employee IS NULL AND request_providers.fk_person IS NULL
UNION
 SELECT request_providers.pk AS pk_request_provider,
    lu_request_type.type,
    request_providers.fk_headoffice_branch,
    request_providers.fk_default_branch,
    request_providers.fk_employee,
    request_providers.fk_person,
    request_providers.fk_lu_request_type,
    request_providers.deleted AS request_provider_deleted,
    request_providers.staff_default,
    NULL::text AS organisation,
    NULL::character varying AS category,
    'HEAD OFFICE'::text AS headoffice_branch,
    NULL::integer AS fk_organisation,
    NULL::boolean AS headoffice_branch_deleted,
    vwpersons.street1 AS headoffice_street1,
    vwpersons.street2 AS headoffice_street2,
    NULL::boolean AS headoffice_address_deleted,
    vwpersons.postcode AS headoffice_postcode,
    vwpersons.town AS headoffice_town,
    vwpersons.state AS headoffice_state,
    vwpersons.wholename,
    vwpersons.firstname,
    vwpersons.surname,
    vwpersons.salutation,
    vwpersons.fk_title,
    vwpersons.title,
    vwpersons.fk_sex,
    vwpersons.sex,
    vwpersons.fk_occupation,
    vwpersons.occupation,
    NULL::text AS default_branch,
    vwpersons.street1 AS default_branch_street1,
    vwpersons.street2 AS default_branch_street2,
    vwpersons.postcode AS default_branch_postcode,
    vwpersons.town AS default_branch_town,
    vwpersons.state AS default_branch_state
   FROM clin_requests.request_providers
     JOIN clin_requests.lu_request_type ON request_providers.fk_lu_request_type = lu_request_type.pk
     JOIN contacts.vwpersons ON request_providers.fk_person = vwpersons.fk_person
  WHERE request_providers.fk_person IS NOT NULL;

ALTER TABLE clin_requests.vwrequestproviders   OWNER TO easygp;
GRANT ALL ON TABLE clin_requests.vwrequestproviders TO staff;
COMMENT ON VIEW clin_requests.vwrequestproviders
  IS ' View of providers who we may send requests to
 Note: it is possible in contacts for user not to put in an addresss, hence the outer joins here
 ';

CREATE OR REPLACE VIEW clin_requests.vwuserproviderdefaults AS 
SELECT 
    vwrequestproviders.type as request_type,
    vwrequestproviders.fk_headoffice_branch,
    vwrequestproviders.fk_employee,
    vwrequestproviders.fk_person,
    vwrequestproviders.fk_lu_request_type,
    vwrequestproviders.request_provider_deleted,
    vwrequestproviders.staff_default,
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
    user_provider_defaults.fk_staff,
    user_provider_defaults.fk_request_provider,
    user_provider_defaults.pk AS pk_default,
    user_provider_defaults.send_electronically,
    user_provider_defaults.print_paper,
    user_provider_defaults.deleted,
    user_provider_defaults.fk_default_branch_user,
    vwrequestproviders.default_branch,
    vwrequestproviders.default_branch_street1,
    vwrequestproviders.default_branch_street2,
    vwrequestproviders.default_branch_postcode,
    vwrequestproviders.default_branch_town,
    vwrequestproviders.default_branch_state
FROM clin_requests.user_provider_defaults
     JOIN clin_requests.vwrequestproviders ON user_provider_defaults.fk_request_provider = vwrequestproviders.pk_request_provider
     LEFT JOIN contacts.data_branches ON user_provider_defaults.fk_default_branch_user = data_branches.pk
     LEFT JOIN contacts.data_addresses ON data_branches.fk_address = data_addresses.pk
     LEFT JOIN contacts.lu_towns ON data_addresses.fk_town = lu_towns.pk
     JOIN clin_requests.lu_request_type ON user_provider_defaults.fk_lu_request_type = lu_request_type.pk
  WHERE user_provider_defaults.fk_default_branch_user IS NOT NULL

  UNION
  
 SELECT vwrequestproviders.type as request_type,
    vwrequestproviders.fk_headoffice_branch,
    vwrequestproviders.fk_employee,
    vwrequestproviders.fk_person,
    vwrequestproviders.fk_lu_request_type,
    vwrequestproviders.request_provider_deleted,
    vwrequestproviders.staff_default,
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
    user_provider_defaults.fk_staff,
    user_provider_defaults.fk_request_provider,
    user_provider_defaults.pk AS pk_default,
    user_provider_defaults.send_electronically,
    user_provider_defaults.print_paper,
    user_provider_defaults.deleted,
    clin_requests.user_provider_defaults.fk_default_branch_user,
    data_branches.branch AS default_branch,
    data_addresses.street1 AS default_branch_street1,
    data_addresses.street2 AS default_branch_street2,
    lu_towns.postcode AS default_branch_postcode,
    lu_towns.town AS default_branch_town,
    lu_towns.state AS default_branch_state
 FROM clin_requests.user_provider_defaults
     JOIN clin_requests.vwrequestproviders ON user_provider_defaults.fk_request_provider = vwrequestproviders.pk_request_provider
     LEFT JOIN contacts.data_branches ON user_provider_defaults.fk_default_branch_user = data_branches.pk
     LEFT JOIN contacts.data_addresses ON data_branches.fk_address = data_addresses.pk
     LEFT JOIN contacts.lu_towns ON data_addresses.fk_town = lu_towns.pk
  WHERE user_provider_defaults.fk_default_branch_user IS NOT NULL;
  
 
ALTER TABLE clin_requests.vwuserproviderdefaults  OWNER TO easygp;
GRANT ALL ON TABLE clin_requests.vwuserproviderdefaults TO staff;

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

update db.lu_version set lu_minor = 475;
