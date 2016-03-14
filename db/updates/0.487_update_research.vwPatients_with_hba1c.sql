-- View: research.vwdiabetes_patients_with_hba1c
-- added the image field to display patient picture in the diabetes research module
DROP VIEW research.vwdiabetes_patients_with_hba1c cascade;

CREATE OR REPLACE VIEW research.vwdiabetes_patients_with_hba1c AS 
 SELECT DISTINCT vwgraphableobservations.pk_observations,
    vwgraphableobservations.observation_date,
    vwgraphableobservations.loinc,
    vwgraphableobservations.value_numeric,
    vwpatients.fk_patient,
    vwpatients.firstname,
    vwpatients.surname,
    vwpatients.wholename,
    vwpatients.age_display,
    vwpatients.sex,
    vwpatients.title,
    vwpatients.occupation,
    vwpatients.fk_image,
    vwpatients.birthdate,
    vwpatients.age_numeric,
    vwpatients.marital,
    vwpatients.fk_person,
    vwpatients.deceased,
    vwpatients.active_status,
    vwpatients.street1,
    vwpatients.street2,
    vwpatients.town,
    vwpatients.state,
    vwpatients.postcode,
    vwpatients.image
   FROM contacts.vwpatients,
    documents.vwgraphableobservations
  WHERE vwgraphableobservations.fk_patient = vwpatients.fk_patient AND vwgraphableobservations.loinc = '4548-4'::text;

ALTER TABLE research.vwdiabetes_patients_with_hba1c   OWNER TO easygp;
GRANT ALL ON TABLE research.vwdiabetes_patients_with_hba1c TO staff;

COMMENT ON VIEW research.vwdiabetes_patients_with_hba1c
  IS 'all patients and all their hba1''s, including deceased and those left the practice
 this view could also contain patients who are not diabetic if someone has done
 their hab1c without good cause or logic - mind you there is a push to make
 hba1c a diagnostic tool heaven forbid
 The GUI layer must use  chronic_disease_management.diabetes_hba1c_not_diabetic
 to filter these non-diabetics out of stats - or at least that is how I''ve done it';

CREATE OR REPLACE VIEW research.vwdiabetics_with_ldlcholesterol AS 
 SELECT vwdiabetes_patients_with_hba1c.fk_patient AS pk_view,
    vwgraphableobservations.loinc,
    vwgraphableobservations.value_numeric,
    vwgraphableobservations.value_numeric_qualifier,
    vwdiabetes_patients_with_hba1c.fk_patient,
    vwdiabetes_patients_with_hba1c.deceased,
    vwdiabetes_patients_with_hba1c.active_status,
    vwgraphableobservations.identifier,
    vwgraphableobservations.observation_date,
    vwgraphableobservations.reference_range,
    vwgraphableobservations.abnormal
   FROM research.vwdiabetes_patients_with_hba1c,
    documents.vwgraphableobservations
  WHERE vwdiabetes_patients_with_hba1c.fk_patient = vwgraphableobservations.fk_patient AND vwgraphableobservations.loinc = '22748-8'::text;

ALTER TABLE research.vwdiabetics_with_ldlcholesterol   OWNER TO easygp;
GRANT ALL ON TABLE research.vwdiabetics_with_ldlcholesterol TO easygp;
GRANT SELECT ON TABLE research.vwdiabetics_with_ldlcholesterol TO staff;
COMMENT ON VIEW research.vwdiabetics_with_ldlcholesterol
  IS 'a view of all diabetes and their LDL Cholesterol Levels
 note as the fk_patient of the diabetes view is linked to the fk_patient of the observations view
 there is always a 1-1 relationship between these views
 this view could also contain patients who are not diabetic if someone has done
 their hab1c without good cause or logic 
 The GUI layer must use  chronic_disease_management.diabetes_hba1c_not_diabetic
 to filter these non-diabetics out of stats - or at least that is how I''ve done it';

CREATE OR REPLACE VIEW research.vwdiabetics_with_microalbumins AS 
 SELECT vwmicroalbuminuria.identifier,
    vwmicroalbuminuria.observation_date,
    vwmicroalbuminuria.value_numeric,
    vwmicroalbuminuria.value_numeric_qualifier,
    vwmicroalbuminuria.units,
    vwmicroalbuminuria.reference_range,
    vwmicroalbuminuria.abnormal,
    vwmicroalbuminuria.loinc,
    vwdiabetes_patients_with_hba1c.fk_patient,
    vwdiabetes_patients_with_hba1c.fk_patient AS pk_view,
    vwdiabetes_patients_with_hba1c.deceased,
    vwdiabetes_patients_with_hba1c.active_status
   FROM research.vwmicroalbuminuria,
    research.vwdiabetes_patients_with_hba1c
  WHERE vwmicroalbuminuria.fk_patient = vwdiabetes_patients_with_hba1c.fk_patient
  ORDER BY vwdiabetes_patients_with_hba1c.fk_patient, vwmicroalbuminuria.observation_date;

ALTER TABLE research.vwdiabetics_with_microalbumins   OWNER TO easygp;
GRANT ALL ON TABLE research.vwdiabetics_with_microalbumins TO easygp;
GRANT ALL ON TABLE research.vwdiabetics_with_microalbumins TO staff;
COMMENT ON VIEW research.vwdiabetics_with_microalbumins
  IS 'A view of all patient''s with hab1c''s who also have had some sort of microalbumnin test (4 different LOINC''s
 Note the pk_view does not have to be unique we only pull out a single record for each patient when used (our collections must have unique keys)';


CREATE OR REPLACE VIEW research.vwdiabeticsegfr AS 
 SELECT vwdiabetes_patients_with_hba1c.fk_patient AS pk_view,
    vwgraphableobservations.loinc,
    vwgraphableobservations.value_numeric,
    vwgraphableobservations.value_numeric_qualifier,
    vwdiabetes_patients_with_hba1c.fk_patient,
    vwdiabetes_patients_with_hba1c.deceased,
    vwdiabetes_patients_with_hba1c.active_status,
    vwgraphableobservations.identifier,
    vwgraphableobservations.observation_date,
    vwgraphableobservations.reference_range,
    vwgraphableobservations.abnormal
   FROM research.vwdiabetes_patients_with_hba1c,
    documents.vwgraphableobservations
  WHERE vwdiabetes_patients_with_hba1c.fk_patient = vwgraphableobservations.fk_patient AND vwgraphableobservations.loinc = '33914-3'::text;

ALTER TABLE research.vwdiabeticsegfr   OWNER TO easygp;
GRANT ALL ON TABLE research.vwdiabeticsegfr TO easygp;
GRANT SELECT ON TABLE research.vwdiabeticsegfr TO staff;

COMMENT ON VIEW research.vwdiabeticsegfr
  IS 'a view of all diabetes and their egfr''s
 note as the fk_patient of the diabetes view is linked to the fk_patient of the observations view
 there is always a 1-1 relationship between these views
 this view could also contain patients who are not diabetic if someone has done
 their hab1c without good cause or logic 
 The GUI layer must use  chronic_disease_management.diabetes_hba1c_not_diabetic
 to filter these non-diabetics out of stats - or at least that is how I''ve done it';

update db.lu_version set lu_minor = 487;
