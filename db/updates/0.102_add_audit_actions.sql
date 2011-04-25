INSERT INTO clin_consult.lu_audit_actions("action", insist_reason)
    VALUES ('progress note edited', True);

  truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 102)
