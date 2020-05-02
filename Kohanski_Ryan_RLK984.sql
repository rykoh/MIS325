-- Select Statement Assignment
-- Ryan Kohanski
-- RLK984

-- PROBLEM 1:
SELECT customer_id, first_name, last_name, email_address
FROM Customers
ORDER BY last_name ASC;

-- PROBLEM 2:
SELECT first_name || ' ' || last_name AS customer_full_name
FROM Customers
WHERE SUBSTR(last_name, 1, 1) IN ('W', 'V', 'Z')
ORDER BY first_name ASC;

-- PROBLEM 3:
SELECT product_name, list_price, discount_percent
FROM Products
WHERE list_price > 400 AND list_price <= 1000
ORDER BY date_added DESC;

-- PROBLEM 4:
SELECT product_name, list_price, discount_percent
FROM Products
WHERE list_price BETWEEN 401 AND 1000
ORDER BY date_added DESC;

-- PROBLEM 5:
SELECT 
    product_name,
    list_price,
    discount_percent,
    ROUND (list_price * (discount_percent / 100), 2) AS discount,
    ROUND ( list_price - (list_price * (discount_percent / 100)), 2) AS final_price
FROM Products
WHERE ROWNUM <= 4
ORDER BY final_price DESC;

-- PROBLEM 6:
SELECT 
    item_id,
    item_price,
    discount_amount,
    quantity,
    quantity * item_price AS price_total,
    quantity * discount_amount AS total_discount,
    (item_price - discount_amount) * quantity AS final_total
FROM Order_Items
WHERE ((item_price - discount_amount) * quantity) > 700 -- Same as final_total calculation
ORDER BY final_total ASC;

-- PROBLEM 7:
SELECT order_id, order_date, ship_date
FROM Orders
WHERE ship_date IS NOT NULL
ORDER BY ship_date DESC;

-- PROBLEM 8:
SELECT 
    SYSDATE AS today_unformatted,
    TO_CHAR (SYSDATE, 'MM/DD/YYYY') AS today_formatted
FROM Dual;

-- PROBLEM 9:
SELECT 
    100 AS price,
    0.0825 AS tax_rate,
    100 * 0.0825 AS tax_sum,
    100 + (100 * 0.0825) AS final_total -- same as price + tax_sum
FROM Dual;

-- PROBLEM 10:
SELECT order_id, order_date, email_address
FROM Customers JOIN Orders 
ON Customers.customer_id = Orders.customer_id
ORDER BY email_address ASC, order_date DESC; 

-- PROBLEM 11:
SELECT
    first_name || ' ' || last_name AS Customer_Name,
    line1,
    city,
    state, 
    zip_code
FROM Customers JOIN Addresses 
ON Customers.customer_id = Addresses.customer_id
WHERE email_address = 'david.goldstein@hotmail.com';

-- PROBLEM 12:
SELECT first_name, last_name, line1, city, state, zip_code
FROM Customers c JOIN Addresses a
ON c.shipping_address_id = a.address_id; -- Only show shipping address

-- PROBLEM 13:
SELECT first_name, last_name, order_date, product_name, item_price, discount_amount, quantity
FROM Customers C
    JOIN Orders O
        ON C.customer_id = O.customer_id
    JOIN Order_Items OI 
        ON O.order_id = OI.order_id
    JOIN Products P
        ON OI.product_id = P.product_id
ORDER BY last_name ASC, product_name DESC;

-- PROBLEM 14:
SELECT P.product_id, OI.order_id
FROM Products P LEFT OUTER JOIN Order_Items OI
ON P.product_id = OI.product_id
WHERE OI.order_id IS NULL;
-- Hint: Use an outer join and only return rows where the order_id column contains a null value.
-- Return one row for each product that has never been ordered.

-- PROBLEM 15:
-- Use a union operator
SELECT 'High-End' AS product_tier, product_name, list_price     -- product_tier: A calculated column that contains a value of High-End, Mid-Level, or Entry-Level,
    FROM Products
    WHERE list_price > 700
UNION
SELECT 'Mid-Tier' AS product_tier, product_name, list_price     -- product_tier: A calculated column that contains a value of High-End, Mid-Level, or Entry-Level,
    FROM Products
    WHERE list_price BETWEEN 500 AND 700
UNION
SELECT 'Entry-Level' AS product_tier, product_name, list_price     -- product_tier: A calculated column that contains a value of High-End, Mid-Level, or Entry-Level,
    FROM Products
    WHERE list_price < 500
ORDER BY list_price DESC;









