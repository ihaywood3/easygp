-- fix adacel and put in correct ATC code
delete from drugs.brand where pk='1cf250b1-f55d-44c1-a82c-d67e57abdbab'
or pk='dbeedc16-4ccb-4673-84e1-4660e87d6b42' or
pk='0c8646bc-04d6-4f4b-81c5-8abd5dd26806' or
pk='960142a4-f5c1-4646-9440-a27656280d8d' or
pk='21734d50-dd2e-4182-8b77-987011be0c67';
delete from drugs.product where
pk='5b5addfe-b52a-5bdf-bda6-453ab0f9068a' or
pk='901de45a-b40f-540f-8b00-c9ecb80764bc' or
pk='d23f5e1c-1257-5d44-9cd7-27f3b82b7f27' or
pk='db03e51f-3132-55c7-84fe-84868a893ed5' or
pk='ea0a433c-1778-514c-b88a-174eb424dba2';
update drugs.product set atccode='J07AJ52' where pk='6222f442-9daf-5160-9114-85255e05331c';

-- fix Kinson
 update drugs.product set strength='100mg-25mg' where pk=E'9bda8ebe-17c1-457d-a9f5-bf0952b7c5e2';
-- new drugs codeine linctus, yasmin, boostrix ipv
INSERT INTO drugs.product (shared,fk_schedule,generic,strength,fk_form,atccode,amount,amount_unit,pack_size,pk) VALUES (TRUE,4,E'codeine phosphate', E'5mg/ml',35,E'R05DA04',100,26,1,E'925e7dd5-16f4-4cff-9c5f-310d1745f750');
INSERT INTO drugs.brand (brand,fk_product) VALUES (E'CODEINE LINCTUS',E'925e7dd5-16f4-4cff-9c5f-310d1745f750');
INSERT INTO drugs.product (shared,fk_schedule,generic,strength,fk_form,atccode,pack_size,pk) VALUES (TRUE,4,E'ethinyloestradiol;drospirenone',E'50mcg-3mg',59,E'G03AA12',28,E'628b0f30-7a8a-45ad-abdb-d405c8f4bce9');
INSERT INTO drugs.brand (brand,fk_product,fk_company) VALUES (E'YASMIN',E'628b0f30-7a8a-45ad-abdb-d405c8f4bce9',E'BAY');
-- first fix adacel
update drugs.product set fk_form=58,generic=E'pertussis vaccine;diphtheria vaccine;tetanus toxoid' where generic=E'pertussis vaccine;diphtheria vaccine;tetanus toxoid;inactivated poliovirus vaccine';
-- now add the *real* 4-valent vaccine
INSERT INTO drugs.product (shared,fk_schedule,generic,strength,fk_form,atccode,amount,amount_unit,pack_size,pk) VALUES (TRUE,4,E'pertussis vaccine;diphtheria vaccine;tetanus toxoid;inactivated poliovirus vaccine',E'-',22,E'J07CA02',E'0.5',26,1,E'be846933-c673-4598-a977-aec691aad909');
INSERT INTO drugs.brand (brand,fk_product,fk_company) VALUES (E'BOOSTRIX IPV',E'be846933-c673-4598-a977-aec691aad909',E'GK');

-- update to link pdf's to drugs
UPDATE drugs.brand SET product_information_filename = E'afpamira.pdf' 
WHERE pk = E'497f390f-a01a-4a30-a0bd-63fc52757f60' ;
UPDATE drugs.brand SET product_information_filename = E'afpamira.pdf' 
WHERE pk = E'8fc1a24a-bdae-4eb2-83af-155c10a94e1c' ;
UPDATE drugs.brand SET product_information_filename = E'afpanpec.pdf' 
WHERE pk = E'503a75c0-87d4-4bd9-a80d-ebf5a70895e6' ;
UPDATE drugs.brand SET product_information_filename = E'afpanpec.pdf' 
WHERE pk = E'e32851de-faf2-4963-8aef-d658fc14b6f3' ;
UPDATE drugs.brand SET product_information_filename = E'afpanthe.pdf' 
WHERE pk = E'a339a8c6-4783-4e07-975f-cfac7c28a891' ;
UPDATE drugs.brand SET product_information_filename = E'afpanthe.pdf' 
WHERE pk = E'5d48986b-c04c-4d9b-b2bf-4f743b06d6d4' ;
UPDATE drugs.brand SET product_information_filename = E'afpaamox.pdf' 
WHERE pk = E'a0994e60-8fd9-4f6b-bc99-8053a6f82bb6' ;
UPDATE drugs.brand SET product_information_filename = E'afpaamox.pdf' 
WHERE pk = E'9398b187-ba32-40cd-a549-0607d35ce84a' ;
UPDATE drugs.brand SET product_information_filename = E'afpaamox.pdf' 
WHERE pk = E'5a2f06d6-a61d-42f3-910e-24355a3bbceb' ;
UPDATE drugs.brand SET product_information_filename = E'afpaamox.pdf' 
WHERE pk = E'8dbcf538-9e02-43da-a1a9-3692d047fec7' ;
UPDATE drugs.brand SET product_information_filename = E'txpmetfo.pdf' 
WHERE pk = E'd7790d29-77ca-4c23-afaa-b28d85281932' ;
UPDATE drugs.brand SET product_information_filename = E'txpmetfo.pdf' 
WHERE pk = E'24a95556-5ade-43f2-8b84-44e0343e14fe' ;
UPDATE drugs.brand SET product_information_filename = E'txpmetfo.pdf' 
WHERE pk = E'07e29a20-78b7-478a-a1fa-d3a65d2dd9dc' ;
UPDATE drugs.brand SET product_information_filename = E'chpmetop.pdf' 
WHERE pk = E'c857c058-b790-4175-a0f2-ce2c148935df' ;
UPDATE drugs.brand SET product_information_filename = E'chpmetop.pdf' 
WHERE pk = E'8012da42-7d88-432c-9fc3-ea3aad81b44d' ;
UPDATE drugs.brand SET product_information_filename = E'afpzactc.pdf' 
WHERE pk = E'8a040923-84e6-45ed-8254-2e6a321bd5b3' ;
UPDATE drugs.brand SET product_information_filename = E'afpzactc.pdf' 
WHERE pk = E'febc1d83-9c4f-41ea-a839-379d33b62ecf' ;
UPDATE drugs.brand SET product_information_filename = E'roppgsps.pdf' 
WHERE pk = E'e30f7cbb-21b1-47ef-902e-7b38ee724e05' ;
UPDATE drugs.brand SET product_information_filename = E'roppgsps.pdf' 
WHERE pk = E'f21b0959-8885-412f-9177-d18be16c7e6d' ;
UPDATE drugs.brand SET product_information_filename = E'pfpramit.pdf' 
WHERE pk = E'a61430a9-5012-4d63-adaf-b6e07b5347c3' ;
UPDATE drugs.brand SET product_information_filename = E'pfpramit.pdf' 
WHERE pk = E'bde366df-71a3-4c6b-9586-da7aff7ecd74' ;
UPDATE drugs.brand SET product_information_filename = E'pfpramit.pdf' 
WHERE pk = E'52959a8b-dfcc-4410-bf80-9fddcf196c23' ;
UPDATE drugs.brand SET product_information_filename = E'pfpramit.pdf' 
WHERE pk = E'e7415853-84c9-4dca-91b7-80a6c4748c4c' ;
UPDATE drugs.brand SET product_information_filename = E'bypatrcf.pdf' 
WHERE pk = E'c94e04d5-c934-4020-bf61-9a7410b8a927' ;
UPDATE drugs.brand SET product_information_filename = E'lupfluan.pdf' 
WHERE pk = E'4965d0fc-3a38-4c2e-a9aa-2815aca08bdf' ;
UPDATE drugs.brand SET product_information_filename = E'afptrmsr.pdf' 
WHERE pk = E'1d8f43c7-78cd-4029-9cc9-962b066d2d44' ;
UPDATE drugs.brand SET product_information_filename = E'afptrmsr.pdf' 
WHERE pk = E'f69a042c-1834-4db2-b209-f40b4f40810d' ;
UPDATE drugs.brand SET product_information_filename = E'afptrmsr.pdf' 
WHERE pk = E'7d9d2063-0c81-4959-8f7f-2df33a7e3a3d' ;
UPDATE drugs.brand SET product_information_filename = E'afpstaph.pdf' 
WHERE pk = E'dca32062-db7d-4555-b6d7-354dc757c6f5' ;
UPDATE drugs.brand SET product_information_filename = E'afpstaph.pdf' 
WHERE pk = E'b45b8e0f-0f7d-41ae-9df3-57e1ca968d5a' ;
UPDATE drugs.brand SET product_information_filename = E'swpcarcd.pdf' 
WHERE pk = E'7cdd725a-690a-459e-b03d-7a960dbb5a59' ;
UPDATE drugs.brand SET product_information_filename = E'swpcarcd.pdf' 
WHERE pk = E'e8c65036-7b4d-4c97-a805-446e4f3e48dc' ;
UPDATE drugs.brand SET product_information_filename = E'swpcarcd.pdf' 
WHERE pk = E'4582e13f-8024-4eb5-80aa-8ae485968866' ;
UPDATE drugs.brand SET product_information_filename = E'txpfluco.pdf' 
WHERE pk = E'459e6d30-0b03-4ff4-bcb4-cdeb673a5a84' ;
UPDATE drugs.brand SET product_information_filename = E'gxpmetop.pdf' 
WHERE pk = E'1db21b21-92ce-4cb1-8695-caab238455fd' ;
UPDATE drugs.brand SET product_information_filename = E'gxpmetop.pdf' 
WHERE pk = E'27b584a6-1bb1-49b3-b60e-9a747d235215' ;
UPDATE drugs.brand SET product_information_filename = E'roppgrst.pdf' 
WHERE pk = E'296600df-3c4f-43d7-8345-b876eedf5424' ;
UPDATE drugs.brand SET product_information_filename = E'gxpisotr.pdf' 
WHERE pk = E'985c4f54-101f-46fb-abb2-eeb00978e7d3' ;
UPDATE drugs.brand SET product_information_filename = E'fpppento.pdf' 
WHERE pk = E'4ef15ca6-dc48-430c-b044-91fe49975908' ;
UPDATE drugs.brand SET product_information_filename = E'fpppento.pdf' 
WHERE pk = E'5d446f1d-09b5-4cc2-bbb1-692a9cb7102c' ;
UPDATE drugs.brand SET product_information_filename = E'fpppento.pdf' 
WHERE pk = E'36d9eddf-d936-492a-bc02-5dabbca0f6a1' ;
UPDATE drugs.brand SET product_information_filename = E'fpppento.pdf' 
WHERE pk = E'3b9301b3-c52a-4899-a92e-c514c2f2580b' ;
UPDATE drugs.brand SET product_information_filename = E'txpanthr.pdf' 
WHERE pk = E'534ecc83-8908-4396-9224-429151f37b29' ;
UPDATE drugs.brand SET product_information_filename = E'txpanthr.pdf' 
WHERE pk = E'9496afd5-5b06-4e0a-85a1-99d6715c4cc4' ;
UPDATE drugs.brand SET product_information_filename = E'swpclopi.pdf' 
WHERE pk = E'5504926a-7c91-4667-9e90-e8b142ef6891' ;
UPDATE drugs.brand SET product_information_filename = E'afpaamox.pdf' 
WHERE pk = E'a0994e60-8fd9-4f6b-bc99-8053a6f82bb6' ;
UPDATE drugs.brand SET product_information_filename = E'afpaamox.pdf' 
WHERE pk = E'9398b187-ba32-40cd-a549-0607d35ce84a' ;
UPDATE drugs.brand SET product_information_filename = E'afpaamox.pdf' 
WHERE pk = E'5a2f06d6-a61d-42f3-910e-24355a3bbceb' ;
UPDATE drugs.brand SET product_information_filename = E'afpaamox.pdf' 
WHERE pk = E'8dbcf538-9e02-43da-a1a9-3692d047fec7' ;
UPDATE drugs.brand SET product_information_filename = E'mkpccdsi.pdf' 
WHERE pk = E'8a89ddf5-2981-49cf-b816-e90bff3a24cb' ;
UPDATE drugs.brand SET product_information_filename = E'afpglyad.pdf' 
WHERE pk = E'b2c78d76-07c3-436b-add9-0b758c21287b' ;
UPDATE drugs.brand SET product_information_filename = E'twpdiclo.pdf' 
WHERE pk = E'7aa356ba-e92e-4c9c-bb74-77f4669c6f63' ;
UPDATE drugs.brand SET product_information_filename = E'twpdiclo.pdf' 
WHERE pk = E'57418d5d-853a-4934-bb1f-06fa9a297dfa' ;
UPDATE drugs.brand SET product_information_filename = E'afpdeptr.pdf' 
WHERE pk = E'581d6005-b357-43d2-a0bd-3a1ae9caf03a' ;
UPDATE drugs.brand SET product_information_filename = E'afpdeptr.pdf' 
WHERE pk = E'a2b0092b-6a91-4a0d-84c4-41b57c74a08c' ;
UPDATE drugs.brand SET product_information_filename = E'afpdeptr.pdf' 
WHERE pk = E'1789b312-74ac-48a3-a6fe-785dc04be5fa' ;
UPDATE drugs.brand SET product_information_filename = E'afpdiabx.pdf' 
WHERE pk = E'50b3225e-6b09-43ba-9e9a-b39b170719a5' ;
UPDATE drugs.brand SET product_information_filename = E'afpdiabx.pdf' 
WHERE pk = E'a4c0116c-70ad-436c-b2fe-56874b99248e' ;
UPDATE drugs.brand SET product_information_filename = E'afptryta.pdf' 
WHERE pk = E'240236ec-3e1b-44a6-aeb5-651259157886' ;
UPDATE drugs.brand SET product_information_filename = E'afptryta.pdf' 
WHERE pk = E'9b5dfc04-4543-483f-aec1-5703c7360758' ;
UPDATE drugs.brand SET product_information_filename = E'afptryta.pdf' 
WHERE pk = E'05b400ac-1451-4030-b304-2054505ff5f5' ;
UPDATE drugs.brand SET product_information_filename = E'afptryta.pdf' 
WHERE pk = E'ad0cc3a3-e11e-4bd4-a199-4c09630fc5f5' ;
UPDATE drugs.brand SET product_information_filename = E'txpmetfo.pdf' 
WHERE pk = E'd7790d29-77ca-4c23-afaa-b28d85281932' ;
UPDATE drugs.brand SET product_information_filename = E'txpmetfo.pdf' 
WHERE pk = E'24a95556-5ade-43f2-8b84-44e0343e14fe' ;
UPDATE drugs.brand SET product_information_filename = E'txpmetfo.pdf' 
WHERE pk = E'07e29a20-78b7-478a-a1fa-d3a65d2dd9dc' ;
UPDATE drugs.brand SET product_information_filename = E'gwpaugts.pdf' 
WHERE pk = E'1972fd36-ab81-4dcc-b847-647b2cf01b48' ;
UPDATE drugs.brand SET product_information_filename = E'sepnatri.pdf' 
WHERE pk = E'd8ffebe1-c56f-4548-8e3f-33919e227a3f' ;
UPDATE drugs.brand SET product_information_filename = E'sepnatri.pdf' 
WHERE pk = E'9ae53205-5bd7-4b06-ab56-2646bec8c091' ;
UPDATE drugs.brand SET product_information_filename = E'chpglica.pdf' 
WHERE pk = E'921800ce-6263-4082-8d58-a36c8331b18c' ;
UPDATE drugs.brand SET product_information_filename = E'twpperin.pdf' 
WHERE pk = E'c1924fe9-6411-4bf5-8cca-d995906e08df' ;
UPDATE drugs.brand SET product_information_filename = E'twpperin.pdf' 
WHERE pk = E'f6abff50-cb59-4c72-a0c5-fb2e283e280d' ;
UPDATE drugs.brand SET product_information_filename = E'twpperin.pdf' 
WHERE pk = E'85f89331-8b00-42e0-9483-f976f9032c09' ;
UPDATE drugs.brand SET product_information_filename = E'nvptgror.pdf' 
WHERE pk = E'fc7b6f0d-6a3a-4fc9-9b7c-641f68ecfa67' ;
UPDATE drugs.brand SET product_information_filename = E'nvptgror.pdf' 
WHERE pk = E'b5c23438-fe52-4725-9a87-079c7bfc78ff' ;
UPDATE drugs.brand SET product_information_filename = E'nvptgror.pdf' 
WHERE pk = E'206081ca-5988-405d-9e9f-0a88aec5ed0b' ;
UPDATE drugs.brand SET product_information_filename = E'nvptgror.pdf' 
WHERE pk = E'85f3d514-bc5c-4058-8afa-822396f0afe9' ;
UPDATE drugs.brand SET product_information_filename = E'nvptgror.pdf' 
WHERE pk = E'cc3521ba-1cba-4ac1-b383-7db8f0c41303' ;
UPDATE drugs.brand SET product_information_filename = E'appnexhp.pdf' 
WHERE pk = E'507030ea-8d99-4d5e-93e8-fe30d0fad260' ;
UPDATE drugs.brand SET product_information_filename = E'swptrias.pdf' 
WHERE pk = E'994ff6b4-0b76-47fa-b133-955d3901f7c8' ;
UPDATE drugs.brand SET product_information_filename = E'swptrias.pdf' 
WHERE pk = E'94062727-0b9d-4b64-b490-6d8d0a019d82' ;
UPDATE drugs.brand SET product_information_filename = E'txpflucz.pdf' 
WHERE pk = E'459e6d30-0b03-4ff4-bcb4-cdeb673a5a84' ;
UPDATE drugs.brand SET product_information_filename = E'gxpterbi.pdf' 
WHERE pk = E'dd6f630c-77a0-44df-9e64-165e4a407277' ;
UPDATE drugs.brand SET product_information_filename = E'gxpfosin.pdf' 
WHERE pk = E'afdbcb27-87ea-488f-b195-883b304796fe' ;
UPDATE drugs.brand SET product_information_filename = E'gxpfosin.pdf' 
WHERE pk = E'fd3809f0-a9ec-402e-98ec-174dbcbda142' ;
UPDATE drugs.brand SET product_information_filename = E'afppaxam.pdf' 
WHERE pk = E'3ae6297d-36eb-4afe-b914-2b1d6d68d5f3' ;
UPDATE drugs.brand SET product_information_filename = E'afppaxam.pdf' 
WHERE pk = E'5ada509e-fe0a-4759-8953-40d3a48c6b47' ;
UPDATE drugs.brand SET product_information_filename = E'afppaxam.pdf' 
WHERE pk = E'3ae6297d-36eb-4afe-b914-2b1d6d68d5f3' ;
UPDATE drugs.brand SET product_information_filename = E'afppaxam.pdf' 
WHERE pk = E'297e2477-3937-442b-b18f-e2bf7b60611e' ;
UPDATE drugs.brand SET product_information_filename = E'afppaxam.pdf' 
WHERE pk = E'493fddcf-fe7f-493f-8d9b-6d5b71351799' ;
UPDATE drugs.brand SET product_information_filename = E'afppaxam.pdf' 
WHERE pk = E'297e2477-3937-442b-b18f-e2bf7b60611e' ;
UPDATE drugs.brand SET product_information_filename = E'aspceclo.pdf' 
WHERE pk = E'0ca66926-34be-4e05-871e-2cb3022c6f88' ;
UPDATE drugs.brand SET product_information_filename = E'aspceclo.pdf' 
WHERE pk = E'cd50fea1-8ac9-4dbc-ac51-f3ead001eb9d' ;
UPDATE drugs.brand SET product_information_filename = E'iapnuesr.pdf' 
WHERE pk = E'f44360c5-7aa7-4362-9e1b-eaccf4ec5c74' ;
UPDATE drugs.brand SET product_information_filename = E'iapnuesr.pdf' 
WHERE pk = E'5629431f-7b81-47f5-9604-760e5d503055' ;
UPDATE drugs.brand SET product_information_filename = E'iapnuesr.pdf' 
WHERE pk = E'54f20fe7-bbb5-4b73-9633-1c3e21596a17' ;
UPDATE drugs.brand SET product_information_filename = E'chpdilti.pdf' 
WHERE pk = E'68ed45b3-7471-4c1e-9798-d3ecab4c0142' ;
UPDATE drugs.brand SET product_information_filename = E'chpdilcd.pdf' 
WHERE pk = E'0d4e36f7-7a1a-4dcb-8c6b-95e01ac2526d' ;
UPDATE drugs.brand SET product_information_filename = E'chpdilcd.pdf' 
WHERE pk = E'8974c3aa-8bf7-4259-9232-7323a7036962' ;
UPDATE drugs.brand SET product_information_filename = E'chpdiclo.pdf' 
WHERE pk = E'8125f066-01f9-4b38-939b-0ab174361c7f' ;
UPDATE drugs.brand SET product_information_filename = E'chpdiclo.pdf' 
WHERE pk = E'ca7f8650-a5ad-4835-8518-ecb2abec1b4d' ;
UPDATE drugs.brand SET product_information_filename = E'chpdoxyt.pdf' 
WHERE pk = E'e6243c76-c56d-4bed-a2a2-e37c2ff99996' ;
UPDATE drugs.brand SET product_information_filename = E'chpdoxyt.pdf' 
WHERE pk = E'5a93baf5-cf7c-4a00-ac98-b65baabdd554' ;
UPDATE drugs.brand SET product_information_filename = E'chpdoxyt.pdf' 
WHERE pk = E'c467e532-d329-484a-87df-48c4da134a59' ;
UPDATE drugs.brand SET product_information_filename = E'chpdoxyt.pdf' 
WHERE pk = E'e6243c76-c56d-4bed-a2a2-e37c2ff99996' ;
UPDATE drugs.brand SET product_information_filename = E'chpdoxyt.pdf' 
WHERE pk = E'9b303f0b-6b89-45ad-8435-daf5d33541c6' ;
UPDATE drugs.brand SET product_information_filename = E'chplerca.pdf' 
WHERE pk = E'89857cb4-fcdd-49e2-9ca9-e940c23ffaea' ;
UPDATE drugs.brand SET product_information_filename = E'chplerca.pdf' 
WHERE pk = E'a6c864be-a29e-47d6-8728-5f0ce8856d8e' ;
UPDATE drugs.brand SET product_information_filename = E'chpcefcd.pdf' 
WHERE pk = E'1d197288-3568-4032-a67f-ed26b7247a4a' ;
UPDATE drugs.brand SET product_information_filename = E'chptramz.pdf' 
WHERE pk = E'24bb1d05-8cca-4388-85df-44416449a1b1' ;
UPDATE drugs.brand SET product_information_filename = E'chpprava.pdf' 
WHERE pk = E'9c84f5cf-a178-464a-892e-e81970027ac0' ;
UPDATE drugs.brand SET product_information_filename = E'chpprava.pdf' 
WHERE pk = E'5167a28d-5739-4e41-90d8-c7921e4c6dd2' ;
UPDATE drugs.brand SET product_information_filename = E'chpprava.pdf' 
WHERE pk = E'3a4c8f70-cb76-4a8d-831c-126ab3cab99f' ;
UPDATE drugs.brand SET product_information_filename = E'chpprava.pdf' 
WHERE pk = E'3b46556c-3b31-4b35-9916-d9c5223e5d90' ;
UPDATE drugs.brand SET product_information_filename = E'gwpamoor.pdf' 
WHERE pk = E'0a4c1932-3c4b-42d9-8767-6adb5257fe68' ;
UPDATE drugs.brand SET product_information_filename = E'gwpamoor.pdf' 
WHERE pk = E'6b712743-1eea-472e-8395-9707f4d17fea' ;
UPDATE drugs.brand SET product_information_filename = E'gwpamoor.pdf' 
WHERE pk = E'2e8c9d4e-6992-4949-a0a9-f5412d0b9014' ;
UPDATE drugs.brand SET product_information_filename = E'gwpamoor.pdf' 
WHERE pk = E'93025644-24d2-4626-ae9d-df9a890c81c0' ;
UPDATE drugs.brand SET product_information_filename = E'gwpamoor.pdf' 
WHERE pk = E'9bd904f8-bea5-455b-b8f8-1b2d26f3720a' ;
UPDATE drugs.brand SET product_information_filename = E'chpisoso.pdf' 
WHERE pk = E'075a1b1b-b81d-4afa-9ba5-2b6f54bfc056' ;
UPDATE drugs.brand SET product_information_filename = E'chpsimva.pdf' 
WHERE pk = E'9309fc6b-6bc6-40f7-8a0e-3a3138d23ab7' ;
UPDATE drugs.brand SET product_information_filename = E'chpsimva.pdf' 
WHERE pk = E'f28fbf93-82b3-40d1-895c-ef9ee519cf3b' ;
UPDATE drugs.brand SET product_information_filename = E'chpsimva.pdf' 
WHERE pk = E'3a6d5409-0bbc-4d8f-8afd-1a4c39c264a2' ;
UPDATE drugs.brand SET product_information_filename = E'chpsimva.pdf' 
WHERE pk = E'c9944ef5-6c68-409e-87a3-ee22c9345303' ;
UPDATE drugs.brand SET product_information_filename = E'chpamoxs.pdf' 
WHERE pk = E'cda4feaa-82ee-4825-9eb8-8084c44c2969' ;
UPDATE drugs.brand SET product_information_filename = E'chpamoxs.pdf' 
WHERE pk = E'843fef16-b468-4473-8483-7e6fcd68b7a2' ;
UPDATE drugs.brand SET product_information_filename = E'chpmelox.pdf' 
WHERE pk = E'2bfdaa8a-406a-436c-a2d2-715d22914ff1' ;
UPDATE drugs.brand SET product_information_filename = E'chpmelox.pdf' 
WHERE pk = E'0ff1260c-fdf1-436d-a593-8917a2f0c87d' ;
UPDATE drugs.brand SET product_information_filename = E'chpacicl.pdf' 
WHERE pk = E'0ffe64c2-e62d-4014-b472-7656bc580003' ;
UPDATE drugs.brand SET product_information_filename = E'chpbaclo.pdf' 
WHERE pk = E'a58ee202-4712-484b-bae0-7366be930929' ;
UPDATE drugs.brand SET product_information_filename = E'chpbaclo.pdf' 
WHERE pk = E'907f580f-4667-43ce-b88c-6afa6391db86' ;
UPDATE drugs.brand SET product_information_filename = E'chpmetfo.pdf' 
WHERE pk = E'13dcb7c9-f469-4585-b216-7a19b67262bb' ;
UPDATE drugs.brand SET product_information_filename = E'chpmetfo.pdf' 
WHERE pk = E'f33e50f1-c2f0-4e1e-a060-6e5e89944b9c' ;
UPDATE drugs.brand SET product_information_filename = E'chpmetfo.pdf' 
WHERE pk = E'c3ceed7c-0025-428d-aa95-e214c1d6bc54' ;
UPDATE drugs.brand SET product_information_filename = E'chpparox.pdf' 
WHERE pk = E'49225656-d013-4263-9f87-49d7d19327c8' ;
UPDATE drugs.brand SET product_information_filename = E'chpfluox.pdf' 
WHERE pk = E'253df500-e8b5-42da-a8a5-4ef9065274fe' ;
UPDATE drugs.brand SET product_information_filename = E'chpamoxc.pdf' 
WHERE pk = E'affb3767-dcad-4078-9b81-7564a745c96a' ;
UPDATE drugs.brand SET product_information_filename = E'chpamoxc.pdf' 
WHERE pk = E'b979e09b-ede6-45e1-984f-abbb452e39d4' ;
UPDATE drugs.brand SET product_information_filename = E'chppiroc.pdf' 
WHERE pk = E'08b18667-efb7-4990-b5e4-14366afc9b39' ;
UPDATE drugs.brand SET product_information_filename = E'chppiroc.pdf' 
WHERE pk = E'f18b0402-7ad3-4393-9088-46cccd84be32' ;
UPDATE drugs.brand SET product_information_filename = E'sepreapt.pdf' 
WHERE pk = E'25bcb5fc-0c41-4232-ae65-75c9e652fa81' ;
UPDATE drugs.brand SET product_information_filename = E'sepreapt.pdf' 
WHERE pk = E'92ef4c8b-a23b-4276-8f62-f11e45c257fc' ;
UPDATE drugs.brand SET product_information_filename = E'sepreapt.pdf' 
WHERE pk = E'f5089c37-fb92-4a71-87e0-68d08d427f0c' ;
UPDATE drugs.brand SET product_information_filename = E'sepreapt.pdf' 
WHERE pk = E'3b47963f-4f25-4aa9-a28b-4b32cfa6b842' ;
UPDATE drugs.brand SET product_information_filename = E'swpomepr.pdf' 
WHERE pk = E'de204113-0605-4ef6-b8ab-facdc469621d' ;
UPDATE drugs.brand SET product_information_filename = E'afpmonac.pdf' 
WHERE pk = E'288512d6-0f6b-4128-807b-8407bba1da72' ;
UPDATE drugs.brand SET product_information_filename = E'afpmonac.pdf' 
WHERE pk = E'dc72a56e-22ac-43e9-8830-3c59f4a81a2e' ;
UPDATE drugs.brand SET product_information_filename = E'iapminit.pdf' 
WHERE pk = E'36767533-c69c-4b62-841f-8e49dc0d2e59' ;
UPDATE drugs.brand SET product_information_filename = E'iapminit.pdf' 
WHERE pk = E'244469f3-d4e3-4c25-942e-36438e357ca7' ;
UPDATE drugs.brand SET product_information_filename = E'iapminit.pdf' 
WHERE pk = E'b7289744-97aa-48b1-855e-3fcc0eacb4a7' ;
UPDATE drugs.brand SET product_information_filename = E'afpgluco.pdf' 
WHERE pk = E'707d4fa3-461a-44ee-bea5-56a61643fba6' ;
UPDATE drugs.brand SET product_information_filename = E'afpgluco.pdf' 
WHERE pk = E'0add48d0-0aeb-4b7e-bf88-1febba852bca' ;
UPDATE drugs.brand SET product_information_filename = E'afpgluco.pdf' 
WHERE pk = E'6137ab52-b7cc-4343-a513-1e55deed463d' ;
UPDATE drugs.brand SET product_information_filename = E'chpmoclo.pdf' 
WHERE pk = E'f4abf6b4-cc12-4a0b-9fd0-bea610e3d529' ;
UPDATE drugs.brand SET product_information_filename = E'chpmoclo.pdf' 
WHERE pk = E'9218e017-62ce-4c73-ad15-f61e9758f76d' ;
UPDATE drugs.brand SET product_information_filename = E'chpmeloc.pdf' 
WHERE pk = E'9030e11a-d4b5-4ff1-b204-7e2ae0156fc5' ;
UPDATE drugs.brand SET product_information_filename = E'chpmeloc.pdf' 
WHERE pk = E'54ba895d-3ff7-4293-a364-78b5efff60c0' ;
UPDATE drugs.brand SET product_information_filename = E'chpsimva.pdf' 
WHERE pk = E'9309fc6b-6bc6-40f7-8a0e-3a3138d23ab7' ;
UPDATE drugs.brand SET product_information_filename = E'chpsimva.pdf' 
WHERE pk = E'f28fbf93-82b3-40d1-895c-ef9ee519cf3b' ;
UPDATE drugs.brand SET product_information_filename = E'chpsimva.pdf' 
WHERE pk = E'3a6d5409-0bbc-4d8f-8afd-1a4c39c264a2' ;
UPDATE drugs.brand SET product_information_filename = E'chpsimva.pdf' 
WHERE pk = E'c9944ef5-6c68-409e-87a3-ee22c9345303' ;
UPDATE drugs.brand SET product_information_filename = E'chpmelox.pdf' 
WHERE pk = E'2bfdaa8a-406a-436c-a2d2-715d22914ff1' ;
UPDATE drugs.brand SET product_information_filename = E'chpmelox.pdf' 
WHERE pk = E'0ff1260c-fdf1-436d-a593-8917a2f0c87d' ;
UPDATE drugs.brand SET product_information_filename = E'chpenala.pdf' 
WHERE pk = E'8f9b13bd-b392-4d34-939b-ed7b1a4f1409' ;
UPDATE drugs.brand SET product_information_filename = E'chpenala.pdf' 
WHERE pk = E'1f3e4c88-fa81-4125-9dd7-72b354f84e88' ;
UPDATE drugs.brand SET product_information_filename = E'chpenala.pdf' 
WHERE pk = E'b382c7d4-1d29-4313-bc7e-a8dc1cfea2d6' ;
UPDATE drugs.brand SET product_information_filename = E'chpamoxs.pdf' 
WHERE pk = E'cda4feaa-82ee-4825-9eb8-8084c44c2969' ;
UPDATE drugs.brand SET product_information_filename = E'chpamoxs.pdf' 
WHERE pk = E'843fef16-b468-4473-8483-7e6fcd68b7a2' ;
UPDATE drugs.brand SET product_information_filename = E'chpalpra.pdf' 
WHERE pk = E'3ca1770c-a438-4909-9069-4b97e55b3275' ;
UPDATE drugs.brand SET product_information_filename = E'chpalpra.pdf' 
WHERE pk = E'0bd9b711-b43b-47f2-a71a-373ec2c86416' ;
UPDATE drugs.brand SET product_information_filename = E'chpacicl.pdf' 
WHERE pk = E'0ffe64c2-e62d-4014-b472-7656bc580003' ;
UPDATE drugs.brand SET product_information_filename = E'chppanto.pdf' 
WHERE pk = E'3bda5062-92a6-436a-9beb-fd183fad5392' ;
UPDATE drugs.brand SET product_information_filename = E'chppanto.pdf' 
WHERE pk = E'cc4fd4a1-afa2-4cfe-9dd8-82bffcefc49d' ;


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 201);

