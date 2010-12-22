-- new view which combines addresses of persons in organisations (employees)
-- with addresses of persons not in organisations

CREATE OR REPLACE VIEW contacts.vwpersonsandemployeesaddresses AS 
         SELECT vworganisationsemployees.fk_address, 
                CASE
                    WHEN vworganisationsemployees.fk_address IS NULL THEN vworganisationsemployees.fk_person || '-0'::text
                    ELSE (vworganisationsemployees.fk_person || '-'::text) || vworganisationsemployees.fk_address::text
                END AS pk_view, vworganisationsemployees.fk_branch, vworganisationsemployees.branch, vworganisationsemployees.organisation, vworganisationsemployees.fk_organisation,
                 vworganisationsemployees.fk_person, vworganisationsemployees.firstname, vworganisationsemployees.surname, vworganisationsemployees.title, vworganisationsemployees.occupation, vworganisationsemployees.street, vworganisationsemployees.town, vworganisationsemployees.state, vworganisationsemployees.postcode
           FROM contacts.vworganisationsemployees
          WHERE vworganisationsemployees.fk_person <> 0
UNION 
         SELECT vwpersonsexcludingpatients.fk_address, 
                CASE
                    WHEN vwpersonsexcludingpatients.fk_address IS NULL THEN vwpersonsexcludingpatients.fk_person || '-0'::text
                    ELSE (vwpersonsexcludingpatients.fk_person || '-'::text) || vwpersonsexcludingpatients.fk_address::text
                END AS pk_view, NULL::unknown AS fk_branch, NULL::unknown AS branch, NULL::unknown AS organisation, null::unknown as fk_organisation,
                vwpersonsexcludingpatients.fk_person, vwpersonsexcludingpatients.firstname, vwpersonsexcludingpatients.surname, vwpersonsexcludingpatients.title, vwpersonsexcludingpatients.occupation, vwpersonsexcludingpatients.street, vwpersonsexcludingpatients.town, vwpersonsexcludingpatients.state, vwpersonsexcludingpatients.postcode
           FROM contacts.vwpersonsexcludingpatients
          WHERE vwpersonsexcludingpatients.fk_person <> 0 AND vwpersonsexcludingpatients.fk_address IS NOT NULL
  ORDER BY 6, 12;

ALTER TABLE contacts.vwpersonsandemployeesaddresses OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsandemployeesaddresses TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsandemployeesaddresses TO staff;
COMMENT ON VIEW contacts.vwpersonsandemployeesaddresses IS 'A view of all addresses for a person whether they have a private address or their address as an employee of an organisation';



ALTER TABLE contacts.vwPersonsAndEmployeesAddresses OWNER TO easygp;
Grant all on contacts.vwPersonsAndEmployeesAddresses to easygp;
Grant all on contacts.vwPersonsAndEmployeesAddresses to staff;


comment on view contacts.vwPersonsAndEmployeesAddresses is
'A view of all addresses for a person whether they have a private address or their address as an employee of an organisation';


-- and as yet incomplete vwReferrals
-- so far union of employees with persons

DROP VIEW clin_referrals.vwreferrals;

CREATE OR REPLACE VIEW clin_referrals.vwreferrals AS 
SELECT 
  clin_referrals.referrals.pk AS pk_referral,
  clin_referrals.referrals.fk_consult,
  clin_referrals.referrals.fk_person,
  clin_referrals.referrals.fk_branch,
  clin_referrals.referrals.fk_type,
  clin_referrals.referrals.letter_html,
  clin_referrals.referrals.tag,
  clin_referrals.referrals.deleted,
  clin_referrals.referrals.body_html,
  clin_referrals.referrals.include_healthsummary,
  clin_referrals.referrals.include_careplan,
  clin_consult.consult.consult_date AS date,
  clin_consult.consult.fk_patient,
  clin_consult.consult.fk_staff,
  contacts.data_persons.firstname AS provider_firstname,
  contacts.data_persons.surname AS provider_surname,
  contacts.lu_title.title AS provider_title,
  contacts.data_branches.branch,
  contacts.data_organisations.organisation,
  clin_referrals.lu_type.type,
  contacts.lu_categories.category,
  contacts.data_addresses.street,
  contacts.lu_towns.postcode,
  contacts.lu_towns.town,
  contacts.data_branches.fk_organisation,
  clin_referrals.referrals.fk_pasthistory,
  clin_referrals.referrals.fk_progressnote,
  common.lu_occupations.occupation
FROM
  clin_referrals.referrals
  INNER JOIN clin_consult.consult ON (clin_referrals.referrals.fk_consult = clin_consult.consult.pk)
  INNER JOIN clin_referrals.lu_type ON (clin_referrals.referrals.fk_type = clin_referrals.lu_type.pk)
  LEFT OUTER JOIN contacts.data_employees ON (clin_referrals.referrals.fk_person = contacts.data_employees.fk_person)
  AND (clin_referrals.referrals.fk_branch = contacts.data_employees.fk_branch)
  LEFT OUTER JOIN common.lu_occupations ON (contacts.data_employees.fk_occupation = common.lu_occupations.pk)
  LEFT OUTER JOIN contacts.data_persons ON (contacts.data_employees.fk_person = contacts.data_persons.pk)
  LEFT OUTER JOIN contacts.lu_categories ON (contacts.data_employees.fk_category = contacts.lu_categories.pk)
  INNER JOIN contacts.data_branches ON (contacts.data_employees.fk_branch = contacts.data_branches.pk)
  LEFT OUTER JOIN contacts.data_organisations ON (contacts.data_branches.fk_organisation = contacts.data_organisations.pk)
  LEFT OUTER JOIN contacts.data_addresses ON (contacts.data_branches.fk_address = contacts.data_addresses.pk)
  LEFT OUTER JOIN contacts.lu_towns ON (contacts.data_addresses.fk_town = contacts.lu_towns.pk)
  LEFT OUTER JOIN contacts.lu_title ON (contacts.data_persons.fk_title = contacts.lu_title.pk)

  where clin_referrals.referrals.fk_branch is not null and clin_referrals.referrals.fk_person is not null
UNION 
         SELECT referrals.pk AS pk_referral, referrals.fk_consult, referrals.fk_person, referrals.fk_branch, referrals.fk_type, 
         referrals.letter_html, referrals.tag, referrals.deleted, referrals.body_html, referrals.include_healthsummary, 
         referrals.include_careplan, consult.consult_date AS date, consult.fk_patient, consult.fk_staff, data_persons.firstname AS provider_firstname, 
         data_persons.surname AS provider_surname, lu_title.title AS provider_title, NULL::unknown AS branch, NULL::unknown AS organisation, 
         lu_type.type, lu_categories.category, data_addresses.street, lu_towns.postcode, lu_towns.town, NULL::unknown AS fk_organisation, 
         referrals.fk_pasthistory, referrals.fk_progressnote,
         common.lu_occupations.occupation
           FROM clin_referrals.referrals
      JOIN clin_consult.consult ON referrals.fk_consult = consult.pk
   LEFT JOIN contacts.data_persons ON referrals.fk_person = data_persons.pk
   LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
   JOIN clin_referrals.lu_type ON referrals.fk_type = lu_type.pk
   LEFT JOIN contacts.links_persons_addresses ON data_persons.pk = links_persons_addresses.fk_person
   JOIN contacts.data_addresses ON links_persons_addresses.fk_address = data_addresses.pk
   JOIN contacts.lu_categories ON data_persons.fk_category = lu_categories.pk
   LEFT JOIN contacts.lu_towns ON data_addresses.fk_town = lu_towns.pk
   LEFT OUTER JOIN common.lu_occupations ON (contacts.data_persons.fk_occupation = common.lu_occupations.pk)
  WHERE referrals.fk_branch IS NULL
  ORDER BY 13, 12 DESC;

ALTER TABLE clin_referrals.vwreferrals OWNER TO easygp;
GRANT ALL ON TABLE clin_referrals.vwreferrals TO easygp;
GRANT ALL ON TABLE clin_referrals.vwreferrals TO staff;




truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 56)