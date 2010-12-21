-- a little document housekeeping, table dropping

insert into documents.lu_display_as (display_as) values ('certificate');
insert into documents.lu_display_as (display_as) values ('image');

drop table documents.copies_to;
drop table documents.link_document_action;
drop table documents.link_document_task;
drop table documents.lu_stakeholder_type;
drop table documents.lu_stakeholders;
drop table documents.stakeholders;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 55)

