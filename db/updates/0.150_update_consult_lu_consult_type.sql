-- added new type of consult to track origin of recalls, comments, new health issues etc
-- which were added from the inbox

alter table clin_consult.lu_consult_type add column user_selectable boolean default true;
update  clin_consult.lu_consult_type set user_selectable = false where pk > 9;
insert into clin_consult.lu_consult_type (type,user_selectable) values ('Added from Inbox',false);

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 150);

