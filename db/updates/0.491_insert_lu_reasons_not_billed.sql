ALTER SEQUENCE billing.lu_reasons_not_billed_pk_seq RESTART WITH 1;

insert into billing.lu_reasons_not_billed (reason) values ('duplicate appointment');
insert into billing.lu_reasons_not_billed (reason) values ('patient DNA');
insert into billing.lu_reasons_not_billed (reason) values ('no charge - after care');
insert into billing.lu_reasons_not_billed (reason) values ('no charge - doctors choice unspecified');
insert into billing.lu_reasons_not_billed (reason) values ('no charge - patient walked from consult');
insert into billing.lu_reasons_not_billed (reason) values ('no charge - family member interview');
insert into billing.lu_reasons_not_billed (reason) values ('no charge - traveller no insurance');


update db.lu_version set lu_minor = 491;

