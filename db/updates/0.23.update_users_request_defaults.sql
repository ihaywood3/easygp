alter table clin_requests.user_provider_defaults
add column fk_lu_request_type integer not null;

DROP VIEW clin_requests.vwuserproviderdefaults;

CREATE OR REPLACE VIEW clin_requests.vwuserproviderdefaults AS 
 SELECT user_provider_defaults.pk as pk_default, user_provider_defaults.fk_staff, user_provider_defaults.fk_default_branch, user_provider_defaults.fk_head_office_branch, user_provider_defaults.send_electronically, user_provider_defaults.print_paper, user_provider_defaults.deleted, user_provider_defaults.fk_lu_request_type, data_branches.branch AS default_branch, data_branches.fk_organisation, data_branches.fk_address, data_branches.memo AS default_branch_memo, data_branches.fk_category, data_branches.deleted AS default_branch_deleted, data_organisations.organisation, lu_request_type.type AS request_type, lu_categories.category AS category_organisation, data_addresses.street AS default_branch_street, lu_towns.town AS default_branch_town, lu_towns.postcode AS default_branch_postcode, data_branches1.branch AS headoffice_branch, data_addresses1.street AS headoffice_street, lu_towns1.postcode AS headoffice_postcode, lu_towns1.town AS headoffice_town
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

GRANT ALL ON TABLE clin_requests.vwuserproviderdefaults TO staff;

-- changes to FRequests and Clin_requests to confirm to lookup table name changes

ALTER TABLE clin_requests.forms   RENAME COLUMN fk_lu_type TO fk_lu_request_type;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 23);

