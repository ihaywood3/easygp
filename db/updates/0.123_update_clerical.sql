Alter TABLE clerical.bookings add column fk_appointment_icon integer default null;

create table clerical.lu_appointment_icons
(pk serial primary key,
 appointment_type text not null,
 icon_path text not null);

 comment on table clerical.lu_appointment_icons is
 'a table holding path to icons to use as visual indicator of appointment types';
ALTER TABLE clerical.lu_appointment_icons OWNER TO easygp;
GRANT ALL ON TABLE clerical.lu_appointment_icons TO easygp;
GRANT ALL ON TABLE clerical.lu_appointment_icons TO staff;

insert into clerical.lu_appointment_icons (appointment_type,icon_path) values ('pregnancy','icons/20/pregnancy.png');
insert into clerical.lu_appointment_icons (appointment_type,icon_path) values ('blood test','icons/16/bloodtube16x16.png');
insert into clerical.lu_appointment_icons (appointment_type,icon_path) values ('mental health plan','icons/22/face-smile.png');
insert into clerical.lu_appointment_icons (appointment_type,icon_path) values ('home visit','icons/22/user-home.png');
insert into clerical.lu_appointment_icons (appointment_type,icon_path) values ('over 75 health assessment','icons/24/hand_2020.png');
insert into clerical.lu_appointment_icons (appointment_type,icon_path) values ('procedure','icons/24/glove-scalple_2424.png');
insert into clerical.lu_appointment_icons (appointment_type,icon_path) values ('immunization','icons/20/syringe2020.png');
insert into clerical.lu_appointment_icons (appointment_type,icon_path) values ('workcover','icons/20/workcover2020.png');
insert into clerical.lu_appointment_icons (appointment_type,icon_path) values ('annual checkup','icons/22/heart.png');
insert into clerical.lu_appointment_icons (appointment_type,icon_path) values ('prescription','icons/20/pill2020.png');
insert into clerical.lu_appointment_icons (appointment_type,icon_path) values ('diabetes cycle of care','icons/24/diabetes_cycle_care_2424.png');

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 123);
