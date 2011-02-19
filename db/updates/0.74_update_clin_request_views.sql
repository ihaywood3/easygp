
DROP VIEW clin_requests.vwrequestproviders;

CREATE OR REPLACE VIEW clin_requests.vwrequestproviders AS 
 SELECT data_organisations.organisation, lu_categories.category AS branch_category, lu_request_type.type, 
 data_branches.branch AS default_branch, request_providers.pk AS pk_request_provider, 
 request_providers.fk_branch AS fk_default_branch, request_providers.fk_employee, request_providers.fk_person, 
 request_providers.fk_lu_request_type, data_branches.fk_organisation, data_branches.deleted AS default_branch_deleted, 
 data_branches.fk_address, data_branches.memo AS default_branch_memo, data_branches.fk_category, 
 data_addresses.street AS default_branch_street, data_addresses.deleted AS address_deleted, data_addresses.fk_town, 
 lu_towns.postcode AS default_branch_postcode, lu_towns.town AS default_branch_town, lu_towns.state AS default_branch_state, 
 data_addresses1.street AS headoffice_street, data_addresses1.head_office, lu_towns1.postcode AS headoffice_postcode, 
 lu_towns1.town AS headoffice_town, lu_towns1.state AS headoffice_state, data_branches1.pk AS fk_headoffice_branch
   FROM clin_requests.request_providers
   JOIN contacts.data_branches ON request_providers.fk_branch = data_branches.pk
   JOIN contacts.data_organisations ON data_branches.fk_organisation = data_organisations.pk
   JOIN contacts.lu_categories ON data_branches.fk_category = lu_categories.pk
   JOIN clin_requests.lu_request_type ON request_providers.fk_lu_request_type = lu_request_type.pk
   LEFT JOIN contacts.data_addresses ON data_branches.fk_address = data_addresses.pk
   LEFT JOIN contacts.lu_towns ON data_addresses.fk_town = lu_towns.pk
   JOIN contacts.data_branches data_branches1 ON data_organisations.pk = data_branches1.fk_organisation
   JOIN contacts.data_addresses data_addresses1 ON data_branches1.fk_address = data_addresses1.pk
   JOIN contacts.lu_towns lu_towns1 ON data_addresses1.fk_town = lu_towns1.pk
  WHERE request_providers.fk_employee = 0 AND request_providers.fk_person = 0 AND data_addresses1.head_office = true;

ALTER TABLE clin_requests.vwrequestproviders OWNER TO easygp;
GRANT ALL ON TABLE clin_requests.vwrequestproviders TO easygp;
GRANT ALL ON TABLE clin_requests.vwrequestproviders TO staff;
COMMENT ON VIEW clin_requests.vwrequestproviders IS ' View of providers who we may send requests to
 Note: it is possible in contacts for user not to put in an addresss, hence the outer joins here
 ';



 DROP VIEW clin_requests.vwuserproviderdefaults;

CREATE OR REPLACE VIEW clin_requests.vwuserproviderdefaults AS 
 SELECT user_provider_defaults.pk AS pk_default, user_provider_defaults.fk_staff, user_provider_defaults.fk_default_branch,
 user_provider_defaults.fk_head_office_branch, user_provider_defaults.send_electronically, user_provider_defaults.print_paper,
 user_provider_defaults.deleted, user_provider_defaults.fk_lu_request_type, data_branches.branch AS default_branch,
 data_branches.fk_organisation, data_branches.fk_address, data_branches.memo AS default_branch_memo, data_branches.fk_category,
 data_branches.deleted AS default_branch_deleted, data_organisations.organisation, lu_request_type.type AS request_type,
 lu_categories.category AS category_organisation, data_addresses.street AS default_branch_street,
 lu_towns.town AS default_branch_town, lu_towns.postcode AS default_branch_postcode,
 data_branches1.branch AS headoffice_branch, data_addresses1.street AS headoffice_street,
 lu_towns1.postcode AS headoffice_postcode, lu_towns1.town AS headoffice_town
   FROM clin_requests.user_provider_defaults
   JOIN contacts.data_branches ON user_provider_defaults.fk_default_branch = data_branches.pk
   JOIN contacts.data_organisations ON data_branches.fk_organisation = data_organisations.pk
   JOIN clin_requests.lu_request_type ON user_provider_defaults.fk_lu_request_type = lu_request_type.pk
   JOIN contacts.lu_categories ON data_branches.fk_category = lu_categories.pk
   JOIN contacts.data_addresses ON data_branches.fk_address = data_addresses.pk
   JOIN contacts.lu_towns ON data_addresses.fk_town = lu_towns.pk
   JOIN contacts.data_branches data_branches1 ON user_provider_defaults.fk_head_office_branch = data_branches1.pk
   JOIN contacts.data_addresses data_addresses1 ON data_branches1.fk_address = data_addresses1.pk
   JOIN contacts.lu_towns lu_towns1 ON data_addresses1.fk_town = lu_towns1.pk
  ORDER BY user_provider_defaults.fk_staff;

ALTER TABLE clin_requests.vwuserproviderdefaults OWNER TO easygp;
GRANT ALL ON TABLE clin_requests.vwuserproviderdefaults TO easygp;
GRANT ALL ON TABLE clin_requests.vwuserproviderdefaults TO staff;



truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 74)
