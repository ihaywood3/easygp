
alter table drugs.product add column shared boolean default true;
comment on column drugs.product.shared is 'if true then the user/surgery wants to share this drug with easygp-central';

alter table drugs.form add column volume_amount_required boolean default false;
alter table drugs.brand add column product_information_filename text default null;

create table drugs.product_information_unmatched
(brand text not null,
 product_information_filename text not null);

grant select on drugs.product_information_unmatched to staff;
 

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 152);


