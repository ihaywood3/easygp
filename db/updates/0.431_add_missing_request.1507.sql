INSERT INTO clin_requests.lu_requests(
            pk, fk_lu_request_type, item, fk_laterality, fk_decision_support, 
            fk_instruction, deleted)
    VALUES (1507, 1, 'Test Not Translated', null,null,null ,True);
    
    update db.lu_version set lu_minor=431;
    