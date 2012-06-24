CREATE OR REPLACE VIEW clin_measurements.vwheightmostrecent AS 
 SELECT DISTINCT ON (vwmeasurements.fk_patient) vwmeasurements.fk_patient AS pk_view, vwmeasurements.consult_date, vwmeasurements.measurement
   FROM clin_measurements.vwmeasurements
  WHERE vwmeasurements.deleted = false AND vwmeasurements.fk_type = 4
  ORDER BY vwmeasurements.fk_patient, vwmeasurements.consult_date DESC;

ALTER TABLE clin_measurements.vwheightmostrecent OWNER TO easygp;
GRANT ALL ON TABLE clin_measurements.vwheightmostrecent TO easygp;
GRANT ALL ON TABLE clin_measurements.vwheightmostrecent TO staff;
COMMENT ON VIEW clin_measurements.vwheightmostrecent IS ' the latest Height measurement for all patients, pk_view = fk_patient';

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 177);

