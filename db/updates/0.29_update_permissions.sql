GRANT ALL ON TABLE common.lu_urgency TO easygp;
GRANT SELECT ON TABLE common.lu_urgency TO staff;

ALTER TABLE common.lu_whisper_test OWNER TO easygp;
GRANT ALL ON TABLE common.lu_whisper_test TO easygp;
GRANT SELECT ON TABLE common.lu_whisper_test TO staff;

ALTER TABLE common.vwreligions OWNER TO easygp;
GRANT ALL ON TABLE common.vwreligions TO easygp;
GRANT SELECT ON TABLE common.vwreligions TO staff;


ALTER TABLE common.lu_sub_religions OWNER TO easygp;
GRANT ALL ON TABLE common.lu_sub_religions TO easygp;
GRANT SELECT ON TABLE common.lu_sub_religions TO staff;

ALTER TABLE common.lu_social_support OWNER TO easygp;
GRANT ALL ON TABLE common.lu_social_support TO easygp;
GRANT SELECT ON TABLE common.lu_social_support TO staff;


ALTER TABLE common.lu_smoking_status OWNER TO easygp;
GRANT ALL ON TABLE common.lu_smoking_status TO easygp;
GRANT SELECT ON TABLE common.lu_smoking_status TO staff;

ALTER TABLE common.lu_religions OWNER TO easygp;
GRANT ALL ON TABLE common.lu_religions TO easygp;
GRANT SELECT ON TABLE common.lu_religions TO staff;

ALTER TABLE common.lu_normality OWNER TO easygp;
GRANT ALL ON TABLE common.lu_normality TO easygp;
GRANT SELECT ON TABLE common.lu_normality TO staff;

ALTER TABLE common.lu_hearing_aid_status OWNER TO easygp;
GRANT ALL ON TABLE common.lu_hearing_aid_status TO easygp;
GRANT SELECT ON TABLE common.lu_hearing_aid_status TO staff;

ALTER TABLE common.lu_companion_status OWNER TO easygp;
GRANT ALL ON TABLE common.lu_companion_status TO easygp;
GRANT SELECT ON TABLE common.lu_companion_status TO staff;

ALTER TABLE admin.global_preferences OWNER TO easygp;
GRANT ALL ON TABLE admin.global_preferences TO easygp;

ALTER TABLE admin.vwclinicrooms OWNER TO easygp;
GRANT ALL ON TABLE admin.vwclinicrooms TO easygp;

ALTER TABLE clin_certificates.lu_illness_temporality OWNER TO easygp;
GRANT ALL ON TABLE clin_certificates.lu_illness_temporality TO easygp;
GRANT SELECT ON TABLE clin_certificates.lu_illness_temporality TO staff;

ALTER TABLE clin_certificates.medical_certificate OWNER TO easygp;
GRANT ALL ON TABLE clin_certificates.medical_certificate TO easygp;
GRANT ALL ON table  clin_certificates.medical_certificate TO staff;

ALTER TABLE clin_certificates.vwmedicalcertificates OWNER TO easygp;
GRANT ALL ON TABLE clin_certificates.vwmedicalcertificates TO easygp;
GRANT ALL ON table  clin_certificates.vwmedicalcertificates TO staff;


ALTER TABLE clin_checkups.lu_nutrition_questions OWNER TO easygp;
GRANT ALL ON TABLE clin_checkups.lu_nutrition_questions TO easygp;
GRANT ALL ON table  clin_checkups.lu_nutrition_questions TO staff;

ALTER TABLE clin_checkups.lu_state_of_health OWNER TO easygp;
GRANT ALL ON TABLE clin_checkups.lu_state_of_health TO easygp;
GRANT ALL ON table  clin_checkups.lu_state_of_health TO staff;

ALTER TABLE clin_checkups.over75 OWNER TO easygp;
GRANT ALL ON TABLE clin_checkups.over75 TO easygp;
GRANT ALL ON table  clin_checkups.over75 TO staff;

ALTER TABLE clin_history.care_plan_components_due OWNER TO easygp;
GRANT ALL ON TABLE clin_history.care_plan_components_due TO easygp;
GRANT ALL ON table  clin_history.care_plan_components_due TO staff;

ALTER TABLE  all_images OWNER TO easygp;
GRANT ALL ON TABLE all_images TO easygp;
GRANT ALL ON TABLE all_images TO staff;

ALTER TABLE contacts.images OWNER TO easygp;
GRANT ALL ON TABLE contacts.images TO easygp;
GRANT ALL ON TABLE contacts.images TO staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 29);