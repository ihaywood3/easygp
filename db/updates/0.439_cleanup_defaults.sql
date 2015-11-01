drop table defaults.lu_link_printer_task;
drop table defaults.lu_printer_host cascade;
drop table defaults.lu_printer_task cascade;
drop table defaults.temp;

update db.lu_version set lu_minor=439;
