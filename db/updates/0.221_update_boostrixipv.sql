-- Boostrix ipv in the database has a \n character in between the boostrix and the ipv and the tetanus and the toxoid
update drugs.brand set brand = 'BOOSTRIX IPV' WHERE PK ='e29947a8-0424-4028-b9ac-503e1b79b261';
update drugs.product set generic = 'pertussis vaccine;diphtheria vaccine;tetanus toxoid;inactivated poliovirus vaccine' where pk = 'be846933-c673-4598-a977-aec691aad909';

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 221);


