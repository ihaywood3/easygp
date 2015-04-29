
grant select on documents.lu_display_as to staff;
grant select on billing.vwinvoices to staff;
grant select on billing.vwitemsandinvoices to staff;
 grant select on billing.vwitemsbilled to staff;
update db.lu_version set lu_minor=397;
