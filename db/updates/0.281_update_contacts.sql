CREATE OR REPLACE VIEW contacts.vwpersonsincludingpatients AS 
 SELECT persons.pk AS fk_person, 
        CASE
            WHEN addresses.pk > 0 THEN COALESCE((persons.pk || '-'::text) || addresses.pk)
            ELSE persons.pk || '-0'::text
        END AS pk_view, addresses.pk AS fk_address, 
        ((title.title || ' '::text) || (persons.firstname || ' '::text)) || (persons.surname || ' '::text) AS wholename, 
        persons.firstname, persons.surname, persons.salutation, persons.birthdate, 
        date_part('year'::text, age(persons.birthdate::timestamp with time zone)) AS age, 
        marital.marital, sex.sex, title.title, countries.country, languages.language, 
        countries1.country AS country_birth, ethnicity.ethnicity, addresses.street1, 
        addresses.street2, towns.town, towns.state, towns.postcode, addresses.fk_town, 
        addresses.preferred_address, addresses.postal_address, addresses.head_office, 
        addresses.geolocation, addresses.country_code, addresses.fk_lu_address_type AS fk_address_type, 
        addresses.deleted AS address_deleted, persons.fk_ethnicity, persons.fk_language, 
        persons.language_problems, persons.memo, persons.fk_marital, persons.country_code AS country_birth_country_code, 
        persons.fk_title, persons.deceased, persons.date_deceased, persons.fk_sex, images.pk AS fk_image, 
        images.image, images.md5sum, images.tag, images.fk_consult AS fk_consult_image, persons.surname_normalised,
        data_patients.pk as fk_patient
   FROM contacts.data_persons persons
   LEFT JOIN clerical.data_patients ON persons.pk = data_patients.pk
   LEFT JOIN contacts.links_persons_addresses ON persons.pk = links_persons_addresses.fk_person
   LEFT JOIN contacts.lu_marital marital ON persons.fk_marital = marital.pk
   LEFT JOIN contacts.lu_sex sex ON persons.fk_sex = sex.pk
   LEFT JOIN common.lu_languages languages ON persons.fk_language = languages.pk
   LEFT JOIN contacts.lu_title title ON persons.fk_title = title.pk
   LEFT JOIN common.lu_ethnicity ethnicity ON persons.fk_ethnicity = ethnicity.pk
   LEFT JOIN blobs.images ON persons.fk_image = images.pk
   LEFT JOIN common.lu_countries countries ON persons.country_code = countries.country_code::text
   LEFT JOIN contacts.data_addresses addresses ON links_persons_addresses.fk_address = addresses.pk
   LEFT JOIN contacts.lu_towns towns ON addresses.fk_town = towns.pk
   LEFT JOIN common.lu_countries countries1 ON addresses.country_code = countries1.country_code;

ALTER TABLE contacts.vwpersonsincludingpatients   OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpersonsincludingpatients TO easygp;
GRANT SELECT ON TABLE contacts.vwpersonsincludingpatients TO staff;
COMMENT ON VIEW contacts.vwpersonsincludingpatients
  IS 'a view of all persons including those who are patients';

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 281);

