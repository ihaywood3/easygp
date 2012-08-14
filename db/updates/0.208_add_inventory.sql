-- some tables as first attempt to establish an inventory system.

--drop table clerical.lu_inventory_categories;
--drop table clerical.inventory_locations cascade;
--drop table clerical.lu_inventory_items cascade;
--drop table clerical.inventory cascade;
--drop table clerical.inventory_lent;

create table clerical.lu_inventory_categories
(pk serial primary key,
 category text not null);

alter table clerical.lu_inventory_categories owner to easygp;
Grant all on table clerical.lu_inventory_categories to easygp;
Grant all on table clerical.lu_inventory_categories to staff;

 Comment on table clerical.lu_inventory_categories is
 'The category e.g ''IT equipment'' or ''medical supplies'' or ''clerical supplies'' - this can be added to as needed
 this is a lookup table as it will be dumped with the database definition';

Insert into clerical.lu_inventory_categories (category) values ('office - fixture');
Insert into clerical.lu_inventory_categories (category) values ('office - furniture');
Insert into clerical.lu_inventory_categories (category) values ('stationary');
Insert into clerical.lu_inventory_categories (category) values ('medical supplies');
Insert into clerical.lu_inventory_categories (category) values ('electronic equipment');
Insert into clerical.lu_inventory_categories (category) values ('books');
Insert into clerical.lu_inventory_categories (category) values ('kitchen equipment');
Insert into clerical.lu_inventory_categories (category) values ('gym equipment');
Insert into clerical.lu_inventory_categories (category) values ('cleaning');
Insert into clerical.lu_inventory_categories (category) values ('medical equipment');
Insert into clerical.lu_inventory_categories (category) values ('building fixtures');
Insert into clerical.lu_inventory_categories (category) values ('gardening equipment');
Insert into clerical.lu_inventory_categories (category) values ('toys');


Create table clerical.inventory_locations
(pk serial primary key,
 fk_clinic integer not null,
 location text not null,
CONSTRAINT inventory_locations_fk_clinic_fkey FOREIGN KEY (fk_clinic)
      REFERENCES admin.clinics (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION)
 ;

alter table clerical.inventory_locations owner to easygp;
Grant all on table clerical.inventory_locations to easygp;
Grant all on table clerical.inventory_locations to staff;


 comment on table clerical.inventory_locations is
 'the location within the clinic or it''s environs where the inventory item is located';
 
Create table clerical.lu_inventory_items
(pk serial primary key,
 fk_lu_inventory_category integer not null,
 item text not null
 );

alter table clerical.lu_inventory_items owner to easygp;
Grant all on table clerical.lu_inventory_items to easygp;
Grant all on table clerical.lu_inventory_items to staff;


 comment on table clerical.lu_inventory_items is
 'a look up table of items which can be part on an inventory eg sphygmomanometer
  this is a lookup table as it will be dumped with the database definition';
 comment on column clerical.lu_inventory_items.item is 'the item e.g computer';

 
create table clerical.inventory
(pk serial primary key,
 fk_lu_inventory_item integer not null,
 fk_image integer default null,
 fk_inventory_location integer not null,
 fk_branch_purchased_from integer default null,
 fk_employee_purchased_from integer default null,
 fk_person_purchased_from integer default null,
 date_purchased timestamp without time zone default null,
 purchase_price money default null,
 "comment" text default null,
  CONSTRAINT inventory_fk_inventory_item_fkey FOREIGN KEY (fk_lu_inventory_item)
      REFERENCES clerical.lu_inventory_items (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
 CONSTRAINT inventory_fk_inventory_location_fkey FOREIGN KEY (fk_inventory_location)
      REFERENCES clerical.inventory_locations (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
 );

alter table clerical.inventory owner to easygp;
Grant all on table clerical.inventory to easygp;
Grant all on table clerical.inventory to staff;


 
 Comment on table clerical.inventory is
 'Keeps list of all equipment, where held etc';
  comment on column clerical.inventory.fk_image is 'if not null then points to image of the equipment';
 Comment on column  clerical.inventory.fk_branch_purchased_from is
 'if not null then points to contacts.data_branches.pk ie the organisation and branch the item was purchase from';
Comment on column  clerical.inventory.fk_employee_purchased_from is
'if not null then points to contacts.data_employees.pk .i.e the employee from whom purchased the item.';
Comment on column  clerical.inventory.fk_person_purchased_from is
'if not null then points to contacts.data persons.pk .i.e the person from whom purchased the item';


 Create table clerical.inventory_lent
 (pk serial primary key,
  fk_inventory integer not null,
  fk_patient  integer not null,
  fk_staff integer not null,
  date_lent timestamp without time zone not null,
  date_due  timestamp without time zone not null,
  comment text default null,
  CONSTRAINT inventory_lent_fk_inventory_fkey FOREIGN KEY (fk_inventory)
      REFERENCES clerical.inventory (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
 CONSTRAINT inventory_lent_fk_patient_fkey FOREIGN KEY (fk_patient)
      REFERENCES clerical.data_patients (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
 CONSTRAINT inventory_lent_fk_staff_fkey FOREIGN KEY (fk_staff)
      REFERENCES admin.staff (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
  );


alter table clerical.inventory_lent owner to easygp;
Grant all on table clerical.inventory_lent to easygp;
Grant all on table clerical.inventory_lent to staff;

create or replace view clerical.vwInventory as
SELECT 
  clerical.inventory.pk,
  clerical.lu_inventory_items.item,
  clerical.lu_inventory_categories.category,
  clerical.inventory_locations.location,
  clerical.inventory.date_purchased,
  clerical.inventory.purchase_price,
  clerical.inventory.comment,
  admin.vwclinics.branch,
  admin.vwclinics.organisation,
  admin.vwclinics.street1,
  admin.vwclinics.street2,
  admin.vwclinics.town,
  admin.vwclinics.postcode,
  admin.vwclinics.state,
  blobs.images.image AS inventory_item_image,
  blobs.images.deleted AS inventory_item_deleted,
  blobs.images.md5sum AS inventory_item_md5sum,
  blobs.images.tag AS inventory_item_tag,
  contacts.data_branches.branch AS branch_purchased_from,
  contacts.data_organisations.organisation AS organisation_purchased_from,
  clerical.inventory.fk_lu_inventory_item,
  clerical.inventory.fk_image,
  clerical.inventory.fk_inventory_location,
  clerical.inventory.fk_branch_purchased_from,
  clerical.inventory.fk_employee_purchased_from,
  clerical.inventory.fk_person_purchased_from,
  clerical.lu_inventory_items.fk_lu_inventory_category
FROM
  clerical.inventory
  INNER JOIN clerical.lu_inventory_items ON (clerical.inventory.fk_lu_inventory_item = clerical.lu_inventory_items.pk)
  INNER JOIN clerical.lu_inventory_categories ON (clerical.lu_inventory_items.fk_lu_inventory_category = clerical.lu_inventory_categories.pk)
  LEFT OUTER JOIN blobs.images ON (clerical.inventory.fk_image = blobs.images.pk)
  INNER JOIN clerical.inventory_locations ON (clerical.inventory.fk_inventory_location = clerical.inventory_locations.pk)
  INNER JOIN admin.vwclinics ON (clerical.inventory_locations.fk_clinic = admin.vwclinics.fk_clinic)
  LEFT OUTER JOIN contacts.data_branches ON (clerical.inventory.fk_branch_purchased_from = contacts.data_branches.pk)
  LEFT OUTER JOIN contacts.data_organisations ON (contacts.data_branches.fk_organisation = contacts.data_organisations.pk);

alter view clerical.vwinventory owner to easygp;
Grant all on  clerical.vwinventory to easygp;
Grant all on  clerical.vwinventory to staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 208);

