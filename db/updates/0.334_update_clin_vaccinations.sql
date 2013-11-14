-- warning do not run this if you have ever added any vaccines to your database
-- add new description for the priorix-tetra brand vaccine now used at 18 months
-- add new schedule for 18 months, renaming the old one in use to 30/06/2013
update clin_vaccination.lu_descriptions set description = 'Measles, Rubella, Mumps vaccine - live' where pk=35;
insert into clin_vaccination.lu_descriptions (description) values ('Measles, Rubella, Mumps, Varicella vaccine - live'); -- key 42
update clin_vaccination.lu_schedules set schedule='18 month childhood - Pre01July13', inactive = True, date_inactive = '30/06/2013' where pk=46;
insert into clin_vaccination.lu_schedules (age_due_from_months, schedule,notes) values (18, '18 Month childhood', 'from 01/07/2013');
insert into clin_vaccination.lu_vaccines (brand, fk_description, fk_route, fk_form) values ('Priorix-Tetra', 42,2,1) ; -- key 201
insert into clin_vaccination.lu_vaccines_in_schedule (fk_vaccine,fk_schedule) values (201,75);

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 334);
