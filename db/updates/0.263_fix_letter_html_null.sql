alter table clin_referrals.referrals alter column letter_html drop not null;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 263);
