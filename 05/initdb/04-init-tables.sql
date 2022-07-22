-- CITY TABLES --

create table if not exists mp.country
(
    id        smallserial not null,
    is_active bool        not null default true,
    title     varchar(50) not null,

    constraint country_pk primary key (id) using index tablespace mp_fastspace,
    constraint country_unique unique (title) using index tablespace mp_fastspace
) tablespace mp_general;


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
    constraint city_unique unique (country_id, title) using index tablespace mp_fastspace
) tablespace mp_general;


-- MEDIA_FILE TABLES --

create table if not exists mp.media_file
(
    id            bigserial    not null,
    uuid          uuid         not null default gen_random_uuid(),
    is_active     bool         not null default true,
    is_private    bool         not null default false,
    file_type     varchar(25)  not null,
    original_file varchar(250) not null,
    thumbnail     varchar(250) not null,

    constraint media_file_pk primary key (id) using index tablespace mp_fastspace,
    constraint media_file_uuid_unique unique (uuid) using index tablespace mp_fastspace
) tablespace mp_general;


-- PAYMENT TABLES --

create table if not exists mp.payment
(
    id               bigserial    not null,
    uuid             uuid         not null default gen_random_uuid(),
    create_date      timestamptz  not null default now(),
    status           varchar(50)  not null,
    payment_type     varchar(20)  not null,
    bank_payment_id  varchar(50)  not null,
    bank_payment_url varchar(250) not null,
    bank_comment     text,
    total_amount     decimal,
--     refund_amount    decimal,

    constraint payment_pk primary key (id) using index tablespace mp_fastspace,
    constraint payment_uuid_unique unique (uuid) using index tablespace mp_fastspace
) tablespace mp_general;


-- CLIENT TABLES --

create table if not exists mp.client
(
    id         serial      not null,
    is_active  bool        not null default true,
    email      varchar(50) not null,
    phone      varchar(12) not null,
    first_name varchar(50) not null,
    last_name  varchar(50) not null,
    city_id    int         not null
        references mp.city on delete cascade
            deferrable initially deferred,

    constraint client_pk primary key (id) using index tablespace mp_fastspace,
    constraint client_email_unique unique (email) using index tablespace mp_fastspace,
    constraint client_phone_unique unique (phone) using index tablespace mp_fastspace
) tablespace mp_general;


-- PRODUCT TABLES --

create table if not exists mp.feature_group
(
    id        smallserial not null,
    is_active bool        not null default true,
    title     varchar(50) not null,

    constraint feature_group_pk primary key (id) using index tablespace mp_fastspace,
    constraint feature_group_title_unique unique (title) using index tablespace mp_fastspace
) tablespace mp_general;


create table if not exists mp.product_group
(
    id        smallserial not null,
    is_active bool        not null default true,
    title     varchar(50) not null,

    constraint product_group_pk primary key (id) using index tablespace mp_fastspace,
    constraint product_group_title_unique unique (title) using index tablespace mp_fastspace
) tablespace mp_general;


create table if not exists mp.brand
(
    id         serial      not null,
    is_active  bool        not null default true,
    title      varchar(50) not null,
    country_id int         not null
        references mp.country on delete cascade
            deferrable initially deferred,

    constraint brand_pk primary key (id) using index tablespace mp_fastspace,
    constraint brand_unique unique (country_id, title) using index tablespace mp_fastspace
) tablespace mp_general;


create table if not exists mp.feature
(
    id               serial      not null,
    is_active        bool        not null default true,
    title            varchar(50) not null,
    feature_group_id int         not null
        references mp.feature_group on delete cascade
            deferrable initially deferred,

    constraint feature_pk primary key (id) using index tablespace mp_fastspace,
    constraint feature_title_unique unique (title) using index tablespace mp_fastspace
) tablespace mp_general;


create table if not exists mp.product
(
    id               bigserial   not null,
    is_active        bool        not null default true,
    title            varchar(50) not null,
    slug             varchar(50) not null,
    code             varchar(50) not null,
    description      text        not null,
    brand_id         int         not null
        references mp.brand on delete cascade
            deferrable initially deferred,
    product_group_id int         not null
        references mp.product_group on delete cascade
            deferrable initially deferred,
    cover_id         bigint      not null
        references mp.media_file on delete cascade
            deferrable initially deferred,
    weight           int         not null,
    length           int         not null,
    width            int         not null,
    height           int         not null,

    constraint product_pk primary key (id) using index tablespace mp_fastspace,
    constraint product_unique unique (brand_id, code) using index tablespace mp_fastspace
) tablespace mp_general;


create table if not exists mp.product_feature
(
    id         bigserial not null,
    product_id bigint    not null
        references mp.brand on delete cascade
            deferrable initially deferred,
    feature_id int       not null
        references mp.product_group on delete cascade
            deferrable initially deferred,

    constraint product_feature_pk primary key (id) using index tablespace mp_fastspace,
    constraint product_feature_unique unique (product_id, feature_id) using index tablespace mp_fastspace
) tablespace mp_general;


create table if not exists mp.product_image
(
    id            serial   not null,
    product_id    int      not null
        references mp.brand on delete cascade
            deferrable initially deferred,
    media_file_id int      not null
        references mp.media_file on delete cascade
            deferrable initially deferred,
    "order"       smallint not null,

    constraint product_image_pk primary key (id) using index tablespace mp_fastspace,
    constraint product_image_unique unique (product_id, media_file_id) using index tablespace mp_fastspace
) tablespace mp_general;


-- SHOP TABLES --

create table if not exists mp.company
(
    id        serial      not null,
    is_active bool        not null default true,
    title     varchar(50) not null,
    inn       varchar(20) not null,
    status    varchar(50) not null,

    constraint company_pk primary key (id) using index tablespace mp_fastspace,
    constraint company_inn_unique unique (inn) using index tablespace mp_fastspace
) tablespace mp_general;


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
    constraint shop_unique unique (company_id, city_id, address) using index tablespace mp_fastspace
) tablespace mp_general;


create table if not exists mp.sales_commission
(
    id               serial not null,
    company_id       int    not null
        references mp.company on delete cascade
            deferrable initially deferred,
    product_group_id int    not null
        references mp.product_group on delete cascade
            deferrable initially deferred,
    percent          float  not null,

    constraint sales_commission_pk primary key (id) using index tablespace mp_fastspace,
    constraint sales_commission_unique unique (company_id, product_group_id) using index tablespace mp_fastspace
) tablespace mp_general;


create table if not exists mp.bill
(
    id           serial  not null,
    company_id   int     not null
        references mp.company on delete cascade
            deferrable initially deferred,
    date         date    not null,
    total_amount decimal not null,
    status       varchar(25),

    constraint bill_pk primary key (id) using index tablespace mp_fastspace
--     constraint bill_unique unique (company_id, date) using index tablespace mp_fastspace
) tablespace mp_general;


create table if not exists mp.bill_position
(
    id               serial  not null,
    bill_id          int     not null
        references mp.company on delete cascade
            deferrable initially deferred,
    product_group_id int     not null
        references mp.product_group on delete cascade
            deferrable initially deferred,
    sales_commission float   not null,
    sales_amount     decimal not null,
    total_amount     decimal not null,

    constraint bill_position_pk primary key (id) using index tablespace mp_fastspace,
    constraint bill_position_unique unique (bill_id, product_group_id) using index tablespace mp_fastspace
) tablespace mp_general;


create table if not exists mp.bill_payment
(
    id         serial not null,
    bill_id    int    not null
        references mp.bill on delete cascade
            deferrable initially deferred,
    payment_id int    not null
        references mp.payment on delete cascade
            deferrable initially deferred,

    constraint bill_payment_pk primary key (id) using index tablespace mp_fastspace,
    constraint bill_payment_unique unique (bill_id, payment_id) using index tablespace mp_fastspace
) tablespace mp_general;


-- PRICE TABLES --

create table if not exists mp.price
(
    id            serial       not null,
    is_active     bool         not null default true,
    status        varchar(50)  not null,
    original_file varchar(255) not null,
    uploaded_date timestamptz  not null default now(),
    shop_id       int          not null
        references mp.shop on delete cascade
            deferrable initially deferred,

    constraint price_pk primary key (id) using index tablespace mp_fastspace
) tablespace mp_general;


create table if not exists mp.price_position
(
    id         serial   not null,
    price_id   int      not null
        references mp.price on delete cascade
            deferrable initially deferred,
    product_id int      not null
        references mp.product on delete cascade
            deferrable initially deferred,
    amount     smallint not null,
    price      decimal  not null,

    constraint price_position_pk primary key (id) using index tablespace mp_fastspace,
    constraint price_position_unique unique (price_id, product_id) using index tablespace mp_fastspace
) tablespace mp_general;


-- OFFER TABLES --

create table if not exists mp.offer
(
    id         serial   not null,
    uuid       uuid     not null default gen_random_uuid(),
    is_active  bool     not null default true,
    shop_id    int      not null
        references mp.shop on delete cascade
            deferrable initially deferred,
    product_id int      not null
        references mp.product on delete cascade
            deferrable initially deferred,
    amount     smallint not null,
    price      decimal  not null,

    constraint offer_pk primary key (id) using index tablespace mp_fastspace,
    constraint offer_uuid_unique unique (uuid) using index tablespace mp_fastspace,
    constraint offer_unique unique (shop_id, product_id) using index tablespace mp_fastspace
) tablespace mp_general;


-- ORDER TABLES --

create table if not exists mp.order
(
    id          serial      not null,
    uuid        uuid        not null default gen_random_uuid(),
    client_id   int         not null
        references mp.client on delete cascade
            deferrable initially deferred,
    create_date timestamptz not null default now(),
    status      varchar(25) not null,

    constraint order_pk primary key (id) using index tablespace mp_fastspace,
    constraint order_uuid_unique unique (uuid) using index tablespace mp_fastspace
) tablespace mp_general;


create table if not exists mp.order_position
(
    id           serial   not null,
    order_id     int      not null
        references mp.order on delete cascade
            deferrable initially deferred,
    offer_id     int      not null
        references mp.offer on delete cascade
            deferrable initially deferred,
    amount       smallint not null,
    price        decimal  not null,
    total_amount decimal  not null,

    constraint order_position_pk primary key (id) using index tablespace mp_fastspace,
    constraint order_position_uuid_unique unique (order_id, offer_id) using index tablespace mp_fastspace
) tablespace mp_general;


create table if not exists mp.order_payment
(
    id         serial not null,
    order_id   int    not null
        references mp.order on delete cascade
            deferrable initially deferred,
    payment_id int    not null
        references mp.payment on delete cascade
            deferrable initially deferred,

    constraint order_payment_pk primary key (id) using index tablespace mp_fastspace,
    constraint order_payment_unique unique (order_id, payment_id) using index tablespace mp_fastspace
) tablespace mp_general;

