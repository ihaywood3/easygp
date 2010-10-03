-- update or install the ICPC codes


truncate coding.icpc2_keywords;
truncate coding.icpc2_link_keyword_term ;
truncate coding.icpc2_terms ;
truncate coding.icpc2_version ;
truncate coding.icpc2_chapters ;
truncate coding.icpc2_components ;
truncate coding.icpc2_codes ;
truncate coding.icpc2_grp_keyword ;
truncate coding.icpc2_grp_keyword_grp ;
truncate coding.icpc2_grp_grouper ;
truncate coding.icpc2_grp_grp_icpc ;

\copy coding.icpc2_keywords from 'ICPC2KEY.CSV'  delimiter ',' CSV HEADER  NULL AS ''
\copy coding.icpc2_link_keyword_term from 'ICPC2LNK.CSV'  delimiter ',' CSV HEADER  NULL AS ''
\copy coding.icpc2_terms from 'ICPC2TRM.CSV'  delimiter ',' CSV HEADER  NULL AS ''
\copy coding.icpc2_version from 'VERSION.CSV'  delimiter ',' CSV HEADER  NULL AS ''
\copy coding.icpc2_chapters from 'ICPC2CHA.CSV'  delimiter ',' CSV HEADER  NULL AS ''
\copy coding.icpc2_components from 'ICPC2COM.CSV'  delimiter ',' CSV HEADER  NULL AS ''
\copy coding.icpc2_codes from 'ICPC2COD.CSV'  delimiter ',' CSV HEADER  NULL AS ''
\copy coding.icpc2_grp_keyword from 'grp_Keyword.csv'   delimiter ',' CSV HEADER NULL AS ''
\copy coding.icpc2_grp_keyword_grp from 'grp_kwd_grp.csv'  delimiter ',' CSV HEADER NULL AS ''
\copy coding.icpc2_grp_grouper from 'grp_Grouper.csv'  delimiter ',' CSV HEADER NULL AS ''
\copy coding.icpc2_grp_grp_icpc from 'grp_grp_icpc.csv'  delimiter ',' CSV HEADER NULL AS ''



insert into coding.generic_terms (code,                    body_system,code_role,term,  fk_coding_system,active,icd10) select
                                  t.icpc_code||t.term_code,     NULL,     2,     t.term,       1        ,  't' ,c.icd10
          from coding.icpc2_terms t, coding.icpc2_codes c where t.status = 'A' and t.icpc_code=c.icpc_code;

