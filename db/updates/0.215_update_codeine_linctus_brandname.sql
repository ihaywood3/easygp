-- removes an invisible carriage return in the brand-name
update drugs.brand set brand = 'CODEINE LINCTUS' WHERE pk ='a21b548e-1d98-43a3-b1ad-a0c992a1b05d';

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 215);

