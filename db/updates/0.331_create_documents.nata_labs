-- in preparation for a cleverer finding of the sender of hl7 messages
-- will later import the nata_laboritories into easygp to search when hl7 hits the office

create table documents.nata_laboritories
(pk serial primary key,
 Accreditation_No text not null,
 LabName text not null,
 LabName2 text default null,
 Address text default null,
 Address2 text default null,
 Address3 text default null,
 Suburb  text default null,
 State  text default null,
 Postcode  text default null,
 Contact text default null,
 Phone text default null,
 Fax text default null,
 Mobile text default null,
 Email  text default null,
 Website text default null,
 Facility_Type text default null,
Last_Updated date not null);
 

GRANT ALL ON TABLE documents.nata_laboritories TO easygp;
GRANT ALL ON TABLE documents.nata_laboritories TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 331);
