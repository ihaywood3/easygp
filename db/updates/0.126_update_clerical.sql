create TABLE clerical.lu_appointment_status
(pk serial primary key,
 status text not null);

 insert into clerical.lu_appointment_status(status) values ('appointment made');
 insert into clerical.lu_appointment_status(status) values ('arrived and waiting');
 insert into clerical.lu_appointment_status(status) values ('in consulting room');
 insert into clerical.lu_appointment_status(status) values ('patient departed');


ALTER TABLE clerical.lu_appointment_status OWNER TO easygp;
GRANT ALL ON TABLE clerical.lu_appointment_status TO easygp;
GRANT ALL ON TABLE clerical.lu_appointment_status TO staff;

COMMENT ON TABLE clerical.lu_appointment_status IS 
'the status of the appointment as it applies to patient: arrived (color code blue), seeing clinician (red), gray (patient gone)';

alter table clerical.bookings add column fk_lu_appointment_status integer default 1;

DROP VIEW clerical.vwappointments;

CREATE OR REPLACE VIEW clerical.vwappointments AS
 SELECT bookings.pk, bookings.fk_patient, bookings.fk_staff, bookings.begin, bookings.duration,
 bookings.notes, bookings.fk_staff_booked, bookings.fk_clinic, bookings.fk_lu_appointment_icon,
 bookings.fk_lu_appointment_status,
 bookings.deleted,
  clerical.data_patients.fk_person,
  contacts.data_persons.firstname,
  contacts.data_persons.surname,
  contacts.data_persons.birthdate,
  contacts.lu_sex.sex,
  contacts.lu_title.title,
   (((contacts.lu_title.title ||
    ' '::text) || (contacts.data_persons.firstname || ' '::text)) ||
    (contacts.data_persons.surname || ' '::text)) AS wholename
FROM
  clerical.bookings
  INNER JOIN clerical.data_patients ON (clerical.bookings.fk_patient = clerical.data_patients.pk)
  INNER JOIN contacts.data_persons ON (clerical.data_patients.fk_person = contacts.data_persons.pk)
  INNER JOIN contacts.lu_sex ON (contacts.data_persons.fk_sex = contacts.lu_sex.pk)
  INNER JOIN contacts.lu_title ON (contacts.data_persons.fk_title = contacts.lu_title.pk)order by bookings.begin;

ALTER TABLE clerical.vwappointments OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwappointments TO easygp;
GRANT ALL ON TABLE clerical.vwappointments TO staff;

update clerical.lu_appointment_icons set icon_path= 'icons/20/united_nations_diabetes_icon.png' where pk=11;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 126);
