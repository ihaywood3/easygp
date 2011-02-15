--fixes a long standing error in this view
--lateralisation now displays correctly and in order of left,right,both

drop view clin_requests.vwRequestNames;
create or replace view clin_requests.vwrequestnames  as

    (   SELECT lu_request_items.pk || '-1'::text AS pk_view, lu_request_items.pk AS fk_lu_request, lu_request_type.type, 
       lu_request_items.fk_lu_request_type, lu_request_items.deleted, 
                                CASE
                                    WHEN lu_request_items.fk_laterality = 3 THEN lu_request_items.item || ' (LEFT)'::text
                                    ELSE NULL::text
                                END AS item, 1 as fk_laterality , lu_request_items.fk_decision_support, lu_request_items.fk_instruction, lu_instructions.instruction
                           FROM clin_requests.lu_requests lu_request_items
                      JOIN clin_requests.lu_request_type ON lu_request_items.fk_lu_request_type = lu_request_type.pk
                 LEFT JOIN clin_requests.lu_instructions ON lu_request_items.fk_instruction = lu_instructions.pk
                WHERE lower(lu_request_items.item) ~~ '%'::text AND lu_request_items.fk_laterality = 3

                union 


                                        SELECT lu_request_items.pk || '-2'::text AS pk_view, lu_request_items.pk AS fk_lu_request, lu_request_type.type, lu_request_items.fk_lu_request_type, lu_request_items.deleted, 
                                CASE
                                    WHEN lu_request_items.fk_laterality = 3 THEN lu_request_items.item || ' (RIGHT)'::text
                                    ELSE NULL::text
                                END AS item, 2 as fk_laterality , lu_request_items.fk_decision_support, lu_request_items.fk_instruction, lu_instructions.instruction
                           FROM clin_requests.lu_requests lu_request_items
                      JOIN clin_requests.lu_request_type ON lu_request_items.fk_lu_request_type = lu_request_type.pk
                 LEFT JOIN clin_requests.lu_instructions ON lu_request_items.fk_instruction = lu_instructions.pk
                WHERE lower(lu_request_items.item) ~~ '%'::text AND lu_request_items.fk_laterality = 3 
                union 
                
              SELECT lu_request_items.pk || '-3'::text AS pk_view, lu_request_items.pk AS fk_lu_request, lu_request_type.type, lu_request_items.fk_lu_request_type, lu_request_items.deleted, 
                        CASE
                            WHEN lu_request_items.fk_laterality = 3 THEN lu_request_items.item || ' (BOTH)'::text
                            ELSE NULL::text
                        END AS item, 3 as fk_laterality, lu_request_items.fk_decision_support, lu_request_items.fk_instruction, lu_instructions.instruction
                   FROM clin_requests.lu_requests lu_request_items
              JOIN clin_requests.lu_request_type ON lu_request_items.fk_lu_request_type = lu_request_type.pk
         LEFT JOIN clin_requests.lu_instructions ON lu_request_items.fk_instruction = lu_instructions.pk
        WHERE lower(lu_request_items.item) ~~ '%'::text AND lu_request_items.fk_laterality = 3

union
         SELECT lu_request_items.pk || '-0'::text AS pk_view, lu_request_items.pk AS fk_lu_request, lu_request_type.type, lu_request_items.fk_lu_request_type, lu_request_items.deleted, lu_request_items.item, lu_request_items.fk_laterality, lu_request_items.fk_decision_support, lu_request_items.fk_instruction, lu_instructions.instruction
           FROM clin_requests.lu_requests lu_request_items
      JOIN clin_requests.lu_request_type ON lu_request_items.fk_lu_request_type = lu_request_type.pk
   LEFT JOIN clin_requests.lu_instructions ON lu_request_items.fk_instruction = lu_instructions.pk
  WHERE lower(lu_request_items.item) ~~ '%'::text AND lu_request_items.fk_laterality = 0

        )

                order by fk_lu_request, fk_laterality;

               
 ALTER TABLE clin_requests.vwrequestnames OWNER TO easygp;;
GRANT ALL ON TABLE clin_requests.vwrequestnames TO easygp;
GRANT ALL ON TABLE clin_requests.vwrequestnames TO staff;
COMMENT ON VIEW clin_requests.vwrequestnames IS 'a view of everything which is orderable, including lateralisation eg Xray wrist (LEFT), Xray wrist (RIGHT) or Xray Wrist (BOTH)';

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 72)
