Update billing.fee_schedule Set descriptor_brief = $$Brief consultation$$ WHERE  pk = 1 ;
Update billing.fee_schedule Set descriptor_brief = $$Standard Consultation$$ WHERE  pk = 4;
Update billing.fee_schedule Set descriptor_brief = $$Cryotherapy > 10 lesions$$ WHERE  pk = 1369;
Update billing.fee_schedule Set descriptor_brief = $$Long Consultation$$ WHERE  pk = 7;
Update billing.fee_schedule Set descriptor_brief = $$Prolonged Consultation$$ WHERE  pk = 10;
Update billing.fee_schedule Set descriptor_brief = $$GP Managment Plan - Initial$$ WHERE  pk = 141;
Update billing.fee_schedule Set descriptor_brief = $$Long Acupuncture Consultation$$ WHERE  pk =61;
Update billing.fee_schedule Set descriptor_brief = $$Removal of superficial foreign body (including cornea or sclera)$$ WHERE  pk = 1331;
Update billing.fee_schedule Set descriptor_brief = $$Removal of Entonogestral Subcutaneous Implant$$ WHERE  pk = 1332;
Update billing.fee_schedule Set descriptor_brief = $$Cryotherapy > 10 lesions$$ WHERE  pk =1369;
Update billing.fee_schedule Set descriptor_brief = $$GP Management Plan - Initial$$ WHERE  pk =141;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 229);

