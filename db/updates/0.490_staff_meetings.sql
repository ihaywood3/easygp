
Create table clerical.staff_meetings
(pk serial primary key,
 meeting_date timestamp without time zone NOT NULL
 );
 
alter table clerical.staff_meetings OWNER to easygp;
grant all on clerical.staff_meetings to staff;

Create table clerical.staff_meetings_attendees
(pk serial primary key,
fk_staff integer not null references  admin.staff(pk), 
fk_meeting integer not null references clerical.staff_meetings (pk)
);

alter table clerical.staff_meetings_attendees OWNER to easygp;
grant all on clerical.staff_meetings_attendees to staff;

COMMENT ON TABLE clerical.staff_meetings_attendees IS
'a link table, linking a staff meeting to staff who attended';

Create table clerical.staff_meeting_issues
(pk serial primary key,
date_logged  timestamp without time zone NOT NULL,
issue text not null,
issue_details text default null,
fk_staff_logged integer not null references  admin.staff(pk),
fk_staff_allocated integer default null references  admin.staff(pk),
proposed_action text default null,
progress_towards_resolution text default null,
outcome_achieved boolean default false,
finalised boolean default false,
deleted boolean default false
);

COMMENT ON COLUMN clerical.staff_meeting_issues.fk_staff_allocated  IS 'If not null, the staff member to whom the issue is allocated to resolve';

alter table clerical.staff_meeting_issues OWNER to easygp;
grant all on clerical.staff_meeting_issues to staff;

create table clerical.staff_meeting_agenda
(pk serial primary key,
 fk_issue integer not null references clerical.staff_meeting_issues(pk),
 fk_meeting  integer not null references clerical.staff_meetings(pk)
 );

alter table clerical.staff_meeting_agenda OWNER to easygp;
grant all on clerical.staff_meeting_agenda to staff;

 COMMENT ON TABLE clerical.staff_meeting_agenda IS
'a link table, linking a staff meeting to issues discussed';


Create table clerical.Staff_Meeting_Issue_Notes
(pk serial primary key,
fk_staff integer not null   references  admin.staff(pk),
fk_issue integer not null references clerical.staff_meeting_issues(pk),
note text not null
);

alter table clerical.Staff_Meeting_Issue_Notes OWNER to easygp;
grant all on clerical.Staff_Meeting_Issue_Notes to staff;

Create or replace view clerical.vwStaffMeetingIssues as
select 
  staff_meeting_issues.pk,
  staff_meeting_issues.date_logged,
  staff_meeting_issues.issue,
  staff_meeting_issues.issue_details,
  staff_meeting_issues.fk_staff_logged,
  staff_meeting_issues.fk_staff_allocated,
  staff_meeting_issues.proposed_action,
  staff_meeting_issues.progress_towards_resolution,
  staff_meeting_issues.outcome_achieved,
  staff_meeting_issues.finalised,
  staff_meeting_issues.deleted,
  vwStaff.title as staff_logged_title,
  vwStaff.wholename as staff_logged_wholename
 FROM
 clerical.staff_meeting_issues
 JOIN admin.vwstaff on staff_meeting_issues.fk_staff_logged = vwStaff.fk_staff
 LEFT JOIN  admin.vwStaff vwstaffAllocated on staff_meeting_issues.fk_staff_allocated = vwstaffAllocated .fk_staff;

 alter table clerical.vwStaffMeetingIssues OWNER to easygp;
 grant select on table clerical.vwStaffMeetingIssues to staff;