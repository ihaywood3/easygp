-- remove an inappropriate comment, the field is self explanatory

COMMENT ON COLUMN clin_history.social_history.fk_progressnote  is null;

update db.lu_version set lu_minor = 454;