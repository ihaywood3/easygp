alter table drugs.pbsconvert drop column route;
insert into drugs.pbsconvert(fs,done,form,dose,packsize,amount,"comment") values ('Sachets 34 g, 30','t','oral powder','34g',30,'','');
insert into drugs.pbsconvert(fs,done,form,dose,packsize,amount,"comment") values ('Capsule 3 mg','t','capsule','3mg',1,'','');
insert into drugs.pbsconvert(fs,done,form,dose,packsize,amount,"comment") values ('Powder for injection 1200 IU with solvent','t','injection','1200iu',1,'','with solvent');
insert into drugs.pbsconvert(fs,done,form,dose,packsize,amount,"comment") values ('Powder for injection 600 IU with solvent','t','injection','600iu',1,'','with solvent');
insert into drugs.pbsconvert(fs,done,form,dose,packsize,amount,"comment") values ('Injection 200 mg (as sodium) in 1 mL','t','injection','200mg',1,'','as sodium');
insert into drugs.pbsconvert(fs,done,form,dose,packsize,amount,"comment") values ('Powder for injection 3 g-100 mg','t','injection','3g-100mg',1,'','');
insert into drugs.pbsconvert(fs,done,form,dose,packsize,amount,"comment") values ('Powder for oral suspension 125 mg (base) per 5 mL, 70 mL','t','oral solution','25mg/ml',1,'70ml','as powder');
insert into drugs.pbsconvert(fs,done,form,dose,packsize,amount,"comment") values ('Powder for injection 1 g (as hydrochloride)','t','injection','1g',1,'','as hydrochloride');
insert into drugs.pbsconvert(fs,done,form,dose,packsize,amount,"comment") values ('Powder for injection 2 g (as hydrochloride)','t','injection','2g',1,'','as hydrochloride');
insert into drugs.pbsconvert(fs,done,form,dose,packsize,amount,"comment") values (' Lozenge 200 micrograms (as citrate)','t','lozenge','200mcg',1,'','as citrate');
insert into drugs.pbsconvert(fs,done,form,dose,packsize,amount,comment) values ('Lozenge 200 micrograms (as citrate)','t','lozenge','200mcg',1,'','as citrate');
insert into drugs.pbsconvert(fs,done,form,dose,packsize,amount,"comment") values ('Lozenge 400 micrograms (as citrate)','t','lozenge','400mcg',1,'','as citrate');
insert into drugs.pbsconvert(fs,done,form,dose,packsize,amount,"comment") values ('Lozenge 600 micrograms (as citrate)','t','lozenge','600mcg',1,'','as citrate');
insert into drugs.pbsconvert(fs,done,form,dose,packsize,amount,"comment") values ('Lozenge 800 micrograms (as citrate)','t','lozenge','800mcg',1,'','as citrate');
insert into drugs.pbsconvert(fs,done,form,dose,packsize,amount,"comment") values ('Lozenge 1200 micrograms (as citrate)','t','lozenge','1200mcg',1,'','as citrate');
insert into drugs.pbsconvert(fs,done,form,dose,packsize,amount,"comment") values ('Lozenge 1600 micrograms (as citrate)','t','lozenge','1600mcg',1,'','as citrate');
insert into drugs.pbsconvert(fs,done,form,dose,packsize,amount,"comment") values ('Dressings 4 cm, 10','t','dressing','',10,'','4cm');
insert into drugs.pbsconvert(fs,done,form,dose,packsize,amount,"comment") values ('Dressings 5.5 cm, 10','t','dressing','',10,'','5.5cm');
insert into drugs.pbsconvert(fs,done,form,dose,packsize,amount,"comment") values ('Tablet 1 mg (as mesilate)','t','tablet','1mg',1,'','as mesilate');
insert into drugs.pbsconvert(fs,done,form,dose,packsize,amount,"comment") values ('Injection 30 mg (as acetate) in 3 mL single use pre-filled syringe','t','syringe','30mg',1,'3ml','as acetate, in single use pre-filled');
insert into drugs.pbsconvert(fs,done,form,dose,packsize,amount,"comment") values ('Tablet 90 mg','t','tablet','90mg',1,'','');
insert into drugs.pbsconvert(fs,done,form,dose,packsize,amount,"comment") values ('Pack containing 280 capsules containing powder for inhalation 40 mg and 2 inhalers','t','powder for inhalation','40mg',280,'','as capsules, with 2 inhalers');

insert into drugs.pbsconvert(fs,done,form,dose,packsize,amount,"comment") values ('Ear drops, ortho-dichlorobenzene 140 mg per mL, para-dichlorobenzene 20 mg per mL, chlorbutol 50 mg per mL, arachis oil 573 mg per mL, 10 mL','t','ear drops','140mg/ml-20mg/ml-50mg/ml-573mg/ml',1,'10ml','');
insert into drugs.pbsconvert(fs,done,form,dose,packsize,amount,"comment") values ('Eye gel 2 mg-10 mg per g (0.2%-1%), 10 g','t','eye paste','2mg/g-10mg/g',1,'10g','');
insert into drugs.pbsconvert(fs,done,form,dose,packsize,amount,"comment") values ('Eye gel 2 mg-10 mg per g (0.2%-1%), single dose units 0.6 g, 30','t','eye paste','2mg/g-10mg/g',30,'0.6g','single dose units');
insert into drugs.pbsconvert(fs,done,form,dose,packsize,amount,"comment") values ('Tablet 400 mg (as hydrochloride)','t','tablet','400mg',1,'','as hydrochloride');
insert into drugs.pbsconvert(fs,done,form,dose,packsize,amount,"comment") values ('Tablet 200 mg (as hydrochloride)','t','tablet','200mg',1,'','as hydrochloride');


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 250);
