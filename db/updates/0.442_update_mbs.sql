CREATE OR REPLACE FUNCTION billing.assert_mbs(item1, pk1 uuid, atccode1 text, generic1 text, fk_form1 integer, strength1 text, original_pbs_name1 text, free_comment1 text, fk_schedule1 integer, pack_size1 integer, amount1 double precision, amount_unit1 integer, units_per_pack1 integer, sct1 text, salt1 text DEFAULT NULL::text, salt_strength1 text DEFAULT NULL::text, updated_at1 timestamp without time zone DEFAULT now())
 RETURNS void
 LANGUAGE plpgsql
AS $function$
begin
   perform 1 from drugs.product where pk=pk1;
   if found then
      update drugs.product set generic=generic1, salt=salt1, fk_form=fk_form1, strength=strength1, salt_strength=salt_strength1, original_pbs_name=original_pbs_name1, free_comment=free_comment1, fk_schedule=fk_schedule1, pack_size=pack_size1, amount=amount1, amount_unit=amount_unit1, units_per_pack=units_per_pack1, sct=sct1,updated_at=updated_at1,atccode=atccode1 where pk=pk1;
   else
      insert into drugs.product (pk,  atccode,  generic,  salt,  fk_form,  strength,  salt_strength,  original_pbs_name,  free_comment,  fk_schedule,  pack_size,  amount,  amount_unit,  units_per_pack,  sct) 
                         values (pk1, atccode1, generic1, salt1, fk_form1, strength1, salt_strength1, original_pbs_name1, free_comment1, fk_schedule1, pack_size1, amount1, amount_unit1, units_per_pack1, sct1);
   end if;
end
$function$
