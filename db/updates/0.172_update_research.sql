-- these views may or may not exist in your database, don't fret if if error messages you
DROP VIEW research.vwdiabetes_patients_with_hba1c cascade;

CREATE OR REPLACE VIEW research.vwdiabetes_patients_with_hba1c AS 
 SELECT DISTINCT vwgraphableobservations.pk_observations, vwgraphableobservations.observation_date, 
 vwgraphableobservations.loinc, vwgraphableobservations.value_numeric, 
 vwpatients.fk_patient,  vwpatients.firstname, vwpatients.surname, vwpatients.wholename, 
 vwpatients.age_display, vwpatients.sex, vwpatients.title,  vwpatients.occupation, 
 vwpatients.fk_image, vwpatients.birthdate, vwpatients.age_numeric, vwpatients.marital,  
 vwpatients.fk_person,vwpatients.deceased, vwpatients.active_status, 
 vwpatients.street1, vwpatients.street2, vwpatients.town, vwpatients.state,  vwpatients.postcode
FROM contacts.vwpatients, documents.vwgraphableobservations 
WHERE vwgraphableobservations.fk_patient = vwpatients.fk_patient 
AND vwgraphableobservations.loinc = '4548-4'::text;

ALTER TABLE research.vwdiabetes_patients_with_hba1c OWNER TO easygp;
GRANT ALL ON TABLE research.vwdiabetes_patients_with_hba1c TO easygp;
GRANT ALL ON TABLE research.vwdiabetes_patients_with_hba1c TO staff;

COMMENT ON VIEW research.vwdiabetes_patients_with_hba1c IS 
'all patients and all their hba1''s, including deceased and those left the practice
 this view could also contain patients who are not diabetic if someone has done
 their hab1c without good cause or logic - mind you there is a push to make
 hba1c a diagnostic tool heaven forbid
 The GUI layer must use  chronic_disease_management.diabetes_hba1c_not_diabetic
 to filter these non-diabetics out of stats - or at least that is how I''ve done it';


CREATE OR REPLACE VIEW research.vwmostrecenteyerelateddocuments AS 
 SELECT DISTINCT ON (vwdocuments.fk_patient) vwdocuments.fk_patient AS pk_view, 
vwdocuments.fk_patient, vwdocuments.pk_document AS fk_document, 
vwdocuments.date_created, vwdocuments.deleted
   FROM documents.vwdocuments
  WHERE (vwdocuments.organisation_category::text ~~* '%ophthal%'::text OR 
vwdocuments.organisation_category::text ~~* '%optom%'::text OR 
vwdocuments.person_occupation ~~* '%ophthal%'::text OR 
vwdocuments.person_occupation ~~* '%optom%'::text) AND vwdocuments.deleted = false
  ORDER BY vwdocuments.fk_patient, vwdocuments.date_created DESC;

ALTER TABLE research.vwmostrecenteyerelateddocuments OWNER TO easygp;
GRANT ALL ON TABLE research.vwmostrecenteyerelateddocuments TO easygp;
GRANT ALL ON TABLE research.vwmostrecenteyerelateddocuments TO staff;

COMMENT ON VIEW research.vwmostrecenteyerelateddocuments is
'
This is a view of the most recent eye related document found in the database.
Quite dependant on the user allocating an eye-related category.
Though not specific to diabetics, it is currently only used in FDiabetesResearch 
The view key pk_view=fk_patient so once we have all diabetic patients, the view 
yields their eye documents. I put in fk_patient only to remind anyone viewing the
data that pk_view = fk_patient
';



CREATE OR REPLACE VIEW research.vwdiabeticsegfr AS 
 SELECT vwdiabetes_patients_with_hba1c.fk_patient AS pk_view, 
vwgraphableobservations.loinc, vwgraphableobservations.value_numeric, 
vwgraphableobservations.value_numeric_qualifier, vwdiabetes_patients_with_hba1c.fk_patient, 
vwdiabetes_patients_with_hba1c.deceased, vwdiabetes_patients_with_hba1c.active_status, 
vwgraphableobservations.identifier, vwgraphableobservations.observation_date, 
vwgraphableobservations.reference_range, vwgraphableobservations.abnormal 
FROM research.vwdiabetes_patients_with_hba1c, documents.vwgraphableobservations 
WHERE vwdiabetes_patients_with_hba1c.fk_patient = vwgraphableobservations.fk_patient 
AND vwgraphableobservations.loinc = '33914-3'::text;

ALTER TABLE research.vwdiabeticsegfr OWNER TO easygp;
GRANT ALL ON TABLE research.vwdiabeticsegfr TO easygp;
GRANT SELECT ON TABLE research.vwdiabeticsegfr TO staff;

COMMENT ON VIEW research.vwdiabeticsegfr IS 
'a view of all diabetes and their egfr''s
 note as the fk_patient of the diabetes view is linked to the fk_patient of the observations view
 there is always a 1-1 relationship between these views
 this view could also contain patients who are not diabetic if someone has done
 their hab1c without good cause or logic 
 The GUI layer must use  chronic_disease_management.diabetes_hba1c_not_diabetic
 to filter these non-diabetics out of stats - or at least that is how I''ve done it';

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 172);
