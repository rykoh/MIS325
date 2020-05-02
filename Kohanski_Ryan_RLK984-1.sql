-- Summary / Subquery Assignment
-- Ryan Kohanski, RLK984


-- SUMMARY PROBLEMS:

-- Problem 1
SELECT COUNT(*) AS product_count, -- OR count(product_id)
       MIN(list_price) AS min_price,
       MAX(list_price) AS max_price
FROM Products;

-- Problem 2
SELECT customer_id, 
       COUNT(product_id) AS products_purchased, -- Not Quantity
       MAX(item_price) AS most_expensive_purchase
FROM Orders O JOIN Order_Items OI
        ON O.order_id = OI.order_id
GROUP BY customer_id;

-- Problem 3
SELECT customer_id, 
       COUNT(product_id) AS products_purchased, 
       MAX(item_price) AS most_expensive_purchase,
       ROUND(AVG(item_price), 2) AS average_price 
FROM Orders O JOIN Order_Items OI
        ON O.order_id = OI.order_id
GROUP BY customer_id
ORDER BY products_purchased DESC, most_expensive_purchase DESC;

-- Problem 4
SELECT first_name,
       last_name,
       (SUM(item_price) * quantity),
       (SUM(discount_amount) * quantity),
       (SUM(item_price - discount_amount) * quantity) AS final_revenue
FROM Customers C JOIN Orders O
        ON C.customer_id = O.customer_id
    JOIN order_items OI
        ON O.order_id = OI.order_id
GROUP BY first_name, last_name, quantity
ORDER BY final_revenue DESC;

-- Problem 5
SELECT customer_id,
       COUNT(product_id) AS product_count,
       SUM(item_price) AS total_spend
FROM Orders O JOIN Order_Items OI
        ON O.order_id = OI.order_id
GROUP BY customer_id
HAVING COUNT(O.customer_id) > 1 
ORDER BY product_count DESC, total_spend DESC;

-- Problem 6
SELECT customer_id,
       COUNT(product_id) AS product_count,
       SUM(item_price) AS total_spend
FROM Orders O JOIN Order_Items OI
        ON O.order_id = OI.order_id
WHERE item_price > 400
GROUP BY customer_id
HAVING COUNT(O.customer_id) > 1 
ORDER BY product_count DESC, total_spend DESC;

-- Problem 7
SELECT category_name,
       product_name,
       ROUND(AVG(list_price), 2)
FROM Categories C JOIN Products P
        ON C.category_id = P.category_id
WHERE P.category_id = 1 OR P.category_id = 2 
GROUP BY ROLLUP(category_name, product_name);

-- Problem 8
SELECT email_address, 
       COUNT(product_id)
FROM Customers C JOIN Orders O
        ON C.customer_id = O.customer_id
    JOIN Order_Items OI
        ON OI.order_id = O.order_id 
GROUP BY email_address
HAVING COUNT(O.customer_id) > 1; -- How to count more than one product? is ID already distinct? unique?

-- SUBQUERY PROBLEMS:

-- Problem 9
SELECT product_name
FROM Products
WHERE product_id IN 
    (SELECT product_id
     FROM Order_Items)
ORDER BY product_name;

-- Problem 10
SELECT product_name,
       list_price,
       date_added
FROM Products
WHERE list_price > (SELECT AVG(list_price)
                    FROM Products)
ORDER BY product_name;

-- Problem 11
SELECT customer_id, 
       first_name, 
       last_name,
       email_address
FROM Customers
WHERE customer_id IN (SELECT C.customer_id 
                          FROM Customers C LEFT JOIN Orders O
                                ON O.customer_id = C.customer_id
                          WHERE order_id IS NULL);

-- Problem 12
SELECT first_name, 
       last_name,
       MAX(order_total)
FROM (SELECT first_name,
             last_name,
             O.order_id,
             ((item_price - discount_amount) * quantity) AS order_total
      FROM Customers C JOIN Orders O
            ON C.customer_id = O.customer_id
        JOIN Order_Items OI
            ON O.order_id = OI.order_id
      GROUP BY first_name, last_name, O.order_id, quantity, item_price, discount_amount)
GROUP BY first_name, last_name
ORDER BY last_name;

-- Problem 13
SELECT order_id, 
       order_date, 
       ship_amount
FROM Orders
WHERE ship_amount IN (SELECT ship_amount
                      FROM Orders
                      GROUP BY ship_amount
                      HAVING COUNT(order_id) = 1)
ORDER BY order_id;

-- Problem 14
SELECT customer_id, 
       email_address, 
       MAX(order_date) -- MAX
FROM (SELECT C.customer_id, 
             email_address, 
             order_date 
      FROM Customers C JOIN Orders O
            ON C.customer_id = O.customer_id
      GROUP BY C.customer_id, email_address, order_date)
GROUP BY customer_id, email_address;


