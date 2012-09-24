CREATE OR REPLACE FUNCTION clin_prescribing.make_auth_number(integer)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
declare
  script_no integer;
  check_digit integer;
begin
  select into script_no authority_script_number from
clin_prescribing.authority_script_number where fk_staff = $1 limit 1;
  if not found then -- doctor has never done an Authority script on this system
    select into script_no n.prescriber_number from admin.staff s, contacts.data_numbers n where  s.pk = $1 and s.fk_person = n.fk_person limit 1;
    if not found then
      raise exception 'no such staff member';
    end if;
    if script_no < 1000000 then -- must be seven digits
      script_no := script_no + 1000000;
    end if;
    insert into
clin_prescribing.authority_script_number(fk_staff,authority_script_number)
values ($1,script_no);
  else
    script_no := script_no + 1;
    update clin_prescribing.authority_script_number set
authority_script_number=script_no where fk_staff=$1;
  end if;
  check_digit := 0;
  for i in 1..7 loop
    check_digit := check_digit + substring(script_no::text from i for
1)::integer;
  end loop;
  check_digit := check_digit % 9;
  return script_no::text || check_digit::text;
end;
$function$;


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 232);
