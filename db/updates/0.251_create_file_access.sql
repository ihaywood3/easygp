-- this script must be run as superuser

create language 'plpythonu';

CREATE OR REPLACE FUNCTION load_file (dir_option_name text,fname text)
  RETURNS bytea
AS $body$
   ret = plpy.execute('select "value" from admin.global_preferences where fk_clinic=1 and fk_staff is null and "name" = $$%s$$ limit 1' % dir_option_name)
   if len(ret) == 0: plpy.error("No such option %s" % dir_option_name)
   f = open(ret[0]["value"]+'/'+fname,'r')
   d = f.read()
   f.close()
   return d
$body$ LANGUAGE plpythonu;

CREATE OR REPLACE FUNCTION save_file (dir_option_name text,fname text, "data" bytea)
  RETURNS void
AS $body$
   ret = plpy.execute('select "value" from admin.global_preferences where fk_clinic=1 and fk_staff is null and "name" = $$%s$$ limit 1' % dir_option_name)
   if len(ret) == 0: plpy.error("No such option %s" % dir_option_name)
   f = open(ret[0]["value"]+'/'+fname,'w')
   d = f.write(data)
   f.close()
$body$ LANGUAGE plpythonu;

CREATE OR REPLACE FUNCTION list_files (dir_option_name text)
  RETURNS SETOF text
AS $body$
  import os, os.path
  ret = plpy.execute('select "value" from admin.global_preferences where fk_clinic=1 and fk_staff is null and "name" = $$%s$$ limit 1' % dir_option_name)
  if len(ret) == 0: plpy.error("No such option %s" % dir_option_name)
  top = ret[0]["value"]
  for p,s,f in os.walk(top):
    p = p[len(top)+1:]
    for j in f:
       yield os.path.join(p,j)
$body$ LANGUAGE plpythonu;

CREATE OR REPLACE FUNCTION delete_file (dir_option_name text,fname text)
  RETURNS void
AS $body$
  import os
  ret = plpy.execute('select "value" from admin.global_preferences where fk_clinic=1 and fk_staff is null and "name" = $$%s$$ limit 1' % dir_option_name)
  if len(ret) == 0: plpy.error("No such option %s" % dir_option_name)
  os.unlink(ret[0]["value"] + "/" + fname)
$body$ LANGUAGE plpythonu;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 251);

