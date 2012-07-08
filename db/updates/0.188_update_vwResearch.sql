-- new view for ldl cholesterol taking into account all the different ldl assay loinc codes I could find

Create or replace view Research.vwLDLCholesterol as
Select * from documents.vwObservations  where 
loinc = '39469-2' or 
loinc =  '22748-8' or 
loinc ='18262-6' or 
loinc = '2089-1' 
order by fk_patient, observation_date DESC;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 188);

