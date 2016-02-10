INSERT INTO clerical.lu_private_health_funds
(fund, name_abbrev, availability, states_available)
    VALUES 
    ('RTHealth',
     'RTH', 
     'Restricted', 
     'ACT, NSW, QLD, SA, TAS, VIC, WA, NT')
     ;

update db.lu_version set lu_minor = 487;
