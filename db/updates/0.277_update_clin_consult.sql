
Insert into clin_consult.lu_progressnotes_sections (section) values ('Health Summary');
Insert into clin_consult.lu_progressnotes_sections (section) values ('Recreational Drugs');

comment on view clin_consult.vwProgressNotes is  'the fk_lu_consult_type = 8 is ''Review of Correspondance''';

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 277);

