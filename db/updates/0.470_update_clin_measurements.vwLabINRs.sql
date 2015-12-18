Drop view clin_measurements.vwlabinrs ;
CREATE OR REPLACE VIEW clin_measurements.vwlabinrs AS 
 SELECT documents.pk,
    documents.source_file,
    documents.fk_patient,
    observations.loinc,
    observations.value,
    observations.abnormal,
    observations.observation_date,
    observations.pk AS fk_observation,
    vwSendingEntities.organisation
   FROM documents.documents
       JOIN     documents.observations ON observations.fk_document = documents.pk
       JOIN     documents.vwSendingEntities on vwsendingEntities.pk_sending_entities= documents.fk_sending_entity
  WHERE documents.pk = observations.fk_document AND observations.loinc = '6301-6'::text AND documents.source_file IS NOT NULL
  ORDER BY documents.fk_patient;
  
update db.lu_version set lu_minor = 470;