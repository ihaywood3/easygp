drop view  admin.vwpreferences;
create or replace view admin.vwpreferences as SELECT 
COALESCE(g.pk + 10000, lpd.pk) AS pk_view, g.fk_clinic, g.fk_staff, 
COALESCE(g.name, lpd.name) AS name, COALESCE(g.value, lpd.value) AS value, 
lpd.check_dir is true as check_dir,
        CASE
            WHEN lpd.check_dir IS TRUE THEN 
                admin.check_dir(COALESCE(g.value, lpd.value)) 
            ELSE FALSE
        END AS server_dir
   FROM admin.global_preferences g
   FULL JOIN admin.lu_preferences_defaults lpd USING (name);
   
CREATE OR REPLACE FUNCTION public.list_files(dir_option_name text)
 RETURNS SETOF text
 LANGUAGE plpythonu
AS $function$
  import os, os.path
  ret = plpy.execute('select "value" from admin.vwpreferences where "name" = $$%s$$ limit 1' % dir_option_name)
  if len(ret) == 0: plpy.error("No such option %s" % dir_option_name)
  top = ret[0]["value"]
  for p,s,f in os.walk(top):
    p = p[len(top)+1:]
    for j in f:
       yield os.path.join(p,j)
$function$;
 
CREATE OR REPLACE FUNCTION public.save_file(dir_option_name text, fname text, data bytea)
 RETURNS void
 LANGUAGE plpythonu
AS $function$
   ret = plpy.execute('select "value" from admin.vwpreferences where "name" = $$%s$$ limit 1' % dir_option_name)
   if len(ret) == 0: plpy.error("No such option %s" % dir_option_name)
   f = open(ret[0]["value"]+'/'+fname,'w')
   d = f.write(data)
   f.close()
$function$;

CREATE OR REPLACE FUNCTION public.load_file(dir_option_name text, fname text)
 RETURNS bytea
 LANGUAGE plpythonu
AS $function$
   ret = plpy.execute('select "value" from admin.vwpreferences where "name" = $$%s$$ limit 1' % dir_option_name)
   if len(ret) == 0: plpy.error("No such option %s" % dir_option_name)
   f = open(ret[0]["value"]+'/'+fname,'r')
   d = f.read()
   f.close()
   return d
$function$;

CREATE OR REPLACE FUNCTION public.delete_file(dir_option_name text, fname text)
 RETURNS void
 LANGUAGE plpythonu
AS $function$
  import os
  ret = plpy.execute('select "value" from admin.vwpreferences where "name" = $$%s$$ limit 1' % dir_option_name)
  if len(ret) == 0: plpy.error("No such option %s" % dir_option_name)
  os.unlink(ret[0]["value"] + "/" + fname)
$function$;

alter view admin.vwpreferences owner to easygp;
grant select on admin.vwpreferences to staff;

alter function public.delete_file(text,text) owner to easygp;
grant execute on function public.delete_file(text,text) to staff;

alter function public.load_file(text,text) owner to easygp;
grant execute on function public.load_file(text,text) to staff;

alter function public.save_file(text,text,bytea) owner to easygp;
grant execute on function public.save_file(text,text,bytea) to staff;

alter function public.list_files(text) owner to easygp;
grant execute on function public.list_files(text) to staff;

grant all on admin.lu_preferences_defaults to staff;

update db.lu_version set lu_minor=353;
