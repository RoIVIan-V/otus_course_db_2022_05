-- Создадим таблицу Country и заполним ее данными
create table if not exists mp.country
(
    id        smallserial not null,
    is_active bool        not null default true,
    title     varchar(50) not null,

    constraint country_pk primary key (id) using index tablespace mp_fastspace,
    constraint country_title_unique unique (title) using index tablespace mp_fastspace
) tablespace mp_general;


insert into mp.country (id, is_active, title)
values (1, true, 'Абхазия'),
       (2, true, 'Азербайджан'),
       (3, true, 'Белоруссия'),
       (4, true, 'Грузия'),
       (5, true, 'Казахстан'),
       (6, true, 'Китай'),
       (7, true, 'КНДР'),
       (8, true, 'Латвия'),
       (9, true, 'Литва'),
       (10, true, 'Монголия'),
       (11, true, 'Норвегия'),
       (12, true, 'Польша'),
       (13, true, 'США'),
       (14, true, 'Украина'),
       (15, true, 'Финляндия'),
       (16, true, 'Эстония'),
       (17, true, 'Южная Осетия'),
       (18, true, 'Япония');


create table if not exists mp.city
(
    id         smallserial  not null,
    is_active  bool         not null default true,
    title      varchar(100) not null,
    timezone   varchar(50)  not null,
    country_id smallint     not null
        references mp.country on delete cascade
            deferrable initially deferred,

    constraint city_pk primary key (id) using index tablespace mp_fastspace,
    constraint city_country_id_title_unique unique (country_id, title) using index tablespace mp_fastspace
) tablespace mp_general;


insert into mp.city (id, is_active, title, timezone, country_id)
values (1, true, 'Сухум', 'Asia/Tbilisi', 1),
       (2, true, 'Баку', 'Asia/Baku', 2),
       (3, true, 'Минск', 'Europe/Minsk', 3),
       (4, true, 'Тбилиси', 'Asia/Tbilisi', 4),
       (5, true, 'Астана', 'Asia/Almaty', 5),
       (6, true, 'Пекин', 'Asia/Shanghai', 6),
       (7, true, 'Пхеньян', 'Asia/Pyongyang', 7),
       (8, true, 'Рига', 'Europe/Riga', 8),
       (9, true, 'Вильнюс', 'Europe/Vilnius', 9),
       (10, true, 'Улан-Батор', 'Asia/Ulaanbaatar', 10),
       (11, true, 'Осло', 'Europe/Oslo', 11),
       (12, true, 'Варшава', 'Europe/Warsaw', 12),
       (13, true, 'Вашингтон', 'America/New_York', 13),
       (14, true, 'Киев', 'Europe/Kiev', 14),
       (15, true, 'Хельсинки', 'Europe/Helsinki', 15),
       (16, true, 'Таллин', 'Europe/Tallinn', 16),
       (17, true, 'Цхинвал', 'Asia/Tbilisi', 17),
       (18, true, 'Токио', 'Asia/Tokyo', 18);