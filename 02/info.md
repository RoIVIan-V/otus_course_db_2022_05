## Документация к БД


**[➤ Перейти к Схеме БД ](https://github.com/RoIVIan-V/otus_course_db_2022_05/blob/main/01/schema.md)**

### Таблицы:

#### Блок таблиц "Город"


* Таблица **Страна** - *Country*
<table>
  <tr><th>Поле</th><th>Тип</th><th>Описание</th><th>Ограничения</th><th>Значение по умолчанию</th></tr>
  <tr><td>id</td><td>bigint (PK)</td><td>Идентификатор</td><td>NOT NULL, UNIQUE</td><td>-</td></tr>
  <tr><td>title</td><td>varchar</td><td>Название страны</td><td>NOT NULL, UNIQUE</td><td>-</td></tr>
  <tr><td>is_active</td><td>bit</td><td>Флаг активности, если флаг == False, то страна не активна и все магазины и предложения из этой страны не отображаются</td><td>-</td><td>TRUE</td></tr>
</table>

<table>
    <tr><th>Возможные запросы</th><th>Комментарий</th></tr>
    <tr><td>селект по id</td><td>-</td></tr>
    <tr><td>селект по is_active</td><td>Отдавать только активные страны</td></tr>
</table>

<table>
    <tr><th>Индексы</th><th>Комментарий</th></tr>
    <tr><td>по полю id</td><td>PK</td></tr>
</table>

<br/>

* Таблица **Город** - *City*
<table>
  <tr><th>Поле</th><th>Тип</th><th>Описание</th><th>Ограничения</th><th>Значение по умолчанию</th></tr>
  <tr><td>id</td><td>bigint (PK)</td><td>Идентификатор</td><td>NOT NULL, UNIQUE</td><td>-</td></tr>
  <tr><td>country_id</td><td>FK Country</td><td>Связь с таблицей Country</td><td>NOT NULL</td><td>-</td></tr>
  <tr><td>title</td><td>varchar</td><td>Название города</td><td>NOT NULL, UNIQUE (country_id, title)</td><td>-</td></tr>
  <tr><td>timezone</td><td>varchar</td><td>Часовой пояс</td><td>NOT NULL</td><td>-</td></tr>
  <tr><td>is_active</td><td>bit</td><td>Флаг активности, если флаг == False, то город не активен и все магазины и предложения из этого города не отображаются</td><td>-</td><td>TRUE</td></tr>
</table>

<table>
    <tr><th>Возможные запросы</th><th>Комментарий</th></tr>
    <tr><td>селект по id</td><td>-</td></tr>
    <tr><td>селект по is_active</td><td>Отдавать только активные города</td></tr>
    <tr><td>селект по country_id</td><td>Фильтрация для списка / вложенного списка</td></tr>
    <tr><td>селект по title</td><td>Фильтрация списка городов во время набора названия</td></tr>
</table>

<table>
    <tr><th>Индексы</th><th>Комментарий</th></tr>
    <tr><td>по полю id</td><td>PK</td></tr>
    <tr><td>по полю country_id</td><td>FK</td></tr>
</table>

<br/>

#### Блок таблиц "Товар"
* Таблица **Производитель** - *Brand*
<table>
  <tr><th>Поле</th><th>Тип</th><th>Описание</th><th>Ограничения</th><th>Значение по умолчанию</th></tr>
  <tr><td>id</td><td>bigint (PK)</td><td>Идентификатор</td><td>NOT NULL, UNIQUE</td><td>-</td></tr>
  <tr><td>country_id</td><td>FK Country</td><td>Связь с таблицей Country</td><td>NOT NULL</td><td>-</td></tr>
  <tr><td>title</td><td>varchar</td><td>Название бренда</td><td>NOT NULL, UNIQUE (country_id, title)</td><td>-</td></tr>
  <tr><td>is_active</td><td>bit</td><td>Флаг активности, если флаг == False, то производитель не активен и предложения с его товарами не отображаются</td><td></td><td>TRUE</td></tr>
</table>

<table>
    <tr><th>Возможные запросы</th><th>Комментарий</th></tr>
    <tr><td>селект по id</td><td>-</td></tr>
    <tr><td>селект по is_active</td><td>Отдавать только активные бренды</td></tr>
    <tr><td>селект по country_id</td><td>Фильтрация брендов по стране производителя</td></tr>
    <tr><td>селект по title</td><td>Фильтрация списка брендов во время набора названия</td></tr>
</table>

<table>
    <tr><th>Индексы</th><th>Комментарий</th></tr>
    <tr><td>по полю id</td><td>PK</td></tr>
    <tr><td>по полю country_id</td><td>FK</td></tr>
</table>

<br/>
    
<br/>

* Таблица **Группа товаров** - *ProductGroup*
<table>
  <tr><th>Поле</th><th>Тип</th><th>Описание</th><th>Ограничения</th><th>Значение по умолчанию</th></tr>
  <tr><td>id</td><td>bigint (PK)</td><td>Идентификатор</td><td>NOT NULL, UNIQUE</td><td>-</td></tr>
  <tr><td>title</td><td>varchar</td><td>Название группы товаров</td><td>NOT NULL, UNIQUE</td><td>-</td></tr>
  <tr><td>is_active</td><td>bit</td><td>Флаг активности, если флаг == False, то товары в этой группе не активны и предложения с этими товарами не отображаются</td><td>-</td><td>TRUE</td></tr>
</table>

<table>
    <tr><th>Возможные запросы</th><th>Комментарий</th></tr>
    <tr><td>селект по id</td><td>-</td></tr>
    <tr><td>селект по is_active</td><td>Отдавать только активные группы товаров</td></tr>
</table>

<table>
    <tr><th>Индексы</th><th>Комментарий</th></tr>
    <tr><td>по полю id</td><td>PK</td></tr>
</table>

<br/>

<br/>

* Таблица **Товар** - *Product*
<table>
  <tr><th>Поле</th><th>Тип</th><th>Описание</th><th>Ограничения</th><th>Значение по умолчанию</th></tr>
  <tr><td>id</td><td>bigint (PK)</td><td>Идентификатор</td><td>NOT NULL, UNIQUE</td><td>-</td></tr>
  <tr><td>brand_id</td><td>FK Brand</td><td>Связь с таблицей Brand</td><td>NOT NULL</td><td>-</td></tr>
  <tr><td>product_group_id</td><td>FK ProductGroup</td><td>Связь с таблицей ProductGroup</td><td>NOT NULL</td><td>-</td></tr>
  <tr><td>title</td><td>varchar</td><td>Название товара</td><td>NOT NULL, UNIQUE (brand_id, title)</td><td>-</td></tr>
  <tr><td>description</td><td>text</td><td>Название товара</td><td>NOT NULL</td><td>-</td></tr>
  <tr><td>code</td><td>varchar</td><td>Артикул товара</td><td>NOT NULL, UNIQUE (brand_id, code)</td><td>-</td></tr>
  <tr><td>is_active</td><td>bit</td><td>Флаг активности, если флаг == False, то предложения с этим товаром не отображаются</td><td>-</td><td>TRUE</td></tr>
</table>

<table>
    <tr><th>Возможные запросы</th><th>Комментарий</th></tr>
    <tr><td>селект по id</td><td>-</td></tr>
    <tr><td>селект по is_active</td><td>Отдавать только активные товары</td></tr>
    <tr><td>селект по brand_id</td><td>Фильтрация товара по бренду</td></tr>
    <tr><td>селект по product_group_id</td><td>Фильтрация списка товаров по категории товара</td></tr>
    <tr><td>селект по title</td><td>Фильтрация списка товаров во время набора названия</td></tr>
    <tr><td>селект по code</td><td>Фильтрация списка товаров по артикулу</td></tr>
</table>

<table>
    <tr><th>Индексы</th><th>Комментарий</th></tr>
    <tr><td>по полю id</td><td>PK</td></tr>
    <tr><td>по полю brand_id</td><td>FK</td></tr>
    <tr><td>по полю product_group_id</td><td>FK</td></tr>
    <tr><td>по полю title</td><td>Индекс по названиям товаров, для быстрого поиска</td></tr>
</table>

<br/>
    
<br/>

* Таблица **Фото** - *Photo*
<table>
  <tr><th>Поле</th><th>Тип</th><th>Описание</th><th>Ограничения</th><th>Значение по умолчанию</th></tr>
  <tr><td>id</td><td>bigint (PK)</td><td>Идентификатор</td><td>NOT NULL, UNIQUE</td><td>-</td></tr>
  <tr><td>product_id</td><td>FK Product</td><td>Связь с таблицей Product</td><td>NOT NULL</td><td>-</td></tr>
  <tr><td>original</td><td>varchar</td><td>Путь до оригинального файла</td><td>NOT NULL</td><td>-</td></tr>
  <tr><td>thumbnail</td><td>varchar</td><td>Путь до файла с миниатюрой</td><td>-</td><td>-</td></tr>
  <tr><td>is_active</td><td>bit</td><td>Флаг активности, если флаг == False, то предложения с этим товаром не отображаются</td><td>-</td><td>TRUE</td></tr>
</table>

<table>
    <tr><th>Возможные запросы</th><th>Комментарий</th></tr>
    <tr><td>селект по id</td><td>-</td></tr>
    <tr><td>селект по is_active</td><td>Отдавать только активные фото</td></tr>
    <tr><td>селект по product_id</td><td>Фильтрация фото по товару</td></tr>
</table>

<table>
    <tr><th>Индексы</th><th>Комментарий</th></tr>
    <tr><td>по полю id</td><td>PK</td></tr>
    <tr><td>по полю product_id</td><td>FK</td></tr>
</table>

<br/>
    
<br/>

* Таблица **Группа характеристик** - *FeatureGroup*
<table>
  <tr><th>Поле</th><th>Тип</th><th>Описание</th><th>Ограничения</th><th>Значение по умолчанию</th></tr>
  <tr><td>id</td><td>bigint (PK)</td><td>Идентификатор</td><td>NOT NULL, UNIQUE</td><td>-</td></tr>
  <tr><td>title</td><td>varchar</td><td>Название характеристики</td><td>NOT NULL, UNIQUE</td><td>-</td></tr>
  <tr><td>is_active</td><td>bit</td><td>Флаг активности, если флаг == False, то данная характиеристка не отображается</td><td>-</td><td>TRUE</td></tr>
</table>

<table>
    <tr><th>Возможные запросы</th><th>Комментарий</th></tr>
    <tr><td>селект по id</td><td>-</td></tr>
    <tr><td>селект по is_active</td><td>Отдавать только активные группы характеристик</td></tr>
</table>

<table>
    <tr><th>Индексы</th><th>Комментарий</th></tr>
    <tr><td>по полю id</td><td>PK</td></tr>
</table>

<br/>
    
<br/>

* Таблица **Характеристики** - *Feature*
<table>
  <tr><th>Поле</th><th>Тип</th><th>Описание</th><th>Ограничения</th><th>Значение по умолчанию</th></tr>
  <tr><td>id</td><td>bigint (PK)</td><td>Идентификатор</td><td>NOT NULL, UNIQUE</td><td>-</td></tr>
  <tr><td>feature_group_id</td><td>FK FeatureGroup</td><td>Связь с таблицей FeatureGroup</td><td>NOT NULL</td><td>-</td></tr>
  <tr><td>title</td><td>varchar</td><td>Название характеристики</td><td>NOT NULL, UNIQUE (feature_group_id, title)</td><td>-</td></tr>
  <tr><td>is_active</td><td>bit</td><td>Флаг активности, если флаг == False, то данная характиеристка не отображается</td><td>-</td><td>TRUE</td></tr>
</table>

<table>
    <tr><th>Возможные запросы</th><th>Комментарий</th></tr>
    <tr><td>селект по id</td><td>-</td></tr>
    <tr><td>селект по is_active</td><td>Отдавать только активные характеристики</td></tr>
</table>

<table>
    <tr><th>Индексы</th><th>Комментарий</th></tr>
    <tr><td>по полю id</td><td>PK</td></tr>
    <tr><td>по полю feature_group_id</td><td>FK</td></tr>
</table>

<br/>
    
<br/>

* Таблица **Характеристики Продукта** - *ProductFeature*
<table>
  <tr><th>Поле</th><th>Тип</th><th>Описание</th><th>Ограничения</th><th>Значение по умолчанию</th></tr>
  <tr><td>id</td><td>bigint (PK)</td><td>Идентификатор</td><td>NOT NULL, UNIQUE</td><td>-</td></tr>
  <tr><td>product_id</td><td>FK Product</td><td>Связь с таблицей Product</td><td>NOT NULL</td><td>-</td></tr>
  <tr><td>feature_id</td><td>FK Feature</td><td>Связь с таблицей Feature</td><td>NOT NULL, UNIQUE (product_id, feature_id)</td><td>-</td></tr>
</table>

<table>
    <tr><th>Возможные запросы</th><th>Комментарий</th></tr>
    <tr><td>селект по id</td><td>-</td></tr>
    <tr><td>селект по product_id</td><td>Фильтрация фото по товару</td></tr>
</table>

<table>
    <tr><th>Индексы</th><th>Комментарий</th></tr>
    <tr><td>по полю id</td><td>PK</td></tr>
    <tr><td>по полю product_id</td><td>FK</td></tr>
</table>

<br/>
    
<br/>

#### Блок таблиц "Продавец"
* Таблица **Компания** - *Company*
<table>
  <tr><th>Поле</th><th>Тип</th><th>Описание</th><th>Ограничения</th><th>Значение по умолчанию</th></tr>
  <tr><td>id</td><td>bigint (PK)</td><td>Идентификатор</td><td>NOT NULL, UNIQUE</td><td>-</td></tr>
  <tr><td>title</td><td>varchar</td><td>Название компании</td><td>NOT NULL</td><td>-</td></tr>
  <tr><td>inn</td><td>text</td><td>ИНН</td><td>NOT NULL, UNIQUE</td><td>-</td></tr>
  <tr><td>status</td><td>varchar</td><td>Статус компании: 'new', 'verified', ...</td><td>NOT NULL</td><td>-</td></tr>
  <tr><td>is_active</td><td>bit</td><td>Флаг активности, если флаг == False, то компания не активна и ее предложения не отображаются</td><td>-</td><td>TRUE</td></tr>
</table>

<table>
    <tr><th>Возможные запросы</th><th>Комментарий</th></tr>
    <tr><td>селект по id</td><td>-</td></tr>
    <tr><td>селект по is_active</td><td>Отдавать только активные компании</td></tr>
    <tr><td>селект по status</td><td>Фильтрация компаний по статусу</td></tr>
</table>

<table>
    <tr><th>Индексы</th><th>Комментарий</th></tr>
    <tr><td>по полю id</td><td>PK</td></tr>
</table>

<br/>
    
<br/>

* Таблица **Магазин** - *Shop*
<table>
  <tr><th>Поле</th><th>Тип</th><th>Описание</th><th>Ограничения</th><th>Значение по умолчанию</th></tr>
  <tr><td>id</td><td>bigint (PK)</td><td>Идентификатор</td><td>NOT NULL, UNIQUE</td><td>-</td></tr>
  <tr><td>title</td><td>varchar</td><td>Название магазина</td><td>NOT NULL</td><td>-</td></tr>
  <tr><td>company_id</td><td>FK Company</td><td>Связь с таблицей Company</td><td>NOT NULL</td><td>-</td></tr>
  <tr><td>city_id</td><td>FK City</td><td>Связь с таблицей City</td><td>NOT NULL</td><td>-</td></tr>
  <tr><td>address</td><td>varchar</td><td>Адрес магазина</td><td>NOT NULL, UNIQUE (company_id, city_id, address)</td><td>-</td></tr>
  <tr><td>phone</td><td>varchar</td><td>Телефон магазина</td><td>-</td><td>-</td></tr>
  <tr><td>email</td><td>varchar</td><td>Email магазина</td><td>-</td><td>-</td></tr>
  <tr><td>is_active</td><td>bit</td><td>Флаг активности, если флаг == False, то магазин не активен и его предложения не отображаются</td><td>-</td><td>TRUE</td></tr>
</table>

<table>
    <tr><th>Возможные запросы</th><th>Комментарий</th></tr>
    <tr><td>селект по id</td><td>-</td></tr>
    <tr><td>селект по is_active</td><td>Отдавать только активные магазины</td></tr>
    <tr><td>селект по id_company</td><td>Фильтрация магазины по компании</td></tr>
    <tr><td>селект по id_city</td><td>Фильтрация магазины по городу</td></tr>
</table>

<table>
    <tr><th>Индексы</th><th>Комментарий</th></tr>
    <tr><td>по полю id</td><td>PK</td></tr>
    <tr><td>по полю company_id</td><td>FK</td></tr>
    <tr><td>по полю city_id</td><td>FK</td></tr>
</table>

<br/>
    
<br/>

* Таблица **Предложение** - *Offer*
<table>
  <tr><th>Поле</th><th>Тип</th><th>Описание</th><th>Ограничения</th><th>Значение по умолчанию</th></tr>
  <tr><td>id</td><td>bigint (PK)</td><td>Идентификатор</td><td>NOT NULL, UNIQUE</td><td>-</td></tr>
  <tr><td>shop_id</td><td>FK Shop</td><td>Связь с таблицей Shop</td><td>NOT_NULL</td><td>-</td></tr>
  <tr><td>product_id</td><td>FK Product</td><td>Связь с таблицей Product</td><td>NOT_NULL, UNIQUE (shop_id, product_id)</td><td>-</td></tr>
  <tr><td>amount</td><td>int</td><td>Кол-во в наличии</td><td>NOT NULL, CHECK( >=0 )</td><td>-</td></tr>
  <tr><td>price</td><td>decimal</td><td>Стоимость за единицу товара</td><td>NOT NULL, CHECK( >= 0.00)</td><td>-</td></tr>
  <tr><td>is_active</td><td>bit</td><td>Флаг активности, если флаг == False, то предложение не отображаются</td><td>-</td><td>TRUE</td></tr>
</table>

<table>
    <tr><th>Возможные запросы</th><th>Комментарий</th></tr>
    <tr><td>селект по id</td><td>-</td></tr>
    <tr><td>селект по is_active</td><td>Отдавать только активные магазины</td></tr>
    <tr><td>селект по id_company</td><td>Фильтрация магазины по компании</td></tr>
    <tr><td>селект по id_city</td><td>Фильтрация магазины по городу</td></tr>
</table>

<table>
    <tr><th>Индексы</th><th>Комментарий</th></tr>
    <tr><td>по полю id</td><td>PK</td></tr>
    <tr><td>по полю shop_id</td><td>FK</td></tr>
    <tr><td>по полю product_id</td><td>FK</td></tr>
    <tr><td>по полю price</td><td>Индекс по полю стоимости товара, для возможности фильтровать список по диапазону цен</td></tr>
</table>

<br/>
    
<br/>


#### Блок таблиц "Заказ"
* Таблица **Клиент** - *Client*
<table>
  <tr><th>Поле</th><th>Тип</th><th>Описание</th><th>Ограничения</th><th>Значение по умолчанию</th></tr>
  <tr><td>id</td><td>bigint (PK)</td><td>Идентификатор</td><td>NOT NULL, UNIQUE</td><td>-</td></tr>
  <tr><td>city_id</td><td>FK City</td><td>Связь с таблицей City</td><td>NOT NULL</td><td>-</td></tr>
  <tr><td>phone</td><td>varchar</td><td>Телефон</td><td>-</td><td>-</td></tr>
  <tr><td>email</td><td>varchar</td><td>Email</td><td>NOT NULL</td><td>-</td></tr>
  <tr><td>first_name</td><td>varchar</td><td>Имя</td><td>NOT NULL</td><td>-</td></tr>
  <tr><td>last_name</td><td>varchar</td><td>Фамилия</td><td>NOT NULL</td><td>-</td></tr>
  <tr><td>is_active</td><td>bit</td><td>Флаг активности, если флаг == False, то учётка клиента заблокирована</td><td>-</td><td>TRUE</td></tr>
</table>

<table>
    <tr><th>Возможные запросы</th><th>Комментарий</th></tr>
    <tr><td>селект по id</td><td>-</td></tr>
    <tr><td>селект по is_active</td><td>Отдавать только активных клиентов</td></tr>
    <tr><td>селект по city_id</td><td>Фильтрация клиентов по городу</td></tr>
</table>

<table>
    <tr><th>Индексы</th><th>Комментарий</th></tr>
    <tr><td>по полю id</td><td>PK</td></tr>
    <tr><td>по полю city_id</td><td>FK</td></tr>
</table>

<br/>
    
<br/>

* Таблица **Заказ** - *Order*
<table>
  <tr><th>Поле</th><th>Тип</th><th>Описание</th><th>Ограничения</th><th>Значение по умолчанию</th></tr>
  <tr><td>id</td><td>bigint (PK)</td><td>Идентификатор</td><td>NOT NULL, UNIQUE</td><td>-</td></tr>
  <tr><td>client_id</td><td>FK Client</td><td>Связь с таблицей Client</td><td>NOT_NULL</td><td>-</td></tr>
  <tr><td>date_create</td><td>datetime</td><td>Дата создания</td><td>NOT NULL</td><td>-</td></tr>
  <tr><td>status</td><td>varchar</td><td>Статус заказа</td><td>NOT NULL</td><td>-</td></tr>
</table>

<table>
    <tr><th>Возможные запросы</th><th>Комментарий</th></tr>
    <tr><td>селект по id</td><td>-</td></tr>
    <tr><td>селект по client_id</td><td>Фильтрация заказов по клиенту</td></tr>
    <tr><td>селект по status</td><td>Фильтрация заказов по статусу</td></tr>
    <tr><td>селект по date_create</td><td>Фильтрация заказов по дате создания</td></tr>
</table>

<table>
    <tr><th>Индексы</th><th>Комментарий</th></tr>
    <tr><td>по полю id</td><td>PK</td></tr>
    <tr><td>по полю client_id</td><td>FK</td></tr>
</table>

<br/>
    
<br/>

* Таблица **Позиция заказа** - *OrderPosition*
<table>
  <tr><th>Поле</th><th>Тип</th><th>Описание</th><th>Ограничения</th><th>Значение по умолчанию</th></tr>
  <tr><td>id</td><td>bigint (PK)</td><td>Идентификатор</td><td>NOT NULL, UNIQUE</td><td>-</td></tr>
  <tr><td>order_id</td><td>FK Order</td><td>Связь с таблицей Order</td><td>NOT NULL</td><td>-</td></tr>
  <tr><td>offer_id</td><td>FK Offer</td><td>Связь с таблицей Offer</td><td>NOT NULL, UNIQUE(order_id, offer_id)</td><td>-</td></tr>
  <tr><td>amount</td><td>int</td><td>Кол-во в заказе</td><td>NOT NULL, CHECK( >= 1)</td><td>-</td></tr>
  <tr><td>price</td><td>decimal</td><td>Стоимость за единицу товара</td><td>NOT NULL, CHECK( >= 0.00)</td><td>-</td></tr>
</table>

<table>
    <tr><th>Возможные запросы</th><th>Комментарий</th></tr>
    <tr><td>селект по id</td><td>-</td></tr>
    <tr><td>селект по order_id</td><td>Фильтрация позиций по заказу</td></tr>
</table>

<table>
    <tr><th>Индексы</th><th>Комментарий</th></tr>
    <tr><td>по полю id</td><td>PK</td></tr>
    <tr><td>по полю order_id</td><td>FK</td></tr>
    <tr><td>по полю offer_id</td><td>FK</td></tr>
</table>

<br/>
    
<br/>

* Таблица **Платеж** - *Payment*
<table>
  <tr><th>Поле</th><th>Тип</th><th>Описание</th><th>Ограничения</th><th>Значение по умолчанию</th></tr>
  <tr><td>id</td><td>bigint (PK)</td><td>Идентификатор</td><td>NOT NULL, UNIQUE</td><td>-</td></tr>
  <tr><td>order_id</td><td>FK Order</td><td>Связь с таблицей Order</td><td>NOT NULL</td><td>-</td></tr>
  <tr><td>is_refund</td><td>bit</td><td>Отмена платежа</td><td>-</td><td>FALSE</td></tr>
  <tr><td>create_date</td><td>datetime</td><td>Время создания</td><td>-</td><td>-</td></tr>
  <tr><td>bank_id</td><td>varchar</td><td>Банковский идентификатор транзакции</td><td>NOT NULL</td><td>-</td></tr>
  <tr><td>bank_comment</td><td>text</td><td>Сообщение от банка</td><td>-</td><td>-</td></tr>
</table>

<table>
    <tr><th>Возможные запросы</th><th>Комментарий</th></tr>
    <tr><td>селект по id</td><td>-</td></tr>
    <tr><td>селект по order_id</td><td>Фильтрация платежей по заказу</td></tr>
</table>

<table>
    <tr><th>Индексы</th><th>Комментарий</th></tr>
    <tr><td>по полю id</td><td>PK</td></tr>
    <tr><td>по полю order_id</td><td>FK</td></tr>
</table>

<br/>
