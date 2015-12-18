update documents.sending_entities set fk_person = null where fk_person = 0;
update documents.sending_entities  set fk_branch = null where fk_branch = 0;
update documents.sending_entities  set fk_employee = null where fk_employee = 0;
update documents.sending_entities  set fk_lu_request_type = null where fk_lu_request_type = 0;

COMMENT ON COLUMN documents.sending_entities.fk_lu_request_type IS 'The type of provider eg pathology provider, radiology provider however this may often be null';


update db.lu_version set lu_minor = 457;