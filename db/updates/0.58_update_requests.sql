-- Oops, added the deleted flag to requests (ie the marked deleted flag)

DROP VIEW clin_requests.vwrequestnames;

CREATE OR REPLACE VIEW clin_requests.vwrequestnames AS 
        (        (         SELECT lu_request_items.pk || '-1'::text AS pk_view, lu_request_items.pk AS fk_lu_request, lu_request_type.type, 
        lu_request_items.fk_lu_request_type, lu_request_items.deleted,
                                CASE
                                    WHEN lu_request_items.fk_laterality = 3 THEN lu_request_items.item || ' (LEFT)'::text
                                    ELSE NULL::text
                                END AS item, lu_request_items.fk_laterality, lu_request_items.fk_decision_support, lu_request_items.fk_instruction, lu_instructions.instruction
                           FROM clin_requests.lu_requests lu_request_items
                      JOIN clin_requests.lu_request_type ON lu_request_items.fk_lu_request_type = lu_request_type.pk
                 LEFT JOIN clin_requests.lu_instructions ON lu_request_items.fk_instruction = lu_instructions.pk
                WHERE lower(lu_request_items.item) ~~ '%'::text AND lu_request_items.fk_laterality = 3
                UNION 
                         SELECT lu_request_items.pk || '-2'::text AS pk_view, lu_request_items.pk AS fk_lu_request, lu_request_type.type, lu_request_items.fk_lu_request_type, 
                         lu_request_items.deleted,
                                CASE
                                    WHEN lu_request_items.fk_laterality = 3 THEN lu_request_items.item || ' (RIGHT)'::text
                                    ELSE NULL::text
                                END AS item, lu_request_items.fk_laterality, lu_request_items.fk_decision_support, lu_request_items.fk_instruction, lu_instructions.instruction
                           FROM clin_requests.lu_requests lu_request_items
                      JOIN clin_requests.lu_request_type ON lu_request_items.fk_lu_request_type = lu_request_type.pk
                 LEFT JOIN clin_requests.lu_instructions ON lu_request_items.fk_instruction = lu_instructions.pk
                WHERE lower(lu_request_items.item) ~~ '%'::text AND lu_request_items.fk_laterality = 3)
        UNION 
                 SELECT lu_request_items.pk || '-3'::text AS pk_view, lu_request_items.pk AS fk_lu_request, lu_request_type.type, lu_request_items.fk_lu_request_type, 
                 lu_request_items.deleted,
                        CASE
                            WHEN lu_request_items.fk_laterality = 3 THEN lu_request_items.item || ' (BOTH)'::text
                            ELSE NULL::text
                        END AS item, lu_request_items.fk_laterality, lu_request_items.fk_decision_support, lu_request_items.fk_instruction, lu_instructions.instruction
                   FROM clin_requests.lu_requests lu_request_items
              JOIN clin_requests.lu_request_type ON lu_request_items.fk_lu_request_type = lu_request_type.pk
         LEFT JOIN clin_requests.lu_instructions ON lu_request_items.fk_instruction = lu_instructions.pk
        WHERE lower(lu_request_items.item) ~~ '%'::text AND lu_request_items.fk_laterality = 3)
UNION 
         SELECT lu_request_items.pk || '-0'::text AS pk_view, lu_request_items.pk AS fk_lu_request, lu_request_type.type, lu_request_items.fk_lu_request_type, 
         lu_request_items.deleted,
         lu_request_items.item, lu_request_items.fk_laterality, lu_request_items.fk_decision_support, lu_request_items.fk_instruction, lu_instructions.instruction
           FROM clin_requests.lu_requests lu_request_items
      JOIN clin_requests.lu_request_type ON lu_request_items.fk_lu_request_type = lu_request_type.pk
   LEFT JOIN clin_requests.lu_instructions ON lu_request_items.fk_instruction = lu_instructions.pk
  WHERE lower(lu_request_items.item) ~~ '%'::text AND lu_request_items.fk_laterality = 0
  ORDER BY 4, 5;

ALTER TABLE clin_requests.vwrequestnames OWNER TO easygp;;
GRANT ALL ON TABLE clin_requests.vwrequestnames TO easygp;
GRANT ALL ON TABLE clin_requests.vwrequestnames TO staff;
COMMENT ON VIEW clin_requests.vwrequestnames IS 'a view of everything which is orderable, including lateralisation eg Xray wrist (LEFT), Xray wrist (RIGHT) or Xray Wrist (BOTH)';

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 58)