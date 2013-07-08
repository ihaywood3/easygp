 --drop view drugbank.vwATCDrugFoodInteractions;
Create or replace view drugbank.vwATCDrugFoodInteractions as
SELECT 
  atc_codes.atc_code,
   drug.name,
  food_interactions.pk,
  food_interactions.food_interaction
FROM 
  drugbank.food_interactions, 
  drugbank.link_drug_to_atc_code, 
  drugbank.drug, 
  drugbank.atc_codes
WHERE 
  food_interactions.fk_drug = link_drug_to_atc_code.fk_drug AND
  link_drug_to_atc_code.fk_drug = drug.pk AND
  link_drug_to_atc_code.fk_atc_code = atc_codes.pk
 ;

 COMMENT ON VIEW  drugbank.vwATCDrugFoodInteractions IS
 'a view of drugs atccode linked to food interactions';
 
  ALTER TABLE drugbank.vwATCDrugFoodInteractions owner to EASYGP;
GRANT ALL ON TABLE drugbank.vwATCDrugFoodInteractions to EASYGP;
GRANT select on drugbank.vwATCDrugFoodInteractions to staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 299)
