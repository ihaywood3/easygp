alter table clin_measurements.lu_type drop column fk_decision_support cascade;
alter table clin_measurements.lu_type drop column fk_plotting_method;


CREATE OR REPLACE VIEW clin_measurements.vwmeasurementtypes AS 
 SELECT lu_units.full_text,
    lu_units.abbrev_text,
    lu_type.pk,
    lu_type.name_abbreviated,
    lu_type.code,
    lu_type.name_full,
    lu_type.input_key_restriction,
    lu_type.input_mask,
    lu_type.fk_unit,
    lu_type.unit_qualifier,
    lu_type.upper_limit,
    lu_type.lower_limit
    FROM clin_measurements.lu_type
     JOIN common.lu_units ON lu_type.fk_unit = lu_units.pk
  ORDER BY lu_type.name_full;

ALTER TABLE clin_measurements.vwmeasurementtypes   OWNER TO easygp;
GRANT ALL ON TABLE clin_measurements.vwmeasurementtypes TO staff;



CREATE OR REPLACE VIEW clin_measurements.vwpatientsdefaults AS 
 SELECT patients_defaults.fk_patient,
    patients_defaults.pk AS pk_patients_defaults,
    patients_defaults.fk_lu_type,
    lu_type.name_abbreviated,
    lu_type.code,
    lu_type.input_key_restriction,
    lu_type.name_full,
    lu_type.input_mask,
    lu_type.fk_unit,
    lu_type.unit_qualifier,
    lu_type.upper_limit,
    lu_type.lower_limit,
    lu_units.full_text,
    lu_units.abbrev_text
   FROM clin_measurements.patients_defaults
     JOIN clin_measurements.lu_type ON patients_defaults.fk_lu_type = lu_type.pk
     LEFT JOIN common.lu_units ON lu_type.fk_unit = lu_units.pk
  ORDER BY patients_defaults.fk_patient;

ALTER TABLE clin_measurements.vwpatientsdefaults   OWNER TO easygp;
GRANT ALL ON TABLE clin_measurements.vwpatientsdefaults TO staff;
update db.lu_version set lu_minor=434;