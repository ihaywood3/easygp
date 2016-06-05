-- new reason codes for failed itmes billed, to be used in the invoice GUI

insert into billing.lu_codes (code, description) values (4020, 'Insurance refuses payment');
insert into billing.lu_codes (code, description) values (4021, 'Patient refuses payment');

update db.lu_version set lu_minor = 510;

