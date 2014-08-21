update documents.lu_display_as set display_as = 'team care arrangement' where display_as = 'tca';
update documents.lu_display_as set display_as = 'gp management plan' where display_as = 'gpmp';
update documents.lu_display_as set display_as = 'mental health pLan' where display_as = 'mhp';
update db.lu_version set lu_minor=388;