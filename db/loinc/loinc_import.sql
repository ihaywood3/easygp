delete from coding.lu_loinc;
\copy coding.lu_loinc from 'lu_loinc.txt'  delimiter '|' NULL AS ''