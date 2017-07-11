Alter table billing.items_billed add column deletion_explanation_code integer default null;
Comment on column  items_billed.deletion_explanation_code is

'- this only applies to bulk billed items
 - is the key to billing.lu_codes 
 - if not null then points to the medicare code where an item has not been paid and is marked as deleted
   e.g 529 = bulkbill additional item claimed incorrectlly
 - internally in EasyGP when an item is not paid it has to be marked off the invoice as deleted';


 update db.lu_version set lu_minor=524;