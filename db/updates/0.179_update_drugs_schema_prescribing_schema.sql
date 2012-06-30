-- alterations to function so that eg Aristocort 100gm x 2 has the spaces before/after the x
-- drop cascades to drugs.vwdrugs and  clin_prescribing.vwprescribeditems

DROP FUNCTION drugs.format_packsize(double precision, integer, integer) cascade;

CREATE OR REPLACE FUNCTION drugs.format_packsize(double precision, integer, integer)
  RETURNS text AS
$BODY$
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
      r := i;
    end if;
  end if;
  RETURN r;
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100;

ALTER FUNCTION drugs.format_packsize(double precision, integer, integer) OWNER TO easygp;

drop view clin_prescribing.vwprescribeditems;

CREATE OR REPLACE VIEW clin_prescribing.vwprescribeditems AS 
 SELECT prescribed.pk AS pk_view, medications.pk AS fk_medication, medications.start_date, medications.last_date, 
 medications.active, medications.deleted AS medication_deleted, medications.fk_generic_product, 
 consult.pk AS fk_consult, consult.consult_date AS date_script_written, consult.fk_patient, 
 product.generic, brand.brand, product.strength, drugs.format_strength(product.strength) as display_strength,
 product.fk_form, product.fk_schedule, product.salt_strength, 
 drugs.format_packsize(product.amount, product.amount_unit, product.pack_size) AS display_packsize,
 form.form, 
 brand.pk AS fk_brand, brand.product_information_filename, prescribed.pk AS fk_prescribed, prescribed.repeats, 
 prescribed.date_on_script, prescribed.quantity, prescribed_for.prescribed_for, 
 prescribed.deleted AS prescribed_deleted, prescribed.authority_reason, 
 prescribed.print_reason, instructions.instruction, vwstaff.wholename AS staff_prescribed_wholename, 
 vwstaff.title AS staff_prescribed_title, vwstaff.provider_number, product.atccode, product.salt, 
 prescribed.fk_instruction, 
 prescribed.fk_prescribed_for, prescribed.pbscode, prescribed.fk_lu_pbs_script_type, 
 prescribed.restriction_code, prescribed.fk_code, lu_pbs_script_type.type AS pbs_script_type, 
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
   LEFT JOIN drugs.schedules ON product.fk_schedule = schedules.pk
   JOIN drugs.form ON product.fk_form = form.pk;

ALTER TABLE clin_prescribing.vwprescribeditems OWNER TO easygp;
GRANT ALL ON TABLE clin_prescribing.vwprescribeditems TO easygp;
GRANT ALL ON TABLE clin_prescribing.vwprescribeditems TO staff;
COMMENT ON VIEW clin_prescribing.vwprescribeditems IS 'This view contains every single drug prescribed for all patients';

CREATE OR REPLACE VIEW drugs.vwdrugs AS 
 SELECT (brand.pk || COALESCE(vwpbs.pbscode, ''::character varying)::text) || COALESCE(vwpbs.restriction_code, ''::character varying)::text AS pk_view, 
 brand.fk_product, brand.fk_company, brand.brand, brand.pk AS fk_brand, brand.price, brand.from_pbs, 
 product.atccode, product.generic, product.salt, product.fk_form, product.strength, 
 drugs.format_strength(product.strength) AS display_strength, 
 drugs.format_packsize(product.amount, product.amount_unit, product.pack_size) AS display_packsize, 
 product.salt_strength, product.free_comment, product.fk_schedule, product.updated_at, product.pack_size, 
 product.amount, product.amount_unit, form.form, brand.product_information_filename, vwpbs.quantity, 
 vwpbs.max_rpt, vwpbs.pbscode, vwpbs.chapter, atc.atcname, company.company, vwpbs.restrictionflag, 
 vwpbs.pbs_type, vwpbs.restriction, vwpbs.restriction_type, vwpbs.restriction_code, vwpbs.streamlined
   FROM drugs.brand brand
   JOIN drugs.product ON brand.fk_product = product.pk
   JOIN drugs.form ON product.fk_form = form.pk
   JOIN drugs.atc ON product.atccode::text = atc.atccode
   JOIN drugs.company ON company.code::text = brand.fk_company::text
   LEFT JOIN drugs.vwpbs ON product.pk = vwpbs.fk_product;

ALTER TABLE drugs.vwdrugs OWNER TO easygp;
GRANT ALL ON TABLE drugs.vwdrugs TO easygp;
GRANT ALL ON TABLE drugs.vwdrugs TO staff;


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 179);

