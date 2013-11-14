-- added a new audit action, new progress note section (pregnancy)
insert into clin_consult.lu_audit_actions(pk,action,insist_reason) values (37,'document metadata edited', false);
insert into clin_consult.lu_audit_actions(pk,action,insist_reason) values (38,'staff task deleted',True);
insert into clin_consult.lu_audit_actions(pk,action,insist_reason) values (39,'staff task finalised with explanation',True);
insert into clin_consult.lu_audit_actions(pk,action,insist_reason) values (40,'recall logged',False);
insert into clin_consult.lu_audit_actions(pk,action,insist_reason) values (41,'recall edited',False);
update clin_consult.lu_audit_actions set insist_reason=true where action='undelete';

-- delete tables no longer needed as 'scratchpad' no longer exists and replaced by FPatientTasks
-- cascade drops to the scratchpad view
drop table clin_consult.scratchpad cascade ;
drop table clin_consult.lu_scratchpad_status;

insert into clin_consult.lu_progressnotes_sections (section) values ('pregnancy');

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 328)

