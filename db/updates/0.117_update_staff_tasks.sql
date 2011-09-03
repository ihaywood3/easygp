COMMENT ON COLUMN clerical.tasks.fk_row is 'if not null then this is foreign key to documents.pk';
truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 117);
