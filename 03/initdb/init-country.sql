create table if not exists country
(
  id int primary key,
  is_active bool default true,
  title varchar(50) unique not null
);

insert into country (id, is_active, title) values (1,true,'Россия'), (2,true,'Китай');
