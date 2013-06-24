
CREATE TABLE drugbank.pregnancy_code
(
  fk_drug integer,
  code character(2),
  safety text,
  pk integer NOT NULL DEFAULT nextval('drugbank.pregnancycode_pk_seq'::regclass),
  CONSTRAINT pregnancy_code_pkey PRIMARY KEY (pk),
  CONSTRAINT pregnancy_code_fk_drug_fkey FOREIGN KEY (fk_drug)
      REFERENCES drugbank.drug (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE drugbank.pregnancy_code
  OWNER TO easygp;