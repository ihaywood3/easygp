-- added Reg24 column to the view i.e dispense all at once.
DROP VIEW clin_prescribing.vwprescribeditems;

CREATE OR REPLACE VIEW clin_prescribing.vwprescribeditems AS 
 SELECT prescribed.pk AS pk_view, medications.pk AS fk_medication, medications.start_date, medications.last_date, 
 medications.active, medications.deleted AS medication_deleted, medications.fk_generic_product, 
 consult.pk AS fk_consult, consult.consult_date AS date_script_written, consult.fk_patient, 
 product.generic, brand.brand, product.strength, brand.product_information_filename, 
 form.form, brand.pk AS fk_brand, prescribed.pk AS fk_prescribed, prescribed.repeats, 
 prescribed.date_on_script, prescribed.quantity, prescribed_for.prescribed_for, prescribed.deleted AS prescribed_deleted, 
 prescribed.authority_reason, prescribed.print_reason, instructions.instruction, vwstaff.wholename AS staff_prescribed_wholename, 
 vwstaff.title AS staff_prescribed_title, vwstaff.provider_number, product.atccode, product.salt, product.fk_form, 
 product.fk_schedule, product.salt_strength, prescribed.fk_instruction, prescribed.fk_prescribed_for, 
 prescribed.pbscode, prescribed.fk_lu_pbs_script_type, prescribed.restriction_code, prescribed.fk_code, prescribed.reg24,
 lu_pbs_script_type.type AS pbs_script_type, restriction.streamlined, restriction.restriction, 
 restriction.restriction_type, schedules.schedule, drugs.format_strength(product.strength) AS display_strength, 
 drugs.format_amount(product.amount, product.amount_unit, product.units_per_pack) AS display_packsize, product.units_per_pack
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
GRANT ALL on table clin_prescribing.vwprescribeditems to easygp;
GRANT ALL on table clin_prescribing.vwprescribeditems to staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 217);
