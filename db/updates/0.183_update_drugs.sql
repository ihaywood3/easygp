-- various fixes to the non-PBS drugs
delete from drugs.brand where fk_product='73081f1e-67ab-5f99-a95d-fd61f9b240f9';
delete from drugs.product where pk='73081f1e-67ab-5f99-a95d-fd61f9b240f9';
delete from drugs.brand where fk_product='4d817944-6d26-501e-ae3d-a1007813e60f';
delete from drugs.product where pk='4d817944-6d26-501e-ae3d-a1007813e60f';
update drugs.product set salt='besylate',generic='atracurium' where pk='097a5859-a2c0-5b68-8816-f6ceb75d293b';
update drugs.product set strength='10mg/ml',salt='besylate' where pk='879d1894-e6be-53a9-8671-3a70002862cf';
update drugs.product set atccode='N01BB01', salt='hydrochloride',generic='bupivacaine' where generic = 'bupivacaine hydrochloride';
update drugs.product set atccode='D11AC01' where generic = 'cetrimide;lignocaine';
update drugs.product set atccode='D07AB08' where pk='6d33c1db-aad9-51ff-b39d-be7c2910b169';
update drugs.product set atccode='D07AB08' where pk='ac2b5bc9-099f-5474-bccd-e30ab5496d88';
update drugs.product set fk_form=33 where pk='9ae303ff-fed3-5637-aaf4-ed7bdee791c3';
update drugs.product set atccode='A16AB09' where pk='47e79460-28f6-5eaa-a444-606a70af4aa4'; 
update drugs.product set atccode='N04AA04',salt='hydrochloride',generic='procyclidine' where pk='f79e6b89-e3cb-51dc-8f02-cb81a08b9c17';


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 183);

