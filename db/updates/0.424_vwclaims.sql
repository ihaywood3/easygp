create or replace view billing.vwclaims as select
 claims.pk as pk                        
 , claim_id                  
 , claim_date                
 , claims.fk_branch as fk_branch                
 ,result_code              
 , (coalesce(result_text,'') || coalesce(lu_codes.description,'')) as result_text              
 , claims.provider_number          
 ,payment_report_run_date    
 , processing_report_run_date 
 , payment_report 
 , vwstaff.wholename as doctor
 , vwclinics.branch as branch
from 
   billing.claims
   LEFT JOIN billing.lu_codes ON (lu_codes.code = claims.result_code)
   LEFT JOIN admin.vwstaff ON (vwstaff.provider_number = claims.provider_number)
   JOIN admin.vwclinics ON (vwclinics.fk_branch = claims.fk_branch);

grant select on billing.vwclaims to staff;

insert into billing.lu_codes(code,description) values (4013,'Invoice deleted using same-day delete function');

update db.lu_version set lu_minor=424;

