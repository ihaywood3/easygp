alter table documents.documents add column incoming_referral boolean not null default 'f';


create or replace view documents.vwdocuments as  
SELECT documents.pk AS pk_document, documents.source_file, documents.fk_sending_entity, documents.imported_time, documents.date_requested, documents.date_created, documents.fk_patient, documents.fk_staff_filed_document, documents.originator, documents.originator_reference, documents.copy_to, documents.provider_of_service_reference, documents.internal_reference, documents.copies_to, documents.fk_staff_destination, documents.comment_on_document, documents.patient_access, documents.concluded, documents.deleted, documents.fk_lu_urgency, documents.tag, documents.tag_user, documents.md5sum, documents.html, documents.fk_unmatched_staff, documents.fk_referral, documents.fk_request, documents.fk_unmatched_patient, documents.fk_lu_display_as, documents.fk_lu_request_type, lu_request_type.type AS request_type, vwsendingentities.fk_lu_request_type AS sending_entity_fk_lu_request_type, vwsendingentities.request_type AS sending_entity_request_type, vwsendingentities.style, vwsendingentities.message_type, vwsendingentities.message_version, vwsendingentities.msh_sending_entity, vwsendingentities.msh_transmitting_entity, vwsendingentities.fk_lu_message_display_style, vwsendingentities.fk_branch AS fk_sender_branch, vwsendingentities.fk_employee AS fk_employee_branch, vwsendingentities.fk_person AS fk_sender_person, vwsendingentities.fk_lu_message_standard, vwsendingentities.exclude_ft_report, vwsendingentities.abnormals_foreground_color, vwsendingentities.abnormals_background_color, vwsendingentities.exclude_pit, vwsendingentities.person_occupation, vwsendingentities.organisation, vwsendingentities.organisation_category, vwpatients.fk_person AS patient_fk_person, vwpatients.firstname AS patient_firstname, vwpatients.surname AS patient_surname, vwpatients.birthdate AS patient_birthdate, vwpatients.sex AS patient_sex, vwpatients.age_numeric AS patient_age, vwpatients.title AS patient_title, vwpatients.street1 AS patient_street1, vwpatients.street2 AS patient_street2, vwpatients.town AS patient_town, vwpatients.state AS patient_state, vwpatients.postcode AS patient_postcode, vwstaff.wholename AS staff_destination_wholename, vwstaff.title AS staff_destination_title, unmatched_patients.surname AS unmatched_patient_surname, unmatched_patients.firstname AS unmatched_patient_firstname, unmatched_patients.birthdate AS unmatched_patient_birthdate, unmatched_patients.sex AS unmatched_patient_sex, unmatched_patients.title AS unmatched_patient_title, unmatched_patients.street AS unmatched_patient_street, unmatched_patients.town AS unmatched_patient_town, unmatched_patients.postcode AS unmatched_patient_postcode, unmatched_patients.state AS unmatched_patient_state, unmatched_staff.surname AS unmatched_staff_surname, unmatched_staff.firstname AS unmatched_staff_firstname, unmatched_staff.title AS unmatched_staff_title, unmatched_staff.provider_number AS unmatched_staff_provider_number, documents.incoming_referral as incoming_referral
   FROM documents.documents
   JOIN documents.vwsendingentities ON documents.fk_sending_entity = vwsendingentities.pk_sending_entities
   LEFT JOIN clin_requests.lu_request_type ON documents.fk_lu_request_type = lu_request_type.pk
   LEFT JOIN contacts.vwpatients ON documents.fk_patient = vwpatients.fk_patient
   LEFT JOIN admin.vwstaff ON documents.fk_staff_destination = vwstaff.fk_staff
   LEFT JOIN documents.unmatched_patients ON documents.fk_unmatched_patient = unmatched_patients.pk
   LEFT JOIN documents.unmatched_staff ON documents.fk_unmatched_staff = unmatched_staff.pk;


-- add referrer type 
alter table common.lu_occupations add column referrer_type char(1) default 'o' check (referrer_type in ('o','g','s'));


-- fix up errors in occupations
update common.lu_occupations set occupation=lower(occupation);
delete from common.lu_occupations where pk = 190 or pk= 189 or pk=282 ; -- psychologist is in four times
update contacts.data_persons set fk_occupation=84 where fk_occupation=190 or fk_occupation=189 or fk_occupation=282;
delete from common.lu_occupations where pk=132 or pk=180; -- cardiologist in three times
update contacts.data_persons set fk_occupation=37 where fk_occupation=132 or fk_occupation=180;
update common.lu_occupations set occupation='medical oncology registrar',referrer_type='g' where pk=118;
delete from common.lu_occupations where pk = 236 or pk=305; -- and in twice
update contacts.data_persons set fk_occupation=118 where fk_occupation=236 or fk_occupation=305;

delete from common.lu_occupations where pk = 153; -- geriatrician in twice
update contacts.data_persons set fk_occupation=67 where fk_occupation=153;
delete from common.lu_occupations where pk = 174; -- orthopaedic surgeon paediatric in twice
update contacts.data_persons set fk_occupation=164 where fk_occupation=174;
delete from common.lu_occupations where pk = 214; -- chef in twice
update contacts.data_persons set fk_occupation=213 where fk_occupation=214;

delete from common.lu_occupations where pk = 311; -- unknown in twice
update contacts.data_persons set fk_occupation=43 where fk_occupation=311;

delete from common.lu_occupations where pk = 293; -- colo-rectal surgeon in twice
update contacts.data_persons set fk_occupation=114 where fk_occupation=293;

delete from common.lu_occupations where pk = 242; -- vascular surgeon in twice
update contacts.data_persons set fk_occupation=134 where fk_occupation=242;

delete from common.lu_occupations where pk = 178; -- urologist in twice
update contacts.data_persons set fk_occupation=136 where fk_occupation=178;

delete from common.lu_occupations where pk = 182; -- medical practitioner in twice
update contacts.data_persons set fk_occupation=28 where fk_occupation=182;
update common.lu_occupations set occupation='paediatric urologist',referrer_type='s' where pk=170;
update common.lu_occupations set referrer_type='g' where pk=83; -- "doctor"

delete from common.lu_occupations where pk = 181; -- ENT surgeon in twice
update contacts.data_persons set fk_occupation=42 where fk_occupation=181;
update common.lu_occupations set referrer_type='g' where pk=20; -- GP
update common.lu_occupations set referrer_type='g' where pk=28; -- "medical practitioner"
update common.lu_occupations set referrer_type='g' where pk=61; -- psychiatry registrar
update common.lu_occupations set referrer_type='g' where pk=138; -- orthopaedic registrar
update common.lu_occupations set referrer_type='g' where pk=146; -- haematology registrar
update common.lu_occupations set referrer_type='g' where pk=165; -- ENT registrar
update common.lu_occupations set referrer_type='g' where pk=219; -- CMO
update common.lu_occupations set referrer_type='g' where pk=245; -- HMO
update common.lu_occupations set referrer_type='g' where pk=290; -- neurosurgery registrar
update common.lu_occupations set referrer_type='g' where pk=309; -- surgery registrar
update common.lu_occupations set referrer_type='g' where pk=285; -- urology registrar
update common.lu_occupations set referrer_type='g' where pk=294; -- registrar


update common.lu_occupations set referrer_type='g',occupation='haematology registrar' where pk=304;

update common.lu_occupations set referrer_type='g',occupation='radiation oncology registrar' where pk=113;

update common.lu_occupations set referrer_type='s' where pk=112;
delete from common.lu_occupations where pk = 196; -- radiation oncologist in twice
update contacts.data_persons set fk_occupation=112 where fk_occupation=196;

delete from common.lu_occupations where pk = 291; -- surg reg in twice
update contacts.data_persons set fk_occupation=309 where fk_occupation=291;

update common.lu_occupations set referrer_type='s' where pk=259;
delete from common.lu_occupations where pk = 128; -- medical oncologist in twice
update contacts.data_persons set fk_occupation=259 where fk_occupation=128;

delete from common.lu_occupations where pk = 253; -- emergency physician in twice
update contacts.data_persons set fk_occupation=115 where fk_occupation=253;

delete from common.lu_occupations where pk = 273 or pk = 157 or pk=119; -- rehab physician  in four times
update contacts.data_persons set fk_occupation=280 where fk_occupation=273 or fk_occupation=119 or fk_occupation=157;

delete from common.lu_occupations where pk = 120 or pk=172; -- pain physician  in twice
update contacts.data_persons set fk_occupation=264 where fk_occupation=120 or fk_occupation=172;

delete from common.lu_occupations where pk = 275; -- occupational physician  in twice
update contacts.data_persons set fk_occupation=177 where fk_occupation=275;
update common.lu_occupations set referrer_type='s' where pk=156;
update common.lu_occupations set referrer_type='s' where pk=306;
update common.lu_occupations set referrer_type='s' where pk=41;
delete from common.lu_occupations where pk = 173 or pk= 241; -- rheumatologist in three times
update contacts.data_persons set fk_occupation=41 where fk_occupation=173 or fk_occupation=241;

update common.lu_occupations set occupation='nuclear medicine physician' where pk=15;
update common.lu_occupations set occupation='counselling psychologist' where pk=223;
update common.lu_occupations set occupation='oral surgeon',referrer_type='s' where pk=175;
update common.lu_occupations set occupation='chief executive officer' where pk=18;
update common.lu_occupations set occupation='gardener' where pk=57;
update common.lu_occupations set occupation='physician - musculoskeletal' where pk=161;
update common.lu_occupations set occupation='liaison officer' where pk=62;
update common.lu_occupations set occupation='bereavement counsellor - adult' where pk=263;
update common.lu_occupations set referrer_type='s',occupation='pain physician' where pk=264;
update common.lu_occupations set occupation='addiction medicine specialist',referrer_type='s' where pk=269;
update common.lu_occupations set occupation='psychogeriatrician' where pk=274;
update common.lu_occupations set occupation='forensic psychologist' where pk=262;
update common.lu_occupations set referrer_type='s' where (occupation ilike '%ologist%' and not (occupation ilike 'audiologist' or occupation ilike '%psychologist%')) or occupation ilike '%surgeon%' or occupation ilike '%physician%';
update common.lu_occupations set referrer_type='s' where occupation ilike '%iatrician';
update common.lu_occupations set referrer_type='s' where pk=246;
update common.lu_occupations set referrer_type='s' where occupation ilike '%psychiatrist%';
update common.lu_occupations set referrer_type='o' where pk=247; -- speech pathologists are not specialists
update common.lu_occupations set occupation='medical registrar',referrer_type='g' where pk=318;

-- now make sure we cover every AHPRA-registered specialty and its registrars


insert into common.lu_occupations(occupation,referrer_type) values ('rheumatology registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('cardiology registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('child psychiatrist','s');
insert into common.lu_occupations(occupation,referrer_type) values ('child psychiatry registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('general practice registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('intern','g');
insert into common.lu_occupations(occupation,referrer_type) values ('court registrar','o');
insert into common.lu_occupations(occupation,referrer_type) values ('urogynaecologist','s');
insert into common.lu_occupations(occupation,referrer_type) values ('forensic psychiatrist','s');
insert into common.lu_occupations(occupation,referrer_type) values ('sexual health physician','s');
insert into common.lu_occupations(occupation,referrer_type) values ('public health physician','s');
insert into common.lu_occupations(occupation,referrer_type) values ('ivf specialist','s');

insert into common.lu_occupations(occupation,referrer_type) values ('clinical geneticist','s');
insert into common.lu_occupations(occupation,referrer_type) values ('paediatric cardiologist','s');
insert into common.lu_occupations(occupation,referrer_type) values ('paediatric emergency physician','s');
insert into common.lu_occupations(occupation,referrer_type) values ('paediatric endocrinologist','s');
insert into common.lu_occupations(occupation,referrer_type) values ('paediatric haematologist','s');
insert into common.lu_occupations(occupation,referrer_type) values ('paediatric infectious diseases physician','s');
insert into common.lu_occupations(occupation,referrer_type) values ('paediatric oncologist','s');
insert into common.lu_occupations(occupation,referrer_type) values ('paediatric nephrologist','s');
insert into common.lu_occupations(occupation,referrer_type) values ('paediatric nuclear medicine physician','s');
insert into common.lu_occupations(occupation,referrer_type) values ('paediatric palliative care physician','s');
insert into common.lu_occupations(occupation,referrer_type) values ('paediatric respiratory physician','s');
insert into common.lu_occupations(occupation,referrer_type) values ('paediatric rheumatologist','s');
insert into common.lu_occupations(occupation,referrer_type) values ('forensic pathologist','s');
insert into common.lu_occupations(occupation,referrer_type) values ('pathologist','s');
insert into common.lu_occupations(occupation,referrer_type) values ('chemical pathologist','s');
insert into common.lu_occupations(occupation,referrer_type) values ('anatomical pathologist','s');
insert into common.lu_occupations(occupation,referrer_type) values ('microbiologist','s');
insert into common.lu_occupations(occupation,referrer_type) values ('clinical pharmacologist','s');
insert into common.lu_occupations(occupation,referrer_type) values ('pathology registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('obstetric registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('gynaecology registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('paediatric registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('psychogeriatric registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('geriatric registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('addiction medicine registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('paliative care registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('palliative care physician','s');
insert into common.lu_occupations(occupation,referrer_type) values ('anaesthesic registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('dermatology registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('emergency registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('icu registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('medical administrator','s');
insert into common.lu_occupations(occupation,referrer_type) values ('occupational medicine registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('ophthalmology registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('pain medicine registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('clinical genetics registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('clinical pharmacology registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('endocrinology registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('gastroenterology registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('renal registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('immunology registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('infectious diseases registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('neurology registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('nuclear medicine registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('respiratory registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('public health registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('medical administration registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('radiology registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('rehabilitation registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('sexual health registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('sports medicine registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('cardio-thoracic registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('maxillo-facial registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('paediatric surgical registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('plastics registrar','g');
insert into common.lu_occupations(occupation,referrer_type) values ('vascular registrar','g');
 
truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 212);

