-- Ian's addition working towards implementing the PCEHR

insert into clin_consult.lu_audit_actions values (36,'PCEHR automated entry',false);

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 300)
