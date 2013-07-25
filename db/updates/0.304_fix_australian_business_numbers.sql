-- fix any existing abn's which may have spaces

update contacts.data_numbers set australian_business_number =
regexp_replace(australian_business_number,' +','','g');

COMMENT ON COLUMN contacts.data_numbers.australian_business_number  is
'the australian business number - this filed consists of numbers only no spaces and is validated in the gui before saving';

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 304);

