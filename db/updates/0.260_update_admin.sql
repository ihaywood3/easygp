INSERT INTO admin.lu_clinical_modules(name, icon_path)
    VALUES ('Recreational Drugs', 'icons/20/recreationaldrugs2020.png');

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 260);

