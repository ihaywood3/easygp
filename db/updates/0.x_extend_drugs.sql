-- changes to drugs schema as required by new PBS formats

alter table drugs.product add column old_original_pbs_name text;
update drugs.product set old_original_pbs_name=original_pbs_name;
update drugs.product set original_pbs_name=null;

alter table drugs.product add column sct text constraint sct_is_numeric check (sct ~ '^[0-9]+$');
alter table drugs.brand add column sct text constraint sct_is_numeric check (sct ~ '^[0-9]+$');
alter table drugs.brand add column "current" boolean not null default 't';

-- sort out multiple naloxones

delete from drugs.brand where pk='fd494c3c-c4e2-446e-9b5f-3430baf5c23c';

update drugs.product set strength='400mcg', original_pbs_name='naloxone hydrochloride 400 microgram/mL injection, 1 x 1 mL syringe',original_pbs_fs=null,
old_original_pbs_name=null,units_per_pack=1,pack_size=1,amount=1.0,amount_unit=26,fk_form=22,sct='259441000144102' where pk='d0f71da1-61ad-4dad-995b-5b0912659738';

update drugs.product set strength='550mg' where pk='23b37c6c-924b-4e29-8c42-45fb02b9ed61'; -- fix unit

insert into drugs.product (pk,sct,atccode,generic,fk_form,strength,original_pbs_name,fk_schedule,pack_size,amount,amount_unit,units_per_pack) values
('2a3d6444-065a-4bd9-ad21-d5a9df8cf9c0','26538011000036109','M01AE02','naproxen',35,'25mg/ml','naproxen 125 mg/5 mL oral liquid, 474 mL',4,1,474,26,1);
insert into drugs.product (pk,sct,atccode,generic,fk_form,strength,original_pbs_name,fk_schedule,pack_size,amount,amount_unit,units_per_pack) values
('cf859c07-fbed-4d5f-b504-c144a759c6f9','259721000144100','B01AX06','rivaroxaban',59,'15mg','rivaroxaban 15 mg tablet, 42',4,42,null,null,1);
insert into drugs.product (pk,sct,atccode,generic,fk_form,strength,original_pbs_name,fk_schedule,pack_size,amount,amount_unit,units_per_pack,free_comment) values
('91ddec23-98c3-43a0-8480-671e21d04319','259881000144108','S01XA20','paraffin;retinyl palmitate',1,'1g/g-138mcg/g','paraffin + retinyl palmitate 138 microgram/g (equivalent to 250 units/g vitamin A) eye ointment, 5 g',4,1,5.0,35,1,'equivalent to 250unit/g vitamin A');
insert into drugs.product (pk,atccode,sct,generic,fk_form,strength,original_pbs_name,fk_schedule,pack_size,amount,amount_unit,units_per_pack) values
('3b4e15b5-cb6f-4656-aa3b-8dc7acba32f6','S01LA05','258741000144104','aflibercept',22,'4mg','aflibercept 4 mg/0.1 mL injection, 1 x 0.1 mL vial',4,1,0.1,26,1);
insert into drugs.product (pk,atccode,sct,generic,fk_form,strength,original_pbs_name,fk_schedule,pack_size,amount,amount_unit,units_per_pack) values
('69b44482-b4bc-427b-a45f-06282d79f6c8','S01XA20','258861000144107','sodium hyaluronate',13,'2mg/ml','sodium hyaluronate 0.2% (2 mg/mL) eye drops, 10 mL',4,1,10,26,1);
insert into drugs.product (pk,atccode,sct,generic,fk_form,strength,original_pbs_name,fk_schedule,pack_size,amount,amount_unit,units_per_pack) values
('6617900f-a007-4e46-88a9-75be5dfb0244','S01XA20','258841000144106','sodium hyaluronate',13,'1mg/ml','sodium hyaluronate 0.1% (1 mg/mL) eye drops, 10 mL',4,1,10,26,1);
insert into drugs.product (pk,atccode,sct,generic,fk_form,strength,original_pbs_name,fk_schedule,pack_size,amount,amount_unit,units_per_pack) values
('477a0884-ec98-4636-9ea6-4aa22da49ba0','L01XE11','925423011000036105','pazopanib',59,'400mg','pazopanib 400 mg tablet, 30',4,30,null,null,1);
insert into drugs.product (pk,atccode,sct,generic,fk_form,strength,original_pbs_name,fk_schedule,pack_size,amount,amount_unit,units_per_pack) values
('f60c7be2-fa11-41f9-9cc9-4ad7b2b92397','L01XE11','925425011000036106','pazopanib',59,'200mg','pazopanib 200 mg tablet, 30',4,30,null,null,1);
insert into drugs.product (pk,atccode,sct,generic,fk_form,strength,original_pbs_name,fk_schedule,pack_size,amount,amount_unit,units_per_pack) values
('c2df6989-a013-4bb5-995b-30e2035c8bb3','C07AB03','258311000144104','atenolol',35,'5mg/ml','atenolol 50 mg/10 mL oral liquid, 300 mL',4,1,300,26,1);
insert into drugs.product (pk,atccode,sct,generic,fk_form,strength,original_pbs_name,fk_schedule,pack_size,amount,amount_unit,units_per_pack) values
('3fdc6df4-ee0f-4427-b4bc-6928cca13296','B01AX06','259741000144107','rivaroxaban',59,'20mg','rivaroxaban 20 mg tablet, 28',4,28,null,null,1);
insert into drugs.product (pk,atccode,sct,generic,fk_form,strength,original_pbs_name,fk_schedule,pack_size,amount,amount_unit,units_per_pack,free_comment) values
('a293e28a-11e5-4d78-a3fb-27282a59d68f','M05BB02','26692011000036107','risendronate sodium;calcium carbonate',59,'35mg-400mg','risedronate sodium 35 mg tablet [4 tablets] (&) calcium (as carbonate) 500 mg tablet [24 tablets], 28',4,1,null,null,28,'as 4 tablets risendronate and 24 calcium');

\i updates/2012-dec-new-pbs.sql


-- too many phenoxybenzamines
delete from drugs.brand where pk='8f878a7d-bac3-4f03-a7bb-860d4b6030ef';
delete from drugs.brand where pk='6e692919-2d5e-485a-b2fd-c39fee03dae6';
update clin_prescribing.prescribed set fk_brand='4f83a657-76fd-435e-a53d-9a400a9b9ea0' where 
     fk_brand='8f878a7d-bac3-4f03-a7bb-860d4b6030ef' or fk_brand='6e692919-2d5e-485a-b2fd-c39fee03dae6';

delete from drugs.product where pk='b49207d1-c119-456d-aff8-7c03ecf256f6';
update clin_prescribing.medications set fk_generic_product = 'b6e5797c-2eb0-4cc8-b0d5-4f402842d2f4' where fk_generic_product='b49207d1-c119-456d-aff8-7c03ecf256f6';

-- fix doxycycline
update clin_prescribing.medications set fk_generic_product = 'ac358441-825e-496f-bba5-e48b66748a12' where fk_generic_product='0f112169-2924-459d-a4e4-a2d013ecf022';
 update clin_prescribing.prescribed set fk_brand='96c2f0ac-917b-44a7-ad23-d9763fb4e08e' where fk_brand='d586db1f-d97d-4383-b27c-3dce40cbf931';
 update clin_prescribing.prescribed set fk_brand='4f614cc2-874e-401a-a607-75fb5cff6d48' where fk_brand='abbfa69d-330a-4a34-9c1e-4cb8a10c8512';
 update clin_prescribing.prescribed set fk_brand='da945135-c18e-4d2b-8046-d35953844448' where fk_brand='4974a44f-99ea-4c64-9b6c-d34bbb6f630f';
 update clin_prescribing.prescribed set fk_brand='ca380316-e323-4d0b-8ee9-4b467d5b4b37' where fk_brand='53f64466-e1d8-4d01-a7d9-e0434b756dd1';
 update clin_prescribing.prescribed set fk_brand='322b41e7-aca5-4f2b-aecc-bb99ff704bc5' where fk_brand='e7cc77b2-6e22-4130-a3c8-b124d3110d3d';
 update clin_prescribing.prescribed set fk_brand='c1399747-a208-4f35-93e2-50db5f295582' where fk_brand='800ec8be-6ce9-4366-8dea-e64f72569f75';
 update clin_prescribing.prescribed set fk_brand='c467e532-d329-484a-87df-48c4da134a59' where fk_brand='e6243c76-c56d-4bed-a2a2-e37c2ff99996';
delete from drugs.brand where fk_product='0f112169-2924-459d-a4e4-a2d013ecf022';
delete from drugs.product where pk='0f112169-2924-459d-a4e4-a2d013ecf022';
update drugs.product set pack_size=21,sct='33813011000036104' where pk='ac358441-825e-496f-bba5-e48b66748a12';

-- fix famciclovir
update drugs.product set pack_size=20,sct='86450011000036106' where pk='f4eaa41d-e3b2-4a58-b07c-fe2339863070';
update drugs.product set pack_size=21,sct='27248011000036102' where pk='0c0a42ae-6441-4e28-a472-e88e886bc75d';

-- fix eliqis
update drugs.product set pack_size=30,sct='933236701000036105' where pk='2f236cdc-d46b-4de1-9bb4-d1c511106d74';
update drugs.product set pack_size=60,sct='933236721000036100' where pk='77fb2ede-04a0-4283-be87-d679f3c790a8';


-- fic valaciclovir
update drugs.product set pack_size=10,sct='27731011000036102',original_pbs_name='valaciclovir 500 mg tablet, 10' where pk='cd5f2daa-b19e-4e8a-a930-9c2388023a6f';
update drugs.product set pack_size=100,sct='27732011000036108' where pk='88737924-88be-4987-a197-b9bd1f13064c';
update drugs.product set pack_size=42,sct='27734011000036104' where pk='bd3fadbd-f196-48a9-885e-12a7a2a31b9f';
update drugs.product set pack_size=30,sct='27733011000036101' where pk='ec8a3dec-d916-4236-9b77-3a64ca822a04';

-- fix salphasalazine
update drugs.product set free_comment='enteric-coated' where pk='6812260e-c377-4378-84d3-8f1880191ec6';
insert into drugs.product (pk,generic,fk_form,strength,free_comment,sct,original_pbs_name,pack_size,atccode,amount,amount_unit,units_per_pack) values
('7d32b887-48a0-480d-8b07-a77667b21b63','sulfasalazine',59,'500mg','','27402011000036108',$$sulfasalazine 500 mg tablet, 100$$,100,'A07EC01',NULL,NULL,1);

-- fix salbutamol

update drugs.product set sct='27601011000036100',free_comment='pressurised device' where pk='4081e0e2-5379-4298-a628-bdff9eb1d348';
-- auromir autohaler now a separate product: FINISHED
insert into drugs.product (pk,generic,fk_form,strength,free_comment,sct,original_pbs_name,pack_size,atccode,amount,amount_unit,units_per_pack) values
('6c55488b-d1ee-4683-b262-6482bd92dda3','salbutamol sulfate',46,'100mcg','breath-actuated device','30361000144109',$$salbutamol Oral pressurised inhalation in breath actuated device 100 micrograms (base) per dose (200 doses), CFC-free formulation, 1$$,1,'R03AC02',200.0,56,1);
update drugs.brand set fk_product='6c55488b-d1ee-4683-b262-6482bd92dda3'  where pk='f9e4273e-9231-468e-8bf9-6c83464190ac';
update clin_prescribing.medications set fk_generic_product='6c55488b-d1ee-4683-b262-6482bd92dda3' from clin_prescribing.prescribed where prescribed.fk_brand='f9e4273e-9231-468e-8bf9-6c83464190ac' and prescribed.fk_medication = medications.pk;

update drugs.product set generic='amino acid synthetic formula supplemented with long chain polyunsaturated fatty acids' where sct='51427011000036107';
insert into drugs.product (pk,generic,fk_form,strength,free_comment,sct,original_pbs_name,pack_size,atccode,amount,amount_unit,units_per_pack) values
('40f7014a-97d6-4c72-9c7a-1c43884f19b3','amino acid synthetic formula supplemented with long chain polyunsaturated fatty acids and medium chain triglycerides',36,'400g','','927290011000036108',$$amino acid synthetic formula supplemented with long chain polyunsaturated fatty acids and medium chain triglycerides oral liquid: powder for, 400 g$$,1,'V06DB',NULL,NULL,1);

-- etanercept: only one brand: FINISHED
update drugs.product set sct='53301000144102' where pk='ed23fb8e-551a-4e23-9a6f-c6873b9ff13a';
insert into drugs.product (pk,generic,fk_form,strength,free_comment,sct,original_pbs_name,pack_size,atccode,amount,amount_unit,units_per_pack) values
('32dcf1ea-0952-4fd3-83c8-d917058cf488','etanercept',58,'50mg','auto-injector','53261000144107',$$ETANERCEPT Injection 50 mg in 1 mL single use auto-injector, 4, 1$$,1,'L04AB01',1.0,26,4);

-- sulphasalazine: FINISHED
-- brand Salazopyrin
update drugs.product set sct='27402011000036108',original_pbs_name='sulfasalazine 500 mg tablet, 100',free_comment='' where pk='6812260e-c377-4378-84d3-8f1880191ec6';
--brands Pyralin En and Salazopyrin EN
insert into drugs.product (pk,generic,fk_form,strength,free_comment,sct,original_pbs_name,pack_size,atccode,amount,amount_unit,units_per_pack) values
('08464091-46f3-4f8e-926b-b29df46bc652','sulfasalazine',59,'500mg','enteric-coated','31301000144102',$$SULFASALAZINE Tablet 500 mg (enteric coated), 100$$,100,'A07EC01',NULL,NULL,1);
update drugs.brand set fk_product='08464091-46f3-4f8e-926b-b29df46bc652' where pk='f465c187-5220-4cf3-a6ba-2afd0b88d71b';
update clin_prescribing.medications set fk_generic_product='08464091-46f3-4f8e-926b-b29df46bc652' from clin_prescribing.prescribed where prescribed.fk_brand='f465c187-5220-4cf3-a6ba-2afd0b88d71b' and prescribed.fk_medication = medications.pk;
update drugs.brand set fk_product='08464091-46f3-4f8e-926b-b29df46bc652' where pk='5bf3d70d-1288-4961-b469-ff092f94d708';
update clin_prescribing.medications set fk_generic_product='08464091-46f3-4f8e-926b-b29df46bc652' from clin_prescribing.prescribed where prescribed.fk_brand='5bf3d70d-1288-4961-b469-ff092f94d708' and prescribed.fk_medication = medications.pk;


insert into drugs.product (pk,generic,fk_form,strength,free_comment,sct,original_pbs_name,pack_size,atccode,amount,amount_unit,units_per_pack) values
('65236ba0-69af-4c8c-a544-f0f258c083a8','milk powder-lactose free predigested formula',36,'900g','','51255011000036100',$$milk powder lactose free formula predigested oral liquid: powder for, 900 g$$,1,'V06DF',NULL,NULL,1);

-- with diluent is Solu-Medrol, without is Methylpred/Methylprednisolone Alphapharm
insert into drugs.product (pk,generic,fk_form,strength,free_comment,sct,original_pbs_name,pack_size,atccode,amount,amount_unit,units_per_pack) values
('57196726-0370-4827-8f74-253d3b3fa539','methylprednisolone',22,'40mg','with diluent','26759011000036103',$$methylprednisolone 40 mg injection [5 x 40 mg vials] (&) inert substance diluent [5 x 1 mL vials], 1 pack$$,5,'H02AB04',NULL,NULL,1);
insert into drugs.product (pk,generic,fk_form,strength,free_comment,sct,original_pbs_name,pack_size,atccode,amount,amount_unit,units_per_pack) values
('f0d6c1fe-0b8a-45df-90d8-8498256771db','methylprednisolone',22,'1g','with diluent','26758011000036106',$$methylprednisolone 1 g injection [1 x 1 g vial] (&) inert substance diluent [1 x 16 mL vial], 1 pack$$,1,'H02AB04',NULL,NULL,1);

-- Qvar 50 FINISHED
update drugs.product set sct='27701011000036109',free_comment='pressurised device',original_pbs_name=$$beclomethasone dipropionate 50 microgram/actuation inhalation: pressurised, 200 actuations$$ where pk='51d3317e-076d-4491-b4d7-0249f1ff252e';
-- Qvar 50 Autohaler
insert into drugs.product (pk,generic,fk_form,strength,free_comment,sct,original_pbs_name,pack_size,atccode,amount,amount_unit,units_per_pack) values
('05d8b286-9576-4137-b3a1-46db86764e8d','beclomethasone dipropionate',46,'50mcg','breath-actuated device','16091000144106',$$BECLOMETHASONE DIPROPIONATE Oral pressurised inhalation in breath actuated device 50 micrograms per dose (200 doses), CFC-free formulation, 1$$,1,'R03BA01',200.0,56,1);
update drugs.brand set fk_product='05d8b286-9576-4137-b3a1-46db86764e8d' where pk='cca2040d-006a-4d77-8576-f59dcf267f41';
update clin_prescribing.medications set fk_generic_product='05d8b286-9576-4137-b3a1-46db86764e8d' from clin_prescribing.prescribed where prescribed.fk_brand='cca2040d-006a-4d77-8576-f59dcf267f41' and prescribed.fk_medication = medications.pk;

-- Qvar 100 FINISHED
update drugs.product set sct='27702011000036103',free_comment='pressurised device',original_pbs_name=$$beclomethasone dipropionate 100 microgram/actuation inhalation: pressurised, 200 actuations$$ where pk='3c1e79ae-0c74-444e-9a17-a2d8648b24a3';
-- Qvar 100 Autohaler
insert into drugs.product (pk,generic,fk_form,strength,free_comment,sct,original_pbs_name,pack_size,atccode,amount,amount_unit,units_per_pack) values
('1b1cd924-01da-41b5-a09b-680f06358d9c','beclomethasone dipropionate',46,'100mcg','breath-actuated device','16061000144100',$$BECLOMETHASONE DIPROPIONATE Oral pressurised inhalation in breath actuated device 100 micrograms per dose (200 doses), CFC-free formulation, 1$$,1,'R03BA01',200.0,56,1);
update drugs.brand set fk_product='1b1cd924-01da-41b5-a09b-680f06358d9c' where pk='bf8359f6-69dc-413b-8c9d-e37d2ca755b0';
update clin_prescribing.medications set fk_generic_product='1b1cd924-01da-41b5-a09b-680f06358d9c' from clin_prescribing.prescribed where prescribed.fk_brand='bf8359f6-69dc-413b-8c9d-e37d2ca755b0' and prescribed.fk_medication = medications.pk;

-- Estalis sequi 50/250 : FINISHED
update drugs.product set generic='oestradiol;norethisterone',strength='50mcg-250mcg',free_comment='4 patches oestradiol, 4 patches oestradiol and norethisterone acetate',units_per_pack=8 where pk='3506a9e7-3bf3-4e0b-ac5c-65a7baee28a2';
-- Estalis sequi 50/140
insert into drugs.product (pk,generic,fk_form,strength,free_comment,sct,original_pbs_name,pack_size,atccode,amount,amount_unit,units_per_pack) values
('351b2943-cf44-4930-a16f-edb11cc207cd','oestradiol;norethisterone',39,'50mcg-140mcg','4 patches oestradiol, 4 patches oestradiol and norethisterone acetate','27681011000036101',$$oestradiol 50 microgram/24 hours patch [4 patches] (&) oestradiol 50 microgram/24 hours + norethisterone acetate 140 microgram/24 hours patch [4 patches], 8$$,1,'G03FB05',NULL,NULL,8);
update drugs.brand set fk_product='351b2943-cf44-4930-a16f-edb11cc207cd' where pk='373e3559-8974-4655-b848-0c989c888d20';
update clin_prescribing.medications set fk_generic_product='351b2943-cf44-4930-a16f-edb11cc207cd' from clin_prescribing.prescribed where prescribed.fk_brand='373e3559-8974-4655-b848-0c989c888d20' and prescribed.fk_medication = medications.pk;

-- leuprorelin

insert into drugs.product (pk,generic,fk_form,strength,free_comment,sct,original_pbs_name,pack_size,atccode,amount,amount_unit,units_per_pack) values
('b4897e11-9ba2-4143-bb50-b2b08ef21120','leuprorelin acetate',22,'7.5mg','','932927011000036104',$$leuprorelin acetate 7.5 mg injection: modified release [1 syringe] (&) inert substance diluent [1 syringe], 1 pack$$,1,'L02AE02',NULL,NULL,1);

insert into drugs.product (pk,generic,fk_form,strength,free_comment,sct,original_pbs_name,pack_size,atccode,amount,amount_unit,units_per_pack) values
('2dc0db6a-9190-42af-b6a0-73133d978129','leuprorelin acetate',22,'22.5mg','','932929011000036106',$$leuprorelin acetate 22.5 mg injection: modified release [1 syringe] (&) inert substance diluent [1 syringe], 1 pack$$,1,'L02AE02',NULL,NULL,1);


insert into drugs.product (pk,generic,fk_form,strength,free_comment,sct,original_pbs_name,pack_size,atccode,amount,amount_unit,units_per_pack) values
('82d04b86-c920-4211-abd2-bd3e6dc4df10','leuprorelin acetate',22,'30mg','','932931011000036109',$$leuprorelin acetate 30 mg injection: modified release [1 syringe] (&) inert substance diluent [1 syringe], 1 pack$$,1,'L02AE02',NULL,NULL,1);

-- risendronate enteric-coated pack: FINISHED
update drugs.product set free_comment='4 tablets 35mg risendronate enteric-coated, 24 tablets 500mg calcium carbonate',sct='55141000144100' where pk='b98d6d27-2971-4cc1-9e89-68734e01f960';
-- risendronate NOT enteric-coated pack: FINISHED
insert into drugs.product (pk,generic,fk_form,strength,free_comment,sct,original_pbs_name,pack_size,atccode,amount,amount_unit,units_per_pack) values
('7502b034-0237-4003-91ad-5d0a10366193','risedronate sodium and calcium carbonate',39,'None','4 tablets 35mg risendronate, 24 tablets 500mg calcium carbonate','26692011000036107',$$risedronate sodium 35 mg tablet [4 tablets] (&) calcium (as carbonate) 500 mg tablet [24 tablets], 28$$,1,'M05BB02',NULL,NULL,28);
update drugs.brand set fk_product='7502b034-0237-4003-91ad-5d0a10366193' where pk='ed714fd8-8227-4205-acec-3405c1404b29';
update clin_prescribing.medications set fk_generic_product='7502b034-0237-4003-91ad-5d0a10366193' from clin_prescribing.prescribed where prescribed.fk_brand='ed714fd8-8227-4205-acec-3405c1404b29' and prescribed.fk_medication = medications.pk;
update drugs.brand set fk_product='7502b034-0237-4003-91ad-5d0a10366193' where pk='e2a9d6fd-5d52-45e6-bc6e-f7bb8173cffc';
update clin_prescribing.medications set fk_generic_product='7502b034-0237-4003-91ad-5d0a10366193' from clin_prescribing.prescribed where prescribed.fk_brand='e2a9d6fd-5d52-45e6-bc6e-f7bb8173cffc' and prescribed.fk_medication = medications.pk;

-- risendronate enteric-coated plain 35mg tabs: FINISHED
insert into drugs.product (pk,generic,fk_form,strength,free_comment,sct,original_pbs_name,pack_size,atccode,amount,amount_unit,units_per_pack) values
('a72b630c-7f3d-40b7-8ab0-8019f32904ac','risedronate sodium',59,'35mg','enteric-coated','51591000144100',$$RISEDRONATE SODIUM Tablet 35 mg (enteric coated), 4$$,4,'M05BA07',NULL,NULL,1);
update drugs.brand set fk_product='a72b630c-7f3d-40b7-8ab0-8019f32904ac' where pk='5290fd08-354e-4014-9c0f-a5e9d5f4928c';
update clin_prescribing.medications set fk_generic_product='a72b630c-7f3d-40b7-8ab0-8019f32904ac' from clin_prescribing.prescribed where prescribed.fk_brand='5290fd08-354e-4014-9c0f-a5e9d5f4928c' and prescribed.fk_medication = medications.pk;


-- gosrelins

insert into drugs.product (pk,generic,fk_form,strength,free_comment,sct,original_pbs_name,pack_size,atccode,amount,amount_unit,units_per_pack) values
('980fa0a2-ba4f-4737-acc4-20a44f09fc95','goserelin acetate and bicalutamide',39,'None','goserelin 3.6mg, 28 tablets 50mg bicalutamide ','26781011000036107',$$goserelin 3.6 mg implant [1 implant] (&) bicalutamide 50 mg tablet [28 tablets], 1 pack$$,1,'L02AE',NULL,NULL,1);
update drugs.product set free_comment='goserelin 10.8mg, 84 tablets bicalutamide' where sct='26783011000036108';


insert into drugs.product (pk,generic,fk_form,strength,free_comment,sct,original_pbs_name,pack_size,atccode,amount,amount_unit,units_per_pack) values
('52a72cc2-0ffe-4fec-9de7-03f427ca765c','goserelin acetate and bicalutamide',39,'None','goserelin 10.8mg, 28 tablets 50mg bicalutamide','26782011000036101',$$goserelin 10.8 mg implant [1 implant] (&) bicalutamide 50 mg tablet [28 tablets], 1 pack$$,1,'L02AE',NULL,NULL,1);

-- bath oils: FINISHED

insert into drugs.form (pk,form,volume_amount_required) values (76, 'bath oil', true);
update drugs.product set fk_form=76 where pk='c405b849-3280-4a0e-8104-6e00479eb639';
insert into drugs.product (pk,generic,fk_form,strength,free_comment,sct,original_pbs_name,pack_size,atccode,amount,amount_unit,units_per_pack) values
('62d9bd4c-72fc-4b63-8009-488a82ec478f','skin emollient',26,'500ml','','33331000144107',$$SKIN EMOLLIENT Lotion 500 mL, 1$$,1,'D02AX',NULL,NULL,1);
update drugs.brand set fk_product='62d9bd4c-72fc-4b63-8009-488a82ec478f' where pk='c0f5ca47-a8c8-4173-96a6-3a4974078a38';
update clin_prescribing.medications set fk_generic_product='62d9bd4c-72fc-4b63-8009-488a82ec478f' from clin_prescribing.prescribed where prescribed.fk_brand='c0f5ca47-a8c8-4173-96a6-3a4974078a38' and prescribed.fk_medication = medications.pk;


-- peginferon  2A  -- FINISHED
update drugs.product set free_comment='peginterferon alfa-2a 180mcg injection, 140 tablets ribavirin 200mg', sct='28056011000036104',original_pbs_name='peginterferon alfa-2a 180 microgram/0.5 mL injection [4 x 0.5 mL syringes] (&) ribavirin 200 mg tablet [140 tablets], 1 pack' where pk='42f58e69-50eb-406e-9083-ce46c32ee43f';
insert into drugs.product (pk,generic,fk_form,strength,free_comment,sct,original_pbs_name,pack_size,atccode,amount,amount_unit,units_per_pack) values
('74be2df3-98a6-4d7c-ba60-b7bf01a3b6ff','ribavirin and peginterferon alfa-2a',39,'None','peginferon alfa-2a 135mcg injection, 4 syringes, 168 tablets ribavirin 200mg','28053011000036105',$$peginterferon alfa-2a 135 microgram/0.5 mL injection [4 x 0.5 mL syringes] (&) ribavirin 200 mg tablet [168 tablets], 1 pack$$,1,'L03AB61',NULL,NULL,1);
insert into drugs.product (pk,generic,fk_form,strength,free_comment,sct,original_pbs_name,pack_size,atccode,amount,amount_unit,units_per_pack) values
('1a36d290-44d7-4328-b106-3bb40dad0e67','ribavirin and peginterferon alfa-2a',39,'None','peginterferon alfa-2a 180mcg infection, 4 syringes, 112 tablets ribavirin 200mg','28055011000036106',$$peginterferon alfa-2a 180 microgram/0.5 mL injection [4 x 0.5 mL syringes] (&) ribavirin 200 mg tablet [112 tablets], 1 pack$$,1,'L03AB61',NULL,NULL,1);
insert into drugs.product (pk,generic,fk_form,strength,free_comment,sct,original_pbs_name,pack_size,atccode,amount,amount_unit,units_per_pack) values
('7bb768ce-5e18-4cac-9810-fe002243dd9e','ribavirin and peginterferon alfa-2a',39,'None','peginterferon alfa-2a 180mcg infection, 4 syringes, 168 tablets ribavirin 200mg','28056011000036101',$$peginterferon alfa-2a 180 microgram/0.5 mL injection [4 x 0.5 mL syringes] (&) ribavirin 200 mg tablet [168 tablets], 1 pack$$,1,'L03AB61',NULL,NULL,1);


-- peginterferon 2 *B* FINISHED
update drugs.product set free_comment='peginterferon alfa-2b 80mcg injection, 140 tablets ribavirin 200mg',sct='28076011000036102' where pk='d3c9ef7c-c8fd-4dd0-b0d5-441689b945f7';
insert into drugs.product (pk,generic,fk_form,strength,free_comment,sct,original_pbs_name,pack_size,atccode,amount,amount_unit,units_per_pack) values
('ee148a47-5007-491b-af25-04031bd981b5','ribavirin and peginterferon alfa-2b',39,'None','peginterferon alfa-2b 50mcg infection, 4 syringes, 112 tablets ribavirin 200mg','28074011000036105',$$peginterferon alfa-2b 50 microgram injection [4 x 50 microgram cartridges] (&) ribavirin 200 mg capsule [112 capsules] (&) inert substance diluent [4 x 0.5 mL cartridges], 1 pack$$,1,'L03AB60',NULL,NULL,1);
insert into drugs.product (pk,generic,fk_form,strength,free_comment,sct,original_pbs_name,pack_size,atccode,amount,amount_unit,units_per_pack) values
('e97a702b-7d98-44e9-9990-906ce48da7d3','ribavirin and peginterferon alfa-2b',39,'None','peginterferon alfa-2b 80mcg infection, 4 syringes, 84 tablets ribavirin 200mg','28078011000036103',$$peginterferon alfa-2b 80 microgram injection [4 x 80 microgram cartridges] (&) ribavirin 200 mg capsule [84 capsules] (&) inert substance diluent [4 x 0.5 mL cartridges], 1 pack$$,1,'L03AB60',NULL,NULL,1);
insert into drugs.product (pk,generic,fk_form,strength,free_comment,sct,original_pbs_name,pack_size,atccode,amount,amount_unit,units_per_pack) values
('29973764-0224-4379-b9e7-8a91fc3eb734','ribavirin and peginterferon alfa-2b',39,'None','peginterferon alfa-2b 150mcg infection, 4 syringes, 196 tablets ribavirin 200mg','51572011000036101',$$peginterferon alfa-2b 150 microgram injection [4 x 150 microgram cartridges] (&) ribavirin 200 mg capsule [196 capsules] (&) inert substance diluent [4 x 0.5 mL cartridges], 1 pack$$,1,'L03AB60',NULL,NULL,1);
insert into drugs.product (pk,generic,fk_form,strength,free_comment,sct,original_pbs_name,pack_size,atccode,amount,amount_unit,units_per_pack) values
('65f3f0b5-4c29-4f90-8d4e-31608e1e90bc','ribavirin and peginterferon alfa-2b',39,'None','peginterferon alfa-2b 100mcg infection, 4 syringes, 112 tablets ribavirin 200mg','28079011000036106',$$peginterferon alfa-2b 100 microgram injection [4 x 100 microgram cartridges] (&) ribavirin 200 mg capsule [112 capsules] (&) inert substance diluent [4 x 0.5 mL cartridges], 1 pack$$,1,'L03AB60',NULL,NULL,1);
insert into drugs.product (pk,generic,fk_form,strength,free_comment,sct,original_pbs_name,pack_size,atccode,amount,amount_unit,units_per_pack) values
('e527e448-a943-4bf7-9ad7-fb14b46f4ffb','ribavirin and peginterferon alfa-2b',39,'None','peginterferon alfa-2b 120mcg infection, 4 syringes, 140 tablets ribavirin 200mg','28081011000036104',$$peginterferon alfa-2b 120 microgram injection [4 x 120 microgram cartridges] (&) ribavirin 200 mg capsule [140 capsules] (&) inert substance diluent [4 x 0.5 mL cartridges], 1 pack$$,1,'L03AB60',NULL,NULL,1);
insert into drugs.product (pk,generic,fk_form,strength,free_comment,sct,original_pbs_name,pack_size,atccode,amount,amount_unit,units_per_pack) values
('4852c05c-3027-4f0b-bce3-69f34d1c23e1','ribavirin and peginterferon alfa-2b',39,'None','peginterferon alfa-2b 150mcg infection, 4 syringes, 140 tablets ribavirin 200mg','28083011000036103',$$peginterferon alfa-2b 150 microgram injection [4 x 150 microgram cartridges] (&) ribavirin 200 mg capsule [140 capsules] (&) inert substance diluent [4 x 0.5 mL cartridges], 1 pack$$,1,'L03AB60',NULL,NULL,1);
insert into drugs.product (pk,generic,fk_form,strength,free_comment,sct,original_pbs_name,pack_size,atccode,amount,amount_unit,units_per_pack) values
('3643fd5d-9eb2-4709-8a8a-59bb4adceb41','ribavirin and peginterferon alfa-2b',39,'None','peginterferon alfa-2b 150mcg infection, 4 syringes, 168 tablets ribavirin 200mg','28084011000036101',$$peginterferon alfa-2b 150 microgram injection [4 x 150 microgram cartridges] (&) ribavirin 200 mg capsule [168 capsules] (&) inert substance diluent [4 x 0.5 mL cartridges], 1 pack$$,1,'L03AB60',NULL,NULL,1);



truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 251);
