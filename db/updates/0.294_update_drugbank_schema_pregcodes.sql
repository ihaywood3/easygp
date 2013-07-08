
CREATE TABLE drugbank.pregnancy_code
(
  pk serial primary key,
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
ALTER TABLE drugbank.pregnancy_code
  OWNER TO easygp;

GRANT ALL ON TABLE drugbank.pregnancy_code to easygp;
GRANT SELECT ON TABLE drugbank.pregnancy_code to STAFF;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 294)

