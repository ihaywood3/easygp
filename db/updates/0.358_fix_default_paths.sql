update admin.lu_preferences_defaults set value='/var/lib/easygp/drug_pis' where "name" = 'product_information_directory';
update admin.lu_preferences_defaults set value='/var/lib/easygp/hl7/outgoing' where "name" = 'hl7_outgoing_directory';
update admin.lu_preferences_defaults set value='/var/lib/easygp/hl7/incoming' where "name" = 'hl7_incoming_directory';

update db.lu_version set lu_minor=358;
