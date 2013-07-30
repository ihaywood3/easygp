---miscellanous comments and permissions

comment on table common.lu_occupations is
'A user list of unique occupations. As this is user-maintained spelling mistakes could be possible though the core
 list has been vetted. We hope at some point to link this list to the coded lu_occupations_abs_coded supplied from
 the Australian Beaureau of Statistics, though that list is not descriptive enough to cover many peoples occupations';

comment on column common.lu_occupations.referrer_type is '
 If EasyGP is being used by a specialist, they need to know about the type of referrer:
 s (specialists: can only refer for 3 months)
 g (generalists: GPs and hospital docs, can refer for 12 months)
 o (everyone else that can''t refer at all)';

GRANT SELECT on drugs.version to staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 309);
