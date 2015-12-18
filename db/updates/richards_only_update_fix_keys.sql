ALTER TABLE admin.vwpreferences   OWNER TO easygp;
grant select on admin.vwPreferences to staff;
ALTER TABLE contacts.vwPatients   OWNER TO easygp;
grant select on contacts.vwPatients to staff;
delete from contacts.links_persons_comms where pk between 22292 and 37061;
delete from contacts.links_persons_addresses where fk_address = 7402; -- removes mark brown's extra address
delete from contacts.data_addresses where pk = 7402;
delete from contacts.links_persons_addresses where pk between 12450 and 17418; -- 'gets rid of all address_person links where there is no persons in persons table
delete from contacts.data_persons where pk = 12465;
delete from clerical.data_family_members where fk_patient between 7501 and 17421;
delete from clin_prescribing.prescribed_for_habits where 
fk_generic_product = '5382a0f0-c543-5cac-9684-88cdee651b2a' or
fk_generic_product = '4d6f93c3-e30d-4d47-9cea-6704601067ce' or
fk_generic_product = '5e862a38-224d-465c-9a1a-9515eb736e18' or
fk_generic_product = '0f112169-2924-459d-a4e4-a2d013ecf022' or
fk_generic_product = '0f112169-2924-459d-a4e4-a2d013ecf022' or
fk_generic_product = '0f112169-2924-459d-a4e4-a2d013ecf022' or
fk_generic_product = '0f112169-2924-459d-a4e4-a2d013ecf022' or
fk_generic_product = '0f112169-2924-459d-a4e4-a2d013ecf022' or
fk_generic_product = '03c7b331-fb4b-48c2-8932-08270ec986da' or
fk_generic_product = '03c7b331-fb4b-48c2-8932-08270ec986da' or
fk_generic_product = '1a95ee44-516c-439e-9777-1818ea060c3d' or
fk_generic_product = '0f112169-2924-459d-a4e4-a2d013ecf022' or
fk_generic_product = 'b791e50b-0e08-47ad-bf0d-49cb477a9bc8' or
fk_generic_product = '0f112169-2924-459d-a4e4-a2d013ecf022' or
fk_generic_product = '0f112169-2924-459d-a4e4-a2d013ecf022' or 
fk_generic_product ='6812260e-c377-4378-84d3-8f1880191ec6';
delete from clin_prescribing.instruction_habits where 
fk_generic_product = '5382a0f0-c543-5cac-9684-88cdee651b2a' or
fk_generic_product = '4d6f93c3-e30d-4d47-9cea-6704601067ce' or
fk_generic_product = '5e862a38-224d-465c-9a1a-9515eb736e18' or
fk_generic_product = '0f112169-2924-459d-a4e4-a2d013ecf022' or
fk_generic_product = '0f112169-2924-459d-a4e4-a2d013ecf022' or
fk_generic_product = '0f112169-2924-459d-a4e4-a2d013ecf022' or
fk_generic_product = '0f112169-2924-459d-a4e4-a2d013ecf022' or
fk_generic_product = '0f112169-2924-459d-a4e4-a2d013ecf022' or
fk_generic_product = '03c7b331-fb4b-48c2-8932-08270ec986da' or
fk_generic_product = '03c7b331-fb4b-48c2-8932-08270ec986da' or
fk_generic_product = '1a95ee44-516c-439e-9777-1818ea060c3d' or
fk_generic_product = '0f112169-2924-459d-a4e4-a2d013ecf022' or
fk_generic_product = 'b791e50b-0e08-47ad-bf0d-49cb477a9bc8' or
fk_generic_product = '0f112169-2924-459d-a4e4-a2d013ecf022' or
fk_generic_product = '0f112169-2924-459d-a4e4-a2d013ecf022' or 
fk_generic_product ='6812260e-c377-4378-84d3-8f1880191ec6';
update drugs.brand set fk_company = null  where fk_company = 'EVI';
update drugs.brand set fk_company = null  where fk_company = 'EXP';-- 
delete  from clin_workcover.visits where pk <54;
delete from clin_workcover.visits where fk_claim <28;
delete  from clin_workcover.claims where pk < 28;
update clin_workcover.visits set fk_progressnote = 154182 where pk = 724; 
update clin_workcover.visits set fk_progressnote = 154378 where pk = 725;
-- missing all linked documents between 11800 and 12378
delete from documents.observations where fk_document between 11801 and 12378; -- but check this
delete from documents.signed_off where fk_document between 11801 and 12378; -- 102  rows, but check this
update clerical.task_components  set fk_staff_allocated = 6 where fk_staff_allocated = 0;
update clin_measurements.inr_dose_management set fk_observation = 436919 where  pk=4; -- BRIAN CLAXTon's record missing a link
delete from clin_mentalhealth.Team_Care_Members where fk_plan < 9;
delete from clin_mentalhealth.mentalhealth_plan where pk <9;
delete from clin_mentalhealth.k10_results where fk_plan <9;
Update clin_recalls.recalls set fk_reason = 2 where pk=1 or pk=41; -- keeps two valid recalls
delete from clin_recalls.recalls where fk_reason > 130;
Delete from clin_procedures.link_images_procedures;
Delete from clin_procedures.lu_last_surgical_pack;
Delete from clin_procedures.skin_procedures;
delete from contacts.data_employees where pk=327 or pk=28  or pk=354 or pk=132 or pk=622 or pk=278 or pk=323 or pk=321;
delete from blobs.images where fk_consult = 778 or  fk_consult = 1752 or fk_consult = 1745 or fk_consult = 1750 or fk_consult = 1754 or fk_consult = 1755 or fk_consult = 1759 or fk_consult = 1795 or fk_consult = 1797;
delete from clin_mentalhealth.mentalhealth_plan where fk_consult = 1769 or fk_consult=1770;
delete from clin_mentalhealth.mentalhealth_plan where fk_progressnote = 254 or fk_progressnote = 381 or fk_progressnote = 450 or fk_progressnote = 496 or fk_progressnote = 529;
update clin_consult.consult set fk_type = 11 where fk_type = 18; -- fix recalls not in audit trail
delete from clin_measurements.measurements where fk_consult between 26 and 1803;
delete from clin_consult.progressnotes where fk_consult between 26 and 1803; -- only 4 rows
delete from  clin_prescribing.prescribed where fk_medication = 3722;
delete from clin_prescribing.medications where fk_generic_product = 'b791e50b-0e08-47ad-bf0d-49cb477a9bc8';

