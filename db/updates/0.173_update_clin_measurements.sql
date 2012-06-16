Create or replace view clin_Measurements.vwBPMostRecent as
select distinct on (fk_patient) fk_patient as pk_view, consult_date, 
measurement  from clin_measurements.vwMeasurements where deleted = false and fk_type = 1 
order by fk_patient,consult_date DESC;

alter view clin_measurements.vwBPMostRecent owner to easygp;
grant all on clin_measurements.vwBPMostRecent to easygp;
grant all on clin_measurements.vwBPMostRecent to staff;

comment on view clin_measurements.vwBPMostRecent is
' the latest BP measurement for all patients, pk_view = fk_patient';


Create or replace view clin_Measurements.vwWeightMostRecent as
select distinct on (fk_patient) fk_patient as pk_view, consult_date,
measurement  from clin_measurements.vwMeasurements where deleted = false and fk_type = 2
order by fk_patient,consult_date DESC;

alter view clin_measurements.vwWeightMostRecent owner to easygp;
grant all on clin_measurements.vwWeightMostRecent to easygp;
grant all on clin_measurements.vwWeightMostRecent to staff;

comment on view clin_measurements.vwWeightMostRecent is
' the latest Weight measurement for all patients, pk_view = fk_patient';


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 173);

