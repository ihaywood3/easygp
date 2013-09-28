-- View: drugbank.vw_basic_drug_pi

-- DROP VIEW drugbank.vw_basic_drug_pi;

CREATE OR REPLACE VIEW drugbank.vw_basic_drug_pi AS 
 SELECT pregnancy_code.code AS pregnancy_code, pregnancy_code.safety AS pregnancy_safety, drug.pk, drug.drugbank_id, drug.description, drug.cas_number, drug.indication, drug.pharmacology, drug.mechanism_of_action, drug.toxicity, drug.biotransformation, drug.absorption, drug.half_life, drug.route_of_elimination, drug.volume_of_distribution, drug.clearance, drug.name
   FROM drugbank.drug
   LEFT JOIN drugbank.pregnancy_code ON pregnancy_code.fk_drug = drug.pk;

ALTER TABLE drugbank.vw_basic_drug_pi
  OWNER TO easygp;
Grant all on table drugbank.vw_basic_drug_pi to staff;