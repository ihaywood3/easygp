insert into clerical.lu_centrelink_card_type(pk,type) values (5,'PBS Safety Net card');

insert into clerical.lu_veteran_card_type (pk,type) values (5,'Orange - RPBS only');

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 342);

