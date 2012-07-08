

CREATE OR REPLACE VIEW research.vwTotalcholesterol AS 
 SELECT vwobservations.fk_patient, vwobservations.pk, vwobservations.identifier, 
 vwobservations.observation_date, vwobservations.value_numeric, vwobservations.value_numeric_qualifier, 
 vwobservations.units, vwobservations.reference_range, vwobservations.abnormal, vwobservations.loinc
   FROM documents.vwobservations
  WHERE vwobservations.loinc = '14647-2'::text 
  ORDER BY vwobservations.fk_patient, vwobservations.observation_date DESC;

ALTER TABLE research.vwTotalcholesterol OWNER TO  easygp;
grant all on table research.vwTotalcholesterol to easygp;
grant all on research.vwTotalcholesterol to staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 191)

