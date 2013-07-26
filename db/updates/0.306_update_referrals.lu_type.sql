-- spelling mistake fixed
update clin_referrals.lu_type set type = 'Indefinite Referral' where pk=5;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 306);
