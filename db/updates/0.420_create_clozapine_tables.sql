-- some tables to generate clozapine patient consent and blood count record forms

-- drop table clin_mentalhealth.clozapine_Details cascade;
-- Drop table clin_mentalhealth.clozapine_record cascade;

Create Table clin_mentalhealth.Clozapine_Details
(pk serial primary key,
 fk_consult integer not null references clin_consult.consult(pk),
 clozapine_number text not null,
 clozapine_dose text not null,
 brand text not null,
 fk_branch_clozapine_centre integer not null references contacts.data_branches(pk),
 fk_branch_dispensing_pharmacy integer not null references contacts.data_branches(pk),
 clozapine_centre_pharmacy_fax_number text default null,
 clozapine_coordinator_fax_number text default null,
 deleted boolean default false
 )
 ;

 comment on column clin_mentalhealth.clozapine_details.brand is 
 'the brand name (stem) eg clopine, the whole brand is not kept as may be on multiples eg clopine 25 clopine 50
 so we don''t keep the fk_brand';

ALTER TABLE clin_mentalhealth.Clozapine_Details OWNER TO easygp;
GRANT ALL ON TABLE clin_mentalhealth.Clozapine_Details to staff;

Create table clin_mentalhealth.clozapine_record
(pk serial primary key,
 fk_clozapine_details integer references clin_mentalhealth.Clozapine_details(pk),
 fk_consult integer not null references clin_consult.consult(pk),
 fk_progressnote integer not null references clin_consult.progressnotes (pk),
 fk_document integer not null references documents.documents (pk),
 weight  numeric not null,
 fk_observation_white_cell_count integer default null,
 white_cell_count text default null,
 fk_observation_neutrophil_count integer default null,
 neutrophil_count text default null,
 date_paper_based_fbc date default null,
 clozapine_dose text not null,
 latex text not null,
 deleted boolean default false
 )
;

ALTER TABLE clin_mentalhealth.clozapine_record OWNER TO easygp;
GRANT ALL ON TABLE clin_mentalhealth.clozapine_record to staff;

comment on column clin_mentalhealth.clozapine_record.fk_document is 
'points to the document which was faxed/sent to the hospital, pharmacy, clozapine co-ordinator';
comment on column clin_mentalhealth.clozapine_record.white_cell_count is 
'if not null, then the user has manually typed in the result as opposed to the system pulling it in';
comment on column clin_mentalhealth.clozapine_record.neutrophil_count is 
'if not null, then the user has manually typed in the result as opposed to the system pulling it in';
comment on column clin_mentalhealth.clozapine_record.date_paper_based_fbc is 
'If not null then the date of the paper-based fbc record';

-- DROP VIEW  clin_mentalhealth.vwClozapineDetails;
Create or replace View clin_mentalhealth.vwClozapineDetails as
Select 
	Clozapine_Details.pk as pk_clozapine_details,
	consult.pk as fk_consult,
	consult.fk_patient,
	consult.fk_staff,
	Clozapine_Details.clozapine_number,
	Clozapine_Details.clozapine_dose,
	Clozapine_Details.brand,
	Clozapine_Details.fk_branch_clozapine_centre,
	Clozapine_Details.fk_branch_dispensing_pharmacy,
	Clozapine_Details.deleted,
	clozapine_centre_pharmacy_fax_number,
	clozapine_coordinator_fax_number,
	clozapine_centre.branch as clozapine_centre_branch,
	clozapine_centre.organisation as clozapine_centre_organisation, 
	clozapine_centre.street1 as clozapine_centre_street1,
	clozapine_centre.street2 as clozapine_centre_street2,
	clozapine_centre.town as clozapine_centre_town,
	clozapine_centre.postcode as clozapine_centre_postcode,
	dispensing_pharmacy.branch as dispensing_pharmacy_branch,
	dispensing_pharmacy.organisation as dispensing_pharmacy_organisation, 
	dispensing_pharmacy.street1 as dispensing_pharmacy_street1,
	dispensing_pharmacy.street2 as dispensing_pharmacy_street2,
	dispensing_pharmacy.town as dispensing_pharmacy_town,
	dispensing_pharmacy.postcode as dispensing_pharmacy_postcode
FROM
	clin_mentalhealth.Clozapine_Details
JOIN   clin_consult.consult ON Clozapine_Details.fk_consult = consult.pk
JOIN   contacts.vwOrganisations as clozapine_centre on Clozapine_Details.fk_branch_clozapine_centre = clozapine_centre.fk_branch 
JOIN   contacts.vwOrganisations as dispensing_pharmacy on Clozapine_Details.fk_branch_dispensing_Pharmacy= dispensing_pharmacy.fk_branch 
;

ALTER TABLE clin_mentalhealth.vwClozapineDetails OWNER TO easygp;
GRANT SELECT ON TABLE clin_mentalhealth.vwClozapineDetails to staff;


CREATE OR REPLACE VIEW clin_mentalhealth.vwClozapineRecords as 
Select
  clozapine_record.pk  as pk_clozapine_record,
  clozapine_record.fk_clozapine_details ,
  clozapine_record.fk_consult,
  clozapine_record.fk_document,
  consult.fk_patient,
  consult.fk_staff,
  consult.consult_date,
  clozapine_record.weight,
  clozapine_record.fk_observation_white_cell_count,
  clozapine_record.white_cell_count, 
  clozapine_record.fk_observation_neutrophil_count,
  clozapine_record.neutrophil_count, 
  clozapine_record.clozapine_dose,
  clozapine_record.deleted,
  clozapine_record.date_paper_based_fbc,
  clozapine_record.fk_progressnote,
  clozapine_record.latex,
  progressnotes.notes,
  observations_wcc.value_numeric as  wcc_value_numeric,
  observations_wcc.units as wcc_units,
  observations_wcc.reference_range as wcc_reference_range,
  observations_wcc.observation_date as wcc_observation_date,
  observations_wcc.abnormal as wcc_abnormal,
  observations_neutrophils.value_numeric as  neutrophil_value_numeric,
  observations_neutrophils.units as neutrophil_units,
  observations_neutrophils.reference_range as neutrophil_reference_range,
  observations_neutrophils.observation_date as neutrophil_observation_date,
  observations_neutrophils.abnormal as neutrophil_abnormal
  FROM clin_mentalhealth.clozapine_record
	  JOIN clin_consult.consult ON clozapine_record.fk_consult = consult.pk
	  JOIN clin_Consult.progressnotes ON clozapine_record.fk_progressnote = progressnotes.pk
	  JOIN documents.documents ON clozapine_record.fk_document = documents.pk
	  LEFT JOIN documents.observations as observations_wcc ON clozapine_record.fk_observation_white_cell_count = observations_wcc.pk
	  LEFT JOIN documents.observations as observations_neutrophils ON clozapine_record.fk_observation_neutrophil_count = observations_neutrophils.pk;
	  
  ALTER TABLE clin_mentalhealth.vwClozapineRecords OWNER TO easygp;
  GRANT SELECT ON  TABLE clin_mentalhealth.vwClozapineRecords TO staff;

  COMMENT ON VIEW clin_mentalhealth.vwClozapineRecords IS 
  'a view of all clozapine records per patient (fk_patient) including outer joins to documents.observations to pull in wcc and neutrophil counts';
  
  update db.lu_version set lu_minor=420;