
-- Added field to accomodate identifying and 'add fit' appointment

insert into clerical.lu_appointment_status(status) values ('fit in appointment made');

UPDATE clerical.lu_appointment_icons SET icon_path='icons/12/pregnancy1212.png' WHERE pk= 1 ;
UPDATE clerical.lu_appointment_icons SET icon_path='icons/12/bloodtube1212.png' WHERE pk= 2 ;
UPDATE clerical.lu_appointment_icons SET icon_path='icons/12/workcover1212.png' WHERE pk= 8 ;
UPDATE clerical.lu_appointment_icons SET icon_path='icons/12/mentalhealth1212.png' WHERE pk= 3 ;
UPDATE clerical.lu_appointment_icons SET icon_path='icons/12/united_nations_diabetes_icon1212.png' WHERE pk= 11 ;
UPDATE clerical.lu_appointment_icons SET icon_path='icons/12/heart1212.png' WHERE pk= 9 ;
UPDATE clerical.lu_appointment_icons SET icon_path='icons/16/pill1808.png' WHERE pk= 10 ;
UPDATE clerical.lu_appointment_icons SET icon_path='icons/12/home1212.png' WHERE pk= 4 ;
UPDATE clerical.lu_appointment_icons SET icon_path='icons/12/syringe1212.png' WHERE pk= 7 ;
UPDATE clerical.lu_appointment_icons SET icon_path='icons/12/over75healthassessment1212.png' WHERE pk= 5 ;
UPDATE clerical.lu_appointment_icons SET icon_path='icons/12/glove-scalpel1212.png' WHERE pk= 6 ;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 148);
