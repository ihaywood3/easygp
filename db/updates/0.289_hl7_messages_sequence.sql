-- create a sequence for generating HL7 message numbers

create sequence documents.hl7_messages_seq;
ALTER sequence documents.hl7_messages_seq OWNER TO easygp;
GRANT ALL ON TABLE documents.hl7_messages_seq TO easygp;
GRANT ALL ON TABLE documents.hl7_messages_seq TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 289);

