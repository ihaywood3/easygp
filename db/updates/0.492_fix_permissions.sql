GRANT USAGE ON SEQUENCE clin_certificates.centrelink_diagnoses_pk_seq TO staff;
GRANT USAGE ON SEQUENCE clin_certificates.centrelink_medical_certificates_pk_seq TO staff;
GRANT USAGE ON SEQUENCE clin_certificates.certificate_reasons_pk_seq TO staff;
GRANT USAGE ON SEQUENCE clin_certificates.lu_centrelink_condition_prognosis_pk_seq TO staff;
GRANT USAGE ON SEQUENCE clin_certificates.lu_centrelink_condition_temporality_pk_seq TO staff;
GRANT USAGE ON SEQUENCE clin_certificates.lu_centrelink_diagnosis_type_pk_seq TO staff;
GRANT USAGE ON SEQUENCE clin_certificates.lu_fitness_pk_seq TO staff;
GRANT USAGE ON SEQUENCE clin_certificates.lu_illness_temporality_pk_seq TO staff;
GRANT USAGE ON SEQUENCE clin_certificates.medical_certificate_pk_seq TO staff;

update db.lu_version set lu_minor = 492;

