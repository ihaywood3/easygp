
CREATE SEQUENCE documents.hl7_messages_in
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE documents.hl7_messages_in   OWNER TO easygp;
GRANT ALL ON TABLE documents.hl7_messages_in TO easygp;
GRANT ALL ON TABLE documents.hl7_messages_in TO staff;

comment on SEQUENCE documents.hl7_messages_in is
'a unique key which is added to all incoming hl7 files imported to prevent collisions
 due to different senders using the same file names';
 
update db.lu_version set lu_minor=396;
