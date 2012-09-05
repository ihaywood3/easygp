alter table clerical.bookings add column invoiced boolean default false;

comment on column clerical.bookings.invoiced is 
'if true then the consultation has been invoiced (paid or account raised)';

alter table clerical.bookings add column did_not_attend boolean default false;

comment on column clerical.bookings.did_not_attend is 
'if true then the the patient did not attend the appointment';

CREATE OR REPLACE VIEW clerical.vwappointments AS 
 SELECT bookings.pk, bookings.fk_patient, bookings.fk_staff, bookings.begin, 
 bookings.duration, bookings.notes, bookings.fk_staff_booked, 
 bookings.fk_clinic, bookings.fk_lu_appointment_icon, bookings.fk_lu_appointment_status, 
 bookings.deleted, data_patients.fk_person, data_persons.firstname, 
 data_persons.surname, data_persons.birthdate, lu_sex.sex, 
 lu_title.title, 
 ((lu_title.title || ' '::text) || (data_persons.firstname || ' '::text)) || (data_persons.surname || ' '::text) AS wholename,
 bookings.invoiced, bookings.did_not_attend
   FROM clerical.bookings
   LEFT JOIN clerical.data_patients ON bookings.fk_patient = data_patients.pk
   LEFT JOIN contacts.data_persons ON data_patients.fk_person = data_persons.pk
   LEFT JOIN contacts.lu_sex ON data_persons.fk_sex = lu_sex.pk
   LEFT JOIN contacts.lu_title ON data_persons.fk_title = lu_title.pk
  ORDER BY bookings.begin;

ALTER TABLE clerical.vwappointments   OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwappointments TO easygp;
GRANT ALL ON TABLE clerical.vwappointments TO staff;

create table clerical.lu_payment_method
(pk serial primary key,
 method text not null);
 insert into clerical.lu_payment_method (method) values ('Cash');
 insert into clerical.lu_payment_method (method) values ('EFPos');
 insert into clerical.lu_payment_method (method) values ('Cheque');

 comment on table clerical.lu_payment_method is 'the method of paying the invoice';
 
ALTER TABLE clerical.lu_payment_method OWNER TO easygp;
GRANT ALL ON TABLE clerical.lu_payment_method TO easygp;
GRANT ALL ON TABLE clerical.lu_payment_method TO staff;


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 224);

