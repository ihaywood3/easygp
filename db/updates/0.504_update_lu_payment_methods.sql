update billing.lu_payment_method set method = 'CASH' where pk=1;
update billing.lu_payment_method set method = 'CHEQUE' where pk=3;
update billing.lu_payment_method set method = 'MEDICARE' where pk=5;

update db.lu_version set lu_minor = 504;