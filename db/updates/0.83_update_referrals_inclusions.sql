-- some minor mods and ownership changes to inclusions;

alter table  clin_referrals.inclusions add column  deleted boolean default false;

comment on column clin_referrals.inclusions.deleted is
'if deleted is true then the inclusion is marked as deleted and
 for example will not be sent out if the document is later re-printed';


ALTER TABLE clin_referrals.inclusions OWNER TO easygp;
GRANT ALL ON TABLE clin_referrals.inclusions TO easygp;
GRANT SELECT ON TABLE clin_referrals.inclusions TO staff;
 

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 83);

