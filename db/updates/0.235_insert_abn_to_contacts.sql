alter table  data_numbers add column australian_business_number text default null;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 235);


