-- Something went awry in a previous drug update, the generic text went missing for sevikar HCT

update drugs.product set generic = 'olmesartan;amlodipine;hydrochlorothiazide' where pk = '0dacf19c-8d28-4879-b9dc-029e543bac30';
update db.lu_version set lu_minor = 535;
