-- Ian has started work on allergies

drop table clin_allergies.lu_type;
alter table clin_allergies.allergies alter column fk_reaction set data type integer using 0;
alter table clin_allergies.allergies add constraint "allergies_fk_reaction" foreign key (fk_reaction) references clin_allergies.lu_reaction (pk);
alter table clin_allergies.allergies add constraint "allergies_fk_consult" foreign key (fk_consult) references clin_consult.consult(pk);
alter table clin_allergies.allergies drop column generic;
alter table clin_allergies.allergies drop column fk_type;
alter table clin_allergies.allergies add column atc text references drugs.atc (atccode);
alter table clin_allergies.allergies add column date_reaction date;
alter table clin_allergies.allergies alter column fk_consult set not null;
alter table clin_allergies.allergies alter column generic_specific set not null;
alter table clin_allergies.allergies alter column deleted set not null;
alter table clin_allergies.allergies alter column atc set not null;

insert into clin_allergies.lu_reaction(pk,reaction) values (1,'anaphalaxis');
insert into clin_allergies.lu_reaction(pk,reaction) values (2,'generalised rash with wheeze');
insert into clin_allergies.lu_reaction(pk,reaction) values (3,'generalised rash');
insert into clin_allergies.lu_reaction(pk,reaction) values (4,'localised rash');
insert into clin_allergies.lu_reaction(pk,reaction) values (5,'nausea/vomiting');
insert into clin_allergies.lu_reaction(pk,reaction) values (6,'unknown/uncertain');

create or replace view clin_allergies.vwallergies as select 
     ccc.fk_patient as fk_patient,
     ccc.pk as fk_consult,
     caa.generic_specific as generic_specific,
     ccc.fk_staff as fk_staff,
     caa.brand as brand,
     caa.atc as atc,
     caa.fk_reaction as fk_reaction,
     car.reaction as reaction,
     datc.atcname as atcname,
     cdp.surname as surname,
     cdp.firstname as firstname,
     caa.date_reaction as date_reaction
from
	drugs.atc datc,
	clin_allergies.allergies caa,
	clin_allergies.lu_reaction car,
	clin_consult.consult ccc,
	admin.staff ast,
        contacts.data_persons cdp
where
	datc.atccode = caa.atc and
	caa.fk_consult = ccc.pk and
	ccc.fk_staff = ast.pk and
	cdp.pk = ast.fk_person and
	car.pk = caa.fk_reaction and
        not caa.deleted;
	
truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 184);

