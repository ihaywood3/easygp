-- adds veterans (implied EFT) to the payment methods

insert into billing.lu_payment_method (pk,method) values (6,'VETERANS');

update db.lu_version set lu_minor = 505;