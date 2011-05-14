-- First draft for enhanced primary care (EPC) program tables

Create table chronic_disease_management.lu_allied_health_type
(pk serial primary key,
 type text not null,
 item_number integer not null,
 deleted boolean default false)
 ;

 insert into chronic_disease_management.lu_Allied_health_type(type, item_number) values ('aboriginal health worker',10950);
 insert into chronic_disease_management.lu_Allied_health_type(type, item_number) values ('audiologist',10952);
 insert into chronic_disease_management.lu_Allied_health_type(type, item_number) values ('chiropractor',10964);
 insert into chronic_disease_management.lu_Allied_health_type(type, item_number) values ('dental',0);
 insert into chronic_disease_management.lu_Allied_health_type(type, item_number) values ('diabetes educator',10951);
 insert into chronic_disease_management.lu_Allied_health_type(type, item_number) values ('dietitian',10954);
 insert into chronic_disease_management.lu_Allied_health_type(type, item_number) values ('exercise physiologist',10953);
 insert into chronic_disease_management.lu_Allied_health_type(type, item_number) values ('mental health worker',10956);
 insert into chronic_disease_management.lu_Allied_health_type(type, item_number) values ('occupational therapist',10958);
 insert into chronic_disease_management.lu_Allied_health_type(type, item_number) values ('osteopath',10966);
 insert into chronic_disease_management.lu_Allied_health_type(type, item_number) values ('physiotherapist',10960);
 insert into chronic_disease_management.lu_Allied_health_type(type, item_number) values ('podiatrist',10962);
 insert into chronic_disease_management.lu_Allied_health_type(type, item_number) values ('psychologist',10968);
 insert into chronic_disease_management.lu_Allied_health_type(type, item_number) values ('speech pathologist',10970);


comment on table chronic_disease_management.lu_allied_health_type is
'describes the type of allied health provider including dental';


Create table chronic_disease_management.EPC_Referral
(pk serial primary key,
 fk_consult integer not null,
 has_gp_management_plan_and_team_care_arrangments boolean default true,
 has_aged_care_multidisciplinary_plan boolean default false,
 fk_team_care_arrangement integer not null,
 fk_electronic_signature integer default null
 );

comment on table chronic_disease_management.EPC_Referral is 
'Describes the core details single EPC_Referral to one or more allied health or dental providers
 however note that the view chronic_disease_management.vwEPCReferrals is needed to describe
 a single form (multiple rows) as there are 1 or more providers on a form';

comment on column  chronic_disease_management.EPC_Referral.fk_electronic_signature is 
 'if not null, an image in blobs.images which is the signature of the GP';
 
comment on column chronic_disease_management.EPC_Referral.fk_consult is
' key to clin_consult.consult links the form to the patient, date and doctor who did it';

comment on column chronic_disease_management.EPC_Referral.has_gp_management_plan_and_team_care_arrangments is
'defaults to true because most will have a GP management plan in place';
comment on column chronic_disease_management.EPC_Referral.fk_team_care_arrangement is
'key to EPC_TeamCare_Arrangements table';


Create table chronic_disease_management.EPC_Link_Provider_Form
(pk serial primary key,
 fk_epc_referral integer not null,
 fk_type integer not null,
 number_services integer not null,
 deleted boolean default false)
  ;

 comment on table chronic_disease_management.EPC_Link_Provider_Form is
 'links the core EPC referral details to a provider on this form and number of services';

 Create table chronic_disease_management.Team_Care_Arrangements
 (pk serial primary key,
  fk_organisation integer default null,
  fk_employee integer default null,
  fk_person integer default null,
  responsibility text not null);
comment on table chronic_disease_management.Team_Care_Arrangements is
'the team care arrangements table';

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 106);

