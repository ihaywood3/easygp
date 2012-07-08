-- must be able to have null company key if we are to put in our own mixtures

alter table drugs.brand drop constraint  brand_fk_company_fkey;
alter table drugs.brand alter column fk_company drop not null;
alter table drugs.brand alter column fk_company set default null;
comment on column drugs.brand.fk_company is 'may be null as we can put in our own drug preparations, creams etc';

-- allow user to have their own specific pi on their local machine
Alter table drugs.brand add column product_information_filename_user text default null;

-- changed for the GUI to help hapless doctors without a large cranium to allocated S4 and S8
Update drugs.schedules set schedule = 'Controlled Drug (S8)' where pk= 8;
Update drugs.Schedules set schedule = 'Prescription Only Medicine OR Prescription Animal Remedy (S4)' where pk=4;

comment on column drugs.brand.product_information_filename_user is
'If the user downloads a product information file for their own use it then the filename 
 is kept here';
 
-- keep a copy of all our product information files
create table drugs.product_information_files 
(filename text not null);

Comment on table drugs.product_information_files is
'the filenames of all the guild pdfs as supplied to us under the agreed 
terms and conditions of use';

alter table drugs.product_information_files owner to easygp;
grant all on table drugs.product_information_files to easygp;
grant all on table drugs.product_information_files to staff;

-- included new field in view product_information_filename_user
DROP VIEW drugs.vwdrugs;

CREATE OR REPLACE VIEW drugs.vwdrugs AS 
 SELECT (brand.pk || COALESCE(vwpbs.pbscode, ''::character varying)::text) || COALESCE(vwpbs.restriction_code, ''::character varying)::text AS pk_view, 
 brand.fk_product, brand.fk_company, brand.brand, brand.pk AS fk_brand, brand.price, brand.from_pbs, product.atccode, 
 product.generic, product.salt, product.fk_form, product.strength, drugs.format_strength(product.strength) AS display_strength, 
 drugs.format_packsize(product.amount, product.amount_unit, product.pack_size) AS display_packsize, product.salt_strength, 
 product.free_comment, product.fk_schedule, product.updated_at, product.pack_size, product.amount, product.amount_unit, 
 form.form, brand.product_information_filename, brand.product_information_filename_user,
 vwpbs.quantity, vwpbs.max_rpt, vwpbs.pbscode, vwpbs.chapter, 
 atc.atcname, company.company, vwpbs.restrictionflag, vwpbs.pbs_type, vwpbs.restriction, vwpbs.restriction_type, vwpbs.restriction_code, vwpbs.streamlined
   FROM drugs.brand brand
   JOIN drugs.product ON brand.fk_product = product.pk
   JOIN drugs.form ON product.fk_form = form.pk
   JOIN drugs.atc ON product.atccode::text = atc.atccode
   LEFT JOIN drugs.company ON company.code::text = brand.fk_company::text
   LEFT JOIN drugs.vwpbs ON product.pk = vwpbs.fk_product;

ALTER TABLE drugs.vwdrugs OWNER TO richard;
GRANT ALL ON TABLE drugs.vwdrugs TO richard;
GRANT ALL ON TABLE drugs.vwdrugs TO easygp;
GRANT ALL ON TABLE drugs.vwdrugs TO staff;



truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 186);
