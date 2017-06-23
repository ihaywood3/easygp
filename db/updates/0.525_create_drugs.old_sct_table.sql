-- this table seems missing from my database, it is in Ian's and is needed for whoever does the drug updates
create table drugs.old_sct 
(fk_product uuid NOT NULL,
 sct text not null);

 update db.lu_version set lu_minor=525;