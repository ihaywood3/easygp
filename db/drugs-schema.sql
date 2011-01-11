drop schema drugs cascade;

create schema drugs;

SET search_path = drugs, pg_catalog;

comment on schema drugs is '
This schema is based on original proposed structure of drug database for the gnumed project
Copyright 2000-02 Dr. Horst Herb
Copyright 2010-11 Dr. Ian Haywood
';


-- ===========================================
create table sources(
	pk integer primary key,
	source_category char check (source_category in ('p', 'a', 'i', 'm', 'o', 's')) not null,
	"source" text not null
);

comment on table sources is
	'Source of any reference information in this database';
comment on column sources.source_category is
	'p=peer reviewed, a=official authority, i=independent source, m=manufacturer, o=other, s=self defined';
comment on column sources."source" is
	'URL or address or similar informtion allowing to reproduce the source of information';

copy sources(pk,"source",source_category) from stdin with delimiter as '|';
1|Manufacturer''s paper handout|m
2|PBS Yellow Book Caution|a
3|Australian Prescriber|a
4|DailyMed (http://dailymed.nlm.nih.gov)|m
\.

-- ===========================================
create table patient_categories(
	pk integer primary key,
	"category" text not null
);
comment on table patient_categories is
	'enumeration of categories of patient populations for targeted drug warnings';

copy patient_categories(pk,"category") from stdin with delimiter as '|';
1|renal impairment
2|hepatic impairment
3|elderly
4|child
5|pregnant
6|breastfeeding
\.

create table evidence_levels
(
	pk integer primary key,
	evidence_level text not null
);

comment on table evidence_levels is 
       'different levels of evidence for a fact in the database';

copy evidence_levels(pk,evidence_level) from stdin with delimiter as '|';
1|multiple controlled studies
2|multiple case-reports
3|single case-report
4|pharmacological theory (too dangerous to test)
5|pharmacological assumption
6|no evidence of safety
7|expert consenus
8|established clinical experience
\.

-- ===========================================
create table severity_level (
	pk integer primary key,
	severity text not null
);

comment on table severity_level is
        'different level of severity for warnings. Levels may control client behaviour';

copy severity_level(pk,severity) from stdin with delimiter as '|';
1|noting only
2|mild effects, requires simple clinical action
3|significant but reversible effect
4|severe morbidity, not reversible
5|risk of death
\.

 --=========================================================

create table clinical_effects
(
	pk serial primary key,
	effect text unique not null,
	fk_severity integer references severity_level (pk) not null
);

comment on table clinical_effects is 
'A list of side-effects and consequences of interactions.
I appreciate this list will get long, some values may only apply to one or two drugs, but
I think it is important to normalise. The interface may need to use a text box (it will be
too long for a pick list) and confirm with users if they want to create a new entry.';


copy clinical_effects(effect,fk_severity) from stdin with delimiter '|';
increase in INR|2
sharp decrease in INR|2
increase in plasma concentration|2
rash|2
Stevens-Johnson syndrome|4
diarrhoea|2
loss of contraceptive effect|4
constipation|2
nausea|1
vomiting|3
dizziness|2
postural hypotension|3
\.
-- ==================================================================

create table pharmacologic_mechanisms
(
	pk integer primary key,
	mechanism text not null
);

copy pharmacologic_mechanisms(pk, mechanism) from stdin with delimiter '|';
1|competition for renal extraction
2|competition for hepatic metabolic pathway
3|induction of hepatic metaboilsm
4|competition for plasma-protein binding site
5|pharmacodynamic opposition (different receptor)
6|competition for target receptor
7|pharmacodynamic synergy (different receptor)
8|pharmcodynamic synergy (same receptor)
9|other
10|unknown
\.

-- ===================================================================
create table topic
(
	pk integer primary key,
	title varchar (60) not null,
	target char check (target in ('h', 'p')) not null
);

comment on table topic is 'topics for drug information, such as pharmaco-kinetics, indications, etc.';

comment on column topic.target is
	'the target of this information: h=health professional, p=patient';

copy topic(pk,title,target) from stdin with delimiter '|';
1|synposis|h
2|indication|h
3|dosage and titration|h
4|warning|h
5|contraindication|h
6|interaction|h
7|chemical structure|h
8|side-effects|p
9|instructions|p
10|reason for use|p
11|introduction|p
\.

-- ==============================================================

create table atc (
	atccode text primary key,
        atcname text not null
);

comment on table atc is
	'table associating drug names and Anatomic Therapeutic Chemical (ATC) codes';

-- ===========================================
create table info(
        pk serial primary key,
	"comment" text not null,
	fk_topic integer references topic (pk) not null,
        created_at timestamp default now () not null,
        fk_clinical_effect integer references clinical_effects (pk),
        fk_pharmacologic_mechanism integer references pharmacologic_mechanisms (pk),
        fk_evidence_level integer references evidence_levels (pk) not null,
        fk_source integer references sources (pk) not null,
        fk_patient_category integer references patient_categories (pk),
	standard_frequency text,
        paed_dose float,
        paed_max float
);
comment on table info is
	'any product information about a specific drug or class in HTML format';
comment on column info.comment is
	'the drug product information in HTML format';

create table link_atc_info (
       atccode text not null references atc(atccode),
       fk_info integer references info (pk) not null
);

comment on table link_atc_info is
       'links one or more ATC codes (i.e. drugs or classes) to a piece of information. Generally one 
link, but for interactions or contraindications there may be more';

create table link_category_info (
       fK_category integer references patient_categories(pk),
       fk_info integer references info (pk)
);

comment on table link_category_info is 'links information to a particular category: information only applies to 
this categoery.';


-- ===========================================
create table form (
	pk integer primary key,
	form text not null
);

copy form(pk,form) from stdin with delimiter '|';
2|bandage
3|capsule
4|cartridge
5|chewing gum
6|cream
7|dispersible tablet
8|dressing
9|ear drops
10|effervescent granules
11|enema
12|eye disc
13|eye drops
14|eye paste
1|eye ointment
15|eye spray
16|film
17|gas
18|glove
19|granules
20|implant
21|inhaler
22|inj
23|insert
24|intrauterine implant
25|kit
26|lotion
27|lozenge
28|mouthwash
29|nasal ointment
30|nasal solution
31|nasal spray
32|nebule
33|topical ointment
34|oral gel
35|oral liquid
36|oral powder
37|oral solution
38|oral spray
39|pack
40|pad
41|paint
42|paste
43|patch
44|pen
45|pessary
46|powder for inhalation
47|roll
48|rope
49|shampoo
50|sheet
51|slow-release capsule
52|slow-release tablet
53|spray
54|stick
55|sublingual spray
56|sublingual tablet
57|suppository
58|syringe
59|tablet
60|test strip
61|topical gel
62|topical powder
63|topical solution
64|topical spray
65|transdermal gel
66|wafer
67|ear ointment
\.

create table product(
        pk serial primary key,
	atccode varchar (8) not null,
	generic text not null,
	salt text,
	fk_form integer references form (pk) not null,
	strength text,
        salt_strength text,
        original_pbs_name text,
        original_pbs_fs text,
	free_comment text,
        updated_at timestamp default now(),
        unique (atccode,generic,fk_form,strength)
);

comment on table product is
'dispensable form of a generic drug including strength, package size etc';

comment on column product.generic is 'full generic name in lower-case. For compounds names separated by ";"';
comment on column product.salt is 'if not normally part of generic name, the adjuvant salt';
comment on column product.fk_form is 'the form of the drug';
comment on column product.strength is 'the strength as a number followed by a unit. For compounds
strengths are separated by "-", in the same order as the names of the consitituents in the generic name';
comment on column product.salt_strength is 'where a weight of the full salt is listed (being heavier than the weight 
of the solid drug. Must be in same unit';
comment on column product.original_pbs_name is 'for a drug imported from the PBS Yellow Book database, the original 
generic name as there listed, otherwise NULL';
comment on column product.original_pbs_fs is 'for a drug imported from the PBS Yellow Book database, the original 
form-and-strength field as there listed, otherwise NULL';
comment on column product.free_comment is 'a free-text comment on properties of the product. For example for complex packages
with tablets lof differing strengths';

create table pack (
      fk_product integer references product(pk),
      amount float,
      amount_unit integer, --references common.lu_units(pk), 
      packsize integer default 1
); 

comment on column pack.amount is 'the amount of drugs that have a fluid form';
comment on column pack.packsize is 'the number of identical units (bottles, vials, tablets, etc) within a pack';

-- ===========================================
create table flags (
	pk serial primary key,
	description varchar (100)
);

comment on table flags is
	'flags for adjuvants such as ''gluten-free'', ''paediatric formulation'', etc.';

copy flags(pk,description) from stdin with delimiter '|';
1|gluten-free
2|with diluent syringe
3|with diluent ampoule
4|contains gluten
5|orange flavour
6|blackcurrent flavour
7|banana flavour
8|chocolate flavour
\.

create table link_flag_product (
	fk_product integer references product (pk) not null,
	fk_flag integer references flags (pk) not null
);

comment on table link_flag_product is
	'many-to-many pivot table linking products to flags';

-- ===========================================
create table company(
	company text unique not null,
	address text,
	telephone text,
	facsimile text,
	code varchar (3) primary key
);

comment on table company is
	'list of pharmaceutical manufacturers/importers';
comment on column company.company is
	'company name';
comment on column company.address is
	E'complete printable address, lines separated by commas';
comment on column company.telephone is
	'phone number of company';
comment on column company.facsimile is
	'fax number of company';
comment on column company.code is
	'Two- or three-letter guaranteed-unique code of company. Two-letter codes come
from the PBS system. Three-letter codes assigned by me for companies that only produce non-PBS drugs';

-- ===========================================
create table brand(
	fk_product integer references product(pk) not null,
	fk_company varchar(3) not null references company(code),
	brand varchar (100) not null,
	price money,
        from_pbs boolean not null default 'f',
        original_tga_text text,
        original_tga_code varchar(12)
);

comment on table brand is
	'many to many pivot table linking drug products and manufacturers';
comment on column brand.from_pbs is 
         'true if the brand comes from the PBS database, allows the list to be easily reloaded
with new PBS data. False means data we added ourselves.';
comment on column brand.price is 'dispensed price for PBS drugs.';
comment on column brand.original_tga_text is 'drugs imported from TGA database, the original label therein';
comment on column brand.original_tga_code is 'drugs imported from TGA database, their TGA code';

-- ===========================================

create table pbs (
        fk_product integer references product (pk) not null,
	quantity integer default 1 not null,
	max_rpt integer default 0 not null,
	pbscode varchar(10) not null,
	chapter varchar(2) not null,
        restrictionflag char not null default 'U',
        check (restrictionflag in ('U','R','A'))
);

comment on table pbs is
	'PBS-specific information about subsidy, authority riles, etc. Private-script only drugs wont have a entry in this table.';
comment on column pbs.restrictionflag is
        'U=unrestricted, R=restricted, A=authority'; 
comment on column pbs.quantity is
'quantity of packaged units dispensed under subsidy for any one prescription. 
AU: this the maximum quantity in the PBS Yellow Book.';
comment on column pbs.max_rpt is
	'maximum number of repeat (refill) authorizations allowed on any one subsidised prescription (series)';

create table restriction (
    pbscode varchar (10) not null,
    restriction text not null,
    restriction_type char default '3' not null,
    code varchar(10) not null,
    streamlined boolean default false not null
);

comment on table restriction is 
     'list of PBS restrictions and authority warnings';

comment on column restriction.code is
   'the authority code number, for doing streamlined authorities';

comment on column restriction.restriction is 
   'the actual text of the authority requirement, in basic HTML';

comment on column restriction.restriction_type is
    '1=only applies to increased quantities/repeats, 2=only to normal amounts, 3=to both'; 

comment on column restriction.streamlined is 'true if this is a "streamlined" Authority'; 