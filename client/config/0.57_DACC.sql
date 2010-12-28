-- new schema for chronic disease management for want of better name for the moment.
-- for stuff like diabetes annual cycle of care

Create schema chronic_disease_management;

GRANT ALL ON SCHEMA chronic_disease_management TO easygp;
GRANT all ON SCHEMA chronic_disease_management TO staff;


CREATE TABLE chronic_disease_management.lu_dacc_components
(
  pk serial NOT NULL,
  fk_component integer NOT NULL, -- key to chronic_disease_management.lu_careplan_components table
  CONSTRAINT lu_dacc_components_pkey PRIMARY KEY (pk)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE chronic_disease_management.lu_dacc_components OWNER TO easygp;

GRANT ALL ON TABLE chronic_disease_management.lu_dacc_components TO easygp;
GRANT ALL ON TABLE chronic_disease_management.lu_dacc_components TO staff;

COMMENT ON TABLE chronic_disease_management.lu_dacc_components IS 'Specific to Australian Government requirements for billing care of diabetics is the so 
  called Diabetic Annual Cycle of Care (DACC)';
  
COMMENT ON COLUMN chronic_disease_management.lu_dacc_components.fk_component IS 'key to chronic_disease_management.lu_careplan_components table';

set search_path = 'chronic_disease_management';

CREATE table chronic_disease_management.diabetes_annual_cycle_of_care
(pk serial primary key,
 fk_consult integer not null,
 date_completed date default null,
 
 hba1c_date date default null,
 hba1c_date_due date default null,
 hba1c_details text default null,
 hba1c_fk_observation integer default null,
 
 eyes_date date default null,
 eyes_date_due date default null,
 eyes_details text default null,
 eyes_fk_document integer default null,
 
 bp_date date default null,
 bp_date_due date default null,
 bp_details text default null,
 
 BMI_date date default null,
 BMI_date_due date default null,
 BMI_text text default null,

 feet_date date default null,
 feet_date_due date default null,
 feet_text text default null,

 lipids_date date default null,
 lipids_date_due date default null,
 lipids_details text default null,

 microalbumin_date date default null,
 microalbumin_date_due date default null,
 microalbumin_details text default null,

 education_date date default null,
 education_date_due date default null,
 education_details text default null,

 diet_date date default null,
 diet_date_due date default null,
 diet_details text default null,

 exercise_date date default null,
 exercise_date_due date default null,
 exercise_details text default null,

 smoking_date date default null,
 smoking_date_due date default null,
 smoking_details text default null,

 medication_review date default null,
 medication_review_date_due date default null,
 medication_review_details text default null
 );

 
 

 
GRANT ALL ON TABLE  diabetes_annual_cycle_of_care TO easygp;
GRANT ALL ON TABLE  diabetes_annual_cycle_of_care TO easygp;
GRANT ALL ON TABLE  diabetes_annual_cycle_of_care TO staff;

comment on table diabetes_annual_cycle_of_care is
'Table containing the components to the diabetes annual cycle of care';

comment on column diabetes_annual_cycle_of_care.hba1c_date   is 
  'date of last hba1c could be null if not yet completed but DACC saved
   also could be taken from  document not from our system, or a phone result etc' ;
comment on column diabetes_annual_cycle_of_care.hba1c_fk_observation  is 
'foreign key to documents.observations points to the hba1c result may be null' ;
comment on column diabetes_annual_cycle_of_care.eyes_date    is 
'Date the eye check was done, may be entered without paperwork to verify ' ;
comment on column diabetes_annual_cycle_of_care.eyes_details   is 
'Whoever checked the eyes, could be person or entity, but hopefully in most cases
 will be auto-trawled from the database ' ;
comment on column diabetes_annual_cycle_of_care.eyes_fk_document   is 
'foreign key to document containing letter from provider of eye check ' ;
