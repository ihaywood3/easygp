CREATE OR REPLACE VIEW research.vwDiabetics_With_LDLCholesterol AS 
 SELECT vwdiabetes_patients_with_hba1c.fk_patient AS pk_view, vwgraphableobservations.loinc, vwgraphableobservations.value_numeric, vwgraphableobservations.value_numeric_qualifier, vwdiabetes_patients_with_hba1c.fk_patient, vwdiabetes_patients_with_hba1c.deceased, vwdiabetes_patients_with_hba1c.active_status, vwgraphableobservations.identifier, vwgraphableobservations.observation_date, vwgraphableobservations.reference_range, vwgraphableobservations.abnormal
   FROM research.vwdiabetes_patients_with_hba1c, documents.vwgraphableobservations
  WHERE vwdiabetes_patients_with_hba1c.fk_patient = vwgraphableobservations.fk_patient AND vwgraphableobservations.loinc = '22748-8'::text;

ALTER TABLE research.vwDiabetics_With_LDLCholesterol OWNER TO easygp;
GRANT ALL ON TABLE research.vwDiabetics_With_LDLCholesterol TO easygp;
GRANT SELECT ON TABLE research.vwDiabetics_With_LDLCholesterol TO staff;

COMMENT ON VIEW research.vwDiabetics_With_LDLCholesterol IS 'a view of all diabetes and their LDL Cholesterol Levels
 note as the fk_patient of the diabetes view is linked to the fk_patient of the observations view
 there is always a 1-1 relationship between these views
 this view could also contain patients who are not diabetic if someone has done
 their hab1c without good cause or logic 
 The GUI layer must use  chronic_disease_management.diabetes_hba1c_not_diabetic
 to filter these non-diabetics out of stats - or at least that is how I''ve done it';

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 174);

