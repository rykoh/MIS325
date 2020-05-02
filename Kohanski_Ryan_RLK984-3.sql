-- PL/SQL, PROCS, AND FUNCS ASSIGNMENT
-- RYAN KOHANSKI, RLK984

-- PL/SQL PROBLEMS

SET SERVEROUTPUT ON;

-- Problem 1
DECLARE
    vendor_count NUMBER;
BEGIN
    SELECT COUNT(vendor_id)
    INTO vendor_count
    FROM Vendors
    WHERE vendor_state = 'CA';

    IF vendor_count > 30 THEN
        DBMS_OUTPUT.PUT_LINE('The number of vendors is greater than 30');
    ELSE
        DBMS_OUTPUT.PUT_LINE('The number of vendors is less than or equal 30');
    END IF;
END;
/

-- Problem 2
-- USE i OR ID for statement??
-- I kept getting errors trying to use bulk collect for #2, so I tried using a cursor and a for loop and that gave me the right output
DECLARE
    TYPE ids_table  IS TABLE OF Invoices.invoice_id%TYPE;
    invoice_ids     ids_table;
BEGIN
    SELECT invoice_id
    BULK COLLECT INTO invoice_ids
    FROM Invoices
    WHERE (invoice_total - credit_total - payment_total) > 0
    ORDER BY invoice_id ASC;
    
    FOR i IN 1 .. invoice_ids.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Invoice ' || invoice_ids(i) || ' is not paid');
    END LOOP;
END;
/

-- Problem 3
BEGIN
    INSERT INTO Departments VALUES(department_id_seq.NEXTVAL, 'IT Dept');
    DBMS_OUTPUT.PUT_LINE('1 row was inserted.');
    --COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Row was not inserted - duplicate entry.');
END;
/
--Used to test Problem 3
ROLLBACK;


-- PROCEDURE / FUNCTION PROBLEMS

-- Problem 4 
CREATE OR REPLACE PROCEDURE insert_department
(
    department_name_param       Departments.department_name%TYPE
)
AS
BEGIN
    INSERT INTO Departments VALUES (department_id_seq.NEXTVAL, department_name_param);
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END;
/
-- CALL Test 1
CALL insert_department('Finance');
-- CALL Test 2
CALL insert_department('Human Resources');
-- For testing Problem 4
ROLLBACK;

-- Problem 5
CREATE OR REPLACE FUNCTION phone_lookup
(
    customer_id_param   Customers_MGS.customer_id%TYPE
)
RETURN VARCHAR2
AS 
    customer_phone_var Addresses.phone%TYPE;
BEGIN
    SELECT A.phone
    INTO customer_phone_var
    FROM Addresses A JOIN Customers_MGS CMGS
    ON A.address_id = CMGS.shipping_address_id
    WHERE CMGS.customer_id = customer_id_param;
    
    RETURN customer_phone_var;
END;
/

-- Use the following SELECT statement to test this function.
SELECT first_name, last_name, email_address, phone_lookup(customer_id) 
FROM customers_mgs;







