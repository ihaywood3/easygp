-- fix some historical errors, bad linkages and fix some stuff like making a 'cream' a vaginal gel like it should be.
-- must run query 0.536 first (not yet committed)
-- this first one fixes the generic in drugs.pbs for selsun sulfide which was incorrectly linked to aci-gel
insert into drugs.company (code,company,address,telephone) values ('DVA','Department of Veteran''s Affairs','GPO Box 9998 Brisbane QLD 4001','0262891133');
update drugs.pbs set fk_product = '10522888-e78e-4f39-9cbf-d3807979cfdb' where pbscode='4452H' and fk_product = '0879fb52-d7d7-4d33-84c3-216147c464d2';
-- the next one, accomin is linked to acigel vaginal generic, so link it back to 'vitamin b complex' which is what we called accomin contents.
update drugs.pbs set fk_product = '682c06a0-10d5-4a17-8160-4431db80a1cd' where pbscode='4493L' and fk_product = '0879fb52-d7d7-4d33-84c3-216147c464d2';
update drugs.product set strength ='100mcg-20mcg' where pk = '736e7403-831f-450f-aefb-7feafb848e0b'; -- fix femme-tab 100-20 (was none)
update drugs.product set strength = '2mg' where pk ='f311dd97-923e-4699-a650-31335e2455ea'; -- fix rotigotine
update drugs.product set strength = '4mg' where pk = 'c37b218f-e2a9-42ca-953d-60367b834fa2'; -- fix rotigotine
update drugs.product set strength =' 6mg' where pk = '8a1c3151-d99e-4df9-94f8-02e2bb2d8524'; -- fix rotigotine
update drugs.product set strength ='3mg/ml-300mcg/ml-100mcg/ml-3mg/ml' where pk = '89102b31-3bd7-4687-85e1-6a31d50225c5'; -- fix polytar
update drugs.product set strength ='3.125mg-450mg-45mg' where pk = 'c65e8c1e-9dd4-4c73-ac24-6fea851ececc'; -- fix microlax, microlette
update drugs.product set strength ='3.125mg-450mg-45mg' where pk = '8a290594-eddd-47fa-b8c3-2448c50520d2'; -- fix microlax, microlette
update drugs.product set generic = 'ichthammol;zinc oxide' where pk='94ec7fee-6122-48cb-a4e5-9e15764de7e8'; --remove allantoin
update drugs.product set strength ='10mg-15mg' where pk = '94ec7fee-6122-48cb-a4e5-9e15764de7e8'; -- fix strengh egoderm ointment
update drugs.product set fk_form= 80 where pk='2a69faa1-e345-4246-9c80-c3c4ab9a6bb8'; -- change topical ointment to tincture (daktarin)
update drugs.product set strength ='7.5mg-9.4mg-250mcg ' where pk = '0879fb52-d7d7-4d33-84c3-216147c464d2'; -- fix aci-gel strength
update drugs.product set fk_form= 82 where pk='0879fb52-d7d7-4d33-84c3-216147c464d2';  -- change aci-gel from a cream to a gel
update drugs.product set strength ='20mg' where pk = 'bbe37022-e133-4d0f-800c-840944e10b67'; -- fix gelofusin (was 40mg, only comes in 20mg, already in db)
update drugs.product set fk_form= 79 where pk='cba32dde-a3f8-4ea4-9a81-99ed6c12af3f';  -- make nistat cream vaginal cream as per PBS
update drugs.product set amount=30 where pk='2a69faa1-e345-4246-9c80-c3c4ab9a6bb8'; -- backend original error, fixed amount of daktarin tincture from 20 to 30ml
update drugs.product set strength = '10mg/ml' where pk ='69463d9c-1889-4036-9524-45e7c7460c36'; -- fix dilaudid-HP strength from 10mg to 10mg/ml
update drugs.product set amount = 0.4, units_per_pack=30 where pk= 'cce0e3a2-8638-4c95-9a89-213e60550c50'; -- fix celluvisc, optifresh back to unit dose vials (was in as single bottle)
update drugs.product set amount = 0.4, units_per_pack= 28 where pk= '639ec5a7-75d2-470d-9e4d-02c81ce5e6c0'; -- fix bion tears
update drugs.product set amount = 0.4, units_per_pack=30 where pk= '6de663fd-58df-4aad-8737-8a3b0fa283fa'; -- fix cellufresh tears and optifresh tears back to unit dose vials 
update drugs.product set strength = '8mg-500mg' where pk ='b8f68f4e-4826-45ec-985f-a071caaa9880'; -- fix aspalgin, exists in db but wrong asprin amount
update drugs.product set strength = '20mg/ml' where pk ='4320f71d-7841-475c-a4d0-8ea8ebee0989'; -- fix buscopan 20mg to 20mg/ml
update drugs.product set fk_form= 81 where pk='f1aa520d-23c0-4560-812d-ac7f81bbcec8'; -- methyl salycilate ointment changed to linament to match PBS
update drugs.product set strength = '125mg' where pk ='ccdf75c7-a907-4482-a501-c3ae9b2e9f12'; -- fix pyrantel from 126 to 125mg
update drugs.product set strength = '10mg/ml' where pk ='ad155e29-7dda-4535-80f6-78e35fc4634b'; -- fix triamcilalone strength  to a per/ml basis
update drugs.product set strength = '100mg/ml' where pk ='5e896472-48b3-489e-b8c2-9a7eba4e2dba'; -- fix zylocaine to 100mg/ml instead of 100mg
update drugs.product set strength = '7.5mg' where pk = '9433d4fb-eebf-4a5a-861a-f6472a70574e'; -- fix lucrin depot 7.5mg
update drugs.product set strength = '22.5mg' where pk = 'a81ba14e-13c2-4b30-bff4-88f0f2cbd056'; -- fix lucrin depot 22.5
update drugs.product set strength = '30mg' where pk = '12e3366a-8baa-4a1c-aa21-67ae45c5daee'; -- fix lucrin depot 30mg
update drugs.product set strength = '30mg' where pk ='b549f3b7-14fc-4133-b9d1-991ada8f88ce'; -- fix eligard 4 months
update drugs.product set strength = '45mg' where pk = '19e94c9c-dc16-4e5b-8184-3ec50037fded'; -- lucrin depot 45mg
update drugs.product set fk_form=79 where pk='771f99a3-7ee0-4257-8d1c-6355af88c4b6'; -- 'changed from cream - link to vaginal cream 
update drugs.product set fk_form=79 where pk='56477957-f4c6-426f-8ebc-b440549d57df'; -- 'changed from cream - link to vaginal cream
update drugs.product set amount=30 where pk='8440d008-a3ed-4eb8-a6b6-befacc65cf49'; -- fixed wrong predmix, redipred quantity
update drugs.product set fk_form= 57 where pk='5aaf62f3-4bc6-4c75-9622-3de05a433334'; -- Anusol suppository listed as a tablet, changed to suppository
update drugs.product set strength = '15mg-500mg' where pk = 'aa221ba0-45a8-4f6f-ab89-3bb4b2384aa4'; -- fixed long standing error of only 100mg codeine instead of 500mg
update drugs.product set strength = '20mg/ml' where pk = '43e59f04-b02d-481e-a7e1-c021ff7d406f'; -- fix iron sucrose
update drugs.product set strength = '100mg' where pk ='07096497-d5c4-4cb0-9579-c8dad193ad20'; -- fix colifoam
update drugs.product set fk_form= 63 where pk='dabd1a38-1c1b-4ff4-8266-6060ccfb06fe'; -- wart kill duofilm in as oral liquid instead of topical solution
update drugs.product set fk_form= 61 where pk='d785fc73-b0b5-4acd-addf-5678eaeec28c';  -- fix Lamasil dermgel from topical ointment to a topical gel
update drugs.product set strength = '160mcg' where pk = 'ac0dbdcf-503e-4703-93b8-b4620fa9ff38'; --  fix alvesco from 100mcg to 160mcg
update drugs.product set strength = '35mg-500mg' where pk = 'a293e28a-11e5-4d78-a3fb-27282a59d68f'; --  'fix acris combi or actonel combi
update drugs.product set fk_form=62 where pk='73c79285-0805-4923-97c3-64a2683f6736'; -- 'fix dactarin oral powder to topical powder
update drugs.product set strength = '1mg-5mg' where pk ='32c3eca0-b077-4ed5-8dba-8ffbe3fcd1fc'; -- Femostin Conti (was 1mg-28mg which is wrong)
update drugs.product set strength = '1mg/ml' where pk ='e62babf5-6f71-4305-8a65-15b475b20e80'; -- fix clonazepam strengh to 1mg/ml
update drugs.product set strength = '5mg/ml' where pk ='e8f11a4f-ba81-4887-be12-b60d8a61e7e5'; -- fixed strengh metronidazole to 5mg/ml instead of 5mg
update drugs.product set strength = '40mg/ml' where pk ='335ff15a-a437-4aa4-a90a-e576b1a1b645'; -- fix methylprednisolone injection to 40mg/ml instead of just 40mg
update drugs.product set fk_form = 35 where pk= 'f6aa81ed-56d5-488a-ae2d-7f48e24aca32'; --'MCT oil listed as lotion instead of an oral liquid.
update drugs.product set fk_form = 35 where pk= 'efa12f27-f217-4787-9a13-7318ab2b190b';  --'"hydromorphone hydrochloride" listed as topical solution instead of an oral liquid.
update drugs.product set strength = '3mg/ml' where pk ='dc5e029e-15cc-40e9-9d66-aba9a6a43a18'; -- update pamisol from 3mg to 3mg/ml
update drugs.product set strength = '9.5mg' where pk= 'b152b520-13d5-447f-bd7d-3c973fe332d1'; -- fix rivastigmine
update drugs.product set units_per_pack= 28 where pk= '03ca7275-4784-4344-ab0e-d4ac960dbba6'; -- systane missing units per pack
update drugs.product set strength ='20g' where pk = 'bbe37022-e133-4d0f-800c-840944e10b67';  -- gelofusine was 20mg should be 20g
update drugs.product set fk_form= 61 where pk='80b60345-3af3-420e-bf03-93e86903e6d1';  -- Sandrena in as an ointment not a topical gel (fixed)
update drugs.product set strength ='3mg/ml' where pk = '8d7eb6b5-d6da-48bc-b4af-d2be2a10ea85'; --pamidronate disodium strength changed from 3mg to 3mg/ml
update drugs.product set strength ='6mg/ml' where pk = '8bbef916-4fe8-466e-ba5a-b2c606197c79';--pamidronate disodium strength changed from 6mg to 6mg/ml
update drugs.product set fk_form= 9 where pk='7f3eb5f4-102f-487a-b30f-4fae2c758448'; -- fix waxol was a lotion, now back to ear drops
-- fix xylocaine viscous, I checked, there are no others in drugs.product using this strength.
update drugs.product set generic = 'lignocaine hydrochloride'  where pk= '2c9acf1f-5c9b-433c-97e3-aa1a33b11e73';
update drugs.product set fk_form = 35 where   pk= '2c9acf1f-5c9b-433c-97e3-aa1a33b11e73'; -- 'make this a oral liquid
update drugs.product set strength = '20mg/ml' where pk= '2c9acf1f-5c9b-433c-97e3-aa1a33b11e73'; -- remove the other component which is not in the PI and confuses drug update
update drugs.product set amount = 18 where pk= '9f9871ac-b0c8-4016-9ac5-0ec71736feab'; -- fix logitech nasal spray quantity
update drugs.product set strength ='15mcg/ml' where pk = '00d072da-732d-4b9a-9e90-a20b975af1da'; -- taluprost 0.0015%/ml was in at 1.5mg/ml instsead of 15mcg/ml
update drugs.product set generic = 'coal tar;phenol;sulfur' where pk='38968c64-7fab-45d5-bfc0-5131dd999800'; -- EGOPSORYL-TA re-ordered generics to match script, dropped non existant generic
update drugs.product set strength ='50mg/g-5mg/g-5mg/g' where pk = '38968c64-7fab-45d5-bfc0-5131dd999800'; -- EGOPSORYL-TA fix strength
-- hamilton skin therapy wash
update drugs.product set generic = 'paraffin;cocoamphodiacetate disodium' where pk='c603283e-2e11-489d-8fa0-3f12f6c3c992'; -- rename generic from hand cream to its proper generic
update drugs.product set strength ='35mg/ml-30mg/ml' where pk = 'c603283e-2e11-489d-8fa0-3f12f6c3c992'; -- add the strength of generics for  hamilton skin therapy wash
update drugs.product set amount = 500 where pk= 'c603283e-2e11-489d-8fa0-3f12f6c3c992'; -- add amount for hamilton skin therapy wash
update drugs.product set amount_unit = 26 where pk = 'c603283e-2e11-489d-8fa0-3f12f6c3c992'; -- add amount_Unit for hamilton skin therapy wash
update drugs.product set strength ='9mg/ml' where pk = 'dcb0b3c5-90ec-417c-8b33-1391b15c80b9';  -- fix strengh from 9mg to 9mg/ml disodium pamidronate
update drugs.product set strength ='10mg/ml' where pk = '8fe83682-fc4a-46e6-a7c5-1df5b1c5f0a4';  -- fix strengh apopine from 10mg to 10mg/ml
update drugs.product set units_per_pack=1 where pk='b75c18da-2094-43ba-9032-8f23c3e6fba2';

update db.lu_version set lu_minor = 537;