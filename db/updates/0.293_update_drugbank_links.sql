ALTER TABLE drugbank.external_links ADD COLUMN fk_drug integer;
ALTER TABLE drugbank.external_links
  ADD CONSTRAINT external_links_fk_drug_fkey FOREIGN KEY (fk_drug)
      REFERENCES drugbank.drug (pk) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE drugbank.lu_external_resources
  ADD CONSTRAINT lu_external_resources_resource_key UNIQUE(resource);
