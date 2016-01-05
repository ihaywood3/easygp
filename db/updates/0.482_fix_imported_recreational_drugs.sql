update  clin_history.recreational_drugs set fk_lu_route_administration =  7 where fk_lu_recreational_drug = 1; --- 1=nicotine inhaled = 7
update  clin_history.recreational_drugs set fk_lu_route_administration =  5  where fk_lu_recreational_drug = 2; --- 1=alcohol oral = 5

update db.lu_version set lu_minor = 482;
