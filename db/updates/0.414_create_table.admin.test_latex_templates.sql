-- Creates a table to continue test templates to allow  user in the GUI to line up vertical/horizontal offsets for a room printer
-- this is done via the 'Room Setup' tab, the code is in FRoomSetup

--DROP TABLE Admin.test_latex_templates;

Create table Admin.test_latex_templates
(pk serial primary key,
name text not null,
latex text not null,
deleted boolean default false,
horizontal_offset decimal,
vertical_offset decimal
 );

 COMMENT ON TABLE Admin.test_latex_templates is 'some latex templates to test vertical/horizontal offset for form printing';
 
 ALTER TABLE Admin.test_latex_templates OWNER TO easygp;
 GRANT SELECT ON Admin.test_latex_templates TO staff;
 
 update db.lu_version set lu_minor=414;
 

