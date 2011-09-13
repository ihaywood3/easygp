create table clerical.sessions (
    pk serial primary key,
    fk_staff integer not null references admin.staff (pk),
    fk_clinic integer not null references admin.clinics (pk),
    "begin" time,
    "finish" time,
    weekday smallint, 
    of_month boolean[5] default '{true,true,true,true,true}' 
);
grant all on table clerical.sessions to staff;

comment on table clerical.sessions is 'list of all sessions currently running at a clinic';
comment on column clerical.sessions.of_month is 'which weeks of the month the session runs for fortnightly/monthly sessions';
comment on column clerical.sessions.weekday is 'must be compatible with postgres date functions, so 0=Sunday and 6=Saturday';

create table clerical.bookings (
      pk serial8 primary key, --- this might get BIG
      fk_patient integer references clerical.data_patients (pk),
      fk_staff integer not null references admin.staff (pk),
      "begin" timestamp,
      "duration" interval,
      notes text,
      deleted boolean not null default 'f'
);

comment on table clerical.bookings is 'list of all bookings past and future. Note fk_patient can be NULL for non-patien things: meetings, holidays etc';

grant all on table clerical.bookings to staff;

CREATE FUNCTION clerical.listsessions(timestamp, integer) RETURNS SETOF clerical.sessions AS $$
    select * from clerical.sessions where fk_clinic = $2 and weekday = extract(dow from $1)
           and of_month[((extract(day from $1)-1)/7)+1]
$$ LANGUAGE SQL;

comment on function clerical.listsessions is 'returns sessions for all doctors on a particular calendar day'; 

grant execute on function clerical.listsessions(timestamp,integer) to staff;

CREATE TABLE clerical.schedule (
	pk serial primary key,
	mbs_item text unique,
	ama_item text unique,
	descriptor text not null,
	ceased_date date,
        "group" text, 
        check ((not mbs_item is null) or (not ama_item is null))
);

comment on table clerical.schedule is 'the Schedule of Fees';
comment on column clerical.schedule.mbs_item is 'the item number in the Medicare Benefits Schedule, NULL only if only appears on AMA Schedule';
comment on column clerical.schedule.ama_item is 'the item number in the AMA version of the schedule, if used, otherwise NULL';

grant all on table clerical.schedule to staff;

create table clerical.lu_billing_type (
	"name" text not null unique,
	pk integer primary key
);

insert into clerical.lu_billing_type (pk,"name") values (1,'Standard');
insert into clerical.lu_billing_type (pk,"name") values (2,'DVA');
insert into clerical.lu_billing_type (pk,"name") values (3,'Schedule Fee');
insert into clerical.lu_billing_type (pk,"name") values (4,'AMA Fee');
insert into clerical.lu_billing_type (pk,"name") values (5,'Concession');
insert into clerical.lu_billing_type (pk,"name") values (6,'WorkCover');
insert into clerical.lu_billing_type (pk,"name") values (7,'TAC');
insert into clerical.lu_billing_type (pk,"name") values (8,'Medico-legal');

grant select on table clerical.lu_billing_type to staff;

create table clerical.prices (
	fk_schedule integer not null references clerical.schedule (pk),
	price money not null default '0.00',
	fk_lu_billing_type integer not null references clerical.lu_billing_type (pk),
        notes text
);


comment on column clerical.prices.price is 'the price to the patient';

grant select on table clerical.prices to staff;

create table clerical.invoices (
	pk serial primary key,
	fk_who_printed integer references admin.staff(pk),
	when_printed timestamp,
	notes text,
	fk_lu_billing_type integer not null references clerical.lu_billing_type (pk),
        fk_doctor_raising integer not null references admin.staff(pk),
	fk_patient integer not null references clerical.data_patients(pk),
        raised timestamp not null default now(),
	paid boolean not null default false
);

grant all on clerical.invoices to staff;

create table clerical.items_billed (
	pk serial8 primary key,
	fk_schedule integer not null references clerical.schedule (pk),
	patient_charge money not null,
	fk_invoice integer not null references clerical.invoices (pk)
);


create table clerical.payments_received (
	pk serial8 primary key,
	fk_invoice integer not null references clerical.invoices(pk),
	referent text,
	amount money not null,
	"when" timestamp not null default now()
);

grant all on clerical.payments_received to staff;

create function invoice_total(integer) returns money as  $$
    select sum(patient_charge) from clerical.items_billed where fk_invoice=$1; $$ 
language sql;

create function invoice_received(integer) returns money as $$
    select sum(amount) from clerical.payments_received where fk_invoice=$1;$$
language sql;

grant execute on function invoice_total(integer) to staff;
grant execute on function invoice_received(integer) to staff;

create view clerical.vwinvoices as 
	select pk as pk_invoice, 
	notes, 
	fk_lu_billing_type,
	fk_patient,
	when_printed,
	fk_who_printed,
	invoice_total(pk) as total,
	invoice_received(pk) as paid
from
	clerical.invoices;

grant select on clerical.vwinvoices to staff;
