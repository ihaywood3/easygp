create table research.queries (pk serial primary key,
"sql" text not null,
gnuplot text,
title text not null);

alter table research.queries owner to easygp;
grant all on research.queries to staff;


update db.lu_version set lu_minor = 441;
