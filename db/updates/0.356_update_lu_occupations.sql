-- this may not be in the original dataset, but update to be sure.

update common.lu_occupations set occupation = 'stevedore' where occupation = 'stevadore';

update db.lu_version set lu_minor=356;

