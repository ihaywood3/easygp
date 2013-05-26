-- these report names are missing from my db and the one in svn

Delete from billing.lu_reports;  -- in case already there in someones db

ALTER SEQUENCE billing.lu_reports_pk_seq
    INCREMENT 1  MINVALUE 1
    MAXVALUE 9223372036854775807  RESTART 1
    CACHE 1  NO CYCLE;

Insert into billing.lu_reports (report_title) values('Consultations Not Charged');
Insert into billing.lu_reports (report_title) values('Day List of Patients Seen');
Insert into billing.lu_reports (report_title) values('Payments Received');

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 286)


