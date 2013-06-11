-- create a sequence for generating HL7 message numbers

create sequence documents.hl7_messages;
ALTER sequence documents.hl7_messages OWNER TO easygp;
GRANT ALL ON TABLE documents.hl7_messages TO easygp;
GRANT ALL ON TABLE documents.hl7_messages TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 289);

