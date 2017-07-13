-- View: research.vwdiabeticsegfr
-- added another loinc for EGFR

-- DROP VIEW research.vwdiabeticsegfr;

CREATE OR REPLACE VIEW research.vwdiabeticsegfr AS 
 SELECT vwdiabetes_patients_with_hba1c.fk_patient AS pk_view, vwgraphableobservations.loinc, 
 vwgraphableobservations.value_numeric, vwgraphableobservations.value_numeric_qualifier, 
 vwdiabetes_patients_with_hba1c.fk_patient, vwdiabetes_patients_with_hba1c.deceased, 
 vwdiabetes_patients_with_hba1c.active_status, vwgraphableobservations.identifier, 
 vwgraphableobservations.observation_date, vwgraphableobservations.reference_range, vwgraphableobservations.abnormal
   FROM research.vwdiabetes_patients_with_hba1c, documents.vwgraphableobservations
  WHERE vwdiabetes_patients_with_hba1c.fk_patient = vwgraphableobservations.fk_patient AND vwgraphableobservations.loinc = '33914-3'::text 
  or vwdiabetes_patients_with_hba1c.fk_patient = vwgraphableobservations.fk_patient AND  vwgraphableobservations.loinc = '62238-1'::text;

ALTER TABLE research.vwdiabeticsegfr
  OWNER TO easygp;
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
 
update db.lu_version set lu_minor = 531;
