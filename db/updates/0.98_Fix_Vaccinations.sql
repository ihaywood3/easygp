-- Somehow along the way these views have been lost from the schema
--  vaccinations section not yet in clinical use here!

CREATE OR REPLACE VIEW clin_vaccination.vwvaccines AS 
 SELECT lu_vaccines.pk, lu_vaccines.brand, lu_vaccines.fk_form, lu_formulation.form, lu_vaccines.fk_description,
 lu_vaccines.fk_route, lu_route_administration.route, lu_vaccines.inactive AS vaccine_inactive, lu_vaccines.deleted,
 lu_descriptions.description, lu_descriptions.deleted AS decription_deleted
   FROM clin_vaccination.lu_vaccines
   JOIN clin_vaccination.lu_descriptions ON lu_vaccines.fk_description = lu_descriptions.pk
   JOIN common.lu_route_administration ON lu_vaccines.fk_route = lu_route_administration.pk
   JOIN clin_vaccination.lu_formulation ON lu_vaccines.fk_form = lu_formulation.pk
  ORDER BY lu_descriptions.description;

ALTER TABLE clin_vaccination.vwvaccines OWNER TO easygp;
GRANT ALL ON TABLE clin_vaccination.vwvaccines TO easygp;
GRANT ALL ON TABLE clin_vaccination.vwvaccines TO staff;


CREATE OR REPLACE VIEW clin_vaccination.vwvaccineroutesadministration AS 
 SELECT lu_route_administration.pk, lu_route_administration.abbreviation, lu_route_administration.route
   FROM common.lu_route_administration
  WHERE lu_route_administration.pk < 9;

GRANT ALL ON TABLE clin_vaccination.vwvaccineroutesadministration TO easygp;
GRANT ALL ON TABLE clin_vaccination.vwvaccineroutesadministration TO easygp;
GRANT ALL ON TABLE clin_vaccination.vwvaccineroutesadministration TO staff;

ALTER TABLE clin_vaccination.lu_formulation OWNER TO easygp;
GRANT ALL ON TABLE clin_vaccination.lu_formulation TO easygp;
GRANT ALL ON TABLE clin_vaccination.lu_formulation TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 98);

