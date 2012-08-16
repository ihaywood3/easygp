

CREATE TABLE coding.icpc2_chapters (
    chapter character(1) NOT NULL,
    name text NOT NULL
);

grant select on coding.icpc2_chapters to staff;

COMMENT ON TABLE coding.icpc2_chapters IS 'Chapters are based on body systems, with additional chapters for psychological and social
problems.
A General              L Musculoskeletal                   U Urinary
B Blood, blood-forming N Neurological                      W Pregnancy, family planning
D Digestive            P Psychological                     X Female genital
F Eye                  R Respiratory                       Y Male genital
H Ear                  S Skin                              Z Social
K Circulatory          T Metabolic, endocrine, nutritional
File: ICPC2CH.CSV sample line: A|General & Unspecified';

COMMENT ON COLUMN coding.icpc2_chapters.chapter IS 'Single alphabetic character of chapter as defined by ICPC-2.';
COMMENT ON COLUMN coding.icpc2_chapters.name IS 'Labelor name for ICPC-2 chapter code.';

CREATE TABLE coding.icpc2_codes (
    icpc_code character(3) NOT NULL,
    rubric text NOT NULL,
    component character(2),
    chapter character(1),
    note character(5),
    icd10 character(15)
);

grant select on coding.icpc2_codes to staff;

COMMENT ON TABLE coding.icpc2_codes IS 'This table summarises each ICPC-2 code (or rubric).
 It states the alpha-numeric code and its rubric,
 along with the chapter and component 
 each ICPC-2 code belongs to.
 File ICPC2COD: sample line:A01|PAIN GENERAL/MULTIPLE SITES|1|A||';
COMMENT ON COLUMN coding.icpc2_codes.icpc_code IS 'The 3 digit alpha-numeric ICPC-2 code.';
COMMENT ON COLUMN coding.icpc2_codes.rubric IS 'Label of the ICPC-2 code.';
COMMENT ON COLUMN coding.icpc2_codes.component IS 'Label for ICPC-2 component code.';
COMMENT ON COLUMN coding.icpc2_codes.chapter IS 'Single alphabetic character of chapter as defined by ICPC-2.';
COMMENT ON COLUMN coding.icpc2_codes.note IS 'Currently not used and is blank.';
COMMENT ON COLUMN coding.icpc2_codes.icd10 IS 'ICPC-2 to ICD10 map. Currently not used and is blank.';

CREATE TABLE coding.icpc2_components (
    component character(2) NOT NULL,
    name text NOT NULL
);

grant select on coding.icpc2_components to staff;

COMMENT ON TABLE coding.icpc2_components IS '1. Symptoms, complaints
2. Diagnostic, screening, prevention
3. Treatment, procedures, medication
4. Test results
5. Administrative
6. Other
7. Diagnoses, disease
i.e columns component,name';

COMMENT ON COLUMN coding.icpc2_components.component IS 'Numeric code of components as defined by ICPC-2 (1-7) and extended by FMRC so that chapter 7 is further defined as components 8 to 12.';
COMMENT ON COLUMN coding.icpc2_components.name IS 'Label for ICPC-2 component code.';

CREATE TABLE coding.icpc2_grp_grouper (
    "Grouper_id" integer,
    grouper character(3),
    grouper_description text
);

grant select on coding.icpc2_grp_grouper to staff;

COMMENT ON TABLE coding.icpc2_grp_grouper IS '
contains codes which can group icpc terms e.g
• G40 Diabetes (all)
• G77 Diabetes (non-gestational)
• T89 IDDM
• T90 NIDDM
if you wanted to pull out all diabetes';
COMMENT ON COLUMN coding.icpc2_grp_grouper.grouper IS 'group code to encompass groups of
 icpc2_terms<>icpc_code 
  e.g G40|DIABETES (ALL)';
COMMENT ON COLUMN coding.icpc2_grp_grouper.grouper_description IS 'an accompanying description
 e.g DIABETES (ALL)';


CREATE TABLE coding.icpc2_grp_grp_icpc (
    grouper_id integer,
    icpc_code character(6)
);
grant select on coding.icpc2_grp_grp_icpc to staff;

COMMENT ON COLUMN coding.icpc2_grp_grp_icpc.icpc_code IS 'The 3 digit alpha-numeric ICPC-2 code.';

CREATE TABLE coding.icpc2_grp_keyword (
    keyword_id integer,
    keyword text
);
grant select on coding.icpc2_grp_keyword to staff;

CREATE TABLE coding.icpc2_grp_keyword_grp (
    keyword_id integer,
    grouper_id integer
);

grant select on coding.icpc2_grp_keyword_grp to staff;

COMMENT ON TABLE coding.icpc2_grp_keyword_grp IS 'links keywords to groups';


CREATE TABLE coding.icpc2_keywords (
    pk serial primary key,
    keyword text NOT NULL
);

grant select on coding.icpc2_keywords to staff;

COMMENT ON TABLE coding.icpc2_keywords IS 'This table is used to search for terms 
 Users simply have to enter the first few letters of a keyword 
 and select the most appropriate term to record,
 rather than manually typing the name of
 the condition they wish to enter.
 Users do not have to be aware of the codes saved,
 or even know what they are coding';
COMMENT ON COLUMN coding.icpc2_keywords.keyword IS 'words or abbreviations, of up to 10 characters long, which are linked to ICPC-2
 PLUS terms, and used for searching.
 Keywords always have a logical connection with the ICPC2-PLUS term and can be
 fragments of terms, whole words, abbreviations, synonyms or acronyms. They can be
 up to 10 characters in length. Keywords tend to be plural rather than singular words
 and are formatted without spaces, slashes (/) or dashes (-). Multiple keywords may be
 linked to a single term. Similarly, multiple terms may be linked to a single keyword.

 Examples:

 AMENORRHOE
 ADHESIONS
 ADENOVIRUS
 ADRENAL
 ADVERSE
 ADVICE ';


CREATE TABLE coding.icpc2_link_keyword_term (
    fk_keyword integer NOT NULL,
    fk_term integer NOT NULL
);

grant select on coding.icpc2_link_keyword_term to staff;

COMMENT ON TABLE coding.icpc2_link_keyword_term IS 'This table links the keywords to terms e.g searching on ADRENAL will bring up this list:';
COMMENT ON COLUMN coding.icpc2_link_keyword_term.fk_keyword IS 'foreign key to icpc2_keywords table';
COMMENT ON COLUMN coding.icpc2_link_keyword_term.fk_term IS 'foreign key to icpc2_terms table';


CREATE TABLE coding.icpc2_terms (
    pk serial primary key,
    term text NOT NULL,
    natural_language_term text NOT NULL,
    icpc_code text NOT NULL,
    term_code text NOT NULL,
    status text,
    replacement text
);

grant select on coding.icpc2_terms to staff;

COMMENT ON TABLE coding.icpc2_terms IS 'The description of an ICPC-2 PLUS term, attached to the 6 digit alphanumeric code. A complete listing of a term
in this table could be e.g:
1,Disease;Hansens (Leprosy),Hansens disease (leprosy),A78,016,A ';


COMMENT ON COLUMN coding.icpc2_terms.term IS 'The description of the ICPC-2 PLUS code e.g Disease;Hansens (Leprosy)';
COMMENT ON COLUMN coding.icpc2_terms.natural_language_term IS 'The natural language term, up to 50 characters e.g Hansens disease (leprosy)';
COMMENT ON COLUMN coding.icpc2_terms.icpc_code IS 'The 3 digit alpha-numeric ICPC-2 code  e.g A78';
COMMENT ON COLUMN coding.icpc2_terms.term_code IS 'also called the ‘plus code’.
The three digit code that makes up the extension of ICPC-2 for Australia. 
In combination with the ICPC code it provides a more specific
six digit code to record a concept in the classification. e.g 016';
COMMENT ON COLUMN coding.icpc2_terms.status IS 'Indicates whether the code is active (A) or inactive (I) (for further information e.g A';
COMMENT ON COLUMN coding.icpc2_terms.replacement IS 'The replacement code field is used when a term is made inactive,
 and states the code that should be used in its place 
 (for further information on inactive codes ';
CREATE TABLE coding.icpc2_version (
    version text NOT NULL
);
COMMENT ON TABLE coding.icpc2_version IS 'The release date eg 08/2008';

CREATE TABLE coding.icpc2_drsdesk_term_mapper (
    pk serial primary key,
    fk_term integer NOT NULL,
    drsdesk_free_text text NOT NULL
);
grant select on coding.icpc2_drsdesk_term_mapper to staff;

CREATE TABLE coding.icpc2_user_terms (
    pk serial primary key,
    term text NOT NULL,
    natural_language_term text NOT NULL,
    icpc_code text NOT NULL,
    term_code text NOT NULL,
    status text,
    replacement text
);
grant select on coding.icpc2_user_terms to staff;

CREATE VIEW coding.vwicpc2terms AS
    SELECT icpc2_terms.pk AS pk_term, icpc2_keywords.keyword, icpc2_terms.replacement, ((((icpc2_terms.term || ' ('::text) || icpc2_terms.icpc_code) || icpc2_terms.term_code) || ')'::text) AS combined_term_code, icpc2_terms.term, icpc2_terms.natural_language_term, icpc2_terms.icpc_code, icpc2_terms.term_code, icpc2_terms.status FROM 
((coding.icpc2_link_keyword_term JOIN coding.icpc2_keywords ON ((icpc2_link_keyword_term.fk_keyword = icpc2_keywords.pk))) 
JOIN coding.icpc2_terms ON ((icpc2_link_keyword_term.fk_term = icpc2_terms.pk))) 
UNION SELECT icpc2_terms.pk AS pk_term, null as keyword, icpc2_terms.replacement, 
((((icpc2_terms.term || ' ('::text) || icpc2_terms.icpc_code) || icpc2_terms.term_code) || ')'::text)
 AS combined_term_code, icpc2_terms.term, icpc2_terms.natural_language_term, icpc2_terms.icpc_code, icpc2_terms.term_code, icpc2_terms.status 
FROM coding.icpc2_terms WHERE (icpc2_terms.icpc_code = 'J99'::text) ORDER BY 2;

grant select on coding.vwicpc2terms to staff;

CREATE VIEW coding."vwicpc2terms_nonJTerm" AS
    SELECT icpc2_terms.pk AS pk_term, icpc2_keywords.keyword, icpc2_terms.replacement, ((((icpc2_terms.term || ' ('::text) || icpc2_terms.icpc_code) || icpc2_terms.term_code) || ')'::text) AS combined_term_code, icpc2_terms.term, icpc2_terms.natural_language_term, icpc2_terms.icpc_code, icpc2_terms.term_code, icpc2_terms.status 
FROM ((coding.icpc2_link_keyword_term JOIN coding.icpc2_keywords ON ((icpc2_link_keyword_term.fk_keyword = icpc2_keywords.pk))) 
JOIN coding.icpc2_terms ON ((icpc2_link_keyword_term.fk_term = icpc2_terms.pk))) ORDER BY icpc2_keywords.keyword;

grant select on coding."vwicpc2terms_nonJTerm" to staff;

CREATE VIEW coding.vwicpc2terms_orig AS
    SELECT icpc2_terms.pk AS pk_term, icpc2_keywords.keyword, icpc2_terms.replacement, ((((icpc2_terms.term || ' ('::text) || icpc2_terms.icpc_code) || icpc2_terms.term_code) || ')'::text) AS combined_term_code, icpc2_terms.term, icpc2_terms.natural_language_term, icpc2_terms.icpc_code, icpc2_terms.term_code, icpc2_terms.status 
FROM ((coding.icpc2_link_keyword_term JOIN coding.icpc2_keywords ON ((icpc2_link_keyword_term.fk_keyword = icpc2_keywords.pk))) 
JOIN coding.icpc2_terms ON ((icpc2_link_keyword_term.fk_term = icpc2_terms.pk))) WHERE (icpc2_terms.status = 'A'::text);

grant select on coding.vwicpc2terms_orig to staff;
CREATE VIEW coding.vwicpckeywordgroupers AS
    SELECT DISTINCT icpc2_grp_keyword.keyword, icpc2_grp_grouper.grouper, icpc2_grp_grouper.grouper_description 
FROM (coding.icpc2_grp_keyword JOIN (coding.icpc2_grp_grouper JOIN coding.icpc2_grp_keyword_grp ON ((icpc2_grp_grouper."Grouper_id" = icpc2_grp_keyword_grp.grouper_id))) 
ON ((icpc2_grp_keyword.keyword_id = icpc2_grp_keyword_grp.keyword_id))) ORDER BY icpc2_grp_grouper.grouper, icpc2_grp_keyword.keyword, icpc2_grp_grouper.grouper_description;


grant select on coding.vwicpckeywordgroupers to staff;



update coding.lu_systems set preferred='f';
update coding.lu_systems set preferred='t' where pk=1;

\i icpc2_update.sql

