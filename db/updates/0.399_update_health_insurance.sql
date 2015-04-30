-- add a new health insurance company

Insert into clerical.lu_private_health_funds(fund,name_abbrev, availability, states_available) values('Uni Health Insurance','Uni Health','Closed','ACT, NSW, QLD, SA, TAS, VIC, WA, NT');

update db.lu_version set lu_minor=399;
