alter table billing.fee_schedule add column number_of_patients integer default 1;

COMMENT ON COLUMN billing.fee_schedule.number_of_patients IS 'the number of patients to which this item applies, usually 1, but e.g nursing homes or group therapy sessions can be up to 7';

drop view billing.vwfees;

CREATE VIEW billing.vwfees AS
    SELECT prices.pk AS pk_view, fee_schedule.mbs_item, fee_schedule.user_item, fee_schedule.ama_item, fee_schedule.descriptor, fee_schedule.descriptor_brief, fee_schedule.gst_rate, fee_schedule.percentage_fee_rule, fee_schedule.ceased_date, fee_schedule."group", fee_schedule.derived_fee, fee_schedule.number_of_patients, prices.fk_fee_schedule, prices.pk AS fk_price, prices.price, prices.fk_lu_billing_type, prices.notes, lu_billing_type.type AS fee_type FROM ((billing.fee_schedule JOIN billing.prices ON ((fee_schedule.pk = prices.fk_fee_schedule))) JOIN billing.lu_billing_type ON ((prices.fk_lu_billing_type = lu_billing_type.pk)));

alter view billing.vwfees owner to easygp;
grant select on billing.vwfees to staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 242);
