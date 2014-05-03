-- basic 'tips' handling for the gui, the tips are in the gui, the desire not to see them in the backend.
--drop table admin.tips_seen;

create table admin.tips_seen
(fk_staff integer not null,
 tip_name text not null
 )
 ;

comment on table  admin.tips_seen is 'lists tip the staff member has viewed and does not want to see again';

alter table admin.tips_seen owner to easygp;
grant all on table admin.tips_seen to staff;

update db.lu_version set lu_minor=360;
