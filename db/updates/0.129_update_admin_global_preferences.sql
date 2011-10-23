
Alter TABLE "admin".global_preferences add column fk_staff integer default null;
comment on column admin.global_preferences.fk_staff is
'if not null, then this is a staff preference';


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 129);

