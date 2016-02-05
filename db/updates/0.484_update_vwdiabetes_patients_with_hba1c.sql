-- View: research.vwdiabetes_patients_with_hba1c

-- DROP VIEW research.vwdiabetes_patients_with_hba1c;

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
    vwpatients.image,
    vwPatients.uses_webster_pack
   FROM contacts.vwpatients,
    documents.vwgraphableobservations
   WHERE vwgraphableobservations.fk_patient = vwpatients.fk_patient AND vwgraphableobservations.loinc = '4548-4'::text;

ALTER TABLE research.vwdiabetes_patients_with_hba1c  OWNER TO easygp;
GRANT ALL ON TABLE research.vwdiabetes_patients_with_hba1c TO staff;
COMMENT ON VIEW research.vwdiabetes_patients_with_hba1c
  IS 'all patients and all their hba1''s, including deceased and those left the practice
 this view could also contain patients who are not diabetic if someone has done
 their hab1c without good cause or logic or since 2015 when the powers that be 
 decided that hba1c was a diagnostic tool
 The GUI layer must use  chronic_disease_management.diabetes_hba1c_not_diabetic
 to filter these non-diabetics out of stats - or at least that is how I''ve done it';
update db.lu_version set lu_minor = 484;