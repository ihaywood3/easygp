-- we all have crap in this namespace
-- you won't have all these or any ignore the errors
drop table public.dailymed;
drop table public.forms1;
drop table public.inventory_items_lent;
DROP SEQUENCE public.inventory_items_lent_pk_seq;
drop table public.lu_modes;
drop table public.rawpbs;
drop table public.temp;
drop table public.web;
DROP SEQUENCE public.authority_number;
DROP SEQUENCE public.pbsconvert_id_seq;
DROP SEQUENCE public.script_number;
DROP SEQUENCE public.web_pk_seq;
DROP TABLE atc_codes;
DROP TABLE brands;
DROP TABLE categories;
DROP TABLE dosage;
DROP TABLE drug;
DROP TABLE drug_interactions;
DROP TABLE external_links;
DROP TABLE food_interactions;
DROP TABLE general_references;
DROP TABLE link_drug_to_atc_code;
DROP TABLE link_drug_to_category;
DROP TABLE link_drug_to_dosage; 
DROP TABLE lu_external_resources;
DROP TABLE patents;
DROP TABLE salts;
DROP TABLE synonyms;
update db.lu_version set lu_minor = 442;
