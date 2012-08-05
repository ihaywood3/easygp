Drop schema clin_allergies cascade;

Create schema clin_allergies;

GRANT ALL On SCHEMA clin_allergies To easygp;
GRANT ALL On SCHEMA clin_allergies To easygp;
GRANT USAGE On SCHEMA clin_allergies To staff;

Create table clin_allergies.lu_reaction_type
(pk serial primary key,
 type text Not Null);
 
ALTER TABLE clin_allergies.lu_reaction_type OWNER To easygp;
GRANT ALL On TABLE clin_allergies.lu_reaction_type To easygp;
GRANT ALL On TABLE clin_allergies.lu_reaction_type To staff;

insert into clin_allergies.lu_reaction_type(type)values( 'allergy');
insert into clin_allergies.lu_reaction_type(type)values( 'sensitivity');

Create table clin_allergies.allergies
  (pk serial primary key,
  fk_consult integer Not Null,
  fk_brand uuid Default Null, 
  fk_product uuid Default Null,
  allergen text Default Null, 
  specificity char(1) Default Null, 
  details text Not Null,
  fk_lu_reaction_type integer Not Null,
  fk_coding_system integer,
  fk_code text Default Null, 
  confirmed boolean Default True, 
  deleted boolean Default False, 
  date_reaction text Default Null, 
  fk_progressNote integer Not Null,
 CONSTRAINT allergies_fk_consult_fkey FOREIGN KEY(fk_consult)
      REFERENCES clin_consult.consult(pk)MATCH SIMPLE
      On UPDATE NO ACTION On DELETE NO ACTION,
 CONSTRAINT allergies_fk_brand_fkey FOREIGN KEY(fk_brand)
      REFERENCES drugs.brand(pk)MATCH SIMPLE
      On UPDATE NO ACTION On DELETE NO ACTION,
 CONSTRAINT allergies_fk_product_fkey FOREIGN KEY(fk_product)
      REFERENCES drugs.product(pk)MATCH SIMPLE
      On UPDATE NO ACTION On DELETE NO ACTION,
 CONSTRAINT allergies_specificity_check 
      CHECK(specificity:: text = 'c'::text OR specificity = 'b'::text OR specificity = 'g'::text OR specificity IS NULL),
 CONSTRAINT allergies_fk_lu_reaction_type_key FOREIGN KEY(fk_lu_reaction_type)
      REFERENCES clin_allergies.lu_reaction_type(pk)MATCH SIMPLE
      On UPDATE NO ACTION On DELETE NO ACTION,
CONSTRAINT allergies_fk_progressnote_fkey FOREIGN KEY(fk_progressnote)
      REFERENCES clin_consult.progressnotes(pk)MATCH SIMPLE
 );
 
ALTER TABLE clin_allergies.allergies OWNER To easygp;
GRANT ALL On TABLE clin_allergies.allergies To easygp;
GRANT ALL On TABLE clin_allergies.allergies To staff;


COMMENT On COLUMN clin_allergies.allergies.fk_consult Is
'key to clin_consult.consult table > points to consult created and patient details';
COMMENT On COLUMN clin_allergies.allergies.fk_brand Is
'if not null key to drugs.brand table points to brand with which this allergy was noted';
COMMENT On COLUMN clin_allergies.allergies.fk_product Is
'if not null key to drugs.product table points to product (generic) with which this allergy was noted';
COMMENT On COLUMN clin_allergies.allergies.allergen Is
'if not null then the substance that the person was allergic or sensitive to, eg could be bee or cedar';
COMMENT On COLUMN clin_allergies.allergies.specificity Is
'the degree of specificity of the allergy c= class effect eg non-steroidals b= brand specific e.g could be a coloring agent in a tablet or g=generic specific eg naproxen but hence not all nsaids';
COMMENT On COLUMN clin_allergies.allergies.details Is
'free text representation of the reaction, could be say anaphlyaxis of ''gets diarrhoea''';
COMMENT On COLUMN clin_allergies.allergies.fk_lu_reaction_type Is
'foreign key to allergies.lu_reaction_type 1=allergy 2=sensitivity';
COMMENT On COLUMN clin_allergies.allergies.fk_coding_system Is 
'key to coding.lu_coding_system containing name of coding system   that this allergy is linked to';
COMMENT On COLUMN clin_allergies.allergies.fk_code Is 
'the text of the code references coding.generic_terms.code';
COMMENT On COLUMN clin_allergies.allergies.confirmed Is 
'if true (the default) then the allergy has been confirmed';
COMMENT On COLUMN clin_allergies.allergies.deleted Is '
If True Then this record Is Marked As Deleted ';
COMMENT On COLUMN clin_allergies.allergies.date_reaction Is '
the Date Of reaction, could be Date, could be Year ';
COMMENT On COLUMN clin_allergies.allergies.fk_progressnote Is '
The associated progress note summary Of this allergy - at least Of the latest Time it was accessed ';

Create view clin_allergies.vwAllergies As
Select 
  clin_allergies.allergies.pk,
  clin_allergies.allergies.fk_consult,
  clin_allergies.allergies.fk_brand,
  clin_allergies.allergies.fk_product,
  clin_allergies.allergies.allergen,
  clin_allergies.allergies.specificity,
  clin_allergies.allergies.details,
  clin_allergies.allergies.fk_lu_reaction_type,
  clin_allergies.allergies.fk_progressnote,
  lu_reaction_type.type As Reaction_type, 
  clin_allergies.allergies.fk_coding_system,
  clin_allergies.allergies.fk_code,
  clin_allergies.allergies.confirmed,
  clin_allergies.allergies.deleted,
  clin_allergies.allergies.date_reaction,
  clin_consult.consult.fk_patient,
  clin_consult.consult.consult_date,
  clin_consult.consult.fk_staff As Fk_staff_logged_allergy,
  drugs.atc.atccode As Product_atccode,
  drugs.atc.atcname As Product_atcname,
  coding.generic_terms.term,
  coding.lu_systems.system As Coding_system,
  drugs.product.generic, atc1.atccode As Class_code, atc1.atcname As Class_name,
  drugs.brand.brand,
  progressnotes.notes
From
  clin_allergies.allergies
  JOIN clin_allergies.lu_reaction_type ON(clin_allergies.allergies.fk_lu_reaction_type = clin_allergies.lu_reaction_type.pk)
  JOIN clin_consult.consult ON(clin_allergies.allergies.fk_consult = clin_consult.consult.pk)
  JOIN clin_consult.progressnotes On allergies.fk_progressnote = progressnotes.pk
  Left JOIN drugs.brand ON(clin_allergies.allergies.fk_brand = drugs.brand.pk)
  Left JOIN drugs.product ON(clin_allergies.allergies.fk_product = drugs.product.pk)
  Left JOIN drugs.atc ON(drugs.product.atccode = drugs.atc.atccode)
  Left JOIN coding.generic_terms ON(clin_allergies.allergies.fk_code = coding.generic_terms.code)
  Left JOIN coding.lu_systems ON(clin_allergies.allergies.fk_coding_system = coding.lu_systems.pk)
  Left JOIN drugs.atc atc1 On substring(drugs.product.atccode For 4) = atc1.atccode;
  

ALTER TABLE clin_allergies.vwallergies OWNER To easygp;
GRANT ALL On TABLE clin_allergies.vwallergies To easygp;
GRANT ALL On TABLE clin_allergies.vwallergies To staff;

truncate db.lu_version;
insert into db.lu_version(lu_major, lu_minor)values(0, 202);
