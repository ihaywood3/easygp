-- oops... this was not replaced with a previous cascade delete

CREATE OR REPLACE VIEW clin_mentalhealth.vwteamcaremembers AS 
 SELECT team_care_members.pk,
    team_care_members.fk_plan,
    team_care_members.fk_employee,
    vworganisationsemployees.fk_organisation,
    vworganisationsemployees.fk_branch,
    vworganisationsemployees.fk_person,
        CASE
            WHEN vworganisationsemployees.fk_employee = 0 THEN vworganisationsemployees.branch
            ELSE ((vworganisationsemployees.title || ' '::text) || (vworganisationsemployees.firstname || ' '::text)) || vworganisationsemployees.surname
        END AS wholename,
    ((vworganisationsemployees.organisation || ' '::text) || (vworganisationsemployees.branch || ' '::text)) ||
        CASE
            WHEN vworganisationsemployees.fk_address IS NULL THEN ''::text
            ELSE (((vworganisationsemployees.street1 || ' '::text) || vworganisationsemployees.town) || ' '::text) || vworganisationsemployees.postcode::text
        END AS summary,
    team_care_members.responsibility
   FROM clin_mentalhealth.team_care_members
     LEFT JOIN contacts.vworganisationsemployees ON team_care_members.fk_branch = vworganisationsemployees.fk_branch AND team_care_members.fk_employee = vworganisationsemployees.fk_employee
  WHERE team_care_members.deleted = false AND team_care_members.fk_branch > 0
UNION
 SELECT team_care_members.pk,
    team_care_members.fk_plan,
    team_care_members.fk_employee,
    NULL::integer AS fk_organisation,
    NULL::integer AS fk_branch,
    vwpersonsincludingpatients.fk_person,
    vwpersonsincludingpatients.wholename,
    (((vwpersonsincludingpatients.street1 || ' '::text) || vwpersonsincludingpatients.town) || ' '::text) || vwpersonsincludingpatients.postcode::text AS summary,
    team_care_members.responsibility
   FROM clin_mentalhealth.team_care_members
     JOIN contacts.vwpersonsincludingpatients ON team_care_members.fk_person = vwpersonsincludingpatients.fk_person
     LEFT JOIN contacts.vworganisationsemployees ON team_care_members.fk_person = vworganisationsemployees.fk_person
  WHERE team_care_members.deleted = false AND team_care_members.fk_employee IS NULL;

ALTER TABLE clin_mentalhealth.vwteamcaremembers   OWNER TO easygp;
GRANT ALL ON TABLE clin_mentalhealth.vwteamcaremembers TO easygp;
GRANT SELECT ON TABLE clin_mentalhealth.vwteamcaremembers TO staff;

update db.lu_version set lu_minor=401;