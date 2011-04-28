-- bit of a subtle change:
-- as it is possible for a person or employee to not have an address need to allow for this
-- comes about because vwEmployees can have eg an organisation + named branch without the branch address eg John Hunter Hospital/Nephrology
-- AND (vwpersonsexcludingpatients.address_deleted IS FALSE OR vwpersonsexcludingpatients.address_deleted IS NULL)
-- AND (vwemployees.organisation_address_deleted = false or vwemployees.organisation_address_deleted  is null)
-- anyway whatever, it fixes the problem of missing doctors or other persons.

DROP VIEW contacts.vwpersonsemployeesbyoccupation;

CREATE OR REPLACE VIEW contacts.vwpersonsemployeesbyoccupation AS 
         SELECT DISTINCT (vwpersonsexcludingpatients.fk_person || '-'::text) || COALESCE(vwpersonsexcludingpatients.fk_address, 0)::text AS pk_view, 
         vwpersonsexcludingpatients.fk_person, vwpersonsexcludingpatients.title, vwpersonsexcludingpatients.surname, 
         vwpersonsexcludingpatients.firstname, vwpersonsexcludingpatients.occupation, vwpersonsexcludingpatients.sex, 
         vwpersonsexcludingpatients.salutation, NULL::text AS organisation, NULL::text AS branch, 0 AS fk_organisation, 0 AS fk_branch, 
         vwpersonsexcludingpatients.fk_address, 0 AS fk_employee, vwpersonsexcludingpatients.street1, vwpersonsexcludingpatients.street2, vwpersonsexcludingpatients.town, vwpersonsexcludingpatients.state, vwpersonsexcludingpatients.postcode, vwpersonsexcludingpatients.wholename
           FROM contacts.vwpersonsexcludingpatients
          WHERE vwpersonsexcludingpatients.retired IS FALSE AND vwpersonsexcludingpatients.deceased IS FALSE AND 
          vwpersonsexcludingpatients.fk_address IS NOT NULL 
          AND (vwpersonsexcludingpatients.address_deleted IS FALSE OR vwpersonsexcludingpatients.address_deleted IS NULL)
          AND vwpersonsexcludingpatients.deleted = false
UNION 
         SELECT DISTINCT (vwemployees.fk_person || '-'::text) || COALESCE(vwemployees.fk_address, 0)::text AS pk_view, 
         vwemployees.fk_person, vwemployees.title, vwemployees.surname, vwemployees.firstname, vwemployees.occupation, 
         vwemployees.sex, vwemployees.salutation, vwemployees.organisation, vwemployees.branch, vwemployees.fk_organisation, 
         vwemployees.fk_branch, vwemployees.fk_address, vwemployees.fk_employee, vwemployees.street1, vwemployees.street2,
          vwemployees.town, vwemployees.state, vwemployees.postcode, 
          (((vwemployees.title || ' '::text) || vwemployees.firstname) || ' '::text) || vwemployees.surname AS wholename
           FROM contacts.vwemployees
          WHERE vwemployees.employee_deleted = false AND vwemployees.person_deleted = false 
          AND vwemployees.deceased = false AND vwemployees.retired = false 
          AND (vwemployees.organisation_address_deleted = false or vwemployees.organisation_address_deleted  is null)
          AND vwemployees.fk_status <> 2
  ORDER BY 6, 4, 5;

ALTER TABLE contacts.vwpersonsemployeesbyoccupation OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsemployeesbyoccupation TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsemployeesbyoccupation TO staff;

COMMENT ON VIEW contacts.vwpersonsemployeesbyoccupation IS 'A view of all people in the database and their occupations, listed by their addresses, whether in organisations or sole traders
 Persons who are retired, deceased or left the organisation (if an employee) are excluded.';


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 103);

