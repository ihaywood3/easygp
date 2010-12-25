-- new view which combines addresses of persons in organisations (employees)
-- with addresses of persons not in organisations

CREATE OR REPLACE VIEW contacts.vwPersonsAndEmployeesAddresses AS 
         SELECT vworganisationsemployees.fk_address, 
                CASE
                    WHEN vworganisationsemployees.fk_address IS NULL THEN vworganisationsemployees.fk_person || '-0'::text
                    ELSE (vworganisationsemployees.fk_person || '-'::text) || vworganisationsemployees.fk_address::text
                END AS pk_view, vworganisationsemployees.fk_branch, vworganisationsemployees.branch, vworganisationsemployees.organisation, vworganisationsemployees.fk_person, vworganisationsemployees.firstname, vworganisationsemployees.surname, vworganisationsemployees.title, vworganisationsemployees.occupation, vworganisationsemployees.street, vworganisationsemployees.town, vworganisationsemployees.state, vworganisationsemployees.postcode
           FROM contacts.vworganisationsemployees
          WHERE vworganisationsemployees.fk_person <> 0
UNION 
         SELECT vwpersonsexcludingpatients.fk_address, 
                CASE
                    WHEN vwpersonsexcludingpatients.fk_address IS NULL THEN vwpersonsexcludingpatients.fk_person || '-0'::text
                    ELSE (vwpersonsexcludingpatients.fk_person || '-'::text) || vwpersonsexcludingpatients.fk_address::text
                END AS pk_view, NULL::unknown AS fk_branch, NULL::unknown AS branch, NULL::unknown AS organisation, vwpersonsexcludingpatients.fk_person, vwpersonsexcludingpatients.firstname, vwpersonsexcludingpatients.surname, vwpersonsexcludingpatients.title, vwpersonsexcludingpatients.occupation, vwpersonsexcludingpatients.street, vwpersonsexcludingpatients.town, vwpersonsexcludingpatients.state, vwpersonsexcludingpatients.postcode
           FROM contacts.vwpersonsexcludingpatients
          WHERE vwpersonsexcludingpatients.fk_person <> 0 AND vwpersonsexcludingpatients.fk_address IS NOT NULL
  ORDER BY 6, 12;

Grant all on contacts.vwPersonsAndEmployeesAddresses to staff;


comment on view contacts.vwPersonsAndEmployeesAddresses is
'A view of all addresses for a person whether they have a private address or their address as an employee of an organisation';


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 56)
