CREATE OR REPLACE FUNCTION public.save_file(dir_option_name text, fname text, data bytea)
 RETURNS void
 LANGUAGE plpythonu
AS $function$
   ret = plpy.execute('select "value" from admin.global_preferences where "name" = $$%s$$ limit 1' % dir_option_name)
   if len(ret) == 0: plpy.error("No such option %s" % dir_option_name)
   f = open(ret[0]["value"]+'/'+fname,'w')
   d = f.write(data)
   f.close()
$function$

CREATE OR REPLACE FUNCTION public.load_file(dir_option_name text, fname text)
 RETURNS bytea
 LANGUAGE plpythonu
AS $function$
   ret = plpy.execute('select "value" from admin.global_preferences where "name" = $$%s$$ limit 1' % dir_option_name)
   if len(ret) == 0: plpy.error("No such option %s" % dir_option_name)
   f = open(ret[0]["value"]+'/'+fname,'r')
   d = f.read()
   f.close()
   return d
$function$

CREATE OR REPLACE FUNCTION public.list_files(dir_option_name text)
 RETURNS SETOF text
 LANGUAGE plpythonu
AS $function$
  import os, os.path
  ret = plpy.execute('select "value" from admin.global_preferences where "name" = $$%s$$ limit 1' % dir_option_name)
  if len(ret) == 0: plpy.error("No such option %s" % dir_option_name)
  top = ret[0]["value"]
  for p,s,f in os.walk(top):
    p = p[len(top)+1:]
    for j in f:
       yield os.path.join(p,j)
$function$

CREATE OR REPLACE FUNCTION public.delete_file(dir_option_name text, fname text)
 RETURNS void
 LANGUAGE plpythonu
AS $function$
  import os
  ret = plpy.execute('select "value" from admin.global_preferences where "name" = $$%s$$ limit 1' % dir_option_name)
  if len(ret) == 0: plpy.error("No such option %s" % dir_option_name)
  os.unlink(ret[0]["value"] + "/" + fname)
$function$

update db.lu_version set lu_minor=344;