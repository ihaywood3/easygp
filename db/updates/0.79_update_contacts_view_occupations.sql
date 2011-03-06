-- View: contacts.vwpersonsemployeesbyoccupation
DROP VIEW contacts.vwpersonsoremployees_by_occupation;
-- DROP VIEW contacts.vwpersonsemployeesbyoccupation;

CREATE OR REPLACE VIEW contacts.vwpersonsemployeesbyoccupation AS 
         SELECT DISTINCT (vwpersonsexcludingpatients.fk_person || '-'::text) || COALESCE(vwpersonsexcludingpatients.fk_address, 0)::text AS pk_view, vwpersonsexcludingpatients.fk_person, vwpersonsexcludingpatients.title, vwpersonsexcludingpatients.surname, vwpersonsexcludingpatients.firstname, vwpersonsexcludingpatients.occupation, vwpersonsexcludingpatients.sex, vwpersonsexcludingpatients.salutation, NULL::text AS organisation, NULL::text AS branch, 0 AS fk_organisation, 0 AS fk_branch, vwpersonsexcludingpatients.fk_address, 0 AS fk_employee, vwpersonsexcludingpatients.street, vwpersonsexcludingpatients.town, vwpersonsexcludingpatients.state, vwpersonsexcludingpatients.postcode, vwpersonsexcludingpatients.wholename
           FROM contacts.vwpersonsexcludingpatients
          WHERE vwpersonsexcludingpatients.retired IS FALSE AND vwpersonsexcludingpatients.deceased IS FALSE AND vwpersonsexcludingpatients.fk_address IS NOT NULL AND vwpersonsexcludingpatients.address_deleted IS FALSE AND vwpersonsexcludingpatients.deleted = false
UNION 
         SELECT DISTINCT (vwemployees.fk_person || '-'::text) || COALESCE(vwemployees.fk_address, 0)::text AS pk_view, vwemployees.fk_person, vwemployees.title, vwemployees.surname, vwemployees.firstname, vwemployees.occupation, vwemployees.sex, vwemployees.salutation, vwemployees.organisation, vwemployees.branch, vwemployees.fk_organisation, vwemployees.fk_branch, vwemployees.fk_address, vwemployees.fk_employee, vwemployees.street, vwemployees.town, vwemployees.state, vwemployees.postcode, (((vwemployees.title || ' '::text) || vwemployees.firstname) || ' '::text) || vwemployees.surname AS wholename
           FROM contacts.vwemployees
          WHERE vwemployees.employee_deleted = false AND vwemployees.person_deleted = false AND vwemployees.deceased = false AND vwemployees.retired = false AND vwemployees.organisation_address_deleted = false AND vwemployees.fk_status <> 2
  ORDER BY 6, 4, 5;

ALTER TABLE contacts.vwpersonsemployeesbyoccupation OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsemployeesbyoccupation TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsemployeesbyoccupation TO staff;
COMMENT ON VIEW contacts.vwpersonsemployeesbyoccupation IS 'A view of all people in the database and their occupations, listed by their addresses, whether in organisations or sole traders
 Persons who are retired, deceased or left the organisation (if an employee) are excluded.';

ALTER TABLE contacts.vwPersonsEmployeesByOccupation OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwPersonsEmployeesByOccupation TO easygp;
GRANT ALL ON TABLE contacts.vwPersonsEmployeesByOccupation TO staff;


Comment on view contacts.vwPersonsEmployeesByOccupation is
'A view of all people in the database and their occupations, listed by their addresses, whether in organisations or sole traders
 Persons who are retired, deceased or left the organisation (if an employee) are excluded.';


truncate table db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 79);

