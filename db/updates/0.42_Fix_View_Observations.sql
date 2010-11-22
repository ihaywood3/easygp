DROP VIEW documents.vwobservations;

CREATE OR REPLACE VIEW documents.vwobservations AS 
 SELECT documents.fk_patient, observations.pk, observations.identifier,
  observations.observation_date, observations.value_numeric, observations.units,
   observations.reference_range, observations.abnormal, observations.loinc
   FROM documents.observations, documents.documents
  WHERE documents.pk = observations.fk_document
  ORDER BY documents.fk_patient, observations.observation_date, set_id;

ALTER TABLE documents.vwobservations OWNER TO easygp;
GRANT ALL ON TABLE documents.vwobservations TO easygp;
GRANT ALL ON TABLE documents.vwobservations TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 42);