CREATE OR REPLACE FUNCTION clerical.notify_booking()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$begin
  EXECUTE 'NOTIFY booking, ''' || extract(day from NEW."begin") || ' ' || 
                  extract(month from NEW."begin") || ' ' ||
                  extract(year from NEW."begin") || ' ' ||
                  NEW.fk_clinic || ' ' ||
                  NEW.fk_staff|| '''';
  RETURN NEW;
end;$function$;

create trigger notify_booking BEFORE INSERT OR UPDATE ON clerical.bookings FOR EACH ROW EXECUTE PROCEDURE clerical.notify_booking();

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 262);
