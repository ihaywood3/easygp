
CREATE OR REPLACE FUNCTION research.first_progressnote()
  RETURNS date AS
$BODY$
declare
  first_date date;
begin
  select into first_date 
  consult_date From clin_consult.vwprogressnotes where fk_audit_action = 1 order by pk_progressnote ASC limit 1;
  return first_date;
end;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
  
ALTER FUNCTION research.first_progressnote()   OWNER TO easygp;
GRANT EXECUTE ON FUNCTION research.first_progressnote() TO STAFF;

update db.lu_version set lu_minor = 489;
