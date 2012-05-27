Drop view drugs.vwDrugs;
Drop view drugs.vwDrugs1;

CREATE OR REPLACE VIEW drugs.vwdrugs AS 
 SELECT (brand.pk || COALESCE(pbs.pbscode, ''::character varying)::text) || COALESCE(restriction.code, ''::character varying)::text AS pk_view,
 brand.fk_product, brand.fk_company, brand.brand, brand.pk AS fk_brand, brand.price,
 brand.from_pbs, product.atccode, product.generic, product.salt, product.fk_form,
 product.strength, product.salt_strength, product.original_pbs_name, product.original_pbs_fs,
 product.free_comment, product.updated_at, pack.pack_size, pack.amount, pack.amount_unit, 
 form.form, atc.atcname, pbs.quantity, pbs.max_rpt, pbs.pbscode, pbs.chapter, pbs.restrictionflag,
 restriction.restriction, restriction.restriction_type, restriction.code AS restriction_code,
 restriction.streamlined, brand.product_information_filename
   FROM drugs.brand brand
   JOIN drugs.product ON brand.fk_product = product.pk
   JOIN drugs.form ON product.fk_form = form.pk
   JOIN drugs.pack ON product.pk = pack.fk_product
   LEFT JOIN drugs.atc ON product.atccode::text = atc.atccode
   LEFT JOIN drugs.pbs ON brand.fk_product = pbs.fk_product
   LEFT JOIN drugs.restriction ON pbs.pbscode::text = restriction.pbscode::text;

ALTER TABLE drugs.vwdrugs OWNER TO easygp;
grant all on table drugs.vwdrugs to easygp;
grant all on table drugs.vwdrugs to staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 162);

