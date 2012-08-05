-- added class code and class name for each drug
drop view drugs.vwdrugs;

Create Or Replace VIEW drugs.vwdrugs As
 Select (brand.pk || COALESCE(vwpbs.pbscode, ''::character varying)::text) || COALESCE(vwpbs.restriction_code, ''::character varying)::text AS pk_view,
  brand.fk_product, brand.fk_company, brand.brand, brand.pk As Fk_brand, brand.price,
  brand.from_pbs, product.atccode, product.generic, product.salt, product.fk_form,
  product.strength, drugs.format_strength(product.strength) As Display_strength,
  drugs.format_packsize(product.amount, product.amount_unit, product.pack_size) As Display_packsize,
  product.salt_strength, product.free_comment, product.fk_schedule, product.updated_at, product.pack_size,
  product.amount, product.amount_unit, schedules.schedule, form.form, brand.product_information_filename,
  brand.product_information_filename_user, vwpbs.quantity, vwpbs.max_rpt, vwpbs.pbscode, vwpbs.chapter,
  atc.atcname, atc1.atccode As Class_code, atc1.atcname As Class_name,
  company.company, vwpbs.restrictionflag, vwpbs.pbs_type, vwpbs.restriction,
  vwpbs.restriction_type, vwpbs.restriction_code, vwpbs.streamlined
   From drugs.brand brand
   JOIN drugs.product On brand.fk_product = product.pk
   JOIN drugs.form On product.fk_form = form.pk
   JOIN drugs.atc On product.atccode:: text = atc.atccode
   Left JOIN drugs.company On company.code:: text = brand.fk_company:: text
   Left JOIN drugs.vwpbs On product.pk = vwpbs.fk_product
   Left JOIN drugs.schedules On schedules.pk = product.fk_schedule
   Left JOIN drugs.atc atc1 On "substring"(product.atccode:: text, 1, 4) = atc1.atccode;

ALTER TABLE drugs.vwdrugs OWNER To easygp;
GRANT ALL On TABLE drugs.vwdrugs To easygp;
GRANT ALL On TABLE drugs.vwdrugs To staff;

truncate db.lu_version;
insert into db.lu_version(lu_major, lu_minor)values(0, 203);
