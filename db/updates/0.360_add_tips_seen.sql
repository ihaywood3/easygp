create table admin.tips_seen (
	pk serial primary key,
	tip text,
	fk_staff integer references admin.staff (pk)
);

grant all on admin.tips_seen to staff;
grant all on admin.tips_seen_pk_seq to staff;


update db.lu_version set lu_minor=360;
