alter Table  clin_referrals.referrals rename column fk_branch to fk_referral_recipient;
COMMENT ON COLUMN clin_referrals.referrals.fk_referral_recipient IS 'key to clin_referrals.referral_recipients table';
CREATE TABLE clin_referrals.referral_recipients
(
  pk integer NOT NULL DEFAULT nextval('clin_referrals.letter_recipients_pk_seq'::regclass),
  fk_branch integer,
  fk_employee integer,
  fk_person integer,
  fk_address integer,
  deleted boolean DEFAULT false,
  CONSTRAINT letter_recipients_pkey PRIMARY KEY (pk)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE clin_referrals.referral_recipients OWNER TO easygp;
GRANT ALL ON TABLE clin_referrals.referral_recipients TO easygp;
GRANT ALL ON TABLE clin_referrals.referral_recipients TO staff;
COMMENT ON TABLE clin_referrals.referral_recipients IS 'A lookup table of who received the letter and where
   if not null fk_branch points to the organisation/branch/address
   if not null fk_person points to the person
   if not null fk_address is the address the letter is sent to if linked to fk_person';


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 78)

