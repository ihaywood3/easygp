alter table billing.invoices add column pms_claim_id text;
alter table billing.invoices add column error_level char(1);
alter table billing.items_billed add column error_level char(1);

comment on column billing.invoices.pms_claim_id is 'Medicare Online returns a claim transaction ID, which their documentaiton misleadingly calls the PMS Claim ID'; 
comment on column billing.invoices.error_level is 'Medicare Online''s one-char error level code, A=acceptable, U=aunacceptable, not very useful compared to the error numeric code';
comment on column billing.items_billed.error_level is 'Medicare Online''s one-char error level code, A=acceptable, U=unacceptable, not very useful compared to the error numeric code';


create table billing.codes (code integer unique, description text);
grant select on billing.codes to staff;

CREATE OR REPLACE FUNCTION billing.assert_code(integer,text)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
begin
  perform 1 from billing.codes where code=$1;
  if found then
      update billing.codes set description=$2 where code=$1;
  else
      insert into billing.codes (code,description) values ($1, $2);
  end if;
end
$function$;


create or replace view billing.vwinvoices as 
 SELECT invoices.pk AS pk_invoice,
    invoices.pk AS fk_invoice,
   invoices.notes,
    invoices.fk_staff_invoicing,
    invoices.fk_patient,
    invoices.date_printed,
    invoices.fk_staff_provided_service,
    invoices.date_invoiced,
    invoices.paid,
    invoices.fk_payer_person,
    invoices.fk_payer_branch,
    COALESCE(vworganisations.organisation, vwpersonsincludingpatients.wholename) AS account_to_name,
    vworganisations.branch AS account_to_branch,
    COALESCE(COALESCE(vworganisations.street1 || ' '::text, vworganisations.street2 || ' '::text), COALESCE(vwpersonsincludingpatients.street1 || ' '::text, vwpersonsincludingpatients.street2 || ' '::text)) AS account_to_street,
    COALESCE((vworganisations.town || ' '::text) || vworganisations.postcode::text, (vwpersonsincludingpatients.town || ' '::text) || vwpersonsincludingpatients.postcode::text) AS account_to_town_postcode,
    invoices.latex,
    invoices.fk_branch,
    invoices.visit_date,
    invoices.fk_appointment,
    bookings.begin AS appointment_time,
    bookings.duration,
    invoices.reference,
    invoices.fk_lu_bulk_billing_type,
    invoices.total_bill,
    invoices.total_paid,
    invoices.total_gst,
    invoices.total_bill - invoices.total_paid AS due,
    staff_invoicing.wholename AS staff_invoicing_wholename,
    staff_provider.wholename AS staff_provided_service_wholename,
    staff_provider.provider_number AS staff_provided_service_provider_number,
    staff_provider.australian_business_number,
    vwpatients.firstname AS patient_firstname,
    vwpatients.surname AS patient_surname,
    vwpatients.title AS patient_title,
    vwpatients.fk_sex AS patient_fk_sex,
    vwpatients.sex AS patient_sex,
    vwpatients.wholename AS patient_wholename,
    vwpatients.fk_lu_centrelink_card_type,
    vwpatients.fk_lu_default_billing_level,
    vworganisations1.branch,
    claims.claim_id,
    claims.result_code AS claim_result_code,
    claims.result_text AS claim_result_text,
    claims.claim_date,
    invoices.online,
    invoices.fk_claim,
    invoices.voucher_id,
    invoices.referrer_provider_number,
    invoices.referral_date,
    invoices.referral_duration,
    invoices.result_code,
    invoices.result_text,
    invoices.error_level,
    invoices.pms_claim_id,
    c1.description,
    c2.description as claim_description
   FROM billing.invoices
   JOIN admin.vwstaff staff_invoicing ON invoices.fk_staff_invoicing = staff_invoicing.fk_staff
   JOIN admin.vwstaff staff_provider ON invoices.fk_staff_provided_service = staff_provider.fk_staff
   JOIN contacts.vworganisations vworganisations1 ON invoices.fk_branch = vworganisations1.fk_branch
   LEFT JOIN clerical.bookings ON invoices.fk_appointment = bookings.pk
   LEFT JOIN contacts.vworganisations ON invoices.fk_payer_branch = vworganisations.fk_branch
   LEFT JOIN contacts.vwpersonsincludingpatients ON invoices.fk_payer_person = vwpersonsincludingpatients.fk_person
   LEFT JOIN contacts.vwpatients ON invoices.fk_patient = vwpatients.fk_patient
   LEFT JOIN billing.claims ON invoices.fk_claim = claims.pk
   LEFT JOIN billing.codes c1 ON invoices.result_code = c1.code
   LEFT JOIN billing.codes c2 ON claims.result_code = c2.code;

create or replace view billing.vwitemsbilled as 
 SELECT items_billed.pk AS pk_items_billed,
    items_billed.fk_fee_schedule,
    items_billed.amount,
    items_billed.amount_gst,
    items_billed.fk_invoice,
    items_billed.fk_lu_billing_type,
    lu_billing_type.type AS billing_type,
    fee_schedule.mbs_item,
    fee_schedule.user_item,
    fee_schedule.ama_item,
    coalesce(mbs_item,ama_item,user_item) as common_item,
    fee_schedule.descriptor,
    fee_schedule.descriptor_brief,
    fee_schedule.gst_rate,
    fee_schedule.percentage_fee_rule,
    items_billed.service_id,
    items_billed.reason_code,
    items_billed.comment,
    items_billed.error_level,
    codes.description
   FROM billing.items_billed
    JOIN billing.lu_billing_type ON lu_billing_type.pk = items_billed.fk_lu_billing_type
    JOIN billing.fee_schedule ON items_billed.fk_fee_schedule = fee_schedule.pk
    LEFT JOIN billing.codes ON items_billed.reason_code = codes.code;


CREATE or replace VIEW billing.vwitemsandinvoices AS
 SELECT vwitemsbilled.pk_items_billed,
    vwitemsbilled.fk_fee_schedule,
    vwitemsbilled.amount,
    vwitemsbilled.amount_gst,
    vwitemsbilled.fk_lu_billing_type,
    vwitemsbilled.billing_type,
    vwitemsbilled.mbs_item,
    vwitemsbilled.user_item,
    vwitemsbilled.ama_item,
    vwitemsbilled.descriptor,
    vwitemsbilled.descriptor_brief,
    vwitemsbilled.gst_rate,
    vwitemsbilled.percentage_fee_rule,
    vwinvoices.fk_invoice,
    vwinvoices.notes,
    vwinvoices.fk_staff_invoicing,
    vwinvoices.fk_patient,
    vwinvoices.date_printed,
    vwinvoices.fk_staff_provided_service,
    vwinvoices.date_invoiced,
    vwinvoices.paid,
    vwinvoices.fk_payer_person,
    vwinvoices.fk_payer_branch,
    vwinvoices.account_to_name,
    vwinvoices.account_to_branch,
    vwinvoices.account_to_street,
    vwinvoices.account_to_town_postcode,
    vwinvoices.latex,
    vwinvoices.fk_branch,
    vwinvoices.visit_date,
    vwinvoices.fk_appointment,
    vwinvoices.appointment_time,
    vwinvoices.duration,
    vwinvoices.reference,
    vwinvoices.fk_lu_bulk_billing_type,
    vwinvoices.total_bill,
    vwinvoices.total_paid,
    vwinvoices.total_gst,
    vwinvoices.due,
    vwinvoices.staff_invoicing_wholename,
    vwinvoices.staff_provided_service_wholename,
    vwinvoices.staff_provided_service_provider_number,
    vwinvoices.australian_business_number,
    vwinvoices.patient_firstname,
    vwinvoices.patient_surname,
    vwinvoices.patient_title,
    vwinvoices.patient_fk_sex,
    vwinvoices.patient_sex,
    vwinvoices.patient_wholename,
    vwinvoices.fk_lu_centrelink_card_type,
    vwinvoices.fk_lu_default_billing_level,
    vwinvoices.branch,
    vwinvoices.result_code,
    vwinvoices.result_text,
    vwitemsbilled.reason_code,
    vwitemsbilled.comment AS item_comment,
    vwitemsbilled.service_id,
    vwinvoices.voucher_id,
    vwinvoices.fk_claim,
    vwinvoices.pms_claim_id,
    vwinvoices.error_level as error_level,
    vwinvoices.description as description,
    vwitemsbilled.error_level as item_error_level,
    vwitemsbilled.description as item_description,
    vwinvoices.claim_description,
    vwinvoices.claim_result_code,
    vwinvoices.claim_result_text,
    vwinvoices.online,
    vwitemsbilled.common_item,
    vwinvoices.claim_id,
    vwinvoices.claim_date
   FROM billing.vwitemsbilled,
    billing.vwinvoices
  WHERE (vwinvoices.fk_invoice = vwitemsbilled.fk_invoice);





truncate billing.codes;

COPY billing.codes (code, description) FROM stdin;
0    Success
1001	Unable to load /connect to Java Virtual Machine.
1002	Unable to unload Medicare Online Claiming.
1003	Medicare Online Claiming is not operational.
1004	A session could not be established.
1005	No session matching the provided session ID currently exists.
1006	PKI login failure.
1007	Transmission failure.
1008	Medicare Online Claiming already operational
1010	Medicare Online Claiming session already exists
1011	Unable to find Java Virtual machine library
1012	The CLASSPATH environment variable cannot be found
1013	Unable to locate the base Java Classes
1014	Unable to locate the EasyclaimAPI class
1015	Create Cryptostore failure
1016	Config file not found, cannot be opened or file type incorrect. Check path.
1017	Config file already loaded. No action taken
1018	Config parameters does not exist or not defined for this DLL version
1019	Config parameter cannot be set as Medicare Online Claiming already operational (ie. loadEasyclaim already called)
1701	Sql failure
1702	XML to JAVA classes conversion failure
1703	Client Adaptor session does not exist
1704	Desecure failure
1705	Secure failure
1711	Unexpected protocol exception
1712	HTTP server error
1713	Protocol error
1714	Error occurred attempting to load logic pack
1715	The added content was created with a LogicPack with a different major and minor version therefore it cannot be loaded
1716	Request received, process in progress
1717	No logic packs have been loaded
1718	No further reports exist in session
1719	No unloadable content exists in session
1720	Unknown content type OR problem with configuration preventing ContentInfo lookup
1721	Development mode not supported by this ContentInfo OR retrieval of dev content failed
1722	Intermittent problem signing using the HCI token. Repeating the function call should be successful
1723	The receiver has rejected this asynchronous response and will not accept it at any future time. The sender should take whatever action is appropriate to reverse the transaction that generated the response.
1724	The receiver is unable to accept this asynchronous response at this time - the sender should attempt to deliver the response at a later time
1725	Inconsistent search criteria has been set
1726	The Business Process Manager has been unable to accept the claim request due to an unknown error
1727	Response received
1728	An undetermined error has occurred processing the request in the BPM
1997	An attempt to call an unsupported function was made
1998	An undefined error has been detected in C DLL
1999	An undefined error has been detected in Java API
2001	A claim is in progress and cannot be modified
2002	Missing or invalid transmission content type
2003	No transmission exists
2004	The element name supplied is not valid or does not apply to the current function
2005	No authorised claim exists within the specified session
2006	A claim or request already exists. Another claim or request cannot be created until the current claim or request is cancelled or completed.
2007	The transmission is empty i.e. the transmission does not contain any content
2008	No business object currently exists for the supplied Session ID
2009	The condition name supplied is not valid
2010	The claim type is not valid
2011	The information being set is inconsistent with the information currently set for this claim
2012	Transmission in progress. The requested action cannot be done until the current transmission is sent or cancelled.
2013	A report is in use. The existing report must be cleared before a claim or transmission can be created.
2014	The current claim has already been processed (submitted or accepted). Get details then clear the claim
2015	No voucher exists within the session for the supplied VoucherSeqNum
2016	No service exists in the claim for the supplied service ID
2017	The Payee Provider specified is the same as the Servicing Provider
2018	Data validation, cross field validations or unacceptable errors have been detected and not corrected OR data has been changed and not validated before submission. Correct any errors and resubmit.
2019	An object with the supplied object ID already exists
2020	Invalid file path type
2021	Invalid directory or directory not found
2022	The report name supplied is not valid
2023	The report is not available yet or is no longer available for retrieval
2024	A voucher with the quoted sequence number already exists in the claim/session
2025	The maximum number of child business objects for the parent business object type has been reached
2026	An out of sequence function call has occurred
2027	The report does not exist for the given selection criteria
2028	The requested clear would have removed the last voucher from the claim. The claim requires at least one voucher to be present.
2029	This function does not apply to the current report
2030	The data element being set is inconsistent with other data elements already set OR a data element has been set and a related conditionally required data element has not been set.
2031	The claim contains an unacceptable error that must be corrected prior to submission/storage
2032	The maximum number of services allowable for the voucher has been reached
2033	The maximum number of services allowable for the claim has been reached
2034	The OutputBuffer allocated is too small for the data being retrieved
2035	The function requested is inconsistent with the current state of processing
2036	The current claim must be completed (submitted, accepted or authorised and stored) or cancelled
2037	An error was detected with the voucher sequencing. The sequence numbers must begin with 01 and increment by one as each voucher is added.
2038	The referral/request type is inconsistent with the service type set for this claim
2039	Invalid service ID
2040	The claim or request data received by the Client Adaptor from the client system is incomplete or missing
2041	Record Sequence Number is invalid
2050	Unable to map specified PathOfObject to an existing business object
2051	The position of the business object in the hierarchy of business object types is invalid
2052	This method is not supported by the type of content you are creating
2053	Patient contribution amount must be less than total charge
2054	Date of service is inconsistent with other dates set
2055	Patient contribution amount should not be set when the account is fully paid
2056	The supplied discharge date must not be earlier than the admission date
2057	Instances of admission date, discharge date, care plan issue date or clinical condition treated reason date cannot be earlier than date of birth.
2058	Expected high level object missing
2059	The part number must be less than or equal to the part total
2060	Text for requested return code not found. Either the Medicare CA ErrorList.properties file not found or is out of date.
2064	A CID segment must be supplied
2065	A PAT segment must be supplied
2066	An EPD segment must be supplied
2067	Number of days of Palliative Care must be supplied
2068	Where ContiguousClaimCde = N or L then at least one MOR segment must be created and all conditional data elements set at least once except where PatientClassificationCode = RE
2070	The only special character allowed in ANSNAPId is a hyphen
2071	If PatientClassificationCode=PS then TotalPsychiatricCareDays must be set
2072	TotalPsychiatricCareDays must be in the format NNNNN
2073	PalliativeCareDays must be in the format NNNN
2074	NumberOfQualifiedDaysForNewborns must be in the format NNNNN
2075	NonCertifiedDaysOfStay must be in the format NNNN
2076	NumberOfHours must be in the format NNNN
2077	MultiDisciplinaryRehabPlanDate must be in the format DDMMYYYY
2078	DischargePlanDate must be in the format DDMMYYYY
2999	An error has been detected whilst executing a function within the Client Adaptor
3001	Communication error. Check that you have a current internet session. For further assistance contact the Medicare eBusiness Service Centre.
3002	The response from the central site was not received within the permitted response time.
3003	The Medicare server is not operational. Try again later. If the problem persists, contact the Medicare eBusiness Service Centre.
3004	The request cannot be dealt with at this time because real-time processing is not available or the system is down. Contact the Medicare eBusiness Service Centre for further assistance.
3005	The message format received by the Client Adaptor was not valid (PKI)
3006	The message could not be decrypted. Contact the Medicare eBusiness Service Centre for further assistance.
3007	The Client Adaptor could not decrypt the return message. Contact the Medicare eBusiness Service Centre for further assistance.
3008	The sending Location could not be identified at the Client Adaptor
3009	The Medicare signing certificate could not be found in the PSI store OR the passphrase used did not match the Individual certificate. If problem persists contact the Medicare eBusiness Service Centre.
3010	The data has been corrupted in transmission
3011	The transmission received at the Client Adaptor was not encrypted.
3012	The message received at the Client Adaptor was not signed. Messages should be signed by the sending Location.
3013	The signing Location is unknown. For further assistance contact the Medicare eBusiness Service Centre.
3014	The internal message format is invalid. Contact the Medicare eBusiness Service Centre for further assistance.
3015	The response could not be secured. Contact the Medicare eBusiness Service Centre for further assistance.
3016	The supplied location ID does not match the HCL For further assistance contact the Medicare eBusiness Service Centre. [No longer used]
3017	The transmission date is not the current date. Check the system date set in the transmitting computer.
3018	Data content of the message received by the Client Adaptor is unrecognisable
3019	Data content of the message received by the Client Adaptor is missing or exceeds the maximum allowable size
3020	The message format received at the Server was not valid (PKI). Contact the Medicare eBusiness Service Centre for further assistance.
3021	The sending Location could not be identified at the Server. Contact the Medicare eBusiness Service Centre for further assistance.
3022	The data arriving at the Server has been corrupted in transmission. Contact the Medicare eBusiness Service Centre for further assistance.
3023	The transmission arriving at the Server was not encrypted
3024	The message arriving at the Server was not signed
3025	The internal format of the message arriving at the Server is invalid. Possible cause: non standard characters in a patient's name. Contact the Medicare eBusiness Service Centre for further assistance.
3026	Data content is unrecognisable at the Server. Contact the Medicare eBusiness Service Centre for further assistance.
3027	Data content of the message arriving at the Server is missing or exceeds the maximum allowable size
3028	HTTP 1.0 response code 202 returned
3029	HTTP redirection attempted
3030	HTTP client error
3031	The server cannot fulfil this request
3032	Bad Gateway encountered
3033	Duplicate Claim IDs. More than two (2) claims have been submitted with the same Claim ID. Contact the Medicare eBusiness Service Centre for further assistance.
3034	An invalid object ID has been supplied
3035	The type of claim being transmitted or received cannot be identified
3036	The sending Location's details failed validation against the Registration File. Contact the Medicare eBusiness Service Centre for further assistance.
3037	The sending Individual's details failed validation against the Registration File. Contact the Medicare eBusiness Service Centre for further assistance.
3038	Authentication failed at proxy server. Session element AuthProxyName contains proxy name at which failure occurred. Set AuthProxyUserId and AuthProxyPasswd to provide authentication at the proxy.
3039	An error occurred during transmission to Medicare. It is unknown whether the claim was processed. Contact the Medicare eBusiness Service Centre.
3040	Health Fund system unavailable
3041	Test transmissions are not supported for this business function at this time
3042	Health Fund cannot accept this claim. Please contact the Health Fund for assistance.
3043	The TransactionId of the submitted ERA has previously been received by the HUB
3999	An undefined error was detected either preparing the transmission, during transmission or at the Medicare central site
5001	The quoted Individual Certificate RA number is registered to another individual
5002	One or more of the Professional Number Stems quoted is registered to another individual
5003	Professional Number Stem(s) must be supplied
5004	Action type must be supplied
5005	Subscription ID must be supplied
5006	Valid state code must be supplied
5007	The subscription ID supplied is not registered.
5008	The Registration already exists
5009	Name required. At least one of surname or first name must be supplied.
5010	The subscription ID supplied has been identified as in-active
5011	Update request received where existing record has old subscriber version (V1R0) . Need to be a insert request.
5201	Duplicate claim at Health Fund
5202	The Health Fund system has reached capacity
8001	No more claims exist within the report
8002	No more rows exist within the report
8003	Patient is currently ineligible for Medicare. This status can be confirmed for today only.
8004	The report requested contains too much data to be returned. Try more specific selection criteria
8005	The individual has been matched using the submitted data however differences were identified. Please check the information returned and update your records.
8006	Claim accepted however Medicare patient validation outstanding. - This return code will be deleted [LW]
8007	Membership matched. Please ask patient to contact the Fund
8008	Membership matched but provider must contact the Fund
8009	The name supplied for this individual differs from that held by Medicare. This individual only has one name. Please check the name and update your records.
8010	The request has not been completed within the allocated time frame
8011	The report contains header information only
8012	Details for a POTENTIAL match with DVA records have been returned. Please check this information with the Veteran and, if correct, update your records
8013	Veteran identification confirmed however their card type could not be determined. Please contact DVA.
8014	Claim accepted for processing. Updated information has been supplied
7001	Service Rate must be supplied.
7002	The Hospital Indicator must be set.
7003	Pre-Existing Ailment (PEA) Indicator must be supplied.
7004	The Funds' Universal Patient Identifier (UPI) must be supplied.
7006	A Service Id is missing and must be supplied.
7007	Co-payment description must be set.
7008	Excess amount description must be supplied.
7009	Claim assessment code required.
7010	Service Assessment Code must be supplied.
7011	Element Name must be supplied.
7012	Inpatient Medical Claims can process up to 50 services within one claim. Please divide the services appropriately and re-submit.
7013	Provider is not registered at the transmitting Location for IHC DVA
7014	Service Code or Item Number for IHC DVA cannot be more than 5 characters
7015	Accommodation Total must equal sum of Accommodation Charge amounts for IHC DVA
7016	Accommodation Total Days must equal sum of Accommodation Item Days for IHC DVA
7017	Accommodation Total Leave Days must equal all Leave Period Leave Days (IHC DVA)
7018	Service or Item From Date cannot precede Accomm Summary From Date (IHC DVA)
7019	Service or Item To Date cannot be later than Accom Summary To Date (IHC DVA)
7020	Please split the Item into parts with less than 99 days (IHC DVA)
7021	Total Amount must equal sum of Principle and Multiple Service Amounts (IHC DVA)
7022	Certificate cannot span calendar years. Split into calendar years (IHC DVA)
7023	Item cannot span calendar years. Split into separate calendar years (IHC DVA)
7024	IHC DVA does not support Adjustments
7025	Service or Item Charge Amounts over $99999.99 are not supported by IHC DVA
7026	DVA file number does not have a Gold or White card and may not be eligible for services. Please verify file number and resubmit claim.
7027	Public Hospitals can only claim prosthesis charges at this time.
7028	Name does not match registered name for File Number.
7029	IHC DVA does not support over 400 services or vouchers in a transmission
7030	IHC DVA can't have over 80 vouchers in a transmission. Split claim and resubmit
7031	Transmitting Location not registered for DVA. Contact eBusiness 1800 700 199
7032	The Total Charge cannot include non Hospital Charges for IHC DVA
7033	Invalid Provider Number for IHC DVA
7034	IHC DVA claims are not accepted from Public Hospitals at present
7035	Patient gender must be Male or Female for IHC DVA
7036	Service or Item From Date for IHC DVA cannot be later than the Date of Lodgement
7037	Claim Certified Ind missing (this may apply where certification details are implicitly set as part of a business object)
7038	ClaimCertifiedDate and ClaimCertifiedInd are missing
7039	ADLTransferMobilityInd is missing or invalid value has been set
7040	AcceptedDisabilityText is missing
7041	ReferralIssueDate is inconsistent with the ServiceTypeCde and/or other data elements set
7042	ReferralOverrideTypeCde is inconsistent with the ServiceTypeCde and/or other data elements set
7043	ReferringProviderNum is inconsistent with the ServiceTypeCde and/or other data elements set
7044	RequestIssueDate is inconsistent with the ServiceTypeCde and/or other data elements set
7045	RequestOverrideTypeCde is inconsistent with the ServiceTypeCde and/or other data elements set
7046	RequestingProviderNum is inconsistent with the ServiceTypeCde and/or other data elements set
7047	HospitalInd is inconsistent with the ServiceTypeCde and/or other data elements set
7048	ReferralIssueDate is prior to patient date of birth
7049	ReferralIssueDate is after the date of service
7050	RequestIssueDate is prior to patient date of birth
7051	ReferralOverrideTypeCde must be set or referral details must be set
7052	ReferralPeriod is inconsistent with the ServiceTypeCde and/or other data elements set
7055	TreatmentLocationCde is inconsistent with the ServiceTypeCde and/or other data elements set
7056	CollectionDateTime is inconsistent with the ServiceTypeCde and/or other data elements set
7057	AccessionDateTime is inconsistent with the ServiceTypeCde and/or other data elements set
7058	AccessionDateTime is earlier than RequestIssueDate
7059	ADLToiletingContinenceInd is missing or invalid value has been set
7060	AfterCareOverrideInd cannot be set when ServiceTypeCode is set as Pathology, Diagnostic or Radiotherapy
7061	DuplicateServiceOverrideInd is inconsistent with the ServiceTypeCde and/or other data elements set
7062	EquipmentId is inconsistent with the ServiceTypeCde and/or other data elements set
7063	FieldQuantity is inconsistent with the ServiceTypeCde and/or other data elements set
7064	ItemNum must be set to KM or OT80 where DistanceKms is set
7065	LSPNum is inconsistent with the ServiceTypeCde and/or other data elements set
7066	MultipleProcedureOverrideInd is inconsistent with the ServiceTypeCde and/or other data elements set
7067	NoOfPatientsSeen is inconsistent with the ServiceTypeCde and/or other data elements set
7068	Rule3ExemptInd is inconsistent with the ServiceTypeCde and/or other data elements set
7069	S4b3ExemptInd is inconsistent with the ServiceTypeCde and/or other data elements set
7070	SCPId is inconsistent with the ServiceTypeCde and/or other data elements set
7071	DistanceKms is missing
7073	DistanceKms is set where no other service exists within the voucher
7074	DistanceKms is set and the date of service is not consistent with another service item present in the same voucher
7075	DistanceKms is set with ChargeAmount
7076	ItemNum = KM and ChargeAmount has been set
7077	ItemNum = KM, DistanceKms and ChargeAmount have all been set
7078	ItemNum is set to KM or OT80 but DistanceKms has not been set
7079	DistanceKms is set and ItemNum = KM has not been set
7080	NumberOfServices is inconsistent with the ServiceTypeCde and/or other data elements set
7081	ADLPersonalHygieneInd is missing or invalid value has been set
7082	NumberOfServices is not a valid value
7087	ADLEatingInd is missing or invalid value has been set
7088	ADLCognitiveBehaviouralInd is missing or invalid value has been set
7093	NoOfPatientsSeen is not a valid value for TreatmentLocationCde
7094	RequestIssueDate a future date
7095	DateOfService is in an invalid value
7096	ADLTool is missing or invalid value has been set
7097	LivesAloneInd is missing or invalid value has been set
7098	CarerInd is missing or invalid value has been set
7099	BreakInEpisodeOfCare is missing or invalid value has been set
7100	RestrictiveOverrideCde can only be set when ClaimTypeCde is set to PC
9001	The Location is not authorised to undertake Online Claiming transactions. The transmission has been rejected. Contact the Medicare eBusiness Service Centre for further assistance.
9002	The individual signing the claim or making the request is not authorised to undertake Online Claiming transactions. The claim has been rejected. Contact the Medicare eBusiness Service Centre for further assistance.
9003	The provider is identified as inactive for Online Claiming purposes. Contact the PKI Customer Service Centre for assistance.
9004	Only test transmissions are acceptable from this location at this time. Contact the Medicare eBusiness Service Centre for further assistance.
9005	The signature (HCI) is not that of the Servicing Provider
9006	The Provider is not authorised to participate in Online Claiming. Contact the Medicare eBusiness Service Centre for further assistance.
9007	The Location is not authorised to undertake the function on the date of transmission. The transmission has been rejected. Contact the Medicare eBusiness Service Centre for further assistance.
9008	Claims from this provider must be signed using their Individual Certificate
9009	This transaction type is not permitted from this type of client
9010	The software product used to create the transaction is not certified for this function. Contact the Medicare eBusiness Service Centre for further assistance
9011	Billing Agent is not recognised as belonging to the transmitting Location
9012	The intended recipient is unable to accept this content type at this time
9013	Hospitals can only submit eligibility checks relating to their hospital
9014	The requestor is identified as a Billing Agent. Billing Agents can only submit eligibility checks using their Billing Agent identifier
9015	StartDateBreakInEpisode is missing or invalid value has been set
9016	StartDateBreakInEpisode cannot be set where BreakInEpisodeOfCare is set to 4 or 5
9017	EndDateBreakInEpisode must be set where BreakInEpisodeOfCare is set to 1, 2 or 3
9018	EndDateBreakInEpisode is missing or invalid value has been set
9019	NumberOfCNCVisits is missing or invalid value has been set
9020	NumberOfRNVisits is missing or invalid value has been set
9021	NumberOfENVisits is missing or invalid value has been set
9022	NumberOfNSSVisits is missing or invalid value has been set
9023	NumberOfCNCHours is missing or invalid value has been set
9024	NumberOfRNHours is missing or invalid value has been set
9025	NumberOfENHours is missing or invalid value has been set
9026	NumberOfNSSHours is missing or invalid value has been set
9027	Community Nursing Minimum Data Set elements cannot be set unless ServiceTypeCde is set to F
9028	StartDateBreakInEpisode must be before or equal to EndDateBreakInEpisode
9029	ClaimCertifiedInd must be set to Y to submit the claim
9030	EndDateBreakInEpisode cannot be set where BreakInEpisodeOfCare is set to 4 or 5
9101	Invalid Passphrase. The Passphrase entered does not match the passphrase for this Location certificate.
9102	The Location Certificate (HCL) has expired. Contact the Registration Authority.
9103	The token relating to the individual certificate could not be found
9104	The Individual Certificate (HCI) has expired
9105	Invalid certificate type. The certificate type is either location or individual
9106	Could not change passphrase. Ensure original passphrase entered is correct, the new passphrase differs from the old passphrase and that the new passphrase conforms to passphrase requirements.
9107	The private keys specified could not be imported. Please check the input filenames. If the problem persists call the Medicare eBusiness Service Centre
9108	The Medicare Public Certificates could not be imported. Please check the input filenames. If the problem persists call the Medicare eBusiness Service Centre.
9109	One or more of the specified files could not be accessed. Please ensure the filenames are correct, and you have read access to them
9110	Could not create one or more destination files. Please ensure you have write access to the destination directory and sufficient space available
9111	If createCryptoStore - a PSI Store already exists in the nominated folder. Otherwise a problem has been encountered using PKI services. Repeating the function call should be successful
9112	Location signing Certificate not found in the PSI Store.
9113	Individual signature not required
9114	Individual signature is optional
9115	The Location Certificate used has been revoked by the Registration Authority. Please contact the PKI Customer Service Centre
9116	The Location Certificate used differs from the Certificate recorded for this Location. Contact the Medicare eBusiness Service Centre for assistance.
9117	The Location Certificate used cannot be used for the requested function. Contact the Medicare eBusiness Service Centre for assistance.
9118	The Location has been identified as inactive. Contact the Medicare eBusiness Service Centre for assistance.
9119	The provider is identified as inactive for Online Claiming purposes. Contact the PKI Customer Service Centre for assistance.
9120	The Individual Certificate used has been revoked by the Registration Authority. Contact PKI Customer Service Centre for assistance.
9121	Desecure failure at Medicare. Contact the PKI Customer Service Centre for assistance
9122	Location Id missing from transmission
9123	The HCL Certificate used to sign the transmission is not the Certificate currently registered against the Location Id
9124	Unable to determine the Location Id from the submitted data. Please contact the Medicare eBusiness Service Centre for assistance.
9125	Cannot register Location based on transaction type
9126	No current Location Certificate exists in the nominated PSI Store
9127	Requested Location Encryption Certificate not found in the PSI Store
9128	MultipleProcedureOverrideInd is an invalid value
9129	NoOfPatientsSeen is not a valid value
9130	NumberOfPatientsSeen cannot be set when MultipleProcedureOverrideInd is set
9131	NumberOfPatientsSeen is not a valid value if the RequestOverrideTypeCde is set
9132	Rule3ExemptInd is an invalid value
9133	S4b3ExemptInd/S4B3ExemptInd is an invalid value
9134	SCPId is an invalid value
9135	ServiceId is an invalid value
9136	TimeOfService is an invalid value
9137	DateOfService is a date in the future
9138	AccessionDateTime is earlier than RequestIssueDate
9139	CollectionDateTime is later than RequestIssueDate
9140	SelfDeemedCde is an invalid value
9141	SelfDeemedCde is inconsistent with the ServiceTypeCde and/or other data elements set
9142	The value in the Restrictive Override Code is invalid, please check and resubmit your claim
9144	TimeOfService must be set if either DuplicateServiceOverrideInd or MultipleProcedureOverrideInd or both are set to Y
9145	DistanceKMS is inconsistent with ServiceTypeCde and/or can't be set with MultipleProcedureOverrideInd, DuplicateServiceOverrideInd, Rule3ExemptedInd, S4B3ExemptInd, TimeOfService, SCPId, CollectionDateTime, AccessionDateTime,FieldQuantity,LSPNum,EquipmentId
9146	AuthorisationDate is missing
9147	DistanceKMs cannot be set when TreatmentLocationCde is set to R
9193	CollectionDateTime is earlier than RequestIssueDate
9201	Invalid format for data item
9202	Invalid value for data item. The data element does not comply with the values permitted or has failed a check digit check.
9203	Date of service must be no more than 2 years in the past
9204	Date in future. The date supplied must not be in the future
9205	Requested data item is empty.
9206	Date must be in the future. The date supplied is expected to be a future date
9207	An item cannot be self deemed or substituted when a referral or request override has been set
9208	Date supplied too old
9209	Date supplied is greater than 12 months in the future
9210	Date of service must be no more than two years in the past
9211	Future date-time. Date-time cannot be in the future
9212	ServiceId is not set
9214	Transaction Id not a valid value
9215	Authorisation date is an invalid value (this may apply where Authorisation date is explicitly set)
9217	Authorisation date is a date in the future
9218	Authorisation date more than 2 years past
9219	VeteranFileNum is a mandatory field and must be provided
9220	Payee Provider Number is not a valid value
9340	Transmission time missing or invalid
9221	Claim Certified Ind not a valid value (this may apply where Authorisation date explicitly set)
9222	Claim Certified date is an invalid format. (this may apply where Authorisation date explicitly set)
9223	Claim Certified date is an invalid value. (this may apply where Authorisation date explicitly set)
9224	Claim Certified date must not be a future date (this may apply where Authorisation date explicitly set)
9225	Claim Certified date more than 2 years past
9226	PatientDateOfBirth more than 130 years ago
9227	PatientDateOfBirth is later than Date of Service
9228	AcceptedDisabilityInd is an invalid value
9229	AcceptedDisabilityText set but AcceptedDisabilityInd not set to Y
9230	AcceptedDisabilityText is an invalid value
9232	PatientAddressPostcode is an invalid value
9233	PatientAliasFamilyName is an invalid value
9234	PatientAliasFirstName is an invalid value
9236	PatientFamilyName is an invalid value
9237	PatientFirstName is an invalid value
9244	PatientAddressLocality is an invalid value
9245	PatientAddressPostcode is an invalid value
9246	PatientDateOfBirth is an invalid value
9247	PatientGender is an invalid value
9248	ReferralIssueDate is an invalid value
9249	ReferralPeriodTypeCde is an invalid value
9250	ReferralOverrideTypeCde is an invalid value
9251	ReferringProviderNum is an invalid value
9252	RequestingProviderNum is an invalid value
9253	RequestIssueDate is an invalid value
9254	RequestOverrideTypeCde is an invalid value
9255	ServiceTypeCde is an invalid value
9256	ServicingProviderNum is an invalid value
9257	HospitalInd is an invalid value
9258	VeteranFileNum is an invalid value
9259	VoucherId is an invalid value
9260	PatientDateOfBirth in the future
9263	ReferralPeriod is an invalid value
9270	HospitalInd is not a valid value for TreatmentLocationCde
9271	TreatmentLocationCde is an invalid value
9273	AccessionDateTime is a future date-time
9274	CollectionDateTime is a date-time in the future
9275	AccessionDateTime is an invalid value
9277	AfterCareOverrideInd is an invalid value
9278	ChargeAmount cannot be set where DistanceKms is set
9279	PatientDateOfBirth is an invalid value
9280	ReferralIssueDate is an invalid value
9283	RequestIssueDate is an invalid value
9286	TimeOfService is an invalid value
9288	ServiceText is an invalid value
9290	AccountReferenceNum is an invalid value
9291	ChargeAmount is an invalid value
9292	CollectionDateTime is an invalid value
9293	DateOfService is an invalid value
9294	DistanceKms is an invalid value
9295	DuplicateServiceOverrideInd is an invalid value
9296	EquipmentId is an invalid value
9297	FieldQuantity is an invalid value
9298	ItemNum is an invalid value
9299	LSPNum is an invalid value
9301	Patient's Medicare card number must be supplied
9302	Patient's reference number must be supplied
9303	Patient's first name must be supplied
9304	Patient's family name must be supplied
9305	Servicing Practitioner's Provider Number must be supplied
9306	Date of service must be supplied
9307	An item number must be supplied for each service
9308	Referring Practitioner's Provider Number must be supplied
9309	Referral issue date must be supplied, and must be prior to, or the same as, the date of the medical service, cannot be before the date of birth, nor after the referral start date
9310	Requesting Practitioner's Provider Number must be supplied
9311	Request issue date must be supplied, and must be prior to, or the same as, the date of the medical service and cannot be before the date of birth
9312	Claimant first name, family name, date of birth, claimant Medicare card number and reference number must be supplied. If any one data element is supplied, then all five (5) must be supplied.
9313	Patient/Claimant address line 1 must be supplied or all claimant address elements removed.
9314	Patient/Claimant locality must be supplied or all claimant address elements removed
9315	Patient/Claimant postcode must be supplied or all claimant address elements removed
9316	The Referring/Requesting Provider cannot be the Servicing or Principal Provider
9317	Account payment status required. Must be paid or unpaid.
9318	Non standard referral has been set without the referral period
9319	Date of lodgement not supplied
9320	Time of lodgement not supplied
9321	Location ID not supplied
9322	Referral period details must be supplied
9323	Incomplete banking details. BSB code, account number and account name must all be supplied.
9324	Claim ID not supplied or invalid
9325	Service type not supplied
9326	At least one voucher must be included in the claim
9327	Claim type must be consistent with the transmission type set by the createTransmission function
9328	The maximum number of contents allowable in this transmission has been reached
9329	The data element being set is not relevant to this claim type
9330	The data appears to be other than a stored patient claim
9331	The data appears to be other than a stored bulk bill claim.
9332	Voucher must contain at least one (1) service
9333	Assignment/submission authorisation not supplied
9335	Bank account details supplied for unpaid claim
9336	Hospital details must be supplied in the text field
9337	At least one service in the voucher must have a non zero charge amount
9338	A required charge amount has not been supplied or is inconsistent with other data supplied.
9339	Transmission date missing or invalid
9341	More information required. Either text must be keyed against a service or a time supplied for the voucher.
9342	The Payee Practitioner supplied is the same as the Servicing Provider. If both are the same, only one of the Servicing Provider should be completed
9343	Veterans File Number/patient details incomplete
9345	Patient's Date of Birth not supplied
9346	Patient's gender not supplied
9347	Request type code must be set when a request exists
9348	Batch Identifier missing or invalid
9349	Immunisation Date invalid or missing
9350	Next Due Date for immunisation invalid or missing
9351	Medicare Card Issue Number missing or invalid
9352	Provider Child ID missing or invalid
9353	Information Provider Number missing or invalid
9354	ATSI Indicator missing
9355	Contact phone number missing or invalid
9356	Vaccine code missing or invalid
9357	Vaccine dose missing or invalid
9358	Clinic Code missing or invalid
9359	Vaccine Batch Number missing or invalid
9360	HepB Birth Dose Flag invalid or missing
9361	Encounter details do not contain an allowable combination of the minimum required fields
9362	The encounter must contain at least one (1) episode
9363	Encounter already contains equivalent antigen(s)
9364	Patient information provided is insufficient
9365	Referral period or referral date to must be supplied
9366	Referral Date From must be supplied
9367	Referral Date From is later than Referral Date To
9368	Hep B Birth Dose Date is prior to Patient's Birth Date or prior to 1 January
9369	The patient Fund membership number must be supplied
9370	The Fund brand Id must be supplied
9371	OPV type must be supplied
9372	The claim type for the claim must be supplied
9373	Discharge date supplied therefore admission date must also be supplied
9374	Both product name and version must be supplied
9375	All vouchers within the claim must have the same service type code
9376	Facility Id or Treatment Location Provider Number must be supplied
9378	Claim Type has been identified as an Agreement, the Facility Identifier must also be supplied
9379	Claim Type has been identified as an Agreement, Informed Financial Consent must also have been identified as being verbally given or supplied in writing for the patient or indicated as not obtained
9380	Claim Type has been identified as a Gap Cover scheme, Informed Financial Consent must also be identified as being supplied in writing for the patient or indicated as not obtained
9381	Claim Type has been identified as a Gap Cover Scheme, Financial Interest Disclosure must have been given
9382	Conflicting selection criteria supplied. When TransactionId supplied no other criteria can be supplied.
9383	If either ReceivedFromDateTime or ReceivedToDateTime set both must be set
9384	ReceivedFromDateTime must be prior or equal to ReceivedToDateTime
9385	RequestContentType must be supplied
9386	Maximum request period cannot exceed 31 days
9387	Request must specify either one or more transaction Ids or a received date time range
9388	Request must specify one or more Transaction Ids
9389	The account reference Id must be supplied
9390	The Billing Agent Id must be supplied
9391	Payer name, payment run date, payment reference, deposit amount, payee Location Id, part number and part total must be supplied
9392	Benefit amount, Date of lodgement and Account Reference Id must be supplied for each claim
9393	The Transaction Id must be supplied for each claim where the claim channel code is SB3 or SB4
9394	The number of items exceeds the maximum allowable for this content type
9395	Fund claim explanation code must be supplied as the claim has been rejected by the Fund
9396	Incomplete data in outbound transmission
9397	Principal Provider Number must be supplied
9398	OEC type must be supplied
9399	Accident indicator must be supplied
9400	Length of stay must be supplied and cannot exceed the number of days from the date of admission to date of discharge inclusive.
9401	Presenting Illness Code must be supplied.
9402	Same day indicator / code must be supplied.
9403	Admission date must be supplied
9404	Date of admission and date of discharge must be consistent for all vouchers
9405	FundReferenceId must be supplied
9406	Table name, description and scale must be supplied
9407	The financial status of the member must be supplied
9408	Benefit must be supplied for each service
9409	Fund explanation code and explanation text must be supplied
9410	If service explanation code or service explanation text is supplied both must be supplied
9411	The compensation claim indicator must be consistent across all vouchers within the claim
9412	Collection date time and accession date time must be supplied for all services in the voucher where S4B3 exemption is indicated against any service in the voucher
9413	Collection date time must be prior to accession. Date of service must be on or after the date of accession. Collection date must be on or after date of birth and the date of the request.
9414	If collection date time or accession date time is present both must be present
9415	Date of service cannot be prior to the accident date
9416	The service must have been rendered in hospital where S4B3 exemption is indicated against the service
9417	Service must have been requested, self deemed or a request override set
9418	Payee Provider Number must be supplied
9419	Both the concomitant provider number and role must be set. The concomitant provider can only undertake a single role and cannot be the servicing provider.
9420	The Servicing provider must be the same for all vouchers within the claim
9421	Benefit assignment authorisation details must be supplied or are incomplete
9422	Clinical condition information missing or incomplete
9423	Clinical indicators, request/referral details and/or results and related information is missing or incomplete
9424	Health Care Plan details (type, issue date) incomplete
9425	Dates of service within the voucher must be consistent
9426	Check KMs. Only one km entry permitted per voucher and the voucher must contain another item with the same Date of Service.
9427	Service start date must be on or after the patient’s date of birth and on or before the date of service and service end date.
9428	The service end date must be on or after the date of service and the service start date and supplied where number of services is greater than one.
9429	When duplicate service override requested or supporting details supplied both must be present
9430	When multiple procedure override requested or supporting details supplied both must be present
9431	The original procedure date must be on or after the patient’s date of birth and on or before the date of service
9432	Item start date-time must be supplied. It must be on or after the patient’s date of birth and the Date of Service, and prior to the Item End Date Time.
9433	Item end date-time must be supplied. It must be on or after the date of service and after Item Start Date Time
9434	Time in future. The date and time supplied must not be in the future.
9435	Time of service must be set against all items within the voucher if set against any item within the voucher, except where DistanceKms is set
9436	Anaesthetic type code must be supplied
9437	When AfterCareOverrideInd or AfterCareExplanationText present both must be present. Both may be present when AfterCareApportionedPercentage or AfterCareProviderNum present
9438	Aftercare provider number required and must not be the same as the servicing provider.
9439	Either the service has been flagged as having been self deemed or the reason for the service being self deemed has been supplied. If one is present both must be present.
9440	The appliance order date must be greater than or equal to the patient’s date of birth and equal to or less than the date of service and delivery date. Supporting details must be supplied where an appliance has been ordered.
9441	When intensive care override requested or supporting details supplied both must be present
9442	A service cannot be substituted without request details also being present
9443	Original procedure details (date, item number and supporting details) are missing or incomplete
9444	Anatomical details (region and description) are missing or incomplete
9445	Where item is set to KM or the distance travelled is stated, both must be present without a charge amount
9446	Fund Payee Id must be consistent across all vouchers.
9447	A Segment Identifier is missing or invalid
9448	A TFR segment must be supplied
9449	ACS segment must be supplied and can only be supplied, if any of ACD, CCG or LPD segments are also supplied
9450	Leave period must be supplied when the leave days indicated in the Accommodation Summary is greater than 0
9451	A PSG segment must be supplied
9452	An MSG segment must be supplied
9453	A DMG or PSG segment must be supplied
9454	A DMG segment must be supplied
9455	A MED segment must be supplied
9456	Urgency code must be supplied
9457	Compensation code must be supplied
9458	Contiguous claim code must be supplied
9459	Facility Type Code must be supplied
9460	Transaction Id of claim to be adjusted must be supplied.
9461	Patients’ Medical record number must be supplied
9462	Patient Admission Weight can only be set if the patient is less than 365 days old.
9463	Accommodation status must be supplied
9464	Facility Contract Status Code must be supplied.
9465	Episode Id must be supplied
9466	Episode Type Code must be supplied
9467	Patient Classification Code must be supplied
9468	Referral Source Code must be supplied
9469	Charge Raised Code must be supplied
9470	Service Code must be supplied
9471	Service Code Type Code must be supplied
9472	From Date is either missing or after To Date
9473	ANB segments must contain Baby Date of Birth, Family Name, First Name, Gender and Number.
9474	Transfer Code must be supplied
9475	Accommodation Day must be supplied
9476	To Date must be supplied
9477	Number Of Days must be supplied
9478	Leave Days must be supplied
9479	An ACD Segment must contain Bed Level Add On Indicator and Bed Level Code
9480	Day Rate must be supplied
9482	A CCG segment must contain a Critical Care Type Code and Critical Care Add On Indicator must be set.
9483	Service Time must be set for all PSG segments with the same Date of Service.
9484	A TRG segment must contain Distance Kms, Transport Hours Minutes, From Locality, To Locality, Start Time and Transport TypeCode.
9485	An MIG segment must contain both a Service Quantity and Service Rate.
9486	Principal Diagnosis must be supplied
9487	Ventilation Hours Minutes must be supplied
9488	Only 49 secondary diagnosis and 50 procedures can be set within a DMG segment.
9489	Casemix Code Type Code must be supplied
9490	Issue Date must be supplied
9491	Certificate Type Code must be supplied
9492	Text must be supplied
9493	Either CertifyingProviderNum or CertifyingProviderName must be supplied
9494	Admission time must be supplied.
9495	Previous Transaction Id and Previous Account Reference cannot be set when Claim Channel Code is SB3 or SB4.
9496	Benefit Amount cannot be negative when Claim Channel Code is SB3 or SB4.
9497	Either Presenting Illness Item Number or Presenting Illness Code must be set, but not both.
9498	Cannot submit fully paid accounts for this claim type.
9499	Service Quantity must be supplied.
9500	Patient Admission Weight must be set if the patient is less than 365 days old
9501	A submission response report is available
9502	Multiple reports are included in the response
9503	More reports meeting the criteria are available for retrieval
9504	More rows for this report are available for retrieval
9601	The claim needs to be referred to a Medicare Customer Services Officer for further assessment. The claim will be processed and payment notification will be sent in the near future.
9602	This claim cannot be lodged through Medicare Easyclaim. Please submit the claim via an alternative Medicare claiming channel.
9603	Check location. The location entered for the address is invalid.
9604	Check bank account name. The name supplied is not a valid account name.
9605	Another Medicare Card may have been issued to the patient or the details you entered do not match those held by Medicare. Please update your records and resubmit the claim.
9606	Another Medicare Card may have been issued to the claimant or the details you entered do not match those held by Medicare. Please update your records and resubmit the claim.
9607	This item is only claimable via Bulk Bill
9608	The service requires confirmation that an operative procedure from groups 03 - 09 has been performed subsequent to the attendance.
9609	Time (duration) required for the item
9610	Equipment number required
9611	Check item. The item claimed is either unknown or invalid at the date of service. Eg Misc, incorrect alpha included
9612	This service is normally only performed in a hospital
9613	This service cannot be performed in hospital
9614	Check bank account number
9615	An error has been detected with the address
9616	The BSB supplied is invalid, unknown or cannot be used for Medicare payments
9617	The referral has expired
9618	Either an amount has not been entered in the charge field or an invalid amount has been entered.
9619	Check postcode and locality. This is not a recognised combination OR a PO Box type locality has been entered.
9620	The radiotherapy service performed is not payable using the equipment number
9621	The pathology, diagnostic imaging or specialist service cannot be self determined or the Practitioner cannot self deem
9622	The attendance item must contain the number of patients seen
9623	Payee Provider cannot be used with an assistant surgeon item ( 513000 or 51303 ) or an assistance anaesthetist item ( 17500 )
9624	A subsequent consultation has been keyed and the date of service is after the referral expiry date
9625	Claimant address needs to be updated with Medicare, Issue account/receipt for the claimant to submit via an alternative Medicare claiming channel.
9626	The patient is or was covered under the Reciprocal Health Care Agreement
9627	Check date of service
9628	Referral or request required
9629	Check item and patient
9630	Please check the request or referral details
9631	Check if service self deemed
9632	Duplicate of service already paid. If not duplicate resubmit with appropriate indication.
9633	A new Medicare card has been issued. Please update your records and ask the patient to use the new card number for any future claims.
9634	A new Medicare card has been issued. Please update your records and ask the claimant to use the new card number for any future claims.
9635	Check Servicing Provider. May not be able to provide the service for this item at date of service
9636	Check Payee Provider
9637	More information is required. Service text or other information is required to support this service.
9638	Claimant details required. Patient or quoted claimant is a minor.
9639	PO Boxes are not an acceptable address type for this claiming method.
9640	The benefit assessed for this claim exceeds the review threshold. While no assessing errors have been detected, the claim needs to be reviewed by a Medicare operator.
9641	A restrictive condition exists
9642	DVA Pathology not supported in this release.
9643	Check claimant name
9644	Mix of in hospital and out of hospital services are not permitted
9645	The claim identified for deletion has a status other than Paid Same Day
9646	The claim could not be located by Medicare.
9647	The claim has already been deleted by Medicare.
9648	The Reason Code for requesting Same Day Delete is missing or invalid
9649	Patient's eligibility cannot be determined
9650	The patient data supplied failed validation checks against Medicare data.
9651	The transmission Id supplied is not valid
9652	Enter either all address details or no address details for the claimant
9653	Multiple claims have been identified at the Medicare Central Site matching this deletion request. Please contact the Medicare eBusiness Service Centre to delete the correct claim.
9654	Mixed LSPNs within a voucher are not allowed
9655	An LSPN is required
9656	An LSPN is invalid
9657	LSPN not recognised
9658	LSPN not valid at date of service
9659	SCP Invalid
9660	This item cannot be used as a substituted service
9661	This provider cannot substitute services
9662	Provider must contact Fund
9663	Check Fund and Membership Card details
9664	Check Patient details. If correct, check Fund and Membership Card. If correct, the name known to the Fund may differ from that held by Medicare OR Patient Unique Identifier has not been supplied (if applicable to Fund).
9665	Cannot uniquely identify Patient from information supplied
9666	Patient must contact Fund
9667	Health Fund Membership cover suspended or cancelled
9668	Medical claims are not covered for this patient. Patient must contact Fund
9669	Membership details matched however claims for the patient cannot be submitted using this channel at this time. Patient to contact Fund
9670	Claim type identified cannot be submitted through this channel at this time. Please submit claim through another channel.
9671	The Health Fund identified does not currently accept transmissions through this channel
4002	Bulk-billing printed manually
9672	Your Fund information is out of date. Please update your Fund list and resubmit.
9673	Fund registration record is incomplete or needs correction. Please contact the Medicare eBusiness Service Centre for assistance.
9674	Fund patient validation not undertaken as the Medicare validation was unsuccessful
9675	Current Medicare card has expired. Patient must contact Medicare as claims using this Medicare card may be rejected.
9676	The equipment required for this service is not registered for the LSPN provided
9677	The equipment used for this service has exceeded the required equipment age
9678	The service is not payable as an appropriate associated service is not present
9679	The content type specified does not match the actual type of the specified Transaction Id
9680	Claim assessment code is invalid for this claim
9681	Item only payable if the Servicing Provider is in RRMA 3 - 7, Tasmania or in an eligible SSD
9682	Medicare cannot assess the request due to a system limitation. Please contact the ebusiness service centre to discuss.
9683	Medicare cannot assess this request due to a system limitation. Please check patient details and then contact the Medicare eBusiness Service Centre should assistance be required.
9684	The unique patient identifier supplied was not valid for this membership. Check the patients fund membership card for the correct patient identifier.
9685	A concessional entitlement has not been found for this patient
9686	Baby not known at Fund.
9687	EFT details are not registered at this fund for this provider or Facility. Fund must be contacted before further claims are submitted.
9688	An Admission / Discharge Date can only be supplied for services flagged as being performed in a Hospital.
9689	Services relating to the specified Service Type Code can only be submitted for a single patient per claim / request.
9690	Only Medicare can handle MBS items and Medicare can only handle MBS items.
9692	An Item Number must be supplied for every MBS service.
9694	The referral period type must be identified.
9695	Fund does not perform OEC with prosthetics or miscellaneous items at this time.
9696	For IMC, set both ClaimId and ClaimChannelCde. For IHC or OVS, set neither.
9698	Service is possible aftercare, check the account and resubmit with a valid indicator if not normal aftercare
9699	Item not covered for this patient at this date of service
9700	An incorrect item number appears to have been used/amount claimed does not match item number
9701	The maximum number of services for this item have been paid, if this service is not a duplicate please resend with correct item numbers as per MBS
9702	A base item has not been entered or should be entered first. Please re-submit claim with correct sequence.
9703	Item number used can not be claimed for this Provider. Check details of service and re-submit with appropriate item.
9704	This service appears to have been previously claimed. Please contact Medicare if you wish to discuss.
9705	In some instances where two or more services are performed together, they are claimable under one item number. Please check the MBS for correct item and re-submit. If exceptional circumstances exist, please issue account/receipt notating reasons.
9706	This item requires a specific notation of the relevant condition. Please check the MBS and resubmit via an alternative Medicare claiming channel.
9707	This claim needs to be referred to a Medicare Customer Services Officer for further assessment. Please issue claimant with an account/receipt to claim via an alternative Medicare claiming channel.
9708	Equipment number entered does not appear to be registered with Medicare, correct details and re-submit or contact Medicare.
9709	An age restriction applies to this item. Please check the MBS to verify item specifics.
9710	This item number has specific restrictions. Please refer to the MBS and ensure you are entering the correct patient details.
9711	This claim requires further assessment by a Medicare Customer Services Officer. Please issue claimant with an account/receipt to claim via an alternative Medicare claiming channel.
9712	The item number claimed and an override code used cannot be used together. Please resubmit the claim or contact Medicare for assistance.
9723	ToothNum is an invalid value
9725	UpperLowerJaw is an invalid value
9728	NumberOfTeeth is an invalid value
9742	SecondDeviceIdentifier is an invalid value
9743	SecondDeviceIdentifier is missing
9744	OpticalScript is an invalid value
9745	OpticalScript is missing
9754	ReferralPeriodTypeCde is inconsistent with the ServiceTypeCde and or/other data elements set
9755	AdmisssionDate must be greater than or equal to the PatientDateOfBirth
9756	DischargeDate must be greater than or equal to the AdmissionDate
9757	AdmissionDate not set
9759	TimeDuration is missing
9761	TimeDuration is an invalid value
9762	AdmissionDate must be a valid date
9763	DischargeDate must be a valid date
9764	DischargeDate must be greater than or equal to the PatientDateOfBirth
9765	Site Not Accredited for this service
9766	TimeOfService must be set if either DuplicateServiceOverrideInd and / or MultipleProcedureOverrideInd and / or Rule3ExemptInd are set to Y.
9768	Authorisation date is invalid or missing
9767	Claim Certified date is an invalid value (this may apply where Authorisation date explicitly set)
9769	VoucherId is missing
9770	PatientSecondInitial is an invalid value
9771	ChargeAmount cannot be set where ServiceTypeCde = F
9772	ReferralOverrideTypeCde cannot be present where ServiceTypeCde is set to F or K
9773	ChargeAmount cannot be claimed for item number OT80
9775	Invalid Transaction Id
9776	Maximum number of Transactions cannot exceed 500
9777	Duplicate Transaction Id
9778	ReferringProviderNum and ReferralIssueDate must both be set when ServiceTypeCde is set to F ( Community Nursing ) or K ( Clinical Psych )
9999	An indeterminate error has been detected
4001	Private invoice printed manually
4003	Bulk-billing online waiting to be assigned to a claim
4004	Bulk-billing assigned to claim
4005	Private billing awaiting transmission
4006	No invoice-level error code: see item status
4007	No invoice-level error code: see claim status
4008	Claim awaiting transmission
4009	Python layer exception on bulk-billing
4010	Bulk-bill claim transmitted no result yet
4011	Error code 9501 but no report provided
4012	Python layer exception on private billing
101	More details of service required to assess benefit                      
102	No amount charged is shown on account/receipt                           
103	Letter of explanation is being sent separately                          
104	Balance of benefit due to claimant                                      
105	Benefit paid to provider as requested                                   
106	Servicing provider unable to be identified                              
107	Benefit paid on item number other than that claimed                     
108	Benefit is not payable for the service claimed                          
111	No benefit payable - claims/s over 2 years old                          
113	Total charge shown on account apportioned over all items                
115	Benefit recommended for this item                                       
117	Benefit not recommended for this item                                   
120	Age restriction applies to this item                                    
122	Associated referral/request line not required                           
123	Benefit paid on radiology item other than service claimed               
124	Item is restricted to persons of opposite sex to patient                
125	Not payable without associated operation/anaesthetic item               
126	Service is not payable without radiology service                        
127	Maximum number of additional fields already paid  s                     
128	Benefit paid on associated fracture/amputation item                     
129	Service is not payable without the base item/s                          
130	Letter of explanation is being sent separately                          
131	Date of service not supplied/invalid                                    
134	Single course of treatment paid as subsequent attendance                
135	Provider not a consultant physician - specialist rate paid              
136	Referral details not supplied- paid at g.p. rate                        
137	Details of requesting provider not shown on account/receipt             
138	Benefit only payable when self-determined/deemed necessary              
139	Approved pathologist should not use this item number                    
140	Non-specialist provider                                                 
141	No benefit payable for services performed by this provider              
142	Letter of explanation is being sent separately                          
144	Claim benefit not paid - further assessment required                    
150	Member has not supplied details to permit claim payment                 
151	Associated service already paid-adjustment being processed              
154	Diagnostic imaging multiple service rule applied to service             
155	Letter of explanation is being sent separately                          
157	Service possibly aftercare - refer to provider                          
158	Benefit paid on associated abandoned surgery/anae item                  
159	Item associated with other service on which benefit payable             
160	Maximum number of services for this item already paid                   
161	Adjustment to benefit previously paid                                   
162	Benefit has been previously paid for this service                       
163	Surgical/anaesthetic item/s already paid for this date                  
164	Assistant surgeon benefit not payable                                   
166	Letter of explanation is being sent separately                          
168	Not payable without associated operation/anaesthetic item               
169	Operation/anaesthetic item not claimed                                  
170	Assistant anaesthetic benefit not payable                               
171	Benefit not payable - provider may only act in one capacity             
173	Patient episode coning - maximum number of services paid                
174	Patient episode coning adjustment                                       
175	Benefit paid on associated foetal intervention item                     
176	Pay each foetal intervention item as a separate item                    
177	Foetal intervention item paid using derived fee item                    
179	Benefit not payable - associated service already paid                   
184	Benefit paid for additional time item using a derived fee               
194	Letter of explanation is being sent separately                          
195	Letter of explanation is being sent separately                          
206	Item number does not attract a benefit at date of service               
208	Cardnumber used has expired                                             
209	Claimants name stated is different to that on cardnumber                
211	Patient not covered by this cardnumber at date of service               
212	Date of service used is in the future                                   
214	Claim form not complete                                                 
215	Service claimed prior 1 february 1984                                   
217	Patient cannot be identified from information supplied                  
222	Benefit paid on associated anaesthetic item                             
223	Service not payable - specified item not claimed or present             
225	Patient contribution substantiated-additional benefit paid              
226	Date of service is prior to patients date of birth                      
227	Date of service prior to date eligible for medicare benefit             
228	Date of service after benefit period for overseas visitor               
229	Benefit paid at 100% of schedule fee                                    
230	Combination of 85% and 100% of schedule fee paid                        
232	Service claimed not covered by medicare                                 
233	Provider not entitled to medicare benefit at date of service            
234	Letter of explanation is being sent separately                          
236	Letter of explanation is being sent separately                          
237	Letter of explanation is being sent separately                          
238	Not paid because all associated services rejected                       
240	Gap adjustment to benefit previously paid                               
241	Total charge and benefit for multiple procedure                         
242	Service is part of a multiple procedure                                 
243	Apportioned charge and total benefit for multiple procedure             
244	Benefit not paid - service line in error                                
245	Benefit paid on service other than that claimed                         
246	Patient cannot be identified from information supplied                  
250	Explanation/voucher will be forwarded separately                        
251	Details of requesting provider not supplied                             
252	Service possibly aftercare                                              
253	Radiotherapy assessed with other item number on statement               
254	Assessment incomplete - further advice will follow                      
255	Benefit assigned has been increased                                     
256	Benefit not payable on this service for a hospital patient              
260	Benefit assessed with associated item on statement                      
261	Associated surgical items/anaesthetic time not supplied                 
262	Insufficient prolonged anaesthetic time - service not paid              
264	Benefit not payable - compensation/damages service                      
265	Service not covered by reciprocal health care agreement                 
267	Service not payable - associated service not present                    
271	Not payable without associated ophthalmological item                    
272	Benefit paid on associated ophthalmological item                        
274	Provisional payment                                                     
280	Cannot identify service. resubmit with correct mbs item                 
282	Date of service outside of referral/request period                      
306	Card# not valid at date of service-future claims may reject             
307	Claim not paid - cardnumber not valid for date of service               
308	Ivf service - conditions not met - no benefit payable                   
316	Benefit not payable - item cannot be self-determined                    
317	Benefit not payable - additional item to those requested                
320	Quoted medicare cardnumber is incorrect                                 
322	Provider not approved for this medicare pathology benefit               
325	Laboratory not accredited for benefits for this service                 
326	Laboratory not accredited for benefits at date of service               
328	Benefit paid on associated tomography item                              
329	Not payable without associated tomography item                          
331	Benefit not payable - h.i. act sect 20(a)(1)                            
332	Category 5 lab - benefit not payable for requested service              
333	Provider must claim time-based items                                    
334	Benefit not payable-associated pathology must be inpatient              
335	Service is not payable without nuclear medicine service                 
336	Benefit paid on nuclear medicine item other than one claimed            
337	Provider must claim content-based items                                 
338	Provider not registered to claim benefit at date of service             
339	Benefit paid at the concession rate                                     
340	Refund of co-payment amount                                             
341	No referral details - details required for future claims                
342	Referral expired - paid at unreferred (gp) rate                         
343	Cardnumber quoted on claim form has been cancelled                      
344	Concession number invalid - benefit paid at general rate                
345	No safty net entitlement - benefit paid at general rate                 
346	Co-payment not made - $2.50 credited to threshold                       
347	Safety net threshold reached - benefit increased                        
348	Overpayment of claim - invalid concession number                        
349	Replacement for requested eft payment rejected by bank                  
350	Hospital referral - paid at specialist/consultant rate                  
351	Benefit not payable - lcc number incorrect or not supplied              
352	Service date outside lcc registration dates                             
353	Pathology items not present - no benefit payable                        
356	Documentation required to process service                               
358	Documentation not received - unable to process service                  
359	Documentation not received - unable to process claim                    
360	No benefit payable when requested by this provider                      
361	Di exemption/items not approved                                         
364	Items claimed must be as a combination item                             
367	Service associated with mbac item in a multiple procedure               
370	Benefit paid on item number other than that claimed                     
371	Future claims quoting old style card no. will be rejected               
372	Old style card number quoted - benefit not payable                      
373	Expired card - benefit not payable                                      
374	Old card issue used - benefit not payable - also refer @                
375	Service being processed manually                                        
377	Number of patients seen not indicated                                   
378	Provider cannot refer/request service at date of request                
390	Documentation not received                                              
391	Service provider on db1 differs from transmitted data                   
392	Benefit amount changed                                                  
393	No benefit payable - baby not an admitted inpatient                     
395	Tac medical excess                                                      
400	Equipment number missing or invalid                                     
401	Benefit not payable - charge amount missing or invalid                  
402	Benefit not payable- number of patients attended required               
403	Subsequent consultation - referral details required                     
404	Benefit not payable - referral/request details required                 
405	Equipment number invalid for servicing provider                         
406	Unable to assess claim - please forward documents                       
407	Benefit not payable - overseas student                                  
408	Date of service prior to 29 may 1995                                    
409	Cardnumber for this enrolment needs to be verified                      
410	Age restriction applies for this item - verify details                  
411	Mbac determination/precedent number not supplied or invalid             
412	Benefit not payable - provider unable to claim this service             
413	Benefit not payable - date of serv prior to date of request             
414	Provider practice location is closed at date of service                 
415	Referral details same as rendering provider - self-deemed?              
416	Services form a composite item - composite item required                
417	Referral needed - if no referral, nr item to be transmitted             
418	Item cannot be claimed more than once in one attendance                 
419	Benefit already paid on item - verify if multiple pregnancy             
420	Operation/s schedule fee does not meet item description                 
421	Wrong assistant item used for the operation/s performed                 
422	Benefit paid has been reduced (benefit = charge)                        
423	Optical condition not specified - no benefit payable                    
424	More information required - which eye was treated                       
425	Benefit not payable - individual charges required                       
426	Indicate whether new treatment or continuing management                 
427	Compensation related services - please forward documents                
428	Date of service over 2 years - late lodgement form required             
429	Patient cannot be identified from the information supplied              
430	Conflicting referral details - please clarify                           
431	Initial consultation previously paid - query subsequent con             
432	Not multi-op - more information required to pay benefit                 
433	Associated referral/request line not required                           
434	Expired or invalid card.  benefit not payable                           
435	Service for nursing home care recipient - benefit not paid              
436	Cannot claim out of hospital service through simplified bill            
450	Eft details invalid - cheque issued for benefit                         
461	Adjustment to benefit previously paid                                   
475	Patient/service details invalid or missing                              
500	Rejected in association with another item in this claim                 
501	Group attendance or item format invalid                                 
502	Patient is not eligible to claim benefit for this item                  
503	Referral date format is invalid                                         
504	Charge amount missing/invalid - no benefit payable                      
505	More information required. evidence of condition                        
507	Site not accredited for this service                                    
509	Service paid as item 2712/2719                                          
510	Service paid as item 52-96/or similar item                              
511	Emsn threshold reached - cap applied to benefit                         
512	Multiple musculoskeletal mri service rule applied                       
513	Multiple musculoskeletal mri and di services rules applied              
514	Required equipment type code not on lspn register                       
515	Equipment greater than 10 years old                                     
516	Ben paid for base and derived radiotherapy items claimed                
517	Mpsn threshold reached - 80% out of pocket paid                         
518	Benefit paid at 100% schedule fee + emsn                                
519	Mpsn threshold reached - partial 80% out of pocket paid                 
520	Benefit paid at 100% schedule fee + part 80% out of pocket              
521	Paid part 80% out of pocket + between 85% and 100% increase             
522	Benefit paid - emsn + between 85% and 100% schedule fee                 
524	Safety net benefit adjusted                                             
525	Only attracts benefit when claimed via bulk billing                     
528	Provider not in eligible area (incorrect rrma,ssd or state)             
529	Bulk bill additional item claimed incorrectly                           
530	Patient not on concession/under 16 years at date of service             
535	Missing data                                                            
536	Location specific practice number not supplied                          
537	Location specific practice number invalid                               
538	Location specific practice number not recognised                        
539	Location specific practice number not valid at date of serv             
540	Enhanced primary care plan item not previously claimed                  
549	Bulk bill incentive item already paid - adjustment required             
550	Associated service not claimed - no benefit payable                     
551	Specimen collection point is incorrect or not supplied                  
552	Specimen collection point not valid at date of service                  
553	Approved collection centre number not supplied                          
554	Total benefit for anaesthetic service                                   
555	Benefit paid on main rvg anaesthetic item                               
556	Rvg time item not claimed                                               
557	Associated rvg anaesthetic service not claimed                          
558	Rvg anaesthetic item not claimed                                        
559	Patient outside age range - please verify age                           
560	Rvg item restriction                                                    
561	Benefit paid on rvg item claimed                                        
562	Benefit paid on associated rvg anaesthetic item                         
563	Associated rvg service already paid                                     
564	Multiple vascular ultrasound services site rule applied                 
565	Multiple di and vascular ultrasound service rules applied               
566	Total benefit for diagnostic imaging service                            
567	Benefit paid on main diagnostic imaging item                            
600	Requesting/referring provider unable to be identified                   
601	In hospital services cannot be claimed as out of hospital               
602	Out of hospital service cannot be claimed as in hospital                
603	Newborn not yet enrolled with medicare - no benefit payable             
604	Service over 6 months old - late lodgement form required                
605	Referral expired - no benefit payable                                   
606	Referring provider number not open at date of referral                  
607	Referral date has been omitted                                          
608	Referring and servicing provider same - no benefit payable              
609	Service cancelled at providers request                                  
610	Provider specialty not consistent with item claimed                     
611	Referral/request details not supplied - no benefit payable              
612	Date of referral after date of service - no benefit payable             
613	Card number cannot be identified from information supplied              
614	No benefit payable - please notate time of each visit                   
615	Multiple procedures - notate times and area of treatment                
616	Item cannot be claimed as in hospital service                           
617	Item cannot be claimed as out of hospital service                       
618	No benefit if requested by this provider at date of request             
619	Servicing provider number not open at date of service                   
620	Duplicate transmission - no further payment made                        
621	Item not claimable electronically                                       
622	Pet drop-down items not claimable via edi                               
623	Pet items only claimable via direct bill                                
624	Pet items - payee provider required                                     
625	Payee provider not eligible to claim pet items                          
627	Pdt statement not provided by the doctor                                
629	Initial pdt therapy item not present on patient history                 
633	Refer back to the specialist (referring provider is closed)             
634	Refer back to the specialist (servicing provider is closed)             
635	Late lodgement not approved - letter being sent separately              
636	Benefit reduced-dental cap broken                                       
637	No benefit payable-dentalcap reached                                    
638	Derived fee and other item cannot be claimed in-hospital                
639	Provider not in an eligible area to claim this item                     
640	More than one base and derived item claimed                             
641	More than one base item claimed                                         
642	Benefit paid for derived and other item claimed                         
643	Derived item assessed with other item on statement                      
700	Benefit cannot be determined for this service                           
701	Benefit cannot be determined due to complex assessing rules             
702	Item restrictive with another item                                      
703	Duplicate of item already quoted                                        
704	Provider not permitted to claim this item                               
705	No associated pathology service                                         
706	Provider not associated with a pathology laboratory                     
707	Pathology laboratory not registered at date of service                  
708	Item cannot be claimed from this pathology laboratory                   
709	Another assistant item should be claimed                                
710	Associated surgical items not present                                   
711	Unable to determine associated surgery                                  
712	Base item not present or in incorrect order                             
713	Radiotherapy fields greater than maximum allowable                      
714	Benefit not determined - number ot time units not present               
715	Number of time units exceeded maximum allowable                         
716	Service forms a composite item - composite item required                
717	Benefit not payable on this service for a hospital patient              
718	Provider location not open at date of service                           
719	Benefit cannot be calculated for hyperbaric oxygen therapy              
720	Eligibility cannot be determined for this item                          
732	Referral period not valid for referring provider                        
\.



update db.lu_version set lu_minor=393;
