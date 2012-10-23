CREATE OR REPLACE VIEW "admin".vwstaff AS 
 SELECT roles.role, staff.fk_person, staff.logon_name, staff.fk_role, staff.pk, 
 staff.pk AS fk_staff, persons.firstname, persons.surname, (persons.firstname || ' '::text) || persons.surname AS wholename, 
 persons.salutation, persons.fk_title, lu_title.title, staff.qualifications, persons.surname_normalised,
 data_numbers.provider_number, data_numbers.prescriber_number, data_numbers.australian_business_number
   FROM admin.staff staff
   JOIN admin.lu_staff_roles roles ON staff.fk_role = roles.pk
   JOIN contacts.data_persons persons ON staff.fk_person = persons.pk
   JOIN contacts.lu_title ON persons.fk_title = lu_title.pk
   left JOIN contacts.data_numbers on  staff.fk_person = data_numbers.fk_person;
ALTER TABLE "admin".vwstaff OWNER TO easygp;
GRANT ALL ON TABLE "admin".vwstaff TO easygp;
GRANT ALL ON TABLE "admin".vwstaff TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 237);
