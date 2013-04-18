-- changes to drugs schema as required by new PBS formats

alter table drugs.product add column old_original_pbs_name text;
update drugs.product set old_original_pbs_name=original_pbs_name;
update drugs.product set original_pbs_name=null;

alter table drugs.product add column sct text constraint sct_is_numeric check (sct ~ '^[0-9]+$');
alter table drugs.brand add column sct text constraint sct_is_numeric check (sct ~ '^[0-9]+$');
alter table drugs.brand add column "current" boolean not null default 't';


-- fentanyl patches
update clin_prescribing.medications set fk_generic_product='1c125908-31d4-42e5-9d6f-c01e8e020aed' where fk_generic_product='1a95ee44-516c-439e-9777-1818ea060c3d' or fk_generic_product='4d6f93c3-e30d-4d47-9cea-6704601067ce';
update clin_prescribing.medications set fk_generic_product='052a31ae-9b7a-49ed-a058-857387214841' where fk_generic_product='03c7b331-fb4b-48c2-8932-08270ec986da';


-- sort out multiple naloxones


update drugs.product set strength='400mcg', original_pbs_name='naloxone hydrochloride 400 microgram/mL injection, 1 x 1 mL syringe',original_pbs_fs=null,
old_original_pbs_name=null,units_per_pack=1,pack_size=1,amount=1.0,amount_unit=26,fk_form=22,sct='259441000144102' where pk='d0f71da1-61ad-4dad-995b-5b0912659738';


-- too many phenoxybenzamines

update clin_prescribing.prescribed set fk_brand='4f83a657-76fd-435e-a53d-9a400a9b9ea0' where 
     fk_brand='8f878a7d-bac3-4f03-a7bb-860d4b6030ef' or fk_brand='6e692919-2d5e-485a-b2fd-c39fee03dae6';


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



update clin_prescribing.medications set fk_generic_product='08464091-46f3-4f8e-926b-b29df46bc652' where fk_generic_product='6812260e-c377-4378-84d3-8f1880191ec6';
update clin_prescribing.prescribed set fk_brand = '368bff97-032e-4c52-84f3-38f6a5f9938f' where fk_brand = '9b5af915-5bf2-4f5c-8d7f-17963353c978';

update clin_prescribing.medications set fk_generic_product='7d32b887-48a0-480d-8b07-a77667b21b63' from clin_prescribing.prescribed where prescribed.fk_medication = medications.pk and prescribed.fk_brand='f465c187-5220-4cf3-a6ba-2afd0b88d71b';
update clin_prescribing.prescribed set fk_brand = 'f456ef25-1418-4821-bea9-19fe8097045d' where fk_brand ='f465c187-5220-4cf3-a6ba-2afd0b88d71b';

-- simponi extra brand

update clin_prescribing.medications set fk_generic_product='989c2d00-b5a0-51af-a4d5-a3dbba2b4b12' from clin_prescribing.prescribed where prescribed.fk_medication = medications.pk and prescribed.fk_brand='50b808db-91d0-436f-90d3-0737cfffde2a';
update clin_prescribing.prescribed set fk_brand = '494ef591-389f-4159-b63f-64e641112048' where fk_brand ='50b808db-91d0-436f-90d3-0737cfffde2a';

-- fix brufens

update clin_prescribing.prescribed set fk_brand = '4342a42b-4622-4bfb-b48f-4493b0e3df63' where fk_brand='c04f8d3b-e9cd-4874-a7ce-68ceff3b6e13';
update clin_prescribing.medications set fk_generic_product='b9397ad7-bbc8-4298-ac65-130b41d71011' where fk_generic_product='5e862a38-224d-465c-9a1a-9515eb736e18';

-- fix salbutamol


-- auromir autohaler now a separate product: FINISHED

update clin_prescribing.medications set fk_generic_product='6c55488b-d1ee-4683-b262-6482bd92dda3' from clin_prescribing.prescribed where prescribed.fk_brand='f9e4273e-9231-468e-8bf9-6c83464190ac' and prescribed.fk_medication = medications.pk;





-- sulphasalazine: FINISHED
-- brand Salazopyrin

--brands Pyralin En and Salazopyrin EN

update clin_prescribing.medications set fk_generic_product='08464091-46f3-4f8e-926b-b29df46bc652' from clin_prescribing.prescribed where prescribed.fk_brand='f465c187-5220-4cf3-a6ba-2afd0b88d71b' and prescribed.fk_medication = medications.pk;

update clin_prescribing.medications set fk_generic_product='08464091-46f3-4f8e-926b-b29df46bc652' from clin_prescribing.prescribed where prescribed.fk_brand='5bf3d70d-1288-4961-b469-ff092f94d708' and prescribed.fk_medication = medications.pk;




-- with diluent is Solu-Medrol, without is Methylpred/Methylprednisolone Alphapharm


-- Qvar 50 FINISHED

-- Qvar 50 Autohaler

update clin_prescribing.medications set fk_generic_product='05d8b286-9576-4137-b3a1-46db86764e8d' from clin_prescribing.prescribed where prescribed.fk_brand='cca2040d-006a-4d77-8576-f59dcf267f41' and prescribed.fk_medication = medications.pk;

-- Qvar 100 FINISHED

-- Qvar 100 Autohaler

update clin_prescribing.medications set fk_generic_product='1b1cd924-01da-41b5-a09b-680f06358d9c' from clin_prescribing.prescribed where prescribed.fk_brand='bf8359f6-69dc-413b-8c9d-e37d2ca755b0' and prescribed.fk_medication = medications.pk;

-- Estalis sequi 50/250 : FINISHED

-- Estalis sequi 50/140

update clin_prescribing.medications set fk_generic_product='351b2943-cf44-4930-a16f-edb11cc207cd' from clin_prescribing.prescribed where prescribed.fk_brand='373e3559-8974-4655-b848-0c989c888d20' and prescribed.fk_medication = medications.pk;

-- leuprorelin: BLOWN AWAY

-- actonel
update clin_prescribing.medications set fk_generic_product='a293e28a-11e5-4d78-a3fb-27282a59d68f' from clin_prescribing.prescribed where prescribed.fk_brand='ed714fd8-8227-4205-acec-3405c1404b29' and prescribed.fk_medication = medications.pk;

update clin_prescribing.medications set fk_generic_product='a293e28a-11e5-4d78-a3fb-27282a59d68f' from clin_prescribing.prescribed where prescribed.fk_brand='e2a9d6fd-5d52-45e6-bc6e-f7bb8173cffc' and prescribed.fk_medication = medications.pk;

-- risendronate enteric-coated plain 35mg tabs: FINISHED

update clin_prescribing.medications set fk_generic_product='a72b630c-7f3d-40b7-8ab0-8019f32904ac' from clin_prescribing.prescribed where prescribed.fk_brand='5290fd08-354e-4014-9c0f-a5e9d5f4928c' and prescribed.fk_medication = medications.pk;

-- Fluvax
update clin_prescribing.medications set fk_generic_product ='07071d7c-a3dc-5c3e-869d-24b596645476' where fk_generic_product ='59336329-98b6-50f9-b0a4-61cd50407973';
update clin_prescribing.prescribed set fk_brand='6411e912-625e-4d0e-8fbc-28a6ca742323' where fk_brand='5ea6d852-5089-40f8-9c98-afb8f23875ed';

-- gosrelins: BLOWN AWAY

-- bath oils: FINISHED


update clin_prescribing.medications set fk_generic_product='62d9bd4c-72fc-4b63-8009-488a82ec478f' from clin_prescribing.prescribed where prescribed.fk_brand='c0f5ca47-a8c8-4173-96a6-3a4974078a38' and prescribed.fk_medication = medications.pk;


insert into drugs.form (pk,form,volume_amount_required) values (76,'bath oil',true);



truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 266);
