-- mmm.. my bad spelling from many meny years ago fixed

update clin_vaccination.lu_schedules set schedule = 'Diphtheria' where schedule ='Diptheria';
update clin_vaccination.lu_schedules set schedule = 'Tetanus Diphtheria Pertussus Polio' where schedule = 'Tetanus Diptheria Pertussus Polio';

update db.lu_version set lu_minor=348;
