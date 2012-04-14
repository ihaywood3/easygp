
alter table drugs.product add column shared boolean default true;
comment on column drugs.product.shared is 'if true then the user/surgery wants to share this drug with easygp-central';

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 152);


