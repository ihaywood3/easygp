drop table clin_history.lu_dacc_components;
drop table chronic_disease_management.lu_dacc_components ;
drop table chronic_disease_management.team_care_arrangements;
DROP TABLE chronic_disease_management.epc_link_provider_form;

update db.lu_version set lu_minor=429;