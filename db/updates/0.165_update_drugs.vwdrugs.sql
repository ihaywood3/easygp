-- update to include all pbs chapters

Drop view drugs.vwDrugs;

CREATE OR REPLACE VIEW drugs.vwDrugs AS
SELECT (brand.pk || COALESCE(pbs.pbscode, ''::character varying)::text)
|| COALESCE(restriction.code, ''::character varying)::text AS pk_view,
brand.fk_product, brand.fk_company, brand.brand, brand.pk AS fk_brand,
brand.price, brand.from_pbs, product.atccode, product.generic,
product.salt, product.fk_form, product.strength, product.salt_strength,
product.original_pbs_name, product.original_pbs_fs,
product.free_comment, product.updated_at, pack.pack_size, pack.amount,
pack.amount_unit, form.form, atc.atcname, pbs.quantity, pbs.max_rpt,
pbs.pbscode, pbs.chapter, pbs.restrictionflag,
       CASE
           WHEN pbs.chapter::text = 'GE' THEN
		CASE
			 WHEN pbs.restrictionflag = 'U'::text THEN 'PBS/RPBS UNRESTRICTED'::text
			 WHEN pbs.restrictionflag = 'R'::text THEN 'PBSRPBS RESTRICTED'::text
			 ELSE 
				CASE
					WHEN restriction.streamlined THEN 'PBS/RPBS AUTHORITY STREAMLINED'::text
					ELSE 'PBS/RPBS AUTHORITY'::text
				END	
		END 
           WHEN pbs.chapter::text = 'R1' THEN
		CASE
			 WHEN pbs.restrictionflag = 'U'::text THEN 'RPBS UNRESTRICTED'::text
			 WHEN pbs.restrictionflag = 'R'::text THEN 'RPBS RESTRICTED'::text
			 ELSE 
				CASE
					WHEN restriction.streamlined THEN 'RPBS AUTHORITY STREAMLINED'::text
					ELSE 'RPBS AUTHORITY'::text
				END	
		END 
	  WHEN (pbs.chapter::text = 'OT') THEN
		CASE
			 WHEN pbs.restrictionflag = 'U'::text THEN 'OTOMETRIST UNRESTRICTED'::text
			 WHEN pbs.restrictionflag= 'R'::text THEN 'OTOMETRIST RESTRICTED'::text
			 ELSE 
				CASE
					WHEN restriction.streamlined THEN 'OTOMETRIST AUTHORITY STREAMLINED'::text
					ELSE 'OPTOMETRIST AUTHORITY'::text
				END	
                 END
           WHEN (pbs.chapter::text = 'PL') THEN 'PBS/RPBS PALLIATIVE CARE AUTHORITY'
           WHEN (pbs.chapter::text = 'GH') THEN 'Section 100 (GROWTH HORMONE) RESTRICTED'
           WHEN (pbs.chapter::text = 'IF') THEN 'Section 100 (IVF/GIFT) RESTRICTED'
           WHEN (pbs.chapter::text = 'PQ') THEN 'Paraplegic/Quadriplegic UNRESTRICTED'
           WHEN (pbs.chapter::text = 'MD') THEN 'Section 100 (Opiate Addiction Treatment) RESTRICTED'
	   WHEN (pbs.chapter::text = 'MF') THEN 'Section 100 (Botulinum Toxin Program) AUTHORITY'
	   WHEN (pbs.chapter::text = 'SY') THEN 'Section 100 (Special Authority Items) - Private Hospitals AUTHORITY'
	   WHEN (pbs.chapter::text = 'SZ') THEN 'Section 100 (Special Authority Items) - Public Hospitals AUTHORITY'

           WHEN (pbs.chapter::text = 'CS') THEN 'Section100 (chemotherapy special benefits) RESTRICTED'
	   WHEN (pbs.chapter::text = 'DB') THEN 'Doctors Bag UNRESTRICTED'
	   WHEN (pbs.chapter::text = 'HB') THEN 'Section 100 (highly specialised drugs - public hospital) AUTHORITY'
	   WHEN (pbs.chapter::text = 'HS') THEN 'Section 100 (Highly specialised drugs) AUTHORITY'
           WHEN (pbs.chapter::text = 'SB') THEN 
                CASE
			 WHEN pbs.restrictionflag = 'U'::text THEN 'SPECIAL BENEFITS UNRESTRICTED'::text
			 WHEN pbs.restrictionflag= 'R'::text THEN 'SPECIAL BENEFITS RESTRICTED'::text
		 END
           WHEN pbs.chapter::text = 'CT' THEN
		CASE
			 WHEN pbs.restrictionflag = 'U'::text THEN 'CHEMOTHERAPY SPECIAL BENEFITS UNRESTRICTED'::text
			 WHEN pbs.restrictionflag = 'R'::text THEN 'CHEMOTHERAPY SPECIAL BENEFITS RESTRICTED'::text
			 ELSE 
				CASE
					WHEN restriction.streamlined THEN 'CHEMOTHERAPY SPECIAL BENEFITS AUTHORITY STREAMLINED'::text
					ELSE 'CHEMOTHERAPY SPECIAL BENEFITS AUTHORITY'::text
				END	
		END 
           WHEN pbs.chapter::text = 'DT' THEN
		CASE
			 WHEN pbs.restrictionflag = 'U'::text THEN 'DENTAL UNRESTRICTED'::text
			 WHEN pbs.restrictionflag = 'R'::text THEN 'DENTAL RESTRICTED'::text
		END
            WHEN pbs.chapter::text = 'DS' THEN 'DENTAL SPECIAL BENEFITS UNRESTRICTED'::text
		
       END 
	 AS pbs_type, 

restriction.restriction,
restriction.restriction_type, restriction.code AS restriction_code,
restriction.streamlined, brand.product_information_filename
  FROM drugs.brand brand
  JOIN drugs.product ON brand.fk_product = product.pk
  JOIN drugs.form ON product.fk_form = form.pk
  JOIN drugs.pack ON product.pk = pack.fk_product
  LEFT JOIN drugs.atc ON product.atccode::text = atc.atccode
  LEFT JOIN drugs.pbs ON brand.fk_product = pbs.fk_product
  LEFT JOIN drugs.restriction ON pbs.pbscode::text =
restriction.pbscode::text ;

COMMENT ON VIEW drugs.vwDrugs  is
'THESE ARE THE CHAPTERS:

CS Section 100 (Chemotherapy Special Benefit)
CT Section 100 (Chemotherapy Scheme)
DB Doctors Bag
DS Dental (Special Pharmaceutical Benefits)
DT Dental
GE General
GH Section 100 (Growth hormone)
HB Section 100 (Highly Specialised Drugs) - Public Hospitals
HS Section 100 (Highly specialised drugs)
IF Section 100 (IVF/GIFT Treatment)
MD Section 100 (Opiate Addiction Treatment)
MF Section 100 (Botulinum Toxin Program)
OT Optometrist
PL Palliative care      - seems to have only authority items.
PQ Paraplegic/Quadriplegic
R1 Repatriation
SB Special Pharmaceutical Benefits
SY Section 100 (Special Authority Items) - Private Hospitals
SZ Section 100 (Special Authority Items) - Public Hospitals
' ;

ALTER TABLE drugs.vwDrugs OWNER TO easygp ;
GRANT ALL ON TABLE drugs.vwDrugs TO easygp ;
GRANT ALL ON TABLE drugs.vwDrugs TO staff ;


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 165);
