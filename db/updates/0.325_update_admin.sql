-- spelling error in table fixed, however the key sequence is out of whack, Ian can you fix

update admin.lu_staff_roles set role = 'locum' where pk=3;
insert into admin.lu_staff_roles(pk,role) values (13,'practice principal');

truncate db.lu_version;
insert into db.lu_version(lu_major, lu_minor)values(0, 325);
