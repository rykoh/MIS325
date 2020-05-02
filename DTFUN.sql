-- Data Types & Functions Assignment
-- Ryan Kohanski, RLK984

-- Problem 1
SELECT SYSDATE,
       TO_CHAR(SYSDATE, 'MM/DD/YYYY HH:MI:SS') AS "Numbered Date", -- SS.FF2 was not working
       TRIM(TO_CHAR(SYSDATE, 'Day')) || ', ' || TRIM(TO_CHAR(SYSDATE, 'Month')) || ' ' || TRIM(TO_CHAR(SYSDATE, 'DD')) || ', ' || TO_CHAR(SYSDATE, 'Year, HH24:MI:SS') AS "Written",
       TO_CHAR(SYSDATE, 'DY, MON DD, YYYY HH24:MI') AS "Abbreviated Written",
       TO_CHAR(SYSDATE, 'HH:MI:SS A.M. MON/DD/YY') AS "Abbreviated Year",
       TRIM(TO_CHAR(SYSDATE, 'HH:MI day')) || ', ' || TRIM(TO_CHAR(SYSDATE, 'month')) || ' ' || TRIM(TO_CHAR(SYSDATE, 'dd, year')) AS "All Lowercase",
       
       TO_CHAR(SYSDATE, 'DDD') AS "Days Into the Year" -- For Fun
FROM Dual;

-- Problem 2
SELECT order_id,
       'Ordered on: ' || TO_CHAR(order_date, 'Mon-DD-YYYY') AS order_date,
       NVL2(ship_date, 'Shipped on a ' || TO_CHAR(ship_date, 'Day'), 'Not shipped yet') AS ship_date,
       TO_CHAR(tax_amount, '$999')
FROM Orders
ORDER BY order_id ASC;

-- Problem 3
SELECT UPPER(SUBSTR(first_name, 1, 1))
       || '. '
       || UPPER(last_name)
FROM Customers;

-- Problem 4
SELECT product_name,
       TO_CHAR(list_price, '$9999.99') AS list_price,
       TO_CHAR(discount_percent * 100, '99') || '%' AS discount, -- Easier way?
       ROUND(list_price * discount_percent, 2) AS discount_amount
FROM Products;

-- Problem 5
SELECT product_id,
       product_name,
       LENGTH(description) AS description_length,
       ROUND(date_added - TO_DATE('01-JAN-12'), 0) AS days_on_shelf 
FROM Products
WHERE date_added > TO_DATE('01-JAN-12');

-- Problem 6
SELECT address_id,
       SUBSTR(line1, 1, INSTR(line1, ' ') - 1) AS Num, -- Right way to do it?
       SUBSTR(line1, INSTR(line1, ' ') + 1) AS Street_Name, 
       NVL(line2, ' ') AS line2, 
       city,
       state,
       zip_code
FROM Addresses;

-- Problem 7  
SELECT DISTINCT C.first_name,
       C.last_name,
       SUBSTR(phone, 1, 3) AS local_phone, -- Are all numbers same characters?
       '###-###-' || SUBSTR(phone, 9, LENGTH(phone)) AS last_four  
FROM Customers C JOIN Addresses A
ON C.customer_id = A.customer_id;

-- Problem 8
SELECT SUBSTR(product_name, 1, INSTR(product_name, ' ')) AS Brand, --first word of the product_name field, need the -+1?
       AVG(list_price) AS Average_Price, --is the average item price of the brand.   
       CASE 
            WHEN AVG(list_price) >= 1000 THEN 'High-End'
            WHEN AVG(list_price) >= 500 AND AVG(list_price) < 1000 THEN 'Mid-Range'
            ELSE 'Low-End'
            -- OR: WHEN AVG(list_price) < 500 THEN 'Low-End'
       END AS Product_Tier 
FROM Products
GROUP BY product_name
ORDER BY Average_Price ASC;

-- Problem 9
-- Use Rank(), not DenseRank()!
SELECT product_name,
       TO_CHAR(list_price, '$9,999.99'), 
       RANK() OVER (ORDER BY list_price DESC) AS Price_Rank   
FROM Products;

-- Problem 10
SELECT *
FROM (SELECT ROW_NUMBER() OVER (ORDER BY list_price DESC) AS row_number, 
             product_name,
             TO_CHAR(list_price, '$999.99') AS list_price 
      FROM Products
      ORDER BY list_price DESC)
WHERE row_number = 7;







