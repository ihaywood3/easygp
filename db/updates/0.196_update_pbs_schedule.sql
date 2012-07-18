update drugs.product set fk_schedule=4;
 -- set them all to 4 to start
update drugs.product set fk_schedule=8 where atccode ilike 'N01AH%';
 --opioid anaesthetics
update drugs.product set fk_schedule=8 where atccode ilike 'N02A%' or atccode ilike 'R05DA%';
 -- rest of the opioids
update drugs.product set fk_schedule=8 where atccode ilike 'N06B%';
 -- Ritalin and friends
update drugs.product set fk_schedule=8 where atccode ilike 'N01AF%' or
atccode ilike 'N01AG%' or atccode ilike 'N03AA%' or atccode ilike 'N05CA%';
 -- barbiturates
update drugs.product set fk_schedule=8 where atccode = 'N05CD03';
 -- Rohypnol

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 196);

