alter table drugs.info drop column fk_clinical_effect;
drop table drugs.clinical_effects;
alter table drugs.info add column fk_severity integer references drugs.severity_level (pk);
drop table drugs.link_category_info ;
update drugs.patient_categories set pk = 7 where pk=1;
insert into drugs.patient_categories(pk,category) values (1,'all patients');
update drugs.pharmacologic_mechanisms set pk=11 where pk=1;
update drugs.pharmacologic_mechanisms set pk=1 where pk=10;
update drugs.pharmacologic_mechanisms set pk=10 where pk=11;

CREATE OR REPLACE VIEW drugs.vwinfo AS 
 SELECT di.pk, di.comment, di.fk_topic, di.created_at, di.fk_severity, ds.severity, dpm.mechanism AS pharmacologic_mechanism, di.fk_evidence_level, del.evidence_level, 
           di.fk_patient_category, dpc.category AS patient_category, di.fk_pharmacologic_mechanism,
           a2.atccode as actual_atccode,
           a2.atcname as actual_atcname,
           a1.atccode as atccode,
           a1.atcname as atcname
   FROM drugs.info di, drugs.severity_level ds, drugs.pharmacologic_mechanisms dpm, drugs.evidence_levels del, drugs.patient_categories dpc, drugs.atc a1, drugs.atc a2, drugs.link_atc_info l
  WHERE di.fk_severity = ds.pk AND di.fk_pharmacologic_mechanism = dpm.pk AND di.fk_evidence_level = del.pk AND di.fk_patient_category = dpc.pk and
        l.fk_info = di.pk and l.atccode = substring(a1.atccode for length(l.atccode)) and
        a2.atccode  = l.atccode;

