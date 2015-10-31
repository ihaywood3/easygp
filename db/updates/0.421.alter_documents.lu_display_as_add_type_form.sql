-- new type of display_as to get forms out of letters
-- think the sequence is out of kilter
ALTER SEQUENCE documents.lu_display_as_pk_seq RESTART WITH 8;
insert into documents.lu_display_as (display_as) values ( 'form');

  update db.lu_version set lu_minor=421;


