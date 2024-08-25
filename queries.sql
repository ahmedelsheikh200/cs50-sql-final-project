-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database
--- searching for the item highest selled
SELECT name FROM "order"
GROUP BY name
ORDER BY COUNT(name) DESC
LIMIT 1;

---select the name of the person ordered most orders and the number of his orders
SELECT "first_name" , "last_name", COUNT("user_id")as "number of orders" FROM user
JOIN "order_user_connection" ON  user.id = "order_user_connection".user_id
GROUP BY ("user_id")
ORDER BY "number of orders" DESC
LIMIT 1 ;

---select the name of the person ordered most expensive order and the price of his order
SELECT "first_name" , "last_name","order"."name" ,"price" FROM user
JOIN "order_user_connection" ON  user.id = "order_user_connection".user_id
JOIN "order" ON "order"."id" = "order_user_connection".order_id
ORDER BY "price" DESC
LIMIT 1 ;

---find all orders and its price from one customer
SELECT "order"."name" ,"price" FROM "order_user_connection"
JOIN "user" ON  user.id = "order_user_connection".user_id
JOIN "order" ON "order"."id" = "order_user_connection".order_id
WHERE "first_name" = "ahmed" and "last_name" = "hamdi" ;

--- find highest rated item and its rating
WITH ItemAvgRating AS (
    SELECT
        m."item",
        AVG(r."rating") AS avg_rating
    FROM
        "menu" m
    JOIN
        "order_rating" orr ON m."id" = orr."order_id"
    JOIN
        "rating" r ON orr."rating_id" = r."id"
    GROUP BY
        m."item"
)
SELECT "item",MAX(avg_rating) AS highest_avg_rating
FROM ItemAvgRating
GROUP BY "item";

---insert values to user
INSERT INTO "menu"("id", "first_name", "last_name","user_name","password","mobile number")
VALUES(1,"eid","said","eido","#############","01015189570")


---insert values to menu
INSERT INTO "menu"("id", "item", "price")
VALUES
  (1, "pizza", 87),
  (2, "crepe", 85),
  (3, "chicken", 100),
  (4, "fish", 120);

  ---delete first column from order_user_connectio
  DELETE FROM order_user_connectio where order_id = 1 ;

  ---update user's name in user table
 UPDATE "user"
SET "user_name" = 'hasona'
WHERE "id" = 1;


