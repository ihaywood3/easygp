CREATE SEQUENCE documents.unique_file_number_seq
   INCREMENT 1
   MINVALUE 1
   MAXVALUE 9223372036854775807
   START 1
   CACHE 1;
ALTER TABLE documents.unique_file_number_seq  OWNER TO EASYGP;
GRANT USAGE ON documents.unique_file_number_seq TO Staff; 

update db.lu_version set lu_minor=406;