-- start of putting progress notes attached to entering family history
-- not yet implemented, I'm in two minds about doing so, progress notes will end up really cluttered with stuff

Alter table clin_history.family_conditions add column fk_progressnote integer ;
 DROP VIEW clin_history.vwfamilyhistory;

CREATE OR REPLACE VIEW clin_history.vwfamilyhistory AS 
 SELECT family_conditions.pk AS pk_view, family_links.fk_member, family_members.fk_consult AS fk_consult_familymember, 
 family_members.fk_relationship, family_members.fk_person, family_members.name, family_members.birthdate, 
 family_members.age_of_death, family_members.fk_occupation, family_members.fk_country_birth, 
 family_members.deleted AS member_deleted, family_links.fk_patient, family_links.pk AS fk_link, 
 family_conditions.pk AS fk_condition, family_conditions.condition, family_conditions.diagnosis_certain, 
 family_conditions.fk_consult AS fk_consult_condition, family_conditions.fk_code, family_conditions.age_of_onset, 
 family_conditions.cause_of_death, family_conditions.notes, family_conditions.deleted AS condition_deleted, 
 family_conditions.contributed_to_death, family_conditions.fk_progressnote,
 lu_countries.country, lu_occupations.occupation, 
 lu_family_relationships.relationship, family_links.deleted AS link_deleted, generic_terms.code, generic_terms.term
   FROM clin_history.family_links
   LEFT JOIN clerical.data_patients ON family_links.fk_patient = data_patients.pk
   JOIN clin_history.family_members ON family_links.fk_member = family_members.pk
   JOIN clin_history.family_conditions ON family_links.fk_member = family_conditions.fk_member
   LEFT JOIN common.lu_countries ON family_members.fk_country_birth = lu_countries.country_code
   LEFT JOIN common.lu_occupations ON family_members.fk_occupation = lu_occupations.pk
   JOIN common.lu_family_relationships ON family_members.fk_relationship = lu_family_relationships.pk
   LEFT JOIN coding.generic_terms ON family_conditions.fk_code = generic_terms.code
  WHERE family_members.deleted = false AND family_conditions.deleted = false
  ORDER BY family_links.fk_patient, family_links.fk_member;

ALTER TABLE clin_history.vwfamilyhistory OWNER TO easygp;
GRANT ALL ON TABLE clin_history.vwfamilyhistory TO staff;

update db.lu_version set lu_minor=347;