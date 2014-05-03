-- added a new consult type for when clerical stuff enter or alter stuff in clinical record eg next of kin.
insert into clin_consult.lu_consult_type(type,user_selectable) values ('Clerical Note', False);

update db.lu_version set lu_minor=362;

