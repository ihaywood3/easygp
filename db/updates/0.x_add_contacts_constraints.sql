-- Add constraints to contacts
-- do not run this on a production database without trying it on a backup as you could well have data you need to manually fix.
alter table contacts.links_employees_comms add constraint "links_employees_comms_fk_employee_fkey" foreign key (fk_employee) references contacts.data_employees (pk);
alter table contacts.links_employees_comms add constraint "links_employees_comms_fk_comm_fkey" foreign key (fk_comm) references contacts.data_communications (pk);
alter table contacts.links_employees_comms alter COLUMN deleted set not null;
alter table contacts.links_employees_comms alter COLUMN fk_comm set not null;
alter table contacts.links_employees_comms alter COLUMN fk_employee set not null;

alter table contacts.links_persons_addresses add constraint "links_persons_addresses_fk_person_fkey" foreign key (fk_person) references contacts.data_persons(pk);
alter table contacts.links_persons_addresses add constraint "links_persons_addresses_fk_address_fkey" foreign key (fk_address) references contacts.data_addresses(pk);
alter table contacts.links_persons_addresses alter COLUMN deleted set not null;
alter table contacts.links_persons_addresses alter COLUMN fk_address set not null;
alter table contacts.links_persons_addresses alter COLUMN fk_person set not null;

alter table contacts.links_persons_comms add constraint "links_persons_comms_fk_comm_fkey" foreign key (fk_comm) references contacts.data_communications(pk);
alter table contacts.links_persons_comms add constraint "links_persons_comms_fk_person_fkey" foreign key (fk_person) references contacts.data_persons(pk);
alter table contacts.links_persons_comms alter COLUMN deleted set not null;
alter table contacts.links_persons_comms alter COLUMN fk_comm set not null;
alter table contacts.links_persons_comms alter COLUMN fk_person set not null;

alter table contacts.data_addresses add constraint "fk_town" foreign key (fk_town) references contacts.lu_towns (pk);
alter table contacts.data_addresses add constraint "address_type" foreign key (fk_lu_address_type) references contacts.lu_address_types (pk);
alter table contacts.data_addresses alter column fk_town set not null;
update contacts.data_addresses set preferred_address='f' where preferred_address is null;
alter table contacts.data_addresses alter column preferred_address set default false;
update contacts.data_addresses set postal_address='f' where postal_address is null;
alter table contacts.data_addresses alter column postal_address set not null;
alter table contacts.data_addresses alter column head_office set not null;
alter table contacts.data_addresses alter column deleted set not null;
update contacts.data_addresses set fk_lu_address_type = 1 where fk_lu_address_type is null;
alter table contacts.data_addresses alter column fk_lu_address_type set not null;
alter table contacts.data_addresses ALTER COLUMN fk_lu_address_type set default 1;
update contacts.data_addresses set country_code = 'AU' where country_code is null;
alter table contacts.data_addresses ALTER COLUMN country_code set default 'AU';
alter table contacts.data_addresses alter column country_code set not null;

alter table contacts.data_branches add constraint "fk_organisation_fkey" foreign key (fk_organisation) references contacts.data_organisations (pk);
alter table contacts.data_branches alter column fk_organisation set not null;
alter table contacts.data_branches add constraint "fk_address_fkey" foreign key (fk_address) references contacts.data_addresses (pk);
alter table contacts.data_branches alter column deleted set not null;
alter table contacts.data_branches add constraint "fk_category_fkey" foreign key (fk_category) references contacts.lu_categories (pk);
alter table contacts.data_branches alter column fk_category set not null;

alter table contacts.data_communications add constraint "fk_type" foreign key (fk_type) references contacts.lu_contact_type (pk);
alter table contacts.data_communications alter column preferred_method set not null;
alter table contacts.data_communications alter column confidential set not null;
alter table contacts.data_communications alter column deleted set not null;

alter table contacts.data_employees add constraint "fk_branch_fkey" foreign key (fk_branch) references contacts.data_branches (pk);
alter table contacts.data_employees add constraint "fk_person_fkey" foreign key (fk_person) references contacts.data_persons (pk);
alter table contacts.data_employees add constraint "fk_occupation_fkey" foreign key (fk_occupation) references common.lu_occupations (pk);
alter table contacts.data_employees add constraint "fk_status_fkey" foreign key (fk_status) references contacts.lu_employee_status (pk);
alter table contacts.data_employees alter column fk_branch set not null;
alter table contacts.data_employees alter column fk_person set not null;
alter table contacts.data_employees alter column fk_status set not null;
alter table contacts.data_employees alter column deleted set not null;

alter table contacts.data_numbers add constraint "pn_is_alphanumber" CHECK (provider_number ~ '^[0-9]{5,7}[A-Z]{1,2}$'::text);
alter table contacts.data_numbers add constraint "abn_is_number" CHECK (australian_business_number ~ '^[0-9]{11}$'::text);

grant all on contacts.data_numbers_persons to staff;

alter table contacts.data_organisations alter column deleted set not null;

alter table contacts.images alter column deleted set not null;
alter table contacts.images alter column image set not null;

alter table contacts.links_branches_comms alter column fk_branch set not null;
alter table contacts.links_branches_comms alter column fk_comm set not null;
alter table contacts.links_branches_comms alter column deleted set not null;

alter table contacts.lu_address_types add constraint "type_unique" unique (type);
alter table contacts.lu_address_types alter column type set not null;

alter table contacts.lu_categories add constraint "category_unique" unique (category);

alter table contacts.lu_contact_type alter COLUMN type set not null;

alter table contacts.lu_firstnames alter COLUMN firstname set not null;
alter table contacts.lu_firstnames add constraint "firstname_unique" unique (firstname);
alter table contacts.lu_firstnames alter COLUMN sex set not null;
alter table contacts.lu_firstnames alter COLUMN ord set not null;

alter table contacts.lu_sex add constraint "sex_unique" unique (sex);
update contacts.lu_firstnames set sex=upper(sex);
alter table contacts.lu_firstnames add constraint "sex_fkey" foreign key (sex) references contacts.lu_sex (sex);

alter table contacts.lu_marital alter COLUMN marital set NOT NULL ;
alter table contacts.lu_misspelt_towns add constraint "fk_town_fkey" foreign key (fk_town) references contacts.lu_towns (pk);
alter table contacts.lu_misspelt_towns add constraint "town_misspelt_unique" unique (town_misspelt);

alter table contacts.lu_sex alter COLUMN sex SET NOT NULL ;
alter table contacts.lu_sex alter COLUMN sex_text SET NOT NULL ;

delete from contacts.lu_surnames where pk=2071;
delete from contacts.lu_surnames where pk=1931;
delete from contacts.lu_surnames where pk=1303;
delete from contacts.lu_surnames where pk=1536;
delete from contacts.lu_surnames where pk=714;
alter table contacts.lu_surnames add constraint "surname_unique" unique (surname);
alter table contacts.lu_title add constraint "title_unique" unique (title);
alter table contacts.lu_towns add constraint "town_unique" unique (postcode,town,state,"comment");
alter table contacts.lu_towns alter column town set not null;

drop table contacts.todo;



