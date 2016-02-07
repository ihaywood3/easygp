CREATE OR REPLACE VIEW admin.vwstaff AS 
 SELECT roles.role,
    staff.fk_person,
    staff.logon_name,
    staff.fk_role,
    staff.pk,
    staff.pk AS fk_staff,
    persons.firstname,
    persons.surname,
    (persons.firstname || ' '::text) || persons.surname AS wholename,
    persons.salutation,
    persons.fk_title,
    lu_title.title,
    staff.qualifications,
    persons.surname_normalised,
    employees_numbers.provider_number,
    data_numbers_persons.prescriber_number,
    employees_numbers.australian_business_number,
    data_numbers_persons.hpii,
    staff.fk_status,
    lu_employee_status.status
   FROM admin.staff staff
     JOIN admin.lu_staff_roles roles ON staff.fk_role = roles.pk
     JOIN contacts.data_persons persons ON staff.fk_person = persons.pk
     JOIN contacts.lu_title ON persons.fk_title = lu_title.pk
     LEFT JOIN contacts.data_numbers_persons ON staff.fk_person = data_numbers_persons.fk_person
     LEFT JOIN contacts.data_numbers employees_numbers ON staff.fk_person = employees_numbers.fk_person
     JOIN contacts.lu_employee_status ON staff.fk_status = lu_employee_status.pk;

ALTER TABLE admin.vwstaff   OWNER TO easygp;
GRANT ALL ON TABLE admin.vwstaff TO easygp;
GRANT ALL ON TABLE admin.vwstaff TO staff;

update db.lu_version set lu_minor = 485;
