
--drop table  clerical.staff_shifts cascade;
--drop table  clerical.lu_staff_notes_type cascade;
--drop table clerical.staff_notes ;
CREATE TABLE clerical.lu_staff_message_type
(
  pk serial primary key,
  type text NOT NULL
)
;

ALTER TABLE clerical.lu_staff_message_type   OWNER TO easygp;
GRANT SELECT ON TABLE clerical.lu_staff_message_type TO staff;
GRANT ALL ON TABLE clerical.lu_staff_message_type_pk_seq   TO STAFF;

COMMENT ON TABLE clerical.lu_staff_message_type is 
'the type of message entry made by the staff';

INSERT INTO clerical.lu_staff_message_type (type) values ('General');
INSERT INTO clerical.lu_staff_message_type (type) values ('Complaint');
INSERT INTO clerical.lu_staff_message_type (type) values ('Referral');
INSERT INTO clerical.lu_staff_message_type (type) values ('Phone Call');
INSERT INTO clerical.lu_staff_message_type (type) values ('Scripts');
INSERT INTO clerical.lu_staff_message_type (type) values ('Document');
INSERT INTO clerical.lu_staff_message_type (type) values ('Staff Meeting ');

CREATE TABLE clerical.staff_shifts
(
  pk serial primary key,
  shift_date timestamp without time zone NOT NULL,
  fk_staff integer NOT NULL references admin.staff(pk)
);
ALTER TABLE clerical.staff_shifts   OWNER TO easygp;
GRANT ALL ON TABLE clerical.staff_shifts TO staff;
GRANT ALL ON TABLE clerical.staff_shifts_pk_seq TO STAFF;
comment on table clerical.staff_shifts is 'the record of the staff''s shift';



CREATE TABLE clerical.staff_messages
(
  pk serial primary key,
  time_logged timestamp without time zone NOT NULL,
  fk_staff_shift integer NOT NULL references clerical.staff_shifts (pk),
  notes text not null,
  fk_staff_destination integer default null,
  fk_lu_urgency integer not null references common.lu_urgency(pk),
  fk_staff_completed integer default null,
  fk_lu_staff_message_type integer NOT NULL references  clerical.lu_staff_message_type (pk),
  completed boolean default false,
  date_completed date default null,
  completion_notes text default null,
  deleted boolean DEFAULT false 
);

ALTER TABLE clerical.staff_messages   OWNER TO easygp;
GRANT ALL ON TABLE clerical.staff_messages TO staff;
GRANT ALL ON TABLE clerical.staff_messages_pk_seq TO STAFF;

create OR replace view Clerical.vwStaffMessages as (
select staff_shifts.pk as fk_staff_shift,
       staff_shifts.shift_date,
       staff_shifts.fk_staff as fk_staff_logged,
       vwStaff.title as staff_logged_title,
       vwStaff.wholename as staff_logged_wholename,
       staff_messages.pk as pk_staff_messages,
       staff_messages.time_logged,
       staff_messages.notes,
       staff_messages.fk_staff_destination,
       staff_messages.fk_staff_completed,
       staff_messages.fk_lu_urgency,
       staff_messages.fk_lu_staff_message_type,
       staff_messages.deleted as staff_note_deleted,
       staff_messages.completed,
       staff_messages.date_completed,
       staff_messages.completion_notes,
       lu_staff_message_type.type,
       vwStaff1.wholename as staff_destination_wholename,
       vwStaff1.title as staff_destination_title,
       vwStaff2.wholename as staff_completed_wholename,
       vwStaff2.title as staff_completed_title
FROM    clerical.staff_shifts
JOIN    admin.vwStaff on staff_shifts.fk_staff = vwSTaff.fk_staff
JOIN    clerical.staff_messages on staff_messages.fk_staff_shift = staff_shifts.pk
JOIN    common.lu_urgency on staff_messages.fk_lu_urgency = lu_urgency.pk
LEFT JOIN admin.vwStaff as vwStaff1 on staff_messages.fk_staff_destination = vwStaff1.fk_staff
LEFT JOIN  admin.vwStaff as vwStaff2 on staff_messages.fk_staff_completed = vwStaff2.fk_staff
JOIN    clerical.lu_staff_message_type on lu_staff_message_type.pk = staff_messages.fk_lu_staff_message_type)
;

ALTER TABLE clerical.vwStaffmessages   OWNER TO easygp;
GRANT SELECT ON TABLE clerical.vwStaffmessages TO staff;


update db.lu_version set lu_minor = 486;
