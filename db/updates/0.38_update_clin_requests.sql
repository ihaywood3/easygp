-- it became evident that one could 'slip up in allocating request synonyms, so I've added a deleted field
-- and will later write a module to allow maintenance of these synonyms

Alter table clin_requests.lu_link_provider_user_requests add column deleted boolean default false;

GRANT SELECT, INSERT ON TABLE clin_requests.lu_link_provider_user_requests TO staff;

--re-create the view:

DROP VIEW clin_requests.vwrequestsynonyms;

CREATE OR REPLACE VIEW clin_requests.vwrequestsynonyms AS 
 SELECT lu_link_provider_user_requests.pk AS pk_lu_link_provider_user_requests, lu_link_provider_user_requests.provider_request_name, 
 lu_link_provider_user_requests.lateralisation, lu_link_provider_user_requests.deleted,
 lu_requests.pk AS fk_lu_request, 
 lu_requests.item AS user_request_name
   FROM clin_requests.lu_requests, clin_requests.lu_link_provider_user_requests
  WHERE lu_link_provider_user_requests.fk_lu_request = lu_requests.pk;

GRANT ALL ON TABLE clin_requests.vwrequestsynonyms TO staff;


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 38);
