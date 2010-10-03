--delete from coding.lu_loinc_abbrev_temp;
fixme - I've added a unique pk.
--\copy coding.lu_loinc_abbrev_temp from 'lu_loinc_abbrev.txt'  delimiter '|' NULL AS ''