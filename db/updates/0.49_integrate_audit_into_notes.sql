CREATE TABLE clin_consult.lu_audit_reasons
(
  pk serial NOT NULL,
  fk_staff integer,
  reason text,
  CONSTRAINT lu_reasons_pkey PRIMARY KEY (pk)
);
GRANT SELECT, INSERT ON TABLE clin_consult.lu_audit_reasons TO staff;
grant all on sequence clin_consult.lu_audit_reasons_pk_seq to staff;
COMMENT ON TABLE clin_consult.lu_audit_reasons IS 'keeps reasons for the audit action on per-user basis';
insert into clin_consult.lu_audit_reasons (pk,fk_staff,reason) select pk, fk_staff, reason from audit.lu_reasons; 

select setval('clin_consult.lu_audit_reasons_pk_seq',nextval('audit.lu_reasons_pk_seq'));

CREATE TABLE clin_consult.lu_actions
(
  pk serial NOT NULL primary key,
  "action" text NOT NULL,
  insist_reason boolean not null default 'f'
 );
GRANT SELECT ON TABLE clin_consult.lu_actions TO staff;
COMMENT ON TABLE clin_consult.lu_actions IS 'the action undertaken by the audit eg insert, update, delete, complete etc';
\copy clin_consult.lu_actions("action",insist_reason) from stdin with delimiter '|'
progress note|f
insert|f
update|f
mark deleted|t
reversal|f
completed|f
completed with explanation|t
completed repeat same interval|f
completed repeat new interval|f
refused|f
refused with explanation|f
make active|f
make inactive|f
make significant|f
make major|f
not due|f
overdue|f
reminder sent|f
arranged not completed|f
file import|f
document filed|f
staff task allocated|f
\.
drop schema audit cascade;

alter table clin_consult.progressnotes add column linked_table regclass;
alter table clin_consult.progressnotes add column fk_row integer;
alter table clin_consult.progressnotes add column fk_audit_reason integer references clin_consult.lu_audit_reasons (pk);
alter table clin_consult.progressnotes alter column fk_audit_action set default 1;
alter table clin_consult.progressnotes add constraint action_action_ref foreign key (fk_audit_action) references clin_consult.lu_actions (pk);
alter table clin_consult.progressnotes drop column display;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 49);
