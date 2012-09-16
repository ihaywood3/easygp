alter table drugs.info add column fk_severity integer references drugs.severity_level (pk);
create table drugs.link_info_source (fk_info integer references drugs.info (pk) not null, fk_source integer references drugs.sources (pk) not null);
alter table drugs.link_info_source owner to easygp;
grant all on drugs.link_info_source to easygp;
grant select on drugs.link_info_source to staff;
alter table drugs.info drop column fk_source;

truncate db.lu_version;

insert into db.lu_version (lu_major,lu_minor) values (0, 225);