alter table drugs.product add column extempore boolean not null default false;
 
create or replace view drugs.vwprescribeditems as
SELECT prescribed.pk AS pk_view, medications.pk AS fk_medication, medications.start_date, medications.last_date, medications.active, medications.deleted AS medication_deleted, medications.fk_generic_product, consult.pk AS fk_consult, consult.consult_date AS date_script_written, consult.fk_patient, product.generic, brand.brand, product.strength, brand.product_information_filename, form.form, brand.pk AS fk_brand, prescribed.pk AS fk_prescribed, prescribed.repeats, prescribed.date_on_script, prescribed.quantity, prescribed_for.prescribed_for, prescribed.deleted AS prescribed_deleted, prescribed.authority_reason, prescribed.print_reason, instructions.instruction, vwstaff.wholename AS staff_prescribed_wholename, vwstaff.title AS staff_prescribed_title, product.atccode, product.salt, product.fk_form, product.fk_schedule, product.salt_strength, prescribed.fk_instruction, prescribed.fk_prescribed_for, prescribed.pbscode, prescribed.fk_lu_pbs_script_type, prescribed.restriction_code, prescribed.fk_code, prescribed.reg24, lu_pbs_script_type.type AS pbs_script_type, restriction.streamlined, restriction.restriction, restriction.restriction_type, schedules.schedule, drugs.format_strength(product.strength) AS display_strength, drugs.format_amount(product.amount, product.amount_unit, product.units_per_pack) AS display_packsize, product.units_per_pack, prescribed.medisecure_uuid, prescribed.medisecure_barcode, prescribed.escript_uploaded, prescribed.script_number, product.sct AS product_sct, brand.sct AS brand_sct, product.amount, product.amount_unit, prescribed.brand_substitution, brand.fk_company, product.original_pbs_name, prescribed.authority_script_number, prescribed.authority_approval_number, prescribed.authority_post_to_patient, prescribed.concession_details, prescribed.fk_progress_note, prescribed.printed, prescribed.latex, prescribed.ctg, product.extempore
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

update db.lu_version set lu_minor=354;