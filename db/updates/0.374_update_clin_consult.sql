Insert into clin_consult.lu_consult_type (type, user_selectable) values ('Transcribed Letter',false);
Insert into clin_consult.lu_consult_type (type, user_selectable) values ('Transcribed Clinical Notes',false);
insert into clin_consult.lu_audit_actions (pk, action, insist_reason) values (42,'clerical transcribing dictation', FALSE);

update db.lu_version set lu_minor=374;


