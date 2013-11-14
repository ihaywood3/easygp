
alter table contacts.links_persons_addresses add column left_address boolean default false;

CREATE OR REPLACE VIEW contacts.vwpersonsemployeesbyoccupation AS 
         SELECT DISTINCT (vwpersonsexcludingpatients.fk_person || '-'::text) || COALESCE(vwpersonsexcludingpatients.fk_address, 0)::text AS pk_view, 
         vwpersonsexcludingpatients.fk_person, vwpersonsexcludingpatients.title, 
         vwpersonsexcludingpatients.fk_title, vwpersonsexcludingpatients.surname, 
         vwpersonsexcludingpatients.firstname, vwpersonsexcludingpatients.occupation, 
         vwpersonsexcludingpatients.fk_occupation, vwpersonsexcludingpatients.sex, 
         vwpersonsexcludingpatients.fk_sex, vwpersonsexcludingpatients.retired, vwpersonsexcludingpatients.deceased, 
         vwpersonsexcludingpatients.salutation, 
         NULL::text AS organisation, NULL::text AS branch, 0 AS fk_organisation, 0 AS fk_branch, 
         vwpersonsexcludingpatients.fk_address, 0 AS fk_employee, vwpersonsexcludingpatients.street1, 
         vwpersonsexcludingpatients.street2, vwpersonsexcludingpatients.town, vwpersonsexcludingpatients.state, 
         vwpersonsexcludingpatients.postcode, vwpersonsexcludingpatients.wholename, 
         vwpersonsexcludingpatients.surname_normalised, persons_numbers.provider_number, 
         data_numbers_persons.prescriber_number, data_numbers_persons.hpii, persons_numbers.hpio, 
         persons_numbers.australian_business_number, vwpersonscomms.value AS fax, vwpersonsexcludingpatients.memo, 
         vwpersonsexcludingpatients.fk_image, vwpersonsexcludingpatients.image, 0 as fk_status
           FROM contacts.vwpersonsexcludingpatients
      LEFT JOIN contacts.data_numbers persons_numbers ON persons_numbers.fk_person = vwpersonsexcludingpatients.fk_person AND persons_numbers.fk_branch IS NULL
   LEFT JOIN contacts.data_numbers_persons ON data_numbers_persons.fk_person = vwpersonsexcludingpatients.fk_person
   LEFT JOIN contacts.vwpersonscomms ON vwpersonscomms.fk_person = vwpersonsexcludingpatients.fk_person AND vwpersonscomms.fk_type = 2
  WHERE vwpersonsexcludingpatients.fk_address IS NOT NULL AND 
  (vwpersonsexcludingpatients.address_deleted IS FALSE OR vwpersonsexcludingpatients.address_deleted IS NULL) AND vwpersonsexcludingpatients.deleted = false
UNION 
         SELECT DISTINCT (vwemployees.fk_person || '-'::text) || COALESCE(vwemployees.fk_address, 0)::text AS pk_view, 
         vwemployees.fk_person, vwemployees.title, vwemployees.fk_title, vwemployees.surname, vwemployees.firstname, 
         vwemployees.occupation, vwemployees.fk_occupation, vwemployees.sex, vwemployees.fk_sex, vwemployees.retired, 
         vwemployees.deceased, vwemployees.salutation, vwemployees.organisation, 
                CASE
                    WHEN lower(vwemployees.branch) = 'head office'::text THEN ''::text
                    ELSE vwemployees.branch
                END AS branch, vwemployees.fk_organisation, vwemployees.fk_branch, vwemployees.fk_address, 
                vwemployees.fk_employee, vwemployees.street1, vwemployees.street2, vwemployees.town, vwemployees.state, vwemployees.postcode,
                 (((vwemployees.title || ' '::text) || vwemployees.firstname) || ' '::text) || vwemployees.surname AS wholename, 
                 vwemployees.surname_normalised, vwemployees.provider_number, vwemployees.prescriber_number, vwemployees.hpii, 
                 vwemployees.hpio, vwemployees.australian_business_number, vwbranchescomms.value AS fax, vwemployees.memo, 
                 vwemployees.fk_image, vwemployees.image,vwemployees.fk_status
           FROM contacts.vwemployees
      LEFT JOIN contacts.vwbranchescomms ON vwbranchescomms.fk_branch = vwemployees.fk_branch AND vwbranchescomms.fk_type = 2
     WHERE vwemployees.employee_deleted = false AND vwemployees.person_deleted = false 
     AND (vwemployees.organisation_address_deleted = false OR vwemployees.organisation_address_deleted IS NULL);
 

ALTER TABLE contacts.vwpersonsemployeesbyoccupation   OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsemployeesbyoccupation TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 332);

