INSERT INTO clin_consult.lu_progressnotes_sections(section)  VALUES ('images');
INSERT INTO clin_consult.lu_progressnotes_sections(section) VALUES ('care plans');
INSERT INTO clin_consult.lu_progressnotes_sections(section) VALUES ('medical certificates');
truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 119);
    
    
    
