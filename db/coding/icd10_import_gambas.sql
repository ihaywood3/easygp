-- this is a script to set up ICD-10 codes in the EasyGP database


CREATE TABLE coding.icd10
(
  code text, -- the complete icd10 code without dots
  term text, -- the icd10 term eg angina max lengh 99 characters
  stem text, -- the initial three characters of code to link to chapter
  chapter text, -- the chapter number 1-21
  len_code text,
  len_term text
)
WITH (
  OIDS=FALSE
);

grant select on coding.icd10 to staff;

COMMENT ON TABLE coding.icd10 IS 'icd10 codes version 2007 WHO';
COMMENT ON COLUMN coding.icd10.code IS 'the complete icd10 code without dots';
COMMENT ON COLUMN coding.icd10.term IS ' the icd10 term eg angina max lengh 99 characters';
COMMENT ON COLUMN coding.icd10.stem IS 'the initial three characters of code to link to chapter';
COMMENT ON COLUMN coding.icd10.chapter IS 'the chapter number 1-21';


CREATE TABLE coding.icd10_chapters
(
  chapter text,
  range text, -- range of codes within a chapter
  description text, -- a description of the chapter
  lower_limit text, -- lower limit range extracted from range
  upper_limit text -- upper limit range extracted from range
)
WITH (
  OIDS=FALSE
);

grant select on coding.icd10_chapters to staff;

COMMENT ON TABLE coding.icd10_chapters IS 'icd10 chapter - the broad classification';
COMMENT ON COLUMN coding.icd10_chapters.range IS 'range of codes within a chapter';
COMMENT ON COLUMN coding.icd10_chapters.description IS 'a description of the chapter';
COMMENT ON COLUMN coding.icd10_chapters.lower_limit IS 'lower limit range extracted from range';
COMMENT ON COLUMN coding.icd10_chapters.upper_limit IS 'upper limit range extracted from range';

CREATE TABLE coding.icd10_subchapters
(
  subchapter_range text,
  subschapter_description text
)
WITH (
  OIDS=FALSE
);
COMMENT ON TABLE coding.icd10_subchapters IS 'subchapters of ICD10';

grant select on coding.icd10_subchapters to staff;
\cd coding
\copy coding.icd10 from 'icd10.txt'  delimiter '|' NULL AS ''
\copy coding.icd10_chapters from 'icd10_chapters.txt'  delimiter '|' NULL AS ''
\copy coding.icd10_subchapters from 'icd10_subchapters.txt'  delimiter '|' NULL AS ''
\cd ..
update coding.lu_systems set preferred='f';
update coding.lu_systems set preferred='t' where pk=2;

insert into coding.generic_terms (code,               body_system,         code_role,term,fk_coding_system,active,icd10) select
                                  code,upper(substring(code from 1 for 1)),    2,    term,       2        ,  't' ,code
          from coding.icd10;
   
