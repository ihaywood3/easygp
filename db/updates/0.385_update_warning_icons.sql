-- fixed wrong size/wrongly named icons inserted during last upgrade

update admin.lu_patient_warnings set icon_path='icons/20/centigradeicons_drugs2222.png'  where pk=6;
update admin.lu_patient_warnings set icon_path='icons/20/centigrade_syringe2222.png'  where pk=7;

update db.lu_version set lu_minor=385;

