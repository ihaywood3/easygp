--inserted to take care of imported data where the town is missing
-- just co-incidentally our keys started from 2.

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 290);

insert into contacts.lu_towns (pk, postcode,town,state,"comment")
values (1, '0000', 'MISSING TOWN','NIL','this is to be used where the town is missing');

