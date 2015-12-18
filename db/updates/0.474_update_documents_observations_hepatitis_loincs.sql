-- Changes to vwObservations and update some loincs to allow showing in vaccinations if patient is immune to some diseases
-- drop cascades to
--view research.vwmicroalbuminuria depends on view documents.vwobservations
--view research.vwdiabetics_with_microalbumins depends on view research.vwmicroalbuminuria
--view research.vwldlcholesterol depends on view documents.vwobservations
--view research.vwtotalcholesterol depends on view documents.vwobservations
--view research.vwtsh depends on view documents.vwobservations
--view research.diabetes_patients_latest_hba1c depends on view documents.vwobservations
--view research.vwldh depends on view documents.vwobservations

update documents.observations set loinc = '20575-7' where identifier  ILIKE 'Hepatitis A IgG' and loinc is null;
update documents.observations set loinc = '75409-3' where identifier  ILIKE 'Hepatitis B Surface Ab' and loinc is null;

CREATE OR REPLACE VIEW documents.vwobservations AS 
 SELECT documents.fk_patient,
    observations.pk,
    observations.identifier,
    observations.observation_date,
    observations.value_numeric,
    observations.value_numeric_qualifier,
    observations.units,
    observations.reference_range,
    observations.abnormal,
    observations.loinc,
    observations.value
   FROM documents.observations,
    documents.documents
  WHERE documents.pk = observations.fk_document
  ORDER BY documents.fk_patient, observations.observation_date, observations.set_id;

ALTER TABLE documents.vwobservations   OWNER TO EASYGP;
GRANT ALL ON TABLE documents.vwobservations TO staff;

update db.lu_version set lu_minor = 474;