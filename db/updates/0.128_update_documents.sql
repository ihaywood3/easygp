-- maybe temporary, the document finding query became dead slow and I've not time to figure out why
-- this has fixed it

CREATE INDEX "date_created_not_deleted_index" ON "documents"."documents"
  USING btree ("deleted", "date_created");
truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 128)
