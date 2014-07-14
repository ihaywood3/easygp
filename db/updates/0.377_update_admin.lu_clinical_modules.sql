-- drugs used name reverted to Habits at behest of Horst
-- he says that patient looking at the screen took offence at the term 'recreational drugs'
Update admin.lu_clinical_modules set name = 'Habits' where name='Recreational Drugs';

update db.lu_version set lu_minor=377;
