-- changes to drugs schema as required by new PBS formats

alter table drugs.product add column old_original_pbs_name text;
update drugs.product set old_original_pbs_name=original_pbs_name;
update drugs.product set original_pbs_name=null;

alter table drugs.product add column sct text constraint sct_is_numeric check (sct ~ '^[0-9]+$');
alter table drugs.brand add column sct text constraint sct_is_numeric check (sct ~ '^[0-9]+$');

-- sort out multiple naloxones

delete from drugs.brand where pk='fd494c3c-c4e2-446e-9b5f-3430baf5c23c';

update drugs.product set strength='400mcg', original_pbs_name='naloxone hydrochloride 400 microgram/mL injection, 1 x 1 mL syringe',original_pbs_fs=null,
old_original_pbs_name=null,units_per_pack=1,pack_size=1,amount=1.0,amount_unit=26,fk_form=22,sct='259441000144102' where pk='d0f71da1-61ad-4dad-995b-5b0912659738';

update drugs.product set strength='550mg' where pk='23b37c6c-924b-4e29-8c42-45fb02b9ed61'; -- fix unit

insert into drugs.product (pk,sct,atccode,generic,fk_form,strength,original_pbs_name,fk_schedule,pack_size,amount,amount_unit,units_per_pack) values
('2a3d6444-065a-4bd9-ad21-d5a9df8cf9c0','26538011000036109','M01AE02','naproxen',35,'25mg/ml','naproxen 125 mg/5 mL oral liquid, 474 mL',4,1,474,26,1);
insert into drugs.product (pk,sct,atccode,generic,fk_form,strength,original_pbs_name,fk_schedule,pack_size,amount,amount_unit,units_per_pack) values
('cf859c07-fbed-4d5f-b504-c144a759c6f9','259721000144100','B01AX06','rivaroxaban',59,'15mg','rivaroxaban 15 mg tablet, 42',4,42,null,null,1);
insert into drugs.product (pk,sct,atccode,generic,fk_form,strength,original_pbs_name,fk_schedule,pack_size,amount,amount_unit,units_per_pack,comment) values
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
insert into drugs.product (pk,atccode,sct,generic,fk_form,strength,original_pbs_name,fk_schedule,pack_size,amount,amount_unit,units_per_pack,comment) values
('a293e28a-11e5-4d78-a3fb-27282a59d68f','M05BB02','26692011000036107','risendronate sodium;calcium carbonate',59,'35mg-400mg','risedronate sodium 35 mg tablet [4 tablets] (&) calcium (as carbonate) 500 mg tablet [24 tablets], 28',4,1,null,null,28,'as 4 tablets risendronate and 24 calcium');

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 251);