

  create or replace view contacts.vworganisations as
SELECT distinct on (branches.pk)
branches.pk::bigint AS pk_view,
  clinics.pk AS fk_clinic,
    organisations.organisation,
    organisations.deleted AS organisation_deleted,
    branches.pk AS fk_branch,
    branches.branch,
    branches.fk_organisation,
    branches.deleted AS branch_deleted,
    branches.fk_address,
    branches.memo,
    branches.fk_category,
    categories.category,
    addresses.street1,
    addresses.street2,
    addresses.fk_town,
    addresses.preferred_address,
    addresses.postal_address,
    addresses.head_office,
    addresses.country_code,
    addresses.fk_lu_address_type,
    addresses.deleted AS address_deleted,
    towns.postcode,
    towns.town,
    towns.state,
    data_numbers.australian_business_number,
    vbc.value AS fax,
    data_numbers.hpio
   FROM contacts.data_branches branches
   JOIN contacts.data_organisations organisations ON branches.fk_organisation = organisations.pk
   JOIN contacts.lu_categories categories ON branches.fk_category = categories.pk
   LEFT JOIN contacts.data_addresses addresses ON branches.fk_address = addresses.pk
   LEFT JOIN contacts.lu_address_types ON addresses.fk_lu_address_type = lu_address_types.pk
   LEFT JOIN contacts.lu_towns towns ON addresses.fk_town = towns.pk
   LEFT JOIN admin.clinics ON branches.pk = clinics.fk_branch
   LEFT JOIN contacts.data_numbers ON branches.pk = data_numbers.fk_branch AND data_numbers.fk_person IS NULL
   LEFT JOIN contacts.vwbranchescomms vbc ON (branches.pk = vbc.fk_branch and vbc.fk_type = 2);

update db.lu_version set lu_minor=369;

