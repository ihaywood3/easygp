-- add some more routes of administration

-- oops, another sequence where I must have manually inserted data at some stage

Delete from common.lu_route_administration;

ALTER SEQUENCE "common"."lu_route_administration_pk_seq"
    INCREMENT 1  MINVALUE 1
    MAXVALUE 9223372036854775807  RESTART 1
    CACHE 1  NO CYCLE;

INSERT INTO common.lu_route_administration
           (abbreviation, route)
    VALUES ('imi', 'intramuscular');

INSERT INTO common.lu_route_administration
           (abbreviation, route)
    VALUES ('sc', 'subcutaneous');

INSERT INTO common.lu_route_administration
           (abbreviation, route)
    VALUES ('sc or imi', 'subcutaneous or intramuscular');

INSERT INTO common.lu_route_administration
           (abbreviation, route)
    VALUES ('', 'intradermal');

INSERT INTO common.lu_route_administration
           (abbreviation, route)
    VALUES ('', 'oral');

INSERT INTO common.lu_route_administration
           (abbreviation, route)
    VALUES ('', 'intranasal');

INSERT INTO common.lu_route_administration
           (abbreviation, route)
    VALUES ('', 'inhaled');
INSERT INTO common.lu_route_administration
           (abbreviation, route)
    VALUES ('', 'topical');


INSERT INTO common.lu_route_administration
           (abbreviation, route)
    VALUES ('', 'intrathecal');

INSERT INTO common.lu_route_administration
           (abbreviation, route)
    VALUES ('', 'sublinqual');

INSERT INTO common.lu_route_administration
           (abbreviation, route)
    VALUES ('ivi', 'intravenous');

INSERT INTO common.lu_route_administration
           (abbreviation, route)
    VALUES ('', 'intraarterial');

INSERT INTO common.lu_route_administration
           (abbreviation, route)
    VALUES ('', 'intracardiac');

INSERT INTO common.lu_route_administration
           (abbreviation, route)
    VALUES ('', 'intraosseous');

INSERT INTO common.lu_route_administration
           (abbreviation, route)
    VALUES ('', 'intraperitoneal');


INSERT INTO common.lu_route_administration
           (abbreviation, route)
    VALUES ('', 'intravesical');

INSERT INTO common.lu_route_administration
           (abbreviation, route)
    VALUES ('', 'intravitreal');

INSERT INTO common.lu_route_administration
           (abbreviation, route)
    VALUES ('', 'intrauterine');

INSERT INTO common.lu_route_administration
           (abbreviation, route)
    VALUES ('', 'intrauterine');


INSERT INTO common.lu_route_administration
           (abbreviation, route)
    VALUES ('', 'intracavernous');


INSERT INTO common.lu_route_administration
           (abbreviation, route)
    VALUES ('', 'intravaginal');

INSERT INTO common.lu_route_administration
           (abbreviation, route)
    VALUES ('', 'extra-amniotic');

INSERT INTO common.lu_route_administration
           (abbreviation, route)
    VALUES ('', 'topical');


INSERT INTO common.lu_route_administration
           (abbreviation, route)
    VALUES ('', 'epidural');

INSERT INTO common.lu_route_administration
           (abbreviation, route)
    VALUES ('', 'intracerebral');

INSERT INTO common.lu_route_administration
           (abbreviation, route)
    VALUES ('', 'intracerebroventricular');

INSERT INTO common.lu_route_administration
           (abbreviation, route)
    VALUES ('', 'rectal');




truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 87);

