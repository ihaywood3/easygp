-- Ian has added a versioning table for drugs with some weird constraint magic
-- he picked up off the Internet that makes it only ever have one row.

create table drugs.version (
	release_date date default now() not null,
 	"author" text not null,
	 "comment" text
	);

create unique index version_one_row_only on drugs.version ((release_date is not null));

CREATE FUNCTION drugs.version_no_delete ()
RETURNS trigger
LANGUAGE plpgsql AS $f$
BEGIN
   RAISE EXCEPTION 'You may not delete the DB version!';
END; $f$;

CREATE TRIGGER version_no_delete
BEFORE DELETE ON drugs.version
FOR EACH ROW EXECUTE PROCEDURE drugs.version_no_delete();


insert into drugs.version (release_date,"author","comment") values
('2013-4-1','Ian Haywood','Ian''s original April PBS update');

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 305);

