
Create table clin_recalls.lu_status
(pk serial primary key,
 status text not null);

 COMMENT ON TABLE clin_recalls.lu_status is 'the completion or otherwise status  not due, finalised, refused
     corresponds to e.g const.RecallNotDue in the gui code';

INSERT INTO  clin_recalls.lu_status(status) VALUES('not due');
INSERT INTO  clin_recalls.lu_status(status) VALUES('overdue');
INSERT INTO  clin_recalls.lu_status(status) VALUES('reminder sent');
INSERT INTO  clin_recalls.lu_status(status) VALUES('arranged not completed');
INSERT INTO  clin_recalls.lu_status(status) VALUES('completed');
INSERT INTO  clin_recalls.lu_status(status) VALUES('refused');
INSERT INTO  clin_recalls.lu_status(status) VALUES('repeat same interval');

COMMENT ON COLUMN clin_recalls.recalls.fk_status IS 'key to lu_status table, ie things like not due, finalised, refused
corresponds to e.g gvar.RecallNotDue constants
this defaults to 1 = not due';
update clin_recalls.lu_recall_intervals set fk_interval_unit = 8 where fk_interval_unit = 0; --  fix for previousi bug

update db.lu_version set lu_minor=436;
