alter table clerical.schedule add column descriptor_brief text default null;
alter table clerical.schedule add column gst_rate integer default 0;
alter table clerical.schedule add column percentage_fee_rule boolean default false;

comment on column clerical.schedule.descriptor_brief is 'a brief description of a long descriptor';
comment on column clerical.schedule.gst_rate is 'the goods and services tax rate';
comment on column clerical.schedule.ypercentage_fee_rule is 'if true then percentage rules apply for the fee
 for example ist excision paid at 100%, second on same occasion at 50% etc';

-- some additional types for billing

insert into clerical.lu_billing_type (name,pk) values ('Rebate 75',9);
insert into clerical.lu_billing_type (name, pk) values ('Rebate 85',10);
insert into clerical.lu_billing_type (name, pk) values ('DVA LMO',11);
insert into clerical.lu_billing_type (name, pk) values ('AMA',12);
insert into clerical.lu_billing_type (name, pk) values ('Health Care Card',13);
insert into clerical.lu_billing_type (name, pk) values ('Pensioner',14);

drop view clerical.vwfees;

CREATE OR REPLACE VIEW clerical.vwfees AS 
 SELECT schedule.pk, schedule.mbs_item, schedule.ama_item, schedule.descriptor,
 schedule.descriptor_brief, schedule.gst_rate, schedule.percentage_fee_rule,
 schedule.ceased_date, schedule."group", schedule.derived_fee,
 prices.fk_schedule, prices.price, prices.fk_lu_billing_type, prices.notes, lu_billing_type.name
   FROM clerical.schedule
   JOIN clerical.prices ON schedule.pk = prices.fk_schedule
   JOIN clerical.lu_billing_type ON prices.fk_lu_billing_type = lu_billing_type.pk;

ALTER TABLE clerical.vwfees OWNER TO easygp;
GRANT ALL ON TABLE clerical.vwfees TO easygp;
GRANT SELECT ON TABLE clerical.vwfees TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 145);

