create table clerical.sessions (
    pk serial primary key,
    fk_staff integer not null references admin.staff (pk),
    fk_clinic integer not null references admin.clinics (pk),
    "begin" time,
    "finish" time,
    weekday smallint, 
    of_month boolean[5] default '{true,true,true,true,true}' 
);


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
      booked_by integer not null references admin.staff (pk),
      booked_at timestamp not null default now ()
);

comment on table clerical.bookings is 'list of all bookings past and future. Note fk_patient can be NULL for non-patien things: meetings, holidays etc';


CREATE FUNCTION clerical.listsessions(timestamp, integer) RETURNS SETOF clerical.sessions AS $$
    select * from clerical.sessions where fk_clinic = $2 and weekday = extract(dow from $1)
           and of_month[((extract(day from $1)-1)/7)+1]
$$ LANGUAGE SQL;

comment on function clerical.listsessions is 'returns sessions for all doctors on a particular calendar day'; 

CREATE TABLE clerical.schedule (
	pk serial primary key,
	mbs_item text,
	ama_item text,
	descriptor text not null,
	ceased_date date,
	summary text
);

comment on table clerical.schedule is 'the Schedule of Fees';
comment on column clerical.schedule.mbs_item is 'the item number in the Medicare Benefits Schedule, NULL if only an AMA item';
comment on column clerical.schedule.ama_item is 'the item number in the AMA version of the schedule, if used';

create table clerical.lu_billing_type (
	"name" text not null unique,
	pk serial primary key,
);

insert into clerical.modes ("name") values ('Standard');
insert into clerical.modes ("name") values ('DVA');
insert into clerical.modes ("name") values ('Concession');
insert into clerical.modes ("name") values ('WorkCover');
insert into clerical.modes ("name") values ('TAC');
insert into clerical.modes ("name") values ('Medico-legal');


create table clerical.prices (
	fk_schedule integer not null references clerical.schedule (pk),
	price money not null default 0,
	rebate money not null default 0,
	fk_billing_type integer not null references clerical.lu_billing_type (pk)
);


comment on column clerical.prices.price is 'the price to the patient';
comment on column clerical.prices.rebate is 'the amount sought from third-party payor';


create table clerical.invoices (
	pk serial primary key,
	fk_who_printed integer references admin.staff(pk),
	when_printed datetime,
	notes text,
	fk_billing_type integer not null references clerical.lu_billing_type (pk),
	fk_patient integer not null references clerical.data_patients(pk),
	paid boolean not null default false
);

create table clerical.items_billed (
	pk serial8 primary key,
	fk_schedule integer not null references clerical.schedule (pk),
	raised datetime not null default now(),
	patient_charge money not null,
	rebate_charge money not null default 0,
	fk_invoice integer references clerical.invoices (pk)
);


create table clerical.payments_received (
	pk serial8 primary key,
	fk_invoice integer references clerical.invoices(pk),
	referent text,
	amount money,
	"when" datetime
);


create view clerical.vwinvoices_owing as
        select sum(ib.patient_charge) as amount, ib.fk_invoice as fk_invoice from clerical.item_billed ib group by ib.fk_invoice;

create view clerical.vwinvoices_recieved as  
	select sum(amount) as amount, p.fk_invoice as fk_invoice from clerical.payments_received p group by p.fk_invoice;

create view clerical.vwinvoices as 
	select i.pk as pk_invoice, 
	i.notes as notes, 
	i.fk_billing_type as fk_billing_type,
	i.fk_patient as fk_patient,
	i.when_printed as when_printed,
	i.fk_who_printed as fk_who_printed,
	o.amount as total,
	r.amount as paid
from
	clerical.invoices i,
	clerical.wvinvoices_owing o,
	clerical.wvinvoices_received r
when
	o.fk_invoice = i.pk and
	r.fk_invoice = i.pk;
