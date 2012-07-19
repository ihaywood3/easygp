
-- quick-n-dirty fix 
update drugs.product set amount=null, amount_unit=null, pack_size=28
where amount_unit=6;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 197);

