create or replace function db.do_all_tables(cmd text,regex text,classes text) returns void as $func$
  DECLARE
    line text;
  BEGIN
    FOR line IN select nspname || '.' || relname from pg_class, pg_namespace where relnamespace = pg_namespace.oid and (not relname ilike 'pg_%') and nspname<>'information_schema' and nspname || '.' || relname ~ regex and position(relkind in classes) > 0 LOOP
      EXECUTE replace(cmd,'&',line);
    END LOOP;
  END;
$func$ language plpgsql;
truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 249);
