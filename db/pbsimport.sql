-- ===============================================
-- This script imports drug data and ATC codes from
-- information as provided by the Australian authorities
-- (HIC) in the form of the PBS data updates
-- into Postgres tables
-- Based on work by Dr. Horst Herb for the gnumed project, Copyright (C) 2000-2002
-- adapted by Dr. Ian Haywood, Copyright (C) 2010

\encoding WIN1252

create  table drugs.rawpbs (
	drugtypecode char(2),
	atccode varchar(7),
	atctype char,
	atcprintopt char,
	pbscode char(5),
	restrictionflag char,
	cautionflag char,
	noteflag char,
	maxquantity int,
	numrepeats int,
	manufacturercode char(2),
	packsize int,
	markupcode char,
	dispensefee char(2),
	danger char(2),
	brandpricepremium money,
	thergrouppremium money,
	cwprice money,
	cwdprice money,
	thergroupprice money,
	thergroupdprice money,
	manufactprice money,
	manufactdprice money,
	maxvalsafetynet money,
	bioequivalence char,
	brandname text,
	genericname text,
	formandstrength text
);

-- ===============================================
-- fill the table with the current data
-- ===============================================
\copy drugs.rawpbs from 'drug.txt' with delimiter as '!'


-- ===============================================
-- fill the table with the current data
-- ===============================================
truncate drugs.atc;

\copy drugs.atc from 'atc.txt' with delimiter as '!'
update drugs.atc set "name"=trim(both from "name");

-- ===============================================
-- do the same thing with the manufacturer details
-- ===============================================

create temporary table mnfr (
	code char(2),
	"name" text,
	address text,
	telephone text,
	facsimile text
);
-- ===============================================
-- fill the table with the current data
-- ===============================================
\copy mnfr (code, "name", address, telephone, facsimile) from 'mnfr.txt' with delimiter as '!'

create temporary table mnfr_pks (code char (2), pk integer);

-- save the PKs
insert into mnfr_pks(code,pk) select m1.code, m1.pk from 
                 drugs.manufacturer m1, mnfr where mnfr.code = m1.code;
-- delete all entries matching the codes in the new PBS data
delete from drugs.manufacturer using mnfr where drugs.manufacturer.code = mnfr.code;
-- insert new entries using the old PKs
insert into drugs.manufacturer (pk,code,"name",address,telephone,facsimile)
    select mnfr_pks.pk, mnfr_pks.code, mnfr."name", mnfr.address, mnfr.telephone, mnfr.facsimile
    from mnfr_pks, mnfr
    where mnfr_pks.code = mnfr.code;
-- then delete them back in mnfr, leaving new PBS manufacturers
delete from mnfr using drugs.manufacturer m1 where mnfr.code = m1.code;
-- insert them, generating new PKs 
insert into drugs.manufacturer (code,"name",address,telephone,facsimile)
    select mnfr.code, mnfr."name", mnfr.address, mnfr.telephone, mnfr.facsimile
     from mnfr;


-- insert new PBS entries
insert into drugs.product (atccode,"name",description,packsize) 
   select distinct atccode, trim(both from genericname), trim(both from formandstrength)
    , packsize
   from rawpbs
   except select atccode, "name", description , packsize from drugs.product;

-- reload all PBS-specific information
truncate drugs.pbs;

insert into drugs.pbs (fk_product,quantity,max_rpt,pbscode,chapter,restrictionflag) 
    select distinct 
    dp.pk, rawpbs.maxquantity, rawpbs.numrepeats, 
    rawpbs.pbscode, rawpbs.drugtypecode, rawpbs.restrictionflag
    from drugs.product dp, rawpbs
    where dp."name" = rawpbs.genericname and 
    dp.description = rawpbs.formandstrength and
    dp.packsize = rawpbs.packsize;

truncate drugs.restriction;

create temporary table notes (id varchar(4), comment text);
\copy notes from 'NoteExtract.txt'
update notes set comment=E'\nNOTE: ' || comment;

create temporary table cautions (id varchar(4), comment text);
\copy cautions from 'CautionExtract.txt'
update cautions set comment=E'\nCAUTION: ' || comment;

create temporary table raw_restrict (id varchar(4), comment text, flag text, date_required text, text_required text);
\copy raw_restrict from 'RestrictionExtract.txt'

create temporary table links (pbscode text, auth_code text, flag1 text,
    startdate text, enddate text, note_id text, caution_id text);
\copy links from 'LinkExtract.txt'

insert into drugs.restriction (pbscode, comment, code)
    select distinct links.pbscode, 
    trim(both from raw_restrict.comment) || 
    coalesce(trim(both from notes.comment),'') || 
    coalesce(trim(both from cautions.comment),''),
    links.auth_code
    from  
       links
         inner join raw_restrict on (links.auth_code = raw_restrict.id)
         left outer join cautions on (links.caution_id = cautions.id)
         left outer join notes on (links.note_id = notes.id);

delete from drugs.brand where from_pbs;
insert into drugs.brand (fk_product, fk_manufacturer, brand, price, from_pbs)
    select distinct 
        dp.pk, dm.pk, rawpbs.brandname, rawpbs.cwdprice, 't'::boolean
    from
       drugs.product dp, drugs.manufacturer dm, rawpbs
    where
       dp."name" = rawpbs.genericname and
       dp.description = rawpbs.formandstrength and
       dp.packsize = rawpbs.packsize and
       dm.code = rawpbs.manufacturercode;
       
