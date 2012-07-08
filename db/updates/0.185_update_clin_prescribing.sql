-- dropped no longer needed sequence

drop sequence clin_prescribing.authority_number;

-- adding a new field to save the LaTex definitions of the script
-- for some people (probably only me) this means many scripts are missing a laTex Definition

alter table clin_prescribing.prescribed add column latex text;
update clin_prescribing.prescribed set latex = 'No LaTeX definition found';
alter table clin_prescribing.prescribed alter column latex set default not null;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 185);

