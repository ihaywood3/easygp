alter table blobs.blobs add column created_at timestamp default now ();
alter table documents.documents add column fk_blob integer references blobs.blobs(pk);
create table blobs.backups (
       done_by name default current_user,
       done_at timestamp default now()
);


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 41);
