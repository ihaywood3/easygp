-- re-insert missing fk_schedule field

DROP VIEW drugs.vwdrugs;

CREATE OR REPLACE VIEW drugs.vwdrugs AS 
 SELECT (brand.pk || COALESCE(vwpbs.pbscode, ''::character varying)::text) || COALESCE(vwpbs.restriction_code, ''::character varying)::text AS pk_view,
  brand.fk_product, brand.fk_company, brand.brand, brand.pk AS fk_brand, brand.price, brand.from_pbs, product.atccode, 
  product.generic, product.salt, product.fk_form, product.strength, product.salt_strength, product.free_comment, product.fk_schedule,
  product.updated_at, product.pack_size, product.amount, product.amount_unit, form.form, brand.product_information_filename, 
  vwpbs.quantity, vwpbs.max_rpt, vwpbs.pbscode, vwpbs.chapter, vwpbs.restrictionflag, vwpbs.pbs_type, vwpbs.restriction, 
  vwpbs.restriction_type, vwpbs.restriction_code, vwpbs.streamlined
   FROM drugs.brand brand
   JOIN drugs.product ON brand.fk_product = product.pk
   JOIN drugs.form ON product.fk_form = form.pk
   LEFT JOIN drugs.vwpbs ON product.pk = vwpbs.fk_product;

ALTER TABLE drugs.vwdrugs OWNER TO richard;
GRANT ALL ON TABLE drugs.vwdrugs TO richard;
GRANT ALL ON TABLE drugs.vwdrugs TO staff;

-- temporary fudge
-- update drugs.product set fk_schedule = 4 where fk_schedule is null;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 171);

