
-- a function to display strengths properly
-- use like this: drugs.format_strength(strength) as display_strength


CREATE OR REPLACE FUNCTION drugs.format_strength(text)
  RETURNS text AS
$BODY$
DECLARE
  i text;
  a text[];
  r text;
  u text;
  q float;
BEGIN
  -- do the ml -> 5ml conversion;
  for i in select strength from regexp_split_to_table($1,E'-') as
strength loop
    u := i;
    a := regexp_matches(i,E'^([0-9\\.]+)([a-z\\/]+)$');
    if not a is null then
      if a[2] = 'mg/ml' or a[2] = 'mcg/ml' then
        q := a[1]::float;
        q := q*5;
        u := q::text || replace(a[2],'/ml','/5ml');
      else
        u := i;
      end if;
    else
      u := i;
    end if;
    IF r is null THEN
      r := u;
    ELSE
      r := r || '-' || u;
    END IF;
  end loop;
  return r;
end;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100;
ALTER FUNCTION drugs.format_strength(text) OWNER TO easygp;


-- use like this:
-- drugs.format_packsize(product.amount,product.amount_unit,product.packsize) as display_packsize

create or replace function drugs.format_packsize(float,integer,integer)
returns text as $x$
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
      r:= r || 'x' || i;
    else
      r := i;
    end if;
  end if;
  RETURN r;
END;
$x$ language 'plpgsql';

ALTER FUNCTION drugs.format_packsize(float,integer,integer) OWNER TO easygp;

DROP VIEW drugs.vwdrugs;

CREATE OR REPLACE VIEW drugs.vwdrugs AS 
 SELECT (brand.pk || COALESCE(vwpbs.pbscode, ''::character varying)::text) || COALESCE(vwpbs.restriction_code, ''::character varying)::text AS pk_view,
  brand.fk_product, brand.fk_company, brand.brand, brand.pk AS fk_brand, brand.price, brand.from_pbs,
   product.atccode, product.generic, product.salt, product.fk_form, product.strength, 
   drugs.format_strength(product.strength) AS display_strength, 
   drugs.format_packsize(product.amount, product.amount_unit, product.pack_size) as display_packsize,
   product.salt_strength, product.free_comment, product.fk_schedule, product.updated_at, product.pack_size, 
   product.amount, product.amount_unit, form.form, brand.product_information_filename, 
   vwpbs.quantity, vwpbs.max_rpt, vwpbs.pbscode, vwpbs.chapter, atc.atcname, company.company, 
   vwpbs.restrictionflag, vwpbs.pbs_type, vwpbs.restriction, vwpbs.restriction_type, vwpbs.restriction_code, vwpbs.streamlined
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
insert into db.lu_version (lu_major,lu_minor) values (0, 178);

