-- Создадим новую схему (дефолтную дропним)
create schema mp;
drop schema public cascade;

-- Создадим табличное пространство для размещения индексов
create tablespace mp_fastspace owner superuser location '/var/lib/postgresql/data/spaces/fastspace';

-- Создадим основное табличное пространство
create tablespace mp_general owner superuser location '/var/lib/postgresql/data/spaces/general';

-- Установим табличное пространство по умолчанию для БД
-- ERROR:  cannot change the tablespace of the currently open database
-- alter database marketplace_db set tablespace mp_general;
