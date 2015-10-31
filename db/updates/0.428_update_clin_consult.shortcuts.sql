-- delete shortcut user

-- drop table clin_consult.shortcuts_user cascade;

CREATE TABLE clin_consult.shortcuts_user_temp
(
  pk serial primary key,
  fk_staff integer not null references admin.staff (pk),
  shared boolean   DEFAULT false,
  shortcut text not null, -- the shortcut that triggers the text expansion
  expanded text not null, -- the text the shortcut will get expanded to. Any htnl code is valid, including embedded images
  fk_lu_shortcut_category integer NOT NULL references clin_consult.lu_shortcut_category
 )
WITH (
  OIDS=FALSE
);
ALTER TABLE clin_consult.shortcuts_user_temp   OWNER TO easygp;
GRANT ALL ON TABLE clin_consult.shortcuts_user_temp TO staff;

COMMENT ON TABLE clin_consult.shortcuts_user_temp   IS 'user unique shortcuts that the editor will expand to a longer text sequence';
COMMENT ON COLUMN clin_consult.shortcuts_user_temp.shortcut IS 'the shortcut that triggers the text expansion';
COMMENT ON COLUMN clin_consult.shortcuts_user_temp.expanded IS 'the text the shortcut will get expanded to. Any htnl code is valid, including embedded images';


insert into clin_consult.shortcuts_user_temp (fk_staff, shared, shortcut, expanded, fk_lu_shortcut_category) 
 select fk_staff, shared, shortcut, expanded, fk_lu_shortcut_category from clin_consult.lu_shortcut where fk_staff is not null;

delete from  clin_consult.lu_shortcut where fk_staff is not null;

alter table clin_consult.lu_shortcut drop column fk_staff cascade;

drop table clin_consult.shortcuts_user;

alter table clin_consult.shortcuts_user_temp rename to   shortcuts_user;


create or replace view clin_consult.vwshortcuts  as
select
	lu_shortcut.pk as fk_shortcut,
	shared,
	shortcut,
	expanded,
	fk_lu_shortcut_category,
	lu_shortcut_category.category,
	null as fk_staff
from 
	clin_consult.lu_shortcut
   JOIN  clin_consult.lu_shortcut_category ON lu_shortcut_category.pk = lu_shortcut.fk_lu_shortcut_category

   UNION
    SELECT 
	shortcuts_user.pk as fk_shortcut,
	shortcuts_user.shared,
	shortcuts_user.shortcut,
	shortcuts_user.expanded,
	fk_lu_shortcut_category,
	lu_shortcut_category.category,
	shortcuts_user.fk_staff
 from clin_consult.shortcuts_user
   join clin_consult.lu_shortcut_category ON lu_shortcut_category.pk = shortcuts_user.fk_lu_shortcut_category;


ALTER TABLE clin_consult.vwshortcuts    OWNER TO easygp;
GRANT SELECT ON TABLE clin_consult.vwshortcuts TO staff;

update db.lu_version set lu_minor=428;