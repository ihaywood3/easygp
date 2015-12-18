-- after this you will have to fix any plan's by editing them
update clin_mentalhealth.mentalhealth_plan  set fk_progressnote = null where fk_progressnote = 0;
update clin_mentalhealth.mentalhealth_plan set fk_lu_risk_to_others = 5 where fk_lu_risk_to_others is null;

update db.lu_version set lu_minor = 460;
