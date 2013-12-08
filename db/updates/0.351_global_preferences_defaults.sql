create table admin.lu_preferences_defaults (
     pk serial primary key,
     "name" text not null unique,
     "value" text not null,
     check_dir boolean default false);

grant select on admin.lu_preferences_defaults to staff;

insert into admin.lu_preferences_defaults ("name","value",check_dir) values ('document_scanning_directory','/var/lib/easygp/scanning',true);
insert into admin.lu_preferences_defaults ("name","value",check_dir) values ('document_archiving_directory','/var/lib/easygp/documents',true);
insert into admin.lu_preferences_defaults ("name","value",check_dir) values ('hl7_incoming_directory','/var/lib/easygp/hl7/incoming',true);
insert into admin.lu_preferences_defaults ("name","value",check_dir) values ('hl7_outgoing_directory','/var/lib/easygp/hl7/outgoing',true);
insert into admin.lu_preferences_defaults ("name","value") values ('document_fk_lu_archive_site','1');
insert into admin.lu_preferences_defaults ("name","value",check_dir) values ('library_directory_network','/var/lib/easygp/library/',true);
insert into admin.lu_preferences_defaults ("name","value",check_dir) values ('product_information_directory','/var/lib/easygp/drug_pis',true);
insert into admin.lu_preferences_defaults ("name","value") values ('area_of_need','false');
insert into admin.lu_preferences_defaults ("name","value") values ('use_ozefax','false');
insert into admin.lu_preferences_defaults ("name","value") values ('referral_engine','h');

CREATE OR REPLACE FUNCTION admin.check_dir(dir1 text)
 RETURNS boolean
 LANGUAGE plpythonu
AS $function$
import os
return os.access(dir1,os.R_OK|os.W_OK|os.X_OK)
$function$;

grant execute on function admin.check_dir(text) to staff;

create or replace view admin.vwpreferences as 
   select 
       coalesce(g.pk+10000,lpd.pk) as pk_view,
       fk_clinic,
        fk_staff,
       coalesce(g."name",lpd."name") as "name",
       case when lpd.check_dir is true then 
            case when admin.check_dir(coalesce(g."value",lpd."value")) then '*server*' else coalesce(g."value",lpd."value") end
       else
            coalesce(g."value",lpd."value") end as "value",
       coalesce(g."value",lpd."value") as "rvalue"    
   from admin.global_preferences g
        full outer join
        admin.lu_preferences_defaults lpd using ("name");

grant select on admin.vwpreferences to staff;

CREATE OR REPLACE FUNCTION public.save_file(dir_option_name text, fname text, data bytea)
 RETURNS void
 LANGUAGE plpythonu
AS $function$
   ret = plpy.execute('select "rvalue" from admin.vwpreferences where "name" = $$%s$$ limit 1' % dir_option_name)
   if len(ret) == 0: plpy.error("No such option %s" % dir_option_name)
   f = open(ret[0]["rvalue"]+'/'+fname,'w')
   d = f.write(data)
   f.close()
$function$ ;

CREATE OR REPLACE FUNCTION public.load_file(dir_option_name text, fname text)
 RETURNS bytea
 LANGUAGE plpythonu
AS $function$
   ret = plpy.execute('select "rvalue" from admin.vwpreferences where "name" = $$%s$$ limit 1' % dir_option_name)
   if len(ret) == 0: plpy.error("No such option %s" % dir_option_name)
   f = open(ret[0]["rvalue"]+'/'+fname,'r')
   d = f.read()
   f.close()
   return d
$function$ ;

CREATE OR REPLACE FUNCTION public.list_files(dir_option_name text)
 RETURNS SETOF text
 LANGUAGE plpythonu
AS $function$
  import os, os.path
  ret = plpy.execute('select "rvalue" from admin.vwpreferences where "name" = $$%s$$ limit 1' % dir_option_name)
  if len(ret) == 0: plpy.error("No such option %s" % dir_option_name)
  top = ret[0]["rvalue"]
  for p,s,f in os.walk(top):
    p = p[len(top)+1:]
    for j in f:
       yield os.path.join(p,j)
$function$ ;

CREATE OR REPLACE FUNCTION public.delete_file(dir_option_name text, fname text)
 RETURNS void
 LANGUAGE plpythonu
AS $function$
  import os
  ret = plpy.execute('select "rvalue" from admin.vwpreferences where "name" = $$%s$$ limit 1' % dir_option_name)
  if len(ret) == 0: plpy.error("No such option %s" % dir_option_name)
  os.unlink(ret[0]["rvalue"] + "/" + fname)
$function$ ;

update db.lu_version set lu_minor=351;
