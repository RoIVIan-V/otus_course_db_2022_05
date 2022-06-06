## Документация к БД
___

**[➤ Перейти к Схеме БД ](https://github.com/RoIVIan-V/otus_course_db_2022_05/blob/main/01/schema.md)**

### Таблицы:

#### Блок таблиц "Город"


* Таблица **Страна** - *Country*
<table>
  <tr><th>Поле</th><th>Тип</th><th>Описание</th></tr>
  <tr><td>id</td><td>bigint (PK)</td><td>Идентификатор</td></tr>
  <tr><td>title</td><td>varchar</td><td>Название страны</td></tr>
  <tr><td>is_active</td><td>bit</td><td>Флаг активности, если флаг == False, то страна не активна и все магазины и предложения из этой страны не отображаются</td></tr>
</table>

<br/>

* Таблица **Город** - *City*
<table>
  <tr><th>Поле</th><th>Тип</th><th>Описание</th></tr>
  <tr><td>id</td><td>bigint (PK)</td><td>Идентификатор</td></tr>
  <tr><td>country_id</td><td>FK Country</td><td>Связь с таблицей Country</td></tr>
  <tr><td>title</td><td>varchar</td><td>Название города</td></tr>
  <tr><td>timezone</td><td>varchar</td><td>Часовой пояс</td></tr>
  <tr><td>is_active</td><td>bit</td><td>Флаг активности, если флаг == False, то город не активен и все магазины и предложения из этого города не отображаются</td></tr>
</table>

<br/>

#### Блок таблиц "Товар"
* Таблица **Производитель** - *Brand*
<table>
  <tr><th>Поле</th><th>Тип</th><th>Описание</th></tr>
  <tr><td>id</td><td>bigint (PK)</td><td>Идентификатор</td></tr>
  <tr><td>title</td><td>varchar</td><td>Название бренда</td></tr>
  <tr><td>country_id</td><td>FK Country</td><td>Связь с таблицей Country</td></tr>
  <tr><td>is_active</td><td>bit</td><td>Флаг активности, если флаг == False, то производитель не активен и предложения с его товарами не отображаются</td></tr>
</table>
    
<br/>

* Таблица **Группа товаров** - *ProductGroup*
<table>
  <tr><th>Поле</th><th>Тип</th><th>Описание</th></tr>
  <tr><td>id</td><td>bigint (PK)</td><td>Идентификатор</td></tr>
  <tr><td>title</td><td>varchar</td><td>Название группы товаров</td></tr>
  <tr><td>is_active</td><td>bit</td><td>Флаг активности, если флаг == False, то товары в этой группе не активны и предложения с этими товарами не отображаются</td></tr>
</table>

<br/>

* Таблица **Товар** - *Product*
<table>
  <tr><th>Поле</th><th>Тип</th><th>Описание</th></tr>
  <tr><td>id</td><td>bigint (PK)</td><td>Идентификатор</td></tr>
  <tr><td>title</td><td>varchar</td><td>Название товара</td></tr>
  <tr><td>description</td><td>text</td><td>Название товара</td></tr>
  <tr><td>code</td><td>varchar</td><td>Артикул товара</td></tr>
  <tr><td>brand_id</td><td>FK Brand</td><td>Связь с таблицей Brand</td></tr>
  <tr><td>product_group_id</td><td>FK ProductGroup</td><td>Связь с таблицей ProductGroup</td></tr>
  <tr><td>is_active</td><td>bit</td><td>Флаг активности, если флаг == False, то предложения с этим товаром не отображаются</td></tr>
</table>
    
<br/>

* Таблица **Фото** - *Photo*
<table>
  <tr><th>Поле</th><th>Тип</th><th>Описание</th></tr>
  <tr><td>id</td><td>bigint (PK)</td><td>Идентификатор</td></tr>
  <tr><td>product_id</td><td>FK Product</td><td>Связь с таблицей Product</td></tr>
  <tr><td>original</td><td>varchar</td><td>Путь до оригинального файла</td></tr>
  <tr><td>thumbnail</td><td>varchar</td><td>Путь до файла с миниатюрой</td></tr>
  <tr><td>is_active</td><td>bit</td><td>Флаг активности, если флаг == False, то предложения с этим товаром не отображаются</td></tr>
</table>
    
<br/>

* Таблица **Группа характеристик** - *FeatureGroup*
<table>
  <tr><th>Поле</th><th>Тип</th><th>Описание</th></tr>
  <tr><td>id</td><td>bigint (PK)</td><td>Идентификатор</td></tr>
  <tr><td>feature_group_id</td><td>FK FeatureGroup</td><td>Связь с таблицей FeatureGroup</td></tr>
  <tr><td>title</td><td>varchar</td><td>Название характеристики</td></tr>
  <tr><td>is_active</td><td>bit</td><td>Флаг активности, если флаг == False, то данная характиеристка не отображается</td></tr>
</table>
    
<br/>

* Таблица **Характеристики** - *Feature*
<table>
  <tr><th>Поле</th><th>Тип</th><th>Описание</th></tr>
  <tr><td>id</td><td>bigint (PK)</td><td>Идентификатор</td></tr>
  <tr><td>feature_group_id</td><td>FK FeatureGroup</td><td>Связь с таблицей FeatureGroup</td></tr>
  <tr><td>title</td><td>varchar</td><td>Название характеристики</td></tr>
  <tr><td>is_active</td><td>bit</td><td>Флаг активности, если флаг == False, то данная характиеристка не отображается</td></tr>
</table>
    
<br/>

* Таблица **Характеристики Продукта** - *ProductFeature*
<table>
  <tr><th>Поле</th><th>Тип</th><th>Описание</th></tr>
  <tr><td>id</td><td>bigint (PK)</td><td>Идентификатор</td></tr>
  <tr><td>product_id</td><td>FK Product</td><td>Связь с таблицей Product</td></tr>
  <tr><td>feature_id</td><td>FK Feature</td><td>Связь с таблицей Feature</td></tr>
</table>
    
<br/>

#### Блок таблиц "Продавец"
* Таблица **Компания** - *Company*
<table>
  <tr><th>Поле</th><th>Тип</th><th>Описание</th></tr>
  <tr><td>id</td><td>bigint (PK)</td><td>Идентификатор</td></tr>
  <tr><td>title</td><td>varchar</td><td>Название компании</td></tr>
  <tr><td>inn</td><td>text</td><td>ИНН</td></tr>
  <tr><td>status</td><td>varchar</td><td>Статус компании: 'new', 'verified', ...</td></tr>
  <tr><td>brand_id</td><td>FK Brand</td><td>Связь с таблицей Brand</td></tr>
  <tr><td>product_group_id</td><td>FK ProductGroup</td><td>Связь с таблицей ProductGroup</td></tr>
  <tr><td>is_active</td><td>bit</td><td>Флаг активности, если флаг == False, то компания не активна и ее предложения не отображаются</td></tr>
</table>
    
<br/>

* Таблица **Магазин** - *Shop*
<table>
  <tr><th>Поле</th><th>Тип</th><th>Описание</th></tr>
  <tr><td>id</td><td>bigint (PK)</td><td>Идентификатор</td></tr>
  <tr><td>title</td><td>varchar</td><td>Название магазина</td></tr>
  <tr><td>company_id</td><td>FK Company</td><td>Связь с таблицей Company</td></tr>
  <tr><td>city_id</td><td>FK City</td><td>Связь с таблицей City</td></tr>
  <tr><td>address</td><td>varchar</td><td>Адрес магазина</td></tr>
  <tr><td>phone</td><td>varchar</td><td>Телефон магазина</td></tr>
  <tr><td>email</td><td>varchar</td><td>Email магазина</td></tr>
  <tr><td>is_active</td><td>bit</td><td>Флаг активности, если флаг == False, то магазин не активен и его предложения не отображаются</td></tr>
</table>
    
<br/>

* Таблица **Предложение** - *Offer*
<table>
  <tr><th>Поле</th><th>Тип</th><th>Описание</th></tr>
  <tr><td>id</td><td>bigint (PK)</td><td>Идентификатор</td></tr>
  <tr><td>shop_id</td><td>FK Shop</td><td>Связь с таблицей Shop</td></tr>
  <tr><td>product_id</td><td>FK Product</td><td>Связь с таблицей Product</td></tr>
  <tr><td>amount</td><td>int</td><td>Кол-во в наличии</td></tr>
  <tr><td>price</td><td>decimal</td><td>Стоимость за единицу товара</td></tr>
  <tr><td>is_active</td><td>bit</td><td>Флаг активности, если флаг == False, то предложение не отображаются</td></tr>
</table>
    
<br/>


#### Блок таблиц "Заказ"
* Таблица **Клиент** - *Client*
<table>
  <tr><th>Поле</th><th>Тип</th><th>Описание</th></tr>
  <tr><td>id</td><td>bigint (PK)</td><td>Идентификатор</td></tr>
  <tr><td>city_id</td><td>FK City</td><td>Связь с таблицей City</td></tr>
  <tr><td>phone</td><td>varchar</td><td>Телефон</td></tr>
  <tr><td>email</td><td>varchar</td><td>Email</td></tr>
  <tr><td>first_name</td><td>varchar</td><td>Имя</td></tr>
  <tr><td>last_name</td><td>varchar</td><td>Фамилия</td></tr>
  <tr><td>is_active</td><td>bit</td><td>Флаг активности, если флаг == False, то учётка клиента заблокирована</td></tr>
</table>
    
<br/>

* Таблица **Заказ** - *Order*
<table>
  <tr><th>Поле</th><th>Тип</th><th>Описание</th></tr>
  <tr><td>id</td><td>bigint (PK)</td><td>Идентификатор</td></tr>
  <tr><td>client_id</td><td>FK Client</td><td>Связь с таблицей Client</td></tr>
  <tr><td>date_create</td><td>datetime</td><td>Дата создания</td></tr>
  <tr><td>status</td><td>varchar</td><td>Статус заказа</td></tr>
</table>
    
<br/>

* Таблица **Позиция заказа** - *OrderPosition*
<table>
  <tr><th>Поле</th><th>Тип</th><th>Описание</th></tr>
  <tr><td>id</td><td>bigint (PK)</td><td>Идентификатор</td></tr>
  <tr><td>order_id</td><td>FK Order</td><td>Связь с таблицей Order</td></tr>
  <tr><td>offer_id</td><td>FK Offer</td><td>Связь с таблицей Offer</td></tr>
  <tr><td>amount</td><td>int</td><td>Кол-во в заказе</td></tr>
  <tr><td>price</td><td>decimal</td><td>Стоимость за единицу товара</td></tr>
</table>
    
<br/>

* Таблица **Платеж** - *Payment*
<table>
  <tr><th>Поле</th><th>Тип</th><th>Описание</th></tr>
  <tr><td>id</td><td>bigint (PK)</td><td>Идентификатор</td></tr>
  <tr><td>order_id</td><td>FK Order</td><td>Связь с таблицей Order</td></tr>
  <tr><td>is_refund</td><td>bit</td><td>Отмена платежа</td></tr>
  <tr><td>create_date</td><td>datetime</td><td>Время создания</td></tr>
  <tr><td>bank_id</td><td>varchar</td><td>Банковский идентификатор транзакции</td></tr>
  <tr><td>bank_comment</td><td>text</td><td>Сообщение от банка</td></tr>
</table>
