create table clerical.sessions (
    pk serial primary key,
    fk_staff integer not null references admin.staff (pk),
    fk_clinic integer not null references admin.clinics (pk),
    "begin" time,
    "finish" time,
    weekday smallint, -- 0=Sunday, 6=Saturday
    of_month boolean[5] default '{true,true,true,true,true}' -- which weeks of the month for fortnightly/monthly sessions
);

create table clerical.holidays (
     pk serial primary key,
     fk_staff integer references admin.staff (pk), -- NULL means all staff
     "begin" timestamp,
     "finish" timestamp,
     "name" text
);

create table clerical.bookings (
      pk serial8 primary key,
      fk_patient integer not null references clerical.data_patients (pk),
      fk_staff integer not null references admin.staff (pk),
      "begin" timestamp,
      "duratipn" interval,
      notes text,
      booked_by integer not null references admin.staff (pk),
      booked_at timestamp not null default now ()
);

CREATE FUNCTION clerical.listsessions(timestamp, integer) RETURNS SETOF clerical.sessions AS $$
    select * from clerical.sessions where fk_clinic = $2 and weekday = extract(dow from $1)
           and of_month[((extract(day from $1)-1)/7)+1]
$$ LANGUAGE SQL;