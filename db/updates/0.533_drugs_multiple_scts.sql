delete from drugs.old_sct where sct='None';

delete from drugs.old_sct where sct='293311000144103';
insert into drugs.old_sct (fk_product,sct) values ('5aa3bf22-8132-4991-8356-ec5975045eab','293311000144103');

create table drugs.link_product_sct (
       fk_product uuid references drugs.product (pk) not null,
       sct text not null unique,
       original_pbs_name text not null,
       created timestamp default now() not null
);

insert into drugs.link_product_sct (fk_product, sct, original_pbs_name)
   select distinct on (o.sct) o.fk_product, o.sct, coalesce( p.original_pbs_name, 'UNKNOWN')
   	  from drugs.old_sct o,
	  drugs.product p
	  where o.fk_product = p.pk;

insert into drugs.link_product_sct (fk_product, sct, original_pbs_name)
  select distinct on (sct) p.pk, p.sct,  coalesce( p.original_pbs_name, 'UNKNOWN')
  from drugs.product p where not sct is null and not exists (select 1 from drugs.link_product_sct lps where lps.sct = p.sct) ;

update db.lu_version set lu_minor = 533;
