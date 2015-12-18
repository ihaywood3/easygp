Update clin_consult.consult set fk_type = 1 where fk_type = 0; -- must be a bug in FClinical not setting the type
update db.lu_version set lu_minor = 458;
