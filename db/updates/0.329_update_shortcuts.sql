create table clin_consult.lu_shortcut_category
(pk serial primary key,
category text not null);

ALTER TABLE clin_consult.lu_shortcut_category OWNER to easygp;
GRANT ALL ON TABLE clin_consult.lu_shortcut_category TO staff;

comment on table clin_consult.lu_shortcut_category is
'The category of shortcut e.g examination';

insert into clin_consult.lu_shortcut_category (category) values ('System Wide');
insert into clin_consult.lu_shortcut_category (category) values ('Care Planning');
insert into clin_consult.lu_shortcut_category (category) values ('Education');
insert into clin_consult.lu_shortcut_category (category) values ('Examination');
insert into clin_consult.lu_shortcut_category (category) values ('Explanation to Patient');
insert into clin_consult.lu_shortcut_category (category) values ('Medico-Legal Warnings');
insert into clin_consult.lu_shortcut_category (category) values ('Progress Note Headings');
-- add the new lookup column to the shortcuts table, update all existing to the 'system wide'
-- then reset the default value to not null
alter table clin_consult.lu_shortcut add column fk_lu_shortcut_category integer ;
alter table clin_consult.lu_shortcut 
 ADD CONSTRAINT clin_consult_fk_lu_shortcut_category_fkey FOREIGN KEY (fk_lu_shortcut_category)
      REFERENCES clin_consult.lu_shortcut_category (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;
      
update clin_consult.lu_shortcut set fk_lu_shortcut_category = 1;
alter table clin_consult.lu_shortcut  alter column fk_lu_shortcut_category  set not null;

-- do some error fixing for previous data
update  clin_consult.lu_shortcut set expanded = '<b>Treatment</b><br>' where shortcut='.rx';

insert into clin_consult.lu_shortcut (shared,shortcut, expanded,fk_lu_shortcut_category) -- ,shortcut_progressnotes_sections) values
values (True, '.scr', '<b>Scripts</b><br>', 1);

Create or replace view clin_consult.vwShortcuts as
SELECT 
  lu_shortcut_category.category, 
  shortcuts_user.pk, 
  shortcuts_user.fk_staff, 
  shortcuts_user.shared, 
  shortcuts_user.shortcut, 
  shortcuts_user.expanded, 
  shortcuts_user.fk_lu_shortcut_category 
 -- shortcuts_user.shortcut_progressnotes_sections
FROM 
  clin_consult.lu_shortcut_category, 
  clin_consult.shortcuts_user
WHERE 
  shortcuts_user.fk_lu_shortcut_category = lu_shortcut_category.pk;
  alter  view clin_consult.vwShortcuts owner to easygp;
  
  grant select on  clin_consult.vwShortcuts to staff;

grant usage on clin_consult.lu_shortcut_pk_seq to staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 329)
