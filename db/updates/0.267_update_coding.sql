-- updates copy of drsdesk terms mapped to icpc and further down the page the user_terms (J99 terms)
--Drop table coding.icpc2_drsdesk_term_mapper;
--yDROP TABLE coding.icpc2_user_terms;
--DROP TABLE Coding.lu_icpc2_plain_language_mapper;
--DROP SEQUENCE coding.icpc2_user_terms_seq;
--DROP SEQUENCE coding.icpc2_drsdesk_term_mapper_seq;
DROP SEQUENCE coding.user_terms_pk_seq;


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0,267);
