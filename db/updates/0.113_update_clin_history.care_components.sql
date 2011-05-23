-- added a column to this table so that if the user so wishes, the component when due is sent a recall

CREATE TABLE clin_history.care_plan_components
(
  pk serial primary key,
  fk_pasthistory integer NOT NULL, 
  fk_reason integer NOT NULL, 
  due date not null, 
  fk_recall integer default null);

  
ALTER TABLE clin_history.care_plan_components OWNER TO easygp;
GRANT ALL ON TABLE clin_history.care_plan_components TO easygp;
GRANT ALL ON TABLE clin_history.care_plan_components TO staff;

COMMENT ON TABLE clin_history.care_plan_components IS 
'links a health issue - fk_pasthistory - to a component of care and when it is due.
 There is some duplication in this table:
 - many  ''components'' of a care plan are the same as reasons for a recall eg hba1c, or diabetic annual cycle of care
   and most we will want to automatically recall, hence for the moment I''ve used clin_recalls.lu_reasons to be the components name.
 -  if fk_recall is not null then there is a recall linked to this component.
 -  As each fk_pasthistory is unique to a patient and not re-used, 
    this key identifies the patient or visa-versa - i.e the patient''s past history item or health issue identifies its care plan components.';
COMMENT ON COLUMN clin_history.care_plan_components.fk_pasthistory IS 'foreign key references clin_history.past_history.pk';
COMMENT ON COLUMN clin_history.care_plan_components.fk_reason IS 'foreign key references clin_recalls.lu_reasons';
COMMENT ON COLUMN clin_history.care_plan_components.due IS 'date the comment is due to be done';
COMMENT ON COLUMN clin_history.care_plan_components.fk_recall IS 'if not null, then is the key to clin_recalls.recalls table'


CREATE OR REPLACE VIEW clin_history.vwcareplancomponents AS 
 SELECT care_plan_components.fk_pasthistory, lu_reasons.reason, care_plan_components.fk_reason, 
 care_plan_components.pk AS pk_careplan_components, care_plan_components.due , care_plan_components.fk_recall,
clin_recalls.vwRecalls.fk_staff,
clin_recalls.vwRecalls.interval,
clin_recalls.vwRecalls.fk_interval_unit,
clin_recalls.vwRecalls.default_interval,
clin_recalls.vwRecalls.fk_default_interval_unit,
clin_recalls.vwRecalls.fk_contact_by,
clin_recalls.vwRecalls.abbrev_text
   FROM clin_history.care_plan_components
   JOIN clin_recalls.lu_reasons ON care_plan_components.fk_reason = lu_reasons.pk
   LEFT JOIN clin_recalls.vwRecalls on care_plan_components.fk_recall = clin_recalls.vwRecalls.pk_recall
  ORDER BY care_plan_components.fk_pasthistory, care_plan_components.due;

ALTER TABLE clin_history.vwcareplancomponents OWNER TO easygp;
GRANT ALL ON TABLE clin_history.vwcareplancomponents TO easygp;
GRANT ALL ON TABLE clin_history.vwcareplancomponents TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 113);

