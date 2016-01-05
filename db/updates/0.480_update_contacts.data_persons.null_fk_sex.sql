-- during contraining my database I had 1 only record missing a sex
update  contacts.data_persons set fk_sex = 2 where fk_sex is null; -- 2=unknown

update db.lu_version set lu_minor = 480;
