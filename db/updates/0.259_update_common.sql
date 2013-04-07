drop table common.lu_recreationaldrugs;

Create table common.lu_recreational_drugs
(pk serial primary key,
drug text not null,
alternative_names text default null,
default_fk_lu_route_administration integer not null,
quantification text default null,
illicit boolean not null default true,
 CONSTRAINT common_lu_recreational_drugs_default_fk_lu_route_administration  FOREIGN KEY (default_fk_lu_route_administration )
      REFERENCES common.lu_route_administration (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION

);

ALTER TABLE common.lu_recreational_drugs OWNER TO easygp;
GRANT ALL ON TABLE common.lu_recreational_drugs TO easygp;
GRANT SELECT ON TABLE common.lu_recreational_drugs TO staff;


comment on table common.lu_recreational_drugs is 'A list of common recreational drugs';
comment on column common.lu_recreational_drugs.alternative_names is 'a space-separated list of alternative names or subtypes';
comment on column common.lu_recreational_drugs.illicit is 'true if illegal to use recreationally in most Australian jurisdictions';
comment on column common.lu_recreational_drugs.quantification is 'how to quantify eg cig/day or gm/day';

--  route_administration_intramuscular As Integer = 1
--  route_administration_subcutaneous As Integer = 2
--  route_administration_intramuscular_or_subcutaneous As Integer = 3
--  route_administration_intradermal As Integer = 4
--  route_administration_oral As Integer = 5
--  route_administration_intranasal As Integer = 6
--  route_administration_inhaled As Integer = 7
--  route_administration_topical As Integer = 8
--  route_administration_intravenous As Integer = 11

Insert into common.lu_recreational_drugs (drug, alternative_names, default_fk_lu_route_administration,quantification, illicit) values ('nicotine','cigarette cigar rollies chop-chop',7,'cig or equiv',false);
Insert into common.lu_recreational_drugs (drug, alternative_names, default_fk_lu_route_administration,quantification, illicit) values ('alcohol','ethanol booze piss goon drink mixers',5,'grams',false);
Insert into common.lu_recreational_drugs (drug,alternative_names, default_fk_lu_route_administration,quantification, illicit) values ('opiate', 'heroin morphine oxycodone oxies smack shit ms-contin',11, 'mg',true);
Insert into common.lu_recreational_drugs (drug,alternative_names, default_fk_lu_route_administration,quantification, illicit) values ('cocaine','crack rock coke powder', 6,'',true);
Insert into common.lu_recreational_drugs (drug,alternative_names, default_fk_lu_route_administration,quantification, illicit) values ('caffeine','coffee', 5,'cups',false);
Insert into common.lu_recreational_drugs (drug,alternative_names, default_fk_lu_route_administration,quantification, illicit) values ('cannabis', 'THC skunk weed grass green bud synthetic-cannabis mary-jane wacky-baccy', 7,'grams',true);
-- God only knows what "synthetic cannabis" actually is!
Insert into common.lu_recreational_drugs (drug,alternative_names, default_fk_lu_route_administration,quantification, illicit) values ('benzodiazepines','valium xanax mogadon moggies serepax serries', 5,'milligrams',true);
Insert into common.lu_recreational_drugs (drug,alternative_names, default_fk_lu_route_administration,quantification, illicit) values ('inhalants','solvents glue', 7,'sessions',false);
Insert into common.lu_recreational_drugs (drug,alternative_names, default_fk_lu_route_administration,quantification, illicit) values ('petrol','fuel gas', 7,'sessions',false);
insert into common.lu_recreational_drugs (drug,alternative_names, default_fk_lu_route_administration,quantification, illicit) values  ('amphetamine', 'metamphetamine ice speed methylphenidate ritalin looey', 11,'',true);
-- contrary to the firm belief of many users there is no effective difference between
-- "speed" and "ice": the same mixture of amphetamines created in the backyard lab
-- will be sold by dealers as "ice" to increase cachet (and so value)
Insert into common.lu_recreational_drugs (drug,alternative_names, default_fk_lu_route_administration,quantification, illicit) values ('psychedelics','LSD angel-dust acid shrooms mushies', 5,'times',true);
-- technically angel dust is phencycline, and mushrooms may contain a 
-- variety of compounds, chiefly mescaline, but again clinically it doesn't really make
-- a difference
insert into common.lu_recreational_drugs (drug,alternative_names, default_fk_lu_route_administration,quantification, illicit) values ('MDMA','xtc ecstasy extasy', 5,'tablets',true);
-- in practice "ecstasy" often has the same issue as "ice": whatever claimed by the dealer
-- the pill will usually contain plain old amphetamine
Insert into common.lu_recreational_drugs (drug,alternative_names, default_fk_lu_route_administration,quantification, illicit) values ('kava','', 5,'',false);
Insert into common.lu_recreational_drugs (drug,alternative_names, default_fk_lu_route_administration,quantification, illicit) values ('ketamine','special k', 11,'',false);
-- yes it is legal, apparently

Create or replace view common.vwRecreationalDrugs as
SELECT 
  common.lu_recreational_drugs.pk, 
  common.lu_recreational_drugs.drug, 
  common.lu_route_administration.route, 
  common.lu_recreational_drugs.alternative_names, 
  common.lu_recreational_drugs.illicit, 
  common.lu_recreational_drugs.quantification,
  common.lu_recreational_drugs.default_fk_lu_route_administration
FROM 
  common.lu_route_administration, 
  common.lu_recreational_drugs
WHERE 
  common.lu_recreational_drugs.default_fk_lu_route_administration = lu_route_administration.pk;


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 259);


