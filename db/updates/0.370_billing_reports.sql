truncate table billing.lu_reports;

alter table billing.lu_reports add column "sql" text not null;
alter table billing.lu_reports add column plot text;
alter table billing.lu_reports add column fk_subreport integer references billing.lu_reports(pk);
alter table billing.lu_reports add column subkey name;

comment on column billing.lu_reports."sql" is 'SQL code to run the report, with variable subsitutions prefixed by dollar. $staff $start_date and $end_date are default';
comment on column billing.lu_reports.plot is 'if non-null GNUPlot program to feed results of query into';
comment on column billing.lu_reports.fk_subreport is 'PK of sub-report if exists';
comment on column billing.lu_reports.subkey is 'field on this report to be available to subreport''s quiery as a substitution variable';

update db.lu_version set lu_minor=370;
