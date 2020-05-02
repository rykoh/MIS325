-- ETL Assignment
-- Ryan Kohanski, RLK984

-- PROBLEM 1
-- Review the structure of the three customer tables and identify the common fields that they have. 
-- Common Fields: customer id, first name, last name, shipping address, city, state, zip, phone


-- PROBLEM 2 
-- DDL to create the customers_dw table
CREATE TABLE customers_dw
(
    customer_id         NUMBER         NOT NULL,
    first_name          VARCHAR2(30)   NOT NULL,
    last_name           VARCHAR2(30)   NOT NULL,
    shipping_address    VARCHAR2(50)   NOT NULL,
    city                VARCHAR2(20)   NOT NULL,
    state               CHAR(2)        NOT NULL,
    zip                 VARCHAR2(5)    NOT NULL,
    phone               VARCHAR2(12)   NOT NULL,       -- formatted as ###-###-####
    data_source         CHAR(3)        NOT NULL        CHECK (data_source IN ('EX', 'MGS', 'OM')),
    
    CONSTRAINT customers_dw_pk PRIMARY KEY (data_source, customer_id)
);


-- PROBLEM 3
-- DDL to create your 3 views 
-- CUSTOMERS_EX VIEW
CREATE OR REPLACE VIEW customers_ex_view AS
    SELECT 
        CAST(customer_id AS NUMBER) AS customer_id,
        CAST(customer_firstname AS VARCHAR2(30)) AS first_name,
        CAST(customer_lastname AS VARCHAR2(30)) AS last_name,
        CAST(customer_address AS VARCHAR2(50)) AS shipping_address,
        CAST(customer_city AS VARCHAR2(20)) AS city,
        CAST(customer_state AS CHAR(2)) AS state,
        CAST(customer_zipcode AS VARCHAR2(5)) AS zip,
        CAST(SUBSTR(customer_phonenum, 2, 3) || '-' || SUBSTR(customer_phonenum, 7, 3) || '-' || SUBSTR(customer_phonenum, 11, 4) AS VARCHAR2(12)) AS phone,
        CAST('EX' AS VARCHAR(3)) AS data_source
    FROM customers_ex;
-- CUSTOMERS_MGS VIEW
CREATE OR REPLACE VIEW customers_mgs_view AS
    SELECT 
        CAST(CMGS.customer_id AS NUMBER) AS customer_id,
        CAST(CMGS.first_name AS VARCHAR2(30)) AS first_name,
        CAST(CMGS.last_name AS VARCHAR2(30)) AS last_name,
        CAST(NVL2(A.line2, A.line1 || ', ' || A.line2, A.line1) AS VARCHAR2(50)) AS shipping_address,
        CAST(A.city AS VARCHAR2(20)) AS city,
        CAST(A.state AS CHAR(2)) AS state,
        CAST(A.zip_code AS VARCHAR2(5)) AS zip,
        CAST(A.phone AS VARCHAR(12)) AS phone,
        CAST('MGS' AS VARCHAR(3)) AS data_source
    FROM customers_mgs CMGS JOIN Addresses A
    ON CMGS.shipping_address_id = A.address_id;
-- CUSTOMERS_OM VIEW
CREATE OR REPLACE VIEW customers_om_view AS
    SELECT
        CAST(customer_id AS NUMBER) AS customer_id,
        CAST(customer_first_name AS VARCHAR2(30)) AS first_name,
        CAST(customer_last_name AS VARCHAR2(30)) AS last_name,
        CAST(customer_address AS VARCHAR2(50)) AS shipping_address,
        CAST(customer_city AS VARCHAR2(20)) AS city,
        CAST(customer_state AS CHAR(2)) AS state,
        CAST(customer_zip AS VARCHAR(5)) AS zip,
        CAST(SUBSTR(customer_phone, 1, 3) || '-' || SUBSTR(customer_phone, 4, 3) || '-' || SUBSTR(customer_phone, 7, 4) AS VARCHAR2(12)) AS phone,
        CAST('OM' AS VARCHAR(3)) AS data_source
    FROM customers_om;


-- PROBLEM 4
-- Insert CUSTOMERS_EX
/*
INSERT INTO customers_dw (customer_id, first_name, last_name, shipping_address, city, state, zip, phone, data_source)
SELECT customer_id, first_name, last_name, shipping_address, city, state, zip, phone, data_source
FROM customers_ex_view;
*/
-- Insert CUSTOMERS_MGS
/*
INSERT INTO customers_dw (customer_id, first_name, last_name, shipping_address, city, state, zip, phone, data_source)
SELECT customer_id, first_name, last_name, shipping_address, city, state, zip, phone, data_source
FROM customers_mgs_view;
*/
-- Insert CUSTOMERS_OM
/*
INSERT INTO customers_dw (customer_id, first_name, last_name, shipping_address, city, state, zip, phone, data_source)
SELECT customer_id, first_name, last_name, shipping_address, city, state, zip, phone, data_source
FROM customers_om_view;
*/
-- ROLLBACK;


-- PROBLEM 5
-- Update 1 on customers_dw       
-- Update 2 on customers_dw
-- Update 3 on customers_dw

-- MERGE STATEMENT (for both the previous insert statement and the update statements)
-- Update the records on the customer_dw table with the latest name, address, city state, zip, or phone from the source views (Not updating ID or Source)


-- PROBLEM 6
-- Statement to create your procedure (using 3 merge statements rather than 3 inserts + 3 updates)
CREATE OR REPLACE PROCEDURE customer_etl_proc
AS
BEGIN
    MERGE INTO customers_dw cdw
        USING customers_ex_view cexv
        ON (cdw.customer_id = cexv.customer_id AND cdw.data_source = cexv.data_source)
        WHEN MATCHED THEN
            UPDATE SET
                cdw.first_name = cexv.first_name,
                cdw.last_name = cexv.Last_name,
                cdw.shipping_address = cexv.shipping_address,
                cdw.city = cexv.city,
                cdw.state = cexv.state,
                cdw.zip = cexv.zip,
                cdw.phone = cexv.phone
        WHEN NOT MATCHED THEN
            INSERT (customer_id, first_name, last_name, shipping_address, city, state, zip, phone, data_source)
            VALUES (cexv.customer_id, cexv.first_name, cexv.last_name, cexv.shipping_address, cexv.city, cexv.state, cexv.zip, cexv.phone, cexv.data_source);
    COMMIT;       
    MERGE INTO customers_dw cdw
        USING customers_mgs_view cmgsv
        ON (cdw.customer_id = cmgsv.customer_id AND cdw.data_source = cmgsv.data_source)
        WHEN MATCHED THEN
            UPDATE SET
                cdw.first_name = cmgsv.first_name,
                cdw.last_name = cmgsv.last_name,
                cdw.shipping_address = cmgsv.shipping_address,
                cdw.city = cmgsv.city,
                cdw.state = cmgsv.state,
                cdw.zip = cmgsv.zip,
                cdw.phone = cmgsv.phone
        WHEN NOT MATCHED THEN
            INSERT (customer_id, first_name, last_name, shipping_address, city, state, zip, phone, data_source)
            VALUES (cmgsv.customer_id, cmgsv.first_name, cmgsv.last_name, cmgsv.shipping_address, cmgsv.city, cmgsv.state, cmgsv.zip, cmgsv.phone, cmgsv.data_source);
    COMMIT;        
    MERGE INTO customers_dw cdw
        USING customers_om_view comv
        ON (cdw.customer_id = comv.customer_id  AND cdw.data_source = comv.data_source)
        WHEN MATCHED THEN
            UPDATE SET
                cdw.first_name = comv.first_name,
                cdw.last_name = comv.last_name,
                cdw.shipping_address = comv.shipping_address,
                cdw.city = comv.city,
                cdw.state = comv.state,
                cdw.zip = comv.zip,
                cdw.phone = comv.phone
        WHEN NOT MATCHED THEN
            INSERT (customer_id, first_name, last_name, shipping_address, city, state, zip, phone, data_source)
            VALUES (comv.customer_id, comv.first_name, comv.last_name, comv.shipping_address, comv.city, comv.state, comv.zip, comv.phone, comv.data_source);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END;
/

-- TEST
-- drop table customers_dw;
-- drop view customers_ex_view;
-- drop view customers_mgs_view;
-- drop view customers_om_view;
-- drop procedure customer_etl_proc;

/*
BEGIN
    customer_etl_proc;
    commit;
END;
/
*/