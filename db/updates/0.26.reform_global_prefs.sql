create temporary table newprefs
(
   "name" text,
   value text
   );
   
insert into newprefs ("name",value) select 'document_scanning_directory',document_scanning_directory
from "admin".global_preferences;
insert into newprefs ("name",value) select 'document_archiving_directory',document_archiving_directory
from "admin".global_preferences;
insert into newprefs ("name",value) select 'document_fk_lu_archive_site',document_fk_lu_archive_site::text
from "admin".global_preferences;
insert into newprefs ("name",value) select 'document_save_to_database',document_save_to_database::text
from "admin".global_preferences;
insert into newprefs ("name",value) select 'hl7_root_directory',hl7_root_directory
from "admin".global_preferences;
insert into newprefs ("name",value) select 'fk_hl7_fallback_staff_member',fk_hl7_fallback_staff_member::text
from "admin".global_preferences;

DROP VIEW "admin".vwglobalpreferences;

drop table "admin".global_preferences;
create table "admin".global_preferences (
   pk serial primary key,
   "name" text not null,
   value text,
   fk_clinic integer not null,
   unique (fk_clinic,"name")
   );
   
insert into "admin".global_preferences ("name",value,fk_clinic) select distinct "name",value,1 from newprefs;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 26);