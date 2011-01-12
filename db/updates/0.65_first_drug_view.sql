-- first attempt at a drug view so probably a little rough!!!!!!!1
-- to test the new drug data

create or replace view drugs.vwBrands as 
SELECT 
  brand.fk_product as pk,
  brand.fk_product,
  brand.fk_company,
  brand.brand,
  brand.price,
  brand.from_pbs,
  brand.original_tga_text,
  brand.original_tga_code,
  drugs.company.company,
  drugs.company.address,
  drugs.company.telephone,
  drugs.company.facsimile,
  product.atccode,
  product.generic,
  product.salt,
  product.fk_form,
  product.strength,
  product.salt_strength,
  product.original_pbs_name,
  product.original_pbs_fs,
  product.free_comment,
  product.updated_at,
  atc.atcname,
  form.form,
  drugs.restriction.restriction,
  drugs.restriction.restriction_type,
  drugs.restriction.code,
  drugs.restriction.streamlined,
  drugs.pbs.pbscode,
  drugs.pbs.chapter,
  drugs.pbs.restrictionflag,
  drugs.pbs.max_rpt,
  drugs.pbs.quantity
FROM
  drugs.brand brand
  INNER JOIN drugs.company ON (brand.fk_company = drugs.company.code)
  INNER JOIN drugs.product product ON (brand.fk_product = product.pk)
  INNER JOIN drugs.atc ON (product.atccode = atc.atccode)
  INNER JOIN drugs.form form ON (product.fk_form = form.pk)
  INNER JOIN drugs.pbs ON (product.pk = drugs.pbs.fk_product)
  LEFT OUTER JOIN drugs.restriction ON (drugs.pbs.pbscode = drugs.restriction.pbscode)

 order by brand ;


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 65)

