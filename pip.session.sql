
-- ...# 1. Узнайте какие телефоны из Kivano стоят столько же сколько и компьютеры из Sulpak.
-- # Solution 1:
-- # SELECT kivano.price,kivano.product_name, sulpak.price, sulpak.product_name  
--     # FROM kivano,sulpak 
--         # WHERE kivano.category_id = 1 AND sulpak.category_id = 2 AND kivano.price = sulpak.price;

-- # Solution 2:
-- # SELECT kivano.price,kivano.product_name, sulpak.price, sulpak.product_name 
--     # FROM kivano INNER JOIN sulpak     
--         # ON kivano.category_id = 1 AND sulpak.category_id = 2 AND kivano.price = sulpak.price;

-- # 2. Узнайте самую последнюю модель Iphone в магазинах.
--   # query_1 = 'SELECT kivano.product_name, sulpak.product_name FROM kivano, sulpak WHERE kivano.product_name LIKE \'Iphone%\' AND sulpak.product_name LIKE \'Iphone%\''.
--   # cursor.execute(query_1)
--   # result_1 = cursor.fetchall()
--   # my_set = set()
--   # for tup in result:
--   #     my_set.add(int(tup[0].split(' ')[1]))
--   #     my_set.add(int(tup[1].split(' ')[1]))

--   # print(max(my_set))

-- # 3. Выведите на экран список всех ноутбуков из sulpak и только тех телефонов которые имеют одинаковую дату выхода с компьютером из таблицы kivano.
-- # SELECT prodused_date 
-- #   FROM produsers 
-- #   WHERE prodused_date IN (
-- #       SELECT produsers.prodused_date 
-- #       FROM sulpak INNER JOIN produsers 
-- #       ON sulpak.produser_id = produsers.produser_id 
-- #       WHERE sulpak.category_id = 2) 
-- #           AND prodused_date IN (
-- #               SELECT produsers.prodused_date 
-- #               FROM kivano INNER JOIN produsers 
-- #               ON kivano.produser_id = produsers.produser_id 
-- #               WHERE kivano.category_id = 1);

-- # 4. Выведите все китайские продукты.
-- # SELECT produser_company 
--     # FROM produsers 
--         # WHERE produser_country = 'China';

-- # 5. Напишите запрос, который выводит продукты любого магазина в порядке их добавления.
-- # Solution 1:
-- # SELECT * FROM kivano;

-- # Solution 2:
-- # SELECT * FROM sulpak;

-- # 6. Найдите товары, которые есть в kivano но нет в sulpak.
-- # SELECT * 
--     # FROM kivano 
--         # WHERE product_name 
--             # NOT IN (
--                 # SELECT product_name FROM sulpak
--                 #);

-- # 7. Найдите все товары в магазине sulpak, где компания-производитель содержит букву "m" в имени.
-- # SELECT sulpak.product_name 
-- #     FROM sulpak 
-- #         INNER JOIN produsers 
-- #             ON sulpak.produser_id = produsers.produser_id 
-- #                 WHERE produsers.produser_company LIKE '%m%';

-- # 8. Найдите товары, которые есть и в kivano u sulpak.
-- # SELECT * 
-- #     FROM kivano 
-- #         INNER JOIN sulpak 
-- #             ON kivano.product_name = sulpak.product_name;

-- # 9. Найдите китайские товары из kivano, которые в названии содержат "k". 
-- # SELECT * 
-- #     FROM kivano 
-- #         LEFT JOIN produsers 
-- #             ON kivano.produser_id = produsers.produser_id 
-- #                 WHERE produsers.produser_country = 'China' 
-- #                     AND product_name 
-- #                         LIKE '%k%';

-- # 10. Найдите самый последний добавленный товар в таблице produsers, и поменяйте компанию на Apple, и страну на kyrgyzstan.
-- # UPDATE produsers 
-- #     SET produser_company = 'Apple', produser_country = 'Kyrgyzstan' 
-- #         WHERE produser_id = (
-- #             SELECT MAX(produser_id) FROM produsers
-- #         );

-- # 11. Нужно объеденить 2 магазина по product_name и вывести на экран имя продукта и его цену из обоих магазинов, однако не факт что в обоих магазинах будут одинаковые товары, поэтому нужно joinить по полной.
-- # SELECT kivano.product_name, kivano.price, sulpak.product_name, sulpak.price 
-- #     FROM kivano 
-- #         FULL JOIN sulpak 
-- #             ON kivano.product_name = sulpak.product_name;

-- # 12. Найдите самый последний японский товар который был добавлен в produsers.
-- # SELECT * 
-- #     FROM produsers 
-- #         WHERE produser_id = (
-- #             SELECT MAX(produser_id) 
-- #                 FROM produsers 
-- #                     WHERE produser_country = 'Japan');

-- # 13. Напишите запрос, который прибавит 1000 к цене всех продуктов в sulpak.
-- # UPDATE sulpak 
--     # SET price = (sulpak.price + 1000);

-- Python (bootcamp) вечер, [31.05.21 19:14]
-- # 14. Узнать разницу между самой высокой ценой в sulpak и самой низкой ценой товар в kivano.
-- # SELECT (SELECT MAX(price) FROM sulpak) - (SELECT MIN(price) FROM kivano);

-- # 15. Выведите на экран цены самых дешёвых телефонов из обоих магазинов.
-- # SELECT (SELECT MIN(price) FROM kivano WHERE category_id = 1), (SELECT MIN(price) FROM sulpak WHERE category_id = 1);

-- # 16. Удалить все записи где есть NULL в product_name в обоих магазинах.
-- # DELETE FROM kivano 
--     # WHERE product_name = NULL;

-- # DELETE FROM sulpak 
--     # WHERE product_name = NULL;

-- # 17. Все телефоны у которых год меньше 1998 изменить на 2000 (Выполнить с помощью psycopg2).
-- # def get_ids(table):
-- #     kivano_items = f'''SELECT produsers.produser_id, produsers.prodused_date
-- #         FROM {table} 
-- #         INNER JOIN produsers 
-- #         ON {table}.produser_id = produsers.produser_id 
-- #         WHERE {table}.category_id = 1;'''

-- #     cursor.execute(kivano_items)
-- #     result = cursor.fetchall()

-- #     table_ids = set()

-- #     for item in result:
-- #         item_id = item[0]
-- #         item_date = item[1]
-- #         if int(str(item_date)[:4]) < 1998:
-- #             new_date = '2000' + str(item_date)[4:]
-- #             table_ids.add((item_id, new_date))
-- #     return table_ids


-- # kivano_ids = get_ids('kivano')

-- # for kiv in kivano_ids:
-- #     query = f'UPDATE produsers SET prodused_date = \'{kiv[1]}\' WHERE produser_id = {kiv[0]}'
-- #     cursor.execute(query)


-- # sulpak_ids = get_ids('sulpak')

-- # for sulp in sulpak_ids:
-- #     query = f'UPDATE produsers SET prodused_date = \'{sulp[1]}\' WHERE produser_id = {sulp[0]}'
-- #     cursor.execute(query)
-- # connection.commit()

-- # 18. Acer закрыл свою фабрику в Бразилии после 2012 года и переехал в Германию, у всех записей в produsers где Acer был произведен в Brazil после 2012 поставьте Germany.
-- # UPDATE produsers 
-- #     SET produser_country = 'Germany' 
-- #         WHERE produser_country = 'Brazil' 
-- #             AND prodused_date > '2012-12-31';

-- # 19. Выведите первые 16 записей без id, из kivano.
-- # SELECT category_id, producer_id, product_name, price 
--     # FROM kivano 
--         # LIMIT 15;

-- # 20. Выведите на экран все product_name которые относятся к категории laptops в kivano.
-- # SELECT DISTINCT kivano.product_name 
--     # FROM kivano 
--         # WHERE category_id = 2;

-- # 21. Найдите товары в sulpak, цена которых больше среднего на 2000 и меньше средний на 2000
-- # SELECT * 
-- #     FROM sulpak 
-- #         WHERE sulpak.price 
-- #             BETWEEN (
-- #                 SELECT (AVG(price) - 2000) 
-- #                 FROM sulpak) 
-- #             AND (
-- #                 SELECT (AVG(price) + 2000) 
-- #                 FROM sulpak);

-- # 22. Найдите product_company, чьи товары дороже среднего в kivano.
-- # SELECT producers.producer_company 
-- #     FROM producers 
-- #         INNER JOIN kivano 
-- #             ON producers.producer_id = kivano.producer_id 
-- #                 WHERE kivano.price > (
-- #                     SELECT AVG(price) 
-- #                         FROM kivano) 
-- #                             GROUP BY producers.producer_company;

-- # 23. Найдите товар который лежит посередине в таблице sulpak.
-- # SELECT COUNT(item_id) / 2 FROM sulpak;

-- # 24. Поменяйте страну на South Korea везде где страна Korea и компания Asus.
-- # UPDATE producers 
-- #     SET producer_country = 'South Korea' 
-- #         WHERE producer_country = 'Korea' 
-- #             AND producer_company = 'Asus';

-- # 25. В producers поменяйте Nokia на Microsoft везде где у компании Nokia указана страна USA.
-- # UPDATE producers 
-- #     SET producer_company = 'Microsoft' 
-- #         WHERE producer_country = 'USA' 
-- #             AND producer_company = 'Nokia';