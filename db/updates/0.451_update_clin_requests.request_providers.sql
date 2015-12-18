update clin_requests.request_providers set fk_person = null where fk_person = 0;
update clin_requests.request_providers  set fk_headoffice_branch  = null where fk_headoffice_branch = 0;
update clin_requests.request_providers  set fk_employee = null where fk_employee = 0;
update clin_requests.request_providers  set fk_default_branch = null where fk_default_branch = 0;

update db.lu_version set lu_minor = 451;
