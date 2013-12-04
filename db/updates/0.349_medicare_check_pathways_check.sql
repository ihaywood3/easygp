alter table clerical.data_patients add constraint "medicare_check" check
(medicare_number ~ '[0-9]{10}');

update clerical.data_patients set medicare_ref_number = null where
medicare_ref_number = '0';

alter table clerical.data_patients add constraint "medicare_ref_check"
check (medicare_ref_number ~ '^[1-9]$');

CREATE TYPE public.check_dirs_result as ("name" text, "path" text, "access" boolean);
CREATE OR REPLACE FUNCTION public.check_dirs(fk_clinic integer)
 RETURNS SETOF public.check_dirs_result
 LANGUAGE plpythonu
AS $function$
import os
ret = plpy.execute('select "name","value" from admin.global_preferences where "name" ilike $$%%_directory$$ and fk_clinic = %s' % fk_clinic)
for row in ret:
    f = row["value"]
    yield (row["name"],f,os.access(f,os.R_OK|os.W_OK|os.X_OK))
$function$;

update db.lu_version set lu_minor=349;


