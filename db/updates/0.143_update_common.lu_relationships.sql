-- Redoing this table to make programming easier in FFamilyHistory
-- E.g must not allow entry of a name when the relationship is 'General Family History'

Delete from common.lu_family_relationships;

ALTER SEQUENCE "common"."lu_family_relationships_pk_seq"
    INCREMENT 1  MINVALUE 1
    MAXVALUE 9223372036854775807  RESTART 1
    CACHE 1  NO CYCLE;

-- these can only be one person and can be named in FFamilyHistory
-- can only allow one of this type of relationship

Insert into common.lu_family_relationships (relationship) values ('Mother');
Insert into common.lu_family_relationships (relations-- These can never be named in FFamilyHistory and can have only 1 entry
Insert into common.lu_family_relationships (relationship) values ('General Family History');
Insert into common.lu_family_relationships (relationship) values ('General History - paternal');
Insert into common.lu_family_relationships (relationship) values ('General History - maternal');hip) values ('Father');
Insert into common.lu_family_relationships (relationship) values ('Grandmother - maternal');
Insert into common.lu_family_relationships (relationship) values ('Grandmother - paternal');
Insert into common.lu_family_relationships (relationship) values ('Grandfather - maternal');
Insert into common.lu_family_relationships (relationship) values ('Grandfather - paternal');
Insert into common.lu_family_relationships (relationship) values ('Great grandmother paternal');
Insert into common.lu_family_relationships (relationship) values ('Great grandmother maternal');
Insert into common.lu_family_relationships (relationship) values ('Great grandfather maternal');
Insert into common.lu_family_relationships (relationship) values ('Great grandfather paternal');

-- These can never be named in FFamilyHistory and can have only 1 entry
Insert into common.lu_family_relationships (relationship) values ('General Family History');
Insert into common.lu_family_relationships (relationship) values ('General History - paternal');
Insert into common.lu_family_relationships (relationship) values ('General History - maternal');

-- these can be more than  person - can be named FFamilyHistory
-- can allow more than one of this type of relationship

Insert into common.lu_family_relationships (relationship) values ('Wife');
Insert into common.lu_family_relationships (relationship) values ('Husband');
Insert into common.lu_family_relationships (relationship) values ('Defacto wife');
Insert into common.lu_family_relationships (relationship) values ('Defacto husband');
Insert into common.lu_family_relationships (relationship) values ('Uncle - maternal');
Insert into common.lu_family_relationships (relationship) values ('Uncle - paternal');
Insert into common.lu_family_relationships (relationship) values ('Aunt - maternal');
Insert into common.lu_family_relationships (relationship) values ('Aunt - paternal');
Insert into common.lu_family_relationships (relationship) values ('Cousin maternal');
Insert into common.lu_family_relationships (relationship) values ('Cousin paternal');
Insert into common.lu_family_relationships (relationship) values ('Nephew - maternal');
Insert into common.lu_family_relationships (relationship) values ('Nephew - paternal');
Insert into common.lu_family_relationships (relationship) values ('Niece - paternal');
Insert into common.lu_family_relationships (relationship) values ('Niece - maternal');
Insert into common.lu_family_relationships (relationship) values ('Son');
Insert into common.lu_family_relationships (relationship) values ('Step son');
Insert into common.lu_family_relationships (relationship) values ('Daughter');
Insert into common.lu_family_relationships (relationship) values ('Step daughter');
Insert into common.lu_family_relationships (relationship) values ('Step mother');
Insert into common.lu_family_relationships (relationship) values ('Step father');
Insert into common.lu_family_relationships (relationship) values ('Uncle - side of family unknown');
Insert into common.lu_family_relationships (relationship) values ('Aunt - side of family unknown');
Insert into common.lu_family_relationships (relationship) values ('Cousin side of family unknown');
Insert into common.lu_family_relationships (relationship) values ('Nephew - side of family unknown');
Insert into common.lu_family_relationships (relationship) values ('Grandmother side of family unknown');
Insert into common.lu_family_relationships (relationship) values ('Grandfather side of family unknown');
Insert into common.lu_family_relationships (relationship) values ('Grandaughter side of family unknown');
Insert into common.lu_family_relationships (relationship) values ('Grandson side of family unknown');
Insert into common.lu_family_relationships (relationship) values ('Adopted son');
Insert into common.lu_family_relationships (relationship) values ('Adopted daughter');

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 143);
;

