-- coding schema permissions

ALTER TABLE coding.generic_terms OWNER TO easygp;
GRANT ALL ON TABLE coding.generic_terms TO easygp;
GRANT SELECT ON TABLE coding.generic_terms TO staff;

ALTER TABLE coding.icpc2_chapters OWNER TO easygp;
GRANT ALL ON TABLE coding.icpc2_chapters TO easygp;
GRANT SELECT ON TABLE coding.icpc2_chapters TO staff;

ALTER TABLE coding.icpc2_codes OWNER TO easygp;
GRANT ALL ON TABLE coding.icpc2_codes TO easygp;
GRANT SELECT ON TABLE coding.icpc2_codes TO staff;

ALTER TABLE coding.icpc2_components OWNER TO easygp;
GRANT ALL ON TABLE coding.icpc2_components TO easygp;
GRANT SELECT ON TABLE coding.icpc2_components TO staff;

ALTER TABLE coding.icpc2_drsdesk_term_mapper OWNER TO easygp;
GRANT ALL ON TABLE coding.icpc2_drsdesk_term_mapper TO easygp;
GRANT SELECT ON TABLE coding.icpc2_drsdesk_term_mapper TO staff;


ALTER TABLE coding.icpc2_grp_grouper OWNER TO easygp;
GRANT ALL ON TABLE coding.icpc2_grp_grouper TO easygp;
GRANT SELECT ON TABLE coding.icpc2_grp_grouper TO staff;

ALTER TABLE coding.icpc2_grp_grp_icpc OWNER TO easygp;
GRANT ALL ON TABLE coding.icpc2_grp_grp_icpc TO easygp;
GRANT SELECT ON TABLE coding.icpc2_grp_grp_icpc TO staff;

ALTER TABLE coding.icpc2_grp_keyword OWNER TO easygp;
GRANT ALL ON TABLE coding.icpc2_grp_keyword TO easygp;
GRANT SELECT ON TABLE coding.icpc2_grp_keyword TO staff;

ALTER TABLE coding.icpc2_grp_keyword_grp OWNER TO easygp;
GRANT ALL ON TABLE coding.icpc2_grp_keyword_grp TO easygp;
GRANT SELECT ON TABLE coding.icpc2_grp_keyword_grp TO staff;

ALTER TABLE coding.icpc2_keywords OWNER TO easygp;
GRANT ALL ON TABLE coding.icpc2_keywords TO easygp;
GRANT SELECT ON TABLE coding.icpc2_keywords TO staff;

ALTER TABLE coding.icpc2_link_keyword_term OWNER TO easygp;
GRANT ALL ON TABLE coding.icpc2_link_keyword_term TO easygp;
GRANT SELECT ON TABLE coding.icpc2_link_keyword_term TO staff;

ALTER TABLE coding.icpc2_terms OWNER TO easygp;
GRANT ALL ON TABLE coding.icpc2_terms TO easygp;
GRANT SELECT ON TABLE coding.icpc2_terms TO staff;


ALTER TABLE coding.icpc2_user_terms OWNER TO easygp;
GRANT ALL ON TABLE coding.icpc2_user_terms TO easygp;
GRANT SELECT ON TABLE coding.icpc2_user_terms TO staff;

ALTER TABLE coding.icpc2_version OWNER TO easygp;
GRANT ALL ON TABLE coding.icpc2_version TO easygp;
GRANT SELECT ON TABLE coding.icpc2_version TO staff;

ALTER TABLE coding.lu_loinc OWNER TO easygp;
GRANT ALL ON TABLE coding.lu_loinc TO easygp;
GRANT SELECT ON TABLE coding.lu_loinc TO staff;


ALTER TABLE coding.lu_loinc_abbrev OWNER TO easygp;
GRANT ALL ON TABLE coding.lu_loinc_abbrev TO easygp;
GRANT SELECT ON TABLE coding.lu_loinc_abbrev TO staff;

ALTER TABLE coding.lu_systems OWNER TO easygp;
GRANT ALL ON TABLE coding.lu_systems TO easygp;
GRANT SELECT ON TABLE coding.lu_systems TO staff;

ALTER TABLE coding.usr_codes_weighting OWNER TO easygp;
GRANT ALL ON TABLE coding.usr_codes_weighting TO easygp;
GRANT SELECT ON TABLE coding.usr_codes_weighting TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 97);

