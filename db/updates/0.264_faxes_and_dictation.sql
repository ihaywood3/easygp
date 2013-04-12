 create or replace view contacts.vwPersonsEmployeesByOccupation as
  SELECT DISTINCT (vwpersonsexcludingpatients.fk_person || '-'::text) || COALESCE(vwpersonsexcludingpatients.fk_address, 0)::text AS pk_view, vwpersonsexcludingpatients.fk_person, vwpersonsexcludingpatients.title, vwpersonsexcludingpatients.surname, vwpersonsexcludingpatients.firstname, vwpersonsexcludingpatients.occupation, vwpersonsexcludingpatients.sex, vwpersonsexcludingpatients.salutation, NULL::text AS organisation, NULL::text AS branch, 0 AS fk_organisation, 0 AS fk_branch, vwpersonsexcludingpatients.fk_address, 0 AS fk_employee, vwpersonsexcludingpatients.street1, vwpersonsexcludingpatients.street2, vwpersonsexcludingpatients.town, vwpersonsexcludingpatients.state, vwpersonsexcludingpatients.postcode, vwpersonsexcludingpatients.wholename, vwpersonsexcludingpatients.surname_normalised, data_numbers.provider_number, data_numbers.prescriber_number, contacts.vwpersonscomms.value as fax
           FROM contacts.vwpersonsexcludingpatients
      LEFT JOIN contacts.data_numbers ON data_numbers.fk_person = vwpersonsexcludingpatients.fk_person AND data_numbers.fk_branch IS NULL
      left join contacts.vwpersonscomms on vwpersonscomms.fk_person = contacts.vwpersonsexcludingpatients.fk_person and vwpersonscomms.fk_type=2
     WHERE vwpersonsexcludingpatients.retired IS FALSE AND vwpersonsexcludingpatients.deceased IS FALSE AND vwpersonsexcludingpatients.fk_address IS NOT NULL AND (vwpersonsexcludingpatients.address_deleted IS FALSE OR vwpersonsexcludingpatients.address_deleted IS NULL) AND vwpersonsexcludingpatients.deleted = false
UNION 
         SELECT DISTINCT (vwemployees.fk_person || '-'::text) || COALESCE(vwemployees.fk_address, 0)::text AS pk_view, vwemployees.fk_person, vwemployees.title, vwemployees.surname, vwemployees.firstname, vwemployees.occupation, vwemployees.sex, vwemployees.salutation, vwemployees.organisation, vwemployees.branch, vwemployees.fk_organisation, vwemployees.fk_branch, vwemployees.fk_address, vwemployees.fk_employee, vwemployees.street1, vwemployees.street2, vwemployees.town, vwemployees.state, vwemployees.postcode, (((vwemployees.title || ' '::text) || vwemployees.firstname) || ' '::text) || vwemployees.surname AS wholename, vwemployees.surname_normalised, vwemployees.provider_number, vwemployees.prescriber_number, contacts.vwbranchescomms.value as fax
           FROM contacts.vwemployees
            left join contacts.vwbranchescomms on vwbranchescomms.fk_branch = vwemployees.fk_branch and vwbranchescomms.fk_type = 2
          WHERE vwemployees.employee_deleted = false AND vwemployees.person_deleted = false AND vwemployees.deceased = false AND vwemployees.retired = false AND (vwemployees.organisation_address_deleted = false OR vwemployees.organisation_address_deleted IS NULL) AND vwemployees.fk_status <> 2;

create table clin_consult.dictations (
    pk serial primary key,
    filename text not null, 
    fk_referral integer references clin_referrals.referrals (pk),
    fk_progress_note integer references clin_consult.progressnotes (pk),
    transcript text,
    fk_user integer references admin.staff (pk) not null,
    processed boolean not null default false
);

alter table clin_consult.dictations owner to easygp;
grant all on clin_consult.dictations to staff;

comment on table clin_consult.dictations is 'dictation recordings made by the user';
comment on column clin_consult.dictations.filename is 'the name of the MP3 file in the documents store';
comment on column clin_consult.dictations.fk_referral is 'if a dictated referral, the (saved unsent) referral row to be filled';
comment on column clin_consult.dictations.fk_progress_note is 'if a progress note, the progress note row to be filled in. This and fk_referral cannot both be NULL, but one alwys will be';
comment on column clin_consult.dictations.transcript is 'the text as returned by the transcriptionist, without user corrections';
comment on column clin_consult.dictations.processed is 'true if the user has reviewed the transcript, corrected and post to the original table (referral or progress note). In principle the referral could still be unsent, but would usually be sent immediately after correction of the transcript';

create or replace view clin_consult.vwdictations as 
   select 
	d.pk as pk_dictation,
	d.fk_referral as fk_referral,
	d.transcript as transcript,
	d.fk_progress_note as fk_progress_note,
	d.fk_user as fk_user,
	d.processed as processed,
	d.filename as filename,
	vwp.wholename as wholename
  from
       clin_consult.dictations d,
       clin_referrals.referrals r,
       contacts.vwpatients vwp,
	clin-consult.consult c
 where
	d.fk_referral = r.pk and
        r.fk_consult = c.pk  and
	c.fk_patient = vwp.fk_patient;

truncate table db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 264);

