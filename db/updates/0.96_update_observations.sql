-- change to view to put observations back into correct vertical order as received in the hl7

drop view documents.vwGraphableObservations;
CREATE OR REPLACE VIEW documents.vwgraphableobservations AS 
 SELECT observations.pk AS pk_observations, lu_loinc_abbrev.component, observations.loinc, observations.fk_document, observations.identifier, observations.reference_range, observations.units, observations.abnormal, observations.observation_date, observations.value, observations.value_numeric, observations.value_numeric_qualifier, documents.fk_patient
   FROM coding.lu_loinc_abbrev, documents.observations, documents.documents
  WHERE observations.loinc = lu_loinc_abbrev.loinc_num AND observations.fk_document = documents.pk AND observations.identifier <> ''::text AND observations.loinc <> '15418-7'::text
  ORDER BY observations.pk;

ALTER TABLE documents.vwgraphableobservations OWNER TO easygp;
GRANT ALL ON TABLE documents.vwgraphableobservations TO easygp;
GRANT ALL ON TABLE documents.vwgraphableobservations TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 96);


