﻿-- request from Horst''s surgery
alter table clerical.data_patients add column long_appointment boolean default false;
comment on column clerical.data_patients.long_appointment is 'if true the when making an appointment the user will be reminded this patient usually needs a long appointment';
alter table clerical.data_patients add column appointment_memo text default null;
comment on column clerical.data_patients.appointment_memo is 'text to communicate to patient at time of making the appointment e.g - pick up Xrays - ';


CREATE OR REPLACE VIEW contacts.vwpatients AS 
 SELECT
        CASE
            WHEN addresses.pk IS NULL THEN patients.pk || '-0'::text
            ELSE (patients.pk || '-'::text) || addresses.pk
        END AS pk_view,
    patients.pk AS fk_patient,
    link_person_address.fk_address,
    patients.fk_person,
    ((title.title || ' '::text) || (persons.firstname || ' '::text)) || persons.surname AS wholename,
    patients.fk_doctor,
    patients.fk_next_of_kin,
    patients.fk_payer_person,
    patients.fk_payer_branch,
    patients.fk_family,
    patients.medicare_number,
    patients.medicare_ref_number,
    patients.medicare_expiry_date,
    patients.veteran_number,
    patients.veteran_specific_condition,
    patients.concession_card_number,
    patients.concession_card_expiry_date,
    patients.memo AS patient_memo,
    patients.source_database_key,
    patients.fk_lu_aboriginality,
    patients.fk_lu_veteran_card_type,
    patients.fk_lu_active_status,
    patients.fk_lu_centrelink_card_type,
    patients.fk_lu_private_health_fund,
    patients.fk_lu_default_billing_level,
    patients.private_insurance,
    patients.nursing_home_resident,
    patients.ihi,
    patients.pcehr_consent,
    patients.ihi_updated,
    patients.fk_branch_pharmacy,
    patients.uses_webster_pack,
    patients.memo_for_pharmacy,
    patients.patient_at_practice_since,
    patients.fk_source_program,
    lu_active_status.status AS active_status,
    lu_veteran_card_type.type AS veteran_card_type,
    lu_centrelink_card_type.type AS concession_card_type,
    lu_private_health_funds.fund,
    persons.firstname,
    persons.surname,
    persons.salutation,
    persons.birthdate,
    age_display(age(persons.birthdate::timestamp with time zone)) AS age_display,
    date_part('year'::text, age(persons.birthdate::timestamp with time zone)) AS age_numeric,
    persons.fk_ethnicity,
    persons.fk_language,
    persons.memo AS person_memo,
    persons.fk_marital,
    persons.fk_title,
    persons.fk_sex,
    persons.country_code AS country_birth_country_code,
    persons.fk_image,
    persons.retired,
    persons.fk_occupation,
    persons.deleted AS person_deleted,
    persons.deceased,
    persons.date_deceased,
    persons.language_problems,
    persons.surname_normalised,
    lu_aboriginality.aboriginality,
    country_birth.country AS country_birth,
    lu_ethnicity.ethnicity,
    lu_languages.language,
    lu_occupations.occupation,
    lu_marital.marital,
    title.title,
    lu_sex.sex,
    lu_sex.sex_text,
    images.image,
    images.md5sum,
    images.tag,
    images.fk_consult AS fk_consult_image,
    link_person_address.pk AS fk_link_persons_address,
    addresses.street1,
    addresses.fk_town,
    addresses.preferred_address,
    addresses.postal_address,
    addresses.head_office,
    addresses.geolocation,
    addresses.country_code,
    addresses.fk_lu_address_type,
    addresses.deleted AS address_deleted,
    addresses.street2,
    address_country.country,
    link_person_address.deleted AS link_address_deleted,
    lu_address_types.type AS address_type,
    lu_towns.postcode,
    lu_towns.town,
    lu_towns.state,
    lu_default_billing_level.level AS billing_level,
    patients.long_appointment,
    patients.appointment_memo
   FROM clerical.data_patients patients
     JOIN clerical.lu_active_status lu_active_status ON patients.fk_lu_active_status = lu_active_status.pk
     LEFT JOIN clerical.lu_centrelink_card_type ON patients.fk_lu_centrelink_card_type = lu_centrelink_card_type.pk
     LEFT JOIN common.lu_aboriginality ON patients.fk_lu_aboriginality = lu_aboriginality.pk
     LEFT JOIN clerical.lu_veteran_card_type ON patients.fk_lu_veteran_card_type = lu_veteran_card_type.pk
     LEFT JOIN clerical.lu_private_health_funds ON patients.fk_lu_private_health_fund = lu_private_health_funds.pk
     LEFT JOIN billing.lu_default_billing_level ON patients.fk_lu_default_billing_level = lu_default_billing_level.pk
     JOIN contacts.data_persons persons ON patients.fk_person = persons.pk
     LEFT JOIN common.lu_ethnicity ON persons.fk_ethnicity = lu_ethnicity.pk
     LEFT JOIN common.lu_languages ON persons.fk_language = lu_languages.pk
     LEFT JOIN common.lu_occupations ON persons.fk_occupation = lu_occupations.pk
     LEFT JOIN contacts.lu_marital ON persons.fk_marital = lu_marital.pk
     LEFT JOIN contacts.lu_title title ON persons.fk_title = title.pk
     LEFT JOIN contacts.lu_sex ON persons.fk_sex = lu_sex.pk
     LEFT JOIN blobs.images images ON persons.fk_image = images.pk
     LEFT JOIN contacts.links_persons_addresses link_person_address ON persons.pk = link_person_address.fk_person
     LEFT JOIN contacts.data_addresses addresses ON link_person_address.fk_address = addresses.pk
     LEFT JOIN contacts.lu_address_types ON addresses.fk_lu_address_type = lu_address_types.pk
     LEFT JOIN contacts.lu_towns ON addresses.fk_town = lu_towns.pk
     LEFT JOIN common.lu_countries country_birth ON persons.country_code = country_birth.country_code::text
     LEFT JOIN common.lu_countries address_country ON addresses.country_code = address_country.country_code;

ALTER TABLE contacts.vwpatients OWNER TO easygp;
GRANT ALL ON TABLE contacts.vwpatients TO easygp;
GRANT SELECT ON TABLE contacts.vwpatients TO staff;

update db.lu_version set lu_minor = 477;