-- an update to allow recording 'no known allergies' i.e the patient has been asked
-- the field allergies.no_known_allergies becomes the only manadatory field
-- renamed the module to better reflect its purpose
update admin.lu_clinical_modules set name='Allergies & Sensitivities' where pk=13;

Alter table clin_allergies.allergies add column nil_allergies_sensitivities boolean default false;

alter table clin_allergies.allergies alter column details drop not null;
alter table clin_allergies.allergies alter column fk_lu_reaction_type  drop not null;

CREATE OR REPLACE VIEW clin_allergies.vwallergies AS 
 SELECT allergies.pk, allergies.fk_consult, allergies.fk_brand, allergies.fk_product, 
 allergies.allergen, allergies.specificity, allergies.details, allergies.fk_lu_reaction_type, 
 allergies.fk_progressnote, lu_reaction_type.type AS reaction_type, allergies.fk_coding_system, 
 allergies.fk_code, allergies.confirmed, allergies.deleted, allergies.date_reaction, 
 consult.fk_patient, consult.consult_date, consult.fk_staff AS fk_staff_logged_allergy, 
 atc.atccode AS product_atccode, atc.atcname AS product_atcname, generic_terms.term, 
 lu_systems.system AS coding_system, product.generic, atc1.atccode AS class_code, 
 atc1.atcname AS class_name, brand.brand, progressnotes.notes,allergies.nil_allergies_sensitivities
   FROM clin_allergies.allergies
   LEFT JOIN clin_allergies.lu_reaction_type ON allergies.fk_lu_reaction_type = lu_reaction_type.pk
   JOIN clin_consult.consult ON allergies.fk_consult = consult.pk
   JOIN clin_consult.progressnotes ON allergies.fk_progressnote = progressnotes.pk
   LEFT JOIN drugs.brand ON allergies.fk_brand = brand.pk
   LEFT JOIN drugs.product ON allergies.fk_product = product.pk
   LEFT JOIN drugs.atc ON product.atccode::text = atc.atccode
   LEFT JOIN coding.generic_terms ON allergies.fk_code = generic_terms.code
   LEFT JOIN coding.lu_systems ON allergies.fk_coding_system = lu_systems.pk
   LEFT JOIN drugs.atc atc1 ON "substring"(product.atccode::text, 1, 4) = atc1.atccode;

ALTER TABLE clin_allergies.vwallergies   OWNER TO easygp;
GRANT ALL ON TABLE clin_allergies.vwallergies TO easygp;
GRANT ALL ON TABLE clin_allergies.vwallergies TO staff;

 
truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 320);

