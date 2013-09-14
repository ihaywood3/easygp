insert into clin_measurements.lu_type(pk, name_abbreviated,name_full, input_key_restriction, input_mask, fk_unit, unit_qualifier, fk_decision_support,fk_plotting_method)
values(5, 'waist', 'waist circumference', 2, '###', 9, 'cm',0,0);
insert into clin_measurements.lu_type(pk, name_abbreviated,name_full, input_key_restriction, input_mask, fk_unit, unit_qualifier, fk_decision_support,fk_plotting_method)
values(6, 'hip', 'hip circumference', 2, '###', 9, 'cm',0,0);
truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 318);
