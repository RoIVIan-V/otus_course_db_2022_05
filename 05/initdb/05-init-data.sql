create or replace function mp.random_between(low int, high int)
    returns int as
$$
begin
    return floor(random() * (high - low) + low);
end;
$$ language 'plpgsql' strict;


set session CONST.COUNTRY_AMOUNT = 100;
set session CONST.CITY_AMOUNT = 100;
set session CONST.MEDIA_FILE_AMOUNT = 1000000;
set session CONST.PAYMENT_AMOUNT = 100000;
set session CONST.CLIENT_AMOUNT = 10000;
set session CONST.FEATURE_GROUP_AMOUNT = 100;
set session CONST.PRODUCT_GROUP_AMOUNT = 100;
set session CONST.BRAND_AMOUNT = 2000;
set session CONST.FEATURE_AMOUNT = 1000;
set session CONST.PRODUCT_AMOUNT = 1000000;
set session CONST.PRODUCT_FUTURE_AMOUNT = 3000000;
set session CONST.PRODUCT_IMAGE_AMOUNT = 1000000;
set session CONST.COMPANY_AMOUNT = 10000;
set session CONST.SHOP_AMOUNT = 30000;
set session CONST.BILL_AMOUNT = 10000;
set session CONST.BILL_POSITION_AMOUNT = 100000;
set session CONST.PRICE_AMOUNT = 10000;
set session CONST.PRICE_POSITION_AMOUNT = 100000;
set session CONST.OFFER_AMOUNT = 500000;
set session CONST.ORDER_AMOUNT = 250000;
set session CONST.ORDER_POSITION_AMOUNT = 700000;
set session CONST.ORDER_PAIMENT_AMOUNT = 200000;


insert into mp.country (is_active, title)
select case when random() < 0.8 then true else false end,
       'country_' || seq as title
from generate_series(1, current_setting('CONST.COUNTRY_AMOUNT')::int) seq;


insert into mp.city (is_active, title, timezone, country_id)
select case when random() < 0.8 then true else false end,
       'city_' || seq as title,
       case (mp.random_between(0, 10))::int
           when 0 then 'Asia/Vladivostok'
           when 1 then 'Asia/Beirut'
           when 2 then 'Europe/Helsinki'
           when 3 then 'Australia/Eucla'
           when 4 then 'Europe/Vienna'
           when 5 then 'Europe/Saratov'
           when 6 then 'Europe/Moscow'
           when 7 then 'Europe/Zurich'
           when 8 then 'Asia/Tokyo'
           when 9 then 'Asia/Shanghai'
           when 10 then 'Asia/Qatar'
           end,
       mp.random_between(1, current_setting('CONST.COUNTRY_AMOUNT')::int)
from generate_series(1, current_setting('CONST.CITY_AMOUNT')::int) seq;


insert into mp.media_file (is_active, is_private, file_type, original_file, thumbnail)
select case when random() < 0.8 then true else false end,
       case when random() < 0.9 then false else true end,
       case (mp.random_between(0, 1))::int
           when 0 then 'video'
           when 1 then 'photo'
           end,
       'original_file_' || seq as title,
       'thumbnail_' || seq     as title
from generate_series(1, current_setting('CONST.MEDIA_FILE_AMOUNT')::int) seq;


insert into mp.payment (status, payment_type, bank_payment_id, bank_payment_url, bank_comment, total_amount)
select case (mp.random_between(0, 3))::int
           when 0 then 'new'
           when 1 then 'in_process'
           when 2 then 'complete'
           when 3 then 'canceled'
           end,
       case (mp.random_between(0, 1))::int
           when 0 then 'sale'
           when 1 then 'refund'
           end,
       md5(random()::text),
       md5(random()::text),
       case (mp.random_between(0, 1))::int
           when 0 then null
           when 1 then md5(random()::text)
           end,
       case (mp.random_between(0, 1))::int
           when 0 then null
           when 1 then mp.random_between(0, 69999)
           end
from generate_series(1, current_setting('CONST.PAYMENT_AMOUNT')::int) seq;


insert into mp.client (is_active, email, phone, first_name, last_name, city_id)
select case when random() < 0.9 then true else false end,
       'client_' || seq || '@' || (
           CASE (RANDOM() * 2)::INT
               WHEN 0 THEN 'gmail.com'
               WHEN 1 THEN 'mail.ru'
               WHEN 2 THEN 'ya.ru'
               END
           )                             as email,
       "left"(md5(random()::text), 12)   as phone,
       'client_' || seq || '_first_name' as first_name,
       'client_' || seq || '_last_name'  as last_name,
       mp.random_between(1, current_setting('CONST.CITY_AMOUNT')::int)
from generate_series(1, current_setting('CONST.CLIENT_AMOUNT')::int) seq;


insert into mp.feature_group (is_active, title)
select case when random() < 0.9 then true else false end,
       'feature_group_' || seq as title
from generate_series(1, current_setting('CONST.FEATURE_GROUP_AMOUNT')::int) seq;


insert into mp.product_group (is_active, title)
select case when random() < 0.9 then true else false end,
       'product_group_' || seq as title
from generate_series(1, current_setting('CONST.PRODUCT_GROUP_AMOUNT')::int) seq;


insert into mp.brand (is_active, title, country_id)
select case when random() < 0.9 then true else false end,
       'brand_' || seq as title,
       mp.random_between(1, current_setting('CONST.COUNTRY_AMOUNT')::int)
from generate_series(1, current_setting('CONST.BRAND_AMOUNT')::int) seq;


insert into mp.feature (is_active, title, feature_group_id)
select case when random() < 0.9 then true else false end,
       'feature_' || seq as title,
       mp.random_between(1, current_setting('CONST.FEATURE_GROUP_AMOUNT')::int)
from generate_series(1, current_setting('CONST.FEATURE_AMOUNT')::int) seq;


insert into mp.product (is_active, title, slug, code, description, brand_id, product_group_id, cover_id, weight, length,
                        width, height)
select case when random() < 0.9 then true else false end,
       'product_' || seq                   as title,
       'product_' || seq || '_slug'        as title,
       md5(random()::text)                 as code,
       'product_' || seq || '_description' as title,
       mp.random_between(1, current_setting('CONST.BRAND_AMOUNT')::int),
       mp.random_between(1, current_setting('CONST.PRODUCT_GROUP_AMOUNT')::int),
       mp.random_between(1, current_setting('CONST.MEDIA_FILE_AMOUNT')::int),
       mp.random_between(300, 99999)       as weight,
       mp.random_between(10, 99999)        as length,
       mp.random_between(10, 99999)        as width,
       mp.random_between(10, 99999)        as height
from generate_series(1, current_setting('CONST.PRODUCT_AMOUNT')::int) seq;


-- alter table mp.product_feature
--     drop constraint product_feature_unique;
--
-- insert into mp.product_feature (product_id, feature_id)
-- select mp.random_between(1, current_setting('CONST.PRODUCT_AMOUNT')::int),
--        mp.random_between(1, current_setting('CONST.FEATURE_AMOUNT')::int)
-- from generate_series(1, current_setting('CONST.PRODUCT_FUTURE_AMOUNT')::int) seq;
--
-- delete
-- from mp.product_feature a using mp.product_feature b
-- where a.id > b.id
--   and a.product_id = b.product_id
--   and a.feature_id = b.feature_id;
--
-- alter table mp.product_feature
--     add constraint product_feature_unique unique (product_id, feature_id) using index tablespace mp_fastspace;


-- alter table mp.product_image
--     drop constraint product_image_unique;
--
-- insert into mp.product_image (product_id, media_file_id, "order")
-- select mp.random_between(1, current_setting('CONST.PRODUCT_AMOUNT')::int),
--        mp.random_between(1, current_setting('CONST.MEDIA_FILE_AMOUNT')::int),
--        0
-- from generate_series(1, current_setting('CONST.PRODUCT_IMAGE_AMOUNT')::int) seq;
--
-- delete
-- from mp.product_image a using mp.product_image b
-- where a.id > b.id
--   and a.product_id = b.product_id
--   and a.media_file_id = b.media_file_id;
--
-- alter table mp.product_image
--     add constraint product_image_unique unique (product_id, media_file_id) using index tablespace mp_fastspace;


insert into mp.company (is_active, title, inn, status)
select case when random() < 0.9 then true else false end,
       'company_' || seq           as title,
       'company_' || seq || '_inn' as inn,
       case (mp.random_between(0, 3))::int
           when 0 then 'new'
           when 1 then 'signed'
           when 2 then 'blocked'
           when 3 then 'canceled'
           end
from generate_series(1, current_setting('CONST.COMPANY_AMOUNT')::int) seq;


insert into mp.shop (is_active, title, address, phone, email, company_id, city_id)
select case when random() < 0.8 then true else false end,
       'shop_' || seq                  as title,
       'shop_' || seq || '_address'    as address,
       "left"(md5(random()::text), 12) as phone,
       'shop_' || seq || '@' || (
           CASE (RANDOM() * 2)::INT
               WHEN 0 THEN 'gmail.com'
               WHEN 1 THEN 'mail.ru'
               WHEN 2 THEN 'ya.ru'
               END
           )                           as email,
       mp.random_between(1, current_setting('CONST.COMPANY_AMOUNT')::int),
       mp.random_between(1, current_setting('CONST.CITY_AMOUNT')::int)
from generate_series(1, current_setting('CONST.SHOP_AMOUNT')::int) seq;


-- insert into mp.sales_commission (company_id, product_group_id, percent)
-- select mp.random_between(1, current_setting('CONST.COMPANY_AMOUNT')::int),
--        mp.random_between(1, current_setting('CONST.PRODUCT_GROUP_AMOUNT')::int),
--        mp.random_between(5, 30)
-- from generate_series(1, current_setting('CONST.PRODUCT_IMAGE_AMOUNT')::int) seq;


insert into mp.bill (company_id, date, total_amount, status)
select mp.random_between(1, current_setting('CONST.COMPANY_AMOUNT')::int),
       NOW() - (random() * (interval '90 days')) + '30 days',
       mp.random_between(1, current_setting('CONST.CITY_AMOUNT')::int),
       case (mp.random_between(0, 3))::int
           when 0 then 'new'
           when 1 then 'sent'
           when 2 then 'paid'
           when 3 then 'canceled'
           end
from generate_series(1, current_setting('CONST.BILL_AMOUNT')::int) seq;


insert into mp.bill_position (bill_id, product_group_id, sales_commission, sales_amount, total_amount)
select mp.random_between(1, current_setting('CONST.BILL_AMOUNT')::int),
       mp.random_between(1, current_setting('CONST.PRODUCT_GROUP_AMOUNT')::int),
       mp.random_between(5, 30),
       mp.random_between(0, 15),
       mp.random_between(7500, 159999)
from generate_series(1, current_setting('CONST.BILL_POSITION_AMOUNT')::int) seq;


insert into mp.bill_payment (bill_id, payment_id)
select mp.random_between(1, current_setting('CONST.BILL_AMOUNT')::int),
       mp.random_between(1, current_setting('CONST.PAYMENT_AMOUNT')::int)
from generate_series(1, current_setting('CONST.BILL_PAYMENT_AMOUNT')::int) seq;


insert into mp.price (is_active, status, original_file, shop_id)
select case when random() < 0.9 then true else false end,
       case (mp.random_between(0, 5))::int
           when 0 then 'new'
           when 1 then 'checked'
           when 2 then 'processing'
           when 3 then 'processed'
           when 4 then 'completed'
           when 5 then 'canceled'
           end,
       'price_' || seq || '_original_file' as original_file,
       mp.random_between(1, current_setting('CONST.SHOP_AMOUNT')::int)
from generate_series(1, current_setting('CONST.PRICE_AMOUNT')::int) seq;


insert into mp.price_position (price_id, product_id, amount, price)
select mp.random_between(1, current_setting('CONST.PRICE_AMOUNT')::int),
       mp.random_between(1, current_setting('CONST.PRODUCT_AMOUNT')::int),
       mp.random_between(1, 345),
       mp.random_between(500, 12948765)
from generate_series(1, current_setting('CONST.PRICE_POSITION_AMOUNT')::int) seq;


insert into mp.offer (is_active, shop_id, product_id, amount, price)
select case when random() < 0.9 then true else false end,
       mp.random_between(1, current_setting('CONST.SHOP_AMOUNT')::int),
       mp.random_between(1, current_setting('CONST.PRODUCT_AMOUNT')::int),
       mp.random_between(1, 345),
       mp.random_between(500, 12948765)
from generate_series(1, current_setting('CONST.OFFER_AMOUNT')::int) seq;


insert into mp.order (client_id, create_date, status)
select mp.random_between(1, current_setting('CONST.CLIENT_AMOUNT')::int),
       NOW() - (random() * (interval '90 days')) + '30 days',
       case (mp.random_between(0, 5))::int
           when 0 then 'new'
           when 1 then 'checked'
           when 2 then 'processing'
           when 3 then 'processed'
           when 4 then 'completed'
           when 5 then 'canceled'
           end
from generate_series(1, current_setting('CONST.ORDER_AMOUNT')::int) seq;


insert into mp.order_position (order_id, offer_id, amount, price, total_amount)
select mp.random_between(1, current_setting('CONST.ORDER_AMOUNT')::int),
       mp.random_between(1, current_setting('CONST.OFFER_AMOUNT')::int),
       mp.random_between(1, 47),
       mp.random_between(500, 929076),
       mp.random_between(500, 929076) * mp.random_between(1, 47)
from generate_series(1, current_setting('CONST.ORDER_POSITION_AMOUNT')::int) seq;


insert into mp.order_payment (order_id, payment_id)
select mp.random_between(1, current_setting('CONST.ORDER_AMOUNT')::int),
       mp.random_between(1, current_setting('CONST.PAYMENT_AMOUNT')::int)
from generate_series(1, current_setting('CONST.ORDER_PAYMENT_AMOUNT')::int) seq;

