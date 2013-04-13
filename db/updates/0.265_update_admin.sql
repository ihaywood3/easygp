INSERT INTO admin.lu_clinical_modules(name, icon_path)
    VALUES ('Dictaphone', 'icons/22/media-record');

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 265);

