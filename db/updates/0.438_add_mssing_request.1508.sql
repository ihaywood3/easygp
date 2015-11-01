INSERT INTO clin_requests.lu_requests(pk, fk_lu_request_type, item, fk_laterality,deleted)
  VALUES (1508, 1, 'Test Not Translated', null,True);

  update db.lu_version set lu_minor=438;
    