-- removes default of 0 in a foreign key

alter table clin_history.past_history alter column fk_laterality set default null;
update  clin_history.past_history set fk_laterality = null where fk_laterality = 0;

update db.lu_version set lu_minor = 450;
