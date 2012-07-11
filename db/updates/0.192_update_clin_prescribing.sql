-- accidentally dropped a table during one of the deletes I think
-- maybe just on my machine.

CREATE TABLE clin_prescribing.increased_quantity_authority_reasons
(
  pk serial NOT NULL,
  reason text NOT NULL,
  CONSTRAINT increased_quantity_authority_reasons_pkey PRIMARY KEY (pk)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE clin_prescribing.increased_quantity_authority_reasons OWNER TO easygp;
GRANT ALL ON TABLE clin_prescribing.increased_quantity_authority_reasons TO easygp;
GRANT ALL ON TABLE clin_prescribing.increased_quantity_authority_reasons TO staff;


truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 192)

