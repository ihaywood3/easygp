CREATE INDEX "date_created_idx" ON "documents"."documents"
USING btree ("date_created");

CREATE INDEX "documents_deleted_idx" ON "documents"."documents"
USING btree ("deleted");

CREATE INDEX "sending_entity_idx" ON "documents"."documents"
  USING btree ("fk_sending_entity");
  
  
CREATE INDEX "sending_entity_idx" ON "documents"."documents"
  USING btree ("fk_sending_entity");

  CREATE INDEX "staff_destination_idx" ON "documents"."documents"
  USING btree ("fk_staff_destination");
  
  CREATE INDEX "tag_idx" ON "documents"."documents"
  USING btree ("tag");