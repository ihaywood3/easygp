--typhim fix
insert into drugs.product
(pk,atccode,generic,strength,fk_form,fk_schedule,pack_size,units_per_pack,amount_unit,amount,shared)
values('26211640-5fc2-4b78-b950-8128aa6f125d','J07AP03','salmonella typhi vaccine','25mcg',22,4,1,1,26,0.5,'t');
insert into drugs.brand (pk,fk_product,fk_company,brand,product_information_filename) values ('6477ec0b-3cee-4233-9235-757949699bb2','26211640-5fc2-4b78-b950-8128aa6f125d','SW',$$TYPHIM VI$$,NULL);

insert into
drugs.brand(fk_product,fk_company,brand,from_pbs,pk,product_information_filename)
values ('26211640-5fc2-4b78-b950-8128aa6f125d','GK','TYPHERIX','f','81dcca0b-8ea0-4a29-ba9e-e87eedcd575a','gwptyphv.pdf');

-- contribution from dr-richard-terry
-- date: 07/26/2012 19:40:09.662
insert into drugs.product (pk,generic,strength,fk_form,atccode,free_comment,fk_schedule,pack_size,amount_unit,amount) values ('d9e71383-6eb3-44f1-a460-5a4a0265c9b7',
$$norethisterone;ethinyloestradiol$$,$$0.5mg-1mg$$,59,'G03FB05',NULL,4,28,NULL,NULL);
insert into drugs.brand (pk,fk_product,fk_company,brand,product_information_filename) values ('c197aead-1c4d-4430-a089-81ebb687ab34','d9e71383-6eb3-44f1-a460-5a4a0265c9b7','NO',$$KLIOVANCE$$,NULL);

-- contribution from dr-richard-terry
-- date: 07/26/2012 20:03:12.805
insert into drugs.brand (pk,fk_product,fk_company,brand,product_information_filename) values ('9c837f88-b842-4c04-bb6a-91c8d4be3035','628b0f30-7a8a-45ad-abdb-d405c8f4bce9','LUP',$$ISABELLE$$,NULL);

-- contribution from dr-richard-terry
-- date: 07/26/2012 20:31:34.71
update clin_prescribing.medications set fk_generic_product='ff792cfb-b980-40da-b11d-c4c1f0e65dbe' where fk_generic_product='ae182565-9ab4-4d25-b255-936c74a40830';
update clin_prescribing.prescribed set fk_brand='df8170e2-a8ab-4ad4-b06f-e920006a6c94' where fk_brand='a8e93071-c585-4465-9283-76ac63febff8';
delete from drugs.brand where pk='d1603e79-7af1-4592-8619-5be2d93c30d4';
delete from drugs.product where pk='429c4555-bc7a-5b7d-ab8a-9ec9e58a30d5';
update drugs.brand set product_information_filename='gwpmalar.pdf' where pk='df8170e2-a8ab-4ad4-b06f-e920006a6c94';


-- contribution from dr-richard-terry
-- date: 07/26/2012 21:15:27.237
delete from drugs.brand where pk='000c2064-b5bb-40ad-8d72-0269fccf4a54';
delete from drugs.brand where pk='91192578-6574-4df1-ad12-6ca3e09501df';
delete from drugs.brand where pk='92e5ac55-5ead-4ec5-bc4a-3949411cc0a2';
insert into drugs.product (pk,generic,strength,fk_form,atccode,free_comment,fk_schedule,pack_size,amount_unit,amount) values ('6549b768-6cc8-4502-af89-9480cfdf240c',$$hepatitis a virus inactivated$$,$$1440unit$$,
22,'J07BC02',NULL,4,1,26,1);
insert into drugs.brand (pk,fk_product,fk_company,brand,product_information_filename) values ('3f06485b-4e59-40db-b417-169122ff6f2f','6549b768-6cc8-4502-af89-9480cfdf240c','GK',$$HAVRIX 1440$$,'gwphavjv.pdf');

-- contribution from dr-richard-terry
-- date: 07/26/2012 21:24:38.321
update clin_prescribing.medications set fk_generic_product='26211640-5fc2-4b78-b950-8128aa6f125d' where fk_generic_product='abffc43b-c2ee-4554-8430-ee0a2016ebf8';
delete from drugs.product where pk='abffc43b-c2ee-4554-8430-ee0a2016ebf8';

--insert into drugs.brand (pk,fk_product,fk_company,brand,product_information_filename) values ('6477ec0b-3cee-4233-9235-757949699bb2','26211640-5fc2-4b78-b950-8128aa6f125d','SW',$$TYPHIM VI$$,NULL);

update clin_prescribing.medications set fk_generic_product='26211640-5fc2-4b78-b950-8128aa6f125d' where fk_generic_product='55a228c3-218e-470f-bf20-8fd0b1166214';
delete from drugs.product where pk='55a228c3-218e-470f-bf20-8fd0b1166214';

insert into drugs.product (pk,generic,strength,fk_form,atccode,free_comment,fk_schedule,pack_size,amount_unit,amount) values ('7d65fdeb-7369-40a2-9fca-f8e98564815a',$$hepatitis a virus inactivated$$,$$160unit$$,22,'J07BC02',NULL,4,1,26,0.5);
insert into drugs.brand (pk,fk_product,fk_company,brand,product_information_filename) values ('46f800da-9b12-498a-b892-4cedcf402fea','7d65fdeb-7369-40a2-9fca-f8e98564815a','SW',$$AVAXIM$$,NULL);

-- contribution from dr-richard-terry
-- date: 07/26/2012 21:41:56.689
insert into drugs.product (pk,generic,strength,fk_form,atccode,free_comment,fk_schedule,pack_size,amount_unit,amount) values ('c161863c-6104-41ab-a122-1a82d3e38cdc',$$rabies vaccine inactivated$$,$$$$,22,'J07BG01',NULL,4,1,26,1);
insert into drugs.brand (pk,fk_product,fk_company,brand,product_information_filename) values ('89bb24c2-9fbc-4397-a911-a56f2b777aa1','c161863c-6104-41ab-a122-1a82d3e38cdc','SW',$$MERIEUX INACTIVATED RABIES VACCINE$$,NULL);
insert into drugs.brand (pk,fk_product,fk_company,brand,product_information_filename) values ('11ea640e-0313-4d47-9580-a971e910c7ad','c161863c-6104-41ab-a122-1a82d3e38cdc','NV',$$RABIPUR$$,NULL);

-- contribution from dr-richard-terry
-- date: 07/26/2012 21:53:41.121
update clin_prescribing.medications set fk_generic_product='628b0f30-7a8a-45ad-abdb-d405c8f4bce9' where fk_generic_product='ddddb35d-d926-4857-bf0e-1f27823cf672';
delete from drugs.product where pk='ddddb35d-d926-4857-bf0e-1f27823cf672';
insert into drugs.brand (pk,fk_product,fk_company,brand,product_information_filename) values ('566977bb-9e73-47e3-b9a8-0a0a5bc48035','628b0f30-7a8a-45ad-abdb-d405c8f4bce9','BN',$$YAZ$$,NULL);

-- contribution from dr-richard-terry
-- date: 07/26/2012 23:13:13.863
update clin_prescribing.prescribed set fk_brand='c458ef6d-bf09-4cb6-bd8a-b7ce0de53c94' where fk_brand='5abc1693-01d6-461e-8b6e-2f1ad056d070';
update clin_prescribing.medications set fk_generic_product='59336329-98b6-50f9-b0a4-61cd50407973' where fk_generic_product='5382a0f0-c543-5cac-9684-88cdee651b2a';
delete from drugs.brand where pk='5abc1693-01d6-461e-8b6e-2f1ad056d070';
delete from drugs.brand where fk_product='5382a0f0-c543-5cac-9684-88cdee651b2a';
delete from drugs.product where pk='5382a0f0-c543-5cac-9684-88cdee651b2a';

-- contribution from dr-richard-terry
-- date: 07/26/2012 23:14:31.198
update clin_prescribing.prescribed set fk_brand='fb7f5868-b5ed-4780-a2bf-89e8a113778e' where fk_brand='2098d3c3-a73f-420f-b524-e4ae3275a2eb';
delete from drugs.brand where pk='2098d3c3-a73f-420f-b524-e4ae3275a2eb';
update clin_prescribing.medications set fk_generic_product='ba77da3d-0394-41ff-9f54-aafbcbe08b61' where fk_generic_product='80b17e2d-7780-41a4-83cc-a2778140e96d';
delete from drugs.product where pk='80b17e2d-7780-41a4-83cc-a2778140e96d';
delete from drugs.brand where pk='e6217b88-d41f-4056-93b0-81f7ece0bfd6';
delete from drugs.product where pk='9100d9e0-d38b-516d-985b-e27a99941fed';
delete from drugs.brand where pk='6f948aa0-52fc-4e6f-bcad-6f22dc5cd8ac';
delete from drugs.product where pk='3312aa62-098d-54ec-9a5f-4a96c9e80ee5';


truncate db.lu_version;
insert into db.lu_version(lu_major, lu_minor)values(0, 205);
