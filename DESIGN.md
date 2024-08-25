# Design Document

By Ahmed Ali Elsheikh

Video overview: <https://youtu.be/Y7MA-e8Y0EQ>

## Scope

We own arestaurant and we decided to release a mobile application helps customers to make their orders easier , on the app they can find the  menu (items and  their price) , make the order , the way he want to pay (cash or visa) and they can rate their order from 5

The database for CS50 SQL includes all entities necessary to facilitate the process of tracking orders , making the best selled and knowing the highest rated items which help the restaurant and the customer   As such, included in the database's scope is:

* User , including basic identifying information
* Menu , including all items and their price
* Order , including the order of the client , the way of paying
* Rating, which includes the rating of the customer to the order
* Comments from instructors, including the content of the comment and the submission on which the comment was left

Out of scope are elements like riders deliver order , time taken , offeres of the restaurant .
## Functional Requirements
This database will support:
security of all customer's data
The ability for customer to know his pervious orders and ratings
knowing average rating for each item
knowing best seller items and highest rated items
we can find the person who made the most orders and its price . we can also find the most expensive order .
Note that in this iteration, the system will not support modyfing rating or knowing other people's order

## Representation
Entities are captured in SQLite tables with the following schema

### Entities

In this section you should answer the following questions:
#### User
The "user" table includes:
    "id" for the user id which is unique ,This column is PRIMARY KEY  , "first_name"for the user's first name text and should not be null , "last_name" for the user's last name text and should not be null,
    "user_name" for the user's user  name which is unique value  and used for user log in to the app ,this column is also text and  should not be null, "password" which be used in logging in text and should not be null , "mobile number" for user's mobile phone  to communicate with the customer if needed text and should not be null .
    All columns are required and hence have the `NOT NULL` constraint applied where a `PRIMARY KEY` or `FOREIGN KEY` constraint is not.

#### menu
The "menu" table includes:
   "id" unique id for each item  which is the primary key ,"item" the name of the item  text and should not be null, "price"for price of each item  ,item column is integer and not null ,
    "ingrediants" TEXT which tells the ingradiants of order if needed.

#### order
The "order" table includes:
 "id"unique id for each order  integer primary key ,
    "address" the address of the customer where we will deliver the order text and should not be null ,"name"the name of the item which customer ordered text and should not be null,
    "price" price of the order  integer and should not be null , "payment" the way that the customer will pay (cash or visa) text and not null.

#### order_user_connection
this table makes realation between user and order and includes:
"user_id" refers to user id , FOREIGN KEY ("user_id") REFERENCES "user"("id"), "order_id" refers to id of the order FOREIGN KEY ("order_id") REFERENCES "order"("id"),
PRIMARY KEY ("user_id", "order_id")
This makes tables (user , order) easier to read and less complex .

### rating
The "rating" table includes:
   "id" unique id for rating which is primary key  , "rating" rating usergives to order which is integer and nut null between 0 and 5.

### order_rating
this table makes realation between rating  and order and includes:
"order_id" refers to user id    FOREIGN KEY ("order_id") REFERENCES "order"("id"), "rating_id" refers to id of the order FOREIGN KEY ("rating_id") REFERENCES "rating"("id").

### Relationships

The below entity relationship diagram describes the relationships among the entities in the database.

![ER Diagram](diagram.png)
As detailed by the diagram:As detailed by the diagram:
 *0 to many users  is capable to read the menu . 0, if no one uses the app , and many if many users read it  . the user read only 1 menu.

 *One user  is capable of making 0 to many orders . 0, if they have yet to make any order , and many if they made more than one order  . An order  is made by one user .

 *One user  is capable of making 0 to many rating . 0, if they have yet to make any rating , and many if they made more than one rating  . A rating   is made by one user.

## Optimizations
Per the typical queries in "queries.sql`" it is common for users of the database to access all price for any particular item. For that reason, indexes are created on the "price" and "name" for order table to speed the identification of price and name  by these columns.
.
it is also common to search on customer's data so we created index on  "first_name" and "last_name" on user table to speed the identification ofuser name  by those columns.
.
Similarly, it is also common practice for a user of the database to concerned rating of orders so we created index on rating  to speed the identification of rating by those columns.
.

## Limitations

The current schema assumes individual submissions. Collaborative submissions would require a shift to a relationship between users  and order , orders and rating .
The use of foreign key constraints ensures referential integrity, helping to maintain consistency in the relationships between tables.
he creation of indexes on relevant columns, such as "user_search," "price_search," and "rating_search," can enhance query performance, especially for common search operations.

The schema separates different entities into distinct tables (e.g., "user," "menu," "order," and "rating"), which aligns with the principle of separation of concerns and makes the database more modular.
The schema can be extended easily to accommodate additional features or data requirements without major structural changes.
The creation of the "item_rating" view demonstrates the capability to generate virtual tables, allowing for more convenient querying and reporting without altering the underlying structure.
