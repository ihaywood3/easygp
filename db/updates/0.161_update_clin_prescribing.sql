-- new tables for prescribing

DROP TABLE clin_prescribing.medications cascade;

CREATE TABLE clin_prescribing.medications
(
  pk serial primary key,
  active boolean DEFAULT false, -- If true, the medication is on the patients...
  deleted boolean DEFAULT false, -- if true the record is marked deleted, e.g could have been prescribed for the...
  start_date date NOT NULL DEFAULT now(),
  last_date date NOT NULL DEFAULT now(),
  fk_generic_product uuid NOT NULL
);
ALTER TABLE clin_prescribing.medications OWNER TO easygp;
GRANT ALL ON TABLE clin_prescribing.medications TO easygp;
GRANT ALL ON TABLE clin_prescribing.medications TO staff;

COMMENT ON TABLE clin_prescribing.medications IS 
'The medications table holds a list of unique medications for each patient';

COMMENT ON COLUMN clin_prescribing.medications.active IS '
If true, the medication is on the patients active medication list';
COMMENT ON COLUMN clin_prescribing.medications.deleted IS 
'if true the record is marked deleted, e.g could have been prescribed for the
 wrong patient, but has been deleted by the user, hence this record remains
 part of an audit trail';
COMMENT ON COLUMN clin_prescribing.medications.start_date IS 
'the date the medication was started';
COMMENT ON COLUMN clin_prescribing.medications.last_date IS 
'the last date the medication was prescibed';
COMMENT ON COLUMN clin_prescribing.medications.fk_generic_product IS 
'the last date the medication was prescibed
 this is the foreign key to the drugs.product table which gives then
 dispensable form of a generic drug including strength, package size etc';


DROP TABLE clin_prescribing.prescribed;

CREATE TABLE clin_prescribing.prescribed
(
  pk serial primary key,
  fk_consult integer NOT NULL,
  fk_medication integer NOT NULL,
  fk_brand uuid,
  date_on_script date NOT NULL, -- The actual date on the script may not be the consulation date, can be back/forwarded dated,...
  repeats integer NOT NULL DEFAULT 0, -- The actual number of repeats...
  quantity integer NOT NULL, -- The quantity on the script...
  fk_instruction integer NOT NULL,
  fk_prescribed_for integer,
  pbscode text,
  restriction_code text,
  reg24 boolean DEFAULT false, -- If true reg24 allows us to tell the...
  authority_script_number integer, -- the pbs requires a unique script number for an authority item, pretty stupid, but a number that...
  authority_approval_number text, -- either the steamlined authority number or the phone approval number obtained from a pbs operator
  authority_post_to_patient boolean DEFAULT false,
  script_number integer,
  fk_code text, -- foreign key to references coding.generic_terms, if not null then the reason for using script...
  suppress_reason boolean,
  concession_details text,
  brand_substitution boolean DEFAULT true,
  fk_increased_quantity_authority_reason integer,
  fk_lu_pbs_script_type integer,
  fk_progress_note integer,
  deleted boolean DEFAULT false,
  CONSTRAINT prescribed_fk_lu_pbs_script_type_fkey FOREIGN KEY (fk_lu_pbs_script_type)
      REFERENCES clin_prescribing.lu_pbs_script_type (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
  
);

ALTER TABLE clin_prescribing.prescribed OWNER TO easygp;
GRANT ALL ON TABLE clin_prescribing.prescribed TO easygp;
GRANT ALL ON TABLE clin_prescribing.prescribed TO staff;

COMMENT ON TABLE clin_prescribing.prescribed IS 
	'Every single item prescribed has an entry here
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

COMMENT ON COLUMN clin_prescribing.prescribed.fk_consult is
'foreign key to clin_consult.consult table';
COMMENT ON COLUMN clin_prescribing.prescribed.date_on_script IS '
The actual date on the script may not be the consulation date, can be back/forwarded dated,
without this ability GP''s may as well pack up and go
home though illegal in theory';
COMMENT ON COLUMN clin_prescribing.prescribed.repeats IS '
The actual number of repeats
may not be the max repeats allowed
by the pbs accessed by fk_pbs';
COMMENT ON COLUMN clin_prescribing.prescribed.quantity IS '
The quantity on the script
May not be the actual quanitity allowed on the pbs
e.g sometimes we may prescribe diazepam in small quantities';
COMMENT ON COLUMN clin_prescribing.prescribed.reg24 IS '
If true reg24 allows us to tell the
pharmacist to dispense the script and all 
its repeats at once';
COMMENT ON COLUMN clin_prescribing.prescribed.authority_script_number IS 
'the pbs requires a unique script number for an authority item, pretty stupid, but a number that
 increments by 11. This is distinct from the streamlined approval number or phone approval number';
COMMENT ON COLUMN clin_prescribing.prescribed.authority_approval_number IS 
'either the steamlined authority number or the phone approval number obtained from a pbs operator';
COMMENT ON COLUMN clin_prescribing.prescribed.fk_code IS 
'foreign key to references coding.generic_terms, if not null then the reason for using script
   is coded';


CREATE OR REPLACE VIEW clin_prescribing.vwprescribeditems AS 
 SELECT prescribed.pk AS pk_view, medications.pk AS fk_medication, medications.start_date, 
 medications.last_date, medications.active, medications.deleted AS medication_deleted, 
 medications.fk_generic_product, consult.pk AS fk_consult, consult.consult_date AS date_script_written, 
 consult.fk_patient, product.generic, brand.brand, product.strength, brand.product_information_filename, 
 form.form, brand.pk AS fk_brand, prescribed.pk AS fk_prescribed, prescribed.repeats, 
 prescribed.date_on_script, prescribed.quantity, prescribed_for.prescribed_for, prescribed.deleted AS prescribed_deleted, 
 instructions.instruction, vwstaff.wholename AS staff_prescribed_wholename, vwstaff.title AS staff_prescribed_title, 
 vwstaff.provider_number, product.atccode, product.salt, product.fk_form, product.fk_schedule, 
 product.salt_strength, prescribed.fk_instruction, prescribed.fk_prescribed_for, 
 prescribed.pbscode, prescribed.fk_lu_pbs_script_type, prescribed.suppress_reason, 
 prescribed.restriction_code, prescribed.fk_code, prescribed.fk_increased_quantity_authority_reason, 
 increased_quantity_authority_reasons.reason AS increased_authority_reason, lu_pbs_script_type.type AS pbs_script_type, 
 restriction.streamlined, restriction.restriction, restriction.restriction_type, schedules.schedule
   FROM clin_consult.consult
   JOIN admin.vwstaff ON consult.fk_staff = vwstaff.fk_staff
   JOIN clin_prescribing.prescribed ON consult.pk = prescribed.fk_consult
   JOIN clin_prescribing.medications medications ON prescribed.fk_medication = medications.pk
   JOIN clin_prescribing.prescribed_for ON prescribed.fk_prescribed_for = prescribed_for.pk
   JOIN clin_prescribing.instructions ON prescribed.fk_instruction = instructions.pk
   JOIN clin_prescribing.lu_pbs_script_type ON prescribed.fk_lu_pbs_script_type = lu_pbs_script_type.pk
   LEFT JOIN drugs.restriction ON prescribed.pbscode = restriction.pbscode::text AND prescribed.restriction_code = restriction.code::text
   LEFT JOIN drugs.brand ON prescribed.fk_brand = brand.pk
   JOIN drugs.product ON medications.fk_generic_product = product.pk
   JOIN drugs.schedules ON product.fk_schedule = schedules.pk
   JOIN drugs.form ON product.fk_form = form.pk
   LEFT JOIN clin_prescribing.increased_quantity_authority_reasons ON prescribed.fk_increased_quantity_authority_reason = increased_quantity_authority_reasons.pk;

ALTER TABLE clin_prescribing.vwprescribeditems OWNER TO easygp;
GRANT ALL ON TABLE clin_prescribing.vwprescribeditems TO easygp;
GRANT ALL ON TABLE clin_prescribing.vwprescribeditems TO staff;

Comment on view clin_prescribing.vwprescribeditems is
'This view contains every single drug prescribed for all patients';



truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 161);

