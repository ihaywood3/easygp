update documents.documents set fk_patient = null where fk_patient=0;

update db.lu_version set lu_minor = 456;