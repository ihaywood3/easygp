
CREATE OR REPLACE VIEW clin_measurements.vwsystolicdiastolic AS 
 SELECT vwmeasurements.fk_patient,
    vwpatients.wholename,
    vwpatients.fk_person,
    vwpatients.surname,
    vwpatients.firstname,
    vwpatients.title,
    vwpatients.sex,
    vwpatients.age_numeric,
    vwpatients.fk_lu_active_status,
    vwpatients.deceased,
    vwmeasurements.pk_measurement,
    vwmeasurements.consult_date,
    vwmeasurements.measurement,
    round(vwmeasurements.measurement / 1000::numeric) AS systolic,
    vwmeasurements.measurement % 1000::numeric AS diastolic
   FROM clin_measurements.vwmeasurements
     JOIN contacts.vwpatients ON vwpatients.fk_patient = vwmeasurements.fk_patient
  WHERE vwmeasurements.deleted = false AND vwmeasurements.fk_type = 1 AND vwpatients.deceased = false AND vwpatients.fk_lu_active_status = 1
  ORDER BY vwmeasurements.fk_patient, vwmeasurements.consult_date DESC;

ALTER TABLE clin_measurements.vwsystolicdiastolic   OWNER TO easygp;
GRANT ALL ON TABLE clin_measurements.vwsystolicdiastolic TO staff;

CREATE OR REPLACE VIEW clin_measurements.vwaveragebp AS 
 SELECT vwsystolicdiastolic.fk_patient,
    vwsystolicdiastolic.fk_patient AS pk,
    vwsystolicdiastolic.fk_person,
    vwsystolicdiastolic.surname,
    vwsystolicdiastolic.firstname,
    vwsystolicdiastolic.title,
    vwsystolicdiastolic.sex,
    vwsystolicdiastolic.age_numeric,
    round(avg(vwsystolicdiastolic.systolic)) AS average_systolic,
    round(avg(vwsystolicdiastolic.diastolic)) AS average_diastolic
   FROM clin_measurements.vwsystolicdiastolic
  GROUP BY vwsystolicdiastolic.fk_patient, vwsystolicdiastolic.fk_person, vwsystolicdiastolic.surname, vwsystolicdiastolic.firstname, vwsystolicdiastolic.title, vwsystolicdiastolic.sex, vwsystolicdiastolic.age_numeric
  ORDER BY vwsystolicdiastolic.surname;

ALTER TABLE clin_measurements.vwaveragebp   OWNER TO easygp;
GRANT ALL ON TABLE clin_measurements.vwaveragebp TO staff;

CREATE OR REPLACE VIEW research.vwpatientswithcodedhypertension AS 
 SELECT DISTINCT ON (vwpatients.surname, vwhealthissues.fk_patient) vwhealthissues.fk_patient AS pk_patient,
    vwpatients.fk_person,
    vwpatients.firstname,
    vwpatients.surname,
    vwpatients.sex,
    vwpatients.title,
    vwpatients.age_numeric,
    vwpatients.fk_lu_active_status,
    vwpatients.person_deleted,
    vwpatients.deceased
   FROM clin_history.vwhealthissues
     JOIN contacts.vwpatients ON vwpatients.fk_patient = vwhealthissues.fk_patient
  WHERE vwhealthissues.fk_code = 'K86005'::text OR vwhealthissues.fk_code = 'K85004'::text
  ORDER BY vwpatients.surname;

ALTER TABLE research.vwpatientswithcodedhypertension   OWNER TO easygp;
GRANT ALL ON TABLE research.vwpatientswithcodedhypertension TO staff;


update db.lu_version set lu_minor = 488;