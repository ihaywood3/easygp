-- historically this field present, but ?not used at this point
-- meant to link a document back to a request automatically, was not yet implemented
update documents.documents set fk_request = null;
update db.lu_version set lu_minor = 459;
