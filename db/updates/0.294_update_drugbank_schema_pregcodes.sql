DROP TABLE drugbank.pregnancy_code;
CREATE TABLE drugbank.pregnancy_code
(
  pk SERIAL PRIMARY KEY, 
  fk_drug integer,
  code character(2),
  safety text,
  CONSTRAINT pregnancy_code_fk_drug_fkey FOREIGN KEY (fk_drug)
      REFERENCES drugbank.drug (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);

COMMENT ON COLUMN drugbank.pregnancy_code.code IS 'ABCD pregnancy category as per Australian TGA definition';
COMMENT ON COLUMN drugbank.pregnancy_code.safety IS 'comment on safety of the referenced drug in pregnancy'; 

ALTER TABLE drugbank.pregnancy_code OWNER TO easygp;
  
truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 294);