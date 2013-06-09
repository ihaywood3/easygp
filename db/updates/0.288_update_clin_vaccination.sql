-- mods to vaccinations with update of views to link up no-active gui elements.

alter table clin_vaccination.lu_vaccines add column notes text default null;
alter table clin_vaccination.lu_vaccines add column female_only boolean default false;

DROP VIEW clin_vaccination.vwvaccines;

CREATE OR REPLACE VIEW clin_vaccination.vwvaccines AS 
 SELECT lu_vaccines.pk, lu_vaccines.brand, lu_vaccines.fk_form, lu_formulation.form, 
 lu_vaccines.fk_description, lu_vaccines.fk_route, lu_route_administration.route, 
 lu_vaccines.notes, lu_vaccines.female_only,
 lu_vaccines.inactive AS vaccine_inactive, lu_vaccines.deleted, lu_descriptions.description, 
 lu_descriptions.deleted AS decription_deleted
   FROM clin_vaccination.lu_vaccines
   JOIN clin_vaccination.lu_descriptions ON lu_vaccines.fk_description = lu_descriptions.pk
   LEFT JOIN common.lu_route_administration ON lu_vaccines.fk_route = lu_route_administration.pk
   LEFT JOIN clin_vaccination.lu_formulation ON lu_vaccines.fk_form = lu_formulation.pk
  ORDER BY lu_descriptions.description;

ALTER TABLE clin_vaccination.vwvaccines
  OWNER TO easygp;
GRANT ALL ON TABLE clin_vaccination.vwvaccines TO easygp;
GRANT ALL ON TABLE clin_vaccination.vwvaccines TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 288)

