-- gradually fixing more generic errors during June 2018 release.
update drugs.product set strength ='1mg/ml' where pk = 'ed888815-ddf2-4bc2-b2f9-3bc9835f7de5'; -- fix adrenaline strength per ml
update drugs.product set strength ='2mg/ml' where pk = '19509460-c962-4ea2-8c70-095dc7de54a5';  -- fix bisacodyl strengh per ml
update drugs.product set strength ='50mg/ml' where pk = '27b8a220-69e2-40aa-926d-f57a93f84db3';-- fix strengh per ml haloperidol injection
update drugs.product set strength ='2mg/ml' where pk = 'ad1dae4a-235c-42ac-beeb-e11da88463d7';-- dilaudad make 2mg/ml instead of just 2mg
update drugs.product set strength ='10mg/ml' where pk = '51d50dc8-869e-49fd-8def-a8c1a9f429cd';-- dilaudad-HP make 10mg/ml
update drugs.product set strength ='1mg/ml' where pk = '072defaf-6aa0-4045-ad71-c73a70b521a6';--  fix B12 to 1mg/ml instead of 1mg
update drugs.product set strength ='150mg/ml' where pk = 'ab9fb392-5c88-40c7-b36f-c169864decc2';-- fix "secukinmab" strength to 150mg/ml
update drugs.product set strength ='10mg/ml' where pk = 'a8fd09c4-2367-41df-b578-62f343b3c60f'; -- fix morphine to 10mg/ml
update drugs.product set strength ='20mg/ml' where pk = 'b14b3ad9-6a26-4b48-986f-5e106a614135';  -- fix morphine to 20mg/ml
update drugs.product set strength ='400mcg/ml' where pk = '331c4a9c-6ee1-4835-a375-d527bce8a6e0'; -- fix naloxone to 400mcg/ml
update drugs.product set strength ='200mg/ml' where pk = 'c5283b08-f075-4b0b-8334-a540bedc59bb';  -- fix certolizumab pegol syringe to mg/ml
update drugs.product set strength ='50mcg/ml' where pk = '2e774340-36bb-41d1-8346-3ca47e64f25f';  -- fix octreotide injection to 50mcg/ml
update drugs.product set strength ='100mcg/ml' where pk = '5918aca3-81c5-4855-998f-b28f2012112c';  -- octreotide injection to 100mcg/ml
update drugs.product set strength ='100mcg/ml' where pk = '360c2265-b309-4f52-9180-8c9f05c203cb'; -- octreotide injection to 500mcg/ml
update drugs.product set strength ='125mg' where pk = '0c5fd53e-753f-42eb-9c3b-57774b61eb17';  -- fix bosentan from 126mg to 125mg
update drugs.product set strength ='150mg/ml' where pk = '8f988124-8273-429d-91ce-5e673441b4e5';  -- fix omalizumab injection to 150mg/ml

 update db.lu_version set lu_minor=538;