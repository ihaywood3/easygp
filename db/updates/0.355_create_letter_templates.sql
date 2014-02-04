
-- new table to enable user to save templates in the letter writer

CREATE TABLE clin_referrals.lu_referral_letter_templates
(
  pk serial NOT NULL,
  fk_staff integer NOT NULL,
  shared boolean DEFAULT false, -- if true then anyone can access this template
  name text NOT NULL,
  deleted boolean DEFAULT false,
  template text NOT NULL, -- html for a letter template
 
 CONSTRAINT lu_referral_letter_templates_fk_staff_fkey FOREIGN KEY (fk_staff)
      REFERENCES admin.staff (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
       CONSTRAINT lu_referral_letter_templates_pkey PRIMARY KEY (pk )
)
WITH (
  OIDS=FALSE
);
ALTER TABLE clin_referrals.lu_referral_letter_templates   OWNER TO easygp;
GRANT ALL ON TABLE clin_referrals.lu_referral_letter_templates TO staff;

COMMENT ON TABLE clin_referrals.lu_referral_letter_templates   IS 'Table to hold templates for referral letters';
COMMENT ON COLUMN clin_referrals.lu_referral_letter_templates.shared IS 'if true then anyone can access this template';
COMMENT ON COLUMN clin_referrals.lu_referral_letter_templates.template IS 'html for a letter template';

update db.lu_version set lu_minor=355;

