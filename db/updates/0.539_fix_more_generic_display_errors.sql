-- a bit more updating of product strenghs to make future parsing easier visually
update drugs.product set strength ='10mg/ml' where pk = '86a56191-ddf9-4342-901a-44c7ed88e114'; -- physeptone
update drugs.product set strength ='10mg/ml' where pk = '44d93e69-7afb-431e-a6cf-24c6eca64626'; -- morphine
update drugs.product set strength ='15mg/ml' where pk = '92123297-a4ec-444c-b291-5299c556b8c6';  -- morphine
update drugs.product set strength ='15mg/ml' where pk = '04267387-6b29-47c9-950b-10d4d0ea7a1e';  -- morphine
update drugs.product set strength ='50mg/ml' where pk = '2e93ac6f-d050-441a-ba52-c73779d8dd8b';  -- nandrolone
update drugs.product set strength ='12.5mg/ml' where pk = '08e64d10-4e2d-4ee0-b7f1-68931da23e35';  -- fix stemetil injection
update drugs.product set strength ='5mg/ml' where pk = '0d9f79db-8665-46bb-a3c2-70a6195d4c06';  -- fix haloperidol injection
update drugs.product set strength ='5mg/ml' where pk = 'ee790301-f0e5-4c3b-baee-34c332e35d8c';  -- fix  tetracosactrin injection
update drugs.product set strength ='150mg/ml' where pk = '90e566e2-1def-4524-a02e-0f61f10ada5f';  -- update progesterone injection
update drugs.product set strength ='200mg/ml' where pk = '23085399-79bd-424b-83b4-3ec5ceafeac5';  -- update zuclopenthixol depot
update drugs.product set strength ='20mg/ml' where pk = '974ff5c4-d142-4149-a60c-890fb9dc3891'; -- fix glatiramer acetate syringe to mg/ml

 update db.lu_version set lu_minor=539;