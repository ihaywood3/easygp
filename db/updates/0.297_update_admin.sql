INSERT INTO admin.lu_clinical_modules(name, icon_path)
    VALUES ('INR', 'icons/20/inr2020.png');

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 297);

