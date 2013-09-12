\set ON_ERROR_STOP 1
\o /dev/null
\set QUIET 1

create or replace function drugs.assert_product(pk1 uuid, atccode1 text, generic1 text, fk_form1 integer, strength1 text, original_pbs_name1 text, free_comment1 text, fk_schedule1 integer, pack_size1 integer, amount1 double precision, amount_unit1 integer, units_per_pack1 integer, sct1 text, salt1 text default null, salt_strength1 text default null, updated_at1 timestamp default now()) returns void language plpgsql as $func$
begin
   perform 1 from drugs.product where pk=pk1;
   if found then
      update drugs.product set generic=generic1, salt=salt1, fk_form=fk_form1, strength=strength1, salt_strength=salt_strength1, original_pbs_name=original_pbs_name1, free_comment=free_comment1, fk_schedule=fk_schedule1, pack_size=pack_size1, amount=amount1, amount_unit=amount_unit1, units_per_pack=units_per_pack1, sct=sct1,updated_at=updated_at1,atccode=atccode1 where pk=pk1;
   else
      insert into drugs.product (pk,  atccode,  generic,  salt,  fk_form,  strength,  salt_strength,  original_pbs_name,  free_comment,  fk_schedule,  pack_size,  amount,  amount_unit,  units_per_pack,  sct) 
                         values (pk1, atccode1, generic1, salt1, fk_form1, strength1, salt_strength1, original_pbs_name1, free_comment1, fk_schedule1, pack_size1, amount1, amount_unit1, units_per_pack1, sct1);
   end if;
end
$func$;


alter function drugs.assert_product(uuid,text,text,integer,text,text,text,integer,integer,double precision,integer,integer,text,text,text,timestamp) 
owner to easygp;

grant execute on function drugs.assert_product(uuid,text,text,integer,text,text,text,integer,integer,double precision,integer,integer,text,text,text,timestamp) to easygp;

create or replace function drugs.assert_brand(pk1 uuid, fk_product1 uuid, fk_company1 text, brand1 text, sct1 text, price1 money, from_pbs1 boolean, pif text) returns void language plpgsql as $func$
begin
   perform 1 from drugs.brand where pk=pk1;
   if found then
      update drugs.brand set  fk_product=fk_product1, fk_company=fk_company1, brand=brand1, price=price1, sct=sct1,product_information_filename=pif,from_pbs=from_pbs1 where pk=pk1;
   else
      insert into drugs.brand (pk, fk_product, fk_company, brand, price, from_pbs, sct,product_information_filename) values (pk1, fk_product1, fk_company1, brand1, price1, from_pb1s, sct1, pif);
   end if;
end
$func$;

alter function drugs.assert_brand(uuid,uuid,text,text,text,money,boolean,text) owner to easygp;
grant execute on function drugs.assert_brand(uuid,uuid,text,text,text,money,boolean,text) to easygp;

create or replace function drugs.assert_atc(atccode1 text, atctext1 text) returns void language plpgsql as $func$
begin
   perform 1 from drugs.atc where atccode=atccode1;
   if not found then
      insert into drugs.atc (atccode, atcname) values (atccode1, atctext1);
   end if;
end
$func$;

alter function drugs.assert_atc(text,text) owner to easygp;
grant execute on function drugs.assert_atc(text,text) to easygp;

create or replace function drugs.assert_form(pk1 integer,form1 text,vol1 boolean) returns void language plpgsql as $func$
begin
   perform 1 from drugs.form where pk=pk1;
   if not found then
       insert into drugs.form (pk,form,volume_amount_required) values (pk1, form1, vol1);
   end if;
end;
$func$;


alter function drugs.assert_form(integer,text,boolean) owner to easygp;
grant execute on function drugs.assert_form(integer,text,boolean) to easygp;

select drugs.assert_form(77,'fatty ointment',true);

create or replace function drugs.assert_company(code1 text, company1 text, address1 text, telephone1 text)
      returns void language plpgsql as $func$
begin
  perform 1 from drugs.company where code=code1;
  if found then
      update drugs.company set company=company1,address=address1,telephone=telephone1
where code=code1;
  else
      insert into drugs.company (code,company,address,telephone) values
                (code1,company1,address1,telephone1);
  end if;
end
$func$;


alter function drugs.assert_company(text,text,text,text) owner to easygp;
grant execute on function drugs.assert_company(text,text,text,text) to easygp;

create or replace function drugs.duplicate_product(old_pk uuid, new_pk uuid)
       returns void language plpgsql as $func$
begin
  update clin_prescribing.prescribed set fk_brand = b2.pk from drugs.brand b1, drugs.brand b2 where 
    b1.fk_product= old_pk and b2.fk_product = new_pk and b1.brand = b2.brand and b1.fk_company = b2.fk_company and prescribed.fk_brand = b1.pk;
  update clin_prescribing.medications set fk_generic_product = new_pk where fk_generic_product = old_pk;
  delete from drugs.brand where fk_product= old_pk;
  delete from drugs.product where pk=old_pk;
end;
$func$;

alter function drugs.duplicate_product(uuid,uuid) owner to easygp;
grant execute on function drugs.duplicate_product(uuid,uuid) to easygp;

select drugs.duplicate_product('5dadcc4a-bf90-4c0d-8cfb-f0363bf897a7','7a9ec70e-0a40-4a31-b66c-98e0ee18d8da'); -- remove temozolide 100mg duplicate
select drugs.duplicate_product('52425b76-ddd1-401c-b58e-d5c57b793632','a73d59e7-79b1-4853-bcdb-ca999ad30edb'); -- temozolide 5mg 

grant update, select on drugs.version to easygp;
grant select on drugs.version to staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 317);