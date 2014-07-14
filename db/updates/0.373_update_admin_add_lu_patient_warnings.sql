-- New tables to allow visual warnings to the user about a particular patient
-- eg could be violent, alcohol issue, pregnant, breast feeding.

CREATE TABLE admin.lu_patient_warnings
(
  pk serial NOT NULL,
  name text NOT NULL,
  icon_path text NOT NULL,
  in_use boolean DEFAULT true,
  CONSTRAINT lu_clinical_warnings_pkey PRIMARY KEY (pk )
)
WITH (
  OIDS=FALSE
);

ALTER TABLE admin.lu_patient_warnings   OWNER TO easygp;
GRANT SELECT ON TABLE admin.lu_patient_warnings_pk_seq TO staff;
GRANT SELECT ON TABLE admin.lu_patient_warnings TO staff;
GRANT USAGE ON SEQUENCE admin.lu_patient_warnings_pk_seq to staff;

COMMENT ON TABLE admin.lu_patient_warnings   IS 
'Images which represent warnings can be for use on per patient basis eg is pregnant, breastfeeding, alcoholic';

Insert into admin.lu_patient_warnings(name, icon_path) values ('pregnancy', 'icons/20/pregnancy2020.png');
Insert into admin.lu_patient_warnings(name, icon_path) values ('breast feeding', 'icons/24/international_breast_feeding_24x24.png');
Insert into admin.lu_patient_warnings(name, icon_path) values ('alcoholic','icons/22/drink-beer.png');
Insert into admin.lu_patient_warnings(name, icon_path) values ('aggression', 'icons/24/bull_24x24.png');
Insert into admin.lu_patient_warnings(name, icon_path) values ('eating disorder', 'icons/24/cupcake_24x24.png');
Insert into admin.lu_patient_warnings(name, icon_path) values ('antibiotic prophylaxis', 'icons/20/centigrade_pills_2020.png');
Insert into admin.lu_patient_warnings(name, icon_path) values ('drug addict','icons/20/centigradeicons_drugs2222.png');


Create table admin.patient_warnings
(pk serial primary key,
 fk_patient integer not null,
 fk_lu_patient_warning integer not null,
 deleted boolean default false,
 CONSTRAINT patient_warnings_fk_patient FOREIGN KEY (fk_patient)
   REFERENCES clerical.data_patients (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
CONSTRAINT patient_warnings_fk_lu_patient_warning FOREIGN KEY (fk_lu_patient_warning) 
   REFERENCES admin.lu_patient_warnings (pk) MATCH SIMPLE
    ON UPDATE NO ACTION ON DELETE NO ACTION
)
;

alter table admin.patient_warnings owner to easygp;
grant all on table admin.patient_warnings to staff;
GRANT ALL ON SEQUENCE admin.patient_warnings_pk_seq TO staff;

COMMENT ON TABLE   admin.patient_warnings is  'A table linking a patient to a warning';


Create or replace view admin.vwPatientWarnings as
SELECT 
  lu_patient_warnings.name, 
  lu_patient_warnings.icon_path, 
  patient_warnings.pk,  -- the pk for this view
  patient_warnings.pk as fk_patient_warning,
  patient_warnings.fk_patient, 
  patient_warnings.fk_lu_patient_warning,
  patient_warnings.deleted
FROM 
  admin.lu_patient_warnings, 
  admin.patient_warnings
WHERE 
  patient_warnings.fk_lu_patient_warning = lu_patient_warnings.pk;

alter table admin.vwPatientWarnings owner to easygp;
Grant select on admin.vwPatientWarnings to staff;

update db.lu_version set lu_minor=373;
