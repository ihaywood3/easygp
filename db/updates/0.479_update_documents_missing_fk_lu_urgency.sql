update documents.documents set fk_lu_urgency = 1 where fk_lu_urgency is null;

update db.lu_version set lu_minor = 479;
