--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: admin; Type: SCHEMA; Schema: -; Owner: easygp
--

CREATE SCHEMA admin;


ALTER SCHEMA admin OWNER TO easygp;

--
-- Name: billing; Type: SCHEMA; Schema: -; Owner: easygp
--

CREATE SCHEMA billing;


ALTER SCHEMA billing OWNER TO easygp;

--
-- Name: SCHEMA billing; Type: COMMENT; Schema: -; Owner: easygp
--

COMMENT ON SCHEMA billing IS 'Contains anything to do with billing or receiving payments for the patient services';


--
-- Name: blobs; Type: SCHEMA; Schema: -; Owner: easygp
--

CREATE SCHEMA blobs;


ALTER SCHEMA blobs OWNER TO easygp;

--
-- Name: chronic_disease_management; Type: SCHEMA; Schema: -; Owner: easygp
--

CREATE SCHEMA chronic_disease_management;


ALTER SCHEMA chronic_disease_management OWNER TO easygp;

--
-- Name: clerical; Type: SCHEMA; Schema: -; Owner: easygp
--

CREATE SCHEMA clerical;


ALTER SCHEMA clerical OWNER TO easygp;

--
-- Name: SCHEMA clerical; Type: COMMENT; Schema: -; Owner: easygp
--

COMMENT ON SCHEMA clerical IS 'Clerical schema contains anything to do with the office
Fore example patient specific stuff to do with medicare,
veterns etc. If The project ever got off the ground all
the financial stuff would be here.';


--
-- Name: clin_allergies; Type: SCHEMA; Schema: -; Owner: easygp
--

CREATE SCHEMA clin_allergies;


ALTER SCHEMA clin_allergies OWNER TO easygp;

--
-- Name: clin_careplans; Type: SCHEMA; Schema: -; Owner: easygp
--

CREATE SCHEMA clin_careplans;


ALTER SCHEMA clin_careplans OWNER TO easygp;

--
-- Name: clin_certificates; Type: SCHEMA; Schema: -; Owner: easygp
--

CREATE SCHEMA clin_certificates;


ALTER SCHEMA clin_certificates OWNER TO easygp;

--
-- Name: clin_checkups; Type: SCHEMA; Schema: -; Owner: easygp
--

CREATE SCHEMA clin_checkups;


ALTER SCHEMA clin_checkups OWNER TO easygp;

--
-- Name: clin_consult; Type: SCHEMA; Schema: -; Owner: easygp
--

CREATE SCHEMA clin_consult;


ALTER SCHEMA clin_consult OWNER TO easygp;

--
-- Name: clin_history; Type: SCHEMA; Schema: -; Owner: easygp
--

CREATE SCHEMA clin_history;


ALTER SCHEMA clin_history OWNER TO easygp;

--
-- Name: clin_measurements; Type: SCHEMA; Schema: -; Owner: easygp
--

CREATE SCHEMA clin_measurements;


ALTER SCHEMA clin_measurements OWNER TO easygp;

--
-- Name: clin_mentalhealth; Type: SCHEMA; Schema: -; Owner: easygp
--

CREATE SCHEMA clin_mentalhealth;


ALTER SCHEMA clin_mentalhealth OWNER TO easygp;

--
-- Name: clin_pregnancy; Type: SCHEMA; Schema: -; Owner: easygp
--

CREATE SCHEMA clin_pregnancy;


ALTER SCHEMA clin_pregnancy OWNER TO easygp;

--
-- Name: clin_prescribing; Type: SCHEMA; Schema: -; Owner: easygp
--

CREATE SCHEMA clin_prescribing;


ALTER SCHEMA clin_prescribing OWNER TO easygp;

--
-- Name: clin_procedures; Type: SCHEMA; Schema: -; Owner: easygp
--

CREATE SCHEMA clin_procedures;


ALTER SCHEMA clin_procedures OWNER TO easygp;

--
-- Name: clin_recalls; Type: SCHEMA; Schema: -; Owner: easygp
--

CREATE SCHEMA clin_recalls;


ALTER SCHEMA clin_recalls OWNER TO easygp;

--
-- Name: clin_referrals; Type: SCHEMA; Schema: -; Owner: easygp
--

CREATE SCHEMA clin_referrals;


ALTER SCHEMA clin_referrals OWNER TO easygp;

--
-- Name: SCHEMA clin_referrals; Type: COMMENT; Schema: -; Owner: easygp
--

COMMENT ON SCHEMA clin_referrals IS 'Contains all referral letters written';


--
-- Name: clin_requests; Type: SCHEMA; Schema: -; Owner: easygp
--

CREATE SCHEMA clin_requests;


ALTER SCHEMA clin_requests OWNER TO easygp;

--
-- Name: SCHEMA clin_requests; Type: COMMENT; Schema: -; Owner: easygp
--

COMMENT ON SCHEMA clin_requests IS 'Schema containing all the lookup information and data around request ordering';


--
-- Name: clin_vaccination; Type: SCHEMA; Schema: -; Owner: easygp
--

CREATE SCHEMA clin_vaccination;


ALTER SCHEMA clin_vaccination OWNER TO easygp;

--
-- Name: SCHEMA clin_vaccination; Type: COMMENT; Schema: -; Owner: easygp
--

COMMENT ON SCHEMA clin_vaccination IS ' Easy GP:2April2008 creates all the tables to do with vaccination ie vaccines (holds the brand names, fk_vaccine_description, form (eg injection) vaccines_descriptions eg typoid or tetanus toxoid, diptheria toxoid vaccines_last_bath_number - dr/nurse specific last batch used';


--
-- Name: clin_workcover; Type: SCHEMA; Schema: -; Owner: easygp
--

CREATE SCHEMA clin_workcover;


ALTER SCHEMA clin_workcover OWNER TO easygp;

--
-- Name: SCHEMA clin_workcover; Type: COMMENT; Schema: -; Owner: easygp
--

COMMENT ON SCHEMA clin_workcover IS 'First version probably needs modifications +++';


--
-- Name: coding; Type: SCHEMA; Schema: -; Owner: easygp
--

CREATE SCHEMA coding;


ALTER SCHEMA coding OWNER TO easygp;

--
-- Name: common; Type: SCHEMA; Schema: -; Owner: easygp
--

CREATE SCHEMA common;


ALTER SCHEMA common OWNER TO easygp;

--
-- Name: contacts; Type: SCHEMA; Schema: -; Owner: easygp
--

CREATE SCHEMA contacts;


ALTER SCHEMA contacts OWNER TO easygp;

--
-- Name: db; Type: SCHEMA; Schema: -; Owner: easygp
--

CREATE SCHEMA db;


ALTER SCHEMA db OWNER TO easygp;

--
-- Name: defaults; Type: SCHEMA; Schema: -; Owner: easygp
--

CREATE SCHEMA defaults;


ALTER SCHEMA defaults OWNER TO easygp;

--
-- Name: SCHEMA defaults; Type: COMMENT; Schema: -; Owner: easygp
--

COMMENT ON SCHEMA defaults IS 'Schema containing program defaults 
 ranging from how the user wants the program to look
 to default providers for pathology etc
 very embryonic
	';


--
-- Name: documents; Type: SCHEMA; Schema: -; Owner: easygp
--

CREATE SCHEMA documents;


ALTER SCHEMA documents OWNER TO easygp;

--
-- Name: drugs; Type: SCHEMA; Schema: -; Owner: easygp
--

CREATE SCHEMA drugs;


ALTER SCHEMA drugs OWNER TO easygp;

--
-- Name: SCHEMA drugs; Type: COMMENT; Schema: -; Owner: easygp
--

COMMENT ON SCHEMA drugs IS '
This schema is based on original proposed structure of drug database for the gnumed project
Copyright 2000-02 Dr. Horst Herb
Copyright 2010-11 Dr. Ian Haywood
';


--
-- Name: import_export; Type: SCHEMA; Schema: -; Owner: easygp
--

CREATE SCHEMA import_export;


ALTER SCHEMA import_export OWNER TO easygp;

--
-- Name: maintenance; Type: SCHEMA; Schema: -; Owner: easygp
--

CREATE SCHEMA maintenance;


ALTER SCHEMA maintenance OWNER TO easygp;

--
-- Name: research; Type: SCHEMA; Schema: -; Owner: easygp
--

CREATE SCHEMA research;


ALTER SCHEMA research OWNER TO easygp;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: plpythonu; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: postgres
--

CREATE OR REPLACE PROCEDURAL LANGUAGE plpythonu;


ALTER PROCEDURAL LANGUAGE plpythonu OWNER TO postgres;

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET search_path = billing, pg_catalog;

--
-- Name: invoice_gst(integer); Type: FUNCTION; Schema: billing; Owner: easygp
--

CREATE FUNCTION invoice_gst(integer) RETURNS money
    LANGUAGE sql
    AS $_$
   select coalesce(sum(i.amount_gst),'$0.00'::money) 
           from billing.items_billed i where i.fk_invoice=$1; 
$_$;


ALTER FUNCTION billing.invoice_gst(integer) OWNER TO easygp;

--
-- Name: invoice_received(integer); Type: FUNCTION; Schema: billing; Owner: easygp
--

CREATE FUNCTION invoice_received(integer) RETURNS money
    LANGUAGE sql
    AS $_$
    select coalesce(sum(amount),'$0.00'::money) from billing.payments_received where fk_invoice=$1;$_$;


ALTER FUNCTION billing.invoice_received(integer) OWNER TO easygp;

--
-- Name: invoice_total(integer); Type: FUNCTION; Schema: billing; Owner: easygp
--

CREATE FUNCTION invoice_total(integer) RETURNS money
    LANGUAGE sql
    AS $_$
   select coalesce(sum(amount),'$0.00'::money) from billing.items_billed where fk_invoice=$1; $_$;


ALTER FUNCTION billing.invoice_total(integer) OWNER TO easygp;

--
-- Name: update_invoice_bill(); Type: FUNCTION; Schema: billing; Owner: easygp
--

CREATE FUNCTION update_invoice_bill() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
       pk_invoice iNTEGER;
    BEGIN
        if (TG_OP = 'DELETE') THEN
pk_invoice = OLD.fk_invoice;
else
pk_invoice = NEW.fk_invoice;
end if;
        update billing.invoices set total_bill=billing.invoice_total(pk), total_gst=billing.invoice_gst(pk) where pk = pk_invoice;
        RETURN NULL; -- result is ignored since this is an AFTER trigger
    END;
$$;


ALTER FUNCTION billing.update_invoice_bill() OWNER TO easygp;

--
-- Name: update_invoice_payment(); Type: FUNCTION; Schema: billing; Owner: easygp
--

CREATE FUNCTION update_invoice_payment() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
       pk_invoice iNTEGER;
    BEGIN
        If (TG_OP = 'DELETE') THEN
      pk_invoice = OLD.fk_invoice;
   Else
      pk_invoice = New .fk_invoice;
   End If ;
        update billing.invoices set total_paid = billing.invoice_received(pk)where pk = pk_invoice;
   update billing.invoices set paid = (total_paid >= total_gst + total_bill)where pk = pk_invoice;
        Return Null; -- result Is Ignored since this Is An AFTER trigger
    End ;
$$;


ALTER FUNCTION billing.update_invoice_payment() OWNER TO easygp;

SET search_path = clerical, pg_catalog;

--
-- Name: listavailable(integer, integer, integer); Type: FUNCTION; Schema: clerical; Owner: easygp
--

CREATE FUNCTION listavailable(fk_clinicv integer, fk_doctor integer, max integer) RETURNS SETOF timestamp without time zone
    LANGUAGE plpgsql
    AS $$
    declare
      thedate date;
      remaining integer;
      sess clerical.sessions%rowtype;
      thetime time;
      thestamp timestamp without time zone;
    begin
	thedate := now()::date+'1 day'::interval;
	remaining := max;
	while remaining > 0 loop
            if thedate > '2200-1-1'::date then
 	       raise exception 'we''ve gone stupidly far into the future';
	    end if;	
            for sess in select * from clerical.listsessions(thedate,fk_clinicv) loop
	         thetime := sess.begin;
		 while thetime < sess.finish loop
		       thestamp := thedate + thetime;
		       --raise notice 'checking %',thestamp;
		       perform 1 from clerical.bookings where fk_staff=fk_doctor and fk_clinic=fk_clinicv and "begin" <= thestamp and "begin"+duration > thestamp;
		       if not found then
                          remaining := remaining-1;
		       	  return next thestamp;
		       end if; 
		       thetime := thetime + sess.appointment_interval;
		 end loop;	  
	      end loop;
	      thedate := thedate + '1 day'::interval;
	end loop;
        return;
    end;
$$;


ALTER FUNCTION clerical.listavailable(fk_clinicv integer, fk_doctor integer, max integer) OWNER TO easygp;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: sessions; Type: TABLE; Schema: clerical; Owner: easygp; Tablespace: 
--

CREATE TABLE sessions (
    pk integer NOT NULL,
    fk_staff integer NOT NULL,
    fk_clinic integer NOT NULL,
    begin time without time zone,
    finish time without time zone,
    weekday smallint,
    of_month boolean[] DEFAULT '{t,t,t,t,t}'::boolean[],
    appointment_interval interval DEFAULT '00:10:00'::interval
);


ALTER TABLE clerical.sessions OWNER TO easygp;

--
-- Name: TABLE sessions; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON TABLE sessions IS 'list of all sessions currently running at a clinic';


--
-- Name: COLUMN sessions.weekday; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON COLUMN sessions.weekday IS 'must be compatible with postgres date functions, so 0=Sunday and 6=Saturday';


--
-- Name: COLUMN sessions.of_month; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON COLUMN sessions.of_month IS 'which weeks of the month the session runs for fortnightly/monthly sessions';


--
-- Name: listsessions(timestamp without time zone, integer); Type: FUNCTION; Schema: clerical; Owner: easygp
--

CREATE FUNCTION listsessions(timestamp without time zone, integer) RETURNS SETOF sessions
    LANGUAGE sql
    AS $_$
    select * from clerical.sessions where fk_clinic = $2 and weekday = extract(dow from $1)
           and of_month[((extract(day from $1)-1)/7)+1]
$_$;


ALTER FUNCTION clerical.listsessions(timestamp without time zone, integer) OWNER TO easygp;

--
-- Name: notify_booking(); Type: FUNCTION; Schema: clerical; Owner: postgres
--

CREATE FUNCTION notify_booking() RETURNS trigger
    LANGUAGE plpgsql
    AS $$begin
  EXECUTE 'NOTIFY booking, ''' || extract(day from NEW."begin") || ' ' || 
                  extract(month from NEW."begin") || ' ' ||
                  extract(year from NEW."begin") || ' ' ||
                  NEW.fk_clinic || ' ' ||
                  NEW.fk_staff|| '''';
  RETURN NEW;
end;$$;


ALTER FUNCTION clerical.notify_booking() OWNER TO postgres;

--
-- Name: tell_remote_server1(); Type: FUNCTION; Schema: clerical; Owner: ian
--

CREATE FUNCTION tell_remote_server1() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  start integer;
  duration integer;
BEGIN
  start:=round(extract(epoch from NEW."begin"));
  IF NEW.deleted THEN
    duration:=0;
  ELSE
    duration:=(extract(hour from NEW.duration)*60)+extract(minute from NEW.duration);
  END IF;
  PERFORM clerical.tell_remote_server2(start,duration);
  RETURN NEW;
END;
$$;


ALTER FUNCTION clerical.tell_remote_server1() OWNER TO ian;

--
-- Name: tell_remote_server2(integer, integer); Type: FUNCTION; Schema: clerical; Owner: postgres
--

CREATE FUNCTION tell_remote_server2(start integer, duration integer) RETURNS void
    LANGUAGE plpythonu
    AS $$
import urllib
urllib.urlopen("http://127.0.0.1:4567/auto_update_appt",urllib.urlencode({"start":start,"duration":duration}))
$$;


ALTER FUNCTION clerical.tell_remote_server2(start integer, duration integer) OWNER TO postgres;

SET search_path = clin_careplans, pg_catalog;

--
-- Name: erase_data(); Type: FUNCTION; Schema: clin_careplans; Owner: easygp
--

CREATE FUNCTION erase_data() RETURNS boolean
    LANGUAGE plpgsql
    AS $$
begin
delete from clin_careplans.careplan_pages;
delete from clin_careplans.careplans;
delete from clin_careplans.component_task_due;

delete from clin_careplans.link_careplanpage_advice;

delete from clin_careplans.link_careplanpage_components;
delete from clin_careplans.link_careplanpages_careplan;

delete from clin_careplans.lu_advice;

delete from clin_careplans.lu_aims;

delete from clin_careplans.lu_components;

delete from clin_careplans.lu_conditions;

delete from clin_careplans.lu_education;


delete from clin_careplans.lu_tasks;
return 1;
end
$$;


ALTER FUNCTION clin_careplans.erase_data() OWNER TO easygp;

--
-- Name: FUNCTION erase_data(); Type: COMMENT; Schema: clin_careplans; Owner: easygp
--

COMMENT ON FUNCTION erase_data() IS '**********************
 Developmental use only
 **********************
 This function will erase your entire care plan database!!!!!!!!!!!!;
';


SET search_path = clin_prescribing, pg_catalog;

--
-- Name: make_auth_number(integer); Type: FUNCTION; Schema: clin_prescribing; Owner: easygp
--

CREATE FUNCTION make_auth_number(integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
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
$_$;


ALTER FUNCTION clin_prescribing.make_auth_number(integer) OWNER TO easygp;

SET search_path = db, pg_catalog;

--
-- Name: do_all_tables(text, text, text); Type: FUNCTION; Schema: db; Owner: easygp
--

CREATE FUNCTION do_all_tables(cmd text, regex text, classes text) RETURNS void
    LANGUAGE plpgsql
    AS $$
  DECLARE
    line text;
  BEGIN
    FOR line IN select nspname || '.' || relname from pg_class, pg_namespace where relnamespace = pg_namespace.oid and (not relname ilike 'pg_%') and nspname<>'information_schema' and nspname || '.' || relname ~ regex and position(relkind in classes) > 0 LOOP
      EXECUTE replace(cmd,'&',line);
    END LOOP;
  END;
$$;


ALTER FUNCTION db.do_all_tables(cmd text, regex text, classes text) OWNER TO easygp;

SET search_path = drugs, pg_catalog;

--
-- Name: format_amount(double precision, integer, integer); Type: FUNCTION; Schema: drugs; Owner: easygp
--

CREATE FUNCTION format_amount(double precision, integer, integer) RETURNS text
    LANGUAGE plpgsql
    AS $_$
declare
 r text;
 i text;
begin
 r := '';
 -- now add amount and amount_unit
 if not $1 is null then
   select into i abbrev_text from common.lu_units where pk = $2;
   r := $1 || i;
 end if;
 if $3 <> 1 then
   i := $3::text;
   if r <> '' then
     r:= r || ' x ' || i;
   else
     r := '(pack of ' || i || ')';
   end if;
 end if;
 RETURN r;
END;
$_$;


ALTER FUNCTION drugs.format_amount(double precision, integer, integer) OWNER TO easygp;

--
-- Name: FUNCTION format_amount(double precision, integer, integer); Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON FUNCTION format_amount(double precision, integer, integer) IS 'formats the amount and units per pack appropriately for display
Parameters are in order:
- the value for product.amount
- the value for product.amount_unit
- the value for product.units_per_pack

Note: previously this function called format_packsize, but now product.pack_size not involved in this function,
putting in this value is the responsibility the client';


--
-- Name: format_strength(text); Type: FUNCTION; Schema: drugs; Owner: easygp
--

CREATE FUNCTION format_strength(text) RETURNS text
    LANGUAGE plpgsql
    AS $_$
DECLARE
  i text;
  a text[];
  r text;
  u text;
  q float;
BEGIN
  -- do the ml -> 5ml conversion;
  for i in select strength from regexp_split_to_table($1,E'-') as
strength loop
    u := i;
    a := regexp_matches(i,E'^([0-9\\.]+)([a-z\\/]+)$');
    if not a is null then
      if a[2] = 'mg/ml' or a[2] = 'mcg/ml' then
        q := a[1]::float;
        q := q*5;
        u := q::text || replace(a[2],'/ml','/5ml');
      else
        u := i;
      end if;
    else
      u := i;
    end if;
    IF r is null THEN
      r := u;
    ELSE
      r := r || '-' || u;
    END IF;
  end loop;
  return r;
end;
$_$;


ALTER FUNCTION drugs.format_strength(text) OWNER TO easygp;

SET search_path = public, pg_catalog;

--
-- Name: age_display(interval); Type: FUNCTION; Schema: public; Owner: easygp
--

CREATE FUNCTION age_display(interval) RETURNS text
    LANGUAGE sql
    AS $_$
    SELECT
         CASE WHEN $1 < '1 year' THEN to_char($1,'FMMM"m"FMDD"d"')
              WHEN $1 >= '1 year' AND $1 < '10 years' THEN to_char($1,'Y"y"FMMM"m"')
	      WHEN $1 >= '10 years' AND $1 < '18 years' THEN to_char($1, 'YY"y"FMMM"m')
	      WHEN $1 > '100 years' THEN to_char($1,'YYY"y"')
	      ELSE to_char($1,'YY"y"') END
$_$;


ALTER FUNCTION public.age_display(interval) OWNER TO easygp;

--
-- Name: delete_file(text, text); Type: FUNCTION; Schema: public; Owner: easygp
--

CREATE FUNCTION delete_file(dir_option_name text, fname text) RETURNS void
    LANGUAGE plpythonu
    AS $_$
  import os
  ret = plpy.execute('select "value" from admin.global_preferences where fk_clinic=1 and fk_staff is null and "name" = $$%s$$ limit 1' % dir_option_name)
  if len(ret) == 0: plpy.error("No such option %s" % dir_option_name)
  os.unlink(ret[0]["value"] + "/" + fname)
$_$;


ALTER FUNCTION public.delete_file(dir_option_name text, fname text) OWNER TO easygp;

--
-- Name: invoice_received(integer); Type: FUNCTION; Schema: public; Owner: easygp
--

CREATE FUNCTION invoice_received(integer) RETURNS money
    LANGUAGE sql
    AS $_$
    select sum(amount) from billing.payments_received where fk_invoice=$1;$_$;


ALTER FUNCTION public.invoice_received(integer) OWNER TO easygp;

--
-- Name: invoice_total(integer); Type: FUNCTION; Schema: public; Owner: easygp
--

CREATE FUNCTION invoice_total(integer) RETURNS money
    LANGUAGE sql
    AS $_$
   select sum(amount) from billing.items_billed where fk_invoice=$1; $_$;


ALTER FUNCTION public.invoice_total(integer) OWNER TO easygp;

--
-- Name: list_files(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION list_files(dir_option_name text) RETURNS SETOF text
    LANGUAGE plpythonu
    AS $_$
  import os, os.path
  ret = plpy.execute('select "value" from admin.global_preferences where fk_clinic=1 and fk_staff is null and "name" = $$%s$$ limit 1' % dir_option_name)
  if len(ret) == 0: plpy.error("No such option %s" % dir_option_name)
  top = ret[0]["value"]
  for p,s,f in os.walk(top):
    p = p[len(top)+1:]
    for j in f:
       yield os.path.join(p,j)
$_$;


ALTER FUNCTION public.list_files(dir_option_name text) OWNER TO postgres;

--
-- Name: load_file(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION load_file(dir_option_name text, fname text) RETURNS bytea
    LANGUAGE plpythonu
    AS $_$
   ret = plpy.execute('select "value" from admin.global_preferences where fk_clinic=1 and fk_staff is null and "name" = $$%s$$ limit 1' % dir_option_name)
   if len(ret) == 0: plpy.error("No such option %s" % dir_option_name)
   f = open(ret[0]["value"]+'/'+fname,'r')
   d = f.read()
   f.close()
   return d
$_$;


ALTER FUNCTION public.load_file(dir_option_name text, fname text) OWNER TO postgres;

--
-- Name: new_uuid(uuid, integer); Type: FUNCTION; Schema: public; Owner: easygp
--

CREATE FUNCTION new_uuid(uuid, integer) RETURNS uuid
    LANGUAGE plpgsql
    AS $_$
DECLARE
  x integer;
BEGIN
   select "count" into x from multiple_packsize where fk_product = $1;
   if x = 1 then
       return $1;
   else 
       return  uuid_generate_v5(uuid_ns_url(),'http://easygp.net/new-uuids/' || $1 || '/' || $2);
   end if;
END
$_$;


ALTER FUNCTION public.new_uuid(uuid, integer) OWNER TO easygp;

--
-- Name: new_uuid(uuid, double precision); Type: FUNCTION; Schema: public; Owner: easygp
--

CREATE FUNCTION new_uuid(uuid, double precision) RETURNS uuid
    LANGUAGE plpgsql
    AS $_$
DECLARE
  x integer;
BEGIN
   select count(*) into x from new_product where new_uuid = $1;
   if x = 1 then
       return $1;
   else 
       return  uuid_generate_v5(uuid_ns_url(),'http://easygp.net/new-uuids2/' || $1 || '/' || $2);
   end if;
END
$_$;


ALTER FUNCTION public.new_uuid(uuid, double precision) OWNER TO easygp;

--
-- Name: pymax(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pymax(a integer, b integer) RETURNS integer
    LANGUAGE plpythonu
    AS $$
  if a > b:
    return a
  return b
$$;


ALTER FUNCTION public.pymax(a integer, b integer) OWNER TO postgres;

--
-- Name: save_file(text, text, bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION save_file(dir_option_name text, fname text, data bytea) RETURNS void
    LANGUAGE plpythonu
    AS $_$
   ret = plpy.execute('select "value" from admin.global_preferences where fk_clinic=1 and fk_staff is null and "name" = $$%s$$ limit 1' % dir_option_name)
   if len(ret) == 0: plpy.error("No such option %s" % dir_option_name)
   f = open(ret[0]["value"]+'/'+fname,'w')
   d = f.write(data)
   f.close()
$_$;


ALTER FUNCTION public.save_file(dir_option_name text, fname text, data bytea) OWNER TO postgres;

SET search_path = admin, pg_catalog;

--
-- Name: clinics; Type: TABLE; Schema: admin; Owner: easygp; Tablespace: 
--

CREATE TABLE clinics (
    pk integer NOT NULL,
    fk_branch integer NOT NULL
);


ALTER TABLE admin.clinics OWNER TO easygp;

--
-- Name: TABLE clinics; Type: COMMENT; Schema: admin; Owner: easygp
--

COMMENT ON TABLE clinics IS 'Probably temporary table till I figure out how to save clinic specific stuff';


--
-- Name: COLUMN clinics.fk_branch; Type: COMMENT; Schema: admin; Owner: easygp
--

COMMENT ON COLUMN clinics.fk_branch IS 'foreign key to contacts.branches table';


--
-- Name: clinic_pk_seq; Type: SEQUENCE; Schema: admin; Owner: easygp
--

CREATE SEQUENCE clinic_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE admin.clinic_pk_seq OWNER TO easygp;

--
-- Name: clinic_pk_seq; Type: SEQUENCE OWNED BY; Schema: admin; Owner: easygp
--

ALTER SEQUENCE clinic_pk_seq OWNED BY clinics.pk;


--
-- Name: clinic_rooms; Type: TABLE; Schema: admin; Owner: easygp; Tablespace: 
--

CREATE TABLE clinic_rooms (
    pk integer NOT NULL,
    room_name text NOT NULL,
    fk_clinic integer NOT NULL,
    script_printer text,
    default_printer text
);


ALTER TABLE admin.clinic_rooms OWNER TO easygp;

--
-- Name: TABLE clinic_rooms; Type: COMMENT; Schema: admin; Owner: easygp
--

COMMENT ON TABLE clinic_rooms IS 'links a name of a room to a clinic ie specifies locations within the practice(s)';


--
-- Name: COLUMN clinic_rooms.room_name; Type: COMMENT; Schema: admin; Owner: easygp
--

COMMENT ON COLUMN clinic_rooms.room_name IS 'the name of a location within the clinic for example Surgery1';


--
-- Name: COLUMN clinic_rooms.fk_clinic; Type: COMMENT; Schema: admin; Owner: easygp
--

COMMENT ON COLUMN clinic_rooms.fk_clinic IS 'foreign key to admin.clinics table';


--
-- Name: clinic_rooms_pk_seq; Type: SEQUENCE; Schema: admin; Owner: easygp
--

CREATE SEQUENCE clinic_rooms_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE admin.clinic_rooms_pk_seq OWNER TO easygp;

--
-- Name: clinic_rooms_pk_seq; Type: SEQUENCE OWNED BY; Schema: admin; Owner: easygp
--

ALTER SEQUENCE clinic_rooms_pk_seq OWNED BY clinic_rooms.pk;


--
-- Name: global_preferences; Type: TABLE; Schema: admin; Owner: easygp; Tablespace: 
--

CREATE TABLE global_preferences (
    pk integer NOT NULL,
    name text NOT NULL,
    value text,
    fk_clinic integer NOT NULL,
    fk_staff integer
);


ALTER TABLE admin.global_preferences OWNER TO easygp;

--
-- Name: COLUMN global_preferences.fk_staff; Type: COMMENT; Schema: admin; Owner: easygp
--

COMMENT ON COLUMN global_preferences.fk_staff IS 'if not null, then this is a staff preference';


--
-- Name: global_preferences_pk_seq; Type: SEQUENCE; Schema: admin; Owner: easygp
--

CREATE SEQUENCE global_preferences_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE admin.global_preferences_pk_seq OWNER TO easygp;

--
-- Name: global_preferences_pk_seq; Type: SEQUENCE OWNED BY; Schema: admin; Owner: easygp
--

ALTER SEQUENCE global_preferences_pk_seq OWNED BY global_preferences.pk;


--
-- Name: link_staff_clinics; Type: TABLE; Schema: admin; Owner: easygp; Tablespace: 
--

CREATE TABLE link_staff_clinics (
    pk integer NOT NULL,
    fk_staff integer NOT NULL,
    fk_clinic integer NOT NULL
);


ALTER TABLE admin.link_staff_clinics OWNER TO easygp;

--
-- Name: link_staff_clinics_pk_seq; Type: SEQUENCE; Schema: admin; Owner: easygp
--

CREATE SEQUENCE link_staff_clinics_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE admin.link_staff_clinics_pk_seq OWNER TO easygp;

--
-- Name: link_staff_clinics_pk_seq; Type: SEQUENCE OWNED BY; Schema: admin; Owner: easygp
--

ALTER SEQUENCE link_staff_clinics_pk_seq OWNED BY link_staff_clinics.pk;


--
-- Name: lu_clinical_modules; Type: TABLE; Schema: admin; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_clinical_modules (
    pk integer NOT NULL,
    name text NOT NULL,
    icon_path text NOT NULL
);


ALTER TABLE admin.lu_clinical_modules OWNER TO easygp;

--
-- Name: TABLE lu_clinical_modules; Type: COMMENT; Schema: admin; Owner: easygp
--

COMMENT ON TABLE lu_clinical_modules IS 'modules which could be available clinically';


--
-- Name: lu_clinical_modules_pk_seq; Type: SEQUENCE; Schema: admin; Owner: easygp
--

CREATE SEQUENCE lu_clinical_modules_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE admin.lu_clinical_modules_pk_seq OWNER TO easygp;

--
-- Name: lu_clinical_modules_pk_seq; Type: SEQUENCE OWNED BY; Schema: admin; Owner: easygp
--

ALTER SEQUENCE lu_clinical_modules_pk_seq OWNED BY lu_clinical_modules.pk;


--
-- Name: lu_staff_roles; Type: TABLE; Schema: admin; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_staff_roles (
    pk integer NOT NULL,
    role text NOT NULL
);


ALTER TABLE admin.lu_staff_roles OWNER TO easygp;

--
-- Name: TABLE lu_staff_roles; Type: COMMENT; Schema: admin; Owner: easygp
--

COMMENT ON TABLE lu_staff_roles IS 'Type of role in the organisation
	sysadmin, clinical, administrative';


--
-- Name: lu_staff_roles_pk_seq; Type: SEQUENCE; Schema: admin; Owner: easygp
--

CREATE SEQUENCE lu_staff_roles_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE admin.lu_staff_roles_pk_seq OWNER TO easygp;

--
-- Name: lu_staff_roles_pk_seq; Type: SEQUENCE OWNED BY; Schema: admin; Owner: easygp
--

ALTER SEQUENCE lu_staff_roles_pk_seq OWNED BY lu_staff_roles.pk;


--
-- Name: lu_staff_status; Type: TABLE; Schema: admin; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_staff_status (
    pk integer NOT NULL,
    status text NOT NULL
);


ALTER TABLE admin.lu_staff_status OWNER TO easygp;

--
-- Name: TABLE lu_staff_status; Type: COMMENT; Schema: admin; Owner: easygp
--

COMMENT ON TABLE lu_staff_status IS 'Working status of staff member
	e.g active = active in organisation
	    locum  = is a locum etc';


--
-- Name: lu_staff_status_pk_seq; Type: SEQUENCE; Schema: admin; Owner: easygp
--

CREATE SEQUENCE lu_staff_status_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE admin.lu_staff_status_pk_seq OWNER TO easygp;

--
-- Name: lu_staff_status_pk_seq; Type: SEQUENCE OWNED BY; Schema: admin; Owner: easygp
--

ALTER SEQUENCE lu_staff_status_pk_seq OWNED BY lu_staff_status.pk;


--
-- Name: lu_staff_type; Type: TABLE; Schema: admin; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_staff_type (
    pk integer NOT NULL,
    type text NOT NULL
);


ALTER TABLE admin.lu_staff_type OWNER TO easygp;

--
-- Name: TABLE lu_staff_type; Type: COMMENT; Schema: admin; Owner: easygp
--

COMMENT ON TABLE lu_staff_type IS 'Type of staff:
	Administrative
	Maintenance
	Medical
	Mental Health
	Nursing
	Paramedical
	Secretarial
	Speclialist
	or whatever these end up being
';


--
-- Name: lu_staff_type_pk_seq; Type: SEQUENCE; Schema: admin; Owner: easygp
--

CREATE SEQUENCE lu_staff_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE admin.lu_staff_type_pk_seq OWNER TO easygp;

--
-- Name: lu_staff_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: admin; Owner: easygp
--

ALTER SEQUENCE lu_staff_type_pk_seq OWNED BY lu_staff_type.pk;


--
-- Name: staff; Type: TABLE; Schema: admin; Owner: easygp; Tablespace: 
--

CREATE TABLE staff (
    pk integer NOT NULL,
    fk_person integer NOT NULL,
    fk_role integer NOT NULL,
    fk_status integer NOT NULL,
    logon_name text NOT NULL,
    logon_date_from date,
    logon_date_to date,
    fk_lu_staff_type integer DEFAULT 12 NOT NULL,
    qualifications text
);


ALTER TABLE admin.staff OWNER TO easygp;

--
-- Name: COLUMN staff.fk_lu_staff_type; Type: COMMENT; Schema: admin; Owner: easygp
--

COMMENT ON COLUMN staff.fk_lu_staff_type IS 'type of staff e.g 12 - clerical. As I added this later it couldn''t be null due to join 
in the vwStaffInclinics so users will have to go back fix their staff table (ie me), 
I will change this back to not null after I do this';


--
-- Name: staff_clinical_toolbar; Type: TABLE; Schema: admin; Owner: easygp; Tablespace: 
--

CREATE TABLE staff_clinical_toolbar (
    pk integer NOT NULL,
    fk_module integer NOT NULL,
    fk_staff integer NOT NULL,
    display_order integer NOT NULL,
    deleted boolean DEFAULT false
);


ALTER TABLE admin.staff_clinical_toolbar OWNER TO easygp;

--
-- Name: TABLE staff_clinical_toolbar; Type: COMMENT; Schema: admin; Owner: easygp
--

COMMENT ON TABLE staff_clinical_toolbar IS 'Links staff member to a toolbar button, allows staff to only put
  modules they want on the toolbar and in a particular order';


--
-- Name: staff_clinical_toolbar_pk_seq; Type: SEQUENCE; Schema: admin; Owner: easygp
--

CREATE SEQUENCE staff_clinical_toolbar_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE admin.staff_clinical_toolbar_pk_seq OWNER TO easygp;

--
-- Name: staff_clinical_toolbar_pk_seq; Type: SEQUENCE OWNED BY; Schema: admin; Owner: easygp
--

ALTER SEQUENCE staff_clinical_toolbar_pk_seq OWNED BY staff_clinical_toolbar.pk;


--
-- Name: staff_pk_seq; Type: SEQUENCE; Schema: admin; Owner: easygp
--

CREATE SEQUENCE staff_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE admin.staff_pk_seq OWNER TO easygp;

--
-- Name: staff_pk_seq; Type: SEQUENCE OWNED BY; Schema: admin; Owner: easygp
--

ALTER SEQUENCE staff_pk_seq OWNED BY staff.pk;


SET search_path = contacts, pg_catalog;

--
-- Name: data_addresses; Type: TABLE; Schema: contacts; Owner: easygp; Tablespace: 
--

CREATE TABLE data_addresses (
    pk integer NOT NULL,
    street1 text,
    fk_town integer,
    preferred_address boolean DEFAULT false,
    postal_address boolean DEFAULT false,
    head_office boolean DEFAULT false,
    geolocation point,
    country_code character(2),
    fk_lu_address_type integer,
    deleted boolean DEFAULT false,
    street2 text
);


ALTER TABLE contacts.data_addresses OWNER TO easygp;

--
-- Name: COLUMN data_addresses.geolocation; Type: COMMENT; Schema: contacts; Owner: easygp
--

COMMENT ON COLUMN data_addresses.geolocation IS 'geographical location latitude and longitude';


--
-- Name: COLUMN data_addresses.country_code; Type: COMMENT; Schema: contacts; Owner: easygp
--

COMMENT ON COLUMN data_addresses.country_code IS 'pointer to lu_country';


--
-- Name: COLUMN data_addresses.deleted; Type: COMMENT; Schema: contacts; Owner: easygp
--

COMMENT ON COLUMN data_addresses.deleted IS 'IF False then this address has had its link removed';


--
-- Name: data_branches; Type: TABLE; Schema: contacts; Owner: easygp; Tablespace: 
--

CREATE TABLE data_branches (
    pk integer NOT NULL,
    branch text,
    fk_organisation integer,
    fk_address integer,
    memo text,
    fk_category integer,
    deleted boolean DEFAULT false
);


ALTER TABLE contacts.data_branches OWNER TO easygp;

--
-- Name: COLUMN data_branches.memo; Type: COMMENT; Schema: contacts; Owner: easygp
--

COMMENT ON COLUMN data_branches.memo IS 'branch specific memo';


--
-- Name: COLUMN data_branches.deleted; Type: COMMENT; Schema: contacts; Owner: easygp
--

COMMENT ON COLUMN data_branches.deleted IS 'If true then the branch is marked as  deleted';


--
-- Name: data_organisations; Type: TABLE; Schema: contacts; Owner: easygp; Tablespace: 
--

CREATE TABLE data_organisations (
    pk integer NOT NULL,
    organisation text NOT NULL,
    deleted boolean DEFAULT false
);


ALTER TABLE contacts.data_organisations OWNER TO easygp;

--
-- Name: lu_address_types; Type: TABLE; Schema: contacts; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_address_types (
    pk integer NOT NULL,
    type text
);


ALTER TABLE contacts.lu_address_types OWNER TO easygp;

--
-- Name: lu_categories; Type: TABLE; Schema: contacts; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_categories (
    pk integer NOT NULL,
    category character varying(50) NOT NULL
);


ALTER TABLE contacts.lu_categories OWNER TO easygp;

--
-- Name: lu_towns; Type: TABLE; Schema: contacts; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_towns (
    pk integer NOT NULL,
    postcode character varying(4),
    town text,
    state character varying(3),
    comment text
);


ALTER TABLE contacts.lu_towns OWNER TO easygp;

--
-- Name: COLUMN lu_towns.comment; Type: COMMENT; Schema: contacts; Owner: easygp
--

COMMENT ON COLUMN lu_towns.comment IS 'really a qualifier, in the Australian context this field is usually null
 or the text:PO Boxes';


SET search_path = admin, pg_catalog;

--
-- Name: vwclinics; Type: VIEW; Schema: admin; Owner: easygp
--

CREATE VIEW vwclinics AS
    SELECT data_branches.pk AS pk_view, clinics.pk AS fk_clinic, clinics.fk_branch, data_branches.branch, data_branches.fk_address, data_branches.fk_organisation, data_organisations.organisation, data_addresses.street1, data_addresses.street2, data_addresses.fk_town, data_addresses.preferred_address, data_addresses.postal_address, data_addresses.head_office, data_addresses.geolocation, data_addresses.country_code, data_addresses.fk_lu_address_type, lu_address_types.type AS address_type, data_addresses.deleted, lu_towns.postcode, lu_towns.town, lu_towns.state, data_branches.memo AS memo_branches, data_organisations.deleted AS organisation_deleted, lu_categories.category FROM ((((((clinics JOIN contacts.data_branches ON ((clinics.fk_branch = data_branches.pk))) JOIN contacts.data_organisations ON ((data_branches.fk_organisation = data_organisations.pk))) LEFT JOIN contacts.data_addresses ON ((data_branches.fk_address = data_addresses.pk))) LEFT JOIN contacts.lu_address_types ON ((data_addresses.fk_lu_address_type = lu_address_types.pk))) JOIN contacts.lu_towns ON ((data_addresses.fk_town = lu_towns.pk))) JOIN contacts.lu_categories ON ((data_branches.fk_category = lu_categories.pk))) ORDER BY data_organisations.organisation, data_branches.fk_address;


ALTER TABLE admin.vwclinics OWNER TO easygp;

--
-- Name: vwclinicrooms; Type: VIEW; Schema: admin; Owner: easygp
--

CREATE VIEW vwclinicrooms AS
    SELECT clinic_rooms.pk, clinic_rooms.room_name, clinic_rooms.script_printer, clinic_rooms.default_printer, clinic_rooms.fk_clinic, vwclinics.organisation, vwclinics.branch, vwclinics.street1, vwclinics.street2, vwclinics.town FROM clinic_rooms, vwclinics WHERE (clinic_rooms.fk_clinic = vwclinics.fk_clinic) ORDER BY clinic_rooms.fk_clinic, clinic_rooms.room_name;


ALTER TABLE admin.vwclinicrooms OWNER TO easygp;

SET search_path = contacts, pg_catalog;

--
-- Name: data_numbers; Type: TABLE; Schema: contacts; Owner: easygp; Tablespace: 
--

CREATE TABLE data_numbers (
    fk_person integer,
    fk_branch integer,
    provider_number text,
    prescriber_number text,
    australian_business_number text,
    pk integer NOT NULL
);


ALTER TABLE contacts.data_numbers OWNER TO easygp;

--
-- Name: TABLE data_numbers; Type: COMMENT; Schema: contacts; Owner: easygp
--

COMMENT ON TABLE data_numbers IS 'table for various types of numbers for persons or organisations
      e.g Medicare provider numbers and prescriber numbers, australian business numbers.
      Used to be in admin.staff, but now here because we need to record provider numbers 
      for external contacts too.';


--
-- Name: COLUMN data_numbers.fk_branch; Type: COMMENT; Schema: contacts; Owner: easygp
--

COMMENT ON COLUMN data_numbers.fk_branch IS 'can be NULL for individuals in solo practices who aren''t part of an ''organisation'' in our system.';


--
-- Name: COLUMN data_numbers.provider_number; Type: COMMENT; Schema: contacts; Owner: easygp
--

COMMENT ON COLUMN data_numbers.provider_number IS 'the Medicare Australia alphanumeric provider number. ';


--
-- Name: data_persons; Type: TABLE; Schema: contacts; Owner: easygp; Tablespace: 
--

CREATE TABLE data_persons (
    pk integer NOT NULL,
    firstname text,
    surname text,
    salutation text,
    birthdate date,
    fk_ethnicity integer,
    fk_language integer,
    memo text,
    fk_marital integer DEFAULT 0,
    fk_title integer DEFAULT 7,
    fk_sex integer,
    country_code text,
    fk_image integer,
    retired boolean DEFAULT false,
    fk_occupation integer,
    deleted boolean DEFAULT false,
    deceased boolean DEFAULT false,
    date_deceased date,
    language_problems boolean DEFAULT false,
    surname_normalised text
);


ALTER TABLE contacts.data_persons OWNER TO easygp;

--
-- Name: COLUMN data_persons.country_code; Type: COMMENT; Schema: contacts; Owner: easygp
--

COMMENT ON COLUMN data_persons.country_code IS 'This code if not null refers to common.lu_countries and is the country of origin or the patient, normally country of birth';


--
-- Name: COLUMN data_persons.fk_occupation; Type: COMMENT; Schema: contacts; Owner: easygp
--

COMMENT ON COLUMN data_persons.fk_occupation IS 'maybe a temporary column - at the moment only used to record a single occupation 
of a person who is not in an organisation';


--
-- Name: COLUMN data_persons.language_problems; Type: COMMENT; Schema: contacts; Owner: easygp
--

COMMENT ON COLUMN data_persons.language_problems IS 'so named in case EasyGP used outside of english speaking country, ie this field could have
 been called difficult_with_english, but the intent is that the person/patient cannot speak 
 or has difficulty understanding the predominant language in your country';


--
-- Name: lu_title; Type: TABLE; Schema: contacts; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_title (
    pk integer NOT NULL,
    title text
);


ALTER TABLE contacts.lu_title OWNER TO easygp;

SET search_path = admin, pg_catalog;

--
-- Name: vwstaff; Type: VIEW; Schema: admin; Owner: easygp
--

CREATE VIEW vwstaff AS
    SELECT roles.role, staff.fk_person, staff.logon_name, staff.fk_role, staff.pk, staff.pk AS fk_staff, persons.firstname, persons.surname, ((persons.firstname || ' '::text) || persons.surname) AS wholename, persons.salutation, persons.fk_title, lu_title.title, staff.qualifications, persons.surname_normalised, data_numbers.provider_number, data_numbers.prescriber_number, data_numbers.australian_business_number FROM ((((staff staff JOIN lu_staff_roles roles ON ((staff.fk_role = roles.pk))) JOIN contacts.data_persons persons ON ((staff.fk_person = persons.pk))) JOIN contacts.lu_title ON ((persons.fk_title = lu_title.pk))) LEFT JOIN contacts.data_numbers ON ((staff.fk_person = data_numbers.fk_person)));


ALTER TABLE admin.vwstaff OWNER TO easygp;

SET search_path = blobs, pg_catalog;

--
-- Name: images; Type: TABLE; Schema: blobs; Owner: easygp; Tablespace: 
--

CREATE TABLE images (
    pk integer NOT NULL,
    image bytea,
    deleted boolean DEFAULT false,
    fk_consult integer,
    md5sum text,
    tag text
);


ALTER TABLE blobs.images OWNER TO easygp;

--
-- Name: TABLE images; Type: COMMENT; Schema: blobs; Owner: easygp
--

COMMENT ON TABLE images IS 'contains only images, artificial separation from other blobs';


--
-- Name: COLUMN images.deleted; Type: COMMENT; Schema: blobs; Owner: easygp
--

COMMENT ON COLUMN images.deleted IS 'if true the images is marked deleted not removed';


--
-- Name: COLUMN images.fk_consult; Type: COMMENT; Schema: blobs; Owner: easygp
--

COMMENT ON COLUMN images.fk_consult IS 'if not null, points to date/patient when image captured/imported';


--
-- Name: COLUMN images.md5sum; Type: COMMENT; Schema: blobs; Owner: easygp
--

COMMENT ON COLUMN images.md5sum IS 'the md5sum of the image imported';


--
-- Name: COLUMN images.tag; Type: COMMENT; Schema: blobs; Owner: easygp
--

COMMENT ON COLUMN images.tag IS 'a descriptive tag of an image e.g Basal Cell Carcinoma - Left Ear';


SET search_path = common, pg_catalog;

--
-- Name: lu_ethnicity; Type: TABLE; Schema: common; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_ethnicity (
    pk integer NOT NULL,
    ethnicity text NOT NULL
);


ALTER TABLE common.lu_ethnicity OWNER TO easygp;

--
-- Name: lu_languages; Type: TABLE; Schema: common; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_languages (
    pk integer NOT NULL,
    language text NOT NULL
);


ALTER TABLE common.lu_languages OWNER TO easygp;

--
-- Name: lu_occupations; Type: TABLE; Schema: common; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_occupations (
    pk integer NOT NULL,
    occupation text NOT NULL,
    referrer_type character(1) DEFAULT 'o'::bpchar,
    CONSTRAINT lu_occupations_referrer_type_check CHECK ((referrer_type = ANY (ARRAY['o'::bpchar, 'g'::bpchar, 's'::bpchar])))
);


ALTER TABLE common.lu_occupations OWNER TO easygp;

SET search_path = contacts, pg_catalog;

--
-- Name: data_employees; Type: TABLE; Schema: contacts; Owner: easygp; Tablespace: 
--

CREATE TABLE data_employees (
    pk integer NOT NULL,
    fk_branch integer,
    fk_person integer,
    fk_occupation integer,
    memo text,
    deleted boolean DEFAULT false,
    fk_status integer DEFAULT 0
);


ALTER TABLE contacts.data_employees OWNER TO easygp;

--
-- Name: COLUMN data_employees.deleted; Type: COMMENT; Schema: contacts; Owner: easygp
--

COMMENT ON COLUMN data_employees.deleted IS 'If True then the person is marked as no longer attatched to current branch
 though of course is not removed from the database';


--
-- Name: COLUMN data_employees.fk_status; Type: COMMENT; Schema: contacts; Owner: easygp
--

COMMENT ON COLUMN data_employees.fk_status IS 'employement status, foreign key to admin.lu_status FIXME SHIFT THIS TO CONTACTS AND
 FIX ASSOCIATED STAFF QUERIES - eg 0 = active';


--
-- Name: lu_employee_status; Type: TABLE; Schema: contacts; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_employee_status (
    pk integer NOT NULL,
    status text NOT NULL
);


ALTER TABLE contacts.lu_employee_status OWNER TO easygp;

--
-- Name: TABLE lu_employee_status; Type: COMMENT; Schema: contacts; Owner: easygp
--

COMMENT ON TABLE lu_employee_status IS 'Working status of staff member
	e.g active = active in organisation';


--
-- Name: lu_marital; Type: TABLE; Schema: contacts; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_marital (
    pk integer NOT NULL,
    marital text
);


ALTER TABLE contacts.lu_marital OWNER TO easygp;

--
-- Name: lu_sex; Type: TABLE; Schema: contacts; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_sex (
    pk integer NOT NULL,
    sex text,
    sex_text text
);


ALTER TABLE contacts.lu_sex OWNER TO easygp;

SET search_path = admin, pg_catalog;

--
-- Name: vwstaffinclinics; Type: VIEW; Schema: admin; Owner: easygp
--

CREATE VIEW vwstaffinclinics AS
    SELECT ((staff.pk || '-'::text) || data_addresses.pk) AS pk_view, ((data_persons.firstname || ' '::text) || data_persons.surname) AS wholename, staff.fk_person, staff.fk_role, staff.fk_status, staff.logon_name, data_numbers.provider_number, data_numbers.prescriber_number, staff.fk_lu_staff_type, staff.logon_date_from, staff.logon_date_to, link_staff_clinics1.fk_staff, link_staff_clinics1.fk_clinic, clinics.fk_branch, data_branches.branch, data_branches.fk_organisation, data_branches.fk_address, data_branches.memo AS branch_memo, data_branches.fk_category AS branch_category, data_branches.deleted AS branch_deleted, data_employees.pk AS fk_employee, data_employees.fk_occupation, data_employees.memo AS employee_memo, data_employees.deleted AS employee_deleted, data_persons.firstname, data_persons.surname, data_persons.salutation, data_persons.birthdate, data_persons.fk_ethnicity, data_persons.fk_language, data_persons.memo AS person_memo, data_persons.fk_marital, data_persons.fk_title, data_persons.fk_sex, data_persons.country_code AS person_country_code, data_persons.fk_image, data_persons.retired, data_persons.deleted AS person_deleted, data_persons.deceased, data_persons.date_deceased, lu_title.title, lu_marital.marital, lu_sex.sex, lu_occupations.occupation, lu_ethnicity.ethnicity, lu_languages.language, images.image, images.md5sum, images.tag, images.fk_consult AS fk_consult_image, images.deleted AS image_deleted, lu_staff_roles.role, lu_staff_type.type AS staff_type, lu_employee_status.status, data_organisations.organisation, data_organisations.deleted AS organisation_deleted, data_addresses.street1, data_addresses.street2, data_addresses.fk_town, lu_address_types.type AS address_type, data_addresses.preferred_address, data_addresses.postal_address, data_addresses.head_office, data_addresses.geolocation, data_addresses.country_code, data_addresses.fk_lu_address_type, data_addresses.deleted AS address_deleted, lu_towns.postcode, lu_towns.town, lu_towns.state, link_staff_clinics1.pk AS fk_link_staff_clinic, staff.qualifications, data_persons.surname_normalised FROM ((((((((((((((((((((staff JOIN link_staff_clinics link_staff_clinics1 ON ((staff.pk = link_staff_clinics1.fk_staff))) JOIN clinics ON ((link_staff_clinics1.fk_clinic = clinics.pk))) JOIN contacts.data_employees ON (((staff.fk_person = data_employees.fk_person) AND (clinics.fk_branch = data_employees.fk_branch)))) JOIN contacts.data_branches ON ((clinics.fk_branch = data_branches.pk))) JOIN contacts.data_persons ON ((data_employees.fk_person = data_persons.pk))) JOIN lu_staff_type ON ((staff.fk_lu_staff_type = lu_staff_type.pk))) LEFT JOIN contacts.lu_sex ON ((data_persons.fk_sex = lu_sex.pk))) LEFT JOIN contacts.data_numbers ON (((data_numbers.fk_person = staff.fk_person) AND (clinics.fk_branch = data_numbers.fk_branch)))) LEFT JOIN contacts.lu_marital ON ((data_persons.fk_marital = lu_marital.pk))) LEFT JOIN contacts.lu_title ON ((data_persons.fk_title = lu_title.pk))) LEFT JOIN common.lu_occupations ON ((data_employees.fk_occupation = lu_occupations.pk))) LEFT JOIN common.lu_ethnicity ON ((data_persons.fk_ethnicity = lu_ethnicity.pk))) LEFT JOIN common.lu_languages ON ((data_persons.fk_language = lu_languages.pk))) LEFT JOIN blobs.images ON ((data_persons.fk_image = images.pk))) JOIN lu_staff_roles ON ((staff.fk_role = lu_staff_roles.pk))) JOIN contacts.lu_employee_status ON ((staff.fk_status = lu_employee_status.pk))) JOIN contacts.data_organisations ON ((data_branches.fk_organisation = data_organisations.pk))) LEFT JOIN contacts.data_addresses ON ((data_branches.fk_address = data_addresses.pk))) LEFT JOIN contacts.lu_towns ON ((data_addresses.fk_town = lu_towns.pk))) LEFT JOIN contacts.lu_address_types ON ((data_addresses.fk_lu_address_type = lu_address_types.pk)));


ALTER TABLE admin.vwstaffinclinics OWNER TO easygp;

--
-- Name: vwstafftoolbarbuttons; Type: VIEW; Schema: admin; Owner: easygp
--

CREATE VIEW vwstafftoolbarbuttons AS
    SELECT lu_clinical_modules.pk AS pk_module, staff_clinical_toolbar.pk AS fk_staff_clinical_toolbar, staff_clinical_toolbar.display_order, lu_clinical_modules.name, lu_clinical_modules.icon_path, staff_clinical_toolbar.fk_staff, staff_clinical_toolbar.deleted FROM staff_clinical_toolbar, vwstaff, lu_clinical_modules WHERE ((staff_clinical_toolbar.fk_staff = vwstaff.fk_staff) AND (staff_clinical_toolbar.fk_module = lu_clinical_modules.pk)) ORDER BY staff_clinical_toolbar.fk_staff, staff_clinical_toolbar.display_order;


ALTER TABLE admin.vwstafftoolbarbuttons OWNER TO easygp;

SET search_path = billing, pg_catalog;

--
-- Name: bulk_billing_claims; Type: TABLE; Schema: billing; Owner: easygp; Tablespace: 
--

CREATE TABLE bulk_billing_claims (
    pk integer NOT NULL,
    claim_id text NOT NULL,
    claim_date date,
    claim_amount money NOT NULL,
    voucher_count integer NOT NULL,
    finalised boolean DEFAULT false,
    fk_branch integer NOT NULL,
    fk_medclaim integer,
    fk_lu_bulk_billing_type integer NOT NULL,
    fk_staff_provided_service integer NOT NULL,
    fk_staff_processed integer NOT NULL,
    html text NOT NULL
);


ALTER TABLE billing.bulk_billing_claims OWNER TO easygp;

--
-- Name: TABLE bulk_billing_claims; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON TABLE bulk_billing_claims IS 'Contains informaton about batching of bulk billing claims';


--
-- Name: COLUMN bulk_billing_claims.claim_id; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN bulk_billing_claims.claim_id IS 'The medicare issued coverslip number which accompanies the claim';


--
-- Name: COLUMN bulk_billing_claims.claim_date; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN bulk_billing_claims.claim_date IS 'The date on which the claim was processed (paper) or lodged (medclaims)';


--
-- Name: COLUMN bulk_billing_claims.voucher_count; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN bulk_billing_claims.voucher_count IS 'the number of vouchers in the claim';


--
-- Name: COLUMN bulk_billing_claims.fk_lu_bulk_billing_type; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN bulk_billing_claims.fk_lu_bulk_billing_type IS 'key to billing.fk_lu_bulk_billing_type 1=medicare 2=veterans';


--
-- Name: COLUMN bulk_billing_claims.fk_staff_processed; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN bulk_billing_claims.fk_staff_processed IS 'key to admin.staff table = staff member who processed this claim';


--
-- Name: COLUMN bulk_billing_claims.html; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN bulk_billing_claims.html IS 'html summary of the bulk billing claim';


--
-- Name: bulk_billing_claims_pk_seq; Type: SEQUENCE; Schema: billing; Owner: easygp
--

CREATE SEQUENCE bulk_billing_claims_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE billing.bulk_billing_claims_pk_seq OWNER TO easygp;

--
-- Name: bulk_billing_claims_pk_seq; Type: SEQUENCE OWNED BY; Schema: billing; Owner: easygp
--

ALTER SEQUENCE bulk_billing_claims_pk_seq OWNED BY bulk_billing_claims.pk;


--
-- Name: fee_schedule; Type: TABLE; Schema: billing; Owner: easygp; Tablespace: 
--

CREATE TABLE fee_schedule (
    pk integer NOT NULL,
    item text,
    mbs_item text,
    user_item text,
    ama_item text,
    descriptor text NOT NULL,
    ceased_date date,
    "group" text,
    derived_fee text,
    descriptor_brief text,
    gst_rate integer DEFAULT 0,
    percentage_fee_rule boolean DEFAULT false,
    number_of_patients integer DEFAULT 1,
    CONSTRAINT schedule_check CHECK ((((NOT (mbs_item IS NULL)) OR (NOT (ama_item IS NULL))) OR (NOT (user_item IS NULL))))
);


ALTER TABLE billing.fee_schedule OWNER TO easygp;

--
-- Name: TABLE fee_schedule; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON TABLE fee_schedule IS 'the Schedule of Fees this may be medicare benefit schedule or added by the user';


--
-- Name: COLUMN fee_schedule.mbs_item; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN fee_schedule.mbs_item IS 'the item number in the Medicare Benefits Schedule or user schedule, NULL only if only appears on AMA Schedule';


--
-- Name: COLUMN fee_schedule.user_item; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN fee_schedule.user_item IS 'if the item is defined by the user';


--
-- Name: COLUMN fee_schedule.ama_item; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN fee_schedule.ama_item IS 'the item number in the AMA version of the schedule, if used, otherwise NULL';


--
-- Name: COLUMN fee_schedule.descriptor_brief; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN fee_schedule.descriptor_brief IS 'a brief description of a long descriptor';


--
-- Name: COLUMN fee_schedule.gst_rate; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN fee_schedule.gst_rate IS 'the goods and services tax rate';


--
-- Name: fee_schedule_pk_seq; Type: SEQUENCE; Schema: billing; Owner: easygp
--

CREATE SEQUENCE fee_schedule_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE billing.fee_schedule_pk_seq OWNER TO easygp;

--
-- Name: fee_schedule_pk_seq; Type: SEQUENCE OWNED BY; Schema: billing; Owner: easygp
--

ALTER SEQUENCE fee_schedule_pk_seq OWNED BY fee_schedule.pk;


--
-- Name: invoices; Type: TABLE; Schema: billing; Owner: easygp; Tablespace: 
--

CREATE TABLE invoices (
    pk integer NOT NULL,
    fk_staff_invoicing integer NOT NULL,
    date_printed timestamp without time zone,
    notes text,
    fk_staff_provided_service integer NOT NULL,
    fk_patient integer,
    date_invoiced timestamp without time zone DEFAULT now() NOT NULL,
    paid boolean DEFAULT false NOT NULL,
    fk_payer_person integer,
    fk_payer_branch integer,
    latex text,
    fk_branch integer NOT NULL,
    visit_date date,
    reference text,
    fk_lu_bulk_billing_type integer,
    fk_appointment integer,
    total_bill money DEFAULT '$0.00'::money NOT NULL,
    total_gst money DEFAULT '$0.00'::money NOT NULL,
    total_paid money DEFAULT '$0.00'::money NOT NULL
);


ALTER TABLE billing.invoices OWNER TO easygp;

--
-- Name: TABLE invoices; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON TABLE invoices IS 'any invoices generated';


--
-- Name: COLUMN invoices.fk_staff_invoicing; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN invoices.fk_staff_invoicing IS 'the staff member raising the invoice';


--
-- Name: COLUMN invoices.notes; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN invoices.notes IS 'Any additional comments pertaining to the invoice or any of it''s
  items eg if the item was WCO002 (workcover case conference per 5mins)
  then the comment may be ''Conference with Mr P Smith about Return to Work Plan''';


--
-- Name: COLUMN invoices.fk_staff_provided_service; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN invoices.fk_staff_provided_service IS 'the staff member who provider the service on which the invoice is based';


--
-- Name: COLUMN invoices.fk_payer_person; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN invoices.fk_payer_person IS 'if not null then the key to the person who pays the bill';


--
-- Name: COLUMN invoices.fk_payer_branch; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN invoices.fk_payer_branch IS 'if not null then payer is an organisation/branch';


--
-- Name: COLUMN invoices.latex; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN invoices.latex IS 'the LaTeX definition of the invoice generated';


--
-- Name: COLUMN invoices.fk_branch; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN invoices.fk_branch IS 'The branch at which the patient was provided with the service';


--
-- Name: COLUMN invoices.visit_date; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN invoices.visit_date IS 'The date time of the patient visit - may be null because the invoice could be raised not in relation to a visit';


--
-- Name: COLUMN invoices.reference; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN invoices.reference IS 'text of any insurance or bill reference eg ''CLAIM NO:1234''';


--
-- Name: COLUMN invoices.fk_lu_bulk_billing_type; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN invoices.fk_lu_bulk_billing_type IS 'if not null then the type of bulk-bill 1=medicare 2=veteran';


--
-- Name: invoices_pk_seq; Type: SEQUENCE; Schema: billing; Owner: easygp
--

CREATE SEQUENCE invoices_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE billing.invoices_pk_seq OWNER TO easygp;

--
-- Name: invoices_pk_seq; Type: SEQUENCE OWNED BY; Schema: billing; Owner: easygp
--

ALTER SEQUENCE invoices_pk_seq OWNED BY invoices.pk;


--
-- Name: items_billed; Type: TABLE; Schema: billing; Owner: easygp; Tablespace: 
--

CREATE TABLE items_billed (
    pk integer NOT NULL,
    fk_fee_schedule integer NOT NULL,
    amount money NOT NULL,
    fk_invoice integer NOT NULL,
    fk_lu_billing_type integer NOT NULL,
    amount_gst money
);


ALTER TABLE billing.items_billed OWNER TO easygp;

--
-- Name: TABLE items_billed; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON TABLE items_billed IS 'contains all the items as per shedule billed on the invoice';


--
-- Name: items_billed_pk_seq; Type: SEQUENCE; Schema: billing; Owner: easygp
--

CREATE SEQUENCE items_billed_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE billing.items_billed_pk_seq OWNER TO easygp;

--
-- Name: items_billed_pk_seq; Type: SEQUENCE OWNED BY; Schema: billing; Owner: easygp
--

ALTER SEQUENCE items_billed_pk_seq OWNED BY items_billed.pk;


--
-- Name: link_invoice_bulk_bill_claim; Type: TABLE; Schema: billing; Owner: easygp; Tablespace: 
--

CREATE TABLE link_invoice_bulk_bill_claim (
    pk integer NOT NULL,
    fk_claim integer NOT NULL,
    fk_invoice integer NOT NULL
);


ALTER TABLE billing.link_invoice_bulk_bill_claim OWNER TO easygp;

--
-- Name: TABLE link_invoice_bulk_bill_claim; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON TABLE link_invoice_bulk_bill_claim IS 'links each bulk billing claim back to the invoice hence items billed';


--
-- Name: link_invoice_bulk_bill_claim_pk_seq; Type: SEQUENCE; Schema: billing; Owner: easygp
--

CREATE SEQUENCE link_invoice_bulk_bill_claim_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE billing.link_invoice_bulk_bill_claim_pk_seq OWNER TO easygp;

--
-- Name: link_invoice_bulk_bill_claim_pk_seq; Type: SEQUENCE OWNED BY; Schema: billing; Owner: easygp
--

ALTER SEQUENCE link_invoice_bulk_bill_claim_pk_seq OWNED BY link_invoice_bulk_bill_claim.pk;


--
-- Name: lu_billing_type; Type: TABLE; Schema: billing; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_billing_type (
    pk integer NOT NULL,
    type text NOT NULL
);


ALTER TABLE billing.lu_billing_type OWNER TO easygp;

--
-- Name: TABLE lu_billing_type; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON TABLE lu_billing_type IS 'the various types of billing eg AMA, Schedule Fee, Private etc.';


--
-- Name: lu_billing_type_pk_seq; Type: SEQUENCE; Schema: billing; Owner: easygp
--

CREATE SEQUENCE lu_billing_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE billing.lu_billing_type_pk_seq OWNER TO easygp;

--
-- Name: lu_billing_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: billing; Owner: easygp
--

ALTER SEQUENCE lu_billing_type_pk_seq OWNED BY lu_billing_type.pk;


--
-- Name: lu_bulk_billing_type; Type: TABLE; Schema: billing; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_bulk_billing_type (
    pk integer NOT NULL,
    type text NOT NULL
);


ALTER TABLE billing.lu_bulk_billing_type OWNER TO easygp;

--
-- Name: TABLE lu_bulk_billing_type; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON TABLE lu_bulk_billing_type IS 'the type of bulk-bill 1=medicare 2=veterans';


--
-- Name: lu_bulk_billing_type_pk_seq; Type: SEQUENCE; Schema: billing; Owner: easygp
--

CREATE SEQUENCE lu_bulk_billing_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE billing.lu_bulk_billing_type_pk_seq OWNER TO easygp;

--
-- Name: lu_bulk_billing_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: billing; Owner: easygp
--

ALTER SEQUENCE lu_bulk_billing_type_pk_seq OWNED BY lu_bulk_billing_type.pk;


--
-- Name: lu_default_billing_level; Type: TABLE; Schema: billing; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_default_billing_level (
    pk integer NOT NULL,
    level text NOT NULL
);


ALTER TABLE billing.lu_default_billing_level OWNER TO easygp;

--
-- Name: TABLE lu_default_billing_level; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON TABLE lu_default_billing_level IS ' the default level of billing that a practice decides to give to a patient/client
 eg bulk bill (either medicare or veterans) private or concession of some type';


--
-- Name: lu_default_billing_level_pk_seq; Type: SEQUENCE; Schema: billing; Owner: easygp
--

CREATE SEQUENCE lu_default_billing_level_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE billing.lu_default_billing_level_pk_seq OWNER TO easygp;

--
-- Name: lu_default_billing_level_pk_seq; Type: SEQUENCE OWNED BY; Schema: billing; Owner: easygp
--

ALTER SEQUENCE lu_default_billing_level_pk_seq OWNED BY lu_default_billing_level.pk;


--
-- Name: lu_invoice_comments; Type: TABLE; Schema: billing; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_invoice_comments (
    pk integer NOT NULL,
    comment text NOT NULL
);


ALTER TABLE billing.lu_invoice_comments OWNER TO easygp;

--
-- Name: TABLE lu_invoice_comments; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON TABLE lu_invoice_comments IS 'Comments added to the invoice e.g ''not usual aftercare''';


--
-- Name: lu_invoice_comments_pk_seq; Type: SEQUENCE; Schema: billing; Owner: easygp
--

CREATE SEQUENCE lu_invoice_comments_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE billing.lu_invoice_comments_pk_seq OWNER TO easygp;

--
-- Name: lu_invoice_comments_pk_seq; Type: SEQUENCE OWNED BY; Schema: billing; Owner: easygp
--

ALTER SEQUENCE lu_invoice_comments_pk_seq OWNED BY lu_invoice_comments.pk;


--
-- Name: lu_payment_method; Type: TABLE; Schema: billing; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_payment_method (
    pk integer NOT NULL,
    method text NOT NULL
);


ALTER TABLE billing.lu_payment_method OWNER TO easygp;

--
-- Name: TABLE lu_payment_method; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON TABLE lu_payment_method IS 'the method of paying the invoice';


--
-- Name: lu_payment_method_pk_seq; Type: SEQUENCE; Schema: billing; Owner: easygp
--

CREATE SEQUENCE lu_payment_method_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE billing.lu_payment_method_pk_seq OWNER TO easygp;

--
-- Name: lu_payment_method_pk_seq; Type: SEQUENCE OWNED BY; Schema: billing; Owner: easygp
--

ALTER SEQUENCE lu_payment_method_pk_seq OWNED BY lu_payment_method.pk;


--
-- Name: lu_reasons_not_billed; Type: TABLE; Schema: billing; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_reasons_not_billed (
    pk integer NOT NULL,
    reason text NOT NULL
);


ALTER TABLE billing.lu_reasons_not_billed OWNER TO easygp;

--
-- Name: lu_reasons_not_billed_pk_seq; Type: SEQUENCE; Schema: billing; Owner: easygp
--

CREATE SEQUENCE lu_reasons_not_billed_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE billing.lu_reasons_not_billed_pk_seq OWNER TO easygp;

--
-- Name: lu_reasons_not_billed_pk_seq; Type: SEQUENCE OWNED BY; Schema: billing; Owner: easygp
--

ALTER SEQUENCE lu_reasons_not_billed_pk_seq OWNED BY lu_reasons_not_billed.pk;


--
-- Name: lu_reports; Type: TABLE; Schema: billing; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_reports (
    pk integer NOT NULL,
    report_title text
);


ALTER TABLE billing.lu_reports OWNER TO easygp;

--
-- Name: lu_reports_pk_seq; Type: SEQUENCE; Schema: billing; Owner: easygp
--

CREATE SEQUENCE lu_reports_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE billing.lu_reports_pk_seq OWNER TO easygp;

--
-- Name: lu_reports_pk_seq; Type: SEQUENCE OWNED BY; Schema: billing; Owner: easygp
--

ALTER SEQUENCE lu_reports_pk_seq OWNED BY lu_reports.pk;


--
-- Name: payments_received; Type: TABLE; Schema: billing; Owner: easygp; Tablespace: 
--

CREATE TABLE payments_received (
    pk integer NOT NULL,
    fk_invoice integer NOT NULL,
    referent text,
    amount money NOT NULL,
    fk_lu_payment_method integer,
    date_paid timestamp without time zone DEFAULT now() NOT NULL,
    fk_staff_receipted integer
);


ALTER TABLE billing.payments_received OWNER TO easygp;

--
-- Name: payments_received_pk_seq; Type: SEQUENCE; Schema: billing; Owner: easygp
--

CREATE SEQUENCE payments_received_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE billing.payments_received_pk_seq OWNER TO easygp;

--
-- Name: payments_received_pk_seq; Type: SEQUENCE OWNED BY; Schema: billing; Owner: easygp
--

ALTER SEQUENCE payments_received_pk_seq OWNED BY payments_received.pk;


--
-- Name: prices; Type: TABLE; Schema: billing; Owner: easygp; Tablespace: 
--

CREATE TABLE prices (
    pk integer NOT NULL,
    fk_fee_schedule integer NOT NULL,
    price money DEFAULT '$0.00'::money NOT NULL,
    fk_lu_billing_type integer NOT NULL,
    notes text
);


ALTER TABLE billing.prices OWNER TO easygp;

--
-- Name: COLUMN prices.price; Type: COMMENT; Schema: billing; Owner: easygp
--

COMMENT ON COLUMN prices.price IS 'the price to the patient';


--
-- Name: prices_pk_seq; Type: SEQUENCE; Schema: billing; Owner: easygp
--

CREATE SEQUENCE prices_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE billing.prices_pk_seq OWNER TO easygp;

--
-- Name: prices_pk_seq; Type: SEQUENCE OWNED BY; Schema: billing; Owner: easygp
--

ALTER SEQUENCE prices_pk_seq OWNED BY prices.pk;


--
-- Name: reports; Type: TABLE; Schema: billing; Owner: easygp; Tablespace: 
--

CREATE TABLE reports (
    pk integer NOT NULL,
    report_title text NOT NULL
);


ALTER TABLE billing.reports OWNER TO easygp;

--
-- Name: reports_pk_seq; Type: SEQUENCE; Schema: billing; Owner: easygp
--

CREATE SEQUENCE reports_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE billing.reports_pk_seq OWNER TO easygp;

--
-- Name: reports_pk_seq; Type: SEQUENCE OWNED BY; Schema: billing; Owner: easygp
--

ALTER SEQUENCE reports_pk_seq OWNED BY reports.pk;


SET search_path = clerical, pg_catalog;

--
-- Name: data_patients; Type: TABLE; Schema: clerical; Owner: easygp; Tablespace: 
--

CREATE TABLE data_patients (
    pk integer NOT NULL,
    fk_person integer NOT NULL,
    fk_doctor integer,
    fk_next_of_kin integer,
    fk_payer_person integer,
    fk_family integer,
    medicare_number character varying(10),
    medicare_ref_number text,
    medicare_expiry_date date,
    veteran_number character varying(10),
    veteran_specific_condition text,
    concession_card_number text,
    concession_card_expiry_date date,
    memo text,
    fk_legacy text,
    fk_lu_veteran_card_type integer,
    fk_lu_active_status integer,
    fk_lu_centrelink_card_type integer,
    fk_lu_aboriginality integer,
    fk_lu_private_health_fund integer,
    private_insurance boolean,
    fk_lu_default_billing_level integer,
    fk_payer_branch integer,
    nursing_home_resident boolean DEFAULT false
);


ALTER TABLE clerical.data_patients OWNER TO easygp;

--
-- Name: TABLE data_patients; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON TABLE data_patients IS 'Patient specific data, ie applies within the health care
sector only';


--
-- Name: COLUMN data_patients.fk_person; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON COLUMN data_patients.fk_person IS 'foreign key to contacts.data_persons table';


--
-- Name: COLUMN data_patients.fk_doctor; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON COLUMN data_patients.fk_doctor IS 'if not null this is the patients perferred doctor';


--
-- Name: COLUMN data_patients.fk_next_of_kin; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON COLUMN data_patients.fk_next_of_kin IS 'if not null points to person in the database who is the next of kin';


--
-- Name: COLUMN data_patients.fk_payer_person; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON COLUMN data_patients.fk_payer_person IS 'if the patient does not pay, this is the key to contacts.persons table this could be another patient, or a non-patient in the persons table';


--
-- Name: COLUMN data_patients.fk_family; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON COLUMN data_patients.fk_family IS 'foriegn key to clerical.data_families - links patients to a family unit';


--
-- Name: COLUMN data_patients.veteran_specific_condition; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON COLUMN data_patients.veteran_specific_condition IS 'the condition the veteran is entitled to if limited benefit';


--
-- Name: COLUMN data_patients.fk_legacy; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON COLUMN data_patients.fk_legacy IS 'the key from the legacy database for the patient';


--
-- Name: COLUMN data_patients.fk_lu_veteran_card_type; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON COLUMN data_patients.fk_lu_veteran_card_type IS 'the type of card 1 = full (gold) 2= specific entitlement (white)  3=war widow (lilac)';


--
-- Name: COLUMN data_patients.fk_lu_active_status; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON COLUMN data_patients.fk_lu_active_status IS 'key to clerical.lu_active_status 1= active 2 = inactive';


--
-- Name: COLUMN data_patients.fk_lu_centrelink_card_type; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON COLUMN data_patients.fk_lu_centrelink_card_type IS 'key to clerial.lu_centrelink_card_type - the 3 card types in Australia';


--
-- Name: COLUMN data_patients.fk_lu_private_health_fund; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON COLUMN data_patients.fk_lu_private_health_fund IS 'foreign key to clerical.lu_private_health_fund table listing nearly 40 private health funds';


--
-- Name: COLUMN data_patients.private_insurance; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON COLUMN data_patients.private_insurance IS 'boolean value if true the patient has private insurance';


--
-- Name: COLUMN data_patients.fk_lu_default_billing_level; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON COLUMN data_patients.fk_lu_default_billing_level IS 'the default billing level eg private';


--
-- Name: COLUMN data_patients.fk_payer_branch; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON COLUMN data_patients.fk_payer_branch IS 'if the patient does not pay, then the branch of the organisation in data_branches (e.g could be head office) is the payer';


--
-- Name: COLUMN data_patients.nursing_home_resident; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON COLUMN data_patients.nursing_home_resident IS 'If true the patient lives in an aged care facility
 the is used for the area-of-need billing';


SET search_path = billing, pg_catalog;

--
-- Name: vwbulkbilleditems; Type: VIEW; Schema: billing; Owner: easygp
--

CREATE VIEW vwbulkbilleditems AS
    SELECT items_billed.pk AS pk_items_billed, items_billed.fk_invoice, items_billed.amount, items_billed.fk_lu_billing_type, invoices.fk_branch, invoices.fk_patient, invoices.fk_staff_provided_service, fee_schedule.mbs_item, fee_schedule.item, invoices.paid, invoices.latex, invoices.fk_lu_bulk_billing_type, invoices.visit_date, ((data_persons.firstname || ' '::text) || data_persons.surname) AS patient_wholename, link_invoice_bulk_bill_claim.fk_claim FROM (((((invoices JOIN items_billed ON ((invoices.pk = items_billed.fk_invoice))) JOIN fee_schedule ON ((items_billed.fk_fee_schedule = fee_schedule.pk))) JOIN clerical.data_patients ON ((invoices.fk_patient = data_patients.pk))) JOIN contacts.data_persons ON ((data_patients.fk_person = data_persons.pk))) LEFT JOIN link_invoice_bulk_bill_claim ON ((invoices.pk = link_invoice_bulk_bill_claim.fk_invoice))) WHERE (invoices.fk_lu_bulk_billing_type IS NOT NULL);


ALTER TABLE billing.vwbulkbilleditems OWNER TO easygp;

SET search_path = clerical, pg_catalog;

--
-- Name: bookings; Type: TABLE; Schema: clerical; Owner: easygp; Tablespace: 
--

CREATE TABLE bookings (
    pk bigint NOT NULL,
    fk_patient integer,
    fk_staff integer NOT NULL,
    begin timestamp without time zone,
    duration interval,
    notes text,
    fk_staff_booked integer NOT NULL,
    booked_at timestamp without time zone DEFAULT now() NOT NULL,
    fk_clinic integer NOT NULL,
    deleted boolean DEFAULT false,
    fk_lu_appointment_icon integer,
    fk_lu_appointment_status integer DEFAULT 1,
    invoiced boolean DEFAULT false,
    did_not_attend boolean DEFAULT false,
    fk_lu_reason_not_billed integer
);


ALTER TABLE clerical.bookings OWNER TO easygp;

--
-- Name: TABLE bookings; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON TABLE bookings IS 'list of all bookings past and future. Note fk_patient can be NULL for non-patien things: meetings, holidays etc';


--
-- Name: COLUMN bookings.invoiced; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON COLUMN bookings.invoiced IS 'if true then the consultation has been invoiced (paid or account raised)';


--
-- Name: COLUMN bookings.did_not_attend; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON COLUMN bookings.did_not_attend IS 'if true then the the patient did not attend the appointment';


SET search_path = common, pg_catalog;

--
-- Name: lu_countries; Type: TABLE; Schema: common; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_countries (
    pk integer NOT NULL,
    country_code character(2) NOT NULL,
    country text NOT NULL
);


ALTER TABLE common.lu_countries OWNER TO easygp;

SET search_path = contacts, pg_catalog;

--
-- Name: links_persons_addresses; Type: TABLE; Schema: contacts; Owner: easygp; Tablespace: 
--

CREATE TABLE links_persons_addresses (
    pk integer NOT NULL,
    fk_address integer,
    fk_person integer,
    deleted boolean DEFAULT false
);


ALTER TABLE contacts.links_persons_addresses OWNER TO easygp;

--
-- Name: vworganisations_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: easygp
--

CREATE SEQUENCE vworganisations_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contacts.vworganisations_pk_seq OWNER TO easygp;

--
-- Name: vworganisations; Type: VIEW; Schema: contacts; Owner: easygp
--

CREATE VIEW vworganisations AS
    SELECT nextval('vworganisations_pk_seq'::regclass) AS pk_view, clinics.pk AS fk_clinic, organisations.organisation, organisations.deleted AS organisation_deleted, branches.pk AS fk_branch, branches.branch, branches.fk_organisation, branches.deleted AS branch_deleted, branches.fk_address, branches.memo, branches.fk_category, categories.category, addresses.street1, addresses.street2, addresses.fk_town, addresses.preferred_address, addresses.postal_address, addresses.head_office, addresses.country_code, addresses.fk_lu_address_type, addresses.deleted AS address_deleted, towns.postcode, towns.town, towns.state, data_numbers.australian_business_number FROM (((((((data_branches branches JOIN data_organisations organisations ON ((branches.fk_organisation = organisations.pk))) JOIN lu_categories categories ON ((branches.fk_category = categories.pk))) LEFT JOIN data_addresses addresses ON ((branches.fk_address = addresses.pk))) LEFT JOIN lu_address_types ON ((addresses.fk_lu_address_type = lu_address_types.pk))) LEFT JOIN lu_towns towns ON ((addresses.fk_town = towns.pk))) LEFT JOIN admin.clinics ON ((branches.pk = clinics.fk_branch))) LEFT JOIN data_numbers ON ((branches.pk = data_numbers.fk_branch))) ORDER BY nextval('vworganisations_pk_seq'::regclass), organisations.organisation, organisations.deleted;


ALTER TABLE contacts.vworganisations OWNER TO easygp;

--
-- Name: vwpersonsincludingpatients; Type: VIEW; Schema: contacts; Owner: easygp
--

CREATE VIEW vwpersonsincludingpatients AS
    SELECT persons.pk AS fk_person, CASE WHEN (addresses.pk > 0) THEN COALESCE(((persons.pk || '-'::text) || addresses.pk)) ELSE (persons.pk || '-0'::text) END AS pk_view, addresses.pk AS fk_address, (((title.title || ' '::text) || (persons.firstname || ' '::text)) || (persons.surname || ' '::text)) AS wholename, persons.firstname, persons.surname, persons.salutation, persons.birthdate, date_part('year'::text, age((persons.birthdate)::timestamp with time zone)) AS age, marital.marital, sex.sex, title.title, countries.country, languages.language, countries1.country AS country_birth, ethnicity.ethnicity, addresses.street1, addresses.street2, towns.town, towns.state, towns.postcode, addresses.fk_town, addresses.preferred_address, addresses.postal_address, addresses.head_office, addresses.geolocation, addresses.country_code, addresses.fk_lu_address_type AS fk_address_type, addresses.deleted AS address_deleted, persons.fk_ethnicity, persons.fk_language, persons.language_problems, persons.memo, persons.fk_marital, persons.country_code AS country_birth_country_code, persons.fk_title, persons.deceased, persons.date_deceased, persons.fk_sex, images.pk AS fk_image, images.image, images.md5sum, images.tag, images.fk_consult AS fk_consult_image, persons.surname_normalised FROM ((((((((((((data_persons persons LEFT JOIN clerical.data_patients ON ((persons.pk = data_patients.pk))) LEFT JOIN links_persons_addresses ON ((persons.pk = links_persons_addresses.fk_person))) LEFT JOIN lu_marital marital ON ((persons.fk_marital = marital.pk))) LEFT JOIN lu_sex sex ON ((persons.fk_sex = sex.pk))) LEFT JOIN common.lu_languages languages ON ((persons.fk_language = languages.pk))) LEFT JOIN lu_title title ON ((persons.fk_title = title.pk))) LEFT JOIN common.lu_ethnicity ethnicity ON ((persons.fk_ethnicity = ethnicity.pk))) LEFT JOIN blobs.images ON ((persons.fk_image = images.pk))) LEFT JOIN common.lu_countries countries ON ((persons.country_code = (countries.country_code)::text))) JOIN data_addresses addresses ON ((links_persons_addresses.fk_address = addresses.pk))) JOIN lu_towns towns ON ((addresses.fk_town = towns.pk))) LEFT JOIN common.lu_countries countries1 ON ((addresses.country_code = countries1.country_code)));


ALTER TABLE contacts.vwpersonsincludingpatients OWNER TO easygp;

--
-- Name: VIEW vwpersonsincludingpatients; Type: COMMENT; Schema: contacts; Owner: easygp
--

COMMENT ON VIEW vwpersonsincludingpatients IS 'temporary view until I fix it, a view of all persons including those who are patients';


SET search_path = billing, pg_catalog;

--
-- Name: vwdaylist; Type: VIEW; Schema: billing; Owner: postgres
--

CREATE VIEW vwdaylist AS
    SELECT ((bookings.pk || '-'::text) || items_billed.pk) AS pk_view, bookings.pk AS fk_appointment, bookings.fk_patient, bookings.fk_lu_reason_not_billed, data_patients.fk_lu_centrelink_card_type, invoices.pk AS fk_invoice, invoices.paid, invoices.fk_payer_person, invoices.fk_payer_branch, invoices.latex, invoices.total_bill, invoices.total_gst, invoices.total_paid, invoices.fk_staff_provided_service, invoices.fk_lu_bulk_billing_type, lu_bulk_billing_type.type AS bulk_billing_type, bookings.begin AS appointment_date, COALESCE(COALESCE(fee_schedule.ama_item, fee_schedule.mbs_item), fee_schedule.user_item) AS item, fee_schedule.descriptor_brief, items_billed.amount, items_billed.amount_gst, items_billed.pk AS fk_items_billed, payments_received.fk_lu_payment_method, payments_received.amount AS payment_amount, lu_billing_type.type AS billing_type, lu_payment_method.method AS payment_method, NULL::text AS reason_not_billed, (((lu_title.title || ' '::text) || (data_persons.firstname || ' '::text)) || (data_persons.surname || ' '::text)) AS wholename, data_persons.firstname, data_persons.surname, lu_title.title, data_persons.fk_sex, COALESCE(vworganisations.organisation, vwpersonsincludingpatients.wholename) AS account_to_name, clinics.fk_branch FROM (((((((((((((clerical.bookings JOIN invoices ON ((invoices.fk_appointment = bookings.pk))) JOIN admin.clinics ON ((bookings.fk_clinic = clinics.pk))) JOIN clerical.data_patients ON ((bookings.fk_patient = data_patients.pk))) LEFT JOIN lu_bulk_billing_type ON ((invoices.fk_lu_bulk_billing_type = lu_bulk_billing_type.pk))) JOIN items_billed ON ((invoices.pk = items_billed.fk_invoice))) JOIN fee_schedule ON ((items_billed.fk_fee_schedule = fee_schedule.pk))) JOIN lu_billing_type ON ((items_billed.fk_lu_billing_type = lu_billing_type.pk))) LEFT JOIN contacts.vworganisations ON ((invoices.fk_payer_branch = vworganisations.fk_branch))) LEFT JOIN contacts.vwpersonsincludingpatients ON ((invoices.fk_payer_person = vwpersonsincludingpatients.fk_person))) JOIN contacts.data_persons ON ((data_patients.fk_person = data_persons.pk))) JOIN contacts.lu_title ON ((data_persons.fk_title = lu_title.pk))) LEFT JOIN payments_received ON ((invoices.pk = payments_received.fk_invoice))) LEFT JOIN lu_payment_method ON ((payments_received.fk_lu_payment_method = lu_payment_method.pk))) WHERE (bookings.fk_lu_reason_not_billed IS NULL) UNION SELECT ((bookings.pk || '-'::text) || '0'::text) AS pk_view, bookings.pk AS fk_appointment, bookings.fk_patient, bookings.fk_lu_reason_not_billed, NULL::integer AS fk_lu_centrelink_card_type, NULL::integer AS fk_invoice, NULL::boolean AS paid, NULL::integer AS fk_payer_person, NULL::integer AS fk_payer_branch, NULL::text AS latex, NULL::money AS total_bill, NULL::money AS total_gst, NULL::money AS total_paid, bookings.fk_staff AS fk_staff_provided_service, NULL::integer AS fk_lu_bulk_billing_type, NULL::text AS bulk_billing_type, bookings.begin AS appointment_date, NULL::text AS item, NULL::text AS descriptor_brief, NULL::money AS amount, NULL::money AS amount_gst, NULL::integer AS fk_items_billed, NULL::integer AS fk_lu_payment_method, NULL::money AS payment_amount, NULL::text AS billing_type, NULL::text AS payment_method, lu_reasons_not_billed.reason AS reason_not_billed, (((lu_title.title || ' '::text) || (data_persons.firstname || ' '::text)) || (data_persons.surname || ' '::text)) AS wholename, data_persons.firstname, data_persons.surname, lu_title.title, data_persons.fk_sex, NULL::text AS account_to_name, clinics.fk_branch FROM (((((clerical.bookings JOIN clerical.data_patients ON ((bookings.fk_patient = data_patients.pk))) JOIN admin.clinics ON ((bookings.fk_clinic = clinics.pk))) LEFT JOIN lu_reasons_not_billed ON ((bookings.fk_lu_reason_not_billed = lu_reasons_not_billed.pk))) JOIN contacts.data_persons ON ((data_patients.fk_person = data_persons.pk))) JOIN contacts.lu_title ON ((data_persons.fk_title = lu_title.pk))) WHERE (bookings.fk_lu_reason_not_billed IS NOT NULL);


ALTER TABLE billing.vwdaylist OWNER TO postgres;

--
-- Name: vwfees; Type: VIEW; Schema: billing; Owner: easygp
--

CREATE VIEW vwfees AS
    SELECT prices.pk AS pk_view, fee_schedule.mbs_item, fee_schedule.user_item, fee_schedule.ama_item, fee_schedule.descriptor, fee_schedule.descriptor_brief, fee_schedule.gst_rate, fee_schedule.percentage_fee_rule, fee_schedule.ceased_date, fee_schedule."group", fee_schedule.derived_fee, fee_schedule.number_of_patients, prices.fk_fee_schedule, prices.pk AS fk_price, prices.price, prices.fk_lu_billing_type, prices.notes, lu_billing_type.type AS fee_type FROM ((fee_schedule JOIN prices ON ((fee_schedule.pk = prices.fk_fee_schedule))) JOIN lu_billing_type ON ((prices.fk_lu_billing_type = lu_billing_type.pk)));


ALTER TABLE billing.vwfees OWNER TO easygp;

SET search_path = clerical, pg_catalog;

--
-- Name: lu_active_status; Type: TABLE; Schema: clerical; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_active_status (
    pk integer NOT NULL,
    status text
);


ALTER TABLE clerical.lu_active_status OWNER TO easygp;

--
-- Name: TABLE lu_active_status; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON TABLE lu_active_status IS 'determines if the patient is an active patient or not 1- active 2 - inactive';


--
-- Name: lu_centrelink_card_type; Type: TABLE; Schema: clerical; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_centrelink_card_type (
    pk integer NOT NULL,
    type text NOT NULL
);


ALTER TABLE clerical.lu_centrelink_card_type OWNER TO easygp;

--
-- Name: TABLE lu_centrelink_card_type; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON TABLE lu_centrelink_card_type IS 'The different types of australian government centrelink entitlement cards';


--
-- Name: lu_private_health_funds; Type: TABLE; Schema: clerical; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_private_health_funds (
    pk integer NOT NULL,
    fund text NOT NULL,
    name_abbrev text NOT NULL,
    availability text NOT NULL,
    states_available text NOT NULL
);


ALTER TABLE clerical.lu_private_health_funds OWNER TO easygp;

--
-- Name: TABLE lu_private_health_funds; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON TABLE lu_private_health_funds IS 'a listing of private health funds available in australila http://www.privatehealth.gov.au/dynamic/healthfundlist.aspx accurate as of 22July12';


--
-- Name: lu_veteran_card_type; Type: TABLE; Schema: clerical; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_veteran_card_type (
    pk integer NOT NULL,
    type text NOT NULL
);


ALTER TABLE clerical.lu_veteran_card_type OWNER TO easygp;

--
-- Name: TABLE lu_veteran_card_type; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON TABLE lu_veteran_card_type IS 'The different types of veteran entitlement cards';


SET search_path = common, pg_catalog;

--
-- Name: lu_aboriginality; Type: TABLE; Schema: common; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_aboriginality (
    pk integer NOT NULL,
    aboriginality text NOT NULL
);


ALTER TABLE common.lu_aboriginality OWNER TO easygp;

SET search_path = contacts, pg_catalog;

--
-- Name: vwpatients; Type: VIEW; Schema: contacts; Owner: easygp
--

CREATE VIEW vwpatients AS
    SELECT CASE WHEN (addresses.pk IS NULL) THEN (patients.pk || '-0'::text) ELSE ((patients.pk || '-'::text) || addresses.pk) END AS pk_view, patients.pk AS fk_patient, link_person_address.fk_address, patients.fk_person, (((title.title || ' '::text) || (persons.firstname || ' '::text)) || (persons.surname || ' '::text)) AS wholename, patients.fk_doctor, patients.fk_next_of_kin, patients.fk_payer_person, patients.fk_payer_branch, patients.fk_family, patients.medicare_number, patients.medicare_ref_number, patients.medicare_expiry_date, patients.veteran_number, patients.veteran_specific_condition, patients.concession_card_number, patients.concession_card_expiry_date, patients.memo AS patient_memo, patients.fk_legacy, patients.fk_lu_aboriginality, patients.fk_lu_veteran_card_type, patients.fk_lu_active_status, patients.fk_lu_centrelink_card_type, patients.fk_lu_private_health_fund, patients.private_insurance, lu_active_status.status AS active_status, lu_veteran_card_type.type AS veteran_card_type, lu_centrelink_card_type.type AS concession_card_type, lu_private_health_funds.fund, persons.firstname, persons.surname, persons.salutation, persons.birthdate, public.age_display(age((persons.birthdate)::timestamp with time zone)) AS age_display, date_part('year'::text, age((persons.birthdate)::timestamp with time zone)) AS age_numeric, persons.fk_ethnicity, persons.fk_language, persons.memo AS person_memo, persons.fk_marital, persons.fk_title, persons.fk_sex, persons.country_code AS country_birth_country_code, persons.fk_image, persons.retired, persons.fk_occupation, persons.deleted AS person_deleted, persons.deceased, persons.date_deceased, persons.language_problems, persons.surname_normalised, lu_aboriginality.aboriginality, country_birth.country AS country_birth, lu_ethnicity.ethnicity, lu_languages.language, lu_occupations.occupation, lu_marital.marital, title.title, lu_sex.sex, lu_sex.sex_text, images.image, images.md5sum, images.tag, images.fk_consult AS fk_consult_image, link_person_address.pk AS fk_link_persons_address, addresses.street1, addresses.fk_town, addresses.preferred_address, addresses.postal_address, addresses.head_office, addresses.geolocation, addresses.country_code, addresses.fk_lu_address_type, addresses.deleted AS address_deleted, addresses.street2, address_country.country, link_person_address.deleted AS link_address_deleted, lu_address_types.type AS address_type, lu_towns.postcode, lu_towns.town, lu_towns.state, patients.fk_lu_default_billing_level, lu_default_billing_level.level AS billing_level, patients.nursing_home_resident FROM ((((((((((((((((((((clerical.data_patients patients JOIN clerical.lu_active_status lu_active_status ON ((patients.fk_lu_active_status = lu_active_status.pk))) LEFT JOIN clerical.lu_centrelink_card_type ON ((patients.fk_lu_centrelink_card_type = lu_centrelink_card_type.pk))) LEFT JOIN common.lu_aboriginality ON ((patients.fk_lu_aboriginality = lu_aboriginality.pk))) LEFT JOIN clerical.lu_veteran_card_type ON ((patients.fk_lu_veteran_card_type = lu_veteran_card_type.pk))) LEFT JOIN clerical.lu_private_health_funds ON ((patients.fk_lu_private_health_fund = lu_private_health_funds.pk))) LEFT JOIN billing.lu_default_billing_level ON ((patients.fk_lu_default_billing_level = lu_default_billing_level.pk))) JOIN data_persons persons ON ((patients.fk_person = persons.pk))) LEFT JOIN common.lu_ethnicity ON ((persons.fk_ethnicity = lu_ethnicity.pk))) LEFT JOIN common.lu_languages ON ((persons.fk_language = lu_languages.pk))) LEFT JOIN common.lu_occupations ON ((persons.fk_occupation = lu_occupations.pk))) LEFT JOIN lu_marital ON ((persons.fk_marital = lu_marital.pk))) LEFT JOIN lu_title title ON ((persons.fk_title = title.pk))) LEFT JOIN lu_sex ON ((persons.fk_sex = lu_sex.pk))) LEFT JOIN blobs.images images ON ((persons.fk_image = images.pk))) LEFT JOIN links_persons_addresses link_person_address ON ((persons.pk = link_person_address.fk_person))) LEFT JOIN data_addresses addresses ON ((link_person_address.fk_address = addresses.pk))) LEFT JOIN lu_address_types ON ((addresses.fk_lu_address_type = lu_address_types.pk))) LEFT JOIN lu_towns ON ((addresses.fk_town = lu_towns.pk))) LEFT JOIN common.lu_countries country_birth ON ((persons.country_code = (country_birth.country_code)::text))) LEFT JOIN common.lu_countries address_country ON ((addresses.country_code = address_country.country_code)));


ALTER TABLE contacts.vwpatients OWNER TO easygp;

SET search_path = billing, pg_catalog;

--
-- Name: vwinvoices; Type: VIEW; Schema: billing; Owner: easygp
--

CREATE VIEW vwinvoices AS
    SELECT invoices.pk AS pk_invoice, invoices.pk AS fk_invoice, invoices.notes, invoices.fk_staff_invoicing, invoices.fk_patient, invoices.date_printed, invoices.fk_staff_provided_service, invoices.date_invoiced, invoices.paid, invoices.fk_payer_person, invoices.fk_payer_branch, COALESCE(vworganisations.organisation, vwpersonsincludingpatients.wholename) AS account_to_name, vworganisations.branch AS account_to_branch, COALESCE(COALESCE((vworganisations.street1 || ' '::text), (vworganisations.street2 || ' '::text)), COALESCE((vwpersonsincludingpatients.street1 || ' '::text), (vwpersonsincludingpatients.street2 || ' '::text))) AS account_to_street, COALESCE(((vworganisations.town || ' '::text) || (vworganisations.postcode)::text), ((vwpersonsincludingpatients.town || ' '::text) || (vwpersonsincludingpatients.postcode)::text)) AS account_to_town_postcode, invoices.latex, invoices.fk_branch, invoices.visit_date, invoices.fk_appointment, bookings.begin AS appointment_time, bookings.duration, invoices.reference, invoices.fk_lu_bulk_billing_type, invoices.total_bill, invoices.total_paid, invoices.total_gst, (invoices.total_bill - invoices.total_paid) AS due, staff_invoicing.wholename AS staff_invoicing_wholename, staff_provider.wholename AS staff_provided_service_wholename, staff_provider.provider_number AS staff_provided_service_provider_number, staff_provider.australian_business_number, vwpatients.firstname AS patient_firstname, vwpatients.surname AS patient_surname, vwpatients.title AS patient_title, vwpatients.fk_sex AS patient_fk_sex, vwpatients.sex AS patient_sex, vwpatients.wholename AS patient_wholename, vwpatients.fk_lu_centrelink_card_type, vwpatients.fk_lu_default_billing_level, vworganisations1.branch FROM (((((((invoices JOIN admin.vwstaff staff_invoicing ON ((invoices.fk_staff_invoicing = staff_invoicing.fk_staff))) JOIN admin.vwstaff staff_provider ON ((invoices.fk_staff_provided_service = staff_provider.fk_staff))) JOIN contacts.vworganisations vworganisations1 ON ((invoices.fk_branch = vworganisations1.fk_branch))) LEFT JOIN clerical.bookings ON ((invoices.fk_appointment = bookings.pk))) LEFT JOIN contacts.vworganisations ON ((invoices.fk_payer_branch = vworganisations.fk_branch))) LEFT JOIN contacts.vwpersonsincludingpatients ON ((invoices.fk_payer_person = vwpersonsincludingpatients.fk_person))) LEFT JOIN contacts.vwpatients ON ((invoices.fk_patient = vwpatients.fk_patient)));


ALTER TABLE billing.vwinvoices OWNER TO easygp;

--
-- Name: vwitemsbilled; Type: VIEW; Schema: billing; Owner: easygp
--

CREATE VIEW vwitemsbilled AS
    SELECT items_billed.pk AS pk_items_billed, items_billed.fk_fee_schedule, items_billed.amount, items_billed.amount_gst, items_billed.fk_invoice, items_billed.fk_lu_billing_type, lu_billing_type.type AS billing_type, fee_schedule.item, fee_schedule.mbs_item, fee_schedule.user_item, fee_schedule.ama_item, fee_schedule.descriptor, fee_schedule.descriptor_brief, fee_schedule.gst_rate, fee_schedule.percentage_fee_rule FROM items_billed, lu_billing_type, fee_schedule WHERE ((lu_billing_type.pk = items_billed.fk_lu_billing_type) AND (items_billed.fk_fee_schedule = fee_schedule.pk));


ALTER TABLE billing.vwitemsbilled OWNER TO easygp;

--
-- Name: vwitemsandinvoices; Type: VIEW; Schema: billing; Owner: easygp
--

CREATE VIEW vwitemsandinvoices AS
    SELECT vwitemsbilled.pk_items_billed, vwitemsbilled.fk_fee_schedule, vwitemsbilled.amount, vwitemsbilled.amount_gst, vwitemsbilled.fk_lu_billing_type, vwitemsbilled.billing_type, vwitemsbilled.item, vwitemsbilled.mbs_item, vwitemsbilled.user_item, vwitemsbilled.ama_item, vwitemsbilled.descriptor, vwitemsbilled.descriptor_brief, vwitemsbilled.gst_rate, vwitemsbilled.percentage_fee_rule, vwinvoices.fk_invoice, vwinvoices.notes, vwinvoices.fk_staff_invoicing, vwinvoices.fk_patient, vwinvoices.date_printed, vwinvoices.fk_staff_provided_service, vwinvoices.date_invoiced, vwinvoices.paid, vwinvoices.fk_payer_person, vwinvoices.fk_payer_branch, vwinvoices.account_to_name, vwinvoices.account_to_branch, vwinvoices.account_to_street, vwinvoices.account_to_town_postcode, vwinvoices.latex, vwinvoices.fk_branch, vwinvoices.visit_date, vwinvoices.fk_appointment, vwinvoices.appointment_time, vwinvoices.duration, vwinvoices.reference, vwinvoices.fk_lu_bulk_billing_type, vwinvoices.total_bill, vwinvoices.total_paid, vwinvoices.total_gst, vwinvoices.due, vwinvoices.staff_invoicing_wholename, vwinvoices.staff_provided_service_wholename, vwinvoices.staff_provided_service_provider_number, vwinvoices.australian_business_number, vwinvoices.patient_firstname, vwinvoices.patient_surname, vwinvoices.patient_title, vwinvoices.patient_fk_sex, vwinvoices.patient_sex, vwinvoices.patient_wholename, vwinvoices.fk_lu_centrelink_card_type, vwinvoices.fk_lu_default_billing_level, vwinvoices.branch FROM vwitemsbilled, vwinvoices WHERE (vwinvoices.fk_invoice = vwitemsbilled.fk_invoice);


ALTER TABLE billing.vwitemsandinvoices OWNER TO easygp;

SET search_path = blobs, pg_catalog;

--
-- Name: blobs; Type: TABLE; Schema: blobs; Owner: easygp; Tablespace: 
--

CREATE TABLE blobs (
    pk integer NOT NULL,
    blob bytea NOT NULL
);


ALTER TABLE blobs.blobs OWNER TO easygp;

--
-- Name: blobs_pk_seq; Type: SEQUENCE; Schema: blobs; Owner: easygp
--

CREATE SEQUENCE blobs_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE blobs.blobs_pk_seq OWNER TO easygp;

--
-- Name: blobs_pk_seq; Type: SEQUENCE OWNED BY; Schema: blobs; Owner: easygp
--

ALTER SEQUENCE blobs_pk_seq OWNED BY blobs.pk;


--
-- Name: images_pk_seq; Type: SEQUENCE; Schema: blobs; Owner: easygp
--

CREATE SEQUENCE images_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE blobs.images_pk_seq OWNER TO easygp;

--
-- Name: images_pk_seq; Type: SEQUENCE OWNED BY; Schema: blobs; Owner: easygp
--

ALTER SEQUENCE images_pk_seq OWNED BY images.pk;


SET search_path = clin_consult, pg_catalog;

--
-- Name: consult; Type: TABLE; Schema: clin_consult; Owner: easygp; Tablespace: 
--

CREATE TABLE consult (
    pk integer NOT NULL,
    consult_date timestamp without time zone NOT NULL,
    fk_patient integer NOT NULL,
    fk_staff integer NOT NULL,
    fk_type integer,
    summary text
);


ALTER TABLE clin_consult.consult OWNER TO easygp;

SET search_path = blobs, pg_catalog;

--
-- Name: vwpatientimages; Type: VIEW; Schema: blobs; Owner: easygp
--

CREATE VIEW vwpatientimages AS
    SELECT images.pk, images.image, images.deleted, images.fk_consult, images.md5sum, images.tag, consult.consult_date, consult.fk_patient FROM (images images LEFT JOIN clin_consult.consult ON ((images.fk_consult = consult.pk))) ORDER BY consult.fk_patient;


ALTER TABLE blobs.vwpatientimages OWNER TO easygp;

SET search_path = chronic_disease_management, pg_catalog;

--
-- Name: diabetes_annual_cycle_of_care; Type: TABLE; Schema: chronic_disease_management; Owner: easygp; Tablespace: 
--

CREATE TABLE diabetes_annual_cycle_of_care (
    pk integer NOT NULL,
    fk_consult integer NOT NULL,
    date_completed date,
    hba1c_date date,
    hba1c_date_due date,
    hba1c_details text,
    eyes_date date,
    eyes_date_due date,
    eyes_details text,
    bp_date date,
    bp_date_due date,
    bp_details text,
    bmi_date date,
    bmi_date_due date,
    bmi_details text,
    feet_date date,
    feet_date_due date,
    feet_details text,
    lipids_date date,
    lipids_date_due date,
    lipids_details text,
    microalbumin_date date,
    microalbumin_date_due date,
    microalbumin_details text,
    education_date date,
    education_date_due date,
    education_details text,
    diet_date date,
    diet_date_due date,
    diet_details text,
    exercise_date date,
    exercise_date_due date,
    exercise_details text,
    smoking_date date,
    smoking_date_due date,
    smoking_details text,
    medication_review_date date,
    medication_review_date_due date,
    medication_review_details text,
    deleted boolean DEFAULT false,
    fk_progressnote_components integer,
    renalfunction_date date,
    renalfunction_date_due date,
    renalfunction_details text,
    latex text
);


ALTER TABLE chronic_disease_management.diabetes_annual_cycle_of_care OWNER TO easygp;

--
-- Name: TABLE diabetes_annual_cycle_of_care; Type: COMMENT; Schema: chronic_disease_management; Owner: easygp
--

COMMENT ON TABLE diabetes_annual_cycle_of_care IS 'Table containing the components to the diabetes annual cycle of care first version not for clinical use';


--
-- Name: COLUMN diabetes_annual_cycle_of_care.hba1c_date; Type: COMMENT; Schema: chronic_disease_management; Owner: easygp
--

COMMENT ON COLUMN diabetes_annual_cycle_of_care.hba1c_date IS 'date of last hba1c could be null if not yet completed but DACC saved
	 also could be taken from  document not from our system, or a phone result etc';


--
-- Name: COLUMN diabetes_annual_cycle_of_care.eyes_date; Type: COMMENT; Schema: chronic_disease_management; Owner: easygp
--

COMMENT ON COLUMN diabetes_annual_cycle_of_care.eyes_date IS 'Date the eye check was done, may be entered without paperwork to verify ';


--
-- Name: COLUMN diabetes_annual_cycle_of_care.eyes_details; Type: COMMENT; Schema: chronic_disease_management; Owner: easygp
--

COMMENT ON COLUMN diabetes_annual_cycle_of_care.eyes_details IS 'Whoever checked the eyes, could be person or entity, but hopefully in most cases
 will be auto-trawled from the database ';


--
-- Name: COLUMN diabetes_annual_cycle_of_care.fk_progressnote_components; Type: COMMENT; Schema: chronic_disease_management; Owner: easygp
--

COMMENT ON COLUMN diabetes_annual_cycle_of_care.fk_progressnote_components IS 'html of the tabulated DACC if not null';


--
-- Name: COLUMN diabetes_annual_cycle_of_care.latex; Type: COMMENT; Schema: chronic_disease_management; Owner: easygp
--

COMMENT ON COLUMN diabetes_annual_cycle_of_care.latex IS 'the LaTeX definition of the output of the assessment';


--
-- Name: diabetes_annual_cycle_of_care_notes; Type: TABLE; Schema: chronic_disease_management; Owner: easygp; Tablespace: 
--

CREATE TABLE diabetes_annual_cycle_of_care_notes (
    pk integer NOT NULL,
    fk_progressnote integer NOT NULL,
    fk_diabetes_annual_cycle_of_care integer
);


ALTER TABLE chronic_disease_management.diabetes_annual_cycle_of_care_notes OWNER TO easygp;

--
-- Name: TABLE diabetes_annual_cycle_of_care_notes; Type: COMMENT; Schema: chronic_disease_management; Owner: easygp
--

COMMENT ON TABLE diabetes_annual_cycle_of_care_notes IS 'as a cycle_of_care may not be completed during the same physical consultation, but over
 several visits, this keeps the key to each progress note, so that they can be
 re-displayed to the user to see what they did last time';


--
-- Name: diabetes_annual_cycle_of_care_notes_pk_seq; Type: SEQUENCE; Schema: chronic_disease_management; Owner: easygp
--

CREATE SEQUENCE diabetes_annual_cycle_of_care_notes_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE chronic_disease_management.diabetes_annual_cycle_of_care_notes_pk_seq OWNER TO easygp;

--
-- Name: diabetes_annual_cycle_of_care_notes_pk_seq; Type: SEQUENCE OWNED BY; Schema: chronic_disease_management; Owner: easygp
--

ALTER SEQUENCE diabetes_annual_cycle_of_care_notes_pk_seq OWNED BY diabetes_annual_cycle_of_care_notes.pk;


--
-- Name: diabetes_annual_cycle_of_care_pk_seq; Type: SEQUENCE; Schema: chronic_disease_management; Owner: easygp
--

CREATE SEQUENCE diabetes_annual_cycle_of_care_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE chronic_disease_management.diabetes_annual_cycle_of_care_pk_seq OWNER TO easygp;

--
-- Name: diabetes_annual_cycle_of_care_pk_seq; Type: SEQUENCE OWNED BY; Schema: chronic_disease_management; Owner: easygp
--

ALTER SEQUENCE diabetes_annual_cycle_of_care_pk_seq OWNED BY diabetes_annual_cycle_of_care.pk;


--
-- Name: epc_link_provider_form; Type: TABLE; Schema: chronic_disease_management; Owner: easygp; Tablespace: 
--

CREATE TABLE epc_link_provider_form (
    pk integer NOT NULL,
    fk_epc_referral integer NOT NULL,
    fk_type integer NOT NULL,
    number_services integer NOT NULL,
    deleted boolean DEFAULT false
);


ALTER TABLE chronic_disease_management.epc_link_provider_form OWNER TO easygp;

--
-- Name: TABLE epc_link_provider_form; Type: COMMENT; Schema: chronic_disease_management; Owner: easygp
--

COMMENT ON TABLE epc_link_provider_form IS 'links the core EPC referral details to a provider on this form and number of services';


--
-- Name: epc_link_provider_form_pk_seq; Type: SEQUENCE; Schema: chronic_disease_management; Owner: easygp
--

CREATE SEQUENCE epc_link_provider_form_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE chronic_disease_management.epc_link_provider_form_pk_seq OWNER TO easygp;

--
-- Name: epc_link_provider_form_pk_seq; Type: SEQUENCE OWNED BY; Schema: chronic_disease_management; Owner: easygp
--

ALTER SEQUENCE epc_link_provider_form_pk_seq OWNED BY epc_link_provider_form.pk;


--
-- Name: epc_referral; Type: TABLE; Schema: chronic_disease_management; Owner: easygp; Tablespace: 
--

CREATE TABLE epc_referral (
    pk integer NOT NULL,
    fk_consult integer NOT NULL,
    has_gp_management_plan_and_team_care_arrangments boolean DEFAULT true,
    has_aged_care_multidisciplinary_plan boolean DEFAULT false,
    fk_team_care_arrangement integer NOT NULL,
    fk_electronic_signature integer
);


ALTER TABLE chronic_disease_management.epc_referral OWNER TO easygp;

--
-- Name: TABLE epc_referral; Type: COMMENT; Schema: chronic_disease_management; Owner: easygp
--

COMMENT ON TABLE epc_referral IS 'Describes the core details single EPC_Referral to one or more allied health or dental providers
 however note that the view chronic_disease_management.vwEPCReferrals is needed to describe
 a single form (multiple rows) as there are 1 or more providers on a form';


--
-- Name: COLUMN epc_referral.fk_consult; Type: COMMENT; Schema: chronic_disease_management; Owner: easygp
--

COMMENT ON COLUMN epc_referral.fk_consult IS ' key to clin_consult.consult links the form to the patient, date and doctor who did it';


--
-- Name: COLUMN epc_referral.has_gp_management_plan_and_team_care_arrangments; Type: COMMENT; Schema: chronic_disease_management; Owner: easygp
--

COMMENT ON COLUMN epc_referral.has_gp_management_plan_and_team_care_arrangments IS 'defaults to true because most will have a GP management plan in place';


--
-- Name: COLUMN epc_referral.fk_team_care_arrangement; Type: COMMENT; Schema: chronic_disease_management; Owner: easygp
--

COMMENT ON COLUMN epc_referral.fk_team_care_arrangement IS 'key to EPC_TeamCare_Arrangements table';


--
-- Name: COLUMN epc_referral.fk_electronic_signature; Type: COMMENT; Schema: chronic_disease_management; Owner: easygp
--

COMMENT ON COLUMN epc_referral.fk_electronic_signature IS 'if not null, an image in blobs.images which is the signature of the GP';


--
-- Name: epc_referral_pk_seq; Type: SEQUENCE; Schema: chronic_disease_management; Owner: easygp
--

CREATE SEQUENCE epc_referral_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE chronic_disease_management.epc_referral_pk_seq OWNER TO easygp;

--
-- Name: epc_referral_pk_seq; Type: SEQUENCE OWNED BY; Schema: chronic_disease_management; Owner: easygp
--

ALTER SEQUENCE epc_referral_pk_seq OWNED BY epc_referral.pk;


--
-- Name: lu_allied_health_type; Type: TABLE; Schema: chronic_disease_management; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_allied_health_type (
    pk integer NOT NULL,
    type text NOT NULL,
    item_number integer NOT NULL,
    deleted boolean DEFAULT false
);


ALTER TABLE chronic_disease_management.lu_allied_health_type OWNER TO easygp;

--
-- Name: TABLE lu_allied_health_type; Type: COMMENT; Schema: chronic_disease_management; Owner: easygp
--

COMMENT ON TABLE lu_allied_health_type IS 'describes the type of allied health provider including dental';


--
-- Name: lu_allied_health_type_pk_seq; Type: SEQUENCE; Schema: chronic_disease_management; Owner: easygp
--

CREATE SEQUENCE lu_allied_health_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE chronic_disease_management.lu_allied_health_type_pk_seq OWNER TO easygp;

--
-- Name: lu_allied_health_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: chronic_disease_management; Owner: easygp
--

ALTER SEQUENCE lu_allied_health_type_pk_seq OWNED BY lu_allied_health_type.pk;


--
-- Name: lu_dacc_components; Type: TABLE; Schema: chronic_disease_management; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_dacc_components (
    pk integer NOT NULL,
    fk_component integer NOT NULL
);


ALTER TABLE chronic_disease_management.lu_dacc_components OWNER TO easygp;

--
-- Name: TABLE lu_dacc_components; Type: COMMENT; Schema: chronic_disease_management; Owner: easygp
--

COMMENT ON TABLE lu_dacc_components IS 'Specific to Australian Government requirements for billing care of diabetics is the so 
  called Diabetic Annual Cycle of Care (DACC)';


--
-- Name: COLUMN lu_dacc_components.fk_component; Type: COMMENT; Schema: chronic_disease_management; Owner: easygp
--

COMMENT ON COLUMN lu_dacc_components.fk_component IS 'key to chronic_disease_management.lu_careplan_components table';


--
-- Name: lu_dacc_components_pk_seq; Type: SEQUENCE; Schema: chronic_disease_management; Owner: easygp
--

CREATE SEQUENCE lu_dacc_components_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE chronic_disease_management.lu_dacc_components_pk_seq OWNER TO easygp;

--
-- Name: lu_dacc_components_pk_seq; Type: SEQUENCE OWNED BY; Schema: chronic_disease_management; Owner: easygp
--

ALTER SEQUENCE lu_dacc_components_pk_seq OWNED BY lu_dacc_components.pk;


--
-- Name: patients_with_hba1c_not_diabetic; Type: TABLE; Schema: chronic_disease_management; Owner: easygp; Tablespace: 
--

CREATE TABLE patients_with_hba1c_not_diabetic (
    fk_patient integer NOT NULL
);


ALTER TABLE chronic_disease_management.patients_with_hba1c_not_diabetic OWNER TO easygp;

--
-- Name: TABLE patients_with_hba1c_not_diabetic; Type: COMMENT; Schema: chronic_disease_management; Owner: easygp
--

COMMENT ON TABLE patients_with_hba1c_not_diabetic IS 'table containing keys to clerical.fk_patient where someone has ordered 
 a hba1c on somone who is not diabetic in fact.';


--
-- Name: team_care_arrangements; Type: TABLE; Schema: chronic_disease_management; Owner: easygp; Tablespace: 
--

CREATE TABLE team_care_arrangements (
    pk integer NOT NULL,
    fk_organisation integer,
    fk_employee integer,
    fk_person integer,
    responsibility text NOT NULL
);


ALTER TABLE chronic_disease_management.team_care_arrangements OWNER TO easygp;

--
-- Name: TABLE team_care_arrangements; Type: COMMENT; Schema: chronic_disease_management; Owner: easygp
--

COMMENT ON TABLE team_care_arrangements IS 'the team care arrangements table';


--
-- Name: team_care_arrangements_pk_seq; Type: SEQUENCE; Schema: chronic_disease_management; Owner: easygp
--

CREATE SEQUENCE team_care_arrangements_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE chronic_disease_management.team_care_arrangements_pk_seq OWNER TO easygp;

--
-- Name: team_care_arrangements_pk_seq; Type: SEQUENCE OWNED BY; Schema: chronic_disease_management; Owner: easygp
--

ALTER SEQUENCE team_care_arrangements_pk_seq OWNED BY team_care_arrangements.pk;


SET search_path = clin_consult, pg_catalog;

--
-- Name: lu_audit_actions; Type: TABLE; Schema: clin_consult; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_audit_actions (
    pk integer NOT NULL,
    action text NOT NULL,
    insist_reason boolean DEFAULT false NOT NULL
);


ALTER TABLE clin_consult.lu_audit_actions OWNER TO easygp;

--
-- Name: TABLE lu_audit_actions; Type: COMMENT; Schema: clin_consult; Owner: easygp
--

COMMENT ON TABLE lu_audit_actions IS 'the action undertaken by the audit eg insert, update, delete, complete etc';


--
-- Name: lu_audit_reasons; Type: TABLE; Schema: clin_consult; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_audit_reasons (
    pk integer NOT NULL,
    fk_staff integer,
    reason text
);


ALTER TABLE clin_consult.lu_audit_reasons OWNER TO easygp;

--
-- Name: TABLE lu_audit_reasons; Type: COMMENT; Schema: clin_consult; Owner: easygp
--

COMMENT ON TABLE lu_audit_reasons IS 'keeps reasons for the audit action on per-user basis';


--
-- Name: lu_consult_type; Type: TABLE; Schema: clin_consult; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_consult_type (
    pk integer NOT NULL,
    type text NOT NULL,
    user_selectable boolean DEFAULT true
);


ALTER TABLE clin_consult.lu_consult_type OWNER TO easygp;

--
-- Name: lu_progressnotes_sections; Type: TABLE; Schema: clin_consult; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_progressnotes_sections (
    pk integer NOT NULL,
    section text NOT NULL
);


ALTER TABLE clin_consult.lu_progressnotes_sections OWNER TO easygp;

--
-- Name: progressnotes; Type: TABLE; Schema: clin_consult; Owner: easygp; Tablespace: 
--

CREATE TABLE progressnotes (
    pk integer NOT NULL,
    fk_consult integer,
    notes text,
    fk_section integer,
    fk_code bigint,
    problem text,
    fk_problem integer,
    fk_audit_action integer DEFAULT 1,
    linked_table regclass,
    fk_row integer,
    fk_audit_reason integer,
    deleted boolean DEFAULT false
);


ALTER TABLE clin_consult.progressnotes OWNER TO easygp;

--
-- Name: COLUMN progressnotes.deleted; Type: COMMENT; Schema: clin_consult; Owner: easygp
--

COMMENT ON COLUMN progressnotes.deleted IS 'if True then the record is marked as deleted. An audit trail will have been inserted';


--
-- Name: vwprogressnotes; Type: VIEW; Schema: clin_consult; Owner: easygp
--

CREATE VIEW vwprogressnotes AS
    SELECT "CONSULT".fk_patient, progressnotes.pk AS pk_progressnote, "CONSULT".consult_date, "CONSULT_TYPE".type AS consult_type, "SECTION".section, progressnotes.problem, progressnotes.notes, "CONSULT".summary, progressnotes.fk_consult, progressnotes.fk_section, progressnotes.fk_code, progressnotes.fk_problem, progressnotes.fk_audit_action, progressnotes.deleted, "CONSULT".fk_staff, "CONSULT".fk_type, data_persons.firstname, data_persons.surname, lu_title.title, lu_audit_actions.action AS audit_action, progressnotes.linked_table, progressnotes.fk_audit_reason, lu_audit_reasons.reason AS audit_reason, progressnotes.fk_row, lu_audit_actions.insist_reason, lu_staff_roles.role FROM (((((((((consult "CONSULT" LEFT JOIN lu_consult_type "CONSULT_TYPE" ON (("CONSULT".fk_type = "CONSULT_TYPE".pk))) JOIN admin.staff ON (("CONSULT".fk_staff = staff.pk))) JOIN contacts.data_persons ON ((staff.fk_person = data_persons.pk))) JOIN contacts.lu_title ON ((data_persons.fk_title = lu_title.pk))) JOIN progressnotes ON (("CONSULT".pk = progressnotes.fk_consult))) JOIN lu_progressnotes_sections "SECTION" ON ((progressnotes.fk_section = "SECTION".pk))) JOIN lu_audit_actions ON ((progressnotes.fk_audit_action = lu_audit_actions.pk))) JOIN admin.lu_staff_roles ON ((staff.fk_role = lu_staff_roles.pk))) LEFT JOIN lu_audit_reasons ON ((progressnotes.fk_audit_reason = lu_audit_reasons.pk))) WHERE ("CONSULT_TYPE".pk <> 8) ORDER BY "CONSULT".fk_patient, "CONSULT".consult_date, "CONSULT".fk_staff, "SECTION".pk, progressnotes.fk_problem;


ALTER TABLE clin_consult.vwprogressnotes OWNER TO easygp;

SET search_path = chronic_disease_management, pg_catalog;

--
-- Name: vwdiabetescycleofcare; Type: VIEW; Schema: chronic_disease_management; Owner: easygp
--

CREATE VIEW vwdiabetescycleofcare AS
    SELECT ((diabetes_annual_cycle_of_care.pk || '-'::text) || (COALESCE(diabetes_annual_cycle_of_care_notes.pk, 0))::text) AS pk_view, diabetes_annual_cycle_of_care.pk AS fk_diabetes_annual_cycle_of_care, consult.consult_date, consult.fk_patient, consult.fk_staff AS fk_staff_started, diabetes_annual_cycle_of_care.date_completed, diabetes_annual_cycle_of_care.fk_consult, diabetes_annual_cycle_of_care.hba1c_date, diabetes_annual_cycle_of_care.hba1c_date_due, diabetes_annual_cycle_of_care.hba1c_details, diabetes_annual_cycle_of_care.eyes_date, diabetes_annual_cycle_of_care.eyes_date_due, diabetes_annual_cycle_of_care.eyes_details, diabetes_annual_cycle_of_care.bp_date, diabetes_annual_cycle_of_care.bp_date_due, diabetes_annual_cycle_of_care.bp_details, diabetes_annual_cycle_of_care.bmi_date, diabetes_annual_cycle_of_care.bmi_date_due, diabetes_annual_cycle_of_care.bmi_details, diabetes_annual_cycle_of_care.feet_date, diabetes_annual_cycle_of_care.feet_date_due, diabetes_annual_cycle_of_care.feet_details, diabetes_annual_cycle_of_care.lipids_date, diabetes_annual_cycle_of_care.lipids_date_due, diabetes_annual_cycle_of_care.lipids_details, diabetes_annual_cycle_of_care.microalbumin_date, diabetes_annual_cycle_of_care.microalbumin_date_due, diabetes_annual_cycle_of_care.microalbumin_details, diabetes_annual_cycle_of_care.renalfunction_date, diabetes_annual_cycle_of_care.renalfunction_date_due, diabetes_annual_cycle_of_care.renalfunction_details, diabetes_annual_cycle_of_care.education_date, diabetes_annual_cycle_of_care.education_date_due, diabetes_annual_cycle_of_care.education_details, diabetes_annual_cycle_of_care.diet_date, diabetes_annual_cycle_of_care.diet_date_due, diabetes_annual_cycle_of_care.diet_details, diabetes_annual_cycle_of_care.exercise_date, diabetes_annual_cycle_of_care.exercise_date_due, diabetes_annual_cycle_of_care.exercise_details, diabetes_annual_cycle_of_care.smoking_date, diabetes_annual_cycle_of_care.smoking_date_due, diabetes_annual_cycle_of_care.smoking_details, diabetes_annual_cycle_of_care.medication_review_date, diabetes_annual_cycle_of_care.medication_review_date_due, diabetes_annual_cycle_of_care.medication_review_details, diabetes_annual_cycle_of_care.deleted, diabetes_annual_cycle_of_care.fk_progressnote_components, diabetes_annual_cycle_of_care.latex, diabetes_annual_cycle_of_care_notes.fk_progressnote AS fk_progressnote_comments, vwprogressnotes.consult_date AS date_progress_note_comment, vwstaff.title AS staff_made_comment_title, vwstaff.wholename AS staff_made_comment_wholename, vwstaff1.title AS staff_started_title, vwstaff1.wholename AS staff_started_wholename, progressnotes.notes AS component_notes, vwprogressnotes.notes AS comments_notes FROM ((((((diabetes_annual_cycle_of_care JOIN clin_consult.consult ON ((diabetes_annual_cycle_of_care.fk_consult = consult.pk))) LEFT JOIN diabetes_annual_cycle_of_care_notes ON ((diabetes_annual_cycle_of_care.pk = diabetes_annual_cycle_of_care_notes.fk_diabetes_annual_cycle_of_care))) LEFT JOIN clin_consult.vwprogressnotes ON ((diabetes_annual_cycle_of_care_notes.fk_progressnote = vwprogressnotes.pk_progressnote))) LEFT JOIN admin.vwstaff ON ((vwprogressnotes.fk_staff = vwstaff.fk_staff))) JOIN clin_consult.progressnotes ON ((diabetes_annual_cycle_of_care.fk_progressnote_components = progressnotes.pk))) JOIN admin.vwstaff vwstaff1 ON ((consult.fk_staff = vwstaff1.pk)));


ALTER TABLE chronic_disease_management.vwdiabetescycleofcare OWNER TO easygp;

SET search_path = clerical, pg_catalog;

--
-- Name: bookings_pk_seq; Type: SEQUENCE; Schema: clerical; Owner: easygp
--

CREATE SEQUENCE bookings_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clerical.bookings_pk_seq OWNER TO easygp;

--
-- Name: bookings_pk_seq; Type: SEQUENCE OWNED BY; Schema: clerical; Owner: easygp
--

ALTER SEQUENCE bookings_pk_seq OWNED BY bookings.pk;


--
-- Name: data_families; Type: TABLE; Schema: clerical; Owner: easygp; Tablespace: 
--

CREATE TABLE data_families (
    pk integer NOT NULL,
    disbanded boolean
);


ALTER TABLE clerical.data_families OWNER TO easygp;

--
-- Name: data_families_pk_seq; Type: SEQUENCE; Schema: clerical; Owner: easygp
--

CREATE SEQUENCE data_families_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clerical.data_families_pk_seq OWNER TO easygp;

--
-- Name: data_families_pk_seq; Type: SEQUENCE OWNED BY; Schema: clerical; Owner: easygp
--

ALTER SEQUENCE data_families_pk_seq OWNED BY data_families.pk;


--
-- Name: data_family_members; Type: TABLE; Schema: clerical; Owner: easygp; Tablespace: 
--

CREATE TABLE data_family_members (
    pk integer NOT NULL,
    fk_family integer NOT NULL,
    fk_patient integer NOT NULL
);


ALTER TABLE clerical.data_family_members OWNER TO easygp;

--
-- Name: data_family_members_pk_seq; Type: SEQUENCE; Schema: clerical; Owner: easygp
--

CREATE SEQUENCE data_family_members_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clerical.data_family_members_pk_seq OWNER TO easygp;

--
-- Name: data_family_members_pk_seq; Type: SEQUENCE OWNED BY; Schema: clerical; Owner: easygp
--

ALTER SEQUENCE data_family_members_pk_seq OWNED BY data_family_members.pk;


--
-- Name: data_patients_pk_seq; Type: SEQUENCE; Schema: clerical; Owner: easygp
--

CREATE SEQUENCE data_patients_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clerical.data_patients_pk_seq OWNER TO easygp;

--
-- Name: data_patients_pk_seq; Type: SEQUENCE OWNED BY; Schema: clerical; Owner: easygp
--

ALTER SEQUENCE data_patients_pk_seq OWNED BY data_patients.pk;


--
-- Name: inventory; Type: TABLE; Schema: clerical; Owner: easygp; Tablespace: 
--

CREATE TABLE inventory (
    pk integer NOT NULL,
    fk_lu_inventory_item integer NOT NULL,
    fk_image integer,
    fk_inventory_location integer NOT NULL,
    fk_branch_purchased_from integer,
    fk_employee_purchased_from integer,
    fk_person_purchased_from integer,
    date_purchased timestamp without time zone,
    purchase_price money,
    comment text
);


ALTER TABLE clerical.inventory OWNER TO easygp;

--
-- Name: TABLE inventory; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON TABLE inventory IS 'Keeps list of all equipment, where held etc';


--
-- Name: COLUMN inventory.fk_image; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON COLUMN inventory.fk_image IS 'if not null then points to image of the equipment';


--
-- Name: COLUMN inventory.fk_branch_purchased_from; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON COLUMN inventory.fk_branch_purchased_from IS 'if not null then points to contacts.data_branches.pk ie the organisation and branch the item was purchase from';


--
-- Name: COLUMN inventory.fk_employee_purchased_from; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON COLUMN inventory.fk_employee_purchased_from IS 'if not null then points to contacts.data_employees.pk .i.e the employee from whom purchased the item.';


--
-- Name: COLUMN inventory.fk_person_purchased_from; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON COLUMN inventory.fk_person_purchased_from IS 'if not null then points to contacts.data persons.pk .i.e the person from whom purchased the item';


--
-- Name: inventory_lent; Type: TABLE; Schema: clerical; Owner: easygp; Tablespace: 
--

CREATE TABLE inventory_lent (
    pk integer NOT NULL,
    fk_inventory integer NOT NULL,
    fk_patient integer NOT NULL,
    fk_staff integer NOT NULL,
    date_lent timestamp without time zone NOT NULL,
    date_due timestamp without time zone NOT NULL,
    comment text
);


ALTER TABLE clerical.inventory_lent OWNER TO easygp;

--
-- Name: inventory_lent_pk_seq; Type: SEQUENCE; Schema: clerical; Owner: easygp
--

CREATE SEQUENCE inventory_lent_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clerical.inventory_lent_pk_seq OWNER TO easygp;

--
-- Name: inventory_lent_pk_seq; Type: SEQUENCE OWNED BY; Schema: clerical; Owner: easygp
--

ALTER SEQUENCE inventory_lent_pk_seq OWNED BY inventory_lent.pk;


--
-- Name: inventory_locations; Type: TABLE; Schema: clerical; Owner: easygp; Tablespace: 
--

CREATE TABLE inventory_locations (
    pk integer NOT NULL,
    fk_clinic integer NOT NULL,
    location text NOT NULL
);


ALTER TABLE clerical.inventory_locations OWNER TO easygp;

--
-- Name: TABLE inventory_locations; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON TABLE inventory_locations IS 'the location within the clinic or it''s environs where the inventory item is located';


--
-- Name: inventory_locations_pk_seq; Type: SEQUENCE; Schema: clerical; Owner: easygp
--

CREATE SEQUENCE inventory_locations_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clerical.inventory_locations_pk_seq OWNER TO easygp;

--
-- Name: inventory_locations_pk_seq; Type: SEQUENCE OWNED BY; Schema: clerical; Owner: easygp
--

ALTER SEQUENCE inventory_locations_pk_seq OWNED BY inventory_locations.pk;


--
-- Name: inventory_pk_seq; Type: SEQUENCE; Schema: clerical; Owner: easygp
--

CREATE SEQUENCE inventory_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clerical.inventory_pk_seq OWNER TO easygp;

--
-- Name: inventory_pk_seq; Type: SEQUENCE OWNED BY; Schema: clerical; Owner: easygp
--

ALTER SEQUENCE inventory_pk_seq OWNED BY inventory.pk;


--
-- Name: lu_active_status_pk_seq; Type: SEQUENCE; Schema: clerical; Owner: easygp
--

CREATE SEQUENCE lu_active_status_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clerical.lu_active_status_pk_seq OWNER TO easygp;

--
-- Name: lu_active_status_pk_seq; Type: SEQUENCE OWNED BY; Schema: clerical; Owner: easygp
--

ALTER SEQUENCE lu_active_status_pk_seq OWNED BY lu_active_status.pk;


--
-- Name: lu_appointment_icons; Type: TABLE; Schema: clerical; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_appointment_icons (
    pk integer NOT NULL,
    appointment_type text NOT NULL,
    icon_path text NOT NULL
);


ALTER TABLE clerical.lu_appointment_icons OWNER TO easygp;

--
-- Name: TABLE lu_appointment_icons; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON TABLE lu_appointment_icons IS 'a table holding path to icons to use as visual indicator of appointment types';


--
-- Name: lu_appointment_icons_pk_seq; Type: SEQUENCE; Schema: clerical; Owner: easygp
--

CREATE SEQUENCE lu_appointment_icons_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clerical.lu_appointment_icons_pk_seq OWNER TO easygp;

--
-- Name: lu_appointment_icons_pk_seq; Type: SEQUENCE OWNED BY; Schema: clerical; Owner: easygp
--

ALTER SEQUENCE lu_appointment_icons_pk_seq OWNED BY lu_appointment_icons.pk;


--
-- Name: lu_appointment_status; Type: TABLE; Schema: clerical; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_appointment_status (
    pk integer NOT NULL,
    status text NOT NULL
);


ALTER TABLE clerical.lu_appointment_status OWNER TO easygp;

--
-- Name: TABLE lu_appointment_status; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON TABLE lu_appointment_status IS 'the status of the appointment as it applies to patient: arrived (color code blue), seeing clinician (red), gray (patient gone)';


--
-- Name: lu_appointment_status_pk_seq; Type: SEQUENCE; Schema: clerical; Owner: easygp
--

CREATE SEQUENCE lu_appointment_status_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clerical.lu_appointment_status_pk_seq OWNER TO easygp;

--
-- Name: lu_appointment_status_pk_seq; Type: SEQUENCE OWNED BY; Schema: clerical; Owner: easygp
--

ALTER SEQUENCE lu_appointment_status_pk_seq OWNED BY lu_appointment_status.pk;


--
-- Name: lu_centrelink_card_type_pk_seq; Type: SEQUENCE; Schema: clerical; Owner: easygp
--

CREATE SEQUENCE lu_centrelink_card_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clerical.lu_centrelink_card_type_pk_seq OWNER TO easygp;

--
-- Name: lu_centrelink_card_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: clerical; Owner: easygp
--

ALTER SEQUENCE lu_centrelink_card_type_pk_seq OWNED BY lu_centrelink_card_type.pk;


--
-- Name: lu_inventory_categories; Type: TABLE; Schema: clerical; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_inventory_categories (
    pk integer NOT NULL,
    category text NOT NULL
);


ALTER TABLE clerical.lu_inventory_categories OWNER TO easygp;

--
-- Name: TABLE lu_inventory_categories; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON TABLE lu_inventory_categories IS 'The category e.g ''IT equipment'' or ''medical supplies'' or ''clerical supplies'' - this can be added to as needed
 this is a lookup table as it will be dumped with the database definition';


--
-- Name: lu_inventory_categories_pk_seq; Type: SEQUENCE; Schema: clerical; Owner: easygp
--

CREATE SEQUENCE lu_inventory_categories_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clerical.lu_inventory_categories_pk_seq OWNER TO easygp;

--
-- Name: lu_inventory_categories_pk_seq; Type: SEQUENCE OWNED BY; Schema: clerical; Owner: easygp
--

ALTER SEQUENCE lu_inventory_categories_pk_seq OWNED BY lu_inventory_categories.pk;


--
-- Name: lu_inventory_items; Type: TABLE; Schema: clerical; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_inventory_items (
    pk integer NOT NULL,
    fk_lu_inventory_category integer NOT NULL,
    item text NOT NULL
);


ALTER TABLE clerical.lu_inventory_items OWNER TO easygp;

--
-- Name: TABLE lu_inventory_items; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON TABLE lu_inventory_items IS 'a look up table of items which can be part on an inventory eg sphygmomanometer
  this is a lookup table as it will be dumped with the database definition';


--
-- Name: COLUMN lu_inventory_items.item; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON COLUMN lu_inventory_items.item IS 'the item e.g computer';


--
-- Name: lu_inventory_items_pk_seq; Type: SEQUENCE; Schema: clerical; Owner: easygp
--

CREATE SEQUENCE lu_inventory_items_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clerical.lu_inventory_items_pk_seq OWNER TO easygp;

--
-- Name: lu_inventory_items_pk_seq; Type: SEQUENCE OWNED BY; Schema: clerical; Owner: easygp
--

ALTER SEQUENCE lu_inventory_items_pk_seq OWNED BY lu_inventory_items.pk;


--
-- Name: lu_private_health_funds_pk_seq; Type: SEQUENCE; Schema: clerical; Owner: easygp
--

CREATE SEQUENCE lu_private_health_funds_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clerical.lu_private_health_funds_pk_seq OWNER TO easygp;

--
-- Name: lu_private_health_funds_pk_seq; Type: SEQUENCE OWNED BY; Schema: clerical; Owner: easygp
--

ALTER SEQUENCE lu_private_health_funds_pk_seq OWNED BY lu_private_health_funds.pk;


--
-- Name: lu_task_types; Type: TABLE; Schema: clerical; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_task_types (
    pk integer NOT NULL,
    type text NOT NULL
);


ALTER TABLE clerical.lu_task_types OWNER TO easygp;

--
-- Name: TABLE lu_task_types; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON TABLE lu_task_types IS 'the type of task e.g ring the patient';


--
-- Name: lu_task_types_pk_seq; Type: SEQUENCE; Schema: clerical; Owner: easygp
--

CREATE SEQUENCE lu_task_types_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clerical.lu_task_types_pk_seq OWNER TO easygp;

--
-- Name: lu_task_types_pk_seq; Type: SEQUENCE OWNED BY; Schema: clerical; Owner: easygp
--

ALTER SEQUENCE lu_task_types_pk_seq OWNED BY lu_task_types.pk;


--
-- Name: lu_veteran_card_type_pk_seq; Type: SEQUENCE; Schema: clerical; Owner: easygp
--

CREATE SEQUENCE lu_veteran_card_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clerical.lu_veteran_card_type_pk_seq OWNER TO easygp;

--
-- Name: lu_veteran_card_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: clerical; Owner: easygp
--

ALTER SEQUENCE lu_veteran_card_type_pk_seq OWNED BY lu_veteran_card_type.pk;


--
-- Name: sessions_pk_seq; Type: SEQUENCE; Schema: clerical; Owner: easygp
--

CREATE SEQUENCE sessions_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clerical.sessions_pk_seq OWNER TO easygp;

--
-- Name: sessions_pk_seq; Type: SEQUENCE OWNED BY; Schema: clerical; Owner: easygp
--

ALTER SEQUENCE sessions_pk_seq OWNED BY sessions.pk;


--
-- Name: task_component_notes; Type: TABLE; Schema: clerical; Owner: easygp; Tablespace: 
--

CREATE TABLE task_component_notes (
    pk integer NOT NULL,
    fk_task_component integer NOT NULL,
    note text NOT NULL,
    date timestamp(0) without time zone NOT NULL,
    fk_staff_made_note integer
);


ALTER TABLE clerical.task_component_notes OWNER TO easygp;

--
-- Name: COLUMN task_component_notes.note; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON COLUMN task_component_notes.note IS 'notes about the component as the task progresses
 e.g Patient was rung, said they will come in next week
  or Patient rung a second time - refuses to come in';


--
-- Name: task_component_notes_pk_seq; Type: SEQUENCE; Schema: clerical; Owner: easygp
--

CREATE SEQUENCE task_component_notes_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clerical.task_component_notes_pk_seq OWNER TO easygp;

--
-- Name: task_component_notes_pk_seq; Type: SEQUENCE OWNED BY; Schema: clerical; Owner: easygp
--

ALTER SEQUENCE task_component_notes_pk_seq OWNED BY task_component_notes.pk;


--
-- Name: task_components; Type: TABLE; Schema: clerical; Owner: easygp; Tablespace: 
--

CREATE TABLE task_components (
    pk integer NOT NULL,
    fk_task integer NOT NULL,
    fk_consult integer,
    date_logged date,
    fk_staff_allocated integer NOT NULL,
    fk_staff_completed integer,
    allocated_staff text,
    fk_urgency integer DEFAULT 1,
    details text,
    date_completed date,
    deleted boolean DEFAULT false,
    fk_staff_filed integer,
    fk_role integer
);


ALTER TABLE clerical.task_components OWNER TO easygp;

--
-- Name: TABLE task_components; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON TABLE task_components IS 'Components which make up a task
 e.g arrange a GTT, get back for results.
 note: table clerical.task_component_notes contains none or one or
 more notes about the task component in hand
 see table task_component_notes_link for linkage';


--
-- Name: COLUMN task_components.fk_consult; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON COLUMN task_components.fk_consult IS 'key to clin_consult.consult ie gives patient and
the date the task was logged and by which staff member if the task is for a patient, otherwise can be null';


--
-- Name: COLUMN task_components.date_logged; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON COLUMN task_components.date_logged IS 'Null where the task was logged for a patient, as it has fk_consult,
 if not null, this is a staff task not linked to a fk_patient';


--
-- Name: COLUMN task_components.fk_staff_allocated; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON COLUMN task_components.fk_staff_allocated IS 'foreign key to clerical.staff table, ie points to the staff member
 who is allocated to do the task. May be null if staff member is a generic
 e.g Practice Nurse';


--
-- Name: COLUMN task_components.fk_staff_completed; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON COLUMN task_components.fk_staff_completed IS 'foreign key to clerical.staff table, points to who
 marked this component off as finalised';


--
-- Name: COLUMN task_components.allocated_staff; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON COLUMN task_components.allocated_staff IS 'usually null unless the staff is generic
 in which case contains text e.g Practice Nurse fixme not implemented ie the not generic';


--
-- Name: COLUMN task_components.fk_urgency; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON COLUMN task_components.fk_urgency IS 'key to common.lu_urgency 1:routine 2:moderate 3:urgent';


--
-- Name: COLUMN task_components.date_completed; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON COLUMN task_components.date_completed IS 'The date the component was finalised
 note this does not mean the task was completed';


--
-- Name: COLUMN task_components.fk_role; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON COLUMN task_components.fk_role IS 'foreign key to admin.lu_staff_roles 
 points to the role within the organisation for which the task 
 is designated key of 7=secretarial';


--
-- Name: task_components_pk_seq; Type: SEQUENCE; Schema: clerical; Owner: easygp
--

CREATE SEQUENCE task_components_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clerical.task_components_pk_seq OWNER TO easygp;

--
-- Name: task_components_pk_seq; Type: SEQUENCE OWNED BY; Schema: clerical; Owner: easygp
--

ALTER SEQUENCE task_components_pk_seq OWNED BY task_components.pk;


--
-- Name: tasks; Type: TABLE; Schema: clerical; Owner: easygp; Tablespace: 
--

CREATE TABLE tasks (
    pk integer NOT NULL,
    task text NOT NULL,
    fk_staff_filed_task integer NOT NULL,
    fk_staff_finalised_task integer,
    fk_row integer,
    date_finalised date,
    deleted boolean DEFAULT false,
    fk_staff_must_finalise integer,
    fk_role_can_finalise integer
);


ALTER TABLE clerical.tasks OWNER TO easygp;

--
-- Name: TABLE tasks; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON TABLE tasks IS 'A task can be generated for either a patient or a staff member
 It may have 1 or more components, for either same or different staff members
 If linked to a document then all actions for this task will be veiwed in the documents audit trail.
 The task can be allocated to
 - a particuliar staff member, or anyone of a particular role
 The task can be set to be finalised by:
 - a designated staff member only (currently only the task allocator) and no-one else
 - any staff member of a particular role
 Once all components to a task are completed fk_staff_finalised and date finalised is set
 ';


--
-- Name: COLUMN tasks.fk_row; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON COLUMN tasks.fk_row IS 'if not null then this is foreign key to documents.pk';


--
-- Name: COLUMN tasks.fk_staff_must_finalise; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON COLUMN tasks.fk_staff_must_finalise IS 'if not null, then this staff member has ultimate responsbility to finalise the task';


--
-- Name: COLUMN tasks.fk_role_can_finalise; Type: COMMENT; Schema: clerical; Owner: easygp
--

COMMENT ON COLUMN tasks.fk_role_can_finalise IS 'if not null, then a staff member of this role can finalise the task';


--
-- Name: tasks_pk_seq; Type: SEQUENCE; Schema: clerical; Owner: easygp
--

CREATE SEQUENCE tasks_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clerical.tasks_pk_seq OWNER TO easygp;

--
-- Name: tasks_pk_seq; Type: SEQUENCE OWNED BY; Schema: clerical; Owner: easygp
--

ALTER SEQUENCE tasks_pk_seq OWNED BY tasks.pk;


--
-- Name: vwappointments; Type: VIEW; Schema: clerical; Owner: easygp
--

CREATE VIEW vwappointments AS
    SELECT bookings.pk, bookings.fk_patient, bookings.fk_staff, bookings.begin, bookings.duration, bookings.notes, bookings.fk_staff_booked, bookings.fk_clinic, bookings.fk_lu_appointment_icon, bookings.fk_lu_appointment_status, bookings.deleted, bookings.invoiced, bookings.did_not_attend, bookings.fk_lu_reason_not_billed, data_patients.fk_payer_person, data_patients.fk_payer_branch, data_patients.fk_doctor, data_patients.fk_lu_default_billing_level, data_patients.medicare_number, data_patients.medicare_ref_number, data_patients.medicare_expiry_date, lu_veteran_card_type.type AS veteran_card_type, data_patients.veteran_number, data_patients.veteran_specific_condition, data_patients.concession_card_number, data_patients.concession_card_expiry_date, data_patients.nursing_home_resident, lu_centrelink_card_type.type AS concession_card_type, lu_private_health_funds.fund, lu_default_billing_level.level AS billing_level, data_persons.firstname, data_persons.surname, data_persons.birthdate, lu_sex.sex, lu_title.title, (((lu_title.title || ' '::text) || (data_persons.firstname || ' '::text)) || (data_persons.surname || ' '::text)) AS wholename, public.age_display(age((data_persons.birthdate)::timestamp with time zone)) AS age_display, date_part('year'::text, age((data_persons.birthdate)::timestamp with time zone)) AS age_numeric FROM ((((((((bookings LEFT JOIN data_patients ON ((bookings.fk_patient = data_patients.pk))) LEFT JOIN lu_centrelink_card_type ON ((data_patients.fk_lu_centrelink_card_type = lu_centrelink_card_type.pk))) LEFT JOIN lu_private_health_funds ON ((data_patients.fk_lu_private_health_fund = lu_private_health_funds.pk))) LEFT JOIN lu_veteran_card_type ON ((data_patients.fk_lu_veteran_card_type = lu_veteran_card_type.pk))) LEFT JOIN contacts.data_persons ON ((data_patients.fk_person = data_persons.pk))) LEFT JOIN contacts.lu_sex ON ((data_persons.fk_sex = lu_sex.pk))) LEFT JOIN billing.lu_default_billing_level ON ((data_patients.fk_lu_default_billing_level = lu_default_billing_level.pk))) LEFT JOIN contacts.lu_title ON ((data_persons.fk_title = lu_title.pk))) ORDER BY bookings.begin;


ALTER TABLE clerical.vwappointments OWNER TO easygp;

--
-- Name: vwinventory; Type: VIEW; Schema: clerical; Owner: easygp
--

CREATE VIEW vwinventory AS
    SELECT inventory.pk, lu_inventory_items.item, lu_inventory_categories.category, inventory_locations.location, inventory.date_purchased, inventory.purchase_price, inventory.comment, vwclinics.branch, vwclinics.organisation, vwclinics.street1, vwclinics.street2, vwclinics.town, vwclinics.postcode, vwclinics.state, images.image AS inventory_item_image, images.deleted AS inventory_item_deleted, images.md5sum AS inventory_item_md5sum, images.tag AS inventory_item_tag, data_branches.branch AS branch_purchased_from, data_organisations.organisation AS organisation_purchased_from, inventory.fk_lu_inventory_item, inventory.fk_image, inventory.fk_inventory_location, inventory.fk_branch_purchased_from, inventory.fk_employee_purchased_from, inventory.fk_person_purchased_from, lu_inventory_items.fk_lu_inventory_category FROM (((((((inventory JOIN lu_inventory_items ON ((inventory.fk_lu_inventory_item = lu_inventory_items.pk))) JOIN lu_inventory_categories ON ((lu_inventory_items.fk_lu_inventory_category = lu_inventory_categories.pk))) LEFT JOIN blobs.images ON ((inventory.fk_image = images.pk))) JOIN inventory_locations ON ((inventory.fk_inventory_location = inventory_locations.pk))) JOIN admin.vwclinics ON ((inventory_locations.fk_clinic = vwclinics.fk_clinic))) LEFT JOIN contacts.data_branches ON ((inventory.fk_branch_purchased_from = data_branches.pk))) LEFT JOIN contacts.data_organisations ON ((data_branches.fk_organisation = data_organisations.pk)));


ALTER TABLE clerical.vwinventory OWNER TO easygp;

SET search_path = common, pg_catalog;

--
-- Name: lu_urgency; Type: TABLE; Schema: common; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_urgency (
    pk integer NOT NULL,
    urgency text
);


ALTER TABLE common.lu_urgency OWNER TO easygp;

--
-- Name: TABLE lu_urgency; Type: COMMENT; Schema: common; Owner: easygp
--

COMMENT ON TABLE lu_urgency IS 'The degree of urgency of a recall';


SET search_path = clerical, pg_catalog;

--
-- Name: vwtaskscomponents; Type: VIEW; Schema: clerical; Owner: easygp
--

CREATE VIEW vwtaskscomponents AS
    SELECT task_components.pk AS pk_view, tasks.task, tasks.fk_row, tasks.fk_staff_finalised_task, tasks.date_finalised, tasks.deleted AS task_deleted, tasks.fk_staff_filed_task, tasks.fk_staff_must_finalise, tasks.fk_role_can_finalise, vwstaffinclinics.wholename AS staff_filed_task_wholename, vwstaffinclinics.title AS staff_filed_task_title, vwstaffinclinics2.title AS staff_finalised_task_title, vwstaffinclinics2.wholename AS staff_finalised_task_wholename, vwstaffinclinics3.title AS staff_must_finalise_task_title, vwstaffinclinics3.wholename AS staff_must_finalise_task_wholename, task_components.fk_role, task_components.pk AS fk_component, task_components.fk_task, task_components.fk_consult, task_components.fk_staff_allocated, task_components.fk_staff_completed, task_components.allocated_staff, task_components.fk_urgency, task_components.details, task_components.date_completed AS date_component_completed, task_components.deleted AS component_deleted, vwstaffinclinics1.wholename AS staff_allocated_wholename, vwstaffinclinics1.title AS staff_allocated_title, consult.consult_date AS date_component_logged, vwpatients.town AS patient_town, vwpatients.state AS patient_state, vwpatients.postcode AS patient_postcode, vwpatients.street1 AS patient_street1, vwpatients.street2 AS patient_street2, vwpatients.fk_person, vwpatients.fk_patient, vwpatients.wholename AS patient_wholename, vwpatients.title AS patient_title, vwpatients.birthdate AS patient_birthdate, lu_urgency.urgency FROM ((((((((task_components JOIN tasks ON ((task_components.fk_task = tasks.pk))) JOIN admin.vwstaffinclinics ON ((tasks.fk_staff_filed_task = vwstaffinclinics.fk_staff))) LEFT JOIN admin.vwstaffinclinics vwstaffinclinics1 ON ((task_components.fk_staff_allocated = vwstaffinclinics1.fk_staff))) LEFT JOIN admin.vwstaffinclinics vwstaffinclinics2 ON ((tasks.fk_staff_finalised_task = vwstaffinclinics2.fk_staff))) LEFT JOIN admin.vwstaffinclinics vwstaffinclinics3 ON ((tasks.fk_staff_must_finalise = vwstaffinclinics3.fk_staff))) JOIN clin_consult.consult ON ((task_components.fk_consult = consult.pk))) JOIN contacts.vwpatients ON ((consult.fk_patient = vwpatients.fk_patient))) JOIN common.lu_urgency ON ((task_components.fk_urgency = lu_urgency.pk))) WHERE (task_components.fk_consult > 0) ORDER BY vwpatients.fk_patient, task_components.pk;


ALTER TABLE clerical.vwtaskscomponents OWNER TO easygp;

--
-- Name: vwtaskscomponentsandnotes; Type: VIEW; Schema: clerical; Owner: easygp
--

CREATE VIEW vwtaskscomponentsandnotes AS
    SELECT CASE WHEN (task_component_notes.pk IS NULL) THEN (task_components.pk || '-0'::text) ELSE ((task_components.pk || '-'::text) || task_component_notes.pk) END AS pk_view, tasks.task, task_components.details, task_component_notes.note, tasks.fk_row, tasks.fk_staff_finalised_task, tasks.fk_staff_must_finalise, tasks.fk_role_can_finalise, tasks.date_finalised, tasks.deleted AS task_deleted, tasks.fk_staff_filed_task, vwstaffinclinics.wholename AS staff_filed_task_wholename, vwstaffinclinics.title AS staff_filed_task_title, vwstaffinclinics2.title AS staff_finalised_task_title, vwstaffinclinics2.wholename AS staff_finalised_task_wholename, vwstaffinclinics3.title AS staff_must_finalise_task_title, vwstaffinclinics3.wholename AS staff_must_finalise_task_wholename, task_components.fk_role, task_components.pk AS fk_component, task_components.fk_task, task_components.fk_consult, task_components.fk_staff_allocated, task_components.fk_staff_completed, task_components.allocated_staff, task_components.fk_urgency, task_components.date_completed AS date_component_completed, task_components.deleted AS component_deleted, vwstaffinclinics1.wholename AS staff_allocated_wholename, vwstaffinclinics1.title AS staff_allocated_title, consult.consult_date AS date_component_logged, vwpatients.town AS patient_town, vwpatients.state AS patient_state, vwpatients.postcode AS patient_postcode, vwpatients.street1 AS patient_street1, vwpatients.street2 AS patient_street2, vwpatients.fk_person, vwpatients.fk_patient, vwpatients.wholename AS patient_wholename, vwpatients.title AS patient_title, vwpatients.birthdate AS patient_birthdate, lu_urgency.urgency, task_component_notes.pk AS fk_task_component_note, task_component_notes.date AS date_note, task_component_notes.fk_staff_made_note FROM (((((((((task_components JOIN tasks ON ((task_components.fk_task = tasks.pk))) JOIN admin.vwstaffinclinics ON ((tasks.fk_staff_filed_task = vwstaffinclinics.fk_staff))) LEFT JOIN admin.vwstaffinclinics vwstaffinclinics1 ON ((task_components.fk_staff_allocated = vwstaffinclinics1.fk_staff))) LEFT JOIN admin.vwstaffinclinics vwstaffinclinics2 ON ((tasks.fk_staff_finalised_task = vwstaffinclinics2.fk_staff))) LEFT JOIN admin.vwstaffinclinics vwstaffinclinics3 ON ((tasks.fk_staff_must_finalise = vwstaffinclinics3.fk_staff))) JOIN clin_consult.consult ON ((task_components.fk_consult = consult.pk))) JOIN contacts.vwpatients ON ((consult.fk_patient = vwpatients.fk_patient))) JOIN common.lu_urgency ON ((task_components.fk_urgency = lu_urgency.pk))) LEFT JOIN task_component_notes ON ((task_components.pk = task_component_notes.fk_task_component))) WHERE (task_components.fk_consult > 0) ORDER BY vwpatients.fk_patient, task_components.pk;


ALTER TABLE clerical.vwtaskscomponentsandnotes OWNER TO easygp;

--
-- Name: vwtaskscomponentsnotes; Type: VIEW; Schema: clerical; Owner: easygp
--

CREATE VIEW vwtaskscomponentsnotes AS
    SELECT task_component_notes.pk AS pk_note, task_component_notes.fk_task_component, task_component_notes.note, task_component_notes.date, task_component_notes.fk_staff_made_note, vwstaffinclinics.wholename AS staff_made_note_wholename, vwstaffinclinics.title AS staff_made_note_title, task_components.fk_task FROM ((task_component_notes JOIN admin.vwstaffinclinics ON ((task_component_notes.fk_staff_made_note = vwstaffinclinics.fk_staff))) JOIN task_components ON ((task_component_notes.fk_task_component = task_components.pk)));


ALTER TABLE clerical.vwtaskscomponentsnotes OWNER TO easygp;

SET search_path = clin_allergies, pg_catalog;

--
-- Name: allergies; Type: TABLE; Schema: clin_allergies; Owner: easygp; Tablespace: 
--

CREATE TABLE allergies (
    pk integer NOT NULL,
    fk_consult integer NOT NULL,
    fk_brand uuid,
    fk_product uuid,
    allergen text,
    specificity character(1) DEFAULT NULL::bpchar,
    details text NOT NULL,
    fk_lu_reaction_type integer NOT NULL,
    fk_coding_system integer,
    fk_code text,
    confirmed boolean DEFAULT true,
    deleted boolean DEFAULT false,
    date_reaction text,
    fk_progressnote integer NOT NULL,
    CONSTRAINT allergies_specificity_check CHECK ((((((specificity)::text = 'c'::text) OR ((specificity)::text = 'b'::text)) OR ((specificity)::text = 'g'::text)) OR (specificity IS NULL)))
);


ALTER TABLE clin_allergies.allergies OWNER TO easygp;

--
-- Name: COLUMN allergies.fk_consult; Type: COMMENT; Schema: clin_allergies; Owner: easygp
--

COMMENT ON COLUMN allergies.fk_consult IS 'key to clin_consult.consult table > points to consult created and patient details';


--
-- Name: COLUMN allergies.fk_brand; Type: COMMENT; Schema: clin_allergies; Owner: easygp
--

COMMENT ON COLUMN allergies.fk_brand IS 'if not null key to drugs.brand table points to brand with which this allergy was noted';


--
-- Name: COLUMN allergies.fk_product; Type: COMMENT; Schema: clin_allergies; Owner: easygp
--

COMMENT ON COLUMN allergies.fk_product IS 'if not null key to drugs.product table points to product (generic) with which this allergy was noted';


--
-- Name: COLUMN allergies.allergen; Type: COMMENT; Schema: clin_allergies; Owner: easygp
--

COMMENT ON COLUMN allergies.allergen IS 'if not null then the substance that the person was allergic or sensitive to, eg could be bee or cedar';


--
-- Name: COLUMN allergies.specificity; Type: COMMENT; Schema: clin_allergies; Owner: easygp
--

COMMENT ON COLUMN allergies.specificity IS 'the degree of specificity of the allergy c= class effect eg non-steroidals b= brand specific e.g could be a coloring agent in a tablet or g=generic specific eg naproxen but hence not all nsaids';


--
-- Name: COLUMN allergies.details; Type: COMMENT; Schema: clin_allergies; Owner: easygp
--

COMMENT ON COLUMN allergies.details IS 'free text representation of the reaction, could be say anaphlyaxis of ''gets diarrhoea''';


--
-- Name: COLUMN allergies.fk_lu_reaction_type; Type: COMMENT; Schema: clin_allergies; Owner: easygp
--

COMMENT ON COLUMN allergies.fk_lu_reaction_type IS 'foreign key to allergies.lu_reaction_type 1=allergy 2=sensitivity';


--
-- Name: COLUMN allergies.fk_coding_system; Type: COMMENT; Schema: clin_allergies; Owner: easygp
--

COMMENT ON COLUMN allergies.fk_coding_system IS 'key to coding.lu_coding_system containing name of coding system   that this allergy is linked to';


--
-- Name: COLUMN allergies.fk_code; Type: COMMENT; Schema: clin_allergies; Owner: easygp
--

COMMENT ON COLUMN allergies.fk_code IS 'the text of the code references coding.generic_terms.code';


--
-- Name: COLUMN allergies.confirmed; Type: COMMENT; Schema: clin_allergies; Owner: easygp
--

COMMENT ON COLUMN allergies.confirmed IS 'if true (the default) then the allergy has been confirmed';


--
-- Name: COLUMN allergies.deleted; Type: COMMENT; Schema: clin_allergies; Owner: easygp
--

COMMENT ON COLUMN allergies.deleted IS '
If True Then this record Is Marked As Deleted ';


--
-- Name: COLUMN allergies.date_reaction; Type: COMMENT; Schema: clin_allergies; Owner: easygp
--

COMMENT ON COLUMN allergies.date_reaction IS '
the Date Of reaction, could be Date, could be Year ';


--
-- Name: COLUMN allergies.fk_progressnote; Type: COMMENT; Schema: clin_allergies; Owner: easygp
--

COMMENT ON COLUMN allergies.fk_progressnote IS '
The associated progress note summary Of this allergy - at least Of the latest Time it was accessed ';


--
-- Name: allergies_pk_seq; Type: SEQUENCE; Schema: clin_allergies; Owner: easygp
--

CREATE SEQUENCE allergies_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_allergies.allergies_pk_seq OWNER TO easygp;

--
-- Name: allergies_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_allergies; Owner: easygp
--

ALTER SEQUENCE allergies_pk_seq OWNED BY allergies.pk;


--
-- Name: lu_reaction_type; Type: TABLE; Schema: clin_allergies; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_reaction_type (
    pk integer NOT NULL,
    type text NOT NULL
);


ALTER TABLE clin_allergies.lu_reaction_type OWNER TO easygp;

--
-- Name: lu_reaction_type_pk_seq; Type: SEQUENCE; Schema: clin_allergies; Owner: easygp
--

CREATE SEQUENCE lu_reaction_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_allergies.lu_reaction_type_pk_seq OWNER TO easygp;

--
-- Name: lu_reaction_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_allergies; Owner: easygp
--

ALTER SEQUENCE lu_reaction_type_pk_seq OWNED BY lu_reaction_type.pk;


SET search_path = coding, pg_catalog;

--
-- Name: generic_terms; Type: TABLE; Schema: coding; Owner: easygp; Tablespace: 
--

CREATE TABLE generic_terms (
    code text,
    body_system text,
    code_role integer,
    term text,
    fk_coding_system integer,
    active boolean,
    icd10 character varying(15)
);


ALTER TABLE coding.generic_terms OWNER TO easygp;

--
-- Name: COLUMN generic_terms.icd10; Type: COMMENT; Schema: coding; Owner: easygp
--

COMMENT ON COLUMN generic_terms.icd10 IS 'mapping to ICD-10 where this exists for the system';


--
-- Name: lu_systems; Type: TABLE; Schema: coding; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_systems (
    pk integer NOT NULL,
    system text NOT NULL,
    author text,
    preferred boolean DEFAULT false NOT NULL
);


ALTER TABLE coding.lu_systems OWNER TO easygp;

--
-- Name: TABLE lu_systems; Type: COMMENT; Schema: coding; Owner: easygp
--

COMMENT ON TABLE lu_systems IS 'Contains names of coding systems';


--
-- Name: COLUMN lu_systems.system; Type: COMMENT; Schema: coding; Owner: easygp
--

COMMENT ON COLUMN lu_systems.system IS 'The name of the coding system
  e.g ICPC2 Plus, or ICD10';


--
-- Name: COLUMN lu_systems.author; Type: COMMENT; Schema: coding; Owner: easygp
--

COMMENT ON COLUMN lu_systems.author IS 'the authors of the system';


--
-- Name: COLUMN lu_systems.preferred; Type: COMMENT; Schema: coding; Owner: easygp
--

COMMENT ON COLUMN lu_systems.preferred IS 'true if this is the preferred system';


SET search_path = drugs, pg_catalog;

--
-- Name: atc; Type: TABLE; Schema: drugs; Owner: easygp; Tablespace: 
--

CREATE TABLE atc (
    atccode text NOT NULL,
    atcname text NOT NULL
);


ALTER TABLE drugs.atc OWNER TO easygp;

--
-- Name: TABLE atc; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON TABLE atc IS 'table associating drug names and Anatomic Therapeutic Chemical (ATC) codes';


--
-- Name: brand; Type: TABLE; Schema: drugs; Owner: easygp; Tablespace: 
--

CREATE TABLE brand (
    fk_product uuid NOT NULL,
    fk_company character varying(3) DEFAULT NULL::character varying,
    brand character varying(100) NOT NULL,
    price money,
    from_pbs boolean DEFAULT false NOT NULL,
    original_tga_text text,
    original_tga_code character varying(12),
    pk uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    product_information_filename text,
    product_information_filename_user text,
    current boolean DEFAULT true NOT NULL,
    sct text,
    CONSTRAINT sct_is_numeric CHECK ((sct ~ '^[0-9]+$'::text))
);


ALTER TABLE drugs.brand OWNER TO easygp;

--
-- Name: TABLE brand; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON TABLE brand IS 'many to many pivot table linking drug products and manufacturers';


--
-- Name: COLUMN brand.fk_company; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON COLUMN brand.fk_company IS 'may be null as we can put in our own drug preparations, creams etc';


--
-- Name: COLUMN brand.price; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON COLUMN brand.price IS 'dispensed price for PBS drugs.';


--
-- Name: COLUMN brand.from_pbs; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON COLUMN brand.from_pbs IS 'true if the brand comes from the PBS database, allows the list to be easily reloaded
with new PBS data. False means data we added ourselves.';


--
-- Name: COLUMN brand.original_tga_text; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON COLUMN brand.original_tga_text IS 'drugs imported from TGA database, the original label therein';


--
-- Name: COLUMN brand.original_tga_code; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON COLUMN brand.original_tga_code IS 'drugs imported from TGA database, their TGA code';


--
-- Name: COLUMN brand.product_information_filename_user; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON COLUMN brand.product_information_filename_user IS 'If the user downloads a product information file for their own use it then the filename 
 is kept here';


--
-- Name: product; Type: TABLE; Schema: drugs; Owner: easygp; Tablespace: 
--

CREATE TABLE product (
    pk uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    atccode character varying(8) NOT NULL,
    generic text NOT NULL,
    salt text,
    fk_form integer NOT NULL,
    strength text,
    salt_strength text,
    original_pbs_name text,
    original_pbs_fs text,
    free_comment text,
    updated_at timestamp without time zone DEFAULT now(),
    fk_schedule integer,
    shared boolean DEFAULT true,
    pack_size integer DEFAULT 1,
    amount double precision,
    amount_unit integer,
    units_per_pack integer DEFAULT 1,
    old_original_pbs_name text,
    sct text,
    CONSTRAINT sct_is_numeric CHECK ((sct ~ '^[0-9]+$'::text))
);


ALTER TABLE drugs.product OWNER TO easygp;

--
-- Name: TABLE product; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON TABLE product IS 'dispensable form of a generic drug including strength, package size etc';


--
-- Name: COLUMN product.generic; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON COLUMN product.generic IS 'full generic name in lower-case. For compounds names separated by ";"';


--
-- Name: COLUMN product.salt; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON COLUMN product.salt IS 'if not normally part of generic name, the adjuvant salt';


--
-- Name: COLUMN product.fk_form; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON COLUMN product.fk_form IS 'the form of the drug';


--
-- Name: COLUMN product.strength; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON COLUMN product.strength IS 'the strength as a number followed by a unit. For compounds
strengths are separated by "-", in the same order as the names of the consitituents in the generic name';


--
-- Name: COLUMN product.salt_strength; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON COLUMN product.salt_strength IS 'where a weight of the full salt is listed (being heavier than the weight 
of the solid drug. Must be in same unit';


--
-- Name: COLUMN product.original_pbs_name; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON COLUMN product.original_pbs_name IS 'for a drug imported from the PBS Yellow Book database, the original 
generic name as there listed, otherwise NULL';


--
-- Name: COLUMN product.original_pbs_fs; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON COLUMN product.original_pbs_fs IS 'for a drug imported from the PBS Yellow Book database, the original 
form-and-strength field as there listed, otherwise NULL';


--
-- Name: COLUMN product.free_comment; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON COLUMN product.free_comment IS 'a free-text comment on properties of the product. For example for complex packages
with tablets lof differing strengths';


--
-- Name: COLUMN product.shared; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON COLUMN product.shared IS 'if true then the user/surgery wants to share this drug with easygp-central';


SET search_path = clin_allergies, pg_catalog;

--
-- Name: vwallergies; Type: VIEW; Schema: clin_allergies; Owner: easygp
--

CREATE VIEW vwallergies AS
    SELECT allergies.pk, allergies.fk_consult, allergies.fk_brand, allergies.fk_product, allergies.allergen, allergies.specificity, allergies.details, allergies.fk_lu_reaction_type, allergies.fk_progressnote, lu_reaction_type.type AS reaction_type, allergies.fk_coding_system, allergies.fk_code, allergies.confirmed, allergies.deleted, allergies.date_reaction, consult.fk_patient, consult.consult_date, consult.fk_staff AS fk_staff_logged_allergy, atc.atccode AS product_atccode, atc.atcname AS product_atcname, generic_terms.term, lu_systems.system AS coding_system, product.generic, atc1.atccode AS class_code, atc1.atcname AS class_name, brand.brand, progressnotes.notes FROM (((((((((allergies JOIN lu_reaction_type ON ((allergies.fk_lu_reaction_type = lu_reaction_type.pk))) JOIN clin_consult.consult ON ((allergies.fk_consult = consult.pk))) JOIN clin_consult.progressnotes ON ((allergies.fk_progressnote = progressnotes.pk))) LEFT JOIN drugs.brand ON ((allergies.fk_brand = brand.pk))) LEFT JOIN drugs.product ON ((allergies.fk_product = product.pk))) LEFT JOIN drugs.atc ON (((product.atccode)::text = atc.atccode))) LEFT JOIN coding.generic_terms ON ((allergies.fk_code = generic_terms.code))) LEFT JOIN coding.lu_systems ON ((allergies.fk_coding_system = lu_systems.pk))) LEFT JOIN drugs.atc atc1 ON (("substring"((product.atccode)::text, 1, 4) = atc1.atccode)));


ALTER TABLE clin_allergies.vwallergies OWNER TO easygp;

SET search_path = clin_careplans, pg_catalog;

--
-- Name: careplan_pages; Type: TABLE; Schema: clin_careplans; Owner: easygp; Tablespace: 
--

CREATE TABLE careplan_pages (
    pk integer NOT NULL,
    fk_condition integer NOT NULL,
    fk_education integer,
    fk_aim integer NOT NULL,
    summary text NOT NULL
);


ALTER TABLE clin_careplans.careplan_pages OWNER TO easygp;

--
-- Name: TABLE careplan_pages; Type: COMMENT; Schema: clin_careplans; Owner: easygp
--

COMMENT ON TABLE careplan_pages IS 'Note by default the careplan page does not have a parent, in this case it is a template
 the table careplans links person to multiple careplan pages, which then make up the careplan
 Each care plan page contains the complete html summary of the care plan page, and some (not all) of the
 pointers to care plan components, advice, education, so that it can be re-constructed/deconstructed.
 It will always have a  condition and aim, but may or may
 not have link to education which is not enforced. Any components of the care plan are kept in components_tasks_due';


--
-- Name: COLUMN careplan_pages.fk_condition; Type: COMMENT; Schema: clin_careplans; Owner: easygp
--

COMMENT ON COLUMN careplan_pages.fk_condition IS 'key to lu_conditions table e.g NIDDM';


--
-- Name: COLUMN careplan_pages.fk_education; Type: COMMENT; Schema: clin_careplans; Owner: easygp
--

COMMENT ON COLUMN careplan_pages.fk_education IS 'key to lu_education table';


--
-- Name: COLUMN careplan_pages.fk_aim; Type: COMMENT; Schema: clin_careplans; Owner: easygp
--

COMMENT ON COLUMN careplan_pages.fk_aim IS 'key to lu_aims table e.g -get a life!';


--
-- Name: COLUMN careplan_pages.summary; Type: COMMENT; Schema: clin_careplans; Owner: easygp
--

COMMENT ON COLUMN careplan_pages.summary IS 'a complete html page which is the careplan for this condition
 and which will stand alone for display or printing';


--
-- Name: careplan_pages_pk_seq; Type: SEQUENCE; Schema: clin_careplans; Owner: easygp
--

CREATE SEQUENCE careplan_pages_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_careplans.careplan_pages_pk_seq OWNER TO easygp;

--
-- Name: careplan_pages_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_careplans; Owner: easygp
--

ALTER SEQUENCE careplan_pages_pk_seq OWNED BY careplan_pages.pk;


--
-- Name: careplans; Type: TABLE; Schema: clin_careplans; Owner: easygp; Tablespace: 
--

CREATE TABLE careplans (
    pk integer NOT NULL,
    fk_consult integer NOT NULL
);


ALTER TABLE clin_careplans.careplans OWNER TO easygp;

--
-- Name: TABLE careplans; Type: COMMENT; Schema: clin_careplans; Owner: easygp
--

COMMENT ON TABLE careplans IS '
Creates a unique id for a patient care plan and link to consult it is created or changed
note:
The total care plan consists of one or more html pages describing how to manage a condition in the plan
Condition = the disease condition or risk factor
Aim       = the overall aim of the plan e.g Prevent end organ damage due to elevated BSL and vascular complications of diabetes
Components= methods or ways of achieving the aim, ie of managing the diabetes.
	    Each component will have tasks, ir how this component will be made to work
		component(1) could be $$Monitor vision$$
			 Task(1) could be $$Make appointment with opthalmologist$$
		component(2) could be $$Improve physical fitness$$
	                 Task(1) could be $$exercise for 1 hour per day$$
	                 task(2) could be $$Join a gym$$ 
	    These components are then displayed in table format in the final html and can be dissassembled
NotifyUs  = Reasons(1-n) the patient should contact the surgery.
Education = Information to improve patients understanding of their condition.
SamplePlan is available in Clin_careplans.sample table.
';


--
-- Name: COLUMN careplans.fk_consult; Type: COMMENT; Schema: clin_careplans; Owner: easygp
--

COMMENT ON COLUMN careplans.fk_consult IS 'foreigh key to the clin_consult.consult table (to get the patients id)';


--
-- Name: careplans_pk_seq; Type: SEQUENCE; Schema: clin_careplans; Owner: easygp
--

CREATE SEQUENCE careplans_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_careplans.careplans_pk_seq OWNER TO easygp;

--
-- Name: careplans_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_careplans; Owner: easygp
--

ALTER SEQUENCE careplans_pk_seq OWNED BY careplans.pk;


--
-- Name: component_task_due; Type: TABLE; Schema: clin_careplans; Owner: easygp; Tablespace: 
--

CREATE TABLE component_task_due (
    pk integer NOT NULL,
    fk_careplanpage integer NOT NULL,
    fk_component integer NOT NULL,
    fk_task integer NOT NULL,
    fk_responsible integer,
    due date,
    "interval" text
);


ALTER TABLE clin_careplans.component_task_due OWNER TO easygp;

--
-- Name: TABLE component_task_due; Type: COMMENT; Schema: clin_careplans; Owner: easygp
--

COMMENT ON TABLE component_task_due IS 'links a component to a task, and to whoever is responsible
 and when the task falls due';


--
-- Name: COLUMN component_task_due."interval"; Type: COMMENT; Schema: clin_careplans; Owner: easygp
--

COMMENT ON COLUMN component_task_due."interval" IS 'temporary field containg e.g 12M. Should be two
 fields linked to common.lu_units';


--
-- Name: component_task_due_pk_seq; Type: SEQUENCE; Schema: clin_careplans; Owner: easygp
--

CREATE SEQUENCE component_task_due_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_careplans.component_task_due_pk_seq OWNER TO easygp;

--
-- Name: component_task_due_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_careplans; Owner: easygp
--

ALTER SEQUENCE component_task_due_pk_seq OWNED BY component_task_due.pk;


--
-- Name: link_careplanpage_advice; Type: TABLE; Schema: clin_careplans; Owner: easygp; Tablespace: 
--

CREATE TABLE link_careplanpage_advice (
    pk integer NOT NULL,
    fk_careplanpage integer,
    fk_advice integer
);


ALTER TABLE clin_careplans.link_careplanpage_advice OWNER TO easygp;

--
-- Name: TABLE link_careplanpage_advice; Type: COMMENT; Schema: clin_careplans; Owner: easygp
--

COMMENT ON TABLE link_careplanpage_advice IS 'Links a careplan page to advice. Note that the same condition could have different advice
depending on eg severity of condition, psychology of the patient etc, hence not linked to the
condition, but the care plan page itself.';


--
-- Name: COLUMN link_careplanpage_advice.fk_careplanpage; Type: COMMENT; Schema: clin_careplans; Owner: easygp
--

COMMENT ON COLUMN link_careplanpage_advice.fk_careplanpage IS 'foreign key to data_careplanpage';


--
-- Name: COLUMN link_careplanpage_advice.fk_advice; Type: COMMENT; Schema: clin_careplans; Owner: easygp
--

COMMENT ON COLUMN link_careplanpage_advice.fk_advice IS 'foreign key to lu_advice table';


--
-- Name: link_careplanpage_advice_pk_seq; Type: SEQUENCE; Schema: clin_careplans; Owner: easygp
--

CREATE SEQUENCE link_careplanpage_advice_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_careplans.link_careplanpage_advice_pk_seq OWNER TO easygp;

--
-- Name: link_careplanpage_advice_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_careplans; Owner: easygp
--

ALTER SEQUENCE link_careplanpage_advice_pk_seq OWNED BY link_careplanpage_advice.pk;


--
-- Name: link_careplanpage_components; Type: TABLE; Schema: clin_careplans; Owner: easygp; Tablespace: 
--

CREATE TABLE link_careplanpage_components (
    pk integer NOT NULL,
    fk_careplanpage integer NOT NULL,
    fk_component integer NOT NULL
);


ALTER TABLE clin_careplans.link_careplanpage_components OWNER TO easygp;

--
-- Name: TABLE link_careplanpage_components; Type: COMMENT; Schema: clin_careplans; Owner: easygp
--

COMMENT ON TABLE link_careplanpage_components IS ' links a  careplan page to its component parts';


--
-- Name: link_careplanpage_components_pk_seq; Type: SEQUENCE; Schema: clin_careplans; Owner: easygp
--

CREATE SEQUENCE link_careplanpage_components_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_careplans.link_careplanpage_components_pk_seq OWNER TO easygp;

--
-- Name: link_careplanpage_components_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_careplans; Owner: easygp
--

ALTER SEQUENCE link_careplanpage_components_pk_seq OWNED BY link_careplanpage_components.pk;


--
-- Name: link_careplanpages_careplan; Type: TABLE; Schema: clin_careplans; Owner: easygp; Tablespace: 
--

CREATE TABLE link_careplanpages_careplan (
    pk integer NOT NULL,
    fk_careplan integer NOT NULL,
    fk_careplanpage integer NOT NULL
);


ALTER TABLE clin_careplans.link_careplanpages_careplan OWNER TO easygp;

--
-- Name: TABLE link_careplanpages_careplan; Type: COMMENT; Schema: clin_careplans; Owner: easygp
--

COMMENT ON TABLE link_careplanpages_careplan IS 'links a care plan  to its consituant pages';


--
-- Name: COLUMN link_careplanpages_careplan.fk_careplan; Type: COMMENT; Schema: clin_careplans; Owner: easygp
--

COMMENT ON COLUMN link_careplanpages_careplan.fk_careplan IS 'key to clin_careplans.careplan table';


--
-- Name: COLUMN link_careplanpages_careplan.fk_careplanpage; Type: COMMENT; Schema: clin_careplans; Owner: easygp
--

COMMENT ON COLUMN link_careplanpages_careplan.fk_careplanpage IS 'key to clin_careplans.careplan_pages table';


--
-- Name: link_careplanpages_careplan_pk_seq; Type: SEQUENCE; Schema: clin_careplans; Owner: easygp
--

CREATE SEQUENCE link_careplanpages_careplan_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_careplans.link_careplanpages_careplan_pk_seq OWNER TO easygp;

--
-- Name: link_careplanpages_careplan_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_careplans; Owner: easygp
--

ALTER SEQUENCE link_careplanpages_careplan_pk_seq OWNED BY link_careplanpages_careplan.pk;


--
-- Name: lu_advice; Type: TABLE; Schema: clin_careplans; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_advice (
    pk integer NOT NULL,
    advice text NOT NULL
);


ALTER TABLE clin_careplans.lu_advice OWNER TO easygp;

--
-- Name: TABLE lu_advice; Type: COMMENT; Schema: clin_careplans; Owner: easygp
--

COMMENT ON TABLE lu_advice IS 'Advice to be printed on the care plan re the condition';


--
-- Name: COLUMN lu_advice.advice; Type: COMMENT; Schema: clin_careplans; Owner: easygp
--

COMMENT ON COLUMN lu_advice.advice IS 'advice printed on care plan e.g ring if chest pains';


--
-- Name: lu_advice_pk_seq; Type: SEQUENCE; Schema: clin_careplans; Owner: easygp
--

CREATE SEQUENCE lu_advice_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_careplans.lu_advice_pk_seq OWNER TO easygp;

--
-- Name: lu_advice_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_careplans; Owner: easygp
--

ALTER SEQUENCE lu_advice_pk_seq OWNED BY lu_advice.pk;


--
-- Name: lu_aims; Type: TABLE; Schema: clin_careplans; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_aims (
    pk integer NOT NULL,
    aim text NOT NULL
);


ALTER TABLE clin_careplans.lu_aims OWNER TO easygp;

--
-- Name: lu_aims_pk_seq; Type: SEQUENCE; Schema: clin_careplans; Owner: easygp
--

CREATE SEQUENCE lu_aims_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_careplans.lu_aims_pk_seq OWNER TO easygp;

--
-- Name: lu_aims_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_careplans; Owner: easygp
--

ALTER SEQUENCE lu_aims_pk_seq OWNED BY lu_aims.pk;


--
-- Name: lu_components; Type: TABLE; Schema: clin_careplans; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_components (
    pk integer NOT NULL,
    component text NOT NULL
);


ALTER TABLE clin_careplans.lu_components OWNER TO easygp;

--
-- Name: TABLE lu_components; Type: COMMENT; Schema: clin_careplans; Owner: easygp
--

COMMENT ON TABLE lu_components IS 'A component is a part of a care plan describing
  something that needs to be acheived eg.
  component could be - lose weight - or - increase physical fitness';


--
-- Name: lu_components_pk_seq; Type: SEQUENCE; Schema: clin_careplans; Owner: easygp
--

CREATE SEQUENCE lu_components_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_careplans.lu_components_pk_seq OWNER TO easygp;

--
-- Name: lu_components_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_careplans; Owner: easygp
--

ALTER SEQUENCE lu_components_pk_seq OWNED BY lu_components.pk;


--
-- Name: lu_conditions; Type: TABLE; Schema: clin_careplans; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_conditions (
    pk integer NOT NULL,
    condition text NOT NULL,
    fk_condition_code integer NOT NULL
);


ALTER TABLE clin_careplans.lu_conditions OWNER TO easygp;

--
-- Name: TABLE lu_conditions; Type: COMMENT; Schema: clin_careplans; Owner: easygp
--

COMMENT ON TABLE lu_conditions IS 'Look up table of conditions (should be snomed)';


--
-- Name: COLUMN lu_conditions.condition; Type: COMMENT; Schema: clin_careplans; Owner: easygp
--

COMMENT ON COLUMN lu_conditions.condition IS 'condition eg diabetes, hypertension
Later need to make this just a snomed code';


--
-- Name: COLUMN lu_conditions.fk_condition_code; Type: COMMENT; Schema: clin_careplans; Owner: easygp
--

COMMENT ON COLUMN lu_conditions.fk_condition_code IS 'key to codings.lu_reason table FIXME
this is confusing and ambiguous because of reasons in the care plan schema';


--
-- Name: lu_conditions_pk_seq; Type: SEQUENCE; Schema: clin_careplans; Owner: easygp
--

CREATE SEQUENCE lu_conditions_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_careplans.lu_conditions_pk_seq OWNER TO easygp;

--
-- Name: lu_conditions_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_careplans; Owner: easygp
--

ALTER SEQUENCE lu_conditions_pk_seq OWNED BY lu_conditions.pk;


--
-- Name: lu_education; Type: TABLE; Schema: clin_careplans; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_education (
    pk integer NOT NULL,
    education text
);


ALTER TABLE clin_careplans.lu_education OWNER TO easygp;

--
-- Name: COLUMN lu_education.education; Type: COMMENT; Schema: clin_careplans; Owner: easygp
--

COMMENT ON COLUMN lu_education.education IS 'text of education e.g all about hypertension';


--
-- Name: lu_education_pk_seq; Type: SEQUENCE; Schema: clin_careplans; Owner: easygp
--

CREATE SEQUENCE lu_education_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_careplans.lu_education_pk_seq OWNER TO easygp;

--
-- Name: lu_education_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_careplans; Owner: easygp
--

ALTER SEQUENCE lu_education_pk_seq OWNED BY lu_education.pk;


--
-- Name: lu_responsible; Type: TABLE; Schema: clin_careplans; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_responsible (
    pk integer NOT NULL,
    responsible text NOT NULL
);


ALTER TABLE clin_careplans.lu_responsible OWNER TO easygp;

--
-- Name: TABLE lu_responsible; Type: COMMENT; Schema: clin_careplans; Owner: easygp
--

COMMENT ON TABLE lu_responsible IS 'the person responsible for implementing a component of a care plan
  this preferably should be generic eg Dr, GP, Practice Nurse, Secretary
  Patient, but can be specific eg Dr Imthe BestDoctor';


--
-- Name: lu_responsible_pk_seq; Type: SEQUENCE; Schema: clin_careplans; Owner: easygp
--

CREATE SEQUENCE lu_responsible_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_careplans.lu_responsible_pk_seq OWNER TO easygp;

--
-- Name: lu_responsible_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_careplans; Owner: easygp
--

ALTER SEQUENCE lu_responsible_pk_seq OWNED BY lu_responsible.pk;


--
-- Name: lu_tasks; Type: TABLE; Schema: clin_careplans; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_tasks (
    pk integer NOT NULL,
    task text NOT NULL
);


ALTER TABLE clin_careplans.lu_tasks OWNER TO easygp;

--
-- Name: TABLE lu_tasks; Type: COMMENT; Schema: clin_careplans; Owner: easygp
--

COMMENT ON TABLE lu_tasks IS 'A task is something that needs to be done to acheive one of the 
 goals in a care plan e.g:
 What to acheive is - improve physical fitness
 Task could be - exercise 1 hour per day or -joint a gym';


--
-- Name: lu_tasks_pk_seq; Type: SEQUENCE; Schema: clin_careplans; Owner: easygp
--

CREATE SEQUENCE lu_tasks_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_careplans.lu_tasks_pk_seq OWNER TO easygp;

--
-- Name: lu_tasks_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_careplans; Owner: easygp
--

ALTER SEQUENCE lu_tasks_pk_seq OWNED BY lu_tasks.pk;


--
-- Name: sample_plan; Type: TABLE; Schema: clin_careplans; Owner: easygp; Tablespace: 
--

CREATE TABLE sample_plan (
    html text
);


ALTER TABLE clin_careplans.sample_plan OWNER TO easygp;

--
-- Name: test; Type: TABLE; Schema: clin_careplans; Owner: easygp; Tablespace: 
--

CREATE TABLE test (
    somedata text[]
);


ALTER TABLE clin_careplans.test OWNER TO easygp;

SET search_path = clin_certificates, pg_catalog;

--
-- Name: certificate_reasons; Type: TABLE; Schema: clin_certificates; Owner: easygp; Tablespace: 
--

CREATE TABLE certificate_reasons (
    pk integer NOT NULL,
    fk_staff integer NOT NULL,
    reason text NOT NULL
);


ALTER TABLE clin_certificates.certificate_reasons OWNER TO easygp;

--
-- Name: TABLE certificate_reasons; Type: COMMENT; Schema: clin_certificates; Owner: easygp
--

COMMENT ON TABLE certificate_reasons IS 'A table to keep reasons a particular doctor writes for certificates
  to make data entry quicker - for popup lists - caveat spelling - no checker yet installed';


--
-- Name: certificate_reasons_pk_seq; Type: SEQUENCE; Schema: clin_certificates; Owner: easygp
--

CREATE SEQUENCE certificate_reasons_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_certificates.certificate_reasons_pk_seq OWNER TO easygp;

--
-- Name: certificate_reasons_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_certificates; Owner: easygp
--

ALTER SEQUENCE certificate_reasons_pk_seq OWNED BY certificate_reasons.pk;


--
-- Name: lu_fitness; Type: TABLE; Schema: clin_certificates; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_fitness (
    pk integer NOT NULL,
    fitness text NOT NULL
);


ALTER TABLE clin_certificates.lu_fitness OWNER TO easygp;

--
-- Name: lu_fitness_pk_seq; Type: SEQUENCE; Schema: clin_certificates; Owner: easygp
--

CREATE SEQUENCE lu_fitness_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_certificates.lu_fitness_pk_seq OWNER TO easygp;

--
-- Name: lu_fitness_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_certificates; Owner: easygp
--

ALTER SEQUENCE lu_fitness_pk_seq OWNED BY lu_fitness.pk;


--
-- Name: lu_illness_temporality; Type: TABLE; Schema: clin_certificates; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_illness_temporality (
    pk integer NOT NULL,
    temporality text NOT NULL
);


ALTER TABLE clin_certificates.lu_illness_temporality OWNER TO easygp;

--
-- Name: TABLE lu_illness_temporality; Type: COMMENT; Schema: clin_certificates; Owner: easygp
--

COMMENT ON TABLE lu_illness_temporality IS 'dictionary defination: of or relating to the sequence of time or to a particular time
 in our case a lookup table to indicate in past, now, in the future';


--
-- Name: COLUMN lu_illness_temporality.temporality; Type: COMMENT; Schema: clin_certificates; Owner: easygp
--

COMMENT ON COLUMN lu_illness_temporality.temporality IS 'text contents: is - was - will be';


--
-- Name: lu_illness_temporality_pk_seq; Type: SEQUENCE; Schema: clin_certificates; Owner: easygp
--

CREATE SEQUENCE lu_illness_temporality_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_certificates.lu_illness_temporality_pk_seq OWNER TO easygp;

--
-- Name: lu_illness_temporality_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_certificates; Owner: easygp
--

ALTER SEQUENCE lu_illness_temporality_pk_seq OWNED BY lu_illness_temporality.pk;


--
-- Name: medical_certificates; Type: TABLE; Schema: clin_certificates; Owner: easygp; Tablespace: 
--

CREATE TABLE medical_certificates (
    pk integer NOT NULL,
    fk_consult integer NOT NULL,
    reason text,
    fk_coding_system integer,
    fk_code text,
    fk_lu_illness_temporality integer NOT NULL,
    from_date date NOT NULL,
    to_date date,
    deleted boolean DEFAULT false,
    fk_lu_fitness integer,
    notes text,
    certificate_date date NOT NULL,
    fk_progressnote integer,
    latex text,
    print_notes boolean DEFAULT false
);


ALTER TABLE clin_certificates.medical_certificates OWNER TO easygp;

--
-- Name: TABLE medical_certificates; Type: COMMENT; Schema: clin_certificates; Owner: easygp
--

COMMENT ON TABLE medical_certificates IS 'a table to save medical certificates';


--
-- Name: COLUMN medical_certificates.fk_consult; Type: COMMENT; Schema: clin_certificates; Owner: easygp
--

COMMENT ON COLUMN medical_certificates.fk_consult IS 'foreign key to clin_consult.consult table identifies consult date and staff member';


--
-- Name: COLUMN medical_certificates.reason; Type: COMMENT; Schema: clin_certificates; Owner: easygp
--

COMMENT ON COLUMN medical_certificates.reason IS 'temporary concession to non-coders, the text reason for the certificate';


--
-- Name: COLUMN medical_certificates.fk_coding_system; Type: COMMENT; Schema: clin_certificates; Owner: easygp
--

COMMENT ON COLUMN medical_certificates.fk_coding_system IS 'key to coding.lu_coding_system containing name of coding system eg icpc, icd10';


--
-- Name: COLUMN medical_certificates.fk_code; Type: COMMENT; Schema: clin_certificates; Owner: easygp
--

COMMENT ON COLUMN medical_certificates.fk_code IS 'the coded reason for the illness eg N18';


--
-- Name: COLUMN medical_certificates.fk_lu_illness_temporality; Type: COMMENT; Schema: clin_certificates; Owner: easygp
--

COMMENT ON COLUMN medical_certificates.fk_lu_illness_temporality IS 'foreign key to fk_lu_illness_temporality table to tell temporal nature of the certificate
 i.e was sick, is sick, will be sick';


--
-- Name: COLUMN medical_certificates.from_date; Type: COMMENT; Schema: clin_certificates; Owner: easygp
--

COMMENT ON COLUMN medical_certificates.from_date IS 'Date from which the person was unwell';


--
-- Name: COLUMN medical_certificates.to_date; Type: COMMENT; Schema: clin_certificates; Owner: easygp
--

COMMENT ON COLUMN medical_certificates.to_date IS 'Date to which the person will be unwell';


--
-- Name: COLUMN medical_certificates.deleted; Type: COMMENT; Schema: clin_certificates; Owner: easygp
--

COMMENT ON COLUMN medical_certificates.deleted IS 'if true the record is marked as deleted';


--
-- Name: COLUMN medical_certificates.certificate_date; Type: COMMENT; Schema: clin_certificates; Owner: easygp
--

COMMENT ON COLUMN medical_certificates.certificate_date IS '
The date which appears on top of the certificate
this may not be the date on which it was written, e.g sometimes have to
back-date a certificate';


--
-- Name: COLUMN medical_certificates.fk_progressnote; Type: COMMENT; Schema: clin_certificates; Owner: easygp
--

COMMENT ON COLUMN medical_certificates.fk_progressnote IS 'references clin_consult.progressnotes primary key';


--
-- Name: COLUMN medical_certificates.latex; Type: COMMENT; Schema: clin_certificates; Owner: easygp
--

COMMENT ON COLUMN medical_certificates.latex IS 'the latex text of the certificate';


--
-- Name: COLUMN medical_certificates.print_notes; Type: COMMENT; Schema: clin_certificates; Owner: easygp
--

COMMENT ON COLUMN medical_certificates.print_notes IS 'if true then the notes will be printed on the medical certificate';


--
-- Name: medical_certificate_pk_seq; Type: SEQUENCE; Schema: clin_certificates; Owner: easygp
--

CREATE SEQUENCE medical_certificate_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_certificates.medical_certificate_pk_seq OWNER TO easygp;

--
-- Name: medical_certificate_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_certificates; Owner: easygp
--

ALTER SEQUENCE medical_certificate_pk_seq OWNED BY medical_certificates.pk;


--
-- Name: vwmedicalcertificates; Type: VIEW; Schema: clin_certificates; Owner: easygp
--

CREATE VIEW vwmedicalcertificates AS
    SELECT medical_certificates.pk AS pk_medicalcertificate, consult.fk_patient, consult.consult_date, medical_certificates.fk_consult, medical_certificates.certificate_date, medical_certificates.reason, medical_certificates.fk_coding_system, medical_certificates.fk_code, medical_certificates.fk_lu_illness_temporality, medical_certificates.fk_lu_fitness, lu_fitness.fitness, medical_certificates.from_date, medical_certificates.deleted, medical_certificates.to_date, medical_certificates.notes, medical_certificates.print_notes, medical_certificates.fk_progressnote, medical_certificates.latex, consult.fk_staff, vwstaffinclinics.wholename AS staff_wholename, vwstaffinclinics.title AS staff_title, vwstaffinclinics.branch AS staff_branch, vwstaffinclinics.organisation AS staff_organisation, vwstaffinclinics.street1 AS staff_street1, vwstaffinclinics.street2 AS staff_street2, vwstaffinclinics.town AS staff_town, vwstaffinclinics.postcode AS staff_postcode, vwstaffinclinics.provider_number AS staff_provider_number, lu_illness_temporality.temporality, lu_systems.system, generic_terms.term, generic_terms.code FROM ((((((medical_certificates medical_certificates JOIN clin_consult.consult ON ((medical_certificates.fk_consult = consult.pk))) JOIN admin.vwstaffinclinics ON ((consult.fk_staff = vwstaffinclinics.fk_staff))) JOIN lu_illness_temporality ON ((medical_certificates.fk_lu_illness_temporality = lu_illness_temporality.pk))) JOIN lu_fitness ON ((medical_certificates.fk_lu_fitness = lu_fitness.pk))) LEFT JOIN coding.lu_systems ON ((medical_certificates.fk_coding_system = lu_systems.pk))) LEFT JOIN coding.generic_terms ON ((medical_certificates.fk_code = generic_terms.code))) ORDER BY consult.fk_patient, consult.consult_date;


ALTER TABLE clin_certificates.vwmedicalcertificates OWNER TO easygp;

--
-- Name: VIEW vwmedicalcertificates; Type: COMMENT; Schema: clin_certificates; Owner: easygp
--

COMMENT ON VIEW vwmedicalcertificates IS 'A view of patients medical certificate history';


SET search_path = clin_checkups, pg_catalog;

--
-- Name: annual_checkup; Type: TABLE; Schema: clin_checkups; Owner: easygp; Tablespace: 
--

CREATE TABLE annual_checkup (
    pk integer NOT NULL,
    pk_consult integer,
    patient_concerns text,
    "system _review" text,
    centralnervoussystem_sysreview boolean DEFAULT false,
    earnosethroat_sysreview boolean DEFAULT false,
    cardiovascular_sysreview boolean DEFAULT false,
    respiratory_sysreview boolean DEFAULT false,
    muskuloskeletal_sysreview boolean DEFAULT false,
    gastrointestinal_sysreview boolean DEFAULT false,
    genitourinary_sysreview boolean DEFAULT false,
    endocrine_sysreview boolean DEFAULT false,
    haemopoetic_sysreview boolean DEFAULT false,
    fk_height integer,
    fk_weight numeric,
    bmi numeric,
    overweight_kg numeric,
    fk_bp numeric,
    fk_bsl numeric,
    fk_urinalysis text,
    clinical_notes text,
    summary text,
    consultation_html text
);


ALTER TABLE clin_checkups.annual_checkup OWNER TO easygp;

--
-- Name: TABLE annual_checkup; Type: COMMENT; Schema: clin_checkups; Owner: easygp
--

COMMENT ON TABLE annual_checkup IS 'Describes a persons annual checkup';


--
-- Name: annual_checkup_pk_seq; Type: SEQUENCE; Schema: clin_checkups; Owner: easygp
--

CREATE SEQUENCE annual_checkup_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_checkups.annual_checkup_pk_seq OWNER TO easygp;

--
-- Name: annual_checkup_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_checkups; Owner: easygp
--

ALTER SEQUENCE annual_checkup_pk_seq OWNED BY annual_checkup.pk;


--
-- Name: lu_nutrition_questions; Type: TABLE; Schema: clin_checkups; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_nutrition_questions (
    pk integer NOT NULL,
    question text NOT NULL,
    red_flag_text text
);


ALTER TABLE clin_checkups.lu_nutrition_questions OWNER TO easygp;

--
-- Name: TABLE lu_nutrition_questions; Type: COMMENT; Schema: clin_checkups; Owner: easygp
--

COMMENT ON TABLE lu_nutrition_questions IS 'The questions to determinate patients state of nuitrition';


--
-- Name: COLUMN lu_nutrition_questions.question; Type: COMMENT; Schema: clin_checkups; Owner: easygp
--

COMMENT ON COLUMN lu_nutrition_questions.question IS 'the question e.g do you have enough money for food?';


--
-- Name: COLUMN lu_nutrition_questions.red_flag_text; Type: COMMENT; Schema: clin_checkups; Owner: easygp
--

COMMENT ON COLUMN lu_nutrition_questions.red_flag_text IS 'the question translated e.g may not have enough money to buy food and may be null';


--
-- Name: lu_nutrition_questions_pk_seq; Type: SEQUENCE; Schema: clin_checkups; Owner: easygp
--

CREATE SEQUENCE lu_nutrition_questions_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_checkups.lu_nutrition_questions_pk_seq OWNER TO easygp;

--
-- Name: lu_nutrition_questions_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_checkups; Owner: easygp
--

ALTER SEQUENCE lu_nutrition_questions_pk_seq OWNED BY lu_nutrition_questions.pk;


--
-- Name: lu_state_of_health; Type: TABLE; Schema: clin_checkups; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_state_of_health (
    pk integer NOT NULL,
    state_of_health text NOT NULL
);


ALTER TABLE clin_checkups.lu_state_of_health OWNER TO easygp;

--
-- Name: TABLE lu_state_of_health; Type: COMMENT; Schema: clin_checkups; Owner: easygp
--

COMMENT ON TABLE lu_state_of_health IS 'The general state of the patients health';


--
-- Name: COLUMN lu_state_of_health.state_of_health; Type: COMMENT; Schema: clin_checkups; Owner: easygp
--

COMMENT ON COLUMN lu_state_of_health.state_of_health IS 'excellent, very good, good, fair, poor, indeterminate';


--
-- Name: lu_state_of_health_pk_seq; Type: SEQUENCE; Schema: clin_checkups; Owner: easygp
--

CREATE SEQUENCE lu_state_of_health_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_checkups.lu_state_of_health_pk_seq OWNER TO easygp;

--
-- Name: lu_state_of_health_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_checkups; Owner: easygp
--

ALTER SEQUENCE lu_state_of_health_pk_seq OWNED BY lu_state_of_health.pk;


--
-- Name: over75; Type: TABLE; Schema: clin_checkups; Owner: easygp; Tablespace: 
--

CREATE TABLE over75 (
    pk integer NOT NULL,
    fk_lu_consult_type integer NOT NULL,
    fk_lu_state_of_health integer NOT NULL,
    systems_reviewed boolean,
    fk_lu_smoking_status integer,
    alcohol_gm_per_day integer,
    consider_alcohol_audit_tool boolean,
    exercise boolean,
    foot_problems boolean,
    visual_acuity text,
    lu_hearing_aid_status integer,
    fk_lu_earcanal_status integer,
    fk_lu_whisper_test integer,
    fit_to_drive boolean,
    urinary_incontinence boolean,
    fk_bowel_trouble boolean,
    system_review_comments text,
    other_health_professionals text,
    mentalstatus_problems boolean,
    mentalstatus_consider_assessment_tool boolean,
    fk_lu_companion_status integer,
    fk_lu_social_support integer,
    independance_have_carer boolean,
    independance_is_carer boolean,
    fk_lu_depression_degree boolean,
    mood_difficulty_sleeping boolean,
    mood_consider_assessement_tool boolean,
    nuitrition_dentures_yes_no boolean,
    nuitrition_denture_problems boolean,
    nuitrition_eating_less boolean,
    nuitrition_3meals_per_day boolean,
    nuitrition_fruit_n_veg boolean,
    nuitrition_dairy boolean,
    nuitrition_excess_alcohol boolean,
    nuitrition_adequate_fluids boolean,
    nuitrition_swallowing_problems boolean,
    nuitrition_enough_money boolean,
    nuitrition_eat_alone boolean,
    nuitrition_lots_of_medications boolean,
    nuitrition_weight_change boolean,
    nuitrition_shop_cook_feed boolean,
    mobility_aid_indoors boolean,
    mobility_aid_outdoors boolean,
    mobility_bath_shower boolean,
    mobility_bend_kneel boolean,
    mobility_walk100meters boolean,
    mobility_use_steps boolean,
    mobility_reach_overhead boolean,
    mobility_no_clutter boolean,
    mobility_adequate_lighting boolean,
    mobility_free_of_falls boolean,
    mobility_actions_suggested text,
    home_safety_use_chairs boolean,
    home_safety_use_bed boolean,
    home_safety_use_light boolean,
    home_safety_use_toilet boolean,
    home_safety_flooring_secured boolean,
    home_safety_use_bath_mats boolean,
    home_safety_carry_meals boolean,
    home_safety_use_utensils boolean,
    home_safety_see_stairs boolean,
    home_safety_actions_suggested text
);


ALTER TABLE clin_checkups.over75 OWNER TO easygp;

--
-- Name: COLUMN over75.fk_lu_consult_type; Type: COMMENT; Schema: clin_checkups; Owner: easygp
--

COMMENT ON COLUMN over75.fk_lu_consult_type IS 'foreign key to consult.lu_consult_type table eg home visit';


--
-- Name: COLUMN over75.fk_lu_state_of_health; Type: COMMENT; Schema: clin_checkups; Owner: easygp
--

COMMENT ON COLUMN over75.fk_lu_state_of_health IS 'foreign key to clin_checkups.fk_lu_state_of_health table';


--
-- Name: COLUMN over75.fk_lu_smoking_status; Type: COMMENT; Schema: clin_checkups; Owner: easygp
--

COMMENT ON COLUMN over75.fk_lu_smoking_status IS 'foreign key to clin_checkups.lu_lu_smoking_status';


--
-- Name: COLUMN over75.fk_lu_earcanal_status; Type: COMMENT; Schema: clin_checkups; Owner: easygp
--

COMMENT ON COLUMN over75.fk_lu_earcanal_status IS 'references common.lu_normality';


--
-- Name: over75_pk_seq; Type: SEQUENCE; Schema: clin_checkups; Owner: easygp
--

CREATE SEQUENCE over75_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_checkups.over75_pk_seq OWNER TO easygp;

--
-- Name: over75_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_checkups; Owner: easygp
--

ALTER SEQUENCE over75_pk_seq OWNED BY over75.pk;


SET search_path = clin_consult, pg_catalog;

--
-- Name: consult_pk_seq; Type: SEQUENCE; Schema: clin_consult; Owner: easygp
--

CREATE SEQUENCE consult_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_consult.consult_pk_seq OWNER TO easygp;

--
-- Name: consult_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_consult; Owner: easygp
--

ALTER SEQUENCE consult_pk_seq OWNED BY consult.pk;


--
-- Name: dictations; Type: TABLE; Schema: clin_consult; Owner: easygp; Tablespace: 
--

CREATE TABLE dictations (
    pk integer NOT NULL,
    filename text NOT NULL,
    fk_referral integer,
    fk_progress_note integer,
    transcript text,
    fk_user integer NOT NULL,
    processed boolean DEFAULT false NOT NULL
);


ALTER TABLE clin_consult.dictations OWNER TO easygp;

--
-- Name: TABLE dictations; Type: COMMENT; Schema: clin_consult; Owner: easygp
--

COMMENT ON TABLE dictations IS 'dictation recordings made by the user';


--
-- Name: COLUMN dictations.filename; Type: COMMENT; Schema: clin_consult; Owner: easygp
--

COMMENT ON COLUMN dictations.filename IS 'the name of the MP3 file in the documents store';


--
-- Name: COLUMN dictations.fk_referral; Type: COMMENT; Schema: clin_consult; Owner: easygp
--

COMMENT ON COLUMN dictations.fk_referral IS 'if a dictated referral, the (saved unsent) referral row to be filled';


--
-- Name: COLUMN dictations.fk_progress_note; Type: COMMENT; Schema: clin_consult; Owner: easygp
--

COMMENT ON COLUMN dictations.fk_progress_note IS 'if a progress note, the progress note row to be filled in. This and fk_referral cannot both be NULL, but one alwys will be';


--
-- Name: COLUMN dictations.transcript; Type: COMMENT; Schema: clin_consult; Owner: easygp
--

COMMENT ON COLUMN dictations.transcript IS 'the text as returned by the transcriptionist, without user corrections';


--
-- Name: COLUMN dictations.processed; Type: COMMENT; Schema: clin_consult; Owner: easygp
--

COMMENT ON COLUMN dictations.processed IS 'true if the user has reviewed the transcript, corrected and post to the original table (referral or progress note). In principle the referral could still be unsent, but would usually be sent immediately after correction of the transcript';


--
-- Name: dictations_pk_seq; Type: SEQUENCE; Schema: clin_consult; Owner: easygp
--

CREATE SEQUENCE dictations_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_consult.dictations_pk_seq OWNER TO easygp;

--
-- Name: dictations_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_consult; Owner: easygp
--

ALTER SEQUENCE dictations_pk_seq OWNED BY dictations.pk;


--
-- Name: images; Type: TABLE; Schema: clin_consult; Owner: easygp; Tablespace: 
--

CREATE TABLE images (
    pk integer NOT NULL,
    image bytea,
    deleted boolean
);


ALTER TABLE clin_consult.images OWNER TO easygp;

--
-- Name: images_pk_seq; Type: SEQUENCE; Schema: clin_consult; Owner: easygp
--

CREATE SEQUENCE images_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_consult.images_pk_seq OWNER TO easygp;

--
-- Name: images_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_consult; Owner: easygp
--

ALTER SEQUENCE images_pk_seq OWNED BY images.pk;


--
-- Name: lu_actions_pk_seq; Type: SEQUENCE; Schema: clin_consult; Owner: easygp
--

CREATE SEQUENCE lu_actions_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_consult.lu_actions_pk_seq OWNER TO easygp;

--
-- Name: lu_actions_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_consult; Owner: easygp
--

ALTER SEQUENCE lu_actions_pk_seq OWNED BY lu_audit_actions.pk;


--
-- Name: lu_audit_reasons_pk_seq; Type: SEQUENCE; Schema: clin_consult; Owner: easygp
--

CREATE SEQUENCE lu_audit_reasons_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_consult.lu_audit_reasons_pk_seq OWNER TO easygp;

--
-- Name: lu_audit_reasons_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_consult; Owner: easygp
--

ALTER SEQUENCE lu_audit_reasons_pk_seq OWNED BY lu_audit_reasons.pk;


--
-- Name: lu_consult_type_pk_seq; Type: SEQUENCE; Schema: clin_consult; Owner: easygp
--

CREATE SEQUENCE lu_consult_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_consult.lu_consult_type_pk_seq OWNER TO easygp;

--
-- Name: lu_consult_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_consult; Owner: easygp
--

ALTER SEQUENCE lu_consult_type_pk_seq OWNED BY lu_consult_type.pk;


--
-- Name: lu_progressnote_templates; Type: TABLE; Schema: clin_consult; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_progressnote_templates (
    pk integer NOT NULL,
    fk_staff integer NOT NULL,
    shared boolean DEFAULT false,
    name text NOT NULL,
    deleted boolean DEFAULT false,
    template text NOT NULL
);


ALTER TABLE clin_consult.lu_progressnote_templates OWNER TO easygp;

--
-- Name: TABLE lu_progressnote_templates; Type: COMMENT; Schema: clin_consult; Owner: easygp
--

COMMENT ON TABLE lu_progressnote_templates IS 'Table to hold templates for progress notes';


--
-- Name: COLUMN lu_progressnote_templates.shared; Type: COMMENT; Schema: clin_consult; Owner: easygp
--

COMMENT ON COLUMN lu_progressnote_templates.shared IS 'if true then anyone can access this template';


--
-- Name: COLUMN lu_progressnote_templates.template; Type: COMMENT; Schema: clin_consult; Owner: easygp
--

COMMENT ON COLUMN lu_progressnote_templates.template IS 'html for a letter template';


--
-- Name: lu_progressnote_templates_pk_seq; Type: SEQUENCE; Schema: clin_consult; Owner: easygp
--

CREATE SEQUENCE lu_progressnote_templates_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_consult.lu_progressnote_templates_pk_seq OWNER TO easygp;

--
-- Name: lu_progressnote_templates_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_consult; Owner: easygp
--

ALTER SEQUENCE lu_progressnote_templates_pk_seq OWNED BY lu_progressnote_templates.pk;


--
-- Name: lu_progressnotes_sections_pk_seq; Type: SEQUENCE; Schema: clin_consult; Owner: easygp
--

CREATE SEQUENCE lu_progressnotes_sections_pk_seq
    START WITH 20
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_consult.lu_progressnotes_sections_pk_seq OWNER TO easygp;

--
-- Name: lu_progressnotes_sections_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_consult; Owner: easygp
--

ALTER SEQUENCE lu_progressnotes_sections_pk_seq OWNED BY lu_progressnotes_sections.pk;


--
-- Name: lu_scratchpad_status; Type: TABLE; Schema: clin_consult; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_scratchpad_status (
    pk integer NOT NULL,
    status text
);


ALTER TABLE clin_consult.lu_scratchpad_status OWNER TO easygp;

--
-- Name: TABLE lu_scratchpad_status; Type: COMMENT; Schema: clin_consult; Owner: easygp
--

COMMENT ON TABLE lu_scratchpad_status IS 'Current status of the scrathpad item 
e.g outstanding
    compeleted
    completed with explanation
    marked as deleted
    ';


--
-- Name: lu_scratchpad_status_pk_seq; Type: SEQUENCE; Schema: clin_consult; Owner: easygp
--

CREATE SEQUENCE lu_scratchpad_status_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_consult.lu_scratchpad_status_pk_seq OWNER TO easygp;

--
-- Name: lu_scratchpad_status_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_consult; Owner: easygp
--

ALTER SEQUENCE lu_scratchpad_status_pk_seq OWNED BY lu_scratchpad_status.pk;


--
-- Name: progressnotes_pk_seq; Type: SEQUENCE; Schema: clin_consult; Owner: easygp
--

CREATE SEQUENCE progressnotes_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_consult.progressnotes_pk_seq OWNER TO easygp;

--
-- Name: progressnotes_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_consult; Owner: easygp
--

ALTER SEQUENCE progressnotes_pk_seq OWNED BY progressnotes.pk;


--
-- Name: scratchpad; Type: TABLE; Schema: clin_consult; Owner: easygp; Tablespace: 
--

CREATE TABLE scratchpad (
    pk integer NOT NULL,
    fk_consult integer,
    note text,
    deleted boolean DEFAULT false,
    fk_lu_status integer NOT NULL,
    fk_progressnote integer
);


ALTER TABLE clin_consult.scratchpad OWNER TO easygp;

--
-- Name: COLUMN scratchpad.fk_progressnote; Type: COMMENT; Schema: clin_consult; Owner: easygp
--

COMMENT ON COLUMN scratchpad.fk_progressnote IS 'foreign key to clin_consult.progressnotes, points to the last progress note entry for this item';


--
-- Name: scratchpad_pk_seq; Type: SEQUENCE; Schema: clin_consult; Owner: easygp
--

CREATE SEQUENCE scratchpad_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_consult.scratchpad_pk_seq OWNER TO easygp;

--
-- Name: scratchpad_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_consult; Owner: easygp
--

ALTER SEQUENCE scratchpad_pk_seq OWNED BY scratchpad.pk;


SET search_path = clin_referrals, pg_catalog;

--
-- Name: referrals; Type: TABLE; Schema: clin_referrals; Owner: easygp; Tablespace: 
--

CREATE TABLE referrals (
    pk integer NOT NULL,
    fk_consult integer NOT NULL,
    date_referral date NOT NULL,
    fk_branch integer,
    fk_employee integer,
    fk_person integer,
    fk_address integer,
    fk_type integer,
    letter_html text,
    tag text,
    deleted boolean DEFAULT false,
    body_html text,
    fk_pasthistory integer DEFAULT 0,
    fk_progressnote integer,
    include_careplan boolean DEFAULT false,
    include_healthsummary boolean DEFAULT false,
    copyto text,
    fk_lu_urgency integer DEFAULT 1,
    letter_hl7 text,
    finalised boolean DEFAULT false
);


ALTER TABLE clin_referrals.referrals OWNER TO easygp;

--
-- Name: TABLE referrals; Type: COMMENT; Schema: clin_referrals; Owner: easygp
--

COMMENT ON TABLE referrals IS 'data of all referrals. Note that I kept all my referral as shredded down rich text files outside of the database so this table will probably change.';


--
-- Name: COLUMN referrals.fk_consult; Type: COMMENT; Schema: clin_referrals; Owner: easygp
--

COMMENT ON COLUMN referrals.fk_consult IS 'key to the main clin_consult.consult table which is the master table of the database';


--
-- Name: COLUMN referrals.date_referral; Type: COMMENT; Schema: clin_referrals; Owner: easygp
--

COMMENT ON COLUMN referrals.date_referral IS 'Date written on the referral, may not be the consult_date';


--
-- Name: COLUMN referrals.fk_branch; Type: COMMENT; Schema: clin_referrals; Owner: easygp
--

COMMENT ON COLUMN referrals.fk_branch IS 'if not null key to contacts.data_branches - points to organisation and address of the organisation';


--
-- Name: COLUMN referrals.fk_employee; Type: COMMENT; Schema: clin_referrals; Owner: easygp
--

COMMENT ON COLUMN referrals.fk_employee IS 'if not null key to contacts.data_employees table - points to employee of an organisation';


--
-- Name: COLUMN referrals.fk_person; Type: COMMENT; Schema: clin_referrals; Owner: easygp
--

COMMENT ON COLUMN referrals.fk_person IS 'if not null key to contacts.data_persons table ie person referred to';


--
-- Name: COLUMN referrals.fk_address; Type: COMMENT; Schema: clin_referrals; Owner: easygp
--

COMMENT ON COLUMN referrals.fk_address IS 'key to contacts.data_addresses, if not null is the address of the person. not the address of the organisation/branch/employee obtained through the other keys';


--
-- Name: COLUMN referrals.fk_type; Type: COMMENT; Schema: clin_referrals; Owner: easygp
--

COMMENT ON COLUMN referrals.fk_type IS 'key to lu_referral_type table ie type of referral e.g opinion or management';


--
-- Name: COLUMN referrals.letter_html; Type: COMMENT; Schema: clin_referrals; Owner: easygp
--

COMMENT ON COLUMN referrals.letter_html IS 'html which is the letter itself';


--
-- Name: COLUMN referrals.tag; Type: COMMENT; Schema: clin_referrals; Owner: easygp
--

COMMENT ON COLUMN referrals.tag IS 'A description of the letter eg ''heart failure''';


--
-- Name: COLUMN referrals.body_html; Type: COMMENT; Schema: clin_referrals; Owner: easygp
--

COMMENT ON COLUMN referrals.body_html IS 'Contains the html of the body of the letter';


--
-- Name: COLUMN referrals.fk_pasthistory; Type: COMMENT; Schema: clin_referrals; Owner: easygp
--

COMMENT ON COLUMN referrals.fk_pasthistory IS 'if not 0 = general notes, then is the key to clin_history.past_history table';


--
-- Name: COLUMN referrals.fk_progressnote; Type: COMMENT; Schema: clin_referrals; Owner: easygp
--

COMMENT ON COLUMN referrals.fk_progressnote IS 'key to clin_consult.progress notes table - points to the progress note of a letter during the
 consultation it was written in - used for editing/auditing';


--
-- Name: COLUMN referrals.copyto; Type: COMMENT; Schema: clin_referrals; Owner: easygp
--

COMMENT ON COLUMN referrals.copyto IS 'a Pipe delimated list of entities receiving copies
 e.g Mr Joe Blogs
     John Hunter hospital, Lookout Rd New Lambton Heights
     any free text or constructed text is acceptable';


--
-- Name: COLUMN referrals.letter_hl7; Type: COMMENT; Schema: clin_referrals; Owner: easygp
--

COMMENT ON COLUMN referrals.letter_hl7 IS ' the hl7 of the letter ** minus ** the inclusions OBX segments
   the hl7 file sent can be ''re-constituted'' by accessing the referrals.inclusions table';


--
-- Name: COLUMN referrals.finalised; Type: COMMENT; Schema: clin_referrals; Owner: easygp
--

COMMENT ON COLUMN referrals.finalised IS 'if true the letter has been partly written but not sent either by hl7 or printed';


SET search_path = clin_consult, pg_catalog;

--
-- Name: vwdictations; Type: VIEW; Schema: clin_consult; Owner: ian
--

CREATE VIEW vwdictations AS
    SELECT d.pk AS pk_dictation, d.fk_referral, d.transcript, d.fk_progress_note, d.fk_user, d.processed, d.filename, vwp.wholename, c.fk_patient FROM dictations d, clin_referrals.referrals r, contacts.vwpatients vwp, consult c WHERE (((d.fk_referral = r.pk) AND (r.fk_consult = c.pk)) AND (c.fk_patient = vwp.fk_patient));


ALTER TABLE clin_consult.vwdictations OWNER TO ian;

--
-- Name: vwpatientconsults; Type: VIEW; Schema: clin_consult; Owner: easygp
--

CREATE VIEW vwpatientconsults AS
    SELECT DISTINCT vwprogressnotes.consult_date AS pk_view, vwprogressnotes.fk_patient, vwprogressnotes.consult_date, vwprogressnotes.consult_type, vwprogressnotes.fk_staff, vwprogressnotes.title AS staff_title, vwprogressnotes.surname AS staff_surname, vwprogressnotes.firstname AS staff_firstname, vwprogressnotes.linked_table, vwprogressnotes.fk_type, vwpatients.wholename, vwpatients.firstname, vwpatients.surname, vwpatients.street1, vwpatients.street2, vwpatients.town, vwpatients.state, vwpatients.postcode, vwpatients.deceased, vwpatients.sex, vwpatients.title, vwpatients.birthdate, vwpatients.age_numeric, vwpatients.age_display FROM vwprogressnotes, contacts.vwpatients WHERE (vwprogressnotes.fk_patient = vwpatients.fk_patient) ORDER BY vwprogressnotes.consult_date;


ALTER TABLE clin_consult.vwpatientconsults OWNER TO easygp;

--
-- Name: vwprogressnotes1; Type: VIEW; Schema: clin_consult; Owner: easygp
--

CREATE VIEW vwprogressnotes1 AS
    SELECT "CONSULT".fk_patient, progressnotes.pk AS pk_progressnote, "CONSULT".consult_date, "CONSULT_TYPE".type AS consult_type, "SECTION".section, progressnotes.problem, progressnotes.notes, "CONSULT".summary, progressnotes.fk_consult, progressnotes.fk_section, progressnotes.fk_code, progressnotes.fk_problem, progressnotes.fk_audit_action, progressnotes.deleted, "CONSULT".fk_staff, "CONSULT".fk_type, data_persons.firstname, data_persons.surname, lu_title.title, lu_audit_actions.action AS audit_action, progressnotes.linked_table, progressnotes.fk_audit_reason, lu_audit_reasons.reason AS audit_reason, progressnotes.fk_row, lu_audit_actions.insist_reason, lu_staff_roles.role FROM (((((((((consult "CONSULT" LEFT JOIN lu_consult_type "CONSULT_TYPE" ON (("CONSULT".fk_type = "CONSULT_TYPE".pk))) JOIN admin.staff ON (("CONSULT".fk_staff = staff.pk))) JOIN contacts.data_persons ON ((staff.fk_person = data_persons.pk))) JOIN contacts.lu_title ON ((data_persons.fk_title = lu_title.pk))) JOIN progressnotes ON (("CONSULT".pk = progressnotes.fk_consult))) JOIN lu_progressnotes_sections "SECTION" ON ((progressnotes.fk_section = "SECTION".pk))) JOIN lu_audit_actions ON ((progressnotes.fk_audit_action = lu_audit_actions.pk))) JOIN admin.lu_staff_roles ON ((staff.fk_role = lu_staff_roles.pk))) LEFT JOIN lu_audit_reasons ON ((progressnotes.fk_audit_reason = lu_audit_reasons.pk))) WHERE ("CONSULT_TYPE".pk < 10) ORDER BY "CONSULT".fk_patient, "CONSULT".consult_date, "CONSULT".fk_staff, "SECTION".pk, progressnotes.fk_problem;


ALTER TABLE clin_consult.vwprogressnotes1 OWNER TO easygp;

--
-- Name: vwscratchpad; Type: VIEW; Schema: clin_consult; Owner: easygp
--

CREATE VIEW vwscratchpad AS
    SELECT consult.fk_patient, scratchpad.pk AS pk_scratchpad, scratchpad.fk_consult, scratchpad.note, consult.consult_date, consult.fk_staff, lu_title.title, data_persons.firstname, data_persons.surname, ((data_persons.firstname || ' '::text) || data_persons.surname) AS wholename, scratchpad.deleted, scratchpad.fk_lu_status AS fk_status, scratchpad.fk_progressnote FROM ((((scratchpad JOIN consult ON ((scratchpad.fk_consult = consult.pk))) JOIN admin.staff ON ((consult.fk_staff = staff.pk))) JOIN contacts.data_persons ON ((staff.fk_person = data_persons.pk))) LEFT JOIN contacts.lu_title ON ((data_persons.fk_title = lu_title.pk))) ORDER BY consult.fk_patient, consult.consult_date;


ALTER TABLE clin_consult.vwscratchpad OWNER TO easygp;

SET search_path = clin_history, pg_catalog;

--
-- Name: care_plan_components; Type: TABLE; Schema: clin_history; Owner: easygp; Tablespace: 
--

CREATE TABLE care_plan_components (
    pk integer NOT NULL,
    fk_pasthistory integer NOT NULL,
    component text NOT NULL,
    due date NOT NULL,
    fk_recall integer
);


ALTER TABLE clin_history.care_plan_components OWNER TO easygp;

--
-- Name: TABLE care_plan_components; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON TABLE care_plan_components IS 'links a health issue - fk_pasthistory - to a component of care and when it is due.
 There is some duplication in this table:
 - many  ''components'' of a care plan are the same as reasons for a recall eg hba1c, or diabetic annual cycle of care
   and most we will want to automatically recall, hence for the moment I''ve used clin_recalls.lu_reasons to be the components name.
 -  if fk_recall is not null then there is a recall linked to this component.
 -  As each fk_pasthistory is unique to a patient and not re-used, 
    this key identifies the patient or visa-versa - i.e the patient''s past history item or health issue identifies its care plan components.';


--
-- Name: COLUMN care_plan_components.fk_pasthistory; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN care_plan_components.fk_pasthistory IS 'foreign key references clin_history.past_history.pk';


--
-- Name: COLUMN care_plan_components.component; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN care_plan_components.component IS 'the component e.g weight opportunistically, in theory can be null, i''ve left this as not null for time being';


--
-- Name: COLUMN care_plan_components.due; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN care_plan_components.due IS 'date the comment is due to be done';


--
-- Name: COLUMN care_plan_components.fk_recall; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN care_plan_components.fk_recall IS 'if not null, then is the key to clin_recalls.recalls table';


--
-- Name: care_plan_components_due; Type: TABLE; Schema: clin_history; Owner: easygp; Tablespace: 
--

CREATE TABLE care_plan_components_due (
    pk integer NOT NULL,
    fk_pasthistory integer NOT NULL,
    fk_component integer NOT NULL,
    due date
);


ALTER TABLE clin_history.care_plan_components_due OWNER TO easygp;

--
-- Name: TABLE care_plan_components_due; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON TABLE care_plan_components_due IS 'links a health issue - fk_pasthistory - to a component of care and when it is due. As each fk_pasthistory is unique to a patient and not re-used, this key identifies the patient or visa-versa - i.e the patient''s past history item or health issue identifies its care plan components.';


--
-- Name: COLUMN care_plan_components_due.fk_pasthistory; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN care_plan_components_due.fk_pasthistory IS 'foreign key references clin_history.past_history.pk';


--
-- Name: COLUMN care_plan_components_due.fk_component; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN care_plan_components_due.fk_component IS 'foreign key references clin_history.care_plan_components.pk';


--
-- Name: COLUMN care_plan_components_due.due; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN care_plan_components_due.due IS 'date the comment is due to be done';


--
-- Name: care_plan_components_due_pk_seq; Type: SEQUENCE; Schema: clin_history; Owner: easygp
--

CREATE SEQUENCE care_plan_components_due_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_history.care_plan_components_due_pk_seq OWNER TO easygp;

--
-- Name: care_plan_components_due_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_history; Owner: easygp
--

ALTER SEQUENCE care_plan_components_due_pk_seq OWNED BY care_plan_components_due.pk;


--
-- Name: care_plan_components_pk_seq; Type: SEQUENCE; Schema: clin_history; Owner: easygp
--

CREATE SEQUENCE care_plan_components_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_history.care_plan_components_pk_seq OWNER TO easygp;

--
-- Name: care_plan_components_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_history; Owner: easygp
--

ALTER SEQUENCE care_plan_components_pk_seq OWNED BY care_plan_components.pk;


--
-- Name: family_conditions; Type: TABLE; Schema: clin_history; Owner: easygp; Tablespace: 
--

CREATE TABLE family_conditions (
    pk integer NOT NULL,
    fk_member integer NOT NULL,
    condition text NOT NULL,
    age_of_onset integer,
    cause_of_death boolean DEFAULT false,
    notes text,
    deleted boolean DEFAULT false,
    fk_consult integer,
    contributed_to_death boolean,
    fk_code text,
    diagnosis_certain boolean DEFAULT true
);


ALTER TABLE clin_history.family_conditions OWNER TO easygp;

--
-- Name: COLUMN family_conditions.condition; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN family_conditions.condition IS 'note: the condition may NEVER exist in the coded database, 
 so it must be stored here. fk_code will only exist if it is a coded reason';


--
-- Name: COLUMN family_conditions.fk_code; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN family_conditions.fk_code IS 'foreign key to coding.generic_terms table. Note this key is a text string
 and will either be an icpc key or an icd10 key';


--
-- Name: family_conditions_pk_seq; Type: SEQUENCE; Schema: clin_history; Owner: easygp
--

CREATE SEQUENCE family_conditions_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_history.family_conditions_pk_seq OWNER TO easygp;

--
-- Name: family_conditions_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_history; Owner: easygp
--

ALTER SEQUENCE family_conditions_pk_seq OWNED BY family_conditions.pk;


--
-- Name: family_links; Type: TABLE; Schema: clin_history; Owner: easygp; Tablespace: 
--

CREATE TABLE family_links (
    pk integer NOT NULL,
    fk_member integer NOT NULL,
    fk_patient integer NOT NULL,
    deleted boolean DEFAULT false
);


ALTER TABLE clin_history.family_links OWNER TO easygp;

--
-- Name: family_links_pk_seq; Type: SEQUENCE; Schema: clin_history; Owner: easygp
--

CREATE SEQUENCE family_links_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_history.family_links_pk_seq OWNER TO easygp;

--
-- Name: family_links_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_history; Owner: easygp
--

ALTER SEQUENCE family_links_pk_seq OWNED BY family_links.pk;


--
-- Name: family_members; Type: TABLE; Schema: clin_history; Owner: easygp; Tablespace: 
--

CREATE TABLE family_members (
    pk integer NOT NULL,
    fk_relationship integer NOT NULL,
    fk_person integer,
    name text,
    birthdate date,
    age_of_death integer,
    fk_occupation integer,
    fk_country_birth character(2),
    deleted boolean DEFAULT false,
    fk_consult integer
);


ALTER TABLE clin_history.family_members OWNER TO easygp;

--
-- Name: COLUMN family_members.fk_person; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN family_members.fk_person IS 'I put this in in-case it was needed if we had imported family history from an person who exists in the easygp database.';


--
-- Name: family_members_pk_seq; Type: SEQUENCE; Schema: clin_history; Owner: easygp
--

CREATE SEQUENCE family_members_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_history.family_members_pk_seq OWNER TO easygp;

--
-- Name: family_members_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_history; Owner: easygp
--

ALTER SEQUENCE family_members_pk_seq OWNED BY family_members.pk;


--
-- Name: hospitalisations; Type: TABLE; Schema: clin_history; Owner: easygp; Tablespace: 
--

CREATE TABLE hospitalisations (
    pk integer NOT NULL,
    admission_date date,
    discharge_date date,
    pk_person integer,
    specialist_name text,
    diagnosis text
);


ALTER TABLE clin_history.hospitalisations OWNER TO easygp;

--
-- Name: TABLE hospitalisations; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON TABLE hospitalisations IS 'if specialist exists in contacts use pk_person';


--
-- Name: hospitalisations_pk_seq; Type: SEQUENCE; Schema: clin_history; Owner: easygp
--

CREATE SEQUENCE hospitalisations_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_history.hospitalisations_pk_seq OWNER TO easygp;

--
-- Name: hospitalisations_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_history; Owner: easygp
--

ALTER SEQUENCE hospitalisations_pk_seq OWNED BY hospitalisations.pk;


--
-- Name: lu_careplan_components; Type: TABLE; Schema: clin_history; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_careplan_components (
    pk integer NOT NULL,
    component text NOT NULL
);


ALTER TABLE clin_history.lu_careplan_components OWNER TO easygp;

--
-- Name: TABLE lu_careplan_components; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON TABLE lu_careplan_components IS 'table containing all the components available for care planning';


--
-- Name: COLUMN lu_careplan_components.component; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN lu_careplan_components.component IS 'a component of a care plan e.g HBA1c or visit opthalmologist';


--
-- Name: lu_careplan_components_pk_seq; Type: SEQUENCE; Schema: clin_history; Owner: easygp
--

CREATE SEQUENCE lu_careplan_components_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_history.lu_careplan_components_pk_seq OWNER TO easygp;

--
-- Name: lu_careplan_components_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_history; Owner: easygp
--

ALTER SEQUENCE lu_careplan_components_pk_seq OWNED BY lu_careplan_components.pk;


--
-- Name: lu_dacc_components; Type: TABLE; Schema: clin_history; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_dacc_components (
    pk integer NOT NULL,
    fk_component integer NOT NULL
);


ALTER TABLE clin_history.lu_dacc_components OWNER TO easygp;

--
-- Name: TABLE lu_dacc_components; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON TABLE lu_dacc_components IS 'Specific to Australian Government requirements for billing care of diabetics is the so 
  called Diabetic Annual Cycle of Care (DACC). This table keeps linkages to the 
  lu_careplan_components table for those components needed
  This table is purely to enable quick pulling in of DACC for the health issues section';


--
-- Name: COLUMN lu_dacc_components.fk_component; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN lu_dacc_components.fk_component IS 'key to clin_history.lu_careplan_components table';


--
-- Name: lu_dacc_components_pk_seq; Type: SEQUENCE; Schema: clin_history; Owner: easygp
--

CREATE SEQUENCE lu_dacc_components_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_history.lu_dacc_components_pk_seq OWNER TO easygp;

--
-- Name: lu_dacc_components_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_history; Owner: easygp
--

ALTER SEQUENCE lu_dacc_components_pk_seq OWNED BY lu_dacc_components.pk;


--
-- Name: lu_exposures; Type: TABLE; Schema: clin_history; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_exposures (
    pk integer NOT NULL,
    exposure text NOT NULL,
    fk_decision_support integer,
    deleted boolean
);


ALTER TABLE clin_history.lu_exposures OWNER TO easygp;

--
-- Name: TABLE lu_exposures; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON TABLE lu_exposures IS 'lookup table for things the person may be exposed to in the workplace e.g "stress", or "asbestos"';


--
-- Name: COLUMN lu_exposures.fk_decision_support; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN lu_exposures.fk_decision_support IS '
 foriegn key to decision support table, wherever and whenever that exists';


--
-- Name: lu_exposures_pk_seq; Type: SEQUENCE; Schema: clin_history; Owner: easygp
--

CREATE SEQUENCE lu_exposures_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_history.lu_exposures_pk_seq OWNER TO easygp;

--
-- Name: lu_exposures_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_history; Owner: easygp
--

ALTER SEQUENCE lu_exposures_pk_seq OWNED BY lu_exposures.pk;


--
-- Name: occupational_history; Type: TABLE; Schema: clin_history; Owner: easygp; Tablespace: 
--

CREATE TABLE occupational_history (
    pk integer NOT NULL,
    fk_consult integer NOT NULL,
    fk_occupation integer NOT NULL,
    from_age integer,
    to_age integer,
    current boolean DEFAULT false,
    retired boolean DEFAULT false,
    notes_occupation text,
    deleted boolean DEFAULT false,
    fk_progressnote integer
);


ALTER TABLE clin_history.occupational_history OWNER TO easygp;

--
-- Name: TABLE occupational_history; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON TABLE occupational_history IS 'data table for a patients occupational history
  note that any work place exposures for this occupation must be
  retrieved via the occupation_exposure_links table';


--
-- Name: COLUMN occupational_history.fk_occupation; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN occupational_history.fk_occupation IS 'foreign key to common.lu_occupations';


--
-- Name: COLUMN occupational_history.from_age; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN occupational_history.from_age IS 'age person started working in this occupation, can be null, measured in years
  note:potential problem here as now cannot calculate duration of exposure
  so this is kept in the link_occupation_exposure table';


--
-- Name: COLUMN occupational_history.current; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN occupational_history.current IS 'if true this is the patients current occupation';


--
-- Name: COLUMN occupational_history.retired; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN occupational_history.retired IS 'if true then the patient is retired with this as last occupation';


--
-- Name: COLUMN occupational_history.notes_occupation; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN occupational_history.notes_occupation IS 'notes about either the occupation or further comment on exposure risks';


--
-- Name: COLUMN occupational_history.fk_progressnote; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN occupational_history.fk_progressnote IS 'key to clin_consult.progressnotes points to the last progress note for this occupation';


--
-- Name: occupational_history_pk_seq; Type: SEQUENCE; Schema: clin_history; Owner: easygp
--

CREATE SEQUENCE occupational_history_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_history.occupational_history_pk_seq OWNER TO easygp;

--
-- Name: occupational_history_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_history; Owner: easygp
--

ALTER SEQUENCE occupational_history_pk_seq OWNED BY occupational_history.pk;


--
-- Name: occupations_exposures; Type: TABLE; Schema: clin_history; Owner: easygp; Tablespace: 
--

CREATE TABLE occupations_exposures (
    pk integer NOT NULL,
    fk_occupational_history integer NOT NULL,
    fk_exposure integer NOT NULL,
    exposure_duration integer,
    exposure_duration_units integer,
    deleted boolean DEFAULT false,
    notes_exposure text
);


ALTER TABLE clin_history.occupations_exposures OWNER TO easygp;

--
-- Name: TABLE occupations_exposures; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON TABLE occupations_exposures IS 'links table for one to many links of substances person exposed to in their occupation';


--
-- Name: COLUMN occupations_exposures.fk_occupational_history; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN occupations_exposures.fk_occupational_history IS 'foreign key to clin_history.occupational_history';


--
-- Name: COLUMN occupations_exposures.fk_exposure; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN occupations_exposures.fk_exposure IS 'foreign key to clin_history.lu_exposures';


--
-- Name: COLUMN occupations_exposures.exposure_duration; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN occupations_exposures.exposure_duration IS 'length of time exposed';


--
-- Name: COLUMN occupations_exposures.exposure_duration_units; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN occupations_exposures.exposure_duration_units IS 'foreign key to common.lu_units table
  e.g 6 = month, 7 = year';


--
-- Name: occupations_exposures_pk_seq; Type: SEQUENCE; Schema: clin_history; Owner: easygp
--

CREATE SEQUENCE occupations_exposures_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_history.occupations_exposures_pk_seq OWNER TO easygp;

--
-- Name: occupations_exposures_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_history; Owner: easygp
--

ALTER SEQUENCE occupations_exposures_pk_seq OWNED BY occupations_exposures.pk;


--
-- Name: past_history; Type: TABLE; Schema: clin_history; Owner: easygp; Tablespace: 
--

CREATE TABLE past_history (
    pk integer NOT NULL,
    fk_consult integer NOT NULL,
    age_onset integer NOT NULL,
    age_onset_units integer NOT NULL,
    description text NOT NULL,
    fk_laterality integer DEFAULT 0,
    year_onset text NOT NULL,
    active boolean DEFAULT false,
    operation boolean DEFAULT false,
    cause_of_death boolean DEFAULT false,
    confidential boolean DEFAULT false,
    major boolean DEFAULT false,
    deleted boolean DEFAULT false,
    year_onset_uncertain boolean DEFAULT false,
    management_summary text DEFAULT ''::text,
    condition_summary text DEFAULT ''::text,
    risk_factor boolean DEFAULT false,
    fk_coding_system integer NOT NULL,
    fk_code text,
    aim_of_plan text,
    fk_progressnote integer
);


ALTER TABLE clin_history.past_history OWNER TO easygp;

--
-- Name: COLUMN past_history.fk_coding_system; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN past_history.fk_coding_system IS 'key to coding.lu_coding_system containing name of coding system 
  that this health issue is linked to';


--
-- Name: COLUMN past_history.fk_progressnote; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN past_history.fk_progressnote IS 'foreign key to clin_consult.progressnotes table, used only during each consultation
 if changes made to this past history item, an entry is put in the progress notes, so
 if changed, but then edited again in same consultation it overwrites the original note';


--
-- Name: past_history_pk_seq; Type: SEQUENCE; Schema: clin_history; Owner: easygp
--

CREATE SEQUENCE past_history_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_history.past_history_pk_seq OWNER TO easygp;

--
-- Name: past_history_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_history; Owner: easygp
--

ALTER SEQUENCE past_history_pk_seq OWNED BY past_history.pk;


--
-- Name: pk_view_familyhistory; Type: SEQUENCE; Schema: clin_history; Owner: easygp
--

CREATE SEQUENCE pk_view_familyhistory
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_history.pk_view_familyhistory OWNER TO easygp;

--
-- Name: recreational_drugs; Type: TABLE; Schema: clin_history; Owner: easygp; Tablespace: 
--

CREATE TABLE recreational_drugs (
    pk integer NOT NULL,
    fk_consult integer NOT NULL,
    fk_lu_recreational_drug integer NOT NULL,
    age_started integer,
    age_last_used integer,
    substance_amount integer,
    fk_lu_substance_amount_units integer,
    fk_lu_substance_frequency integer,
    fk_lu_route_administration integer,
    cumulative_amount integer,
    never_used_drug boolean DEFAULT false,
    notes text,
    deleted boolean DEFAULT false
);


ALTER TABLE clin_history.recreational_drugs OWNER TO easygp;

--
-- Name: TABLE recreational_drugs; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON TABLE recreational_drugs IS 'A list of the patient''s recreational drug use
 - note it is not possible to be absolutely precise about age started/stopped drugs a use can start stop, so comments should be added to the notes field';


--
-- Name: COLUMN recreational_drugs.fk_lu_recreational_drug; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN recreational_drugs.fk_lu_recreational_drug IS 'foreign key to common.lu_recreational_drugs';


--
-- Name: COLUMN recreational_drugs.age_started; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN recreational_drugs.age_started IS 'the age the patient first used this drug';


--
-- Name: COLUMN recreational_drugs.age_last_used; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN recreational_drugs.age_last_used IS 'the age the patient last used or stopped using the drug';


--
-- Name: COLUMN recreational_drugs.substance_amount; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN recreational_drugs.substance_amount IS 'the quantity of the substance e.g 10 if say 10gm of alcohol per day see lu_substance_frequency';


--
-- Name: COLUMN recreational_drugs.fk_lu_substance_amount_units; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN recreational_drugs.fk_lu_substance_amount_units IS 'the units for the substance amount eg gm key to common.lu_units (to be restricted in the front end';


--
-- Name: COLUMN recreational_drugs.fk_lu_substance_frequency; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN recreational_drugs.fk_lu_substance_frequency IS 'foreign key to common.lu_units but front end will allow on day/week/month/year';


--
-- Name: COLUMN recreational_drugs.fk_lu_route_administration; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN recreational_drugs.fk_lu_route_administration IS 'key to common.lu_route_administration';


--
-- Name: COLUMN recreational_drugs.cumulative_amount; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN recreational_drugs.cumulative_amount IS 'the cumulative amount of the drug meant more for  nicotine eg 25=25 pack years';


--
-- Name: COLUMN recreational_drugs.never_used_drug; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN recreational_drugs.never_used_drug IS 'this apparently useless column is because we have to record if say smoker is non-smoker or non- drinker, just have empty start_age end_age is not good enough';


--
-- Name: COLUMN recreational_drugs.notes; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN recreational_drugs.notes IS 'any qualifying information about the drug eg, ''used intermittently 20-30, stopped in 30''s, started again in 40''s';


--
-- Name: recreational_drugs_pk_seq; Type: SEQUENCE; Schema: clin_history; Owner: easygp
--

CREATE SEQUENCE recreational_drugs_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_history.recreational_drugs_pk_seq OWNER TO easygp;

--
-- Name: recreational_drugs_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_history; Owner: easygp
--

ALTER SEQUENCE recreational_drugs_pk_seq OWNED BY recreational_drugs.pk;


--
-- Name: social_history; Type: TABLE; Schema: clin_history; Owner: easygp; Tablespace: 
--

CREATE TABLE social_history (
    pk integer NOT NULL,
    fk_consult integer NOT NULL,
    history text,
    deleted boolean DEFAULT false,
    fk_responsible_person integer,
    responsible_person text,
    responsible_person_street1 text,
    responsible_person_street2 text,
    responsible_person_town text,
    responsible_person_postcode text,
    responsible_person_state text,
    responsible_person_contacts text,
    responsible_person_notes text,
    country_code text
);


ALTER TABLE clin_history.social_history OWNER TO easygp;

--
-- Name: TABLE social_history; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON TABLE social_history IS 'keeps patient social history and contact for responsible person, the address is hard_coded to allow for oversea''s addresses
 if fk_person is not null the address fields will not be filled, but retrieved in the view from contacts';


--
-- Name: COLUMN social_history.fk_responsible_person; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN social_history.fk_responsible_person IS 'if not null this is the key to  clerical.data_persons table';


--
-- Name: COLUMN social_history.responsible_person; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN social_history.responsible_person IS 'if not null and fk_patient is null then this is used as name as responsible person';


--
-- Name: COLUMN social_history.responsible_person_street1; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN social_history.responsible_person_street1 IS 'if not null is the street of responsible person who is not in patients database';


--
-- Name: COLUMN social_history.responsible_person_street2; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN social_history.responsible_person_street2 IS 'if not null is the street2 of responsible person who is not in patients database';


--
-- Name: COLUMN social_history.responsible_person_town; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN social_history.responsible_person_town IS 'if not null is the fk_town of responsible person who is not in patients database';


--
-- Name: COLUMN social_history.responsible_person_contacts; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON COLUMN social_history.responsible_person_contacts IS 'one or more types of contact';


--
-- Name: social_history_pk_seq; Type: SEQUENCE; Schema: clin_history; Owner: easygp
--

CREATE SEQUENCE social_history_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_history.social_history_pk_seq OWNER TO easygp;

--
-- Name: social_history_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_history; Owner: easygp
--

ALTER SEQUENCE social_history_pk_seq OWNED BY social_history.pk;


--
-- Name: team_care_members; Type: TABLE; Schema: clin_history; Owner: easygp; Tablespace: 
--

CREATE TABLE team_care_members (
    pk integer NOT NULL,
    fk_pasthistory integer NOT NULL,
    fk_organisation integer,
    fk_branch integer,
    fk_employee integer,
    fk_person integer,
    deleted boolean DEFAULT false,
    responsibility text
);


ALTER TABLE clin_history.team_care_members OWNER TO easygp;

--
-- Name: TABLE team_care_members; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON TABLE team_care_members IS 'links a past history item to team care members
  keys are kept rather than names and addresses to allow automatic updating of the
  names and addresses on the care plan.';


--
-- Name: team_care_members_pk_seq; Type: SEQUENCE; Schema: clin_history; Owner: easygp
--

CREATE SEQUENCE team_care_members_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_history.team_care_members_pk_seq OWNER TO easygp;

--
-- Name: team_care_members_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_history; Owner: easygp
--

ALTER SEQUENCE team_care_members_pk_seq OWNED BY team_care_members.pk;


SET search_path = clin_recalls, pg_catalog;

--
-- Name: lu_reasons; Type: TABLE; Schema: clin_recalls; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_reasons (
    pk integer NOT NULL,
    reason text NOT NULL
);


ALTER TABLE clin_recalls.lu_reasons OWNER TO easygp;

--
-- Name: TABLE lu_reasons; Type: COMMENT; Schema: clin_recalls; Owner: easygp
--

COMMENT ON TABLE lu_reasons IS 'Keeps the reasons for the recall.
	Whilst these may equate to a code reason e.g colonoscopy
	they often will not e.g
	3rd Hepatitis B Injection
	May later want to link to coding system when we have one
  ';


--
-- Name: COLUMN lu_reasons.reason; Type: COMMENT; Schema: clin_recalls; Owner: easygp
--

COMMENT ON COLUMN lu_reasons.reason IS 'the reason for the recall';


--
-- Name: lu_recall_intervals; Type: TABLE; Schema: clin_recalls; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_recall_intervals (
    pk integer NOT NULL,
    fk_reason integer NOT NULL,
    fk_staff integer NOT NULL,
    "interval" integer NOT NULL,
    fk_interval_unit integer NOT NULL
);


ALTER TABLE clin_recalls.lu_recall_intervals OWNER TO easygp;

--
-- Name: TABLE lu_recall_intervals; Type: COMMENT; Schema: clin_recalls; Owner: easygp
--

COMMENT ON TABLE lu_recall_intervals IS 'Keeps list of intervals used on per-user basis to recall
  for things eg PAP 2yrs. Use this table to auto-insert dates
  for next recall due
  ';


--
-- Name: COLUMN lu_recall_intervals.fk_staff; Type: COMMENT; Schema: clin_recalls; Owner: easygp
--

COMMENT ON COLUMN lu_recall_intervals.fk_staff IS 'key to admin.staff table';


--
-- Name: COLUMN lu_recall_intervals."interval"; Type: COMMENT; Schema: clin_recalls; Owner: easygp
--

COMMENT ON COLUMN lu_recall_intervals."interval" IS 'the time interval for the recall 
    e.g 24 (if months) or 2 (if years)
    i.e the most ususal or common interval for this particular reason';


--
-- Name: COLUMN lu_recall_intervals.fk_interval_unit; Type: COMMENT; Schema: clin_recalls; Owner: easygp
--

COMMENT ON COLUMN lu_recall_intervals.fk_interval_unit IS 'key to common.lu_units table
   e.g a value of 6 = month';


--
-- Name: lu_templates; Type: TABLE; Schema: clin_recalls; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_templates (
    pk integer NOT NULL,
    name text NOT NULL,
    deleted boolean DEFAULT false,
    template text NOT NULL,
    fk_lu_appointment_length integer DEFAULT 1
);


ALTER TABLE clin_recalls.lu_templates OWNER TO easygp;

--
-- Name: TABLE lu_templates; Type: COMMENT; Schema: clin_recalls; Owner: easygp
--

COMMENT ON TABLE lu_templates IS 'Table to hold templates for recall letters';


--
-- Name: COLUMN lu_templates.template; Type: COMMENT; Schema: clin_recalls; Owner: easygp
--

COMMENT ON COLUMN lu_templates.template IS 'html for a letter template';


--
-- Name: COLUMN lu_templates.fk_lu_appointment_length; Type: COMMENT; Schema: clin_recalls; Owner: easygp
--

COMMENT ON COLUMN lu_templates.fk_lu_appointment_length IS 'key to common.lu_appointment_length, A Template for a recall must always have a default appointment length here a standard consult length=1';


--
-- Name: recalls; Type: TABLE; Schema: clin_recalls; Owner: easygp; Tablespace: 
--

CREATE TABLE recalls (
    pk integer NOT NULL,
    fk_consult integer NOT NULL,
    due date NOT NULL,
    fk_reason integer NOT NULL,
    fk_contact_method integer NOT NULL,
    fk_urgency integer NOT NULL,
    fk_appointment_length integer NOT NULL,
    fk_staff integer NOT NULL,
    fk_status integer DEFAULT 1 NOT NULL,
    additional_text text,
    deleted boolean DEFAULT false,
    "interval" integer,
    fk_interval_unit integer,
    fk_progressnote integer,
    fk_pasthistory integer,
    active boolean DEFAULT true,
    fk_template integer,
    fk_sent integer,
    num_reminders integer DEFAULT 0
);


ALTER TABLE clin_recalls.recalls OWNER TO easygp;

--
-- Name: TABLE recalls; Type: COMMENT; Schema: clin_recalls; Owner: easygp
--

COMMENT ON TABLE recalls IS 'The main recall table
 notes: the fk_reason is key to recalls.lu_reasons table within this schema
         currently no coded reason is kept
         Example of a reason would be 2nd Hepatitis B Injection, but we need to keep these
         for re-use for ease of typing.
      : Also God knows where the patient will be in 5 years time, so though we keep a default
        method of contacting them (fk_contact_method), this could change
      : Ditto with staff members, Dr Blogs may have moved on, so if he is recorded as the
        person to see and not present later on, will send appointment for anyone
        Also,may not be important who patient sees eg, bloods taken by the practice nurse
        so fk_staff could point to a generic staff member eg generic_nurse (FIXME NOT IMPLEMENTED)
      : note most foreign keys will have equivalents in module gvar
';


--
-- Name: COLUMN recalls.fk_consult; Type: COMMENT; Schema: clin_recalls; Owner: easygp
--

COMMENT ON COLUMN recalls.fk_consult IS 'key to clin_consult.consult table hence gives staff member, patient and date consult';


--
-- Name: COLUMN recalls.due; Type: COMMENT; Schema: clin_recalls; Owner: easygp
--

COMMENT ON COLUMN recalls.due IS 'date recall falls due';


--
-- Name: COLUMN recalls.fk_reason; Type: COMMENT; Schema: clin_recalls; Owner: easygp
--

COMMENT ON COLUMN recalls.fk_reason IS ' key to clin_recalls.lu.reasons tablet';


--
-- Name: COLUMN recalls.fk_contact_method; Type: COMMENT; Schema: clin_recalls; Owner: easygp
--

COMMENT ON COLUMN recalls.fk_contact_method IS 'key to contacts.lu_contact_method table';


--
-- Name: COLUMN recalls.fk_urgency; Type: COMMENT; Schema: clin_recalls; Owner: easygp
--

COMMENT ON COLUMN recalls.fk_urgency IS 'key to common.lu_urgency table eg 1 = routine
	 gvar.RecallUrgencyLevelRoutine';


--
-- Name: COLUMN recalls.fk_appointment_length; Type: COMMENT; Schema: clin_recalls; Owner: easygp
--

COMMENT ON COLUMN recalls.fk_appointment_length IS 'key to common.lu_appointment_length';


--
-- Name: COLUMN recalls.fk_staff; Type: COMMENT; Schema: clin_recalls; Owner: easygp
--

COMMENT ON COLUMN recalls.fk_staff IS 'key to clerical.staff table';


--
-- Name: COLUMN recalls.fk_status; Type: COMMENT; Schema: clin_recalls; Owner: easygp
--

COMMENT ON COLUMN recalls.fk_status IS 'key to lu_status table, ie things like not due, finalised, refused
     corresponds to e.g gvar.RecallNotDue constants
     this defaults to 1 = not due';


--
-- Name: COLUMN recalls.additional_text; Type: COMMENT; Schema: clin_recalls; Owner: easygp
--

COMMENT ON COLUMN recalls.additional_text IS 'Any additional text to accompany the letter
	 e.g  come fasting or bring your partner etc';


--
-- Name: COLUMN recalls.fk_progressnote; Type: COMMENT; Schema: clin_recalls; Owner: easygp
--

COMMENT ON COLUMN recalls.fk_progressnote IS 'the foreign key to clin_consult.progressnotes, kept so that if the recall is
 edited, then the progress note is modified with the edited value for the current consultation';


--
-- Name: COLUMN recalls.fk_pasthistory; Type: COMMENT; Schema: clin_recalls; Owner: easygp
--

COMMENT ON COLUMN recalls.fk_pasthistory IS 'if not null it is the health issue linked to this recall foreign key to clin_history.past_history';


--
-- Name: COLUMN recalls.active; Type: COMMENT; Schema: clin_recalls; Owner: easygp
--

COMMENT ON COLUMN recalls.active IS 'Whether the recall is active or not';


--
-- Name: COLUMN recalls.fk_template; Type: COMMENT; Schema: clin_recalls; Owner: easygp
--

COMMENT ON COLUMN recalls.fk_template IS 'If not null, then the template text will be included in the patients recalls';


--
-- Name: COLUMN recalls.fk_sent; Type: COMMENT; Schema: clin_recalls; Owner: easygp
--

COMMENT ON COLUMN recalls.fk_sent IS 'key to clin_recalls.sent table - gives info about when the last reminder was sent, who sent it
  the actual letter latex definition and how sent';


--
-- Name: COLUMN recalls.num_reminders; Type: COMMENT; Schema: clin_recalls; Owner: easygp
--

COMMENT ON COLUMN recalls.num_reminders IS 'the number of times the practice has attempted to deal with this reminder';


--
-- Name: sent; Type: TABLE; Schema: clin_recalls; Owner: easygp; Tablespace: 
--

CREATE TABLE sent (
    pk integer NOT NULL,
    fk_recall integer NOT NULL,
    date date NOT NULL,
    latex text NOT NULL,
    fk_contact_method integer NOT NULL,
    contact_value text,
    fk_staff integer,
    memo text
);


ALTER TABLE clin_recalls.sent OWNER TO easygp;

--
-- Name: TABLE sent; Type: COMMENT; Schema: clin_recalls; Owner: easygp
--

COMMENT ON TABLE sent IS 'Details of recalls sent out to remind the patient';


--
-- Name: COLUMN sent.fk_recall; Type: COMMENT; Schema: clin_recalls; Owner: easygp
--

COMMENT ON COLUMN sent.fk_recall IS 'key to clin_recalls.recall table';


--
-- Name: COLUMN sent.date; Type: COMMENT; Schema: clin_recalls; Owner: easygp
--

COMMENT ON COLUMN sent.date IS 'the date the reminder for the recall was processed';


--
-- Name: COLUMN sent.latex; Type: COMMENT; Schema: clin_recalls; Owner: easygp
--

COMMENT ON COLUMN sent.latex IS 'the latex definition of the recall reminder sent';


--
-- Name: COLUMN sent.fk_contact_method; Type: COMMENT; Schema: clin_recalls; Owner: easygp
--

COMMENT ON COLUMN sent.fk_contact_method IS 'key to contacts.lu_contact_type table e.g could point to letter/phone';


--
-- Name: COLUMN sent.contact_value; Type: COMMENT; Schema: clin_recalls; Owner: easygp
--

COMMENT ON COLUMN sent.contact_value IS 'if not null contact via this text eg mobile phone, voip, email';


--
-- Name: COLUMN sent.fk_staff; Type: COMMENT; Schema: clin_recalls; Owner: easygp
--

COMMENT ON COLUMN sent.fk_staff IS 'key to admin.staff table staff member who prepared the letter';


--
-- Name: COLUMN sent.memo; Type: COMMENT; Schema: clin_recalls; Owner: easygp
--

COMMENT ON COLUMN sent.memo IS 'memo added by staff at the time e.g could have called patient who said they would make appointment';


SET search_path = common, pg_catalog;

--
-- Name: lu_appointment_length_pk_seq; Type: SEQUENCE; Schema: common; Owner: easygp
--

CREATE SEQUENCE lu_appointment_length_pk_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    MAXVALUE 100
    CACHE 1;


ALTER TABLE common.lu_appointment_length_pk_seq OWNER TO easygp;

--
-- Name: lu_appointment_length; Type: TABLE; Schema: common; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_appointment_length (
    pk integer DEFAULT nextval('lu_appointment_length_pk_seq'::regclass) NOT NULL,
    length text NOT NULL
);


ALTER TABLE common.lu_appointment_length OWNER TO easygp;

--
-- Name: lu_units; Type: TABLE; Schema: common; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_units (
    pk integer NOT NULL,
    abbrev_text text NOT NULL,
    full_text text
);


ALTER TABLE common.lu_units OWNER TO easygp;

SET search_path = contacts, pg_catalog;

--
-- Name: lu_contact_type; Type: TABLE; Schema: contacts; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_contact_type (
    pk integer NOT NULL,
    type text
);


ALTER TABLE contacts.lu_contact_type OWNER TO easygp;

SET search_path = clin_recalls, pg_catalog;

--
-- Name: vwrecalls; Type: VIEW; Schema: clin_recalls; Owner: easygp
--

CREATE VIEW vwrecalls AS
    SELECT consult.fk_patient, consult.consult_date, lu_reasons.reason, recalls.due, lu_urgency.urgency, lu_contact_type.type AS contact_by, lu_appointment_length.length, lu_title.title, ((data_persons.firstname || ' '::text) || data_persons.surname) AS wholename, recalls.fk_consult, recalls.pk AS pk_recall, recalls.fk_reason, recalls.fk_contact_method, recalls.fk_urgency, recalls.fk_appointment_length, recalls.fk_staff, recalls.active, recalls."interval", lu_units.abbrev_text, recalls.fk_interval_unit, recalls.additional_text, recalls.deleted, recalls.fk_pasthistory, recalls.fk_progressnote, recalls.fk_template, recalls.fk_sent, recalls.num_reminders, data_persons.firstname, data_persons.surname, data_persons.fk_title, lu_contact_type.pk AS fk_contact_by, lu_recall_intervals."interval" AS default_interval, lu_recall_intervals.fk_interval_unit AS fk_default_interval_unit, lu_templates.name AS template_name, lu_templates.template, lu_templates.fk_lu_appointment_length AS template_fk_lu_appointment_length, lu_appointment_length1.length AS template_appointment_length, sent.latex FROM (((((((((((((recalls JOIN lu_recall_intervals ON ((recalls.fk_reason = lu_recall_intervals.fk_reason))) JOIN clin_consult.consult ON ((recalls.fk_consult = consult.pk))) JOIN lu_reasons ON ((recalls.fk_reason = lu_reasons.pk))) JOIN contacts.lu_contact_type ON ((recalls.fk_contact_method = lu_contact_type.pk))) JOIN admin.staff ON ((consult.fk_staff = staff.pk))) LEFT JOIN lu_templates ON ((recalls.fk_template = lu_templates.pk))) LEFT JOIN contacts.data_persons ON ((staff.fk_person = data_persons.pk))) LEFT JOIN contacts.lu_title ON ((data_persons.fk_title = lu_title.pk))) JOIN common.lu_urgency ON ((recalls.fk_urgency = lu_urgency.pk))) LEFT JOIN common.lu_appointment_length ON ((recalls.fk_appointment_length = lu_appointment_length.pk))) LEFT JOIN common.lu_appointment_length lu_appointment_length1 ON ((lu_templates.fk_lu_appointment_length = lu_appointment_length1.pk))) LEFT JOIN common.lu_units ON ((recalls.fk_interval_unit = lu_units.pk))) LEFT JOIN sent ON ((recalls.fk_sent = sent.pk))) ORDER BY consult.fk_patient, recalls.due;


ALTER TABLE clin_recalls.vwrecalls OWNER TO easygp;

SET search_path = clin_history, pg_catalog;

--
-- Name: vwcareplancomponents; Type: VIEW; Schema: clin_history; Owner: easygp
--

CREATE VIEW vwcareplancomponents AS
    SELECT care_plan_components.fk_pasthistory, care_plan_components.component, care_plan_components.pk AS pk_careplan_components, care_plan_components.due, care_plan_components.fk_recall, vwrecalls.fk_staff, vwrecalls."interval", vwrecalls.reason, vwrecalls.fk_reason, vwrecalls.fk_interval_unit, vwrecalls.default_interval, vwrecalls.fk_default_interval_unit, vwrecalls.fk_contact_by, vwrecalls.abbrev_text FROM (care_plan_components LEFT JOIN clin_recalls.vwrecalls ON ((care_plan_components.fk_recall = vwrecalls.pk_recall))) ORDER BY care_plan_components.fk_pasthistory, care_plan_components.due;


ALTER TABLE clin_history.vwcareplancomponents OWNER TO easygp;

--
-- Name: vwcareplancomponentsdue; Type: VIEW; Schema: clin_history; Owner: easygp
--

CREATE VIEW vwcareplancomponentsdue AS
    SELECT care_plan_components_due.fk_pasthistory, lu_careplan_components.component, care_plan_components_due.fk_component, care_plan_components_due.pk AS pk_careplan_components_due, care_plan_components_due.due FROM (care_plan_components_due JOIN lu_careplan_components ON ((care_plan_components_due.fk_component = lu_careplan_components.pk))) ORDER BY care_plan_components_due.fk_pasthistory, care_plan_components_due.due;


ALTER TABLE clin_history.vwcareplancomponentsdue OWNER TO easygp;

SET search_path = common, pg_catalog;

--
-- Name: lu_family_relationships; Type: TABLE; Schema: common; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_family_relationships (
    pk integer NOT NULL,
    relationship text NOT NULL
);


ALTER TABLE common.lu_family_relationships OWNER TO easygp;

SET search_path = clin_history, pg_catalog;

--
-- Name: vwfamilyhistory; Type: VIEW; Schema: clin_history; Owner: easygp
--

CREATE VIEW vwfamilyhistory AS
    SELECT family_conditions.pk AS pk_view, family_links.fk_member, family_members.fk_consult AS fk_consult_familymember, family_members.fk_relationship, family_members.fk_person, family_members.name, family_members.birthdate, family_members.age_of_death, family_members.fk_occupation, family_members.fk_country_birth, family_members.deleted AS member_deleted, family_links.fk_patient, family_links.pk AS fk_link, family_conditions.pk AS fk_condition, family_conditions.condition, family_conditions.diagnosis_certain, family_conditions.fk_consult AS fk_consult_condition, family_conditions.fk_code, family_conditions.age_of_onset, family_conditions.cause_of_death, family_conditions.notes, family_conditions.deleted AS condition_deleted, family_conditions.contributed_to_death, lu_countries.country, lu_occupations.occupation, lu_family_relationships.relationship, family_links.deleted AS link_deleted, generic_terms.code, generic_terms.term FROM (((((((family_links LEFT JOIN clerical.data_patients ON ((family_links.fk_patient = data_patients.pk))) JOIN family_members ON ((family_links.fk_member = family_members.pk))) JOIN family_conditions ON ((family_links.fk_member = family_conditions.fk_member))) LEFT JOIN common.lu_countries ON ((family_members.fk_country_birth = lu_countries.country_code))) LEFT JOIN common.lu_occupations ON ((family_members.fk_occupation = lu_occupations.pk))) JOIN common.lu_family_relationships ON ((family_members.fk_relationship = lu_family_relationships.pk))) LEFT JOIN coding.generic_terms ON ((family_conditions.fk_code = generic_terms.code))) WHERE ((family_members.deleted = false) AND (family_conditions.deleted = false)) ORDER BY family_links.fk_patient, family_links.fk_member;


ALTER TABLE clin_history.vwfamilyhistory OWNER TO easygp;

SET search_path = common, pg_catalog;

--
-- Name: lu_laterality; Type: TABLE; Schema: common; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_laterality (
    pk integer NOT NULL,
    laterality text NOT NULL
);


ALTER TABLE common.lu_laterality OWNER TO easygp;

SET search_path = clin_history, pg_catalog;

--
-- Name: vwhealthissues; Type: VIEW; Schema: clin_history; Owner: easygp
--

CREATE VIEW vwhealthissues AS
    SELECT consult.fk_patient, past_history.pk AS pk_pasthistory, past_history.age_onset, past_history.age_onset_units, past_history.description, past_history.fk_laterality, past_history.year_onset, past_history.active, past_history.operation, past_history.cause_of_death, past_history.confidential, past_history.major, past_history.deleted, past_history.year_onset_uncertain, past_history.management_summary, past_history.condition_summary, past_history.aim_of_plan, past_history.risk_factor, past_history.fk_coding_system, past_history.fk_code, past_history.fk_progressnote, lu_systems.system, generic_terms.term, (((generic_terms.term || ' ('::text) || generic_terms.code) || ')'::text) AS combined_term_code, generic_terms.active AS code_active, consult.pk AS fk_consult, consult.fk_staff, consult.consult_date AS date_noted, data_persons.firstname AS staff_firstname, data_persons.surname AS staff_surname, lu_title.title AS staff_title FROM (((((((past_history JOIN clin_consult.consult ON ((past_history.fk_consult = consult.pk))) LEFT JOIN common.lu_laterality ON ((past_history.fk_laterality = lu_laterality.pk))) LEFT JOIN coding.lu_systems ON ((past_history.fk_coding_system = lu_systems.pk))) LEFT JOIN coding.generic_terms ON ((past_history.fk_code = generic_terms.code))) JOIN admin.staff ON ((consult.fk_staff = staff.pk))) JOIN contacts.data_persons ON ((staff.fk_person = data_persons.pk))) LEFT JOIN contacts.lu_title ON ((data_persons.fk_title = lu_title.pk))) WHERE (past_history.deleted = false) ORDER BY consult.fk_patient;


ALTER TABLE clin_history.vwhealthissues OWNER TO easygp;

--
-- Name: vwoccupationalhistory; Type: VIEW; Schema: clin_history; Owner: easygp
--

CREATE VIEW vwoccupationalhistory AS
    SELECT CASE WHEN (occupations_exposures.pk IS NULL) THEN (occupational_history.pk || '-0'::text) ELSE ((occupational_history.pk || '-'::text) || occupations_exposures.pk) END AS pk_view, occupational_history.pk AS fk_occupational_history, occupational_history.fk_consult, occupational_history.fk_occupation, occupational_history.from_age, occupational_history.to_age, occupational_history.current, occupational_history.retired, occupational_history.notes_occupation, occupational_history.deleted AS occupational_history_deleted, occupational_history.fk_progressnote, consult.consult_date, consult.fk_patient, lu_occupations.occupation, occupations_exposures.pk AS fk_occupations_exposures, occupations_exposures.fk_exposure, occupations_exposures.exposure_duration, occupations_exposures.exposure_duration_units, occupations_exposures.notes_exposure, lu_exposures.exposure, lu_exposures.fk_decision_support, occupations_exposures.deleted AS exposure_deleted, lu_units.abbrev_text FROM (((((occupational_history JOIN clin_consult.consult ON ((occupational_history.fk_consult = consult.pk))) JOIN common.lu_occupations ON ((occupational_history.fk_occupation = lu_occupations.pk))) LEFT JOIN occupations_exposures ON ((occupational_history.pk = occupations_exposures.fk_occupational_history))) LEFT JOIN lu_exposures ON ((occupations_exposures.fk_exposure = lu_exposures.pk))) LEFT JOIN common.lu_units ON ((occupations_exposures.exposure_duration_units = lu_units.pk)));


ALTER TABLE clin_history.vwoccupationalhistory OWNER TO easygp;

SET search_path = common, pg_catalog;

--
-- Name: lu_recreational_drugs; Type: TABLE; Schema: common; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_recreational_drugs (
    pk integer NOT NULL,
    drug text NOT NULL,
    alternative_names text,
    default_fk_lu_route_administration integer NOT NULL,
    quantification text,
    illicit boolean DEFAULT true NOT NULL
);


ALTER TABLE common.lu_recreational_drugs OWNER TO easygp;

--
-- Name: TABLE lu_recreational_drugs; Type: COMMENT; Schema: common; Owner: easygp
--

COMMENT ON TABLE lu_recreational_drugs IS 'A list of common recreational drugs';


--
-- Name: COLUMN lu_recreational_drugs.alternative_names; Type: COMMENT; Schema: common; Owner: easygp
--

COMMENT ON COLUMN lu_recreational_drugs.alternative_names IS 'a space-separated list of alternative names or subtypes';


--
-- Name: COLUMN lu_recreational_drugs.quantification; Type: COMMENT; Schema: common; Owner: easygp
--

COMMENT ON COLUMN lu_recreational_drugs.quantification IS 'how to quantify eg cig/day or gm/day';


--
-- Name: COLUMN lu_recreational_drugs.illicit; Type: COMMENT; Schema: common; Owner: easygp
--

COMMENT ON COLUMN lu_recreational_drugs.illicit IS 'true if illegal to use recreationally in most Australian jurisdictions';


--
-- Name: lu_route_administration; Type: TABLE; Schema: common; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_route_administration (
    pk integer NOT NULL,
    abbreviation text NOT NULL,
    route text NOT NULL
);


ALTER TABLE common.lu_route_administration OWNER TO easygp;

SET search_path = clin_history, pg_catalog;

--
-- Name: vwrecreationaldrugsused; Type: VIEW; Schema: clin_history; Owner: easygp
--

CREATE VIEW vwrecreationaldrugsused AS
    SELECT recreational_drugs.pk, data_patients.pk AS fk_patient, lu_recreational_drugs.drug, lu_recreational_drugs.alternative_names, lu_route_administration.route, recreational_drugs.fk_consult, recreational_drugs.fk_lu_recreational_drug, recreational_drugs.age_started, recreational_drugs.age_last_used, recreational_drugs.substance_amount, recreational_drugs.fk_lu_substance_amount_units, recreational_drugs.fk_lu_substance_frequency, recreational_drugs.fk_lu_route_administration, recreational_drugs.notes, recreational_drugs.deleted, recreational_drugs.never_used_drug, recreational_drugs.cumulative_amount, lu_recreational_drugs.quantification, lu_recreational_drugs.illicit, lu_recreational_drugs.default_fk_lu_route_administration FROM (((((recreational_drugs JOIN clin_consult.consult ON ((consult.pk = recreational_drugs.fk_consult))) JOIN clerical.data_patients ON ((data_patients.pk = consult.fk_patient))) JOIN common.lu_recreational_drugs ON ((lu_recreational_drugs.pk = recreational_drugs.fk_lu_recreational_drug))) JOIN common.lu_route_administration ON ((lu_route_administration.pk = recreational_drugs.fk_lu_route_administration))) LEFT JOIN common.lu_units ON ((lu_units.pk = recreational_drugs.fk_lu_substance_amount_units)));


ALTER TABLE clin_history.vwrecreationaldrugsused OWNER TO easygp;

--
-- Name: vwsocialhistory; Type: VIEW; Schema: clin_history; Owner: easygp
--

CREATE VIEW vwsocialhistory AS
    SELECT sh.pk AS pk_socialhistory, sh.fk_consult, consult.fk_patient, sh.history, sh.deleted, sh.fk_responsible_person, sh.responsible_person, sh.responsible_person_street1, sh.responsible_person_street2, sh.responsible_person_town, sh.responsible_person_state, sh.responsible_person_postcode, sh.responsible_person_contacts, sh.country_code, lu_countries.country, sh.responsible_person_notes, vwpersonsincludingpatients.title AS person_responsible_title, vwpersonsincludingpatients.firstname AS person_responsible_firstname, vwpersonsincludingpatients.surname AS person_responsible_surname, vwpersonsincludingpatients.wholename AS person_responsible_wholename, vwpersonsincludingpatients.street1 AS person_responsible_street1, vwpersonsincludingpatients.street2 AS person_responsible_street2, vwpersonsincludingpatients.town AS person_responsible_town, vwpersonsincludingpatients.postcode AS person_responsible_postcode, vwpersonsincludingpatients.state AS person_responsible_state, vwpersonsincludingpatients.fk_town AS patient_fk_town FROM (((social_history sh JOIN clin_consult.consult consult ON ((consult.pk = sh.fk_consult))) LEFT JOIN contacts.vwpersonsincludingpatients ON ((vwpersonsincludingpatients.fk_person = sh.fk_responsible_person))) LEFT JOIN common.lu_countries ON (((lu_countries.country_code)::text = sh.country_code))) WHERE (sh.deleted = false);


ALTER TABLE clin_history.vwsocialhistory OWNER TO easygp;

--
-- Name: VIEW vwsocialhistory; Type: COMMENT; Schema: clin_history; Owner: easygp
--

COMMENT ON VIEW vwsocialhistory IS 'Seems odd.. ok. if fk_responsible_person is in our database
    we want the latest name/address, so person_responsible... fields get this 
    from contacts
    If fk_responsible_person is null/0 then we keep the responsible person
    address as given in a straight text field';


SET search_path = contacts, pg_catalog;

--
-- Name: vworganisationsemployees; Type: VIEW; Schema: contacts; Owner: easygp
--

CREATE VIEW vworganisationsemployees AS
    SELECT ((((organisations.pk || '-'::text) || branches.pk) || '-'::text) || employees.pk) AS pk_view, clinics.pk AS fk_clinic, organisations.organisation, organisations.deleted AS organisation_deleted, branches.pk AS fk_branch, branches.branch, branches.fk_organisation, branches.deleted AS branch_deleted, branches.fk_address, employees.memo, branches.fk_category, NULL::character varying AS category, addresses.street1, addresses.street2, addresses.fk_town, addresses.preferred_address, addresses.postal_address, addresses.head_office, addresses.country_code, addresses.fk_lu_address_type, addresses.deleted AS address_deleted, towns.postcode, towns.town, towns.state, employees.pk AS fk_employee, CASE WHEN (employees.pk > 0) THEN (((title.title || ' '::text) || (persons.firstname || ' '::text)) || persons.surname) ELSE 'Nothing'::text END AS wholename, employees.fk_occupation, employees.fk_status, employee_status.status AS employee_status, employees.deleted AS employee_deleted, occupations.occupation, persons.pk AS fk_person, persons.firstname, persons.surname, persons.salutation, persons.birthdate, persons.deceased, persons.date_deceased, persons.retired, persons.fk_ethnicity, persons.fk_language, persons.fk_marital, persons.fk_title, persons.fk_sex, sex.sex, title.title, persons.surname_normalised, data_numbers.provider_number, data_numbers.prescriber_number, data_numbers.australian_business_number FROM ((((((((((((data_employees employees JOIN data_branches branches ON ((employees.fk_branch = branches.pk))) LEFT JOIN lu_employee_status employee_status ON ((employees.fk_status = employee_status.pk))) JOIN data_organisations organisations ON ((branches.fk_organisation = organisations.pk))) LEFT JOIN data_addresses addresses ON ((branches.fk_address = addresses.pk))) LEFT JOIN lu_address_types ON ((addresses.fk_lu_address_type = lu_address_types.pk))) LEFT JOIN lu_towns towns ON ((addresses.fk_town = towns.pk))) LEFT JOIN common.lu_occupations occupations ON ((employees.fk_occupation = occupations.pk))) LEFT JOIN data_persons persons ON ((employees.fk_person = persons.pk))) LEFT JOIN lu_title title ON ((persons.fk_title = title.pk))) LEFT JOIN lu_sex sex ON ((persons.fk_sex = sex.pk))) LEFT JOIN admin.clinics ON ((branches.pk = clinics.fk_branch))) LEFT JOIN data_numbers ON (((employees.fk_person = data_numbers.fk_person) AND (branches.pk = data_numbers.fk_branch)))) WHERE (employees.fk_person IS NOT NULL) UNION SELECT (((organisations.pk || '-'::text) || branches.pk) || '-0'::text) AS pk_view, clinics.pk AS fk_clinic, organisations.organisation, organisations.deleted AS organisation_deleted, branches.pk AS fk_branch, branches.branch, branches.fk_organisation, branches.deleted AS branch_deleted, branches.fk_address, branches.memo, branches.fk_category, categories.category, addresses.street1, addresses.street2, addresses.fk_town, addresses.preferred_address, addresses.postal_address, addresses.head_office, addresses.country_code, addresses.fk_lu_address_type, addresses.deleted AS address_deleted, towns.postcode, towns.town, towns.state, 0 AS fk_employee, ((organisations.organisation || ' '::text) || branches.branch) AS wholename, 0 AS fk_occupation, 0 AS fk_status, NULL::text AS employee_status, false AS employee_deleted, NULL::text AS occupation, 0 AS fk_person, NULL::text AS firstname, NULL::text AS surname, NULL::text AS salutation, NULL::date AS birthdate, false AS deceased, NULL::date AS date_deceased, false AS retired, 0 AS fk_ethnicity, 0 AS fk_language, 0 AS fk_marital, 0 AS fk_title, 0 AS fk_sex, NULL::text AS sex, NULL::text AS title, NULL::text AS surname_normalised, NULL::text AS provider_number, NULL::text AS prescriber_number, data_numbers.australian_business_number FROM (((((((data_branches branches JOIN data_organisations organisations ON ((branches.fk_organisation = organisations.pk))) JOIN lu_categories categories ON ((branches.fk_category = categories.pk))) LEFT JOIN data_addresses addresses ON ((branches.fk_address = addresses.pk))) LEFT JOIN lu_address_types ON ((addresses.fk_lu_address_type = lu_address_types.pk))) LEFT JOIN lu_towns towns ON ((addresses.fk_town = towns.pk))) LEFT JOIN admin.clinics ON ((branches.pk = clinics.fk_branch))) LEFT JOIN data_numbers ON ((branches.pk = data_numbers.fk_branch)));


ALTER TABLE contacts.vworganisationsemployees OWNER TO easygp;

SET search_path = clin_history, pg_catalog;

--
-- Name: vwteamcaremembers; Type: VIEW; Schema: clin_history; Owner: easygp
--

CREATE VIEW vwteamcaremembers AS
    SELECT team_care_members.pk, team_care_members.fk_pasthistory, vworganisationsemployees.fk_organisation, vworganisationsemployees.fk_branch, vworganisationsemployees.fk_person, vworganisationsemployees.fk_employee, CASE WHEN (vworganisationsemployees.fk_employee = 0) THEN vworganisationsemployees.branch ELSE (((vworganisationsemployees.title || ' '::text) || (vworganisationsemployees.firstname || ' '::text)) || vworganisationsemployees.surname) END AS wholename, (((vworganisationsemployees.organisation || ' '::text) || (vworganisationsemployees.branch || ' '::text)) || CASE WHEN (vworganisationsemployees.fk_address IS NULL) THEN ''::text ELSE ((((vworganisationsemployees.street1 || ' '::text) || vworganisationsemployees.town) || ' '::text) || (vworganisationsemployees.postcode)::text) END) AS summary, team_care_members.responsibility FROM (team_care_members LEFT JOIN contacts.vworganisationsemployees ON (((team_care_members.fk_branch = vworganisationsemployees.fk_branch) AND (team_care_members.fk_employee = vworganisationsemployees.fk_employee)))) WHERE ((team_care_members.deleted = false) AND (team_care_members.fk_branch > 0)) UNION SELECT team_care_members.pk, team_care_members.fk_pasthistory, NULL::integer AS fk_organisation, NULL::integer AS fk_branch, vwpersonsincludingpatients.fk_person, NULL::integer AS fk_employee, vwpersonsincludingpatients.wholename, ((((vwpersonsincludingpatients.street1 || ' '::text) || vwpersonsincludingpatients.town) || ' '::text) || (vwpersonsincludingpatients.postcode)::text) AS summary, team_care_members.responsibility FROM ((team_care_members JOIN contacts.vwpersonsincludingpatients ON ((team_care_members.fk_person = vwpersonsincludingpatients.fk_person))) LEFT JOIN contacts.vworganisationsemployees ON ((team_care_members.fk_person = vworganisationsemployees.fk_person))) WHERE ((team_care_members.deleted = false) AND (team_care_members.fk_employee = 0));


ALTER TABLE clin_history.vwteamcaremembers OWNER TO easygp;

SET search_path = clin_measurements, pg_catalog;

--
-- Name: lu_type; Type: TABLE; Schema: clin_measurements; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_type (
    pk integer NOT NULL,
    name_abbreviated text NOT NULL,
    code integer,
    name_full text,
    input_key_restriction integer,
    input_mask text,
    fk_unit integer,
    unit_qualifier text,
    upper_limit integer,
    lower_limit integer,
    fk_decision_support integer,
    fk_plotting_method integer
);


ALTER TABLE clin_measurements.lu_type OWNER TO easygp;

--
-- Name: TABLE lu_type; Type: COMMENT; Schema: clin_measurements; Owner: easygp
--

COMMENT ON TABLE lu_type IS 'A lookup table containing types of measurements';


--
-- Name: COLUMN lu_type.name_abbreviated; Type: COMMENT; Schema: clin_measurements; Owner: easygp
--

COMMENT ON COLUMN lu_type.name_abbreviated IS 'The type of measurement e.g BP';


--
-- Name: COLUMN lu_type.code; Type: COMMENT; Schema: clin_measurements; Owner: easygp
--

COMMENT ON COLUMN lu_type.code IS 'if not null points to disease code not implemented';


--
-- Name: COLUMN lu_type.name_full; Type: COMMENT; Schema: clin_measurements; Owner: easygp
--

COMMENT ON COLUMN lu_type.name_full IS 'Full description eg Blood Pressure';


--
-- Name: COLUMN lu_type.input_key_restriction; Type: COMMENT; Schema: clin_measurements; Owner: easygp
--

COMMENT ON COLUMN lu_type.input_key_restriction IS 'Contant contained in module gvar (global variable module) eg  AllowKeys_BP will allow numbers & /';


--
-- Name: COLUMN lu_type.input_mask; Type: COMMENT; Schema: clin_measurements; Owner: easygp
--

COMMENT ON COLUMN lu_type.input_mask IS 'input mask e.g ###/###';


--
-- Name: COLUMN lu_type.fk_unit; Type: COMMENT; Schema: clin_measurements; Owner: easygp
--

COMMENT ON COLUMN lu_type.fk_unit IS 'key to common.lu_units table eg mm (millimeters)';


--
-- Name: COLUMN lu_type.unit_qualifier; Type: COMMENT; Schema: clin_measurements; Owner: easygp
--

COMMENT ON COLUMN lu_type.unit_qualifier IS 'qualifier for the unit eg Hg (mercury)';


--
-- Name: COLUMN lu_type.upper_limit; Type: COMMENT; Schema: clin_measurements; Owner: easygp
--

COMMENT ON COLUMN lu_type.upper_limit IS 'A recommended upper limit if not null';


--
-- Name: COLUMN lu_type.lower_limit; Type: COMMENT; Schema: clin_measurements; Owner: easygp
--

COMMENT ON COLUMN lu_type.lower_limit IS 'A recommended lower limit if not null';


--
-- Name: COLUMN lu_type.fk_decision_support; Type: COMMENT; Schema: clin_measurements; Owner: easygp
--

COMMENT ON COLUMN lu_type.fk_decision_support IS 'key to Decision support table which does not exist yet';


--
-- Name: COLUMN lu_type.fk_plotting_method; Type: COMMENT; Schema: clin_measurements; Owner: easygp
--

COMMENT ON COLUMN lu_type.fk_plotting_method IS 'foreign key for lu_plotting method table';


--
-- Name: lu_type_pk_seq; Type: SEQUENCE; Schema: clin_measurements; Owner: easygp
--

CREATE SEQUENCE lu_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_measurements.lu_type_pk_seq OWNER TO easygp;

--
-- Name: lu_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_measurements; Owner: easygp
--

ALTER SEQUENCE lu_type_pk_seq OWNED BY lu_type.pk;


--
-- Name: measurements; Type: TABLE; Schema: clin_measurements; Owner: easygp; Tablespace: 
--

CREATE TABLE measurements (
    pk integer NOT NULL,
    fk_consult integer NOT NULL,
    time_noted time without time zone,
    fk_type integer NOT NULL,
    measurement numeric,
    comment text,
    deleted boolean DEFAULT false
);


ALTER TABLE clin_measurements.measurements OWNER TO easygp;

--
-- Name: TABLE measurements; Type: COMMENT; Schema: clin_measurements; Owner: easygp
--

COMMENT ON TABLE measurements IS 'A data table containing data for all measurements all measurements are assumed to be covertable to numbers 
 even blood pressure which is stored as six digit number eg 120070 = 120/70';


--
-- Name: COLUMN measurements.fk_consult; Type: COMMENT; Schema: clin_measurements; Owner: easygp
--

COMMENT ON COLUMN measurements.fk_consult IS 'key to clin_consult.consult table which gives date consult, dr/patient';


--
-- Name: COLUMN measurements.time_noted; Type: COMMENT; Schema: clin_measurements; Owner: easygp
--

COMMENT ON COLUMN measurements.time_noted IS 'time measurement noted within the date of the consult';


--
-- Name: COLUMN measurements.fk_type; Type: COMMENT; Schema: clin_measurements; Owner: easygp
--

COMMENT ON COLUMN measurements.fk_type IS 'key to clin_measurements.lu_type table eg BP measurement';


--
-- Name: COLUMN measurements.measurement; Type: COMMENT; Schema: clin_measurements; Owner: easygp
--

COMMENT ON COLUMN measurements.measurement IS 'the actual measurement, see comment in table comment';


--
-- Name: COLUMN measurements.comment; Type: COMMENT; Schema: clin_measurements; Owner: easygp
--

COMMENT ON COLUMN measurements.comment IS 'comment on this measurement e.g resting BP';


--
-- Name: measurements_pk_seq; Type: SEQUENCE; Schema: clin_measurements; Owner: easygp
--

CREATE SEQUENCE measurements_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_measurements.measurements_pk_seq OWNER TO easygp;

--
-- Name: measurements_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_measurements; Owner: easygp
--

ALTER SEQUENCE measurements_pk_seq OWNED BY measurements.pk;


--
-- Name: patients_defaults; Type: TABLE; Schema: clin_measurements; Owner: easygp; Tablespace: 
--

CREATE TABLE patients_defaults (
    pk integer NOT NULL,
    fk_patient integer NOT NULL,
    fk_lu_type integer,
    loinc text,
    display_as_default boolean DEFAULT false,
    name text,
    alias text,
    deleted boolean DEFAULT false
);


ALTER TABLE clin_measurements.patients_defaults OWNER TO easygp;

--
-- Name: TABLE patients_defaults; Type: COMMENT; Schema: clin_measurements; Owner: easygp
--

COMMENT ON TABLE patients_defaults IS 'contains patient specific measurement types for graphing';


--
-- Name: COLUMN patients_defaults.fk_lu_type; Type: COMMENT; Schema: clin_measurements; Owner: easygp
--

COMMENT ON COLUMN patients_defaults.fk_lu_type IS 'key to clin_measurements.lu_type table. May be null for example if the default type is a loinc code';


--
-- Name: COLUMN patients_defaults.loinc; Type: COMMENT; Schema: clin_measurements; Owner: easygp
--

COMMENT ON COLUMN patients_defaults.loinc IS 'if not null, the default measurement to graph is that of the loinc';


--
-- Name: COLUMN patients_defaults.alias; Type: COMMENT; Schema: clin_measurements; Owner: easygp
--

COMMENT ON COLUMN patients_defaults.alias IS 'Used where the full name is too long for a button, eg Haemoglobin could be HB';


--
-- Name: COLUMN patients_defaults.deleted; Type: COMMENT; Schema: clin_measurements; Owner: easygp
--

COMMENT ON COLUMN patients_defaults.deleted IS 'If True, then this record is marked deleted';


--
-- Name: patients_defaults_pk_seq; Type: SEQUENCE; Schema: clin_measurements; Owner: easygp
--

CREATE SEQUENCE patients_defaults_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_measurements.patients_defaults_pk_seq OWNER TO easygp;

--
-- Name: patients_defaults_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_measurements; Owner: easygp
--

ALTER SEQUENCE patients_defaults_pk_seq OWNED BY patients_defaults.pk;


--
-- Name: vwmeasurements; Type: VIEW; Schema: clin_measurements; Owner: easygp
--

CREATE VIEW vwmeasurements AS
    SELECT consult.fk_patient, consult.consult_date, measurements.fk_consult, measurements.time_noted, lu_type.name_abbreviated AS type, lu_type.name_full, measurements.pk AS pk_measurement, measurements.measurement, consult.fk_staff, measurements.comment, measurements.fk_type, lu_staff_roles.role, data_persons.firstname, data_persons.surname, lu_title.title, measurements.deleted FROM ((((((measurements JOIN lu_type ON ((measurements.fk_type = lu_type.pk))) JOIN clin_consult.consult ON ((measurements.fk_consult = consult.pk))) JOIN admin.staff ON ((consult.fk_staff = staff.pk))) LEFT JOIN admin.lu_staff_roles ON ((staff.fk_role = lu_staff_roles.pk))) LEFT JOIN contacts.data_persons ON ((staff.fk_person = data_persons.pk))) LEFT JOIN contacts.lu_title ON ((data_persons.fk_title = lu_title.pk))) WHERE (measurements.deleted = false) ORDER BY consult.fk_patient, lu_type.name_abbreviated, consult.consult_date, measurements.time_noted;


ALTER TABLE clin_measurements.vwmeasurements OWNER TO easygp;

--
-- Name: vwbpmostrecent; Type: VIEW; Schema: clin_measurements; Owner: easygp
--

CREATE VIEW vwbpmostrecent AS
    SELECT DISTINCT ON (vwmeasurements.fk_patient) vwmeasurements.fk_patient AS pk_view, vwmeasurements.consult_date, vwmeasurements.measurement FROM vwmeasurements WHERE ((vwmeasurements.deleted = false) AND (vwmeasurements.fk_type = 1)) ORDER BY vwmeasurements.fk_patient, vwmeasurements.consult_date DESC;


ALTER TABLE clin_measurements.vwbpmostrecent OWNER TO easygp;

--
-- Name: VIEW vwbpmostrecent; Type: COMMENT; Schema: clin_measurements; Owner: easygp
--

COMMENT ON VIEW vwbpmostrecent IS ' the latest BP measurement for all patients, pk_view = fk_patient';


--
-- Name: vwheightmostrecent; Type: VIEW; Schema: clin_measurements; Owner: easygp
--

CREATE VIEW vwheightmostrecent AS
    SELECT DISTINCT ON (vwmeasurements.fk_patient) vwmeasurements.fk_patient AS pk_view, vwmeasurements.consult_date, vwmeasurements.measurement FROM vwmeasurements WHERE ((vwmeasurements.deleted = false) AND (vwmeasurements.fk_type = 4)) ORDER BY vwmeasurements.fk_patient, vwmeasurements.consult_date DESC;


ALTER TABLE clin_measurements.vwheightmostrecent OWNER TO easygp;

--
-- Name: VIEW vwheightmostrecent; Type: COMMENT; Schema: clin_measurements; Owner: easygp
--

COMMENT ON VIEW vwheightmostrecent IS ' the latest Height measurement for all patients, pk_view = fk_patient';


--
-- Name: vwmeasurementtypes; Type: VIEW; Schema: clin_measurements; Owner: easygp
--

CREATE VIEW vwmeasurementtypes AS
    SELECT lu_units.full_text, lu_units.abbrev_text, lu_type.pk, lu_type.name_abbreviated, lu_type.code, lu_type.name_full, lu_type.input_key_restriction, lu_type.input_mask, lu_type.fk_unit, lu_type.unit_qualifier, lu_type.upper_limit, lu_type.lower_limit, lu_type.fk_decision_support, lu_type.fk_plotting_method FROM (lu_type JOIN common.lu_units ON ((lu_type.fk_unit = lu_units.pk))) ORDER BY lu_type.name_full;


ALTER TABLE clin_measurements.vwmeasurementtypes OWNER TO easygp;

--
-- Name: vwpatientsdefaults; Type: VIEW; Schema: clin_measurements; Owner: easygp
--

CREATE VIEW vwpatientsdefaults AS
    SELECT patients_defaults.fk_patient, patients_defaults.pk AS pk_patients_defaults, patients_defaults.fk_lu_type, lu_type.name_abbreviated, lu_type.code, lu_type.input_key_restriction, lu_type.name_full, lu_type.input_mask, lu_type.fk_unit, lu_type.unit_qualifier, lu_type.upper_limit, lu_type.lower_limit, lu_type.fk_decision_support, lu_type.fk_plotting_method, lu_units.full_text, lu_units.abbrev_text FROM ((patients_defaults JOIN lu_type ON ((patients_defaults.fk_lu_type = lu_type.pk))) LEFT JOIN common.lu_units ON ((lu_type.fk_unit = lu_units.pk))) ORDER BY patients_defaults.fk_patient;


ALTER TABLE clin_measurements.vwpatientsdefaults OWNER TO easygp;

--
-- Name: vwweightmostrecent; Type: VIEW; Schema: clin_measurements; Owner: easygp
--

CREATE VIEW vwweightmostrecent AS
    SELECT DISTINCT ON (vwmeasurements.fk_patient) vwmeasurements.fk_patient AS pk_view, vwmeasurements.consult_date, vwmeasurements.measurement FROM vwmeasurements WHERE ((vwmeasurements.deleted = false) AND (vwmeasurements.fk_type = 2)) ORDER BY vwmeasurements.fk_patient, vwmeasurements.consult_date DESC;


ALTER TABLE clin_measurements.vwweightmostrecent OWNER TO easygp;

--
-- Name: VIEW vwweightmostrecent; Type: COMMENT; Schema: clin_measurements; Owner: easygp
--

COMMENT ON VIEW vwweightmostrecent IS ' the latest Weight measurement for all patients, pk_view = fk_patient';


SET search_path = clin_mentalhealth, pg_catalog;

--
-- Name: k10_results; Type: TABLE; Schema: clin_mentalhealth; Owner: easygp; Tablespace: 
--

CREATE TABLE k10_results (
    pk integer NOT NULL,
    fk_plan integer,
    fk_lu_k10_component integer,
    score integer
);


ALTER TABLE clin_mentalhealth.k10_results OWNER TO easygp;

--
-- Name: k10_results_pk_seq; Type: SEQUENCE; Schema: clin_mentalhealth; Owner: easygp
--

CREATE SEQUENCE k10_results_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_mentalhealth.k10_results_pk_seq OWNER TO easygp;

--
-- Name: k10_results_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_mentalhealth; Owner: easygp
--

ALTER SEQUENCE k10_results_pk_seq OWNED BY k10_results.pk;


--
-- Name: lu_assessment_tools; Type: TABLE; Schema: clin_mentalhealth; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_assessment_tools (
    pk_tool integer NOT NULL,
    tool text NOT NULL,
    tool_about text,
    name_abbrev text
);


ALTER TABLE clin_mentalhealth.lu_assessment_tools OWNER TO easygp;

--
-- Name: TABLE lu_assessment_tools; Type: COMMENT; Schema: clin_mentalhealth; Owner: easygp
--

COMMENT ON TABLE lu_assessment_tools IS 'table containing names of assessment tools and some descriptive html to display to user';


--
-- Name: lu_assessment_tools_pk_tool_seq; Type: SEQUENCE; Schema: clin_mentalhealth; Owner: easygp
--

CREATE SEQUENCE lu_assessment_tools_pk_tool_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_mentalhealth.lu_assessment_tools_pk_tool_seq OWNER TO easygp;

--
-- Name: lu_assessment_tools_pk_tool_seq; Type: SEQUENCE OWNED BY; Schema: clin_mentalhealth; Owner: easygp
--

ALTER SEQUENCE lu_assessment_tools_pk_tool_seq OWNED BY lu_assessment_tools.pk_tool;


--
-- Name: lu_component_help; Type: TABLE; Schema: clin_mentalhealth; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_component_help (
    pk integer NOT NULL,
    care_plan_component text NOT NULL,
    component_help text NOT NULL
);


ALTER TABLE clin_mentalhealth.lu_component_help OWNER TO easygp;

--
-- Name: TABLE lu_component_help; Type: COMMENT; Schema: clin_mentalhealth; Owner: easygp
--

COMMENT ON TABLE lu_component_help IS 'contains help for each component of a care plan';


--
-- Name: COLUMN lu_component_help.care_plan_component; Type: COMMENT; Schema: clin_mentalhealth; Owner: easygp
--

COMMENT ON COLUMN lu_component_help.care_plan_component IS 'the components of a plan e.g mental state examination';


--
-- Name: lu_component_help_pk_seq; Type: SEQUENCE; Schema: clin_mentalhealth; Owner: easygp
--

CREATE SEQUENCE lu_component_help_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_mentalhealth.lu_component_help_pk_seq OWNER TO easygp;

--
-- Name: lu_component_help_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_mentalhealth; Owner: easygp
--

ALTER SEQUENCE lu_component_help_pk_seq OWNED BY lu_component_help.pk;


--
-- Name: lu_depression_degree; Type: TABLE; Schema: clin_mentalhealth; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_depression_degree (
    pk integer NOT NULL,
    degree text NOT NULL
);


ALTER TABLE clin_mentalhealth.lu_depression_degree OWNER TO easygp;

--
-- Name: lu_depression_degree_pk_seq; Type: SEQUENCE; Schema: clin_mentalhealth; Owner: easygp
--

CREATE SEQUENCE lu_depression_degree_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_mentalhealth.lu_depression_degree_pk_seq OWNER TO easygp;

--
-- Name: lu_depression_degree_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_mentalhealth; Owner: easygp
--

ALTER SEQUENCE lu_depression_degree_pk_seq OWNED BY lu_depression_degree.pk;


--
-- Name: lu_k10_components; Type: TABLE; Schema: clin_mentalhealth; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_k10_components (
    pk integer NOT NULL,
    component text NOT NULL
);


ALTER TABLE clin_mentalhealth.lu_k10_components OWNER TO easygp;

--
-- Name: lu_k10_components_pk_seq; Type: SEQUENCE; Schema: clin_mentalhealth; Owner: easygp
--

CREATE SEQUENCE lu_k10_components_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_mentalhealth.lu_k10_components_pk_seq OWNER TO easygp;

--
-- Name: lu_k10_components_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_mentalhealth; Owner: easygp
--

ALTER SEQUENCE lu_k10_components_pk_seq OWNED BY lu_k10_components.pk;


--
-- Name: lu_plan_type; Type: TABLE; Schema: clin_mentalhealth; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_plan_type (
    pk integer NOT NULL,
    type text NOT NULL
);


ALTER TABLE clin_mentalhealth.lu_plan_type OWNER TO easygp;

--
-- Name: lu_plan_type_pk_seq; Type: SEQUENCE; Schema: clin_mentalhealth; Owner: easygp
--

CREATE SEQUENCE lu_plan_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_mentalhealth.lu_plan_type_pk_seq OWNER TO easygp;

--
-- Name: lu_plan_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_mentalhealth; Owner: easygp
--

ALTER SEQUENCE lu_plan_type_pk_seq OWNED BY lu_plan_type.pk;


--
-- Name: lu_risk_to_others; Type: TABLE; Schema: clin_mentalhealth; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_risk_to_others (
    pk integer NOT NULL,
    risk text NOT NULL
);


ALTER TABLE clin_mentalhealth.lu_risk_to_others OWNER TO easygp;

--
-- Name: lu_risk_to_others_pk_seq; Type: SEQUENCE; Schema: clin_mentalhealth; Owner: easygp
--

CREATE SEQUENCE lu_risk_to_others_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_mentalhealth.lu_risk_to_others_pk_seq OWNER TO easygp;

--
-- Name: lu_risk_to_others_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_mentalhealth; Owner: easygp
--

ALTER SEQUENCE lu_risk_to_others_pk_seq OWNED BY lu_risk_to_others.pk;


--
-- Name: mentalhealth_plan; Type: TABLE; Schema: clin_mentalhealth; Owner: easygp; Tablespace: 
--

CREATE TABLE mentalhealth_plan (
    pk integer NOT NULL,
    fk_consult integer NOT NULL,
    fk_pasthistory integer,
    diagnosis text NOT NULL,
    fk_coding_system integer,
    fk_code text,
    presenting_problems text,
    bio_psycho_social text,
    mental_state_examination text,
    fk_lu_risk_to_others integer,
    fk_stress_assessment integer,
    risk_harm_comments text,
    goals text,
    treatment_referrrals text,
    patient_action text,
    review_date date,
    html text,
    deleted boolean DEFAULT false,
    fk_lu_plan_type integer,
    fk_progressnote integer,
    relapse_plan text
);


ALTER TABLE clin_mentalhealth.mentalhealth_plan OWNER TO easygp;

--
-- Name: TABLE mentalhealth_plan; Type: COMMENT; Schema: clin_mentalhealth; Owner: easygp
--

COMMENT ON TABLE mentalhealth_plan IS 'The mental health plan components including html';


--
-- Name: COLUMN mentalhealth_plan.fk_consult; Type: COMMENT; Schema: clin_mentalhealth; Owner: easygp
--

COMMENT ON COLUMN mentalhealth_plan.fk_consult IS 'key to clin_consult.consult > gives Dr and date plan formulated';


--
-- Name: COLUMN mentalhealth_plan.fk_pasthistory; Type: COMMENT; Schema: clin_mentalhealth; Owner: easygp
--

COMMENT ON COLUMN mentalhealth_plan.fk_pasthistory IS 'key to clin_history.past_history if not null is linked to health issue';


--
-- Name: COLUMN mentalhealth_plan.diagnosis; Type: COMMENT; Schema: clin_mentalhealth; Owner: easygp
--

COMMENT ON COLUMN mentalhealth_plan.diagnosis IS 'the diagnosis may be free text but could be coded';


--
-- Name: COLUMN mentalhealth_plan.fk_coding_system; Type: COMMENT; Schema: clin_mentalhealth; Owner: easygp
--

COMMENT ON COLUMN mentalhealth_plan.fk_coding_system IS 'if not null this is the coding system used for the coded diagnosis';


--
-- Name: COLUMN mentalhealth_plan.fk_lu_risk_to_others; Type: COMMENT; Schema: clin_mentalhealth; Owner: easygp
--

COMMENT ON COLUMN mentalhealth_plan.fk_lu_risk_to_others IS 'key to lu_risk_to_others table';


--
-- Name: COLUMN mentalhealth_plan.fk_stress_assessment; Type: COMMENT; Schema: clin_mentalhealth; Owner: easygp
--

COMMENT ON COLUMN mentalhealth_plan.fk_stress_assessment IS 'key to stress_assessment table eg results of K10';


--
-- Name: COLUMN mentalhealth_plan.html; Type: COMMENT; Schema: clin_mentalhealth; Owner: easygp
--

COMMENT ON COLUMN mentalhealth_plan.html IS 'the plan in html';


--
-- Name: COLUMN mentalhealth_plan.fk_progressnote; Type: COMMENT; Schema: clin_mentalhealth; Owner: easygp
--

COMMENT ON COLUMN mentalhealth_plan.fk_progressnote IS 'foreign key to clin_consult.progressnotes, and points to the progress note for the consultation
 that this mental health plan was written in. Used in editing during a consultation only';


--
-- Name: mentalhealth_plan_pk_seq; Type: SEQUENCE; Schema: clin_mentalhealth; Owner: easygp
--

CREATE SEQUENCE mentalhealth_plan_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_mentalhealth.mentalhealth_plan_pk_seq OWNER TO easygp;

--
-- Name: mentalhealth_plan_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_mentalhealth; Owner: easygp
--

ALTER SEQUENCE mentalhealth_plan_pk_seq OWNED BY mentalhealth_plan.pk;


--
-- Name: team_care_members; Type: TABLE; Schema: clin_mentalhealth; Owner: easygp; Tablespace: 
--

CREATE TABLE team_care_members (
    pk integer NOT NULL,
    fk_plan integer NOT NULL,
    fk_organisation integer,
    fk_branch integer,
    fk_employee integer,
    fk_person integer,
    deleted boolean DEFAULT false,
    responsibility text
);


ALTER TABLE clin_mentalhealth.team_care_members OWNER TO easygp;

--
-- Name: TABLE team_care_members; Type: COMMENT; Schema: clin_mentalhealth; Owner: easygp
--

COMMENT ON TABLE team_care_members IS 'links a mental health plan to team care members
  keys are kept rather than names and addresses to allow automatic updating of the
  names and addresses on the care plan.';


--
-- Name: team_care_members_pk_seq; Type: SEQUENCE; Schema: clin_mentalhealth; Owner: easygp
--

CREATE SEQUENCE team_care_members_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_mentalhealth.team_care_members_pk_seq OWNER TO easygp;

--
-- Name: team_care_members_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_mentalhealth; Owner: easygp
--

ALTER SEQUENCE team_care_members_pk_seq OWNED BY team_care_members.pk;


--
-- Name: vwk10results; Type: VIEW; Schema: clin_mentalhealth; Owner: easygp
--

CREATE VIEW vwk10results AS
    SELECT k10_results.pk, k10_results.fk_plan, k10_results.fk_lu_k10_component, k10_results.score, lu_k10_components.component FROM k10_results, lu_k10_components WHERE (k10_results.fk_lu_k10_component = lu_k10_components.pk) ORDER BY k10_results.fk_plan;


ALTER TABLE clin_mentalhealth.vwk10results OWNER TO easygp;

--
-- Name: vwmentalhealthplans; Type: VIEW; Schema: clin_mentalhealth; Owner: easygp
--

CREATE VIEW vwmentalhealthplans AS
    SELECT mentalhealth_plan.pk AS pk_mentalhealth_plan, consult.fk_patient, consult.fk_staff, consult.consult_date AS plan_date, mentalhealth_plan.fk_consult, mentalhealth_plan.fk_pasthistory, mentalhealth_plan.diagnosis, mentalhealth_plan.fk_coding_system, mentalhealth_plan.fk_progressnote, lu_systems.system, (SELECT DISTINCT generic_terms.term FROM coding.generic_terms WHERE (mentalhealth_plan.fk_code = generic_terms.code)) AS coded_term, mentalhealth_plan.fk_code, mentalhealth_plan.presenting_problems, mentalhealth_plan.bio_psycho_social, mentalhealth_plan.mental_state_examination, mentalhealth_plan.fk_lu_risk_to_others, lu_risk_to_others.risk, mentalhealth_plan.fk_stress_assessment, mentalhealth_plan.relapse_plan, mentalhealth_plan.risk_harm_comments, mentalhealth_plan.goals, mentalhealth_plan.treatment_referrrals, mentalhealth_plan.review_date, mentalhealth_plan.html, mentalhealth_plan.fk_lu_plan_type, lu_plan_type.type, mentalhealth_plan.deleted, vwstaff.wholename, vwstaff.title FROM ((((((mentalhealth_plan JOIN clin_consult.consult ON ((mentalhealth_plan.fk_consult = consult.pk))) JOIN lu_plan_type ON ((mentalhealth_plan.fk_lu_plan_type = lu_plan_type.pk))) LEFT JOIN clin_history.past_history ON ((mentalhealth_plan.fk_pasthistory = past_history.pk))) JOIN coding.lu_systems ON ((mentalhealth_plan.fk_coding_system = lu_systems.pk))) LEFT JOIN lu_risk_to_others ON ((mentalhealth_plan.fk_lu_risk_to_others = lu_risk_to_others.pk))) JOIN admin.vwstaff ON ((consult.fk_staff = vwstaff.fk_staff))) WHERE (NOT mentalhealth_plan.deleted);


ALTER TABLE clin_mentalhealth.vwmentalhealthplans OWNER TO easygp;

--
-- Name: vwteamcaremembers; Type: VIEW; Schema: clin_mentalhealth; Owner: easygp
--

CREATE VIEW vwteamcaremembers AS
    SELECT team_care_members.pk, team_care_members.fk_plan, vworganisationsemployees.fk_organisation, vworganisationsemployees.fk_branch, vworganisationsemployees.fk_person, CASE WHEN (vworganisationsemployees.fk_employee = 0) THEN vworganisationsemployees.branch ELSE (((vworganisationsemployees.title || ' '::text) || (vworganisationsemployees.firstname || ' '::text)) || vworganisationsemployees.surname) END AS wholename, (((vworganisationsemployees.organisation || ' '::text) || (vworganisationsemployees.branch || ' '::text)) || CASE WHEN (vworganisationsemployees.fk_address IS NULL) THEN ''::text ELSE ((((vworganisationsemployees.street1 || ' '::text) || vworganisationsemployees.town) || ' '::text) || (vworganisationsemployees.postcode)::text) END) AS summary, team_care_members.responsibility FROM (team_care_members LEFT JOIN contacts.vworganisationsemployees ON (((team_care_members.fk_branch = vworganisationsemployees.fk_branch) AND (team_care_members.fk_employee = vworganisationsemployees.fk_employee)))) WHERE ((team_care_members.deleted = false) AND (team_care_members.fk_branch > 0)) UNION SELECT team_care_members.pk, team_care_members.fk_plan, NULL::integer AS fk_organisation, NULL::integer AS fk_branch, vwpersonsincludingpatients.fk_person, vwpersonsincludingpatients.wholename, ((((vwpersonsincludingpatients.street1 || ' '::text) || vwpersonsincludingpatients.town) || ' '::text) || (vwpersonsincludingpatients.postcode)::text) AS summary, team_care_members.responsibility FROM ((team_care_members JOIN contacts.vwpersonsincludingpatients ON ((team_care_members.fk_person = vwpersonsincludingpatients.fk_person))) LEFT JOIN contacts.vworganisationsemployees ON ((team_care_members.fk_person = vworganisationsemployees.fk_person))) WHERE ((team_care_members.deleted = false) AND (team_care_members.fk_employee IS NULL));


ALTER TABLE clin_mentalhealth.vwteamcaremembers OWNER TO easygp;

SET search_path = clin_pregnancy, pg_catalog;

--
-- Name: lu_antenatal_venue; Type: TABLE; Schema: clin_pregnancy; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_antenatal_venue (
    pk integer NOT NULL,
    fk_branch integer NOT NULL
);


ALTER TABLE clin_pregnancy.lu_antenatal_venue OWNER TO easygp;

--
-- Name: TABLE lu_antenatal_venue; Type: COMMENT; Schema: clin_pregnancy; Owner: easygp
--

COMMENT ON TABLE lu_antenatal_venue IS 'available venues for attendance for pregnant women';


--
-- Name: lu_antenatal_venue_pk_seq; Type: SEQUENCE; Schema: clin_pregnancy; Owner: easygp
--

CREATE SEQUENCE lu_antenatal_venue_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_pregnancy.lu_antenatal_venue_pk_seq OWNER TO easygp;

--
-- Name: lu_antenatal_venue_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_pregnancy; Owner: easygp
--

ALTER SEQUENCE lu_antenatal_venue_pk_seq OWNED BY lu_antenatal_venue.pk;


SET search_path = clin_prescribing, pg_catalog;

--
-- Name: authority_script_number; Type: TABLE; Schema: clin_prescribing; Owner: easygp; Tablespace: 
--

CREATE TABLE authority_script_number (
    fk_staff integer NOT NULL,
    authority_script_number integer NOT NULL
);


ALTER TABLE clin_prescribing.authority_script_number OWNER TO easygp;

--
-- Name: TABLE authority_script_number; Type: COMMENT; Schema: clin_prescribing; Owner: easygp
--

COMMENT ON TABLE authority_script_number IS 'keeps record of the last used authority number per staff per clinic';


--
-- Name: increased_quantity_authority_reasons; Type: TABLE; Schema: clin_prescribing; Owner: easygp; Tablespace: 
--

CREATE TABLE increased_quantity_authority_reasons (
    pk integer NOT NULL,
    reason text NOT NULL
);


ALTER TABLE clin_prescribing.increased_quantity_authority_reasons OWNER TO easygp;

--
-- Name: increased_quantity_authority_reasons_pk_seq; Type: SEQUENCE; Schema: clin_prescribing; Owner: easygp
--

CREATE SEQUENCE increased_quantity_authority_reasons_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_prescribing.increased_quantity_authority_reasons_pk_seq OWNER TO easygp;

--
-- Name: increased_quantity_authority_reasons_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_prescribing; Owner: easygp
--

ALTER SEQUENCE increased_quantity_authority_reasons_pk_seq OWNED BY increased_quantity_authority_reasons.pk;


--
-- Name: instruction_habits; Type: TABLE; Schema: clin_prescribing; Owner: easygp; Tablespace: 
--

CREATE TABLE instruction_habits (
    pk integer NOT NULL,
    fk_instruction integer NOT NULL,
    fk_generic_product uuid NOT NULL,
    fk_staff integer NOT NULL,
    weighting integer NOT NULL,
    fk_brand uuid
);


ALTER TABLE clin_prescribing.instruction_habits OWNER TO easygp;

--
-- Name: TABLE instruction_habits; Type: COMMENT; Schema: clin_prescribing; Owner: easygp
--

COMMENT ON TABLE instruction_habits IS 'allow auto-completion of a script for the commonest instruction
 a particular staff member uses for a particular drug. 
	-If fk_company and fk_generic product are not null,
	then this points  to a brand name in drugs.brand
	-If fk_company is null, then this is a generically prescribed drug';


--
-- Name: instruction_habits_pk_seq; Type: SEQUENCE; Schema: clin_prescribing; Owner: easygp
--

CREATE SEQUENCE instruction_habits_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_prescribing.instruction_habits_pk_seq OWNER TO easygp;

--
-- Name: instruction_habits_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_prescribing; Owner: easygp
--

ALTER SEQUENCE instruction_habits_pk_seq OWNED BY instruction_habits.pk;


--
-- Name: instructions; Type: TABLE; Schema: clin_prescribing; Owner: easygp; Tablespace: 
--

CREATE TABLE instructions (
    pk integer NOT NULL,
    instruction text,
    fk_lu_units integer,
    am integer,
    lunch integer,
    pm integer,
    bed integer,
    prn integer
);


ALTER TABLE clin_prescribing.instructions OWNER TO easygp;

--
-- Name: TABLE instructions; Type: COMMENT; Schema: clin_prescribing; Owner: easygp
--

COMMENT ON TABLE instructions IS 'A lookup table for instructions and hopefully with a bit of intelligence
 allow printing out of medications charts';


--
-- Name: COLUMN instructions.fk_lu_units; Type: COMMENT; Schema: clin_prescribing; Owner: easygp
--

COMMENT ON COLUMN instructions.fk_lu_units IS 'key to common.lu_units = day, month, week or year = frequency of the medication';


--
-- Name: instructions_pk_seq; Type: SEQUENCE; Schema: clin_prescribing; Owner: easygp
--

CREATE SEQUENCE instructions_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_prescribing.instructions_pk_seq OWNER TO easygp;

--
-- Name: instructions_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_prescribing; Owner: easygp
--

ALTER SEQUENCE instructions_pk_seq OWNED BY instructions.pk;


--
-- Name: lu_pbs_script_type; Type: TABLE; Schema: clin_prescribing; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_pbs_script_type (
    pk integer NOT NULL,
    type text NOT NULL
);


ALTER TABLE clin_prescribing.lu_pbs_script_type OWNER TO easygp;

--
-- Name: TABLE lu_pbs_script_type; Type: COMMENT; Schema: clin_prescribing; Owner: easygp
--

COMMENT ON TABLE lu_pbs_script_type IS 'The various ways a script can be printed as for example:
	- PBS AUTHORITY, RPBS AUTHORITY, PBS STREAMLINED AUTHORITY
	  PBS, RPBS,  PRIVATE';


--
-- Name: medications; Type: TABLE; Schema: clin_prescribing; Owner: easygp; Tablespace: 
--

CREATE TABLE medications (
    pk integer NOT NULL,
    active boolean DEFAULT false,
    deleted boolean DEFAULT false,
    start_date date DEFAULT now() NOT NULL,
    last_date date DEFAULT now() NOT NULL,
    fk_generic_product uuid NOT NULL
);


ALTER TABLE clin_prescribing.medications OWNER TO easygp;

--
-- Name: TABLE medications; Type: COMMENT; Schema: clin_prescribing; Owner: easygp
--

COMMENT ON TABLE medications IS 'The medications table holds a list of unique medications for each patient';


--
-- Name: COLUMN medications.active; Type: COMMENT; Schema: clin_prescribing; Owner: easygp
--

COMMENT ON COLUMN medications.active IS '
If true, the medication is on the patients active medication list';


--
-- Name: COLUMN medications.deleted; Type: COMMENT; Schema: clin_prescribing; Owner: easygp
--

COMMENT ON COLUMN medications.deleted IS 'if true the record is marked deleted, e.g could have been prescribed for the
 wrong patient, but has been deleted by the user, hence this record remains
 part of an audit trail';


--
-- Name: COLUMN medications.start_date; Type: COMMENT; Schema: clin_prescribing; Owner: easygp
--

COMMENT ON COLUMN medications.start_date IS 'the date the medication was started';


--
-- Name: COLUMN medications.last_date; Type: COMMENT; Schema: clin_prescribing; Owner: easygp
--

COMMENT ON COLUMN medications.last_date IS 'the last date the medication was prescibed';


--
-- Name: COLUMN medications.fk_generic_product; Type: COMMENT; Schema: clin_prescribing; Owner: easygp
--

COMMENT ON COLUMN medications.fk_generic_product IS 'the last date the medication was prescibed
 this is the foreign key to the drugs.product table which gives then
 dispensable form of a generic drug including strength, package size etc';


--
-- Name: medications_pk_seq; Type: SEQUENCE; Schema: clin_prescribing; Owner: easygp
--

CREATE SEQUENCE medications_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_prescribing.medications_pk_seq OWNER TO easygp;

--
-- Name: medications_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_prescribing; Owner: easygp
--

ALTER SEQUENCE medications_pk_seq OWNED BY medications.pk;


--
-- Name: prescribed; Type: TABLE; Schema: clin_prescribing; Owner: easygp; Tablespace: 
--

CREATE TABLE prescribed (
    pk integer NOT NULL,
    fk_consult integer NOT NULL,
    fk_medication integer NOT NULL,
    fk_brand uuid,
    date_on_script date NOT NULL,
    repeats integer DEFAULT 0 NOT NULL,
    quantity integer NOT NULL,
    fk_instruction integer NOT NULL,
    fk_prescribed_for integer,
    pbscode text,
    restriction_code text,
    reg24 boolean DEFAULT false,
    authority_script_number integer,
    authority_approval_number text,
    authority_post_to_patient boolean DEFAULT false,
    script_number integer,
    fk_code text,
    concession_details text,
    brand_substitution boolean DEFAULT true,
    fk_lu_pbs_script_type integer,
    fk_progress_note integer,
    deleted boolean DEFAULT false,
    printed boolean DEFAULT true,
    authority_reason text,
    print_reason boolean DEFAULT true,
    latex text DEFAULT (NOT NULL::boolean)
);


ALTER TABLE clin_prescribing.prescribed OWNER TO easygp;

--
-- Name: TABLE prescribed; Type: COMMENT; Schema: clin_prescribing; Owner: easygp
--

COMMENT ON TABLE prescribed IS 'Every single item prescribed has an entry here
	 this table gives us
	- the doctor who prescribed (via fk_consult)
	- the date prescription was issued consult.date
	- the actual date on the script (script_date)
	  which could be foreward or back dated mmm.. illegal?
	- the medication details (fk_medication) of start data, last date and product via medications.fk_generic_product)
	- stuff which could be unique for this prescription
	  such as pbs details, quantity, repeats, reg 25, s8
	- print_status is pbs or rpbs or priv
	- the pack details for this drug on this occasion.';


--
-- Name: COLUMN prescribed.fk_consult; Type: COMMENT; Schema: clin_prescribing; Owner: easygp
--

COMMENT ON COLUMN prescribed.fk_consult IS 'foreign key to clin_consult.consult table';


--
-- Name: COLUMN prescribed.date_on_script; Type: COMMENT; Schema: clin_prescribing; Owner: easygp
--

COMMENT ON COLUMN prescribed.date_on_script IS '
The actual date on the script may not be the consulation date, can be back/forwarded dated,
without this ability GP''s may as well pack up and go
home though illegal in theory';


--
-- Name: COLUMN prescribed.repeats; Type: COMMENT; Schema: clin_prescribing; Owner: easygp
--

COMMENT ON COLUMN prescribed.repeats IS '
The actual number of repeats
may not be the max repeats allowed
by the pbs accessed by fk_pbs';


--
-- Name: COLUMN prescribed.quantity; Type: COMMENT; Schema: clin_prescribing; Owner: easygp
--

COMMENT ON COLUMN prescribed.quantity IS '
The quantity on the script
May not be the actual quanitity allowed on the pbs
e.g sometimes we may prescribe diazepam in small quantities';


--
-- Name: COLUMN prescribed.reg24; Type: COMMENT; Schema: clin_prescribing; Owner: easygp
--

COMMENT ON COLUMN prescribed.reg24 IS '
If true reg24 allows us to tell the
pharmacist to dispense the script and all 
its repeats at once';


--
-- Name: COLUMN prescribed.authority_script_number; Type: COMMENT; Schema: clin_prescribing; Owner: easygp
--

COMMENT ON COLUMN prescribed.authority_script_number IS 'the pbs requires a unique script number for an authority item, pretty stupid, but a number that
 increments by 11. This is distinct from the streamlined approval number or phone approval number';


--
-- Name: COLUMN prescribed.authority_approval_number; Type: COMMENT; Schema: clin_prescribing; Owner: easygp
--

COMMENT ON COLUMN prescribed.authority_approval_number IS 'either the steamlined authority number or the phone approval number obtained from a pbs operator';


--
-- Name: COLUMN prescribed.fk_code; Type: COMMENT; Schema: clin_prescribing; Owner: easygp
--

COMMENT ON COLUMN prescribed.fk_code IS 'foreign key to references coding.generic_terms, if not null then the reason for using script
   is coded';


--
-- Name: COLUMN prescribed.printed; Type: COMMENT; Schema: clin_prescribing; Owner: easygp
--

COMMENT ON COLUMN prescribed.printed IS 'if the script was actually printed then printed is true, i.e when the menu option saved no print is used field is false';


--
-- Name: COLUMN prescribed.authority_reason; Type: COMMENT; Schema: clin_prescribing; Owner: easygp
--

COMMENT ON COLUMN prescribed.authority_reason IS 'the text of the authority wording';


--
-- Name: COLUMN prescribed.print_reason; Type: COMMENT; Schema: clin_prescribing; Owner: easygp
--

COMMENT ON COLUMN prescribed.print_reason IS 'if True then the reason the drug was prescribed will be printed on the script';


--
-- Name: prescribed_for; Type: TABLE; Schema: clin_prescribing; Owner: easygp; Tablespace: 
--

CREATE TABLE prescribed_for (
    pk integer NOT NULL,
    prescribed_for text NOT NULL,
    fk_code text
);


ALTER TABLE clin_prescribing.prescribed_for OWNER TO easygp;

--
-- Name: TABLE prescribed_for; Type: COMMENT; Schema: clin_prescribing; Owner: easygp
--

COMMENT ON TABLE prescribed_for IS 'keeps list of things prescribed for
  If fk_code is not null it has been coded
  referenced by items_prescibed.fk_prescibed_for';


--
-- Name: prescribed_for_habits; Type: TABLE; Schema: clin_prescribing; Owner: easygp; Tablespace: 
--

CREATE TABLE prescribed_for_habits (
    pk integer NOT NULL,
    fk_prescribed_for integer NOT NULL,
    fk_generic_product uuid NOT NULL,
    fk_staff integer NOT NULL,
    weighting integer NOT NULL,
    fk_brand uuid
);


ALTER TABLE clin_prescribing.prescribed_for_habits OWNER TO easygp;

--
-- Name: TABLE prescribed_for_habits; Type: COMMENT; Schema: clin_prescribing; Owner: easygp
--

COMMENT ON TABLE prescribed_for_habits IS 'used to auto-complete a script on a per-staff member, to
 display the commonest reason a particular generic +/- brand
 was prescribed for';


--
-- Name: prescribed_for_habits_pk_seq; Type: SEQUENCE; Schema: clin_prescribing; Owner: easygp
--

CREATE SEQUENCE prescribed_for_habits_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_prescribing.prescribed_for_habits_pk_seq OWNER TO easygp;

--
-- Name: prescribed_for_habits_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_prescribing; Owner: easygp
--

ALTER SEQUENCE prescribed_for_habits_pk_seq OWNED BY prescribed_for_habits.pk;


--
-- Name: prescribed_for_pk_seq; Type: SEQUENCE; Schema: clin_prescribing; Owner: easygp
--

CREATE SEQUENCE prescribed_for_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_prescribing.prescribed_for_pk_seq OWNER TO easygp;

--
-- Name: prescribed_for_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_prescribing; Owner: easygp
--

ALTER SEQUENCE prescribed_for_pk_seq OWNED BY prescribed_for.pk;


--
-- Name: prescribed_pk_seq; Type: SEQUENCE; Schema: clin_prescribing; Owner: easygp
--

CREATE SEQUENCE prescribed_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_prescribing.prescribed_pk_seq OWNER TO easygp;

--
-- Name: prescribed_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_prescribing; Owner: easygp
--

ALTER SEQUENCE prescribed_pk_seq OWNED BY prescribed.pk;


--
-- Name: print_status_pk_seq; Type: SEQUENCE; Schema: clin_prescribing; Owner: easygp
--

CREATE SEQUENCE print_status_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_prescribing.print_status_pk_seq OWNER TO easygp;

--
-- Name: print_status_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_prescribing; Owner: easygp
--

ALTER SEQUENCE print_status_pk_seq OWNED BY lu_pbs_script_type.pk;


--
-- Name: script_number; Type: SEQUENCE; Schema: clin_prescribing; Owner: easygp
--

CREATE SEQUENCE script_number
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_prescribing.script_number OWNER TO easygp;

--
-- Name: vwinstructionhabits; Type: VIEW; Schema: clin_prescribing; Owner: easygp
--

CREATE VIEW vwinstructionhabits AS
    SELECT instruction_habits.pk AS pk_instruction_habit, instruction_habits.fk_instruction, instruction_habits.fk_brand, instruction_habits.fk_generic_product, instruction_habits.fk_staff, instruction_habits.weighting, instructions.instruction FROM instruction_habits, instructions WHERE (instruction_habits.fk_instruction = instructions.pk);


ALTER TABLE clin_prescribing.vwinstructionhabits OWNER TO easygp;

--
-- Name: vwprescribedforhabits; Type: VIEW; Schema: clin_prescribing; Owner: easygp
--

CREATE VIEW vwprescribedforhabits AS
    SELECT prescribed_for.prescribed_for, prescribed_for.fk_code, prescribed_for_habits.pk AS pk_prescibed_for_habit, prescribed_for_habits.fk_prescribed_for, prescribed_for_habits.fk_brand, prescribed_for_habits.fk_generic_product, prescribed_for_habits.fk_staff, prescribed_for_habits.weighting FROM prescribed_for, prescribed_for_habits WHERE (prescribed_for_habits.fk_prescribed_for = prescribed_for.pk);


ALTER TABLE clin_prescribing.vwprescribedforhabits OWNER TO easygp;

SET search_path = drugs, pg_catalog;

--
-- Name: form; Type: TABLE; Schema: drugs; Owner: easygp; Tablespace: 
--

CREATE TABLE form (
    pk integer NOT NULL,
    form text NOT NULL,
    volume_amount_required boolean DEFAULT false
);


ALTER TABLE drugs.form OWNER TO easygp;

--
-- Name: restriction; Type: TABLE; Schema: drugs; Owner: easygp; Tablespace: 
--

CREATE TABLE restriction (
    pbscode character varying(10) NOT NULL,
    restriction text NOT NULL,
    restriction_type character(1) DEFAULT '3'::bpchar NOT NULL,
    code character varying(10) NOT NULL,
    streamlined boolean DEFAULT false NOT NULL
);


ALTER TABLE drugs.restriction OWNER TO easygp;

--
-- Name: TABLE restriction; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON TABLE restriction IS 'list of PBS restrictions and authority warnings';


--
-- Name: COLUMN restriction.restriction; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON COLUMN restriction.restriction IS 'the actual text of the authority requirement, in basic HTML';


--
-- Name: COLUMN restriction.restriction_type; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON COLUMN restriction.restriction_type IS '1=only applies to increased quantities/repeats, 2=only to normal amounts, 3=to both';


--
-- Name: COLUMN restriction.code; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON COLUMN restriction.code IS 'the authority code number, for doing streamlined authorities';


--
-- Name: COLUMN restriction.streamlined; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON COLUMN restriction.streamlined IS 'true if this is a "streamlined" Authority';


--
-- Name: schedules; Type: TABLE; Schema: drugs; Owner: easygp; Tablespace: 
--

CREATE TABLE schedules (
    pk integer,
    schedule text
);


ALTER TABLE drugs.schedules OWNER TO easygp;

SET search_path = clin_prescribing, pg_catalog;

--
-- Name: vwprescribeditems; Type: VIEW; Schema: clin_prescribing; Owner: easygp
--

CREATE VIEW vwprescribeditems AS
    SELECT prescribed.pk AS pk_view, medications.pk AS fk_medication, medications.start_date, medications.last_date, medications.active, medications.deleted AS medication_deleted, medications.fk_generic_product, consult.pk AS fk_consult, consult.consult_date AS date_script_written, consult.fk_patient, product.generic, brand.brand, product.strength, brand.product_information_filename, form.form, brand.pk AS fk_brand, prescribed.pk AS fk_prescribed, prescribed.repeats, prescribed.date_on_script, prescribed.quantity, prescribed_for.prescribed_for, prescribed.deleted AS prescribed_deleted, prescribed.authority_reason, prescribed.print_reason, instructions.instruction, vwstaff.wholename AS staff_prescribed_wholename, vwstaff.title AS staff_prescribed_title, product.atccode, product.salt, product.fk_form, product.fk_schedule, product.salt_strength, prescribed.fk_instruction, prescribed.fk_prescribed_for, prescribed.pbscode, prescribed.fk_lu_pbs_script_type, prescribed.restriction_code, prescribed.fk_code, prescribed.reg24, lu_pbs_script_type.type AS pbs_script_type, restriction.streamlined, restriction.restriction, restriction.restriction_type, schedules.schedule, drugs.format_strength(product.strength) AS display_strength, drugs.format_amount(product.amount, product.amount_unit, product.units_per_pack) AS display_packsize, product.units_per_pack FROM (((((((((((clin_consult.consult JOIN admin.vwstaff ON ((consult.fk_staff = vwstaff.fk_staff))) JOIN prescribed ON ((consult.pk = prescribed.fk_consult))) JOIN medications medications ON ((prescribed.fk_medication = medications.pk))) JOIN prescribed_for ON ((prescribed.fk_prescribed_for = prescribed_for.pk))) JOIN instructions ON ((prescribed.fk_instruction = instructions.pk))) JOIN lu_pbs_script_type ON ((prescribed.fk_lu_pbs_script_type = lu_pbs_script_type.pk))) LEFT JOIN drugs.restriction ON (((prescribed.pbscode = (restriction.pbscode)::text) AND (prescribed.restriction_code = (restriction.code)::text)))) LEFT JOIN drugs.brand ON ((prescribed.fk_brand = brand.pk))) JOIN drugs.product ON ((medications.fk_generic_product = product.pk))) LEFT JOIN drugs.schedules ON ((product.fk_schedule = schedules.pk))) JOIN drugs.form ON ((product.fk_form = form.pk)));


ALTER TABLE clin_prescribing.vwprescribeditems OWNER TO easygp;

SET search_path = clin_procedures, pg_catalog;

--
-- Name: link_images_procedures; Type: TABLE; Schema: clin_procedures; Owner: easygp; Tablespace: 
--

CREATE TABLE link_images_procedures (
    pk integer NOT NULL,
    fk_image integer NOT NULL,
    fk_procedure integer NOT NULL,
    deleted boolean DEFAULT false
);


ALTER TABLE clin_procedures.link_images_procedures OWNER TO easygp;

--
-- Name: TABLE link_images_procedures; Type: COMMENT; Schema: clin_procedures; Owner: easygp
--

COMMENT ON TABLE link_images_procedures IS ' links images to a procedure - one to many';


--
-- Name: COLUMN link_images_procedures.fk_image; Type: COMMENT; Schema: clin_procedures; Owner: easygp
--

COMMENT ON COLUMN link_images_procedures.fk_image IS ' key to clin_consult.images table';


--
-- Name: COLUMN link_images_procedures.fk_procedure; Type: COMMENT; Schema: clin_procedures; Owner: easygp
--

COMMENT ON COLUMN link_images_procedures.fk_procedure IS 'ky to a procedure table eg skin_procedures';


--
-- Name: COLUMN link_images_procedures.deleted; Type: COMMENT; Schema: clin_procedures; Owner: easygp
--

COMMENT ON COLUMN link_images_procedures.deleted IS 'if true then the image is marked as deleted';


--
-- Name: link_images_procedures_pk_seq; Type: SEQUENCE; Schema: clin_procedures; Owner: easygp
--

CREATE SEQUENCE link_images_procedures_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_procedures.link_images_procedures_pk_seq OWNER TO easygp;

--
-- Name: link_images_procedures_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_procedures; Owner: easygp
--

ALTER SEQUENCE link_images_procedures_pk_seq OWNED BY link_images_procedures.pk;


--
-- Name: lu_anaesthetic_agent; Type: TABLE; Schema: clin_procedures; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_anaesthetic_agent (
    pk integer NOT NULL,
    agent text NOT NULL,
    fk_lu_route_administration integer NOT NULL
);


ALTER TABLE clin_procedures.lu_anaesthetic_agent OWNER TO easygp;

--
-- Name: COLUMN lu_anaesthetic_agent.fk_lu_route_administration; Type: COMMENT; Schema: clin_procedures; Owner: easygp
--

COMMENT ON COLUMN lu_anaesthetic_agent.fk_lu_route_administration IS 'foreign key to common.lu_route_adminstration e.g sub-cutaneous)';


--
-- Name: lu_anaesthetic_agent_pk_seq; Type: SEQUENCE; Schema: clin_procedures; Owner: easygp
--

CREATE SEQUENCE lu_anaesthetic_agent_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_procedures.lu_anaesthetic_agent_pk_seq OWNER TO easygp;

--
-- Name: lu_anaesthetic_agent_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_procedures; Owner: easygp
--

ALTER SEQUENCE lu_anaesthetic_agent_pk_seq OWNED BY lu_anaesthetic_agent.pk;


--
-- Name: lu_complications; Type: TABLE; Schema: clin_procedures; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_complications (
    pk integer NOT NULL,
    complication text NOT NULL
);


ALTER TABLE clin_procedures.lu_complications OWNER TO easygp;

--
-- Name: lu_complications_pk_seq; Type: SEQUENCE; Schema: clin_procedures; Owner: easygp
--

CREATE SEQUENCE lu_complications_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_procedures.lu_complications_pk_seq OWNER TO easygp;

--
-- Name: lu_complications_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_procedures; Owner: easygp
--

ALTER SEQUENCE lu_complications_pk_seq OWNED BY lu_complications.pk;


--
-- Name: lu_procedure_type; Type: TABLE; Schema: clin_procedures; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_procedure_type (
    pk integer NOT NULL,
    type text NOT NULL
);


ALTER TABLE clin_procedures.lu_procedure_type OWNER TO easygp;

--
-- Name: TABLE lu_procedure_type; Type: COMMENT; Schema: clin_procedures; Owner: easygp
--

COMMENT ON TABLE lu_procedure_type IS 'the type of excision eg ellipse, graft, flap etc';


--
-- Name: lu_excision_type_pk_seq; Type: SEQUENCE; Schema: clin_procedures; Owner: easygp
--

CREATE SEQUENCE lu_excision_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_procedures.lu_excision_type_pk_seq OWNER TO easygp;

--
-- Name: lu_excision_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_procedures; Owner: easygp
--

ALTER SEQUENCE lu_excision_type_pk_seq OWNED BY lu_procedure_type.pk;


--
-- Name: lu_last_surgical_pack; Type: TABLE; Schema: clin_procedures; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_last_surgical_pack (
    pk integer NOT NULL,
    identifier text NOT NULL,
    fk_clinic integer NOT NULL
);


ALTER TABLE clin_procedures.lu_last_surgical_pack OWNER TO easygp;

--
-- Name: TABLE lu_last_surgical_pack; Type: COMMENT; Schema: clin_procedures; Owner: easygp
--

COMMENT ON TABLE lu_last_surgical_pack IS 'the last pack used - probably close to or = to date of one now using';


--
-- Name: lu_pack_pk_seq; Type: SEQUENCE; Schema: clin_procedures; Owner: easygp
--

CREATE SEQUENCE lu_pack_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_procedures.lu_pack_pk_seq OWNER TO easygp;

--
-- Name: lu_pack_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_procedures; Owner: easygp
--

ALTER SEQUENCE lu_pack_pk_seq OWNED BY lu_last_surgical_pack.pk;


--
-- Name: lu_repair_type; Type: TABLE; Schema: clin_procedures; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_repair_type (
    pk integer NOT NULL,
    type text
);


ALTER TABLE clin_procedures.lu_repair_type OWNER TO easygp;

--
-- Name: lu_repair_type_pk_seq; Type: SEQUENCE; Schema: clin_procedures; Owner: easygp
--

CREATE SEQUENCE lu_repair_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_procedures.lu_repair_type_pk_seq OWNER TO easygp;

--
-- Name: lu_repair_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_procedures; Owner: easygp
--

ALTER SEQUENCE lu_repair_type_pk_seq OWNED BY lu_repair_type.pk;


--
-- Name: lu_skin_preparation; Type: TABLE; Schema: clin_procedures; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_skin_preparation (
    pk integer NOT NULL,
    preparation text NOT NULL
);


ALTER TABLE clin_procedures.lu_skin_preparation OWNER TO easygp;

--
-- Name: lu_skin_preparation_pk_seq; Type: SEQUENCE; Schema: clin_procedures; Owner: easygp
--

CREATE SEQUENCE lu_skin_preparation_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_procedures.lu_skin_preparation_pk_seq OWNER TO easygp;

--
-- Name: lu_skin_preparation_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_procedures; Owner: easygp
--

ALTER SEQUENCE lu_skin_preparation_pk_seq OWNED BY lu_skin_preparation.pk;


--
-- Name: lu_suture_site; Type: TABLE; Schema: clin_procedures; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_suture_site (
    pk integer NOT NULL,
    site text
);


ALTER TABLE clin_procedures.lu_suture_site OWNER TO easygp;

--
-- Name: TABLE lu_suture_site; Type: COMMENT; Schema: clin_procedures; Owner: easygp
--

COMMENT ON TABLE lu_suture_site IS 'the site the suture is used eg subcutaneous, skin, sclera, cornea, blood vessel';


--
-- Name: lu_suture_site_pk_seq; Type: SEQUENCE; Schema: clin_procedures; Owner: easygp
--

CREATE SEQUENCE lu_suture_site_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_procedures.lu_suture_site_pk_seq OWNER TO easygp;

--
-- Name: lu_suture_site_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_procedures; Owner: easygp
--

ALTER SEQUENCE lu_suture_site_pk_seq OWNED BY lu_suture_site.pk;


--
-- Name: lu_suture_type; Type: TABLE; Schema: clin_procedures; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_suture_type (
    pk integer NOT NULL,
    brand text NOT NULL,
    fk_lu_site integer
);


ALTER TABLE clin_procedures.lu_suture_type OWNER TO easygp;

--
-- Name: TABLE lu_suture_type; Type: COMMENT; Schema: clin_procedures; Owner: easygp
--

COMMENT ON TABLE lu_suture_type IS 'type of sutures, could extend this table to include ordering of sutures by incrementing the count etc somewhere';


--
-- Name: lu_suture_type_pk_seq; Type: SEQUENCE; Schema: clin_procedures; Owner: easygp
--

CREATE SEQUENCE lu_suture_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_procedures.lu_suture_type_pk_seq OWNER TO easygp;

--
-- Name: lu_suture_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_procedures; Owner: easygp
--

ALTER SEQUENCE lu_suture_type_pk_seq OWNED BY lu_suture_type.pk;


--
-- Name: skin_procedures; Type: TABLE; Schema: clin_procedures; Owner: easygp; Tablespace: 
--

CREATE TABLE skin_procedures (
    pk integer NOT NULL,
    fk_consult integer NOT NULL,
    date date NOT NULL,
    explained_procedure boolean DEFAULT false,
    obtained_consent boolean DEFAULT false,
    detailed_complications boolean DEFAULT false,
    fk_lu_site integer NOT NULL,
    lesion_notes text,
    dermoscopy_notes text,
    fk_lu_lateralisation integer,
    fk_lu_anterior_posterior integer,
    localisation text,
    surgical_pack_identifier text NOT NULL,
    fk_lu_skin_preparation integer,
    fk_lu_anaesthetic_agent integer,
    fk_lu_procedure_type integer,
    fk_lu_repair_type integer,
    fk_subcutaneous_suture integer,
    fk_skin_suture integer,
    average_diameter_cm numeric,
    fk_provisional_diagnosis text,
    fk_document integer,
    fk_actual_diagnosis text,
    referred boolean DEFAULT false,
    review_months integer,
    fk_branch integer,
    fk_form integer,
    complications text,
    fk_progressnote_auto integer,
    fk_pasthistory integer,
    fk_progressnote_user integer
);


ALTER TABLE clin_procedures.skin_procedures OWNER TO easygp;

--
-- Name: TABLE skin_procedures; Type: COMMENT; Schema: clin_procedures; Owner: easygp
--

COMMENT ON TABLE skin_procedures IS 'keeps data for skin procedures';


--
-- Name: COLUMN skin_procedures.fk_consult; Type: COMMENT; Schema: clin_procedures; Owner: easygp
--

COMMENT ON COLUMN skin_procedures.fk_consult IS 'pk of clin_consult.consult table ie links to staff and patient';


--
-- Name: COLUMN skin_procedures.date; Type: COMMENT; Schema: clin_procedures; Owner: easygp
--

COMMENT ON COLUMN skin_procedures.date IS 'date performed may no <> date consult notes written up';


--
-- Name: COLUMN skin_procedures.explained_procedure; Type: COMMENT; Schema: clin_procedures; Owner: easygp
--

COMMENT ON COLUMN skin_procedures.explained_procedure IS 'if true the clinician explained the procedure to the patient';


--
-- Name: COLUMN skin_procedures.obtained_consent; Type: COMMENT; Schema: clin_procedures; Owner: easygp
--

COMMENT ON COLUMN skin_procedures.obtained_consent IS 'if true the clinician obtained consent fo the procedure from the patient';


--
-- Name: COLUMN skin_procedures.detailed_complications; Type: COMMENT; Schema: clin_procedures; Owner: easygp
--

COMMENT ON COLUMN skin_procedures.detailed_complications IS 'if true the clinician detailed the complications of the procedure to the patient';


--
-- Name: COLUMN skin_procedures.fk_lu_site; Type: COMMENT; Schema: clin_procedures; Owner: easygp
--

COMMENT ON COLUMN skin_procedures.fk_lu_site IS 'pk of clin_procedures.lu_site e.g could be the foot';


--
-- Name: COLUMN skin_procedures.lesion_notes; Type: COMMENT; Schema: clin_procedures; Owner: easygp
--

COMMENT ON COLUMN skin_procedures.lesion_notes IS 'clinical notes re this excision';


--
-- Name: COLUMN skin_procedures.dermoscopy_notes; Type: COMMENT; Schema: clin_procedures; Owner: easygp
--

COMMENT ON COLUMN skin_procedures.dermoscopy_notes IS 'clinical notes re this excision';


--
-- Name: COLUMN skin_procedures.fk_lu_lateralisation; Type: COMMENT; Schema: clin_procedures; Owner: easygp
--

COMMENT ON COLUMN skin_procedures.fk_lu_lateralisation IS 'pk of common.lu_lateralisation';


--
-- Name: COLUMN skin_procedures.localisation; Type: COMMENT; Schema: clin_procedures; Owner: easygp
--

COMMENT ON COLUMN skin_procedures.localisation IS 'add notes to localise lesion e.g near scapula or above umbilicus';


--
-- Name: COLUMN skin_procedures.surgical_pack_identifier; Type: COMMENT; Schema: clin_procedures; Owner: easygp
--

COMMENT ON COLUMN skin_procedures.surgical_pack_identifier IS 'pack identifier for surgicalinstrument(s) may be multiple';


--
-- Name: COLUMN skin_procedures.fk_lu_skin_preparation; Type: COMMENT; Schema: clin_procedures; Owner: easygp
--

COMMENT ON COLUMN skin_procedures.fk_lu_skin_preparation IS 'text explaining how skin was prepped';


--
-- Name: COLUMN skin_procedures.fk_lu_procedure_type; Type: COMMENT; Schema: clin_procedures; Owner: easygp
--

COMMENT ON COLUMN skin_procedures.fk_lu_procedure_type IS 'key to clin_procedures.lu_procedure_type table';


--
-- Name: COLUMN skin_procedures.fk_subcutaneous_suture; Type: COMMENT; Schema: clin_procedures; Owner: easygp
--

COMMENT ON COLUMN skin_procedures.fk_subcutaneous_suture IS 'key to clin_procedures.lu_suture_type table';


--
-- Name: COLUMN skin_procedures.fk_skin_suture; Type: COMMENT; Schema: clin_procedures; Owner: easygp
--

COMMENT ON COLUMN skin_procedures.fk_skin_suture IS 'key to clin_procedures.lu_suture_type table';


--
-- Name: COLUMN skin_procedures.fk_provisional_diagnosis; Type: COMMENT; Schema: clin_procedures; Owner: easygp
--

COMMENT ON COLUMN skin_procedures.fk_provisional_diagnosis IS 'key to coding.generic_terms table generic_terms.code
 this field is a string ';


--
-- Name: COLUMN skin_procedures.fk_document; Type: COMMENT; Schema: clin_procedures; Owner: easygp
--

COMMENT ON COLUMN skin_procedures.fk_document IS 'Points to the document which is the result';


--
-- Name: COLUMN skin_procedures.fk_actual_diagnosis; Type: COMMENT; Schema: clin_procedures; Owner: easygp
--

COMMENT ON COLUMN skin_procedures.fk_actual_diagnosis IS 'key to coding.generic_terms table generic_terms.code
 this field is a string ';


--
-- Name: COLUMN skin_procedures.fk_progressnote_auto; Type: COMMENT; Schema: clin_procedures; Owner: easygp
--

COMMENT ON COLUMN skin_procedures.fk_progressnote_auto IS 'Key to clin_consult.progressnotes.

At each excision all the fields the user filled in are used to auto-generate a description of the exision, and this is saved to the progress notes. ';


--
-- Name: COLUMN skin_procedures.fk_pasthistory; Type: COMMENT; Schema: clin_procedures; Owner: easygp
--

COMMENT ON COLUMN skin_procedures.fk_pasthistory IS 'if not null it is the health issue linked to this procedure foreign key to clin_history.past_history';


--
-- Name: COLUMN skin_procedures.fk_progressnote_user; Type: COMMENT; Schema: clin_procedures; Owner: easygp
--

COMMENT ON COLUMN skin_procedures.fk_progressnote_user IS 'Key to clin_consult.progress_notes.

At each exicision, the user can put in free-hand  clinical notes';


--
-- Name: skin_procedures_pk_seq; Type: SEQUENCE; Schema: clin_procedures; Owner: easygp
--

CREATE SEQUENCE skin_procedures_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_procedures.skin_procedures_pk_seq OWNER TO easygp;

--
-- Name: skin_procedures_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_procedures; Owner: easygp
--

ALTER SEQUENCE skin_procedures_pk_seq OWNED BY skin_procedures.pk;


--
-- Name: staff_skin_procedure_defaults; Type: TABLE; Schema: clin_procedures; Owner: easygp; Tablespace: 
--

CREATE TABLE staff_skin_procedure_defaults (
    pk integer NOT NULL,
    fk_staff integer,
    fk_lu_skin_preparation integer,
    fk_lu_anaesthetic_agent integer,
    fk_lu_procedure_type integer,
    fk_lu_repair_type integer,
    fk_subcutaneous_suture integer,
    fk_skin_suture integer,
    fk_user_provider_defaults integer
);


ALTER TABLE clin_procedures.staff_skin_procedure_defaults OWNER TO easygp;

--
-- Name: TABLE staff_skin_procedure_defaults; Type: COMMENT; Schema: clin_procedures; Owner: easygp
--

COMMENT ON TABLE staff_skin_procedure_defaults IS 'The defaults for a staff member for a skin procedure, e.g
	  what type of skin prep, suture materials, who they send pathology
	  to, electronic or paper etc';


--
-- Name: COLUMN staff_skin_procedure_defaults.fk_user_provider_defaults; Type: COMMENT; Schema: clin_procedures; Owner: easygp
--

COMMENT ON COLUMN staff_skin_procedure_defaults.fk_user_provider_defaults IS 'key to clin_requests.user_provider_defaults table which details
	  the default branch, organisation and method of sending pathology';


--
-- Name: staff_skin_procedure_defaults_pk_seq; Type: SEQUENCE; Schema: clin_procedures; Owner: easygp
--

CREATE SEQUENCE staff_skin_procedure_defaults_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_procedures.staff_skin_procedure_defaults_pk_seq OWNER TO easygp;

--
-- Name: staff_skin_procedure_defaults_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_procedures; Owner: easygp
--

ALTER SEQUENCE staff_skin_procedure_defaults_pk_seq OWNED BY staff_skin_procedure_defaults.pk;


--
-- Name: surgical_packs; Type: TABLE; Schema: clin_procedures; Owner: easygp; Tablespace: 
--

CREATE TABLE surgical_packs (
    pk integer NOT NULL,
    identifier text NOT NULL,
    fk_staff integer NOT NULL,
    fk_clinic integer NOT NULL,
    date_sterilised date NOT NULL,
    date_expires date NOT NULL
);


ALTER TABLE clin_procedures.surgical_packs OWNER TO easygp;

--
-- Name: TABLE surgical_packs; Type: COMMENT; Schema: clin_procedures; Owner: easygp
--

COMMENT ON TABLE surgical_packs IS 'info about each surgical pack sterilized';


--
-- Name: surgical_packs_pk_seq; Type: SEQUENCE; Schema: clin_procedures; Owner: easygp
--

CREATE SEQUENCE surgical_packs_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_procedures.surgical_packs_pk_seq OWNER TO easygp;

--
-- Name: surgical_packs_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_procedures; Owner: easygp
--

ALTER SEQUENCE surgical_packs_pk_seq OWNED BY surgical_packs.pk;


--
-- Name: vwimages; Type: VIEW; Schema: clin_procedures; Owner: easygp
--

CREATE VIEW vwimages AS
    SELECT images.image, images.md5sum, images.tag, images.deleted AS image_deleted, images.fk_consult AS fk_consult_image, link_images_procedures.fk_image, link_images_procedures.fk_procedure, link_images_procedures.deleted, link_images_procedures.pk AS pk_link_images_procedures FROM (link_images_procedures JOIN blobs.images ON ((link_images_procedures.fk_image = images.pk))) WHERE (link_images_procedures.deleted = false) ORDER BY link_images_procedures.fk_procedure;


ALTER TABLE clin_procedures.vwimages OWNER TO easygp;

SET search_path = clin_requests, pg_catalog;

--
-- Name: forms; Type: TABLE; Schema: clin_requests; Owner: easygp; Tablespace: 
--

CREATE TABLE forms (
    pk integer NOT NULL,
    fk_consult integer NOT NULL,
    date date,
    fk_request_provider integer NOT NULL,
    fk_lu_request_type integer NOT NULL,
    requests_summary text NOT NULL,
    notes_summary text,
    medications_summary text,
    copyto text,
    deleted boolean DEFAULT false,
    copyto_patient boolean DEFAULT false,
    urgent boolean DEFAULT false,
    bulk_bill boolean DEFAULT false,
    fasting boolean DEFAULT false,
    phone boolean DEFAULT false,
    fax boolean DEFAULT false,
    include_medications boolean DEFAULT false,
    pk_image integer,
    fk_progressnote integer,
    fk_pasthistory integer,
    latex text
);


ALTER TABLE clin_requests.forms OWNER TO easygp;

--
-- Name: TABLE forms; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON TABLE forms IS 'Links a form to a consult(hence the patient/date), organisation, type of request, notes, etc';


--
-- Name: COLUMN forms.fk_consult; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON COLUMN forms.fk_consult IS 'foreign key to clin_consult.consult table';


--
-- Name: COLUMN forms.date; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON COLUMN forms.date IS 'the date printed on request form. May not be
same as consult_date, for instance, if dated in the future';


--
-- Name: COLUMN forms.fk_request_provider; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON COLUMN forms.fk_request_provider IS 'foreign key to contacts.data_branches table points to organisation service is requested of, the branch address, all comms for the organisation, branch etc
FIXME - BAD NAME, MIXED UP NOMENCLATURE';


--
-- Name: COLUMN forms.fk_lu_request_type; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON COLUMN forms.fk_lu_request_type IS 'foreign key to clin_requests.lu_type table e.g 1= pathology';


--
-- Name: COLUMN forms.requests_summary; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON COLUMN forms.requests_summary IS ' delimited ; summary of requests eg fbc;esr;msu;lfts;';


--
-- Name: COLUMN forms.notes_summary; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON COLUMN forms.notes_summary IS ' delimited ; summary of clinicalnotes eg tiredness;weight loss;';


--
-- Name: COLUMN forms.medications_summary; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON COLUMN forms.medications_summary IS ' delimited ; summary of medications eg ranitidine;simvastatin';


--
-- Name: COLUMN forms.deleted; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON COLUMN forms.deleted IS 'if true the the request form as been deleted';


--
-- Name: COLUMN forms.fk_pasthistory; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON COLUMN forms.fk_pasthistory IS 'if not null it is the health issue linked to this request form -  foreign key to clin_history.past_history';


--
-- Name: COLUMN forms.latex; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON COLUMN forms.latex IS 'the actually LaTex of the form as printed currently the field has no default as all 
  my old forms won''t have any LaTex';


SET search_path = common, pg_catalog;

--
-- Name: lu_anatomical_site; Type: TABLE; Schema: common; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_anatomical_site (
    pk integer NOT NULL,
    site text NOT NULL
);


ALTER TABLE common.lu_anatomical_site OWNER TO easygp;

--
-- Name: lu_anterior_posterior; Type: TABLE; Schema: common; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_anterior_posterior (
    pk integer NOT NULL,
    anterior_posterior text
);


ALTER TABLE common.lu_anterior_posterior OWNER TO easygp;

SET search_path = clin_procedures, pg_catalog;

--
-- Name: vwskinprocedures; Type: VIEW; Schema: clin_procedures; Owner: easygp
--

CREATE VIEW vwskinprocedures AS
    SELECT skin_procedures.pk AS pk_view, skin_procedures.pk AS fk_skin_procedure, skin_procedures.fk_consult, skin_procedures.date, skin_procedures.explained_procedure, skin_procedures.obtained_consent, skin_procedures.detailed_complications, skin_procedures.fk_lu_site, skin_procedures.lesion_notes, skin_procedures.dermoscopy_notes, skin_procedures.fk_lu_lateralisation, skin_procedures.fk_lu_anterior_posterior, skin_procedures.localisation, skin_procedures.surgical_pack_identifier, skin_procedures.fk_lu_skin_preparation, skin_procedures.fk_lu_anaesthetic_agent, skin_procedures.fk_lu_procedure_type, skin_procedures.fk_lu_repair_type, skin_procedures.fk_subcutaneous_suture, skin_procedures.fk_skin_suture, skin_procedures.average_diameter_cm, skin_procedures.fk_provisional_diagnosis, generic_terms.term AS provisional_diagnosis, skin_procedures.fk_document, skin_procedures.fk_actual_diagnosis, generic_terms1.term AS actual_diagnosis, skin_procedures.fk_pasthistory, skin_procedures.referred, skin_procedures.review_months, skin_procedures.fk_branch, skin_procedures.fk_form, skin_procedures.complications, skin_procedures.fk_progressnote_auto, progressnotes.notes AS progressnote_auto, skin_procedures.fk_progressnote_user, progressnotes1.notes AS progressnote_user, consult.consult_date, consult.fk_staff, consult.fk_patient, lu_anatomical_site.site, lu_anterior_posterior.anterior_posterior, lu_laterality.laterality, lu_skin_preparation.preparation, lu_anaesthetic_agent.agent, lu_anaesthetic_agent.fk_lu_route_administration, lu_procedure_type.type AS procedure_type, lu_repair_type.type AS repair_type, lu_suture_type.brand AS skin_suture, lu_suture_type1.brand AS subcutaneous_suture, data_organisations.organisation, vwstaff.wholename, vwstaff.title FROM ((((((((((((((((((skin_procedures JOIN clin_consult.consult ON ((skin_procedures.fk_consult = consult.pk))) JOIN common.lu_anatomical_site ON ((skin_procedures.fk_lu_site = lu_anatomical_site.pk))) LEFT JOIN common.lu_anterior_posterior ON ((skin_procedures.fk_lu_anterior_posterior = lu_anterior_posterior.pk))) LEFT JOIN common.lu_laterality ON ((skin_procedures.fk_lu_lateralisation = lu_laterality.pk))) LEFT JOIN lu_skin_preparation ON ((skin_procedures.fk_lu_skin_preparation = lu_skin_preparation.pk))) LEFT JOIN coding.generic_terms ON ((skin_procedures.fk_provisional_diagnosis = generic_terms.code))) JOIN lu_anaesthetic_agent ON ((skin_procedures.fk_lu_anaesthetic_agent = lu_anaesthetic_agent.pk))) JOIN lu_procedure_type ON ((skin_procedures.fk_lu_procedure_type = lu_procedure_type.pk))) JOIN lu_repair_type ON ((skin_procedures.fk_lu_repair_type = lu_repair_type.pk))) JOIN lu_suture_type ON ((skin_procedures.fk_skin_suture = lu_suture_type.pk))) JOIN lu_suture_type lu_suture_type1 ON ((skin_procedures.fk_subcutaneous_suture = lu_suture_type1.pk))) LEFT JOIN coding.generic_terms generic_terms1 ON ((skin_procedures.fk_actual_diagnosis = generic_terms1.code))) LEFT JOIN contacts.data_branches ON ((skin_procedures.fk_branch = data_branches.pk))) LEFT JOIN clin_requests.forms ON ((skin_procedures.fk_form = forms.pk))) LEFT JOIN clin_consult.progressnotes progressnotes1 ON ((skin_procedures.fk_progressnote_user = progressnotes1.pk))) JOIN clin_consult.progressnotes ON ((skin_procedures.fk_progressnote_auto = progressnotes.pk))) JOIN contacts.data_organisations ON ((data_branches.fk_organisation = data_organisations.pk))) JOIN admin.vwstaff ON ((consult.fk_staff = vwstaff.fk_staff)));


ALTER TABLE clin_procedures.vwskinprocedures OWNER TO easygp;

--
-- Name: vwstaffskinproceduredefaults; Type: VIEW; Schema: clin_procedures; Owner: easygp
--

CREATE VIEW vwstaffskinproceduredefaults AS
    SELECT lu_anaesthetic_agent.agent, lu_skin_preparation.preparation, staff_skin_procedure_defaults.pk AS pk_default, staff_skin_procedure_defaults.fk_staff, staff_skin_procedure_defaults.fk_lu_skin_preparation, staff_skin_procedure_defaults.fk_lu_anaesthetic_agent, staff_skin_procedure_defaults.fk_lu_procedure_type, staff_skin_procedure_defaults.fk_lu_repair_type, staff_skin_procedure_defaults.fk_subcutaneous_suture, staff_skin_procedure_defaults.fk_skin_suture, staff_skin_procedure_defaults.fk_user_provider_defaults, lu_suture_type.brand AS skin_suture, lu_suture_type1.brand AS subcutaneous_suture, lu_procedure_type.type AS procedure_type, lu_repair_type.type AS repair_type FROM ((((((staff_skin_procedure_defaults JOIN lu_anaesthetic_agent ON ((staff_skin_procedure_defaults.fk_lu_anaesthetic_agent = lu_anaesthetic_agent.pk))) JOIN lu_skin_preparation ON ((staff_skin_procedure_defaults.fk_lu_skin_preparation = lu_skin_preparation.pk))) JOIN lu_suture_type ON ((staff_skin_procedure_defaults.fk_skin_suture = lu_suture_type.pk))) JOIN lu_suture_type lu_suture_type1 ON ((staff_skin_procedure_defaults.fk_subcutaneous_suture = lu_suture_type1.pk))) JOIN lu_procedure_type ON ((staff_skin_procedure_defaults.fk_lu_procedure_type = lu_procedure_type.pk))) JOIN lu_repair_type ON ((staff_skin_procedure_defaults.fk_lu_repair_type = lu_repair_type.pk))) ORDER BY staff_skin_procedure_defaults.fk_staff;


ALTER TABLE clin_procedures.vwstaffskinproceduredefaults OWNER TO easygp;

--
-- Name: vwsutures; Type: VIEW; Schema: clin_procedures; Owner: easygp
--

CREATE VIEW vwsutures AS
    SELECT lu_suture_type.pk, lu_suture_type.brand, lu_suture_type.fk_lu_site, lu_suture_site.site FROM (lu_suture_type JOIN lu_suture_site ON ((lu_suture_type.fk_lu_site = lu_suture_site.pk))) ORDER BY lu_suture_site.site, lu_suture_type.brand;


ALTER TABLE clin_procedures.vwsutures OWNER TO easygp;

SET search_path = clin_recalls, pg_catalog;

--
-- Name: forms; Type: TABLE; Schema: clin_recalls; Owner: easygp; Tablespace: 
--

CREATE TABLE forms (
    pk integer NOT NULL,
    form text
);


ALTER TABLE clin_recalls.forms OWNER TO easygp;

--
-- Name: TABLE forms; Type: COMMENT; Schema: clin_recalls; Owner: easygp
--

COMMENT ON TABLE forms IS 'embryonic table, will contain all data to create form, for now just a dummy text column';


--
-- Name: forms_pk_seq; Type: SEQUENCE; Schema: clin_recalls; Owner: easygp
--

CREATE SEQUENCE forms_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_recalls.forms_pk_seq OWNER TO easygp;

--
-- Name: forms_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_recalls; Owner: easygp
--

ALTER SEQUENCE forms_pk_seq OWNED BY forms.pk;


--
-- Name: links_forms; Type: TABLE; Schema: clin_recalls; Owner: easygp; Tablespace: 
--

CREATE TABLE links_forms (
    pk integer NOT NULL,
    fk_recall integer NOT NULL,
    fk_form integer NOT NULL
);


ALTER TABLE clin_recalls.links_forms OWNER TO easygp;

--
-- Name: TABLE links_forms; Type: COMMENT; Schema: clin_recalls; Owner: easygp
--

COMMENT ON TABLE links_forms IS 'links a particular recall to one or more forms to include when patient recalled';


--
-- Name: COLUMN links_forms.fk_recall; Type: COMMENT; Schema: clin_recalls; Owner: easygp
--

COMMENT ON COLUMN links_forms.fk_recall IS 'foreign key to data_recalls table';


--
-- Name: COLUMN links_forms.fk_form; Type: COMMENT; Schema: clin_recalls; Owner: easygp
--

COMMENT ON COLUMN links_forms.fk_form IS 'foreign key to forms table';


--
-- Name: links_forms_pk_seq; Type: SEQUENCE; Schema: clin_recalls; Owner: easygp
--

CREATE SEQUENCE links_forms_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_recalls.links_forms_pk_seq OWNER TO easygp;

--
-- Name: links_forms_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_recalls; Owner: easygp
--

ALTER SEQUENCE links_forms_pk_seq OWNED BY links_forms.pk;


--
-- Name: lu_reasons_pk_seq; Type: SEQUENCE; Schema: clin_recalls; Owner: easygp
--

CREATE SEQUENCE lu_reasons_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_recalls.lu_reasons_pk_seq OWNER TO easygp;

--
-- Name: lu_reasons_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_recalls; Owner: easygp
--

ALTER SEQUENCE lu_reasons_pk_seq OWNED BY lu_reasons.pk;


--
-- Name: lu_recall_intervals_pk_seq; Type: SEQUENCE; Schema: clin_recalls; Owner: easygp
--

CREATE SEQUENCE lu_recall_intervals_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_recalls.lu_recall_intervals_pk_seq OWNER TO easygp;

--
-- Name: lu_recall_intervals_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_recalls; Owner: easygp
--

ALTER SEQUENCE lu_recall_intervals_pk_seq OWNED BY lu_recall_intervals.pk;


--
-- Name: lu_templates_pk_seq; Type: SEQUENCE; Schema: clin_recalls; Owner: easygp
--

CREATE SEQUENCE lu_templates_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_recalls.lu_templates_pk_seq OWNER TO easygp;

--
-- Name: lu_templates_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_recalls; Owner: easygp
--

ALTER SEQUENCE lu_templates_pk_seq OWNED BY lu_templates.pk;


--
-- Name: recalls_pk_seq; Type: SEQUENCE; Schema: clin_recalls; Owner: easygp
--

CREATE SEQUENCE recalls_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_recalls.recalls_pk_seq OWNER TO easygp;

--
-- Name: recalls_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_recalls; Owner: easygp
--

ALTER SEQUENCE recalls_pk_seq OWNED BY recalls.pk;


--
-- Name: sent_pk_seq; Type: SEQUENCE; Schema: clin_recalls; Owner: easygp
--

CREATE SEQUENCE sent_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_recalls.sent_pk_seq OWNER TO easygp;

--
-- Name: sent_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_recalls; Owner: easygp
--

ALTER SEQUENCE sent_pk_seq OWNED BY sent.pk;


--
-- Name: vwreasons; Type: VIEW; Schema: clin_recalls; Owner: easygp
--

CREATE VIEW vwreasons AS
    SELECT lu_reasons.pk AS pk_reason, lu_reasons.reason, lu_recall_intervals.fk_staff, lu_recall_intervals.pk AS fk_lu_recall_intervals, lu_recall_intervals."interval", lu_units.abbrev_text, lu_units.full_text, lu_recall_intervals.fk_interval_unit FROM ((lu_recall_intervals JOIN common.lu_units ON ((lu_recall_intervals.fk_interval_unit = lu_units.pk))) JOIN lu_reasons ON ((lu_recall_intervals.fk_reason = lu_reasons.pk))) ORDER BY lu_reasons.reason;


ALTER TABLE clin_recalls.vwreasons OWNER TO easygp;

--
-- Name: vwrecallsdue; Type: VIEW; Schema: clin_recalls; Owner: easygp
--

CREATE VIEW vwrecallsdue AS
    SELECT recalls.pk AS pk_recall, recalls.fk_consult, recalls.due, (recalls.due - date(now())) AS days_due, recalls.fk_reason, recalls.fk_contact_method, recalls.fk_urgency, recalls.fk_appointment_length, recalls.fk_staff, recalls.active, recalls.additional_text, recalls.deleted, recalls."interval", recalls.fk_interval_unit, recalls.fk_progressnote, recalls.fk_pasthistory, recalls.fk_sent, recalls.num_reminders, sent.latex, sent.date AS date_reminder_sent, lu_units.abbrev_text, vwpatients.fk_person, vwpatients.wholename, vwpatients.firstname, vwpatients.surname, vwpatients.salutation, vwpatients.birthdate, vwpatients.age_numeric, vwpatients.sex, vwpatients.title, vwpatients.street1, vwpatients.street2, vwpatients.town, vwpatients.state, vwpatients.postcode, vwpatients.language_problems, vwpatients.language, consult.fk_patient, vwstaff.firstname AS staff_to_see_firstname, vwstaff.surname AS staff_to_see_surname, vwstaff.wholename AS staff_to_see_wholename, vwstaff.title AS staff_to_see_title, lu_reasons.reason, lu_urgency.urgency, lu_contact_type.type AS contact_method, lu_appointment_length.length AS appointment_length, consult.consult_date, recalls.fk_template, lu_appointment_length1.length, lu_templates.name, lu_templates.template FROM (((((((((((recalls JOIN clin_consult.consult ON ((recalls.fk_consult = consult.pk))) JOIN contacts.vwpatients ON ((consult.fk_patient = vwpatients.fk_patient))) JOIN admin.vwstaff ON ((recalls.fk_staff = vwstaff.fk_staff))) JOIN lu_reasons ON ((recalls.fk_reason = lu_reasons.pk))) JOIN common.lu_urgency ON ((recalls.fk_urgency = lu_urgency.pk))) JOIN contacts.lu_contact_type ON ((recalls.fk_contact_method = lu_contact_type.pk))) JOIN common.lu_appointment_length ON ((recalls.fk_appointment_length = lu_appointment_length.pk))) LEFT JOIN common.lu_units ON ((recalls.fk_interval_unit = lu_units.pk))) LEFT JOIN lu_templates ON ((recalls.fk_template = lu_templates.pk))) LEFT JOIN common.lu_appointment_length lu_appointment_length1 ON ((lu_templates.fk_lu_appointment_length = lu_appointment_length1.pk))) LEFT JOIN sent ON ((recalls.fk_sent = sent.pk))) WHERE (recalls.deleted = false) ORDER BY (recalls.due - date(now())), consult.fk_patient;


ALTER TABLE clin_recalls.vwrecallsdue OWNER TO easygp;

--
-- Name: vwtemplates; Type: VIEW; Schema: clin_recalls; Owner: easygp
--

CREATE VIEW vwtemplates AS
    SELECT lu_templates.pk, lu_templates.name, lu_templates.deleted, lu_templates.template, lu_templates.fk_lu_appointment_length, lu_appointment_length.length FROM lu_templates, common.lu_appointment_length WHERE ((lu_templates.fk_lu_appointment_length = lu_appointment_length.pk) AND (lu_templates.template <> ''::text));


ALTER TABLE clin_recalls.vwtemplates OWNER TO easygp;

SET search_path = clin_referrals, pg_catalog;

--
-- Name: inclusions; Type: TABLE; Schema: clin_referrals; Owner: easygp; Tablespace: 
--

CREATE TABLE inclusions (
    pk integer NOT NULL,
    fk_referral integer NOT NULL,
    fk_document integer NOT NULL,
    deleted boolean DEFAULT false
);


ALTER TABLE clin_referrals.inclusions OWNER TO easygp;

--
-- Name: TABLE inclusions; Type: COMMENT; Schema: clin_referrals; Owner: easygp
--

COMMENT ON TABLE inclusions IS 'A Table describing which documents went out with the referral';


--
-- Name: COLUMN inclusions.deleted; Type: COMMENT; Schema: clin_referrals; Owner: easygp
--

COMMENT ON COLUMN inclusions.deleted IS 'if deleted is true then the inclusion is marked as deleted and
 for example will not be sent out if the document is later re-printed';


--
-- Name: inclusions_pk_seq; Type: SEQUENCE; Schema: clin_referrals; Owner: easygp
--

CREATE SEQUENCE inclusions_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_referrals.inclusions_pk_seq OWNER TO easygp;

--
-- Name: inclusions_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_referrals; Owner: easygp
--

ALTER SEQUENCE inclusions_pk_seq OWNED BY inclusions.pk;


--
-- Name: lu_type; Type: TABLE; Schema: clin_referrals; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_type (
    pk integer NOT NULL,
    type text NOT NULL,
    display boolean DEFAULT true
);


ALTER TABLE clin_referrals.lu_type OWNER TO easygp;

--
-- Name: TABLE lu_type; Type: COMMENT; Schema: clin_referrals; Owner: easygp
--

COMMENT ON TABLE lu_type IS 'List of types of referral eg required by medicare so could be
  opinion
  ongoing management
  indefinate referral etc';


--
-- Name: COLUMN lu_type.display; Type: COMMENT; Schema: clin_referrals; Owner: easygp
--

COMMENT ON COLUMN lu_type.display IS 'when true, the column will be available on the combo list in the referral''s gui';


--
-- Name: lu_type_pk_seq; Type: SEQUENCE; Schema: clin_referrals; Owner: easygp
--

CREATE SEQUENCE lu_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_referrals.lu_type_pk_seq OWNER TO easygp;

--
-- Name: lu_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_referrals; Owner: easygp
--

ALTER SEQUENCE lu_type_pk_seq OWNED BY lu_type.pk;


--
-- Name: lu_urgency; Type: TABLE; Schema: clin_referrals; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_urgency (
    pk integer NOT NULL,
    urgency text NOT NULL
);


ALTER TABLE clin_referrals.lu_urgency OWNER TO easygp;

--
-- Name: lu_urgency_pk_seq; Type: SEQUENCE; Schema: clin_referrals; Owner: easygp
--

CREATE SEQUENCE lu_urgency_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_referrals.lu_urgency_pk_seq OWNER TO easygp;

--
-- Name: lu_urgency_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_referrals; Owner: easygp
--

ALTER SEQUENCE lu_urgency_pk_seq OWNED BY lu_urgency.pk;


--
-- Name: referrals_pk_seq; Type: SEQUENCE; Schema: clin_referrals; Owner: easygp
--

CREATE SEQUENCE referrals_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_referrals.referrals_pk_seq OWNER TO easygp;

--
-- Name: referrals_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_referrals; Owner: easygp
--

ALTER SEQUENCE referrals_pk_seq OWNED BY referrals.pk;


SET search_path = documents, pg_catalog;

--
-- Name: documents; Type: TABLE; Schema: documents; Owner: easygp; Tablespace: 
--

CREATE TABLE documents (
    pk integer NOT NULL,
    source_file text,
    fk_sending_entity integer NOT NULL,
    imported_time timestamp without time zone DEFAULT now() NOT NULL,
    date_requested date,
    date_created date,
    fk_patient integer,
    fk_staff_filed_document integer,
    originator text,
    originator_reference text,
    provider_of_service_reference text,
    internal_reference text,
    copies_to text,
    fk_staff_destination integer,
    comment_on_document text,
    patient_access boolean DEFAULT false,
    concluded boolean DEFAULT false,
    deleted boolean DEFAULT false,
    fk_lu_urgency integer,
    tag text,
    md5sum text,
    fk_unmatched_staff integer,
    fk_unmatched_patient integer,
    fk_referral integer,
    fk_request integer,
    html text,
    tag_user text,
    copy_to text,
    staff_intended_for_unknown boolean DEFAULT false,
    fk_lu_display_as integer,
    fk_lu_request_type integer,
    incoming_referral boolean DEFAULT false NOT NULL
);


ALTER TABLE documents.documents OWNER TO easygp;

--
-- Name: COLUMN documents.source_file; Type: COMMENT; Schema: documents; Owner: easygp
--

COMMENT ON COLUMN documents.source_file IS 'the source filename of the document pdf, jpeg etc on the file server, may be 1:1 or the document contents may have been part of a file eg hl7';


--
-- Name: COLUMN documents.date_created; Type: COMMENT; Schema: documents; Owner: easygp
--

COMMENT ON COLUMN documents.date_created IS 'date the document was created - ie the document was created or  the observation collected e.g blood';


--
-- Name: COLUMN documents.fk_staff_filed_document; Type: COMMENT; Schema: documents; Owner: easygp
--

COMMENT ON COLUMN documents.fk_staff_filed_document IS 'key to admin.staff table - who filed the document, may be null if auto-filed eg by the hl7 parser';


--
-- Name: COLUMN documents.copies_to; Type: COMMENT; Schema: documents; Owner: easygp
--

COMMENT ON COLUMN documents.copies_to IS 'Whoever gets a copy of the document - flaw should be keyed for multiple';


--
-- Name: COLUMN documents.fk_staff_destination; Type: COMMENT; Schema: documents; Owner: easygp
--

COMMENT ON COLUMN documents.fk_staff_destination IS 'if null, then documented sent to everyones inbox';


--
-- Name: COLUMN documents.comment_on_document; Type: COMMENT; Schema: documents; Owner: easygp
--

COMMENT ON COLUMN documents.comment_on_document IS 'additional comment e.g NAD etc';


--
-- Name: COLUMN documents.fk_referral; Type: COMMENT; Schema: documents; Owner: easygp
--

COMMENT ON COLUMN documents.fk_referral IS 'If not null, linkt the document e.g incoming letter from specialist to a referral letter written
  to the specialist in the first place. That way, all correspondance for a particular referral
  and health issues (as referrals are linked to health issues) can be shown';


--
-- Name: COLUMN documents.fk_request; Type: COMMENT; Schema: documents; Owner: easygp
--

COMMENT ON COLUMN documents.fk_request IS 'If not null, links the document e.g incoming result form a path lab
  to a particular request on a particular form. This is the fk to clin_requests.forms_requests table';


--
-- Name: COLUMN documents.html; Type: COMMENT; Schema: documents; Owner: easygp
--

COMMENT ON COLUMN documents.html IS 'maybe temporary, but as most of the documents are html results, I have included this field';


--
-- Name: COLUMN documents.staff_intended_for_unknown; Type: COMMENT; Schema: documents; Owner: easygp
--

COMMENT ON COLUMN documents.staff_intended_for_unknown IS 'Sometimes despite all efforts it is not possible to determine from the hl7 who the message was
 intended for. In this situation EasyGP has a default staff member who is allocated the
 orphaned messages. If so, then this field will be true
 If this is sorted out, then this field will be re-set to false the fk_staff_destination set
 to the correct fk_staff, however these changes will be logged';


--
-- Name: COLUMN documents.fk_lu_display_as; Type: COMMENT; Schema: documents; Owner: easygp
--

COMMENT ON COLUMN documents.fk_lu_display_as IS 'How to display the document 1 as a result 2 as a letter';


--
-- Name: COLUMN documents.fk_lu_request_type; Type: COMMENT; Schema: documents; Owner: easygp
--

COMMENT ON COLUMN documents.fk_lu_request_type IS ' - key to clin_requests.lu_request_type table which contains the types
    of requests e.g Pathology Radiology Vascular. 
  - note this field over-rides the 
   fk_lu_request_type of a given documents.sending_entities.fk_lu_request_type
   which is there to aid FDocumentMetadata guess the likely type of request for
   a given sender of messages, but may not be correct all the time';


SET search_path = clin_referrals, pg_catalog;

--
-- Name: vwinclusions; Type: VIEW; Schema: clin_referrals; Owner: easygp
--

CREATE VIEW vwinclusions AS
    SELECT DISTINCT inclusions.pk AS pk_inclusion, inclusions.fk_referral, inclusions.fk_document, inclusions.deleted, consult.consult_date, consult.fk_patient, documents.date_created, documents.tag_user FROM (((clin_consult.consult JOIN referrals ON ((referrals.fk_consult = consult.pk))) JOIN inclusions ON ((referrals.pk = inclusions.fk_referral))) JOIN documents.documents ON ((inclusions.fk_document = documents.pk))) ORDER BY consult.fk_patient;


ALTER TABLE clin_referrals.vwinclusions OWNER TO easygp;

--
-- Name: vwreferrals; Type: VIEW; Schema: clin_referrals; Owner: easygp
--

CREATE VIEW vwreferrals AS
    (SELECT DISTINCT referrals.pk AS pk_referral, referrals.date_referral, referrals.fk_consult, referrals.fk_person, referrals.fk_type, lu_type.type, referrals.tag, referrals.deleted, referrals.body_html, referrals.letter_html, referrals.letter_hl7, referrals.fk_pasthistory, referrals.fk_progressnote, referrals.include_careplan, referrals.include_healthsummary, referrals.fk_branch, referrals.fk_employee, referrals.fk_address, referrals.copyto, referrals.fk_lu_urgency, referrals.finalised, lu_urgency.urgency, vworganisationsemployees.street1, vworganisationsemployees.street2, vworganisationsemployees.town, vworganisationsemployees.state, vworganisationsemployees.postcode, vworganisationsemployees.organisation, vworganisationsemployees.branch, vworganisationsemployees.wholename, vworganisationsemployees.occupation, vworganisationsemployees.firstname, vworganisationsemployees.surname, vworganisationsemployees.salutation, vworganisationsemployees.sex, vworganisationsemployees.title, consult.consult_date, consult.fk_patient, consult.fk_staff, vwstaff.firstname AS staff_firstname, vwstaff.wholename AS staff_wholename, vwstaff.salutation AS staff_salutation, vwstaff.title AS staff_title, past_history.description, vworganisationsemployees.provider_number AS contact_provider_number FROM ((((((referrals JOIN contacts.vworganisationsemployees ON (((referrals.fk_employee = vworganisationsemployees.fk_employee) AND (referrals.fk_branch = vworganisationsemployees.fk_branch)))) JOIN clin_consult.consult ON ((referrals.fk_consult = consult.pk))) JOIN admin.vwstaff ON ((consult.fk_staff = vwstaff.fk_staff))) JOIN lu_type ON ((referrals.fk_type = lu_type.pk))) LEFT JOIN clin_history.past_history ON ((referrals.fk_pasthistory = past_history.pk))) JOIN lu_urgency ON ((referrals.fk_lu_urgency = lu_urgency.pk))) UNION SELECT DISTINCT referrals.pk AS pk_referral, referrals.date_referral, referrals.fk_consult, referrals.fk_person, referrals.fk_type, lu_type.type, referrals.tag, referrals.deleted, referrals.body_html, referrals.letter_html, referrals.letter_hl7, referrals.fk_pasthistory, referrals.fk_progressnote, referrals.include_careplan, referrals.include_healthsummary, referrals.fk_branch, referrals.fk_employee, referrals.fk_address, referrals.copyto, referrals.fk_lu_urgency, referrals.finalised, lu_urgency.urgency, vwpersonsincludingpatients.street1, vwpersonsincludingpatients.street2, vwpersonsincludingpatients.town, vwpersonsincludingpatients.state, vwpersonsincludingpatients.postcode, NULL::text AS organisation, NULL::text AS branch, vwpersonsincludingpatients.wholename, NULL::text AS occupation, vwpersonsincludingpatients.firstname, vwpersonsincludingpatients.surname, vwpersonsincludingpatients.salutation, vwpersonsincludingpatients.sex, vwpersonsincludingpatients.title, consult.consult_date, consult.fk_patient, consult.fk_staff, vwstaff.firstname AS staff_firstname, vwstaff.wholename AS staff_wholename, vwstaff.salutation AS staff_salutation, vwstaff.title AS staff_title, past_history.description, NULL::text AS contact_provider_number FROM ((((((referrals LEFT JOIN contacts.vwpersonsincludingpatients ON (((referrals.fk_person = vwpersonsincludingpatients.fk_person) AND (referrals.fk_address = vwpersonsincludingpatients.fk_address)))) JOIN clin_consult.consult ON ((referrals.fk_consult = consult.pk))) JOIN admin.vwstaff ON ((consult.fk_staff = vwstaff.fk_staff))) JOIN lu_type ON ((referrals.fk_type = lu_type.pk))) LEFT JOIN clin_history.past_history ON ((referrals.fk_pasthistory = past_history.pk))) JOIN lu_urgency ON ((referrals.fk_lu_urgency = lu_urgency.pk))) WHERE ((referrals.fk_branch IS NULL) AND (referrals.fk_employee IS NULL))) UNION SELECT DISTINCT referrals.pk AS pk_referral, referrals.date_referral, referrals.fk_consult, referrals.fk_person, referrals.fk_type, lu_type.type, referrals.tag, referrals.deleted, referrals.body_html, referrals.letter_html, referrals.letter_hl7, referrals.fk_pasthistory, referrals.fk_progressnote, referrals.include_careplan, referrals.include_healthsummary, referrals.fk_branch, referrals.fk_employee, referrals.fk_address, referrals.copyto, referrals.fk_lu_urgency, referrals.finalised, lu_urgency.urgency, vworganisationsemployees.street1, vworganisationsemployees.street2, vworganisationsemployees.town, vworganisationsemployees.state, vworganisationsemployees.postcode, vworganisationsemployees.organisation, vworganisationsemployees.branch, NULL::text AS wholename, NULL::text AS occupation, NULL::text AS firstname, NULL::text AS surname, NULL::text AS salutation, NULL::text AS sex, NULL::text AS title, consult.consult_date, consult.fk_patient, consult.fk_staff, vwstaff.firstname AS staff_firstname, vwstaff.wholename AS staff_wholename, vwstaff.salutation AS staff_salutation, vwstaff.title AS staff_title, past_history.description, NULL::text AS contact_provider_number FROM ((((((referrals JOIN contacts.vworganisationsemployees ON ((referrals.fk_branch = vworganisationsemployees.fk_branch))) JOIN clin_consult.consult ON ((referrals.fk_consult = consult.pk))) JOIN admin.vwstaff ON ((consult.fk_staff = vwstaff.fk_staff))) JOIN lu_type ON ((referrals.fk_type = lu_type.pk))) JOIN lu_urgency ON ((referrals.fk_lu_urgency = lu_urgency.pk))) LEFT JOIN clin_history.past_history ON ((referrals.fk_pasthistory = past_history.pk))) WHERE (referrals.fk_person IS NULL);


ALTER TABLE clin_referrals.vwreferrals OWNER TO easygp;

SET search_path = clin_requests, pg_catalog;

--
-- Name: forms_pk_seq; Type: SEQUENCE; Schema: clin_requests; Owner: easygp
--

CREATE SEQUENCE forms_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_requests.forms_pk_seq OWNER TO easygp;

--
-- Name: forms_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_requests; Owner: easygp
--

ALTER SEQUENCE forms_pk_seq OWNED BY forms.pk;


--
-- Name: forms_requests; Type: TABLE; Schema: clin_requests; Owner: easygp; Tablespace: 
--

CREATE TABLE forms_requests (
    pk integer NOT NULL,
    fk_form integer,
    fk_lu_request integer NOT NULL,
    deleted boolean DEFAULT false,
    request_result_html text
);


ALTER TABLE clin_requests.forms_requests OWNER TO easygp;

--
-- Name: TABLE forms_requests; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON TABLE forms_requests IS 'This table links a form to the name of requests on that form
  i.e there is a one to many relationship to a form
  when a form ie created/saved, then an entry in this table
  is created, but there is no OBR (returned result segment in hl7)
  and no html text to summarise the result of the request';


--
-- Name: COLUMN forms_requests.pk; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON COLUMN forms_requests.pk IS 'key to forms_requests table, ie points to pk of the orginal request   ';


--
-- Name: COLUMN forms_requests.fk_form; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON COLUMN forms_requests.fk_form IS ' points to form the request was on  ';


--
-- Name: COLUMN forms_requests.fk_lu_request; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON COLUMN forms_requests.fk_lu_request IS ' foreign key points to the actual request name eg ''FBC  ';


--
-- Name: COLUMN forms_requests.deleted; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON COLUMN forms_requests.deleted IS ' If false the form has been delted  ';


--
-- Name: COLUMN forms_requests.request_result_html; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON COLUMN forms_requests.request_result_html IS ' the entire html of a single result   ';


--
-- Name: forms_requests_pk_seq; Type: SEQUENCE; Schema: clin_requests; Owner: easygp
--

CREATE SEQUENCE forms_requests_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_requests.forms_requests_pk_seq OWNER TO easygp;

--
-- Name: forms_requests_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_requests; Owner: easygp
--

ALTER SEQUENCE forms_requests_pk_seq OWNED BY forms_requests.pk;


--
-- Name: inbox_oru_unresolved_temp_patient_id_seq; Type: SEQUENCE; Schema: clin_requests; Owner: easygp
--

CREATE SEQUENCE inbox_oru_unresolved_temp_patient_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_requests.inbox_oru_unresolved_temp_patient_id_seq OWNER TO easygp;

--
-- Name: link_forms_requests_requests_results; Type: TABLE; Schema: clin_requests; Owner: easygp; Tablespace: 
--

CREATE TABLE link_forms_requests_requests_results (
    pk integer NOT NULL,
    fk_forms_requests integer,
    requests_results_episode_key integer
);


ALTER TABLE clin_requests.link_forms_requests_requests_results OWNER TO easygp;

--
-- Name: link_forms_requests_requests_results_pk_seq; Type: SEQUENCE; Schema: clin_requests; Owner: easygp
--

CREATE SEQUENCE link_forms_requests_requests_results_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_requests.link_forms_requests_requests_results_pk_seq OWNER TO easygp;

--
-- Name: link_forms_requests_requests_results_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_requests; Owner: easygp
--

ALTER SEQUENCE link_forms_requests_requests_results_pk_seq OWNED BY link_forms_requests_requests_results.pk;


--
-- Name: lu_copyto_type; Type: TABLE; Schema: clin_requests; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_copyto_type (
    pk integer NOT NULL,
    type text NOT NULL
);


ALTER TABLE clin_requests.lu_copyto_type OWNER TO easygp;

--
-- Name: TABLE lu_copyto_type; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON TABLE lu_copyto_type IS 'The type of contact that is being sent a copy of
  the request eg person or organisation/branch';


--
-- Name: lu_copyto_type_pk_seq; Type: SEQUENCE; Schema: clin_requests; Owner: easygp
--

CREATE SEQUENCE lu_copyto_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_requests.lu_copyto_type_pk_seq OWNER TO easygp;

--
-- Name: lu_copyto_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_requests; Owner: easygp
--

ALTER SEQUENCE lu_copyto_type_pk_seq OWNED BY lu_copyto_type.pk;


--
-- Name: lu_form_header; Type: TABLE; Schema: clin_requests; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_form_header (
    pk integer NOT NULL,
    fk_branch integer NOT NULL,
    header text,
    general_text text
);


ALTER TABLE clin_requests.lu_form_header OWNER TO easygp;

--
-- Name: TABLE lu_form_header; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON TABLE lu_form_header IS 'Provider specific text to be shown on a request form
 e.g For a pathology report could be specific details
 they have on their forms, A.C.N - Australian company number - etc';


--
-- Name: COLUMN lu_form_header.fk_branch; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON COLUMN lu_form_header.fk_branch IS 'primary key to contacts.branches table. This will usually be the head office';


--
-- Name: COLUMN lu_form_header.header; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON COLUMN lu_form_header.header IS 'HTML text as described above';


--
-- Name: COLUMN lu_form_header.general_text; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON COLUMN lu_form_header.general_text IS 'Some general text such as this, from one pathology company:
<B>Privacy Note:</B>The information provided by you on this form will be used to assess 
the benefit payable for the service(s) rendered. Its collection is authorised by 
law and may be disclosed to the Department of Health and Family Services, 
to the person who has claimed benefit for the service or to that person''s nominee. 
Information concerning your eligibility under the scheme may be advised to a person
who may or who has made a claim under the scheme.';


--
-- Name: lu_form_header_pk_seq; Type: SEQUENCE; Schema: clin_requests; Owner: easygp
--

CREATE SEQUENCE lu_form_header_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_requests.lu_form_header_pk_seq OWNER TO easygp;

--
-- Name: lu_form_header_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_requests; Owner: easygp
--

ALTER SEQUENCE lu_form_header_pk_seq OWNED BY lu_form_header.pk;


--
-- Name: lu_instructions; Type: TABLE; Schema: clin_requests; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_instructions (
    pk integer NOT NULL,
    instruction text NOT NULL
);


ALTER TABLE clin_requests.lu_instructions OWNER TO easygp;

--
-- Name: TABLE lu_instructions; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON TABLE lu_instructions IS 'Table containing instructions which can be linked to a particular tests to be printed out on the request form';


--
-- Name: COLUMN lu_instructions.instruction; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON COLUMN lu_instructions.instruction IS 'Instructions for a given test, for e.g for an cardiac.holter monitor:
<P>You will be wearing a small box around your waist for 24 hours. 
You will not be able to shower or get wet in any way whilst the test is in progress. 
The clothing you wear is important.<P>
<B>LADIES</B> please bring or wear a 2 piece outfit such as a loose blouse that buttons
 through the front and skirt or slacks. One piece undergarments (bodysuits/long-line bras)
  are not suitable.
  <B>MEN</B> Please bring or wear a button through the front shirt and shorts or trousers. 
  Please do not wear a singlet.';


--
-- Name: lu_instructions_pk_seq; Type: SEQUENCE; Schema: clin_requests; Owner: easygp
--

CREATE SEQUENCE lu_instructions_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_requests.lu_instructions_pk_seq OWNER TO easygp;

--
-- Name: lu_instructions_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_requests; Owner: easygp
--

ALTER SEQUENCE lu_instructions_pk_seq OWNED BY lu_instructions.pk;


--
-- Name: lu_link_provider_user_requests; Type: TABLE; Schema: clin_requests; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_link_provider_user_requests (
    pk integer NOT NULL,
    fk_lu_request integer NOT NULL,
    provider_request_name text NOT NULL,
    lateralisation integer DEFAULT 0,
    deleted boolean DEFAULT false
);


ALTER TABLE clin_requests.lu_link_provider_user_requests OWNER TO easygp;

--
-- Name: lu_link_provider_user_requests_pk_seq; Type: SEQUENCE; Schema: clin_requests; Owner: easygp
--

CREATE SEQUENCE lu_link_provider_user_requests_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_requests.lu_link_provider_user_requests_pk_seq OWNER TO easygp;

--
-- Name: lu_link_provider_user_requests_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_requests; Owner: easygp
--

ALTER SEQUENCE lu_link_provider_user_requests_pk_seq OWNED BY lu_link_provider_user_requests.pk;


--
-- Name: lu_request_type; Type: TABLE; Schema: clin_requests; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_request_type (
    pk integer NOT NULL,
    type text NOT NULL
);


ALTER TABLE clin_requests.lu_request_type OWNER TO easygp;

--
-- Name: TABLE lu_request_type; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON TABLE lu_request_type IS 'Table containing list of types of requests eg radiology';


--
-- Name: COLUMN lu_request_type.type; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON COLUMN lu_request_type.type IS 'the type of request e.g radiology, pathology, cardiovascular etc.';


--
-- Name: lu_request_type_pk_seq; Type: SEQUENCE; Schema: clin_requests; Owner: easygp
--

CREATE SEQUENCE lu_request_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_requests.lu_request_type_pk_seq OWNER TO easygp;

--
-- Name: lu_request_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_requests; Owner: easygp
--

ALTER SEQUENCE lu_request_type_pk_seq OWNED BY lu_request_type.pk;


--
-- Name: lu_requests; Type: TABLE; Schema: clin_requests; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_requests (
    pk integer NOT NULL,
    fk_lu_request_type integer NOT NULL,
    item text NOT NULL,
    fk_laterality integer DEFAULT 0,
    fk_decision_support integer DEFAULT 0,
    fk_instruction integer DEFAULT 0,
    deleted boolean DEFAULT false
);


ALTER TABLE clin_requests.lu_requests OWNER TO easygp;

--
-- Name: TABLE lu_requests; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON TABLE lu_requests IS 'Table containing all possible request items for eg pathology, radiology etc e.g CXR, Ultasound of gall bladder, Bone mineral Density, or physio e.g physio at discretion or back physio';


--
-- Name: COLUMN lu_requests.fk_lu_request_type; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON COLUMN lu_requests.fk_lu_request_type IS ' foreign key to clin_requests.lu_request_type table';


--
-- Name: COLUMN lu_requests.item; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON COLUMN lu_requests.item IS 'the actual request eg Xray of wrist';


--
-- Name: COLUMN lu_requests.fk_laterality; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON COLUMN lu_requests.fk_laterality IS 'foreign key to common.lu_laterality, ie left/right/both';


--
-- Name: COLUMN lu_requests.fk_decision_support; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON COLUMN lu_requests.fk_decision_support IS 'foreign key to decision_support.decision_support table neither of which exist yet';


--
-- Name: COLUMN lu_requests.fk_instruction; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON COLUMN lu_requests.fk_instruction IS 'foreign key to lu_instructions ie patient instructions for a particular test';


--
-- Name: lu_requests_pk_seq; Type: SEQUENCE; Schema: clin_requests; Owner: easygp
--

CREATE SEQUENCE lu_requests_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_requests.lu_requests_pk_seq OWNER TO easygp;

--
-- Name: lu_requests_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_requests; Owner: easygp
--

ALTER SEQUENCE lu_requests_pk_seq OWNED BY lu_requests.pk;


--
-- Name: notes; Type: TABLE; Schema: clin_requests; Owner: easygp; Tablespace: 
--

CREATE TABLE notes (
    pk integer NOT NULL,
    note text,
    fk_lu_type integer,
    fk_staff integer NOT NULL
);


ALTER TABLE clin_requests.notes OWNER TO easygp;

--
-- Name: TABLE notes; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON TABLE notes IS 'This table may be moved. The principal is that it saves the user
typing, by saving short notes which the user colon delimited during
data entry whilst creating request forms
e.g tiredness;weight loss;increased breathlessness;';


--
-- Name: COLUMN notes.fk_lu_type; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON COLUMN notes.fk_lu_type IS 'key to lu_type table, ie pathology/radiology/physiotherapy etc';


--
-- Name: notes_pk_seq; Type: SEQUENCE; Schema: clin_requests; Owner: easygp
--

CREATE SEQUENCE notes_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_requests.notes_pk_seq OWNER TO easygp;

--
-- Name: notes_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_requests; Owner: easygp
--

ALTER SEQUENCE notes_pk_seq OWNED BY notes.pk;


--
-- Name: request_providers; Type: TABLE; Schema: clin_requests; Owner: easygp; Tablespace: 
--

CREATE TABLE request_providers (
    pk integer NOT NULL,
    fk_headoffice_branch integer,
    fk_employee integer,
    fk_person integer,
    fk_lu_request_type integer NOT NULL,
    deleted boolean DEFAULT false,
    fk_default_branch integer
);


ALTER TABLE clin_requests.request_providers OWNER TO easygp;

--
-- Name: TABLE request_providers; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON TABLE request_providers IS 'table which points to those persons, organisations or employees in 
  an organisation to whom we can send requests for services. this could
  be a test eg fbc, cxr, or a service like physiotherapy - in which case
  the user is using a request form instead of a letter';


--
-- Name: request_providers_pk_seq; Type: SEQUENCE; Schema: clin_requests; Owner: easygp
--

CREATE SEQUENCE request_providers_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_requests.request_providers_pk_seq OWNER TO easygp;

--
-- Name: request_providers_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_requests; Owner: easygp
--

ALTER SEQUENCE request_providers_pk_seq OWNED BY request_providers.pk;


--
-- Name: results_requests_episode_key; Type: SEQUENCE; Schema: clin_requests; Owner: easygp
--

CREATE SEQUENCE results_requests_episode_key
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_requests.results_requests_episode_key OWNER TO easygp;

--
-- Name: SEQUENCE results_requests_episode_key; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON SEQUENCE results_requests_episode_key IS 'First attempt to link multiple lines of this table eg all the
 rows of a FBC to one or more differently named requests';


--
-- Name: user_default_type; Type: TABLE; Schema: clin_requests; Owner: easygp; Tablespace: 
--

CREATE TABLE user_default_type (
    pk integer NOT NULL,
    fk_staff integer NOT NULL,
    fk_lu_type integer NOT NULL
);


ALTER TABLE clin_requests.user_default_type OWNER TO easygp;

--
-- Name: TABLE user_default_type; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON TABLE user_default_type IS 'the default type of form first presented to the
  user when loads the request form module';


--
-- Name: COLUMN user_default_type.fk_staff; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON COLUMN user_default_type.fk_staff IS 'key to admin.staff table';


--
-- Name: COLUMN user_default_type.fk_lu_type; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON COLUMN user_default_type.fk_lu_type IS 'key to lu_type table ie type of request e.g pathology';


--
-- Name: user_default_type_pk_seq; Type: SEQUENCE; Schema: clin_requests; Owner: easygp
--

CREATE SEQUENCE user_default_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_requests.user_default_type_pk_seq OWNER TO easygp;

--
-- Name: user_default_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_requests; Owner: easygp
--

ALTER SEQUENCE user_default_type_pk_seq OWNED BY user_default_type.pk;


--
-- Name: user_provider_defaults; Type: TABLE; Schema: clin_requests; Owner: easygp; Tablespace: 
--

CREATE TABLE user_provider_defaults (
    pk integer NOT NULL,
    fk_staff integer NOT NULL,
    fk_default_branch integer NOT NULL,
    fk_request_provider integer,
    send_electronically boolean DEFAULT false,
    print_paper boolean DEFAULT true,
    deleted boolean DEFAULT false,
    fk_lu_request_type integer NOT NULL
);


ALTER TABLE clin_requests.user_provider_defaults OWNER TO easygp;

--
-- Name: TABLE user_provider_defaults; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON TABLE user_provider_defaults IS 'Contains defaults for users according to the category of the provider - as that provider has its own category';


--
-- Name: COLUMN user_provider_defaults.fk_staff; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON COLUMN user_provider_defaults.fk_staff IS 'key to admin.staff table ie describes the user';


--
-- Name: COLUMN user_provider_defaults.fk_default_branch; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON COLUMN user_provider_defaults.fk_default_branch IS 'key to contacts.branches table
  this is the branch that the user preferentially sends the
  request to';


--
-- Name: user_provider_defaults_pk_seq; Type: SEQUENCE; Schema: clin_requests; Owner: easygp
--

CREATE SEQUENCE user_provider_defaults_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_requests.user_provider_defaults_pk_seq OWNER TO easygp;

--
-- Name: user_provider_defaults_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_requests; Owner: easygp
--

ALTER SEQUENCE user_provider_defaults_pk_seq OWNED BY user_provider_defaults.pk;


--
-- Name: vwforms_pk_seq; Type: SEQUENCE; Schema: clin_requests; Owner: easygp
--

CREATE SEQUENCE vwforms_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_requests.vwforms_pk_seq OWNER TO easygp;

SET search_path = contacts, pg_catalog;

--
-- Name: images; Type: TABLE; Schema: contacts; Owner: easygp; Tablespace: 
--

CREATE TABLE images (
    pk integer NOT NULL,
    image bytea,
    deleted boolean
);


ALTER TABLE contacts.images OWNER TO easygp;

--
-- Name: vwpersons; Type: VIEW; Schema: contacts; Owner: easygp
--

CREATE VIEW vwpersons AS
    SELECT data_persons.pk AS fk_person, CASE WHEN ("Addresses".pk > 0) THEN COALESCE(((data_persons.pk || '-'::text) || "Addresses".pk)) ELSE (data_persons.pk || '-0'::text) END AS pk_view, (((lu_title.title || ' '::text) || (data_persons.firstname || ' '::text)) || (data_persons.surname || ' '::text)) AS wholename, data_persons.firstname, data_persons.surname, data_persons.salutation, data_persons.birthdate, data_persons.fk_ethnicity, data_persons.fk_language, data_persons.language_problems, data_persons.memo, data_persons.fk_marital, data_persons.fk_title, data_persons.fk_sex, data_persons.fk_image, data_persons.fk_occupation, data_persons.retired, data_persons.deceased, data_persons.date_deceased, data_persons.deleted, lu_sex.sex, lu_sex.sex_text, lu_title.title, lu_marital.marital, lu_occupations.occupation, lu_languages.language, lu_countries.country, links_persons_addresses.pk AS fk_link_address, links_persons_addresses.fk_address, lu_towns.postcode, lu_towns.town, lu_towns.state, data_persons.country_code, "Addresses".street1, "Addresses".street2, "Addresses".fk_town, "Addresses".fk_lu_address_type, lu_address_types.type AS address_type, "Addresses".preferred_address, "Addresses".postal_address, "Addresses".head_office, "Addresses".geolocation, "Addresses".deleted AS address_deleted, images.image, data_persons.surname_normalised FROM (((((((((((data_persons LEFT JOIN lu_sex ON ((data_persons.fk_sex = lu_sex.pk))) LEFT JOIN lu_title ON ((data_persons.fk_title = lu_title.pk))) LEFT JOIN lu_marital ON ((data_persons.fk_marital = lu_marital.pk))) LEFT JOIN common.lu_occupations ON ((data_persons.fk_occupation = lu_occupations.pk))) LEFT JOIN common.lu_languages ON ((data_persons.fk_language = lu_languages.pk))) LEFT JOIN images ON ((data_persons.fk_image = images.pk))) LEFT JOIN links_persons_addresses ON ((data_persons.pk = links_persons_addresses.fk_person))) LEFT JOIN common.lu_countries ON ((data_persons.country_code = (lu_countries.country_code)::text))) LEFT JOIN data_addresses "Addresses" ON ((links_persons_addresses.fk_address = "Addresses".pk))) LEFT JOIN lu_address_types ON (("Addresses".fk_lu_address_type = lu_address_types.pk))) LEFT JOIN lu_towns ON (("Addresses".fk_town = lu_towns.pk))) ORDER BY data_persons.pk, links_persons_addresses.fk_address;


ALTER TABLE contacts.vwpersons OWNER TO easygp;

SET search_path = clin_requests, pg_catalog;

--
-- Name: vwrequestproviders; Type: VIEW; Schema: clin_requests; Owner: easygp
--

CREATE VIEW vwrequestproviders AS
    SELECT request_providers.pk AS pk_request_provider, lu_request_type.type, request_providers.fk_headoffice_branch, request_providers.fk_default_branch, request_providers.fk_employee, request_providers.fk_person, request_providers.fk_lu_request_type, request_providers.deleted AS request_provider_deleted, data_organisations.organisation, lu_categories.category, data_branches.branch AS headoffice_branch, data_branches.fk_organisation, data_branches.deleted AS headoffice_branch_deleted, data_addresses.street1 AS headoffice_street1, data_addresses.street2 AS headoffice_street2, data_addresses.deleted AS headoffice_address_deleted, lu_towns.postcode AS headoffice_postcode, lu_towns.town AS headoffice_town, lu_towns.state AS headoffice_state, NULL::text AS wholename, NULL::text AS firstname, NULL::text AS surname, NULL::text AS salutation, 0 AS fk_title, NULL::text AS title, 0 AS fk_sex, NULL::text AS sex, 0 AS fk_occupation, NULL::text AS occupation, data_branches1.branch AS default_branch, data_addresses1.street1 AS default_branch_street1, data_addresses1.street2 AS default_branch_street2, lu_towns1.postcode AS default_branch_postcode, lu_towns1.town AS default_branch_town, lu_towns1.state AS default_branch_state FROM (((((((((request_providers JOIN contacts.data_branches ON ((request_providers.fk_headoffice_branch = data_branches.pk))) JOIN contacts.data_organisations ON ((data_branches.fk_organisation = data_organisations.pk))) JOIN contacts.lu_categories ON ((data_branches.fk_category = lu_categories.pk))) JOIN lu_request_type ON ((request_providers.fk_lu_request_type = lu_request_type.pk))) LEFT JOIN contacts.data_addresses ON ((data_branches.fk_address = data_addresses.pk))) LEFT JOIN contacts.lu_towns ON ((data_addresses.fk_town = lu_towns.pk))) JOIN contacts.data_branches data_branches1 ON ((request_providers.fk_default_branch = data_branches1.pk))) LEFT JOIN contacts.data_addresses data_addresses1 ON ((data_branches1.fk_address = data_addresses1.pk))) LEFT JOIN contacts.lu_towns lu_towns1 ON ((data_addresses1.fk_town = lu_towns1.pk))) WHERE ((request_providers.fk_employee = 0) AND (request_providers.fk_person = 0)) UNION SELECT request_providers.pk AS pk_request_provider, lu_request_type.type, request_providers.fk_headoffice_branch, request_providers.fk_default_branch, request_providers.fk_employee, request_providers.fk_person, request_providers.fk_lu_request_type, request_providers.deleted AS request_provider_deleted, NULL::text AS organisation, NULL::character varying AS category, 'HEAD OFFICE'::text AS headoffice_branch, 0 AS fk_organisation, NULL::boolean AS headoffice_branch_deleted, vwpersons.street1 AS headoffice_street1, vwpersons.street2 AS headoffice_street2, NULL::boolean AS headoffice_address_deleted, vwpersons.postcode AS headoffice_postcode, vwpersons.town AS headoffice_town, vwpersons.state AS headoffice_state, vwpersons.wholename, vwpersons.firstname, vwpersons.surname, vwpersons.salutation, vwpersons.fk_title, vwpersons.title, vwpersons.fk_sex, vwpersons.sex, vwpersons.fk_occupation, vwpersons.occupation, NULL::text AS default_branch, vwpersons.street1 AS default_branch_street1, vwpersons.street2 AS default_branch_street2, vwpersons.postcode AS default_branch_postcode, vwpersons.town AS default_branch_town, vwpersons.state AS default_branch_state FROM ((request_providers JOIN lu_request_type ON ((request_providers.fk_lu_request_type = lu_request_type.pk))) JOIN contacts.vwpersons ON ((request_providers.fk_person = vwpersons.fk_person))) WHERE (request_providers.fk_person <> 0) ORDER BY 7;


ALTER TABLE clin_requests.vwrequestproviders OWNER TO easygp;

--
-- Name: VIEW vwrequestproviders; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON VIEW vwrequestproviders IS ' View of providers who we may send requests to
 Note: it is possible in contacts for user not to put in an addresss, hence the outer joins here
 ';


--
-- Name: vwrequestforms; Type: VIEW; Schema: clin_requests; Owner: easygp
--

CREATE VIEW vwrequestforms AS
    SELECT COALESCE(((forms.pk || '-'::text) || forms_requests.pk)) AS pk_view, forms_requests.pk AS fk_forms_requests, forms.fk_consult, forms.date, lu_requests.item, forms.requests_summary, forms.notes_summary, forms.fk_request_provider, forms.fk_lu_request_type, forms.medications_summary, forms.copyto, forms.deleted, forms.copyto_patient, forms.urgent, forms.bulk_bill, forms.fasting, forms.phone, forms.fax, forms.include_medications, forms.pk_image, forms.fk_progressnote, forms.fk_pasthistory, forms.latex, vwstaff.firstname AS staff_firstname, vwstaff.surname AS staff_surname, vwstaff.wholename AS staff_wholename, vwstaff.title AS staff_title, lu_request_type.type, vwrequestproviders.fk_headoffice_branch, vwrequestproviders.fk_default_branch, vwrequestproviders.fk_employee, vwrequestproviders.fk_person, vwrequestproviders.request_provider_deleted, vwrequestproviders.organisation, vwrequestproviders.category, vwrequestproviders.headoffice_branch, vwrequestproviders.fk_organisation, vwrequestproviders.headoffice_branch_deleted, vwrequestproviders.headoffice_street1, vwrequestproviders.headoffice_street2, vwrequestproviders.headoffice_address_deleted, vwrequestproviders.headoffice_postcode, vwrequestproviders.headoffice_town, vwrequestproviders.headoffice_state, vwrequestproviders.wholename, vwrequestproviders.firstname, vwrequestproviders.surname, vwrequestproviders.salutation, vwrequestproviders.fk_title, vwrequestproviders.title, vwrequestproviders.fk_sex, vwrequestproviders.sex, vwrequestproviders.fk_occupation, vwrequestproviders.occupation, vwrequestproviders.default_branch, vwrequestproviders.default_branch_street1, vwrequestproviders.default_branch_street2, vwrequestproviders.default_branch_postcode, vwrequestproviders.default_branch_town, vwrequestproviders.default_branch_state, forms_requests.fk_form, forms_requests.fk_lu_request, forms_requests.deleted AS forms_request_deleted, forms_requests.request_result_html, consult.consult_date, consult.fk_patient, consult.fk_staff, past_history.description AS past_history_description FROM (((((((forms JOIN clin_consult.consult ON ((forms.fk_consult = consult.pk))) JOIN admin.vwstaff ON ((consult.fk_staff = vwstaff.fk_staff))) JOIN lu_request_type ON ((forms.fk_lu_request_type = lu_request_type.pk))) JOIN forms_requests ON ((forms.pk = forms_requests.fk_form))) JOIN lu_requests ON ((forms_requests.fk_lu_request = lu_requests.pk))) JOIN vwrequestproviders ON ((forms.fk_request_provider = vwrequestproviders.pk_request_provider))) LEFT JOIN clin_history.past_history ON ((forms.fk_pasthistory = past_history.pk)));


ALTER TABLE clin_requests.vwrequestforms OWNER TO easygp;

--
-- Name: vwrequestnames; Type: VIEW; Schema: clin_requests; Owner: easygp
--

CREATE VIEW vwrequestnames AS
    ((SELECT (lu_request_items.pk || '-1'::text) AS pk_view, lu_request_items.pk AS fk_lu_request, lu_request_type.type, lu_request_items.fk_lu_request_type, lu_request_items.deleted, CASE WHEN (lu_request_items.fk_laterality = 3) THEN (lu_request_items.item || ' (LEFT)'::text) ELSE NULL::text END AS item, 1 AS fk_laterality, lu_request_items.fk_decision_support, lu_request_items.fk_instruction, lu_instructions.instruction FROM ((lu_requests lu_request_items JOIN lu_request_type ON ((lu_request_items.fk_lu_request_type = lu_request_type.pk))) LEFT JOIN lu_instructions ON ((lu_request_items.fk_instruction = lu_instructions.pk))) WHERE ((lower(lu_request_items.item) ~~ '%'::text) AND (lu_request_items.fk_laterality = 3)) UNION SELECT (lu_request_items.pk || '-2'::text) AS pk_view, lu_request_items.pk AS fk_lu_request, lu_request_type.type, lu_request_items.fk_lu_request_type, lu_request_items.deleted, CASE WHEN (lu_request_items.fk_laterality = 3) THEN (lu_request_items.item || ' (RIGHT)'::text) ELSE NULL::text END AS item, 2 AS fk_laterality, lu_request_items.fk_decision_support, lu_request_items.fk_instruction, lu_instructions.instruction FROM ((lu_requests lu_request_items JOIN lu_request_type ON ((lu_request_items.fk_lu_request_type = lu_request_type.pk))) LEFT JOIN lu_instructions ON ((lu_request_items.fk_instruction = lu_instructions.pk))) WHERE ((lower(lu_request_items.item) ~~ '%'::text) AND (lu_request_items.fk_laterality = 3))) UNION SELECT (lu_request_items.pk || '-3'::text) AS pk_view, lu_request_items.pk AS fk_lu_request, lu_request_type.type, lu_request_items.fk_lu_request_type, lu_request_items.deleted, CASE WHEN (lu_request_items.fk_laterality = 3) THEN (lu_request_items.item || ' (BOTH)'::text) ELSE NULL::text END AS item, 3 AS fk_laterality, lu_request_items.fk_decision_support, lu_request_items.fk_instruction, lu_instructions.instruction FROM ((lu_requests lu_request_items JOIN lu_request_type ON ((lu_request_items.fk_lu_request_type = lu_request_type.pk))) LEFT JOIN lu_instructions ON ((lu_request_items.fk_instruction = lu_instructions.pk))) WHERE ((lower(lu_request_items.item) ~~ '%'::text) AND (lu_request_items.fk_laterality = 3))) UNION SELECT (lu_request_items.pk || '-0'::text) AS pk_view, lu_request_items.pk AS fk_lu_request, lu_request_type.type, lu_request_items.fk_lu_request_type, lu_request_items.deleted, lu_request_items.item, lu_request_items.fk_laterality, lu_request_items.fk_decision_support, lu_request_items.fk_instruction, lu_instructions.instruction FROM ((lu_requests lu_request_items JOIN lu_request_type ON ((lu_request_items.fk_lu_request_type = lu_request_type.pk))) LEFT JOIN lu_instructions ON ((lu_request_items.fk_instruction = lu_instructions.pk))) WHERE ((lower(lu_request_items.item) ~~ '%'::text) AND (lu_request_items.fk_laterality = 0)) ORDER BY 2, 7;


ALTER TABLE clin_requests.vwrequestnames OWNER TO easygp;

--
-- Name: VIEW vwrequestnames; Type: COMMENT; Schema: clin_requests; Owner: easygp
--

COMMENT ON VIEW vwrequestnames IS 'a view of everything which is orderable, including lateralisation eg Xray wrist (LEFT), Xray wrist (RIGHT) or Xray Wrist (BOTH)';


SET search_path = documents, pg_catalog;

--
-- Name: lu_message_display_style; Type: TABLE; Schema: documents; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_message_display_style (
    pk integer NOT NULL,
    style text NOT NULL
);


ALTER TABLE documents.lu_message_display_style OWNER TO easygp;

--
-- Name: lu_message_standard; Type: TABLE; Schema: documents; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_message_standard (
    pk integer NOT NULL,
    type text NOT NULL,
    version text
);


ALTER TABLE documents.lu_message_standard OWNER TO easygp;

--
-- Name: TABLE lu_message_standard; Type: COMMENT; Schema: documents; Owner: easygp
--

COMMENT ON TABLE lu_message_standard IS 'hl7 or pit version not yet implemented';


--
-- Name: sending_entities; Type: TABLE; Schema: documents; Owner: easygp; Tablespace: 
--

CREATE TABLE sending_entities (
    pk integer NOT NULL,
    fk_lu_request_type integer,
    msh_sending_entity text NOT NULL,
    msh_transmitting_entity text,
    fk_lu_message_display_style integer NOT NULL,
    fk_branch integer,
    fk_employee integer,
    fk_person integer,
    fk_lu_message_standard integer NOT NULL,
    exclude_ft_report boolean DEFAULT false,
    exclude_pit boolean DEFAULT false,
    abnormals_foreground_color integer DEFAULT 16711680,
    abnormals_background_color integer DEFAULT 16777215,
    deleted boolean DEFAULT false
);


ALTER TABLE documents.sending_entities OWNER TO easygp;

--
-- Name: TABLE sending_entities; Type: COMMENT; Schema: documents; Owner: easygp
--

COMMENT ON TABLE sending_entities IS 'Sending entities and the parameters to define how to handle incoming hl7 messages 
on a per-provider basis.Note these messages can be in form of various hl7 standards or old style PIT (sequential numbered text lines eg 100, 110 120 etc This table
defines the file type hl7 or pit, who is sending it, where to put it, which segments of the message to exclude when displaying in html';


--
-- Name: COLUMN sending_entities.fk_lu_request_type; Type: COMMENT; Schema: documents; Owner: easygp
--

COMMENT ON COLUMN sending_entities.fk_lu_request_type IS 'The type of provider eg pathology provider, radiology provider';


--
-- Name: COLUMN sending_entities.msh_sending_entity; Type: COMMENT; Schema: documents; Owner: easygp
--

COMMENT ON COLUMN sending_entities.msh_sending_entity IS 'the entity sending, could be unintelligable eg a NATA/number or a recognizable name eg Hunter Radiology, however often bears no relationship to a real person or company';


--
-- Name: COLUMN sending_entities.msh_transmitting_entity; Type: COMMENT; Schema: documents; Owner: easygp
--

COMMENT ON COLUMN sending_entities.msh_transmitting_entity IS 'could be the sending entity or third party transmitter eg Medical Objects, or the name of a computer program generating the hl7';


--
-- Name: COLUMN sending_entities.fk_lu_message_display_style; Type: COMMENT; Schema: documents; Owner: easygp
--

COMMENT ON COLUMN sending_entities.fk_lu_message_display_style IS 'display as letter or result style
 - Public Const Document_Display_As_Letter As Integer = 1 
 - Public Const Document_Display_As_Result As Integer = 2
 
 Note: though this attribute is kept for each document in document.documents
       at the time the document is signed off by the user,
       we need to know what the default display type is for each message sender -
 defaults to 1 = letter, because, though pathology companies are far more
 common, they will have been set to display as a result in the configuration of
 message senders. Scanned documents however will not by default, so we assume
 (sometimes wrongly) that they are usually letters
 ';


--
-- Name: COLUMN sending_entities.fk_lu_message_standard; Type: COMMENT; Schema: documents; Owner: easygp
--

COMMENT ON COLUMN sending_entities.fk_lu_message_standard IS 'hl7 or pit';


--
-- Name: COLUMN sending_entities.exclude_ft_report; Type: COMMENT; Schema: documents; Owner: easygp
--

COMMENT ON COLUMN sending_entities.exclude_ft_report IS 'if true then no free text segments will be shown';


--
-- Name: COLUMN sending_entities.exclude_pit; Type: COMMENT; Schema: documents; Owner: easygp
--

COMMENT ON COLUMN sending_entities.exclude_pit IS 'if contains PIT segments if true these will not be shown (often duplicated the hl7 data itself)';


--
-- Name: unmatched_patients; Type: TABLE; Schema: documents; Owner: easygp; Tablespace: 
--

CREATE TABLE unmatched_patients (
    pk integer NOT NULL,
    surname text NOT NULL,
    firstname text,
    birthdate date,
    sex text,
    title text,
    comment text,
    fk_real_patient integer,
    street text,
    town text,
    postcode text,
    state text
);


ALTER TABLE documents.unmatched_patients OWNER TO easygp;

--
-- Name: COLUMN unmatched_patients.comment; Type: COMMENT; Schema: documents; Owner: easygp
--

COMMENT ON COLUMN unmatched_patients.comment IS 'other data about the patient to help matching';


--
-- Name: unmatched_staff; Type: TABLE; Schema: documents; Owner: easygp; Tablespace: 
--

CREATE TABLE unmatched_staff (
    pk integer NOT NULL,
    surname text NOT NULL,
    firstname text,
    title text,
    provider_number text,
    fk_real_staff integer
);


ALTER TABLE documents.unmatched_staff OWNER TO easygp;

--
-- Name: vwsendingentities; Type: VIEW; Schema: documents; Owner: easygp
--

CREATE VIEW vwsendingentities AS
    ((SELECT sending_entities.pk AS pk_sending_entities, sending_entities.fk_lu_request_type, lu_request_type.type AS request_type, sending_entities.msh_sending_entity, sending_entities.msh_transmitting_entity, sending_entities.fk_lu_message_display_style, sending_entities.fk_branch, sending_entities.fk_employee, sending_entities.fk_person, sending_entities.fk_lu_message_standard, lu_message_standard.type AS message_type, lu_message_standard.version AS message_version, lu_message_display_style.style, sending_entities.exclude_ft_report, sending_entities.exclude_pit, sending_entities.abnormals_foreground_color, sending_entities.abnormals_background_color, sending_entities.deleted, NULL::text AS branch, NULL::text AS organisation, false AS organisation_deleted, NULL::integer AS fk_organisation, false AS branch_deleted, NULL::integer AS fk_address_organisation, NULL::integer AS fk_category_organisation, NULL::character varying AS organisation_category, NULL::text AS organisation_street1, NULL::text AS organisation_street2, NULL::integer AS fk_town_organisation, NULL::boolean AS organisation_postal_address, NULL::boolean AS organisation_head_office, NULL::character varying AS organisation_postcode, NULL::text AS organisation_town, NULL::character varying AS organisation_state, vwpersons.firstname, vwpersons.surname, vwpersons.title, vwpersons.occupation AS person_occupation, vwpersons.sex, vwpersons.fk_address AS fk_address_person, vwpersons.postcode AS person_postcode, vwpersons.street1 AS person_street1, vwpersons.street2 AS person_street2, vwpersons.fk_town AS fk_town_person, vwpersons.town AS person_town, vwpersons.state AS person_state FROM ((((sending_entities JOIN contacts.vwpersons ON ((sending_entities.fk_person = vwpersons.fk_person))) LEFT JOIN clin_requests.lu_request_type ON ((sending_entities.fk_lu_request_type = lu_request_type.pk))) JOIN lu_message_display_style ON ((sending_entities.fk_lu_message_display_style = lu_message_display_style.pk))) JOIN lu_message_standard ON ((sending_entities.fk_lu_message_standard = lu_message_standard.pk))) WHERE (((vwpersons.deleted = false) AND (sending_entities.fk_branch = 0)) AND (sending_entities.fk_employee = 0)) UNION SELECT sending_entities.pk AS pk_sending_entities, sending_entities.fk_lu_request_type, lu_request_type.type AS request_type, sending_entities.msh_sending_entity, sending_entities.msh_transmitting_entity, sending_entities.fk_lu_message_display_style, sending_entities.fk_branch, sending_entities.fk_employee, sending_entities.fk_person, sending_entities.fk_lu_message_standard, lu_message_standard.type AS message_type, lu_message_standard.version AS message_version, lu_message_display_style.style, sending_entities.exclude_ft_report, sending_entities.exclude_pit, sending_entities.abnormals_foreground_color, sending_entities.abnormals_background_color, sending_entities.deleted, vworganisations.branch, vworganisations.organisation, vworganisations.organisation_deleted, vworganisations.fk_organisation, vworganisations.branch_deleted, vworganisations.fk_address AS fk_address_organisation, vworganisations.fk_category AS fk_category_organisation, vworganisations.category AS organisation_category, vworganisations.street1 AS organisation_street1, vworganisations.street2 AS organisation_street2, vworganisations.fk_town AS fk_town_organisation, vworganisations.postal_address AS organisation_postal_address, vworganisations.head_office AS organisation_head_office, vworganisations.postcode AS organisation_postcode, vworganisations.town AS organisation_town, vworganisations.state AS organisation_state, NULL::text AS firstname, NULL::text AS surname, NULL::text AS title, NULL::text AS person_occupation, NULL::text AS sex, NULL::integer AS fk_address_person, NULL::character varying AS person_postcode, NULL::text AS person_street1, NULL::text AS person_street2, NULL::integer AS fk_town_person, NULL::text AS person_town, NULL::character varying AS person_state FROM ((((sending_entities JOIN contacts.vworganisations ON ((sending_entities.fk_branch = vworganisations.fk_branch))) LEFT JOIN clin_requests.lu_request_type ON ((sending_entities.fk_lu_request_type = lu_request_type.pk))) JOIN lu_message_display_style ON ((sending_entities.fk_lu_message_display_style = lu_message_display_style.pk))) JOIN lu_message_standard ON ((sending_entities.fk_lu_message_standard = lu_message_standard.pk))) WHERE (((vworganisations.branch_deleted = false) AND (sending_entities.fk_employee = 0)) AND (sending_entities.fk_person = 0))) UNION SELECT sending_entities.pk AS pk_sending_entities, sending_entities.fk_lu_request_type, lu_request_type.type AS request_type, sending_entities.msh_sending_entity, sending_entities.msh_transmitting_entity, sending_entities.fk_lu_message_display_style, sending_entities.fk_branch, sending_entities.fk_employee, sending_entities.fk_person, sending_entities.fk_lu_message_standard, lu_message_standard.type AS message_type, lu_message_standard.version AS message_version, lu_message_display_style.style, sending_entities.exclude_ft_report, sending_entities.exclude_pit, sending_entities.abnormals_foreground_color, sending_entities.abnormals_background_color, sending_entities.deleted, vworganisations.branch, vworganisations.organisation, vworganisations.organisation_deleted, vworganisations.fk_organisation, vworganisations.branch_deleted, vworganisations.fk_address AS fk_address_organisation, vworganisations.fk_category AS fk_category_organisation, vworganisations.category AS organisation_category, vworganisations.street1 AS organisation_street1, vworganisations.street2 AS organisation_street2, vworganisations.fk_town AS fk_town_organisation, vworganisations.postal_address AS organisation_postal_address, vworganisations.head_office AS organisation_head_office, vworganisations.postcode AS organisation_postcode, vworganisations.town AS organisation_town, vworganisations.state AS organisation_state, vwpersons.firstname, vwpersons.surname, vwpersons.title, vwpersons.occupation AS person_occupation, vwpersons.sex, vwpersons.fk_address AS fk_address_person, vwpersons.postcode AS person_postcode, vwpersons.street1 AS person_street1, vwpersons.street2 AS person_street2, vwpersons.fk_town AS fk_town_person, vwpersons.town AS person_town, vwpersons.state AS person_state FROM ((((((sending_entities JOIN contacts.vworganisations ON ((sending_entities.fk_branch = vworganisations.fk_branch))) LEFT JOIN clin_requests.lu_request_type ON ((sending_entities.fk_lu_request_type = lu_request_type.pk))) JOIN lu_message_display_style ON ((sending_entities.fk_lu_message_display_style = lu_message_display_style.pk))) JOIN lu_message_standard ON ((sending_entities.fk_lu_message_standard = lu_message_standard.pk))) JOIN contacts.data_employees ON ((sending_entities.fk_employee = data_employees.pk))) JOIN contacts.vwpersons ON ((data_employees.fk_person = vwpersons.fk_person))) WHERE ((vwpersons.deleted = false) AND (data_employees.deleted = false))) UNION SELECT sending_entities.pk AS pk_sending_entities, sending_entities.fk_lu_request_type, lu_request_type.type AS request_type, sending_entities.msh_sending_entity, sending_entities.msh_transmitting_entity, sending_entities.fk_lu_message_display_style, sending_entities.fk_branch, sending_entities.fk_employee, sending_entities.fk_person, sending_entities.fk_lu_message_standard, lu_message_standard.type AS message_type, lu_message_standard.version AS message_version, lu_message_display_style.style, sending_entities.exclude_ft_report, sending_entities.exclude_pit, sending_entities.abnormals_foreground_color, sending_entities.abnormals_background_color, sending_entities.deleted, NULL::text AS branch, NULL::text AS organisation, NULL::boolean AS organisation_deleted, NULL::integer AS fk_organisation, NULL::boolean AS branch_deleted, NULL::integer AS fk_address_organisation, NULL::integer AS fk_category_organisation, NULL::character varying AS organisation_category, NULL::text AS organisation_street1, NULL::text AS organisation_street2, NULL::integer AS fk_town_organisation, false AS organisation_postal_address, false AS organisation_head_office, NULL::character varying AS organisation_postcode, NULL::text AS organisation_town, NULL::character varying AS organisation_state, NULL::text AS firstname, NULL::text AS surname, NULL::text AS title, NULL::text AS person_occupation, NULL::text AS sex, NULL::integer AS fk_address_person, NULL::character varying AS person_postcode, NULL::text AS person_street1, NULL::text AS person_street2, NULL::integer AS fk_town_person, NULL::text AS person_town, NULL::character varying AS person_state FROM (((sending_entities LEFT JOIN clin_requests.lu_request_type ON ((sending_entities.fk_lu_request_type = lu_request_type.pk))) JOIN lu_message_display_style ON ((sending_entities.fk_lu_message_display_style = lu_message_display_style.pk))) JOIN lu_message_standard ON ((sending_entities.fk_lu_message_standard = lu_message_standard.pk))) WHERE (((sending_entities.fk_branch IS NULL) AND (sending_entities.fk_employee IS NULL)) AND (sending_entities.fk_person IS NULL));


ALTER TABLE documents.vwsendingentities OWNER TO easygp;

--
-- Name: vwdocuments; Type: VIEW; Schema: documents; Owner: easygp
--

CREATE VIEW vwdocuments AS
    SELECT documents.pk AS pk_document, documents.source_file, documents.fk_sending_entity, documents.imported_time, documents.date_requested, documents.date_created, documents.fk_patient, documents.fk_staff_filed_document, documents.originator, documents.originator_reference, documents.copy_to, documents.provider_of_service_reference, documents.internal_reference, documents.copies_to, documents.fk_staff_destination, documents.comment_on_document, documents.patient_access, documents.concluded, documents.deleted, documents.fk_lu_urgency, documents.tag, documents.tag_user, documents.md5sum, documents.html, documents.fk_unmatched_staff, documents.fk_referral, documents.fk_request, documents.incoming_referral, documents.fk_unmatched_patient, documents.fk_lu_display_as, documents.fk_lu_request_type, lu_request_type.type AS request_type, vwsendingentities.fk_lu_request_type AS sending_entity_fk_lu_request_type, vwsendingentities.request_type AS sending_entity_request_type, vwsendingentities.style, vwsendingentities.message_type, vwsendingentities.message_version, vwsendingentities.msh_sending_entity, vwsendingentities.msh_transmitting_entity, vwsendingentities.fk_lu_message_display_style, vwsendingentities.fk_branch AS fk_sender_branch, vwsendingentities.fk_employee AS fk_employee_branch, vwsendingentities.fk_person AS fk_sender_person, vwsendingentities.fk_lu_message_standard, vwsendingentities.exclude_ft_report, vwsendingentities.abnormals_foreground_color, vwsendingentities.abnormals_background_color, vwsendingentities.exclude_pit, vwsendingentities.person_occupation, vwsendingentities.organisation, vwsendingentities.organisation_category, vwpatients.fk_person AS patient_fk_person, vwpatients.firstname AS patient_firstname, vwpatients.surname AS patient_surname, vwpatients.birthdate AS patient_birthdate, vwpatients.sex AS patient_sex, vwpatients.age_numeric AS patient_age, vwpatients.title AS patient_title, vwpatients.street1 AS patient_street1, vwpatients.street2 AS patient_street2, vwpatients.town AS patient_town, vwpatients.state AS patient_state, vwpatients.postcode AS patient_postcode, vwstaff.wholename AS staff_destination_wholename, vwstaff.title AS staff_destination_title, unmatched_patients.surname AS unmatched_patient_surname, unmatched_patients.firstname AS unmatched_patient_firstname, unmatched_patients.birthdate AS unmatched_patient_birthdate, unmatched_patients.sex AS unmatched_patient_sex, unmatched_patients.title AS unmatched_patient_title, unmatched_patients.street AS unmatched_patient_street, unmatched_patients.town AS unmatched_patient_town, unmatched_patients.postcode AS unmatched_patient_postcode, unmatched_patients.state AS unmatched_patient_state, unmatched_staff.surname AS unmatched_staff_surname, unmatched_staff.firstname AS unmatched_staff_firstname, unmatched_staff.title AS unmatched_staff_title, unmatched_staff.provider_number AS unmatched_staff_provider_number FROM ((((((documents JOIN vwsendingentities ON ((documents.fk_sending_entity = vwsendingentities.pk_sending_entities))) LEFT JOIN clin_requests.lu_request_type ON ((documents.fk_lu_request_type = lu_request_type.pk))) LEFT JOIN contacts.vwpatients ON ((documents.fk_patient = vwpatients.fk_patient))) LEFT JOIN admin.vwstaff ON ((documents.fk_staff_destination = vwstaff.fk_staff))) LEFT JOIN unmatched_patients ON ((documents.fk_unmatched_patient = unmatched_patients.pk))) LEFT JOIN unmatched_staff ON ((documents.fk_unmatched_staff = unmatched_staff.pk))) ORDER BY documents.fk_patient, documents.date_created;


ALTER TABLE documents.vwdocuments OWNER TO easygp;

SET search_path = clin_requests, pg_catalog;

--
-- Name: vwrequestsordered; Type: VIEW; Schema: clin_requests; Owner: easygp
--

CREATE VIEW vwrequestsordered AS
    SELECT ((forms.pk || '-'::text) || forms_requests.pk) AS pk_view, forms.fk_lu_request_type, lu_request_type.type, forms.fk_consult, consult.consult_date, consult.fk_patient, data_persons.firstname, data_persons.surname, data_persons.birthdate, data_persons.fk_sex, forms_requests.fk_form, forms.requests_summary, forms_requests.pk AS fk_forms_requests, lu_requests.item, forms.date, forms_requests.request_result_html, forms.fk_progressnote, forms_requests.fk_lu_request, forms_requests.deleted AS request_deleted, lu_requests.fk_laterality, lu_requests.fk_decision_support, lu_requests.fk_instruction, forms.fk_request_provider AS fk_branch, forms.notes_summary, forms.medications_summary, forms.copyto, forms.deleted, forms.copyto_patient, forms.urgent, forms.bulk_bill, forms.fasting, forms.phone, forms.fax, forms.include_medications, forms.pk_image AS fk_image, forms.fk_pasthistory, past_history.description, lu_title.title AS staff_title, staff.pk AS fk_staff, data_persons1.firstname AS staff_firstname, data_persons1.surname AS staff_surname, data_branches.branch, data_branches.fk_organisation, data_organisations.organisation, vwdocuments.html FROM (((((((((((((forms JOIN forms_requests ON ((forms.pk = forms_requests.fk_form))) JOIN lu_requests ON ((forms_requests.fk_lu_request = lu_requests.pk))) JOIN lu_request_type ON ((lu_requests.fk_lu_request_type = lu_request_type.pk))) JOIN clin_consult.consult ON ((forms.fk_consult = consult.pk))) JOIN clerical.data_patients ON ((consult.fk_patient = data_patients.pk))) JOIN contacts.data_persons ON ((data_patients.fk_person = data_persons.pk))) LEFT JOIN contacts.lu_title ON ((data_persons.fk_title = lu_title.pk))) JOIN admin.staff ON ((consult.fk_staff = staff.pk))) JOIN contacts.data_persons data_persons1 ON ((staff.fk_person = data_persons1.pk))) LEFT JOIN contacts.data_branches ON ((forms.fk_request_provider = data_branches.pk))) LEFT JOIN contacts.data_organisations ON ((data_branches.fk_organisation = data_organisations.pk))) LEFT JOIN clin_history.past_history ON ((forms.fk_pasthistory = past_history.pk))) LEFT JOIN documents.vwdocuments ON ((forms_requests.pk = vwdocuments.fk_request))) WHERE ((forms.deleted = false) AND (forms_requests.deleted = false)) ORDER BY consult.fk_patient, forms.date DESC, forms_requests.fk_form, lu_requests.item;


ALTER TABLE clin_requests.vwrequestsordered OWNER TO easygp;

--
-- Name: vwrequestsynonyms; Type: VIEW; Schema: clin_requests; Owner: easygp
--

CREATE VIEW vwrequestsynonyms AS
    SELECT lu_link_provider_user_requests.pk AS pk_lu_link_provider_user_requests, lu_link_provider_user_requests.provider_request_name, lu_link_provider_user_requests.lateralisation, lu_link_provider_user_requests.deleted, lu_requests.pk AS fk_lu_request, lu_requests.item AS user_request_name FROM lu_requests, lu_link_provider_user_requests WHERE (lu_link_provider_user_requests.fk_lu_request = lu_requests.pk);


ALTER TABLE clin_requests.vwrequestsynonyms OWNER TO easygp;

--
-- Name: vwuserproviderdefaults; Type: VIEW; Schema: clin_requests; Owner: easygp
--

CREATE VIEW vwuserproviderdefaults AS
    SELECT vwrequestproviders.type, vwrequestproviders.fk_headoffice_branch, vwrequestproviders.fk_employee, vwrequestproviders.fk_person, vwrequestproviders.fk_lu_request_type, vwrequestproviders.request_provider_deleted, vwrequestproviders.organisation, vwrequestproviders.category, vwrequestproviders.headoffice_branch, vwrequestproviders.fk_organisation, vwrequestproviders.headoffice_branch_deleted, vwrequestproviders.headoffice_street1, vwrequestproviders.headoffice_street2, vwrequestproviders.headoffice_address_deleted, vwrequestproviders.headoffice_postcode, vwrequestproviders.headoffice_town, vwrequestproviders.headoffice_state, vwrequestproviders.wholename, vwrequestproviders.firstname, vwrequestproviders.surname, vwrequestproviders.salutation, vwrequestproviders.fk_title, vwrequestproviders.title, vwrequestproviders.fk_sex, vwrequestproviders.sex, vwrequestproviders.fk_occupation, vwrequestproviders.occupation, user_provider_defaults.fk_staff, user_provider_defaults.fk_request_provider, user_provider_defaults.pk AS pk_default, user_provider_defaults.send_electronically, user_provider_defaults.print_paper, user_provider_defaults.deleted, user_provider_defaults.fk_default_branch, data_branches.branch AS default_branch, data_addresses.street1 AS default_branch_street1, data_addresses.street2 AS default_branch_street2, lu_towns.postcode AS default_branch_postcode, lu_towns.town AS default_branch_town, lu_towns.state AS default_branch_state, lu_request_type.type AS request_type FROM (((((user_provider_defaults JOIN vwrequestproviders ON ((user_provider_defaults.fk_request_provider = vwrequestproviders.pk_request_provider))) LEFT JOIN contacts.data_branches ON ((user_provider_defaults.fk_default_branch = data_branches.pk))) LEFT JOIN contacts.data_addresses ON ((data_branches.fk_address = data_addresses.pk))) LEFT JOIN contacts.lu_towns ON ((data_addresses.fk_town = lu_towns.pk))) JOIN lu_request_type ON ((user_provider_defaults.fk_lu_request_type = lu_request_type.pk))) ORDER BY user_provider_defaults.fk_staff;


ALTER TABLE clin_requests.vwuserproviderdefaults OWNER TO easygp;

SET search_path = clin_vaccination, pg_catalog;

--
-- Name: lu_descriptions; Type: TABLE; Schema: clin_vaccination; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_descriptions (
    pk integer NOT NULL,
    description text,
    deleted boolean DEFAULT false
);


ALTER TABLE clin_vaccination.lu_descriptions OWNER TO easygp;

--
-- Name: TABLE lu_descriptions; Type: COMMENT; Schema: clin_vaccination; Owner: easygp
--

COMMENT ON TABLE lu_descriptions IS 'create the vaccines_descriptions table contains names describing what the brand names are eg tetanus, diptheria, or combinations thereof ';


--
-- Name: lu_formulation; Type: TABLE; Schema: clin_vaccination; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_formulation (
    pk integer NOT NULL,
    form text NOT NULL
);


ALTER TABLE clin_vaccination.lu_formulation OWNER TO easygp;

--
-- Name: TABLE lu_formulation; Type: COMMENT; Schema: clin_vaccination; Owner: easygp
--

COMMENT ON TABLE lu_formulation IS 'probably temporary table, until drugs.form sorted
  but is the formulation of the vaccine';


--
-- Name: lu_formulation_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: easygp
--

CREATE SEQUENCE lu_formulation_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_vaccination.lu_formulation_pk_seq OWNER TO easygp;

--
-- Name: lu_formulation_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: easygp
--

ALTER SEQUENCE lu_formulation_pk_seq OWNED BY lu_formulation.pk;


--
-- Name: lu_schedules; Type: TABLE; Schema: clin_vaccination; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_schedules (
    pk integer NOT NULL,
    age_due_from_months integer,
    age_due_to_months integer,
    schedule text NOT NULL,
    female_only boolean DEFAULT false,
    atsi_only boolean DEFAULT false,
    fk_season integer,
    inactive boolean DEFAULT false,
    date_inactive date,
    deleted boolean DEFAULT false,
    multiple_vaccines boolean DEFAULT false,
    notes text
);


ALTER TABLE clin_vaccination.lu_schedules OWNER TO easygp;

--
-- Name: TABLE lu_schedules; Type: COMMENT; Schema: clin_vaccination; Owner: easygp
--

COMMENT ON TABLE lu_schedules IS 'create schedulescontains the schedules eg 2 month, 4 months, 4yrs etcA vaccination schedule can be a single vaccination or a schedule of
vaccination and contain one or more vaccines. The reason for this is complex
and practical referral to the doc for further information';


--
-- Name: COLUMN lu_schedules.schedule; Type: COMMENT; Schema: clin_vaccination; Owner: easygp
--

COMMENT ON COLUMN lu_schedules.schedule IS 'either a target disease name eg ''yellow fever'' or a schedule name to describe course of combined vaccines eg Hepatits A + Hepatitis B.Hence this allows unlimited and user defined schedules.';


--
-- Name: COLUMN lu_schedules.atsi_only; Type: COMMENT; Schema: clin_vaccination; Owner: easygp
--

COMMENT ON COLUMN lu_schedules.atsi_only IS 'australian requirement, some schedules apply only to aboriginal or torres strait islanders at particular ages';


--
-- Name: COLUMN lu_schedules.fk_season; Type: COMMENT; Schema: clin_vaccination; Owner: easygp
--

COMMENT ON COLUMN lu_schedules.fk_season IS 'eg. influenza prompts only wanted at particular time of year';


--
-- Name: COLUMN lu_schedules.multiple_vaccines; Type: COMMENT; Schema: clin_vaccination; Owner: easygp
--

COMMENT ON COLUMN lu_schedules.multiple_vaccines IS 'if TRUE this vaccine schedule aka target contains muliple separate vaccines
 for example in AU the 2 month childhood has 2 separate injections and 1 oral vaccine';


--
-- Name: COLUMN lu_schedules.notes; Type: COMMENT; Schema: clin_vaccination; Owner: easygp
--

COMMENT ON COLUMN lu_schedules.notes IS 'any additional notes, eg the NSW 12-13yrs schedule is a school program only';


--
-- Name: lu_schedules_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: easygp
--

CREATE SEQUENCE lu_schedules_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_vaccination.lu_schedules_pk_seq OWNER TO easygp;

--
-- Name: lu_schedules_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: easygp
--

ALTER SEQUENCE lu_schedules_pk_seq OWNED BY lu_schedules.pk;


--
-- Name: lu_vaccines; Type: TABLE; Schema: clin_vaccination; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_vaccines (
    pk integer NOT NULL,
    brand text,
    form text,
    fk_description integer,
    fk_route integer,
    inactive boolean DEFAULT false,
    deleted boolean DEFAULT false,
    fk_form integer
);


ALTER TABLE clin_vaccination.lu_vaccines OWNER TO easygp;

--
-- Name: TABLE lu_vaccines; Type: COMMENT; Schema: clin_vaccination; Owner: easygp
--

COMMENT ON TABLE lu_vaccines IS 'A Table to hold all vaccines.
 Note as the database will contain legacy data, some of these brand names are no
 longer commercially available, so inactive will be true.I''ve not put a date 
 inactive inactive in here as I didn''t think it was important, or usually knowable';


--
-- Name: lu_vaccines_descriptions_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: easygp
--

CREATE SEQUENCE lu_vaccines_descriptions_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_vaccination.lu_vaccines_descriptions_pk_seq OWNER TO easygp;

--
-- Name: lu_vaccines_descriptions_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: easygp
--

ALTER SEQUENCE lu_vaccines_descriptions_pk_seq OWNED BY lu_descriptions.pk;


--
-- Name: lu_vaccines_in_schedule; Type: TABLE; Schema: clin_vaccination; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_vaccines_in_schedule (
    pk integer NOT NULL,
    fk_vaccine integer,
    fk_schedule integer,
    atsi_only boolean DEFAULT false,
    date_inactive date
);


ALTER TABLE clin_vaccination.lu_vaccines_in_schedule OWNER TO easygp;

--
-- Name: lu_vaccines_in_schedule_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: easygp
--

CREATE SEQUENCE lu_vaccines_in_schedule_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_vaccination.lu_vaccines_in_schedule_pk_seq OWNER TO easygp;

--
-- Name: lu_vaccines_in_schedule_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: easygp
--

ALTER SEQUENCE lu_vaccines_in_schedule_pk_seq OWNED BY lu_vaccines_in_schedule.pk;


--
-- Name: lu_vaccines_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: easygp
--

CREATE SEQUENCE lu_vaccines_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_vaccination.lu_vaccines_pk_seq OWNER TO easygp;

--
-- Name: lu_vaccines_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: easygp
--

ALTER SEQUENCE lu_vaccines_pk_seq OWNED BY lu_vaccines.pk;


--
-- Name: vaccinations; Type: TABLE; Schema: clin_vaccination; Owner: easygp; Tablespace: 
--

CREATE TABLE vaccinations (
    pk integer NOT NULL,
    fk_vaccine integer,
    fk_schedule integer,
    fk_site integer DEFAULT 0 NOT NULL,
    fk_laterality integer,
    date_given character varying(10),
    serial_no text DEFAULT 'not recorded'::text NOT NULL,
    fk_progressnote integer,
    notes text,
    not_given boolean DEFAULT false,
    deleted boolean DEFAULT false
);


ALTER TABLE clin_vaccination.vaccinations OWNER TO easygp;

--
-- Name: COLUMN vaccinations.fk_site; Type: COMMENT; Schema: clin_vaccination; Owner: easygp
--

COMMENT ON COLUMN vaccinations.fk_site IS 'As sometimes we need to record a vaccine component as not given 
 for example when a child is having a catch up schedule then
 fk_site must be null';


--
-- Name: COLUMN vaccinations.date_given; Type: COMMENT; Schema: clin_vaccination; Owner: easygp
--

COMMENT ON COLUMN vaccinations.date_given IS 'not a date field because sometimes may need to record just say 01/2002 or 1998';


--
-- Name: COLUMN vaccinations.notes; Type: COMMENT; Schema: clin_vaccination; Owner: easygp
--

COMMENT ON COLUMN vaccinations.notes IS 'notes about the vaccine e.g this vaccine not given because child was 
 too old, in reference to a 6 month old getting her 2 month needles
 because  is late, hence no rotorix vaccine given';


--
-- Name: COLUMN vaccinations.not_given; Type: COMMENT; Schema: clin_vaccination; Owner: easygp
--

COMMENT ON COLUMN vaccinations.not_given IS 'if true then this vaccine was not given.  Recorded because a schedule
can have several vaccines and one may not be given - we need to know why';


--
-- Name: vaccinations_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: easygp
--

CREATE SEQUENCE vaccinations_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_vaccination.vaccinations_pk_seq OWNER TO easygp;

--
-- Name: vaccinations_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: easygp
--

ALTER SEQUENCE vaccinations_pk_seq OWNED BY vaccinations.pk;


--
-- Name: vaccine_serial_numbers; Type: TABLE; Schema: clin_vaccination; Owner: easygp; Tablespace: 
--

CREATE TABLE vaccine_serial_numbers (
    pk integer NOT NULL,
    fk_vaccine integer,
    serial_number text NOT NULL,
    date_used date NOT NULL
);


ALTER TABLE clin_vaccination.vaccine_serial_numbers OWNER TO easygp;

--
-- Name: TABLE vaccine_serial_numbers; Type: COMMENT; Schema: clin_vaccination; Owner: easygp
--

COMMENT ON TABLE vaccine_serial_numbers IS 'last used batch number to make it easier on the doctors typing when e.g vaccines may be stored in fridges in rooms in a surgery and most doctors and nurses work out of their own rooms. todo link to doctor code table';


--
-- Name: vaccine_serial_numbers_pk_seq; Type: SEQUENCE; Schema: clin_vaccination; Owner: easygp
--

CREATE SEQUENCE vaccine_serial_numbers_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_vaccination.vaccine_serial_numbers_pk_seq OWNER TO easygp;

--
-- Name: vaccine_serial_numbers_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_vaccination; Owner: easygp
--

ALTER SEQUENCE vaccine_serial_numbers_pk_seq OWNED BY vaccine_serial_numbers.pk;


--
-- Name: vwvaccineroutesadministration; Type: VIEW; Schema: clin_vaccination; Owner: easygp
--

CREATE VIEW vwvaccineroutesadministration AS
    SELECT lu_route_administration.pk, lu_route_administration.abbreviation, lu_route_administration.route FROM common.lu_route_administration WHERE (lu_route_administration.pk < 9);


ALTER TABLE clin_vaccination.vwvaccineroutesadministration OWNER TO easygp;

--
-- Name: vwvaccines; Type: VIEW; Schema: clin_vaccination; Owner: easygp
--

CREATE VIEW vwvaccines AS
    SELECT lu_vaccines.pk, lu_vaccines.brand, lu_vaccines.fk_form, lu_formulation.form, lu_vaccines.fk_description, lu_vaccines.fk_route, lu_route_administration.route, lu_vaccines.inactive AS vaccine_inactive, lu_vaccines.deleted, lu_descriptions.description, lu_descriptions.deleted AS decription_deleted FROM (((lu_vaccines JOIN lu_descriptions ON ((lu_vaccines.fk_description = lu_descriptions.pk))) LEFT JOIN common.lu_route_administration ON ((lu_vaccines.fk_route = lu_route_administration.pk))) LEFT JOIN lu_formulation ON ((lu_vaccines.fk_form = lu_formulation.pk))) ORDER BY lu_descriptions.description;


ALTER TABLE clin_vaccination.vwvaccines OWNER TO easygp;

SET search_path = common, pg_catalog;

--
-- Name: lu_seasons; Type: TABLE; Schema: common; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_seasons (
    pk integer NOT NULL,
    season text NOT NULL
);


ALTER TABLE common.lu_seasons OWNER TO easygp;

--
-- Name: lu_site_administration; Type: TABLE; Schema: common; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_site_administration (
    pk integer NOT NULL,
    site text NOT NULL,
    has_laterality boolean DEFAULT true
);


ALTER TABLE common.lu_site_administration OWNER TO easygp;

SET search_path = clin_vaccination, pg_catalog;

--
-- Name: vwvaccinesgiven; Type: VIEW; Schema: clin_vaccination; Owner: easygp
--

CREATE VIEW vwvaccinesgiven AS
    SELECT vaccinations.pk AS pk_view, vaccinations.pk AS fk_vaccination, consult.fk_patient, vwstaff.title AS staff_title, vwstaff.wholename AS staff_wholename, consult.consult_date, consult.fk_staff, consult.pk AS fk_consult, lu_schedules.age_due_from_months, lu_schedules.age_due_to_months, lu_schedules.schedule, lu_schedules.female_only, lu_schedules.atsi_only, lu_schedules.fk_season, lu_schedules.inactive AS schedule_inactive, lu_schedules.date_inactive AS date_schedule_inactive, lu_schedules.deleted AS schedule_deleted, lu_schedules.multiple_vaccines, lu_schedules.notes AS schedule_notes, lu_seasons.season, lu_laterality.laterality, lu_site_administration.site, progressnotes.notes AS progress_notes, lu_vaccines.brand, lu_vaccines.form, lu_vaccines.fk_description, lu_vaccines.fk_route, lu_vaccines.inactive, vaccinations.fk_vaccine, vaccinations.fk_schedule, vaccinations.fk_site, vaccinations.fk_laterality, vaccinations.date_given, vaccinations.serial_no, vaccinations.fk_progressnote, vaccinations.not_given, vaccinations.notes, vaccinations.deleted FROM ((((((((clin_consult.consult JOIN admin.vwstaff ON ((consult.fk_staff = vwstaff.fk_staff))) JOIN clin_consult.progressnotes ON ((progressnotes.fk_consult = consult.pk))) JOIN vaccinations ON ((vaccinations.fk_progressnote = progressnotes.pk))) LEFT JOIN common.lu_site_administration ON ((vaccinations.fk_site = lu_site_administration.pk))) LEFT JOIN common.lu_laterality ON ((vaccinations.fk_laterality = lu_laterality.pk))) JOIN lu_schedules ON ((vaccinations.fk_schedule = lu_schedules.pk))) JOIN lu_vaccines ON ((vaccinations.fk_vaccine = lu_vaccines.pk))) LEFT JOIN common.lu_seasons ON ((lu_schedules.fk_season = lu_seasons.pk)));


ALTER TABLE clin_vaccination.vwvaccinesgiven OWNER TO easygp;

--
-- Name: vwvaccinesinschedule; Type: VIEW; Schema: clin_vaccination; Owner: easygp
--

CREATE VIEW vwvaccinesinschedule AS
    SELECT lu_vaccines_in_schedule.pk AS pk_view, lu_vaccines_in_schedule.pk AS fk_lu_vaccines_in_schedule, lu_vaccines_in_schedule.fk_schedule, lu_vaccines_in_schedule.fk_vaccine, lu_vaccines_in_schedule.atsi_only AS vaccine_atsi_only, lu_vaccines_in_schedule.date_inactive AS date_vaccine_in_schedule_inactive, lu_schedules.age_due_from_months, lu_schedules.age_due_to_months, lu_schedules.schedule, lu_schedules.female_only AS schedule_female_only, lu_schedules.atsi_only AS schedule_atsi_only, lu_schedules.fk_season, lu_schedules.inactive AS schedule_inactive, lu_schedules.date_inactive AS date_schedule_inactive, lu_schedules.deleted AS schedule_deleted, lu_schedules.multiple_vaccines, lu_schedules.notes, lu_vaccines.brand, lu_vaccines.form, lu_vaccines.fk_description, lu_vaccines.fk_route, lu_vaccines.inactive AS vaccine_inactive, lu_seasons.season, lu_descriptions.description AS vaccine_description FROM ((((lu_vaccines_in_schedule JOIN lu_schedules ON ((lu_vaccines_in_schedule.fk_schedule = lu_schedules.pk))) JOIN lu_vaccines ON ((lu_vaccines_in_schedule.fk_vaccine = lu_vaccines.pk))) LEFT JOIN common.lu_seasons ON ((lu_schedules.fk_season = lu_seasons.pk))) JOIN lu_descriptions ON ((lu_vaccines.fk_description = lu_descriptions.pk))) ORDER BY lu_vaccines_in_schedule.fk_schedule, lu_vaccines.brand;


ALTER TABLE clin_vaccination.vwvaccinesinschedule OWNER TO easygp;

SET search_path = clin_workcover, pg_catalog;

--
-- Name: claims; Type: TABLE; Schema: clin_workcover; Owner: easygp; Tablespace: 
--

CREATE TABLE claims (
    pk integer NOT NULL,
    fk_consult integer NOT NULL,
    claim_number text,
    fk_occupation integer,
    fk_branch integer,
    hours_week_worked integer,
    mechanism_of_injury text,
    date_injury text NOT NULL,
    contact_person text,
    memo text,
    identifier text NOT NULL,
    fk_person integer,
    accepted boolean,
    deleted boolean DEFAULT false
);


ALTER TABLE clin_workcover.claims OWNER TO easygp;

--
-- Name: COLUMN claims.fk_consult; Type: COMMENT; Schema: clin_workcover; Owner: easygp
--

COMMENT ON COLUMN claims.fk_consult IS 'fk to clin_consult.consult, gives date the claim was first logged. Note the first visit.fk_consult will be same as this, but no subsequent ones will. Last visit.fk_consult = day claim was finalised';


--
-- Name: COLUMN claims.claim_number; Type: COMMENT; Schema: clin_workcover; Owner: easygp
--

COMMENT ON COLUMN claims.claim_number IS 'claim number for this workcover claim';


--
-- Name: COLUMN claims.fk_occupation; Type: COMMENT; Schema: clin_workcover; Owner: easygp
--

COMMENT ON COLUMN claims.fk_occupation IS 'foreign key to common.lu_occupations table
note that a person may have more than one occupation so this may not be the same key
as recorded in the patients entry in data_persons.fk_occupation';


--
-- Name: COLUMN claims.fk_branch; Type: COMMENT; Schema: clin_workcover; Owner: easygp
--

COMMENT ON COLUMN claims.fk_branch IS 'foreign key to contacts.data.organisations table or contacts.data_persons table where the employer is a person and not a company';


--
-- Name: COLUMN claims.date_injury; Type: COMMENT; Schema: clin_workcover; Owner: easygp
--

COMMENT ON COLUMN claims.date_injury IS 'if known, the date of injury ?how to handle vague dates here, so have made this text for now';


--
-- Name: COLUMN claims.contact_person; Type: COMMENT; Schema: clin_workcover; Owner: easygp
--

COMMENT ON COLUMN claims.contact_person IS 'A contact person for this claim
Note that this IS NOT related to 
fk_person field which is used where
the employer is a person and not a company';


--
-- Name: COLUMN claims.fk_person; Type: COMMENT; Schema: clin_workcover; Owner: easygp
--

COMMENT ON COLUMN claims.fk_person IS ' key to contacts.data_persons table where employer is a person and not an organisation';


--
-- Name: COLUMN claims.accepted; Type: COMMENT; Schema: clin_workcover; Owner: easygp
--

COMMENT ON COLUMN claims.accepted IS 'If True then the work cover claim as been accepted by the insurer';


--
-- Name: COLUMN claims.deleted; Type: COMMENT; Schema: clin_workcover; Owner: easygp
--

COMMENT ON COLUMN claims.deleted IS 'if true the claim is marked as deleted';


--
-- Name: claims_pk_seq; Type: SEQUENCE; Schema: clin_workcover; Owner: easygp
--

CREATE SEQUENCE claims_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_workcover.claims_pk_seq OWNER TO easygp;

--
-- Name: claims_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_workcover; Owner: easygp
--

ALTER SEQUENCE claims_pk_seq OWNED BY claims.pk;


--
-- Name: lu_caused_by_employment; Type: TABLE; Schema: clin_workcover; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_caused_by_employment (
    pk integer NOT NULL,
    caused_by_employment text
);


ALTER TABLE clin_workcover.lu_caused_by_employment OWNER TO easygp;

--
-- Name: TABLE lu_caused_by_employment; Type: COMMENT; Schema: clin_workcover; Owner: easygp
--

COMMENT ON TABLE lu_caused_by_employment IS 'degree of certainty that the workcover injury was caused by employment';


--
-- Name: lu_caused_by_employment_pk_seq; Type: SEQUENCE; Schema: clin_workcover; Owner: easygp
--

CREATE SEQUENCE lu_caused_by_employment_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_workcover.lu_caused_by_employment_pk_seq OWNER TO easygp;

--
-- Name: lu_caused_by_employment_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_workcover; Owner: easygp
--

ALTER SEQUENCE lu_caused_by_employment_pk_seq OWNED BY lu_caused_by_employment.pk;


--
-- Name: lu_visit_type; Type: TABLE; Schema: clin_workcover; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_visit_type (
    pk integer NOT NULL,
    type text NOT NULL
);


ALTER TABLE clin_workcover.lu_visit_type OWNER TO easygp;

--
-- Name: TABLE lu_visit_type; Type: COMMENT; Schema: clin_workcover; Owner: easygp
--

COMMENT ON TABLE lu_visit_type IS 'type of workcover consultation lookup table - can be Initial, Progress or the Final consulation';


--
-- Name: COLUMN lu_visit_type.type; Type: COMMENT; Schema: clin_workcover; Owner: easygp
--

COMMENT ON COLUMN lu_visit_type.type IS 'Initial Progress or Final or Initial and Final';


--
-- Name: lu_visit_type_pk_seq; Type: SEQUENCE; Schema: clin_workcover; Owner: easygp
--

CREATE SEQUENCE lu_visit_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_workcover.lu_visit_type_pk_seq OWNER TO easygp;

--
-- Name: lu_visit_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_workcover; Owner: easygp
--

ALTER SEQUENCE lu_visit_type_pk_seq OWNED BY lu_visit_type.pk;


--
-- Name: visits; Type: TABLE; Schema: clin_workcover; Owner: easygp; Tablespace: 
--

CREATE TABLE visits (
    pk integer NOT NULL,
    fk_claim integer NOT NULL,
    fk_lu_visit_type integer NOT NULL,
    diagnosis text NOT NULL,
    fk_code text,
    management_plan text,
    review_date date,
    assessworkplace boolean DEFAULT false NOT NULL,
    hours_capable integer,
    days_capable integer,
    restrictions text,
    fk_caused_by_employment integer NOT NULL,
    doctor_consented boolean DEFAULT true,
    worker_consented boolean DEFAULT true,
    fitness_preinjury_from date,
    fitness_suitable_from date,
    fitness_suitable_to date,
    fitness_unfit_from date,
    fitness_unfit_to date,
    fitness_perm_mod_duties_from date,
    fk_consult integer,
    fk_progressnote integer,
    fk_coding_system integer,
    capabilities text,
    certificate_date date,
    latex text,
    deleted boolean DEFAULT false
);


ALTER TABLE clin_workcover.visits OWNER TO easygp;

--
-- Name: COLUMN visits.fk_claim; Type: COMMENT; Schema: clin_workcover; Owner: easygp
--

COMMENT ON COLUMN visits.fk_claim IS 'foreign key linking to claims table';


--
-- Name: COLUMN visits.fk_lu_visit_type; Type: COMMENT; Schema: clin_workcover; Owner: easygp
--

COMMENT ON COLUMN visits.fk_lu_visit_type IS 'key to lu_visit_type table';


--
-- Name: COLUMN visits.diagnosis; Type: COMMENT; Schema: clin_workcover; Owner: easygp
--

COMMENT ON COLUMN visits.diagnosis IS 'the diagnosis may be free text but could be coded';


--
-- Name: COLUMN visits.fk_code; Type: COMMENT; Schema: clin_workcover; Owner: easygp
--

COMMENT ON COLUMN visits.fk_code IS ' key to coding.generic_terms table';


--
-- Name: COLUMN visits.management_plan; Type: COMMENT; Schema: clin_workcover; Owner: easygp
--

COMMENT ON COLUMN visits.management_plan IS 'description of the managment plan';


--
-- Name: COLUMN visits.review_date; Type: COMMENT; Schema: clin_workcover; Owner: easygp
--

COMMENT ON COLUMN visits.review_date IS 'Date the treatment plan will be reviewed';


--
-- Name: COLUMN visits.hours_capable; Type: COMMENT; Schema: clin_workcover; Owner: easygp
--

COMMENT ON COLUMN visits.hours_capable IS 'number of hours in the day capable';


--
-- Name: COLUMN visits.days_capable; Type: COMMENT; Schema: clin_workcover; Owner: easygp
--

COMMENT ON COLUMN visits.days_capable IS 'number of days in a week capable of working';


--
-- Name: COLUMN visits.doctor_consented; Type: COMMENT; Schema: clin_workcover; Owner: easygp
--

COMMENT ON COLUMN visits.doctor_consented IS 'if true doctor consented. Note this is not in the 
encounter table because doctor could at any time change his mind and terminate the agreement, hence though it
will usually be the same for all vists it may not be';


--
-- Name: COLUMN visits.worker_consented; Type: COMMENT; Schema: clin_workcover; Owner: easygp
--

COMMENT ON COLUMN visits.worker_consented IS 'if true worker consented. Note this is not in the 
encounter table because worker could at any time change his mind and terminate the agreement, hence though it
will usually be the same for all vists it may not be';


--
-- Name: COLUMN visits.fk_progressnote; Type: COMMENT; Schema: clin_workcover; Owner: easygp
--

COMMENT ON COLUMN visits.fk_progressnote IS 'key to clin_consult.progressnotes points to last progress note associated with this visit';


--
-- Name: COLUMN visits.fk_coding_system; Type: COMMENT; Schema: clin_workcover; Owner: easygp
--

COMMENT ON COLUMN visits.fk_coding_system IS 'if not null this is the coding system used for the coded diagnosis';


--
-- Name: COLUMN visits.certificate_date; Type: COMMENT; Schema: clin_workcover; Owner: easygp
--

COMMENT ON COLUMN visits.certificate_date IS 'The certificate date, usually now() but sometimes needs to be backdated, for example if
 replacing a paper certificate with an electronic one when copy needed';


--
-- Name: COLUMN visits.latex; Type: COMMENT; Schema: clin_workcover; Owner: easygp
--

COMMENT ON COLUMN visits.latex IS 'the LaTex definition of the workcover form';


--
-- Name: COLUMN visits.deleted; Type: COMMENT; Schema: clin_workcover; Owner: easygp
--

COMMENT ON COLUMN visits.deleted IS 'if true the visit is marked as deleted';


--
-- Name: visits_pk_seq; Type: SEQUENCE; Schema: clin_workcover; Owner: easygp
--

CREATE SEQUENCE visits_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clin_workcover.visits_pk_seq OWNER TO easygp;

--
-- Name: visits_pk_seq; Type: SEQUENCE OWNED BY; Schema: clin_workcover; Owner: easygp
--

ALTER SEQUENCE visits_pk_seq OWNED BY visits.pk;


--
-- Name: vwworkcover; Type: VIEW; Schema: clin_workcover; Owner: easygp
--

CREATE VIEW vwworkcover AS
    SELECT visits.pk AS pk_view, visits.pk AS fk_visit, visits.fk_claim, consult1.consult_date AS start_date, consult.consult_date AS visit_date, consult.fk_patient, claims.claim_number, claims.fk_occupation, claims.fk_branch, claims.hours_week_worked, claims.mechanism_of_injury, claims.date_injury, claims.contact_person, claims.memo, claims.identifier, claims.fk_person, claims.accepted, claims.deleted AS claim_deleted, consult.fk_staff, consult.fk_type, consult.summary, vwstaff.wholename AS staff_wholename, vwstaff.surname AS staff_surname, vwstaff.firstname AS staff_firstname, vwstaff.title AS staff_title, lu_occupations.occupation, vworganisations.branch, vworganisations.fk_organisation, vworganisations.organisation, vworganisations.street1 AS branch_street1, vworganisations.street2 AS branch_street2, vworganisations.town AS branch_town, vworganisations.branch_deleted, vwpersons.wholename AS soletrader_wholename, vwpersons.firstname AS soletrader_firstname, vwpersons.surname AS soletrader_surname, vwpersons.title AS soletrader_title, vwpersons.town AS soletrader_town, vwpersons.street1 AS soletrader_street1, vwpersons.street2 AS soletrader_street2, vwpersons.postcode AS soletrader_postcode, vwpersons.address_deleted AS soletrader_address_deleted, lu_visit_type.type AS visit_type, visits.fk_lu_visit_type, visits.diagnosis, lu_systems.system AS coding_system, visits.fk_code, CASE WHEN (visits.fk_code IS NOT NULL) THEN (SELECT DISTINCT generic_terms.term FROM coding.generic_terms WHERE (visits.fk_code = generic_terms.code)) ELSE NULL::text END AS coded_term, visits.certificate_date, visits.management_plan, visits.review_date, visits.assessworkplace, visits.hours_capable, visits.days_capable, visits.restrictions, visits.fk_caused_by_employment, visits.doctor_consented, visits.worker_consented, visits.fitness_preinjury_from, visits.fitness_suitable_from, visits.fitness_suitable_to, visits.fitness_unfit_from, visits.fitness_unfit_to, visits.fitness_perm_mod_duties_from, visits.fk_consult, visits.fk_progressnote, visits.fk_coding_system, visits.capabilities, visits.latex, visits.deleted AS visit_deleted, lu_caused_by_employment.caused_by_employment, consult1.pk AS fk_consult_claim FROM ((((((((((clin_consult.consult JOIN admin.vwstaff ON ((consult.fk_staff = vwstaff.fk_staff))) JOIN visits ON ((visits.fk_consult = consult.pk))) JOIN claims ON ((claims.pk = visits.fk_claim))) JOIN common.lu_occupations ON ((claims.fk_occupation = lu_occupations.pk))) LEFT JOIN coding.lu_systems ON ((visits.fk_coding_system = lu_systems.pk))) LEFT JOIN contacts.vworganisations ON ((claims.fk_branch = vworganisations.fk_branch))) LEFT JOIN contacts.vwpersons ON ((claims.fk_person = vwpersons.fk_person))) JOIN lu_visit_type ON ((visits.fk_lu_visit_type = lu_visit_type.pk))) JOIN lu_caused_by_employment ON ((visits.fk_caused_by_employment = lu_caused_by_employment.pk))) JOIN clin_consult.consult consult1 ON ((claims.fk_consult = consult1.pk)));


ALTER TABLE clin_workcover.vwworkcover OWNER TO easygp;

SET search_path = coding, pg_catalog;

--
-- Name: lu_loinc; Type: TABLE; Schema: coding; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_loinc (
    loinc_num text,
    component text,
    property text,
    time_aspct text,
    system text,
    scale_typ text,
    method_typ text,
    relat_nms text,
    class text,
    source text,
    dt_last_ch text,
    chng_type text,
    comments text,
    answerlist text,
    status text,
    map_to text,
    scope text,
    consumer_name text,
    ipcc_units text,
    reference text,
    exact_cmp_sy text,
    molar_mass text,
    classtype integer,
    formula text,
    species text,
    exmpl_answers text,
    acssym text,
    base_name text,
    final text,
    naaccr_id text,
    code_table text,
    setroot integer,
    panelelements text,
    survey_quest_text text,
    survey_quest_src text,
    unitsrequired text,
    submitted_units text,
    relatednames2 text,
    shortname text,
    order_obs text,
    cdisc_common_tests text,
    hl7_field_subfield_id text,
    external_copyright_notice text,
    example_units text,
    inpc_percentage numeric,
    long_common_name text,
    hl7_v2_datatype text,
    hl7_v3_datatype text,
    curated_range_and_units text,
    document_section text,
    definition_description_help text,
    example_ucum_units text
);


ALTER TABLE coding.lu_loinc OWNER TO easygp;

--
-- Name: lu_loinc_abbrev; Type: TABLE; Schema: coding; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_loinc_abbrev (
    pk integer NOT NULL,
    loinc_num text,
    component text,
    system text
);


ALTER TABLE coding.lu_loinc_abbrev OWNER TO easygp;

--
-- Name: lu_loinc_abbrev_pk_seq; Type: SEQUENCE; Schema: coding; Owner: easygp
--

CREATE SEQUENCE lu_loinc_abbrev_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE coding.lu_loinc_abbrev_pk_seq OWNER TO easygp;

--
-- Name: lu_loinc_abbrev_pk_seq; Type: SEQUENCE OWNED BY; Schema: coding; Owner: easygp
--

ALTER SEQUENCE lu_loinc_abbrev_pk_seq OWNED BY lu_loinc_abbrev.pk;


--
-- Name: lu_systems_pk_seq; Type: SEQUENCE; Schema: coding; Owner: easygp
--

CREATE SEQUENCE lu_systems_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE coding.lu_systems_pk_seq OWNER TO easygp;

--
-- Name: lu_systems_pk_seq; Type: SEQUENCE OWNED BY; Schema: coding; Owner: easygp
--

ALTER SEQUENCE lu_systems_pk_seq OWNED BY lu_systems.pk;


--
-- Name: user_terms_pk_seq; Type: SEQUENCE; Schema: coding; Owner: easygp
--

CREATE SEQUENCE user_terms_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE coding.user_terms_pk_seq OWNER TO easygp;

--
-- Name: usr_codes_weighting; Type: TABLE; Schema: coding; Owner: easygp; Tablespace: 
--

CREATE TABLE usr_codes_weighting (
    pk integer NOT NULL,
    code text NOT NULL,
    fk_coding_system integer NOT NULL,
    fk_staff integer NOT NULL,
    weighting integer NOT NULL
);


ALTER TABLE coding.usr_codes_weighting OWNER TO easygp;

--
-- Name: usr_codes_weighting_pk_seq; Type: SEQUENCE; Schema: coding; Owner: easygp
--

CREATE SEQUENCE usr_codes_weighting_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE coding.usr_codes_weighting_pk_seq OWNER TO easygp;

--
-- Name: usr_codes_weighting_pk_seq; Type: SEQUENCE OWNED BY; Schema: coding; Owner: easygp
--

ALTER SEQUENCE usr_codes_weighting_pk_seq OWNED BY usr_codes_weighting.pk;


--
-- Name: vwcodesweighted; Type: VIEW; Schema: coding; Owner: easygp
--

CREATE VIEW vwcodesweighted AS
    SELECT t.code, t.fk_coding_system, t.term, w.fk_staff, w.weighting FROM (generic_terms t LEFT JOIN usr_codes_weighting w ON (((t.code = w.code) AND (w.fk_coding_system = t.fk_coding_system))));


ALTER TABLE coding.vwcodesweighted OWNER TO easygp;

--
-- Name: vwgenericterms; Type: VIEW; Schema: coding; Owner: easygp
--

CREATE VIEW vwgenericterms AS
    SELECT DISTINCT generic_terms.code AS pk_view, generic_terms.code, generic_terms.body_system, generic_terms.code_role, generic_terms.term, generic_terms.fk_coding_system, generic_terms.icd10, generic_terms.active, s.system, s.preferred FROM generic_terms, lu_systems s WHERE (s.pk = generic_terms.fk_coding_system);


ALTER TABLE coding.vwgenericterms OWNER TO easygp;

SET search_path = common, pg_catalog;

--
-- Name: lu_aboriginality_pk_seq; Type: SEQUENCE; Schema: common; Owner: easygp
--

CREATE SEQUENCE lu_aboriginality_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE common.lu_aboriginality_pk_seq OWNER TO easygp;

--
-- Name: lu_aboriginality_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: easygp
--

ALTER SEQUENCE lu_aboriginality_pk_seq OWNED BY lu_aboriginality.pk;


--
-- Name: lu_anatomical_localisation; Type: TABLE; Schema: common; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_anatomical_localisation (
    pk integer NOT NULL,
    term text NOT NULL
);


ALTER TABLE common.lu_anatomical_localisation OWNER TO easygp;

--
-- Name: lu_anatomical_location_pk_seq; Type: SEQUENCE; Schema: common; Owner: easygp
--

CREATE SEQUENCE lu_anatomical_location_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE common.lu_anatomical_location_pk_seq OWNER TO easygp;

--
-- Name: lu_anatomical_location_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: easygp
--

ALTER SEQUENCE lu_anatomical_location_pk_seq OWNED BY lu_anatomical_localisation.pk;


--
-- Name: lu_anatomical_site_pk_seq; Type: SEQUENCE; Schema: common; Owner: easygp
--

CREATE SEQUENCE lu_anatomical_site_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE common.lu_anatomical_site_pk_seq OWNER TO easygp;

--
-- Name: lu_anatomical_site_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: easygp
--

ALTER SEQUENCE lu_anatomical_site_pk_seq OWNED BY lu_anatomical_site.pk;


--
-- Name: lu_anterior_posterior_pk_seq; Type: SEQUENCE; Schema: common; Owner: easygp
--

CREATE SEQUENCE lu_anterior_posterior_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE common.lu_anterior_posterior_pk_seq OWNER TO easygp;

--
-- Name: lu_anterior_posterior_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: easygp
--

ALTER SEQUENCE lu_anterior_posterior_pk_seq OWNED BY lu_anterior_posterior.pk;


--
-- Name: lu_companion_status; Type: TABLE; Schema: common; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_companion_status (
    pk integer NOT NULL,
    status text NOT NULL
);


ALTER TABLE common.lu_companion_status OWNER TO easygp;

--
-- Name: lu_companion_status_pk_seq; Type: SEQUENCE; Schema: common; Owner: easygp
--

CREATE SEQUENCE lu_companion_status_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE common.lu_companion_status_pk_seq OWNER TO easygp;

--
-- Name: lu_companion_status_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: easygp
--

ALTER SEQUENCE lu_companion_status_pk_seq OWNED BY lu_companion_status.pk;


--
-- Name: lu_countries_pk_seq; Type: SEQUENCE; Schema: common; Owner: easygp
--

CREATE SEQUENCE lu_countries_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE common.lu_countries_pk_seq OWNER TO easygp;

--
-- Name: lu_countries_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: easygp
--

ALTER SEQUENCE lu_countries_pk_seq OWNED BY lu_countries.pk;


--
-- Name: lu_ethnicity_pk_seq; Type: SEQUENCE; Schema: common; Owner: easygp
--

CREATE SEQUENCE lu_ethnicity_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE common.lu_ethnicity_pk_seq OWNER TO easygp;

--
-- Name: lu_ethnicity_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: easygp
--

ALTER SEQUENCE lu_ethnicity_pk_seq OWNED BY lu_ethnicity.pk;


--
-- Name: lu_family_relationships_pk_seq; Type: SEQUENCE; Schema: common; Owner: easygp
--

CREATE SEQUENCE lu_family_relationships_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE common.lu_family_relationships_pk_seq OWNER TO easygp;

--
-- Name: lu_family_relationships_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: easygp
--

ALTER SEQUENCE lu_family_relationships_pk_seq OWNED BY lu_family_relationships.pk;


--
-- Name: lu_formulation; Type: TABLE; Schema: common; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_formulation (
    pk integer NOT NULL,
    form text NOT NULL
);


ALTER TABLE common.lu_formulation OWNER TO easygp;

--
-- Name: lu_formulation_pk_seq; Type: SEQUENCE; Schema: common; Owner: easygp
--

CREATE SEQUENCE lu_formulation_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE common.lu_formulation_pk_seq OWNER TO easygp;

--
-- Name: lu_formulation_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: easygp
--

ALTER SEQUENCE lu_formulation_pk_seq OWNED BY lu_formulation.pk;


--
-- Name: lu_hearing_aid_status; Type: TABLE; Schema: common; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_hearing_aid_status (
    pk integer NOT NULL,
    status text NOT NULL
);


ALTER TABLE common.lu_hearing_aid_status OWNER TO easygp;

--
-- Name: lu_hearing_aid_status_pk_seq; Type: SEQUENCE; Schema: common; Owner: easygp
--

CREATE SEQUENCE lu_hearing_aid_status_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE common.lu_hearing_aid_status_pk_seq OWNER TO easygp;

--
-- Name: lu_hearing_aid_status_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: easygp
--

ALTER SEQUENCE lu_hearing_aid_status_pk_seq OWNED BY lu_hearing_aid_status.pk;


--
-- Name: lu_languages_pk_seq; Type: SEQUENCE; Schema: common; Owner: easygp
--

CREATE SEQUENCE lu_languages_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE common.lu_languages_pk_seq OWNER TO easygp;

--
-- Name: lu_languages_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: easygp
--

ALTER SEQUENCE lu_languages_pk_seq OWNED BY lu_languages.pk;


--
-- Name: lu_laterality_pk_seq; Type: SEQUENCE; Schema: common; Owner: easygp
--

CREATE SEQUENCE lu_laterality_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE common.lu_laterality_pk_seq OWNER TO easygp;

--
-- Name: lu_laterality_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: easygp
--

ALTER SEQUENCE lu_laterality_pk_seq OWNED BY lu_laterality.pk;


--
-- Name: lu_medicolegal; Type: TABLE; Schema: common; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_medicolegal (
    pk integer NOT NULL,
    medicolegal_action text NOT NULL
);


ALTER TABLE common.lu_medicolegal OWNER TO easygp;

--
-- Name: TABLE lu_medicolegal; Type: COMMENT; Schema: common; Owner: easygp
--

COMMENT ON TABLE lu_medicolegal IS ' list of medicolegal things eg - patient informed of risks - user extensible';


--
-- Name: lu_medicolegal_pk_seq; Type: SEQUENCE; Schema: common; Owner: easygp
--

CREATE SEQUENCE lu_medicolegal_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE common.lu_medicolegal_pk_seq OWNER TO easygp;

--
-- Name: lu_medicolegal_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: easygp
--

ALTER SEQUENCE lu_medicolegal_pk_seq OWNED BY lu_medicolegal.pk;


--
-- Name: lu_motion; Type: TABLE; Schema: common; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_motion (
    pk integer NOT NULL,
    motion text NOT NULL
);


ALTER TABLE common.lu_motion OWNER TO easygp;

--
-- Name: lu_motion_pk_seq; Type: SEQUENCE; Schema: common; Owner: easygp
--

CREATE SEQUENCE lu_motion_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE common.lu_motion_pk_seq OWNER TO easygp;

--
-- Name: lu_motion_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: easygp
--

ALTER SEQUENCE lu_motion_pk_seq OWNED BY lu_motion.pk;


--
-- Name: lu_normality; Type: TABLE; Schema: common; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_normality (
    pk integer NOT NULL,
    normality text NOT NULL
);


ALTER TABLE common.lu_normality OWNER TO easygp;

--
-- Name: lu_normality_pk_seq; Type: SEQUENCE; Schema: common; Owner: easygp
--

CREATE SEQUENCE lu_normality_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE common.lu_normality_pk_seq OWNER TO easygp;

--
-- Name: lu_normality_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: easygp
--

ALTER SEQUENCE lu_normality_pk_seq OWNED BY lu_normality.pk;


--
-- Name: lu_occupations_pk_seq; Type: SEQUENCE; Schema: common; Owner: easygp
--

CREATE SEQUENCE lu_occupations_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE common.lu_occupations_pk_seq OWNER TO easygp;

--
-- Name: lu_occupations_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: easygp
--

ALTER SEQUENCE lu_occupations_pk_seq OWNED BY lu_occupations.pk;


--
-- Name: lu_proximal_distal; Type: TABLE; Schema: common; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_proximal_distal (
    pk integer NOT NULL,
    proximal_distal text
);


ALTER TABLE common.lu_proximal_distal OWNER TO easygp;

--
-- Name: lu_proximal_distal_pk_seq; Type: SEQUENCE; Schema: common; Owner: easygp
--

CREATE SEQUENCE lu_proximal_distal_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE common.lu_proximal_distal_pk_seq OWNER TO easygp;

--
-- Name: lu_proximal_distal_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: easygp
--

ALTER SEQUENCE lu_proximal_distal_pk_seq OWNED BY lu_proximal_distal.pk;


--
-- Name: lu_recreational_drugs_pk_seq; Type: SEQUENCE; Schema: common; Owner: easygp
--

CREATE SEQUENCE lu_recreational_drugs_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE common.lu_recreational_drugs_pk_seq OWNER TO easygp;

--
-- Name: lu_recreational_drugs_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: easygp
--

ALTER SEQUENCE lu_recreational_drugs_pk_seq OWNED BY lu_recreational_drugs.pk;


--
-- Name: lu_religions; Type: TABLE; Schema: common; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_religions (
    pk integer NOT NULL,
    religion text NOT NULL
);


ALTER TABLE common.lu_religions OWNER TO easygp;

--
-- Name: TABLE lu_religions; Type: COMMENT; Schema: common; Owner: easygp
--

COMMENT ON TABLE lu_religions IS 'The -core- religions eg christiantity, the sub religions are
 in the table lu_sub_religion';


--
-- Name: lu_religions_pk_seq; Type: SEQUENCE; Schema: common; Owner: easygp
--

CREATE SEQUENCE lu_religions_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE common.lu_religions_pk_seq OWNER TO easygp;

--
-- Name: lu_religions_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: easygp
--

ALTER SEQUENCE lu_religions_pk_seq OWNED BY lu_religions.pk;


--
-- Name: lu_route_administration_pk_seq; Type: SEQUENCE; Schema: common; Owner: easygp
--

CREATE SEQUENCE lu_route_administration_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE common.lu_route_administration_pk_seq OWNER TO easygp;

--
-- Name: lu_route_administration_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: easygp
--

ALTER SEQUENCE lu_route_administration_pk_seq OWNED BY lu_route_administration.pk;


--
-- Name: lu_seasons_pk_seq; Type: SEQUENCE; Schema: common; Owner: easygp
--

CREATE SEQUENCE lu_seasons_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE common.lu_seasons_pk_seq OWNER TO easygp;

--
-- Name: lu_seasons_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: easygp
--

ALTER SEQUENCE lu_seasons_pk_seq OWNED BY lu_seasons.pk;


--
-- Name: lu_site_administration_pk_seq; Type: SEQUENCE; Schema: common; Owner: easygp
--

CREATE SEQUENCE lu_site_administration_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE common.lu_site_administration_pk_seq OWNER TO easygp;

--
-- Name: lu_site_administration_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: easygp
--

ALTER SEQUENCE lu_site_administration_pk_seq OWNED BY lu_site_administration.pk;


--
-- Name: lu_smoking_status; Type: TABLE; Schema: common; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_smoking_status (
    pk integer NOT NULL,
    status text NOT NULL
);


ALTER TABLE common.lu_smoking_status OWNER TO easygp;

--
-- Name: lu_smoking_status_pk_seq; Type: SEQUENCE; Schema: common; Owner: easygp
--

CREATE SEQUENCE lu_smoking_status_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE common.lu_smoking_status_pk_seq OWNER TO easygp;

--
-- Name: lu_smoking_status_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: easygp
--

ALTER SEQUENCE lu_smoking_status_pk_seq OWNED BY lu_smoking_status.pk;


--
-- Name: lu_social_support; Type: TABLE; Schema: common; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_social_support (
    pk integer NOT NULL,
    support text NOT NULL
);


ALTER TABLE common.lu_social_support OWNER TO easygp;

--
-- Name: lu_social_support_pk_seq; Type: SEQUENCE; Schema: common; Owner: easygp
--

CREATE SEQUENCE lu_social_support_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE common.lu_social_support_pk_seq OWNER TO easygp;

--
-- Name: lu_social_support_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: easygp
--

ALTER SEQUENCE lu_social_support_pk_seq OWNED BY lu_social_support.pk;


--
-- Name: lu_sub_religions; Type: TABLE; Schema: common; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_sub_religions (
    pk integer NOT NULL,
    fk_religion integer NOT NULL,
    sub_religion text NOT NULL
);


ALTER TABLE common.lu_sub_religions OWNER TO easygp;

--
-- Name: TABLE lu_sub_religions; Type: COMMENT; Schema: common; Owner: easygp
--

COMMENT ON TABLE lu_sub_religions IS 'The eg christiantity may be Baptist, Methodist';


--
-- Name: lu_sub_religions_pk_seq; Type: SEQUENCE; Schema: common; Owner: easygp
--

CREATE SEQUENCE lu_sub_religions_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE common.lu_sub_religions_pk_seq OWNER TO easygp;

--
-- Name: lu_sub_religions_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: easygp
--

ALTER SEQUENCE lu_sub_religions_pk_seq OWNED BY lu_sub_religions.pk;


--
-- Name: lu_units_pk_seq; Type: SEQUENCE; Schema: common; Owner: easygp
--

CREATE SEQUENCE lu_units_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE common.lu_units_pk_seq OWNER TO easygp;

--
-- Name: lu_units_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: easygp
--

ALTER SEQUENCE lu_units_pk_seq OWNED BY lu_units.pk;


--
-- Name: lu_urgency_pk_seq; Type: SEQUENCE; Schema: common; Owner: easygp
--

CREATE SEQUENCE lu_urgency_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE common.lu_urgency_pk_seq OWNER TO easygp;

--
-- Name: lu_urgency_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: easygp
--

ALTER SEQUENCE lu_urgency_pk_seq OWNED BY lu_urgency.pk;


--
-- Name: lu_whisper_test; Type: TABLE; Schema: common; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_whisper_test (
    pk integer NOT NULL,
    hearing_result text NOT NULL
);


ALTER TABLE common.lu_whisper_test OWNER TO easygp;

--
-- Name: lu_whisper_test_pk_seq; Type: SEQUENCE; Schema: common; Owner: easygp
--

CREATE SEQUENCE lu_whisper_test_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE common.lu_whisper_test_pk_seq OWNER TO easygp;

--
-- Name: lu_whisper_test_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: easygp
--

ALTER SEQUENCE lu_whisper_test_pk_seq OWNED BY lu_whisper_test.pk;


--
-- Name: vwrecreationaldrugs; Type: VIEW; Schema: common; Owner: ian
--

CREATE VIEW vwrecreationaldrugs AS
    SELECT lu_recreational_drugs.pk, lu_recreational_drugs.drug, lu_route_administration.route, lu_recreational_drugs.alternative_names, lu_recreational_drugs.illicit, lu_recreational_drugs.quantification, lu_recreational_drugs.default_fk_lu_route_administration FROM lu_route_administration, lu_recreational_drugs WHERE (lu_recreational_drugs.default_fk_lu_route_administration = lu_route_administration.pk);


ALTER TABLE common.vwrecreationaldrugs OWNER TO ian;

--
-- Name: vwreligions; Type: VIEW; Schema: common; Owner: easygp
--

CREATE VIEW vwreligions AS
    SELECT CASE WHEN (lu_sub_religions.fk_religion > 0) THEN ((lu_religions.pk || '-'::text) || lu_sub_religions.pk) ELSE (lu_religions.pk || '-0'::text) END AS pk_view, lu_religions.religion, lu_sub_religions.sub_religion, lu_religions.pk AS fk_religion, lu_sub_religions.pk AS fk_lu_sub_religion FROM (lu_sub_religions RIGHT JOIN lu_religions ON ((lu_sub_religions.fk_religion = lu_religions.pk))) ORDER BY lu_sub_religions.fk_religion, lu_sub_religions.pk;


ALTER TABLE common.vwreligions OWNER TO easygp;

SET search_path = contacts, pg_catalog;

--
-- Name: data_addresses_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: easygp
--

CREATE SEQUENCE data_addresses_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contacts.data_addresses_pk_seq OWNER TO easygp;

--
-- Name: data_addresses_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: easygp
--

ALTER SEQUENCE data_addresses_pk_seq OWNED BY data_addresses.pk;


--
-- Name: data_branches_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: easygp
--

CREATE SEQUENCE data_branches_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contacts.data_branches_pk_seq OWNER TO easygp;

--
-- Name: data_branches_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: easygp
--

ALTER SEQUENCE data_branches_pk_seq OWNED BY data_branches.pk;


--
-- Name: data_communications; Type: TABLE; Schema: contacts; Owner: easygp; Tablespace: 
--

CREATE TABLE data_communications (
    pk integer NOT NULL,
    value text NOT NULL,
    note text,
    preferred_method boolean DEFAULT false,
    confidential boolean DEFAULT false,
    deleted boolean DEFAULT false,
    fk_type integer NOT NULL
);


ALTER TABLE contacts.data_communications OWNER TO easygp;

--
-- Name: data_communications_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: easygp
--

CREATE SEQUENCE data_communications_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contacts.data_communications_pk_seq OWNER TO easygp;

--
-- Name: data_communications_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: easygp
--

ALTER SEQUENCE data_communications_pk_seq OWNED BY data_communications.pk;


--
-- Name: data_employees_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: easygp
--

CREATE SEQUENCE data_employees_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contacts.data_employees_pk_seq OWNER TO easygp;

--
-- Name: data_employees_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: easygp
--

ALTER SEQUENCE data_employees_pk_seq OWNED BY data_employees.pk;


--
-- Name: data_numbers_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: easygp
--

CREATE SEQUENCE data_numbers_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contacts.data_numbers_pk_seq OWNER TO easygp;

--
-- Name: data_numbers_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: easygp
--

ALTER SEQUENCE data_numbers_pk_seq OWNED BY data_numbers.pk;


--
-- Name: data_organisations_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: easygp
--

CREATE SEQUENCE data_organisations_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contacts.data_organisations_pk_seq OWNER TO easygp;

--
-- Name: data_organisations_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: easygp
--

ALTER SEQUENCE data_organisations_pk_seq OWNED BY data_organisations.pk;


--
-- Name: data_persons_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: easygp
--

CREATE SEQUENCE data_persons_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contacts.data_persons_pk_seq OWNER TO easygp;

--
-- Name: data_persons_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: easygp
--

ALTER SEQUENCE data_persons_pk_seq OWNED BY data_persons.pk;


--
-- Name: images_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: easygp
--

CREATE SEQUENCE images_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contacts.images_pk_seq OWNER TO easygp;

--
-- Name: images_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: easygp
--

ALTER SEQUENCE images_pk_seq OWNED BY images.pk;


--
-- Name: links_branches_comms; Type: TABLE; Schema: contacts; Owner: easygp; Tablespace: 
--

CREATE TABLE links_branches_comms (
    pk integer NOT NULL,
    fk_branch integer,
    fk_comm integer,
    deleted boolean DEFAULT false
);


ALTER TABLE contacts.links_branches_comms OWNER TO easygp;

--
-- Name: links_branches_comms_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: easygp
--

CREATE SEQUENCE links_branches_comms_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contacts.links_branches_comms_pk_seq OWNER TO easygp;

--
-- Name: links_branches_comms_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: easygp
--

ALTER SEQUENCE links_branches_comms_pk_seq OWNED BY links_branches_comms.pk;


--
-- Name: links_employees_comms; Type: TABLE; Schema: contacts; Owner: easygp; Tablespace: 
--

CREATE TABLE links_employees_comms (
    pk integer NOT NULL,
    fk_employee integer,
    fk_comm integer,
    deleted boolean DEFAULT false
);


ALTER TABLE contacts.links_employees_comms OWNER TO easygp;

--
-- Name: links_employees_comms_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: easygp
--

CREATE SEQUENCE links_employees_comms_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contacts.links_employees_comms_pk_seq OWNER TO easygp;

--
-- Name: links_employees_comms_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: easygp
--

ALTER SEQUENCE links_employees_comms_pk_seq OWNED BY links_employees_comms.pk;


--
-- Name: links_persons_addresses_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: easygp
--

CREATE SEQUENCE links_persons_addresses_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contacts.links_persons_addresses_pk_seq OWNER TO easygp;

--
-- Name: links_persons_addresses_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: easygp
--

ALTER SEQUENCE links_persons_addresses_pk_seq OWNED BY links_persons_addresses.pk;


--
-- Name: links_persons_comms; Type: TABLE; Schema: contacts; Owner: easygp; Tablespace: 
--

CREATE TABLE links_persons_comms (
    pk integer NOT NULL,
    fk_person integer,
    fk_comm integer,
    deleted boolean DEFAULT false
);


ALTER TABLE contacts.links_persons_comms OWNER TO easygp;

--
-- Name: links_persons_comms_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: easygp
--

CREATE SEQUENCE links_persons_comms_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contacts.links_persons_comms_pk_seq OWNER TO easygp;

--
-- Name: links_persons_comms_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: easygp
--

ALTER SEQUENCE links_persons_comms_pk_seq OWNED BY links_persons_comms.pk;


--
-- Name: lu_address_types_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: easygp
--

CREATE SEQUENCE lu_address_types_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contacts.lu_address_types_pk_seq OWNER TO easygp;

--
-- Name: lu_address_types_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: easygp
--

ALTER SEQUENCE lu_address_types_pk_seq OWNED BY lu_address_types.pk;


--
-- Name: lu_categories_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: easygp
--

CREATE SEQUENCE lu_categories_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contacts.lu_categories_pk_seq OWNER TO easygp;

--
-- Name: lu_categories_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: easygp
--

ALTER SEQUENCE lu_categories_pk_seq OWNED BY lu_categories.pk;


--
-- Name: lu_contact_type_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: easygp
--

CREATE SEQUENCE lu_contact_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contacts.lu_contact_type_pk_seq OWNER TO easygp;

--
-- Name: lu_contact_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: easygp
--

ALTER SEQUENCE lu_contact_type_pk_seq OWNED BY lu_contact_type.pk;


--
-- Name: lu_employee_status_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: easygp
--

CREATE SEQUENCE lu_employee_status_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contacts.lu_employee_status_pk_seq OWNER TO easygp;

--
-- Name: lu_employee_status_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: easygp
--

ALTER SEQUENCE lu_employee_status_pk_seq OWNED BY lu_employee_status.pk;


--
-- Name: lu_firstnames; Type: TABLE; Schema: contacts; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_firstnames (
    pk integer NOT NULL,
    firstname text,
    ord integer,
    sex character(1)
);


ALTER TABLE contacts.lu_firstnames OWNER TO easygp;

--
-- Name: lu_firstnames_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: easygp
--

CREATE SEQUENCE lu_firstnames_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contacts.lu_firstnames_pk_seq OWNER TO easygp;

--
-- Name: lu_firstnames_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: easygp
--

ALTER SEQUENCE lu_firstnames_pk_seq OWNED BY lu_firstnames.pk;


--
-- Name: lu_marital_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: easygp
--

CREATE SEQUENCE lu_marital_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contacts.lu_marital_pk_seq OWNER TO easygp;

--
-- Name: lu_marital_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: easygp
--

ALTER SEQUENCE lu_marital_pk_seq OWNED BY lu_marital.pk;


--
-- Name: lu_misspelt_towns; Type: TABLE; Schema: contacts; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_misspelt_towns (
    pk integer NOT NULL,
    fk_town integer NOT NULL,
    town text NOT NULL,
    town_misspelt text NOT NULL
);


ALTER TABLE contacts.lu_misspelt_towns OWNER TO easygp;

--
-- Name: TABLE lu_misspelt_towns; Type: COMMENT; Schema: contacts; Owner: easygp
--

COMMENT ON TABLE lu_misspelt_towns IS 'When patient demographics is imported, the quality is usually appalling
 this table keeps matches to real towns/suburbs from the AU postcode database';


--
-- Name: lu_mismatched_towns_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: easygp
--

CREATE SEQUENCE lu_mismatched_towns_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contacts.lu_mismatched_towns_pk_seq OWNER TO easygp;

--
-- Name: lu_mismatched_towns_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: easygp
--

ALTER SEQUENCE lu_mismatched_towns_pk_seq OWNED BY lu_misspelt_towns.pk;


--
-- Name: lu_sex_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: easygp
--

CREATE SEQUENCE lu_sex_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contacts.lu_sex_pk_seq OWNER TO easygp;

--
-- Name: lu_sex_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: easygp
--

ALTER SEQUENCE lu_sex_pk_seq OWNED BY lu_sex.pk;


--
-- Name: lu_surnames; Type: TABLE; Schema: contacts; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_surnames (
    pk integer NOT NULL,
    surname text
);


ALTER TABLE contacts.lu_surnames OWNER TO easygp;

--
-- Name: lu_surnames_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: easygp
--

CREATE SEQUENCE lu_surnames_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contacts.lu_surnames_pk_seq OWNER TO easygp;

--
-- Name: lu_surnames_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: easygp
--

ALTER SEQUENCE lu_surnames_pk_seq OWNED BY lu_surnames.pk;


--
-- Name: lu_title_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: easygp
--

CREATE SEQUENCE lu_title_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contacts.lu_title_pk_seq OWNER TO easygp;

--
-- Name: lu_title_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: easygp
--

ALTER SEQUENCE lu_title_pk_seq OWNED BY lu_title.pk;


--
-- Name: lu_towns_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: easygp
--

CREATE SEQUENCE lu_towns_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contacts.lu_towns_pk_seq OWNER TO easygp;

--
-- Name: lu_towns_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: easygp
--

ALTER SEQUENCE lu_towns_pk_seq OWNED BY lu_towns.pk;


--
-- Name: todo; Type: TABLE; Schema: contacts; Owner: easygp; Tablespace: 
--

CREATE TABLE todo (
    text text
);


ALTER TABLE contacts.todo OWNER TO easygp;

--
-- Name: vwbranchescomms; Type: VIEW; Schema: contacts; Owner: easygp
--

CREATE VIEW vwbranchescomms AS
    SELECT comms.pk, comms.value, comms.note, comms.preferred_method, comms.confidential, comms.deleted, comms.fk_type, type.type, branches.pk AS fk_branch, links.deleted AS comm_link_deleted FROM (((data_branches branches JOIN links_branches_comms links ON ((branches.pk = links.fk_branch))) JOIN data_communications comms ON ((links.fk_comm = comms.pk))) JOIN lu_contact_type type ON ((comms.fk_type = type.pk))) WHERE (links.deleted = false) ORDER BY branches.pk;


ALTER TABLE contacts.vwbranchescomms OWNER TO easygp;

--
-- Name: vwemployees; Type: VIEW; Schema: contacts; Owner: easygp
--

CREATE VIEW vwemployees AS
    SELECT data_employees.pk AS fk_employee, data_employees.fk_person, lu_title.title, data_persons.firstname, data_persons.surname, data_persons.birthdate, data_employees.fk_occupation, lu_occupations.occupation, data_employees.memo AS employee_memo, data_employees.deleted AS employee_deleted, data_employees.fk_status, data_employees.fk_branch, data_branches.branch, data_organisations.organisation, data_branches.fk_organisation, data_branches.fk_address, data_branches.memo AS fk_address_organisation, data_branches.fk_category AS fk_category_organisation, lu_categories.category AS category_organisation, data_persons.salutation, data_persons.fk_ethnicity, data_persons.fk_language, data_persons.memo, data_persons.fk_marital, data_persons.fk_title, data_persons.fk_sex, data_persons.country_code, data_persons.fk_image, data_persons.retired, data_persons.deleted AS person_deleted, data_persons.deceased, data_persons.date_deceased, lu_sex.sex, data_addresses.street1, data_addresses.street2, data_addresses.fk_town, data_addresses.preferred_address, data_addresses.postal_address, data_addresses.head_office, lu_towns.postcode, lu_towns.town, lu_towns.state, data_addresses.deleted AS organisation_address_deleted, data_persons.surname_normalised, data_numbers.provider_number, data_numbers.prescriber_number FROM ((((((((((data_employees JOIN data_branches ON ((data_employees.fk_branch = data_branches.pk))) JOIN data_organisations ON ((data_branches.fk_organisation = data_organisations.pk))) JOIN lu_categories ON ((data_branches.fk_category = lu_categories.pk))) JOIN data_persons ON ((data_employees.fk_person = data_persons.pk))) LEFT JOIN lu_sex ON ((data_persons.fk_sex = lu_sex.pk))) LEFT JOIN common.lu_occupations ON ((data_employees.fk_occupation = lu_occupations.pk))) LEFT JOIN lu_title ON ((data_persons.fk_title = lu_title.pk))) LEFT JOIN data_addresses ON ((data_branches.fk_address = data_addresses.pk))) LEFT JOIN lu_towns ON ((data_addresses.fk_town = lu_towns.pk))) LEFT JOIN data_numbers ON (((data_numbers.fk_person = data_employees.fk_person) AND (data_numbers.fk_branch = data_employees.fk_branch)))) WHERE (NOT data_employees.deleted);


ALTER TABLE contacts.vwemployees OWNER TO easygp;

--
-- Name: vworganisationsbycategory; Type: VIEW; Schema: contacts; Owner: easygp
--

CREATE VIEW vworganisationsbycategory AS
    SELECT DISTINCT data_organisations.organisation, data_branches.branch, data_branches.pk AS pk_branch, lu_categories.category, data_branches.fk_organisation FROM ((data_branches JOIN data_organisations ON ((data_branches.fk_organisation = data_organisations.pk))) JOIN lu_categories ON ((data_branches.fk_category = lu_categories.pk))) WHERE ((data_organisations.deleted = false) AND (data_branches.deleted = false)) ORDER BY lu_categories.category, data_organisations.organisation, data_branches.branch;


ALTER TABLE contacts.vworganisationsbycategory OWNER TO easygp;

--
-- Name: vwpatients_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: easygp
--

CREATE SEQUENCE vwpatients_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contacts.vwpatients_pk_seq OWNER TO easygp;

--
-- Name: vwpersonsaddresses; Type: VIEW; Schema: contacts; Owner: easygp
--

CREATE VIEW vwpersonsaddresses AS
    SELECT links_persons_addresses.fk_address AS pk_view, links_persons_addresses.fk_person, links_persons_addresses.fk_address, data_addresses.street1, data_addresses.street2, data_addresses.fk_town, lu_address_types.type AS address_type, data_addresses.preferred_address, data_addresses.postal_address, data_addresses.head_office, data_addresses.geolocation, data_addresses.country_code, data_addresses.fk_lu_address_type, data_addresses.deleted, lu_towns.postcode, lu_towns.town, lu_towns.state FROM (((links_persons_addresses JOIN data_addresses ON ((links_persons_addresses.fk_address = data_addresses.pk))) JOIN lu_towns ON ((data_addresses.fk_town = lu_towns.pk))) LEFT JOIN lu_address_types ON ((data_addresses.fk_lu_address_type = lu_address_types.pk))) WHERE ((data_addresses.head_office = false) AND (data_addresses.deleted = false)) ORDER BY links_persons_addresses.fk_person;


ALTER TABLE contacts.vwpersonsaddresses OWNER TO easygp;

--
-- Name: vwpersonsexcludingpatients; Type: VIEW; Schema: contacts; Owner: easygp
--

CREATE VIEW vwpersonsexcludingpatients AS
    SELECT vwpersons.fk_person, vwpersons.pk_view, vwpersons.wholename, vwpersons.firstname, vwpersons.surname, vwpersons.salutation, vwpersons.birthdate, vwpersons.fk_ethnicity, vwpersons.fk_language, vwpersons.language_problems, vwpersons.memo, vwpersons.fk_marital, vwpersons.fk_title, vwpersons.fk_sex, vwpersons.fk_image, vwpersons.fk_occupation, vwpersons.retired, vwpersons.deceased, vwpersons.date_deceased, vwpersons.sex, vwpersons.sex_text, vwpersons.title, vwpersons.marital, vwpersons.occupation, vwpersons.language, vwpersons.country, vwpersons.fk_link_address, vwpersons.fk_address, vwpersons.postcode, vwpersons.town, vwpersons.state, vwpersons.country_code, vwpersons.street1, vwpersons.street2, vwpersons.fk_town, vwpersons.fk_lu_address_type, vwpersons.address_type, vwpersons.preferred_address, vwpersons.postal_address, vwpersons.head_office, vwpersons.address_deleted, vwpersons.image, vwpersons.deleted, vwpersons.surname_normalised FROM ((vwpersons LEFT JOIN clerical.data_patients ON ((vwpersons.fk_person = data_patients.fk_person))) LEFT JOIN blobs.images ON ((vwpersons.fk_image = images.pk))) WHERE (data_patients.pk IS NULL) ORDER BY vwpersons.fk_person, vwpersons.fk_address;


ALTER TABLE contacts.vwpersonsexcludingpatients OWNER TO easygp;

--
-- Name: vwpersonsandemployeesaddresses; Type: VIEW; Schema: contacts; Owner: easygp
--

CREATE VIEW vwpersonsandemployeesaddresses AS
    SELECT vworganisationsemployees.fk_address, CASE WHEN (vworganisationsemployees.fk_address IS NULL) THEN (vworganisationsemployees.fk_person || '-0'::text) ELSE ((vworganisationsemployees.fk_person || '-'::text) || (vworganisationsemployees.fk_address)::text) END AS pk_view, vworganisationsemployees.fk_branch, vworganisationsemployees.branch, vworganisationsemployees.organisation, vworganisationsemployees.fk_organisation, vworganisationsemployees.fk_person, vworganisationsemployees.firstname, vworganisationsemployees.surname, vworganisationsemployees.title, vworganisationsemployees.occupation, vworganisationsemployees.street1, vworganisationsemployees.street2, vworganisationsemployees.town, vworganisationsemployees.state, vworganisationsemployees.postcode FROM vworganisationsemployees WHERE (vworganisationsemployees.fk_person <> 0) UNION SELECT vwpersonsexcludingpatients.fk_address, CASE WHEN (vwpersonsexcludingpatients.fk_address IS NULL) THEN (vwpersonsexcludingpatients.fk_person || '-0'::text) ELSE ((vwpersonsexcludingpatients.fk_person || '-'::text) || (vwpersonsexcludingpatients.fk_address)::text) END AS pk_view, NULL::integer AS fk_branch, NULL::text AS branch, NULL::text AS organisation, NULL::integer AS fk_organisation, vwpersonsexcludingpatients.fk_person, vwpersonsexcludingpatients.firstname, vwpersonsexcludingpatients.surname, vwpersonsexcludingpatients.title, vwpersonsexcludingpatients.occupation, vwpersonsexcludingpatients.street1, vwpersonsexcludingpatients.street2, vwpersonsexcludingpatients.town, vwpersonsexcludingpatients.state, vwpersonsexcludingpatients.postcode FROM vwpersonsexcludingpatients WHERE ((vwpersonsexcludingpatients.fk_person <> 0) AND (vwpersonsexcludingpatients.fk_address IS NOT NULL));


ALTER TABLE contacts.vwpersonsandemployeesaddresses OWNER TO easygp;

--
-- Name: vwpersonscomms; Type: VIEW; Schema: contacts; Owner: easygp
--

CREATE VIEW vwpersonscomms AS
    SELECT links_person_comms.fk_person, comms.pk, comms.value, comms.note, comms.preferred_method, comms.confidential, comms.deleted, comms.fk_type, comm_types.type FROM ((data_communications comms JOIN lu_contact_type comm_types ON ((comms.fk_type = comm_types.pk))) JOIN links_persons_comms links_person_comms ON ((comms.pk = links_person_comms.fk_comm))) ORDER BY links_person_comms.fk_person;


ALTER TABLE contacts.vwpersonscomms OWNER TO easygp;

--
-- Name: vwpersonsemployeesbyoccupation; Type: VIEW; Schema: contacts; Owner: easygp
--

CREATE VIEW vwpersonsemployeesbyoccupation AS
    SELECT DISTINCT ((vwpersonsexcludingpatients.fk_person || '-'::text) || (COALESCE(vwpersonsexcludingpatients.fk_address, 0))::text) AS pk_view, vwpersonsexcludingpatients.fk_person, vwpersonsexcludingpatients.title, vwpersonsexcludingpatients.surname, vwpersonsexcludingpatients.firstname, vwpersonsexcludingpatients.occupation, vwpersonsexcludingpatients.sex, vwpersonsexcludingpatients.salutation, NULL::text AS organisation, NULL::text AS branch, 0 AS fk_organisation, 0 AS fk_branch, vwpersonsexcludingpatients.fk_address, 0 AS fk_employee, vwpersonsexcludingpatients.street1, vwpersonsexcludingpatients.street2, vwpersonsexcludingpatients.town, vwpersonsexcludingpatients.state, vwpersonsexcludingpatients.postcode, vwpersonsexcludingpatients.wholename, vwpersonsexcludingpatients.surname_normalised, data_numbers.provider_number, data_numbers.prescriber_number, vwpersonscomms.value AS fax FROM ((vwpersonsexcludingpatients LEFT JOIN data_numbers ON (((data_numbers.fk_person = vwpersonsexcludingpatients.fk_person) AND (data_numbers.fk_branch IS NULL)))) LEFT JOIN vwpersonscomms ON (((vwpersonscomms.fk_person = vwpersonsexcludingpatients.fk_person) AND (vwpersonscomms.fk_type = 2)))) WHERE (((((vwpersonsexcludingpatients.retired IS FALSE) AND (vwpersonsexcludingpatients.deceased IS FALSE)) AND (vwpersonsexcludingpatients.fk_address IS NOT NULL)) AND ((vwpersonsexcludingpatients.address_deleted IS FALSE) OR (vwpersonsexcludingpatients.address_deleted IS NULL))) AND (vwpersonsexcludingpatients.deleted = false)) UNION SELECT DISTINCT ((vwemployees.fk_person || '-'::text) || (COALESCE(vwemployees.fk_address, 0))::text) AS pk_view, vwemployees.fk_person, vwemployees.title, vwemployees.surname, vwemployees.firstname, vwemployees.occupation, vwemployees.sex, vwemployees.salutation, vwemployees.organisation, vwemployees.branch, vwemployees.fk_organisation, vwemployees.fk_branch, vwemployees.fk_address, vwemployees.fk_employee, vwemployees.street1, vwemployees.street2, vwemployees.town, vwemployees.state, vwemployees.postcode, ((((vwemployees.title || ' '::text) || vwemployees.firstname) || ' '::text) || vwemployees.surname) AS wholename, vwemployees.surname_normalised, vwemployees.provider_number, vwemployees.prescriber_number, vwbranchescomms.value AS fax FROM (vwemployees LEFT JOIN vwbranchescomms ON (((vwbranchescomms.fk_branch = vwemployees.fk_branch) AND (vwbranchescomms.fk_type = 2)))) WHERE ((((((vwemployees.employee_deleted = false) AND (vwemployees.person_deleted = false)) AND (vwemployees.deceased = false)) AND (vwemployees.retired = false)) AND ((vwemployees.organisation_address_deleted = false) OR (vwemployees.organisation_address_deleted IS NULL))) AND (vwemployees.fk_status <> 2));


ALTER TABLE contacts.vwpersonsemployeesbyoccupation OWNER TO easygp;

--
-- Name: vwtowns; Type: VIEW; Schema: contacts; Owner: easygp
--

CREATE VIEW vwtowns AS
    SELECT lu_towns.pk, lu_towns.postcode, lu_towns.town, lu_towns.state, lu_towns.comment FROM lu_towns ORDER BY lu_towns.town;


ALTER TABLE contacts.vwtowns OWNER TO easygp;

SET search_path = db, pg_catalog;

--
-- Name: lu_version; Type: TABLE; Schema: db; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_version (
    pk integer NOT NULL,
    lu_major integer DEFAULT 0 NOT NULL,
    lu_minor integer DEFAULT 0 NOT NULL
);


ALTER TABLE db.lu_version OWNER TO easygp;

--
-- Name: db_version_pk_seq; Type: SEQUENCE; Schema: db; Owner: easygp
--

CREATE SEQUENCE db_version_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.db_version_pk_seq OWNER TO easygp;

--
-- Name: db_version_pk_seq; Type: SEQUENCE OWNED BY; Schema: db; Owner: easygp
--

ALTER SEQUENCE db_version_pk_seq OWNED BY lu_version.pk;


SET search_path = defaults, pg_catalog;

--
-- Name: hl7_inboxes; Type: TABLE; Schema: defaults; Owner: easygp; Tablespace: 
--

CREATE TABLE hl7_inboxes (
    pk integer NOT NULL,
    destination text
);


ALTER TABLE defaults.hl7_inboxes OWNER TO easygp;

--
-- Name: TABLE hl7_inboxes; Type: COMMENT; Schema: defaults; Owner: easygp
--

COMMENT ON TABLE hl7_inboxes IS 'The destination for the hl7 message';


--
-- Name: COLUMN hl7_inboxes.destination; Type: COMMENT; Schema: defaults; Owner: easygp
--

COMMENT ON COLUMN hl7_inboxes.destination IS 'where the hl7 message is routed to:
	general inbox = doctor specific general inbox eg
		all radiology/pathology/specialist letters
	patient inbox = the inbox in the patients notes
	doctors personal inbox = doctors personal messages
	e.g could by from external entity, or internal staff
	messages e.g reminding him do something';


--
-- Name: hl7_message_destination_pk_seq; Type: SEQUENCE; Schema: defaults; Owner: easygp
--

CREATE SEQUENCE hl7_message_destination_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE defaults.hl7_message_destination_pk_seq OWNER TO easygp;

--
-- Name: hl7_message_destination_pk_seq; Type: SEQUENCE OWNED BY; Schema: defaults; Owner: easygp
--

ALTER SEQUENCE hl7_message_destination_pk_seq OWNED BY hl7_inboxes.pk;


--
-- Name: incoming_message_handling; Type: TABLE; Schema: defaults; Owner: easygp; Tablespace: 
--

CREATE TABLE incoming_message_handling (
    pk integer NOT NULL,
    fk_lu_provider_type integer,
    sending_entity text NOT NULL,
    transmitting_entity text,
    fk_lu_message_display_style integer NOT NULL,
    fk_branch integer,
    fk_employee integer,
    fk_person integer,
    incoming_dir text NOT NULL,
    processed_dir text NOT NULL,
    error_dir text NOT NULL,
    fk_lu_message_standard integer NOT NULL,
    file_sample_filename text NOT NULL,
    exclude_ft_report boolean DEFAULT false,
    exclude_pit boolean DEFAULT false,
    fk_blob integer
);


ALTER TABLE defaults.incoming_message_handling OWNER TO easygp;

--
-- Name: TABLE incoming_message_handling; Type: COMMENT; Schema: defaults; Owner: easygp
--

COMMENT ON TABLE incoming_message_handling IS 'parameters to define how to handle incoming hl7 messages on a per-provider basis.
Note these messages can be in form of various hl7 standards or old style PIT (sequential numbered text lines eg 100, 110 120 etc This table
defines the file type hl7 or pit, who is sending it, where to put it, which segments of the message to exclude when displaying in html';


--
-- Name: COLUMN incoming_message_handling.fk_lu_provider_type; Type: COMMENT; Schema: defaults; Owner: easygp
--

COMMENT ON COLUMN incoming_message_handling.fk_lu_provider_type IS 'The type of provider eg pathology provider, radiology provider';


--
-- Name: COLUMN incoming_message_handling.sending_entity; Type: COMMENT; Schema: defaults; Owner: easygp
--

COMMENT ON COLUMN incoming_message_handling.sending_entity IS 'the entity sending eg Best Radiology';


--
-- Name: COLUMN incoming_message_handling.transmitting_entity; Type: COMMENT; Schema: defaults; Owner: easygp
--

COMMENT ON COLUMN incoming_message_handling.transmitting_entity IS 'could be the sending entity or third party transmitter eg Medical Objects';


--
-- Name: COLUMN incoming_message_handling.fk_lu_message_display_style; Type: COMMENT; Schema: defaults; Owner: easygp
--

COMMENT ON COLUMN incoming_message_handling.fk_lu_message_display_style IS 'display as letter or result style';


--
-- Name: COLUMN incoming_message_handling.fk_lu_message_standard; Type: COMMENT; Schema: defaults; Owner: easygp
--

COMMENT ON COLUMN incoming_message_handling.fk_lu_message_standard IS 'hl7 or pit';


--
-- Name: COLUMN incoming_message_handling.exclude_ft_report; Type: COMMENT; Schema: defaults; Owner: easygp
--

COMMENT ON COLUMN incoming_message_handling.exclude_ft_report IS 'if true then no free text segments will be shown';


--
-- Name: COLUMN incoming_message_handling.exclude_pit; Type: COMMENT; Schema: defaults; Owner: easygp
--

COMMENT ON COLUMN incoming_message_handling.exclude_pit IS 'if contains PIT segments if true these will not be shown (often duplicated the hl7 data itself)';


--
-- Name: COLUMN incoming_message_handling.fk_blob; Type: COMMENT; Schema: defaults; Owner: easygp
--

COMMENT ON COLUMN incoming_message_handling.fk_blob IS 'sample file data';


--
-- Name: incoming_message_handling_pk_seq; Type: SEQUENCE; Schema: defaults; Owner: easygp
--

CREATE SEQUENCE incoming_message_handling_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE defaults.incoming_message_handling_pk_seq OWNER TO easygp;

--
-- Name: incoming_message_handling_pk_seq; Type: SEQUENCE OWNED BY; Schema: defaults; Owner: easygp
--

ALTER SEQUENCE incoming_message_handling_pk_seq OWNED BY incoming_message_handling.pk;


--
-- Name: lu_link_printer_task; Type: TABLE; Schema: defaults; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_link_printer_task (
    pk integer NOT NULL,
    fk_lu_printer_host integer NOT NULL,
    fk_task integer NOT NULL
);


ALTER TABLE defaults.lu_link_printer_task OWNER TO easygp;

--
-- Name: TABLE lu_link_printer_task; Type: COMMENT; Schema: defaults; Owner: easygp
--

COMMENT ON TABLE lu_link_printer_task IS 'Links a printer on a host = linux hostname = a computer to a task';


--
-- Name: lu_link_printer_task_pk_seq; Type: SEQUENCE; Schema: defaults; Owner: easygp
--

CREATE SEQUENCE lu_link_printer_task_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE defaults.lu_link_printer_task_pk_seq OWNER TO easygp;

--
-- Name: lu_link_printer_task_pk_seq; Type: SEQUENCE OWNED BY; Schema: defaults; Owner: easygp
--

ALTER SEQUENCE lu_link_printer_task_pk_seq OWNED BY lu_link_printer_task.pk;


--
-- Name: lu_message_display_style; Type: TABLE; Schema: defaults; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_message_display_style (
    pk integer NOT NULL,
    style text NOT NULL
);


ALTER TABLE defaults.lu_message_display_style OWNER TO easygp;

--
-- Name: lu_message_display_style_pk_seq; Type: SEQUENCE; Schema: defaults; Owner: easygp
--

CREATE SEQUENCE lu_message_display_style_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE defaults.lu_message_display_style_pk_seq OWNER TO easygp;

--
-- Name: lu_message_display_style_pk_seq; Type: SEQUENCE OWNED BY; Schema: defaults; Owner: easygp
--

ALTER SEQUENCE lu_message_display_style_pk_seq OWNED BY lu_message_display_style.pk;


--
-- Name: lu_message_standard; Type: TABLE; Schema: defaults; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_message_standard (
    pk integer NOT NULL,
    type text NOT NULL,
    version text
);


ALTER TABLE defaults.lu_message_standard OWNER TO easygp;

--
-- Name: TABLE lu_message_standard; Type: COMMENT; Schema: defaults; Owner: easygp
--

COMMENT ON TABLE lu_message_standard IS 'hl7 or pit version not yet implemented';


--
-- Name: lu_message_standard_pk_seq; Type: SEQUENCE; Schema: defaults; Owner: easygp
--

CREATE SEQUENCE lu_message_standard_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE defaults.lu_message_standard_pk_seq OWNER TO easygp;

--
-- Name: lu_message_standard_pk_seq; Type: SEQUENCE OWNED BY; Schema: defaults; Owner: easygp
--

ALTER SEQUENCE lu_message_standard_pk_seq OWNED BY lu_message_standard.pk;


--
-- Name: lu_printer_host; Type: TABLE; Schema: defaults; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_printer_host (
    pk integer NOT NULL,
    fk_clinic integer NOT NULL,
    hostname text NOT NULL,
    printer text NOT NULL
);


ALTER TABLE defaults.lu_printer_host OWNER TO easygp;

--
-- Name: TABLE lu_printer_host; Type: COMMENT; Schema: defaults; Owner: easygp
--

COMMENT ON TABLE lu_printer_host IS 'keeps a list of which printers live in which rooms (host=linux hostname)';


--
-- Name: lu_printer_host_pk_seq; Type: SEQUENCE; Schema: defaults; Owner: easygp
--

CREATE SEQUENCE lu_printer_host_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE defaults.lu_printer_host_pk_seq OWNER TO easygp;

--
-- Name: lu_printer_host_pk_seq; Type: SEQUENCE OWNED BY; Schema: defaults; Owner: easygp
--

ALTER SEQUENCE lu_printer_host_pk_seq OWNED BY lu_printer_host.pk;


--
-- Name: lu_printer_task; Type: TABLE; Schema: defaults; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_printer_task (
    pk integer NOT NULL,
    task text NOT NULL
);


ALTER TABLE defaults.lu_printer_task OWNER TO easygp;

--
-- Name: lu_printer_task_pk_seq; Type: SEQUENCE; Schema: defaults; Owner: easygp
--

CREATE SEQUENCE lu_printer_task_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE defaults.lu_printer_task_pk_seq OWNER TO easygp;

--
-- Name: lu_printer_task_pk_seq; Type: SEQUENCE OWNED BY; Schema: defaults; Owner: easygp
--

ALTER SEQUENCE lu_printer_task_pk_seq OWNED BY lu_printer_task.pk;


--
-- Name: script_coordinates; Type: TABLE; Schema: defaults; Owner: easygp; Tablespace: 
--

CREATE TABLE script_coordinates (
    pk integer NOT NULL,
    fk_lu_printer_host integer NOT NULL,
    left_margin integer NOT NULL,
    top_margin integer NOT NULL,
    practice_details_x integer NOT NULL,
    practice_details_y integer NOT NULL,
    prescriber_number_x integer NOT NULL,
    prescriber_number_y integer NOT NULL,
    medicare_number_x integer NOT NULL,
    medicare_number_y integer NOT NULL,
    benefits_number_x integer NOT NULL,
    benefits_number_y integer NOT NULL,
    safety_net_card_holder_x integer NOT NULL,
    safety_net_card_holder_y integer NOT NULL,
    other_concession_card_x integer NOT NULL,
    other_concession_card_y integer NOT NULL,
    patients_details_x integer NOT NULL,
    patients_details_y integer NOT NULL,
    script_date_x integer NOT NULL,
    script_date_y integer NOT NULL,
    no_brand_substitution_x integer NOT NULL,
    no_brand_substitution_y integer NOT NULL,
    script_type_x integer NOT NULL,
    script_type_y integer NOT NULL,
    font text DEFAULT 'Arial,9'::text,
    drugs_x integer,
    drugs_y integer
);


ALTER TABLE defaults.script_coordinates OWNER TO easygp;

--
-- Name: TABLE script_coordinates; Type: COMMENT; Schema: defaults; Owner: easygp
--

COMMENT ON TABLE script_coordinates IS 'keeps the paper positions x-y for printing out
 a prescription for a particular printer in a
 particular clinic on a particular desk';


--
-- Name: script_coordinates_pk_seq; Type: SEQUENCE; Schema: defaults; Owner: easygp
--

CREATE SEQUENCE script_coordinates_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE defaults.script_coordinates_pk_seq OWNER TO easygp;

--
-- Name: script_coordinates_pk_seq; Type: SEQUENCE OWNED BY; Schema: defaults; Owner: easygp
--

ALTER SEQUENCE script_coordinates_pk_seq OWNED BY script_coordinates.pk;


--
-- Name: temp; Type: TABLE; Schema: defaults; Owner: easygp; Tablespace: 
--

CREATE TABLE temp (
    pk integer NOT NULL,
    xy point
);


ALTER TABLE defaults.temp OWNER TO easygp;

--
-- Name: temp_pk_seq; Type: SEQUENCE; Schema: defaults; Owner: easygp
--

CREATE SEQUENCE temp_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE defaults.temp_pk_seq OWNER TO easygp;

--
-- Name: temp_pk_seq; Type: SEQUENCE OWNED BY; Schema: defaults; Owner: easygp
--

ALTER SEQUENCE temp_pk_seq OWNED BY temp.pk;


--
-- Name: vwprinterstasks; Type: VIEW; Schema: defaults; Owner: easygp
--

CREATE VIEW vwprinterstasks AS
    SELECT data_branches.branch, lu_printer_host.hostname, lu_printer_host.printer, lu_printer_task.task, lu_link_printer_task.fk_task, lu_link_printer_task.fk_lu_printer_host, lu_printer_host.fk_clinic, clinics.fk_branch, lu_link_printer_task.pk AS pk_lu_link_printer_task FROM ((((lu_link_printer_task JOIN lu_printer_host ON ((lu_link_printer_task.fk_lu_printer_host = lu_printer_host.pk))) JOIN lu_printer_task ON ((lu_link_printer_task.fk_task = lu_printer_task.pk))) JOIN admin.clinics ON ((lu_printer_host.fk_clinic = clinics.pk))) JOIN contacts.data_branches ON ((clinics.fk_branch = data_branches.pk)));


ALTER TABLE defaults.vwprinterstasks OWNER TO easygp;

SET search_path = documents, pg_catalog;

--
-- Name: documents_pk_seq; Type: SEQUENCE; Schema: documents; Owner: easygp
--

CREATE SEQUENCE documents_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE documents.documents_pk_seq OWNER TO easygp;

--
-- Name: documents_pk_seq; Type: SEQUENCE OWNED BY; Schema: documents; Owner: easygp
--

ALTER SEQUENCE documents_pk_seq OWNED BY documents.pk;


--
-- Name: lu_archive_site; Type: TABLE; Schema: documents; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_archive_site (
    pk integer NOT NULL,
    archive_site text NOT NULL
);


ALTER TABLE documents.lu_archive_site OWNER TO easygp;

--
-- Name: TABLE lu_archive_site; Type: COMMENT; Schema: documents; Owner: easygp
--

COMMENT ON TABLE lu_archive_site IS 'sites documents are archived eg filesystem,  url';


--
-- Name: lu_archive_site_pk_seq; Type: SEQUENCE; Schema: documents; Owner: easygp
--

CREATE SEQUENCE lu_archive_site_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE documents.lu_archive_site_pk_seq OWNER TO easygp;

--
-- Name: lu_archive_site_pk_seq; Type: SEQUENCE OWNED BY; Schema: documents; Owner: easygp
--

ALTER SEQUENCE lu_archive_site_pk_seq OWNED BY lu_archive_site.pk;


--
-- Name: lu_display_as; Type: TABLE; Schema: documents; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_display_as (
    pk integer NOT NULL,
    display_as text NOT NULL
);


ALTER TABLE documents.lu_display_as OWNER TO easygp;

--
-- Name: lu_display_as_pk_seq; Type: SEQUENCE; Schema: documents; Owner: easygp
--

CREATE SEQUENCE lu_display_as_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE documents.lu_display_as_pk_seq OWNER TO easygp;

--
-- Name: lu_display_as_pk_seq; Type: SEQUENCE OWNED BY; Schema: documents; Owner: easygp
--

ALTER SEQUENCE lu_display_as_pk_seq OWNED BY lu_display_as.pk;


--
-- Name: lu_message_display_style_pk_seq; Type: SEQUENCE; Schema: documents; Owner: easygp
--

CREATE SEQUENCE lu_message_display_style_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE documents.lu_message_display_style_pk_seq OWNER TO easygp;

--
-- Name: lu_message_display_style_pk_seq; Type: SEQUENCE OWNED BY; Schema: documents; Owner: easygp
--

ALTER SEQUENCE lu_message_display_style_pk_seq OWNED BY lu_message_display_style.pk;


--
-- Name: lu_message_standard_pk_seq; Type: SEQUENCE; Schema: documents; Owner: easygp
--

CREATE SEQUENCE lu_message_standard_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE documents.lu_message_standard_pk_seq OWNER TO easygp;

--
-- Name: lu_message_standard_pk_seq; Type: SEQUENCE OWNED BY; Schema: documents; Owner: easygp
--

ALTER SEQUENCE lu_message_standard_pk_seq OWNED BY lu_message_standard.pk;


--
-- Name: observations; Type: TABLE; Schema: documents; Owner: easygp; Tablespace: 
--

CREATE TABLE observations (
    pk integer NOT NULL,
    fk_document integer,
    set_id integer,
    value_type text,
    identifier text,
    sub_identifier text,
    value text,
    units text,
    reference_range text,
    abnormal text,
    probability text,
    nature_abnormality text,
    result_status text,
    date_last_normal date,
    user_defined_access_checks text,
    observation_date date,
    value_numeric numeric,
    loinc text,
    pit boolean DEFAULT false,
    value_numeric_qualifier text
);


ALTER TABLE documents.observations OWNER TO easygp;

--
-- Name: TABLE observations; Type: COMMENT; Schema: documents; Owner: easygp
--

COMMENT ON TABLE observations IS 'Essentially this is an OBX segment such as shown below:
OBX|4|NM|2532-0^LDH^LN||269|U/L^U/L|120-250|*|||F|||200811242054
where:set_id     = 1 to n
      value_type = NM
      identifier = LDH (actually observation_identifer = 2532-0^LDH^LN
      value      = 269
      units      = U/L
      range      = 120-250
      abnormal   = * (but can be various other codes)

but we have included a numeric value of the observation value and LOINC code';


--
-- Name: COLUMN observations.pit; Type: COMMENT; Schema: documents; Owner: easygp
--

COMMENT ON COLUMN observations.pit IS 'if true, the FT segment contains PIT lines ie a PIT report';


--
-- Name: COLUMN observations.value_numeric_qualifier; Type: COMMENT; Schema: documents; Owner: easygp
--

COMMENT ON COLUMN observations.value_numeric_qualifier IS 'numerical qualifier eg < or > for example egfr <60)';


--
-- Name: observations_pk_seq; Type: SEQUENCE; Schema: documents; Owner: easygp
--

CREATE SEQUENCE observations_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE documents.observations_pk_seq OWNER TO easygp;

--
-- Name: observations_pk_seq; Type: SEQUENCE OWNED BY; Schema: documents; Owner: easygp
--

ALTER SEQUENCE observations_pk_seq OWNED BY observations.pk;


--
-- Name: vwgraphableobservations; Type: VIEW; Schema: documents; Owner: easygp
--

CREATE VIEW vwgraphableobservations AS
    SELECT observations.pk AS pk_observations, lu_loinc_abbrev.component, observations.loinc, observations.fk_document, observations.identifier, observations.reference_range, observations.units, observations.abnormal, observations.observation_date, observations.value, observations.value_numeric, observations.value_numeric_qualifier, documents.fk_patient FROM coding.lu_loinc_abbrev, observations, documents WHERE ((((observations.loinc = lu_loinc_abbrev.loinc_num) AND (observations.fk_document = documents.pk)) AND (observations.identifier <> ''::text)) AND (observations.loinc <> '15418-7'::text)) ORDER BY observations.pk;


ALTER TABLE documents.vwgraphableobservations OWNER TO easygp;

--
-- Name: patientshba1cover75; Type: VIEW; Schema: documents; Owner: easygp
--

CREATE VIEW patientshba1cover75 AS
    SELECT DISTINCT vwgraphableobservations.fk_patient FROM vwgraphableobservations WHERE ((vwgraphableobservations.loinc = '4548-4'::text) AND (vwgraphableobservations.value_numeric > 7.5));


ALTER TABLE documents.patientshba1cover75 OWNER TO easygp;

--
-- Name: sending_entities_pk_seq; Type: SEQUENCE; Schema: documents; Owner: easygp
--

CREATE SEQUENCE sending_entities_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE documents.sending_entities_pk_seq OWNER TO easygp;

--
-- Name: sending_entities_pk_seq; Type: SEQUENCE OWNED BY; Schema: documents; Owner: easygp
--

ALTER SEQUENCE sending_entities_pk_seq OWNED BY sending_entities.pk;


--
-- Name: signed_off; Type: TABLE; Schema: documents; Owner: easygp; Tablespace: 
--

CREATE TABLE signed_off (
    pk integer NOT NULL,
    fk_document integer NOT NULL,
    fk_staff integer NOT NULL,
    date timestamp without time zone DEFAULT now(),
    comment text
);


ALTER TABLE documents.signed_off OWNER TO easygp;

--
-- Name: signed_off_pk_seq; Type: SEQUENCE; Schema: documents; Owner: easygp
--

CREATE SEQUENCE signed_off_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE documents.signed_off_pk_seq OWNER TO easygp;

--
-- Name: signed_off_pk_seq; Type: SEQUENCE OWNED BY; Schema: documents; Owner: easygp
--

ALTER SEQUENCE signed_off_pk_seq OWNED BY signed_off.pk;


--
-- Name: unmatched_patients_pk_seq; Type: SEQUENCE; Schema: documents; Owner: easygp
--

CREATE SEQUENCE unmatched_patients_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE documents.unmatched_patients_pk_seq OWNER TO easygp;

--
-- Name: unmatched_patients_pk_seq; Type: SEQUENCE OWNED BY; Schema: documents; Owner: easygp
--

ALTER SEQUENCE unmatched_patients_pk_seq OWNED BY unmatched_patients.pk;


--
-- Name: unmatched_staff_pk_seq; Type: SEQUENCE; Schema: documents; Owner: easygp
--

CREATE SEQUENCE unmatched_staff_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE documents.unmatched_staff_pk_seq OWNER TO easygp;

--
-- Name: unmatched_staff_pk_seq; Type: SEQUENCE OWNED BY; Schema: documents; Owner: easygp
--

ALTER SEQUENCE unmatched_staff_pk_seq OWNED BY unmatched_staff.pk;


--
-- Name: vwhba1cover75; Type: VIEW; Schema: documents; Owner: easygp
--

CREATE VIEW vwhba1cover75 AS
    SELECT DISTINCT vwgraphableobservations.fk_patient FROM vwgraphableobservations WHERE ((vwgraphableobservations.loinc = '4548-4'::text) AND (vwgraphableobservations.value_numeric > 7.5));


ALTER TABLE documents.vwhba1cover75 OWNER TO easygp;

--
-- Name: vwhl7filesimported; Type: VIEW; Schema: documents; Owner: easygp
--

CREATE VIEW vwhl7filesimported AS
    SELECT DISTINCT vwdocuments.source_file FROM vwdocuments WHERE (vwdocuments.md5sum IS NULL) ORDER BY vwdocuments.source_file;


ALTER TABLE documents.vwhl7filesimported OWNER TO easygp;

--
-- Name: vwinboxstaff; Type: VIEW; Schema: documents; Owner: easygp
--

CREATE VIEW vwinboxstaff AS
    SELECT vwstaffinclinics.pk_view, vwstaffinclinics.title, vwstaffinclinics.fk_staff, vwstaffinclinics.wholename, vwstaffinclinics.surname, NULL::integer AS fk_unmatched_staff FROM admin.vwstaffinclinics UNION SELECT ((unmatched_staff.pk || '-'::text) || 'unmatched'::text) AS pk_view, unmatched_staff.title, unmatched_staff.fk_real_staff AS fk_staff, ((unmatched_staff.firstname || ' '::text) || (unmatched_staff.surname || ' [Unkown]'::text)) AS wholename, unmatched_staff.surname, unmatched_staff.pk AS fk_unmatched_staff FROM unmatched_staff WHERE (unmatched_staff.fk_real_staff IS NULL) ORDER BY 5;


ALTER TABLE documents.vwinboxstaff OWNER TO easygp;

--
-- Name: VIEW vwinboxstaff; Type: COMMENT; Schema: documents; Owner: easygp
--

COMMENT ON VIEW vwinboxstaff IS 'All staff with an inbox. If the staff member is unknown, they will still
 appear, once matched to a real staff member they are not pulled from
 the unmatched table ie fk_real_staff <> null then';


--
-- Name: vwobservations; Type: VIEW; Schema: documents; Owner: easygp
--

CREATE VIEW vwobservations AS
    SELECT documents.fk_patient, observations.pk, observations.identifier, observations.observation_date, observations.value_numeric, observations.value_numeric_qualifier, observations.units, observations.reference_range, observations.abnormal, observations.loinc FROM observations, documents WHERE (documents.pk = observations.fk_document) ORDER BY documents.fk_patient, observations.observation_date, observations.set_id;


ALTER TABLE documents.vwobservations OWNER TO easygp;

SET search_path = drugs, pg_catalog;

--
-- Name: chapters; Type: TABLE; Schema: drugs; Owner: easygp; Tablespace: 
--

CREATE TABLE chapters (
    chapter character varying(2) NOT NULL,
    chapter_name text
);


ALTER TABLE drugs.chapters OWNER TO easygp;

--
-- Name: clinical_effects; Type: TABLE; Schema: drugs; Owner: easygp; Tablespace: 
--

CREATE TABLE clinical_effects (
    pk integer NOT NULL,
    effect text NOT NULL,
    fk_severity integer NOT NULL
);


ALTER TABLE drugs.clinical_effects OWNER TO easygp;

--
-- Name: TABLE clinical_effects; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON TABLE clinical_effects IS 'A list of side-effects and consequences of interactions.
I appreciate this list will get long, some values may only apply to one or two drugs, but
I think it is important to normalise. The interface may need to use a text box (it will be
too long for a pick list) and confirm with users if they want to create a new entry.';


--
-- Name: clinical_effects_pk_seq; Type: SEQUENCE; Schema: drugs; Owner: easygp
--

CREATE SEQUENCE clinical_effects_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE drugs.clinical_effects_pk_seq OWNER TO easygp;

--
-- Name: clinical_effects_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugs; Owner: easygp
--

ALTER SEQUENCE clinical_effects_pk_seq OWNED BY clinical_effects.pk;


--
-- Name: company; Type: TABLE; Schema: drugs; Owner: easygp; Tablespace: 
--

CREATE TABLE company (
    company text NOT NULL,
    address text,
    telephone text,
    facsimile text,
    code character varying(3) NOT NULL
);


ALTER TABLE drugs.company OWNER TO easygp;

--
-- Name: TABLE company; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON TABLE company IS 'list of pharmaceutical manufacturers/importers';


--
-- Name: COLUMN company.company; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON COLUMN company.company IS 'company name';


--
-- Name: COLUMN company.address; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON COLUMN company.address IS 'complete printable address, lines separated by commas';


--
-- Name: COLUMN company.telephone; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON COLUMN company.telephone IS 'phone number of company';


--
-- Name: COLUMN company.facsimile; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON COLUMN company.facsimile IS 'fax number of company';


--
-- Name: COLUMN company.code; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON COLUMN company.code IS 'Two- or three-letter guaranteed-unique code of company. Two-letter codes come
from the PBS system. Three-letter codes assigned by me for companies that only produce non-PBS drugs';


--
-- Name: evidence_levels; Type: TABLE; Schema: drugs; Owner: easygp; Tablespace: 
--

CREATE TABLE evidence_levels (
    pk integer NOT NULL,
    evidence_level text NOT NULL
);


ALTER TABLE drugs.evidence_levels OWNER TO easygp;

--
-- Name: TABLE evidence_levels; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON TABLE evidence_levels IS 'different levels of evidence for a fact in the database';


--
-- Name: flags; Type: TABLE; Schema: drugs; Owner: easygp; Tablespace: 
--

CREATE TABLE flags (
    pk integer NOT NULL,
    description character varying(100)
);


ALTER TABLE drugs.flags OWNER TO easygp;

--
-- Name: TABLE flags; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON TABLE flags IS 'flags for adjuvants such as ''gluten-free'', ''paediatric formulation'', etc.';


--
-- Name: flags_pk_seq; Type: SEQUENCE; Schema: drugs; Owner: easygp
--

CREATE SEQUENCE flags_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE drugs.flags_pk_seq OWNER TO easygp;

--
-- Name: flags_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugs; Owner: easygp
--

ALTER SEQUENCE flags_pk_seq OWNED BY flags.pk;


--
-- Name: info; Type: TABLE; Schema: drugs; Owner: easygp; Tablespace: 
--

CREATE TABLE info (
    pk integer NOT NULL,
    comment text NOT NULL,
    fk_topic integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    fk_clinical_effect integer,
    fk_pharmacologic_mechanism integer,
    fk_evidence_level integer NOT NULL,
    fk_patient_category integer,
    standard_frequency text,
    paed_dose double precision,
    paed_max double precision,
    fk_severity integer
);


ALTER TABLE drugs.info OWNER TO easygp;

--
-- Name: TABLE info; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON TABLE info IS 'any product information about a specific drug or class in HTML format';


--
-- Name: COLUMN info.comment; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON COLUMN info.comment IS 'the drug product information in HTML format';


--
-- Name: info_pk_seq; Type: SEQUENCE; Schema: drugs; Owner: easygp
--

CREATE SEQUENCE info_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE drugs.info_pk_seq OWNER TO easygp;

--
-- Name: info_pk_seq; Type: SEQUENCE OWNED BY; Schema: drugs; Owner: easygp
--

ALTER SEQUENCE info_pk_seq OWNED BY info.pk;


--
-- Name: link_atc_info; Type: TABLE; Schema: drugs; Owner: easygp; Tablespace: 
--

CREATE TABLE link_atc_info (
    atccode text NOT NULL,
    fk_info integer NOT NULL
);


ALTER TABLE drugs.link_atc_info OWNER TO easygp;

--
-- Name: TABLE link_atc_info; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON TABLE link_atc_info IS 'links one or more ATC codes (i.e. drugs or classes) to a piece of information. Generally one 
link, but for interactions or contraindications there may be more';


--
-- Name: link_category_info; Type: TABLE; Schema: drugs; Owner: easygp; Tablespace: 
--

CREATE TABLE link_category_info (
    fk_category integer,
    fk_info integer
);


ALTER TABLE drugs.link_category_info OWNER TO easygp;

--
-- Name: TABLE link_category_info; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON TABLE link_category_info IS 'links information to a particular category: information only applies to 
this categoery.';


--
-- Name: link_flag_product; Type: TABLE; Schema: drugs; Owner: easygp; Tablespace: 
--

CREATE TABLE link_flag_product (
    fk_product uuid NOT NULL,
    fk_flag integer NOT NULL
);


ALTER TABLE drugs.link_flag_product OWNER TO easygp;

--
-- Name: TABLE link_flag_product; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON TABLE link_flag_product IS 'many-to-many pivot table linking products to flags';


--
-- Name: link_info_source; Type: TABLE; Schema: drugs; Owner: easygp; Tablespace: 
--

CREATE TABLE link_info_source (
    fk_info integer NOT NULL,
    fk_source integer NOT NULL
);


ALTER TABLE drugs.link_info_source OWNER TO easygp;

--
-- Name: patient_categories; Type: TABLE; Schema: drugs; Owner: easygp; Tablespace: 
--

CREATE TABLE patient_categories (
    pk integer NOT NULL,
    category text NOT NULL
);


ALTER TABLE drugs.patient_categories OWNER TO easygp;

--
-- Name: TABLE patient_categories; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON TABLE patient_categories IS 'enumeration of categories of patient populations for targeted drug warnings';


--
-- Name: pbs; Type: TABLE; Schema: drugs; Owner: easygp; Tablespace: 
--

CREATE TABLE pbs (
    fk_product uuid NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    max_rpt integer DEFAULT 0 NOT NULL,
    pbscode character varying(10) NOT NULL,
    chapter character varying(2) NOT NULL,
    restrictionflag character(1) DEFAULT 'U'::bpchar NOT NULL,
    CONSTRAINT pbs_restrictionflag_check CHECK ((restrictionflag = ANY (ARRAY['U'::bpchar, 'R'::bpchar, 'A'::bpchar])))
);


ALTER TABLE drugs.pbs OWNER TO easygp;

--
-- Name: TABLE pbs; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON TABLE pbs IS 'PBS-specific information about subsidy, authority riles, etc. Private-script only drugs wont have a entry in this table.';


--
-- Name: COLUMN pbs.quantity; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON COLUMN pbs.quantity IS 'quantity of packaged units dispensed under subsidy for any one prescription. 
AU: this the maximum quantity in the PBS Yellow Book.';


--
-- Name: COLUMN pbs.max_rpt; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON COLUMN pbs.max_rpt IS 'maximum number of repeat (refill) authorizations allowed on any one subsidised prescription (series)';


--
-- Name: COLUMN pbs.restrictionflag; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON COLUMN pbs.restrictionflag IS 'U=unrestricted, R=restricted, A=authority';


--
-- Name: pbsconvert; Type: TABLE; Schema: drugs; Owner: easygp; Tablespace: 
--

CREATE TABLE pbsconvert (
    fs character varying(200),
    done boolean,
    dose character varying(100),
    packsize integer,
    amount character varying(20),
    id integer,
    comment text,
    form text
);


ALTER TABLE drugs.pbsconvert OWNER TO easygp;

--
-- Name: pharmacologic_mechanisms; Type: TABLE; Schema: drugs; Owner: easygp; Tablespace: 
--

CREATE TABLE pharmacologic_mechanisms (
    pk integer NOT NULL,
    mechanism text NOT NULL
);


ALTER TABLE drugs.pharmacologic_mechanisms OWNER TO easygp;

--
-- Name: product_information_files; Type: TABLE; Schema: drugs; Owner: easygp; Tablespace: 
--

CREATE TABLE product_information_files (
    filename text NOT NULL
);


ALTER TABLE drugs.product_information_files OWNER TO easygp;

--
-- Name: TABLE product_information_files; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON TABLE product_information_files IS 'the filenames of all the guild pdfs as supplied to us under the agreed 
terms and conditions of use';


--
-- Name: product_information_unmatched; Type: TABLE; Schema: drugs; Owner: easygp; Tablespace: 
--

CREATE TABLE product_information_unmatched (
    brand text NOT NULL,
    product_information_filename text NOT NULL
);


ALTER TABLE drugs.product_information_unmatched OWNER TO easygp;

--
-- Name: severity_level; Type: TABLE; Schema: drugs; Owner: easygp; Tablespace: 
--

CREATE TABLE severity_level (
    pk integer NOT NULL,
    severity text NOT NULL
);


ALTER TABLE drugs.severity_level OWNER TO easygp;

--
-- Name: TABLE severity_level; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON TABLE severity_level IS 'different level of severity for warnings. Levels may control client behaviour';


--
-- Name: sources; Type: TABLE; Schema: drugs; Owner: easygp; Tablespace: 
--

CREATE TABLE sources (
    pk integer NOT NULL,
    source_category character(1) NOT NULL,
    source text NOT NULL,
    CONSTRAINT sources_source_category_check CHECK ((source_category = ANY (ARRAY['p'::bpchar, 'a'::bpchar, 'i'::bpchar, 'm'::bpchar, 'o'::bpchar, 's'::bpchar])))
);


ALTER TABLE drugs.sources OWNER TO easygp;

--
-- Name: TABLE sources; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON TABLE sources IS 'Source of any reference information in this database';


--
-- Name: COLUMN sources.source_category; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON COLUMN sources.source_category IS 'p=peer reviewed, a=official authority, i=independent source, m=manufacturer, o=other, s=self defined';


--
-- Name: COLUMN sources.source; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON COLUMN sources.source IS 'URL or address or similar informtion allowing to reproduce the source of information';


--
-- Name: topic; Type: TABLE; Schema: drugs; Owner: easygp; Tablespace: 
--

CREATE TABLE topic (
    pk integer NOT NULL,
    title character varying(60) NOT NULL,
    target character(1) NOT NULL,
    CONSTRAINT topic_target_check CHECK ((target = ANY (ARRAY['h'::bpchar, 'p'::bpchar])))
);


ALTER TABLE drugs.topic OWNER TO easygp;

--
-- Name: TABLE topic; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON TABLE topic IS 'topics for drug information, such as pharmaco-kinetics, indications, etc.';


--
-- Name: COLUMN topic.target; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON COLUMN topic.target IS 'the target of this information: h=health professional, p=patient';


--
-- Name: vwdistinctbrandsforgenericproduct; Type: VIEW; Schema: drugs; Owner: easygp
--

CREATE VIEW vwdistinctbrandsforgenericproduct AS
    SELECT DISTINCT brand.pk AS pk_view, brand.fk_product, product.generic, brand.brand, brand.product_information_filename, brand.pk AS fk_brand FROM (brand JOIN product ON ((product.pk = brand.fk_product)));


ALTER TABLE drugs.vwdistinctbrandsforgenericproduct OWNER TO easygp;

--
-- Name: vwpbs; Type: VIEW; Schema: drugs; Owner: easygp
--

CREATE VIEW vwpbs AS
    SELECT pbs.quantity, pbs.max_rpt, pbs.pbscode, pbs.chapter, pbs.restrictionflag, pbs.fk_product, ((CASE WHEN ((pbs.chapter)::text = 'GE'::text) THEN 'PBS'::text WHEN ((pbs.chapter)::text = 'R1'::text) THEN 'RPBS'::text WHEN ((pbs.chapter)::text = 'OT'::text) THEN 'OPTOMETRIST'::text WHEN ((pbs.chapter)::text = 'PL'::text) THEN 'PBS PALLIATIVE CARE'::text WHEN ((pbs.chapter)::text = 'GH'::text) THEN 'Section 100 (GROWTH HORMONE)'::text WHEN ((pbs.chapter)::text = 'IF'::text) THEN 'Section 100 (IVF/GIFT)'::text WHEN ((pbs.chapter)::text = 'PQ'::text) THEN 'Paraplegic/Quadriplegic'::text WHEN ((pbs.chapter)::text = 'MD'::text) THEN 'Section 100 (Opiate Addiction Treatment)'::text WHEN ((pbs.chapter)::text = 'MF'::text) THEN 'Section 100 (Botulinum Toxin Program)'::text WHEN ((pbs.chapter)::text = 'SY'::text) THEN 'Section 100 (Special Authority Items) - Private Hospitals'::text WHEN ((pbs.chapter)::text = 'SZ'::text) THEN 'Section 100 (Special Authority Items) - Public Hospitals'::text WHEN ((pbs.chapter)::text = 'CS'::text) THEN 'Section100 (chemotherapy special benefits)'::text WHEN ((pbs.chapter)::text = 'DB'::text) THEN 'Doctors Bag'::text WHEN ((pbs.chapter)::text = 'HB'::text) THEN 'Section 100 (highly specialised drugs - public hospital)'::text WHEN ((pbs.chapter)::text = 'HS'::text) THEN 'Section 100 (Highly specialised drugs)'::text WHEN ((pbs.chapter)::text = 'SB'::text) THEN 'SPECIAL BENEFITS'::text WHEN ((pbs.chapter)::text = 'CT'::text) THEN 'CHEMOTHERAPY SPECIAL BENEFITS'::text WHEN ((pbs.chapter)::text = 'DT'::text) THEN 'DENTAL'::text WHEN ((pbs.chapter)::text = 'DS'::text) THEN 'DENTAL SPECIAL BENEFITS'::text ELSE NULL::text END || ' '::text) || CASE WHEN ((pbs.restrictionflag)::text = 'U'::text) THEN 'UNRESTRICTED'::text WHEN ((pbs.restrictionflag)::text = 'R'::text) THEN 'RESTRICTED'::text ELSE CASE WHEN restriction.streamlined THEN 'STREAMLINED'::text ELSE 'AUTHORITY'::text END END) AS pbs_type, restriction.restriction, restriction.restriction_type, restriction.code AS restriction_code, restriction.streamlined FROM (pbs LEFT JOIN restriction ON (((pbs.pbscode)::text = (restriction.pbscode)::text)));


ALTER TABLE drugs.vwpbs OWNER TO easygp;

--
-- Name: VIEW vwpbs; Type: COMMENT; Schema: drugs; Owner: easygp
--

COMMENT ON VIEW vwpbs IS 'THESE ARE THE CHAPTERS:

CS Section 100 (Chemotherapy Special Benefit)
CT Section 100 (Chemotherapy Scheme)
DB Doctors Bag
DS Dental (Special Pharmaceutical Benefits)
DT Dental
GE General
GH Section 100 (Growth hormone)
HB Section 100 (Highly Specialised Drugs) - Public Hospitals
HS Section 100 (Highly specialised drugs)
IF Section 100 (IVF/GIFT Treatment)
MD Section 100 (Opiate Addiction Treatment)
MF Section 100 (Botulinum Toxin Program)
OT Optometrist
PL Palliative care      - seems to have only authority items.
PQ Paraplegic/Quadriplegic
R1 Repatriation
SB Special Pharmaceutical Benefits
SY Section 100 (Special Authority Items) - Private Hospitals
SZ Section 100 (Special Authority Items) - Public Hospitals
';


--
-- Name: vwdrugs; Type: VIEW; Schema: drugs; Owner: easygp
--

CREATE VIEW vwdrugs AS
    SELECT ((brand.pk || (COALESCE(vwpbs.pbscode, ''::character varying))::text) || (COALESCE(vwpbs.restriction_code, ''::character varying))::text) AS pk_view, brand.fk_product, brand.fk_company, brand.brand, brand.pk AS fk_brand, brand.price, brand.from_pbs, product.atccode, product.generic, product.salt, product.fk_form, product.strength, format_strength(product.strength) AS display_strength, format_amount(product.amount, product.amount_unit, product.units_per_pack) AS display_packsize, product.units_per_pack, product.salt_strength, product.free_comment, product.fk_schedule, product.updated_at, product.pack_size, product.amount, product.amount_unit, schedules.schedule, form.form, brand.product_information_filename, brand.product_information_filename_user, COALESCE(vwpbs.quantity, product.pack_size) AS quantity, vwpbs.max_rpt, vwpbs.pbscode, vwpbs.chapter, atc.atcname, company.company, vwpbs.restrictionflag, vwpbs.pbs_type, vwpbs.restriction, vwpbs.restriction_type, vwpbs.restriction_code, vwpbs.streamlined, atc1.atccode AS class_code, atc1.atcname AS class_name FROM (((((((brand brand JOIN product ON ((brand.fk_product = product.pk))) JOIN form ON ((product.fk_form = form.pk))) JOIN atc ON (((product.atccode)::text = atc.atccode))) LEFT JOIN company ON (((company.code)::text = (brand.fk_company)::text))) LEFT JOIN vwpbs ON ((product.pk = vwpbs.fk_product))) LEFT JOIN schedules ON ((schedules.pk = product.fk_schedule))) LEFT JOIN atc atc1 ON (("substring"((product.atccode)::text, 1, 4) = atc1.atccode)));


ALTER TABLE drugs.vwdrugs OWNER TO easygp;

--
-- Name: vwdrugs1; Type: VIEW; Schema: drugs; Owner: easygp
--

CREATE VIEW vwdrugs1 AS
    SELECT ((brand.pk || (COALESCE(vwpbs.pbscode, ''::character varying))::text) || (COALESCE(vwpbs.restriction_code, ''::character varying))::text) AS pk_view, brand.fk_product, brand.fk_company, brand.brand, brand.pk AS fk_brand, brand.price, brand.from_pbs, product.atccode, product.generic, product.salt, product.fk_form, product.strength, product.salt_strength, product.free_comment, product.fk_schedule, product.updated_at, product.pack_size, product.amount, product.amount_unit, form.form, brand.product_information_filename, vwpbs.quantity, vwpbs.max_rpt, vwpbs.pbscode, vwpbs.chapter, atc.atcname, vwpbs.restrictionflag, vwpbs.pbs_type, vwpbs.restriction, vwpbs.restriction_type, vwpbs.restriction_code, vwpbs.streamlined FROM ((((brand brand JOIN product ON ((brand.fk_product = product.pk))) JOIN form ON ((product.fk_form = form.pk))) JOIN atc ON (((product.atccode)::text = atc.atccode))) LEFT JOIN vwpbs ON ((product.pk = vwpbs.fk_product)));


ALTER TABLE drugs.vwdrugs1 OWNER TO easygp;

--
-- Name: vwgeneric; Type: VIEW; Schema: drugs; Owner: easygp
--

CREATE VIEW vwgeneric AS
    SELECT ((product.pk || (COALESCE(vwpbs.pbscode, ''::character varying))::text) || (COALESCE(vwpbs.restriction_code, ''::character varying))::text) AS pk_view, product.pk AS fk_product, NULL::character varying(3) AS fk_company, product.generic AS brand, NULL::uuid AS fk_brand, NULL::money AS price, NULL::boolean AS from_pbs, product.atccode, product.generic, product.salt, product.fk_form, product.strength, product.salt_strength, product.free_comment, product.updated_at, product.pack_size, product.amount, product.amount_unit, form.form, NULL::text AS product_information_filename, vwpbs.quantity, vwpbs.max_rpt, vwpbs.pbscode, vwpbs.chapter, vwpbs.restrictionflag, vwpbs.pbs_type, vwpbs.restriction, vwpbs.restriction_type, vwpbs.restriction_code, vwpbs.streamlined FROM ((product JOIN form ON ((product.fk_form = form.pk))) LEFT JOIN vwpbs ON ((product.pk = vwpbs.fk_product)));


ALTER TABLE drugs.vwgeneric OWNER TO easygp;

SET search_path = import_export, pg_catalog;

--
-- Name: lu_demographics_field_templates; Type: TABLE; Schema: import_export; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_demographics_field_templates (
    pk integer NOT NULL,
    fk_source_program integer NOT NULL,
    version text NOT NULL,
    surname_field_order integer,
    firstname_field_order integer,
    title_field_order integer,
    sex_field_order integer,
    marital_field_order integer,
    salutation_field_order integer,
    medicare_field_order integer,
    birthdate_field_order integer,
    occupation_field_order integer,
    street1_field_order integer,
    street2_field_order integer,
    suburb_field_order integer,
    homephone_field_order integer,
    workphone_field_order integer,
    mobile_field_order integer,
    retired_field_order integer,
    field_names text,
    veterens_field_order integer,
    medicare_card_pos_field_order integer,
    card_concession_number_field_order integer
);


ALTER TABLE import_export.lu_demographics_field_templates OWNER TO easygp;

--
-- Name: TABLE lu_demographics_field_templates; Type: COMMENT; Schema: import_export; Owner: easygp
--

COMMENT ON TABLE lu_demographics_field_templates IS 'demographic details imported from delimited file , this table keeps details of field definitions, sparators etc';


--
-- Name: lu_demographics_field_templates_pk_seq; Type: SEQUENCE; Schema: import_export; Owner: easygp
--

CREATE SEQUENCE lu_demographics_field_templates_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE import_export.lu_demographics_field_templates_pk_seq OWNER TO easygp;

--
-- Name: lu_demographics_field_templates_pk_seq; Type: SEQUENCE OWNED BY; Schema: import_export; Owner: easygp
--

ALTER SEQUENCE lu_demographics_field_templates_pk_seq OWNED BY lu_demographics_field_templates.pk;


--
-- Name: lu_misspelt_user_request_tags; Type: TABLE; Schema: import_export; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_misspelt_user_request_tags (
    pk integer NOT NULL,
    tag text NOT NULL
);


ALTER TABLE import_export.lu_misspelt_user_request_tags OWNER TO easygp;

--
-- Name: lu_misspelt_user_request_tags_pk_seq; Type: SEQUENCE; Schema: import_export; Owner: easygp
--

CREATE SEQUENCE lu_misspelt_user_request_tags_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE import_export.lu_misspelt_user_request_tags_pk_seq OWNER TO easygp;

--
-- Name: lu_misspelt_user_request_tags_pk_seq; Type: SEQUENCE OWNED BY; Schema: import_export; Owner: easygp
--

ALTER SEQUENCE lu_misspelt_user_request_tags_pk_seq OWNED BY lu_misspelt_user_request_tags.pk;


--
-- Name: lu_source_program; Type: TABLE; Schema: import_export; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_source_program (
    pk integer NOT NULL,
    program text NOT NULL
);


ALTER TABLE import_export.lu_source_program OWNER TO easygp;

--
-- Name: TABLE lu_source_program; Type: COMMENT; Schema: import_export; Owner: easygp
--

COMMENT ON TABLE lu_source_program IS 'source program for imported data either clinical or clerical';


--
-- Name: lu_source_program_pk_seq; Type: SEQUENCE; Schema: import_export; Owner: easygp
--

CREATE SEQUENCE lu_source_program_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE import_export.lu_source_program_pk_seq OWNER TO easygp;

--
-- Name: lu_source_program_pk_seq; Type: SEQUENCE OWNED BY; Schema: import_export; Owner: easygp
--

ALTER SEQUENCE lu_source_program_pk_seq OWNED BY lu_source_program.pk;


--
-- Name: vwdemographictemplates; Type: VIEW; Schema: import_export; Owner: easygp
--

CREATE VIEW vwdemographictemplates AS
    SELECT lu_source_program.pk AS pk_source_program, lu_source_program.program, lu_demographics_field_templates.pk AS fk_template, lu_demographics_field_templates.version, lu_demographics_field_templates.surname_field_order, lu_demographics_field_templates.firstname_field_order, lu_demographics_field_templates.title_field_order, lu_demographics_field_templates.sex_field_order, lu_demographics_field_templates.marital_field_order, lu_demographics_field_templates.salutation_field_order, lu_demographics_field_templates.medicare_field_order, lu_demographics_field_templates.medicare_card_pos_field_order, lu_demographics_field_templates.card_concession_number_field_order, lu_demographics_field_templates.veterens_field_order, lu_demographics_field_templates.birthdate_field_order, lu_demographics_field_templates.occupation_field_order, lu_demographics_field_templates.street1_field_order, lu_demographics_field_templates.street2_field_order, lu_demographics_field_templates.suburb_field_order, lu_demographics_field_templates.homephone_field_order, lu_demographics_field_templates.workphone_field_order, lu_demographics_field_templates.mobile_field_order, lu_demographics_field_templates.retired_field_order, lu_demographics_field_templates.field_names, lu_demographics_field_templates.fk_source_program FROM (lu_demographics_field_templates RIGHT JOIN lu_source_program ON ((lu_demographics_field_templates.fk_source_program = lu_source_program.pk))) ORDER BY lu_source_program.program;


ALTER TABLE import_export.vwdemographictemplates OWNER TO easygp;

SET search_path = public, pg_catalog;

--
-- Name: authority_number; Type: SEQUENCE; Schema: public; Owner: easygp
--

CREATE SEQUENCE authority_number
    START WITH 1
    INCREMENT BY 11
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authority_number OWNER TO easygp;

--
-- Name: dailymed; Type: TABLE; Schema: public; Owner: easygp; Tablespace: 
--

CREATE TABLE dailymed (
    genericname text,
    brandname text,
    dailymed uuid
);


ALTER TABLE public.dailymed OWNER TO easygp;

--
-- Name: forms1; Type: TABLE; Schema: public; Owner: easygp; Tablespace: 
--

CREATE TABLE forms1 (
    form text
);


ALTER TABLE public.forms1 OWNER TO easygp;

--
-- Name: inventory_items_lent; Type: TABLE; Schema: public; Owner: easygp; Tablespace: 
--

CREATE TABLE inventory_items_lent (
    pk integer NOT NULL,
    fk_inventory_item integer NOT NULL,
    fk_patient integer NOT NULL,
    fk_clinic integer NOT NULL,
    fk_staff integer NOT NULL,
    date_lent timestamp without time zone NOT NULL,
    date_due timestamp without time zone NOT NULL,
    comment text
);


ALTER TABLE public.inventory_items_lent OWNER TO easygp;

--
-- Name: inventory_items_lent_pk_seq; Type: SEQUENCE; Schema: public; Owner: easygp
--

CREATE SEQUENCE inventory_items_lent_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inventory_items_lent_pk_seq OWNER TO easygp;

--
-- Name: inventory_items_lent_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: easygp
--

ALTER SEQUENCE inventory_items_lent_pk_seq OWNED BY inventory_items_lent.pk;


--
-- Name: lu_modes; Type: TABLE; Schema: public; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_modes (
    mode character(1),
    description text
);


ALTER TABLE public.lu_modes OWNER TO easygp;

--
-- Name: pbsconvert_id_seq; Type: SEQUENCE; Schema: public; Owner: easygp
--

CREATE SEQUENCE pbsconvert_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pbsconvert_id_seq OWNER TO easygp;

--
-- Name: rawpbs; Type: TABLE; Schema: public; Owner: easygp; Tablespace: 
--

CREATE TABLE rawpbs (
    drugtypecode character(2),
    atccode character varying(7),
    atctype character(1),
    atcprintopt character(1),
    pbscode character(5),
    restrictionflag character(1),
    cautionflag character(1),
    noteflag character(1),
    maxquantity integer,
    numrepeats integer,
    manufacturercode character(2),
    packsize integer,
    markupcode character(1),
    dispensefee character(2),
    danger character(2),
    brandpricepremium money,
    thergrouppremium money,
    cwprice money,
    cwdprice money,
    thergroupprice money,
    thergroupdprice money,
    manufactprice money,
    manufactdprice money,
    maxvalsafetynet money,
    bioequivalence character(1),
    brandname text,
    genericname text,
    formandstrength text
);


ALTER TABLE public.rawpbs OWNER TO easygp;

--
-- Name: script_number; Type: SEQUENCE; Schema: public; Owner: easygp
--

CREATE SEQUENCE script_number
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.script_number OWNER TO easygp;

--
-- Name: web_pk_seq; Type: SEQUENCE; Schema: public; Owner: easygp
--

CREATE SEQUENCE web_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.web_pk_seq OWNER TO easygp;

--
-- Name: web; Type: TABLE; Schema: public; Owner: easygp; Tablespace: 
--

CREATE TABLE web (
    pk integer DEFAULT nextval('web_pk_seq'::regclass),
    tga_code character varying(10),
    genericname text,
    form text,
    brandname text,
    strength text,
    amount double precision,
    amount_unit character varying(10),
    packsize text,
    poison character varying(4),
    rawname text,
    mnfr character varying(3),
    updated_at timestamp without time zone DEFAULT now(),
    updated_by character varying(20),
    mode character(1),
    atc character varying(8),
    comment text,
    created_at timestamp without time zone DEFAULT now(),
    hex text
);


ALTER TABLE public.web OWNER TO easygp;

SET search_path = research, pg_catalog;

--
-- Name: diabetes_patients_latest_hba1c; Type: VIEW; Schema: research; Owner: easygp
--

CREATE VIEW diabetes_patients_latest_hba1c AS
    SELECT DISTINCT vwobservations.fk_patient, vwpatients.wholename, vwpatients.surname, vwpatients.firstname, vwpatients.birthdate, vwpatients.age_numeric, (SELECT vwobservations.observation_date FROM documents.vwobservations WHERE ((vwobservations.fk_patient = vwpatients.fk_patient) AND (vwobservations.loinc = '4548-4'::text)) ORDER BY vwobservations.observation_date DESC LIMIT 1) AS observation_date, (SELECT vwobservations.value_numeric FROM documents.vwobservations WHERE ((vwobservations.fk_patient = vwpatients.fk_patient) AND (vwobservations.loinc = '4548-4'::text)) ORDER BY vwobservations.observation_date DESC LIMIT 1) AS hba1c FROM contacts.vwpatients, documents.vwobservations WHERE ((vwobservations.fk_patient = vwpatients.fk_patient) AND (vwobservations.loinc = '4548-4'::text)) ORDER BY (SELECT vwobservations.value_numeric FROM documents.vwobservations WHERE ((vwobservations.fk_patient = vwpatients.fk_patient) AND (vwobservations.loinc = '4548-4'::text)) ORDER BY vwobservations.observation_date DESC LIMIT 1);


ALTER TABLE research.diabetes_patients_latest_hba1c OWNER TO easygp;

--
-- Name: diabetes_patients_with_hba1c; Type: VIEW; Schema: research; Owner: easygp
--

CREATE VIEW diabetes_patients_with_hba1c AS
    SELECT DISTINCT vwgraphableobservations.observation_date, vwgraphableobservations.loinc, vwgraphableobservations.value_numeric, vwpatients.firstname, vwpatients.wholename, vwpatients.age_display, vwpatients.sex, vwpatients.title, vwpatients.street1, vwpatients.street2, vwpatients.town, vwpatients.state, vwpatients.occupation, vwpatients.postcode, vwpatients.surname, vwpatients.birthdate, vwpatients.age_numeric, vwpatients.marital FROM contacts.vwpatients, documents.vwgraphableobservations WHERE ((vwgraphableobservations.fk_patient = vwpatients.fk_patient) AND (vwgraphableobservations.loinc = '4548-4'::text));


ALTER TABLE research.diabetes_patients_with_hba1c OWNER TO easygp;

--
-- Name: patientsnameshba1cover75; Type: VIEW; Schema: research; Owner: easygp
--

CREATE VIEW patientsnameshba1cover75 AS
    SELECT DISTINCT vwpatients.wholename, vwpatients.age_display, vwpatients.sex FROM contacts.vwpatients, documents.patientshba1cover75 WHERE (patientshba1cover75.fk_patient = vwpatients.fk_patient);


ALTER TABLE research.patientsnameshba1cover75 OWNER TO easygp;

--
-- Name: vwdiabetes_patients_with_hba1c; Type: VIEW; Schema: research; Owner: easygp
--

CREATE VIEW vwdiabetes_patients_with_hba1c AS
    SELECT DISTINCT vwgraphableobservations.pk_observations, vwgraphableobservations.observation_date, vwgraphableobservations.loinc, vwgraphableobservations.value_numeric, vwpatients.fk_patient, vwpatients.firstname, vwpatients.surname, vwpatients.wholename, vwpatients.age_display, vwpatients.sex, vwpatients.title, vwpatients.occupation, vwpatients.fk_image, vwpatients.birthdate, vwpatients.age_numeric, vwpatients.marital, vwpatients.fk_person, vwpatients.deceased, vwpatients.active_status, vwpatients.street1, vwpatients.street2, vwpatients.town, vwpatients.state, vwpatients.postcode FROM contacts.vwpatients, documents.vwgraphableobservations WHERE ((vwgraphableobservations.fk_patient = vwpatients.fk_patient) AND (vwgraphableobservations.loinc = '4548-4'::text));


ALTER TABLE research.vwdiabetes_patients_with_hba1c OWNER TO easygp;

--
-- Name: VIEW vwdiabetes_patients_with_hba1c; Type: COMMENT; Schema: research; Owner: easygp
--

COMMENT ON VIEW vwdiabetes_patients_with_hba1c IS 'all patients and all their hba1''s, including deceased and those left the practice
 this view could also contain patients who are not diabetic if someone has done
 their hab1c without good cause or logic - mind you there is a push to make
 hba1c a diagnostic tool heaven forbid
 The GUI layer must use  chronic_disease_management.diabetes_hba1c_not_diabetic
 to filter these non-diabetics out of stats - or at least that is how I''ve done it';


--
-- Name: vwdiabetics_with_ldlcholesterol; Type: VIEW; Schema: research; Owner: easygp
--

CREATE VIEW vwdiabetics_with_ldlcholesterol AS
    SELECT vwdiabetes_patients_with_hba1c.fk_patient AS pk_view, vwgraphableobservations.loinc, vwgraphableobservations.value_numeric, vwgraphableobservations.value_numeric_qualifier, vwdiabetes_patients_with_hba1c.fk_patient, vwdiabetes_patients_with_hba1c.deceased, vwdiabetes_patients_with_hba1c.active_status, vwgraphableobservations.identifier, vwgraphableobservations.observation_date, vwgraphableobservations.reference_range, vwgraphableobservations.abnormal FROM vwdiabetes_patients_with_hba1c, documents.vwgraphableobservations WHERE ((vwdiabetes_patients_with_hba1c.fk_patient = vwgraphableobservations.fk_patient) AND (vwgraphableobservations.loinc = '22748-8'::text));


ALTER TABLE research.vwdiabetics_with_ldlcholesterol OWNER TO easygp;

--
-- Name: VIEW vwdiabetics_with_ldlcholesterol; Type: COMMENT; Schema: research; Owner: easygp
--

COMMENT ON VIEW vwdiabetics_with_ldlcholesterol IS 'a view of all diabetes and their LDL Cholesterol Levels
 note as the fk_patient of the diabetes view is linked to the fk_patient of the observations view
 there is always a 1-1 relationship between these views
 this view could also contain patients who are not diabetic if someone has done
 their hab1c without good cause or logic 
 The GUI layer must use  chronic_disease_management.diabetes_hba1c_not_diabetic
 to filter these non-diabetics out of stats - or at least that is how I''ve done it';


--
-- Name: vwmicroalbuminuria; Type: VIEW; Schema: research; Owner: easygp
--

CREATE VIEW vwmicroalbuminuria AS
    ((SELECT vwobservations.fk_patient, vwobservations.pk AS pk_observation, vwobservations.identifier, vwobservations.observation_date, vwobservations.value_numeric, vwobservations.value_numeric_qualifier, vwobservations.units, vwobservations.reference_range, vwobservations.abnormal, vwobservations.loinc FROM documents.vwobservations WHERE ((vwobservations.loinc = '14959-1'::text) AND (vwobservations.value_numeric IS NOT NULL)) UNION SELECT vwobservations.fk_patient, vwobservations.pk AS pk_observation, vwobservations.identifier, vwobservations.observation_date, vwobservations.value_numeric, vwobservations.value_numeric_qualifier, vwobservations.units, vwobservations.reference_range, vwobservations.abnormal, vwobservations.loinc FROM documents.vwobservations WHERE ((vwobservations.loinc = '2890-2'::text) AND (vwobservations.value_numeric IS NOT NULL))) UNION SELECT vwobservations.fk_patient, vwobservations.pk AS pk_observation, vwobservations.identifier, vwobservations.observation_date, vwobservations.value_numeric, vwobservations.value_numeric_qualifier, vwobservations.units, vwobservations.reference_range, vwobservations.abnormal, vwobservations.loinc FROM documents.vwobservations WHERE ((vwobservations.loinc = '14957-5'::text) AND (vwobservations.value_numeric IS NOT NULL))) UNION SELECT vwobservations.fk_patient, vwobservations.pk AS pk_observation, vwobservations.identifier, vwobservations.observation_date, vwobservations.value_numeric, vwobservations.value_numeric_qualifier, vwobservations.units, vwobservations.reference_range, vwobservations.abnormal, vwobservations.loinc FROM documents.vwobservations WHERE ((vwobservations.loinc = '14956-7'::text) AND (vwobservations.value_numeric IS NOT NULL)) ORDER BY 1, 4;


ALTER TABLE research.vwmicroalbuminuria OWNER TO easygp;

--
-- Name: VIEW vwmicroalbuminuria; Type: COMMENT; Schema: research; Owner: easygp
--

COMMENT ON VIEW vwmicroalbuminuria IS 'a view containing all microalbumins for all patients';


--
-- Name: vwdiabetics_with_microalbumins; Type: VIEW; Schema: research; Owner: easygp
--

CREATE VIEW vwdiabetics_with_microalbumins AS
    SELECT vwmicroalbuminuria.identifier, vwmicroalbuminuria.observation_date, vwmicroalbuminuria.value_numeric, vwmicroalbuminuria.value_numeric_qualifier, vwmicroalbuminuria.units, vwmicroalbuminuria.reference_range, vwmicroalbuminuria.abnormal, vwmicroalbuminuria.loinc, vwdiabetes_patients_with_hba1c.fk_patient, vwdiabetes_patients_with_hba1c.fk_patient AS pk_view, vwdiabetes_patients_with_hba1c.deceased, vwdiabetes_patients_with_hba1c.active_status FROM vwmicroalbuminuria, vwdiabetes_patients_with_hba1c WHERE (vwmicroalbuminuria.fk_patient = vwdiabetes_patients_with_hba1c.fk_patient) ORDER BY vwdiabetes_patients_with_hba1c.fk_patient, vwmicroalbuminuria.observation_date;


ALTER TABLE research.vwdiabetics_with_microalbumins OWNER TO easygp;

--
-- Name: VIEW vwdiabetics_with_microalbumins; Type: COMMENT; Schema: research; Owner: easygp
--

COMMENT ON VIEW vwdiabetics_with_microalbumins IS 'A view of all patient''s with hab1c''s who also have had some sort of microalbumnin test (4 different LOINC''s
 Note the pk_view does not have to be unique we only pull out a single record for each patient when used (our collections must have unique keys)';


--
-- Name: vwdiabeticsegfr; Type: VIEW; Schema: research; Owner: easygp
--

CREATE VIEW vwdiabeticsegfr AS
    SELECT vwdiabetes_patients_with_hba1c.fk_patient AS pk_view, vwgraphableobservations.loinc, vwgraphableobservations.value_numeric, vwgraphableobservations.value_numeric_qualifier, vwdiabetes_patients_with_hba1c.fk_patient, vwdiabetes_patients_with_hba1c.deceased, vwdiabetes_patients_with_hba1c.active_status, vwgraphableobservations.identifier, vwgraphableobservations.observation_date, vwgraphableobservations.reference_range, vwgraphableobservations.abnormal FROM vwdiabetes_patients_with_hba1c, documents.vwgraphableobservations WHERE ((vwdiabetes_patients_with_hba1c.fk_patient = vwgraphableobservations.fk_patient) AND (vwgraphableobservations.loinc = '33914-3'::text));


ALTER TABLE research.vwdiabeticsegfr OWNER TO easygp;

--
-- Name: VIEW vwdiabeticsegfr; Type: COMMENT; Schema: research; Owner: easygp
--

COMMENT ON VIEW vwdiabeticsegfr IS 'a view of all diabetes and their egfr''s
 note as the fk_patient of the diabetes view is linked to the fk_patient of the observations view
 there is always a 1-1 relationship between these views
 this view could also contain patients who are not diabetic if someone has done
 their hab1c without good cause or logic 
 The GUI layer must use  chronic_disease_management.diabetes_hba1c_not_diabetic
 to filter these non-diabetics out of stats - or at least that is how I''ve done it';


--
-- Name: vwldh; Type: VIEW; Schema: research; Owner: easygp
--

CREATE VIEW vwldh AS
    SELECT vwpatients.wholename, vwpatients.fk_patient, vwobservations.value_numeric, vwobservations.abnormal FROM contacts.vwpatients, documents.vwobservations WHERE (((vwobservations.identifier ~~* '%LDH%'::text) AND (vwobservations.fk_patient = vwpatients.fk_patient)) AND (vwobservations.abnormal IS NOT NULL)) ORDER BY vwobservations.value_numeric;


ALTER TABLE research.vwldh OWNER TO easygp;

--
-- Name: vwldlcholesterol; Type: VIEW; Schema: research; Owner: easygp
--

CREATE VIEW vwldlcholesterol AS
    SELECT vwobservations.fk_patient, vwobservations.pk, vwobservations.identifier, vwobservations.observation_date, vwobservations.value_numeric, vwobservations.value_numeric_qualifier, vwobservations.units, vwobservations.reference_range, vwobservations.abnormal, vwobservations.loinc FROM documents.vwobservations WHERE ((((vwobservations.loinc = '39469-2'::text) OR (vwobservations.loinc = '22748-8'::text)) OR (vwobservations.loinc = '18262-6'::text)) OR (vwobservations.loinc = '2089-1'::text)) ORDER BY vwobservations.fk_patient, vwobservations.observation_date DESC;


ALTER TABLE research.vwldlcholesterol OWNER TO easygp;

--
-- Name: vwmostrecenteyerelateddocuments; Type: VIEW; Schema: research; Owner: easygp
--

CREATE VIEW vwmostrecenteyerelateddocuments AS
    SELECT DISTINCT ON (vwdocuments.fk_patient) vwdocuments.fk_patient AS pk_view, vwdocuments.fk_patient, vwdocuments.pk_document AS fk_document, vwdocuments.date_created, vwdocuments.deleted FROM documents.vwdocuments WHERE ((((((vwdocuments.organisation_category)::text ~~* '%ophthal%'::text) OR ((vwdocuments.organisation_category)::text ~~* '%optom%'::text)) OR (vwdocuments.person_occupation ~~* '%ophthal%'::text)) OR (vwdocuments.person_occupation ~~* '%optom%'::text)) AND (vwdocuments.deleted = false)) ORDER BY vwdocuments.fk_patient, vwdocuments.date_created DESC;


ALTER TABLE research.vwmostrecenteyerelateddocuments OWNER TO easygp;

--
-- Name: VIEW vwmostrecenteyerelateddocuments; Type: COMMENT; Schema: research; Owner: easygp
--

COMMENT ON VIEW vwmostrecenteyerelateddocuments IS '
This is a view of the most recent eye related document found in the database.
Quite dependant on the user allocating an eye-related category.
Though not specific to diabetics, it is currently only used in FDiabetesResearch 
The view key pk_view=fk_patient so once we have all diabetic patients, the view 
yields their eye documents. I put in fk_patient only to remind anyone viewing the
data that pk_view = fk_patient
';


--
-- Name: vwtotalcholesterol; Type: VIEW; Schema: research; Owner: easygp
--

CREATE VIEW vwtotalcholesterol AS
    SELECT vwobservations.fk_patient, vwobservations.pk, vwobservations.identifier, vwobservations.observation_date, vwobservations.value_numeric, vwobservations.value_numeric_qualifier, vwobservations.units, vwobservations.reference_range, vwobservations.abnormal, vwobservations.loinc FROM documents.vwobservations WHERE (vwobservations.loinc = '14647-2'::text) ORDER BY vwobservations.fk_patient, vwobservations.observation_date DESC;


ALTER TABLE research.vwtotalcholesterol OWNER TO easygp;

SET search_path = admin, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: admin; Owner: easygp
--

ALTER TABLE ONLY clinic_rooms ALTER COLUMN pk SET DEFAULT nextval('clinic_rooms_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: admin; Owner: easygp
--

ALTER TABLE ONLY clinics ALTER COLUMN pk SET DEFAULT nextval('clinic_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: admin; Owner: easygp
--

ALTER TABLE ONLY global_preferences ALTER COLUMN pk SET DEFAULT nextval('global_preferences_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: admin; Owner: easygp
--

ALTER TABLE ONLY link_staff_clinics ALTER COLUMN pk SET DEFAULT nextval('link_staff_clinics_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: admin; Owner: easygp
--

ALTER TABLE ONLY lu_clinical_modules ALTER COLUMN pk SET DEFAULT nextval('lu_clinical_modules_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: admin; Owner: easygp
--

ALTER TABLE ONLY lu_staff_roles ALTER COLUMN pk SET DEFAULT nextval('lu_staff_roles_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: admin; Owner: easygp
--

ALTER TABLE ONLY lu_staff_status ALTER COLUMN pk SET DEFAULT nextval('lu_staff_status_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: admin; Owner: easygp
--

ALTER TABLE ONLY lu_staff_type ALTER COLUMN pk SET DEFAULT nextval('lu_staff_type_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: admin; Owner: easygp
--

ALTER TABLE ONLY staff ALTER COLUMN pk SET DEFAULT nextval('staff_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: admin; Owner: easygp
--

ALTER TABLE ONLY staff_clinical_toolbar ALTER COLUMN pk SET DEFAULT nextval('staff_clinical_toolbar_pk_seq'::regclass);


SET search_path = billing, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY bulk_billing_claims ALTER COLUMN pk SET DEFAULT nextval('bulk_billing_claims_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY fee_schedule ALTER COLUMN pk SET DEFAULT nextval('fee_schedule_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY invoices ALTER COLUMN pk SET DEFAULT nextval('invoices_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY items_billed ALTER COLUMN pk SET DEFAULT nextval('items_billed_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY link_invoice_bulk_bill_claim ALTER COLUMN pk SET DEFAULT nextval('link_invoice_bulk_bill_claim_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY lu_billing_type ALTER COLUMN pk SET DEFAULT nextval('lu_billing_type_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY lu_bulk_billing_type ALTER COLUMN pk SET DEFAULT nextval('lu_bulk_billing_type_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY lu_default_billing_level ALTER COLUMN pk SET DEFAULT nextval('lu_default_billing_level_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY lu_invoice_comments ALTER COLUMN pk SET DEFAULT nextval('lu_invoice_comments_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY lu_payment_method ALTER COLUMN pk SET DEFAULT nextval('lu_payment_method_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY lu_reasons_not_billed ALTER COLUMN pk SET DEFAULT nextval('lu_reasons_not_billed_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY lu_reports ALTER COLUMN pk SET DEFAULT nextval('lu_reports_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY payments_received ALTER COLUMN pk SET DEFAULT nextval('payments_received_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY prices ALTER COLUMN pk SET DEFAULT nextval('prices_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: billing; Owner: easygp
--

ALTER TABLE ONLY reports ALTER COLUMN pk SET DEFAULT nextval('reports_pk_seq'::regclass);


SET search_path = blobs, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: blobs; Owner: easygp
--

ALTER TABLE ONLY blobs ALTER COLUMN pk SET DEFAULT nextval('blobs_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: blobs; Owner: easygp
--

ALTER TABLE ONLY images ALTER COLUMN pk SET DEFAULT nextval('images_pk_seq'::regclass);


SET search_path = chronic_disease_management, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: chronic_disease_management; Owner: easygp
--

ALTER TABLE ONLY diabetes_annual_cycle_of_care ALTER COLUMN pk SET DEFAULT nextval('diabetes_annual_cycle_of_care_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: chronic_disease_management; Owner: easygp
--

ALTER TABLE ONLY diabetes_annual_cycle_of_care_notes ALTER COLUMN pk SET DEFAULT nextval('diabetes_annual_cycle_of_care_notes_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: chronic_disease_management; Owner: easygp
--

ALTER TABLE ONLY epc_link_provider_form ALTER COLUMN pk SET DEFAULT nextval('epc_link_provider_form_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: chronic_disease_management; Owner: easygp
--

ALTER TABLE ONLY epc_referral ALTER COLUMN pk SET DEFAULT nextval('epc_referral_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: chronic_disease_management; Owner: easygp
--

ALTER TABLE ONLY lu_allied_health_type ALTER COLUMN pk SET DEFAULT nextval('lu_allied_health_type_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: chronic_disease_management; Owner: easygp
--

ALTER TABLE ONLY lu_dacc_components ALTER COLUMN pk SET DEFAULT nextval('lu_dacc_components_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: chronic_disease_management; Owner: easygp
--

ALTER TABLE ONLY team_care_arrangements ALTER COLUMN pk SET DEFAULT nextval('team_care_arrangements_pk_seq'::regclass);


SET search_path = clerical, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: clerical; Owner: easygp
--

ALTER TABLE ONLY bookings ALTER COLUMN pk SET DEFAULT nextval('bookings_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clerical; Owner: easygp
--

ALTER TABLE ONLY data_families ALTER COLUMN pk SET DEFAULT nextval('data_families_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clerical; Owner: easygp
--

ALTER TABLE ONLY data_family_members ALTER COLUMN pk SET DEFAULT nextval('data_family_members_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clerical; Owner: easygp
--

ALTER TABLE ONLY data_patients ALTER COLUMN pk SET DEFAULT nextval('data_patients_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clerical; Owner: easygp
--

ALTER TABLE ONLY inventory ALTER COLUMN pk SET DEFAULT nextval('inventory_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clerical; Owner: easygp
--

ALTER TABLE ONLY inventory_lent ALTER COLUMN pk SET DEFAULT nextval('inventory_lent_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clerical; Owner: easygp
--

ALTER TABLE ONLY inventory_locations ALTER COLUMN pk SET DEFAULT nextval('inventory_locations_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clerical; Owner: easygp
--

ALTER TABLE ONLY lu_active_status ALTER COLUMN pk SET DEFAULT nextval('lu_active_status_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clerical; Owner: easygp
--

ALTER TABLE ONLY lu_appointment_icons ALTER COLUMN pk SET DEFAULT nextval('lu_appointment_icons_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clerical; Owner: easygp
--

ALTER TABLE ONLY lu_appointment_status ALTER COLUMN pk SET DEFAULT nextval('lu_appointment_status_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clerical; Owner: easygp
--

ALTER TABLE ONLY lu_centrelink_card_type ALTER COLUMN pk SET DEFAULT nextval('lu_centrelink_card_type_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clerical; Owner: easygp
--

ALTER TABLE ONLY lu_inventory_categories ALTER COLUMN pk SET DEFAULT nextval('lu_inventory_categories_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clerical; Owner: easygp
--

ALTER TABLE ONLY lu_inventory_items ALTER COLUMN pk SET DEFAULT nextval('lu_inventory_items_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clerical; Owner: easygp
--

ALTER TABLE ONLY lu_private_health_funds ALTER COLUMN pk SET DEFAULT nextval('lu_private_health_funds_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clerical; Owner: easygp
--

ALTER TABLE ONLY lu_task_types ALTER COLUMN pk SET DEFAULT nextval('lu_task_types_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clerical; Owner: easygp
--

ALTER TABLE ONLY lu_veteran_card_type ALTER COLUMN pk SET DEFAULT nextval('lu_veteran_card_type_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clerical; Owner: easygp
--

ALTER TABLE ONLY sessions ALTER COLUMN pk SET DEFAULT nextval('sessions_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clerical; Owner: easygp
--

ALTER TABLE ONLY task_component_notes ALTER COLUMN pk SET DEFAULT nextval('task_component_notes_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clerical; Owner: easygp
--

ALTER TABLE ONLY task_components ALTER COLUMN pk SET DEFAULT nextval('task_components_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clerical; Owner: easygp
--

ALTER TABLE ONLY tasks ALTER COLUMN pk SET DEFAULT nextval('tasks_pk_seq'::regclass);


SET search_path = clin_allergies, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: clin_allergies; Owner: easygp
--

ALTER TABLE ONLY allergies ALTER COLUMN pk SET DEFAULT nextval('allergies_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_allergies; Owner: easygp
--

ALTER TABLE ONLY lu_reaction_type ALTER COLUMN pk SET DEFAULT nextval('lu_reaction_type_pk_seq'::regclass);


SET search_path = clin_careplans, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: clin_careplans; Owner: easygp
--

ALTER TABLE ONLY careplan_pages ALTER COLUMN pk SET DEFAULT nextval('careplan_pages_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_careplans; Owner: easygp
--

ALTER TABLE ONLY careplans ALTER COLUMN pk SET DEFAULT nextval('careplans_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_careplans; Owner: easygp
--

ALTER TABLE ONLY component_task_due ALTER COLUMN pk SET DEFAULT nextval('component_task_due_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_careplans; Owner: easygp
--

ALTER TABLE ONLY link_careplanpage_advice ALTER COLUMN pk SET DEFAULT nextval('link_careplanpage_advice_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_careplans; Owner: easygp
--

ALTER TABLE ONLY link_careplanpage_components ALTER COLUMN pk SET DEFAULT nextval('link_careplanpage_components_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_careplans; Owner: easygp
--

ALTER TABLE ONLY link_careplanpages_careplan ALTER COLUMN pk SET DEFAULT nextval('link_careplanpages_careplan_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_careplans; Owner: easygp
--

ALTER TABLE ONLY lu_advice ALTER COLUMN pk SET DEFAULT nextval('lu_advice_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_careplans; Owner: easygp
--

ALTER TABLE ONLY lu_aims ALTER COLUMN pk SET DEFAULT nextval('lu_aims_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_careplans; Owner: easygp
--

ALTER TABLE ONLY lu_components ALTER COLUMN pk SET DEFAULT nextval('lu_components_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_careplans; Owner: easygp
--

ALTER TABLE ONLY lu_conditions ALTER COLUMN pk SET DEFAULT nextval('lu_conditions_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_careplans; Owner: easygp
--

ALTER TABLE ONLY lu_education ALTER COLUMN pk SET DEFAULT nextval('lu_education_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_careplans; Owner: easygp
--

ALTER TABLE ONLY lu_responsible ALTER COLUMN pk SET DEFAULT nextval('lu_responsible_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_careplans; Owner: easygp
--

ALTER TABLE ONLY lu_tasks ALTER COLUMN pk SET DEFAULT nextval('lu_tasks_pk_seq'::regclass);


SET search_path = clin_certificates, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: clin_certificates; Owner: easygp
--

ALTER TABLE ONLY certificate_reasons ALTER COLUMN pk SET DEFAULT nextval('certificate_reasons_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_certificates; Owner: easygp
--

ALTER TABLE ONLY lu_fitness ALTER COLUMN pk SET DEFAULT nextval('lu_fitness_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_certificates; Owner: easygp
--

ALTER TABLE ONLY lu_illness_temporality ALTER COLUMN pk SET DEFAULT nextval('lu_illness_temporality_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_certificates; Owner: easygp
--

ALTER TABLE ONLY medical_certificates ALTER COLUMN pk SET DEFAULT nextval('medical_certificate_pk_seq'::regclass);


SET search_path = clin_checkups, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: clin_checkups; Owner: easygp
--

ALTER TABLE ONLY annual_checkup ALTER COLUMN pk SET DEFAULT nextval('annual_checkup_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_checkups; Owner: easygp
--

ALTER TABLE ONLY lu_nutrition_questions ALTER COLUMN pk SET DEFAULT nextval('lu_nutrition_questions_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_checkups; Owner: easygp
--

ALTER TABLE ONLY lu_state_of_health ALTER COLUMN pk SET DEFAULT nextval('lu_state_of_health_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_checkups; Owner: easygp
--

ALTER TABLE ONLY over75 ALTER COLUMN pk SET DEFAULT nextval('over75_pk_seq'::regclass);


SET search_path = clin_consult, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: clin_consult; Owner: easygp
--

ALTER TABLE ONLY consult ALTER COLUMN pk SET DEFAULT nextval('consult_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_consult; Owner: easygp
--

ALTER TABLE ONLY dictations ALTER COLUMN pk SET DEFAULT nextval('dictations_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_consult; Owner: easygp
--

ALTER TABLE ONLY images ALTER COLUMN pk SET DEFAULT nextval('images_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_consult; Owner: easygp
--

ALTER TABLE ONLY lu_audit_actions ALTER COLUMN pk SET DEFAULT nextval('lu_actions_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_consult; Owner: easygp
--

ALTER TABLE ONLY lu_audit_reasons ALTER COLUMN pk SET DEFAULT nextval('lu_audit_reasons_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_consult; Owner: easygp
--

ALTER TABLE ONLY lu_consult_type ALTER COLUMN pk SET DEFAULT nextval('lu_consult_type_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_consult; Owner: easygp
--

ALTER TABLE ONLY lu_progressnote_templates ALTER COLUMN pk SET DEFAULT nextval('lu_progressnote_templates_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_consult; Owner: easygp
--

ALTER TABLE ONLY lu_progressnotes_sections ALTER COLUMN pk SET DEFAULT nextval('lu_progressnotes_sections_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_consult; Owner: easygp
--

ALTER TABLE ONLY lu_scratchpad_status ALTER COLUMN pk SET DEFAULT nextval('lu_scratchpad_status_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_consult; Owner: easygp
--

ALTER TABLE ONLY progressnotes ALTER COLUMN pk SET DEFAULT nextval('progressnotes_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_consult; Owner: easygp
--

ALTER TABLE ONLY scratchpad ALTER COLUMN pk SET DEFAULT nextval('scratchpad_pk_seq'::regclass);


SET search_path = clin_history, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: clin_history; Owner: easygp
--

ALTER TABLE ONLY care_plan_components ALTER COLUMN pk SET DEFAULT nextval('care_plan_components_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_history; Owner: easygp
--

ALTER TABLE ONLY care_plan_components_due ALTER COLUMN pk SET DEFAULT nextval('care_plan_components_due_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_history; Owner: easygp
--

ALTER TABLE ONLY family_conditions ALTER COLUMN pk SET DEFAULT nextval('family_conditions_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_history; Owner: easygp
--

ALTER TABLE ONLY family_links ALTER COLUMN pk SET DEFAULT nextval('family_links_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_history; Owner: easygp
--

ALTER TABLE ONLY family_members ALTER COLUMN pk SET DEFAULT nextval('family_members_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_history; Owner: easygp
--

ALTER TABLE ONLY hospitalisations ALTER COLUMN pk SET DEFAULT nextval('hospitalisations_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_history; Owner: easygp
--

ALTER TABLE ONLY lu_careplan_components ALTER COLUMN pk SET DEFAULT nextval('lu_careplan_components_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_history; Owner: easygp
--

ALTER TABLE ONLY lu_dacc_components ALTER COLUMN pk SET DEFAULT nextval('lu_dacc_components_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_history; Owner: easygp
--

ALTER TABLE ONLY lu_exposures ALTER COLUMN pk SET DEFAULT nextval('lu_exposures_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_history; Owner: easygp
--

ALTER TABLE ONLY occupational_history ALTER COLUMN pk SET DEFAULT nextval('occupational_history_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_history; Owner: easygp
--

ALTER TABLE ONLY occupations_exposures ALTER COLUMN pk SET DEFAULT nextval('occupations_exposures_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_history; Owner: easygp
--

ALTER TABLE ONLY past_history ALTER COLUMN pk SET DEFAULT nextval('past_history_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_history; Owner: easygp
--

ALTER TABLE ONLY recreational_drugs ALTER COLUMN pk SET DEFAULT nextval('recreational_drugs_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_history; Owner: easygp
--

ALTER TABLE ONLY social_history ALTER COLUMN pk SET DEFAULT nextval('social_history_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_history; Owner: easygp
--

ALTER TABLE ONLY team_care_members ALTER COLUMN pk SET DEFAULT nextval('team_care_members_pk_seq'::regclass);


SET search_path = clin_measurements, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: clin_measurements; Owner: easygp
--

ALTER TABLE ONLY lu_type ALTER COLUMN pk SET DEFAULT nextval('lu_type_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_measurements; Owner: easygp
--

ALTER TABLE ONLY measurements ALTER COLUMN pk SET DEFAULT nextval('measurements_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_measurements; Owner: easygp
--

ALTER TABLE ONLY patients_defaults ALTER COLUMN pk SET DEFAULT nextval('patients_defaults_pk_seq'::regclass);


SET search_path = clin_mentalhealth, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: clin_mentalhealth; Owner: easygp
--

ALTER TABLE ONLY k10_results ALTER COLUMN pk SET DEFAULT nextval('k10_results_pk_seq'::regclass);


--
-- Name: pk_tool; Type: DEFAULT; Schema: clin_mentalhealth; Owner: easygp
--

ALTER TABLE ONLY lu_assessment_tools ALTER COLUMN pk_tool SET DEFAULT nextval('lu_assessment_tools_pk_tool_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_mentalhealth; Owner: easygp
--

ALTER TABLE ONLY lu_component_help ALTER COLUMN pk SET DEFAULT nextval('lu_component_help_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_mentalhealth; Owner: easygp
--

ALTER TABLE ONLY lu_depression_degree ALTER COLUMN pk SET DEFAULT nextval('lu_depression_degree_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_mentalhealth; Owner: easygp
--

ALTER TABLE ONLY lu_k10_components ALTER COLUMN pk SET DEFAULT nextval('lu_k10_components_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_mentalhealth; Owner: easygp
--

ALTER TABLE ONLY lu_plan_type ALTER COLUMN pk SET DEFAULT nextval('lu_plan_type_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_mentalhealth; Owner: easygp
--

ALTER TABLE ONLY lu_risk_to_others ALTER COLUMN pk SET DEFAULT nextval('lu_risk_to_others_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_mentalhealth; Owner: easygp
--

ALTER TABLE ONLY mentalhealth_plan ALTER COLUMN pk SET DEFAULT nextval('mentalhealth_plan_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_mentalhealth; Owner: easygp
--

ALTER TABLE ONLY team_care_members ALTER COLUMN pk SET DEFAULT nextval('team_care_members_pk_seq'::regclass);


SET search_path = clin_pregnancy, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: clin_pregnancy; Owner: easygp
--

ALTER TABLE ONLY lu_antenatal_venue ALTER COLUMN pk SET DEFAULT nextval('lu_antenatal_venue_pk_seq'::regclass);


SET search_path = clin_prescribing, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: clin_prescribing; Owner: easygp
--

ALTER TABLE ONLY increased_quantity_authority_reasons ALTER COLUMN pk SET DEFAULT nextval('increased_quantity_authority_reasons_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_prescribing; Owner: easygp
--

ALTER TABLE ONLY instruction_habits ALTER COLUMN pk SET DEFAULT nextval('instruction_habits_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_prescribing; Owner: easygp
--

ALTER TABLE ONLY instructions ALTER COLUMN pk SET DEFAULT nextval('instructions_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_prescribing; Owner: easygp
--

ALTER TABLE ONLY lu_pbs_script_type ALTER COLUMN pk SET DEFAULT nextval('print_status_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_prescribing; Owner: easygp
--

ALTER TABLE ONLY medications ALTER COLUMN pk SET DEFAULT nextval('medications_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_prescribing; Owner: easygp
--

ALTER TABLE ONLY prescribed ALTER COLUMN pk SET DEFAULT nextval('prescribed_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_prescribing; Owner: easygp
--

ALTER TABLE ONLY prescribed_for ALTER COLUMN pk SET DEFAULT nextval('prescribed_for_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_prescribing; Owner: easygp
--

ALTER TABLE ONLY prescribed_for_habits ALTER COLUMN pk SET DEFAULT nextval('prescribed_for_habits_pk_seq'::regclass);


SET search_path = clin_procedures, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: clin_procedures; Owner: easygp
--

ALTER TABLE ONLY link_images_procedures ALTER COLUMN pk SET DEFAULT nextval('link_images_procedures_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_procedures; Owner: easygp
--

ALTER TABLE ONLY lu_anaesthetic_agent ALTER COLUMN pk SET DEFAULT nextval('lu_anaesthetic_agent_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_procedures; Owner: easygp
--

ALTER TABLE ONLY lu_complications ALTER COLUMN pk SET DEFAULT nextval('lu_complications_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_procedures; Owner: easygp
--

ALTER TABLE ONLY lu_last_surgical_pack ALTER COLUMN pk SET DEFAULT nextval('lu_pack_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_procedures; Owner: easygp
--

ALTER TABLE ONLY lu_procedure_type ALTER COLUMN pk SET DEFAULT nextval('lu_excision_type_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_procedures; Owner: easygp
--

ALTER TABLE ONLY lu_repair_type ALTER COLUMN pk SET DEFAULT nextval('lu_repair_type_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_procedures; Owner: easygp
--

ALTER TABLE ONLY lu_skin_preparation ALTER COLUMN pk SET DEFAULT nextval('lu_skin_preparation_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_procedures; Owner: easygp
--

ALTER TABLE ONLY lu_suture_site ALTER COLUMN pk SET DEFAULT nextval('lu_suture_site_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_procedures; Owner: easygp
--

ALTER TABLE ONLY lu_suture_type ALTER COLUMN pk SET DEFAULT nextval('lu_suture_type_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_procedures; Owner: easygp
--

ALTER TABLE ONLY skin_procedures ALTER COLUMN pk SET DEFAULT nextval('skin_procedures_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_procedures; Owner: easygp
--

ALTER TABLE ONLY staff_skin_procedure_defaults ALTER COLUMN pk SET DEFAULT nextval('staff_skin_procedure_defaults_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_procedures; Owner: easygp
--

ALTER TABLE ONLY surgical_packs ALTER COLUMN pk SET DEFAULT nextval('surgical_packs_pk_seq'::regclass);


SET search_path = clin_recalls, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: clin_recalls; Owner: easygp
--

ALTER TABLE ONLY forms ALTER COLUMN pk SET DEFAULT nextval('forms_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_recalls; Owner: easygp
--

ALTER TABLE ONLY links_forms ALTER COLUMN pk SET DEFAULT nextval('links_forms_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_recalls; Owner: easygp
--

ALTER TABLE ONLY lu_reasons ALTER COLUMN pk SET DEFAULT nextval('lu_reasons_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_recalls; Owner: easygp
--

ALTER TABLE ONLY lu_recall_intervals ALTER COLUMN pk SET DEFAULT nextval('lu_recall_intervals_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_recalls; Owner: easygp
--

ALTER TABLE ONLY lu_templates ALTER COLUMN pk SET DEFAULT nextval('lu_templates_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_recalls; Owner: easygp
--

ALTER TABLE ONLY recalls ALTER COLUMN pk SET DEFAULT nextval('recalls_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_recalls; Owner: easygp
--

ALTER TABLE ONLY sent ALTER COLUMN pk SET DEFAULT nextval('sent_pk_seq'::regclass);


SET search_path = clin_referrals, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: clin_referrals; Owner: easygp
--

ALTER TABLE ONLY inclusions ALTER COLUMN pk SET DEFAULT nextval('inclusions_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_referrals; Owner: easygp
--

ALTER TABLE ONLY lu_type ALTER COLUMN pk SET DEFAULT nextval('lu_type_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_referrals; Owner: easygp
--

ALTER TABLE ONLY lu_urgency ALTER COLUMN pk SET DEFAULT nextval('lu_urgency_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_referrals; Owner: easygp
--

ALTER TABLE ONLY referrals ALTER COLUMN pk SET DEFAULT nextval('referrals_pk_seq'::regclass);


SET search_path = clin_requests, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: clin_requests; Owner: easygp
--

ALTER TABLE ONLY forms ALTER COLUMN pk SET DEFAULT nextval('forms_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_requests; Owner: easygp
--

ALTER TABLE ONLY forms_requests ALTER COLUMN pk SET DEFAULT nextval('forms_requests_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_requests; Owner: easygp
--

ALTER TABLE ONLY link_forms_requests_requests_results ALTER COLUMN pk SET DEFAULT nextval('link_forms_requests_requests_results_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_requests; Owner: easygp
--

ALTER TABLE ONLY lu_copyto_type ALTER COLUMN pk SET DEFAULT nextval('lu_copyto_type_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_requests; Owner: easygp
--

ALTER TABLE ONLY lu_form_header ALTER COLUMN pk SET DEFAULT nextval('lu_form_header_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_requests; Owner: easygp
--

ALTER TABLE ONLY lu_instructions ALTER COLUMN pk SET DEFAULT nextval('lu_instructions_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_requests; Owner: easygp
--

ALTER TABLE ONLY lu_link_provider_user_requests ALTER COLUMN pk SET DEFAULT nextval('lu_link_provider_user_requests_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_requests; Owner: easygp
--

ALTER TABLE ONLY lu_request_type ALTER COLUMN pk SET DEFAULT nextval('lu_request_type_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_requests; Owner: easygp
--

ALTER TABLE ONLY lu_requests ALTER COLUMN pk SET DEFAULT nextval('lu_requests_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_requests; Owner: easygp
--

ALTER TABLE ONLY notes ALTER COLUMN pk SET DEFAULT nextval('notes_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_requests; Owner: easygp
--

ALTER TABLE ONLY request_providers ALTER COLUMN pk SET DEFAULT nextval('request_providers_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_requests; Owner: easygp
--

ALTER TABLE ONLY user_default_type ALTER COLUMN pk SET DEFAULT nextval('user_default_type_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_requests; Owner: easygp
--

ALTER TABLE ONLY user_provider_defaults ALTER COLUMN pk SET DEFAULT nextval('user_provider_defaults_pk_seq'::regclass);


SET search_path = clin_vaccination, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: easygp
--

ALTER TABLE ONLY lu_descriptions ALTER COLUMN pk SET DEFAULT nextval('lu_vaccines_descriptions_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: easygp
--

ALTER TABLE ONLY lu_formulation ALTER COLUMN pk SET DEFAULT nextval('lu_formulation_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: easygp
--

ALTER TABLE ONLY lu_schedules ALTER COLUMN pk SET DEFAULT nextval('lu_schedules_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: easygp
--

ALTER TABLE ONLY lu_vaccines ALTER COLUMN pk SET DEFAULT nextval('lu_vaccines_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: easygp
--

ALTER TABLE ONLY lu_vaccines_in_schedule ALTER COLUMN pk SET DEFAULT nextval('lu_vaccines_in_schedule_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: easygp
--

ALTER TABLE ONLY vaccinations ALTER COLUMN pk SET DEFAULT nextval('vaccinations_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_vaccination; Owner: easygp
--

ALTER TABLE ONLY vaccine_serial_numbers ALTER COLUMN pk SET DEFAULT nextval('vaccine_serial_numbers_pk_seq'::regclass);


SET search_path = clin_workcover, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: clin_workcover; Owner: easygp
--

ALTER TABLE ONLY claims ALTER COLUMN pk SET DEFAULT nextval('claims_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_workcover; Owner: easygp
--

ALTER TABLE ONLY lu_caused_by_employment ALTER COLUMN pk SET DEFAULT nextval('lu_caused_by_employment_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_workcover; Owner: easygp
--

ALTER TABLE ONLY lu_visit_type ALTER COLUMN pk SET DEFAULT nextval('lu_visit_type_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: clin_workcover; Owner: easygp
--

ALTER TABLE ONLY visits ALTER COLUMN pk SET DEFAULT nextval('visits_pk_seq'::regclass);


SET search_path = coding, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: coding; Owner: easygp
--

ALTER TABLE ONLY lu_loinc_abbrev ALTER COLUMN pk SET DEFAULT nextval('lu_loinc_abbrev_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: coding; Owner: easygp
--

ALTER TABLE ONLY lu_systems ALTER COLUMN pk SET DEFAULT nextval('lu_systems_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: coding; Owner: easygp
--

ALTER TABLE ONLY usr_codes_weighting ALTER COLUMN pk SET DEFAULT nextval('usr_codes_weighting_pk_seq'::regclass);


SET search_path = common, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: easygp
--

ALTER TABLE ONLY lu_aboriginality ALTER COLUMN pk SET DEFAULT nextval('lu_aboriginality_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: easygp
--

ALTER TABLE ONLY lu_anatomical_localisation ALTER COLUMN pk SET DEFAULT nextval('lu_anatomical_location_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: easygp
--

ALTER TABLE ONLY lu_anatomical_site ALTER COLUMN pk SET DEFAULT nextval('lu_anatomical_site_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: easygp
--

ALTER TABLE ONLY lu_anterior_posterior ALTER COLUMN pk SET DEFAULT nextval('lu_anterior_posterior_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: easygp
--

ALTER TABLE ONLY lu_companion_status ALTER COLUMN pk SET DEFAULT nextval('lu_companion_status_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: easygp
--

ALTER TABLE ONLY lu_countries ALTER COLUMN pk SET DEFAULT nextval('lu_countries_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: easygp
--

ALTER TABLE ONLY lu_ethnicity ALTER COLUMN pk SET DEFAULT nextval('lu_ethnicity_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: easygp
--

ALTER TABLE ONLY lu_family_relationships ALTER COLUMN pk SET DEFAULT nextval('lu_family_relationships_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: easygp
--

ALTER TABLE ONLY lu_formulation ALTER COLUMN pk SET DEFAULT nextval('lu_formulation_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: easygp
--

ALTER TABLE ONLY lu_hearing_aid_status ALTER COLUMN pk SET DEFAULT nextval('lu_hearing_aid_status_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: easygp
--

ALTER TABLE ONLY lu_languages ALTER COLUMN pk SET DEFAULT nextval('lu_languages_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: easygp
--

ALTER TABLE ONLY lu_laterality ALTER COLUMN pk SET DEFAULT nextval('lu_laterality_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: easygp
--

ALTER TABLE ONLY lu_medicolegal ALTER COLUMN pk SET DEFAULT nextval('lu_medicolegal_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: easygp
--

ALTER TABLE ONLY lu_motion ALTER COLUMN pk SET DEFAULT nextval('lu_motion_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: easygp
--

ALTER TABLE ONLY lu_normality ALTER COLUMN pk SET DEFAULT nextval('lu_normality_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: easygp
--

ALTER TABLE ONLY lu_occupations ALTER COLUMN pk SET DEFAULT nextval('lu_occupations_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: easygp
--

ALTER TABLE ONLY lu_proximal_distal ALTER COLUMN pk SET DEFAULT nextval('lu_proximal_distal_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: easygp
--

ALTER TABLE ONLY lu_recreational_drugs ALTER COLUMN pk SET DEFAULT nextval('lu_recreational_drugs_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: easygp
--

ALTER TABLE ONLY lu_religions ALTER COLUMN pk SET DEFAULT nextval('lu_religions_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: easygp
--

ALTER TABLE ONLY lu_route_administration ALTER COLUMN pk SET DEFAULT nextval('lu_route_administration_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: easygp
--

ALTER TABLE ONLY lu_seasons ALTER COLUMN pk SET DEFAULT nextval('lu_seasons_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: easygp
--

ALTER TABLE ONLY lu_site_administration ALTER COLUMN pk SET DEFAULT nextval('lu_site_administration_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: easygp
--

ALTER TABLE ONLY lu_smoking_status ALTER COLUMN pk SET DEFAULT nextval('lu_smoking_status_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: easygp
--

ALTER TABLE ONLY lu_social_support ALTER COLUMN pk SET DEFAULT nextval('lu_social_support_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: easygp
--

ALTER TABLE ONLY lu_sub_religions ALTER COLUMN pk SET DEFAULT nextval('lu_sub_religions_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: easygp
--

ALTER TABLE ONLY lu_units ALTER COLUMN pk SET DEFAULT nextval('lu_units_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: easygp
--

ALTER TABLE ONLY lu_urgency ALTER COLUMN pk SET DEFAULT nextval('lu_urgency_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: easygp
--

ALTER TABLE ONLY lu_whisper_test ALTER COLUMN pk SET DEFAULT nextval('lu_whisper_test_pk_seq'::regclass);


SET search_path = contacts, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: easygp
--

ALTER TABLE ONLY data_addresses ALTER COLUMN pk SET DEFAULT nextval('data_addresses_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: easygp
--

ALTER TABLE ONLY data_branches ALTER COLUMN pk SET DEFAULT nextval('data_branches_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: easygp
--

ALTER TABLE ONLY data_communications ALTER COLUMN pk SET DEFAULT nextval('data_communications_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: easygp
--

ALTER TABLE ONLY data_employees ALTER COLUMN pk SET DEFAULT nextval('data_employees_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: easygp
--

ALTER TABLE ONLY data_numbers ALTER COLUMN pk SET DEFAULT nextval('data_numbers_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: easygp
--

ALTER TABLE ONLY data_organisations ALTER COLUMN pk SET DEFAULT nextval('data_organisations_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: easygp
--

ALTER TABLE ONLY data_persons ALTER COLUMN pk SET DEFAULT nextval('data_persons_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: easygp
--

ALTER TABLE ONLY images ALTER COLUMN pk SET DEFAULT nextval('images_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: easygp
--

ALTER TABLE ONLY links_branches_comms ALTER COLUMN pk SET DEFAULT nextval('links_branches_comms_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: easygp
--

ALTER TABLE ONLY links_employees_comms ALTER COLUMN pk SET DEFAULT nextval('links_employees_comms_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: easygp
--

ALTER TABLE ONLY links_persons_addresses ALTER COLUMN pk SET DEFAULT nextval('links_persons_addresses_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: easygp
--

ALTER TABLE ONLY links_persons_comms ALTER COLUMN pk SET DEFAULT nextval('links_persons_comms_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: easygp
--

ALTER TABLE ONLY lu_address_types ALTER COLUMN pk SET DEFAULT nextval('lu_address_types_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: easygp
--

ALTER TABLE ONLY lu_categories ALTER COLUMN pk SET DEFAULT nextval('lu_categories_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: easygp
--

ALTER TABLE ONLY lu_contact_type ALTER COLUMN pk SET DEFAULT nextval('lu_contact_type_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: easygp
--

ALTER TABLE ONLY lu_employee_status ALTER COLUMN pk SET DEFAULT nextval('lu_employee_status_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: easygp
--

ALTER TABLE ONLY lu_firstnames ALTER COLUMN pk SET DEFAULT nextval('lu_firstnames_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: easygp
--

ALTER TABLE ONLY lu_marital ALTER COLUMN pk SET DEFAULT nextval('lu_marital_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: easygp
--

ALTER TABLE ONLY lu_misspelt_towns ALTER COLUMN pk SET DEFAULT nextval('lu_mismatched_towns_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: easygp
--

ALTER TABLE ONLY lu_sex ALTER COLUMN pk SET DEFAULT nextval('lu_sex_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: easygp
--

ALTER TABLE ONLY lu_surnames ALTER COLUMN pk SET DEFAULT nextval('lu_surnames_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: easygp
--

ALTER TABLE ONLY lu_title ALTER COLUMN pk SET DEFAULT nextval('lu_title_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: easygp
--

ALTER TABLE ONLY lu_towns ALTER COLUMN pk SET DEFAULT nextval('lu_towns_pk_seq'::regclass);


SET search_path = db, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: db; Owner: easygp
--

ALTER TABLE ONLY lu_version ALTER COLUMN pk SET DEFAULT nextval('db_version_pk_seq'::regclass);


SET search_path = defaults, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: defaults; Owner: easygp
--

ALTER TABLE ONLY hl7_inboxes ALTER COLUMN pk SET DEFAULT nextval('hl7_message_destination_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: defaults; Owner: easygp
--

ALTER TABLE ONLY incoming_message_handling ALTER COLUMN pk SET DEFAULT nextval('incoming_message_handling_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: defaults; Owner: easygp
--

ALTER TABLE ONLY lu_link_printer_task ALTER COLUMN pk SET DEFAULT nextval('lu_link_printer_task_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: defaults; Owner: easygp
--

ALTER TABLE ONLY lu_message_display_style ALTER COLUMN pk SET DEFAULT nextval('lu_message_display_style_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: defaults; Owner: easygp
--

ALTER TABLE ONLY lu_message_standard ALTER COLUMN pk SET DEFAULT nextval('lu_message_standard_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: defaults; Owner: easygp
--

ALTER TABLE ONLY lu_printer_host ALTER COLUMN pk SET DEFAULT nextval('lu_printer_host_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: defaults; Owner: easygp
--

ALTER TABLE ONLY lu_printer_task ALTER COLUMN pk SET DEFAULT nextval('lu_printer_task_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: defaults; Owner: easygp
--

ALTER TABLE ONLY script_coordinates ALTER COLUMN pk SET DEFAULT nextval('script_coordinates_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: defaults; Owner: easygp
--

ALTER TABLE ONLY temp ALTER COLUMN pk SET DEFAULT nextval('temp_pk_seq'::regclass);


SET search_path = documents, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: documents; Owner: easygp
--

ALTER TABLE ONLY documents ALTER COLUMN pk SET DEFAULT nextval('documents_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: documents; Owner: easygp
--

ALTER TABLE ONLY lu_archive_site ALTER COLUMN pk SET DEFAULT nextval('lu_archive_site_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: documents; Owner: easygp
--

ALTER TABLE ONLY lu_display_as ALTER COLUMN pk SET DEFAULT nextval('lu_display_as_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: documents; Owner: easygp
--

ALTER TABLE ONLY lu_message_display_style ALTER COLUMN pk SET DEFAULT nextval('lu_message_display_style_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: documents; Owner: easygp
--

ALTER TABLE ONLY lu_message_standard ALTER COLUMN pk SET DEFAULT nextval('lu_message_standard_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: documents; Owner: easygp
--

ALTER TABLE ONLY observations ALTER COLUMN pk SET DEFAULT nextval('observations_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: documents; Owner: easygp
--

ALTER TABLE ONLY sending_entities ALTER COLUMN pk SET DEFAULT nextval('sending_entities_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: documents; Owner: easygp
--

ALTER TABLE ONLY signed_off ALTER COLUMN pk SET DEFAULT nextval('signed_off_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: documents; Owner: easygp
--

ALTER TABLE ONLY unmatched_patients ALTER COLUMN pk SET DEFAULT nextval('unmatched_patients_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: documents; Owner: easygp
--

ALTER TABLE ONLY unmatched_staff ALTER COLUMN pk SET DEFAULT nextval('unmatched_staff_pk_seq'::regclass);


SET search_path = drugs, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: drugs; Owner: easygp
--

ALTER TABLE ONLY clinical_effects ALTER COLUMN pk SET DEFAULT nextval('clinical_effects_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: drugs; Owner: easygp
--

ALTER TABLE ONLY flags ALTER COLUMN pk SET DEFAULT nextval('flags_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: drugs; Owner: easygp
--

ALTER TABLE ONLY info ALTER COLUMN pk SET DEFAULT nextval('info_pk_seq'::regclass);


SET search_path = import_export, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: import_export; Owner: easygp
--

ALTER TABLE ONLY lu_demographics_field_templates ALTER COLUMN pk SET DEFAULT nextval('lu_demographics_field_templates_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: import_export; Owner: easygp
--

ALTER TABLE ONLY lu_misspelt_user_request_tags ALTER COLUMN pk SET DEFAULT nextval('lu_misspelt_user_request_tags_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: import_export; Owner: easygp
--

ALTER TABLE ONLY lu_source_program ALTER COLUMN pk SET DEFAULT nextval('lu_source_program_pk_seq'::regclass);


SET search_path = public, pg_catalog;

--
-- Name: pk; Type: DEFAULT; Schema: public; Owner: easygp
--

ALTER TABLE ONLY inventory_items_lent ALTER COLUMN pk SET DEFAULT nextval('inventory_items_lent_pk_seq'::regclass);


SET search_path = admin, pg_catalog;

--
-- Name: clinic_pkey; Type: CONSTRAINT; Schema: admin; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY clinics
    ADD CONSTRAINT clinic_pkey PRIMARY KEY (pk);


--
-- Name: clinic_rooms_pkey; Type: CONSTRAINT; Schema: admin; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY clinic_rooms
    ADD CONSTRAINT clinic_rooms_pkey PRIMARY KEY (pk);


--
-- Name: global_preferences_pkey; Type: CONSTRAINT; Schema: admin; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY global_preferences
    ADD CONSTRAINT global_preferences_pkey PRIMARY KEY (pk);


--
-- Name: link_staff_clinics_pkey; Type: CONSTRAINT; Schema: admin; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY link_staff_clinics
    ADD CONSTRAINT link_staff_clinics_pkey PRIMARY KEY (pk);


--
-- Name: lu_clinical_modules_pkey; Type: CONSTRAINT; Schema: admin; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_clinical_modules
    ADD CONSTRAINT lu_clinical_modules_pkey PRIMARY KEY (pk);


--
-- Name: lu_staff_roles_pkey; Type: CONSTRAINT; Schema: admin; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_staff_roles
    ADD CONSTRAINT lu_staff_roles_pkey PRIMARY KEY (pk);


--
-- Name: lu_staff_status_pkey; Type: CONSTRAINT; Schema: admin; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_staff_status
    ADD CONSTRAINT lu_staff_status_pkey PRIMARY KEY (pk);


--
-- Name: lu_staff_type_pkey; Type: CONSTRAINT; Schema: admin; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_staff_type
    ADD CONSTRAINT lu_staff_type_pkey PRIMARY KEY (pk);


--
-- Name: staff_clinical_toolbar_pkey; Type: CONSTRAINT; Schema: admin; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY staff_clinical_toolbar
    ADD CONSTRAINT staff_clinical_toolbar_pkey PRIMARY KEY (pk);


--
-- Name: staff_pkey; Type: CONSTRAINT; Schema: admin; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY staff
    ADD CONSTRAINT staff_pkey PRIMARY KEY (pk);


SET search_path = billing, pg_catalog;

--
-- Name: lu_billing_type_pkey; Type: CONSTRAINT; Schema: billing; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_billing_type
    ADD CONSTRAINT lu_billing_type_pkey PRIMARY KEY (pk);


--
-- Name: lu_billing_type_type_key; Type: CONSTRAINT; Schema: billing; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_billing_type
    ADD CONSTRAINT lu_billing_type_type_key UNIQUE (type);


--
-- Name: lu_bulk_billing_type_pkey; Type: CONSTRAINT; Schema: billing; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_bulk_billing_type
    ADD CONSTRAINT lu_bulk_billing_type_pkey PRIMARY KEY (pk);


--
-- Name: lu_default_billing_level_pkey; Type: CONSTRAINT; Schema: billing; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_default_billing_level
    ADD CONSTRAINT lu_default_billing_level_pkey PRIMARY KEY (pk);


SET search_path = blobs, pg_catalog;

--
-- Name: blobs_pkey; Type: CONSTRAINT; Schema: blobs; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY blobs
    ADD CONSTRAINT blobs_pkey PRIMARY KEY (pk);


--
-- Name: images_pkey; Type: CONSTRAINT; Schema: blobs; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY images
    ADD CONSTRAINT images_pkey PRIMARY KEY (pk);


SET search_path = chronic_disease_management, pg_catalog;

--
-- Name: diabetes_annual_cycle_of_care_notes_pkey; Type: CONSTRAINT; Schema: chronic_disease_management; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY diabetes_annual_cycle_of_care_notes
    ADD CONSTRAINT diabetes_annual_cycle_of_care_notes_pkey PRIMARY KEY (pk);


--
-- Name: diabetes_annual_cycle_of_care_pkey; Type: CONSTRAINT; Schema: chronic_disease_management; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY diabetes_annual_cycle_of_care
    ADD CONSTRAINT diabetes_annual_cycle_of_care_pkey PRIMARY KEY (pk);


--
-- Name: epc_link_provider_form_pkey; Type: CONSTRAINT; Schema: chronic_disease_management; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY epc_link_provider_form
    ADD CONSTRAINT epc_link_provider_form_pkey PRIMARY KEY (pk);


--
-- Name: epc_referral_pkey; Type: CONSTRAINT; Schema: chronic_disease_management; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY epc_referral
    ADD CONSTRAINT epc_referral_pkey PRIMARY KEY (pk);


--
-- Name: lu_allied_health_type_pkey; Type: CONSTRAINT; Schema: chronic_disease_management; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_allied_health_type
    ADD CONSTRAINT lu_allied_health_type_pkey PRIMARY KEY (pk);


--
-- Name: lu_dacc_components_pkey; Type: CONSTRAINT; Schema: chronic_disease_management; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_dacc_components
    ADD CONSTRAINT lu_dacc_components_pkey PRIMARY KEY (pk);


--
-- Name: team_care_arrangements_pkey; Type: CONSTRAINT; Schema: chronic_disease_management; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY team_care_arrangements
    ADD CONSTRAINT team_care_arrangements_pkey PRIMARY KEY (pk);


SET search_path = clerical, pg_catalog;

--
-- Name: bookings_pkey; Type: CONSTRAINT; Schema: clerical; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY bookings
    ADD CONSTRAINT bookings_pkey PRIMARY KEY (pk);


--
-- Name: data_families_pkey; Type: CONSTRAINT; Schema: clerical; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY data_families
    ADD CONSTRAINT data_families_pkey PRIMARY KEY (pk);


--
-- Name: data_family_members_pkey; Type: CONSTRAINT; Schema: clerical; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY data_family_members
    ADD CONSTRAINT data_family_members_pkey PRIMARY KEY (pk);


--
-- Name: data_patients_fk_person_key; Type: CONSTRAINT; Schema: clerical; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY data_patients
    ADD CONSTRAINT data_patients_fk_person_key UNIQUE (fk_person);


--
-- Name: data_patients_pkey; Type: CONSTRAINT; Schema: clerical; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY data_patients
    ADD CONSTRAINT data_patients_pkey PRIMARY KEY (pk);


--
-- Name: inventory_lent_pkey; Type: CONSTRAINT; Schema: clerical; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY inventory_lent
    ADD CONSTRAINT inventory_lent_pkey PRIMARY KEY (pk);


--
-- Name: inventory_locations_pkey; Type: CONSTRAINT; Schema: clerical; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY inventory_locations
    ADD CONSTRAINT inventory_locations_pkey PRIMARY KEY (pk);


--
-- Name: inventory_pkey; Type: CONSTRAINT; Schema: clerical; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (pk);


--
-- Name: lu_active_status_pkey; Type: CONSTRAINT; Schema: clerical; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_active_status
    ADD CONSTRAINT lu_active_status_pkey PRIMARY KEY (pk);


--
-- Name: lu_appointment_icons_pkey; Type: CONSTRAINT; Schema: clerical; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_appointment_icons
    ADD CONSTRAINT lu_appointment_icons_pkey PRIMARY KEY (pk);


--
-- Name: lu_appointment_status_pkey; Type: CONSTRAINT; Schema: clerical; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_appointment_status
    ADD CONSTRAINT lu_appointment_status_pkey PRIMARY KEY (pk);


--
-- Name: lu_centrelink_card_type_pkey; Type: CONSTRAINT; Schema: clerical; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_centrelink_card_type
    ADD CONSTRAINT lu_centrelink_card_type_pkey PRIMARY KEY (pk);


--
-- Name: lu_inventory_categories_pkey; Type: CONSTRAINT; Schema: clerical; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_inventory_categories
    ADD CONSTRAINT lu_inventory_categories_pkey PRIMARY KEY (pk);


--
-- Name: lu_inventory_items_pkey; Type: CONSTRAINT; Schema: clerical; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_inventory_items
    ADD CONSTRAINT lu_inventory_items_pkey PRIMARY KEY (pk);


--
-- Name: lu_private_health_funds_pkey; Type: CONSTRAINT; Schema: clerical; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_private_health_funds
    ADD CONSTRAINT lu_private_health_funds_pkey PRIMARY KEY (pk);


--
-- Name: lu_task_types_pkey; Type: CONSTRAINT; Schema: clerical; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_task_types
    ADD CONSTRAINT lu_task_types_pkey PRIMARY KEY (pk);


--
-- Name: lu_veteran_card_type_pkey; Type: CONSTRAINT; Schema: clerical; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_veteran_card_type
    ADD CONSTRAINT lu_veteran_card_type_pkey PRIMARY KEY (pk);


--
-- Name: sessions_pkey; Type: CONSTRAINT; Schema: clerical; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (pk);


--
-- Name: task_component_notes_pkey; Type: CONSTRAINT; Schema: clerical; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY task_component_notes
    ADD CONSTRAINT task_component_notes_pkey PRIMARY KEY (pk);


--
-- Name: task_components_pkey; Type: CONSTRAINT; Schema: clerical; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY task_components
    ADD CONSTRAINT task_components_pkey PRIMARY KEY (pk);


--
-- Name: tasks_pkey; Type: CONSTRAINT; Schema: clerical; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (pk);


SET search_path = clin_allergies, pg_catalog;

--
-- Name: allergies_pkey; Type: CONSTRAINT; Schema: clin_allergies; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY allergies
    ADD CONSTRAINT allergies_pkey PRIMARY KEY (pk);


--
-- Name: lu_reaction_type_pkey; Type: CONSTRAINT; Schema: clin_allergies; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_reaction_type
    ADD CONSTRAINT lu_reaction_type_pkey PRIMARY KEY (pk);


SET search_path = clin_careplans, pg_catalog;

--
-- Name: careplan_pages_pkey1; Type: CONSTRAINT; Schema: clin_careplans; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY careplan_pages
    ADD CONSTRAINT careplan_pages_pkey1 PRIMARY KEY (pk);


--
-- Name: careplans_pkey; Type: CONSTRAINT; Schema: clin_careplans; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY careplans
    ADD CONSTRAINT careplans_pkey PRIMARY KEY (pk);


--
-- Name: component_task_due_pkey; Type: CONSTRAINT; Schema: clin_careplans; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY component_task_due
    ADD CONSTRAINT component_task_due_pkey PRIMARY KEY (pk);


--
-- Name: link_careplanpage_advice_pkey; Type: CONSTRAINT; Schema: clin_careplans; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY link_careplanpage_advice
    ADD CONSTRAINT link_careplanpage_advice_pkey PRIMARY KEY (pk);


--
-- Name: link_careplanpage_components_pkey; Type: CONSTRAINT; Schema: clin_careplans; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY link_careplanpage_components
    ADD CONSTRAINT link_careplanpage_components_pkey PRIMARY KEY (pk);


--
-- Name: link_careplanpages_careplan_pkey; Type: CONSTRAINT; Schema: clin_careplans; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY link_careplanpages_careplan
    ADD CONSTRAINT link_careplanpages_careplan_pkey PRIMARY KEY (pk);


--
-- Name: lu_advice_pkey; Type: CONSTRAINT; Schema: clin_careplans; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_advice
    ADD CONSTRAINT lu_advice_pkey PRIMARY KEY (pk);


--
-- Name: lu_aims_pkey; Type: CONSTRAINT; Schema: clin_careplans; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_aims
    ADD CONSTRAINT lu_aims_pkey PRIMARY KEY (pk);


--
-- Name: lu_components_pkey; Type: CONSTRAINT; Schema: clin_careplans; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_components
    ADD CONSTRAINT lu_components_pkey PRIMARY KEY (pk);


--
-- Name: lu_conditions_pkey; Type: CONSTRAINT; Schema: clin_careplans; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_conditions
    ADD CONSTRAINT lu_conditions_pkey PRIMARY KEY (pk);


--
-- Name: lu_education_pkey; Type: CONSTRAINT; Schema: clin_careplans; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_education
    ADD CONSTRAINT lu_education_pkey PRIMARY KEY (pk);


--
-- Name: lu_responsible_pkey; Type: CONSTRAINT; Schema: clin_careplans; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_responsible
    ADD CONSTRAINT lu_responsible_pkey PRIMARY KEY (pk);


--
-- Name: lu_tasks_pkey; Type: CONSTRAINT; Schema: clin_careplans; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_tasks
    ADD CONSTRAINT lu_tasks_pkey PRIMARY KEY (pk);


SET search_path = clin_certificates, pg_catalog;

--
-- Name: certificate_reasons_pkey; Type: CONSTRAINT; Schema: clin_certificates; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY certificate_reasons
    ADD CONSTRAINT certificate_reasons_pkey PRIMARY KEY (pk);


--
-- Name: lu_fitness_pkey; Type: CONSTRAINT; Schema: clin_certificates; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_fitness
    ADD CONSTRAINT lu_fitness_pkey PRIMARY KEY (pk);


--
-- Name: lu_illness_temporality_pkey; Type: CONSTRAINT; Schema: clin_certificates; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_illness_temporality
    ADD CONSTRAINT lu_illness_temporality_pkey PRIMARY KEY (pk);


--
-- Name: medical_certificate_pkey; Type: CONSTRAINT; Schema: clin_certificates; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY medical_certificates
    ADD CONSTRAINT medical_certificate_pkey PRIMARY KEY (pk);


SET search_path = clin_checkups, pg_catalog;

--
-- Name: annual_checkup_pkey; Type: CONSTRAINT; Schema: clin_checkups; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY annual_checkup
    ADD CONSTRAINT annual_checkup_pkey PRIMARY KEY (pk);


--
-- Name: lu_nutrition_questions_pkey; Type: CONSTRAINT; Schema: clin_checkups; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_nutrition_questions
    ADD CONSTRAINT lu_nutrition_questions_pkey PRIMARY KEY (pk);


--
-- Name: lu_state_of_health_pkey; Type: CONSTRAINT; Schema: clin_checkups; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_state_of_health
    ADD CONSTRAINT lu_state_of_health_pkey PRIMARY KEY (pk);


--
-- Name: over75_pkey; Type: CONSTRAINT; Schema: clin_checkups; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY over75
    ADD CONSTRAINT over75_pkey PRIMARY KEY (pk);


SET search_path = clin_consult, pg_catalog;

--
-- Name: consult_pkey; Type: CONSTRAINT; Schema: clin_consult; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY consult
    ADD CONSTRAINT consult_pkey PRIMARY KEY (pk);


--
-- Name: dictations_pkey; Type: CONSTRAINT; Schema: clin_consult; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY dictations
    ADD CONSTRAINT dictations_pkey PRIMARY KEY (pk);


--
-- Name: images_pkey; Type: CONSTRAINT; Schema: clin_consult; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY images
    ADD CONSTRAINT images_pkey PRIMARY KEY (pk);


--
-- Name: lu_actions_pkey; Type: CONSTRAINT; Schema: clin_consult; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_audit_actions
    ADD CONSTRAINT lu_actions_pkey PRIMARY KEY (pk);


--
-- Name: lu_consult_type_pkey; Type: CONSTRAINT; Schema: clin_consult; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_consult_type
    ADD CONSTRAINT lu_consult_type_pkey PRIMARY KEY (pk);


--
-- Name: lu_progressnote_templates_pkey; Type: CONSTRAINT; Schema: clin_consult; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_progressnote_templates
    ADD CONSTRAINT lu_progressnote_templates_pkey PRIMARY KEY (pk);


--
-- Name: lu_progressnotes_sections_pkey; Type: CONSTRAINT; Schema: clin_consult; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_progressnotes_sections
    ADD CONSTRAINT lu_progressnotes_sections_pkey PRIMARY KEY (pk);


--
-- Name: lu_reasons_pkey; Type: CONSTRAINT; Schema: clin_consult; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_audit_reasons
    ADD CONSTRAINT lu_reasons_pkey PRIMARY KEY (pk);


--
-- Name: lu_status_pkey; Type: CONSTRAINT; Schema: clin_consult; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_scratchpad_status
    ADD CONSTRAINT lu_status_pkey PRIMARY KEY (pk);


--
-- Name: progressnotes_pkey; Type: CONSTRAINT; Schema: clin_consult; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY progressnotes
    ADD CONSTRAINT progressnotes_pkey PRIMARY KEY (pk);


--
-- Name: scratchpad_pkey; Type: CONSTRAINT; Schema: clin_consult; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY scratchpad
    ADD CONSTRAINT scratchpad_pkey PRIMARY KEY (pk);


SET search_path = clin_history, pg_catalog;

--
-- Name: care_plan_components_due_pkey; Type: CONSTRAINT; Schema: clin_history; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY care_plan_components_due
    ADD CONSTRAINT care_plan_components_due_pkey PRIMARY KEY (pk);


--
-- Name: care_plan_components_pkey; Type: CONSTRAINT; Schema: clin_history; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY care_plan_components
    ADD CONSTRAINT care_plan_components_pkey PRIMARY KEY (pk);


--
-- Name: family_conditions_pkey; Type: CONSTRAINT; Schema: clin_history; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY family_conditions
    ADD CONSTRAINT family_conditions_pkey PRIMARY KEY (pk);


--
-- Name: family_links_pkey; Type: CONSTRAINT; Schema: clin_history; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY family_links
    ADD CONSTRAINT family_links_pkey PRIMARY KEY (pk);


--
-- Name: family_members_pkey; Type: CONSTRAINT; Schema: clin_history; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY family_members
    ADD CONSTRAINT family_members_pkey PRIMARY KEY (pk);


--
-- Name: hospitalisations_pkey; Type: CONSTRAINT; Schema: clin_history; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY hospitalisations
    ADD CONSTRAINT hospitalisations_pkey PRIMARY KEY (pk);


--
-- Name: lu_careplan_components_pkey; Type: CONSTRAINT; Schema: clin_history; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_careplan_components
    ADD CONSTRAINT lu_careplan_components_pkey PRIMARY KEY (pk);


--
-- Name: lu_dacc_components_pkey; Type: CONSTRAINT; Schema: clin_history; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_dacc_components
    ADD CONSTRAINT lu_dacc_components_pkey PRIMARY KEY (pk);


--
-- Name: lu_exposures_pkey; Type: CONSTRAINT; Schema: clin_history; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_exposures
    ADD CONSTRAINT lu_exposures_pkey PRIMARY KEY (pk);


--
-- Name: occupational_history_pkey; Type: CONSTRAINT; Schema: clin_history; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY occupational_history
    ADD CONSTRAINT occupational_history_pkey PRIMARY KEY (pk);


--
-- Name: occupations_exposures_pkey; Type: CONSTRAINT; Schema: clin_history; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY occupations_exposures
    ADD CONSTRAINT occupations_exposures_pkey PRIMARY KEY (pk);


--
-- Name: past_history_pkey; Type: CONSTRAINT; Schema: clin_history; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY past_history
    ADD CONSTRAINT past_history_pkey PRIMARY KEY (pk);


--
-- Name: recreational_drugs_pkey; Type: CONSTRAINT; Schema: clin_history; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY recreational_drugs
    ADD CONSTRAINT recreational_drugs_pkey PRIMARY KEY (pk);


--
-- Name: social_history_pkey; Type: CONSTRAINT; Schema: clin_history; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY social_history
    ADD CONSTRAINT social_history_pkey PRIMARY KEY (pk);


--
-- Name: team_care_members_pkey; Type: CONSTRAINT; Schema: clin_history; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY team_care_members
    ADD CONSTRAINT team_care_members_pkey PRIMARY KEY (pk);


SET search_path = clin_measurements, pg_catalog;

--
-- Name: lu_type_pkey; Type: CONSTRAINT; Schema: clin_measurements; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_type
    ADD CONSTRAINT lu_type_pkey PRIMARY KEY (pk);


--
-- Name: measurements_pkey; Type: CONSTRAINT; Schema: clin_measurements; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY measurements
    ADD CONSTRAINT measurements_pkey PRIMARY KEY (pk);


--
-- Name: patients_defaults_pkey; Type: CONSTRAINT; Schema: clin_measurements; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY patients_defaults
    ADD CONSTRAINT patients_defaults_pkey PRIMARY KEY (pk);


SET search_path = clin_mentalhealth, pg_catalog;

--
-- Name: k10_results_pkey; Type: CONSTRAINT; Schema: clin_mentalhealth; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY k10_results
    ADD CONSTRAINT k10_results_pkey PRIMARY KEY (pk);


--
-- Name: lu_assessment_tools_pkey; Type: CONSTRAINT; Schema: clin_mentalhealth; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_assessment_tools
    ADD CONSTRAINT lu_assessment_tools_pkey PRIMARY KEY (pk_tool);


--
-- Name: lu_component_help_pkey; Type: CONSTRAINT; Schema: clin_mentalhealth; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_component_help
    ADD CONSTRAINT lu_component_help_pkey PRIMARY KEY (pk);


--
-- Name: lu_depression_degree_pkey; Type: CONSTRAINT; Schema: clin_mentalhealth; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_depression_degree
    ADD CONSTRAINT lu_depression_degree_pkey PRIMARY KEY (pk);


--
-- Name: lu_k10_components_pkey; Type: CONSTRAINT; Schema: clin_mentalhealth; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_k10_components
    ADD CONSTRAINT lu_k10_components_pkey PRIMARY KEY (pk);


--
-- Name: lu_plan_type_pkey; Type: CONSTRAINT; Schema: clin_mentalhealth; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_plan_type
    ADD CONSTRAINT lu_plan_type_pkey PRIMARY KEY (pk);


--
-- Name: lu_risk_to_others_pkey; Type: CONSTRAINT; Schema: clin_mentalhealth; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_risk_to_others
    ADD CONSTRAINT lu_risk_to_others_pkey PRIMARY KEY (pk);


--
-- Name: mentalhealth_plan_pkey; Type: CONSTRAINT; Schema: clin_mentalhealth; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY mentalhealth_plan
    ADD CONSTRAINT mentalhealth_plan_pkey PRIMARY KEY (pk);


--
-- Name: team_care_members_pkey; Type: CONSTRAINT; Schema: clin_mentalhealth; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY team_care_members
    ADD CONSTRAINT team_care_members_pkey PRIMARY KEY (pk);


SET search_path = clin_pregnancy, pg_catalog;

--
-- Name: lu_antenatal_venue_pkey; Type: CONSTRAINT; Schema: clin_pregnancy; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_antenatal_venue
    ADD CONSTRAINT lu_antenatal_venue_pkey PRIMARY KEY (pk);


SET search_path = clin_prescribing, pg_catalog;

--
-- Name: increased_quantity_authority_reasons_pkey; Type: CONSTRAINT; Schema: clin_prescribing; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY increased_quantity_authority_reasons
    ADD CONSTRAINT increased_quantity_authority_reasons_pkey PRIMARY KEY (pk);


--
-- Name: instruction_habits_pkey; Type: CONSTRAINT; Schema: clin_prescribing; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY instruction_habits
    ADD CONSTRAINT instruction_habits_pkey PRIMARY KEY (pk);


--
-- Name: instructions_pkey; Type: CONSTRAINT; Schema: clin_prescribing; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY instructions
    ADD CONSTRAINT instructions_pkey PRIMARY KEY (pk);


--
-- Name: medications_pkey; Type: CONSTRAINT; Schema: clin_prescribing; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY medications
    ADD CONSTRAINT medications_pkey PRIMARY KEY (pk);


--
-- Name: prescribed_for_habits_pkey; Type: CONSTRAINT; Schema: clin_prescribing; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY prescribed_for_habits
    ADD CONSTRAINT prescribed_for_habits_pkey PRIMARY KEY (pk);


--
-- Name: prescribed_for_pkey; Type: CONSTRAINT; Schema: clin_prescribing; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY prescribed_for
    ADD CONSTRAINT prescribed_for_pkey PRIMARY KEY (pk);


--
-- Name: prescribed_pkey; Type: CONSTRAINT; Schema: clin_prescribing; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY prescribed
    ADD CONSTRAINT prescribed_pkey PRIMARY KEY (pk);


--
-- Name: print_status_pkey; Type: CONSTRAINT; Schema: clin_prescribing; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_pbs_script_type
    ADD CONSTRAINT print_status_pkey PRIMARY KEY (pk);


SET search_path = clin_procedures, pg_catalog;

--
-- Name: link_images_procedures_pkey; Type: CONSTRAINT; Schema: clin_procedures; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY link_images_procedures
    ADD CONSTRAINT link_images_procedures_pkey PRIMARY KEY (pk);


--
-- Name: lu_anaesthetic_agent_pkey; Type: CONSTRAINT; Schema: clin_procedures; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_anaesthetic_agent
    ADD CONSTRAINT lu_anaesthetic_agent_pkey PRIMARY KEY (pk);


--
-- Name: lu_complications_pkey; Type: CONSTRAINT; Schema: clin_procedures; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_complications
    ADD CONSTRAINT lu_complications_pkey PRIMARY KEY (pk);


--
-- Name: lu_excision_type_pkey; Type: CONSTRAINT; Schema: clin_procedures; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_procedure_type
    ADD CONSTRAINT lu_excision_type_pkey PRIMARY KEY (pk);


--
-- Name: lu_pack_pkey; Type: CONSTRAINT; Schema: clin_procedures; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_last_surgical_pack
    ADD CONSTRAINT lu_pack_pkey PRIMARY KEY (pk);


--
-- Name: lu_repair_type_pkey; Type: CONSTRAINT; Schema: clin_procedures; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_repair_type
    ADD CONSTRAINT lu_repair_type_pkey PRIMARY KEY (pk);


--
-- Name: lu_skin_preparation_pkey; Type: CONSTRAINT; Schema: clin_procedures; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_skin_preparation
    ADD CONSTRAINT lu_skin_preparation_pkey PRIMARY KEY (pk);


--
-- Name: lu_suture_site_pkey; Type: CONSTRAINT; Schema: clin_procedures; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_suture_site
    ADD CONSTRAINT lu_suture_site_pkey PRIMARY KEY (pk);


--
-- Name: lu_suture_type_pkey; Type: CONSTRAINT; Schema: clin_procedures; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_suture_type
    ADD CONSTRAINT lu_suture_type_pkey PRIMARY KEY (pk);


--
-- Name: skin_procedures_pkey; Type: CONSTRAINT; Schema: clin_procedures; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY skin_procedures
    ADD CONSTRAINT skin_procedures_pkey PRIMARY KEY (pk);


--
-- Name: staff_skin_procedure_defaults_pkey; Type: CONSTRAINT; Schema: clin_procedures; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY staff_skin_procedure_defaults
    ADD CONSTRAINT staff_skin_procedure_defaults_pkey PRIMARY KEY (pk);


--
-- Name: surgical_packs_pkey; Type: CONSTRAINT; Schema: clin_procedures; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY surgical_packs
    ADD CONSTRAINT surgical_packs_pkey PRIMARY KEY (pk);


SET search_path = clin_recalls, pg_catalog;

--
-- Name: forms_pkey; Type: CONSTRAINT; Schema: clin_recalls; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY forms
    ADD CONSTRAINT forms_pkey PRIMARY KEY (pk);


--
-- Name: lu_reasons_pkey; Type: CONSTRAINT; Schema: clin_recalls; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_reasons
    ADD CONSTRAINT lu_reasons_pkey PRIMARY KEY (pk);


--
-- Name: lu_recall_intervals_pkey; Type: CONSTRAINT; Schema: clin_recalls; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_recall_intervals
    ADD CONSTRAINT lu_recall_intervals_pkey PRIMARY KEY (pk);


--
-- Name: lu_templates_pkey; Type: CONSTRAINT; Schema: clin_recalls; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_templates
    ADD CONSTRAINT lu_templates_pkey PRIMARY KEY (pk);


--
-- Name: recalls_pkey; Type: CONSTRAINT; Schema: clin_recalls; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY recalls
    ADD CONSTRAINT recalls_pkey PRIMARY KEY (pk);


--
-- Name: sent_pkey; Type: CONSTRAINT; Schema: clin_recalls; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY sent
    ADD CONSTRAINT sent_pkey PRIMARY KEY (pk);


SET search_path = clin_referrals, pg_catalog;

--
-- Name: inclusions_pkey; Type: CONSTRAINT; Schema: clin_referrals; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY inclusions
    ADD CONSTRAINT inclusions_pkey PRIMARY KEY (pk);


--
-- Name: lu_type_pkey; Type: CONSTRAINT; Schema: clin_referrals; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_type
    ADD CONSTRAINT lu_type_pkey PRIMARY KEY (pk);


--
-- Name: lu_urgency_pkey; Type: CONSTRAINT; Schema: clin_referrals; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_urgency
    ADD CONSTRAINT lu_urgency_pkey PRIMARY KEY (pk);


--
-- Name: referrals_pkey; Type: CONSTRAINT; Schema: clin_referrals; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY referrals
    ADD CONSTRAINT referrals_pkey PRIMARY KEY (pk);


SET search_path = clin_requests, pg_catalog;

--
-- Name: forms_pkey; Type: CONSTRAINT; Schema: clin_requests; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY forms
    ADD CONSTRAINT forms_pkey PRIMARY KEY (pk);


--
-- Name: forms_requests_pkey; Type: CONSTRAINT; Schema: clin_requests; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY forms_requests
    ADD CONSTRAINT forms_requests_pkey PRIMARY KEY (pk);


--
-- Name: link_forms_requests_requests_results_pkey; Type: CONSTRAINT; Schema: clin_requests; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY link_forms_requests_requests_results
    ADD CONSTRAINT link_forms_requests_requests_results_pkey PRIMARY KEY (pk);


--
-- Name: lu_copyto_type_pkey; Type: CONSTRAINT; Schema: clin_requests; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_copyto_type
    ADD CONSTRAINT lu_copyto_type_pkey PRIMARY KEY (pk);


--
-- Name: lu_form_header_pkey; Type: CONSTRAINT; Schema: clin_requests; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_form_header
    ADD CONSTRAINT lu_form_header_pkey PRIMARY KEY (pk);


--
-- Name: lu_instructions_pkey; Type: CONSTRAINT; Schema: clin_requests; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_instructions
    ADD CONSTRAINT lu_instructions_pkey PRIMARY KEY (pk);


--
-- Name: lu_link_provider_user_requests_pkey; Type: CONSTRAINT; Schema: clin_requests; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_link_provider_user_requests
    ADD CONSTRAINT lu_link_provider_user_requests_pkey PRIMARY KEY (pk);


--
-- Name: lu_request_type_pkey; Type: CONSTRAINT; Schema: clin_requests; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_request_type
    ADD CONSTRAINT lu_request_type_pkey PRIMARY KEY (pk);


--
-- Name: lu_requests_pkey; Type: CONSTRAINT; Schema: clin_requests; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_requests
    ADD CONSTRAINT lu_requests_pkey PRIMARY KEY (pk);


--
-- Name: notes_pkey; Type: CONSTRAINT; Schema: clin_requests; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (pk);


--
-- Name: request_providers_pkey; Type: CONSTRAINT; Schema: clin_requests; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY request_providers
    ADD CONSTRAINT request_providers_pkey PRIMARY KEY (pk);


--
-- Name: user_default_type_pkey; Type: CONSTRAINT; Schema: clin_requests; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY user_default_type
    ADD CONSTRAINT user_default_type_pkey PRIMARY KEY (pk);


--
-- Name: user_provider_defaults_pkey; Type: CONSTRAINT; Schema: clin_requests; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY user_provider_defaults
    ADD CONSTRAINT user_provider_defaults_pkey PRIMARY KEY (pk);


SET search_path = clin_vaccination, pg_catalog;

--
-- Name: lu_formulation_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_formulation
    ADD CONSTRAINT lu_formulation_pkey PRIMARY KEY (pk);


--
-- Name: lu_schedules_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_schedules
    ADD CONSTRAINT lu_schedules_pkey PRIMARY KEY (pk);


--
-- Name: lu_vaccines_descriptions_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_descriptions
    ADD CONSTRAINT lu_vaccines_descriptions_pkey PRIMARY KEY (pk);


--
-- Name: lu_vaccines_in_schedule_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_vaccines_in_schedule
    ADD CONSTRAINT lu_vaccines_in_schedule_pkey PRIMARY KEY (pk);


--
-- Name: lu_vaccines_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_vaccines
    ADD CONSTRAINT lu_vaccines_pkey PRIMARY KEY (pk);


--
-- Name: vaccinations_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY vaccinations
    ADD CONSTRAINT vaccinations_pkey PRIMARY KEY (pk);


--
-- Name: vaccine_serial_numbers_pkey; Type: CONSTRAINT; Schema: clin_vaccination; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY vaccine_serial_numbers
    ADD CONSTRAINT vaccine_serial_numbers_pkey PRIMARY KEY (pk);


SET search_path = clin_workcover, pg_catalog;

--
-- Name: claims_pkey; Type: CONSTRAINT; Schema: clin_workcover; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY claims
    ADD CONSTRAINT claims_pkey PRIMARY KEY (pk);


--
-- Name: lu_caused_by_employment_pkey; Type: CONSTRAINT; Schema: clin_workcover; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_caused_by_employment
    ADD CONSTRAINT lu_caused_by_employment_pkey PRIMARY KEY (pk);


--
-- Name: lu_visit_type_pkey; Type: CONSTRAINT; Schema: clin_workcover; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_visit_type
    ADD CONSTRAINT lu_visit_type_pkey PRIMARY KEY (pk);


--
-- Name: visits_pkey; Type: CONSTRAINT; Schema: clin_workcover; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY visits
    ADD CONSTRAINT visits_pkey PRIMARY KEY (pk);


SET search_path = coding, pg_catalog;

--
-- Name: lu_loinc_abbrev_pkey; Type: CONSTRAINT; Schema: coding; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_loinc_abbrev
    ADD CONSTRAINT lu_loinc_abbrev_pkey PRIMARY KEY (pk);


--
-- Name: lu_systems_pkey; Type: CONSTRAINT; Schema: coding; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_systems
    ADD CONSTRAINT lu_systems_pkey PRIMARY KEY (pk);


--
-- Name: usr_codes_weighting_pkey; Type: CONSTRAINT; Schema: coding; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY usr_codes_weighting
    ADD CONSTRAINT usr_codes_weighting_pkey PRIMARY KEY (pk);


SET search_path = common, pg_catalog;

--
-- Name: lu_aboriginality_pkey; Type: CONSTRAINT; Schema: common; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_aboriginality
    ADD CONSTRAINT lu_aboriginality_pkey PRIMARY KEY (pk);


--
-- Name: lu_anatomical_location_pkey; Type: CONSTRAINT; Schema: common; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_anatomical_localisation
    ADD CONSTRAINT lu_anatomical_location_pkey PRIMARY KEY (pk);


--
-- Name: lu_anatomical_site_pkey; Type: CONSTRAINT; Schema: common; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_anatomical_site
    ADD CONSTRAINT lu_anatomical_site_pkey PRIMARY KEY (pk);


--
-- Name: lu_anterior_posterior_pkey; Type: CONSTRAINT; Schema: common; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_anterior_posterior
    ADD CONSTRAINT lu_anterior_posterior_pkey PRIMARY KEY (pk);


--
-- Name: lu_appointment_length_pkey; Type: CONSTRAINT; Schema: common; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_appointment_length
    ADD CONSTRAINT lu_appointment_length_pkey PRIMARY KEY (pk);


--
-- Name: lu_companion_status_pkey; Type: CONSTRAINT; Schema: common; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_companion_status
    ADD CONSTRAINT lu_companion_status_pkey PRIMARY KEY (pk);


--
-- Name: lu_countries_pkey; Type: CONSTRAINT; Schema: common; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_countries
    ADD CONSTRAINT lu_countries_pkey PRIMARY KEY (pk);


--
-- Name: lu_ethnicity_pkey; Type: CONSTRAINT; Schema: common; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_ethnicity
    ADD CONSTRAINT lu_ethnicity_pkey PRIMARY KEY (pk);


--
-- Name: lu_family_relationships_pkey; Type: CONSTRAINT; Schema: common; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_family_relationships
    ADD CONSTRAINT lu_family_relationships_pkey PRIMARY KEY (pk);


--
-- Name: lu_formulation_pkey; Type: CONSTRAINT; Schema: common; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_formulation
    ADD CONSTRAINT lu_formulation_pkey PRIMARY KEY (pk);


--
-- Name: lu_hearing_aid_status_pkey; Type: CONSTRAINT; Schema: common; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_hearing_aid_status
    ADD CONSTRAINT lu_hearing_aid_status_pkey PRIMARY KEY (pk);


--
-- Name: lu_languages_pkey; Type: CONSTRAINT; Schema: common; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_languages
    ADD CONSTRAINT lu_languages_pkey PRIMARY KEY (pk);


--
-- Name: lu_laterality_pkey; Type: CONSTRAINT; Schema: common; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_laterality
    ADD CONSTRAINT lu_laterality_pkey PRIMARY KEY (pk);


--
-- Name: lu_medicolegal_pkey; Type: CONSTRAINT; Schema: common; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_medicolegal
    ADD CONSTRAINT lu_medicolegal_pkey PRIMARY KEY (pk);


--
-- Name: lu_motion_pkey; Type: CONSTRAINT; Schema: common; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_motion
    ADD CONSTRAINT lu_motion_pkey PRIMARY KEY (pk);


--
-- Name: lu_normality_pkey; Type: CONSTRAINT; Schema: common; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_normality
    ADD CONSTRAINT lu_normality_pkey PRIMARY KEY (pk);


--
-- Name: lu_occupations_pkey; Type: CONSTRAINT; Schema: common; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_occupations
    ADD CONSTRAINT lu_occupations_pkey PRIMARY KEY (pk);


--
-- Name: lu_proximal_distal_pkey; Type: CONSTRAINT; Schema: common; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_proximal_distal
    ADD CONSTRAINT lu_proximal_distal_pkey PRIMARY KEY (pk);


--
-- Name: lu_recreational_drugs_pkey; Type: CONSTRAINT; Schema: common; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_recreational_drugs
    ADD CONSTRAINT lu_recreational_drugs_pkey PRIMARY KEY (pk);


--
-- Name: lu_religions_pkey; Type: CONSTRAINT; Schema: common; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_religions
    ADD CONSTRAINT lu_religions_pkey PRIMARY KEY (pk);


--
-- Name: lu_route_administration_pkey; Type: CONSTRAINT; Schema: common; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_route_administration
    ADD CONSTRAINT lu_route_administration_pkey PRIMARY KEY (pk);


--
-- Name: lu_seasons_pkey; Type: CONSTRAINT; Schema: common; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_seasons
    ADD CONSTRAINT lu_seasons_pkey PRIMARY KEY (pk);


--
-- Name: lu_site_administration_pkey; Type: CONSTRAINT; Schema: common; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_site_administration
    ADD CONSTRAINT lu_site_administration_pkey PRIMARY KEY (pk);


--
-- Name: lu_smoking_status_pkey; Type: CONSTRAINT; Schema: common; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_smoking_status
    ADD CONSTRAINT lu_smoking_status_pkey PRIMARY KEY (pk);


--
-- Name: lu_social_support_pkey; Type: CONSTRAINT; Schema: common; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_social_support
    ADD CONSTRAINT lu_social_support_pkey PRIMARY KEY (pk);


--
-- Name: lu_sub_religions_pkey; Type: CONSTRAINT; Schema: common; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_sub_religions
    ADD CONSTRAINT lu_sub_religions_pkey PRIMARY KEY (pk);


--
-- Name: lu_units_pkey; Type: CONSTRAINT; Schema: common; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_units
    ADD CONSTRAINT lu_units_pkey PRIMARY KEY (pk);


--
-- Name: lu_urgency_pkey; Type: CONSTRAINT; Schema: common; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_urgency
    ADD CONSTRAINT lu_urgency_pkey PRIMARY KEY (pk);


--
-- Name: lu_whisper_test_pkey; Type: CONSTRAINT; Schema: common; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_whisper_test
    ADD CONSTRAINT lu_whisper_test_pkey PRIMARY KEY (pk);


SET search_path = contacts, pg_catalog;

--
-- Name: data_addresses_pkey; Type: CONSTRAINT; Schema: contacts; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY data_addresses
    ADD CONSTRAINT data_addresses_pkey PRIMARY KEY (pk);


--
-- Name: data_branches_pkey; Type: CONSTRAINT; Schema: contacts; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY data_branches
    ADD CONSTRAINT data_branches_pkey PRIMARY KEY (pk);


--
-- Name: data_communications_pkey; Type: CONSTRAINT; Schema: contacts; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY data_communications
    ADD CONSTRAINT data_communications_pkey PRIMARY KEY (pk);


--
-- Name: data_employees_pkey; Type: CONSTRAINT; Schema: contacts; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY data_employees
    ADD CONSTRAINT data_employees_pkey PRIMARY KEY (pk);


--
-- Name: data_numbers_pkey; Type: CONSTRAINT; Schema: contacts; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY data_numbers
    ADD CONSTRAINT data_numbers_pkey PRIMARY KEY (pk);


--
-- Name: data_organisations_pkey; Type: CONSTRAINT; Schema: contacts; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY data_organisations
    ADD CONSTRAINT data_organisations_pkey PRIMARY KEY (pk);


--
-- Name: data_persons_pkey; Type: CONSTRAINT; Schema: contacts; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY data_persons
    ADD CONSTRAINT data_persons_pkey PRIMARY KEY (pk);


--
-- Name: images_pkey; Type: CONSTRAINT; Schema: contacts; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY images
    ADD CONSTRAINT images_pkey PRIMARY KEY (pk);


--
-- Name: links_branches_comms_pkey; Type: CONSTRAINT; Schema: contacts; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY links_branches_comms
    ADD CONSTRAINT links_branches_comms_pkey PRIMARY KEY (pk);


--
-- Name: links_employees_comms_pkey; Type: CONSTRAINT; Schema: contacts; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY links_employees_comms
    ADD CONSTRAINT links_employees_comms_pkey PRIMARY KEY (pk);


--
-- Name: links_persons_addresses_pkey; Type: CONSTRAINT; Schema: contacts; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY links_persons_addresses
    ADD CONSTRAINT links_persons_addresses_pkey PRIMARY KEY (pk);


--
-- Name: links_persons_comms_pkey; Type: CONSTRAINT; Schema: contacts; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY links_persons_comms
    ADD CONSTRAINT links_persons_comms_pkey PRIMARY KEY (pk);


--
-- Name: lu_address_types_pkey; Type: CONSTRAINT; Schema: contacts; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_address_types
    ADD CONSTRAINT lu_address_types_pkey PRIMARY KEY (pk);


--
-- Name: lu_categories_pkey; Type: CONSTRAINT; Schema: contacts; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_categories
    ADD CONSTRAINT lu_categories_pkey PRIMARY KEY (pk);


--
-- Name: lu_contact_type_pkey; Type: CONSTRAINT; Schema: contacts; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_contact_type
    ADD CONSTRAINT lu_contact_type_pkey PRIMARY KEY (pk);


--
-- Name: lu_employee_status_pkey; Type: CONSTRAINT; Schema: contacts; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_employee_status
    ADD CONSTRAINT lu_employee_status_pkey PRIMARY KEY (pk);


--
-- Name: lu_firstnames_pkey; Type: CONSTRAINT; Schema: contacts; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_firstnames
    ADD CONSTRAINT lu_firstnames_pkey PRIMARY KEY (pk);


--
-- Name: lu_marital_pkey; Type: CONSTRAINT; Schema: contacts; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_marital
    ADD CONSTRAINT lu_marital_pkey PRIMARY KEY (pk);


--
-- Name: lu_mismatched_towns_pkey; Type: CONSTRAINT; Schema: contacts; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_misspelt_towns
    ADD CONSTRAINT lu_mismatched_towns_pkey PRIMARY KEY (pk);


--
-- Name: lu_sex_pkey; Type: CONSTRAINT; Schema: contacts; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_sex
    ADD CONSTRAINT lu_sex_pkey PRIMARY KEY (pk);


--
-- Name: lu_surnames_pkey; Type: CONSTRAINT; Schema: contacts; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_surnames
    ADD CONSTRAINT lu_surnames_pkey PRIMARY KEY (pk);


--
-- Name: lu_title_pkey; Type: CONSTRAINT; Schema: contacts; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_title
    ADD CONSTRAINT lu_title_pkey PRIMARY KEY (pk);


--
-- Name: lu_towns_pkey; Type: CONSTRAINT; Schema: contacts; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_towns
    ADD CONSTRAINT lu_towns_pkey PRIMARY KEY (pk);


SET search_path = db, pg_catalog;

--
-- Name: db_version_pkey; Type: CONSTRAINT; Schema: db; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_version
    ADD CONSTRAINT db_version_pkey PRIMARY KEY (pk);


SET search_path = defaults, pg_catalog;

--
-- Name: hl7_message_destination_pkey; Type: CONSTRAINT; Schema: defaults; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY hl7_inboxes
    ADD CONSTRAINT hl7_message_destination_pkey PRIMARY KEY (pk);


--
-- Name: incoming_message_handling_pkey; Type: CONSTRAINT; Schema: defaults; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY incoming_message_handling
    ADD CONSTRAINT incoming_message_handling_pkey PRIMARY KEY (pk);


--
-- Name: lu_link_printer_task_pkey; Type: CONSTRAINT; Schema: defaults; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_link_printer_task
    ADD CONSTRAINT lu_link_printer_task_pkey PRIMARY KEY (pk);


--
-- Name: lu_message_display_style_pkey; Type: CONSTRAINT; Schema: defaults; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_message_display_style
    ADD CONSTRAINT lu_message_display_style_pkey PRIMARY KEY (pk);


--
-- Name: lu_message_standard_pkey; Type: CONSTRAINT; Schema: defaults; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_message_standard
    ADD CONSTRAINT lu_message_standard_pkey PRIMARY KEY (pk);


--
-- Name: lu_printer_host_pkey; Type: CONSTRAINT; Schema: defaults; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_printer_host
    ADD CONSTRAINT lu_printer_host_pkey PRIMARY KEY (pk);


--
-- Name: lu_printer_task_pkey; Type: CONSTRAINT; Schema: defaults; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_printer_task
    ADD CONSTRAINT lu_printer_task_pkey PRIMARY KEY (pk);


--
-- Name: script_coordinates_pkey; Type: CONSTRAINT; Schema: defaults; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY script_coordinates
    ADD CONSTRAINT script_coordinates_pkey PRIMARY KEY (pk);


--
-- Name: temp_pkey; Type: CONSTRAINT; Schema: defaults; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY temp
    ADD CONSTRAINT temp_pkey PRIMARY KEY (pk);


SET search_path = documents, pg_catalog;

--
-- Name: documents_pkey; Type: CONSTRAINT; Schema: documents; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (pk);


--
-- Name: lu_archive_site_pkey; Type: CONSTRAINT; Schema: documents; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_archive_site
    ADD CONSTRAINT lu_archive_site_pkey PRIMARY KEY (pk);


--
-- Name: lu_display_as_pkey; Type: CONSTRAINT; Schema: documents; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_display_as
    ADD CONSTRAINT lu_display_as_pkey PRIMARY KEY (pk);


--
-- Name: lu_message_display_style_pkey; Type: CONSTRAINT; Schema: documents; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_message_display_style
    ADD CONSTRAINT lu_message_display_style_pkey PRIMARY KEY (pk);


--
-- Name: lu_message_standard_pkey; Type: CONSTRAINT; Schema: documents; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_message_standard
    ADD CONSTRAINT lu_message_standard_pkey PRIMARY KEY (pk);


--
-- Name: observations_pkey; Type: CONSTRAINT; Schema: documents; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY observations
    ADD CONSTRAINT observations_pkey PRIMARY KEY (pk);


--
-- Name: sending_entities_pkey; Type: CONSTRAINT; Schema: documents; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY sending_entities
    ADD CONSTRAINT sending_entities_pkey PRIMARY KEY (pk);


--
-- Name: signed_off_pkey; Type: CONSTRAINT; Schema: documents; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY signed_off
    ADD CONSTRAINT signed_off_pkey PRIMARY KEY (pk);


--
-- Name: unmatched_patients_pkey; Type: CONSTRAINT; Schema: documents; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY unmatched_patients
    ADD CONSTRAINT unmatched_patients_pkey PRIMARY KEY (pk);


--
-- Name: unmatched_staff_pkey; Type: CONSTRAINT; Schema: documents; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY unmatched_staff
    ADD CONSTRAINT unmatched_staff_pkey PRIMARY KEY (pk);


SET search_path = drugs, pg_catalog;

--
-- Name: atc_pkey; Type: CONSTRAINT; Schema: drugs; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY atc
    ADD CONSTRAINT atc_pkey PRIMARY KEY (atccode);


--
-- Name: brand_pkey; Type: CONSTRAINT; Schema: drugs; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY brand
    ADD CONSTRAINT brand_pkey PRIMARY KEY (pk);


--
-- Name: chapters_pkey; Type: CONSTRAINT; Schema: drugs; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY chapters
    ADD CONSTRAINT chapters_pkey PRIMARY KEY (chapter);


--
-- Name: clinical_effects_effect_key; Type: CONSTRAINT; Schema: drugs; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY clinical_effects
    ADD CONSTRAINT clinical_effects_effect_key UNIQUE (effect);


--
-- Name: clinical_effects_pkey; Type: CONSTRAINT; Schema: drugs; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY clinical_effects
    ADD CONSTRAINT clinical_effects_pkey PRIMARY KEY (pk);


--
-- Name: company_code_key; Type: CONSTRAINT; Schema: drugs; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY company
    ADD CONSTRAINT company_code_key UNIQUE (code);


--
-- Name: company_pkey; Type: CONSTRAINT; Schema: drugs; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY company
    ADD CONSTRAINT company_pkey PRIMARY KEY (code);


--
-- Name: evidence_levels_pkey; Type: CONSTRAINT; Schema: drugs; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY evidence_levels
    ADD CONSTRAINT evidence_levels_pkey PRIMARY KEY (pk);


--
-- Name: flags_pk_key; Type: CONSTRAINT; Schema: drugs; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY flags
    ADD CONSTRAINT flags_pk_key UNIQUE (pk);


--
-- Name: flags_pkey; Type: CONSTRAINT; Schema: drugs; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY flags
    ADD CONSTRAINT flags_pkey PRIMARY KEY (pk);


--
-- Name: form_pkey; Type: CONSTRAINT; Schema: drugs; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY form
    ADD CONSTRAINT form_pkey PRIMARY KEY (pk);


--
-- Name: info_pkey; Type: CONSTRAINT; Schema: drugs; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY info
    ADD CONSTRAINT info_pkey PRIMARY KEY (pk);


--
-- Name: patient_categories_pkey; Type: CONSTRAINT; Schema: drugs; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY patient_categories
    ADD CONSTRAINT patient_categories_pkey PRIMARY KEY (pk);


--
-- Name: pbs_pbscode_key; Type: CONSTRAINT; Schema: drugs; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY pbs
    ADD CONSTRAINT pbs_pbscode_key UNIQUE (pbscode);


--
-- Name: pharmacologic_mechanisms_pkey; Type: CONSTRAINT; Schema: drugs; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY pharmacologic_mechanisms
    ADD CONSTRAINT pharmacologic_mechanisms_pkey PRIMARY KEY (pk);


--
-- Name: product_pkey; Type: CONSTRAINT; Schema: drugs; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY product
    ADD CONSTRAINT product_pkey PRIMARY KEY (pk);


--
-- Name: schedules_schedule_key; Type: CONSTRAINT; Schema: drugs; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY schedules
    ADD CONSTRAINT schedules_schedule_key UNIQUE (pk);


--
-- Name: severity_level_pkey; Type: CONSTRAINT; Schema: drugs; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY severity_level
    ADD CONSTRAINT severity_level_pkey PRIMARY KEY (pk);


--
-- Name: sources_pkey; Type: CONSTRAINT; Schema: drugs; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY sources
    ADD CONSTRAINT sources_pkey PRIMARY KEY (pk);


--
-- Name: topic_pkey; Type: CONSTRAINT; Schema: drugs; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY topic
    ADD CONSTRAINT topic_pkey PRIMARY KEY (pk);


SET search_path = import_export, pg_catalog;

--
-- Name: lu_demographics_field_templates_pkey; Type: CONSTRAINT; Schema: import_export; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_demographics_field_templates
    ADD CONSTRAINT lu_demographics_field_templates_pkey PRIMARY KEY (pk);


--
-- Name: lu_misspelt_user_request_tags_pkey; Type: CONSTRAINT; Schema: import_export; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_misspelt_user_request_tags
    ADD CONSTRAINT lu_misspelt_user_request_tags_pkey PRIMARY KEY (pk);


--
-- Name: lu_source_program_pkey; Type: CONSTRAINT; Schema: import_export; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_source_program
    ADD CONSTRAINT lu_source_program_pkey PRIMARY KEY (pk);


SET search_path = public, pg_catalog;

--
-- Name: inventory_items_lent_pkey; Type: CONSTRAINT; Schema: public; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY inventory_items_lent
    ADD CONSTRAINT inventory_items_lent_pkey PRIMARY KEY (pk);


--
-- Name: pk_uniq; Type: CONSTRAINT; Schema: public; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY web
    ADD CONSTRAINT pk_uniq UNIQUE (pk);


SET search_path = blobs, pg_catalog;

--
-- Name: images_md5_idx; Type: INDEX; Schema: blobs; Owner: easygp; Tablespace: 
--

CREATE INDEX images_md5_idx ON images USING btree (md5sum);


SET search_path = clin_prescribing, pg_catalog;

--
-- Name: instructions_idx; Type: INDEX; Schema: clin_prescribing; Owner: easygp; Tablespace: 
--

CREATE INDEX instructions_idx ON instructions USING btree (instruction);


--
-- Name: prescribed_for_idx; Type: INDEX; Schema: clin_prescribing; Owner: easygp; Tablespace: 
--

CREATE INDEX prescribed_for_idx ON prescribed_for USING btree (prescribed_for);


SET search_path = clin_recalls, pg_catalog;

--
-- Name: date_recall_due_idx; Type: INDEX; Schema: clin_recalls; Owner: easygp; Tablespace: 
--

CREATE INDEX date_recall_due_idx ON recalls USING btree (due);


SET search_path = contacts, pg_catalog;

--
-- Name: data_persons_firstname_surname_idx; Type: INDEX; Schema: contacts; Owner: easygp; Tablespace: 
--

CREATE INDEX data_persons_firstname_surname_idx ON data_persons USING btree (firstname, surname);


SET search_path = documents, pg_catalog;

--
-- Name: date_created_idx; Type: INDEX; Schema: documents; Owner: easygp; Tablespace: 
--

CREATE INDEX date_created_idx ON documents USING btree (date_created);


--
-- Name: date_created_not_deleted_index; Type: INDEX; Schema: documents; Owner: easygp; Tablespace: 
--

CREATE INDEX date_created_not_deleted_index ON documents USING btree (deleted, date_created);


--
-- Name: documents__concluded_deleted_idx; Type: INDEX; Schema: documents; Owner: easygp; Tablespace: 
--

CREATE INDEX documents__concluded_deleted_idx ON documents USING btree (concluded, deleted) WHERE false;


--
-- Name: documents_concluded_idx; Type: INDEX; Schema: documents; Owner: easygp; Tablespace: 
--

CREATE INDEX documents_concluded_idx ON documents USING btree (concluded);


--
-- Name: documents_deleted_idx; Type: INDEX; Schema: documents; Owner: easygp; Tablespace: 
--

CREATE INDEX documents_deleted_idx ON documents USING btree (deleted);


--
-- Name: sending_entities_provider_type_index; Type: INDEX; Schema: documents; Owner: easygp; Tablespace: 
--

CREATE INDEX sending_entities_provider_type_index ON sending_entities USING btree (fk_lu_request_type);


--
-- Name: sending_entity_idx; Type: INDEX; Schema: documents; Owner: easygp; Tablespace: 
--

CREATE INDEX sending_entity_idx ON documents USING btree (fk_sending_entity);


--
-- Name: staff_destination_idx; Type: INDEX; Schema: documents; Owner: easygp; Tablespace: 
--

CREATE INDEX staff_destination_idx ON documents USING btree (fk_staff_destination);


--
-- Name: tag_idx; Type: INDEX; Schema: documents; Owner: easygp; Tablespace: 
--

CREATE INDEX tag_idx ON documents USING btree (tag);


SET search_path = billing, pg_catalog;

--
-- Name: update_invoice_bill_trig; Type: TRIGGER; Schema: billing; Owner: easygp
--

CREATE TRIGGER update_invoice_bill_trig AFTER INSERT OR DELETE OR UPDATE ON items_billed FOR EACH ROW EXECUTE PROCEDURE update_invoice_bill();


--
-- Name: update_invoice_payment_trig; Type: TRIGGER; Schema: billing; Owner: easygp
--

CREATE TRIGGER update_invoice_payment_trig AFTER INSERT OR DELETE OR UPDATE ON payments_received FOR EACH ROW EXECUTE PROCEDURE update_invoice_payment();


SET search_path = clerical, pg_catalog;

--
-- Name: notify_booking; Type: TRIGGER; Schema: clerical; Owner: easygp
--

CREATE TRIGGER notify_booking BEFORE INSERT OR UPDATE ON bookings FOR EACH ROW EXECUTE PROCEDURE notify_booking();


--
-- Name: tell_remote_server; Type: TRIGGER; Schema: clerical; Owner: easygp
--

CREATE TRIGGER tell_remote_server BEFORE INSERT OR UPDATE ON bookings FOR EACH ROW WHEN ((NOT (new.notes ~~* '%internet%'::text))) EXECUTE PROCEDURE tell_remote_server1();


--
-- Name: bookings_booked_by_fkey; Type: FK CONSTRAINT; Schema: clerical; Owner: easygp
--

ALTER TABLE ONLY bookings
    ADD CONSTRAINT bookings_booked_by_fkey FOREIGN KEY (fk_staff_booked) REFERENCES admin.staff(pk);


--
-- Name: bookings_fk_patient_fkey; Type: FK CONSTRAINT; Schema: clerical; Owner: easygp
--

ALTER TABLE ONLY bookings
    ADD CONSTRAINT bookings_fk_patient_fkey FOREIGN KEY (fk_patient) REFERENCES data_patients(pk);


--
-- Name: bookings_fk_staff_fkey; Type: FK CONSTRAINT; Schema: clerical; Owner: easygp
--

ALTER TABLE ONLY bookings
    ADD CONSTRAINT bookings_fk_staff_fkey FOREIGN KEY (fk_staff) REFERENCES admin.staff(pk);


--
-- Name: data_patients_fk_family_fkey; Type: FK CONSTRAINT; Schema: clerical; Owner: easygp
--

ALTER TABLE ONLY data_patients
    ADD CONSTRAINT data_patients_fk_family_fkey FOREIGN KEY (fk_family) REFERENCES data_families(pk);


--
-- Name: data_patients_fk_lu_aboriginality_fkey; Type: FK CONSTRAINT; Schema: clerical; Owner: easygp
--

ALTER TABLE ONLY data_patients
    ADD CONSTRAINT data_patients_fk_lu_aboriginality_fkey FOREIGN KEY (fk_lu_aboriginality) REFERENCES common.lu_aboriginality(pk);


--
-- Name: data_patients_fk_lu_active_status_fkey; Type: FK CONSTRAINT; Schema: clerical; Owner: easygp
--

ALTER TABLE ONLY data_patients
    ADD CONSTRAINT data_patients_fk_lu_active_status_fkey FOREIGN KEY (fk_lu_active_status) REFERENCES lu_active_status(pk);


--
-- Name: data_patients_fk_lu_centrelink_card_type_fkey; Type: FK CONSTRAINT; Schema: clerical; Owner: easygp
--

ALTER TABLE ONLY data_patients
    ADD CONSTRAINT data_patients_fk_lu_centrelink_card_type_fkey FOREIGN KEY (fk_lu_centrelink_card_type) REFERENCES lu_centrelink_card_type(pk);


--
-- Name: data_patients_fk_lu_veteran_card_type_fkey; Type: FK CONSTRAINT; Schema: clerical; Owner: easygp
--

ALTER TABLE ONLY data_patients
    ADD CONSTRAINT data_patients_fk_lu_veteran_card_type_fkey FOREIGN KEY (fk_lu_veteran_card_type) REFERENCES lu_veteran_card_type(pk);


--
-- Name: inventory_fk_inventory_item_fkey; Type: FK CONSTRAINT; Schema: clerical; Owner: easygp
--

ALTER TABLE ONLY inventory
    ADD CONSTRAINT inventory_fk_inventory_item_fkey FOREIGN KEY (fk_lu_inventory_item) REFERENCES lu_inventory_items(pk);


--
-- Name: inventory_fk_inventory_location_fkey; Type: FK CONSTRAINT; Schema: clerical; Owner: easygp
--

ALTER TABLE ONLY inventory
    ADD CONSTRAINT inventory_fk_inventory_location_fkey FOREIGN KEY (fk_inventory_location) REFERENCES inventory_locations(pk);


--
-- Name: inventory_lent_fk_inventory_fkey; Type: FK CONSTRAINT; Schema: clerical; Owner: easygp
--

ALTER TABLE ONLY inventory_lent
    ADD CONSTRAINT inventory_lent_fk_inventory_fkey FOREIGN KEY (fk_inventory) REFERENCES inventory(pk);


--
-- Name: inventory_lent_fk_patient_fkey; Type: FK CONSTRAINT; Schema: clerical; Owner: easygp
--

ALTER TABLE ONLY inventory_lent
    ADD CONSTRAINT inventory_lent_fk_patient_fkey FOREIGN KEY (fk_patient) REFERENCES data_patients(pk);


--
-- Name: inventory_lent_fk_staff_fkey; Type: FK CONSTRAINT; Schema: clerical; Owner: easygp
--

ALTER TABLE ONLY inventory_lent
    ADD CONSTRAINT inventory_lent_fk_staff_fkey FOREIGN KEY (fk_staff) REFERENCES admin.staff(pk);


--
-- Name: inventory_locations_fk_clinic_fkey; Type: FK CONSTRAINT; Schema: clerical; Owner: easygp
--

ALTER TABLE ONLY inventory_locations
    ADD CONSTRAINT inventory_locations_fk_clinic_fkey FOREIGN KEY (fk_clinic) REFERENCES admin.clinics(pk);


--
-- Name: sessions_fk_clinic_fkey; Type: FK CONSTRAINT; Schema: clerical; Owner: easygp
--

ALTER TABLE ONLY sessions
    ADD CONSTRAINT sessions_fk_clinic_fkey FOREIGN KEY (fk_clinic) REFERENCES admin.clinics(pk);


--
-- Name: sessions_fk_staff_fkey; Type: FK CONSTRAINT; Schema: clerical; Owner: easygp
--

ALTER TABLE ONLY sessions
    ADD CONSTRAINT sessions_fk_staff_fkey FOREIGN KEY (fk_staff) REFERENCES admin.staff(pk);


SET search_path = clin_allergies, pg_catalog;

--
-- Name: allergies_fk_brand_fkey; Type: FK CONSTRAINT; Schema: clin_allergies; Owner: easygp
--

ALTER TABLE ONLY allergies
    ADD CONSTRAINT allergies_fk_brand_fkey FOREIGN KEY (fk_brand) REFERENCES drugs.brand(pk);


--
-- Name: allergies_fk_consult_fkey; Type: FK CONSTRAINT; Schema: clin_allergies; Owner: easygp
--

ALTER TABLE ONLY allergies
    ADD CONSTRAINT allergies_fk_consult_fkey FOREIGN KEY (fk_consult) REFERENCES clin_consult.consult(pk);


--
-- Name: allergies_fk_lu_reaction_type_key; Type: FK CONSTRAINT; Schema: clin_allergies; Owner: easygp
--

ALTER TABLE ONLY allergies
    ADD CONSTRAINT allergies_fk_lu_reaction_type_key FOREIGN KEY (fk_lu_reaction_type) REFERENCES lu_reaction_type(pk);


--
-- Name: allergies_fk_product_fkey; Type: FK CONSTRAINT; Schema: clin_allergies; Owner: easygp
--

ALTER TABLE ONLY allergies
    ADD CONSTRAINT allergies_fk_product_fkey FOREIGN KEY (fk_product) REFERENCES drugs.product(pk);


--
-- Name: allergies_fk_progressnote_fkey; Type: FK CONSTRAINT; Schema: clin_allergies; Owner: easygp
--

ALTER TABLE ONLY allergies
    ADD CONSTRAINT allergies_fk_progressnote_fkey FOREIGN KEY (fk_progressnote) REFERENCES clin_consult.progressnotes(pk);


SET search_path = clin_consult, pg_catalog;

--
-- Name: action_action_ref; Type: FK CONSTRAINT; Schema: clin_consult; Owner: easygp
--

ALTER TABLE ONLY progressnotes
    ADD CONSTRAINT action_action_ref FOREIGN KEY (fk_audit_action) REFERENCES lu_audit_actions(pk);


--
-- Name: dictations_fk_progress_note_fkey; Type: FK CONSTRAINT; Schema: clin_consult; Owner: easygp
--

ALTER TABLE ONLY dictations
    ADD CONSTRAINT dictations_fk_progress_note_fkey FOREIGN KEY (fk_progress_note) REFERENCES progressnotes(pk);


--
-- Name: dictations_fk_referral_fkey; Type: FK CONSTRAINT; Schema: clin_consult; Owner: easygp
--

ALTER TABLE ONLY dictations
    ADD CONSTRAINT dictations_fk_referral_fkey FOREIGN KEY (fk_referral) REFERENCES clin_referrals.referrals(pk);


--
-- Name: dictations_fk_user_fkey; Type: FK CONSTRAINT; Schema: clin_consult; Owner: easygp
--

ALTER TABLE ONLY dictations
    ADD CONSTRAINT dictations_fk_user_fkey FOREIGN KEY (fk_user) REFERENCES admin.staff(pk);


--
-- Name: progressnotes_fk_audit_reason_fkey; Type: FK CONSTRAINT; Schema: clin_consult; Owner: easygp
--

ALTER TABLE ONLY progressnotes
    ADD CONSTRAINT progressnotes_fk_audit_reason_fkey FOREIGN KEY (fk_audit_reason) REFERENCES lu_audit_reasons(pk);


SET search_path = clin_history, pg_catalog;

--
-- Name: data_recreational_drugs_fk_consult; Type: FK CONSTRAINT; Schema: clin_history; Owner: easygp
--

ALTER TABLE ONLY recreational_drugs
    ADD CONSTRAINT data_recreational_drugs_fk_consult FOREIGN KEY (fk_consult) REFERENCES clin_consult.consult(pk);


--
-- Name: data_recreational_drugs_fk_lu_recreational_drug; Type: FK CONSTRAINT; Schema: clin_history; Owner: easygp
--

ALTER TABLE ONLY recreational_drugs
    ADD CONSTRAINT data_recreational_drugs_fk_lu_recreational_drug FOREIGN KEY (fk_lu_recreational_drug) REFERENCES common.lu_recreational_drugs(pk);


SET search_path = clin_prescribing, pg_catalog;

--
-- Name: prescribed_fk_lu_pbs_script_type_fkey; Type: FK CONSTRAINT; Schema: clin_prescribing; Owner: easygp
--

ALTER TABLE ONLY prescribed
    ADD CONSTRAINT prescribed_fk_lu_pbs_script_type_fkey FOREIGN KEY (fk_lu_pbs_script_type) REFERENCES lu_pbs_script_type(pk);


SET search_path = common, pg_catalog;

--
-- Name: common_lu_recreational_drugs_default_fk_lu_route_administration; Type: FK CONSTRAINT; Schema: common; Owner: easygp
--

ALTER TABLE ONLY lu_recreational_drugs
    ADD CONSTRAINT common_lu_recreational_drugs_default_fk_lu_route_administration FOREIGN KEY (default_fk_lu_route_administration) REFERENCES lu_route_administration(pk);


SET search_path = contacts, pg_catalog;

--
-- Name: data_numbers_fk_branch_fkey; Type: FK CONSTRAINT; Schema: contacts; Owner: easygp
--

ALTER TABLE ONLY data_numbers
    ADD CONSTRAINT data_numbers_fk_branch_fkey FOREIGN KEY (fk_branch) REFERENCES data_branches(pk);


--
-- Name: data_numbers_fk_person_fkey; Type: FK CONSTRAINT; Schema: contacts; Owner: easygp
--

ALTER TABLE ONLY data_numbers
    ADD CONSTRAINT data_numbers_fk_person_fkey FOREIGN KEY (fk_person) REFERENCES data_persons(pk);


--
-- Name: links_branches_comms_fk_branch_fkey; Type: FK CONSTRAINT; Schema: contacts; Owner: easygp
--

ALTER TABLE ONLY links_branches_comms
    ADD CONSTRAINT links_branches_comms_fk_branch_fkey FOREIGN KEY (fk_branch) REFERENCES data_branches(pk);


--
-- Name: links_branches_comms_fk_comm_fkey; Type: FK CONSTRAINT; Schema: contacts; Owner: easygp
--

ALTER TABLE ONLY links_branches_comms
    ADD CONSTRAINT links_branches_comms_fk_comm_fkey FOREIGN KEY (fk_comm) REFERENCES data_communications(pk);


SET search_path = defaults, pg_catalog;

--
-- Name: incoming_message_handling_fk_lu_provider_type_fkey; Type: FK CONSTRAINT; Schema: defaults; Owner: easygp
--

ALTER TABLE ONLY incoming_message_handling
    ADD CONSTRAINT incoming_message_handling_fk_lu_provider_type_fkey FOREIGN KEY (fk_lu_provider_type) REFERENCES contacts.lu_categories(pk);


SET search_path = documents, pg_catalog;

--
-- Name: unmatched_patients_fk_real_patient_fkey; Type: FK CONSTRAINT; Schema: documents; Owner: easygp
--

ALTER TABLE ONLY unmatched_patients
    ADD CONSTRAINT unmatched_patients_fk_real_patient_fkey FOREIGN KEY (fk_real_patient) REFERENCES clerical.data_patients(pk);


--
-- Name: unmatched_staff_fk_real_staff_fkey; Type: FK CONSTRAINT; Schema: documents; Owner: easygp
--

ALTER TABLE ONLY unmatched_staff
    ADD CONSTRAINT unmatched_staff_fk_real_staff_fkey FOREIGN KEY (fk_real_staff) REFERENCES admin.staff(pk);


SET search_path = drugs, pg_catalog;

--
-- Name: brand_fk_product_fkey; Type: FK CONSTRAINT; Schema: drugs; Owner: easygp
--

ALTER TABLE ONLY brand
    ADD CONSTRAINT brand_fk_product_fkey FOREIGN KEY (fk_product) REFERENCES product(pk);


--
-- Name: clinical_effects_fk_severity_fkey; Type: FK CONSTRAINT; Schema: drugs; Owner: easygp
--

ALTER TABLE ONLY clinical_effects
    ADD CONSTRAINT clinical_effects_fk_severity_fkey FOREIGN KEY (fk_severity) REFERENCES severity_level(pk);


--
-- Name: info_fk_clinical_effect_fkey; Type: FK CONSTRAINT; Schema: drugs; Owner: easygp
--

ALTER TABLE ONLY info
    ADD CONSTRAINT info_fk_clinical_effect_fkey FOREIGN KEY (fk_clinical_effect) REFERENCES clinical_effects(pk);


--
-- Name: info_fk_evidence_level_fkey; Type: FK CONSTRAINT; Schema: drugs; Owner: easygp
--

ALTER TABLE ONLY info
    ADD CONSTRAINT info_fk_evidence_level_fkey FOREIGN KEY (fk_evidence_level) REFERENCES evidence_levels(pk);


--
-- Name: info_fk_patient_category_fkey; Type: FK CONSTRAINT; Schema: drugs; Owner: easygp
--

ALTER TABLE ONLY info
    ADD CONSTRAINT info_fk_patient_category_fkey FOREIGN KEY (fk_patient_category) REFERENCES patient_categories(pk);


--
-- Name: info_fk_pharmacologic_mechanism_fkey; Type: FK CONSTRAINT; Schema: drugs; Owner: easygp
--

ALTER TABLE ONLY info
    ADD CONSTRAINT info_fk_pharmacologic_mechanism_fkey FOREIGN KEY (fk_pharmacologic_mechanism) REFERENCES pharmacologic_mechanisms(pk);


--
-- Name: info_fk_severity_fkey; Type: FK CONSTRAINT; Schema: drugs; Owner: easygp
--

ALTER TABLE ONLY info
    ADD CONSTRAINT info_fk_severity_fkey FOREIGN KEY (fk_severity) REFERENCES severity_level(pk);


--
-- Name: info_fk_topic_fkey; Type: FK CONSTRAINT; Schema: drugs; Owner: easygp
--

ALTER TABLE ONLY info
    ADD CONSTRAINT info_fk_topic_fkey FOREIGN KEY (fk_topic) REFERENCES topic(pk);


--
-- Name: link_atc_info_atccode_fkey; Type: FK CONSTRAINT; Schema: drugs; Owner: easygp
--

ALTER TABLE ONLY link_atc_info
    ADD CONSTRAINT link_atc_info_atccode_fkey FOREIGN KEY (atccode) REFERENCES atc(atccode);


--
-- Name: link_atc_info_fk_info_fkey; Type: FK CONSTRAINT; Schema: drugs; Owner: easygp
--

ALTER TABLE ONLY link_atc_info
    ADD CONSTRAINT link_atc_info_fk_info_fkey FOREIGN KEY (fk_info) REFERENCES info(pk);


--
-- Name: link_category_info_fk_category_fkey; Type: FK CONSTRAINT; Schema: drugs; Owner: easygp
--

ALTER TABLE ONLY link_category_info
    ADD CONSTRAINT link_category_info_fk_category_fkey FOREIGN KEY (fk_category) REFERENCES patient_categories(pk);


--
-- Name: link_category_info_fk_info_fkey; Type: FK CONSTRAINT; Schema: drugs; Owner: easygp
--

ALTER TABLE ONLY link_category_info
    ADD CONSTRAINT link_category_info_fk_info_fkey FOREIGN KEY (fk_info) REFERENCES info(pk);


--
-- Name: link_flag_product_fk_flag_fkey; Type: FK CONSTRAINT; Schema: drugs; Owner: easygp
--

ALTER TABLE ONLY link_flag_product
    ADD CONSTRAINT link_flag_product_fk_flag_fkey FOREIGN KEY (fk_flag) REFERENCES flags(pk);


--
-- Name: link_flag_product_fk_product_fkey; Type: FK CONSTRAINT; Schema: drugs; Owner: easygp
--

ALTER TABLE ONLY link_flag_product
    ADD CONSTRAINT link_flag_product_fk_product_fkey FOREIGN KEY (fk_product) REFERENCES product(pk);


--
-- Name: link_info_source_fk_info_fkey; Type: FK CONSTRAINT; Schema: drugs; Owner: easygp
--

ALTER TABLE ONLY link_info_source
    ADD CONSTRAINT link_info_source_fk_info_fkey FOREIGN KEY (fk_info) REFERENCES info(pk);


--
-- Name: link_info_source_fk_source_fkey; Type: FK CONSTRAINT; Schema: drugs; Owner: easygp
--

ALTER TABLE ONLY link_info_source
    ADD CONSTRAINT link_info_source_fk_source_fkey FOREIGN KEY (fk_source) REFERENCES sources(pk);


--
-- Name: pbs_chapter_fkey; Type: FK CONSTRAINT; Schema: drugs; Owner: easygp
--

ALTER TABLE ONLY pbs
    ADD CONSTRAINT pbs_chapter_fkey FOREIGN KEY (chapter) REFERENCES chapters(chapter);


--
-- Name: pbs_fk_product_fkey; Type: FK CONSTRAINT; Schema: drugs; Owner: easygp
--

ALTER TABLE ONLY pbs
    ADD CONSTRAINT pbs_fk_product_fkey FOREIGN KEY (fk_product) REFERENCES product(pk);


--
-- Name: product_fk_form_fkey; Type: FK CONSTRAINT; Schema: drugs; Owner: easygp
--

ALTER TABLE ONLY product
    ADD CONSTRAINT product_fk_form_fkey FOREIGN KEY (fk_form) REFERENCES form(pk);


--
-- Name: product_fk_schedule_fkey; Type: FK CONSTRAINT; Schema: drugs; Owner: easygp
--

ALTER TABLE ONLY product
    ADD CONSTRAINT product_fk_schedule_fkey FOREIGN KEY (fk_schedule) REFERENCES schedules(pk);


--
-- Name: restriction_pbscode_fkey; Type: FK CONSTRAINT; Schema: drugs; Owner: easygp
--

ALTER TABLE ONLY restriction
    ADD CONSTRAINT restriction_pbscode_fkey FOREIGN KEY (pbscode) REFERENCES pbs(pbscode);


SET search_path = public, pg_catalog;

--
-- Name: inventory_items_lent_fk_clinic_fkey; Type: FK CONSTRAINT; Schema: public; Owner: easygp
--

ALTER TABLE ONLY inventory_items_lent
    ADD CONSTRAINT inventory_items_lent_fk_clinic_fkey FOREIGN KEY (fk_clinic) REFERENCES admin.clinics(pk);


--
-- Name: inventory_items_lent_fk_patient_fkey; Type: FK CONSTRAINT; Schema: public; Owner: easygp
--

ALTER TABLE ONLY inventory_items_lent
    ADD CONSTRAINT inventory_items_lent_fk_patient_fkey FOREIGN KEY (fk_patient) REFERENCES clerical.data_patients(pk);


--
-- Name: inventory_items_lent_fk_staff_fkey; Type: FK CONSTRAINT; Schema: public; Owner: easygp
--

ALTER TABLE ONLY inventory_items_lent
    ADD CONSTRAINT inventory_items_lent_fk_staff_fkey FOREIGN KEY (fk_staff) REFERENCES admin.staff(pk);


--
-- Name: admin; Type: ACL; Schema: -; Owner: easygp
--

REVOKE ALL ON SCHEMA admin FROM PUBLIC;
REVOKE ALL ON SCHEMA admin FROM easygp;
GRANT ALL ON SCHEMA admin TO easygp;


--
-- Name: billing; Type: ACL; Schema: -; Owner: easygp
--

REVOKE ALL ON SCHEMA billing FROM PUBLIC;
REVOKE ALL ON SCHEMA billing FROM easygp;
GRANT ALL ON SCHEMA billing TO easygp;


--
-- Name: blobs; Type: ACL; Schema: -; Owner: easygp
--

REVOKE ALL ON SCHEMA blobs FROM PUBLIC;
REVOKE ALL ON SCHEMA blobs FROM easygp;
GRANT ALL ON SCHEMA blobs TO easygp;


--
-- Name: clerical; Type: ACL; Schema: -; Owner: easygp
--

REVOKE ALL ON SCHEMA clerical FROM PUBLIC;
REVOKE ALL ON SCHEMA clerical FROM easygp;
GRANT ALL ON SCHEMA clerical TO easygp;


--
-- Name: clin_allergies; Type: ACL; Schema: -; Owner: easygp
--

REVOKE ALL ON SCHEMA clin_allergies FROM PUBLIC;
REVOKE ALL ON SCHEMA clin_allergies FROM easygp;
GRANT ALL ON SCHEMA clin_allergies TO easygp;


--
-- Name: clin_careplans; Type: ACL; Schema: -; Owner: easygp
--

REVOKE ALL ON SCHEMA clin_careplans FROM PUBLIC;
REVOKE ALL ON SCHEMA clin_careplans FROM easygp;
GRANT ALL ON SCHEMA clin_careplans TO easygp;


--
-- Name: clin_certificates; Type: ACL; Schema: -; Owner: easygp
--

REVOKE ALL ON SCHEMA clin_certificates FROM PUBLIC;
REVOKE ALL ON SCHEMA clin_certificates FROM easygp;
GRANT ALL ON SCHEMA clin_certificates TO easygp;


--
-- Name: clin_checkups; Type: ACL; Schema: -; Owner: easygp
--

REVOKE ALL ON SCHEMA clin_checkups FROM PUBLIC;
REVOKE ALL ON SCHEMA clin_checkups FROM easygp;
GRANT ALL ON SCHEMA clin_checkups TO easygp;


--
-- Name: clin_consult; Type: ACL; Schema: -; Owner: easygp
--

REVOKE ALL ON SCHEMA clin_consult FROM PUBLIC;
REVOKE ALL ON SCHEMA clin_consult FROM easygp;
GRANT ALL ON SCHEMA clin_consult TO easygp;


--
-- Name: clin_history; Type: ACL; Schema: -; Owner: easygp
--

REVOKE ALL ON SCHEMA clin_history FROM PUBLIC;
REVOKE ALL ON SCHEMA clin_history FROM easygp;
GRANT ALL ON SCHEMA clin_history TO easygp;


--
-- Name: clin_measurements; Type: ACL; Schema: -; Owner: easygp
--

REVOKE ALL ON SCHEMA clin_measurements FROM PUBLIC;
REVOKE ALL ON SCHEMA clin_measurements FROM easygp;
GRANT ALL ON SCHEMA clin_measurements TO easygp;


--
-- Name: clin_prescribing; Type: ACL; Schema: -; Owner: easygp
--

REVOKE ALL ON SCHEMA clin_prescribing FROM PUBLIC;
REVOKE ALL ON SCHEMA clin_prescribing FROM easygp;
GRANT ALL ON SCHEMA clin_prescribing TO easygp;
GRANT USAGE ON SCHEMA clin_prescribing TO ian;


--
-- Name: clin_procedures; Type: ACL; Schema: -; Owner: easygp
--

REVOKE ALL ON SCHEMA clin_procedures FROM PUBLIC;
REVOKE ALL ON SCHEMA clin_procedures FROM easygp;
GRANT ALL ON SCHEMA clin_procedures TO easygp;


--
-- Name: clin_recalls; Type: ACL; Schema: -; Owner: easygp
--

REVOKE ALL ON SCHEMA clin_recalls FROM PUBLIC;
REVOKE ALL ON SCHEMA clin_recalls FROM easygp;
GRANT ALL ON SCHEMA clin_recalls TO easygp;


--
-- Name: clin_referrals; Type: ACL; Schema: -; Owner: easygp
--

REVOKE ALL ON SCHEMA clin_referrals FROM PUBLIC;
REVOKE ALL ON SCHEMA clin_referrals FROM easygp;
GRANT ALL ON SCHEMA clin_referrals TO easygp;


--
-- Name: clin_requests; Type: ACL; Schema: -; Owner: easygp
--

REVOKE ALL ON SCHEMA clin_requests FROM PUBLIC;
REVOKE ALL ON SCHEMA clin_requests FROM easygp;
GRANT ALL ON SCHEMA clin_requests TO easygp;


--
-- Name: clin_vaccination; Type: ACL; Schema: -; Owner: easygp
--

REVOKE ALL ON SCHEMA clin_vaccination FROM PUBLIC;
REVOKE ALL ON SCHEMA clin_vaccination FROM easygp;
GRANT ALL ON SCHEMA clin_vaccination TO easygp;


--
-- Name: clin_workcover; Type: ACL; Schema: -; Owner: easygp
--

REVOKE ALL ON SCHEMA clin_workcover FROM PUBLIC;
REVOKE ALL ON SCHEMA clin_workcover FROM easygp;
GRANT ALL ON SCHEMA clin_workcover TO easygp;


--
-- Name: coding; Type: ACL; Schema: -; Owner: easygp
--

REVOKE ALL ON SCHEMA coding FROM PUBLIC;
REVOKE ALL ON SCHEMA coding FROM easygp;
GRANT ALL ON SCHEMA coding TO easygp;


--
-- Name: common; Type: ACL; Schema: -; Owner: easygp
--

REVOKE ALL ON SCHEMA common FROM PUBLIC;
REVOKE ALL ON SCHEMA common FROM easygp;
GRANT ALL ON SCHEMA common TO easygp;


--
-- Name: contacts; Type: ACL; Schema: -; Owner: easygp
--

REVOKE ALL ON SCHEMA contacts FROM PUBLIC;
REVOKE ALL ON SCHEMA contacts FROM easygp;
GRANT ALL ON SCHEMA contacts TO easygp;


--
-- Name: db; Type: ACL; Schema: -; Owner: easygp
--

REVOKE ALL ON SCHEMA db FROM PUBLIC;
REVOKE ALL ON SCHEMA db FROM easygp;
GRANT ALL ON SCHEMA db TO easygp;
GRANT USAGE ON SCHEMA db TO ian;


--
-- Name: defaults; Type: ACL; Schema: -; Owner: easygp
--

REVOKE ALL ON SCHEMA defaults FROM PUBLIC;
REVOKE ALL ON SCHEMA defaults FROM easygp;
GRANT ALL ON SCHEMA defaults TO easygp;


--
-- Name: documents; Type: ACL; Schema: -; Owner: easygp
--

REVOKE ALL ON SCHEMA documents FROM PUBLIC;
REVOKE ALL ON SCHEMA documents FROM easygp;
GRANT ALL ON SCHEMA documents TO easygp;


--
-- Name: drugs; Type: ACL; Schema: -; Owner: easygp
--

REVOKE ALL ON SCHEMA drugs FROM PUBLIC;
REVOKE ALL ON SCHEMA drugs FROM easygp;
GRANT ALL ON SCHEMA drugs TO easygp;
GRANT USAGE ON SCHEMA drugs TO ian;


--
-- Name: import_export; Type: ACL; Schema: -; Owner: easygp
--

REVOKE ALL ON SCHEMA import_export FROM PUBLIC;
REVOKE ALL ON SCHEMA import_export FROM easygp;
GRANT ALL ON SCHEMA import_export TO easygp;


--
-- Name: maintenance; Type: ACL; Schema: -; Owner: easygp
--

REVOKE ALL ON SCHEMA maintenance FROM PUBLIC;
REVOKE ALL ON SCHEMA maintenance FROM easygp;
GRANT ALL ON SCHEMA maintenance TO easygp;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: research; Type: ACL; Schema: -; Owner: easygp
--

REVOKE ALL ON SCHEMA research FROM PUBLIC;
REVOKE ALL ON SCHEMA research FROM easygp;
GRANT ALL ON SCHEMA research TO easygp;


SET search_path = clerical, pg_catalog;

--
-- Name: listavailable(integer, integer, integer); Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON FUNCTION listavailable(fk_clinicv integer, fk_doctor integer, max integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION listavailable(fk_clinicv integer, fk_doctor integer, max integer) FROM easygp;
GRANT ALL ON FUNCTION listavailable(fk_clinicv integer, fk_doctor integer, max integer) TO easygp;
GRANT ALL ON FUNCTION listavailable(fk_clinicv integer, fk_doctor integer, max integer) TO PUBLIC;


--
-- Name: sessions; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON TABLE sessions FROM PUBLIC;
REVOKE ALL ON TABLE sessions FROM easygp;
GRANT ALL ON TABLE sessions TO easygp;
GRANT ALL ON TABLE sessions TO ian;


SET search_path = public, pg_catalog;

--
-- Name: invoice_received(integer); Type: ACL; Schema: public; Owner: easygp
--

REVOKE ALL ON FUNCTION invoice_received(integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION invoice_received(integer) FROM easygp;
GRANT ALL ON FUNCTION invoice_received(integer) TO easygp;
GRANT ALL ON FUNCTION invoice_received(integer) TO PUBLIC;


--
-- Name: invoice_total(integer); Type: ACL; Schema: public; Owner: easygp
--

REVOKE ALL ON FUNCTION invoice_total(integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION invoice_total(integer) FROM easygp;
GRANT ALL ON FUNCTION invoice_total(integer) TO easygp;
GRANT ALL ON FUNCTION invoice_total(integer) TO PUBLIC;


SET search_path = admin, pg_catalog;

--
-- Name: clinics; Type: ACL; Schema: admin; Owner: easygp
--

REVOKE ALL ON TABLE clinics FROM PUBLIC;
REVOKE ALL ON TABLE clinics FROM easygp;
GRANT ALL ON TABLE clinics TO easygp;
GRANT ALL ON TABLE clinics TO ian;


--
-- Name: clinic_pk_seq; Type: ACL; Schema: admin; Owner: easygp
--

REVOKE ALL ON SEQUENCE clinic_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE clinic_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE clinic_pk_seq TO easygp;


--
-- Name: clinic_rooms; Type: ACL; Schema: admin; Owner: easygp
--

REVOKE ALL ON TABLE clinic_rooms FROM PUBLIC;
REVOKE ALL ON TABLE clinic_rooms FROM easygp;
GRANT ALL ON TABLE clinic_rooms TO easygp;
GRANT ALL ON TABLE clinic_rooms TO ian;


--
-- Name: global_preferences; Type: ACL; Schema: admin; Owner: easygp
--

REVOKE ALL ON TABLE global_preferences FROM PUBLIC;
REVOKE ALL ON TABLE global_preferences FROM easygp;
GRANT ALL ON TABLE global_preferences TO easygp;
GRANT ALL ON TABLE global_preferences TO ian;


--
-- Name: global_preferences_pk_seq; Type: ACL; Schema: admin; Owner: easygp
--

REVOKE ALL ON SEQUENCE global_preferences_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE global_preferences_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE global_preferences_pk_seq TO easygp;


--
-- Name: link_staff_clinics; Type: ACL; Schema: admin; Owner: easygp
--

REVOKE ALL ON TABLE link_staff_clinics FROM PUBLIC;
REVOKE ALL ON TABLE link_staff_clinics FROM easygp;
GRANT ALL ON TABLE link_staff_clinics TO easygp;
GRANT ALL ON TABLE link_staff_clinics TO ian;


--
-- Name: link_staff_clinics_pk_seq; Type: ACL; Schema: admin; Owner: easygp
--

REVOKE ALL ON SEQUENCE link_staff_clinics_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE link_staff_clinics_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE link_staff_clinics_pk_seq TO easygp;


--
-- Name: lu_clinical_modules; Type: ACL; Schema: admin; Owner: easygp
--

REVOKE ALL ON TABLE lu_clinical_modules FROM PUBLIC;
REVOKE ALL ON TABLE lu_clinical_modules FROM easygp;
GRANT ALL ON TABLE lu_clinical_modules TO easygp;
GRANT ALL ON TABLE lu_clinical_modules TO ian;


--
-- Name: lu_staff_roles; Type: ACL; Schema: admin; Owner: easygp
--

REVOKE ALL ON TABLE lu_staff_roles FROM PUBLIC;
REVOKE ALL ON TABLE lu_staff_roles FROM easygp;
GRANT ALL ON TABLE lu_staff_roles TO easygp;
GRANT ALL ON TABLE lu_staff_roles TO ian;


--
-- Name: lu_staff_status; Type: ACL; Schema: admin; Owner: easygp
--

REVOKE ALL ON TABLE lu_staff_status FROM PUBLIC;
REVOKE ALL ON TABLE lu_staff_status FROM easygp;
GRANT ALL ON TABLE lu_staff_status TO easygp;
GRANT ALL ON TABLE lu_staff_status TO ian;


--
-- Name: lu_staff_type; Type: ACL; Schema: admin; Owner: easygp
--

REVOKE ALL ON TABLE lu_staff_type FROM PUBLIC;
REVOKE ALL ON TABLE lu_staff_type FROM easygp;
GRANT ALL ON TABLE lu_staff_type TO easygp;
GRANT ALL ON TABLE lu_staff_type TO ian;


--
-- Name: staff; Type: ACL; Schema: admin; Owner: easygp
--

REVOKE ALL ON TABLE staff FROM PUBLIC;
REVOKE ALL ON TABLE staff FROM easygp;
GRANT ALL ON TABLE staff TO easygp;
GRANT ALL ON TABLE staff TO ian;


--
-- Name: staff_clinical_toolbar; Type: ACL; Schema: admin; Owner: easygp
--

REVOKE ALL ON TABLE staff_clinical_toolbar FROM PUBLIC;
REVOKE ALL ON TABLE staff_clinical_toolbar FROM easygp;
GRANT ALL ON TABLE staff_clinical_toolbar TO easygp;
GRANT ALL ON TABLE staff_clinical_toolbar TO ian;


--
-- Name: staff_clinical_toolbar_pk_seq; Type: ACL; Schema: admin; Owner: easygp
--

REVOKE ALL ON SEQUENCE staff_clinical_toolbar_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE staff_clinical_toolbar_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE staff_clinical_toolbar_pk_seq TO easygp;


--
-- Name: staff_pk_seq; Type: ACL; Schema: admin; Owner: easygp
--

REVOKE ALL ON SEQUENCE staff_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE staff_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE staff_pk_seq TO easygp;


SET search_path = contacts, pg_catalog;

--
-- Name: data_addresses; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE data_addresses FROM PUBLIC;
REVOKE ALL ON TABLE data_addresses FROM easygp;
GRANT ALL ON TABLE data_addresses TO easygp;
GRANT ALL ON TABLE data_addresses TO ian;


--
-- Name: data_branches; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE data_branches FROM PUBLIC;
REVOKE ALL ON TABLE data_branches FROM easygp;
GRANT ALL ON TABLE data_branches TO easygp;
GRANT ALL ON TABLE data_branches TO ian;


--
-- Name: data_organisations; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE data_organisations FROM PUBLIC;
REVOKE ALL ON TABLE data_organisations FROM easygp;
GRANT ALL ON TABLE data_organisations TO easygp;
GRANT ALL ON TABLE data_organisations TO ian;


--
-- Name: lu_address_types; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE lu_address_types FROM PUBLIC;
REVOKE ALL ON TABLE lu_address_types FROM easygp;
GRANT ALL ON TABLE lu_address_types TO easygp;
GRANT ALL ON TABLE lu_address_types TO ian;


--
-- Name: lu_categories; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE lu_categories FROM PUBLIC;
REVOKE ALL ON TABLE lu_categories FROM easygp;
GRANT ALL ON TABLE lu_categories TO easygp;
GRANT ALL ON TABLE lu_categories TO ian;


--
-- Name: lu_towns; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE lu_towns FROM PUBLIC;
REVOKE ALL ON TABLE lu_towns FROM easygp;
GRANT ALL ON TABLE lu_towns TO easygp;
GRANT ALL ON TABLE lu_towns TO ian;


SET search_path = admin, pg_catalog;

--
-- Name: vwclinics; Type: ACL; Schema: admin; Owner: easygp
--

REVOKE ALL ON TABLE vwclinics FROM PUBLIC;
REVOKE ALL ON TABLE vwclinics FROM easygp;
GRANT ALL ON TABLE vwclinics TO easygp;
GRANT ALL ON TABLE vwclinics TO ian;


--
-- Name: vwclinicrooms; Type: ACL; Schema: admin; Owner: easygp
--

REVOKE ALL ON TABLE vwclinicrooms FROM PUBLIC;
REVOKE ALL ON TABLE vwclinicrooms FROM easygp;
GRANT ALL ON TABLE vwclinicrooms TO easygp;
GRANT ALL ON TABLE vwclinicrooms TO ian;


SET search_path = contacts, pg_catalog;

--
-- Name: data_numbers; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE data_numbers FROM PUBLIC;
REVOKE ALL ON TABLE data_numbers FROM easygp;
GRANT ALL ON TABLE data_numbers TO easygp;
GRANT ALL ON TABLE data_numbers TO ian;


--
-- Name: data_persons; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE data_persons FROM PUBLIC;
REVOKE ALL ON TABLE data_persons FROM easygp;
GRANT ALL ON TABLE data_persons TO easygp;
GRANT ALL ON TABLE data_persons TO ian;


--
-- Name: lu_title; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE lu_title FROM PUBLIC;
REVOKE ALL ON TABLE lu_title FROM easygp;
GRANT ALL ON TABLE lu_title TO easygp;
GRANT ALL ON TABLE lu_title TO ian;


SET search_path = admin, pg_catalog;

--
-- Name: vwstaff; Type: ACL; Schema: admin; Owner: easygp
--

REVOKE ALL ON TABLE vwstaff FROM PUBLIC;
REVOKE ALL ON TABLE vwstaff FROM easygp;
GRANT ALL ON TABLE vwstaff TO easygp;
GRANT ALL ON TABLE vwstaff TO ian;


SET search_path = blobs, pg_catalog;

--
-- Name: images; Type: ACL; Schema: blobs; Owner: easygp
--

REVOKE ALL ON TABLE images FROM PUBLIC;
REVOKE ALL ON TABLE images FROM easygp;
GRANT ALL ON TABLE images TO easygp;
GRANT ALL ON TABLE images TO ian;


SET search_path = common, pg_catalog;

--
-- Name: lu_ethnicity; Type: ACL; Schema: common; Owner: easygp
--

REVOKE ALL ON TABLE lu_ethnicity FROM PUBLIC;
REVOKE ALL ON TABLE lu_ethnicity FROM easygp;
GRANT ALL ON TABLE lu_ethnicity TO easygp;
GRANT ALL ON TABLE lu_ethnicity TO ian;


--
-- Name: lu_languages; Type: ACL; Schema: common; Owner: easygp
--

REVOKE ALL ON TABLE lu_languages FROM PUBLIC;
REVOKE ALL ON TABLE lu_languages FROM easygp;
GRANT ALL ON TABLE lu_languages TO easygp;
GRANT ALL ON TABLE lu_languages TO ian;


--
-- Name: lu_occupations; Type: ACL; Schema: common; Owner: easygp
--

REVOKE ALL ON TABLE lu_occupations FROM PUBLIC;
REVOKE ALL ON TABLE lu_occupations FROM easygp;
GRANT ALL ON TABLE lu_occupations TO easygp;
GRANT ALL ON TABLE lu_occupations TO ian;


SET search_path = contacts, pg_catalog;

--
-- Name: data_employees; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE data_employees FROM PUBLIC;
REVOKE ALL ON TABLE data_employees FROM easygp;
GRANT ALL ON TABLE data_employees TO easygp;
GRANT ALL ON TABLE data_employees TO ian;


--
-- Name: lu_employee_status; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE lu_employee_status FROM PUBLIC;
REVOKE ALL ON TABLE lu_employee_status FROM easygp;
GRANT ALL ON TABLE lu_employee_status TO easygp;
GRANT ALL ON TABLE lu_employee_status TO ian;


--
-- Name: lu_marital; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE lu_marital FROM PUBLIC;
REVOKE ALL ON TABLE lu_marital FROM easygp;
GRANT ALL ON TABLE lu_marital TO easygp;
GRANT ALL ON TABLE lu_marital TO ian;


--
-- Name: lu_sex; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE lu_sex FROM PUBLIC;
REVOKE ALL ON TABLE lu_sex FROM easygp;
GRANT ALL ON TABLE lu_sex TO easygp;
GRANT ALL ON TABLE lu_sex TO ian;


SET search_path = admin, pg_catalog;

--
-- Name: vwstaffinclinics; Type: ACL; Schema: admin; Owner: easygp
--

REVOKE ALL ON TABLE vwstaffinclinics FROM PUBLIC;
REVOKE ALL ON TABLE vwstaffinclinics FROM easygp;
GRANT ALL ON TABLE vwstaffinclinics TO easygp;
GRANT ALL ON TABLE vwstaffinclinics TO ian;


--
-- Name: vwstafftoolbarbuttons; Type: ACL; Schema: admin; Owner: easygp
--

REVOKE ALL ON TABLE vwstafftoolbarbuttons FROM PUBLIC;
REVOKE ALL ON TABLE vwstafftoolbarbuttons FROM easygp;
GRANT ALL ON TABLE vwstafftoolbarbuttons TO easygp;
GRANT ALL ON TABLE vwstafftoolbarbuttons TO ian;


SET search_path = billing, pg_catalog;

--
-- Name: bulk_billing_claims; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE bulk_billing_claims FROM PUBLIC;
REVOKE ALL ON TABLE bulk_billing_claims FROM easygp;
GRANT ALL ON TABLE bulk_billing_claims TO easygp;
GRANT ALL ON TABLE bulk_billing_claims TO ian;


--
-- Name: bulk_billing_claims_pk_seq; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON SEQUENCE bulk_billing_claims_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE bulk_billing_claims_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE bulk_billing_claims_pk_seq TO easygp;


--
-- Name: fee_schedule; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE fee_schedule FROM PUBLIC;
REVOKE ALL ON TABLE fee_schedule FROM easygp;
GRANT ALL ON TABLE fee_schedule TO easygp;
GRANT ALL ON TABLE fee_schedule TO ian;


--
-- Name: fee_schedule_pk_seq; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON SEQUENCE fee_schedule_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE fee_schedule_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE fee_schedule_pk_seq TO easygp;


--
-- Name: invoices; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE invoices FROM PUBLIC;
REVOKE ALL ON TABLE invoices FROM easygp;
GRANT ALL ON TABLE invoices TO easygp;
GRANT ALL ON TABLE invoices TO ian;


--
-- Name: invoices_pk_seq; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON SEQUENCE invoices_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE invoices_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE invoices_pk_seq TO easygp;


--
-- Name: items_billed; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE items_billed FROM PUBLIC;
REVOKE ALL ON TABLE items_billed FROM easygp;
GRANT ALL ON TABLE items_billed TO easygp;
GRANT ALL ON TABLE items_billed TO ian;


--
-- Name: items_billed_pk_seq; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON SEQUENCE items_billed_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE items_billed_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE items_billed_pk_seq TO easygp;


--
-- Name: link_invoice_bulk_bill_claim; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE link_invoice_bulk_bill_claim FROM PUBLIC;
REVOKE ALL ON TABLE link_invoice_bulk_bill_claim FROM easygp;
GRANT ALL ON TABLE link_invoice_bulk_bill_claim TO easygp;
GRANT ALL ON TABLE link_invoice_bulk_bill_claim TO ian;


--
-- Name: lu_billing_type; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE lu_billing_type FROM PUBLIC;
REVOKE ALL ON TABLE lu_billing_type FROM easygp;
GRANT ALL ON TABLE lu_billing_type TO easygp;
GRANT ALL ON TABLE lu_billing_type TO ian;


--
-- Name: lu_bulk_billing_type; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE lu_bulk_billing_type FROM PUBLIC;
REVOKE ALL ON TABLE lu_bulk_billing_type FROM easygp;
GRANT ALL ON TABLE lu_bulk_billing_type TO easygp;
GRANT ALL ON TABLE lu_bulk_billing_type TO ian;


--
-- Name: lu_default_billing_level; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE lu_default_billing_level FROM PUBLIC;
REVOKE ALL ON TABLE lu_default_billing_level FROM easygp;
GRANT ALL ON TABLE lu_default_billing_level TO easygp;
GRANT ALL ON TABLE lu_default_billing_level TO ian;


--
-- Name: lu_invoice_comments; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE lu_invoice_comments FROM PUBLIC;
REVOKE ALL ON TABLE lu_invoice_comments FROM easygp;
GRANT ALL ON TABLE lu_invoice_comments TO easygp;
GRANT ALL ON TABLE lu_invoice_comments TO ian;


--
-- Name: lu_payment_method; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE lu_payment_method FROM PUBLIC;
REVOKE ALL ON TABLE lu_payment_method FROM easygp;
GRANT ALL ON TABLE lu_payment_method TO easygp;
GRANT ALL ON TABLE lu_payment_method TO ian;


--
-- Name: lu_reasons_not_billed; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE lu_reasons_not_billed FROM PUBLIC;
REVOKE ALL ON TABLE lu_reasons_not_billed FROM easygp;
GRANT ALL ON TABLE lu_reasons_not_billed TO easygp;
GRANT ALL ON TABLE lu_reasons_not_billed TO ian;


--
-- Name: lu_reports; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE lu_reports FROM PUBLIC;
REVOKE ALL ON TABLE lu_reports FROM easygp;
GRANT ALL ON TABLE lu_reports TO easygp;
GRANT ALL ON TABLE lu_reports TO ian;


--
-- Name: payments_received; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE payments_received FROM PUBLIC;
REVOKE ALL ON TABLE payments_received FROM easygp;
GRANT ALL ON TABLE payments_received TO easygp;
GRANT ALL ON TABLE payments_received TO ian;


--
-- Name: payments_received_pk_seq; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON SEQUENCE payments_received_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE payments_received_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE payments_received_pk_seq TO easygp;


--
-- Name: prices; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE prices FROM PUBLIC;
REVOKE ALL ON TABLE prices FROM easygp;
GRANT ALL ON TABLE prices TO easygp;
GRANT ALL ON TABLE prices TO ian;


--
-- Name: prices_pk_seq; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON SEQUENCE prices_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE prices_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE prices_pk_seq TO easygp;


--
-- Name: reports; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE reports FROM PUBLIC;
REVOKE ALL ON TABLE reports FROM easygp;
GRANT ALL ON TABLE reports TO easygp;
GRANT ALL ON TABLE reports TO ian;


SET search_path = clerical, pg_catalog;

--
-- Name: data_patients; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON TABLE data_patients FROM PUBLIC;
REVOKE ALL ON TABLE data_patients FROM easygp;
GRANT ALL ON TABLE data_patients TO easygp;
GRANT ALL ON TABLE data_patients TO ian;


SET search_path = billing, pg_catalog;

--
-- Name: vwbulkbilleditems; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE vwbulkbilleditems FROM PUBLIC;
REVOKE ALL ON TABLE vwbulkbilleditems FROM easygp;
GRANT ALL ON TABLE vwbulkbilleditems TO easygp;
GRANT ALL ON TABLE vwbulkbilleditems TO ian;


SET search_path = clerical, pg_catalog;

--
-- Name: bookings; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON TABLE bookings FROM PUBLIC;
REVOKE ALL ON TABLE bookings FROM easygp;
GRANT ALL ON TABLE bookings TO easygp;
GRANT ALL ON TABLE bookings TO ian;


SET search_path = common, pg_catalog;

--
-- Name: lu_countries; Type: ACL; Schema: common; Owner: easygp
--

REVOKE ALL ON TABLE lu_countries FROM PUBLIC;
REVOKE ALL ON TABLE lu_countries FROM easygp;
GRANT ALL ON TABLE lu_countries TO easygp;
GRANT ALL ON TABLE lu_countries TO ian;


SET search_path = contacts, pg_catalog;

--
-- Name: links_persons_addresses; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE links_persons_addresses FROM PUBLIC;
REVOKE ALL ON TABLE links_persons_addresses FROM easygp;
GRANT ALL ON TABLE links_persons_addresses TO easygp;
GRANT ALL ON TABLE links_persons_addresses TO ian;


--
-- Name: vworganisations_pk_seq; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON SEQUENCE vworganisations_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE vworganisations_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE vworganisations_pk_seq TO easygp;


--
-- Name: vworganisations; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE vworganisations FROM PUBLIC;
REVOKE ALL ON TABLE vworganisations FROM easygp;
GRANT ALL ON TABLE vworganisations TO easygp;
GRANT ALL ON TABLE vworganisations TO ian;


--
-- Name: vwpersonsincludingpatients; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE vwpersonsincludingpatients FROM PUBLIC;
REVOKE ALL ON TABLE vwpersonsincludingpatients FROM easygp;
GRANT ALL ON TABLE vwpersonsincludingpatients TO easygp;
GRANT ALL ON TABLE vwpersonsincludingpatients TO ian;


SET search_path = billing, pg_catalog;

--
-- Name: vwdaylist; Type: ACL; Schema: billing; Owner: postgres
--

REVOKE ALL ON TABLE vwdaylist FROM PUBLIC;
REVOKE ALL ON TABLE vwdaylist FROM postgres;
GRANT ALL ON TABLE vwdaylist TO postgres;
GRANT ALL ON TABLE vwdaylist TO ian;


--
-- Name: vwfees; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE vwfees FROM PUBLIC;
REVOKE ALL ON TABLE vwfees FROM easygp;
GRANT ALL ON TABLE vwfees TO easygp;
GRANT ALL ON TABLE vwfees TO ian;


SET search_path = clerical, pg_catalog;

--
-- Name: lu_active_status; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON TABLE lu_active_status FROM PUBLIC;
REVOKE ALL ON TABLE lu_active_status FROM easygp;
GRANT ALL ON TABLE lu_active_status TO easygp;
GRANT ALL ON TABLE lu_active_status TO ian;


--
-- Name: lu_centrelink_card_type; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON TABLE lu_centrelink_card_type FROM PUBLIC;
REVOKE ALL ON TABLE lu_centrelink_card_type FROM easygp;
GRANT ALL ON TABLE lu_centrelink_card_type TO easygp;
GRANT ALL ON TABLE lu_centrelink_card_type TO ian;


--
-- Name: lu_private_health_funds; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON TABLE lu_private_health_funds FROM PUBLIC;
REVOKE ALL ON TABLE lu_private_health_funds FROM easygp;
GRANT ALL ON TABLE lu_private_health_funds TO easygp;
GRANT ALL ON TABLE lu_private_health_funds TO ian;


--
-- Name: lu_veteran_card_type; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON TABLE lu_veteran_card_type FROM PUBLIC;
REVOKE ALL ON TABLE lu_veteran_card_type FROM easygp;
GRANT ALL ON TABLE lu_veteran_card_type TO easygp;
GRANT ALL ON TABLE lu_veteran_card_type TO ian;


SET search_path = common, pg_catalog;

--
-- Name: lu_aboriginality; Type: ACL; Schema: common; Owner: easygp
--

REVOKE ALL ON TABLE lu_aboriginality FROM PUBLIC;
REVOKE ALL ON TABLE lu_aboriginality FROM easygp;
GRANT ALL ON TABLE lu_aboriginality TO easygp;
GRANT ALL ON TABLE lu_aboriginality TO ian;


SET search_path = contacts, pg_catalog;

--
-- Name: vwpatients; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE vwpatients FROM PUBLIC;
REVOKE ALL ON TABLE vwpatients FROM easygp;
GRANT ALL ON TABLE vwpatients TO easygp;
GRANT ALL ON TABLE vwpatients TO ian;


SET search_path = billing, pg_catalog;

--
-- Name: vwinvoices; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE vwinvoices FROM PUBLIC;
REVOKE ALL ON TABLE vwinvoices FROM easygp;
GRANT ALL ON TABLE vwinvoices TO easygp;
GRANT ALL ON TABLE vwinvoices TO ian;


--
-- Name: vwitemsbilled; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE vwitemsbilled FROM PUBLIC;
REVOKE ALL ON TABLE vwitemsbilled FROM easygp;
GRANT ALL ON TABLE vwitemsbilled TO easygp;
GRANT ALL ON TABLE vwitemsbilled TO ian;


--
-- Name: vwitemsandinvoices; Type: ACL; Schema: billing; Owner: easygp
--

REVOKE ALL ON TABLE vwitemsandinvoices FROM PUBLIC;
REVOKE ALL ON TABLE vwitemsandinvoices FROM easygp;
GRANT ALL ON TABLE vwitemsandinvoices TO easygp;
GRANT ALL ON TABLE vwitemsandinvoices TO ian;


SET search_path = blobs, pg_catalog;

--
-- Name: blobs; Type: ACL; Schema: blobs; Owner: easygp
--

REVOKE ALL ON TABLE blobs FROM PUBLIC;
REVOKE ALL ON TABLE blobs FROM easygp;
GRANT ALL ON TABLE blobs TO easygp;
GRANT ALL ON TABLE blobs TO ian;


--
-- Name: blobs_pk_seq; Type: ACL; Schema: blobs; Owner: easygp
--

REVOKE ALL ON SEQUENCE blobs_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE blobs_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE blobs_pk_seq TO easygp;


--
-- Name: images_pk_seq; Type: ACL; Schema: blobs; Owner: easygp
--

REVOKE ALL ON SEQUENCE images_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE images_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE images_pk_seq TO easygp;


SET search_path = clin_consult, pg_catalog;

--
-- Name: consult; Type: ACL; Schema: clin_consult; Owner: easygp
--

REVOKE ALL ON TABLE consult FROM PUBLIC;
REVOKE ALL ON TABLE consult FROM easygp;
GRANT ALL ON TABLE consult TO easygp;
GRANT ALL ON TABLE consult TO ian;


SET search_path = blobs, pg_catalog;

--
-- Name: vwpatientimages; Type: ACL; Schema: blobs; Owner: easygp
--

REVOKE ALL ON TABLE vwpatientimages FROM PUBLIC;
REVOKE ALL ON TABLE vwpatientimages FROM easygp;
GRANT ALL ON TABLE vwpatientimages TO easygp;
GRANT ALL ON TABLE vwpatientimages TO ian;


SET search_path = chronic_disease_management, pg_catalog;

--
-- Name: diabetes_annual_cycle_of_care; Type: ACL; Schema: chronic_disease_management; Owner: easygp
--

REVOKE ALL ON TABLE diabetes_annual_cycle_of_care FROM PUBLIC;
REVOKE ALL ON TABLE diabetes_annual_cycle_of_care FROM easygp;
GRANT ALL ON TABLE diabetes_annual_cycle_of_care TO easygp;
GRANT ALL ON TABLE diabetes_annual_cycle_of_care TO ian;


--
-- Name: diabetes_annual_cycle_of_care_notes; Type: ACL; Schema: chronic_disease_management; Owner: easygp
--

REVOKE ALL ON TABLE diabetes_annual_cycle_of_care_notes FROM PUBLIC;
REVOKE ALL ON TABLE diabetes_annual_cycle_of_care_notes FROM easygp;
GRANT ALL ON TABLE diabetes_annual_cycle_of_care_notes TO easygp;
GRANT ALL ON TABLE diabetes_annual_cycle_of_care_notes TO ian;


--
-- Name: epc_link_provider_form; Type: ACL; Schema: chronic_disease_management; Owner: easygp
--

REVOKE ALL ON TABLE epc_link_provider_form FROM PUBLIC;
REVOKE ALL ON TABLE epc_link_provider_form FROM easygp;
GRANT ALL ON TABLE epc_link_provider_form TO easygp;
GRANT ALL ON TABLE epc_link_provider_form TO ian;


--
-- Name: epc_referral; Type: ACL; Schema: chronic_disease_management; Owner: easygp
--

REVOKE ALL ON TABLE epc_referral FROM PUBLIC;
REVOKE ALL ON TABLE epc_referral FROM easygp;
GRANT ALL ON TABLE epc_referral TO easygp;
GRANT ALL ON TABLE epc_referral TO ian;


--
-- Name: lu_allied_health_type; Type: ACL; Schema: chronic_disease_management; Owner: easygp
--

REVOKE ALL ON TABLE lu_allied_health_type FROM PUBLIC;
REVOKE ALL ON TABLE lu_allied_health_type FROM easygp;
GRANT ALL ON TABLE lu_allied_health_type TO easygp;
GRANT ALL ON TABLE lu_allied_health_type TO ian;


--
-- Name: lu_dacc_components; Type: ACL; Schema: chronic_disease_management; Owner: easygp
--

REVOKE ALL ON TABLE lu_dacc_components FROM PUBLIC;
REVOKE ALL ON TABLE lu_dacc_components FROM easygp;
GRANT ALL ON TABLE lu_dacc_components TO easygp;
GRANT ALL ON TABLE lu_dacc_components TO ian;


--
-- Name: patients_with_hba1c_not_diabetic; Type: ACL; Schema: chronic_disease_management; Owner: easygp
--

REVOKE ALL ON TABLE patients_with_hba1c_not_diabetic FROM PUBLIC;
REVOKE ALL ON TABLE patients_with_hba1c_not_diabetic FROM easygp;
GRANT ALL ON TABLE patients_with_hba1c_not_diabetic TO easygp;
GRANT ALL ON TABLE patients_with_hba1c_not_diabetic TO ian;


--
-- Name: team_care_arrangements; Type: ACL; Schema: chronic_disease_management; Owner: easygp
--

REVOKE ALL ON TABLE team_care_arrangements FROM PUBLIC;
REVOKE ALL ON TABLE team_care_arrangements FROM easygp;
GRANT ALL ON TABLE team_care_arrangements TO easygp;
GRANT ALL ON TABLE team_care_arrangements TO ian;


SET search_path = clin_consult, pg_catalog;

--
-- Name: lu_audit_actions; Type: ACL; Schema: clin_consult; Owner: easygp
--

REVOKE ALL ON TABLE lu_audit_actions FROM PUBLIC;
REVOKE ALL ON TABLE lu_audit_actions FROM easygp;
GRANT ALL ON TABLE lu_audit_actions TO easygp;
GRANT ALL ON TABLE lu_audit_actions TO ian;


--
-- Name: lu_audit_reasons; Type: ACL; Schema: clin_consult; Owner: easygp
--

REVOKE ALL ON TABLE lu_audit_reasons FROM PUBLIC;
REVOKE ALL ON TABLE lu_audit_reasons FROM easygp;
GRANT ALL ON TABLE lu_audit_reasons TO easygp;
GRANT ALL ON TABLE lu_audit_reasons TO ian;


--
-- Name: lu_consult_type; Type: ACL; Schema: clin_consult; Owner: easygp
--

REVOKE ALL ON TABLE lu_consult_type FROM PUBLIC;
REVOKE ALL ON TABLE lu_consult_type FROM easygp;
GRANT ALL ON TABLE lu_consult_type TO easygp;
GRANT ALL ON TABLE lu_consult_type TO ian;


--
-- Name: lu_progressnotes_sections; Type: ACL; Schema: clin_consult; Owner: easygp
--

REVOKE ALL ON TABLE lu_progressnotes_sections FROM PUBLIC;
REVOKE ALL ON TABLE lu_progressnotes_sections FROM easygp;
GRANT ALL ON TABLE lu_progressnotes_sections TO easygp;
GRANT ALL ON TABLE lu_progressnotes_sections TO ian;


--
-- Name: progressnotes; Type: ACL; Schema: clin_consult; Owner: easygp
--

REVOKE ALL ON TABLE progressnotes FROM PUBLIC;
REVOKE ALL ON TABLE progressnotes FROM easygp;
GRANT ALL ON TABLE progressnotes TO easygp;
GRANT ALL ON TABLE progressnotes TO ian;


--
-- Name: vwprogressnotes; Type: ACL; Schema: clin_consult; Owner: easygp
--

REVOKE ALL ON TABLE vwprogressnotes FROM PUBLIC;
REVOKE ALL ON TABLE vwprogressnotes FROM easygp;
GRANT ALL ON TABLE vwprogressnotes TO easygp;
GRANT ALL ON TABLE vwprogressnotes TO ian;


SET search_path = chronic_disease_management, pg_catalog;

--
-- Name: vwdiabetescycleofcare; Type: ACL; Schema: chronic_disease_management; Owner: easygp
--

REVOKE ALL ON TABLE vwdiabetescycleofcare FROM PUBLIC;
REVOKE ALL ON TABLE vwdiabetescycleofcare FROM easygp;
GRANT ALL ON TABLE vwdiabetescycleofcare TO easygp;
GRANT ALL ON TABLE vwdiabetescycleofcare TO ian;


SET search_path = clerical, pg_catalog;

--
-- Name: bookings_pk_seq; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON SEQUENCE bookings_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE bookings_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE bookings_pk_seq TO easygp;


--
-- Name: data_families; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON TABLE data_families FROM PUBLIC;
REVOKE ALL ON TABLE data_families FROM easygp;
GRANT ALL ON TABLE data_families TO easygp;
GRANT ALL ON TABLE data_families TO ian;


--
-- Name: data_families_pk_seq; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON SEQUENCE data_families_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE data_families_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE data_families_pk_seq TO easygp;


--
-- Name: data_family_members; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON TABLE data_family_members FROM PUBLIC;
REVOKE ALL ON TABLE data_family_members FROM easygp;
GRANT ALL ON TABLE data_family_members TO easygp;
GRANT ALL ON TABLE data_family_members TO ian;


--
-- Name: data_family_members_pk_seq; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON SEQUENCE data_family_members_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE data_family_members_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE data_family_members_pk_seq TO easygp;


--
-- Name: data_patients_pk_seq; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON SEQUENCE data_patients_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE data_patients_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE data_patients_pk_seq TO easygp;


--
-- Name: inventory; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON TABLE inventory FROM PUBLIC;
REVOKE ALL ON TABLE inventory FROM easygp;
GRANT ALL ON TABLE inventory TO easygp;
GRANT ALL ON TABLE inventory TO ian;


--
-- Name: inventory_lent; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON TABLE inventory_lent FROM PUBLIC;
REVOKE ALL ON TABLE inventory_lent FROM easygp;
GRANT ALL ON TABLE inventory_lent TO easygp;
GRANT ALL ON TABLE inventory_lent TO ian;


--
-- Name: inventory_lent_pk_seq; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON SEQUENCE inventory_lent_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE inventory_lent_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE inventory_lent_pk_seq TO easygp;


--
-- Name: inventory_locations; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON TABLE inventory_locations FROM PUBLIC;
REVOKE ALL ON TABLE inventory_locations FROM easygp;
GRANT ALL ON TABLE inventory_locations TO easygp;
GRANT ALL ON TABLE inventory_locations TO ian;


--
-- Name: inventory_locations_pk_seq; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON SEQUENCE inventory_locations_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE inventory_locations_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE inventory_locations_pk_seq TO easygp;


--
-- Name: inventory_pk_seq; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON SEQUENCE inventory_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE inventory_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE inventory_pk_seq TO easygp;


--
-- Name: lu_active_status_pk_seq; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_active_status_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_active_status_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_active_status_pk_seq TO easygp;


--
-- Name: lu_appointment_icons; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON TABLE lu_appointment_icons FROM PUBLIC;
REVOKE ALL ON TABLE lu_appointment_icons FROM easygp;
GRANT ALL ON TABLE lu_appointment_icons TO easygp;
GRANT ALL ON TABLE lu_appointment_icons TO ian;


--
-- Name: lu_appointment_icons_pk_seq; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_appointment_icons_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_appointment_icons_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_appointment_icons_pk_seq TO easygp;


--
-- Name: lu_appointment_status; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON TABLE lu_appointment_status FROM PUBLIC;
REVOKE ALL ON TABLE lu_appointment_status FROM easygp;
GRANT ALL ON TABLE lu_appointment_status TO easygp;
GRANT ALL ON TABLE lu_appointment_status TO ian;


--
-- Name: lu_appointment_status_pk_seq; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_appointment_status_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_appointment_status_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_appointment_status_pk_seq TO easygp;


--
-- Name: lu_centrelink_card_type_pk_seq; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_centrelink_card_type_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_centrelink_card_type_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_centrelink_card_type_pk_seq TO easygp;


--
-- Name: lu_inventory_categories; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON TABLE lu_inventory_categories FROM PUBLIC;
REVOKE ALL ON TABLE lu_inventory_categories FROM easygp;
GRANT ALL ON TABLE lu_inventory_categories TO easygp;
GRANT ALL ON TABLE lu_inventory_categories TO ian;


--
-- Name: lu_inventory_categories_pk_seq; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_inventory_categories_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_inventory_categories_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_inventory_categories_pk_seq TO easygp;


--
-- Name: lu_inventory_items; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON TABLE lu_inventory_items FROM PUBLIC;
REVOKE ALL ON TABLE lu_inventory_items FROM easygp;
GRANT ALL ON TABLE lu_inventory_items TO easygp;
GRANT ALL ON TABLE lu_inventory_items TO ian;


--
-- Name: lu_inventory_items_pk_seq; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_inventory_items_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_inventory_items_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_inventory_items_pk_seq TO easygp;


--
-- Name: lu_private_health_funds_pk_seq; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_private_health_funds_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_private_health_funds_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_private_health_funds_pk_seq TO easygp;


--
-- Name: lu_task_types; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON TABLE lu_task_types FROM PUBLIC;
REVOKE ALL ON TABLE lu_task_types FROM easygp;
GRANT ALL ON TABLE lu_task_types TO easygp;
GRANT ALL ON TABLE lu_task_types TO ian;


--
-- Name: lu_task_types_pk_seq; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_task_types_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_task_types_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_task_types_pk_seq TO easygp;


--
-- Name: lu_veteran_card_type_pk_seq; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_veteran_card_type_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_veteran_card_type_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_veteran_card_type_pk_seq TO easygp;


--
-- Name: sessions_pk_seq; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON SEQUENCE sessions_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE sessions_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE sessions_pk_seq TO easygp;


--
-- Name: task_component_notes; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON TABLE task_component_notes FROM PUBLIC;
REVOKE ALL ON TABLE task_component_notes FROM easygp;
GRANT ALL ON TABLE task_component_notes TO easygp;
GRANT ALL ON TABLE task_component_notes TO ian;


--
-- Name: task_component_notes_pk_seq; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON SEQUENCE task_component_notes_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE task_component_notes_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE task_component_notes_pk_seq TO easygp;


--
-- Name: task_components; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON TABLE task_components FROM PUBLIC;
REVOKE ALL ON TABLE task_components FROM easygp;
GRANT ALL ON TABLE task_components TO easygp;
GRANT ALL ON TABLE task_components TO ian;


--
-- Name: task_components_pk_seq; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON SEQUENCE task_components_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE task_components_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE task_components_pk_seq TO easygp;


--
-- Name: tasks; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON TABLE tasks FROM PUBLIC;
REVOKE ALL ON TABLE tasks FROM easygp;
GRANT ALL ON TABLE tasks TO easygp;
GRANT ALL ON TABLE tasks TO ian;


--
-- Name: tasks_pk_seq; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON SEQUENCE tasks_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE tasks_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE tasks_pk_seq TO easygp;


--
-- Name: vwappointments; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON TABLE vwappointments FROM PUBLIC;
REVOKE ALL ON TABLE vwappointments FROM easygp;
GRANT ALL ON TABLE vwappointments TO easygp;
GRANT ALL ON TABLE vwappointments TO ian;


--
-- Name: vwinventory; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON TABLE vwinventory FROM PUBLIC;
REVOKE ALL ON TABLE vwinventory FROM easygp;
GRANT ALL ON TABLE vwinventory TO easygp;
GRANT ALL ON TABLE vwinventory TO ian;


SET search_path = common, pg_catalog;

--
-- Name: lu_urgency; Type: ACL; Schema: common; Owner: easygp
--

REVOKE ALL ON TABLE lu_urgency FROM PUBLIC;
REVOKE ALL ON TABLE lu_urgency FROM easygp;
GRANT ALL ON TABLE lu_urgency TO easygp;
GRANT ALL ON TABLE lu_urgency TO ian;


SET search_path = clerical, pg_catalog;

--
-- Name: vwtaskscomponents; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON TABLE vwtaskscomponents FROM PUBLIC;
REVOKE ALL ON TABLE vwtaskscomponents FROM easygp;
GRANT ALL ON TABLE vwtaskscomponents TO easygp;
GRANT ALL ON TABLE vwtaskscomponents TO ian;


--
-- Name: vwtaskscomponentsandnotes; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON TABLE vwtaskscomponentsandnotes FROM PUBLIC;
REVOKE ALL ON TABLE vwtaskscomponentsandnotes FROM easygp;
GRANT ALL ON TABLE vwtaskscomponentsandnotes TO easygp;
GRANT ALL ON TABLE vwtaskscomponentsandnotes TO ian;


--
-- Name: vwtaskscomponentsnotes; Type: ACL; Schema: clerical; Owner: easygp
--

REVOKE ALL ON TABLE vwtaskscomponentsnotes FROM PUBLIC;
REVOKE ALL ON TABLE vwtaskscomponentsnotes FROM easygp;
GRANT ALL ON TABLE vwtaskscomponentsnotes TO easygp;
GRANT ALL ON TABLE vwtaskscomponentsnotes TO ian;


SET search_path = clin_allergies, pg_catalog;

--
-- Name: allergies; Type: ACL; Schema: clin_allergies; Owner: easygp
--

REVOKE ALL ON TABLE allergies FROM PUBLIC;
REVOKE ALL ON TABLE allergies FROM easygp;
GRANT ALL ON TABLE allergies TO easygp;
GRANT ALL ON TABLE allergies TO ian;


--
-- Name: allergies_pk_seq; Type: ACL; Schema: clin_allergies; Owner: easygp
--

REVOKE ALL ON SEQUENCE allergies_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE allergies_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE allergies_pk_seq TO easygp;


--
-- Name: lu_reaction_type; Type: ACL; Schema: clin_allergies; Owner: easygp
--

REVOKE ALL ON TABLE lu_reaction_type FROM PUBLIC;
REVOKE ALL ON TABLE lu_reaction_type FROM easygp;
GRANT ALL ON TABLE lu_reaction_type TO easygp;
GRANT ALL ON TABLE lu_reaction_type TO ian;


--
-- Name: lu_reaction_type_pk_seq; Type: ACL; Schema: clin_allergies; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_reaction_type_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_reaction_type_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_reaction_type_pk_seq TO easygp;


SET search_path = coding, pg_catalog;

--
-- Name: generic_terms; Type: ACL; Schema: coding; Owner: easygp
--

REVOKE ALL ON TABLE generic_terms FROM PUBLIC;
REVOKE ALL ON TABLE generic_terms FROM easygp;
GRANT ALL ON TABLE generic_terms TO easygp;
GRANT ALL ON TABLE generic_terms TO ian;


--
-- Name: lu_systems; Type: ACL; Schema: coding; Owner: easygp
--

REVOKE ALL ON TABLE lu_systems FROM PUBLIC;
REVOKE ALL ON TABLE lu_systems FROM easygp;
GRANT ALL ON TABLE lu_systems TO easygp;
GRANT ALL ON TABLE lu_systems TO ian;


SET search_path = drugs, pg_catalog;

--
-- Name: atc; Type: ACL; Schema: drugs; Owner: easygp
--

REVOKE ALL ON TABLE atc FROM PUBLIC;
REVOKE ALL ON TABLE atc FROM easygp;
GRANT ALL ON TABLE atc TO easygp;
GRANT ALL ON TABLE atc TO ian;


--
-- Name: brand; Type: ACL; Schema: drugs; Owner: easygp
--

REVOKE ALL ON TABLE brand FROM PUBLIC;
REVOKE ALL ON TABLE brand FROM easygp;
GRANT ALL ON TABLE brand TO easygp;
GRANT ALL ON TABLE brand TO ian;


--
-- Name: product; Type: ACL; Schema: drugs; Owner: easygp
--

REVOKE ALL ON TABLE product FROM PUBLIC;
REVOKE ALL ON TABLE product FROM easygp;
GRANT ALL ON TABLE product TO easygp;
GRANT ALL ON TABLE product TO ian;


SET search_path = clin_allergies, pg_catalog;

--
-- Name: vwallergies; Type: ACL; Schema: clin_allergies; Owner: easygp
--

REVOKE ALL ON TABLE vwallergies FROM PUBLIC;
REVOKE ALL ON TABLE vwallergies FROM easygp;
GRANT ALL ON TABLE vwallergies TO easygp;
GRANT ALL ON TABLE vwallergies TO ian;


SET search_path = clin_careplans, pg_catalog;

--
-- Name: careplan_pages; Type: ACL; Schema: clin_careplans; Owner: easygp
--

REVOKE ALL ON TABLE careplan_pages FROM PUBLIC;
REVOKE ALL ON TABLE careplan_pages FROM easygp;
GRANT ALL ON TABLE careplan_pages TO easygp;
GRANT ALL ON TABLE careplan_pages TO ian;


--
-- Name: careplan_pages_pk_seq; Type: ACL; Schema: clin_careplans; Owner: easygp
--

REVOKE ALL ON SEQUENCE careplan_pages_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE careplan_pages_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE careplan_pages_pk_seq TO easygp;


--
-- Name: careplans; Type: ACL; Schema: clin_careplans; Owner: easygp
--

REVOKE ALL ON TABLE careplans FROM PUBLIC;
REVOKE ALL ON TABLE careplans FROM easygp;
GRANT ALL ON TABLE careplans TO easygp;
GRANT ALL ON TABLE careplans TO ian;


--
-- Name: careplans_pk_seq; Type: ACL; Schema: clin_careplans; Owner: easygp
--

REVOKE ALL ON SEQUENCE careplans_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE careplans_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE careplans_pk_seq TO easygp;


--
-- Name: component_task_due; Type: ACL; Schema: clin_careplans; Owner: easygp
--

REVOKE ALL ON TABLE component_task_due FROM PUBLIC;
REVOKE ALL ON TABLE component_task_due FROM easygp;
GRANT ALL ON TABLE component_task_due TO easygp;
GRANT ALL ON TABLE component_task_due TO ian;


--
-- Name: component_task_due_pk_seq; Type: ACL; Schema: clin_careplans; Owner: easygp
--

REVOKE ALL ON SEQUENCE component_task_due_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE component_task_due_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE component_task_due_pk_seq TO easygp;


--
-- Name: link_careplanpage_advice; Type: ACL; Schema: clin_careplans; Owner: easygp
--

REVOKE ALL ON TABLE link_careplanpage_advice FROM PUBLIC;
REVOKE ALL ON TABLE link_careplanpage_advice FROM easygp;
GRANT ALL ON TABLE link_careplanpage_advice TO easygp;
GRANT ALL ON TABLE link_careplanpage_advice TO ian;


--
-- Name: link_careplanpage_advice_pk_seq; Type: ACL; Schema: clin_careplans; Owner: easygp
--

REVOKE ALL ON SEQUENCE link_careplanpage_advice_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE link_careplanpage_advice_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE link_careplanpage_advice_pk_seq TO easygp;


--
-- Name: link_careplanpage_components; Type: ACL; Schema: clin_careplans; Owner: easygp
--

REVOKE ALL ON TABLE link_careplanpage_components FROM PUBLIC;
REVOKE ALL ON TABLE link_careplanpage_components FROM easygp;
GRANT ALL ON TABLE link_careplanpage_components TO easygp;
GRANT ALL ON TABLE link_careplanpage_components TO ian;


--
-- Name: link_careplanpage_components_pk_seq; Type: ACL; Schema: clin_careplans; Owner: easygp
--

REVOKE ALL ON SEQUENCE link_careplanpage_components_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE link_careplanpage_components_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE link_careplanpage_components_pk_seq TO easygp;


--
-- Name: link_careplanpages_careplan; Type: ACL; Schema: clin_careplans; Owner: easygp
--

REVOKE ALL ON TABLE link_careplanpages_careplan FROM PUBLIC;
REVOKE ALL ON TABLE link_careplanpages_careplan FROM easygp;
GRANT ALL ON TABLE link_careplanpages_careplan TO easygp;
GRANT ALL ON TABLE link_careplanpages_careplan TO ian;


--
-- Name: link_careplanpages_careplan_pk_seq; Type: ACL; Schema: clin_careplans; Owner: easygp
--

REVOKE ALL ON SEQUENCE link_careplanpages_careplan_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE link_careplanpages_careplan_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE link_careplanpages_careplan_pk_seq TO easygp;


--
-- Name: lu_advice; Type: ACL; Schema: clin_careplans; Owner: easygp
--

REVOKE ALL ON TABLE lu_advice FROM PUBLIC;
REVOKE ALL ON TABLE lu_advice FROM easygp;
GRANT ALL ON TABLE lu_advice TO easygp;
GRANT ALL ON TABLE lu_advice TO ian;


--
-- Name: lu_advice_pk_seq; Type: ACL; Schema: clin_careplans; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_advice_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_advice_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_advice_pk_seq TO easygp;


--
-- Name: lu_aims; Type: ACL; Schema: clin_careplans; Owner: easygp
--

REVOKE ALL ON TABLE lu_aims FROM PUBLIC;
REVOKE ALL ON TABLE lu_aims FROM easygp;
GRANT ALL ON TABLE lu_aims TO easygp;
GRANT ALL ON TABLE lu_aims TO ian;


--
-- Name: lu_aims_pk_seq; Type: ACL; Schema: clin_careplans; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_aims_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_aims_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_aims_pk_seq TO easygp;


--
-- Name: lu_components; Type: ACL; Schema: clin_careplans; Owner: easygp
--

REVOKE ALL ON TABLE lu_components FROM PUBLIC;
REVOKE ALL ON TABLE lu_components FROM easygp;
GRANT ALL ON TABLE lu_components TO easygp;
GRANT ALL ON TABLE lu_components TO ian;


--
-- Name: lu_components_pk_seq; Type: ACL; Schema: clin_careplans; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_components_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_components_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_components_pk_seq TO easygp;


--
-- Name: lu_conditions; Type: ACL; Schema: clin_careplans; Owner: easygp
--

REVOKE ALL ON TABLE lu_conditions FROM PUBLIC;
REVOKE ALL ON TABLE lu_conditions FROM easygp;
GRANT ALL ON TABLE lu_conditions TO easygp;
GRANT ALL ON TABLE lu_conditions TO ian;


--
-- Name: lu_conditions_pk_seq; Type: ACL; Schema: clin_careplans; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_conditions_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_conditions_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_conditions_pk_seq TO easygp;


--
-- Name: lu_education; Type: ACL; Schema: clin_careplans; Owner: easygp
--

REVOKE ALL ON TABLE lu_education FROM PUBLIC;
REVOKE ALL ON TABLE lu_education FROM easygp;
GRANT ALL ON TABLE lu_education TO easygp;
GRANT ALL ON TABLE lu_education TO ian;


--
-- Name: lu_education_pk_seq; Type: ACL; Schema: clin_careplans; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_education_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_education_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_education_pk_seq TO easygp;


--
-- Name: lu_responsible; Type: ACL; Schema: clin_careplans; Owner: easygp
--

REVOKE ALL ON TABLE lu_responsible FROM PUBLIC;
REVOKE ALL ON TABLE lu_responsible FROM easygp;
GRANT ALL ON TABLE lu_responsible TO easygp;
GRANT ALL ON TABLE lu_responsible TO ian;


--
-- Name: lu_responsible_pk_seq; Type: ACL; Schema: clin_careplans; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_responsible_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_responsible_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_responsible_pk_seq TO easygp;


--
-- Name: lu_tasks; Type: ACL; Schema: clin_careplans; Owner: easygp
--

REVOKE ALL ON TABLE lu_tasks FROM PUBLIC;
REVOKE ALL ON TABLE lu_tasks FROM easygp;
GRANT ALL ON TABLE lu_tasks TO easygp;
GRANT ALL ON TABLE lu_tasks TO ian;


--
-- Name: lu_tasks_pk_seq; Type: ACL; Schema: clin_careplans; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_tasks_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_tasks_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_tasks_pk_seq TO easygp;


--
-- Name: sample_plan; Type: ACL; Schema: clin_careplans; Owner: easygp
--

REVOKE ALL ON TABLE sample_plan FROM PUBLIC;
REVOKE ALL ON TABLE sample_plan FROM easygp;
GRANT ALL ON TABLE sample_plan TO easygp;
GRANT ALL ON TABLE sample_plan TO ian;


--
-- Name: test; Type: ACL; Schema: clin_careplans; Owner: easygp
--

REVOKE ALL ON TABLE test FROM PUBLIC;
REVOKE ALL ON TABLE test FROM easygp;
GRANT ALL ON TABLE test TO easygp;
GRANT ALL ON TABLE test TO ian;


SET search_path = clin_certificates, pg_catalog;

--
-- Name: certificate_reasons; Type: ACL; Schema: clin_certificates; Owner: easygp
--

REVOKE ALL ON TABLE certificate_reasons FROM PUBLIC;
REVOKE ALL ON TABLE certificate_reasons FROM easygp;
GRANT ALL ON TABLE certificate_reasons TO easygp;
GRANT ALL ON TABLE certificate_reasons TO ian;


--
-- Name: lu_fitness; Type: ACL; Schema: clin_certificates; Owner: easygp
--

REVOKE ALL ON TABLE lu_fitness FROM PUBLIC;
REVOKE ALL ON TABLE lu_fitness FROM easygp;
GRANT ALL ON TABLE lu_fitness TO easygp;
GRANT ALL ON TABLE lu_fitness TO ian;


--
-- Name: lu_illness_temporality; Type: ACL; Schema: clin_certificates; Owner: easygp
--

REVOKE ALL ON TABLE lu_illness_temporality FROM PUBLIC;
REVOKE ALL ON TABLE lu_illness_temporality FROM easygp;
GRANT ALL ON TABLE lu_illness_temporality TO easygp;
GRANT ALL ON TABLE lu_illness_temporality TO ian;


--
-- Name: lu_illness_temporality_pk_seq; Type: ACL; Schema: clin_certificates; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_illness_temporality_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_illness_temporality_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_illness_temporality_pk_seq TO easygp;


--
-- Name: medical_certificates; Type: ACL; Schema: clin_certificates; Owner: easygp
--

REVOKE ALL ON TABLE medical_certificates FROM PUBLIC;
REVOKE ALL ON TABLE medical_certificates FROM easygp;
GRANT ALL ON TABLE medical_certificates TO easygp;
GRANT ALL ON TABLE medical_certificates TO ian;


--
-- Name: medical_certificate_pk_seq; Type: ACL; Schema: clin_certificates; Owner: easygp
--

REVOKE ALL ON SEQUENCE medical_certificate_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE medical_certificate_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE medical_certificate_pk_seq TO easygp;


--
-- Name: vwmedicalcertificates; Type: ACL; Schema: clin_certificates; Owner: easygp
--

REVOKE ALL ON TABLE vwmedicalcertificates FROM PUBLIC;
REVOKE ALL ON TABLE vwmedicalcertificates FROM easygp;
GRANT ALL ON TABLE vwmedicalcertificates TO easygp;
GRANT ALL ON TABLE vwmedicalcertificates TO ian;


SET search_path = clin_checkups, pg_catalog;

--
-- Name: annual_checkup; Type: ACL; Schema: clin_checkups; Owner: easygp
--

REVOKE ALL ON TABLE annual_checkup FROM PUBLIC;
REVOKE ALL ON TABLE annual_checkup FROM easygp;
GRANT ALL ON TABLE annual_checkup TO easygp;
GRANT ALL ON TABLE annual_checkup TO ian;


--
-- Name: annual_checkup_pk_seq; Type: ACL; Schema: clin_checkups; Owner: easygp
--

REVOKE ALL ON SEQUENCE annual_checkup_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE annual_checkup_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE annual_checkup_pk_seq TO easygp;


--
-- Name: lu_nutrition_questions; Type: ACL; Schema: clin_checkups; Owner: easygp
--

REVOKE ALL ON TABLE lu_nutrition_questions FROM PUBLIC;
REVOKE ALL ON TABLE lu_nutrition_questions FROM easygp;
GRANT ALL ON TABLE lu_nutrition_questions TO easygp;
GRANT ALL ON TABLE lu_nutrition_questions TO ian;


--
-- Name: lu_nutrition_questions_pk_seq; Type: ACL; Schema: clin_checkups; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_nutrition_questions_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_nutrition_questions_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_nutrition_questions_pk_seq TO easygp;


--
-- Name: lu_state_of_health; Type: ACL; Schema: clin_checkups; Owner: easygp
--

REVOKE ALL ON TABLE lu_state_of_health FROM PUBLIC;
REVOKE ALL ON TABLE lu_state_of_health FROM easygp;
GRANT ALL ON TABLE lu_state_of_health TO easygp;
GRANT ALL ON TABLE lu_state_of_health TO ian;


--
-- Name: lu_state_of_health_pk_seq; Type: ACL; Schema: clin_checkups; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_state_of_health_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_state_of_health_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_state_of_health_pk_seq TO easygp;


--
-- Name: over75; Type: ACL; Schema: clin_checkups; Owner: easygp
--

REVOKE ALL ON TABLE over75 FROM PUBLIC;
REVOKE ALL ON TABLE over75 FROM easygp;
GRANT ALL ON TABLE over75 TO easygp;
GRANT ALL ON TABLE over75 TO ian;


--
-- Name: over75_pk_seq; Type: ACL; Schema: clin_checkups; Owner: easygp
--

REVOKE ALL ON SEQUENCE over75_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE over75_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE over75_pk_seq TO easygp;


SET search_path = clin_consult, pg_catalog;

--
-- Name: consult_pk_seq; Type: ACL; Schema: clin_consult; Owner: easygp
--

REVOKE ALL ON SEQUENCE consult_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE consult_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE consult_pk_seq TO easygp;


--
-- Name: dictations; Type: ACL; Schema: clin_consult; Owner: easygp
--

REVOKE ALL ON TABLE dictations FROM PUBLIC;
REVOKE ALL ON TABLE dictations FROM easygp;
GRANT ALL ON TABLE dictations TO easygp;
GRANT ALL ON TABLE dictations TO staff;


--
-- Name: images; Type: ACL; Schema: clin_consult; Owner: easygp
--

REVOKE ALL ON TABLE images FROM PUBLIC;
REVOKE ALL ON TABLE images FROM easygp;
GRANT ALL ON TABLE images TO easygp;
GRANT ALL ON TABLE images TO ian;


--
-- Name: images_pk_seq; Type: ACL; Schema: clin_consult; Owner: easygp
--

REVOKE ALL ON SEQUENCE images_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE images_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE images_pk_seq TO easygp;


--
-- Name: lu_actions_pk_seq; Type: ACL; Schema: clin_consult; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_actions_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_actions_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_actions_pk_seq TO easygp;


--
-- Name: lu_audit_reasons_pk_seq; Type: ACL; Schema: clin_consult; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_audit_reasons_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_audit_reasons_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_audit_reasons_pk_seq TO easygp;


--
-- Name: lu_consult_type_pk_seq; Type: ACL; Schema: clin_consult; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_consult_type_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_consult_type_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_consult_type_pk_seq TO easygp;


--
-- Name: lu_progressnote_templates; Type: ACL; Schema: clin_consult; Owner: easygp
--

REVOKE ALL ON TABLE lu_progressnote_templates FROM PUBLIC;
REVOKE ALL ON TABLE lu_progressnote_templates FROM easygp;
GRANT ALL ON TABLE lu_progressnote_templates TO easygp;
GRANT ALL ON TABLE lu_progressnote_templates TO ian;


--
-- Name: lu_progressnote_templates_pk_seq; Type: ACL; Schema: clin_consult; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_progressnote_templates_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_progressnote_templates_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_progressnote_templates_pk_seq TO easygp;


--
-- Name: lu_progressnotes_sections_pk_seq; Type: ACL; Schema: clin_consult; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_progressnotes_sections_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_progressnotes_sections_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_progressnotes_sections_pk_seq TO easygp;


--
-- Name: lu_scratchpad_status; Type: ACL; Schema: clin_consult; Owner: easygp
--

REVOKE ALL ON TABLE lu_scratchpad_status FROM PUBLIC;
REVOKE ALL ON TABLE lu_scratchpad_status FROM easygp;
GRANT ALL ON TABLE lu_scratchpad_status TO easygp;
GRANT ALL ON TABLE lu_scratchpad_status TO ian;


--
-- Name: lu_scratchpad_status_pk_seq; Type: ACL; Schema: clin_consult; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_scratchpad_status_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_scratchpad_status_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_scratchpad_status_pk_seq TO easygp;


--
-- Name: progressnotes_pk_seq; Type: ACL; Schema: clin_consult; Owner: easygp
--

REVOKE ALL ON SEQUENCE progressnotes_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE progressnotes_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE progressnotes_pk_seq TO easygp;


--
-- Name: scratchpad; Type: ACL; Schema: clin_consult; Owner: easygp
--

REVOKE ALL ON TABLE scratchpad FROM PUBLIC;
REVOKE ALL ON TABLE scratchpad FROM easygp;
GRANT ALL ON TABLE scratchpad TO easygp;
GRANT ALL ON TABLE scratchpad TO ian;


--
-- Name: scratchpad_pk_seq; Type: ACL; Schema: clin_consult; Owner: easygp
--

REVOKE ALL ON SEQUENCE scratchpad_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE scratchpad_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE scratchpad_pk_seq TO easygp;


SET search_path = clin_referrals, pg_catalog;

--
-- Name: referrals; Type: ACL; Schema: clin_referrals; Owner: easygp
--

REVOKE ALL ON TABLE referrals FROM PUBLIC;
REVOKE ALL ON TABLE referrals FROM easygp;
GRANT ALL ON TABLE referrals TO easygp;
GRANT ALL ON TABLE referrals TO ian;


SET search_path = clin_consult, pg_catalog;

--
-- Name: vwpatientconsults; Type: ACL; Schema: clin_consult; Owner: easygp
--

REVOKE ALL ON TABLE vwpatientconsults FROM PUBLIC;
REVOKE ALL ON TABLE vwpatientconsults FROM easygp;
GRANT ALL ON TABLE vwpatientconsults TO easygp;
GRANT ALL ON TABLE vwpatientconsults TO ian;


--
-- Name: vwprogressnotes1; Type: ACL; Schema: clin_consult; Owner: easygp
--

REVOKE ALL ON TABLE vwprogressnotes1 FROM PUBLIC;
REVOKE ALL ON TABLE vwprogressnotes1 FROM easygp;
GRANT ALL ON TABLE vwprogressnotes1 TO easygp;
GRANT ALL ON TABLE vwprogressnotes1 TO ian;


--
-- Name: vwscratchpad; Type: ACL; Schema: clin_consult; Owner: easygp
--

REVOKE ALL ON TABLE vwscratchpad FROM PUBLIC;
REVOKE ALL ON TABLE vwscratchpad FROM easygp;
GRANT ALL ON TABLE vwscratchpad TO easygp;
GRANT ALL ON TABLE vwscratchpad TO ian;


SET search_path = clin_history, pg_catalog;

--
-- Name: care_plan_components; Type: ACL; Schema: clin_history; Owner: easygp
--

REVOKE ALL ON TABLE care_plan_components FROM PUBLIC;
REVOKE ALL ON TABLE care_plan_components FROM easygp;
GRANT ALL ON TABLE care_plan_components TO easygp;
GRANT ALL ON TABLE care_plan_components TO ian;


--
-- Name: care_plan_components_due; Type: ACL; Schema: clin_history; Owner: easygp
--

REVOKE ALL ON TABLE care_plan_components_due FROM PUBLIC;
REVOKE ALL ON TABLE care_plan_components_due FROM easygp;
GRANT ALL ON TABLE care_plan_components_due TO easygp;
GRANT ALL ON TABLE care_plan_components_due TO ian;


--
-- Name: care_plan_components_due_pk_seq; Type: ACL; Schema: clin_history; Owner: easygp
--

REVOKE ALL ON SEQUENCE care_plan_components_due_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE care_plan_components_due_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE care_plan_components_due_pk_seq TO easygp;


--
-- Name: family_conditions; Type: ACL; Schema: clin_history; Owner: easygp
--

REVOKE ALL ON TABLE family_conditions FROM PUBLIC;
REVOKE ALL ON TABLE family_conditions FROM easygp;
GRANT ALL ON TABLE family_conditions TO easygp;
GRANT ALL ON TABLE family_conditions TO ian;


--
-- Name: family_conditions_pk_seq; Type: ACL; Schema: clin_history; Owner: easygp
--

REVOKE ALL ON SEQUENCE family_conditions_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE family_conditions_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE family_conditions_pk_seq TO easygp;


--
-- Name: family_links; Type: ACL; Schema: clin_history; Owner: easygp
--

REVOKE ALL ON TABLE family_links FROM PUBLIC;
REVOKE ALL ON TABLE family_links FROM easygp;
GRANT ALL ON TABLE family_links TO easygp;
GRANT ALL ON TABLE family_links TO ian;


--
-- Name: family_links_pk_seq; Type: ACL; Schema: clin_history; Owner: easygp
--

REVOKE ALL ON SEQUENCE family_links_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE family_links_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE family_links_pk_seq TO easygp;


--
-- Name: family_members; Type: ACL; Schema: clin_history; Owner: easygp
--

REVOKE ALL ON TABLE family_members FROM PUBLIC;
REVOKE ALL ON TABLE family_members FROM easygp;
GRANT ALL ON TABLE family_members TO easygp;
GRANT ALL ON TABLE family_members TO ian;


--
-- Name: family_members_pk_seq; Type: ACL; Schema: clin_history; Owner: easygp
--

REVOKE ALL ON SEQUENCE family_members_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE family_members_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE family_members_pk_seq TO easygp;


--
-- Name: hospitalisations; Type: ACL; Schema: clin_history; Owner: easygp
--

REVOKE ALL ON TABLE hospitalisations FROM PUBLIC;
REVOKE ALL ON TABLE hospitalisations FROM easygp;
GRANT ALL ON TABLE hospitalisations TO easygp;
GRANT ALL ON TABLE hospitalisations TO ian;


--
-- Name: hospitalisations_pk_seq; Type: ACL; Schema: clin_history; Owner: easygp
--

REVOKE ALL ON SEQUENCE hospitalisations_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE hospitalisations_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE hospitalisations_pk_seq TO easygp;


--
-- Name: lu_careplan_components; Type: ACL; Schema: clin_history; Owner: easygp
--

REVOKE ALL ON TABLE lu_careplan_components FROM PUBLIC;
REVOKE ALL ON TABLE lu_careplan_components FROM easygp;
GRANT ALL ON TABLE lu_careplan_components TO easygp;
GRANT ALL ON TABLE lu_careplan_components TO ian;


--
-- Name: lu_dacc_components; Type: ACL; Schema: clin_history; Owner: easygp
--

REVOKE ALL ON TABLE lu_dacc_components FROM PUBLIC;
REVOKE ALL ON TABLE lu_dacc_components FROM easygp;
GRANT ALL ON TABLE lu_dacc_components TO easygp;
GRANT ALL ON TABLE lu_dacc_components TO ian;


--
-- Name: lu_dacc_components_pk_seq; Type: ACL; Schema: clin_history; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_dacc_components_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_dacc_components_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_dacc_components_pk_seq TO easygp;


--
-- Name: lu_exposures; Type: ACL; Schema: clin_history; Owner: easygp
--

REVOKE ALL ON TABLE lu_exposures FROM PUBLIC;
REVOKE ALL ON TABLE lu_exposures FROM easygp;
GRANT ALL ON TABLE lu_exposures TO easygp;
GRANT ALL ON TABLE lu_exposures TO ian;


--
-- Name: lu_exposures_pk_seq; Type: ACL; Schema: clin_history; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_exposures_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_exposures_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_exposures_pk_seq TO easygp;


--
-- Name: occupational_history; Type: ACL; Schema: clin_history; Owner: easygp
--

REVOKE ALL ON TABLE occupational_history FROM PUBLIC;
REVOKE ALL ON TABLE occupational_history FROM easygp;
GRANT ALL ON TABLE occupational_history TO easygp;
GRANT ALL ON TABLE occupational_history TO ian;


--
-- Name: occupational_history_pk_seq; Type: ACL; Schema: clin_history; Owner: easygp
--

REVOKE ALL ON SEQUENCE occupational_history_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE occupational_history_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE occupational_history_pk_seq TO easygp;


--
-- Name: occupations_exposures; Type: ACL; Schema: clin_history; Owner: easygp
--

REVOKE ALL ON TABLE occupations_exposures FROM PUBLIC;
REVOKE ALL ON TABLE occupations_exposures FROM easygp;
GRANT ALL ON TABLE occupations_exposures TO easygp;
GRANT ALL ON TABLE occupations_exposures TO ian;


--
-- Name: occupations_exposures_pk_seq; Type: ACL; Schema: clin_history; Owner: easygp
--

REVOKE ALL ON SEQUENCE occupations_exposures_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE occupations_exposures_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE occupations_exposures_pk_seq TO easygp;


--
-- Name: past_history; Type: ACL; Schema: clin_history; Owner: easygp
--

REVOKE ALL ON TABLE past_history FROM PUBLIC;
REVOKE ALL ON TABLE past_history FROM easygp;
GRANT ALL ON TABLE past_history TO easygp;
GRANT ALL ON TABLE past_history TO ian;


--
-- Name: past_history_pk_seq; Type: ACL; Schema: clin_history; Owner: easygp
--

REVOKE ALL ON SEQUENCE past_history_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE past_history_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE past_history_pk_seq TO easygp;


--
-- Name: recreational_drugs; Type: ACL; Schema: clin_history; Owner: easygp
--

REVOKE ALL ON TABLE recreational_drugs FROM PUBLIC;
REVOKE ALL ON TABLE recreational_drugs FROM easygp;
GRANT ALL ON TABLE recreational_drugs TO easygp;
GRANT SELECT ON TABLE recreational_drugs TO staff;


--
-- Name: social_history; Type: ACL; Schema: clin_history; Owner: easygp
--

REVOKE ALL ON TABLE social_history FROM PUBLIC;
REVOKE ALL ON TABLE social_history FROM easygp;
GRANT ALL ON TABLE social_history TO easygp;
GRANT ALL ON TABLE social_history TO ian;


--
-- Name: social_history_pk_seq; Type: ACL; Schema: clin_history; Owner: easygp
--

REVOKE ALL ON SEQUENCE social_history_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE social_history_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE social_history_pk_seq TO easygp;


--
-- Name: team_care_members; Type: ACL; Schema: clin_history; Owner: easygp
--

REVOKE ALL ON TABLE team_care_members FROM PUBLIC;
REVOKE ALL ON TABLE team_care_members FROM easygp;
GRANT ALL ON TABLE team_care_members TO easygp;
GRANT ALL ON TABLE team_care_members TO ian;


--
-- Name: team_care_members_pk_seq; Type: ACL; Schema: clin_history; Owner: easygp
--

REVOKE ALL ON SEQUENCE team_care_members_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE team_care_members_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE team_care_members_pk_seq TO easygp;


SET search_path = clin_recalls, pg_catalog;

--
-- Name: lu_reasons; Type: ACL; Schema: clin_recalls; Owner: easygp
--

REVOKE ALL ON TABLE lu_reasons FROM PUBLIC;
REVOKE ALL ON TABLE lu_reasons FROM easygp;
GRANT ALL ON TABLE lu_reasons TO easygp;
GRANT ALL ON TABLE lu_reasons TO ian;


--
-- Name: lu_recall_intervals; Type: ACL; Schema: clin_recalls; Owner: easygp
--

REVOKE ALL ON TABLE lu_recall_intervals FROM PUBLIC;
REVOKE ALL ON TABLE lu_recall_intervals FROM easygp;
GRANT ALL ON TABLE lu_recall_intervals TO easygp;
GRANT ALL ON TABLE lu_recall_intervals TO ian;


--
-- Name: lu_templates; Type: ACL; Schema: clin_recalls; Owner: easygp
--

REVOKE ALL ON TABLE lu_templates FROM PUBLIC;
REVOKE ALL ON TABLE lu_templates FROM easygp;
GRANT ALL ON TABLE lu_templates TO easygp;
GRANT ALL ON TABLE lu_templates TO ian;


--
-- Name: recalls; Type: ACL; Schema: clin_recalls; Owner: easygp
--

REVOKE ALL ON TABLE recalls FROM PUBLIC;
REVOKE ALL ON TABLE recalls FROM easygp;
GRANT ALL ON TABLE recalls TO easygp;
GRANT ALL ON TABLE recalls TO ian;


--
-- Name: sent; Type: ACL; Schema: clin_recalls; Owner: easygp
--

REVOKE ALL ON TABLE sent FROM PUBLIC;
REVOKE ALL ON TABLE sent FROM easygp;
GRANT ALL ON TABLE sent TO easygp;
GRANT ALL ON TABLE sent TO ian;


SET search_path = common, pg_catalog;

--
-- Name: lu_appointment_length_pk_seq; Type: ACL; Schema: common; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_appointment_length_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_appointment_length_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_appointment_length_pk_seq TO easygp;


--
-- Name: lu_appointment_length; Type: ACL; Schema: common; Owner: easygp
--

REVOKE ALL ON TABLE lu_appointment_length FROM PUBLIC;
REVOKE ALL ON TABLE lu_appointment_length FROM easygp;
GRANT ALL ON TABLE lu_appointment_length TO easygp;
GRANT ALL ON TABLE lu_appointment_length TO ian;


--
-- Name: lu_units; Type: ACL; Schema: common; Owner: easygp
--

REVOKE ALL ON TABLE lu_units FROM PUBLIC;
REVOKE ALL ON TABLE lu_units FROM easygp;
GRANT ALL ON TABLE lu_units TO easygp;
GRANT ALL ON TABLE lu_units TO ian;


SET search_path = contacts, pg_catalog;

--
-- Name: lu_contact_type; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE lu_contact_type FROM PUBLIC;
REVOKE ALL ON TABLE lu_contact_type FROM easygp;
GRANT ALL ON TABLE lu_contact_type TO easygp;
GRANT ALL ON TABLE lu_contact_type TO ian;


SET search_path = clin_recalls, pg_catalog;

--
-- Name: vwrecalls; Type: ACL; Schema: clin_recalls; Owner: easygp
--

REVOKE ALL ON TABLE vwrecalls FROM PUBLIC;
REVOKE ALL ON TABLE vwrecalls FROM easygp;
GRANT ALL ON TABLE vwrecalls TO easygp;
GRANT ALL ON TABLE vwrecalls TO ian;


SET search_path = clin_history, pg_catalog;

--
-- Name: vwcareplancomponents; Type: ACL; Schema: clin_history; Owner: easygp
--

REVOKE ALL ON TABLE vwcareplancomponents FROM PUBLIC;
REVOKE ALL ON TABLE vwcareplancomponents FROM easygp;
GRANT ALL ON TABLE vwcareplancomponents TO easygp;
GRANT ALL ON TABLE vwcareplancomponents TO ian;


--
-- Name: vwcareplancomponentsdue; Type: ACL; Schema: clin_history; Owner: easygp
--

REVOKE ALL ON TABLE vwcareplancomponentsdue FROM PUBLIC;
REVOKE ALL ON TABLE vwcareplancomponentsdue FROM easygp;
GRANT ALL ON TABLE vwcareplancomponentsdue TO easygp;
GRANT ALL ON TABLE vwcareplancomponentsdue TO ian;


SET search_path = common, pg_catalog;

--
-- Name: lu_family_relationships; Type: ACL; Schema: common; Owner: easygp
--

REVOKE ALL ON TABLE lu_family_relationships FROM PUBLIC;
REVOKE ALL ON TABLE lu_family_relationships FROM easygp;
GRANT ALL ON TABLE lu_family_relationships TO easygp;
GRANT ALL ON TABLE lu_family_relationships TO ian;


SET search_path = clin_history, pg_catalog;

--
-- Name: vwfamilyhistory; Type: ACL; Schema: clin_history; Owner: easygp
--

REVOKE ALL ON TABLE vwfamilyhistory FROM PUBLIC;
REVOKE ALL ON TABLE vwfamilyhistory FROM easygp;
GRANT ALL ON TABLE vwfamilyhistory TO easygp;
GRANT ALL ON TABLE vwfamilyhistory TO staff;


SET search_path = common, pg_catalog;

--
-- Name: lu_laterality; Type: ACL; Schema: common; Owner: easygp
--

REVOKE ALL ON TABLE lu_laterality FROM PUBLIC;
REVOKE ALL ON TABLE lu_laterality FROM easygp;
GRANT ALL ON TABLE lu_laterality TO easygp;
GRANT ALL ON TABLE lu_laterality TO ian;


SET search_path = clin_history, pg_catalog;

--
-- Name: vwhealthissues; Type: ACL; Schema: clin_history; Owner: easygp
--

REVOKE ALL ON TABLE vwhealthissues FROM PUBLIC;
REVOKE ALL ON TABLE vwhealthissues FROM easygp;
GRANT ALL ON TABLE vwhealthissues TO easygp;
GRANT ALL ON TABLE vwhealthissues TO ian;


--
-- Name: vwoccupationalhistory; Type: ACL; Schema: clin_history; Owner: easygp
--

REVOKE ALL ON TABLE vwoccupationalhistory FROM PUBLIC;
REVOKE ALL ON TABLE vwoccupationalhistory FROM easygp;
GRANT ALL ON TABLE vwoccupationalhistory TO easygp;
GRANT ALL ON TABLE vwoccupationalhistory TO ian;


SET search_path = common, pg_catalog;

--
-- Name: lu_recreational_drugs; Type: ACL; Schema: common; Owner: easygp
--

REVOKE ALL ON TABLE lu_recreational_drugs FROM PUBLIC;
REVOKE ALL ON TABLE lu_recreational_drugs FROM easygp;
GRANT ALL ON TABLE lu_recreational_drugs TO easygp;
GRANT SELECT ON TABLE lu_recreational_drugs TO staff;


--
-- Name: lu_route_administration; Type: ACL; Schema: common; Owner: easygp
--

REVOKE ALL ON TABLE lu_route_administration FROM PUBLIC;
REVOKE ALL ON TABLE lu_route_administration FROM easygp;
GRANT ALL ON TABLE lu_route_administration TO easygp;
GRANT ALL ON TABLE lu_route_administration TO ian;


SET search_path = clin_history, pg_catalog;

--
-- Name: vwrecreationaldrugsused; Type: ACL; Schema: clin_history; Owner: easygp
--

REVOKE ALL ON TABLE vwrecreationaldrugsused FROM PUBLIC;
REVOKE ALL ON TABLE vwrecreationaldrugsused FROM easygp;
GRANT ALL ON TABLE vwrecreationaldrugsused TO easygp;
GRANT SELECT ON TABLE vwrecreationaldrugsused TO staff;


--
-- Name: vwsocialhistory; Type: ACL; Schema: clin_history; Owner: easygp
--

REVOKE ALL ON TABLE vwsocialhistory FROM PUBLIC;
REVOKE ALL ON TABLE vwsocialhistory FROM easygp;
GRANT ALL ON TABLE vwsocialhistory TO easygp;
GRANT ALL ON TABLE vwsocialhistory TO ian;


SET search_path = contacts, pg_catalog;

--
-- Name: vworganisationsemployees; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE vworganisationsemployees FROM PUBLIC;
REVOKE ALL ON TABLE vworganisationsemployees FROM easygp;
GRANT ALL ON TABLE vworganisationsemployees TO easygp;
GRANT ALL ON TABLE vworganisationsemployees TO ian;


SET search_path = clin_history, pg_catalog;

--
-- Name: vwteamcaremembers; Type: ACL; Schema: clin_history; Owner: easygp
--

REVOKE ALL ON TABLE vwteamcaremembers FROM PUBLIC;
REVOKE ALL ON TABLE vwteamcaremembers FROM easygp;
GRANT ALL ON TABLE vwteamcaremembers TO easygp;
GRANT ALL ON TABLE vwteamcaremembers TO ian;


SET search_path = clin_measurements, pg_catalog;

--
-- Name: lu_type; Type: ACL; Schema: clin_measurements; Owner: easygp
--

REVOKE ALL ON TABLE lu_type FROM PUBLIC;
REVOKE ALL ON TABLE lu_type FROM easygp;
GRANT ALL ON TABLE lu_type TO easygp;
GRANT ALL ON TABLE lu_type TO ian;


--
-- Name: lu_type_pk_seq; Type: ACL; Schema: clin_measurements; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_type_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_type_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_type_pk_seq TO easygp;


--
-- Name: measurements; Type: ACL; Schema: clin_measurements; Owner: easygp
--

REVOKE ALL ON TABLE measurements FROM PUBLIC;
REVOKE ALL ON TABLE measurements FROM easygp;
GRANT ALL ON TABLE measurements TO easygp;
GRANT ALL ON TABLE measurements TO ian;


--
-- Name: measurements_pk_seq; Type: ACL; Schema: clin_measurements; Owner: easygp
--

REVOKE ALL ON SEQUENCE measurements_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE measurements_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE measurements_pk_seq TO easygp;


--
-- Name: patients_defaults; Type: ACL; Schema: clin_measurements; Owner: easygp
--

REVOKE ALL ON TABLE patients_defaults FROM PUBLIC;
REVOKE ALL ON TABLE patients_defaults FROM easygp;
GRANT ALL ON TABLE patients_defaults TO easygp;
GRANT ALL ON TABLE patients_defaults TO ian;


--
-- Name: patients_defaults_pk_seq; Type: ACL; Schema: clin_measurements; Owner: easygp
--

REVOKE ALL ON SEQUENCE patients_defaults_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE patients_defaults_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE patients_defaults_pk_seq TO easygp;


--
-- Name: vwmeasurements; Type: ACL; Schema: clin_measurements; Owner: easygp
--

REVOKE ALL ON TABLE vwmeasurements FROM PUBLIC;
REVOKE ALL ON TABLE vwmeasurements FROM easygp;
GRANT ALL ON TABLE vwmeasurements TO easygp;
GRANT ALL ON TABLE vwmeasurements TO ian;


--
-- Name: vwbpmostrecent; Type: ACL; Schema: clin_measurements; Owner: easygp
--

REVOKE ALL ON TABLE vwbpmostrecent FROM PUBLIC;
REVOKE ALL ON TABLE vwbpmostrecent FROM easygp;
GRANT ALL ON TABLE vwbpmostrecent TO easygp;
GRANT ALL ON TABLE vwbpmostrecent TO ian;


--
-- Name: vwheightmostrecent; Type: ACL; Schema: clin_measurements; Owner: easygp
--

REVOKE ALL ON TABLE vwheightmostrecent FROM PUBLIC;
REVOKE ALL ON TABLE vwheightmostrecent FROM easygp;
GRANT ALL ON TABLE vwheightmostrecent TO easygp;
GRANT ALL ON TABLE vwheightmostrecent TO ian;


--
-- Name: vwmeasurementtypes; Type: ACL; Schema: clin_measurements; Owner: easygp
--

REVOKE ALL ON TABLE vwmeasurementtypes FROM PUBLIC;
REVOKE ALL ON TABLE vwmeasurementtypes FROM easygp;
GRANT ALL ON TABLE vwmeasurementtypes TO easygp;
GRANT ALL ON TABLE vwmeasurementtypes TO ian;


--
-- Name: vwpatientsdefaults; Type: ACL; Schema: clin_measurements; Owner: easygp
--

REVOKE ALL ON TABLE vwpatientsdefaults FROM PUBLIC;
REVOKE ALL ON TABLE vwpatientsdefaults FROM easygp;
GRANT ALL ON TABLE vwpatientsdefaults TO easygp;
GRANT ALL ON TABLE vwpatientsdefaults TO ian;


--
-- Name: vwweightmostrecent; Type: ACL; Schema: clin_measurements; Owner: easygp
--

REVOKE ALL ON TABLE vwweightmostrecent FROM PUBLIC;
REVOKE ALL ON TABLE vwweightmostrecent FROM easygp;
GRANT ALL ON TABLE vwweightmostrecent TO easygp;
GRANT ALL ON TABLE vwweightmostrecent TO ian;


SET search_path = clin_mentalhealth, pg_catalog;

--
-- Name: k10_results; Type: ACL; Schema: clin_mentalhealth; Owner: easygp
--

REVOKE ALL ON TABLE k10_results FROM PUBLIC;
REVOKE ALL ON TABLE k10_results FROM easygp;
GRANT ALL ON TABLE k10_results TO easygp;
GRANT ALL ON TABLE k10_results TO ian;


--
-- Name: k10_results_pk_seq; Type: ACL; Schema: clin_mentalhealth; Owner: easygp
--

REVOKE ALL ON SEQUENCE k10_results_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE k10_results_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE k10_results_pk_seq TO easygp;


--
-- Name: lu_assessment_tools; Type: ACL; Schema: clin_mentalhealth; Owner: easygp
--

REVOKE ALL ON TABLE lu_assessment_tools FROM PUBLIC;
REVOKE ALL ON TABLE lu_assessment_tools FROM easygp;
GRANT ALL ON TABLE lu_assessment_tools TO easygp;
GRANT ALL ON TABLE lu_assessment_tools TO ian;


--
-- Name: lu_component_help; Type: ACL; Schema: clin_mentalhealth; Owner: easygp
--

REVOKE ALL ON TABLE lu_component_help FROM PUBLIC;
REVOKE ALL ON TABLE lu_component_help FROM easygp;
GRANT ALL ON TABLE lu_component_help TO easygp;
GRANT ALL ON TABLE lu_component_help TO ian;


--
-- Name: lu_component_help_pk_seq; Type: ACL; Schema: clin_mentalhealth; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_component_help_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_component_help_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_component_help_pk_seq TO easygp;


--
-- Name: lu_depression_degree; Type: ACL; Schema: clin_mentalhealth; Owner: easygp
--

REVOKE ALL ON TABLE lu_depression_degree FROM PUBLIC;
REVOKE ALL ON TABLE lu_depression_degree FROM easygp;
GRANT ALL ON TABLE lu_depression_degree TO easygp;
GRANT ALL ON TABLE lu_depression_degree TO ian;


--
-- Name: lu_depression_degree_pk_seq; Type: ACL; Schema: clin_mentalhealth; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_depression_degree_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_depression_degree_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_depression_degree_pk_seq TO easygp;


--
-- Name: lu_k10_components; Type: ACL; Schema: clin_mentalhealth; Owner: easygp
--

REVOKE ALL ON TABLE lu_k10_components FROM PUBLIC;
REVOKE ALL ON TABLE lu_k10_components FROM easygp;
GRANT ALL ON TABLE lu_k10_components TO easygp;
GRANT ALL ON TABLE lu_k10_components TO ian;


--
-- Name: lu_k10_components_pk_seq; Type: ACL; Schema: clin_mentalhealth; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_k10_components_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_k10_components_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_k10_components_pk_seq TO easygp;


--
-- Name: lu_plan_type; Type: ACL; Schema: clin_mentalhealth; Owner: easygp
--

REVOKE ALL ON TABLE lu_plan_type FROM PUBLIC;
REVOKE ALL ON TABLE lu_plan_type FROM easygp;
GRANT ALL ON TABLE lu_plan_type TO easygp;
GRANT ALL ON TABLE lu_plan_type TO ian;


--
-- Name: lu_plan_type_pk_seq; Type: ACL; Schema: clin_mentalhealth; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_plan_type_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_plan_type_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_plan_type_pk_seq TO easygp;


--
-- Name: lu_risk_to_others; Type: ACL; Schema: clin_mentalhealth; Owner: easygp
--

REVOKE ALL ON TABLE lu_risk_to_others FROM PUBLIC;
REVOKE ALL ON TABLE lu_risk_to_others FROM easygp;
GRANT ALL ON TABLE lu_risk_to_others TO easygp;
GRANT ALL ON TABLE lu_risk_to_others TO ian;


--
-- Name: lu_risk_to_others_pk_seq; Type: ACL; Schema: clin_mentalhealth; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_risk_to_others_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_risk_to_others_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_risk_to_others_pk_seq TO easygp;


--
-- Name: mentalhealth_plan; Type: ACL; Schema: clin_mentalhealth; Owner: easygp
--

REVOKE ALL ON TABLE mentalhealth_plan FROM PUBLIC;
REVOKE ALL ON TABLE mentalhealth_plan FROM easygp;
GRANT ALL ON TABLE mentalhealth_plan TO easygp;
GRANT ALL ON TABLE mentalhealth_plan TO ian;


--
-- Name: mentalhealth_plan_pk_seq; Type: ACL; Schema: clin_mentalhealth; Owner: easygp
--

REVOKE ALL ON SEQUENCE mentalhealth_plan_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE mentalhealth_plan_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE mentalhealth_plan_pk_seq TO easygp;


--
-- Name: team_care_members; Type: ACL; Schema: clin_mentalhealth; Owner: easygp
--

REVOKE ALL ON TABLE team_care_members FROM PUBLIC;
REVOKE ALL ON TABLE team_care_members FROM easygp;
GRANT ALL ON TABLE team_care_members TO easygp;
GRANT ALL ON TABLE team_care_members TO ian;


--
-- Name: team_care_members_pk_seq; Type: ACL; Schema: clin_mentalhealth; Owner: easygp
--

REVOKE ALL ON SEQUENCE team_care_members_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE team_care_members_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE team_care_members_pk_seq TO easygp;


--
-- Name: vwk10results; Type: ACL; Schema: clin_mentalhealth; Owner: easygp
--

REVOKE ALL ON TABLE vwk10results FROM PUBLIC;
REVOKE ALL ON TABLE vwk10results FROM easygp;
GRANT ALL ON TABLE vwk10results TO easygp;
GRANT ALL ON TABLE vwk10results TO ian;


--
-- Name: vwmentalhealthplans; Type: ACL; Schema: clin_mentalhealth; Owner: easygp
--

REVOKE ALL ON TABLE vwmentalhealthplans FROM PUBLIC;
REVOKE ALL ON TABLE vwmentalhealthplans FROM easygp;
GRANT ALL ON TABLE vwmentalhealthplans TO easygp;
GRANT ALL ON TABLE vwmentalhealthplans TO ian;


--
-- Name: vwteamcaremembers; Type: ACL; Schema: clin_mentalhealth; Owner: easygp
--

REVOKE ALL ON TABLE vwteamcaremembers FROM PUBLIC;
REVOKE ALL ON TABLE vwteamcaremembers FROM easygp;
GRANT ALL ON TABLE vwteamcaremembers TO easygp;
GRANT ALL ON TABLE vwteamcaremembers TO ian;


SET search_path = clin_pregnancy, pg_catalog;

--
-- Name: lu_antenatal_venue; Type: ACL; Schema: clin_pregnancy; Owner: easygp
--

REVOKE ALL ON TABLE lu_antenatal_venue FROM PUBLIC;
REVOKE ALL ON TABLE lu_antenatal_venue FROM easygp;
GRANT ALL ON TABLE lu_antenatal_venue TO easygp;
GRANT ALL ON TABLE lu_antenatal_venue TO ian;


--
-- Name: lu_antenatal_venue_pk_seq; Type: ACL; Schema: clin_pregnancy; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_antenatal_venue_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_antenatal_venue_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_antenatal_venue_pk_seq TO easygp;


SET search_path = clin_prescribing, pg_catalog;

--
-- Name: authority_script_number; Type: ACL; Schema: clin_prescribing; Owner: easygp
--

REVOKE ALL ON TABLE authority_script_number FROM PUBLIC;
REVOKE ALL ON TABLE authority_script_number FROM easygp;
GRANT ALL ON TABLE authority_script_number TO easygp;
GRANT ALL ON TABLE authority_script_number TO ian;


--
-- Name: increased_quantity_authority_reasons; Type: ACL; Schema: clin_prescribing; Owner: easygp
--

REVOKE ALL ON TABLE increased_quantity_authority_reasons FROM PUBLIC;
REVOKE ALL ON TABLE increased_quantity_authority_reasons FROM easygp;
GRANT ALL ON TABLE increased_quantity_authority_reasons TO easygp;
GRANT ALL ON TABLE increased_quantity_authority_reasons TO ian;


--
-- Name: increased_quantity_authority_reasons_pk_seq; Type: ACL; Schema: clin_prescribing; Owner: easygp
--

REVOKE ALL ON SEQUENCE increased_quantity_authority_reasons_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE increased_quantity_authority_reasons_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE increased_quantity_authority_reasons_pk_seq TO easygp;


--
-- Name: instruction_habits; Type: ACL; Schema: clin_prescribing; Owner: easygp
--

REVOKE ALL ON TABLE instruction_habits FROM PUBLIC;
REVOKE ALL ON TABLE instruction_habits FROM easygp;
GRANT ALL ON TABLE instruction_habits TO easygp;
GRANT ALL ON TABLE instruction_habits TO ian;


--
-- Name: instruction_habits_pk_seq; Type: ACL; Schema: clin_prescribing; Owner: easygp
--

REVOKE ALL ON SEQUENCE instruction_habits_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE instruction_habits_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE instruction_habits_pk_seq TO easygp;


--
-- Name: instructions; Type: ACL; Schema: clin_prescribing; Owner: easygp
--

REVOKE ALL ON TABLE instructions FROM PUBLIC;
REVOKE ALL ON TABLE instructions FROM easygp;
GRANT ALL ON TABLE instructions TO easygp;
GRANT ALL ON TABLE instructions TO ian;


--
-- Name: instructions_pk_seq; Type: ACL; Schema: clin_prescribing; Owner: easygp
--

REVOKE ALL ON SEQUENCE instructions_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE instructions_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE instructions_pk_seq TO easygp;


--
-- Name: lu_pbs_script_type; Type: ACL; Schema: clin_prescribing; Owner: easygp
--

REVOKE ALL ON TABLE lu_pbs_script_type FROM PUBLIC;
REVOKE ALL ON TABLE lu_pbs_script_type FROM easygp;
GRANT ALL ON TABLE lu_pbs_script_type TO easygp;
GRANT ALL ON TABLE lu_pbs_script_type TO ian;


--
-- Name: medications; Type: ACL; Schema: clin_prescribing; Owner: easygp
--

REVOKE ALL ON TABLE medications FROM PUBLIC;
REVOKE ALL ON TABLE medications FROM easygp;
GRANT ALL ON TABLE medications TO easygp;
GRANT ALL ON TABLE medications TO ian;


--
-- Name: medications_pk_seq; Type: ACL; Schema: clin_prescribing; Owner: easygp
--

REVOKE ALL ON SEQUENCE medications_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE medications_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE medications_pk_seq TO easygp;


--
-- Name: prescribed; Type: ACL; Schema: clin_prescribing; Owner: easygp
--

REVOKE ALL ON TABLE prescribed FROM PUBLIC;
REVOKE ALL ON TABLE prescribed FROM easygp;
GRANT ALL ON TABLE prescribed TO easygp;
GRANT ALL ON TABLE prescribed TO ian;


--
-- Name: prescribed_for; Type: ACL; Schema: clin_prescribing; Owner: easygp
--

REVOKE ALL ON TABLE prescribed_for FROM PUBLIC;
REVOKE ALL ON TABLE prescribed_for FROM easygp;
GRANT ALL ON TABLE prescribed_for TO easygp;
GRANT ALL ON TABLE prescribed_for TO ian;


--
-- Name: prescribed_for_habits; Type: ACL; Schema: clin_prescribing; Owner: easygp
--

REVOKE ALL ON TABLE prescribed_for_habits FROM PUBLIC;
REVOKE ALL ON TABLE prescribed_for_habits FROM easygp;
GRANT ALL ON TABLE prescribed_for_habits TO easygp;
GRANT ALL ON TABLE prescribed_for_habits TO ian;


--
-- Name: prescribed_for_habits_pk_seq; Type: ACL; Schema: clin_prescribing; Owner: easygp
--

REVOKE ALL ON SEQUENCE prescribed_for_habits_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE prescribed_for_habits_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE prescribed_for_habits_pk_seq TO easygp;


--
-- Name: prescribed_for_pk_seq; Type: ACL; Schema: clin_prescribing; Owner: easygp
--

REVOKE ALL ON SEQUENCE prescribed_for_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE prescribed_for_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE prescribed_for_pk_seq TO easygp;


--
-- Name: prescribed_pk_seq; Type: ACL; Schema: clin_prescribing; Owner: easygp
--

REVOKE ALL ON SEQUENCE prescribed_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE prescribed_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE prescribed_pk_seq TO easygp;


--
-- Name: print_status_pk_seq; Type: ACL; Schema: clin_prescribing; Owner: easygp
--

REVOKE ALL ON SEQUENCE print_status_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE print_status_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE print_status_pk_seq TO easygp;


--
-- Name: script_number; Type: ACL; Schema: clin_prescribing; Owner: easygp
--

REVOKE ALL ON SEQUENCE script_number FROM PUBLIC;
REVOKE ALL ON SEQUENCE script_number FROM easygp;
GRANT ALL ON SEQUENCE script_number TO easygp;


--
-- Name: vwinstructionhabits; Type: ACL; Schema: clin_prescribing; Owner: easygp
--

REVOKE ALL ON TABLE vwinstructionhabits FROM PUBLIC;
REVOKE ALL ON TABLE vwinstructionhabits FROM easygp;
GRANT ALL ON TABLE vwinstructionhabits TO easygp;
GRANT ALL ON TABLE vwinstructionhabits TO ian;


--
-- Name: vwprescribedforhabits; Type: ACL; Schema: clin_prescribing; Owner: easygp
--

REVOKE ALL ON TABLE vwprescribedforhabits FROM PUBLIC;
REVOKE ALL ON TABLE vwprescribedforhabits FROM easygp;
GRANT ALL ON TABLE vwprescribedforhabits TO easygp;
GRANT ALL ON TABLE vwprescribedforhabits TO ian;


SET search_path = drugs, pg_catalog;

--
-- Name: form; Type: ACL; Schema: drugs; Owner: easygp
--

REVOKE ALL ON TABLE form FROM PUBLIC;
REVOKE ALL ON TABLE form FROM easygp;
GRANT ALL ON TABLE form TO easygp;
GRANT ALL ON TABLE form TO ian;


--
-- Name: restriction; Type: ACL; Schema: drugs; Owner: easygp
--

REVOKE ALL ON TABLE restriction FROM PUBLIC;
REVOKE ALL ON TABLE restriction FROM easygp;
GRANT ALL ON TABLE restriction TO easygp;
GRANT ALL ON TABLE restriction TO ian;


--
-- Name: schedules; Type: ACL; Schema: drugs; Owner: easygp
--

REVOKE ALL ON TABLE schedules FROM PUBLIC;
REVOKE ALL ON TABLE schedules FROM easygp;
GRANT ALL ON TABLE schedules TO easygp;
GRANT ALL ON TABLE schedules TO ian;


SET search_path = clin_prescribing, pg_catalog;

--
-- Name: vwprescribeditems; Type: ACL; Schema: clin_prescribing; Owner: easygp
--

REVOKE ALL ON TABLE vwprescribeditems FROM PUBLIC;
REVOKE ALL ON TABLE vwprescribeditems FROM easygp;
GRANT ALL ON TABLE vwprescribeditems TO easygp;
GRANT ALL ON TABLE vwprescribeditems TO ian;


SET search_path = clin_procedures, pg_catalog;

--
-- Name: link_images_procedures; Type: ACL; Schema: clin_procedures; Owner: easygp
--

REVOKE ALL ON TABLE link_images_procedures FROM PUBLIC;
REVOKE ALL ON TABLE link_images_procedures FROM easygp;
GRANT ALL ON TABLE link_images_procedures TO easygp;
GRANT ALL ON TABLE link_images_procedures TO ian;


--
-- Name: link_images_procedures_pk_seq; Type: ACL; Schema: clin_procedures; Owner: easygp
--

REVOKE ALL ON SEQUENCE link_images_procedures_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE link_images_procedures_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE link_images_procedures_pk_seq TO easygp;


--
-- Name: lu_anaesthetic_agent; Type: ACL; Schema: clin_procedures; Owner: easygp
--

REVOKE ALL ON TABLE lu_anaesthetic_agent FROM PUBLIC;
REVOKE ALL ON TABLE lu_anaesthetic_agent FROM easygp;
GRANT ALL ON TABLE lu_anaesthetic_agent TO easygp;
GRANT ALL ON TABLE lu_anaesthetic_agent TO ian;


--
-- Name: lu_anaesthetic_agent_pk_seq; Type: ACL; Schema: clin_procedures; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_anaesthetic_agent_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_anaesthetic_agent_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_anaesthetic_agent_pk_seq TO easygp;


--
-- Name: lu_complications; Type: ACL; Schema: clin_procedures; Owner: easygp
--

REVOKE ALL ON TABLE lu_complications FROM PUBLIC;
REVOKE ALL ON TABLE lu_complications FROM easygp;
GRANT ALL ON TABLE lu_complications TO easygp;
GRANT ALL ON TABLE lu_complications TO ian;


--
-- Name: lu_complications_pk_seq; Type: ACL; Schema: clin_procedures; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_complications_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_complications_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_complications_pk_seq TO easygp;


--
-- Name: lu_procedure_type; Type: ACL; Schema: clin_procedures; Owner: easygp
--

REVOKE ALL ON TABLE lu_procedure_type FROM PUBLIC;
REVOKE ALL ON TABLE lu_procedure_type FROM easygp;
GRANT ALL ON TABLE lu_procedure_type TO easygp;
GRANT ALL ON TABLE lu_procedure_type TO ian;


--
-- Name: lu_excision_type_pk_seq; Type: ACL; Schema: clin_procedures; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_excision_type_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_excision_type_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_excision_type_pk_seq TO easygp;


--
-- Name: lu_last_surgical_pack; Type: ACL; Schema: clin_procedures; Owner: easygp
--

REVOKE ALL ON TABLE lu_last_surgical_pack FROM PUBLIC;
REVOKE ALL ON TABLE lu_last_surgical_pack FROM easygp;
GRANT ALL ON TABLE lu_last_surgical_pack TO easygp;
GRANT ALL ON TABLE lu_last_surgical_pack TO ian;


--
-- Name: lu_pack_pk_seq; Type: ACL; Schema: clin_procedures; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_pack_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_pack_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_pack_pk_seq TO easygp;


--
-- Name: lu_repair_type; Type: ACL; Schema: clin_procedures; Owner: easygp
--

REVOKE ALL ON TABLE lu_repair_type FROM PUBLIC;
REVOKE ALL ON TABLE lu_repair_type FROM easygp;
GRANT ALL ON TABLE lu_repair_type TO easygp;
GRANT ALL ON TABLE lu_repair_type TO ian;


--
-- Name: lu_repair_type_pk_seq; Type: ACL; Schema: clin_procedures; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_repair_type_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_repair_type_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_repair_type_pk_seq TO easygp;


--
-- Name: lu_skin_preparation; Type: ACL; Schema: clin_procedures; Owner: easygp
--

REVOKE ALL ON TABLE lu_skin_preparation FROM PUBLIC;
REVOKE ALL ON TABLE lu_skin_preparation FROM easygp;
GRANT ALL ON TABLE lu_skin_preparation TO easygp;
GRANT ALL ON TABLE lu_skin_preparation TO ian;


--
-- Name: lu_skin_preparation_pk_seq; Type: ACL; Schema: clin_procedures; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_skin_preparation_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_skin_preparation_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_skin_preparation_pk_seq TO easygp;


--
-- Name: lu_suture_site; Type: ACL; Schema: clin_procedures; Owner: easygp
--

REVOKE ALL ON TABLE lu_suture_site FROM PUBLIC;
REVOKE ALL ON TABLE lu_suture_site FROM easygp;
GRANT ALL ON TABLE lu_suture_site TO easygp;
GRANT ALL ON TABLE lu_suture_site TO ian;


--
-- Name: lu_suture_site_pk_seq; Type: ACL; Schema: clin_procedures; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_suture_site_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_suture_site_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_suture_site_pk_seq TO easygp;


--
-- Name: lu_suture_type; Type: ACL; Schema: clin_procedures; Owner: easygp
--

REVOKE ALL ON TABLE lu_suture_type FROM PUBLIC;
REVOKE ALL ON TABLE lu_suture_type FROM easygp;
GRANT ALL ON TABLE lu_suture_type TO easygp;
GRANT ALL ON TABLE lu_suture_type TO ian;


--
-- Name: lu_suture_type_pk_seq; Type: ACL; Schema: clin_procedures; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_suture_type_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_suture_type_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_suture_type_pk_seq TO easygp;


--
-- Name: skin_procedures; Type: ACL; Schema: clin_procedures; Owner: easygp
--

REVOKE ALL ON TABLE skin_procedures FROM PUBLIC;
REVOKE ALL ON TABLE skin_procedures FROM easygp;
GRANT ALL ON TABLE skin_procedures TO easygp;
GRANT ALL ON TABLE skin_procedures TO ian;


--
-- Name: skin_procedures_pk_seq; Type: ACL; Schema: clin_procedures; Owner: easygp
--

REVOKE ALL ON SEQUENCE skin_procedures_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE skin_procedures_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE skin_procedures_pk_seq TO easygp;


--
-- Name: staff_skin_procedure_defaults; Type: ACL; Schema: clin_procedures; Owner: easygp
--

REVOKE ALL ON TABLE staff_skin_procedure_defaults FROM PUBLIC;
REVOKE ALL ON TABLE staff_skin_procedure_defaults FROM easygp;
GRANT ALL ON TABLE staff_skin_procedure_defaults TO easygp;
GRANT ALL ON TABLE staff_skin_procedure_defaults TO ian;


--
-- Name: staff_skin_procedure_defaults_pk_seq; Type: ACL; Schema: clin_procedures; Owner: easygp
--

REVOKE ALL ON SEQUENCE staff_skin_procedure_defaults_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE staff_skin_procedure_defaults_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE staff_skin_procedure_defaults_pk_seq TO easygp;


--
-- Name: surgical_packs; Type: ACL; Schema: clin_procedures; Owner: easygp
--

REVOKE ALL ON TABLE surgical_packs FROM PUBLIC;
REVOKE ALL ON TABLE surgical_packs FROM easygp;
GRANT ALL ON TABLE surgical_packs TO easygp;
GRANT ALL ON TABLE surgical_packs TO ian;


--
-- Name: surgical_packs_pk_seq; Type: ACL; Schema: clin_procedures; Owner: easygp
--

REVOKE ALL ON SEQUENCE surgical_packs_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE surgical_packs_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE surgical_packs_pk_seq TO easygp;


--
-- Name: vwimages; Type: ACL; Schema: clin_procedures; Owner: easygp
--

REVOKE ALL ON TABLE vwimages FROM PUBLIC;
REVOKE ALL ON TABLE vwimages FROM easygp;
GRANT ALL ON TABLE vwimages TO easygp;
GRANT ALL ON TABLE vwimages TO ian;


SET search_path = clin_requests, pg_catalog;

--
-- Name: forms; Type: ACL; Schema: clin_requests; Owner: easygp
--

REVOKE ALL ON TABLE forms FROM PUBLIC;
REVOKE ALL ON TABLE forms FROM easygp;
GRANT ALL ON TABLE forms TO easygp;
GRANT ALL ON TABLE forms TO ian;


SET search_path = common, pg_catalog;

--
-- Name: lu_anatomical_site; Type: ACL; Schema: common; Owner: easygp
--

REVOKE ALL ON TABLE lu_anatomical_site FROM PUBLIC;
REVOKE ALL ON TABLE lu_anatomical_site FROM easygp;
GRANT ALL ON TABLE lu_anatomical_site TO easygp;
GRANT ALL ON TABLE lu_anatomical_site TO ian;


--
-- Name: lu_anterior_posterior; Type: ACL; Schema: common; Owner: easygp
--

REVOKE ALL ON TABLE lu_anterior_posterior FROM PUBLIC;
REVOKE ALL ON TABLE lu_anterior_posterior FROM easygp;
GRANT ALL ON TABLE lu_anterior_posterior TO easygp;
GRANT ALL ON TABLE lu_anterior_posterior TO ian;


SET search_path = clin_procedures, pg_catalog;

--
-- Name: vwskinprocedures; Type: ACL; Schema: clin_procedures; Owner: easygp
--

REVOKE ALL ON TABLE vwskinprocedures FROM PUBLIC;
REVOKE ALL ON TABLE vwskinprocedures FROM easygp;
GRANT ALL ON TABLE vwskinprocedures TO easygp;
GRANT ALL ON TABLE vwskinprocedures TO ian;


--
-- Name: vwstaffskinproceduredefaults; Type: ACL; Schema: clin_procedures; Owner: easygp
--

REVOKE ALL ON TABLE vwstaffskinproceduredefaults FROM PUBLIC;
REVOKE ALL ON TABLE vwstaffskinproceduredefaults FROM easygp;
GRANT ALL ON TABLE vwstaffskinproceduredefaults TO easygp;
GRANT ALL ON TABLE vwstaffskinproceduredefaults TO ian;


--
-- Name: vwsutures; Type: ACL; Schema: clin_procedures; Owner: easygp
--

REVOKE ALL ON TABLE vwsutures FROM PUBLIC;
REVOKE ALL ON TABLE vwsutures FROM easygp;
GRANT ALL ON TABLE vwsutures TO easygp;
GRANT ALL ON TABLE vwsutures TO ian;


SET search_path = clin_recalls, pg_catalog;

--
-- Name: forms; Type: ACL; Schema: clin_recalls; Owner: easygp
--

REVOKE ALL ON TABLE forms FROM PUBLIC;
REVOKE ALL ON TABLE forms FROM easygp;
GRANT ALL ON TABLE forms TO easygp;
GRANT ALL ON TABLE forms TO ian;


--
-- Name: forms_pk_seq; Type: ACL; Schema: clin_recalls; Owner: easygp
--

REVOKE ALL ON SEQUENCE forms_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE forms_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE forms_pk_seq TO easygp;


--
-- Name: links_forms; Type: ACL; Schema: clin_recalls; Owner: easygp
--

REVOKE ALL ON TABLE links_forms FROM PUBLIC;
REVOKE ALL ON TABLE links_forms FROM easygp;
GRANT ALL ON TABLE links_forms TO easygp;
GRANT ALL ON TABLE links_forms TO ian;


--
-- Name: links_forms_pk_seq; Type: ACL; Schema: clin_recalls; Owner: easygp
--

REVOKE ALL ON SEQUENCE links_forms_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE links_forms_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE links_forms_pk_seq TO easygp;


--
-- Name: lu_reasons_pk_seq; Type: ACL; Schema: clin_recalls; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_reasons_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_reasons_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_reasons_pk_seq TO easygp;


--
-- Name: lu_recall_intervals_pk_seq; Type: ACL; Schema: clin_recalls; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_recall_intervals_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_recall_intervals_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_recall_intervals_pk_seq TO easygp;


--
-- Name: lu_templates_pk_seq; Type: ACL; Schema: clin_recalls; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_templates_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_templates_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_templates_pk_seq TO easygp;


--
-- Name: recalls_pk_seq; Type: ACL; Schema: clin_recalls; Owner: easygp
--

REVOKE ALL ON SEQUENCE recalls_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE recalls_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE recalls_pk_seq TO easygp;


--
-- Name: sent_pk_seq; Type: ACL; Schema: clin_recalls; Owner: easygp
--

REVOKE ALL ON SEQUENCE sent_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE sent_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE sent_pk_seq TO easygp;


--
-- Name: vwreasons; Type: ACL; Schema: clin_recalls; Owner: easygp
--

REVOKE ALL ON TABLE vwreasons FROM PUBLIC;
REVOKE ALL ON TABLE vwreasons FROM easygp;
GRANT ALL ON TABLE vwreasons TO easygp;
GRANT ALL ON TABLE vwreasons TO ian;


--
-- Name: vwrecallsdue; Type: ACL; Schema: clin_recalls; Owner: easygp
--

REVOKE ALL ON TABLE vwrecallsdue FROM PUBLIC;
REVOKE ALL ON TABLE vwrecallsdue FROM easygp;
GRANT ALL ON TABLE vwrecallsdue TO easygp;
GRANT ALL ON TABLE vwrecallsdue TO ian;


--
-- Name: vwtemplates; Type: ACL; Schema: clin_recalls; Owner: easygp
--

REVOKE ALL ON TABLE vwtemplates FROM PUBLIC;
REVOKE ALL ON TABLE vwtemplates FROM easygp;
GRANT ALL ON TABLE vwtemplates TO easygp;
GRANT ALL ON TABLE vwtemplates TO ian;


SET search_path = clin_referrals, pg_catalog;

--
-- Name: inclusions; Type: ACL; Schema: clin_referrals; Owner: easygp
--

REVOKE ALL ON TABLE inclusions FROM PUBLIC;
REVOKE ALL ON TABLE inclusions FROM easygp;
GRANT ALL ON TABLE inclusions TO easygp;
GRANT ALL ON TABLE inclusions TO ian;


--
-- Name: lu_type; Type: ACL; Schema: clin_referrals; Owner: easygp
--

REVOKE ALL ON TABLE lu_type FROM PUBLIC;
REVOKE ALL ON TABLE lu_type FROM easygp;
GRANT ALL ON TABLE lu_type TO easygp;
GRANT ALL ON TABLE lu_type TO ian;


--
-- Name: lu_type_pk_seq; Type: ACL; Schema: clin_referrals; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_type_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_type_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_type_pk_seq TO easygp;


--
-- Name: lu_urgency; Type: ACL; Schema: clin_referrals; Owner: easygp
--

REVOKE ALL ON TABLE lu_urgency FROM PUBLIC;
REVOKE ALL ON TABLE lu_urgency FROM easygp;
GRANT ALL ON TABLE lu_urgency TO easygp;
GRANT ALL ON TABLE lu_urgency TO ian;


--
-- Name: referrals_pk_seq; Type: ACL; Schema: clin_referrals; Owner: easygp
--

REVOKE ALL ON SEQUENCE referrals_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE referrals_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE referrals_pk_seq TO easygp;


SET search_path = documents, pg_catalog;

--
-- Name: documents; Type: ACL; Schema: documents; Owner: easygp
--

REVOKE ALL ON TABLE documents FROM PUBLIC;
REVOKE ALL ON TABLE documents FROM easygp;
GRANT ALL ON TABLE documents TO easygp;
GRANT ALL ON TABLE documents TO ian;


SET search_path = clin_referrals, pg_catalog;

--
-- Name: vwinclusions; Type: ACL; Schema: clin_referrals; Owner: easygp
--

REVOKE ALL ON TABLE vwinclusions FROM PUBLIC;
REVOKE ALL ON TABLE vwinclusions FROM easygp;
GRANT ALL ON TABLE vwinclusions TO easygp;
GRANT ALL ON TABLE vwinclusions TO ian;


--
-- Name: vwreferrals; Type: ACL; Schema: clin_referrals; Owner: easygp
--

REVOKE ALL ON TABLE vwreferrals FROM PUBLIC;
REVOKE ALL ON TABLE vwreferrals FROM easygp;
GRANT ALL ON TABLE vwreferrals TO easygp;
GRANT ALL ON TABLE vwreferrals TO staff;


SET search_path = clin_requests, pg_catalog;

--
-- Name: forms_pk_seq; Type: ACL; Schema: clin_requests; Owner: easygp
--

REVOKE ALL ON SEQUENCE forms_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE forms_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE forms_pk_seq TO easygp;


--
-- Name: forms_requests; Type: ACL; Schema: clin_requests; Owner: easygp
--

REVOKE ALL ON TABLE forms_requests FROM PUBLIC;
REVOKE ALL ON TABLE forms_requests FROM easygp;
GRANT ALL ON TABLE forms_requests TO easygp;
GRANT ALL ON TABLE forms_requests TO ian;


--
-- Name: forms_requests_pk_seq; Type: ACL; Schema: clin_requests; Owner: easygp
--

REVOKE ALL ON SEQUENCE forms_requests_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE forms_requests_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE forms_requests_pk_seq TO easygp;


--
-- Name: inbox_oru_unresolved_temp_patient_id_seq; Type: ACL; Schema: clin_requests; Owner: easygp
--

REVOKE ALL ON SEQUENCE inbox_oru_unresolved_temp_patient_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE inbox_oru_unresolved_temp_patient_id_seq FROM easygp;
GRANT ALL ON SEQUENCE inbox_oru_unresolved_temp_patient_id_seq TO easygp;


--
-- Name: link_forms_requests_requests_results; Type: ACL; Schema: clin_requests; Owner: easygp
--

REVOKE ALL ON TABLE link_forms_requests_requests_results FROM PUBLIC;
REVOKE ALL ON TABLE link_forms_requests_requests_results FROM easygp;
GRANT ALL ON TABLE link_forms_requests_requests_results TO easygp;
GRANT ALL ON TABLE link_forms_requests_requests_results TO ian;


--
-- Name: link_forms_requests_requests_results_pk_seq; Type: ACL; Schema: clin_requests; Owner: easygp
--

REVOKE ALL ON SEQUENCE link_forms_requests_requests_results_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE link_forms_requests_requests_results_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE link_forms_requests_requests_results_pk_seq TO easygp;


--
-- Name: lu_copyto_type; Type: ACL; Schema: clin_requests; Owner: easygp
--

REVOKE ALL ON TABLE lu_copyto_type FROM PUBLIC;
REVOKE ALL ON TABLE lu_copyto_type FROM easygp;
GRANT ALL ON TABLE lu_copyto_type TO easygp;
GRANT ALL ON TABLE lu_copyto_type TO ian;


--
-- Name: lu_copyto_type_pk_seq; Type: ACL; Schema: clin_requests; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_copyto_type_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_copyto_type_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_copyto_type_pk_seq TO easygp;


--
-- Name: lu_form_header; Type: ACL; Schema: clin_requests; Owner: easygp
--

REVOKE ALL ON TABLE lu_form_header FROM PUBLIC;
REVOKE ALL ON TABLE lu_form_header FROM easygp;
GRANT ALL ON TABLE lu_form_header TO easygp;
GRANT ALL ON TABLE lu_form_header TO ian;


--
-- Name: lu_form_header_pk_seq; Type: ACL; Schema: clin_requests; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_form_header_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_form_header_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_form_header_pk_seq TO easygp;


--
-- Name: lu_instructions; Type: ACL; Schema: clin_requests; Owner: easygp
--

REVOKE ALL ON TABLE lu_instructions FROM PUBLIC;
REVOKE ALL ON TABLE lu_instructions FROM easygp;
GRANT ALL ON TABLE lu_instructions TO easygp;
GRANT ALL ON TABLE lu_instructions TO ian;


--
-- Name: lu_instructions_pk_seq; Type: ACL; Schema: clin_requests; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_instructions_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_instructions_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_instructions_pk_seq TO easygp;


--
-- Name: lu_link_provider_user_requests; Type: ACL; Schema: clin_requests; Owner: easygp
--

REVOKE ALL ON TABLE lu_link_provider_user_requests FROM PUBLIC;
REVOKE ALL ON TABLE lu_link_provider_user_requests FROM easygp;
GRANT ALL ON TABLE lu_link_provider_user_requests TO easygp;
GRANT ALL ON TABLE lu_link_provider_user_requests TO ian;


--
-- Name: lu_link_provider_user_requests_pk_seq; Type: ACL; Schema: clin_requests; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_link_provider_user_requests_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_link_provider_user_requests_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_link_provider_user_requests_pk_seq TO easygp;


--
-- Name: lu_request_type; Type: ACL; Schema: clin_requests; Owner: easygp
--

REVOKE ALL ON TABLE lu_request_type FROM PUBLIC;
REVOKE ALL ON TABLE lu_request_type FROM easygp;
GRANT ALL ON TABLE lu_request_type TO easygp;
GRANT ALL ON TABLE lu_request_type TO ian;


--
-- Name: lu_request_type_pk_seq; Type: ACL; Schema: clin_requests; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_request_type_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_request_type_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_request_type_pk_seq TO easygp;


--
-- Name: lu_requests; Type: ACL; Schema: clin_requests; Owner: easygp
--

REVOKE ALL ON TABLE lu_requests FROM PUBLIC;
REVOKE ALL ON TABLE lu_requests FROM easygp;
GRANT ALL ON TABLE lu_requests TO easygp;
GRANT ALL ON TABLE lu_requests TO ian;


--
-- Name: lu_requests_pk_seq; Type: ACL; Schema: clin_requests; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_requests_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_requests_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_requests_pk_seq TO easygp;


--
-- Name: notes; Type: ACL; Schema: clin_requests; Owner: easygp
--

REVOKE ALL ON TABLE notes FROM PUBLIC;
REVOKE ALL ON TABLE notes FROM easygp;
GRANT ALL ON TABLE notes TO easygp;
GRANT ALL ON TABLE notes TO ian;


--
-- Name: notes_pk_seq; Type: ACL; Schema: clin_requests; Owner: easygp
--

REVOKE ALL ON SEQUENCE notes_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE notes_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE notes_pk_seq TO easygp;


--
-- Name: request_providers; Type: ACL; Schema: clin_requests; Owner: easygp
--

REVOKE ALL ON TABLE request_providers FROM PUBLIC;
REVOKE ALL ON TABLE request_providers FROM easygp;
GRANT ALL ON TABLE request_providers TO easygp;
GRANT ALL ON TABLE request_providers TO ian;


--
-- Name: request_providers_pk_seq; Type: ACL; Schema: clin_requests; Owner: easygp
--

REVOKE ALL ON SEQUENCE request_providers_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE request_providers_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE request_providers_pk_seq TO easygp;


--
-- Name: results_requests_episode_key; Type: ACL; Schema: clin_requests; Owner: easygp
--

REVOKE ALL ON SEQUENCE results_requests_episode_key FROM PUBLIC;
REVOKE ALL ON SEQUENCE results_requests_episode_key FROM easygp;
GRANT ALL ON SEQUENCE results_requests_episode_key TO easygp;


--
-- Name: user_default_type; Type: ACL; Schema: clin_requests; Owner: easygp
--

REVOKE ALL ON TABLE user_default_type FROM PUBLIC;
REVOKE ALL ON TABLE user_default_type FROM easygp;
GRANT ALL ON TABLE user_default_type TO easygp;
GRANT ALL ON TABLE user_default_type TO ian;


--
-- Name: user_default_type_pk_seq; Type: ACL; Schema: clin_requests; Owner: easygp
--

REVOKE ALL ON SEQUENCE user_default_type_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE user_default_type_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE user_default_type_pk_seq TO easygp;


--
-- Name: user_provider_defaults; Type: ACL; Schema: clin_requests; Owner: easygp
--

REVOKE ALL ON TABLE user_provider_defaults FROM PUBLIC;
REVOKE ALL ON TABLE user_provider_defaults FROM easygp;
GRANT ALL ON TABLE user_provider_defaults TO easygp;
GRANT ALL ON TABLE user_provider_defaults TO ian;


--
-- Name: user_provider_defaults_pk_seq; Type: ACL; Schema: clin_requests; Owner: easygp
--

REVOKE ALL ON SEQUENCE user_provider_defaults_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE user_provider_defaults_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE user_provider_defaults_pk_seq TO easygp;


--
-- Name: vwforms_pk_seq; Type: ACL; Schema: clin_requests; Owner: easygp
--

REVOKE ALL ON SEQUENCE vwforms_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE vwforms_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE vwforms_pk_seq TO easygp;


SET search_path = contacts, pg_catalog;

--
-- Name: images; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE images FROM PUBLIC;
REVOKE ALL ON TABLE images FROM easygp;
GRANT ALL ON TABLE images TO easygp;
GRANT ALL ON TABLE images TO ian;


--
-- Name: vwpersons; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE vwpersons FROM PUBLIC;
REVOKE ALL ON TABLE vwpersons FROM easygp;
GRANT ALL ON TABLE vwpersons TO easygp;
GRANT ALL ON TABLE vwpersons TO ian;


SET search_path = clin_requests, pg_catalog;

--
-- Name: vwrequestproviders; Type: ACL; Schema: clin_requests; Owner: easygp
--

REVOKE ALL ON TABLE vwrequestproviders FROM PUBLIC;
REVOKE ALL ON TABLE vwrequestproviders FROM easygp;
GRANT ALL ON TABLE vwrequestproviders TO easygp;
GRANT ALL ON TABLE vwrequestproviders TO ian;


--
-- Name: vwrequestforms; Type: ACL; Schema: clin_requests; Owner: easygp
--

REVOKE ALL ON TABLE vwrequestforms FROM PUBLIC;
REVOKE ALL ON TABLE vwrequestforms FROM easygp;
GRANT ALL ON TABLE vwrequestforms TO easygp;
GRANT ALL ON TABLE vwrequestforms TO ian;


--
-- Name: vwrequestnames; Type: ACL; Schema: clin_requests; Owner: easygp
--

REVOKE ALL ON TABLE vwrequestnames FROM PUBLIC;
REVOKE ALL ON TABLE vwrequestnames FROM easygp;
GRANT ALL ON TABLE vwrequestnames TO easygp;
GRANT ALL ON TABLE vwrequestnames TO ian;


SET search_path = documents, pg_catalog;

--
-- Name: lu_message_display_style; Type: ACL; Schema: documents; Owner: easygp
--

REVOKE ALL ON TABLE lu_message_display_style FROM PUBLIC;
REVOKE ALL ON TABLE lu_message_display_style FROM easygp;
GRANT ALL ON TABLE lu_message_display_style TO easygp;
GRANT ALL ON TABLE lu_message_display_style TO ian;


--
-- Name: lu_message_standard; Type: ACL; Schema: documents; Owner: easygp
--

REVOKE ALL ON TABLE lu_message_standard FROM PUBLIC;
REVOKE ALL ON TABLE lu_message_standard FROM easygp;
GRANT ALL ON TABLE lu_message_standard TO easygp;
GRANT ALL ON TABLE lu_message_standard TO ian;


--
-- Name: sending_entities; Type: ACL; Schema: documents; Owner: easygp
--

REVOKE ALL ON TABLE sending_entities FROM PUBLIC;
REVOKE ALL ON TABLE sending_entities FROM easygp;
GRANT ALL ON TABLE sending_entities TO easygp;
GRANT ALL ON TABLE sending_entities TO ian;


--
-- Name: unmatched_patients; Type: ACL; Schema: documents; Owner: easygp
--

REVOKE ALL ON TABLE unmatched_patients FROM PUBLIC;
REVOKE ALL ON TABLE unmatched_patients FROM easygp;
GRANT ALL ON TABLE unmatched_patients TO easygp;
GRANT ALL ON TABLE unmatched_patients TO ian;


--
-- Name: unmatched_staff; Type: ACL; Schema: documents; Owner: easygp
--

REVOKE ALL ON TABLE unmatched_staff FROM PUBLIC;
REVOKE ALL ON TABLE unmatched_staff FROM easygp;
GRANT ALL ON TABLE unmatched_staff TO easygp;
GRANT ALL ON TABLE unmatched_staff TO ian;


--
-- Name: vwsendingentities; Type: ACL; Schema: documents; Owner: easygp
--

REVOKE ALL ON TABLE vwsendingentities FROM PUBLIC;
REVOKE ALL ON TABLE vwsendingentities FROM easygp;
GRANT ALL ON TABLE vwsendingentities TO easygp;
GRANT ALL ON TABLE vwsendingentities TO ian;


--
-- Name: vwdocuments; Type: ACL; Schema: documents; Owner: easygp
--

REVOKE ALL ON TABLE vwdocuments FROM PUBLIC;
REVOKE ALL ON TABLE vwdocuments FROM easygp;
GRANT ALL ON TABLE vwdocuments TO easygp;
GRANT ALL ON TABLE vwdocuments TO ian;


SET search_path = clin_requests, pg_catalog;

--
-- Name: vwrequestsordered; Type: ACL; Schema: clin_requests; Owner: easygp
--

REVOKE ALL ON TABLE vwrequestsordered FROM PUBLIC;
REVOKE ALL ON TABLE vwrequestsordered FROM easygp;
GRANT ALL ON TABLE vwrequestsordered TO easygp;
GRANT ALL ON TABLE vwrequestsordered TO ian;


--
-- Name: vwrequestsynonyms; Type: ACL; Schema: clin_requests; Owner: easygp
--

REVOKE ALL ON TABLE vwrequestsynonyms FROM PUBLIC;
REVOKE ALL ON TABLE vwrequestsynonyms FROM easygp;
GRANT ALL ON TABLE vwrequestsynonyms TO easygp;
GRANT ALL ON TABLE vwrequestsynonyms TO ian;


--
-- Name: vwuserproviderdefaults; Type: ACL; Schema: clin_requests; Owner: easygp
--

REVOKE ALL ON TABLE vwuserproviderdefaults FROM PUBLIC;
REVOKE ALL ON TABLE vwuserproviderdefaults FROM easygp;
GRANT ALL ON TABLE vwuserproviderdefaults TO easygp;
GRANT ALL ON TABLE vwuserproviderdefaults TO ian;


SET search_path = clin_vaccination, pg_catalog;

--
-- Name: lu_descriptions; Type: ACL; Schema: clin_vaccination; Owner: easygp
--

REVOKE ALL ON TABLE lu_descriptions FROM PUBLIC;
REVOKE ALL ON TABLE lu_descriptions FROM easygp;
GRANT ALL ON TABLE lu_descriptions TO easygp;
GRANT ALL ON TABLE lu_descriptions TO ian;


--
-- Name: lu_formulation; Type: ACL; Schema: clin_vaccination; Owner: easygp
--

REVOKE ALL ON TABLE lu_formulation FROM PUBLIC;
REVOKE ALL ON TABLE lu_formulation FROM easygp;
GRANT ALL ON TABLE lu_formulation TO easygp;
GRANT ALL ON TABLE lu_formulation TO ian;


--
-- Name: lu_schedules; Type: ACL; Schema: clin_vaccination; Owner: easygp
--

REVOKE ALL ON TABLE lu_schedules FROM PUBLIC;
REVOKE ALL ON TABLE lu_schedules FROM easygp;
GRANT ALL ON TABLE lu_schedules TO easygp;
GRANT ALL ON TABLE lu_schedules TO ian;


--
-- Name: lu_schedules_pk_seq; Type: ACL; Schema: clin_vaccination; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_schedules_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_schedules_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_schedules_pk_seq TO easygp;


--
-- Name: lu_vaccines; Type: ACL; Schema: clin_vaccination; Owner: easygp
--

REVOKE ALL ON TABLE lu_vaccines FROM PUBLIC;
REVOKE ALL ON TABLE lu_vaccines FROM easygp;
GRANT ALL ON TABLE lu_vaccines TO easygp;
GRANT ALL ON TABLE lu_vaccines TO ian;


--
-- Name: lu_vaccines_descriptions_pk_seq; Type: ACL; Schema: clin_vaccination; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_vaccines_descriptions_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_vaccines_descriptions_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_vaccines_descriptions_pk_seq TO easygp;


--
-- Name: lu_vaccines_in_schedule; Type: ACL; Schema: clin_vaccination; Owner: easygp
--

REVOKE ALL ON TABLE lu_vaccines_in_schedule FROM PUBLIC;
REVOKE ALL ON TABLE lu_vaccines_in_schedule FROM easygp;
GRANT ALL ON TABLE lu_vaccines_in_schedule TO easygp;
GRANT ALL ON TABLE lu_vaccines_in_schedule TO ian;


--
-- Name: lu_vaccines_in_schedule_pk_seq; Type: ACL; Schema: clin_vaccination; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_vaccines_in_schedule_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_vaccines_in_schedule_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_vaccines_in_schedule_pk_seq TO easygp;


--
-- Name: lu_vaccines_pk_seq; Type: ACL; Schema: clin_vaccination; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_vaccines_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_vaccines_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_vaccines_pk_seq TO easygp;


--
-- Name: vaccinations; Type: ACL; Schema: clin_vaccination; Owner: easygp
--

REVOKE ALL ON TABLE vaccinations FROM PUBLIC;
REVOKE ALL ON TABLE vaccinations FROM easygp;
GRANT ALL ON TABLE vaccinations TO easygp;
GRANT ALL ON TABLE vaccinations TO ian;


--
-- Name: vaccine_serial_numbers; Type: ACL; Schema: clin_vaccination; Owner: easygp
--

REVOKE ALL ON TABLE vaccine_serial_numbers FROM PUBLIC;
REVOKE ALL ON TABLE vaccine_serial_numbers FROM easygp;
GRANT ALL ON TABLE vaccine_serial_numbers TO easygp;
GRANT ALL ON TABLE vaccine_serial_numbers TO ian;


--
-- Name: vwvaccineroutesadministration; Type: ACL; Schema: clin_vaccination; Owner: easygp
--

REVOKE ALL ON TABLE vwvaccineroutesadministration FROM PUBLIC;
REVOKE ALL ON TABLE vwvaccineroutesadministration FROM easygp;
GRANT ALL ON TABLE vwvaccineroutesadministration TO easygp;
GRANT ALL ON TABLE vwvaccineroutesadministration TO ian;


--
-- Name: vwvaccines; Type: ACL; Schema: clin_vaccination; Owner: easygp
--

REVOKE ALL ON TABLE vwvaccines FROM PUBLIC;
REVOKE ALL ON TABLE vwvaccines FROM easygp;
GRANT ALL ON TABLE vwvaccines TO easygp;
GRANT ALL ON TABLE vwvaccines TO ian;


SET search_path = common, pg_catalog;

--
-- Name: lu_seasons; Type: ACL; Schema: common; Owner: easygp
--

REVOKE ALL ON TABLE lu_seasons FROM PUBLIC;
REVOKE ALL ON TABLE lu_seasons FROM easygp;
GRANT ALL ON TABLE lu_seasons TO easygp;
GRANT ALL ON TABLE lu_seasons TO ian;


--
-- Name: lu_site_administration; Type: ACL; Schema: common; Owner: easygp
--

REVOKE ALL ON TABLE lu_site_administration FROM PUBLIC;
REVOKE ALL ON TABLE lu_site_administration FROM easygp;
GRANT ALL ON TABLE lu_site_administration TO easygp;
GRANT ALL ON TABLE lu_site_administration TO ian;


SET search_path = clin_vaccination, pg_catalog;

--
-- Name: vwvaccinesgiven; Type: ACL; Schema: clin_vaccination; Owner: easygp
--

REVOKE ALL ON TABLE vwvaccinesgiven FROM PUBLIC;
REVOKE ALL ON TABLE vwvaccinesgiven FROM easygp;
GRANT ALL ON TABLE vwvaccinesgiven TO easygp;
GRANT ALL ON TABLE vwvaccinesgiven TO ian;


--
-- Name: vwvaccinesinschedule; Type: ACL; Schema: clin_vaccination; Owner: easygp
--

REVOKE ALL ON TABLE vwvaccinesinschedule FROM PUBLIC;
REVOKE ALL ON TABLE vwvaccinesinschedule FROM easygp;
GRANT ALL ON TABLE vwvaccinesinschedule TO easygp;
GRANT ALL ON TABLE vwvaccinesinschedule TO ian;


SET search_path = clin_workcover, pg_catalog;

--
-- Name: claims; Type: ACL; Schema: clin_workcover; Owner: easygp
--

REVOKE ALL ON TABLE claims FROM PUBLIC;
REVOKE ALL ON TABLE claims FROM easygp;
GRANT ALL ON TABLE claims TO easygp;
GRANT ALL ON TABLE claims TO ian;


--
-- Name: claims_pk_seq; Type: ACL; Schema: clin_workcover; Owner: easygp
--

REVOKE ALL ON SEQUENCE claims_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE claims_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE claims_pk_seq TO easygp;


--
-- Name: lu_caused_by_employment; Type: ACL; Schema: clin_workcover; Owner: easygp
--

REVOKE ALL ON TABLE lu_caused_by_employment FROM PUBLIC;
REVOKE ALL ON TABLE lu_caused_by_employment FROM easygp;
GRANT ALL ON TABLE lu_caused_by_employment TO easygp;
GRANT ALL ON TABLE lu_caused_by_employment TO ian;


--
-- Name: lu_caused_by_employment_pk_seq; Type: ACL; Schema: clin_workcover; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_caused_by_employment_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_caused_by_employment_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_caused_by_employment_pk_seq TO easygp;


--
-- Name: lu_visit_type; Type: ACL; Schema: clin_workcover; Owner: easygp
--

REVOKE ALL ON TABLE lu_visit_type FROM PUBLIC;
REVOKE ALL ON TABLE lu_visit_type FROM easygp;
GRANT ALL ON TABLE lu_visit_type TO easygp;
GRANT ALL ON TABLE lu_visit_type TO ian;


--
-- Name: lu_visit_type_pk_seq; Type: ACL; Schema: clin_workcover; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_visit_type_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_visit_type_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_visit_type_pk_seq TO easygp;


--
-- Name: visits; Type: ACL; Schema: clin_workcover; Owner: easygp
--

REVOKE ALL ON TABLE visits FROM PUBLIC;
REVOKE ALL ON TABLE visits FROM easygp;
GRANT ALL ON TABLE visits TO easygp;
GRANT ALL ON TABLE visits TO ian;


--
-- Name: visits_pk_seq; Type: ACL; Schema: clin_workcover; Owner: easygp
--

REVOKE ALL ON SEQUENCE visits_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE visits_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE visits_pk_seq TO easygp;


--
-- Name: vwworkcover; Type: ACL; Schema: clin_workcover; Owner: easygp
--

REVOKE ALL ON TABLE vwworkcover FROM PUBLIC;
REVOKE ALL ON TABLE vwworkcover FROM easygp;
GRANT ALL ON TABLE vwworkcover TO easygp;
GRANT ALL ON TABLE vwworkcover TO ian;


SET search_path = coding, pg_catalog;

--
-- Name: lu_loinc; Type: ACL; Schema: coding; Owner: easygp
--

REVOKE ALL ON TABLE lu_loinc FROM PUBLIC;
REVOKE ALL ON TABLE lu_loinc FROM easygp;
GRANT ALL ON TABLE lu_loinc TO easygp;
GRANT ALL ON TABLE lu_loinc TO ian;


--
-- Name: lu_loinc_abbrev; Type: ACL; Schema: coding; Owner: easygp
--

REVOKE ALL ON TABLE lu_loinc_abbrev FROM PUBLIC;
REVOKE ALL ON TABLE lu_loinc_abbrev FROM easygp;
GRANT ALL ON TABLE lu_loinc_abbrev TO easygp;
GRANT ALL ON TABLE lu_loinc_abbrev TO ian;


--
-- Name: usr_codes_weighting; Type: ACL; Schema: coding; Owner: easygp
--

REVOKE ALL ON TABLE usr_codes_weighting FROM PUBLIC;
REVOKE ALL ON TABLE usr_codes_weighting FROM easygp;
GRANT ALL ON TABLE usr_codes_weighting TO easygp;
GRANT ALL ON TABLE usr_codes_weighting TO ian;


--
-- Name: usr_codes_weighting_pk_seq; Type: ACL; Schema: coding; Owner: easygp
--

REVOKE ALL ON SEQUENCE usr_codes_weighting_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE usr_codes_weighting_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE usr_codes_weighting_pk_seq TO easygp;


--
-- Name: vwcodesweighted; Type: ACL; Schema: coding; Owner: easygp
--

REVOKE ALL ON TABLE vwcodesweighted FROM PUBLIC;
REVOKE ALL ON TABLE vwcodesweighted FROM easygp;
GRANT ALL ON TABLE vwcodesweighted TO easygp;
GRANT ALL ON TABLE vwcodesweighted TO ian;


--
-- Name: vwgenericterms; Type: ACL; Schema: coding; Owner: easygp
--

REVOKE ALL ON TABLE vwgenericterms FROM PUBLIC;
REVOKE ALL ON TABLE vwgenericterms FROM easygp;
GRANT ALL ON TABLE vwgenericterms TO easygp;
GRANT ALL ON TABLE vwgenericterms TO ian;


SET search_path = common, pg_catalog;

--
-- Name: lu_anatomical_localisation; Type: ACL; Schema: common; Owner: easygp
--

REVOKE ALL ON TABLE lu_anatomical_localisation FROM PUBLIC;
REVOKE ALL ON TABLE lu_anatomical_localisation FROM easygp;
GRANT ALL ON TABLE lu_anatomical_localisation TO easygp;
GRANT ALL ON TABLE lu_anatomical_localisation TO ian;


--
-- Name: lu_companion_status; Type: ACL; Schema: common; Owner: easygp
--

REVOKE ALL ON TABLE lu_companion_status FROM PUBLIC;
REVOKE ALL ON TABLE lu_companion_status FROM easygp;
GRANT ALL ON TABLE lu_companion_status TO easygp;
GRANT ALL ON TABLE lu_companion_status TO ian;


--
-- Name: lu_formulation; Type: ACL; Schema: common; Owner: easygp
--

REVOKE ALL ON TABLE lu_formulation FROM PUBLIC;
REVOKE ALL ON TABLE lu_formulation FROM easygp;
GRANT ALL ON TABLE lu_formulation TO easygp;
GRANT ALL ON TABLE lu_formulation TO ian;


--
-- Name: lu_hearing_aid_status; Type: ACL; Schema: common; Owner: easygp
--

REVOKE ALL ON TABLE lu_hearing_aid_status FROM PUBLIC;
REVOKE ALL ON TABLE lu_hearing_aid_status FROM easygp;
GRANT ALL ON TABLE lu_hearing_aid_status TO easygp;
GRANT ALL ON TABLE lu_hearing_aid_status TO ian;


--
-- Name: lu_medicolegal; Type: ACL; Schema: common; Owner: easygp
--

REVOKE ALL ON TABLE lu_medicolegal FROM PUBLIC;
REVOKE ALL ON TABLE lu_medicolegal FROM easygp;
GRANT ALL ON TABLE lu_medicolegal TO easygp;
GRANT ALL ON TABLE lu_medicolegal TO ian;


--
-- Name: lu_motion; Type: ACL; Schema: common; Owner: easygp
--

REVOKE ALL ON TABLE lu_motion FROM PUBLIC;
REVOKE ALL ON TABLE lu_motion FROM easygp;
GRANT ALL ON TABLE lu_motion TO easygp;
GRANT ALL ON TABLE lu_motion TO ian;


--
-- Name: lu_normality; Type: ACL; Schema: common; Owner: easygp
--

REVOKE ALL ON TABLE lu_normality FROM PUBLIC;
REVOKE ALL ON TABLE lu_normality FROM easygp;
GRANT ALL ON TABLE lu_normality TO easygp;
GRANT ALL ON TABLE lu_normality TO ian;


--
-- Name: lu_occupations_pk_seq; Type: ACL; Schema: common; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_occupations_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_occupations_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_occupations_pk_seq TO easygp;


--
-- Name: lu_proximal_distal; Type: ACL; Schema: common; Owner: easygp
--

REVOKE ALL ON TABLE lu_proximal_distal FROM PUBLIC;
REVOKE ALL ON TABLE lu_proximal_distal FROM easygp;
GRANT ALL ON TABLE lu_proximal_distal TO easygp;
GRANT ALL ON TABLE lu_proximal_distal TO ian;


--
-- Name: lu_religions; Type: ACL; Schema: common; Owner: easygp
--

REVOKE ALL ON TABLE lu_religions FROM PUBLIC;
REVOKE ALL ON TABLE lu_religions FROM easygp;
GRANT ALL ON TABLE lu_religions TO easygp;
GRANT ALL ON TABLE lu_religions TO ian;


--
-- Name: lu_smoking_status; Type: ACL; Schema: common; Owner: easygp
--

REVOKE ALL ON TABLE lu_smoking_status FROM PUBLIC;
REVOKE ALL ON TABLE lu_smoking_status FROM easygp;
GRANT ALL ON TABLE lu_smoking_status TO easygp;
GRANT ALL ON TABLE lu_smoking_status TO ian;


--
-- Name: lu_social_support; Type: ACL; Schema: common; Owner: easygp
--

REVOKE ALL ON TABLE lu_social_support FROM PUBLIC;
REVOKE ALL ON TABLE lu_social_support FROM easygp;
GRANT ALL ON TABLE lu_social_support TO easygp;
GRANT ALL ON TABLE lu_social_support TO ian;


--
-- Name: lu_sub_religions; Type: ACL; Schema: common; Owner: easygp
--

REVOKE ALL ON TABLE lu_sub_religions FROM PUBLIC;
REVOKE ALL ON TABLE lu_sub_religions FROM easygp;
GRANT ALL ON TABLE lu_sub_religions TO easygp;
GRANT ALL ON TABLE lu_sub_religions TO ian;


--
-- Name: lu_whisper_test; Type: ACL; Schema: common; Owner: easygp
--

REVOKE ALL ON TABLE lu_whisper_test FROM PUBLIC;
REVOKE ALL ON TABLE lu_whisper_test FROM easygp;
GRANT ALL ON TABLE lu_whisper_test TO easygp;
GRANT ALL ON TABLE lu_whisper_test TO ian;


--
-- Name: vwreligions; Type: ACL; Schema: common; Owner: easygp
--

REVOKE ALL ON TABLE vwreligions FROM PUBLIC;
REVOKE ALL ON TABLE vwreligions FROM easygp;
GRANT ALL ON TABLE vwreligions TO easygp;
GRANT ALL ON TABLE vwreligions TO ian;


SET search_path = contacts, pg_catalog;

--
-- Name: data_addresses_pk_seq; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON SEQUENCE data_addresses_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE data_addresses_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE data_addresses_pk_seq TO easygp;


--
-- Name: data_branches_pk_seq; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON SEQUENCE data_branches_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE data_branches_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE data_branches_pk_seq TO easygp;


--
-- Name: data_communications; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE data_communications FROM PUBLIC;
REVOKE ALL ON TABLE data_communications FROM easygp;
GRANT ALL ON TABLE data_communications TO easygp;
GRANT ALL ON TABLE data_communications TO ian;


--
-- Name: data_communications_pk_seq; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON SEQUENCE data_communications_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE data_communications_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE data_communications_pk_seq TO easygp;


--
-- Name: data_employees_pk_seq; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON SEQUENCE data_employees_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE data_employees_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE data_employees_pk_seq TO easygp;


--
-- Name: data_organisations_pk_seq; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON SEQUENCE data_organisations_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE data_organisations_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE data_organisations_pk_seq TO easygp;


--
-- Name: data_persons_pk_seq; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON SEQUENCE data_persons_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE data_persons_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE data_persons_pk_seq TO easygp;


--
-- Name: images_pk_seq; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON SEQUENCE images_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE images_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE images_pk_seq TO easygp;


--
-- Name: links_branches_comms; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE links_branches_comms FROM PUBLIC;
REVOKE ALL ON TABLE links_branches_comms FROM easygp;
GRANT ALL ON TABLE links_branches_comms TO easygp;
GRANT ALL ON TABLE links_branches_comms TO ian;


--
-- Name: links_branches_comms_pk_seq; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON SEQUENCE links_branches_comms_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE links_branches_comms_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE links_branches_comms_pk_seq TO easygp;


--
-- Name: links_employees_comms; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE links_employees_comms FROM PUBLIC;
REVOKE ALL ON TABLE links_employees_comms FROM easygp;
GRANT ALL ON TABLE links_employees_comms TO easygp;
GRANT ALL ON TABLE links_employees_comms TO ian;


--
-- Name: links_employees_comms_pk_seq; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON SEQUENCE links_employees_comms_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE links_employees_comms_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE links_employees_comms_pk_seq TO easygp;


--
-- Name: links_persons_addresses_pk_seq; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON SEQUENCE links_persons_addresses_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE links_persons_addresses_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE links_persons_addresses_pk_seq TO easygp;


--
-- Name: links_persons_comms; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE links_persons_comms FROM PUBLIC;
REVOKE ALL ON TABLE links_persons_comms FROM easygp;
GRANT ALL ON TABLE links_persons_comms TO easygp;
GRANT ALL ON TABLE links_persons_comms TO ian;


--
-- Name: links_persons_comms_pk_seq; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON SEQUENCE links_persons_comms_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE links_persons_comms_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE links_persons_comms_pk_seq TO easygp;


--
-- Name: lu_categories_pk_seq; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_categories_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_categories_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_categories_pk_seq TO easygp;


--
-- Name: lu_firstnames; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE lu_firstnames FROM PUBLIC;
REVOKE ALL ON TABLE lu_firstnames FROM easygp;
GRANT ALL ON TABLE lu_firstnames TO easygp;
GRANT ALL ON TABLE lu_firstnames TO ian;


--
-- Name: lu_firstnames_pk_seq; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_firstnames_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_firstnames_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_firstnames_pk_seq TO easygp;


--
-- Name: lu_misspelt_towns; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE lu_misspelt_towns FROM PUBLIC;
REVOKE ALL ON TABLE lu_misspelt_towns FROM easygp;
GRANT ALL ON TABLE lu_misspelt_towns TO easygp;
GRANT ALL ON TABLE lu_misspelt_towns TO ian;


--
-- Name: lu_mismatched_towns_pk_seq; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_mismatched_towns_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_mismatched_towns_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_mismatched_towns_pk_seq TO easygp;


--
-- Name: lu_surnames; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE lu_surnames FROM PUBLIC;
REVOKE ALL ON TABLE lu_surnames FROM easygp;
GRANT ALL ON TABLE lu_surnames TO easygp;
GRANT ALL ON TABLE lu_surnames TO ian;


--
-- Name: lu_surnames_pk_seq; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_surnames_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_surnames_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_surnames_pk_seq TO easygp;


--
-- Name: lu_title_pk_seq; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_title_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_title_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_title_pk_seq TO easygp;


--
-- Name: todo; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE todo FROM PUBLIC;
REVOKE ALL ON TABLE todo FROM easygp;
GRANT ALL ON TABLE todo TO easygp;
GRANT ALL ON TABLE todo TO ian;


--
-- Name: vwbranchescomms; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE vwbranchescomms FROM PUBLIC;
REVOKE ALL ON TABLE vwbranchescomms FROM easygp;
GRANT ALL ON TABLE vwbranchescomms TO easygp;
GRANT ALL ON TABLE vwbranchescomms TO ian;


--
-- Name: vwemployees; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE vwemployees FROM PUBLIC;
REVOKE ALL ON TABLE vwemployees FROM easygp;
GRANT ALL ON TABLE vwemployees TO easygp;
GRANT ALL ON TABLE vwemployees TO ian;


--
-- Name: vworganisationsbycategory; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE vworganisationsbycategory FROM PUBLIC;
REVOKE ALL ON TABLE vworganisationsbycategory FROM easygp;
GRANT ALL ON TABLE vworganisationsbycategory TO easygp;
GRANT ALL ON TABLE vworganisationsbycategory TO ian;


--
-- Name: vwpatients_pk_seq; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON SEQUENCE vwpatients_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE vwpatients_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE vwpatients_pk_seq TO easygp;


--
-- Name: vwpersonsaddresses; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE vwpersonsaddresses FROM PUBLIC;
REVOKE ALL ON TABLE vwpersonsaddresses FROM easygp;
GRANT ALL ON TABLE vwpersonsaddresses TO easygp;
GRANT ALL ON TABLE vwpersonsaddresses TO ian;


--
-- Name: vwpersonsexcludingpatients; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE vwpersonsexcludingpatients FROM PUBLIC;
REVOKE ALL ON TABLE vwpersonsexcludingpatients FROM easygp;
GRANT ALL ON TABLE vwpersonsexcludingpatients TO easygp;
GRANT ALL ON TABLE vwpersonsexcludingpatients TO ian;


--
-- Name: vwpersonsandemployeesaddresses; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE vwpersonsandemployeesaddresses FROM PUBLIC;
REVOKE ALL ON TABLE vwpersonsandemployeesaddresses FROM easygp;
GRANT ALL ON TABLE vwpersonsandemployeesaddresses TO easygp;
GRANT ALL ON TABLE vwpersonsandemployeesaddresses TO ian;


--
-- Name: vwpersonscomms; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE vwpersonscomms FROM PUBLIC;
REVOKE ALL ON TABLE vwpersonscomms FROM easygp;
GRANT ALL ON TABLE vwpersonscomms TO easygp;
GRANT ALL ON TABLE vwpersonscomms TO ian;


--
-- Name: vwpersonsemployeesbyoccupation; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE vwpersonsemployeesbyoccupation FROM PUBLIC;
REVOKE ALL ON TABLE vwpersonsemployeesbyoccupation FROM easygp;
GRANT ALL ON TABLE vwpersonsemployeesbyoccupation TO easygp;
GRANT ALL ON TABLE vwpersonsemployeesbyoccupation TO ian;


--
-- Name: vwtowns; Type: ACL; Schema: contacts; Owner: easygp
--

REVOKE ALL ON TABLE vwtowns FROM PUBLIC;
REVOKE ALL ON TABLE vwtowns FROM easygp;
GRANT ALL ON TABLE vwtowns TO easygp;
GRANT ALL ON TABLE vwtowns TO ian;


SET search_path = db, pg_catalog;

--
-- Name: lu_version; Type: ACL; Schema: db; Owner: easygp
--

REVOKE ALL ON TABLE lu_version FROM PUBLIC;
REVOKE ALL ON TABLE lu_version FROM easygp;
GRANT ALL ON TABLE lu_version TO easygp;
GRANT ALL ON TABLE lu_version TO ian;


SET search_path = defaults, pg_catalog;

--
-- Name: hl7_inboxes; Type: ACL; Schema: defaults; Owner: easygp
--

REVOKE ALL ON TABLE hl7_inboxes FROM PUBLIC;
REVOKE ALL ON TABLE hl7_inboxes FROM easygp;
GRANT ALL ON TABLE hl7_inboxes TO easygp;
GRANT ALL ON TABLE hl7_inboxes TO ian;


--
-- Name: hl7_message_destination_pk_seq; Type: ACL; Schema: defaults; Owner: easygp
--

REVOKE ALL ON SEQUENCE hl7_message_destination_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE hl7_message_destination_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE hl7_message_destination_pk_seq TO easygp;


--
-- Name: incoming_message_handling; Type: ACL; Schema: defaults; Owner: easygp
--

REVOKE ALL ON TABLE incoming_message_handling FROM PUBLIC;
REVOKE ALL ON TABLE incoming_message_handling FROM easygp;
GRANT ALL ON TABLE incoming_message_handling TO easygp;
GRANT ALL ON TABLE incoming_message_handling TO ian;


--
-- Name: incoming_message_handling_pk_seq; Type: ACL; Schema: defaults; Owner: easygp
--

REVOKE ALL ON SEQUENCE incoming_message_handling_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE incoming_message_handling_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE incoming_message_handling_pk_seq TO easygp;


--
-- Name: lu_link_printer_task; Type: ACL; Schema: defaults; Owner: easygp
--

REVOKE ALL ON TABLE lu_link_printer_task FROM PUBLIC;
REVOKE ALL ON TABLE lu_link_printer_task FROM easygp;
GRANT ALL ON TABLE lu_link_printer_task TO easygp;
GRANT ALL ON TABLE lu_link_printer_task TO ian;


--
-- Name: lu_link_printer_task_pk_seq; Type: ACL; Schema: defaults; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_link_printer_task_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_link_printer_task_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_link_printer_task_pk_seq TO easygp;


--
-- Name: lu_message_display_style; Type: ACL; Schema: defaults; Owner: easygp
--

REVOKE ALL ON TABLE lu_message_display_style FROM PUBLIC;
REVOKE ALL ON TABLE lu_message_display_style FROM easygp;
GRANT ALL ON TABLE lu_message_display_style TO easygp;
GRANT ALL ON TABLE lu_message_display_style TO ian;


--
-- Name: lu_message_display_style_pk_seq; Type: ACL; Schema: defaults; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_message_display_style_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_message_display_style_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_message_display_style_pk_seq TO easygp;


--
-- Name: lu_message_standard; Type: ACL; Schema: defaults; Owner: easygp
--

REVOKE ALL ON TABLE lu_message_standard FROM PUBLIC;
REVOKE ALL ON TABLE lu_message_standard FROM easygp;
GRANT ALL ON TABLE lu_message_standard TO easygp;
GRANT ALL ON TABLE lu_message_standard TO ian;


--
-- Name: lu_printer_host; Type: ACL; Schema: defaults; Owner: easygp
--

REVOKE ALL ON TABLE lu_printer_host FROM PUBLIC;
REVOKE ALL ON TABLE lu_printer_host FROM easygp;
GRANT ALL ON TABLE lu_printer_host TO easygp;
GRANT ALL ON TABLE lu_printer_host TO ian;


--
-- Name: lu_printer_host_pk_seq; Type: ACL; Schema: defaults; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_printer_host_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_printer_host_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_printer_host_pk_seq TO easygp;


--
-- Name: lu_printer_task; Type: ACL; Schema: defaults; Owner: easygp
--

REVOKE ALL ON TABLE lu_printer_task FROM PUBLIC;
REVOKE ALL ON TABLE lu_printer_task FROM easygp;
GRANT ALL ON TABLE lu_printer_task TO easygp;
GRANT ALL ON TABLE lu_printer_task TO ian;


--
-- Name: lu_printer_task_pk_seq; Type: ACL; Schema: defaults; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_printer_task_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_printer_task_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_printer_task_pk_seq TO easygp;


--
-- Name: script_coordinates; Type: ACL; Schema: defaults; Owner: easygp
--

REVOKE ALL ON TABLE script_coordinates FROM PUBLIC;
REVOKE ALL ON TABLE script_coordinates FROM easygp;
GRANT ALL ON TABLE script_coordinates TO easygp;
GRANT ALL ON TABLE script_coordinates TO ian;


--
-- Name: script_coordinates_pk_seq; Type: ACL; Schema: defaults; Owner: easygp
--

REVOKE ALL ON SEQUENCE script_coordinates_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE script_coordinates_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE script_coordinates_pk_seq TO easygp;


--
-- Name: temp; Type: ACL; Schema: defaults; Owner: easygp
--

REVOKE ALL ON TABLE temp FROM PUBLIC;
REVOKE ALL ON TABLE temp FROM easygp;
GRANT ALL ON TABLE temp TO easygp;
GRANT ALL ON TABLE temp TO ian;


--
-- Name: temp_pk_seq; Type: ACL; Schema: defaults; Owner: easygp
--

REVOKE ALL ON SEQUENCE temp_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE temp_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE temp_pk_seq TO easygp;


--
-- Name: vwprinterstasks; Type: ACL; Schema: defaults; Owner: easygp
--

REVOKE ALL ON TABLE vwprinterstasks FROM PUBLIC;
REVOKE ALL ON TABLE vwprinterstasks FROM easygp;
GRANT ALL ON TABLE vwprinterstasks TO easygp;
GRANT ALL ON TABLE vwprinterstasks TO ian;


SET search_path = documents, pg_catalog;

--
-- Name: documents_pk_seq; Type: ACL; Schema: documents; Owner: easygp
--

REVOKE ALL ON SEQUENCE documents_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE documents_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE documents_pk_seq TO easygp;


--
-- Name: lu_archive_site; Type: ACL; Schema: documents; Owner: easygp
--

REVOKE ALL ON TABLE lu_archive_site FROM PUBLIC;
REVOKE ALL ON TABLE lu_archive_site FROM easygp;
GRANT ALL ON TABLE lu_archive_site TO easygp;
GRANT ALL ON TABLE lu_archive_site TO ian;


--
-- Name: lu_archive_site_pk_seq; Type: ACL; Schema: documents; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_archive_site_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_archive_site_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_archive_site_pk_seq TO easygp;


--
-- Name: lu_display_as; Type: ACL; Schema: documents; Owner: easygp
--

REVOKE ALL ON TABLE lu_display_as FROM PUBLIC;
REVOKE ALL ON TABLE lu_display_as FROM easygp;
GRANT ALL ON TABLE lu_display_as TO easygp;
GRANT ALL ON TABLE lu_display_as TO ian;


--
-- Name: lu_message_standard_pk_seq; Type: ACL; Schema: documents; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_message_standard_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_message_standard_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_message_standard_pk_seq TO easygp;


--
-- Name: observations; Type: ACL; Schema: documents; Owner: easygp
--

REVOKE ALL ON TABLE observations FROM PUBLIC;
REVOKE ALL ON TABLE observations FROM easygp;
GRANT ALL ON TABLE observations TO easygp;
GRANT ALL ON TABLE observations TO ian;


--
-- Name: observations_pk_seq; Type: ACL; Schema: documents; Owner: easygp
--

REVOKE ALL ON SEQUENCE observations_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE observations_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE observations_pk_seq TO easygp;


--
-- Name: vwgraphableobservations; Type: ACL; Schema: documents; Owner: easygp
--

REVOKE ALL ON TABLE vwgraphableobservations FROM PUBLIC;
REVOKE ALL ON TABLE vwgraphableobservations FROM easygp;
GRANT ALL ON TABLE vwgraphableobservations TO easygp;
GRANT ALL ON TABLE vwgraphableobservations TO ian;


--
-- Name: patientshba1cover75; Type: ACL; Schema: documents; Owner: easygp
--

REVOKE ALL ON TABLE patientshba1cover75 FROM PUBLIC;
REVOKE ALL ON TABLE patientshba1cover75 FROM easygp;
GRANT ALL ON TABLE patientshba1cover75 TO easygp;
GRANT ALL ON TABLE patientshba1cover75 TO ian;


--
-- Name: sending_entities_pk_seq; Type: ACL; Schema: documents; Owner: easygp
--

REVOKE ALL ON SEQUENCE sending_entities_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE sending_entities_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE sending_entities_pk_seq TO easygp;


--
-- Name: signed_off; Type: ACL; Schema: documents; Owner: easygp
--

REVOKE ALL ON TABLE signed_off FROM PUBLIC;
REVOKE ALL ON TABLE signed_off FROM easygp;
GRANT ALL ON TABLE signed_off TO easygp;
GRANT ALL ON TABLE signed_off TO ian;


--
-- Name: signed_off_pk_seq; Type: ACL; Schema: documents; Owner: easygp
--

REVOKE ALL ON SEQUENCE signed_off_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE signed_off_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE signed_off_pk_seq TO easygp;


--
-- Name: unmatched_patients_pk_seq; Type: ACL; Schema: documents; Owner: easygp
--

REVOKE ALL ON SEQUENCE unmatched_patients_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE unmatched_patients_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE unmatched_patients_pk_seq TO easygp;


--
-- Name: unmatched_staff_pk_seq; Type: ACL; Schema: documents; Owner: easygp
--

REVOKE ALL ON SEQUENCE unmatched_staff_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE unmatched_staff_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE unmatched_staff_pk_seq TO easygp;


--
-- Name: vwhba1cover75; Type: ACL; Schema: documents; Owner: easygp
--

REVOKE ALL ON TABLE vwhba1cover75 FROM PUBLIC;
REVOKE ALL ON TABLE vwhba1cover75 FROM easygp;
GRANT ALL ON TABLE vwhba1cover75 TO easygp;
GRANT ALL ON TABLE vwhba1cover75 TO ian;


--
-- Name: vwhl7filesimported; Type: ACL; Schema: documents; Owner: easygp
--

REVOKE ALL ON TABLE vwhl7filesimported FROM PUBLIC;
REVOKE ALL ON TABLE vwhl7filesimported FROM easygp;
GRANT ALL ON TABLE vwhl7filesimported TO easygp;
GRANT ALL ON TABLE vwhl7filesimported TO ian;


--
-- Name: vwinboxstaff; Type: ACL; Schema: documents; Owner: easygp
--

REVOKE ALL ON TABLE vwinboxstaff FROM PUBLIC;
REVOKE ALL ON TABLE vwinboxstaff FROM easygp;
GRANT ALL ON TABLE vwinboxstaff TO easygp;
GRANT ALL ON TABLE vwinboxstaff TO ian;


--
-- Name: vwobservations; Type: ACL; Schema: documents; Owner: easygp
--

REVOKE ALL ON TABLE vwobservations FROM PUBLIC;
REVOKE ALL ON TABLE vwobservations FROM easygp;
GRANT ALL ON TABLE vwobservations TO easygp;
GRANT ALL ON TABLE vwobservations TO ian;


SET search_path = drugs, pg_catalog;

--
-- Name: chapters; Type: ACL; Schema: drugs; Owner: easygp
--

REVOKE ALL ON TABLE chapters FROM PUBLIC;
REVOKE ALL ON TABLE chapters FROM easygp;
GRANT ALL ON TABLE chapters TO easygp;
GRANT ALL ON TABLE chapters TO ian;


--
-- Name: clinical_effects; Type: ACL; Schema: drugs; Owner: easygp
--

REVOKE ALL ON TABLE clinical_effects FROM PUBLIC;
REVOKE ALL ON TABLE clinical_effects FROM easygp;
GRANT ALL ON TABLE clinical_effects TO easygp;
GRANT ALL ON TABLE clinical_effects TO ian;


--
-- Name: clinical_effects_pk_seq; Type: ACL; Schema: drugs; Owner: easygp
--

REVOKE ALL ON SEQUENCE clinical_effects_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE clinical_effects_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE clinical_effects_pk_seq TO easygp;


--
-- Name: company; Type: ACL; Schema: drugs; Owner: easygp
--

REVOKE ALL ON TABLE company FROM PUBLIC;
REVOKE ALL ON TABLE company FROM easygp;
GRANT ALL ON TABLE company TO easygp;
GRANT ALL ON TABLE company TO ian;


--
-- Name: evidence_levels; Type: ACL; Schema: drugs; Owner: easygp
--

REVOKE ALL ON TABLE evidence_levels FROM PUBLIC;
REVOKE ALL ON TABLE evidence_levels FROM easygp;
GRANT ALL ON TABLE evidence_levels TO easygp;
GRANT ALL ON TABLE evidence_levels TO ian;


--
-- Name: flags; Type: ACL; Schema: drugs; Owner: easygp
--

REVOKE ALL ON TABLE flags FROM PUBLIC;
REVOKE ALL ON TABLE flags FROM easygp;
GRANT ALL ON TABLE flags TO easygp;
GRANT ALL ON TABLE flags TO ian;


--
-- Name: flags_pk_seq; Type: ACL; Schema: drugs; Owner: easygp
--

REVOKE ALL ON SEQUENCE flags_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE flags_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE flags_pk_seq TO easygp;


--
-- Name: info; Type: ACL; Schema: drugs; Owner: easygp
--

REVOKE ALL ON TABLE info FROM PUBLIC;
REVOKE ALL ON TABLE info FROM easygp;
GRANT ALL ON TABLE info TO easygp;
GRANT ALL ON TABLE info TO ian;


--
-- Name: info_pk_seq; Type: ACL; Schema: drugs; Owner: easygp
--

REVOKE ALL ON SEQUENCE info_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE info_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE info_pk_seq TO easygp;


--
-- Name: link_atc_info; Type: ACL; Schema: drugs; Owner: easygp
--

REVOKE ALL ON TABLE link_atc_info FROM PUBLIC;
REVOKE ALL ON TABLE link_atc_info FROM easygp;
GRANT ALL ON TABLE link_atc_info TO easygp;
GRANT ALL ON TABLE link_atc_info TO ian;


--
-- Name: link_category_info; Type: ACL; Schema: drugs; Owner: easygp
--

REVOKE ALL ON TABLE link_category_info FROM PUBLIC;
REVOKE ALL ON TABLE link_category_info FROM easygp;
GRANT ALL ON TABLE link_category_info TO easygp;
GRANT ALL ON TABLE link_category_info TO ian;


--
-- Name: link_flag_product; Type: ACL; Schema: drugs; Owner: easygp
--

REVOKE ALL ON TABLE link_flag_product FROM PUBLIC;
REVOKE ALL ON TABLE link_flag_product FROM easygp;
GRANT ALL ON TABLE link_flag_product TO easygp;
GRANT ALL ON TABLE link_flag_product TO ian;


--
-- Name: link_info_source; Type: ACL; Schema: drugs; Owner: easygp
--

REVOKE ALL ON TABLE link_info_source FROM PUBLIC;
REVOKE ALL ON TABLE link_info_source FROM easygp;
GRANT ALL ON TABLE link_info_source TO easygp;
GRANT ALL ON TABLE link_info_source TO ian;


--
-- Name: patient_categories; Type: ACL; Schema: drugs; Owner: easygp
--

REVOKE ALL ON TABLE patient_categories FROM PUBLIC;
REVOKE ALL ON TABLE patient_categories FROM easygp;
GRANT ALL ON TABLE patient_categories TO easygp;
GRANT ALL ON TABLE patient_categories TO ian;


--
-- Name: pbs; Type: ACL; Schema: drugs; Owner: easygp
--

REVOKE ALL ON TABLE pbs FROM PUBLIC;
REVOKE ALL ON TABLE pbs FROM easygp;
GRANT ALL ON TABLE pbs TO easygp;
GRANT ALL ON TABLE pbs TO ian;


--
-- Name: pbsconvert; Type: ACL; Schema: drugs; Owner: easygp
--

REVOKE ALL ON TABLE pbsconvert FROM PUBLIC;
REVOKE ALL ON TABLE pbsconvert FROM easygp;
GRANT ALL ON TABLE pbsconvert TO easygp;
GRANT ALL ON TABLE pbsconvert TO ian;


--
-- Name: pharmacologic_mechanisms; Type: ACL; Schema: drugs; Owner: easygp
--

REVOKE ALL ON TABLE pharmacologic_mechanisms FROM PUBLIC;
REVOKE ALL ON TABLE pharmacologic_mechanisms FROM easygp;
GRANT ALL ON TABLE pharmacologic_mechanisms TO easygp;
GRANT ALL ON TABLE pharmacologic_mechanisms TO ian;


--
-- Name: product_information_files; Type: ACL; Schema: drugs; Owner: easygp
--

REVOKE ALL ON TABLE product_information_files FROM PUBLIC;
REVOKE ALL ON TABLE product_information_files FROM easygp;
GRANT ALL ON TABLE product_information_files TO easygp;
GRANT ALL ON TABLE product_information_files TO ian;


--
-- Name: product_information_unmatched; Type: ACL; Schema: drugs; Owner: easygp
--

REVOKE ALL ON TABLE product_information_unmatched FROM PUBLIC;
REVOKE ALL ON TABLE product_information_unmatched FROM easygp;
GRANT ALL ON TABLE product_information_unmatched TO easygp;
GRANT ALL ON TABLE product_information_unmatched TO ian;


--
-- Name: severity_level; Type: ACL; Schema: drugs; Owner: easygp
--

REVOKE ALL ON TABLE severity_level FROM PUBLIC;
REVOKE ALL ON TABLE severity_level FROM easygp;
GRANT ALL ON TABLE severity_level TO easygp;
GRANT ALL ON TABLE severity_level TO ian;


--
-- Name: sources; Type: ACL; Schema: drugs; Owner: easygp
--

REVOKE ALL ON TABLE sources FROM PUBLIC;
REVOKE ALL ON TABLE sources FROM easygp;
GRANT ALL ON TABLE sources TO easygp;
GRANT ALL ON TABLE sources TO ian;


--
-- Name: topic; Type: ACL; Schema: drugs; Owner: easygp
--

REVOKE ALL ON TABLE topic FROM PUBLIC;
REVOKE ALL ON TABLE topic FROM easygp;
GRANT ALL ON TABLE topic TO easygp;
GRANT ALL ON TABLE topic TO ian;


--
-- Name: vwdistinctbrandsforgenericproduct; Type: ACL; Schema: drugs; Owner: easygp
--

REVOKE ALL ON TABLE vwdistinctbrandsforgenericproduct FROM PUBLIC;
REVOKE ALL ON TABLE vwdistinctbrandsforgenericproduct FROM easygp;
GRANT ALL ON TABLE vwdistinctbrandsforgenericproduct TO easygp;
GRANT ALL ON TABLE vwdistinctbrandsforgenericproduct TO ian;


--
-- Name: vwpbs; Type: ACL; Schema: drugs; Owner: easygp
--

REVOKE ALL ON TABLE vwpbs FROM PUBLIC;
REVOKE ALL ON TABLE vwpbs FROM easygp;
GRANT ALL ON TABLE vwpbs TO easygp;
GRANT ALL ON TABLE vwpbs TO ian;


--
-- Name: vwdrugs; Type: ACL; Schema: drugs; Owner: easygp
--

REVOKE ALL ON TABLE vwdrugs FROM PUBLIC;
REVOKE ALL ON TABLE vwdrugs FROM easygp;
GRANT ALL ON TABLE vwdrugs TO easygp;
GRANT ALL ON TABLE vwdrugs TO ian;


--
-- Name: vwdrugs1; Type: ACL; Schema: drugs; Owner: easygp
--

REVOKE ALL ON TABLE vwdrugs1 FROM PUBLIC;
REVOKE ALL ON TABLE vwdrugs1 FROM easygp;
GRANT ALL ON TABLE vwdrugs1 TO easygp;
GRANT ALL ON TABLE vwdrugs1 TO ian;


--
-- Name: vwgeneric; Type: ACL; Schema: drugs; Owner: easygp
--

REVOKE ALL ON TABLE vwgeneric FROM PUBLIC;
REVOKE ALL ON TABLE vwgeneric FROM easygp;
GRANT ALL ON TABLE vwgeneric TO easygp;
GRANT ALL ON TABLE vwgeneric TO ian;


SET search_path = import_export, pg_catalog;

--
-- Name: lu_demographics_field_templates; Type: ACL; Schema: import_export; Owner: easygp
--

REVOKE ALL ON TABLE lu_demographics_field_templates FROM PUBLIC;
REVOKE ALL ON TABLE lu_demographics_field_templates FROM easygp;
GRANT ALL ON TABLE lu_demographics_field_templates TO easygp;
GRANT ALL ON TABLE lu_demographics_field_templates TO ian;


--
-- Name: lu_demographics_field_templates_pk_seq; Type: ACL; Schema: import_export; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_demographics_field_templates_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_demographics_field_templates_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_demographics_field_templates_pk_seq TO easygp;


--
-- Name: lu_misspelt_user_request_tags; Type: ACL; Schema: import_export; Owner: easygp
--

REVOKE ALL ON TABLE lu_misspelt_user_request_tags FROM PUBLIC;
REVOKE ALL ON TABLE lu_misspelt_user_request_tags FROM easygp;
GRANT ALL ON TABLE lu_misspelt_user_request_tags TO easygp;
GRANT ALL ON TABLE lu_misspelt_user_request_tags TO ian;


--
-- Name: lu_source_program; Type: ACL; Schema: import_export; Owner: easygp
--

REVOKE ALL ON TABLE lu_source_program FROM PUBLIC;
REVOKE ALL ON TABLE lu_source_program FROM easygp;
GRANT ALL ON TABLE lu_source_program TO easygp;
GRANT ALL ON TABLE lu_source_program TO ian;


--
-- Name: lu_source_program_pk_seq; Type: ACL; Schema: import_export; Owner: easygp
--

REVOKE ALL ON SEQUENCE lu_source_program_pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lu_source_program_pk_seq FROM easygp;
GRANT ALL ON SEQUENCE lu_source_program_pk_seq TO easygp;


--
-- Name: vwdemographictemplates; Type: ACL; Schema: import_export; Owner: easygp
--

REVOKE ALL ON TABLE vwdemographictemplates FROM PUBLIC;
REVOKE ALL ON TABLE vwdemographictemplates FROM easygp;
GRANT ALL ON TABLE vwdemographictemplates TO easygp;
GRANT ALL ON TABLE vwdemographictemplates TO ian;


SET search_path = public, pg_catalog;

--
-- Name: dailymed; Type: ACL; Schema: public; Owner: easygp
--

REVOKE ALL ON TABLE dailymed FROM PUBLIC;
REVOKE ALL ON TABLE dailymed FROM easygp;
GRANT ALL ON TABLE dailymed TO easygp;
GRANT ALL ON TABLE dailymed TO ian;


--
-- Name: forms1; Type: ACL; Schema: public; Owner: easygp
--

REVOKE ALL ON TABLE forms1 FROM PUBLIC;
REVOKE ALL ON TABLE forms1 FROM easygp;
GRANT ALL ON TABLE forms1 TO easygp;
GRANT ALL ON TABLE forms1 TO ian;


--
-- Name: inventory_items_lent; Type: ACL; Schema: public; Owner: easygp
--

REVOKE ALL ON TABLE inventory_items_lent FROM PUBLIC;
REVOKE ALL ON TABLE inventory_items_lent FROM easygp;
GRANT ALL ON TABLE inventory_items_lent TO easygp;
GRANT ALL ON TABLE inventory_items_lent TO ian;


--
-- Name: lu_modes; Type: ACL; Schema: public; Owner: easygp
--

REVOKE ALL ON TABLE lu_modes FROM PUBLIC;
REVOKE ALL ON TABLE lu_modes FROM easygp;
GRANT ALL ON TABLE lu_modes TO easygp;
GRANT ALL ON TABLE lu_modes TO ian;


--
-- Name: rawpbs; Type: ACL; Schema: public; Owner: easygp
--

REVOKE ALL ON TABLE rawpbs FROM PUBLIC;
REVOKE ALL ON TABLE rawpbs FROM easygp;
GRANT ALL ON TABLE rawpbs TO easygp;
GRANT ALL ON TABLE rawpbs TO ian;


--
-- Name: web; Type: ACL; Schema: public; Owner: easygp
--

REVOKE ALL ON TABLE web FROM PUBLIC;
REVOKE ALL ON TABLE web FROM easygp;
GRANT ALL ON TABLE web TO easygp;
GRANT ALL ON TABLE web TO ian;


SET search_path = research, pg_catalog;

--
-- Name: diabetes_patients_latest_hba1c; Type: ACL; Schema: research; Owner: easygp
--

REVOKE ALL ON TABLE diabetes_patients_latest_hba1c FROM PUBLIC;
REVOKE ALL ON TABLE diabetes_patients_latest_hba1c FROM easygp;
GRANT ALL ON TABLE diabetes_patients_latest_hba1c TO easygp;
GRANT ALL ON TABLE diabetes_patients_latest_hba1c TO ian;


--
-- Name: diabetes_patients_with_hba1c; Type: ACL; Schema: research; Owner: easygp
--

REVOKE ALL ON TABLE diabetes_patients_with_hba1c FROM PUBLIC;
REVOKE ALL ON TABLE diabetes_patients_with_hba1c FROM easygp;
GRANT ALL ON TABLE diabetes_patients_with_hba1c TO easygp;
GRANT ALL ON TABLE diabetes_patients_with_hba1c TO ian;


--
-- Name: patientsnameshba1cover75; Type: ACL; Schema: research; Owner: easygp
--

REVOKE ALL ON TABLE patientsnameshba1cover75 FROM PUBLIC;
REVOKE ALL ON TABLE patientsnameshba1cover75 FROM easygp;
GRANT ALL ON TABLE patientsnameshba1cover75 TO easygp;
GRANT ALL ON TABLE patientsnameshba1cover75 TO ian;


--
-- Name: vwdiabetes_patients_with_hba1c; Type: ACL; Schema: research; Owner: easygp
--

REVOKE ALL ON TABLE vwdiabetes_patients_with_hba1c FROM PUBLIC;
REVOKE ALL ON TABLE vwdiabetes_patients_with_hba1c FROM easygp;
GRANT ALL ON TABLE vwdiabetes_patients_with_hba1c TO easygp;
GRANT ALL ON TABLE vwdiabetes_patients_with_hba1c TO ian;


--
-- Name: vwdiabetics_with_ldlcholesterol; Type: ACL; Schema: research; Owner: easygp
--

REVOKE ALL ON TABLE vwdiabetics_with_ldlcholesterol FROM PUBLIC;
REVOKE ALL ON TABLE vwdiabetics_with_ldlcholesterol FROM easygp;
GRANT ALL ON TABLE vwdiabetics_with_ldlcholesterol TO easygp;
GRANT ALL ON TABLE vwdiabetics_with_ldlcholesterol TO ian;


--
-- Name: vwmicroalbuminuria; Type: ACL; Schema: research; Owner: easygp
--

REVOKE ALL ON TABLE vwmicroalbuminuria FROM PUBLIC;
REVOKE ALL ON TABLE vwmicroalbuminuria FROM easygp;
GRANT ALL ON TABLE vwmicroalbuminuria TO easygp;
GRANT ALL ON TABLE vwmicroalbuminuria TO ian;


--
-- Name: vwdiabetics_with_microalbumins; Type: ACL; Schema: research; Owner: easygp
--

REVOKE ALL ON TABLE vwdiabetics_with_microalbumins FROM PUBLIC;
REVOKE ALL ON TABLE vwdiabetics_with_microalbumins FROM easygp;
GRANT ALL ON TABLE vwdiabetics_with_microalbumins TO easygp;
GRANT ALL ON TABLE vwdiabetics_with_microalbumins TO ian;


--
-- Name: vwdiabeticsegfr; Type: ACL; Schema: research; Owner: easygp
--

REVOKE ALL ON TABLE vwdiabeticsegfr FROM PUBLIC;
REVOKE ALL ON TABLE vwdiabeticsegfr FROM easygp;
GRANT ALL ON TABLE vwdiabeticsegfr TO easygp;
GRANT ALL ON TABLE vwdiabeticsegfr TO ian;


--
-- Name: vwldh; Type: ACL; Schema: research; Owner: easygp
--

REVOKE ALL ON TABLE vwldh FROM PUBLIC;
REVOKE ALL ON TABLE vwldh FROM easygp;
GRANT ALL ON TABLE vwldh TO easygp;
GRANT ALL ON TABLE vwldh TO ian;


--
-- Name: vwldlcholesterol; Type: ACL; Schema: research; Owner: easygp
--

REVOKE ALL ON TABLE vwldlcholesterol FROM PUBLIC;
REVOKE ALL ON TABLE vwldlcholesterol FROM easygp;
GRANT ALL ON TABLE vwldlcholesterol TO easygp;
GRANT ALL ON TABLE vwldlcholesterol TO ian;


--
-- Name: vwmostrecenteyerelateddocuments; Type: ACL; Schema: research; Owner: easygp
--

REVOKE ALL ON TABLE vwmostrecenteyerelateddocuments FROM PUBLIC;
REVOKE ALL ON TABLE vwmostrecenteyerelateddocuments FROM easygp;
GRANT ALL ON TABLE vwmostrecenteyerelateddocuments TO easygp;
GRANT ALL ON TABLE vwmostrecenteyerelateddocuments TO ian;


--
-- Name: vwtotalcholesterol; Type: ACL; Schema: research; Owner: easygp
--

REVOKE ALL ON TABLE vwtotalcholesterol FROM PUBLIC;
REVOKE ALL ON TABLE vwtotalcholesterol FROM easygp;
GRANT ALL ON TABLE vwtotalcholesterol TO easygp;
GRANT ALL ON TABLE vwtotalcholesterol TO ian;


--
-- PostgreSQL database dump complete
--

