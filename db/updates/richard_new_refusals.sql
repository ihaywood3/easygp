-- some tables to handle automated reminders and refusals or ineligability of care by patients

create schema clin_refusals;
GRANT ALL ON SCHEMA clin_refusals TO easygp;
GRANT USAGE ON SCHEMA clin_refusals TO staff;

Comment on schema clin_refusals is 
		'contains information about things patient''s refuse to do
		for i) to cover the clinician - medico-legal reasons
		    ii) so as not to bug them all the time with  reminders & questions
		that way we don''t get angst and ''I''ve already told  yout that lots of times!
		Note this may or may not (often not) have anything to do with recalls';

Create table clin_recalls.lu_automated_reminders
( pk serial primary key,
  reminder text not null);
  
ALTER TABLE  clin_recalls.lu_automated_reminders OWNER TO easygp;
GRANT ALL ON TABLE clin_recalls.lu_automated_reminders TO easygp;
GRANT ALL ON TABLE clin_recalls.lu_automated_reminders to staff;

COMMENT ON TABLE clin_recalls.lu_automated_reminders IS
'a list of reminders we may want to send automatically for example ''flu vaccination due'' or ''STD screen for an age group''';

insert into clin_recalls.lu_automated_reminders (reminder) VALUES ('influenza vaccination');
insert into clin_recalls.lu_automated_reminders (reminder) VALUES ('pneumococcal vaccination');
insert into clin_recalls.lu_automated_reminders (reminder) VALUES ('over 45yrs health check');
insert into clin_recalls.lu_automated_reminders (reminder) VALUES ('over 75yr health assessment');
  

CREATE TABLE  clin_recalls.lu_reason_exclusion_from_reminders
(
 pk serial primary key,
 reason text not null
 );

ALTER TABLE clin_recalls.lu_reason_exclusion_from_reminders OWNER TO easygp;
GRANT ALL ON TABLE clin_recalls.lu_reason_exclusion_from_reminders TO easygp;
GRANT ALL ON TABLE clin_recalls.lu_reason_exclusion_from_reminders to staff;

INSERT INTO  clin_recalls.lu_reason_exclusion_from_reminders(reason) VALUES ('terminally ill');
INSERT INTO  clin_recalls.lu_reason_exclusion_from_reminders(reason) VALUES ('deceased');
INSERT INTO  clin_recalls.lu_reason_exclusion_from_reminders(reason) VALUES ('patient request');
INSERT INTO  clin_recalls.lu_reason_exclusion_from_reminders(reason) VALUES ('clinician decision');

CREATE TABLE clin_recalls.exclude_from_reminders
(pk serial primary key,
 fk_consult integer not null references clin_consult.consult(pk),
 fk_lu_automated_reminded integer not null references  clin_recalls.lu_automated_reminders(pk),
 fk_lu_reason_exclusion_reminders integer not null references clin_recalls.lu_reason_exclusion_from_reminders (pk),
 patient_comment text default null,
 clinician_note text default null
 );

ALTER TABLE clin_recalls.exclude_from_reminders OWNER TO easygp;
GRANT ALL ON TABLE clin_recalls.exclude_from_reminders TO easygp;
GRANT ALL ON TABLE clin_recalls.exclude_from_reminders to staff;


Create table clin_refusals.lu_refusal_category
(pk serial primary key,
 category text not null);

COMMENT ON TABLE clin_refusals.lu_refusal_category IS 
'categorisation of either
 a) refusals by the patient for a service e.g preventative care or
 b) ineligability for a service eg EPC items';

ALTER TABLE Clin_refusals.lu_refusal_category OWNER TO easygp;
GRANT ALL ON TABLE Clin_refusals.lu_refusal_category TO easygp;
GRANT ALL ON Clin_refusals.lu_refusal_category to staff;

INSERT INTO clin_refusals.lu_refusal_category (category) Values ('Preventative Care');
INSERT INTO clin_refusals.lu_refusal_category (category) Values ('Referral');
INSERT INTO clin_refusals.lu_refusal_category (category) Values ('Medication Related');
INSERT INTO clin_refusals.lu_refusal_category (category) Values ('Ineligible for Service');


CREATE TABLE Clin_Refusals.refusals
(pk serial primary key,
 fk_consult integer not null references clin_consult.consult(pk),
 date_noted text,
 fk_lu_refusal_category integer not null references clin_refusals.lu_refusal_category(pk),
 refusal text not null,
 refusal_reason_patient text default null,
 clinician_notes text default null,
 permanant boolean default false,
 exclusion_duration_months integer default null
 );
 
 
COMMENT ON TABLE clin_refusals.refusals IS 'keeps a list of things patient has refused in their clinical care + reasons why or things we have refused (ineligible)';
COMMENT ON COLUMN clin_refusals.refusals.date_noted IS'when this issue was noted, may not be consult_date, could be eg a date or mm/yyyy or yyyy' ;
COMMENT ON COLUMN clin_refusals.refusals.fk_lu_refusal_category IS'the category e.g Preventative Care';
COMMENT ON COLUMN clin_refusals.refusals.refusal IS 'a brief decription of the refusal e.g ''No influenza vaccination''';
COMMENT ON COLUMN clin_refusals.refusals.refusal_reason_patient IS 'why they refuse eg ''It always gives me the flu''';
COMMENT ON COLUMN clin_refusals.refusals.clinician_notes  IS 'any additional comment or explanation by the clinician';
COMMENT ON COLUMN clin_refusals.refusals.exclusion_duration_months IS'if not null, then the number of months this exclusion applies';
COMMENT ON COLUMN clin_refusals.refusals.permanant IS  'if TRUE the exclusion is permananant eg may not want flu needle this year, but happy for next year';

