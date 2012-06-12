-- add some non-PBS drugs originally uploaded by Richard using the GUI drugs module


delete from drugs.brand where fk_product = E'52b40426-db7d-4e18-82e4-0ff6288b1090';
delete from drugs.product where pk = E'52b40426-db7d-4e18-82e4-0ff6288b1090';
INSERT INTO drugs.product (shared,fk_schedule,generic,strength,fk_form,atccode,pk,amount,amount_unit,pack_size) VALUES (TRUE,4,E'hepatitis a virus inactivated',E'25unit',22,E'J07BC02', E'52b40426-db7d-4e18-82e4-0ff6288b1090',0.5, 26, 1);
insert into drugs.brand (brand,fk_product,fk_company,product_information_filename) values (E'VAQTA PAEDIATRIC',E'52b40426-db7d-4e18-82e4-0ff6288b1090',E'MSD',E'mkpvaqta.pdf');

delete from drugs.brand where fk_product = E'ba516be5-0719-4c83-9ebf-990a9a5f78d6';
delete from drugs.product where pk = E'ba516be5-0719-4c83-9ebf-990a9a5f78d6';
INSERT INTO drugs.product (pk,shared,generic,strength,fk_form,atccode,amount, amount_unit, pack_size) VALUES (E'ba516be5-0719-4c83-9ebf-990a9a5f78d6',TRUE,E'human papillomavirus vaccine',E'120mcg',22,E'J07BM01',E'0.5', 26, 1);
INSERT INTO drugs.brand (brand,fk_product,fk_company,product_information_filename) VALUES (E'GARDASIL',E'ba516be5-0719-4c83-9ebf-990a9a5f78d6',E'MSD',E'mkpgarda.pdf');

delete from drugs.brand where fk_product = E'93529526-5215-4a55-bd3f-925ea170ba2d';
delete from drugs.product where pk = E'93529526-5215-4a55-bd3f-925ea170ba2d';
INSERT INTO drugs.product (pk,shared,generic,strength,fk_form,atccode, amount, amount_unit, pack_size) VALUES (E'93529526-5215-4a55-bd3f-925ea170ba2d',TRUE,E'salmonella typhi purified polysaccharide capsule (Ty 2 strain);hepatitis a  virus inactivated',E'25mcg-160unit',22,E'J07CA10',E'0.5', 26, 1);
INSERT INTO drugs.brand (brand,fk_product,fk_company,product_information_filename) VALUES (E'VIVAXIM',E'93529526-5215-4a55-bd3f-925ea170ba2d',E'SW',E'vivaxim.pdf'); -- PDF not in Guild set

delete from drugs.brand where fk_product = E'a09d1ac0-f641-4dc5-81b8-0ad3b5063ac6';
delete from drugs.product where pk = E'a09d1ac0-f641-4dc5-81b8-0ad3b5063ac6';
INSERT INTO drugs.product (pk,shared,generic,strength,fk_form,atccode,amount, amount_unit, pack_size) VALUES (E'a09d1ac0-f641-4dc5-81b8-0ad3b5063ac6',TRUE,E'vibrio cholerae virus inactivated;recombinant cholera toxin B subunit',E'125000000000unit-1mg',35,E'J07AE01',E'3', 26, 1);
INSERT INTO drugs.brand (brand,fk_product,fk_company,product_information_filename) VALUES (E'DUKORAL',E'a09d1ac0-f641-4dc5-81b8-0ad3b5063ac6',E'CS',E'dukoral.pdf'); -- PDF not in Guild set

delete from drugs.brand where fk_product = E'35c498c8-9f93-4332-b929-7310fc72f5fb';
delete from drugs.product where pk = E'35c498c8-9f93-4332-b929-7310fc72f5fb';
INSERT INTO drugs.product (pk,shared,generic,strength,fk_form,atccode,amount, amount_unit, pack_size) VALUES (E'35c498c8-9f93-4332-b929-7310fc72f5fb',TRUE,E'yellow fever virus vaccine',E'1000unit',22,E'J07BL01',E'0.5', 26, 1);
INSERT INTO drugs.brand (brand,fk_product,fk_company,product_information_filename) VALUES (E'STAMARIL',E'35c498c8-9f93-4332-b929-7310fc72f5fb',E'SW',E'stamaril.pdf'); -- PDF not in Guild set

delete from drugs.brand where fk_product = E'549d1e08-087d-4e68-a1e3-19ccf30318c8';
delete from drugs.product where pk = E'549d1e08-087d-4e68-a1e3-19ccf30318c8';
INSERT INTO drugs.product (pk,shared,generic,strength,fk_form,atccode,amount, amount_unit, pack_size) VALUES (E'549d1e08-087d-4e68-a1e3-19ccf30318c8',TRUE,E'japanese encephalitis virus inactivated vaccine',E'6mcg',22,E'J07BA02',E'0.5', 26, 1);
INSERT INTO drugs.brand (brand,fk_product,fk_company,product_information_filename) VALUES (E'JESPECT',E'549d1e08-087d-4e68-a1e3-19ccf30318c8',E'CS',E'jespect.pdf'); -- PDF not in Guild set

delete from drugs.brand where fk_product = E'26211640-5fc2-4b78-b950-8128aa6f125d';
delete from drugs.product where pk = E'26211640-5fc2-4b78-b950-8128aa6f125d';
INSERT INTO drugs.product (pk,shared,generic,strength,fk_form,atccode,amount, amount_unit, pack_size) VALUES (E'26211640-5fc2-4b78-b950-8128aa6f125d',TRUE,E'salmonella typhi purified polysaccharide capsule (Ty 2 strain)',E'25mcg',22,E'J07AP03',E'0.5', 26, 1);
INSERT INTO drugs.brand (brand,fk_product,fk_company,product_information_filename) VALUES (E'TYPHERIX',E'26211640-5fc2-4b78-b950-8128aa6f125d',E'GK',E'gwptyphv.pdf');

delete from drugs.brand where fk_product = E'dbdc03b7-975e-47a7-8619-0381c5582deb';
delete from drugs.product where pk = E'dbdc03b7-975e-47a7-8619-0381c5582deb';
INSERT INTO drugs.product (pk,shared,generic,strength,fk_form,atccode,amount, amount_unit, pack_size) VALUES (E'dbdc03b7-975e-47a7-8619-0381c5582deb',TRUE,E'hepatitis a virus inactivated',E'720unit',22,E'J07BC02',E'0.5', 26, 1);
INSERT INTO drugs.brand (brand,fk_product,fk_company,product_information_filename) VALUES (E'HAVRIX JUNIOR PRESERVATIVE FREE',E'dbdc03b7-975e-47a7-8619-0381c5582deb',E'GK',E'gwphavjp.pdf');

INSERT INTO drugs.product (pk,shared,generic,strength,fk_form,atccode,amount, amount_unit, pack_size) VALUES ('ffb79a0a-b60f-4f1b-ae84-a578df1fd430',TRUE,E'hepatitis a virus inactivated',E'720unit',58,E'J07BC02',E'0.5', 26, 1);
INSERT INTO drugs.brand (brand,fk_product,fk_company,product_information_filename) VALUES (E'HAVRIX JUNIOR PREFILLED SYRINGE','ffb79a0a-b60f-4f1b-ae84-a578df1fd430',E'GK',E'gwphavjp.pdf');


delete from drugs.brand where fk_product = 'b6ebb223-29e6-48bd-ac2a-30cf1a635c61';
delete from drugs.product where pk = 'b6ebb223-29e6-48bd-ac2a-30cf1a635c61';
INSERT INTO drugs.product (pk, shared,generic,strength,fk_form,atccode,amount,amount_unit,pack_size) VALUES ('b6ebb223-29e6-48bd-ac2a-30cf1a635c61',TRUE,E'hepatitis a virus inactivated',E'1440unit',58,E'J07BC02',E'1', 26, 1);
INSERT INTO drugs.brand (brand,fk_product,fk_company,product_information_filename) VALUES (E'HAVRIX 1440 PREFILLED SYRINGE',E'b6ebb223-29e6-48bd-ac2a-30cf1a635c61',E'GK',E'gwphavjv.pdf');

delete from drugs.brand where fk_product = E'ff792cfb-b980-40da-b11d-c4c1f0e65dbe';
delete from drugs.product where pk = E'ff792cfb-b980-40da-b11d-c4c1f0e65dbe';
INSERT INTO drugs.product (pk,shared,fk_schedule,generic,strength,fk_form,atccode,amount, amount_unit, pack_size) VALUES (E'ff792cfb-b980-40da-b11d-c4c1f0e65dbe',TRUE,4,E'atovaquone;proguanil hydrochloride',E'62.5mg-25mg',59,E'P01BB51',NULL,NULL,60);
INSERT INTO drugs.brand (fk_product,brand,fk_company,product_information_filename) VALUES (E'ff792cfb-b980-40da-b11d-c4c1f0e65dbe','MALARONE JUNIOR','GK',E'gwpmalar.pdf');

delete from drugs.brand where fk_product = E'429c4555-bc7a-5b7d-ab8a-9ec9e58a30d5';
delete from drugs.product where pk = E'429c4555-bc7a-5b7d-ab8a-9ec9e58a30d5';
INSERT INTO drugs.product (pk,shared,fk_schedule,generic,strength,fk_form,atccode,amount, amount_unit, pack_size) VALUES (E'429c4555-bc7a-5b7d-ab8a-9ec9e58a30d5',TRUE,4,E'atovaquone;proguanil hydrochloride',E'250mg-100mg',59,E'P01BB51',NULL,NULL,24);
INSERT INTO drugs.brand (fk_product,brand,fk_company,product_information_filename) VALUES (E'429c4555-bc7a-5b7d-ab8a-9ec9e58a30d5','MALARONE','GK',E'gwpmalar.pdf');

delete from drugs.brand where fk_product = E'71e0c731-dd8e-4080-95df-c1e74c72d19a';
delete from drugs.product where pk = E'71e0c731-dd8e-4080-95df-c1e74c72d19a';
INSERT INTO drugs.product (pk,shared,fk_schedule,generic,strength,fk_form,atccode,pack_size) VALUES (E'71e0c731-dd8e-4080-95df-c1e74c72d19a',TRUE,4,'ethinyloestradiol;cyproterone acetate',E'35mcg-2mg',59,E'G03HB01',28);
INSERT INTO drugs.brand (brand,fk_product,fk_company) VALUES (E'DIANE-35 ED',E'71e0c731-dd8e-4080-95df-c1e74c72d19a',E'BN');
INSERT INTO drugs.brand (brand,fk_product,fk_company,product_information_filename) VALUES (E'BRENDA-35 ED',E'71e0c731-dd8e-4080-95df-c1e74c72d19a',E'AF','afpbrend.pdf');


delete from drugs.brand where fk_product = E'59336329-98b6-50f9-b0a4-61cd50407973';
delete from drugs.product where pk = E'59336329-98b6-50f9-b0a4-61cd50407973';
INSERT INTO drugs.product (pk,shared,fk_schedule,generic,strength,fk_form,atccode,amount,amount_unit,pack_size) VALUES (E'59336329-98b6-50f9-b0a4-61cd50407973',TRUE,4,E'inactivated influenza vaccine (split virion)',E'15mcg',58,E'J07BB02',E'0.5', 58, 1);
insert into drugs.brand (fk_product,brand,fk_company) values (E'59336329-98b6-50f9-b0a4-61cd50407973','FLUVAX','CS');
insert into drugs.brand (fk_product,brand,fk_company) values (E'59336329-98b6-50f9-b0a4-61cd50407973','FLUVARIX','GK');
insert into drugs.brand (fk_product,brand,fk_company,product_information_filename) values (E'59336329-98b6-50f9-b0a4-61cd50407973','INFLUVAC','AB','smpinflu.pdf'); 

delete from drugs.brand where fk_product = E'ba77da3d-0394-41ff-9f54-aafbcbe08b61';
delete from drugs.product where pk = E'ba77da3d-0394-41ff-9f54-aafbcbe08b61';
INSERT INTO drugs.product (pk,shared,fk_schedule,generic,strength,fk_form,atccode,amount,amount_unit,pack_size) VALUES (E'ba77da3d-0394-41ff-9f54-aafbcbe08b61',TRUE,4,E'inactivated influenza vaccine (split virion)',E'7.5mcg',58,E'J07BB02',E'0.25', 26, 1);
insert into drugs.brand (fk_product,brand,fk_company,product_information_filename) values (E'ba77da3d-0394-41ff-9f54-aafbcbe08b61','INFLUVAC JUNIOR','AB','smpinflj.pdf'); 

delete from drugs.brand where fk_product = 'bac31fcb-5ac7-497f-9928-c5d2e8a43910';
delete from drugs.product where pk = 'bac31fcb-5ac7-497f-9928-c5d2e8a43910';
INSERT INTO drugs.product (pk,shared,fk_schedule,generic,strength,fk_form,atccode,amount,amount_unit,pack_size) VALUES ('bac31fcb-5ac7-497f-9928-c5d2e8a43910',true,4,'betamethasone dipropionate','500mcg/g',33,'A07EA04','30',35,1);
insert into drugs.brand (fk_product,brand,fk_company,product_information_filename) values ('bac31fcb-5ac7-497f-9928-c5d2e8a43910','DIPROSONE OV','MK','mkpdipov.pdf');


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 169);



