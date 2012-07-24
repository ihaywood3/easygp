-- an update to add a function to create a proper authority number

alter table clin_prescribing.authority_script_number drop column fk_clinic;
-- delete any existing number for a staff - it will be wrong.
delete from clin_prescribing.authority_script_number;

-- takes the pk of the admin.staff table as the only parameter.
-- returns a number hopefully pleasing to the PBS Authority.
create or replace function clin_prescribing.make_auth_number(integer)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
declare
  script_no integer;
  check_digit integer;
ebegin
  select into script_no authority_script_number from
clin_prescribing.authority_script_number where fk_staff = $1 limit 1;
  if not found then -- doctor has never done an Authority script on this system
    select into script_no prescriber_number from admin.staff where  pk = $1;
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
insert into db.lu_version (lu_major,lu_minor) values (0, 198);

