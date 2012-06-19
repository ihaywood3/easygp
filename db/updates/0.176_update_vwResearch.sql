CREATE OR REPLACE VIEW research.vwmicroalbuminuria AS 
        (        (         SELECT vwobservations.fk_patient, vwobservations.pk AS pk_observation, vwobservations.identifier, 
        vwobservations.observation_date, vwobservations.value_numeric, vwobservations.value_numeric_qualifier, 
        vwobservations.units, vwobservations.reference_range, vwobservations.abnormal, vwobservations.loinc
                           FROM documents.vwobservations
                          WHERE vwobservations.loinc = '14959-1'::text AND vwobservations.value_numeric IS NOT NULL
                UNION 
                         SELECT vwobservations.fk_patient, vwobservations.pk AS pk_observation, vwobservations.identifier, 
vwobservations.observation_date, vwobservations.value_numeric, vwobservations.value_numeric_qualifier, vwobservations.units,
 vwobservations.reference_range, vwobservations.abnormal, vwobservations.loinc
                           FROM documents.vwobservations
                          WHERE vwobservations.loinc = '2890-2'::text AND vwobservations.value_numeric IS NOT NULL)
        UNION 
                 SELECT vwobservations.fk_patient, vwobservations.pk AS pk_observation, vwobservations.identifier, 
vwobservations.observation_date, vwobservations.value_numeric, vwobservations.value_numeric_qualifier, vwobservations.units, 
vwobservations.reference_range, vwobservations.abnormal, vwobservations.loinc
                   FROM documents.vwobservations
                  WHERE vwobservations.loinc = '14957-5'::text AND vwobservations.value_numeric IS NOT NULL)
UNION 
         SELECT vwobservations.fk_patient, vwobservations.pk AS pk_observation, vwobservations.identifier, 
vwobservations.observation_date, vwobservations.value_numeric, vwobservations.value_numeric_qualifier, vwobservations.units, 
vwobservations.reference_range, vwobservations.abnormal, vwobservations.loinc
           FROM documents.vwobservations
          WHERE vwobservations.loinc = '14956-7'::text AND vwobservations.value_numeric IS NOT NULL
  ORDER BY 1, 4;

ALTER view research.vwmicroalbuminuria OWNER TO easygp;
GRANT ALL on table research.vwmicroalbuminuria to easygp;
GRANT ALL on table research.vwmicroalbuminuria to staff;

COMMENT ON view research.vwmicroalbuminuria is 'a view containing all microalbumins for all patients';


Create view Research.VwDiabetics_with_Microalbumins as 
SELECT 
  vwmicroalbuminuria.identifier, 
  vwmicroalbuminuria.observation_date, 
  vwmicroalbuminuria.value_numeric, 
  vwmicroalbuminuria.value_numeric_qualifier, 
  vwmicroalbuminuria.units, 
  vwmicroalbuminuria.reference_range, 
  vwmicroalbuminuria.abnormal, 
  vwmicroalbuminuria.loinc, 
  vwdiabetes_patients_with_hba1c.fk_patient,
  vwdiabetes_patients_with_hba1c.fk_patient as pk_view,
  vwdiabetes_patients_with_hba1c.deceased, 
  vwdiabetes_patients_with_hba1c.active_status
FROM 
  research.vwmicroalbuminuria, 
  research.vwdiabetes_patients_with_hba1c
WHERE 
  vwmicroalbuminuria.fk_patient = vwdiabetes_patients_with_hba1c.fk_patient
ORDER BY fk_patient, observation_date;

ALTER view research.VwDiabetics_with_Microalbumins OWNER TO easygp;
GRANT ALL on table research.VwDiabetics_with_Microalbumins to easygp;
GRANT ALL on table research.VwDiabetics_with_Microalbumins to staff;


COMMENT ON view Research.VwDiabetics_with_Microalbumins is
'A view of all patient''s with hab1c''s who also have had some sort of microalbumnin test (4 different LOINC''s
 Note the pk_view does not have to be unique we only pull out a single record for each patient when used (our collections must have unique keys)';

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 176);

