comment on table common.lu_route_administration is
'The route of administration of a a substance eg, oral, intramuscular, intrathecal';

update common.lu_site_administration set site = 'unknown' where site = 'unkown';
update db.lu_version set lu_minor = 446;
