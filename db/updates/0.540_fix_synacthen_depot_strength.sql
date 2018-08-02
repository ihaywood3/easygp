-- drug database error
update drugs.product set strength ='1mg/ml' where pk = 'ee790301-f0e5-4c3b-baee-34c332e35d8c' -- fix synacthen depot, was wrong strength (5mg/ml, should be 1mg/ml)
update db.lu_version set lu_minor=540;