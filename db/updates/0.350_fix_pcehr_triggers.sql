
CREATE OR REPLACE FUNCTION clerical.updated_patient_new_ihi()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
	NEW.pcehr_consent := 'h';
	EXECUTE 'NOTIFY newihi';
	RETURN NEW;
END;
$function$;


create trigger ihi_update2 BEFORE UPDATE ON clerical.data_patients FOR EACH ROW WHEN (new.pcehr_consent = 'v' and old.pcehr_consent='v' AND new.ihi::text <> old.ihi::text) EXECUTE PROCEDURE clerical.updated_patient_new_ihi();

drop trigger ihi_update on clerical.data_patients;

create trigger ihi_update BEFORE UPDATE ON clerical.data_patients FOR EACH ROW WHEN ((new.pcehr_consent = ANY (ARRAY['c'::bpchar, 'h'::bpchar, 'e'::bpchar, 'v'::bpchar])) AND (new.medicare_number::text <> old.medicare_number::text AND new.medicare_number IS NOT NULL OR new.veteran_number::text <> old.veteran_number::text AND new.veteran_number IS NOT NULL)) EXECUTE PROCEDURE clerical.updated_patient_new_ihi();

drop trigger ihi_new on clerical.data_patients;
create trigger ihi_new BEFORE INSERT ON clerical.data_patients FOR EACH ROW WHEN (new.pcehr_consent = 'c'::bpchar) EXECUTE PROCEDURE clerical.create_patient_new_ihi();

drop trigger ihi_new_provided on clerical.data_patients;
create trigger ihi_new_provided BEFORE UPDATE ON clerical.data_patients FOR EACH ROW WHEN (new.pcehr_consent = ANY (ARRAY['c'::bpchar, 'h'::bpchar])) EXECUTE PROCEDURE clerical.updated_patient_new_ihi();

CREATE OR REPLACE FUNCTION clerical.updated_person_new_ihi()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
  UPDATE clerical.data_patients SET pcehr_consent ='h' WHERE fk_person = NEW.pk AND pcehr_consent IN ('e','c','v');
  EXECUTE 'NOTIFY newihi';
  RETURN NEW;
END;
$function$;

CREATE OR REPLACE FUNCTION clerical.person_death()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
	EXECUTE 'NOTIFY death';
	RETURN NEW;
END;
$function$;


drop trigger death on contacts.data_persons;
create trigger death BEFORE UPDATE ON contacts.data_persons FOR EACH ROW WHEN (new.deceased AND old.deceased IS NOT TRUE) EXECUTE PROCEDURE clerical.person_death();
drop trigger person_ihi_update on contacts.data_persons;
create trigger person_ihi_update BEFORE UPDATE ON contacts.data_persons FOR EACH ROW WHEN (new.firstname <> old.firstname OR new.surname <> old.surname OR new.birthdate <> old.birthdate) EXECUTE PROCEDURE clerical.updated_person_new_ihi();



CREATE OR REPLACE FUNCTION clin_consult.notify_new_progress_note()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
DECLARE
    fkp integer;
BEGIN
  SElect into fkp fk_patient from clin_consult.consult where pk = NEW.fk_consult;
  EXECUTE 'NOTIFY new_progress_note, ''' || fkp || '|' || coalesce(NEW.linked_table,'clin_consult.progressnotes') || '''';
  RETURN NEW;
END;
$function$;

CREATE TRIGGER check_update
    BEFORE INSERT ON clin_consult.progressnotes
    FOR EACH ROW
    EXECUTE PROCEDURE clin_consult.notify_new_progress_note();

update db.lu_version set lu_minor=350;
