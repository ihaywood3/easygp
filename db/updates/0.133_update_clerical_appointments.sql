-- remove constraint on bookings as a appointment slot dosn't need a patient key
-- examples drug rep or comment.
alter table clerical.bookings drop constraint bookings_fk_patient_fkey;
insert into clerical.lu_appointment_status (status) values ('emergency');
DROP VIEW clerical.vwappointments;

CREATE OR REPLACE VIEW clerical.vwappointments AS 
 SELECT bookings.pk, bookings.fk_patient, bookings.fk_staff, bookings.begin, bookings.duration, bookings.notes, 
 bookings.fk_staff_booked, bookings.fk_clinic, bookings.fk_lu_appointment_icon, bookings.fk_lu_appointment_status,
  bookings.deleted, data_patients.fk_person, data_persons.firstname, data_persons.surname, 
  data_persons.birthdate, lu_sex.sex, lu_title.title, 
  ((lu_title.title || ' '::text) || (data_persons.firstname || ' '::text)) || (data_persons.surname || ' '::text) AS wholename
   FROM clerical.bookings
   left JOIN clerical.data_patients ON bookings.fk_patient = data_patients.pk
   left JOIN contacts.data_persons ON data_patients.fk_person = data_persons.pk
   left JOIN contacts.lu_sex ON data_persons.fk_sex = lu_sex.pk
   left JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
  ORDER BY bookings.begin;

ALTER TABLE clerical.vwappointments OWNER TO richard;
GRANT ALL ON TABLE clerical.vwappointments TO richard;
GRANT ALL ON TABLE clerical.vwappointments TO easygp;
GRANT ALL ON TABLE clerical.vwappointments TO staff;


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 133);

