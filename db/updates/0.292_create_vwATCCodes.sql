-- creates a view of a drugs atccode and all drugs that this interacts with
-- used in interactions
CREATE OR REPLACE VIEW drugbank.vwdrugatccodeinteractions AS 
 SELECT drug_interactions.pk AS pk_view, drug.name, atc1.atc_code,
 drug1.name AS drug_interacts_with, drug_interactions.description,
 atc2.atc_code AS atc_code_interacts_with
   FROM drugbank.drug
   JOIN drugbank.drug_interactions ON drug.pk = drug_interactions.fk_drug
   JOIN drugbank.link_drug_to_atc_code ON drug.pk = link_drug_to_atc_code.fk_drug
   JOIN drugbank.atc_codes atc1 ON link_drug_to_atc_code.fk_atc_code = atc1.pk
   JOIN drugbank.drug drug1 ON drug_interactions.fk_interacts_with = drug1.pk
   JOIN drugbank.link_drug_to_atc_code link_drug_atc2 ON drug1.pk = link_drug_atc2.fk_drug
   JOIN drugbank.atc_codes atc2 ON link_drug_atc2.fk_atc_code = atc2.pk;

ALTER TABLE drugbank.vwdrugatccodeinteractions  OWNER TO easygp;
GRANT ALL ON TABLE drugbank.vwdrugatccodeinteractions TO easygp;
GRANT SELECT ON TABLE drugbank.vwdrugatccodeinteractions TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 292);

