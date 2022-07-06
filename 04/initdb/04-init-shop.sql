-- Создадим таблицу Country и заполним ее данными
create table if not exists mp.company
(
    id        serial      not null,
    is_active bool        not null default true,
    title     varchar(50) not null,
    inn       varchar(20) not null,
    status    varchar(50) not null,

    constraint company_pk primary key (id) using index tablespace mp_fastspace,
    constraint company_title_unique unique (inn) using index tablespace mp_fastspace
) tablespace mp_general;


insert into mp.company (id, is_active, title, inn, status)
values (1, true, 'Магазин на диване', '00033412847302837485', 'confirmed'),
       (2, true, 'Сундук сокровищ', '98364748472019487009', 'confirmed'),
       (3, true, 'Оружейный двор', '85739284759830278590', 'not confirmed'),
       (4, true, 'Всё для рыбалки', '94723625647583657487', 'not confirmed'),
       (5, true, 'Фабрика спорта', '00357328397564574929', 'on confirmation');


create table if not exists mp.shop
(
    id         serial       not null,
    is_active  bool         not null default true,
    title      varchar(50)  not null,
    address    varchar(255) not null,
    phone      varchar(20)  not null,
    email      varchar(50)  not null,
    company_id int          not null
        references mp.company on delete cascade
            deferrable initially deferred,
    city_id    smallint     not null
        references mp.city on delete cascade
            deferrable initially deferred,

    constraint shop_pk primary key (id) using index tablespace mp_fastspace,
    constraint shop_company_id_address_unique unique (company_id, address) using index tablespace mp_fastspace
) tablespace mp_general;


insert into mp.shop (id, is_active, title, address, phone, email, company_id, city_id)
values (1, true, 'Жемчужина', 'ул. Академика Сахарова, 40', '+7-840-226-49-55', 'pearl@sofa-shop.net' , 1, 1),
       (2, true, 'Амай', 'просп. 8 Ноября, 23', '+99-412-598-81-44', 'amai@sofa-shop.net', 1, 2),
       (3, true, 'Евро-опт', 'Партизанский проспект, 26', '+37-517-209-78-62', 'euro.opt@treasure.net', 2, 3),
       (4, true, 'Два шага', 'ул. Адама Мицкевича, 25А', '+99-532-244-07-07', 'agrohub.ge', 5, 4),
       (5, true, 'Жетысу', 'ул. Шамши Калдаякова, 2', '+7-717-231-31-38', '72.astana-bilim.kz', 5, 5);
