alter table clerical.data_patients drop constraint "data_patients_pcehr_consent_check";
alter table clerical.data_patients add constraint "data_patients_pcehr_consent_check" CHECK (pcehr_consent = ANY (ARRAY['n'::bpchar, 'c'::bpchar, 'e'::bpchar, 'r'::bpchar, 'x'::bpchar, 'h'::bpchar, 'd'::bpchar]));

comment on column clerical.data_patients.pcehr_consent is 'consent status. n=not asked yet, c=consented, x=not eligible (tourist, asylum-seeker, etc), r=refused, e=error, h=details cHange,d=deceased';


CREATE OR REPLACE FUNCTION clerical.create_patient_new_ihi() RETURNS trigger AS $new_ihi$
BEGIN
	EXECUTE 'NOTIFY newihi';
	RETURN NEW;
END;
$new_ihi$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION clerical.person_death() RETURNS trigger AS $x$
BEGIN
	EXECUTE 'NOTIFY death';
	RETURN NEW;
END;
$x$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION clerical.updated_patient_new_ihi() RETURNS trigger AS $new_ihi$
BEGIN
	NEW.pcehr_consent := 'h';
	EXECUTE 'NOTIFY newihi';
	RETURN NEW;
END;
$new_ihi$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION clerical.updated_person_new_ihi() RETURNS trigger AS $xyz$
BEGIN
  UPDATE clerical.data_patients SET pcehr_consent ='h' WHERE fk_person = NEW.pk AND pcehr_consent IN ('e','c');
  EXECUTE 'NOTIFY newihi';
  RETURN NEW;
END;
$xyz$ LANGUAGE plpgsql;

CREATE TRIGGER ihi_new BEFORE INSERT ON clerical.data_patients
    FOR EACH ROW 
    WHEN (NEW.pcehr_consent = 'c' AND NEW.ihi IS NULL)
    EXECUTE PROCEDURE clerical.create_patient_new_ihi();

CREATE TRIGGER ihi_update BEFORE UPDATE ON clerical.data_patients
    FOR EACH ROW 
    WHEN (NEW.pcehr_consent IN ('c','h','e') AND (
    	 		     NEW.ihi IS NULL OR 
    	 		     (NEW.medicare_number <> OLD.medicare_number AND NEW.medicare_number IS NOT NULL) OR
			     (NEW.veteran_number <> OLD.veteran_number AND NEW.veteran_number IS NOT NULL)))
    EXECUTE PROCEDURE clerical.updated_patient_new_ihi();

CREATE TRIGGER persons_ihi_update BEFORE UPDATE ON contacts.data_persons
       FOR EACH ROW
       WHEN (NEW.firstname <> OLD.surname OR NEW.surname <> OLD.surname OR NEW.birthdate <> OLD.birthdate)
       EXECUTE PROCEDURE clerical.updated_person_new_ihi();

CREATE TRIGGER "death" BEFORE UPDATE ON contacts.data_persons 
       	 FOR EACH ROW
	 WHEN (NEW.deceased AND OLD.deceased IS NOT TRUE)
	 EXECUTE PROCEDURE clerical.person_death();