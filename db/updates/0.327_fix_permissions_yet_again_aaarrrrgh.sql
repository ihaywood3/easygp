grant usage on chronic_disease_management.diabetes_annual_cycle_of_care_notes_pk_seq to staff;
grant usage on chronic_disease_management.diabetes_annual_cycle_of_care_pk_seq to staff;
grant usage on chronic_disease_management.epc_link_provider_form_pk_seq to staff;
grant usage on chronic_disease_management.epc_referral_pk_seq to staff;
grant usage on chronic_disease_management.lu_allied_health_type_pk_seq to staff;
grant usage on chronic_disease_management.lu_dacc_components_pk_seq to staff;
grant usage on chronic_disease_management.team_care_arrangements_pk_seq to staff;
truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 327)
