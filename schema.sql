-- In this SQL file, write (and comment!) the schema of your database, including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it


---CREATE user table:

CREATE TABLE "user"(
    "id" INTEGER PRIMARY KEY,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "user_name" TEXT NOT NULL UNIQUE,
    "password" TEXT NOT NULL,
    "mobile number" TEXT NOT NULL UNIQUE
);

---CREATE menu table  :
CREATE TABLE "menu"(
    "id" INTEGER PRIMARY KEY,
    "item" TEXT NOT NULL UNIQUE,
    "price" INTEGER NOT NULL,
    "ingrediants" TEXT
);

---CREATE order  table  :
CREATE TABLE "order"(
    "id" INTEGER PRIMARY KEY,
    "address" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "price" INTEGER NOT NULL,
    "payment" TEXT NOT NULL
);

---CREATE  order_user_connection table :
CREATE TABLE "order_user_connection"(
    "user_id" INTEGER,
    "order_id" INTEGER,
    FOREIGN KEY ("user_id") REFERENCES "user"("id"),
    FOREIGN KEY ("order_id") REFERENCES "order"("id"),
    PRIMARY KEY ("user_id", "order_id")
);

---CREATE  rating table :
CREATE TABLE "rating"(
    "id" INTEGER PRIMARY KEY,
    "rating" INTEGER NOT NULL
);
---create table order rating
CREATE TABLE "order_rating"(
    "order_id" INTEGER,
    "rating_id" INTEGER,
    FOREIGN KEY ("order_id") REFERENCES "order"("id"),
    FOREIGN KEY ("rating_id") REFERENCES "rating"("id"),
    PRIMARY KEY ("order_id", "rating_id")
);

---optimization
-- Create indexes to speed common searches
CREATE INDEX "user_search" ON "user" ("first_name", "last_name");
CREATE INDEX "price_search" ON "order" ("price","name");
CREATE INDEX "rating_search" ON "rating" ("rating");

---Create view
CREATE VIEW "item_rating" AS
SELECT "order"."name", "rating"."rating"
FROM "order"
JOIN "order_rating" ON "order"."id" = "order_rating"."order_id"
JOIN "rating" ON "order_rating"."rating_id" = "rating"."id";



