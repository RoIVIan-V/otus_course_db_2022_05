## Тема: DDL скрипты для postgres

### Задача

Реализовать спроектированную схему в postgres

Используя операторы DDL создайте схемы:
* Базу данных
* Табличные пространства и роли
* Схему данных
* Таблицы своего проекта, распределив их по схемам и табличным пространствам

___
### Решение

Создадим сценарии, которые при старте контейнера будет создавать нужные сущности. 
Все сценарии находятся в директории [./initdb](https://github.com/RoIVIan-V/otus_course_db_2022_05/blob/main/04/initdb)

1. Поскольку БД и юзер создается автоматически при старте контейнера, то команды создания БД опустим

> ЗАМЕТКА
> 
> Если, при создании роли, строка пароля уже зашифрована с применением MD5 или SCRAM, она сохраняется как есть. 
> Это позволяет пересохранять зашифрованные пароли при выгрузке/восстановлении

2. Создадим новую схему mp (public дропним)

3. Для индексов создадим отдельное табличное пространство mp_fastspace,
для остальных же сущностей создадим табличное пространство mp_general

4. Создадим несколько таблиц согласно [cхеме БД](https://github.com/RoIVIan-V/otus_course_db_2022_05/blob/main/01/schema.md). 
Справочные таблицы наполним данными

> ВНИМАНИЕ!
> 
> При старте контейнера убедитесь что вы удалили ранее созданый volume - marketplace_postgres,
> в противном случае сценарии инициализации БД будут проигнорированы
> 
> docker rm $(docker ps -a -q) && docker volume rm marketplace_postgres

___
### Что можно улучшить

* Добавить поле в таблицу Payment с суммой платежа
* Добавить таблицу для учета комиссии на товар (группу товара)
* Добавить таблицу с доставкой (тип доставки, статус, трекер)