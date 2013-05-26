create or replace view contacts.vworganisations as  

SELECT distinct branches.pk* organisations.pk::bigint as pk_view, clinics.pk AS fk_clinic, organisations.organisation, organisations.deleted AS organisation_deleted, branches.pk AS fk_branch, branches.branch, branches.fk_organisation, branches.deleted AS branch_deleted, branches.fk_address, branches.memo, branches.fk_category, categories.category, addresses.street1, addresses.street2, addresses.fk_town, addresses.preferred_address, addresses.postal_address, addresses.head_office, addresses.country_code, addresses.fk_lu_address_type, addresses.deleted AS address_deleted, towns.postcode, towns.town, towns.state, data_numbers.australian_business_number, data_communications.value as fax
   FROM contacts.data_branches branches
   JOIN contacts.data_organisations organisations ON branches.fk_organisation = organisations.pk
   JOIN contacts.lu_categories categories ON branches.fk_category = categories.pk
   LEFT JOIN contacts.data_addresses addresses ON branches.fk_address = addresses.pk
   LEFT JOIN contacts.lu_address_types ON addresses.fk_lu_address_type = lu_address_types.pk
   LEFT JOIN contacts.lu_towns towns ON addresses.fk_town = towns.pk
   LEFT JOIN admin.clinics ON branches.pk = clinics.fk_branch
   LEFT JOIN contacts.data_numbers ON branches.pk = data_numbers.fk_branch
   lEFT JOIN contacts.links_branches_comms on branches.pk = links_branches_comms.fk_branch
   LEFT JOIN contacts.data_communications on (links_branches_comms.fk_comm = data_communications.pk and data_communications.fk_type =2);

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 284)
