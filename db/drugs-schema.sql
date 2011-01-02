

create schema drugs;
alter schema drugs owner to easygp;

SET search_path = drugs, pg_catalog;

comment on schema drugs is '
This schema is based on original DDL structure of drug database for the gnumed project
Copyright 2000, 2001, 2002, 2010 by Dr. Horst Herb, Dr. Ian Haywood
';


-- ===========================================
create table sources(
	pk serial primary key,
	source_category char check (source_category in ('p', 'a', 'i', 'm', 'o', 's')) not null,
	description text not null
);

comment on table sources is
	'Source of any reference information in this database';
comment on column sources.source_category is
	'p=peer reviewed, a=official authority, i=independent source, m=manufacturer, o=other, s=self defined';
comment on column sources.description is
	'URL or address or similar informtion allowing to reproduce the source of information';

copy sources(description,source_category) from stdin with delimiter as '|';
Manufacturer''s paper handout|m
PBS Yellow Book Caution|a
Australian Prescriber|a
DailyMed (http://dailymed.nlm.nih.gov)|m
\.

-- ===========================================
create table patient_categories(
	pk serial primary key,
	description text not null,
	"comment" text
);
comment on table patient_categories is
	'enumeration of categories of patient populations for targeted drug warnings';

create table evidence_levels
(
	pk serial primary key,
	description text not null
);

comment on table evidence_levels is 
       'different levels of evidence for a fact in the database';


-- ===========================================
create table severity_level (
	pk serial primary key,
	description varchar (100) not null,
	"comment" text
);

comment on table severity_level is
        'different level of severity for warnings. Levels may control client behaviour';

copy severity_level(pk,description) from stdin with delimiter as '|';
1|noting only
2|mild effects, requires simple clinical action
3|significant but temporary effects
4|severe morbidity
5|risk of death
\.

 --=========================================================

create table clinical_effects
(
	pk serial primary key,
	description text unique,
	fk_severity integer references severity_level (pk) not null
);

comment on table clinical_effects is 
'A list of side-effects and consequences of interactions.
I appreciate this list will get long, some values may only apply to one or two drugs, but
I think it is important to normalise. The interface may need to use a text box (it will be
too long for a pick list) and confirm with users if they want to create a new entry.';


copy clinical_effects(description,fk_severity) from stdin with delimiter '|';
increase in INR|2
sharp decrease in INR|2
increase in plasma concentration
-- ==================================================================

create table pharmacologic_mechanisms
(
	pk serial primary key,
	description text not null
);


-- ===================================================================
create table topic
(
	pk serial primary key,
	title varchar (60) not null,
	target char check (target in ('h', 'p')) not null
);

comment on table topic is 'topics for drug information, such as pharmaco-kinetics, indications, etc.';

comment on column topic.target is
	'the target of this information: h=health professional, p=patient';

-- ==============================================================

create table atc (
	atccode varchar(8) primary key,
        "name" text not null
);

comment on table atc is
	'table associating drug names and ATC codes';

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
        paed_dose float
        paed_max float
);
comment on table info is
	'any product information about a specific drug or class in HTML format';
comment on column info.comment is
	'the drug product information in HTML format';

create table link_atc_info (
       atccode varchar(8) not null,
       fk_info integer references info (pk) not null
);

comment on table link_atc_info is
       'links one or more ATC codes (i.e. drugs or classes) to a piece of information. Generally one 
link, but for interactions or contraindications there may be more';

-- ===========================================
create table product(
        pk serial primary key,
	atccode varchar (8) not null,
	"name" text not null,
	salt text,
	fk_form integer references form (pk) not null,
	strength text,
        salt_strength text,
	amount text, 
	packsize integer not null default 1, 
        original_text text,
	original_pbs_code varchar(10),
        original_tga_code varchar(12)
        unique (atccode,"name",description,packsize)
);

comment on table product is
'dispensable form of a generic drug including strength, package size etc';

-- ===========================================
create table flags (
	pk serial primary key,
	description varchar (100)
);

comment on table flags is
	'flags for adjuvants such as ''gluten-free'', ''paediatric formulation'', etc.';

-- ===========================================
create table link_flag_product (
	fk_product integer references product (pk) not null,
	fk_flag integer references flags (pk) not null
);

comment on table link_flag_product is
	'many-to-many pivot table linking products to flags';


-- ===========================================
create table manufacturer(
	pk serial primary key,
	"name" varchar(100) unique,
	address text,
	telephone text,
	facsimile text,
	code char (2) unique
);

comment on table manufacturer is
	'list of pharmaceutical manufacturers';
comment on column manufacturer.name is
	'company name';
comment on column manufacturer.address is
	E'complete printable address with embeded newline characters as "\\n"';
comment on column manufacturer.telephone is
	'phone number of company';
comment on column manufacturer.facsimile is
	'fax number of company';
comment on column manufacturer.code is
	'two-letter symbol of manufacturer';

-- ===========================================
create table brand(
	fk_product integer references product(pk) not null,
	fk_manufacturer integer not null, -- references manufacturer(pk)
	brand varchar (80) not null,
	price money,
        from_pbs boolean default 'f'
);

comment on table brand is
	'many to many pivot table linking drug products and manufacturers';

comment on column brand.from_pbs is 
         'true if the brand comes from the PBS database, allows the list to be easily reloaded
with new PBS data. False means data we added ourselves.';


-- ===========================================

create table pbs (
        fk_product integer references product (pk) not null,
	quantity integer default 1 not null,
	max_rpt integer default 0 not null,
	pbscode varchar(10) not null,
	chapter varchar(2) not null,
        restrictionflag char not null default 'U'
);

comment on table pbs is
	'PBS-specific information about subsidy, authority riles, etc. Private-script only drugs wont have a entry in this table.';
comment on column pbs.restrictionflag is
        'U=unrestricted, R=restricted, A=authority, S=streamlined'; 
comment on column pbs.quantity is
'quantity of packaged units dispensed under subsidy for any one prescription. 
AU: this the maximum quantity in the PBS Yellow Book.';
comment on column pbs.max_rpt is
	'maximum number of repeat (refill) authorizations allowed on any one subsidised prescription (series)';

create table restriction (
    pbscode varchar (10) not null,
    comment text not null,
    code varchar(10) not null
);

comment on table restriction is 
     'list of PBS restrictions and authority warnings';

comment on column restriction.code is
   'the authority code number, for doing streamlined authorities';

comment on column restriction.comment is 
   'the actual text of the authority requirement';