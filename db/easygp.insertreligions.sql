--Adds tables of religions and subreligions and data
--the view definition is not needed as it exists in the dump
drop table common.lu_religions;
CREATE TABLE common.lu_religions
(
  pk serial primary key,
  religion text not null
);

ALTER TABLE common.lu_religions OWNER TO easygp;
GRANT ALL ON TABLE common.lu_religions TO easygp;
GRANT SELECT ON TABLE common.lu_religions TO staff;

COMMENT ON TABLE common.lu_religions is
'The -core- religions eg christiantity, the sub religions are
 in the table lu_sub_religion';
drop table common.lu_sub_religions;
create table common.lu_sub_religions

(pk serial primary key,
 fk_religion integer not null,
 sub_religion text not null);
 
COMMENT ON TABLE common.lu_sub_religions is
'The eg christiantity may be Baptist, Methodist';

 ALTER TABLE common.lu_sub_religions OWNER TO easygp;
GRANT ALL ON TABLE common.lu_sub_religions TO easygp;
GRANT SELECT ON TABLE common.lu_sub_religions TO staff;


 
 insert into common.lu_religions (religion) values ('Christianity');
insert into common.lu_sub_religions (fk_religion, sub_religion) Values ((select currval ('common.lu_religions_pk_seq')),'Catholicism');
insert into common.lu_sub_religions (fk_religion, sub_religion) Values ((select currval ('common.lu_religions_pk_seq')),'Orthodoxy');
insert into common.lu_sub_religions (fk_religion, sub_religion) Values ((select currval ('common.lu_religions_pk_seq')),'Protestantism');
insert into common.lu_sub_religions (fk_religion, sub_religion) Values ((select currval ('common.lu_religions_pk_seq')),'Baptist');
insert into common.lu_sub_religions (fk_religion, sub_religion) Values ((select currval ('common.lu_religions_pk_seq')),'Episcopal');
insert into common.lu_sub_religions (fk_religion, sub_religion) Values ((select currval ('common.lu_religions_pk_seq')),'Lutheran');
insert into common.lu_sub_religions (fk_religion, sub_religion) Values ((select currval ('common.lu_religions_pk_seq')),'Methodist');
insert into common.lu_sub_religions (fk_religion, sub_religion) Values ((select currval ('common.lu_religions_pk_seq')),'Pentecostal');
insert into common.lu_sub_religions (fk_religion, sub_religion) Values ((select currval ('common.lu_religions_pk_seq')),'Other');
 
insert into common.lu_religions (religion) values ('Buddhism');
insert into common.lu_sub_religions (fk_religion, sub_religion) Values ((select currval ('common.lu_religions_pk_seq')),'Zen');
insert into common.lu_sub_religions (fk_religion, sub_religion) Values ((select currval ('common.lu_religions_pk_seq')),'Pure Land');
insert into common.lu_sub_religions (fk_religion, sub_religion) Values ((select currval ('common.lu_religions_pk_seq')),'Theravada');
insert into common.lu_sub_religions (fk_religion, sub_religion) Values ((select currval ('common.lu_religions_pk_seq')),'Tibetan');
insert into common.lu_sub_religions (fk_religion, sub_religion) Values ((select currval ('common.lu_religions_pk_seq')),'Zen');



insert into common.lu_religions (religion) values ('Confucianism');
insert into common.lu_religions (religion) values ('Hinduism');
insert into common.lu_sub_religions (fk_religion, sub_religion) Values ((select currval ('common.lu_religions_pk_seq')),'Shaivism');
insert into common.lu_sub_religions (fk_religion, sub_religion) Values ((select currval ('common.lu_religions_pk_seq')),'Vaishnavism');
insert into common.lu_sub_religions (fk_religion, sub_religion) Values ((select currval ('common.lu_religions_pk_seq')),'Shakta');
insert into common.lu_sub_religions (fk_religion, sub_religion) Values ((select currval ('common.lu_religions_pk_seq')),'Shakta');


insert into common.lu_religions (religion) values ('Islam');
insert into common.lu_religions (religion) values ('Jainism');
insert into common.lu_religions (religion) values ('Judaism');

insert into common.lu_sub_religions (fk_religion, sub_religion) Values ((select currval ('common.lu_religions_pk_seq')),'Orthodox');
insert into common.lu_sub_religions (fk_religion, sub_religion) Values ((select currval ('common.lu_religions_pk_seq')),'Liberal/Reform');


insert into common.lu_religions (religion) values ('Shinto');
insert into common.lu_religions (religion) values ('Sikhism');
insert into common.lu_religions (religion) values ('Taoism');
insert into common.lu_religions (religion) values ('Zoroastrianism');

insert into common.lu_religions (religion) values ('New Religious Movements');
insert into common.lu_sub_religions (fk_religion, sub_religion) Values ((select currval ('common.lu_religions_pk_seq')),'Christian-Derived NRMs');
insert into common.lu_sub_religions (fk_religion, sub_religion) Values ((select currval ('common.lu_religions_pk_seq')),'Eastern-Derived NRMs');
insert into common.lu_sub_religions (fk_religion, sub_religion) Values ((select currval ('common.lu_religions_pk_seq')),'Paganism and New Age');


insert into common.lu_religions (religion) values ('Other');
insert into common.lu_sub_religions (fk_religion, sub_religion) Values ((select currval ('common.lu_religions_pk_seq')),'Bahai');
insert into common.lu_sub_religions (fk_religion, sub_religion) Values ((select currval ('common.lu_religions_pk_seq')),'Scientology');
insert into common.lu_sub_religions (fk_religion, sub_religion) Values ((select currval ('common.lu_religions_pk_seq')),'Rastafarianism');



CREATE OR REPLACE VIEW common.vwreligions AS 
 SELECT 
        CASE
            WHEN lu_sub_religions.fk_religion > 0 THEN (lu_sub_religions.pk || '-'::text) || lu_religions.pk
            ELSE lu_religions.pk || '-0'::text
        END AS pk_view, lu_religions.religion, lu_sub_religions.sub_religion, lu_sub_religions.fk_religion, lu_sub_religions.pk AS pk_lu_sub_religions
   FROM common.lu_sub_religions
   RIGHT JOIN common.lu_religions ON lu_sub_religions.fk_religion = lu_religions.pk
  ORDER BY lu_sub_religions.fk_religion, lu_sub_religions.pk;

ALTER TABLE common.vwreligions OWNER TO easygp;
GRANT ALL ON TABLE common.vwreligions TO easygp;
GRANT SELECT ON TABLE common.vwreligions TO staff;
Christianity
  Catholicism
  Orthodoxy
  Protestantism
  Baptist
  Episcopal
  Lutheran
  Methodist
  Pentecostal
  Other
Buddhism
  Zen
  Pure Land
  Theravada
  Tibetan
  Other
Confucianism
Hinduism
  Shaivism
  Vaishnavism
  Shakta
  Philosophy
Islam
Jainism
Judaism
 Orthodox
 Liberal/Reform
Shinto
Sikhism
Taoism
Zoroastrianism
New Religious Movements
 Christian-Derived NRMs
 Eastern-Derived NRMs
 Paganism and New Age
Other
 Bahai
 Scientology
 Rastafarianism
