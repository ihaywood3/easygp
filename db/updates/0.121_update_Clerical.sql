-- minor modifications to appointments

Alter table clerical.sessions add column appointment_interval interval default '10 minutes';
alter table clerical.bookings rename column booked_by to fk_staff_booked;
ALTER TABLE clerical.bookings drop column fk_clinic;
alter table clerical.bookings add column fk_clinic integer not null;
alter table clerical.bookings add deleted boolean default false;

ALTER TABLE clerical.bookings OWNER TO easygp;
GRANT ALL ON TABLE clerical.bookings TO easygp;
GRANT ALL ON TABLE clerical.bookings TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 121);

