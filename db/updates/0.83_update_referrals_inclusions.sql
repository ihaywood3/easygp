-- some minor mods and ownership changes to inclusions;
CREATE TABLE clin_referrals.inclusions
(
  pk serial NOT NULL,
  fk_referral integer NOT NULL,
  fk_document integer NOT NULL,
  deleted boolean DEFAULT false, -- if deleted is true then the inclusion is marked as deleted and...
  CONSTRAINT inclusions_pkey PRIMARY KEY (pk)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE clin_referrals.inclusions OWNER TO easygp;
GRANT ALL ON TABLE clin_referrals.inclusions TO easygp;
GRANT SELECT ON TABLE clin_referrals.inclusions TO staff;
COMMENT ON TABLE clin_referrals.inclusions IS 'A Table describing which documents went out with the referral';
COMMENT ON COLUMN clin_referrals.inclusions.deleted IS 'if deleted is true then the inclusion is marked as deleted and
 for example will not be sent out if the document is later re-printed';


CREATE OR REPLACE VIEW clin_referrals.vwinclusions AS 
 SELECT DISTINCT inclusions.pk AS pk_inclusion, inclusions.fk_referral, inclusions.fk_document, inclusions.deleted, consult.fk_patient, documents.date_created, documents.tag_user
   FROM clin_consult.consult
   JOIN clin_referrals.referrals ON referrals.fk_consult = consult.pk
   JOIN clin_referrals.inclusions ON referrals.pk = inclusions.fk_referral
   JOIN documents.documents ON inclusions.fk_document = documents.pk
  ORDER BY consult.fk_patient;

ALTER TABLE clin_referrals.vwinclusions OWNER TO easygp;
GRANT ALL ON TABLE clin_referrals.vwinclusions TO easygp;
GRANT ALL ON TABLE clin_referrals.vwinclusions TO staff;


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 83);

