Create or replace view research.vwHBA1cGraph as 
   Select 
              '>8' As XAxes_text, count(value_numeric), 6 As display_order 
              From Documents.vwObservations  where loinc = '4548-4' and value_numeric > 8
              UNION
          select 
              '7.5-8.0' As XAxes_text, count(value_numeric), 5 as display_order 
              From Documents.vwObservations  where loinc = '4548-4' and value_numeric between  7.5  and 8.0
              UNION 
          select  
             '7.0-7.5' As XAxes_text, count(value_numeric), 4 as display_order 
              From Documents.vwObservations  where loinc = '4548-4' and value_numeric between 7 and 7.5 
            UNION 
          select 
              '6.5-7.0' As XAxes_text, count(value_numeric), 3 as display_order 
              From Documents.vwObservations  where loinc = '4548-4' and value_numeric between  6.5 and 7.0
               UNION 
          select 
              '6.0-6.5' As XAxes_text, count(value_numeric), 2 as display_order 
              From Documents.vwObservations  where loinc = '4548-4' and value_numeric between  6.0 and 6.5
               UNION 
          select 
                '<6' As XAxes_text, count(value_numeric), 1 as display_order 
               From Documents.vwObservations  where loinc = '4548-4' and value_numeric < 6
               order by display_order;
   
truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 115);

