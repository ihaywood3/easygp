Create table coding.user_favourites
(pk serial primary key,
 fk_code text not null,
 fk_staff integer not null,
 deleted boolean default false,
 CONSTRAINT user_favourites_fk_staff_fkey FOREIGN KEY  (fk_staff)
       REFERENCES admin.staff(pk)  MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION --,
 --CONSTRAINT user_favourites_fk_code_fkey FOREIGN KEY (fk_code)
   --   REFERENCES coding.generic_terms(code) MATCH SIMPLE
   --   ON UPDATE NO ACTION ON DELETE NO ACTION
  );
  
 COMMENT on table coding.user_favourites is
 ' A table to keep a list of users favourite codes for user in coding consultations see FProgressNoteEditor.class';
ALTER TABLE coding.user_favourites   OWNER TO easygp;
GRANT ALL ON TABLE coding.user_favourites TO easygp;


Create or replace view coding.vwUserFavourites as 
SELECT 
  user_favourites.pk,
  user_favourites.fk_staff, 
  vwgenericterms.code, 
  vwgenericterms.body_system, 
  vwgenericterms.code_role, 
  vwgenericterms.term, 
  vwgenericterms.fk_coding_system, 
  vwgenericterms.icd10, 
  vwgenericterms.active, 
  vwgenericterms.system, 
  vwgenericterms.preferred
FROM 
  coding.vwgenericterms, 
  coding.user_favourites
WHERE 
  user_favourites.fk_code = vwgenericterms.code and user_favourites.deleted = false;
  
ALTER TABLE coding.vwUserFavourites   OWNER TO easygp;
GRANT ALL ON TABLE coding.vwUserFavourites TO easygp;
GRANT SELECT ON TABLE coding.vwUserFavourites TO staff;

update db.lu_version set lu_minor=364;