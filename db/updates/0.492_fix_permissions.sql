GRANT USAGE ON SEQUENCE clin_certificates.centrelink_diagnoses_pk_seq TO staff;
GRANT USAGE ON SEQUENCE clin_certificates.centrelink_medical_certificates_pk_seq TO staff;
GRANT USAGE ON SEQUENCE clin_certificates.certificate_reasons_pk_seq TO staff;
GRANT USAGE ON SEQUENCE clin_certificates.lu_centrelink_condition_prognosis_pk_seq TO staff;
GRANT USAGE ON SEQUENCE clin_certificates.lu_centrelink_condition_temporality_pk_seq TO staff;
GRANT USAGE ON SEQUENCE clin_certificates.lu_centrelink_diagnosis_type_pk_seq TO staff;
GRANT USAGE ON SEQUENCE clin_certificates.lu_fitness_pk_seq TO staff;
GRANT USAGE ON SEQUENCE clin_certificates.lu_illness_temporality_pk_seq TO staff;
GRANT USAGE ON SEQUENCE clin_certificates.medical_certificate_pk_seq TO staff;

GRANT ALL ON SEQUENCE admin.lu_preferences_defaults_pk_seq TO staff;
GRANT USAGE ON SEQUENCE admin.test_latex_templates_pk_seq TO staff;
GRANT SELECT ON TABLE clin_measurements.vwlabinrs TO staff;
GRANT USAGE ON SEQUENCE clin_recalls.lu_status_pk_seq TO staff;
GRANT EXECUTE ON FUNCTION clerical.listsessions(timestamp without time zone, integer) TO staff;



update db.lu_version set lu_minor = 492;

